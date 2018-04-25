From: Antonio Quartulli <a@...2181...>
Date: Thu, 26 Apr 2018 03:57:15 +0800
Message-Id: <20180425195722.20744-2-a@...2181...>
In-Reply-To: <20180425195722.20744-1-a@...2181...>
References: <20180425195722.20744-1-a@...2181...>
Subject: [Openvpn-devel] [RFC 1/8] event/multi: add event_arg object to make
 event handling more generic
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

In order to prepare the event handling code to deal with multiple
listening sockets, we have to make sure that it is possible to
distinguish which of these sockets have been pocked by an incoming
connection request.

To achieve that, this patch changes the object being passed as
event handler argument, from a "partly integer evaluated variable"
to a full struct with a proper type attribute.

This struct will allow the code to carry around the particular
listening socket where the connection is being established.

This change affects the TCP server code path only as UDP servers
use only one socket to handle all clients i/o.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/event.h  | 14 ++++++++++
 src/openvpn/mtcp.c   | 62 +++++++++++++++++++++++++-------------------
 src/openvpn/multi.c  |  3 +++
 src/openvpn/multi.h  |  1 +
 src/openvpn/socket.c |  2 ++
 src/openvpn/socket.h |  2 ++
 6 files changed, 58 insertions(+), 26 deletions(-)

diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 4af6371e..33ff8890 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -85,6 +85,20 @@ struct event_set
     struct event_set_functions func;
 };
 
+typedef enum {
+    EVENT_ARG_MULTI_INSTANCE = 0,
+    EVENT_ARG_LINK_SOCKET,
+} event_arg_t;
+
+/* generic event argument object to pass to event_ctl() */
+struct event_arg
+{
+    event_arg_t type;
+    union {
+        struct multi_instance *mi; /* if type = EVENT_ARG_MULTI_INSTANCE */
+    } u;
+};
+
 /*
  * maxevents on input:  desired max number of event_t descriptors
  *                      simultaneously set with event_ctl
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 3756c270..234c077c 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -58,7 +58,6 @@
 /*
  * Special tags passed to event.[ch] functions
  */
-#define MTCP_SOCKET      ((void *)1)
 #define MTCP_TUN         ((void *)2)
 #define MTCP_SIG         ((void *)3) /* Only on Windows */
 #ifdef ENABLE_MANAGEMENT
@@ -259,7 +258,7 @@ multi_tcp_set_global_rw_flags(struct multi_context *m, struct multi_instance *mi
         socket_set(mi->context.c2.link_socket,
                    m->mtcp->es,
                    mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,
-                   mi,
+                   &mi->ev_arg,
                    &mi->tcp_rwflags);
     }
 }
@@ -269,7 +268,8 @@ multi_tcp_wait(const struct context *c,
                struct multi_tcp *mtcp)
 {
     int status;
-    socket_set_listen_persistent(c->c2.link_socket, mtcp->es, MTCP_SOCKET);
+    socket_set_listen_persistent(c->c2.link_socket, mtcp->es,
+                                 &c->c2.link_socket->ev_arg);
     tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, &mtcp->tun_rwflags);
 #ifdef ENABLE_MANAGEMENT
     if (management)
@@ -679,21 +679,43 @@ multi_tcp_process_io(struct multi_context *m)
     for (i = 0; i < mtcp->n_esr; ++i)
     {
         struct event_set_return *e = &mtcp->esr[i];
+        struct event_arg *ev_arg = (struct event_arg *)e->arg;
 
-        /* incoming data for instance? */
+        /* incoming data for instance or listening socket? */
         if (e->arg >= MTCP_N)
         {
-            struct multi_instance *mi = (struct multi_instance *) e->arg;
-            if (mi)
+            switch (ev_arg->type)
             {
-                if (e->rwflags & EVENT_WRITE)
-                {
-                    multi_tcp_action(m, mi, TA_SOCKET_WRITE_READY, false);
-                }
-                else if (e->rwflags & EVENT_READ)
-                {
-                    multi_tcp_action(m, mi, TA_SOCKET_READ, false);
-                }
+                struct multi_instance *mi;
+
+                /* react to event on child instance */
+                case EVENT_ARG_MULTI_INSTANCE:
+                    if (!ev_arg->u.mi)
+                    {
+                        msg(D_MULTI_ERRORS, "MULTI: mtcp_proc_io: null minstance");
+                        break;
+                    }
+
+                    mi = ev_arg->u.mi;
+                    if (e->rwflags & EVENT_WRITE)
+                    {
+                        multi_tcp_action(m, mi, TA_SOCKET_WRITE_READY, false);
+                    }
+                    else if (e->rwflags & EVENT_READ)
+                    {
+                        multi_tcp_action(m, mi, TA_SOCKET_READ, false);
+                    }
+                    break;
+                /* new incoming TCP client attempting to connect? */
+                case EVENT_ARG_LINK_SOCKET:
+                    ASSERT(m->top.c2.link_socket);
+                    socket_reset_listen_persistent(m->top.c2.link_socket);
+                    mi = multi_create_instance_tcp(m);
+                    if (mi)
+                    {
+                        multi_tcp_action(m, mi, TA_INITIAL, false);
+                    }
+                    break;
             }
         }
         else
@@ -718,18 +740,6 @@ multi_tcp_process_io(struct multi_context *m)
                     multi_tcp_action(m, NULL, TA_TUN_READ, false);
                 }
             }
-            /* new incoming TCP client attempting to connect? */
-            else if (e->arg == MTCP_SOCKET)
-            {
-                struct multi_instance *mi;
-                ASSERT(m->top.c2.link_socket);
-                socket_reset_listen_persistent(m->top.c2.link_socket);
-                mi = multi_create_instance_tcp(m);
-                if (mi)
-                {
-                    multi_tcp_action(m, mi, TA_INITIAL, false);
-                }
-            }
             /* signal received? */
             else if (e->arg == MTCP_SIG)
             {
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3da8c110..f877c060 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -841,6 +841,9 @@ multi_create_instance(struct multi_context *m, const struct mroute_addr *real)
         goto err;
     }
 
+    mi->ev_arg.type = EVENT_ARG_MULTI_INSTANCE;
+    mi->ev_arg.u.mi = mi;
+
     perf_pop();
     gc_free(&gc);
     return mi;
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index d7e5c298..c52445ed 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -75,6 +75,7 @@ struct deferred_signal_schedule_entry
  */
 struct multi_instance {
     struct schedule_entry se;  /* this must be the first element of the structure */
+    struct event_arg ev_arg;
     struct gc_arena gc;
     bool defined;
     bool halt;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 211e7441..e0620f09 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1712,6 +1712,8 @@ link_socket_new(void)
     ALLOC_OBJ_CLEAR(sock, struct link_socket);
     sock->sd = SOCKET_UNDEFINED;
     sock->ctrl_sd = SOCKET_UNDEFINED;
+    sock->ev_arg.type = EVENT_ARG_LINK_SOCKET;
+
     return sock;
 }
 
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 479d1150..46000246 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -165,6 +165,8 @@ struct link_socket
 {
     struct link_socket_info info;
 
+    struct event_arg ev_arg;
+
     socket_descriptor_t sd;
     socket_descriptor_t ctrl_sd; /* only used for UDP over Socks */
 
-- 
2.17.0


