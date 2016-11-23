From: Gert Doering <gert@...1296...>
Date: Wed, 23 Nov 2016 11:20:18 +0100
Message-Id: <1479896418-16190-1-git-send-email-gert@...1296...>
In-Reply-To: <20161121091013.imxgfilt3byyqu7u@...30...>
References: <20161121091013.imxgfilt3byyqu7u@...30...>
Subject: [Openvpn-devel] [PATCH] Refactor setting close-on-exec for socket
	FDs
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

The existing code can leak socket FDs to the "--up" script, which is
not desired.  Brought up by Alberto Gonzalez Iniesta, based on debian
bug 367716.

Since different sockets get create at different times, just moving the
set_cloexec() to link_socket_init_phase1() is not good enough - so move
the call into create_socket_<family>(), so we will catch ALL socket
creations, no matter when or under which conditions they will be
created (SOCKS proxy socket, listening socket, ...).

--inetd gets an extra fd_cloexec() call, as socket FD is inherited.

URL: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=367716

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/socket.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index c233f2b..d9d95fe 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -771,6 +771,10 @@ create_socket_tcp (struct addrinfo* addrinfo)
   }
 #endif
 
+  /* set socket file descriptor to not pass across execs, so that
+     scripts don't have access to it */
+  set_cloexec (sd);
+
   return sd;
 }
 
@@ -815,6 +819,11 @@ create_socket_udp (struct addrinfo* addrinfo, const unsigned int flags)
         }
     }
 #endif
+
+  /* set socket file descriptor to not pass across execs, so that
+     scripts don't have access to it */
+  set_cloexec (sd);
+
   return sd;
 }
 
@@ -1617,6 +1626,7 @@ link_socket_init_phase1 (struct link_socket *sock,
       ASSERT (sock->info.proto != PROTO_TCP_CLIENT);
       ASSERT (socket_defined (inetd_socket_descriptor));
       sock->sd = inetd_socket_descriptor;
+      set_cloexec (sock->sd);		/* not created by create_socket*() */
     }
   else if (mode != LS_MODE_TCP_ACCEPT_FROM)
     {
@@ -1677,13 +1687,6 @@ phase2_set_socket_flags (struct link_socket* sock)
   /* set socket to non-blocking mode */
   set_nonblock (sock->sd);
 
-  /* set socket file descriptor to not pass across execs, so that
-     scripts don't have access to it */
-  set_cloexec (sock->sd);
-
-  if (socket_defined (sock->ctrl_sd))
-    set_cloexec (sock->ctrl_sd);
-
   /* set Path MTU discovery options on the socket */
   set_mtu_discover_type (sock->sd, sock->mtu_discover_type, sock->info.af);
 
@@ -3476,6 +3479,11 @@ create_socket_unix (void)
 
   if ((sd = socket (PF_UNIX, SOCK_STREAM, 0)) < 0)
     msg (M_ERR, "Cannot create unix domain socket");
+
+  /* set socket file descriptor to not pass across execs, so that
+     scripts don't have access to it */
+  set_cloexec (sd);
+
   return sd;
 }
 
-- 
2.7.3


