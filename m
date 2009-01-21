Message-ID: <497735A2.8060101@...1187...>
Date: Wed, 21 Jan 2009 15:48:02 +0100
From: Robert Fischer <rf@...1187...>
MIME-Version: 1.0
Subject: [Openvpn-devel] multiple remote directives, bad packet ID
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

We are using multiple remote parameters in order to switch to a second=20
OpenVPN instance in case the first one isn't reachable:

remote server1 8080 tcp
remote server1 1194 udp

By using just one of the above mentioned remote paramters everything=20
works perfectly.

However while testing the connection with the above order of remote=20
parameters and blocking access to tcp/8080 the following happens:

- OpenVPN tries to connect to server1:8080 via TCP which fails (as expected)
- after a few seconds OpenVPN tries to connect to server1:1194 via UDP=20
(as expected)
- the OpenVPN connection is established sucessfully, the remote network=20
is reachable, everything works just fine.
- after a little while (a few seconds to about one minute) the message

Authenticate/Decrypt packet error: bad packet ID (may be a replay): [=20
#<number> ]

appears and the tunnel stops working.

This strange error happens reproducible if both remote directives are=20
used, using just one _never_ caused any problems.

Further details:
- the client (Windows XP SP3) is using OpenVPN version 2.1_rc15=20
downloaded from openvpn.net
- the server (Linux 2.6.22) is using OpenVPN version 2.0.6.
- the server is configured with 2 OpenVPN instances, one listening at=20
the respective TCP/UDP ports, so the only difference between the two=20
server instances is the port, proto and server and status parameter.

~~~~~~~~~~~~~~~~~~~~~~
Server configuration:
~~~~~~~~~~~~~~~~~~~~~~

local           <ip address>
port            1194
proto           udp
dev             tap

ca              ca.pem
cert            certs/CServer.pem
key             keys/KServer.pem
crl-verify      crl/crl.pem
tls-auth        ta.key 0

comp-lzo
dh              dh2048.pem

server          10.162.0.0 255.255.0.0

keepalive       5 60
tun-mtu         1500
tun-mtu-extra   32
mssfix          1450
max-clients     100

user            nobody
group           nogroup

persist-key
persist-tun

status          /etc/openvpn/status.log 1
verb            3
push            "dhcp-option DNS <dns ip address>"

~~~~~~~~~~~~~~~~~~~~~~
Client configuration:
~~~~~~~~~~~~~~~~~~~~~~
client
dev tap

remote server1 8080 tcp
remote server1 1194 udp

tls-client
tls-remote <remote CN>
ca ca.pem
cert cert.pem
key key.pem
tls-auth ta.key 1
redirect-gateway
ns-cert-type server
comp-lzo
tun-mtu 1500
tun-mtu-extra 32
mssfix 1450
verb 3
route-method exe
route-delay 2


So my question would be if there are any known issues using multiple=20
remote statements (or the recently introduced "<connection>" blocks -=20
for which the same problem occurs).

Searching through the mailing list showed nothing related.

If you need any further details or debugging output, please let me know.

Thanks in advance,
Robert

mit freundlichen Gr=FC=DFen
Robert Fischer

