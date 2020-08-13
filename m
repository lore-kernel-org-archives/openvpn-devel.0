From: Gert Doering <gert@...1296...>
Date: Thu, 13 Aug 2020 12:13:01 +0200
Message-Id: <20200813101301.12720-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix stack overflow in OpenSolaris NEXTADDR()
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

Commit 5fde831c5807 fixed NEXTADDR() for all *BSDs and MacOS.

OpenSolaris has to use a slightly different macro due to lack of
sockaddr->sa_len - but it has the same problem, first rounding up,
then memmove()'ing.  Switch order.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 24563ed6..f127a90a 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3429,7 +3429,7 @@ struct rtmsg {
 #if defined(TARGET_SOLARIS)
 #define NEXTADDR(w, u) \
     if (rtm_addrs & (w)) { \
-        l = ROUNDUP(sizeof(u)); memmove(cp, &(u), l); cp += l; \
+        l = sizeof(u); memmove(cp, &(u), l); cp += ROUNDUP(l); \
     }
 
 #define ADVANCE(x, n) (x += ROUNDUP(sizeof(struct sockaddr_in)))
-- 
2.23.0


