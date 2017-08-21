From: =?UTF-8?q?Szil=C3=A1rd=20Pfeiffer?= <coroner@...2290...>
Date: Mon, 21 Aug 2017 23:09:33 +0200
Message-Id: <20170821210933.11460-1-coroner@...2290...>
In-Reply-To: <3069bcad-548c-4f90-91ce-b8950095bfd9@...2080...>
References: <3069bcad-548c-4f90-91ce-b8950095bfd9@...2080...>
Subject: [Openvpn-devel] [PATCH] OpenSSL: Always set
 SSL_OP_CIPHER_SERVER_PREFERENCE flag
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

* safe bet to say that server admins are better at updating their configs
  than client users are and if client do want to restrict their ciphers,
  they should simply evict the ciphers they don't want from their cipher
  suite
* mbed TLS and OpenSSL behave more similar with the
  SSL_OP_CIPHER_SERVER_PREFERENCE flag
---
 src/openvpn/ssl_openssl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 597c62d8..bb8098cc 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -252,6 +252,9 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
         {
             sslopt |= SSL_OP_NO_TLSv1_2;
         }
+#endif
+#ifdef SSL_OP_CIPHER_SERVER_PREFERENCE
+       sslopt |= SSL_OP_CIPHER_SERVER_PREFERENCE;
 #endif
         sslopt |= SSL_OP_NO_COMPRESSION;
         SSL_CTX_set_options(ctx->ctx, sslopt);
-- 
2.14.1


