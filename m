From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Aug 2020 16:37:02 +0200
Message-Id: <20200810143707.5834-13-arne@...1227...>
In-Reply-To: <20200810143707.5834-1-arne@...1227...>
References: <20200810143707.5834-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 12/17] Merge check_coarse_timers and
 check_coarse_timers_dowork
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

This simplifies the code a bit and makes the code flow clearer as
it only adds three curly brackets in check_coarse_timers. Merging the
resulting check_coarse_timers_dowork function into the caller and
called function as with the other function does not make sense here
since it does more than similar function.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 36e5c175..7ed8d0d7 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -700,8 +700,14 @@ process_coarse_timers(struct context *c)
 }
 
 static void
-check_coarse_timers_dowork(struct context *c)
+check_coarse_timers(struct context *c)
 {
+    if (now < c->c2.coarse_timer_wakeup)
+    {
+        context_reschedule_sec(c, c->c2.coarse_timer_wakeup - now);
+        return;
+    }
+
     const struct timeval save = c->c2.timeval;
     c->c2.timeval.tv_sec = BIG_TIMEOUT;
     c->c2.timeval.tv_usec = 0;
@@ -717,20 +723,6 @@ check_coarse_timers_dowork(struct context *c)
     }
 }
 
-static inline void
-check_coarse_timers(struct context *c)
-{
-    const time_t local_now = now;
-    if (local_now >= c->c2.coarse_timer_wakeup)
-    {
-        check_coarse_timers_dowork(c);
-    }
-    else
-    {
-        context_reschedule_sec(c, c->c2.coarse_timer_wakeup - local_now);
-    }
-}
-
 static void
 check_timeout_random_component_dowork(struct context *c)
 {
-- 
2.26.2


