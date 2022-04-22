From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 16:29:49 +0200
Message-Id: <20220422142953.3805364-15-arne@...1227...>
In-Reply-To: <20220422142953.3805364-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 24/28] Extract read_incoming_tls_plaintext
 into its own function
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

This makes the tls_process_state function a bit easier to read allows
extending the read_incoming_tls_plaintext function later without
making tls_process_state even longer.
---
 src/openvpn/ssl.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e3101c7fa..01717559c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2612,6 +2612,28 @@ control_packet_needs_wkc(const struct key_state *ks)
            && (ks->send_reliable->packet_id == 1);
 }
 
+static bool
+read_incoming_tls_plaintext(struct buffer *buf, struct key_state *ks, interval_t *wakeup)
+{
+    ASSERT(buf_init(buf, 0));
+    int status = key_state_read_plaintext(&ks->ks_ssl, buf, TLS_CHANNEL_BUF_SIZE);
+    update_time();
+    if (status == -1)
+    {
+        msg(D_TLS_ERRORS, "TLS Error: TLS object -> incoming plaintext read error");
+        return false;
+    }
+    if (status == 1)
+    {
+        *state_change = true;
+        dmsg(D_TLS_DEBUG, "TLS -> Incoming Plaintext");
+
+        /* More data may be available, wake up again asap to check. */
+        *wakeup = 0;
+    }
+    return true;
+}
+
 
 static bool
 tls_process_state(struct tls_multi *multi,
@@ -2705,24 +2727,10 @@ tls_process_state(struct tls_multi *multi,
     struct buffer *buf = &ks->plaintext_read_buf;
     if (!buf->len)
     {
-        int status;
-
-        ASSERT(buf_init(buf, 0));
-        status = key_state_read_plaintext(&ks->ks_ssl, buf, TLS_CHANNEL_BUF_SIZE);
-        update_time();
-        if (status == -1)
+        if (!read_incoming_tls_plaintext(buf, ks, wakeup))
         {
-            msg(D_TLS_ERRORS, "TLS Error: TLS object -> incoming plaintext read error");
             goto error;
         }
-        if (status == 1)
-        {
-            state_change = true;
-            dmsg(D_TLS_DEBUG, "TLS -> Incoming Plaintext");
-
-            /* More data may be available, wake up again asap to check. */
-            *wakeup = 0;
-        }
     }
 
     /* Send Key */
-- 
2.32.0 (Apple Git-132)


