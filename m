From: Arne Schwabe <arne@...1227...>
Date: Wed,  8 Mar 2023 00:57:37 +0100
Message-Id: <20230307235737.3595130-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Avoid warning about missing braces when
 initialising key struct
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

This avoids the warning from gcc about initialising the key2 struct

Change-Id: Ia73d24923b1efd99263f33ce13d90e04b59bd980
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/tls_crypt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 81098355e..e84d979e9 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -348,7 +348,8 @@ tls_crypt_v2_init_client_key(struct key_ctx_bi *key, struct key2 *original_key,
         msg(M_FATAL, "ERROR: invalid tls-crypt-v2 client key format");
     }
 
-    struct key2 key2 = { .n = 2, .keys = { 0 } };
+    struct key2 key2 = { .n = 2, .keys = {{{ 0 }}} };
+
     if (!buf_read(&client_key, &key2.keys, sizeof(key2.keys)))
     {
         msg(M_FATAL, "ERROR: not enough data in tls-crypt-v2 client key");
-- 
2.37.1 (Apple Git-137.1)


