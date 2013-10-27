# -*-Shell-script-*-
#

# include files

. ${BASH_SOURCE[0]%/*}/functions.sh

# variables

## System part

LANG=C
LC_ALL=C

## GITHUB part

load_githubrc

extract_args $@

GITHUB_API_VERSION=${GITHUB_API_VERSION:-3}
GITHUB_HOST=${GITHUB_HOST:-api.github.com}
GITHUB_PORT=${GITHUB_PORT:-443}
GITHUB_BASE_URI=${GITHUB_BASE_URI:-https://${GITHUB_HOST}:${GITHUB_PORT}}
