References: <20200519220004.25136-1-arne@...1227...>
 <20200519220004.25136-3-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b2e3aede-6243-776a-0f5b-153dc1d480b9@...2080...>
Date: Wed, 27 May 2020 22:47:57 +0200
MIME-Version: 1.0
In-Reply-To: <20200519220004.25136-3-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="8qeWBTr0wUors7wvNgM3GDAvH1TEchod1"
Subject: Re: [Openvpn-devel] [PATCH v3 2/5] Implement support for signalling
 IV_SSO to server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8qeWBTr0wUors7wvNgM3GDAvH1TEchod1
Content-Type: multipart/mixed; boundary="ByexCCJB6maDcpTkd6VuFqVxIAl1FuZYZ";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <b2e3aede-6243-776a-0f5b-153dc1d480b9@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v3 2/5] Implement support for signalling
 IV_SSO to server
References: <20200519220004.25136-1-arne@...1227...>
 <20200519220004.25136-3-arne@...1227...>
In-Reply-To: <20200519220004.25136-3-arne@...1227...>

--ByexCCJB6maDcpTkd6VuFqVxIAl1FuZYZ
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 20/05/2020 00:00, Arne Schwabe wrote:
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  src/openvpn/ssl.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index c2e9a4f3..f85ef3eb 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -2333,7 +2333,9 @@ push_peer_info(struct buffer *buf, struct tls_sessi=
on *session)
>                  if ((((strncmp(e->string, "UV_", 3)=3D=3D0
>                         || strncmp(e->string, "IV_PLAT_VER=3D", sizeof("I=
V_PLAT_VER=3D")-1)=3D=3D0)
>                        && session->opt->push_peer_info_detail >=3D 2)
> -                     || (strncmp(e->string,"IV_GUI_VER=3D",sizeof("IV_GU=
I_VER=3D")-1)=3D=3D0))
> +                     || (strncmp(e->string,"IV_GUI_VER=3D",sizeof("IV_GU=
I_VER=3D")-1)=3D=3D0)
> +                     || (strncmp(e->string,"IV_SSO=3D",sizeof("IV_SSO=3D=
")-1)=3D=3D0)
> +                     )
>                      && buf_safe(&out, strlen(e->string)+1))
>                  {
>                      buf_printf(&out, "%s\n", e->string);
>=20

Acked-By: David Sommerseth <davids@...515...>

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--ByexCCJB6maDcpTkd6VuFqVxIAl1FuZYZ--

--8qeWBTr0wUors7wvNgM3GDAvH1TEchod1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJeztH+AAoJEIbPlEyWcf3yyT8P/Rhq3GEKDe77ajGepx0MdyI4
PAJergG+h7cRX2nUsbQkagjgIYn+LDDJNm7xueSdglDWc4D27y9/1sYk6T8BcnPv
tlB7kWc9jiXMbQMOAJUTKgnzgWKs0Sll3ELesl5fFVyqLwe/lShZRhStFV6jasUJ
F7ZQuqRhwlz6DXMQwNyWyLeRl3eq8AYWwWPyJsOCArMVmVlgqh3U2lBWvCLEHkCH
/Ow2SUUNJcEeA4rV9AF/R3zVTnISvevYXqe89evoxxr6bqdQqkyh5O791WRH28A9
8wSux4WuNKS1MeUGlZyG4Aa+LIJI+hbVvyhonq/9tPUS9UbjWNjg7oKd9M35Ud44
Mi5QM7ISafcMohhGrLwi2HWhMmPYf1aXR5kVJ2v1KIovA7uXCq/oOET2CVaHWYk+
JBNJT4Tk/Um2PdRKx4r5xJlPT40dQQyk4VznD18Xmx1lJ10BtSBYpdHTzGqOytun
2sg6FuB+zDZOS1JigyFqg+0tHI9ncN9ck8IgaQWYks3UWkpo7xLMq4TutHejqI8R
AHRx83Hk7PJK+W6Lb+dSGn843j7RDxBgEMmy3ayi/ZwGWG5NGa0Z/NEkXa9Pk9M1
BzRZUeiMC33ug1TG65SXt8GhFmWxTRtcA6iRvePJ/FCs8UsCLjpBdZf61OpG2RcN
OpEzRZv0QvnuOswrpKGT
=ZrXF
-----END PGP SIGNATURE-----

--8qeWBTr0wUors7wvNgM3GDAvH1TEchod1--

