From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <c113c9a5-198e-775b-c183-f319c35bdb28@...515...>
Date: Mon, 16 Apr 2018 10:20:28 +0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KVyscUKdMwCQ1IZZeAm9unbquHz4hCOXR"
Subject: [Openvpn-devel] New tap-windows6 driver (9.21.3) available for
 testing
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
--KVyscUKdMwCQ1IZZeAm9unbquHz4hCOXR
Content-Type: multipart/mixed; boundary="WpJ1J7eFT58BjzwNAnrR7AxICmWVOrZfG";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <c113c9a5-198e-775b-c183-f319c35bdb28@...515...>
Subject: New tap-windows6 driver (9.21.3) available for testing

--WpJ1J7eFT58BjzwNAnrR7AxICmWVOrZfG
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

We're bundling a tap-windows6 driver (9.21.3) with OpenVPN 2.4.6 that is
due later this week:

https://build.openvpn.net/downloads/temp/tap-windows-9.21.3-I601.exe

The main difference to the old driver (9.21.2) is that the driver and
installer have only a SHA2 Authenticode signature[*]. This means that
Windows Vista should refuse to install the driver. Some outdated Windows
7 installations might behave the same. This is intentional on our part,
as Vista is EOL and we don't want to support Windows 7 installations
that are horribly outdated.

I've tested installing this driver on Windows 7 Pro (64-bit) and Windows
2012r2 (64-bit) and I did not encounter any installation issues.
However, I do not have access to Windows 8 or Windows 10, nor to 32-bit
platforms.

I would appreciate somebody could do additional driver installation
tests. This would help build confidence in the driver before we push it
out. Verifying that the driver installs fine is enough.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[*] The earlier driver has SHA1 as the primary signature and SHA2 as
secondary signature.


--WpJ1J7eFT58BjzwNAnrR7AxICmWVOrZfG--

--KVyscUKdMwCQ1IZZeAm9unbquHz4hCOXR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlrUTr0ACgkQKVhNn0CG
RXj9sAf/YJabehQtBMJNJbNFf9NWb9VNtBrIwppEGJ80yT7ay57LZGPEAov0qLR4
oZOuCGG/zXDvR34/g+mCkgGvT2S7DzPHHEB1Y2/ZbHOPDmuHC0dwZiDi1vgOa5eV
r6hbSVe9F9XMosvfx19kCzLHSYzDbtoO1Rg48mXq2XeZnFQhUHMLwlm0j7I5zFou
yJ82BcYVOLKWYcJ8A+RJSzKeVDtvtnM2LHMMU01Nht7UReRb7+tXd/9WqBAMSAD7
YBMVBUc0ZHPUc58Prigz//CBInwjHW/6NporyDvG5SPjsYFjXPH/pImFCIh0gvk1
0Sv5w5VRG8yPpoJXVjp/5t9xyJCwgg==
=YuRm
-----END PGP SIGNATURE-----

--KVyscUKdMwCQ1IZZeAm9unbquHz4hCOXR--

