References: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
 <20180611075242.GF57262@...1296...>
 <bb55cab5-2523-b899-0ead-6f34886c4d2b@...515...>
 <DM5PR2101MB1112279487CBA7B6DE9A3ABDB0710@...2412...>
 <20180618205610.GI57262@...1296...>
 <20180618205916.GJ57262@...1296...>
 <DM5PR2101MB11120F3A5F61835EE906C481B0710@...2412...>
 <f7cffd19-6db7-a622-3268-fbb198531387@...515...>
 <DM5PR2101MB1112A510BA8E7FCE6FA1166FB0760@...2412...>
 <20180626191511.GI57262@...1296...>
 <DM5PR2101MB1112FF96189404007097878FB0490@...2412...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <a412d044-3a0a-a312-8bc8-0e6114f1e56f@...515...>
Date: Wed, 27 Jun 2018 13:11:40 +0300
MIME-Version: 1.0
In-Reply-To: <DM5PR2101MB1112FF96189404007097878FB0490@...2412...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NPqITcb8lOw0LLx75ExSYI33vIGy3rVBq"
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
--NPqITcb8lOw0LLx75ExSYI33vIGy3rVBq
Content-Type: multipart/mixed; boundary="twrFYbq2Ykddv9RTAoSJcp6GJsOsiAvxa";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: Jon Kunkee <jkunkee@...2393...>, Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <a412d044-3a0a-a312-8bc8-0e6114f1e56f@...515...>
Subject: Re: [Openvpn-devel] Regarding tap-windows6 driver signatures and
 driver distribution
References: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
 <20180611075242.GF57262@...1296...>
 <bb55cab5-2523-b899-0ead-6f34886c4d2b@...515...>
 <DM5PR2101MB1112279487CBA7B6DE9A3ABDB0710@...2412...>
 <20180618205610.GI57262@...1296...>
 <20180618205916.GJ57262@...1296...>
 <DM5PR2101MB11120F3A5F61835EE906C481B0710@...2412...>
 <f7cffd19-6db7-a622-3268-fbb198531387@...515...>
 <DM5PR2101MB1112A510BA8E7FCE6FA1166FB0760@...2412...>
 <20180626191511.GI57262@...1296...>
 <DM5PR2101MB1112FF96189404007097878FB0490@...2412...>
In-Reply-To: <DM5PR2101MB1112FF96189404007097878FB0490@...2412...>

--twrFYbq2Ykddv9RTAoSJcp6GJsOsiAvxa
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Jon,

Il 27/06/2018 00:11, Jon Kunkee ha scritto:
>=20=20
> Hi,
>=20
>> as a quick note - sorry, we won't make "June 27" as release date for=20
>> the new tap driver.
>=20
>> We tentatively plan for "one more week" now, which would be July 4th.=20
>=20
> No worries. Thanks for the update!
>=20
>>                  The Windows HLK tests for Server 2016 are somewhat=20
>> "demanding" from what I hear from Samuli (you need to have a larger=20
>> setup than "just the machine with the driver", it actually wants to=20
>> talk through the driver to "things" - which need to be provisioned,=20
>> etc.).=20
>=20
>> Jon, do you have experience with the HLK test suite and could help=20
>> explain some of the test failures ("what does the system expect to=20
>> find here?") - what's remaining does not seem to be "driver" related=20
>> but "things the tests expect to see in the network behind that driver"..=
.=20
>> gert=20
>=20
> I have experience running the PCI portion of the HLK from Windows 8, so
> that gives me the basic idea. Those tests required two machines: the
> one with the device and the driver and the one with the HLK server.
>=20
> Network device testing is more complex because the test needs to control
> both the OS' end of the traffic and the external traffic. I found this:
>=20
> https://docs.microsoft.com/en-us/windows-hardware/test/hlk/testref/lan-te=
sting-prerequisites
> (apologies if Exchange or Outlook mangles that link... ):
>=20
> It appears that you need three devices: the HLK server, the device with
> the 'hardware' and the driver for testing ('Test Machine' with a 'message
> device'), and the external traffic source/sink ('Support Machine'). All
> three probably need a backchannel link to the HLK server, while the Test
> Machine and Support Machine do best with a dedicated link through the
> device whose driver is being tested.

Our test environment currently has the following nodes:

- One combined HLK Studio/controller
- Four identical HLK client nodes
- OpenVPN test server

The HLK nodes are all Windows Server 2016 as that is our primary target.
The OpenVPN test server provides the HLK clients with an IPv6 address
and IPv6 gateway - this is required for almost all "Run" tests. All of
the nodes are in Amazon EC2. With the above setup 54 tests pass and 9 fail.

The "Support machine" you mentioned is still missing. I will try to set
it up today and check how many of the currently failing tests start passing.

Note that right now I'm running the tests against tap-windows-9.22.1 to
give us a baseline. That way we can check if our recent updates have
broken (or possibly fixed) something. With 4 HLK clients the runtime of
the whole test suite is almost reasonable. With one node it took 10+ hours.

>=20
> There should be a predefined set of individual tests that are required
> by the signature service, probably NDISTest 6.5.
>=20
> I'd be happy to review failure logs to help figure out what's going wrong.
>=20

I can definitely grant you access to the HLK controller so that you can
check what is happening. If you're working today around 16:00-18:00 UTC
please poke me at #openvpn-devel and we'll get you started.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--twrFYbq2Ykddv9RTAoSJcp6GJsOsiAvxa--

--NPqITcb8lOw0LLx75ExSYI33vIGy3rVBq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlszYtwACgkQKVhNn0CG
RXhLrAf9Hri0UJiOHaIOpZcRLmncw5o+awO70+MJbrB24WHe74toBi+5yt2gI9Lv
72HwR9JtdLXg6audscS7WGr94MF0WtvQtWqUFU5HAtu7/dQfrzhbBKB0+ZD+O6LU
zRMpSfubC7SuMv3WlHNPgbVr5GfiNzHjUKt3HfYJOIQj9yk6lGv2JTAPDCxuxMK/
aR1MjLCuB/sdIdjxjqCOZgprFlBRHiLxRziVILDPnngrMY6gQaFNUFxiuCX9oPAr
KQnBXGO7ok4SOzXqj57fr7iohJsr8QYxlG06i3l4oEcuvQm1EVWQdWryuJBZ0BrK
RTDeM8wKlJXi+SBPBQlmbPQV1qhF+Q==
=DdQP
-----END PGP SIGNATURE-----

--NPqITcb8lOw0LLx75ExSYI33vIGy3rVBq--

