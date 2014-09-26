Date: Fri, 26 Sep 2014 20:12:23 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140926181223.GR396@...1296...>
References: <54259015.2030005@...1921...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0hHDr/TIsw4o3iPK"
Content-Disposition: inline
In-Reply-To: <54259015.2030005@...1921...>
Subject: Re: [Openvpn-devel] [PATCH] Implement on-link route adding for
	iproute2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Philipp Hagemeister <phihag@...1921...>
Cc: openvpn-devel@lists.sourceforge.net

--0hHDr/TIsw4o3iPK
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 26, 2014 at 06:11:01PM +0200, Philipp Hagemeister wrote:
> Currently, when compiling with --enable-iproute2 , OpenVPN does not
> create a correct route when the user is connected to the Internet
> without a gateway (e.g. via ppp). This patch implements the
> corresponding FIXME.
>=20
> Signed-off-by: Philipp Hagemeister <phihag@...1921...>

Looks good to me.  Will test and then commit (might take a few days).

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--0hHDr/TIsw4o3iPK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVCWshqkuBuNlUUl1AQJYJwP/bw1+LhxSF+NdwW6KJaWeTEMmALQJJhmK
2sLWa/5gvvaF2Hgd4a4N0vzgKqSCujLr5JBQdMJALHk53TOQ+GFFnebhjonMv7nm
xFRaCRnAV1t1wS2uuppxQrRSo1/bAerN9aTL3aLdvUoykOs9gznJvdO5lIB2JzPI
TbQB2Y/G/AU=
=aliB
-----END PGP SIGNATURE-----

--0hHDr/TIsw4o3iPK--

