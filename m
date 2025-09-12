From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 12 Sep 2025 15:15:19 +0200
Message-Id: <20250912131519.43222-1-frank@...2641...>
In-Reply-To: <gerrit.1757600733000.I73f8ad9bf105920f4bde357ea9dcf0e485f3f3cb@...2715...>
References: <gerrit.1757600733000.I73f8ad9bf105920f4bde357ea9dcf0e485f3f3cb@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] push-update-server: comment about
 buf_string_compare_advance() usage in send_single_push_update()
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

Change-Id: I73f8ad9bf105920f4bde357ea9dcf0e485f3f3cb
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1177
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index bd3992b..f7a4fca 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -161,6 +161,10 @@
          * will not be routed towards the client.
          * For the same reason we later update the vhash too in
          * `send_push_update()` function.
+         * Using `buf_string_compare_advance()` we mimic the behavior
+         * inside `process_incoming_push_msg()`. However, we don't need
+         * to check the return value here because we just want to `advance`,
+         * meaning we skip the `push_update_cmd' we added earlier.
          */
         buf_string_compare_advance(&msgs[i], push_update_cmd);
         if (process_incoming_push_update(c, pull_permission_mask(c), option_types_found, &msgs[i], true) == PUSH_MSG_ERROR)

