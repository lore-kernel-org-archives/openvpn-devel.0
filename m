Message-ID: <46E7AEF9.1000107@...277...>
Date: Wed, 12 Sep 2007 11:18:49 +0200
From: Pieter Temmerman <pieter.temmerman@...277...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070707060601090401040109"
Subject: [Openvpn-devel] Connection stalls if more than one client is
	connected
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------070707060601090401040109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All.

I successfully setup my OpenVPN environment to connect from home to the 
office. (Congrats for the tool by the way, I love it).
When I am the only connected person, then the connection works 
flawlessly, however, as soon as another person starts using the VPN at 
the same time (with different account),
both our connections start stalling. This is, I am not able anymore to 
contact any service on our corporate network and I see the VPN client 
gets a timeout and reconnects to the server after about 1 minute. After 
this, the connection works again for a minute or less and the same thing 
happens.
One thing I noticed is that when my VPN connection stalls, I cannot even 
connect to the VPN server machine with ssh (not over VPN). As soon as  
close my VPN client, I can connect to the VPN server again over SSH (no 
VPN). This is not something related to my machine, since I was able to 
reproduce from different machines.
We are using a 2Mbit synchrone DSL connection, which should be more than 
enough to let two people connect to a webserver over VPN.
Please find attached my server.conf and client.conf files for your 
convenience.

I have been looking at logs and tcpdumps for days now, and I have 
absolutely no clue where the problem might be coming from.
Any help would be kindly appreciated.

Kind Regards,

Pieter

--------------070707060601090401040109
Content-Type: text/plain;
 name="server.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="server.conf"

# Listening address
local 192.168.200.2
# Which TCP/UDP port should OpenVPN listen on?
port 5000
# TCP or UDP server?
proto udp
# "dev tun" will create a routed IP tunnel, "dev tap" will create
# an ethernet tunnel.
# Use "dev tap0" if you are ethernet bridging and have precreated
# a tap0 virtual interface and bridged it with your ethernet
# interface.
# On non-Windows systems, you can give
# an explicit unit number, such as tun0.
# On Windows, use "dev-node" for this.
# On most systems, the VPN will not function
# unless you partially or fully disable
# the firewall for the TUN/TAP interface.
;dev tap
dev tun0
# SSL/TLS root certificate (ca), certificate (cert), and private
# key (key). Each client and the server must have their own cert
# and key file. The server and all clients will use the same ca
#file.
ca ca.crt
cert server.crt
key /etc/openvpn/server.key # This file should be kept secret
# Diffie hellman parameters.
dh dh2048.pem
# Configure server mode and supply a VPN subnet
# for OpenVPN to draw client addresses from.
# The server will take 10.8.0.1 for itself, the rest will be made
# available to clients.
# Comment this line out if you are ethernet bridging. See the man
# page for info.
server 10.8.0.0 255.255.255.0
# Maintain a record of client <-> virtual IP address
# associations in this file. If OpenVPN goes down or
# is restarted, reconnecting clients can be assigned
# the same virtual IP address from the pool that was
# previously assigned.
ifconfig-pool-persist ipp.txt
# Push routes to the client to allow it to reach other private
# subnets behind the server. Remember that these private subnets
# will also need to know to route the OpenVPN client address pool
# (10.8.0.0/255.255.255.0) back to the OpenVPN server.
push "route 192.168.1.0 255.255.255.0"
# The keepalive directive causes ping-likemessages to be sent back
# and forth over the link so that each side knows when the other
# side has gone down. Ping every 10 seconds, assume that remote
# peer is down if no ping received during a 120 second time
# period.
keepalive 10 120
# Select a cryptographic cipher. This config item must be copied
# to the client config file as well.
cipher BF-CBC        # Blowfish (default)
# Enable compression on the VPN link.
# If you enable it here, you must also enable it in the client
# config file.
comp-lzo
# The maximum number of concurrently connected clients we want to
# allow.
max-clients 15
# Allow client to see eachother
client-to-client
#Allow clients to connect from different IPs
float
#Run the server inside a chroot for security reasons
chroot /etc/openvpn/serverChroot
# It's a good idea to reduce the OpenVPN daemon's privileges after
# initialization.
user nobody
group nobody
# The persist options will try to avoid
# accessing certain resources on restart
# that may no longer be accessible because
# of the privilege downgrade.
persist-key
persist-tun
# If a tls-auth key is used on the server
# then every client must also have the key.
# value should be 0 on server and 1 on client.
;tls-auth ta.key 0
# Output a short status file showing
# current connections, truncated
# and rewritten every minute.
status openvpn-status.log
# By default, log messages will go to the syslog (or
# on Windows, if running as a service, they will go to
# the "\Program Files\OpenVPN\log" directory).
# Use log or log-append to override this default.
log-append openvpn.log
# Set the appropriate level of log file verbosity.
# 0 is silent, except for fatal errors
# 4 is reasonable for general usage
# 5 and 6 can help to debug connection problems
# 9 is extremely verbose
verb 3


--------------070707060601090401040109
Content-Type: text/plain;
 name="client.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="client.conf"

# Specify that we are a client and that we
# will be pulling certain config file directives
# from the server.
client
# Use the same setting as you are using on
# the server.
# On most systems, the VPN will not function
# unless you partially or fully disable
# the firewall for the TUN/TAP interface.
;dev tap
dev tun
# Are we connecting to a TCP or UDP server?
# Use the same setting as
# on the server.
;proto tcp
proto udp
# The hostname/IP and port of the server.
# You can have multiple remote entries
# to load balance between the servers.
remote 1.2.3.4 5000
# Most clients don't need to bind to
# a specific local port number.
nobind
# Downgrade privileges after initialization (non-Windows only)
user nobody
group nogroup
# Try to preserve some state across restarts.
persist-key
persist-tun
# SSL/TLS parms.
# It's best to use a separate .crt/.key file pair
# for each client. A single ca
# file can be used for all clients.
ca /etc/openvpn/keys/ca.crt
cert /etc/openvpn/keys/USERNAME.crt
key /etc/openvpn/USERNAME.key
#Enable TLS Authentification
;tls-auth /etc/openvpn/keys/ta.key 1
# Enable compression on the VPN link.
# Don't enable this unless it is also
# enabled in the server config file.
comp-lzo
# Set log file verbosity.
verb 3


--------------070707060601090401040109--

