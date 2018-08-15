From: Antonio Quartulli <a@...2181...>
References: <20180815051540.25118-1-a@...2181...>
 <b3f74d10-d20e-9746-a45e-b47bb1664b18@...2181...>
Message-ID: <70d603a7-0ff4-5b55-a14b-8be2ca749b3c@...2181...>
Date: Wed, 15 Aug 2018 13:41:02 +0800
MIME-Version: 1.0
In-Reply-To: <b3f74d10-d20e-9746-a45e-b47bb1664b18@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zpvk0ImXiUsr3KJwAS0MuADcVNIYtOTAz"
Subject: Re: [Openvpn-devel] [PATCH] ssl_verify: define label only when
 required
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zpvk0ImXiUsr3KJwAS0MuADcVNIYtOTAz
Content-Type: multipart/mixed; boundary="yZ5SovpzLjwC7mMEiJ9BVyfnnxFGcmRLy";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <70d603a7-0ff4-5b55-a14b-8be2ca749b3c@...2181...>
Subject: Re: [PATCH] ssl_verify: define label only when required
References: <20180815051540.25118-1-a@...2181...>
 <b3f74d10-d20e-9746-a45e-b47bb1664b18@...2181...>
In-Reply-To: <b3f74d10-d20e-9746-a45e-b47bb1664b18@...2181...>

--yZ5SovpzLjwC7mMEiJ9BVyfnnxFGcmRLy
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 15/08/18 13:32, Antonio Quartulli wrote:
> Hi,
>=20
> On 15/08/18 13:15, Antonio Quartulli wrote:
>> The "cleanup" label in ssl_verify.c:verify_user_pass_plugin() is used
>> only when PLUGIN_DEF_AUTH is defined, therefore make the label
>> definition dependent on the same define.
>>
>> At the moment, gcc throws an error for unused label if PLUGIN_DEF_AUTH
>> is not defined.
>>
>> Signed-off-by: Antonio Quartulli <a@...2181...>
>> ---
>>  src/openvpn/ssl_verify.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
>> index 61872251..9dfe23f8 100644
>> --- a/src/openvpn/ssl_verify.c
>> +++ b/src/openvpn/ssl_verify.c
>> @@ -1220,7 +1220,9 @@ verify_user_pass_plugin(struct tls_session *sessio=
n, const struct user_pass *up,
>>          msg(D_TLS_ERRORS, "TLS Auth Error (verify_user_pass_plugin): pe=
er provided a blank username");
>>      }
>>=20=20
>> +#ifdef PLUGIN_DEF_AUT
>>  cleanup:
>> +#endif
>>      return retval;
>>  }
>>=20=20
>=20
>=20
> Not sure which gcc version is being used on Gitlab-CI, but my jobs are
> failing with:
>=20
> ssl_verify.c:1197:13: error: label 'cleanup' used but not defined
>              goto cleanup;
>              ^~~~
> Makefile:680: recipe for target 'ssl_verify.o' failed
> make[3]: *** [ssl_verify.o] Error 1
>=20
> It seems this is not just a warning anymore.

Sorry, I acted before being fully awake.

This is obviously not a warning because it tries to use a label that
does not exist...

Indeed my patch is wrong and I messed it up.

Forget about this. I'll send a proper v2.

Cheers,


--=20
Antonio Quartulli


--yZ5SovpzLjwC7mMEiJ9BVyfnnxFGcmRLy--

--zpvk0ImXiUsr3KJwAS0MuADcVNIYtOTAz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltzvO4ACgkQB6U8WA7y
zXTWXw/8CbmPpNJtSP1DFm2/tdWSAA/OgtedcqLnFH9+iMcPPX5L8PHuSLDMricW
pVY3JYhWxElJqfY22+QkpFZ4hMZOC0kQ6lY+evblUjrO00dKEYe9Rcp0rBJv+MKI
jgQ0j5hpNxbZBAN/apeiO/wCG3jyJ0FnfIBdvWNXQZI3Y6DbWTl30nzaDw1tNXXq
fcpz2LgqxiXbDX08q2eyrxEJZ6JA9/2kAHzodfhD74J5EUB2ebFSq1x4Fkak5RRX
b9iJ+fz8HwFd+Gb/ep780VOfZwqraZzUFmvYvTDy38I8pD3wgpIKP2WL9Tf0iymx
xi+isaOgGeX9xPdPiX/ogMmbkcVHq4KrFx5t9eZ1xG2cdJK1JyTYcgiP94mFQDlh
nsXR3IUPWrYiGAwiufXSRNNkeJVwRXiEjsy4KAA8DP5RQCBcKWlrK7mIiN5nIkvA
sYYyuSUfJ0bELDKW0yDD5Jwc+HCma7nQ6eXysFuO01AoBmJje2dOyKmFCikTuzM5
9q2o7UFKQj0gXcPMIyMMsLf8SBXVYyjUxGlq5+6xu3OKKZlnQIaAfPD3eALYYRKC
iz2Esc96ZoHyGs9H8vpfRcJTT11CcxjKqBu/YAS1LwF8az3eAIGnI6n5RscP1Rac
Ts7NICxP5JCDPwlWlEifdZlQSxk/BgAKPRhfGyVdDQxcWuUevcg=
=mQs9
-----END PGP SIGNATURE-----

--zpvk0ImXiUsr3KJwAS0MuADcVNIYtOTAz--

