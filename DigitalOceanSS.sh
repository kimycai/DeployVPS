#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

apt-get update
apt-get -y install curl
apt-get -y install python-pip
pip install shadowsocks

IP=$(curl -s -4 icanhazip.com)
    if [[ "$IP" = "" ]]; then
        IP=$(curl -s -4 ipinfo.io/ip)
    fi

cat >> /etc/shadowsocks.json <<-EOF
{
"server":"${IP}",
"server_port":443,
"local_port":1080,
"password":"Cym9631514404",
"timeout":300,
"method":"rc4-md5"
}
EOF

#启动SS
ssserver -c /etc/shadowsocks.json -d start
#ssserver -c /etc/shadowsocks.json -d stop

#优化SS
echo "* soft nofile 51200" >> /etc/security/limits.conf
echo "* hard nofile 51200" >> /etc/security/limits.conf
ulimit -n 51200

cat >> /etc/sysctl.conf <<-EOF
fs.file-max = 51200

net.core.rmem_max = 67108864
net.core.wmem_max = 67108864
net.core.netdev_max_backlog = 250000
net.core.somaxconn = 4096

net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_tw_recycle = 0
net.ipv4.tcp_fin_timeout = 30
net.ipv4.tcp_keepalive_time = 1200
net.ipv4.ip_local_port_range = 10000 65000
net.ipv4.tcp_max_syn_backlog = 8192
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_mem = 25600 51200 102400
net.ipv4.tcp_rmem = 4096 87380 67108864
net.ipv4.tcp_wmem = 4096 65536 67108864
net.ipv4.tcp_mtu_probing = 1
net.ipv4.tcp_congestion_control = hybla
EOF

sysctl -p

echo -e "Your main public IP is\t\033[32m$IP\033[0m"
echo -e "server_port:\t\033[32m443\033[0m"
echo -e "local_port:\t\033[32m1080\033[0m"
echo -e "password:\t\033[32mCym9631514404\033[0m"
echo -e "method:\t\033[32mrc4-md5\033[0m"
