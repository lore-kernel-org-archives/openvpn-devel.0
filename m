Message-ID: <4FAAE0A1.2080808@...1227...>
Date: Wed, 09 May 2012 23:24:49 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040807070708080603080405"
Subject: [Openvpn-devel] [PATCH] Openvpn for Android 4.0 Changeset
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------040807070708080603080405
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hello,

I have developed the port of openvpn for Android 4.0:
https://play.google.com/store/apps/details?id=de.blinkt.openvpn and
http://code.google.com/p/ics-openvpn/

The API of Android 4.0 requires that openvpn runs as completely
unprivileged process. There all opening of tun, adding of routes,
ifconfig etc. has to be done by another process.

This patch implements an API to allow pushing routes, dns, tun over the
management interface (unix socket). Also on Android 4.0 the connection
for the control has to be protect via an API call from the Java GUI.

Basically I am using the needok feature of the management protocol to
push all relevant information to the GUI or to request information. I
have not split the patch into multiple small patches because it should
be first discussed if this is right architectural way.


Arne

--------------040807070708080603080405
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
	name="android.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="android.diff"

From 8997c9b0029588a2e2f814f06c9ee1dfe1e4d3a4 Mon Sep 17 00:00:00 2001
From: Arne Schwabe <arne@...1227...>
Date: Tue, 1 May 2012 14:04:22 +0200
Subject: [PATCH] rebase on head

---
 src/openvpn/error.c   |   86 +++++++++++++++++++++++++++++--------------------
 src/openvpn/event.c   |    4 ++
 src/openvpn/init.c    |   10 +++++-
 src/openvpn/manage.c  |   11 ++++--
 src/openvpn/options.c |    7 ++++
 src/openvpn/route.c   |    7 +++-
 src/openvpn/socket.c  |   25 ++++++++++++++
 src/openvpn/ssl.c     |    2 +
 src/openvpn/syshead.h |    2 +-
 src/openvpn/tun.c     |   29 +++++++++++++++-
 src/openvpn/tun.h     |   22 ++++++++++++-
 11 files changed, 160 insertions(+), 45 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index d6ad639..6849794 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -199,6 +199,11 @@ msg_fp(const unsigned int flags)
 
 int x_msg_line_num; /* GLOBAL */
 
+#include "android/log.h"
+ 
+
+
+
 void x_msg (const unsigned int flags, const char *format, ...)
 {
   struct gc_arena gc;
@@ -214,6 +219,7 @@ void x_msg (const unsigned int flags, const char *format, ...)
   const char *prefix_sep;
 
   void usage_small (void);
+    
 
 #ifndef HAVE_VARARG_MACROS
   /* the macro has checked this otherwise */
@@ -298,58 +304,65 @@ void x_msg (const unsigned int flags, const char *format, ...)
   if (!prefix)
     prefix_sep = prefix = "";
 
+
   /* virtual output capability used to copy output to management subsystem */
   if (!forked)
     {
       const struct virtual_output *vo = msg_get_virtual_output ();
+        
       if (vo)
 	{
 	  openvpn_snprintf (m2, ERR_BUF_SIZE, "%s%s%s",
 			    prefix,
 			    prefix_sep,
 			    m1);
-	  virtual_output_print (vo, flags, m2);
+        virtual_output_print (vo, flags, m2);
 	}
     }
 
-  if (!(flags & M_MSG_VIRT_OUT))
+  if (!(flags & M_MSG_VIRT_OUT) )
     {
-      if (use_syslog && !std_redir && !forked)
-	{
+        if (use_syslog && !std_redir && !forked)
+        {
 #if SYSLOG_CAPABILITY
-	  syslog (level, "%s%s%s",
-		  prefix,
-		  prefix_sep,
-		  m1);
+            syslog (level, "%s%s%s",
+                    prefix,
+                    prefix_sep,
+                    m1); 
+#endif
+        }
+        else // No Syslog
+        {
+            FILE *fp = msg_fp(flags);
+            const bool show_usec = check_debug_level (DEBUG_LEVEL_USEC_TIME);
+            
+            if ((flags & M_NOPREFIX) || suppress_timestamps)
+            {
+                fprintf (fp, "%s%s%s%s",
+                         prefix,
+                         prefix_sep,
+                         m1,
+                         (flags&M_NOLF) ? "" : "\n");
+            }
+            else
+            {
+                fprintf (fp, "%s %s%s%s%s",
+                         time_string (0, 0, show_usec, &gc),
+                         prefix,
+                         prefix_sep,
+                         m1,
+                         (flags&M_NOLF) ? "" : "\n"); 
+            }
+            fflush(fp);
+            ++x_msg_line_num;
+        }
+#ifdef TARGET_ANDROID
+        android_openvpn_log(prefix,prefix_sep,m1);;
 #endif
-	}
-      else
-	{
-	  FILE *fp = msg_fp(flags);
-	  const bool show_usec = check_debug_level (DEBUG_LEVEL_USEC_TIME);
-
-	  if ((flags & M_NOPREFIX) || suppress_timestamps)
-	    {
-	      fprintf (fp, "%s%s%s%s",
-		       prefix,
-		       prefix_sep,
-		       m1,
-		       (flags&M_NOLF) ? "" : "\n");
-	    }
-	  else
-	    {
-	      fprintf (fp, "%s %s%s%s%s",
-		       time_string (0, 0, show_usec, &gc),
-		       prefix,
-		       prefix_sep,
-		       m1,
-		       (flags&M_NOLF) ? "" : "\n");
-	    }
-	  fflush(fp);
-	  ++x_msg_line_num;
-	}
     }
 
+
+    
   if (flags & M_FATAL)
     msg (M_INFO, "Exiting due to fatal error");
 
@@ -701,7 +714,10 @@ openvpn_exit (const int status)
       if (status == OPENVPN_EXIT_STATUS_GOOD)
 	perf_output_results ();
     }
-
+#ifdef TARGET_ANDROID
+    android_openvpn_exit(status);
+#endif
+    
   exit (status);
 }
 
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 2a13e1c..0463d98 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -753,6 +753,10 @@ po_wait (struct event_set *es, const struct timeval *tv, struct event_set_return
 	      ++out;
 	      ++j;
 	    }
+      else if(pfdp->revents==0x0020) 
+        {
+            openvpn_exit (OPENVPN_EXIT_STATUS_ERROR);
+        }
 	  else if (pfdp->revents)
 	    {
 	      msg (D_EVENT_ERRORS, "Error: poll: unknown revents=0x%04x", (unsigned int)pfdp->revents);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 61ced5d..cc94b81 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1477,6 +1477,13 @@ do_open_tun (struct context *c)
 						&gc);
 	  do_ifconfig (c->c1.tuntap, guess, TUN_MTU_SIZE (&c->c2.frame), c->c2.es);
 	}
+        
+        /* possibly add routes */
+        if(ifconfig_order() == ROUTE_BEFORE_TUN) {
+            if (!c->options.route_delay_defined)
+                do_route (&c->options, c->c1.route_list, c->c1.route_ipv6_list,
+                          c->c1.tuntap, c->plugins, c->c2.es);
+        }
 
       /* open the tun device */
       open_tun (c->options.dev, c->options.dev_type, c->options.dev_node,
@@ -1509,10 +1516,11 @@ do_open_tun (struct context *c)
 		   c->c2.es);
 
       /* possibly add routes */
+        if(ifconfig_order() == ROUTE_AFTER_TUN) {
       if (!c->options.route_delay_defined)
 	do_route (&c->options, c->c1.route_list, c->c1.route_ipv6_list,
 		  c->c1.tuntap, c->plugins, c->c2.es);
-
+        }
       /*
        * Did tun/tap driver give us an MTU?
        */
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 1dddd41..1a6c086 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1479,13 +1479,14 @@ man_new_connection_post (struct management *man, const char *description)
 #if UNIX_SOCK_SUPPORT
   if (man->settings.flags & MF_UNIX_SOCK)
     {
-      msg (D_MANAGEMENT, "MANAGEMENT: %s %s",
-	   description,
-	   sockaddr_unix_name (&man->settings.local_unix, "NULL"));
+        msg (D_MANAGEMENT, "MANAGEMENT(unix): %s %s",
+             description,
+             sockaddr_unix_name (&man->settings.local_unix, "NULL"));
+ 
     }
   else
 #endif
-    msg (D_MANAGEMENT, "MANAGEMENT: %s %s",
+    msg (D_MANAGEMENT, "MANAGEMENT(tcp): %s %s",
 	 description,
 	 print_sockaddr (&man->settings.local, &gc));
 
@@ -2690,6 +2691,7 @@ management_socket_set (struct management *man,
 void
 management_io (struct management *man)
 {
+    msg(D_MANAGEMENT,"M I/O State %d in",man->connection.state);
   switch (man->connection.state)
     {
     case MS_LISTEN:
@@ -2706,6 +2708,7 @@ management_io (struct management *man)
     default:
       ASSERT (0);
     }
+    msg(D_MANAGEMENT,"M I/O State %d out",man->connection.state);
 }
 
 #endif
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7769625..bd6382f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -564,6 +564,7 @@ static const char usage_message[] =
 #if OPENSSL_VERSION_NUMBER >= 0x00907000L
   " and CRLs).\n"
 #else /* OPENSSL_VERSION_NUMBER >= 0x00907000L */
+#error WTF!
   ").\n"
   "                  WARNING: no support of CRL available with this version.\n"
 #endif /* OPENSSL_VERSION_NUMBER >= 0x00907000L */
@@ -1140,7 +1141,9 @@ show_tuntap_options (const struct tuntap_options *o)
 }
 
 #endif
+#endif
 
+#if defined(WIN32) || defined(TARGET_ANDROID) 
 static void
 dhcp_option_address_parse (const char *name, const char *parm, in_addr_t *array, int *len, int msglevel)
 {
@@ -6064,6 +6067,8 @@ add_option (struct options *options,
       to->ip_win32_type = index;
       to->ip_win32_defined = true; 
     }
+#endif
+#if defined(WIN32) || defined(TARGET_ANDROID)
   else if (streq (p[0], "dhcp-option") && p[1])
     {
       struct tuntap_options *o = &options->tuntap_options;
@@ -6115,6 +6120,8 @@ add_option (struct options *options,
 	}
       o->dhcp_options = true;
     }
+#endif
+#ifdef WIN32
   else if (streq (p[0], "show-adapters"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 7c25c77..6c3ad90 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1344,6 +1344,11 @@ add_route (struct route *r,
   argv_msg (D_ROUTE, &argv);
   status = openvpn_execve_check (&argv, es, 0, "ERROR: Linux route add command failed");
 
+#elif defined (TARGET_ANDROID)
+#include "jniglue.h"
+
+    addRouteInformation(network, netmask, gateway);
+
 #elif defined (WIN32)
   {
     DWORD ai = TUN_ADAPTER_INDEX_INVALID;
@@ -2371,7 +2376,7 @@ show_routes (int msglev)
   gc_free (&gc);
 }
 
-#elif defined(TARGET_LINUX)
+#elif defined(TARGET_LINUX) || defined(TARGET_ANDROID)
 
 void
 get_default_gateway (struct route_gateway_info *rgi)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 6b1f8d2..364b97e 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -41,6 +41,11 @@
 
 #include "memdbg.h"
 
+#ifdef TARGET_ANDROID
+#include "jniglue.h"
+#endif 
+
+
 const int proto_overhead[] = { /* indexed by PROTO_x */
   0,
   IPv4_UDP_HEADER_SIZE, /* IPv4 */
@@ -858,6 +863,11 @@ create_socket_tcp (void)
   }
 #endif
 
+#ifdef TARGET_ANDROID
+    /* Protects the socket from being routed via VPN */
+    android_protect_socket(sd);
+#endif
+
   return sd;
 }
 
@@ -885,6 +895,12 @@ create_socket_udp (const unsigned int flags)
 #endif
     }
 #endif
+
+#ifdef TARGET_ANDROID
+    /* Protects the socket from being routed via VPN */
+    android_protect_socket(sd);
+#endif
+
   return sd;
 }
 
@@ -904,6 +920,11 @@ create_socket_udp6 (const unsigned int flags)
 	msg(M_SOCKERR, "UDP: failed setsockopt for IPV6_RECVPKTINFO");
     }
 #endif
+#ifdef TARGET_ANDROID
+    /* Protects the socket from being routed via VPN */
+    android_protect_socket(sd);
+#endif
+
   return sd;
 }
 
@@ -922,6 +943,10 @@ create_socket_tcp6 (void)
 		    (void *) &on, sizeof (on)) < 0)
       msg (M_SOCKERR, "TCP: Cannot setsockopt SO_REUSEADDR on TCP6 socket");
   }
+#ifdef TARGET_ANDROID
+    /* Protects the socket from being routed via VPN */
+    android_protect_socket(sd);
+#endif
 
   return sd;
 }
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
index 3337764..8ce40f7 100644
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
index 633150f..7aa8627 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -49,6 +49,11 @@
 
 #include "memdbg.h"
 
+#ifdef TARGET_ANDROID
+#include "jniglue.h"
+#endif
+
+
 #ifdef WIN32
 
 /* #define SIMULATE_DHCP_FAILED */       /* simulate bad DHCP negotiation */
@@ -768,6 +773,8 @@ do_ifconfig (struct tuntap *tt,
       tt->did_ifconfig = true;
 
 #endif /*ENABLE_IPROUTE*/
+#elif defined(TARGET_ANDROID)
+       addInterfaceInformation(tun_mtu,ifconfig_local, ifconfig_remote_netmask);
 #elif defined(TARGET_SOLARIS)
 
       /* Solaris 2.6 (and 7?) cannot set all parameters in one go...
@@ -1365,7 +1372,24 @@ close_tun_generic (struct tuntap *tt)
 
 #endif
 
-#if defined(TARGET_LINUX)
+#if defined(TARGET_LINUX) || defined(TARGET_ANDROID)
+
+#if defined (TARGET_ANDROID)
+void
+open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+{
+    struct gc_arena gc = gc_new ();
+    int i;
+    for (i = 0; i < tt->options.dns_len; ++i) {
+        android_set_dns(print_in_addr_t(tt->options.dns[i], 0, &gc));
+    }
+
+    if(tt->options.domain)
+        android_set_domain(tt->options.domain);
+    tt->fd = android_open_tun();
+}
+
+#else
 
 #ifdef HAVE_LINUX_IF_TUN_H	/* New driver support */
 
@@ -1411,7 +1435,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
       if (!tt->ipv6)
 	ifr.ifr_flags = IFF_NO_PI;
 
-#if defined(IFF_ONE_QUEUE) && defined(SIOCSIFTXQLEN)
+#if defined(IFF_ONE_QUEUE) && defined(SIOCSIFTXQLEN) && !defined(TARGET_ANDROID)
       ifr.ifr_flags |= IFF_ONE_QUEUE;
 #endif
 
@@ -1501,6 +1525,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 }
 
 #endif /* HAVE_LINUX_IF_TUN_H */
+#endif /* TARGET_ANDROID */
 
 #ifdef ENABLE_FEATURE_TUN_PERSIST
 
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 9bd990f..095e77e 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -38,7 +38,7 @@
 #include "proto.h"
 #include "misc.h"
 
-#ifdef WIN32
+#if defined(WIN32) || defined(TARGET_ANDROID)
 
 #define TUN_ADAPTER_INDEX_INVALID ((DWORD)-1)
 
@@ -76,6 +76,7 @@ struct tuntap_options {
 
   int netbios_node_type;     /* NBT 1,2,4,8 (46) */
 
+
 #define N_DHCP_ADDR 4        /* Max # of addresses allowed for
 			        DNS, WINS, etc. */
 
@@ -292,11 +293,30 @@ ifconfig_order(void)
   return IFCONFIG_AFTER_TUN_OPEN;
 #elif defined(WIN32)
   return IFCONFIG_BEFORE_TUN_OPEN;
+#elif defined(TARGET_ANDROID)
+  return IFCONFIG_BEFORE_TUN_OPEN;
 #else
   return IFCONFIG_DEFAULT;
 #endif
 }
 
+#define ROUTE_BEFORE_TUN 0
+#define ROUTE_AFTER_TUN 1
+#define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN
+
+static inline int
+route_order(void)
+{
+#if defined(TARGET_ANDROID)
+    return ROUTE_BEFORE_TUN;
+#else
+    return ROUTE_ORDER_DEFAULT;
+#endif
+}
+
+
+
+
 #ifdef WIN32
 
 #define TUN_PASS_BUFFER
-- 
1.7.8.3

From 5a1b05c9410cbbabcee271201d781f425cfd77e5 Mon Sep 17 00:00:00 2001
From: Arne Schwabe <arne@...1227...>
Date: Sat, 5 May 2012 12:40:55 +0200
Subject: [PATCH] tmp-dir for all revert debug output

---
 src/openvpn/manage.c  |   11 ++++-------
 src/openvpn/options.c |   11 +++++------
 src/openvpn/tun.c     |    5 ++++-
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 1a6c086..1dddd41 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1479,14 +1479,13 @@ man_new_connection_post (struct management *man, const char *description)
 #if UNIX_SOCK_SUPPORT
   if (man->settings.flags & MF_UNIX_SOCK)
     {
-        msg (D_MANAGEMENT, "MANAGEMENT(unix): %s %s",
-             description,
-             sockaddr_unix_name (&man->settings.local_unix, "NULL"));
- 
+      msg (D_MANAGEMENT, "MANAGEMENT: %s %s",
+	   description,
+	   sockaddr_unix_name (&man->settings.local_unix, "NULL"));
     }
   else
 #endif
-    msg (D_MANAGEMENT, "MANAGEMENT(tcp): %s %s",
+    msg (D_MANAGEMENT, "MANAGEMENT: %s %s",
 	 description,
 	 print_sockaddr (&man->settings.local, &gc));
 
@@ -2691,7 +2690,6 @@ management_socket_set (struct management *man,
 void
 management_io (struct management *man)
 {
-    msg(D_MANAGEMENT,"M I/O State %d in",man->connection.state);
   switch (man->connection.state)
     {
     case MS_LISTEN:
@@ -2708,7 +2706,6 @@ management_io (struct management *man)
     default:
       ASSERT (0);
     }
-    msg(D_MANAGEMENT,"M I/O State %d out",man->connection.state);
 }
 
 #endif
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bd6382f..a2d0f6e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -564,7 +564,6 @@ static const char usage_message[] =
 #if OPENSSL_VERSION_NUMBER >= 0x00907000L
   " and CRLs).\n"
 #else /* OPENSSL_VERSION_NUMBER >= 0x00907000L */
-#error WTF!
   ").\n"
   "                  WARNING: no support of CRL available with this version.\n"
 #endif /* OPENSSL_VERSION_NUMBER >= 0x00907000L */
@@ -5472,6 +5471,11 @@ add_option (struct options *options,
       options->occ = false;
     }
 #endif
+  else if (streq (p[0], "tmp-dir") && p[1])
+  {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->tmp_dir = p[1];
+  }
 #if P2MP
 #if P2MP_SERVER
   else if (streq (p[0], "server") && p[1] && p[2])
@@ -5753,11 +5757,6 @@ add_option (struct options *options,
       warn_multiple_script (options->learn_address_script, "learn-address");
       options->learn_address_script = p[1];
     }
-  else if (streq (p[0], "tmp-dir") && p[1])
-    {
-      VERIFY_PERMISSION (OPT_P_GENERAL);
-      options->tmp_dir = p[1];
-    }
   else if (streq (p[0], "client-config-dir") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 7aa8627..238d9fb 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1386,7 +1386,10 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 
     if(tt->options.domain)
         android_set_domain(tt->options.domain);
-    tt->fd = android_open_tun();
+
+    if((tt->fd = android_open_tun())< 0){
+        msg (M_ERR, "ERROR: Cannot open TUN");
+    }
 }
 
 #else
-- 
1.7.8.3

From 82ef19f76f827026033aefea295e64015ae7c36d Mon Sep 17 00:00:00 2001
From: Arne Schwabe <arne@...1227...>
Date: Wed, 9 May 2012 19:27:32 +0200
Subject: [PATCH] working openvpn

---
 src/openvpn/error.c  |    5 +--
 src/openvpn/manage.c |  103 ++++++++++++++++++++++++++++++++++++++++++++++++-
 src/openvpn/manage.h |    7 +++-
 src/openvpn/misc.c   |    2 +-
 src/openvpn/route.c  |   13 +++++-
 src/openvpn/socket.c |   40 +++++++-------------
 src/openvpn/tun.c    |   39 +++++++++++++-----
 7 files changed, 160 insertions(+), 49 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 6849794..83a9eb4 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -714,10 +714,7 @@ openvpn_exit (const int status)
       if (status == OPENVPN_EXIT_STATUS_GOOD)
 	perf_output_results ();
     }
-#ifdef TARGET_ANDROID
-    android_openvpn_exit(status);
-#endif
-    
+
   exit (status);
 }
 
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 1dddd41..f7ca8e1 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -58,6 +58,9 @@
 #define MANAGEMENT_ECHO_FLAGS 0
 #endif
 
+#include <android/log.h>
+
+
 /* tag for blank username/password */
 static const char blank_up[] = "[[BLANK]]";
 
@@ -66,6 +69,9 @@ struct management *management; /* GLOBAL */
 /* static forward declarations */
 static void man_output_standalone (struct management *man, volatile int *signal_received);
 static void man_reset_client_socket (struct management *man, const bool exiting);
+static ssize_t write_fd (int fd, void *ptr, size_t nbytes, int flags, int sendfd);
+static ssize_t read_fd(int fd, void *ptr, size_t nbytes, int flags, int *recvfd);
+
 
 static void
 man_help ()
@@ -1805,6 +1811,7 @@ man_io_error (struct management *man, const char *prefix)
     return false;
 }
 
+
 static int
 man_read (struct management *man)
 {
@@ -1813,8 +1820,19 @@ man_read (struct management *man)
    */
   unsigned char buf[256];
   int len = 0;
+  int fd = -1;
 
-  len = recv (man->connection.sd_cli, buf, sizeof (buf), MSG_NOSIGNAL);
+#ifdef TARGET_ANDROID
+    len = read_fd (man->connection.sd_cli, buf, sizeof (buf), MSG_NOSIGNAL, &fd);
+    __android_log_print(ANDROID_LOG_DEBUG,"openvpn-dbg","read_fd %d %d", len, fd);
+    if(fd >= 0) {
+        man->connection.lastfdreceived = fd;
+        if(len == 0) // No data message but a fd, return without resetting socket...
+            return 0;
+    }
+#else
+    len = recv (man->connection.sd_cli, buf, sizeof (buf), MSG_NOSIGNAL);
+#endif
   if (len == 0)
     {
       man_reset_client_socket (man, false);
@@ -1891,7 +1909,13 @@ man_write (struct management *man)
   if (buf && BLEN (buf))
     {
       const int len = min_int (size_hint, BLEN (buf));
-      sent = send (man->connection.sd_cli, BPTR (buf), len, MSG_NOSIGNAL);
+#ifdef TARGET_ANDROID
+        if (man->connection.fdtosend > 0) {
+            sent = write_fd (man->connection.sd_cli, BPTR (buf), len, MSG_NOSIGNAL,man->connection.fdtosend);
+            man->connection.fdtosend = -1;
+        } else
+#endif
+        sent = send (man->connection.sd_cli, BPTR (buf), len, MSG_NOSIGNAL);
       if (sent >= 0)
 	{
 	  buffer_list_advance (man->connection.out, sent);
@@ -2886,7 +2910,7 @@ management_event_loop_n_seconds (struct management *man, int sec)
  * Get a username/password from management channel in standalone mode.
  */
 bool
-management_query_user_pass (struct management *man,
+    management_query_user_pass (struct management *man,
 			    struct user_pass *up,
 			    const char *type,
 			    const unsigned int flags,
@@ -3084,6 +3108,79 @@ management_query_rsa_sig (struct management *man,
 
 #endif
 
+#ifdef TARGET_ANDROID
+static ssize_t write_fd (int fd, void *ptr, size_t nbytes, int flags, int sendfd)
+{
+    struct msghdr msg;
+    struct iovec iov[1];
+    
+    union {
+        struct cmsghdr cm;
+        char    control[CMSG_SPACE(sizeof(int))];
+    } control_un;
+    struct cmsghdr *cmptr;
+    
+    msg.msg_control = control_un.control;
+    msg.msg_controllen = sizeof(control_un.control);
+    
+    cmptr = CMSG_FIRSTHDR(&msg);
+    cmptr->cmsg_len = CMSG_LEN(sizeof(int));
+    cmptr->cmsg_level = SOL_SOCKET;
+    cmptr->cmsg_type = SCM_RIGHTS;
+    *((int *) CMSG_DATA(cmptr)) = sendfd;
+    
+    msg.msg_name = NULL;
+    msg.msg_namelen = 0;
+    
+    iov[0].iov_base = ptr;
+    iov[0].iov_len = nbytes;
+    msg.msg_iov = iov;
+    msg.msg_iovlen = 1;
+    
+    return (sendmsg(fd, &msg, flags));
+}
+
+static ssize_t read_fd(int fd, void *ptr, size_t nbytes, int flags, int *recvfd)
+{
+    struct msghdr msghdr;
+    struct iovec iov[1];
+    ssize_t n;
+    
+    union {
+        struct cmsghdr cm;
+        char     control[CMSG_SPACE(sizeof (int))];
+    } control_un;
+    struct cmsghdr  *cmptr;
+    
+    msghdr.msg_control  = control_un.control;
+    msghdr.msg_controllen = sizeof(control_un.control);
+    
+    msghdr.msg_name = NULL;
+    msghdr.msg_namelen = 0;
+    
+    iov[0].iov_base = ptr;
+    iov[0].iov_len = nbytes;
+    msghdr.msg_iov = iov;
+    msghdr.msg_iovlen = 1;
+    
+    if ( (n = recvmsg(fd, &msghdr, flags)) <= 0)
+        return (n);
+    
+    if ( (cmptr = CMSG_FIRSTHDR(&msghdr)) != NULL &&
+        cmptr->cmsg_len == CMSG_LEN(sizeof(int))) {
+        if (cmptr->cmsg_level != SOL_SOCKET)
+            msg (M_ERR, "control level != SOL_SOCKET");
+        if (cmptr->cmsg_type != SCM_RIGHTS)
+            msg (M_ERR, "control type != SCM_RIGHTS");
+        *recvfd = *((int *) CMSG_DATA(cmptr));
+    } else
+        *recvfd = -1;           /* descriptor was not passed */
+    
+    return (n);
+}
+#endif
+
+
 /*
  * Return true if management_hold() would block
  */
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index f681f8d..c7ffb42 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -208,7 +208,7 @@ struct man_persist {
   bool hold_release;
 
   const char *special_state_msg;
-
+    
   counter_type bytes_in;
   counter_type bytes_out;
 };
@@ -303,6 +303,11 @@ struct man_connection {
 #ifdef MANAGMENT_EXTERNAL_KEY
   struct buffer_list *rsa_sig;
 #endif
+#ifdef TARGET_ANDROID
+    int fdtosend;
+    int lastfdreceived;
+#endif
+    
 };
 
 struct management
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 2ded9bf..3658c34 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1176,7 +1176,7 @@ get_user_pass_cr (struct user_pass *up,
 	      if (ac)
 		{
 		  char *response = (char *) gc_malloc (USER_PASS_LEN, false, &gc);
-		  struct buffer packed_resp;
+		  struct buffer packed_resp; 
 
 		  buf_set_write (&packed_resp, (uint8_t*)up->password, USER_PASS_LEN);
 		  msg (M_INFO|M_NOPREFIX, "CHALLENGE: %s", ac->challenge_text);
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 6c3ad90..99674e2 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1345,9 +1345,15 @@ add_route (struct route *r,
   status = openvpn_execve_check (&argv, es, 0, "ERROR: Linux route add command failed");
 
 #elif defined (TARGET_ANDROID)
-#include "jniglue.h"
 
-    addRouteInformation(network, netmask, gateway);
+    struct user_pass up;    
+    struct buffer out = alloc_buf_gc (64, &gc);
+
+    buf_printf (&out, "%s %s", network, netmask);
+
+    strcpy(up.username, buf_bptr(&out));
+    management_query_user_pass(management, &up , "ROUTE", GET_USER_PASS_NEED_OK,(void*) 0);
+
 
 #elif defined (WIN32)
   {
@@ -1852,7 +1858,8 @@ delete_route (struct route *r,
 
   argv_msg (D_ROUTE, &argv);
   openvpn_execve_check (&argv, es, 0, "ERROR: OpenBSD/NetBSD route delete command failed");
-
+#elif defined(TARGET_ANDROID)
+  msg (M_NONFATAL, "Sorry, deleting routes on Android is not possible. The VpnService API allows routes to be set on connect only.");
 #else
   msg (M_FATAL, "Sorry, but I don't know how to do 'route' commands on this operating system.  Try putting your routes in a --route-up script");
 #endif
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 364b97e..7101097 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -38,13 +38,10 @@
 #include "ps.h"
 #include "manage.h"
 #include "misc.h"
+#include "manage.h"
 
-#include "memdbg.h"
-
-#ifdef TARGET_ANDROID
-#include "jniglue.h"
-#endif 
 
+#include "memdbg.h"
 
 const int proto_overhead[] = { /* indexed by PROTO_x */
   0,
@@ -378,7 +375,7 @@ getaddr6 (unsigned int flags,
 
       /*
        * Resolve hostname
-       */
+       */ 
       while (true)
 	{
 	  /* try hostname lookup */
@@ -863,12 +860,7 @@ create_socket_tcp (void)
   }
 #endif
 
-#ifdef TARGET_ANDROID
-    /* Protects the socket from being routed via VPN */
-    android_protect_socket(sd);
-#endif
-
-  return sd;
+    return sd;
 }
 
 static socket_descriptor_t
@@ -896,11 +888,6 @@ create_socket_udp (const unsigned int flags)
     }
 #endif
 
-#ifdef TARGET_ANDROID
-    /* Protects the socket from being routed via VPN */
-    android_protect_socket(sd);
-#endif
-
   return sd;
 }
 
@@ -920,10 +907,6 @@ create_socket_udp6 (const unsigned int flags)
 	msg(M_SOCKERR, "UDP: failed setsockopt for IPV6_RECVPKTINFO");
     }
 #endif
-#ifdef TARGET_ANDROID
-    /* Protects the socket from being routed via VPN */
-    android_protect_socket(sd);
-#endif
 
   return sd;
 }
@@ -943,10 +926,6 @@ create_socket_tcp6 (void)
 		    (void *) &on, sizeof (on)) < 0)
       msg (M_SOCKERR, "TCP: Cannot setsockopt SO_REUSEADDR on TCP6 socket");
   }
-#ifdef TARGET_ANDROID
-    /* Protects the socket from being routed via VPN */
-    android_protect_socket(sd);
-#endif
 
   return sd;
 }
@@ -984,6 +963,15 @@ create_socket (struct link_socket *sock)
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
@@ -1341,7 +1329,7 @@ socket_connect (socket_descriptor_t *sd,
 }
 
 /* For stream protocols, allocate a buffer to build up packet.
-   Called after frame has been finalized. */
+    Called after frame has been finalized. */
 
 static void
 socket_frame_init (const struct frame *frame, struct link_socket *sock)
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 238d9fb..158cd61 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -46,12 +46,8 @@
 #include "manage.h"
 #include "route.h"
 #include "win32.h"
-
 #include "memdbg.h"
-
-#ifdef TARGET_ANDROID
-#include "jniglue.h"
-#endif
+#include <string.h>
 
 
 #ifdef WIN32
@@ -774,7 +770,16 @@ do_ifconfig (struct tuntap *tt,
 
 #endif /*ENABLE_IPROUTE*/
 #elif defined(TARGET_ANDROID)
-       addInterfaceInformation(tun_mtu,ifconfig_local, ifconfig_remote_netmask);
+        
+        struct user_pass up;    
+        struct buffer out = alloc_buf_gc (64, &gc);
+        
+        buf_printf (&out, "%s %s %d", ifconfig_local, ifconfig_remote_netmask, tun_mtu);
+        
+        strcpy(up.username, buf_bptr(&out));
+        management_query_user_pass(management, &up , "IFCONFIG", GET_USER_PASS_NEED_OK,(void*) 0);
+        
+        
 #elif defined(TARGET_SOLARIS)
 
       /* Solaris 2.6 (and 7?) cannot set all parameters in one go...
@@ -1378,18 +1383,30 @@ close_tun_generic (struct tuntap *tt)
 void
 open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
 {
-    struct gc_arena gc = gc_new ();
     int i;
+    struct user_pass up;
+    struct gc_arena gc = gc_new ();
+    
     for (i = 0; i < tt->options.dns_len; ++i) {
-        android_set_dns(print_in_addr_t(tt->options.dns[i], 0, &gc));
+        strcpy(up.username, print_in_addr_t(tt->options.dns[i], 0, &gc));
+        management_query_user_pass(management, &up , "DNSSERVER", GET_USER_PASS_NEED_OK,(void*) 0);
     }
 
-    if(tt->options.domain)
-        android_set_domain(tt->options.domain);
+    if(tt->options.domain) {
+        strcpy(up.username , tt->options.domain);
+        management_query_user_pass(management, &up , "DNSDOMAIN", GET_USER_PASS_NEED_OK,(void*) 0);
+    }
+    
+    strcpy(up.username , dev);
+    management_query_user_pass(management, &up , "OPENTUN", GET_USER_PASS_NEED_OK,(void*) 0);
 
-    if((tt->fd = android_open_tun())< 0){
+    tt->fd = management->connection.lastfdreceived;
+    management->connection.lastfdreceived=-1;
+    
+    if( (tt->fd < 0) || ! (strcmp("ok",up.password)==0)) {
         msg (M_ERR, "ERROR: Cannot open TUN");
     }
+    gc_free (&gc);
 }
 
 #else
-- 
1.7.8.3

From 870b93ef683f68f85e4aad63f3e9ca9325f4bf8f Mon Sep 17 00:00:00 2001
From: Arne Schwabe <arne@...1227...>
Date: Wed, 9 May 2012 23:09:43 +0200
Subject: [PATCH] openvpn android working api through unix socket

---
 src/openvpn/error.c  |   15 +--------------
 src/openvpn/init.c   |    2 +-
 src/openvpn/socket.c |    1 -
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 83a9eb4..e2e24b1 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -199,11 +199,6 @@ msg_fp(const unsigned int flags)
 
 int x_msg_line_num; /* GLOBAL */
 
-#include "android/log.h"
- 
-
-
-
 void x_msg (const unsigned int flags, const char *format, ...)
 {
   struct gc_arena gc;
@@ -219,7 +214,6 @@ void x_msg (const unsigned int flags, const char *format, ...)
   const char *prefix_sep;
 
   void usage_small (void);
-    
 
 #ifndef HAVE_VARARG_MACROS
   /* the macro has checked this otherwise */
@@ -304,12 +298,10 @@ void x_msg (const unsigned int flags, const char *format, ...)
   if (!prefix)
     prefix_sep = prefix = "";
 
-
   /* virtual output capability used to copy output to management subsystem */
   if (!forked)
     {
       const struct virtual_output *vo = msg_get_virtual_output ();
-        
       if (vo)
 	{
 	  openvpn_snprintf (m2, ERR_BUF_SIZE, "%s%s%s",
@@ -331,7 +323,7 @@ void x_msg (const unsigned int flags, const char *format, ...)
                     m1); 
 #endif
         }
-        else // No Syslog
+      else
         {
             FILE *fp = msg_fp(flags);
             const bool show_usec = check_debug_level (DEBUG_LEVEL_USEC_TIME);
@@ -356,13 +348,8 @@ void x_msg (const unsigned int flags, const char *format, ...)
             fflush(fp);
             ++x_msg_line_num;
         }
-#ifdef TARGET_ANDROID
-        android_openvpn_log(prefix,prefix_sep,m1);;
-#endif
     }
 
-
-    
   if (flags & M_FATAL)
     msg (M_INFO, "Exiting due to fatal error");
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index cc94b81..17e4f4a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2475,7 +2475,7 @@ do_option_warnings (struct context *c)
 {
   const struct options *o = &c->options;
 
-#if 1 /* JYFIXME -- port warning */
+#if 0 /* JYFIXME -- port warning */
   if (!o->ce.port_option_used && (o->ce.local_port == OPENVPN_PORT && o->ce.remote_port == OPENVPN_PORT))
     msg (M_WARN, "IMPORTANT: OpenVPN's default port number is now %d, based on an official port number assignment by IANA.  OpenVPN 2.0-beta16 and earlier used 5000 as the default port.",
 	 OPENVPN_PORT);
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 7101097..b92c282 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -859,7 +859,6 @@ create_socket_tcp (void)
       msg (M_SOCKERR, "TCP: Cannot setsockopt SO_LINGER on TCP socket");
   }
 #endif
-
     return sd;
 }
 
-- 
1.7.8.3


--------------040807070708080603080405--

