# -*-Shell-script-*-
#

. ${BASH_SOURCE[0]%/*}/base.sh

task_list() {
  # http://developer.github.com/v3/activity/feeds/

  call_api -X GET \
   $(base_uri)/feeds
}
