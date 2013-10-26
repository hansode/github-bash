# -*-Shell-script-*-
#
#
#

GITHUB_PROMPT='$'
GITHUB_ARGS=
GITHUB_FRONTEND=${GITHUB_FRONTEND:-noninteractive} # [ interactive | noninteractive ]

function extract_args() {
  GITHUB_ARGS=
  local arg= key= value= key_prefix=
  while [[ $# != 0 ]]; do
    arg="$1" key= value=
    case "${arg}" in
    --*=*)
      key=${arg%%=*}; key=${key##--}; key=${key//-/_}
      ;;
    --*)
      key=${arg##--}; key=${key//-/_}
      case "$2" in
      --*|"")
        eval "${key}=1"
        ;;
      *)
        value="\${${key}} $2"
        eval "${key}=\"${value}\""; value="\${${key}}"; value=$(eval echo ${value}); eval "${key}=\"${value## }\""
        shift
        ;;
      esac
      ;;
    *)
      GITHUB_ARGS="${GITHUB_ARGS} ${arg}"
      ;;
    esac
    shift
  done
  # trim
  GITHUB_ARGS=${GITHUB_ARGS%% }
  GITHUB_ARGS=${GITHUB_ARGS## }
}

function shlog() {
  GITHUB_LOGLEVEL=$(echo ${GITHUB_LOGLEVEL:-info} | tr A-Z a-z)
  GITHUB_DRY_RUN=$(echo ${GITHUB_DRY_RUN:-} | tr A-Z a-z)

  case "${GITHUB_LOGLEVEL}" in
  debug)
    echo "${GITHUB_PROMPT} $@"
    ;;
  *)
    ;;
  esac

  case "${GITHUB_DRY_RUN}" in
  y|yes|on|1)
    :
   ;;
  *)
    eval $@
    ;;
  esac
}

function curl_opts() {
  echo -fsSkL $(request_header)
}

function request_header() {
  if [[ -n "${GITHUB_TOKEN}" ]]; then
    echo -H "\"Authorization: token ${GITHUB_TOKEN}\""
  fi
}

function request_param() {
  echo $@
}

function base_uri() {
  echo ${GITHUB_BASE_URI}
}

## cmd_*

function call_api() {
  shlog curl $(curl_opts) $(request_param $@)
}

## tasklet

function invoke_task() {
  local namespace=$1 cmd=${2//-/_}
  [[ -n "${namespace}" ]] || { echo "[ERROR] 'namespace' is empty (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }
  [[ -n "${cmd}"       ]] || { echo "[ERROR] 'cmd' is empty (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  declare -f task_${cmd} >/dev/null || { echo "[ERROR] undefined task: 'task_${cmd}' (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }
  shift; shift
  eval task_${cmd} $@
}

task_help() {
  cmd_help ${namespace} "$(echo $(declare -f | egrep ^task_ | egrep -v 'task_help|task_default' | sed 's,^task_,,; s,(,,; s,),,;') | sort | sed 's, ,|,g')"
}

## controller

function run_cmd() {
  local namespace=$1 cmd=$2
  [[ -n "${namespace}" ]] || { echo "[ERROR] 'namespace' is empty (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }
  [[ -n "${cmd}"       ]] || { echo "[ERROR] 'cmd' is empty (${BASH_SOURCE[0]##*/}:${LINENO})" >&2; return 1; }

  local namespace_path=${BASH_SOURCE[0]%/*}/v${GITHUB_API_VERSION}.d/${namespace}.sh
  [[ -f "${namespace_path}" ]] || {
    echo "[ERROR] no such namespace '${namespace}'" >&2
    return 1
  }

  . ${namespace_path}
  invoke_task $@
}

function load_githubrc() {
  GITHUB_RC=${GITHUB_RC:-${HOME}/.githubrc}
  if [[ -f "${GITHUB_RC}" ]]; then
    . ${GITHUB_RC}
  fi
}
