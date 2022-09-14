From: Arne Schwabe <arne@...1227...>
Date: Wed, 14 Sep 2022 19:25:27 +0200
Message-Id: <20220914172527.2661529-1-arne@...1227...>
In-Reply-To: <20220824093723.64618-1-arne@...1227...>
References: <20220824093723.64618-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Improve data key id not found error
 message
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

With delayed data key generation now with deferred auth, NCP and similar
mechanism the "TLS Error: local/remote TLS keys are out of sync" is shown
much too frequent and confuses a lot of people.

This also removes the dead code of printing multi not ready keys and
replace it with an assert.

Factor out printing of error messages into an extra function to make
the code easier to understand and also to only call into that function
in the case that a key is not found and avoid the overhead.

Patch v2: fix comparing key_id to state value, improve message
Patch v3: also take key_id into account

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c | 75 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 57 insertions(+), 18 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 672cd9c84..c0d8add97 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3210,11 +3210,62 @@ nohard:
     return (tas == TLS_AUTHENTICATION_FAILED) ? TLSMP_KILL : active;
 }
 
-/*
- * Pre and post-process the encryption & decryption buffers in order
- * to implement a multiplexed TLS channel over the TCP/UDP port.
+/**
+ * We have not found a matching key to decrypt data channel packet,
+ * try to generate a sensible error message and print it
  */
+static void
+print_key_id_not_found_reason(struct tls_multi *multi,
+                              const struct link_socket_actual *from, int key_id)
+{
+    struct gc_arena gc = gc_new();
+    const char *source = print_link_socket_actual(from, &gc);
+
 
+    for (int i = 0; i < KEY_SCAN_SIZE; ++i)
+    {
+        struct key_state *ks = get_key_scan(multi, i);
+        if (ks->key_id != key_id)
+        {
+            continue;
+        }
+
+        /* Our key state has been progressed far enough to be part of a valid
+         * session but has not generated keys. */
+        if (ks->state >= S_INITIAL && ks->state < S_GENERATED_KEYS)
+        {
+            msg(D_MULTI_DROPPED,
+                "Key %s [%d] not initialized (yet), dropping packet.",
+                source, key_id);
+            gc_free(&gc);
+            return;
+        }
+        if (ks->state >= S_ACTIVE && ks->authenticated != KS_AUTH_TRUE)
+        {
+            msg(D_MULTI_DROPPED,
+                "Key %s [%d] not authorized%s, dropping packet.",
+                source, key_id,
+                (ks->authenticated == KS_AUTH_DEFERRED) ? " (deferred)" : "");
+            gc_free(&gc);
+            return;
+        }
+    }
+
+    msg(D_TLS_ERRORS,
+        "TLS Error: local/remote TLS keys are out of sync: %s "
+        "(received key id: %d, known key ids: %s)",
+        source, key_id,
+        print_key_id(multi, &gc));
+    gc_free(&gc);
+}
+
+/**
+ * Check the keyid of the an incoming data channel packet and
+ * return the matching crypto parameters in \c opt if found.
+ * Also move the \c buf to the start of the encrypted data, skipping
+ * the opcode and peer id header and setting also set \c ad_start for
+ * AEAD ciphers to the start of the authenticated data.
+ */
 static inline void
 handle_data_channel_packet(struct tls_multi *multi,
                            const struct link_socket_actual *from,
@@ -3229,7 +3280,6 @@ handle_data_channel_packet(struct tls_multi *multi,
     int op = c >> P_OPCODE_SHIFT;
     int key_id = c & P_KEY_ID_MASK;
 
-    /* data channel packet */
     for (int i = 0; i < KEY_SCAN_SIZE; ++i)
     {
         struct key_state *ks = get_key_scan(multi, i);
@@ -3251,14 +3301,7 @@ handle_data_channel_packet(struct tls_multi *multi,
             && ks->authenticated == KS_AUTH_TRUE
             && (floated || link_socket_actual_match(from, &ks->remote_addr)))
         {
-            if (!ks->crypto_options.key_ctx_bi.initialized)
-            {
-                msg(D_MULTI_DROPPED,
-                    "Key %s [%d] not initialized (yet), dropping packet.",
-                    print_link_socket_actual(from, &gc), key_id);
-                goto done;
-            }
-
+            ASSERT(ks->crypto_options.key_ctx_bi.initialized);
             /* return appropriate data channel decrypt key in opt */
             *opt = &ks->crypto_options;
             if (op == P_DATA_V2)
@@ -3292,17 +3335,13 @@ handle_data_channel_packet(struct tls_multi *multi,
         }
     }
 
-    msg(D_TLS_ERRORS,
-        "TLS Error: local/remote TLS keys are out of sync: %s "
-        "(received key id: %d, known key ids: %s)",
-        print_link_socket_actual(from, &gc), key_id,
-        print_key_id(multi, &gc));
+    print_key_id_not_found_reason(multi, from, key_id);
 
 done:
+    gc_free(&gc);
     tls_clear_error();
     buf->len = 0;
     *opt = NULL;
-    gc_free(&gc);
 }
 
 /*
-- 
2.37.0 (Apple Git-136)


