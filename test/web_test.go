package test

import (
	"fmt"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestWebServerResponse(t *testing.T) {
    t.Parallel()

    terraformOptions := &terraform.Options{
        // Path to the Terraform configuration files
        TerraformDir: "../",
    }

    // Ensure resources are cleaned up at the end of the test
    defer terraform.Destroy(t, terraformOptions)

    // Initialize and apply Terraform configuration
    terraform.InitAndApply(t, terraformOptions)

    // Fetch the public IP of the EC2 instance from Terraform outputs
    publicIp := terraform.Output(t, terraformOptions, "public_ip")
    fmt.Println("Public IP:", publicIp)

    assert.NotEmpty(t, publicIp)

    // Construct the URL to the web server
    url := "http://" + publicIp
    expectedText := "<h1>Hello from Apple</h1>"

    // Define a retryable HTTP test to ensure the server is up and running
    maxRetries := 7
    timeBetweenRetries := 10 * time.Second
    http_helper.HttpGetWithRetry(t, url, nil, 200, expectedText, maxRetries, timeBetweenRetries)
}
