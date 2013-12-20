# -*-Shell-script-*-
#

. ${BASH_SOURCE[0]%/*}/base.sh

# task_edit() { :; }

task_list() {
  # http://developer.github.com/v3/gists/#list-gists
  local owner=$1

  call_api -X GET \
   $(base_uri)/users/${owner}/gists
}

task_list_public() {
  # http://developer.github.com/v3/gists/#list-gists
  local owner=$1

  call_api -X GET \
   $(base_uri)/gists/public
}

task_list_starred() {
  # http://developer.github.com/v3/gists/#list-gists
  local owner=$1

  call_api -X GET \
   $(base_uri)/gists/starred
}

task_get() {
  # http://developer.github.com/v3/gists/#get-a-single-gist
  local id=$1

  call_api -X GET \
   $(base_uri)/gists/${id}
}

task_new() {
  # http://developer.github.com/v3/gists/#create-a-gist

  call_api -X POST --data @- \
   $(base_uri)/gists <<-EOS
	{
	  "description": "${description}",
	  "public": ${public:-false},
          "files": {
	    "${file##*/}": {"content": "${content:-$(sed '{:q;N;s/\n/\\n/g;t q}' ${file})}"}
	  }
	}
	EOS
}

task_set_star() {
  # http://developer.github.com/v3/gists/#star-a-gist
  local id=$1

  call_api -X PUT \
   $(base_uri)/gists/${id}/star
}

task_get_star() {
  # http://developer.github.com/v3/gists/#check-if-a-gist-is-starred
  local id=$1

  call_api -X GET \
   $(base_uri)/gists/${id}/star
}

task_set_unstar() {
  # http://developer.github.com/v3/gists/#unstar-a-gist
  local id=$1

  call_api -X DELETE \
   $(base_uri)/gists/${id}/star
}

task_fork() {
  # http://developer.github.com/v3/gists/#fork-a-gist
  local id=$1

  call_api -X POST \
   $(base_uri)/gists/${id}/forks
}

task_delete() {
  # http://developer.github.com/v3/gists/#delete-a-gist
  local id=$1

  call_api -X DELETE \
   $(base_uri)/gists/${id}
}
