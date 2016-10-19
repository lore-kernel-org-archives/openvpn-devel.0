From: Steffan Karger <steffan@...1856...>
Date: Wed, 19 Oct 2016 21:03:27 +0200
Message-Id: <1476903807-28763-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Remove verbose msg() from send_push_reply()
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

Probably committed by lev by accident, and then overlooked by me during
review.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/push.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index ff374c8..54726e7 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -431,8 +431,6 @@ send_push_reply (struct context *c, struct push_list *per_client_push_list)
   const int safe_cap = BCAP (&buf) - extra;
   bool push_sent = false;
 
-  msg( M_INFO, "send_push_reply(): safe_cap=%d", safe_cap );
-
   buf_printf (&buf, "%s", push_reply_cmd);
 
   /* send options which are common to all clients */
-- 
2.7.4


