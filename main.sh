#!/bin/bash

set -e

if [ -n "${GITHUB_WORKSPACE}" ]; then
  cd "${GITHUB_WORKSPACE}" || exit
fi

if [[ -n ${INPUT_GITHUB_TOKEN} ]]; then
  echo "::debug::Using GitHub token"
  git config --global url."https://${INPUT_GITHUB_TOKEN}:x-oauth-basic@github.com/".insteadOf "https://github.com/"
fi

CONFIG_FILE_OPTION="-x"

if [[ -n ${INPUT_REPORT_FILE} ]]; then
  echo "::debug::Using report file ${INPUT_REPORT_FILE}"
  CONFIG_FILE_OPTION="--output ${INPUT_REPORT_FILE}"
fi

if [[ -n ${INPUT_REPORT_FORMAT} ]]; then
  echo "::debug::Using report format ${INPUT_REPORT_FORMAT}"
  CONFIG_FILE_OPTION+=" --${INPUT_REPORT_FORMAT}"
fi

if [ -n "${INPUT_CONFIG_FILE}" ]; then
  echo "::debug::Using config file ${INPUT_CONFIG_FILE}"
  CONFIG_FILE_OPTION+=" --input ${INPUT_CONFIG_FILE}"
fi

if [ -n "${INPUT_GOKART_ARGS}" ]; then
  echo "::debug::Using specified args: ${INPUT_GOKART_ARGS}"
  CONFIG_FILE_OPTION+=" ${INPUT_GOKART_ARGS}"
fi


# shellcheck disable=SC2086
gokart scan "${INPUT_WORKING_DIRECTORY}" ${CONFIG_FILE_OPTION}

gokart_return="${PIPESTATUS[0]}"

echo "go-kart-return-code=${gokart_return}" >> "$GITHUB_OUTPUT"
