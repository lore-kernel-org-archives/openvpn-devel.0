References: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
 <20180611075242.GF57262@...1296...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <bb55cab5-2523-b899-0ead-6f34886c4d2b@...515...>
Date: Mon, 11 Jun 2018 11:29:24 +0300
MIME-Version: 1.0
In-Reply-To: <20180611075242.GF57262@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="n8SikX9ZaNOeXys4CCrnuQlJXT78XsYqe"
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n8SikX9ZaNOeXys4CCrnuQlJXT78XsYqe
Content-Type: multipart/mixed; boundary="jES6qD0WXlEU6Dq52yUx7evjjxmAfMbSH";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <bb55cab5-2523-b899-0ead-6f34886c4d2b@...515...>
Subject: Re: [Openvpn-devel] Regarding tap-windows6 driver signatures and
 driver distribution
References: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
 <20180611075242.GF57262@...1296...>
In-Reply-To: <20180611075242.GF57262@...1296...>

--jES6qD0WXlEU6Dq52yUx7evjjxmAfMbSH
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

Il 11/06/2018 10:52, Gert Doering ha scritto:
> Hi,
>=20
> On Mon, Jun 11, 2018 at 10:30:05AM +0300, Samuli Sepp=E4nen wrote:
>> Last Friday I managed to get tap-windows-9.22.1[1] attestation
>> signed[2]. This means that that particular driver (64-bit variant)
>> should work on any Windows 10. However, according to [2]
>=20
> This is very good news :-)
>=20
> Have you been able to make this into a tap6 installer that we could
> throw at people that had issues getting the previous attempt to work
> on win10?

Not yet. But I don't have any reason believe it won't work, because the
only signature in there is directly from Microsoft. I also asked about
the relation of "requested signatures" checklist in the dashboard and
signatures. Regardless of which Windows 10 variants we check the boxes
for the signature should be valid across all of them.

So by checking the boxes is just a statement along the lines "we have
tested the driver on Windows flavors <x>".

I just asked what we need to do to make the driver work on Windows
Server 2016. I _hope_ that platform does not require us to pass the HLK
tests. If it does, then we have no option but to go through the process
_now_. HCK and WLK can wait a while, as the older operating systems will
be fine with a cross-signed driver. But then we'd end up with two
installers (HLK and cross-signed).

>=20
> [..]
>> I actually lean towards 2), as that is the only way[3] to provide a
>> driver that works across all Windows versions that are under "mainstream
>> support". That would leave out Windows Server 2008 R2 which is under
>> "extended support" that ends in early 2020:
>>
>> https://support.microsoft.com/en-us/lifecycle/search?alpha=3Dwindows%20s=
erver%202008
>>
>> So, if we want to keep on supporting Windows Server 2008 R2 while having
>> just one tap-windows6 driver we (=3DI) would have to go through three
>> different test suites / certifications:
>>
>> - HLK (Windows 10)
>> - HCK (Windows 7/8)
>> - WLK (Windows 2008 R2)
>=20
> I have no idea how many people are doing Server 2008 R2 with OpenVPN,
> but I'm afraid there will be "more than zero".
>=20
> Wild idea: do we want to add a checkbox to the installer "submit=20
> version information to OpenVPN Headquarters" (opt-in, of course) so
> we can have a rough idea what people are actively using?

I would not be opposed to this. We'd have to include the matching code
in openvpn.nsi as well, as it runs tap-windows6.nsi non-interactively.

>> Our projected deadline for the next tap-windows6 release is June 20th. I
>> will start working on HLK/HCK, but I don't know how many obstacles I
>> will encounter.
>>
>> However, as we can now attestation-sign drivers, even in the worst case
>> we could initially release two installers (option 1 above). Then, when
>> HLK/HCK/WLK are in order, we can switch back to using a single installer
>> again.
>=20
> This sounds like a good backup plan to get fixed drivers *out* for all=20
> supported platforms, and give us (=3Dyou :) ) time to wrestle with=20
> HLK/HCK/WLK...
>=20

It looks like this will be a wrestle. MS docs seem relatively good, but
many tiny but important details seem to be undocumented. Like "can I run
HLK tests on Amazon EC2/Azure VMs?"


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--jES6qD0WXlEU6Dq52yUx7evjjxmAfMbSH--

--n8SikX9ZaNOeXys4CCrnuQlJXT78XsYqe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlseMuQACgkQKVhNn0CG
RXgZeAf/TZbrIxdZb45CZLeacWPaq9JmGtgeKDwZKJONGazK8EMv/wqA6NnIg5a5
V6FRlMfn7oapcOkuMPA5Z/y3GT5cm3i1Oz+rPGiJ65UfoyK0RxDIEZqPigPs7LnA
+RPtcioQtWBB+f4LNfhOJ+8/LtRsxZ8j9w1Ev5Qk4onh58LA4YP3OaI8FfVQSuDI
ot/7W8y2vK6To9G4Gqp8Z9aieX5543XVEexuZy+utMAdUmsOgLkuuAqL/URADsNh
o82waZNJtQtum2xiwxtEa6F17l01omOb1fq35uckLQo59ObZqRJnIpjU7uHLz2N5
yWq5uDYYIj4c4Mxvsxm6YH9Yl/DC9A==
=i6D1
-----END PGP SIGNATURE-----

--n8SikX9ZaNOeXys4CCrnuQlJXT78XsYqe--

