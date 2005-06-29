Message-ID: <42C29B31.4010202@...428...>
From: Hartmut Goebel <h.goebel@...428...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Status and Roadmap for IPv6 Support
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
Date: Wed Jun 29 05:58:29 2005
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hello,

I plan writing an article about using OpenVPN for tunneling IPv6.
Thatfor some more information about the current status would help
descriping the benefits of OpenVPN more precisely.

1) Current status

1a) As far as I've found out, OpenVPN 2.0 supports forwarding IPv6 when
using tun+tun-ipv6 or tap. But neither of the build-in commands (like
route, ifconfig, server, push/pull) supprot IPv6-addresses or IPv6
Name-lookup.

Is this correct, or have I overlooked something?

1b) Since one has to set up IPv6 manually (due to 1a): What is the
benefit of using tun+tun-ipv6 instead of tap? I assume the first alows
for using current IPv4 support, while the later requires me to set up
IPv4 manually (in addition of setting up IPv6 manually).

2) "merge JuanJo Ciarlante's IPv6 patch"

Thw wiki-wishlist states this as a topic. I've not found this path yet.
What does it enhance/fix/enable?

3) Roadmap, further plans for IPv6

What is the roadmap to improofing IPv6-support? What topics, which
release, which timeline?


Thanks for your answers in advance!

--=20
Sch=F6nen Gru=DF - Regards
Hartmut Goebel

| Hartmut Goebel             | IT-Security -- effizient |
| h.goebel@...428... | www.goebel-consult.de    |

