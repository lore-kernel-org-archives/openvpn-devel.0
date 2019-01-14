From: Arne Schwabe <arne@...1227...>
Date: Mon, 14 Jan 2019 16:48:14 +0100
Message-Id: <20190114154819.6064-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/6] Fix loading inline tls-crypt-v2 keys
 with mbed TLS
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
Cc: Arne Schwabe <arne@...515...>

From: Arne Schwabe <arne@...515...>

Using a tls-crypt-v2 key with mbed TLS inline results in

PEM decode error: source buffer not null-terminated

This is because the mbed TLS decode PEM function excepts the last byte
in the buffer to be 0x00. When constructing the buffer we only made as
big as strlen, which does not include the 0x00 byte of a string. Add an
extra byte to ensure also the null byte is included in the buffer.
---
 src/openvpn/tls_crypt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 85495d7f..6bc2b7f8 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -298,7 +298,7 @@ tls_crypt_v2_read_keyfile(struct buffer *key, const char *pem_name,
     }
     else
     {
-        buf_set_read(&key_pem, (const void *)key_inline, strlen(key_inline));
+        buf_set_read(&key_pem, (const void *)key_inline, strlen(key_inline) + 1);
     }
 
     if (!crypto_pem_decode(pem_name, key, &key_pem))
-- 
2.19.2


