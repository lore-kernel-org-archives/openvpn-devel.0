From: Antonio Quartulli <a@...2181...>
Date: Wed, 19 Oct 2016 14:22:31 +0800
Message-Id: <20161019062231.2845-4-a@...2181...>
In-Reply-To: <20161019062231.2845-1-a@...2181...>
References: <20161019062231.2845-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 3/3] openssl: implement crl-persist related
	functions
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
Cc: Antonio Quartulli <a@...2181...>

Implement the functions needed by the crl-persist logic when openssl
is enabled. Such functions are used in the ssl_verify module.

Note that the CRL file is stored in an adhoc data structure and no
openssl specific object is used. The data structure being used is a
sorted array or serials that can later be looked up in log(N) with
a binary search, thus guaranteeing a fast lookup operation.

Such data structure may be changed in the future with an optimized
openssl specific object.

Tests have been performed by using a CRL file having size 143MB.
Original delay upon client connection was around 5-8 seconds.
With this patch the delay gets close to 0.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/ssl_verify_openssl.c | 183 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index a4b9432..c5649ca 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -47,6 +47,9 @@
 #include <openssl/x509v3.h>
 #include <openssl/err.h>
 
+#define __STDC_FORMAT_MACROS
+#include <inttypes.h>
+
 int
 verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
 {
@@ -625,6 +628,186 @@ x509_write_pem(FILE *peercert_file, X509 *peercert)
   return SUCCESS;
 }
 
+static int
+x509_serial_cmp(const void *a, const void *b)
+{
+  const ASN1_INTEGER **serial1 = (const ASN1_INTEGER **)a;
+  const ASN1_INTEGER **serial2 = (const ASN1_INTEGER **)b;
+
+  ASSERT(serial1 && *serial1 && serial2 && *serial2);
+
+  return ASN1_INTEGER_cmp(*serial1, *serial2);
+}
+
+result_t
+x509_verify_crl_mem(const openvpn_x509_crl_t *crl, X509 *cert,
+		    const char *subject)
+{
+  result_t ret = FAILURE;
+  struct gc_arena gc = gc_new();
+  ASN1_INTEGER *serial;
+
+  ASSERT(crl && cert);
+
+  /* authorize the client if the CRL list is empty */
+  if (crl->num == 0)
+    {
+      ret = SUCCESS;
+      goto end;
+    }
+
+  /*
+   * make sure the issuer of the CRL and the certificate are the same,
+   * otherwise the check cannot be performed
+   */
+  if (X509_NAME_cmp(crl->issuer, X509_get_issuer_name(cert)) != 0)
+  {
+    msg(M_WARN, "CRL: CRL [in-memory] is from a different issuer than the issuer of certificate %s",
+	subject);
+    ret = SUCCESS;
+    goto end;
+  }
+
+  serial = X509_get_serialNumber(cert);
+  if (!serial)
+    {
+      msg(M_WARN, "CRL: can't extract serial from cert");
+      goto end;
+    }
+
+  /*
+   * perform binary search on sorted CRL array. The cmp function assumes that
+   * the arguments are all pointers to pointers, therefore the address of the
+   * "key" object has to be passed instead of the object itself.
+   */
+  if (bsearch(&serial, crl->buff, crl->num, sizeof(ASN1_INTEGER *),
+	      x509_serial_cmp))
+    {
+	    fprintf(stderr, "!\n");
+      msg(D_HANDSHAKE, "CRL CHECK FAILED: %s (serial %s) is REVOKED", subject,
+	  format_hex_ex(serial->data, serial->length, 0, 1, ":", &gc));
+      goto end;
+    }
+
+  /* serial not found in CRL: certificate is valid */
+  ret = SUCCESS;
+  msg(D_HANDSHAKE, "CRL CHECK OK: %s", subject);
+
+end:
+  gc_free(&gc);
+
+  return ret;
+}
+
+void
+x509_crl_free(openvpn_x509_crl_t *crl)
+{
+  int i;
+
+  ASSERT(crl);
+
+  for (i = 0; i < crl->num; i++)
+    ASN1_INTEGER_free(crl->buff[i]);
+
+  free(crl->buff);
+  X509_NAME_free(crl->issuer);
+  crl->buff = NULL;
+  crl->issuer = NULL;
+  crl->num = 0;
+}
+
+result_t
+x509_load_crl_mem(openvpn_x509_crl_t *crl, const char *crl_file)
+{
+  result_t ret = FAILURE;
+  X509_CRL *x509_crl = NULL;
+  X509_REVOKED *revoked;
+  X509_NAME *issuer;
+  BIO *in = NULL;
+  uint64_t num, i;
+
+  ASSERT(crl && crl_file);
+
+  msg(D_TLS_DEBUG_LOW, "CRL-persist: loading file: %s", crl_file);
+
+  /* free previously allocated data - useful in case or context update */
+  if (crl->buff)
+    x509_crl_free(crl);
+
+  in = BIO_new_file(crl_file, "r");
+  if (!in)
+    {
+      msg(M_WARN, "CRL: cannot read: %s", crl_file);
+      goto end;
+    }
+
+  x509_crl = PEM_read_bio_X509_CRL(in, NULL, NULL, NULL);
+  if (!x509_crl)
+    {
+      msg(M_WARN, "CRL: cannot read CRL from file %s", crl_file);
+      goto end;
+    }
+
+  crl->num = 0;
+  crl->buff = NULL;
+  crl->issuer = NULL;
+
+  issuer = X509_CRL_get_issuer(x509_crl);
+  if (issuer)
+    crl->issuer = X509_NAME_dup(issuer);
+
+  num = sk_X509_REVOKED_num(X509_CRL_get_REVOKED(x509_crl));
+  /* CRL is empty */
+  if (num == (uint64_t)-1)
+    {
+      ret = SUCCESS;
+      goto end;
+    }
+
+  crl->num = num;
+  crl->buff = malloc(sizeof(ASN1_INTEGER **) * num);
+  if (!crl->buff)
+    {
+      msg(M_WARN, "CRL: cannot allocate CRL buffer for file %s", crl_file);
+      goto end;
+    }
+
+  /* store each serial number in the buffer array as ASN1_INTEGER objects */
+  for (i = 0; i < num; i++)
+    {
+      revoked = sk_X509_REVOKED_value(X509_CRL_get_REVOKED(x509_crl), i);
+      crl->buff[i] = ASN1_INTEGER_dup(revoked->serialNumber);
+      if (!crl->buff[i])
+        {
+          msg(M_WARN, "CRL: cannot store CRL serial for file %s", crl_file);
+          goto err;
+        }
+    }
+
+  /* sort the array for fast lookup later */
+  qsort(crl->buff, crl->num, sizeof(ASN1_INTEGER *), x509_serial_cmp);
+  msg(D_TLS_DEBUG_LOW, "CRL-persist: loaded and sorted %" PRIu64 " serials",
+      crl->num);
+
+  ret = SUCCESS;
+  goto end;
+err:
+  /* rollback the for-loop and release all the allocated memory */
+  for (;i > 0; i--)
+    ASN1_INTEGER_free(crl->buff[i - 1]);
+
+  free(crl->buff);
+  X509_NAME_free(crl->issuer);
+
+end:
+  if (in)
+    BIO_free(in);
+  if (x509_crl)
+    X509_CRL_free(x509_crl);
+
+  return ret;
+}
+
 /*
  * check peer cert against CRL
  */
-- 
2.10.1


