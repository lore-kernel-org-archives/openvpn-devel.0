From: Adriaan de Jong <dejong@...1435...>
Date: Tue, 14 Feb 2012 11:11:24 +0100
Message-ID: <1329214286-9179-2-git-send-email-dejong@...1435...>
In-Reply-To: <1329214286-9179-1-git-send-email-dejong@...1435...>
References: <1329214286-9179-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Migrated x509_get_subject to use of the
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

This also cleans up a messy call in pkcs11.c to _openssl_get_subject, as discussed at FOSDEM.

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 pkcs11.c              |   10 ++++++----
 pkcs11_backend.h      |    8 +++-----
 pkcs11_openssl.c      |   16 +++++++---------
 pkcs11_polarssl.c     |   12 +++++++-----
 ssl_verify.c          |    7 ++++---
 ssl_verify_backend.h  |   11 ++---------
 ssl_verify_openssl.c  |   35 +++++++++++------------------------
 ssl_verify_polarssl.c |   26 +++++++++++---------------
 8 files changed, 51 insertions(+), 74 deletions(-)

diff --git a/pkcs11.c b/pkcs11.c
index 7c0b90a..3fa5197 100644
--- a/pkcs11.c
+++ b/pkcs11.c
@@ -827,7 +827,8 @@ show_pkcs11_ids (
 	);
 	for (current = user_certificates;current != NULL; current = current->next) {
 		pkcs11h_certificate_t certificate = NULL;
-		char dn[1024] = {0};
+		struct gc_arena gc = gc_new();
+		char *dn = NULL;
 		char serial[1024] = {0};
 		char *ser = NULL;
 		size_t ser_len = 0;
@@ -876,10 +877,9 @@ show_pkcs11_ids (
 		}
 
 		if (
-		      (pkcs11_certificate_dn (
+		      (dn = pkcs11_certificate_dn (
 				certificate,
-				dn,
-				sizeof(dn)
+				&gc
 		      ))
 		) {
 			goto cleanup1;
@@ -920,6 +920,8 @@ show_pkcs11_ids (
 			free (ser);
 			ser = NULL;
 		}
+
+		gc_free (&gc);
 	}
 
 cleanup:
diff --git a/pkcs11_backend.h b/pkcs11_backend.h
index 6b5ad31..7b7ec45 100644
--- a/pkcs11_backend.h
+++ b/pkcs11_backend.h
@@ -42,13 +42,11 @@
  * Retrieve PKCS #11 Certificate's DN in a printable format.
  *
  * @param certificate 	The PKCS #11 helper certificate object
- * @param dn		Buffer that the certificate subject DN will be placed in.
- * @param dn_len	Size of said buffer.
+ * @param gc		Garbage collection pool to allocate memory in
  *
- * @return 		1 on failure, 0 on success
+ * @return 		Certificate's DN on success, NULL on failure
  */
-int pkcs11_certificate_dn (pkcs11h_certificate_t certificate, char *dn,
-    size_t dn_len);
+char * pkcs11_certificate_dn (pkcs11h_certificate_t certificate, struct gc_arena *gc);
 
 /**
  * Retrieve PKCS #11 Certificate's serial number in a printable format.
diff --git a/pkcs11_openssl.c b/pkcs11_openssl.c
index aa1eccc..797772a 100644
--- a/pkcs11_openssl.c
+++ b/pkcs11_openssl.c
@@ -33,6 +33,7 @@
 
 #include "errlevel.h"
 #include "pkcs11_backend.h"
+#include "ssl_verify.h"
 #include <pkcs11-helper-1.0/pkcs11h-openssl.h>
 
 int
@@ -115,23 +116,20 @@ cleanup:
   return ret;
 }
 
-int
-pkcs11_certificate_dn (pkcs11h_certificate_t certificate, char *dn,
-    size_t dn_len)
+char *
+pkcs11_certificate_dn (pkcs11h_certificate_t certificate, struct gc_arena *gc)
 {
   X509 *x509 = NULL;
-  int ret = 1;
+
+  char *dn = NULL;
 
   if ((x509 = pkcs11h_openssl_getX509 (certificate)) == NULL)
     {
       msg (M_FATAL, "PKCS#11: Cannot get X509");
-      ret = 1;
       goto cleanup;
     }
 
-  _openssl_get_subject (x509, dn, dn_len);
-
-  ret = 0;
+  dn = x509_get_subject (x509, gc);
 
 cleanup:
   if (x509 != NULL)
@@ -140,7 +138,7 @@ cleanup:
       x509 = NULL;
     }
 
-  return ret;
+  return dn;
 }
 
 int
diff --git a/pkcs11_polarssl.c b/pkcs11_polarssl.c
index 0f9daab..2c8ced6 100644
--- a/pkcs11_polarssl.c
+++ b/pkcs11_polarssl.c
@@ -66,11 +66,11 @@ cleanup:
   return ret;
 }
 
-int
-pkcs11_certificate_dn (pkcs11h_certificate_t cert, char *dn,
-    size_t dn_len)
+char *
+pkcs11_certificate_dn (pkcs11h_certificate_t cert, struct gc_arena *gc)
 {
   int ret = 1;
+  char dn[1024] = {0};
 
   x509_cert polar_cert = {0};
 
@@ -79,7 +79,7 @@ pkcs11_certificate_dn (pkcs11h_certificate_t cert, char *dn,
       goto cleanup;
   }
 
-  if (-1 == x509parse_dn_gets (dn, dn_len, &polar_cert.subject)) {
+  if (-1 == x509parse_dn_gets (dn, sizeof(dn), &polar_cert.subject)) {
       msg (M_FATAL, "PKCS#11: PolarSSL cannot parse subject");
       goto cleanup;
   }
@@ -89,7 +89,9 @@ pkcs11_certificate_dn (pkcs11h_certificate_t cert, char *dn,
 cleanup:
   x509_free(&polar_cert);
 
-  return ret;
+  if (ret == 0)
+    return string_alloc(dn, gc);
+  return NULL;
 }
 
 int
diff --git a/ssl_verify.c b/ssl_verify.c
index a7b361f..06585d8 100644
--- a/ssl_verify.c
+++ b/ssl_verify.c
@@ -565,6 +565,7 @@ verify_cert(struct tls_session *session, x509_cert_t *cert, int cert_depth)
   char *subject = NULL;
   char common_name[TLS_USERNAME_LEN] = {0};
   const struct tls_options *opt;
+  struct gc_arena gc = gc_new();
 
   opt = session->opt;
   ASSERT (opt);
@@ -572,7 +573,7 @@ verify_cert(struct tls_session *session, x509_cert_t *cert, int cert_depth)
   session->verified = false;
 
   /* get the X509 name */
-  subject = x509_get_subject(cert);
+  subject = x509_get_subject(cert, &gc);
   if (!subject)
     {
 	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, could not extract X509 "
@@ -670,13 +671,13 @@ verify_cert(struct tls_session *session, x509_cert_t *cert, int cert_depth)
   msg (D_HANDSHAKE, "VERIFY OK: depth=%d, %s", cert_depth, subject);
   session->verified = true;
 
-  x509_free_subject (subject);
+  gc_free(&gc);
   return SUCCESS;
 
  err:
   tls_clear_error();
   session->verified = false;
-  x509_free_subject (subject);
+  gc_free(&gc);
   return FAILURE;
 }
 
diff --git a/ssl_verify_backend.h b/ssl_verify_backend.h
index 2ba3723..a1fd682 100644
--- a/ssl_verify_backend.h
+++ b/ssl_verify_backend.h
@@ -80,20 +80,13 @@ void cert_hash_remember (struct tls_session *session, const int cert_depth,
 /*
  * Retrieve certificate's subject name.
  *
- * The returned string must be freed with \c verify_free_subject()
- *
  * @param cert		Certificate to retrieve the subject from.
+ * @param gc		Garbage collection arena to use when allocating string.
  *
  * @return 		a string containing the subject
  */
-char *x509_get_subject (x509_cert_t *cert);
+char *x509_get_subject (x509_cert_t *cert, struct gc_arena *gc);
 
-/*
- * Free a subject string as returned by \c verify_get_subject()
- *
- * @param subject	The subject to be freed.
- */
-void x509_free_subject (char *subject);
 
 /* Retrieve the certificate's SHA1 hash.
  *
diff --git a/ssl_verify_openssl.c b/ssl_verify_openssl.c
index 200a570..473835e 100644
--- a/ssl_verify_openssl.c
+++ b/ssl_verify_openssl.c
@@ -42,6 +42,7 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
 {
   struct tls_session *session;
   SSL *ssl;
+  struct gc_arena gc = gc_new();
   unsigned char *sha1_hash = NULL;
 
   /* get the tls_session pointer */
@@ -58,7 +59,7 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
   if (!preverify_ok)
     {
       /* get the X509 name */
-      char *subject = x509_get_subject(ctx->current_cert);
+      char *subject = x509_get_subject(ctx->current_cert, &gc);
 
       if (subject)
 	{
@@ -67,16 +68,18 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
 	      ctx->error_depth,
 	      X509_verify_cert_error_string (ctx->error),
 	      subject);
-	  x509_free_subject(subject);
 	}
 
       ERR_clear_error();
 
+      gc_free(&gc);
       session->verified = false;
 
       return 0;
     }
 
+  gc_free(&gc);
+
   if (SUCCESS == verify_cert(session, ctx->current_cert, ctx->error_depth))
     return 1;
   return 0;
@@ -247,12 +250,12 @@ x509_free_sha1_hash (unsigned char *hash)
 }
 
 char *
-_openssl_get_subject (X509 *cert, char *buf, int size)
+x509_get_subject (X509 *cert, struct gc_arena *gc)
 {
   BIO *subject_bio = NULL;
   BUF_MEM *subject_mem;
-  char *subject = buf;
-  int maxlen = size;
+  char *subject = NULL;
+  int maxlen = 0;
 
   subject_bio = BIO_new (BIO_s_mem ());
   if (subject_bio == NULL)
@@ -266,12 +269,9 @@ _openssl_get_subject (X509 *cert, char *buf, int size)
     goto err;
 
   BIO_get_mem_ptr (subject_bio, &subject_mem);
-  if (subject == NULL)
-    {
-      maxlen = subject_mem->length + 1;
-      subject = malloc (maxlen);
-      check_malloc_return (subject);
-    }
+
+  maxlen = subject_mem->length + 1;
+  subject = gc_malloc (maxlen, false, gc);
 
   memcpy (subject, subject_mem->data, maxlen);
   subject[maxlen - 1] = '\0';
@@ -283,19 +283,6 @@ err:
   return subject;
 }
 
-char *
-x509_get_subject (X509 *cert)
-{
-  return _openssl_get_subject (cert, NULL, 0);
-}
-
-void
-x509_free_subject (char *subject)
-{
-  if (subject)
-    free(subject);
-}
-
 
 #ifdef ENABLE_X509_TRACK
 
diff --git a/ssl_verify_polarssl.c b/ssl_verify_polarssl.c
index 699eb47..c4afb24 100644
--- a/ssl_verify_polarssl.c
+++ b/ssl_verify_polarssl.c
@@ -41,6 +41,7 @@ verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
     int preverify_ok)
 {
   struct tls_session *session = (struct tls_session *) session_obj;
+  struct gc_arena gc = gc_new();
   unsigned char *sha1_hash = NULL;
 
   ASSERT (cert);
@@ -56,21 +57,23 @@ verify_callback (void *session_obj, x509_cert *cert, int cert_depth,
   /* did peer present cert which was signed by our root cert? */
   if (!preverify_ok)
     {
-      char subject[MAX_SUBJECT_LENGTH] = {0};
+      char *subject = x509_get_subject(cert, &gc);
 
-      /* get the X509 name */
-      if (x509parse_dn_gets( subject, MAX_SUBJECT_LENGTH, &cert->subject ) < 0)
-	  msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, could not extract X509 "
-	      "subject string from certificate", cert_depth);
-      else
+      if (subject)
 	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, %s", cert_depth, subject);
+      else
+	msg (D_TLS_ERRORS, "VERIFY ERROR: depth=%d, could not extract X509 "
+	      "subject string from certificate", cert_depth);
 
+      gc_free(&gc);
       return 1;
     }
 
   /*
    * PolarSSL expects 1 on failure, 0 on success
    */
+  gc_free(&gc);
+
   if (SUCCESS == verify_cert(session, cert, cert_depth))
     return 0;
   return 1;
@@ -158,7 +161,7 @@ x509_free_sha1_hash (unsigned char *hash)
 }
 
 char *
-x509_get_subject(x509_cert *cert)
+x509_get_subject(x509_cert *cert, struct gc_arena *gc)
 {
   char tmp_subject[MAX_SUBJECT_LENGTH] = {0};
   char *subject = NULL;
@@ -169,19 +172,12 @@ x509_get_subject(x509_cert *cert)
   if (ret > 0)
     {
       /* Allocate the required space for the subject */
-      subject = malloc(ret + 1);
-      strncpy(subject, tmp_subject, ret+1);
+      subject = string_alloc(tmp_subject, gc);
     }
 
   return subject;
 }
 
-void
-x509_free_subject (char *subject)
-{
-  if (subject)
-    free(subject);
-}
 
 /*
  * Save X509 fields to environment, using the naming convention:
-- 
1.7.5.4


