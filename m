From: Gert Doering <gert@...1296...>
Date: Mon, 28 Nov 2022 17:49:32 +0100
Message-Id: <20221128164932.14252-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] rework INSTALL and README to prepare for
 2.6 release
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Update URLs in README

Rip out information in INSTALL that is already in PORTS, or is
printed by "./configure --help"

Update tun/tap driver information where outdated or incomplete.

Update build prerequisites, add new linux libraries, add git and
libtool to developer tools needed, etc.

Signed-off-by: Gert Doering <gert@...1296...>
---
 INSTALL | 207 ++++++++++++++------------------------------------------
 README  |   8 +--
 2 files changed, 56 insertions(+), 159 deletions(-)

diff --git a/INSTALL b/INSTALL
index 9db5b645..a899b148 100644
--- a/INSTALL
+++ b/INSTALL
@@ -1,6 +1,6 @@
 Installation instructions for OpenVPN, a Secure Tunneling Daemon
 
-Copyright (C) 2002-2019 OpenVPN Inc. This program is free software;
+Copyright (C) 2002-2022 OpenVPN Inc. This program is free software;
 you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2
 as published by the Free Software Foundation.
@@ -52,45 +52,39 @@ Also see the man page for more information.
 
 *************************************************************************
 
-SUPPORTED PLATFORMS:
-  (1) Linux (kernel 2.6+)
-  (2) Solaris
-  (3) OpenBSD 5.1+
-  (4) Mac OS X Darwin 10.5+
-  (5) FreeBSD 7.4+
-  (6) NetBSD 5.0+
-  (7) Windows Vista or later for OpenVPN 2.4
-  (8) Windows XP or later for OpenVPN 2.3
-
-SUPPORTED PROCESSOR ARCHITECTURES:
-   In general, OpenVPN is word size and endian independent, so
-   most processors should be supported.  Architectures known to
-   work include Intel x86, Alpha, Sparc, Amd64, and ARM.
-
-REQUIRES:
+For a list of supported platforms and architectures, and for
+instructions how to port OpenVPN to a yet-unsupported architecture,
+see the file "PORTS".
+
+*************************************************************************
+
+SYSTEM REQUIREMENTS:
   (1) TUN and/or TAP driver to allow user-space programs to control
-      a virtual point-to-point IP or Ethernet device.  See
-      TUN/TAP Driver Configuration section below for more info.
-  (2) OpenSSL library, necessary for encryption, version 1.0.2 or higher
+      a virtual point-to-point IP or Ethernet device.
+      See TUN/TAP Driver References section below for more info.
+  (2a) OpenSSL library, necessary for encryption, version 1.0.2 or higher
       required, available from http://www.openssl.org/
       or
-  (3) mbed TLS library, an alternative for encryption, version 2.0 or higher
+  (2b) mbed TLS library, an alternative for encryption, version 2.0 or higher
       required, available from https://tls.mbed.org/
+  (3) on Linux, "libnl-gen" is required for kernel netlink support
+  (4) on Linux, "libcap-ng" is required for Linux capability handling
 
 OPTIONAL:
-  (3) LZO real-time compression library, required for link compression,
+  (5) LZO real-time compression library, required for link compression,
       available from http://www.oberhumer.com/opensource/lzo/
-      OpenBSD users can use ports or packages to install lzo, but remember
-      to add CFLAGS="-I/usr/local/include" LDFLAGS="-L/usr/local/lib"
-      directives to "configure", since gcc will not find them otherwise.
+      (most supported operating systems have LZO in their installable
+      packages repository.  It might be necessary to add LZO_CFLAGS=
+      and LZO_LIBS= to the configure call to make it find the LZO pieces)
+  (6) LZ4 compression library
 
 OPTIONAL (for developers only):
-  (1) Autoconf 2.59 or higher + Automake 1.9 or higher
-      -- available from http://www.gnu.org/software/software.html
-  (2) Dmalloc library
-      -- available from http://dmalloc.com/
+  (1) Autoconf 2.59 or higher
+      Automake 1.9 or higher
+      Libtool
+      Git
+  (2) cmocka test framework (http://cmocka.org)
   (3) If using t_client.sh test framework, fping/fping6 is needed
-      -- Available from http://www.fping.org/
       Note: t_client.sh needs an external configured OpenVPN server.
       See t_client.rc-sample for more info.
 
@@ -106,7 +100,7 @@ CHECK OUT SOURCE FROM SOURCE REPOSITORY:
 
   Check out stable version:
 
-    git checkout release/2.4
+    git checkout release/2.6
 
   Check out master (unstable) branch:
 
@@ -119,7 +113,7 @@ BUILD COMMANDS FROM TARBALL:
 
 	./configure
 	make
-	make install
+	sudo make install
 
 *************************************************************************
 
@@ -128,7 +122,7 @@ BUILD COMMANDS FROM SOURCE REPOSITORY CHECKOUT:
 	autoreconf -i -v -f
 	./configure
 	make
-	make install
+	sudo make install
 
 *************************************************************************
 
@@ -175,98 +169,17 @@ you can install cmocka with these commands:
 
 OPTIONS for ./configure:
 
-  --disable-lzo           disable LZO compression support [default=yes]
-  --disable-lz4           Disable LZ4 compression support
-  --enable-comp-stub      Don't compile compression support but still allow limited interoperability with compression-enabled peers
-  --disable-crypto        disable crypto support [default=yes]
-  --disable-ofb-cfb       disable support for OFB and CFB cipher modes
-                          [default=yes]
-  --enable-x509-alt-username
-                          enable the --x509-username-field feature
-                          [default=no]
-  --disable-server        disable server support only (but retain client
-                          support) [default=yes]
-  --disable-plugins       disable plug-in support [default=yes]
-  --disable-management    disable management server support [default=yes]
-  --enable-pkcs11         enable pkcs11 support [default=no]
-  --disable-fragment      disable internal fragmentation support (--fragment)
-                          [default=yes]
-  --disable-multihome     disable multi-homed UDP server support (--multihome)
-                          [default=yes]
-  --disable-port-share    disable TCP server port-share support (--port-share)
-                          [default=yes]
-  --disable-debug         disable debugging support (disable gremlin and verb
-                          7+ messages) [default=yes]
-  --enable-small          enable smaller executable size (disable OCC, usage
-                          message, and verb 4 parm list) [default=no]
-  --enable-iproute2       enable support for iproute2 [default=no]
-  --disable-def-auth      disable deferred authentication [default=yes]
-  --disable-pf            disable internal packet filter [default=yes]
-  --disable-plugin-auth-pam
-                          disable auth-pam plugin [default=platform specific]
-  --disable-plugin-down-root
-                          disable down-root plugin [default=platform specific]
-  --enable-pam-dlopen     dlopen libpam [default=no]
-  --enable-strict         enable strict compiler warnings (debugging option)
-                          [default=no]
-  --enable-pedantic       enable pedantic compiler warnings, will not generate
-                          a working executable (debugging option) [default=no]
-  --enable-werror         promote compiler warnings to errors, will cause
-                          builds to fail if the compiler issues warnings
-                          (debugging option) [default=no]
-  --enable-strict-options enable strict options check between peers (debugging
-                          option) [default=no]
-  --enable-selinux        enable SELinux support [default=no]
-  --enable-systemd        enable systemd support [default=no]
-  --enable-async-push     enable async-push support for plugins providing
-                          deferred authentication [default=no]
+  To get an overview of all the configure options, run "./configure --help"
 
 ENVIRONMENT for ./configure:
 
-  PLUGINDIR   Path of plug-in directory [default=LIBDIR/openvpn/plugins]
-  IFCONFIG    full path to ipconfig utility
-  ROUTE       full path to route utility
-  IPROUTE     full path to ip utility
-  NETSTAT     path to netstat utility
-  GIT         path to git utility
-  SYSTEMD_ASK_PASSWORD
-              path to systemd-ask-password utility
-  SYSTEMD_UNIT_DIR
-              Path of systemd unit directory [default=LIBDIR/systemd/system]
-  TMPFILES_DIR
-              Path of tmpfiles directory [default=LIBDIR/tmpfiles.d]
-  RST2MAN     Path to rst2man utility
-  RST2HTML    Path to rst2html utility
-
-ENVIRONMENT variables adjusting parameters related to dependencies
-
-  TAP_CFLAGS  C compiler flags for tap
-  LIBPAM_CFLAGS
-              C compiler flags for libpam
-  LIBPAM_LIBS linker flags for libpam
-  PKCS11_HELPER_CFLAGS
-              C compiler flags for PKCS11_HELPER, overriding pkg-config
-  PKCS11_HELPER_LIBS
-              linker flags for PKCS11_HELPER, overriding pkg-config
-  OPENSSL_CFLAGS
-              C compiler flags for OpenSSL
-  OPENSSL_LIBS
-              linker flags for OpenSSL
-  MBEDTLS_CFLAGS
-              C compiler flags for mbedtls
-  MBEDTLS_LIBS
-              linker flags for mbedtls
-  LZO_CFLAGS  C compiler flags for lzo
-  LZO_LIBS    linker flags for lzo
-  LZ4_CFLAGS  C compiler flags for lz4
-  LZ4_LIBS    linker flags for lz4
-  libsystemd_CFLAGS
-              C compiler flags for libsystemd, overriding pkg-config
-  libsystemd_LIBS
-              linker flags for libsystemd, overriding pkg-config
-  P11KIT_CFLAGS
-              C compiler flags for P11KIT, overriding pkg-config
-  P11KIT_LIBS linker flags for P11KIT, overriding pkg-config
+  For more fine-grained control on include + library paths for external
+  components etc., configure can be called with environment variables on
+  the command line, e.g.
+
+     ./configure OPENSSL_CFLAGS="-I/usr/local/include" ...
+
+  these are also explained in "./configure --help", so not repeated here.
 
 *************************************************************************
 
@@ -303,12 +216,12 @@ For more details:
   https://packages.ubuntu.com/search?keywords=openvpn
 
 In addition, the OpenVPN community provides a best-effort APT repository
-for Debian and Ubuntu:
+for CentOS/Fedora, Debian and Ubuntu:
 https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos
 
 *************************************************************************
 
-TUN/TAP Driver Configuration:
+TUN/TAP Driver References:
 
 * Linux 2.6 or higher (with integrated TUN/TAP driver):
 
@@ -322,17 +235,17 @@ TUN/TAP Driver Configuration:
 
   FreeBSD ships with the TUN/TAP driver, and the device nodes for tap0,
   tap1, tap2, tap3, tun0, tun1, tun2 and tun3 are made by default.
-  However, only the TUN driver is linked into the GENERIC kernel.
 
-  To load the TAP driver, enter: 
+  On FreeBSD versions prior to 12.0-RELEASE, there were independent
+  TUN and TAP drivers, and the TAP driver needed to be loaded manually,
+  using the command:
 
-	kldload if_tap
+	# kldload if_tap
 
-  See man rc(8) to find out how you can do this at boot time.
+  For recent FreeBSD versions, TUN/TAP are integrated and always loaded.
 
-  The easiest way is to install OpenVPN from the FreeBSD ports system,
-  the port includes a sample script to automatically load the TAP driver
-  at boot-up time.
+  FreeBSD 14 contains the ovpn(4) for kernel-level OpenVPN acceleration
+  (DCO) which will be used by OpenVPN 2.6 and up if available.
 
 * OpenBSD:
 
@@ -354,31 +267,15 @@ TUN/TAP Driver Configuration:
   recent Windows versions it is recommended to use the NDIS 6 driver
   (tap-windows6) instead.
 
+  Windows 10 and Server 2016 and up can use the dco-win driver for
+  kernel-level acceleration for OpenVPN client setups.  This is also
+  included in the community-provided OpenVPN installers.
+
 *************************************************************************
 
 CAVEATS & BUGS:
 
-* I have noticed cases where TCP sessions tunneled over the Linux
-  TAP driver (kernel 2.4.21 and 2.4.22) stall when lower --mssfix
-  values are used.  The TCP sessions appear to unstall and resume
-  normally when the remote VPN endpoint is pinged.
-
-* If run through a firewall using OpenBSDs packet filter PF and the
-  filter rules include a "scrub" directive, you may get problems talking
-  to Linux hosts over the tunnel, since the scrubbing will kill packets
-  sent from Linux hosts if they are fragmented. This is usually seen as
-  tunnels where small packets and pings get through but large packets
-  and "regular traffic" don't. To circumvent this, add "no-df" to
-  the scrub directive so that the packet filter will let fragments with
-  the "dont fragment"-flag set through anyway.
-
-* Mixing OFB or CFB cipher modes with static key mode is not recommended,
-  and is flagged as an error on OpenVPN versions 1.2.1 and greater.
-  If you use the --cipher option to explicitly select an OFB or CFB
-  cipher AND you are using static key mode, it is possible that there
-  could be an IV collision if the OpenVPN daemons on both sides
-  of the connection are started at exactly the same time, since
-  OpenVPN uses a timestamp combined with a sequence number as the cipher
-  IV for OFB and CFB modes.  This is not an issue if you are
-  using CBC cipher mode (the default), or if you are using OFB or CFB
-  cipher mode with SSL/TLS authentication.
+* see the bug tracker on https://community.openvpn.net/openvpn/report
+  and the wiki on https://community.openvpn.net/wiki for more detailed
+  caveats on operating systems, and for open and resolved bug reports.
+
diff --git a/README b/README
index b75a568e..523abb70 100644
--- a/README
+++ b/README
@@ -1,6 +1,6 @@
 OpenVPN -- A Secure tunneling daemon
 
-Copyright (C) 2002-2018 OpenVPN Inc. This program is free software;
+Copyright (C) 2002-2022 OpenVPN Inc. This program is free software;
 you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2
 as published by the Free Software Foundation.
@@ -9,7 +9,7 @@ as published by the Free Software Foundation.
 
 To get the latest release of OpenVPN, go to:
 
-	https://openvpn.net/index.php/download/community-downloads.html
+	https://openvpn.net/community-downloads/
 
 To Build and Install,
 
@@ -30,7 +30,7 @@ For a sample VPN configuration, see
   http://openvpn.net/howto.html
 
 To report an issue, see
-  https://community.openvpn.net/openvpn/report
+  https://community.openvpn.net/openvpn/newticket
 
 For a description of OpenVPN's underlying protocol,
   see the file ssl.h included in the source distribution.
@@ -64,7 +64,7 @@ Note that easy-rsa and tap-windows are now maintained in their own subprojects.
 Their source code is available here:
 
   https://github.com/OpenVPN/easy-rsa
-  https://github.com/OpenVPN/tap-windows
+  https://github.com/OpenVPN/tap-windows6
 
 The old cross-compilation environment (domake-win) and the Python-based
 buildsystem have been replaced with openvpn-build:
-- 
2.35.1


