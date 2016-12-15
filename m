From: Steffan Karger <steffan@...1856...>
Date: Thu, 15 Dec 2016 19:52:35 +0100
Message-Id: <1481827955-18896-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Don't reopen tun if cipher changes
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

When the pulled options change, OpenVPN will attempt to reopen the tun
device.  That might fail if the process has already dropper privileges,
and is not needed unless the tun MTU is changed.  This patch therefore
ignores the cipher value for the digest if a fixed tun-mtu is used.

Additionally, this patch changes the md_ctx_update() call to include the
trailing zero byte of each option, to make sure that parsing "foo,bar"
results in a different hash than "foobar".  (Sorry for not catching that
during the review...)

Trac: #761

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/push.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 34c65c4..674efeb 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -677,17 +677,22 @@ process_incoming_push_request(struct context *c)
 #endif /* if P2MP_SERVER */
 
 static void
-push_update_digest(md_ctx_t *ctx, struct buffer *buf)
+push_update_digest(md_ctx_t *ctx, struct buffer *buf, const struct options *opt)
 {
     char line[OPTION_PARM_SIZE];
     while (buf_parse(buf, ',', line, sizeof(line)))
     {
         /* peer-id might change on restart and this should not trigger reopening tun */
-        if (strstr(line, "peer-id ") != line)
+        if (strcmp(line, "peer-id ") == 0)
         {
-            md_ctx_update(ctx, (const uint8_t *) line, strlen(line));
+            continue;
         }
-    }
+        if (strcmp(line, "cipher ") == 0 && !opt->ce.tun_mtu_defined)
+        {
+            continue;
+        }
+	}
+    md_ctx_update(ctx, (const uint8_t *) line, strlen(line)+1);
 }
 
 int
@@ -730,7 +735,8 @@ process_incoming_push_msg(struct context *c,
                                    option_types_found,
                                    c->c2.es))
             {
-                push_update_digest(&c->c2.pulled_options_state, &buf_orig);
+                push_update_digest(&c->c2.pulled_options_state, &buf_orig,
+                                   &c->options);
                 switch (c->options.push_continuation)
                 {
                     case 0:
-- 
2.7.4


