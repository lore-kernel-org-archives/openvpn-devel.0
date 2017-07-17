References: <20170716104714.2113-1-a@...2181...>
	<efbe1728-11a2-2be8-2cdc-4bd845e1e1d2@...515...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <89c6cc9c-7f11-2b85-9eee-252dfb012a63@...2181...>
Date: Mon, 17 Jul 2017 15:54:53 +0800
MIME-Version: 1.0
In-Reply-To: <efbe1728-11a2-2be8-2cdc-4bd845e1e1d2@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7Wt2drOxmI9OB30UShaS86pUOuw3IFJoH"
Subject: Re: [Openvpn-devel] [PATCH openvpn-build] fix test when white space
 is present
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7Wt2drOxmI9OB30UShaS86pUOuw3IFJoH
Content-Type: multipart/mixed; boundary="3RlRBDIXmaIP5C3FQ3X8HxxBT3IVLtx59";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <89c6cc9c-7f11-2b85-9eee-252dfb012a63@...2181...>
Subject: Re: [Openvpn-devel] [PATCH openvpn-build] fix test when white space
 is present
References: <20170716104714.2113-1-a@...2181...>
 <efbe1728-11a2-2be8-2cdc-4bd845e1e1d2@...515...>
In-Reply-To: <efbe1728-11a2-2be8-2cdc-4bd845e1e1d2@...515...>

--3RlRBDIXmaIP5C3FQ3X8HxxBT3IVLtx59
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



On 17/07/17 15:54, Samuli Sepp=C3=A4nen wrote:
> On 16/07/2017 13:47, Antonio Quartulli wrote:
>> For some CHOST ret_want and ret_got may contain a whitespace.
>> Add double quotes around ret_want to avoid messing up the test.
>>
>> Signed-off-by: Antonio Quartulli <a@...2181...>
>> ---
>>  generic/gentoo.config-0.9.8 | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/generic/gentoo.config-0.9.8 b/generic/gentoo.config-0.9.8
>> index 2361ae6..7051886 100755
>> --- a/generic/gentoo.config-0.9.8
>> +++ b/generic/gentoo.config-0.9.8
>> @@ -45,7 +45,7 @@ if [ "$1" =3D "test" ] ; then
>>  		ret_want=3D${c/*|}
>>  		ret_got=3D$(CHOST=3D${CHOST} "$0")
>>=20=20
>> -		if [ ${ret_want} =3D "${ret_got}" ] ; then
>> +		if [ "${ret_want}" =3D "${ret_got}" ] ; then
>>  			echo "PASS: ${CHOST}"
>>  		else
>>  			echo "FAIL: ${CHOST}"
>>
>=20
> Hi Antonio,
>=20
> Would you mind sending this and the "add support for aarch64" patch as
> GitHub pull requests here:
>=20
> <https://github.com/OpenVPN/openvpn-build>

Sure, will do!

Cheers,

--=20
Antonio Quartulli


--3RlRBDIXmaIP5C3FQ3X8HxxBT3IVLtx59--

--7Wt2drOxmI9OB30UShaS86pUOuw3IFJoH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAllsbU0ACgkQ0+HICM1s
oFB6VA/+IWy0K+qU7NnGJURVgzxWWZMuj4909MICk8hcls04qdclQSfH1WiU7oK/
RgLMQMsmaC0C3yLnntLVaFKvEfjNAEc+I+BuQwvGyh2vlmKs7tQYH1tuqBO9KApC
vj12GLHTLS0GdiIXa2ODDWEPRIJ1q4uj853xmyFk+WJdOFL2vG5TH3A9b5pPL+CU
amH5uewfjLeYaDqF6xcWCuYsx54Ap153XjlXB2oeKN5ae3dtSbb9xkcJlaJ+iPvJ
0KdPlFiqjAUQB0Wijo9tfrPbCS/q90Zoqywf4nLrHKq25pwenpAruUN9T7hmmwQQ
5dFG2j/33HfjQicK+54tPHJBw/5Z4Ti2Z0NN37gofqlFSrsydWR3p2h9Yd1zUOgh
ZoI2BfIxrGpC2Jb5F3fcyQ3MPZ4yaMGv1RlnNkm4uY6qTPRclfuViWp7mSHQTaXZ
48zRNdfRdKsB0L1UF7D4nd6mSFyU1JdkX49KLz8XZsIm9TLJ8ysmHZp1J53COgCV
Ku6UqRibtCjLRXeSEJcK800/T456HWzprqaxWsnUiPvvYI/g+O4xOHD7ofMyTm17
cHlmsw+mBh/H0BLqgm7oxZdwxw7fkgogQSKppqTZWJX7rodwA/sAzrNQ+D2rp2W1
O7EtFueTEzA4Y8tahiVWzT2Gywjk22Ej+thWAZdgDJGXPWjkCmA=
=sFIe
-----END PGP SIGNATURE-----

--7Wt2drOxmI9OB30UShaS86pUOuw3IFJoH--

