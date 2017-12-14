From: Steffan Karger <steffan@...1856...>
Date: Thu, 14 Dec 2017 11:21:37 +0100
Message-Id: <1513246897-28171-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] ssl_openssl: fix compiler warning by
 removing getbio() wrapper
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

An API change in openssl 1.1 made the BIO_METHOD * returned by BIO_f_ssl()
and BIO_s_mem() const, as well as the BIO_METHOD * argment of BIO_new()
const.  This meant that our getbio() function would either have an API
inconsistent with 1.0 or 1.1.

The wrapper was basically an ASSERT, so fix this by replacing the wrapper
with an ASSERT.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_openssl.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 34c31b9..711bba1 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1416,23 +1416,6 @@ bio_debug_oc(const char *mode, BIO *bio)
 #endif /* ifdef BIO_DEBUG */
 
 /*
- * OpenVPN's interface to SSL/TLS authentication,
- * encryption, and decryption is exclusively
- * through "memory BIOs".
- */
-static BIO *
-getbio(BIO_METHOD *type, const char *desc)
-{
-    BIO *ret;
-    ret = BIO_new(type);
-    if (!ret)
-    {
-        crypto_msg(M_FATAL, "Error creating %s BIO", desc);
-    }
-    return ret;
-}
-
-/*
  * Write to an OpenSSL BIO in non-blocking mode.
  */
 static int
@@ -1573,9 +1556,9 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl, const struct tls_root_ctx *ssl_
      * from verify callback*/
     SSL_set_ex_data(ks_ssl->ssl, mydata_index, session);
 
-    ks_ssl->ssl_bio = getbio(BIO_f_ssl(), "ssl_bio");
-    ks_ssl->ct_in = getbio(BIO_s_mem(), "ct_in");
-    ks_ssl->ct_out = getbio(BIO_s_mem(), "ct_out");
+    ASSERT((ks_ssl->ssl_bio = BIO_new(BIO_f_ssl())));
+    ASSERT((ks_ssl->ct_in = BIO_new(BIO_s_mem())));
+    ASSERT((ks_ssl->ct_out = BIO_new(BIO_s_mem())));
 
 #ifdef BIO_DEBUG
     bio_debug_oc("open ssl_bio", ks_ssl->ssl_bio);
-- 
2.7.4


