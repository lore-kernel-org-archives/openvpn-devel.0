From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Aug 2020 16:36:54 +0200
Message-Id: <20200810143707.5834-5-arne@...1227...>
In-Reply-To: <20200810143707.5834-1-arne@...1227...>
References: <20200810143707.5834-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 04/17] Minor cleanup in push.c
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/push.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index f10021f8..d20b345d 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -330,13 +330,10 @@ incoming_push_message(struct context *c, const struct buffer *buffer)
 {
     struct gc_arena gc = gc_new();
     unsigned int option_types_found = 0;
-    int status;
 
     msg(D_PUSH, "PUSH: Received control message: '%s'", sanitize_control_message(BSTR(buffer), &gc));
 
-    status = process_incoming_push_msg(c,
-                                       buffer,
-                                       c->options.pull,
+    int status = process_incoming_push_msg(c, buffer, c->options.pull,
                                        pull_permission_mask(c),
                                        &option_types_found);
 
@@ -866,7 +863,7 @@ process_incoming_push_msg(struct context *c,
         return process_incoming_push_request(c);
     }
     else if (honor_received_options
-             && buf_string_compare_advance(&buf, "PUSH_REPLY"))
+             && buf_string_compare_advance(&buf, push_reply_cmd))
     {
         return process_incoming_push_reply(c, permission_mask,
                                            option_types_found, &buf);
-- 
2.26.2


