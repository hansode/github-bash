# -*-Shell-script-*-
#

. ${BASH_SOURCE[0]%/*}/base.sh

task_list() {
  local owner=$1 repo=$2

  call_api -X GET \
   $(base_uri)/repos/${owner}/${repo}/pulls?state=${state:-open}
}

task_get() {
  local owner=$1 repo=$2 number=$3

  call_api -X GET \
   $(base_uri)/repos/${owner}/${repo}/pulls/${number}
}

task_new() {
  # http://developer.github.com/v3/pulls/#create-a-pull-request
  local owner=$1 repo=$2

  call_api -X POST --data @- \
   $(base_uri)/repos/${owner}/${repo}/pulls <<-EOS
	{
	  "title": "${title}",
	  "body": "${body}",
	  "head": "${head}",
	  "base": "${base}"
	}
	EOS
}

task_merge() {
  # http://developer.github.com/v3/pulls/#merge-a-pull-request-merge-buttontrade
  local owner=$1 repo=$2 number=$3

  call_api -X PUT --data @- \
   $(base_uri)/repos/${owner}/${repo}/pulls/${number}/merge <<-EOS
	{
	  "commit_message": "${commit_message}"
	}
	EOS
}
