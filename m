From: Antonio Quartulli <a@...2181...>
Date: Tue,  5 Jun 2018 11:29:02 +0800
Message-Id: <20180605032902.26440-3-a@...2181...>
In-Reply-To: <20180605032902.26440-1-a@...2181...>
References: <20180605032902.26440-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v2 3/3] make tls-crypt a
 per-connection-block option
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

If persist-key is specified, tls-crypt keys are pre-loaded during
startup (same as they were embeeded in the config file) so that
later there is no need to access the key files.

Trac: #720
Cc: Steffan Karger <steffan@...1856...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

v2:
- convert tls-crypt keyfile to inline key if persist-key was specified

 doc/openvpn.8         |  1 +
 src/openvpn/init.c    |  8 +++----
 src/openvpn/options.c | 56 +++++++++++++++++++++++++++++++++++--------
 src/openvpn/options.h |  4 ++++
 4 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 8006ba29..ac7307af 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -374,6 +374,7 @@ block:
 .B rport,
 .B socks\-proxy,
 .B tls\-auth,
+.B tls\-crypt,
 .B tun\-mtu and
 .B tun\-mtu\-extra.
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 22a74e36..99b5b12a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2529,11 +2529,11 @@ do_init_tls_wrap_key(struct context *c)
     }
 
     /* TLS handshake encryption+authentication (--tls-crypt) */
-    if (options->tls_crypt_file)
+    if (options->ce.tls_crypt_file)
     {
         tls_crypt_init_key(&c->c1.ks.tls_wrap_key,
-                           options->tls_crypt_file,
-                           options->tls_crypt_inline, options->tls_server);
+                           options->ce.tls_crypt_file,
+                           options->ce.tls_crypt_inline, options->tls_server);
     }
 }
 
@@ -2814,7 +2814,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     }
 
     /* TLS handshake encryption (--tls-crypt) */
-    if (options->tls_crypt_file)
+    if (options->ce.tls_crypt_file)
     {
         to.tls_wrap.mode = TLS_WRAP_CRYPT;
         to.tls_wrap.opt.key_ctx_bi = c->c1.ks.tls_wrap_key;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7357f189..09f094d1 100644
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
@@ -2875,7 +2874,7 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
     /*
      * Set per-connection block tls-auth fields if no other method was defined
      */
-    if (!ce->tls_auth_file)
+    if (!ce->tls_auth_file && !ce->tls_crypt_file)
     {
         ce->tls_auth_file = o->tls_auth_file;
         ce->tls_auth_file_inline = o->tls_auth_file_inline;
@@ -2889,6 +2888,29 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
         ce->tls_auth_file = INLINE_FILE_TAG;
         ce->tls_auth_file_inline = (char *)in.data;
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
+    /* pre-cache tls-auth key file if persist-key was specified */
+    if (ce->tls_crypt_file && !ce->tls_crypt_inline && o->persist_key)
+    {
+        struct buffer in = keyfile_to_buffer(ce->tls_crypt_file, 2048, &o->gc);
+        ce->tls_crypt_file = INLINE_FILE_TAG;
+        ce->tls_crypt_inline = (char *)in.data;
+    }
+
+    /*
+     * NOTE: after the two blocks above, only one among tls-crypt and tls-auth
+     * will be set, because it is not allowed by the config parser to have both
+     * globally assigned.
+     */
 }
 
 #ifdef _WIN32
@@ -3312,10 +3334,12 @@ options_postprocess_filechecks(struct options *options)
 
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
 
@@ -8071,12 +8095,24 @@ add_option(struct options *options,
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
index 77c963d2..2c0902a9 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -135,6 +135,10 @@ struct connection_entry
     const char *tls_auth_file;
     const char *tls_auth_file_inline;
     int key_direction;
+
+    /* Shared secret used for TLS control channel authenticated encryption */
+    const char *tls_crypt_file;
+    const char *tls_crypt_inline;
 };
 
 struct remote_entry
-- 
2.17.1


