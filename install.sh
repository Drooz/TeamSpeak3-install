yum update -y
yum install nano wget perl tar net-tools bzip2 -y



adduser teamspeak

passwd teamspeak



wget http://dl.4players.de/ts/releases/3.0.12.4/teamspeak3-server_linux_amd64-3.0.12.4.tar.bz2
tar xvf teamspeak3-server_linux_amd64-3.0.12.4.tar.bz2
cd teamspeak3-server_linux_amd64
cp * -R /home/teamspeak
cd ..
rm -rf teamspeak3-server_linux_amd64*
chown -R teamspeak:teamspeak /home/teamspeak


nano /lib/systemd/system/teamspeak.service


[Unit]
Description=Team Speak 3 Server
After=network.target
[Service]
WorkingDirectory=/home/teamspeak/
User=teamspeak
Group=teamspeak
Type=forking
ExecStart=/home/teamspeak/ts3server_startscript.sh start inifile=ts3server.ini
ExecStop=/home/teamspeak/ts3server_startscript.sh stop
PIDFile=/home/teamspeak/ts3server.pid
RestartSec=15
Restart=always
[Install]
WantedBy=multi-user.target



systemctl --system daemon-reload
systemctl start teamspeak.service
systemctl enable teamspeak.service

systemctl status teamspeak.service

firewall-cmd --zone=public --add-port=9987/udp --permanent
firewall-cmd --zone=public --add-port=10011/tcp --permanent
firewall-cmd --zone=public --add-port=30033/tcp --permanent
firewall-cmd --reload



cat /home/teamspeak/logs/ts3server_*
