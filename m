From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 30 Dec 2024 13:35:11 +0000
In-Reply-To: <gerrit.1727098847000.I1e5a84969988e4f027a18658d4ab268c13fbf929@...2715...>
References: <gerrit.1727098847000.I1e5a84969988e4f027a18658d4ab268c13fbf929@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c801c6c384b81077c77719fe7fff936828929a15-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VJrXqHgi6vg="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: multiproto: move
 generic event handling code in dedicated files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VJrXqHgi6vg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/763?usp=3Demail

to look at the new patch set (#10).


Change subject: multiproto: move generic event handling code in dedicated f=
iles
......................................................................

multiproto: move generic event handling code in dedicated files

    Introduced multi_io.h and multi_io.c files to centralize
    all codes related to multiple protocols.

    Renamed the struct mtcp to struct multi_protocol since it
    encompasses the event_set used by the parent context in server mode.

    Several methods have also been renamed and moved to fit the
    multiproto structure:

    - multi_tcp_init() -> multi_protocol_init();
    - multi_tcp_free() -> multi_protocol_free();
    - multi_tcp_wait() -> multi_protocol_io_wait();
    and so forth.

Change-Id: I1e5a84969988e4f027a18658d4ab268c13fbf929
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M CMakeLists.txt
M src/openvpn/Makefile.am
M src/openvpn/forward.h
M src/openvpn/init.c
M src/openvpn/init.h
M src/openvpn/mtcp.c
M src/openvpn/mtcp.h
M src/openvpn/mudp.c
M src/openvpn/mudp.h
M src/openvpn/multi.c
M src/openvpn/multi.h
A src/openvpn/multi_io.c
A src/openvpn/multi_io.h
13 files changed, 765 insertions(+), 632 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/763/10

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 9ffcc89..ea8d006 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -458,6 +458,8 @@
     src/openvpn/mudp.h
     src/openvpn/multi.c
     src/openvpn/multi.h
+    src/openvpn/multi_io.h
+    src/openvpn/multi_io.c
     src/openvpn/ntlm.c
     src/openvpn/ntlm.h
     src/openvpn/occ.c
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index d6d6592..37af683 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -93,6 +93,7 @@
 	mtu.c mtu.h \
 	mudp.c mudp.h \
 	multi.c multi.h \
+	multi_io.c multi_io.h \
 	networking_freebsd.c \
 	networking_iproute2.c networking_iproute2.h \
 	networking_sitnl.c networking_sitnl.h \
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index ca2a695..214a322 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -50,6 +50,7 @@
 #include "openvpn.h"
 #include "occ.h"
 #include "ping.h"
+#include "multi_io.h"

 #define IOW_TO_TUN          (1<<0)
 #define IOW_TO_LINK         (1<<1)
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 86378f7..4d1cef0 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4923,7 +4923,7 @@
 void
 inherit_context_child(struct context *dest,
                       const struct context *src,
-                      struct link_socket *ls)
+                      struct link_socket *sock)
 {
     CLEAR(*dest);

@@ -4962,7 +4962,7 @@
          * The CM_TOP context does the socket listen(),
          * and the CM_CHILD_TCP context does the accept().
          */
-        dest->c2.accept_from =3D ls;
+        dest->c2.accept_from =3D sock;
     }

 #ifdef ENABLE_PLUGIN
@@ -4989,11 +4989,11 @@
         ALLOC_ARRAY_GC(dest->c2.link_sockets, struct link_socket *, 1, &de=
st->gc);

         /* inherit parent link_socket and tuntap */
-        dest->c2.link_sockets[0] =3D ls;
+        dest->c2.link_sockets[0] =3D sock;

         ALLOC_ARRAY_GC(dest->c2.link_socket_infos, struct link_socket_info=
 *, 1, &dest->gc);
         ALLOC_OBJ_GC(dest->c2.link_socket_infos[0], struct link_socket_inf=
o, &dest->gc);
-        *dest->c2.link_socket_infos[0] =3D ls->info;
+        *dest->c2.link_socket_infos[0] =3D sock->info;

         /* locally override some link_socket_info fields */
         dest->c2.link_socket_infos[0]->lsa =3D &dest->c1.link_socket_addrs=
[0];
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 11c32ac..50b38e3 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -96,7 +96,7 @@

 void inherit_context_child(struct context *dest,
                            const struct context *src,
-                           struct link_socket *ls);
+                           struct link_socket *sock);

 void inherit_context_top(struct context *dest,
                          const struct context *src);
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index b5bbf13..1dae184 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -29,6 +29,8 @@

 #include "multi.h"
 #include "forward.h"
+#include "mtcp.h"
+#include "multi_io.h"

 #include "memdbg.h"

@@ -36,30 +38,6 @@
 #include <sys/inotify.h>
 #endif

-/*
- * TCP States
- */
-#define TA_UNDEF                 0
-#define TA_SOCKET_READ           1
-#define TA_SOCKET_READ_RESIDUAL  2
-#define TA_SOCKET_WRITE          3
-#define TA_SOCKET_WRITE_READY    4
-#define TA_SOCKET_WRITE_DEFERRED 5
-#define TA_TUN_READ              6
-#define TA_TUN_WRITE             7
-#define TA_INITIAL               8
-#define TA_TIMEOUT               9
-#define TA_TUN_WRITE_TIMEOUT     10
-
-/*
- * Special tags passed to event.[ch] functions
- */
-#define MTCP_TUN         ((void *)2)
-#define MTCP_SIG         ((void *)3) /* Only on Windows */
-#define MTCP_MANAGEMENT ((void *)4)
-#define MTCP_FILE_CLOSE_WRITE ((void *)5)
-#define MTCP_DCO        ((void *)6)
-
 struct ta_iow_flags
 {
     unsigned int flags;
@@ -68,59 +46,14 @@
     unsigned int sock;
 };

-#ifdef ENABLE_DEBUG
-static const char *
-pract(int action)
-{
-    switch (action)
-    {
-        case TA_UNDEF:
-            return "TA_UNDEF";
-
-        case TA_SOCKET_READ:
-            return "TA_SOCKET_READ";
-
-        case TA_SOCKET_READ_RESIDUAL:
-            return "TA_SOCKET_READ_RESIDUAL";
-
-        case TA_SOCKET_WRITE:
-            return "TA_SOCKET_WRITE";
-
-        case TA_SOCKET_WRITE_READY:
-            return "TA_SOCKET_WRITE_READY";
-
-        case TA_SOCKET_WRITE_DEFERRED:
-            return "TA_SOCKET_WRITE_DEFERRED";
-
-        case TA_TUN_READ:
-            return "TA_TUN_READ";
-
-        case TA_TUN_WRITE:
-            return "TA_TUN_WRITE";
-
-        case TA_INITIAL:
-            return "TA_INITIAL";
-
-        case TA_TIMEOUT:
-            return "TA_TIMEOUT";
-
-        case TA_TUN_WRITE_TIMEOUT:
-            return "TA_TUN_WRITE_TIMEOUT";
-
-        default:
-            return "?";
-    }
-}
-#endif /* ENABLE_DEBUG */
-
-static struct multi_instance *
-multi_create_instance_tcp(struct multi_context *m, struct link_socket *ls)
+struct multi_instance *
+multi_create_instance_tcp(struct multi_context *m, struct link_socket *soc=
k)
 {
     struct gc_arena gc =3D gc_new();
     struct multi_instance *mi =3D NULL;
     struct hash *hash =3D m->hash;

-    mi =3D multi_create_instance(m, NULL, ls);
+    mi =3D multi_create_instance(m, NULL, sock);
     if (mi)
     {
         struct hash_element *he;
@@ -193,126 +126,42 @@
     mbuf_free(mi->tcp_link_out_deferred);
 }

-struct multi_tcp *
-multi_tcp_init(int maxevents, int *maxclients)
-{
-    struct multi_tcp *mtcp;
-    const int extra_events =3D BASE_N_EVENTS;
-
-    ASSERT(maxevents >=3D 1);
-    ASSERT(maxclients);
-
-    ALLOC_OBJ_CLEAR(mtcp, struct multi_tcp);
-    mtcp->maxevents =3D maxevents + extra_events;
-    mtcp->es =3D event_set_init(&mtcp->maxevents, 0);
-    wait_signal(mtcp->es, MTCP_SIG);
-    ALLOC_ARRAY(mtcp->esr, struct event_set_return, mtcp->maxevents);
-    *maxclients =3D max_int(min_int(mtcp->maxevents - extra_events, *maxcl=
ients), 1);
-    msg(D_MULTI_LOW, "MULTI: TCP INIT maxclients=3D%d maxevents=3D%d", *ma=
xclients, mtcp->maxevents);
-    return mtcp;
-}
-
 void
-multi_tcp_delete_event(struct multi_tcp *mtcp, event_t event)
+multi_tcp_delete_event(struct multi_protocol *multi_io, event_t event)
 {
-    if (mtcp && mtcp->es)
+    if (multi_io && multi_io->es)
     {
-        event_del(mtcp->es, event);
+        event_del(multi_io->es, event);
     }
 }

 void
-multi_tcp_free(struct multi_tcp *mtcp)
+multi_tcp_dereference_instance(struct multi_protocol *multi_io, struct mul=
ti_instance *mi)
 {
-    if (mtcp)
+    struct link_socket *sock =3D mi->context.c2.link_sockets[0];
+    if (sock && mi->socket_set_called)
     {
-        event_free(mtcp->es);
-        free(mtcp->esr);
-        free(mtcp);
-    }
-}
-
-void
-multi_tcp_dereference_instance(struct multi_tcp *mtcp, struct multi_instan=
ce *mi)
-{
-    struct link_socket *ls =3D mi->context.c2.link_sockets[0];
-    if (ls && mi->socket_set_called)
-    {
-        event_del(mtcp->es, socket_event_handle(ls));
+        event_del(multi_io->es, socket_event_handle(sock));
         mi->socket_set_called =3D false;
     }
-    mtcp->n_esr =3D 0;
+    multi_io->n_esr =3D 0;
 }

-static inline void
+void
 multi_tcp_set_global_rw_flags(struct multi_context *m, struct multi_instan=
ce *mi)
 {
     if (mi)
     {
         mi->socket_set_called =3D true;
         socket_set(mi->context.c2.link_sockets[0],
-                   m->mtcp->es,
+                   m->multi_io->es,
                    mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE :=
 EVENT_READ,
                    &mi->ev_arg,
                    &mi->tcp_rwflags);
     }
 }

-static inline int
-multi_tcp_wait(const struct context *c,
-               struct multi_tcp *mtcp)
-{
-    int status;
-    unsigned int *persistent =3D &mtcp->tun_rwflags;
-
-    for (int i =3D 0; i < c->c1.link_sockets_num; i++)
-    {
-        socket_set_listen_persistent(c->c2.link_sockets[i], mtcp->es,
-                                     &c->c2.link_sockets[i]->ev_arg);
-    }
-
-#ifdef _WIN32
-    if (tuntap_is_wintun(c->c1.tuntap))
-    {
-        if (!tuntap_ring_empty(c->c1.tuntap))
-        {
-            /* there is data in wintun ring buffer, read it immediately */
-            mtcp->esr[0].arg =3D MTCP_TUN;
-            mtcp->esr[0].rwflags =3D EVENT_READ;
-            mtcp->n_esr =3D 1;
-            return 1;
-        }
-        persistent =3D NULL;
-    }
-#endif
-    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, persistent);
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
-    dco_event_set(&c->c1.tuntap->dco, mtcp->es, MTCP_DCO);
-#endif
-
-#ifdef ENABLE_MANAGEMENT
-    if (management)
-    {
-        management_socket_set(management, mtcp->es, MTCP_MANAGEMENT, &mtcp=
->management_persist_flags);
-    }
-#endif
-
-#ifdef ENABLE_ASYNC_PUSH
-    /* arm inotify watcher */
-    event_ctl(mtcp->es, c->c2.inotify_fd, EVENT_READ, MTCP_FILE_CLOSE_WRIT=
E);
-#endif
-
-    status =3D event_wait(mtcp->es, &c->c2.timeval, mtcp->esr, mtcp->maxev=
ents);
-    update_time();
-    mtcp->n_esr =3D 0;
-    if (status > 0)
-    {
-        mtcp->n_esr =3D status;
-    }
-    return status;
-}
-
-static inline struct context *
+struct context *
 multi_tcp_context(struct multi_context *m, struct multi_instance *mi)
 {
     if (mi)
@@ -325,7 +174,7 @@
     }
 }

-static bool
+bool
 multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct mult=
i_instance *mi, const unsigned int mpp_flags)
 {
     struct mbuf_item item;
@@ -349,7 +198,7 @@
     return ret;
 }

-static bool
+bool
 multi_tcp_process_outgoing_link(struct multi_context *m, bool defer, const=
 unsigned int mpp_flags)
 {
     struct multi_instance *mi =3D multi_process_outgoing_link_pre(m);
@@ -393,417 +242,6 @@
     return ret;
 }

-static int
-multi_tcp_wait_lite(struct multi_context *m, struct multi_instance *mi, co=
nst int action, bool *tun_input_pending)
-{
-    struct context *c =3D multi_tcp_context(m, mi);
-    unsigned int looking_for =3D 0;
-
-    dmsg(D_MULTI_DEBUG, "MULTI TCP: multi_tcp_wait_lite a=3D%s mi=3D" ptr_=
format,
-         pract(action),
-         (ptr_type)mi);
-
-    tv_clear(&c->c2.timeval); /* ZERO-TIMEOUT */
-
-    switch (action)
-    {
-        case TA_TUN_READ:
-            looking_for =3D TUN_READ;
-            tun_input_pending =3D NULL;
-            io_wait(c, IOW_READ_TUN);
-            break;
-
-        case TA_SOCKET_READ:
-            looking_for =3D SOCKET_READ;
-            tun_input_pending =3D NULL;
-            io_wait(c, IOW_READ_LINK);
-            break;
-
-        case TA_TUN_WRITE:
-            looking_for =3D TUN_WRITE;
-            tun_input_pending =3D NULL;
-            c->c2.timeval.tv_sec =3D 1; /* For some reason, the Linux 2.2 =
TUN/TAP driver hits this timeout */
-            perf_push(PERF_PROC_OUT_TUN_MTCP);
-            io_wait(c, IOW_TO_TUN);
-            perf_pop();
-            break;
-
-        case TA_SOCKET_WRITE:
-            looking_for =3D SOCKET_WRITE;
-            io_wait(c, IOW_TO_LINK|IOW_READ_TUN_FORCE);
-            break;
-
-        default:
-            msg(M_FATAL, "MULTI TCP: multi_tcp_wait_lite, unhandled action=
=3D%d", action);
-    }
-
-    if (tun_input_pending && (c->c2.event_set_status & TUN_READ))
-    {
-        *tun_input_pending =3D true;
-    }
-
-    if (c->c2.event_set_status & looking_for)
-    {
-        return action;
-    }
-    else
-    {
-        switch (action)
-        {
-            /* TCP socket output buffer is full */
-            case TA_SOCKET_WRITE:
-                return TA_SOCKET_WRITE_DEFERRED;
-
-            /* TUN device timed out on accepting write */
-            case TA_TUN_WRITE:
-                return TA_TUN_WRITE_TIMEOUT;
-        }
-
-        return TA_UNDEF;
-    }
-}
-
-static struct multi_instance *
-multi_tcp_dispatch(struct multi_context *m, struct multi_instance *mi, con=
st int action)
-{
-    const unsigned int mpp_flags =3D MPP_PRE_SELECT|MPP_RECORD_TOUCH;
-    struct multi_instance *touched =3D mi;
-    m->mpp_touched =3D &touched;
-
-    dmsg(D_MULTI_DEBUG, "MULTI TCP: multi_tcp_dispatch a=3D%s mi=3D" ptr_f=
ormat,
-         pract(action),
-         (ptr_type)mi);
-
-    switch (action)
-    {
-        case TA_TUN_READ:
-            read_incoming_tun(&m->top);
-            if (!IS_SIG(&m->top))
-            {
-                multi_process_incoming_tun(m, mpp_flags);
-            }
-            break;
-
-        case TA_SOCKET_READ:
-        case TA_SOCKET_READ_RESIDUAL:
-            ASSERT(mi);
-            ASSERT(mi->context.c2.link_sockets);
-            ASSERT(mi->context.c2.link_sockets[0]);
-            set_prefix(mi);
-            read_incoming_link(&mi->context, mi->context.c2.link_sockets[0=
]);
-            clear_prefix();
-            if (!IS_SIG(&mi->context))
-            {
-                multi_process_incoming_link(m, mi, mpp_flags,
-                                            mi->context.c2.link_sockets[0]=
);
-                if (!IS_SIG(&mi->context))
-                {
-                    stream_buf_read_setup(mi->context.c2.link_sockets[0]);
-                }
-            }
-            break;
-
-        case TA_TIMEOUT:
-            multi_process_timeout(m, mpp_flags);
-            break;
-
-        case TA_TUN_WRITE:
-            multi_process_outgoing_tun(m, mpp_flags);
-            break;
-
-        case TA_TUN_WRITE_TIMEOUT:
-            multi_process_drop_outgoing_tun(m, mpp_flags);
-            break;
-
-        case TA_SOCKET_WRITE_READY:
-            ASSERT(mi);
-            multi_tcp_process_outgoing_link_ready(m, mi, mpp_flags);
-            break;
-
-        case TA_SOCKET_WRITE:
-            multi_tcp_process_outgoing_link(m, false, mpp_flags);
-            break;
-
-        case TA_SOCKET_WRITE_DEFERRED:
-            multi_tcp_process_outgoing_link(m, true, mpp_flags);
-            break;
-
-        case TA_INITIAL:
-            ASSERT(mi);
-            multi_tcp_set_global_rw_flags(m, mi);
-            multi_process_post(m, mi, mpp_flags);
-            break;
-
-        default:
-            msg(M_FATAL, "MULTI TCP: multi_tcp_dispatch, unhandled action=
=3D%d", action);
-    }
-
-    m->mpp_touched =3D NULL;
-    return touched;
-}
-
-static int
-multi_tcp_post(struct multi_context *m, struct multi_instance *mi, const i=
nt action)
-{
-    struct context *c =3D multi_tcp_context(m, mi);
-    int newaction =3D TA_UNDEF;
-
-#define MTP_NONE         0
-#define MTP_TUN_OUT      (1<<0)
-#define MTP_LINK_OUT     (1<<1)
-    unsigned int flags =3D MTP_NONE;
-
-    if (TUN_OUT(c))
-    {
-        flags |=3D MTP_TUN_OUT;
-    }
-    if (LINK_OUT(c))
-    {
-        flags |=3D MTP_LINK_OUT;
-    }
-
-    switch (flags)
-    {
-        case MTP_TUN_OUT|MTP_LINK_OUT:
-        case MTP_TUN_OUT:
-            newaction =3D TA_TUN_WRITE;
-            break;
-
-        case MTP_LINK_OUT:
-            newaction =3D TA_SOCKET_WRITE;
-            break;
-
-        case MTP_NONE:
-            if (mi && sockets_read_residual(c))
-            {
-                newaction =3D TA_SOCKET_READ_RESIDUAL;
-            }
-            else
-            {
-                multi_tcp_set_global_rw_flags(m, mi);
-            }
-            break;
-
-        default:
-        {
-            struct gc_arena gc =3D gc_new();
-            msg(M_FATAL, "MULTI TCP: multi_tcp_post bad state, mi=3D%s fla=
gs=3D%d",
-                multi_instance_string(mi, false, &gc),
-                flags);
-            gc_free(&gc);
-            break;
-        }
-    }
-
-    dmsg(D_MULTI_DEBUG, "MULTI TCP: multi_tcp_post %s -> %s",
-         pract(action),
-         pract(newaction));
-
-    return newaction;
-}
-
-static void
-multi_tcp_action(struct multi_context *m, struct multi_instance *mi, int a=
ction, bool poll)
-{
-    bool tun_input_pending =3D false;
-
-    do
-    {
-        dmsg(D_MULTI_DEBUG, "MULTI TCP: multi_tcp_action a=3D%s p=3D%d",
-             pract(action),
-             poll);
-
-        /*
-         * If TA_SOCKET_READ_RESIDUAL, it means we still have pending
-         * input packets which were read by a prior TCP recv.
-         *
-         * Otherwise do a "lite" wait, which means we wait with 0 timeout
-         * on I/O events only related to the current instance, not
-         * the big list of events.
-         *
-         * On our first pass, poll will be false because we already know
-         * that input is available, and to call io_wait would be redundant.
-         */
-        if (poll && action !=3D TA_SOCKET_READ_RESIDUAL)
-        {
-            const int orig_action =3D action;
-            action =3D multi_tcp_wait_lite(m, mi, action, &tun_input_pendi=
ng);
-            if (action =3D=3D TA_UNDEF)
-            {
-                msg(M_FATAL, "MULTI TCP: I/O wait required blocking in mul=
ti_tcp_action, action=3D%d", orig_action);
-            }
-        }
-
-        /*
-         * Dispatch the action
-         */
-        struct multi_instance *touched =3D multi_tcp_dispatch(m, mi, actio=
n);
-
-        /*
-         * Signal received or TCP connection
-         * reset by peer?
-         */
-        if (touched && IS_SIG(&touched->context))
-        {
-            if (mi =3D=3D touched)
-            {
-                mi =3D NULL;
-            }
-            multi_close_instance_on_signal(m, touched);
-        }
-
-
-        /*
-         * If dispatch produced any pending output
-         * for a particular instance, point to
-         * that instance.
-         */
-        if (m->pending)
-        {
-            mi =3D m->pending;
-        }
-
-        /*
-         * Based on the effects of the action,
-         * such as generating pending output,
-         * possibly transition to a new action state.
-         */
-        action =3D multi_tcp_post(m, mi, action);
-
-        /*
-         * If we are finished processing the original action,
-         * check if we have any TUN input.  If so, transition
-         * our action state to processing this input.
-         */
-        if (tun_input_pending && action =3D=3D TA_UNDEF)
-        {
-            action =3D TA_TUN_READ;
-            mi =3D NULL;
-            tun_input_pending =3D false;
-            poll =3D false;
-        }
-        else
-        {
-            poll =3D true;
-        }
-
-    } while (action !=3D TA_UNDEF);
-}
-
-static void
-multi_tcp_process_io(struct multi_context *m)
-{
-    struct multi_tcp *mtcp =3D m->mtcp;
-    int i;
-
-    for (i =3D 0; i < mtcp->n_esr; ++i)
-    {
-        struct event_set_return *e =3D &mtcp->esr[i];
-
-        /* incoming data for instance or listening socket? */
-        if (e->arg >=3D MULTI_N)
-        {
-            struct event_arg *ev_arg =3D (struct event_arg *)e->arg;
-            switch (ev_arg->type)
-            {
-                struct multi_instance *mi;
-
-                /* react to event on child instance */
-                case EVENT_ARG_MULTI_INSTANCE:
-                    if (!ev_arg->u.mi)
-                    {
-                        msg(D_MULTI_ERRORS, "MULTI: mtcp_proc_io: null min=
stance");
-                        break;
-                    }
-
-                    mi =3D ev_arg->u.mi;
-                    if (e->rwflags & EVENT_WRITE)
-                    {
-                        multi_tcp_action(m, mi, TA_SOCKET_WRITE_READY, fal=
se);
-                    }
-                    else if (e->rwflags & EVENT_READ)
-                    {
-                        multi_tcp_action(m, mi, TA_SOCKET_READ, false);
-                    }
-                    break;
-
-                /* new incoming TCP client attempting to connect? */
-                case EVENT_ARG_LINK_SOCKET:
-                    if (!ev_arg->u.sock)
-                    {
-                        msg(D_MULTI_ERRORS, "MULTI: mtcp_proc_io: null soc=
ket");
-                        break;
-                    }
-
-                    socket_reset_listen_persistent(ev_arg->u.sock);
-                    mi =3D multi_create_instance_tcp(m, ev_arg->u.sock);
-                    if (mi)
-                    {
-                        multi_tcp_action(m, mi, TA_INITIAL, false);
-                    }
-                    break;
-            }
-        }
-        else
-        {
-#ifdef ENABLE_MANAGEMENT
-            if (e->arg =3D=3D MTCP_MANAGEMENT)
-            {
-                ASSERT(management);
-                management_io(management);
-            }
-            else
-#endif
-            /* incoming data on TUN? */
-            if (e->arg =3D=3D MTCP_TUN)
-            {
-                if (e->rwflags & EVENT_WRITE)
-                {
-                    multi_tcp_action(m, NULL, TA_TUN_WRITE, false);
-                }
-                else if (e->rwflags & EVENT_READ)
-                {
-                    multi_tcp_action(m, NULL, TA_TUN_READ, false);
-                }
-            }
-#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBS=
D))
-            /* incoming data on DCO? */
-            else if (e->arg =3D=3D MTCP_DCO)
-            {
-                multi_process_incoming_dco(m);
-            }
-#endif
-            /* signal received? */
-            else if (e->arg =3D=3D MTCP_SIG)
-            {
-                get_signal(&m->top.sig->signal_received);
-            }
-#ifdef ENABLE_ASYNC_PUSH
-            else if (e->arg =3D=3D MTCP_FILE_CLOSE_WRITE)
-            {
-                multi_process_file_closed(m, MPP_PRE_SELECT | MPP_RECORD_T=
OUCH);
-            }
-#endif
-        }
-        if (IS_SIG(&m->top))
-        {
-            break;
-        }
-    }
-    mtcp->n_esr =3D 0;
-
-    /*
-     * Process queued mbuf packets destined for TCP socket
-     */
-    {
-        struct multi_instance *mi;
-        while (!IS_SIG(&m->top) && (mi =3D mbuf_peek(m->mbuf)) !=3D NULL)
-        {
-            multi_tcp_action(m, mi, TA_SOCKET_WRITE, true);
-        }
-    }
-}
-
 /*
  * Top level event loop for single-threaded operation.
  * TCP mode.
@@ -851,7 +289,7 @@

         /* wait on tun/socket list */
         multi_get_timeout(&multi, &multi.top.c2.timeval);
-        status =3D multi_tcp_wait(&multi.top, multi.mtcp);
+        status =3D multi_protocol_io_wait(&multi);
         MULTI_CHECK_SIG(&multi);

         /* check on status of coarse timers */
@@ -861,12 +299,12 @@
         if (status > 0)
         {
             /* process the I/O which triggered select */
-            multi_tcp_process_io(&multi);
+            multi_protocol_process_io(&multi);
             MULTI_CHECK_SIG(&multi);
         }
         else if (status =3D=3D 0)
         {
-            multi_tcp_action(&multi, NULL, TA_TIMEOUT, false);
+            multi_protocol_action(&multi, NULL, TA_TIMEOUT, false);
         }

         perf_pop();
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index ab968e9..b9f73d4 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -30,34 +30,28 @@

 #include "event.h"

-/*
- * Extra state info needed for TCP mode
- */
-struct multi_tcp
-{
-    struct event_set *es;
-    struct event_set_return *esr;
-    int n_esr;
-    int maxevents;
-    unsigned int tun_rwflags;
-#ifdef ENABLE_MANAGEMENT
-    unsigned int management_persist_flags;
-#endif
-};
-
 struct multi_instance;
 struct context;

-struct multi_tcp *multi_tcp_init(int maxevents, int *maxclients);
-
-void multi_tcp_free(struct multi_tcp *mtcp);
-
-void multi_tcp_dereference_instance(struct multi_tcp *mtcp, struct multi_i=
nstance *mi);
+void multi_tcp_dereference_instance(struct multi_protocol *multi_io, struc=
t multi_instance *mi);

 bool multi_tcp_instance_specific_init(struct multi_context *m, struct mult=
i_instance *mi);

 void multi_tcp_instance_specific_free(struct multi_instance *mi);

+struct context *multi_tcp_context(struct multi_context *m, struct multi_in=
stance *mi);
+
+void multi_tcp_set_global_rw_flags(struct multi_context *m, struct multi_i=
nstance *mi);
+
+bool multi_tcp_process_outgoing_link(struct multi_context *m, bool defer, =
const unsigned int mpp_flags);
+
+bool multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct=
 multi_instance *mi, const unsigned int mpp_flags);
+
+struct multi_instance *multi_create_instance_tcp(struct multi_context *m, =
struct link_socket *sock);
+
+void multi_tcp_link_out_deferred(struct multi_context *m, struct multi_ins=
tance *mi);
+
+
 /*************************************************************************=
*/
 /**
  * Main event loop for OpenVPN in TCP server mode.
@@ -68,6 +62,6 @@
 void tunnel_server_tcp(struct context *top);


-void multi_tcp_delete_event(struct multi_tcp *mtcp, event_t event);
+void multi_tcp_delete_event(struct multi_protocol *multi_io, event_t event=
);

 #endif /* ifndef MTCP_H */
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 6137578..c0ae4e8 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -186,7 +186,7 @@

 struct multi_instance *
 multi_get_create_instance_udp(struct multi_context *m, bool *floated,
-                              struct link_socket *ls)
+                              struct link_socket *sock)
 {
     struct gc_arena gc =3D gc_new();
     struct mroute_addr real =3D {0};
@@ -257,7 +257,7 @@
                      * connect-freq but not against connect-freq-initial */
                     reflect_filter_rate_limit_decrease(m->initial_rate_lim=
iter);

-                    mi =3D multi_create_instance(m, &real, ls);
+                    mi =3D multi_create_instance(m, &real, sock);
                     if (mi)
                     {
                         hash_add_fast(hash, bucket, &mi->real, hv, mi);
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index b378754..3107cc6 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -56,13 +56,13 @@
  * successful, returns the newly created instance.
  *
  * @param m           - The single multi_context structure.
- * @param ls          - Listening socket where this instance is connecting=
 to
+ * @param sock        - Listening socket where this instance is connecting=
 to
  *
  * @return A pointer to a multi_instance if one already existed for the
  *     packet's source address or if one was a newly created successfully.
  *      NULL if one did not yet exist and a new one was not created.
  */
 struct multi_instance *multi_get_create_instance_udp(struct multi_context =
*m, bool *floated,
-                                                     struct link_socket *l=
s);
+                                                     struct link_socket *s=
ock);

 #endif /* ifndef MUDP_H */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 67bb58f..72fd964 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -440,7 +440,7 @@
      */
     if (tcp_mode)
     {
-        m->mtcp =3D multi_tcp_init(t->options.max_clients, &m->max_clients=
);
+        m->multi_io =3D multi_protocol_init(t->options.max_clients, &m->ma=
x_clients);
     }
     m->tcp_queue_limit =3D t->options.tcp_queue_limit;

@@ -665,9 +665,9 @@
             mi->did_iroutes =3D false;
         }

-        if (m->mtcp)
+        if (m->multi_io)
         {
-            multi_tcp_dereference_instance(m->mtcp, mi);
+            multi_tcp_dereference_instance(m->multi_io, mi);
         }

         mbuf_dereference_instance(m->mbuf, mi);
@@ -742,7 +742,7 @@
         initial_rate_limit_free(m->initial_rate_limiter);
         multi_reap_free(m->reaper);
         mroute_helper_free(m->route_helper);
-        multi_tcp_free(m->mtcp);
+        multi_protocol_free(m->multi_io);
     }
 }

@@ -751,7 +751,7 @@
  */
 struct multi_instance *
 multi_create_instance(struct multi_context *m, const struct mroute_addr *r=
eal,
-                      struct link_socket *ls)
+                      struct link_socket *sock)
 {
     struct gc_arena gc =3D gc_new();
     struct multi_instance *mi;
@@ -774,7 +774,7 @@
         generate_prefix(mi);
     }

-    inherit_context_child(&mi->context, &m->top, ls);
+    inherit_context_child(&mi->context, &m->top, sock);
     if (IS_SIG(&mi->context))
     {
         goto err;
@@ -3126,7 +3126,7 @@

 void
 multi_process_float(struct multi_context *m, struct multi_instance *mi,
-                    struct link_socket *ls)
+                    struct link_socket *sock)
 {
     struct mroute_addr real =3D {0};
     struct hash *hash =3D m->hash;
@@ -3182,7 +3182,7 @@
     mi->context.c2.to_link_addr =3D &mi->context.c2.from;

     /* inherit parent link_socket and link_socket_info */
-    mi->context.c2.link_sockets[0] =3D ls;
+    mi->context.c2.link_sockets[0] =3D sock;
     mi->context.c2.link_socket_infos[0]->lsa->actual =3D m->top.c2.from;

     tls_update_remote_addr(mi->context.c2.tls_multi, &mi->context.c2.from);
@@ -3332,7 +3332,7 @@
  */
 bool
 multi_process_incoming_link(struct multi_context *m, struct multi_instance=
 *instance,
-                            const unsigned int mpp_flags, struct link_sock=
et *ls)
+                            const unsigned int mpp_flags, struct link_sock=
et *sock)
 {
     struct gc_arena gc =3D gc_new();

@@ -3353,7 +3353,7 @@
 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("TCP/UDP -> TUN [%d]\n", BLEN(&m->top.c2.buf));
 #endif
-        multi_set_pending(m, multi_get_create_instance_udp(m, &floated, ls=
));
+        multi_set_pending(m, multi_get_create_instance_udp(m, &floated, so=
ck));
     }
     else
     {
@@ -3394,7 +3394,7 @@
                 /* nonzero length means that we have a valid, decrypted pa=
cked */
                 if (floated && c->c2.buf.len > 0)
                 {
-                    multi_process_float(m, m->pending, ls);
+                    multi_process_float(m, m->pending, sock);
                 }

                 process_incoming_link_part2(c, lsi, orig_buf);
@@ -3974,9 +3974,9 @@
 management_delete_event(void *arg, event_t event)
 {
     struct multi_context *m =3D (struct multi_context *) arg;
-    if (m->mtcp)
+    if (m->multi_io)
     {
-        multi_tcp_delete_event(m->mtcp, event);
+        multi_tcp_delete_event(m->multi_io, event);
     }
 }

diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 9b6834a..8bf596c 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -38,6 +38,7 @@
 #include "pool.h"
 #include "mudp.h"
 #include "mtcp.h"
+#include "multi_io.h"
 #include "perf.h"
 #include "vlan.h"
 #include "reflect_filter.h"
@@ -174,8 +175,8 @@
     struct mbuf_set *mbuf;      /**< Set of buffers for passing data
                                  *   channel packets between VPN tunnel
                                  *   instances. */
-    struct multi_tcp *mtcp;     /**< State specific to OpenVPN using TCP
-                                 *   as external transport. */
+    struct multi_protocol *multi_io;     /**< State specific to OpenVPN us=
ing TCP
+                                          *   as external transport. */
     struct ifconfig_pool *ifconfig_pool;
     struct frequency_limit *new_connection_limiter;
     struct initial_packet_rate_limit *initial_rate_limiter;
@@ -276,7 +277,7 @@
 void multi_top_free(struct multi_context *m);

 struct multi_instance *multi_create_instance(struct multi_context *m, cons=
t struct mroute_addr *real,
-                                             struct link_socket *ls);
+                                             struct link_socket *sock);

 void multi_close_instance(struct multi_context *m, struct multi_instance *=
mi, bool shutdown);

@@ -291,7 +292,7 @@
  * updates hashtables in multi_context.
  */
 void multi_process_float(struct multi_context *m, struct multi_instance *m=
i,
-                         struct link_socket *ls);
+                         struct link_socket *sock);

 #define MPP_PRE_SELECT             (1<<0)
 #define MPP_CONDITIONAL_PRE_SELECT (1<<1)
@@ -356,10 +357,10 @@
  *                       when using TCP transport. Otherwise NULL, as is
  *                       the case when using UDP transport.
  * @param mpp_flags    - Fast I/O optimization flags.
- * @param ls           - Socket where the packet was received.
+ * @param sock           - Socket where the packet was received.
  */
 bool multi_process_incoming_link(struct multi_context *m, struct multi_ins=
tance *instance, const unsigned int mpp_flags,
-                                 struct link_socket *ls);
+                                 struct link_socket *sock);


 /**
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
new file mode 100644
index 0000000..43fe24b
--- /dev/null
+++ b/src/openvpn/multi_io.c
@@ -0,0 +1,619 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include "memdbg.h"
+
+#include "multi.h"
+#include "forward.h"
+#include "multi_io.h"
+
+#ifdef HAVE_SYS_INOTIFY_H
+#include <sys/inotify.h>
+#endif
+
+/*
+ * Special tags passed to event.[ch] functions
+ */
+#define MULTI_IO_SOCKET      ((void *)1)
+#define MULTI_IO_TUN         ((void *)2)
+#define MULTI_IO_SIG         ((void *)3) /* Only on Windows */
+#define MULTI_IO_MANAGEMENT ((void *)4)
+#define MULTI_IO_FILE_CLOSE_WRITE ((void *)5)
+#define MULTI_IO_DCO        ((void *)6)
+
+struct ta_iow_flags
+{
+    unsigned int flags;
+    unsigned int ret;
+    unsigned int tun;
+    unsigned int sock;
+};
+
+#ifdef ENABLE_DEBUG
+static const char *
+pract(int action)
+{
+    switch (action)
+    {
+        case TA_UNDEF:
+            return "TA_UNDEF";
+
+        case TA_SOCKET_READ:
+            return "TA_SOCKET_READ";
+
+        case TA_SOCKET_READ_RESIDUAL:
+            return "TA_SOCKET_READ_RESIDUAL";
+
+        case TA_SOCKET_WRITE:
+            return "TA_SOCKET_WRITE";
+
+        case TA_SOCKET_WRITE_READY:
+            return "TA_SOCKET_WRITE_READY";
+
+        case TA_SOCKET_WRITE_DEFERRED:
+            return "TA_SOCKET_WRITE_DEFERRED";
+
+        case TA_TUN_READ:
+            return "TA_TUN_READ";
+
+        case TA_TUN_WRITE:
+            return "TA_TUN_WRITE";
+
+        case TA_INITIAL:
+            return "TA_INITIAL";
+
+        case TA_TIMEOUT:
+            return "TA_TIMEOUT";
+
+        case TA_TUN_WRITE_TIMEOUT:
+            return "TA_TUN_WRITE_TIMEOUT";
+
+        default:
+            return "?";
+    }
+}
+#endif /* ENABLE_DEBUG */
+
+struct multi_protocol *
+multi_protocol_init(int maxevents, int *maxclients)
+{
+    struct multi_protocol *multi_io;
+    const int extra_events =3D BASE_N_EVENTS;
+
+    ASSERT(maxevents >=3D 1);
+    ASSERT(maxclients);
+
+    ALLOC_OBJ_CLEAR(multi_io, struct multi_protocol);
+    multi_io->maxevents =3D maxevents + extra_events;
+    multi_io->es =3D event_set_init(&multi_io->maxevents, 0);
+    wait_signal(multi_io->es, MULTI_IO_SIG);
+    ALLOC_ARRAY(multi_io->esr, struct event_set_return, multi_io->maxevent=
s);
+    *maxclients =3D max_int(min_int(multi_io->maxevents - extra_events, *m=
axclients), 1);
+    msg(D_MULTI_LOW, "MULTI: TCP INIT maxclients=3D%d maxevents=3D%d", *ma=
xclients, multi_io->maxevents);
+    return multi_io;
+}
+
+void
+multi_protocol_free(struct multi_protocol *multi_io)
+{
+    if (multi_io)
+    {
+        event_free(multi_io->es);
+        free(multi_io->esr);
+        free(multi_io);
+    }
+}
+
+int
+multi_protocol_io_wait(struct multi_context *m)
+{
+    int status, i;
+    unsigned int *persistent =3D &m->multi_io->tun_rwflags;
+
+    for (i =3D 0; i < m->top.c1.link_sockets_num; i++)
+    {
+        socket_set_listen_persistent(m->top.c2.link_sockets[i], m->multi_i=
o->es,
+                                     &m->top.c2.link_sockets[i]->ev_arg);
+    }
+
+#ifdef _WIN32
+    if (tuntap_is_wintun(m->top.c1.tuntap))
+    {
+        if (!tuntap_ring_empty(m->top.c1.tuntap))
+        {
+            /* there is data in wintun ring buffer, read it immediately */
+            m->multi_io->esr[0].arg =3D MULTI_IO_TUN;
+            m->multi_io->esr[0].rwflags =3D EVENT_READ;
+            m->multi_io->n_esr =3D 1;
+            return 1;
+        }
+        persistent =3D NULL;
+    }
+#endif
+    tun_set(m->top.c1.tuntap, m->multi_io->es, EVENT_READ, MULTI_IO_TUN, p=
ersistent);
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+    dco_event_set(&m->top.c1.tuntap->dco, m->multi_io->es, MULTI_IO_DCO);
+#endif
+
+#ifdef ENABLE_MANAGEMENT
+    if (management)
+    {
+        management_socket_set(management, m->multi_io->es, MULTI_IO_MANAGE=
MENT, &m->multi_io->management_persist_flags);
+    }
+#endif
+
+#ifdef ENABLE_ASYNC_PUSH
+    /* arm inotify watcher */
+    event_ctl(m->multi_io->es, m->top.c2.inotify_fd, EVENT_READ, MULTI_IO_=
FILE_CLOSE_WRITE);
+#endif
+
+    status =3D event_wait(m->multi_io->es, &m->top.c2.timeval, m->multi_io=
->esr, m->multi_io->maxevents);
+    update_time();
+    m->multi_io->n_esr =3D 0;
+    if (status > 0)
+    {
+        m->multi_io->n_esr =3D status;
+    }
+    return status;
+}
+
+static int
+multi_protocol_wait_lite(struct multi_context *m, struct multi_instance *m=
i, const int action, bool *tun_input_pending)
+{
+    struct context *c =3D multi_tcp_context(m, mi);
+    unsigned int looking_for =3D 0;
+
+    dmsg(D_MULTI_DEBUG, "MULTI PROTOCOL: multi_protocol_wait_lite a=3D%s m=
i=3D" ptr_format,
+         pract(action),
+         (ptr_type)mi);
+
+    tv_clear(&c->c2.timeval); /* ZERO-TIMEOUT */
+
+    switch (action)
+    {
+        case TA_TUN_READ:
+            looking_for =3D TUN_READ;
+            tun_input_pending =3D NULL;
+            io_wait(c, IOW_READ_TUN);
+            break;
+
+        case TA_SOCKET_READ:
+            looking_for =3D SOCKET_READ;
+            tun_input_pending =3D NULL;
+            io_wait(c, IOW_READ_LINK);
+            break;
+
+        case TA_TUN_WRITE:
+            looking_for =3D TUN_WRITE;
+            tun_input_pending =3D NULL;
+            c->c2.timeval.tv_sec =3D 1; /* For some reason, the Linux 2.2 =
TUN/TAP driver hits this timeout */
+            perf_push(PERF_PROC_OUT_TUN_MTCP);
+            io_wait(c, IOW_TO_TUN);
+            perf_pop();
+            break;
+
+        case TA_SOCKET_WRITE:
+            looking_for =3D SOCKET_WRITE;
+            io_wait(c, IOW_TO_LINK|IOW_READ_TUN_FORCE);
+            break;
+
+        default:
+            msg(M_FATAL, "MULTI PROTOCOL: multi_protocol_wait_lite, unhand=
led action=3D%d", action);
+    }
+
+    if (tun_input_pending && (c->c2.event_set_status & TUN_READ))
+    {
+        *tun_input_pending =3D true;
+    }
+
+    if (c->c2.event_set_status & looking_for)
+    {
+        return action;
+    }
+    else
+    {
+        switch (action)
+        {
+            /* MULTI PROTOCOL socket output buffer is full */
+            case TA_SOCKET_WRITE:
+                return TA_SOCKET_WRITE_DEFERRED;
+
+            /* TUN device timed out on accepting write */
+            case TA_TUN_WRITE:
+                return TA_TUN_WRITE_TIMEOUT;
+        }
+
+        return TA_UNDEF;
+    }
+}
+
+static struct multi_instance *
+multi_protocol_dispatch(struct multi_context *m, struct multi_instance *mi=
, const int action)
+{
+    const unsigned int mpp_flags =3D MPP_PRE_SELECT|MPP_RECORD_TOUCH;
+    struct multi_instance *touched =3D mi;
+    m->mpp_touched =3D &touched;
+
+    dmsg(D_MULTI_DEBUG, "MULTI PROTOCOL: multi_protocol_dispatch a=3D%s mi=
=3D" ptr_format,
+         pract(action),
+         (ptr_type)mi);
+
+    switch (action)
+    {
+        case TA_TUN_READ:
+            read_incoming_tun(&m->top);
+            if (!IS_SIG(&m->top))
+            {
+                multi_process_incoming_tun(m, mpp_flags);
+            }
+            break;
+
+        case TA_SOCKET_READ:
+        case TA_SOCKET_READ_RESIDUAL:
+            ASSERT(mi);
+            ASSERT(mi->context.c2.link_sockets);
+            ASSERT(mi->context.c2.link_sockets[0]);
+            set_prefix(mi);
+            read_incoming_link(&mi->context, mi->context.c2.link_sockets[0=
]);
+            clear_prefix();
+            if (!IS_SIG(&mi->context))
+            {
+                multi_process_incoming_link(m, mi, mpp_flags,
+                                            mi->context.c2.link_sockets[0]=
);
+                if (!IS_SIG(&mi->context))
+                {
+                    stream_buf_read_setup(mi->context.c2.link_sockets[0]);
+                }
+            }
+            break;
+
+        case TA_TIMEOUT:
+            multi_process_timeout(m, mpp_flags);
+            break;
+
+        case TA_TUN_WRITE:
+            multi_process_outgoing_tun(m, mpp_flags);
+            break;
+
+        case TA_TUN_WRITE_TIMEOUT:
+            multi_process_drop_outgoing_tun(m, mpp_flags);
+            break;
+
+        case TA_SOCKET_WRITE_READY:
+            ASSERT(mi);
+            multi_tcp_process_outgoing_link_ready(m, mi, mpp_flags);
+            break;
+
+        case TA_SOCKET_WRITE:
+            multi_tcp_process_outgoing_link(m, false, mpp_flags);
+            break;
+
+        case TA_SOCKET_WRITE_DEFERRED:
+            multi_tcp_process_outgoing_link(m, true, mpp_flags);
+            break;
+
+        case TA_INITIAL:
+            ASSERT(mi);
+            multi_tcp_set_global_rw_flags(m, mi);
+            multi_process_post(m, mi, mpp_flags);
+            break;
+
+        default:
+            msg(M_FATAL, "MULTI PROTOCOL: multi_protocol_dispatch, unhandl=
ed action=3D%d", action);
+    }
+
+    m->mpp_touched =3D NULL;
+    return touched;
+}
+
+static int
+multi_protocol_post(struct multi_context *m, struct multi_instance *mi, co=
nst int action)
+{
+    struct context *c =3D multi_tcp_context(m, mi);
+    int newaction =3D TA_UNDEF;
+
+#define MTP_NONE         0
+#define MTP_TUN_OUT      (1<<0)
+#define MTP_LINK_OUT     (1<<1)
+    unsigned int flags =3D MTP_NONE;
+
+    if (TUN_OUT(c))
+    {
+        flags |=3D MTP_TUN_OUT;
+    }
+    if (LINK_OUT(c))
+    {
+        flags |=3D MTP_LINK_OUT;
+    }
+
+    switch (flags)
+    {
+        case MTP_TUN_OUT|MTP_LINK_OUT:
+        case MTP_TUN_OUT:
+            newaction =3D TA_TUN_WRITE;
+            break;
+
+        case MTP_LINK_OUT:
+            newaction =3D TA_SOCKET_WRITE;
+            break;
+
+        case MTP_NONE:
+            if (mi && sockets_read_residual(c))
+            {
+                newaction =3D TA_SOCKET_READ_RESIDUAL;
+            }
+            else
+            {
+                multi_tcp_set_global_rw_flags(m, mi);
+            }
+            break;
+
+        default:
+        {
+            struct gc_arena gc =3D gc_new();
+            msg(M_FATAL, "MULTI PROTOCOL: multi_protocol_post bad state, m=
i=3D%s flags=3D%d",
+                multi_instance_string(mi, false, &gc),
+                flags);
+            gc_free(&gc);
+            break;
+        }
+    }
+
+    dmsg(D_MULTI_DEBUG, "MULTI PROTOCOL: multi_protocol_post %s -> %s",
+         pract(action),
+         pract(newaction));
+
+    return newaction;
+}
+
+void
+multi_protocol_process_io(struct multi_context *m)
+{
+    struct multi_protocol *multi_io =3D m->multi_io;
+    int i;
+
+    for (i =3D 0; i < multi_io->n_esr; ++i)
+    {
+        struct event_set_return *e =3D &multi_io->esr[i];
+        struct event_arg *ev_arg =3D (struct event_arg *)e->arg;
+
+        /* incoming data for instance or listening socket? */
+        if (e->arg >=3D MULTI_N)
+        {
+            switch (ev_arg->type)
+            {
+                struct multi_instance *mi;
+
+                /* react to event on child instance */
+                case EVENT_ARG_MULTI_INSTANCE:
+                    if (!ev_arg->u.mi)
+                    {
+                        msg(D_MULTI_ERRORS, "MULTI PROTOCOL: multi_proto_p=
roc_io: null minstance");
+                        break;
+                    }
+
+                    mi =3D ev_arg->u.mi;
+                    if (e->rwflags & EVENT_WRITE)
+                    {
+                        multi_protocol_action(m, mi, TA_SOCKET_WRITE_READY=
, false);
+                    }
+                    else if (e->rwflags & EVENT_READ)
+                    {
+                        multi_protocol_action(m, mi, TA_SOCKET_READ, false=
);
+                    }
+                    break;
+
+                /* new incoming TCP client attempting to connect? */
+                case EVENT_ARG_LINK_SOCKET:
+                    if (!ev_arg->u.sock)
+                    {
+                        msg(D_MULTI_ERRORS, "MULTI PROTOCOL: multi_proto_p=
roc_io: null socket");
+                        break;
+                    }
+
+                    if (!proto_is_dgram(ev_arg->u.sock->info.proto))
+                    {
+                        socket_reset_listen_persistent(ev_arg->u.sock);
+                        mi =3D multi_create_instance_tcp(m, ev_arg->u.sock=
);
+                        if (mi)
+                        {
+                            multi_protocol_action(m, mi, TA_INITIAL, false=
);
+                        }
+                        break;
+                    }
+            }
+        }
+        else
+        {
+#ifdef ENABLE_MANAGEMENT
+            if (e->arg =3D=3D MULTI_IO_MANAGEMENT)
+            {
+                ASSERT(management);
+                management_io(management);
+            }
+            else
+#endif
+            /* incoming data on TUN? */
+            if (e->arg =3D=3D MULTI_IO_TUN)
+            {
+                if (e->rwflags & EVENT_WRITE)
+                {
+                    multi_protocol_action(m, NULL, TA_TUN_WRITE, false);
+                }
+                else if (e->rwflags & EVENT_READ)
+                {
+                    multi_protocol_action(m, NULL, TA_TUN_READ, false);
+                }
+            }
+            /* new incoming TCP client attempting to connect? */
+            else if (e->arg =3D=3D MULTI_IO_SOCKET)
+            {
+                struct multi_instance *mi;
+                ASSERT(m->top.c2.link_sockets[0]);
+                socket_reset_listen_persistent(m->top.c2.link_sockets[0]);
+                mi =3D multi_create_instance_tcp(m, m->top.c2.link_sockets=
[0]);
+                if (mi)
+                {
+                    multi_protocol_action(m, mi, TA_INITIAL, false);
+                }
+            }
+#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBS=
D))
+            /* incoming data on DCO? */
+            else if (e->arg =3D=3D MULTI_IO_DCO)
+            {
+                multi_process_incoming_dco(m);
+            }
+#endif
+            /* signal received? */
+            else if (e->arg =3D=3D MULTI_IO_SIG)
+            {
+                get_signal(&m->top.sig->signal_received);
+            }
+#ifdef ENABLE_ASYNC_PUSH
+            else if (e->arg =3D=3D MULTI_IO_FILE_CLOSE_WRITE)
+            {
+                multi_process_file_closed(m, MPP_PRE_SELECT | MPP_RECORD_T=
OUCH);
+            }
+#endif
+        }
+        if (IS_SIG(&m->top))
+        {
+            break;
+        }
+    }
+    multi_io->n_esr =3D 0;
+
+    /*
+     * Process queued mbuf packets destined for TCP socket
+     */
+    {
+        struct multi_instance *mi;
+        while (!IS_SIG(&m->top) && (mi =3D mbuf_peek(m->mbuf)) !=3D NULL)
+        {
+            multi_protocol_action(m, mi, TA_SOCKET_WRITE, true);
+        }
+    }
+}
+
+void
+multi_protocol_action(struct multi_context *m, struct multi_instance *mi, =
int action, bool poll)
+{
+    bool tun_input_pending =3D false;
+
+    do
+    {
+        dmsg(D_MULTI_DEBUG, "MULTI PROTOCOL: multi_protocol_action a=3D%s =
p=3D%d",
+             pract(action),
+             poll);
+
+        /*
+         * If TA_SOCKET_READ_RESIDUAL, it means we still have pending
+         * input packets which were read by a prior recv.
+         *
+         * Otherwise do a "lite" wait, which means we wait with 0 timeout
+         * on I/O events only related to the current instance, not
+         * the big list of events.
+         *
+         * On our first pass, poll will be false because we already know
+         * that input is available, and to call io_wait would be redundant.
+         */
+        if (poll && action !=3D TA_SOCKET_READ_RESIDUAL)
+        {
+            const int orig_action =3D action;
+            action =3D multi_protocol_wait_lite(m, mi, action, &tun_input_=
pending);
+            if (action =3D=3D TA_UNDEF)
+            {
+                msg(M_FATAL, "MULTI PROTOCOL: I/O wait required blocking i=
n multi_protocol_action, action=3D%d", orig_action);
+            }
+        }
+
+        /*
+         * Dispatch the action
+         */
+        struct multi_instance *touched =3D multi_protocol_dispatch(m, mi, =
action);
+
+        /*
+         * Signal received or connection
+         * reset by peer?
+         */
+        if (touched && IS_SIG(&touched->context))
+        {
+            if (mi =3D=3D touched)
+            {
+                mi =3D NULL;
+            }
+            multi_close_instance_on_signal(m, touched);
+        }
+
+
+        /*
+         * If dispatch produced any pending output
+         * for a particular instance, point to
+         * that instance.
+         */
+        if (m->pending)
+        {
+            mi =3D m->pending;
+        }
+
+        /*
+         * Based on the effects of the action,
+         * such as generating pending output,
+         * possibly transition to a new action state.
+         */
+        action =3D multi_protocol_post(m, mi, action);
+
+        /*
+         * If we are finished processing the original action,
+         * check if we have any TUN input.  If so, transition
+         * our action state to processing this input.
+         */
+        if (tun_input_pending && action =3D=3D TA_UNDEF)
+        {
+            action =3D TA_TUN_READ;
+            mi =3D NULL;
+            tun_input_pending =3D false;
+            poll =3D false;
+        }
+        else
+        {
+            poll =3D true;
+        }
+
+    } while (action !=3D TA_UNDEF);
+}
+
+void
+multi_protocol_delete_event(struct multi_protocol *multi_io, event_t event)
+{
+    if (multi_io && multi_io->es)
+    {
+        event_del(multi_io->es, event);
+    }
+}
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
new file mode 100644
index 0000000..07fc935
--- /dev/null
+++ b/src/openvpn/multi_io.h
@@ -0,0 +1,77 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/*
+ * Multi-protocol specific code for --mode server
+ */
+
+#ifndef MULTI_IO_H
+#define MULTI_IO_H
+
+#include "event.h"
+
+/*
+ * I/O processing States
+ */
+
+#define TA_UNDEF                 0
+#define TA_SOCKET_READ           1
+#define TA_SOCKET_READ_RESIDUAL  2
+#define TA_SOCKET_WRITE          3
+#define TA_SOCKET_WRITE_READY    4
+#define TA_SOCKET_WRITE_DEFERRED 5
+#define TA_TUN_READ              6
+#define TA_TUN_WRITE             7
+#define TA_INITIAL               8
+#define TA_TIMEOUT               9
+#define TA_TUN_WRITE_TIMEOUT     10
+
+/*
+ * Extra state info needed for Multi-protocol
+ */
+struct multi_protocol
+{
+    struct event_set *es;
+    struct event_set_return *esr;
+    int n_esr;
+    int maxevents;
+    unsigned int tun_rwflags;
+    unsigned int udp_flags;
+#ifdef ENABLE_MANAGEMENT
+    unsigned int management_persist_flags;
+#endif
+};
+
+struct multi_protocol *multi_protocol_init(int maxevents, int *maxclients);
+
+void multi_protocol_free(struct multi_protocol *multi_io);
+
+int multi_protocol_io_wait(struct multi_context *m);
+
+void multi_protocol_process_io(struct multi_context *m);
+
+void multi_protocol_action(struct multi_context *m, struct multi_instance =
*mi, int action, bool poll);
+
+void multi_protocol_delete_event(struct multi_protocol *multi_io, event_t =
event);
+
+#endif /* ifndef MULTI_IO_H */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/763?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1e5a84969988e4f027a18658d4ab268c13fbf929
Gerrit-Change-Number: 763
Gerrit-PatchSet: 10
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--VJrXqHgi6vg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #10</strong> to this change.</p><p>=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/763?usp=3Demail">View Chan=
ge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">multiproto: move generic event handling code in dedicated files<br><=
br>    Introduced multi_io.h and multi_io.c files to centralize<br>    all =
codes related to multiple protocols.<br><br>    Renamed the struct mtcp to =
struct multi_protocol since it<br>    encompasses the event_set used by the=
 parent context in server mode.<br><br>    Several methods have also been r=
enamed and moved to fit the<br>    multiproto structure:<br><br>    - multi=
_tcp_init() -&gt; multi_protocol_init();<br>    - multi_tcp_free() -&gt; mu=
lti_protocol_free();<br>    - multi_tcp_wait() -&gt; multi_protocol_io_wait=
();<br>    and so forth.<br><br>Change-Id: I1e5a84969988e4f027a18658d4ab268=
c13fbf929<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&g=
t;<br>---<br>M CMakeLists.txt<br>M src/openvpn/Makefile.am<br>M src/openvpn=
/forward.h<br>M src/openvpn/init.c<br>M src/openvpn/init.h<br>M src/openvpn=
/mtcp.c<br>M src/openvpn/mtcp.h<br>M src/openvpn/mudp.c<br>M src/openvpn/mu=
dp.h<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>A src/openvpn/mul=
ti_io.c<br>A src/openvpn/multi_io.h<br>13 files changed, 765 insertions(+),=
 632 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/63/763/10</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.tx=
t</span><br><span>index 9ffcc89..ea8d006 100644</span><br><span>--- a/CMake=
Lists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -458,6 +4=
58,8 @@</span><br><span>     src/openvpn/mudp.h</span><br><span>     src/op=
envpn/multi.c</span><br><span>     src/openvpn/multi.h</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/multi_io.h</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/multi_io.c</span>=
<br><span>     src/openvpn/ntlm.c</span><br><span>     src/openvpn/ntlm.h</=
span><br><span>     src/openvpn/occ.c</span><br><span>diff --git a/src/open=
vpn/Makefile.am b/src/openvpn/Makefile.am</span><br><span>index d6d6592..37=
af683 100644</span><br><span>--- a/src/openvpn/Makefile.am</span><br><span>=
+++ b/src/openvpn/Makefile.am</span><br><span>@@ -93,6 +93,7 @@</span><br><=
span> 	mtu.c mtu.h \</span><br><span> 	mudp.c mudp.h \</span><br><span> 	mu=
lti.c multi.h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mul=
ti_io.c multi_io.h \</span><br><span> 	networking_freebsd.c \</span><br><sp=
an> 	networking_iproute2.c networking_iproute2.h \</span><br><span> 	networ=
king_sitnl.c networking_sitnl.h \</span><br><span>diff --git a/src/openvpn/=
forward.h b/src/openvpn/forward.h</span><br><span>index ca2a695..214a322 10=
0644</span><br><span>--- a/src/openvpn/forward.h</span><br><span>+++ b/src/=
openvpn/forward.h</span><br><span>@@ -50,6 +50,7 @@</span><br><span> #inclu=
de &quot;openvpn.h&quot;</span><br><span> #include &quot;occ.h&quot;</span>=
<br><span> #include &quot;ping.h&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;multi_io.h&quot;</span><br><span> </span>=
<br><span> #define IOW_TO_TUN          (1&lt;&lt;0)</span><br><span> #defin=
e IOW_TO_LINK         (1&lt;&lt;1)</span><br><span>diff --git a/src/openvpn=
/init.c b/src/openvpn/init.c</span><br><span>index 86378f7..4d1cef0 100644<=
/span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/=
init.c</span><br><span>@@ -4923,7 +4923,7 @@</span><br><span> void</span><b=
r><span> inherit_context_child(struct context *dest,</span><br><span>      =
                 const struct context *src,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                      struct link_socket *ls)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                      struc=
t link_socket *sock)</span><br><span> {</span><br><span>     CLEAR(*dest);<=
/span><br><span> </span><br><span>@@ -4962,7 +4962,7 @@</span><br><span>   =
       * The CM_TOP context does the socket listen(),</span><br><span>     =
     * and the CM_CHILD_TCP context does the accept().</span><br><span>    =
      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dest-=
&gt;c2.accept_from =3D ls;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        dest-&gt;c2.accept_from =3D sock;</span><br><span>     }</sp=
an><br><span> </span><br><span> #ifdef ENABLE_PLUGIN</span><br><span>@@ -49=
89,11 +4989,11 @@</span><br><span>         ALLOC_ARRAY_GC(dest-&gt;c2.link_=
sockets, struct link_socket *, 1, &amp;dest-&gt;gc);</span><br><span> </spa=
n><br><span>         /* inherit parent link_socket and tuntap */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        dest-&gt;c2.link_sockets=
[0] =3D ls;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
dest-&gt;c2.link_sockets[0] =3D sock;</span><br><span> </span><br><span>   =
      ALLOC_ARRAY_GC(dest-&gt;c2.link_socket_infos, struct link_socket_info=
 *, 1, &amp;dest-&gt;gc);</span><br><span>         ALLOC_OBJ_GC(dest-&gt;c2=
.link_socket_infos[0], struct link_socket_info, &amp;dest-&gt;gc);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        *dest-&gt;c2.link_sock=
et_infos[0] =3D ls-&gt;info;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        *dest-&gt;c2.link_socket_infos[0] =3D sock-&gt;info;</span=
><br><span> </span><br><span>         /* locally override some link_socket_=
info fields */</span><br><span>         dest-&gt;c2.link_socket_infos[0]-&g=
t;lsa =3D &amp;dest-&gt;c1.link_socket_addrs[0];</span><br><span>diff --git=
 a/src/openvpn/init.h b/src/openvpn/init.h</span><br><span>index 11c32ac..5=
0b38e3 100644</span><br><span>--- a/src/openvpn/init.h</span><br><span>+++ =
b/src/openvpn/init.h</span><br><span>@@ -96,7 +96,7 @@</span><br><span> </s=
pan><br><span> void inherit_context_child(struct context *dest,</span><br><=
span>                            const struct context *src,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                           struct lin=
k_socket *ls);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                      struct link_socket *sock);</span><br><span> </span><b=
r><span> void inherit_context_top(struct context *dest,</span><br><span>   =
                       const struct context *src);</span><br><span>diff --g=
it a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>index b5bbf13.=
.1dae184 100644</span><br><span>--- a/src/openvpn/mtcp.c</span><br><span>++=
+ b/src/openvpn/mtcp.c</span><br><span>@@ -29,6 +29,8 @@</span><br><span> <=
/span><br><span> #include &quot;multi.h&quot;</span><br><span> #include &qu=
ot;forward.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;mtcp.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;multi_io.h&quot;</span><br><span> </span><br><span> #=
include &quot;memdbg.h&quot;</span><br><span> </span><br><span>@@ -36,30 +3=
8,6 @@</span><br><span> #include &lt;sys/inotify.h&gt;</span><br><span> #en=
dif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * TCP States</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define TA_UNDEF                 0</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define TA_SOCKET_READ        =
   1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TA_SOCKET=
_READ_RESIDUAL  2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine TA_SOCKET_WRITE          3</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define TA_SOCKET_WRITE_READY    4</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define TA_SOCKET_WRITE_DEFERRED 5</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define TA_TUN_READ              6</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TA_TUN_WRITE       =
      7</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TA_INI=
TIAL               8</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define TA_TIMEOUT               9</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define TA_TUN_WRITE_TIMEOUT     10</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Special tag=
s passed to event.[ch] functions</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 MTCP_TUN         ((void *)2)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define MTCP_SIG         ((void *)3) /* Only on Windows */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define MTCP_MANAGEMENT ((void=
 *)4)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define MTCP_FIL=
E_CLOSE_WRITE ((void *)5)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define MTCP_DCO        ((void *)6)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> struct ta_iow_flags</span><br><span> {<=
/span><br><span>     unsigned int flags;</span><br><span>@@ -68,59 +46,14 @=
@</span><br><span>     unsigned int sock;</span><br><span> };</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEB=
UG</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static const char *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pract(int action)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    switch (action)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        case TA_UNDEF:</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            return &quot;TA_UNDEF&quot;;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        case TA_SOCKET_READ:</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            return &quot;TA_SOCKET_READ&quot;;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        case TA_SOCKET_READ_RESIDUAL:</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            return &quot;TA_SOCKE=
T_READ_RESIDUAL&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCK=
ET_WRITE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
return &quot;TA_SOCKET_WRITE&quot;;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 case TA_SOCKET_WRITE_READY:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            return &quot;TA_SOCKET_WRITE_READY&quot;;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        case TA_SOCKET_WRITE_DEFERRED:</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            return &quot;TA_SOCKET_WRITE=
_DEFERRED&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_TUN_READ:<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return &qu=
ot;TA_TUN_READ&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_TUN_W=
RITE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            retu=
rn &quot;TA_TUN_WRITE&quot;;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case T=
A_INITIAL:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 return &quot;TA_INITIAL&quot;;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cas=
e TA_TIMEOUT:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    return &quot;TA_TIMEOUT&quot;;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
case TA_TUN_WRITE_TIMEOUT:</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            return &quot;TA_TUN_WRITE_TIMEOUT&quot;;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        default:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            return &quot;?&quot;;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENAB=
LE_DEBUG */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-static struct multi_instance *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_create_instance_=
tcp(struct multi_context *m, struct link_socket *ls)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+struct multi_instance *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+multi_create_instance_tcp(struct mult=
i_context *m, struct link_socket *sock)</span><br><span> {</span><br><span>=
     struct gc_arena gc =3D gc_new();</span><br><span>     struct multi_ins=
tance *mi =3D NULL;</span><br><span>     struct hash *hash =3D m-&gt;hash;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
mi =3D multi_create_instance(m, NULL, ls);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    mi =3D multi_create_instance(m, NULL, sock);</sp=
an><br><span>     if (mi)</span><br><span>     {</span><br><span>         s=
truct hash_element *he;</span><br><span>@@ -193,126 +126,42 @@</span><br><s=
pan>     mbuf_free(mi-&gt;tcp_link_out_deferred);</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct mul=
ti_tcp *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_ini=
t(int maxevents, int *maxclients)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct multi_tcp *mtcp;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const int extra_events =3D BASE_N_EVENTS;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    ASSERT(maxevents &gt;=3D 1);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ASSERT(maxclients);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ALL=
OC_OBJ_CLEAR(mtcp, struct multi_tcp);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    mtcp-&gt;maxevents =3D maxevents + extra_events;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    mtcp-&gt;es =3D event_se=
t_init(&amp;mtcp-&gt;maxevents, 0);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    wait_signal(mtcp-&gt;es, MTCP_SIG);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ALLOC_ARRAY(mtcp-&gt;esr, struct event_=
set_return, mtcp-&gt;maxevents);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    *maxclients =3D max_int(min_int(mtcp-&gt;maxevents - extra_e=
vents, *maxclients), 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    msg(D_MULTI_LOW, &quot;MULTI: TCP INIT maxclients=3D%d maxevents=3D%=
d&quot;, *maxclients, mtcp-&gt;maxevents);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return mtcp;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mul=
ti_tcp_delete_event(struct multi_tcp *mtcp, event_t event)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+multi_tcp_delete_event(struct multi_=
protocol *multi_io, event_t event)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (mtcp &amp;&amp; mtcp-&gt;es)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi_io &amp;&amp=
; multi_io-&gt;es)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        event_del(mtcp-&gt;es, event);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        event_del(multi_io-&gt;es, e=
vent);</span><br><span>     }</span><br><span> }</span><br><span> </span><b=
r><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_tc=
p_free(struct multi_tcp *mtcp)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+multi_tcp_dereference_instance(struct multi_protocol *multi_io, =
struct multi_instance *mi)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (mtcp)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct link_socket *sock =3D mi-&gt;context.c2.link_s=
ockets[0];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (s=
ock &amp;&amp; mi-&gt;socket_set_called)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        event_free(mtcp-&gt;es);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        free(mtcp-&gt;=
esr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        free(mtc=
p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_derefer=
ence_instance(struct multi_tcp *mtcp, struct multi_instance *mi)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct link_socket *ls =3D mi-&gt;context.c2.lin=
k_sockets[0];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
ls &amp;&amp; mi-&gt;socket_set_called)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        event_del(mtcp-&gt;es, socket_event_handle(ls));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        event_del(multi_io-&gt;es, s=
ocket_event_handle(sock));</span><br><span>         mi-&gt;socket_set_calle=
d =3D false;</span><br><span>     }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    mtcp-&gt;n_esr =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    multi_io-&gt;n_esr =3D 0;</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inl=
ine void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span>=
<br><span> multi_tcp_set_global_rw_flags(struct multi_context *m, struct mu=
lti_instance *mi)</span><br><span> {</span><br><span>     if (mi)</span><br=
><span>     {</span><br><span>         mi-&gt;socket_set_called =3D true;</=
span><br><span>         socket_set(mi-&gt;context.c2.link_sockets[0],</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                   m-&gt;mt=
cp-&gt;es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
          m-&gt;multi_io-&gt;es,</span><br><span>                    mbuf_d=
efined(mi-&gt;tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,</span><br>=
<span>                    &amp;mi-&gt;ev_arg,</span><br><span>             =
       &amp;mi-&gt;tcp_rwflags);</span><br><span>     }</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_tc=
p_wait(const struct context *c,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-               struct multi_tcp *mtcp)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    int status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    unsigned int *persistent =3D &amp;mtcp-&gt;tun_rwflags;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i=
++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        socket_set_listen_persiste=
nt(c-&gt;c2.link_sockets[i], mtcp-&gt;es,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                     &amp;c-&gt;c2.link=
_sockets[i]-&gt;ev_arg);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (tuntap_is_wintun(c-&gt;c1.tuntap))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (!tuntap_ring_empty(c-&gt;=
c1.tuntap))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* there i=
s data in wintun ring buffer, read it immediately */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            mtcp-&gt;esr[0].arg =3D MTCP_TU=
N;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mtcp-&g=
t;esr[0].rwflags =3D EVENT_READ;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            mtcp-&gt;n_esr =3D 1;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            return 1;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        persistent =3D NULL;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tun_set(c=
-&gt;c1.tuntap, mtcp-&gt;es, EVENT_READ, MTCP_TUN, persistent);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX) || defi=
ned(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  dco_event_set(&amp;c-&gt;c1.tuntap-&gt;dco, mtcp-&gt;es, MTCP_DCO);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (management)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     management_socket_set(management, mtcp-&gt;es, MTCP_MANAGEMENT, &amp;m=
tcp-&gt;management_persist_flags);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* arm inotify watcher */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    event_ctl(mtcp-&gt;es, c=
-&gt;c2.inotify_fd, EVENT_READ, MTCP_FILE_CLOSE_WRITE);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  status =3D event_wait(mtcp-&gt;es, &amp;c-&gt;c2.timeval, mtcp-&gt;esr, m=
tcp-&gt;maxevents);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  update_time();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
tcp-&gt;n_esr =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (status &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mtcp-&gt=
;n_esr =3D status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return status;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-static inline struct context *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+struct context *</span><br><span> multi_tcp_context(=
struct multi_context *m, struct multi_instance *mi)</span><br><span> {</spa=
n><br><span>     if (mi)</span><br><span>@@ -325,7 +174,7 @@</span><br><spa=
n>     }</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bool</span><br><span> multi_tcp_process_outgoing_link_ready=
(struct multi_context *m, struct multi_instance *mi, const unsigned int mpp=
_flags)</span><br><span> {</span><br><span>     struct mbuf_item item;</spa=
n><br><span>@@ -349,7 +198,7 @@</span><br><span>     return ret;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span> multi_tcp_process_outgoing_link(struct multi_context *m,=
 bool defer, const unsigned int mpp_flags)</span><br><span> {</span><br><sp=
an>     struct multi_instance *mi =3D multi_process_outgoing_link_pre(m);</=
span><br><span>@@ -393,417 +242,6 @@</span><br><span>     return ret;</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-m=
ulti_tcp_wait_lite(struct multi_context *m, struct multi_instance *mi, cons=
t int action, bool *tun_input_pending)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 struct context *c =3D multi_tcp_context(m, mi);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    unsigned int looking_for =3D 0;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    dmsg(D_MULTI_DEBUG, &quot;MULTI TCP: multi_tcp_wait=
_lite a=3D%s mi=3D&quot; ptr_format,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-         pract(action),</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-         (ptr_type)mi);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  tv_clear(&amp;c-&gt;c2.timeval); /* ZERO-TIMEOUT */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    switch (action)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 case TA_TUN_READ:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         looking_for =3D TUN_READ;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            tun_input_pending =3D NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            io_wait(c, IOW_READ_TUN);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        case TA_SOCKET_READ:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            looking_for =3D SOCKET_READ;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            tun_input_pe=
nding =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      io_wait(c, IOW_READ_LINK);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            break;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case =
TA_TUN_WRITE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    looking_for =3D TUN_WRITE;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            tun_input_pending =3D NULL;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            c-&gt;c2.timeval.tv_sec =3D 1; /* Fo=
r some reason, the Linux 2.2 TUN/TAP driver hits this timeout */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            perf_push(PERF_PROC_=
OUT_TUN_MTCP);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     io_wait(c, IOW_TO_TUN);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            perf_pop();</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA=
_SOCKET_WRITE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     looking_for =3D SOCKET_WRITE;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            io_wait(c, IOW_TO_LINK|IOW_READ_TUN_FORCE);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        default:</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            msg(M_FATAL, &quot;MULTI TCP: multi_tcp_wait_=
lite, unhandled action=3D%d&quot;, action);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tun_inp=
ut_pending &amp;&amp; (c-&gt;c2.event_set_status &amp; TUN_READ))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        *tun_input_pending =3D true;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (c-&gt;c2.event_set_status &amp; looking_for)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        return action;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        switch (action)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            /* TCP socket output =
buffer is full */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        case TA_SOCKET_WRITE:</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                return TA_SOCKET_WRITE_DEFERRED;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            /* TUN device timed out on accepting write */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            case TA_TUN_W=
RITE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
return TA_TUN_WRITE_TIMEOUT;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        return TA_UNDEF;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stati=
c struct multi_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-multi_tcp_dispatch(struct multi_context *m, struct multi_instance *mi, =
const int action)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    const unsigned int m=
pp_flags =3D MPP_PRE_SELECT|MPP_RECORD_TOUCH;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    struct multi_instance *touched =3D mi;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;mpp_touched =3D &amp=
;touched;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_MULTI_DEBUG, &quot;MUL=
TI TCP: multi_tcp_dispatch a=3D%s mi=3D&quot; ptr_format,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-         pract(action),</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-         (ptr_type)mi);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    switch (action)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        case TA_TUN_READ:</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            read_incoming_tun(&amp;m-&gt;top);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (!IS_SIG(&amp;m-&gt;top))</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                multi_process_in=
coming_tun(m, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKET_READ:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKE=
T_READ_RESIDUAL:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       ASSERT(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         ASSERT(mi-&gt;context.c2.link_sockets);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            ASSERT(mi-&gt;context.c2.link_socket=
s[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            set=
_prefix(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   read_incoming_link(&amp;mi-&gt;context, mi-&gt;context.c2.link_sockets[0=
]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            clear_=
prefix();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
if (!IS_SIG(&amp;mi-&gt;context))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                multi_process_incoming_link(m, mi, mpp_flags,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
             mi-&gt;context.c2.link_sockets[0]);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                if (!IS_SIG(&amp;mi-&gt;context)=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    stre=
am_buf_read_setup(mi-&gt;context.c2.link_sockets[0]);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    case TA_TIMEOUT:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           multi_process_timeout(m, mpp_flags);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        case TA_TUN_WRITE:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            multi_process_outgoing_tun(m, mpp_flags);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        case TA_TUN_WRITE_TIMEOUT:</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            multi_process_drop_outgoing_tun(m, =
mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKET_WRITE_READY=
:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(m=
i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_=
tcp_process_outgoing_link_ready(m, mi, mpp_flags);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        case TA_SOCKET_WRITE:</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            multi_tcp_process_outgoing_link(m, false, mpp_flag=
s);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKET_WRITE_DEFERRED:</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_tcp_pro=
cess_outgoing_link(m, true, mpp_flags);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  case TA_INITIAL:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         ASSERT(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           multi_tcp_set_global_rw_flags(m, mi);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            multi_process_post(m, mi, mpp_flags)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        default:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;MULTI TCP: multi_=
tcp_dispatch, unhandled action=3D%d&quot;, action);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
-&gt;mpp_touched =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return touched;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-multi_tcp_post(struct multi_context *m, struct mu=
lti_instance *mi, const int action)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct context *c =3D multi_tcp_context(m, mi);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    int newaction =3D TA_UNDEF;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define MTP_NONE         0</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define MTP_TUN_OUT      (1&lt;&lt;0)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define MTP_LINK_OUT     (1&lt;&lt;1)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int flags =
=3D MTP_NONE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (TUN_OUT(c))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        flags |=3D MTP_TUN_OUT;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (LINK_OUT(c))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        flags |=3D MTP_LINK_OUT;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (flags)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        case MTP_TUN_OUT|MTP_LINK_OUT:</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case MTP_TUN_OU=
T:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            newacti=
on =3D TA_TUN_WRITE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        case MTP_LINK_OUT=
:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            newactio=
n =3D TA_SOCKET_WRITE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case MTP_NONE:<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (mi &am=
p;&amp; sockets_read_residual(c))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                newaction =3D TA_SOCKET_READ_RESIDUAL;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            else</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                multi_tcp_set_global_rw_flags(m, mi);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        default:</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           struct gc_arena gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;MULTI TCP: multi_tcp_p=
ost bad state, mi=3D%s flags=3D%d&quot;,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                multi_instance_string(mi, false, &amp;gc=
),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                fla=
gs);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    dmsg(D_MULTI_DEBUG, &quot;MULTI TCP: multi_tcp_post %s -&=
gt; %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
 pract(action),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
   pract(newaction));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return newaction;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-multi_tcp_action(struct multi_context *m, struct multi_instance *mi, int=
 action, bool poll)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool tun_input_pen=
ding =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    do</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        dmsg(D_MULTI_DEBUG, &quot;MULTI TCP: multi_tcp_act=
ion a=3D%s p=3D%d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-             pract(action),</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-             poll);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-         * If TA_SOCKET_R=
EAD_RESIDUAL, it means we still have pending</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-         * input packets which were read by a prior =
TCP recv.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * Otherwise do=
 a &quot;lite&quot; wait, which means we wait with 0 timeout</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-         * on I/O events only relate=
d to the current instance, not</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-         * the big list of events.</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-         *</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-         * On our first pass, poll will be false because we alre=
ady know</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * th=
at input is available, and to call io_wait would be redundant.</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (poll &amp;&amp; action !=3D TA_=
SOCKET_READ_RESIDUAL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
const int orig_action =3D action;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            action =3D multi_tcp_wait_lite(m, mi, action, &amp;=
tun_input_pending);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          if (action =3D=3D TA_UNDEF)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                msg(M_FATAL, &quot;MULTI TCP: I/O wait required blo=
cking in multi_tcp_action, action=3D%d&quot;, orig_action);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * D=
ispatch the action</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struc=
t multi_instance *touched =3D multi_tcp_dispatch(m, mi, action);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        /*</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-         * Signal received or TCP connection</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-         * reset by peer?</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (touched &amp;&amp; IS_SIG(&amp;touc=
hed-&gt;context))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (=
mi =3D=3D touched)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     mi =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
multi_close_instance_on_signal(m, touched);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         * If dispatch produced any pending=
 output</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * for=
 a particular instance, point to</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-         * that instance.</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (m-&gt;pending)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          mi =3D m-&gt;pending;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-         * Based on the effects of=
 the action,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
* such as generating pending output,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-         * possibly transition to a new action state.</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        action =3D multi_tcp_post(m, m=
i, action);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-         * If we are finished processing t=
he original action,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
       * check if we have any TUN input.  If so, transition</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-         * our action state to proces=
sing this input.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
    */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (tun=
_input_pending &amp;&amp; action =3D=3D TA_UNDEF)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            action =3D TA_TUN_READ;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            mi =3D NULL;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            tun_input_pending =3D false;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            poll =3D =
false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            poll =3D true;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   } while (action !=3D TA_UNDEF);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_process_io(struct multi_cont=
ext *m)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct multi_tcp *mtcp =3D m-&=
gt;mtcp;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; mtcp-&gt;n_esr; ++=
i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        struct event_set_return *e =
=3D &amp;mtcp-&gt;esr[i];</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* incomi=
ng data for instance or listening socket? */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (e-&gt;arg &gt;=3D MULTI_N)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            struct event_arg *ev_arg =3D (struc=
t event_arg *)e-&gt;arg;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            switch (ev_arg-&gt;type)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                struct multi_instance *mi;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                /* react to event on child instance */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                case EVENT_ARG_=
MULTI_INSTANCE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              if (!ev_arg-&gt;u.mi)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                        msg(D_MULTI_ERRORS, &quot;MULTI: mtcp=
_proc_io: null minstance&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                        break;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   mi =3D ev_arg-&gt;u.mi;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    if (e-&gt;rwflags &amp; EVENT_WRIT=
E)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
     multi_tcp_action(m, mi, TA_SOCKET_WRITE_READY, false);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    else if (e-&gt;rw=
flags &amp; EVENT_READ)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                        multi_tcp_action(m, mi, TA_SOCKET_READ, false);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    bre=
ak;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                /* new incoming TCP cli=
ent attempting to connect? */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                case EVENT_ARG_LINK_SOCKET:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    if (!ev_arg-&gt;u.sock)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
   msg(D_MULTI_ERRORS, &quot;MULTI: mtcp_proc_io: null socket&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                        bre=
ak;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    socket_reset_listen=
_persistent(ev_arg-&gt;u.sock);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    mi =3D multi_create_instance_tcp(m, ev_arg-&g=
t;u.sock);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         if (mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                   multi_tcp_action(m, mi, TA_INITIAL, false);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    break;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            if (e-&gt;arg =3D=3D MTCP_MANAGEMENT)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                ASSERT(management);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                management_io(man=
agement);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            else</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            /* incoming data on TUN? */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (e-&gt;=
arg =3D=3D MTCP_TUN)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       if (e-&gt;rwflags &amp; EVENT_WRITE)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    multi_tcp_action(m, NULL, TA_TUN_WRIT=
E, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 else if (e-&gt;rwflags &amp; EVENT_READ)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    multi_tcp_action(m, NULL, TA_TUN_READ, =
false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_DCO) &a=
mp;&amp; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            /* incoming data on DCO? =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            else if=
 (e-&gt;arg =3D=3D MTCP_DCO)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               multi_process_incoming_dco(m);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            /* signal received? */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            else if (e-&gt;arg =3D=3D MTCP_SIG)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                get_signal(&amp;m-&gt;top.s=
ig-&gt;signal_received);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifde=
f ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          else if (e-&gt;arg =3D=3D MTCP_FILE_CLOSE_WRITE)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                multi_process_file_closed(m, M=
PP_PRE_SELECT | MPP_RECORD_TOUCH);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (IS_SIG(&am=
p;m-&gt;top))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    mtcp-&gt;n_esr =3D 0;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * P=
rocess queued mbuf packets destined for TCP socket</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       struct multi_instance *mi;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        while (!IS_SIG(&amp;m-&gt;top) &amp;&amp; (mi =3D mbuf_=
peek(m-&gt;mbuf)) !=3D NULL)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       multi_tcp_action(m, mi, TA_SOCKET_WRITE, true);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> /*</span><br><span>  * Top level event loop for single-threaded operatio=
n.</span><br><span>  * TCP mode.</span><br><span>@@ -851,7 +289,7 @@</span>=
<br><span> </span><br><span>         /* wait on tun/socket list */</span><b=
r><span>         multi_get_timeout(&amp;multi, &amp;multi.top.c2.timeval);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        status =3D mul=
ti_tcp_wait(&amp;multi.top, multi.mtcp);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        status =3D multi_protocol_io_wait(&amp;multi);=
</span><br><span>         MULTI_CHECK_SIG(&amp;multi);</span><br><span> </s=
pan><br><span>         /* check on status of coarse timers */</span><br><sp=
an>@@ -861,12 +299,12 @@</span><br><span>         if (status &gt; 0)</span>=
<br><span>         {</span><br><span>             /* process the I/O which =
triggered select */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          multi_tcp_process_io(&amp;multi);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            multi_protocol_process_io(&amp;multi);<=
/span><br><span>             MULTI_CHECK_SIG(&amp;multi);</span><br><span> =
        }</span><br><span>         else if (status =3D=3D 0)</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   multi_tcp_action(&amp;multi, NULL, TA_TIMEOUT, false);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            multi_protocol_action(&am=
p;multi, NULL, TA_TIMEOUT, false);</span><br><span>         }</span><br><sp=
an> </span><br><span>         perf_pop();</span><br><span>diff --git a/src/=
openvpn/mtcp.h b/src/openvpn/mtcp.h</span><br><span>index ab968e9..b9f73d4 =
100644</span><br><span>--- a/src/openvpn/mtcp.h</span><br><span>+++ b/src/o=
penvpn/mtcp.h</span><br><span>@@ -30,34 +30,28 @@</span><br><span> </span><=
br><span> #include &quot;event.h&quot;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * Extra state info needed for TCP mode</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-struct multi_tcp</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t event_set *es;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct event_set_return *esr;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    int n_esr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    int maxevents;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 unsigned int tun_rwflags;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    unsigned int management_persist_flags;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> struct multi_instance;</span><br><span> struct context;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct mul=
ti_tcp *multi_tcp_init(int maxevents, int *maxclients);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void multi_tcp_free(struct multi_tcp *mtcp);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-void multi_tcp_dereference_instance(struct multi_tcp *mtcp, =
struct multi_instance *mi);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void multi_tcp_dereference_instance(struct multi_protocol *multi_io=
, struct multi_instance *mi);</span><br><span> </span><br><span> bool multi=
_tcp_instance_specific_init(struct multi_context *m, struct multi_instance =
*mi);</span><br><span> </span><br><span> void multi_tcp_instance_specific_f=
ree(struct multi_instance *mi);</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+struct context *multi_tcp_context(struct mult=
i_context *m, struct multi_instance *mi);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void multi_tcp_set_global_rw_flags(struct multi_context *m, struct multi=
_instance *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool multi_tcp_process_=
outgoing_link(struct multi_context *m, bool defer, const unsigned int mpp_f=
lags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool multi_tcp_process_outgoing_=
link_ready(struct multi_context *m, struct multi_instance *mi, const unsign=
ed int mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct multi_instanc=
e *multi_create_instance_tcp(struct multi_context *m, struct link_socket *s=
ock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void multi_tcp_link_out_deferred(=
struct multi_context *m, struct multi_instance *mi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> /*****************************************=
*********************************/</span><br><span> /**</span><br><span>  *=
 Main event loop for OpenVPN in TCP server mode.</span><br><span>@@ -68,6 +=
62,6 @@</span><br><span> void tunnel_server_tcp(struct context *top);</span=
><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void multi_tcp_delete_event(struct multi_tcp *mtcp, event_t event)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void multi_tcp_del=
ete_event(struct multi_protocol *multi_io, event_t event);</span><br><span>=
 </span><br><span> #endif /* ifndef MTCP_H */</span><br><span>diff --git a/=
src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index 6137578..c0ae=
4e8 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/s=
rc/openvpn/mudp.c</span><br><span>@@ -186,7 +186,7 @@</span><br><span> </sp=
an><br><span> struct multi_instance *</span><br><span> multi_get_create_ins=
tance_udp(struct multi_context *m, bool *floated,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                              struct link_socke=
t *ls)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                 struct link_socket *sock)</span><br><span> {</span><br><sp=
an>     struct gc_arena gc =3D gc_new();</span><br><span>     struct mroute=
_addr real =3D {0};</span><br><span>@@ -257,7 +257,7 @@</span><br><span>   =
                   * connect-freq but not against connect-freq-initial */</=
span><br><span>                     reflect_filter_rate_limit_decrease(m-&g=
t;initial_rate_limiter);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    mi =3D multi_create_instance(m, &a=
mp;real, ls);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              mi =3D multi_create_instance(m, &amp;real, sock);</span><br><=
span>                     if (mi)</span><br><span>                     {</s=
pan><br><span>                         hash_add_fast(hash, bucket, &amp;mi-=
&gt;real, hv, mi);</span><br><span>diff --git a/src/openvpn/mudp.h b/src/op=
envpn/mudp.h</span><br><span>index b378754..3107cc6 100644</span><br><span>=
--- a/src/openvpn/mudp.h</span><br><span>+++ b/src/openvpn/mudp.h</span><br=
><span>@@ -56,13 +56,13 @@</span><br><span>  * successful, returns the newl=
y created instance.</span><br><span>  *</span><br><span>  * @param m       =
    - The single multi_context structure.</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- * @param ls          - Listening socket where this ins=
tance is connecting to</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param sock        - Listening socket where this instance is connecti=
ng to</span><br><span>  *</span><br><span>  * @return A pointer to a multi_=
instance if one already existed for the</span><br><span>  *     packet&#39;=
s source address or if one was a newly created successfully.</span><br><spa=
n>  *      NULL if one did not yet exist and a new one was not created.</sp=
an><br><span>  */</span><br><span> struct multi_instance *multi_get_create_=
instance_udp(struct multi_context *m, bool *floated,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                           =
          struct link_socket *ls);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                                     struct =
link_socket *sock);</span><br><span> </span><br><span> #endif /* ifndef MUD=
P_H */</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi=
.c</span><br><span>index 67bb58f..72fd964 100644</span><br><span>--- a/src/=
openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@=
@ -440,7 +440,7 @@</span><br><span>      */</span><br><span>     if (tcp_mo=
de)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        m-&gt;mtcp =3D multi_tcp_init(t-&gt;options.max_clients, &amp;=
m-&gt;max_clients);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        m-&gt;multi_io =3D multi_protocol_init(t-&gt;options.max_clients, &=
amp;m-&gt;max_clients);</span><br><span>     }</span><br><span>     m-&gt;t=
cp_queue_limit =3D t-&gt;options.tcp_queue_limit;</span><br><span> </span><=
br><span>@@ -665,9 +665,9 @@</span><br><span>             mi-&gt;did_iroute=
s =3D false;</span><br><span>         }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (m-&gt;mtcp)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (m-&gt;multi_io)</span><=
br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          multi_tcp_dereference_instance(m-&gt;mtcp, mi);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            multi_tcp_dereference_ins=
tance(m-&gt;multi_io, mi);</span><br><span>         }</span><br><span> </sp=
an><br><span>         mbuf_dereference_instance(m-&gt;mbuf, mi);</span><br>=
<span>@@ -742,7 +742,7 @@</span><br><span>         initial_rate_limit_free(=
m-&gt;initial_rate_limiter);</span><br><span>         multi_reap_free(m-&gt=
;reaper);</span><br><span>         mroute_helper_free(m-&gt;route_helper);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_tcp_free=
(m-&gt;mtcp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  multi_protocol_free(m-&gt;multi_io);</span><br><span>     }</span><br><sp=
an> }</span><br><span> </span><br><span>@@ -751,7 +751,7 @@</span><br><span=
>  */</span><br><span> struct multi_instance *</span><br><span> multi_creat=
e_instance(struct multi_context *m, const struct mroute_addr *real,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                      struct =
link_socket *ls)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                   struct link_socket *sock)</span><br><span> {</span><br><=
span>     struct gc_arena gc =3D gc_new();</span><br><span>     struct mult=
i_instance *mi;</span><br><span>@@ -774,7 +774,7 @@</span><br><span>       =
  generate_prefix(mi);</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    inherit_context_child(&amp;mi=
-&gt;context, &amp;m-&gt;top, ls);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    inherit_context_child(&amp;mi-&gt;context, &amp;m-&gt;to=
p, sock);</span><br><span>     if (IS_SIG(&amp;mi-&gt;context))</span><br><=
span>     {</span><br><span>         goto err;</span><br><span>@@ -3126,7 +=
3126,7 @@</span><br><span> </span><br><span> void</span><br><span> multi_pr=
ocess_float(struct multi_context *m, struct multi_instance *mi,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    struct link_s=
ocket *ls)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           struct link_socket *sock)</span><br><span> {</span><br><span>   =
  struct mroute_addr real =3D {0};</span><br><span>     struct hash *hash =
=3D m-&gt;hash;</span><br><span>@@ -3182,7 +3182,7 @@</span><br><span>     =
mi-&gt;context.c2.to_link_addr =3D &amp;mi-&gt;context.c2.from;</span><br><=
span> </span><br><span>     /* inherit parent link_socket and link_socket_i=
nfo */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mi-&gt;cont=
ext.c2.link_sockets[0] =3D ls;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    mi-&gt;context.c2.link_sockets[0] =3D sock;</span><br><span>=
     mi-&gt;context.c2.link_socket_infos[0]-&gt;lsa-&gt;actual =3D m-&gt;to=
p.c2.from;</span><br><span> </span><br><span>     tls_update_remote_addr(mi=
-&gt;context.c2.tls_multi, &amp;mi-&gt;context.c2.from);</span><br><span>@@=
 -3332,7 +3332,7 @@</span><br><span>  */</span><br><span> bool</span><br><s=
pan> multi_process_incoming_link(struct multi_context *m, struct multi_inst=
ance *instance,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                      const unsigned int mpp_flags, struct link_socket *ls)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
         const unsigned int mpp_flags, struct link_socket *sock)</span><br>=
<span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><s=
pan> </span><br><span>@@ -3353,7 +3353,7 @@</span><br><span> #ifdef MULTI_D=
EBUG_EVENT_LOOP</span><br><span>         printf(&quot;TCP/UDP -&gt; TUN [%d=
]\n&quot;, BLEN(&amp;m-&gt;top.c2.buf));</span><br><span> #endif</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        multi_set_pending(m, mul=
ti_get_create_instance_udp(m, &amp;floated, ls));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        multi_set_pending(m, multi_get_create=
_instance_udp(m, &amp;floated, sock));</span><br><span>     }</span><br><sp=
an>     else</span><br><span>     {</span><br><span>@@ -3394,7 +3394,7 @@</=
span><br><span>                 /* nonzero length means that we have a vali=
d, decrypted packed */</span><br><span>                 if (floated &amp;&a=
mp; c-&gt;c2.buf.len &gt; 0)</span><br><span>                 {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    multi_process=
_float(m, m-&gt;pending, ls);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    multi_process_float(m, m-&gt;pending, sock);<=
/span><br><span>                 }</span><br><span> </span><br><span>      =
           process_incoming_link_part2(c, lsi, orig_buf);</span><br><span>@=
@ -3974,9 +3974,9 @@</span><br><span> management_delete_event(void *arg, ev=
ent_t event)</span><br><span> {</span><br><span>     struct multi_context *=
m =3D (struct multi_context *) arg;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (m-&gt;mtcp)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (m-&gt;multi_io)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        multi_tcp_delete_event(m-&gt=
;mtcp, event);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   multi_tcp_delete_event(m-&gt;multi_io, event);</span><br><span>     }</s=
pan><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn=
/multi.h b/src/openvpn/multi.h</span><br><span>index 9b6834a..8bf596c 10064=
4</span><br><span>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/openv=
pn/multi.h</span><br><span>@@ -38,6 +38,7 @@</span><br><span> #include &quo=
t;pool.h&quot;</span><br><span> #include &quot;mudp.h&quot;</span><br><span=
> #include &quot;mtcp.h&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;multi_io.h&quot;</span><br><span> #include &quot;p=
erf.h&quot;</span><br><span> #include &quot;vlan.h&quot;</span><br><span> #=
include &quot;reflect_filter.h&quot;</span><br><span>@@ -174,8 +175,8 @@</s=
pan><br><span>     struct mbuf_set *mbuf;      /**&lt; Set of buffers for p=
assing data</span><br><span>                                  *   channel p=
ackets between VPN tunnel</span><br><span>                                 =
 *   instances. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 struct multi_tcp *mtcp;     /**&lt; State specific to OpenVPN using TCP</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
         *   as external transport. */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct multi_protocol *multi_io;     /**&lt; State s=
pecific to OpenVPN using TCP</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                          *   as external transpor=
t. */</span><br><span>     struct ifconfig_pool *ifconfig_pool;</span><br><=
span>     struct frequency_limit *new_connection_limiter;</span><br><span> =
    struct initial_packet_rate_limit *initial_rate_limiter;</span><br><span=
>@@ -276,7 +277,7 @@</span><br><span> void multi_top_free(struct multi_cont=
ext *m);</span><br><span> </span><br><span> struct multi_instance *multi_cr=
eate_instance(struct multi_context *m, const struct mroute_addr *real,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
                   struct link_socket *ls);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                             struct=
 link_socket *sock);</span><br><span> </span><br><span> void multi_close_in=
stance(struct multi_context *m, struct multi_instance *mi, bool shutdown);<=
/span><br><span> </span><br><span>@@ -291,7 +292,7 @@</span><br><span>  * u=
pdates hashtables in multi_context.</span><br><span>  */</span><br><span> v=
oid multi_process_float(struct multi_context *m, struct multi_instance *mi,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
    struct link_socket *ls);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                         struct link_socket *sock);</span><br><spa=
n> </span><br><span> #define MPP_PRE_SELECT             (1&lt;&lt;0)</span>=
<br><span> #define MPP_CONDITIONAL_PRE_SELECT (1&lt;&lt;1)</span><br><span>=
@@ -356,10 +357,10 @@</span><br><span>  *                       when using =
TCP transport. Otherwise NULL, as is</span><br><span>  *                   =
    the case when using UDP transport.</span><br><span>  * @param mpp_flags=
    - Fast I/O optimization flags.</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * @param ls           - Socket where the packet was received.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param sock     =
      - Socket where the packet was received.</span><br><span>  */</span><b=
r><span> bool multi_process_incoming_link(struct multi_context *m, struct m=
ulti_instance *instance, const unsigned int mpp_flags,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                 struct li=
nk_socket *ls);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                             struct link_socket *sock);</span><br><span> </=
span><br><span> </span><br><span> /**</span><br><span>diff --git a/src/open=
vpn/multi_io.c b/src/openvpn/multi_io.c</span><br><span>new file mode 10064=
4</span><br><span>index 0000000..43fe24b</span><br><span>--- /dev/null</spa=
n><br><span>+++ b/src/openvpn/multi_io.c</span><br><span>@@ -0,0 +1,619 @@<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to secu=
rely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             over a single TCP/UDP port, with support for SSL/TLS-bas=
ed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             se=
ssion authentication and key exchange,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             packet encryption, packet authentication,=
 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
packet compression.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C)=
 2002-2023 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  This program is free software; you can redistribute it and/or=
 modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under=
 the terms of the GNU General Public License version 2</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fo=
undation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distrib=
uted in the hope that it will be useful,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied=
 warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MER=
CHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for m=
ore details.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have rece=
ived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write to t=
he Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 U=
SA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;config.h&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;syshead.h&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;memdbg.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;multi.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;forward.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;multi_io.h&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifdef HAVE_SYS_INOTIFY_H</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &lt;sys/inotify.h&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Special tags passed to event.[=
ch] functions</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MULTI_IO_SOCKE=
T      ((void *)1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define MULTI_IO_TUN         ((void *)2)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define MULTI_IO_SIG         ((void *)3) /* Only on Win=
dows */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MULT=
I_IO_MANAGEMENT ((void *)4)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define MULTI_IO_FILE_CLOSE_WRITE ((void *)5)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define MULTI_IO_DCO        ((void *)6)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+struct ta_iow_flags</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    unsigned int flags;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    unsigned int ret;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    unsigned int tun;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    unsigned int sock;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef E=
NABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static c=
onst char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pract(in=
t action)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    switch (action)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case TA_UNDEF:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            return &quot;TA_UNDEF&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        case TA_SOCKET_READ:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            return &quot;TA=
_SOCKET_READ&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case TA_SOC=
KET_READ_RESIDUAL:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           return &quot;TA_SOCKET_READ_RESIDUAL&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        case TA_SOCKET_WRITE:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            return &quot;TA_SOCKET_WRITE&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        case TA_SOCKET_WRITE_READY:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            return &quot=
;TA_SOCKET_WRITE_READY&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
ase TA_SOCKET_WRITE_DEFERRED:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            return &quot;TA_SOCKET_WRITE_DEFERRED&quot;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        case TA_TUN_READ:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return &quot;TA_TUN_READ&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        case TA_TUN_WRITE:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            return &quot;TA_T=
UN_WRITE&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        case TA_INITIAL=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return=
 &quot;TA_INITIAL&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case T=
A_TIMEOUT:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   return &quot;TA_TIMEOUT&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   case TA_TUN_WRITE_TIMEOUT:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            return &quot;TA_TUN_WRITE_TIMEOUT&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        default:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            return &quot;?&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif /* ENABLE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct mul=
ti_protocol *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_=
protocol_init(int maxevents, int *maxclients)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct multi_protocol *multi_io;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const int extra_events =3D BASE_N_EVENTS;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(maxevents &gt;=3D 1);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(maxclients);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(multi_io, struct mult=
i_protocol);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mul=
ti_io-&gt;maxevents =3D maxevents + extra_events;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    multi_io-&gt;es =3D event_set_init(&amp;m=
ulti_io-&gt;maxevents, 0);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    wait_signal(multi_io-&gt;es, MULTI_IO_SIG);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ALLOC_ARRAY(multi_io-&gt;esr, struct=
 event_set_return, multi_io-&gt;maxevents);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    *maxclients =3D max_int(min_int(multi_io-&gt;ma=
xevents - extra_events, *maxclients), 1);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    msg(D_MULTI_LOW, &quot;MULTI: TCP INIT maxclients=
=3D%d maxevents=3D%d&quot;, *maxclients, multi_io-&gt;maxevents);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return multi_io;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi=
_protocol_free(struct multi_protocol *multi_io)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (multi_io)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  event_free(multi_io-&gt;es);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        free(multi_io-&gt;esr);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        free(multi_io);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+multi_protocol_io_wait(struct multi_cont=
ext *m)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int status, i;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int *persistent =
=3D &amp;m-&gt;multi_io-&gt;tun_rwflags;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    for (i =3D 0; i &lt; m-&gt;top.c1.link_sockets_num; i++)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        socket_set_listen_persistent(m-&gt;top=
.c2.link_sockets[i], m-&gt;multi_io-&gt;es,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                     &amp;m-&gt;top=
.c2.link_sockets[i]-&gt;ev_arg);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tuntap_is_wintun(m=
-&gt;top.c1.tuntap))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!=
tuntap_ring_empty(m-&gt;top.c1.tuntap))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            /* there is data in wintun ring buffer, read it immed=
iately */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  m-&gt;multi_io-&gt;esr[0].arg =3D MULTI_IO_TUN;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            m-&gt;multi_io-&gt;esr[0].rwflags=
 =3D EVENT_READ;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         m-&gt;multi_io-&gt;n_esr =3D 1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            return 1;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        persistent =3D NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    t=
un_set(m-&gt;top.c1.tuntap, m-&gt;multi_io-&gt;es, EVENT_READ, MULTI_IO_TUN=
, persistent);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    dco_event_set(&amp;m-&gt;top.c1.tuntap-&gt;=
dco, m-&gt;multi_io-&gt;es, MULTI_IO_DCO);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef EN=
ABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (management)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        management=
_socket_set(management, m-&gt;multi_io-&gt;es, MULTI_IO_MANAGEMENT, &amp;m-=
&gt;multi_io-&gt;management_persist_flags);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_ASYNC_PU=
SH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* arm inotif=
y watcher */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    eve=
nt_ctl(m-&gt;multi_io-&gt;es, m-&gt;top.c2.inotify_fd, EVENT_READ, MULTI_IO=
_FILE_CLOSE_WRITE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    status =3D event_wait(m-&gt;=
multi_io-&gt;es, &amp;m-&gt;top.c2.timeval, m-&gt;multi_io-&gt;esr, m-&gt;m=
ulti_io-&gt;maxevents);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    update_time();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    m-&gt;multi_io-&gt;n_esr =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (status &gt; 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        m-&gt;multi_io-&gt;n_esr =3D status;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return status;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+multi_protocol_wait_lite(st=
ruct multi_context *m, struct multi_instance *mi, const int action, bool *t=
un_input_pending)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context *=
c =3D multi_tcp_context(m, mi);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    unsigned int looking_for =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    dmsg(D_MULTI_DEBUG, &quot;MULTI PROTOCOL: multi_protocol_wait_=
lite a=3D%s mi=3D&quot; ptr_format,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+         pract(action),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+         (ptr_type)mi);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    tv_clear(&amp;c-&gt;c2.timeval); /* ZERO-TIMEOUT */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    switch (action)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        case TA_TUN_READ:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            looking_for =3D TUN_READ;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            tun_input_pending =3D NULL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            io_wait(c=
, IOW_READ_TUN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        case TA_SOCKET_=
READ:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            lo=
oking_for =3D SOCKET_READ;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            tun_input_pending =3D NULL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            io_wait(c, IOW_READ_LINK);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        case TA_TUN_WRITE:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            looking_for =3D TUN_WRITE;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            tun_input_=
pending =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          c-&gt;c2.timeval.tv_sec =3D 1; /* For some reason, the Linux 2.2 =
TUN/TAP driver hits this timeout */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            perf_push(PERF_PROC_OUT_TUN_MTCP);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            io_wait(c, IOW_TO_TU=
N);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            perf=
_pop();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        case TA_SOCKET_WRITE:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            looking_fo=
r =3D SOCKET_WRITE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            io_wait(c, IOW_TO_LINK|IOW_READ_TUN_FORCE);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        default:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            msg(M_FATAL, &quot;MULTI PROTOCOL: multi_protocol_=
wait_lite, unhandled action=3D%d&quot;, action);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (tun_input_pending &amp;&amp; (c-&gt;c2.event_set_status &amp; TUN_READ)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        *tun_input_pending =3D t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (c-&gt;c2.event_set_status &amp; looking_=
for)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return action;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        switch (action)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            /* MULTI PROTOCOL socket output buffer is full */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            case TA_SOCKET_WR=
ITE:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 return TA_SOCKET_WRITE_DEFERRED;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       /* TUN device timed out on accepting write */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            case TA_TUN_WRITE:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                return TA_TUN_=
WRITE_TIMEOUT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return TA_UNDEF;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic struct multi_instance *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+multi_protocol_dispatch(struct multi_context *m, struct multi_insta=
nce *mi, const int action)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const u=
nsigned int mpp_flags =3D MPP_PRE_SELECT|MPP_RECORD_TOUCH;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *touched =
=3D mi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;mp=
p_touched =3D &amp;touched;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_=
MULTI_DEBUG, &quot;MULTI PROTOCOL: multi_protocol_dispatch a=3D%s mi=3D&quo=
t; ptr_format,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
    pract(action),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        (ptr_type)mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (acti=
on)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        case TA_TUN_READ:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            read_incomin=
g_tun(&amp;m-&gt;top);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (!IS_SIG(&amp;m-&gt;top))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                multi_process_incoming_tun(m, mpp_flags);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        case TA_SOCKET_READ:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        case TA_SOCKET_READ_RESIDUAL=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT=
(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            AS=
SERT(mi-&gt;context.c2.link_sockets);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            ASSERT(mi-&gt;context.c2.link_sockets[0]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            set_prefix=
(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
ad_incoming_link(&amp;mi-&gt;context, mi-&gt;context.c2.link_sockets[0]);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            clear_pre=
fix();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (!IS_SIG(&amp;mi-&gt;context))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                multi_process_incoming_link(m, mi, mpp_flags,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
                  mi-&gt;context.c2.link_sockets[0]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                if (!IS_SIG(&amp;mi-&gt;c=
ontext))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       stream_buf_read_setup(mi-&gt;context.c2.link_sockets[0]);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        case TA_TIMEOUT:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            multi_process_timeout(m, mpp_flags);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        case TA_TUN_WRITE:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            multi_process_outgoing_tu=
n(m, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        case TA_TUN_WRI=
TE_TIMEOUT:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    multi_process_drop_outgoing_tun(m, mpp_flags);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        case TA_SOCKET_WRITE_READY:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            ASSERT(mi);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            multi_tcp_process_outgoing_link_=
ready(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case TA=
_SOCKET_WRITE:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       multi_tcp_process_outgoing_link(m, false, mpp_flags);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        case TA_SOCKET_WRITE_DEFERRED:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            multi_tcp_process_outgo=
ing_link(m, true, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ca=
se TA_INITIAL:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       ASSERT(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           multi_tcp_set_global_rw_flags(m, mi);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            multi_process_post(m, mi, mpp_flag=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            brea=
k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        default:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;MULTI PR=
OTOCOL: multi_protocol_dispatch, unhandled action=3D%d&quot;, action);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    m-&gt;mpp_touched =3D NULL;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return touched;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_protocol_p=
ost(struct multi_context *m, struct multi_instance *mi, const int action)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D multi_tcp_con=
text(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int=
 newaction =3D TA_UNDEF;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MTP_NO=
NE         0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 MTP_TUN_OUT      (1&lt;&lt;0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define MTP_LINK_OUT     (1&lt;&lt;1)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    unsigned int flags =3D MTP_NONE;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (TUN_OUT(c))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        flags |=3D MTP_TUN_OUT;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (LINK_OUT(c))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      flags |=3D MTP_LINK_OUT;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (flags)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        case MTP_TUN_OUT|MTP_LINK_OUT=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case MTP_T=
UN_OUT:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
newaction =3D TA_TUN_WRITE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case=
 MTP_LINK_OUT:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       newaction =3D TA_SOCKET_WRITE;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      case MTP_NONE:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (mi &amp;&amp; sockets_read_residual(c))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                newaction =3D TA_SOCKET_READ=
_RESIDUAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                multi_tc=
p_set_global_rw_flags(m, mi);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        default:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(M_FATAL, &quot;MULTI PROTOCOL: multi_protocol_post bad state, m=
i=3D%s flags=3D%d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                multi_instance_string(mi, false, &amp;gc),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                flags);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    dmsg(D_MULTI_DEBUG, &quot;MULTI PROTOCOL: multi_protocol=
_post %s -&gt; %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+         pract(action),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         pract(newaction));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return newaction;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+multi_protocol_process_io(struct multi_context *m)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct multi_protocol *multi_io =3D=
 m-&gt;multi_io;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; multi_=
io-&gt;n_esr; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct =
event_set_return *e =3D &amp;multi_io-&gt;esr[i];</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct event_arg *ev_arg =3D (struct =
event_arg *)e-&gt;arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* incom=
ing data for instance or listening socket? */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (e-&gt;arg &gt;=3D MULTI_N)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            switch (ev_arg-&gt;type)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                struct multi_=
instance *mi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* react =
to event on child instance */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                case EVENT_ARG_MULTI_INSTANCE:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    if (!ev_arg-&gt;u.=
mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          msg(D_MULTI_ERRORS, &quot;MULTI PROTOCOL: multi_proto_proc_io: nu=
ll minstance&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        break;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               mi =3D ev_arg-&gt;u.mi;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    if (e-&gt;rwflags &amp; EVENT_WRITE)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
       multi_protocol_action(m, mi, TA_SOCKET_WRITE_READY, false);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    else i=
f (e-&gt;rwflags &amp; EVENT_READ)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                        multi_protocol_action(m, mi, TA_SO=
CKET_READ, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    break;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     /* new incoming TCP client attempting to connect? */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                case EVENT_ARG_LINK_S=
OCKET:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       if (!ev_arg-&gt;u.sock)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                        msg(D_MULTI_ERRORS, &quot;MULTI PROTOC=
OL: multi_proto_proc_io: null socket&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        break;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    if (!proto_is_dgram(ev_arg-&gt;u.soc=
k-&gt;info.proto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        socket_reset_listen_persistent(ev_arg-&gt;u.sock);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
     mi =3D multi_create_instance_tcp(m, ev_arg-&gt;u.sock);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        if (mi)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
            multi_protocol_action(m, mi, TA_INITIAL, false);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        brea=
k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (e-&gt;arg =3D=3D MULTI_IO=
_MANAGEMENT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   ASSERT(management);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                management_io(management);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            /* incoming data on TUN? */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (e-&gt;arg =3D=3D MULTI_IO_TUN)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                if (e-&gt;rwfl=
ags &amp; EVENT_WRITE)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    multi_protocol_action(m, NULL, TA_TUN_WRITE, false);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                else if=
 (e-&gt;rwflags &amp; EVENT_READ)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    multi_protocol_action(m, NULL, TA_TUN_READ,=
 false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* new =
incoming TCP client attempting to connect? */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            else if (e-&gt;arg =3D=3D MULTI_IO_SO=
CKET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                stru=
ct multi_instance *mi;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                ASSERT(m-&gt;top.c2.link_sockets[0]);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                socket_reset_listen_pe=
rsistent(m-&gt;top.c2.link_sockets[0]);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                mi =3D multi_create_instance_tcp(m, m-&=
gt;top.c2.link_sockets[0]);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                if (mi)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    multi_protocol_action(m, mi, TA_INITIAL, fals=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO) =
&amp;&amp; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            /* incoming data on D=
CO? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e=
lse if (e-&gt;arg =3D=3D MULTI_IO_DCO)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                multi_process_incoming_dco(m);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            /* signal received? */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            else if (e-&gt;arg =3D=3D M=
ULTI_IO_SIG)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   get_signal(&amp;m-&gt;top.sig-&gt;signal_received);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#ifdef ENABLE_ASYNC_PUSH</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            else if (e-&gt;arg =3D=3D MUL=
TI_IO_FILE_CLOSE_WRITE)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              multi_process_file_closed(m, MPP_PRE_SELECT | MPP_RECORD_TOUC=
H);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (IS_SIG(&amp;m-&gt;top))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    multi_io-&gt;n_esr =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Proc=
ess queued mbuf packets destined for TCP socket</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        struct multi_instance *mi;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        while (!IS_SIG(&amp;m-&gt;top) &amp;&amp; (mi =3D =
mbuf_peek(m-&gt;mbuf)) !=3D NULL)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            multi_protocol_action(m, mi, TA_SOCKET_WRITE, true);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+multi_protocol_action(struc=
t multi_context *m, struct multi_instance *mi, int action, bool poll)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool tun_input_pending =3D false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    do</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        dmsg(D_MULTI_DEBUG, &quot;MULTI PROTOCOL: multi_protocol_act=
ion a=3D%s p=3D%d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+             pract(action),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+             poll);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * If T=
A_SOCKET_READ_RESIDUAL, it means we still have pending</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         * input packets which were read=
 by a prior recv.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * =
Otherwise do a &quot;lite&quot; wait, which means we wait with 0 timeout</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * on I/O even=
ts only related to the current instance, not</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+         * the big list of events.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * On our first pass, poll will be f=
alse because we already know</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         * that input is available, and to call io_wait would be r=
edundant.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (poll &=
amp;&amp; action !=3D TA_SOCKET_READ_RESIDUAL)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            const int orig_action =3D action;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            action =3D multi_pro=
tocol_wait_lite(m, mi, action, &amp;tun_input_pending);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if (action =3D=3D TA_UNDEF)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_FAT=
AL, &quot;MULTI PROTOCOL: I/O wait required blocking in multi_protocol_acti=
on, action=3D%d&quot;, orig_action);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+         * Dispatch the act=
ion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct multi_ins=
tance *touched =3D multi_protocol_dispatch(m, mi, action);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /*</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         * Signal received or connection</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * reset by peer?</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (touched &amp;&amp; IS_SIG(&am=
p;touched-&gt;context))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (mi =3D=3D touched)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                mi =3D NULL;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            multi_close_instance_on_signal(m, touched);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * If=
 dispatch produced any pending output</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+         * for a particular instance, point to</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+         * that instance.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (m-&gt;pending)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            mi =3D m-&gt;pending;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /*</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+         * Based on the effects of the action,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         * such as generating pe=
nding output,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * possibly transition to a new action state.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        action =3D multi_protocol_post(m, mi, action);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        /*</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         * If we are finished processing the ori=
ginal action,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * check if we have any TUN input.  If so, transition</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * our action state to processi=
ng this input.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
    */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (t=
un_input_pending &amp;&amp; action =3D=3D TA_UNDEF)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            action =3D TA_TUN_READ;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            mi =3D NULL;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            tun_input_pending =
=3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   poll =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            poll =3D true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    } while (action !=3D TA_UNDEF);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_proto=
col_delete_event(struct multi_protocol *multi_io, event_t event)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (multi_io &amp;&amp; multi_io-&gt;es)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        event_del(multi_io-&gt;es, ev=
ent);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git=
 a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h</span><br><span>new file=
 mode 100644</span><br><span>index 0000000..07fc935</span><br><span>--- /de=
v/null</span><br><span>+++ b/src/openvpn/multi_io.h</span><br><span>@@ -0,0=
 +1,77 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applicati=
on to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             over a single TCP/UDP port, with support for S=
SL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
        session authentication and key exchange,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             packet encryption, packet authe=
ntication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          packet compression.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Cop=
yright (C) 2002-2023 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  This program is free software; you can redistribute=
 it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  it under the terms of the GNU General Public License version 2</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free S=
oftware Foundation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program =
is distributed in the hope that it will be useful,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even t=
he implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Lic=
ense for more details.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should=
 have received a copy of the GNU General Public License along</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, wr=
ite to the Free Software Foundation, Inc.,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 0211=
0-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Multi-protocol specific code for --mode server</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifndef MULTI_IO_H</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define MULTI_IO_H</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;event.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * I/O processing States</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define TA_UNDEF                 0</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define TA_SOCKET_READ           1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define TA_SOCKET_READ_RESIDUAL  2</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TA_SOCKET_WRI=
TE          3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e TA_SOCKET_WRITE_READY    4</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define TA_SOCKET_WRITE_DEFERRED 5</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define TA_TUN_READ              6</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define TA_TUN_WRITE             7</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TA_INITIAL   =
            8</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e TA_TIMEOUT               9</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define TA_TUN_WRITE_TIMEOUT     10</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Extra st=
ate info needed for Multi-protocol</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
truct multi_protocol</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct event_=
set *es;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
event_set_return *esr;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int n_esr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int maxevents;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 unsigned int tun_rwflags;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    unsigned int udp_flags;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    unsigned int management_persist_flags;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct=
 multi_protocol *multi_protocol_init(int maxevents, int *maxclients);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void multi_protocol_free(struct multi_protoc=
ol *multi_io);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+int multi_protocol_io_wa=
it(struct multi_context *m);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void multi=
_protocol_process_io(struct multi_context *m);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void multi_protocol_action(struct multi_context *m, struct multi_in=
stance *mi, int action, bool poll);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d multi_protocol_delete_event(struct multi_protocol *multi_io, event_t even=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef MULTI_IO_H */</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/763?usp=3Demail">change 763</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/763?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1e5a84969988e4f027a18658d4a=
b268c13fbf929 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 763 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--VJrXqHgi6vg=--

