Date: Wed, 20 Jun 2018 07:00:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180620050012.GR57262@...1296...>
References: <20180620044650.18041-1-rosenp@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uWYqsj5fbtgVoVlo"
Content-Disposition: inline
In-Reply-To: <20180620044650.18041-1-rosenp@...277...>
Subject: Re: [Openvpn-devel] [PATCH] OpenSSL: Fix compilation with
 deprecated APIs disabled on 1.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rosen Penev <rosenp@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--uWYqsj5fbtgVoVlo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jun 19, 2018 at 09:46:50PM -0700, Rosen Penev wrote:
> Signed-off-by: Rosen Penev <rosenp@...277...>
> ---
>  src/openvpn/crypto_openssl.c     |  9 +++++++++
>  src/openvpn/ssl_openssl.c        | 32 +++++++++++++++++++++++++++++++-
>  src/openvpn/ssl_verify_openssl.c |  1 +
>  3 files changed, 41 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
> index 4fb2f6d6..816d8002 100644
> --- a/src/openvpn/crypto_openssl.c
> +++ b/src/openvpn/crypto_openssl.c
> @@ -670,11 +670,16 @@ cipher_ctx_init(EVP_CIPHER_CTX *ctx, const uint8_t =
*key, int key_len,
>  {
>      ASSERT(NULL !=3D kt && NULL !=3D ctx);
>=20=20
> +#if OPENSSL_VERSION_NUMBER < 0x10100000L
>      EVP_CIPHER_CTX_init(ctx);
> +#else
> +    EVP_CIPHER_CTX_new();
> +#endif

Thanks for the patch, but this is not the way we want our source to
look like.  As in: these extra #if will make maintaining the code
harder and more error-prone.


A patch along the lines of the existing openssl 1.1 / 1.0 compat layer
(the .c files call the 1.1 API and if that API is not available,=20
openssl_compat.h provides a substitute function) would be something
we might look more closely into.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--uWYqsj5fbtgVoVlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbKd9cAAoJEB2Cnv7KVigSGCYL/ig12nbAH5EH7wkUGcvsLErY
tIhxv/JiYjxuLrpHFhGr8hjYC6YiCJusarKVBeV1+x1ZI9v+4LiiDPIj2DeWAovW
YN8d883for1Lp1W/Hx65W2CGm7KQr+9TY9lmECNACdCkgZSOzUXtPcYNXp4sE2oF
+fQMsONs5ihpAfw7lubSpuAFmeGy+Gh/iH4ziDSZjghyPt4fTIaqfTzuExkp8GCP
p8QOs5cL1uqBM2pNWUbuMJ0xi4UsWFwVgC/1i9MxsYr6ULfJQ6BGfPQr0Vn3PP/2
G98qteWPGJd+Am8co3jvJgcxOA7h8eaH9ljujwFWfW5IJ41ngmhW6JP1OpCeAFer
FwmiAbSkK16+a7H2qdLYIZ5c2SmufhuH5kiw4rnJEfoAWf/ZenvmYLNVJvXQ4NqO
YTW/XGo6L54IccVMAVqayyF8Tm9mOOXo0PQhryDE+KxAk4j2DZyNS1dImLEJzcD4
reeIHo0eB9yRFHDjtXV16qCAB6RhPRQnJSHrNuE88w==
=FTDD
-----END PGP SIGNATURE-----

--uWYqsj5fbtgVoVlo--

