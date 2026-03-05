This build should demonstrate the problems shown in https://github.com/moby/buildkit/issues/6521

1. Extract into a temporary directory
2. cd into directory
3. (set -eu; for i in $(seq 1 1000); do docker-compose build --no-cache; done)
