From: Charles Duffy <cduffy@...294...>
In-Reply-To: <Pine.LNX.4.58.0504061504500.19198@...41...>
References: <pan.2005.04.06.20.59.05.1038@...294...>
	 <Pine.LNX.4.58.0504061504500.19198@...41...>
Message-Id: <1112834211.15356.17.camel@...370...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_smtp.isgenesis.com-3997-1112835056-0001-2"
Subject: [Openvpn-devel] Re: resolv-retry w/ multiple remote arguments
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
Date: Wed Apr  6 17:52:44 2005
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_smtp.isgenesis.com-3997-1112835056-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

I'm trying to put together a patch to implement my desired behaviour wrt
resolv-retry and multiple remote hosts.

So far, I've made the following changes:

Setting the default resolv-retry count:
      * Create a new constant, RESOLV_RETRY_UNSET
      * Initialize resolve_retry_seconds to RESOLV_RETRY_UNSET rather
        than RESOLV_RETRY_INFINITE
      * In options_postprocess(), set resolve_retry_seconds
        appropriately based on the number of remote hosts provided

Retrying on DNS failures with resolv-retry 0 and multiple hosts:
      * Modify resolve_remote() to accept a boolean argument
        multiple_remotes
      * In the phase-specific handlers within that same function, treat
        multiple_remotes as an alternative to resolve_retry_seconds when
        determining whether GETADDR_FATAL and
        GETADDR_MENTION_RESOLVE_RETRY should be set (in phase 1) and
        whether to fail out with an assertion error (in phase 2).

Thing is, this doesn't actually work: When I run it in a test case in
with the first remote specified by DNS and the second host specified by
IP, it tries to resolve the first host in phase 1; fails; tries again in
phase 2; and fails again (fatally, there, because GETADDR_FATAL is set).

I presume that it's supposed to loop around to trying phase1 with the
next host if getaddr fails (on account of using all the available
retries on the current host) rather than proceeding to phase 2 -- but
what's the mechanism?


My work-in-progress, known-broken patch is attached, just for reference.

--=_smtp.isgenesis.com-3997-1112835056-0001-2
Content-Type: text/x-patch; name="openvpn-2.0_rc19.resolve-retry-patch"; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=openvpn-2.0_rc19.resolve-retry-patch

diff -ru openvpn-2.0_rc19/init.c openvpn-2.0_rc19.patched/init.c
--- openvpn-2.0_rc19/init.c	2005-02-17 14:36:08.000000000 -0600
+++ openvpn-2.0_rc19.patched/init.c	2005-04-06 18:38:57.360000000 -0500
@@ -1687,7 +1687,8 @@
 do_init_socket_2 (struct context *c)
 {
   link_socket_init_phase2 (c->c2.link_socket, &c->c2.frame,
-			   &c->sig->signal_received);
+			   &c->sig->signal_received,
+			   remote_list_len(c->c1.remote_list) > 1);
 }
 
 /*
diff -ru openvpn-2.0_rc19/options.c openvpn-2.0_rc19.patched/options.c
--- openvpn-2.0_rc19/options.c	2005-02-10 20:18:08.000000000 -0600
+++ openvpn-2.0_rc19.patched/options.c	2005-04-06 19:08:05.610000000 -0500
@@ -533,7 +533,7 @@
   o->mtu_discover_type = -1;
   o->mssfix = MSSFIX_DEFAULT;
   o->route_delay_window = 30;
-  o->resolve_retry_seconds = RESOLV_RETRY_INFINITE;
+  o->resolve_retry_seconds = RESOLV_RETRY_UNSET;
 #ifdef ENABLE_OCC
   o->occ = true;
 #endif
@@ -1203,6 +1203,19 @@
     }
 
   /*
+   * Set resolv_retry value if not provided
+   */
+  if ((options->resolve_retry_seconds == RESOLV_RETRY_UNSET) &&
+      (remote_list_len(options->remote_list) > 1))
+    {
+      options->resolve_retry_seconds = RESOLV_RETRY_INFINITE;
+    }
+  else
+    {
+      options->resolve_retry_seconds = 0;
+    }
+
+  /*
    * If --mssfix is supplied without a parameter, default
    * it to --fragment value, if --fragment is specified.
    */
diff -ru openvpn-2.0_rc19/socket.c openvpn-2.0_rc19.patched/socket.c
--- openvpn-2.0_rc19/socket.c	2005-02-05 02:42:13.000000000 -0600
+++ openvpn-2.0_rc19.patched/socket.c	2005-04-06 18:39:22.320000000 -0500
@@ -746,7 +746,8 @@
 resolve_remote (struct link_socket *sock,
 		int phase,
 		const char **remote_dynamic,
-		volatile int *signal_received)
+		volatile int *signal_received,
+		bool multiple_remotes)
 {
   struct gc_arena gc = gc_new ();
 
@@ -766,7 +767,7 @@
 
 	      if (phase == 1)
 		{
-		  if (sock->resolve_retry_seconds)
+		  if (sock->resolve_retry_seconds || multiple_remotes)
 		    {
 		      flags = GETADDR_RESOLVE;
 		      retry = 0;
@@ -779,7 +780,7 @@
 		}
 	      else if (phase == 2)
 		{
-		  if (sock->resolve_retry_seconds)
+		  if (sock->resolve_retry_seconds || multiple_remotes)
 		    {
 		      flags = GETADDR_RESOLVE | GETADDR_FATAL;
 		      retry = sock->resolve_retry_seconds;
@@ -1007,7 +1008,7 @@
     {
       create_socket (sock);
       resolve_bind_local (sock);
-      resolve_remote (sock, 1, NULL, NULL);
+      resolve_remote (sock, 1, NULL, NULL, (remote_list_len(remote_list) > 1));
     }
 }
 
@@ -1015,7 +1016,8 @@
 void
 link_socket_init_phase2 (struct link_socket *sock,
 			 const struct frame *frame,
-			 volatile int *signal_received)
+			 volatile int *signal_received,
+			 bool multiple_remotes)
 {
   struct gc_arena gc = gc_new ();
   const char *remote_dynamic = NULL;
@@ -1053,7 +1055,7 @@
     }
   else
     {
-      resolve_remote (sock, 2, &remote_dynamic, signal_received);
+      resolve_remote (sock, 2, &remote_dynamic, signal_received, multiple_remotes);
 
       if (*signal_received)
 	goto done;
@@ -1159,7 +1161,7 @@
 	  sock->info.lsa->actual.sin_addr.s_addr = 0;
 	  sock->info.lsa->remote.sin_addr.s_addr = 0;
 
-	  resolve_remote (sock, 1, NULL, signal_received);
+	  resolve_remote (sock, 1, NULL, signal_received, multiple_remotes);
 
 	  if (*signal_received)
 	    goto done;
diff -ru openvpn-2.0_rc19/socket.h openvpn-2.0_rc19.patched/socket.h
--- openvpn-2.0_rc19/socket.h	2005-02-05 02:36:31.000000000 -0600
+++ openvpn-2.0_rc19.patched/socket.h	2005-04-06 18:34:46.120000000 -0500
@@ -47,6 +47,7 @@
  * represents.
  */
 #define RESOLV_RETRY_INFINITE 1000000000
+#define RESOLV_RETRY_UNSET     999999999
 
 #define REMOTE_LIST_SIZE 64
 
@@ -281,7 +282,8 @@
 
 void link_socket_init_phase2 (struct link_socket *sock,
 			      const struct frame *frame,
-			      volatile int *signal_received);
+			      volatile int *signal_received,
+			      bool multiple_remotes);
 
 void link_socket_post_fork (const struct link_socket *sock,
 			    const struct sockaddr_in *remote);

--=_smtp.isgenesis.com-3997-1112835056-0001-2--

