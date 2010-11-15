From: David Sommerseth <dazo@...384...>
Date: Mon, 15 Nov 2010 09:05:47 +0100
Message-Id: <1289808348-17463-7-git-send-email-dazo@...384...>
In-Reply-To: <1289808348-17463-1-git-send-email-dazo@...384...>
References: <1289808348-17463-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 5/6] Removed functions not being used
	anywhere
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

The GNU C compiler gave warnings about these functions in the patch
not being used anywhere.  Doing a git grep on the code turned out
there were no callers to these functions.  Taking these functions out,
as there is not good reason why to carry dead code.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 ps.c  |   12 ------------
 sig.c |    9 ---------
 2 files changed, 0 insertions(+), 21 deletions(-)

diff --git a/ps.c b/ps.c
index 003fb45..0aaef62 100644
--- a/ps.c
+++ b/ps.c
@@ -234,18 +234,6 @@ port_share_sendmsg (const socket_descriptor_t sd,
     }
 }
 
-static int
-pc_list_len (struct proxy_connection *pc)
-{
-  int count = 0;
-  while (pc)
-    {
-      ++count;
-      pc = pc->next;
-    }
-  return count;
-}
-
 static void
 proxy_entry_close_sd (struct proxy_connection *pc, struct event_set *es)
 {
diff --git a/sig.c b/sig.c
index 4dd6b09..438f4e6 100644
--- a/sig.c
+++ b/sig.c
@@ -185,15 +185,6 @@ signal_handler (const int signum)
   signal (signum, signal_handler);
 }
 
-/* temporary signal handler, before we are fully initialized */
-static void
-signal_handler_exit (const int signum)
-{
-  msg (M_FATAL,
-       "Signal %d (%s) received during initialization, exiting",
-       signum, signal_description (signum, NULL));
-}
-
 #endif
 
 /* set handlers for unix signals */
-- 
1.7.2.3


