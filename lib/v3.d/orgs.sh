# -*-Shell-script-*-
#

. ${BASH_SOURCE[0]%/*}/base.sh

task_user_list() {
  # http://developer.github.com/v3/orgs/#list-user-organizations
  local user=$1

  call_api -X GET \
   $(base_uri)/users/${user}/orgs
}

task_org_list() {
  # http://developer.github.com/v3/orgs/#list-user-organizations

  call_api -X GET \
   $(base_uri)/user/orgs
}

task_get() {
  # http://developer.github.com/v3/orgs/#get-an-organization
  local org=$1

  call_api -X GET \
   $(base_uri)/orgs/${org}
}

task_update() {
  # http://developer.github.com/v3/orgs/#edit-an-organization
  local org=$1

  call_api -X PATCH --data @- \
   $(base_uri)/orgs/${org} <<-EOS
	{
	"billing_email": "${billing_email}",
	"company": "${company}",
	"email": "${email}",
	"location": "${location}",
	"name": "${name}"
	}
	EOS
}
