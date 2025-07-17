package main

import (
	"fmt"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestThings(t *testing.T) {
	ret := Goof(5)
	fmt.Println("Doot")
	assert.Equal(t, true, true)

	assert.NotNil(t, 4)
	assert.NotNil(t, ret)
	fmt.Println("more stuff")
	fmt.Println("value was ", ret)
	assert.Greater(t, ret, 30)
}

func TestMainFunction(t *testing.T) {
	main()
}

func TestMoreThings(t *testing.T) {
	fmt.Println("more doot")
	assert.Equal(t, true, true)
}
