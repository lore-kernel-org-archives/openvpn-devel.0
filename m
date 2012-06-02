From: Arne Schwabe <arne@...1227...>
Date: Sat,  2 Jun 2012 15:03:43 +0200
Message-Id: <1338642223-20324-9-git-send-email-arne@...1227...>
In-Reply-To: <1338642223-20324-1-git-send-email-arne@...1227...>
References: <1338642223-20324-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 8/8] Android platform specific changes.
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


Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c |    6 +++
 src/openvpn/route.c   |   25 +++++++++++++-
 src/openvpn/socket.c  |   10 +++++
 src/openvpn/ssl.c     |    2 +
 src/openvpn/syshead.h |    2 +-
 src/openvpn/tun.c     |   88 ++++++++++++++++++++++++++++++++++++++++++++++++-
 src/openvpn/tun.h     |    8 ++++-
 7 files changed, 136 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9ed4ff5..7b7fc68 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1129,7 +1129,9 @@ show_tuntap_options (const struct tuntap_options *o)
 }
 
 #endif
+#endif
 
+#if defined(WIN32) || defined(TARGET_ANDROID) 
 static void
 dhcp_option_address_parse (const char *name, const char *parm, in_addr_t *array, int *len, int msglevel)
 {
@@ -6060,6 +6062,8 @@ add_option (struct options *options,
       to->ip_win32_type = index;
       to->ip_win32_defined = true; 
     }
+#endif
+#if defined(WIN32) || defined(TARGET_ANDROID)
   else if (streq (p[0], "dhcp-option") && p[1])
     {
       struct tuntap_options *o = &options->tuntap_options;
@@ -6111,6 +6115,8 @@ add_option (struct options *options,
 	}
       o->dhcp_options = true;
     }
+#endif
+#ifdef WIN32
   else if (streq (p[0], "show-adapters"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 7c25c77..7c02d6f 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1344,6 +1344,17 @@ add_route (struct route *r,
   argv_msg (D_ROUTE, &argv);
   status = openvpn_execve_check (&argv, es, 0, "ERROR: Linux route add command failed");
 
+#elif defined (TARGET_ANDROID)
+
+    struct user_pass up;    
+    struct buffer out = alloc_buf_gc (64, &gc);
+
+    buf_printf (&out, "%s %s", network, netmask);
+
+    strcpy(up.username, buf_bptr(&out));
+    management_query_user_pass(management, &up , "ROUTE", GET_USER_PASS_NEED_OK,(void*) 0);
+
+
 #elif defined (WIN32)
   {
     DWORD ai = TUN_ADAPTER_INDEX_INVALID;
@@ -1597,6 +1608,15 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
   argv_msg (D_ROUTE, &argv);
   status = openvpn_execve_check (&argv, es, 0, "ERROR: Linux route -6/-A inet6 add command failed");
 
+#elif defined (TARGET_ANDROID)
+    struct user_pass up;    
+    struct buffer out = alloc_buf_gc (64, &gc);
+    
+    buf_printf (&out, "%s/%d", network, r6->netbits);
+    
+    strcpy(up.username, buf_bptr(&out));
+    management_query_user_pass(management, &up , "ROUTE6", GET_USER_PASS_NEED_OK,(void*) 0);
+
 #elif defined (WIN32)
 
   /* netsh interface ipv6 add route 2001:db8::/32 MyTunDevice */
@@ -1847,7 +1867,8 @@ delete_route (struct route *r,
 
   argv_msg (D_ROUTE, &argv);
   openvpn_execve_check (&argv, es, 0, "ERROR: OpenBSD/NetBSD route delete command failed");
-
+#elif defined(TARGET_ANDROID)
+  msg (M_NONFATAL, "Sorry, deleting routes on Android is not possible. The VpnService API allows routes to be set on connect only.");
 #else
   msg (M_FATAL, "Sorry, but I don't know how to do 'route' commands on this operating system.  Try putting your routes in a --route-up script");
 #endif
@@ -2371,7 +2392,7 @@ show_routes (int msglev)
   gc_free (&gc);
 }
 
-#elif defined(TARGET_LINUX)
+#elif defined(TARGET_LINUX) || defined(TARGET_ANDROID)
 
 void
 get_default_gateway (struct route_gateway_info *rgi)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 6b1f8d2..d417172 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -38,6 +38,7 @@
 #include "ps.h"
 #include "manage.h"
 #include "misc.h"
+#include "manage.h"
 
 #include "memdbg.h"
 
@@ -959,6 +960,15 @@ create_socket (struct link_socket *sock)
     {
       ASSERT (0);
     }
+#ifdef TARGET_ANDROID
+    struct user_pass up;
+    strcpy(up.username ,__func__);
+    management->connection.fdtosend = sock->sd;
+    management_query_user_pass(management, &up , "PROTECTFD", GET_USER_PASS_NEED_OK,(void*) 0);
+
+
+#endif
+    
 }
 
 /*
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 19512c0..9f570b9 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1650,6 +1650,8 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
       buf_printf (&out, "IV_PLAT=netbsd\n");
 #elif defined(TARGET_FREEBSD)
       buf_printf (&out, "IV_PLAT=freebsd\n");
+#elif defined(TARGET_ANDROID)
+      buf_printf(&out, "IV_PLAT=android\n");
 #elif defined(WIN32)
       buf_printf (&out, "IV_PLAT=win\n");
 #endif
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index f5c8774..ed00e82 100644
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
index 633150f..8057c16 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -48,6 +48,7 @@
 #include "win32.h"
 
 #include "memdbg.h"
+#include <string.h>
 
 #ifdef WIN32
 
@@ -768,6 +769,40 @@ do_ifconfig (struct tuntap *tt,
       tt->did_ifconfig = true;
 
 #endif /*ENABLE_IPROUTE*/
+#elif defined(TARGET_ANDROID)
+        
+        
+        if (do_ipv6) {
+            struct user_pass up6;    
+            struct buffer out6 = alloc_buf_gc (64, &gc);
+            buf_printf (&out6, "%s/%d", ifconfig_ipv6_local,tt->netbits_ipv6);
+            strcpy(up6.username, buf_bptr(&out6));
+            management_query_user_pass(management, &up6 , "IFCONFIG6", GET_USER_PASS_NEED_OK,(void*) 0);
+        }
+
+        struct user_pass up;    
+        struct buffer out = alloc_buf_gc (64, &gc);
+        char* top;
+        switch(tt->topology) {
+            case TOP_NET30:
+                top = "net30";
+                break;
+            case TOP_P2P:
+                top="p2p";
+                break;
+            case TOP_SUBNET:
+                top="subnet";
+                break;
+            default:
+                top="undef";
+        }
+        
+        buf_printf (&out, "%s %s %d %s", ifconfig_local, ifconfig_remote_netmask, tun_mtu,top);
+        strcpy(up.username, buf_bptr(&out));
+        management_query_user_pass(management, &up , "IFCONFIG", GET_USER_PASS_NEED_OK,(void*) 0);
+
+
+        
 #elif defined(TARGET_SOLARIS)
 
       /* Solaris 2.6 (and 7?) cannot set all parameters in one go...
@@ -1365,8 +1400,59 @@ close_tun_generic (struct tuntap *tt)
 
 #endif
 
-#if defined(TARGET_LINUX)
+#if defined (TARGET_ANDROID)
+void
+open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+{
+    int i;
+    struct user_pass up;
+    struct gc_arena gc = gc_new ();
+    
+    for (i = 0; i < tt->options.dns_len; ++i) {
+        strcpy(up.username, print_in_addr_t(tt->options.dns[i], 0, &gc));
+        management_query_user_pass(management, &up , "DNSSERVER", GET_USER_PASS_NEED_OK,(void*) 0);
+    }
+
+    if(tt->options.domain) {
+        strcpy(up.username , tt->options.domain);
+        management_query_user_pass(management, &up , "DNSDOMAIN", GET_USER_PASS_NEED_OK,(void*) 0);
+    }
+    
+    strcpy(up.username , dev);
+    management_query_user_pass(management, &up , "OPENTUN", GET_USER_PASS_NEED_OK,(void*) 0);
+
+    tt->fd = management->connection.lastfdreceived;
+    management->connection.lastfdreceived=-1;
+    
+    if( (tt->fd < 0) || ! (strcmp("ok",up.password)==0)) {
+        msg (M_ERR, "ERROR: Cannot open TUN");
+    }
+    gc_free (&gc);
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
index 60d75c8..0f4f012 100644
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
1.7.7.5 (Apple Git-26)


