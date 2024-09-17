From: Gert Doering <gert@...1296...>
Date: Tue, 17 Sep 2024 15:32:53 +0200
Message-ID: <20240917133253.19616-1-gert@...1296...>
In-Reply-To: <gerrit.1723546478000.I39a6f58b11b922f5dbd3e55a5bc8574eda8a83fe@...2715...>
References: <gerrit.1723546478000.I39a6f58b11b922f5dbd3e55a5bc8574eda8a83fe@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] configure: Handle libnl-genl and
 libcap-ng consistent with other libs
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

From: Frank Lichtenheld <frank@...2641...>

Do not communicate any of the flags via the global
CFLAGS and LIBS, so that users are not confused when
overriding them on the command line.

Github: closes OpenVPN/openvpn#586
Change-Id: I39a6f58b11b922f5dbd3e55a5bc8574eda8a83fe
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/724
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/configure.ac b/configure.ac
index 9ce826c..5c44822 100644
--- a/configure.ac
+++ b/configure.ac
@@ -824,8 +824,8 @@
 					   AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the development package and pkg-config ${pkg_config_found} installed? Must be version 3.4.0 or newer for DCO])
 					  ]
 				)
-				CFLAGS="${CFLAGS} ${LIBNL_GENL_CFLAGS}"
-				LIBS="${LIBS} ${LIBNL_GENL_LIBS}"
+				OPTIONAL_LIBNL_GENL_CFLAGS="${LIBNL_GENL_CFLAGS}"
+				OPTIONAL_LIBNL_GENL_LIBS="${LIBNL_GENL_LIBS}"
 
 				AC_DEFINE(ENABLE_DCO, 1, [Enable shared data channel offload])
 				AC_MSG_NOTICE([Enabled ovpn-dco support for Linux])
@@ -865,7 +865,6 @@
 dnl
 case "$host" in
 	*-*-linux*)
-		# We require pkg-config
 		PKG_CHECK_MODULES([LIBCAPNG],
 				  [libcap-ng],
 				  [],
@@ -873,8 +872,8 @@
 		)
 		AC_CHECK_HEADER([sys/prctl.h],,[AC_MSG_ERROR([sys/prctl.h not found!])])
 
-		CFLAGS="${CFLAGS} ${LIBCAPNG_CFLAGS}"
-		LIBS="${LIBS} ${LIBCAPNG_LIBS}"
+		OPTIONAL_LIBCAPNG_CFLAGS="${LIBCAPNG_CFLAGS}"
+		OPTIONAL_LIBCAPNG_LIBS="${LIBCAPNG_LIBS}"
 		AC_DEFINE(HAVE_LIBCAPNG, 1, [Enable libcap-ng support])
 	;;
 esac
@@ -1414,7 +1413,7 @@
 
 # When testing a compiler option, we add -Werror to force
 # an error when the option is unsupported. This is not
-# required for gcc, but some compilers such as clang needs it.
+# required for gcc, but some compilers such as clang need it.
 AC_DEFUN([ACL_CHECK_ADD_COMPILE_FLAGS], [
     old_cflags="$CFLAGS"
     CFLAGS="$1 -Werror $CFLAGS"
@@ -1490,6 +1489,10 @@
 AC_SUBST([OPTIONAL_SELINUX_LIBS])
 AC_SUBST([OPTIONAL_CRYPTO_CFLAGS])
 AC_SUBST([OPTIONAL_CRYPTO_LIBS])
+AC_SUBST([OPTIONAL_LIBCAPNG_CFLAGS])
+AC_SUBST([OPTIONAL_LIBCAPNG_LIBS])
+AC_SUBST([OPTIONAL_LIBNL_GENL_CFLAGS])
+AC_SUBST([OPTIONAL_LIBNL_GENL_LIBS])
 AC_SUBST([OPTIONAL_LZO_CFLAGS])
 AC_SUBST([OPTIONAL_LZO_LIBS])
 AC_SUBST([OPTIONAL_LZ4_CFLAGS])
@@ -1534,10 +1537,11 @@
 AM_CONDITIONAL([ENABLE_UNITTESTS], [test "${enable_unit_tests}" = "yes" -a "${have_cmocka}" = "yes" ])
 AC_SUBST([ENABLE_UNITTESTS])
 
-TEST_LDFLAGS="${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS}"
+TEST_LDFLAGS="${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${OPTIONAL_LIBCAPNG_LIBS}"
+TEST_LDFLAGS="${TEST_LDFLAGS} ${OPTIONAL_LIBNL_GENL_LIBS}"
 TEST_LDFLAGS="${TEST_LDFLAGS} ${OPTIONAL_LZO_LIBS} ${CMOCKA_LIBS}"
-TEST_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS}"
-TEST_CFLAGS="${TEST_CFLAGS} ${OPTIONAL_LZO_CFLAGS}"
+TEST_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${OPTIONAL_PKCS11_HELPER_CFLAGS} ${OPTIONAL_LIBCAPNG_CFLAGS}"
+TEST_CFLAGS="${TEST_CFLAGS} ${OPTIONAL_LIBNL_GENL_CFLAGS} ${OPTIONAL_LZO_CFLAGS}"
 TEST_CFLAGS="${TEST_CFLAGS} -I\$(top_srcdir)/include ${CMOCKA_CFLAGS}"
 
 AC_SUBST([TEST_LDFLAGS])
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 56cce9d..3784a98 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -24,6 +24,8 @@
 AM_CFLAGS = \
 	$(TAP_CFLAGS) \
 	$(OPTIONAL_CRYPTO_CFLAGS) \
+	$(OPTIONAL_LIBCAPNG_CFLAGS) \
+	$(OPTIONAL_LIBNL_GENL_CFLAGS) \
 	$(OPTIONAL_LZO_CFLAGS) \
 	$(OPTIONAL_LZ4_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \
@@ -147,6 +149,8 @@
 openvpn_LDADD = \
 	$(top_builddir)/src/compat/libcompat.la \
 	$(SOCKETS_LIBS) \
+	$(OPTIONAL_LIBCAPNG_LIBS) \
+	$(OPTIONAL_LIBNL_GENL_LIBS) \
 	$(OPTIONAL_LZO_LIBS) \
 	$(OPTIONAL_LZ4_LIBS) \
 	$(OPTIONAL_PKCS11_HELPER_LIBS) \

