#!/bin/bash
set -eux -o pipefail
mkdir -p bin

: Downloading crictl
curl -sSL https://github.com/kubernetes-sigs/cri-tools/releases/download/v1.18.0/crictl-v1.18.0-linux-amd64.tar.gz | tar xzv -C bin

: Downloading rootlesskit
curl -sSL https://github.com/rootless-containers/rootlesskit/releases/download/v0.9.5/rootlesskit-x86_64.tar.gz | tar xzv -C bin

: Downloading slirp4netns
curl -o bin/slirp4netns -sSL https://github.com/rootless-containers/slirp4netns/releases/download/v1.1.0-beta.2/slirp4netns-x86_64
chmod +x bin/slirp4netns

: Downloading containerd
curl -sSL https://github.com/kind-ci/containerd-nightlies/releases/download/containerd-1.4.0-beta.1-8-g62dd1411/containerd-1.4.0-beta.1-8-g62dd1411.linux-amd64.tar.gz | tar xzv -C bin --strip-components=1 bin/containerd bin/containerd-shim-runc-v2 bin/ctr

: NOTE: CRI-O is not supported yet

: Downloading crun
curl -o bin/crun -sSL https://github.com/containers/crun/releases/download/0.13/crun-0.13-static-x86_64
chmod +x bin/crun

: NOTE: If you want to try runc, compile it by yourself and place the binary under ./bin .
