#!/usr/bin/env bats

@test "can list all" {
  asdf list all copier
}

@test "can install latest" {
  asdf install copier latest
}

@test "can install 9.3.1" {
  asdf install copier 9.3.1
  asdf list copier
}
