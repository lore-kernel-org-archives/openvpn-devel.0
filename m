From: Antonio Quartulli <a@...2181...>
Date: Thu, 26 Apr 2018 03:57:18 +0800
Message-Id: <20180425195722.20744-5-a@...2181...>
In-Reply-To: <20180425195722.20744-1-a@...2181...>
References: <20180425195722.20744-1-a@...2181...>
Subject: [Openvpn-devel] [RFC 4/8] io_work: pass event_arg object to event
 handler in case of socket event
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

In order to allow the code to work with multiple listening sockets
it is essential to allow the generic multi_io event handler
to distinguish between the various socket objects.

This can be achieved by passing an event_arg object that contains
a pointer to the link_socket.

This code path is used on clients as well as UDP servers.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/event.h   |  6 ++++++
 src/openvpn/forward.c | 25 +++++++++++++++++++++++--
 src/openvpn/mtcp.c    |  4 +---
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index be199ad9..fd0ede04 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -41,6 +41,12 @@
 #define EVENT_METHOD_US_TIMEOUT   (1<<0)
 #define EVENT_METHOD_FAST         (1<<1)
 
+/*
+ * The following constant is used as boundary between integer value
+ * and real addresses when passing arguments to event handlers as (void *)
+ */
+#define MULTI_N           ((void *)16) /* upper bound on MTCP_x */
+
 #ifdef _WIN32
 
 typedef const struct rw_handle *event_t;
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index a4e4d98a..1b5dad9b 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1714,7 +1714,8 @@ io_wait_dowork(struct context *c, const unsigned int flags)
     /*
      * Configure event wait based on socket, tuntap flags.
      */
-    socket_set(c->c2.link_socket, c->c2.event_set, socket, (void *)socket_shift, NULL);
+    socket_set(c->c2.link_socket, c->c2.event_set, socket,
+               &c->c2.link_socket->ev_arg, NULL);
     tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)tun_shift, NULL);
 
 #ifdef ENABLE_MANAGEMENT
@@ -1771,7 +1772,27 @@ io_wait_dowork(struct context *c, const unsigned int flags)
                 for (i = 0; i < status; ++i)
                 {
                     const struct event_set_return *e = &esr[i];
-                    c->c2.event_set_status |= ((e->rwflags & 3) << (uintptr_t)e->arg);
+                    uintptr_t shift;
+
+                    if (e->arg >= MULTI_N)
+                    {
+                        struct event_arg *ev_arg = (struct event_arg *)e->arg;
+                        if (ev_arg->type != EVENT_ARG_LINK_SOCKET)
+                        {
+                            c->c2.event_set_status = ES_ERROR;
+                            msg(D_LINK_ERRORS,
+                                "io_work: non socket event delivered");
+                            return;
+                        }
+
+                        shift = socket_shift;
+                    }
+                    else
+                    {
+                        shift = (uintptr_t)e->arg;
+                    }
+
+                    c->c2.event_set_status |= ((e->rwflags & 3) << shift);
                 }
             }
             else if (status == 0)
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 51f339d0..0be97ae4 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -68,8 +68,6 @@
 #define MTCP_FILE_CLOSE_WRITE ((void *)5)
 #endif
 
-#define MTCP_N           ((void *)16) /* upper bound on MTCP_x */
-
 struct ta_iow_flags
 {
     unsigned int flags;
@@ -682,7 +680,7 @@ multi_tcp_process_io(struct multi_context *m)
         struct event_arg *ev_arg = (struct event_arg *)e->arg;
 
         /* incoming data for instance or listening socket? */
-        if (e->arg >= MTCP_N)
+        if (e->arg >= MULTI_N)
         {
             switch (ev_arg->type)
             {
-- 
2.17.0


