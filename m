From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sun,  1 Apr 2012 16:46:28 +0300
Message-Id: <1333287988-25921-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz1OjVKEq5+0BcAgS9PVPcs77oJemG+kD3S7ZZUv+TiAEg@...278...>
References: <CAOazyz1OjVKEq5+0BcAgS9PVPcs77oJemG+kD3S7ZZUv+TiAEg@...278...>
Subject: [Openvpn-devel] [PATCH] cleanup: gc usage
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Cleanup of "Use the garbage collector when retrieving x509 fields"
patch series.

Discussed at [1].

There should be an effort to produce common function prologue
and epilogue, so that cleanups will be done at single point.

[1] http://comments.gmane.org/gmane.network.openvpn.devel/5401

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/pkcs11.c              |    5 +--
 src/openvpn/pkcs11_polarssl.c     |    8 ++---
 src/openvpn/ssl_verify.c          |   53 +++++++++++++++++++++----------------
 src/openvpn/ssl_verify_openssl.c  |   15 ++++++----
 src/openvpn/ssl_verify_polarssl.c |   18 +++++++-----
 5 files changed, 55 insertions(+), 44 deletions(-)

diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index a6b8db5..d86e267 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -769,6 +769,7 @@ show_pkcs11_ids (
 	const char * const provider,
 	bool cert_private
 ) {
+	struct gc_arena gc = gc_new();
 	pkcs11h_certificate_id_list_t user_certificates = NULL;
 	pkcs11h_certificate_id_list_t current = NULL;
 	CK_RV rv = CKR_FUNCTION_FAILED;
@@ -834,7 +835,6 @@ show_pkcs11_ids (
 	);
 	for (current = user_certificates;current != NULL; current = current->next) {
 		pkcs11h_certificate_t certificate = NULL;
-		struct gc_arena gc = gc_new();
 		char *dn = NULL;
 		char serial[1024] = {0};
 		char *ser = NULL;
@@ -927,8 +927,6 @@ show_pkcs11_ids (
 			free (ser);
 			ser = NULL;
 		}
-
-		gc_free (&gc);
 	}
 
 cleanup:
@@ -938,6 +936,7 @@ cleanup:
 	}
 
 	pkcs11h_terminate ();
+	gc_free (&gc);
 }
 
 #else
diff --git a/src/openvpn/pkcs11_polarssl.c b/src/openvpn/pkcs11_polarssl.c
index f5b7b8b..03b2bab 100644
--- a/src/openvpn/pkcs11_polarssl.c
+++ b/src/openvpn/pkcs11_polarssl.c
@@ -75,7 +75,7 @@ cleanup:
 char *
 pkcs11_certificate_dn (pkcs11h_certificate_t cert, struct gc_arena *gc)
 {
-  int ret = 1;
+  char *ret = NULL;
   char dn[1024] = {0};
 
   x509_cert polar_cert = {0};
@@ -90,14 +90,12 @@ pkcs11_certificate_dn (pkcs11h_certificate_t cert, struct gc_arena *gc)
       goto cleanup;
   }
 
-  ret = 0;
+  ret = string_alloc(dn, gc);
 
 cleanup:
   x509_free(&polar_cert);
 
-  if (ret == 0)
-    return string_alloc(dn, gc);
-  return NULL;
+  return ret;
 }
 
 int
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 5783528..30fb05d 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -538,8 +538,9 @@ verify_cert_call_command(const char *verify_command, struct env_set *es,
 static result_t
 verify_check_crl_dir(const char *crl_dir, openvpn_x509_cert_t *cert)
 {
+  result_t ret = FAILURE;
   char fn[256];
-  int fd;
+  int fd = -1;
   struct gc_arena gc = gc_new();
 
   char *serial = x509_get_serial(cert, &gc);
@@ -547,26 +548,29 @@ verify_check_crl_dir(const char *crl_dir, openvpn_x509_cert_t *cert)
   if (!openvpn_snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, OS_SPECIFIC_DIRSEP, serial))
     {
       msg (D_HANDSHAKE, "VERIFY CRL: filename overflow");
-      gc_free(&gc);
-      return FAILURE;
+      goto cleanup;
     }
   fd = platform_open (fn, O_RDONLY, 0);
   if (fd >= 0)
     {
       msg (D_HANDSHAKE, "VERIFY CRL: certificate serial number %s is revoked", serial);
-      close(fd);
-      gc_free(&gc);
-      return FAILURE;
+      goto cleanup;
     }
 
-  gc_free(&gc);
+  ret = SUCCESS;
 
-  return SUCCESS;
+cleanup:
+
+  if (fd != -1)
+    close(fd);
+  gc_free(&gc);
+  return ret;
 }
 
 result_t
 verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_depth)
 {
+  result_t ret = FAILURE;
   char *subject = NULL;
   char common_name[TLS_USERNAME_LEN] = {0};
   const struct tls_options *opt;
@@ -583,7 +587,7 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
     {
 	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, could not extract X509 "
 	    "subject string from certificate", cert_depth);
-	goto err;
+	goto cleanup;
     }
 
   /* enforce character class restrictions in X509 name */
@@ -602,7 +606,7 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
 	       opt->x509_username_field,
 		 subject,
 		 TLS_USERNAME_LEN);
-	  goto err;
+	  goto cleanup;
 	}
     }
 
@@ -613,7 +617,7 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
   if (cert_depth >= MAX_CERT_DEPTH)
     {
       msg (D_TLS_ERRORS, "TLS Error: Convoluted certificate chain detected with depth [%d] greater than %d", cert_depth, MAX_CERT_DEPTH);
-      goto err;			/* Reject connection */
+      goto cleanup;			/* Reject connection */
     }
 
   /* verify level 1 cert, i.e. the CA that signed our leaf cert */
@@ -623,7 +627,7 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
       if (memcmp (sha1_hash, opt->verify_hash, SHA_DIGEST_LENGTH))
       {
 	msg (D_TLS_ERRORS, "TLS Error: level-1 certificate hash verification failed");
-	goto err;
+	goto cleanup;
       }
     }
 
@@ -645,16 +649,16 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
 
   /* If this is the peer's own certificate, verify it */
   if (cert_depth == 0 && SUCCESS != verify_peer_cert(opt, cert, subject, common_name))
-    goto err;
+    goto cleanup;
 
   /* call --tls-verify plug-in(s), if registered */
   if (SUCCESS != verify_cert_call_plugin(opt->plugins, opt->es, cert_depth, cert, subject))
-    goto err;
+    goto cleanup;
 
   /* run --tls-verify script */
   if (opt->verify_command && SUCCESS != verify_cert_call_command(opt->verify_command,
       opt->es, cert_depth, cert, subject, opt->verify_export_cert))
-    goto err;
+    goto cleanup;
 
   /* check peer cert against CRL */
   if (opt->crl_file)
@@ -662,26 +666,29 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
       if (opt->ssl_flags & SSLF_CRL_VERIFY_DIR)
       {
 	if (SUCCESS != verify_check_crl_dir(opt->crl_file, cert))
-	  goto err;
+	  goto cleanup;
       }
       else
       {
 	if (SUCCESS != x509_verify_crl(opt->crl_file, cert, subject))
-	  goto err;
+	  goto cleanup;
       }
     }
 
   msg (D_HANDSHAKE, "VERIFY OK: depth=%d, %s", cert_depth, subject);
   session->verified = true;
+  ret = SUCCESS;
 
-  gc_free(&gc);
-  return SUCCESS;
+cleanup:
 
- err:
-  tls_clear_error();
-  session->verified = false;
+  if (ret != SUCCESS)
+    {
+      tls_clear_error(); /* always? */
+      session->verified = false; /* double sure? */
+    }
   gc_free(&gc);
-  return FAILURE;
+
+  return ret;
 }
 
 /* ***************************************************************************
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 4dfabfc..f5dce0d 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -46,6 +46,7 @@
 int
 verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
 {
+  int ret = 0;
   struct tls_session *session;
   SSL *ssl;
   struct gc_arena gc = gc_new();
@@ -76,17 +77,19 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
 
       ERR_clear_error();
 
-      gc_free(&gc);
       session->verified = false;
-
-      return 0;
+      goto cleanup;
     }
 
+  if (SUCCESS != verify_cert(session, ctx->current_cert, ctx->error_depth))
+    goto cleanup;
+
+  ret = 1;
+
+cleanup:
   gc_free(&gc);
 
-  if (SUCCESS == verify_cert(session, ctx->current_cert, ctx->error_depth))
-    return 1;
-  return 0;
+  return ret;
 }
 
 #ifdef ENABLE_X509ALTUSERNAME
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index d9d4fd5..a32db8d 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -48,6 +48,7 @@ verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
 {
   struct tls_session *session = (struct tls_session *) session_obj;
   struct gc_arena gc = gc_new();
+  int ret = 1;
 
   ASSERT (cert);
   ASSERT (session);
@@ -68,18 +69,21 @@ verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
 	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, could not extract X509 "
 	      "subject string from certificate", cert_depth);
 
-      gc_free(&gc);
-      return 1;
+      goto cleanup;
     }
 
+  if (SUCCESS != verify_cert(session, cert, cert_depth))
+    goto cleanup;
+
+  ret = 0;
+
+cleanup:
+  gc_free(&gc);
+
   /*
    * PolarSSL expects 1 on failure, 0 on success
    */
-  gc_free(&gc);
-
-  if (SUCCESS == verify_cert(session, cert, cert_depth))
-    return 0;
-  return 1;
+  return ret;
 }
 
 #ifdef ENABLE_X509ALTUSERNAME
-- 
1.7.3.4


