References: <61a238ea-3a52-da19-9a21-a127540e2b5e@...515...>
	<CAFHpkQG3GOm-GKj24pccyn84pZaA=KsvMgfqYLVjs9DxEo6Y5w@...278...>
	<0a77ede7-0374-ed7a-a10e-20d0ac9e31b9@...2080...>
	<95c70c5e-22ac-81ab-0fca-b9195f426f7a@...1856...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <a0821983-407a-dd9f-dbac-47f94a18c4dd@...515...>
Date: Mon, 3 Apr 2017 16:53:09 +0300
MIME-Version: 1.0
In-Reply-To: <95c70c5e-22ac-81ab-0fca-b9195f426f7a@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="amdAOMTF74HmPKEwsXuKKrcaax4euMuCt"
Subject: Re: [Openvpn-devel] Upgrading EasyRSA 2's defaults
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
--amdAOMTF74HmPKEwsXuKKrcaax4euMuCt
Content-Type: multipart/mixed; boundary="------------3562D774230E421A43F087D3"

This is a multi-part message in MIME format.
--------------3562D774230E421A43F087D3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 02/04/2017 10:57, Steffan Karger wrote:
> Hi,
>=20
> On 31-03-17 22:34, David Sommerseth wrote:
>> On 31/03/17 10:56, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
>>> 2017-03-31 13:26 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
>>> <mailto:samuli@...515...>>:
>>>
>>>     Hi,
>>>
>>>     We still bundle EasyRSA 2 with our Windows installers and it is
>>>     prominently advertised on our widely linked to HOWTO:
>>>
>>>     <https://openvpn.net/index.php/open-source/documentation/howto.html
>>>     <https://openvpn.net/index.php/open-source/documentation/howto.html=
>>
>>>
>>>     As such, EasyRSA 2 is used by many/most OpenVPN server admins.
>>>
>>>     However, the default values for EasyRSA 2 such as MD5 hashing algor=
ithm
>>>     and 1024-bit keysize seem totally inadequate for today's standards:
>>>
>>>     <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.0/v=
ars#L53
>>>     <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.0/v=
ars#L53>>
>>>     <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.0/o=
penssl-1.0.0.cnf#L57
>>>     <https://github.com/OpenVPN/easy-rsa-old/blob/master/easy-rsa/2.0/o=
penssl-1.0.0.cnf#L57>>
>>>
>>>     I think we should upgrade these to something more recent. What would
>>>     more modern reasonable defaults be?
>>>
>>>
>>>
>>> someday we decided to use DSA (instead of default RSA)
>>> it worked ... until we started to use OpenVPN Connect for iOS.
>>> next, we had to change back to RSA
>>>
>>>
>>> the conclusion would be "test all available platforms and take a
>>> decision", probably even set up special test server and ask people on
>>> openvpn-users mailing list
>>
>> Always a good idea to test as many platforms as possible.  But we can
>> also leverage all the testing which have been done indirectly by others
>> as well.
>>
>> The suggestion from Samuli is to update the default key size and hashing
>> algorithm.  MD5 is broken.  MD5 have been broken for years.  SHA1 have
>> the recent SHAttering panic, which have its own set of challenges - and
>> should not be used for certificates any longer (if I have understood the
>> crypto-gurus correctly).
>>
>> Also considering that the "world in general" have been moving towards
>> stronger keys *and* have moved towards SHA256 hashing in certificates,
>> updating EasyRSA is more than reasonable.
>>
>> So, I would highly recommend using SHA256.  I have used that for my
>> OpenVPN setups for several years already.  That works fine for me, and I
>> know others have done the same.  This is actually the most challenging
>> move, from a technical point of view - using a new algorithm.  But this
>> algorithm is well supported by all OpenSSL and mbed TLS implementations
>> OpenVPN can be built against.
>>
>> Secondly, updating the key length from 1024 bits to at least 2048 should
>> not cause any issues at all.  Many users (myself included) often use
>> 4096 bits keys without any issues.
>>
>> Swapping RSA for DSA is an issue of a completely different league. And
>> DSA is by OpenSSH considered too weak; IIRC it was even removed in
>> OpenSSH v7.0.
>=20
> Yes, upgrading would be good if we still ship it.  I can echo David's
> SHA256 / RSA2048+ recommendation.  Enough security margin, and very good
> interop (not only crypto libs, but also smart cards, OS key stores,
> ...).  To not dramatically slow down connection setup on low-cpu-power
> devices (e.g. home routers), don't go beyond RSA4096 though.
>=20
> DSA is _not_ a preferred choice.  The original 1024-bit DSA is too weak
> nowadays, and the 'larger' DSA variants are not even close to the wide
> support that RSA has.
>=20
> -Steffan
>=20

Hi,

I've issue a pull request here and review would be appreciated:

<https://github.com/OpenVPN/easy-rsa-old/pull/1>

I tested these changes on Debian 8 which has OpenSSL-1.0.1. Key size was
set to 4096-bits and signature algorithm to SHA256WithRSAEncryption.

The only real issue was DH parameter generation: it took ~25 minutes on
my Intel i5 laptop. Is that acceptable default behavior?

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------3562D774230E421A43F087D3
Content-Type: application/pgp-keys;
 name="0x40864578.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x40864578.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
XuwT7RpGDZ6jBfphYQ=3D=3D
=3DFKLE
-----END PGP PUBLIC KEY BLOCK-----

--------------3562D774230E421A43F087D3--

--amdAOMTF74HmPKEwsXuKKrcaax4euMuCt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJY4lPGAAoJEClYTZ9AhkV4HS0IAL4hxRy7whkUMbAP23NTfeAB
AzopZ8Ja9pfT9S2NbqLDTIL3LFx7rDECL3v3xOGHXW9Gl9cfhPba0uM0+K5MLz5g
UYjBVxK9CNt1CR+vrQvYgOo5SLW7MkX0GEzCdeecD9zdwk4NHE2bc3oAiDYv92fR
SECiSsZh0Yg7NXY/CjxAF+j4L4bvA8/MmRQdVGp5mkSCoN8/CoHZ07pHMc5EaYSc
sF006xBNzsIqlbKZD/CeV0jEQUcvwvFM+W9X7SJhYWzq0glrW0f0Zvcw9DCjGqY2
NQhwQxQMIpRsrhTBN2vwagehVBJqftEPvvJ4Ksk9O1ckQuENYSFNnI4erorV9rU=
=HPG1
-----END PGP SIGNATURE-----

--amdAOMTF74HmPKEwsXuKKrcaax4euMuCt--

