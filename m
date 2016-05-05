From: Steffan Karger <steffan@...1856...>
Date: Thu,  5 May 2016 16:16:48 +0200
Message-Id: <1462457808-18833-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Add SHA256 fingerprint support
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

Add SHA256 fingerprint support for both the normal exported fingerprints
(tls_digest_n -> tls_digest_sha256_n), as well as for --x509-track.

Also switch to using the SHA256 fingerprint instead of the SHA1 fingerprint
internally, in cert_hash_remember() / cert_hash_compare().  And instead of
updating an #if 0'd code block that has been disabled since 2009, just
remove that.

This should take care of trac #675.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_verify.c         | 50 ++++++++++++++++------------------------
 src/openvpn/ssl_verify.h         |  2 +-
 src/openvpn/ssl_verify_backend.h | 25 +++++++++++++++-----
 src/openvpn/ssl_verify_mbedtls.c | 48 +++++++++++++++++++++++++++++---------
 src/openvpn/ssl_verify_openssl.c | 37 +++++++++++++++++++++--------
 5 files changed, 105 insertions(+), 57 deletions(-)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index b373bed..15a5de8 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -191,7 +191,8 @@ tls_username (const struct tls_multi *multi, const bool null)
 }
 
 void
-cert_hash_remember (struct tls_session *session, const int error_depth, const unsigned char *sha1_hash)
+cert_hash_remember (struct tls_session *session, const int error_depth,
+    const struct buffer *cert_hash)
 {
   if (error_depth >= 0 && error_depth < MAX_CERT_DEPTH)
     {
@@ -201,31 +202,12 @@ cert_hash_remember (struct tls_session *session, const int error_depth, const un
 	ALLOC_OBJ (session->cert_hash_set->ch[error_depth], struct cert_hash);
       {
 	struct cert_hash *ch = session->cert_hash_set->ch[error_depth];
-	memcpy (ch->sha1_hash, sha1_hash, SHA_DIGEST_LENGTH);
+	ASSERT (sizeof (ch->sha256_hash) == BLEN (cert_hash));
+	memcpy (ch->sha256_hash, BPTR (cert_hash), sizeof (ch->sha256_hash));
       }
     }
 }
 
-#if 0
-static void
-cert_hash_print (const struct cert_hash_set *chs, int msglevel)
-{
-  struct gc_arena gc = gc_new ();
-  msg (msglevel, "CERT_HASH");
-  if (chs)
-    {
-      int i;
-      for (i = 0; i < MAX_CERT_DEPTH; ++i)
-	{
-	  const struct cert_hash *ch = chs->ch[i];
-	  if (ch)
-	    msg (msglevel, "%d:%s", i, format_hex(ch->sha1_hash, SHA_DIGEST_LENGTH, 0, &gc));
-	}
-    }
-  gc_free (&gc);
-}
-#endif
-
 void
 cert_hash_free (struct cert_hash_set *chs)
 {
@@ -251,7 +233,8 @@ cert_hash_compare (const struct cert_hash_set *chs1, const struct cert_hash_set
 
 	  if (!ch1 && !ch2)
 	    continue;
-	  else if (ch1 && ch2 && !memcmp (ch1->sha1_hash, ch2->sha1_hash, SHA_DIGEST_LENGTH))
+	  else if (ch1 && ch2 && !memcmp (ch1->sha256_hash, ch2->sha256_hash,
+	      sizeof(ch1->sha256_hash)))
 	    continue;
 	  else
 	    return false;
@@ -278,7 +261,8 @@ cert_hash_copy (const struct cert_hash_set *chs)
 	  if (ch)
 	    {
 	      ALLOC_OBJ (dest->ch[i], struct cert_hash);
-	      memcpy (dest->ch[i]->sha1_hash, ch->sha1_hash, SHA_DIGEST_LENGTH);
+	      memcpy (dest->ch[i]->sha256_hash, ch->sha256_hash,
+		  sizeof(dest->ch[i]->sha256_hash));
 	    }
 	}
     }
@@ -416,13 +400,19 @@ verify_cert_set_env(struct env_set *es, openvpn_x509_cert_t *peer_cert, int cert
   setenv_str (es, envname, common_name);
 #endif
 
-  /* export X509 cert SHA1 fingerprint */
+  /* export X509 cert fingerprints */
   {
-    unsigned char *sha1_hash = x509_get_sha1_hash(peer_cert, &gc);
+    struct buffer sha1 = x509_get_sha1_fingerprint(peer_cert, &gc);
+    struct buffer sha256 = x509_get_sha256_fingerprint(peer_cert, &gc);
 
     openvpn_snprintf (envname, sizeof(envname), "tls_digest_%d", cert_depth);
-    setenv_str (es, envname, format_hex_ex(sha1_hash, SHA_DIGEST_LENGTH, 0, 1,
-					  ":", &gc));
+    setenv_str (es, envname,
+	format_hex_ex(BPTR(&sha1), BLEN(&sha1), 0, 1, ":", &gc));
+
+    openvpn_snprintf (envname, sizeof(envname), "tls_digest_sha256_%d",
+	cert_depth);
+    setenv_str (es, envname,
+	format_hex_ex(BPTR(&sha256), BLEN(&sha256), 0, 1, ":", &gc));
   }
 
   /* export serial number as environmental variable */
@@ -638,8 +628,8 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
   /* verify level 1 cert, i.e. the CA that signed our leaf cert */
   if (cert_depth == 1 && opt->verify_hash)
     {
-      unsigned char *sha1_hash = x509_get_sha1_hash(cert, &gc);
-      if (memcmp (sha1_hash, opt->verify_hash, SHA_DIGEST_LENGTH))
+      struct buffer sha1_hash = x509_get_sha1_fingerprint(cert, &gc);
+      if (memcmp (BPTR (&sha1_hash), opt->verify_hash, BLEN(&sha1_hash)))
       {
 	msg (D_TLS_ERRORS, "TLS Error: level-1 certificate hash verification failed");
 	goto cleanup;
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index f693b2a..e5b5950 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -55,7 +55,7 @@
 
 /** Structure containing the hash for a single certificate */
 struct cert_hash {
-  unsigned char sha1_hash[SHA_DIGEST_LENGTH]; /**< The SHA1 hash for a certificate */
+  unsigned char sha256_hash[256/8];
 };
 
 /** Structure containing the hashes for a full certificate chain */
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 9d2057b..91e6ec9 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -66,10 +66,10 @@ result_t verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int
  *
  * @param session	TLS Session associated with this tunnel
  * @param cert_depth	Depth of the current certificate
- * @param sha1_hash	Hash of the current certificate
+ * @param cert_hash	Hash of the current certificate
  */
 void cert_hash_remember (struct tls_session *session, const int cert_depth,
-    const unsigned char *sha1_hash);
+    const struct buffer *cert_hash);
 
 /*
  * Library-specific functions.
@@ -87,14 +87,27 @@ void cert_hash_remember (struct tls_session *session, const int cert_depth,
  */
 char *x509_get_subject (openvpn_x509_cert_t *cert, struct gc_arena *gc);
 
-/* Retrieve the certificate's SHA1 hash.
+/**
+ * Retrieve the certificate's SHA1 fingerprint.
  *
- * @param cert		Certificate to retrieve the hash from.
+ * @param cert		Certificate to retrieve the fingerprint from.
  * @param gc		Garbage collection arena to use when allocating string.
  *
- * @return 		a string containing the SHA1 hash of the certificate
+ * @return 		a string containing the certificate fingerprint
  */
-unsigned char *x509_get_sha1_hash (openvpn_x509_cert_t *cert, struct gc_arena *gc);
+struct buffer x509_get_sha1_fingerprint (openvpn_x509_cert_t *cert,
+    struct gc_arena *gc);
+
+/**
+ * Retrieve the certificate's SHA256 fingerprint.
+ *
+ * @param cert		Certificate to retrieve the fingerprint from.
+ * @param gc		Garbage collection arena to use when allocating string.
+ *
+ * @return 		a string containing the certificate fingerprint
+ */
+struct buffer x509_get_sha256_fingerprint (openvpn_x509_cert_t *cert,
+    struct gc_arena *gc);
 
 /*
  * Retrieve the certificate's username from the specified field.
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 9c4b51a..d018938 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -60,7 +60,8 @@ verify_callback (void *session_obj, mbedtls_x509_crt *cert, int cert_depth,
   session->verified = false;
 
   /* Remember certificate hash */
-  cert_hash_remember (session, cert_depth, x509_get_sha1_hash(cert, &gc));
+  struct buffer cert_fingerprint = x509_get_sha256_fingerprint (cert, &gc);
+  cert_hash_remember (session, cert_depth, &cert_fingerprint);
 
   /* did peer present cert which was signed by our root cert? */
   if (*flags != 0)
@@ -193,12 +194,29 @@ backend_x509_get_serial_hex (mbedtls_x509_crt *cert, struct gc_arena *gc)
   return buf;
 }
 
-unsigned char *
-x509_get_sha1_hash (mbedtls_x509_crt *cert, struct gc_arena *gc)
+static struct buffer
+x509_get_fingerprint (const mbedtls_md_info_t *md_info, mbedtls_x509_crt *cert,
+    struct gc_arena *gc)
 {
-  unsigned char *sha1_hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
-  mbedtls_sha1(cert->raw.p, cert->tbs.len, sha1_hash);
-  return sha1_hash;
+  const size_t md_size = mbedtls_md_get_size (md_info);
+  struct buffer fingerprint = alloc_buf_gc (md_size, gc);
+  mbedtls_md(md_info, cert->raw.p, cert->tbs.len, BPTR (&fingerprint));
+  ASSERT (buf_inc_len(&fingerprint, md_size));
+  return fingerprint;
+}
+
+struct buffer
+x509_get_sha1_fingerprint (mbedtls_x509_crt *cert, struct gc_arena *gc)
+{
+  return x509_get_fingerprint(mbedtls_md_info_from_type(MBEDTLS_MD_SHA1),
+      cert, gc);
+}
+
+struct buffer
+x509_get_sha256_fingerprint (mbedtls_x509_crt *cert, struct gc_arena *gc)
+{
+  return x509_get_fingerprint(mbedtls_md_info_from_type(MBEDTLS_MD_SHA256),
+      cert, gc);
 }
 
 char *
@@ -291,12 +309,20 @@ x509_setenv_track (const struct x509_track *xt, struct env_set *es,
     {
       if (depth == 0 || (xt->flags & XT_FULL_CHAIN))
 	{
-	  if (0 == strcmp(xt->name, "SHA1"))
+	  if (0 == strcmp(xt->name, "SHA1") || 0 == strcmp(xt->name, "SHA256"))
 	    {
-	      /* SHA1 fingerprint is not part of X509 structure */
-	      unsigned char *sha1_hash = x509_get_sha1_hash(cert, &gc);
-	      char *sha1_fingerprint = format_hex_ex(sha1_hash, SHA_DIGEST_LENGTH, 0, 1 | FHE_CAPS, ":", &gc);
-	      do_setenv_x509(es, xt->name, sha1_fingerprint, depth);
+	      /* Fingerprint is not part of X509 structure */
+	      struct buffer cert_hash;
+	      char *fingerprint;
+
+	      if (0 == strcmp(xt->name, "SHA1"))
+		cert_hash = x509_get_sha1_fingerprint(cert, &gc);
+	      else
+		cert_hash = x509_get_sha256_fingerprint(cert, &gc);
+
+	      fingerprint = format_hex_ex(BPTR(&cert_hash),
+		  BLEN(&cert_hash), 0, 1 | FHE_CAPS, ":", &gc);
+	      do_setenv_x509(es, xt->name, fingerprint, depth);
 	    }
 	  else
 	    {
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 5817a05..a4b9432 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -61,8 +61,8 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
   session = (struct tls_session *) SSL_get_ex_data (ssl, mydata_index);
   ASSERT (session);
 
-  cert_hash_remember (session, ctx->error_depth,
-      x509_get_sha1_hash(ctx->current_cert, &gc));
+  struct buffer cert_hash = x509_get_sha256_fingerprint(ctx->current_cert, &gc);
+  cert_hash_remember (session, ctx->error_depth, &cert_hash);
 
   /* did peer present cert which was signed by our root cert? */
   if (!preverify_ok)
@@ -248,11 +248,21 @@ backend_x509_get_serial_hex (openvpn_x509_cert_t *cert, struct gc_arena *gc)
   return format_hex_ex(asn1_i->data, asn1_i->length, 0, 1, ":", gc);
 }
 
-unsigned char *
-x509_get_sha1_hash (X509 *cert, struct gc_arena *gc)
+struct buffer
+x509_get_sha1_fingerprint (X509 *cert, struct gc_arena *gc)
 {
-  unsigned char *hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
-  memcpy(hash, cert->sha1_hash, SHA_DIGEST_LENGTH);
+  struct buffer hash = alloc_buf_gc(sizeof(cert->sha1_hash), gc);
+  memcpy(BPTR(&hash), cert->sha1_hash, sizeof(cert->sha1_hash));
+  ASSERT (buf_inc_len(&hash, sizeof (cert->sha1_hash)));
+  return hash;
+}
+
+struct buffer
+x509_get_sha256_fingerprint (X509 *cert, struct gc_arena *gc)
+{
+  struct buffer hash = alloc_buf_gc((EVP_sha256())->md_size, gc);
+  X509_digest(cert, EVP_sha256(), BPTR(&hash), NULL);
+  ASSERT (buf_inc_len(&hash, (EVP_sha256())->md_size));
   return hash;
 }
 
@@ -376,10 +386,19 @@ x509_setenv_track (const struct x509_track *xt, struct env_set *es, const int de
 	  switch (xt->nid)
 	    {
 	    case NID_sha1:
+	    case NID_sha256:
 	      {
-		char *sha1_fingerprint = format_hex_ex(x509->sha1_hash,
-                                 SHA_DIGEST_LENGTH, 0, 1 | FHE_CAPS, ":", &gc);
-		do_setenv_x509(es, xt->name, sha1_fingerprint, depth);
+		struct buffer fp_buf;
+		char *fp_str = NULL;
+
+		if (xt->nid == NID_sha1)
+		  fp_buf = x509_get_sha1_fingerprint(x509, &gc);
+		else
+		  fp_buf = x509_get_sha256_fingerprint(x509, &gc);
+
+		fp_str = format_hex_ex(BPTR(&fp_buf), BLEN(&fp_buf), 0,
+		    1 | FHE_CAPS, ":", &gc);
+		do_setenv_x509(es, xt->name, fp_str, depth);
 	      }
 	      break;
 	    default:
-- 
2.7.4


