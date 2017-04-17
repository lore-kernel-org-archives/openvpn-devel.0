References: <20170413172609.29093-1-davids@...515...>
	<20170417090156.5218-1-davids@...515...>
	<3eb7511d-c2c5-cb12-f95f-e4a6b4649b5e@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <426c9b5e-c863-7ce3-1b98-1edfa7b62a98@...2080...>
Date: Mon, 17 Apr 2017 22:58:27 +0200
MIME-Version: 1.0
In-Reply-To: <3eb7511d-c2c5-cb12-f95f-e4a6b4649b5e@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="M00hsEkQcNijqHxCWEdHS7KRrAiFgixEm"
Subject: Re: [Openvpn-devel] [PATCH v2] Fix broken ./configure on systems
 without openssl.pc
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
--M00hsEkQcNijqHxCWEdHS7KRrAiFgixEm
Content-Type: multipart/mixed; boundary="GQr0WWKMrssph04DU1VaiictOeTCHr1H4";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <426c9b5e-c863-7ce3-1b98-1edfa7b62a98@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix broken ./configure on systems
	without openssl.pc
References: <20170413172609.29093-1-davids@...515...>
	<20170417090156.5218-1-davids@...515...>
	<3eb7511d-c2c5-cb12-f95f-e4a6b4649b5e@...1856...>
In-Reply-To: <3eb7511d-c2c5-cb12-f95f-e4a6b4649b5e@...1856...>

--GQr0WWKMrssph04DU1VaiictOeTCHr1H4
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 17/04/17 22:36, Steffan Karger wrote:
> Hi,
> On 17-04-17 11:01, David Sommerseth wrote:
>> [..]
>>
>> We should anyway in this case have a better check of OpenSSL version
>> available.  So in the case pkg-config fails, it will run an additional
>> test looking for the OpenSSL version number in the opensslv.h header
>> file and check against that version number.
>=20
> Content-wise this looks good, but two remarks:
>=20
>> @@ -861,12 +861,34 @@ if test "${enable_crypto}" =3D "yes" -a "${with_cr=
ypto_library}" =3D "openssl"; then
>>  			[OPENSSL],
>>  			[libcrypto >=3D 1.0.1, libssl >=3D 1.0.1],
>>  	                [have_openssl=3D"yes"],
>> -			[AC_MSG_ERROR([Minimum supported OpenSSL version is 1.0.1])]
>> +			[] # If this fails, we will do another test next
>>  		)
>>=20=20
>>  		OPENSSL_LIBS=3D${OPENSSL_LIBS:--lssl -lcrypto}
>>  	fi
>=20
> I think this OPENSSL_LIBS default can go now, since it is set below if
> needed.

Ah, right.  Somehow I connected that to pkg-config as well.  But you're
right!

>> +        # If pkgconfig check failed or OPENSSL_CFLAGS/OPENSSL_LIBS env =
vars
>> +        # are used, check the version directly in the OpenSSL include f=
ile
>> +        if test "${have_openssl}" !=3D "yes"; then
>> +           AC_MSG_CHECKING([additionally if OpenSSL is available and ve=
rsion >=3D 1.0.1])
>> +	   AC_COMPILE_IFELSE(
>> +		[AC_LANG_PROGRAM(
>> +			[[
>> +#include <openssl/opensslv.h>
>> +			]],
>> +			[[
>> +/*           Version encoding: MNNFFPPS - see opensslv.h for details */
>> +#if OPENSSL_VERSION_NUMBER < 0x10001000L
>> +#error OpenSSL too old
>> +#endif
>> +			]]
>> +		)],
>> +		[AC_MSG_RESULT([ok])],
>> +		[AC_MSG_ERROR([OpenSSL version too old])]
>> +	   )
>> +           OPENSSL_LIBS=3D${OPENSSL_LIBS:--lssl -lcrypto}
>> +        fi
>=20
> Tabs and spaces are mixed here.  The surrounding lines seem to be
> tabs-only.  (This bites me each time I edit configure.ac too...)

Oh bloody h...... *grmbl* .... Something have seriously changed in my
emacs setup during an update or something related; I've never had as
much tab/space mess as I've had lately.  It used to do everything
correct earlier.

I'll send another update soonish.  Thanks!


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--GQr0WWKMrssph04DU1VaiictOeTCHr1H4--

--M00hsEkQcNijqHxCWEdHS7KRrAiFgixEm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJY9Sx7AAoJEIbPlEyWcf3ygTIP/jQwznw5LRdH7PfvDuvSz7+g
Jwc1sstvkOWKXHQaeGc6skO0VkUIeLcqQXvE2EokiuUg6pfFCbZm8ivv7SGOAkxh
4tonaTI8YotHtETYxIN3nBUKU++ObshX0Q8MsCbWPwvtmKCOPuleFpV5+w8IqgHO
O+Ylan0QSSUyA8GPZI6VXiR17DwN+nTLEB0LLqtt4n5xR6yglhJF80tSP05x+1Kb
sbYAYno/cRqvCqBMpz4tRPkcukMvyZU62QCVjNvW8CXlOP4EdrNkt20jZFEsHQK8
rh8wEL/ZQuPxLCZPrJCnB8DeXsfcFFnS35h2VPyIQCCRHmyetavqOdhQW6W/1HKu
Jsm8SfUchQPAlTLyj2aiUYzl686AteVPeXDAc0s62FoWUxJud/XEzZrgvpY7/krv
ofCPmDa3vkH5Fc7+Pioc3Gc2hQhvsk/IJkDGyHr1jCBS819SMhLiUxdAN4Wgee3W
eHEjN9wAYEBJ2UwSJnePeAH2ffU67BFu+54Sih6H14n8dZQsYRCzPEXDZ+j96KQ4
Qm/UvpPsU+T2zz7xsAAiuSC0oRChEDVmG5izmOLx5FSZZv7eRyDojbyH7xW4CLew
9ZTrnZWLHQVSpO6+Urzf1CCO0FD3/5yTigFqfqt/+beZYdXntXTblwszedYy1MhZ
bCOFW00sNh86YJwyG0rN
=DEbn
-----END PGP SIGNATURE-----

--M00hsEkQcNijqHxCWEdHS7KRrAiFgixEm--

