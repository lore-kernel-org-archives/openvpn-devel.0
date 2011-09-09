Message-ID: <4E69DDAB.2040104@...515...>
Date: Fri, 09 Sep 2011 12:34:35 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] First Windows snapshot installer of "master" branch
	now available
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

Hi all,

The first Windows snapshot installer based on current "master" branch is
now available:

<http://build.openvpn.net/downloads/snapshots/openvpn-2.x-20110909-master-i=
nstall.exe>

There are lots of changes compared to OpenVPN 2.2.1, including IPv6
support and a new GUI. Perhaps somebody else could provide a more
through list of changes using some Git magic?

This installer also contains signed TAP-drivers (from 2.2.1), so it
should install without any trickery on Windows Vista and later. Please
note that this installer has been tested only briefly and while it
_seems_ to work ok on Windows 7 64-bit, it may still have issues. If you
have any issues with the installer, OpenVPN or the new GUI, please let
us know.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


PS. Future snapshots will also be available as Debian, Ubuntu and
hopefully Fedora/RHEL packages, too. There are already apt repositories
available for the stable releases:

<https://community.openvpn.net/openvpn/wiki/OpenvpnAptRepos>

