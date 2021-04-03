From: Arne Schwabe <arne@...1227...>
Date: Sat,  3 Apr 2021 14:30:00 +0200
Message-Id: <20210403123000.17688-1-arne@...1227...>
In-Reply-To: <0210401131337.3684-14-arne@...1227...>
References: <0210401131337.3684-14-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v2] log file descriptor in more socket
 related error messages
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

This add the fd to the epoll event error message and the x_check_status
message. This helps debugging when thing go wrong with event handling.

Also add logging when ep_del fails to remove a socket from the structure.
In constract to ep_ctl that has this as a FATAL message (M_ERR), we only
log here since the code has been ignoring the status forever there might
be corner cases where a FATAL message could trigger an unintened regression.

PATCH v2: Fix wrong order of fd,code in printed message.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/error.c | 8 ++++----
 src/openvpn/event.c | 8 ++++++--
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index e6f7ff0ff..93091fce8 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -690,15 +690,15 @@ x_check_status(int status,
         {
             if (extended_msg)
             {
-                msg(x_cs_info_level, "%s %s [%s]: %s (code=%d)", description,
+                msg(x_cs_info_level, "%s %s [%s]: %s (fd=%d,code=%d)", description,
                     sock ? proto2ascii(sock->info.proto, sock->info.af, true) : "",
-                    extended_msg, strerror(my_errno), my_errno);
+                    extended_msg, strerror(my_errno), sock ? sock->sd : -1, my_errno);
             }
             else
             {
-                msg(x_cs_info_level, "%s %s: %s (code=%d)", description,
+                msg(x_cs_info_level, "%s %s: %s (fd=%d,code=%d)", description,
                     sock ? proto2ascii(sock->info.proto, sock->info.af, true) : "",
-                    strerror(my_errno), my_errno);
+                    strerror(my_errno), sock ? sock->sd : -1, my_errno);
             }
 
             if (x_cs_err_delay_ms)
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 49dfa861c..14a25155c 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -555,7 +555,10 @@ ep_del(struct event_set *es, event_t event)
 
     ASSERT(!eps->fast);
     CLEAR(ev);
-    epoll_ctl(eps->epfd, EPOLL_CTL_DEL, event, &ev);
+    if (epoll_ctl(eps->epfd, EPOLL_CTL_DEL, event, &ev) < 0)
+    {
+        msg(M_WARN|M_ERRNO, "EVENT: epoll_ctl EPOLL_CTL_DEL failed, sd=%d", (int)event);
+    }
 }
 
 static void
@@ -844,7 +847,8 @@ po_wait(struct event_set *es, const struct timeval *tv, struct event_set_return
             }
             else if (pfdp->revents)
             {
-                msg(D_EVENT_ERRORS, "Error: poll: unknown revents=0x%04x", (unsigned int)pfdp->revents);
+                msg(D_EVENT_ERRORS, "Error: poll: unknown revents=0x%04x for fd=%d",
+                    (unsigned int)pfdp->revents, pfdp->fd);
             }
             ++pfdp;
         }
-- 
2.30.1


