References: <1540981377-22752-1-git-send-email-steffan.karger@...1435...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <15d8f6c6-5678-5639-4745-09213a699ea5@...2181...>
Date: Wed, 14 Nov 2018 20:49:49 +1000
MIME-Version: 1.0
In-Reply-To: <1540981377-22752-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EUYIfmFI5Fa4eqr61KwoX17LgcjuGVNEs"
Subject: Re: [Openvpn-devel] [PATCH] tls-crypt-v2: clarify
 --tls-crypt-v2-genkey man page section
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EUYIfmFI5Fa4eqr61KwoX17LgcjuGVNEs
Content-Type: multipart/mixed; boundary="nykAwCn2QcUchLgLe0SSIgICi9fMK6SQo";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <15d8f6c6-5678-5639-4745-09213a699ea5@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] tls-crypt-v2: clarify
 --tls-crypt-v2-genkey man page section
References: <1540981377-22752-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1540981377-22752-1-git-send-email-steffan.karger@...1435...>

--nykAwCn2QcUchLgLe0SSIgICi9fMK6SQo
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 31/10/2018 20:22, Steffan Karger wrote:
> As kitsune1 mentioned in IRC, this section should explain that
> "--tls-crypt-v2-genkey client" requires the user to supply the server
> key using "--tls-crypt-v2".
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>

Makes sense and, after listening to some people getting confused, it is
good to clarify the procedure.


Acked-by: Antonio Quartulli <antonio@...515...>

> ---
>  doc/openvpn.8 | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index 94b5cc4..f38fba9 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -5314,6 +5314,11 @@ If no metadata is supplied, OpenVPN will use a 64\=
-bit unix timestamp
>  representing the current time in UTC, encoded in network order, as metad=
ata for
>  the generated key.
>=20=20
> +A tls\-crypt\-v2 client key is wrapped using a server key.  To generate a
> +client key, the user must therefore supply the server key using the
> +.B \-\-tls\-crypt\-v2
> +option.
> +
>  Servers can use
>  .B \-\-tls\-crypt\-v2\-verify
>  to specify a metadata verification command.
>=20

--=20
Antonio Quartulli


--nykAwCn2QcUchLgLe0SSIgICi9fMK6SQo--

--EUYIfmFI5Fa4eqr61KwoX17LgcjuGVNEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3o8ejP0lUW4GTX3J9FVsWUWDDm0FAlvr/c0ACgkQ9FVsWUWD
Dm2e1xAAmOdsWkTRTpa6+Fij2jd7alzBMO8Jo9tUYY4Ka2e5zmH+QeIrQsX2hEn+
T5WtDjazEnENI2nKEoltIA3zoSSey50t7ibK6XKynzG9W6NWbcJp3mi8oH/vGCAI
dEt+Pw6BMW6Y36wALbaMTshxA65Bemi5bBV/GBSsNh9LUlxEeZslH6+BdbWX/abS
NzNz6R4g+UMyAvmWPHAjLA9q8BJvTOdeP6hC51JcagGcidYrBfWagc/3ezkO+bGk
/0nvXFkKfMr0pzBciLf3MkTf2c2lSB0ACsfnt5YsTUGexxHXSyToWa2fWGoktVgq
mcdUyWQQUJKKX5feM+17ekF/rU5fSD0e1rY4kHDk70T+LsLmw+0lUTUkoFXoKsdl
I3AOBEml+1BfVEb3K8Bu79vs09lZjOo3T3O0VTVdTTDVJhJZ2Um6iJt9EpYoVUff
3qfSrFrQLBzQdZQRJTR9SdA8l6FUJyKwv2gCI2mUlZIfQiIQ4qThH+LwtMhHYVdR
fDT4MamI2ToI+sKYcvCfX4e8YoRxeBRMchdIcDF2jp4+kRd6L1iRlISfEjImQidz
V6my9bux2SdSPS1SwHQg7ERXHoqRxTv0IJLNhydmCmxOM/KzR5haaAEYQlOkL2jK
dg9PkxKopo6KlLCQ37s/oLJbLem1h+ToOvnZF1jh8nSL3Xx1ZEs=
=28T8
-----END PGP SIGNATURE-----

--EUYIfmFI5Fa4eqr61KwoX17LgcjuGVNEs--

