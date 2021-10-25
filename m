From: Max Fillinger <maximilian.fillinger@...2507...>
Date: Mon, 25 Oct 2021 16:53:14 +0200
Message-ID: <20211025145314.23009-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Don't manually free DH params in OpenSSL 3
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

When the EVP_PKEY object with the Diffie-Hellman parameters is passed
to SSL_CTX_set0_tmp_dh_pkey, it does not create a copy but stores the
pointer in the SSL_CTX. Therefore, we should not free it.

The EVP_PKEY will be freed automatically when we free the SSL_CTX.

Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
 src/openvpn/ssl_openssl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 2414fc5e..6f2d6d57 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -685,8 +685,6 @@ tls_ctx_load_dh_params(struct tls_root_ctx *ctx, const char *dh_file,
 
     msg(D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with %d bit key",
         8 * EVP_PKEY_get_size(dh));
-
-    EVP_PKEY_free(dh);
 #else
     DH *dh = PEM_read_bio_DHparams(bio, NULL, NULL, NULL);
     BIO_free(bio);
-- 
2.11.0


