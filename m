From: Arne Schwabe <arne@...1227...>
Date: Fri, 23 Oct 2020 13:34:29 +0200
Message-Id: <20201023113431.26691-3-arne@...1227...>
In-Reply-To: <20201023113431.26691-1-arne@...1227...>
References: <20201023113431.26691-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 3/5] Align reliable_free with other free
 methods to accept NULL
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

The semantic of most free methods is to free a pointer and all its
contents and also free the pointer itself. Align reliable_free to this
semantic.

Also clean up the other free uses in key_state_free.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/reliable.c |  5 +++++
 src/openvpn/reliable.h |  4 +++-
 src/openvpn/ssl.c      | 24 ++++--------------------
 3 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index eae1e0cb..6c1f2da1 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -326,12 +326,17 @@ reliable_init(struct reliable *rel, int buf_size, int offset, int array_size, bo
 void
 reliable_free(struct reliable *rel)
 {
+    if (!rel)
+    {
+        return;
+    }
     int i;
     for (i = 0; i < rel->size; ++i)
     {
         struct reliable_entry *e = &rel->array[i];
         free_buf(&e->buf);
     }
+    free(rel);
 }
 
 /* no active buffers? */
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index 688c65c8..a84d4290 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -192,7 +192,9 @@ bool reliable_ack_write(struct reliable_ack *ack,
 void reliable_init(struct reliable *rel, int buf_size, int offset, int array_size, bool hold);
 
 /**
- * Free allocated memory associated with a reliable structure.
+ * Free allocated memory associated with a reliable structure and the pointer
+ * itself.
+ * Does nothing if rel is NULL.
  *
  * @param rel The reliable structured to clean up.
  */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 87b51d96..7a3eb146 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -969,27 +969,11 @@ key_state_free(struct key_state *ks, bool clear)
     free_buf(&ks->ack_write_buf);
     buffer_list_free(ks->paybuf);
 
-    if (ks->send_reliable)
-    {
-        reliable_free(ks->send_reliable);
-        free(ks->send_reliable);
-    }
-
-    if (ks->rec_reliable)
-    {
-        reliable_free(ks->rec_reliable);
-        free(ks->rec_reliable);
-    }
+    reliable_free(ks->send_reliable);
+    reliable_free(ks->rec_reliable);
 
-    if (ks->rec_ack)
-    {
-        free(ks->rec_ack);
-    }
-
-    if (ks->key_src)
-    {
-        free(ks->key_src);
-    }
+    free(ks->rec_ack);
+    free(ks->key_src);
 
     packet_id_free(&ks->crypto_options.packet_id);
 
-- 
2.26.2


