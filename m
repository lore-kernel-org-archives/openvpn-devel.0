From: Arne Schwabe <arne@...1227...>
Date: Tue, 22 Jan 2019 16:03:28 +0100
Message-Id: <20190122150333.1061-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 1/6] Rename tls_crypt_v2_read_keyfile
 into generic pem_read_key_file
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
Cc: Arne Schwabe <arne@...515...>

From: Arne Schwabe <arne@...515...>

The function is fairly generic and to avoid duplicating the same
functionality move the function to crypto.c and change fixed string to
be the same as the pem_name parameter.
---
 src/openvpn/crypto.c    | 39 ++++++++++++++++++++++++++++++++++
 src/openvpn/crypto.h    | 12 +++++++++++
 src/openvpn/ssl.h       |  1 -
 src/openvpn/tls_crypt.c | 47 ++++-------------------------------------
 4 files changed, 55 insertions(+), 44 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 19136799..ff9dbfdc 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1882,3 +1882,42 @@ cleanup:
     gc_free(&gc);
     return;
 }
+
+bool
+read_pem_key_file(struct buffer *key, const char *pem_name,
+                  const char *key_file, const char *key_inline)
+{
+    bool ret = false;
+    struct buffer key_pem = { 0 };
+    struct gc_arena gc = gc_new();
+
+    if (strcmp(key_file, INLINE_FILE_TAG))
+    {
+        key_pem = buffer_read_from_file(key_file, &gc);
+        if (!buf_valid(&key_pem))
+        {
+            msg(M_WARN, "ERROR: failed to read %s file (%s)",
+                pem_name, key_file);
+            goto cleanup;
+        }
+    }
+    else
+    {
+        buf_set_read(&key_pem, (const void *)key_inline, strlen(key_inline) + 1);
+    }
+
+    if (!crypto_pem_decode(pem_name, key, &key_pem))
+    {
+        msg(M_WARN, "ERROR: %s pem decode failed", pem_name);
+        goto cleanup;
+    }
+
+    ret = true;
+cleanup:
+    if (strcmp(key_file, INLINE_FILE_TAG))
+    {
+        buf_clear(&key_pem);
+    }
+    gc_free(&gc);
+    return ret;
+}
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index c0574ff6..09f7bb25 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -430,6 +430,18 @@ unsigned int crypto_max_overhead(void);
 void
 write_pem_key_file(const char *filename, const char *pem_name);
 
+/**
+ * Read key material from a PEM encoded files into the key structure
+ * @param key           the key structure that will hold the key material
+ * @param pem_name      the name used in the pem encoding start/end lines
+ * @param key_file      name of the file to read
+ * @param key_inline    a string holding the data in case of an inline key
+ * @return              true if reading into key was successful
+ */
+bool
+read_pem_key_file(struct buffer *key, const char *pem_name,
+                  const char *key_file, const char *key_inline);
+
 /* Minimum length of the nonce used by the PRNG */
 #define NONCE_SECRET_LEN_MIN 16
 
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index eafb235e..660e9eb4 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -634,5 +634,4 @@ void
 show_available_tls_ciphers(const char *cipher_list,
                            const char *cipher_list_tls13,
                            const char *tls_cert_profile);
-
 #endif /* ifndef OPENVPN_SSL_H */
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index eeac794b..d6a82252 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -278,45 +278,6 @@ error_exit:
     return false;
 }
 
-static inline bool
-tls_crypt_v2_read_keyfile(struct buffer *key, const char *pem_name,
-                          const char *key_file, const char *key_inline)
-{
-    bool ret = false;
-    struct buffer key_pem = { 0 };
-    struct gc_arena gc = gc_new();
-
-    if (strcmp(key_file, INLINE_FILE_TAG))
-    {
-        key_pem = buffer_read_from_file(key_file, &gc);
-        if (!buf_valid(&key_pem))
-        {
-            msg(M_WARN, "ERROR: failed to read tls-crypt-v2 key file (%s)",
-                key_file);
-            goto cleanup;
-        }
-    }
-    else
-    {
-        buf_set_read(&key_pem, (const void *)key_inline, strlen(key_inline) + 1);
-    }
-
-    if (!crypto_pem_decode(pem_name, key, &key_pem))
-    {
-        msg(M_WARN, "ERROR: tls-crypt-v2 pem decode failed");
-        goto cleanup;
-    }
-
-    ret = true;
-cleanup:
-    if (strcmp(key_file, INLINE_FILE_TAG))
-    {
-        buf_clear(&key_pem);
-    }
-    gc_free(&gc);
-    return ret;
-}
-
 static inline void
 tls_crypt_v2_load_client_key(struct key_ctx_bi *key, const struct key2 *key2,
                              bool tls_server)
@@ -339,8 +300,8 @@ tls_crypt_v2_init_client_key(struct key_ctx_bi *key, struct buffer *wkc_buf,
     struct buffer client_key = alloc_buf(TLS_CRYPT_V2_CLIENT_KEY_LEN
                                          + TLS_CRYPT_V2_MAX_WKC_LEN);
 
-    if (!tls_crypt_v2_read_keyfile(&client_key, tls_crypt_v2_cli_pem_name,
-                                   key_file, key_inline))
+    if (!read_pem_key_file(&client_key, tls_crypt_v2_cli_pem_name,
+                           key_file, key_inline))
     {
         msg(M_FATAL, "ERROR: invalid tls-crypt-v2 client key format");
     }
@@ -365,8 +326,8 @@ tls_crypt_v2_init_server_key(struct key_ctx *key_ctx, bool encrypt,
     struct buffer srv_key_buf;
 
     buf_set_write(&srv_key_buf, (void *)&srv_key, sizeof(srv_key));
-    if (!tls_crypt_v2_read_keyfile(&srv_key_buf, tls_crypt_v2_srv_pem_name,
-                                   key_file, key_inline))
+    if (!read_pem_key_file(&srv_key_buf, tls_crypt_v2_srv_pem_name,
+                           key_file, key_inline))
     {
         msg(M_FATAL, "ERROR: invalid tls-crypt-v2 server key format");
     }
-- 
2.20.1


