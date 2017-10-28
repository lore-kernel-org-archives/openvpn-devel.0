Message-ID: <1509192205.3021.7.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Sat, 28 Oct 2017 13:03:25 +0100
In-Reply-To: <1509192147.3021.6.camel@...2316...>
References: <1509192147.3021.6.camel@...2316...>
Mime-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/1] openssl: add engine method for loading
 the key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

As well as doing crypto acceleration, engines can also be used to load
key files.  If the engine is set, and the private key loading fails
for bio methods, this patch makes openvpn try to get the engine to
load the key.  If that succeeds, we end up using an engine based key.
This can be used with the openssl tpm engines to make openvpn use a
TPM wrapped key file.

Signed-off-by: James Bottomley <James.Bottomley@...2316...>
---
 src/openvpn/crypto_backend.h | 13 ++++++++++++
 src/openvpn/crypto_openssl.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/ssl_openssl.c    |  6 +++++-
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 567fd9b2..0b4a9ce9 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -669,4 +669,17 @@ const char *translate_cipher_name_from_openvpn(const char *cipher_name);
  */
 const char *translate_cipher_name_to_openvpn(const char *cipher_name);
 
+/**
+ * Load a key file from an engine
+ *
+ * @param file	The engine file to load
+ * @param ui	The UI method for the password prompt
+ * @param data	The data to pass to the UI method
+ *
+ * @return	The private key if successful or NULL if not
+ */
+EVP_PKEY *
+engine_load_key(const char *file, SSL_CTX *ctx);
+
+
 #endif /* CRYPTO_BACKEND_H_ */
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 0134e55d..ee16a496 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -969,4 +969,53 @@ hmac_ctx_final(HMAC_CTX *ctx, uint8_t *dst)
     HMAC_Final(ctx, dst, &in_hmac_len);
 }
 
+static int
+ui_read(UI *ui, UI_STRING *uis)
+{
+    SSL_CTX *ctx = UI_get0_user_data(ui);
+
+    if (UI_get_string_type(uis) == UIT_PROMPT) {
+        pem_password_cb *cb = SSL_CTX_get_default_passwd_cb(ctx);
+        void *d = SSL_CTX_get_default_passwd_cb_userdata(ctx);
+        char password[64];
+
+        cb(password, sizeof(password), 0, d);
+        UI_set_result(ui, uis, password);
+
+        return 1;
+    }
+    return 0;
+}
+
+EVP_PKEY *
+engine_load_key(const char *file, SSL_CTX *ctx)
+{
+    UI_METHOD *ui;
+    EVP_PKEY *pkey;
+
+    if (!engine_persist)
+        return NULL;
+
+    ui = UI_create_method("openvpn");
+
+    if (!ui)
+        return NULL;
+
+    UI_method_set_reader(ui, ui_read);
+
+    ERR_clear_error();		/* BIO read failure */
+    if (!ENGINE_init(engine_persist)) {
+	ERR_print_errors_fp(stderr);
+	pkey = NULL;
+	goto out;
+    }
+    pkey = ENGINE_load_private_key(engine_persist, file, ui, ctx);
+    ENGINE_finish(engine_persist);
+    if (!pkey)
+	ERR_print_errors_fp(stderr);
+ out:
+    UI_destroy_method(ui);
+    return pkey;
+}
+
 #endif /* ENABLE_CRYPTO && ENABLE_CRYPTO_OPENSSL */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 92a662b5..52e9a869 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -839,7 +839,11 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
                                    SSL_CTX_get_default_passwd_cb_userdata(ctx->ctx));
     if (!pkey)
     {
-        goto end;
+        pkey = engine_load_key(priv_key_file, ctx->ctx);
+        if (!pkey)
+        {
+            goto end;
+        }
     }
 
     if (!SSL_CTX_use_PrivateKey(ssl_ctx, pkey))
-- 
2.12.3

