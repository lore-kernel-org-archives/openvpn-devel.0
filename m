References: <20200626133254.11795-1-tincanteksup@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d797a9ab-6438-f1b1-16f2-4911e491c523@...2080...>
Date: Fri, 26 Jun 2020 16:49:05 +0200
MIME-Version: 1.0
In-Reply-To: <20200626133254.11795-1-tincanteksup@...277...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="RUFL5gCvszQt1QPLZYyvW7pENt7eOi5wd"
Subject: Re: [Openvpn-devel] [PATCH] New man page corrections -
 advanced-options.rst
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, tincanteksup <tincanteksup@...277...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RUFL5gCvszQt1QPLZYyvW7pENt7eOi5wd
Content-Type: multipart/mixed; boundary="YgYSMso72S8Wr0QQRbUZmuqA5vi4ZTYPL";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: openvpn-devel@lists.sourceforge.net, tincanteksup <tincanteksup@...277...>
Message-ID: <d797a9ab-6438-f1b1-16f2-4911e491c523@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] New man page corrections -
 advanced-options.rst
References: <20200626133254.11795-1-tincanteksup@...277...>
In-Reply-To: <20200626133254.11795-1-tincanteksup@...277...>

--YgYSMso72S8Wr0QQRbUZmuqA5vi4ZTYPL
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 26/06/2020 15:32, Richard Bonhomme wrote:
> Signed-off-by: Richard Bonhomme <tincanteksup@...277...>
> ---
>  doc/man-sections/advanced-options.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/adv=
anced-options.rst
> index 262e568c..dbf7799c 100644
> --- a/doc/man-sections/advanced-options.rst
> +++ b/doc/man-sections/advanced-options.rst
> @@ -61,5 +61,5 @@ used when debugging or testing out special usage scenar=
ios.
>=20=20
>  --rcvbuf size
> -  Set the TCP/UDP socket receive buffer size. Defaults to operation syst=
em
> +  Set the TCP/UDP socket receive buffer size. Defaults to operating syst=
em
>    default.
>=20=20
> @@ -89,5 +89,5 @@ used when debugging or testing out special usage scenar=
ios.
>=20=20
>  --sndbuf size
> -  Set the TCP/UDP socket send buffer size. Defaults to operation system
> +  Set the TCP/UDP socket send buffer size. Defaults to operating system
>    default.

Thanks again!

I've squashed this change into your previous grammar/typo fix commit.

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--YgYSMso72S8Wr0QQRbUZmuqA5vi4ZTYPL--

--RUFL5gCvszQt1QPLZYyvW7pENt7eOi5wd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJe9grhAAoJEIbPlEyWcf3yyL0QAIdj+k0Emz6Y+MHOLO+pwcdr
boEOkGmRA3g5wXGXDfSVmalyNSVqbcY7rl5XjYVrXD3dgjMcjtB5XFP8IPRfqGWT
QFJy2gDLY770bOIupmOqwjUPGmCq/FesMB91vnRyKF9SdZ1An/LF2I9TbSq5FYLa
a5qpnQhdhhFfHY+qjr3XMqorT51AQSyF10b9Q7tWrifAV5q05BjWD+uav2vI1U9l
IXgzDIGpf1hA0ckUEXkjnEudLMX7dmjoG2rs+PwkxR7pDJI9jQ6HjF3UnD8nsiGg
MnTC8oYiZCESanlz9DO4lYACkPJtrD1O4YKp7NY29YIYLUN4gElLG2LofslcJVqC
79vJv99B5NbvUmiEc+Ppb/+w7LjLyYgwhDuDYcMIuUGPJZX93K7uZb2MsYkpG9eM
//DnLb4rYYXbBK3XkSBJrOuEouQ24V/dMpiwEMqCe5T99WVvOiIi/WKn4NktqiKl
Qb421OU97QnSkse0upKg5zXtgwDsayNFCsUQ9B+bGRkb4seVQCjW8wKpxlFb6B3W
YHxRDkiWskvm1pksZb4g4Ik8+KqpIk1+32wcxUBU/kr2mQG914ORwOsA0rJyMlvf
H2MXHsBWdXjs9KIvteDM+cNm85lg8jdRfCD+iXqq/bsRPt8zN9qyUYwHYurC1l/C
qyEzM4uM4PDFkWkGH8g3
=FVKE
-----END PGP SIGNATURE-----

--RUFL5gCvszQt1QPLZYyvW7pENt7eOi5wd--

