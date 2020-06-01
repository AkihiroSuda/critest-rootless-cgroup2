#!/bin/bash
set -u
exec nsenter -U --preserve-credentials -n -t $(cat $XDG_RUNTIME_DIR/rootlesskit-containerd/child_pid) $(pwd)/bin/crictl -i unix://$XDG_RUNTIME_DIR/containerd/containerd.sock -r unix://$XDG_RUNTIME_DIR/containerd/containerd.sock "$@"
