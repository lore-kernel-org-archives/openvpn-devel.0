From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 24 Jan 2025 13:43:40 +0000
In-Reply-To: <gerrit.1727098847000.I1e5a84969988e4f027a18658d4ab268c13fbf929@...2715...>
References: <gerrit.1727098847000.I1e5a84969988e4f027a18658d4ab268c13fbf929@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <d7dbaa780f89fbb6fdc33b65a12772136f5824ca-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eH90Z058Qqk="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eH90Z058Qqk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/76=
3?usp=3Demail )

Change subject: multiproto: move generic event handling code in dedicated f=
iles
......................................................................

multiproto: move generic event handling code in dedicated files

    Introduced multi_io.h and multi_io.c files to centralize
    all codes related to multiple protocols.

    Renamed the struct mtcp to struct multi_io since it
    encompasses the event_set used by the parent context in server mode.

    Several methods have also been renamed and moved to fit the
    multiproto structure:

    - multi_tcp_init() -> multi_io_init();
    - multi_tcp_free() -> multi_io_free();
    - multi_tcp_wait() -> multi_io_wait();
    and so forth.

Change-Id: I1e5a84969988e4f027a18658d4ab268c13fbf929
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250124115849.14638-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
561.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M src/openvpn/Makefile.am
M src/openvpn/forward.h
M src/openvpn/mtcp.c
M src/openvpn/mtcp.h
M src/openvpn/multi.c
M src/openvpn/multi.h
A src/openvpn/multi_io.c
A src/openvpn/multi_io.h
9 files changed, 751 insertions(+), 620 deletions(-)




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
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index b5bbf13..6d1d5a0 100644
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
@@ -68,52 +46,7 @@
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
+struct multi_instance *
 multi_create_instance_tcp(struct multi_context *m, struct link_socket *ls)
 {
     struct gc_arena gc =3D gc_new();
@@ -193,139 +126,42 @@
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
+multi_tcp_delete_event(struct multi_io *multi_io, event_t event)
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
-{
-    if (mtcp)
-    {
-        event_free(mtcp->es);
-        free(mtcp->esr);
-        free(mtcp);
-    }
-}
-
-void
-multi_tcp_dereference_instance(struct multi_tcp *mtcp, struct multi_instan=
ce *mi)
+multi_tcp_dereference_instance(struct multi_io *multi_io, struct multi_ins=
tance *mi)
 {
     struct link_socket *ls =3D mi->context.c2.link_sockets[0];
     if (ls && mi->socket_set_called)
     {
-        event_del(mtcp->es, socket_event_handle(ls));
+        event_del(multi_io->es, socket_event_handle(ls));
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
-multi_tcp_context(struct multi_context *m, struct multi_instance *mi)
-{
-    if (mi)
-    {
-        return &mi->context;
-    }
-    else
-    {
-        return &m->top;
-    }
-}
-
-static bool
+bool
 multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct mult=
i_instance *mi, const unsigned int mpp_flags)
 {
     struct mbuf_item item;
@@ -349,7 +185,7 @@
     return ret;
 }

-static bool
+bool
 multi_tcp_process_outgoing_link(struct multi_context *m, bool defer, const=
 unsigned int mpp_flags)
 {
     struct multi_instance *mi =3D multi_process_outgoing_link_pre(m);
@@ -393,417 +229,6 @@
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
@@ -851,7 +276,7 @@

         /* wait on tun/socket list */
         multi_get_timeout(&multi, &multi.top.c2.timeval);
-        status =3D multi_tcp_wait(&multi.top, multi.mtcp);
+        status =3D multi_io_wait(&multi);
         MULTI_CHECK_SIG(&multi);

         /* check on status of coarse timers */
@@ -861,12 +286,12 @@
         if (status > 0)
         {
             /* process the I/O which triggered select */
-            multi_tcp_process_io(&multi);
+            multi_io_process_io(&multi);
             MULTI_CHECK_SIG(&multi);
         }
         else if (status =3D=3D 0)
         {
-            multi_tcp_action(&multi, NULL, TA_TIMEOUT, false);
+            multi_io_action(&multi, NULL, TA_TIMEOUT, false);
         }

         perf_pop();
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index ab968e9..0da0a7d 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -30,34 +30,27 @@

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
+struct multi_context;
 struct multi_instance;
 struct context;

-struct multi_tcp *multi_tcp_init(int maxevents, int *maxclients);
-
-void multi_tcp_free(struct multi_tcp *mtcp);
-
-void multi_tcp_dereference_instance(struct multi_tcp *mtcp, struct multi_i=
nstance *mi);
+void multi_tcp_dereference_instance(struct multi_io *multi_io, struct mult=
i_instance *mi);

 bool multi_tcp_instance_specific_init(struct multi_context *m, struct mult=
i_instance *mi);

 void multi_tcp_instance_specific_free(struct multi_instance *mi);

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
struct link_socket *ls);
+
+void multi_tcp_link_out_deferred(struct multi_context *m, struct multi_ins=
tance *mi);
+
+
 /*************************************************************************=
*/
 /**
  * Main event loop for OpenVPN in TCP server mode.
@@ -68,6 +61,6 @@
 void tunnel_server_tcp(struct context *top);


-void multi_tcp_delete_event(struct multi_tcp *mtcp, event_t event);
+void multi_tcp_delete_event(struct multi_io *multi_io, event_t event);

 #endif /* ifndef MTCP_H */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f426b46..3f55dd7 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -440,7 +440,7 @@
      */
     if (tcp_mode)
     {
-        m->mtcp =3D multi_tcp_init(t->options.max_clients, &m->max_clients=
);
+        m->multi_io =3D multi_io_init(t->options.max_clients, &m->max_clie=
nts);
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
+        multi_io_free(m->multi_io);
     }
 }

@@ -3975,9 +3975,9 @@
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
index 9b6834a..eacfb52 100644
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
@@ -174,8 +175,7 @@
     struct mbuf_set *mbuf;      /**< Set of buffers for passing data
                                  *   channel packets between VPN tunnel
                                  *   instances. */
-    struct multi_tcp *mtcp;     /**< State specific to OpenVPN using TCP
-                                 *   as external transport. */
+    struct multi_io *multi_io;     /**< I/O state and events tracker */
     struct ifconfig_pool *ifconfig_pool;
     struct frequency_limit *new_connection_limiter;
     struct initial_packet_rate_limit *initial_rate_limiter;
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
new file mode 100644
index 0000000..e4174dd
--- /dev/null
+++ b/src/openvpn/multi_io.c
@@ -0,0 +1,632 @@
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
+static inline struct context *
+multi_get_context(struct multi_context *m, struct multi_instance *mi)
+{
+    if (mi)
+    {
+        return &mi->context;
+    }
+    else
+    {
+        return &m->top;
+    }
+}
+
+struct multi_io *
+multi_io_init(int maxevents, int *maxclients)
+{
+    struct multi_io *multi_io;
+    const int extra_events =3D BASE_N_EVENTS;
+
+    ASSERT(maxevents >=3D 1);
+    ASSERT(maxclients);
+
+    ALLOC_OBJ_CLEAR(multi_io, struct multi_io);
+    multi_io->maxevents =3D maxevents + extra_events;
+    multi_io->es =3D event_set_init(&multi_io->maxevents, 0);
+    wait_signal(multi_io->es, MULTI_IO_SIG);
+    ALLOC_ARRAY(multi_io->esr, struct event_set_return, multi_io->maxevent=
s);
+    *maxclients =3D max_int(min_int(multi_io->maxevents - extra_events, *m=
axclients), 1);
+    msg(D_MULTI_LOW, "MULTI IO: MULTI_IO INIT maxclients=3D%d maxevents=3D=
%d", *maxclients, multi_io->maxevents);
+    return multi_io;
+}
+
+void
+multi_io_free(struct multi_io *multi_io)
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
+multi_io_wait(struct multi_context *m)
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
+multi_io_wait_lite(struct multi_context *m, struct multi_instance *mi, con=
st int action, bool *tun_input_pending)
+{
+    struct context *c =3D multi_get_context(m, mi);
+    unsigned int looking_for =3D 0;
+
+    dmsg(D_MULTI_DEBUG, "MULTI IO: multi_io_wait_lite a=3D%s mi=3D" ptr_fo=
rmat,
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
+            msg(M_FATAL, "MULTI IO: multi_io_wait_lite, unhandled action=
=3D%d", action);
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
+multi_io_dispatch(struct multi_context *m, struct multi_instance *mi, cons=
t int action)
+{
+    const unsigned int mpp_flags =3D MPP_PRE_SELECT|MPP_RECORD_TOUCH;
+    struct multi_instance *touched =3D mi;
+    m->mpp_touched =3D &touched;
+
+    dmsg(D_MULTI_DEBUG, "MULTI IO: multi_io_dispatch a=3D%s mi=3D" ptr_for=
mat,
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
+            msg(M_FATAL, "MULTI IO: multi_io_dispatch, unhandled action=3D=
%d", action);
+    }
+
+    m->mpp_touched =3D NULL;
+    return touched;
+}
+
+static int
+multi_io_post(struct multi_context *m, struct multi_instance *mi, const in=
t action)
+{
+    struct context *c =3D multi_get_context(m, mi);
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
+            msg(M_FATAL, "MULTI IO: multi_io_post bad state, mi=3D%s flags=
=3D%d",
+                multi_instance_string(mi, false, &gc),
+                flags);
+            gc_free(&gc);
+            break;
+        }
+    }
+
+    dmsg(D_MULTI_DEBUG, "MULTI IO: multi_io_post %s -> %s",
+         pract(action),
+         pract(newaction));
+
+    return newaction;
+}
+
+void
+multi_io_process_io(struct multi_context *m)
+{
+    struct multi_io *multi_io =3D m->multi_io;
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
+                        msg(D_MULTI_ERRORS, "MULTI IO: multi_io_proc_io: n=
ull minstance");
+                        break;
+                    }
+
+                    mi =3D ev_arg->u.mi;
+                    if (e->rwflags & EVENT_WRITE)
+                    {
+                        multi_io_action(m, mi, TA_SOCKET_WRITE_READY, fals=
e);
+                    }
+                    else if (e->rwflags & EVENT_READ)
+                    {
+                        multi_io_action(m, mi, TA_SOCKET_READ, false);
+                    }
+                    break;
+
+                /* new incoming TCP client attempting to connect? */
+                case EVENT_ARG_LINK_SOCKET:
+                    if (!ev_arg->u.sock)
+                    {
+                        msg(D_MULTI_ERRORS, "MULTI IO: multi_io_proc_io: n=
ull socket");
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
+                            multi_io_action(m, mi, TA_INITIAL, false);
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
+                    multi_io_action(m, NULL, TA_TUN_WRITE, false);
+                }
+                else if (e->rwflags & EVENT_READ)
+                {
+                    multi_io_action(m, NULL, TA_TUN_READ, false);
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
+                    multi_io_action(m, mi, TA_INITIAL, false);
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
+            multi_io_action(m, mi, TA_SOCKET_WRITE, true);
+        }
+    }
+}
+
+void
+multi_io_action(struct multi_context *m, struct multi_instance *mi, int ac=
tion, bool poll)
+{
+    bool tun_input_pending =3D false;
+
+    do
+    {
+        dmsg(D_MULTI_DEBUG, "MULTI IO: multi_io_action a=3D%s p=3D%d",
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
+            action =3D multi_io_wait_lite(m, mi, action, &tun_input_pendin=
g);
+            if (action =3D=3D TA_UNDEF)
+            {
+                msg(M_FATAL, "MULTI IO: I/O wait required blocking in mult=
i_io_action, action=3D%d", orig_action);
+            }
+        }
+
+        /*
+         * Dispatch the action
+         */
+        struct multi_instance *touched =3D multi_io_dispatch(m, mi, action=
);
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
+        action =3D multi_io_post(m, mi, action);
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
+multi_io_delete_event(struct multi_io *multi_io, event_t event)
+{
+    if (multi_io && multi_io->es)
+    {
+        event_del(multi_io->es, event);
+    }
+}
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
new file mode 100644
index 0000000..03d708c
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
+ * I/O state and events tracker
+ */
+struct multi_io
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
+struct multi_io *multi_io_init(int maxevents, int *maxclients);
+
+void multi_io_free(struct multi_io *multi_io);
+
+int multi_io_wait(struct multi_context *m);
+
+void multi_io_process_io(struct multi_context *m);
+
+void multi_io_action(struct multi_context *m, struct multi_instance *mi, i=
nt action, bool poll);
+
+void multi_io_delete_event(struct multi_io *multi_io, event_t event);
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
Gerrit-PatchSet: 15
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--eH90Z058Qqk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/763?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">multiproto: move generic event handling code i=
n dedicated files<br><br>    Introduced multi_io.h and multi_io.c files to =
centralize<br>    all codes related to multiple protocols.<br><br>    Renam=
ed the struct mtcp to struct multi_io since it<br>    encompasses the event=
_set used by the parent context in server mode.<br><br>    Several methods =
have also been renamed and moved to fit the<br>    multiproto structure:<br=
><br>    - multi_tcp_init() -&gt; multi_io_init();<br>    - multi_tcp_free(=
) -&gt; multi_io_free();<br>    - multi_tcp_wait() -&gt; multi_io_wait();<b=
r>    and so forth.<br><br>Change-Id: I1e5a84969988e4f027a18658d4ab268c13fb=
f929<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br=
>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250124=
115849.14638-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/ope=
nvpn-devel@lists.sourceforge.net/msg30561.html<br>Signed-off-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M src/openvpn/Make=
file.am<br>M src/openvpn/forward.h<br>M src/openvpn/mtcp.c<br>M src/openvpn=
/mtcp.h<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>A src/openvpn/=
multi_io.c<br>A src/openvpn/multi_io.h<br>9 files changed, 751 insertions(+=
), 620 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 9ffcc=
89..ea8d006 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -458,6 +458,8 @@</span><br><span>     =
src/openvpn/mudp.h</span><br><span>     src/openvpn/multi.c</span><br><span=
>     src/openvpn/multi.h</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    src/openvpn/multi_io.h</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    src/openvpn/multi_io.c</span><br><span>     src/openvpn/nt=
lm.c</span><br><span>     src/openvpn/ntlm.h</span><br><span>     src/openv=
pn/occ.c</span><br><span>diff --git a/src/openvpn/Makefile.am b/src/openvpn=
/Makefile.am</span><br><span>index d6d6592..37af683 100644</span><br><span>=
--- a/src/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.am=
</span><br><span>@@ -93,6 +93,7 @@</span><br><span> 	mtu.c mtu.h \</span><b=
r><span> 	mudp.c mudp.h \</span><br><span> 	multi.c multi.h \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	multi_io.c multi_io.h \</span><b=
r><span> 	networking_freebsd.c \</span><br><span> 	networking_iproute2.c ne=
tworking_iproute2.h \</span><br><span> 	networking_sitnl.c networking_sitnl=
.h \</span><br><span>diff --git a/src/openvpn/forward.h b/src/openvpn/forwa=
rd.h</span><br><span>index ca2a695..214a322 100644</span><br><span>--- a/sr=
c/openvpn/forward.h</span><br><span>+++ b/src/openvpn/forward.h</span><br><=
span>@@ -50,6 +50,7 @@</span><br><span> #include &quot;openvpn.h&quot;</spa=
n><br><span> #include &quot;occ.h&quot;</span><br><span> #include &quot;pin=
g.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;multi_io.h&quot;</span><br><span> </span><br><span> #define IOW_TO_TUN=
          (1&lt;&lt;0)</span><br><span> #define IOW_TO_LINK         (1&lt;&=
lt;1)</span><br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c<=
/span><br><span>index b5bbf13..6d1d5a0 100644</span><br><span>--- a/src/ope=
nvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -29=
,6 +29,8 @@</span><br><span> </span><br><span> #include &quot;multi.h&quot;=
</span><br><span> #include &quot;forward.h&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;mtcp.h&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi_io.h&quot;</span>=
<br><span> </span><br><span> #include &quot;memdbg.h&quot;</span><br><span>=
 </span><br><span>@@ -36,30 +38,6 @@</span><br><span> #include &lt;sys/inot=
ify.h&gt;</span><br><span> #endif</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * TCP States</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TA_UN=
DEF                 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define TA_SOCKET_READ           1</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define TA_SOCKET_READ_RESIDUAL  2</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#define TA_SOCKET_WRITE          3</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#define TA_SOCKET_WRITE_READY    4</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TA_SOCKET_WRITE=
_DEFERRED 5</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TA=
_TUN_READ              6</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define TA_TUN_WRITE             7</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define TA_INITIAL               8</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define TA_TIMEOUT               9</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define TA_TUN_WRITE_TIMEOUT     =
10</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * Special tags passed to event.[ch] functions</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define MTCP_TUN         ((void *)2)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define MTCP_SIG         ((void *)3) =
/* Only on Windows */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define MTCP_MANAGEMENT ((void *)4)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define MTCP_FILE_CLOSE_WRITE ((void *)5)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define MTCP_DCO        ((void *)6)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> struct ta=
_iow_flags</span><br><span> {</span><br><span>     unsigned int flags;</spa=
n><br><span>@@ -68,52 +46,7 @@</span><br><span>     unsigned int sock;</spa=
n><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-static const char *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-pract(int action)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (acti=
on)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        case TA_UNDEF:</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            return &quot;TA_UNDEF=
&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKET_READ:</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            return &quot;TA_=
SOCKET_READ&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKET_R=
EAD_RESIDUAL:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    return &quot;TA_SOCKET_READ_RESIDUAL&quot;;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        case TA_SOCKET_WRITE:</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            return &quot;TA_SOCKET_WRITE&quot;;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        case TA_SOCKET_WRITE_READY:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            return &quot;TA_SOCKET_WRITE_RE=
ADY&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKET_WRITE_DEF=
ERRED:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret=
urn &quot;TA_SOCKET_WRITE_DEFERRED&quot;;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       case TA_TUN_READ:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            return &quot;TA_TUN_READ&quot;;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        case TA_TUN_WRITE:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            return &quot;TA_TUN_WRITE&quot;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        case TA_INITIAL:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            return &quot;TA_INITIAL&quot;;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        case TA_TIMEOUT:</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            return &quot;TA_TIMEOUT&quot;;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        case TA_TUN_WRITE_TIMEOUT:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            return &quot;TA_TUN_WRITE_TIMEO=
UT&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        default:</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            return &quot;?&quot;;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif /* ENABLE_DEBUG */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic struct multi_instance *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+struct multi_instance *</span><br><span> multi_create_instance_tcp(s=
truct multi_context *m, struct link_socket *ls)</span><br><span> {</span><b=
r><span>     struct gc_arena gc =3D gc_new();</span><br><span>@@ -193,139 +=
126,42 @@</span><br><span>     mbuf_free(mi-&gt;tcp_link_out_deferred);</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-struct multi_tcp *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-multi_tcp_init(int maxevents, int *maxclients)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct multi_tcp *mtcp;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    const int extra_events =3D BASE_N_EVENTS;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    ASSERT(maxevents &gt;=3D 1);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    ASSERT(maxclients);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    ALLOC_OBJ_CLEAR(mtcp, struct multi_tcp);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    mtcp-&gt;maxevents =3D maxevents =
+ extra_events;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mt=
cp-&gt;es =3D event_set_init(&amp;mtcp-&gt;maxevents, 0);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    wait_signal(mtcp-&gt;es, MTCP_SIG);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_ARRAY(mtcp-=
&gt;esr, struct event_set_return, mtcp-&gt;maxevents);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    *maxclients =3D max_int(min_int(mtcp-&=
gt;maxevents - extra_events, *maxclients), 1);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    msg(D_MULTI_LOW, &quot;MULTI: TCP INIT maxclie=
nts=3D%d maxevents=3D%d&quot;, *maxclients, mtcp-&gt;maxevents);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return mtcp;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-multi_tcp_delete_event(struct multi_tcp *mtcp, event_t e=
vent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_tcp_dele=
te_event(struct multi_io *multi_io, event_t event)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mtcp &amp;&amp; mtc=
p-&gt;es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mu=
lti_io &amp;&amp; multi_io-&gt;es)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        event_del(mtcp-&gt;es, event);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        event_del(mu=
lti_io-&gt;es, event);</span><br><span>     }</span><br><span> }</span><br>=
<span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-multi_tcp_free(struct multi_tcp *mtcp)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (mtcp)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        event_free(=
mtcp-&gt;es);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
free(mtcp-&gt;esr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      free(mtcp);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mul=
ti_tcp_dereference_instance(struct multi_tcp *mtcp, struct multi_instance *=
mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_tcp_derefe=
rence_instance(struct multi_io *multi_io, struct multi_instance *mi)</span>=
<br><span> {</span><br><span>     struct link_socket *ls =3D mi-&gt;context=
.c2.link_sockets[0];</span><br><span>     if (ls &amp;&amp; mi-&gt;socket_s=
et_called)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        event_del(mtcp-&gt;es, socket_event_handle(ls));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        event_del(multi_io=
-&gt;es, socket_event_handle(ls));</span><br><span>         mi-&gt;socket_s=
et_called =3D false;</span><br><span>     }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    mtcp-&gt;n_esr =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    multi_io-&gt;n_esr =3D 0;</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
atic inline void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span> multi_tcp_set_global_rw_flags(struct multi_context *m, s=
truct multi_instance *mi)</span><br><span> {</span><br><span>     if (mi)</=
span><br><span>     {</span><br><span>         mi-&gt;socket_set_called =3D=
 true;</span><br><span>         socket_set(mi-&gt;context.c2.link_sockets[0=
],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
m-&gt;mtcp-&gt;es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                  m-&gt;multi_io-&gt;es,</span><br><span>                  =
  mbuf_defined(mi-&gt;tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,</s=
pan><br><span>                    &amp;mi-&gt;ev_arg,</span><br><span>     =
               &amp;mi-&gt;tcp_rwflags);</span><br><span>     }</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
multi_tcp_wait(const struct context *c,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-               struct multi_tcp *mtcp)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    int status;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    unsigned int *persistent =3D &amp;mtcp-&gt;tun_rwflags;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; c-&gt;c1.link_socket=
s_num; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        socket_set_listen_=
persistent(c-&gt;c2.link_sockets[i], mtcp-&gt;es,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                                     &amp;c-&gt=
;c2.link_sockets[i]-&gt;ev_arg);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (tuntap_is_wintun(c-&gt;c1.=
tuntap))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!tuntap_ring_empt=
y(c-&gt;c1.tuntap))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /*=
 there is data in wintun ring buffer, read it immediately */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            mtcp-&gt;esr[0].arg =3D =
MTCP_TUN;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
mtcp-&gt;esr[0].rwflags =3D EVENT_READ;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            mtcp-&gt;n_esr =3D 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            return 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        persistent =3D NULL;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
tun_set(c-&gt;c1.tuntap, mtcp-&gt;es, EVENT_READ, MTCP_TUN, persistent);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX=
) || defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    dco_event_set(&amp;c-&gt;c1.tuntap-&gt;dco, mtcp-&gt;es, MTCP_DC=
O);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (management)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        management_socket_set(management, mtcp-&gt;es, MTCP_MANAGEMEN=
T, &amp;mtcp-&gt;management_persist_flags);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* arm inotify watcher =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    event_ctl(mtcp-=
&gt;es, c-&gt;c2.inotify_fd, EVENT_READ, MTCP_FILE_CLOSE_WRITE);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    status =3D event_wait(mtcp-&gt;es, &amp;c-&gt;c2.timeval, mtcp-&=
gt;esr, mtcp-&gt;maxevents);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    update_time();</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    mtcp-&gt;n_esr =3D 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (status &gt; 0)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 mtcp-&gt;n_esr =3D status;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static inline struct context *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-multi_tcp_context(struct multi_context *m, =
struct multi_instance *mi)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mi)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        return &amp;mi-&gt;context;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        return &amp;m-&gt;top;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool</span><br><span> multi_tcp_process_outgoing_li=
nk_ready(struct multi_context *m, struct multi_instance *mi, const unsigned=
 int mpp_flags)</span><br><span> {</span><br><span>     struct mbuf_item it=
em;</span><br><span>@@ -349,7 +185,7 @@</span><br><span>     return ret;</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-static bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+bool</span><br><span> multi_tcp_process_outgoing_link(struct multi_con=
text *m, bool defer, const unsigned int mpp_flags)</span><br><span> {</span=
><br><span>     struct multi_instance *mi =3D multi_process_outgoing_link_p=
re(m);</span><br><span>@@ -393,417 +229,6 @@</span><br><span>     return re=
t;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-multi_tcp_wait_lite(struct multi_context *m, struct multi_instance *=
mi, const int action, bool *tun_input_pending)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct context *c =3D multi_tcp_context(m, mi);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    unsigned int looking_for =3D 0;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    dmsg(D_MULTI_DEBUG, &quot;MULTI TCP: multi_=
tcp_wait_lite a=3D%s mi=3D&quot; ptr_format,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-         pract(action),</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-         (ptr_type)mi);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    tv_clear(&amp;c-&gt;c2.timeval); /* ZERO-TIMEOUT */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    switch (action)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        case TA_TUN_READ:</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            looking_for =3D TUN_READ;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            tun_input_pending =3D NULL;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            io_wait(c, IOW_READ_TUN)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKET_READ:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            looking_for =3D SOCKET_R=
EAD;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            tun_i=
nput_pending =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            io_wait(c, IOW_READ_LINK);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  case TA_TUN_WRITE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           looking_for =3D TUN_WRITE;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            tun_input_pending =3D NULL;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            c-&gt;c2.timeval.tv_sec =3D 1=
; /* For some reason, the Linux 2.2 TUN/TAP driver hits this timeout */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            perf_push(PER=
F_PROC_OUT_TUN_MTCP);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            io_wait(c, IOW_TO_TUN);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            perf_pop();</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
case TA_SOCKET_WRITE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            looking_for =3D SOCKET_WRITE;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            io_wait(c, IOW_TO_LINK|IOW_READ_TUN_FORCE);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        default:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;MULTI TCP: multi_=
tcp_wait_lite, unhandled action=3D%d&quot;, action);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (tun_input_pending &amp;&amp; (c-&gt;c2.event_set_status &amp; TUN_READ))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        *tun_input_pending =3D true;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (c-&gt;c2.event_set_status &amp; looking_for)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return action;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        swit=
ch (action)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* TCP soc=
ket output buffer is full */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            case TA_SOCKET_WRITE:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                return TA_SOCKET_WRITE_DEFERRED;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            /* TUN device timed out on accepting w=
rite */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ca=
se TA_TUN_WRITE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           return TA_TUN_WRITE_TIMEOUT;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return =
TA_UNDEF;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-static struct multi_instance *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-multi_tcp_dispatch(struct multi_context *m, struct multi_ins=
tance *mi, const int action)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const uns=
igned int mpp_flags =3D MPP_PRE_SELECT|MPP_RECORD_TOUCH;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct multi_instance *touched =3D m=
i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;mpp_touch=
ed =3D &amp;touched;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_MULTI_DEBUG=
, &quot;MULTI TCP: multi_tcp_dispatch a=3D%s mi=3D&quot; ptr_format,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-         pract(action),</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-         (ptr_type)mi);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    switch (action)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        case TA_TUN_READ:</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            read_incoming_tun(&amp;m-&gt;top);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            if (!IS_SIG(&amp;m=
-&gt;top))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                mul=
ti_process_incoming_tun(m, mpp_flags);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA=
_SOCKET_READ:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
case TA_SOCKET_READ_RESIDUAL:</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            ASSERT(mi);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            ASSERT(mi-&gt;context.c2.link_sockets);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(mi-&gt;context.c=
2.link_sockets[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          set_prefix(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            read_incoming_link(&amp;mi-&gt;context, mi-&gt;context.c2.l=
ink_sockets[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       clear_prefix();</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            if (!IS_SIG(&amp;mi-&gt;context))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                multi_process_incoming_link(m, mi, mpp_fla=
gs,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
                          mi-&gt;context.c2.link_sockets[0]);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                if (!IS_SIG(&amp;mi=
-&gt;context))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         stream_buf_read_setup(mi-&gt;context.c2.link_sockets[0]);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        case TA_TIMEOUT:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            multi_process_timeout(m, mpp_flags);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        case TA_TUN_WRITE:</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            multi_process_outgoing_tun(m, mpp_flags);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        case TA_TUN_WRITE_TIMEOUT:</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            multi_process_drop=
_outgoing_tun(m, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_S=
OCKET_WRITE_READY:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         ASSERT(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           multi_tcp_process_outgoing_link_ready(m, mi, mpp_flags);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        case TA_SOCKET_WRITE:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            multi_tcp_process_outgoing_link=
(m, false, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKET_=
WRITE_DEFERRED:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      multi_tcp_process_outgoing_link(m, true, mpp_flags);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        case TA_INITIAL:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            ASSERT(mi);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            multi_tcp_set_global_rw_flags(m, mi);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_process_pos=
t(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        default:</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot=
;MULTI TCP: multi_tcp_dispatch, unhandled action=3D%d&quot;, action);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    m-&gt;mpp_touched =3D NULL;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return touched;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_post(struct multi_conte=
xt *m, struct multi_instance *mi, const int action)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct context *c =3D multi_tcp_context(m, mi);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    int newaction =3D TA_UNDEF;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define MTP_NONE         0</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define MTP_TUN_OUT      (1&lt;&lt;0)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define MTP_LINK_OUT  =
   (1&lt;&lt;1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    un=
signed int flags =3D MTP_NONE;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (TUN_=
OUT(c))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        flags |=3D MTP_TUN_OUT=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (LINK_OUT(c))</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        flags |=3D MTP_LINK_OUT;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
switch (flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case MTP_TUN_OU=
T|MTP_LINK_OUT:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  case MTP_TUN_OUT:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          newaction =3D TA_TUN_WRITE;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
case MTP_LINK_OUT:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         newaction =3D TA_SOCKET_WRITE;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  case MTP_NONE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       if (mi &amp;&amp; sockets_read_residual(c))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                newaction =3D TA_SOCKET_READ_RESIDUAL;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            else</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                multi_tcp_set_global_rw_fl=
ags(m, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        default:</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            struct gc_arena gc =3D gc_new();</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;MULTI=
 TCP: multi_tcp_post bad state, mi=3D%s flags=3D%d&quot;,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                multi_instance_string(m=
i, false, &amp;gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_MULTI_DEBUG, &quot;MULTI TCP: mu=
lti_tcp_post %s -&gt; %s&quot;,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-         pract(action),</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-         pract(newaction));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return newaction;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-multi_tcp_action(struct multi_context *m, struct mult=
i_instance *mi, int action, bool poll)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 bool tun_input_pending =3D false;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    do</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_MULTI_DEBUG, &quot;MULTI=
 TCP: multi_tcp_action a=3D%s p=3D%d&quot;,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-             pract(action),</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-             poll);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
   * If TA_SOCKET_READ_RESIDUAL, it means we still have pending</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-         * input packets which we=
re read by a prior TCP recv.</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-         *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
     * Otherwise do a &quot;lite&quot; wait, which means we wait with 0 tim=
eout</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * on I/O=
 events only related to the current instance, not</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-         * the big list of events.</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-         *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         * On our first pass, poll will be =
false because we already know</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-         * that input is available, and to call io_wait would be re=
dundant.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (poll &amp;&=
amp; action !=3D TA_SOCKET_READ_RESIDUAL)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            const int orig_action =3D action;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            action =3D multi_tcp_wait_lite(=
m, mi, action, &amp;tun_input_pending);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            if (action =3D=3D TA_UNDEF)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                msg(M_FATAL, &quot;MULTI TCP: I=
/O wait required blocking in multi_tcp_action, action=3D%d&quot;, orig_acti=
on);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        /*</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-         * Dispatch the action</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        struct multi_instance *touched =3D multi_tcp_dispatch(m, mi, a=
ction);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-         * Signal received or TCP connection</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * reset by pee=
r?</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (touched &amp;&amp=
; IS_SIG(&amp;touched-&gt;context))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            if (mi =3D=3D touched)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                mi =3D NULL;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            multi_close_instance_on_signal(m, touched);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-         * If dispatch pr=
oduced any pending output</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-         * for a particular instance, point to</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-         * that instance.</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (m-&gt;pending)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            mi =3D m-&gt;pending;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * Based=
 on the effects of the action,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-         * such as generating pending output,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-         * possibly transition to a new ac=
tion state.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        action =3D m=
ulti_tcp_post(m, mi, action);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-         * If we are fin=
ished processing the original action,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-         * check if we have any TUN input.  If so, transiti=
on</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * our acti=
on state to processing this input.</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (tun_input_pending &amp;&amp; action =3D=3D TA_UNDEF)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            action =3D TA_TUN_READ;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            mi =3D NULL;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            tun_input_pe=
nding =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       poll =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        els=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            poll =3D true;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    } while (action !=3D TA_UNDEF);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_process_io(s=
truct multi_context *m)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_t=
cp *mtcp =3D m-&gt;mtcp;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; mtcp=
-&gt;n_esr; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct event_=
set_return *e =3D &amp;mtcp-&gt;esr[i];</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     /* incoming data for instance or listening socket? */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (e-&gt;arg &gt;=3D MULTI_N)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            struct event_arg *ev_=
arg =3D (struct event_arg *)e-&gt;arg;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            switch (ev_arg-&gt;type)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                struct multi_instance *mi;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                /* react to event on child instance=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ca=
se EVENT_ARG_MULTI_INSTANCE:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    if (!ev_arg-&gt;u.mi)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        msg(D_MULTI_ERRORS, &quo=
t;MULTI: mtcp_proc_io: null minstance&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                        break;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    mi =3D ev_arg-&gt;u.mi;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    if (e-&gt;rwflags &am=
p; EVENT_WRITE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  multi_tcp_action(m, mi, TA_SOCKET_WRITE_READY, false);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    else=
 if (e-&gt;rwflags &amp; EVENT_READ)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                        multi_tcp_action(m, mi, TA_SOCKET_RE=
AD, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* new inc=
oming TCP client attempting to connect? */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                case EVENT_ARG_LINK_SOCKET:</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    if (!ev_arg-=
&gt;u.sock)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              msg(D_MULTI_ERRORS, &quot;MULTI: mtcp_proc_io: null socket&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
        break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    socket_r=
eset_listen_persistent(ev_arg-&gt;u.sock);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    mi =3D multi_create_instance_tcp(m=
, ev_arg-&gt;u.sock);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    if (mi)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                        multi_tcp_action(m, mi, TA_INITIAL, false);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    bre=
ak;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            if (e-&gt;arg =3D=3D MTCP_MANAGEMENT)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                ASSERT(management);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                manage=
ment_io(management);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            /* incoming data =
on TUN? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (e-&gt;arg =3D=3D MTCP_TUN)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                if (e-&gt;rwflags &amp; EVENT_WRITE)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    multi_tcp_action(m, NULL, =
TA_TUN_WRITE, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            else if (e-&gt;rwflags &amp; EVENT_READ)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    multi_tcp_action(m, NULL, T=
A_TUN_READ, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(EN=
ABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* incoming d=
ata on DCO? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     else if (e-&gt;arg =3D=3D MTCP_DCO)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                multi_process_incoming_dco(m);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            /* signal received? */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            else if (e-&gt;arg =3D=3D MTCP_SIG)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                get_signal(&amp=
;m-&gt;top.sig-&gt;signal_received);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            else if (e-&gt;arg =3D=3D MTCP_FILE_CLOSE_WRITE)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                multi_process_file=
_closed(m, MPP_PRE_SELECT | MPP_RECORD_TOUCH);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (IS_SIG(&amp;m-&gt;top))</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    mtcp-&gt;n_esr =3D 0;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     * Process queued mbuf packets destined for TCP socket</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        struct multi_instance *mi;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        while (!IS_SIG(&amp;m-&gt;top) &amp;&amp; (=
mi =3D mbuf_peek(m-&gt;mbuf)) !=3D NULL)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            multi_tcp_action(m, mi, TA_SOCKET_WRITE, true);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> /*</span><br><span>  * Top level event loop for single-threa=
ded operation.</span><br><span>  * TCP mode.</span><br><span>@@ -851,7 +276=
,7 @@</span><br><span> </span><br><span>         /* wait on tun/socket list=
 */</span><br><span>         multi_get_timeout(&amp;multi, &amp;multi.top.c=
2.timeval);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        st=
atus =3D multi_tcp_wait(&amp;multi.top, multi.mtcp);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        status =3D multi_io_wait(&amp;mul=
ti);</span><br><span>         MULTI_CHECK_SIG(&amp;multi);</span><br><span>=
 </span><br><span>         /* check on status of coarse timers */</span><br=
><span>@@ -861,12 +286,12 @@</span><br><span>         if (status &gt; 0)</s=
pan><br><span>         {</span><br><span>             /* process the I/O wh=
ich triggered select */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            multi_tcp_process_io(&amp;multi);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            multi_io_process_io(&amp;multi);</s=
pan><br><span>             MULTI_CHECK_SIG(&amp;multi);</span><br><span>   =
      }</span><br><span>         else if (status =3D=3D 0)</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 multi_tcp_action(&amp;multi, NULL, TA_TIMEOUT, false);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            multi_io_action(&amp;multi,=
 NULL, TA_TIMEOUT, false);</span><br><span>         }</span><br><span> </sp=
an><br><span>         perf_pop();</span><br><span>diff --git a/src/openvpn/=
mtcp.h b/src/openvpn/mtcp.h</span><br><span>index ab968e9..0da0a7d 100644</=
span><br><span>--- a/src/openvpn/mtcp.h</span><br><span>+++ b/src/openvpn/m=
tcp.h</span><br><span>@@ -30,34 +30,27 @@</span><br><span> </span><br><span=
> #include &quot;event.h&quot;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * Extra state info needed for TCP mode</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-struct multi_tcp</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct event_=
set *es;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct ev=
ent_set_return *esr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int n_esr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int =
maxevents;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigne=
d int tun_rwflags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
def ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    unsigned int management_persist_flags;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+struct multi_context;</span><br>=
<span> struct multi_instance;</span><br><span> struct context;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct multi_tcp=
 *multi_tcp_init(int maxevents, int *maxclients);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void multi_tcp_free(struct multi_tcp *mtcp);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void multi_tcp_dereference_instance(struct multi_tcp *mtcp, stru=
ct multi_instance *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void multi_tcp_dereference_instance(struct multi_io *multi_io, struct m=
ulti_instance *mi);</span><br><span> </span><br><span> bool multi_tcp_insta=
nce_specific_init(struct multi_context *m, struct multi_instance *mi);</spa=
n><br><span> </span><br><span> void multi_tcp_instance_specific_free(struct=
 multi_instance *mi);</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void multi_tcp_set_global_rw_flags(struct multi_context=
 *m, struct multi_instance *mi);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool m=
ulti_tcp_process_outgoing_link(struct multi_context *m, bool defer, const u=
nsigned int mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool multi_tcp_=
process_outgoing_link_ready(struct multi_context *m, struct multi_instance =
*mi, const unsigned int mpp_flags);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+str=
uct multi_instance *multi_create_instance_tcp(struct multi_context *m, stru=
ct link_socket *ls);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void multi_tcp_lin=
k_out_deferred(struct multi_context *m, struct multi_instance *mi);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> /***************************=
***********************************************/</span><br><span> /**</span=
><br><span>  * Main event loop for OpenVPN in TCP server mode.</span><br><s=
pan>@@ -68,6 +61,6 @@</span><br><span> void tunnel_server_tcp(struct contex=
t *top);</span><br><span> </span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void multi_tcp_delete_event(struct multi_tcp *mtcp, =
event_t event);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
 multi_tcp_delete_event(struct multi_io *multi_io, event_t event);</span><b=
r><span> </span><br><span> #endif /* ifndef MTCP_H */</span><br><span>diff =
--git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index f42=
6b46..3f55dd7 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><s=
pan>+++ b/src/openvpn/multi.c</span><br><span>@@ -440,7 +440,7 @@</span><br=
><span>      */</span><br><span>     if (tcp_mode)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m-&gt;mtcp =3D =
multi_tcp_init(t-&gt;options.max_clients, &amp;m-&gt;max_clients);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        m-&gt;multi_io =3D m=
ulti_io_init(t-&gt;options.max_clients, &amp;m-&gt;max_clients);</span><br>=
<span>     }</span><br><span>     m-&gt;tcp_queue_limit =3D t-&gt;options.t=
cp_queue_limit;</span><br><span> </span><br><span>@@ -665,9 +665,9 @@</span=
><br><span>             mi-&gt;did_iroutes =3D false;</span><br><span>     =
    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (m-&gt;mtcp)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (m-&gt;multi_io)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            multi_tcp_dereference_in=
stance(m-&gt;mtcp, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            multi_tcp_dereference_instance(m-&gt;multi_io, mi);</span><=
br><span>         }</span><br><span> </span><br><span>         mbuf_derefer=
ence_instance(m-&gt;mbuf, mi);</span><br><span>@@ -742,7 +742,7 @@</span><b=
r><span>         initial_rate_limit_free(m-&gt;initial_rate_limiter);</span=
><br><span>         multi_reap_free(m-&gt;reaper);</span><br><span>        =
 mroute_helper_free(m-&gt;route_helper);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        multi_tcp_free(m-&gt;mtcp);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        multi_io_free(m-&gt;multi_io);</=
span><br><span>     }</span><br><span> }</span><br><span> </span><br><span>=
@@ -3975,9 +3975,9 @@</span><br><span> management_delete_event(void *arg, e=
vent_t event)</span><br><span> {</span><br><span>     struct multi_context =
*m =3D (struct multi_context *) arg;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (m-&gt;mtcp)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (m-&gt;multi_io)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        multi_tcp_delete_event(m-&g=
t;mtcp, event);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    multi_tcp_delete_event(m-&gt;multi_io, event);</span><br><span>     }</=
span><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvp=
n/multi.h b/src/openvpn/multi.h</span><br><span>index 9b6834a..eacfb52 1006=
44</span><br><span>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/open=
vpn/multi.h</span><br><span>@@ -38,6 +38,7 @@</span><br><span> #include &qu=
ot;pool.h&quot;</span><br><span> #include &quot;mudp.h&quot;</span><br><spa=
n> #include &quot;mtcp.h&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;multi_io.h&quot;</span><br><span> #include &quot;=
perf.h&quot;</span><br><span> #include &quot;vlan.h&quot;</span><br><span> =
#include &quot;reflect_filter.h&quot;</span><br><span>@@ -174,8 +175,7 @@</=
span><br><span>     struct mbuf_set *mbuf;      /**&lt; Set of buffers for =
passing data</span><br><span>                                  *   channel =
packets between VPN tunnel</span><br><span>                                =
  *   instances. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct multi_tcp *mtcp;     /**&lt; State specific to OpenVPN using TCP</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
          *   as external transport. */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct multi_io *multi_io;     /**&lt; I/O state an=
d events tracker */</span><br><span>     struct ifconfig_pool *ifconfig_poo=
l;</span><br><span>     struct frequency_limit *new_connection_limiter;</sp=
an><br><span>     struct initial_packet_rate_limit *initial_rate_limiter;</=
span><br><span>diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c=
</span><br><span>new file mode 100644</span><br><span>index 0000000..e4174d=
d</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/multi_io.=
c</span><br><span>@@ -0,0 +1,632 @@</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  OpenVPN -- An application to securely tunnel IP networks</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UD=
P port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             session authentication and key exchange,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packe=
t encryption, packet authentication, and</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             packet compression.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  Copyright (C) 2002-2023 OpenVPN Inc &lt;sales@...2146...=
...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free soft=
ware; you can redistribute it and/or modify</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Li=
cense version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
as published by the Free Software Foundation.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  This program is distributed in the hope that it will be useful=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT AN=
Y WARRANTY; without even the implied warranty of</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULA=
R PURPOSE.  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  GNU General Public License for more details.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  You should have received a copy of the GNU General Public L=
icense along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  wit=
h this program; if not, write to the Free Software Foundation, Inc.,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fi=
fth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFI=
G_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;c=
onfig.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead.h&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;memdbg.h&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;multi.h&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;forward.h&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi_io.h&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_SYS_INOTIFY_H</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &lt;sys/inotify.h&gt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Special tags passed to event.[ch] functions</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define MULTI_IO_SOCKET      ((void *)1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define MULTI_IO_TUN         ((void *)2)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MULTI_IO_SIG=
         ((void *)3) /* Only on Windows */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define MULTI_IO_MANAGEMENT ((void *)4)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define MULTI_IO_FILE_CLOSE_WRIT=
E ((void *)5)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e MULTI_IO_DCO        ((void *)6)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struc=
t ta_iow_flags</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int re=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int =
tun;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned in=
t sock;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifdef ENABLE_DEBUG</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static const char *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+pract(int action)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    switch (action)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 case TA_UNDEF:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        return &quot;TA_UNDEF&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      case TA_SOCKET_READ:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            return &quot;TA_SOCKET_READ&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        case TA_SOCKET_READ_RESIDUAL:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return &quot;TA_SOCKET_READ_R=
ESIDUAL&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        case TA_SOCKET_W=
RITE:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
turn &quot;TA_SOCKET_WRITE&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   case TA_SOCKET_WRITE_READY:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            return &quot;TA_SOCKET_WRITE_READY&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        case TA_SOCKET_WRITE_DEFERRED:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return &quot;TA_SO=
CKET_WRITE_DEFERRED&quot;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case=
 TA_TUN_READ:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      return &quot;TA_TUN_READ&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       case TA_TUN_WRITE:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            return &quot;TA_TUN_WRITE&quot;;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        case TA_INITIAL:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            return &quot;TA_INITIAL&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        case TA_TIMEOUT:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            return &quot;TA_TIMEOUT&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        case TA_TUN_WRITE_TIMEOUT:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return &quot;TA_TU=
N_WRITE_TIMEOUT&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        default:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return =
&quot;?&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif /* ENABLE_DEBUG */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static inline struct context *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+multi_get_context(struct multi_context =
*m, struct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return &amp;mi-&gt;co=
ntext;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return &amp;m-&gt;top;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct multi_io *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_io_init(int m=
axevents, int *maxclients)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
multi_io *multi_io;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const int extra_events =3D BASE_N_EVENTS;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ASSERT(maxevents &gt;=3D 1);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ASSERT(maxclients);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ALLOC_OBJ_CLEAR(multi_io, struct multi_io);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    multi_io-&gt;maxevents =3D maxevents =
+ extra_events;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
multi_io-&gt;es =3D event_set_init(&amp;multi_io-&gt;maxevents, 0);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    wait_signal(multi_io-&g=
t;es, MULTI_IO_SIG);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ALLOC_ARRAY(multi_io-&gt;esr, struct event_set_return, multi_io-&gt;ma=
xevents);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *maxcl=
ients =3D max_int(min_int(multi_io-&gt;maxevents - extra_events, *maxclient=
s), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_MU=
LTI_LOW, &quot;MULTI IO: MULTI_IO INIT maxclients=3D%d maxevents=3D%d&quot;=
, *maxclients, multi_io-&gt;maxevents);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return multi_io;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+multi_io_free(struct multi_io *=
multi_io)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi_io)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        event_free(multi_io-&gt;es);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        free(multi_io-&gt;e=
sr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(mu=
lti_io);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
ulti_io_wait(struct multi_context *m)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int status, i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   unsigned int *persistent =3D &amp;m-&gt;multi_io-&gt;tun_rwflags;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &lt; m-&gt;top.c1.link_so=
ckets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        socket_set=
_listen_persistent(m-&gt;top.c2.link_sockets[i], m-&gt;multi_io-&gt;es,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
              &amp;m-&gt;top.c2.link_sockets[i]-&gt;ev_arg);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (tuntap_is_wintun(m-&gt;top.c1.tuntap))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!tuntap_ring_empty(m-&gt;top.c1.tuntap))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            /* there is data in wintu=
n ring buffer, read it immediately */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            m-&gt;multi_io-&gt;esr[0].arg =3D MULTI_IO_TU=
N;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m-&gt=
;multi_io-&gt;esr[0].rwflags =3D EVENT_READ;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            m-&gt;multi_io-&gt;n_esr =3D 1;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            return 1;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        persistent =3D NULL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    tun_set(m-&gt;top.c1.tuntap, m-&gt;multi_io-&gt;=
es, EVENT_READ, MULTI_IO_TUN, persistent);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_event_set(&=
amp;m-&gt;top.c1.tuntap-&gt;dco, m-&gt;multi_io-&gt;es, MULTI_IO_DCO);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (management)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        management_socket_set(management, m-&gt;multi_io-&gt;es, =
MULTI_IO_MANAGEMENT, &amp;m-&gt;multi_io-&gt;management_persist_flags);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* arm inotify watcher */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    event_ctl(m-&gt;multi_io-&gt;es, m-&gt;top.c2.inot=
ify_fd, EVENT_READ, MULTI_IO_FILE_CLOSE_WRITE);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
status =3D event_wait(m-&gt;multi_io-&gt;es, &amp;m-&gt;top.c2.timeval, m-&=
gt;multi_io-&gt;esr, m-&gt;multi_io-&gt;maxevents);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    update_time();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    m-&gt;multi_io-&gt;n_esr =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (status &gt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        m-&gt;multi_io-&gt;n_esr =3D=
 status;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return status;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+multi_io_wait_lite(struct multi_context *m, struct multi_instance *mi, c=
onst int action, bool *tun_input_pending)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct context *c =3D multi_get_context(m, mi);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    unsigned int looking_for =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_MULTI_DEBUG, &quot;MULTI IO: m=
ulti_io_wait_lite a=3D%s mi=3D&quot; ptr_format,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+         pract(action),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         (ptr_type)mi);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    tv_clear(&amp;c-&gt;c2.timeval); /* ZERO-TIMEOUT */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    switch (action)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        case TA_TUN_READ:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            looking_for =3D TUN_READ;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            tun_input_pending=
 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   io_wait(c, IOW_READ_TUN);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cas=
e TA_SOCKET_READ:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          looking_for =3D SOCKET_READ;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            tun_input_pending =3D NULL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            io_wait(c, IOW_READ_LINK=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        case TA_TUN_WRITE:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            looking_for =3D TU=
N_WRITE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 tun_input_pending =3D NULL;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            c-&gt;c2.timeval.tv_sec =3D 1; /* For some reason, the=
 Linux 2.2 TUN/TAP driver hits this timeout */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            perf_push(PERF_PROC_OUT_TUN_MTCP);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            io_wait(c=
, IOW_TO_TUN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       perf_pop();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case TA_SOCKE=
T_WRITE:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 looking_for =3D SOCKET_WRITE;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            io_wait(c, IOW_TO_LINK|IOW_READ_TUN_FORCE);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        default:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;MULTI IO: multi_io_w=
ait_lite, unhandled action=3D%d&quot;, action);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (tun_input_pending &amp;&amp; (c-&gt;c2.event_set_status &amp; TUN_READ))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        *tun_input_pending =3D tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (c-&gt;c2.event_set_status &amp; looking_f=
or)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return action;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        switch (action)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            /* MULTI PROTOCOL socket output buffer is full */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            case TA_SOCKET_WRI=
TE:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
return TA_SOCKET_WRITE_DEFERRED;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
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
40%);">+multi_io_dispatch(struct multi_context *m, struct multi_instance *m=
i, const int action)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigne=
d int mpp_flags =3D MPP_PRE_SELECT|MPP_RECORD_TOUCH;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *touched =3D mi=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;mpp_touc=
hed =3D &amp;touched;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_MULTI_=
DEBUG, &quot;MULTI IO: multi_io_dispatch a=3D%s mi=3D&quot; ptr_format,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+         pract(action),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         (ptr_type)=
mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    switch (action)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        case TA_TUN_READ:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            read_incoming_tun(&amp;m-&gt;=
top);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if=
 (!IS_SIG(&amp;m-&gt;top))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                multi_process_incoming_tun(m, mpp_flags);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        case TA_SOCKET_READ:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        case TA_SOCKET_READ_RESIDUAL:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(mi);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(mi-&gt;con=
text.c2.link_sockets);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            ASSERT(mi-&gt;context.c2.link_sockets[0]);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            set_prefix(mi);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            read_incoming_lin=
k(&amp;mi-&gt;context, mi-&gt;context.c2.link_sockets[0]);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            clear_prefix();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (!IS_SIG(&amp=
;mi-&gt;context))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        multi_process_incoming_link(m, mi, mpp_flags,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
   mi-&gt;context.c2.link_sockets[0]);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                if (!IS_SIG(&amp;mi-&gt;context))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    stream_b=
uf_read_setup(mi-&gt;context.c2.link_sockets[0]);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            break;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        case TA_TIMEOUT:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            multi_process_timeout(m, mpp_flags);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        case TA_TUN_WRITE:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            multi_process_outgoing_tun(m, mpp_flags)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        case TA_TUN_WRITE_TIMEOUT:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi_proce=
ss_drop_outgoing_tun(m, mpp_flags);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    case TA_SOCKET_WRITE_READY:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            ASSERT(mi);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            multi_tcp_process_outgoing_link_ready(m, mi, mp=
p_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        case TA_SOCKET_WRITE:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi_tc=
p_process_outgoing_link(m, false, mpp_flags);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        case TA_SOCKET_WRITE_DEFERRED:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            multi_tcp_process_outgoing_link(m, tru=
e, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        case TA_INITIAL:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(m=
i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mult=
i_tcp_set_global_rw_flags(m, mi);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            multi_process_post(m, mi, mpp_flags);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        default:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(M_FATAL, &quot;MULTI IO: multi_io_disp=
atch, unhandled action=3D%d&quot;, action);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt=
;mpp_touched =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return touched;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_io_post(struct multi_context *m, st=
ruct multi_instance *mi, const int action)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct context *c =3D multi_get_context(m, mi);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int newaction =3D TA_UNDEF;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define MTP_NONE         0</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define MTP_TUN_OUT      (1&lt;&lt;0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MTP_LINK_OUT=
     (1&lt;&lt;1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  unsigned int flags =3D MTP_NONE;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (TUN_OUT(c))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        flags |=3D=
 MTP_TUN_OUT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (LINK_OUT(c))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        flags |=3D MTP_LINK_OUT;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    switch (flags)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        case MTP_TUN_OUT|MTP_LINK_OUT:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        case MTP_TUN_OUT:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            newaction =3D TA_TUN_WRITE;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case MTP_LINK_OUT:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            newaction =3D TA_SOCKE=
T_WRITE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        case MTP_NONE:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (mi &amp;&amp=
; sockets_read_residual(c))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                newaction =3D TA_SOCKET_READ_RESIDUAL;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                multi_tcp_set_global_rw_flags(m, mi);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        default:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;MU=
LTI IO: multi_io_post bad state, mi=3D%s flags=3D%d&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                multi_instance_strin=
g(mi, false, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                flags);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_MULTI_DEBUG, &qu=
ot;MULTI IO: multi_io_post %s -&gt; %s&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         pract(action),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+         pract(newaction));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return newaction;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+multi_io_process_io(struct mult=
i_context *m)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_io *mul=
ti_io =3D m-&gt;multi_io;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (i =3D 0; i &l=
t; multi_io-&gt;n_esr; ++i)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  struct event_set_return *e =3D &amp;multi_io-&gt;esr[i];</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        struct event_arg *ev_arg =3D=
 (struct event_arg *)e-&gt;arg;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 /* incoming data for instance or listening socket? */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (e-&gt;arg &gt;=3D MULTI_N)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            switch (ev_arg-&gt;=
type)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                stru=
ct multi_instance *mi;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
/* react to event on child instance */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                case EVENT_ARG_MULTI_INSTANCE:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    if (!ev_a=
rg-&gt;u.mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   msg(D_MULTI_ERRORS, &quot;MULTI IO: multi_io_proc_io: nu=
ll minstance&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        break;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               mi =3D ev_arg-&gt;u.mi;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    if (e-&gt;rwflags &amp; EVENT_WRITE)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
       multi_io_action(m, mi, TA_SOCKET_WRITE_READY, false);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    else if (e-&=
gt;rwflags &amp; EVENT_READ)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        multi_io_action(m, mi, TA_SOCKET_READ, f=
alse);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* new =
incoming TCP client attempting to connect? */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                case EVENT_ARG_LINK_SOCKET:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    if (!=
ev_arg-&gt;u.sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        msg(D_MULTI_ERRORS, &quot;MULTI IO: multi_io_proc_=
io: null socket&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                        break;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  if (!proto_is_dgram(ev_arg-&gt;u.sock-&gt;info.proto))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    socket_reset_listen_persistent(ev_arg-&gt;u.sock);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        mi =3D multi_cre=
ate_instance_tcp(m, ev_arg-&gt;u.sock);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                        if (mi)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                            multi_i=
o_action(m, mi, TA_INITIAL, false);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (e-&gt;arg =3D=3D MULTI_IO_MANAGEMENT)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                ASSERT(management);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                managem=
ent_io(management);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* incomin=
g data on TUN? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (e-&gt;arg =3D=3D MULTI_IO_TUN)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                if (e-&gt;rwflags &amp; EVENT_WRITE)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                    multi=
_io_action(m, NULL, TA_TUN_WRITE, false);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                else if (e-&gt;rwflags &amp; EVENT_READ=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
multi_io_action(m, NULL, TA_TUN_READ, false);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            /* new incoming TCP client attempting to conn=
ect? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
else if (e-&gt;arg =3D=3D MULTI_IO_SOCKET)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                struct multi_instance *mi;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                ASSERT(m-&gt;top.c2=
.link_sockets[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               socket_reset_listen_persistent(m-&gt;top.c2.link_sockets[0])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                mi=
 =3D multi_create_instance_tcp(m, m-&gt;top.c2.link_sockets[0]);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                if (mi)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    multi_io=
_action(m, mi, TA_INITIAL, false);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || defined=
(TARGET_FREEBSD))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          /* incoming data on DCO? */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            else if (e-&gt;arg =3D=3D MULTI_IO_DCO)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                multi_process_i=
ncoming_dco(m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* signal r=
eceived? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    else if (e-&gt;arg =3D=3D MULTI_IO_SIG)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                get_signal(&amp;m-&gt;top.sig-&gt;signal_=
received);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_A=
SYNC_PUSH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  else if (e-&gt;arg =3D=3D MULTI_IO_FILE_CLOSE_WRITE)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                multi_process_file_closed(m, M=
PP_PRE_SELECT | MPP_RECORD_TOUCH);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (IS=
_SIG(&amp;m-&gt;top))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    multi_io-&gt;n_esr =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * Process queued mbuf packets destined for TCP so=
cket</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct multi_instance *mi;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        while (!IS_SIG(&am=
p;m-&gt;top) &amp;&amp; (mi =3D mbuf_peek(m-&gt;mbuf)) !=3D NULL)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            multi_io_action(m, mi, TA_S=
OCKET_WRITE, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
multi_io_action(struct multi_context *m, struct multi_instance *mi, int act=
ion, bool poll)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool tun_input_pen=
ding =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    do</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        dmsg(D_MULTI_DEBUG, &quot;MULTI IO: multi_=
io_action a=3D%s p=3D%d&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+             pract(action),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+             poll);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
* If TA_SOCKET_READ_RESIDUAL, it means we still have pending</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         * input packets which wer=
e read by a prior recv.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+         *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
    * Otherwise do a &quot;lite&quot; wait, which means we wait with 0 time=
out</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * on I/=
O events only related to the current instance, not</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * the big list of events.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+         * On our first pass, poll wil=
l be false because we already know</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         * that input is available, and to call io_wait woul=
d be redundant.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
poll &amp;&amp; action !=3D TA_SOCKET_READ_RESIDUAL)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            const int orig_action =3D action;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            action =3D mu=
lti_io_wait_lite(m, mi, action, &amp;tun_input_pending);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (action =3D=3D TA_UNDEF=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_FA=
TAL, &quot;MULTI IO: I/O wait required blocking in multi_io_action, action=
=3D%d&quot;, orig_action);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /*</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+         * Dispatch the action</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        struct multi_instance *tou=
ched =3D multi_io_dispatch(m, mi, action);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
    * Signal received or connection</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+         * reset by peer?</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+         */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (touched &amp;&amp; IS_SIG(&amp;touched-&gt;contex=
t))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if (mi =3D=3D =
touched)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m=
i =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mu=
lti_close_instance_on_signal(m, touched);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /*</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         * If dispatch produced any=
 pending output</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     * for a particular instance, point to</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         * that instance.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (m-&gt;pending)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            mi =3D m-&gt;pending;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     * Based on the effects of the action,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+         * such as generating pending output,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+         * possibly transi=
tion to a new action state.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+         */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        action =3D multi_io_post(m, mi, action);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+         * If we are finished processing the original action,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         * check if we have any =
TUN input.  If so, transition</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+         * our action state to processing this input.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (tun_input_pending &amp;&amp=
; action =3D=3D TA_UNDEF)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        action =3D TA_TUN_READ;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            mi =3D NULL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            tun_input_pending =3D false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            poll =3D false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            poll =3D true;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 } while (action !=3D TA_UNDEF);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+multi_io_delete_event(struct multi_io *=
multi_io, event_t event)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi=
_io &amp;&amp; multi_io-&gt;es)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      event_del(multi_io-&gt;es, event);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span>diff --git a/src/openvpn/multi_io.h b/src/openvpn/=
multi_io.h</span><br><span>new file mode 100644</span><br><span>index 00000=
00..03d708c</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn=
/multi_io.h</span><br><span>@@ -0,0 +1,77 @@</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a sing=
le TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *             session authentication and key e=
xchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    packet encryption, packet authentication, and</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             packet compression.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2023 OpenVPN Inc &lt;sal=
es@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is =
free software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  This program is distributed in the hope that it will=
 be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but =
WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A=
 PARTICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  GNU General Public License for more details.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Genera=
l Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  with this program; if not, write to the Free Software Foundation, In=
c.,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin =
Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Multi-protocol specif=
ic code for --mode server</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef MULTI_IO_H</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define MULTI_IO_H</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;event.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 I/O processing States</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define TA_UNDEF                =
 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TA_SOCKET=
_READ           1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine TA_SOCKET_READ_RESIDUAL  2</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define TA_SOCKET_WRITE          3</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define TA_SOCKET_WRITE_READY    4</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define TA_SOCKET_WRITE_DEFERRED=
 5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TA_TUN_RE=
AD              6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine TA_TUN_WRITE             7</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define TA_INITIAL               8</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define TA_TIMEOUT               9</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define TA_TUN_WRITE_TIMEOUT    =
 10</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * I/O state and events tracker</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+struct multi_io</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct event_set *es;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct event_set_return *esr;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int n_esr;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int maxevents;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    unsigned int tun_rwflags;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    unsigned int udp_flags;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned int management_persist_flags=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+struct multi_io *multi_io_init(int maxevents, int *maxclients);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void multi_io_free(struct multi_io *multi=
_io);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+int multi_io_wait(struct multi_co=
ntext *m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void multi_io_process_io(str=
uct multi_context *m);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void multi_io_ac=
tion(struct multi_context *m, struct multi_instance *mi, int action, bool p=
oll);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void multi_io_delete_event(struct=
 multi_io *multi_io, event_t event);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif /* ifndef MULTI_IO_H */</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/763?usp=3Demail">chan=
ge 763</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/763?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1e5a84969988e4f027a18658d4a=
b268c13fbf929 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 763 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--eH90Z058Qqk=--

