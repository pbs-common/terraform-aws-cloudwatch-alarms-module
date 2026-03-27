package test

import (
	"testing"
)

func TestLogMetricFilterExample(t *testing.T) {
	testCloudWatchAlarm(t, "log-metric-filter")
}
