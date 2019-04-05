From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <e18eefae-c2e8-61e2-4f4d-8d978d74b4c3@...515...>
Date: Fri, 5 Apr 2019 17:00:59 +0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BzKTWX5hFONCi2fmvioUdrawSOPXRKQVI"
Subject: [Openvpn-devel] New tap-windows6 driver for Windows 7/8/8.1/Server
 2012r2 ready for testing
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
--BzKTWX5hFONCi2fmvioUdrawSOPXRKQVI
Content-Type: multipart/mixed; boundary="VjuQqpxERESZRsn43Nqe5G5fg8tvko5P7";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <e18eefae-c2e8-61e2-4f4d-8d978d74b4c3@...515...>
Subject: New tap-windows6 driver for Windows 7/8/8.1/Server 2012r2 ready for
 testing

--VjuQqpxERESZRsn43Nqe5G5fg8tvko5P7
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

A new pre-release tap-windows6 driver (9.23.1) is available for testing.
It should work on Windows 7/8/8.1/Server 2012r2. It _will not_ work  on
Windows 10 or Windows Server 2016/2019.

The driver includes several new features such as support for NDIS 6.30
arm64 support, improvements in driver version display, etc.

Download the installer from here:

https://build.openvpn.net/downloads/snapshots/tap-windows-9.23.1-I601.exe

For those who want the raw, signed driver files please download the zip
file:

https://build.openvpn.net/downloads/snapshots/tap-windows-9.23.1.zip

I install-tested driver on Windows Server 2012r2 and there were no
obvious problems.

It would be great if other people could smoke-test the new driver - just
install it on top of existing OpenVPN installation. In particular
running OpenVPN with the driver would be useful.

I ran into some issues with attestation signing for Windows 10, but I
will probably have a Windows 10 version available tomorrow.

Best regards,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--VjuQqpxERESZRsn43Nqe5G5fg8tvko5P7--

--BzKTWX5hFONCi2fmvioUdrawSOPXRKQVI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlynX5sACgkQKVhNn0CG
RXgxMwf+NPpnbZv5Etj85xH5oQSf2gBn4IjqJoHFLyz3QxTLd4zZq09ci8I35oEL
Aw2h4OOGAWFRtC80ZQOsx6tHtAFTD2YDL9E3z0XahlbzgvD1Nm0EOFWovvEEienm
qW4gBKvEvPUzxJaerWALSOaks/2yP0d1wHiSqNBkT7fz63CAbBeEBixW8hckkzUo
uNM1JlqP/1mQ4qluKVT2TtNM2opKjPjwsr706F6upmRgIAZVdnCEHyzd1i70tGZI
zt6mPFbSXmpehYXjiRENB2Lzc5wrchOqGfkh4Yt8RDl66BNSY8nWmaZm+tR8YGw0
aqiHiD/0cC1/yBm4lfPGRSvczJuUsQ==
=jDtk
-----END PGP SIGNATURE-----

--BzKTWX5hFONCi2fmvioUdrawSOPXRKQVI--

