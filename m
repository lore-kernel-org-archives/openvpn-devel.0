From: Antonio Quartulli <a@...2181...>
Date: Mon, 10 Jan 2022 15:45:10 +0100
Message-Id: <20220110144510.17769-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] ssl.c: use arrow operator to access object
 member
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
Cc: Antonio Quartulli <a@...2181...>

The arrow operator exists exactly to perform a pointer dereference implicitly
while accessing a member.

while at it, add whitespaces around the '-' operator on the same line.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/ssl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 400b2062..ef3597af 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1669,9 +1669,9 @@ init_key_contexts(struct key_ctx_bi *key,
     init_key_ctx_bi(key, key2, key_direction, key_type, "Data Channel");
 
     /* Initialize implicit IVs */
-    key_ctx_update_implicit_iv(&key->encrypt, (*key2).keys[(int)server].hmac,
+    key_ctx_update_implicit_iv(&key->encrypt, key2->keys[(int)server].hmac,
                                MAX_HMAC_KEY_LENGTH);
-    key_ctx_update_implicit_iv(&key->decrypt, (*key2).keys[1-(int)server].hmac,
+    key_ctx_update_implicit_iv(&key->decrypt, key2->keys[1 - (int)server].hmac,
                                MAX_HMAC_KEY_LENGTH);
 
 }
-- 
2.34.1


