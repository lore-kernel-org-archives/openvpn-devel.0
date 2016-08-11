Date: Thu, 11 Aug 2016 21:00:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20160811190027.GA78279@...1296...>
References: <4489a66e-428f-493d-6dc9-1dde62c2c731@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5adDe+nHDi68q/7x"
Content-Disposition: inline
In-Reply-To: <4489a66e-428f-493d-6dc9-1dde62c2c731@...2080...>
Subject: Re: [Openvpn-devel] autoconf/automake warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--5adDe+nHDi68q/7x
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,

On Thu, Aug 11, 2016 at 08:50:22PM +0200, David Sommerseth wrote:
> I noticed a few errors today when building OpenVPN on Fedora 23.  The
> attached patch resolves this.  But it breaks 'make' when it reaches
> ./src/openvpnserv:
>=20
> Makefile:505: ../../src/openvpn/.deps/openvpnserv-block_dns.Po: No
> such file or directory

Well, if the patch introduces errors instead of warnings, it can't
be "the right fix" yet...  but it's good to get started on this (thanks).

> * LT_INIT removes a warning on automake-1.15.

Can we avoid libtool for everything but plugins?  Since we do not build
a shared library, libtool tends to introduce much more hassles than=20
being helpful about anything - especially on more weird platforms like
AIX.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--5adDe+nHDi68q/7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBV6zLSqkuBuNlUUl1AQJYOgP8DDahuGkyYe/4Br4hqvifbeeyMVUFqt9g
qy3aKx7b1MYh7gANhXxnAKajLOmMGLqrcejpNyavCnj+JD5Mu8YUdwKHL1KT5RZ5
AafBnbCQ+vedSozTxlBdbZAYMH8ydkbII4zJv87hAUARbQQLJsYeiRM+Ldiz5MqD
W2V1e6+oNP8=
=yV4V
-----END PGP SIGNATURE-----

--5adDe+nHDi68q/7x--

