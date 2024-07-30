# network-tool
network tool

We use ansible to automatically capture logs from multiple hosts through scripts

auto_strace 
Capture Gopher Meta processes based on the PID keyword

network_state_collection

Collect the current network status

auto_tcpdump
Capture tcpdump packets based on the PID keyword.


1. Distribute scripts to each segments hosts
ansible -i hostfile_segments  all -m copy -a "src=/tmp/auto_tcpdump.sh dest=/tmp/auto_tcpdump.sh mode=0755 owner=root group=root"