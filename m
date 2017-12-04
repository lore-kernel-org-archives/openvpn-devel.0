References: <20171203131651.622-1-a@...2181...>
 <8607686f-75ac-ab6a-21a9-5aab8aea34c3@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <40f364f6-9347-56a2-6915-82f9005d9d20@...2181...>
Date: Mon, 4 Dec 2017 12:06:41 +0800
MIME-Version: 1.0
In-Reply-To: <8607686f-75ac-ab6a-21a9-5aab8aea34c3@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="H8uAE9AJSQfibpp0KIXnNdEOT0VNr0P82"
Subject: Re: [Openvpn-devel] [PATCH v2] reload HTTP proxy credentials when
 moving to the next connection profile
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--H8uAE9AJSQfibpp0KIXnNdEOT0VNr0P82
Content-Type: multipart/mixed; boundary="aKapb4WFE2PxNlLb8guVGq4pCAxOmrjLK";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <40f364f6-9347-56a2-6915-82f9005d9d20@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2] reload HTTP proxy credentials when
 moving to the next connection profile
References: <20171203131651.622-1-a@...2181...>
 <8607686f-75ac-ab6a-21a9-5aab8aea34c3@...1856...>
In-Reply-To: <8607686f-75ac-ab6a-21a9-5aab8aea34c3@...1856...>

--aKapb4WFE2PxNlLb8guVGq4pCAxOmrjLK
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 03/12/17 23:02, Steffan Karger wrote:
> Hi,
>=20
> Feature-ACK, but one implementation concern:
>=20
> On 03-12-17 14:16, Antonio Quartulli wrote:
>> The HTTP proxy credentials are stored in a static variable that is
>> possibly initialized before each connection attempt.
>>
>> However, the variable is never "released" therefore get_user_pass()
>> refuses to overwrite its content and leaves it as it is.
>> Consequently, if the user config contains multiple connection profiles
>> with different http-proxy, each having its own credentials, only the
>> first user/pass couple is loaded and the others are all ignored.
>> This leads to connection failures because the proper credentials are
>> not associated with the right proxy server.
>>
>> The root of the misbehaviour seems to be located in the fact that,
>> despite the argument force passed to get_user_pass_http() being true,
>> no action is taken to release the static object containing the
>> credentials.
>>
>> Fix the misbehaviour by releasing the http-proxy credential object
>> when the reload is "forced".
>>
>> Trac: #836
>> Signed-off-by: Antonio Quartulli <a@...2181...>
>> ---
>>
>> v2:
>> - rebased on current master
>>
>>  src/openvpn/proxy.c | 11 ++++++++++-
>>  1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
>> index fdc73b4a..cfc1d11c 100644
>> --- a/src/openvpn/proxy.c
>> +++ b/src/openvpn/proxy.c
>> @@ -255,7 +255,16 @@ username_password_as_base64(const struct http_proxy=
_info *p,
>>  static void
>>  get_user_pass_http(struct http_proxy_info *p, const bool force)
>>  {
>> -    if (!static_proxy_user_pass.defined || force)
>> +    /*
>> +     * in case of forced (re)load, make sure the static storage is set =
as
>> +     * undefined, otherwise get_user_pass() won't try to load any crede=
ntial
>> +     */
>> +    if (force)
>> +    {
>> +        static_proxy_user_pass.defined =3D false;
>> +    }
>=20
> I'm wondering, shouldn't we clear the username/password in the struct if
> we set defined=3Dfalse as a hardening measure?  And shouldn't we then just
> replace this if(force) block with a call to purge_user_pass(up, force)?
> Or should we be careful to not clear the other members of
> static_proxy_user_pass?

There should be no problem in clearing up the struct, because the idea
is that it has to be fully reinitialized with the "next proxy"
information (so nothing to save).

Actually we could just re-use clear_user_pass_http() that is there for
this purpose.


I'll send v3 with this change.


Thanks a lot for your review!

Cheers,

>=20
> -Steffan
>=20
> -------------------------------------------------------------------------=
-----
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
Antonio Quartulli


--aKapb4WFE2PxNlLb8guVGq4pCAxOmrjLK--

--H8uAE9AJSQfibpp0KIXnNdEOT0VNr0P82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlokydEACgkQB6U8WA7y
zXSoGQ/+MtwvcFpvSMFfVXdAVNYaJsRS6T49tFxINyMQrC3/pU69m/WAGnlUC7A5
T2LeIYtEi7As8MKf3iIL8yKSAkuY7Beq+5bYTr9oiun+A+Htcpn9pv7SKSfnRFVT
Rm0e1vuDHDtB8X71ObGIS510o7NRwjY1wzqocPRLfGuWP5sboJ0xbZd0sBw6xmBu
2JySl4Kne0XV4C4jD8XeEBZUI6vc/il5D0jnwwFNi/Cwja0QGX6+9txlY9Lq8M1o
8J9OTdhlnJ3vcFObAPNL1PfBPWYvegMbbRGoG4pWTnGE0Qryi48ZyNHzCt0448AK
yDJf3HEW8tzZjfO5LFsnZxAc4jn2HjLM7y7jnXnPcm6ko23J4CAX/Z5ROMlNuNry
hHLGcO5POPcNzP+8bHemxMrbfbd14YLhRNkD8CkDQvraNr7rE3kWEdCp/TZpNjnq
Bk48pcyXJN37AtzLB9W0ipZWZQp3zAnfxU4TLG/SopA+wJtu8v0lUEg88qDirqJy
zi9yfH8JIvLFR3YMWI/gQwtd+/S4fuYOlqo8CM7i4Dfk3BViu8o4j5hQBF2p2y2/
SQm3ZDNt2xiSRMoiaclJxuJhEEy0oRUgU2q7x/k/qNTSk9+SjCuELxlKHTX3T4k4
LVi8DENRb8saWOKHbyLDSNq4vJe3Jxi1QT7/wPdW8kWG8YHVOcA=
=4NK4
-----END PGP SIGNATURE-----

--H8uAE9AJSQfibpp0KIXnNdEOT0VNr0P82--

