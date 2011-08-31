From: Heiko Hund <heiko.hund@...1489...>
Date: Wed, 31 Aug 2011 20:05:15 +0200
Message-Id: <1314813915-30115-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH] add --mark option to set SO_MARK sockopt
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

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 init.c    |    1 +
 openvpn.8 |    6 ++++++
 options.c |   14 ++++++++++++++
 options.h |    3 +++
 socket.c  |   13 +++++++++++++
 socket.h  |    1 +
 6 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/init.c b/init.c
index 0530b10..e8c9aab 100644
--- a/init.c
+++ b/init.c
@@ -2640,6 +2640,7 @@ do_init_socket_1 (struct context *c, const int mode)
 			   c->options.mtu_discover_type,
 			   c->options.rcvbuf,
 			   c->options.sndbuf,
+			   c->options.mark,
 			   sockflags);
 }
 
diff --git a/openvpn.8 b/openvpn.8
index dc76464..55a9b80 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -1371,6 +1371,12 @@ Set the TCP/UDP socket receive buffer size.
 Currently defaults to 65536 bytes.
 .\"*********************************************************
 .TP
+.B \-\-mark value
+Mark encrypted packets being sent with value. The mark value can be
+matched in policy routing and packetfilter rules. This option is
+only supported in Linux and does nothing on other operating systems.
+.\"*********************************************************
+.TP
 .B \-\-socket-flags flags...
 Apply the given flags to the OpenVPN transport socket.
 Currently, only
diff --git a/options.c b/options.c
index a6230de..d410782 100644
--- a/options.c
+++ b/options.c
@@ -280,6 +280,10 @@ static const char usage_message[] =
   "                  or --fragment max value, whichever is lower.\n"
   "--sndbuf size   : Set the TCP/UDP send buffer size.\n"
   "--rcvbuf size   : Set the TCP/UDP receive buffer size.\n"
+#ifdef TARGET_LINUX
+  "--mark value    : Mark encrypted packets being sent with value. The mark value\n"
+  "                  can be matched in policy routing and packetfilter rules.\n"
+#endif
   "--txqueuelen n  : Set the tun/tap TX queue length to n (Linux only).\n"
   "--mlock         : Disable Paging -- ensures key material and tunnel\n"
   "                  data will never be written to disk.\n"
@@ -1473,6 +1477,9 @@ show_settings (const struct options *o)
 #endif
   SHOW_INT (rcvbuf);
   SHOW_INT (sndbuf);
+#ifdef TARGET_LINUX
+  SHOW_INT (mark);
+#endif
   SHOW_INT (sockflags);
 
   SHOW_BOOL (fast_io);
@@ -4520,6 +4527,13 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_SOCKBUF);
       options->sndbuf = positive_atoi (p[1]);
     }
+  else if (streq (p[0], "mark") && p[1])
+    {
+#ifdef TARGET_LINUX
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->mark = atoi(p[1]);
+#endif
+    }
   else if (streq (p[0], "socket-flags"))
     {
       int j;
diff --git a/options.h b/options.h
index e723b66..d792872 100644
--- a/options.h
+++ b/options.h
@@ -342,6 +342,9 @@ struct options
   int rcvbuf;
   int sndbuf;
 
+  /* mark value */
+  int mark;
+
   /* socket flags */
   unsigned int sockflags;
 
diff --git a/socket.c b/socket.c
index 76c760c..a2f9511 100644
--- a/socket.c
+++ b/socket.c
@@ -779,6 +779,15 @@ socket_set_tcp_nodelay (int sd, int state)
 #endif
 }
 
+static void
+socket_set_mark (int sd, int mark)
+{
+#ifdef TARGET_LINUX
+  if (mark && setsockopt (sd, SOL_SOCKET, SO_MARK, &mark, sizeof (mark)) != 0)
+    msg (M_WARN, "NOTE: setsockopt SO_MARK=%d failed", mark);
+#endif
+}
+
 static bool
 socket_set_flags (int sd, unsigned int sockflags)
 {
@@ -1599,6 +1608,7 @@ link_socket_init_phase1 (struct link_socket *sock,
 			 int mtu_discover_type,
 			 int rcvbuf,
 			 int sndbuf,
+			 int mark,
 			 unsigned int sockflags)
 {
   ASSERT (sock);
@@ -1716,6 +1726,9 @@ link_socket_init_phase1 (struct link_socket *sock,
       /* set socket buffers based on --sndbuf and --rcvbuf options */
       socket_set_buffers (sock->sd, &sock->socket_buffer_sizes);
 
+      /* set socket to --mark packets with given value */
+      socket_set_mark (sock->sd, mark);
+
       resolve_bind_local (sock);
       resolve_remote (sock, 1, NULL, NULL);
     }
diff --git a/socket.h b/socket.h
index b385fb2..a9a29c5 100644
--- a/socket.h
+++ b/socket.h
@@ -324,6 +324,7 @@ link_socket_init_phase1 (struct link_socket *sock,
 			 int mtu_discover_type,
 			 int rcvbuf,
 			 int sndbuf,
+			 int mark,
 			 unsigned int sockflags);
 
 void link_socket_init_phase2 (struct link_socket *sock,
-- 
1.7.4.1


