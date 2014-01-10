Message-ID: <52D077EC.9020803@...1114...>
Date: Fri, 10 Jan 2014 23:45:00 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1389371142-26705-1-git-send-email-gert@...1296...>
In-Reply-To: <1389371142-26705-1-git-send-email-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="tFGkl6uwALHKcOORNeCnWpcLtKtl3Hrp9"
Subject: Re: [Openvpn-devel] [PATCH 1/2] remove some "unused variable"
	warnings
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tFGkl6uwALHKcOORNeCnWpcLtKtl3Hrp9
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 10/01/14 17:25, Gert Doering wrote:
> Signed-off-by: Gert Doering <gert@...1296...>
> ---
>  src/openvpn/comp-lz4.c | 1 -
>  src/openvpn/options.c  | 2 ++
>  src/openvpn/ssl.c      | 3 +--
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
> index afa43b1..4651148 100644
> --- a/src/openvpn/comp-lz4.c
> +++ b/src/openvpn/comp-lz4.c
> @@ -64,7 +64,6 @@ lz4_compress (struct buffer *buf, struct buffer work,
>  	       struct compress_context *compctx,
>  	       const struct frame* frame)
>  {
> -  int result;
>    bool compressed =3D false;
>=20=20
>    if (buf->len <=3D 0)
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 0803da7..9e21d5a 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2425,7 +2425,9 @@ options_postprocess_mutate_ce (struct options *o, s=
truct connection_entry *ce)
>  static void
>  options_postprocess_mutate_invariant (struct options *options)
>  {
> +#ifdef WIN32
>    const int dev =3D dev_type_enum (options->dev, options->dev_type);
> +#endif
>=20=20
>    /*
>     * In forking TCP server mode, you don't need to ifconfig
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 15518ca..c61701a 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1331,7 +1331,7 @@ tls1_P_hash(const md_kt_t *md_kt,
>  	    int olen)
>  {
>    struct gc_arena gc =3D gc_new ();
> -  int chunk,n;
> +  int chunk;
>    hmac_ctx_t ctx;
>    hmac_ctx_t ctx_tmp;
>    uint8_t A1[MAX_HMAC_KEY_LENGTH];
> @@ -1357,7 +1357,6 @@ tls1_P_hash(const md_kt_t *md_kt,
>    hmac_ctx_update(&ctx,seed,seed_len);
>    hmac_ctx_final(&ctx, A1);
>=20=20
> -  n=3D0;
>    for (;;)
>      {
>        hmac_ctx_reset(&ctx);
>=20

ACK.  Compiles nicely on one of my systems, changes are quite obvious too.

--=20
kind regards,

David Sommerseth


--tFGkl6uwALHKcOORNeCnWpcLtKtl3Hrp9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLQd+wACgkQDC186MBRfrpG3QCfeOA6itESEVCUK3r4jTMAMUFi
maUAnAuJnvgwlA7ZtBRk7zqVIhQZqlXX
=g2wq
-----END PGP SIGNATURE-----

--tFGkl6uwALHKcOORNeCnWpcLtKtl3Hrp9--

