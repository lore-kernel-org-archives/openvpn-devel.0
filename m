From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <1996c6a0-8713-cda7-b26e-8700a5b9c1ab@...515...>
Date: Tue, 26 Sep 2017 17:43:52 +0300
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Dvrek7BpMVdl3u3OEnkdXO79DBUAbei1q"
Subject: [Openvpn-devel] OpenVPN 2.3.18 released (with security fixes)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, openvpn-announce@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Dvrek7BpMVdl3u3OEnkdXO79DBUAbei1q
Content-Type: multipart/mixed; boundary="4xGggI1h02KFgo66OGOEks5lDNVr31e0E";
 protected-headers="v1"
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>,
 "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>,
 openvpn-announce@lists.sourceforge.net
Message-ID: <1996c6a0-8713-cda7-b26e-8700a5b9c1ab@...515...>
Subject: OpenVPN 2.3.18 released (with security fixes)

--4xGggI1h02KFgo66OGOEks5lDNVr31e0E
Content-Type: multipart/mixed;
 boundary="------------E208BA983257AC362F848E29"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------E208BA983257AC362F848E29
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.3.18.
It can be downloaded from here:

<http://openvpn.net/index.php/open-source/downloads.html>

This release has an important security fix for legacy setups that may
still be using key-method 1:

<https://community.openvpn.net/openvpn/wiki/CVE-2017-12166>

As that option was deprecated 12 years ago we estimate that not many
production setups are affected in practice.

In addition Windows installers have been built with NSIS version that
has been patched against several NSIS installer code execution and
privilege escalation problems:

<https://community.openvpn.net/openvpn/wiki/NSISBug1125>

Based on our testing, though, older Windows versions such as Windows 7
might not benefit from these fixes. We thus strongly encourage you to
always move NSIS installers to a non-user-writeable location before
running them. Our long-term plan is to migrate to using MSI installers
instead.

A summary of the changes is available here:

<https://github.com/OpenVPN/openvpn/blob/release/2.3/Changes.rst>

A full list of changes is available here:

<https://community.openvpn.net/openvpn/wiki/ChangesInOpenvpn23>

For generic help use these support channels:

Official documentation:
<http://openvpn.net/index.php/open-source/documentation/howto.html>
Wiki: <https://community.openvpn.net>
Forums: <https://forums.openvpn.net>
User mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
User IRC channel: #openvpn at irc.freenode.net

Please report bugs and ask development questions here:

Bug tracker and wiki: <https://community.openvpn.net>
Developer mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
Developer IRC channel: #openvpn-devel at irc.freenode.net (requires
Freenode registration)

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


--------------E208BA983257AC362F848E29
Content-Type: application/pgp-keys;
 name="0x40864578.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0x40864578.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v2

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
XuwT7RpGDZ6jBfphYQ=3D=3D
=3DFKLE
-----END PGP PUBLIC KEY BLOCK-----

--------------E208BA983257AC362F848E29--

--4xGggI1h02KFgo66OGOEks5lDNVr31e0E--

--Dvrek7BpMVdl3u3OEnkdXO79DBUAbei1q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZymeoAAoJEClYTZ9AhkV4LCAH/3sdnGUjn5yAaretaOEKFCUC
yxtgSfjIBZBZDCy3b4hNOCg1v49lCEFQZnCWIrXmuOV/ZTLtpd2be8RN7Gx/LWOh
7XnEqJNVkR4njm97Re3qWAjFP2A6BEwyR2m3xeR+um9Gl/mbKhs6HDHbwg7V9Ebh
WSClCAlLwmPvLrELequjfwFgQIRLW17smRx0YTNcQqROaldj00c9dQUi8Ve6oYUP
bTzIriey3Ny7NWNoeCaA8IlbVOTHKiXud/H1T54H9jGn75tloFta+oE7BtWdnBZ0
5eUuHqwf1JrcDrZ+FY9II7g8OQQCo+4UPF96vYSXmHRQ/BcJmm2H9E2oCTaFcsY=
=bdSu
-----END PGP SIGNATURE-----

--Dvrek7BpMVdl3u3OEnkdXO79DBUAbei1q--

