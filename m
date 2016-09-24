From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 24 Sep 2016 18:51:50 +0300
Message-Id: <1474732310-13672-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH 2.3] Exclude peer-id from pulled options
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

Peer-id might change on restart and this should not trigger reopening
tun.

Trac #649
---
 src/openvpn/push.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 71f39c1..6feaa2a 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -473,20 +473,30 @@ process_incoming_push_msg (struct context *c,
 				  permission_mask,
 				  option_types_found,
 				  c->c2.es))
-	    switch (c->options.push_continuation)
-	      {
-	      case 0:
-	      case 1:
-		md5_state_update (&c->c2.pulled_options_state, BPTR(&buf_orig), BLEN(&buf_orig));
-		md5_state_final (&c->c2.pulled_options_state, &c->c2.pulled_options_digest);
-	        c->c2.pulled_options_md5_init_done = false;
-		ret = PUSH_MSG_REPLY;
-		break;
-	      case 2:
-		md5_state_update (&c->c2.pulled_options_state, BPTR(&buf_orig), BLEN(&buf_orig));
-		ret = PUSH_MSG_CONTINUATION;
-		break;
-	      }
+	    {
+	      char line[OPTION_PARM_SIZE];
+	      while (buf_parse (&buf_orig, ',', line, sizeof (line)))
+		{
+		  /* peer-id might change on restart and this should not trigger reopening tun */
+		  if (strstr (line, "peer-id ") != line)
+		    {
+		      md_ctx_update (&c->c2.pulled_options_state, (const uint8_t *) line, strlen(line));
+		    }
+		}
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


