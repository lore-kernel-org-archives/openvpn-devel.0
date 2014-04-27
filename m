From: Steffan Karger <steffan@...1856...>
Date: Sun, 27 Apr 2014 09:55:48 +0200
Message-Id: <1398585348-7969-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/2] Change signedness of hash in
	x509_get_sha1_hash(), fixes compiler warning.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

hash was cast from char * to unsigned char * at the return of the function.
This patch removes the implicit cast by declaring hash as unsigned char * .

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl_verify_openssl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index a9205f3..0f571d9 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -241,7 +241,7 @@ backend_x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
 unsigned char *
 x509_get_sha1_hash (X509 *cert, struct gc_arena *gc)
 {
-  char *hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
+  unsigned char *hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
   memcpy(hash, cert->sha1_hash, SHA_DIGEST_LENGTH);
   return hash;
 }
-- 
1.8.3.2


