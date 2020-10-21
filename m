References: <20200813072923.24385-1-eric@...1918...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <8d9ec33a-3e97-d350-94e3-0e9481b318d7@...1227...>
Date: Wed, 21 Oct 2020 13:33:34 +0200
MIME-Version: 1.0
In-Reply-To: <20200813072923.24385-1-eric@...1918...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hZyOc19F9yh43NkscFjYnCFmdirXphRUh"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Send auth-fail messages to clients
 on renegotiation failures via auth-token or user-pass expiry
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
--hZyOc19F9yh43NkscFjYnCFmdirXphRUh
Content-Type: multipart/mixed; boundary="m6YFtPWmMh9g0LSMvvzWBfkz04VlJkgF2"

--m6YFtPWmMh9g0LSMvvzWBfkz04VlJkgF2
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


>  /*
>   * Send restart message from server to client.
>   */
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 96897e48..b5cc9dc9 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -576,6 +576,7 @@ struct tls_multi
>=20=20
>      char *remote_ciphername;    /**< cipher specified in peer's config f=
ile */
>=20=20
> +    bool connection_established; /** Notifies future auth calls this is =
a reneg */
>      /*
>       * Our session objects.
>       */
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index 97ccb93b..8d8531c7 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -1318,6 +1318,7 @@ verify_user_pass(struct user_pass *up, struct tls_m=
ulti *multi,
>          }
>          else
>          {
> +            send_push_reply_auth_failed(multi, "SESSION:Auth-token expir=
ed");
>              wipe_auth_token(multi);
>              ks->authenticated =3D KS_AUTH_FALSE;
>              msg(M_WARN, "TLS: Username/auth-token authentication "
> @@ -1432,6 +1433,12 @@ verify_user_pass(struct user_pass *up, struct tls_=
multi *multi,
>      }
>      else
>      {
> +        if (multi->connection_established)
> +        {
> +            /* Notify the client */
> +            send_push_reply_auth_failed(multi, "SESSION:Auth failed");
> +
> +        }
>          ks->authenticated =3D KS_AUTH_FALSE;
>          msg(D_TLS_ERRORS, "TLS Auth Error: Auth Username/Password verifi=
cation failed for peer");
>      }
>=20

Here comes a late NACK to the patch. I am currently looking into this
problem in detail and this patch fails for deferred authentication. The
patch will only send the AUTH_FAILED message if the result of the
user/password authentication is already known in verify_user_pass. If
the it is deferred with this patch does not send the AUTH_FAILED.

Arne


--m6YFtPWmMh9g0LSMvvzWBfkz04VlJkgF2--

--hZyOc19F9yh43NkscFjYnCFmdirXphRUh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl+QHI4ACgkQFRhsZwKx
RFRqIhAAkBU6mDWCZttdp+s07MVE2+KUGyRw/q+s2xu/pLh6tKDgRul9aROga9ky
WL1m9wsmmkifEsDVxiX2NjKxWH059Ae42ub1jkUj/q01YDYOdwFd+kBzKSS1li7p
1zPMYpPTop54hQYdH9UZ0JWnD5C5em7SnMF7N7mbeRbtxq0fl/GGYKJaghxA6zIv
3zuCQJcBOEImbZSfpOVOf6JXXQV5X7xx+mNI6K96E7XMh53otgA96E+7Wtn54NVy
dQX/0H6kUyWXhmTYYojR0JpsEdJwG/dKGoZ+AtNaWVwkx6naFAbYOHa7qAvzrWKZ
uUPxbTyeshqjkFT3ejo0pcoBlxUxdSlnK5OdUwGVZllm8kt4IUerWhdBhaqVGlq1
B80HnXOy7T2VuKalN8DU+K6wlxPutBwXCCyaSLQZbfq/AdyLxLg6lDNxKWlIvoVv
bKoDSD0I+xM/lItgzCC5vtMFfs9SrAk49HgmJHZ+NFsSo3Eudyhj/Gr2EBdCU6kQ
Scu4mKeHrckyKdpM6ovBQwutT2/RMsZDLFNgS7fjDvvGGf5orF0lCVRYHoIWBGrZ
hCvBK0rOpE2nba2eVXvVrkgkKJ14DyBptWio6rxK4HHjbYoYGfO5pos9bxh4qwec
+Kaofg/nqPfHi36rLhfGosiepUB78Yb9+zhUyTHJKTZ4kRhB23s=
=NYgi
-----END PGP SIGNATURE-----

--hZyOc19F9yh43NkscFjYnCFmdirXphRUh--

