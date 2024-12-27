From: Gert Doering <gert@...1296...>
Date: Fri, 27 Dec 2024 12:22:07 +0100
Message-ID: <20241227112209.11572-1-gert@...1296...>
In-Reply-To: <gerrit.1726585476000.I43d84034f3e920a45731c4aab4f851a60921290d@...2715...>
References: <gerrit.1726585476000.I43d84034f3e920a45731c4aab4f851a60921290d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] Add building/testing with msbuild and
 the clang compiler
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

From: Arne Schwabe <arne@...1227...>

The LLVM/clang compiler warning and error message are easier too read
than their MSVC cl counterparts. Also compiling/running tests on Windows
with a different compiler has the benefit of a better coverage.

This includes a few minor changes to allow clang-cl to compile the
project.

Change-Id: I43d84034f3e920a45731c4aab4f851a60921290d
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/751
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 3958ef0..767de0b 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -259,7 +259,7 @@
       strategy:
         fail-fast: false
         matrix:
-          arch: [amd64, x86, arm64]
+          arch: [amd64, x86, arm64, amd64-clang, x86-clang]
 
       name: "msbuild - ${{ matrix.arch }} - openssl"
       env:
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 61f0cc5..5b5b7ff 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -627,7 +627,8 @@
         check_linker_flag(C -Wl,--wrap=parse_line LD_SUPPORTS_WRAP)
     endif()
 
-    if (${LD_SUPPORTS_WRAP})
+    # Clang-cl (which is also MSVC) is wrongly detected to support wrap
+    if (NOT MSVC AND "${LD_SUPPORTS_WRAP}")
         list(APPEND unit_tests
             "test_argv"
             "test_tls_crypt"
diff --git a/CMakePresets.json b/CMakePresets.json
index 135b19d..b6ec201 100644
--- a/CMakePresets.json
+++ b/CMakePresets.json
@@ -122,6 +122,10 @@
             }
         },
         {
+            "name": "clangtoolset",
+            "toolset": "ClangCL"
+        },
+        {
             "name": "mingw-x64",
             "inherits": [ "base", "base-mingw", "x64-mingw" ]
         },
@@ -134,6 +138,10 @@
             "inherits": [ "base", "base-windows", "x64", "release" ]
         },
         {
+            "name": "win-amd64-clang-release",
+            "inherits": [ "base", "base-windows", "clangtoolset", "x64", "release" ]
+        },
+        {
             "name": "win-arm64-release",
             "inherits": [ "base", "base-windows", "arm64", "release" ]
         },
@@ -142,10 +150,18 @@
             "inherits": [ "base", "base-windows", "x86", "release" ]
         },
         {
+            "name": "win-x86-clang-release",
+            "inherits": [ "base", "base-windows", "clangtoolset", "x86", "release" ]
+        },
+        {
             "name": "win-amd64-debug",
             "inherits": [ "base", "base-windows", "x64", "debug" ]
         },
         {
+            "name": "win-amd64-clang-debug",
+            "inherits": [ "base", "base-windows", "clangtoolset", "x64", "debug" ]
+        },
+        {
             "name": "win-arm64-debug",
             "inherits": [ "base", "base-windows", "arm64", "debug" ]
         },
@@ -154,6 +170,10 @@
             "inherits": [ "base", "base-windows", "x86", "debug" ]
         },
         {
+            "name": "win-x86-clang-debug",
+            "inherits": [ "base", "base-windows", "clangtoolset", "x86", "debug" ]
+        },
+        {
             "name": "unix-native",
             "generator": "Ninja Multi-Config",
             "binaryDir": "out/build/unix"
@@ -174,6 +194,11 @@
             "configuration": "Release"
         },
         {
+            "name": "win-amd64-clang-release",
+            "configurePreset": "win-amd64-clang-release",
+            "configuration": "Release"
+        },
+        {
             "name": "win-arm64-release",
             "configurePreset": "win-arm64-release",
             "configuration": "Release"
@@ -184,11 +209,21 @@
             "configuration": "Release"
         },
         {
+            "name": "win-x86-clang-release",
+            "configurePreset": "win-x86-clang-release",
+            "configuration": "Release"
+        },
+        {
             "name": "win-amd64-debug",
             "configurePreset": "win-amd64-debug",
             "configuration": "Debug"
         },
         {
+            "name": "win-amd64-clang-debug",
+            "configurePreset": "win-amd64-clang-debug",
+            "configuration": "Debug"
+        },
+        {
             "name": "win-arm64-debug",
             "configurePreset": "win-arm64-debug",
             "configuration": "Debug"
@@ -199,6 +234,11 @@
             "configuration": "Debug"
         },
         {
+            "name": "win-x86-clang-debug",
+            "configurePreset": "win-x86-clang-debug",
+            "configuration": "Debug"
+        },
+        {
             "name": "unix-native",
             "configurePreset": "unix-native"
         }
@@ -209,18 +249,34 @@
             "configurePreset": "win-amd64-release"
         },
         {
+            "name": "win-amd64-clang-release",
+            "configurePreset": "win-amd64-clang-release"
+        },
+        {
             "name": "win-x86-release",
             "configurePreset": "win-x86-release"
         },
         {
+            "name": "win-x86-clang-release",
+            "configurePreset": "win-x86-clang-release"
+        },
+        {
             "name": "win-amd64-debug",
             "configurePreset": "win-amd64-debug"
         },
         {
+            "name": "win-amd64-clang-debug",
+            "configurePreset": "win-amd64-clang-debug"
+        },
+        {
             "name": "win-x86-debug",
             "configurePreset": "win-x86-debug"
         },
         {
+            "name": "win-x86-clang-debug",
+            "configurePreset": "win-x86-clang-debug"
+        },
+        {
             "name": "unix-native",
             "configurePreset": "unix-native"
         }
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 3c517d7..74a53a6 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -439,8 +439,10 @@
 # define _GNU_SOURCE 1
 #endif
 
-
-#if defined(_WIN32)
+/* if inttypes.h is included this breaks rc.exe when using the ClangCL
+ * Toolchain as it pulls in a inttypes.h variant for clang that rc.exe does
+ * not understand (#include_next preprocessor directive) */
+#if defined(_WIN32) && !defined(RC_INVOKED)
 #include <inttypes.h>
 typedef uint32_t in_addr_t;
 typedef uint16_t in_port_t;
@@ -452,7 +454,7 @@
 #define SIGTERM   15
 #endif
 
-#if defined(_MSC_VER)
+#if defined(_MSC_VER) && !defined(RC_INVOKED)
 #include <BaseTsd.h>
 typedef SSIZE_T ssize_t;
 #define strncasecmp strnicmp
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 154fff4..17152e0 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -303,7 +303,7 @@
 UINT __stdcall
 FindSystemInfo(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
@@ -340,7 +340,7 @@
 UINT __stdcall
 CloseOpenVPNGUI(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
     UNREFERENCED_PARAMETER(hInstall); /* This CA is does not interact with MSI session (report errors, access properties, tables, etc.). */
@@ -363,7 +363,7 @@
 UINT __stdcall
 StartOpenVPNGUI(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
@@ -636,7 +636,7 @@
 UINT __stdcall
 EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
@@ -789,7 +789,7 @@
                 {
                     goto cleanup_szDisplayName;
                 }
-#ifdef __GNUC__
+#if defined(__GNUC__) || defined(__clang__)
 /*
  * warning: enumeration value ‘MSICONDITION_TRUE’ not handled in switch
  * warning: enumeration value ‘MSICONDITION_NONE’ not handled in switch
@@ -809,7 +809,7 @@
                         free(szValue);
                         goto cleanup_szDisplayName;
                 }
-#ifdef __GNUC__
+#if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic pop
 #endif
                 free(szValue);
@@ -965,7 +965,7 @@
 UINT __stdcall
 ProcessDeferredAction(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
@@ -1165,7 +1165,7 @@
 UINT __stdcall
 CheckAndScheduleReboot(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
 
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index 7aacdf3..761aa47 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -66,7 +66,11 @@
 extern "C" {
 #endif
 
-#ifdef __GNUC__
+/* Ensure that clang-cl, which does not understand the cl specific
+ * preprocessor defines like #pragma comment(linker, DLLEXP_EXPORT)
+ * is handled the same way as mingw and uses the alternative instead
+ * and does not define DLLEXP_EXPORT */
+#if defined(__GNUC__) || defined(__clang__)
 #define DLLEXP_DECL __declspec(dllexport)
 #else
 #define DLLEXP_DECL
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 0fb4697..06e8b98 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -389,8 +389,9 @@
 
     /* Instead of trying to trick the compiler here, disable the warnings
      * for this unit test. We know that the results will be truncated
-     * and we want to test that */
-#if defined(__GNUC__)
+     * and we want to test that. Not we need the clang as clang-cl (msvc) does
+     * not define __GNUC__ like it does under UNIX(-like) platforms */
+#if defined(__GNUC__) || defined(__clang__)
 /* some clang version do not understand -Wformat-truncation, so ignore the
  * warning to avoid warnings/errors (-Werror) about unknown pragma/option */
 #if defined(__clang__)
@@ -418,7 +419,7 @@
     assert_int_equal(ret, 10);
     assert_int_equal(buf[9], '\0');
 
-#if defined(__GNUC__)
+#if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic pop
 #if defined(__clang__)
 #pragma clang diagnostic pop

