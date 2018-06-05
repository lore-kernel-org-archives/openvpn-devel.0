From: Antonio Quartulli <a@...2181...>
Date: Tue,  5 Jun 2018 11:29:01 +0800
Message-Id: <20180605032902.26440-2-a@...2181...>
In-Reply-To: <20180605032902.26440-1-a@...2181...>
References: <20180605032902.26440-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v2 2/3] make tls-auth a per-connection-block
 option
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
Cc: Antonio Quartulli <a@...2181...>, Steffan Karger <steffan@...1856...>

Different VPN servers may use different tls-auth keys. For this
reason it is convenient to make tls-auth a per-connection-block
option so that the user is allowed to specify one key per remote.

If no tls-auth option is specified in a given connection block,
the global one, if any, is used.

If persist-key is specified, tls-auth keys are pre-loaded during
startup (same as they were embeeded in the config file) so that
later there is no need to access the key files.

Trac: #720
Cc: Steffan Karger <steffan@...1856...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

v2:
- convert tls-auth keyfile to inline key if persist-key was specified

 doc/openvpn.8         |  2 +
 src/openvpn/init.c    | 10 ++---
 src/openvpn/options.c | 90 +++++++++++++++++++++++++++++++++++--------
 src/openvpn/options.h |  5 +++
 4 files changed, 85 insertions(+), 22 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 4114f408..8006ba29 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -361,6 +361,7 @@ block:
 .B fragment,
 .B http\-proxy,
 .B http\-proxy\-option,
+.B key\-direction,
 .B link\-mtu,
 .B local,
 .B lport,
@@ -372,6 +373,7 @@ block:
 .B remote,
 .B rport,
 .B socks\-proxy,
+.B tls\-auth,
 .B tun\-mtu and
 .B tun\-mtu\-extra.
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 15fef08d..22a74e36 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2504,7 +2504,7 @@ do_init_tls_wrap_key(struct context *c)
     const struct options *options = &c->options;
 
     /* TLS handshake authentication (--tls-auth) */
-    if (options->tls_auth_file)
+    if (options->ce.tls_auth_file)
     {
         /* Initialize key_type for tls-auth with auth only */
         CLEAR(c->c1.ks.tls_auth_key_type);
@@ -2522,9 +2522,9 @@ do_init_tls_wrap_key(struct context *c)
 
         crypto_read_openvpn_key(&c->c1.ks.tls_auth_key_type,
                                 &c->c1.ks.tls_wrap_key,
-                                options->tls_auth_file,
-                                options->tls_auth_file_inline,
-                                options->key_direction,
+                                options->ce.tls_auth_file,
+                                options->ce.tls_auth_file_inline,
+                                options->ce.key_direction,
                                 "Control Channel Authentication", "tls-auth");
     }
 
@@ -2803,7 +2803,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
 #endif
 
     /* TLS handshake authentication (--tls-auth) */
-    if (options->tls_auth_file)
+    if (options->ce.tls_auth_file)
     {
         to.tls_wrap.mode = TLS_WRAP_AUTH;
         to.tls_wrap.opt.key_ctx_bi = c->c1.ks.tls_wrap_key;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 426057ab..7357f189 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1506,6 +1506,10 @@ show_connection_entry(const struct connection_entry *o)
 #ifdef ENABLE_OCC
     SHOW_INT(explicit_exit_notification);
 #endif
+
+    SHOW_STR(tls_auth_file);
+    SHOW_PARM(key_direction, keydirection2ascii(o->key_direction, false, true),
+              "%s");
 }
 
 
@@ -1786,7 +1790,6 @@ show_settings(const struct options *o)
     SHOW_BOOL(push_peer_info);
     SHOW_BOOL(tls_exit);
 
-    SHOW_STR(tls_auth_file);
     SHOW_STR(tls_crypt_file);
 
 #ifdef ENABLE_PKCS11
@@ -2869,6 +2872,23 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
         }
     }
 
+    /*
+     * Set per-connection block tls-auth fields if no other method was defined
+     */
+    if (!ce->tls_auth_file)
+    {
+        ce->tls_auth_file = o->tls_auth_file;
+        ce->tls_auth_file_inline = o->tls_auth_file_inline;
+        ce->key_direction = o->key_direction;
+    }
+
+    /* pre-cache tls-auth key file if persist-key was specified */
+    if (ce->tls_auth_file && !ce->tls_auth_file_inline && o->persist_key)
+    {
+        struct buffer in = keyfile_to_buffer(ce->tls_auth_file, 2048, &o->gc);
+        ce->tls_auth_file = INLINE_FILE_TAG;
+        ce->tls_auth_file_inline = (char *)in.data;
+    }
 }
 
 #ifdef _WIN32
@@ -3285,12 +3305,20 @@ options_postprocess_filechecks(struct options *options)
                                          options->crl_file, R_OK, "--crl-verify");
     }
 
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
-                              options->tls_auth_file, R_OK, "--tls-auth");
+    ASSERT(options->connection_list);
+    for (int i = 0; i < options->connection_list->len; ++i)
+    {
+        struct connection_entry *ce = options->connection_list->array[i];
+
+        errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
+                                  ce->tls_auth_file, R_OK, "--tls-auth");
+    }
+
     errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
                               options->tls_crypt_file, R_OK, "--tls-crypt");
     errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
                               options->shared_secret_file, R_OK, "--secret");
+
     errs |= check_file_access(CHKACC_DIRPATH|CHKACC_FILEXSTWR,
                               options->packet_id_file, R_OK|W_OK, "--replay-persist");
 
@@ -3647,7 +3675,7 @@ options_string(const struct options *o,
     {
         if (TLS_CLIENT || TLS_SERVER)
         {
-            if (o->tls_auth_file)
+            if (o->ce.tls_auth_file)
             {
                 buf_printf(&out, ",tls-auth");
             }
@@ -7420,10 +7448,19 @@ add_option(struct options *options,
     {
         int key_direction;
 
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+
         key_direction = ascii2keydirection(msglevel, p[1]);
         if (key_direction >= 0)
         {
-            options->key_direction = key_direction;
+            if (permission_mask & OPT_P_GENERAL)
+            {
+                options->key_direction = key_direction;
+            }
+            else if (permission_mask & OPT_P_CONNECTION)
+            {
+                options->ce.key_direction = key_direction;
+            }
         }
         else
         {
@@ -7992,26 +8029,45 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "tls-auth") && p[1] && !p[3])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
+        int key_direction = -1;
+
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+
+        if (permission_mask & OPT_P_GENERAL)
         {
-            options->tls_auth_file_inline = p[2];
+            if (streq(p[1], INLINE_FILE_TAG) && p[2])
+            {
+                options->tls_auth_file_inline = p[2];
+            }
+            else if (p[2])
+            {
+                key_direction = ascii2keydirection(msglevel, p[2]);
+                if (key_direction < 0)
+                {
+                    goto err;
+                }
+                options->key_direction = key_direction;
+            }
+            options->tls_auth_file = p[1];
         }
-        else if (p[2])
+        else if (permission_mask & OPT_P_CONNECTION)
         {
-            int key_direction;
-
-            key_direction = ascii2keydirection(msglevel, p[2]);
-            if (key_direction >= 0)
+            options->ce.key_direction = KEY_DIRECTION_BIDIRECTIONAL;
+            if (streq(p[1], INLINE_FILE_TAG) && p[2])
             {
-                options->key_direction = key_direction;
+                options->ce.tls_auth_file_inline = p[2];
             }
-            else
+            else if (p[2])
             {
-                goto err;
+                key_direction = ascii2keydirection(msglevel, p[2]);
+                if (key_direction < 0)
+                {
+                    goto err;
+                }
+                options->ce.key_direction = key_direction;
             }
+            options->ce.tls_auth_file = p[1];
         }
-        options->tls_auth_file = p[1];
     }
     else if (streq(p[0], "tls-crypt") && p[1] && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f7d0145a..77c963d2 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -130,6 +130,11 @@ struct connection_entry
 #define CE_MAN_QUERY_REMOTE_MASK   (0x07)
 #define CE_MAN_QUERY_REMOTE_SHIFT  (2)
     unsigned int flags;
+
+    /* Shared secret used for TLS control channel authentication */
+    const char *tls_auth_file;
+    const char *tls_auth_file_inline;
+    int key_direction;
 };
 
 struct remote_entry
-- 
2.17.1


