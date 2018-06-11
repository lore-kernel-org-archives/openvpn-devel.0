From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
Date: Mon, 11 Jun 2018 10:30:05 +0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="IWB5Vau0a0IgyvvfgquN8CScwE7LXjPGE"
Subject: [Openvpn-devel] Regarding tap-windows6 driver signatures and driver
 distribution
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IWB5Vau0a0IgyvvfgquN8CScwE7LXjPGE
Content-Type: multipart/mixed; boundary="kqrR2gSuDlThz5UEIbtB6bh3raGfFeEAb";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <42bafab6-9e6f-56b5-2c44-b449ec503ce7@...515...>
Subject: Regarding tap-windows6 driver signatures and driver distribution

--kqrR2gSuDlThz5UEIbtB6bh3raGfFeEAb
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Last Friday I managed to get tap-windows-9.22.1[1] attestation
signed[2]. This means that that particular driver (64-bit variant)
should work on any Windows 10. However, according to [2]

"An attestation signed driver will only work for Windows 10. It will not
work for other versions of Windows, such as Windows Server 2016,Windows
8.1, or Windows 7."

According to [3] it is possible to cross-sign the driver[4] before
submitting it to Microsoft for attestation signing. This will enable the
driver to work on _almost_ everything. For obscure reasons this
dual-signed driver will _not_ work on Windows Server 2016[3].

So we're left with two options:

1) Generate two different tap-windows6 installers (Windows 10 / others)
2) Go through the test suites in HLK (Windows 10) and HCK (Windows 7/8)
   and submit the test data as part of the driver submission to
   Microsoft

I actually lean towards 2), as that is the only way[3] to provide a
driver that works across all Windows versions that are under "mainstream
support". That would leave out Windows Server 2008 R2 which is under
"extended support" that ends in early 2020:

https://support.microsoft.com/en-us/lifecycle/search?alpha=3Dwindows%20serv=
er%202008

So, if we want to keep on supporting Windows Server 2008 R2 while having
just one tap-windows6 driver we (=3DI) would have to go through three
different test suites / certifications:

- HLK (Windows 10)
- HCK (Windows 7/8)
- WLK (Windows 2008 R2)

Our projected deadline for the next tap-windows6 release is June 20th. I
will start working on HLK/HCK, but I don't know how many obstacles I
will encounter.

However, as we can now attestation-sign drivers, even in the worst case
we could initially release two installers (option 1 above). Then, when
HLK/HCK/WLK are in order, we can switch back to using a single installer
again.


--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

[1] Includes Jon Junkee's tap-windows6 build system refactoring patches
[2]
<https://docs.microsoft.com/en-us/windows-hardware/drivers/dashboard/attest=
ation-signing-a-kernel-driver-for-public-release>
[3]
<https://docs.microsoft.com/en-us/windows-hardware/drivers/dashboard/get-dr=
ivers-signed-by-microsoft-for-multiple-windows-versions>
[4] Sign it ourselves using our old signing process


--kqrR2gSuDlThz5UEIbtB6bh3raGfFeEAb--

--IWB5Vau0a0IgyvvfgquN8CScwE7LXjPGE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlseJP4ACgkQKVhNn0CG
RXjx7Af/QLcAFrfHPrFLKp7r+8LvNAfkS5s8QwPqCLHF2SppxemqSp6U5JYvh49z
AYENUYTkY0P8kRblu/6uNNF1HS/IQQ58SQNhx0nMmD7yenVbiGWlvxGGmI2n4r3J
kX75debMEY4CGYxHif+k0ZqWjOWlfYG+Qczuk9UaNw6aJ4YmYQQRYkI0bruheoQY
khaui6y7X4BNSdINBGIjnPefDlyE11WYz+3tEnvr3ivnvvOJP0km2S9eqcd456Sz
Pl450Wv/Q0G2EdyeCv7iWyd4M9nRX9k03zdpr2Ds7lRov65IVrCbu4kW9Bd6Fz8/
JV2h26y1LzfYnrkUrmNo8I5PfWZfPA==
=KOVy
-----END PGP SIGNATURE-----

--IWB5Vau0a0IgyvvfgquN8CScwE7LXjPGE--

