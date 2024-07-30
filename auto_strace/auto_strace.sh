#/bin/bash
arg=$1
if [ X"$arg" == "Xstart" ]; then
    echo "start strace"
    cd /tmp
    pids=$(ps aux | grep "Gopher Meta process" | grep -v grep | awk '{print $2}')
    #nohup strace -tt -e trace=network -f  -p $pids -o /tmp/test_strace.out > log 2>&1 &
    nohup strace -tt -e trace=sendto,recvfrom,poll -f -p $pids -o /tmp/test_strace.out > nohup_test_strace.log 2>&1 &
    echo "strace start successful"
fi

if [ X"$arg" == "Xstop" ]; then
    echo "stop strace"
    pids=`ps -ef | grep strace | grep -v grep | awk '{print $2}'`
    kill -15 ${pids}
    echo "stop strace successful"
fi


if [ X"$arg" == "Xclean" ]; then
    #rm -f /tmp/nohup.out
    #rm -f /tmp/test.pacp
    find /tmp/ -type f -name 'test_strace*' -exec truncate -s 0 {} +
    find /tmp/ -type f -name 'nohup_test_strace*' -exec truncate -s 0 {} +
    echo "clean all strace temp file"
fi