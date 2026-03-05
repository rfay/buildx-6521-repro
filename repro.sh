#!/usr/bin/env bash

set -eu -o pipefail
set -x

(for i in $(seq 1 1000); do docker-compose build --no-cache; done)

