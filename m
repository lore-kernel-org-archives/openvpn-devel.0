From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <d94eadcd-06ca-0691-0add-147ac00ab063@...515...>
Date: Thu, 24 Nov 2016 12:26:33 +0200
MIME-Version: 1.0
Subject: [Openvpn-devel] Test installer with installer,
 openvpn-gui and openvpnserv2 improvements
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Here's a Windows new test installer for 2.4_beta1:

<https://build.openvpn.net/downloads/snapshots/openvpn-install-2.4_beta1-I9=
02.exe>

The changes compared to standard 2.4_beta1 installers are:

1) Installer works on both 32-bit and 64-bit Windows
- https://github.com/OpenVPN/openvpn-build/pull/44

2) Installer should fail on Windows XP and earlier
- https://github.com/OpenVPN/openvpn-build/pull/52

3) OpenVPN-GUI is DPI-aware
- https://github.com/OpenVPN/openvpn-gui/pull/99

4) OpenVPN-GUI has dynamic challenge-response support
- https://github.com/OpenVPN/openvpn-gui/pull/87

5) OpenVPN-GUI Ukrainian localization fixes
- https://github.com/OpenVPN/openvpn-gui/pull/94

6) Openvpnserv2 shuts down openvpn instances cleanly
- https://github.com/OpenVPN/openvpnserv2/pull/6

We will try to get all of this included in OpenVPN 2.4_rc1, so test=20
reports are most welcome!

Best regards,

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

