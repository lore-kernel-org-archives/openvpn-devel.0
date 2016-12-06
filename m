From: Lev Stipakov <lstipakov@...277...>
Date: Wed,  7 Dec 2016 01:45:51 +0200
Message-Id: <1481067951-28917-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Arm inotify only in server mode
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

Async-push is a server side feature and inotify_fd is
initialized in server mode.

Trac #786
---
 src/openvpn/forward.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index b50a2e0..4502e10 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1578,7 +1578,8 @@ io_wait_dowork (struct context *c, const unsigned int flags)
 
 #ifdef ENABLE_ASYNC_PUSH
   /* arm inotify watcher */
-  event_ctl (c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void*)&file_shift);
+  if (c->options.mode == MODE_SERVER)
+    event_ctl (c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void*)&file_shift);
 #endif
 
   /*
-- 
1.9.1


