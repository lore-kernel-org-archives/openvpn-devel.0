From: Antonio Quartulli <a@...2181...>
Date: Thu, 26 Apr 2018 03:57:17 +0800
Message-Id: <20180425195722.20744-4-a@...2181...>
In-Reply-To: <20180425195722.20744-1-a@...2181...>
References: <20180425195722.20744-1-a@...2181...>
Subject: [Openvpn-devel] [RFC 3/8] io_work: convert shift argument to
 uintptr_t
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
Cc: Antonio Quartulli <a@...2181...>

Instead of passing the shift argument as pointer, pass
directly its integer value. This will allow the code to
distinguish a shift value from a real object pointer,
like we already do in multi_tcp_process_io().

This change will allow us later to pass an event_arg
object as event handler argument instead of a simple
integer value.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/forward.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index c5ddf385..a4e4d98a 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1607,11 +1607,11 @@ io_wait_dowork(struct context *c, const unsigned int flags)
     struct event_set_return esr[4];
 
     /* These shifts all depend on EVENT_READ and EVENT_WRITE */
-    static int socket_shift = 0;   /* depends on SOCKET_READ and SOCKET_WRITE */
-    static int tun_shift = 2;      /* depends on TUN_READ and TUN_WRITE */
-    static int err_shift = 4;      /* depends on ES_ERROR */
+    static uintptr_t socket_shift = 0;   /* depends on SOCKET_READ and SOCKET_WRITE */
+    static uintptr_t tun_shift = 2;      /* depends on TUN_READ and TUN_WRITE */
+    static uintptr_t err_shift = 4;      /* depends on ES_ERROR */
 #ifdef ENABLE_MANAGEMENT
-    static int management_shift = 6; /* depends on MANAGEMENT_READ and MANAGEMENT_WRITE */
+    static uintptr_t management_shift = 6; /* depends on MANAGEMENT_READ and MANAGEMENT_WRITE */
 #endif
 #ifdef ENABLE_ASYNC_PUSH
     static int file_shift = 8;     /* listening inotify events */
@@ -1628,7 +1628,7 @@ io_wait_dowork(struct context *c, const unsigned int flags)
      */
     if (flags & IOW_WAIT_SIGNAL)
     {
-        wait_signal(c->c2.event_set, (void *)&err_shift);
+        wait_signal(c->c2.event_set, (void *)err_shift);
     }
 
     /*
@@ -1714,13 +1714,13 @@ io_wait_dowork(struct context *c, const unsigned int flags)
     /*
      * Configure event wait based on socket, tuntap flags.
      */
-    socket_set(c->c2.link_socket, c->c2.event_set, socket, (void *)&socket_shift, NULL);
-    tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)&tun_shift, NULL);
+    socket_set(c->c2.link_socket, c->c2.event_set, socket, (void *)socket_shift, NULL);
+    tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)tun_shift, NULL);
 
 #ifdef ENABLE_MANAGEMENT
     if (management)
     {
-        management_socket_set(management, c->c2.event_set, (void *)&management_shift, NULL);
+        management_socket_set(management, c->c2.event_set, (void *)management_shift, NULL);
     }
 #endif
 
@@ -1728,7 +1728,7 @@ io_wait_dowork(struct context *c, const unsigned int flags)
     /* arm inotify watcher */
     if (c->options.mode == MODE_SERVER)
     {
-        event_ctl(c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void *)&file_shift);
+        event_ctl(c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void *)file_shift);
     }
 #endif
 
@@ -1771,7 +1771,7 @@ io_wait_dowork(struct context *c, const unsigned int flags)
                 for (i = 0; i < status; ++i)
                 {
                     const struct event_set_return *e = &esr[i];
-                    c->c2.event_set_status |= ((e->rwflags & 3) << *((int *)e->arg));
+                    c->c2.event_set_status |= ((e->rwflags & 3) << (uintptr_t)e->arg);
                 }
             }
             else if (status == 0)
-- 
2.17.0


