From: selva.nair@...277...
Date: Tue,  3 Jan 2017 16:42:18 -0500
Message-Id: <1483479738-17672-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Fix push options digest update
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

From: Selva Nair <selva.nair@...277...>

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index f515475..c9c04a6 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -692,8 +692,8 @@ push_update_digest(md_ctx_t *ctx, struct buffer *buf, const struct options *opt)
         {
             continue;
         }
+        md_ctx_update(ctx, (const uint8_t *) line, strlen(line)+1);
     }
-    md_ctx_update(ctx, (const uint8_t *) line, strlen(line)+1);
 }
 
 int
-- 
2.1.4


