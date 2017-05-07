References: <20170426160021.25122-1-davids@...515...>
	<29e6daf6-6423-5fb7-ff55-7710b528ddab@...1856...>
	<1349e743-76a0-b021-0e26-94bb7694e820@...2080...>
	<5E3AAEBC-4B0F-409B-9ADE-2DFFED3CF29E@...2181...>
	<338076EC-09A1-4CDA-9D12-A905FD846831@...2181...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <f7f3b9b7-f3ca-fb16-3972-aa6ea7c7991c@...1856...>
Date: Sun, 7 May 2017 14:15:00 +0200
MIME-Version: 1.0
In-Reply-To: <338076EC-09A1-4CDA-9D12-A905FD846831@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ujS2T1LIV3rP1c3feMITlXrJSS6C2Tg5P"
Subject: Re: [Openvpn-devel] [PATCH] crypto: Enable SHA256 fingerprint
 checking in --verify-hash
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net, openvpn@...2080...

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ujS2T1LIV3rP1c3feMITlXrJSS6C2Tg5P
Content-Type: multipart/mixed; boundary="sGN06HQ7clQeGCDGkqolg7a709be3Cx7Q";
	protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net,
	openvpn@...2080...
Message-ID: <f7f3b9b7-f3ca-fb16-3972-aa6ea7c7991c@...1856...>
Subject: Re: [Openvpn-devel] [PATCH] crypto: Enable SHA256 fingerprint
	checking in --verify-hash
References: <20170426160021.25122-1-davids@...515...>
	<29e6daf6-6423-5fb7-ff55-7710b528ddab@...1856...>
	<1349e743-76a0-b021-0e26-94bb7694e820@...2080...>
	<5E3AAEBC-4B0F-409B-9ADE-2DFFED3CF29E@...2181...>
	<338076EC-09A1-4CDA-9D12-A905FD846831@...2181...>
In-Reply-To: <338076EC-09A1-4CDA-9D12-A905FD846831@...2181...>

--sGN06HQ7clQeGCDGkqolg7a709be3Cx7Q
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 07-05-17 14:03, Antonio Quartulli wrote:
>=20
>> On 7 May 2017, at 19:56, Antonio Quartulli <a@...2181...> wrote:
>>
>>> On 4 May 2017, at 06:57, David Sommerseth <openvpn@...2080...> wrote:
>>>
>>> On 03/05/17 22:15, Steffan Karger wrote:
>>>>> +        switch (opt->verify_hash_algo)
>>>>> +        {
>>>>> +        case MD_SHA1:
>>>>> +            ca_hash =3D x509_get_sha1_fingerprint(cert, &gc);
>>>>> +            break;
>>>>> +
>>>>> +        case MD_SHA256:
>>>>> +            ca_hash =3D x509_get_sha256_fingerprint(cert, &gc);
>>>>> +            break;
>>>>> +        }
>>>> This switch should have a default: case that fails, otherwise we might
>>>> be reading from uninitialized memory.  And you might want to consider
>>>> initializing ca_hash to "{ 0 }".  (But you still need to default: case,
>>>> otherwise you'll be doing a 0-length memcmp()).
>>>
>>> *grmbl*  I was sure the enumerated type would make the compiler
>>> complain, but I must have mixed this with some C++ stuff I read not too
>>> long ago.  But my stupid test allows assigning an enumerated type to any
>>> invalid value as well.
>>>
>>
>> You are right.
>> The compiler would have complained if you had left out any value from th=
e enum set.
>> But the enum set is made of those two values only, hence a default case =
is not plausible unless you
>> assign verify_hash_algo with a value out of the enum set (but then you s=
hould have a compiler warning
>> on the assignment).
>>
>=20
> I forgot: the good point of *not* having a default is that when you will =
add a new enum value for that
> particular enum type, the compiler will throw warnings for every switch b=
lock you have, informing you
> that now they need to be updated. Having a default will leave you with ma=
nually check the various
> code spots.

This only holds when compiling with -Wall, which we do not do by default
(because our current code would emit quite some warnings).

If we would fix our code and compile with -Wall -Werror, I'd agree.  But
as long as we don't, I prefer a defensive code style where I can exclude
undefined behaviour just by looking at the code.

-Steffan


--sGN06HQ7clQeGCDGkqolg7a709be3Cx7Q--

--ujS2T1LIV3rP1c3feMITlXrJSS6C2Tg5P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZDw/EAAoJEJgCyj0AftKIO1gH/2D0/pRKND6lULmS9w6bFX0m
j/7Gji7aGo+x/p9oo4pZSjSGjhwmgsINMo00NyJgeUU2WCk9gRGJcPo35MCoqvlK
EBtcLLFR67WXQM932XTutlwQ2TO4TIRjplh7pPXp5PgaCk5yNcRhdE36Ovtd/B4v
WXH6ac97OFT9OnhG/XxngM2zbXPFSyvv1Pkc2mWHkWNW1w42lDBcliVXrQkbkDE+
HH4pDM3PNDeFMVxr0OM0UBaawiUe61jalJRn8BgUqfWeQ+GePr2vO7kXGPWzbV6l
EL3Dh3jVyOYKXPG9AnLrHUZtKlYeQxJ4+qXGIjkidLCzulMXg8O22DNmC4w8zEc=
=Hxb2
-----END PGP SIGNATURE-----

--ujS2T1LIV3rP1c3feMITlXrJSS6C2Tg5P--

