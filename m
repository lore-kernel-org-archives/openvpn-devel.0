Resent-Message-ID: <ZUzBkzsfFDfng1x7@...1296...>
Resent-To: openvpn-devel@lists.sourceforge.net
From: Gert Doering <gert@...1296...>
Date: Wed,  8 Nov 2023 13:49:46 +0100
Message-ID: <20231108124947.76816-2-gert@...1296...>
In-Reply-To: <20231108124947.76816-1-gert@...1296...>
References: <20231108124947.76816-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] Double check that we do not use a freed
 buffer when freeing a session
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

This is a find cases where the session already has planned to send out
a packet but encounters some other errors that invalidate the session,
setting it to S_ERROR and leaving the buffer behind.

This will detect and clear that to_link buffer in that case.

Change-Id: I5ffb41bed1c9237946b13d787eb4c4013e0bec68
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c | 48 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 5e6205cc2..e15f951d6 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3155,6 +3155,53 @@ tls_process(struct tls_multi *multi,
     return false;
 }
 
+
+/**
+ * This is a safe guard function to double check that a buffer from a session is
+ * not used in a session to avoid a use after free.
+ *
+ * @param to_link
+ * @param session
+ */
+static void
+check_session_buf_not_used(struct buffer *to_link, struct tls_session *session)
+{
+    uint8_t *dataptr = to_link->data;
+    if (!dataptr)
+    {
+        return;
+    }
+
+    /* Checks buffers in tls_wrap */
+    if (session->tls_wrap.work.data == dataptr)
+    {
+        msg(M_INFO, "Warning buffer of freed TLS session is "
+            "still in use (tls_wrap.work.data)");
+        goto used;
+    }
+
+    for (int i = 0; i < KS_SIZE; i++)
+    {
+        struct key_state *ks = &session->key[i];
+        for (int j = 0; j < ks->send_reliable->size; j++)
+        {
+            if (ks->send_reliable->array[i].buf.data == dataptr)
+            {
+                msg(M_INFO, "Warning buffer of freed TLS session is still in"
+                    " use (session->key[%d].send_reliable->array[%d])",
+                    i, j);
+
+                goto used;
+            }
+        }
+    }
+    return;
+
+used:
+    to_link->len = 0;
+    to_link->data = 0;
+    /* for debugging, you can add an ASSERT(0); here to trigger an abort */
+}
 /*
  * Called by the top-level event loop.
  *
@@ -3253,6 +3300,7 @@ tls_multi_process(struct tls_multi *multi,
                 }
                 else
                 {
+                    check_session_buf_not_used(to_link, session);
                     reset_session(multi, session);
                 }
             }
-- 
2.39.3 (Apple Git-145)


