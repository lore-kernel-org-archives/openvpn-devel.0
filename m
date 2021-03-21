References: <20210319153129.8734-1-arne@...1227...>
 <20210319153129.8734-2-arne@...1227...>
 <08c1d3c8-d5d1-f329-57a6-a2d07ec39430@...2080...>
 <513d1277-6e4e-5215-e0d4-ac2aa0d042b3@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ecbbc45f-0cae-99d0-0b7b-b61de4a7744f@...2080...>
Date: Sun, 21 Mar 2021 21:05:26 +0100
MIME-Version: 1.0
In-Reply-To: <513d1277-6e4e-5215-e0d4-ac2aa0d042b3@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SCLWeSuPry1RUTu5fmehjphNTyIta0FGo"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Implement '--compress migrate' to
 migrate to non-compression setup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SCLWeSuPry1RUTu5fmehjphNTyIta0FGo
Content-Type: multipart/mixed; boundary="LHelMG2nAk3E4PI1qiyzucdfYsH8r72pc";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <ecbbc45f-0cae-99d0-0b7b-b61de4a7744f@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Implement '--compress migrate' to
 migrate to non-compression setup
References: <20210319153129.8734-1-arne@...1227...>
 <20210319153129.8734-2-arne@...1227...>
 <08c1d3c8-d5d1-f329-57a6-a2d07ec39430@...2080...>
 <513d1277-6e4e-5215-e0d4-ac2aa0d042b3@...1227...>
In-Reply-To: <513d1277-6e4e-5215-e0d4-ac2aa0d042b3@...1227...>

--LHelMG2nAk3E4PI1qiyzucdfYsH8r72pc
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 21/03/2021 13:56, Arne Schwabe wrote:
> Am 20.03.21 um 14:20 schrieb David Sommerseth:
>> On 19/03/2021 16:31, Arne Schwabe wrote:
>>> This option allow migration to a non compression server config while
>>> still retraining compatibility with client that have a compression
>>> setting in their config.
>>>
>>> For existing setups that used to have comp-lzo no or another
>>> compression setting in their configs it is a difficult to migrate to
>>> a setup without compression without replacing all client configs at
>>> once especially if OpenVPN 2.3 or earlier clients are in the mix that
>>> do not support pushing stub-v2. Even with OpenVPN 2.4 and later clients
>>> that support pushing this is not a satisfying solution as the clients
>>> log occ mismatches and the "push stub-v2" needs to be in the server
>>> config "forever".
>>>
>>> Signed-off-by: Arne Schwabe <arne@...1227...>
>>> ---
>>>  =C2=A0 doc/man-sections/protocol-options.rst | 12 +++-
>>>  =C2=A0 src/openvpn/comp.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 1 +
>>>  =C2=A0 src/openvpn/multi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 41 +++=
++++++++++
>>>  =C2=A0 src/openvpn/options.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++
>>>  =C2=A0 src/openvpn/ssl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 34 ++++++++++-
>>>  =C2=A0 src/openvpn/ssl_common.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
>>>  =C2=A0 src/openvpn/ssl_util.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 43 ++++++++++++++
>>>  =C2=A0 src/openvpn/ssl_util.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 +++++
>>>  =C2=A0 tests/unit_tests/openvpn/Makefile.am=C2=A0 | 14 ++++-
>>>  =C2=A0 tests/unit_tests/openvpn/test_misc.c=C2=A0 | 83 +++++++++++++++=
++++++++++++
>>>  =C2=A0 10 files changed, 245 insertions(+), 5 deletions(-)
>>>  =C2=A0 create mode 100644 tests/unit_tests/openvpn/test_misc.c
>>>
>>
>> This fails compiling:
>>
>> ../../../src/openvpn/ssl.c: In function =E2=80=98key_method_2_write=E2=
=80=99:
>> ../../../src/openvpn/ssl.c:2280:13: error: =E2=80=98multi=E2=80=99 undec=
lared (first use
>> in this function)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (multi->remote_uses=
comp && session->opt->mode =3D=3D MODE_SERVER
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 ^~~~~
>> ../../../src/openvpn/ssl.c:2280:13: note: each undeclared identifier is
>> reported only once for each function it appears in
>> make[3]: *** [Makefile:742: ssl.o] Error 1
>=20
> Oh the fun of rebasing. The multi argument was added by another patch.
> Can you just the small patch to review the rest of the patch?:
>=20
>   static bool
> -key_method_2_write(struct buffer *buf, struct tls_session *session)
> +key_method_2_write(struct buffer *buf, struct tls_multi *multi, struct
> tls_session *session)
>   {
>       struct key_state *ks =3D &session->key[KS_PRIMARY];      /* primary
> key */
>=20
> @@ -2856,7 +2856,7 @@ tls_process(struct tls_multi *multi,
>           if (!buf->len && ((ks->state =3D=3D S_START && !session->opt->s=
erver)
>                             || (ks->state =3D=3D S_GOT_KEY &&
> session->opt->server)))
>           {
> -            if (!key_method_2_write(buf, session))
> +            if (!key_method_2_write(buf, multi, session))
>               {
>                   goto error;
>               }
>=20

I'll give this a spin and continue the review.  Thx!


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--LHelMG2nAk3E4PI1qiyzucdfYsH8r72pc--

--SCLWeSuPry1RUTu5fmehjphNTyIta0FGo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmBXpwYACgkQhs+UTJZx
/fL7fg/5AXKPn6eBSvmGqOzQ43EB96T0JarFmiplPLjtRiFQeT9sK3QlhGxuEIc6
PeKN24mw8nqI5eVGTzqtaigXvMnAMEka5SSyTWY3z7L9kGd9rciue8GP7tSz6BFD
rZm/15HPpIvUJQYTncC56eO+fBjVbfmaUyC8OV5HorfxWEaYCNzNo1DK/i5Kvk+x
FejYz4hI4P9hI03h1Cd9mKFWiIJr0oAdzCgVoOJ1WBwahHxhMIfOVpWQL+BalNXX
AcLPaXZhAf6lr7q+S94HS5pClGSb8H+EWV9N4eUVurnNkyNO33QP3apzH21YqYNX
irWSJ3vn9nOx73dPRFQY3hv6xRwXT4GfdQv6C7g3MorLi6BVYkXU/WrqSjlYktCj
R4VDQq55xFPrMzDnRmZl/NmXbL3yrOO98xCobG95E8E61vYMx0sSe9EwssyHc+LD
Gwq9+uGohEzOSRuXcEJvEtQ1+SeDt6AMF9OkBOELmCvslJXX53ZXQ2gIMTe4UE1J
X9aRfmG4qOgJzmLn+QI2HJ8/+MZ1gT/bUv5C5CQLN314x/LFiJ0+5LLbM9ACc3C7
GU8uSQWsP7Qppx3HlYzQIw+Jb0pAQj8qgxB+1OXfyWzMih2wzxqgOVpck3qgBrTR
Ta0Wbe/YlAAAZGI807Dq4vQ2Mi7M5M7TtgR46hWY7N4JZx+hD5g=
=cou0
-----END PGP SIGNATURE-----

--SCLWeSuPry1RUTu5fmehjphNTyIta0FGo--

