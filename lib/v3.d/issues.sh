# -*-Shell-script-*-
#

. ${BASH_SOURCE[0]%/*}/base.sh

task_issue_list() {
  # http://developer.github.com/v3/issues/#list-issues
  local owner=$1 repo=$2

  call_api -X GET \
   $(base_uri)/repos/${owner}/${repo}/issues?$(query_string \
    $(add_param milestone string optional) \
    $(add_param state     string optional) \
    $(add_param assignee  string optional) \
    $(add_param creator   string optional) \
    $(add_param mentioned string optional) \
    $(add_param labels    string optional) \
    $(add_param sortsort  string optional) \
    $(add_param direction string optional) \
    $(add_param since     string optional) \
  )
}


task_issue_get() {
  # http://developer.github.com/v3/issues/#get-a-single-issue
  local owner=$1 repo=$2 number=$3

  call_api -X GET \
   $(base_uri)/repos/${owner}/${repo}/issues/${number}
}
