From: Adriaan de Jong <dejong@...1435...>
Date: Tue, 14 Feb 2012 11:11:25 +0100
Message-ID: <1329214286-9179-3-git-send-email-dejong@...1435...>
In-Reply-To: <1329214286-9179-1-git-send-email-dejong@...1435...>
References: <1329214286-9179-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] Migrated x509_get_serial to use the
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
 ssl_verify.c          |   28 ++++++++++++++--------------
 ssl_verify_backend.h  |   11 ++---------
 ssl_verify_openssl.c  |   17 +++++++----------
 ssl_verify_polarssl.c |   17 +++--------------
 4 files changed, 26 insertions(+), 47 deletions(-)

diff --git a/ssl_verify.c b/ssl_verify.c
index 06585d8..352118a 100644
--- a/ssl_verify.c
+++ b/ssl_verify.c
@@ -377,6 +377,8 @@ verify_cert_set_env(struct env_set *es, x509_cert_t *peer_cert, int cert_depth,
     )
 {
   char envname[64];
+  char *serial = NULL;
+  struct gc_arena gc = gc_new ();
 
   /* Save X509 fields in environment */
 #ifdef ENABLE_X509_TRACK
@@ -399,25 +401,21 @@ verify_cert_set_env(struct env_set *es, x509_cert_t *peer_cert, int cert_depth,
 #ifdef ENABLE_EUREPHIA
   /* export X509 cert SHA1 fingerprint */
   {
-    struct gc_arena gc = gc_new ();
     unsigned char *sha1_hash = x509_get_sha1_hash(peer_cert);
 
     openvpn_snprintf (envname, sizeof(envname), "tls_digest_%d", cert_depth);
     setenv_str (es, envname, format_hex_ex(sha1_hash, SHA_DIGEST_LENGTH, 0, 1,
 					  ":", &gc));
     x509_free_sha1_hash(sha1_hash);
-    gc_free(&gc);
   }
 #endif
 
-  /* export serial number as environmental variable,
-     use bignum in case serial number is large */
-  {
-    char *serial = x509_get_serial(peer_cert);
-    openvpn_snprintf (envname, sizeof(envname), "tls_serial_%d", cert_depth);
-    setenv_str (es, envname, serial);
-    x509_free_serial(serial);
-  }
+  /* export serial number as environmental variable */
+  serial = x509_get_serial(peer_cert, &gc);
+  openvpn_snprintf (envname, sizeof(envname), "tls_serial_%d", cert_depth);
+  setenv_str (es, envname, serial);
+
+  gc_free(&gc);
 }
 
 /*
@@ -537,24 +535,26 @@ verify_check_crl_dir(const char *crl_dir, x509_cert_t *cert)
 {
   char fn[256];
   int fd;
-  char *serial = x509_get_serial(cert);
+  struct gc_arena gc = gc_new();
+
+  char *serial = x509_get_serial(cert, &gc);
 
   if (!openvpn_snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, OS_SPECIFIC_DIRSEP, serial))
     {
       msg (D_HANDSHAKE, "VERIFY CRL: filename overflow");
-      x509_free_serial(serial);
+      gc_free(&gc);
       return FAILURE;
     }
   fd = openvpn_open (fn, O_RDONLY, 0);
   if (fd >= 0)
     {
       msg (D_HANDSHAKE, "VERIFY CRL: certificate serial number %s is revoked", serial);
-      x509_free_serial(serial);
       close(fd);
+      gc_free(&gc);
       return FAILURE;
     }
 
-  x509_free_serial(serial);
+  gc_free(&gc);
 
   return SUCCESS;
 }
diff --git a/ssl_verify_backend.h b/ssl_verify_backend.h
index a1fd682..5c69b11 100644
--- a/ssl_verify_backend.h
+++ b/ssl_verify_backend.h
@@ -125,20 +125,13 @@ result_t x509_get_username (char *common_name, int cn_len,
  * Return the certificate's serial number.
  *
  * The serial number is returned as a string, since it might be a bignum.
- * The returned string must be freed with \c verify_free_serial()
  *
  * @param cert		Certificate to retrieve the serial number from.
+ * @param gc		Garbage collection arena to use when allocating string.
  *
  * @return 		The certificate's serial number.
  */
-char *x509_get_serial (x509_cert_t *cert);
-
-/*
- * Free a serial number string as returned by \c verify_get_serial()
- *
- * @param serial	The string to be freed.
- */
-void x509_free_serial (char *serial);
+char *x509_get_serial (x509_cert_t *cert, struct gc_arena *gc);
 
 /*
  * Save X509 fields to environment, using the naming convention:
diff --git a/ssl_verify_openssl.c b/ssl_verify_openssl.c
index 473835e..6d31bb3 100644
--- a/ssl_verify_openssl.c
+++ b/ssl_verify_openssl.c
@@ -213,25 +213,22 @@ x509_get_username (char *common_name, int cn_len,
 }
 
 char *
-x509_get_serial (x509_cert_t *cert)
+x509_get_serial (x509_cert_t *cert, struct gc_arena *gc)
 {
   ASN1_INTEGER *asn1_i;
   BIGNUM *bignum;
-  char *serial;
+  char *openssl_serial, *serial;
 
   asn1_i = X509_get_serialNumber(cert);
   bignum = ASN1_INTEGER_to_BN(asn1_i, NULL);
-  serial = BN_bn2dec(bignum);
+  openssl_serial = BN_bn2dec(bignum);
+
+  serial = string_alloc(openssl_serial, gc);
 
   BN_free(bignum);
-  return serial;
-}
+  OPENSSL_free(openssl_serial);
 
-void
-x509_free_serial (char *serial)
-{
-  if (serial)
-    OPENSSL_free(serial);
+  return serial;
 }
 
 unsigned char *
diff --git a/ssl_verify_polarssl.c b/ssl_verify_polarssl.c
index c4afb24..065b30d 100644
--- a/ssl_verify_polarssl.c
+++ b/ssl_verify_polarssl.c
@@ -119,32 +119,21 @@ x509_get_username (char *cn, int cn_len,
 }
 
 char *
-x509_get_serial (x509_cert *cert)
+x509_get_serial (x509_cert *cert, struct gc_arena *gc)
 {
   int ret = 0;
   int i = 0;
   char *buf = NULL;
   size_t len = cert->serial.len * 3;
 
-  buf = malloc(len);
-  ASSERT(buf);
+  buf = gc_malloc(len, true, gc);
 
   if(x509parse_serial_gets(buf, len-1, &cert->serial) < 0)
-    {
-      free(buf);
-      buf = NULL;
-    }
+    buf = NULL;
 
   return buf;
 }
 
-void
-x509_free_serial (char *serial)
-{
-  if (serial)
-    free(serial);
-}
-
 unsigned char *
 x509_get_sha1_hash (x509_cert *cert)
 {
-- 
1.7.5.4


