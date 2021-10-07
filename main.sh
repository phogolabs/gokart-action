#!/bin/bash

set -e

if [ -n "${GITHUB_WORKSPACE}" ]; then
  cd "${GITHUB_WORKSPACE}" || exit
fi

export INPUT COMMAND
export INPUT_PARAM

if [[ -n ${INPUT_GITHUB_TOKEN} ]]; then
	git config --global url."https://${INPUT_GITHUB_TOKEN}:x-oauth-basic@github.com/".insteadOf "https://github.com/"
fi

if [[ -n ${INPUT_DEBUG} ]]; then
	INPUT_PARAM+=" -d"
fi

if [[ -n ${INPUT_VERBOSE} ]]; then
	INPUT_PARAM+=" -v"
fi

if [[ -n ${INPUT_GLOBALSTAINTED} ]]; then
	INPUT_PARAM+=" -g"
fi

if [[ -n ${INPUT_REMOTEMODULE} ]]; then
	INPUT_PARAM+=" -r ${INPUT_REMOTEMODULE}"
fi

if [[ -n ${INPUT_CONFIG} ]]; then
	INPUT_PARAM+=" -i ${INPUT_CONFIG}"
fi

if [[ -n ${INPUT_OUTPUT} ]]; then
	INPUT_PARAM+=" -s -i ${INPUT_OUTPUT}"
fi

INPUT_DIRECTORY=${INPUT_DIRECTORY:-$PWD}

# format the command according to the provided arguments
INPUT_COMMAND="gokart scan ${INPUT_DIRECTORY} -x ${INPUT_PARAM}"

# evaluate the command
eval "${INPUT_COMMAND}"
