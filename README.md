# network-tool
We use ansible to automatically capture network logs from segments hosts through scripts.

## Introduction
### auto_strace 
Automatically capture tracing information for a specified process PID via the strace command.

### auto_tcpdump
Automatically capture tracing information for a specified process PID via the tcpdump command.

### network_state_collection
Collection network information.

We have collected related logs involving the network in the system.
1. Collect network status using `netstat`
2. Collect `system messages logs` related to the network in the system
3. Collect some information from the kernel buffer through `dmesg`, involving network, packet sending, packet receiving, TCP, UDP, etc.



## Attation
**Before running, you need to modify the network card, host and other parameters in the script. The script is only responsible for the overall framework. The details need to be filled in by the user.**

## Getting Start
1. Download scripts
   ```
   cd /tmp/
   wget https://github.com/MisterRaindrop/network-tool/archive/refs/heads/main.zip
   unzip main.zip
   mv network-tool-main network-tool 
   ```
2. Distribute scripts to segments hosts
   ```
   ansible -i /home/gpadmin/hostfile_segments  all -m copy -a "src=/tmp/network-tool/auto_tcpdump/auto_tcpdump.sh dest=/tmp/auto_tcpdump.sh mode=0755 owner=root group=root"
   ansible -i /home/gpadmin/hostfile_segments  all -m copy -a "src=/tmp/network-tool/auto_strace/auto_strace.sh dest=/tmp/auto_strace.sh mode=0755 owner=root group=root"
   ansible -i /home/gpadmin/hostfile_segments  all -m copy -a "src=/tmp/network-tool/network_state_collection/network_state_collection.sh dest=/tmp/network_state_collection.sh mode=0755 owner=root group=root"
   ```
3. Start Scripts
   ```
   ansible -i /home/gpadmin/hostfile_segments  all -m shell -a "/bin/bash /tmp/network_state_collection.sh start"
   ansible -i /home/gpadmin/hostfile_segments  all -m shell -a "/bin/bash /tmp/auto_strace.sh start"
   ansible -i /home/gpadmin/hostfile_segments  all -m shell -a "/bin/bash /tmp/auto_tcpdump.sh start"
   ```
4. Stop Scripts
   ```
   ansible -i /home/gpadmin/hostfile_segments  all -m shell -a "/bin/bash /tmp/auto_strace.sh stop"
   ansible -i /home/gpadmin/hostfile_segments  all -m shell -a "/bin/bash /tmp/auto_tcpdump.sh stop"
   ```
5. Clean
   ```
   ansible -i /home/gpadmin/hostfile_segments  all -m shell -a "/bin/bash /tmp/network_state_collection.sh clean"
   ansible -i /home/gpadmin/hostfile_segments  all -m shell -a "/bin/bash /tmp/auto_strace.sh clean"
   ansible -i /home/gpadmin/hostfile_segments  all -m shell -a "/bin/bash /tmp/auto_tcpdump.sh clean"
   ```
6. Check
   ```
   ansible -i /home/gpadmin/hostfile_segments  all -m shell -a 'ps -ef | grep -E "tcpdump|strace"'
   ```
7. Ls /tmp 
   ```
   ansible -i /home/gpadmin/hostfile_segments  all -m shell -a 'ls -l /tmp/test*'
   ```


   
