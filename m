References: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
 <20180611075242.GF57262@...1296...>
 <bb55cab5-2523-b899-0ead-6f34886c4d2b@...515...>
 <DM5PR2101MB1112279487CBA7B6DE9A3ABDB0710@...2412...>
 <20180618205610.GI57262@...1296...>
 <20180618205916.GJ57262@...1296...>
 <DM5PR2101MB11120F3A5F61835EE906C481B0710@...2412...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <f7cffd19-6db7-a622-3268-fbb198531387@...515...>
Date: Tue, 19 Jun 2018 10:57:27 +0300
MIME-Version: 1.0
In-Reply-To: <DM5PR2101MB11120F3A5F61835EE906C481B0710@...2412...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5OE4yZzDu48hJS5P9T3zRxtVIalGRmCet"
Subject: Re: [Openvpn-devel] Regarding tap-windows6 driver signatures and
 driver distribution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jon Kunkee <jkunkee@...2393...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5OE4yZzDu48hJS5P9T3zRxtVIalGRmCet
Content-Type: multipart/mixed; boundary="mTelp53kGHlioFZHJ8ptdaVMiqexdbAdy";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: Jon Kunkee <jkunkee@...2393...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <f7cffd19-6db7-a622-3268-fbb198531387@...515...>
Subject: Re: [Openvpn-devel] Regarding tap-windows6 driver signatures and
 driver distribution
References: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
 <20180611075242.GF57262@...1296...>
 <bb55cab5-2523-b899-0ead-6f34886c4d2b@...515...>
 <DM5PR2101MB1112279487CBA7B6DE9A3ABDB0710@...2412...>
 <20180618205610.GI57262@...1296...>
 <20180618205916.GJ57262@...1296...>
 <DM5PR2101MB11120F3A5F61835EE906C481B0710@...2412...>
In-Reply-To: <DM5PR2101MB11120F3A5F61835EE906C481B0710@...2412...>

--mTelp53kGHlioFZHJ8ptdaVMiqexdbAdy
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Il 19/06/2018 00:56, Jon Kunkee ha scritto:
>  Hi Gert,
>=20
>>>> Our projected deadline for the next tap-windows6 release is June=20
>>>> 20th.=20
>>>
>>> Is this still the target?=20
>>
>> No, we moved it to (tentatively) June 27th.  There was some sort of=20
>> major outage of Samuli's Infrastructure which took too much time to=20
>> fix.=20
>=20
> Ouch for Samuli.

Indeed, that delayed my other work for about one week. There is still
some cleanup work to do, but that can be delayed a bit if necessary.

So, I will rebuild our Windows build/test VMs this week. I hope to get
to that today actually. The test environment will include a HLK
Studio/Controller with one Windows Server 2016 client. That allows me to
build and sign anything I want, so releasing on 27th seems very
realistic right now.

> My motivation is simple: The Microsoft partner that asked for this port
> wants to know ASAP when it's released so they can tell people about it.
> That said, as long as I get the final release date to them promptly
> they can deal with whatever ends up happening.
>=20
> Thanks for the update!
>=20
>> The goal is to have the 3 ARM64 related PRs plus the version number PR=20
>> merged after a bit of smoketesting on other platforms
>=20
> Wonderful.
>=20
> Samuli, let me know if you think I can help.

Testing the signatures and the driver on ARM64 would be good. We don't
have any ARM64 Windows hardware at our disposal.

We don't have any tap-windows6 -specific tests at the moment, so I
generally just run the OpenVPN test suite against a bunch of OpenVPN 2.x
/ Access Server / Private Tunnel servers:

<https://github.com/OpenVPN/openvpn-windows-test.git>

The test suite does just basic ping testing, so it is just a smoketest.
But in the past we've exposed some tap-windows6 problems using such tests.

Given that tap-windows6 driver has seen lots of modifications having
more focused tests would be good. Any ideas what we should test and how?

>=20
>> Most likely this release will be "get things out with compromises" -=20
>=20
> This makes sense, no worries. It's already a fairly complex release.
>=20
>> Then, focus on make nicer installers - .msi for the tap driver, .msi=20
>> for openvpn proper, return to *one* driver that has proper signatures=20
>> for everything.=20
>=20
> I'll take a closer look at WIX support for ARM64. This timeline is easier=
 to
> work with.
>=20
> Cheers,
> Jon
>=20


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--mTelp53kGHlioFZHJ8ptdaVMiqexdbAdy--

--5OE4yZzDu48hJS5P9T3zRxtVIalGRmCet
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlsot2cACgkQKVhNn0CG
RXgrWgf/dhuqN2ESaF4uPHgDnB7bMhhxohC7exnsXQFwikcAVL2C2F9r2A+O0d98
CPNXobdQK3etBl6erEXeTe6T3MpsIeDXu8/leYDC+We/K8jmtVPcN1NB2XijKxjf
48B+pqjGqnqaMyJQebhyamHjy/XxbDLZvhMF4ILGxMizI9rH9yuuO+EwMgfZw9qf
ADwHWcFps3d9dCEHEptTGbYKsr6sYr1CCzi0f1MgXsAvHFLanoweM1HA4QYCjo9T
gHdH5j86mauzDnIHRpIhiP41btbCg8GoE5ExiZB1/A5wSUQHUWVoazOjUq/VTZyB
RFpxpZ5SCV1iimzOsLe7ZUsaTPMZDg==
=fMze
-----END PGP SIGNATURE-----

--5OE4yZzDu48hJS5P9T3zRxtVIalGRmCet--

