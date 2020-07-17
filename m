References: <20200713094646.13929-1-arne@...1227...>
 <20200713094646.13929-3-arne@...1227...>
 <E1jviV7-0003vf-2C@...2479...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c10b352c-47db-7d5b-28a6-86ee95b47887@...1227...>
Date: Fri, 17 Jul 2020 10:14:38 +0200
MIME-Version: 1.0
In-Reply-To: <E1jviV7-0003vf-2C@...2479...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KAt5lzCP5yopWpEU0Ar6qDaDBbJjYUmUt"
Subject: Re: [Openvpn-devel] [PATCH 3/3] Remove key-method 1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...2507...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KAt5lzCP5yopWpEU0Ar6qDaDBbJjYUmUt
Content-Type: multipart/mixed; boundary="YDbi9c8W7JBQ8gUBTtcFp1KhPr1T0kM67"

--YDbi9c8W7JBQ8gUBTtcFp1KhPr1T0kM67
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 15.07.20 um 16:34 schrieb Steffan Karger:
> Hi
>=20
> On 13-07-2020 11:46, Arne Schwabe wrote:
>> @@ -1100,7 +1100,7 @@ process_incoming_link_part1(struct context *c, str=
uct link_socket_info *lsi, boo
>>                                  floated, &ad_start))
>>              {
>>                  /* Restore pre-NCP frame parameters */
>> -                if (is_hard_reset(opcode, c->options.key_method))
>> +                if (is_hard_reset(opcode, KEY_METHOD_2))
>>                  {
>=20
> Can't we just remove the key_method parameter from is_hard_reset()?

Some code still checks if it is a general hard reset or if it is a v2
hard reset. I agree that we can do more cleanup in this area but that
would make more code changes. Should we pull that into this change?

>> @@ -3817,10 +3803,9 @@ options_string(const struct options *o,
>>               * tls-auth/tls-crypt does not match.  Removing tls-auth he=
re would
>>               * break stuff, so leaving that in place. */
>>=20=20
>> -            if (o->key_method > 1)
>> -            {
>> -                buf_printf(&out, ",key-method %d", o->key_method);
>> -            }
>> +
>> +
>> +            buf_printf(&out, ",key-method %d", 2);
>=20
> This could do with one less newline.
>=20
>> @@ -2404,7 +2348,7 @@ key_method_2_write(struct buffer *buf, struct tls_=
session *session)
>>      }
>>=20=20
>>      /* write key_method + flags */
>> -    if (!buf_write_u8(buf, (session->opt->key_method & KEY_METHOD_MASK)=
))
>> +    if (!buf_write_u8(buf, (KEY_METHOD_2 & KEY_METHOD_MASK)))
>>      {
>>          goto error;
>>      }
>=20
> The masking looks a bit silly now. Maybe replace with a static_assert()
> if you want to be sure that no "wrong" bits are set?

Yeah I think the mask is silly here. I will just remove it.

>=20
>>  static bool
>>  key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct t=
ls_session *session)
>>  {
>>      struct key_state *ks =3D &session->key[KS_PRIMARY];      /* primary=
 key */
>>=20=20
>> -    int key_method_flags;
>>      bool username_status, password_status;
>>=20=20
>>      struct gc_arena gc =3D gc_new();
>> @@ -2582,8 +2464,6 @@ key_method_2_read(struct buffer *buf, struct tls_m=
ulti *multi, struct tls_sessio
>>      /* allocate temporary objects */
>>      ALLOC_ARRAY_CLEAR_GC(options, char, TLS_OPTIONS_LEN, &gc);
>>=20=20
>> -    ASSERT(session->opt->key_method =3D=3D 2);
>> -
>>      /* discard leading uint32 */
>>      if (!buf_advance(buf, 4))
>>      {
>> @@ -2593,7 +2473,7 @@ key_method_2_read(struct buffer *buf, struct tls_m=
ulti *multi, struct tls_sessio
>>      }
>>=20=20
>>      /* get key method */
>> -    key_method_flags =3D buf_read_u8(buf);
>> +    int key_method_flags =3D buf_read_u8(buf);
>=20
> This variable declaration is now *after* a "goto error" jump. Currently
> not harmful, because the variable isn't used after the error label, but
> static analyzers might complain about "jump past initialization".
>=20
> Otherwise this looks good based on stare-at-code. Didn't have time to
> test yet.

Clang/gcc will already complain/error out if you actually jump past
initialisation. So I think we are good here. Static analyzer are
hopefully not that broken.

Arne


--YDbi9c8W7JBQ8gUBTtcFp1KhPr1T0kM67--

--KAt5lzCP5yopWpEU0Ar6qDaDBbJjYUmUt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8RXe4ACgkQFRhsZwKx
RFRfbhAAqqIj7T3PXX0pShAXbbvnPtldyXDZGMhYe7X06/tG+v9M/0x0hHWts5Ug
rGSt2Fip9FYJlAAZ+mSHJeRFsehjISj8tlHX3Rj4MGBM4UTP2/WT1iMXjfP1P0LO
vCDgEt9PZnYw1iqTSrG58Qd3Wa0vv0uwg1w/Ia0yHtEklsvK1QFTrVUATjQ5/9Po
P5RyUSA3mtHLdmRb1PQbkSK9pHtvf8/ZuqKWYZwhRXLqVv0TSvTLsOJ648zaJbcb
FgaM2eHTItd5DC9OXv3G5DUeJlzTzdxVzj/B/tq0tmPuOznVMAcNiJfNL1HZ3UNF
oB3zoEq3lTZihkckYMYVgj/JNaFqiND8W79qu05Zf0Zl5QNBG5jAmwl+usuwGbeR
UZwXEJIh4Bw3W2Vgla3/tHz4DiOkzmr/8BVUlOkoucFUfX4/HJpwGYJe6CNRWKKx
HMIOvv2NFbdZKcEw524aABVZNThCk225+aw8G2HaqU9Z0SUMpdh2FkewrgGGexk3
QyH4jc7FcS/akZQrLtt7uLGd9f0CgVK+6NNwTnhmN6t9DTKygtCqoj2p2GvoPdM8
SnKHXgbCoTvtpD2PF8bq7WjSYzQxmacFWfAfWSmXahF5KtJo4KGf2/IkWxVAptu8
7m0PVZdzrRQrExezVJxGlAQ/0h0TY4pItmKuVSJaMSvHbQwtBuk=
=/2+L
-----END PGP SIGNATURE-----

--KAt5lzCP5yopWpEU0Ar6qDaDBbJjYUmUt--

