From: Arne Schwabe <arne@...1227...>
References: <20191117181243.28919-1-arne@...1227...>
 <20191117212318.13428-1-arne@...1227...>
 <50f7e1b9-e443-3efe-af8e-1eb5b8d2e082@...1227...>
Message-ID: <c62577f1-885e-0103-52bf-f4cf4a154895@...1227...>
Date: Thu, 13 Feb 2020 14:52:52 +0100
MIME-Version: 1.0
In-Reply-To: <50f7e1b9-e443-3efe-af8e-1eb5b8d2e082@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="eXJaByq3bqQzeStwYr5Z4fY4BsKSzQ92y"
Subject: Re: [Openvpn-devel] [PATCH 5/4] Add ncp files to Visual studio print
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eXJaByq3bqQzeStwYr5Z4fY4BsKSzQ92y
Content-Type: multipart/mixed; boundary="TG4dA3nwNMsSdRRtZx9X9aidABSNKmoRx"

--TG4dA3nwNMsSdRRtZx9X9aidABSNKmoRx
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 18.11.19 um 09:45 schrieb Arne Schwabe:
> Am 17.11.19 um 22:23 schrieb Arne Schwabe:
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>  src/openvpn/openvpn.vcxproj | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
>> index 7446d97d..b3d35ba2 100644
>> --- a/src/openvpn/openvpn.vcxproj
>> +++ b/src/openvpn/openvpn.vcxproj
>> @@ -191,6 +191,7 @@
>>      <ClCompile Include=3D"socks.c" />
>>      <ClCompile Include=3D"ssl.c" />
>>      <ClCompile Include=3D"ssl_openssl.c" />
>> +    <ClCompile Include=3D"ssl_ncp.c" />
>>      <ClCompile Include=3D"ssl_verify.c" />
>>      <ClCompile Include=3D"ssl_verify_openssl.c" />
>>      <ClCompile Include=3D"status.c" />
>> @@ -276,6 +277,7 @@
>>      <ClInclude Include=3D"ssl.h" />
>>      <ClInclude Include=3D"ssl_backend.h" />
>>      <ClInclude Include=3D"ssl_common.h" />
>> +    <ClInclude Include=3D"ssl_ncp.h" />
>>      <ClInclude Include=3D"ssl_openssl.h" />
>>      <ClInclude Include=3D"ssl_verify.h" />
>>      <ClInclude Include=3D"ssl_verify_backend.h" />
>>
>=20
> Note this patch can be merged into the 4/4 patch. I just did not want to
> resend 4/4 for this tiny patch. Should a V2 of 4/4 be needed, I will
> include this one into it.

V2 of 4/5 includes now this patch and this patch is obsolute.


--TG4dA3nwNMsSdRRtZx9X9aidABSNKmoRx--

--eXJaByq3bqQzeStwYr5Z4fY4BsKSzQ92y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl5FVLQACgkQFRhsZwKx
RFRf1xAAo6KoTBCD6/Tkd5yLgzPo4ROUzHBXL7xiGOhfFAjlITCvyqCr01sEW97H
YIBBVNJ05Fn2vEtdYuzjiFMKkZ04CvxfQ8cXza7cWKodYxJ4BFyiUxI95D7oHKdO
osndcNOO4JnHDwtKXgEAsLfBjYtp4MSU9zFk/LBPU/OxbyMvIk49wp9JdFKCtW4E
lPNYND1fZxNFkzVRCKHTpRlhG7auwnzb18YWIih1x8HIh9nX25AjOEu8bZF0uA8V
/s4yHwqiqbkW5yEO7IoPmX0YjTbacSTJs1o5pwPnfzBVIHTEkfnjEkaBxcqwd1sI
8WzrSSm1b61V/5jvlxeMxdZ5U8ArqZ6Drgk6+zIIRYfLT1TFza1ryy4CMOz1+bfn
2pSJzDdvOiILkhlwni/VHnm4qYjls3ukFCh1T9DSmzkEHBWoPoi2JDZhvC6SS7Qs
3CzQJM2sCexUtcGOX+ifDQD+Z97nyf/EKyPwCL4Ob1En5ZnaVGofA4A8dfya0WZ0
8Gz1eDYygUyur7iyWr+WEUKCLb2rodPLHyM98ejWzpuuJN6HE0YodD29A+nxk6+R
AC4ZUKybJvHDp29Z3xZnmZuDLwIRyjGkxWjMRqpnCcf2r/s8RTTHkEHnnzEqCfuY
rqCkL7nGvzuTKtZaB7hge9OsIYtnHhfPdkFc4/SmC/SqsGzuAtI=
=KwQB
-----END PGP SIGNATURE-----

--eXJaByq3bqQzeStwYr5Z4fY4BsKSzQ92y--

