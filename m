From: Marc Becker <marc.becker@...2704...>
Date: Wed, 14 Dec 2022 15:33:25 +0100
Message-Id: <20221214143325.2604-1-marc.becker@...2704...>
In-Reply-To: <20221211200108.1402-1-marc.becker@...2704...>
References: <20221211200108.1402-1-marc.becker@...2704...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] vcpkg-ports/pkcs11-helper: support loader
 flags
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

Add dynamic loader flag feature to bundled pkcs11-helper.
Required to allow special handling for PKCS11 providers on win32.

Signed-off-by: Marc Becker <marc.becker@...2704...>
---
  Part 2 of [PATCH v3 3/3] special handling for PKCS11 providers on win32
   - split contrib patch from OpenVPN change
  
  See https://github.com/OpenSC/pkcs11-helper/pull/59
  
  Support is expected to land in pkcs11-helper with next release (v1.30?),
  anticipate change to have stable behavior during OpenVPN 2.6 lifetime
---
 ...cs11-helper-002-dynamic_loader_flags.patch | 102 ++++++++++++++++++
 .../vcpkg-ports/pkcs11-helper/portfile.cmake  |   1 +
 2 files changed, 103 insertions(+)
 create mode 100644 contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.patch

diff --git a/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.patch b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.patch
new file mode 100644
index 00000000..325dea8b
--- /dev/null
+++ b/contrib/vcpkg-ports/pkcs11-helper/pkcs11-helper-002-dynamic_loader_flags.patch
@@ -0,0 +1,102 @@
+From 934197611dd1260d17ae0f11ae81c1d2e85612d2 Mon Sep 17 00:00:00 2001
+From: Marc Becker <marc.becker@...2704...>
+Date: Fri, 22 Jul 2022 10:33:05 +0200
+Subject: [PATCH] core: add provider property for loader flags
+
+support flags for dynamic loader via provider property
+set original values as defaults, use verbatim (user-supplied) value
+---
+ include/pkcs11-helper-1.0/pkcs11h-core.h | 11 ++++++++++-
+ lib/_pkcs11h-core.h                      |  2 ++
+ lib/pkcs11h-core.c                       | 13 +++++++++++--
+ 3 files changed, 23 insertions(+), 3 deletions(-)
+
+diff --git a/include/pkcs11-helper-1.0/pkcs11h-core.h b/include/pkcs11-helper-1.0/pkcs11h-core.h
+index 9028c277..56f87718 100644
+--- a/include/pkcs11-helper-1.0/pkcs11h-core.h
++++ b/include/pkcs11-helper-1.0/pkcs11h-core.h
+@@ -384,8 +384,17 @@ extern "C" {
+  */
+ #define PKCS11H_PROVIDER_PROPERTY_PROVIDER_DESTRUCT_HOOK_DATA 8
+ 
++/**
++ * @brief Provider loader flags for platform.
++ * Value type is unsigned.
++ * Default value is platform dependent:
++ *     win32 -> 0
++ *    dlopen -> RTLD_NOW | RTLD_LOCAL
++ */
++#define PKCS11H_PROVIDER_PROPERTY_LOADER_FLAGS 9
++
+ /** @private */
+-#define _PKCS11H_PROVIDER_PROPERTY_LAST 9
++#define _PKCS11H_PROVIDER_PROPERTY_LAST 10
+ 
+ /** @} */
+ 
+diff --git a/lib/_pkcs11h-core.h b/lib/_pkcs11h-core.h
+index f879c0e8..1c02e35d 100644
+--- a/lib/_pkcs11h-core.h
++++ b/lib/_pkcs11h-core.h
+@@ -134,6 +134,8 @@ struct _pkcs11h_provider_s {
+ #if defined(ENABLE_PKCS11H_SLOTEVENT)
+ 	_pkcs11h_thread_t slotevent_thread;
+ #endif
++
++	unsigned loader_flags;
+ };
+ 
+ struct _pkcs11h_session_s {
+diff --git a/lib/pkcs11h-core.c b/lib/pkcs11h-core.c
+index 0bf11e87..409ad9e2 100644
+--- a/lib/pkcs11h-core.c
++++ b/lib/pkcs11h-core.c
+@@ -138,6 +138,7 @@ static const char * __pkcs11h_provider_preperty_names[] = {
+ 	"init_args",
+ 	"provider_destruct_hook",
+ 	"provider_destruct_hook_data",
++	"provider_loader_flags",
+ 	NULL
+ };
+ 
+@@ -916,6 +917,10 @@ pkcs11h_registerProvider (
+ 		reference
+ 	);
+ 
++#if !defined(_WIN32)
++	provider->loader_flags = RTLD_NOW | RTLD_LOCAL;
++#endif
++
+ 	_PKCS11H_DEBUG (
+ 		PKCS11H_LOG_DEBUG2,
+ 		"PKCS#11: pkcs11h_registerProvider Provider '%s'",
+@@ -1001,6 +1006,7 @@ pkcs11h_setProviderPropertyByName (
+ 		case PKCS11H_PROVIDER_PROPERTY_SLOT_EVENT_METHOD:
+ 		case PKCS11H_PROVIDER_PROPERTY_MASK_PRIVATE_MODE:
+ 		case PKCS11H_PROVIDER_PROPERTY_SLOT_POLL_INTERVAL:
++		case PKCS11H_PROVIDER_PROPERTY_LOADER_FLAGS:
+ 			*(unsigned *)value = (unsigned)strtol(value_str, 0, 0);
+ 			value_size = sizeof(unsigned);
+ 		break;
+@@ -1084,6 +1090,9 @@ __pkcs11h_providerPropertyAddress(
+ 		case PKCS11H_PROVIDER_PROPERTY_PROVIDER_DESTRUCT_HOOK_DATA:
+ 			*value = &provider->destruct_hook_data;
+ 			*value_size = sizeof(provider->destruct_hook_data);
++		case PKCS11H_PROVIDER_PROPERTY_LOADER_FLAGS:
++			*value = &provider->loader_flags;
++			*value_size = sizeof(provider->loader_flags);
+ 		break;
+ 	}
+ 	rv = CKR_OK;
+@@ -1254,9 +1263,9 @@ pkcs11h_initializeProvider (
+ 	}
+ 
+ #if defined(_WIN32)
+-	provider->handle = LoadLibraryA (provider->provider_location);
++	provider->handle = LoadLibraryExA (provider->provider_location, NULL, provider->loader_flags);
+ #else
+-	provider->handle = dlopen (provider->provider_location, RTLD_NOW | RTLD_LOCAL);
++	provider->handle = dlopen (provider->provider_location, provider->loader_flags);
+ #endif
+ 
+ 	if (provider->handle == NULL) {
diff --git a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
index 4432b550..1c6cedac 100644
--- a/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
+++ b/contrib/vcpkg-ports/pkcs11-helper/portfile.cmake
@@ -14,6 +14,7 @@ vcpkg_extract_source_archive_ex(
         0001-nmake-compatibility-with-vcpkg-nmake.patch
         0002-config-w32-vc.h.in-indicate-OpenSSL.patch
         pkcs11-helper-001-RFC7512.patch
+        pkcs11-helper-002-dynamic_loader_flags.patch
 )
 
 vcpkg_build_nmake(
-- 
2.39.0.windows.1


