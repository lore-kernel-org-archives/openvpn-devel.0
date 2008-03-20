Message-ID: <47E279C9.9060208@...1030...>
Date: Thu, 20 Mar 2008 15:50:49 +0100
From: Marcus <adesperateuser@...1030...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Unwanted behavior with "remote random" and "retry
	infinite" on 2.1rc7
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi Folks,

I just did a failover-test according to the howto.
Two server (1+2) resolved via dns.

the server pushes the following:
push "redirect-gateway def1"
push "dhcp-option DOMAIN uni-tuebingen.de"
push "dhcp-option DNS 134.2.200.1"
push "dhcp-option DNS 134.2.200.2"

This works great.

Scenario was as follows:

Client is connected to and does everything via Server 1.
Now Server 1 crashes due to hardware-error or whatever. (I simulated 
that by killing the ovpn-daemon with SIGTERM).

After some time the client recognizes that and tries it's 
rescue-programm. It however fails to resolve other servers from its 
conf, since the routing is still in effect (at least thats what I 
suppose.) Here the whole failover-concept is screwed in my opinion. 
(Maybe I just misconfigured it?)


Here the client and server-config:

local openvpn1or2.ourdomain.de
port 1194
proto udp
dev tun

# Use the whole subnet (coz IPv4-Adresses are getting rare)
## (experimental?)
topology subnet

# PAM for authentication
plugin /lib/security/openvpn-auth-pam.so openvpn

# Change to config-Dir
cd /etc/openvpn

# Key-Stuff
ca ssl/ca.crt
cert ssl/server.crt
key ssl/server.key
dh ssl/dh1024.pem

mode server
server 13.12.221.0 255.255.255.0

client-cert-not-required
username-as-common-name

tls-server
tls-auth ssl/ta.key 0

up /etc/openvpn/server-up.sh
down /etc/openvpn/server-down.sh
client-connect /etc/openvpn/client-connect.sh
client-disconnect /etc/openvpn/client-disconnect.sh

push "redirect-gateway def1"
push "dhcp-option DOMAIN ourdomain.de"
push "dhcp-option DNS 13.12.222.1"
push "dhcp-option DNS 13.12.222.2"

client-to-client
duplicate-cn
keepalive 10 120
comp-lzo
persist-key
persist-tun
status /var/log/openvpn/openvpn-status.log 1
log-append /var/log/openvpn/openvpn.log
verb 3

# drop privs
user openvpn
group openvpn

mute 4

-----  so far for the server config

Here comes the client config:

client
dev tun
proto udp

remote openvpn1.ourdomain.de 1194
remote openvpn2.ourdomain.de 1194
remote random

route-method exe
route-delay 2
resolv-retry infinite
nobind
persist-key
persist-tun

auth-user-pass

ca ca.crt
tls-auth ta.key 1

verb 3


Here is the client-log of the failover test:

Thu Mar 20 14:34:42 2008 OpenVPN 2.1_rc7 Win32-MinGW [SSL] [LZO2] 
[PKCS11] built on Jan 29 2008
[ ... ]
Thu Mar 20 14:56:50 2008 [openvpn1.ourdomain.de] Inactivity timeout 
(--ping-restart), restarting
Thu Mar 20 14:56:50 2008 TCP/UDP: Closing socket
Thu Mar 20 14:56:50 2008 SIGUSR1[soft,ping-restart] received, process 
restarting
Thu Mar 20 14:56:50 2008 Restart pause, 2 second(s)
Thu Mar 20 14:56:52 2008 WARNING: No server certificate verification 
method has been enabled.  See http://openvpn.net/howto.html#mitm for 
more info.
Thu Mar 20 14:56:52 2008 Re-using SSL/TLS context
Thu Mar 20 14:56:52 2008 LZO compression initialized
Thu Mar 20 14:56:52 2008 Control Channel MTU parms [ L:1542 D:166 EF:66 
EB:0 ET:0 EL:0 ]
Thu Mar 20 14:57:07 2008 RESOLVE: Cannot resolve host address: 
openvpn1.ourdomain.de: [NO_DATA] The requested name is valid but does 
not have an IP address.
Thu Mar 20 14:57:07 2008 Data Channel MTU parms [ L:1542 D:1450 EF:42 
EB:135 ET:0 EL:0 AF:3/1 ]
Thu Mar 20 14:57:07 2008 Local Options hash (VER=V4): '504e774e'
Thu Mar 20 14:57:07 2008 Expected Remote Options hash (VER=V4): '14168603'
Thu Mar 20 14:57:22 2008 RESOLVE: Cannot resolve host address: 
openvpn1.ourdomain.de: [NO_DATA] The requested name is valid but does 
not have an IP address.
Thu Mar 20 14:57:22 2008 TCP/UDP: Closing socket
Thu Mar 20 14:57:22 2008 SIGUSR1[soft,init_instance] received, process 
restarting
Thu Mar 20 14:57:22 2008 Restart pause, 2 second(s)
Thu Mar 20 14:57:24 2008 WARNING: No server certificate verification 
method has been enabled.  See http://openvpn.net/howto.html#mitm for 
more info.
Thu Mar 20 14:57:24 2008 Re-using SSL/TLS context
Thu Mar 20 14:57:24 2008 LZO compression initialized
Thu Mar 20 14:57:24 2008 Control Channel MTU parms [ L:1542 D:166 EF:66 
EB:0 ET:0 EL:0 ]
Thu Mar 20 14:57:39 2008 RESOLVE: Cannot resolve host address: 
openvpn2.ourdomain.de: [NO_DATA] The requested name is valid but does 
not have an IP address.
Thu Mar 20 14:57:39 2008 Data Channel MTU parms [ L:1542 D:1450 EF:42 
EB:135 ET:0 EL:0 AF:3/1 ]
Thu Mar 20 14:57:39 2008 Local Options hash (VER=V4): '504e774e'
Thu Mar 20 14:57:39 2008 Expected Remote Options hash (VER=V4): '14168603'
Thu Mar 20 14:57:54 2008 RESOLVE: Cannot resolve host address: 
openvpn2.ourdomain.de: [NO_DATA] The requested name is valid but does 
not have an IP address.
Thu Mar 20 14:57:54 2008 TCP/UDP: Closing socket
Thu Mar 20 14:57:54 2008 SIGUSR1[soft,init_instance] received, process 
restarting
Thu Mar 20 14:57:54 2008 Restart pause, 2 second(s)
Thu Mar 20 14:57:56 2008 WARNING: No server certificate verification 
method has been enabled.  See http://openvpn.net/howto.html#mitm for 
more info.
Thu Mar 20 14:57:56 2008 Re-using SSL/TLS context
Thu Mar 20 14:57:56 2008 LZO compression initialized
Thu Mar 20 14:57:56 2008 Control Channel MTU parms [ L:1542 D:166 EF:66 
EB:0 ET:0 EL:0 ]
Thu Mar 20 14:58:13 2008 RESOLVE: Cannot resolve host address: random: 
[HOST_NOT_FOUND] The specified host is unknown.
Thu Mar 20 14:58:13 2008 Data Channel MTU parms [ L:1542 D:1450 EF:42 
EB:135 ET:0 EL:0 AF:3/1 ]
Thu Mar 20 14:58:13 2008 Local Options hash (VER=V4): '504e774e'
Thu Mar 20 14:58:13 2008 Expected Remote Options hash (VER=V4): '14168603'
Thu Mar 20 14:58:30 2008 RESOLVE: Cannot resolve host address: random: 
[HOST_NOT_FOUND] The specified host is unknown.
Thu Mar 20 14:58:30 2008 TCP/UDP: Closing socket
Thu Mar 20 14:58:30 2008 SIGUSR1[soft,init_instance] received, process 
restarting
Thu Mar 20 14:58:30 2008 Restart pause, 2 second(s)
Thu Mar 20 14:58:32 2008 WARNING: No server certificate verification 
method has been enabled.  See http://openvpn.net/howto.html#mitm for 
more info.
Thu Mar 20 14:58:32 2008 Re-using SSL/TLS context
Thu Mar 20 14:58:32 2008 LZO compression initialized
Thu Mar 20 14:58:32 2008 Control Channel MTU parms [ L:1542 D:166 EF:66 
EB:0 ET:0 EL:0 ]
Thu Mar 20 14:58:47 2008 RESOLVE: Cannot resolve host address: 
openvpn1.ourdomain.de: [NO_DATA] The requested name is valid but does 
not have an IP address.
Thu Mar 20 14:58:47 2008 Data Channel MTU parms [ L:1542 D:1450 EF:42 
EB:135 ET:0 EL:0 AF:3/1 ]
Thu Mar 20 14:58:47 2008 Local Options hash (VER=V4): '504e774e'
Thu Mar 20 14:58:47 2008 Expected Remote Options hash (VER=V4): '14168603'
Thu Mar 20 14:59:02 2008 RESOLVE: Cannot resolve host address: 
openvpn1.ourdomain.de: [NO_DATA] The requested name is valid but does 
not have an IP address.
Thu Mar 20 14:59:02 2008 TCP/UDP: Closing socket
Thu Mar 20 14:59:02 2008 SIGUSR1[soft,init_instance] received, process 
restarting
Thu Mar 20 14:59:02 2008 Restart pause, 2 second(s)
Thu Mar 20 14:59:04 2008 WARNING: No server certificate verification 
method has been enabled.  See http://openvpn.net/howto.html#mitm for 
more info.
Thu Mar 20 14:59:04 2008 Re-using SSL/TLS context
Thu Mar 20 14:59:04 2008 LZO compression initialized
Thu Mar 20 14:59:04 2008 Control Channel MTU parms [ L:1542 D:166 EF:66 
EB:0 ET:0 EL:0 ]
Thu Mar 20 14:59:19 2008 RESOLVE: Cannot resolve host address: 
openvpn2.ourdomain.de: [NO_DATA] The requested name is valid but does 
not have an IP address.
Thu Mar 20 14:59:19 2008 Data Channel MTU parms [ L:1542 D:1450 EF:42 
EB:135 ET:0 EL:0 AF:3/1 ]
Thu Mar 20 14:59:19 2008 Local Options hash (VER=V4): '504e774e'
Thu Mar 20 14:59:19 2008 Expected Remote Options hash (VER=V4): '14168603'

# Here I killed the connection manually #

Thu Mar 20 14:59:34 2008 RESOLVE: signal received during DNS resolution 
attempt
Thu Mar 20 14:59:34 2008 TCP/UDP: Closing socket
Thu Mar 20 14:59:34 2008 route DELETE 19.17.63.67 MASK 255.255.255.255 
a.b.c.d
Thu Mar 20 14:59:34 2008 route DELETE 0.0.0.0 MASK 128.0.0.0 13.22.227.1
Thu Mar 20 14:59:35 2008 route DELETE 128.0.0.0 MASK 128.0.0.0 13.22.227.1
Thu Mar 20 14:59:35 2008 Closing TUN/TAP interface
Thu Mar 20 14:59:35 2008 SIGTERM[hard,init_instance] received, process 
exiting


Greetz, Marcus

