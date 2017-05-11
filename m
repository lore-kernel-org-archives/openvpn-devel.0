From: Steffan Karger <steffan@...1856...>
Date: Thu, 11 May 2017 23:13:40 +0200
Message-Id: <1494537221-12050-2-git-send-email-steffan@...1856...>
In-Reply-To: <1494537221-12050-1-git-send-email-steffan@...1856...>
References: <1494537221-12050-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/3 (release/2.2)] cleanup: merge
	packet_id_alloc_outgoing() into packet_id_write()
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

From: Steffan Karger <steffan.karger@...1435...>

The functions packet_id_alloc_outgoing() and packet_id_write() were
always called in tandem.  Instead of forcing the caller to allocate a
packet_id_net to do so, merge the two functions.  This simplifies the API
and reduces the chance on mistakes in the future.

This patch was cherry-picked from 5d747770 (release/2.3), with the unit
tests removed because release/2.2 does not have unit tests.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 crypto.c    | 12 +++---------
 packet_id.c | 24 +++++++++++++++++++++---
 packet_id.h | 34 +++++++++++++---------------------
 3 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/crypto.c b/crypto.c
index 6dd6a5f..b7b2f01 100644
--- a/crypto.c
+++ b/crypto.c
@@ -119,23 +119,19 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	      /* Put packet ID in plaintext buffer or IV, depending on cipher mode */
 	      if (opt->packet_id)
 		{
-		  struct packet_id_net pin;
-		  packet_id_alloc_outgoing (&opt->packet_id->send, &pin, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM));
-		  ASSERT (packet_id_write (&pin, buf, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM), true));
+		  ASSERT (packet_id_write (&opt->packet_id->send, buf, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM), true));
 		}
 	    }
 	  else if (mode == EVP_CIPH_CFB_MODE || mode == EVP_CIPH_OFB_MODE)
 	    {
-	      struct packet_id_net pin;
 	      struct buffer b;
 
 	      ASSERT (opt->flags & CO_USE_IV);    /* IV and packet-ID required */
 	      ASSERT (opt->packet_id); /*  for this mode. */
 
-	      packet_id_alloc_outgoing (&opt->packet_id->send, &pin, true);
 	      memset (iv_buf, 0, iv_size);
 	      buf_set_write (&b, iv_buf, iv_size);
-	      ASSERT (packet_id_write (&pin, &b, true, false));
+	      ASSERT (packet_id_write (&opt->packet_id->send, &b, true, false));
 	    }
 	  else /* We only support CBC, CFB, or OFB modes right now */
 	    {
@@ -193,9 +189,7 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	{
 	  if (opt->packet_id)
 	    {
-	      struct packet_id_net pin;
-	      packet_id_alloc_outgoing (&opt->packet_id->send, &pin, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM));
-	      ASSERT (packet_id_write (&pin, buf, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM), true));
+	      ASSERT (packet_id_write (&opt->packet_id->send, buf, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM), true));
 	    }
 	  work = *buf;
 	}
diff --git a/packet_id.c b/packet_id.c
index b11e71f..d190074 100644
--- a/packet_id.c
+++ b/packet_id.c
@@ -248,12 +248,30 @@ packet_id_read (struct packet_id_net *pin, struct buffer *buf, bool long_form)
   return true;
 }
 
+static void
+packet_id_send_update(struct packet_id_send *p, bool long_form)
+{
+  if (!p->time)
+    {
+      p->time = now;
+    }
+  p->id++;
+  if (!p->id)
+    {
+      ASSERT(long_form);
+      p->time = now;
+      p->id = 1;
+    }
+}
+
 bool
-packet_id_write (const struct packet_id_net *pin, struct buffer *buf, bool long_form, bool prepend)
+packet_id_write (struct packet_id_send *p, struct buffer *buf, bool long_form,
+        bool prepend)
 {
-  packet_id_type net_id = htonpid (pin->id);
-  net_time_t net_time = htontime (pin->time);
+  packet_id_send_update(p, long_form);
 
+  const packet_id_type net_id = htonpid(p->id);
+  const net_time_t net_time = htontime(p->time);
   if (prepend)
     {
       if (long_form)
diff --git a/packet_id.h b/packet_id.h
index 12c1df3..59b7a7b 100644
--- a/packet_id.h
+++ b/packet_id.h
@@ -249,7 +249,19 @@ const char *packet_id_persist_print (const struct packet_id_persist *p, struct g
  */
 
 bool packet_id_read (struct packet_id_net *pin, struct buffer *buf, bool long_form);
-bool packet_id_write (const struct packet_id_net *pin, struct buffer *buf, bool long_form, bool prepend);
+
+/**
+ * Write a packet ID to buf, and update the packet ID state.
+ *
+ * @param p             Packet ID state.
+ * @param buf           Buffer to write the packet ID too
+ * @param long_form     If true, also update and write time_t to buf
+ * @param prepend       If true, prepend to buffer, otherwise apppend.
+ *
+ * @return true if successful, false otherwise.
+ */
+bool packet_id_write (struct packet_id_send *p, struct buffer *buf,
+        bool long_form, bool prepend);
 
 /*
  * Inline functions.
@@ -291,26 +303,6 @@ packet_id_close_to_wrapping (const struct packet_id_send *p)
   return p->id >= PACKET_ID_WRAP_TRIGGER;
 }
 
-/*
- * Allocate an outgoing packet id.
- * Sequence number ranges from 1 to 2^32-1.
- * In long_form, a time_t is added as well.
- */
-static inline void
-packet_id_alloc_outgoing (struct packet_id_send *p, struct packet_id_net *pin, bool long_form)
-{
-  if (!p->time)
-    p->time = now;
-  pin->id = ++p->id;
-  if (!pin->id)
-    {
-      ASSERT (long_form);
-      p->time = now;
-      pin->id = p->id = 1;
-    }
-  pin->time = p->time;
-}
-
 static inline bool
 check_timestamp_delta (time_t remote, unsigned int max_delta)
 {
-- 
2.7.4


