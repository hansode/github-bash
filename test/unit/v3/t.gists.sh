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
  # for "new" task
  function sed() { :; }
}

function tearDown() {
  :
}

function test_list() {
  extract_args ${namespace} list
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_list_public() {
  extract_args ${namespace} list-public
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_list_starred() {
  extract_args ${namespace} list-starred
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_get() {
  extract_args ${namespace} get
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_new() {
  extract_args ${namespace} new
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_set_star() {
  extract_args ${namespace} set-star
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_get_star() {
  extract_args ${namespace} get-star
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_set_unstar() {
  extract_args ${namespace} set-unstar
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

function test_delete() {
  extract_args ${namespace} delete
  run_cmd ${COMMAND_ARGS}
  assertEquals 0 $?
}

## shunit2

. ${shunit2_file}
