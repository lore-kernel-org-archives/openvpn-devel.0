From: "Stephen Gerstacker" <sgerstacker@...996...>
Date: Wed, 20 Dec 2006 15:00:00 -0500
Message-ID: <008701c72471$6f6d58d0$4e480a70$@com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0088_01C72447.869750D0"
Content-Language: en-us
Sender: "Stephen Gerstacker" <sgerstacker@...996...>
Subject: [Openvpn-devel] Potentially Obscure Bug
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multipart message in MIME format.

------=_NextPart_000_0088_01C72447.869750D0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

I apologize ahead of time, but I've posted this multiple times on the 
OpenVPN-Users list as well as the forum and no one has said a word to me 
about fixing my problem.  I'm getting desperate and I'm going insane because
of this problem.


The Problem
-----------
When I VPN in, I can ping everything on my network.  I can SSH into my UNIX
boxes.  I can connect to web servers running on my internal machines.  When
I attempt to connect to a Windows share, nothing happens for about 3
minutes.  I am then presented with a Windows authentication dialog.  I can't
type in my current credentials because Windows is awesome and won't let you
try them again.  Trying other credentials does nothing.

I also found that if I hit a site hosted on an IIS server that requires
authentication, the web browser tries for about 3 minutes and then gives a
'page cannot be displayed error'.

This leads me to believe that something is being lost with the
authentication protocol.


The Setup
---------
This originally started happening with an OpenVPN 2.0.6 server running on
OpenBSD 3.8.  The clients were using Windows XP SP2 with I believe the 2.0.6
GUI client.

I've since upgraded and tried many different configurations, including:

* OpenVPN 2.0.9 server on OpenBSD 3.8
* OpenVPN 2.0.9 server on OpenBSD 4.0
* OpenVPN 2.0.9 client
* OpenVPN 2.0.9 server on Ubuntu Edgy

The weirdest part is that with the original configuration worked for 6
months and then spontaneously stopped working.  My guess is that a Windows
patch killed it, but I'm surprised that no one else has experienced this.

I've attached my current configuration files.  This is for the 2.0.9 client
GUI, 2.0.9 server on Edgy behind an OpenBSD 4.0 firewall.  The log from the
client is also provided.

Our network's subnet is 192.168.1.0/24 and our VPN subnet is
192.168.10.0/24.

Again, please help.

Stephen Gerstacker
Sr. Database Developer
Electronic Data Payment Systems
p: 866.578.9740 x114
f: 866.578.9740


------=_NextPart_000_0088_01C72447.869750D0
Content-Type: application/octet-stream;
	name="client.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="client.log"

Tue Dec 12 22:56:35 2006 OpenVPN 2.0.9 Win32-MinGW [SSL] [LZO] built on =
Oct  1 2006
Tue Dec 12 22:56:39 2006 IMPORTANT: OpenVPN's default port number is now =
1194, based on an official port number assignment by IANA.  OpenVPN =
2.0-beta16 and earlier used 5000 as the default port.
Tue Dec 12 22:56:39 2006 WARNING: No server certificate verification =
method has been enabled.  See http://openvpn.net/howto.html#mitm for =
more info.
Tue Dec 12 22:56:39 2006 LZO compression initialized
Tue Dec 12 22:56:39 2006 Control Channel MTU parms [ L:1542 D:138 EF:38 =
EB:0 ET:0 EL:0 ]
Tue Dec 12 22:56:39 2006 Data Channel MTU parms [ L:1542 D:1450 EF:42 =
EB:135 ET:0 EL:0 AF:3/1 ]
Tue Dec 12 22:56:39 2006 Local Options hash (VER=3DV4): '41690919'
Tue Dec 12 22:56:39 2006 Expected Remote Options hash (VER=3DV4): =
'530fdded'
Tue Dec 12 22:56:39 2006 UDPv4 link local: [undef]
Tue Dec 12 22:56:39 2006 UDPv4 link remote: 63.239.190.203:1194
Tue Dec 12 22:56:40 2006 TLS: Initial packet from 63.239.190.203:1194, =
sid=3D95131adf 0170e063
Tue Dec 12 22:56:41 2006 VERIFY OK: depth=3D1, =
/C=3DUS/ST=3DOhio/L=3DDover/O=3DElectronic_Data_Payment_Systems/CN=3Drose=
ncrantz/emailAddress=3Dsgerstacker@...996...
Tue Dec 12 22:56:41 2006 VERIFY OK: depth=3D0, =
/C=3DUS/ST=3DOhio/O=3DElectronic_Data_Payment_Systems/CN=3Dserver/emailAd=
dress=3Dsgerstacker@...996...
Tue Dec 12 22:56:45 2006 Data Channel Encrypt: Cipher 'BF-CBC' =
initialized with 128 bit key
Tue Dec 12 22:56:45 2006 Data Channel Encrypt: Using 160 bit message =
hash 'SHA1' for HMAC authentication
Tue Dec 12 22:56:45 2006 Data Channel Decrypt: Cipher 'BF-CBC' =
initialized with 128 bit key
Tue Dec 12 22:56:45 2006 Data Channel Decrypt: Using 160 bit message =
hash 'SHA1' for HMAC authentication
Tue Dec 12 22:56:45 2006 Control Channel: TLSv1, cipher TLSv1/SSLv3 =
DHE-RSA-AES256-SHA, 2048 bit RSA
Tue Dec 12 22:56:45 2006 [server] Peer Connection Initiated with =
63.239.190.203:1194
Tue Dec 12 22:56:46 2006 SENT CONTROL [server]: 'PUSH_REQUEST' =
(status=3D1)
Tue Dec 12 22:56:46 2006 PUSH: Received control message: =
'PUSH_REPLY,route 192.168.1.0 255.255.255.0,redirect-gateway,dhcp-option =
DNS 192.168.1.3,dhcp-option WINS 192.168.1.3,route 10.8.0.0 =
255.255.255.0,ping 10,ping-restart 120,ifconfig 10.8.0.10 10.8.0.9'
Tue Dec 12 22:56:46 2006 OPTIONS IMPORT: timers and/or timeouts modified
Tue Dec 12 22:56:46 2006 OPTIONS IMPORT: --ifconfig/up options modified
Tue Dec 12 22:56:46 2006 OPTIONS IMPORT: route options modified
Tue Dec 12 22:56:46 2006 OPTIONS IMPORT: --ip-win32 and/or --dhcp-option =
options modified
Tue Dec 12 22:56:46 2006 TAP-WIN32 device [Local Area Connection] =
opened: \\.\Global\{492CF7EE-DE31-4B55-A125-CD396A5DEE12}.tap
Tue Dec 12 22:56:46 2006 TAP-Win32 Driver Version 8.4=20
Tue Dec 12 22:56:46 2006 TAP-Win32 MTU=3D1500
Tue Dec 12 22:56:46 2006 Notified TAP-Win32 driver to set a DHCP =
IP/netmask of 10.8.0.10/255.255.255.252 on interface =
{492CF7EE-DE31-4B55-A125-CD396A5DEE12} [DHCP-serv: 10.8.0.9, lease-time: =
31536000]
Tue Dec 12 22:56:46 2006 Successful ARP Flush on interface [6] =
{492CF7EE-DE31-4B55-A125-CD396A5DEE12}
Tue Dec 12 22:56:46 2006 TEST ROUTES: 0/0 succeeded len=3D2 ret=3D0 =
a=3D0 u/d=3Ddown
Tue Dec 12 22:56:46 2006 Route: Waiting for TUN/TAP interface to come =
up...
Tue Dec 12 22:56:48 2006 TEST ROUTES: 0/0 succeeded len=3D2 ret=3D0 =
a=3D0 u/d=3Ddown
Tue Dec 12 22:56:48 2006 Route: Waiting for TUN/TAP interface to come =
up...
Tue Dec 12 22:56:49 2006 TEST ROUTES: 3/3 succeeded len=3D2 ret=3D1 =
a=3D0 u/d=3Dup
Tue Dec 12 22:56:49 2006 route ADD 63.239.190.203 MASK 255.255.255.255 =
192.168.1.254
Tue Dec 12 22:56:49 2006 Route addition via IPAPI succeeded
Tue Dec 12 22:56:49 2006 route DELETE 0.0.0.0 MASK 0.0.0.0 192.168.1.254
Tue Dec 12 22:56:49 2006 Route deletion via IPAPI succeeded
Tue Dec 12 22:56:49 2006 route ADD 0.0.0.0 MASK 0.0.0.0 10.8.0.9
Tue Dec 12 22:56:49 2006 Route addition via IPAPI succeeded
Tue Dec 12 22:56:49 2006 route ADD 192.168.1.0 MASK 255.255.255.0 =
10.8.0.9
Tue Dec 12 22:56:49 2006 Route addition via IPAPI succeeded
Tue Dec 12 22:56:49 2006 route ADD 10.8.0.0 MASK 255.255.255.0 10.8.0.9
Tue Dec 12 22:56:49 2006 Route addition via IPAPI succeeded
Tue Dec 12 22:56:49 2006 Initialization Sequence Completed
Tue Dec 12 22:57:13 2006 Replay-window backtrack occurred [1]
Tue Dec 12 23:08:17 2006 TCP/UDP: Closing socket
Tue Dec 12 23:08:17 2006 route DELETE 10.8.0.0 MASK 255.255.255.0 =
10.8.0.9
Tue Dec 12 23:08:17 2006 Route deletion via IPAPI succeeded
Tue Dec 12 23:08:17 2006 route DELETE 192.168.1.0 MASK 255.255.255.0 =
10.8.0.9
Tue Dec 12 23:08:17 2006 Route deletion via IPAPI succeeded
Tue Dec 12 23:08:17 2006 route DELETE 63.239.190.203 MASK =
255.255.255.255 192.168.1.254
Tue Dec 12 23:08:17 2006 ROUTE: route deletion failed using =
DeleteIpForwardEntry: The parameter is incorrect. =20
Tue Dec 12 23:08:17 2006 Route deletion via IPAPI failed
Tue Dec 12 23:08:17 2006 route DELETE 0.0.0.0 MASK 0.0.0.0 10.8.0.9
Tue Dec 12 23:08:17 2006 Route deletion via IPAPI succeeded
Tue Dec 12 23:08:17 2006 route ADD 0.0.0.0 MASK 0.0.0.0 192.168.1.254
Tue Dec 12 23:08:17 2006 Route addition via IPAPI succeeded
Tue Dec 12 23:08:17 2006 Closing TUN/TAP interface
Tue Dec 12 23:08:17 2006 SIGTERM[hard,] received, process exiting

------=_NextPart_000_0088_01C72447.869750D0
Content-Type: application/octet-stream;
	name="client.ovpn"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="client.ovpn"

##############################################
# Sample client-side OpenVPN 2.0 config file #
# for connecting to multi-client server.     #
#                                            #
# This configuration can be used by multiple #
# clients, however each client should have   #
# its own cert and key files.                #
#                                            #
# On Windows, you might want to rename this  #
# file so it has a .ovpn extension           #
##############################################

# Specify that we are a client and that we
# will be pulling certain config file directives
# from the server.
client
auth-user-pass

# Use the same setting as you are using on
# the server.
# On most systems, the VPN will not function
# unless you partially or fully disable
# the firewall for the TUN/TAP interface.
;dev tap
dev tun

# Windows needs the TAP-Win32 adapter name
# from the Network Connections panel
# if you have more than one.  On XP SP2,
# you may need to disable the firewall
# for the TAP adapter.
;dev-node MyTap

# Are we connecting to a TCP or
# UDP server?  Use the same setting as
# on the server.
;proto tcp
proto udp

# The hostname/IP and port of the server.
# You can have multiple remote entries
# to load balance between the servers.
remote office.provantagefinance.com 1194
;remote my-server-2 1194

# Choose a random host from the remote
# list for load-balancing.  Otherwise
# try hosts in the order specified.
;remote-random

# Keep trying indefinitely to resolve the
# host name of the OpenVPN server.  Very useful
# on machines which are not permanently connected
# to the internet such as laptops.
resolv-retry infinite

# Most clients don't need to bind to
# a specific local port number.
nobind

# Downgrade privileges after initialization (non-Windows only)
;user nobody
;group nobody

# Try to preserve some state across restarts.
persist-key
persist-tun

# If you are connecting through an
# HTTP proxy to reach the actual OpenVPN
# server, put the proxy server/IP and
# port number here.  See the man page
# if your proxy server requires
# authentication.
;http-proxy-retry # retry on connection failures
;http-proxy [proxy server] [proxy port #]

# Wireless networks often produce a lot
# of duplicate packets.  Set this flag
# to silence duplicate packet warnings.
;mute-replay-warnings

# SSL/TLS parms.
# See the server config file for more
# description.  It's best to use
# a separate .crt/.key file pair
# for each client.  A single ca
# file can be used for all clients.
ca ca.crt
cert sgerstacker.crt
key sgerstacker.key

# Verify server certificate by checking
# that the certicate has the nsCertType
# field set to "server".  This is an
# important precaution to protect against
# a potential attack discussed here:
#  http://openvpn.net/howto.html#mitm
#
# To use this feature, you will need to generate
# your server certificates with the nsCertType
# field set to "server".  The build-key-server
# script in the easy-rsa folder will do this.
;ns-cert-type server

# If a tls-auth key is used on the server
# then every client must also have the key.
;tls-auth ta.key 1

# Select a cryptographic cipher.
# If the cipher option is used on the server
# then you must also specify it here.
;cipher x

# Enable compression on the VPN link.
# Don't enable this unless it is also
# enabled in the server config file.
comp-lzo

# Set log file verbosity.
verb 3

# Silence repeating messages
;mute 20

------=_NextPart_000_0088_01C72447.869750D0
Content-Type: application/octet-stream;
	name="server.conf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="server.conf"

# Which local IP address should OpenVPN=0A=
# listen on? (optional)=0A=
local 192.168.1.4=0A=
=0A=
# Which TCP/UDP port should OpenVPN listen on?=0A=
# If you want to run multiple OpenVPN instances=0A=
# on the same machine, use a different port=0A=
# number for each one.  You will need to=0A=
# open up this port on your firewall.=0A=
port 1194=0A=
=0A=
# TCP or UDP server?=0A=
;proto tcp=0A=
proto udp=0A=
=0A=
# "dev tun" will create a routed IP tunnel,=0A=
# "dev tap" will create an ethernet tunnel.=0A=
# Use "dev tap0" if you are ethernet bridging=0A=
# and have precreated a tap0 virtual interface=0A=
# and bridged it with your ethernet interface.=0A=
# If you want to control access policies=0A=
# over the VPN, you must create firewall=0A=
# rules for the the TUN/TAP interface.=0A=
# On non-Windows systems, you can give=0A=
# an explicit unit number, such as tun0.=0A=
# On Windows, use "dev-node" for this.=0A=
# On most systems, the VPN will not function=0A=
# unless you partially or fully disable=0A=
# the firewall for the TUN/TAP interface.=0A=
;dev tap0=0A=
dev tun=0A=
=0A=
# Windows needs the TAP-Win32 adapter name=0A=
# from the Network Connections panel if you=0A=
# have more than one.  On XP SP2 or higher,=0A=
# you may need to selectively disable the=0A=
# Windows firewall for the TAP adapter.=0A=
# Non-Windows systems usually don't need this.=0A=
;dev-node MyTap=0A=
=0A=
# SSL/TLS root certificate (ca), certificate=0A=
# (cert), and private key (key).  Each client=0A=
# and the server must have their own cert and=0A=
# key file.  The server and all clients will=0A=
# use the same ca file.=0A=
#=0A=
# See the "easy-rsa" directory for a series=0A=
# of scripts for generating RSA certificates=0A=
# and private keys.  Remember to use=0A=
# a unique Common Name for the server=0A=
# and each of the client certificates.=0A=
#=0A=
# Any X509 key management system can be used.=0A=
# OpenVPN can also use a PKCS #12 formatted key file=0A=
# (see "pkcs12" directive in man page).=0A=
ca /etc/openvpn/easy-rsa/keys/ca.crt=0A=
cert /etc/openvpn/easy-rsa/keys/server.crt=0A=
key /etc/openvpn/easy-rsa/keys/server.key  # This file should be kept =
secret=0A=
dh /etc/openvpn/easy-rsa/keys/dh2048.pem=0A=
=0A=
# Configure server mode and supply a VPN subnet=0A=
# for OpenVPN to draw client addresses from.=0A=
# The server will take 10.8.0.1 for itself,=0A=
# the rest will be made available to clients.=0A=
# Each client will be able to reach the server=0A=
# on 10.8.0.1. Comment this line out if you are=0A=
# ethernet bridging. See the man page for more info.=0A=
server 10.8.0.0 255.255.255.0=0A=
;server-bridge 192.168.1.4 255.255.255.0 192.168.1.201 192.168.1.210=0A=
=0A=
# Maintain a record of client <-> virtual IP address=0A=
# associations in this file.  If OpenVPN goes down or=0A=
# is restarted, reconnecting clients can be assigned=0A=
# the same virtual IP address from the pool that was=0A=
# previously assigned.=0A=
ifconfig-pool-persist ipp.txt=0A=
=0A=
# Configure server mode for ethernet bridging.=0A=
# You must first use your OS's bridging capability=0A=
# to bridge the TAP interface with the ethernet=0A=
# NIC interface.  Then you must manually set the=0A=
# IP/netmask on the bridge interface, here we=0A=
# assume 10.8.0.4/255.255.255.0.  Finally we=0A=
# must set aside an IP range in this subnet=0A=
# (start=3D10.8.0.50 end=3D10.8.0.100) to allocate=0A=
# to connecting clients.  Leave this line commented=0A=
# out unless you are ethernet bridging.=0A=
;server-bridge 10.8.0.4 255.255.255.0 10.8.0.50 10.8.0.100=0A=
=0A=
# Push routes to the client to allow it=0A=
# to reach other private subnets behind=0A=
# the server.  Remember that these=0A=
# private subnets will also need=0A=
# to know to route the OpenVPN client=0A=
# address pool (10.8.0.0/255.255.255.0)=0A=
# back to the OpenVPN server.=0A=
;push "route 10.8.0.0 255.255.255.0"=0A=
push "route 192.168.1.0 255.255.255.0"=0A=
;push "route 192.168.20.0 255.255.255.0"=0A=
=0A=
# To assign specific IP addresses to specific=0A=
# clients or if a connecting client has a private=0A=
# subnet behind it that should also have VPN access,=0A=
# use the subdirectory "ccd" for client-specific=0A=
# configuration files (see man page for more info).=0A=
=0A=
# EXAMPLE: Suppose the client=0A=
# having the certificate common name "Thelonious"=0A=
# also has a small subnet behind his connecting=0A=
# machine, such as 192.168.40.128/255.255.255.248.=0A=
# First, uncomment out these lines:=0A=
;client-config-dir ccd=0A=
;route 192.168.40.128 255.255.255.248=0A=
# Then create a file ccd/Thelonious with this line:=0A=
#   iroute 192.168.40.128 255.255.255.248=0A=
# This will allow Thelonious' private subnet to=0A=
# access the VPN.  This example will only work=0A=
# if you are routing, not bridging, i.e. you are=0A=
# using "dev tun" and "server" directives.=0A=
=0A=
# EXAMPLE: Suppose you want to give=0A=
# Thelonious a fixed VPN IP address of 10.9.0.1.=0A=
# First uncomment out these lines:=0A=
;client-config-dir ccd=0A=
;route 10.9.0.0 255.255.255.252=0A=
# Then add this line to ccd/Thelonious:=0A=
#   ifconfig-push 10.9.0.1 10.9.0.2=0A=
=0A=
# Suppose that you want to enable different=0A=
# firewall access policies for different groups=0A=
# of clients.  There are two methods:=0A=
# (1) Run multiple OpenVPN daemons, one for each=0A=
#     group, and firewall the TUN/TAP interface=0A=
#     for each group/daemon appropriately.=0A=
# (2) (Advanced) Create a script to dynamically=0A=
#     modify the firewall in response to access=0A=
#     from different clients.  See man=0A=
#     page for more info on learn-address script.=0A=
;learn-address ./script=0A=
=0A=
# If enabled, this directive will configure=0A=
# all clients to redirect their default=0A=
# network gateway through the VPN, causing=0A=
# all IP traffic such as web browsing and=0A=
# and DNS lookups to go through the VPN=0A=
# (The OpenVPN server machine may need to NAT=0A=
# the TUN/TAP interface to the internet in=0A=
# order for this to work properly).=0A=
# CAVEAT: May break client's network config if=0A=
# client's local DHCP server packets get routed=0A=
# through the tunnel.  Solution: make sure=0A=
# client's local DHCP server is reachable via=0A=
# a more specific route than the default route=0A=
# of 0.0.0.0/0.0.0.0.=0A=
push "redirect-gateway"=0A=
=0A=
# Certain Windows-specific network settings=0A=
# can be pushed to clients, such as DNS=0A=
# or WINS server addresses.  CAVEAT:=0A=
# http://openvpn.net/faq.html#dhcpcaveats=0A=
push "dhcp-option DNS 192.168.1.3"=0A=
push "dhcp-option WINS 192.168.1.3"=0A=
=0A=
# Uncomment this directive to allow different=0A=
# clients to be able to "see" each other.=0A=
# By default, clients will only see the server.=0A=
# To force clients to only see the server, you=0A=
# will also need to appropriately firewall the=0A=
# server's TUN/TAP interface.=0A=
client-to-client=0A=
=0A=
# Uncomment this directive if multiple clients=0A=
# might connect with the same certificate/key=0A=
# files or common names.  This is recommended=0A=
# only for testing purposes.  For production use,=0A=
# each client should have its own certificate/key=0A=
# pair.=0A=
#=0A=
# IF YOU HAVE NOT GENERATED INDIVIDUAL=0A=
# CERTIFICATE/KEY PAIRS FOR EACH CLIENT,=0A=
# EACH HAVING ITS OWN UNIQUE "COMMON NAME",=0A=
# UNCOMMENT THIS LINE OUT.=0A=
;duplicate-cn=0A=
=0A=
# The keepalive directive causes ping-like=0A=
# messages to be sent back and forth over=0A=
# the link so that each side knows when=0A=
# the other side has gone down.=0A=
# Ping every 10 seconds, assume that remote=0A=
# peer is down if no ping received during=0A=
# a 120 second time period.=0A=
keepalive 10 120=0A=
=0A=
# For extra security beyond that provided=0A=
# by SSL/TLS, create an "HMAC firewall"=0A=
# to help block DoS attacks and UDP port flooding.=0A=
#=0A=
# Generate with:=0A=
#   openvpn --genkey --secret ta.key=0A=
#=0A=
# The server and each client must have=0A=
# a copy of this key.=0A=
# The second parameter should be '0'=0A=
# on the server and '1' on the clients.=0A=
;tls-auth /etc/openvpn/examples/easy-rsa/keys/ta.key 0 # This file is =
secret=0A=
=0A=
# Select a cryptographic cipher.=0A=
# This config item must be copied to=0A=
# the client config file as well.=0A=
cipher BF-CBC        # Blowfish (default)=0A=
;cipher AES-128-CBC   # AES=0A=
;cipher DES-EDE3-CBC  # Triple-DES=0A=
=0A=
# Enable compression on the VPN link.=0A=
# If you enable it here, you must also=0A=
# enable it in the client config file.=0A=
comp-lzo=0A=
=0A=
# The maximum number of concurrently connected=0A=
# clients we want to allow.=0A=
;max-clients 100=0A=
=0A=
# It's a good idea to reduce the OpenVPN=0A=
# daemon's privileges after initialization.=0A=
#=0A=
# You can uncomment this out on=0A=
# non-Windows systems.=0A=
;user nobody=0A=
;group nogroup=0A=
=0A=
# The persist options will try to avoid=0A=
# accessing certain resources on restart=0A=
# that may no longer be accessible because=0A=
# of the privilege downgrade.=0A=
persist-key=0A=
persist-tun=0A=
=0A=
# Output a short status file showing=0A=
# current connections, truncated=0A=
# and rewritten every minute.=0A=
status openvpn-status.log=0A=
=0A=
# By default, log messages will go to the syslog (or=0A=
# on Windows, if running as a service, they will go to=0A=
# the "\Program Files\OpenVPN\log" directory).=0A=
# Use log or log-append to override this default.=0A=
# "log" will truncate the log file on OpenVPN startup,=0A=
# while "log-append" will append to it.  Use one=0A=
# or the other (but not both).=0A=
;log         openvpn.log=0A=
;log-append  openvpn.log=0A=
=0A=
# Set the appropriate level of log=0A=
# file verbosity.=0A=
#=0A=
# 0 is silent, except for fatal errors=0A=
# 4 is reasonable for general usage=0A=
# 5 and 6 can help to debug connection problems=0A=
# 9 is extremely verbose=0A=
verb 5=0A=
=0A=
# Silence repeating messages.  At most 20=0A=
# sequential messages of the same message=0A=
# category will be output to the log.=0A=
;mute 20=0A=
=0A=
;plugin /usr/lib/openvpn-auth-ldap.so /etc/openvpn/auth-ldap.conf=0A=
plugin /usr/lib/openvpn/openvpn-auth-pam.so login=0A=

------=_NextPart_000_0088_01C72447.869750D0--


