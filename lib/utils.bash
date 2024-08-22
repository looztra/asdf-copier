#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/copier-org/copier"
TOOL_NAME="copier"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

# NOTE: You might want to remove this if copier is not hosted on GitHub releases.
if [ -n "${GITHUB_API_TOKEN:-}" ]; then
  curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_github_tags() {
  git ls-remote --tags --refs "$GH_REPO" |
    grep -o 'refs/tags/.*' | cut -d/ -f3- |
    sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions() {
  list_github_tags
}

download_release() {
  # shellcheck disable=SC2034
  local version filename url
  version="$1"
  # shellcheck disable=SC2034
  filename="$2"

  #url="$GH_REPO/archive/v${version}.tar.gz"

  #echo "* Downloading $TOOL_NAME release $version..."
  #curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"
}

get_abs_filename() {
  # $1 : relative filename
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

resolve_python_path() {
  # if ASDF_PYAPP_DEFAULT_PYTHON_PATH is set, use it, else:
  # 1. try $(asdf which python)
  # 2. try $(which python3)
  if [ -n "${ASDF_PYAPP_DEFAULT_PYTHON_PATH+x}" ]; then
    echo "* ASDF_PYAPP_DEFAULT_PYTHON_PATH is set, using python at [$ASDF_PYAPP_DEFAULT_PYTHON_PATH]"
    ASDF_PYAPP_RESOLVED_PYTHON_PATH="$ASDF_PYAPP_DEFAULT_PYTHON_PATH"
    return
  fi
  local python_path

  # Borrowed to asdf-pyapp plugin
  # cd to $HOME to avoid picking up a local python from .tool-versions
  # pipx is best when install with a global python
  pushd "$HOME" >/dev/null || fail "Failed to pushd \$HOME"
  python_path=$(asdf which python3 2>/dev/null)
  if [ -z "$python_path" ]; then
    python_path=$(which python3)
    if [ -z "$python_path" ]; then
      fail "* Python3 not found in asdf or system"
    fi
    echo "* Python not found in asdf, using system python at [$python_path]"
  else
    echo "* Found python in asdf, using it at [$python_path]"
  fi
  ASDF_PYAPP_RESOLVED_PYTHON_PATH="${python_path}"
  popd >/dev/null || fail "Failed to popd"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="${3%/bin}/bin"

  if [ "${install_type}" != "version" ]; then
    fail "asdf-${TOOL_NAME} supports release installs only"
  fi

  (
    mkdir -p "$install_path"
    local venv_path uv_path python_path
    venv_path=$(get_abs_filename "$install_path/../venv")
    #
    resolve_python_path
    # Check if uv is installed
    uv_path=$(command -v uv 2>/dev/null)
    if [ -n "$uv_path" ]; then
      echo "* Found uv, using it"
      echo "* Creating virtual environment with uv"
      uv venv --quiet --prompt "asdf $TOOL_NAME venv" --python "${ASDF_PYAPP_RESOLVED_PYTHON_PATH}" "${venv_path}"
      echo "* Installing copier in virtual environment with uv"
      VIRTUAL_ENV="${venv_path}" uv pip install --quiet "copier==${version}"
    else
      echo "* uv not found, using bare venv instead"
      echo "* Creating virtual environment with venv"
      "${ASDF_PYAPP_RESOLVED_PYTHON_PATH}" -m venv --prompt "asdf $TOOL_NAME venv" "${venv_path}"
      # shellcheck disable=SC1091
      source "${venv_path}/bin/activate"
      echo "* Installing copier in virtual environment with pip"
      pip install --quiet "copier==${version}"
    fi

    # Link copier executable where asdf expects it.
    cd "${install_path}"
    ln -s "${venv_path}/bin/copier" copier

    # Assert copier executable exists.
    test -x "${install_path}/$TOOL_NAME" || fail "Expected ${install_path}/$TOOL_NAME to be executable."

    echo "* ${TOOL_NAME} ${version} installation was successful!"
    echo "* Make it local or global with:"
    echo "asdf local ${TOOL_NAME} ${version}"
    echo "asdf global ${TOOL_NAME} ${version}"
  ) || (
    rm -rf "${install_path}"
    fail "An error occurred while installing ${TOOL_NAME} ${version}."
  )
}
