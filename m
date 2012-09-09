From: David Sommerseth <dazo@...384...>
Date: Sun,  9 Sep 2012 03:30:46 +0200
Message-Id: <1347154246-20143-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH] Fix reconnect issues when --push and UDP is
	used on the server
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
Cc: james@...515...

From: David Sommerseth <davids@...1347...>

When the server is configured with UDP and --push statements, reconnecting
often fails by the client never receiving PUSH_REPLY.  The client sends
PUSH_REQUEST and the server logs these requests but does not send them.

This bug got introduced in commit ff65da3a230b658b2c1d52dc1a48612e80a2eb42
which tries to avoid sending duplicated PUSH messages if the client/server
connection is slow.

This patch keeps this behaviour, but instead of a session wide PUSH_REPLY
block it sets an expiry time for the PUSH_REPLY block.  The expiry time
is set to 30 seconds.

Signed-off-by: David Sommerseth <davids@...1347...>
Cc: James Yonan <james@...515...>
---
The solution here probably isn't the optimal fix, as the PUSH_REPLY block
should be reset when the client confirms the connection is established.
However, resetting the context's sent_push_reply variable turned out to
be tricky, as it already was set to  '0' on places it would be natural
to reset it.  However, it was always '1' in process_incoming_push_msg().

Going for the timeout solution is a quick-fix as we need to have this
issue solved before the 2.3 beta releases.  If anyone have a better 
solution, please submit a patch and we can drop this one.

To trigger this bug and to test this fix, configure a UDP enabled server
with PKI (--tls-{client,server}, --key, --cert, --ca, etc) and with add
some --push statements as well.  When the initial connection has been
established, stop the openvpn client and reconnect.  The bug will result
in server receiving and ignoring PUSH_REQUEST and the client will send
these requests until stopped.  The result is that the connection cannot
be re-established.  Two workarounds have been identified for this
behaviour.  A) Add --explicit-exit-notify to the client config,
or B) switch from UDP to TCP.  I did not manage to reproduce this on
a single computer running both client and server, but running on separate
computers over the Internet made it possible to trigger this issue.

 src/openvpn/openvpn.h |    2 +-
 src/openvpn/push.c    |    7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 0732d0f..7abfb08 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -448,7 +448,7 @@ struct context_2
   /* --ifconfig endpoints to be pushed to client */
   bool push_reply_deferred;
   bool push_ifconfig_defined;
-  bool sent_push_reply;
+  time_t sent_push_reply_expiry;
   in_addr_t push_ifconfig_local;
   in_addr_t push_ifconfig_remote_netmask;
 #ifdef ENABLE_CLIENT_NAT
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 8d7d23a..05a38e0 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -416,7 +416,10 @@ process_incoming_push_msg (struct context *c,
 	}
       else if (!c->c2.push_reply_deferred && c->c2.context_auth == CAS_SUCCEEDED)
 	{
-	  if (c->c2.sent_push_reply)
+	  time_t now;
+
+	  openvpn_time(&now);
+	  if (c->c2.sent_push_reply_expiry > now)
 	    {
 	      ret = PUSH_MSG_ALREADY_REPLIED;
 	    }
@@ -425,7 +428,7 @@ process_incoming_push_msg (struct context *c,
 	      if (send_push_reply (c))
 		{
 		  ret = PUSH_MSG_REQUEST;
-		  c->c2.sent_push_reply = true;
+		  c->c2.sent_push_reply_expiry = now + 30;
 		}
 	    }
 	}
-- 
1.7.10.2


