From: Arne Schwabe <arne@...1227...>
Date: Sun, 30 Aug 2020 16:07:35 +0200
Message-Id: <20200830140736.16571-2-arne@...1227...>
In-Reply-To: <20200830140736.16571-1-arne@...1227...>
References: <20200830140736.16571-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/2] Normalise ncp-ciphers option and
 restrict it to 127 bytes
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

In scenarios of mbed TLS vs OpenSSL we already normalise the ciphers
that are send via the wire protocol via OCC to not have a mismatch
warning between server and client. This is done by
translate_cipher_name_from_openvpn. The same applies also to the
ncp-ciphers list. Specifying non normalised names in ncp-ciphers will
cause negotation not to succeed if ciphers are not in the same form.
Therefore we will normalise the ciphers in options_postmutate.

The alternative and a lot less user friendly alternative would be to
bail if on of the ciphers in ncp-ciphers is not in its normalised form.

Also restrict the ncp-ciphers list to 127. This is somewhat arbitrary
but should prevent too large IV_CIPHER messages and problems sending
those. The server will accept also large IV_CIPHER values from clients.

Cherry picked from be4531564e2be7c8a0222e6923e3f7580b358cab and adjusted
for 2.4 (methods added to ssl.h/ssl.c instead ssl_ncp.c/.h

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/openvpn.8         |   2 +
 src/openvpn/options.c |   9 ++++
 src/openvpn/ssl.c     |  63 +++++++++++++++++++++++
 src/openvpn/ssl.h     |  23 +++++++++
 src/openvpn/ssl_ncp.h | 116 ++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 213 insertions(+)
 create mode 100644 src/openvpn/ssl_ncp.h

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 8038e1f4..77cc361d 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4273,6 +4273,8 @@ NCP server (v2.4+) with "\-\-cipher BF\-CBC" and "\-\-ncp\-ciphers
 AES\-256\-GCM:AES\-256\-CBC" set can either specify "\-\-cipher BF\-CBC" or
 "\-\-cipher AES\-256\-CBC" and both will work.
 
+This list is restricted to be 127 chars long after conversion to OpenVPN
+ciphers.
 .\"*********************************************************
 .TP
 .B \-\-ncp\-disable
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index de30fcb0..f69bbb22 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2982,6 +2982,15 @@ options_postprocess_mutate(struct options *o)
 
     options_postprocess_mutate_invariant(o);
 
+    if (o->ncp_enabled)
+    {
+        o->ncp_ciphers = mutate_ncp_cipher_list(o->ncp_ciphers, &o->gc);
+        if (o->ncp_ciphers == NULL)
+        {
+            msg(M_USAGE, "NCP cipher list contains unsupported ciphers or is too long.");
+        }
+    }
+
     if (o->remote_list && !o->connection_list)
     {
         /*
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 215147f3..dd9c52fb 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -4318,6 +4318,69 @@ delayed_auth_pass_purge(void)
     purge_user_pass(&auth_user_pass, false);
 }
 
+char *
+mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
+{
+    bool error_found = false;
+
+    struct buffer new_list  = alloc_buf(MAX_NCP_CIPHERS_LENGTH);
+
+    char *const tmp_ciphers = string_alloc(list, NULL);
+    const char *token = strtok(tmp_ciphers, ":");
+    while (token)
+    {
+        /*
+         * Going through a roundtrip by using translate_cipher_name_from_openvpn
+         * and translate_cipher_name_to_openvpn also normalises the cipher name,
+         * e.g. replacing AeS-128-gCm with AES-128-GCM
+         */
+        const char *cipher_name = translate_cipher_name_from_openvpn(token);
+        const cipher_kt_t *ktc = cipher_kt_get(cipher_name);
+        if (!ktc)
+        {
+            msg(M_WARN, "Unsupported cipher in --ncp-ciphers: %s", token);
+            error_found = true;
+        }
+        else
+        {
+            const char *ovpn_cipher_name =
+                translate_cipher_name_to_openvpn(cipher_kt_name(ktc));
+
+            if (buf_len(&new_list)> 0)
+            {
+                /* The next if condition ensure there is always space for
+                 * a :
+                 */
+                buf_puts(&new_list, ":");
+            }
+
+            /* Ensure buffer has capacity for cipher name + : + \0 */
+            if (!(buf_forward_capacity(&new_list) >
+                  strlen(ovpn_cipher_name) + 2))
+            {
+                msg(M_WARN, "Length of --ncp-ciphers is over the "
+                    "limit of 127 chars");
+                error_found = true;
+            }
+            else
+            {
+                buf_puts(&new_list, ovpn_cipher_name);
+            }
+        }
+        token = strtok(NULL, ":");
+    }
+
+    char *ret = NULL;
+    if (!error_found && buf_len(&new_list) > 0)
+    {
+        buf_null_terminate(&new_list);
+        ret = string_alloc(buf_str(&new_list), gc);
+    }
+    free(tmp_ciphers);
+    free_buf(&new_list);
+
+    return ret;
+}
 #else  /* if defined(ENABLE_CRYPTO) */
 static void
 dummy(void)
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 3266f386..703de99b 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -527,6 +527,29 @@ bool tls_check_ncp_cipher_list(const char *list);
  */
 bool tls_item_in_cipher_list(const char *item, const char *list);
 
+/**
+ * Check whether the ciphers in the supplied list are supported.
+ *
+ * @param list          Colon-separated list of ciphers
+ * @parms gc            gc_arena to allocate the returned string
+ *
+ * @returns             colon separated string of normalised (via
+ *                      translate_cipher_name_from_openvpn) and
+ *                      zero terminated string iff all ciphers
+ *                      in list are supported and the total length
+ *                      is short than MAX_NCP_CIPHERS_LENGTH. NULL
+ *                      otherwise.
+ */
+char *
+mutate_ncp_cipher_list(const char *list, struct gc_arena *gc);
+
+/**
+ * The maximum length of a ncp-cipher string that is accepted.
+ *
+ * Since this list needs to be pushed as IV_CIPHERS, we are conservative
+ * about its length.
+ */
+#define MAX_NCP_CIPHERS_LENGTH 127
 
 /*
  * inline functions
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
new file mode 100644
index 00000000..d00c222d
--- /dev/null
+++ b/src/openvpn/ssl_ncp.h
@@ -0,0 +1,116 @@
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
+ * @parms gc            gc_arena to allocate the returned string
+ *
+ * @returns             colon separated string of normalised (via
+ *                      translate_cipher_name_from_openvpn) and
+ *                      zero terminated string iff all ciphers
+ *                      in list are supported and the total length
+ *                      is short than MAX_NCP_CIPHERS_LENGTH. NULL
+ *                      otherwise.
+ */
+char *
+mutate_ncp_cipher_list(const char *list, struct gc_arena *gc);
+
+/**
+ * Return true iff item is present in the colon-separated zero-terminated
+ * cipher list.
+ */
+bool tls_item_in_cipher_list(const char *item, const char *list);
+
+/**
+ * The maximum length of a ncp-cipher string that is accepted.
+ *
+ * Since this list needs to be pushed as IV_CIPHERS, we are conservative
+ * about its length.
+ */
+#define MAX_NCP_CIPHERS_LENGTH 127
+
+#endif /* ifndef OPENVPN_SSL_NCP_H */
-- 
2.26.2


