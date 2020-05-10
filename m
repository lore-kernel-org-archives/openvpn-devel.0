References: <20200508211434.27545-1-a@...2181...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b52a84be-5e42-2dcf-f576-fe8af8bc2ee8@...2080...>
Date: Sun, 10 May 2020 15:49:59 +0200
MIME-Version: 1.0
In-Reply-To: <20200508211434.27545-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="t48J36uy9K88BLqC3knXuOq3n3Bg2WpbY"
Subject: Re: [Openvpn-devel] [PATCH] options: fix inlining
 auth-gen-token-secret file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t48J36uy9K88BLqC3knXuOq3n3Bg2WpbY
Content-Type: multipart/mixed; boundary="s2JM5lOmIWXiI34xvgbNsUoyrkGJVDNLS";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <b52a84be-5e42-2dcf-f576-fe8af8bc2ee8@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] options: fix inlining
 auth-gen-token-secret file
References: <20200508211434.27545-1-a@...2181...>
In-Reply-To: <20200508211434.27545-1-a@...2181...>

--s2JM5lOmIWXiI34xvgbNsUoyrkGJVDNLS
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 08/05/2020 23:14, Antonio Quartulli wrote:
> With commit ("convert *_inline attributes to bool") the logic for
> signaling when a certain option is inline has been changed.
> Due to an overlook, the auth-gen-token-secret was not converted, thus
> making it impossible to be inlined.
>=20
> Fix parsing logic and allow auth-gen-token-secret to be inlined as well.
>=20
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/options.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 56c9e411..2d2089e3 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -6981,16 +6981,12 @@ add_option(struct options *options,
>          }
>=20=20
>      }
> -    else if (streq(p[0], "auth-gen-token-secret") && p[1] && (!p[2]
> -                                                              || (p[2] &=
& streq(p[1], INLINE_FILE_TAG))))
> +    else if (streq(p[0], "auth-gen-token-secret") && p[1] && !p[2])
>      {
> -        VERIFY_PERMISSION(OPT_P_GENERAL);
> +        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
>          options->auth_token_secret_file =3D p[1];
> +        options->auth_token_secret_file_inline =3D is_inline;
>=20=20
> -        if (streq(p[1], INLINE_FILE_TAG) && p[2])
> -        {
> -            options->auth_token_secret_file_inline =3D p[2];
> -        }
>      }
>      else if (streq(p[0], "client-connect") && p[1])
>      {
>=20

Good to see that braintwister of boolean logic go away.  I've only done a
quick compile test and glared at the code change, which all makes sense.

Acked-By: David Sommerseth <davids@...515...>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--s2JM5lOmIWXiI34xvgbNsUoyrkGJVDNLS--

--t48J36uy9K88BLqC3knXuOq3n3Bg2WpbY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJeuAaMAAoJEIbPlEyWcf3ySfsP/3i6z7Q7SNW+oME0hmpY8gkp
2Y627tz/+MxnnT8B0w+1UF0zQqg09E9cWG2RrOOavMFkXlScBuxevhzNw1ixbrjk
SvyUrHOibAah1DujjXRpHyXsqkpPzMavmrHWotm5RopCt1E5wDZXNV6gS1hgTa93
ZkWOSV9fMACaaFXuYnq/1o6YTsZOwav3iJACEhofJQNTHNJXU+QUe3Gj7xnJNh5Z
0KXHQkXrlm3CrpyVZ/FwNxEvFVeYbgGUWOfSRx3FmjoWGrtV0b+qbKGgk90fdniM
9oCx/te1Yl6GG2/qeOI/32SPHM41gRcd9GFOq0LToDNPQRI/rDGYn5IERarMI0R/
bTnpbrdUgMULROx4k/5HO32KwbEhgXI0M+RzRJFbV+wA2QmWMv/VqLd9WHlpfxK2
qapWoFxtTX/zHJNy1zxnLtbtwfWSli59kZA5afjaS5yFzZu/bf8YC761VF8iSWp6
lMt3sS+C8tu7XDAiYt6RuKZfnsD7adzWaP/qiq/GF6j3G16UN5Fy6n4jg0Cyy+cE
hv1nQoecJWqd9yPG/mZ6x40HU8JnYzFnE5FF6BVC24byCjfABnMvuEk3vtT82Lxf
00WgBNlk9ZkVPmm91ipHbSDH4Pc7H7PKsZH0w+sGFu1a75CwuFavHM3jbb/m9g7n
rBBpL56KnO/GE9xOzdhY
=SYHw
-----END PGP SIGNATURE-----

--t48J36uy9K88BLqC3knXuOq3n3Bg2WpbY--

