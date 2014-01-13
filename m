Date: Mon, 13 Jan 2014 19:58:23 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20140113185822.GV226@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EFrEOWQ9ye2lTNjK"
Content-Disposition: inline
Subject: [Openvpn-devel] RFD: <net/route.h> and struct route (trac #340)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--EFrEOWQ9ye2lTNjK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

there's an open bug in trac

https://community.openvpn.net/openvpn/ticket/340

that asks us to remove structures used in route.c that were copy-pasted
from <net/route.h>, because OpenBSD will change some structure elements,
leading to incompatibility with OpenVPN, and include <net/route.h> instead.

This makes sense, from a portability perspective, even if it needs
careful testing across all supported platforms to see whether everything
affected still works (this seems to primarily be the default gateway
querying code, get-default_gateway()).

There is a catch to it: <net/route.h> defines a "struct route", while
OpenVPN's route.h also has a "struct route", which are wildly different,
so including <net/route.h> would require is to change all occurrences
of "struct route" to "struct route_ipv4" or such.  Which we can do,
and I think it makes sense (we have "struct route_ipv6" for IPv6, so
that would avoid the conflict while still aligning IPv4/IPv6 somewhat).

Now comes the catch: git master/2.4 only, or 2.3.3?


It's not exactly a bugfix, but is needed for portability, and since 2.3.x
will be around a while, it would be good to have there.

Also, changing it in master and 2.3.3 would make Arne's and my life much=20
easier in future should we have to fix a bug relating to (then)=20
"struct openvpn_route", as we wouldn't be able to cherry-pick master->2.3
anymore otherwise...


So I'm tempted to go for "git master and 2.3.3", but want to put this
up for discussion here.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--EFrEOWQ9ye2lTNjK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUtQ3TqkuBuNlUUl1AQLgIgQArOXFAR4Ph26CiSbh5Exgze4Wv/Bhm2uD
iujL4zusCJM+gKy3ePau/z3Q6VZsnyDe0RBvDD4jJ0tPZPxWUpCc4Hk5vLcrq5v2
bOLPLsfcowKjgEZqjhA/XKU3I5hJ3F3VaMepZ5QBghiXOkE+jjvsoJQdnqafF5ka
r5d619mQwZ8=
=x0p2
-----END PGP SIGNATURE-----

--EFrEOWQ9ye2lTNjK--

