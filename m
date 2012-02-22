Message-ID: <4F44BB17.40606@...515...>
Date: Wed, 22 Feb 2012 11:53:27 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Cross-compiled Windows binaries (32/64bit)
	available for testing
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
To: "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

Thanks to Alon Bar-Lev we now have a buildsystem that also allows, among
other things, cross-compiling Windows binaries on *NIX platforms. I
built two sets of binaries for testing purposes and they seemed to work
just fine on both Windows XP (32-bit) and Windows 7 (64-bit). However,
more testing never hurts, so any test reports are appreciated!

The binaries are available here:

<http://build.openvpn.net/downloads/snapshots/bin32.zip>
<http://build.openvpn.net/downloads/snapshots/bin64.zip>

You need to install OpenVPN as usual first. Then you just replace it's=20
"bin" directory[1] with the one contained in the zip-file.

NOTE: the included openvpn.exe does not support loading passwords from a
file.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


[1] Usually "C:\Program Files\OpenVPN\bin" or "C:\Program Files
(x86)\OpenVPN\bin"

