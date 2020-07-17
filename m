From: David Sommerseth <openvpn@...2080...>
References: <20200717150526.124733-1-matthias.andree@...68...>
 <4e8ebfb9-ee76-f7e1-0771-8e8bdb605b5f@...2080...>
Message-ID: <d999eaf5-41f1-d7e8-074f-5e788daa6175@...2080...>
Date: Fri, 17 Jul 2020 18:38:42 +0200
MIME-Version: 1.0
In-Reply-To: <4e8ebfb9-ee76-f7e1-0771-8e8bdb605b5f@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="98vQWtt78uhxTYRAao5s5MWBeoepKNxCW"
Subject: Re: [Openvpn-devel] [PATCH 2/2] Permit make dist* targets without
 py*-docutils
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--98vQWtt78uhxTYRAao5s5MWBeoepKNxCW
Content-Type: multipart/mixed; boundary="vYj52LXY6X5b2nTfOLo1io5JrHklrohdm";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Matthias Andree <matthias.andree@...68...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d999eaf5-41f1-d7e8-074f-5e788daa6175@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] Permit make dist* targets without
 py*-docutils
References: <20200717150526.124733-1-matthias.andree@...68...>
 <4e8ebfb9-ee76-f7e1-0771-8e8bdb605b5f@...2080...>
In-Reply-To: <4e8ebfb9-ee76-f7e1-0771-8e8bdb605b5f@...2080...>

--vYj52LXY6X5b2nTfOLo1io5JrHklrohdm
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 17/07/2020 17:36, David Sommerseth wrote:
> On 17/07/2020 17:05, Matthias Andree wrote:
>> Signed-off-by: Matthias Andree <matthias.andree@...68...>
>> ---
>>  doc/Makefile.am | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/doc/Makefile.am b/doc/Makefile.am
>> index add92198..80cb2cb8 100644
>> --- a/doc/Makefile.am
>> +++ b/doc/Makefile.am
>> @@ -59,8 +59,9 @@ else
>>  endif
>>
>>  if HAVE_PYDOCUTILS
>> -dist_noinst_DATA +=3D openvpn.8
>> -dist_html_DATA =3D openvpn.8.html
>> +nodist_noinst_DATA =3D openvpn.8
>> +nodist_html_DATA =3D openvpn.8.html
>> +EXTRA_DIST =3D openvpn.8 $(nodist_html_DATA)
>>
>>  # Failsafe - do not delete these files unless we can recreate them
>>  CLEANFILES =3D \
>=20
>=20
> Thanks!  This fixes the 'make distdir', which should also fix the 'make c=
heck'
> issues Gert found [1].
>=20
> Acked-By: David Sommerseth <davids@...515...>
>=20
>=20
> [1] Message-Id: 20200717131607.GS1431@...1296...
>=20
> <https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg2043=
6.html>
So I'm just retracting the Acked-By ... as this isn't needed.

We were just confused by some failing tests on one of the buildslaves and
realised to late it failed with 'make dist' - not 'make check'.  And then t=
his
change makes things worse by not distributing generated man/html files if
py-docutils is not present.

All the 'make dist*' targets _should_ fail if py-docutils is not present and
the doc/openvpn.8 and doc/openvpn.8.html files are missing.  Running 'make
check' should not fail in any if these cases.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--vYj52LXY6X5b2nTfOLo1io5JrHklrohdm--

--98vQWtt78uhxTYRAao5s5MWBeoepKNxCW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJfEdQTAAoJEIbPlEyWcf3ydEkP/RnjAmGm2t38ty+3cACWsta7
tOI6M2bA4mhCBLgN4AlEt/C4j0i+vo38NypILNFqR6xc6MfyFHQfpeRwCUcgU5LM
BQlx8hSpf2gg17plyKRcXM8d98y4pA2NVCao5t+APAm6d/fxOZ8gOqKrqFrfnlqF
ONju4RLInSX37FXIXwCXH3d/cUfbbH03fsxYtxaE/x+nFktEacxX2to5nVzTnv/W
XbqNf37ke+BzbAVWKkgKtwrq2RPy+CgFPqhdLfV1ieH0Ydv33H5OuCuxF3c35mQR
JvsxmR+aacMDUplp8Sur0pfbMZAlES1S7HpeMYhz03Ij+ths61uVjpOYUJjF3L/r
ZVimRA0QLP1fkvK23HO7E3ahwR56vLkAEvodCf6BwAO7oAm2SPaCAUBrz2OKVuGq
KbsUJZiJUt2fl3qQYhpPist/jbUOZ7e1KnA4gqi4rDI+Wnfw7IEk+kznmq+OJzhV
FN/nRqnvMsmkzH80E+goCRlMSAQKun69BffhWu0JhaOqnqY74pvgFDLJ3bQ8pOP/
NsWHA8QJhsAExyqGYWHz4ERUqGwzYimkyTVJ/3MU27f7Jx/VSY07696fGyQWLjxX
gsMsgskF2GT1/LaVY8unYGp9/JfVEsZXjhFRcAwv/qaQIinGFZHXaaQcDIV3cv+i
XzVWhD/OrApf31rU4ti6
=U0YT
-----END PGP SIGNATURE-----

--98vQWtt78uhxTYRAao5s5MWBeoepKNxCW--

