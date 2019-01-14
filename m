From: Arne Schwabe <arne@...1227...>
Date: Mon, 14 Jan 2019 16:48:15 +0100
Message-Id: <20190114154819.6064-2-arne@...1227...>
In-Reply-To: <20190114154819.6064-1-arne@...1227...>
References: <20190114154819.6064-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/6] Refactor
 tls_crypt_v2_write_server_key_file into crypto.c
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

This allows the method to be resued for generating other types of keys
that should also not be reused as tls-crypt/tls-auth keys.
---
 src/openvpn/crypto.c    | 34 ++++++++++++++++++++++++++++++++++
 src/openvpn/crypto.h    | 10 ++++++++++
 src/openvpn/tls_crypt.c | 30 +-----------------------------
 3 files changed, 45 insertions(+), 29 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index df6f36ca..19136799 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1848,3 +1848,37 @@ translate_cipher_name_to_openvpn(const char *cipher_name)
 
     return pair->openvpn_name;
 }
+
+void
+write_pem_key_file(const char *filename, const char *pem_name)
+{
+    struct gc_arena gc = gc_new();
+    struct key server_key = { 0 };
+    struct buffer server_key_buf = clear_buf();
+    struct buffer server_key_pem = clear_buf();
+
+    if (!rand_bytes((void *)&server_key, sizeof(server_key)))
+    {
+        msg(M_NONFATAL, "ERROR: could not generate random key");
+        goto cleanup;
+    }
+    buf_set_read(&server_key_buf, (void *)&server_key, sizeof(server_key));
+    if (!crypto_pem_encode(pem_name, &server_key_pem,
+                           &server_key_buf, &gc))
+    {
+        msg(M_WARN, "ERROR: could not PEM-encode key");
+        goto cleanup;
+    }
+
+    if (!buffer_write_file(filename, &server_key_pem))
+    {
+        msg(M_ERR, "ERROR: could not write key file");
+        goto cleanup;
+    }
+
+cleanup:
+    secure_memzero(&server_key, sizeof(server_key));
+    buf_clear(&server_key_pem);
+    gc_free(&gc);
+    return;
+}
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 1edde2e3..c0574ff6 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -420,6 +420,16 @@ void crypto_adjust_frame_parameters(struct frame *frame,
 /** Return the worst-case OpenVPN crypto overhead (in bytes) */
 unsigned int crypto_max_overhead(void);
 
+/**
+ * Generate a server key with enough randomness to fill a key struct
+ * and write to file.
+ *
+ * @param filename          Filename of the server key file to create.
+ * @param pem_name          The name to use in the PEM header/footer.
+ */
+void
+write_pem_key_file(const char *filename, const char *pem_name);
+
 /* Minimum length of the nonce used by the PRNG */
 #define NONCE_SECRET_LEN_MIN 16
 
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 6bc2b7f8..eeac794b 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -670,35 +670,7 @@ tls_crypt_v2_extract_client_key(struct buffer *buf,
 void
 tls_crypt_v2_write_server_key_file(const char *filename)
 {
-    struct gc_arena gc = gc_new();
-    struct key server_key = { 0 };
-    struct buffer server_key_buf = clear_buf();
-    struct buffer server_key_pem = clear_buf();
-
-    if (!rand_bytes((void *)&server_key, sizeof(server_key)))
-    {
-        msg(M_NONFATAL, "ERROR: could not generate random key");
-        goto cleanup;
-    }
-    buf_set_read(&server_key_buf, (void *)&server_key, sizeof(server_key));
-    if (!crypto_pem_encode(tls_crypt_v2_srv_pem_name, &server_key_pem,
-                           &server_key_buf, &gc))
-    {
-        msg(M_WARN, "ERROR: could not PEM-encode server key");
-        goto cleanup;
-    }
-
-    if (!buffer_write_file(filename, &server_key_pem))
-    {
-        msg(M_ERR, "ERROR: could not write server key file");
-        goto cleanup;
-    }
-
-cleanup:
-    secure_memzero(&server_key, sizeof(server_key));
-    buf_clear(&server_key_pem);
-    gc_free(&gc);
-    return;
+    write_pem_key_file(filename, tls_crypt_v2_srv_pem_name);
 }
 
 void
-- 
2.19.2


