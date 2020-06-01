#!/bin/bash
set -eux -o pipefail
BIN=$(pwd)/bin

cat <<EOF >/tmp/config.toml
root = "$HOME/.local/share/containerd"
state = "$XDG_RUNTIME_DIR/containerd"

[grpc]
  address = "$XDG_RUNTIME_DIR/containerd/containerd.sock"

[plugins]
  [plugins.cri]
    restrict_oom_score_adj = true
    disable_apparmor = true
    [plugins.cri.containerd]
      [plugins.cri.containerd.runtimes]
        [plugins.cri.containerd.runtimes.crun]
          runtime_type = "io.containerd.runc.v2"
          [plugins.cri.containerd.runtimes.crun.options]
            BinaryName = "$BIN/crun"
            SystemdCgroup = true
        [plugins.cri.containerd.runtimes.runc]
          runtime_type = "io.containerd.runc.v2"
          [plugins.cri.containerd.runtimes.runc.options]
            BinaryName = "$BIN/runc"
            SystemdCgroup = true
EOF

exec systemd-run --user -t --same-dir --unit=containerd -E PATH=$BIN:$PATH \
    $BIN/rootlesskit \
	--net=slirp4netns --disable-host-loopback \
	--copy-up=/etc --copy-up=/run --copy-up=/var/lib \
	--propagation=rslave \
	--state-dir=/run/user/1001/rootlesskit-containerd \
	sh -c "rm -rf /run/containerd /run/netns /run/xtables.lock /var/lib/cni; PATH=$BIN:$PATH containerd -c /tmp/config.toml"
