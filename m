From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 28 Jan 2025 13:41:29 +0100
Message-Id: <20250128124129.109647-1-frank@...2641...>
In-Reply-To: <gerrit.1738029022000.Ieca0f8aa07413682d39e73dd3ed21a0038d41f49@...2715...>
References: <gerrit.1738029022000.Ieca0f8aa07413682d39e73dd3ed21a0038d41f49@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Haiku: change del to delete in route
 command. del is undocumented
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

From: Alexander von Gluck <alex@...2837...>

Change-Id: Ieca0f8aa07413682d39e73dd3ed21a0038d41f49
Signed-off-by: Alexander von Gluck <alex@...2837...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/690
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d17b285..12d6c07 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2359,8 +2359,8 @@
 
 #elif defined(TARGET_HAIKU)
 
-    /* ex: route del /dev/net/ipro1000/0 inet 192.168.0.0 gw 192.168.1.1 netmask 255.255.0.0 */
-    argv_printf(&argv, "%s del %s inet %s gw %s netmask %s",
+    /* ex: route delete /dev/net/ipro1000/0 inet 192.168.0.0 gw 192.168.1.1 netmask 255.255.0.0 */
+    argv_printf(&argv, "%s delete %s inet %s gw %s netmask %s",
                 ROUTE_PATH,
                 rgi->iface,
                 network,
@@ -2551,8 +2551,8 @@
         "on connect only and will clean up automatically.");
 #elif defined(TARGET_HAIKU)
 
-    /* ex: route del /dev/net/ipro1000/0 inet6 :: gw beef::cafe prefixlen 64 */
-    argv_printf(&argv, "%s del %s inet6 %s gw %s prefixlen %d",
+    /* ex: route delete /dev/net/ipro1000/0 inet6 :: gw beef::cafe prefixlen 64 */
+    argv_printf(&argv, "%s delete %s inet6 %s gw %s prefixlen %d",
                 ROUTE_PATH,
                 r6->iface,
                 network,

