# -*-Shell-script-*-
#

. ${BASH_SOURCE[0]%/*}/base.sh

task_list() {
  # http://developer.github.com/v3/repos/hooks/#json-http
  local owner=$1 repo=$2

  call_api -X GET \
   $(base_uri)/repos/${owner}/${repo}/hooks
}

task_get() {
  # http://developer.github.com/v3/repos/hooks/#json-http
  local owner=$1 repo=$2 id=$3

  call_api -X GET \
   $(base_uri)/repos/${owner}/${repo}/hooks/${id}
}

task_update() {
  # http://developer.github.com/v3/repos/hooks/#json-http
  local owner=$1 repo=$2 id=$3

  call_api -X PATCH --data @- \
   $(base_uri)/repos/${owner}/${repo}/hooks/${id} <<-EOS
	{
          "config": { "${config}" },
          "events": [ "${events}" ],
          "add_events": [ "${add_events}" ],
          "remove_events": [ "${remove_events}" ],
          "active": ${state}
	}
	EOS
}

task_test() {
  # http://developer.github.com/v3/repos/hooks/#json-http
  local owner=$1 repo=$2 id=$3

  call_api -X POST \
   $(base_uri)/repos/${owner}/${repo}/hooks/${id}/tests
}

task_delete() {
  # http://developer.github.com/v3/repos/hooks/#delete-a-hook
  local owner=$1 repo=$2 id=$3

  call_api -X DELETE \
   $(base_uri)/repos/${owner}/${repo}/hooks/${id}
}
