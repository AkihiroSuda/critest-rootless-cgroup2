#!/bin/bash
# Usage: run.sh [RUNTIME]
# RUNTIME: "crun" (default) or "runc"
#
set -euxp -o pipefail
RUNTIME=${1:-crun}

if [[ -n $(./crictl.sh pods -q) ]]; then
	./crictl.sh rmp -a -f
fi

id=$(./crictl.sh run --runtime=$RUNTIME container-config.json pod-config.json)

./crictl.sh exec -it $id sh
