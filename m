From: David Sommerseth <davids@...515...>
Date: Tue,  2 Apr 2019 12:37:14 +0300
Message-Id: <20190402093714.8581-1-davids@...515...>
In-Reply-To: <20190327120604.21101-1-davids@...515...>
References: <20190327120604.21101-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH release/2.4] docs: Update INSTALL
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

The INSTALL file contained several minor errors, typos and was generally
not up-to-date in regards to what ./configure provides today.  In
addition, several URL references have moved around to new homes.

Signed-off-by: David Sommerseth <davids@...515...>
---

This is just a backport of git master 6099ab67122429c0 adjusting for the
slight differences in release/2.4.  The contents is the same as git master,
as it is still valid for v2.4.

---
 INSTALL | 106 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 66 insertions(+), 40 deletions(-)

diff --git a/INSTALL b/INSTALL
index a4ad87cc..0ba3bba6 100644
--- a/INSTALL
+++ b/INSTALL
@@ -1,6 +1,6 @@
 Installation instructions for OpenVPN, a Secure Tunneling Daemon
 
-Copyright (C) 2002-2018 OpenVPN Inc. This program is free software;
+Copyright (C) 2002-2019 OpenVPN Inc. This program is free software;
 you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2
 as published by the Free Software Foundation.
@@ -10,26 +10,30 @@ as published by the Free Software Foundation.
 QUICK START:
 
   Unix:
-    ./configure && make && make-install
+    ./configure && make && make install
 
 *************************************************************************
 
-To download OpenVPN, go to:
+To download OpenVPN source code of releases, go to:
 
-    http://openvpn.net/download.html
+    https://openvpn.net/community-downloads/
 
 OpenVPN releases are also available as Debian/RPM packages:
 
     https://community.openvpn.net/openvpn/wiki/OpenvpnSoftwareRepos
 
+OpenVPN development versions can be found here:
+
+   https://github.com/OpenVPN/openvpn
+   https://gitlab.com/OpenVPN/openvpn
+   https://sourceforge.net/p/openvpn/openvpn/ci/master/tree/
+
+They should all be in sync at any time.
+
 To download easy-rsa go to:
 
     https://github.com/OpenVPN/easy-rsa
 
-To download tap-windows (NDIS 5) driver source code go to:
-
-    https://github.com/OpenVPN/tap-windows
-
 To download tap-windows (NDIS 6) driver source code go to:
 
     https://github.com/OpenVPN/tap-windows6
@@ -40,15 +44,11 @@ To get the cross-compilation environment go to:
 
 For step-by-step instructions with real-world examples see:
 
-    http://openvpn.net/howto.html
+    https://community.openvpn.net/openvpn/wiki/GettingStartedwithOVPN
     https://community.openvpn.net/openvpn/wiki
+    https://openvpn.net/community-resources/
 
-For examples see:
-
-    http://openvpn.net/examples.html
-
-Also see the man page for more information, usage examples, and information on
-firewall configuration.
+Also see the man page for more information.
 
 *************************************************************************
 
@@ -73,7 +73,7 @@ REQUIRES:
       TUN/TAP Driver Configuration section below for more info.
 
 OPTIONAL (but recommended):
-  (1) OpenSSL library, necessary for encryption, version 0.9.8 or higher
+  (1) OpenSSL library, necessary for encryption, version 1.0.1 or higher
       required, available from http://www.openssl.org/
   (2) mbed TLS library, an alternative for encryption, version 2.0 or higher
       required, available from https://tls.mbed.org/
@@ -100,11 +100,12 @@ CHECK OUT SOURCE FROM SOURCE REPOSITORY:
   Clone the repository:
 
     git clone https://github.com/OpenVPN/openvpn
+    git clone https://gitlab.com/OpenVPN/openvpn
     git clone git://openvpn.git.sourceforge.net/gitroot/openvpn/openvpn
 
   Check out stable version:
 
-    git checkout -b 2.2 remotes/origin/release/2.2
+    git checkout release/2.4
 
   Check out master (unstable) branch:
 
@@ -134,7 +135,7 @@ BUILD A TARBALL FROM SOURCE REPOSITORY CHECKOUT:
 
 	autoreconf -i -v -f
 	./configure
-	make dist
+	make distcheck
 
 *************************************************************************
 
@@ -160,24 +161,19 @@ environment. See tests/t_client.rc-sample for details.
 OPTIONS for ./configure:
 
   --disable-lzo           disable LZO compression support [default=yes]
-  --enable-lzo-stub       don't compile LZO compression support but still
-                          allow limited interoperability with LZO-enabled
-                          peers [default=no]
+  --disable-lz4           Disable LZ4 compression support
+  --enable-comp-stub      Don't compile compression support but still allow limited interoperability with compression-enabled peers
   --disable-crypto        disable crypto support [default=yes]
-  --disable-ssl           disable SSL support for TLS-based key exchange
+  --disable-ofb-cfb       disable support for OFB and CFB cipher modes
                           [default=yes]
   --enable-x509-alt-username
                           enable the --x509-username-field feature
                           [default=no]
-  --disable-multi         disable client/server support (--mode server +
-                          client mode) [default=yes]
   --disable-server        disable server support only (but retain client
                           support) [default=yes]
   --disable-plugins       disable plug-in support [default=yes]
   --disable-management    disable management server support [default=yes]
   --enable-pkcs11         enable pkcs11 support [default=no]
-  --disable-socks         disable Socks support [default=yes]
-  --disable-http-proxy    disable HTTP proxy support [default=yes]
   --disable-fragment      disable internal fragmentation support (--fragment)
                           [default=yes]
   --disable-multihome     disable multi-homed UDP server support (--multihome)
@@ -187,44 +183,74 @@ OPTIONS for ./configure:
   --disable-debug         disable debugging support (disable gremlin and verb
                           7+ messages) [default=yes]
   --enable-small          enable smaller executable size (disable OCC, usage
-                          message, and verb 4 parm list) [default=yes]
-  --enable-password-save  allow --askpass and --auth-user-pass passwords to be
-                          read from a file [default=yes]
+                          message, and verb 4 parm list) [default=no]
   --enable-iproute2       enable support for iproute2 [default=no]
   --disable-def-auth      disable deferred authentication [default=yes]
   --disable-pf            disable internal packet filter [default=yes]
+  --disable-plugin-auth-pam
+                          disable auth-pam plugin [default=platform specific]
+  --disable-plugin-down-root
+                          disable down-root plugin [default=platform specific]
+  --enable-pam-dlopen     dlopen libpam [default=no]
   --enable-strict         enable strict compiler warnings (debugging option)
                           [default=no]
   --enable-pedantic       enable pedantic compiler warnings, will not generate
                           a working executable (debugging option) [default=no]
+  --enable-werror         promote compiler warnings to errors, will cause
+                          builds to fail if the compiler issues warnings
+                          (debugging option) [default=no]
   --enable-strict-options enable strict options check between peers (debugging
                           option) [default=no]
   --enable-selinux        enable SELinux support [default=no]
-  --enable-systemd        enable systemd suppport [default=no]
+  --enable-systemd        enable systemd support [default=no]
+  --enable-async-push     enable async-push support for plugins providing
+                          deferred authentication [default=no]
 
 ENVIRONMENT for ./configure:
 
+  PLUGINDIR   Path of plug-in directory [default=LIBDIR/openvpn/plugins]
   IFCONFIG    full path to ipconfig utility
   ROUTE       full path to route utility
   IPROUTE     full path to ip utility
   NETSTAT     path to netstat utility
   MAN2HTML    path to man2html utility
   GIT         path to git utility
+  SYSTEMD_ASK_PASSWORD
+              path to systemd-ask-password utility
+  SYSTEMD_UNIT_DIR
+              Path of systemd unit directory [default=LIBDIR/systemd/system]
+  TMPFILES_DIR
+              Path of tmpfiles directory [default=LIBDIR/tmpfiles.d]
+
+ENVIRONMENT variables adjusting parameters related to dependencies
+
   TAP_CFLAGS  C compiler flags for tap
-  OPENSSL_CFLAGS
-              C compiler flags for OpenSSL, overriding pkg-config
-  OPENSSL_LIBS
-              linker flags for OpenSSL, overriding pkg-config
-  POLARSSL_CFLAGS
-              C compiler flags for polarssl
-  POLARSSL_LIBS
-              linker flags for polarssl
-  LZO_CFLAGS  C compiler flags for lzo
-  LZO_LIBS    linker flags for lzo
+  LIBPAM_CFLAGS
+              C compiler flags for libpam
+  LIBPAM_LIBS linker flags for libpam
   PKCS11_HELPER_CFLAGS
               C compiler flags for PKCS11_HELPER, overriding pkg-config
   PKCS11_HELPER_LIBS
               linker flags for PKCS11_HELPER, overriding pkg-config
+  OPENSSL_CFLAGS
+              C compiler flags for OpenSSL
+  OPENSSL_LIBS
+              linker flags for OpenSSL
+  MBEDTLS_CFLAGS
+              C compiler flags for mbedtls
+  MBEDTLS_LIBS
+              linker flags for mbedtls
+  LZO_CFLAGS  C compiler flags for lzo
+  LZO_LIBS    linker flags for lzo
+  LZ4_CFLAGS  C compiler flags for lz4
+  LZ4_LIBS    linker flags for lz4
+  libsystemd_CFLAGS
+              C compiler flags for libsystemd, overriding pkg-config
+  libsystemd_LIBS
+              linker flags for libsystemd, overriding pkg-config
+  P11KIT_CFLAGS
+              C compiler flags for P11KIT, overriding pkg-config
+  P11KIT_LIBS linker flags for P11KIT, overriding pkg-config
 
 *************************************************************************
 
-- 
2.17.1


