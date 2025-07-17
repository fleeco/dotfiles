package main

import (
	"fmt"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestThing(t *testing.T) {
	fmt.Println("More test thing")
	assert.Equal(t, true, true)
}
