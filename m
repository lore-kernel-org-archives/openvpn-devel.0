Message-ID: <4F55E287.2000903@...515...>
Date: Tue, 06 Mar 2012 12:10:15 +0200
From: =?ISO-8859-1?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
	<1330546342-17794-5-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-5-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 04/52] cleanup: remove C++ warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "Openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>


> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  httpdigest.c   |    4 ++--
>  init.c         |    2 +-
>  misc.c         |    6 +++---
>  options.c      |    4 ++--
>  socket.c       |    4 ++--
>  ssl_polarssl.c |    6 ++++--
>  6 files changed, 14 insertions(+), 12 deletions(-)
>
> diff --git a/httpdigest.c b/httpdigest.c
> index 5907637..1aa19ae 100644
> --- a/httpdigest.c
> +++ b/httpdigest.c
> @@ -111,7 +111,7 @@ DigestCalcResponse(
>    md_ctx_t md5_ctx;
>    const md_kt_t *md5_kt =3D md_kt_get("MD5");
>=20=20
> -  // calculate H(A2)
> +  /* calculate H(A2) */
>    md_ctx_init(&md5_ctx, md5_kt);
>    md_ctx_update(&md5_ctx, pszMethod, strlen(pszMethod));
>    md_ctx_update(&md5_ctx, ":", 1);
> @@ -124,7 +124,7 @@ DigestCalcResponse(
>    md_ctx_final(&md5_ctx, HA2);
>    CvtHex(HA2, HA2Hex);
>=20=20
> -  // calculate response
> +  /* calculate response */
>    md_ctx_init(&md5_ctx, md5_kt);
>    md_ctx_update(&md5_ctx, HA1, HASHHEXLEN);
>    md_ctx_update(&md5_ctx, ":", 1);
> diff --git a/init.c b/init.c
> index fb8fe00..d2ad318 100644
> --- a/init.c
> +++ b/init.c
> @@ -745,7 +745,7 @@ init_static (void)
>      uint8_t rndbuf[8];
>      int i;
>      prng_init ("sha1", 16);
> -    //prng_init (NULL, 0);
> +    /*prng_init (NULL, 0);*/
>      const int factor =3D 1;
>      for (i =3D 0; i < factor * 8; ++i)
>        {
> diff --git a/misc.c b/misc.c
> index a07780f..2a1c1c9 100644
> --- a/misc.c
> +++ b/misc.c
> @@ -2457,17 +2457,17 @@ argv_test (void)
>    argv_printf (&a, "%sc foo bar %s", "c:\\\\src\\\\test\\\\jyargs.exe", =
"foo bar");
>    argv_msg_prefix (M_INFO, &a, "ARGV");
>    msg (M_INFO, "ARGV-S: %s", argv_system_str(&a));
> -  //openvpn_execve_check (&a, NULL, 0, "command failed");
> +  /*openvpn_execve_check (&a, NULL, 0, "command failed");*/
>=20=20
>    argv_printf (&a, "%sc %s %s", "c:\\\\src\\\\test files\\\\batargs.bat"=
, "foo", "bar");=20=20
>    argv_msg_prefix (M_INFO, &a, "ARGV");
>    msg (M_INFO, "ARGV-S: %s", argv_system_str(&a));
> -  //openvpn_execve_check (&a, NULL, 0, "command failed");
> +  /*openvpn_execve_check (&a, NULL, 0, "command failed");*/
>=20=20
>    argv_printf (&a, "%s%sc foo bar %s %s/%d %d %u", "/foo", "/bar.exe", "=
one two", "1.2.3.4", 24, -69, 96);
>    argv_msg_prefix (M_INFO, &a, "ARGV");
>    msg (M_INFO, "ARGV-S: %s", argv_system_str(&a));
> -  //openvpn_execve_check (&a, NULL, 0, "command failed");
> +  /*openvpn_execve_check (&a, NULL, 0, "command failed");*/
>=20=20
>    argv_printf (&a, "this is a %s test of int %d unsigned %u", "FOO", -69=
, 42);
>    s =3D argv_str (&a, &gc, PA_BRACKET);
> diff --git a/options.c b/options.c
> index 3d8085c..f11849d 100644
> --- a/options.c
> +++ b/options.c
> @@ -4764,7 +4764,7 @@ add_option (struct options *options,
>      }
>    else if (streq (p[0], "fragment") && p[1])
>      {
> -//      VERIFY_PERMISSION (OPT_P_MTU);
> +/*      VERIFY_PERMISSION (OPT_P_MTU); */
>        VERIFY_PERMISSION (OPT_P_MTU|OPT_P_CONNECTION);
>        options->ce.fragment =3D positive_atoi (p[1]);
>      }
> @@ -5118,7 +5118,7 @@ add_option (struct options *options,
>    else if (streq (p[0], "explicit-exit-notify"))
>      {
>        VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
> -//      VERIFY_PERMISSION (OPT_P_EXPLICIT_NOTIFY);
> +/*      VERIFY_PERMISSION (OPT_P_EXPLICIT_NOTIFY); */
>        if (p[1])
>  	{
>  	  options->ce.explicit_exit_notification =3D positive_atoi (p[1]);
> diff --git a/socket.c b/socket.c
> index 1a772af..61265e4 100644
> --- a/socket.c
> +++ b/socket.c
> @@ -3106,7 +3106,7 @@ openvpn_inet_ntop(int af, const void *src, char *ds=
t, socklen_t size)
>      default:
>        ASSERT (0);
>    }
> -  // cannot direclty use &size because of strict aliasing rules
> +  /* cannot direclty use &size because of strict aliasing rules */
>    return (WSAAddressToString((struct sockaddr *)&ss, sizeof(ss), NULL, d=
st, &s) =3D=3D 0)?
>            dst : NULL;
>  }
> @@ -3119,7 +3119,7 @@ openvpn_inet_pton(int af, const char *src, void *ds=
t)
>    char src_copy[INET6_ADDRSTRLEN+1];
>=20=20
>    CLEAR(ss);
> -  // stupid non-const API
> +  /* stupid non-const API */
>    strncpynt(src_copy, src, INET6_ADDRSTRLEN+1);
>=20=20
>    if (WSAStringToAddress(src_copy, af, NULL, (struct sockaddr *)&ss, &si=
ze) =3D=3D 0) {
> diff --git a/ssl_polarssl.c b/ssl_polarssl.c
> index c50cf0a..02dc233 100644
> --- a/ssl_polarssl.c
> +++ b/ssl_polarssl.c
> @@ -324,8 +324,10 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, co=
nst char *priv_key_file
>    warn_if_group_others_accessible (priv_key_file);
>=20=20
>    /* TODO: Check Private Key */
> -//  if (!SSL_CTX_check_private_key (ctx))
> -//    msg (M_SSLERR, "Private key does not match the certificate");
> +#if 0
> +  if (!SSL_CTX_check_private_key (ctx))
> +    msg (M_SSLERR, "Private key does not match the certificate");
> +#endif
>    return 0;
>  }
>=20=20
The C++ style commenting[1] has not spread widely in OpenVPN:

$ grep "//" *.c|less

Although this commenting style has been valid in C since C99 (year
2000), the actual C99 implementations seem to be incomplete[2]. So, just
to be on the safe side, I'll give this one an ACK.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[1] <http://en.wikipedia.org/wiki/C_syntax#Comments>
[2] <http://en.wikipedia.org/wiki/C99#Implementations>

