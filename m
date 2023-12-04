From: Marc Becker <marc.becker@...2704...>
Date: Mon,  4 Dec 2023 16:33:45 +0100
Message-ID: <20231204153345.1146-1-marc.becker@...2704...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [Openvpn-Devel] [PATCH] vcpkg-ports/pkcs11-helper:
 bump to version 1.30
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

update metadata references for pkcs11-helper v1.30
remove local patches incorporated in new upstream
---
 .../Fix-build-with-disable-shared.patch       |  48 --------
 ...cs11-helper-002-dynamic_loader_flags.patch | 104 ------------------
 .../vcpkg-ports/pkcs11-helper/portfile.cmake  |   6 +-
 contrib/vcpkg-ports/pkcs11-helper/vcpkg.json  |   2 +-
 4 files changed, 3 insertions(+), 157 deletions(-)
 delete mode 100644 contrib/vcpkg-ports/pkcs11-helper/Fix-build-with-disable-shared.patch
 delete mode 100644 contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.patch

diff --git a/contrib/vcpkg-ports/pkcs11-helper/Fix-build-with-disable-shared.patch b/contrib/vcpkg-ports/pkcs11-helper/Fix-build-with-disable-shared.patch
deleted file mode 100644
index 16fa7042..00000000
--- a/contrib/vcpkg-ports/pkcs11-helper/Fix-build-with-disable-shared.patch
+++ /dev/null
@@ -1,48 +0,0 @@
-From 7171396a151a2edb3474c7a321b7ae4ff7e171fc Mon Sep 17 00:00:00 2001
-From: Frank Lichtenheld <frank@...2641...>
-Date: Wed, 29 Mar 2023 12:44:44 +0200
-Subject: [PATCH] Allow the build to succeed if configured with
- --disable-shared
-
-Do not try to install a file that does not exist.
-
-Signed-off-by: Frank Lichtenheld <frank@...2641...>
----
- configure.ac    | 1 +
- lib/Makefile.am | 2 ++
- 2 files changed, 3 insertions(+)
-
-upstream PR: https://github.com/OpenSC/pkcs11-helper/pull/62
-
-diff --git a/configure.ac b/configure.ac
-index a7e9760..f154ae3 100644
---- a/configure.ac
-+++ b/configure.ac
-@@ -581,6 +581,7 @@ AC_SUBST([LIBPKCS11_HELPER_LT_AGE])
- AC_SUBST([LIBPKCS11_HELPER_LT_OLDEST])
- AC_SUBST([WIN_LIBPREFIX])
- AC_SUBST([PKCS11H_FEATURES])
-+AM_CONDITIONAL([ENABLE_SHARED], [test "${enable_shared}" = "yes" ])
- AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
- AM_CONDITIONAL([CYGWIN], [test "${CYGWIN}" = "yes"])
- AM_CONDITIONAL([ENABLE_DOC], [test "${enable_doc}" = "yes"])
-diff --git a/lib/Makefile.am b/lib/Makefile.am
-index 31b928f..3cba32f 100644
---- a/lib/Makefile.am
-+++ b/lib/Makefile.am
-@@ -128,10 +128,12 @@ if ENABLE_PKCS11H_TOKEN
- endif
- 
- if WIN32
-+if ENABLE_SHARED
- mylibdir=$(libdir)
- mylib_DATA=.libs/@WIN_LIBPREFIX@...2727...@LIBPKCS11_HELPER_LT_OLDEST@...2728...
- .libs/@WIN_LIBPREFIX@...2727...@LIBPKCS11_HELPER_LT_OLDEST@...2728...:	libpkcs11-helper.la
- endif
-+endif
- 
- RCCOMPILE = $(RC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) \
- 	$(AM_CPPFLAGS) $(CPPFLAGS)
--- 
-2.34.1
-
diff --git a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.patch b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.patch
deleted file mode 100644
index 6d674581..00000000
--- a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.patch
+++ /dev/null
@@ -1,104 +0,0 @@
-From 934197611dd1260d17ae0f11ae81c1d2e85612d2 Mon Sep 17 00:00:00 2001
-From: Marc Becker <marc.becker@...2704...>
-Date: Fri, 22 Jul 2022 10:33:05 +0200
-Subject: [PATCH] core: add provider property for loader flags
-
-support flags for dynamic loader via provider property
-set original values as defaults, use verbatim (user-supplied) value
----
- include/pkcs11-helper-1.0/pkcs11h-core.h | 11 ++++++++++-
- lib/_pkcs11h-core.h                      |  2 ++
- lib/pkcs11h-core.c                       | 13 +++++++++++--
- 3 files changed, 23 insertions(+), 3 deletions(-)
-
-upstream PR: https://github.com/OpenSC/pkcs11-helper/pull/59
-
-diff --git a/include/pkcs11-helper-1.0/pkcs11h-core.h b/include/pkcs11-helper-1.0/pkcs11h-core.h
-index 9028c277..56f87718 100644
---- a/include/pkcs11-helper-1.0/pkcs11h-core.h
-+++ b/include/pkcs11-helper-1.0/pkcs11h-core.h
-@@ -384,8 +384,17 @@ extern "C" {
-  */
- #define PKCS11H_PROVIDER_PROPERTY_PROVIDER_DESTRUCT_HOOK_DATA 8
- 
-+/**
-+ * @brief Provider loader flags for platform.
-+ * Value type is unsigned.
-+ * Default value is platform dependent:
-+ *     win32 -> 0
-+ *    dlopen -> RTLD_NOW | RTLD_LOCAL
-+ */
-+#define PKCS11H_PROVIDER_PROPERTY_LOADER_FLAGS 9
-+
- /** @private */
--#define _PKCS11H_PROVIDER_PROPERTY_LAST 9
-+#define _PKCS11H_PROVIDER_PROPERTY_LAST 10
- 
- /** @} */
- 
-diff --git a/lib/_pkcs11h-core.h b/lib/_pkcs11h-core.h
-index f879c0e8..1c02e35d 100644
---- a/lib/_pkcs11h-core.h
-+++ b/lib/_pkcs11h-core.h
-@@ -134,6 +134,8 @@ struct _pkcs11h_provider_s {
- #if defined(ENABLE_PKCS11H_SLOTEVENT)
- 	_pkcs11h_thread_t slotevent_thread;
- #endif
-+
-+	unsigned loader_flags;
- };
- 
- struct _pkcs11h_session_s {
-diff --git a/lib/pkcs11h-core.c b/lib/pkcs11h-core.c
-index 0bf11e87..409ad9e2 100644
---- a/lib/pkcs11h-core.c
-+++ b/lib/pkcs11h-core.c
-@@ -138,6 +138,7 @@ static const char * __pkcs11h_provider_preperty_names[] = {
- 	"init_args",
- 	"provider_destruct_hook",
- 	"provider_destruct_hook_data",
-+	"provider_loader_flags",
- 	NULL
- };
- 
-@@ -916,6 +917,10 @@ pkcs11h_registerProvider (
- 		reference
- 	);
- 
-+#if !defined(_WIN32)
-+	provider->loader_flags = RTLD_NOW | RTLD_LOCAL;
-+#endif
-+
- 	_PKCS11H_DEBUG (
- 		PKCS11H_LOG_DEBUG2,
- 		"PKCS#11: pkcs11h_registerProvider Provider '%s'",
-@@ -1001,6 +1006,7 @@ pkcs11h_setProviderPropertyByName (
- 		case PKCS11H_PROVIDER_PROPERTY_SLOT_EVENT_METHOD:
- 		case PKCS11H_PROVIDER_PROPERTY_MASK_PRIVATE_MODE:
- 		case PKCS11H_PROVIDER_PROPERTY_SLOT_POLL_INTERVAL:
-+		case PKCS11H_PROVIDER_PROPERTY_LOADER_FLAGS:
- 			*(unsigned *)value = (unsigned)strtol(value_str, 0, 0);
- 			value_size = sizeof(unsigned);
- 		break;
-@@ -1084,6 +1090,9 @@ __pkcs11h_providerPropertyAddress(
- 		case PKCS11H_PROVIDER_PROPERTY_PROVIDER_DESTRUCT_HOOK_DATA:
- 			*value = &provider->destruct_hook_data;
- 			*value_size = sizeof(provider->destruct_hook_data);
-+		case PKCS11H_PROVIDER_PROPERTY_LOADER_FLAGS:
-+			*value = &provider->loader_flags;
-+			*value_size = sizeof(provider->loader_flags);
- 		break;
- 	}
- 	rv = CKR_OK;
-@@ -1254,9 +1263,9 @@ pkcs11h_initializeProvider (
- 	}
- 
- #if defined(_WIN32)
--	provider->handle = LoadLibraryA (provider->provider_location);
-+	provider->handle = LoadLibraryExA (provider->provider_location, NULL, provider->loader_flags);
- #else
--	provider->handle = dlopen (provider->provider_location, RTLD_NOW | RTLD_LOCAL);
-+	provider->handle = dlopen (provider->provider_location, provider->loader_flags);
- #endif
- 
- 	if (provider->handle == NULL) {
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
index f8da979e..db9a5ab8 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -1,9 +1,9 @@
-set(VERSION 1.29.0)
+set(VERSION 1.30.0)
 
 vcpkg_download_distfile(ARCHIVE
     URLS "https://github.com/OpenSC/pkcs11-helper/releases/download/pkcs11-helper-${VERSION}/pkcs11-helper-${VERSION}.tar.bz2"
     FILENAME "pkcs11-helper-${VERSION}.tar.bz2"
-    SHA512 c530f5a4b5826a02bfe787a1293a7595d5a0d6348daa16675bd10c6d6734b1f24a3cc73b5b89433cf1edf8815f8b7298fdfd1ed686f096bb5edfb425e9430eb2
+    SHA512 19fba76e41210cc17f9efa4501d0214d4a5c777ab7b2671888fd280b150bae4a6b190c7f47fb783015f9aa40d409fd6087264e531d6f28d0bed4293dcbf8bdd5
 )
 
 vcpkg_extract_source_archive_ex(
@@ -13,9 +13,7 @@ vcpkg_extract_source_archive_ex(
     PATCHES
         nmake-compatibility-with-vcpkg-nmake.patch
         config-w32-vc.h.in-indicate-OpenSSL.patch
-        Fix-build-with-disable-shared.patch
         pkcs11-helper-001-RFC7512.patch
-        pkcs11-helper-002-dynamic_loader_flags.patch
 )
 
 if(VCPKG_TARGET_IS_WINDOWS AND NOT VCPKG_TARGET_IS_MINGW)
diff --git a/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
index 12f918b7..521f7547 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
+++ b/contrib/vcpkg-ports/pkcs11-helper/vcpkg.json
@@ -1,6 +1,6 @@
 {
     "name": "pkcs11-helper",
-    "version": "1.29.0",
+    "version": "1.30.0",
     "description": "pkcs11-helper is a library that simplifies the interaction with PKCS#11 providers for end-user applications.",
     "homepage": "https://github.com/OpenSC/pkcs11-helper",
     "license": "BSD-3-Clause OR GPL-2.0-only"
-- 
2.43.0.windows.1


