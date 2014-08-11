# -*-Shell-script-*-
#

. ${BASH_SOURCE[0]%/*}/base.sh

task_list() {
  # https://developer.github.com/v3/issues/comments/#list-comments-on-an-issue
  local owner=$1 repo=$2 number=$3

  call_api -X GET \
   $(base_uri)/repos/${owner}/${repo}/issues/${number}
}


task_get() {
  # https://developer.github.com/v3/issues/comments/#get-a-single-comment
  local owner=$1 repo=$2 id=$3

  call_api -X GET \
   $(base_uri)/repos/${owner}/${repo}/issues/comments/${id}
}

task_new() {
  # https://developer.github.com/v3/issues/comments/#create-a-comment
  local owner=$1 repo=$2 number=$3

  call_api -X POST --data @- \
   $(base_uri)/repos/${owner}/${repo}/issues/${number}/comments <<-EOS
	{
	  "body": "${body}"
	}
	EOS
}

task_update() {
  # https://developer.github.com/v3/issues/comments/#edit-a-comment
  local owner=$1 repo=$2 id=$3

  call_api -X PATCH --data @- \
   $(base_uri)/repos/${owner}/${repo}/issues/comments/${id} <<-EOS
	{
	  "body": "${body}"
	}
	EOS
}

task_delete() {
  # https://developer.github.com/v3/issues/comments/#delete-a-comment
  local owner=$1 repo=$2 id=$3

  call_api -X DELETE \
   $(base_uri)/repos/${owner}/${repo}/issues/comments/${id}
}
