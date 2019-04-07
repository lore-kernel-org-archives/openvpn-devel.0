From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
References: <e18eefae-c2e8-61e2-4f4d-8d978d74b4c3@...515...>
Message-ID: <7dd77ddb-c187-fc8f-96ba-3c8c75fd1c70@...515...>
Date: Sun, 7 Apr 2019 11:26:24 +0300
MIME-Version: 1.0
In-Reply-To: <e18eefae-c2e8-61e2-4f4d-8d978d74b4c3@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="l6J2GOW5Afq4uCY1WtjWRJSn4VuZdhcy5"
Subject: [Openvpn-devel] Tap-windows6 9.23.1 pre-release installer for
 Windows 10
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
--l6J2GOW5Afq4uCY1WtjWRJSn4VuZdhcy5
Content-Type: multipart/mixed; boundary="X9f1CdZl6ezXrO9IKWd2dLzmPJxu207GQ";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <7dd77ddb-c187-fc8f-96ba-3c8c75fd1c70@...515...>
Subject: Tap-windows6 9.23.1 pre-release installer for Windows 10
References: <e18eefae-c2e8-61e2-4f4d-8d978d74b4c3@...515...>
In-Reply-To: <e18eefae-c2e8-61e2-4f4d-8d978d74b4c3@...515...>

--X9f1CdZl6ezXrO9IKWd2dLzmPJxu207GQ
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable

Hi,

Windows 10 version of tap-windows6 9.23.1 is available here:

http://build.openvpn.net/downloads/snapshots/tap-windows6-9.23.1/windows10

The Windows 10 version is completely untested but it "should work" on
x86, x64 and probably even arm64.

Windows 7/8/8.1/Server 2012r2 installer and driver files are here:

http://build.openvpn.net/downloads/snapshots/tap-windows6-9.23.1/windows7

Both installers are unsigned - please ignore the "Unknown publisher"
warning when running them.

Best regards,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

Il 05/04/19 17:00, Samuli Sepp=E4nen ha scritto:
> Hi,
>=20
> A new pre-release tap-windows6 driver (9.23.1) is available for testing.
> It should work on Windows 7/8/8.1/Server 2012r2. It _will not_ work  on
> Windows 10 or Windows Server 2016/2019.
>=20
> The driver includes several new features such as support for NDIS 6.30
> arm64 support, improvements in driver version display, etc.
>=20
> Download the installer from here:
>=20
> https://build.openvpn.net/downloads/snapshots/tap-windows-9.23.1-I601.exe
>=20
> For those who want the raw, signed driver files please download the zip
> file:
>=20
> https://build.openvpn.net/downloads/snapshots/tap-windows-9.23.1.zip
>=20
> I install-tested driver on Windows Server 2012r2 and there were no
> obvious problems.
>=20
> It would be great if other people could smoke-test the new driver - just
> install it on top of existing OpenVPN installation. In particular
> running OpenVPN with the driver would be useful.
>=20
> I ran into some issues with attestation signing for Windows 10, but I
> will probably have a Windows 10 version available tomorrow.
>=20
> Best regards,
>=20
>=20
>=20
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20





--X9f1CdZl6ezXrO9IKWd2dLzmPJxu207GQ--

--l6J2GOW5Afq4uCY1WtjWRJSn4VuZdhcy5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEbQT48bAXMRH0mXleKVhNn0CGRXgFAlyptDAACgkQKVhNn0CG
RXjadgf+MXruiD6zzUK8F+8LXrgYVgtI1UFKeIeICVzoYSKuepuPMI7o5yz3vkRl
Za5VrbbVAhzMs0urzNlrFkenzLaHwFAwYk+6zUNK+nxCQti/UVHDOx/HiDqi886Q
docJVDG6z7aHWRdwX90DmJK0KRd+q7U9CO5WASc2MIBjIicGiYtW2PqIJKk/pHRq
MqAMSpRJPDBLWMANjw+SA4b4mPwGeSZcgL6hHPGiXWs/3XmPdbpO5xtXfokyvrOH
JXscZ1Uq87LiJ416G70XbxRhRJq5H19yAhyqRCzRCu19qTcgWzvUu46OzX7mIU57
qnUyyRMn0vXLUcp3Akntn8JA9F2cVg==
=78tK
-----END PGP SIGNATURE-----

--l6J2GOW5Afq4uCY1WtjWRJSn4VuZdhcy5--

