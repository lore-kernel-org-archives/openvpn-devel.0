From: Marc Becker <becm@...68...>
Date: Sat, 23 Apr 2022 15:57:04 +0200
Message-Id: <20220423135704.88164-1-becm@...68...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] vcpkg-ports/pkcs11-helper: bump to release
 1.29
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

This release has merged win32 support patch,
so our own patch could be removed from the port.

Upstream archive format changed back to BZIP2.

Signed-off-by: Marc Becker <becm@...68...>
---
 ...config-w32-vc.h.in-indicate-OpenSSL.patch} |  0
 ...-pkcs11.h-rename-interface-parameter.patch | 32 -------------------
 contrib/vcpkg-ports/pkcs11-helper/CONTROL     |  2 +-
 .../vcpkg-ports/pkcs11-helper/portfile.cmake  | 11 +++----
 4 files changed, 6 insertions(+), 39 deletions(-)
 rename contrib/vcpkg-ports/pkcs11-helper/{0003-config-w32-vc.h.in-indicate=
-OpenSSL.patch =3D> 0002-config-w32-vc.h.in-indicate-OpenSSL.patch} (100%)
 delete mode 100644 contrib/vcpkg-ports/pkcs11-helper/0002-pkcs11.h-rename-=
interface-parameter.patch

diff --git a/contrib/vcpkg-ports/pkcs11-helper/0003-config-w32-vc.h.in-indi=
cate-OpenSSL.patch b/contrib/vcpkg-ports/pkcs11-helper/0002-config-w32-vc.h=
.in-indicate-OpenSSL.patch
similarity index 100%
rename from contrib/vcpkg-ports/pkcs11-helper/0003-config-w32-vc.h.in-indic=
ate-OpenSSL.patch
rename to contrib/vcpkg-ports/pkcs11-helper/0002-config-w32-vc.h.in-indicat=
e-OpenSSL.patch
diff --git a/contrib/vcpkg-ports/pkcs11-helper/0002-pkcs11.h-rename-interfa=
ce-parameter.patch b/contrib/vcpkg-ports/pkcs11-helper/0002-pkcs11.h-rename=
-interface-parameter.patch
deleted file mode 100644
index 13c60d9d..00000000
--- a/contrib/vcpkg-ports/pkcs11-helper/0002-pkcs11.h-rename-interface-para=
meter.patch
+++ /dev/null
@@ -1,32 +0,0 @@
-From 0c2f862fe23dc6d2c0ca8432d1f6027c922c5a04 Mon Sep 17 00:00:00 2001
-From: Lev Stipakov <lev@...515...>
-Date: Tue, 11 Jan 2022 14:24:45 +0200
-Subject: [PATCH] pkcs11.h: rename "interface" parameter
-
-"interface" is defined in cobaseapi.h as
-
-  #define interface __STRUCT__
-
-so use different name.
-
-Signed-off-by: Lev Stipakov <lev@...515...>
----
- include/pkcs11-helper-1.0/pkcs11.h | 2 +-
- 1 file changed, 1 insertion(+), 1 deletion(-)
-
-diff --git a/include/pkcs11-helper-1.0/pkcs11.h b/include/pkcs11-helper-1.=
0/pkcs11.h
-index 85aa98e..7a7b958 100644
---- a/include/pkcs11-helper-1.0/pkcs11.h
-+++ b/include/pkcs11-helper-1.0/pkcs11.h
-@@ -1210,7 +1210,7 @@ _CK_DECLARE_FUNCTION (C_GetInterfaceList,
- _CK_DECLARE_FUNCTION (C_GetInterface,
- 		      (unsigned char *interface_name,
- 		       struct ck_version *version,
--		       struct ck_interface **interface,
-+		       struct ck_interface **iface,
- 		       ck_flags_t flags));
-
- _CK_DECLARE_FUNCTION (C_LoginUser,
---
-2.23.0.windows.1
-
diff --git a/contrib/vcpkg-ports/pkcs11-helper/CONTROL b/contrib/vcpkg-port=
s/pkcs11-helper/CONTROL
index ff116364..1ead697e 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/CONTROL
+++ b/contrib/vcpkg-ports/pkcs11-helper/CONTROL
@@ -1,4 +1,4 @@
 Source: pkcs11-helper
-Version: 1.28-4
+Version: 1.29-1
 Homepage: https://github.com/OpenSC/pkcs11-helper
 Description: pkcs11-helper is a library that simplifies the interaction wi=
th PKCS#11 providers for end-user applications.
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcp=
kg-ports/pkcs11-helper/portfile.cmake
index 6008f615..a19ea254 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -1,9 +1,9 @@
-set(VERSION 1.28.0)
+set(VERSION 1.29.0)

 vcpkg_download_distfile(ARCHIVE
-    URLS "https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11=
-helper-${VERSION}/pkcs11-helper-${VERSION}.tar.gz"
-    FILENAME "pkcs11-helper-${VERSION}.tar.gz"
-    SHA512 1c1cc7f83ed360fabdcfa68d0eafa7d25be03e68c6a202e7ad2907feb472663=
bb34e12b9e162344ec221a4298abc02acdc75f0f45d9a89657aa7ac55e59badd5
+    URLS "https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11=
-helper-${VERSION}/pkcs11-helper-${VERSION}.tar.bz2"
+    FILENAME "pkcs11-helper-${VERSION}.tar.bz2"
+    SHA512 c530f5a4b5826a02bfe787a1293a7595d5a0d6348daa16675bd10c6d6734b1f=
24a3cc73b5b89433cf1edf8815f8b7298fdfd1ed686f096bb5edfb425e9430eb2
 )

 vcpkg_extract_source_archive_ex(
@@ -12,8 +12,7 @@ vcpkg_extract_source_archive_ex(
     REF ${VERSION}
     PATCHES
         0001-nmake-compatibility-with-vcpkg-nmake.patch
-        0002-pkcs11.h-rename-interface-parameter.patch
-        0003-config-w32-vc.h.in-indicate-OpenSSL.patch
+        0002-config-w32-vc.h.in-indicate-OpenSSL.patch
         pkcs11-helper-001-RFC7512.patch
 )

--
2.30.2


