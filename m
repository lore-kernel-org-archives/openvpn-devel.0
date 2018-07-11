From: Antonio Quartulli <a@...2181...>
Date: Thu, 12 Jul 2018 00:59:18 +0800
Message-Id: <20180711165918.12762-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] socket: make socket_* functions static
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
Cc: Antonio Quartulli <a@...2181...>

stream_buf_init(), stream_buf_close() and stream_buf_added()
are only used within socket.c, therefore there is noneed to
have them declared in socket.h.

Make them static and remove useless declarations.
This change required some re-ordering of the functions to
ensure they were defined before being used, however, no
this is just a copy/paste and no function change has been
introduced.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/socket.c | 362 +++++++++++++++++++++----------------------
 src/openvpn/socket.h |  15 --
 2 files changed, 181 insertions(+), 196 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 211e7441..2a62a49b 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1491,6 +1491,187 @@ done:
     gc_free(&gc);
 }
 
+/*
+ * Stream buffer functions, used to packetize a TCP
+ * stream connection.
+ */
+
+static inline void
+stream_buf_reset(struct stream_buf *sb)
+{
+    dmsg(D_STREAM_DEBUG, "STREAM: RESET");
+    sb->residual_fully_formed = false;
+    sb->buf = sb->buf_init;
+    buf_reset(&sb->next);
+    sb->len = -1;
+}
+
+static void
+stream_buf_init(struct stream_buf *sb,
+                struct buffer *buf,
+                const unsigned int sockflags,
+                const int proto)
+{
+    sb->buf_init = *buf;
+    sb->maxlen = sb->buf_init.len;
+    sb->buf_init.len = 0;
+    sb->residual = alloc_buf(sb->maxlen);
+    sb->error = false;
+#if PORT_SHARE
+    sb->port_share_state = ((sockflags & SF_PORT_SHARE) && (proto == PROTO_TCP_SERVER))
+                           ? PS_ENABLED
+                           : PS_DISABLED;
+#endif
+    stream_buf_reset(sb);
+
+    dmsg(D_STREAM_DEBUG, "STREAM: INIT maxlen=%d", sb->maxlen);
+}
+
+static void
+stream_buf_close(struct stream_buf *sb)
+{
+    free_buf(&sb->residual);
+}
+
+static inline void
+stream_buf_set_next(struct stream_buf *sb)
+{
+    /* set up 'next' for next i/o read */
+    sb->next = sb->buf;
+    sb->next.offset = sb->buf.offset + sb->buf.len;
+    sb->next.len = (sb->len >= 0 ? sb->len : sb->maxlen) - sb->buf.len;
+    dmsg(D_STREAM_DEBUG, "STREAM: SET NEXT, buf=[%d,%d] next=[%d,%d] len=%d maxlen=%d",
+         sb->buf.offset, sb->buf.len,
+         sb->next.offset, sb->next.len,
+         sb->len, sb->maxlen);
+    ASSERT(sb->next.len > 0);
+    ASSERT(buf_safe(&sb->buf, sb->next.len));
+}
+
+static inline void
+stream_buf_get_final(struct stream_buf *sb, struct buffer *buf)
+{
+    dmsg(D_STREAM_DEBUG, "STREAM: GET FINAL len=%d",
+         buf_defined(&sb->buf) ? sb->buf.len : -1);
+    ASSERT(buf_defined(&sb->buf));
+    *buf = sb->buf;
+}
+
+static inline void
+stream_buf_get_next(struct stream_buf *sb, struct buffer *buf)
+{
+    dmsg(D_STREAM_DEBUG, "STREAM: GET NEXT len=%d",
+         buf_defined(&sb->next) ? sb->next.len : -1);
+    ASSERT(buf_defined(&sb->next));
+    *buf = sb->next;
+}
+
+static bool
+stream_buf_added(struct stream_buf *sb,
+                 int length_added)
+{
+    dmsg(D_STREAM_DEBUG, "STREAM: ADD length_added=%d", length_added);
+    if (length_added > 0)
+    {
+        sb->buf.len += length_added;
+    }
+
+    /* if length unknown, see if we can get the length prefix from
+     * the head of the buffer */
+    if (sb->len < 0 && sb->buf.len >= (int) sizeof(packet_size_type))
+    {
+        packet_size_type net_size;
+
+#if PORT_SHARE
+        if (sb->port_share_state == PS_ENABLED)
+        {
+            if (!is_openvpn_protocol(&sb->buf))
+            {
+                msg(D_STREAM_ERRORS, "Non-OpenVPN client protocol detected");
+                sb->port_share_state = PS_FOREIGN;
+                sb->error = true;
+                return false;
+            }
+            else
+            {
+                sb->port_share_state = PS_DISABLED;
+            }
+        }
+#endif
+
+        ASSERT(buf_read(&sb->buf, &net_size, sizeof(net_size)));
+        sb->len = ntohps(net_size);
+
+        if (sb->len < 1 || sb->len > sb->maxlen)
+        {
+            msg(M_WARN, "WARNING: Bad encapsulated packet length from peer (%d), which must be > 0 and <= %d -- please ensure that --tun-mtu or --link-mtu is equal on both peers -- this condition could also indicate a possible active attack on the TCP link -- [Attempting restart...]", sb->len, sb->maxlen);
+            stream_buf_reset(sb);
+            sb->error = true;
+            return false;
+        }
+    }
+
+    /* is our incoming packet fully read? */
+    if (sb->len > 0 && sb->buf.len >= sb->len)
+    {
+        /* save any residual data that's part of the next packet */
+        ASSERT(buf_init(&sb->residual, 0));
+        if (sb->buf.len > sb->len)
+        {
+            ASSERT(buf_copy_excess(&sb->residual, &sb->buf, sb->len));
+        }
+        dmsg(D_STREAM_DEBUG, "STREAM: ADD returned TRUE, buf_len=%d, residual_len=%d",
+             BLEN(&sb->buf),
+             BLEN(&sb->residual));
+        return true;
+    }
+    else
+    {
+        dmsg(D_STREAM_DEBUG, "STREAM: ADD returned FALSE (have=%d need=%d)", sb->buf.len, sb->len);
+        stream_buf_set_next(sb);
+        return false;
+    }
+}
+
+bool
+stream_buf_read_setup_dowork(struct link_socket *sock)
+{
+    if (sock->stream_buf.residual.len && !sock->stream_buf.residual_fully_formed)
+    {
+        ASSERT(buf_copy(&sock->stream_buf.buf, &sock->stream_buf.residual));
+        ASSERT(buf_init(&sock->stream_buf.residual, 0));
+        sock->stream_buf.residual_fully_formed = stream_buf_added(&sock->stream_buf, 0);
+        dmsg(D_STREAM_DEBUG, "STREAM: RESIDUAL FULLY FORMED [%s], len=%d",
+             sock->stream_buf.residual_fully_formed ? "YES" : "NO",
+             sock->stream_buf.residual.len);
+    }
+
+    if (!sock->stream_buf.residual_fully_formed)
+    {
+        stream_buf_set_next(&sock->stream_buf);
+    }
+    return !sock->stream_buf.residual_fully_formed;
+}
+
+/*
+ * The listen event is a special event whose sole purpose is
+ * to tell us that there's a new incoming connection on a
+ * TCP socket, for use in server mode.
+ */
+event_t
+socket_listen_event_handle(struct link_socket *s)
+{
+#ifdef _WIN32
+    if (!defined_net_event_win32(&s->listen_handle))
+    {
+        init_net_event_win32(&s->listen_handle, FD_ACCEPT, s->sd, 0);
+    }
+    return &s->listen_handle;
+#else  /* ifdef _WIN32 */
+    return s->sd;
+#endif
+}
+
 /* For stream protocols, allocate a buffer to build up packet.
  * Called after frame has been finalized. */
 
@@ -2485,187 +2666,6 @@ socket_stat(const struct link_socket *s, unsigned int rwflags, struct gc_arena *
     return BSTR(&out);
 }
 
-/*
- * Stream buffer functions, used to packetize a TCP
- * stream connection.
- */
-
-static inline void
-stream_buf_reset(struct stream_buf *sb)
-{
-    dmsg(D_STREAM_DEBUG, "STREAM: RESET");
-    sb->residual_fully_formed = false;
-    sb->buf = sb->buf_init;
-    buf_reset(&sb->next);
-    sb->len = -1;
-}
-
-void
-stream_buf_init(struct stream_buf *sb,
-                struct buffer *buf,
-                const unsigned int sockflags,
-                const int proto)
-{
-    sb->buf_init = *buf;
-    sb->maxlen = sb->buf_init.len;
-    sb->buf_init.len = 0;
-    sb->residual = alloc_buf(sb->maxlen);
-    sb->error = false;
-#if PORT_SHARE
-    sb->port_share_state = ((sockflags & SF_PORT_SHARE) && (proto == PROTO_TCP_SERVER))
-                           ? PS_ENABLED
-                           : PS_DISABLED;
-#endif
-    stream_buf_reset(sb);
-
-    dmsg(D_STREAM_DEBUG, "STREAM: INIT maxlen=%d", sb->maxlen);
-}
-
-static inline void
-stream_buf_set_next(struct stream_buf *sb)
-{
-    /* set up 'next' for next i/o read */
-    sb->next = sb->buf;
-    sb->next.offset = sb->buf.offset + sb->buf.len;
-    sb->next.len = (sb->len >= 0 ? sb->len : sb->maxlen) - sb->buf.len;
-    dmsg(D_STREAM_DEBUG, "STREAM: SET NEXT, buf=[%d,%d] next=[%d,%d] len=%d maxlen=%d",
-         sb->buf.offset, sb->buf.len,
-         sb->next.offset, sb->next.len,
-         sb->len, sb->maxlen);
-    ASSERT(sb->next.len > 0);
-    ASSERT(buf_safe(&sb->buf, sb->next.len));
-}
-
-static inline void
-stream_buf_get_final(struct stream_buf *sb, struct buffer *buf)
-{
-    dmsg(D_STREAM_DEBUG, "STREAM: GET FINAL len=%d",
-         buf_defined(&sb->buf) ? sb->buf.len : -1);
-    ASSERT(buf_defined(&sb->buf));
-    *buf = sb->buf;
-}
-
-static inline void
-stream_buf_get_next(struct stream_buf *sb, struct buffer *buf)
-{
-    dmsg(D_STREAM_DEBUG, "STREAM: GET NEXT len=%d",
-         buf_defined(&sb->next) ? sb->next.len : -1);
-    ASSERT(buf_defined(&sb->next));
-    *buf = sb->next;
-}
-
-bool
-stream_buf_read_setup_dowork(struct link_socket *sock)
-{
-    if (sock->stream_buf.residual.len && !sock->stream_buf.residual_fully_formed)
-    {
-        ASSERT(buf_copy(&sock->stream_buf.buf, &sock->stream_buf.residual));
-        ASSERT(buf_init(&sock->stream_buf.residual, 0));
-        sock->stream_buf.residual_fully_formed = stream_buf_added(&sock->stream_buf, 0);
-        dmsg(D_STREAM_DEBUG, "STREAM: RESIDUAL FULLY FORMED [%s], len=%d",
-             sock->stream_buf.residual_fully_formed ? "YES" : "NO",
-             sock->stream_buf.residual.len);
-    }
-
-    if (!sock->stream_buf.residual_fully_formed)
-    {
-        stream_buf_set_next(&sock->stream_buf);
-    }
-    return !sock->stream_buf.residual_fully_formed;
-}
-
-bool
-stream_buf_added(struct stream_buf *sb,
-                 int length_added)
-{
-    dmsg(D_STREAM_DEBUG, "STREAM: ADD length_added=%d", length_added);
-    if (length_added > 0)
-    {
-        sb->buf.len += length_added;
-    }
-
-    /* if length unknown, see if we can get the length prefix from
-     * the head of the buffer */
-    if (sb->len < 0 && sb->buf.len >= (int) sizeof(packet_size_type))
-    {
-        packet_size_type net_size;
-
-#if PORT_SHARE
-        if (sb->port_share_state == PS_ENABLED)
-        {
-            if (!is_openvpn_protocol(&sb->buf))
-            {
-                msg(D_STREAM_ERRORS, "Non-OpenVPN client protocol detected");
-                sb->port_share_state = PS_FOREIGN;
-                sb->error = true;
-                return false;
-            }
-            else
-            {
-                sb->port_share_state = PS_DISABLED;
-            }
-        }
-#endif
-
-        ASSERT(buf_read(&sb->buf, &net_size, sizeof(net_size)));
-        sb->len = ntohps(net_size);
-
-        if (sb->len < 1 || sb->len > sb->maxlen)
-        {
-            msg(M_WARN, "WARNING: Bad encapsulated packet length from peer (%d), which must be > 0 and <= %d -- please ensure that --tun-mtu or --link-mtu is equal on both peers -- this condition could also indicate a possible active attack on the TCP link -- [Attempting restart...]", sb->len, sb->maxlen);
-            stream_buf_reset(sb);
-            sb->error = true;
-            return false;
-        }
-    }
-
-    /* is our incoming packet fully read? */
-    if (sb->len > 0 && sb->buf.len >= sb->len)
-    {
-        /* save any residual data that's part of the next packet */
-        ASSERT(buf_init(&sb->residual, 0));
-        if (sb->buf.len > sb->len)
-        {
-            ASSERT(buf_copy_excess(&sb->residual, &sb->buf, sb->len));
-        }
-        dmsg(D_STREAM_DEBUG, "STREAM: ADD returned TRUE, buf_len=%d, residual_len=%d",
-             BLEN(&sb->buf),
-             BLEN(&sb->residual));
-        return true;
-    }
-    else
-    {
-        dmsg(D_STREAM_DEBUG, "STREAM: ADD returned FALSE (have=%d need=%d)", sb->buf.len, sb->len);
-        stream_buf_set_next(sb);
-        return false;
-    }
-}
-
-void
-stream_buf_close(struct stream_buf *sb)
-{
-    free_buf(&sb->residual);
-}
-
-/*
- * The listen event is a special event whose sole purpose is
- * to tell us that there's a new incoming connection on a
- * TCP socket, for use in server mode.
- */
-event_t
-socket_listen_event_handle(struct link_socket *s)
-{
-#ifdef _WIN32
-    if (!defined_net_event_win32(&s->listen_handle))
-    {
-        init_net_event_win32(&s->listen_handle, FD_ACCEPT, s->sd, 0);
-    }
-    return &s->listen_handle;
-#else  /* ifdef _WIN32 */
-    return s->sd;
-#endif
-}
-
 /*
  * Format IP addresses in ascii
  */
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 479d1150..7329a518 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -994,21 +994,6 @@ link_socket_set_outgoing_addr(const struct buffer *buf,
     }
 }
 
-/*
- * Stream buffer handling -- stream_buf is a helper class
- * to assist in the packetization of stream transport protocols
- * such as TCP.
- */
-
-void stream_buf_init(struct stream_buf *sb,
-                     struct buffer *buf,
-                     const unsigned int sockflags,
-                     const int proto);
-
-void stream_buf_close(struct stream_buf *sb);
-
-bool stream_buf_added(struct stream_buf *sb, int length_added);
-
 static inline bool
 stream_buf_read_setup(struct link_socket *sock)
 {
-- 
2.18.0


