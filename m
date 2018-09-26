From: Steffan Karger <steffan@...1856...>
Date: Wed, 26 Sep 2018 21:27:06 +0200
Message-Id: <20180926192706.29460-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix memory leak in SSL_CTX_use_certificate
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

Commit 98bfeeb4 introduced a memory leak in SSL_CTX_use_certificate by
removing the "if(x509) { ... }" bit while not changing the
"else if(x) {}" right after to an "if(x) {}".

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_openssl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d9bc9d74..fe4db604 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -855,7 +855,7 @@ end:
     {
         BIO_free(in);
     }
-    else if (x)
+    if (x)
     {
         X509_free(x);
     }
-- 
2.17.1


