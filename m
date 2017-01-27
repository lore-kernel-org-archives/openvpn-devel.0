From: Christian Hesse <list@...1798...>
Date: Fri, 27 Jan 2017 09:49:27 +0100
Message-Id: <20170127084927.21040-1-list@...1798...>
In-Reply-To: <20170126080519.GN940@...1296...>
References: <20170126080519.GN940@...1296...>
Subject: [Openvpn-devel] [PATCH 1/1] remove GNUism and fix out-of-tree build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Christian Hesse <mail@...1798...>

From: Christian Hesse <mail@...1798...>

The plugin path handling cleanup (4590c383) introduced GNUism and broke
out-of-tree builds.

Revert back to let configure generate the header file. Instead let make
add an extra CFLAG that defines PLUGIN_LIBDIR.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 configure.ac                | 2 +-
 include/Makefile.am         | 7 -------
 include/openvpn-plugin.h.in | 2 --
 src/openvpn/Makefile.am     | 4 +++-
 4 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/configure.ac b/configure.ac
index f305c54..b29f8b4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -38,7 +38,7 @@ AC_DEFINE([OPENVPN_VERSION_MINOR], [PRODUCT_VERSION_MINOR], [OpenVPN minor versi
 AC_DEFINE([OPENVPN_VERSION_PATCH], ["PRODUCT_VERSION_PATCH"], [OpenVPN patch level - may be a string or integer])
 
 AC_CONFIG_AUX_DIR([.])
-AC_CONFIG_HEADERS([config.h])
+AC_CONFIG_HEADERS([config.h include/openvpn-plugin.h])
 AC_CONFIG_SRCDIR([src/openvpn/syshead.h])
 AC_CONFIG_MACRO_DIR([m4])
 
diff --git a/include/Makefile.am b/include/Makefile.am
index 37962a6..a52c427 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -16,10 +16,3 @@ MAINTAINERCLEANFILES = \
 include_HEADERS = \
 	openvpn-plugin.h \
 	openvpn-msg.h
-
-openvpn-plugin.h: openvpn-plugin.h.in Makefile
-	$(AM_V_GEN)sed -e 's|\@PLUGINDIR\@|$(plugindir)|' \
-		-e 's|\@OPENVPN_VERSION_MAJOR\@|$(OPENVPN_VERSION_MAJOR)|' \
-		-e 's|\@OPENVPN_VERSION_MINOR\@|$(OPENVPN_VERSION_MINOR)|' \
-		-e 's|\@OPENVPN_VERSION_PATCH\@|$(OPENVPN_VERSION_PATCH)|' \
-               $< > $@.tmp && mv $@.tmp $@
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index a084fc1..0b30352 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -27,8 +27,6 @@
 
 #define OPENVPN_PLUGIN_VERSION 3
 
-#define PLUGIN_LIBDIR "@PLUGINDIR@"
-
 #ifdef ENABLE_CRYPTO
 #ifdef ENABLE_CRYPTO_MBEDTLS
 #include <mbedtls/x509_crt.h>
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index bea294b..3f97855 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -27,7 +27,9 @@ AM_CFLAGS = \
 	$(OPTIONAL_CRYPTO_CFLAGS) \
 	$(OPTIONAL_LZO_CFLAGS) \
 	$(OPTIONAL_LZ4_CFLAGS) \
-	$(OPTIONAL_PKCS11_HELPER_CFLAGS)
+	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \
+	-DPLUGIN_LIBDIR=\"${plugindir}\"
+
 if WIN32
 # we want unicode entry point but not the macro
 AM_CFLAGS += -municode -UUNICODE
-- 
2.11.0


