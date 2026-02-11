From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 11 Feb 2026 16:07:47 +0100
Message-ID: <20260211150747.113906-1-frank@...2641...>
In-Reply-To: <gerrit.1768930567000.I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3@...2715...>
References: <gerrit.1768930567000.I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Change stream_buf_read_setup_dowork
 parameter to struct steam_buf
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
Cc: Arne Schwabe <arne@...1227...>, Arne Schwabe <arne-openvpn@...1227...>

From: Arne Schwabe <arne@...1227...>

This methods only ever access sock->stream_buf so make the method
simpler by just having a parameter sb.

Change-Id: I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1483
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1483
This mail reflects revision 4 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 58ccda9..c463041 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2111,22 +2111,22 @@
 }
 
 bool
-stream_buf_read_setup_dowork(struct link_socket *sock)
+stream_buf_read_setup_dowork(struct stream_buf *sb)
 {
-    if (sock->stream_buf.residual.len && !sock->stream_buf.residual_fully_formed)
+    if (sb->residual.len && !sb->residual_fully_formed)
     {
-        ASSERT(buf_copy(&sock->stream_buf.buf, &sock->stream_buf.residual));
-        ASSERT(buf_init(&sock->stream_buf.residual, 0));
-        sock->stream_buf.residual_fully_formed = stream_buf_added(&sock->stream_buf, 0);
+        ASSERT(buf_copy(&sb->buf, &sb->residual));
+        ASSERT(buf_init(&sb->residual, 0));
+        sb->residual_fully_formed = stream_buf_added(sb, 0);
         dmsg(D_STREAM_DEBUG, "STREAM: RESIDUAL FULLY FORMED [%s], len=%d",
-             sock->stream_buf.residual_fully_formed ? "YES" : "NO", sock->stream_buf.residual.len);
+             sb->residual_fully_formed ? "YES" : "NO", sb->residual.len);
     }
 
-    if (!sock->stream_buf.residual_fully_formed)
+    if (!sb->residual_fully_formed)
     {
-        stream_buf_set_next(&sock->stream_buf);
+        stream_buf_set_next(sb);
     }
-    return !sock->stream_buf.residual_fully_formed;
+    return !sb->residual_fully_formed;
 }
 
 static bool
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 850064d..3f46dc6 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -528,14 +528,24 @@
     }
 }
 
-bool stream_buf_read_setup_dowork(struct link_socket *sock);
+/**
+ * Will try to check if the buffers in stream form a
+ * full packet. Will return true if further reads are
+ * required and false otherwise. (full packet is ready)
+ *
+ * With UDP we always return true as there is no reassembly.
+ *
+ * @param sb    the stream buffer that should be worked on
+ * @return      true if more reads are required.
+ */
+bool stream_buf_read_setup_dowork(struct stream_buf *sb);
 
 static inline bool
 stream_buf_read_setup(struct link_socket *sock)
 {
     if (link_socket_connection_oriented(sock))
     {
-        return stream_buf_read_setup_dowork(sock);
+        return stream_buf_read_setup_dowork(&sock->stream_buf);
     }
     else
     {

