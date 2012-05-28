MIME-Version: 1.0
Sender: samkob@...277...
From: SamB <ja.ovpn@...1727...>
Date: Mon, 28 May 2012 12:29:01 +0200
Message-ID: <CALb=60Z=zh1dWx5B1oum9D7GBgGhEXi0v1S1fFCD8DhtAyw6WA@...278...>
Subject: [Openvpn-devel] [PATCH] OCC ping
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

=A0 this is simple patch implementing internal openvpn ping over OCC channe=
l.
=A0 Important difference of OCC ping (OCC_PING) to existing one is that
this one is replied on the other side of the channel (with
OCC_PING_REPLY),
=A0 thus making it possible to configure clients and server ping and
ping-restart timeout differently.
=A0 This might be usefull if someone is trying to combine mobile and
non-mobile clients on one openvpn server. Non-mobile clients might
want to have
=A0 reliable link and ping more frequently compared to mobile clients
that might not want this (ie. to save battery on android ;-).

=A0 OCC ping replaces 'normal' ping if activated via occ-ping directive,
and thus fully integrates with all ping/ping-restart/... directives.
=A0 Additionaly I've implemented occ-ping-compat mode, that will send
OCC_REQUEST instread of OCC_PING. All OCC clients will then reply to
this
=A0 request with OCC_REPLY message - it might be usefull to enable this
on server, to stay backward compatible with older non occ-ping
clients.

=A0 Please review it ;)
  Thanks.

Sam


diff -ur openvpn-2.2.2/occ.c openvpn-2.2.2-dev/occ.c
--- openvpn-2.2.2/occ.c	2011-12-13 17:58:56.000000000 +0100
+++ openvpn-2.2.2-dev/occ.c	2012-05-27 19:23:15.000000000 +0200
@@ -302,6 +302,29 @@
       dmsg (D_PACKET_CONTENT, "SENT OCC_EXIT");
       doit =3D true;
       break;
+
+    case OCC_PING:
+      if (c->options.occ_ping_compat)
+        {
+          if (!buf_write_u8 (&c->c2.buf, OCC_REQUEST))
+	    break;
+          dmsg (D_PACKET_CONTENT, "SENT OCC_REQUEST (compat OCC_PING)");
+        }
+      else
+        {
+          if (!buf_write_u8 (&c->c2.buf, OCC_PING))
+	    break;
+          dmsg (D_PACKET_CONTENT, "SENT OCC_PING");
+        }
+      doit =3D true;
+      break;
+
+    case OCC_PING_REPLY:
+      if (!buf_write_u8 (&c->c2.buf, OCC_PING_REPLY))
+	break;
+      dmsg (D_PACKET_CONTENT, "SENT OCC_PING_REPLY");
+      doit =3D true;
+      break;
     }

   if (doit)
@@ -384,6 +407,14 @@
       c->sig->signal_received =3D SIGTERM;
       c->sig->signal_text =3D "remote-exit";
       break;
+
+    case OCC_PING:
+      dmsg (D_PACKET_CONTENT, "RECEIVED OCC_PING");
+      c->c2.occ_op =3D OCC_PING_REPLY;
+      break;
+    case OCC_PING_REPLY:
+      dmsg (D_PACKET_CONTENT, "RECEIVED OCC_PING_REPLY");
+      break;
     }
   c->c2.buf.len =3D 0; /* don't pass packet on */
 }
diff -ur openvpn-2.2.2/occ.h openvpn-2.2.2-dev/occ.h
--- openvpn-2.2.2/occ.h	2011-04-26 10:33:04.000000000 +0200
+++ openvpn-2.2.2-dev/occ.h	2012-05-25 23:07:18.000000000 +0200
@@ -70,6 +70,13 @@
 #define OCC_EXIT               6

 /*
+ * OCC based ping
+ */
+#define OCC_PING		7
+#define OCC_PING_REPLY		8
+
+
+/*
  * Used to conduct a load test command sequence
  * of UDP connection for empirical MTU measurement.
  */
diff -ur openvpn-2.2.2/options.c openvpn-2.2.2-dev/options.c
--- openvpn-2.2.2/options.c	2011-12-13 17:58:56.000000000 +0100
+++ openvpn-2.2.2-dev/options.c	2012-05-25 23:20:55.000000000 +0200
@@ -229,6 +229,11 @@
   "--ping-timer-rem: Run the --ping-exit/--ping-restart timer only if
we have a\n"
   "                  remote address.\n"
   "--ping n        : Ping remote once every n seconds over TCP/UDP port.\n"
+#ifdef ENABLE_OCC
+  "--occ-ping      : Ping using internal OCC protocol.\n"
+  "--occ-ping-compat : Use backward compatible OCC ping.\n"
+  "                  Use for clients without occ-ping support.\n"
+#endif
 #if ENABLE_IP_PKTINFO
   "--multihome     : Configure a multi-homed UDP server.\n"
 #endif
@@ -1235,8 +1240,11 @@
   SHOW_BOOL (ping_timer_remote);
   SHOW_INT (remap_sigusr1);
 #ifdef ENABLE_OCC
+  SHOW_BOOL (occ_ping);
+  SHOW_BOOL (occ_ping_compat);
   SHOW_INT (explicit_exit_notification);
 #endif
+
   SHOW_BOOL (persist_tun);
   SHOW_BOOL (persist_local_ip);
   SHOW_BOOL (persist_remote_ip);
@@ -4529,6 +4537,16 @@
       options->ping_timer_remote =3D true;
     }
 #ifdef ENABLE_OCC
+  else if (streq (p[0], "occ-ping"))
+    {
+      VERIFY_PERMISSION (OPT_P_TIMER);
+      options->occ_ping =3D true;
+    }
+  else if (streq (p[0], "occ-ping-compat"))
+    {
+      VERIFY_PERMISSION (OPT_P_TIMER);
+      options->occ_ping_compat =3D true;
+    }
   else if (streq (p[0], "explicit-exit-notify"))
     {
       VERIFY_PERMISSION (OPT_P_EXPLICIT_NOTIFY);
diff -ur openvpn-2.2.2/options.h openvpn-2.2.2-dev/options.h
--- openvpn-2.2.2/options.h	2011-12-13 17:58:56.000000000 +0100
+++ openvpn-2.2.2-dev/options.h	2012-05-25 23:04:14.000000000 +0200
@@ -239,6 +239,11 @@
   int ping_send_timeout;        /* Send a TCP/UDP ping to remote
every n seconds */
   int ping_rec_timeout;         /* Expect a TCP/UDP ping from remote
at least once every n seconds */
   bool ping_timer_remote;       /* Run ping timer only if we have a
remote address */
+#ifdef ENABLE_OCC
+  bool occ_ping;		/* Enable OCC ping */
+  bool occ_ping_compat;		/* Enable OCC ping compatibility mode */
+#endif
+
   bool tun_ipv6;                /* Build tun dev that supports IPv6 */

 # define PING_UNDEF   0
diff -ur openvpn-2.2.2/ping-inline.h openvpn-2.2.2-dev/ping-inline.h
--- openvpn-2.2.2/ping-inline.h	2011-04-26 10:33:04.000000000 +0200
+++ openvpn-2.2.2-dev/ping-inline.h	2012-05-27 18:50:40.000000000 +0200
@@ -53,7 +53,14 @@
       && event_timeout_trigger (&c->c2.ping_send_interval,
 				&c->c2.timeval,
 				!TO_LINK_DEF(c) ? ETT_DEFAULT : 1))
-    check_ping_send_dowork (c);
+    {
+#ifdef ENABLE_OCC
+      if(c->options.occ_ping)
+        c->c2.occ_op =3D OCC_PING;
+      else
+#endif
+        check_ping_send_dowork (c);
+    }
 }

 #endif

