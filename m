From: Steffan Karger <steffan@...1856...>
Date: Thu, 16 Mar 2017 10:12:17 +0100
Message-Id: <1489655537-19164-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix non-C99-compliant builds: don't use
	const size_t as array length
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

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto_openssl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 5f28391..9139480 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -292,8 +292,7 @@ show_available_ciphers()
     size_t i;
 
     /* If we ever exceed this, we must be more selective */
-    const size_t cipher_list_len = 1000;
-    const EVP_CIPHER *cipher_list[cipher_list_len];
+    const EVP_CIPHER *cipher_list[1000];
     size_t num_ciphers = 0;
 #ifndef ENABLE_SMALL
     printf("The following ciphers and cipher modes are available for use\n"
@@ -318,7 +317,7 @@ show_available_ciphers()
         {
             cipher_list[num_ciphers++] = cipher;
         }
-        if (num_ciphers == cipher_list_len)
+        if (num_ciphers == (sizeof(cipher_list)/sizeof(*cipher_list)))
         {
             msg(M_WARN, "WARNING: Too many ciphers, not showing all");
             break;
-- 
2.7.4


