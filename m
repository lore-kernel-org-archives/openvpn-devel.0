From: Gert Doering <gert@...1296...>
Date: Mon, 15 Dec 2025 17:05:35 +0100
Message-ID: <20251215160541.24237-1-gert@...1296...>
In-Reply-To: <gerrit.1765538409000.I123002255b37160d48ef6481f68a89d03073236b@...2715...>
References: <gerrit.1765538409000.I123002255b37160d48ef6481f68a89d03073236b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] buffer: Change buf_prepend and
 buf_advance to accept ssize_t for length
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

From: Frank Lichtenheld <frank@...2641...>

We already have tests to make sure the value is sane.
Changing the argument to ssize_t allows to use it in
more places without needing to do a cast before the
checks.

Change-Id: I123002255b37160d48ef6481f68a89d03073236b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1437
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1437
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 293622f..aae4104 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -789,7 +789,7 @@
 {
     if (buf_string_match_head_str(src, match))
     {
-        buf_advance(src, (int)strlen(match));
+        buf_advance(src, strlen(match));
         return true;
     }
     else
@@ -1312,7 +1312,7 @@
 }
 
 void
-buffer_list_advance(struct buffer_list *ol, int n)
+buffer_list_advance(struct buffer_list *ol, ssize_t n)
 {
     if (ol->head)
     {
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index ab2a29d..5444dfd 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -601,26 +601,26 @@
  */
 
 static inline uint8_t *
-buf_prepend(struct buffer *buf, int size)
+buf_prepend(struct buffer *buf, ssize_t size)
 {
     if (!buf_valid(buf) || size < 0 || size > buf->offset)
     {
         return NULL;
     }
-    buf->offset -= size;
-    buf->len += size;
+    buf->offset -= (int)size;
+    buf->len += (int)size;
     return BPTR(buf);
 }
 
 static inline bool
-buf_advance(struct buffer *buf, int size)
+buf_advance(struct buffer *buf, ssize_t size)
 {
     if (!buf_valid(buf) || size < 0 || buf->len < size)
     {
         return false;
     }
-    buf->offset += size;
-    buf->len -= size;
+    buf->offset += (int)size;
+    buf->len -= (int)size;
     return true;
 }
 
@@ -1175,7 +1175,7 @@
  */
 struct buffer *buffer_list_peek(struct buffer_list *ol);
 
-void buffer_list_advance(struct buffer_list *ol, int n);
+void buffer_list_advance(struct buffer_list *ol, ssize_t n);
 
 void buffer_list_pop(struct buffer_list *ol);
 
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 31e7c25..917f871 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -596,7 +596,7 @@
         {
             dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: partial write[%d], tried=%d got=%zd", (int)sd,
                  pc->buf.len, status);
-            buf_advance(&pc->buf, (int)status);
+            buf_advance(&pc->buf, status);
             return IOSTAT_EAGAIN_ON_WRITE;
         }
         else

