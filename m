References: <20200722095446.25141-1-davids@...515...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e0212118-cc75-f823-ff4d-4a496269bae2@...1227...>
Date: Wed, 22 Jul 2020 14:01:14 +0200
MIME-Version: 1.0
In-Reply-To: <20200722095446.25141-1-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9hJlwVtpRv06gXypNTQyeYyXpoZJtuQRd"
Subject: Re: [Openvpn-devel] [PATCH] options: Remove --udp-mtu
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9hJlwVtpRv06gXypNTQyeYyXpoZJtuQRd
Content-Type: multipart/mixed; boundary="zpnAJmb8mumXCruq4JLyYZZpLgJFM1XWT"

--zpnAJmb8mumXCruq4JLyYZZpLgJFM1XWT
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 22.07.20 um 11:54 schrieb David Sommerseth:
> Before --link-mtu, it was --udp-mtu.  This was changed in
> OpenVPN 1.5_beta1 (release July 2003).  It should be safe now
> to remove --udp-mtu, the transition period should have been long
> enough.
>=20
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  src/openvpn/options.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index b1962ca4..3ebf033d 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -3645,7 +3645,6 @@ calc_options_string_link_mtu(const struct options *=
o, const struct frame *frame)
>   * --dev tun|tap [unit number need not match]
>   * --dev-type tun|tap
>   * --link-mtu
> - * --udp-mtu
>   * --tun-mtu
>   * --proto udp
>   * --proto tcp-client [matched with --proto tcp-server
> @@ -6007,7 +6006,7 @@ add_option(struct options *options,
>              goto err;
>          }
>      }
> -    else if ((streq(p[0], "link-mtu") || streq(p[0], "udp-mtu")) && p[1]=
 && !p[2])
> +    else if (streq(p[0], "link-mtu") && p[1] && !p[2])
>      {
>          VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
>          options->ce.link_mtu =3D positive_atoi(p[1]);
>=20

I close to sending a NAK to this. Normally we just don't outright remove
options but rather warn for a version or two. But adding the warning
code here and later removing the option just to remove the complexity of
'|| streq(p[0], "udp-mtu"'?

I don't see a compelling reason to remove alias option. Normally we
deprecate options because they

- are considered harmful in some way (no-iv)
- complicate the code without a clear gain
- are replaced by a better mechanism and the old option does not
trivally translate to the new option.
- are features that we do no longer want to maintain and to remove them
to decrease complexity (--enable-client-only)

But with alias I feel we just removing them because we found a newer
nicer name and as a user (especially another dev) removing an alias
feels like they are removed because of pride/principle that since they
are old they must be go away. I cannot came up with any other compelling
reason why we need to remove them. And as much as I want to have old
options gone as well, if my only reason is pride/they are old then I
have to say that they should stay while the option they alias also stays.

Arne


--zpnAJmb8mumXCruq4JLyYZZpLgJFM1XWT--

--9hJlwVtpRv06gXypNTQyeYyXpoZJtuQRd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8YKooACgkQFRhsZwKx
RFS+Hg//QJvUJnc28DJxv+bzdy3jVR8lLGm3D6iT3BcRhwZBif6zfzbvIspZRtp7
FFaADD7c5stjfr8taeFKdVe5C8KG9rORef0knd0SEP7LHo0iRukdxLxQPT7p5mOO
ITFtHZeOfijoTvgB9gdASIhM6pbhyR4mYbTL3uG1pFnQg+FoLd2O04H8Kn5zbFts
tp/88YMaZuOSoQleLPn1pzUPtEJGoLYjVi5OBnN6NMA/uh2iNJzlZNGcI2Vq7/CU
fzlos64IvYE3fRxXwj8q0DjOLaAXlGsUJcjvPNa8O5sOTlj72cht+JYsrco9tG4G
G61RGLnP+oMWLqZS2q3DCt167dxajFR/+VfqzEPgyNhgeW23sDVA21/lSRSmhmw0
nRkZowGgvFBTSKzqzcAno5iPYTYdKW/+rTaNM/QFsrg7kb3onYyUeoh26sLb+TJY
mc1MDWPf+r97nxVJeB6tTKfI+yLLbK1NvozItJDyS4MZHNwFpcSeQuto3+UzoYYW
veIKg5YLlPLBDDTcVwYGlk3rLprBisCTtaCIs2R1wC61omRX98gb8zHXv+SG+ys+
5EQkJbAUkdIlXStG4YzABxgJ7zMND3TaQVAkGKk+m9/3SaYfxiH+qtv4MW1EznqV
GrLfZ/ov4k5QtbaGyBf/zgFIZswAEzdrHddeGP1iS0is2PJbOPg=
=bT1i
-----END PGP SIGNATURE-----

--9hJlwVtpRv06gXypNTQyeYyXpoZJtuQRd--

