Message-ID: <1516998620.3034.16.camel@...2316...>
From: James Bottomley <James.Bottomley@...2316...>
Date: Fri, 26 Jan 2018 12:30:20 -0800
In-Reply-To: <1516998568.3034.15.camel@...2316...>
References: <1516998568.3034.15.camel@...2316...>
Mime-Version: 1.0
Subject: [Openvpn-devel] PATCH v3 1/2] openssl: add engine method for
 loading the key
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

v2: add better configuration guarding
---
 src/openvpn/crypto_openssl.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/crypto_openssl.h | 12 ++++++++++
 src/openvpn/ssl_openssl.c    |  6 ++++-
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 20a519ec..d3f35030 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -969,4 +969,59 @@ hmac_ctx_final(HMAC_CTX *ctx, uint8_t *dst)
     HMAC_Final(ctx, dst, &in_hmac_len);
 }
 
+#if HAVE_OPENSSL_ENGINE
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
+#endif
+
+EVP_PKEY *
+engine_load_key(const char *file, SSL_CTX *ctx)
+{
+#if HAVE_OPENSSL_ENGINE
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
+#else
+    return NULL;
+#endif
+}
+
 #endif /* ENABLE_CRYPTO_OPENSSL */
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 60a28123..759dc927 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -101,5 +101,17 @@ void crypto_print_openssl_errors(const unsigned int flags);
         msg((flags), __VA_ARGS__); \
     } while (false)
 
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
 
 #endif /* CRYPTO_OPENSSL_H_ */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index cc1f8f15..200c0189 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -907,7 +907,11 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
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

