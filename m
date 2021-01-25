From: Arne Schwabe <arne@...1227...>
Date: Mon, 25 Jan 2021 13:56:24 +0100
Message-Id: <20210125125628.30364-8-arne@...1227...>
In-Reply-To: <20210125125628.30364-1-arne@...1227...>
References: <20210125125628.30364-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 07/11] Refactor extract_var_peer_info
 into standalone function and add ssl_util.c
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

Our "natural" place for this function would be ssl.c but ssl.c has a lot of
dependencies on all kinds of other compilation units so including ssl.c into
unit tests is near impossible currently. Instead create a new file ssl_util.c
that holds small utility functions like this one.

Patch v2: add newline add the end of sll_util.h and ssl_util.c

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/Makefile.am              |  1 +
 src/openvpn/openvpn.vcxproj          |  2 +
 src/openvpn/openvpn.vcxproj.filters  |  6 +++
 src/openvpn/ssl.c                    |  2 +-
 src/openvpn/ssl_ncp.c                | 20 ++--------
 src/openvpn/ssl_util.c               | 59 ++++++++++++++++++++++++++++
 src/openvpn/ssl_util.h               | 49 +++++++++++++++++++++++
 src/openvpn/ssl_verify.c             |  1 +
 tests/unit_tests/openvpn/Makefile.am |  3 +-
 9 files changed, 125 insertions(+), 18 deletions(-)
 create mode 100644 src/openvpn/ssl_util.c
 create mode 100644 src/openvpn/ssl_util.h

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 37b002c6..ec84929b 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -119,6 +119,7 @@ openvpn_SOURCES = \
 	ssl_openssl.c ssl_openssl.h \
 	ssl_mbedtls.c ssl_mbedtls.h \
 	ssl_ncp.c ssl_ncp.h \
+	ssl_util.c ssl_util.h \
 	ssl_common.h \
 	ssl_verify.c ssl_verify.h ssl_verify_backend.h \
 	ssl_verify_openssl.c ssl_verify_openssl.h \
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 3863854b..cf31940c 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -212,6 +212,7 @@
     <ClCompile Include="ssl.c" />
     <ClCompile Include="ssl_openssl.c" />
     <ClCompile Include="ssl_ncp.c" />
+    <ClCompile Include="ssl_util.c" />
     <ClCompile Include="ssl_verify.c" />
     <ClCompile Include="ssl_verify_openssl.c" />
     <ClCompile Include="status.c" />
@@ -300,6 +301,7 @@
     <ClInclude Include="ssl_common.h" />
     <ClInclude Include="ssl_ncp.h" />
     <ClInclude Include="ssl_openssl.h" />
+    <ClInclude Include="ssl_util.h" />
     <ClInclude Include="ssl_verify.h" />
     <ClInclude Include="ssl_verify_backend.h" />
     <ClInclude Include="ssl_verify_openssl.h" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index cf5748c7..e8aed2c5 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -243,6 +243,9 @@
     <ClCompile Include="ssl_ncp.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="ssl_util.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="base64.h">
@@ -509,6 +512,9 @@
     <ClInclude Include="ssl_ncp.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="ssl_util.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpn_win32_resources.rc">
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 14c8116f..f59b409f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -4201,4 +4201,4 @@ void
 ssl_clean_user_pass(void)
 {
     purge_user_pass(&auth_user_pass, false);
-}
+}
\ No newline at end of file
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 45bddbe0..f02a3103 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -48,6 +48,7 @@
 #include "common.h"
 
 #include "ssl_ncp.h"
+#include "ssl_util.h"
 #include "openvpn.h"
 
 /**
@@ -195,23 +196,10 @@ const char *
 tls_peer_ncp_list(const char *peer_info, struct gc_arena *gc)
 {
     /* Check if the peer sends the IV_CIPHERS list */
-    const char *ncp_ciphers_start;
-    if (peer_info && (ncp_ciphers_start = strstr(peer_info, "IV_CIPHERS=")))
+    const char *iv_ciphers = extract_var_peer_info(peer_info,"IV_CIPHERS=", gc);
+    if (iv_ciphers)
     {
-        ncp_ciphers_start += strlen("IV_CIPHERS=");
-        const char *ncp_ciphers_end = strstr(ncp_ciphers_start, "\n");
-        if (!ncp_ciphers_end)
-        {
-            /* IV_CIPHERS is at end of the peer_info list and no '\n'
-             * follows */
-            ncp_ciphers_end = ncp_ciphers_start + strlen(ncp_ciphers_start);
-        }
-
-        char *ncp_ciphers_peer = string_alloc(ncp_ciphers_start, gc);
-        /* NULL terminate the copy at the right position */
-        ncp_ciphers_peer[ncp_ciphers_end - ncp_ciphers_start] = '\0';
-        return ncp_ciphers_peer;
-
+        return iv_ciphers;
     }
     else if (tls_peer_info_ncp_ver(peer_info)>=2)
     {
diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
new file mode 100644
index 00000000..d6ead462
--- /dev/null
+++ b/src/openvpn/ssl_util.c
@@ -0,0 +1,59 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2020 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#include "ssl_util.h"
+
+char *
+extract_var_peer_info(const char *peer_info, const char *var,
+                      struct gc_arena *gc)
+{
+    const char *var_start;
+
+    if (peer_info && (var_start = strstr(peer_info, var)))
+    {
+        var_start += strlen(var);
+        const char *var_end = strstr(var_start, "\n");
+        if (!var_end)
+        {
+            /* var is at end of the peer_info list and no '\n'
+             * follows */
+            var_end = var_start + strlen(var_start);
+        }
+
+        char *ncp_ciphers_peer = string_alloc(var_start, gc);
+        /* NULL terminate the copy at the right position */
+        ncp_ciphers_peer[var_end - var_start] = '\0';
+        return ncp_ciphers_peer;
+    }
+    else
+    {
+        return NULL;
+    }
+}
diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h
new file mode 100644
index 00000000..bc2ae30d
--- /dev/null
+++ b/src/openvpn/ssl_util.h
@@ -0,0 +1,49 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2020 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/**
+ * @file SSL utility function. This file (and its .c file) is designed to
+ *       to be included in units/etc without pulling in a lot of dependencies
+ */
+
+#ifndef SSL_UTIL_H_
+#define SSL_UTIL_H_
+
+#include "buffer.h"
+
+/**
+ * Extracts a variable from peer info, the returned string will be allocated
+ * using the supplied gc_arena
+ *
+ * @param peer_info     The peer's peer_info
+ * @param var           The variable *including* =, e.g. IV_CIPHERS=
+ *
+ * @return  The content of the variable as NULL terminated string or NULL if the
+ *          variable cannot be found.
+ */
+char *
+extract_var_peer_info(const char *peer_info,
+                      const char *var,
+                      struct gc_arena *gc);
+
+#endif
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index e04c5c35..e0ef399f 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -46,6 +46,7 @@
 #endif
 #include "auth_token.h"
 #include "push.h"
+#include "ssl_util.h"
 
 /** Maximum length of common name */
 #define TLS_USERNAME_LEN 64
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index f0880a6b..50f3a02e 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -125,4 +125,5 @@ ncp_testdriver_SOURCES = test_ncp.c mock_msg.c \
 	$(openvpn_srcdir)/crypto_openssl.c \
 	$(openvpn_srcdir)/otime.c \
 	$(openvpn_srcdir)/packet_id.c \
-	$(openvpn_srcdir)/platform.c
+	$(openvpn_srcdir)/platform.c \
+	$(openvpn_srcdir)/ssl_util.c
-- 
2.30.0


