Message-ID: <535EB49E.5090809@...1856...>
Date: Mon, 28 Apr 2014 22:05:50 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1398588561-18964-1-git-send-email-steffan@...1856...>
	<201404271322.s3RDM5qu017603@...1295...>
In-Reply-To: <201404271322.s3RDM5qu017603@...1295...>
Content-Type: multipart/mixed; boundary="------------060107010707080904020008"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Make serial env exporting
 consistent amongst OpenSSL and PolarSSL builds.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060107010707080904020008
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

On 27-04-14 15:22, Gert Doering wrote:
> Your patch has been applied to the master branch ONLY, as it doesn't
> work with PolarSSL 1.2 (no "x509_crt" type there) - so 2.3.x still has
> inconsistency here.

Right, different PolarSSL API. Attached a reworked patch for 2.3. Same
functionality, slightly different API calls.

-Steffan

--------------060107010707080904020008
Content-Type: text/x-patch;
	name="0001-Make-serial-env-exporting-consistent-amongst-OpenSSL.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Make-serial-env-exporting-consistent-amongst-OpenSSL.pa";
	filename*1="tch"

From 52d5f5a76dc70e20da740acd347cbdaab40b60df Mon Sep 17 00:00:00 2001
From: Steffan Karger <steffan@...1856...>
Date: Mon, 28 Apr 2014 21:50:22 +0200
Subject: [PATCH] Make serial env exporting consistent amongst OpenSSL and
 PolarSSL builds.

This changes the representation of the tls_serial_{n} environment variable
from hex to decimal for PolarSSL builds, to match OpenSSL build behaviour.

Because hex representation for serials makes sense too, and to ease
transition for PolarSSL users, added tls_serial_hex_{n} that exports the
serial in hex represenation for both crypto library backends.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 doc/openvpn.8                     |  6 ++++++
 src/openvpn/ssl_verify.c          |  9 +++++++--
 src/openvpn/ssl_verify_backend.h  | 21 +++++++++++++++++---
 src/openvpn/ssl_verify_openssl.c  | 10 +++++++++-
 src/openvpn/ssl_verify_polarssl.c | 42 ++++++++++++++++++++++++++++++++++++++-
 5 files changed, 81 insertions(+), 7 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 7a33f8a..585751b 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -6048,6 +6048,12 @@ code should check that.
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
index 0670f2a..c90c2c3 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -435,10 +435,15 @@ verify_cert_set_env(struct env_set *es, openvpn_x509_cert_t *peer_cert, int cert
   }
 
   /* export serial number as environmental variable */
-  serial = x509_get_serial(peer_cert, &gc);
+  serial = backend_x509_get_serial(peer_cert, &gc);
   openvpn_snprintf (envname, sizeof(envname), "tls_serial_%d", cert_depth);
   setenv_str (es, envname, serial);
 
+  /* export serial number in hex as environmental variable */
+  serial = backend_x509_get_serial_hex(peer_cert, &gc);
+  openvpn_snprintf (envname, sizeof(envname), "tls_serial_hex_%d", cert_depth);
+  setenv_str (es, envname, serial);
+
   gc_free(&gc);
 }
 
@@ -562,7 +567,7 @@ verify_check_crl_dir(const char *crl_dir, openvpn_x509_cert_t *cert)
   int fd = -1;
   struct gc_arena gc = gc_new();
 
-  char *serial = x509_get_serial(cert, &gc);
+  char *serial = backend_x509_get_serial(cert, &gc);
 
   if (!openvpn_snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, OS_SPECIFIC_DIRSEP, serial))
     {
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 1658cc0..6f118c9 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -113,16 +113,31 @@ result_t x509_get_username (char *common_name, int cn_len,
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
-char *x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc);
+char *backend_x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc);
+
+/*
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
 
 /*
  * Save X509 fields to environment, using the naming convention:
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 91a42b2..19982ae 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -220,7 +220,7 @@ x509_get_username (char *common_name, int cn_len,
 }
 
 char *
-x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
+backend_x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
 {
   ASN1_INTEGER *asn1_i;
   BIGNUM *bignum;
@@ -238,6 +238,14 @@ x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
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
index 5db4f02..3fd861c 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -38,6 +38,8 @@
 #if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_POLARSSL)
 
 #include "ssl_verify.h"
+#include <polarssl/error.h>
+#include <polarssl/bignum.h>
 #include <polarssl/sha1.h>
 
 #define MAX_SUBJECT_LENGTH 256
@@ -123,11 +125,49 @@ x509_get_username (char *cn, int cn_len,
 }
 
 char *
-x509_get_serial (x509_cert *cert, struct gc_arena *gc)
+backend_x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
 {
   int ret = 0;
   int i = 0;
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
+      error_strerror(retval, errbuf, sizeof(errbuf));
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
+      error_strerror(retval, errbuf, sizeof(errbuf));
+
+      msg(M_WARN, "Failed to write serial to string: %s.", errbuf);
+      return NULL;
+    }
+
+  return buf;
+}
+
+char *
+backend_x509_get_serial_hex (openvpn_x509_cert_t *cert, struct gc_arena *gc)
+{
+  char *buf = NULL;
   size_t len = cert->serial.len * 3 + 1;
 
   buf = gc_malloc(len, true, gc);
-- 
1.9.1


--------------060107010707080904020008--

