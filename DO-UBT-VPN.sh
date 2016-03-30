#! /bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

#获取服务包
wget --no-check-certificate http://swupdate.openvpn.org/as/openvpn-as-2.0.25-Ubuntu14.i386.deb

#安装服务包
dpkg -i openvpn-as-2.0.25-Ubuntu14.i386.deb

#设置登录密码
passwd openvpn

#初始化配置
echo "input "DELETE" and enter"
echo "choose (1) to bind to all interfaces"
/usr/local/openvpn_as/bin/ovpn-init
