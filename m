From: Antonio Quartulli <a@...2181...>
Date: Sat,  2 Jun 2018 11:42:06 +0800
Message-Id: <20180602034206.9459-2-a@...2181...>
In-Reply-To: <20180602034206.9459-1-a@...2181...>
References: <20180602034206.9459-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 2/2] make tls-crypt a per-connection-block
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

Similarly to tls-auth, different remotes may use different
tls-crypt keys.

Allow the user to define a different key in each connection
block.

If no tls-crypt option is specified in a given connection block,
the global one, if any, is used.

Trac: #720
Cc: Steffan Karger <steffan@...1856...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 doc/openvpn.8         |  1 +
 src/openvpn/init.c    |  7 ++++---
 src/openvpn/options.c | 48 ++++++++++++++++++++++++++++++++++---------
 src/openvpn/options.h |  4 ++++
 4 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index e7bc3f4f..ce21518b 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -373,6 +373,7 @@ block:
 .B rport,
 .B socks\-proxy,
 .B tls\-auth,
+.B tls\-crypt,
 .B tun\-mtu and
 .B tun\-mtu\-extra.
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1c43c495..6d5dd9aa 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2571,9 +2571,10 @@ do_init_crypto_tls_c1(struct context *c)
         }
 
         /* TLS handshake encryption+authentication (--tls-crypt) */
-        if (options->tls_crypt_file)
+        if (options->ce.tls_crypt_file)
         {
-            tls_crypt_init_key(&c->c1.ks.tls_wrap_key, options->tls_crypt_file,
+            tls_crypt_init_key(&c->c1.ks.tls_wrap_key,
+                               options->ce.tls_crypt_file,
                                options->tls_crypt_inline, options->tls_server);
         }
 
@@ -2796,7 +2797,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     }
 
     /* TLS handshake encryption (--tls-crypt) */
-    if (options->tls_crypt_file)
+    if (options->ce.tls_crypt_file)
     {
         to.tls_wrap.mode = TLS_WRAP_CRYPT;
         to.tls_wrap.opt.key_ctx_bi = c->c1.ks.tls_wrap_key;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a9dbcb83..36324ce5 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1510,6 +1510,7 @@ show_connection_entry(const struct connection_entry *o)
     SHOW_STR(tls_auth_file);
     SHOW_PARM(key_direction, keydirection2ascii(o->key_direction, false, true),
               "%s");
+    SHOW_STR(tls_crypt_file);
 }
 
 
@@ -1790,8 +1791,6 @@ show_settings(const struct options *o)
     SHOW_BOOL(push_peer_info);
     SHOW_BOOL(tls_exit);
 
-    SHOW_STR(tls_crypt_file);
-
 #ifdef ENABLE_PKCS11
     {
         int i;
@@ -2726,7 +2725,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
                 notnull(options->priv_key_file, "private key file (--key) or PKCS#12 file (--pkcs12)");
             }
         }
-        if (options->tls_auth_file && options->tls_crypt_file)
+        if (ce->tls_auth_file && ce->tls_crypt_file)
         {
             msg(M_USAGE, "--tls-auth and --tls-crypt are mutually exclusive");
         }
@@ -2875,12 +2874,27 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
     /*
      * Set per-connection block tls-auth fields if no other method was defined
      */
-    if (!ce->tls_auth_file)
+    if (!ce->tls_auth_file && !ce->tls_crypt_file)
     {
         ce->tls_auth_file = o->tls_auth_file;
         ce->tls_auth_file_inline = o->tls_auth_file_inline;
         ce->key_direction = o->key_direction;
     }
+
+    /*
+     * Set per-connection block tls-crypt fields if no other method was defined
+     */
+    if (!ce->tls_crypt_file && !ce->tls_auth_file)
+    {
+        ce->tls_crypt_file = o->tls_crypt_file;
+        ce->tls_crypt_inline = o->tls_crypt_inline;
+    }
+
+    /*
+     * NOTE: after the two blocks above, only one among tls-crypt and tls-auth
+     * will be set, because it is not allowed by the config parser to have both
+     * globally assigned.
+     */
 }
 
 #ifdef _WIN32
@@ -3304,10 +3318,12 @@ options_postprocess_filechecks(struct options *options)
 
         errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
                                   ce->tls_auth_file, R_OK, "--tls-auth");
+
+        errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
+                                  ce->tls_crypt_file, R_OK, "--tls-crypt");
+
     }
 
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
-                              options->tls_crypt_file, R_OK, "--tls-crypt");
     errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
                               options->shared_secret_file, R_OK, "--secret");
 
@@ -8063,12 +8079,24 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "tls-crypt") && p[1] && !p[3])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (streq(p[1], INLINE_FILE_TAG) && p[2])
+        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        if (permission_mask & OPT_P_GENERAL)
+        {
+            if (streq(p[1], INLINE_FILE_TAG) && p[2])
+            {
+                options->tls_crypt_inline = p[2];
+            }
+            options->tls_crypt_file = p[1];
+        }
+        else if (permission_mask & OPT_P_CONNECTION)
         {
-            options->tls_crypt_inline = p[2];
+            if (streq(p[1], INLINE_FILE_TAG) && p[2])
+            {
+                options->ce.tls_crypt_inline = p[2];
+            }
+            options->ce.tls_crypt_file = p[1];
+
         }
-        options->tls_crypt_file = p[1];
     }
     else if (streq(p[0], "key-method") && p[1] && !p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 77c963d2..fcde90af 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -135,6 +135,10 @@ struct connection_entry
     const char *tls_auth_file;
     const char *tls_auth_file_inline;
     int key_direction;
+
+    /* Shared secret used for TLS control channel authenticated encryption */
+    const char *tls_crypt_file;
+    bool tls_crypt_inline;
 };
 
 struct remote_entry
-- 
2.17.1


