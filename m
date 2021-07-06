Date: Tue, 06 Jul 2021 20:07:10 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <0jKpsgdf-BFbosK4Fbg3h8eefKrfcLeoLy_oWTvmBvkV2XBz6Z239PZIV55jFOX-AvMBs9XNoI_pig8MzFIHEU3KU21tcWFE7nmOei3OaBE=@protonmail.com>
In-Reply-To: <20210706135758.3134542-1-arne@...1227...>
References: <20210520151148.2565578-7-arne@...1227...>
 <20210706135758.3134542-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_XWfNJksFMZpa21L4QrILoSdTt7bm0LTSra5W9WE"
Subject: Re: [Openvpn-devel] [PATCH v3 7/9] Cleanup handling of initial auth
 token
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

This is a multi-part message in MIME format.

--b1_XWfNJksFMZpa21L4QrILoSdTt7bm0LTSra5W9WE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi,

this is a comment about a comment which this patch is not changing
but the comment is so awful I thought it best to make a note.
See below.

Also, two typos. And FYI, 'anymore' ought to be 'any more'

R

Sent with ProtonMail Secure Email, which still cannot handle diffs.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90

On Tuesday, July 6th, 2021 at 14:57, Arne Schwabe <arne@...1227...> wrote:

> This changes that auth_token_initial is set when the token is
> initially generated instead when pushing the token. Even I do not know
> anymore why I did it in this way in the first place. Also use
> multi->auth_token_initial as source for the sesssion ID since it should

sesssion -> session

> now always be available.
>
> Since the change makes auth_token_initial always available we need to add
> a check to only send a PUSH reply to update the token on renegotiations.
> The old code relied on multi->auth_token not being set in this case.
>
> This commit also removes the workaround for old OpenVPN clients. These
> were only available as commercial OpenVPN Connect client and not in use
> anymore.
>
> Patch V2: rebase.
> Patch V3: fix formatting, clarifying commit message, remove initial
>           token workaround for old v3.
>
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/man-sections/server-options.rst        |  4 +--
>  src/openvpn/auth_token.c                   | 34 ++++++++++++----------
>  src/openvpn/push.c                         |  8 -----
>  src/openvpn/ssl_common.h                   |  4 +--
>  src/openvpn/ssl_verify.c                   |  6 ++--
>  tests/unit_tests/openvpn/test_auth_token.c |  7 +++--
>  6 files changed, 32 insertions(+), 31 deletions(-)
>
> diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/serve=
r=3D
> -options.rst
> index 047f2270f..1ab00e81b 100644
> --- a/doc/man-sections/server-options.rst
> +++ b/doc/man-sections/server-options.rst
> @@ -35,7 +35,7 @@ fast hardware. SSL/TLS authentication must be used in t=
h=3D
> is mode.
>    token is reached or after not being renewed for more than 2 \*
>    ``reneg-sec`` seconds. Clients will be sent renewed tokens on every TLS
>    renogiation to keep the client's token updated. This is done to

I know this is not in this patch but .. renogiation -> renegotiation


> -  invalidate a token if a client is disconnected for a sufficently long
> +  invalidate a token if a client is disconnected for a sufficiently long
>    time, while at the same time permitting much longer token lifetimes for
>    active clients.
>
> @@ -46,7 +46,7 @@ fast hardware. SSL/TLS authentication must be used in t=
h=3D
> is mode.
>    When the :code:`external-auth` keyword is present the normal
>    authentication method will always be called even if auth-token succeed=
s=3D
> .
>    Normally other authentications method are skipped if auth-token
> -  verification suceeds or fails.
> +  verification succeeds or fails.
>
>    This option postpones this decision to the external authentication
>    methods and checks the validity of the account and do other checks.
> diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
> index 0ea6d1832..a681d726f 100644
> --- a/src/openvpn/auth_token.c
> +++ b/src/openvpn/auth_token.c
> @@ -109,11 +109,11 @@ add_session_token_env(struct tls_session *session, =
s=3D
> truct tls_multi *multi,
>          /*
>           * No session before, generate a new session token for the new s=
e=3D
> ssion
>           */
> -        if (!multi->auth_token)
> +        if (!multi->auth_token_initial)
>          {
>              generate_auth_token(up, multi);
>          }
> -        session_id_source =3D3D multi->auth_token;
> +        session_id_source =3D3D multi->auth_token_initial;
>      }
>      /*
>       * In the auth-token the auth token is already base64 encoded
> @@ -184,7 +184,7 @@ generate_auth_token(const struct user_pass *up, struc=
t=3D
>  tls_multi *multi)
>
>      uint8_t sessid[AUTH_TOKEN_SESSION_ID_LEN];
>
> -    if (multi->auth_token)
> +    if (multi->auth_token_initial)
>      {
>          /* Just enough space to fit 8 bytes+ 1 extra to decode a non pad=
d=3D
> ed
>           * base64 string (multiple of 3 bytes). 9 bytes =3D3D> 12 bytes =
bas=3D
> e64
> @@ -192,11 +192,14 @@ generate_auth_token(const struct user_pass *up, str=
u=3D
> ct tls_multi *multi)
>           */
>          char old_tstamp_decode[9];
>
> +        /* Make a copy of the string to not modify multi->auth_token_ini=
t=3D
> ial */
> +        char* initial_token_copy =3D3D string_alloc(multi->auth_token_in=
iti=3D
> al, &gc);
> +
>          /*
>           * reuse the same session id and timestamp and null terminate it=
 =3D
> at
>           * for base64 decode it only decodes the session id part of it
>           */

For the sake of readability:

/*
 * reuse the same session id and timestamp and null terminate it at
 * for base64 decode it only decodes the session id part of it
 */

What does this mean ? I can't decipher it ..


> -        char *old_sessid =3D3D multi->auth_token + strlen(SESSION_ID_PRE=
FIX=3D
> );
> +        char *old_sessid =3D3D initial_token_copy + strlen(SESSION_ID_PR=
EFI=3D
> X);
>          char *old_tsamp_initial =3D3D old_sessid + AUTH_TOKEN_SESSION_ID=
_LE=3D
> N*8/6;
>
>          old_tsamp_initial[12] =3D3D '\0';
> @@ -212,10 +215,6 @@ generate_auth_token(const struct user_pass *up, stru=
c=3D
> t tls_multi *multi)
>
>          old_tsamp_initial[0] =3D3D '\0';
>          ASSERT(openvpn_base64_decode(old_sessid, sessid, AUTH_TOKEN_SESS=
I=3D
> ON_ID_LEN)=3D3D=3D3DAUTH_TOKEN_SESSION_ID_LEN);
> -
> -
> -        /* free the auth-token, we will replace it with a new one */
> -        free(multi->auth_token);
>      }
>      else if (!rand_bytes(sessid, AUTH_TOKEN_SESSION_ID_LEN))
>      {
> @@ -272,11 +271,22 @@ generate_auth_token(const struct user_pass *up, str=
u=3D
> ct tls_multi *multi)
>
>      free(b64output);
>
> +    /* free the auth-token if defined, we will replace it with a new one=
 =3D
> */
> +    free(multi->auth_token);
>      multi->auth_token =3D3D strdup((char *)BPTR(&session_token));
>
>      dmsg(D_SHOW_KEYS, "Generated token for client: %s (%s)",
>           multi->auth_token, up->username);
>
> +    if (!multi->auth_token_initial)
> +    {
> +        /*
> +         * Save the initial auth token to continue using the same sessio=
n=3D
>  ID
> +         * and timestamp in updates
> +         */
> +        multi->auth_token_initial =3D3D strdup(multi->auth_token);
> +    }
> +
>      gc_free(&gc);
>  }
>
> @@ -353,13 +363,7 @@ verify_auth_token(struct user_pass *up, struct tls_m=
u=3D
> lti *multi,
>      bool in_renog_time =3D3D now >=3D3D timestamp
>                           && now < timestamp + 2 * session->opt->renegoti=
a=3D
> te_seconds;
>
> -    /* We could still have a client that does not update
> -     * its auth-token, so also allow the initial auth-token */
> -    bool initialtoken =3D3D multi->auth_token_initial
> -                        && memcmp_constant_time(up->password, multi->aut=
h=3D
> _token_initial,
> -                                                strlen(multi->auth_token=
_=3D
> initial)) =3D3D=3D3D 0;
> -
> -    if (!in_renog_time && !initialtoken)
> +    if (!in_renog_time)
>      {
>          ret |=3D3D AUTH_TOKEN_EXPIRED;
>      }
> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
> index f4957f147..53cb7ca6f 100644
> --- a/src/openvpn/push.c
> +++ b/src/openvpn/push.c
> @@ -527,14 +527,6 @@ prepare_auth_token_push_reply(struct tls_multi *tls_=
m=3D
> ulti, struct gc_arena *gc,
>          push_option_fmt(gc, push_list, M_USAGE,
>                          "auth-token %s",
>                          tls_multi->auth_token);
> -        if (!tls_multi->auth_token_initial)
> -        {
> -            /*
> -             * Save the initial auth token for clients that ignore
> -             * the updates to the token
> -             */
> -            tls_multi->auth_token_initial =3D3D strdup(tls_multi->auth_t=
oke=3D
> n);
> -        }
>      }
>  }
>
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 43d6276be..1914a0015 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -597,8 +597,8 @@ struct tls_multi
>                            *   user/pass authentications in this session.
>                            */
>      char *auth_token_initial;
> -    /**< The first auth-token we sent to a client, for clients that do
> -     * not update their auth-token (older OpenVPN3 core versions)
> +    /**< The first auth-token we sent to a client. We use this to rememb=
e=3D
> r
> +     * the session ID and initial timestamp when generating new auth-tok=
e=3D
> n.
>       */
>  #define  AUTH_TOKEN_HMAC_OK              (1<<0)
>      /**< Auth-token sent from client has valid hmac */
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index bbb1878a3..61dde1791 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -1639,7 +1639,9 @@ verify_user_pass(struct user_pass *up, struct tls_m=
u=3D
> lti *multi,
>           * Otherwise the auth-token get pushed out as part of the "norma=
l=3D
> "
>           * push-reply
>           */
> -        if (multi->auth_token_initial)
> +        bool is_renegotiation =3D3D session->key[KS_PRIMARY].key_id !=3D=
3D 0;
> +
> +        if (multi->auth_token_initial && !is_renegotiation)
>          {
>              /*
>               * We do not explicitly schedule the sending of the
> @@ -1648,7 +1650,7 @@ verify_user_pass(struct user_pass *up, struct tls_m=
u=3D
> lti *multi,
>               * established and furthermore since this is called in
>               * the middle of authentication, there are other messages
>               * (new data channel keys) that are sent anyway and will
> -             * trigger schedueling
> +             * trigger scheduling
>               */
>              send_push_reply_auth_token(multi);
>          }
> diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_test=
s=3D
> /openvpn/test_auth_token.c
> index 4030052e0..a504eed91 100644
> --- a/tests/unit_tests/openvpn/test_auth_token.c
> +++ b/tests/unit_tests/openvpn/test_auth_token.c
> @@ -174,7 +174,10 @@ auth_token_test_timeout(void **state)
>
>      now =3D3D 100000;
>      generate_auth_token(&ctx->up, &ctx->multi);
> +
>      strcpy(ctx->up.password, ctx->multi.auth_token);
> +    free(ctx->multi.auth_token_initial);
> +    ctx->multi.auth_token_initial =3D3D NULL;
>
>      /* No time has passed */
>      assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->sessi=
o=3D
> n),
> @@ -244,10 +247,10 @@ auth_token_test_known_keys(void **state)
>
>      now =3D3D 0;
>      /* Preload the session id so the same session id is used here */
> -    ctx->multi.auth_token =3D3D strdup(now0key0);
> +    ctx->multi.auth_token_initial =3D3D strdup(now0key0);
>
>      /* Zero the hmac part to ensure we have a newly generated token */
> -    zerohmac(ctx->multi.auth_token);
> +    zerohmac(ctx->multi.auth_token_initial);
>
>      generate_auth_token(&ctx->up, &ctx->multi);
>
> --
> 2.32.0
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJg5LfeACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ2UwQf9HRGKdMwuFN5gofphNKjx5u5PnF3woa+LOmg12VHHc99K+JHB
5S7UmRMbt7V+i67paCYMZ54YPE6jeB30UHqw/GY9Rwx+fnh6Qq0Hv8mwvKKz
lM4jweoYCmZKIFcHj8C3UxbOIMugK1F7HSj2s7M7NsF6OqF2ursQQtQHhi80
1HBcYjADWNGufli8JC7CPUNp7MDzKAXu/HK9sxsrIp0B4YAft3WF3+U1OhVt
sOAz0KghaX3tllfqbblNoQGfwzowP78Rxc9jh2dSzsEtl2C6HNSGvDcXjGdS
DT9whFFw8mYkIJ/OPwUDsn8k3sxagYeE0h8X3eppojRgC2JDmRO0Ng=3D=3D
=3DDq71
-----END PGP SIGNATURE-----

--b1_XWfNJksFMZpa21L4QrILoSdTt7bm0LTSra5W9WE
Content-Type: application/pgp-keys; name="publickey - tincantech@...2282... - 0x09BC3D44.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjEwLjEwDQpDb21tZW50OiBodHRwczovL29wZW5wZ3Bqcy5vcmcNCg0KeHNCTkJGdndTY2NC
Q0FET21IRW5RbExtT2pKUnRKTDJsNTNNTHd3RlR5N1huRXBzM2IxUTBVd1dZRkN2DQpMMm9OcDBu
cmRHbEtLREpxNTBZMDlTUitVUllCUW1LbVkzRW16cHlVSUtNL3JnbzFSeXViSHBNUkhiRHANCjdK
cDhMeGtmZkZCVkpqL3Q1Vk1wRDZlTVI2YVVjaVFqZ1JMOE5aZTYrVDd4ZlhYWHdWNWhvUmVaM2pP
Kw0KekhpNlNSN3hUdkdYbGErTVF6NkVFcFdubGJMdmcyb3J0OUtzZXVWallycXZSTXhjZFAwbzlj
WldKNWVwDQpKTm1nZUI2TTcrT1cwOFUxU3NYdEtycExSY0k2eUttVjM4amh6UHIyWmdQOXJtcmxF
clIvMWlxUVFIWFkNCm84LzBEZlB5RjBtSDl5blFJaUxFL2wrRll1NHJzRzhWaUtseGhYY3plUHpB
dExDamlCMGEwbVJWQUJFQg0KQUFITk55SjBhVzVqWVc1MFpXTm9RSEJ5YjNSdmJtMWhhV3d1WTI5
dElpQThkR2x1WTJGdWRHVmphRUJ3DQpjbTkwYjI1dFlXbHNMbU52YlQ3Q3dIOEVFQUVJQUNrRkFs
dndTY2NHQ3drSENBTUNDUkJQbDV6MmE1QzQNCm5RUVZDQW9DQXhZQ0FRSVpBUUliQXdJZUFRQUtD
UkJQbDV6MmE1QzRuUUJEQi85WlVvOUJPWEpSNjFObQ0KMDJvWi84YVJYTzlOblVTRnQ2R0xPV2NE
TnZBczRJSldNRFZFUWZZYW5iKzQyMVFOZC81ZDZIMWlYRitpDQo0TERLME02YWdDK2dzTkZKbmpQ
R0l0dlB0ajdXeWp5blpSeDhENDBQUFhpZ2ZIWXV3Mm9SdTBscitQMXANCjFxZVVlNE5iY3FJdjhJ
SXZMejJ6Q2xZWk9OZ0FzUVZjTkFIaTdaNG9ydFEyaW8yQkFWai84MTlKUFlNdA0KdEhnWTgxd1Mx
Vjd2OEdEVFpnOG9hUGhYR2ZhQzRUWkZHdFpyL2J5YmNxcnNvMzVqYVFtQzU0eE1iWHBGDQpBVXJj
M3VHVk9IK09kRy9CVzJnY1lxcHZVRkJ1a1h4Q1VCWUhQMk5mWGhOZnpHdDluQzF1bE5LWWVQMTkN
ClRHbE9vckJNWUlBRUhvR3h2cGJVWGZiYU5XQ1V6c0JOQkZ2d1NjY0JDQUM5S3lWWlJTNWFNYUc1
UGkwbg0KZng4YU5vczNiWXAyNDZNdGZhb0tCZlRRQXJkK0daVytXbkZ5SkVpU3lMZHowclV1dHlD
QWRmNWxnVkgrDQpXdkx2SW1pR3JTcnpWcE1UMm5DUzA5THFMNTBRano4QTdncDVIL2hRenRaOGlO
eXNHRDlOTzQ2T25JNzUNCjkwZEhmQ3JYalFQU0Z0RkdzVHpnRHhRSWlNdXp6OURSN0Jla0tQbXVP
RkloQmU5ZUVacWJ4YzhSV2VRdA0KaGE3aS9EckpUUk5LMWFPQURRRlZ1VjEvQW01VGhHUFdGTS9Z
SlV5VFloTVcweWVQaDQ1T2JXdVJRWmtzDQpsK2FPbTRMMEtHRERZbG0vRlF4L0VNQ3Vidmx6eS96
eERkQjZucUZpaDJxWnJmeW1uaVNPS2FqRzBqb1QNCnBab3ovRXorNGZBdGc2eTBQc3BOUjZpZEFC
RUJBQUhDd0drRUdBRUlBQk1GQWx2d1NjY0pFRStYblBacg0Ka0xpZEFoc01BQW9KRUUrWG5QWnJr
TGlkUmUwSC9qNUNJRklBdWN1YWlFTWtMa05LRUFPNXM3eDQ3ZU55DQpHUGZac2x5WStIanpHVTBk
MDdNa2tHbVZrUFRWendxVnpOWmJueTdaQXYxemxXMFV5MHlIcDFBUHB5WXQNCjhidVVwcFRCcTdk
NDdvZ3hFUll6dC9MYzJMNWEvVktGTlJiaE4xL1hRbVBpejJFbGU0dHlpcGJUYXBjeQ0KK3pieWZ6
QU1EMTNjSWRaMTNoVHNOUDBvbGdCaEFxVUFVVVlweFJsa0FIZUorRHQzTmJ6SFM0S1FLNTM4DQpO
Si9sN2JYU0tzR3FvWXFKZVo4Vk5CeHdXV1VidUc0ampyaDQzTUlSZ1VaNVdzUFVZVjZIeDA1NmtN
amINCi9iWUJqSTBURU12SDgxNjB1cXpGWGVIdll5VWxxMFNpbkQvWjlpb0llOFFkc0hHQkRVSVJZ
WXViMXBPOA0KcXJDelJaeDBvTkE9DQo9L0RlYQ0KLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxP
Q0stLS0tLQ0K

--b1_XWfNJksFMZpa21L4QrILoSdTt7bm0LTSra5W9WE
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

sOkDgryUUOkqqqMVEStd/YDfEh7h3+0Bz2fzBWJNoJS9XMQ1w2JU7ftWAnXEUEic5P8Z

--b1_XWfNJksFMZpa21L4QrILoSdTt7bm0LTSra5W9WE--


