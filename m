Content-class: urn:content-classes:message
MIME-Version: 1.0
Date: Fri, 7 Jul 2006 08:57:45 +0200
Message-ID: <4718B66E939CA54D8D2B3B824CF4A211A33A42@...691...>
From: "Thomas Heidemann" <Thomas.Heidemann@...690...>
Subject: [Openvpn-devel] Connection initialized but no ping
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi list, hi developer.

I already asked my question to the users list but did not get any reply.
Maybe you can help.

I do have a very strange problem in building up an OpenVPN solution for
a number of roadwarriors.
The connection comes up fine but I cannot ping the vpn server nor any
other host through the tunnel.
After a few seconds, the tunnel breaks down again and the client tries
to reconnect which always fail.
=20
As you can see in the logs (see below), the connection comes up fine. I
do not have any firewall installed - neither on the server nor on the
client.
The strange thing: When I use an HTTP-Proxy server to connect from the
client, the connection itself and the traffic through the tunnel are
running fine.  No break down, no reconnect attempts.
I tried some different settings (tun-mtu,...) but these do not solve my
problem.
=20
Here is my setup:
- OpenVPN Server (version 2.0.7) running on SUSE Linux 10.0 (openvpn
package self-compiled) on Port 443 (TCP) with certificates in tunnel
mode (tun device)
=20
- Client on Windows XP SP2 (latest patchlevel) with latest openvpn-gui
(from openvpn.se)
=20
Here are my configs and logs (sorry for this long posting):
=20
Server:
------------------
local <server-ip>
port 443
proto tcp-server
dev tun
ca /etc/openvpn/ca.pem
cert /etc/openvpn/gate.crt
key /etc/openvpn/gate.key
dh /etc/openvpn/dh2048.pem
server 10.8.0.0 255.255.0.0
ifconfig-pool-persist ipp.txt
client-config-dir /etc/openvpn/ccd
push "dhcp-option DNS <dns-ip>"
push "dhcp-option WINS <wins-ip>"
client-to-client
keepalive 10 120
tls-auth ta.key 0 # This file is secret
cipher AES-256-CBC   # AES
comp-lzo
user nobody
group nobody
persist-key
persist-tun
status /etc/openvpn/openvpn-status.log
log-append  /var/log/openvpn.log
verb 6
management 127.0.0.1 444
crl-verify /etc/openvpn/crl.pem
plugin /lib/security/openvpn-auth-pam.so openvpn
client-connect  "/etc/openvpn/scripts/client-up.sh"
client-disconnect  "/etc/openvpn/scripts/client-down.sh"
------------------=20

Client:
------------------
tcp-client
dev tun
dev-node "OpenVPN"
proto tcp-client
remote <server-ip> 443
resolv-retry infinite
nobind
persist-key
persist-tun
mute-replay-warnings
pkcs12 client-cert.p12
ns-cert-type server
tls-auth ta.key 1
cipher AES-256-CBC
comp-lzo
verb 3
tun-mtu 1500
auth-user-pass
------------------
=20
=20
Logs:
Server:
------------------
Fri Jun 23 10:37:06 2006 us=3D430286 OpenVPN 2.0.7 i686-suse-linux [SSL]
[LZO] [EPOLL] built on May  5 2006
Fri Jun 23 10:37:06 2006 us=3D430556 MANAGEMENT: TCP Socket listening on
127.0.0.1:444
Fri Jun 23 10:37:06 2006 us=3D432727 PLUGIN_INIT: POST
/lib/security/openvpn-auth-pam.so 'openvpn'
intercepted=3DPLUGIN_AUTH_USER_PASS_VERIFY
Fri Jun 23 10:37:06 2006 us=3D550912 Diffie-Hellman initialized with 2048
bit key
Fri Jun 23 10:37:06 2006 us=3D553225 Control Channel Authentication: using
'ta.key' as a OpenVPN static key file
Fri Jun 23 10:37:06 2006 us=3D553323 Outgoing Control Channel
Authentication: Using 160 bit message hash 'SHA1' for HMAC
authentication
Fri Jun 23 10:37:06 2006 us=3D553363 Incoming Control Channel
Authentication: Using 160 bit message hash 'SHA1' for HMAC
authentication
Fri Jun 23 10:37:06 2006 us=3D553420 TLS-Auth MTU parms [ L:1560 D:168
EF:68 EB:0 ET:0 EL:0 ]
Fri Jun 23 10:37:06 2006 us=3D555557 TUN/TAP device tun0 opened
Fri Jun 23 10:37:06 2006 us=3D555727 TUN/TAP TX queue length set to 100
Fri Jun 23 10:37:06 2006 us=3D555802 /sbin/ifconfig tun0 10.8.0.1
pointopoint 10.8.0.2 mtu 1500
Fri Jun 23 10:37:06 2006 us=3D563813 /sbin/route add -net 10.8.0.0 netmask
255.255.0.0 gw 10.8.0.2
Fri Jun 23 10:37:06 2006 us=3D570351 Data Channel MTU parms [ L:1560
D:1450 EF:60 EB:135 ET:0 EL:0 AF:3/1 ]
Fri Jun 23 10:37:06 2006 us=3D587089 GID set to nobody
Fri Jun 23 10:37:06 2006 us=3D587280 UID set to nobody
Fri Jun 23 10:37:06 2006 us=3D587395 Listening for incoming TCP connection
on <server-ip>:443
Fri Jun 23 10:37:06 2006 us=3D587503 Socket Buffers: R=3D[87380->131072]
S=3D[16384->131072]
Fri Jun 23 10:37:06 2006 us=3D587550 TCPv4_SERVER link local (bound):
<server-ip>:443
Fri Jun 23 10:37:06 2006 us=3D587583 TCPv4_SERVER link remote: [undef]
Fri Jun 23 10:37:06 2006 us=3D587630 MULTI: multi_init called, r=3D256 v=3D=
256
Fri Jun 23 10:37:06 2006 us=3D588623 IFCONFIG POOL: base=3D10.8.0.4
size=3D16382
Fri Jun 23 10:37:06 2006 us=3D588975 IFCONFIG POOL LIST
Fri Jun 23 10:37:06 2006 us=3D589098 <client-name>,10.8.0.8
Fri Jun 23 10:37:06 2006 us=3D590111 MULTI: TCP INIT maxclients=3D1024
maxevents=3D1028
Fri Jun 23 10:37:06 2006 us=3D590292 Initialization Sequence Completed
Fri Jun 23 10:37:27 2006 us=3D286090 MULTI: multi_create_instance called
Fri Jun 23 10:37:27 2006 us=3D286344 Re-using SSL/TLS context
Fri Jun 23 10:37:27 2006 us=3D286482 LZO compression initialized
Fri Jun 23 10:37:27 2006 us=3D286882 Control Channel MTU parms [ L:1560
D:168 EF:68 EB:0 ET:0 EL:0 ]
Fri Jun 23 10:37:27 2006 us=3D286987 Data Channel MTU parms [ L:1560
D:1450 EF:60 EB:135 ET:0 EL:0 AF:3/1 ]
Fri Jun 23 10:37:27 2006 us=3D287248 Local Options String: 'V4,dev-type
tun,link-mtu 1560,tun-mtu 1500,proto TCPv4_SERVER,comp-lzo,keydir
0,cipher AES-256-CBC,auth SHA1,keysize 256,tls-auth,key-method
2,tls-server'
Fri Jun 23 10:37:27 2006 us=3D287290 Expected Remote Options String:
'V4,dev-type tun,link-mtu 1560,tun-mtu 1500,proto
TCPv4_CLIENT,comp-lzo,keydir 1,cipher AES-256-CBC,auth SHA1,keysize
256,tls-auth,key-method 2,tls-client'
Fri Jun 23 10:37:27 2006 us=3D287374 Local Options hash (VER=3DV4):
'9915e4a2'
Fri Jun 23 10:37:27 2006 us=3D287427 Expected Remote Options hash
(VER=3DV4): '2f2c6498'

Connection starts here:
Fri Jun 23 10:37:27 2006 us=3D287536 TCP connection established with
192.168.11.133:1199
Fri Jun 23 10:37:27 2006 us=3D287587 Socket Buffers: R=3D[131072->131072]
S=3D[131072->131072]
Fri Jun 23 10:37:27 2006 us=3D287629 TCPv4_SERVER link local: [undef]
Fri Jun 23 10:37:27 2006 us=3D287666 TCPv4_SERVER link remote:
192.168.11.133:1199
Fri Jun 23 10:37:27 2006 us=3D288180 192.168.11.133:1199 TCPv4_SERVER
WRITE [42] to 192.168.11.133:1199: P_CONTROL_HARD_RESET_SERVER_V2 kid=3D0
pid=3D[ #1 ] [ ] pid=3D0 DATA len=3D0
Fri Jun 23 10:37:27 2006 us=3D288446 192.168.11.133:1199 TCPv4_SERVER READ
[42] from 192.168.11.133:1199: P_CONTROL_HARD_RESET_CLIENT_V2 kid=3D0
pid=3D[ #1 ] [ ] pid=3D0 DATA len=3D0
Fri Jun 23 10:37:27 2006 us=3D288510 192.168.11.133:1199 TLS: Initial
packet from 192.168.11.133:1199, sid=3D46bfb0bf 66016382
Fri Jun 23 10:37:27 2006 us=3D288630 192.168.11.133:1199 TCPv4_SERVER
WRITE [54] to 192.168.11.133:1199: P_CONTROL_HARD_RESET_SERVER_V2 kid=3D0
pid=3D[ #2 ] [ 0 ] pid=3D0 DATA len=3D0
Fri Jun 23 10:37:27 2006 us=3D288864 192.168.11.133:1199 TCPv4_SERVER READ
[54] from 192.168.11.133:1199: P_CONTROL_HARD_RESET_CLIENT_V2 kid=3D0
pid=3D[ #2 ] [ 0 ] pid=3D0 DATA len=3D0
Fri Jun 23 10:37:27 2006 us=3D288974 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #3 ] [ 0 ]
Fri Jun 23 10:37:27 2006 us=3D289181 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #3 ] [ 0 ]
Fri Jun 23 10:37:27 2006 us=3D289602 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #4 ] [ ] pid=
=3D1
DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D289747 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #4 ] [ 1 ]
Fri Jun 23 10:37:27 2006 us=3D289860 192.168.11.133:1199 TCPv4_SERVER READ
[44] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #5 ] [ ] pid=3D2
DATA len=3D2
Fri Jun 23 10:37:27 2006 us=3D414525 192.168.11.133:1199 TCPv4_SERVER
WRITE [154] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #5 ] [ 2 ]
pid=3D1 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D414726 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #6 ] [ ]
pid=3D2 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D414842 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #7 ] [ ]
pid=3D3 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D414956 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #8 ] [ ]
pid=3D4 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D488958 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #6 ] [ 1 ]
Fri Jun 23 10:37:27 2006 us=3D489116 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #9 ] [ ]
pid=3D5 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D489531 192.168.11.133:1199 TCPv4_SERVER READ
[58] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #7 ] [ 2 3 4 ]
Fri Jun 23 10:37:27 2006 us=3D489666 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #10 ] [ ]
pid=3D6 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D489807 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #11 ] [ ]
pid=3D7 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D489922 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #12 ] [ ]
pid=3D8 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D490084 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #8 ] [ 5 ]
Fri Jun 23 10:37:27 2006 us=3D490344 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #13 ] [ ]
pid=3D9 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D490497 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #9 ] [ 6 ]
Fri Jun 23 10:37:27 2006 us=3D490624 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #14 ] [ ]
pid=3D10 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D490850 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #10 ] [ 7 ]
Fri Jun 23 10:37:27 2006 us=3D490982 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #15 ] [ ]
pid=3D11 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D491066 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #11 ] [ 8 ]
Fri Jun 23 10:37:27 2006 us=3D491228 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #16 ] [ ]
pid=3D12 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D491327 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #12 ] [ 9 ]
Fri Jun 23 10:37:27 2006 us=3D491499 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #17 ] [ ]
pid=3D13 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D491605 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #13 ] [ 10 ]
Fri Jun 23 10:37:27 2006 us=3D491723 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #18 ] [ ]
pid=3D14 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D491857 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #14 ] [ 11 ]
Fri Jun 23 10:37:27 2006 us=3D491978 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #19 ] [ ]
pid=3D15 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D492237 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #15 ] [ 12 ]
Fri Jun 23 10:37:27 2006 us=3D492363 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #20 ] [ ]
pid=3D16 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D492591 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #16 ] [ 13 ]
Fri Jun 23 10:37:27 2006 us=3D492736 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #21 ] [ ]
pid=3D17 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D492823 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #17 ] [ 14 ]
Fri Jun 23 10:37:27 2006 us=3D492979 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #22 ] [ ]
pid=3D18 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D493077 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #18 ] [ 15 ]
Fri Jun 23 10:37:27 2006 us=3D493227 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #23 ] [ ]
pid=3D19 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D493327 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #19 ] [ 16 ]
Fri Jun 23 10:37:27 2006 us=3D493439 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #24 ] [ ]
pid=3D20 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D493580 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #20 ] [ 17 ]
Fri Jun 23 10:37:27 2006 us=3D493701 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #25 ] [ ]
pid=3D21 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D493977 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #21 ] [ 18 ]
Fri Jun 23 10:37:27 2006 us=3D494097 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #26 ] [ ]
pid=3D22 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D494347 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #22 ] [ 19 ]
Fri Jun 23 10:37:27 2006 us=3D494476 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #27 ] [ ]
pid=3D23 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D494561 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #23 ] [ 20 ]
Fri Jun 23 10:37:27 2006 us=3D494714 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #28 ] [ ]
pid=3D24 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D494814 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #24 ] [ 21 ]
Fri Jun 23 10:37:27 2006 us=3D494924 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #29 ] [ ]
pid=3D25 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D495060 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #25 ] [ 22 ]
Fri Jun 23 10:37:27 2006 us=3D495172 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #30 ] [ ]
pid=3D26 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D521292 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #26 ] [ 23 ]
Fri Jun 23 10:37:27 2006 us=3D521413 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #31 ] [ ]
pid=3D27 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D521693 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #27 ] [ 24 ]
Fri Jun 23 10:37:27 2006 us=3D521811 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #32 ] [ ]
pid=3D28 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D522051 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #28 ] [ 25 ]
Fri Jun 23 10:37:27 2006 us=3D522167 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #33 ] [ ]
pid=3D29 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D522250 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #29 ] [ 26 ]
Fri Jun 23 10:37:27 2006 us=3D522407 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #34 ] [ ]
pid=3D30 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D522512 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #30 ] [ 27 ]
Fri Jun 23 10:37:27 2006 us=3D522621 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #35 ] [ ]
pid=3D31 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D522756 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #31 ] [ 28 ]
Fri Jun 23 10:37:27 2006 us=3D522864 192.168.11.133:1199 TCPv4_SERVER
WRITE [121] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #36 ] [ ]
pid=3D32 DATA len=3D79
Fri Jun 23 10:37:27 2006 us=3D523035 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #32 ] [ 29 ]
Fri Jun 23 10:37:27 2006 us=3D523802 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #33 ] [ 30 ]
Fri Jun 23 10:37:27 2006 us=3D973363 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #34 ] [ 31 ]
Fri Jun 23 10:37:27 2006 us=3D973895 192.168.11.133:1199 TCPv4_SERVER READ
[154] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #35 ] [ 32 ]
pid=3D3 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D974040 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #37 ] [ 3 ]
Fri Jun 23 10:37:27 2006 us=3D974154 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #36 ] [ ] pid=
=3D4
DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D974274 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #38 ] [ 4 ]
Fri Jun 23 10:37:27 2006 us=3D974361 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #37 ] [ ] pid=
=3D5
DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D974641 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #39 ] [ 5 ]
Fri Jun 23 10:37:27 2006 us=3D974736 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #38 ] [ ] pid=
=3D6
DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D974897 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #40 ] [ 6 ]
Fri Jun 23 10:37:27 2006 us=3D975005 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #39 ] [ ] pid=
=3D7
DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D975127 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #41 ] [ 7 ]
Fri Jun 23 10:37:27 2006 us=3D975250 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #40 ] [ ] pid=
=3D8
DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D975374 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #42 ] [ 8 ]
Fri Jun 23 10:37:27 2006 us=3D975470 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #41 ] [ ] pid=
=3D9
DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D975588 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #43 ] [ 9 ]
Fri Jun 23 10:37:27 2006 us=3D975727 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #42 ] [ ]
pid=3D10 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D975849 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #44 ] [ 10 ]
Fri Jun 23 10:37:27 2006 us=3D976007 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #43 ] [ ]
pid=3D11 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D976138 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #45 ] [ 11 ]
Fri Jun 23 10:37:27 2006 us=3D976369 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #44 ] [ ]
pid=3D12 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D976499 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #46 ] [ 12 ]
Fri Jun 23 10:37:27 2006 us=3D976793 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #45 ] [ ]
pid=3D13 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D976926 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #47 ] [ 13 ]
Fri Jun 23 10:37:27 2006 us=3D977012 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #46 ] [ ]
pid=3D14 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D977177 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #48 ] [ 14 ]
Fri Jun 23 10:37:27 2006 us=3D977279 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #47 ] [ ]
pid=3D15 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D977400 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #49 ] [ 15 ]
Fri Jun 23 10:37:27 2006 us=3D977557 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #48 ] [ ]
pid=3D16 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D977687 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #50 ] [ 16 ]
Fri Jun 23 10:37:27 2006 us=3D977824 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #49 ] [ ]
pid=3D17 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D977949 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #51 ] [ 17 ]
Fri Jun 23 10:37:27 2006 us=3D978171 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #50 ] [ ]
pid=3D18 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D978301 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #52 ] [ 18 ]
Fri Jun 23 10:37:27 2006 us=3D978575 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #51 ] [ ]
pid=3D19 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D978788 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #53 ] [ 19 ]
Fri Jun 23 10:37:27 2006 us=3D978924 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #52 ] [ ]
pid=3D20 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D979049 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #54 ] [ 20 ]
Fri Jun 23 10:37:27 2006 us=3D979148 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #53 ] [ ]
pid=3D21 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D979312 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #55 ] [ 21 ]
Fri Jun 23 10:37:27 2006 us=3D979413 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #54 ] [ ]
pid=3D22 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D979575 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #56 ] [ 22 ]
Fri Jun 23 10:37:27 2006 us=3D979678 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #55 ] [ ]
pid=3D23 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D979801 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #57 ] [ 23 ]
Fri Jun 23 10:37:27 2006 us=3D979936 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #56 ] [ ]
pid=3D24 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D980059 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #58 ] [ 24 ]
Fri Jun 23 10:37:27 2006 us=3D980256 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #57 ] [ ]
pid=3D25 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D982550 192.168.11.133:1199 CRL CHECK OK:
<cert>
Fri Jun 23 10:37:27 2006 us=3D983471 192.168.11.133:1199 CRL CHECK OK:
<cert>
Fri Jun 23 10:37:27 2006 us=3D983554 192.168.11.133:1199 VERIFY OK:
depth=3D0, <cert>
Fri Jun 23 10:37:27 2006 us=3D983750 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #59 ] [ 25 ]
Fri Jun 23 10:37:27 2006 us=3D983936 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #58 ] [ ]
pid=3D26 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D984079 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #60 ] [ 26 ]
Fri Jun 23 10:37:27 2006 us=3D984237 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #59 ] [ ]
pid=3D27 DATA len=3D100
Fri Jun 23 10:37:27 2006 us=3D984364 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #61 ] [ 27 ]
Fri Jun 23 10:37:27 2006 us=3D984462 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #60 ] [ ]
pid=3D28 DATA len=3D100
Fri Jun 23 10:37:28 2006 us=3D120206 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #62 ] [ 28 ]
Fri Jun 23 10:37:28 2006 us=3D120425 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #61 ] [ ]
pid=3D29 DATA len=3D100
Fri Jun 23 10:37:28 2006 us=3D121333 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #63 ] [ 29 ]
Fri Jun 23 10:37:28 2006 us=3D121443 192.168.11.133:1199 TCPv4_SERVER READ
[59] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #62 ] [ ] pid=
=3D30
DATA len=3D17
Fri Jun 23 10:37:28 2006 us=3D121893 192.168.11.133:1199 TCPv4_SERVER
WRITE [113] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #64 ] [ 30
] pid=3D33 DATA len=3D59
Fri Jun 23 10:37:28 2006 us=3D289936 192.168.11.133:1199 TCPv4_SERVER READ
[154] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #63 ] [ 33 ]
pid=3D31 DATA len=3D100
Fri Jun 23 10:37:28 2006 us=3D290110 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #65 ] [ 31 ]
Fri Jun 23 10:37:28 2006 us=3D290356 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #64 ] [ ]
pid=3D32 DATA len=3D100
Fri Jun 23 10:37:28 2006 us=3D290470 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #66 ] [ 32 ]
Fri Jun 23 10:37:28 2006 us=3D290548 192.168.11.133:1199 TCPv4_SERVER READ
[142] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #65 ] [ ]
pid=3D33 DATA len=3D100
Fri Jun 23 10:37:28 2006 us=3D290648 192.168.11.133:1199 TCPv4_SERVER
WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #67 ] [ 33 ]
Fri Jun 23 10:37:28 2006 us=3D290722 192.168.11.133:1199 TCPv4_SERVER READ
[104] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #66 ] [ ]
pid=3D34 DATA len=3D62
Fri Jun 23 10:37:28 2006 us=3D417331 192.168.11.133:1199 PLUGIN_CALL: POST
/lib/security/openvpn-auth-pam.so/PLUGIN_AUTH_USER_PASS_VERIFY status=3D0
Fri Jun 23 10:37:28 2006 us=3D417428 192.168.11.133:1199 TLS:
Username/Password authentication succeeded for username '<username>'
Fri Jun 23 10:37:28 2006 us=3D417888 192.168.11.133:1199 Data Channel
Encrypt: Cipher 'AES-256-CBC' initialized with 256 bit key
Fri Jun 23 10:37:28 2006 us=3D417933 192.168.11.133:1199 Data Channel
Encrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Fri Jun 23 10:37:28 2006 us=3D417979 192.168.11.133:1199 Data Channel
Decrypt: Cipher 'AES-256-CBC' initialized with 256 bit key
Fri Jun 23 10:37:28 2006 us=3D418019 192.168.11.133:1199 Data Channel
Decrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Fri Jun 23 10:37:28 2006 us=3D418219 192.168.11.133:1199 TCPv4_SERVER
WRITE [154] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #68 ] [ 34
] pid=3D34 DATA len=3D100
Fri Jun 23 10:37:28 2006 us=3D418332 192.168.11.133:1199 TCPv4_SERVER
WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #69 ] [ ]
pid=3D35 DATA len=3D100
Fri Jun 23 10:37:28 2006 us=3D418422 192.168.11.133:1199 TCPv4_SERVER
WRITE [140] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0 pid=3D[ #70 ] [ ]
pid=3D36 DATA len=3D98
Fri Jun 23 10:37:28 2006 us=3D490550 192.168.11.133:1199 TCPv4_SERVER READ
[50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #67 ] [ 34 ]
Fri Jun 23 10:37:28 2006 us=3D490792 192.168.11.133:1199 TCPv4_SERVER READ
[54] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #68 ] [ 35 36 ]
Fri Jun 23 10:37:28 2006 us=3D490899 192.168.11.133:1199 Control Channel:
TLSv1, cipher TLSv1/SSLv3 DHE-RSA-AES256-SHA, 1024 bit RSA
Fri Jun 23 10:37:28 2006 us=3D490974 192.168.11.133:1199 [<client-name>]
Peer Connection Initiated with 192.168.11.133:1199
Fri Jun 23 10:37:28 2006 us=3D491186 <client-name>/192.168.11.133:1199
OPTIONS IMPORT: reading client specific options from:
/etc/openvpn/ccd/<client-name>
Fri Jun 23 10:37:28 2006 us=3D506519 <client-name>/192.168.11.133:1199
MULTI: Learn: 10.8.0.10 -> <client-name>/192.168.11.133:1199
Fri Jun 23 10:37:28 2006 us=3D506631 <client-name>/192.168.11.133:1199
MULTI: primary virtual IP for <client-name>/192.168.11.133:1199:
10.8.0.10
Fri Jun 23 10:37:29 2006 us=3D511477 <client-name>/192.168.11.133:1199
TCPv4_SERVER READ [132] from 192.168.11.133:1199: P_CONTROL_V1 kid=3D0
pid=3D[ #69 ] [ ] pid=3D35 DATA len=3D90
Fri Jun 23 10:37:29 2006 us=3D511786 <client-name>/192.168.11.133:1199
PUSH: Received control message: 'PUSH_REQUEST'
Fri Jun 23 10:37:29 2006 us=3D511923 <client-name>/192.168.11.133:1199
SENT CONTROL [<client-name>]: 'PUSH_REPLY,dhcp-option DNS
<dns-ip>,dhcp-option WINS <wins-ip>,route 10.8.0.0 255.255.0.0,ping
10,ping-restart 120,route 192.168.13.0 255.255.255.0,ifconfig 10.8.0.10
10.8.0.9' (status=3D1)

Connection established!
Fri Jun 23 10:37:29 2006 us=3D512097 <client-name>/192.168.11.133:1199
TCPv4_SERVER WRITE [50] to 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[ #71
] [ 35 ]
Fri Jun 23 10:37:29 2006 us=3D512265 <client-name>/192.168.11.133:1199
TCPv4_SERVER WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0
pid=3D[ #72 ] [ ] pid=3D37 DATA len=3D100
Fri Jun 23 10:37:29 2006 us=3D512365 <client-name>/192.168.11.133:1199
TCPv4_SERVER WRITE [142] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0
pid=3D[ #73 ] [ ] pid=3D38 DATA len=3D100
Fri Jun 23 10:37:29 2006 us=3D512459 <client-name>/192.168.11.133:1199
TCPv4_SERVER WRITE [140] to 192.168.11.133:1199: P_CONTROL_V1 kid=3D0
pid=3D[ #74 ] [ ] pid=3D39 DATA len=3D98
Fri Jun 23 10:37:29 2006 us=3D702610 <client-name>/192.168.11.133:1199
TCPv4_SERVER READ [50] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[
#70 ] [ 37 ]
Fri Jun 23 10:37:29 2006 us=3D741249 <client-name>/192.168.11.133:1199
TCPv4_SERVER READ [54] from 192.168.11.133:1199: P_ACK_V1 kid=3D0 pid=3D[
#71 ] [ 38 39 ]
Fri Jun 23 10:37:40 2006 us=3D33821 <client-name>/192.168.11.133:1199
TCPv4_SERVER WRITE [69] to 192.168.11.133:1199: P_DATA_V1 kid=3D0 DATA
len=3D68
Fri Jun 23 10:37:50 2006 us=3D114500 <client-name>/192.168.11.133:1199
TCPv4_SERVER WRITE [69] to 192.168.11.133:1199: P_DATA_V1 kid=3D0 DATA
len=3D68
Fri Jun 23 10:38:00 2006 us=3D139266 <client-name>/192.168.11.133:1199
TCPv4_SERVER WRITE [69] to 192.168.11.133:1199: P_DATA_V1 kid=3D0 DATA
len=3D68
Fri Jun 23 10:38:10 2006 us=3D211953 <client-name>/192.168.11.133:1199
TCPv4_SERVER WRITE [69] to 192.168.11.133:1199: P_DATA_V1 kid=3D0 DATA
len=3D68
Fri Jun 23 10:38:20 2006 us=3D372998 <client-name>/192.168.11.133:1199
TCPv4_SERVER WRITE [69] to 192.168.11.133:1199: P_DATA_V1 kid=3D0 DATA
len=3D68
Fri Jun 23 10:38:21 2006 us=3D117514 <client-name>/192.168.11.133:1199 TUN
READ [96]
Fri Jun 23 10:38:21 2006 us=3D117655 <client-name>/192.168.11.133:1199
TCPv4_SERVER WRITE [149] to 192.168.11.133:1199: P_DATA_V1 kid=3D0 DATA
len=3D148
Fri Jun 23 10:38:21 2006 us=3D897109 <client-name>/192.168.11.133:1199 TUN
READ [329]
Fri Jun 23 10:38:21 2006 us=3D897662 <client-name>/192.168.11.133:1199
TCPv4_SERVER WRITE [229] to 192.168.11.133:1199: P_DATA_V1 kid=3D0 DATA
len=3D228
Fri Jun 23 10:38:23 2006 us=3D399308 <client-name>/192.168.11.133:1199 TUN
READ [329]
Fri Jun 23 10:38:23 2006 us=3D399557 <client-name>/192.168.11.133:1199
TCPv4_SERVER WRITE [229] to 192.168.11.133:1199: P_DATA_V1 kid=3D0 DATA
len=3D228
Fri Jun 23 10:38:24 2006 us=3D901447 <client-name>/192.168.11.133:1199 TUN
READ [329]
Fri Jun 23 10:38:24 2006 us=3D901620 <client-name>/192.168.11.133:1199
TCPv4_SERVER WRITE [229] to 192.168.11.133:1199: P_DATA_V1 kid=3D0 DATA
len=3D228
Fri Jun 23 10:38:26 2006 us=3D403802 <client-name>/192.168.11.133:1199 TUN
READ [48]
Fri Jun 23 10:38:26 2006 us=3D403904 <client-name>/192.168.11.133:1199
TCPv4_SERVER WRITE [101] to 192.168.11.133:1199: P_DATA_V1 kid=3D0 DATA
len=3D100
Fri Jun 23 10:38:28 2006 us=3D805632 <client-name>/192.168.11.133:1199
Connection reset, restarting [-1]
Fri Jun 23 10:38:28 2006 us=3D805755 <client-name>/192.168.11.133:1199
SIGUSR1[soft,connection-reset] received, client-instance restarting
Fri Jun 23 10:38:28 2006 us=3D833638 TCP/UDP: Closing socket
------------------
Tunnel broke down :(

Client:
------------------
Fri Jun 23 10:35:16 2006 OpenVPN 2.0.7 Win32-MinGW [SSL] [LZO] built on
Apr 12 2006
Fri Jun 23 10:35:21 2006 IMPORTANT: OpenVPN's default port number is now
1194, based on an official port number assignment by IANA.  OpenVPN
2.0-beta16 and earlier used 5000 as the default port.
Fri Jun 23 10:35:25 2006 Control Channel Authentication: using 'ta.key'
as a OpenVPN static key file
Fri Jun 23 10:35:25 2006 Outgoing Control Channel Authentication: Using
160 bit message hash 'SHA1' for HMAC authentication
Fri Jun 23 10:35:25 2006 Incoming Control Channel Authentication: Using
160 bit message hash 'SHA1' for HMAC authentication
Fri Jun 23 10:35:25 2006 LZO compression initialized
Fri Jun 23 10:35:25 2006 Control Channel MTU parms [ L:1560 D:168 EF:68
EB:0 ET:0 EL:0 ]
Fri Jun 23 10:35:25 2006 Data Channel MTU parms [ L:1560 D:1450 EF:60
EB:135 ET:0 EL:0 AF:3/1 ]
Fri Jun 23 10:35:25 2006 Local Options hash (VER=3DV4): '2f2c6498'
Fri Jun 23 10:35:25 2006 Expected Remote Options hash (VER=3DV4):
'9915e4a2'
Fri Jun 23 10:35:25 2006 Attempting to establish TCP connection with
<server-ip>:443
Fri Jun 23 10:35:25 2006 TCP connection established with <server-ip>:443
Fri Jun 23 10:35:25 2006 TCPv4_CLIENT link local: [undef]
Fri Jun 23 10:35:25 2006 TCPv4_CLIENT link remote: <server-ip>:443
Fri Jun 23 10:35:25 2006 TLS: Initial packet from <server-ip>:443,
sid=3D7f934e53 3cb48279
Fri Jun 23 10:35:26 2006 VERIFY OK: depth=3D1, <cert>
Fri Jun 23 10:35:26 2006 VERIFY OK: nsCertType=3DSERVER
Fri Jun 23 10:35:26 2006 VERIFY OK: depth=3D0, <cert>
Fri Jun 23 10:35:27 2006 Data Channel Encrypt: Cipher 'AES-256-CBC'
initialized with 256 bit key
Fri Jun 23 10:35:27 2006 Data Channel Encrypt: Using 160 bit message
hash 'SHA1' for HMAC authentication
Fri Jun 23 10:35:27 2006 Data Channel Decrypt: Cipher 'AES-256-CBC'
initialized with 256 bit key
Fri Jun 23 10:35:27 2006 Data Channel Decrypt: Using 160 bit message
hash 'SHA1' for HMAC authentication
Fri Jun 23 10:35:27 2006 Control Channel: TLSv1, cipher TLSv1/SSLv3
DHE-RSA-AES256-SHA, 1024 bit RSA
Fri Jun 23 10:35:27 2006 [<server-name>] Peer Connection Initiated with
<server-ip>:443
Fri Jun 23 10:35:28 2006 SENT CONTROL [<server-name>]: 'PUSH_REQUEST'
(status=3D1)
Fri Jun 23 10:35:28 2006 PUSH: Received control message:
'PUSH_REPLY,dhcp-option DNS <dns-ip>,dhcp-option WINS <wins-ip>,route
10.8.0.0 255.255.0.0,ping 10,ping-restart 120,route 192.168.13.0
255.255.255.0,ifconfig 10.8.0.10 10.8.0.9'
Fri Jun 23 10:35:28 2006 OPTIONS IMPORT: timers and/or timeouts modified
Fri Jun 23 10:35:28 2006 OPTIONS IMPORT: --ifconfig/up options modified
Fri Jun 23 10:35:28 2006 OPTIONS IMPORT: route options modified
Fri Jun 23 10:35:28 2006 OPTIONS IMPORT: --ip-win32 and/or --dhcp-option
options modified
Fri Jun 23 10:35:28 2006 TAP-WIN32 device [OpenVPN] opened:
\\.\Global\{D16ADC81-E6A1-46EF-B6CE-8C5A57FCB6CD}.tap
Fri Jun 23 10:35:28 2006 TAP-Win32 Driver Version 8.1=20
Fri Jun 23 10:35:28 2006 TAP-Win32 MTU=3D1500
Fri Jun 23 10:35:28 2006 Notified TAP-Win32 driver to set a DHCP
IP/netmask of 10.8.0.10/255.255.255.252 on interface
{D16ADC81-E6A1-46EF-B6CE-8C5A57FCB6CD} [DHCP-serv: 10.8.0.9, lease-time:
31536000]
Fri Jun 23 10:35:28 2006 Successful ARP Flush on interface [3]
{D16ADC81-E6A1-46EF-B6CE-8C5A57FCB6CD}
Fri Jun 23 10:35:28 2006 TEST ROUTES: 0/0 succeeded len=3D3 ret=3D0 a=3D0
u/d=3Ddown
Fri Jun 23 10:35:28 2006 Route: Waiting for TUN/TAP interface to come
up...
Fri Jun 23 10:35:31 2006 TEST ROUTES: 0/0 succeeded len=3D3 ret=3D0 a=3D0
u/d=3Ddown
Fri Jun 23 10:35:31 2006 Route: Waiting for TUN/TAP interface to come
up...
Fri Jun 23 10:35:32 2006 TEST ROUTES: 3/3 succeeded len=3D3 ret=3D1 a=3D0
u/d=3Dup
Fri Jun 23 10:35:32 2006 route ADD 10.8.0.0 MASK 255.255.0.0 10.8.0.9
Fri Jun 23 10:35:32 2006 Route addition via IPAPI succeeded
Fri Jun 23 10:35:32 2006 route ADD 192.168.13.0 MASK 255.255.255.0
10.8.0.9
Fri Jun 23 10:35:32 2006 Route addition via IPAPI succeeded
Fri Jun 23 10:35:32 2006 Initialization Sequence Completed

Connection established successfully!
And a few seconds later:

Fri Jun 23 10:35:53 2006 write TCPv4_CLIENT: Connection reset by peer
(WSAECONNRESET) (code=3D10054)
Fri Jun 23 10:35:53 2006 Connection reset, restarting [-1]
Fri Jun 23 10:35:53 2006 TCP/UDP: Closing socket
Fri Jun 23 10:35:53 2006 SIGUSR1[soft,connection-reset] received,
process restarting
Fri Jun 23 10:35:53 2006 Restart pause, 5 second(s)
...
------------------
=20
Any suggestions?
=20
Thanks for your answer.
=20
Regards,
Thomas



