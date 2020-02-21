From: Arne Schwabe <arne@...1227...>
Date: Fri, 21 Feb 2020 11:07:46 +0100
Message-Id: <20200221100746.7065-1-arne@...1227...>
In-Reply-To: <20200217144339.3273-1-arne@...1227...>
References: <20200217144339.3273-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v5 4/5] Move NCP related function into a
 seperate file and add unit tests
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

This allows unit test the NCP functions. The ssl.c file has too
many dependencies to make unit testing of it viable.

Patch V2: Removing the include "ssl_ncp.h" from options.c for V2 of
          implement dynamic NCP forces a new version of this patch to
          add the #include in this patch. Merge VS studio file changes
          for ssl_ncp.[ch] into this patch

Patch V3: Regenerate for changes in earlier patches, apply Lev's changes
          to Visual Studio project file

Patch V4: Regenerate to also have the changes of earlier patches.

Patch V5: Fix unit tests for crypto library missing chacha20-poly1305

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/Makefile.am              |   1 +
 src/openvpn/init.c                   |   1 +
 src/openvpn/multi.c                  |   1 +
 src/openvpn/openvpn.vcxproj          |   2 +
 src/openvpn/openvpn.vcxproj.filters  |   8 +-
 src/openvpn/options.c                |   1 +
 src/openvpn/push.c                   |   1 +
 src/openvpn/ssl.c                    | 176 +-------------------
 src/openvpn/ssl.h                    |  65 --------
 src/openvpn/ssl_ncp.c                | 231 +++++++++++++++++++++++++++
 src/openvpn/ssl_ncp.h                | 101 ++++++++++++
 tests/unit_tests/openvpn/Makefile.am |  18 ++-
 tests/unit_tests/openvpn/test_ncp.c  | 184 +++++++++++++++++++++
 13 files changed, 549 insertions(+), 241 deletions(-)
 create mode 100644 src/openvpn/ssl_ncp.c
 create mode 100644 src/openvpn/ssl_ncp.h
 create mode 100644 tests/unit_tests/openvpn/test_ncp.c

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index d1bb99c2..2ea47cda 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -116,6 +116,7 @@ openvpn_SOURCES = \
 	ssl.c ssl.h  ssl_backend.h \
 	ssl_openssl.c ssl_openssl.h \
 	ssl_mbedtls.c ssl_mbedtls.h \
+	ssl_ncp.c ssl_ncp.h \
 	ssl_common.h \
 	ssl_verify.c ssl_verify.h ssl_verify_backend.h \
 	ssl_verify_openssl.c ssl_verify_openssl.h \
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1cfffbbe..824b6667 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -49,6 +49,7 @@
 #include "ping.h"
 #include "mstats.h"
 #include "ssl_verify.h"
+#include "ssl_ncp.h"
 #include "tls_crypt.h"
 #include "forward.h"
 #include "auth_token.h"
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 279cab23..da0aeeba 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -45,6 +45,7 @@
 #include "gremlin.h"
 #include "mstats.h"
 #include "ssl_verify.h"
+#include "ssl_ncp.h"
 #include "vlan.h"
 #include <inttypes.h>
 
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 614d720a..53ac5482 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -192,6 +192,7 @@
     <ClCompile Include="socks.c" />
     <ClCompile Include="ssl.c" />
     <ClCompile Include="ssl_openssl.c" />
+    <ClCompile Include="ssl_ncp.c" />
     <ClCompile Include="ssl_verify.c" />
     <ClCompile Include="ssl_verify_openssl.c" />
     <ClCompile Include="status.c" />
@@ -278,6 +279,7 @@
     <ClInclude Include="ssl.h" />
     <ClInclude Include="ssl_backend.h" />
     <ClInclude Include="ssl_common.h" />
+    <ClInclude Include="ssl_ncp.h" />
     <ClInclude Include="ssl_openssl.h" />
     <ClInclude Include="ssl_verify.h" />
     <ClInclude Include="ssl_verify_backend.h" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index 41e62d14..80eb52b3 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -243,6 +243,9 @@
     <ClCompile Include="ring_buffer.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="ssl_ncp.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="base64.h">
@@ -506,10 +509,13 @@
     <ClInclude Include="ring_buffer.h">
       <Filter>Header Files</Filter>
     </ClInclude>
+    <ClInclude Include="ssl_ncp.h">
+      <Filter>Header Files</Filter>
+    </ClInclude>
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpn_win32_resources.rc">
       <Filter>Resource Files</Filter>
     </ResourceCompile>
   </ItemGroup>
-</Project>
+</Project>
\ No newline at end of file
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6c0e52e6..c3229156 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -45,6 +45,7 @@
 #include "shaper.h"
 #include "crypto.h"
 #include "ssl.h"
+#include "ssl_ncp.h"
 #include "options.h"
 #include "misc.h"
 #include "socket.h"
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 8b634051..71f22e94 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -33,6 +33,7 @@
 #include "options.h"
 #include "ssl.h"
 #include "ssl_verify.h"
+#include "ssl_ncp.h"
 #include "manage.h"
 
 #include "memdbg.h"
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 51b03c3b..e21279f1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -59,6 +59,7 @@
 #include "ssl.h"
 #include "ssl_verify.h"
 #include "ssl_backend.h"
+#include "ssl_ncp.h"
 #include "auth_token.h"
 
 #include "memdbg.h"
@@ -67,6 +68,7 @@
 static const char ssl_default_options_string[] = "V0 UNDEF";
 #endif
 
+
 static inline const char *
 local_options_string(const struct tls_session *session)
 {
@@ -1914,119 +1916,6 @@ key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len)
     }
 }
 
-bool
-tls_item_in_cipher_list(const char *item, const char *list)
-{
-    char *tmp_ciphers = string_alloc(list, NULL);
-    char *tmp_ciphers_orig = tmp_ciphers;
-
-    const char *token = strtok(tmp_ciphers, ":");
-    while (token)
-    {
-        if (0 == strcmp(token, item))
-        {
-            break;
-        }
-        token = strtok(NULL, ":");
-    }
-    free(tmp_ciphers_orig);
-
-    return token != NULL;
-}
-
-const char *
-tls_peer_ncp_list(const char *peer_info, struct gc_arena *gc)
-{
-    /* Check if the peer sends the IV_CIPHERS list */
-    const char *ncp_ciphers_start;
-    if (peer_info && (ncp_ciphers_start = strstr(peer_info, "IV_CIPHERS=")))
-    {
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
-    }
-    else if (tls_peer_info_ncp_ver(peer_info)>=2)
-    {
-        /* If the peer announces IV_NCP=2 then it supports the AES GCM
-         * ciphers */
-        return "AES-256-GCM:AES-128-GCM";
-    }
-    else
-    {
-        return "";
-    }
-}
-
-char *
-ncp_get_best_cipher(const char *server_list, const char *server_cipher,
-                    const char *peer_info,  const char *remote_cipher,
-                    struct gc_arena *gc)
-{
-    /*
-     * The gc of the parameter is tied to the VPN session, create a
-     * short lived gc arena that is only valid for the duration of
-     * this function
-     */
-    struct gc_arena gc_tmp = gc_new();
-
-    const char *peer_ncp_list = tls_peer_ncp_list(peer_info, &gc_tmp);
-    char *tmp_ciphers = string_alloc(server_list, &gc_tmp);
-
-    const char *token = strsep(&tmp_ciphers, ":");
-    while (token)
-    {
-        if (tls_item_in_cipher_list(token, peer_ncp_list)
-            || streq(token, remote_cipher))
-        {
-            break;
-        }
-        token = strsep(&tmp_ciphers, ":");
-    }
-    /* We have not found a common cipher, as a last resort check if the
-     * server cipher can be used
-     */
-    if (token == NULL
-        && (tls_item_in_cipher_list(server_cipher, peer_ncp_list)
-            || streq(server_cipher, remote_cipher)))
-    {
-        token = server_cipher;
-    }
-
-    char *ret = NULL;
-    if (token != NULL)
-    {
-        ret = string_alloc(token, gc);
-    }
-
-    gc_free(&gc_tmp);
-    return ret;
-}
-
-void
-tls_poor_mans_ncp(struct options *o, const char *remote_ciphername)
-{
-    if (o->ncp_enabled && remote_ciphername
-        && 0 != strcmp(o->ciphername, remote_ciphername))
-    {
-        if (tls_item_in_cipher_list(remote_ciphername, o->ncp_ciphers))
-        {
-            o->ciphername = string_alloc(remote_ciphername, &o->gc);
-            msg(D_TLS_DEBUG_LOW, "Using peer cipher '%s'", o->ciphername);
-        }
-    }
-}
-
 /**
  * Generate data channel keys for the supplied TLS session.
  *
@@ -2644,28 +2533,6 @@ error:
     return false;
 }
 
-/**
- * Returns whether the client supports NCP either by
- * announcing IV_NCP>=2 or the IV_CIPHERS list
- */
-static bool
-tls_peer_supports_ncp(const char *peer_info)
-{
-    if (!peer_info)
-    {
-        return false;
-    }
-    else if (tls_peer_info_ncp_ver(peer_info) >= 2
-             || strstr(peer_info, "IV_CIPHERS="))
-    {
-        return true;
-    }
-    else
-    {
-        return false;
-    }
-}
-
 static bool
 key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_session *session)
 {
@@ -4255,45 +4122,6 @@ tls_update_remote_addr(struct tls_multi *multi, const struct link_socket_actual
     gc_free(&gc);
 }
 
-int
-tls_peer_info_ncp_ver(const char *peer_info)
-{
-    const char *ncpstr = peer_info ? strstr(peer_info, "IV_NCP=") : NULL;
-    if (ncpstr)
-    {
-        int ncp = 0;
-        int r = sscanf(ncpstr, "IV_NCP=%d", &ncp);
-        if (r == 1)
-        {
-            return ncp;
-        }
-    }
-    return 0;
-}
-
-bool
-tls_check_ncp_cipher_list(const char *list)
-{
-    bool unsupported_cipher_found = false;
-
-    ASSERT(list);
-
-    char *const tmp_ciphers = string_alloc(list, NULL);
-    const char *token = strtok(tmp_ciphers, ":");
-    while (token)
-    {
-        if (!cipher_kt_get(translate_cipher_name_from_openvpn(token)))
-        {
-            msg(M_WARN, "Unsupported cipher in --ncp-ciphers: %s", token);
-            unsupported_cipher_found = true;
-        }
-        token = strtok(NULL, ":");
-    }
-    free(tmp_ciphers);
-
-    return 0 < strlen(list) && !unsupported_cipher_found;
-}
-
 void
 show_available_tls_ciphers(const char *cipher_list,
                            const char *cipher_list_tls13,
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 2a8871ed..3449d91e 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -489,15 +489,6 @@ bool tls_session_update_crypto_params(struct tls_session *session,
                                       struct frame *frame,
                                       struct frame *frame_fragment);
 
-/**
- * "Poor man's NCP": Use peer cipher if it is an allowed (NCP) cipher.
- * Allows non-NCP peers to upgrade their cipher individually.
- *
- * Make sure to call tls_session_update_crypto_params() after calling this
- * function.
- */
-void tls_poor_mans_ncp(struct options *o, const char *remote_ciphername);
-
 #ifdef MANAGEMENT_DEF_AUTH
 static inline char *
 tls_get_peer_info(const struct tls_multi *multi)
@@ -506,62 +497,6 @@ tls_get_peer_info(const struct tls_multi *multi)
 }
 #endif
 
-/**
- * Return the Negotiable Crypto Parameters version advertised in the peer info
- * string, or 0 if none specified.
- */
-int tls_peer_info_ncp_ver(const char *peer_info);
-
-/**
- * Iterates through the ciphers in server_list and return the first
- * cipher that is also supported by the peer according to the IV_NCP
- * and IV_CIPHER values in peer_info.
- *
- * We also accept a cipher that is the remote cipher of the client for
- * "Poor man's NCP": Use peer cipher if it is an allowed (NCP) cipher.
- * Allows non-NCP peers to upgrade their cipher individually.
- *
- * Make sure to call tls_session_update_crypto_params() after calling this
- * function.
- *
- * @param gc   gc arena that is ONLY used to allocate the returned string
- *
- * @returns NULL if no common cipher is available, otherwise the best common
- * cipher
- */
-char *
-ncp_get_best_cipher(const char *server_list, const char *server_cipher,
-                    const char *peer_info, const char *remote_cipher,
-                    struct gc_arena *gc);
-
-
-/**
- * Returns the support cipher list from the peer according to the IV_NCP
- * and IV_CIPHER values in peer_info.
- *
- * @returns Either a string containing the ncp list that is either static
- * or allocated via gc. If no information is available an empty string
- * ("") is returned.
- */
-const char *
-tls_peer_ncp_list(const char *peer_info, struct gc_arena *gc);
-
-/**
- * Check whether the ciphers in the supplied list are supported.
- *
- * @param list          Colon-separated list of ciphers
- *
- * @returns true iff all ciphers in list are supported.
- */
-bool tls_check_ncp_cipher_list(const char *list);
-
-/**
- * Return true iff item is present in the colon-separated zero-terminated
- * cipher list.
- */
-bool tls_item_in_cipher_list(const char *item, const char *list);
-
-
 /*
  * inline functions
  */
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
new file mode 100644
index 00000000..919b81e8
--- /dev/null
+++ b/src/openvpn/ssl_ncp.c
@@ -0,0 +1,231 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2008-2013 David Sommerseth <dazo@...384...>
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
+ * @file Control Channel SSL/Data dynamic negotion Module
+ * This file is split from ssl.c to be able to unit test it.
+ */
+
+/*
+ * The routines in this file deal with dynamically negotiating
+ * the data channel HMAC and cipher keys through a TLS session.
+ *
+ * Both the TLS session and the data channel are multiplexed
+ * over the same TCP/UDP port.
+ */
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+#include "win32.h"
+
+#include "error.h"
+#include "common.h"
+
+#include "ssl_ncp.h"
+
+/**
+ * Return the Negotiable Crypto Parameters version advertised in the peer info
+ * string, or 0 if none specified.
+ */
+static int
+tls_peer_info_ncp_ver(const char *peer_info)
+{
+    const char *ncpstr = peer_info ? strstr(peer_info, "IV_NCP=") : NULL;
+    if (ncpstr)
+    {
+        int ncp = 0;
+        int r = sscanf(ncpstr, "IV_NCP=%d", &ncp);
+        if (r == 1)
+        {
+            return ncp;
+        }
+    }
+    return 0;
+}
+
+/**
+ * Returns whether the client supports NCP either by
+ * announcing IV_NCP>=2 or the IV_CIPHERS list
+ */
+bool
+tls_peer_supports_ncp(const char *peer_info)
+{
+    if (!peer_info)
+    {
+        return false;
+    }
+    else if (tls_peer_info_ncp_ver(peer_info) >= 2
+             || strstr(peer_info, "IV_CIPHERS="))
+    {
+        return true;
+    }
+    else
+    {
+        return false;
+    }
+}
+
+bool
+tls_check_ncp_cipher_list(const char *list)
+{
+    bool unsupported_cipher_found = false;
+
+    ASSERT(list);
+
+    char *const tmp_ciphers = string_alloc(list, NULL);
+    const char *token = strtok(tmp_ciphers, ":");
+    while (token)
+    {
+        if (!cipher_kt_get(translate_cipher_name_from_openvpn(token)))
+        {
+            msg(M_WARN, "Unsupported cipher in --ncp-ciphers: %s", token);
+            unsupported_cipher_found = true;
+        }
+        token = strtok(NULL, ":");
+    }
+    free(tmp_ciphers);
+
+    return 0 < strlen(list) && !unsupported_cipher_found;
+}
+
+bool
+tls_item_in_cipher_list(const char *item, const char *list)
+{
+    char *tmp_ciphers = string_alloc(list, NULL);
+    char *tmp_ciphers_orig = tmp_ciphers;
+
+    const char *token = strtok(tmp_ciphers, ":");
+    while (token)
+    {
+        if (0 == strcmp(token, item))
+        {
+            break;
+        }
+        token = strtok(NULL, ":");
+    }
+    free(tmp_ciphers_orig);
+
+    return token != NULL;
+}
+
+const char *
+tls_peer_ncp_list(const char *peer_info, struct gc_arena *gc)
+{
+    /* Check if the peer sends the IV_CIPHERS list */
+    const char *ncp_ciphers_start;
+    if (peer_info && (ncp_ciphers_start = strstr(peer_info, "IV_CIPHERS=")))
+    {
+        ncp_ciphers_start += strlen("IV_CIPHERS=");
+        const char *ncp_ciphers_end = strstr(ncp_ciphers_start, "\n");
+        if (!ncp_ciphers_end)
+        {
+            /* IV_CIPHERS is at end of the peer_info list and no '\n'
+             * follows */
+            ncp_ciphers_end = ncp_ciphers_start + strlen(ncp_ciphers_start);
+        }
+
+        char *ncp_ciphers_peer = string_alloc(ncp_ciphers_start, gc);
+        /* NULL terminate the copy at the right position */
+        ncp_ciphers_peer[ncp_ciphers_end - ncp_ciphers_start] = '\0';
+        return ncp_ciphers_peer;
+
+    }
+    else if (tls_peer_info_ncp_ver(peer_info)>=2)
+    {
+        /* If the peer announces IV_NCP=2 then it supports the AES GCM
+         * ciphers */
+        return "AES-256-GCM:AES-128-GCM";
+    }
+    else
+    {
+        return "";
+    }
+}
+
+char *
+ncp_get_best_cipher(const char *server_list, const char *server_cipher,
+                    const char *peer_info,  const char *remote_cipher,
+                    struct gc_arena *gc)
+{
+    /*
+     * The gc of the parameter is tied to the VPN session, create a
+     * short lived gc arena that is only valid for the duration of
+     * this function
+     */
+
+    struct gc_arena gc_tmp = gc_new();
+
+    const char *peer_ncp_list = tls_peer_ncp_list(peer_info, &gc_tmp);
+
+    char *tmp_ciphers = string_alloc(server_list, &gc_tmp);
+
+    const char *token = strsep(&tmp_ciphers, ":");
+    while (token)
+    {
+        if (tls_item_in_cipher_list(token, peer_ncp_list)
+            || streq(token, remote_cipher))
+        {
+            break;
+        }
+        token = strsep(&tmp_ciphers, ":");
+    }
+    /* We have not found a common cipher, as a last resort check if the
+     * server cipher can be used
+     */
+    if (token == NULL
+        && (tls_item_in_cipher_list(server_cipher, peer_ncp_list)
+            || streq(server_cipher, remote_cipher)))
+    {
+        token = server_cipher;
+    }
+
+    char *ret = NULL;
+    if (token != NULL)
+    {
+        ret = string_alloc(token, gc);
+    }
+
+    gc_free(&gc_tmp);
+    return ret;
+}
+
+void
+tls_poor_mans_ncp(struct options *o, const char *remote_ciphername)
+{
+    if (o->ncp_enabled && remote_ciphername
+        && 0 != strcmp(o->ciphername, remote_ciphername))
+    {
+        if (tls_item_in_cipher_list(remote_ciphername, o->ncp_ciphers))
+        {
+            o->ciphername = string_alloc(remote_ciphername, &o->gc);
+            msg(D_TLS_DEBUG_LOW, "Using peer cipher '%s'", o->ciphername);
+        }
+    }
+}
+
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
new file mode 100644
index 00000000..1257b2b6
--- /dev/null
+++ b/src/openvpn/ssl_ncp.h
@@ -0,0 +1,101 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2010-2018 Fox Crypto B.V. <openvpn@...1435...>
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
+ * @file Control Channel SSL/Data dynamic negotion Module
+ * This file is split from ssl.h to be able to unit test it.
+ */
+
+#ifndef OPENVPN_SSL_NCP_H
+#define OPENVPN_SSL_NCP_H
+
+#include "buffer.h"
+#include "options.h"
+
+/**
+ * Returns whether the client supports NCP either by
+ * announcing IV_NCP>=2 or the IV_CIPHERS list
+ */
+bool
+tls_peer_supports_ncp(const char *peer_info);
+
+/**
+ * "Poor man's NCP": Use peer cipher if it is an allowed (NCP) cipher.
+ * Allows non-NCP peers to upgrade their cipher individually.
+ *
+ * Make sure to call tls_session_update_crypto_params() after calling this
+ * function.
+ */
+void tls_poor_mans_ncp(struct options *o, const char *remote_ciphername);
+
+/**
+ * Iterates through the ciphers in server_list and return the first
+ * cipher that is also supported by the peer according to the IV_NCP
+ * and IV_CIPHER values in peer_info.
+ *
+ * We also accept a cipher that is the remote cipher of the client for
+ * "Poor man's NCP": Use peer cipher if it is an allowed (NCP) cipher.
+ * Allows non-NCP peers to upgrade their cipher individually.
+ *
+ * Make sure to call tls_session_update_crypto_params() after calling this
+ * function.
+ *
+ * @param gc   gc arena that is ONLY used to allocate the returned string
+ *
+ * @returns NULL if no common cipher is available, otherwise the best common
+ * cipher
+ */
+char *
+ncp_get_best_cipher(const char *server_list, const char *server_cipher,
+                    const char *peer_info, const char *remote_cipher,
+                    struct gc_arena *gc);
+
+
+/**
+ * Returns the support cipher list from the peer according to the IV_NCP
+ * and IV_CIPHER values in peer_info.
+ *
+ * @returns Either a string containing the ncp list that is either static
+ * or allocated via gc. If no information is available an empty string
+ * ("") is returned.
+ */
+const char *
+tls_peer_ncp_list(const char *peer_info, struct gc_arena *gc);
+
+/**
+ * Check whether the ciphers in the supplied list are supported.
+ *
+ * @param list          Colon-separated list of ciphers
+ *
+ * @returns true iff all ciphers in list are supported.
+ */
+bool tls_check_ncp_cipher_list(const char *list);
+
+/**
+ * Return true iff item is present in the colon-separated zero-terminated
+ * cipher list.
+ */
+bool tls_item_in_cipher_list(const char *item, const char *list);
+
+#endif /* ifndef OPENVPN_SSL_NCP_H */
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 60e84639..f0880a6b 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -6,7 +6,7 @@ if HAVE_LD_WRAP_SUPPORT
 test_binaries += argv_testdriver buffer_testdriver
 endif
 
-test_binaries += crypto_testdriver packet_id_testdriver auth_token_testdriver
+test_binaries += crypto_testdriver packet_id_testdriver auth_token_testdriver ncp_testdriver
 if HAVE_LD_WRAP_SUPPORT
 test_binaries += tls_crypt_testdriver
 endif
@@ -110,3 +110,19 @@ auth_token_testdriver_SOURCES = test_auth_token.c mock_msg.c \
 	$(openvpn_srcdir)/packet_id.c \
 	$(openvpn_srcdir)/platform.c \
 	$(openvpn_srcdir)/base64.c
+
+
+ncp_testdriver_CFLAGS  = @TEST_CFLAGS@ \
+	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir) \
+	$(OPTIONAL_CRYPTO_CFLAGS)
+ncp_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
+	$(OPTIONAL_CRYPTO_LIBS)
+
+ncp_testdriver_SOURCES = test_ncp.c mock_msg.c \
+	$(openvpn_srcdir)/buffer.c \
+	$(openvpn_srcdir)/crypto.c \
+	$(openvpn_srcdir)/crypto_mbedtls.c \
+	$(openvpn_srcdir)/crypto_openssl.c \
+	$(openvpn_srcdir)/otime.c \
+	$(openvpn_srcdir)/packet_id.c \
+	$(openvpn_srcdir)/platform.c
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
new file mode 100644
index 00000000..3fc886c5
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -0,0 +1,184 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2019 Arne Schwabe <arne@...1227...>
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
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <setjmp.h>
+#include <cmocka.h>
+
+#include "ssl_ncp.c"
+
+/* Defines for use in the tests and the mock parse_line() */
+
+const char *bf_chacha = "BF-CBC:CHACHA20-POLY1305";
+const char *aes_ciphers = "AES-256-GCM:AES-128-GCM";
+
+static void
+test_check_ncp_ciphers_list(void **state)
+{
+    bool have_chacha = cipher_kt_get("CHACHA20-POLY1305");
+
+    assert_true(tls_check_ncp_cipher_list(aes_ciphers));
+    assert_true(have_chacha == tls_check_ncp_cipher_list(bf_chacha));
+    assert_false(tls_check_ncp_cipher_list("vollbit"));
+    assert_false(tls_check_ncp_cipher_list("AES-256-GCM:vollbit"));
+}
+
+static void
+test_extract_client_ciphers(void **state)
+{
+    struct gc_arena gc = gc_new();
+    const char *client_peer_info;
+    const char *peer_list;
+
+    client_peer_info = "foo=bar\nIV_foo=y\nIV_NCP=2";
+    peer_list = tls_peer_ncp_list(client_peer_info, &gc);
+    assert_string_equal(aes_ciphers,peer_list);
+    assert_true(tls_peer_supports_ncp(client_peer_info));
+
+    client_peer_info = "foo=bar\nIV_foo=y\nIV_NCP=2\nIV_CIPHERS=BF-CBC";
+    peer_list = tls_peer_ncp_list(client_peer_info, &gc);
+    assert_string_equal("BF-CBC", peer_list);
+    assert_true(tls_peer_supports_ncp(client_peer_info));
+
+    client_peer_info = "IV_NCP=2\nIV_CIPHERS=BF-CBC:FOO-BAR\nIV_BAR=7";
+    peer_list = tls_peer_ncp_list(client_peer_info, &gc);
+    assert_string_equal("BF-CBC:FOO-BAR", peer_list);
+    assert_true(tls_peer_supports_ncp(client_peer_info));
+
+    client_peer_info = "IV_CIPHERS=BF-CBC:FOO-BAR\nIV_BAR=7";
+    peer_list = tls_peer_ncp_list(client_peer_info, &gc);
+    assert_string_equal("BF-CBC:FOO-BAR", peer_list);
+    assert_true(tls_peer_supports_ncp(client_peer_info));
+
+    client_peer_info = "IV_YOLO=NO\nIV_BAR=7";
+    peer_list = tls_peer_ncp_list(client_peer_info, &gc);
+    assert_string_equal("", peer_list);
+    assert_false(tls_peer_supports_ncp(client_peer_info));
+
+    peer_list = tls_peer_ncp_list(NULL, &gc);
+    assert_string_equal("", peer_list);
+    assert_false(tls_peer_supports_ncp(client_peer_info));
+
+    gc_free(&gc);
+}
+
+static void
+test_poor_man(void **state)
+{
+    struct gc_arena gc = gc_new();
+    char *best_cipher;
+
+    const char *serverlist="CHACHA20_POLY1305:AES-128-GCM";
+
+    best_cipher = ncp_get_best_cipher(serverlist, "BF-CBC",
+                                      "IV_YOLO=NO\nIV_BAR=7",
+                                      "BF-CBC", &gc);
+
+    assert_string_equal(best_cipher, "BF-CBC");
+
+    best_cipher = ncp_get_best_cipher(serverlist, "BF-CBC",
+                                      "IV_NCP=1\nIV_BAR=7",
+                                      "AES-128-GCM", &gc);
+
+    assert_string_equal(best_cipher, "AES-128-GCM");
+
+    best_cipher = ncp_get_best_cipher(serverlist, "BF-CBC",
+                                      NULL,
+                                      "AES-128-GCM", &gc);
+
+    assert_string_equal(best_cipher, "AES-128-GCM");
+
+    gc_free(&gc);
+}
+
+
+static void
+test_ncp_best(void **state)
+{
+    struct gc_arena gc = gc_new();
+    char *best_cipher;
+
+    const char *serverlist="CHACHA20_POLY1305:AES-128-GCM:AES-256-GCM";
+
+    best_cipher = ncp_get_best_cipher(serverlist, "BF-CBC",
+                                      "IV_YOLO=NO\nIV_NCP=2\nIV_BAR=7",
+                                      "BF-CBC", &gc);
+
+    assert_string_equal(best_cipher, "AES-128-GCM");
+
+    /* Best cipher is in --cipher of client */
+    best_cipher = ncp_get_best_cipher(serverlist, "BF-CBC",
+                                      "IV_NCP=2\nIV_BAR=7",
+                                      "CHACHA20_POLY1305", &gc);
+
+    assert_string_equal(best_cipher, "CHACHA20_POLY1305");
+
+    /* Best cipher is in --cipher of client */
+    best_cipher = ncp_get_best_cipher(serverlist, "BF-CBC",
+                                      "IV_CIPHERS=AES-128-GCM",
+                                      "AES-256-CBC", &gc);
+
+
+    assert_string_equal(best_cipher, "AES-128-GCM");
+
+    /* IV_NCP=2 should be ignored if IV_CIPHERS is sent */
+    best_cipher = ncp_get_best_cipher(serverlist, "BF-CBC",
+                                      "IV_FOO=7\nIV_CIPHERS=AES-256-GCM\nIV_NCP=2",
+                                      "AES-256-CBC", &gc);
+
+    assert_string_equal(best_cipher, "AES-256-GCM");
+
+
+    gc_free(&gc);
+}
+
+
+
+
+const struct CMUnitTest ncp_tests[] = {
+    cmocka_unit_test(test_check_ncp_ciphers_list),
+    cmocka_unit_test(test_extract_client_ciphers),
+    cmocka_unit_test(test_poor_man),
+    cmocka_unit_test(test_ncp_best)
+};
+
+
+int main(void)
+{
+#if defined(ENABLE_CRYPTO_OPENSSL)
+    OpenSSL_add_all_algorithms();
+#endif
+    return cmocka_run_group_tests(ncp_tests, NULL, NULL);
+}
-- 
2.25.0


