package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func testCloudWatchAlarm(t *testing.T, variant string) {
	t.Parallel()

	terraformDir := fmt.Sprintf("../examples/%s", variant)

	terraformOptions := &terraform.Options{
		TerraformDir: terraformDir,
		LockTimeout:  "5m",
		Upgrade:      true,
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	arn := terraform.Output(t, terraformOptions, "arn")
	name := terraform.Output(t, terraformOptions, "name")

	region := getAWSRegion(t)
	accountID := getAWSAccountID(t)

	expectedName := fmt.Sprintf("example-tf-cloudwatch-alarms-%s", variant)
	expectedARN := fmt.Sprintf("arn:aws:cloudwatch:%s:%s:alarm:%s", region, accountID, expectedName)

	assert.Equal(t, expectedARN, arn)
	assert.Equal(t, expectedName, name)
}
