References: <20200820014258.38377-1-eric@...1918...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <ff5e24b5-f537-b870-a2a4-97561e682dc3@...1227...>
Date: Thu, 20 Aug 2020 08:47:51 +0200
MIME-Version: 1.0
In-Reply-To: <20200820014258.38377-1-eric@...1918...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WOeDwJa3QVW9kWThVB8AiObSl7xFEURNi"
Subject: Re: [Openvpn-devel] [PATCH] Fixes a bug in
 management_callback_send_cc_message, should be strlen instead of sizeof
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Thorpe <eric@...1918...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WOeDwJa3QVW9kWThVB8AiObSl7xFEURNi
Content-Type: multipart/mixed; boundary="5sxaKPFs3VBeth9q81K4vB3pw6s2xb8ih"

--5sxaKPFs3VBeth9q81K4vB3pw6s2xb8ih
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 20.08.20 um 03:42 schrieb Eric Thorpe:
> Signed-off-by: Eric Thorpe <eric@...1918...>
> ---
>  src/openvpn/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index dfa045b0..a785934a 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -312,7 +312,7 @@ management_callback_send_cc_message(void *arg,
>                                      const char *parameters)
>  {
>      struct context *c =3D (struct context *) arg;
> -    size_t len =3D strlen(command) + 1 + sizeof(parameters) + 1;
> +    size_t len =3D strlen(command) + 1 + strlen(parameters) + 1;
>      if (len > PUSH_BUNDLE_SIZE)
>      {
>          return false;
>=20

Acked-By: Arne Schwabe <arne@...1227...>

This probably has escaped my radar because probably the the 2FA codes
were always small enough to fit into the 8 extra character of a pointer
size.

Arne


--5sxaKPFs3VBeth9q81K4vB3pw6s2xb8ih--

--WOeDwJa3QVW9kWThVB8AiObSl7xFEURNi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8+HJgACgkQFRhsZwKx
RFSE0Q//e7OFM+6SM1iivZINw+B6Sqz475W3wCS1WpSE1yVYWh7lKcS6VdwPK/RF
96gbP+KULVOO401O6P8owJfb45Fh3O0PgdD+7U+YGNi2gH9AeOl5NyCRPKD2DfWV
Rn2hkicjv1eX6eE6HatpUdn4zefcW3nNXJGXf65m4eDkPi7aUgSD2IZW5/5DP8jb
q3GzPhiPoKbHhFDwI5x6NSk+NObWUGKNYM/wFDo4jolIWvL5sSkUxrXkOTcEgGCN
xoKT490dt73BvclAaHVFAl6Ds2bQ41IVZyfDI63z37gV5deXNrVTWOw8aeontgET
nNKiVgHB1o5KNnvp7M7LJ+ui434vlks/lUIKqj9KFG2SkvcVumE3NaPETEf8kL5m
vaVKQhLiEEP3kfqptn/AmF0HXKosu+7phO6letSGRhJ9uJOBC3BnQxiOhn1t+hJX
74BV9QT/8Lp31avuEXnFbeUn3DEQ/9ydh297bFnPtWTr35w28FlyqV42O3BvcybW
CnBpVf0Ch6lUHnss5uCnOI8M00A3JmgbMyzcaENe8e3gknGcgU6xhdRFRMlLFowI
Uu5yE8dy44pQ+7vZEB3+zmjn/BARt5tAuls+NmcYEcoL6+wEhzQPR/LLwHdtkfQP
d3Vm4vr7qaOMpt+X/8aCBN/LmM7pnpZtcTQOP/TWZcaeOFMw/NA=
=HD3j
-----END PGP SIGNATURE-----

--WOeDwJa3QVW9kWThVB8AiObSl7xFEURNi--

