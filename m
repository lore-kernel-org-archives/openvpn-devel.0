From: Heiko Hund <heiko@...2662...>
Date: Fri, 13 May 2022 01:19:01 +0200
Message-Id: <20220512231901.1077306-1-heiko@...2662...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] make %x destination unsigned
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

The %x specifier requires for the argument to be an unsigned int.

Signed-off-by: Heiko Hund <heiko@...2662...>
---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9ff384d0..3dbd3fab 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1104,7 +1104,7 @@ parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_aren
     ALLOC_OBJ_CLEAR_GC(ret, struct verify_hash_list, gc);
 
     char term = 0;
-    int byte;
+    unsigned int byte;
 
     while (*cp && i < nbytes)
     {
-- 
2.32.0


