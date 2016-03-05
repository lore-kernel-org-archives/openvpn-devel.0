Date: Sat, 5 Mar 2016 16:27:04 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20160305152704.GQ24952@...1296...>
References: <56D8A6C4.5080803@...2070...>
	<56DA04EE.8000200@...2070...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="64ER8fbSqWes0Fic"
Content-Disposition: inline
In-Reply-To: <56DA04EE.8000200@...2070...>
Subject: Re: [Openvpn-devel] Pushing multiple certificates from server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <iam@...2070...>
Cc: openvpn-devel@lists.sourceforge.net

--64ER8fbSqWes0Fic
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Mar 05, 2016 at 12:58:06AM +0300, ValdikSS wrote:
> Bad news:
>=20
>   * OpenVPN 2.3 and master can't connect to this server, with both OpenSS=
L and PolarSSL backends. Maybe if I supply certificates in correct order, c=
lient would

If Connect works, and OpenVPN for Android does not, this hints at
"PolarSSL vs. OpenSSL".

Or at "we call the crypto library differently"...

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--64ER8fbSqWes0Fic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVtqZGakuBuNlUUl1AQISkgQArN2tnWfaGaNyDd+sarDAnppkZiJJHKXQ
70lTn4VgYTKPhdZDfqk3gwHy9ixmVhCbU0W52hkAtT2kohfE3lz4BaNskLFZqCAl
pO48f/0IKfiJQQGDeFpctzbbhn6C2eRw4vZkiduhQVf4qtqw6o23MuYpSDk9FspD
VXUluyNKzio=
=ZH3+
-----END PGP SIGNATURE-----

--64ER8fbSqWes0Fic--

