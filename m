From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 18 Jul 2019 12:35:03 +0300
Message-Id: <1563442503-11119-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] crypto.c: fix Visual Studio build
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

Commit fb4e8ab added variable-length array which
is C99 feature and is not supported by Visual Studio.

This removes VLA and writes data directly into passed buffer.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/crypto.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 69877d1..8bf33e7 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1895,14 +1895,18 @@ cleanup:
 bool
 generate_ephemeral_key(struct buffer *key, const char *key_name)
 {
+    const int len = BCAP(key);
+
     msg(M_INFO, "Using random %s.", key_name);
-    uint8_t rand[BCAP(key)];
-    if (!rand_bytes(rand, BCAP(key)))
+
+    if (!rand_bytes(BEND(key), len))
     {
         msg(M_WARN, "ERROR: could not generate random key");
         return false;
     }
-    buf_write(key, rand, BCAP(key));
+
+    buf_inc_len(key, len);
+
     return true;
 }
 
-- 
2.7.4


