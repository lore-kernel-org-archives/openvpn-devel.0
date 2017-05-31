Reply-To: openvpn-devel@lists.sourceforge.net
References: <1496177444-18373-1-git-send-email-steffan@...1856...>
	<29f51139-a525-fd92-0fe1-195d308d2924@...2080...>
	<20170531070258.GC97029@...1296...>
	<ae93b702-4edd-6772-0f1d-ac9629589ee8@...2080...>
	<20170531092817.GH97029@...1296...>
	<7bb03bbe8955dacd3a3130f64724024f.squirrel@...2257...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <8fb2b96f-67c8-73ba-3dfd-13ddce59b599@...2080...>
Date: Wed, 31 May 2017 17:08:05 +0200
MIME-Version: 1.0
In-Reply-To: <7bb03bbe8955dacd3a3130f64724024f.squirrel@...2257...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ne5veO3pRGb39xn74B4l5TJDI3hGFi8bn"
Subject: Re: [Openvpn-devel] [PATCH release/2.4] configure.ac: fix building
 against static openssl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Matter <simon.matter@...2249...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ne5veO3pRGb39xn74B4l5TJDI3hGFi8bn
Content-Type: multipart/mixed; boundary="0G3Tr2ja7urddEet8A9XKuOFt9iEAQRAo";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Simon Matter <simon.matter@...2249...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <8fb2b96f-67c8-73ba-3dfd-13ddce59b599@...2080...>
Subject: Re: [Openvpn-devel] [PATCH release/2.4] configure.ac: fix building
 against static openssl
References: <1496177444-18373-1-git-send-email-steffan@...1856...>
 <29f51139-a525-fd92-0fe1-195d308d2924@...2080...>
 <20170531070258.GC97029@...1296...>
 <ae93b702-4edd-6772-0f1d-ac9629589ee8@...2080...>
 <20170531092817.GH97029@...1296...>
 <7bb03bbe8955dacd3a3130f64724024f.squirrel@...2257...>
In-Reply-To: <7bb03bbe8955dacd3a3130f64724024f.squirrel@...2257...>

--0G3Tr2ja7urddEet8A9XKuOFt9iEAQRAo
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 31/05/17 15:51, Simon Matter wrote:
>> Hi,
>>
>> On Wed, May 31, 2017 at 11:14:33AM +0200, David Sommerseth wrote:
>>> On 31/05/17 09:02, Gert Doering wrote:
>>>> Hi,
>>>>
>>>> On Wed, May 31, 2017 at 02:31:40AM +0200, David Sommerseth wrote:
>>>>> If we really do care for supporting 0.9.8, in release/2.4 - I can
>>> give
>>>>> this an ACK.  Otherwise, I think it might be better to backport
>>>>> 039a89c331e9b7998d804 + 79ea67f77ca3afe91222f.
>>>>
>>>> You are the one that objects most violently if we break users'
>>> expectations
>>>
>>> Yes and no.  In regards to end users, I am very careful.  In regards to
>>> package maintainers, I am less weary as they won't distribute failing
>>> builds to end users.  This change hits package building, not the end
>>> user.
>>
>> Well, this is a somewhat simplistic world view, with "package builders"
>> and "package installers".
>>
>> People are stuck on older enterprise distributions, for whatever reasons,
>> but want a newer openvpn version - so they get the source bundle, and
>> compile.  Which is a perfectly fine deployment model - and we should not
>> break things in 2.4.3 that worked just fine in 2.4.2 for them (unless
>> there is a strong reason, like "we have a vulnerability here that we
>> cannot fix unless we abandon an older API").
>=20
> I strongly support your view, Gert. I really hope we do not see such
> breakage in minor stable releases.

Do you depend on building against OpenSSL 0.9.8?  If so, which
OS/distribution do you use?


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--0G3Tr2ja7urddEet8A9XKuOFt9iEAQRAo--

--ne5veO3pRGb39xn74B4l5TJDI3hGFi8bn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZLtxcAAoJEIbPlEyWcf3yFRgQAMKP8mLsWpxhqOqJMtIFvYb2
SQAqpYIspHqbEfvbnZIJ3/ZK6/Vbboln1zta1/qfBJ1Nb8qw2piTGSmyJXrlpoY7
KRcBMq9hvRk034OU2UZ4nvFnNbSvfbJZlCfDeYwd8YI03v/ZZfS5eJqeJY5y6PlZ
BQdEpQs5MagZ50axra8xSaPIyMgUX4JCog2zE52/KlvqSYmzur25B624tADExiUX
EbL+RusVUK8iFQUTiqJxLrj2jE69UDQfU8AhwMkjwXSWG7SQ/sZAeMs0AGaQlpI+
e82x8owftsyCX48qWFv7s42G6YgFxUyCi2pdTieXjwqhPug9jFrdnlJvlPvoP+XM
xwJPIj+WJ2zyqGm8DWe0xOJ8bHSO9BzILLwtDeVfpKSosIMOQ6F94R/2e25vPH4/
pS3HLOIeYmpkj+RMZItdW24ofOR8E1W2O3Lnmvey58bY/zQXg94f+IVeFUObEjcd
QDzxG6v8fiKFmA4D+eCau6z+oD/auJJbFIVq4BAU/ux3jihxuR2U1naNua8MQ8Ef
ouxNYjzrK6OAXdmPWD2oD0FkcyXUP9I4zr4CRGNEuoS3u7EV3SGlg9Wd7yDDaJyI
4O9xRRjIPEuV8HWllnj0yzDoy08uwuIFZrgndjjIyBwjUmOOjWGPT/jXx/UxSzSu
bypUjYckWg+xAkqG9IYh
=EOJE
-----END PGP SIGNATURE-----

--ne5veO3pRGb39xn74B4l5TJDI3hGFi8bn--

