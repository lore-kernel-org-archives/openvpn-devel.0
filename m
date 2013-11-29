Date: Fri, 29 Nov 2013 20:42:58 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20131129194258.GL161@...1296...>
References: <1385382680-5912-1-git-send-email-arne@...1227...>
	<1385382680-5912-6-git-send-email-arne@...1227...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2ItTUDFNGRP62uHp"
Content-Disposition: inline
In-Reply-To: <1385382680-5912-6-git-send-email-arne@...1227...>
Subject: Re: [Openvpn-devel] [Patch v2 6/9] Implement dual stack client
	support for OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--2ItTUDFNGRP62uHp
Content-Type: multipart/mixed; boundary="qgS/pDjx1XAVyX9f"
Content-Disposition: inline

--qgS/pDjx1XAVyX9f
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Nov 25, 2013 at 01:31:17PM +0100, Arne Schwabe wrote:
> This patch contains a number of changes. I did not further spit this sinc=
e some changes make only sense being changed together.

ACK, but...

 - some parts of the patch did not apply cleanly due to whitespace issues
   (most likely I caused them in the previous merges, meh, but some of them
   were not my doing...), so I had to apply a few things manually - I=20
   *think* I got it all right, but hey...

   - while at it, I've cleaned up more whitespace (trailing blanks)

 - as discussed on IRC, I've adapted the complex if() condition in socket.h
   (link_socket_set_outgoing_addr()

 - I've included the fix to make "openvpn --test-crypto" work again

 - I've changed the patch to tun.c to use "local_public" (I assume this=20
   was intended and just a copy-paste overlook)

 - I've changed the protocol list to add "tcp4-server", "tcp4-client", and
   also changed "tcp-server" and "tcp-client" from AF_INET to AF_UNSPEC -
   and I'm not 100% sure if that is "right" for tcp-server.

So - amended patch below.  Arne, could you please verify that these changes
are all good and formally ACK again?  Transparency, and such :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--qgS/pDjx1XAVyX9f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Implement-dual-stack-client-support-for-OpenVPN.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 91cecc4166eb65703441997822b4582292fa84bb Mon Sep 17 00:00:00 2001
From: Arne Schwabe <arne@...1227...>
Date: Mon, 25 Nov 2013 13:31:17 +0100
Subject: [PATCH] Implement dual stack client support for OpenVPN

This patch contains a number of changes. I did not further spit this since =
some changes make only sense being changed together.

Always use connection_list, simplifies the reconnection logic.

Change meaning of --connect-retry-max and --connect-retry to be used
all connections. This now allows OpenVPN to quit after n unsuccessful
udp connection attempts

Remove the tcp reconnection logic. Failing a TCP connection will now
cause a USR1 like a UDP connection. Also extend sig->source from bool to
int to specify signal source. This allows a finer grained reconnection
logic if necessary in the future.

Dual-Stack support: if an address resolves to multiple records each
address is tried in sequential order. Then proceed to next connection
entry. Introduce the field current_remote to represent the current
connecting remote. Also change some fields to struct addrinfo* form
openvn_addr to store multiple addresses needed for the dual stack support.

Change meaning from udp and tcp to allow both IPv4 and IPv6. Introducue
new udp4 and tcp4 to force IPv4.

Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <1385382680-5912-6-git-send-email-arne@...1227...>
URL: http://article.gmane.org/gmane.network.openvpn.devel/8058

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/openvpn.8         |  24 +-
 src/openvpn/error.c   |   2 +-
 src/openvpn/init.c    | 234 +++++++++-------
 src/openvpn/manage.c  |  25 +-
 src/openvpn/manage.h  |   2 +-
 src/openvpn/options.c | 133 ++++-----
 src/openvpn/options.h |  26 +-
 src/openvpn/ps.c      |   8 +-
 src/openvpn/push.c    |   3 +-
 src/openvpn/sig.c     |  22 +-
 src/openvpn/sig.h     |  11 +-
 src/openvpn/socket.c  | 745 +++++++++++++++++++++++++---------------------=
----
 src/openvpn/socket.h  |  81 +++---
 src/openvpn/tun.c     |   9 +-
 src/openvpn/tun.h     |   2 +-
 15 files changed, 684 insertions(+), 643 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 99b4d22..d5376f9 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -221,6 +221,9 @@ options.
 indicates the protocol to use when connecting with the
 remote, and may be "tcp" or "udp".
=20
+For forcing IPv4 or IPv6 connection suffix tcp or udp
+with 4/6 like udp4/udp6/tcp4/tcp6.
+
 The client will move on to the next host in the list,
 in the event of connection failure.
 Note that at any given time, the OpenVPN client
@@ -463,13 +466,9 @@ possess a built-in reliability layer.
 .\"*********************************************************
 .TP
 .B \-\-connect-retry n
-For
-.B \-\-proto tcp-client,
-take
+Wait
 .B n
-as the
-number of seconds to wait
-between connection retries (default=3D5).
+seconds  between connection attempts (default=3D5).
 .\"*********************************************************
 .TP
 .B \-\-connect-timeout n
@@ -481,12 +480,15 @@ seconds (default=3D10).
 .\"*********************************************************
 .TP
 .B \-\-connect-retry-max n
-For
-.B \-\-proto tcp-client,
-take
 .B n
-as the
-number of retries of connection attempt (default=3Dinfinite).
+specifies the number of times all
+.B \-\-remote
+respectively
+.B <connection>
+statements are tried. Specifiying
+.B n
+as one would try each entry exactly once. A sucessful connection
+resets the counter. (default=3Dumlimited).
 .\"*********************************************************
 .TP
 .B \-\-show-proxy-settings
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 4a0418a..ebe9a52 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -259,7 +259,7 @@ void x_msg_va (const unsigned int flags, const char *fo=
rmat, va_list arglist)
   if (flags & M_SSL)
     {
       int nerrs =3D 0;
-      int err;
+      size_t err;
       while ((err =3D ERR_get_error ()))
 	{
 	  openvpn_snprintf (m2, ERR_BUF_SIZE, "%s: %s",
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e7f733b..41d6fad 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -284,84 +284,127 @@ static void
 init_connection_list (struct context *c)
 {
   struct connection_list *l =3D c->options.connection_list;
-  if (l)
+
+  l->current =3D -1;
+  if (c->options.remote_random)
     {
-      l->current =3D -1;
-      if (c->options.remote_random)
-	{
-	  int i;
-	  for (i =3D 0; i < l->len; ++i)
-	    {
-	      const int j =3D get_random () % l->len;
-	      if (i !=3D j)
-		{
-		  struct connection_entry *tmp;
-		  tmp =3D l->array[i];
-		  l->array[i] =3D l->array[j];
-		  l->array[j] =3D tmp;
-		}
-	    }
-	}
+      int i;
+      for (i =3D 0; i < l->len; ++i)
+        {
+          const int j =3D get_random () % l->len;
+          if (i !=3D j)
+            {
+              struct connection_entry *tmp;
+              tmp =3D l->array[i];
+              l->array[i] =3D l->array[j];
+              l->array[j] =3D tmp;
+            }
+        }
     }
 }
=20
 /*
+ * Clear the remote address list
+ */
+static void clear_remote_addrlist (struct link_socket_addr *lsa)
+{
+    if (lsa->remote_list) {
+        freeaddrinfo(lsa->remote_list);
+    }
+    lsa->remote_list =3D NULL;
+    lsa->current_remote =3D NULL;
+}
+
+/*
  * Increment to next connection entry
  */
 static void
 next_connection_entry (struct context *c)
 {
   struct connection_list *l =3D c->options.connection_list;
-  if (l)
-    {
-      bool ce_defined;
-      struct connection_entry *ce;
-      int n_cycles =3D 0;
+  bool ce_defined;
+  struct connection_entry *ce;
+  int n_cycles =3D 0;
=20
-      do {
-	ce_defined =3D true;
-	if (l->no_advance && l->current >=3D 0)
-	  {
-	    l->no_advance =3D false;
-	  }
-	else
-	  {
-	    if (++l->current >=3D l->len)
-	      {
-		l->current =3D 0;
-		++l->n_cycles;
-		if (++n_cycles >=3D 2)
-		  msg (M_FATAL, "No usable connection profiles are present");
-	      }
-	  }
+  do {
+    ce_defined =3D true;
+    if (c->options.no_advance && l->current >=3D 0)
+      {
+        c->options.no_advance =3D false;
+      }
+    else
+      {
+        /* Check if there is another resolved address to try for
+         * the current connection */
+        if (c->c1.link_socket_addr.current_remote &&
+            c->c1.link_socket_addr.current_remote->ai_next)
+          {
+            c->c1.link_socket_addr.current_remote =3D
+                c->c1.link_socket_addr.current_remote->ai_next;
+          }
+        else
+          {
+            /* FIXME (schwabe) fix the persist-remote-ip option for real,
+             * this is broken probably ever since connection lists and mul=
tiple
+             * remote existed
+             */
+
+            if (!c->options.persist_remote_ip)
+                clear_remote_addrlist (&c->c1.link_socket_addr);
+            else
+                c->c1.link_socket_addr.current_remote =3D
+                c->c1.link_socket_addr.remote_list;
+
+            /*
+             * Increase the number of connection attempts
+             * If this is connect-retry-max * size(l)
+             * OpenVPN will quit
+             */
+
+            c->options.unsuccessful_attempts++;
+
+            if (++l->current >=3D l->len)
+              {
+
+                l->current =3D 0;
+                if (++n_cycles >=3D 2)
+                    msg (M_FATAL, "No usable connection profiles are prese=
nt");
+              }
+          }
+      }
=20
-	ce =3D l->array[l->current];
+    ce =3D l->array[l->current];
=20
-	if (ce->flags & CE_DISABLED)
-	  ce_defined =3D false;
+    if (ce->flags & CE_DISABLED)
+      ce_defined =3D false;
=20
-	c->options.ce =3D *ce;
+    c->options.ce =3D *ce;
 #ifdef ENABLE_MANAGEMENT
-	if (ce_defined && management && management_query_remote_enabled(managemen=
t))
-	  {
-	    /* allow management interface to override connection entry details */
-	    ce_defined =3D ce_management_query_remote(c);
-	    if (IS_SIG (c))
-	      break;
-	  }
-        else
+    if (ce_defined && management && management_query_remote_enabled(manage=
ment))
+      {
+        /* allow management interface to override connection entry details=
 */
+        ce_defined =3D ce_management_query_remote(c);
+        if (IS_SIG (c))
+          break;
+      }
+    else
 #endif
=20
 #ifdef ENABLE_MANAGEMENT
-        if (ce_defined && management && management_query_proxy_enabled (ma=
nagement))
-          {
-            ce_defined =3D ce_management_query_proxy (c);
-            if (IS_SIG (c))
-              break;
-          }
+      if (ce_defined && management && management_query_proxy_enabled (mana=
gement))
+        {
+          ce_defined =3D ce_management_query_proxy (c);
+          if (IS_SIG (c))
+            break;
+        }
 #endif
-      } while (!ce_defined);
-    }
+  } while (!ce_defined);
+
+  /* Check if this connection attempt would bring us over the limit */
+  if (c->options.connect_retry_max > 0 &&
+      c->options.unsuccessful_attempts > (l->len  * c->options.connect_ret=
ry_max))
+      msg(M_FATAL, "All connections have been connect-retry-max (%d) times=
 unsuccessful, exiting",
+          c->options.connect_retry_max);
   update_options_ce_post (&c->options);
 }
=20
@@ -396,12 +439,6 @@ init_query_passwords (struct context *c)
=20
 #ifdef GENERAL_PROXY_SUPPORT
=20
-static int
-proxy_scope (struct context *c)
-{
-  return connection_list_defined (&c->options) ? 2 : 1;
-}
-
 static void
 uninit_proxy_dowork (struct context *c)
 {
@@ -463,17 +500,15 @@ init_proxy_dowork (struct context *c)
 }
=20
 static void
-init_proxy (struct context *c, const int scope)
+init_proxy (struct context *c)
 {
-  if (scope =3D=3D proxy_scope (c))
-    init_proxy_dowork (c);
+  init_proxy_dowork (c);
 }
=20
 static void
 uninit_proxy (struct context *c)
 {
-  if (c->sig->signal_received !=3D SIGUSR1 || proxy_scope (c) =3D=3D 2)
-    uninit_proxy_dowork (c);
+   uninit_proxy_dowork (c);
 }
=20
 #else
@@ -525,8 +560,6 @@ context_init_1 (struct context *c)
  }
 #endif
=20
-  /* initialize HTTP or SOCKS proxy object at scope level 1 */
-  init_proxy (c, 1);
 }
=20
 void
@@ -1222,6 +1255,9 @@ initialization_sequence_completed (struct context *c,=
 const unsigned int flags)
 {
   static const char message[] =3D "Initialization Sequence Completed";
=20
+  /* Reset the unsuccessful connection counter on complete initialisation =
*/
+  c->options.unsuccessful_attempts=3D0;
+
   /* If we delayed UID/GID downgrade or chroot, do it now */
   do_uid_gid_chroot (c, true);
=20
@@ -1239,9 +1275,9 @@ initialization_sequence_completed (struct context *c,=
 const unsigned int flags)
   else
     msg (M_INFO, "%s", message);
=20
-  /* Flag connection_list that we initialized */
-  if ((flags & (ISC_ERRORS|ISC_SERVER)) =3D=3D 0 && connection_list_define=
d (&c->options))
-    connection_list_set_no_advance (&c->options);
+  /* Flag that we initialized */
+  if ((flags & (ISC_ERRORS|ISC_SERVER)) =3D=3D 0)
+    c->options.no_advance=3Dtrue;
=20
 #ifdef WIN32
   fork_register_dns_action (c->c1.tuntap);
@@ -1355,7 +1391,7 @@ do_init_tun (struct context *c)
 			   c->options.ifconfig_ipv6_local,
 			   c->options.ifconfig_ipv6_netbits,
 			   c->options.ifconfig_ipv6_remote,
-			   addr_host (&c->c1.link_socket_addr.local),
+			   c->c1.link_socket_addr.bind_local,
 			   c->c1.link_socket_addr.remote_list,
 			   !c->options.ifconfig_nowarn,
 			   c->c2.es);
@@ -1545,7 +1581,7 @@ do_close_tun (struct context *c, bool force)
=20
 	  /* delete any routes we added */
 	  if (c->c1.route_list || c->c1.route_ipv6_list )
-            {
+           {
               run_up_down (c->options.route_predown_script,
                            c->plugins,
                            OPENVPN_PLUGIN_ROUTE_PREDOWN,
@@ -1832,13 +1868,10 @@ socket_restart_pause (struct context *c)
=20
   switch (c->options.ce.proto)
     {
-    case PROTO_UDP:
-      if (proxy)
-	sec =3D c->options.ce.connect_retry_seconds;
-      break;
     case PROTO_TCP_SERVER:
       sec =3D 1;
       break;
+    case PROTO_UDP:
     case PROTO_TCP_CLIENT:
       sec =3D c->options.ce.connect_retry_seconds;
       break;
@@ -2651,7 +2684,6 @@ do_init_socket_1 (struct context *c, const int mode)
 #endif
=20
   link_socket_init_phase1 (c->c2.link_socket,
-			   connection_list_defined (&c->options),
 			   c->options.ce.local,
 			   c->options.ce.local_port,
 			   c->options.ce.remote,
@@ -2676,9 +2708,7 @@ do_init_socket_1 (struct context *c, const int mode)
 			   c->options.ipchange,
 			   c->plugins,
 			   c->options.resolve_retry_seconds,
-			   c->options.ce.connect_retry_seconds,
 			   c->options.ce.connect_timeout,
-			   c->options.ce.connect_retry_max,
 			   c->options.ce.mtu_discover_type,
 			   c->options.rcvbuf,
 			   c->options.sndbuf,
@@ -2693,7 +2723,7 @@ static void
 do_init_socket_2 (struct context *c)
 {
   link_socket_init_phase2 (c->c2.link_socket, &c->c2.frame,
-			   &c->sig->signal_received);
+			   c->sig);
 }
=20
 /*
@@ -2865,15 +2895,30 @@ do_close_link_socket (struct context *c)
       c->c2.link_socket =3D NULL;
     }
=20
-  if (!(c->sig->signal_received =3D=3D SIGUSR1 && c->options.persist_remot=
e_ip))
-    {
-      if (c->c1.link_socket_addr.remote_list)
-        freeaddrinfo(c->c1.link_socket_addr.remote_list);
+   =20
+  /* Preserve the resolved list of remote if the user request to or if we =
want
+   * reconnect to the same host again or there are still addresses that ne=
ed
+   * to be tried */
+  if (!(c->sig->signal_received =3D=3D SIGUSR1 &&
+        ( (c->options.persist_remote_ip)
+         ||
+         ( c->sig->source !=3D SIG_SOURCE_HARD &&
+          ((c->c1.link_socket_addr.current_remote && c->c1.link_socket_add=
r.current_remote->ai_next)
+           || c->options.no_advance))
+         )))
+    {
+      clear_remote_addrlist(&c->c1.link_socket_addr);
+    }
+
+    /* Clear the remote actual address when persist_remote_ip is not in us=
e */
+    if (!(c->sig->signal_received =3D=3D SIGUSR1 && c->options.persist_rem=
ote_ip))
       CLEAR (c->c1.link_socket_addr.actual);
-    }
=20
-  if (!(c->sig->signal_received =3D=3D SIGUSR1 && c->options.persist_local=
_ip))
-    CLEAR (c->c1.link_socket_addr.local);
+  if (!(c->sig->signal_received =3D=3D SIGUSR1 && c->options.persist_local=
_ip)) {
+    if (c->c1.link_socket_addr.bind_local)
+        freeaddrinfo(c->c1.link_socket_addr.bind_local);
+    c->c1.link_socket_addr.bind_local=3DNULL;
+  }
 }
=20
 /*
@@ -3296,7 +3341,7 @@ init_instance (struct context *c, const struct env_se=
t *env, const unsigned int
   /* signals caught here will abort */
   c->sig->signal_received =3D 0;
   c->sig->signal_text =3D NULL;
-  c->sig->hard =3D false;
+  c->sig->source =3D SIG_SOURCE_SOFT;
=20
   if (c->mode =3D=3D CM_P2P)
     init_management_callback_p2p (c);
@@ -3382,7 +3427,7 @@ init_instance (struct context *c, const struct env_se=
t *env, const unsigned int
     do_event_set_init (c, false);
=20
   /* initialize HTTP or SOCKS proxy object at scope level 2 */
-  init_proxy (c, 2);
+  init_proxy (c);
=20
   /* allocate our socket object */
   if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP || c->mode =3D=3D CM_=
CHILD_TCP)
@@ -3720,7 +3765,7 @@ close_context (struct context *c, int sig, unsigned i=
nt flags)
   if (c->sig->signal_received =3D=3D SIGUSR1)
     {
       if ((flags & CC_USR1_TO_HUP)
-	  || (c->sig->hard && (flags & CC_HARD_USR1_TO_HUP)))
+	  || (c->sig->source =3D=3D SIG_SOURCE_HARD && (flags & CC_HARD_USR1_TO_H=
UP)))
 	c->sig->signal_received =3D SIGHUP;
     }
=20
@@ -3746,6 +3791,7 @@ test_crypto_thread (void *arg)
   ASSERT (options->test_crypto);
   init_verb_mute (c, IVM_LEVEL_1);
   context_init_1 (c);
+  next_connection_entry(c);
   do_init_crypto_static (c, 0);
=20
   frame_finalize_options (c, options);
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 3816740..dc6293a 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1461,7 +1461,7 @@ man_new_connection_post (struct management *man, cons=
t char *description)
 #endif
     msg (D_MANAGEMENT, "MANAGEMENT: %s %s",
 	 description,
-	 print_sockaddr (&man->settings.local, &gc));
+	 print_sockaddr (man->settings.local->ai_addr, &gc));
=20
   buffer_list_reset (man->connection.out);
=20
@@ -1569,7 +1569,8 @@ man_listen (struct management *man)
 #endif
 	{
 	  man->connection.sd_top =3D create_socket_tcp (AF_INET);
-	  socket_bind (man->connection.sd_top, &man->settings.local, "MANAGEMENT"=
);
+	  socket_bind (man->connection.sd_top, man->settings.local,
+                       AF_INET, "MANAGEMENT");
 	}
=20
       /*
@@ -1593,7 +1594,7 @@ man_listen (struct management *man)
       else
 #endif
 	msg (D_MANAGEMENT, "MANAGEMENT: TCP Socket listening on %s",
-	     print_sockaddr (&man->settings.local, &gc));
+	     print_sockaddr (man->settings.local->ai_addr, &gc));
     }
=20
 #ifdef WIN32
@@ -1636,7 +1637,7 @@ man_connect (struct management *man)
     {
       man->connection.sd_cli =3D create_socket_tcp (AF_INET);
       status =3D openvpn_connect (man->connection.sd_cli,
-				&man->settings.local,
+				man->settings.local->ai_addr,
 				5,
 				&signal_received);
     }
@@ -1661,7 +1662,7 @@ man_connect (struct management *man)
 #endif
       msg (D_LINK_ERRORS,
 	   "MANAGEMENT: connect to %s failed: %s",
-	   print_sockaddr (&man->settings.local, &gc),
+	   print_sockaddr (man->settings.local->ai_addr, &gc),
 	   strerror_ts (status, &gc));
       throw_signal_soft (SIGTERM, "management-connect-failed");
       goto done;
@@ -2122,13 +2123,9 @@ man_settings_init (struct man_settings *ms,
 	    }
 	  else
 	    {
-              struct addrinfo* ai;
               int status =3D openvpn_getaddrinfo(GETADDR_RESOLVE|GETADDR_W=
ARN_ON_SIGNAL|GETADDR_FATAL,
-                                               addr, port, 0, NULL, AF_INE=
T, &ai);
+                                               addr, port, 0, NULL, AF_INE=
T, &ms->local);
               ASSERT(status=3D=3D0);
-              ms->local.addr.in4 =3D *((struct sockaddr_in*)ai->ai_addr);
-              freeaddrinfo(ai);
-
 	    }
 	}
      =20
@@ -2587,7 +2584,13 @@ management_post_tunnel_open (struct management *man,=
 const in_addr_t tun_local_i
       && man->connection.state =3D=3D MS_INITIAL)
     {
       /* listen on our local TUN/TAP IP address */
-      man->settings.local.addr.in4.sin_addr.s_addr =3D htonl (tun_local_ip=
);
+      struct in_addr ia;
+      int ret;
+
+      ia.s_addr =3D htonl(tun_local_ip);
+      ret =3D openvpn_getaddrinfo(0, inet_ntoa(ia), NULL, 0, NULL,
+                                AF_INET, &man->settings.local);
+      ASSERT (ret=3D=3D0);
       man_connection_init (man);
     }
=20
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index a54d0b6..962b5bc 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -212,7 +212,7 @@ struct man_persist {
 struct man_settings {
   bool defined;
   unsigned int flags; /* MF_x flags */
-  struct openvpn_sockaddr local;
+  struct addrinfo* local;
 #if UNIX_SOCK_SUPPORT
   struct sockaddr_un local_unix;
 #endif
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index aa12cbd..3edab58 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -778,10 +778,10 @@ init_options (struct options *o, const bool init_gc)
   o->mode =3D MODE_POINT_TO_POINT;
   o->topology =3D TOP_NET30;
   o->ce.proto =3D PROTO_UDP;
-  o->ce.af =3D AF_INET;
+  o->ce.af =3D AF_UNSPEC;
   o->ce.connect_retry_seconds =3D 5;
   o->ce.connect_timeout =3D 10;
-  o->ce.connect_retry_max =3D 0;
+  o->connect_retry_max =3D 0;
   o->ce.local_port =3D o->ce.remote_port =3D OPENVPN_PORT;
   o->verbosity =3D 1;
   o->status_file_update_freq =3D 60;
@@ -1369,7 +1369,6 @@ show_connection_entry (const struct connection_entry =
*o)
   SHOW_BOOL (bind_local);
   SHOW_INT (connect_retry_seconds);
   SHOW_INT (connect_timeout);
-  SHOW_INT (connect_retry_max);
=20
 #ifdef ENABLE_HTTP_PROXY
   if (o->http_proxy_options)
@@ -1446,6 +1445,7 @@ show_settings (const struct options *o)
 #endif
 #endif
=20
+  SHOW_INT (connect_retry_max);
   show_connection_entries (o);
=20
   SHOW_BOOL (remote_random);
@@ -1727,32 +1727,31 @@ void
 options_postprocess_http_proxy_override (struct options *o)
 {
   const struct connection_list *l =3D o->connection_list;
-   if (l)
+  int i;
+  bool succeed =3D false;
+  for (i =3D 0; i < l->len; ++i)
+    {
+      struct connection_entry *ce =3D l->array[i];
+      if (ce->proto =3D=3D PROTO_TCP_CLIENT || ce->proto =3D=3D PROTO_TCP)
+        {
+          ce->http_proxy_options =3D o->http_proxy_override;
+          succeed =3D true;
+        }
+    }
+  if (succeed)
     {
-      int i;
-      bool succeed =3D false;
       for (i =3D 0; i < l->len; ++i)
-	{
-	  struct connection_entry *ce =3D l->array[i];
-	  if (ce->proto =3D=3D PROTO_TCP_CLIENT || ce->proto =3D=3D PROTO_TCP)
-	    {
-	      ce->http_proxy_options =3D o->http_proxy_override;
-	      succeed =3D true;
-	    }
-	}
-      if (succeed)
-	{
-	  for (i =3D 0; i < l->len; ++i)
-	    {
-	      struct connection_entry *ce =3D l->array[i];
-	      if (ce->proto =3D=3D PROTO_UDP)
-		{
-		  ce->flags |=3D CE_DISABLED;
-		}
-	    }
-	}
-      else
-        msg (M_WARN, "Note: option http-proxy-override ignored because no =
TCP-based connection profiles are defined");
+        {
+          struct connection_entry *ce =3D l->array[i];
+          if (ce->proto =3D=3D PROTO_UDP)
+            {
+              ce->flags |=3D CE_DISABLED;
+            }
+        }
+    }
+  else
+    {
+      msg (M_WARN, "Note: option http-proxy-override ignored because no TC=
P-based connection profiles are defined");
     }
 }
=20
@@ -1882,11 +1881,6 @@ options_postprocess_verify_ce (const struct options =
*options, const struct conne
   /*
    * Sanity check on TCP mode options
    */
-
-  if (ce->connect_retry_defined && ce->proto !=3D PROTO_TCP_CLIENT)
-    msg (M_USAGE, "--connect-retry doesn't make sense unless also used wit=
h "
-	 "--proto tcp-client or tcp6-client");
-
   if (ce->connect_timeout_defined && ce->proto !=3D PROTO_TCP_CLIENT)
     msg (M_USAGE, "--connect-timeout doesn't make sense unless also used w=
ith "
 	 "--proto tcp-client or tcp6-client");
@@ -2004,7 +1998,7 @@ options_postprocess_verify_ce (const struct options *=
options, const struct conne
     msg (M_USAGE, "--socks-proxy can not be used in TCP Server mode");
 #endif
=20
-  if (ce->proto =3D=3D PROTO_TCP_SERVER && connection_list_defined (option=
s))
+  if (ce->proto =3D=3D PROTO_TCP_SERVER && (options->connection_list->len =
> 1))
     msg (M_USAGE, "TCP server mode allows at most one --remote address");
=20
 #if P2MP_SERVER
@@ -2041,8 +2035,12 @@ options_postprocess_verify_ce (const struct options =
*options, const struct conne
       if (ce->socks_proxy_server)
 	msg (M_USAGE, "--socks-proxy cannot be used with --mode server");
 #endif
-      if (options->connection_list)
-	msg (M_USAGE, "<connection> cannot be used with --mode server");
+      /* <connection> blocks force to have a remote embedded, so we check =
for the
+       * --remote and bail out if it  is present */
+       if (options->connection_list->len >1 ||
+                  options->connection_list->array[0]->remote)
+          msg (M_USAGE, "<connection> cannot be used with --mode server");
+
 #if 0
       if (options->tun_ipv6)
 	msg (M_USAGE, "--tun-ipv6 cannot be used with --mode server");
@@ -2485,6 +2483,7 @@ options_postprocess_verify (const struct options *o)
 static void
 options_postprocess_mutate (struct options *o)
 {
+  int i;
   /*
    * Process helper-type options which map to other, more complex
    * sequences of options.
@@ -2498,48 +2497,38 @@ options_postprocess_mutate (struct options *o)
   if (o->remote_list && !o->connection_list)
     {
       /*
-       * For compatibility with 2.0.x, map multiple --remote options
-       * into connection list (connection lists added in 2.1).
+       * Convert remotes into connection list
        */
-      if (o->remote_list->len > 1 || o->force_connection_list)
-	{
-	  const struct remote_list *rl =3D o->remote_list;
-	  int i;
-	  for (i =3D 0; i < rl->len; ++i)
-	    {
-	      const struct remote_entry *re =3D rl->array[i];
-	      struct connection_entry ce =3D o->ce;
-	      struct connection_entry *ace;
-
-	      ASSERT (re->remote);
-	      connection_entry_load_re (&ce, re);
-	      ace =3D alloc_connection_entry (o, M_USAGE);
-	      ASSERT (ace);
-	      *ace =3D ce;
-	    }
-	}
-      else if (o->remote_list->len =3D=3D 1) /* one --remote option specif=
ied */
-	{
-	  connection_entry_load_re (&o->ce, o->remote_list->array[0]);
-	}
-      else
-	{
-	  ASSERT (0);
-	}
+      const struct remote_list *rl =3D o->remote_list;
+      for (i =3D 0; i < rl->len; ++i)
+        {
+          const struct remote_entry *re =3D rl->array[i];
+          struct connection_entry ce =3D o->ce;
+          struct connection_entry *ace;
+
+          ASSERT (re->remote);
+          connection_entry_load_re (&ce, re);
+          ace =3D alloc_connection_entry (o, M_USAGE);
+          ASSERT (ace);
+          *ace =3D ce;
+        }
     }
-  if (o->connection_list)
+  else if(!o->remote_list && !o->connection_list)
     {
-      int i;
-      for (i =3D 0; i < o->connection_list->len; ++i)
+      struct connection_entry *ace;
+      ace =3D alloc_connection_entry (o, M_USAGE);
+      ASSERT (ace);
+      *ace =3D o->ce;
+    }
+
+  ASSERT (o->connection_list);
+  for (i =3D 0; i < o->connection_list->len; ++i)
 	options_postprocess_mutate_ce (o, o->connection_list->array[i]);
=20
 #if HTTP_PROXY_OVERRIDE
-      if (o->http_proxy_override)
+  if (o->http_proxy_override)
 	options_postprocess_http_proxy_override(o);
 #endif
-    }
-  else
-    options_postprocess_mutate_ce (o, &o->ce); =20
=20
 #if P2MP
   /*
@@ -4169,7 +4158,6 @@ add_option (struct options *options,
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->management_flags |=3D MF_QUERY_PROXY;
-      options->force_connection_list =3D true;
     }
   else if (streq (p[0], "management-hold"))
     {
@@ -4442,7 +4430,6 @@ add_option (struct options *options,
       options->http_proxy_override =3D parse_http_proxy_override(p[1], p[2=
], p[3], msglevel, &options->gc);
       if (!options->http_proxy_override)
 	goto err;
-      options->force_connection_list =3D true;
     }
 #endif
   else if (streq (p[0], "remote") && p[1])
@@ -4494,7 +4481,6 @@ add_option (struct options *options,
     {
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
       options->ce.connect_retry_seconds =3D positive_atoi (p[1]);
-      options->ce.connect_retry_defined =3D true;
     }
   else if (streq (p[0], "connect-timeout") && p[1])
     {
@@ -4505,7 +4491,7 @@ add_option (struct options *options,
   else if (streq (p[0], "connect-retry-max") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_CONNECTION);
-      options->ce.connect_retry_max =3D positive_atoi (p[1]);
+      options->connect_retry_max =3D positive_atoi (p[1]);
     }
   else if (streq (p[0], "ipchange") && p[1])
     {
@@ -4930,7 +4916,6 @@ add_option (struct options *options,
 	  goto err;
 	}
       options->proto_force =3D proto_force;
-      options->force_connection_list =3D true;
     }
 #ifdef ENABLE_HTTP_PROXY
   else if (streq (p[0], "http-proxy") && p[1])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b320ca1..86760bb 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -97,8 +97,6 @@ struct connection_entry
   bool bind_defined;
   bool bind_local;
   int connect_retry_seconds;
-  bool connect_retry_defined;
-  int connect_retry_max;
   int connect_timeout;
   bool connect_timeout_defined;
 #ifdef ENABLE_HTTP_PROXY
@@ -155,8 +153,6 @@ struct connection_list
 {
   int len;
   int current;
-  int n_cycles;
-  bool no_advance;
   struct connection_entry *array[CONNECTION_LIST_SIZE];
 };
=20
@@ -209,10 +205,15 @@ struct options
 #endif
=20
   /* Networking parms */
+  int connect_retry_max;
   struct connection_entry ce;
   struct connection_list *connection_list;
+
   struct remote_list *remote_list;
-  bool force_connection_list;
+  /* Do not advanced the connection or remote addr list*/
+  bool no_advance;
+  /* Counts the number of unsuccessful connection attempts */
+  unsigned int unsuccessful_attempts;
=20
 #if HTTP_PROXY_OVERRIDE
   struct http_proxy_options *http_proxy_override;
@@ -775,20 +776,5 @@ bool get_ipv6_addr( const char * prefix_str, struct in=
6_addr *network,
 		    unsigned int * netbits, char ** printable_ipv6,=20
 		    int msglevel );
=20
-/*
- * inline functions
- */
-static inline bool
-connection_list_defined (const struct options *o)
-{
-  return o->connection_list !=3D NULL;
-}
-
-static inline void
-connection_list_set_no_advance (struct options *o)
-{
-  if (o->connection_list)
-    o->connection_list->no_advance =3D true;
-}
=20
 #endif
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 8714266..b22653b 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -330,8 +330,8 @@ journal_add (const char *journal_dir, struct proxy_conn=
ection *pc, struct proxy_
   if (!getpeername (pc->sd, (struct sockaddr *) &from.addr.sa, &slen)
       && !getsockname (cp->sd, (struct sockaddr *) &to.addr.sa, &dlen))
     {
-      const char *f =3D print_sockaddr (&from, &gc);
-      const char *t =3D print_sockaddr (&to, &gc);
+      const char *f =3D print_openvpn_sockaddr (&from, &gc);
+      const char *t =3D print_openvpn_sockaddr (&to, &gc);
       fnlen =3D  strlen(journal_dir) + strlen(t) + 2;
       jfn =3D (char *) malloc(fnlen);
       check_malloc_return (jfn);
@@ -408,20 +408,18 @@ proxy_entry_new (struct proxy_connection **list,
 		 struct buffer *initial_data,
 		 const char *journal_dir)
 {
-  struct openvpn_sockaddr osaddr;
   socket_descriptor_t sd_server;
   int status;
   struct proxy_connection *pc;
   struct proxy_connection *cp;
=20
   /* connect to port share server */
-  osaddr.addr.in4 =3D server_addr;
   if ((sd_server =3D socket (PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
     {
       msg (M_WARN|M_ERRNO, "PORT SHARE PROXY: cannot create socket");
       return false;
     }
-  status =3D openvpn_connect (sd_server, &osaddr, 5, NULL);
+  status =3D openvpn_connect (sd_server,(const struct sockaddr*)  &server_=
addr, 5, NULL);
   if (status)
     {
       msg (M_WARN, "PORT SHARE PROXY: connect to port-share server failed"=
);
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index be50bef..bd08cff 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -49,7 +49,8 @@ void
 receive_auth_failed (struct context *c, const struct buffer *buffer)
 {
   msg (M_VERB0, "AUTH: Received control message: %s", BSTR(buffer));
-  connection_list_set_no_advance(&c->options);
+  c->options.no_advance=3Dtrue;
+
   if (c->options.pull)
     {
       switch (auth_retry_get ())
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 5dee92b..90e39a4 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -97,14 +97,14 @@ void
 throw_signal (const int signum)
 {
   siginfo_static.signal_received =3D signum;
-  siginfo_static.hard =3D true;
+  siginfo_static.source =3D SIG_SOURCE_HARD;
 }
=20
 void
 throw_signal_soft (const int signum, const char *signal_text)
 {
   siginfo_static.signal_received =3D signum;
-  siginfo_static.hard =3D false;
+  siginfo_static.source =3D SIG_SOURCE_SOFT;
   siginfo_static.signal_text =3D signal_text;
 }
=20
@@ -115,7 +115,7 @@ signal_reset (struct signal_info *si)
     {
       si->signal_received =3D 0;
       si->signal_text =3D NULL;
-      si->hard =3D false;
+      si->source =3D SIG_SOURCE_SOFT;
     }
 }
=20
@@ -124,9 +124,23 @@ print_signal (const struct signal_info *si, const char=
 *title, int msglevel)
 {
   if (si)
     {
-      const char *hs =3D (si->hard ? "hard" : "soft");
       const char *type =3D (si->signal_text ? si->signal_text : "");
       const char *t =3D (title ? title : "process");
+      const char *hs;
+      switch (si->source)
+        {
+        case SIG_SOURCE_SOFT:
+          hs=3D "soft";
+          break;
+        case SIG_SOURCE_HARD:
+          hs =3D "hard";
+          break;
+        case SIG_SOURCE_CONNECTION_FAILED:
+          hs =3D "connection failed(soft)";
+          break;
+        default:
+          ASSERT(0);
+        }
=20
       switch (si->signal_received)
 	{
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index 987efef..c2c7b54 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -28,6 +28,15 @@
 #include "status.h"
 #include "win32.h"
=20
+
+
+#define SIG_SOURCE_SOFT 0
+#define SIG_SOURCE_HARD 1
+/* CONNECTION_FAILED is also a "soft" status,
+ * It is thrown if a connection attempt fails
+ */
+#define SIG_SOURCE_CONNECTION_FAILED 2
+
 /*
  * Signal information, including signal code
  * and descriptive text.
@@ -35,7 +44,7 @@
 struct signal_info
 {
   volatile int signal_received;
-  volatile bool hard;
+  volatile int source;
   const char *signal_text;
 };
=20
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index d176537..5ba1ee3 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -148,6 +148,9 @@ openvpn_getaddrinfo (unsigned int flags,
   ASSERT (hostname || servname);
   ASSERT (!(flags & GETADDR_HOST_ORDER));
=20
+  if (hostname && (flags & GETADDR_RANDOMIZE))
+    hostname =3D hostname_randomize(hostname, &gc);
+
   if(hostname)
     print_hostname =3D hostname;
   else
@@ -158,10 +161,6 @@ openvpn_getaddrinfo (unsigned int flags,
   else
     print_servname =3D "";
=20
-
-  if (flags & GETADDR_RANDOMIZE)
-    hostname =3D hostname_randomize(hostname, &gc);
-
   if (flags & GETADDR_MSG_VIRT_OUT)
     msglevel |=3D M_MSG_VIRT_OUT;
=20
@@ -173,17 +172,23 @@ openvpn_getaddrinfo (unsigned int flags,
   CLEAR(hints);
   hints.ai_family =3D ai_family;
   hints.ai_flags =3D AI_NUMERICHOST;
-  hints.ai_socktype =3D SOCK_STREAM;
=20
   if(flags & GETADDR_PASSIVE)
       hints.ai_flags |=3D AI_PASSIVE;
=20
+  if(flags & GETADDR_DATAGRAM)
+      hints.ai_socktype =3D SOCK_DGRAM;
+  else
+      hints.ai_socktype =3D SOCK_STREAM;
+
   status =3D getaddrinfo(hostname, servname, &hints, res);
=20
   if (status !=3D 0) /* parse as numeric address failed? */
     {
       const int fail_wait_interval =3D 5; /* seconds */
-      int resolve_retries =3D (flags & GETADDR_TRY_ONCE) ? 1 : (resolve_re=
try_seconds / fail_wait_interval);
+      /* Add +4 to cause integer division rounding up (1 + 4) =3D 5, (0+4)=
/5=3D0 */
+      int resolve_retries =3D (flags & GETADDR_TRY_ONCE) ? 1 :
+            ((resolve_retry_seconds + 4)/ fail_wait_interval);
       const char *fmt;
       int level =3D 0;
=20
@@ -270,7 +275,8 @@ openvpn_getaddrinfo (unsigned int flags,
=20
       /* hostname resolve succeeded */
=20
-      /* Do not chose an IP Addresse by random or change the order *
+      /*
+       * Do not choose an IP Addresse by random or change the order *
        * of IP addresses, doing so will break RFC 3484 address selection *
        */
     }
@@ -440,60 +446,6 @@ mac_addr_safe (const char *mac_addr)
   return true;
 }
=20
-static void
-update_remote (const char* host,
-	       struct openvpn_sockaddr *addr,
-	       bool *changed,
-	       const unsigned int sockflags)
-{
-  switch(addr->addr.sa.sa_family)
-    {
-    case AF_INET:
-      if (host && addr)
-	{
-	  const in_addr_t new_addr =3D getaddr (
-					      sf2gaf(GETADDR_RESOLVE|GETADDR_UPDATE_MANAGEMENT_STATE, sockfla=
gs),
-					      host,
-					      1,
-					      NULL,
-					      NULL);
-	  if (new_addr && addr->addr.in4.sin_addr.s_addr !=3D new_addr)
-	    {
-	      addr->addr.in4.sin_addr.s_addr =3D new_addr;
-	      *changed =3D true;
-	    }
-	}
-      break;
-    case AF_INET6:
-      if (host && addr)
-        {
-          int status;
-          struct addrinfo* ai;
-
-          status =3D openvpn_getaddrinfo(sf2gaf(GETADDR_RESOLVE|GETADDR_UP=
DATE_MANAGEMENT_STATE, sockflags),
-                                       host, NULL, 1, NULL, AF_INET6, &ai);
-
-          if ( status =3D=3D0 )
-            {
-			  struct sockaddr_in6 sin6;
-			  CLEAR(sin6);
-			  sin6 =3D *((struct sockaddr_in6*)ai->ai_addr);
-              if (!IN6_ARE_ADDR_EQUAL(&sin6.sin6_addr, &addr->addr.in6.sin=
6_addr))
-              {
-                int port =3D addr->addr.in6.sin6_port;
-                /* ipv6 requires also eg. sin6_scope_id =3D> easier to ful=
ly copy and override port */
-                addr->addr.in6 =3D sin6;=20
-                addr->addr.in6.sin6_port =3D port;
-              }
-			  freeaddrinfo(ai);
-            }
-        }
-      break;
-    default:
-        ASSERT(0);
-  }
-}
-
 static int
 socket_get_sndbuf (int sd)
 {
@@ -665,51 +617,41 @@ create_socket_tcp (int af)
 }
=20
 static socket_descriptor_t
-create_socket_udp (const unsigned int flags)
+create_socket_udp (const int af, const unsigned int flags)
 {
   socket_descriptor_t sd;
=20
-  if ((sd =3D socket (PF_INET, SOCK_DGRAM, IPPROTO_UDP)) < 0)
-    msg (M_ERR, "UDP: Cannot create UDP socket");
+  if ((sd =3D socket (af, SOCK_DGRAM, IPPROTO_UDP)) < 0)
+    msg (M_ERR, "UDP: Cannot create UDP/UDP6 socket");
 #if ENABLE_IP_PKTINFO
   else if (flags & SF_USE_IP_PKTINFO)
     {
       int pad =3D 1;
+      if(af =3D=3D AF_INET)
+        {
 #ifdef IP_PKTINFO
-      if (setsockopt (sd, SOL_IP, IP_PKTINFO,
-		      (void*)&pad, sizeof(pad)) < 0)
-        msg(M_ERR, "UDP: failed setsockopt for IP_PKTINFO");
+          if (setsockopt (sd, SOL_IP, IP_PKTINFO,
+                          (void*)&pad, sizeof(pad)) < 0)
+            msg(M_ERR, "UDP: failed setsockopt for IP_PKTINFO");
 #elif defined(IP_RECVDSTADDR)
-      if (setsockopt (sd, IPPROTO_IP, IP_RECVDSTADDR,
-		      (void*)&pad, sizeof(pad)) < 0)
-        msg(M_ERR, "UDP: failed setsockopt for IP_RECVDSTADDR");
+          if (setsockopt (sd, IPPROTO_IP, IP_RECVDSTADDR,
+                          (void*)&pad, sizeof(pad)) < 0)
+            msg(M_ERR, "UDP: failed setsockopt for IP_RECVDSTADDR");
 #else
 #error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix=
 syshead.h)
 #endif
-    }
-#endif
-  return sd;
-}
-
-static socket_descriptor_t
-create_socket_udp6 (const unsigned int flags)
-{
-  socket_descriptor_t sd;
-
-  if ((sd =3D socket (PF_INET6, SOCK_DGRAM, IPPROTO_UDP)) < 0)
-    msg (M_ERR, "UDP: Cannot create UDP6 socket");
-#if ENABLE_IP_PKTINFO
-  else if (flags & SF_USE_IP_PKTINFO)
-    {
-      int pad =3D 1;
+        }
+      else if (af =3D=3D AF_INET6 )
+        {
 #ifndef IPV6_RECVPKTINFO /* Some older Darwin platforms require this */
-      if (setsockopt (sd, IPPROTO_IPV6, IPV6_PKTINFO,
-		      (void*)&pad, sizeof(pad)) < 0)
+          if (setsockopt (sd, IPPROTO_IPV6, IPV6_PKTINFO,
+                          (void*)&pad, sizeof(pad)) < 0)
 #else
-      if (setsockopt (sd, IPPROTO_IPV6, IPV6_RECVPKTINFO,
-		      (void*)&pad, sizeof(pad)) < 0)
+          if (setsockopt (sd, IPPROTO_IPV6, IPV6_RECVPKTINFO,
+                          (void*)&pad, sizeof(pad)) < 0)
 #endif
-	msg(M_ERR, "UDP: failed setsockopt for IPV6_RECVPKTINFO");
+            msg(M_ERR, "UDP: failed setsockopt for IPV6_RECVPKTINFO");
+        }
     }
 #endif
   return sd;
@@ -718,31 +660,37 @@ create_socket_udp6 (const unsigned int flags)
 static void
 create_socket (struct link_socket *sock)
 {
-  /* create socket */
-  if (sock->info.proto =3D=3D PROTO_UDP && sock->info.af =3D=3D AF_INET)
+  /* create socket, use information carried over from getaddrinfo */
+  const int ai_proto =3D sock->info.lsa->actual.ai_protocol;
+  const int ai_family =3D sock->info.lsa->actual.ai_family;
+
+  ASSERT (sock->info.af =3D=3D AF_UNSPEC  || sock->info.af =3D=3D ai_famil=
y);
+
+   =20
+  if (ai_proto =3D=3D IPPROTO_UDP)
     {
-      sock->sd =3D create_socket_udp (sock->sockflags);
+      sock->sd =3D create_socket_udp (ai_family, sock->sockflags);
       sock->sockflags |=3D SF_GETADDRINFO_DGRAM;
=20
 #ifdef ENABLE_SOCKS
       if (sock->socks_proxy)
-	sock->ctrl_sd =3D create_socket_tcp (AF_INET);
+	sock->ctrl_sd =3D create_socket_tcp (ai_family);
 #endif
     }
-  else if (sock->info.proto =3D=3D PROTO_TCP_SERVER
-	   || sock->info.proto =3D=3D PROTO_TCP_CLIENT)
+  else if (ai_proto =3D=3D IPPROTO_TCP)
     {
-      sock->sd =3D create_socket_tcp (sock->info.af);
-    }
-  else if (sock->info.proto =3D=3D PROTO_UDP && sock->info.af =3D=3D AF_IN=
ET6)
-    {
-      sock->sd =3D create_socket_udp6 (sock->sockflags);
-      sock->sockflags |=3D SF_GETADDRINFO_DGRAM;
+      sock->sd =3D create_socket_tcp (ai_family);
     }
   else
     {
       ASSERT (0);
     }
+    /* set socket buffers based on --sndbuf and --rcvbuf options */
+    socket_set_buffers (sock->sd, &sock->socket_buffer_sizes);
+
+    /* set socket to --mark packets with given value */
+    socket_set_mark (sock->sd, sock->mark);
+
 #ifdef TARGET_ANDROID
   /* pass socket FD to management interface to pass on to VPNService API
    * as "protected socket" (exempt from being routed into tunnel)
@@ -757,10 +705,9 @@ create_socket (struct link_socket *sock)
 /*
  * Functions used for establishing a TCP stream connection.
  */
-
 static void
 socket_do_listen (socket_descriptor_t sd,
-		  const struct openvpn_sockaddr *local,
+		  const struct sockaddr *local,
 		  bool do_listen,
 		  bool do_set_nonblock)
 {
@@ -850,8 +797,7 @@ static int
 socket_listen_accept (socket_descriptor_t sd,
 		      struct link_socket_actual *act,
 		      const char *remote_dynamic,
-		      bool *remote_changed,
-		      const struct openvpn_sockaddr *local,
+		      const struct addrinfo *local,
 		      bool do_listen,
 		      bool nowait,
 		      volatile int *signal_received)
@@ -862,7 +808,7 @@ socket_listen_accept (socket_descriptor_t sd,
   int new_sd =3D SOCKET_UNDEFINED;
=20
   CLEAR (*act);
-  socket_do_listen (sd, local, do_listen, true);
+  socket_do_listen (sd, local->ai_addr, do_listen, true);
=20
   while (true)
     {
@@ -897,18 +843,26 @@ socket_listen_accept (socket_descriptor_t sd,
=20
       if (socket_defined (new_sd))
 	{
-	  update_remote (remote_dynamic, &remote_verify, remote_changed, 0);
-	  if (addr_defined (&remote_verify)
-	      && !addr_match (&remote_verify, &act->dest))
-	    {
-	      msg (M_WARN,
-		   "TCP NOTE: Rejected connection attempt from %s due to --remote settin=
g",
-		   print_link_socket_actual (act, &gc));
-	      if (openvpn_close_socket (new_sd))
-		msg (M_ERR, "TCP: close socket failed (new_sd)");
-	    }
+          struct addrinfo* ai;
+          if(remote_dynamic)
+              openvpn_getaddrinfo(0, remote_dynamic, NULL, 1, NULL,
+                                    remote_verify.addr.sa.sa_family, &ai);
+
+          if(ai && !addrlist_match(&remote_verify, ai))
+            {
+              msg (M_WARN,
+                   "TCP NOTE: Rejected connection attempt from %s due to -=
-remote setting",
+                   print_link_socket_actual (act, &gc));
+              if (openvpn_close_socket (new_sd))
+                  msg (M_ERR, "TCP: close socket failed (new_sd)");
+              freeaddrinfo(ai);
+            }
 	  else
-	    break;
+            {
+              if(ai)
+                  freeaddrinfo(ai);
+              break;
+            }
 	}
       openvpn_sleep (1);
     }
@@ -924,17 +878,38 @@ socket_listen_accept (socket_descriptor_t sd,
=20
 void
 socket_bind (socket_descriptor_t sd,
-             struct openvpn_sockaddr *local,
+             struct addrinfo *local,
+             int ai_family,
 	     const char *prefix)
 {
   struct gc_arena gc =3D gc_new ();
=20
-  if (bind (sd, &local->addr.sa, af_addr_size(local->addr.sa.sa_family)))
+  /* FIXME (schwabe)
+   * getaddrinfo for the bind address might return multiple AF_INET/AF_INE=
T6
+   * entries for the requested protocol.
+   * For example if an address has multiple A records
+   * What is the correct way to deal with it?
+   */
+
+  ASSERT(local);
+  struct addrinfo* cur;
+
+  /* find the first addrinfo with correct ai_family */
+  for (cur =3D local; cur; cur=3Dcur->ai_next)
+    {
+      if(cur->ai_family =3D=3D ai_family)
+          break;
+    }
+  if (!cur)
+      msg (M_FATAL, "%s: Socket bind failed: Addr to bind has no %s record=
",
+           prefix, addr_family_name(ai_family));
+
+  if (bind (sd, cur->ai_addr, cur->ai_addrlen))
     {
       const int errnum =3D openvpn_errno ();
       msg (M_FATAL, "%s: Socket bind failed on local address %s: %s",
 	   prefix,
-           print_sockaddr (local, &gc),
+           print_sockaddr_ex (local->ai_addr, ":", PS_SHOW_PORT, &gc),
            strerror_ts (errnum, &gc));
     }
   gc_free (&gc);
@@ -942,7 +917,7 @@ socket_bind (socket_descriptor_t sd,
=20
 int
 openvpn_connect (socket_descriptor_t sd,
-		 struct openvpn_sockaddr *remote,
+		 const struct sockaddr *remote,
 		 int connect_timeout,
 		 volatile int *signal_received)
 {
@@ -950,7 +925,7 @@ openvpn_connect (socket_descriptor_t sd,
=20
 #ifdef CONNECT_NONBLOCK
   set_nonblock (sd);
-  status =3D connect (sd, &remote->addr.sa, af_addr_size(remote->addr.sa.s=
a_family));
+  status =3D connect (sd, remote, af_addr_size(remote->sa_family));
   if (status)
     status =3D openvpn_errno ();
   if (
@@ -1022,37 +997,47 @@ openvpn_connect (socket_descriptor_t sd,
   return status;
 }
=20
+void set_actual_address (struct link_socket_actual* actual, struct addrinf=
o* ai)
+{
+    CLEAR (*actual);
+    ASSERT (ai);
+
+    if (ai->ai_family =3D=3D AF_INET)
+        actual->dest.addr.in4 =3D
+        *((struct sockaddr_in*) ai->ai_addr);
+    else if (ai->ai_family =3D=3D AF_INET6)
+        actual->dest.addr.in6 =3D
+        *((struct sockaddr_in6*) ai->ai_addr);
+    else
+        ASSERT(0);
+
+    /* Copy addrinfo sock parameters for socket creating */
+    actual->ai_family =3D ai->ai_family;
+    actual->ai_protocol =3D ai->ai_protocol;
+    actual->ai_socktype =3D ai->ai_socktype;
+}
+
 void
 socket_connect (socket_descriptor_t *sd,
-                struct openvpn_sockaddr *local,
-                bool bind_local,
-		struct openvpn_sockaddr *remote,
-		const bool connection_profiles_defined,
-		const char *remote_dynamic,
-		bool *remote_changed,
-		const int connect_retry_seconds,
-		const int connect_timeout,
-		const int connect_retry_max,
-		const unsigned int sockflags,
-		volatile int *signal_received)
+                struct link_socket_addr *lsa,
+                const int connect_timeout,
+                struct signal_info* sig_info)
 {
   struct gc_arena gc =3D gc_new ();
-  int retry =3D 0;
+  const struct sockaddr *dest =3D &lsa->actual.dest.addr.sa;
+
+  int status;
=20
 #ifdef CONNECT_NONBLOCK
-  msg (M_INFO, "Attempting to establish TCP connection with %s [nonblock]"=
,=20
-       print_sockaddr (remote, &gc));
+  msg (M_INFO, "Attempting to establish TCP connection with %s [nonblock]",
+       print_sockaddr (dest, &gc));
 #else
-  msg (M_INFO, "Attempting to establish TCP connection with %s",=20
-       print_sockaddr (remote, &gc));
+  msg (M_INFO, "Attempting to establish TCP connection with %s",
+       print_sockaddr (dest, &gc));
 #endif
=20
-  while (true)
-    {
-      int status;
-
 #ifdef ENABLE_MANAGEMENT
-      if (management)
+  if (management)
 	management_set_state (management,
 			      OPENVPN_STATE_TCP_CONNECT,
 			      NULL,
@@ -1060,47 +1045,28 @@ socket_connect (socket_descriptor_t *sd,
 			      (in_addr_t)0);
 #endif
=20
-      status =3D openvpn_connect (*sd, remote, connect_timeout, signal_rec=
eived);
+  /* Set the actual address */
+  status =3D openvpn_connect (*sd, dest, connect_timeout, &sig_info->signa=
l_received);
=20
-      get_signal (signal_received);
-      if (*signal_received)
+  get_signal (&sig_info->signal_received);
+  if (sig_info->signal_received)
 	goto done;
=20
-      if (!status)
-	break;
+  if (status) {
=20
-      msg (D_LINK_ERRORS,
-	   "TCP: connect to %s failed, will try again in %d seconds: %s",
-	   print_sockaddr (remote, &gc),
-	   connect_retry_seconds,
-	   strerror_ts (status, &gc));
+    msg (D_LINK_ERRORS,
+         "TCP: connect to %s failed: %s",
+         print_sockaddr (dest, &gc),
+         strerror_ts (status, &gc));
=20
-      gc_reset (&gc);
-
-      openvpn_close_socket (*sd);
-      *sd =3D SOCKET_UNDEFINED;
-
-      if ((connect_retry_max > 0 && ++retry >=3D connect_retry_max) || con=
nection_profiles_defined)
-	{
-	  *signal_received =3D SIGUSR1;
-	  goto done;
-	}
-
-      openvpn_sleep (connect_retry_seconds);
-
-      get_signal (signal_received);
-      if (*signal_received)
-	goto done;
-
-	*sd =3D create_socket_tcp (local->addr.sa.sa_family);
-
-      if (bind_local)
-        socket_bind (*sd, local, "TCP Client");
-      update_remote (remote_dynamic, remote, remote_changed, sockflags);
-    }
-
-  msg (M_INFO, "TCP connection established with %s",=20
-       print_sockaddr (remote, &gc));
+    openvpn_close_socket (*sd);
+    *sd =3D SOCKET_UNDEFINED;
+    sig_info->signal_received =3D SIGUSR1;
+    sig_info->source =3D SIG_SOURCE_CONNECTION_FAILED;
+  } else {
+      msg (M_INFO, "TCP connection established with %s",
+        print_sockaddr (dest, &gc));
+  }
=20
  done:
   gc_free (&gc);
@@ -1151,48 +1117,48 @@ frame_adjust_path_mtu (struct frame *frame, int pmt=
u, int proto)
 }
=20
 static void
-resolve_bind_local (struct link_socket *sock)
+resolve_bind_local (struct link_socket *sock, const sa_family_t af)
 {
   struct gc_arena gc =3D gc_new ();
=20
   /* resolve local address if undefined */
-  if (!addr_defined (&sock->info.lsa->local))
+  if (!sock->info.lsa->bind_local)
     {
+      int flags =3D GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL |
+	GETADDR_FATAL | GETADDR_PASSIVE;
       int status;
-      struct addrinfo *ai;
-
-      /* may return AF_{INET|INET6} guessed from local_host */
-      const int af =3D addr_guess_family(sock->info.af, sock->local_host);
-      status =3D openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_WARN_ON_SIG=
NAL | GETADDR_FATAL | GETADDR_PASSIVE,
-                                   sock->local_host, sock->local_port, 0, =
NULL, af, &ai);
-      if(status =3D=3D0) {
-        switch(af) {
-        case AF_INET:
-          sock->info.lsa->local.addr.in4 =3D  *((struct sockaddr_in*)(ai->=
ai_addr));
-
-        case AF_INET6:
-          sock->info.lsa->local.addr.in6 =3D *((struct sockaddr_in6*)(ai->=
ai_addr));
-          break;
-          freeaddrinfo(ai);
-        }
-      } else {
-        msg (M_FATAL, "getaddrinfo() failed for local \"%s:%s\": %s",
-             sock->local_host, sock->local_port,
-             gai_strerror(status));
+
+      if(proto_is_dgram(sock->info.proto))
+	flags |=3D GETADDR_DATAGRAM;
+
+      /* will return AF_{INET|INET6}from local_host */
+      status =3D openvpn_getaddrinfo(flags, sock->local_host, sock->local_=
port, 0,
+				   NULL, af, &sock->info.lsa->bind_local);
+
+      if(status !=3D0) {
+	msg (M_FATAL, "getaddrinfo() failed for local \"%s:%s\": %s",
+	     sock->local_host, sock->local_port,
+	     gai_strerror(status));
       }
     }
=20
-  /* bind to local address/port */
-  if (sock->bind_local)
-    {
+  gc_free (&gc);
+}
+
+static void bind_local (struct link_socket *sock)
+{
+    /* bind to local address/port */
+    if (sock->bind_local)
+      {
 #ifdef ENABLE_SOCKS
-      if (sock->socks_proxy && sock->info.proto =3D=3D PROTO_UDP && sock->=
info.af =3D=3D AF_INET)
-          socket_bind (sock->ctrl_sd, &sock->info.lsa->local, "SOCKS");
-      else
+        if (sock->socks_proxy && sock->info.proto =3D=3D PROTO_UDP)
+            socket_bind (sock->ctrl_sd, sock->info.lsa->bind_local,
+                         sock->info.lsa->actual.ai_family, "SOCKS");
+        else
 #endif
-          socket_bind (sock->sd, &sock->info.lsa->local, "TCP/UDP");
-    }
-  gc_free (&gc);
+            socket_bind (sock->sd, sock->info.lsa->bind_local,
+                         sock->info.lsa->actual.ai_family,  "TCP/UDP");
+      }
 }
=20
 static void
@@ -1202,7 +1168,6 @@ resolve_remote (struct link_socket *sock,
 		volatile int *signal_received)
 {
   struct gc_arena gc =3D gc_new ();
-  int af;
=20
   if (!sock->did_resolve_remote)
     {
@@ -1214,9 +1179,11 @@ resolve_remote (struct link_socket *sock,
 	      unsigned int flags =3D sf2gaf(GETADDR_RESOLVE|GETADDR_UPDATE_MANAGE=
MENT_STATE, sock->sockflags);
 	      int retry =3D 0;
 	      int status =3D -1;
-	      struct addrinfo* ai;
+              struct addrinfo* ai;
+              if (proto_is_dgram(sock->info.proto))
+                  flags |=3D GETADDR_DATAGRAM;
=20
-	      if (sock->connection_profiles_defined && sock->resolve_retry_second=
s =3D=3D RESOLV_RETRY_INFINITE)
+	      if (sock->resolve_retry_seconds =3D=3D RESOLV_RETRY_INFINITE)
 		{
 		  if (phase =3D=3D 2)
 		    flags |=3D (GETADDR_TRY_ONCE | GETADDR_FATAL);
@@ -1251,19 +1218,20 @@ resolve_remote (struct link_socket *sock,
 		  ASSERT (0);
 		}
=20
-		  /* Temporary fix, this need to be changed for dual stack */
-		  status =3D openvpn_getaddrinfo(flags, sock->remote_host, sock->remote_=
port,
-                                               retry, signal_received, af,=
 &ai);
-		  if(status =3D=3D 0) {
-                          sock->info.lsa->remote_list =3D ai;
-
-			  dmsg (D_SOCKET_DEBUG, "RESOLVE_REMOTE flags=3D0x%04x phase=3D%d rrs=
=3D%d sig=3D%d status=3D%d",
-					flags,
-					phase,
-					retry,
-					signal_received ? *signal_received : -1,
-					status);
-		  }
+	      status =3D openvpn_getaddrinfo (flags, sock->remote_host, sock->rem=
ote_port,
+					    retry, signal_received, sock->info.af, &ai);
+
+	      if(status =3D=3D 0) {
+		sock->info.lsa->remote_list =3D ai;
+		sock->info.lsa->current_remote =3D ai;
+
+		dmsg (D_SOCKET_DEBUG, "RESOLVE_REMOTE flags=3D0x%04x phase=3D%d rrs=3D%d=
 sig=3D%d status=3D%d",
+		      flags,
+		      phase,
+		      retry,
+		      signal_received ? *signal_received : -1,
+		      status);
+	      }
 	      if (signal_received)
 		{
 		  if (*signal_received)
@@ -1289,16 +1257,10 @@ resolve_remote (struct link_socket *sock,
       else
 	{
 	  CLEAR (sock->info.lsa->actual);
-	  /* TODO(schwabe) will only use first address als dest address */
-	  if(sock->info.lsa->remote_list) {
-	      if (sock->info.lsa->remote_list->ai_family =3D=3D AF_INET)
-		  sock->info.lsa->actual.dest.addr.in4 =3D
-		  *((struct sockaddr_in*) sock->info.lsa->remote_list->ai_addr);
-	      else if (sock->info.lsa->remote_list->ai_family =3D=3D AF_INET6)
-		  sock->info.lsa->actual.dest.addr.in6 =3D
-		  *((struct sockaddr_in6*) sock->info.lsa->remote_list->ai_addr);
-	      else
-		  ASSERT(0);
+	  if(sock->info.lsa->current_remote)
+	    {
+	      set_actual_address (&sock->info.lsa->actual,
+				  sock->info.lsa->current_remote);
 	    }
 	}
=20
@@ -1310,6 +1272,8 @@ resolve_remote (struct link_socket *sock,
   gc_free (&gc);
 }
=20
+
+
 struct link_socket *
 link_socket_new (void)
 {
@@ -1324,26 +1288,40 @@ link_socket_new (void)
 }
=20
 void
-create_new_socket (struct link_socket* sock, int mark)
+create_new_socket (struct link_socket* sock)
 {
-  create_socket (sock);
+   if (sock->bind_local) {
+      resolve_bind_local (sock, sock->info.af);
+  }
+  resolve_remote (sock, 1, NULL, NULL);
+  /*
+   * In P2P or server mode we must create the socket even when resolving
+   * the remote site fails/is not specified. */
=20
-  /* set socket buffers based on --sndbuf and --rcvbuf options */
-  socket_set_buffers (sock->sd, &sock->socket_buffer_sizes);
+  if (sock->info.af && sock->info.lsa->actual.ai_family=3D=3D0 && sock->bi=
nd_local)
+    {
+      /* Copy sock parameters from bind addr */
+      set_actual_address (&sock->info.lsa->actual, sock->info.lsa->bind_lo=
cal);
+      /* clear destination set by set_actual_address */
+      CLEAR(sock->info.lsa->actual.dest);
+    }
=20
-  /* set socket to --mark packets with given value */
-  socket_set_mark (sock->sd, mark);
+  /*
+   * Create the socket early if socket should be bound
+   */
+  if (sock->bind_local && sock->info.lsa->actual.ai_family)
+    {
+      create_socket (sock);
=20
-  if(sock->bind_local)
-      resolve_bind_local (sock);
-  resolve_remote (sock, 1, NULL, NULL);
+      if (sock->bind_local)
+          bind_local(sock);
+    }
 }
=20
=20
 /* bind socket if necessary */
 void
 link_socket_init_phase1 (struct link_socket *sock,
-			 const bool connection_profiles_defined,
 			 const char *local_host,
 			 const char *local_port,
 			 const char *remote_host,
@@ -1368,9 +1346,7 @@ link_socket_init_phase1 (struct link_socket *sock,
 			 const char *ipchange_command,
 			 const struct plugin_list *plugins,
 			 int resolve_retry_seconds,
-			 int connect_retry_seconds,
 			 int connect_timeout,
-			 int connect_retry_max,
 			 int mtu_discover_type,
 			 int rcvbuf,
 			 int sndbuf,
@@ -1379,8 +1355,6 @@ link_socket_init_phase1 (struct link_socket *sock,
 {
   ASSERT (sock);
=20
-  sock->connection_profiles_defined =3D connection_profiles_defined;
-
   sock->local_host =3D local_host;
   sock->local_port =3D local_port;
   sock->remote_host =3D remote_host;
@@ -1397,9 +1371,7 @@ link_socket_init_phase1 (struct link_socket *sock,
   sock->bind_local =3D bind_local;
   sock->inetd =3D inetd;
   sock->resolve_retry_seconds =3D resolve_retry_seconds;
-  sock->connect_retry_seconds =3D connect_retry_seconds;
   sock->connect_timeout =3D connect_timeout;
-  sock->connect_retry_max =3D connect_retry_max;
   sock->mtu_discover_type =3D mtu_discover_type;
=20
 #ifdef ENABLE_DEBUG
@@ -1410,6 +1382,7 @@ link_socket_init_phase1 (struct link_socket *sock,
   sock->socket_buffer_sizes.sndbuf =3D sndbuf;
=20
   sock->sockflags =3D sockflags;
+  sock->mark =3D mark;
=20
   sock->info.proto =3D proto;
   sock->info.af =3D af;
@@ -1484,7 +1457,7 @@ link_socket_init_phase1 (struct link_socket *sock,
     }
   else if (mode !=3D LS_MODE_TCP_ACCEPT_FROM)
     {
-      create_new_socket (sock, mark);
+      create_new_socket (sock);
     }
 }
=20
@@ -1502,11 +1475,11 @@ void phase2_inetd (struct link_socket* sock, const =
struct frame *frame,
       /* inetd: hint family type for dest =3D local's */
       struct openvpn_sockaddr local_addr;
       socklen_t addrlen =3D sizeof(local_addr);
-      if (getsockname (sock->sd, (struct sockaddr *)&local_addr, &addrlen)=
 =3D=3D 0) {
+      if (getsockname (sock->sd, &local_addr.addr.sa, &addrlen) =3D=3D 0) {
 	sock->info.lsa->actual.dest.addr.sa.sa_family =3D local_addr.addr.sa.sa_f=
amily;
 	dmsg (D_SOCKET_DEBUG, "inetd(%s): using sa_family=3D%d from getsockname(%=
d)",
-	      proto2ascii(sock->info.proto, sock->info.af, false), local_addr.add=
r.sa.sa_family,
-	      sock->sd);
+	      proto2ascii(sock->info.proto, sock->info.af, false),
+	      local_addr.addr.sa.sa_family, sock->sd);
       } else
 	msg (M_WARN, "inetd(%s): getsockname(%d) failed, using AF_INET",
 	     proto2ascii(sock->info.proto, sock->info.af, false), sock->sd);
@@ -1520,11 +1493,11 @@ void phase2_inetd (struct link_socket* sock, const =
struct frame *frame,
       socket_listen_accept (sock->sd,
 			    &sock->info.lsa->actual,
 			    remote_dynamic,
-			    &remote_changed,
-			    &sock->info.lsa->local,
+			    sock->info.lsa->bind_local,
 			    false,
 			    sock->inetd =3D=3D INETD_NOWAIT,
 			    signal_received);
+
   }
   ASSERT (!remote_changed);
 }
@@ -1566,11 +1539,23 @@ linksock_print_addr (struct link_socket *sock)
   /* print local address */
   if (sock->inetd)
     msg (msglevel, "%s link local: [inetd]", proto2ascii (sock->info.proto=
, sock->info.af, true));
-  else
-    msg (msglevel, "%s link local%s: %s",
+    else if (sock->bind_local)
+      {
+	/* Socket is always bound on the first matching address */
+	struct addrinfo *cur;
+	for (cur =3D sock->info.lsa->bind_local; cur; cur=3Dcur->ai_next)
+	  {
+	    if(cur->ai_family =3D=3D sock->info.lsa->actual.ai_family)
+		break;
+	  }
+	ASSERT (cur);
+	msg (msglevel, "%s link local (bound): %s",
 	   proto2ascii (sock->info.proto, sock->info.af, true),
-	   (sock->bind_local ? " (bound)" : ""),
-	   print_openvpn_sockaddr_ex (&sock->info.lsa->local, ":", sock->bind_loc=
al ? PS_SHOW_PORT : 0, &gc));
+	   print_sockaddr(cur->ai_addr,&gc));
+      }
+    else
+	msg (msglevel, "%s link local: (not bound)",
+	     proto2ascii (sock->info.proto, sock->info.af, true));
=20
   /* print active remote address */
   msg (msglevel, "%s link remote: %s",
@@ -1583,8 +1568,8 @@ linksock_print_addr (struct link_socket *sock)
 }
=20
 static void
-phase2_tcp_server (struct link_socket *sock, bool *remote_changed,
-		   const char *remote_dynamic, volatile int *signal_received)
+phase2_tcp_server (struct link_socket *sock, const char *remote_dynamic,
+		   volatile int *signal_received)
 {
   switch (sock->mode)
     {
@@ -1592,15 +1577,14 @@ phase2_tcp_server (struct link_socket *sock, bool *=
remote_changed,
       sock->sd =3D socket_listen_accept (sock->sd,
 				       &sock->info.lsa->actual,
 				       remote_dynamic,
-				       remote_changed,
-				       &sock->info.lsa->local,
+				       sock->info.lsa->bind_local,
 				       true,
 				       false,
 				       signal_received);
       break;
     case LS_MODE_TCP_LISTEN:
       socket_do_listen (sock->sd,
-			&sock->info.lsa->local,
+			sock->info.lsa->bind_local->ai_addr,
 			true,
 			false);
       break;
@@ -1622,90 +1606,76 @@ phase2_tcp_server (struct link_socket *sock, bool *=
remote_changed,
=20
=20
 static void
-phase2_tcp_client (struct link_socket *sock, bool *remote_changed,
-		   const char *remote_dynamic, volatile int *signal_received)
+phase2_tcp_client (struct link_socket *sock, struct signal_info *sig_info)
 {
 #ifdef GENERAL_PROXY_SUPPORT
-    bool proxy_retry =3D false;
+  bool proxy_retry =3D false;
 #else
-    const bool proxy_retry =3D false;
-#endif
-    do {
-	socket_connect (&sock->sd,
-			&sock->info.lsa->local,
-			sock->bind_local,
-			&sock->info.lsa->actual.dest,
-			sock->connection_profiles_defined,
-			remote_dynamic,
-			remote_changed,
-			sock->connect_retry_seconds,
-			sock->connect_timeout,
-			sock->connect_retry_max,
-			sock->sockflags,
-			signal_received);
-
-	if (*signal_received)
-	    return;
-
-	if (false)
-	    ;
+  const bool proxy_retry =3D false;
+#endif
+  do {
+    socket_connect (&sock->sd,
+                   sock->info.lsa,
+                   sock->connect_timeout,
+                   sig_info);
+
+    if (sig_info->signal_received)
+      return;
+
+    if (false)
+      ;
 #ifdef ENABLE_HTTP_PROXY
-	else if (sock->http_proxy)
-	    {
-		proxy_retry =3D establish_http_proxy_passthru (sock->http_proxy,
-							     sock->sd,
-							     sock->proxy_dest_host,
-							     sock->proxy_dest_port,
-							     &sock->stream_buf.residual,
-							     signal_received);
-	    }
+    else if (sock->http_proxy)
+      {
+	proxy_retry =3D establish_http_proxy_passthru (sock->http_proxy,
+						     sock->sd,
+						     sock->proxy_dest_host,
+						     sock->proxy_dest_port,
+						     &sock->stream_buf.residual,
+						     &sig_info->signal_received);
+      }
 #endif
 #ifdef ENABLE_SOCKS
-	else if (sock->socks_proxy)
-	    {
-		establish_socks_proxy_passthru (sock->socks_proxy,
-						sock->sd,
-						sock->proxy_dest_host,
-						sock->proxy_dest_port,
-						signal_received);
-	    }
+    else if (sock->socks_proxy)
+      {
+	establish_socks_proxy_passthru (sock->socks_proxy,
+					sock->sd,
+					sock->proxy_dest_host,
+					sock->proxy_dest_port,
+					&sig_info->signal_received);
+      }
 #endif
-	if (proxy_retry)
-	    {
-		openvpn_close_socket (sock->sd);
-		sock->sd =3D create_socket_tcp (AF_INET);
-	    }
-    } while (proxy_retry);
+    if (proxy_retry)
+      {
+	/* TODO (schwabe): This code assumes AF_INET for the proxy socket
+         * when retrying a connection */
+	openvpn_close_socket (sock->sd);
+	sock->sd =3D create_socket_tcp (AF_INET);
+      }
+
+  } while (proxy_retry);
+
 }
=20
 #ifdef ENABLE_SOCKS
 static void
-phase2_socks_client (struct link_socket *sock, bool *remote_changed,
-		      const char *remote_dynamic, volatile int *signal_received)
+phase2_socks_client (struct link_socket *sock, struct signal_info *sig_inf=
o)
 {
     socket_connect (&sock->ctrl_sd,
-		    &sock->info.lsa->local,
-		    sock->bind_local,
-		    &sock->info.lsa->actual.dest,
-		    sock->connection_profiles_defined,
-		    remote_dynamic,
-		    remote_changed,
-		    sock->connect_retry_seconds,
+		    sock->info.lsa,
 		    sock->connect_timeout,
-		    sock->connect_retry_max,
-		    sock->sockflags,
-		    signal_received);
+		    sig_info);
=20
-    if (*signal_received)
+    if (sig_info->signal_received)
 	return;
=20
     establish_socks_proxy_udpassoc (sock->socks_proxy,
 				    sock->ctrl_sd,
 				    sock->sd,
 				    &sock->socks_relay.dest,
-				    signal_received);
+				    &sig_info->signal_received);
=20
-    if (*signal_received)
+    if (sig_info->signal_received)
 	return;
=20
     sock->remote_host =3D sock->proxy_dest_host;
@@ -1713,12 +1683,14 @@ phase2_socks_client (struct link_socket *sock, bool=
 *remote_changed,
     sock->did_resolve_remote =3D false;
=20
     addr_zero_host(&sock->info.lsa->actual.dest);
-    if (sock->info.lsa->remote_list) {
+    if (sock->info.lsa->remote_list)
+      {
 	freeaddrinfo(sock->info.lsa->remote_list);
-	sock->info.lsa->remote_list=3DNULL;
-    }
+	sock->info.lsa->current_remote =3D NULL;
+	sock->info.lsa->remote_list =3D NULL;
+      }
=20
-    resolve_remote (sock, 1, NULL, signal_received);
+    resolve_remote (sock, 1, NULL, &sig_info->signal_received);
 }
 #endif
=20
@@ -1726,18 +1698,17 @@ phase2_socks_client (struct link_socket *sock, bool=
 *remote_changed,
 void
 link_socket_init_phase2 (struct link_socket *sock,
 			 const struct frame *frame,
-			 volatile int *signal_received)
+			 struct signal_info *sig_info)
 {
   const char *remote_dynamic =3D NULL;
-  bool remote_changed =3D false;
   int sig_save =3D 0;
=20
   ASSERT (sock);
=20
-  if (signal_received && *signal_received)
+  if (sig_info && sig_info->signal_received)
     {
-      sig_save =3D *signal_received;
-      *signal_received =3D 0;
+      sig_save =3D sig_info->signal_received;
+      sig_info->signal_received =3D 0;
     }
=20
   /* initialize buffers */
@@ -1754,56 +1725,65 @@ link_socket_init_phase2 (struct link_socket *sock,
   /* were we started by inetd or xinetd? */
   if (sock->inetd)
     {
-      phase2_inetd (sock, frame, remote_dynamic, signal_received);
-      if (*signal_received)
+      phase2_inetd (sock, frame, remote_dynamic,  &sig_info->signal_receiv=
ed);
+      if (sig_info && sig_info->signal_received)
 	goto done;
=20
     }
   else
     {
-      resolve_remote (sock, 2, &remote_dynamic, signal_received);
+      /* Second chance to resolv/create socket */
+      resolve_remote (sock, 2, &remote_dynamic,  &sig_info->signal_receive=
d);
=20
-      if (*signal_received)
+      /* If socket has not already been created create it now */
+      if (sock->sd =3D=3D SOCKET_UNDEFINED)
+	{
+	  if (sock->info.lsa->actual.ai_family)
+	    {
+	      create_socket (sock);
+	    }
+	  else
+	    {
+	      msg (M_WARN, "Could not determine IPv4/IPv6 protocol");
+	      sig_info->signal_received =3D SIGUSR1;
+	      goto done;
+	    }
+
+	  if (sock->bind_local)
+	    bind_local(sock);
+	}
+
+      if (sig_info && sig_info->signal_received)
 	goto done;
=20
       if (sock->info.proto =3D=3D PROTO_TCP_SERVER)
 	{
-	  phase2_tcp_server(sock, &remote_changed, remote_dynamic,
-			    signal_received);
+	  phase2_tcp_server (sock, remote_dynamic,
+			     &sig_info->signal_received);
 	}
       else if (sock->info.proto =3D=3D PROTO_TCP_CLIENT)
 	{
-	  phase2_tcp_client(sock, &remote_changed, remote_dynamic,
-			    signal_received);
+	  phase2_tcp_client (sock, sig_info);
=20
 	}
 #ifdef ENABLE_SOCKS
-      else if (sock->info.proto =3D=3D PROTO_UDP && sock->socks_proxy && s=
ock->info.af =3D=3D AF_INET)
+      else if (sock->info.proto =3D=3D PROTO_UDP && sock->socks_proxy)
 	{
-	  phase2_socks_client(sock, &remote_changed, remote_dynamic,
-			      signal_received);
+	  phase2_socks_client (sock, sig_info);
 #endif
 	}
-      if (*signal_received)
+      if (sig_info && sig_info->signal_received)
 	goto done;
-
-      if (remote_changed)
-	{
-	  msg (M_INFO, "TCP/UDP: Dynamic remote address changed during TCP connec=
tion establishment");
-	  /* TODO(schwabe) handle multiple addresses */
-	  ASSERT(0);
-	  addr_copy_host(&sock->info.lsa->remote_list->ai_addr, &sock->info.lsa->=
actual.dest);
-	}
     }
=20
   phase2_set_socket_flags(sock);
   linksock_print_addr(sock);
=20
  done:
-  if (sig_save && signal_received)
+  if (sig_save && sig_info)
     {
-      if (!*signal_received)
-	*signal_received =3D sig_save;
+      if (!sig_info->signal_received)
+	sig_info->signal_received =3D sig_save;
     }
 }
=20
@@ -1936,10 +1916,7 @@ link_socket_bad_incoming_addr (struct buffer *buf,
 			       const struct link_socket_actual *from_addr)
 {
   struct gc_arena gc =3D gc_new ();
-  struct openvpn_sockaddr firstremoteaddr;
-
-  /* TODO(schwabe) Fix this and print all remote addresses */
-  firstremoteaddr.addr.in6 =3D *(struct sockaddr_in6*)info->lsa->remote_li=
st->ai_addr;
+  struct addrinfo* ai;
=20
   switch(from_addr->dest.addr.sa.sa_family)
     {
@@ -1949,7 +1926,12 @@ link_socket_bad_incoming_addr (struct buffer *buf,
 	   "TCP/UDP: Incoming packet rejected from %s[%d], expected peer address:=
 %s (allow this incoming source address/port by removing --remote or adding=
 --float)",
 	   print_link_socket_actual (from_addr, &gc),
 	   (int)from_addr->dest.addr.sa.sa_family,
-	   print_sockaddr (&firstremoteaddr, &gc));
+	   print_sockaddr_ex (info->lsa->remote_list->ai_addr,":" ,PS_SHOW_PORT, =
&gc));
+          /* print additional remote addresses */
+          for(ai=3Dinfo->lsa->remote_list->ai_next;ai;ai=3Dai->ai_next) {
+             msg(D_LINK_ERRORS,"or from peer address: %s",
+                 print_sockaddr_ex(ai->ai_addr,":",PS_SHOW_PORT, &gc));
+          }
       break;
     }
   buf->len =3D 0;
@@ -1974,15 +1956,17 @@ link_socket_current_remote (const struct link_socke=
t_info *info)
  * Maybe in the future consider PF_INET6 endpoints also ...
  * by now just ignore it
  *
+ * For --remote entries with multiple addresses this
+ * only return the actual endpoint we have sucessfully connected to
  */
-/* TODO(schwabe) what to do for a remote with multiple IPs? */
   if (lsa->actual.dest.addr.sa.sa_family !=3D AF_INET)
     return IPV4_INVALID_ADDR;
=20
   if (link_socket_actual_defined (&lsa->actual))
     return ntohl (lsa->actual.dest.addr.in4.sin_addr.s_addr);
-  else if (lsa->remote_list)
-    return ntohl (((struct sockaddr_in*)lsa->remote_list->ai_addr)->sin_ad=
dr.s_addr);
+  else if (lsa->current_remote)
+    return ntohl (((struct sockaddr_in*)lsa->current_remote->ai_addr)
+                    ->sin_addr.s_addr);
   else
     return 0;
 }
@@ -2465,10 +2449,17 @@ struct proto_names {
 /* Indexed by PROTO_x */
 static const struct proto_names proto_names[] =3D {
   {"proto-uninitialized",        "proto-NONE", AF_UNSPEC, PROTO_NONE},
-  {"udp",        "UDPv4", AF_INET, PROTO_UDP},
-  {"tcp-server", "TCPv4_SERVER", AF_INET, PROTO_TCP_SERVER},
-  {"tcp-client", "TCPv4_CLIENT", AF_INET, PROTO_TCP_CLIENT},
-  {"tcp",        "TCPv4", AF_INET, PROTO_TCP},
+  /* try IPv4 and IPv6 (client), bind dual-stack (server) */
+  {"udp",        "UDP", AF_UNSPEC, PROTO_UDP},
+  {"tcp-server", "TCP_SERVER", AF_UNSPEC, PROTO_TCP_SERVER},
+  {"tcp-client", "TCP_CLIENT", AF_UNSPEC, PROTO_TCP_CLIENT},
+  {"tcp",        "TCP", AF_UNSPEC, PROTO_TCP},
+  /* force IPv4 */
+  {"udp4",       "UDPv4", AF_INET, PROTO_UDP},
+  {"tcp4-server","TCPv4_SERVER", AF_INET, PROTO_TCP_SERVER},
+  {"tcp4-client","TCPv4_CLIENT", AF_INET, PROTO_TCP_CLIENT},
+  {"tcp4",       "TCPv4", AF_INET, PROTO_TCP},
+  /* force IPv6 */
   {"udp6"       ,"UDPv6", AF_INET6, PROTO_UDP},
   {"tcp6-server","TCPv6_SERVER", AF_INET6, PROTO_TCP_SERVER},
   {"tcp6-client","TCPv6_CLIENT", AF_INET6, PROTO_TCP_CLIENT},
@@ -2807,7 +2798,7 @@ link_socket_write_tcp (struct link_socket *sock,
=20
 #if ENABLE_IP_PKTINFO
=20
-int
+size_t
 link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
 				     struct buffer *buf,
 				     struct link_socket_actual *to)
@@ -2821,7 +2812,7 @@ link_socket_write_udp_posix_sendmsg (struct link_sock=
et *sock,
   iov.iov_len =3D BLEN (buf);
   mesg.msg_iov =3D &iov;
   mesg.msg_iovlen =3D 1;
-  switch (sock->info.lsa->remote_list->ai_family)
+  switch (to->ai_family)
     {
     case AF_INET:
       {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 65def10..5c93474 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -81,6 +81,11 @@ struct openvpn_sockaddr
 struct link_socket_actual
 {
   /*int dummy;*/ /* add offset to force a bug if dest not explicitly deref=
erenced */
+ int ai_family;	/* PF_xxx */
+ int ai_socktype;	/* SOCK_xxx */
+ int ai_protocol;	/* 0 or IPPROTO_xxx for IPv4 and IPv6 */
+
+
   struct openvpn_sockaddr dest;
 #if ENABLE_IP_PKTINFO
   union {
@@ -97,8 +102,10 @@ struct link_socket_actual
 /* IP addresses which are persistant across SIGUSR1s */
 struct link_socket_addr
 {
-  struct openvpn_sockaddr local;
-  struct addrinfo* remote_list;   /* initial remote */
+  struct addrinfo* bind_local;
+  struct addrinfo* remote_list;   /* complete remote list */
+  struct addrinfo* current_remote;  /* remote used in the
+                                     current connection attempt */
   struct link_socket_actual actual; /* reply to this address */
 };
=20
@@ -176,9 +183,6 @@ struct link_socket
   /* used for long-term queueing of pre-accepted socket listen */
   bool listen_persistent_queued;
=20
-  /* Does config file contain any <connection> ... </connection> blocks? */
-  bool connection_profiles_defined;
-
   const char *remote_host;
   const char *remote_port;
   const char *local_host;
@@ -196,9 +200,7 @@ struct link_socket
   int mode;
=20
   int resolve_retry_seconds;
-  int connect_retry_seconds;
   int connect_timeout;
-  int connect_retry_max;
   int mtu_discover_type;
=20
   struct socket_buffer_size socket_buffer_sizes;
@@ -213,6 +215,7 @@ struct link_socket
 # define SF_HOST_RANDOMIZE (1<<3)
 # define SF_GETADDRINFO_DGRAM (1<<4)
   unsigned int sockflags;
+  int mark;
=20
   /* for stream sockets */
   struct stream_buf stream_buf;
@@ -284,11 +287,12 @@ int socket_finalize (
 struct link_socket *link_socket_new (void);
=20
 void socket_bind (socket_descriptor_t sd,
-		  struct openvpn_sockaddr *local,
+		  struct addrinfo *local,
+                  int af_family,
 		  const char *prefix);
=20
 int openvpn_connect (socket_descriptor_t sd,
-		     struct openvpn_sockaddr *remote,
+		     const struct sockaddr *remote,
 		     int connect_timeout,
 		     volatile int *signal_received);
=20
@@ -298,7 +302,6 @@ int openvpn_connect (socket_descriptor_t sd,
=20
 void
 link_socket_init_phase1 (struct link_socket *sock,
-			 const bool connection_profiles_defined,
 			 const char *local_host,
 			 const char *local_port,
 			 const char *remote_host,
@@ -323,9 +326,7 @@ link_socket_init_phase1 (struct link_socket *sock,
 			 const char *ipchange_command,
 			 const struct plugin_list *plugins,
 			 int resolve_retry_seconds,
-			 int connect_retry_seconds,
 			 int connect_timeout,
-			 int connect_retry_max,
 			 int mtu_discover_type,
 			 int rcvbuf,
 			 int sndbuf,
@@ -334,7 +335,7 @@ link_socket_init_phase1 (struct link_socket *sock,
=20
 void link_socket_init_phase2 (struct link_socket *sock,
 			      const struct frame *frame,
-			      volatile int *signal_received);
+			      struct signal_info *sig_info);
=20
 void socket_adjust_frame_parameters (struct frame *frame, int proto);
=20
@@ -364,12 +365,21 @@ const char *print_openvpn_sockaddr_ex (const struct o=
penvpn_sockaddr *addr,
 }
=20
 static inline
-const char *print_sockaddr (const struct openvpn_sockaddr *addr,
+const char *print_openvpn_sockaddr (const struct openvpn_sockaddr *addr,
 			    struct gc_arena *gc)
 {
     return print_sockaddr_ex (&addr->addr.sa, ":", PS_SHOW_PORT, gc);
 }
=20
+static inline
+const char *print_sockaddr (const struct sockaddr *addr,
+                                    struct gc_arena *gc)
+{
+    return print_sockaddr_ex (addr, ":", PS_SHOW_PORT, gc);
+}
+
+
+
 const char *print_link_socket_actual_ex (const struct link_socket_actual *=
act,
 					 const char* separator,
 					 const unsigned int flags,
@@ -420,6 +430,9 @@ void link_socket_bad_incoming_addr (struct buffer *buf,
 				    const struct link_socket_info *info,
 				    const struct link_socket_actual *from_addr);
=20
+void set_actual_address (struct link_socket_actual* actual,
+                         struct addrinfo* ai);
+
 void link_socket_bad_outgoing_addr (void);
=20
 void setenv_trusted (struct env_set *es, const struct link_socket_info *in=
fo);
@@ -496,6 +509,7 @@ bool unix_socket_get_peer_uid_gid (const socket_descrip=
tor_t sd, int *uid, int *
 #define GETADDR_UPDATE_MANAGEMENT_STATE (1<<8)
 #define GETADDR_RANDOMIZE             (1<<9)
 #define GETADDR_PASSIVE               (1<<10)
+#define GETADDR_DATAGRAM              (1<<11)
=20
 in_addr_t getaddr (unsigned int flags,
 		   const char *hostname,
@@ -741,19 +755,6 @@ addr_copy_sa(struct openvpn_sockaddr *dst, const struc=
t openvpn_sockaddr *src)
   dst->addr =3D src->addr;
 }
=20
-static inline void
-addr_copy_host(struct openvpn_sockaddr *dst, const struct openvpn_sockaddr=
 *src)
-{
-   switch(src->addr.sa.sa_family) {
-     case AF_INET:
-       dst->addr.in4.sin_addr.s_addr =3D src->addr.in4.sin_addr.s_addr;
-       break;
-     case AF_INET6:=20
-       dst->addr.in6.sin6_addr =3D src->addr.in6.sin6_addr;
-       break;
-   }
-}
-
 static inline bool
 addr_inet4or6(struct sockaddr *addr)
 {
@@ -838,7 +839,7 @@ link_socket_verify_incoming_addr (struct buffer *buf,
 	case AF_INET:
 	  if (!link_socket_actual_defined (from_addr))
 	    return false;
-	  if (info->remote_float || !info->lsa->remote_list)
+	  if (info->remote_float || (!info->lsa->remote_list))
 	    return true;
 	  if (addrlist_match_proto (&from_addr->dest, info->lsa->remote_list, inf=
o->proto))
 	    return true;
@@ -877,13 +878,15 @@ link_socket_set_outgoing_addr (const struct buffer *b=
uf,
     {
       struct link_socket_addr *lsa =3D info->lsa;
       if (
-	  /* new or changed address? */
-	  (!info->connection_established
-	   || !addr_match_proto (&act->dest, &lsa->actual.dest, info->proto))
-	  /* address undef or address =3D=3D remote or --float */
-	  && (info->remote_float
-	      || !lsa->remote_list
-	      || addrlist_match_proto (&act->dest, lsa->remote_list, info->proto))
+	   /* new or changed address? */
+	   (!info->connection_established
+	    || !addr_match_proto (&act->dest, &lsa->actual.dest, info->proto)
+	    )
+	   &&
+	   /* address undef or address =3D=3D remote or --float */
+	   (info->remote_float ||
+	       (!lsa->remote_list || addrlist_match_proto (&act->dest, lsa->remot=
e_list, info->proto))
+	    )
 	  )
 	{
 	  link_socket_connection_initiated (buf, info, act, common_name, es);
@@ -1007,13 +1010,13 @@ link_socket_write_win32 (struct link_socket *sock,
=20
 #else
=20
-static inline int
+static inline size_t
 link_socket_write_udp_posix (struct link_socket *sock,
 			     struct buffer *buf,
 			     struct link_socket_actual *to)
 {
 #if ENABLE_IP_PKTINFO
-  int link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
+  size_t link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
 					   struct buffer *buf,
 					   struct link_socket_actual *to);
=20
@@ -1027,7 +1030,7 @@ link_socket_write_udp_posix (struct link_socket *sock,
 		   (socklen_t) af_addr_size(to->dest.addr.sa.sa_family));
 }
=20
-static inline int
+static inline size_t
 link_socket_write_tcp_posix (struct link_socket *sock,
 			     struct buffer *buf,
 			     struct link_socket_actual *to)
@@ -1037,7 +1040,7 @@ link_socket_write_tcp_posix (struct link_socket *sock,
=20
 #endif
=20
-static inline int
+static inline size_t
 link_socket_write_udp (struct link_socket *sock,
 		       struct buffer *buf,
 		       struct link_socket_actual *to)
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 0f30e2f..a300275 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -411,7 +411,7 @@ init_tun (const char *dev,       /* --dev option */
 	  const char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 IPv6 */
 	  int         ifconfig_ipv6_netbits_parm,
 	  const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 IPv6 */
-	  in_addr_t local_public,
+	  struct addrinfo *local_public,
 	  struct addrinfo *remote_public,
 	  const bool strict_warn,
 	  struct env_set *es)
@@ -474,11 +474,14 @@ init_tun (const char *dev,       /* --dev option */
 	   * make sure they do not clash with our virtual subnet.
 	   */
=20
-	  check_addr_clash ("local",
+          for(curele=3Dlocal_public;curele;curele=3Dcurele->ai_next) {
+            if(curele->ai_family =3D=3D AF_INET)
+              check_addr_clash ("local",
 			    tt->type,
-			    local_public,
+                            ((struct sockaddr_in*)curele->ai_addr)->sin_ad=
dr.s_addr,
 			    tt->local,
 			    tt->remote_netmask);
+          }
=20
 	  for (curele=3Dremote_public;curele;curele=3Dcurele->ai_next) {
 	    if (curele->ai_family =3D=3D AF_INET)
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index ea2290c..631b53c 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -232,7 +232,7 @@ struct tuntap *init_tun (const char *dev,       /* --de=
v option */
 			 const char *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 / IPv6 =
*/
 			 int ifconfig_ipv6_netbits_parm,           /* --ifconfig parm 1 / bits =
*/
 			 const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 / IPv6 =
*/
-			 in_addr_t local_public,
+			 struct addrinfo *local_public,
 			 struct addrinfo *remote_public,
 			 const bool strict_warn,
 			 struct env_set *es);
--=20
1.8.1.5


--qgS/pDjx1XAVyX9f--

--2ItTUDFNGRP62uHp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUpjuQakuBuNlUUl1AQKp9gQAnllaGSp1y8VSQlxexILWcVNxD4vPVQHA
ur+Ae/r3ZociMSo2u7Jnp0zcaUM6+QzApFqOQglO/4pUjkJONe9g+6WleQkXVHOF
FnuYDQCDUbgfVcYxwu7qb8XwkQyNqTqzq8XgdWcaGl71S3I1e4Jsn+luMxNQeJTA
5ohf8HHKwgY=
=wx5S
-----END PGP SIGNATURE-----

--2ItTUDFNGRP62uHp--

