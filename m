From: Matteo Latini <m.latini@...1502...>
Date: Wed, 14 Sep 2011 15:42:06 +0200
Message-Id: <C8EBC1CC-8304-4A97-A2C6-DE114CB05EFF@...1502...>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Subject: [Openvpn-devel] Info on internal routes aging and
	MULTI_ROUTE_AGEABLE
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,
we (openwisp.it) are an open source wireless ISP using openvpn's tap device=
s=20
to bridge access points with our main servers.

We recently ran into a problem with openvpn's internal routing table gettin=
g filled up by "old and stale" routes.
Some routes are kept for months (till the vpn gets restarted). This and the=
 --max-routes-per-client option makes
the internal routing table fill up and never let newer clients add new inte=
rnal routes.

Since we were unable to find a way to clean stale routes by reading the man=
pages, we began exploring openvpn's
code to create a patch that would clean old and inactive routes. The patch =
is working but, by looking through code,
we found some reference to MULTI_ROUTE_AGEABLE and ageable_ttl_secs in the =
multi_route_defined method (multi.h).

Are those in any way meant to clean, in any way (maybe yet to implement), a=
ged routes?
We tried using multi_route_defined to keep track of such routes without suc=
cess.

Should we keep trying with MULTI_ROUTE_AGEABLE or find other ways (we imple=
mented the patch by using a dedicated
timer that triggers a function that does something similar to what happens =
on teardown)?

We are currently patching OpenVPN 2.1.0


Regards,
Matteo Latini
