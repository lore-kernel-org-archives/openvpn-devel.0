From: David Sommerseth <openvpn.list@...1114...>
Date: Sun, 13 Jun 2010 01:02:56 +0200
Message-Id: <1276383776-15751-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] Fixed client hang when server don't PUSH
	(aka the NO_SOUP_FOR_YOU patch)
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
Cc: David Sommerseth <dazo@...384...>

From: David Sommerseth <dazo@...384...>

Solves bug ticket 13
<https://community.openvpn.net/openvpn/ticket/13>

When the client sends PUSH_REQUESTS, it waits until the server sends PUSH_REPLY.
If the server do not have anything to push to the client nothing happens.  The
client will then regularly send new PUSH_REQUESTS until it gets an answer, which
results in not completing the connection negotiation.

This patch makes the server send an empty PUSH_REPLY when it has nothing to more
to push to the client.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 push.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/push.c b/push.c
index 9ddc900..1320bec 100644
--- a/push.c
+++ b/push.c
@@ -177,6 +177,7 @@ send_push_reply (struct context *c)
   static char cmd[] = "PUSH_REPLY";
   const int extra = 64; /* extra space for possible trailing ifconfig and push-continuation */
   const int safe_cap = BCAP (&buf) - extra;
+  bool push_sent = false;
 
   buf_printf (&buf, cmd);
 
@@ -192,6 +193,7 @@ send_push_reply (struct context *c)
 		const bool status = send_control_channel_string (c, BSTR (&buf), D_PUSH);
 		if (!status)
 		  goto fail;
+		push_sent = true;
 		multi_push = true;
 		buf_reset_len (&buf);
 		buf_printf (&buf, cmd);
@@ -218,6 +220,21 @@ send_push_reply (struct context *c)
     {
       const bool status = send_control_channel_string (c, BSTR (&buf), D_PUSH);
       if (!status)
+        goto fail;
+      push_sent = true;
+    }
+
+  /* If nothing have been pushed, send an empty push,
+   * as the client is expecting a response
+   */
+  if (!push_sent)
+    {
+      bool status = false;
+
+      buf_reset_len (&buf);
+      buf_printf (&buf, cmd);
+      status = send_control_channel_string (c, BSTR(&buf), D_PUSH);
+      if (!status)
 	goto fail;
     }
 
-- 
1.6.6.1


