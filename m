From: Gert Doering <gert@...1296...>
Date: Thu,  4 Jan 2024 17:30:21 +0100
Message-ID: <20240104163022.22875-1-gert@...1296...>
In-Reply-To: <gerrit.1701436335000.Iebaa35a23e217a4cd7739af229cbfc08a3d8854a@...2715...>
References: <gerrit.1701436335000.Iebaa35a23e217a4cd7739af229cbfc08a3d8854a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Make it more explicit and visible when
 pkg-config is not found
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

From: Arne Schwabe <arne@...1227...>

Users seem to struggle to read the full error message. This adds an
indication if pkg-config is actually found to the warning/error message
that use pkg-config.

On platforms that do not require pkg-config and for optional libraries,
the existence of pkg-config is mentioned as part of the error/warning message.

When found:

    configure: error: libnl-genl-3.0 package not found or too old. Is the development package and pkg-config (using /usr/bin/pkg-config) installed? Must be version 3.4.0 or newer for DCO

not found:

    configure: error: libnl-genl-3.0 package not found or too old. Is the development package and pkg-config (not found) installed? Must be version 3.4.0 or newer for DCO

On platforms where pkg-config is required (only Linux at the moment),
configure will abort when not detecting pkg-config:

checking for pkg-config... no
configure: error: pkg-config is required

Change-Id: Iebaa35a23e217a4cd7739af229cbfc08a3d8854a
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/465
This mail reflects revision 3 of this Change.
Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/configure.ac b/configure.ac
index f420612..f009fe2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -323,6 +323,7 @@
 		AM_CONDITIONAL([TARGET_LINUX], [true])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["L"], [Target prefix])
 		have_sitnl="yes"
+		pkg_config_required="yes"
 		;;
 	*-*-solaris*)
 		AC_DEFINE([TARGET_SOLARIS], [1], [Are we running on Solaris?])
@@ -376,6 +377,16 @@
 AM_CONDITIONAL([CROSS_COMPILING], test "${cross_compiling}" = "yes")
 
 PKG_PROG_PKG_CONFIG
+# Add variable to print if pkg-config is found or not. Users often miss that
+if test "${PKG_CONFIG}" = ""; then
+    if test "${pkg_config_required}" = "yes"; then
+        AC_MSG_ERROR([pkg-config is required])
+    fi
+	pkg_config_found="(not found)"
+else
+	pkg_config_found="(using ${PKG_CONFIG})"
+fi
+
 AC_PROG_CPP
 AC_PROG_INSTALL
 AC_PROG_LN_S
@@ -810,7 +821,7 @@
 					  [libnl-genl-3.0 >= 3.4.0],
 					  [have_libnl="yes"],
 					  [
-					   AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the development package and pkg-config installed? Must be version 3.4.0 or newer for DCO])
+					   AC_MSG_ERROR([libnl-genl-3.0 package not found or too old. Is the development package and pkg-config ${pkg_config_found} installed? Must be version 3.4.0 or newer for DCO])
 					  ]
 				)
 				CFLAGS="${CFLAGS} ${LIBNL_GENL_CFLAGS}"
@@ -854,10 +865,11 @@
 dnl
 case "$host" in
 	*-*-linux*)
+		# We require pkg-config
 		PKG_CHECK_MODULES([LIBCAPNG],
 				  [libcap-ng],
 				  [],
-				  [AC_MSG_ERROR([libcap-ng package not found. Is the development package and pkg-config installed?])]
+				  [AC_MSG_ERROR([libcap-ng package not found. Is the development package and pkg-config ${pkg_config_found} installed?])]
 		)
 		AC_CHECK_HEADER([sys/prctl.h],,[AC_MSG_ERROR([sys/prctl.h not found!])])
 
@@ -878,7 +890,7 @@
 			[OPENSSL],
 			[openssl >= 1.0.2],
 			[have_openssl="yes"],
-			[] # If this fails, we will do another test next
+			[AC_MSG_WARN([OpenSSL not found by pkg-config ${pkg_config_found}])] # If this fails, we will do another test next
 		)
 		OPENSSL_LIBS=${OPENSSL_LIBS:--lssl -lcrypto}
 	fi
@@ -1083,7 +1095,7 @@
 			[WOLFSSL],
 			[wolfssl],
 			[],
-			[AC_MSG_ERROR([Could not find wolfSSL.])]
+			[AC_MSG_ERROR([Could not find wolfSSL using pkg-config ${pkg_config_found}])]
 		)
 		PKG_CHECK_VAR(
 			[WOLFSSL_INCLUDEDIR],
@@ -1508,7 +1520,7 @@
 PKG_CHECK_MODULES(
 	[CMOCKA], [cmocka],
 	[have_cmocka="yes"],
-	[AC_MSG_WARN([cmocka.pc not found on the system.  Unit tests disabled])]
+	[AC_MSG_WARN([cmocka.pc not found on the system using pkg-config ${pkg_config_found}.  Unit tests disabled])]
 )
 AM_CONDITIONAL([ENABLE_UNITTESTS], [test "${enable_unit_tests}" = "yes" -a "${have_cmocka}" = "yes" ])
 AC_SUBST([ENABLE_UNITTESTS])

