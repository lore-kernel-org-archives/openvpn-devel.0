Message-ID: <4EF33D15.3070104@...515...>
Date: Thu, 22 Dec 2011 16:22:13 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030800000408030706050006"
Subject: [Openvpn-devel] OpenVPN 2.2.2 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "openvpn-announce@lists.sourceforge.net" <openvpn-announce@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------030800000408030706050006
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable

The OpenVPN community project team is proud to release OpenVPN 2.2.2. It
can be downloaded from here:

<http://openvpn.net/index.php/open-source/downloads.html>

Changes include:

- Pkcs11 support built into the Windows version
- Fixed a bug in the Windows TAP-driver

Full list of changes is attached to this email and is also available here:

<http://openvpn.net/index.php/open-source/documentation/change-log/425-chan=
gelog-for-openvpn-22.html>

For generic help use these support channels:

- Official documentation:
<http://openvpn.net/index.php/open-source/documentation/howto.html>
- Wiki: <https://community.openvpn.net>
- Forums: <https://forums.openvpn.net>
- User mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
- User IRC channel: #openvpn at irc.freenode.net

Please report bugs and ask development questions here:

- Bug tracker and Wiki: <https://community.openvpn.net>
- Developer mailing list: <http://sourceforge.net/mail/?group_id=3D48978>
- Developer IRC channel: #openvpn-devel at irc.freenode.net

Note that we've recently switched to using a different Git repository:

<git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn.git>

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

--------------030800000408030706050006
Content-Type: text/plain;
 name="openvpn-2.2.2-changelog.txt"
Content-Disposition: attachment;
 filename="openvpn-2.2.2-changelog.txt"
Content-Transfer-Encoding: quoted-printable

OpenVPN Change Log

2011.12.22 -- Version 2.2.2

David Sommerseth (1):
      Only warn about non-tackled IPv6 packets once

Gert Doering (3):
      Add missing break between "case IPv4" and "case IPv6", leading to t=
he    =20
      Bump tap driver version from 9.8 to 9.9
      Log error message and exit for "win32, tun mode, tap driver version=
 9.8"

Samuli Sepp=C3=A4nen (1):
      Backported pkcs11-related parts of 7a8d707237bb18 to 2.2 branch

--------------030800000408030706050006--

