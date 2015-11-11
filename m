From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 11 Nov 2015 13:48:07 +0200
Message-Id: <1447242487-30243-1-git-send-email-lstipakov@...277...>
In-Reply-To: <20151111081604.GU24952@...1296...>
References: <20151111081604.GU24952@...1296...>
Subject: [Openvpn-devel] [PATCH v3] Use adapter index instead of name
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
Cc: Olli Mannisto <olmannisto@...277...>

v3:
 * Use interface=<idx> syntax.
 * Add forward declaration of get_adapter_index_flexible to get rid of warning.

v2:
 * Remove netsh call which uses adapter name. After thoughtful testing
turns out that "adapter name" code branch is never used.

Some windows machines get weird issues with netsh when using
adapter name on "netsh.exe interface ipv6 set address" command.

Changed logic to get adapter index and use it instead of adapter
name for netsh set address command. if unable to get adapter index,
try with adapter name.

Signed-off-by: Olli Mannisto <olmannisto@...277...>
Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/tun.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 24a61ec..070fd18 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -67,6 +67,8 @@ static void netsh_command (const struct argv *a, int n);
 
 static const char *netsh_get_id (const char *dev_node, struct gc_arena *gc);
 
+static DWORD get_adapter_index_flexible (const char *name);
+
 #endif
 
 #ifdef TARGET_SOLARIS
@@ -1301,18 +1303,20 @@ do_ifconfig (struct tuntap *tt,
     if ( do_ipv6 )
       {
 	char * saved_actual;
+	char iface[64];
 
 	if (!strcmp (actual, "NULL"))
 	  msg (M_FATAL, "Error: When using --tun-ipv6, if you have more than one TAP-Windows adapter, you must also specify --dev-node");
 
-	/* example: netsh interface ipv6 set address MyTap 2001:608:8003::d store=active */
+	openvpn_snprintf(iface, sizeof(iface), "interface=%lu", get_adapter_index_flexible(actual));
+
+	/* example: netsh interface ipv6 set address interface=42 2001:608:8003::d store=active */
 	argv_printf (&argv,
-		    "%s%sc interface ipv6 set address %s %s store=active",
+		     "%s%sc interface ipv6 set address %s %s store=active",
 		     get_win_sys_path(),
 		     NETSH_PATH_SUFFIX,
-		     actual,
-		     ifconfig_ipv6_local );
-
+		     iface,
+		     ifconfig_ipv6_local);
 	netsh_command (&argv, 4);
 
 	/* explicit route needed */
-- 
1.9.1


