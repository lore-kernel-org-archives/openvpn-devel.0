From: Gert Doering <gert@...1296...>
Date: Wed, 18 Sep 2024 22:45:50 +0200
Message-ID: <20240918204551.2530-1-gert@...1296...>
In-Reply-To: <gerrit.1720619824000.I7927a572611b7c1dc0b522fd6cdf05fd222a852d@...2715...>
References: <gerrit.1720619824000.I7927a572611b7c1dc0b522fd6cdf05fd222a852d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] configure: Review use of standard AC
 macros
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

- Increase required version to 2.60 since that is documented
  minimum version for AC_USE_SYSTEM_EXTENSIONS
- Remove obsolete macros AC_C_CONST and AC_C_VOLATILE. They
  are noops on every compiler we support.
- Add explicit call to AC_PROG_CC. We get this implictly as
  dependency of other macros, but it is nicer to have it
  explicitely as well.
- A few typo and whitespace fixes.

Change-Id: I7927a572611b7c1dc0b522fd6cdf05fd222a852d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/674
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/configure.ac b/configure.ac
index 9ce826c..18538c5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -23,7 +23,7 @@
 
 dnl Process this file with autoconf to produce a configure script.
 
-AC_PREREQ(2.59)
+AC_PREREQ(2.60)
 
 m4_include(version.m4)
 AC_INIT([PRODUCT_NAME], [PRODUCT_VERSION], [PRODUCT_BUGREPORT], [PRODUCT_TARNAME])
@@ -387,6 +387,7 @@
 	pkg_config_found="(${PKG_CONFIG})"
 fi
 
+AC_PROG_CC
 AC_PROG_CPP
 AC_PROG_INSTALL
 AC_PROG_LN_S
@@ -443,9 +444,7 @@
 	]
 )
 
-AC_C_CONST
 AC_C_INLINE
-AC_C_VOLATILE
 AC_TYPE_OFF_T
 AC_TYPE_PID_T
 AC_TYPE_SIZE_T
@@ -981,7 +980,7 @@
 		[AC_MSG_ERROR([OpenSSL check for AES-256-GCM support failed])]
 	)
 
-	# All supported OpenSSL version (>= 1.1.0)
+	# All supported OpenSSL versions (>= 1.1.0)
 	# have this feature
 	have_export_keying_material="yes"
 
@@ -1081,9 +1080,8 @@
 
 elif test "${with_crypto_library}" = "wolfssl"; then
 	AC_ARG_VAR([WOLFSSL_CFLAGS], [C compiler flags for wolfssl. The include directory should
-								  contain the regular wolfSSL header files but also the
-								  wolfSSL OpenSSL header files. Ex: -I/usr/local/include
-								  -I/usr/local/include/wolfssl])
+ contain the regular wolfSSL header files but also the wolfSSL OpenSSL header files.
+ Ex: -I/usr/local/include -I/usr/local/include/wolfssl])
 	AC_ARG_VAR([WOLFSSL_LIBS], [linker flags for wolfssl])
 
 	saved_CFLAGS="${CFLAGS}"
@@ -1274,7 +1272,7 @@
                       [PKG_CHECK_MODULES([libsystemd], [libsystemd-daemon])]
                       )
 
-    PKG_CHECK_EXISTS( [libsystemd > 216],
+    PKG_CHECK_EXISTS([libsystemd > 216],
                      [AC_DEFINE([SYSTEMD_NEWER_THAN_216], [1],
                            [systemd is newer than v216])]
                     )

