From: Arne Schwabe <arne@...1227...>
Date: Tue, 22 Jan 2019 16:03:29 +0100
Message-Id: <20190122150333.1061-2-arne@...1227...>
In-Reply-To: <20190122150333.1061-1-arne@...1227...>
References: <20190122150333.1061-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2 2/6] Allow pem_read_key_file to generate
 a random key
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

This is useful for features that can use either a persistent
or an ephemeral key.
---
 src/openvpn/crypto.c    | 23 ++++++++++++++++++++---
 src/openvpn/crypto.h    |  4 +++-
 src/openvpn/tls_crypt.c |  5 +++--
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index ff9dbfdc..68a28dee 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1885,13 +1885,30 @@ cleanup:
 
 bool
 read_pem_key_file(struct buffer *key, const char *pem_name,
-                  const char *key_file, const char *key_inline)
+                  const char *key_file, const char *key_inline,
+                  bool allow_random)
 {
     bool ret = false;
     struct buffer key_pem = { 0 };
     struct gc_arena gc = gc_new();
 
-    if (strcmp(key_file, INLINE_FILE_TAG))
+
+    if (allow_random && key_file == NULL)
+    {
+        msg(M_INFO, "Using random %s.", pem_name);
+        uint8_t rand[BCAP(key)];
+        if (!rand_bytes(rand, BCAP(key)))
+        {
+            msg(M_WARN, "ERROR: could not generate random key");
+        }
+        else
+        {
+            buf_write(key, rand, BCAP(key));
+            ret = true;
+        }
+        goto cleanup;
+    }
+    else if (strcmp(key_file, INLINE_FILE_TAG))
     {
         key_pem = buffer_read_from_file(key_file, &gc);
         if (!buf_valid(&key_pem))
@@ -1914,7 +1931,7 @@ read_pem_key_file(struct buffer *key, const char *pem_name,
 
     ret = true;
 cleanup:
-    if (strcmp(key_file, INLINE_FILE_TAG))
+    if (key_file && strcmp(key_file, INLINE_FILE_TAG))
     {
         buf_clear(&key_pem);
     }
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 09f7bb25..dfbfb38b 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -436,11 +436,13 @@ write_pem_key_file(const char *filename, const char *pem_name);
  * @param pem_name      the name used in the pem encoding start/end lines
  * @param key_file      name of the file to read
  * @param key_inline    a string holding the data in case of an inline key
+ * @param allow_random  allow generating a random key if no file is provided
  * @return              true if reading into key was successful
  */
 bool
 read_pem_key_file(struct buffer *key, const char *pem_name,
-                  const char *key_file, const char *key_inline);
+                  const char *key_file, const char *key_inline,
+                  bool allow_random);
 
 /* Minimum length of the nonce used by the PRNG */
 #define NONCE_SECRET_LEN_MIN 16
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index d6a82252..baa193c3 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -301,7 +301,7 @@ tls_crypt_v2_init_client_key(struct key_ctx_bi *key, struct buffer *wkc_buf,
                                          + TLS_CRYPT_V2_MAX_WKC_LEN);
 
     if (!read_pem_key_file(&client_key, tls_crypt_v2_cli_pem_name,
-                           key_file, key_inline))
+                           key_file, key_inline, false))
     {
         msg(M_FATAL, "ERROR: invalid tls-crypt-v2 client key format");
     }
@@ -326,8 +326,9 @@ tls_crypt_v2_init_server_key(struct key_ctx *key_ctx, bool encrypt,
     struct buffer srv_key_buf;
 
     buf_set_write(&srv_key_buf, (void *)&srv_key, sizeof(srv_key));
+
     if (!read_pem_key_file(&srv_key_buf, tls_crypt_v2_srv_pem_name,
-                           key_file, key_inline))
+                           key_file, key_inline, false))
     {
         msg(M_FATAL, "ERROR: invalid tls-crypt-v2 server key format");
     }
-- 
2.20.1


