From: David Sommerseth <openvpn@...2080...>
References: <20191109151306.18597-1-arne@...1227...>
 <20191109151306.18597-2-arne@...1227...>
 <96f9411c-1dd3-d19e-4845-83974ca0c836@...2080...>
Message-ID: <53fa2c7b-b7b3-30ca-c0ad-fc874f8905b7@...2080...>
Date: Fri, 27 Mar 2020 22:36:56 +0100
MIME-Version: 1.0
In-Reply-To: <96f9411c-1dd3-d19e-4845-83974ca0c836@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="b2LrIIwGnhhBKAIHHdwfQDJ0sQqRGjQsx"
Subject: Re: [Openvpn-devel] [PATCH v2 2/5] Implement support for signalling
 IV_SSO to server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--b2LrIIwGnhhBKAIHHdwfQDJ0sQqRGjQsx
Content-Type: multipart/mixed; boundary="xKRCCZhwGD3DBQTyfWvWLT868JHPLKHDP";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <53fa2c7b-b7b3-30ca-c0ad-fc874f8905b7@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2 2/5] Implement support for signalling
 IV_SSO to server
References: <20191109151306.18597-1-arne@...1227...>
 <20191109151306.18597-2-arne@...1227...>
 <96f9411c-1dd3-d19e-4845-83974ca0c836@...2080...>
In-Reply-To: <96f9411c-1dd3-d19e-4845-83974ca0c836@...2080...>

--xKRCCZhwGD3DBQTyfWvWLT868JHPLKHDP
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Sorry, I'm loosing grip of my mailing-list-fu ... Managed to reply only to =
Arne.

On 27/03/2020 21:59, David Sommerseth wrote:
> On 09/11/2019 16:13, Arne Schwabe wrote:
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>  src/openvpn/ssl.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
>> index 4455ebb8..cbb87e43 100644
>> --- a/src/openvpn/ssl.c
>> +++ b/src/openvpn/ssl.c
>> @@ -2355,7 +2355,9 @@ push_peer_info(struct buffer *buf, struct tls_sess=
ion *session)
>>                  if ((((strncmp(e->string, "UV_", 3)=3D=3D0
>>                         || strncmp(e->string, "IV_PLAT_VER=3D", sizeof("=
IV_PLAT_VER=3D")-1)=3D=3D0)
>>                        && session->opt->push_peer_info_detail >=3D 2)
>> -                     || (strncmp(e->string,"IV_GUI_VER=3D",sizeof("IV_G=
UI_VER=3D")-1)=3D=3D0))
>> +                     || (strncmp(e->string,"IV_GUI_VER=3D",sizeof("IV_G=
UI_VER=3D")-1)=3D=3D0)
>> +                     || (strncmp(e->string,"IV_SSO=3D",sizeof("IV_SSO=
=3D")-1)=3D=3D0)
>> +                     )
>>                      && buf_safe(&out, strlen(e->string)+1))
>>                  {
>>                      buf_printf(&out, "%s\n", e->string);
>>
>=20
> Code looks good, smoke tested on RHEL-7 against a test server without any=
 issues.
>=20
> Test 1: openvpn --config test.conf --push-peer-info
> No IV_SSO entry found in server log.
>=20
> Test 2: openvpn --config test.conf --push-peer-info --setenv IV_SSO 1
> IV_SSO=3D1 was found in server log
>=20
> Test 3: openvpn --config test.conf --push-peer-info setenv IV_SSX 1
> No IV_SSO nor IV_SSX found in server log
>=20

Acked-by: David Sommerseth <davids@...515...>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--xKRCCZhwGD3DBQTyfWvWLT868JHPLKHDP--

--b2LrIIwGnhhBKAIHHdwfQDJ0sQqRGjQsx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJefnH4AAoJEIbPlEyWcf3yebsP/jPbg806zRpaKaFKecW87WHv
OXeRz4fB3NVgCLvhzPq1bvnNzvFqVfuj7M6vj6hjonwGxU1zFaBcjaGwBL70fxJC
nyPhld3XxynKn9oCvagRvw5exnX65ZBKlpFUmp/MccwhvTjgrVeZS/nebyX5AY6H
+xjAvJeXV09HynwuZTjwcIAFw9pQwM5Db3S3r2fmBAycGRtp/wcJIAL0Xe992hFG
6W+M8Dr1LiFvfKYIJ9sMhNxEnge6MHNzSk5nk2a5UQZng7TQftn2rqTaCsXJw5QB
hP6fA0Jwb+GpwM6eXoC4PRIl8QHpUeigfsT7aZVie0nwPisgYfGFyZIV80MYqJuF
d7XvMwuPJ9YVLImWGLnB0Gyetme5eULWPZFtSEHtWaMrTtxs+eR5/H5Lh1EA8bG3
FahGZy44LERDpsDQe0HIPcTcDpasDV8AcddgT9l1gFgFrR6f1zGLQWK2VtmZRK7O
GR5zHqY68hRY5DD/Q/ZDhgOBMvcZz1DDT7EM5cmCfMx/+G9WJgvVm8SwxmehplKg
HX6+ihPN94H0FL/jnkEIovhMPLJR/+9HamctDEAn/VSaYMcSOWTzUwBMPBnSY69o
zN+wmBRm7oxvmnGgUwz+8nBuG/tHoQTg+frwCZvTJmJSF+xFOn0I/WloqBiMV6DQ
IMaIPIGtc9YJb1hBE91J
=2hwy
-----END PGP SIGNATURE-----

--b2LrIIwGnhhBKAIHHdwfQDJ0sQqRGjQsx--

