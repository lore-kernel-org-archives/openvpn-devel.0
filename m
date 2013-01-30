Date: Wed, 30 Jan 2013 13:07:17 +0000
From: Emmanuel Dreyfus <manu@...1031...>
Message-ID: <20130130130717.GB19096@...1805...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
Subject: [Openvpn-devel] [PATCH] x509 validity for tls-verify
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

Please consider the attached patch that makes x509 xertificate validity
(notBeofre and notAfter) available in environement for the tls-verify
script.

I use it to monitor OpenVPN certificate expirations in Nagios. I can 
share the Nagios bits with whoever is interested.

-- 
Emmanuel Dreyfus
manu@...1031...

--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn-x509-validity.patch"

--- src/openvpn/ssl_verify.c.orig	2013-01-28 16:07:44.000000000 +0100
+++ src/openvpn/ssl_verify.c	2013-01-30 09:40:32.000000000 +0100
@@ -399,8 +399,10 @@
     )
 {
   char envname[64];
   char *serial = NULL;
+  char *notBefore = NULL;
+  char *notAfter = NULL;
   struct gc_arena gc = gc_new ();
 
   /* Save X509 fields in environment */
 #ifdef ENABLE_X509_TRACK
@@ -435,8 +437,19 @@
   serial = x509_get_serial(peer_cert, &gc);
   openvpn_snprintf (envname, sizeof(envname), "tls_serial_%d", cert_depth);
   setenv_str (es, envname, serial);
 
+  /* export Validity */
+  if ((notBefore = x509_get_validity_notBefore(peer_cert, &gc)) != NULL) {
+    openvpn_snprintf (envname, sizeof(envname), "tls_notbefore_%d", cert_depth);
+    setenv_str (es, envname, notBefore);
+  }
+
+  if ((notAfter = x509_get_validity_notAfter(peer_cert, &gc)) != NULL) {
+    openvpn_snprintf (envname, sizeof(envname), "tls_notafter_%d", cert_depth);
+    setenv_str (es, envname, notAfter);
+  }
+
   gc_free(&gc);
 }
 
 /*
--- src/openvpn/ssl_verify_backend.h.orig	2013-01-30 11:34:30.000000000 +0100
+++ src/openvpn/ssl_verify_backend.h	2013-01-30 11:38:06.000000000 +0100
@@ -124,8 +124,36 @@
  */
 char *x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc);
 
 /*
+ * Return the certificate's notBefore validity
+ *
+ * The notBefore validity number is returned as a string with 
+ * format YYmmddHHMMSSZ
+ *
+ * @param cert		Certificate to retrieve the notBefore validity from.
+ * @param gc		Garbage collection arena to use when allocating string.
+ *
+ * @return 		The certificate's notBefore validity
+ */
+char * x509_get_validity_notBefore (openvpn_x509_cert_t *cert,
+    struct gc_arena *gc);
+
+/*
+ * Return the certificate's notAfter validity
+ *
+ * The notAfter validity number is returned as a string with 
+ * format YYmmddHHMMSSZ
+ *
+ * @param cert		Certificate to retrieve the notAfter validity from.
+ * @param gc		Garbage collection arena to use when allocating string.
+ *
+ * @return 		The certificate's notAfter validity
+ */
+char * x509_get_validity_notAfter (openvpn_x509_cert_t *cert,
+    struct gc_arena *gc);
+
+/*
  * Save X509 fields to environment, using the naming convention:
  *
  * X509_{cert_depth}_{name}={value}
  *
--- src/openvpn/ssl_verify_openssl.c.orig	2013-01-28 16:07:44.000000000 +0100
+++ src/openvpn/ssl_verify_openssl.c	2013-01-30 09:32:29.000000000 +0100
@@ -237,8 +237,32 @@
 
   return serial;
 }
 
+char *
+x509_get_validity_notBefore (openvpn_x509_cert_t *cert, struct gc_arena *gc)
+{
+  unsigned char *buf;
+
+  if ((buf = ASN1_STRING_data(X509_get_notBefore(cert))) == NULL)
+    return NULL;
+
+  return string_alloc(buf, gc);
+}
+
+
+char *
+x509_get_validity_notAfter (openvpn_x509_cert_t *cert, struct gc_arena *gc)
+{
+  unsigned char *buf;
+
+  if ((buf = ASN1_STRING_data(X509_get_notAfter(cert))) == NULL)
+    return NULL;
+
+  return string_alloc(buf, gc);
+}
+
+
 unsigned char *
 x509_get_sha1_hash (X509 *cert, struct gc_arena *gc)
 {
   char *hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
--- src/openvpn/ssl_verify_polarssl.c.orig	2013-01-30 09:36:41.000000000 +0100
+++ src/openvpn/ssl_verify_polarssl.c	2013-01-30 09:37:42.000000000 +0100
@@ -140,8 +140,21 @@
 
   return buf;
 }
 
+char *
+x509_get_validity_notBefore (openvpn_x509_cert_t *cert, struct gc_arena *gc)
+{
+  return NULL;
+}
+
+
+char *
+x509_get_validity_notAfter (openvpn_x509_cert_t *cert, struct gc_arena *gc)
+{
+  return NULL;
+}
+
 unsigned char *
 x509_get_sha1_hash (x509_cert *cert, struct gc_arena *gc)
 {
   unsigned char *sha1_hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);

--qMm9M+Fa2AknHoGS--

