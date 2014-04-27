From: Steffan Karger <steffan@...1856...>
Date: Sun, 27 Apr 2014 10:49:20 +0200
Message-Id: <1398588561-18964-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/2] Make serial env exporting consistent
	amongst OpenSSL and PolarSSL builds.
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

This changes the representation of the tls_serial_{n} environment variable
from hex to decimal for PolarSSL builds, to match OpenSSL build behaviour.

Because hex representation for serials makes sense too, and to ease
transition for PolarSSL users, added tls_serial_hex_{n} that exports the
serial in hex represenation for both crypto library backends.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 doc/openvpn.8                     |  6 ++++++
 src/openvpn/ssl_verify.c          |  5 +++++
 src/openvpn/ssl_verify_backend.h  | 19 +++++++++++++++++--
 src/openvpn/ssl_verify_openssl.c  |  8 ++++++++
 src/openvpn/ssl_verify_polarssl.c | 40 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index ae3a4e0..2f9ebdf 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -6102,6 +6102,12 @@ code should check that.
 See the contrib/OCSP_check/OCSP_check.sh script for an example.
 .\"*********************************************************
 .TP
+.B tls_serial_hex_{n}
+Like
+.B tls_serial_{n}\fR,
+but in hex form (e.g. "12:34:56:78:9A").
+.\"*********************************************************
+.TP
 .B tun_mtu
 The MTU of the TUN/TAP device.
 Set prior to
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 7a9a56e..2d10d15 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -435,6 +435,11 @@ verify_cert_set_env(struct env_set *es, openvpn_x509_cert_t *peer_cert, int cert
   openvpn_snprintf (envname, sizeof(envname), "tls_serial_%d", cert_depth);
   setenv_str (es, envname, serial);
 
+  /* export serial number in hex as environmental variable */
+  serial = backend_x509_get_serial_hex(peer_cert, &gc);
+  openvpn_snprintf (envname, sizeof(envname), "tls_serial_hex_%d", cert_depth);
+  setenv_str (es, envname, serial);
+
   gc_free(&gc);
 }
 
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index fa4369d..4e9ad60 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -113,18 +113,33 @@ result_t backend_x509_get_username (char *common_name, int cn_len,
     char * x509_username_field, openvpn_x509_cert_t *peer_cert);
 
 /*
- * Return the certificate's serial number.
+ * Return the certificate's serial number in decimal string representation.
  *
  * The serial number is returned as a string, since it might be a bignum.
  *
  * @param cert		Certificate to retrieve the serial number from.
  * @param gc		Garbage collection arena to use when allocating string.
  *
- * @return 		The certificate's serial number.
+ * @return 		String representation of the certificate's serial number
+ * 			in decimal notation, or NULL on error.
  */
 char *backend_x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc);
 
 /*
+ * Return the certificate's serial number in hex string representation.
+ *
+ * The serial number is returned as a string, since it might be a bignum.
+ *
+ * @param cert		Certificate to retrieve the serial number from.
+ * @param gc		Garbage collection arena to use when allocating string.
+ *
+ * @return 		String representation of the certificate's serial number
+ * 			in hex notation, or NULL on error.
+ */
+char *backend_x509_get_serial_hex (openvpn_x509_cert_t *cert,
+    struct gc_arena *gc);
+
+/*
  * Save X509 fields to environment, using the naming convention:
  *
  * X509_{cert_depth}_{name}={value}
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 0f571d9..98a888a 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -238,6 +238,14 @@ backend_x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
   return serial;
 }
 
+char *
+backend_x509_get_serial_hex (openvpn_x509_cert_t *cert, struct gc_arena *gc)
+{
+  const ASN1_INTEGER *asn1_i = X509_get_serialNumber(cert);
+
+  return format_hex_ex(asn1_i->data, asn1_i->length, 0, 1, ":", gc);
+}
+
 unsigned char *
 x509_get_sha1_hash (X509 *cert, struct gc_arena *gc)
 {
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index 1b2990c..1d622cc 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -38,6 +38,8 @@
 #if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_POLARSSL)
 
 #include "ssl_verify.h"
+#include <polarssl/error.h>
+#include <polarssl/bignum.h>
 #include <polarssl/oid.h>
 #include <polarssl/sha1.h>
 
@@ -127,6 +129,44 @@ char *
 backend_x509_get_serial (x509_crt *cert, struct gc_arena *gc)
 {
   char *buf = NULL;
+  size_t buflen = 0;
+  mpi serial_mpi = { 0 };
+  int retval = 0;
+
+  /* Transform asn1 integer serial into PolarSSL MPI */
+  mpi_init(&serial_mpi);
+  retval = mpi_read_binary(&serial_mpi, cert->serial.p, cert->serial.len);
+  if (retval < 0)
+    {
+      char errbuf[128];
+      polarssl_strerror(retval, errbuf, sizeof(errbuf));
+
+      msg(M_WARN, "Failed to retrieve serial from certificate: %s.", errbuf);
+      return NULL;
+    }
+
+  /* Determine decimal representation length, allocate buffer */
+  mpi_write_string(&serial_mpi, 10, buf, &buflen);
+  buf = gc_malloc(buflen, true, gc);
+
+  /* Write MPI serial as decimal string into buffer */
+  retval = mpi_write_string(&serial_mpi, 10, buf, &buflen);
+  if (retval < 0)
+    {
+      char errbuf[128];
+      polarssl_strerror(retval, errbuf, sizeof(errbuf));
+
+      msg(M_WARN, "Failed to write serial to string: %s.", errbuf);
+      return NULL;
+    }
+
+  return buf;
+}
+
+char *
+backend_x509_get_serial_hex (x509_crt *cert, struct gc_arena *gc)
+{
+  char *buf = NULL;
   size_t len = cert->serial.len * 3 + 1;
 
   buf = gc_malloc(len, true, gc);
-- 
1.8.3.2


