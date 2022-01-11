From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 11 Jan 2022 17:06:47 +0200
Message-Id: <20220111150647.267-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH master+2.5] vcpkg-ports/pkcs11-helper:
 indicate OpenSSL EC support
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

We always build with OpenSSL >= 1.1.1, which has EC support.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 ...-vc.h.in-indicate-OpenSSL-EC-support.patch | 33 +++++++++++++++++++
 contrib/vcpkg-ports/pkcs11-helper/CONTROL     |  2 +-
 .../vcpkg-ports/pkcs11-helper/portfile.cmake  |  1 +
 3 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 contrib/vcpkg-ports/pkcs11-helper/0003-config-w32-vc.h.in-indicate-OpenSSL-EC-support.patch

diff --git a/contrib/vcpkg-ports/pkcs11-helper/0003-config-w32-vc.h.in-indicate-OpenSSL-EC-support.patch b/contrib/vcpkg-ports/pkcs11-helper/0003-config-w32-vc.h.in-indicate-OpenSSL-EC-support.patch
new file mode 100644
index 00000000..212181a7
--- /dev/null
+++ b/contrib/vcpkg-ports/pkcs11-helper/0003-config-w32-vc.h.in-indicate-OpenSSL-EC-support.patch
@@ -0,0 +1,33 @@
+From c2293864de70fec322fe7e559055530ef56b9641 Mon Sep 17 00:00:00 2001
+From: Lev Stipakov <lev@...515...>
+Date: Tue, 11 Jan 2022 13:35:42 +0200
+Subject: [PATCH] config-w32-vc.h.in: indicate OpenSSL EC support
+
+Signed-off-by: Lev Stipakov <lev@...515...>
+---
+ config-w32-vc.h.in | 12 ++++++++++++
+ 1 file changed, 12 insertions(+)
+
+diff --git a/config-w32-vc.h b/config-w32-vc.h
+index 6d94841..db83825 100644
+--- a/config-w32-vc.h
++++ b/config-w32-vc.h
+@@ -218,3 +218,15 @@
+ 
+ /* Define to 1 if you have the `DSA_SIG_set0' function. */
+ #define HAVE_DSA_SIG_SET0 1
++
++/* Define to 1 if you have the `ECDSA_SIG_set0' function. */
++#define HAVE_ECDSA_SIG_SET0 1
++
++/* Define to 1 if you have the `EC_KEY_METHOD_get_sign' function. */
++#define HAVE_EC_KEY_METHOD_GET_SIGN 1
++
++/* Define to 1 if you have the `EC_KEY_METHOD_set_sign' function. */
++#define HAVE_EC_KEY_METHOD_SET_SIGN 1
++
++/* Define to 1 if OpenSSL has EC support. */
++#define ENABLE_PKCS11H_OPENSSL_EC 1
+-- 
+2.23.0.windows.1
+
diff --git a/contrib/vcpkg-ports/pkcs11-helper/CONTROL b/contrib/vcpkg-ports/pkcs11-helper/CONTROL
index 372d420a..6a5077fd 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/CONTROL
+++ b/contrib/vcpkg-ports/pkcs11-helper/CONTROL
@@ -1,4 +1,4 @@
 Source: pkcs11-helper
-Version: 1.28-1
+Version: 1.28-3
 Homepage: https://github.com/OpenSC/pkcs11-helper
 Description: pkcs11-helper is a library that simplifies the interaction with PKCS#11 providers for end-user applications.
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
index d8dee3f6..532aa69b 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -13,6 +13,7 @@ vcpkg_extract_source_archive_ex(
     PATCHES
         0001-nmake-compatibility-with-vcpkg-nmake.patch
         0002-pkcs11.h-rename-interface-parameter.patch
+        0003-config-w32-vc.h.in-indicate-OpenSSL-EC-support.patch
         pkcs11-helper-001-RFC7512.patch
 )
 
-- 
2.23.0.windows.1


