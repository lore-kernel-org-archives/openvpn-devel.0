From: Tom van Leeuwen <tom.van.leeuwen@...2545...>
Message-ID: <ce155eed-2936-8d5c-33a8-36f355fa243a@...2545...>
Date: Tue, 24 Mar 2020 11:42:02 +0100
MIME-Version: 1.0
Content-Language: en-US
Subject: [Openvpn-devel] [PATCH] mbedTLS: Make sure TLS session survives move
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

When an mbedTLS session is moved in move_session(), the contents of the
the tls_session is copied to the new session and the old session is
reinitialized. This tls_session contains, amongst other things, an
mbedtls_ssl_config and bio_ctx structure. However, the mbedtls context has
internal pointers to the mbedtls_ssl_config and bio_ctx. When the session
is moved, these internal pointers point to the reinitialized session.
Since there is no public method to update these internal pointers, this
patch allocates the mbedtls_ssl_config and bio_ctx on the heap and stores
the pointers in the tls_session instead.

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 0f0b035b..4f194ad7 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1036,21 +1036,22 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
     CLEAR(*ks_ssl);
 
     /* Initialise SSL config */
-    mbedtls_ssl_config_init(&ks_ssl->ssl_config);
-    mbedtls_ssl_config_defaults(&ks_ssl->ssl_config, ssl_ctx->endpoint,
+    ALLOC_OBJ_CLEAR(ks_ssl->ssl_config, mbedtls_ssl_config);
+    mbedtls_ssl_config_init(ks_ssl->ssl_config);
+    mbedtls_ssl_config_defaults(ks_ssl->ssl_config, ssl_ctx->endpoint,
                                 MBEDTLS_SSL_TRANSPORT_STREAM,
MBEDTLS_SSL_PRESET_DEFAULT);
 #ifdef MBEDTLS_DEBUG_C
     mbedtls_debug_set_threshold(3);
 #endif
-    mbedtls_ssl_conf_dbg(&ks_ssl->ssl_config, my_debug, NULL);
-    mbedtls_ssl_conf_rng(&ks_ssl->ssl_config, mbedtls_ctr_drbg_random,
+    mbedtls_ssl_conf_dbg(ks_ssl->ssl_config, my_debug, NULL);
+    mbedtls_ssl_conf_rng(ks_ssl->ssl_config, mbedtls_ctr_drbg_random,
                          rand_ctx_get());
 
-    mbedtls_ssl_conf_cert_profile(&ks_ssl->ssl_config,
&ssl_ctx->cert_profile);
+    mbedtls_ssl_conf_cert_profile(ks_ssl->ssl_config,
&ssl_ctx->cert_profile);
 
     if (ssl_ctx->allowed_ciphers)
     {
-        mbedtls_ssl_conf_ciphersuites(&ks_ssl->ssl_config,
ssl_ctx->allowed_ciphers);
+        mbedtls_ssl_conf_ciphersuites(ks_ssl->ssl_config,
ssl_ctx->allowed_ciphers);
     }
 
     /* Disable record splitting (for now).  OpenVPN assumes records are
sent
@@ -1058,35 +1059,35 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
      * testing.  Since OpenVPN is not susceptible to BEAST, we can just
      * disable record splitting as a quick fix. */
 #if defined(MBEDTLS_SSL_CBC_RECORD_SPLITTING)
-    mbedtls_ssl_conf_cbc_record_splitting(&ks_ssl->ssl_config,
+    mbedtls_ssl_conf_cbc_record_splitting(ks_ssl->ssl_config,
                                          
MBEDTLS_SSL_CBC_RECORD_SPLITTING_DISABLED);
 #endif /* MBEDTLS_SSL_CBC_RECORD_SPLITTING */
 
     /* Initialise authentication information */
     if (is_server)
     {
-        mbed_ok(mbedtls_ssl_conf_dh_param_ctx(&ks_ssl->ssl_config,
+        mbed_ok(mbedtls_ssl_conf_dh_param_ctx(ks_ssl->ssl_config,
                                               ssl_ctx->dhm_ctx));
     }
 
-    mbed_ok(mbedtls_ssl_conf_own_cert(&ks_ssl->ssl_config,
ssl_ctx->crt_chain,
+    mbed_ok(mbedtls_ssl_conf_own_cert(ks_ssl->ssl_config,
ssl_ctx->crt_chain,
                                       ssl_ctx->priv_key));
 
     /* Initialise SSL verification */
 #if P2MP_SERVER
     if (session->opt->ssl_flags & SSLF_CLIENT_CERT_OPTIONAL)
     {
-        mbedtls_ssl_conf_authmode(&ks_ssl->ssl_config,
MBEDTLS_SSL_VERIFY_OPTIONAL);
+        mbedtls_ssl_conf_authmode(ks_ssl->ssl_config,
MBEDTLS_SSL_VERIFY_OPTIONAL);
     }
     else if (!(session->opt->ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED))
 #endif
     {
-        mbedtls_ssl_conf_authmode(&ks_ssl->ssl_config,
MBEDTLS_SSL_VERIFY_REQUIRED);
+        mbedtls_ssl_conf_authmode(ks_ssl->ssl_config,
MBEDTLS_SSL_VERIFY_REQUIRED);
     }
-    mbedtls_ssl_conf_verify(&ks_ssl->ssl_config, verify_callback, session);
+    mbedtls_ssl_conf_verify(ks_ssl->ssl_config, verify_callback, session);
 
     /* TODO: mbed TLS does not currently support sending the CA chain
to the client */
-    mbedtls_ssl_conf_ca_chain(&ks_ssl->ssl_config, ssl_ctx->ca_chain,
ssl_ctx->crl);
+    mbedtls_ssl_conf_ca_chain(ks_ssl->ssl_config, ssl_ctx->ca_chain,
ssl_ctx->crl);
 
     /* Initialize minimum TLS version */
     {
@@ -1103,7 +1104,7 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
             tls_version_to_major_minor(tls_version_min, &major, &minor);
         }
 
-        mbedtls_ssl_conf_min_version(&ks_ssl->ssl_config, major, minor);
+        mbedtls_ssl_conf_min_version(ks_ssl->ssl_config, major, minor);
     }
 
     /* Initialize maximum TLS version */
@@ -1116,7 +1117,7 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
         {
             int major, minor;
             tls_version_to_major_minor(tls_version_max, &major, &minor);
-            mbedtls_ssl_conf_max_version(&ks_ssl->ssl_config, major,
minor);
+            mbedtls_ssl_conf_max_version(ks_ssl->ssl_config, major, minor);
         }
     }
 
@@ -1124,7 +1125,7 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
     /* Initialize keying material exporter */
     if (session->opt->ekm_size)
     {
-        mbedtls_ssl_conf_export_keys_ext_cb(&ks_ssl->ssl_config,
+        mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl->ssl_config,
                 mbedtls_ssl_export_keys_cb, session);
     }
 #endif
@@ -1132,11 +1133,11 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
     /* Initialise SSL context */
     ALLOC_OBJ_CLEAR(ks_ssl->ctx, mbedtls_ssl_context);
     mbedtls_ssl_init(ks_ssl->ctx);
-    mbedtls_ssl_setup(ks_ssl->ctx, &ks_ssl->ssl_config);
+    mbedtls_ssl_setup(ks_ssl->ctx, ks_ssl->ssl_config);
 
     /* Initialise BIOs */
-    CLEAR(ks_ssl->bio_ctx);
-    mbedtls_ssl_set_bio(ks_ssl->ctx, &ks_ssl->bio_ctx, ssl_bio_write,
+    ALLOC_OBJ_CLEAR(ks_ssl->bio_ctx, bio_ctx);
+    mbedtls_ssl_set_bio(ks_ssl->ctx, ks_ssl->bio_ctx, ssl_bio_write,
                         ssl_bio_read, NULL);
 }
 
@@ -1152,9 +1153,17 @@ key_state_ssl_free(struct key_state_ssl *ks_ssl)
             mbedtls_ssl_free(ks_ssl->ctx);
             free(ks_ssl->ctx);
         }
-        mbedtls_ssl_config_free(&ks_ssl->ssl_config);
-        buf_free_entries(&ks_ssl->bio_ctx.in);
-        buf_free_entries(&ks_ssl->bio_ctx.out);
+        if (ks_ssl->ssl_config)
+        {
+            mbedtls_ssl_config_free(ks_ssl->ssl_config);
+            free(ks_ssl->ssl_config);
+        }
+        if (ks_ssl->bio_ctx)
+        {
+            buf_free_entries(&ks_ssl->bio_ctx->in);
+            buf_free_entries(&ks_ssl->bio_ctx->out);
+            free(ks_ssl->bio_ctx);
+        }
         CLEAR(*ks_ssl);
     }
 }
@@ -1249,7 +1258,7 @@ key_state_read_ciphertext(struct key_state_ssl
*ks, struct buffer *buf,
         len = maxlen;
     }
 
-    retval = endless_buf_read(&ks->bio_ctx.out, BPTR(buf), len);
+    retval = endless_buf_read(&ks->bio_ctx->out, BPTR(buf), len);
 
     /* Error during read, check for retry error */
     if (retval < 0)
@@ -1294,7 +1303,7 @@ key_state_write_ciphertext(struct key_state_ssl
*ks, struct buffer *buf)
         return 0;
     }
 
-    retval = endless_buf_write(&ks->bio_ctx.in, BPTR(buf), buf->len);
+    retval = endless_buf_write(&ks->bio_ctx->in, BPTR(buf), buf->len);
 
     if (retval < 0)
     {
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index c1c676dc..92381f1a 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -109,9 +109,9 @@ struct tls_root_ctx {
 };
 
 struct key_state_ssl {
-    mbedtls_ssl_config ssl_config;      /**< mbedTLS global ssl config */
+    mbedtls_ssl_config *ssl_config;     /**< mbedTLS global ssl config */
     mbedtls_ssl_context *ctx;           /**< mbedTLS connection context */
-    bio_ctx bio_ctx;
+    bio_ctx *bio_ctx;
 
     /** Keying material exporter cache (RFC 5705). */
     uint8_t *exported_key_material;



