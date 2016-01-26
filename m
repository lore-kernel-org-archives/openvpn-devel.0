From: Gert Doering <gert@...1296...>
Date: Tue, 26 Jan 2016 20:11:48 +0100
Message-Id: <1453835508-26119-1-git-send-email-gert@...1296...>
In-Reply-To: <2215306.x9ci9DhAZ9@...2001...>
References: <2215306.x9ci9DhAZ9@...2001...>
Subject: [Openvpn-devel] [PATCH v3] interactive service v3
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

From: Heiko Hund <heiko.hund@...1489...>

v1: Heiko Hund
 - Message-ID: <2215306.x9ci9DhAZ9@...2001...>
 - extend openvpn service to provide "automatic service" and "interactive
   service" (which is used by GUI and OpenVPN to run openvpn non-privileged
   and still be able to install routes and configure IPv6 addresses)
 - add --msg-channel <n> option to openvpn to tell it which pipe to use
   to talk to the interactive service (used in tun.c for ifconfig + ARP flush,
   and route.c for routing)
 - add openvpn-msg.h with message definitions for talking to interactive service
 - routing in openvpn uses message-pipe automatically if --msg-channel <n> is
   configured, no other option needed
 - today, the integration in route.c and tun.c is windows-only, but could be adapted
   to other platforms

v2: Steffan Karger
 - Message-ID: <548D9046.5000600@...1856...>
 - include "openvpn-msg.h" not "include/openvpn-msg.h"
 - add $(top_srcdir)/include to openvpnsrv build for out-of-tree builds

v3: Gert Doering, rebasing and integrating review feedback
 - rebased to 417fe4a72c
 - r->metric_defined is now r->flags & RT_METRIC_DEFINED (c3ef2d2333fb)
 - move "openvpn-msg.h" include inside #ifdef WIN32 (windows-only right now)
 - hide "msg_channel" extra option inside tt->tuntap_options, so we do not
   need an extra argument to all the add/del_route...() functions
 - do_route_ipv6_service(): use r->adapter index (if set) for RGI6 routes

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
Signed-off-by: Gert Doering <gert@...1296...>
---
 configure.ac                  |    1 +
 include/Makefile.am           |    4 +-
 include/openvpn-msg.h         |  108 ++++
 src/openvpn/buffer.c          |    2 +-
 src/openvpn/init.c            |    6 +
 src/openvpn/options.c         |   18 +
 src/openvpn/options.h         |    1 +
 src/openvpn/route.c           |  317 +++++++---
 src/openvpn/route.h           |    1 +
 src/openvpn/tun.c             |  171 ++++--
 src/openvpn/tun.h             |    4 +
 src/openvpnserv/Makefile.am   |   14 +-
 src/openvpnserv/automatic.c   |  416 ++++++++++++++
 src/openvpnserv/common.c      |  211 +++++++
 src/openvpnserv/interactive.c | 1273 +++++++++++++++++++++++++++++++++++++++++
 src/openvpnserv/openvpnserv.c |  534 -----------------
 src/openvpnserv/service.c     |  861 +++++++---------------------
 src/openvpnserv/service.h     |  213 +++----
 18 files changed, 2706 insertions(+), 1449 deletions(-)
 create mode 100644 include/openvpn-msg.h
 create mode 100644 src/openvpnserv/automatic.c
 create mode 100644 src/openvpnserv/common.c
 create mode 100644 src/openvpnserv/interactive.c
 delete mode 100755 src/openvpnserv/openvpnserv.c

diff --git a/configure.ac b/configure.ac
index 7ff2435..6597194 100644
--- a/configure.ac
+++ b/configure.ac
@@ -58,6 +58,7 @@ m4_define([serial_tests], [
 AM_INIT_AUTOMAKE(foreign serial_tests) dnl NB: Do not [quote] this parameter.
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS
+AM_PROG_CC_C_O
 
 AC_ARG_ENABLE(
 	[lzo],
diff --git a/include/Makefile.am b/include/Makefile.am
index c5a91b1..498b3b5 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -13,4 +13,6 @@ MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in \
 	$(srcdir)/openvpn-plugin.h.in
 
-include_HEADERS = openvpn-plugin.h
+include_HEADERS = \
+	openvpn-plugin.h \
+	openvpn-msg.h
diff --git a/include/openvpn-msg.h b/include/openvpn-msg.h
new file mode 100644
index 0000000..0dcc72f
--- /dev/null
+++ b/include/openvpn-msg.h
@@ -0,0 +1,108 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2013 Heiko Hund <heiko.hund@...1489...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifndef OPENVPN_MSG_H_
+#define OPENVPN_MSG_H_
+
+typedef enum {
+  msg_acknowledgement,
+  msg_add_address,
+  msg_del_address,
+  msg_add_route,
+  msg_del_route,
+  msg_add_dns_cfg,
+  msg_del_dns_cfg,
+  msg_add_nbt_cfg,
+  msg_del_nbt_cfg,
+  msg_flush_neighbors
+} message_type_t;
+
+typedef struct {
+  message_type_t type;
+  size_t size;
+  int message_id;
+} message_header_t;
+
+typedef union {
+  struct in_addr ipv4;
+  struct in6_addr ipv6;
+} inet_address_t;
+
+typedef struct {
+  int index;
+  char name[256];
+} interface_t;
+
+typedef struct {
+  message_header_t header;
+  short family;
+  inet_address_t address;
+  int prefix_len;
+  interface_t iface;
+} address_message_t;
+
+typedef struct {
+  message_header_t header;
+  short family;
+  inet_address_t prefix;
+  int prefix_len;
+  inet_address_t gateway;
+  interface_t iface;
+  int metric;
+} route_message_t;
+
+typedef struct {
+  message_header_t header;
+  interface_t iface;
+  char domains[512];
+  struct in_addr primary_ipv4;
+  struct in_addr secondary_ipv4;
+  struct in_addr6 primary_ipv6;
+  struct in_addr6 secondary_ipv6;
+} dns_cfg_message_t;
+
+typedef struct {
+  message_header_t header;
+  interface_t iface;
+  int disable_nbt;
+  int nbt_type;
+  char scope_id[256];
+  struct in_addr primary_nbns;
+  struct in_addr secondary_nbns;
+} nbt_cfg_message_t;
+
+// TODO: NTP
+
+typedef struct {
+  message_header_t header;
+  short family;
+  interface_t iface;
+} flush_neighbors_message_t;
+
+typedef struct {
+  message_header_t header;
+  int error_number;
+} ack_message_t;
+
+#endif
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 421d60e..bc67d65 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -254,7 +254,7 @@ buf_puts(struct buffer *buf, const char *str)
  *
  * Return false on overflow.
  *
- * This function is duplicated into service-win32/openvpnserv.c
+ * This functionality is duplicated in src/openvpnserv/common.c
  * Any modifications here should be done to the other place as well.
  */
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2beec72..d0020b7 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1433,6 +1433,12 @@ do_open_tun (struct context *c)
       /* initialize (but do not open) tun/tap object */
       do_init_tun (c);
 
+#ifdef WIN32
+      /* store (hide) interactive service handle in tuntap_options */
+      c->c1.tuntap->options.msg_channel = c->options.msg_channel;
+      msg (D_ROUTE, "interactive service msg_channel=%u", (unsigned int) c->options.msg_channel);
+#endif
+
       /* allocate route list structure */
       do_alloc_route_list (c);
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b710c9c..6d97b4f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6015,6 +6015,24 @@ add_option (struct options *options,
     }
 #endif
 #endif
+  else if (streq (p[0], "msg-channel") && p[1])
+    {
+#ifdef WIN32
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      HANDLE process = GetCurrentProcess ();
+      HANDLE handle = (HANDLE) atoi (p[1]);
+      if (!DuplicateHandle (process, handle, process, &options->msg_channel, 0,
+                            FALSE, DUPLICATE_CLOSE_SOURCE | DUPLICATE_SAME_ACCESS))
+        {
+          msg (msglevel, "could not duplicate service pipe handle");
+          goto err;
+        }
+      options->route_method = ROUTE_METHOD_SERVICE;
+#else
+      msg (msglevel, "--msg-channel is only supported on Windows");
+      goto err;
+#endif
+    }
 #ifdef WIN32
   else if (streq (p[0], "win-sys") && p[1] && !p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 9e8a6a0..23d3992 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -581,6 +581,7 @@ struct options
   int foreign_option_index;
 
 #ifdef WIN32
+  HANDLE msg_channel;
   const char *exit_event_name;
   bool exit_event_initial_state;
   bool show_net_up;
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 2012b5c..0815176 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -50,7 +50,13 @@
 #endif
 
 #ifdef WIN32
+#include "openvpn-msg.h"
+
 #define METRIC_NOT_USED ((DWORD)-1)
+static bool add_route_service (const struct route_ipv4 *, const struct tuntap *);
+static bool del_route_service (const struct route_ipv4 *, const struct tuntap *);
+static bool add_route_ipv6_service (const struct route_ipv6 *, const struct tuntap *);
+static bool del_route_ipv6_service (const struct route_ipv6 *, const struct tuntap *);
 #endif
 
 static void delete_route (struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags, const struct route_gateway_info *rgi, const struct env_set *es);
@@ -1468,7 +1474,12 @@ add_route (struct route_ipv4 *r,
 
     argv_msg (D_ROUTE, &argv);
 
-    if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_IPAPI)
+    if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_SERVICE)
+      {
+        status = add_route_service (r, tt);
+        msg (D_ROUTE, "Route addition via service %s", status ? "succeeded" : "failed");
+      }
+    else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_IPAPI)
       {
 	status = add_route_ipapi (r, tt, ai);
 	msg (D_ROUTE, "Route addition via IPAPI %s", status ? "succeeded" : "failed");
@@ -1637,26 +1648,23 @@ add_route (struct route_ipv4 *r,
 }
 
 
-static const char * 
-print_in6_addr_netbits_only( struct in6_addr network_copy, int netbits, 
-                             struct gc_arena * gc)
+static void
+route_ipv6_clear_host_bits( struct route_ipv6 *r6 )
 {
   /* clear host bit parts of route 
    * (needed if routes are specified improperly, or if we need to 
    * explicitely setup/clear the "connected" network routes on some OSes)
    */
   int byte = 15;
-  int bits_to_clear = 128 - netbits;
+  int bits_to_clear = 128 - r6->netbits;
 
   while( byte >= 0 && bits_to_clear > 0 )
     {
       if ( bits_to_clear >= 8 )
-	{ network_copy.s6_addr[byte--] = 0; bits_to_clear -= 8; }
+	{ r6->network.s6_addr[byte--] = 0; bits_to_clear -= 8; }
       else
-	{ network_copy.s6_addr[byte--] &= (0xff << bits_to_clear); bits_to_clear = 0; }
+	{ r6->network.s6_addr[byte--] &= (0xff << bits_to_clear); bits_to_clear = 0; }
     }
-
-  return print_in6_addr( network_copy, 0, gc);
 }
 
 void
@@ -1687,7 +1695,9 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
   gc_init (&gc);
   argv_init (&argv);
 
-  network = print_in6_addr_netbits_only( r6->network, r6->netbits, &gc);
+  route_ipv6_clear_host_bits (r6);
+
+  network = print_in6_addr( r6->network, 0, &gc);
   gateway = print_in6_addr( r6->gateway, 0, &gc);
 
 #if defined(TARGET_DARWIN) || \
@@ -1770,51 +1780,56 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 
 #elif defined (WIN32)
 
-  struct buffer out = alloc_buf_gc (64, &gc);
-  if ( r6->adapter_index )		/* vpn server special route */
-    {
-      buf_printf (&out, "interface=%d", r6->adapter_index );
-      gateway_needed = true;
-    }
+  if (tt->options.msg_channel)
+    status = add_route_ipv6_service (r6, tt);
   else
     {
-      buf_printf (&out, "interface=%d", tt->adapter_index );
-    }
-  device = buf_bptr(&out);
-
-  /* netsh interface ipv6 add route 2001:db8::/32 MyTunDevice */
-  argv_printf (&argv, "%s%sc interface ipv6 add route %s/%d %s",
-	       get_win_sys_path(),
-	       NETSH_PATH_SUFFIX,
-	       network,
-	       r6->netbits,
-	       device);
+      struct buffer out = alloc_buf_gc (64, &gc);
+      if ( r6->adapter_index )		/* vpn server special route */
+	{
+	  buf_printf (&out, "interface=%d", r6->adapter_index );
+	  gateway_needed = true;
+	}
+      else
+	{
+	  buf_printf (&out, "interface=%d", tt->adapter_index );
+	}
+      device = buf_bptr(&out);
 
-  /* next-hop depends on TUN or TAP mode:
-   * - in TAP mode, we use the "real" next-hop
-   * - in TUN mode we use a special-case link-local address that the tapdrvr
-   *   knows about and will answer ND (neighbor discovery) packets for
-   */
-  if ( tt->type == DEV_TYPE_TUN && !gateway_needed )
-	argv_printf_cat( &argv, " %s", "fe80::8" );
-  else if ( !IN6_IS_ADDR_UNSPECIFIED(&r6->gateway) )
-	argv_printf_cat( &argv, " %s", gateway );
+      /* netsh interface ipv6 add route 2001:db8::/32 MyTunDevice */
+      argv_printf (&argv, "%s%sc interface ipv6 add route %s/%d %s",
+		   get_win_sys_path(),
+		   NETSH_PATH_SUFFIX,
+		   network,
+		   r6->netbits,
+		   device);
+
+      /* next-hop depends on TUN or TAP mode:
+       * - in TAP mode, we use the "real" next-hop
+       * - in TUN mode we use a special-case link-local address that the tapdrvr
+       *   knows about and will answer ND (neighbor discovery) packets for
+       */
+      if ( tt->type == DEV_TYPE_TUN && !gateway_needed )
+	    argv_printf_cat( &argv, " %s", "fe80::8" );
+      else if ( !IN6_IS_ADDR_UNSPECIFIED(&r6->gateway) )
+	    argv_printf_cat( &argv, " %s", gateway );
 
 #if 0
-  if (r6->flags & RT_METRIC_DEFINED)
-    argv_printf_cat (&argv, " METRIC %d", r->metric);
+      if (r6->flags & RT_METRIC_DEFINED)
+	argv_printf_cat (&argv, " METRIC %d", r->metric);
 #endif
 
-  /* in some versions of Windows, routes are persistent across reboots by
-   * default, unless "store=active" is set (pointed out by Tony Lim, thanks)
-   */
-  argv_printf_cat( &argv, " store=active" );
+      /* in some versions of Windows, routes are persistent across reboots by
+       * default, unless "store=active" is set (pointed out by Tony Lim, thanks)
+       */
+      argv_printf_cat( &argv, " store=active" );
 
-  argv_msg (D_ROUTE, &argv);
+      argv_msg (D_ROUTE, &argv);
 
-  netcmd_semaphore_lock ();
-  status = openvpn_execve_check (&argv, es, 0, "ERROR: Windows route add ipv6 command failed");
-  netcmd_semaphore_release ();
+      netcmd_semaphore_lock ();
+      status = openvpn_execve_check (&argv, es, 0, "ERROR: Windows route add ipv6 command failed");
+      netcmd_semaphore_release ();
+    }
 
 #elif defined (TARGET_SOLARIS)
 
@@ -1965,7 +1980,12 @@ delete_route (struct route_ipv4 *r,
 
   argv_msg (D_ROUTE, &argv);
 
-  if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_IPAPI)
+  if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_SERVICE)
+    {
+      const bool status = del_route_service (r, tt);
+      msg (D_ROUTE, "Route deletion via service %s", status ? "succeeded" : "failed");
+    }
+  else if ((flags & ROUTE_METHOD_MASK) == ROUTE_METHOD_IPAPI)
     {
       const bool status = del_route_ipapi (r, tt);
       msg (D_ROUTE, "Route deletion via IPAPI %s", status ? "succeeded" : "failed");
@@ -2107,7 +2127,7 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
   gc_init (&gc);
   argv_init (&argv);
 
-  network = print_in6_addr_netbits_only( r6->network, r6->netbits, &gc);
+  network = print_in6_addr( r6->network, 0, &gc);
   gateway = print_in6_addr( r6->gateway, 0, &gc);
 
 #if defined(TARGET_DARWIN) || \
@@ -2172,53 +2192,58 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
 
 #elif defined (WIN32)
 
-  struct buffer out = alloc_buf_gc (64, &gc);
-  if ( r6->adapter_index )		/* vpn server special route */
-    {
-      buf_printf (&out, "interface=%d", r6->adapter_index );
-      gateway_needed = true;
-    }
+  if (tt->options.msg_channel)
+    del_route_ipv6_service (r6, tt);
   else
     {
-      buf_printf (&out, "interface=%d", tt->adapter_index );
-    }
-  device = buf_bptr(&out);
+      struct buffer out = alloc_buf_gc (64, &gc);
+      if ( r6->adapter_index )		/* vpn server special route */
+	{
+	  buf_printf (&out, "interface=%d", r6->adapter_index );
+	  gateway_needed = true;
+	}
+      else
+	{
+	  buf_printf (&out, "interface=%d", tt->adapter_index );
+	}
+      device = buf_bptr(&out);
 
-  /* netsh interface ipv6 delete route 2001:db8::/32 MyTunDevice */
-  argv_printf (&argv, "%s%sc interface ipv6 delete route %s/%d %s",
-	       get_win_sys_path(),
-	       NETSH_PATH_SUFFIX,
-	       network,
-	       r6->netbits,
-	       device);
-
-  /* next-hop depends on TUN or TAP mode:
-   * - in TAP mode, we use the "real" next-hop
-   * - in TUN mode we use a special-case link-local address that the tapdrvr
-   *   knows about and will answer ND (neighbor discovery) packets for
-   * (and "route deletion without specifying next-hop" does not work...)
-   */
-  if ( tt->type == DEV_TYPE_TUN && !gateway_needed )
-	argv_printf_cat( &argv, " %s", "fe80::8" );
-  else if ( !IN6_IS_ADDR_UNSPECIFIED(&r6->gateway) )
-	argv_printf_cat( &argv, " %s", gateway );
+      /* netsh interface ipv6 delete route 2001:db8::/32 MyTunDevice */
+      argv_printf (&argv, "%s%sc interface ipv6 delete route %s/%d %s",
+		   get_win_sys_path(),
+		   NETSH_PATH_SUFFIX,
+		   network,
+		   r6->netbits,
+		   device);
+
+      /* next-hop depends on TUN or TAP mode:
+       * - in TAP mode, we use the "real" next-hop
+       * - in TUN mode we use a special-case link-local address that the tapdrvr
+       *   knows about and will answer ND (neighbor discovery) packets for
+       * (and "route deletion without specifying next-hop" does not work...)
+       */
+      if ( tt->type == DEV_TYPE_TUN && !gateway_needed )
+	    argv_printf_cat( &argv, " %s", "fe80::8" );
+      else if ( !IN6_IS_ADDR_UNSPECIFIED(&r6->gateway) )
+	    argv_printf_cat( &argv, " %s", gateway );
 
 #if 0
-  if (r6->flags & RT_METRIC_DEFINED)
-    argv_printf_cat (&argv, "METRIC %d", r->metric);
+      if (r6->flags & RT_METRIC_DEFINED)
+	argv_printf_cat (&argv, "METRIC %d", r->metric);
 #endif
 
-  /* Windows XP to 7 "just delete" routes, wherever they came from, but
-   * in Windows 8(.1?), if you create them with "store=active", this is
-   * how you should delete them as well (pointed out by Cedric Tabary)
-   */
-  argv_printf_cat( &argv, " store=active" );
+      /* Windows XP to 7 "just delete" routes, wherever they came from, but
+       * in Windows 8(.1?), if you create them with "store=active", this is
+       * how you should delete them as well (pointed out by Cedric Tabary)
+       */
+      argv_printf_cat( &argv, " store=active" );
 
-  argv_msg (D_ROUTE, &argv);
+      argv_msg (D_ROUTE, &argv);
 
-  netcmd_semaphore_lock ();
-  openvpn_execve_check (&argv, es, 0, "ERROR: Windows route delete ipv6 command failed");
-  netcmd_semaphore_release ();
+      netcmd_semaphore_lock ();
+      openvpn_execve_check (&argv, es, 0, "ERROR: Windows route delete ipv6 command failed");
+      netcmd_semaphore_release ();
+    }
 
 #elif defined (TARGET_SOLARIS)
 
@@ -2705,6 +2730,126 @@ del_route_ipapi (const struct route_ipv4 *r, const struct tuntap *tt)
   return ret;
 }
 
+static bool
+do_route_service (const bool add, const route_message_t *rt, const size_t size, HANDLE pipe)
+{
+  DWORD len;
+  bool ret = false;
+  ack_message_t ack;
+  struct gc_arena gc = gc_new ();
+
+  if (!WriteFile (pipe, rt, size, &len, NULL) ||
+      !ReadFile (pipe, &ack, sizeof (ack), &len, NULL))
+    {
+      msg (M_WARN, "ROUTE: could not talk to service: %s [%lu]",
+           strerror_win32 (GetLastError (), &gc), GetLastError ());
+      goto out;
+    }
+
+  if (ack.error_number != NO_ERROR)
+    {
+      msg (M_WARN, "ROUTE: route %s failed using service: %s [status=%u if_index=%lu]",
+           (add ? "addition" : "deletion"), strerror_win32 (ack.error_number, &gc),
+           ack.error_number, rt->iface.index);
+      goto out;
+    }
+
+  ret = true;
+
+out:
+  gc_free (&gc);
+  return ret;
+}
+
+static bool
+do_route_ipv4_service (const bool add, const struct route_ipv4 *r, const struct tuntap *tt)
+{
+  DWORD if_index = windows_route_find_if_index (r, tt);
+  if (if_index == ~0)
+    return false;
+
+  route_message_t msg = {
+    .header = {
+      (add ? msg_add_route : msg_del_route),
+      sizeof (route_message_t),
+      0 },
+    .family = AF_INET,
+    .prefix.ipv4.s_addr = htonl(r->network),
+    .gateway.ipv4.s_addr = htonl(r->gateway),
+    .iface = { .index = if_index, .name = "" },
+    .metric = (r->flags & RT_METRIC_DEFINED ? r->metric : -1)
+  };
+
+  netmask_to_netbits (r->network, r->netmask, &msg.prefix_len);
+  if (msg.prefix_len == -1)
+    msg.prefix_len = 32;
+
+  return do_route_service (add, &msg, sizeof (msg), tt->options.msg_channel);
+}
+
+static bool
+do_route_ipv6_service (const bool add, const struct route_ipv6 *r, const struct tuntap *tt)
+{
+  bool status;
+  route_message_t msg = {
+    .header = {
+      (add ? msg_add_route : msg_del_route),
+      sizeof (route_message_t),
+      0 },
+    .family = AF_INET6,
+    .prefix.ipv6 = r->network,
+    .prefix_len = r->netbits,
+    .gateway.ipv6 = r->gateway,
+    .iface = { .index = tt->adapter_index, .name = "" },
+    .metric = ( (r->flags & RT_METRIC_DEFINED) ? r->metric : -1)
+  };
+
+  if ( r->adapter_index )		/* vpn server special route */
+    msg.iface.index = r->adapter_index;
+
+  /* In TUN mode we use a special link-local address as the next hop.
+   * The tapdrvr knows about it and will answer neighbor discovery packets.
+   */
+  if (tt->type == DEV_TYPE_TUN)
+    inet_pton (AF_INET6, "fe80::8", &msg.gateway.ipv6);
+
+  if (msg.iface.index == TUN_ADAPTER_INDEX_INVALID)
+    {
+      strncpy (msg.iface.name, tt->actual_name, sizeof (msg.iface.name));
+      msg.iface.name[sizeof (msg.iface.name) - 1] = '\0';
+    }
+
+  status = do_route_service (add, &msg, sizeof (msg), tt->options.msg_channel);
+  msg (D_ROUTE, "IPv6 route %s via service %s",
+			add ? "addition" : "deletion",
+			status ? "succeeded" : "failed");
+  return status;
+}
+
+static bool
+add_route_service (const struct route_ipv4 *r, const struct tuntap *tt)
+{
+  return do_route_ipv4_service (true, r, tt);
+}
+
+static bool
+del_route_service (const struct route_ipv4 *r, const struct tuntap *tt)
+{
+  return do_route_ipv4_service (false, r, tt);
+}
+
+static bool
+add_route_ipv6_service (const struct route_ipv6 *r, const struct tuntap *tt)
+{
+  return do_route_ipv6_service (true, r, tt);
+}
+
+static bool
+del_route_ipv6_service (const struct route_ipv6 *r, const struct tuntap *tt)
+{
+  return do_route_ipv6_service (false, r, tt);
+}
+
 static const char *
 format_route_entry (const MIB_IPFORWARDROW *r, struct gc_arena *gc)
 {
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 4bbcdb7..58a5748 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -40,6 +40,7 @@
 #define ROUTE_METHOD_ADAPTIVE  0  /* try IP helper first then route.exe */
 #define ROUTE_METHOD_IPAPI     1  /* use IP helper API */
 #define ROUTE_METHOD_EXE       2  /* use route.exe */
+#define ROUTE_METHOD_SERVICE   3  /* use the privileged Windows service */
 #define ROUTE_METHOD_MASK      3
 #endif
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index efcd225..eaeb6cc 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -48,6 +48,11 @@
 #include "win32.h"
 
 #include "memdbg.h"
+
+#ifdef WIN32
+#include "openvpn-msg.h"
+#endif
+
 #include <string.h>
 
 #ifdef WIN32
@@ -69,6 +74,64 @@ static const char *netsh_get_id (const char *dev_node, struct gc_arena *gc);
 
 static DWORD get_adapter_index_flexible (const char *name);
 
+static bool
+do_address_service (const bool add, const short family, const struct tuntap *tt)
+{
+  DWORD len;
+  bool ret = false;
+  ack_message_t ack;
+  struct gc_arena gc = gc_new ();
+  HANDLE pipe = tt->options.msg_channel;
+
+  address_message_t addr = {
+    .header = {
+      (add ? msg_add_address : msg_del_address),
+      sizeof (address_message_t),
+      0 },
+    .family = family,
+    .iface = { .index = tt->adapter_index, .name = "" }
+  };
+
+  if (addr.iface.index == TUN_ADAPTER_INDEX_INVALID)
+    {
+      strncpy (addr.iface.name, tt->actual_name, sizeof (addr.iface.name));
+      addr.iface.name[sizeof (addr.iface.name) - 1] = '\0';
+    }
+
+  if (addr.family == AF_INET)
+    {
+      addr.address.ipv4.s_addr = tt->local;
+      addr.prefix_len = 32;
+    }
+  else
+    {
+      addr.address.ipv6 = tt->local_ipv6;
+      addr.prefix_len = tt->netbits_ipv6;
+    }
+
+  if (!WriteFile (pipe, &addr, sizeof (addr), &len, NULL) ||
+      !ReadFile (pipe, &ack, sizeof (ack), &len, NULL))
+    {
+      msg (M_WARN, "TUN: could not talk to service: %s [%lu]",
+           strerror_win32 (GetLastError (), &gc), GetLastError ());
+      goto out;
+    }
+
+  if (ack.error_number != NO_ERROR)
+    {
+      msg (M_WARN, "TUN: %s address failed using service: %s [status=%u if_index=%lu]",
+           (add ? "adding" : "deleting"), strerror_win32 (ack.error_number, &gc),
+           ack.error_number, addr.iface.index);
+      goto out;
+    }
+
+  ret = true;
+
+out:
+  gc_free (&gc);
+  return ret;
+}
+
 #endif
 
 #ifdef TARGET_SOLARIS
@@ -1301,7 +1364,6 @@ do_ifconfig (struct tuntap *tt,
 	tt->did_ifconfig = true;
       }
 
-    /* IPv6 always uses "netsh" interface */
     if ( do_ipv6 )
       {
 	char * saved_actual;
@@ -1314,16 +1376,6 @@ do_ifconfig (struct tuntap *tt,
 	idx = get_adapter_index_flexible(actual);
 	openvpn_snprintf(iface, sizeof(iface), "interface=%lu", idx);
 
-	/* example: netsh interface ipv6 set address interface=42 2001:608:8003::d store=active */
-	argv_printf (&argv,
-		     "%s%sc interface ipv6 set address %s %s store=active",
-		     get_win_sys_path(),
-		     NETSH_PATH_SUFFIX,
-		     iface,
-		     ifconfig_ipv6_local);
-	netsh_command (&argv, 4);
-
-	/* explicit route needed */
 	/* on windows, OpenVPN does ifconfig first, open_tun later, so
 	 * tt->actual_name might not yet be initialized, but routing code
 	 * needs to know interface name - point to "actual", restore later
@@ -1332,6 +1384,24 @@ do_ifconfig (struct tuntap *tt,
 	tt->actual_name = (char*) actual;
 	/* we use adapter_index in add_route_ipv6 */
 	tt->adapter_index = idx;
+
+	if (tt->options.msg_channel)
+	  {
+	    do_address_service (true, AF_INET6, tt);
+	  }
+	else
+	  {
+	    /* example: netsh interface ipv6 set address interface=42 2001:608:8003::d store=active */
+	    argv_printf (&argv,
+			 "%s%sc interface ipv6 set address %s %s store=active",
+			 get_win_sys_path(),
+			 NETSH_PATH_SUFFIX,
+			 iface,
+			 ifconfig_ipv6_local );
+	    netsh_command (&argv, 4);
+	  }
+
+	/* explicit route needed */
 	add_route_connected_v6_net(tt, es);
 	tt->actual_name = saved_actual;
       }
@@ -5403,13 +5473,35 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
     /* flush arp cache */
     if (index != TUN_ADAPTER_INDEX_INVALID)
       {
-	DWORD status;
+        DWORD status = -1;
 
-	if ((status = FlushIpNetTable (index)) == NO_ERROR)
+        if (tt->options.msg_channel)
+          {
+            ack_message_t ack;
+            flush_neighbors_message_t msg = {
+              .header = {
+                msg_flush_neighbors,
+                sizeof (flush_neighbors_message_t),
+                0 },
+              .family = AF_INET,
+              .iface = { .index = index, .name = "" }
+            };
+
+            if (!WriteFile (tt->options.msg_channel, &msg, sizeof (msg), &len, NULL) ||
+                !ReadFile (tt->options.msg_channel, &ack, sizeof (ack), &len, NULL))
+              msg (M_WARN, "TUN: could not talk to service: %s [%lu]",
+                   strerror_win32 (GetLastError (), &gc), GetLastError ());
+
+            status = ack.error_number;
+          }
+        else
+          status = FlushIpNetTable (index);
+
+	if (status == NO_ERROR)
 	  msg (M_INFO, "Successful ARP Flush on interface [%u] %s",
 	       (unsigned int)index,
 	       device_guid);
-	else
+	else if (status != -1)
 	  msg (D_TUNTAP_INFO, "NOTE: FlushIpNetTable failed on interface [%u] %s (status=%u) : %s",
 	       (unsigned int)index,
 	       device_guid,
@@ -5530,28 +5622,35 @@ close_tun (struct tuntap *tt)
     {
       if ( tt->ipv6 && tt->did_ifconfig_ipv6_setup )
         {
-	  const char *ifconfig_ipv6_local;
-	  struct argv argv;
-	  argv_init (&argv);
-
-	  /* remove route pointing to interface */
-	  delete_route_connected_v6_net(tt, NULL);
-
-	  /* "store=active" is needed in Windows 8(.1) to delete the
-	   * address we added (pointed out by Cedric Tabary).
-	   */
-
-	  /* netsh interface ipv6 delete address \"%s\" %s */
-	  ifconfig_ipv6_local = print_in6_addr (tt->local_ipv6, 0,  &gc);
-	  argv_printf (&argv,
-		    "%s%sc interface ipv6 delete address %s %s store=active",
-		     get_win_sys_path(),
-		     NETSH_PATH_SUFFIX,
-		     tt->actual_name,
-		     ifconfig_ipv6_local );
-
-	  netsh_command (&argv, 1);
-          argv_reset (&argv);
+          if (tt->options.msg_channel)
+            {
+              do_address_service (false, AF_INET6, tt);
+            }
+          else
+            {
+              const char *ifconfig_ipv6_local;
+              struct argv argv;
+              argv_init (&argv);
+
+              /* remove route pointing to interface */
+              delete_route_connected_v6_net(tt, NULL);
+
+              /* "store=active" is needed in Windows 8(.1) to delete the
+               * address we added (pointed out by Cedric Tabary).
+               */
+
+              /* netsh interface ipv6 delete address \"%s\" %s */
+              ifconfig_ipv6_local = print_in6_addr (tt->local_ipv6, 0,  &gc);
+              argv_printf (&argv,
+                           "%s%sc interface ipv6 delete address %s %s store=active",
+                           get_win_sys_path(),
+                           NETSH_PATH_SUFFIX,
+                           tt->actual_name,
+                           ifconfig_ipv6_local);
+
+              netsh_command (&argv, 1);
+              argv_reset (&argv);
+            }
 	}
 #if 1
       if (tt->ipapi_context_defined)
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 65bacac..4e93a3f 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -58,6 +58,10 @@ struct tuntap_options {
 # define IPW32_SET_N            5
   int ip_win32_type;
 
+#ifdef WIN32
+  HANDLE msg_channel;
+#endif
+
   /* --ip-win32 dynamic options */
   bool dhcp_masq_custom_offset;
   int dhcp_masq_offset;
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index a989c25..4bb1c27 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -17,11 +17,21 @@ EXTRA_DIST = \
 	openvpnserv.vcxproj \
 	openvpnserv.vcxproj.filters
 
+AM_CPPFLAGS = \
+	-I$(top_srcdir)/include
+
 if WIN32
 sbin_PROGRAMS = openvpnserv
+openvpnserv_CFLAGS = \
+	-municode -D_UNICODE \
+	-UNTDDI_VERSION -U_WIN32_WINNT \
+	-D_WIN32_WINNT=_WIN32_WINNT_VISTA
+openvpnserv_LDADD = -ladvapi32 -luserenv -liphlpapi -lws2_32
 endif
 
 openvpnserv_SOURCES = \
-	openvpnserv.c \
-	service.h service.c \
+        common.c \
+	automatic.c \
+	interactive.c \
+	service.c service.h \
 	openvpnserv_resources.rc
diff --git a/src/openvpnserv/automatic.c b/src/openvpnserv/automatic.c
new file mode 100644
index 0000000..4bd63fd
--- /dev/null
+++ b/src/openvpnserv/automatic.c
@@ -0,0 +1,416 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*
+ * This program allows one or more OpenVPN processes to be started
+ * as a service.  To build, you must get the service sample from the
+ * Platform SDK and replace Simple.c with this file.
+ *
+ * You should also apply service.patch to
+ * service.c and service.h from the Platform SDK service sample.
+ *
+ * This code is designed to be built with the mingw compiler.
+ */
+
+#include "service.h"
+
+#include <stdio.h>
+#include <stdarg.h>
+#include <process.h>
+
+/* bool definitions */
+#define bool int
+#define true 1
+#define false 0
+
+static SERVICE_STATUS_HANDLE service;
+static SERVICE_STATUS status;
+
+openvpn_service_t automatic_service = {
+  automatic,
+  TEXT(PACKAGE_NAME "Service"),
+  TEXT(PACKAGE_NAME " Service"),
+  TEXT(SERVICE_DEPENDENCIES),
+  SERVICE_DEMAND_START
+};
+
+struct security_attributes
+{
+  SECURITY_ATTRIBUTES sa;
+  SECURITY_DESCRIPTOR sd;
+};
+
+/*
+ * Which registry key in HKLM should
+ * we get config info from?
+ */
+#define REG_KEY "SOFTWARE\\" PACKAGE_NAME
+
+static HANDLE exit_event = NULL;
+
+/* clear an object */
+#define CLEAR(x) memset(&(x), 0, sizeof(x))
+
+
+bool
+init_security_attributes_allow_all (struct security_attributes *obj)
+{
+  CLEAR (*obj);
+
+  obj->sa.nLength = sizeof (SECURITY_ATTRIBUTES);
+  obj->sa.lpSecurityDescriptor = &obj->sd;
+  obj->sa.bInheritHandle = TRUE;
+  if (!InitializeSecurityDescriptor (&obj->sd, SECURITY_DESCRIPTOR_REVISION))
+    return false;
+  if (!SetSecurityDescriptorDacl (&obj->sd, TRUE, NULL, FALSE))
+    return false;
+  return true;
+}
+
+/*
+ * This event is initially created in the non-signaled
+ * state.  It will transition to the signaled state when
+ * we have received a terminate signal from the Service
+ * Control Manager which will cause an asynchronous call
+ * of ServiceStop below.
+ */
+#define EXIT_EVENT_NAME  TEXT(PACKAGE "_exit_1")
+
+HANDLE
+create_event (LPCTSTR name, bool allow_all, bool initial_state, bool manual_reset)
+{
+  if (allow_all)
+    {
+      struct security_attributes sa;
+      if (!init_security_attributes_allow_all (&sa))
+        return NULL;
+      return CreateEvent (&sa.sa, (BOOL)manual_reset, (BOOL)initial_state, name);
+    }
+  else
+    return CreateEvent (NULL, (BOOL)manual_reset, (BOOL)initial_state, name);
+}
+
+void
+close_if_open (HANDLE h)
+{
+  if (h != NULL)
+    CloseHandle (h);
+}
+
+static bool
+match (const WIN32_FIND_DATA *find, LPCTSTR ext)
+{
+  int i;
+
+  if (find->dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
+    return false;
+
+  if (!_tcslen (ext))
+    return true;
+
+  i = _tcslen (find->cFileName) - _tcslen (ext) - 1;
+  if (i < 1)
+    return false;
+
+  return find->cFileName[i] == '.' && !_tcsicmp (find->cFileName + i + 1, ext);
+}
+
+/*
+ * Modify the extension on a filename.
+ */
+static bool
+modext (LPTSTR dest, int size, LPCTSTR src, LPCTSTR newext)
+{
+  int i;
+
+  if (size > 0 && (_tcslen (src) + 1) <= size)
+    {
+      _tcscpy (dest, src);
+      dest [size - 1] = TEXT('\0');
+      i = _tcslen (dest);
+      while (--i >= 0)
+        {
+          if (dest[i] == TEXT('\\'))
+            break;
+          if (dest[i] == TEXT('.'))
+            {
+              dest[i] = TEXT('\0');
+              break;
+            }
+        }
+      if (_tcslen (dest) + _tcslen(newext) + 2 <= size)
+        {
+          _tcscat (dest, TEXT("."));
+          _tcscat (dest, newext);
+          return true;
+        }
+      dest[0] = TEXT('\0');
+    }
+  return false;
+}
+
+static DWORD WINAPI
+ServiceCtrlAutomatic (DWORD ctrl_code, DWORD event, LPVOID data, LPVOID ctx)
+{
+  SERVICE_STATUS *status = ctx;
+  switch (ctrl_code)
+    {
+    case SERVICE_CONTROL_STOP:
+      status->dwCurrentState = SERVICE_STOP_PENDING;
+      ReportStatusToSCMgr (service, status);
+      if (exit_event)
+        SetEvent (exit_event);
+      return NO_ERROR;
+
+    case SERVICE_CONTROL_INTERROGATE:
+      return NO_ERROR;
+
+    default:
+      return ERROR_CALL_NOT_IMPLEMENTED;
+    }
+}
+
+
+VOID WINAPI
+ServiceStartAutomatic (DWORD dwArgc, LPTSTR *lpszArgv)
+{
+  DWORD error = NO_ERROR;
+  settings_t settings;
+
+  service = RegisterServiceCtrlHandlerEx (automatic_service.name, ServiceCtrlAutomatic, &status);
+  if (!service)
+    return;
+
+  status.dwServiceType = SERVICE_WIN32_SHARE_PROCESS;
+  status.dwCurrentState = SERVICE_START_PENDING;
+  status.dwServiceSpecificExitCode = NO_ERROR;
+  status.dwWin32ExitCode = NO_ERROR;
+  status.dwWaitHint = 3000;
+
+  if (!ReportStatusToSCMgr(service, &status))
+    {
+      MsgToEventLog (M_ERR, TEXT("ReportStatusToSCMgr #1 failed"));
+      goto finish;
+    }
+
+  /*
+   * Create our exit event
+   */
+  exit_event = create_event (EXIT_EVENT_NAME, false, false, true);
+  if (!exit_event)
+    {
+      MsgToEventLog (M_ERR, TEXT("CreateEvent failed"));
+      goto finish;
+    }
+
+  /*
+   * If exit event is already signaled, it means we were not
+   * shut down properly.
+   */
+  if (WaitForSingleObject (exit_event, 0) != WAIT_TIMEOUT)
+    {
+      MsgToEventLog (M_ERR, TEXT("Exit event is already signaled -- we were not shut down properly"));
+      goto finish;
+    }
+
+  if (!ReportStatusToSCMgr(service, &status))
+    {
+      MsgToEventLog (M_ERR, TEXT("ReportStatusToSCMgr #2 failed"));
+      goto finish;
+    }
+
+  /*
+   * Read info from registry in key HKLM\SOFTWARE\OpenVPN
+   */
+  error = GetOpenvpnSettings (&settings);
+  if (error != ERROR_SUCCESS)
+    goto finish;
+
+  /*
+   * Instantiate an OpenVPN process for each configuration
+   * file found.
+   */
+  {
+    WIN32_FIND_DATA find_obj;
+    HANDLE find_handle;
+    BOOL more_files;
+    TCHAR find_string[MAX_PATH];
+
+    openvpn_sntprintf (find_string, MAX_PATH, TEXT("%s\\*"), settings.config_dir);
+
+    find_handle = FindFirstFile (find_string, &find_obj);
+    if (find_handle == INVALID_HANDLE_VALUE)
+      {
+        MsgToEventLog (M_ERR, TEXT("Cannot get configuration file list using: %s"), find_string);
+        goto finish;
+      }
+
+    /*
+     * Loop over each config file
+     */
+    do {
+      HANDLE log_handle = NULL;
+      STARTUPINFO start_info;
+      PROCESS_INFORMATION proc_info;
+      struct security_attributes sa;
+      TCHAR log_file[MAX_PATH];
+      TCHAR log_path[MAX_PATH];
+      TCHAR command_line[256];
+
+      CLEAR (start_info);
+      CLEAR (proc_info);
+      CLEAR (sa);
+
+      if (!ReportStatusToSCMgr(service, &status))
+        {
+          MsgToEventLog (M_ERR, TEXT("ReportStatusToSCMgr #3 failed"));
+          FindClose (find_handle);
+          goto finish;
+        }
+
+      /* does file have the correct type and extension? */
+      if (match (&find_obj, settings.ext_string))
+        {
+          /* get log file pathname */
+          if (!modext (log_file, _countof (log_file), find_obj.cFileName, TEXT("log")))
+            {
+              MsgToEventLog (M_ERR, TEXT("Cannot construct logfile name based on: %s"), find_obj.cFileName);
+              FindClose (find_handle);
+              goto finish;
+            }
+          openvpn_sntprintf (log_path, _countof (log_path),
+                             TEXT("%s\\%s"), settings.log_dir, log_file);
+
+          /* construct command line */
+          openvpn_sntprintf (command_line, _countof (command_line), TEXT(PACKAGE " --service %s 1 --config \"%s\""),
+                      EXIT_EVENT_NAME,
+                      find_obj.cFileName);
+
+          /* Make security attributes struct for logfile handle so it can
+             be inherited. */
+          if (!init_security_attributes_allow_all (&sa))
+            {
+              error = MsgToEventLog (M_SYSERR, TEXT("InitializeSecurityDescriptor start_" PACKAGE " failed"));
+              goto finish;
+            }
+
+          /* open logfile as stdout/stderr for soon-to-be-spawned subprocess */
+          log_handle = CreateFile (log_path,
+                                   GENERIC_WRITE,
+                                   FILE_SHARE_READ,
+                                   &sa.sa,
+                                   settings.append ? OPEN_ALWAYS : CREATE_ALWAYS,
+                                   FILE_ATTRIBUTE_NORMAL,
+                                   NULL);
+
+          if (log_handle == INVALID_HANDLE_VALUE)
+            {
+              error = MsgToEventLog (M_SYSERR, TEXT("Cannot open logfile: %s"), log_path);
+              FindClose (find_handle);
+              goto finish;
+            }
+
+          /* append to logfile? */
+          if (settings.append)
+            {
+              if (SetFilePointer (log_handle, 0, NULL, FILE_END) == INVALID_SET_FILE_POINTER)
+                {
+                  error = MsgToEventLog (M_SYSERR, TEXT("Cannot seek to end of logfile: %s"), log_path);
+                  FindClose (find_handle);
+                  goto finish;
+                }
+            }
+
+          /* fill in STARTUPINFO struct */
+          GetStartupInfo(&start_info);
+          start_info.cb = sizeof(start_info);
+          start_info.dwFlags = STARTF_USESTDHANDLES|STARTF_USESHOWWINDOW;
+          start_info.wShowWindow = SW_HIDE;
+          start_info.hStdInput = GetStdHandle(STD_INPUT_HANDLE);
+          start_info.hStdOutput = start_info.hStdError = log_handle;
+
+          /* create an OpenVPN process for one config file */
+          if (!CreateProcess(settings.exe_path,
+                             command_line,
+                             NULL,
+                             NULL,
+                             TRUE,
+                             settings.priority | CREATE_NEW_CONSOLE,
+                             NULL,
+                             settings.config_dir,
+                             &start_info,
+                             &proc_info))
+            {
+              error = MsgToEventLog (M_SYSERR, TEXT("CreateProcess failed, exe='%s' cmdline='%s' dir='%s'"),
+                   settings.exe_path,
+                   command_line,
+                   settings.config_dir);
+
+              FindClose (find_handle);
+              CloseHandle (log_handle);
+              goto finish;
+            }
+
+          /* close unneeded handles */
+          Sleep (1000); /* try to prevent race if we close logfile
+                           handle before child process DUPs it */
+          if (!CloseHandle (proc_info.hProcess)
+              || !CloseHandle (proc_info.hThread)
+              || !CloseHandle (log_handle))
+            {
+              error = MsgToEventLog (M_SYSERR, TEXT("CloseHandle failed"));
+              goto finish;
+            }
+        }
+
+      /* more files to process? */
+      more_files = FindNextFile (find_handle, &find_obj);
+
+    } while (more_files);
+
+    FindClose (find_handle);
+  }
+
+  /* we are now fully started */
+  status.dwCurrentState = SERVICE_RUNNING;
+  status.dwWaitHint = 0;
+  if (!ReportStatusToSCMgr(service, &status))
+    {
+      MsgToEventLog (M_ERR, TEXT("ReportStatusToSCMgr SERVICE_RUNNING failed"));
+      goto finish;
+    }
+
+  /* wait for our shutdown signal */
+  if (WaitForSingleObject (exit_event, INFINITE) != WAIT_OBJECT_0)
+    MsgToEventLog (M_ERR, TEXT("wait for shutdown signal failed"));
+
+finish:
+  if (exit_event)
+    CloseHandle (exit_event);
+
+  status.dwCurrentState = SERVICE_STOPPED;
+  status.dwWin32ExitCode = error;
+  ReportStatusToSCMgr (service, &status);
+}
+
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
new file mode 100644
index 0000000..a293796
--- /dev/null
+++ b/src/openvpnserv/common.c
@@ -0,0 +1,211 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2011 Heiko Hund <heiko.hund@...1489...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <service.h>
+
+/*
+ * These are necessary due to certain buggy implementations of (v)snprintf,
+ * that don't guarantee null termination for size > 0.
+ */
+int
+openvpn_vsntprintf (LPTSTR str, size_t size, LPCTSTR format, va_list arglist)
+{
+  int len = -1;
+  if (size > 0)
+    {
+      len = _vsntprintf (str, size, format, arglist);
+      str[size - 1] = 0;
+    }
+  return (len >= 0 && len < size);
+}
+int
+openvpn_sntprintf (LPTSTR str, size_t size, LPCTSTR format, ...)
+{
+  va_list arglist;
+  int len = -1;
+  if (size > 0)
+    {
+      va_start (arglist, format);
+      len = openvpn_vsntprintf (str, size, format, arglist);
+      va_end (arglist);
+    }
+  return len;
+}
+
+
+#define REG_KEY  TEXT("SOFTWARE\\" PACKAGE_NAME)
+
+static DWORD
+GetRegString (HKEY key, LPCTSTR value, LPTSTR data, DWORD size)
+{
+  DWORD type;
+  LONG status = RegQueryValueEx (key, value, NULL, &type, (LPBYTE) data, &size);
+
+  if (status == ERROR_SUCCESS && type != REG_SZ)
+    status = ERROR_DATATYPE_MISMATCH;
+
+  if (status != ERROR_SUCCESS)
+    {
+      SetLastError (status);
+      return MsgToEventLog (M_SYSERR, TEXT("Error querying registry value: HKLM\\%s\\%s"), REG_KEY, value);
+    }
+
+  return ERROR_SUCCESS;
+}
+
+
+DWORD
+GetOpenvpnSettings (settings_t *s)
+{
+  TCHAR priority[64];
+  TCHAR append[2];
+  DWORD error;
+  HKEY key;
+
+  LONG status = RegOpenKeyEx (HKEY_LOCAL_MACHINE, REG_KEY, 0, KEY_READ, &key);
+  if (status != ERROR_SUCCESS)
+    {
+      SetLastError (status);
+      return MsgToEventLog (M_SYSERR, TEXT("Could not open Registry key HKLM\\%s not found"), REG_KEY);
+    }
+
+  error = GetRegString (key, TEXT("exe_path"), s->exe_path, sizeof (s->exe_path));
+  if (error != ERROR_SUCCESS)
+    goto out;
+
+  error = GetRegString (key, TEXT("config_dir"), s->config_dir, sizeof (s->config_dir));
+  if (error != ERROR_SUCCESS)
+    goto out;
+
+  error = GetRegString (key, TEXT("config_ext"), s->ext_string, sizeof (s->ext_string));
+  if (error != ERROR_SUCCESS)
+    goto out;
+
+  error = GetRegString (key, TEXT("log_dir"), s->log_dir, sizeof (s->log_dir));
+  if (error != ERROR_SUCCESS)
+    goto out;
+
+  error = GetRegString (key, TEXT("priority"), priority, sizeof (priority));
+  if (error != ERROR_SUCCESS)
+    goto out;
+
+  error = GetRegString (key, TEXT("log_append"), append, sizeof (append));
+  if (error != ERROR_SUCCESS)
+    goto out;
+
+  /* set process priority */
+  if (!_tcsicmp (priority, TEXT("IDLE_PRIORITY_CLASS")))
+    s->priority = IDLE_PRIORITY_CLASS;
+  else if (!_tcsicmp (priority, TEXT("BELOW_NORMAL_PRIORITY_CLASS")))
+    s->priority = BELOW_NORMAL_PRIORITY_CLASS;
+  else if (!_tcsicmp (priority, TEXT("NORMAL_PRIORITY_CLASS")))
+    s->priority = NORMAL_PRIORITY_CLASS;
+  else if (!_tcsicmp (priority, TEXT("ABOVE_NORMAL_PRIORITY_CLASS")))
+    s->priority = ABOVE_NORMAL_PRIORITY_CLASS;
+  else if (!_tcsicmp (priority, TEXT("HIGH_PRIORITY_CLASS")))
+    s->priority = HIGH_PRIORITY_CLASS;
+  else
+    {
+      SetLastError (ERROR_INVALID_DATA);
+      error = MsgToEventLog (M_SYSERR, TEXT("Unknown priority name: %s"), priority);
+      goto out;
+    }
+
+  /* set log file append/truncate flag */
+  if (append[0] == TEXT('0'))
+    s->append = FALSE;
+  else if (append[0] == TEXT('1'))
+    s->append = TRUE;
+  else
+    {
+      SetLastError (ERROR_INVALID_DATA);
+      error = MsgToEventLog (M_ERR, TEXT("Log file append flag (given as '%s') must be '0' or '1'"), append);
+      goto out;
+    }
+
+out:
+  RegCloseKey (key);
+  return error;
+}
+
+
+LPCTSTR
+GetLastErrorText ()
+{
+  static TCHAR buf[256];
+  DWORD len;
+  LPTSTR tmp = NULL;
+
+  len = FormatMessage (FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ARGUMENT_ARRAY,
+                       NULL, GetLastError(), LANG_NEUTRAL, (LPTSTR)&tmp, 0, NULL);
+
+  if (len == 0 || (long) _countof (buf) < (long) len + 14)
+    buf[0] = TEXT('\0');
+  else
+    {
+      tmp[_tcslen (tmp) - 2] = TEXT('\0');  /* remove CR/LF characters */
+      openvpn_sntprintf (buf, _countof (buf), TEXT("%s (0x%x)"), tmp, GetLastError());
+    }
+
+  if (tmp)
+    LocalFree (tmp);
+
+  return buf;
+}
+
+
+DWORD
+MsgToEventLog (DWORD flags, LPCTSTR format, ...)
+{
+  HANDLE hEventSource;
+  TCHAR msg[2][256];
+  DWORD error = 0;
+  LPCTSTR err_msg = TEXT("");
+  va_list arglist;
+
+  if (flags & MSG_FLAGS_SYS_CODE)
+    {
+      error = GetLastError ();
+      err_msg = GetLastErrorText ();
+    }
+
+  hEventSource = RegisterEventSource (NULL, APPNAME);
+  if (hEventSource != NULL)
+    {
+      openvpn_sntprintf (msg[0], _countof (msg[0]),
+                         TEXT("%s error: %s"), APPNAME, err_msg);
+
+      va_start (arglist, format);
+      openvpn_vsntprintf (msg[1], _countof (msg[1]), format, arglist);
+      va_end (arglist);
+
+      const TCHAR *mesg[] = { msg[0], msg[1] };
+      ReportEvent (hEventSource, flags & MSG_FLAGS_ERROR ?
+                   EVENTLOG_ERROR_TYPE : EVENTLOG_INFORMATION_TYPE,
+                   0, 0, NULL, 2, 0, mesg, NULL);
+      DeregisterEventSource (hEventSource);
+    }
+
+  return error;
+}
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
new file mode 100644
index 0000000..0040d85
--- /dev/null
+++ b/src/openvpnserv/interactive.c
@@ -0,0 +1,1273 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2012 Heiko Hund <heiko.hund@...1489...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+
+#include "service.h"
+
+#include <winsock2.h>
+#include <ws2tcpip.h>
+#include <iphlpapi.h>
+#include <userenv.h>
+#include <accctrl.h>
+#include <aclapi.h>
+#include <stdio.h>
+#include <sddl.h>
+
+#include "openvpn-msg.h"
+
+#define IO_TIMEOUT  2000 /*ms*/
+
+#define ERROR_OPENVPN_STARTUP  0x20000000
+#define ERROR_STARTUP_DATA     0x20000001
+#define ERROR_MESSAGE_DATA     0x20000002
+#define ERROR_MESSAGE_TYPE     0x20000003
+
+static SERVICE_STATUS_HANDLE service;
+static SERVICE_STATUS status;
+static HANDLE exit_event = NULL;
+static settings_t settings;
+
+openvpn_service_t interactive_service = {
+  interactive,
+  TEXT(PACKAGE_NAME "ServiceInteractive"),
+  TEXT(PACKAGE_NAME " Interactive Service"),
+  TEXT(SERVICE_DEPENDENCIES),
+  SERVICE_AUTO_START
+};
+
+
+typedef struct {
+  WCHAR *directory;
+  WCHAR *options;
+  WCHAR *std_input;
+} STARTUP_DATA;
+
+
+/* Datatype for linked lists */
+typedef struct _list_item {
+  struct _list_item *next;
+  LPVOID data;
+} list_item_t;
+
+
+/* Datatypes for undo information */
+typedef enum {
+  address,
+  route,
+  _undo_type_max
+} undo_type_t;
+typedef list_item_t* undo_lists_t[_undo_type_max];
+
+
+static DWORD
+AddListItem (list_item_t **pfirst, LPVOID data)
+{
+  list_item_t *new_item = malloc (sizeof (list_item_t));
+  if (new_item == NULL)
+    return ERROR_OUTOFMEMORY;
+
+  new_item->next = *pfirst;
+  new_item->data = data;
+
+  *pfirst = new_item;
+  return NO_ERROR;
+}
+
+typedef BOOL (*match_fn_t) (LPVOID item, LPVOID ctx);
+
+static LPVOID
+RemoveListItem (list_item_t **pfirst, match_fn_t match, LPVOID ctx)
+{
+  LPVOID data = NULL;
+  list_item_t **pnext;
+
+  for (pnext = pfirst; *pnext; pnext = &(*pnext)->next)
+    {
+      list_item_t *item = *pnext;
+      if (!match (item->data, ctx))
+        continue;
+
+      /* Found item, remove from the list and free memory */
+      *pnext = item->next;
+      data = item->data;
+      free (item);
+      break;
+    }
+  return data;
+}
+
+
+static HANDLE
+CloseHandleEx (LPHANDLE handle)
+{
+  if (handle && *handle && *handle != INVALID_HANDLE_VALUE)
+    {
+      CloseHandle (*handle);
+      *handle = INVALID_HANDLE_VALUE;
+    }
+  return INVALID_HANDLE_VALUE;
+}
+
+
+static HANDLE
+InitOverlapped (LPOVERLAPPED overlapped)
+{
+  ZeroMemory (overlapped, sizeof (OVERLAPPED));
+  overlapped->hEvent = CreateEvent (NULL, TRUE, FALSE, NULL);
+  return overlapped->hEvent;
+}
+
+
+static BOOL
+ResetOverlapped (LPOVERLAPPED overlapped)
+{
+  HANDLE io_event = overlapped->hEvent;
+  if (!ResetEvent (io_event))
+    return FALSE;
+  ZeroMemory (overlapped, sizeof (OVERLAPPED));
+  overlapped->hEvent = io_event;
+  return TRUE;
+}
+
+
+typedef enum {
+  peek,
+  read,
+  write
+} async_op_t;
+
+static DWORD
+AsyncPipeOp (async_op_t op, HANDLE pipe, LPVOID buffer, DWORD size, DWORD count, LPHANDLE events)
+{
+  int i;
+  BOOL success;
+  HANDLE io_event;
+  DWORD res, bytes = 0;
+  OVERLAPPED overlapped;
+  LPHANDLE handles = NULL;
+
+  io_event = InitOverlapped (&overlapped);
+  if (!io_event)
+    goto out;
+
+  handles = malloc ((count + 1) * sizeof (HANDLE));
+  if (!handles)
+    goto out;
+
+  if (op == write)
+    success = WriteFile (pipe, buffer, size, NULL, &overlapped);
+  else
+    success = ReadFile (pipe, buffer, size, NULL, &overlapped);
+  if (!success && GetLastError () != ERROR_IO_PENDING && GetLastError () != ERROR_MORE_DATA)
+    goto out;
+
+  handles[0] = io_event;
+  for (i = 0; i < count; i++)
+    handles[i + 1] = events[i];
+
+  res = WaitForMultipleObjects (count + 1, handles, FALSE,
+                                op == peek ? INFINITE : IO_TIMEOUT);
+  if (res != WAIT_OBJECT_0)
+    {
+      CancelIo (pipe);
+      goto out;
+    }
+
+  if (op == peek)
+    PeekNamedPipe (pipe, NULL, 0, NULL, &bytes, NULL);
+  else
+    GetOverlappedResult (pipe, &overlapped, &bytes, TRUE);
+
+out:
+  CloseHandleEx (&io_event);
+  free (handles);
+  return bytes;
+}
+
+static DWORD
+PeekNamedPipeAsync (HANDLE pipe, DWORD count, LPHANDLE events)
+{
+  return AsyncPipeOp (peek, pipe, NULL, 0, count, events);
+}
+
+static DWORD
+ReadPipeAsync (HANDLE pipe, LPVOID buffer, DWORD size, DWORD count, LPHANDLE events)
+{
+  return AsyncPipeOp (read, pipe, buffer, size, count, events);
+}
+
+static DWORD
+WritePipeAsync (HANDLE pipe, LPVOID data, DWORD size, DWORD count, LPHANDLE events)
+{
+  return AsyncPipeOp (write, pipe, data, size, count, events);
+}
+
+
+static VOID
+ReturnError (HANDLE pipe, DWORD error, LPCWSTR func, DWORD count, LPHANDLE events)
+{
+  DWORD result_len;
+  LPWSTR result = L"0xffffffff\nFormatMessage failed\nCould not return result";
+  DWORD_PTR args[] = {
+    (DWORD_PTR) error,
+    (DWORD_PTR) func,
+    (DWORD_PTR) ""
+  };
+
+  if (error != ERROR_OPENVPN_STARTUP)
+    {
+      FormatMessageW (FORMAT_MESSAGE_FROM_SYSTEM |
+                      FORMAT_MESSAGE_ALLOCATE_BUFFER |
+                      FORMAT_MESSAGE_IGNORE_INSERTS,
+                      0, error, 0, (LPWSTR) &args[2], 0, NULL);
+    }
+
+  result_len = FormatMessageW (FORMAT_MESSAGE_FROM_STRING |
+                               FORMAT_MESSAGE_ALLOCATE_BUFFER |
+                               FORMAT_MESSAGE_ARGUMENT_ARRAY,
+                               L"0x%1!08x!\n%2!s!\n%3!s!", 0, 0,
+                               (LPWSTR) &result, 0, (va_list*) args);
+
+  WritePipeAsync (pipe, result, wcslen (result) * 2, count, events);
+#ifdef UNICODE
+  MsgToEventLog (MSG_FLAGS_ERROR, result);
+#else
+  MsgToEventLog (MSG_FLAGS_ERROR, "%S", result);
+#endif
+
+  if (error != ERROR_OPENVPN_STARTUP)
+    LocalFree ((LPVOID) args[2]);
+  if (result_len)
+    LocalFree (result);
+}
+
+
+static VOID
+ReturnLastError (HANDLE pipe, LPCWSTR func)
+{
+  ReturnError (pipe, GetLastError (), func, 1, &exit_event);
+}
+
+
+static VOID
+ReturnOpenvpnOutput (HANDLE pipe, HANDLE ovpn_output, DWORD count, LPHANDLE events)
+{
+  WCHAR *wide_output = NULL;
+  CHAR output[512];
+  DWORD size;
+
+  ReadFile (ovpn_output, output, sizeof (output), &size, NULL);
+  if (size == 0)
+    return;
+
+  wide_output = malloc ((size) * sizeof (WCHAR));
+  if (wide_output)
+    {
+      MultiByteToWideChar (CP_UTF8, 0, output, size, wide_output, size);
+      wide_output[size - 1] = 0;
+    }
+
+  ReturnError (pipe, ERROR_OPENVPN_STARTUP, wide_output, count, events);
+  free (wide_output);
+}
+
+
+static BOOL
+GetStartupData (HANDLE pipe, STARTUP_DATA *sud)
+{
+  size_t len;
+  BOOL ret = FALSE;
+  WCHAR *data = NULL;
+  DWORD size, bytes, read;
+
+  bytes = PeekNamedPipeAsync (pipe, 1, &exit_event);
+  if (bytes == 0)
+    {
+      MsgToEventLog (M_SYSERR, TEXT("PeekNamedPipeAsync failed"));
+      ReturnLastError (pipe, L"PeekNamedPipeAsync");
+      goto out;
+    }
+
+  size = bytes / sizeof (*data);
+  data = malloc (bytes);
+  if (data == NULL)
+    {
+      MsgToEventLog (M_SYSERR, TEXT("malloc failed"));
+      ReturnLastError (pipe, L"malloc");
+      goto out;
+    }
+
+  read = ReadPipeAsync (pipe, data, bytes, 1, &exit_event);
+  if (bytes != read)
+  {
+      MsgToEventLog (M_SYSERR, TEXT("ReadPipeAsync failed"));
+      ReturnLastError (pipe, L"ReadPipeAsync");
+      goto out;
+  }
+
+  if (data[size - 1] != 0)
+    {
+      MsgToEventLog (M_ERR, TEXT("Startup data is not NULL terminated"));
+      ReturnError (pipe, ERROR_STARTUP_DATA, L"GetStartupData", 1, &exit_event);
+      goto out;
+    }
+
+  sud->directory = data;
+  len = wcslen (sud->directory) + 1;
+  size -= len;
+  if (size <= 0)
+    {
+      MsgToEventLog (M_ERR, TEXT("Startup data ends at working directory"));
+      ReturnError (pipe, ERROR_STARTUP_DATA, L"GetStartupData", 1, &exit_event);
+      goto out;
+    }
+
+  sud->options = sud->directory + len;
+  len = wcslen (sud->options) + 1;
+  size -= len;
+  if (size <= 0)
+    {
+      MsgToEventLog (M_ERR, TEXT("Startup data ends at command line options"));
+      ReturnError (pipe, ERROR_STARTUP_DATA, L"GetStartupData", 1, &exit_event);
+      goto out;
+    }
+
+  sud->std_input = sud->options + len;
+  data = NULL; /* don't free data */
+  ret = TRUE;
+
+out:
+  free (data);
+  return ret;
+}
+
+
+static VOID
+FreeStartupData (STARTUP_DATA *sud)
+{
+  free (sud->directory);
+}
+
+
+static SOCKADDR_INET
+sockaddr_inet (short family, inet_address_t *addr)
+{
+  SOCKADDR_INET sa_inet;
+  ZeroMemory (&sa_inet, sizeof (sa_inet));
+  sa_inet.si_family = family;
+  if (family == AF_INET)
+    sa_inet.Ipv4.sin_addr = addr->ipv4;
+  else if (family == AF_INET6)
+    sa_inet.Ipv6.sin6_addr = addr->ipv6;
+  return sa_inet;
+}
+
+static DWORD
+InterfaceLuid (const char *iface_name, PNET_LUID luid)
+{
+  NETIO_STATUS status;
+  LPWSTR wide_name;
+  int n;
+
+  typedef NETIO_STATUS WINAPI (*ConvertInterfaceAliasToLuidFn) (LPCWSTR, PNET_LUID);
+  static ConvertInterfaceAliasToLuidFn ConvertInterfaceAliasToLuid = NULL;
+  if (!ConvertInterfaceAliasToLuid)
+    {
+      HMODULE iphlpapi = GetModuleHandle (TEXT("iphlpapi.dll"));
+      if (iphlpapi == NULL)
+        return GetLastError ();
+
+      ConvertInterfaceAliasToLuid = (ConvertInterfaceAliasToLuidFn) GetProcAddress (iphlpapi, "ConvertInterfaceAliasToLuid");
+      if (!ConvertInterfaceAliasToLuid)
+        return GetLastError ();
+    }
+
+  n = MultiByteToWideChar (CP_UTF8, 0, iface_name, -1, NULL, 0);
+  wide_name = malloc (n * sizeof (WCHAR));
+  MultiByteToWideChar (CP_UTF8, 0, iface_name, -1, wide_name, n);
+  status = ConvertInterfaceAliasToLuid (wide_name, luid);
+  free (wide_name);
+
+  return status;
+}
+
+static BOOL
+CmpAddress (LPVOID item, LPVOID address)
+{
+  return memcmp (item, address, sizeof (MIB_UNICASTIPADDRESS_ROW)) == 0 ? TRUE : FALSE;
+}
+
+static DWORD
+DeleteAddress (PMIB_UNICASTIPADDRESS_ROW addr_row)
+{
+  typedef NETIOAPI_API (*DeleteUnicastIpAddressEntryFn) (const PMIB_UNICASTIPADDRESS_ROW);
+  static DeleteUnicastIpAddressEntryFn DeleteUnicastIpAddressEntry = NULL;
+
+  if (!DeleteUnicastIpAddressEntry)
+    {
+      HMODULE iphlpapi = GetModuleHandle (TEXT("iphlpapi.dll"));
+      if (iphlpapi == NULL)
+        return GetLastError ();
+
+      DeleteUnicastIpAddressEntry = (DeleteUnicastIpAddressEntryFn) GetProcAddress (iphlpapi, "DeleteUnicastIpAddressEntry");
+      if (!DeleteUnicastIpAddressEntry)
+        return GetLastError ();
+    }
+
+  return DeleteUnicastIpAddressEntry (addr_row);
+}
+
+static DWORD
+HandleAddressMessage (address_message_t *msg, undo_lists_t *lists)
+{
+  DWORD err;
+  PMIB_UNICASTIPADDRESS_ROW addr_row;
+  BOOL add = msg->header.type == msg_add_address;
+
+  typedef NETIOAPI_API (*CreateUnicastIpAddressEntryFn) (const PMIB_UNICASTIPADDRESS_ROW);
+  typedef NETIOAPI_API (*InitializeUnicastIpAddressEntryFn) (PMIB_UNICASTIPADDRESS_ROW);
+  static CreateUnicastIpAddressEntryFn CreateUnicastIpAddressEntry = NULL;
+  static InitializeUnicastIpAddressEntryFn InitializeUnicastIpAddressEntry = NULL;
+
+  if (!CreateUnicastIpAddressEntry || !InitializeUnicastIpAddressEntry)
+    {
+      HMODULE iphlpapi = GetModuleHandle (TEXT("iphlpapi.dll"));
+      if (iphlpapi == NULL)
+        return GetLastError ();
+
+      CreateUnicastIpAddressEntry = (CreateUnicastIpAddressEntryFn) GetProcAddress (iphlpapi, "CreateUnicastIpAddressEntry");
+      if (!CreateUnicastIpAddressEntry)
+        return GetLastError ();
+
+      InitializeUnicastIpAddressEntry = (InitializeUnicastIpAddressEntryFn) GetProcAddress (iphlpapi, "InitializeUnicastIpAddressEntry");
+      if (!InitializeUnicastIpAddressEntry)
+        return GetLastError ();
+    }
+
+  addr_row = malloc (sizeof (*addr_row));
+  if (addr_row == NULL)
+    return ERROR_OUTOFMEMORY;
+
+  InitializeUnicastIpAddressEntry (addr_row);
+  addr_row->Address = sockaddr_inet (msg->family, &msg->address);
+  addr_row->OnLinkPrefixLength = (UINT8) msg->prefix_len;
+
+  if (msg->iface.index != -1)
+    {
+      addr_row->InterfaceIndex = msg->iface.index;
+    }
+  else
+    {
+      NET_LUID luid;
+      err = InterfaceLuid (msg->iface.name, &luid);
+      if (err)
+        goto out;
+      addr_row->InterfaceLuid = luid;
+    }
+
+  if (add)
+    {
+      err = CreateUnicastIpAddressEntry (addr_row);
+      if (err)
+        goto out;
+
+      err = AddListItem (&(*lists)[address], addr_row);
+      if (err)
+        DeleteAddress (addr_row);
+    }
+  else
+    {
+      err = DeleteAddress (addr_row);
+      if (err)
+        goto out;
+
+      free (RemoveListItem (&(*lists)[address], CmpAddress, addr_row));
+    }
+
+out:
+  if (!add || err)
+    free (addr_row);
+
+  return err;
+}
+
+
+static BOOL
+CmpRoute (LPVOID item, LPVOID route)
+{
+  return memcmp (item, route, sizeof (MIB_IPFORWARD_ROW2)) == 0 ? TRUE : FALSE;
+}
+
+static DWORD
+DeleteRoute (PMIB_IPFORWARD_ROW2 fwd_row)
+{
+  typedef NETIOAPI_API (*DeleteIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW2);
+  static DeleteIpForwardEntry2Fn DeleteIpForwardEntry2 = NULL;
+
+  if (!DeleteIpForwardEntry2)
+    {
+      HMODULE iphlpapi = GetModuleHandle (TEXT("iphlpapi.dll"));
+      if (iphlpapi == NULL)
+        return GetLastError ();
+
+      DeleteIpForwardEntry2 = (DeleteIpForwardEntry2Fn) GetProcAddress (iphlpapi, "DeleteIpForwardEntry2");
+      if (!DeleteIpForwardEntry2)
+        return GetLastError ();
+    }
+
+  return DeleteIpForwardEntry2 (fwd_row);
+}
+
+static DWORD
+HandleRouteMessage (route_message_t *msg, undo_lists_t *lists)
+{
+  DWORD err;
+  PMIB_IPFORWARD_ROW2 fwd_row;
+  BOOL add = msg->header.type == msg_add_route;
+
+  typedef NETIOAPI_API (*CreateIpForwardEntry2Fn) (PMIB_IPFORWARD_ROW2);
+  static CreateIpForwardEntry2Fn CreateIpForwardEntry2 = NULL;
+
+  if (!CreateIpForwardEntry2)
+    {
+      HMODULE iphlpapi = GetModuleHandle (TEXT("iphlpapi.dll"));
+      if (iphlpapi == NULL)
+        return GetLastError ();
+
+      CreateIpForwardEntry2 = (CreateIpForwardEntry2Fn) GetProcAddress (iphlpapi, "CreateIpForwardEntry2");
+      if (!CreateIpForwardEntry2)
+        return GetLastError ();
+    }
+
+  fwd_row = malloc (sizeof (*fwd_row));
+  if (fwd_row == NULL)
+    return ERROR_OUTOFMEMORY;
+
+  ZeroMemory (fwd_row, sizeof (*fwd_row));
+  fwd_row->ValidLifetime = 0xffffffff;
+  fwd_row->PreferredLifetime = 0xffffffff;
+  fwd_row->Protocol = MIB_IPPROTO_NETMGMT;
+  fwd_row->Metric = msg->metric;
+  fwd_row->DestinationPrefix.Prefix = sockaddr_inet (msg->family, &msg->prefix);
+  fwd_row->DestinationPrefix.PrefixLength = (UINT8) msg->prefix_len;
+  fwd_row->NextHop = sockaddr_inet (msg->family, &msg->gateway);
+
+  if (msg->iface.index != -1)
+    {
+      fwd_row->InterfaceIndex = msg->iface.index;
+    }
+  else if (strlen (msg->iface.name))
+    {
+      NET_LUID luid;
+      err = InterfaceLuid (msg->iface.name, &luid);
+      if (err)
+        goto out;
+      fwd_row->InterfaceLuid = luid;
+    }
+
+  if (add)
+    {
+      err = CreateIpForwardEntry2 (fwd_row);
+      if (err)
+        goto out;
+
+      err = AddListItem (&(*lists)[route], fwd_row);
+      if (err)
+        DeleteRoute (fwd_row);
+    }
+  else
+    {
+      err = DeleteRoute (fwd_row);
+      if (err)
+        goto out;
+
+      free (RemoveListItem (&(*lists)[route], CmpRoute, fwd_row));
+    }
+
+out:
+  if (!add || err)
+    free (fwd_row);
+
+  return err;
+}
+
+
+static DWORD
+HandleFlushNeighborsMessage (flush_neighbors_message_t *msg)
+{
+  typedef NETIOAPI_API (*FlushIpNetTable2Fn) (ADDRESS_FAMILY, NET_IFINDEX);
+  static FlushIpNetTable2Fn flush_fn = NULL;
+
+  if (msg->family == AF_INET)
+    return FlushIpNetTable (msg->iface.index);
+
+  if (!flush_fn)
+    {
+      HMODULE iphlpapi = GetModuleHandle (TEXT("iphlpapi.dll"));
+      if (iphlpapi == NULL)
+        return GetLastError ();
+
+      flush_fn = (FlushIpNetTable2Fn) GetProcAddress (iphlpapi, "FlushIpNetTable2");
+      if (!flush_fn)
+        {
+          if (GetLastError () == ERROR_PROC_NOT_FOUND)
+            return WSAEPFNOSUPPORT;
+          else
+            return GetLastError ();
+        }
+    }
+  return flush_fn (msg->family, msg->iface.index);
+}
+
+
+static VOID
+HandleMessage (HANDLE pipe, DWORD bytes, DWORD count, LPHANDLE events, undo_lists_t *lists)
+{
+  DWORD read;
+  union {
+    message_header_t header;
+    address_message_t address;
+    route_message_t route;
+    flush_neighbors_message_t flush_neighbors;
+  } msg;
+  ack_message_t ack = {
+    .header = {
+      .type = msg_acknowledgement,
+      .size = sizeof (ack),
+      .message_id = -1
+    },
+    .error_number = ERROR_MESSAGE_DATA
+  };
+
+  read = ReadPipeAsync (pipe, &msg, bytes, count, events);
+  if (read != bytes || read < sizeof (msg.header) || read != msg.header.size)
+    goto out;
+
+  ack.header.message_id = msg.header.message_id;
+
+  switch (msg.header.type)
+    {
+    case msg_add_address:
+    case msg_del_address:
+      if (msg.header.size == sizeof (msg.address))
+        ack.error_number = HandleAddressMessage (&msg.address, lists);
+      break;
+
+    case msg_add_route:
+    case msg_del_route:
+      if (msg.header.size == sizeof (msg.route))
+        ack.error_number = HandleRouteMessage (&msg.route, lists);
+      break;
+
+    case msg_flush_neighbors:
+      if (msg.header.size == sizeof (msg.flush_neighbors))
+        ack.error_number = HandleFlushNeighborsMessage (&msg.flush_neighbors);
+      break;
+
+    default:
+      ack.error_number = ERROR_MESSAGE_TYPE;
+      break;
+    }
+
+out:
+  WritePipeAsync (pipe, &ack, sizeof (ack), count, events);
+}
+
+
+static VOID
+Undo (undo_lists_t *lists)
+{
+  undo_type_t type;
+  for (type = 0; type < _undo_type_max; type++)
+    {
+      list_item_t **pnext = &(*lists)[type];
+      while (*pnext)
+        {
+          list_item_t *item = *pnext;
+          switch (type)
+            {
+            case address:
+              DeleteAddress (item->data);
+              break;
+
+            case route:
+              DeleteRoute (item->data);
+              break;
+            }
+
+          /* Remove from the list and free memory */
+          *pnext = item->next;
+          free (item->data);
+          free (item);
+        }
+    }
+}
+
+static DWORD WINAPI
+RunOpenvpn (LPVOID p)
+{
+  HANDLE pipe = p;
+  HANDLE ovpn_pipe, svc_pipe;
+  PTOKEN_USER svc_user, ovpn_user;
+  HANDLE svc_token = NULL, imp_token = NULL, pri_token = NULL;
+  HANDLE stdin_read = NULL, stdin_write = NULL;
+  HANDLE stdout_read = NULL, stdout_write = NULL;
+  DWORD pipe_mode, len, exit_code = 0;
+  STARTUP_DATA sud = { 0, 0, 0 };
+  STARTUPINFOW startup_info;
+  PROCESS_INFORMATION proc_info;
+  LPVOID user_env = NULL;
+  TCHAR ovpn_pipe_name[36];
+  LPCWSTR exe_path;
+  WCHAR *cmdline = NULL;
+  size_t cmdline_size;
+  undo_lists_t undo_lists;
+
+  SECURITY_ATTRIBUTES inheritable = {
+    .nLength = sizeof (inheritable),
+    .lpSecurityDescriptor = NULL,
+    .bInheritHandle = TRUE
+  };
+
+  PACL ovpn_dacl;
+  EXPLICIT_ACCESS ea[2];
+  SECURITY_DESCRIPTOR ovpn_sd;
+  SECURITY_ATTRIBUTES ovpn_sa = {
+    .nLength = sizeof (ovpn_sa),
+    .lpSecurityDescriptor = &ovpn_sd,
+    .bInheritHandle = FALSE
+  };
+
+  ZeroMemory (&ea, sizeof (ea));
+  ZeroMemory (&startup_info, sizeof (startup_info));
+  ZeroMemory (&undo_lists, sizeof (undo_lists));
+  ZeroMemory (&proc_info, sizeof (proc_info));
+
+  if (!GetStartupData (pipe, &sud))
+    goto out;
+
+  if (!InitializeSecurityDescriptor (&ovpn_sd, SECURITY_DESCRIPTOR_REVISION))
+    {
+      ReturnLastError (pipe, L"InitializeSecurityDescriptor");
+      goto out;
+    }
+
+  /* Get SID of user the service is running under */
+  if (!OpenProcessToken (GetCurrentProcess (), TOKEN_QUERY, &svc_token))
+    {
+      ReturnLastError (pipe, L"OpenProcessToken");
+      goto out;
+    }
+  len = 0;
+  svc_user = NULL;
+  while (!GetTokenInformation (svc_token, TokenUser, svc_user, len, &len))
+    {
+      if (GetLastError () != ERROR_INSUFFICIENT_BUFFER)
+        {
+          ReturnLastError (pipe, L"GetTokenInformation (service token)");
+          goto out;
+        }
+      free (svc_user);
+      svc_user = malloc (len);
+      if (svc_user == NULL)
+        {
+          ReturnLastError (pipe, L"malloc (service token user)");
+          goto out;
+        }
+    }
+  if (!IsValidSid (svc_user->User.Sid))
+    {
+      ReturnLastError (pipe, L"IsValidSid (service token user)");
+      goto out;
+    }
+
+  if (!ImpersonateNamedPipeClient (pipe))
+    {
+      ReturnLastError (pipe, L"ImpersonateNamedPipeClient");
+      goto out;
+    }
+  if (!OpenThreadToken (GetCurrentThread (), TOKEN_ALL_ACCESS, FALSE, &imp_token))
+    {
+      ReturnLastError (pipe, L"OpenThreadToken");
+      goto out;
+    }
+  len = 0;
+  ovpn_user = NULL;
+  while (!GetTokenInformation (imp_token, TokenUser, ovpn_user, len, &len))
+    {
+      if (GetLastError () != ERROR_INSUFFICIENT_BUFFER)
+        {
+          ReturnLastError (pipe, L"GetTokenInformation (impersonation token)");
+          goto out;
+        }
+      free (ovpn_user);
+      ovpn_user = malloc (len);
+      if (ovpn_user == NULL)
+        {
+          ReturnLastError (pipe, L"malloc (impersonation token user)");
+          goto out;
+        }
+    }
+  if (!IsValidSid (ovpn_user->User.Sid))
+    {
+      ReturnLastError (pipe, L"IsValidSid (impersonation token user)");
+      goto out;
+    }
+
+  /* OpenVPN process DACL entry for access by service and user */
+  ea[0].grfAccessPermissions = SPECIFIC_RIGHTS_ALL | STANDARD_RIGHTS_ALL;
+  ea[0].grfAccessMode = SET_ACCESS;
+  ea[0].grfInheritance = NO_INHERITANCE;
+  ea[0].Trustee.TrusteeForm = TRUSTEE_IS_SID;
+  ea[0].Trustee.TrusteeType = TRUSTEE_IS_UNKNOWN;
+  ea[0].Trustee.ptstrName = (LPTSTR) svc_user->User.Sid;
+  ea[1].grfAccessPermissions = READ_CONTROL | SYNCHRONIZE | PROCESS_VM_READ |
+                    SYNCHRONIZE | PROCESS_TERMINATE | PROCESS_QUERY_INFORMATION;
+  ea[1].grfAccessMode = SET_ACCESS;
+  ea[1].grfInheritance = NO_INHERITANCE;
+  ea[1].Trustee.TrusteeForm = TRUSTEE_IS_SID;
+  ea[1].Trustee.TrusteeType = TRUSTEE_IS_UNKNOWN;
+  ea[1].Trustee.ptstrName = (LPTSTR) ovpn_user->User.Sid;
+
+  /* Set owner and DACL of OpenVPN security descriptor */
+  if (!SetSecurityDescriptorOwner (&ovpn_sd, svc_user->User.Sid, FALSE))
+    {
+      ReturnLastError (pipe, L"SetSecurityDescriptorOwner");
+      goto out;
+    }
+  if (SetEntriesInAcl (2, ea, NULL, &ovpn_dacl) != ERROR_SUCCESS)
+    {
+      ReturnLastError (pipe, L"SetEntriesInAcl");
+      goto out;
+    }
+  if (!SetSecurityDescriptorDacl (&ovpn_sd, TRUE, ovpn_dacl, FALSE))
+    {
+      ReturnLastError (pipe, L"SetSecurityDescriptorDacl");
+      goto out;
+    }
+
+  /* Create primary token from impersonation token */
+  if (!DuplicateTokenEx (imp_token, TOKEN_ALL_ACCESS, NULL, 0, TokenPrimary, &pri_token))
+    {
+      ReturnLastError (pipe, L"DuplicateTokenEx");
+      goto out;
+    }
+
+  if (!CreatePipe(&stdin_read, &stdin_write, &inheritable, 0) ||
+      !CreatePipe(&stdout_read, &stdout_write, &inheritable, 0) ||
+      !SetHandleInformation(stdin_write, HANDLE_FLAG_INHERIT, 0) ||
+      !SetHandleInformation(stdout_read, HANDLE_FLAG_INHERIT, 0))
+    {
+      ReturnLastError (pipe, L"CreatePipe");
+      goto out;
+    }
+
+  openvpn_sntprintf (ovpn_pipe_name, _countof (ovpn_pipe_name),
+    TEXT("\\\\.\\pipe\\openvpn\\service_%lu"), GetCurrentThreadId ());
+  ovpn_pipe = CreateNamedPipe (ovpn_pipe_name,
+    PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLAPPED,
+    PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT, 1, 128, 128, 0, NULL);
+  if (ovpn_pipe == INVALID_HANDLE_VALUE)
+    {
+      ReturnLastError (pipe, L"CreateNamedPipe");
+      goto out;
+    }
+
+  svc_pipe = CreateFile (ovpn_pipe_name, GENERIC_READ | GENERIC_WRITE, 0,
+                         &inheritable, OPEN_EXISTING, 0, NULL);
+  if (svc_pipe == INVALID_HANDLE_VALUE)
+    {
+      ReturnLastError (pipe, L"CreateFile");
+      goto out;
+    }
+
+  pipe_mode = PIPE_READMODE_MESSAGE;
+  if (!SetNamedPipeHandleState (svc_pipe, &pipe_mode, NULL, NULL))
+    {
+      ReturnLastError (pipe, L"SetNamedPipeHandleState");
+      goto out;
+    }
+
+  cmdline_size = wcslen (sud.options) + 128;
+  cmdline = malloc (cmdline_size * sizeof (*cmdline));
+  if (cmdline == NULL)
+    {
+      ReturnLastError (pipe, L"malloc");
+      goto out;
+    }
+  openvpn_sntprintf (cmdline, cmdline_size, L"openvpn %s --msg-channel %lu",
+                     sud.options, svc_pipe);
+
+  if (!CreateEnvironmentBlock (&user_env, imp_token, FALSE))
+    {
+      ReturnLastError (pipe, L"CreateEnvironmentBlock");
+      goto out;
+    }
+
+  startup_info.cb = sizeof (startup_info);
+  startup_info.lpDesktop = L"winsta0\\default";
+  startup_info.dwFlags = STARTF_USESTDHANDLES;
+  startup_info.hStdInput = stdin_read;
+  startup_info.hStdOutput = stdout_write;
+  startup_info.hStdError = stdout_write;
+
+#ifdef UNICODE
+  exe_path = settings.exe_path;
+#else
+  WCHAR wide_path[MAX_PATH];
+  MultiByteToWideChar (CP_UTF8, 0, settings.exe_path, MAX_PATH, wide_path, MAX_PATH);
+  exe_path = wide_path;
+#endif
+
+  // TODO: make sure HKCU is correct or call LoadUserProfile()
+  if (!CreateProcessAsUserW (pri_token, exe_path, cmdline, &ovpn_sa, NULL, TRUE,
+                             settings.priority | CREATE_NO_WINDOW | CREATE_UNICODE_ENVIRONMENT,
+                             user_env, sud.directory, &startup_info, &proc_info))
+    {
+      ReturnLastError (pipe, L"CreateProcessAsUser");
+      goto out;
+    }
+
+  if (!RevertToSelf ())
+    {
+      TerminateProcess (proc_info.hProcess, 1);
+      ReturnLastError (pipe, L"RevertToSelf");
+      goto out;
+    }
+
+  CloseHandleEx (&stdout_write);
+  CloseHandleEx (&stdin_read);
+  CloseHandleEx (&svc_pipe);
+
+  DWORD input_size = wcslen (sud.std_input) * 2;
+  if (input_size)
+    {
+      DWORD written;
+      LPSTR input = malloc (input_size);
+      WideCharToMultiByte (CP_UTF8, 0, sud.std_input, -1, input, input_size, NULL, NULL);
+      WriteFile (stdin_write, input, strlen (input), &written, NULL);
+      free (input);
+    }
+
+
+  while (TRUE)
+    {
+      DWORD bytes = PeekNamedPipeAsync (ovpn_pipe, 1, &exit_event);
+      if (bytes == 0)
+        break;
+
+      HandleMessage (ovpn_pipe, bytes, 1, &exit_event, &undo_lists);
+    }
+
+  WaitForSingleObject (proc_info.hProcess, IO_TIMEOUT);
+  GetExitCodeProcess (proc_info.hProcess, &exit_code);
+  if (exit_code == STILL_ACTIVE)
+    TerminateProcess (proc_info.hProcess, 1);
+  else if (exit_code != 0)
+    ReturnOpenvpnOutput (pipe, stdout_read, 1, &exit_event);
+
+  Undo (&undo_lists);
+
+out:
+  FlushFileBuffers (pipe);
+  DisconnectNamedPipe (pipe);
+
+  free (ovpn_user);
+  free (svc_user);
+  free (cmdline);
+  DestroyEnvironmentBlock (user_env);
+  FreeStartupData (&sud);
+  CloseHandleEx (&proc_info.hProcess);
+  CloseHandleEx (&proc_info.hThread);
+  CloseHandleEx (&stdin_read);
+  CloseHandleEx (&stdin_write);
+  CloseHandleEx (&stdout_read);
+  CloseHandleEx (&stdout_write);
+  CloseHandleEx (&svc_token);
+  CloseHandleEx (&imp_token);
+  CloseHandleEx (&pri_token);
+  CloseHandleEx (&ovpn_pipe);
+  CloseHandleEx (&svc_pipe);
+  CloseHandleEx (&pipe);
+
+  return 0;
+}
+
+
+static DWORD WINAPI
+ServiceCtrlInteractive (DWORD ctrl_code, DWORD event, LPVOID data, LPVOID ctx)
+{
+  SERVICE_STATUS *status = ctx;
+  switch (ctrl_code)
+    {
+    case SERVICE_CONTROL_STOP:
+      status->dwCurrentState = SERVICE_STOP_PENDING;
+      ReportStatusToSCMgr (service, status);
+      if (exit_event)
+        SetEvent (exit_event);
+      return NO_ERROR;
+
+    case SERVICE_CONTROL_INTERROGATE:
+      return NO_ERROR;
+
+    default:
+      return ERROR_CALL_NOT_IMPLEMENTED;
+    }
+}
+
+
+static HANDLE
+CreateClientPipeInstance (VOID)
+{
+  HANDLE pipe = NULL;
+  PACL old_dacl, new_dacl;
+  PSECURITY_DESCRIPTOR sd;
+  static EXPLICIT_ACCESS ea[2];
+  static BOOL initialized = FALSE;
+  DWORD flags = PIPE_ACCESS_DUPLEX | WRITE_DAC | FILE_FLAG_OVERLAPPED;
+
+  if (!initialized)
+    {
+      PSID everyone, anonymous;
+
+      ConvertStringSidToSid (TEXT("S-1-1-0"), &everyone);
+      ConvertStringSidToSid (TEXT("S-1-5-7"), &anonymous);
+
+      ea[0].grfAccessPermissions = FILE_GENERIC_WRITE;
+      ea[0].grfAccessMode = GRANT_ACCESS;
+      ea[0].grfInheritance = NO_INHERITANCE;
+      ea[0].Trustee.pMultipleTrustee = NULL;
+      ea[0].Trustee.MultipleTrusteeOperation = NO_MULTIPLE_TRUSTEE;
+      ea[0].Trustee.TrusteeForm = TRUSTEE_IS_SID;
+      ea[0].Trustee.TrusteeType = TRUSTEE_IS_UNKNOWN;
+      ea[0].Trustee.ptstrName = (LPTSTR) everyone;
+
+      ea[1].grfAccessPermissions = 0;
+      ea[1].grfAccessMode = REVOKE_ACCESS;
+      ea[1].grfInheritance = NO_INHERITANCE;
+      ea[1].Trustee.pMultipleTrustee = NULL;
+      ea[1].Trustee.MultipleTrusteeOperation = NO_MULTIPLE_TRUSTEE;
+      ea[1].Trustee.TrusteeForm = TRUSTEE_IS_SID;
+      ea[1].Trustee.TrusteeType = TRUSTEE_IS_UNKNOWN;
+      ea[1].Trustee.ptstrName = (LPTSTR) anonymous;
+
+      flags |= FILE_FLAG_FIRST_PIPE_INSTANCE;
+      initialized = TRUE;
+    }
+
+  pipe = CreateNamedPipe (TEXT("\\\\.\\pipe\\openvpn\\service"), flags,
+                PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE,
+                PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, NULL);
+  if (pipe == INVALID_HANDLE_VALUE)
+    {
+      MsgToEventLog (M_SYSERR, TEXT("Could not create named pipe"));
+      return INVALID_HANDLE_VALUE;
+    }
+
+  if (GetSecurityInfo (pipe, SE_KERNEL_OBJECT, DACL_SECURITY_INFORMATION,
+                        NULL, NULL, &old_dacl, NULL, &sd) != ERROR_SUCCESS)
+    {
+      MsgToEventLog (M_SYSERR, TEXT("Could not get pipe security info"));
+      return CloseHandleEx (&pipe);
+    }
+
+  if (SetEntriesInAcl (2, ea, old_dacl, &new_dacl) != ERROR_SUCCESS)
+    {
+      MsgToEventLog (M_SYSERR, TEXT("Could not set entries in new acl"));
+      return CloseHandleEx (&pipe);
+    }
+
+  if (SetSecurityInfo (pipe, SE_KERNEL_OBJECT, DACL_SECURITY_INFORMATION,
+                        NULL, NULL, new_dacl, NULL) != ERROR_SUCCESS)
+    {
+      MsgToEventLog (M_SYSERR, TEXT("Could not set pipe security info"));
+      return CloseHandleEx (&pipe);
+    }
+
+  return pipe;
+}
+
+
+static DWORD
+UpdateWaitHandles (LPHANDLE *handles_ptr, LPDWORD count,
+                   HANDLE io_event, HANDLE exit_event, list_item_t *threads)
+{
+  static DWORD size = 10;
+  static LPHANDLE handles = NULL;
+  DWORD pos = 0;
+
+  if (handles == NULL)
+    {
+      handles = malloc (size * sizeof (HANDLE));
+      if (handles == NULL)
+        return ERROR_OUTOFMEMORY;
+    }
+
+  handles[pos++] = io_event;
+
+  if (!threads)
+    handles[pos++] = exit_event;
+
+  while (threads)
+    {
+      if (pos == size)
+        {
+          size += 10;
+          handles = realloc (handles, size * sizeof (HANDLE));
+          if (handles == NULL)
+            return ERROR_OUTOFMEMORY;
+        }
+      handles[pos++] = threads->data;
+      threads = threads->next;
+    }
+
+  *handles_ptr = handles;
+  *count = pos;
+  return NO_ERROR;
+}
+
+
+static VOID
+FreeWaitHandles (LPHANDLE h)
+{
+  free (h);
+}
+
+
+VOID WINAPI
+ServiceStartInteractive (DWORD dwArgc, LPTSTR *lpszArgv)
+{
+  HANDLE pipe, io_event = NULL;
+  OVERLAPPED overlapped;
+  DWORD error = NO_ERROR;
+  list_item_t *threads = NULL;
+  PHANDLE handles;
+  DWORD handle_count;
+
+  service = RegisterServiceCtrlHandlerEx (interactive_service.name, ServiceCtrlInteractive, &status);
+  if (!service)
+    return;
+
+  status.dwServiceType = SERVICE_WIN32_SHARE_PROCESS;
+  status.dwCurrentState = SERVICE_START_PENDING;
+  status.dwServiceSpecificExitCode = NO_ERROR;
+  status.dwWin32ExitCode = NO_ERROR;
+  status.dwWaitHint = 3000;
+  ReportStatusToSCMgr (service, &status);
+
+  /* Read info from registry in key HKLM\SOFTWARE\OpenVPN */
+  error = GetOpenvpnSettings (&settings);
+  if (error != ERROR_SUCCESS)
+    goto out;
+
+  io_event = InitOverlapped (&overlapped);
+  exit_event = CreateEvent (NULL, FALSE, FALSE, NULL);
+  if (!exit_event || !io_event)
+    {
+      error = MsgToEventLog (M_SYSERR, TEXT("Could not create event"));
+      goto out;
+    }
+
+  error = UpdateWaitHandles (&handles, &handle_count, io_event, exit_event, threads);
+  if (error != NO_ERROR)
+    goto out;
+
+  pipe = CreateClientPipeInstance ();
+  if (pipe == INVALID_HANDLE_VALUE)
+    goto out;
+
+  status.dwCurrentState = SERVICE_RUNNING;
+  status.dwWaitHint = 0;
+  ReportStatusToSCMgr (service, &status);
+
+  while (TRUE)
+    {
+      if (ConnectNamedPipe (pipe, &overlapped) == FALSE &&
+          GetLastError () != ERROR_PIPE_CONNECTED &&
+          GetLastError () != ERROR_IO_PENDING)
+        {
+          MsgToEventLog (M_SYSERR, TEXT("Could not connect pipe"));
+          break;
+        }
+
+      error = WaitForMultipleObjects (handle_count, handles, FALSE, INFINITE);
+      if (error == WAIT_OBJECT_0)
+        {
+          /* Client connected, spawn a worker thread for it */
+          HANDLE next_pipe = CreateClientPipeInstance ();
+          HANDLE thread = CreateThread (NULL, 0, RunOpenvpn, pipe, CREATE_SUSPENDED, NULL);
+          if (thread)
+            {
+              error = AddListItem (&threads, thread) ||
+                UpdateWaitHandles (&handles, &handle_count, io_event, exit_event, threads);
+              if (error)
+                {
+                  TerminateThread (thread, 1);
+                  CloseHandleEx (&thread);
+                  CloseHandleEx (&pipe);
+                  SetEvent (exit_event);
+                }
+              else
+                ResumeThread (thread);
+            }
+          else
+            CloseHandleEx (&pipe);
+
+          ResetOverlapped (&overlapped);
+          pipe = next_pipe;
+        }
+      else
+        {
+          CancelIo (pipe);
+          if (error == WAIT_FAILED)
+            {
+              MsgToEventLog (M_SYSERR, TEXT("WaitForMultipleObjects failed"));
+              continue;
+            }
+          if (!threads)
+            {
+              /* exit event signaled */
+              CloseHandleEx (&pipe);
+              error = NO_ERROR;
+              break;
+            }
+
+          /* Worker thread ended */
+          BOOL CmpHandle (LPVOID item, LPVOID hnd) { return item == hnd; }
+          HANDLE thread = RemoveListItem (&threads, CmpHandle, handles[error]);
+          UpdateWaitHandles (&handles, &handle_count, io_event, exit_event, threads);
+          CloseHandleEx (&thread);
+        }
+    }
+
+out:
+  FreeWaitHandles (handles);
+  CloseHandleEx (&io_event);
+  CloseHandleEx (&exit_event);
+
+  status.dwCurrentState = SERVICE_STOPPED;
+  status.dwWin32ExitCode = error;
+  ReportStatusToSCMgr (service, &status);
+}
+
diff --git a/src/openvpnserv/openvpnserv.c b/src/openvpnserv/openvpnserv.c
deleted file mode 100755
index 56f5a02..0000000
--- a/src/openvpnserv/openvpnserv.c
+++ /dev/null
@@ -1,534 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-/*
- * This program allows one or more OpenVPN processes to be started
- * as a service.  To build, you must get the service sample from the
- * Platform SDK and replace Simple.c with this file.
- *
- * You should also apply service.patch to
- * service.c and service.h from the Platform SDK service sample.
- *
- * This code is designed to be built with the mingw compiler.
- */
-
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
-#endif
-#include <windows.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <stdarg.h>
-#include <process.h>
-#include "service.h"
-
-/* bool definitions */
-#define bool int
-#define true 1
-#define false 0
-
-/* These are new for 2000/XP, so they aren't in the mingw headers yet */
-#ifndef BELOW_NORMAL_PRIORITY_CLASS
-#define BELOW_NORMAL_PRIORITY_CLASS 0x00004000
-#endif
-#ifndef ABOVE_NORMAL_PRIORITY_CLASS
-#define ABOVE_NORMAL_PRIORITY_CLASS 0x00008000
-#endif
-
-struct security_attributes
-{
-  SECURITY_ATTRIBUTES sa;
-  SECURITY_DESCRIPTOR sd;
-};
-
-/*
- * This event is initially created in the non-signaled
- * state.  It will transition to the signaled state when
- * we have received a terminate signal from the Service
- * Control Manager which will cause an asynchronous call
- * of ServiceStop below.
- */
-#define EXIT_EVENT_NAME PACKAGE "_exit_1"
-
-/*
- * Which registry key in HKLM should
- * we get config info from?
- */
-#define REG_KEY "SOFTWARE\\" PACKAGE_NAME
-
-static HANDLE exit_event = NULL;
-
-/* clear an object */
-#define CLEAR(x) memset(&(x), 0, sizeof(x))
-
-/*
- * Message handling
- */
-#define M_INFO    (0)                                  /* informational */
-#define M_SYSERR  (MSG_FLAGS_ERROR|MSG_FLAGS_SYS_CODE) /* error + system code */
-#define M_ERR     (MSG_FLAGS_ERROR)                    /* error */
-
-/* write error to event log */
-#define MSG(flags, ...) \
-        { \
-           char x_msg[256]; \
-           openvpn_snprintf (x_msg, sizeof(x_msg), __VA_ARGS__);      \
-           AddToMessageLog ((flags), x_msg); \
-        }
-
-/* get a registry string */
-#define QUERY_REG_STRING(name, data) \
-  { \
-    len = sizeof (data); \
-    status = RegQueryValueEx(openvpn_key, name, NULL, &type, data, &len); \
-    if (status != ERROR_SUCCESS || type != REG_SZ) \
-      { \
-        SetLastError (status); \
-        MSG (M_SYSERR, error_format_str, name); \
-	RegCloseKey (openvpn_key); \
-	goto finish; \
-      } \
-  }
-
-/* get a registry string */
-#define QUERY_REG_DWORD(name, data) \
-  { \
-    len = sizeof (DWORD); \
-    status = RegQueryValueEx(openvpn_key, name, NULL, &type, (LPBYTE)&data, &len); \
-    if (status != ERROR_SUCCESS || type != REG_DWORD || len != sizeof (DWORD)) \
-      { \
-        SetLastError (status); \
-        MSG (M_SYSERR, error_format_dword, name); \
-	RegCloseKey (openvpn_key); \
-	goto finish; \
-      } \
-  }
-
-/*
- * This is necessary due to certain buggy implementations of snprintf,
- * that don't guarantee null termination for size > 0.
- * (copied from ../buffer.c, line 217)
- * (git: 100644 blob e2f8caab0a5b2a870092c6cd508a1a50c21c3ba3	buffer.c)
- */
-
-int openvpn_snprintf(char *str, size_t size, const char *format, ...)
-{
-  va_list arglist;
-  int len = -1;
-  if (size > 0)
-    {
-      va_start (arglist, format);
-      len = vsnprintf (str, size, format, arglist);
-      va_end (arglist);
-      str[size - 1] = 0;
-    }
-  return (len >= 0 && len < size);
-}
-
-
-bool
-init_security_attributes_allow_all (struct security_attributes *obj)
-{
-  CLEAR (*obj);
-
-  obj->sa.nLength = sizeof (SECURITY_ATTRIBUTES);
-  obj->sa.lpSecurityDescriptor = &obj->sd;
-  obj->sa.bInheritHandle = TRUE;
-  if (!InitializeSecurityDescriptor (&obj->sd, SECURITY_DESCRIPTOR_REVISION))
-    return false;
-  if (!SetSecurityDescriptorDacl (&obj->sd, TRUE, NULL, FALSE))
-    return false;
-  return true;
-}
-
-HANDLE
-create_event (const char *name, bool allow_all, bool initial_state, bool manual_reset)
-{
-  if (allow_all)
-    {
-      struct security_attributes sa;
-      if (!init_security_attributes_allow_all (&sa))
-	return NULL;
-      return CreateEvent (&sa.sa, (BOOL)manual_reset, (BOOL)initial_state, name);
-    }
-  else
-    return CreateEvent (NULL, (BOOL)manual_reset, (BOOL)initial_state, name);
-}
-
-void
-close_if_open (HANDLE h)
-{
-  if (h != NULL)
-    CloseHandle (h);
-}
-
-static bool
-match (const WIN32_FIND_DATA *find, const char *ext)
-{
-  int i;
-
-  if (find->dwFileAttributes & FILE_ATTRIBUTE_DIRECTORY)
-    return false;
-
-  if (!strlen (ext))
-    return true;
-
-  i = strlen (find->cFileName) - strlen (ext) - 1;
-  if (i < 1)
-    return false;
-
-  return find->cFileName[i] == '.' && !_stricmp (find->cFileName + i + 1, ext);
-}
-
-/*
- * Modify the extension on a filename.
- */
-static bool
-modext (char *dest, int size, const char *src, const char *newext)
-{
-  int i;
-
-  if (size > 0 && (strlen (src) + 1) <= size)
-    {
-      strcpy (dest, src);
-      dest [size - 1] = '\0';
-      i = strlen (dest);
-      while (--i >= 0)
-	{
-	  if (dest[i] == '\\')
-	    break;
-	  if (dest[i] == '.')
-	    {
-	      dest[i] = '\0';
-	      break;
-	    }
-	}
-      if (strlen (dest) + strlen(newext) + 2 <= size)
-	{
-	  strcat (dest, ".");
-	  strcat (dest, newext);
-	  return true;
-	}
-      dest [0] = '\0';
-    }
-  return false;
-}
-
-VOID ServiceStart (DWORD dwArgc, LPTSTR *lpszArgv)
-{
-  char exe_path[MAX_PATH];
-  char config_dir[MAX_PATH];
-  char ext_string[16];
-  char log_dir[MAX_PATH];
-  char priority_string[64];
-  char append_string[2];
-
-  DWORD priority;
-  bool append;
-
-  ResetError ();
-
-  if (!ReportStatusToSCMgr(SERVICE_START_PENDING, NO_ERROR, 3000))
-    {
-      MSG (M_ERR, "ReportStatusToSCMgr #1 failed");
-      goto finish;
-    }
-
-  /*
-   * Create our exit event
-   */
-  exit_event = create_event (EXIT_EVENT_NAME, false, false, true);
-  if (!exit_event)
-    {
-      MSG (M_ERR, "CreateEvent failed");
-      goto finish;
-    }
-
-  /*
-   * If exit event is already signaled, it means we were not
-   * shut down properly.
-   */
-  if (WaitForSingleObject (exit_event, 0) != WAIT_TIMEOUT)
-    {
-      MSG (M_ERR, "Exit event is already signaled -- we were not shut down properly");
-      goto finish;
-    }
-
-  if (!ReportStatusToSCMgr(SERVICE_START_PENDING, NO_ERROR, 3000))
-    {
-      MSG (M_ERR, "ReportStatusToSCMgr #2 failed");
-      goto finish;
-    }
-
-  /*
-   * Read info from registry in key HKLM\SOFTWARE\OpenVPN
-   */
-  {
-    HKEY openvpn_key;
-    LONG status;
-    DWORD len;
-    DWORD type;
-
-    static const char error_format_str[] =
-      "Error querying registry key of type REG_SZ: HKLM\\" REG_KEY "\\%s";
-
-    static const char error_format_dword[] =
-      "Error querying registry key of type REG_DWORD: HKLM\\" REG_KEY "\\%s";
-
-    status = RegOpenKeyEx(
-			  HKEY_LOCAL_MACHINE,
-			  REG_KEY,
-			  0,
-			  KEY_READ,
-			  &openvpn_key);
-
-    if (status != ERROR_SUCCESS)
-      {
-	SetLastError (status);
-	MSG (M_SYSERR, "Registry key HKLM\\" REG_KEY " not found");
-	goto finish;
-      }
-
-    /* get path to openvpn.exe */
-    QUERY_REG_STRING ("exe_path", exe_path);
-
-    /* get path to configuration directory */
-    QUERY_REG_STRING ("config_dir", config_dir);
-
-    /* get extension on configuration files */
-    QUERY_REG_STRING ("config_ext", ext_string);
-
-    /* get path to log directory */
-    QUERY_REG_STRING ("log_dir", log_dir);
-
-    /* get priority for spawned OpenVPN subprocesses */
-    QUERY_REG_STRING ("priority", priority_string);
-
-    /* should we truncate or append to logfile? */
-    QUERY_REG_STRING ("log_append", append_string);
-
-    RegCloseKey (openvpn_key);
-  }
-
-  /* set process priority */
-  priority = NORMAL_PRIORITY_CLASS;
-  if (!_stricmp (priority_string, "IDLE_PRIORITY_CLASS"))
-    priority = IDLE_PRIORITY_CLASS;
-  else if (!_stricmp (priority_string, "BELOW_NORMAL_PRIORITY_CLASS"))
-    priority = BELOW_NORMAL_PRIORITY_CLASS;
-  else if (!_stricmp (priority_string, "NORMAL_PRIORITY_CLASS"))
-    priority = NORMAL_PRIORITY_CLASS;
-  else if (!_stricmp (priority_string, "ABOVE_NORMAL_PRIORITY_CLASS"))
-    priority = ABOVE_NORMAL_PRIORITY_CLASS;
-  else if (!_stricmp (priority_string, "HIGH_PRIORITY_CLASS"))
-    priority = HIGH_PRIORITY_CLASS;
-  else
-    {
-      MSG (M_ERR, "Unknown priority name: %s", priority_string);
-      goto finish;
-    }
-
-  /* set log file append/truncate flag */
-  append = false;
-  if (append_string[0] == '0')
-    append = false;
-  else if (append_string[0] == '1')
-    append = true;
-  else
-    {
-      MSG (M_ERR, "Log file append flag (given as '%s') must be '0' or '1'", append_string);
-      goto finish;
-    }
-
-  /*
-   * Instantiate an OpenVPN process for each configuration
-   * file found.
-   */
-  {
-    WIN32_FIND_DATA find_obj;
-    HANDLE find_handle;
-    BOOL more_files;
-    char find_string[MAX_PATH];
-
-    openvpn_snprintf (find_string, MAX_PATH, "%s\\*", config_dir);
-
-    find_handle = FindFirstFile (find_string, &find_obj);
-    if (find_handle == INVALID_HANDLE_VALUE)
-      {
-        MSG (M_ERR, "Cannot get configuration file list using: %s", find_string);
-	goto finish;
-      }
-
-    /*
-     * Loop over each config file
-     */
-    do {
-      HANDLE log_handle = NULL;
-      STARTUPINFO start_info;
-      PROCESS_INFORMATION proc_info;
-      struct security_attributes sa;
-      char log_file[MAX_PATH];
-      char log_path[MAX_PATH];
-      char command_line[256];
-
-      CLEAR (start_info);
-      CLEAR (proc_info);
-      CLEAR (sa);
-
-      if (!ReportStatusToSCMgr(SERVICE_START_PENDING, NO_ERROR, 3000))
-	{
-	  MSG (M_ERR, "ReportStatusToSCMgr #3 failed");
-	  FindClose (find_handle);
-	  goto finish;
-	}
-
-      /* does file have the correct type and extension? */
-      if (match (&find_obj, ext_string))
-	{
-	  /* get log file pathname */
-	  if (!modext (log_file, sizeof (log_file), find_obj.cFileName, "log"))
-	    {
-	      MSG (M_ERR, "Cannot construct logfile name based on: %s", find_obj.cFileName);
-	      FindClose (find_handle);
-	      goto finish;
-	    }
-	  openvpn_snprintf (log_path, sizeof(log_path),
-                            "%s\\%s", log_dir, log_file);
-
-	  /* construct command line */
-	  openvpn_snprintf (command_line, sizeof(command_line), PACKAGE " --service %s 1 --config \"%s\"",
-		      EXIT_EVENT_NAME,
-		      find_obj.cFileName);
-
-	  /* Make security attributes struct for logfile handle so it can
-	     be inherited. */
-	  if (!init_security_attributes_allow_all (&sa))
-	    {
-	      MSG (M_SYSERR, "InitializeSecurityDescriptor start_" PACKAGE " failed");
-	      goto finish;
-	    }
-
-	  /* open logfile as stdout/stderr for soon-to-be-spawned subprocess */
-	  log_handle = CreateFile (log_path,
-				   GENERIC_WRITE,
-				   FILE_SHARE_READ,
-				   &sa.sa,
-				   append ? OPEN_ALWAYS : CREATE_ALWAYS,
-				   FILE_ATTRIBUTE_NORMAL,
-				   NULL);
-
-	  if (log_handle == INVALID_HANDLE_VALUE)
-	    {
-	      MSG (M_SYSERR, "Cannot open logfile: %s", log_path);
-	      FindClose (find_handle);
-	      goto finish;
-	    }
-
-	  /* append to logfile? */
-	  if (append)
-	    {
-	      if (SetFilePointer (log_handle, 0, NULL, FILE_END) == INVALID_SET_FILE_POINTER)
-		{
-		  MSG (M_SYSERR, "Cannot seek to end of logfile: %s", log_path);
-		  FindClose (find_handle);
-		  goto finish;
-		}
-	    }
-
-	  /* fill in STARTUPINFO struct */
-	  GetStartupInfo(&start_info);
-	  start_info.cb = sizeof(start_info);
-	  start_info.dwFlags = STARTF_USESTDHANDLES|STARTF_USESHOWWINDOW;
-	  start_info.wShowWindow = SW_HIDE;
-	  start_info.hStdInput = GetStdHandle(STD_INPUT_HANDLE);
-	  start_info.hStdOutput = start_info.hStdError = log_handle;
-
-	  /* create an OpenVPN process for one config file */
-	  if (!CreateProcess(exe_path,
-			     command_line,
-			     NULL,
-			     NULL,
-			     TRUE,
-			     priority | CREATE_NEW_CONSOLE,
-			     NULL,
-			     config_dir,
-			     &start_info,
-			     &proc_info))
-	    {
-	      MSG (M_SYSERR, "CreateProcess failed, exe='%s' cmdline='%s' dir='%s'",
-		   exe_path,
-		   command_line,
-		   config_dir);
-
-	      FindClose (find_handle);
-	      CloseHandle (log_handle);
-	      goto finish;
-	    }
-
-	  /* close unneeded handles */
-	  Sleep (1000); /* try to prevent race if we close logfile
-			   handle before child process DUPs it */
-	  if (!CloseHandle (proc_info.hProcess)
-	      || !CloseHandle (proc_info.hThread)
-	      || !CloseHandle (log_handle))
-	    {
-	      MSG (M_SYSERR, "CloseHandle failed");
-	      goto finish;
-	    }
-	}
-
-      /* more files to process? */
-      more_files = FindNextFile (find_handle, &find_obj);
-
-    } while (more_files);
-    
-    FindClose (find_handle);
-  }
-
-  /* we are now fully started */
-  if (!ReportStatusToSCMgr(SERVICE_RUNNING, NO_ERROR, 0))
-    {
-      MSG (M_ERR, "ReportStatusToSCMgr SERVICE_RUNNING failed");
-      goto finish;
-    }
-
-  /* wait for our shutdown signal */
-  if (WaitForSingleObject (exit_event, INFINITE) != WAIT_OBJECT_0)
-    {
-      MSG (M_ERR, "wait for shutdown signal failed");
-    }
-
- finish:
-  ServiceStop ();
-  if (exit_event)
-    CloseHandle (exit_event);
-}
-
-VOID ServiceStop()
-{
-  if (exit_event)
-    SetEvent(exit_event);
-}
diff --git a/src/openvpnserv/service.c b/src/openvpnserv/service.c
index d7562b3..82f5551 100644
--- a/src/openvpnserv/service.c
+++ b/src/openvpnserv/service.c
@@ -1,700 +1,245 @@
-/*---------------------------------------------------------------------------
-THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
-ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED
-TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
-PARTICULAR PURPOSE.
-
-Copyright (C) 1993 - 2000.  Microsoft Corporation.  All rights reserved.
-
-MODULE:   service.c
-
-PURPOSE:  Implements functions required by all Windows NT services
-
-FUNCTIONS:
-  main(int argc, char **argv);
-  service_ctrl(DWORD dwCtrlCode);
-  service_main(DWORD dwArgc, LPTSTR *lpszArgv);
-  CmdInstallService();
-  CmdRemoveService();
-  CmdStartService();
-  CmdDebugService(int argc, char **argv);
-  ControlHandler ( DWORD dwCtrlType );
-  GetLastErrorText( LPTSTR lpszBuf, DWORD dwSize );
-
----------------------------------------------------------------------------*/
-
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
-#endif
-#include <windows.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <process.h>
-#include <tchar.h>
+/*
+ * THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
+ * ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED
+ * TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
+ * PARTICULAR PURPOSE.
+ *
+ * Copyright (C) 1993 - 2000.  Microsoft Corporation.  All rights reserved.
+ *                      2013 Heiko Hund <heiko.hund@...1489...>
+ */
 
 #include "service.h"
 
-// internal variables
-SERVICE_STATUS          ssStatus;       // current status of the service
-SERVICE_STATUS_HANDLE   sshStatusHandle;
-DWORD                   dwErr = 0;
-BOOL                    bDebug = FALSE;
-TCHAR                   szErr[256];
-
-// internal function prototypes
-VOID WINAPI service_ctrl(DWORD dwCtrlCode);
-VOID WINAPI service_main(DWORD dwArgc, LPTSTR *lpszArgv);
-int CmdInstallService();
-int CmdRemoveService();
-int CmdStartService();
-VOID CmdDebugService(int argc, char **argv);
-BOOL WINAPI ControlHandler ( DWORD dwCtrlType );
-LPTSTR GetLastErrorText( LPTSTR lpszBuf, DWORD dwSize );
-
-//
-//  FUNCTION: main
-//
-//  PURPOSE: entrypoint for service
-//
-//  PARAMETERS:
-//    argc - number of command line arguments
-//    argv - array of command line arguments
-//
-//  RETURN VALUE:
-//    none
-//
-//  COMMENTS:
-//    main() either performs the command line task, or
-//    call StartServiceCtrlDispatcher to register the
-//    main service thread.  When the this call returns,
-//    the service has stopped, so exit.
-//
-int __cdecl main(int argc, char **argv)
-{
-   SERVICE_TABLE_ENTRY dispatchTable[] =
-   {
-      { TEXT(SZSERVICENAME), (LPSERVICE_MAIN_FUNCTION)service_main},
-      { NULL, NULL}
-   };
-
-   if ( (argc > 1) &&
-        ((*argv[1] == '-') || (*argv[1] == '/')) )
-   {
-      if ( _stricmp( "install", argv[1]+1 ) == 0 )
-      {
-         return CmdInstallService();
-      }
-      else if ( _stricmp( "remove", argv[1]+1 ) == 0 )
-      {
-         return CmdRemoveService();
-      }
-	  else if ( _stricmp( "start", argv[1]+1 ) == 0)
-	  {
-		  return CmdStartService();
-      }
-      else if ( _stricmp( "debug", argv[1]+1 ) == 0 )
-      {
-         bDebug = TRUE;
-         CmdDebugService(argc, argv);
-      }
-      else
-      {
-         goto dispatch;
-      }
-      return 0;
-   }
-
-   // if it doesn't match any of the above parameters
-   // the service control manager may be starting the service
-   // so we must call StartServiceCtrlDispatcher
-   dispatch:
-   // this is just to be friendly
-   printf( "%s -install          to install the service\n", SZAPPNAME );
-   printf( "%s -start			 to start the service\n", SZAPPNAME );
-   printf( "%s -remove           to remove the service\n", SZAPPNAME );
-   printf( "%s -debug <params>   to run as a console app for debugging\n", SZAPPNAME );
-   printf( "\nStartServiceCtrlDispatcher being called.\n" );
-   printf( "This may take several seconds.  Please wait.\n" );
-
-   if (!StartServiceCtrlDispatcher(dispatchTable))
-      AddToMessageLog(MSG_FLAGS_ERROR, TEXT("StartServiceCtrlDispatcher failed."));
-
-   return 0;
-}
-
-
-
-//
-//  FUNCTION: service_main
-//
-//  PURPOSE: To perform actual initialization of the service
-//
-//  PARAMETERS:
-//    dwArgc   - number of command line arguments
-//    lpszArgv - array of command line arguments
-//
-//  RETURN VALUE:
-//    none
-//
-//  COMMENTS:
-//    This routine performs the service initialization and then calls
-//    the user defined ServiceStart() routine to perform majority
-//    of the work.
-//
-void WINAPI service_main(DWORD dwArgc, LPTSTR *lpszArgv)
-{
-
-   // register our service control handler:
-   //
-   sshStatusHandle = RegisterServiceCtrlHandler( TEXT(SZSERVICENAME), service_ctrl);
-
-   if (!sshStatusHandle)
-      goto cleanup;
-
-   // SERVICE_STATUS members that don't change in example
-   //
-   ssStatus.dwServiceType = SERVICE_WIN32_OWN_PROCESS;
-   ssStatus.dwServiceSpecificExitCode = 0;
-
-
-   // report the status to the service control manager.
-   //
-   if (!ReportStatusToSCMgr(
-                           SERVICE_START_PENDING, // service state
-                           NO_ERROR,              // exit code
-                           3000))                 // wait hint
-      goto cleanup;
-
-
-   ServiceStart( dwArgc, lpszArgv );
-
-   cleanup:
+#include <windows.h>
+#include <stdio.h>
+#include <process.h>
 
-   // try to report the stopped status to the service control manager.
-   //
-   if (sshStatusHandle)
-      (VOID)ReportStatusToSCMgr(
-                               SERVICE_STOPPED,
-                               dwErr,
-                               0);
 
-   return;
-}
+openvpn_service_t openvpn_service[_service_max];
 
 
-
-//
-//  FUNCTION: service_ctrl
-//
-//  PURPOSE: This function is called by the SCM whenever
-//           ControlService() is called on this service.
-//
-//  PARAMETERS:
-//    dwCtrlCode - type of control requested
-//
-//  RETURN VALUE:
-//    none
-//
-//  COMMENTS:
-//
-VOID WINAPI service_ctrl(DWORD dwCtrlCode)
+BOOL
+ReportStatusToSCMgr (SERVICE_STATUS_HANDLE service, SERVICE_STATUS *status)
 {
-   // Handle the requested control code.
-   //
-   switch (dwCtrlCode)
-   {
-   // Stop the service.
-   //
-   // SERVICE_STOP_PENDING should be reported before
-   // setting the Stop Event - hServerStopEvent - in
-   // ServiceStop().  This avoids a race condition
-   // which may result in a 1053 - The Service did not respond...
-   // error.
-   case SERVICE_CONTROL_STOP:
-      ReportStatusToSCMgr(SERVICE_STOP_PENDING, NO_ERROR, 0);
-      ServiceStop();
-      return;
-
-      // Update the service status.
-      //
-   case SERVICE_CONTROL_INTERROGATE:
-      break;
-
-      // invalid control code
-      //
-   default:
-      break;
-
-   }
-
-   ReportStatusToSCMgr(ssStatus.dwCurrentState, NO_ERROR, 0);
+  static DWORD dwCheckPoint = 1;
+  BOOL res = TRUE;
+
+  if (status->dwCurrentState == SERVICE_START_PENDING)
+    status->dwControlsAccepted = 0;
+  else
+    status->dwControlsAccepted = SERVICE_ACCEPT_STOP;
+
+  if (status->dwCurrentState == SERVICE_RUNNING ||
+      status->dwCurrentState == SERVICE_STOPPED)
+    status->dwCheckPoint = 0;
+  else
+    status->dwCheckPoint = dwCheckPoint++;
+
+  /* Report the status of the service to the service control manager. */
+  res = SetServiceStatus (service, status);
+  if (!res)
+    MsgToEventLog(MSG_FLAGS_ERROR, TEXT("SetServiceStatus"));
+
+  return res;
 }
 
-
-
-//
-//  FUNCTION: ReportStatusToSCMgr()
-//
-//  PURPOSE: Sets the current status of the service and
-//           reports it to the Service Control Manager
-//
-//  PARAMETERS:
-//    dwCurrentState - the state of the service
-//    dwWin32ExitCode - error code to report
-//    dwWaitHint - worst case estimate to next checkpoint
-//
-//  RETURN VALUE:
-//    TRUE  - success
-//    FALSE - failure
-//
-//  COMMENTS:
-//
-BOOL ReportStatusToSCMgr(DWORD dwCurrentState,
-                         DWORD dwWin32ExitCode,
-                         DWORD dwWaitHint)
+static int
+CmdInstallServices ()
 {
-   static DWORD dwCheckPoint = 1;
-   BOOL fResult = TRUE;
-
-
-   if ( !bDebug ) // when debugging we don't report to the SCM
-   {
-      if (dwCurrentState == SERVICE_START_PENDING)
-         ssStatus.dwControlsAccepted = 0;
-      else
-         ssStatus.dwControlsAccepted = SERVICE_ACCEPT_STOP;
-
-      ssStatus.dwCurrentState = dwCurrentState;
-      ssStatus.dwWin32ExitCode = dwWin32ExitCode;
-      ssStatus.dwWaitHint = dwWaitHint;
+  SC_HANDLE service;
+  SC_HANDLE svc_ctl_mgr;
+  TCHAR path[512];
+  int i, ret = _service_max;
+
+  if (GetModuleFileName (NULL, path + 1, 510) == 0)
+  {
+    _tprintf (TEXT("Unable to install service - %s\n"), GetLastErrorText ());
+    return 1;
+  }
+
+  path[0] = TEXT('\"');
+  _tcscat (path, TEXT("\""));
+
+  svc_ctl_mgr = OpenSCManager (NULL, NULL, SC_MANAGER_CONNECT | SC_MANAGER_CREATE_SERVICE);
+  if (svc_ctl_mgr == NULL)
+    {
+      _tprintf (TEXT("OpenSCManager failed - %s\n"), GetLastErrorText ());
+      return 1;
+    }
 
-      if ( ( dwCurrentState == SERVICE_RUNNING ) ||
-           ( dwCurrentState == SERVICE_STOPPED ) )
-         ssStatus.dwCheckPoint = 0;
+  for (i = 0; i < _service_max; i++)
+    {
+      service = CreateService (svc_ctl_mgr,
+                               openvpn_service[i].name,
+                               openvpn_service[i].display_name,
+                               SERVICE_QUERY_STATUS,
+                               SERVICE_WIN32_SHARE_PROCESS,
+                               openvpn_service[i].start_type,
+                               SERVICE_ERROR_NORMAL,
+                               path, NULL, NULL,
+                               openvpn_service[i].dependencies,
+                               NULL, NULL);
+      if (service)
+        {
+          _tprintf (TEXT("%s installed.\n"), openvpn_service[i].display_name);
+          CloseServiceHandle (service);
+          --ret;
+        }
       else
-         ssStatus.dwCheckPoint = dwCheckPoint++;
-
+        _tprintf (TEXT("CreateService failed - %s\n"), GetLastErrorText ());
+    }
 
-      // Report the status of the service to the service control manager.
-      //
-      if (!(fResult = SetServiceStatus( sshStatusHandle, &ssStatus)))
-      {
-         AddToMessageLog(MSG_FLAGS_ERROR, TEXT("SetServiceStatus"));
-      }
-   }
-   return fResult;
+  CloseServiceHandle (svc_ctl_mgr);
+  return ret;
 }
 
 
-
-//
-//  FUNCTION: AddToMessageLog(LPTSTR lpszMsg)
-//
-//  PURPOSE: Allows any thread to log an error message
-//
-//  PARAMETERS:
-//    lpszMsg - text for message
-//
-//  RETURN VALUE:
-//    none
-//
-//  COMMENTS:
-//
-void AddToMessageLog(DWORD flags, LPTSTR lpszMsg)
+static int
+CmdStartService (openvpn_service_type type)
 {
-   TCHAR szMsg [(sizeof(SZSERVICENAME) / sizeof(TCHAR)) + 100 ];
-   HANDLE  hEventSource;
-   LPCSTR  lpszStrings[2];
-
-   if ( !bDebug )
-   {
-     if (flags & MSG_FLAGS_SYS_CODE)
-      dwErr = GetLastError();
-     else
-       dwErr = 0;
-
-      // Use event logging to log the error.
-      //
-      hEventSource = RegisterEventSource(NULL, TEXT(SZSERVICENAME));
-
-      _stprintf(szMsg, TEXT("%s error: %d"), TEXT(SZSERVICENAME), (int)dwErr);
-      lpszStrings[0] = szMsg;
-      lpszStrings[1] = lpszMsg;
-
-      if (hEventSource != NULL)
-      {
-         ReportEvent(hEventSource, // handle of event source
-		     // event type
-                     (flags & MSG_FLAGS_ERROR)
-		       ? EVENTLOG_ERROR_TYPE : EVENTLOG_INFORMATION_TYPE,
-                     0,                    // event category
-                     0,                    // event ID
-                     NULL,                 // current user's SID
-                     2,                    // strings in lpszStrings
-                     0,                    // no bytes of raw data
-                     lpszStrings,          // array of error strings
-                     NULL);                // no raw data
-
-         (VOID) DeregisterEventSource(hEventSource);
-      }
-   }
-}
-
-void ResetError (void)
-{
-  dwErr = 0;
-}
+  int ret = 1;
+  SC_HANDLE svc_ctl_mgr;
+  SC_HANDLE service;
 
-///////////////////////////////////////////////////////////////////
-//
-//  The following code handles service installation and removal
-//
-
-
-//
-//  FUNCTION: CmdInstallService()
-//
-//  PURPOSE: Installs the service
-//
-//  PARAMETERS:
-//    none
-//
-//  RETURN VALUE:
-//    0 if success
-//
-//  COMMENTS:
-//
-int CmdInstallService()
-{
-   SC_HANDLE   schService;
-   SC_HANDLE   schSCManager;
-
-   TCHAR szPath[512];
-
-   int ret = 0;
-
-   if ( GetModuleFileName( NULL, szPath+1, 510 ) == 0 )
-   {
-      _tprintf(TEXT("Unable to install %s - %s\n"), TEXT(SZSERVICEDISPLAYNAME), GetLastErrorText(szErr, 256));
+  svc_ctl_mgr = OpenSCManager (NULL, NULL, SC_MANAGER_ALL_ACCESS);
+  if (svc_ctl_mgr == NULL)
+    {
+      _tprintf (TEXT("OpenSCManager failed - %s\n"), GetLastErrorText ());
       return 1;
-   }
-   szPath[0] = '\"';
-   strcat(szPath, "\"");
-
-   schSCManager = OpenSCManager(
-                               NULL,                   // machine (NULL == local)
-                               NULL,                   // database (NULL == default)
-                               SC_MANAGER_CONNECT | SC_MANAGER_CREATE_SERVICE  // access required
-                               );
-   if ( schSCManager )
-   {
-      schService = CreateService(
-                                schSCManager,               // SCManager database
-                                TEXT(SZSERVICENAME),        // name of service
-                                TEXT(SZSERVICEDISPLAYNAME), // name to display
-                                SERVICE_QUERY_STATUS,         // desired access
-                                SERVICE_WIN32_OWN_PROCESS,  // service type
-				SERVICE_DEMAND_START,        // start type -- alternative: SERVICE_AUTO_START
-                                SERVICE_ERROR_NORMAL,       // error control type
-                                szPath,                     // service's binary
-                                NULL,                       // no load ordering group
-                                NULL,                       // no tag identifier
-                                TEXT(SZDEPENDENCIES),       // dependencies
-                                NULL,                       // LocalSystem account
-                                NULL);                      // no password
-
-      if ( schService )
-      {
-         _tprintf(TEXT("%s installed.\n"), TEXT(SZSERVICEDISPLAYNAME) );
-         CloseServiceHandle(schService);
-      }
-      else
-      {
-         _tprintf(TEXT("CreateService failed - %s\n"), GetLastErrorText(szErr, 256));
-	 ret = 1;
-      }
-
-      CloseServiceHandle(schSCManager);
-   }
-   else
-     {
-      _tprintf(TEXT("OpenSCManager failed - %s\n"), GetLastErrorText(szErr,256));
-       ret = 1;
-     }
-   return ret;
-}
-
-//
-//  FUNCTION: CmdStartService()
-//
-//  PURPOSE: Start the service
-//
-//  PARAMETERS:
-//    none
-//
-//  RETURN VALUE:
-//    0 if success
-//
-//  COMMENTS:
-
-int CmdStartService()
-{
-  int ret = 0;
-
-  SC_HANDLE schSCManager;
-  SC_HANDLE schService;
-
-
-    // Open a handle to the SC Manager database. 
-    schSCManager = OpenSCManager( 
-       NULL,                    // local machine 
-       NULL,                    // ServicesActive database 
-       SC_MANAGER_ALL_ACCESS);  // full access rights 
-   
-    if (NULL == schSCManager) {
-       _tprintf(TEXT("OpenSCManager failed - %s\n"), GetLastErrorText(szErr,256));
-       ret = 1;
     }
 
-    schService = OpenService( 
-        schSCManager,          // SCM database 
-        SZSERVICENAME,         // service name
-        SERVICE_ALL_ACCESS); 
+  service = OpenService (svc_ctl_mgr, openvpn_service[type].name, SERVICE_ALL_ACCESS);
+  if (service)
+    {
+      if (StartService (service, 0, NULL))
+        {
+          _tprintf (TEXT("Service Started\n"));
+          ret = 0;
+        }
+      else
+        _tprintf (TEXT("StartService failed - %s\n"), GetLastErrorText ());
 
-    if (schService == NULL) {
-      _tprintf(TEXT("OpenService failed - %s\n"), GetLastErrorText(szErr,256));
-       ret = 1;
+      CloseServiceHandle(service);
     }
- 
-    if (!StartService(
-            schService,  // handle to service 
-            0,           // number of arguments 
-            NULL) )      // no arguments 
+  else
     {
-      _tprintf(TEXT("StartService failed - %s\n"), GetLastErrorText(szErr,256));
-       ret = 1;
+      _tprintf (TEXT("OpenService failed - %s\n"), GetLastErrorText ());
     }
-    else
-	{
-		_tprintf(TEXT("Service Started\n"));
-       ret = 0;
-	}
-    CloseServiceHandle(schService); 
-    CloseServiceHandle(schSCManager);
-    return ret;
-}
 
-//
-//  FUNCTION: CmdRemoveService()
-//
-//  PURPOSE: Stops and removes the service
-//
-//  PARAMETERS:
-//    none
-//
-//  RETURN VALUE:
-//    0 if success
-//
-//  COMMENTS:
-//
-int CmdRemoveService()
-{
-   SC_HANDLE   schService;
-   SC_HANDLE   schSCManager;
+  CloseServiceHandle(svc_ctl_mgr);
+  return ret;
+}
 
-   int ret = 0;
 
-   schSCManager = OpenSCManager(
-                               NULL,                   // machine (NULL == local)
-                               NULL,                   // database (NULL == default)
-                               SC_MANAGER_CONNECT   // access required
-                               );
-   if ( schSCManager )
-   {
-      schService = OpenService(schSCManager, TEXT(SZSERVICENAME), DELETE | SERVICE_STOP | SERVICE_QUERY_STATUS);
+static int
+CmdRemoveServices ()
+{
+  SC_HANDLE service;
+  SC_HANDLE svc_ctl_mgr;
+  SERVICE_STATUS status;
+  int i, ret = _service_max;
 
-      if (schService)
-      {
-         // try to stop the service
-         if ( ControlService( schService, SERVICE_CONTROL_STOP, &ssStatus ) )
-         {
-            _tprintf(TEXT("Stopping %s."), TEXT(SZSERVICEDISPLAYNAME));
-            Sleep( 1000 );
+  svc_ctl_mgr = OpenSCManager (NULL, NULL, SC_MANAGER_CONNECT);
+  if (svc_ctl_mgr == NULL)
+    {
+      _tprintf(TEXT("OpenSCManager failed - %s\n"), GetLastErrorText ());
+      return 1;
+    }
 
-            while ( QueryServiceStatus( schService, &ssStatus ) )
+  for (i = 0; i < _service_max; i++)
+    {
+      openvpn_service_t *ovpn_svc = &openvpn_service[i];
+      service = OpenService (svc_ctl_mgr, ovpn_svc->name,
+                             DELETE | SERVICE_STOP | SERVICE_QUERY_STATUS);
+      if (service == NULL)
+        {
+          _tprintf (TEXT("OpenService failed - %s\n"), GetLastErrorText ());
+          goto out;
+        }
+
+      /* try to stop the service */
+      if (ControlService (service, SERVICE_CONTROL_STOP, &status))
+        {
+          _tprintf (TEXT("Stopping %s."), ovpn_svc->display_name);
+          Sleep (1000);
+
+          while (QueryServiceStatus (service, &status))
             {
-               if ( ssStatus.dwCurrentState == SERVICE_STOP_PENDING )
-               {
-                  _tprintf(TEXT("."));
-                  Sleep( 1000 );
-               }
-               else
-                  break;
+              if (status.dwCurrentState == SERVICE_STOP_PENDING)
+                {
+                  _tprintf (TEXT("."));
+                  Sleep (1000);
+                }
+              else
+                break;
             }
 
-            if ( ssStatus.dwCurrentState == SERVICE_STOPPED )
-               _tprintf(TEXT("\n%s stopped.\n"), TEXT(SZSERVICEDISPLAYNAME) );
-            else
-	      {
-               _tprintf(TEXT("\n%s failed to stop.\n"), TEXT(SZSERVICEDISPLAYNAME) );
-		ret = 1;
-	      }
-
-         }
-
-         // now remove the service
-         if ( DeleteService(schService) )
-            _tprintf(TEXT("%s removed.\n"), TEXT(SZSERVICEDISPLAYNAME) );
-         else
-	   {
-            _tprintf(TEXT("DeleteService failed - %s\n"), GetLastErrorText(szErr,256));
-	     ret = 1;
-	   }
-
-
-         CloseServiceHandle(schService);
-      }
+          if (status.dwCurrentState == SERVICE_STOPPED)
+            _tprintf (TEXT("\n%s stopped.\n"), ovpn_svc->display_name);
+          else
+            _tprintf (TEXT("\n%s failed to stop.\n"), ovpn_svc->display_name);
+        }
+
+      /* now remove the service */
+      if (DeleteService (service))
+        {
+          _tprintf (TEXT("%s removed.\n"), ovpn_svc->display_name);
+          --ret;
+        }
       else
-	{
-         _tprintf(TEXT("OpenService failed - %s\n"), GetLastErrorText(szErr,256));
-	  ret = 1;
-	}
-
-      CloseServiceHandle(schSCManager);
-   }
-   else
-     {
-      _tprintf(TEXT("OpenSCManager failed - %s\n"), GetLastErrorText(szErr,256));
-       ret = 1;
-     }
-   return ret;
-}
-
-
-
-
-///////////////////////////////////////////////////////////////////
-//
-//  The following code is for running the service as a console app
-//
-
-
-//
-//  FUNCTION: CmdDebugService(int argc, char ** argv)
-//
-//  PURPOSE: Runs the service as a console application
-//
-//  PARAMETERS:
-//    argc - number of command line arguments
-//    argv - array of command line arguments
-//
-//  RETURN VALUE:
-//    none
-//
-//  COMMENTS:
-//
-void CmdDebugService(int argc, char ** argv)
-{
-   DWORD dwArgc;
-   LPTSTR *lpszArgv;
-
-#ifdef UNICODE
-   lpszArgv = CommandLineToArgvW(GetCommandLineW(), &(dwArgc) );
-   if (NULL == lpszArgv)
-   {
-       // CommandLineToArvW failed!!
-       _tprintf(TEXT("CmdDebugService CommandLineToArgvW returned NULL\n"));
-       return;
-   }
-#else
-   dwArgc   = (DWORD) argc;
-   lpszArgv = argv;
-#endif
-
-   _tprintf(TEXT("Debugging %s.\n"), TEXT(SZSERVICEDISPLAYNAME));
-
-   SetConsoleCtrlHandler( ControlHandler, TRUE );
+        _tprintf (TEXT("DeleteService failed - %s\n"), GetLastErrorText ());
 
-   ServiceStart( dwArgc, lpszArgv );
-
-#ifdef UNICODE
-// Must free memory allocated for arguments
-
-   GlobalFree(lpszArgv);
-#endif // UNICODE
+      CloseServiceHandle (service);
+    }
 
+out:
+  CloseServiceHandle (svc_ctl_mgr);
+  return ret;
 }
 
 
-//
-//  FUNCTION: ControlHandler ( DWORD dwCtrlType )
-//
-//  PURPOSE: Handled console control events
-//
-//  PARAMETERS:
-//    dwCtrlType - type of control event
-//
-//  RETURN VALUE:
-//    True - handled
-//    False - unhandled
-//
-//  COMMENTS:
-//
-BOOL WINAPI ControlHandler ( DWORD dwCtrlType )
+int
+_tmain (int argc, TCHAR *argv[])
 {
-   switch ( dwCtrlType )
-   {
-   case CTRL_BREAK_EVENT:  // use Ctrl+C or Ctrl+Break to simulate
-   case CTRL_C_EVENT:      // SERVICE_CONTROL_STOP in debug mode
-      _tprintf(TEXT("Stopping %s.\n"), TEXT(SZSERVICEDISPLAYNAME));
-      ServiceStop();
-      return TRUE;
-      break;
-
-   }
-   return FALSE;
-}
-
-//
-//  FUNCTION: GetLastErrorText
-//
-//  PURPOSE: copies error message text to string
-//
-//  PARAMETERS:
-//    lpszBuf - destination buffer
-//    dwSize - size of buffer
-//
-//  RETURN VALUE:
-//    destination buffer
-//
-//  COMMENTS:
-//
-LPTSTR GetLastErrorText( LPTSTR lpszBuf, DWORD dwSize )
-{
-   DWORD dwRet;
-   LPTSTR lpszTemp = NULL;
-
-   dwRet = FormatMessage( FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM |FORMAT_MESSAGE_ARGUMENT_ARRAY,
-                          NULL,
-                          GetLastError(),
-                          LANG_NEUTRAL,
-                          (LPTSTR)&lpszTemp,
-                          0,
-                          NULL );
-
-   // supplied buffer is not long enough
-   if ( !dwRet || ( (long)dwSize < (long)dwRet+14 ) )
-      lpszBuf[0] = TEXT('\0');
-   else
-   {
-      lpszTemp[lstrlen(lpszTemp)-2] = TEXT('\0');  //remove cr and newline character
-      _stprintf( lpszBuf, TEXT("%s (0x%x)"), lpszTemp, (int)GetLastError() );
-   }
-
-   if ( lpszTemp )
-      LocalFree((HLOCAL) lpszTemp );
-
-   return lpszBuf;
+  SERVICE_TABLE_ENTRY dispatchTable[] = {
+    { automatic_service.name, ServiceStartAutomatic },
+    { interactive_service.name, ServiceStartInteractive },
+    { NULL, NULL }
+  };
+
+  openvpn_service[0] = automatic_service;
+  openvpn_service[1] = interactive_service;
+
+  if (argc > 1 && (*argv[1] == TEXT('-') || *argv[1] == TEXT('/')))
+  {
+    if (_tcsicmp (TEXT("install"), argv[1] + 1) == 0)
+      return CmdInstallServices ();
+    else if (_tcsicmp (TEXT("remove"), argv[1] + 1) == 0)
+      return CmdRemoveServices ();
+    else if (_tcsicmp (TEXT("start"), argv[1] + 1) == 0)
+      {
+        BOOL is_auto = argc < 3 || _tcsicmp (TEXT("interactive"), argv[2]) != 0;
+        return CmdStartService (is_auto ? automatic : interactive);
+      }
+    else
+      goto dispatch;
+
+    return 0;
+  }
+
+  /* If it doesn't match any of the above parameters
+   * the service control manager may be starting the service
+   * so we must call StartServiceCtrlDispatcher
+   */
+dispatch:
+  _tprintf (TEXT("%s -install        to install the services\n"), APPNAME);
+  _tprintf (TEXT("%s -start <name>   to start a service (\"automatic\" or \"interactive\")\n"), APPNAME);
+  _tprintf (TEXT("%s -remove         to remove the services\n"), APPNAME);
+  _tprintf (TEXT("\nStartServiceCtrlDispatcher being called.\n"));
+  _tprintf (TEXT("This may take several seconds. Please wait.\n"));
+
+  if (!StartServiceCtrlDispatcher (dispatchTable))
+    MsgToEventLog (MSG_FLAGS_ERROR, TEXT("StartServiceCtrlDispatcher failed."));
+
+  return 0;
 }
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index e89a89f..5249b31 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -1,139 +1,90 @@
-/*---------------------------------------------------------------------------
-THIS CODE AND INFORMATION IS PROVIDED "AS IS" WITHOUT WARRANTY OF
-ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED
-TO THE IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
-PARTICULAR PURPOSE.
-
-Copyright (C) 1993 - 2000.  Microsoft Corporation.  All rights reserved.
-
- MODULE: service.h
-
- Comments:  The use of this header file and the accompanying service.c
- file simplifies the process of writting a service.  You as a developer
- simply need to follow the TODO's outlined in this header file, and
- implement the ServiceStart() and ServiceStop() functions.
-
- There is no need to modify the code in service.c.  Just add service.c
- to your project and link with the following libraries...
-
- libcmt.lib kernel32.lib advapi.lib shell32.lib
-
- This code also supports unicode.  Be sure to compile both service.c and
- and code #include "service.h" with the same Unicode setting.
-
- Upon completion, your code will have the following command line interface
-
- <service exe> -?                to display this list
- <service exe> -install          to install the service
- <service exe> -remove           to remove the service
- <service exe> -debug <params>   to run as a console app for debugging
-
- Note: This code also implements Ctrl+C and Ctrl+Break handlers
-       when using the debug option.  These console events cause
-       your ServiceStop routine to be called
-
-       Also, this code only handles the OWN_SERVICE service type
-       running in the LOCAL_SYSTEM security context.
-
-       To control your service ( start, stop, etc ) you may use the
-       Services control panel applet or the NET.EXE program.
-
-       To aid in writing/debugging service, the
-       SDK contains a utility (MSTOOLS\BIN\SC.EXE) that
-       can be used to control, configure, or obtain service status.
-       SC displays complete status for any service/driver
-       in the service database, and allows any of the configuration
-       parameters to be easily changed at the command line.
-       For more information on SC.EXE, type SC at the command line.
-
-
-------------------------------------------------------------------------------*/
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2013 Heiko Hund <heiko.hund@...1489...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
 
 #ifndef _SERVICE_H
 #define _SERVICE_H
 
-
-#ifdef __cplusplus
-extern "C" {
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
 #endif
 
-//////////////////////////////////////////////////////////////////////////////
-//// todo: change to desired strings
-////
-// name of the executable
-#define SZAPPNAME            PACKAGE "serv"
-// internal name of the service
-#define SZSERVICENAME        PACKAGE_NAME "Service"
-// displayed name of the service
-#define SZSERVICEDISPLAYNAME PACKAGE_NAME " Service"
-// list of service dependencies - "dep1\0dep2\0\0"
-#define SZDEPENDENCIES       TAP_WIN_COMPONENT_ID "\0Dhcp\0\0"
-//////////////////////////////////////////////////////////////////////////////
-
-
-
-//////////////////////////////////////////////////////////////////////////////
-//// todo: ServiceStart()must be defined by in your code.
-////       The service should use ReportStatusToSCMgr to indicate
-////       progress.  This routine must also be used by StartService()
-////       to report to the SCM when the service is running.
-////
-////       If a ServiceStop procedure is going to take longer than
-////       3 seconds to execute, it should spawn a thread to
-////       execute the stop code, and return.  Otherwise, the
-////       ServiceControlManager will believe that the service has
-////       stopped responding
-////
-   VOID ServiceStart(DWORD dwArgc, LPTSTR *lpszArgv);
-   VOID ServiceStop();
-//////////////////////////////////////////////////////////////////////////////
-
-
-
-//////////////////////////////////////////////////////////////////////////////
-//// The following are procedures which
-//// may be useful to call within the above procedures,
-//// but require no implementation by the user.
-//// They are implemented in service.c
-
-//
-//  FUNCTION: ReportStatusToSCMgr()
-//
-//  PURPOSE: Sets the current status of the service and
-//           reports it to the Service Control Manager
-//
-//  PARAMETERS:
-//    dwCurrentState - the state of the service
-//    dwWin32ExitCode - error code to report
-//    dwWaitHint - worst case estimate to next checkpoint
-//
-//  RETURN VALUE:
-//    TRUE  - success
-//    FALSE - failure
-//
-   BOOL ReportStatusToSCMgr(DWORD dwCurrentState, DWORD dwWin32ExitCode, DWORD dwWaitHint);
-
-
-//
-//  FUNCTION: AddToMessageLog(LPTSTR lpszMsg)
-//
-//  PURPOSE: Allows any thread to log an error message
-//
-//  PARAMETERS:
-//    lpszMsg - text for message
-//
-//  RETURN VALUE:
-//    none
-//
-#  define MSG_FLAGS_ERROR     (1<<0)
-#  define MSG_FLAGS_SYS_CODE  (1<<1)
-   void AddToMessageLog(DWORD flags, LPTSTR lpszMsg);
-   void ResetError (void);
-//////////////////////////////////////////////////////////////////////////////
-
-
-#ifdef __cplusplus
-}
-#endif
+#include <windows.h>
+#include <stdlib.h>
+#include <tchar.h>
+
+#define APPNAME  TEXT(PACKAGE "serv")
+#define SERVICE_DEPENDENCIES  TAP_WIN_COMPONENT_ID "\0Dhcp\0\0"
+
+/*
+ * Message handling
+ */
+#define MSG_FLAGS_ERROR     (1<<0)
+#define MSG_FLAGS_SYS_CODE  (1<<1)
+#define M_INFO    (0)                                  /* informational */
+#define M_SYSERR  (MSG_FLAGS_ERROR|MSG_FLAGS_SYS_CODE) /* error + system code */
+#define M_ERR     (MSG_FLAGS_ERROR)                    /* error */
+
+typedef enum {
+  automatic,
+  interactive,
+  _service_max
+} openvpn_service_type;
+
+typedef struct {
+  openvpn_service_type type;
+  TCHAR *name;
+  TCHAR *display_name;
+  TCHAR *dependencies;
+  DWORD start_type;
+} openvpn_service_t;
+
+typedef struct {
+  TCHAR exe_path[MAX_PATH];
+  TCHAR config_dir[MAX_PATH];
+  TCHAR ext_string[16];
+  TCHAR log_dir[MAX_PATH];
+  DWORD priority;
+  BOOL append;
+} settings_t;
+
+extern openvpn_service_t automatic_service;
+extern openvpn_service_t interactive_service;
+
+
+VOID WINAPI ServiceStartAutomatic (DWORD argc, LPTSTR *argv);
+VOID WINAPI ServiceStartInteractive (DWORD argc, LPTSTR *argv);
+
+int openvpn_vsntprintf (LPTSTR str, size_t size, LPCTSTR format, va_list arglist);
+int openvpn_sntprintf (LPTSTR str, size_t size, LPCTSTR format, ...);
+
+DWORD GetOpenvpnSettings (settings_t *s);
+
+BOOL ReportStatusToSCMgr (SERVICE_STATUS_HANDLE service, SERVICE_STATUS *status);
+
+LPCTSTR GetLastErrorText ();
+DWORD MsgToEventLog (DWORD flags, LPCTSTR lpszMsg, ...);
 
 #endif
-- 
1.9.1


