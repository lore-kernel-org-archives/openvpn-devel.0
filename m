Message-ID: <43404D99.8080309@...361...>
From: Rolf Fokkens <r.fokkens@...361...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080008070704060807000803"
Subject: [Openvpn-devel] Patch: Admin interface shows server IP when connected
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Oct  2 14:19:06 2005
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080008070704060807000803
Content-Type: multipart/alternative;
 boundary="------------090805090703020006060609"

--------------090805090703020006060609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I created an OpenVPN admin interface, which I want to show the actual 
connected server of a client. The normal "state" command in the admin 
interface does not provide the information. The attached patch adds an 
extra argument to the "state" result which shows the server's IP. Like this:

    [root@...464... ~]# echo state | nc 0.0.0.0 5000
     >INFO:OpenVPN Management Interface Version 1 -- type 'help' for
    more info
    1128286300,CONNECTED,SUCCESS,,145.66.1.1
    END
    [root@...464... ~]#

James Yonan once told me that this actualy changes the admin API, so it 
may break some admin interfaces. For those however who can use it I 
attached the patch.

Rolf

--------------090805090703020006060609
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Hi,<br>
<br>
I created an OpenVPN admin interface, which I want to show the actual
connected server of a client. The normal "state" command in the admin
interface does not provide the information. The attached patch adds an
extra argument to the "state" result which shows the server's IP. Like
this:<br>
<blockquote><tt>[root@...464... ~]# echo state | nc 0.0.0.0 5000</tt><br>
  <tt>&gt;INFO:OpenVPN Management Interface Version 1 -- type 'help'
for more info</tt><br>
  <tt>1128286300,CONNECTED,SUCCESS,,145.66.1.1</tt><br>
  <tt>END</tt><br>
  <tt>[root@...464... ~]#</tt><br>
</blockquote>
James Yonan once told me that this actualy changes the admin API, so it
may break some admin interfaces. For those however who can use it I
attached the patch.<br>
<br>
Rolf<br>
</body>
</html>

--------------090805090703020006060609--

--------------080008070704060807000803
Content-Type: text/x-patch;
 name="openvpn-2.0.1-fks1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-2.0.1-fks1.patch"

diff -ruN openvpn-2.0.1.orig/forward.c openvpn-2.0.1/forward.c
--- openvpn-2.0.1.orig/forward.c	2005-08-04 05:22:16.000000000 +0200
+++ openvpn-2.0.1/forward.c	2005-08-20 00:37:29.000000000 +0200
@@ -194,6 +194,7 @@
 		  management_set_state (management,
 					OPENVPN_STATE_GET_CONFIG,
 					NULL,
+					0,
 					0);
 		}
 #endif
diff -ruN openvpn-2.0.1.orig/init.c openvpn-2.0.1/init.c
--- openvpn-2.0.1.orig/init.c	2005-08-04 20:44:23.000000000 +0200
+++ openvpn-2.0.1/init.c	2005-08-20 00:49:39.000000000 +0200
@@ -594,15 +594,18 @@
   if (management)
     {
       in_addr_t tun_local = 0;
+      in_addr_t tun_remote = 0; /* FKS */
       const char *detail = "SUCCESS";
       if (c->c1.tuntap)
 	tun_local = c->c1.tuntap->local;
+      tun_remote = htonl (c->c1.link_socket_addr.actual.sin_addr.s_addr);
       if (flags & ISC_ERRORS)
 	detail = "ERROR";
       management_set_state (management,
 			    OPENVPN_STATE_CONNECTED,
 			    detail,
-			    tun_local);
+			    tun_local,
+			    tun_remote);
       if (tun_local)
 	management_post_tunnel_open (management, tun_local);
     }
@@ -2190,6 +2193,7 @@
 	      management_set_state (management,
 				    OPENVPN_STATE_CONNECTING,
 				    NULL,
+				    (in_addr_t)0,
 				    (in_addr_t)0);
 	    }
 
diff -ruN openvpn-2.0.1.orig/manage.c openvpn-2.0.1/manage.c
--- openvpn-2.0.1.orig/manage.c	2005-08-04 21:30:42.000000000 +0200
+++ openvpn-2.0.1/manage.c	2005-08-20 00:44:31.000000000 +0200
@@ -440,7 +440,8 @@
 	       "state",
 	       man->persist.state,
 	       &man->connection.state_realtime,
-	       LOG_PRINT_INT_DATE|LOG_PRINT_STATE|LOG_PRINT_LOCAL_IP);
+	       LOG_PRINT_INT_DATE|LOG_PRINT_STATE|
+	       LOG_PRINT_LOCAL_IP|LOG_PRINT_REMOTE_IP);
 }
 
 static void
@@ -1329,7 +1330,8 @@
 management_set_state (struct management *man,
 		      const int state,
 		      const char *detail,
-		      const in_addr_t tun_local_ip)
+		      const in_addr_t tun_local_ip,
+		      const in_addr_t tun_remote_ip)
 {
   if (man->persist.state && (!man->settings.server || state < OPENVPN_STATE_CLIENT_BASE))
     {
@@ -1343,6 +1345,7 @@
       e.u.state = state;
       e.string = detail;
       e.local_ip = tun_local_ip;
+      e.remote_ip = tun_remote_ip;
       
       log_history_add (man->persist.state, &e);
 
@@ -1351,6 +1354,7 @@
 			       |   LOG_PRINT_INT_DATE
                                |   LOG_PRINT_STATE
 			       |   LOG_PRINT_LOCAL_IP
+			       |   LOG_PRINT_REMOTE_IP
                                |   LOG_PRINT_CRLF, &gc);
 
       if (out)
@@ -2032,6 +2036,8 @@
     buf_printf (&out, "%s", e->string);
   if (flags & LOG_PRINT_LOCAL_IP)
     buf_printf (&out, ",%s", print_in_addr_t (e->local_ip, IA_EMPTY_IF_UNDEF, gc));
+  if (flags & LOG_PRINT_REMOTE_IP)
+    buf_printf (&out, ",%s", print_in_addr_t (e->remote_ip, IA_EMPTY_IF_UNDEF, gc));
   if (flags & LOG_PRINT_CRLF)
     buf_printf (&out, "\r\n");
   return BSTR (&out);
diff -ruN openvpn-2.0.1.orig/manage.h openvpn-2.0.1/manage.h
--- openvpn-2.0.1.orig/manage.h	2005-06-12 08:33:20.000000000 +0200
+++ openvpn-2.0.1/manage.h	2005-08-20 00:37:29.000000000 +0200
@@ -96,6 +96,7 @@
   time_t timestamp;
   const char *string;
   in_addr_t local_ip;
+  in_addr_t remote_ip;
   union log_entry_union u;
 };
 
@@ -111,6 +112,8 @@
 #define LOG_PRINT_CRLF         (1<<7)
 #define LOG_FATAL_NOTIFY       (1<<8)
 
+#define LOG_PRINT_REMOTE_IP    (1<<9)
+
 const char *log_entry_print (const struct log_entry *e, unsigned int flags, struct gc_arena *gc);
 
 struct log_history
@@ -321,7 +324,8 @@
 void management_set_state (struct management *man,
 			   const int state,
 			   const char *detail,
-			   const in_addr_t tun_local_ip);
+			   const in_addr_t tun_local_ip,
+			   const in_addr_t tun_remote_ip);
 
 /*
  * The management object keeps track of OpenVPN --echo
Binary files openvpn-2.0.1.orig/openvpn and openvpn-2.0.1/openvpn differ
diff -ruN openvpn-2.0.1.orig/route.c openvpn-2.0.1/route.c
--- openvpn-2.0.1.orig/route.c	2005-04-11 05:43:56.000000000 +0200
+++ openvpn-2.0.1/route.c	2005-08-20 00:37:29.000000000 +0200
@@ -527,6 +527,7 @@
 	  management_set_state (management,
 				OPENVPN_STATE_ADD_ROUTES,
 				NULL,
+				0,
 				0);
 	}
 #endif
diff -ruN openvpn-2.0.1.orig/sig.c openvpn-2.0.1/sig.c
--- openvpn-2.0.1.orig/sig.c	2005-04-11 05:43:55.000000000 +0200
+++ openvpn-2.0.1/sig.c	2005-08-20 00:37:29.000000000 +0200
@@ -167,6 +167,7 @@
 	management_set_state (management,
 			      state,
 			      si->signal_text ? si->signal_text : signal_name (si->signal_received, true),
+			      (in_addr_t)0,
 			      (in_addr_t)0);
     }
 #endif
diff -ruN openvpn-2.0.1.orig/ssl.c openvpn-2.0.1/ssl.c
--- openvpn-2.0.1.orig/ssl.c	2005-08-04 20:50:08.000000000 +0200
+++ openvpn-2.0.1/ssl.c	2005-08-20 00:37:29.000000000 +0200
@@ -2841,6 +2841,7 @@
 		      management_set_state (management,
 					    OPENVPN_STATE_WAIT,
 					    NULL,
+					    0,
 					    0);
 		    }
 #endif
@@ -3512,6 +3513,7 @@
 		      management_set_state (management,
 					    OPENVPN_STATE_AUTH,
 					    NULL,
+					    0,
 					    0);
 		    }
 #endif
diff -ruN openvpn-2.0.1.orig/stamp-h1 openvpn-2.0.1/stamp-h1
--- openvpn-2.0.1.orig/stamp-h1	1970-01-01 01:00:00.000000000 +0100
+++ openvpn-2.0.1/stamp-h1	2005-08-17 21:39:46.000000000 +0200
@@ -0,0 +1 @@
+timestamp for config.h
diff -ruN openvpn-2.0.1.orig/tun.c openvpn-2.0.1/tun.c
--- openvpn-2.0.1.orig/tun.c	2005-08-04 06:46:17.000000000 +0200
+++ openvpn-2.0.1/tun.c	2005-08-20 00:37:29.000000000 +0200
@@ -536,7 +536,8 @@
       management_set_state (management,
 			    OPENVPN_STATE_ASSIGN_IP,
 			    NULL,
-			    tt->local);
+			    tt->local,
+			    0);
     }
 #endif
 

--------------080008070704060807000803--

