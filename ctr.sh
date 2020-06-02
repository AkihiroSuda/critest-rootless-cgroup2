#!/bin/bash
set -u
# e.g.: ctr run -t --rm --runc-systemd-cgroup --cgroup "user.slice:foo:deadbeef" docker.io/library/alpine:latest foo
exec nsenter -U --preserve-credentials -n -m -t $(cat $XDG_RUNTIME_DIR/rootlesskit-containerd/child_pid) $(pwd)/bin/ctr -a $XDG_RUNTIME_DIR/containerd/containerd.sock "$@"
