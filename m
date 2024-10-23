From: Gert Doering <gert@...1296...>
Date: Wed, 23 Oct 2024 10:08:52 +0200
Message-ID: <20241023080853.3710-1-gert@...1296...>
In-Reply-To: <gerrit.1727098847000.Icd7f6a2ad350cdc2312b3e80fa0dbdd7e4311d2e@...2715...>
References: <gerrit.1727098847000.Icd7f6a2ad350cdc2312b3e80fa0dbdd7e4311d2e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] event/multi: add event_arg object to
 make event handling more generic
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

From: Antonio Quartulli <a@...2181...>

In order to prepare the event handling code to deal with multiple
listening sockets, we have to make sure that it is possible to
distinguish which of these sockets have been poked by an incoming
connection request.

To achieve that, this patch changes the object being passed as
event handler argument, from a "partly integer-evaluated variable"
to a full struct with a proper type attribute.

This struct will allow the code to carry around the particular
listening socket where the connection is being established.

This change affects the TCP server code path only as UDP servers
use only one socket to handle all clients.

Change-Id: Icd7f6a2ad350cdc2312b3e80fa0dbdd7e4311d2e
Signed-off-by: Antonio Quartulli <a@...2181...>
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/757
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 856551a..844ea7b 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -126,6 +126,20 @@
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
index 96408d1..c002a38 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -54,7 +54,6 @@
 /*
  * Special tags passed to event.[ch] functions
  */
-#define MTCP_SOCKET      ((void *)1)
 #define MTCP_TUN         ((void *)2)
 #define MTCP_SIG         ((void *)3) /* Only on Windows */
 #define MTCP_MANAGEMENT ((void *)4)
@@ -253,7 +252,7 @@
         socket_set(mi->context.c2.link_socket,
                    m->mtcp->es,
                    mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,
-                   mi,
+                   &mi->ev_arg,
                    &mi->tcp_rwflags);
     }
 }
@@ -263,8 +262,8 @@
                struct multi_tcp *mtcp)
 {
     int status;
-    unsigned int *persistent = &mtcp->tun_rwflags;
-    socket_set_listen_persistent(c->c2.link_socket, mtcp->es, MTCP_SOCKET);
+    socket_set_listen_persistent(c->c2.link_socket, mtcp->es,
+                                 &c->c2.link_socket->ev_arg);
 
 #ifdef _WIN32
     if (tuntap_is_wintun(c->c1.tuntap))
@@ -280,7 +279,7 @@
         persistent = NULL;
     }
 #endif
-    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, persistent);
+    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, &mtcp->tun_rwflags);
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     dco_event_set(&c->c1.tuntap->dco, mtcp->es, MTCP_DCO);
 #endif
@@ -693,20 +692,43 @@
     {
         struct event_set_return *e = &mtcp->esr[i];
 
-        /* incoming data for instance? */
+        /* incoming data for instance or listening socket? */
         if (e->arg >= MTCP_N)
         {
-            struct multi_instance *mi = (struct multi_instance *) e->arg;
-            if (mi)
+            struct event_arg *ev_arg = (struct event_arg *)e->arg;
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
+
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
@@ -731,18 +753,6 @@
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
 #if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
             /* incoming data on DCO? */
             else if (e->arg == MTCP_DCO)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 0509911..45b3cfa 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -823,6 +823,9 @@
         goto err;
     }
 
+    mi->ev_arg.type = EVENT_ARG_MULTI_INSTANCE;
+    mi->ev_arg.u.mi = mi;
+
     perf_pop();
     gc_free(&gc);
     return mi;
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 7167639..1b99ef7 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -102,6 +102,12 @@
     struct schedule_entry se;  /* this must be the first element of the structure,
                                 * We cast between this and schedule_entry so the
                                 * beginning of the struct must be identical */
+
+    struct event_arg ev_arg;   /**< this struct will store a pointer to either mi or
+                                * link_socket, depending on the event type, to keep
+                                * it accessible it's placed within the same struct
+                                * it points to. */
+
     struct gc_arena gc;
     bool halt;
     int refcount;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 7b1e603..cf04090 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1830,6 +1830,8 @@
     ALLOC_OBJ_CLEAR(sock, struct link_socket);
     sock->sd = SOCKET_UNDEFINED;
     sock->ctrl_sd = SOCKET_UNDEFINED;
+    sock->ev_arg.type = EVENT_ARG_LINK_SOCKET;
+
     return sock;
 }
 
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 2e583af..c152ab0 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -178,6 +178,11 @@
 {
     struct link_socket_info info;
 
+    struct event_arg ev_arg;   /**< this struct will store a pointer to either mi or
+                                * link_socket, depending on the event type, to keep
+                                * it accessible it's placed within the same struct
+                                * it points to. */
+
     socket_descriptor_t sd;
     socket_descriptor_t ctrl_sd; /* only used for UDP over Socks */
 

