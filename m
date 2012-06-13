Message-ID: <4FD86BD4.2030408@...1114...>
Date: Wed, 13 Jun 2012 12:30:44 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1339342891-28443-1-git-send-email-gert@...1296...>
In-Reply-To: <1339342891-28443-1-git-send-email-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig50B23DC7C22DFD5912D21A8A"
Subject: Re: [Openvpn-devel] some missing pieces for 2.3_alpha2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig50B23DC7C22DFD5912D21A8A
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 10/06/12 17:41, Gert Doering wrote:
> Hi,
>=20
> somewhat unexpectedly, I had two days of free time at my hand, and=20
> here are what I consider the last missing pieces for basic IPv6 support
> in 2.3_alpha2 (the route-gateway handling for IPv6), plus a bit of=20
> cleanup that crossed my way doing this.
>=20
> The code changes affect Linux iproute2, Linux ifconfig, FreeBSD and
> MacOS X (Darwin) and have been thoroughly tested on each affected OS=20
> (t_client tests with the current "official" set but now with indirect=20
> ping for test set 4 - which didn't work on those platforms before! -=20
> and manually staring at the routes).=20=20
>=20
> TAP on MacOS 5 shows some funny effects with IPv6 routes pointing to=20
> non-existant next-hops on tap interfaces, but that seems to be an=20
> operating system thing, and nothing OpenVPN can do about it.  (Well:=20
> don't install such routes, and everything works fine :) ).
>=20
> This patch set basically incorporates the work that Scott Zeid sent to=20
> the list 10 months ago (<1314694036-3749-1-git-send-email-s@...1497...>),
> but his doesn't work - on the BSDs, you can't use "-iface <dev>"
> together with a gateway spec, it must be either-or.  Nevertheless,
> thanks for this groundwork.
>=20
> Please review and ACK :-)

ACK to all.  Applied to master.

commit c37d9135a27b05ff9088ca6c349fca06de89444b
Author: Gert Doering <gert@...1296...>
Date:   Sun Jun 10 17:41:27 2012 +0200

    cleanup and redefine metric handling for IPv6 routes
=20=20=20=20
    "no metric set" is now stored as "-1"
    "metric 0" means "on-link route" (what the BSDs do)
    properly initialize metric value to "0" for on-link IPv6 net on BSDs
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1339342891-28443-2-git-send-email-gert@...1296...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6710
    Signed-off-by: David Sommerseth <davids@...1347...>

commit 3204ac73ade94fdedbed87ab92e3adb28daada88
Author: Gert Doering <gert@...1296...>
Date:   Sun Jun 10 17:41:28 2012 +0200

    remove "*option" element in "struct route_ipv6"
=20=20=20=20
    this used to point to the "route_ipv6_option" that created this specific
    route entry, but nobody ever queried this field -> dead code.
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1339342891-28443-3-git-send-email-gert@...1296...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6714
    Signed-off-by: David Sommerseth <davids@...1347...>

commit a9af3ca44e335716c1aab46d6702cf3530e3bb73
Author: Gert Doering <gert@...1296...>
Date:   Sun Jun 10 17:41:29 2012 +0200

    Remove warning about "explicit support for IPv6 tun devices is not prov=
ided for this OS" for MacOS X (because it *is*).
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1339342891-28443-4-git-send-email-gert@...1296...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6716
    Signed-off-by: David Sommerseth <davids@...1347...>

commit ff9c39b6c9360fba14693ab5048567599ea5a38f
Author: Gert Doering <gert@...1296...>
Date:   Sun Jun 10 17:41:30 2012 +0200

    Add missing pieces to IPv6 route gateway handling.
=20=20=20=20
    OpenVPN on Linux (iproute2+ifconfig), FreeBSD and MacOS X (Darwin)
    normally points routes directly towards the "tun" interface, obviating
    the need for a gateway.  For "tap" interfaces, now add gateway spec to
    linux route command, and replace "-iface <dev>" with gateway spec (both
    together do not work) on FreeBSD and MacOS X.
=20=20=20=20
    Also adapt "route delete" appropriately, otherwise route will not be fo=
und.
=20=20=20=20
    All other platforms already use the gateway address for tun and tap,
    because there's no way to install a route "towards an interface" there.
    Signed-off-by: Gert Doering <gert@...1296...>
    Acked-by: David Sommerseth <davids@...1347...>
    Message-Id: 1339342891-28443-5-git-send-email-gert@...1296...
    URL: http://article.gmane.org/gmane.network.openvpn.devel/6712
    Signed-off-by: David Sommerseth <davids@...1347...>

commit fc0c29b31c6f3804a074d8436ee738b0cee8f800
Author: Gert Doering <gert@...1296...>
Date:   Sun Jun 10 17:41:31 2012 +0200

    Update TODO.IPv6 list
=20=20=20=20
    Clarify status of each already-done item for "IPv6 payload" TODOs.
=20=20=20=20
    Remove TODOs from "IPv6 transport" list that have been solved in
    "IPv6 payload" work.
=20=20=20=20
    Signed-off-by: Gert Doering <gert@...1296...>
    Signed-off-by: David Sommerseth <davids@...1347...>


kind regards,

David Sommerseth


--------------enig50B23DC7C22DFD5912D21A8A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/Ya9QACgkQDC186MBRfrpcLQCaAhhrdycefGMLuCpQfWp3HkeJ
s70AoI9h21zvRtsrnavhyeCA2xmYCn/1
=B3Lu
-----END PGP SIGNATURE-----

--------------enig50B23DC7C22DFD5912D21A8A--

