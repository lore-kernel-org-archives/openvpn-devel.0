From: Lev Stipakov <lstipakov@...277...>
Date: Tue,  4 Oct 2016 23:20:03 +0300
Message-Id: <1475612403-1266-1-git-send-email-lstipakov@...277...>
In-Reply-To: <2ad2231f-9e17-7709-b488-5ee201200f68@...1856...>
References: <2ad2231f-9e17-7709-b488-5ee201200f68@...1856...>
Subject: [Openvpn-devel] [PATCH v2] Exclude peer-id from pulled options
	digest
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

v2:
 - Move digest update to separate method

Peer-id might change on restart and this should not trigger reopening
tun.

Trac #649
---
 src/openvpn/push.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index a1b999e..c0c78a0 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -597,6 +597,20 @@ process_incoming_push_request (struct context *c)
 }
 #endif
 
+static void
+push_update_digest(md_ctx_t *ctx, struct buffer *buf)
+{
+  char line[OPTION_PARM_SIZE];
+  while (buf_parse (buf, ',', line, sizeof (line)))
+    {
+      /* peer-id might change on restart and this should not trigger reopening tun */
+      if (strstr (line, "peer-id ") != line)
+	{
+	  md_ctx_update (ctx, (const uint8_t *) line, strlen(line));
+	}
+    }
+}
+
 int
 process_incoming_push_msg (struct context *c,
 			   const struct buffer *buffer,
@@ -636,21 +650,22 @@ process_incoming_push_msg (struct context *c,
 				  permission_mask,
 				  option_types_found,
 				  c->c2.es))
-	    switch (c->options.push_continuation)
-	      {
-	      case 0:
-	      case 1:
-		md_ctx_update (&c->c2.pulled_options_state, BPTR(&buf_orig), BLEN(&buf_orig));
-		md_ctx_final (&c->c2.pulled_options_state, c->c2.pulled_options_digest.digest);
-		md_ctx_cleanup (&c->c2.pulled_options_state);
-	        c->c2.pulled_options_md5_init_done = false;
-		ret = PUSH_MSG_REPLY;
-		break;
-	      case 2:
-		md_ctx_update (&c->c2.pulled_options_state, BPTR(&buf_orig), BLEN(&buf_orig));
-		ret = PUSH_MSG_CONTINUATION;
-		break;
-	      }
+	    {
+	      push_update_digest (&c->c2.pulled_options_state, &buf_orig);
+	      switch (c->options.push_continuation)
+		{
+		  case 0:
+		  case 1:
+		    md_ctx_final (&c->c2.pulled_options_state, c->c2.pulled_options_digest.digest);
+		    md_ctx_cleanup (&c->c2.pulled_options_state);
+		    c->c2.pulled_options_md5_init_done = false;
+		    ret = PUSH_MSG_REPLY;
+		    break;
+		  case 2:
+		    ret = PUSH_MSG_CONTINUATION;
+		    break;
+		}
+	    }
 	}
       else if (ch == '\0')
 	{
-- 
1.9.1


