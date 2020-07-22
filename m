From: Arne Schwabe <arne@...1227...>
Date: Wed, 22 Jul 2020 11:30:49 +0200
Message-Id: <20200722093050.20474-2-arne@...1227...>
In-Reply-To: <20200722093050.20474-1-arne@...1227...>
References: <20200722093050.20474-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/3] Cleanup tls_pre_decrypt_lite and
 tls_pre_encrypt
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

Mostly C90 -> C99 cleanups and again immediately instead
wrapping function body into if.

(Review with ignore whitespace)

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c | 219 ++++++++++++++++++++++------------------------
 1 file changed, 106 insertions(+), 113 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 6d146a63..916d2d37 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3696,100 +3696,91 @@ tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
                      const struct buffer *buf)
 
 {
-    struct gc_arena gc = gc_new();
-    bool ret = false;
-
-    if (buf->len > 0)
+    if (buf->len <= 0)
     {
-        int op;
-        int key_id;
+        return false;
+    }
+    struct gc_arena gc = gc_new();
 
-        /* get opcode and key ID */
-        {
-            uint8_t c = *BPTR(buf);
-            op = c >> P_OPCODE_SHIFT;
-            key_id = c & P_KEY_ID_MASK;
-        }
+    /* get opcode and key ID */
+    uint8_t pkt_firstbyte = *BPTR(buf);
+    int op = pkt_firstbyte >> P_OPCODE_SHIFT;
+    int key_id = pkt_firstbyte & P_KEY_ID_MASK;
 
-        /* this packet is from an as-yet untrusted source, so
-         * scrutinize carefully */
+    /* this packet is from an as-yet untrusted source, so
+     * scrutinize carefully */
 
-        if (op != P_CONTROL_HARD_RESET_CLIENT_V2
-            && op != P_CONTROL_HARD_RESET_CLIENT_V3)
-        {
-            /*
-             * This can occur due to bogus data or DoS packets.
-             */
-            dmsg(D_TLS_STATE_ERRORS,
-                 "TLS State Error: No TLS state for client %s, opcode=%d",
-                 print_link_socket_actual(from, &gc),
-                 op);
-            goto error;
-        }
+    if (op != P_CONTROL_HARD_RESET_CLIENT_V2
+        && op != P_CONTROL_HARD_RESET_CLIENT_V3)
+    {
+        /*
+         * This can occur due to bogus data or DoS packets.
+         */
+        dmsg(D_TLS_STATE_ERRORS,
+             "TLS State Error: No TLS state for client %s, opcode=%d",
+             print_link_socket_actual(from, &gc),
+             op);
+        goto error;
+    }
 
-        if (key_id != 0)
-        {
-            dmsg(D_TLS_STATE_ERRORS,
-                 "TLS State Error: Unknown key ID (%d) received from %s -- 0 was expected",
-                 key_id,
-                 print_link_socket_actual(from, &gc));
-            goto error;
-        }
+    if (key_id != 0)
+    {
+        dmsg(D_TLS_STATE_ERRORS,
+             "TLS State Error: Unknown key ID (%d) received from %s -- 0 was expected",
+             key_id,
+             print_link_socket_actual(from, &gc));
+        goto error;
+    }
 
-        if (buf->len > EXPANDED_SIZE_DYNAMIC(&tas->frame))
-        {
-            dmsg(D_TLS_STATE_ERRORS,
-                 "TLS State Error: Large packet (size %d) received from %s -- a packet no larger than %d bytes was expected",
-                 buf->len,
-                 print_link_socket_actual(from, &gc),
-                 EXPANDED_SIZE_DYNAMIC(&tas->frame));
-            goto error;
-        }
+    if (buf->len > EXPANDED_SIZE_DYNAMIC(&tas->frame))
+    {
+        dmsg(D_TLS_STATE_ERRORS,
+             "TLS State Error: Large packet (size %d) received from %s -- a packet no larger than %d bytes was expected",
+             buf->len,
+             print_link_socket_actual(from, &gc),
+             EXPANDED_SIZE_DYNAMIC(&tas->frame));
+        goto error;
+    }
 
-        {
-            struct buffer newbuf = clone_buf(buf);
-            struct tls_wrap_ctx tls_wrap_tmp = tas->tls_wrap;
-            bool status;
-
-            /* HMAC test, if --tls-auth was specified */
-            status = read_control_auth(&newbuf, &tls_wrap_tmp, from, NULL);
-            free_buf(&newbuf);
-            free_buf(&tls_wrap_tmp.tls_crypt_v2_metadata);
-            if (tls_wrap_tmp.cleanup_key_ctx)
-            {
-                free_key_ctx_bi(&tls_wrap_tmp.opt.key_ctx_bi);
-            }
-            if (!status)
-            {
-                goto error;
-            }
 
-            /*
-             * At this point, if --tls-auth is being used, we know that
-             * the packet has passed the HMAC test, but we don't know if
-             * it is a replay yet.  We will attempt to defeat replays
-             * by not advancing to the S_START state until we
-             * receive an ACK from our first reply to the client
-             * that includes an HMAC of our randomly generated 64 bit
-             * session ID.
-             *
-             * On the other hand if --tls-auth is not being used, we
-             * will proceed to begin the TLS authentication
-             * handshake with only cursory integrity checks having
-             * been performed, since we will be leaving the task
-             * of authentication solely up to TLS.
-             */
+    struct buffer newbuf = clone_buf(buf);
+    struct tls_wrap_ctx tls_wrap_tmp = tas->tls_wrap;
 
-            ret = true;
-        }
+    /* HMAC test, if --tls-auth was specified */
+    bool status = read_control_auth(&newbuf, &tls_wrap_tmp, from, NULL);
+    free_buf(&newbuf);
+    free_buf(&tls_wrap_tmp.tls_crypt_v2_metadata);
+    if (tls_wrap_tmp.cleanup_key_ctx)
+    {
+        free_key_ctx_bi(&tls_wrap_tmp.opt.key_ctx_bi);
+    }
+    if (!status)
+    {
+        goto error;
     }
+
+    /*
+     * At this point, if --tls-auth is being used, we know that
+     * the packet has passed the HMAC test, but we don't know if
+     * it is a replay yet.  We will attempt to defeat replays
+     * by not advancing to the S_START state until we
+     * receive an ACK from our first reply to the client
+     * that includes an HMAC of our randomly generated 64 bit
+     * session ID.
+     *
+     * On the other hand if --tls-auth is not being used, we
+     * will proceed to begin the TLS authentication
+     * handshake with only cursory integrity checks having
+     * been performed, since we will be leaving the task
+     * of authentication solely up to TLS.
+     */
     gc_free(&gc);
-    return ret;
+    return true;
 
 error:
     tls_clear_error();
     gc_free(&gc);
-    return ret;
+    return false;
 }
 
 /* Choose the key with which to encrypt a data packet */
@@ -3798,48 +3789,50 @@ tls_pre_encrypt(struct tls_multi *multi,
                 struct buffer *buf, struct crypto_options **opt)
 {
     multi->save_ks = NULL;
-    if (buf->len > 0)
+    if (buf->len <= 0)
     {
-        int i;
-        struct key_state *ks_select = NULL;
-        for (i = 0; i < KEY_SCAN_SIZE; ++i)
+        buf->len = 0;
+        opt = NULL;
+    }
+
+    struct key_state *ks_select = NULL;
+    for (int i = 0; i < KEY_SCAN_SIZE; ++i)
+    {
+        struct key_state *ks = multi->key_scan[i];
+        if (ks->state >= S_ACTIVE
+            && (ks->authenticated == KS_AUTH_TRUE)
+            && ks->crypto_options.key_ctx_bi.initialized
+            )
         {
-            struct key_state *ks = multi->key_scan[i];
-            if (ks->state >= S_ACTIVE
-                && (ks->authenticated == KS_AUTH_TRUE)
-                && ks->crypto_options.key_ctx_bi.initialized
-                )
+            if (!ks_select)
             {
-                if (!ks_select)
-                {
-                    ks_select = ks;
-                }
-                if (now >= ks->auth_deferred_expire)
-                {
-                    ks_select = ks;
-                    break;
-                }
+                ks_select = ks;
+            }
+            if (now >= ks->auth_deferred_expire)
+            {
+                ks_select = ks;
+                break;
             }
         }
+    }
 
-        if (ks_select)
-        {
-            *opt = &ks_select->crypto_options;
-            multi->save_ks = ks_select;
-            dmsg(D_TLS_KEYSELECT, "TLS: tls_pre_encrypt: key_id=%d", ks_select->key_id);
-            return;
-        }
-        else
-        {
-            struct gc_arena gc = gc_new();
-            dmsg(D_TLS_KEYSELECT, "TLS Warning: no data channel send key available: %s",
-                 print_key_id(multi, &gc));
-            gc_free(&gc);
-        }
+    if (ks_select)
+    {
+        *opt = &ks_select->crypto_options;
+        multi->save_ks = ks_select;
+        dmsg(D_TLS_KEYSELECT, "TLS: tls_pre_encrypt: key_id=%d", ks_select->key_id);
+        return;
     }
+    else
+    {
+        struct gc_arena gc = gc_new();
+        dmsg(D_TLS_KEYSELECT, "TLS Warning: no data channel send key available: %s",
+             print_key_id(multi, &gc));
+        gc_free(&gc);
 
-    buf->len = 0;
-    *opt = NULL;
+        *opt = NULL;
+        buf->len = 0;
+    }
 }
 
 void
-- 
2.26.2


