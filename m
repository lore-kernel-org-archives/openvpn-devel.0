From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 31 Oct 2011 16:29:18 +0100
Message-ID: <1320074961-3809-6-git-send-email-dejong@...1435...>
In-Reply-To: <1320074961-3809-1-git-send-email-dejong@...1435...>
References: <1320074961-3809-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/8] Added options to switch between OpenSSL
	and PolarSSL and PKCS11...
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

at compile time. Also included the option to enable/disable PKCS11.

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 win/config.h.in |   18 +++++++++++++++---
 win/msvc.mak.in |   18 +++++++++++++++---
 win/settings.in |   13 +++++++++++++
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/win/config.h.in b/win/config.h.in
index ec447a2..e9df379 100644
--- a/win/config.h.in
+++ b/win/config.h.in
@@ -74,7 +74,9 @@ typedef unsigned long in_addr_t;
 #endif
 
 /* Enable PKCS#11 support */
-/* #define USE_PKCS11 1 */
+#if @USE_PKCS11@ != 0
+#define USE_PKCS11 1
+#endif
 
 /* Enable HTTP proxy support */
 #if @ENABLE_HTTP_PROXY@ != 0
@@ -252,7 +254,17 @@ typedef unsigned long in_addr_t;
 #define TIME_WITH_SYS_TIME 1
 #endif
 
-/* Use OpenSSL crypto library */
+/* Use the PolarSSL crypto library */
+#if @USE_POLARSSL@ != 0
+#define USE_POLARSSL 1
+#endif
+
+/* Use the OpenSSL crypto library */
+#if @USE_OPENSSL@ != 0
+#define USE_OPENSSL 1
+#endif
+
+/* Use the crypto library */
 #define USE_CRYPTO 1
 
 /* Use LZO compression library */
@@ -264,7 +276,7 @@ typedef unsigned long in_addr_t;
 /* Use lzo/ directory prefix for LZO header files (for LZO 2.0) */
 #define LZO_HEADER_DIR 1
 
-/* Use OpenSSL SSL library */
+/* Use the SSL library */
 #define USE_SSL 1
 
 /* Version number of package */
diff --git a/win/msvc.mak.in b/win/msvc.mak.in
index ac17ae9..d2babcf 100644
--- a/win/msvc.mak.in
+++ b/win/msvc.mak.in
@@ -12,16 +12,28 @@
 # - OPENSSL_DIR and LZO_DIR are dynamically created from settings.in
 
 OPENSSL = @OPENSSL_DIR@
+!ifdef INCLUDE_OPENSSL
 OPENSSL_DYNAMIC = libeay32.lib ssleay32.lib
+!endif
+
+POLARSSL = @POLARSSL_DIR@
+!ifdef INCLUDE_POLARSSL
+POLARSSL_DYNAMIC = polarssl.lib
+!endif
+
+PKCS11_HELPER = @PKCS11_HELPER_DIR@
+!ifdef INCLUDE_PKCS11
+PKCS11_HELPER_DYNAMIC = pkcs11-helper.lib
+!endif
 
 LZO = @LZO_DIR@
 LZO_DYNAMIC = lzo2.lib
 
-INCLUDE_DIRS = -I$(OPENSSL)/include -I$(LZO)/include
+INCLUDE_DIRS = -I$(OPENSSL)/include -I$(POLARSSL)/include -I$(LZO)/include -I$(PKCS11_HELPER)/include
 
-LIBS = $(OPENSSL_DYNAMIC) $(LZO_DYNAMIC) ws2_32.lib crypt32.lib iphlpapi.lib winmm.lib user32.lib gdi32.lib advapi32.lib wininet.lib
+LIBS = $(OPENSSL_DYNAMIC) $(POLARSSL_DYNAMIC) $(PKCS11_HELPER_DYNAMIC) $(LZO_DYNAMIC) ws2_32.lib crypt32.lib iphlpapi.lib winmm.lib user32.lib gdi32.lib advapi32.lib wininet.lib
 
-LIB_DIRS = -LIBPATH:$(OPENSSL)\lib -LIBPATH:$(LZO)\lib
+LIB_DIRS = -LIBPATH:$(OPENSSL)\lib -LIBPATH:$(POLARSSL)\build\library -LIBPATH:$(PKCS11_HELPER)\lib -LIBPATH:$(LZO)
 
 EXE = openvpn.exe
 
diff --git a/win/settings.in b/win/settings.in
index 10c7926..79033dd 100644
--- a/win/settings.in
+++ b/win/settings.in
@@ -33,8 +33,21 @@
 !define OPENVPN_GUI_DIR "../openvpn-gui"
 !define OPENVPN_GUI     "openvpn-gui-1.0.3.exe"
 
+# Use either PolarSSL or OpenSSL. Only one may be active at a time
+!define USE_POLARSSL 0
+!define USE_OPENSSL 1
+
+# The same as above, but for library inclusion (must be defined/undefined due to build system)
+;!define INCLUDE_POLARSSL
+!define INCLUDE_OPENSSL
+
+# Uncomment to use the PKCS#11 helper library
+!define USE_PKCS11 0
+;!define INCLUDE_PKCS11
+
 # Prebuilt libraries.  DMALLOC is optional.
 !define OPENSSL_DIR	  "../openssl"
+!define POLARSSL_DIR	  "../polarssl"
 !define LZO_DIR		  "../lzo"
 !define PKCS11_HELPER_DIR "../pkcs11-helper"
 
-- 
1.7.5.4


