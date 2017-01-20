References: <1484297432-14435-1-git-send-email-chipitsine@...277...>
	<7dc75a19-451e-effa-503a-ac5b75a23bab@...515...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <ac93d2de-d56a-0ff9-b97a-a590923f5cf8@...2080...>
Date: Fri, 20 Jan 2017 20:24:59 +0100
MIME-Version: 1.0
In-Reply-To: <7dc75a19-451e-effa-503a-ac5b75a23bab@...515...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Jv4DXfBDv0KiGbjhJ2RaSTm0bvlLTNRK5"
Subject: Re: [Openvpn-devel] [PATCH] add PR template in order to simplify
 new developers cooperate properly if they open PR. discussed here:
 https://sourceforge.net/p/openvpn/mailman/message/35601310/
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, Ilya Shipitsin <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jv4DXfBDv0KiGbjhJ2RaSTm0bvlLTNRK5
Content-Type: multipart/mixed; boundary="D6LUIwQJfFfbdPrQuKWqMMD9fqAUsW8lG";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
	Ilya Shipitsin <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <ac93d2de-d56a-0ff9-b97a-a590923f5cf8@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] add PR template in order to simplify new
	developers cooperate properly if they open PR. discussed here:
	https://sourceforge.net/p/openvpn/mailman/message/35601310/
References: <1484297432-14435-1-git-send-email-chipitsine@...277...>
	<7dc75a19-451e-effa-503a-ac5b75a23bab@...515...>
In-Reply-To: <7dc75a19-451e-effa-503a-ac5b75a23bab@...515...>

--D6LUIwQJfFfbdPrQuKWqMMD9fqAUsW8lG
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 13/01/17 10:05, Samuli Sepp=E4nen wrote:
> Il 13/01/2017 10:50, Ilya Shipitsin ha scritto:
>> ---
>>  .github/PULL_REQUEST_TEMPLATE.md | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>  create mode 100644 .github/PULL_REQUEST_TEMPLATE.md
>>
>> diff --git a/.github/PULL_REQUEST_TEMPLATE.md b/.github/PULL_REQUEST_TEM=
PLATE.md
>> new file mode 100644
>> index 0000000..d0cfd7f
>> --- /dev/null
>> +++ b/.github/PULL_REQUEST_TEMPLATE.md
>> @@ -0,0 +1,8 @@
>> +# Thank you for your contribution
>> +
>> +You are welcome to open PR, but they are used for discussion only. All
>> +patches must eventually go to the openvpn-devel mailing list for review.
>> +For details, see these Wiki articles:
>> +
>> +* https://community.openvpn.net/openvpn/wiki/Contributing
>> +* https://community.openvpn.net/openvpn/wiki/DeveloperDocumentation
>>
>=20
> Based on testing in the travis-openssl-test repository the template=20
> works as intended, so ACK on that part.
>=20
> Any comments on the text itself?

How does this work with branches?  Do we need to say that new patches
should go into the master branch primarily, unless it is fixing a bug or
another issue which is only relevant for specific release branches?


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--D6LUIwQJfFfbdPrQuKWqMMD9fqAUsW8lG--

--Jv4DXfBDv0KiGbjhJ2RaSTm0bvlLTNRK5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYgmQMAAoJEIbPlEyWcf3ygkwP/jY2YBDBCrZPFUWleIc4SAMo
FJwifYS2hpLZCKmrk439W2zrkoTJ594i/WtzGYcXEgxKTzmYMXhITeNK/yi6Jpui
5tFfhcZXPXpRicZlEuAw0JnJ27FD99clsTwZ4WOVYXRkNga/ytT6O2/5JJeTM77h
HwJuMfEhtoBxiTjcShB7wrb93E0hz5774FcZzOyp3lMG+r+FWbkmgLA7MuZ2gTb3
t6RcLSzHHJmokONg58pKeVWK/IuxawYzaHEi4j7sVAUaPoSWphGfPraT/Ol3oZXg
2eA3tp7/xdaRJ7Vx/dWZQI/q5zFQyNxK0xOdDJSXUPo4eFDySrLr+YceOe4i/6yn
j4JSbkMk+eBsukuD0IUlCvcP+v+XPM1RAd2SIcUY+4MBPWsphEVGhdDrxwh7OwqO
KD/x7Ead2uA7p9Ri2kMFzE7SrBe7PFW24Itk+3IiHZsrtD6RASLdxJyubcX2rOxD
qoyapF8KbPai34fjcF7X88BufVDgTKNwmLO0uGVfPgG2TYfVh9uqAG1Cj1xc2+JR
bB4R7uJNgpSA38eAbSWbmaU6xEoCM2H41voDJ/femXcukAKtRbdwx8NPX3FFZKzK
wKb9dN1RRSWWs/1JAKIWI3EbCdEOBy5nc4xk0hwxUScMIK20ZEbH6q1L7PqdHkSd
TAacUiAryg1kQjBQckx+
=qLD7
-----END PGP SIGNATURE-----

--Jv4DXfBDv0KiGbjhJ2RaSTm0bvlLTNRK5--

