#!/usr/bin/env bats

export fixtures_relative_path="${BATS_TEST_DIRNAME}/fixtures"

setup() {
  load 'node_modules/bats-support/load'
  load 'node_modules/bats-assert/load'
}

main() {
  bash "${BATS_TEST_DIRNAME}/../src/read-env-file.sh"
}

@test "empty file" {
  ENV_FILE_PATH="${fixtures_relative_path}/empty.env" \
  run main

  assert_success
  assert_output ""
}

@test "single-item file" {
  ENV_FILE_PATH="${fixtures_relative_path}/single.env" \
  run main

  assert_success
  assert_output "KEY1=string"
}

@test "multi-item file" {
  ENV_FILE_PATH="${fixtures_relative_path}/multiple.env" \
  run main

  assert_success
  assert_output "KEY1=string
KEY2=12
KEY3=2.34"
}

@test "multi-item file with blank lines between items" {
  ENV_FILE_PATH="${fixtures_relative_path}/multiple-with-blank-lines.env" \
  run main

  assert_success
  assert_output "KEY1=string
KEY2=12
KEY3=2.34"
}

@test "multi-item file and github action 'set output' output template" {
  ENV_FILE_PATH="${fixtures_relative_path}/multiple.env" \
  OUTPUT_TEMPLATE="::set-output name={{ key }}::{{ value }}" \
  run main

  assert_success
  assert_output "::set-output name=KEY1::string
::set-output name=KEY2::12
::set-output name=KEY3::2.34"
}
