Mime-Version: 1.0 (Apple Message framework v618)
Message-Id: <63F22839-BBAB-11D8-9014-000A95B96B84@...228...>
From: Jon Bendtsen <jon.bendtsen@...228...>
Subject: [Openvpn-devel] Bug: openvpn2.0beta4 reproduceable - windows does not get its old default route back
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Jun 12 09:22:48 2004
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I'm not on this list, so if you want to talk to me, include my email or 
catch me on the users list.
I found something i consider a bug, and i can reproduce it every time i 
try.
I have only tried with openvpn 2.0 beta4 for windows.

The problem only arrives when i force the closure of the client. If it 
is allowed to time out, it works
as it should.
I run a script like this:
aragorn:/etc/openvpn/windows# cat start-vpn-tunnel.bat
openvpn.exe --askpass --config laerdal.vpn
pause

aragorn:/etc/openvpn/windows# cat laerdal.vpn
#########################################
# Sample client-side OpenVPN config file
# for connecting to multi-client server.
#
# The server can be pinged at 10.8.0.1.
#
# This configuration can be used by multiple
# clients, however each client should have
# its own cert and key files.
#
# tun-style tunnel

port 5000
dev tun
remote <server address>

# TLS parms

tls-client
ca ca.crt
cert _-USER-_.crt
key _-USER-_.key

# This parm is required for connecting
# to a multi-client server.  It tells
# the client to accept options which
# the server pushes to us.
pull

verb 1


When i use the x button in the top right corner of the 
start-vpn-tunnel.bat window, windows no longer have a default route, 
leaving the computer unuseable :(


aragorn:/etc/openvpn# cat remotevpn.conf
########################################
# Sample OpenVPN config file for
# multi-client udp server
#
# tun-style tunnel
#
# modified by Jon Bendtsen to fit Laerdal's case of remote windows users
# and local wifi windows users.

# bind to the "public" interface
local 192.168.1.2
port 5000
dev tun

# TLS parms

tls-server
ca /etc/openvpn/ca.crt
cert /etc/openvpn/aragorn_remotevpn.crt
key /etc/openvpn/aragorn_remotevpn.key
dh /etc/openvpn/dh1024.pem
crl-verify /etc/openvpn/bad-certificates-crl.pem

# Tell OpenVPN to be a multi-client udp server
mode server

# openvpn data are not swapped to disk
mlock

# allow clients to connect to each other faster
client-to-client

# The server's virtual endpoints
ifconfig 10.8.0.1 10.8.0.2

# Pool of /30 subnets to be allocated to clients.
# When a client connects, an --ifconfig command
# will be automatically generated and pushed back to
# the client.
ifconfig-pool 10.8.0.4 10.8.0.255

# Push route to client to bind it to our local
# virtual endpoint.
push "route 10.8.0.1 255.255.255.255"

# Delete client instances after some period of inactivity.
inactive 600

# ping once every minute when there is no trafic
ping 60

# Route the --ifconfig pool range into the OpenVPN server.
route 10.8.0.0 255.255.255.0

# The server doesn't need privileges
user nobody
group nogroup

# options pushed to the windows clients.
push "ping 60"
push "inactive 600"
push "redirect-gateway local"
#push "redirect-gateway"
push "ip-win32 dynamic"
push "tap-sleep 4"
push "dhcp-option DNS 192.168.119.131"
push "dhcp-option WINS 192.168.119.131"
push "dhcp-option NTP 192.168.119.131"
push "dhcp-option NBT 2"
push "dhcp-option DOMAIN laerdal.global"
# Set NetBIOS over TCP/IP Node type. 2 = p-node (point-to-point name 
queries to a WINS server
#################################################


i have tried if this problem also arrives with	push "redirect-gateway"
and it does. If i close the window, the old default gateway is never 
restored.



JonB


