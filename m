From: Antonio Quartulli <a@...2181...>
Date: Tue,  5 Jun 2018 11:29:00 +0800
Message-Id: <20180605032902.26440-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v2 1/3] crypto: always reload tls-auth/crypt
 key contexts
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

In preparation to having tls-auth/crypt keys per connection
block, it is important to ensure that such material is always
reload upon SIGUSR1, no matter is persist-key was specified or
not.

This is required because when moving from one remote to the
other the key may change and thus the key context needs to
be refreshed.

Trac: #720
Cc: Steffan Karger <steffan@...1856...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

v2:
- introduce this patch

 src/openvpn/buffer.c | 29 +++++++++++++++
 src/openvpn/buffer.h | 13 +++++++
 src/openvpn/crypto.c | 20 ++--------
 src/openvpn/init.c   | 87 +++++++++++++++++++++++++++++---------------
 4 files changed, 102 insertions(+), 47 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index becfeb93..cbf969a8 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1332,3 +1332,32 @@ buffer_list_file(const char *fn, int max_line_len)
     }
     return bl;
 }
+
+struct buffer
+keyfile_to_buffer(const char *file, int max_size, struct gc_arena *gc)
+{
+    size_t size;
+    struct buffer in = alloc_buf_gc(max_size, gc);
+    int fd = platform_open(file, O_RDONLY, 0);
+    if (fd == -1)
+    {
+        msg(M_ERR, "Cannot open key file '%s'", file);
+    }
+
+    size = read(fd, in.data, in.capacity);
+    if (size < 0)
+    {
+        msg(M_FATAL, "Read error on key file ('%s')", file);
+    }
+
+    if (size == in.capacity)
+    {
+        msg(M_FATAL, "Key file ('%s') can be a maximum of %d bytes", file,
+            (int)in.capacity);
+    }
+    close(fd);
+
+    in.len = size;
+
+    return in;
+}
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index d848490a..ba9857eb 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -1112,4 +1112,17 @@ void buffer_list_aggregate_separator(struct buffer_list *bl,
 
 struct buffer_list *buffer_list_file(const char *fn, int max_line_len);
 
+/**
+ * keyfile_to_buffer - copy the content of a file into a buffer
+ *
+ * @param file      path to the file to read
+ * @param max_size  maximum size of the buffer to allocate
+ * @param gc        the garbage collector to use when allocating the buffer. It
+ *                  passed to alloc_buf_gc() and therefore can be NULL.
+ *
+ * @return the buffer storing the file content
+ */
+struct buffer keyfile_to_buffer(const char *file, int max_size,
+                                struct gc_arena *gc);
+
 #endif /* BUFFER_H */
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index b59c1f73..f201b533 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1224,7 +1224,7 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
 {
     struct gc_arena gc = gc_new();
     struct buffer in;
-    int fd, size;
+    int size;
     uint8_t hex_byte[3] = {0, 0, 0};
     const char *error_filename = file;
 
@@ -1268,22 +1268,8 @@ read_key_file(struct key2 *key2, const char *file, const unsigned int flags)
     }
     else /* 'file' is a filename which refers to a file containing the ascii key */
     {
-        in = alloc_buf_gc(2048, &gc);
-        fd = platform_open(file, O_RDONLY, 0);
-        if (fd == -1)
-        {
-            msg(M_ERR, "Cannot open key file '%s'", file);
-        }
-        size = read(fd, in.data, in.capacity);
-        if (size < 0)
-        {
-            msg(M_FATAL, "Read error on key file ('%s')", file);
-        }
-        if (size == in.capacity)
-        {
-            msg(M_FATAL, "Key file ('%s') can be a maximum of %d bytes", file, (int)in.capacity);
-        }
-        close(fd);
+        in = keyfile_to_buffer(file, 2048, &gc);
+        size = in.len;
     }
 
     cp = (unsigned char *)in.data;
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 36c1a4c4..15fef08d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2406,7 +2406,6 @@ key_schedule_free(struct key_schedule *ks, bool free_ssl_ctx)
     if (tls_ctx_initialised(&ks->ssl_ctx) && free_ssl_ctx)
     {
         tls_ctx_free(&ks->ssl_ctx);
-        free_key_ctx_bi(&ks->tls_wrap_key);
     }
     CLEAR(*ks);
 }
@@ -2496,6 +2495,48 @@ do_init_crypto_static(struct context *c, const unsigned int flags)
     check_replay_consistency(&c->c1.ks.key_type, options->replay);
 }
 
+/*
+ * Initialize the tls-auth/crypt key context
+ */
+static void
+do_init_tls_wrap_key(struct context *c)
+{
+    const struct options *options = &c->options;
+
+    /* TLS handshake authentication (--tls-auth) */
+    if (options->tls_auth_file)
+    {
+        /* Initialize key_type for tls-auth with auth only */
+        CLEAR(c->c1.ks.tls_auth_key_type);
+        if (!streq(options->authname, "none"))
+        {
+            c->c1.ks.tls_auth_key_type.digest = md_kt_get(options->authname);
+                c->c1.ks.tls_auth_key_type.hmac_length =
+                    md_kt_size(c->c1.ks.tls_auth_key_type.digest);
+        }
+        else
+        {
+            msg(M_FATAL, "ERROR: tls-auth enabled, but no valid --auth "
+                "algorithm specified ('%s')", options->authname);
+        }
+
+        crypto_read_openvpn_key(&c->c1.ks.tls_auth_key_type,
+                                &c->c1.ks.tls_wrap_key,
+                                options->tls_auth_file,
+                                options->tls_auth_file_inline,
+                                options->key_direction,
+                                "Control Channel Authentication", "tls-auth");
+    }
+
+    /* TLS handshake encryption+authentication (--tls-crypt) */
+    if (options->tls_crypt_file)
+    {
+        tls_crypt_init_key(&c->c1.ks.tls_wrap_key,
+                           options->tls_crypt_file,
+                           options->tls_crypt_inline, options->tls_server);
+    }
+}
+
 /*
  * Initialize the persistent component of OpenVPN's TLS mode,
  * which is preserved across SIGUSR1 resets.
@@ -2545,35 +2586,8 @@ do_init_crypto_tls_c1(struct context *c)
         /* Initialize PRNG with config-specified digest */
         prng_init(options->prng_hash, options->prng_nonce_secret_len);
 
-        /* TLS handshake authentication (--tls-auth) */
-        if (options->tls_auth_file)
-        {
-            /* Initialize key_type for tls-auth with auth only */
-            CLEAR(c->c1.ks.tls_auth_key_type);
-            if (!streq(options->authname, "none"))
-            {
-                c->c1.ks.tls_auth_key_type.digest = md_kt_get(options->authname);
-                c->c1.ks.tls_auth_key_type.hmac_length =
-                    md_kt_size(c->c1.ks.tls_auth_key_type.digest);
-            }
-            else
-            {
-                msg(M_FATAL, "ERROR: tls-auth enabled, but no valid --auth "
-                    "algorithm specified ('%s')", options->authname);
-            }
-
-            crypto_read_openvpn_key(&c->c1.ks.tls_auth_key_type,
-                                    &c->c1.ks.tls_wrap_key, options->tls_auth_file,
-                                    options->tls_auth_file_inline, options->key_direction,
-                                    "Control Channel Authentication", "tls-auth");
-        }
-
-        /* TLS handshake encryption+authentication (--tls-crypt) */
-        if (options->tls_crypt_file)
-        {
-            tls_crypt_init_key(&c->c1.ks.tls_wrap_key, options->tls_crypt_file,
-                               options->tls_crypt_inline, options->tls_server);
-        }
+        /* initialize tls-auth/crypt key */
+        do_init_tls_wrap_key(c);
 
         c->c1.ciphername = options->ciphername;
         c->c1.authname = options->authname;
@@ -2595,6 +2609,12 @@ do_init_crypto_tls_c1(struct context *c)
         c->options.ciphername = c->c1.ciphername;
         c->options.authname = c->c1.authname;
         c->options.keysize = c->c1.keysize;
+
+        /*
+         * tls-auth/crypt key can be configured per connection block, therefore
+         * we must reload it as it may have changed
+         */
+        do_init_tls_wrap_key(c);
     }
 }
 
@@ -3398,6 +3418,13 @@ do_close_tls(struct context *c)
 static void
 do_close_free_key_schedule(struct context *c, bool free_ssl_ctx)
 {
+    /*
+     * always free the tls_auth/crypt key. If persist_key is true, the key will
+     * be reloaded from memory (pre-cached)
+     */
+    free_key_ctx_bi(&c->c1.ks.tls_wrap_key);
+    CLEAR(c->c1.ks.tls_wrap_key);
+
     if (!(c->sig->signal_received == SIGUSR1 && c->options.persist_key))
     {
         key_schedule_free(&c->c1.ks, free_ssl_ctx);
-- 
2.17.1


