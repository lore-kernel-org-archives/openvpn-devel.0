Date: Fri, 12 Nov 2010 21:18:03 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20101112201802.GZ258@...1296...>
References: <4CDD641F.30408@...515...> <20101112163620.27677.qmail@...1287...>
	<4CDD704B.7080505@...1114...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dQ+ozEaLk2y6HH72"
Content-Disposition: inline
In-Reply-To: <4CDD704B.7080505@...1114...>
Subject: Re: [Openvpn-devel] [PATCH] Removed hardcoded signtool	dependency
	from win/build_all.py
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn.list@...1114...>
Cc: openvpn-devel@lists.sourceforge.net

--dQ+ozEaLk2y6HH72
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 12, 2010 at 05:50:19PM +0100, David Sommerseth wrote:
> If I've understood it correctly, this is related to signing the Windows
> TUN/TAP driver.  So if you don't have a signing key/tool available, it
> is still possible to build the rest of OpenVPN.  You might even manage
> to install the unsigned TUN/TAP driver with some tweaking.

Isn't the openvpn.exe signed as well?

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--dQ+ozEaLk2y6HH72
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTN2g+qkuBuNlUUl1AQKo+AQAjcNjvY/8MDZoDOGmtR1hh5IVRFMp3iy7
qlVJh3XxRg0vokwZbIDGZ9eh9Wv5i4dSqfahARXmso/0AN52QRfHBLbu3Q9YJI+o
DWkUdFKTksnE2mb8B2/80MNijB61i6JayYc6uU+TVDPlrjR9Uomqbv/yQQ+wYE3i
YbzxlBw/8Ak=
=Wm2d
-----END PGP SIGNATURE-----

--dQ+ozEaLk2y6HH72--

