From: Gert Doering <gert@...1296...>
Date: Tue, 23 Sep 2025 16:08:48 +0200
Message-ID: <20250923140854.21766-1-gert@...1296...>
In-Reply-To: <gerrit.1758282060000.I9ce664d073a4e6a6d433e9e6f986a5086dae8aa1@...2715...>
References: <gerrit.1758282060000.I9ce664d073a4e6a6d433e9e6f986a5086dae8aa1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Enable a subset of -Wextra
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

From: Frank Lichtenheld <frank@...2641...>

- Includes fixes for
  - -Wimplicit-fallthrough=2
    (=3 is default but requires replacing all
     fallthrough comments)
  - -Wmissing-field-initializers
  - -Wold-style-declaration
- All other warnings that would need fixes are
  disabled for now.

Change-Id: I9ce664d073a4e6a6d433e9e6f986a5086dae8aa1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1202
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1202
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index f027b01..fdc0162 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -114,7 +114,14 @@
     check_and_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)
     check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)
     # We are not ready for this
-    #add_compile_options(-Wconversion -Wno-sign-conversion -Wsign-compare)
+    #add_compile_options(-Wconversion -Wno-sign-conversion)
+    add_compile_options(-Wextra -Wno-sign-compare -Wno-type-limits -Wno-unused-parameter)
+    # clang doesn't have the different levels but also doesn't include it in -Wextra
+    check_and_add_compiler_flag(-Wimplicit-fallthrough=2 GCCImplicitFallthrough)
+    if (WIN32)
+        # Not sure how to deal with GetProcAddress
+        add_compile_options(-Wno-cast-function-type)
+    endif ()
     if (USE_WERROR)
         add_compile_options(-Werror)
     endif ()
diff --git a/configure.ac b/configure.ac
index 38b14a1..a5485b0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1398,6 +1398,13 @@
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wstrict-prototypes])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wold-style-definition])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-sign-compare -Wno-type-limits -Wno-unused-parameter])
+# clang doesn't have the different levels but also doesn't include it in -Wextra
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wimplicit-fallthrough=2])
+if test "${WIN32}" = "yes"; then
+        # Not sure how to deal with GetProcAddress
+	ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-cast-function-type])
+fi
 
 if test "${enable_pedantic}" = "yes"; then
 	enable_strict="yes"
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 59bf52b..0922326 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -733,7 +733,7 @@
                 {
                     return false;
                 }
-
+                /* Intentional [[fallthrough]]; */
             case 2:
                 /* after the '=', replace non-printable or shell meta with '_' */
                 if (!isprint(c) || isspace(c) || c == '$' || c == '(' || c == '`')
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 9618301..c213c4b 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -84,10 +84,10 @@
 
 #ifdef _WIN32
 
-const static GUID GUID_DEVCLASS_NET = {
+static const GUID GUID_DEVCLASS_NET = {
     0x4d36e972L, 0xe325, 0x11ce, { 0xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x03, 0x18 }
 };
-const static GUID GUID_DEVINTERFACE_NET = {
+static const GUID GUID_DEVINTERFACE_NET = {
     0xcac88484, 0x7515, 0x4c03, { 0x82, 0xe6, 0x71, 0xa8, 0x7a, 0xba, 0xc3, 0x61 }
 };
 
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index b633e77..9731602 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -40,11 +40,11 @@
 #endif
 
 
-const static GUID GUID_DEVCLASS_NET = {
+static const GUID GUID_DEVCLASS_NET = {
     0x4d36e972L, 0xe325, 0x11ce, { 0xbf, 0xc1, 0x08, 0x00, 0x2b, 0xe1, 0x03, 0x18 }
 };
 
-const static WCHAR szAdapterRegKeyPathTemplate[] =
+static const WCHAR szAdapterRegKeyPathTemplate[] =
     L"SYSTEM\\CurrentControlSet\\Control\\Network\\%ls\\%ls\\Connection";
 #define ADAPTER_REGKEY_PATH_MAX                                                                \
     (_countof(L"SYSTEM\\CurrentControlSet\\Control\\Network\\") - 1 + 38 + _countof(L"\\") - 1 \
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index b5211cd..1423d46 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -164,7 +164,7 @@
 init_tas_auth(int key_direction)
 {
     struct tls_auth_standalone tas = { 0 };
-    struct frame frame = { { .headroom = 200, .payload_size = 1400 }, 0 };
+    struct frame frame = { .buf = { .headroom = 200, .payload_size = 1400 }, 0 };
     tas.frame = frame;
 
     tas.tls_wrap.mode = TLS_WRAP_AUTH;
@@ -591,7 +591,7 @@
     enum first_packet_verdict verdict;
 
     tas.tls_wrap.mode = TLS_WRAP_NONE;
-    struct frame frame = { { .headroom = 200, .payload_size = 1400 }, 0 };
+    struct frame frame = { .buf = { .headroom = 200, .payload_size = 1400 }, 0 };
     tas.frame = frame;
     tas.workbuf = alloc_buf(1600);
 

