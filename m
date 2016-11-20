From: Selva Nair <selva.nair@...277...>
Date: Sun, 20 Nov 2016 16:38:52 -0500
Message-Id: <1479677932-22078-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Handle --dhcp-option DNS6 on Windows using
	netsh
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

TODO: set dns servers using the interactive service

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 doc/openvpn.8         |  5 ++---
 src/openvpn/options.c | 22 ++++++++++++++--------
 src/openvpn/tun.c     | 30 ++++++++++++++++++++++++++++++
 src/openvpn/tun.h     |  3 +++
 4 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index d454a36..171bd72 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5634,13 +5634,12 @@ this option to set secondary DNS server addresses.
 Set primary domain name server IPv6 address.  Repeat
 this option to set secondary DNS server IPv6 addresses.
 
-Note: currently this is somewhat of a placeholder option - it is
-understood, but OpenVPN has no code to tell Windows about it (the
+Note: currently this is handled using netsh and requires admin rights (the
 existing DHCP code can only do IPv4 DHCP, and that protocol only
 permits IPv4 addresses anywhere).  The option will be put into the
 environment, so an
 .B \-\-up
-script could act upon it.
+script could act upon it if needed.
 
 .B WINS addr \-\-
 Set primary WINS server address (NetBIOS over TCP/IP Name Server).
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9e828d8..97be7fa 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6407,14 +6407,20 @@ add_option (struct options *options,
 	{
 	  dhcp_option_address_parse ("DNS", p[2], o->dns, &o->dns_len, msglevel);
 	}
-      else if (streq (p[1], "DNS6") && p[2])
-	{
-	  /* this is somewhat of a placeholder - we understand the option,
-	   * but cannot act upon it - so we'll just accept it and put it
-	   * into the environment, as we would do on all non-win32 platforms
-	   */
-	  foreign_option (options, p, 3, es);
-	}
+      else if (streq (p[1], "DNS6") && p[2] && ipv6_addr_safe(p[2]))
+        {
+          struct in6_addr addr;
+          foreign_option (options, p, 3, es);
+          if (o->dns6_len >= N_DHCP_ADDR)
+            {
+              msg (msglevel, "--dhcp-option DNS6: maximum of %d dns servers can be specified",
+	           N_DHCP_ADDR);
+            }
+          else if (get_ipv6_addr (p[2], &addr, NULL, msglevel))
+            {
+              o->dns6[o->dns6_len++] = addr;
+            }
+        }
       else if (streq (p[1], "WINS") && p[2])
 	{
 	  dhcp_option_address_parse ("WINS", p[2], o->wins, &o->wins_len, msglevel);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 77ae72f..5950906 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -68,6 +68,9 @@ static void netsh_ifconfig (const struct tuntap_options *to,
 			    const in_addr_t ip,
 			    const in_addr_t netmask,
 			    const unsigned int flags);
+static void netsh_dns6_servers (const struct in6_addr *addr_list,
+                                const int addr_len,
+                                const char *flex_name);
 static void netsh_command (const struct argv *a, int n, int msglevel);
 
 static const char *netsh_get_id (const char *dev_node, struct gc_arena *gc);
@@ -1375,6 +1378,7 @@ do_ifconfig (struct tuntap *tt,
 	if (tt->options.msg_channel)
 	  {
 	    do_address_service (true, AF_INET6, tt);
+            /* TODO: do_dns6_service() */
 	  }
 	else
 	  {
@@ -1388,6 +1392,8 @@ do_ifconfig (struct tuntap *tt,
 			 iface,
 			 ifconfig_ipv6_local );
 	    netsh_command (&argv, 4, M_FATAL);
+            /* set ipv6 dns servers if any are specified */
+	    netsh_dns6_servers(tt->options.dns6, tt->options.dns6_len, actual);
 	  }
 
 	/* explicit route needed */
@@ -4618,6 +4624,30 @@ ip_addr_member_of (const in_addr_t addr, const IP_ADDR_STRING *ias)
 }
 
 static void
+netsh_dns6_servers (const struct in6_addr *addr_list,
+                    const int addr_len,
+                    const char *flex_name)
+{
+    struct gc_arena gc = gc_new ();
+    struct argv argv = argv_new ();
+
+    for (int i = 0; i < addr_len; ++i)
+    {
+        const char *fmt = (i == 0) ?
+            "%s%sc interface ipv6 set dnsservers %s static %s validate=no"
+	    : "%s%sc interface ipv6 add dnsservers %s %s validate=no";
+        argv_printf (&argv, fmt, get_win_sys_path(),
+                     NETSH_PATH_SUFFIX, flex_name,
+                     print_in6_addr (addr_list[i], 0, &gc));
+        /* Treat errors while adding as non-fatal as we do not check for duplicates */
+        netsh_command (&argv, 2, (i==0)? M_FATAL : M_NONFATAL);
+    }
+
+    argv_reset (&argv);
+    gc_free (&gc);
+}
+
+static void
 netsh_ifconfig_options (const char *type,
 			const in_addr_t *addr_list,
 			const int addr_len,
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index dedd915..9b5a1b7 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -107,6 +107,9 @@ struct tuntap_options {
   bool dhcp_release;
 
   bool register_dns;
+
+  struct in6_addr dns6[N_DHCP_ADDR];
+  int dns6_len;
 };
 
 #elif TARGET_LINUX
-- 
2.1.4


