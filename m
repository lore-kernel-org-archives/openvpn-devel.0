Date: Mon, 26 Jun 2017 13:44:12 +0200
From: Christian Hesse <list@...1798...>
Message-ID: <20170626134412.4a4af754@...1799...>
In-Reply-To: <1498475606-8337-1-git-send-email-arne@...1227...>
References: <1498475606-8337-1-git-send-email-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/=MN37oLtofQAXe=L/T9lcmI";
	protocol="application/pgp-signature"
Subject: Re: [Openvpn-devel] [PATCH] Set tls-cipher restriction before
 loading certificates
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--Sig_/=MN37oLtofQAXe=L/T9lcmI
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Arne Schwabe <arne@...1227...> on Mon, 2017/06/26 13:13:
> OpenSSL 1.1 does not allow MD5 signed certificates by default anymore. Th=
is
> can be enabled again by settings tls-cipher "DEFAULT:@SECLEVEL=3D0" but o=
nly
> if the cipher list is set before loading the certificates. This patch
> changes the order of loading. --- src/openvpn/ssl.c | 8 +++++--- 1 file
> changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 29280dce..9ca300c0 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -616,6 +616,11 @@ init_ssl(const struct options *options, struct
> tls_root_ctx *new_ctx) tls_ctx_client_new(new_ctx);
>      }
>=20=20
> +    /* Allowable ciphers */
> +    /* Since @SECLEVEL also influces loading of certificates, set the
> +     * cipher restrictions before loading certificates */
> +    tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
> +
>      tls_ctx_set_options(new_ctx, options->ssl_flags);
>=20=20
>      if (options->pkcs12_file)
> @@ -708,9 +713,6 @@ init_ssl(const struct options *options, struct
> tls_root_ctx *new_ctx) tls_ctx_load_ecdh_params(new_ctx,
> options->ecdh_curve); }
>=20=20
> -    /* Allowable ciphers */
> -    tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
> -
>  #ifdef ENABLE_CRYPTO_MBEDTLS
>      /* Personalise the random by mixing in the certificate */
>      tls_ctx_personalise_random(new_ctx);

Looks good and tested on a server with CA and server certificates using MD5.
So ACK.
--=20
main(a){char*c=3D/*    Schoene Gruesse                         */"B?IJj;MEH"
"CX:;",b;for(a/*    Best regards             my address:    */=3D0;b=3Dc[a+=
+];)
putchar(b-1/(/*    Chris            cc -ox -xc - && ./x    */b/42*2-3)*42);}

--Sig_/=MN37oLtofQAXe=L/T9lcmI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEXHmveYAHrRp+prOviUUh18yA9HYFAllQ84wACgkQiUUh18yA
9HYEqQgAiLanSBdnYEP5KBcpqd4P227Fmcx5Yv5o9CwyTWWUib1QwWyRWnm9LdOE
FxBloDr2l3cvaV3pIJ8/hlm9NugpASr0is5EeNtAdt8x9Pi4bKgCYln6whCgqtZQ
rFew4/7WLSMsg1WA9dfXjxmPPEWKsR4vKUxWIHwy7QX/qnlhGvUQWgmWNnX7Hvru
oFljOJQzgM54/yemz5jmdG4W2gLuAZ9xPdJRfB/TRwTUqQbBGR5LpE3RSpFsLtyc
OeXSf+NwLfwp9IKowMpIoIEQ2bGsNcv+aq2Sw3ajP+6Wmvg5f7hXkklc16ntWSR3
OXMlwbIm/KFmqb5ysJfhV6cZd+MgOA==
=RqTv
-----END PGP SIGNATURE-----

--Sig_/=MN37oLtofQAXe=L/T9lcmI--

