From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 25 Nov 2015 13:57:00 +0100
Message-Id: <1448456220-2042-1-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1448383034-20174-1-git-send-email-heiko.hund@...1489...>
References: <1448383034-20174-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCHv3] extend management interface command
	"state"
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

Currently the state command shows only the tun/tap IPv4 address. The
IPv4 address of the remote peer is also displayed. In case you connect
via IPv6 it just shows the first 4 bytes of the address in IPv4 notation.

This patch extends the state command, so it handles IPv6 addresses.
In addition it also displays the local address and the both port numbers
of the connection, e.g.

1447250958,CONNECTED,SUCCESS,10.0.0.2,fd00::1,1193,fd00::2,6492,fdff::1002

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 doc/management-notes.txt |   17 ++++++++++----
 src/openvpn/forward.c    |    6 +++--
 src/openvpn/init.c       |   55 +++++++++++++++++++++++++++++++++-------------
 src/openvpn/manage.c     |   27 ++++++++++++++++++-----
 src/openvpn/manage.h     |   10 ++++++---
 src/openvpn/route.c      |    6 +++--
 src/openvpn/sig.c        |    6 +++--
 src/openvpn/socket.c     |   23 +++++++++++++------
 src/openvpn/socket.h     |    1 +
 src/openvpn/ssl.c        |   12 ++++++----
 src/openvpn/tun.c        |    6 +++--
 11 files changed, 122 insertions(+), 47 deletions(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 0265d55..f68f3db 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -366,14 +366,23 @@ Command examples:
                   same time enable real-time state notification
 		  of future state transitions.
 
-The output format consists of 4 comma-separated parameters: 
+The output format consists of up to 9 comma-separated parameters:
   (a) the integer unix date/time,
   (b) the state name,
   (c) optional descriptive string (used mostly on RECONNECTING
       and EXITING to show the reason for the disconnect),
-  (d) optional TUN/TAP local IP address (shown for ASSIGN_IP
-      and CONNECTED), and
-  (e) optional address of remote server (OpenVPN 2.1 or higher).
+  (d) optional TUN/TAP local IPv4 address
+  (e) optional address of remote server,
+  (f) optional port of remote server,
+  (g) optional local address,
+  (h) optional local port, and
+  (i) optional TUN/TAP local IPv6 address.
+
+Fields (e)-(h) are shown for CONNECTED state,
+(d) and (i) are shown for ASSIGN_IP and CONNECTED states.
+
+(e) is available starting from OpenVPN 2.1
+(f)-(i) are available starting from OpenVPN 2.4
 
 Real-time state notifications will have a ">STATE:" prefix
 prepended to them.
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index cef063d..36a99e6 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -208,8 +208,10 @@ check_connection_established_dowork (struct context *c)
 		  management_set_state (management,
 					OPENVPN_STATE_GET_CONFIG,
 					NULL,
-					0,
-					0);
+                                        NULL,
+                                        NULL,
+                                        NULL,
+                                        NULL);
 		}
 #endif
 	      /* fire up push request right away (already 1s delayed) */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c5c0ab6..5c17087 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -44,6 +44,7 @@
 #include "ping.h"
 #include "mstats.h"
 #include "ssl_verify.h"
+#include "forward-inline.h"
 
 #include "memdbg.h"
 
@@ -1273,26 +1274,48 @@ initialization_sequence_completed (struct context *c, const unsigned int flags)
   /* Tell management interface that we initialized */
   if (management)
     {
-      in_addr_t tun_local = 0;
-      in_addr_t tun_remote = 0; /* FKS */
+      in_addr_t *tun_local = NULL;
+      struct in6_addr *tun_local6 = NULL;
+      struct openvpn_sockaddr local, remote;
+      struct link_socket_actual *actual;
+      socklen_t sa_len = sizeof(local);
       const char *detail = "SUCCESS";
-      if (c->c1.tuntap)
-	tun_local = c->c1.tuntap->local;
-      /* TODO(jjo): for ipv6 this will convert some 32bits in the ipv6 addr
-       *            to a meaningless ipv4 address.
-       *            In any case, is somewhat inconsistent to send local tunnel
-       *            addr with remote _endpoint_ addr (?)
-       */
-      tun_remote = htonl (c->c1.link_socket_addr.actual.dest.addr.in4.sin_addr.s_addr);
       if (flags & ISC_ERRORS)
-	detail = "ERROR";
+        detail = "ERROR";
+
+      CLEAR (local);
+      actual = &get_link_socket_info(c)->lsa->actual;
+      remote = actual->dest;
+      getsockname(c->c2.link_socket->sd, &local.addr.sa, &sa_len);
+#if ENABLE_IP_PKTINFO
+      if (!addr_defined(&local))
+        {
+          switch (local.addr.sa.sa_family)
+            {
+            case AF_INET:
+              local.addr.in4.sin_addr = actual->pi.in4.ipi_spec_dst;
+              break;
+            case AF_INET6:
+              local.addr.in6.sin6_addr = actual->pi.in6.ipi6_addr;
+              break;
+            }
+        }
+#endif
+
+      if (c->c1.tuntap)
+        {
+          tun_local = &c->c1.tuntap->local;
+          tun_local6 = &c->c1.tuntap->local_ipv6;
+        }
       management_set_state (management,
 			    OPENVPN_STATE_CONNECTED,
 			    detail,
 			    tun_local,
-			    tun_remote);
+                            tun_local6,
+                            &local,
+                            &remote);
       if (tun_local)
-	management_post_tunnel_open (management, tun_local);
+	management_post_tunnel_open (management, *tun_local);
     }
 #endif
 }
@@ -3288,8 +3311,10 @@ open_management (struct context *c)
 	      management_set_state (management,
 				    OPENVPN_STATE_CONNECTING,
 				    NULL,
-				    (in_addr_t)0,
-				    (in_addr_t)0);
+                                    NULL,
+                                    NULL,
+                                    NULL,
+                                    NULL);
 	    }
 
 	  /* initial management hold, called early, before first context initialization */
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 97d6f0f..dcb1bc1 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2422,8 +2422,10 @@ void
 management_set_state (struct management *man,
 		      const int state,
 		      const char *detail,
-		      const in_addr_t tun_local_ip,
-		      const in_addr_t tun_remote_ip)
+                      const in_addr_t *tun_local_ip,
+                      const struct in6_addr *tun_local_ip6,
+                      const struct openvpn_sockaddr *local,
+                      const struct openvpn_sockaddr *remote)
 {
   if (man->persist.state && (!(man->settings.flags & MF_SERVER) || state < OPENVPN_STATE_CLIENT_BASE))
     {
@@ -2436,9 +2438,15 @@ management_set_state (struct management *man,
       e.timestamp = now;
       e.u.state = state;
       e.string = detail;
-      e.local_ip = tun_local_ip;
-      e.remote_ip = tun_remote_ip;
-      
+      if (tun_local_ip)
+        e.local_ip = *tun_local_ip;
+      if (tun_local_ip6)
+        e.local_ip6 = *tun_local_ip6;
+      if (local)
+        e.local_sock = *local;
+      if (remote)
+        e.remote_sock = *remote;
+
       log_history_add (man->persist.state, &e);
 
       if (man->connection.state_realtime)
@@ -3460,7 +3468,14 @@ log_entry_print (const struct log_entry *e, unsigned int flags, struct gc_arena
   if (flags & LOG_PRINT_LOCAL_IP)
     buf_printf (&out, ",%s", print_in_addr_t (e->local_ip, IA_EMPTY_IF_UNDEF, gc));
   if (flags & LOG_PRINT_REMOTE_IP)
-    buf_printf (&out, ",%s", print_in_addr_t (e->remote_ip, IA_EMPTY_IF_UNDEF, gc));
+    {
+      buf_printf (&out, ",%s", (!addr_defined (&e->remote_sock) ? "," :
+        print_sockaddr_ex (&e->remote_sock.addr.sa, ",", PS_DONT_SHOW_FAMILY|PS_SHOW_PORT, gc)));
+      buf_printf (&out, ",%s", (!addr_defined (&e->local_sock) ? "," :
+        print_sockaddr_ex (&e->local_sock.addr.sa, ",", PS_DONT_SHOW_FAMILY|PS_SHOW_PORT, gc)));
+    }
+  if (flags & LOG_PRINT_LOCAL_IP && !IN6_IS_ADDR_UNSPECIFIED(&e->local_ip6))
+    buf_printf (&out, ",%s", print_in6_addr (e->local_ip6, IA_EMPTY_IF_UNDEF, gc));
   if (flags & LOG_ECHO_TO_LOG)
     msg (D_MANAGEMENT, "MANAGEMENT: %s", BSTR (&out));
   if (flags & LOG_PRINT_CRLF)
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index a97e8a2..988600f 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -88,7 +88,9 @@ struct log_entry
   time_t timestamp;
   const char *string;
   in_addr_t local_ip;
-  in_addr_t remote_ip;
+  struct in6_addr local_ip6;
+  struct openvpn_sockaddr local_sock;
+  struct openvpn_sockaddr remote_sock;
   union log_entry_union u;
 };
 
@@ -496,8 +498,10 @@ management_enable_def_auth (const struct management *man)
 void management_set_state (struct management *man,
 			   const int state,
 			   const char *detail,
-			   const in_addr_t tun_local_ip,
-			   const in_addr_t tun_remote_ip);
+                           const in_addr_t *tun_local_ip,
+                           const struct in6_addr *tun_local_ip6,
+                           const struct openvpn_sockaddr *local_addr,
+                           const struct openvpn_sockaddr *remote_addr);
 
 /*
  * The management object keeps track of OpenVPN --echo
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d060187..4a60345 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1093,8 +1093,10 @@ add_routes (struct route_list *rl, struct route_ipv6_list *rl6, const struct tun
 	  management_set_state (management,
 				OPENVPN_STATE_ADD_ROUTES,
 				NULL,
-				0,
-				0);
+                                NULL,
+                                NULL,
+                                NULL,
+                                NULL);
 	}
 #endif
 
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index a3d29de..f903fc0 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -189,8 +189,10 @@ signal_restart_status (const struct signal_info *si)
 	management_set_state (management,
 			      state,
 			      si->signal_text ? si->signal_text : signal_name (si->signal_received, true),
-			      (in_addr_t)0,
-			      (in_addr_t)0);
+                              NULL,
+                              NULL,
+                              NULL,
+                              NULL);
     }
 #endif
 }
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8e6b4bc..13c05e0 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -363,8 +363,10 @@ openvpn_getaddrinfo (unsigned int flags,
             management_set_state (management,
                                   OPENVPN_STATE_RESOLVE,
                                   NULL,
-                                  (in_addr_t)0,
-                                  (in_addr_t)0);
+                                  NULL,
+                                  NULL,
+                                  NULL,
+                                  NULL);
         }
 #endif
 
@@ -1244,8 +1246,10 @@ socket_connect (socket_descriptor_t* sd,
 	management_set_state (management,
 			      OPENVPN_STATE_TCP_CONNECT,
 			      NULL,
-			      (in_addr_t)0,
-			      (in_addr_t)0);
+                              NULL,
+                              NULL,
+                              NULL,
+                              NULL);
 #endif
 
   /* Set the actual address */
@@ -2371,17 +2375,22 @@ print_sockaddr_ex (const struct sockaddr *sa,
   switch(sa->sa_family)
     {
     case AF_INET:
-      buf_puts (&out, "[AF_INET]");
+      if (!(flags & PS_DONT_SHOW_FAMILY))
+        buf_puts (&out, "[AF_INET]");
       salen = sizeof (struct sockaddr_in);
       addr_is_defined = ((struct sockaddr_in*) sa)->sin_addr.s_addr != 0;
       break;
     case AF_INET6:
-      buf_puts (&out, "[AF_INET6]");
+      if (!(flags & PS_DONT_SHOW_FAMILY))
+        buf_puts (&out, "[AF_INET6]");
       salen = sizeof (struct sockaddr_in6);
       addr_is_defined = !IN6_IS_ADDR_UNSPECIFIED(&((struct sockaddr_in6*) sa)->sin6_addr);
       break;
     case AF_UNSPEC:
-      return "[AF_UNSPEC]";
+      if (!(flags & PS_DONT_SHOW_FAMILY))
+        return "[AF_UNSPEC]";
+      else
+        return "";
     default:
       ASSERT(0);
     }
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 54cdc88..a8e0e81 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -344,6 +344,7 @@ void sd_close (socket_descriptor_t *sd);
 #define PS_SHOW_PORT            (1<<1)
 #define PS_SHOW_PKTINFO         (1<<2)
 #define PS_DONT_SHOW_ADDR       (1<<3)
+#define PS_DONT_SHOW_FAMILY     (1<<4)
 
 const char *print_sockaddr_ex (const struct sockaddr *addr,
 			       const char* separator,
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 86eda77..817bc49 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2307,8 +2307,10 @@ tls_process (struct tls_multi *multi,
 		      management_set_state (management,
 					    OPENVPN_STATE_WAIT,
 					    NULL,
-					    0,
-					    0);
+                                            NULL,
+                                            NULL,
+                                            NULL,
+                                            NULL);
 		    }
 #endif
 		}
@@ -3016,8 +3018,10 @@ tls_pre_decrypt (struct tls_multi *multi,
 		      management_set_state (management,
 					    OPENVPN_STATE_AUTH,
 					    NULL,
-					    0,
-					    0);
+                                            NULL,
+                                            NULL,
+                                            NULL,
+                                            NULL);
 		    }
 #endif
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index c293e1e..014d988 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -711,8 +711,10 @@ do_ifconfig (struct tuntap *tt,
       management_set_state (management,
 			    OPENVPN_STATE_ASSIGN_IP,
 			    NULL,
-			    tt->local,
-			    0);
+                            &tt->local,
+                            &tt->local_ipv6,
+                            NULL,
+                            NULL);
     }
 #endif
 
-- 
1.7.9.5


