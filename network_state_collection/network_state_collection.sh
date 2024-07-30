#/bin/bash
arg=$1
if [ X"$arg" == "Xstart" ]; then
    echo "start collection"
    cd /tmp
    # collection netstat
    timestamp=$(date +"%Y%m%d_%H%M%S")
    filename="test_netstat_s_${timestamp}.log"
    netstat -s > $filename
    # collection linux log
    grep -i "error" /var/log/messages > "test_messages_error_${timestamp}.log"
    grep -i "network" /var/log/messages > "test_messages_network_${timestamp}.log"
    dmesg | grep -i "tcp" > "test_dmesg_tcp_${timestamp}.log"
    dmesg | grep -i "udp" > "test_dmesg_udp_${timestamp}.log"
    dmesg | grep -i "rx_err" > "test_dmesg_rx_err_${timestamp}.log"
    dmesg | grep -i "tx_err" > "test_dmesg_tx_err_${timestamp}.log"
    echo "collection successful"
fi


if [ X"$arg" == "Xclean" ]; then
    find /tmp/ -type f -name 'test_netstat_*' -exec truncate -s 0 {} +
    find /tmp/ -type f -name 'test_messages_*' -exec truncate -s 0 {} +
    find /tmp/ -type f -name 'test_dmesg_*' -exec truncate -s 0 {} +
    echo "clean all strace temp file"
fi