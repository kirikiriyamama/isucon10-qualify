#!/bin/bash
set -o errexit -o pipefail

export PATH=/home/isucon/local/ruby/bin:$PATH
exec "$@"
