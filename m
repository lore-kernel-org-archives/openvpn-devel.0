From: Gert Doering <gert@...1296...>
Date: Wed, 17 Dec 2025 14:07:38 +0100
Message-ID: <20251217130743.28786-1-gert@...1296...>
In-Reply-To: <gerrit.1765973388000.I47fc0dc93a7ed6b71feb611194cee02a81d91769@...2715...>
References: <gerrit.1765973388000.I47fc0dc93a7ed6b71feb611194cee02a81d91769@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Ensure wolfSSL uses old pre 1.1.0
 OpenSSL path for getting ciphers
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

Normally when wolfSSL is compiled with --enable-openvpn it reports an
OpenSSL version before 1.1.0. When compiled normally it reports an
OpenSSL version higher than this.

So explicitly check for wolfSSL instead of relying on its OpenSSL version
trickery.

Change-Id: I47fc0dc93a7ed6b71feb611194cee02a81d91769
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1448
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1448
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 48bbdfc..35b75eb 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2547,7 +2547,7 @@
         crypto_msg(M_FATAL, "Cannot create SSL object");
     }
 
-#if OPENSSL_VERSION_NUMBER < 0x1010000fL || defined(OPENSSL_IS_AWSLC)
+#if OPENSSL_VERSION_NUMBER < 0x1010000fL || defined(OPENSSL_IS_AWSLC) || defined(ENABLE_CRYPTO_WOLFSSL)
     STACK_OF(SSL_CIPHER) *sk = SSL_get_ciphers(ssl);
 #else
     STACK_OF(SSL_CIPHER) *sk = SSL_get1_supported_ciphers(ssl);

