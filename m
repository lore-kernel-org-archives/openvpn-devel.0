From: Gert Doering <gert@...1296...>
Date: Fri, 31 Jan 2025 09:46:51 +0100
Message-ID: <20250131084651.24765-1-gert@...1296...>
In-Reply-To: <gerrit.1738260795000.I1db72d7dca648a8ea4ec65d173290a819971305c@...2715...>
References: <gerrit.1738260795000.I1db72d7dca648a8ea4ec65d173290a819971305c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] get_default_gateway(): implement
 platform support for Linux/SITNL
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

This adds Linux/SITNL platform functionality to the framework started by
commit 9df51cf56 and commit 0fcfc8381f.

v2: make comment reflect reality

Change-Id: I1db72d7dca648a8ea4ec65d173290a819971305c
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Antonio Quartulli <a@...2181...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/883
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <a@...2181...>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 3501e35..dd37fb9 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3332,8 +3332,8 @@
     CLEAR(*rgi);
     CLEAR(best_name);
 
-    /* get default gateway IP addr */
-    if (net_route_v4_best_gw(ctx, NULL, &rgi->gateway.addr, best_name) == 0)
+    /* find best route to 'dest', get gateway IP addr + interface */
+    if (net_route_v4_best_gw(ctx, &dest, &rgi->gateway.addr, best_name) == 0)
     {
         rgi->flags |= RGI_ADDR_DEFINED;
         if (!rgi->gateway.addr && best_name[0])

