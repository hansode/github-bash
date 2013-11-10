# -*-Shell-script-*-
#

. ${BASH_SOURCE[0]%/*}/base.sh

task_issue_list() {
  # http://developer.github.com/v3/issues/#list-issues
  local owner=$1 repo=$2

  call_api -X GET \
   $(base_uri)/repos/${owner}/${repo}/issues?state=${state:-open}
}
