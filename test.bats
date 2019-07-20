#!/usr/bin/env bats

@test "t1" {
	diff cat test/test-0.txt|dist/cli.js test/t1.txt
}

@test "t2" {
	diff cat test/test-0.txt|dist/cli.js test/t1.txt
}
