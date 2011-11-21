Date: Mon, 21 Nov 2011 13:07:22 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20111121120722.GO8496@...1296...>
References: <1321876765-16500-1-git-send-email-davids@...1347...>
	<1321876765-16500-2-git-send-email-davids@...1347...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HugztF8qW/dl+Dju"
Content-Disposition: inline
In-Reply-To: <1321876765-16500-2-git-send-email-davids@...1347...>
Subject: Re: [Openvpn-devel] [PATCH] Clean-up: check_subnet_conflict()
	function was #if 0 -> remove it
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...1347...>
Cc: openvpn-devel@lists.sourceforge.net

--HugztF8qW/dl+Dju
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,

On Mon, Nov 21, 2011 at 12:59:25PM +0100, David Sommerseth wrote:
> As the body of the check_subnet_conflict() function was disabled with
> an #if 0 clause, remove this function and clean up all places this functi=
on
> was called.
>=20
> This function also expected get_default_gateway() to return data,
> which it does not do any more.  Hence this function is "out-of-date" and =
no
> longer usefull.

I agree with the assessment, but come to a different conclusion - I think
the functionality is worthwile to have, so maybe we should try to repair
it, instead of throwing it out completely.

Meeting topic?

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--HugztF8qW/dl+Dju
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTso++qkuBuNlUUl1AQImRgP/SlYBSL+GpUM3WlufjG5SD4M1WVv4ob8g
eSnQfXq/BiXO8uvW+VC+0yJCANHGrBxpq6Ox6O9Rl2Zckk5ywP46+60XRaSx3q1p
+ZmTdqSJ+K2b+1ldFwQzza7JuTg67TOFjIyG292x+qCxD6jsxQxFsYhoDGqqp8y/
ExaUgWJGeGg=
=c/+5
-----END PGP SIGNATURE-----

--HugztF8qW/dl+Dju--

