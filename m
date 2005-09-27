From: Marcelo Toledo <marcelo@...461...>
Message-Id: <1127848987.6861.117.camel@...399...>
Mime-Version: 1.0
Subject: [Openvpn-devel] 400 vpn clients 20% of them loosing the route frequently
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
Date: Tue Sep 27 12:24:43 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I have one OpenVPN server version 2.0.2 using TCP port 1194 with TLS
with about 400 clients connected to it. From time to time it's
impossible to ping the client from the server, but if you log into the
client and ping the server, the server now became able to ping the
client. I made a lot of tests removing the bridge and trying a older
versions of openvpn and the problem still hapenning with about 20% of
the clients connected to the vpn.

here is the config of the client and server:

# SERVER CONFIG
mode server
port 1194
proto tcp-server
dev tap
tls-server
ca keys/ca.crt
cert keys/sauron.crt
key keys/sauron.key
dh keys/dh1024.pem
#tls-auth keys/ta.key 0
#ifconfig 10.100.0.2 255.255.0.0
#ifconfig-pool 10.100.99.50 10.100.99.100 255.255.0.0
server-bridge 10.100.0.10 255.255.0.0 10.100.99.100 10.100.255.254
push "dhcp-option DNS 200.160.255.85"
push "dhcp-option DNS 200.160.255.84"
push "ping 10"
push "ping-restart 60"
client-config-dir config
client-to-client
keepalive 10 120
comp-lzo
max-clients 1024
persist-key
persist-tun
status openvpn-status.log
log openvpn.log
verb 2
##########

# CLIENT CONFIG
client
tls-client
dev tap
proto tcp-client
#remote-random
remote 200.160.255.100
#remote vpn1.vexbr.com.br
#remote vpn2.vexbr.com.br
rport 1194
lport 9000
resolv-retry infinite
persist-key
persist-tun
mute-replay-warnings
float
ping 10
ping-restart 60
comp-lzo
verb 4
ca keys/ca.crt
up ./vexbr.up
cert keys/escritorio-claro.crt
key keys/escritorio-claro.key
#############
-- 
Marcelo Toledo <marcelo@...461...>


