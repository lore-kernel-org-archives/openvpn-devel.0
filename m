Message-ID: <4FE87245.9030207@...515...>
Date: Mon, 25 Jun 2012 17:14:29 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN 2.3-alpha2 preview Windows installers ready
	for testing
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

Hi,

We've reached a point where the openvpn codebase is ready for 2.3-alpha2
release. As biggest changes are in the build/packaging parts, it'd be
great if you could test these Windows installers and report back how
they work for you:

<http://build.openvpn.net/downloads/releases/openvpn-install-2.3_master-I00=
0_master-i686.exe>
<http://build.openvpn.net/downloads/releases/openvpn-install-2.3_master-I00=
0_master-x86_64.exe>

Use the first for 32-bit and the latter on 64-bit Windows. Both
installers and all of the included components have been signed with a
paid-for software publisher certificate (SPC) so they should work on any
supported version of Windows. I've personally smoketested the installers
on Windows 7 64-bit and Windows XP 32-bit.

If you're upgrading from 2.3-alpha1 or earlier, please read this first:

<https://github.com/mattock/openvpn/blob/4039ec7cd4cd0bf595289ed31df8955f37=
4a1705/INSTALL-win32.txt>

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


