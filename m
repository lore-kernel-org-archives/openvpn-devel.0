From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 15:40:37 +0200
Message-Id: <20220422134038.3801239-9-arne@...1227...>
In-Reply-To: <20220422134038.3801239-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 08/28] Split out reliable_ack_parse from
 reliable_ack_read
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

This allows only the parsing without verification to be reused in other
code parts.
---
 src/openvpn/reliable.c | 60 ++++++++++++++++++++++++------------------
 src/openvpn/reliable.h | 22 ++++++++++++++++
 src/openvpn/ssl.c      |  1 -
 3 files changed, 56 insertions(+), 27 deletions(-)

diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 10a798a59..274f937ab 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -153,56 +153,64 @@ reliable_ack_acknowledge_packet_id(struct reliable_ack *ack, packet_id_type pid)
     return false;
 }
 
-/* read a packet ID acknowledgement record from buf into ack */
+
 bool
 reliable_ack_read(struct reliable_ack *ack,
                   struct buffer *buf, const struct session_id *sid)
 {
-    struct gc_arena gc = gc_new();
-    int i;
-    uint8_t count;
-    packet_id_type net_pid;
-    packet_id_type pid;
     struct session_id session_id_remote;
 
+    if (!reliable_ack_parse(buf, ack, &session_id_remote))
+    {
+        return false;
+    }
+
+    if (ack->len >= 1 && (!session_id_defined(&session_id_remote)
+        || !session_id_equal(&session_id_remote, sid)))
+    {
+        struct gc_arena gc = gc_new();
+        dmsg(D_REL_LOW,
+             "ACK read BAD SESSION-ID FROM REMOTE, local=%s, remote=%s",
+             session_id_print(sid, &gc), session_id_print(&session_id_remote, &gc));
+        gc_free(&gc);
+        return false;
+    }
+    return true;
+}
+
+bool
+reliable_ack_parse(struct buffer *buf, struct reliable_ack *ack,
+                   struct session_id *session_id_remote)
+{
+    uint8_t count;
+    ack->len = 0;
+
     if (!buf_read(buf, &count, sizeof(count)))
     {
-        goto error;
+        return false;
     }
-    for (i = 0; i < count; ++i)
+    for (int i = 0; i < count; ++i)
     {
+        packet_id_type net_pid;
         if (!buf_read(buf, &net_pid, sizeof(net_pid)))
         {
-            goto error;
+            return false;
         }
         if (ack->len >= RELIABLE_ACK_SIZE)
         {
-            goto error;
+            return false;
         }
-        pid = ntohpid(net_pid);
+        packet_id_type pid = ntohpid(net_pid);
         ack->packet_id[ack->len++] = pid;
     }
     if (count)
     {
-        if (!session_id_read(&session_id_remote, buf))
-        {
-            goto error;
-        }
-        if (!session_id_defined(&session_id_remote)
-            || !session_id_equal(&session_id_remote, sid))
+        if (!session_id_read(session_id_remote, buf))
         {
-            dmsg(D_REL_LOW,
-                 "ACK read BAD SESSION-ID FROM REMOTE, local=%s, remote=%s",
-                 session_id_print(sid, &gc), session_id_print(&session_id_remote, &gc));
-            goto error;
+            return false;
         }
     }
-    gc_free(&gc);
     return true;
-
-error:
-    gc_free(&gc);
-    return false;
 }
 
 /* write a packet ID acknowledgement record to buf, */
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index cd80bbfb2..05426fd8c 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -126,6 +126,28 @@ struct reliable
 bool reliable_ack_read(struct reliable_ack *ack,
                        struct buffer *buf, const struct session_id *sid);
 
+
+/**
+ * Parse an acknowledgment record from a received packet.
+ *
+ * This function parses the packet ID acknowledgment record from the packet
+ * contained in \a buf.  If the record contains acknowledgments, these are
+ * stored in \a ack.  This function also compares extracts packet's session ID
+ * and returns it in \a session_id_remote
+ *
+ * @param ack The acknowledgment structure in which received
+ *     acknowledgments are to be stored.
+ * @param buf The buffer containing the packet.
+ * @param session_id_remote The parsed remote session id. This field is
+ *                          is only filled if ack->len >= 1
+ * @return
+ * @li True, if processing was successful.
+ * @li False, if an error occurs during processing.
+ */
+bool
+reliable_ack_parse(struct buffer *buf, struct reliable_ack *ack,
+                   struct session_id *session_id_remote);
+
 /**
  * Remove acknowledged packets from a reliable structure.
  *
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 91f0e214d..cdf3e31da 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3435,7 +3435,6 @@ tls_pre_decrypt(struct tls_multi *multi,
         /* buffers all packet IDs to delete from send_reliable */
         struct reliable_ack send_ack;
 
-        send_ack.len = 0;
         if (!reliable_ack_read(&send_ack, buf, &session->session_id))
         {
             msg(D_TLS_ERRORS,
-- 
2.32.0 (Apple Git-132)


