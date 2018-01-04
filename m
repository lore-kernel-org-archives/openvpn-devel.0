From: Tom Kunz <tkunz@...2030...>
Message-ID: <7f72b2de-f411-c4a0-bd1e-f343543cb8e2@...2030...>
Date: Thu, 4 Jan 2018 17:49:25 -0500
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] OVPN vs IPSec performance as a transport
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

I have been testing OVPN 2.4.4 vs StrongSwan IPSec, to be used as
transport, and I have found something that I think might be a
performance issue.=C2=A0 I have 3 linux boxes, A, B, and C.=C2=A0 All inter=
faces
are 1Gbps.=C2=A0 Each has an interface to the next one downstream:

A - eth0=3D10.10.10.10/24 and eth1=3D172.16.0.10/24

B - eth0=3D172.16.0.11/24 and eth1=3D172.30.0.11/24

C - eth0=3D172.30.0.10/24 and eth1=3D192.168.168.10/24

Packets route as usual through this with no encryption, and throughput
from A to C is at wire speed.=C2=A0 With IPSec between A&B, from
172.16.0.10-172.16.0.11, I can still get wire speed from A to C.=C2=A0 Then=
 I
turn off IPSec, and I setup A as the server and B as the client, with
A's config being:

=3D=3D=3D=3D=3D

dev tun

topology subnet
server 172.17.0.0 255.255.255.0
port 1194
proto udp
dh /etc/openvpn/keys/dh2048.pem
ca /etc/openvpn/keys/ca.crt
cert /etc/openvpn/keys/server.crt
key /etc/openvpn/keys/server.key
verb 3
keepalive 10 45
cipher aes-256-cbc
comp-lzo

tun-mtu 50000

mssfix 0

fragment 0

client-config-dir ccd

push "route 10.10.10.0 255.255.255.0"

=3D=3D=3D=3D=3D

and the client B config file is

=3D=3D=3D=3D=3D

verb 3
client
cipher AES-256-CBC
comp-lzo
tun-mtu 50000
mssfix 0
fragment 0
remote 172.16.0.10=C2=A0 1194

dev tun
redirect-private local
tls-client

ca /etc/openvpn/keys/ca.crt
cert /etc/openvpn/keys/client1.crt
key /etc/openvpn/keys/client1.key

=3D=3D=3D=3D=3D

and I setup static routes on each side so that traffic is going through
the tunnel from A to C and vice versa.

I can pass traffic over this link, however when I do tests for speed, I
am only getting about 200Mbps instead of 1Gbps.

The funny thing is, I know that each of these machines can easily do
1Gbps.=C2=A0 If I do my performance test from A to B, over the above ovpn
configs, I can get just over 1Gbps because of the MTU overhead being
removed. But as soon as I have it make the leap downstream once more, I
lose 80+% of the speed.=C2=A0 And again, both non-encrypted traffic and IPS=
ec
do the exact same test at wire speed or just slightly under wire speed.

The way I do a speed test is on A:

# nc -l -p 5555 > /dev/null

and over on C:

# dd if=3D/dev/urandom of=3Dblob.random.1G bs=3D10M count=3D100

# time cat blob.random.1G | nc 10.10.10.10 5555

tcpdumps over each interface confirm traffic is flowing in the expected
fashion.

Over unencrypted or IPSec, I am looking at about 4s to move 1G of data
from one end to the other, and with ovpn, 15-22s.=C2=A0 The machines involv=
ed
are 2 Dell R720's with 8+G ram and a homebrew machine with several Xeons
and 32G RAM.=C2=A0 Network cards involved are a mix of BCM Tigon3 "tg3"
driver and IGB driver gigabit NICs.

Anyone have any suggestions or thoughts as to why the big perf decrease
and what might be done to improve it?

Thanks,=C2=A0

Tom




