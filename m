From: Steffan Karger <steffan@...1856...>
Date: Sat, 25 Oct 2014 22:35:21 +0200
Message-Id: <1414269324-14102-4-git-send-email-steffan@...1856...>
In-Reply-To: <1414269324-14102-1-git-send-email-steffan@...1856...>
References: <1414269324-14102-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 3/6] polarssl: don't ignore failed
	ssl_init(), but ASSERT() on failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Since key_state_ssl_init() returns void, it *must* succeed. By changing the
'if(a) { success } else ignore' into 'ASSERT(a); success', we make sure we
don't fail (which we in practice don't do, because otherwise we would have
had complaining users with hard to trace errors).

This patch just changes the if() to an ASSERT(), but that causes a lot of
indenting changes, making this patch look a lot bigger than it really is.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_polarssl.c | 128 ++++++++++++++++++++++-----------------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index b332021..1a77c30 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -682,89 +682,89 @@ void key_state_ssl_init(struct key_state_ssl *ks_ssl,
   CLEAR(*ks_ssl);
 
   ALLOC_OBJ_CLEAR(ks_ssl->ctx, ssl_context);
-  if (polar_ok(ssl_init(ks_ssl->ctx))) /* FIXME ASSERT() or propagate errors */
-    {
-      /* Initialise SSL context */
-      ssl_set_dbg (ks_ssl->ctx, my_debug, NULL);
-      ssl_set_endpoint (ks_ssl->ctx, ssl_ctx->endpoint);
 
-      ssl_set_rng (ks_ssl->ctx, ctr_drbg_random, rand_ctx_get());
+  ASSERT (polar_ok(ssl_init(ks_ssl->ctx)));
+
+  /* Initialise SSL context */
+  ssl_set_dbg (ks_ssl->ctx, my_debug, NULL);
+  ssl_set_endpoint (ks_ssl->ctx, ssl_ctx->endpoint);
+
+  ssl_set_rng (ks_ssl->ctx, ctr_drbg_random, rand_ctx_get());
 
-      if (ssl_ctx->allowed_ciphers)
-	ssl_set_ciphersuites (ks_ssl->ctx, ssl_ctx->allowed_ciphers);
+  if (ssl_ctx->allowed_ciphers)
+    ssl_set_ciphersuites (ks_ssl->ctx, ssl_ctx->allowed_ciphers);
 
-      /* Initialise authentication information */
-      if (is_server)
-	ASSERT (polar_ok(ssl_set_dh_param_ctx(ks_ssl->ctx, ssl_ctx->dhm_ctx)));
+  /* Initialise authentication information */
+  if (is_server)
+    ASSERT (polar_ok(ssl_set_dh_param_ctx(ks_ssl->ctx, ssl_ctx->dhm_ctx)));
 #if defined(ENABLE_PKCS11)
-      if (ssl_ctx->priv_key_pkcs11 != NULL)
-	ASSERT (polar_ok(ssl_set_own_cert_alt(ks_ssl->ctx, ssl_ctx->crt_chain,
-	    ssl_ctx->priv_key_pkcs11, ssl_pkcs11_decrypt, ssl_pkcs11_sign,
-	    ssl_pkcs11_key_len)));
-      else
+  if (ssl_ctx->priv_key_pkcs11 != NULL)
+    ASSERT (polar_ok(ssl_set_own_cert_alt(ks_ssl->ctx, ssl_ctx->crt_chain,
+	ssl_ctx->priv_key_pkcs11, ssl_pkcs11_decrypt, ssl_pkcs11_sign,
+	ssl_pkcs11_key_len)));
+  else
 #endif
 #if defined(MANAGMENT_EXTERNAL_KEY)
-      if (ssl_ctx->external_key != NULL)
-	ASSERT (polar_ok(ssl_set_own_cert_alt(ks_ssl->ctx, ssl_ctx->crt_chain,
-	   ssl_ctx->external_key, NULL, external_pkcs1_sign,
-	   external_key_len)));
-      else
+  if (ssl_ctx->external_key != NULL)
+    ASSERT (polar_ok(ssl_set_own_cert_alt(ks_ssl->ctx, ssl_ctx->crt_chain,
+       ssl_ctx->external_key, NULL, external_pkcs1_sign,
+       external_key_len)));
+  else
 #endif
-	ASSERT (polar_ok(ssl_set_own_cert( ks_ssl->ctx, ssl_ctx->crt_chain,
-	    ssl_ctx->priv_key )));
+    ASSERT (polar_ok(ssl_set_own_cert( ks_ssl->ctx, ssl_ctx->crt_chain,
+	ssl_ctx->priv_key )));
 
-      /* Initialise SSL verification */
+  /* Initialise SSL verification */
 #if P2MP_SERVER
-      if (session->opt->ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED)
-	{
-	  msg (M_WARN, "WARNING: POTENTIALLY DANGEROUS OPTION "
-	   "--client-cert-not-required may accept clients which do not present "
-	   "a certificate");
-	}
-      else
+  if (session->opt->ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED)
+    {
+      msg (M_WARN, "WARNING: POTENTIALLY DANGEROUS OPTION "
+       "--client-cert-not-required may accept clients which do not present "
+       "a certificate");
+    }
+  else
 #endif
-      {
-	ssl_set_authmode (ks_ssl->ctx, SSL_VERIFY_REQUIRED);
-	ssl_set_verify (ks_ssl->ctx, verify_callback, session);
-      }
+  {
+    ssl_set_authmode (ks_ssl->ctx, SSL_VERIFY_REQUIRED);
+    ssl_set_verify (ks_ssl->ctx, verify_callback, session);
+  }
 
-      /* TODO: PolarSSL does not currently support sending the CA chain to the client */
-      ssl_set_ca_chain (ks_ssl->ctx, ssl_ctx->ca_chain, NULL, NULL );
+  /* TODO: PolarSSL does not currently support sending the CA chain to the client */
+  ssl_set_ca_chain (ks_ssl->ctx, ssl_ctx->ca_chain, NULL, NULL );
 
-      /* Initialize minimum TLS version */
+  /* Initialize minimum TLS version */
+  {
+    const int tls_version_min = (session->opt->ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SSLF_TLS_VERSION_MASK;
+    int polar_major;
+    int polar_minor;
+    switch (tls_version_min)
       {
-	const int tls_version_min = (session->opt->ssl_flags >> SSLF_TLS_VERSION_SHIFT) & SSLF_TLS_VERSION_MASK;
-	int polar_major;
-	int polar_minor;
-	switch (tls_version_min)
-	  {
-	  case TLS_VER_1_0:
-	  default:
-	    polar_major = SSL_MAJOR_VERSION_3;
-	    polar_minor = SSL_MINOR_VERSION_1;
-	    break;
+      case TLS_VER_1_0:
+      default:
+	polar_major = SSL_MAJOR_VERSION_3;
+	polar_minor = SSL_MINOR_VERSION_1;
+	break;
 #if defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_2)
-	  case TLS_VER_1_1:
-	    polar_major = SSL_MAJOR_VERSION_3;
-	    polar_minor = SSL_MINOR_VERSION_2;
-	    break;
+      case TLS_VER_1_1:
+	polar_major = SSL_MAJOR_VERSION_3;
+	polar_minor = SSL_MINOR_VERSION_2;
+	break;
 #endif
 #if defined(SSL_MAJOR_VERSION_3) && defined(SSL_MINOR_VERSION_3)
-	  case TLS_VER_1_2:
-	    polar_major = SSL_MAJOR_VERSION_3;
-	    polar_minor = SSL_MINOR_VERSION_3;
-	    break;
+      case TLS_VER_1_2:
+	polar_major = SSL_MAJOR_VERSION_3;
+	polar_minor = SSL_MINOR_VERSION_3;
+	break;
 #endif
-	  }
-	ssl_set_min_version(ks_ssl->ctx, polar_major, polar_minor);
       }
+    ssl_set_min_version(ks_ssl->ctx, polar_major, polar_minor);
+  }
 
-      /* Initialise BIOs */
-      ALLOC_OBJ_CLEAR (ks_ssl->ct_in, endless_buffer);
-      ALLOC_OBJ_CLEAR (ks_ssl->ct_out, endless_buffer);
-      ssl_set_bio (ks_ssl->ctx, endless_buf_read, ks_ssl->ct_in,
-	  endless_buf_write, ks_ssl->ct_out);
-    }
+  /* Initialise BIOs */
+  ALLOC_OBJ_CLEAR (ks_ssl->ct_in, endless_buffer);
+  ALLOC_OBJ_CLEAR (ks_ssl->ct_out, endless_buffer);
+  ssl_set_bio (ks_ssl->ctx, endless_buf_read, ks_ssl->ct_in,
+      endless_buf_write, ks_ssl->ct_out);
 }
 
 void
-- 
1.9.1


