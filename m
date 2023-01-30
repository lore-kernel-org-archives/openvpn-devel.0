From: Gert Doering <gert@...1296...>
Date: Mon, 30 Jan 2023 16:17:30 +0000
Message-Id: <20230130161730.110021-1-gert@...1296...>
In-Reply-To: <20230130144112.109560-1-gert@...1296...>
References: <20230130144112.109560-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Get rid of unused 'bool tuntap_buffer'
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

While at it, move alloc_buf_sock_tun() from mtu.c to win32.c and make
static.  It's only ever called from win32.c / overlapped_io_init().

v2:
  move alloc_buf_sock_tun() to win32.c

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/mtu.c    | 13 -------------
 src/openvpn/mtu.h    |  7 -------
 src/openvpn/socket.c |  4 ++--
 src/openvpn/tun.c    |  4 ++--
 src/openvpn/win32.c  | 17 ++++++++++++++---
 src/openvpn/win32.h  |  3 +--
 6 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 1d9ebe01..4b32daff 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -39,19 +39,6 @@
 
 #include "memdbg.h"
 
-/* allocate a buffer for socket or tun layer */
-void
-alloc_buf_sock_tun(struct buffer *buf,
-                   const struct frame *frame,
-                   const bool tuntap_buffer)
-{
-    /* allocate buffer for overlapped I/O */
-    *buf = alloc_buf(BUF_SIZE(frame));
-    ASSERT(buf_init(buf, frame->buf.headroom));
-    buf->len = frame->buf.payload_size;
-    ASSERT(buf_safe(buf, 0));
-}
-
 unsigned int
 calc_packet_id_size_dc(const struct options *options, const struct key_type *kt)
 {
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 0ff4f7bf..afd4ac53 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -261,13 +261,6 @@ unsigned int
 calc_packet_id_size_dc(const struct options *options,
                        const struct key_type *kt);
 
-/*
- * allocate a buffer for socket or tun layer
- */
-void alloc_buf_sock_tun(struct buffer *buf,
-                        const struct frame *frame,
-                        const bool tuntap_buffer);
-
 /*
  * EXTENDED_SOCKET_ERROR_CAPABILITY functions -- print extra error info
  * on socket errors, such as PMTU size.  As of 2003.05.11, only works
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index a883ac4a..2c75cb35 100644
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
index 44176936..9f0c119f 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -170,11 +170,22 @@ init_security_attributes_allow_all(struct security_attributes *obj)
     return true;
 }
 
+/* allocate a buffer for socket or tun layer */
+static void
+alloc_buf_sock_tun(struct buffer *buf,
+                   const struct frame *frame)
+{
+    /* allocate buffer for overlapped I/O */
+    *buf = alloc_buf(BUF_SIZE(frame));
+    ASSERT(buf_init(buf, frame->buf.headroom));
+    buf->len = frame->buf.payload_size;
+    ASSERT(buf_safe(buf, 0));
+}
+
 void
 overlapped_io_init(struct overlapped_io *o,
                    const struct frame *frame,
-                   BOOL event_state,
-                   bool tuntap_buffer)  /* if true: tuntap buffer, if false: socket buffer */
+                   BOOL event_state)
 {
     CLEAR(*o);
 
@@ -186,7 +197,7 @@ overlapped_io_init(struct overlapped_io *o,
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


