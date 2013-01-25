From: samuli@...515...
Date: Fri, 25 Jan 2013 11:59:34 +0200
Message-Id: <1359107974-1481-1-git-send-email-samuli@...515...>
In-Reply-To: <20130125090042.GM22465@...1296...>
References: <20130125090042.GM22465@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/4 v2] Cleaned up and updated INSTALL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

From: Samuli Sepp=C3=A4nen <samuli@...515...>

- Changed "Supported platforms" to reflect current support status of the
  mentioned operatingsystems
- Removed mentions of the obsolete Python and domake-win buildsystems
- Added mention of official Debian/RPM packages
- Added links to the Wiki
- Added mention of the new openvpn-build cross-compile environment
- Added PolarSSL to and removed pthreads from the "Optional" section
- Added mention of t_client.sh test framework
- Removed some very old (pre-2005) nuggets of (obsolete) information
- Other minor cleanups
- Some reorganization

Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 INSTALL |  159 +++++++++++++++++++++++++----------------------------------=
----
 1 file changed, 62 insertions(+), 97 deletions(-)

diff --git a/INSTALL b/INSTALL
index 4ca7288..ab4c984 100644
--- a/INSTALL
+++ b/INSTALL
@@ -12,36 +12,53 @@ QUICK START:
   Unix:
     ./configure && make && make-install
=20
-  Windows MinGW, using MSYS bash shell:
-    ./domake-win (see comments in the script for more info)
+  Cross-compile for Windows on Unix
=20
-  Windows Visual Studio:
-    python win\build_all.py
+    See INSTALL-win32.txt
=20
 *************************************************************************
=20
 To download OpenVPN, go to:
=20
-	http://openvpn.net/download.html
+    http://openvpn.net/download.html
=20
-For step-by-step installation instructions with real-world
-examples see:
+OpenVPN releases are also available as Debian/RPM packages:
=20
-	http://openvpn.net/howto.html
+    https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos
+
+To download easy-rsa go to:
+
+    https://github.com/OpenVPN/easy-rsa
+
+To download tap-windows driver source code go to:
+
+    https://github.com/OpenVPN/tap-windows
+
+To get the cross-compilation environment go to:
+
+    https://github.com/OpenVPN/openvpn-build
+
+For step-by-step instructions with real-world examples see:
+
+    http://openvpn.net/howto.html
+    https://community.openvpn.net/openvpn/wiki
=20
 For examples see:
=20
-	http://openvpn.net/examples.html
+    http://openvpn.net/examples.html
+
+Also see the man page for more information, usage examples, and informatio=
n on=20
+firewall configuration.
=20
 *************************************************************************
=20
 SUPPORTED PLATFORMS:
-  (1) Linux 2.2+
+  (1) Linux (kernel 2.6+)
   (2) Solaris
-  (3) OpenBSD 3.0+ (Comes with OpenSSL and TUN devices by default)
-  (4) Mac OS X Darwin
-  (5) FreeBSD
-  (6) NetBSD
+  (3) OpenBSD 5.1+
+  (4) Mac OS X Darwin 10.5+
+  (5) FreeBSD 7.4+
+  (6) NetBSD 5.0+
   (7) Windows (WinXP and higher)
=20
 SUPPORTED PROCESSOR ARCHITECTURES:
@@ -55,14 +72,15 @@ REQUIRES:
       TUN/TAP Driver Configuration section below for more info.
=20
 OPTIONAL (but recommended):
-  (1) OpenSSL library, necessary for encryption, version 0.9.5 or higher
+  (1) OpenSSL library, necessary for encryption, version 0.9.8 or higher
       required, available from http://www.openssl.org/
-  (2) LZO real-time compression library, required for link compression,
+  (2) PolarSSL library, an alternative for encryption, version 1.1 or high=
er
+      required, available from https://polarssl.org/
+  (3) LZO real-time compression library, required for link compression,
       available from http://www.oberhumer.com/opensource/lzo/
       OpenBSD users can use ports or packages to install lzo, but remember
       to add CFLAGS=3D"-I/usr/local/include" LDFLAGS=3D"-L/usr/local/lib"
       directives to "configure", since gcc will not find them otherwise.
-  (3) Pthread library.
=20
 OPTIONAL (for developers only):
   (1) Autoconf 2.59 or higher + Automake 1.9 or higher
@@ -74,15 +92,18 @@ OPTIONAL (for developers only):
=20
 CHECK OUT SOURCE FROM SOURCE REPOSITORY:
=20
-  git clone https://github.com/OpenVPN/openvpn
+  Clone the repository:
+
+    git clone https://github.com/OpenVPN/openvpn
+    git clone git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn=20
=20
   Check out stable version:
=20
-  git checkout -b 2.2 remotes/origin/release/2.2
+    git checkout -b 2.2 remotes/origin/release/2.2
=20
   Check out master (unstable) branch:
=20
-  git checkout master
+    git checkout master
=20
=20
 *************************************************************************
@@ -112,7 +133,7 @@ BUILD A TARBALL FROM SOURCE REPOSITORY CHECKOUT:
=20
 *************************************************************************
=20
-LOOPBACK TESTS (after BUILD):
+TESTS (after BUILD):
=20
 make check (Run all tests below)
=20
@@ -126,6 +147,9 @@ Test SSL/TLS negotiations (runs for 2 minutes):
 ./openvpn --config sample/sample-config-files/loopback-client (In one wind=
ow)
 ./openvpn --config sample/sample-config-files/loopback-server (Simultaneou=
sly in another window)
=20
+For more thorough client-server tests you can configure your own, private =
test
+environment. See tests/t_client.rc-sample for details.
+
 *************************************************************************
=20
 OPTIONS for ./configure:
@@ -205,7 +229,7 @@ ENVIRONMENT for ./configure:
=20
 *************************************************************************
=20
-BUILDING ON LINUX 2.4+ FROM RPM
+BUILDING ON LINUX 2.6+ FROM RPM
=20
 You can build a binary RPM directly from the OpenVPN tarball file:
=20
@@ -224,7 +248,7 @@ startup or shutdown, based on OpenVPN .conf files in /e=
tc/openvpn.
 See the comments in openvpn.init for more information.
=20
 Installing the RPM will also configure the TUN/TAP device node
-for linux 2.4.
+for linux 2.6.
=20
 Note that the current openvpn.spec file, which instructs the rpm tool
 how to build a package, will build OpenVPN with all options enabled,
@@ -236,56 +260,15 @@ you edit the openvpn.spec file.
=20
 TUN/TAP Driver Configuration:
=20
-* Linux 2.4 or higher (with integrated TUN/TAP driver):
-
-  (1)  make device node:         mknod /dev/net/tun c 10 200
-  (2a) add to /etc/modules.conf: alias char-major-10-200 tun
-  (2b) load driver:              modprobe tun
-  (3)  enable routing:           echo 1 > /proc/sys/net/ipv4/ip_forward
-
-  Note that either of steps (2a) or (2b) is sufficient.  While (2a)
-  only needs to be done once per install, (2b) needs to be done once
-  per reboot.  If you install from RPM (see above) and use the
-  openvpn.init script, these steps are taken care of for you.
-
-* Linux 2.2 or Solaris:
+* Linux 2.6 or higher (with integrated TUN/TAP driver):
=20
-  You should obtain
-  version 1.1 of the TUN/TAP driver from
-  http://vtun.sourceforge.net/tun/
-  and follow the installation instructions.
+  (1) load driver:              modprobe tun
+  (2) enable routing:           echo 1 > /proc/sys/net/ipv4/ip_forward
=20
-  If you use OpenVPN on Linux 2.2 or 2.4 or Solaris, you may be
-  suffering from a bug which causes connections to hang under heavy load.
-  The symptoms are very similar to the MTU problems discussed frequently
-  in the OpenVPN mailing lists. But it turns out that this bug is not caus=
ed by
-  MTU problems. It's a bug in the tun/tap driver.  A patch is provided her=
e:
+  Note that (1) needs to be done once per reboot.  If you install from RPM=
 (see
+  above) and use the openvpn.init script, these steps are taken care of fo=
r you.
=20
-  http://openvpn.net/patch/tun-sb.patch
-
-* Solaris
-
-  For 64 bit, I used the tun-1.1.tar.gz source and compiled it.
-
-  Of course there is a but :)
-  In the tun-1-1\solaris\Makefile I changed a line so it compiles with 64 =
bit
-
-  CFLAGS =3D $(DEFS) -m64 -O2 -Wall -D_KERNEL -I.
-
-  I just added -m64 and it worked.
-
-  The tun driver works fine as said previously, however we noticed there i=
s a
-  minor problem when creating multiple tunnels on Solaris.
-  Mr Tycho Fruru changed the code in tun.c file where he locked the tun de=
vice
-  number to -1. This way it is impossible to specify the name of the tun d=
evice
-  but it is still possible to have multiple devices.
-  The modification will increment automatically meaning starting from tun0=
 --->
-  tunX I know you are not responsible for the tun coding but if you think =
the
-  modification can be useful for you feel free to use it.
-
-  http://openvpn.net/solaris/tun.c
-
-* FreeBSD 4.1.1+:
+* FreeBSD:
=20
   FreeBSD ships with the TUN/TAP driver, and the device nodes for tap0,
   tap1, tap2, tap3, tun0, tun1, tun2 and tun3 are made by default.
@@ -303,41 +286,23 @@ TUN/TAP Driver Configuration:
=20
 * OpenBSD:
=20
-  OpenBSD ships with tun0 and tun1 installed by default on pre-3.5 systems,
-  while 3.5 and later have dynamically created tun* devices so you only ne=
ed
+  OpenBSD has dynamically created tun* devices so you only need
   to create an empty /etc/hostname.tun0 (tun1, tun2 and so on) for each tun
   you plan to use to create the device(s) at boot.
=20
-* Mac OS X:
-
-  2005.02.13: Angelo Laub has developed a GUI for OS X:
-
-  http://rechenknecht.net/OpenVPN-GUI/
-
-  2004.10.26: Mattias Nissler has developed a new TUN/TAP driver for
-  MAC OS X:
-
-  http://www-user.rhrk.uni-kl.de/~nissler/tuntap/=20=20=20=20
-
-  Christoph Pfisterer's old TUN driver can be obtained at
-  http://chrisp.de/en/projects/tunnel.html -- note that it
-  is no longer being maintained.
+* Solaris:
=20
-* Solaris9 Sparc/64
+  You need a TUN/TAP kernel driver for OpenVPN to work:
=20
-  The kernel module for solaris
-  can be generated by adding the -m64 switch to a modern
-  gcc compiler (I'm using 3.2)  The resulting kernel driver
-  needs to be manually copied to /kernel/drv/sparcv9/ and then a=20
-  reconfiguration reboot. (boot -r).
+    http://www.whiteboard.ne.jp/~admin2/tuntap/
=20
-* Windows XP/2003/Vista
+* Windows XP/2003/Vista/7:
=20
-  See domake-win for building instructions.
-  See INSTALL-win32.txt for usage info.
+  OpenVPN on Windows needs a TUN/TAP kernel driver to work. OpenVPN instal=
lers
+  include this driver, so installing it separately is not usually required=
.=20
+  The driver source code is available here:
=20
- See the man page for more information, usage examples, and
- information on firewall configuration.
+    https://github.com/OpenVPN/tap-windows
=20
 *************************************************************************
=20
--=20
1.7.10.4


