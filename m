From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 16:29:45 +0200
Message-Id: <20220422142953.3805364-11-arne@...1227...>
In-Reply-To: <20220422142953.3805364-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 20/28] Change reliable_get_buf_sequenced to
 reliable_get_entry_sequenced
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

This returns not just the buffer of a reliable_entry but the whole
entry. This allows the caller to also inspect the original opcode
and packet id.
---
 src/openvpn/reliable.c | 6 +++---
 src/openvpn/reliable.h | 7 +++----
 src/openvpn/ssl.c      | 7 ++++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 5c897b225..372444350 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -533,8 +533,8 @@ reliable_get_buf_output_sequenced(struct reliable *rel)
 }
 
 /* get active buffer for next sequentially increasing key ID */
-struct buffer *
-reliable_get_buf_sequenced(struct reliable *rel)
+struct reliable_entry *
+reliable_get_entry_sequenced(struct reliable *rel)
 {
     int i;
     for (i = 0; i < rel->size; ++i)
@@ -542,7 +542,7 @@ reliable_get_buf_sequenced(struct reliable *rel)
         struct reliable_entry *e = &rel->array[i];
         if (e->active && e->packet_id == rel->packet_id)
         {
-            return &e->buf;
+            return e;
         }
     }
     return NULL;
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index b045410a7..0bc8ab913 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -351,11 +351,10 @@ bool reliable_ack_acknowledge_packet_id(struct reliable_ack *ack, packet_id_type
  * @param rel The reliable structure from which to retrieve the
  *     buffer.
  *
- * @return A pointer to the buffer of the entry with the next
- *     sequential key ID.  If no such entry is present, this function
- *     returns NULL.
+ * @return A pointer to the entry with the next sequential key ID.
+ *     If no such entry is present, this function  returns NULL.
  */
-struct buffer *reliable_get_buf_sequenced(struct reliable *rel);
+struct reliable_entry *reliable_get_entry_sequenced(struct reliable *rel);
 
 /**
  * Remove an entry from a reliable structure.
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index dca62a875..80440c411 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2592,9 +2592,10 @@ tls_process_state(struct tls_multi *multi,
     }
 
     /* Write incoming ciphertext to TLS object */
-    struct buffer *buf = reliable_get_buf_sequenced(ks->rec_reliable);
-    if (buf)
+    struct reliable_entry *entry = reliable_get_entry_sequenced(ks->rec_reliable);
+    if (entry)
     {
+        struct buffer *buf = &entry->buf;
         int status = 0;
         if (buf->len)
         {
@@ -2619,7 +2620,7 @@ tls_process_state(struct tls_multi *multi,
     }
 
     /* Read incoming plaintext from TLS object */
-    buf = &ks->plaintext_read_buf;
+    struct buffer *buf = &ks->plaintext_read_buf;
     if (!buf->len)
     {
         int status;
-- 
2.32.0 (Apple Git-132)


