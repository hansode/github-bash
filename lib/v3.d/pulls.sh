# -*-Shell-script-*-
#

. ${BASH_SOURCE[0]%/*}/base.sh

task_list() {
  local owner=$1 repo=$2

  call_api -X GET \
   $(base_uri)/repos/${owner}/${repo}/pulls
}

task_get() {
  local owner=$1 repo=$2 number=$3

  call_api -X GET \
   $(base_uri)/repos/${owner}/${repo}/pulls/${number}
}
