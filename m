From: David Sommerseth <davids@...1347...>
Date: Tue, 14 Feb 2012 11:48:47 +0100
Message-Id: <1329216527-14035-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Connection entry {tun,
	link}_mtu_defined not set correctly
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

Commit 76809cae0eae07817160b423d3f9551df1a1d68e enabled setting MTU
variables inside <connection> blocks.  But in that process, the
tun_mtu_defined and link_mtu_defined was not set as it should.

By moving this out of the options_postprocess_mutate_invariant()
function and into options_postprocess_mutate_ce(), these variables
get these *_mtu_defined variables are set correctly in each connection
entry.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 options.c |   32 +++++++++++++++++---------------
 1 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/options.c b/options.c
index 5e972b1..43e9e27 100644
--- a/options.c
+++ b/options.c
@@ -2395,6 +2395,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 static void
 options_postprocess_mutate_ce (struct options *o, struct connection_entry *ce)
 {
+  const int dev = dev_type_enum (o->dev, o->dev_type);
+
 #if P2MP_SERVER
   if (o->server_defined || o->server_bridge_defined || o->server_bridge_proxy_dhcp)
     {
@@ -2441,6 +2443,21 @@ options_postprocess_mutate_ce (struct options *o, struct connection_entry *ce)
 #endif      
     }
 
+  /*
+   * Set MTU defaults
+   */
+  {
+    if (!ce->tun_mtu_defined && !ce->link_mtu_defined)
+      {
+	ce->tun_mtu_defined = true;
+      }
+    if ((dev == DEV_TYPE_TAP) && !ce->tun_mtu_extra_defined)
+      {
+	ce->tun_mtu_extra_defined = true;
+	ce->tun_mtu_extra = TAP_MTU_EXTRA_DEFAULT;
+      }
+  }
+
 }
 
 static void
@@ -2455,21 +2472,6 @@ options_postprocess_mutate_invariant (struct options *options)
   if (options->inetd == INETD_NOWAIT)
     options->ifconfig_noexec = true;
 
-  /*
-   * Set MTU defaults
-   */
-  {
-    if (!options->ce.tun_mtu_defined && !options->ce.link_mtu_defined)
-      {
-	options->ce.tun_mtu_defined = true;
-      }
-    if ((dev == DEV_TYPE_TAP) && !options->ce.tun_mtu_extra_defined)
-      {
-	options->ce.tun_mtu_extra_defined = true;
-	options->ce.tun_mtu_extra = TAP_MTU_EXTRA_DEFAULT;
-      }
-  }
-
 #ifdef WIN32
   if ((dev == DEV_TYPE_TUN || dev == DEV_TYPE_TAP) && !options->route_delay_defined)
     {
-- 
1.7.4.4


