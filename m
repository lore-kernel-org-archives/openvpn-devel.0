From: Gert Doering <gert@...1296...>
Date: Mon, 16 Feb 2026 17:22:31 +0100
Message-ID: <20260216162236.22304-1-gert@...1296...>
In-Reply-To: <gerrit.1768830991000.Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc@...2715...>
References: <gerrit.1768830991000.Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] Merge stream_buf_get_next and
 stream_buf_set_next
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

From: Arne Schwabe <arne@...1227...>

The stream_buf_set_next prepares a buffer in the stream_buf
structure that will be retrieved by stream_buf_get the next
time it is used.

This temporary copy of the buffer is unnecessary as the buffer
next can also be constructed on the fly.

This also fixes a rare crash when read buffer are not initialised and
read is still signalled as the initialisation of next will now happen whenever
it is required.

This assertion happens when we do not expect a read event from the socket and
then in link_socket_read_tcp the function stream_buf_get_next can trigger
an assert on ASSERT(buf_defined(&sb->next));

To avoid this weird corner case, just always initialise the read buffer
whether or not we expect a read to occur.

This also adds documentation about the methods and field associated with
the stream_buf structure.

Reproducing this bug requires very special circumstances. The reproduction is
   openvpn --cert server-secp384r1.crt  --key server-secp384r1.key \
   --dev ml-tan --dev-type tap --tun-mtu 1400 --config ~/fp --topology subnet \
   --port 2201 --verb 3  --mode server  --tls-server --proto tcp6-server
   --ifconfig 10.0.0.1 255.255.255.0

as the server side and

  openvpn --client --proto tcp --remote poseidon --port 2201 --dev tap

The client side must be on Linux. Other platforms do not reproduce this
bug.

Note that the client will not configure any IP or IPv6 on the interface
and will also not bring up the interface. The server must also send at least
one real data packet to the client (no keepalive ping). Just having the
interface up normally produces enough traffic.

Now forcefully reset the TCP connection. E.g. by executing on the server

    sudo ss --kill sport 2201

This will now trigger the assertion. This happens since OpenVPN waits
forever to get a write back from the poll from the tun/tap device but
this never happens since the device is not up.

As long as we do not get back the tun device for writing, we also do
not put the socket back into the EVENT_READ state. And this also means
that code to initialise the read buffer (stream_buf_set_next) is never
run.

But the reset on the TCP socket triggers the TCP socket to be available
for read, even if it is just for a read of 0 bytes to indicate the reset.
So the function link_socket_read_tcp will run into the assert.

Change-Id: Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1477
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1477
This mail reflects revision 7 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index c463041..bdb98b9 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -44,9 +44,7 @@
 bool
 sockets_read_residual(const struct context *c)
 {
-    int i;
-
-    for (i = 0; i < c->c1.link_sockets_num; i++)
+    for (int i = 0; i < c->c1.link_sockets_num; i++)
     {
         if (c->c2.link_sockets[i]->stream_buf.residual_fully_formed)
         {
@@ -2053,13 +2051,19 @@
  * stream connection.
  */
 
+/**
+ * resets the stream buffer to be set up for the next round of
+ * reassembling a packet
+ *
+ * But still leaves the current packet in \c sb->buf to be potentially
+ * read.
+ */
 static inline void
 stream_buf_reset(struct stream_buf *sb)
 {
     dmsg(D_STREAM_DEBUG, "STREAM: RESET");
     sb->residual_fully_formed = false;
     sb->buf = sb->buf_init;
-    buf_reset(&sb->next);
     sb->len = -1;
 }
 
@@ -2081,19 +2085,35 @@
     dmsg(D_STREAM_DEBUG, "STREAM: INIT maxlen=%d", sb->maxlen);
 }
 
-static inline void
-stream_buf_set_next(struct stream_buf *sb)
+/**
+ * Return a buffer that is backed by the same backend as sb->buf that
+ * determines where the next read should be done by also having the
+ * right offset into \c sb->buf.
+ * @param sb the stream buffer from which to construct the next buffer
+ */
+static inline struct buffer
+stream_buf_get_next(struct stream_buf *sb)
 {
     /* set up 'next' for next i/o read */
-    sb->next = sb->buf;
-    sb->next.offset = sb->buf.offset + sb->buf.len;
-    sb->next.len = (sb->len >= 0 ? sb->len : sb->maxlen) - sb->buf.len;
-    dmsg(D_STREAM_DEBUG, "STREAM: SET NEXT, buf=[%d,%d] next=[%d,%d] len=%d maxlen=%d",
-         sb->buf.offset, sb->buf.len, sb->next.offset, sb->next.len, sb->len, sb->maxlen);
-    ASSERT(sb->next.len > 0);
-    ASSERT(buf_safe(&sb->buf, sb->next.len));
+    struct buffer next;
+    next = sb->buf;
+    next.offset = sb->buf.offset + sb->buf.len;
+    next.len = (sb->len >= 0 ? sb->len : sb->maxlen) - sb->buf.len;
+    dmsg(D_STREAM_DEBUG, "STREAM: GET NEXT, buf=[%d,%d] next=[%d,%d] len=%d maxlen=%d",
+         sb->buf.offset, sb->buf.len, next.offset, next.len, sb->len, sb->maxlen);
+    ASSERT(next.len > 0);
+    ASSERT(buf_safe(&sb->buf, next.len));
+    return next;
 }
 
+/**
+ * Sets the parameter buf to the current buffer of \c sb->buf.
+ * This function assumes that caller already checked if the packet in \c sb->buf
+ * is fully assembled.
+ *
+ * @param sb    stream buffer to operate on
+ * @param buf   buffer to point to the contents of buf
+ */
 static inline void
 stream_buf_get_final(struct stream_buf *sb, struct buffer *buf)
 {
@@ -2102,14 +2122,6 @@
     *buf = sb->buf;
 }
 
-static inline void
-stream_buf_get_next(struct stream_buf *sb, struct buffer *buf)
-{
-    dmsg(D_STREAM_DEBUG, "STREAM: GET NEXT len=%d", buf_defined(&sb->next) ? sb->next.len : -1);
-    ASSERT(buf_defined(&sb->next));
-    *buf = sb->next;
-}
-
 bool
 stream_buf_read_setup_dowork(struct stream_buf *sb)
 {
@@ -2122,13 +2134,30 @@
              sb->residual_fully_formed ? "YES" : "NO", sb->residual.len);
     }
 
-    if (!sb->residual_fully_formed)
-    {
-        stream_buf_set_next(sb);
-    }
     return !sb->residual_fully_formed;
 }
 
+/**
+ * This will determine if \c sb->buf contains a full packet. It will also
+ * move anything in \c sb->buf beyond a full packet to \c sb->residual.
+ *
+ * The first time the function is called with a valid buffer and port sharing
+ * is enabled, the function will also determine if the buffer contains
+ * OpenVPN protocol data and store the result in \c sb->port_share_state.
+ *
+ * If a packet outside the allowed range is detected, the error state
+ * on \c sb is set.
+ *
+ * Since the buffer in \c sb->buf is modified from the outside (via
+ * \c stream_buf_get_next) the parameter \p length_added needs to be set
+ * to the amount of bytes that have been written to this buffer. If the
+ * buffer was not modified but should still be analysed and potentially
+ * split to \c sb->residual, the parameter \p length_added should be 0.
+ *
+ * @param sb the stream buffer
+ * @param length_added The length that has been added to \c sb->buf
+ * @return true if \c sb->buf contains fully reassembled packet
+ */
 static bool
 stream_buf_added(struct stream_buf *sb, int length_added)
 {
@@ -2191,7 +2220,6 @@
     else
     {
         dmsg(D_STREAM_DEBUG, "STREAM: ADD returned FALSE (have=%d need=%d)", sb->buf.len, sb->len);
-        stream_buf_set_next(sb);
         return false;
     }
 }
@@ -2261,8 +2289,7 @@
         sockethandle_t sh = { .s = sock->sd };
         len = sockethandle_finalize(sh, &sock->reads, buf, NULL);
 #else
-        struct buffer frag;
-        stream_buf_get_next(&sock->stream_buf, &frag);
+        struct buffer frag = stream_buf_get_next(&sock->stream_buf);
         len = recv(sock->sd, BPTR(&frag), BLEN(&frag), MSG_NOSIGNAL);
 #endif
 
@@ -2538,7 +2565,7 @@
         }
         else if (proto_is_tcp(sock->info.proto))
         {
-            stream_buf_get_next(&sock->stream_buf, &sock->reads.buf);
+            sock->reads.buf = stream_buf_get_next(&sock->stream_buf);
         }
         else
         {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 3f46dc6..ebaf776 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -95,23 +95,41 @@
     int mtu_changed; /* Set to true when mtu value is changed */
 };
 
-/*
- * Used to extract packets encapsulated in streams into a buffer,
- * in this case IP packets embedded in a TCP stream.
+/**
+ * struct used to extract packets encapsulated in streams into a buffer,
+ * in this case OpenVPN packets (data or control) embedded in a TCP stream.
+ *
+ * This struct is used to packetise the TCP stream into the
+ * OpenVPN packet. Each OpenVPN packet has a two-byte header determining
+ * the length of the packet.
  */
 struct stream_buf
 {
+    /* Buffer to hold the initial buffer that will be used to reset buf */
     struct buffer buf_init;
+
+    /** buffer holding the excess bytes that are not part of the
+     *  packet. */
     struct buffer residual;
+
+    /** Maximum length of a packet that we accept */
     int maxlen;
+
+    /** The buffer in buf contains a full packet without a header. Any
+     * extra data is in residual */
     bool residual_fully_formed;
 
+    /** Holds the data of the current packet. This might be a partial packet */
     struct buffer buf;
-    struct buffer next;
-    int len;    /* -1 if not yet known */
 
-    bool error; /* if true, fatal TCP error has occurred,
-                 *  requiring that connection be restarted */
+    /** -1 if not yet known. Otherwise holds the length of the
+     *   packet. If >= 0, buf is already moved past the initial
+     *  size header */
+    int len;
+
+    /** if true, a fatal TCP error has occurred,
+     *  requiring that connection be restarted */
+    bool error;
 #if PORT_SHARE
 #define PS_DISABLED 0
 #define PS_ENABLED  1

