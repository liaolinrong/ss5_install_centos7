yum install gcc openldap-devel pam-devel openssl-devel -y
tar -vzx -f ss5-3.8.9-8.tar.gz
cd ss5-3.8.9/
./configure
make
make install
chmod a+x /etc/init.d/ss5

sed -i "s~#auth    0.0.0.0/0~auth    0.0.0.0/0~g" /etc/opt/ss5/ss5.conf
sed -i "s~#permit -~permit -~g" /etc/opt/ss5/ss5.conf

sed -i '/OS=`uname -s`/iexport SS5_SOCKS_PORT=10887' /etc/init.d/ss5

systemctl daemon-reload
service ss5 restart
/sbin/chkconfig ss5 on

iptables -I INPUT -p tcp --dport 10887 -j ACCEPT
service iptables save

