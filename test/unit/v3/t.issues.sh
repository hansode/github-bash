#!/bin/bash
#
# requires:
#   bash
#

## include files

. $(cd ${BASH_SOURCE[0]%/*} && pwd)/helper_shunit2.sh

## variables

declare namespace=${BASH_SOURCE[0]##*/t.}; namespace=${namespace%%.sh}

## functions

function setUp() {
  :
}

function tearDown() {
  :
}

function test_issue_list() {
  extract_args ${namespace} issue-list
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_issue_get() {
  extract_args ${namespace} issue-list
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_issue_new() {
  extract_args ${namespace} issue-new
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_issue_update() {
  extract_args ${namespace} issue-update
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

## shunit2

. ${shunit2_file}
