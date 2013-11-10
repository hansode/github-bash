# -*-Shell-script-*-
#

. ${BASH_SOURCE[0]%/*}/base.sh

task_list() {
  # http://developer.github.com/v3/activity/notifications/#list-your-notifications

  call_api -X GET \
   $(base_uri)/notifications?$(query_string \
    $(add_param all           string optional) \
    $(add_param participating string optional) \
    $(add_param since         string optional) \
  )
}

task_repo_list() {
  # http://developer.github.com/v3/activity/notifications/#list-your-notifications-in-a-repository
  local owner=$1 repo=$2

  call_api -X GET \
   $(base_uri)/repos/${owner}/${repo}/notifications?$(query_string \
    $(add_param all           string optional) \
    $(add_param participating string optional) \
    $(add_param since         string optional) \
  )
}

task_mark() {
  # http://developer.github.com/v3/activity/notifications/#mark-as-read

  call_api -X PUT --data @- \
   $(base_uri)/notifications <<-EOS
	{
	  "last_read_at": "${last_read_at}"
	}
	EOS
}

task_mark_repo() {
  # http://developer.github.com/v3/activity/notifications/#mark-notifications-as-read-in-a-repository
  local owner=$1 repo=$2

  call_api -X PUT --data @- \
   $(base_uri)/repos/${owner}/${repo}/notifications <<-EOS
	{
	  "last_read_at": "${last_read_at}"
	}
	EOS
}

task_get() {
  # http://developer.github.com/v3/activity/notifications/#view-a-single-thread
  local id=$1

  call_api -X GET \
   $(base_uri)/notifications/threads/${id}
}

task_mark_thread() {
  # http://developer.github.com/v3/activity/notifications/#mark-a-thread-as-read
  local id=$1

  call_api -X PATCH \
   $(base_uri)/notifications/threads/${id}
}


task_get_subscription() {
  # http://developer.github.com/v3/activity/notifications/#get-a-thread-subscription
  local id=$1

  call_api -X GET \
   $(base_uri)/notifications/threads/${id}/subscription
}

task_set_subscription() {
  # http://developer.github.com/v3/activity/notifications/#set-a-thread-subscription
  local id=$1

  call_api -X PUT --data @- \
   $(base_uri)/notifications/threads/${id}/subscription <<-EOS
	{
	  "subscribed": "${subscribed}",
	  "ignored": "${ignored}"
	}
	EOS
}

task_delete_subscription() {
  # http://developer.github.com/v3/activity/notifications/#delete-a-thread-subscription
  local id=$1

  call_api -X DELETE \
   $(base_uri)/notifications/threads/${id}/subscription
}
