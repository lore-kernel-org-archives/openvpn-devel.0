Message-ID: <500012F6.9030108@...515...>
Date: Fri, 13 Jul 2012 15:22:14 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Openvpn-2.3_alpha2 and easy-rsa-2.2.0_master
 packages and packaging files published
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

I've just finished packaging openvpn-2.3_alpha2 for Debian/Ubuntu and
Fedora/EL. As the packaging files required significant changes on both
Debian and RPM front, I've put them here for others to use/improve:

<http://build.openvpn.net/downloads/packaging>

The packaging highlights for the 2.3_alpha2 are:

- easy-rsa split into it's own architecture-independent package
- packages for Ubuntu 12.04
- debian packaging files made as generic as possible, only Ubuntu 12.04
files having required minor changes

CentOS/EL6 is still missing the new packages as I don't have direct
access to the CentOS build computers until next Monday. All other
packages are already in their respective ("-snapshot") repositories.

For details on how to use our software repositories, please look here:

<https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos>

If you encounter any issues with the packages, please let me know! Also,
any suggestions on where to host these files in the long run are most
appreciated! Perhaps "openvpn-build" repository would be the least bad
place?
--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

