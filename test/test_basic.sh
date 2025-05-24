#!/bin/bash
# Simple test suite for HistoriX core modules

set -e

# Test shell and history detection
bash ../bin/historiX.sh --help
bash ../bin/historiX.sh --features

# Test menu (non-interactive, just to check for errors)
echo 9 | bash ../bin/historiX.sh

echo "All basic tests passed."
