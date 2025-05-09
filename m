From: Gert Doering <gert@...1296...>
Date: Fri,  9 May 2025 11:09:31 +0200
Message-ID: <20250509090936.18818-1-gert@...1296...>
In-Reply-To: <gerrit.1743171486000.I28af9eac2e9fb615903a82c8f4087602b72c134d@...2715...>
References: <gerrit.1743171486000.I28af9eac2e9fb615903a82c8f4087602b72c134d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] CMake: Sync list of compiler flags with
 configure.ac
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

Also fix one issue reported by the build.

Change-Id: I28af9eac2e9fb615903a82c8f4087602b72c134d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/923
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 6687b56..c19d29a 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -66,6 +66,13 @@
     CACHE STRING "Flags used by the C++ compiler during AddressSanitizer builds."
     FORCE)
 
+function(check_and_add_compiler_flag flag variable)
+    check_c_compiler_flag(${flag} ${variable})
+    if (${variable})
+        add_compile_options(${flag})
+    endif()
+endfunction()
+
 if (MSVC)
     add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE -D_WINSOCK_DEPRECATED_NO_WARNINGS)
     if (USE_WERROR)
@@ -96,11 +103,9 @@
     endif()
 else ()
     add_compile_options(-Wall -Wuninitialized)
-    check_c_compiler_flag(-Wno-stringop-truncation NoStringOpTruncation)
-
-    if (${NoStringOpTruncation})
-        add_compile_options(-Wno-stringop-truncation)
-    endif()
+    check_and_add_compiler_flag(-Wno-stringop-truncation NoStringOpTruncation)
+    check_and_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)
+    check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)
     # We are not ready for this
     #add_compile_options(-Wconversion -Wno-sign-conversion -Wsign-compare)
     if (USE_WERROR)
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index 98102ef..478995f 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -116,7 +116,7 @@
 
 /* Fill-in certs[] array */
 void
-init_cert_data()
+init_cert_data(void)
 {
     struct test_cert certs_local[] = {
         {cert1,  key1,  cname1,  "OVPN TEST CA1",  "OVPN Test Cert 1",  hash1,  1},

