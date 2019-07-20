References: <f57a2e41-3243-b6ee-aebc-3be050e4e660@...1856...>
 <1548101094-4449-1-git-send-email-lstipakov@...277...>
 <ac02a60e-d3a5-8833-9adb-ca02f2d0c711@...1227...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <49cc6159-a636-5a82-ca68-428300eb8a90@...1856...>
Date: Sat, 20 Jul 2019 12:25:27 +0200
MIME-Version: 1.0
In-Reply-To: <ac02a60e-d3a5-8833-9adb-ca02f2d0c711@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="97M7dRuiIosJbhB1DQutnl0kQ5Sgb66wS"
Subject: Re: [Openvpn-devel] [PATCH v2] Fix broken fragment/mssfix with NCP
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
--97M7dRuiIosJbhB1DQutnl0kQ5Sgb66wS
Content-Type: multipart/mixed; boundary="1o3L59Dc5gg6M7WFWetbWiDvmniUFnJEB";
 protected-headers="v1"
From: Steffan Karger <steffan@...1856...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <49cc6159-a636-5a82-ca68-428300eb8a90@...1856...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix broken fragment/mssfix with NCP
References: <f57a2e41-3243-b6ee-aebc-3be050e4e660@...1856...>
 <1548101094-4449-1-git-send-email-lstipakov@...277...>
 <ac02a60e-d3a5-8833-9adb-ca02f2d0c711@...1227...>
In-Reply-To: <ac02a60e-d3a5-8833-9adb-ca02f2d0c711@...1227...>

--1o3L59Dc5gg6M7WFWetbWiDvmniUFnJEB
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


On 08-05-19 16:19, Arne Schwabe wrote:
> Am 21.01.19 um 21:04 schrieb Lev Stipakov:
>> From: Lev Stipakov <lev@...515...>
>>
>> NCP negotiation replaces worst cast crypto overhead
>> with actual one in data channel frame. That frame
>> params are used by mssfix.
>>
>> Fragment frame still contains worst case overhead.
>> Because of that TCP packets are fragmented, since
>> MSS value exceeds max fragment size.
>>
>> Fix by replacing worst case crypto overhead with
>> actual one for fragment frame, as it is done for data
>> channel frame.
>=20
> The change looks good and is tested.
>=20
> Acked-By: Arne Schwabe <arne@...515...>

Since Arne agrees, I'm completely convinced now too:

Acked-by: Steffan Karger <steffan@...1856...>


--1o3L59Dc5gg6M7WFWetbWiDvmniUFnJEB--

--97M7dRuiIosJbhB1DQutnl0kQ5Sgb66wS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEED9EpzGW9WeE8Ifd8mALKPQB+0ogFAl0y7B4ACgkQmALKPQB+
0oiLxwf/VYH/7Rh0pkXR0KgRktjXvn0CltJhv9WR3hLrlpv/i6CMWc6Au7RPS38k
g3kQFrEfki3OOYGVvvO1TfFbnThd85AsRbCSvqyiYKel8olXBKfylbyT39VFdy7e
MMeWFD4XEm2J3nV9TJ/DeRPMlxDO5M4K6i4fonUb32taZTuCa3QmGGX6hQA56PaO
fGCuuAL44F2RNGIhjtH19u2z3DLwZoiW5K4P3sjjOdPf0xP+VE5JO5/K+ft9S5oL
6ntdg0Df7DhoNN+mxGKnAhSg4RojNFCZ4YOVetna6ofAbSMftw0rrQTBWrGZ8Ju9
8GsvplABr5LuEbW40EQUW2bHtVnGTw==
=2M/a
-----END PGP SIGNATURE-----

--97M7dRuiIosJbhB1DQutnl0kQ5Sgb66wS--

