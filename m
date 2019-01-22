From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 22 Jan 2019 13:02:47 +0200
Message-Id: <1548154968-13019-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH 1/2] crypto_openssl.c: fix
 heap-buffer-overflow found by AddressSanitizer
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

From: Lev Stipakov <lev@...515...>

OpenSSL's version of crypto_pem_encode() uses PEM_write_bio()
function to write PEM-encoded data to BIO object. That method doesn't
add NUL termanator, unlike its mbedTLS counterpart mbedtls_pem_write_buffer().

The code which uses PEM data treats it as a string, so missing NUL
terminator makes sanitizer to compain.

Fix by adding a NUL terminator.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/crypto_openssl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 9691ce0..6a49067 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -400,8 +400,9 @@ crypto_pem_encode(const char *name, struct buffer *dst,
     BUF_MEM *bptr;
     BIO_get_mem_ptr(bio, &bptr);
 
-    *dst = alloc_buf_gc(bptr->length, gc);
+    *dst = alloc_buf_gc(bptr->length + 1, gc);
     ASSERT(buf_write(dst, bptr->data, bptr->length));
+    *BEND(dst) = '\0';
 
     ret = true;
 cleanup:
-- 
2.7.4


