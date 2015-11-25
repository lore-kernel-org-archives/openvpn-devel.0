Date: Wed, 25 Nov 2015 08:54:16 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151125075416.GR24952@...1296...>
References: <564BA6DB.4070703@...2070...>
	<564DE8B3.9030803@...2070...>
	<20151124083944.GY24952@...1296...>
	<5654A314.3080607@...2070...>
	<20151124201135.GM24952@...1296...>
	<CAKuzo_jdcOjunyVmpT8er3HqWG7yh6pr+i8Tn8kD3omj=G_Pqw@...278...>
	<565547AB.9030607@...2070...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lc/+3UtgiEbvMcQ8"
Content-Disposition: inline
In-Reply-To: <565547AB.9030607@...2070...>
Subject: Re: [Openvpn-devel] [PATCH v4-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--lc/+3UtgiEbvMcQ8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 25, 2015 at 08:31:23AM +0300, ValdikSS wrote:
> I need help with 2.3 build system. While the code itself would compile fi=
ne, it won't link because I can't figure out how to link libraries availabl=
e in vista+
> only for vista+ build and do not link it for XP.

Cross-build using ubuntu 14.04 and mingw64, and run configure with=20
"configure ... LIBS=3D'-lwhatyouneed'" for the vista+ build.

For 2.3, that should be good enough.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--lc/+3UtgiEbvMcQ8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVlVpKKkuBuNlUUl1AQKBzwP+OB7kP08XF5lp4yIPA49roG8p9L41nIMn
+TEP/Xy5XVjGtquEgwO5ZjhTNEdJR+QPNzu6oqj7Yi9BAGxmxtfMUc32l3gq9aO1
r6WvWdJuJol07niMArKA7qK5jYXwzJvvtkLQ09zL9YL4mgARcBhYDnAQaWDv9+Uv
J6G/wTeuYN8=
=Ed4N
-----END PGP SIGNATURE-----

--lc/+3UtgiEbvMcQ8--

