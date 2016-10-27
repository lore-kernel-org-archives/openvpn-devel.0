References: <1477496878-17296-1-git-send-email-steffan.karger@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <9be39384-ea1d-ebeb-b9ee-0b70ff91e8f6@...2080...>
Date: Thu, 27 Oct 2016 16:18:32 +0200
MIME-Version: 1.0
In-Reply-To: <1477496878-17296-1-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="a538NmnJ3BUNUMg1W36e74PBDopUXvBqw"
Subject: Re: [Openvpn-devel] [PATCH (master)] Limit --reneg-bytes to 64MB
 when using small block ciphers
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a538NmnJ3BUNUMg1W36e74PBDopUXvBqw
Content-Type: multipart/mixed; boundary="jHPKOo08gAt5vmNS0iP13eS2feLiiBK3V";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan.karger@...1435...>,
	openvpn-devel@lists.sourceforge.net
Message-ID: <9be39384-ea1d-ebeb-b9ee-0b70ff91e8f6@...2080...>
Subject: Re: [Openvpn-devel] [PATCH (master)] Limit --reneg-bytes to 64MB when
	using small block ciphers
References: <1477496878-17296-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1477496878-17296-1-git-send-email-steffan.karger@...1435...>

--jHPKOo08gAt5vmNS0iP13eS2feLiiBK3V
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 26/10/16 17:47, Steffan Karger wrote:
> Following the earlier warning about small block ciphers, now limit the
> --reneg-bytes value when using a cipher that susceptible to SWEET32-like
> attacks.  The 64 MB value has been selected with the researchers who
> published the SWEET32 paper.
>=20
> Note that this will not change a user-set (non-zero) --reneg-bytes value,
> to allow a user to override this behaviour if really needed.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  src/openvpn/crypto.c |  5 +++--
>  src/openvpn/ssl.c    | 24 ++++++++++++++++++++++++
>  2 files changed, 27 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
> index 45689f2..b40fc7a 100644
> --- a/src/openvpn/crypto.c
> +++ b/src/openvpn/crypto.c
> @@ -836,8 +836,9 @@ init_key_ctx (struct key_ctx *ctx, struct key *key,
>  	  cipher_kt_iv_size(kt->cipher));
>        if (cipher_kt_block_size(kt->cipher) < 128/8)
>  	{
> -	  msg (M_WARN, "WARNING: this cipher's block size is less than 128 bit "
> -	      "(%d bit).  Consider using a --cipher with a larger block size.",
> +	  msg (M_WARN, "WARNING: this cipher's block size is less than 128 "
> +	      "bit (%d bit).  This allows attacks like SWEET32.  Consider "
> +	      "using a --cipher with a larger block size.",
>  	      cipher_kt_block_size(kt->cipher)*8);
>  	}
>      }
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index dfdc200..2c341a2 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -283,6 +283,24 @@ tls_get_cipher_name_pair (const char * cipher_name, =
size_t len) {
>    return NULL;
>  }
>=20=20
> +/**
> + * Limit the reneg_bytes value when using a small-block (<128 bytes) cip=
her.
> + *
> + * @param cipher	The current cipher (may be NULL).
> + * @param reneg_bytes	Pointer to the current reneg_bytes, updated if nee=
ded.
> + * 			May *not* be NULL.
> + */
> +static void
> +tls_limit_reneg_bytes (const cipher_kt_t *cipher, int *reneg_bytes)
> +{
> +  if (*reneg_bytes =3D=3D 0 && cipher && (cipher_kt_block_size(cipher) <=
 128/8))

Should we also consider if *reneg_bytes > 64*1024*1024 and enforce
maximum?  This will not allow users to override the 64MB limit, though.

Perhaps we should allow reneg_bytes in to be overridden in v2.3 but
enforce it to max 64MB in v2.4 or v2.5.

> +    {
> +      msg (M_WARN, "WARNING: cipher with small block size in use, "
> +	   "reducing reneg-bytes to 64MB to mitigate SWEET32 attacks.");

Depending on what we do with the >64MB ... this might need to be
slightly reworded.  If we allow users to override the 64MB default, it
should probably say:   "... reneg-bytes is set to 64MB ...".  I find
"reducing" slightly misleading.

Also if we decide not to cap at 64MB in this case, we should print
another warning if --reneg-bytes is > 64MB.  I know this will be
somewhat annoying to users (imaginary #openvpn question: "I get so many
warnings now, why!? I want to get rid of them").  My experience is that
the more warnings we produce, the easier it is to convince users to fix
the issue rather to ignore them.

> +      *reneg_bytes =3D 64 * 1024 * 1024;
> +    }
> +}
> +
>  /*
>   * Max number of bytes we will add
>   * for data structures common to both
> @@ -1742,6 +1760,8 @@ tls_session_update_crypto_params(struct tls_session=
 *session,
>        msg (D_TLS_ERRORS, "TLS Error: server generate_key_expansion faile=
d");
>        goto cleanup;
>      }
> +  tls_limit_reneg_bytes (session->opt->key_type.cipher,
> +			 &session->opt->renegotiate_bytes);
>    ret =3D true;
>  cleanup:
>    CLEAR (*ks->key_src);
> @@ -2126,6 +2146,8 @@ key_method_2_write (struct buffer *buf, struct tls_=
session *session)
>  	}
>=20=20=09=09=20=20=20=20=20=20
>        CLEAR (*ks->key_src);
> +      tls_limit_reneg_bytes (session->opt->key_type.cipher,
> +			     &session->opt->renegotiate_bytes);
>      }
>=20=20
>    return true;
> @@ -2354,6 +2376,8 @@ key_method_2_read (struct buffer *buf, struct tls_m=
ulti *multi, struct tls_sessi
>  	}
>=20=20
>        CLEAR (*ks->key_src);
> +      tls_limit_reneg_bytes (session->opt->key_type.cipher,
> +			     &session->opt->renegotiate_bytes);
>      }

Regarding adding tls_limit_reneg_bytes() in key_method_2_{read,write}()
... How often will those functions be called?  Is it once per renegotiation?


--=20
kind regards,

David Sommerseth


--jHPKOo08gAt5vmNS0iP13eS2feLiiBK3V--

--a538NmnJ3BUNUMg1W36e74PBDopUXvBqw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYEgy4AAoJEIbPlEyWcf3yOzgP/3SZKHZ+gEgYtcPpUrOgBQGf
W2u/xOyy0lxTjM18mRJ4aXVDh3zV5xKsKRwiCWwwmfcxFM1LpztDFUht4yaqYsp1
bv/YxV6WRBNDIRYskBXJARWZRXGuSOTCHP4yreUnozGaH6EX1prT0SAkpX3joUJS
/QH7T8Q45Gwi0wAtAsVvuXKAnGetj8ip4FuD8SnACwvNAcciQkS01ThvfnsKkGGE
kQJK45IYlfxbBg/yT0OJ1hBMXO2Ac0DtP992C5Zg4vZ/nfqcy7pargplpS44VZhG
99Ys1rvTuh7VOdXbfyqPWPsk2xPxXkqBL68wZStlP8C6nKRvcm2rDZS/6FvAR8iG
tqQ2UhHKEtBhH/tjaAmesGU8Ws9s3CjIrzV/Fm6GI/6EqewRRMgRRyECmZLWYKRN
BK4UK6R45j9td9Abop46R2hzMf1rAx5U/LFTwV4geN8Zj11fqjCMJHpxfdAGrQ92
EZCT/AxWdU5oUhREbsC7WNjJvTyultC0rmk0AvCNzlXDJWMDHNhCykDGX7Z4qyRn
viMtWmQFo+yGTdT/NYl5Tuzrgp601OFBmGrYbqrf7wjCRcp6hDe4+b853VIP1itM
aonnv5g7Nkz+ztJ06BQDpwV8IA0DHR0W5L5/Uy7kg9BaEvFfexwN2gnyr95NTJ7Z
CK/brJ5OBMvctcPbrhYp
=K82n
-----END PGP SIGNATURE-----

--a538NmnJ3BUNUMg1W36e74PBDopUXvBqw--

