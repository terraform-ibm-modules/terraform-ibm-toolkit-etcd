#!/usr/bin/env bash

BIN_DIR=$(cat .bin_dir)

export PATH="${BIN_DIR}:${PATH}"

if ! command -v ibmcloud 1> /dev/null 2> /dev/null; then
  echo "ibmcloud cli not found" >&2
  exit 1
fi

if ! command -v jq 1> /dev/null 2> /dev/null; then
  echo "jq cli not found" >&2
  exit 1
fi

NAME=$(jq -r '.name // empty' .outputs)
ID=$(jq -r '.id // empty' .outputs)
REGION=$(jq -r '.region // empty' .outputs)
RESOURCE_GROUP_NAME=$(jq -r '.resource_group_name // empty' .outputs)

ibmcloud login -r "${REGION}" -g "${RESOURCE_GROUP_NAME}"

if ! ibmcloud resource service-instance "${NAME}"; then
  echo "Unable to find instance: ${NAME}" >&2
  exit 1
fi
