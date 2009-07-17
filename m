Message-ID: <544553.74587.qm@...1238...>
Date: Fri, 17 Jul 2009 14:27:23 +0000 (GMT)
From: Puerto Rico <tellmehow@...1237...>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1644982616-1247840843=:74587"
Subject: [Openvpn-devel] bug: client-to-client always enabled in TUN dev
	mode, whereas in TAP works as expected
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0-1644982616-1247840843=:74587
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I just found that when I'am useing TUN dev mode my VPN clients can access e=
ach other directly, even if client-to-client option missing in my server.co=
nf

and it's OK - when I'am useing TAP dev mode, the same configs just the chan=
ged tun to tap mode. so when TAP mode used and client-to-client is missing =
- users can't access each other directly

vpn server is based on Ubuntu Linux: tried versions 2.1RC11 and 2.1RC19
clients running windows XP machines

here are my configs

server.conf
mode server

dev tap
proto udp

local xxx.xxx.xxx.xxx
port 40404

server 10.200.0.0 255.255.255.0
push "redirect-gateway"
push "dhcp-option DNS 208.67.222.222"
push "dhcp-option DNS 208.67.222.220"

tls-server

dh =A0=A0=A0 /etc/openvpn/dh2048.pem
ca =A0=A0=A0 /etc/openvpn/ca.crt
cert =A0=A0=A0 /etc/openvpn/server.crt
key =A0=A0=A0 /etc/openvpn/server.key
tls-auth /etc/openvpn/ta.key 0

management localhost 7505

script-security 1

user nobody
group nogroup

cipher AES-256-CBC

comp-lzo adaptive

keepalive 10 120
persist-tun
persist-key

crl-verify /etc/openvpn/crl.pem

verb 0

client.ovpn
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
client

dev tun
proto udp

remote xxx.xxx.xxx.xxx
port 40404=20

tls-client

ca =A0=A0=A0 =A0=A0=A0 ca.crt
cert =A0=A0=A0 =A0=A0=A0 user.crt
key =A0=A0=A0 =A0=A0=A0 user.key
tls-auth =A0=A0=A0 ta.key 1

ns-cert-type server
cipher AES-256-CBC
keepalive 10 120

comp-lzo adaptive

persist-key
persist-tun

resolv-retry infinite
nobind

explicit-exit-notify 2

verb 3

firewall settings
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#!/bin/bash

PRIVATE=3D10.200.0.0/24

LOOP=3D127.0.0.1

iptables -P OUTPUT DROP
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -F

iptables -P OUTPUT ACCEPT
iptables -P INPUT DROP
iptables -P FORWARD DROP

iptables -A INPUT -i eth0 -s $LOOP -j DROP
iptables -A FORWARD -i eth0 -s $LOOP -j DROP
iptables -A INPUT -i eth0 -d $LOOP -j DROP
iptables -A FORWARD -i eth0 -d $LOOP -j DROP

iptables -A FORWARD -i eth0 -s 192.168.0.0/16 -j DROP
iptables -A FORWARD -i eth0 -s 172.16.0.0/12 -j DROP
iptables -A FORWARD -i eth0 -s 10.0.0.0/8 -j DROP
iptables -A INPUT -i eth0 -s 192.168.0.0/16 -j DROP
iptables -A INPUT -i eth0 -s 172.16.0.0/12 -j DROP
iptables -A INPUT -i eth0 -s 10.0.0.0/8 -j DROP

# block netbios from lan pc's
iptables -A FORWARD -p tcp --sport 137:139 -o eth0 -j DROP
iptables -A FORWARD -p udp --sport 137:139 -o eth0 -j DROP
iptables -A OUTPUT -p tcp --sport 137:139 -o eth0 -j DROP
iptables -A OUTPUT -p udp --sport 137:139 -o eth0 -j DROP

# Check source address validity on packets going out to internet
iptables -A FORWARD -s ! $PRIVATE -i eth1 -j DROP

# Allow local loopback
iptables -A INPUT -s $LOOP -j ACCEPT
iptables -A INPUT -d $LOOP -j ACCEPT

iptables -A INPUT -p udp -d xxx.xxx.xxx.xxx --dport 40404 -j ACCEPT=A0=A0=
=A0=20

iptables -A INPUT -i tun+ -j ACCEPT
iptables -A FORWARD -i tun+ -j ACCEPT
iptables -A INPUT -i tap+ -j ACCEPT
iptables -A FORWARD -i tap+ -j ACCEPT

iptables -A INPUT -p icmp -m state --state NEW --icmp-type ! 8 -j ACCEPT
iptables -A FORWARD -p icmp -m state --state NEW --icmp-type ! 8 -j ACCEPT

# Keep state of connections from local machine and private subnets
iptables -A OUTPUT -m state --state NEW -o eth0 -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A FORWARD -m state --state NEW -o eth0 -j ACCEPT
iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT

# Masquerade local subnet
iptables -t nat -A POSTROUTING -s $PRIVATE -o eth0 -j MASQUERADE







=20=20=20=20=20=20=

--0-1644982616-1247840843=:74587
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<table cellspacing=3D"0" cellpadding=3D"0" border=3D"0" ><tr><td valign=3D"=
top" style=3D"font: inherit;">Hello,<br><br>I just found that when I'am use=
ing TUN dev mode my VPN clients can access each other directly, even if cli=
ent-to-client option missing in my server.conf<br><br>and it's OK - when I'=
am useing TAP dev mode, the same configs just the changed tun to tap mode. =
so when TAP mode used and client-to-client is missing - users can't access =
each other directly<br><br>vpn server is based on Ubuntu Linux: tried versi=
ons 2.1RC11 and 2.1RC19<br>clients running windows XP machines<br><br>here =
are my configs<br><br>server.conf<br>mode server<br><br>dev tap<br>proto ud=
p<br><br>local xxx.xxx.xxx.xxx<br>port 40404<br><br>server 10.200.0.0 255.2=
55.255.0<br>push "redirect-gateway"<br>push "dhcp-option DNS 208.67.222.222=
"<br>push "dhcp-option DNS 208.67.222.220"<br><br>tls-server<br><br>dh &nbs=
p;&nbsp;&nbsp; /etc/openvpn/dh2048.pem<br>ca &nbsp;&nbsp;&nbsp;
 /etc/openvpn/ca.crt<br>cert &nbsp;&nbsp;&nbsp; /etc/openvpn/server.crt<br>=
key &nbsp;&nbsp;&nbsp; /etc/openvpn/server.key<br>tls-auth /etc/openvpn/ta.=
key 0<br><br>management localhost 7505<br><br>script-security 1<br><br>user=
 nobody<br>group nogroup<br><br>cipher AES-256-CBC<br><br>comp-lzo adaptive=
<br><br>keepalive 10 120<br>persist-tun<br>persist-key<br><br>crl-verify /e=
tc/openvpn/crl.pem<br><br>verb 0<br><br>client.ovpn<br>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>client<br><br>dev tun<br>proto udp<br><br>re=
mote xxx.xxx.xxx.xxx<br>port 40404 <br><br>tls-client<br><br>ca &nbsp;&nbsp=
;&nbsp; &nbsp;&nbsp;&nbsp; ca.crt<br>cert &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&n=
bsp; user.crt<br>key &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; user.key<br>tls-=
auth &nbsp;&nbsp;&nbsp; ta.key 1<br><br>ns-cert-type server<br>cipher AES-2=
56-CBC<br>keepalive 10 120<br><br>comp-lzo adaptive<br><br>persist-key<br>p=
ersist-tun<br><br>resolv-retry
 infinite<br>nobind<br><br>explicit-exit-notify 2<br><br>verb 3<br><br>fire=
wall settings<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>#!/bin=
/bash<br><br>PRIVATE=3D10.200.0.0/24<br><br>LOOP=3D127.0.0.1<br><br>iptable=
s -P OUTPUT DROP<br>iptables -P INPUT DROP<br>iptables -P FORWARD DROP<br>i=
ptables -F<br><br>iptables -P OUTPUT ACCEPT<br>iptables -P INPUT DROP<br>ip=
tables -P FORWARD DROP<br><br>iptables -A INPUT -i eth0 -s $LOOP -j DROP<br=
>iptables -A FORWARD -i eth0 -s $LOOP -j DROP<br>iptables -A INPUT -i eth0 =
-d $LOOP -j DROP<br>iptables -A FORWARD -i eth0 -d $LOOP -j DROP<br><br>ipt=
ables -A FORWARD -i eth0 -s 192.168.0.0/16 -j DROP<br>iptables -A FORWARD -=
i eth0 -s 172.16.0.0/12 -j DROP<br>iptables -A FORWARD -i eth0 -s 10.0.0.0/=
8 -j DROP<br>iptables -A INPUT -i eth0 -s 192.168.0.0/16 -j DROP<br>iptable=
s -A INPUT -i eth0 -s 172.16.0.0/12 -j DROP<br>iptables -A INPUT -i eth0 -s=
 10.0.0.0/8 -j DROP<br><br># block netbios from lan pc's<br>iptables -A FOR=
WARD -p tcp --sport 137:139
 -o eth0 -j DROP<br>iptables -A FORWARD -p udp --sport 137:139 -o eth0 -j D=
ROP<br>iptables -A OUTPUT -p tcp --sport 137:139 -o eth0 -j DROP<br>iptable=
s -A OUTPUT -p udp --sport 137:139 -o eth0 -j DROP<br><br># Check source ad=
dress validity on packets going out to internet<br>iptables -A FORWARD -s !=
 $PRIVATE -i eth1 -j DROP<br><br># Allow local loopback<br>iptables -A INPU=
T -s $LOOP -j ACCEPT<br>iptables -A INPUT -d $LOOP -j ACCEPT<br><br>iptable=
s -A INPUT -p udp -d xxx.xxx.xxx.xxx --dport 40404 -j ACCEPT&nbsp;&nbsp;&nb=
sp; <br><br>iptables -A INPUT -i tun+ -j ACCEPT<br>iptables -A FORWARD -i t=
un+ -j ACCEPT<br>iptables -A INPUT -i tap+ -j ACCEPT<br>iptables -A FORWARD=
 -i tap+ -j ACCEPT<br><br>iptables -A INPUT -p icmp -m state --state NEW --=
icmp-type ! 8 -j ACCEPT<br>iptables -A FORWARD -p icmp -m state --state NEW=
 --icmp-type ! 8 -j ACCEPT<br><br># Keep state of connections from local ma=
chine and private subnets<br>iptables -A OUTPUT -m state --state NEW
 -o eth0 -j ACCEPT<br>iptables -A INPUT -m state --state ESTABLISHED,RELATE=
D -j ACCEPT<br>iptables -A FORWARD -m state --state NEW -o eth0 -j ACCEPT<b=
r>iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT<br><br=
># Masquerade local subnet<br>iptables -t nat -A POSTROUTING -s $PRIVATE -o=
 eth0 -j MASQUERADE<br><br><br><br><br></td></tr></table><br>



=20=20=20=20=20=20=

--0-1644982616-1247840843=:74587--

