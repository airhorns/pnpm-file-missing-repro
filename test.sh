#!/usr/bin/env bash
set -euox pipefail

rm -f inner/b.js
cd outer && rm -rf node_modules && cd -

cd outer 

pnpm install

set +e
node run.js
set -e

echo "module.exports = {}" > ../inner/b.js

# breaks because no new hardlink to `b` has been set up yet
node run.js