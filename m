From: Arne Schwabe <arne@...1227...>
Date: Tue,  7 Dec 2021 17:50:35 +0100
Message-Id: <20211207165035.3274728-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove ENABLE_CRYPTO_OPENSSL ifdef inside
 ENABLE_CRYPTO_OPENSSL ifdef
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

This ifdef is redundant.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_openssl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index ab9a8f347..724664bb9 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1964,13 +1964,11 @@ key_state_write_plaintext(struct key_state_ssl *ks_ssl, struct buffer *buf)
     int ret = 0;
     perf_push(PERF_BIO_WRITE_PLAINTEXT);
 
-#ifdef ENABLE_CRYPTO_OPENSSL
     ASSERT(NULL != ks_ssl);
 
     ret = bio_write(ks_ssl->ssl_bio, BPTR(buf), BLEN(buf),
                     "tls_write_plaintext");
     bio_write_post(ret, buf);
-#endif /* ENABLE_CRYPTO_OPENSSL */
 
     perf_pop();
     return ret;
-- 
2.33.0


