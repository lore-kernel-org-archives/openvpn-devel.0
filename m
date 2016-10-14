References: <1476388771-16492-4-git-send-email-davids@...515...>
	<1476440311-29382-1-git-send-email-davids@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <a59474b2-88ef-07ef-54dd-5e6b2a123a4a@...2080...>
Date: Fri, 14 Oct 2016 20:47:02 +0200
MIME-Version: 1.0
In-Reply-To: <1476440311-29382-1-git-send-email-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="33CNFRoRARJGkAvcXeToqFOOju7KBduvh"
Subject: Re: [Openvpn-devel] [PATCH v2 3/5] auth-gen-token: Generate an
 auth-token per client
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--33CNFRoRARJGkAvcXeToqFOOju7KBduvh
Content-Type: multipart/mixed; boundary="BhCb3l6pF7JPIbff7j0EWgvdjV51GRpjl";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: openvpn-devel@lists.sourceforge.net
Message-ID: <a59474b2-88ef-07ef-54dd-5e6b2a123a4a@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2 3/5] auth-gen-token: Generate an
	auth-token per client
References: <1476388771-16492-4-git-send-email-davids@...515...>
	<1476440311-29382-1-git-send-email-davids@...515...>
In-Reply-To: <1476440311-29382-1-git-send-email-davids@...515...>

--BhCb3l6pF7JPIbff7j0EWgvdjV51GRpjl
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable


Meh ... disregard this patch.  Just noticed that the auth_token_sent
member in the struct tls_options sneaked into this patch during my git
rebasing.

I'll send the correct v2 patch (as v2.1 in the subject only)

--
kind regards,

David Sommerseth


On 14/10/16 12:18, David Sommerseth wrote:
> When --auth-gen-token is used a random token key is generated for
> each client after a successful user/password authentication.  This
> token is expected to be returned in the password field on the
> following authentications.
>=20
> The token is 256 bits long and BASE64 encoded before it is stored.
>=20
>   v2 - Fix Doxygen comment typo
>      - Don't exceed 80 chars line length
>=20
> Signed-off-by: David Sommerseth <davids@...515...>
> ---
>  src/openvpn/ssl.c        |  6 ++++++
>  src/openvpn/ssl_common.h |  8 ++++++++
>  src/openvpn/ssl_verify.c | 39 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 53 insertions(+)
>=20
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index c7cf78d..54b6686 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1173,6 +1173,12 @@ tls_multi_free (struct tls_multi *multi, bool clea=
r)
>=20=20
>    cert_hash_free (multi->locked_cert_hash_set);
>=20=20
> +  if (multi->auth_token)
> +    {
> +      memset (multi->auth_token, 0, AUTH_TOKEN_SIZE);
> +      free (multi->auth_token);
> +    }
> +
>    for (i =3D 0; i < TM_SIZE; ++i)
>      tls_session_free (&multi->session[i], false);
>=20=20
> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
> index 50c4a9c..a340a69 100644
> --- a/src/openvpn/ssl_common.h
> +++ b/src/openvpn/ssl_common.h
> @@ -351,6 +351,7 @@ struct tls_options
>  /** @} name Index of key_state objects within a tls_session structure */
>  /** @} addtogroup control_processor */
>=20=20
> +#define AUTH_TOKEN_SIZE 32      /**< Size of server side generated auth =
tokens.  32 bytes =3D=3D 256 bits */
>=20=20
>  /**
>   * Security parameter state of a single session within a VPN tunnel.
> @@ -525,6 +526,13 @@ struct tls_multi
>    uint32_t peer_id;
>    bool use_peer_id;
>=20=20
> +  bool auth_token_sent;  /**< If server uses --auth-gen-token and
> +                          *   token has been sent to client */
> +  char *auth_token;      /**< If server sends a generated auth-token,
> +                          *   this is the token to use for future
> +                          *   user/pass authentications in this session.
> +                          */
> +  time_t auth_token_tstamp; /**< timestamp of the generated token */
>    /*
>     * Our session objects.
>     */
> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
> index d0c22b8..497d1b7 100644
> --- a/src/openvpn/ssl_verify.c
> +++ b/src/openvpn/ssl_verify.c
> @@ -39,6 +39,8 @@
>=20=20
>  #include "misc.h"
>  #include "manage.h"
> +#include "otime.h"
> +#include "base64.h"
>  #include "ssl_verify.h"
>  #include "ssl_verify_backend.h"
>=20=20
> @@ -1174,6 +1176,43 @@ verify_user_pass(struct user_pass *up, struct tls_=
multi *multi,
>        if (man_def_auth !=3D KMDA_UNDEF)
>  	ks->auth_deferred =3D true;
>  #endif
> +
> +      if ((session->opt->auth_generate_token) && (NULL =3D=3D multi->aut=
h_token))
> +	{
> +	  /* Server is configured with --auth-gen-token but no token has yet
> +	   * been generated for this client.  Generate one and save it.
> +	   */
> +	  uint8_t tok[AUTH_TOKEN_SIZE];
> +
> +	  if (!rand_bytes(tok, AUTH_TOKEN_SIZE))
> +	    {
> +	      msg( M_FATAL, "Failed to get enough randomness for "
> +                   "authentication token");
> +	    }
> +
> +	  /* The token should be longer than the input when
> +           * being base64 encoded
> +           */
> +	  if( openvpn_base64_encode(tok, AUTH_TOKEN_SIZE,
> +                                    &multi->auth_token) < AUTH_TOKEN_SIZ=
E)
> +	    {
> +	      msg(D_TLS_ERRORS, "BASE64 encoding of token failed. "
> +                  "No auth-token will be activated now");
> +	      if (multi->auth_token)
> +		{
> +		  memset (multi->auth_token, 0, AUTH_TOKEN_SIZE);
> +		  free (multi->auth_token);
> +		  multi->auth_token =3D NULL;
> +		}
> +	    }
> +	  else
> +	    {
> +	      multi->auth_token_tstamp =3D now;
> +	      dmsg (D_SHOW_KEYS, "Generated token for client: %s",
> +                    multi->auth_token);
> +	    }
> +	}
> +
>        if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME))
>  	set_common_name (session, up->username);
>  #ifdef ENABLE_DEF_AUTH
>=20


--=20
kind regards,

David Sommerseth


--BhCb3l6pF7JPIbff7j0EWgvdjV51GRpjl--

--33CNFRoRARJGkAvcXeToqFOOju7KBduvh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYASgmAAoJEIbPlEyWcf3yz34P/igBs3ox5P0LsZdGoFP10wSE
gpKTO0yrkIWpn4IHhxTHq7QtvXjiDw6TCXj7dIXOFqWVfMbWT7qAtPr+V7kB22M1
U3JYbYJeWx2EFiY3LLtO7M08ytA5CYdarYMW6IMRw0yIJgdLho9vgBVQTXtAR9o/
5g31E2setRMb00iq6s1eFhn+CnlDCMIidpKk0WeMlIDoCqnax2l4y/dmeYUtr6Hc
nrvdMxONsVbsELetUjCrXWA/l1Rafu4qcAKFozVHRG61nOxtl9+dlIG5oO+uw7Ov
pAqBEROo2B9G+odO4ouEV3Qgi7huK5XUHmXDglisqyICwRE+O+IY5ffFesVJ0e70
nV9W8zQrVEH8vmy7uUPU3EoHp2qeTlTuQoyVZPh+kNflc48/OkdWPG1Eh/vwjobc
Lp/IP7oW7lWhK/To55iieplzui2pjFk7z0b3/RDB9vGGEtVFhAA9cQG/HELVNFlb
2KND+YeZex6mS4bMxh2LvWWNGrfqgL+hRTl+QfhYRB+YozQne5B6oF+4sdu+f/Bo
MAHenhgYzcNPDN+7pGfogrQ0NcaqaGwo3fLbQ7aEG7ulzq08SderY1xa+sA+aeEd
hLJNflyq9bgMQXGXNMQXl4WxPgBpND++4bR0fms4FHPzdYsVsZyTnEfV2AYv5YgY
mZtMsP2fCM1gQTHtDpPa
=wkct
-----END PGP SIGNATURE-----

--33CNFRoRARJGkAvcXeToqFOOju7KBduvh--

