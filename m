From: Gert Doering <gert@...1296...>
Date: Wed,  1 Feb 2023 14:15:18 +0000
Message-Id: <20230201141518.119157-1-gert@...1296...>
In-Reply-To: <20230130161730.110021-1-gert@...1296...>
References: <20230130161730.110021-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Get rid of unused 'bool tuntap_buffer'
 arguments.
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

overlapped_io_init() has a "bool tuntap_buffer" argument which is only
passed onwards to alloc_buf_sock_tun(), which does nothing with it.

Remove from both functions.

v2:
  move alloc_buf_sock_tun() to win32.c

v3:
  leave alloc_buf_sock_tun() where it is, and fix non-WIN32 call from socket.c

Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Arne Schwabe <arne@...1227...>
Message-Id: <20230130161730.110021-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26099.html
Signed-off-by: Gert Doering <gert@...1296...>
(cherry picked from commit bdc842d72e92995261bac3579120c94f93e4064a)
---
 src/openvpn/mtu.c    | 3 +--
 src/openvpn/mtu.h    | 3 +--
 src/openvpn/socket.c | 8 +++-----
 src/openvpn/tun.c    | 4 ++--
 src/openvpn/win32.c  | 5 ++---
 src/openvpn/win32.h  | 3 +--
 6 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 1d9ebe01..748a1cf1 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -42,8 +42,7 @@
 /* allocate a buffer for socket or tun layer */
 void
 alloc_buf_sock_tun(struct buffer *buf,
-                   const struct frame *frame,
-                   const bool tuntap_buffer)
+                   const struct frame *frame)
 {
     /* allocate buffer for overlapped I/O */
     *buf = alloc_buf(BUF_SIZE(frame));
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 0ff4f7bf..65236508 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -265,8 +265,7 @@ calc_packet_id_size_dc(const struct options *options,
  * allocate a buffer for socket or tun layer
  */
 void alloc_buf_sock_tun(struct buffer *buf,
-                        const struct frame *frame,
-                        const bool tuntap_buffer);
+                        const struct frame *frame);
 
 /*
  * EXTENDED_SOCKET_ERROR_CAPABILITY functions -- print extra error info
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index a883ac4a..42d95339 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1623,8 +1623,8 @@ static void
 socket_frame_init(const struct frame *frame, struct link_socket *sock)
 {
 #ifdef _WIN32
-    overlapped_io_init(&sock->reads, frame, FALSE, false);
-    overlapped_io_init(&sock->writes, frame, TRUE, false);
+    overlapped_io_init(&sock->reads, frame, FALSE);
+    overlapped_io_init(&sock->writes, frame, TRUE);
     sock->rw_handle.read = sock->reads.overlapped.hEvent;
     sock->rw_handle.write = sock->writes.overlapped.hEvent;
 #endif
@@ -1637,9 +1637,7 @@ socket_frame_init(const struct frame *frame, struct link_socket *sock)
                         sock->sockflags,
                         sock->info.proto);
 #else
-        alloc_buf_sock_tun(&sock->stream_buf_data,
-                           frame,
-                           false);
+        alloc_buf_sock_tun(&sock->stream_buf_data, frame);
 
         stream_buf_init(&sock->stream_buf,
                         &sock->stream_buf_data,
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 01c85f9f..20f80798 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -898,8 +898,8 @@ init_tun_post(struct tuntap *tt,
         return;
     }
 
-    overlapped_io_init(&tt->reads, frame, FALSE, true);
-    overlapped_io_init(&tt->writes, frame, TRUE, true);
+    overlapped_io_init(&tt->reads, frame, FALSE);
+    overlapped_io_init(&tt->writes, frame, TRUE);
     tt->adapter_index = TUN_ADAPTER_INDEX_INVALID;
 
     if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 44176936..8cdfec0e 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -173,8 +173,7 @@ init_security_attributes_allow_all(struct security_attributes *obj)
 void
 overlapped_io_init(struct overlapped_io *o,
                    const struct frame *frame,
-                   BOOL event_state,
-                   bool tuntap_buffer)  /* if true: tuntap buffer, if false: socket buffer */
+                   BOOL event_state)
 {
     CLEAR(*o);
 
@@ -186,7 +185,7 @@ overlapped_io_init(struct overlapped_io *o,
     }
 
     /* allocate buffer for overlapped I/O */
-    alloc_buf_sock_tun(&o->buf_init, frame, tuntap_buffer);
+    alloc_buf_sock_tun(&o->buf_init, frame);
 }
 
 void
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index a1a45503..72ffb012 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -217,8 +217,7 @@ struct overlapped_io {
 
 void overlapped_io_init(struct overlapped_io *o,
                         const struct frame *frame,
-                        BOOL event_state,
-                        bool tuntap_buffer);
+                        BOOL event_state);
 
 void overlapped_io_close(struct overlapped_io *o);
 
-- 
2.34.1


