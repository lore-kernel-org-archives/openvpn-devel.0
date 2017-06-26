From: Arne Schwabe <arne@...1227...>
Date: Mon, 26 Jun 2017 13:13:26 +0200
Message-Id: <1498475606-8337-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Set tls-cipher restriction before loading
 certificates
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

OpenSSL 1.1 does not allow MD5 signed certificates by default anymore. This can be enabled again by settings tls-cipher "DEFAULT:@SECLEVEL=0" but only if the cipher list is set before loading the certificates. This patch changes the order of loading.
---
 src/openvpn/ssl.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 29280dce..9ca300c0 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -616,6 +616,11 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
         tls_ctx_client_new(new_ctx);
     }
 
+    /* Allowable ciphers */
+    /* Since @SECLEVEL also influces loading of certificates, set the
+     * cipher restrictions before loading certificates */
+    tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
+
     tls_ctx_set_options(new_ctx, options->ssl_flags);
 
     if (options->pkcs12_file)
@@ -708,9 +713,6 @@ init_ssl(const struct options *options, struct tls_root_ctx *new_ctx)
         tls_ctx_load_ecdh_params(new_ctx, options->ecdh_curve);
     }
 
-    /* Allowable ciphers */
-    tls_ctx_restrict_ciphers(new_ctx, options->cipher_list);
-
 #ifdef ENABLE_CRYPTO_MBEDTLS
     /* Personalise the random by mixing in the certificate */
     tls_ctx_personalise_random(new_ctx);
-- 
2.11.0 (Apple Git-81)


