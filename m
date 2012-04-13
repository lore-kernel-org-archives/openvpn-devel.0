Message-ID: <4F882970.4080302@...515...>
Date: Fri, 13 Apr 2012 16:26:08 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Build tests using "generic" buildsystem and Git
	"master"!
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi all,

I also ran some build tests with the "generic" buildsystem[1], OpenVPN
Git "master"[2] and an Ubuntu 11.10 amd64 workstation. As the Git
"master" does not yet seem to include the "generic" buildsystem, I
downloaded it separately[3] and pointed it to a tarball[4] assembled
from latest Git "master" code. Building the obsolete OpenVPN-GUI 1.0.3
for Windows seemed to fail, so I disabled it by editing the build script
(generic/build). Anyways, here are the results of the tests...

Building a native binary worked:

$ IMAGEROOT=`pwd`/image-native ./build)

Building a Windows 32bit binary on Linux 64bit worked:

$ IMAGEROOT=`pwd`/image-win32 CHOST=i686-w64-mingw32
\ CBUILD=x86_64-pc-linux-gnu ./build

Building a Windows 64bit binary on Linux 64bit worked:

$ IMAGEROOT=`pwd`/image-win64 CHOST=x86_64-w64-mingw32
\ CBUILD=x86_64-pc-linux-gnu ./build

I could not test building for Arm, as the my workstation was missing the
required tools.

Samuli

[1]
<https://community.openvpn.net/openvpn/wiki/BuildingUsingGenericBuildsystem#Genericbuildmethod>
[2] <git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn.git>
[3] <https://github.com/alonbl/openvpn-build.git>
[4] <http://build.openvpn.net/downloads/snapshots/openvpn-2.3_alpha1.tar.gz>

