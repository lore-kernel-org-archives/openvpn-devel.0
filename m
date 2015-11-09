From: Lev Stipakov <lstipakov@...277...>
Date: Mon,  9 Nov 2015 16:35:09 +0200
Message-Id: <1447079709-17806-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH v2] Use adapter index instead of name
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
 src/openvpn/tun.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 24a61ec..0347a52 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1301,18 +1301,18 @@ do_ifconfig (struct tuntap *tt,
     if ( do_ipv6 )
       {
 	char * saved_actual;
+	const DWORD idx = get_adapter_index_flexible(actual);
 
 	if (!strcmp (actual, "NULL"))
 	  msg (M_FATAL, "Error: When using --tun-ipv6, if you have more than one TAP-Windows adapter, you must also specify --dev-node");
 
-	/* example: netsh interface ipv6 set address MyTap 2001:608:8003::d store=active */
+	/* example: netsh interface ipv6 set address 42 2001:608:8003::d store=active */
 	argv_printf (&argv,
-		    "%s%sc interface ipv6 set address %s %s store=active",
+		     "%s%sc interface ipv6 set address %u %s store=active",
 		     get_win_sys_path(),
 		     NETSH_PATH_SUFFIX,
-		     actual,
-		     ifconfig_ipv6_local );
-
+		     idx,
+		     ifconfig_ipv6_local);
 	netsh_command (&argv, 4);
 
 	/* explicit route needed */
-- 
1.9.1


