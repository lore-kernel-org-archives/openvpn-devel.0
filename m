From: Adriaan de Jong <dejong@...1435...>
Date: Tue, 14 Feb 2012 11:11:26 +0100
Message-ID: <1329214286-9179-4-git-send-email-dejong@...1435...>
In-Reply-To: <1329214286-9179-1-git-send-email-dejong@...1435...>
References: <1329214286-9179-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] Migrated x509_get_sha1_hash to use the
	garbage collector
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

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 ssl_verify.c          |    7 ++-----
 ssl_verify_backend.h  |   11 ++---------
 ssl_verify_openssl.c  |   17 ++++-------------
 ssl_verify_polarssl.c |   17 +++--------------
 4 files changed, 11 insertions(+), 41 deletions(-)

diff --git a/ssl_verify.c b/ssl_verify.c
index 352118a..018278e 100644
--- a/ssl_verify.c
+++ b/ssl_verify.c
@@ -401,12 +401,11 @@ verify_cert_set_env(struct env_set *es, x509_cert_t *peer_cert, int cert_depth,
 #ifdef ENABLE_EUREPHIA
   /* export X509 cert SHA1 fingerprint */
   {
-    unsigned char *sha1_hash = x509_get_sha1_hash(peer_cert);
+    unsigned char *sha1_hash = x509_get_sha1_hash(peer_cert, &gc);
 
     openvpn_snprintf (envname, sizeof(envname), "tls_digest_%d", cert_depth);
     setenv_str (es, envname, format_hex_ex(sha1_hash, SHA_DIGEST_LENGTH, 0, 1,
 					  ":", &gc));
-    x509_free_sha1_hash(sha1_hash);
   }
 #endif
 
@@ -614,14 +613,12 @@ verify_cert(struct tls_session *session, x509_cert_t *cert, int cert_depth)
   /* verify level 1 cert, i.e. the CA that signed our leaf cert */
   if (cert_depth == 1 && opt->verify_hash)
     {
-      unsigned char *sha1_hash = x509_get_sha1_hash(cert);
+      unsigned char *sha1_hash = x509_get_sha1_hash(cert, &gc);
       if (memcmp (sha1_hash, opt->verify_hash, SHA_DIGEST_LENGTH))
       {
 	msg (D_TLS_ERRORS, "TLS Error: level-1 certificate hash verification failed");
-	x509_free_sha1_hash(sha1_hash);
 	goto err;
       }
-      x509_free_sha1_hash(sha1_hash);
     }
 
   /* save common name in session object */
diff --git a/ssl_verify_backend.h b/ssl_verify_backend.h
index 5c69b11..ae64061 100644
--- a/ssl_verify_backend.h
+++ b/ssl_verify_backend.h
@@ -90,20 +90,13 @@ char *x509_get_subject (x509_cert_t *cert, struct gc_arena *gc);
 
 /* Retrieve the certificate's SHA1 hash.
  *
- * The returned string must be freed with \c verify_free_sha1_hash()
- *
  * @param cert		Certificate to retrieve the hash from.
+ * @param gc		Garbage collection arena to use when allocating string.
  *
  * @return 		a string containing the SHA1 hash of the certificate
  */
-unsigned char *x509_get_sha1_hash (x509_cert_t *cert);
+unsigned char *x509_get_sha1_hash (x509_cert_t *cert, struct gc_arena *gc);
 
-/*
- * Free a hash as returned by \c verify_get_hash()
- *
- * @param hash		The subject to be freed.
- */
-void x509_free_sha1_hash (unsigned char *hash);
 
 /*
  * Retrieve the certificate's username from the specified field.
diff --git a/ssl_verify_openssl.c b/ssl_verify_openssl.c
index 6d31bb3..f7e7d52 100644
--- a/ssl_verify_openssl.c
+++ b/ssl_verify_openssl.c
@@ -43,7 +43,6 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
   struct tls_session *session;
   SSL *ssl;
   struct gc_arena gc = gc_new();
-  unsigned char *sha1_hash = NULL;
 
   /* get the tls_session pointer */
   ssl = X509_STORE_CTX_get_ex_data (ctx, SSL_get_ex_data_X509_STORE_CTX_idx());
@@ -51,9 +50,8 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
   session = (struct tls_session *) SSL_get_ex_data (ssl, mydata_index);
   ASSERT (session);
 
-  sha1_hash = x509_get_sha1_hash(ctx->current_cert);
-  cert_hash_remember (session, ctx->error_depth, sha1_hash);
-  x509_free_sha1_hash(sha1_hash);
+  cert_hash_remember (session, ctx->error_depth,
+      x509_get_sha1_hash(ctx->current_cert, &gc));
 
   /* did peer present cert which was signed by our root cert? */
   if (!preverify_ok)
@@ -232,20 +230,13 @@ x509_get_serial (x509_cert_t *cert, struct gc_arena *gc)
 }
 
 unsigned char *
-x509_get_sha1_hash (X509 *cert)
+x509_get_sha1_hash (X509 *cert, struct gc_arena *gc)
 {
-  char *hash = malloc(SHA_DIGEST_LENGTH);
+  char *hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
   memcpy(hash, cert->sha1_hash, SHA_DIGEST_LENGTH);
   return hash;
 }
 
-void
-x509_free_sha1_hash (unsigned char *hash)
-{
-  if (hash)
-    free(hash);
-}
-
 char *
 x509_get_subject (X509 *cert, struct gc_arena *gc)
 {
diff --git a/ssl_verify_polarssl.c b/ssl_verify_polarssl.c
index 065b30d..2ba0a5c 100644
--- a/ssl_verify_polarssl.c
+++ b/ssl_verify_polarssl.c
@@ -42,7 +42,6 @@ verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
 {
   struct tls_session *session = (struct tls_session *) session_obj;
   struct gc_arena gc = gc_new();
-  unsigned char *sha1_hash = NULL;
 
   ASSERT (cert);
   ASSERT (session);
@@ -50,9 +49,7 @@ verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
   session->verified = false;
 
   /* Remember certificate hash */
-  sha1_hash = x509_get_sha1_hash(cert);
-  cert_hash_remember (session, cert_depth, sha1_hash);
-  x509_free_sha1_hash(sha1_hash);
+  cert_hash_remember (session, cert_depth, x509_get_sha1_hash(cert, &gc));
 
   /* did peer present cert which was signed by our root cert? */
   if (!preverify_ok)
@@ -135,20 +132,13 @@ x509_get_serial (x509_cert *cert, struct gc_arena *gc)
 }
 
 unsigned char *
-x509_get_sha1_hash (x509_cert *cert)
+x509_get_sha1_hash (x509_cert *cert, struct gc_arena *gc)
 {
-  unsigned char *sha1_hash = malloc(SHA_DIGEST_LENGTH);
+  unsigned char *sha1_hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
   sha1(cert->tbs.p, cert->tbs.len, sha1_hash);
   return sha1_hash;
 }
 
-void
-x509_free_sha1_hash (unsigned char *hash)
-{
-  if (hash)
-    free(hash);
-}
-
 char *
 x509_get_subject(x509_cert *cert, struct gc_arena *gc)
 {
@@ -167,7 +157,6 @@ x509_get_subject(x509_cert *cert, struct gc_arena *gc)
   return subject;
 }
 
-
 /*
  * Save X509 fields to environment, using the naming convention:
  *
-- 
1.7.5.4


