From: wgh@...2548...
Date: Thu,  2 Apr 2020 00:50:52 +0300
Message-Id: <20200401215052.3489613-1-wgh@...2548...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] OpenSSL: Fix --crl-verify not loading
 multiple CRLs in one file
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
Cc: Maxim Plotnikov <wgh@...2548...>

From: Maxim Plotnikov <wgh@...2548...>

Lack of this led people accepting multiple CAs to use capath,
which already supports multiple CRLs. But capath mode itself
is somewhat ugly: you have to create new file/symlink every time
CRL is updated, and there's no good way to clean them up without
restarting OpenVPN, since any gap in the sequence would cause it
to lose sync[1].

mbedtls crypto backends already loads multiple CRLs as is, so
it doesn't need this fix.

The patch also includes some logging changes which I think are useful.

If you wish to test the patch, here is prepared configuration
files: https://wgh.torlan.ru/openvpn-crl-fix-ca.tar.gz.
The client_ca2_revoked.ovpn config uses a revoked certificate
issued by the second CA, and is accepted by unpatched server,
but rightfully rejected with this patch (or when using mbedtls backend).

[1] https://community.openvpn.net/openvpn/ticket/623#comment:7
---
 src/openvpn/ssl_openssl.c | 41 +++++++++++++++++++++++++++------------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 3f0031ff..a5502a5b 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1038,7 +1038,7 @@ void
 backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
                            const char *crl_inline)
 {
-    X509_CRL *crl = NULL;
+    int i = 0;
     BIO *in = NULL;
 
     X509_STORE *store = SSL_CTX_get_cert_store(ssl_ctx->ctx);
@@ -1079,21 +1079,38 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
         goto end;
     }
 
-    crl = PEM_read_bio_X509_CRL(in, NULL, NULL, NULL);
-    if (crl == NULL)
-    {
-        msg(M_WARN, "CRL: cannot read CRL from file %s", crl_file);
-        goto end;
-    }
+    for (i = 0;; i++) {
+        X509_CRL *crl = PEM_read_bio_X509_CRL(in, NULL, NULL, NULL);
+        if (crl == NULL)
+        {
+            unsigned long err = ERR_get_error();
+            char buf[256];
+
+            if (ERR_GET_REASON(err) == PEM_R_NO_START_LINE && i > 0) {
+                // PEM_R_NO_START_LINE can be considered equivalent to EOF.
+                //
+                // A file without any CRLs should still be considered an error,
+                // though. Hence i > 0.
+                goto end;
+            }
 
-    if (!X509_STORE_add_crl(store, crl))
-    {
-        msg(M_WARN, "CRL: cannot add %s to store", crl_file);
-        goto end;
+            ERR_error_string_n(err, buf, sizeof(buf));
+
+            msg(M_WARN, "CRL: cannot read CRL from file %s: %s", crl_file, buf);
+            goto end;
+        }
+
+        if (!X509_STORE_add_crl(store, crl))
+        {
+            msg(M_WARN, "CRL: cannot add %s to store", crl_file);
+            X509_CRL_free(crl);
+            goto end;
+        }
+        X509_CRL_free(crl);
     }
 
 end:
-    X509_CRL_free(crl);
+    msg(M_INFO, "CRL: loaded %d CRLs from file %s", i, crl_file);
     BIO_free(in);
 }
 
-- 
2.24.1


