References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-5-arne@...1227...>
 <7c0a05cf-3e82-2577-b028-3a0505c7dec5@...2080...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <08cdcced-3146-8b94-5c5d-be2773b2b80a@...1227...>
Date: Mon, 20 Jul 2020 15:22:08 +0200
MIME-Version: 1.0
In-Reply-To: <7c0a05cf-3e82-2577-b028-3a0505c7dec5@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="epBLCtBP5lfh5KauVyhXbmVfcJhPJVBD0"
Subject: Re: [Openvpn-devel] [PATCH v2 5/9] Remove key-method 1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <openvpn@...2080...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--epBLCtBP5lfh5KauVyhXbmVfcJhPJVBD0
Content-Type: multipart/mixed; boundary="WgsyE3bUQgHn1AUEAYV1sDzykdF34vt3C"

--WgsyE3bUQgHn1AUEAYV1sDzykdF34vt3C
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 20.07.20 um 15:16 schrieb David Sommerseth:
> On 17/07/2020 15:47, Arne Schwabe wrote:
>> Key-method 1 is only needed to talk to pre OpenVPN 2.0 clients.
>>
>> Patch V2: Fix style. Make V1 op codes illegal, remove all code handling
>>           v1 op codes and give a good warning message if we encounter
>>           them in the legal op codes pre-check.
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>  doc/doxygen/doc_control_processor.h |   6 +-
>>  doc/doxygen/doc_key_generation.h    |   6 +-
>>  doc/doxygen/doc_protocol_overview.h |   2 +-
>>  src/openvpn/forward.c               |   2 +-
>>  src/openvpn/helper.c                |   5 -
>>  src/openvpn/init.c                  |   1 -
>>  src/openvpn/options.c               |  35 +----
>>  src/openvpn/options.h               |   4 -
>>  src/openvpn/ssl.c                   | 230 ++++------------------------
>>  src/openvpn/ssl.h                   |  19 +--
>>  src/openvpn/ssl_common.h            |   1 -
>>  11 files changed, 42 insertions(+), 269 deletions(-)
>=20
> [...snip...]
>=20
>> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
>> index 00b97352..4144217d 100644
>> --- a/src/openvpn/ssl.c
>> +++ b/src/openvpn/ssl.c
>=20
> [...snip...]
>=20
>> @@ -2225,52 +2205,6 @@ read_string_alloc(struct buffer *buf)
>>      return str;
>>  }
>>=20=20
>> -/*
>> - * Handle the reading and writing of key data to and from
>> - * the TLS control channel (cleartext).
>> - */
>=20
> Is it needed to remove this comment?  Or move it after the push_peer_info=
()
> function?

Yeah, we can move the comment.

>=20
>> -static bool
>> -key_method_1_write(struct buffer *buf, struct tls_session *session)
>> -{
> [...snip...]
>> -}
>> -
>>  static bool
>>  push_peer_info(struct buffer *buf, struct tls_session *session)
>>  {
>> @@ -2312,7 +2246,7 @@ push_peer_info(struct buffer *buf, struct tls_sess=
ion *session)
>>           * push request, also signal that the client wants
>>           * to get push-reply messages without without requiring a round
>>           * trip for a push request message*/
>> -        if(session->opt->pull)
>> +        if (session->opt->pull)
>>          {
>>              iv_proto |=3D IV_PROTO_REQUEST_PUSH;
>>          }
>> @@ -2394,7 +2328,6 @@ key_method_2_write(struct buffer *buf, struct tls_=
session *session)
>=20
> [...snip...]
>=20
>> @@ -3470,14 +3316,12 @@ tls_pre_decrypt(struct tls_multi *multi,
>>              }
>>=20=20
>>              /* hard reset ? */
>> -            if (is_hard_reset(op, 0))
>> +            if (is_hard_reset_method2(op))
>>              {
>>                  /* verify client -> server or server -> client connecti=
on */
>> -                if (((op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1
>> -                      || op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V2
>> +                if (((op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V2
>>                        || op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3) && !=
multi->opt.server)
>> -                    || ((op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1
>> -                         || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V2) &=
& multi->opt.server))
>> +                    || ((op =3D=3D P_CONTROL_HARD_RESET_SERVER_V2) && m=
ulti->opt.server))
>>                  {
>>                      msg(D_TLS_ERRORS,
>>                          "TLS Error: client->client or server->server co=
nnection attempted from %s",
>> @@ -3542,19 +3386,11 @@ tls_pre_decrypt(struct tls_multi *multi,
>>               * Initial packet received.
>>               */
>>=20=20
>> -            if (i =3D=3D TM_SIZE && is_hard_reset(op, 0))
>> +            if (i =3D=3D TM_SIZE && is_hard_reset_method2(op))
>>              {
>>                  struct tls_session *session =3D &multi->session[TM_ACTI=
VE];
>>                  struct key_state *ks =3D &session->key[KS_PRIMARY];
>>=20=20
>> -                if (!is_hard_reset(op, multi->opt.key_method))
>> -                {
>> -                    msg(D_TLS_ERRORS, "TLS ERROR: initial packet local/=
remote key_method mismatch, local key_method=3D%d, op=3D%s",
>> -                        multi->opt.key_method,
>> -                        packet_opcode_name(op));
>> -                    goto error;
>> -                }
>> -
>>                  /*
>>                   * If we have no session currently in progress, the ini=
tial packet will
>>                   * open a new session in TM_ACTIVE rather than TM_UNTRU=
STED.
>> @@ -3594,7 +3430,7 @@ tls_pre_decrypt(struct tls_multi *multi,
>>                  }
>>              }
>>=20=20
>> -            if (i =3D=3D TM_SIZE && is_hard_reset(op, 0))
>> +            if (i =3D=3D TM_SIZE && is_hard_reset_method2(op))
>=20
> Do we need this if() block?  Considering it is exactly the same if() stat=
ement
> as the previous if() block.  I would suggest merging them, but you might =
hit a
> challenge with reuse of struct tls_session *session, where one is referri=
ng to
> TM_ACTIVE vs TM_UNTRUSTED.

That is something that might be possible but I would consider outside of
patch. The first block actually modifies i (i =3D TM_ACTIVE;), so that
needs a separate patch with an explaination why/how we simplify the
logic here.

Arne



--WgsyE3bUQgHn1AUEAYV1sDzykdF34vt3C--

--epBLCtBP5lfh5KauVyhXbmVfcJhPJVBD0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8VmoAACgkQFRhsZwKx
RFT08BAAsMhCy4MkESUEYgqFmoa1yAZjUcs+rmGes+oOKJMsypIZj1OBrw6MZO9Y
V93GfI/flhzwtkH2YQqsuqR0AZiboft++45Mx7dyeCPfKHzkpiz58CSvgIArAZej
FaQt9S6HXX7FPan/vk/yWzWzGrB/4q4S8Z7CAMZ36NOqsoW7VbgqiKvL+5q+O7M/
AauzOGd0k95XER8+8v/C1zuMyoIoe9GCb6wQ0vfUfL5E0W6eSGOEYJYG1SK7TmgN
LxexV3l5EO5y8pIii/6QFR/CibP+QD+I9y5pxu6fS6nTula7/W6iEMesFfhnMxrn
JCuaCiwPxYEYhUWZWXo6QrvQ9j4bwwtDPXJ/AGtpLScImdTcqssNjLrNe9pC4YL8
fEmvolvha3lYo1Y28NhFZpJ+pFN0l7K1GnDZ0gdmvdNp+QyZBJ4AyGX3a/PUU0od
RIRyCVRY64p8pV2NYkr6gkv02DrkAowTFNaUxm7o8wfd/mIBAl8XnLlijbvYzuNq
NSWUADEj2Bq4380xGwc0cANxCAjsRNFeQPpn78s7VJ6FWKk+a6Dh5IXfV3Vu9gp3
fZ33UW2WJVVugv4eRUzc2Sbhdfh5aLREapT8ED4QzBK0XT/H5gwcSjirSKcszwEr
X4n9JSXYTXrJlmlXN2AogF+VuoCgRJXTAfnDWunUFgPaTtos0ic=
=Lxmj
-----END PGP SIGNATURE-----

--epBLCtBP5lfh5KauVyhXbmVfcJhPJVBD0--

