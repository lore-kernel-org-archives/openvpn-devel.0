From: Gert Doering <gert@...1296...>
Date: Fri, 17 Apr 2026 18:46:38 +0200
Message-ID: <20260417164644.17897-1-gert@...1296...>
In-Reply-To: <gerrit.1774974242000.I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5@...2715...>
References: <gerrit.1774974242000.I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] OpenSSL 4.0: Use
 X509_check_certificate_times instead of X509_cmp_time
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Arne Schwabe <arne@...1227...>

The X509_cmp_time function is deprecated in OpenSSL 4.0. So we avoid it and
use the new API.

Change-Id: I6c2eda0e5bbb3a70b404f821e25ded81f0f5ddd5
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1595
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1595
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index efe5b5b..6130dc3 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -634,6 +634,7 @@
 #endif /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
 }
 
+#if OPENSSL_VERSION_NUMBER < 0x40000000L
 void
 tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
 {
@@ -669,6 +670,60 @@
         msg(M_WARN, "WARNING: Your certificate has expired!");
     }
 }
+#else
+void
+tls_ctx_check_cert_time(const struct tls_root_ctx *ctx)
+{
+    const X509 *cert;
+    ASSERT(ctx);
+
+    cert = SSL_CTX_get0_certificate(ctx->ctx);
+
+    if (cert == NULL)
+    {
+        return; /* Nothing to check if there is no certificate */
+    }
+
+    X509_VERIFY_PARAM *vpm = X509_VERIFY_PARAM_new();
+
+    if (vpm == NULL)
+    {
+        msg(D_TLS_DEBUG_MED, "Failed to initialise certificate verification parameters.");
+        return;
+    }
+
+    X509_VERIFY_PARAM_set_flags(vpm, X509_V_FLAG_USE_CHECK_TIME);
+    X509_VERIFY_PARAM_set_time(vpm, now);
+
+    int error = 0;
+    int ret = X509_check_certificate_times(vpm, cert, &error);
+    X509_VERIFY_PARAM_free(vpm);
+
+    if (ret == 1)
+    {
+        return;
+    }
+
+    switch (error)
+    {
+        case X509_V_ERR_ERROR_IN_CERT_NOT_BEFORE_FIELD:
+            msg(D_TLS_DEBUG_MED, "Failed to read certificate notBefore field.");
+            break;
+
+        case X509_V_ERR_CERT_NOT_YET_VALID:
+            msg(M_WARN, "WARNING: Your certificate is not yet valid!");
+            break;
+
+        case X509_V_ERR_ERROR_IN_CERT_NOT_AFTER_FIELD:
+            msg(D_TLS_DEBUG_MED, "Failed to read certificate notAfter field.");
+            break;
+
+        case X509_V_ERR_CERT_HAS_EXPIRED:
+            msg(M_WARN, "WARNING: Your certificate has expired!");
+            break;
+    }
+}
+#endif
 
 void
 tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file, bool dh_file_inline)

