#/bin/bash
arg=$1
if [ X"$arg" == "Xstart" ]; then
    echo "start tcpdump"
    cd /tmp
    nohup tcpdump -i eth0 -nn -s 150 host 192.168.176.170 -vv -x  -G 60 -w test_pacp_%Y_%m%d_%H%M_%S.pcap > nohup_test_tcpdump.log 2>&1 &
    echo "tcpdump successful"
elif [ X"$arg" == "Xstop" ]; then
    echo "stop tcpdump"
    tcpdump_pid=`ps -ef | grep tcpdump | grep -v grep | awk '{print $2}'`
    kill -15 ${tcpdump_pid}
    echo "tcpdump stop successful"
elif [ X"$arg" == "Xclean" ]; then
    #rm -f /tmp/nohup.out
    #rm -f /tmp/test.pacp
    find /tmp/ -type f -name 'test_pacp_*' -exec truncate -s 0 {} +
    find /tmp/ -type f -name 'nohup_test_tcpdump*' -exec truncate -s 0 {} +
    echo "tcpdump clean successful"
else
    echo "Unknown argument: $arg"
    exit 1
fi