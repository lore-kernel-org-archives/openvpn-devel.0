From: Maximilian Wilhelm <max@...1047...>
Date: Mon, 29 Jun 2020 12:49:07 +0200
Message-Id: <1593427748-29801-2-git-send-email-max@...1047...>
In-Reply-To: <1593427748-29801-1-git-send-email-max@...1047...>
References: <1593197385-30618-2-git-send-email-max@...1047...>
 <1593427748-29801-1-git-send-email-max@...1047...>
Subject: [Openvpn-devel] [PATCH v2 1/2] Add --bind-dev option.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Maximilian Wilhelm <max@...2564...>

From: Maximilian Wilhelm <max@...2564...>

  This options allows the user to specify a network device the OpenVPN process
  should use when making a connection or binding to an address. This translates
  in setting the SO_BINDTODEVICE option to the corresponding socket (on Linux).

  When for example using VRFs on Linux [0] this allows making connections using
  the non-default VRF and having the tun/tap interface in the default VRF.

  Thanks to David Ahern (Cumulus Networks) for insights on this.

 [0] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/networking/vrf.txt

Signed-off-by: Maximilian Wilhelm <max@...2564...>
---
 src/openvpn/init.c    |  1 +
 src/openvpn/options.c | 10 ++++++++++
 src/openvpn/options.h |  1 +
 src/openvpn/socket.c  | 14 ++++++++++++++
 src/openvpn/socket.h  |  2 ++
 5 files changed, 28 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2af25c1..dd1747f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3445,6 +3445,7 @@ do_init_socket_1(struct context *c, const int mode)
                             c->options.rcvbuf,
                             c->options.sndbuf,
                             c->options.mark,
+                            c->options.bind_dev,
                             &c->c2.server_poll_interval,
                             sockflags);
 }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9580d1d..34e2bfd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -294,6 +294,9 @@ static const char usage_message[] =
 #if defined(TARGET_LINUX) && HAVE_DECL_SO_MARK
     "--mark value    : Mark encrypted packets being sent with value. The mark value\n"
     "                  can be matched in policy routing and packetfilter rules.\n"
+    "--bind-dev dev  : Bind to the given device when making connection to a peer or\n"
+    "                  listening for connections. This allows sending encrypted packets\n"
+    "                  via a VRF present on the system.\n"
 #endif
     "--txqueuelen n  : Set the tun/tap TX queue length to n (Linux only).\n"
 #ifdef ENABLE_MEMSTATS
@@ -6084,6 +6087,13 @@ add_option(struct options *options,
             }
         }
     }
+#ifdef TARGET_LINUX
+    else if (streq (p[0], "bind-dev") && p[1])
+    {
+        VERIFY_PERMISSION (OPT_P_SOCKFLAGS);
+        options->bind_dev = p[1];
+    }
+#endif
     else if (streq(p[0], "txqueuelen") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 375a4fc..c83a46a 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -352,6 +352,7 @@ struct options
 
     /* mark value */
     int mark;
+    char *bind_dev;
 
     /* socket flags */
     unsigned int sockflags;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index f2fb54d..61463bc 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1138,6 +1138,18 @@ create_socket(struct link_socket *sock, struct addrinfo *addr)
     /* set socket to --mark packets with given value */
     socket_set_mark(sock->sd, sock->mark);
 
+#if defined(TARGET_LINUX)
+    if (sock->bind_dev)
+    {
+        msg (M_INFO, "Using bind-dev %s", sock->bind_dev);
+        if (setsockopt (sock->sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_dev, strlen (sock->bind_dev) + 1) != 0)
+        {
+            msg(M_WARN|M_ERRNO, "WARN: setsockopt SO_BINDTODEVICE=%s failed", sock->bind_dev);
+        }
+
+    }
+#endif
+
     bind_local(sock, addr->ai_family);
 }
 
@@ -1880,6 +1892,7 @@ link_socket_init_phase1(struct link_socket *sock,
                         int rcvbuf,
                         int sndbuf,
                         int mark,
+                        const char *bind_dev,
                         struct event_timeout *server_poll_timeout,
                         unsigned int sockflags)
 {
@@ -1906,6 +1919,7 @@ link_socket_init_phase1(struct link_socket *sock,
 
     sock->sockflags = sockflags;
     sock->mark = mark;
+    sock->bind_dev = bind_dev;
 
     sock->info.proto = proto;
     sock->info.af = af;
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 38e5138..8db9e8b 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -212,6 +212,7 @@ struct link_socket
 #define SF_GETADDRINFO_DGRAM (1<<4)
     unsigned int sockflags;
     int mark;
+    const char *bind_dev;
 
     /* for stream sockets */
     struct stream_buf stream_buf;
@@ -326,6 +327,7 @@ link_socket_init_phase1(struct link_socket *sock,
                         int rcvbuf,
                         int sndbuf,
                         int mark,
+                        const char *bind_dev,
                         struct event_timeout *server_poll_timeout,
                         unsigned int sockflags);
 /* Reenable uncrustify *INDENT-ON* */
-- 
2.1.4


