From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 24 Jun 2016 18:01:41 +0200
Message-ID: <1466784101-20655-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Windows: do_ifconfig() after open_tun()
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

When you had multiple TAP adapters and IPv6 configured you got an error
message about "you must also specify --dev-node" and openvpn exited.
Very inconvenient especially since this is only due to the fact that
Windows tries to set the adapter address before it is opened; for no
good reason.

This patch changes the order to IFCONFIG_AFTER_TUN_OPEN, moves some
initialization code to init_tun, where it belongs, and removes duplicate
code that is now no longer needed.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/tun.c | 56 ++++++++++++++++++-------------------------------------
 src/openvpn/tun.h |  2 +-
 2 files changed, 19 insertions(+), 39 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index b7a29f7..4a11d10 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -611,6 +611,21 @@ init_tun (const char *dev,       /* --dev option */
 	  tt->broadcast = generate_ifconfig_broadcast_addr (tt->local, tt->remote_netmask);
 	}
 
+#ifdef WIN32
+      /*
+       * Make sure that both ifconfig addresses are part of the
+       * same .252 subnet.
+       */
+      if (tun)
+        {
+          verify_255_255_255_252 (tt->local, tt->remote_netmask);
+          tt->adapter_netmask = ~3;
+        }
+      else
+        {
+          tt->adapter_netmask = tt->remote_netmask;
+        }
+#endif
 
       tt->did_ifconfig_setup = true;
     }
@@ -1327,19 +1342,7 @@ do_ifconfig (struct tuntap *tt,
       }
 #elif defined (WIN32)
       {
-	/*
-	 * Make sure that both ifconfig addresses are part of the
-	 * same .252 subnet.
-	 */
-	if (tun)
-	  {
-	    verify_255_255_255_252 (tt->local, tt->remote_netmask);
-	    tt->adapter_netmask = ~3;
-	  }
-	else
-	  {
-	    tt->adapter_netmask = tt->remote_netmask;
-	  }
+        ASSERT (actual != NULL);
 
 	switch (tt->options.ip_win32_type)
 	  {
@@ -1350,9 +1353,6 @@ do_ifconfig (struct tuntap *tt,
 		 print_in_addr_t (tt->adapter_netmask, 0, &gc));
 	    break;
 	  case IPW32_SET_NETSH:
-	    if (!strcmp (actual, "NULL"))
-	      msg (M_FATAL, "Error: When using --ip-win32 netsh, if you have more than one TAP-Windows adapter, you must also specify --dev-node");
-
 	    netsh_ifconfig (&tt->options,
 			    actual,
 			    tt->local,
@@ -1366,25 +1366,6 @@ do_ifconfig (struct tuntap *tt,
 
     if ( do_ipv6 )
       {
-	char * saved_actual;
-	char iface[64];
-	DWORD idx;
-
-	if (!strcmp (actual, "NULL"))
-	  msg (M_FATAL, "Error: When using --tun-ipv6, if you have more than one TAP-Windows adapter, you must also specify --dev-node");
-
-	idx = get_adapter_index_flexible(actual);
-	openvpn_snprintf(iface, sizeof(iface), "interface=%lu", idx);
-
-	/* on windows, OpenVPN does ifconfig first, open_tun later, so
-	 * tt->actual_name might not yet be initialized, but routing code
-	 * needs to know interface name - point to "actual", restore later
-	 */
-	saved_actual = tt->actual_name;
-	tt->actual_name = (char*) actual;
-	/* we use adapter_index in add_route_ipv6 */
-	tt->adapter_index = idx;
-
 	if (tt->options.msg_channel)
 	  {
 	    do_address_service (true, AF_INET6, tt);
@@ -1393,17 +1374,16 @@ do_ifconfig (struct tuntap *tt,
 	  {
 	    /* example: netsh interface ipv6 set address interface=42 2001:608:8003::d store=active */
 	    argv_printf (&argv,
-			 "%s%sc interface ipv6 set address %s %s store=active",
+			 "%s%sc interface ipv6 set address interface=%lu %s store=active",
 			 get_win_sys_path(),
 			 NETSH_PATH_SUFFIX,
-			 iface,
+			 tt->adapter_index,
 			 ifconfig_ipv6_local );
 	    netsh_command (&argv, 4, M_FATAL);
 	  }
 
 	/* explicit route needed */
 	add_route_connected_v6_net(tt, es);
-	tt->actual_name = saved_actual;
       }
 #else
       msg (M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 4e93a3f..1ccf378 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -301,7 +301,7 @@ ifconfig_order(void)
 #elif defined(TARGET_NETBSD)
   return IFCONFIG_AFTER_TUN_OPEN;
 #elif defined(WIN32)
-  return IFCONFIG_BEFORE_TUN_OPEN;
+  return IFCONFIG_AFTER_TUN_OPEN;
 #elif defined(TARGET_ANDROID)
   return IFCONFIG_BEFORE_TUN_OPEN;
 #else
-- 
2.7.4


