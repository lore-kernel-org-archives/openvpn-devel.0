Date: Sun, 25 Oct 2015 19:33:24 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151025183324.GI22054@...1296...>
References: <311679276.3534103.1443637554683.JavaMail.yahoo@...2084...>
	<1442933701.496290.1445796724771.JavaMail.yahoo@...2084...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4EtQHArxtuwgdMQ/"
Content-Disposition: inline
In-Reply-To: <1442933701.496290.1445796724771.JavaMail.yahoo@...2084...>
Subject: Re: [Openvpn-devel] [PATCH] Update
 contrib/pull-resolv-conf/client.up for no DOMAIN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jeffrey Cutter <jeff_m_cutter@...109...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--4EtQHArxtuwgdMQ/
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Oct 25, 2015 at 06:12:04PM +0000, Jeffrey Cutter wrote:
> Author: Jeffrey Cutter <jeff_m_cutter@...109...>
>=20
> Update contrib/pull-resolv-conf/client.up for no DOMAIN
>=20
> When no DOMAIN is received from push/pull, do not add either domain or se=
arch to the resolv.conf.
> Fix typo in comment resolv.con[f].
> Only add new line when using domain or search.
>=20
> Signed-off-by: Jeffrey Cutter <jeff_m_cutter@...109...>
> ---=A0contrib/pull-resolv-conf/client.up | 13 ++++++++-----=A01 file chan=
ged, 8 insertions(+), 5 deletions(-)
> diff --git a/contrib/pull-resolv-conf/client.up b/contrib/pull-resolv-con=
f/client.upindex b28d4d1..8858b47 100644--- a/contrib/pull-resolv-conf/clie=
nt.up+++ b/contrib/pull-resolv-conf/client.up@@ -50,9 +50,10 @@ nl=3D'=A0# =
or=A0# "dhcp-option DNS 10.10.10.10" (multiple allowed)

Uh.  Whatever you used to generate this patch, it totally massacred it.

Can you please re-send using git-format-patch and *attach* the patch,
or using get-send-email and send from there right away?  Usually the
latter is the one that generates the emails most easy to work with.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--4EtQHArxtuwgdMQ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVi0gc6kuBuNlUUl1AQLjkQQAr2vfmxaLNF+3rNJ2Wz95NKYsQbclnPS2
n6aEc8daRMl+1Z0fGSlT6SVNsK9JTcjOWtU2nY7c0gDqz1ylYAE3zOeAxl0sj4y8
3enqs+uB/QGoaTs1sw/NruezYBrULcklpuINI/q083cV829bV6F2Ekj+CDay1Wm3
Xof4XbfYCFU=
=W06h
-----END PGP SIGNATURE-----

--4EtQHArxtuwgdMQ/--

