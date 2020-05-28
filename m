From: James Bottomley <James.Bottomley@...2316...>
Date: Thu, 28 May 2020 15:59:18 -0700
Message-Id: <20200528225920.6983-2-James.Bottomley@...2316...>
In-Reply-To: <20200528225920.6983-1-James.Bottomley@...2316...>
References: <20200528225920.6983-1-James.Bottomley@...2316...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6 1/3] openssl: add engine method for
 loading the key
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

As well as doing crypto acceleration, engines can also be used to load
key files.  If the engine is set, and the private key loading fails
for bio methods, this patch makes openvpn try to get the engine to
load the key.  If that succeeds, we end up using an engine based key.
This can be used with the openssl tpm engines to make openvpn use a
TPM wrapped key file.

Signed-off-by: James Bottomley <James.Bottomley@...2316...>

---

v2: add better configuration guarding

v4: - use crypto_msg() instead of raw openssl prints
    - remove ENGINE_init/finish().  Openvpn already initializes the engine
      so doing a second initialization is wrong.
    - don't clear the openssl errors from the BIO_read failure just in
      case they might be useful.
    - ad ui.h include for openssl 1.1 build failure

v5: add engine init
---
 src/openvpn/crypto_openssl.c | 56 ++++++++++++++++++++++++++++++++++++
 src/openvpn/crypto_openssl.h | 12 ++++++++
 src/openvpn/ssl_openssl.c    |  5 ++++
 3 files changed, 73 insertions(+)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index a5b2c45a..4ac77fde 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -63,6 +63,7 @@
 #endif
 
 #if HAVE_OPENSSL_ENGINE
+#include <openssl/ui.h>
 #include <openssl/engine.h>
 
 static bool engine_initialized = false; /* GLOBAL */
@@ -1070,4 +1071,59 @@ memcmp_constant_time(const void *a, const void *b, size_t size)
 {
     return CRYPTO_memcmp(a, b, size);
 }
+
+#if HAVE_OPENSSL_ENGINE
+static int
+ui_reader(UI *ui, UI_STRING *uis)
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
+    /* this will print out the error from BIO_read */
+    crypto_msg(M_INFO, "PEM_read_bio failed, now trying engine method to load private key");
+
+    ui = UI_create_method("openvpn");
+    if (!ui) {
+	crypto_msg(M_FATAL, "Engine UI creation failed");
+        return NULL;
+    }
+
+    UI_method_set_reader(ui, ui_reader);
+
+    ENGINE_init(engine_persist);
+    pkey = ENGINE_load_private_key(engine_persist, file, ui, ctx);
+    ENGINE_finish(engine_persist);
+    if (!pkey)
+	crypto_msg(M_FATAL, "Engine could not load key file");
+
+    UI_destroy_method(ui);
+    return pkey;
+#else
+    return NULL;
+#endif
+}
+
 #endif /* ENABLE_CRYPTO_OPENSSL */
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 64754480..7449fbd3 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -107,4 +107,16 @@ cipher_kt_var_key_size(const cipher_kt_t *cipher)
     return EVP_CIPHER_flags(cipher) & EVP_CIPH_VARIABLE_LENGTH;
 }
 
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
index 06c836da..a489053b 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1020,6 +1020,11 @@ tls_ctx_load_priv_file(struct tls_root_ctx *ctx, const char *priv_key_file,
     pkey = PEM_read_bio_PrivateKey(in, NULL,
                                    SSL_CTX_get_default_passwd_cb(ctx->ctx),
                                    SSL_CTX_get_default_passwd_cb_userdata(ctx->ctx));
+    if (!pkey)
+    {
+        pkey = engine_load_key(priv_key_file, ctx->ctx);
+    }
+
     if (!pkey || !SSL_CTX_use_PrivateKey(ssl_ctx, pkey))
     {
 #ifdef ENABLE_MANAGEMENT
-- 
2.26.2


