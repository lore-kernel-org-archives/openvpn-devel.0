From: Antonio Quartulli <a@...2181...>
Date: Wed, 19 Oct 2016 14:22:30 +0800
Message-Id: <20161019062231.2845-3-a@...2181...>
In-Reply-To: <20161019062231.2845-1-a@...2181...>
References: <20161019062231.2845-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 2/3] mbedtls: implement crl-persist related
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

Implement the functions needed by the crl-persist logic and
used by the ssl_verify module.

No special data structure has been used to store the CRL as
mbedtls already provides its own object and helper functions.

Tests have been performed by using a CRL file having size 143MB.
Original delay upon client connection was around 4-6 seconds.
With this patch the delay gets close to 0.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/ssl_verify_mbedtls.c | 102 +++++++++++++++++++++++++++++++--------
 1 file changed, 83 insertions(+), 19 deletions(-)

diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 92b0804..169f2f3 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -497,6 +497,88 @@ x509_write_pem(FILE *peercert_file, mbedtls_x509_crt *peercert)
     return FAILURE;
 }
 
+result_t
+x509_verify_crl_cert(const mbedtls_x509_crl *crl, mbedtls_x509_crt *cert,
+		     struct gc_arena *gc, const char *crl_file,
+		     const char *subject)
+{
+  result_t ret = FAILURE;
+  char *serial;
+
+  ASSERT(crl && cert);
+
+  if((cert->issuer_raw.len != crl->issuer_raw.len) ||
+     (memcmp(crl->issuer_raw.p, cert->issuer_raw.p, crl->issuer_raw.len) != 0))
+    {
+      msg(M_WARN, "CRL: CRL %s is from a different issuer than the issuer of "
+	  "certificate %s", crl_file ? crl_file : "[in-memory]", subject);
+      ret = SUCCESS;
+      goto end;
+    }
+
+  if (!mbed_ok(mbedtls_x509_crt_is_revoked(cert, crl)))
+    {
+      serial = backend_x509_get_serial_hex(cert, gc);
+      msg (D_HANDSHAKE, "CRL CHECK FAILED: %s (serial %s) is REVOKED", subject,
+	   (serial ? serial : "NOT AVAILABLE"));
+      goto end;
+    }
+
+  ret = SUCCESS;
+  msg(D_HANDSHAKE, "CRL CHECK OK: %s", subject);
+end:
+
+  return ret;
+}
+
+result_t
+x509_verify_crl_mem(const openvpn_x509_crl_t *crl, mbedtls_x509_crt *cert,
+		    const char *subject)
+{
+  struct gc_arena gc = gc_new();
+  int ret;
+
+  ASSERT(crl && cert);
+
+  ret = x509_verify_crl_cert(&crl->crl, cert, &gc, NULL, subject);
+
+  gc_free(&gc);
+
+  return ret;
+}
+
+void
+x509_crl_free(openvpn_x509_crl_t *crl)
+{
+  ASSERT(crl);
+
+  mbedtls_x509_crl_free(&crl->crl);
+  memset(&crl->crl, 0, sizeof(crl->crl));
+}
+
+result_t
+x509_load_crl_mem(openvpn_x509_crl_t *crl, const char *crl_file)
+{
+  result_t ret = FAILURE;
+
+  ASSERT(crl && crl_file);
+
+  x509_crl_free(crl);
+
+  msg(D_TLS_DEBUG_LOW, "CRL-persist: loading file: %s", crl_file);
+
+  if (!mbed_ok(mbedtls_x509_crl_parse_file(&crl->crl, crl_file)))
+    {
+      msg(M_WARN, "CRL: cannot read: %s", crl_file);
+      goto end;
+    }
+
+  ret = SUCCESS;
+end:
+
+  return ret;
+}
+
 /*
  * check peer cert against CRL
  */
@@ -507,7 +589,6 @@ x509_verify_crl(const char *crl_file, const char *crl_inline,
   result_t retval = FAILURE;
   mbedtls_x509_crl crl = {0};
   struct gc_arena gc = gc_new();
-  char *serial;
 
   if (!strcmp (crl_file, INLINE_FILE_TAG) && crl_inline)
     {
@@ -527,24 +608,7 @@ x509_verify_crl(const char *crl_file, const char *crl_inline,
       }
   }
 
-  if(cert->issuer_raw.len != crl.issuer_raw.len ||
-      memcmp(crl.issuer_raw.p, cert->issuer_raw.p, crl.issuer_raw.len) != 0)
-    {
-      msg (M_WARN, "CRL: CRL %s is from a different issuer than the issuer of "
-	  "certificate %s", crl_file, subject);
-      retval = SUCCESS;
-      goto end;
-    }
-
-  if (!mbed_ok(mbedtls_x509_crt_is_revoked(cert, &crl)))
-    {
-      serial = backend_x509_get_serial_hex(cert, &gc);
-      msg (D_HANDSHAKE, "CRL CHECK FAILED: %s (serial %s) is REVOKED", subject, (serial ? serial : "NOT AVAILABLE"));
-      goto end;
-    }
-
-  retval = SUCCESS;
-  msg (D_HANDSHAKE, "CRL CHECK OK: %s",subject);
+  retval = x509_verify_crl_cert(&crl, cert, &gc, crl_file, subject);
 
 end:
   gc_free(&gc);
-- 
2.10.1


