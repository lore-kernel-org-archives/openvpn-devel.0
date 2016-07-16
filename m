From: "streampp" <streampp@...2153...>
Date: Sat, 16 Jul 2016 20:45:03 +0300
Message-Id: <1468691103.727067.3678.7414@...2154...>
MIME-Version: 1.0
Subject: [Openvpn-devel] net6_gateway feature request
Reply-To: streampp <streampp@...2153...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net


Hello openvpn developers,

First of all, many thanks for such a great product.

I am wondering, is it possible to get something like "net6_gateway" paramet=
er for pushing routes to client?

The problem is the following. I have a dual stack IPv4/IPv6 ethernet connec=
tion to my ISP. So I have native working IPv4 and IPv6.
I have a remote OpenVPN server and I would like to route all my IPv4 and IP=
v6 traffic (except some networks) trough that OpenVPN.
I'm connecting to my remote OpenVPN server via IPv4. On openvpn-server.conf=
 I have something like:

push "route 10.0.0.0 255.0.0.0 net_gateway"
push "route 172.16.0.0 255.240.0.0 net_gateway"
push "route 192.168.0.0 255.255.0.0 net_gateway"

with works perfect and my IPv4 gateway replaces "net_gateway" parameter, so=
 with IPv4 everything is fine.

But... I want same thing for IPv6:

push "route-ipv6 fc00::/64 net_gateway" and that is not working, because ne=
t_gateway represents IPv4 gateway...

Can you do something like "net6_gateway" variable for such cases?=20
You may say, that "hey, dude, just do 2 server configs, one for IPv4 and on=
e for IPv6", and I answer - no, I can't. Because at home I have dual stack =
IPv4/IPv6 network, and on Internet cafe or in a hotel I may not :(

So, any help would be appreciated, Many thanks.

streampp.
