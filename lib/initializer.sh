# -*-Shell-script-*-
#

# include files

. ${BASH_SOURCE[0]%/*}/curlet.sh

# variables

## System part

LANG=C
LC_ALL=C

## curlet part

function rc_path() {
  echo ${GITHUB_RC:-${HOME}/.githubrc}
}

function request_header() {
  if [[ -n "${auth_token}" ]]; then
    echo -H "\"Authorization: token ${auth_token}\""
  fi
}

## GITHUB part

load_rc

extract_args $@

API_VERSION=${API_VERSION:-3}
API_HOST=${API_HOST:-api.github.com}
API_PORT=${API_PORT:-443}
API_BASE_URI=${API_BASE_URI:-https://${API_HOST}:${API_PORT}}
