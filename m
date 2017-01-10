From: David Sommerseth <davids@...515...>
Date: Tue, 10 Jan 2017 21:34:33 +0100
Message-Id: <1484080473-10415-2-git-send-email-davids@...515...>
In-Reply-To: <1484080473-10415-1-git-send-email-davids@...515...>
References: <04b17e24-74d9-193b-ff8d-575efbf4d63a@...2080...>
	<1484080473-10415-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH 2/2] management: Remove a redundant #ifdef
	block
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

Bascially removes two independent #ifdef ENABLE_MANAGEMENT blocks into
a single block, which makes the logic flow more easy to read.

Signed-off-by: David Sommerseth <davids@...515...>
Cc: Selva Nair <selva.nair@...277...>
---
 src/openvpn/init.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4786232..5296345 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -414,11 +414,7 @@ next_connection_entry(struct context *c)
                 break;
             }
         }
-        else
-#endif
-
-#ifdef ENABLE_MANAGEMENT
-        if (ce_defined && management && management_query_proxy_enabled(management))
+        else if (ce_defined && management && management_query_proxy_enabled(management))
         {
             ce_defined = ce_management_query_proxy(c);
             if (IS_SIG(c))
-- 
1.8.3.1


