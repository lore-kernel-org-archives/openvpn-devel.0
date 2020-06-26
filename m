From: Arne Schwabe <arne@...1227...>
Date: Fri, 26 Jun 2020 14:53:32 +0200
Message-Id: <20200626125332.15385-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Reformat files using uncrustify
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

Some of the commits, especially engine have not strictly used uncrustify
clean code. Rerun uncrustify to make them compliant again.
---
 src/openvpn/crypto_openssl.c                |  18 ++-
 src/openvpn/crypto_openssl.h                |   8 +-
 src/openvpn/helper.c                        |   1 -
 src/openvpn/manage.h                        |   2 +-
 src/openvpn/multi.c                         |   4 +-
 src/openvpn/options.c                       |  10 +-
 src/openvpn/otime.c                         |   4 +-
 src/openvpn/pool.c                          |  26 +--
 src/openvpn/push.c                          |   2 +-
 src/openvpn/ssl.c                           |   3 +-
 tests/unit_tests/engine-key/libtestengine.c | 167 +++++++++++---------
 11 files changed, 134 insertions(+), 111 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 521cfca1..161a189e 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1083,7 +1083,8 @@ ui_reader(UI *ui, UI_STRING *uis)
 {
     SSL_CTX *ctx = UI_get0_user_data(ui);
 
-    if (UI_get_string_type(uis) == UIT_PROMPT) {
+    if (UI_get_string_type(uis) == UIT_PROMPT)
+    {
         pem_password_cb *cb = SSL_CTX_get_default_passwd_cb(ctx);
         void *d = SSL_CTX_get_default_passwd_cb_userdata(ctx);
         char password[64];
@@ -1105,14 +1106,17 @@ engine_load_key(const char *file, SSL_CTX *ctx)
     EVP_PKEY *pkey;
 
     if (!engine_persist)
+    {
         return NULL;
+    }
 
     /* this will print out the error from BIO_read */
     crypto_msg(M_INFO, "PEM_read_bio failed, now trying engine method to load private key");
 
     ui = UI_create_method("openvpn");
-    if (!ui) {
-	crypto_msg(M_FATAL, "Engine UI creation failed");
+    if (!ui)
+    {
+        crypto_msg(M_FATAL, "Engine UI creation failed");
         return NULL;
     }
 
@@ -1122,13 +1126,15 @@ engine_load_key(const char *file, SSL_CTX *ctx)
     pkey = ENGINE_load_private_key(engine_persist, file, ui, ctx);
     ENGINE_finish(engine_persist);
     if (!pkey)
-	crypto_msg(M_FATAL, "Engine could not load key file");
+    {
+        crypto_msg(M_FATAL, "Engine could not load key file");
+    }
 
     UI_destroy_method(ui);
     return pkey;
-#else
+#else  /* if HAVE_OPENSSL_ENGINE */
     return NULL;
-#endif
+#endif /* if HAVE_OPENSSL_ENGINE */
 }
 
 #endif /* ENABLE_CRYPTO_OPENSSL */
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 7449fbd3..4694ee08 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -110,11 +110,11 @@ cipher_kt_var_key_size(const cipher_kt_t *cipher)
 /**
  * Load a key file from an engine
  *
- * @param file	The engine file to load
- * @param ui	The UI method for the password prompt
- * @param data	The data to pass to the UI method
+ * @param file  The engine file to load
+ * @param ui    The UI method for the password prompt
+ * @param data  The data to pass to the UI method
  *
- * @return	The private key if successful or NULL if not
+ * @return      The private key if successful or NULL if not
  */
 EVP_PKEY *
 engine_load_key(const char *file, SSL_CTX *ctx);
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 2cc579e7..6e9cc63c 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -478,7 +478,6 @@ helper_client_server(struct options *o)
         }
     }
     else
-
     /*
      * HELPER DIRECTIVE:
      *
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 8c824ca7..881bfb14 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -439,7 +439,7 @@ void management_notify_client_cr_response(unsigned mda_key_id,
                                           const struct env_set *es,
                                           const char *response);
 
-#endif
+#endif /* ifdef MANAGEMENT_DEF_AUTH */
 
 char *management_query_pk_sig(struct management *man, const char *b64_data,
                               const char *algorithm);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index fe8fcd50..95b16744 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3320,8 +3320,8 @@ management_kill_by_cid(void *arg, const unsigned long cid, const char *kill_msg)
 
 static bool
 management_client_pending_auth(void *arg,
-        const unsigned long cid,
-        const char *extra)
+                               const unsigned long cid,
+                               const char *extra)
 {
     struct multi_context *m = (struct multi_context *) arg;
     struct multi_instance *mi = lookup_by_cid(m, cid);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3484f7d4..5f658d3f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4978,11 +4978,11 @@ options_string_import(struct options *options,
 #if P2MP
 
 #define VERIFY_PERMISSION(mask) {                                            \
-    if (!verify_permission(p[0], file, line, (mask), permission_mask,        \
-                           option_types_found, msglevel, options, is_inline))\
-    {                                                                        \
-        goto err;                                                            \
-    }                                                                        \
+        if (!verify_permission(p[0], file, line, (mask), permission_mask,        \
+                               option_types_found, msglevel, options, is_inline)) \
+        {                                                                        \
+            goto err;                                                            \
+        }                                                                        \
 }
 
 static bool
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index b7eb1edc..640168a9 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -130,8 +130,8 @@ time_string(time_t t, int usec, bool show_usec, struct gc_arena *gc)
     struct tm *tm = localtime(&t);
 
     buf_printf(&out, "%04d-%02d-%02d %02d:%02d:%02d",
-                tm->tm_year+1900, tm->tm_mon+1, tm->tm_mday,
-                tm->tm_hour, tm->tm_min, tm->tm_sec);
+               tm->tm_year+1900, tm->tm_mon+1, tm->tm_mday,
+               tm->tm_hour, tm->tm_min, tm->tm_sec);
 
     if (show_usec && tv.tv_usec)
     {
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 370f6af7..1f74ac57 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -310,20 +310,20 @@ ifconfig_pool_acquire(struct ifconfig_pool *pool, in_addr_t *local, in_addr_t *r
             switch (pool->ipv4.type)
             {
                 case IFCONFIG_POOL_30NET:
-                    {
-                        in_addr_t b = pool->ipv4.base + (i << 2);
-                        *local = b + 1;
-                        *remote = b + 2;
-                        break;
-                    }
+                {
+                    in_addr_t b = pool->ipv4.base + (i << 2);
+                    *local = b + 1;
+                    *remote = b + 2;
+                    break;
+                }
 
                 case IFCONFIG_POOL_INDIV:
-                    {
-                        in_addr_t b = pool->ipv4.base + i;
-                        *local = 0;
-                        *remote = b;
-                        break;
-                    }
+                {
+                    in_addr_t b = pool->ipv4.base + i;
+                    *local = 0;
+                    *remote = b;
+                    break;
+                }
 
                 default:
                     ASSERT(0);
@@ -683,7 +683,9 @@ ifconfig_pool_read(struct ifconfig_pool_persist *persist, struct ifconfig_pool *
                      * was not valid
                      */
                     if (h < 0)
+                    {
                         h = h6;
+                    }
                 }
             }
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 26460490..369cd6a4 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -288,7 +288,7 @@ send_auth_failed(struct context *c, const char *client_reason)
 }
 
 bool
-send_auth_pending_messages(struct context *c, const char* extra)
+send_auth_pending_messages(struct context *c, const char *extra)
 {
     send_control_channel_string(c, "AUTH_PENDING", D_PUSH);
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 68d2b5c1..1cf8e44f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1930,7 +1930,8 @@ tls_session_generate_data_channel_keys(struct tls_session *session)
     const struct session_id *server_sid = !session->opt->server ?
                                           &ks->session_id_remote : &session->session_id;
 
-    if (!ks->authenticated) {
+    if (!ks->authenticated)
+    {
         msg(D_TLS_ERRORS, "TLS Error: key_state not authenticated");
         goto cleanup;
     }
diff --git a/tests/unit_tests/engine-key/libtestengine.c b/tests/unit_tests/engine-key/libtestengine.c
index 46ec1e33..8bcfa92e 100644
--- a/tests/unit_tests/engine-key/libtestengine.c
+++ b/tests/unit_tests/engine-key/libtestengine.c
@@ -8,93 +8,108 @@ static char *engine_name = "Engine for testing openvpn engine key support";
 
 static int is_initialized = 0;
 
-static int engine_init(ENGINE *e)
+static int
+engine_init(ENGINE *e)
 {
-	is_initialized = 1;
-	fprintf(stderr, "ENGINE: engine_init called\n");
-	return 1;
+    is_initialized = 1;
+    fprintf(stderr, "ENGINE: engine_init called\n");
+    return 1;
 }
 
-static int engine_finish(ENGINE *e)
+static int
+engine_finish(ENGINE *e)
 {
-	fprintf(stderr, "ENGINE: engine_finsh called\n");
-	is_initialized = 0;
-	return 1;
+    fprintf(stderr, "ENGINE: engine_finsh called\n");
+    is_initialized = 0;
+    return 1;
 }
 
-static EVP_PKEY *engine_load_key(ENGINE *e, const char *key_id,
-				 UI_METHOD *ui_method, void *cb_data)
+static EVP_PKEY *
+engine_load_key(ENGINE *e, const char *key_id,
+                UI_METHOD *ui_method, void *cb_data)
 {
-	BIO *b;
-	EVP_PKEY *pkey;
-	PKCS8_PRIV_KEY_INFO *p8inf;
-	UI *ui;
-	char auth[256];
-
-	fprintf(stderr, "ENGINE: engine_load_key called\n");
-
-	if (!is_initialized) {
-		fprintf(stderr, "Load Key called without correct initialization\n");
-		return NULL;
-	}
-	b = BIO_new_file(key_id, "r");
-	if (!b) {
-		fprintf(stderr, "File %s does not exist or cannot be read\n", key_id);
-		return 0;
-	}
-	/* Basically read an EVP_PKEY private key file with different
-	 * PEM guards --- we are a test engine */
-	p8inf = PEM_ASN1_read_bio((d2i_of_void *)d2i_PKCS8_PRIV_KEY_INFO,
-				 "TEST ENGINE KEY", b,
-				 NULL, NULL, NULL);
-	BIO_free(b);
-	if (!p8inf) {
-		fprintf(stderr, "Failed to read engine private key\n");
-		return NULL;
-	}
-	pkey = EVP_PKCS82PKEY(p8inf);
-
-	/* now we have a private key, pretend it had a password
-	 * this verifies the password makes it through openvpn OK */
-	ui = UI_new();
-
-	if (ui_method)
-		UI_set_method(ui, ui_method);
-
-	UI_add_user_data(ui, cb_data);
-
-	if (UI_add_input_string(ui, "enter test engine key",
-				UI_INPUT_FLAG_DEFAULT_PWD,
-				auth, 0, sizeof(auth)) == 0) {
-		fprintf(stderr, "UI_add_input_string failed\n");
-		goto out;
-	}
-
-	if (UI_process(ui)) {
-		fprintf(stderr, "UI_process failed\n");
-		goto out;
-	}
-
-	fprintf(stderr, "ENGINE: engine_load_key got password %s\n", auth);
-
- out:
-	UI_free(ui);
-
-	return pkey;
+    BIO *b;
+    EVP_PKEY *pkey;
+    PKCS8_PRIV_KEY_INFO *p8inf;
+    UI *ui;
+    char auth[256];
+
+    fprintf(stderr, "ENGINE: engine_load_key called\n");
+
+    if (!is_initialized)
+    {
+        fprintf(stderr, "Load Key called without correct initialization\n");
+        return NULL;
+    }
+    b = BIO_new_file(key_id, "r");
+    if (!b)
+    {
+        fprintf(stderr, "File %s does not exist or cannot be read\n", key_id);
+        return 0;
+    }
+    /* Basically read an EVP_PKEY private key file with different
+     * PEM guards --- we are a test engine */
+    p8inf = PEM_ASN1_read_bio((d2i_of_void *)d2i_PKCS8_PRIV_KEY_INFO,
+                              "TEST ENGINE KEY", b,
+                              NULL, NULL, NULL);
+    BIO_free(b);
+    if (!p8inf)
+    {
+        fprintf(stderr, "Failed to read engine private key\n");
+        return NULL;
+    }
+    pkey = EVP_PKCS82PKEY(p8inf);
+
+    /* now we have a private key, pretend it had a password
+     * this verifies the password makes it through openvpn OK */
+    ui = UI_new();
+
+    if (ui_method)
+    {
+        UI_set_method(ui, ui_method);
+    }
+
+    UI_add_user_data(ui, cb_data);
+
+    if (UI_add_input_string(ui, "enter test engine key",
+                            UI_INPUT_FLAG_DEFAULT_PWD,
+                            auth, 0, sizeof(auth)) == 0)
+    {
+        fprintf(stderr, "UI_add_input_string failed\n");
+        goto out;
+    }
+
+    if (UI_process(ui))
+    {
+        fprintf(stderr, "UI_process failed\n");
+        goto out;
+    }
+
+    fprintf(stderr, "ENGINE: engine_load_key got password %s\n", auth);
+
+out:
+    UI_free(ui);
+
+    return pkey;
 }
 
 
-static int engine_bind_fn(ENGINE *e, const char *id)
+static int
+engine_bind_fn(ENGINE *e, const char *id)
 {
-	if (id && strcmp(id, engine_id) != 0)
-		return 0;
-	if (!ENGINE_set_id(e, engine_id) ||
-	    !ENGINE_set_name(e, engine_name) ||
-	    !ENGINE_set_init_function(e, engine_init) ||
-	    !ENGINE_set_finish_function(e, engine_finish) ||
-	    !ENGINE_set_load_privkey_function(e, engine_load_key))
-		return 0;
-	return 1;
+    if (id && strcmp(id, engine_id) != 0)
+    {
+        return 0;
+    }
+    if (!ENGINE_set_id(e, engine_id)
+        || !ENGINE_set_name(e, engine_name)
+        || !ENGINE_set_init_function(e, engine_init)
+        || !ENGINE_set_finish_function(e, engine_finish)
+        || !ENGINE_set_load_privkey_function(e, engine_load_key))
+    {
+        return 0;
+    }
+    return 1;
 }
 
 IMPLEMENT_DYNAMIC_CHECK_FN()
-- 
2.26.2


