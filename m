MIME-Version: 1.0
From: Marco Schuster <marco@...1208...>
Date: Thu, 9 Apr 2009 00:09:22 +0200
Message-ID: <b542c8b90904081509r7da610a2oc137e4039a5a43b0@...278...>
Subject: [Openvpn-devel] Bug in OpenVPN docs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi all,

today I experimented with OpenVPN in bridged mode using a Debian NSLU2
w/ one ethernet interface, behind a NAT router.
I followed the HowTo and the bridge part at
<http://openvpn.net/index.php/documentation/miscellaneous/ethernet-bridging=
.html>.
So far, so good: As soon as the bridge was initialized, the box was
unreachable from WAN, for all services. After hours of swearing, I
found out the script and the howto miss an important point for people
with devices with only one ethernet connection which also provides
Internet access: Creating a bridge interface apparently kills off the
routing information, so in order to reach anything which is NOT in
your subnet (or be reachable from anything OUTSIDE your subnet), one
has to run "route add default gw 172.16.1.1" before anything will
work. Can someone with doc write access please add this?
I for my part will publish my network setup and my steps on my blog,
so it will at least be indexed by google ;)

Regards,
Marco

PS: The push "redirect-gateway def1 bypass-dhcp" stuff, as specified
in the sample server.conf, also doesn't work with windows clients
(which are then multi-homed): A traceroute still showed the open
hotspot AP as first hop, not the OpenVPN bridge or the NSLUs
gateway... is this a windows bug?
--=20
VMSoft GbR
Nabburger Str. 15
81737 M=C3=BCnchen
Gesch=C3=A4ftsf=C3=BChrer: Marco Schuster, Volker Hemmert
http://vmsoft-gbr.de

