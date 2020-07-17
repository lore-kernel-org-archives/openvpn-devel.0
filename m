From: Arne Schwabe <arne@...1227...>
Date: Fri, 17 Jul 2020 13:29:53 +0200
Message-Id: <20200717112953.6699-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Convert cc_check_return to switch/case
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

The return false/return true is the result of
running uncrustify.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 97b7df16..1fdf6ce5 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2229,22 +2229,16 @@ static inline bool
 cc_check_return(int *cc_succeeded_count,
                 enum client_connect_return ret)
 {
-    if (ret == CC_RET_SUCCEEDED)
+    switch (ret)
     {
-        (*cc_succeeded_count)++;
-        return true;
-    }
-    else if (ret == CC_RET_FAILED)
-    {
-        return false;
-    }
-    else if (ret == CC_RET_SKIPPED)
-    {
-        return true;
-    }
-    else
-    {
-        ASSERT(0);
+        case CC_RET_SUCCEEDED: (*cc_succeeded_count)++;
+            return true;
+
+        case CC_RET_FAILED: return false;
+
+        case CC_RET_SKIPPED: return true;
+
+        default: ASSERT(0);
     }
 }
 
-- 
2.26.2


