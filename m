References: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
	<1478636302-9678-5-git-send-email-steffan.karger@...1435...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ebff9678-bfd1-845d-8d1c-16b9eef8be36@...2080...>
Date: Sat, 12 Nov 2016 12:44:29 +0100
MIME-Version: 1.0
In-Reply-To: <1478636302-9678-5-git-send-email-steffan.karger@...1435...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="8F3OhS1TJEVElRQ7BSNHiq2hViXWGqW6x"
Subject: Re: [Openvpn-devel] [PATCH 4/5] Move private file access checks to
 options_postprocess_filechecks()
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
--8F3OhS1TJEVElRQ7BSNHiq2hViXWGqW6x
Content-Type: multipart/mixed; boundary="FHqj0WuTQ9IXDsajaOALIToXm0IH199ck";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan.karger@...1435...>,
	openvpn-devel@lists.sourceforge.net
Message-ID: <ebff9678-bfd1-845d-8d1c-16b9eef8be36@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 4/5] Move private file access checks to
	options_postprocess_filechecks()
References: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
	<1478636302-9678-5-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1478636302-9678-5-git-send-email-steffan.karger@...1435...>

--FHqj0WuTQ9IXDsajaOALIToXm0IH199ck
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 08/11/16 21:18, Steffan Karger wrote:
> From: Steffan Karger <steffan@...1856...>
>=20
> This removes the dependency of crypto.c on misc.c, which makes testing
> (stuff that needs) crypto.c functionality easier.  In particular, this
> simplifies the --tls-crypt tests in one of the follow-up patches.
>=20
> Apart from that, testing file access really belongs in
> options_postprocess_filechecks(), and moving it there enables us to
> perform the same check for other private files too.
>=20
> Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> ---
>  src/openvpn/crypto.c  |  5 +----
>  src/openvpn/options.c | 36 ++++++++++++++++++++++--------------
>  2 files changed, 23 insertions(+), 18 deletions(-)

These are code paths I know fairly well :)

> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index e9dc17e..c576e6e 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
[...snip...]
> @@ -2850,10 +2856,12 @@ options_postprocess_filechecks (struct options *o=
ptions)
>  #ifdef MANAGMENT_EXTERNAL_KEY
>    if(!(options->management_flags & MF_EXTERNAL_KEY))
>  #endif
> -     errs |=3D check_file_access (CHKACC_FILE|CHKACC_INLINE, options->pr=
iv_key_file, R_OK,
> -                             "--key");
> -  errs |=3D check_file_access (CHKACC_FILE|CHKACC_INLINE, options->pkcs1=
2_file, R_OK,
> -                             "--pkcs12");
> +    {
> +      errs |=3D check_file_access (CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIV=
ATE,
> +	  options->priv_key_file, R_OK, "--key");
> +    }
> +  errs |=3D check_file_access (CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
> +      options->pkcs12_file, R_OK, "--pkcs12");

I'd prefer to have the arguments continuation aligned with the
CHKACC_FILE, but this is code style bike-shedding.  However that is what
we do in the rest of this scope.

>    if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
>      errs |=3D check_file_access_chroot (options->chroot_dir, CHKACC_FILE=
, options->crl_file, R_OK|X_OK,
> @@ -2862,26 +2870,26 @@ options_postprocess_filechecks (struct options *o=
ptions)
>      errs |=3D check_file_access_chroot (options->chroot_dir, CHKACC_FILE=
|CHKACC_INLINE,
>                                        options->crl_file, R_OK, "--crl-ve=
rify");
>=20=20
> -  errs |=3D check_file_access (CHKACC_FILE|CHKACC_INLINE, options->tls_a=
uth_file, R_OK,
> -                             "--tls-auth");
> -  errs |=3D check_file_access (CHKACC_FILE|CHKACC_INLINE, options->tls_c=
rypt_file, R_OK,
> -                             "--tls-crypt");
> -  errs |=3D check_file_access (CHKACC_FILE|CHKACC_INLINE, options->share=
d_secret_file, R_OK,
> -                             "--secret");
> +  errs |=3D check_file_access (CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
> +      options->tls_auth_file, R_OK, "--tls-auth");
> +  errs |=3D check_file_access (CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
> +      options->tls_crypt_file, R_OK, "--tls-crypt");
> +  errs |=3D check_file_access (CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
> +      options->shared_secret_file, R_OK, "--secret");
>    errs |=3D check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR,
> -                             options->packet_id_file, R_OK|W_OK, "--repl=
ay-persist");
> +      options->packet_id_file, R_OK|W_OK, "--replay-persist");
>=20=20
>    /* ** Password files ** */
> -  errs |=3D check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
> +  errs |=3D check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN|CHKACC_PRIVA=
TE,
>                               options->key_pass_file, R_OK, "--askpass");

Here the indent is as expected though :)

>  #endif /* ENABLE_CRYPTO */
>  #ifdef ENABLE_MANAGEMENT
> -  errs |=3D check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
> +  errs |=3D check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN|CHKACC_PRIVA=
TE,
>                               options->management_user_pass, R_OK,
>                               "--management user/password file");
>  #endif /* ENABLE_MANAGEMENT */
>  #if P2MP
> -  errs |=3D check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
> +  errs |=3D check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN|CHKACC_PRIVA=
TE,
>                               options->auth_user_pass_file, R_OK,
>                               "--auth-user-pass");
>  #endif /* P2MP */
>=20

Patch looks good to me.  Good clean-up moving
warn_if_group_others_accessible() to these code paths.  But I have one
comment.

I see that warn_if_group_others_accessible() is still called from
ssl_{mbedtls,openssl}.c ... seems to be used in tls_ctx_load_priv_file()
and tls_ctx_load_pkcs12().  Are those checks needed now?  If not, maybe
move warn_if_group_others_accessible() to options.c as well?

With these issues resolved, it's an ACK from me.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--FHqj0WuTQ9IXDsajaOALIToXm0IH199ck--

--8F3OhS1TJEVElRQ7BSNHiq2hViXWGqW6x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYJwCdAAoJEIbPlEyWcf3yNmkQAJrC3xGeApIPK5Tozlm2DJHx
9vdaL90bN0YqMzaUlciYXNamP+wsTxWuyhztX9RFlgYxmLZZamXqTBgQEFs3sSsr
vcqxpZVkbB7ILCuuVOyaKNdmIxDy4C/IExT3GfBiDK7/Xc4K7T6a4rCUYFffizy6
zHm4+7n37c8fGSgSlyu8QUnAg/7qFNyPtUhaUjRdRzAd8XBTGZJ6vKhMNw+joV1h
SHnFd3ivZlbukmF3wku9rxKtSHsSk4OnzMosDzCviXT+4bEuQosgqGfEELvAXVgW
O6jtUpcFzrFDZS/aU6XvUUZKnd7mv87qHAnFzU+eNUykYz0yRmsb2urYS4tPXpzK
A3kyqqVbHkeRi7usoNrbptcnl+z9ozMXwe/sxT34wim3eW1cJnde+eEnxIT6jhOL
hpe1PQzCUc0T62ZCz7siqT34C42xwb6tPTSrZ5bz4M+eLzdKQfKDh8C7RT0Eh/y/
5k7ww2sEeKVii23GLNjEEXWqvRBDftLqcGPp8u8b07ggskBdhTzPG36CKlLI1YHg
TqHHkuT0gp5VaWeyChm7MOBxXj4kUbKepxOwdAH1uGJl1OT0qdfoltoboaGR7QRf
hbNdZy5b9W92LlAllu5EFs2CtskujHs+Bs8hHPhpWwwcBUTzp1+vfDQp4BmZ3akA
GVPlyghftpuOvGogA82T
=9Awr
-----END PGP SIGNATURE-----

--8F3OhS1TJEVElRQ7BSNHiq2hViXWGqW6x--

