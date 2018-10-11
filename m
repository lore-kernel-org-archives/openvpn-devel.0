From: Steffan Karger <steffan.karger@...1435...>
Date: Thu, 11 Oct 2018 09:20:00 +0200
Message-ID: <1539242400-27614-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] mbedtls: don't print unsupported ciphers in
 insecure cipher list
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

Commit 447997dd refactored the --show-ciphers code, but introduced a bug
in mbedtls builds where non-AEAD/CBC cipher were printed too.  Those are
however unsupported (as openvpn will tell you when you try to use them).

This fixes that bug.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/crypto_mbedtls.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 46c3c60..77e84c3 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -170,7 +170,8 @@ show_available_ciphers(void)
     while (*ciphers != 0)
     {
         const cipher_kt_t *info = mbedtls_cipher_info_from_type(*ciphers);
-        if (info && cipher_kt_insecure(info))
+        if (info && cipher_kt_insecure(info)
+            && (cipher_kt_mode_aead(info) || cipher_kt_mode_cbc(info)))
         {
             print_cipher(info);
         }
-- 
2.7.4


