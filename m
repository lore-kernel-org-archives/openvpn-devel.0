From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 16:29:46 +0200
Message-Id: <20220422142953.3805364-12-arne@...1227...>
In-Reply-To: <20220422142953.3805364-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 21/28] Extract read_incoming_tls_ciphertext
 into function
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

This makes the code a bit more structured and easier to read.
---
 src/openvpn/ssl.c | 53 +++++++++++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 20 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 80440c411..8ea7c06fa 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2525,6 +2525,37 @@ session_skip_to_pre_start(struct tls_session *session,
     return session_move_pre_start(session, ks, true);
 }
 
+/**
+ * Read incoming ciphertext and passes it to the buffer of the SSL library.
+ * Returns false if an error is encountered that should abort the session.
+ */
+static bool
+read_incoming_tls_ciphertext(struct buffer *buf, struct key_state *ks,
+                             bool *state_change)
+{
+    int status = 0;
+    if (buf->len)
+    {
+        status = key_state_write_ciphertext(&ks->ks_ssl, buf);
+        if (status == -1)
+        {
+            msg(D_TLS_ERRORS,
+                "TLS Error: Incoming Ciphertext -> TLS object write error");
+            return false;
+        }
+    }
+    else
+    {
+        status = 1;
+    }
+    if (status == 1)
+    {
+        reliable_mark_deleted(ks->rec_reliable, buf);
+        *state_change = true;
+        dmsg(D_TLS_DEBUG, "Incoming Ciphertext -> TLS");
+    }
+    return true;
+}
 
 
 static bool
@@ -2595,27 +2626,9 @@ tls_process_state(struct tls_multi *multi,
     struct reliable_entry *entry = reliable_get_entry_sequenced(ks->rec_reliable);
     if (entry)
     {
-        struct buffer *buf = &entry->buf;
-        int status = 0;
-        if (buf->len)
-        {
-            status = key_state_write_ciphertext(&ks->ks_ssl, buf);
-            if (status == -1)
-            {
-                msg(D_TLS_ERRORS,
-                    "TLS Error: Incoming Ciphertext -> TLS object write error");
-                goto error;
-            }
-        }
-        else
-        {
-            status = 1;
-        }
-        if (status == 1)
+        if (!read_incoming_tls_ciphertext(&entry->buf, ks, &state_change))
         {
-            reliable_mark_deleted(ks->rec_reliable, buf);
-            state_change = true;
-            dmsg(D_TLS_DEBUG, "Incoming Ciphertext -> TLS");
+            goto error;
         }
     }
 
-- 
2.32.0 (Apple Git-132)


