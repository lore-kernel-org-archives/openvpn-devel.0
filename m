From: Arne Schwabe <arne@...1227...>
Date: Wed,  9 Nov 2022 12:52:08 +0100
Message-Id: <20221109115208.1248948-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix md_kt_size in mbed TLS when queried for
 size of "none"
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

Previously this would error out with a M_FATAL message about cipher
not known. Align the mbed TLS version to OpenSSL version and also remove
unreachable code. This manifested in key_print2 running into this
M_FATAL message when used with an AEAD cipher and verb 7.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto_mbedtls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index da4ed9809..9087ff6ad 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -809,11 +809,11 @@ md_kt_name(const char *mdname)
 unsigned char
 md_kt_size(const char *mdname)
 {
-    const mbedtls_md_info_t *kt = md_get(mdname);
-    if (NULL == kt)
+    if (!strcmp("none", mdname))
     {
         return 0;
     }
+    const mbedtls_md_info_t *kt = md_get(mdname);
     return mbedtls_md_get_size(kt);
 }
 
-- 
2.37.0 (Apple Git-136)


