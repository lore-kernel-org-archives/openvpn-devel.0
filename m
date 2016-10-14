References: <1476388771-16492-1-git-send-email-davids@...515...>
	<1476388771-16492-5-git-send-email-davids@...515...>
	<cd6e0805-20fe-b61d-4858-595e84f234a0@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <d013ee9f-8a52-b512-d5b7-8c35e04d62c3@...2080...>
Date: Fri, 14 Oct 2016 21:24:31 +0200
MIME-Version: 1.0
In-Reply-To: <cd6e0805-20fe-b61d-4858-595e84f234a0@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="b77oRdQ7Fj7Xgn8kLrxr0g78OF47nnnH4"
Subject: Re: [Openvpn-devel] [PATCH 4/5] auth-gen-token: Push generated
 auth-tokens to the client
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b77oRdQ7Fj7Xgn8kLrxr0g78OF47nnnH4
Content-Type: multipart/mixed; boundary="2GNcKkSrftETcAxTSgPjfpTdheSu431XK";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <d013ee9f-8a52-b512-d5b7-8c35e04d62c3@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 4/5] auth-gen-token: Push generated
	auth-tokens to the client
References: <1476388771-16492-1-git-send-email-davids@...515...>
	<1476388771-16492-5-git-send-email-davids@...515...>
	<cd6e0805-20fe-b61d-4858-595e84f234a0@...1856...>
In-Reply-To: <cd6e0805-20fe-b61d-4858-595e84f234a0@...1856...>

--2GNcKkSrftETcAxTSgPjfpTdheSu431XK
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 14/10/16 15:30, Steffan Karger wrote:
>=20
>=20
> On 13-10-16 21:59, David Sommerseth wrote:
>> If --auth-gen-token has been enabled and a token has been generated,
>> ensure this token is pushed to the client using the 'auth-token' option.
>>
>> Signed-off-by: David Sommerseth <davids@...515...>
>> ---
>>  src/openvpn/misc.c       | 5 +++++
>>  src/openvpn/push.c       | 9 ++++++++-
>>  src/openvpn/ssl_common.h | 2 ++
>>  3 files changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
>> index 225f0bf..b74ac9d 100644
>> --- a/src/openvpn/misc.c
>> +++ b/src/openvpn/misc.c
>> @@ -2073,6 +2073,11 @@ sanitize_control_message(const char *src, struct =
gc_arena *gc)
>=20
> Wait, what?  We have over 2000 lines of 'misc.c'...?
>=20
>> +      else if (!check_debug_level(D_SHOW_KEYS) && (c =3D=3D 'a' && !str=
ncmp(src, "auth-token ", 11)))
>=20
> Overly long line.  (And not so clear code, but this is in line with the
> surrounding code, and you already sent an explanation.)
>=20
>> diff --git a/src/openvpn/push.c b/src/openvpn/push.c
>> index ee2eda4..0fb87ba 100644
>> --- a/src/openvpn/push.c
>> +++ b/src/openvpn/push.c
>> @@ -309,7 +309,7 @@ prepare_push_reply (struct context *c, struct gc_are=
na *gc,
>>  		    struct push_list *push_list)
>>  {
>>    const char *optstr =3D NULL;
>> -  const struct tls_multi *tls_multi =3D c->c2.tls_multi;
>> +  struct tls_multi *tls_multi =3D c->c2.tls_multi;
>>    const char * const peer_info =3D tls_multi->peer_info;
>>    struct options *o =3D &c->options;
>>=20=20
>> @@ -371,6 +371,13 @@ prepare_push_reply (struct context *c, struct gc_ar=
ena *gc,
>>  	  push_option_fmt(gc, push_list, M_USAGE, "cipher %s", o->ciphername);
>>  	}
>>      }
>> +
>> +  /* If server uses --auth-gen-token and we have an auth token to send =
to client */
>> +  if (false =3D=3D tls_multi->auth_token_sent && NULL !=3D tls_multi->a=
uth_token)
>> +    {
>> +      push_option_fmt(gc, push_list, M_USAGE, "auth-token %s", tls_mult=
i->auth_token);
>> +      tls_multi->auth_token_sent =3D true;
>> +    }
>>    return true;
>>  }
>>=20=20
>> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
>> index 1b90c5e..3d802c9 100644
>> --- a/src/openvpn/ssl_common.h
>> +++ b/src/openvpn/ssl_common.h
>> @@ -526,6 +526,8 @@ struct tls_multi
>>    uint32_t peer_id;
>>    bool use_peer_id;
>>=20=20
>> +  bool auth_token_sent;  /**< If server uses --auth-gen-token and
>> +                          *   token has been sent to client */
>>    char *auth_token;      /** If server sends a generated auth-token,
>>                            * this is the token to use for future
>>                            * user/pass authentications in this session.
>>
>=20
> ACK, if you wrap the long lines and update the commit message.
>=20

Thanks a lot! As there were some more slight changes, I decided to send
a v2 patch, just for avoid any further confusion.


--=20
kind regards,

David Sommerseth


--2GNcKkSrftETcAxTSgPjfpTdheSu431XK--

--b77oRdQ7Fj7Xgn8kLrxr0g78OF47nnnH4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYATDvAAoJEIbPlEyWcf3yQW4P/2npQJh+YEgmP6+Z73kxHIW1
zJae70ly5eKe+nRO8R8H66WLr62ZqHju9fYUHop/OES0I5ZINfjNg1PvwLCM6lJY
Qb1gHsqDkKoYuUtHHRFNh2vKnjjmf72k5s/KBzI+UOCgORaJ/LmCtg8B1jSvSVf4
iDM9C0XdnFIb02jQ+tKV4gyimIKL7xsAKInrPTQt8S5oKKThhg3K4ln9c2ctMK/H
vs9WtvojViWmCmLmUcbqFwL5WgWfeKFto7rokdvjXXimxQYVvoEBvvIx3IPUu6JU
EQI+4IzyQrvg1zTAtsUuB7W0azIdcKhwtQ4DdpczZFSe0tOG4Aw4D8zEJDbbjsHb
PZLsNCqNLgzJAl6IJB7icb07v6k9GbVvYZw/l1STMkWy+lHZhrZo1eSsiVBN0ZZn
sZJQT4FarbIr+pHhbWRPGBeUJUqzTyALIrVYMI7sJp9YdEXHpRMPVBFTRKel8Z4m
cvWXASdfa1xPLn2A8tr49O1Z4a/haxIGJOBHcb0IQQhJeeeB1UFgpynl67rE9DgP
I9GPhl+8fwnuLMMI9XZFNrtyP8tAspD9OEwsyu/X4rmVaTZiZIa9WD7JgsHpXjDR
1jLu2XkKPp13x8JD97aJHK17rxq7FYhJd32ybROy4eNadfvGYIJmDdKvJwlY8OSV
4ZsJR0qbHgnshGh2qHRL
=QvBk
-----END PGP SIGNATURE-----

--b77oRdQ7Fj7Xgn8kLrxr0g78OF47nnnH4--

