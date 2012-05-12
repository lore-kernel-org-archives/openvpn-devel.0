From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:31:43 +0300
Message-Id: <1336851105-24172-3-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336851105-24172-1-git-send-email-alon.barlev@...277...>
References: <1336851105-24172-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [V2.4 2/4] cleanup: move
	warn_on_use_of_common_subnets to init.c
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
To: openvpn-devel@lists.sourceforge.net, openvpn.list@...1114..., openvpn-devel@lists.sourceforge.net, openvpn.list@...1114...
Cc: Alon Bar-Lev <alon.barlev@...277...>

No dependencies and init.c is the only user.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/init.c |   18 ++++++++++++++++++
 src/openvpn/tun.c  |   17 -----------------
 src/openvpn/tun.h  |    2 --
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 61ced5d..eb4c5df 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -59,6 +59,24 @@ static struct context *static_context; /* GLOBAL */
 
 static void do_init_first_time (struct context *c);
 
+static
+void
+warn_on_use_of_common_subnets (void)
+{
+  struct gc_arena gc = gc_new ();
+  struct route_gateway_info rgi;
+  const int needed = (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
+
+  get_default_gateway (&rgi);
+  if ((rgi.flags & needed) == needed)
+    {
+      const in_addr_t lan_network = rgi.gateway.addr & rgi.gateway.netmask;
+      if (lan_network == 0xC0A80000 || lan_network == 0xC0A80100)
+	msg (M_WARN, "NOTE: your local LAN uses the extremely common subnet address 192.168.0.x or 192.168.1.x.  Be aware that this might create routing conflicts if you connect to the VPN server from public locations such as internet cafes that use the same subnet.");
+    }
+  gc_free (&gc);
+}
+
 void
 context_clear (struct context *c)
 {
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 033c1e2..31684f4 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -242,23 +242,6 @@ check_addr_clash (const char *name,
   gc_free (&gc);
 }
 
-void
-warn_on_use_of_common_subnets (void)
-{
-  struct gc_arena gc = gc_new ();
-  struct route_gateway_info rgi;
-  const int needed = (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
-
-  get_default_gateway (&rgi);
-  if ((rgi.flags & needed) == needed)
-    {
-      const in_addr_t lan_network = rgi.gateway.addr & rgi.gateway.netmask;
-      if (lan_network == 0xC0A80000 || lan_network == 0xC0A80100)
-	msg (M_WARN, "NOTE: your local LAN uses the extremely common subnet address 192.168.0.x or 192.168.1.x.  Be aware that this might create routing conflicts if you connect to the VPN server from public locations such as internet cafes that use the same subnet.");
-    }
-  gc_free (&gc);
-}
-
 /*
  * Complain if --dev tap and --ifconfig is used on an OS for which
  * we don't have a custom tap ifconfig template below.
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index bea1554..7a8e769 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -251,8 +251,6 @@ const char *ifconfig_options_string (const struct tuntap* tt, bool remote, bool
 
 bool is_tun_p2p (const struct tuntap *tt);
 
-void warn_on_use_of_common_subnets (void);
-
 /*
  * Inline functions
  */
-- 
1.7.3.4


