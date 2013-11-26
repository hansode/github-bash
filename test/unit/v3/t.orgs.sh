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

function test_user_list() {
  extract_args ${namespace} user-list
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_org_list() {
  extract_args ${namespace} org-list
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_get() {
  extract_args ${namespace} get
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_update() {
  extract_args ${namespace} update
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

## shunit2

. ${shunit2_file}
