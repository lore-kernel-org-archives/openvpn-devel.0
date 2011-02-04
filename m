Message-ID: <4D4BE51E.1050905@...515...>
Date: Fri, 04 Feb 2011 13:38:06 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Help testing OpenVPN 2.2-rc Windows installer?
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

As some of you may be aware, I've been working on the new Python-based
OpenVPN Windows buildsystem; now the first fully functional OpenVPN
installer is ready:

<http://build.openvpn.net/downloads/releases/openvpn-2.2-rc-install-preview=
-1.exe>

However, I've only done very limited testing. On Windows 7 64-bit
platform the following seems to work:

- installing and uninstalling all userspace components
- installing and uninstalling the (64-bit) TAP driver
- running OpenVPN as service
- running OpenVPN using the OpenVPN-GUI

I've only noticed two small issues on the Win7 64-bit platform:

- uninstall does not remove the OpenVPN start menu entries properly
(remove manually using right click -> delete)
- "View README" at the end of install does not work

Note that the installer itself is not signed, even though the TAP
drivers are. This will be fixed in the final 2.2-rc release.

Now, I'd need help in verifying that both the installer and the included
executables work properly on all supported 32 and 64-bit Windows
platforms (XP and later). If you can, please test the installer on some
_non-critical system_ and report back, whether everything works properly
or not. Once all installer bugs are squashed, I'll make the
openvpn-2.2-rc release. After that I'll clean up my buildsystem patches,
send them here for review and then update the Windows building Wiki page:

<https://community.openvpn.net/openvpn/wiki/BuildingOnWindows>

Note that soon we'll be able to provide (untested) weekly/biweekly
snapshot builds for Windows. This will benefit those who require the
latest and greatest functionality.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


