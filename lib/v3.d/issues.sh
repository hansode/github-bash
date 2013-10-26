# -*-Shell-script-*-
#

. ${BASH_SOURCE[0]%/*}/base.sh

task_issue_list() {
  local owner=$1 repo=$2

  call_api -X GET \
   $(base_uri)/repos/${owner}/${repo}/issues
}
