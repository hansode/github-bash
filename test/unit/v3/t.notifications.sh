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

function test_list() {
  extract_args ${namespace} list
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_repo_list() {
  extract_args ${namespace} repo-list
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_mark() {
  extract_args ${namespace} mark
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_mark_repo() {
  extract_args ${namespace} mark-repo
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_get() {
  extract_args ${namespace} get
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_mark_thread() {
  extract_args ${namespace} mark-thread
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_get_subscription() {
  extract_args ${namespace} get-subscription
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_set_subscription() {
  extract_args ${namespace} set-subscription
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_delete_subscription() {
  extract_args ${namespace} delete-subscription
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

## shunit2

. ${shunit2_file}
