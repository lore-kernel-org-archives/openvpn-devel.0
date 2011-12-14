From: samuli@...515...
Date: Wed, 14 Dec 2011 10:36:22 +0200
Message-Id: <1323851782-27037-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Backported pkcs11-related parts of
	7a8d707237bb18 to 2.2 branch
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

Fixes https://community.openvpn.net/openvpn/ticket/145
---
 win/config.h.in |    4 +++-
 win/msvc.mak.in |   11 ++++++++---
 win/settings.in |    4 ++++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/win/config.h.in b/win/config.h.in
index 82344a0..09263d3 100644
--- a/win/config.h.in
+++ b/win/config.h.in
@@ -74,7 +74,9 @@ typedef unsigned long in_addr_t;
 #endif
=20
 /* Enable PKCS#11 support */
-/* #define USE_PKCS11 1 */
+#if @USE_PKCS11@ !=3D 0
+#define USE_PKCS11 1
+#endif
=20
 /* Enable HTTP proxy support */
 #if @ENABLE_HTTP_PROXY@ !=3D 0
diff --git a/win/msvc.mak.in b/win/msvc.mak.in
index ac17ae9..7979b5e 100644
--- a/win/msvc.mak.in
+++ b/win/msvc.mak.in
@@ -14,14 +14,19 @@
 OPENSSL =3D @OPENSSL_DIR@
 OPENSSL_DYNAMIC =3D libeay32.lib ssleay32.lib
=20
+PKCS11_HELPER =3D @PKCS11_HELPER_DIR@
+!ifdef INCLUDE_PKCS11
+PKCS11_HELPER_DYNAMIC =3D pkcs11-helper.lib
+!endif
+
 LZO =3D @LZO_DIR@
 LZO_DYNAMIC =3D lzo2.lib
=20
-INCLUDE_DIRS =3D -I$(OPENSSL)/include -I$(LZO)/include
+INCLUDE_DIRS =3D -I$(OPENSSL)/include -I$(LZO)/include -I$(PKCS11_HELPER)/=
include
=20
-LIBS =3D $(OPENSSL_DYNAMIC) $(LZO_DYNAMIC) ws2_32.lib crypt32.lib iphlpapi=
.lib winmm.lib user32.lib gdi32.lib advapi32.lib wininet.lib
+LIBS =3D $(OPENSSL_DYNAMIC) $(PKCS11_HELPER_DYNAMIC) $(LZO_DYNAMIC) ws2_32=
.lib crypt32.lib iphlpapi.lib winmm.lib user32.lib gdi32.lib advapi32.lib w=
ininet.lib
=20
-LIB_DIRS =3D -LIBPATH:$(OPENSSL)\lib -LIBPATH:$(LZO)\lib
+LIB_DIRS =3D -LIBPATH:$(OPENSSL)\lib -LIBPATH:$(PKCS11_HELPER)\lib -LIBPAT=
H:$(LZO)\lib
=20
 EXE =3D openvpn.exe
=20
diff --git a/win/settings.in b/win/settings.in
index 10c7926..a197fb8 100644
--- a/win/settings.in
+++ b/win/settings.in
@@ -33,6 +33,10 @@
 !define OPENVPN_GUI_DIR "../openvpn-gui"
 !define OPENVPN_GUI     "openvpn-gui-1.0.3.exe"
=20
+# Uncomment to use the PKCS#11 helper library
+!define USE_PKCS11 0
+;!define INCLUDE_PKCS11
+
 # Prebuilt libraries.  DMALLOC is optional.
 !define OPENSSL_DIR	  "../openssl"
 !define LZO_DIR		  "../lzo"
--=20
1.7.4.1


