From: Xavier Franquet <xavier@...1461...>
Date: Mon, 23 May 2011 09:11:15 +0200
Message-Id: <1306134675-5915-1-git-send-email-xavier@...1461...>
In-Reply-To: <1305729501-500-1-git-send-email-xavier@...1461...>
References: <1305729501-500-1-git-send-email-xavier@...1461...>
Subject: [Openvpn-devel] [PATCH] Modified previous patch for route command.
	The parameter "dev <device>" is only used when the route goes
	through the VPN and not for local routes.
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

Signed-off-by: Xavier Franquet <xavier@...1461...>
---
 route.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/route.c b/route.c
index cb685c3..f361b07 100644
--- a/route.c
+++ b/route.c
@@ -1130,6 +1130,9 @@ add_route (struct route *r, const struct tuntap *tt, unsigned int flags, const s
   if (r->metric_defined)
     argv_printf_cat (&argv, "metric %d", r->metric);
 #endif  /*CONFIG_FEATURE_IPROUTE*/
+  if (r->option->gateway == NULL || !strcmp(r->option->gateway,"vpn_gateway"))
+    argv_print (&argv, "dev %s", tt->actual_name);
+
   argv_msg (D_ROUTE, &argv);
   status = openvpn_execve_check (&argv, es, 0, "ERROR: Linux route add command failed");
 
@@ -1478,6 +1481,10 @@ delete_route (const struct route *r, const struct tuntap *tt, unsigned int flags
 #endif /*CONFIG_FEATURE_IPROUTE*/
   if (r->metric_defined)
     argv_printf_cat (&argv, "metric %d", r->metric);
+
+  if (r->option->gateway == NULL || !strcmp(r->option->gateway,"vpn_gateway"))
+    argv_print (&argv, "dev %s", tt->actual_name);
+
   argv_msg (D_ROUTE, &argv);
   openvpn_execve_check (&argv, es, 0, "ERROR: Linux route delete command failed");
 
-- 
1.7.1


