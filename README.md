# network-tool
We use ansible to automatically capture network logs from segments hosts through scripts.

## Introduction
### auto_strace 
Automatically capture tracing information for a specified process PID via the strace command.

### network_state_collection
Automatically collection network information.

### auto_tcpdump
Automatically capture tracing information for a specified process PID via the tcpdump command.

## Attation
Before running, you need to modify the network card, host and other parameters in the script. The script is only responsible for the overall framework. The details need to be filled in by the user.

## Getting Start
1. Distribute scripts to segments hosts
   ```
   ansible -i hostfile_segments  all -m copy -a "src=/tmp/auto_tcpdump/auto_tcpdump.sh dest=/tmp/auto_tcpdump.sh mode=0755 owner=root group=root"
   ansible -i hostfile_segments  all -m copy -a "src=/tmp/auto_strace/auto_strace.sh dest=/tmp/auto_strace.sh mode=0755 owner=root group=root"
   ansible -i hostfile_segments  all -m copy -a "src=/tmp/network_state_collection/network_state_collection.sh dest=/tmp/network_state_collection.sh mode=0755 owner=root group=root"
   ```
2. Start Scripts
   ```
   ansible -i hostfile_segments  all -m shell -a "/bin/bash /tmp/network_state_collection.sh start"
   ansible -i hostfile_segments  all -m shell -a "/bin/bash /tmp/auto_strace.sh start"
   ansible -i hostfile_segments  all -m shell -a "/bin/bash /tmp/auto_tcpdump.sh start"
   ```
3. Stop Scripts
   ```
   ansible -i hostfile_segments  all -m shell -a "/bin/bash /tmp/auto_strace.sh stop"
   ansible -i hostfile_segments  all -m shell -a "/bin/bash /tmp/auto_tcpdump.sh stop"
   ```
4. Clean
   ```
   ansible -i hostfile_segments  all -m shell -a "/bin/bash /tmp/network_state_collection.sh clean"
   ansible -i hostfile_segments  all -m shell -a "/bin/bash /tmp/auto_strace.sh clean"
   ansible -i hostfile_segments  all -m shell -a "/bin/bash /tmp/auto_tcpdump.sh clean"
   ```
5. Check
   ```
   ansible -i hostfile_segments  all -m shell -a "ps -elf | grep -E "tcpdump|strace" | grep -v grep"
   ```



   
