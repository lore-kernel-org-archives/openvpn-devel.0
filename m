From: Gert Doering <gert@...1296...>
Date: Thu,  2 May 2024 11:53:22 +0200
Message-ID: <20240502095322.9433-1-gert@...1296...>
In-Reply-To: <gerrit.1712744941000.Ie61fa6a78875ecbaa9d3d8e7a50603d77c9ce09e@...2715...>
References: <gerrit.1712744941000.Ie61fa6a78875ecbaa9d3d8e7a50603d77c9ce09e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix "binary or" vs "boolean or" related
 to server_bridge_proxy_dhcp
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

From: Frank Lichtenheld <frank@...2641...>

Both values are boolean so there is no reason to use "|"
and it just confuses the reader whether there is something
more going on here.

Change-Id: Ie61fa6a78875ecbaa9d3d8e7a50603d77c9ce09e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/553
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 1bab84c..24dee97 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -427,7 +427,7 @@
      * if !nogw:
      *   push "route-gateway dhcp"
      */
-    else if (o->server_bridge_defined | o->server_bridge_proxy_dhcp)
+    else if (o->server_bridge_defined || o->server_bridge_proxy_dhcp)
     {
         if (o->client)
         {
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 02205e7..e67f10e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3565,7 +3565,7 @@
         msg(M_WARN, "WARNING: using --pull/--client and --ifconfig together is probably not what you want");
     }
 
-    if (o->server_bridge_defined | o->server_bridge_proxy_dhcp)
+    if (o->server_bridge_defined || o->server_bridge_proxy_dhcp)
     {
         msg(M_WARN, "NOTE: when bridging your LAN adapter with the TAP adapter, note that the new bridge adapter will often take on its own IP address that is different from what the LAN adapter was previously set to");
     }

