From: Antonio Quartulli <a@...2181...>
Message-Id: <497C1C9D-DBB7-415E-8FEB-B68FAC3D2D35@...2181...>
Content-Type: multipart/signed;
	boundary="Apple-Mail=_494F11A7-6062-48D5-8771-62A1A4D1F25C";
	protocol="application/pgp-signature"; micalg=pgp-sha512
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Date: Sun, 7 May 2017 20:17:04 +0800
In-Reply-To: <f7f3b9b7-f3ca-fb16-3972-aa6ea7c7991c@...1856...>
References: <20170426160021.25122-1-davids@...515...>
	<29e6daf6-6423-5fb7-ff55-7710b528ddab@...1856...>
	<1349e743-76a0-b021-0e26-94bb7694e820@...2080...>
	<5E3AAEBC-4B0F-409B-9ADE-2DFFED3CF29E@...2181...>
	<338076EC-09A1-4CDA-9D12-A905FD846831@...2181...>
	<f7f3b9b7-f3ca-fb16-3972-aa6ea7c7991c@...1856...>
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
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--Apple-Mail=_494F11A7-6062-48D5-8771-62A1A4D1F25C
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


> On 7 May 2017, at 20:15, Steffan Karger <steffan@...1856...> wrote:
>=20
> Hi,
>=20
> On 07-05-17 14:03, Antonio Quartulli wrote:
>>=20
>>> On 7 May 2017, at 19:56, Antonio Quartulli <a@...2181...> wrote:
>>>=20
>>>> On 4 May 2017, at 06:57, David Sommerseth <openvpn@...2080...> wrote:
>>>>=20
>>>> On 03/05/17 22:15, Steffan Karger wrote:
>>>>>> +        switch (opt->verify_hash_algo)
>>>>>> +        {
>>>>>> +        case MD_SHA1:
>>>>>> +            ca_hash =3D x509_get_sha1_fingerprint(cert, &gc);
>>>>>> +            break;
>>>>>> +
>>>>>> +        case MD_SHA256:
>>>>>> +            ca_hash =3D x509_get_sha256_fingerprint(cert, &gc);
>>>>>> +            break;
>>>>>> +        }
>>>>> This switch should have a default: case that fails, otherwise we might
>>>>> be reading from uninitialized memory.  And you might want to consider
>>>>> initializing ca_hash to "{ 0 }".  (But you still need to default: cas=
e,
>>>>> otherwise you'll be doing a 0-length memcmp()).
>>>>=20
>>>> *grmbl*  I was sure the enumerated type would make the compiler
>>>> complain, but I must have mixed this with some C++ stuff I read not too
>>>> long ago.  But my stupid test allows assigning an enumerated type to a=
ny
>>>> invalid value as well.
>>>>=20
>>>=20
>>> You are right.
>>> The compiler would have complained if you had left out any value from t=
he enum set.
>>> But the enum set is made of those two values only, hence a default case=
 is not plausible unless you
>>> assign verify_hash_algo with a value out of the enum set (but then you =
should have a compiler warning
>>> on the assignment).
>>>=20
>>=20
>> I forgot: the good point of *not* having a default is that when you will=
 add a new enum value for that
>> particular enum type, the compiler will throw warnings for every switch =
block you have, informing you
>> that now they need to be updated. Having a default will leave you with m=
anually check the various
>> code spots.
>=20
> This only holds when compiling with -Wall, which we do not do by default
> (because our current code would emit quite some warnings).
>=20
> If we would fix our code and compile with -Wall -Werror, I'd agree.  But
> as long as we don't, I prefer a defensive code style where I can exclude
> undefined behaviour just by looking at the code.
>=20

Agreed. This sounds like a call for a cleanup mission :]

Cheers,

--
Antonio Quartulli


--Apple-Mail=_494F11A7-6062-48D5-8771-62A1A4D1F25C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJZDxBFAAoJENPhyAjNbKBQpF8P/3vgKMXq1Sb1Jbxu6VcG/mf5
Mt7CnSHNextfyQtfLZ5ThRDdqlkrIIEqTyMRPY3oTG+yW4Wv475lPB8jsPqmhYYu
7zcbNHxz89YVtAUDKEkKRTfgx/xAqJ60NfMEN/4H1nfc+x5XrTIgAidc5CA0OmjQ
0CZvpIX/D2/YzyV+voXU0RicC7NtqkXhU/KAEPUy2tKtSMJCR4vIiOQV1GUgFwO7
XCa7ZbqZkc14ZajA3nrRpDko16wZS3t7dzCshaj5ytewa0GGz18Gr+Usx1NA0/V7
eV6qAWjAfIFE2hmsIlhbYE0ndvsggOTivDQWOgv/51wRLSJQ1RdO9XKKbx+fWm1v
iGuGNvfOCzZlaSoGILJeFxla9WdMtA5zKK91ZXhIYLpRRBsH5qYg9LtM5SahIh4Z
W74BAtmw8Woz8dEXYD2QRm0qNfaNhADO93VDNMGm9ly8Trgo3JZlN5iYpfJDED7h
DIHUdALPzqlrHN9HVRG674O4ns981gALWITPcQm7QaD3srPHeGDuvz8fnQu7fNn5
4N9/pEy3Pp1ZNRoUh35DaFoABYyI5ygqzVVagaFZWbGAuPZhSkLTxH/Zro1VWpup
CTJRQOf4MsdrmXrSfHwd2eGr1ODiMlzqJRCIkmxv3fLQknya7Pj1meCN6/Ov5q0i
YJZsLygr4giszPw6J3XW
=onMq
-----END PGP SIGNATURE-----

--Apple-Mail=_494F11A7-6062-48D5-8771-62A1A4D1F25C--

