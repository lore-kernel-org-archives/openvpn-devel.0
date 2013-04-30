From: Arne Schwabe <arne@...1227...>
Date: Tue, 30 Apr 2013 21:29:11 +0200
Message-Id: <1367350151-23089-1-git-send-email-arne@...1227...>
In-Reply-To: <5180085E.5000005@...1114...>
References: <5180085E.5000005@...1114...>
Subject: [Openvpn-devel] [Patch v5 3/4] Android platform specific changes.
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

On Android 4.0 (TARGET_ANDROID) the real opening of the tun is handled by the (Java) application controlling OpenVPN. Instead of calling ifconfig/route call the management to do the work. When running openvpn as root openvpn should be compiled as TARGET_LINUX

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/manage.c  |   14 ++++++++
 src/openvpn/manage.h  |    4 +++
 src/openvpn/options.c |    6 ++++
 src/openvpn/route.c   |   18 ++++++++--
 src/openvpn/socket.c  |   10 ++++++
 src/openvpn/ssl.c     |    2 ++
 src/openvpn/syshead.h |    2 +-
 src/openvpn/tun.c     |   87 +++++++++++++++++++++++++++++++++++++++++++++++--
 src/openvpn/tun.h     |    8 ++++-
 9 files changed, 145 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 80c469e..8dbb0bb 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1849,6 +1849,20 @@ static ssize_t man_recv_with_fd (int fd, void *ptr, size_t nbytes, int flags, in
     
   return (n);
 }
+
+/*
+ * The android control method will instruct the GUI part of openvpn to
+ * do the route/ifconfig/open tun command. 
+ */
+bool management_android_control (struct management *man, const char *command, const char *msg)
+{
+  struct user_pass up;    
+  CLEAR(up);
+  strncpy (up.username, msg, sizeof(up.username)-1);
+  
+  management_query_user_pass(management, &up , command, GET_USER_PASS_NEED_OK,(void*) 0);
+  return strcmp ("ok", up.password)==0;
+}
 #endif
 
 static int
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index f5d776e..b08bb78 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -376,6 +376,10 @@ bool management_query_user_pass (struct management *man,
 				 const unsigned int flags,
 				 const char *static_challenge);
 
+#ifdef TARGET_ANDROID
+bool management_android_control (struct management *man, const char *command, const char *msg);
+#endif
+
 bool management_should_daemonize (struct management *man);
 bool management_would_hold (struct management *man);
 bool management_hold (struct management *man);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 05c6da2..9fdfd88 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1125,7 +1125,9 @@ show_tuntap_options (const struct tuntap_options *o)
 }
 
 #endif
+#endif
 
+#if defined(WIN32) || defined(TARGET_ANDROID) 
 static void
 dhcp_option_address_parse (const char *name, const char *parm, in_addr_t *array, int *len, int msglevel)
 {
@@ -5935,6 +5937,8 @@ add_option (struct options *options,
       to->ip_win32_type = index;
       to->ip_win32_defined = true; 
     }
+#endif
+#if defined(WIN32) || defined(TARGET_ANDROID)
   else if (streq (p[0], "dhcp-option") && p[1])
     {
       struct tuntap_options *o = &options->tuntap_options;
@@ -5986,6 +5990,8 @@ add_option (struct options *options,
 	}
       o->dhcp_options = true;
     }
+#endif
+#ifdef WIN32
   else if (streq (p[0], "show-adapters"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 4c1e14e..ff10734 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1342,6 +1342,12 @@ add_route (struct route *r,
   argv_msg (D_ROUTE, &argv);
   status = openvpn_execve_check (&argv, es, 0, "ERROR: Linux route add command failed");
 
+#elif defined (TARGET_ANDROID)
+  struct buffer out = alloc_buf_gc (64, &gc);
+
+  buf_printf (&out, "%s %s", network, netmask);
+  management_android_control (management, "ROUTE", buf_bptr(&out));
+  
 #elif defined (WIN32)
   {
     DWORD ai = TUN_ADAPTER_INDEX_INVALID;
@@ -1616,6 +1622,13 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
   argv_msg (D_ROUTE, &argv);
   status = openvpn_execve_check (&argv, es, 0, "ERROR: Linux route -6/-A inet6 add command failed");
 
+#elif defined (TARGET_ANDROID)
+    struct buffer out = alloc_buf_gc (64, &gc);
+
+    buf_printf (&out, "%s/%d", network, r6->netbits);
+
+    management_android_control (management, "ROUTE6", buf_bptr(&out));
+
 #elif defined (WIN32)
 
   /* netsh interface ipv6 add route 2001:db8::/32 MyTunDevice */
@@ -1875,7 +1888,8 @@ delete_route (struct route *r,
 
   argv_msg (D_ROUTE, &argv);
   openvpn_execve_check (&argv, es, 0, "ERROR: OpenBSD/NetBSD route delete command failed");
-
+#elif defined(TARGET_ANDROID)
+  msg (M_NONFATAL, "Sorry, deleting routes on Android is not possible. The VpnService API allows routes to be set on connect only.");
 #else
   msg (M_FATAL, "Sorry, but I don't know how to do 'route' commands on this operating system.  Try putting your routes in a --route-up script");
 #endif
@@ -2425,7 +2439,7 @@ show_routes (int msglev)
   gc_free (&gc);
 }
 
-#elif defined(TARGET_LINUX)
+#elif defined(TARGET_LINUX) || defined(TARGET_ANDROID)
 
 void
 get_default_gateway (struct route_gateway_info *rgi)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8eb112b..9bb8cff 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -38,6 +38,7 @@
 #include "ps.h"
 #include "manage.h"
 #include "misc.h"
+#include "manage.h"
 
 #include "memdbg.h"
 
@@ -725,6 +726,15 @@ create_socket (struct link_socket *sock)
     {
       ASSERT (0);
     }
+#ifdef TARGET_ANDROID
+  /* pass socket FD to management interface to pass on to VPNService API 
+   * as "protected socket" (exempt from being routed into tunnel)
+   */
+  
+  management->connection.fdtosend = sock->sd;
+  management_android_control (management, "PROTECTFD", __func__);
+#endif
+    
 }
 
 /*
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 43b3980..b367386 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1797,6 +1797,8 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
       buf_printf (&out, "IV_PLAT=netbsd\n");
 #elif defined(TARGET_FREEBSD)
       buf_printf (&out, "IV_PLAT=freebsd\n");
+#elif defined(TARGET_ANDROID)
+      buf_printf(&out, "IV_PLAT=android\n");
 #elif defined(WIN32)
       buf_printf (&out, "IV_PLAT=win\n");
 #endif
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 4db29cc..0c3e4ee 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -212,7 +212,7 @@
 #include <net/if_tap.h>
 #endif
 
-#ifdef TARGET_LINUX
+#if defined(TARGET_LINUX) || defined (TARGET_ANDROID)
 
 #if defined(HAVE_NETINET_IF_ETHER_H)
 #include <netinet/if_ether.h>
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index a361233..76510e9 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -48,6 +48,7 @@
 #include "win32.h"
 
 #include "memdbg.h"
+#include <string.h>
 
 #ifdef WIN32
 
@@ -764,8 +765,36 @@ do_ifconfig (struct tuntap *tt,
       tt->did_ifconfig = true;
 
 #endif /*ENABLE_IPROUTE*/
+#elif defined(TARGET_ANDROID)
+        
+      if (do_ipv6) {
+          struct buffer out6 = alloc_buf_gc (64, &gc);
+          buf_printf (&out6, "%s/%d", ifconfig_ipv6_local,tt->netbits_ipv6);
+          management_android_control(management, "IFCONFIG6",buf_bptr(&out6));
+      }
+      
+      struct buffer out = alloc_buf_gc (64, &gc);
+
+      char* top;
+      switch(tt->topology) {
+      case TOP_NET30:
+          top = "net30";
+          break;
+      case TOP_P2P:
+          top="p2p";
+          break;
+      case TOP_SUBNET:
+          top="subnet";
+          break;
+      default:
+          top="undef";
+      }
+      
+      buf_printf (&out, "%s %s %d %s", ifconfig_local, ifconfig_remote_netmask, tun_mtu, top);
+      management_android_control (management, "IFCONFIG", buf_bptr(&out));
+        
 #elif defined(TARGET_SOLARIS)
-
+      
       /* Solaris 2.6 (and 7?) cannot set all parameters in one go...
        * example:
        *    ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 up
@@ -1368,8 +1397,62 @@ close_tun_generic (struct tuntap *tt)
 
 #endif
 
-#if defined(TARGET_LINUX)
+#if defined (TARGET_ANDROID)
+void
+open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+{
+#define ANDROID_TUNNAME "vpnservice-tun"
+  int i;
+  struct user_pass up;
+  struct gc_arena gc = gc_new ();
+  bool opentun;
+  
+  for (i = 0; i < tt->options.dns_len; ++i) {
+    management_android_control (management, "DNSSERVER",
+                                print_in_addr_t(tt->options.dns[i], 0, &gc));
+  }
+
+  if(tt->options.domain) 
+    management_android_control (management, "DNSDOMAIN", tt->options.domain);
+    
+  opentun = management_android_control (management, "OPENTUN", dev);
+
+  /* Pick up the fd from management interface after calling the OPENTUN command */
+  tt->fd = management->connection.lastfdreceived;
+  management->connection.lastfdreceived=-1;
+    
+  /* Set the actual name to a dummy name */
+  tt->actual_name = string_alloc (ANDROID_TUNNAME, NULL);
+
+  if ((tt->fd < 0) || !opentun)
+    msg (M_ERR, "ERROR: Cannot open TUN");
+
+  gc_free (&gc);
+}
+
+void
+close_tun (struct tuntap *tt)
+{
+    if (tt)
+    {
+        close_tun_generic (tt);
+        free (tt);
+    }
+}
+
+int
+write_tun (struct tuntap* tt, uint8_t *buf, int len)
+{
+    return write (tt->fd, buf, len);
+}
+
+int
+read_tun (struct tuntap* tt, uint8_t *buf, int len)
+{
+    return read (tt->fd, buf, len);
+}
 
+#elif defined(TARGET_LINUX)
 #ifdef HAVE_LINUX_IF_TUN_H	/* New driver support */
 
 #ifndef HAVE_LINUX_SOCKIOS_H
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 63e4b5c..956ad8d 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -38,7 +38,7 @@
 #include "proto.h"
 #include "misc.h"
 
-#ifdef WIN32
+#if defined(WIN32) || defined(TARGET_ANDROID)
 
 #define TUN_ADAPTER_INDEX_INVALID ((DWORD)-1)
 
@@ -292,6 +292,8 @@ ifconfig_order(void)
   return IFCONFIG_AFTER_TUN_OPEN;
 #elif defined(WIN32)
   return IFCONFIG_BEFORE_TUN_OPEN;
+#elif defined(TARGET_ANDROID)
+  return IFCONFIG_BEFORE_TUN_OPEN;
 #else
   return IFCONFIG_DEFAULT;
 #endif
@@ -304,7 +306,11 @@ ifconfig_order(void)
 static inline int
 route_order(void)
 {
+#if defined(TARGET_ANDROID)
+    return ROUTE_BEFORE_TUN;
+#else
     return ROUTE_ORDER_DEFAULT;
+#endif
 }
 
 
-- 
1.7.9.5


