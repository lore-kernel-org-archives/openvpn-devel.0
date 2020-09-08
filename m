From: Gert Doering <gert@...1296...>
Date: Tue,  8 Sep 2020 12:51:30 +0200
Message-Id: <20200908105130.24171-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix error detection / abort in --inetd
 corner case.
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

Calling "openvpn --inetd" from the CLI (= no socket on stdin) will
lead to endless looping in the accept(4) loop.

Instead of cluttering that function further, detect failure to call
getsockame() in phase2_inetd() already, and trigger a M_FATAL abort
on "errno == ENOTSOCK" ("The argument s is a file, not a socket").

While at it, uncrustify the --bind-dev code (whitespace only).

Trac: #350

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/socket.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index c486327b..76bdbfc5 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1141,8 +1141,8 @@ create_socket(struct link_socket *sock, struct addrinfo *addr)
 #if defined(TARGET_LINUX)
     if (sock->bind_dev)
     {
-        msg (M_INFO, "Using bind-dev %s", sock->bind_dev);
-        if (setsockopt (sock->sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_dev, strlen (sock->bind_dev) + 1) != 0)
+        msg(M_INFO, "Using bind-dev %s", sock->bind_dev);
+        if (setsockopt(sock->sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_dev, strlen(sock->bind_dev) + 1) != 0)
         {
             msg(M_WARN|M_ERRNO, "WARN: setsockopt SO_BINDTODEVICE=%s failed", sock->bind_dev);
         }
@@ -2030,8 +2030,14 @@ phase2_inetd(struct link_socket *sock, const struct frame *frame,
             }
             else
             {
-                msg(M_WARN, "inetd(%s): getsockname(%d) failed, using AF_INET",
+                int saved_errno = errno;
+                msg(M_WARN|M_ERRNO, "inetd(%s): getsockname(%d) failed, using AF_INET",
                     proto2ascii(sock->info.proto, sock->info.af, false), (int)sock->sd);
+                /* if not called with a socket on stdin, --inetd cannot work */
+                if (saved_errno == ENOTSOCK)
+                {
+                    msg(M_FATAL, "ERROR: socket required for --inetd operation");
+                }
             }
         }
 #else  /* ifdef HAVE_GETSOCKNAME */
@@ -2047,7 +2053,6 @@ phase2_inetd(struct link_socket *sock, const struct frame *frame,
                                  false,
                                  sock->inetd == INETD_NOWAIT,
                                  signal_received);
-
     }
     ASSERT(!remote_changed);
 }
-- 
2.26.2


