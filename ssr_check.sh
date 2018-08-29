#ssr_check.sh
#!/bin/sh
#检查ssr服务是否在运行
/etc/init.d/shadowsocks-r status
/etc/init.d/shadowsocks-r status|grep 'is running' |grep -v grep
if [ $? -ne 0 ]
then
echo "shadowsocks-r  服务未启动 , 开始启动 shadowsocks-r服务 "
sudo /etc/init.d/shadowsocks-r restart
else
echo "shadowsocks-r  正在运行..."
fi
#####
