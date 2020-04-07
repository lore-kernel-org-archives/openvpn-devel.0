From: wgh@...2548...
Date: Tue,  7 Apr 2020 20:44:36 +0300
Message-Id: <20200407174436.238933-1-wgh@...2548...>
In-Reply-To: <517c16b8-b552-8728-2e73-5f7bcc149953@...1227...>
References: <517c16b8-b552-8728-2e73-5f7bcc149953@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] OpenSSL: Fix --crl-verify not loading
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

mbedtls crypto backend already loads multiple CRLs as is, so
it doesn't need this fix.

The patch also includes some logging changes which I think are useful.

If you wish to test the patch, here is prepared configuration
files: https://wgh.torlan.ru/openvpn-crl-fix-ca.tar.gz.
The client_ca2_revoked.ovpn config uses a revoked certificate
issued by the second CA, and is accepted by unpatched server,
but rightfully rejected with this patch (or when using mbedtls backend).

[1] https://community.openvpn.net/openvpn/ticket/623#comment:7
---
 src/openvpn/ssl_openssl.c | 40 +++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 15959a90..dd818175 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1050,7 +1050,6 @@ void
 backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
                            const char *crl_inline)
 {
-    X509_CRL *crl = NULL;
     BIO *in = NULL;
 
     X509_STORE *store = SSL_CTX_get_cert_store(ssl_ctx->ctx);
@@ -1091,21 +1090,38 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
         goto end;
     }
 
-    crl = PEM_read_bio_X509_CRL(in, NULL, NULL, NULL);
-    if (crl == NULL)
+    int num_crls_loaded = 0;
+    while (true)
     {
-        msg(M_WARN, "CRL: cannot read CRL from file %s", crl_file);
-        goto end;
-    }
+        X509_CRL *crl = PEM_read_bio_X509_CRL(in, NULL, NULL, NULL);
+        if (crl == NULL)
+        {
+            /*
+             * PEM_R_NO_START_LINE can be considered equivalent to EOF.
+            */
+            bool eof = ERR_GET_REASON(ERR_peek_error()) == PEM_R_NO_START_LINE;
+            /* but warn if no CRLs have been loaded */
+            if (num_crls_loaded > 0 && eof) {
+                /* remove that error from error stack */
+                (void)ERR_get_error();
+                break;
+            }
 
-    if (!X509_STORE_add_crl(store, crl))
-    {
-        msg(M_WARN, "CRL: cannot add %s to store", crl_file);
-        goto end;
-    }
+            crypto_msg(M_WARN, "CRL: cannot read CRL from file %s", crl_file);
+            break;
+        }
 
+        if (!X509_STORE_add_crl(store, crl))
+        {
+            X509_CRL_free(crl);
+            crypto_msg(M_WARN, "CRL: cannot add %s to store", crl_file);
+            break;
+        }
+        X509_CRL_free(crl);
+        num_crls_loaded++;
+    }
+    msg(M_INFO, "CRL: loaded %d CRLs from file %s", num_crls_loaded, crl_file);
 end:
-    X509_CRL_free(crl);
     BIO_free(in);
 }
 
-- 
2.24.1


