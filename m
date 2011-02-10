Message-ID: <4D53FD4B.8050302@...515...>
Date: Thu, 10 Feb 2011 16:59:23 +0200
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.2-rc Windows installer ready
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

Hi all,

The (hopefully) final preview of the OpenVPN 2.2-rc installer for
Windows is available here:

<http://build.openvpn.net/downloads/releases/openvpn-2.2-rc-install-preview=
-5.exe>

The main reason for this preview installer is our use of the new,
relatively untested Python-based buildsystem which uses VS 2008 tools.
Note that the new buildsystem is not replacing the old autotools-based
one. This installer and the included binaries have been tested on the
following platforms:

- Windows XP 32-bit
- Windows XP 64-bit
- Windows 7 64-bit

The plan is to get James to sign the installer during today's IRC
meeting (#openvpn-devel at irc.freenode.net) at 18:00 UTC. If you want
help make sure that 2.2-rc is a solid release, please test the installer
and let us know if there are any issues - or if it works perfectly.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


