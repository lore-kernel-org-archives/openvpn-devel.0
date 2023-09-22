From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 22 Sep 2023 18:03:24 +0200
Message-Id: <20230922160324.166907-1-frank@...2641...>
In-Reply-To: <gerrit.1689947729000.Ie61fed8758e44576939a8bb0a04bc95245a3ce18@...2715...>
References: <gerrit.1689947729000.Ie61fed8758e44576939a8bb0a04bc95245a3ce18@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] vcpkg-ports/pkcs11-helper: Backport MinGW
 series from master to release/2.6
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
Cc: Heiko Hund <heiko@...515...>

Contains the following commits:
- Make compatible with mingw build
  (commit 17746e53f65249b42017256056c5415099df288d)
- Convert CONTROL to vcpkg.json
  (commit a2160d3e42a1eff59aee3d984fd3354907f4379f)
- reference upstream PRs in patches
  (commit 9577ffe92f033d8452cff0a3dbdfdc943655c5b8)
- rename patches to make file names shorter
  (commit 0c25a5462e945f537d1836b47a5f147a2132875c)

Change-Id: Ie61fed8758e44576939a8bb0a04bc95245a3ce18
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Heiko Hund <heiko@...515...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/311
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@...515...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 4766efd..8a80c67 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -441,6 +441,7 @@
         uses: lukka/run-vcpkg@...2637...
         with:
           vcpkgGitCommitId: 'd10d511f25620ca0f315cd83dcef6485efc63010'
+          vcpkgJsonGlob: '**/openvpn/vcpkg.json'
           appendedCacheKey: '${{matrix.triplet}}'
 
       - name: Run MSBuild consuming vcpkg.json
diff --git a/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-compatibility-with-vcpkg-nmake.patch b/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-compatibility-with-vcpkg-nmake.patch
deleted file mode 100644
index add4709..0000000
--- a/contrib/vcpkg-ports/pkcs11-helper/0001-nmake-compatibility-with-vcpkg-nmake.patch
+++ /dev/null
@@ -1,38 +0,0 @@
-From 2d3a2c05383f653544b9c7194dd1349c6d5f3067 Mon Sep 17 00:00:00 2001
-From: Lev Stipakov <lev@...515...>
-Date: Tue, 11 Jan 2022 13:24:51 +0200
-Subject: [PATCH] nmake: compatibility with vcpkg nmake
-
-Remove options which contradict or already set
-by vcpkg nmake scripts.
-
-Signed-off-by: Lev Stipakov <lev@...515...>
----
- lib/Makefile.w32-vc | 8 ++------
- 1 file changed, 2 insertions(+), 6 deletions(-)
-
-diff --git a/lib/Makefile.w32-vc b/lib/Makefile.w32-vc
-index 96f1f89..be68a00 100644
---- a/lib/Makefile.w32-vc
-+++ b/lib/Makefile.w32-vc
-@@ -75,15 +75,11 @@ OPENSSL_LIBS=-LIBPATH:$(OPENSSL_LIB) user32.lib advapi32.lib $(OPENSSL_STATIC)
- CFLAGS = -I../include $(OPENSSL_CFLAGS) -DWIN32 -DWIN32_LEAN_AND_MEAN -D_MBCS -D_CRT_SECURE_NO_DEPRECATE -D_WIN32_WINNT=0x0400
- CC=cl.exe
- RC=rc.exe
--CCPARAMS=/nologo /W3 /O2 /FD /c
--
--CCPARAMS=$(CCPARAMS) /MD
--CFLAGS=$(CFLAGS) -DNDEBUG
-+CCPARAMS=/c
- 
- LINK32=link.exe
- LIB32=lib.exe
--LINK32_FLAGS=/nologo /subsystem:windows /dll /incremental:no /release
--LIB32_FLAGS=/nologo
-+LINK32_FLAGS=/dll
- 
- HEADERS = \
- 	config.h \
--- 
-2.23.0.windows.1
-
diff --git a/contrib/vcpkg-ports/pkcs11-helper/0002-config-w32-vc.h.in-indicate-OpenSSL.patch b/contrib/vcpkg-ports/pkcs11-helper/0002-config-w32-vc.h.in-indicate-OpenSSL.patch
deleted file mode 100644
index 212181a..0000000
--- a/contrib/vcpkg-ports/pkcs11-helper/0002-config-w32-vc.h.in-indicate-OpenSSL.patch
+++ /dev/null
@@ -1,33 +0,0 @@
-From c2293864de70fec322fe7e559055530ef56b9641 Mon Sep 17 00:00:00 2001
-From: Lev Stipakov <lev@...515...>
-Date: Tue, 11 Jan 2022 13:35:42 +0200
-Subject: [PATCH] config-w32-vc.h.in: indicate OpenSSL EC support
-
-Signed-off-by: Lev Stipakov <lev@...515...>
----
- config-w32-vc.h.in | 12 ++++++++++++
- 1 file changed, 12 insertions(+)
-
-diff --git a/config-w32-vc.h b/config-w32-vc.h
-index 6d94841..db83825 100644
---- a/config-w32-vc.h
-+++ b/config-w32-vc.h
-@@ -218,3 +218,15 @@
- 
- /* Define to 1 if you have the `DSA_SIG_set0' function. */
- #define HAVE_DSA_SIG_SET0 1
-+
-+/* Define to 1 if you have the `ECDSA_SIG_set0' function. */
-+#define HAVE_ECDSA_SIG_SET0 1
-+
-+/* Define to 1 if you have the `EC_KEY_METHOD_get_sign' function. */
-+#define HAVE_EC_KEY_METHOD_GET_SIGN 1
-+
-+/* Define to 1 if you have the `EC_KEY_METHOD_set_sign' function. */
-+#define HAVE_EC_KEY_METHOD_SET_SIGN 1
-+
-+/* Define to 1 if OpenSSL has EC support. */
-+#define ENABLE_PKCS11H_OPENSSL_EC 1
--- 
-2.23.0.windows.1
-
diff --git a/contrib/vcpkg-ports/pkcs11-helper/CONTROL b/contrib/vcpkg-ports/pkcs11-helper/CONTROL
deleted file mode 100644
index 1ead697..0000000
--- a/contrib/vcpkg-ports/pkcs11-helper/CONTROL
+++ /dev/null
@@ -1,4 +0,0 @@
-Source: pkcs11-helper
-Version: 1.29-1
-Homepage: https://github.com/OpenSC/pkcs11-helper
-Description: pkcs11-helper is a library that simplifies the interaction with PKCS#11 providers for end-user applications.
diff --git a/contrib/vcpkg-ports/pkcs11-helper/Fix-build-with-disable-shared.patch b/contrib/vcpkg-ports/pkcs11-helper/Fix-build-with-disable-shared.patch
new file mode 100644
index 0000000..16fa704
--- /dev/null
+++ b/contrib/vcpkg-ports/pkcs11-helper/Fix-build-with-disable-shared.patch
@@ -0,0 +1,48 @@
+From 7171396a151a2edb3474c7a321b7ae4ff7e171fc Mon Sep 17 00:00:00 2001
+From: Frank Lichtenheld <frank@...2641...>
+Date: Wed, 29 Mar 2023 12:44:44 +0200
+Subject: [PATCH] Allow the build to succeed if configured with
+ --disable-shared
+
+Do not try to install a file that does not exist.
+
+Signed-off-by: Frank Lichtenheld <frank@...2641...>
+---
+ configure.ac    | 1 +
+ lib/Makefile.am | 2 ++
+ 2 files changed, 3 insertions(+)
+
+upstream PR: https://github.com/OpenSC/pkcs11-helper/pull/62
+
+diff --git a/configure.ac b/configure.ac
+index a7e9760..f154ae3 100644
+--- a/configure.ac
++++ b/configure.ac
+@@ -581,6 +581,7 @@ AC_SUBST([LIBPKCS11_HELPER_LT_AGE])
+ AC_SUBST([LIBPKCS11_HELPER_LT_OLDEST])
+ AC_SUBST([WIN_LIBPREFIX])
+ AC_SUBST([PKCS11H_FEATURES])
++AM_CONDITIONAL([ENABLE_SHARED], [test "${enable_shared}" = "yes" ])
+ AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
+ AM_CONDITIONAL([CYGWIN], [test "${CYGWIN}" = "yes"])
+ AM_CONDITIONAL([ENABLE_DOC], [test "${enable_doc}" = "yes"])
+diff --git a/lib/Makefile.am b/lib/Makefile.am
+index 31b928f..3cba32f 100644
+--- a/lib/Makefile.am
++++ b/lib/Makefile.am
+@@ -128,10 +128,12 @@ if ENABLE_PKCS11H_TOKEN
+ endif
+ 
+ if WIN32
++if ENABLE_SHARED
+ mylibdir=$(libdir)
+ mylib_DATA=.libs/@WIN_LIBPREFIX@...2727...@LIBPKCS11_HELPER_LT_OLDEST@...2728...
+ .libs/@WIN_LIBPREFIX@...2727...@LIBPKCS11_HELPER_LT_OLDEST@...2728...:	libpkcs11-helper.la
+ endif
++endif
+ 
+ RCCOMPILE = $(RC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) \
+ 	$(AM_CPPFLAGS) $(CPPFLAGS)
+-- 
+2.34.1
+
diff --git a/contrib/vcpkg-ports/pkcs11-helper/config-w32-vc.h.in-indicate-OpenSSL.patch b/contrib/vcpkg-ports/pkcs11-helper/config-w32-vc.h.in-indicate-OpenSSL.patch
new file mode 100644
index 0000000..212181a
--- /dev/null
+++ b/contrib/vcpkg-ports/pkcs11-helper/config-w32-vc.h.in-indicate-OpenSSL.patch
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
diff --git a/contrib/vcpkg-ports/pkcs11-helper/nmake-compatibility-with-vcpkg-nmake.patch b/contrib/vcpkg-ports/pkcs11-helper/nmake-compatibility-with-vcpkg-nmake.patch
new file mode 100644
index 0000000..add4709
--- /dev/null
+++ b/contrib/vcpkg-ports/pkcs11-helper/nmake-compatibility-with-vcpkg-nmake.patch
@@ -0,0 +1,38 @@
+From 2d3a2c05383f653544b9c7194dd1349c6d5f3067 Mon Sep 17 00:00:00 2001
+From: Lev Stipakov <lev@...515...>
+Date: Tue, 11 Jan 2022 13:24:51 +0200
+Subject: [PATCH] nmake: compatibility with vcpkg nmake
+
+Remove options which contradict or already set
+by vcpkg nmake scripts.
+
+Signed-off-by: Lev Stipakov <lev@...515...>
+---
+ lib/Makefile.w32-vc | 8 ++------
+ 1 file changed, 2 insertions(+), 6 deletions(-)
+
+diff --git a/lib/Makefile.w32-vc b/lib/Makefile.w32-vc
+index 96f1f89..be68a00 100644
+--- a/lib/Makefile.w32-vc
++++ b/lib/Makefile.w32-vc
+@@ -75,15 +75,11 @@ OPENSSL_LIBS=-LIBPATH:$(OPENSSL_LIB) user32.lib advapi32.lib $(OPENSSL_STATIC)
+ CFLAGS = -I../include $(OPENSSL_CFLAGS) -DWIN32 -DWIN32_LEAN_AND_MEAN -D_MBCS -D_CRT_SECURE_NO_DEPRECATE -D_WIN32_WINNT=0x0400
+ CC=cl.exe
+ RC=rc.exe
+-CCPARAMS=/nologo /W3 /O2 /FD /c
+-
+-CCPARAMS=$(CCPARAMS) /MD
+-CFLAGS=$(CFLAGS) -DNDEBUG
++CCPARAMS=/c
+ 
+ LINK32=link.exe
+ LIB32=lib.exe
+-LINK32_FLAGS=/nologo /subsystem:windows /dll /incremental:no /release
+-LIB32_FLAGS=/nologo
++LINK32_FLAGS=/dll
+ 
+ HEADERS = \
+ 	config.h \
+-- 
+2.23.0.windows.1
+
diff --git a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
index 84fba08..56e3486 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
+++ b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-001-RFC7512.patch
@@ -1,3 +1,5 @@
+upstream PR: https://github.com/OpenSC/pkcs11-helper/pull/4
+
 commit 90590b02085edc3830bdfe0942a46c4e7bf3f1ab (HEAD -> master)
 Author: David Woodhouse <David.Woodhouse@...753...>
 Date:   Thu Apr 30 14:58:24 2015 +0100
diff --git a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.patch b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.patch
index 325dea8..6d67458 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.patch
+++ b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.patch
@@ -11,6 +11,8 @@
  lib/pkcs11h-core.c                       | 13 +++++++++++--
  3 files changed, 23 insertions(+), 3 deletions(-)
 
+upstream PR: https://github.com/OpenSC/pkcs11-helper/pull/59
+
 diff --git a/include/pkcs11-helper-1.0/pkcs11h-core.h b/include/pkcs11-helper-1.0/pkcs11h-core.h
 index 9028c277..56f87718 100644
 --- a/include/pkcs11-helper-1.0/pkcs11h-core.h
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
index 1c6ceda..47919bc 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -11,26 +11,45 @@
     ARCHIVE ${ARCHIVE}
     REF ${VERSION}
     PATCHES
-        0001-nmake-compatibility-with-vcpkg-nmake.patch
-        0002-config-w32-vc.h.in-indicate-OpenSSL.patch
+        nmake-compatibility-with-vcpkg-nmake.patch
+        config-w32-vc.h.in-indicate-OpenSSL.patch
+        Fix-build-with-disable-shared.patch
         pkcs11-helper-001-RFC7512.patch
         pkcs11-helper-002-dynamic_loader_flags.patch
 )
 
-vcpkg_build_nmake(
+if(VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)
+  vcpkg_build_nmake(
     SOURCE_PATH ${SOURCE_PATH}
     PROJECT_SUBPATH lib
     PROJECT_NAME Makefile.w32-vc
     OPTIONS
         OPENSSL=1
         OPENSSL_HOME=${CURRENT_PACKAGES_DIR}/../openssl_${TARGET_TRIPLET}
-)
+  )
 
-file(INSTALL ${SOURCE_PATH}/include/pkcs11-helper-1.0 DESTINATION ${CURRENT_PACKAGES_DIR}/include/)
-file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
-file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
+  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/lib)
+  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/pkcs11-helper.dll.lib DESTINATION ${CURRENT_PACKAGES_DIR}/debug/lib)
 
-file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
-file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
+  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-rel/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
+  file(INSTALL ${CURRENT_BUILDTREES_DIR}/${TARGET_TRIPLET}-dbg/lib/libpkcs11-helper-1.dll DESTINATION ${CURRENT_PACKAGES_DIR}/debug/bin)
+
+  file(INSTALL ${SOURCE_PATH}/include/pkcs11-helper-1.0 DESTINATION ${CURRENT_PACKAGES_DIR}/include/)
+
+else()
+  find_program(man_to_html man2html REQUIRED)
+
+  vcpkg_configure_make(
+    SOURCE_PATH ${SOURCE_PATH}
+    OPTIONS --disable-crypto-engine-gnutls --disable-crypto-engine-nss
+    --disable-crypto-engine-polarssl --disable-crypto-engine-mbedtls
+    )
+  vcpkg_install_make()
+  vcpkg_fixup_pkgconfig()
+
+  file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
+endif()
+
+vcpkg_copy_pdbs()
 
 file(INSTALL ${SOURCE_PATH}/COPYING DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
diff --git a/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
new file mode 100644
index 0000000..12f918b
--- /dev/null
+++ b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
@@ -0,0 +1,7 @@
+{
+    "name": "pkcs11-helper",
+    "version": "1.29.0",
+    "description": "pkcs11-helper is a library that simplifies the interaction with PKCS#11 providers for end-user applications.",
+    "homepage": "https://github.com/OpenSC/pkcs11-helper",
+    "license": "BSD-3-Clause OR GPL-2.0-only"
+}
diff --git a/contrib/vcpkg-triplets/x64-mingw-ovpn.cmake b/contrib/vcpkg-triplets/x64-mingw-ovpn.cmake
new file mode 100644
index 0000000..3676cdb
--- /dev/null
+++ b/contrib/vcpkg-triplets/x64-mingw-ovpn.cmake
@@ -0,0 +1,8 @@
+set(VCPKG_TARGET_ARCHITECTURE x64)
+set(VCPKG_CRT_LINKAGE dynamic)
+set(VCPKG_LIBRARY_LINKAGE static)
+set(VCPKG_ENV_PASSTHROUGH PATH)
+
+set(VCPKG_CMAKE_SYSTEM_NAME MinGW)
+
+set(VCPKG_MAKE_BUILD_TRIPLET --host=x86_64-w64-mingw32)
diff --git a/contrib/vcpkg-triplets/x86-mingw-ovpn.cmake b/contrib/vcpkg-triplets/x86-mingw-ovpn.cmake
new file mode 100644
index 0000000..9e65f67
--- /dev/null
+++ b/contrib/vcpkg-triplets/x86-mingw-ovpn.cmake
@@ -0,0 +1,8 @@
+set(VCPKG_TARGET_ARCHITECTURE x86)
+set(VCPKG_CRT_LINKAGE dynamic)
+set(VCPKG_LIBRARY_LINKAGE static)
+set(VCPKG_ENV_PASSTHROUGH PATH)
+
+set(VCPKG_CMAKE_SYSTEM_NAME MinGW)
+
+set(VCPKG_MAKE_BUILD_TRIPLET --host=i686-w64-mingw32)

