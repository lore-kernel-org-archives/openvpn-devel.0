References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-5-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <7c0a05cf-3e82-2577-b028-3a0505c7dec5@...2080...>
Date: Mon, 20 Jul 2020 15:16:28 +0200
MIME-Version: 1.0
In-Reply-To: <20200717134739.21168-5-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="SlWZaFyUqMKOkJmO6YrbQPu0Lq039bIoy"
Subject: Re: [Openvpn-devel] [PATCH v2 5/9] Remove key-method 1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SlWZaFyUqMKOkJmO6YrbQPu0Lq039bIoy
Content-Type: multipart/mixed; boundary="tH62OoCxQkLb4yPTpc0xylbRMcr5eGbBl";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <7c0a05cf-3e82-2577-b028-3a0505c7dec5@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2 5/9] Remove key-method 1
References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-5-arne@...1227...>
In-Reply-To: <20200717134739.21168-5-arne@...1227...>

--tH62OoCxQkLb4yPTpc0xylbRMcr5eGbBl
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 17/07/2020 15:47, Arne Schwabe wrote:
> Key-method 1 is only needed to talk to pre OpenVPN 2.0 clients.
>=20
> Patch V2: Fix style. Make V1 op codes illegal, remove all code handling
>           v1 op codes and give a good warning message if we encounter
>           them in the legal op codes pre-check.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/doxygen/doc_control_processor.h |   6 +-
>  doc/doxygen/doc_key_generation.h    |   6 +-
>  doc/doxygen/doc_protocol_overview.h |   2 +-
>  src/openvpn/forward.c               |   2 +-
>  src/openvpn/helper.c                |   5 -
>  src/openvpn/init.c                  |   1 -
>  src/openvpn/options.c               |  35 +----
>  src/openvpn/options.h               |   4 -
>  src/openvpn/ssl.c                   | 230 ++++------------------------
>  src/openvpn/ssl.h                   |  19 +--
>  src/openvpn/ssl_common.h            |   1 -
>  11 files changed, 42 insertions(+), 269 deletions(-)

[...snip...]

> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 00b97352..4144217d 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c

[...snip...]

> @@ -2225,52 +2205,6 @@ read_string_alloc(struct buffer *buf)
>      return str;
>  }
>=20=20
> -/*
> - * Handle the reading and writing of key data to and from
> - * the TLS control channel (cleartext).
> - */

Is it needed to remove this comment?  Or move it after the push_peer_info()
function?

> -static bool
> -key_method_1_write(struct buffer *buf, struct tls_session *session)
> -{
[...snip...]
> -}
> -
>  static bool
>  push_peer_info(struct buffer *buf, struct tls_session *session)
>  {
> @@ -2312,7 +2246,7 @@ push_peer_info(struct buffer *buf, struct tls_sessi=
on *session)
>           * push request, also signal that the client wants
>           * to get push-reply messages without without requiring a round
>           * trip for a push request message*/
> -        if(session->opt->pull)
> +        if (session->opt->pull)
>          {
>              iv_proto |=3D IV_PROTO_REQUEST_PUSH;
>          }
> @@ -2394,7 +2328,6 @@ key_method_2_write(struct buffer *buf, struct tls_s=
ession *session)

[...snip...]

> @@ -3470,14 +3316,12 @@ tls_pre_decrypt(struct tls_multi *multi,
>              }
>=20=20
>              /* hard reset ? */
> -            if (is_hard_reset(op, 0))
> +            if (is_hard_reset_method2(op))
>              {
>                  /* verify client -> server or server -> client connectio=
n */
> -                if (((op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1
> -                      || op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V2
> +                if (((op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V2
>                        || op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3) && !m=
ulti->opt.server)
> -                    || ((op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1
> -                         || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V2) &&=
 multi->opt.server))
> +                    || ((op =3D=3D P_CONTROL_HARD_RESET_SERVER_V2) && mu=
lti->opt.server))
>                  {
>                      msg(D_TLS_ERRORS,
>                          "TLS Error: client->client or server->server con=
nection attempted from %s",
> @@ -3542,19 +3386,11 @@ tls_pre_decrypt(struct tls_multi *multi,
>               * Initial packet received.
>               */
>=20=20
> -            if (i =3D=3D TM_SIZE && is_hard_reset(op, 0))
> +            if (i =3D=3D TM_SIZE && is_hard_reset_method2(op))
>              {
>                  struct tls_session *session =3D &multi->session[TM_ACTIV=
E];
>                  struct key_state *ks =3D &session->key[KS_PRIMARY];
>=20=20
> -                if (!is_hard_reset(op, multi->opt.key_method))
> -                {
> -                    msg(D_TLS_ERRORS, "TLS ERROR: initial packet local/r=
emote key_method mismatch, local key_method=3D%d, op=3D%s",
> -                        multi->opt.key_method,
> -                        packet_opcode_name(op));
> -                    goto error;
> -                }
> -
>                  /*
>                   * If we have no session currently in progress, the init=
ial packet will
>                   * open a new session in TM_ACTIVE rather than TM_UNTRUS=
TED.
> @@ -3594,7 +3430,7 @@ tls_pre_decrypt(struct tls_multi *multi,
>                  }
>              }
>=20=20
> -            if (i =3D=3D TM_SIZE && is_hard_reset(op, 0))
> +            if (i =3D=3D TM_SIZE && is_hard_reset_method2(op))

Do we need this if() block?  Considering it is exactly the same if() statem=
ent
as the previous if() block.  I would suggest merging them, but you might hi=
t a
challenge with reuse of struct tls_session *session, where one is referring=
 to
TM_ACTIVE vs TM_UNTRUSTED.

>              {
>                  /*
>                   * No match with existing sessions,
> @@ -3614,14 +3450,6 @@ tls_pre_decrypt(struct tls_multi *multi,
>                      goto error;
>                  }
>=20=20
> -                if (!is_hard_reset(op, multi->opt.key_method))
> -                {
> -                    msg(D_TLS_ERRORS, "TLS ERROR: new session local/remo=
te key_method mismatch, local key_method=3D%d, op=3D%s",
> -                        multi->opt.key_method,
> -                        packet_opcode_name(op));
> -                    goto error;
> -                }
> -
>                  if (!read_control_auth(buf, &session->tls_wrap, from,
>                                         session->opt))
>                  {

I had already started my own approach of removing --key-method when I was m=
ade
aware of this patch.  Considering the size of it, my own barely tested chan=
ges
is about 90% similar to this patch.  But this patch has some improvements I
didn't consider in my work.

I've done a quick 'make check' as well, and it works fine.  There are just a
couple of minor things to consider, otherwise I will happily ACK this patch.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--tH62OoCxQkLb4yPTpc0xylbRMcr5eGbBl--

--SlWZaFyUqMKOkJmO6YrbQPu0Lq039bIoy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfFZktAAoJEIbPlEyWcf3yg24P/jWQV/6mBj6N0Uo5Z4sZE5sF
xPyo85u7gITD4slT1Rq4KRTAcmztFWUHErj9Xu0m05bFgPXf+N7YcqLouK7cElYp
Yd5P96ZiemDxP0L9mzyEbFtBWaOz3B5fvac0HjhskTpW26Rj3RjFz1w4DcdY7TLK
nOdevWB0e/BKM4O5lbMhG+EjNjIedkWXFJef0Om3qq1WXbOH42B6OH97/rBpPEel
LsyUR/yRd3WPxPhZYJXj1EyY9ihozIdc4NKZvwrgk53krS5ZFaX3pQpPUjt7BOrB
3lMzPVIz//qkEJdvPid3O1jMHEbsB13ewU/1jzjlmmvFI4pGBvecVCuKxUMOfIFe
m9ZWfl9Oq5NLxuOQjpsJRcr//Aee9uTIlR4jUwhRAJc8AC/7gdk1uflvABL9tdnJ
A4Ny6F6qtuioKlguiP2QfI4DUjW/SDLvjM5HJBJSW4HizNEHSatYP0CVgY/FSkqC
qgsdjRijQCCF1Xwco0Fw5H4Drj827Sdfqb5+/2vc4NLwVwx/HIz5jKpAkYBZ5RiM
UkoCRmahOnobq7h1PZQBqpsEaa/V09XlfzFLn19Vy1r7wJ2HGxdw/tgTenNhWWkZ
iGNpoYdXzGL++7g0fpJwx8Xod7KIAxGM7niWmiHzbfJnpu8eRVuqekSNly4zb7g/
BVX0SmXGkz/PM0lB1Hg9
=wMeN
-----END PGP SIGNATURE-----

--SlWZaFyUqMKOkJmO6YrbQPu0Lq039bIoy--

