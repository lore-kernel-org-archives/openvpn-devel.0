References: <20200413155650.114-1-lstipakov@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <b6450eb9-93db-63b9-7e13-4cacbcad39c9@...1227...>
Date: Tue, 14 Apr 2020 19:37:22 +0200
MIME-Version: 1.0
In-Reply-To: <20200413155650.114-1-lstipakov@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WSTNqFxQZ7iX8mKgOD7W7ZAI7jRJbWWS6"
Subject: Re: [Openvpn-devel] [PATCH] Fix illegal client float
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WSTNqFxQZ7iX8mKgOD7W7ZAI7jRJbWWS6
Content-Type: multipart/mixed; boundary="4BzBJR275ckqLuq75YswIo3ANyCgPjOEg"

--4BzBJR275ckqLuq75YswIo3ANyCgPjOEg
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 13.04.20 um 17:56 schrieb Lev Stipakov:
> From: Lev Stipakov <lev@...515...>
>=20
> There is a time frame between allocating peer-id and initializing data
> channel key, which is performed on receiving push request.
>=20
> If a "rogue" data channel packet arrives during that time frame from
> another address and  with same peer-id, this would cause client to float
> to that new address. This is because:
>=20
>  - tls_pre_decrypt() sets buffer length to zero if
>    data channel key has not been initialized, which leads to
>=20
>  - openvpn_decrypt() returns true if buffer length is zero,
> which leads to
>=20
>  - process_incoming_link_part1() returns true, which
> calls multi_process_float(), which commits float
>=20
> Note that problem doesn't happen when data channel key
> is initialized, since in this case openvpn_decrypt() returns false.
>=20
> Fix illegal float by adding buffer length check before calling
> multi_process_float().
>=20
> This should fix Trac #1272.
>=20
> Signed-off-by: Lev Stipakov <lev@...515...>
> ---
>  src/openvpn/multi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index da0aeeba..58892a87 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2555,7 +2555,7 @@ multi_process_incoming_link(struct multi_context *m=
, struct multi_instance *inst
>              orig_buf =3D c->c2.buf.data;
>              if (process_incoming_link_part1(c, lsi, floated))
>              {
> -                if (floated)
> +                if (floated && c->c2.buf.len > 0)
>                  {
>                      multi_process_float(m, m->pending);
>                  }
>=20

I think the commit is right but should we add a comment here saying that
len >0 is required to have valid decrypted packet?

Arne


--4BzBJR275ckqLuq75YswIo3ANyCgPjOEg--

--WSTNqFxQZ7iX8mKgOD7W7ZAI7jRJbWWS6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6V9NIACgkQFRhsZwKx
RFSDWhAAiKWsxTWCdoym+1ExgYow4hG46ZQ7BYN+QA5nwxVKqtose5wnGpff6CQG
JYzBxCizYvSN4W84Nk/KmlmGTwOvor4UzdvAwoZrPtzpQgSH+py6mg9WHswWCIhP
Z2kHJ1W0HeBu/icepVk+KbOEqqOoT2IBZmxJZsRCzlcZEeiodGyio3SVlNYSNsWV
0qgyjLm+bq+i/aBVyc5U+AfynUA4higKOllXJOeuE9ayyD2TzZ2hQNHydWkKwA0U
31OmnVRgqUPWGnTXNAgGMjVBzaU4m/U5jk9hpHUU6Dl0dcxPb6dyxHIGNne0vFWT
q48P6xmxeYpzpLqnoX6m0yVGTVxwlZYalrJsrmSShw92f61ov/g8T1n38u+BReMH
HtZ21y9Zzt5GApI6FDm8iBWQI/x9mfdDxxbDT3nKIQkp5KfgE7AHF2n/bTEkjmdx
Ujd0+t3P/pwMwcxASPKmlDjVufZinTRgqdHLI8uhWIpC2uZztpzkunvQeuz+qdk2
/gmiLDlz1LMZrblMNMRDY7a5ibKQnQquAoksnhA6KYIkvPbJVzkhWrh6WNbDN9Se
Q0tjyerFrHv7GrpCcegk5MFp5R/4bjDckMeQWEE/zp/3jBIlYJQx24yf5IeQvt/+
vlESIF1r/fHouvbWsgLR4RmEqqZKh8hFtpzUZmYeBxnNI46Rb+M=
=9KiU
-----END PGP SIGNATURE-----

--WSTNqFxQZ7iX8mKgOD7W7ZAI7jRJbWWS6--

