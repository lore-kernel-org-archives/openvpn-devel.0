From: Heiko Hund <heiko.hund@...1489...>
Date: Thu, 18 Aug 2011 12:12:11 +0000
Message-Id: <1313669531-31867-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH] fix warnings in event.c when building for
	win32-64
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

When compiling for 64-bit Windows gcc warns about

  "cast from pointer to integer of different size"

on two occasions in file event.c, due to invalid casting.
This patch removes the type casts and uses the correct
format specifier instead.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 event.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/event.c b/event.c
index 51b17b3..b6ed673 100644
--- a/event.c
+++ b/event.c
@@ -214,9 +214,9 @@ we_ctl (struct event_set *es, event_t event, unsigned int rwflags, void *arg)
 {
   struct we_set *wes = (struct we_set *) es;
 
-  dmsg (D_EVENT_WAIT, "WE_CTL n=%d ev=0x%08x rwflags=0x%04x arg=" ptr_format,
+  dmsg (D_EVENT_WAIT, "WE_CTL n=%d ev=%p rwflags=0x%04x arg=" ptr_format,
        wes->n_events,
-       (unsigned int)event,
+       event,
        rwflags,
        (ptr_type)arg);
 
@@ -344,9 +344,9 @@ we_wait (struct event_set *es, const struct timeval *tv, struct event_set_return
   if (check_debug_level (D_EVENT_WAIT)) {
     int i;
     for (i = 0; i < wes->n_events; ++i)
-      dmsg (D_EVENT_WAIT, "[%d] ev=0x%08x rwflags=0x%04x arg=" ptr_format,
+      dmsg (D_EVENT_WAIT, "[%d] ev=%p rwflags=0x%04x arg=" ptr_format,
        i,
-       (unsigned int)wes->events[i],
+       wes->events[i],
        wes->esr[i].rwflags,
        (ptr_type)wes->esr[i].arg);
   }
-- 
1.7.5.4


