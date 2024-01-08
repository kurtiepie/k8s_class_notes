# Linux Capabilities with Containers and Kubernetes 

## Intro

Linux Capabilities allow nonroot users to execute privileged commands without being provided full root permissions. Capabilities are a way for running processes with some privileges without having the need to grant them root privileges.

Capabilities assign access in chunks of SYSCALLS allowed in a process/container 

## Docker Example

Build or test image
- make build


by default this image will run as root and thus have a root capabilities set. CAP_SYS_ADMIN is essitialy root level privilages.
```sh
$ docker run --rm getcaps
Capabilities for `1': = cap_chown,cap_dac_override,cap_fowner,cap_fsetid,cap_kill,cap_setgid,cap_setuid,cap_setpcap,cap_net_bind_service,cap_net_raw,cap_sys_chroot,cap_mknod,cap_audit_write,cap_setfcap+ep

$ docker run -it --rm getcaps /bin/sh -c 'whoami'
root
```


Now we are going to demo how capabilities are used to harden an application. Any process or container has the ability to drop certian capabilites and add other before execution.

```sh
$ docker run --rm  --cap-drop ALL getcaps /bin/sh -c 'ping -c1 -w2 127.0.0.1'
ping: Lacking privilege for raw socket.

$ docker run --rm  --cap-drop ALL --cap-add CAP_NET_RAW getcaps /bin/sh -c 'ping -c1 -w2 127.0.0.1'
PING 127.0.0.1 (127.0.0.1): 56 data bytes
64 bytes from 127.0.0.1: icmp_seq=0 ttl=64 time=0.067 ms
--- 127.0.0.1 ping statistics ---
1 packets transmitted, 1 packets received, 0% packet loss
round-trip min/avg/max/stddev = 0.067/0.067/0.067/0.000 ms

$ docker run --rm  --cap-drop ALL --cap-add CAP_NET_RAW getcaps
Capabilities for `1': = cap_net_raw+ep

$ docker run --rm  --cap-drop ALL --cap-add CAP_NET_RAW getcaps /bin/sh -c 'capsh --print'
Current: = cap_net_raw+ep
Bounding set =cap_net_raw
Securebits: 00/0x0/1'b0
 secure-noroot: no (unlocked)
 secure-no-suid-fixup: no (unlocked)
 secure-keep-caps: no (unlocked)
uid=0(root)
gid=0(root)
groups=
```
