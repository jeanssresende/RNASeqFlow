#!/bin/bash

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ENV_NAME="rnaseqflow"

echo "Creating RNASeqFlow Conda environment..."

conda env create \
    -f "${SCRIPT_DIR}/environment.yml" \
    || conda env update \
        -f "${SCRIPT_DIR}/environment.yml" \
        --prune

echo ""
echo "RNASeqFlow environment installed successfully."