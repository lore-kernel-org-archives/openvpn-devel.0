From: Gert Doering <gert@...1296...>
Date: Tue, 16 Dec 2025 15:42:00 +0100
Message-ID: <20251216144207.12171-1-gert@...1296...>
In-Reply-To: <gerrit.1765381324000.I21251a42f94fa1d9de083d2acd95b887658c5760@...2715...>
References: <gerrit.1765381324000.I21251a42f94fa1d9de083d2acd95b887658c5760@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] Change ssl_ctx in struct tls_options to
 be a pointer
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

From: Arne Schwabe <arne@...1227...>

The SSL CTX is shared between all of the instances. So any change to the
SSL CTX will affect all instances. Currently the CRL is also reloaded
potentially multiple times as each copy of tls_root_ctx has its own
crl_last_mtime and crl_last_size values that will be checked if the CRL
reload is necessary.

Changing it to a pointer will make it more clear that this is shared
and also the CRL being reloaded multiple times.

Change-Id: I21251a42f94fa1d9de083d2acd95b887658c5760
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1431
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1431
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index cd01520..ee198ce 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2964,9 +2964,10 @@
 key_schedule_free(struct key_schedule *ks, bool free_ssl_ctx)
 {
     free_key_ctx_bi(&ks->static_key);
-    if (tls_ctx_initialised(&ks->ssl_ctx) && free_ssl_ctx)
+    if (tls_ctx_initialised(ks->ssl_ctx) && free_ssl_ctx)
     {
-        tls_ctx_free(&ks->ssl_ctx);
+        tls_ctx_free(ks->ssl_ctx);
+        free(ks->ssl_ctx);
         free_key_ctx(&ks->auth_token_key);
     }
     CLEAR(*ks);
@@ -3121,14 +3122,15 @@
 {
     const struct options *options = &c->options;
 
-    if (!tls_ctx_initialised(&c->c1.ks.ssl_ctx))
+    if (!tls_ctx_initialised(c->c1.ks.ssl_ctx))
     {
         /*
          * Initialize the OpenSSL library's global
          * SSL context.
          */
-        init_ssl(options, &(c->c1.ks.ssl_ctx), c->c0 && c->c0->uid_gid_chroot_set);
-        if (!tls_ctx_initialised(&c->c1.ks.ssl_ctx))
+        ASSERT(NULL == c->c1.ks.ssl_ctx);
+        c->c1.ks.ssl_ctx = init_ssl(options, c->c0 && c->c0->uid_gid_chroot_set);
+        if (!tls_ctx_initialised(c->c1.ks.ssl_ctx))
         {
             switch (auth_retry_get())
             {
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 3e1ae78..9325e21 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -60,7 +60,7 @@
     struct key_ctx_bi static_key;
 
     /* our global SSL context */
-    struct tls_root_ctx ssl_ctx;
+    struct tls_root_ctx *ssl_ctx;
 
     /* optional TLS control channel wrapping */
     struct key_type tls_auth_key_type;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 741f40a..5ee51e9 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -507,11 +507,9 @@
  * Initialize SSL context.
  * All files are in PEM format.
  */
-void
-init_ssl(const struct options *options, struct tls_root_ctx *new_ctx, bool in_chroot)
+struct tls_root_ctx *
+init_ssl(const struct options *options, bool in_chroot)
 {
-    ASSERT(NULL != new_ctx);
-
     tls_clear_error();
 
     if (key_is_external(options))
@@ -519,6 +517,9 @@
         load_xkey_provider();
     }
 
+    struct tls_root_ctx *new_ctx;
+    ALLOC_OBJ_CLEAR(new_ctx, struct tls_root_ctx);
+
     if (options->tls_server)
     {
         tls_ctx_server_new(new_ctx);
@@ -664,12 +665,13 @@
 #endif
 
     tls_clear_error();
-    return;
+    return new_ctx;
 
 err:
     tls_clear_error();
     tls_ctx_free(new_ctx);
-    return;
+    free(new_ctx);
+    return NULL;
 }
 
 /*
@@ -821,7 +823,7 @@
      * Build TLS object that reads/writes ciphertext
      * to/from memory BIOs.
      */
-    key_state_ssl_init(&ks->ks_ssl, &session->opt->ssl_ctx, session->opt->server, session);
+    key_state_ssl_init(&ks->ks_ssl, session->opt->ssl_ctx, session->opt->server, session);
 
     /* Set control-channel initiation mode */
     ks->initial_opcode = session->initial_opcode;
@@ -872,11 +874,12 @@
 
     /*
      * Attempt CRL reload before TLS negotiation. Won't be performed if
-     * the file was not modified since the last reload
+     * the file was not modified since the last reload. This affects
+     * all instances (all instances share the same context).
      */
     if (session->opt->crl_file && !(session->opt->ssl_flags & SSLF_CRL_VERIFY_DIR))
     {
-        tls_ctx_reload_crl(&session->opt->ssl_ctx, session->opt->crl_file,
+        tls_ctx_reload_crl(session->opt->ssl_ctx, session->opt->crl_file,
                            session->opt->crl_file_inline);
     }
 }
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index db8a798..9ee9f38 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -144,7 +144,7 @@
  * Build master SSL context object that serves for the whole of OpenVPN
  * instantiation
  */
-void init_ssl(const struct options *options, struct tls_root_ctx *ctx, bool in_chroot);
+struct tls_root_ctx *init_ssl(const struct options *options, bool in_chroot);
 
 /** @addtogroup control_processor
  *  @{ */
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 3129299..2764840 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -305,8 +305,10 @@
  */
 struct tls_options
 {
-    /* our master TLS context from which all SSL objects derived */
-    struct tls_root_ctx ssl_ctx;
+    /* our master TLS context from which all SSL objects are derived,
+     * this context is shared between all instances in p2pm with
+     * inherit_context_child. */
+    struct tls_root_ctx *ssl_ctx;
 
     /* data channel cipher, hmac, and key lengths */
     struct key_type key_type;
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 3440319..28b92ed 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -157,8 +157,10 @@
 bool
 tls_ctx_initialised(struct tls_root_ctx *ctx)
 {
-    ASSERT(NULL != ctx);
-    return ctx->initialised;
+    /* either this should be NULL or should be non-null and then have a
+     * valid TLS ctx inside as well */
+    ASSERT(NULL == ctx || ctx->initialised);
+    return ctx != NULL;
 }
 #if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
 /*
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index a4a6863..48bbdfc 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -147,8 +147,10 @@
 bool
 tls_ctx_initialised(struct tls_root_ctx *ctx)
 {
-    ASSERT(NULL != ctx);
-    return NULL != ctx->ctx;
+    /* either this should be NULL or should be non-null and then have a
+     * valid TLS ctx inside as well */
+    ASSERT(ctx == NULL || ctx->ctx != NULL);
+    return ctx != NULL;
 }
 
 bool
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 250c806..b7de550 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -572,7 +572,7 @@
 tls_verify_crl_missing(const struct tls_options *opt)
 {
     if (opt->crl_file && !(opt->ssl_flags & SSLF_CRL_VERIFY_DIR)
-        && (opt->ssl_ctx.crl == NULL || opt->ssl_ctx.crl->version == 0))
+        && (opt->ssl_ctx->crl == NULL || opt->ssl_ctx->crl->version == 0))
     {
         return true;
     }
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 6cb04ee..633f78d 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -799,7 +799,7 @@
         return false;
     }
 
-    X509_STORE *store = SSL_CTX_get_cert_store(opt->ssl_ctx.ctx);
+    X509_STORE *store = SSL_CTX_get_cert_store(opt->ssl_ctx->ctx);
     if (!store)
     {
         crypto_msg(M_FATAL, "Cannot get certificate store");

