Message-ID: <5390887A.4040001@...515...>
Date: Thu, 05 Jun 2014 18:10:50 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] New OpenVPN Windows installers released to fix
	OpenSSL security vulnerabilities
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-announce@lists.sourceforge.net" <openvpn-announce@lists.sourceforge.net>


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

The OpenSSL project released fixes to several security vulnerabilities
today, one of which (the MITM vulnerability) affects OpenVPN:

<http://www.openssl.org/news/secadv_20140605.txt>

OpenVPN 2.3.2 and 2.3.4 Windows installers that include a fixed version
of OpenSSL have now been released:

<http://openvpn.net/index.php/download/community-downloads.html>

All Windows users of OpenVPN should upgrade their installations
immediately to the latest 2.3.2 or 2.3.4 releases.

Please note that OpenVPN 2.2.2 Windows installers, which were also
vulnerable, have been removed from the main download pages. If you are
unable to upgrade to a recent release you can still build 2.2.2
yourself, linking it to a more recent OpenSSL version.

- --=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOQiHoACgkQwp2X7RmNIqPhUgCfdKXmmnZGz71w5wF4leaC6aJf
kwYAoIDK8M3fNcIx3gAWepaL0Lt04cGe
=3DXOGC
-----END PGP SIGNATURE-----


