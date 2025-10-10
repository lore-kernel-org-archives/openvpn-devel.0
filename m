From: Gert Doering <gert@...1296...>
Date: Fri, 10 Oct 2025 16:19:56 +0200
Message-ID: <20251010142002.27308-1-gert@...1296...>
In-Reply-To: <gerrit.1760090860000.I41d08a9a2e79ac1f1104e72dd5b7b7617e2071a0@...2715...>
References: <gerrit.1760090860000.I41d08a9a2e79ac1f1104e72dd5b7b7617e2071a0@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] PUSH_UPDATE server: bug-fix,
 reset buffer after processing
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

From: Marco Baffo <marco@...2726...>

In the send_single_push_update() function the buffer containing
the message was not reset after processing, so o in a push-update-broad
the messages sent starting from the second client would have been
shrunk (offset advanced and size decreased).

Change-Id: I41d08a9a2e79ac1f1104e72dd5b7b7617e2071a0
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1264
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1264
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index f306104..b475d2e 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -170,9 +170,12 @@
          * inside `process_incoming_push_msg()`. However, we don't need
          * to check the return value here because we just want to `advance`,
          * meaning we skip the `push_update_cmd' we added earlier.
+         * Also we need to make a temporary copy so we can buf_advance()
+         * without modifying original buffer.
          */
-        buf_string_compare_advance(&msgs[i], push_update_cmd);
-        if (process_incoming_push_update(c, pull_permission_mask(c), option_types_found, &msgs[i], true) == PUSH_MSG_ERROR)
+        struct buffer tmp_msg = msgs[i];
+        buf_string_compare_advance(&tmp_msg, push_update_cmd);
+        if (process_incoming_push_update(c, pull_permission_mask(c), option_types_found, &tmp_msg, true) == PUSH_MSG_ERROR)
         {
             msg(M_WARN, "Failed to process push update message sent to client ID: %u",
                 c->c2.tls_multi ? c->c2.tls_multi->peer_id : UINT32_MAX);

