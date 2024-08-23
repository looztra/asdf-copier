#!/usr/bin/env bats
# shellcheck disable=SC2034
BATS_TEST_FILENAME_BASENAME=$(basename "${BATS_TEST_FILENAME}")
# bats file_tags=type:features

@test "can list all [${BATS_TEST_FILENAME_BASENAME}]" {
  asdf list all copier
}

@test "can install latest [${BATS_TEST_FILENAME_BASENAME}]" {
  asdf install copier latest
}

@test "can install 9.3.1 [${BATS_TEST_FILENAME_BASENAME}]" {
  asdf install copier 9.3.1
  asdf list copier
}
