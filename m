Date: Thu, 25 Mar 2021 12:21:52 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210325112152.GM976@...1296...>
References: <20210324222330.455-1-arne@...1227...>
 <20210324222330.455-2-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="2xcpa89S5zuNdo/i"
Content-Disposition: inline
In-Reply-To: <20210324222330.455-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/4] Fix unchecked signess conversions
 reported by MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--2xcpa89S5zuNdo/i
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Mar 24, 2021 at 11:23:28PM +0100, Arne Schwabe wrote:
> diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
> index c19370eb..1e79ccc4 100644
> --- a/src/openvpn/dhcp.c
> +++ b/src/openvpn/dhcp.c
> @@ -113,7 +113,7 @@ do_extract(struct dhcp *dhcp, int optlen)
>                          const int owlen =3D len + 2;        /* len of da=
ta to overwrite */
>                          uint8_t *src =3D dest + owlen;
>                          uint8_t *end =3D p + optlen;
> -                        const int movlen =3D end - src;
> +                        const size_t movlen =3D end - src;
>                          if (movlen > 0)

This code scares me...  I think it is correct because of all these
checks around, but I like the version with a signed int really more
"should all these assumptions about i<optlen, len<=3D(room+2), .. no
longer hold, and movlen ever be negative, the old code would not
copy anything, and the new code would overwrite all memory".

Based on that, I'd do a "(size_t)movlen" cast here, if positive.


The rest of the patch looks good.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--2xcpa89S5zuNdo/i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgXHHeAAoJEB2Cnv7KVigSaJEL/R1IPajwY2DzJMXlYsX115Qr
ZCPSxaAEFH95Nni3BUyUsdOqUbn3ypjvt9k95nbB1B5XNEdRvry7ScA5ViTbG58v
hhoEOUXXJvm0iNiiacJgjWA7r6aeCcD1iJTcfEiby2JvQIDag860574iaG1m+ujk
mtJRK36hysqEW8K0IY41IMm1NIjvQI129wlfXpJSX/BUbLTK8cQX3T2ss9JQHjp1
tidNdrn5E4ZAimGQQn+7UOe6/IHUvPYvQNKC3D11lvoIwx4f1v2D3J9YYsex8al3
S19Vua9tDFnkYxRskCYue58fGnzrpPOfNU8gUQPAHEpSR2ueyCJOkQHfiOfo9TID
3L23z7HsPd/3vTA2QrRs6YZMZjj2zAU1mkUmyQ3yB1v6Qeb0xNBK85I2Q033gogT
+d2+SsGRnOrhz8pxObs1NE0naIwa9bW8cWQvAmtGVdI2wm/aaU18f/4NNJ2Hw8Me
UZGoaou6MWu7W/JthXxdUYktAhtIokQfXeeNRvdAYw==
=I7z9
-----END PGP SIGNATURE-----

--2xcpa89S5zuNdo/i--

