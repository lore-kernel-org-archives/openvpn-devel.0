References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-5-arne@...1227...>
 <7c0a05cf-3e82-2577-b028-3a0505c7dec5@...2080...>
 <08cdcced-3146-8b94-5c5d-be2773b2b80a@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <59a5ef1d-3b5f-f06a-e0e7-0443f0e2313e@...2080...>
Date: Mon, 20 Jul 2020 20:49:27 +0200
MIME-Version: 1.0
In-Reply-To: <08cdcced-3146-8b94-5c5d-be2773b2b80a@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="INHjpLFvO0G09UamYz36orxqEWScEu2Qr"
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
--INHjpLFvO0G09UamYz36orxqEWScEu2Qr
Content-Type: multipart/mixed; boundary="c6U235JTU1tOUxyD6Uk6xNDxcnxxaiL7u";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <59a5ef1d-3b5f-f06a-e0e7-0443f0e2313e@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2 5/9] Remove key-method 1
References: <20200717134739.21168-1-arne@...1227...>
 <20200717134739.21168-5-arne@...1227...>
 <7c0a05cf-3e82-2577-b028-3a0505c7dec5@...2080...>
 <08cdcced-3146-8b94-5c5d-be2773b2b80a@...1227...>
In-Reply-To: <08cdcced-3146-8b94-5c5d-be2773b2b80a@...1227...>

--c6U235JTU1tOUxyD6Uk6xNDxcnxxaiL7u
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 20/07/2020 15:22, Arne Schwabe wrote:
> Am 20.07.20 um 15:16 schrieb David Sommerseth:
>> On 17/07/2020 15:47, Arne Schwabe wrote:
>>> Key-method 1 is only needed to talk to pre OpenVPN 2.0 clients.
>>>
>>> Patch V2: Fix style. Make V1 op codes illegal, remove all code handling
>>>           v1 op codes and give a good warning message if we encounter
>>>           them in the legal op codes pre-check.
>>>
>>> Signed-off-by: Arne Schwabe <arne@...1227...>
>>> ---
>>>  doc/doxygen/doc_control_processor.h |   6 +-
>>>  doc/doxygen/doc_key_generation.h    |   6 +-
>>>  doc/doxygen/doc_protocol_overview.h |   2 +-
>>>  src/openvpn/forward.c               |   2 +-
>>>  src/openvpn/helper.c                |   5 -
>>>  src/openvpn/init.c                  |   1 -
>>>  src/openvpn/options.c               |  35 +----
>>>  src/openvpn/options.h               |   4 -
>>>  src/openvpn/ssl.c                   | 230 ++++------------------------
>>>  src/openvpn/ssl.h                   |  19 +--
>>>  src/openvpn/ssl_common.h            |   1 -
>>>  11 files changed, 42 insertions(+), 269 deletions(-)
>>
>> [...snip...]
>>
>>> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
>>> index 00b97352..4144217d 100644
>>> --- a/src/openvpn/ssl.c
>>> +++ b/src/openvpn/ssl.c
>>
>> [...snip...]
>>
>>> @@ -2225,52 +2205,6 @@ read_string_alloc(struct buffer *buf)
>>>      return str;
>>>  }
>>>=20=20
>>> -/*
>>> - * Handle the reading and writing of key data to and from
>>> - * the TLS control channel (cleartext).
>>> - */
>>
>> Is it needed to remove this comment?  Or move it after the push_peer_inf=
o()
>> function?
>=20
> Yeah, we can move the comment.

Yes, please ... Since it's not a bad comment, I don't like loosing helpful
pointers in comments :)

>>
>>> -static bool
>>> -key_method_1_write(struct buffer *buf, struct tls_session *session)
>>> -{
>> [...snip...]
>>> -}
>>> -
>>>  static bool
>>>  push_peer_info(struct buffer *buf, struct tls_session *session)
>>>  {
>>> @@ -2312,7 +2246,7 @@ push_peer_info(struct buffer *buf, struct tls_ses=
sion *session)
>>>           * push request, also signal that the client wants
>>>           * to get push-reply messages without without requiring a round
>>>           * trip for a push request message*/
>>> -        if(session->opt->pull)
>>> +        if (session->opt->pull)
>>>          {
>>>              iv_proto |=3D IV_PROTO_REQUEST_PUSH;
>>>          }
>>> @@ -2394,7 +2328,6 @@ key_method_2_write(struct buffer *buf, struct tls=
_session *session)
>>
>> [...snip...]
>>
>>> @@ -3470,14 +3316,12 @@ tls_pre_decrypt(struct tls_multi *multi,
>>>              }
>>>=20=20
>>>              /* hard reset ? */
>>> -            if (is_hard_reset(op, 0))
>>> +            if (is_hard_reset_method2(op))
>>>              {
>>>                  /* verify client -> server or server -> client connect=
ion */
>>> -                if (((op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1
>>> -                      || op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V2
>>> +                if (((op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V2
>>>                        || op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V3) && =
!multi->opt.server)
>>> -                    || ((op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1
>>> -                         || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V2) =
&& multi->opt.server))
>>> +                    || ((op =3D=3D P_CONTROL_HARD_RESET_SERVER_V2) && =
multi->opt.server))
>>>                  {
>>>                      msg(D_TLS_ERRORS,
>>>                          "TLS Error: client->client or server->server c=
onnection attempted from %s",
>>> @@ -3542,19 +3386,11 @@ tls_pre_decrypt(struct tls_multi *multi,
>>>               * Initial packet received.
>>>               */
>>>=20=20
>>> -            if (i =3D=3D TM_SIZE && is_hard_reset(op, 0))
>>> +            if (i =3D=3D TM_SIZE && is_hard_reset_method2(op))
>>>              {
>>>                  struct tls_session *session =3D &multi->session[TM_ACT=
IVE];
>>>                  struct key_state *ks =3D &session->key[KS_PRIMARY];
>>>=20=20
>>> -                if (!is_hard_reset(op, multi->opt.key_method))
>>> -                {
>>> -                    msg(D_TLS_ERRORS, "TLS ERROR: initial packet local=
/remote key_method mismatch, local key_method=3D%d, op=3D%s",
>>> -                        multi->opt.key_method,
>>> -                        packet_opcode_name(op));
>>> -                    goto error;
>>> -                }
>>> -
>>>                  /*
>>>                   * If we have no session currently in progress, the in=
itial packet will
>>>                   * open a new session in TM_ACTIVE rather than TM_UNTR=
USTED.
>>> @@ -3594,7 +3430,7 @@ tls_pre_decrypt(struct tls_multi *multi,
>>>                  }
>>>              }
>>>=20=20
>>> -            if (i =3D=3D TM_SIZE && is_hard_reset(op, 0))
>>> +            if (i =3D=3D TM_SIZE && is_hard_reset_method2(op))
>>
>> Do we need this if() block?  Considering it is exactly the same if() sta=
tement
>> as the previous if() block.  I would suggest merging them, but you might=
 hit a
>> challenge with reuse of struct tls_session *session, where one is referr=
ing to
>> TM_ACTIVE vs TM_UNTRUSTED.
>=20
> That is something that might be possible but I would consider outside of
> patch. The first block actually modifies i (i =3D TM_ACTIVE;), so that
> needs a separate patch with an explaination why/how we simplify the
> logic here.

Alright, I can see the argument of not touching it now.

Could we then just add a comment to these two sections for now, indicating =
why
they have been kept separate despite the if() statement being identical?
Something like "This section processes {TM_ACTIVE, TM_UNTRUSTED} sessions" =
and
elaborate a little bit around that, which may help refactoring this code la=
ter on.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--c6U235JTU1tOUxyD6Uk6xNDxcnxxaiL7u--

--INHjpLFvO0G09UamYz36orxqEWScEu2Qr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfFec3AAoJEIbPlEyWcf3ypC0QAI8yisksWTutKXPqVUMVvkQk
9Rcj2fzreiAtXP+Asp8Z1wGV0HVhLR/iKn4NSgGhyH8T0YQ8yseyKEnh/+Q/aE6k
ZLu9BjvHamdUuTsFHUqEDyDErb3dwhSvhdp1CBWnis18IZ72vSIN9WkTrjTRj0hX
2TsqJrfZPWCw+I7zsFDf+4F8LNsyOQ2ho+XWzZ1H6VdQWX9Z+zIKISN+x+vRdg6x
mzRKrk8XWNE6Yv+NpY7YDKAaxtEt2mwZQdZvmR0ERXmD8JcE7oo2JvnpfQaVf7V2
3tnZWRoHluC8zgAioseTAsVf0Tr4oRSh8cSLSBq5RWWHqf0A6+7Lqg3EeXwG7UE/
3Q9aFc6xvMrWpAsvjPEsScjVBiJz+QxU2NAuNfl9aihHj58GFzVm0SkZhEjQl6oG
7UFVPUkhYNYGH3LnqyyLI+l9xCgYVNfc/a4DlvM2DtJBVFu0wEktmkLGALHJGINW
hT2LS2njjytDmz75mJ0ivngazA1QlMp4seag+fhZ9oPLeThB+raqKx/CNI1rFpel
7W22LIH0SiJ8srARdIu/pHxatCtKhcfmEn7g51qrk/Bwj5XyVQOTxoRTItiFqHdt
LNzikMmuqJEaMqCmXNQlrMkdjKdxmJPcQUGYUF0s4tOiIWBivtpxMzA/7SJd6z1G
682wNTGVpgDIV79rFej/
=nIF8
-----END PGP SIGNATURE-----

--INHjpLFvO0G09UamYz36orxqEWScEu2Qr--

