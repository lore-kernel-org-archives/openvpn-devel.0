From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 11 Jan 2022 17:06:05 +0200
Message-Id: <20220111150605.208-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH master+2.5] vcpkg-ports/pkcs11-helper: bump
 to release 1.28
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

This release has merged openssl 1.1.1 support patch,
so our own patch could be removed from the port.

Remove unconditional /release flag, which is added by vcpkg
for release builds. Having this flag unconditionally breaks vcpkg
debug builds.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 ...make-compatibility-with-vcpkg-nmake.patch} |  8 +-
 .../0001-nmake-openssl-1.1.1-support.patch    | 88 -------------------
 ...-pkcs11.h-rename-interface-parameter.patch | 32 +++++++
 contrib/vcpkg-ports/pkcs11-helper/CONTROL     |  2 +-
 .../vcpkg-ports/pkcs11-helper/portfile.cmake  |  8 +-
 5 files changed, 41 insertions(+), 97 deletions(-)
 rename contrib/vcpkg-ports/pkcs11-helper/{0002-nmake-compatibility-with-vcpkg-nmake.patch => 0001-nmake-compatibility-with-vcpkg-nmake.patch} (81%)
 delete mode 100644 contrib/vcpkg-ports/pkcs11-helper/0001-nmake-openssl-1.1.1-support.patch
 create mode 100644 contrib/vcpkg-ports/pkcs11-helper/0002-pkcs11.h-rename-interface-parameter.patch

diff --git a/contrib/vcpkg-ports/pkcs11-helper/0002-nmake-compatibility-with-vcpkg-nmake.patch b/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-compatibility-with-vcpkg-nmake.patch
similarity index 81%
rename from contrib/vcpkg-ports/pkcs11-helper/0002-nmake-compatibility-with-vcpkg-nmake.patch
rename to contrib/vcpkg-ports/pkcs11-helper/0001-nmake-compatibility-with-vcpkg-nmake.patch
index a6034f7e..add47093 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/0002-nmake-compatibility-with-vcpkg-nmake.patch
+++ b/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-compatibility-with-vcpkg-nmake.patch
@@ -1,6 +1,6 @@
-From 68d12f3e955cc9df435e9289b1244a4c1f24b96b Mon Sep 17 00:00:00 2001
+From 2d3a2c05383f653544b9c7194dd1349c6d5f3067 Mon Sep 17 00:00:00 2001
 From: Lev Stipakov <lev@...515...>
-Date: Wed, 24 Nov 2021 11:21:36 +0200
+Date: Tue, 11 Jan 2022 13:24:51 +0200
 Subject: [PATCH] nmake: compatibility with vcpkg nmake
 
 Remove options which contradict or already set
@@ -12,7 +12,7 @@ Signed-off-by: Lev Stipakov <lev@...515...>
  1 file changed, 2 insertions(+), 6 deletions(-)
 
 diff --git a/lib/Makefile.w32-vc b/lib/Makefile.w32-vc
-index 0e64f42..18af03b 100644
+index 96f1f89..be68a00 100644
 --- a/lib/Makefile.w32-vc
 +++ b/lib/Makefile.w32-vc
 @@ -75,15 +75,11 @@ OPENSSL_LIBS=-LIBPATH:$(OPENSSL_LIB) user32.lib advapi32.lib $(OPENSSL_STATIC)
@@ -27,7 +27,7 @@ index 0e64f42..18af03b 100644
  
  LINK32=link.exe
  LIB32=lib.exe
--LINK32_FLAGS=/nologo /subsystem:windows /dll /incremental:no
+-LINK32_FLAGS=/nologo /subsystem:windows /dll /incremental:no /release
 -LIB32_FLAGS=/nologo
 +LINK32_FLAGS=/dll
  
diff --git a/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-openssl-1.1.1-support.patch b/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-openssl-1.1.1-support.patch
deleted file mode 100644
index d1942a98..00000000
--- a/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-openssl-1.1.1-support.patch
+++ /dev/null
@@ -1,88 +0,0 @@
-From 324026ce179468fcea348e59259dbc5456438ead Mon Sep 17 00:00:00 2001
-From: Lev Stipakov <lev@...515...>
-Date: Fri, 14 May 2021 14:35:53 +0300
-Subject: [PATCH] nmake: openssl 1.1.1 support
-
-Starting from version 1.1.1, OpenSSL includes routines
-like RSA_meth_xxx and DSA_meth_xxx. pkcs11-helper includes
-implementation of those routines. That code is compiled if
-they're missing from OpenSSL.
-
-nmake build uses pre-generated config-w32-vc.h, which lacks
-defines which indicate that OpenSSL includes above routines,
-which causes pkcs11's own implementaion to be compiled. However,
-pkcs11-helper implementation is not compatible with OpenSSL 1.1.1 -
-for example, it takes size of opaque struct RSA_METHOD, which
-has become internal in OpenSSL.
-
-This adds necessary defines to config header used by nmake build
-so that pkcs11-helper code, which is not compatible with OpenSSL 1.1.1,
-is not compiled.
-
-Also libeay is changed to libcrypto.
-
-Signed-off-by: Lev Stipakov <lev@...515...>
----
- config-w32-vc.h.in  | 33 +++++++++++++++++++++++++++++++++
- lib/Makefile.w32-vc |  4 ++--
- 2 files changed, 35 insertions(+), 2 deletions(-)
-
-diff --git a/config-w32-vc.h b/config-w32-vc.h
-index 6346f02..102b2e3 100644
---- a/config-w32-vc.h
-+++ b/config-w32-vc.h
-@@ -185,3 +185,36 @@
- #if _MSC_VER >= 1400
- #define HAVE_CPP_VARARG_MACRO_ISO 1
- #endif
-+
-+/* Define to 1 if you have the `RSA_meth_dup' function. */
-+#define HAVE_RSA_METH_DUP 1
-+
-+/* Define to 1 if you have the `RSA_meth_free' function. */
-+#define HAVE_RSA_METH_FREE 1
-+
-+/* Define to 1 if you have the `RSA_meth_set1_name' function. */
-+#define HAVE_RSA_METH_SET1_NAME 1
-+
-+/* Define to 1 if you have the `RSA_meth_set_flags' function. */
-+#define HAVE_RSA_METH_SET_FLAGS 1
-+
-+/* Define to 1 if you have the `RSA_meth_set_priv_dec' function. */
-+#define HAVE_RSA_METH_SET_PRIV_DEC 1
-+
-+/* Define to 1 if you have the `RSA_meth_set_priv_enc' function. */
-+#define HAVE_RSA_METH_SET_PRIV_ENC 1
-+
-+/* Define to 1 if you have the `DSA_meth_dup' function. */
-+#define HAVE_DSA_METH_DUP 1
-+
-+/* Define to 1 if you have the `DSA_meth_free' function. */
-+#define HAVE_DSA_METH_FREE 1
-+
-+/* Define to 1 if you have the `DSA_meth_set1_name' function. */
-+#define HAVE_DSA_METH_SET1_NAME 1
-+
-+/* Define to 1 if you have the `DSA_meth_set_sign' function. */
-+#define HAVE_DSA_METH_SET_SIGN 1
-+
-+/* Define to 1 if you have the `DSA_SIG_set0' function. */
-+#define HAVE_DSA_SIG_SET0 1
-diff --git a/lib/Makefile.w32-vc b/lib/Makefile.w32-vc
-index 2edab39..b2ac746 100644
---- a/lib/Makefile.w32-vc
-+++ b/lib/Makefile.w32-vc
-@@ -60,9 +60,9 @@ OPENSSL_HOME = ..\..\openssl-0.9.8a
- !endif
- 
- !ifdef OPENSSL
--OPENSSL_STATIC = libeay32.lib
-+OPENSSL_STATIC = libcrypto.lib
- #OPENSSL_STATIC = libeay32sd.lib
--OPENSSL_DYNAMIC = libeay32.lib
-+OPENSSL_DYNAMIC = libcrypto.lib
- #OPENSSL_DYNAMIC = libeay32d.lib
- 
- OPENSSL_INC=$(OPENSSL_HOME)\include
--- 
-2.23.0.windows.1
diff --git a/contrib/vcpkg-ports/pkcs11-helper/0002-pkcs11.h-rename-interface-parameter.patch b/contrib/vcpkg-ports/pkcs11-helper/0002-pkcs11.h-rename-interface-parameter.patch
new file mode 100644
index 00000000..13c60d9d
--- /dev/null
+++ b/contrib/vcpkg-ports/pkcs11-helper/0002-pkcs11.h-rename-interface-parameter.patch
@@ -0,0 +1,32 @@
+From 0c2f862fe23dc6d2c0ca8432d1f6027c922c5a04 Mon Sep 17 00:00:00 2001
+From: Lev Stipakov <lev@...515...>
+Date: Tue, 11 Jan 2022 14:24:45 +0200
+Subject: [PATCH] pkcs11.h: rename "interface" parameter
+
+"interface" is defined in cobaseapi.h as
+
+  #define interface __STRUCT__
+
+so use different name.
+
+Signed-off-by: Lev Stipakov <lev@...515...>
+---
+ include/pkcs11-helper-1.0/pkcs11.h | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/include/pkcs11-helper-1.0/pkcs11.h b/include/pkcs11-helper-1.0/pkcs11.h
+index 85aa98e..7a7b958 100644
+--- a/include/pkcs11-helper-1.0/pkcs11.h
++++ b/include/pkcs11-helper-1.0/pkcs11.h
+@@ -1210,7 +1210,7 @@ _CK_DECLARE_FUNCTION (C_GetInterfaceList,
+ _CK_DECLARE_FUNCTION (C_GetInterface,
+ 		      (unsigned char *interface_name,
+ 		       struct ck_version *version,
+-		       struct ck_interface **interface,
++		       struct ck_interface **iface,
+ 		       ck_flags_t flags));
+ 
+ _CK_DECLARE_FUNCTION (C_LoginUser,
+-- 
+2.23.0.windows.1
+
diff --git a/contrib/vcpkg-ports/pkcs11-helper/CONTROL b/contrib/vcpkg-ports/pkcs11-helper/CONTROL
index 01831802..372d420a 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/CONTROL
+++ b/contrib/vcpkg-ports/pkcs11-helper/CONTROL
@@ -1,4 +1,4 @@
 Source: pkcs11-helper
-Version: 1.27-1
+Version: 1.28-1
 Homepage: https://github.com/OpenSC/pkcs11-helper
 Description: pkcs11-helper is a library that simplifies the interaction with PKCS#11 providers for end-user applications.
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
index ad19fccb..d8dee3f6 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -1,9 +1,9 @@
-set(VERSION 1.27)
+set(VERSION 1.28)
 
 vcpkg_download_distfile(ARCHIVE
     URLS "https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-${VERSION}/pkcs11-helper-${VERSION}.0.tar.bz2"
     FILENAME "pkcs11-helper-${VERSION}.tar.bz2"
-    SHA512 5799342cb755dae8b7ba0880d652e9d4b4f1e52a74043015e1185e1e059326cb2689bb51957db98060ac2257dee34e2f047dcf3d52ad59fd49b91fedcfc5332b
+    SHA512 11b8e554d9223ab9305a3ad7e2b6a9bbece1c09ca8d49276618dec31eefdccf6a32b0db85a28a90334ea42fe809beec83514a31930b79bdbefa368ed4658945b
 )
 
 vcpkg_extract_source_archive_ex(
@@ -11,8 +11,8 @@ vcpkg_extract_source_archive_ex(
     ARCHIVE ${ARCHIVE}
     REF ${VERSION}
     PATCHES
-        0001-nmake-openssl-1.1.1-support.patch
-        0002-nmake-compatibility-with-vcpkg-nmake.patch
+        0001-nmake-compatibility-with-vcpkg-nmake.patch
+        0002-pkcs11.h-rename-interface-parameter.patch
         pkcs11-helper-001-RFC7512.patch
 )
 
-- 
2.23.0.windows.1


