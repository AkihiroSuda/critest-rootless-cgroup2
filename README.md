# critest-rootless-cgroup2

critest example (rootless+cgroup2)

## Usage
Boot Ubuntu 20.04 (systemd 245, kernel 5.4) with `systemd.unified_cgroup_hierarchy=1`.

Download binaries:
```console
$ ./bin-download.sh
Downloading crictl
Downloading rootlesskit
Downloading slirp4netns
Downloading containerd
NOTE: CRI-O is not supported yet
Downloading crun
NOTE: If you want to try runc, compile it by yourself and place the binary under ./bin .
```

Start containerd:
```console
$ ./containerd.sh
```

Run a pod, an Alpine container, and execute a shell within it (using crun):
```console
$ ./run.sh
...
+ ./crictl.sh exec -it d214040f8023a6938ffac05ff6db2aa0f884e86778d5f40a9a3171d2d1e8fc7c sh
/ # cat /sys/fs/cgroup/cpu.weight
5
/ # cat /sys/fs/cgroup/memory.max
67108864
```

The shell is executed in a cgroup like `/user.slice/user-1001.slice/user@1001.service/user.slice/cri-containerd-d214040f8023a6938ffac05ff6db2aa0f884e86778d5f40a9a3171d2d1e8fc7c.scope`. Note that `cat /proc/1/cgroup` in the container shows `/` as the cgroup because cgroup namespaces are enabled for non-privileged pods on cgroup v2.

To use runc (`runc` binary need to be installed under `./bin`):
```console
$ ./run.sh runc
...
```

Clean up:
```console
$ ./kill.sh
```
