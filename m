From: Gert Doering <gert@...1296...>
Date: Fri, 24 Jan 2025 12:58:48 +0100
Message-ID: <20250124115849.14638-1-gert@...1296...>
In-Reply-To: <gerrit.1727098847000.I1e5a84969988e4f027a18658d4ab268c13fbf929@...2715...>
References: <gerrit.1727098847000.I1e5a84969988e4f027a18658d4ab268c13fbf929@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v14] multiproto: move generic event handling
 code in dedicated files
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

From: Gianmarco De Gregori <gianmarco@...2726...>

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
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/763
This mail reflects revision 14 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
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
     struct gc_arena gc = gc_new();
@@ -193,139 +126,42 @@
     mbuf_free(mi->tcp_link_out_deferred);
 }
 
-struct multi_tcp *
-multi_tcp_init(int maxevents, int *maxclients)
-{
-    struct multi_tcp *mtcp;
-    const int extra_events = BASE_N_EVENTS;
-
-    ASSERT(maxevents >= 1);
-    ASSERT(maxclients);
-
-    ALLOC_OBJ_CLEAR(mtcp, struct multi_tcp);
-    mtcp->maxevents = maxevents + extra_events;
-    mtcp->es = event_set_init(&mtcp->maxevents, 0);
-    wait_signal(mtcp->es, MTCP_SIG);
-    ALLOC_ARRAY(mtcp->esr, struct event_set_return, mtcp->maxevents);
-    *maxclients = max_int(min_int(mtcp->maxevents - extra_events, *maxclients), 1);
-    msg(D_MULTI_LOW, "MULTI: TCP INIT maxclients=%d maxevents=%d", *maxclients, mtcp->maxevents);
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
-multi_tcp_dereference_instance(struct multi_tcp *mtcp, struct multi_instance *mi)
+multi_tcp_dereference_instance(struct multi_io *multi_io, struct multi_instance *mi)
 {
     struct link_socket *ls = mi->context.c2.link_sockets[0];
     if (ls && mi->socket_set_called)
     {
-        event_del(mtcp->es, socket_event_handle(ls));
+        event_del(multi_io->es, socket_event_handle(ls));
         mi->socket_set_called = false;
     }
-    mtcp->n_esr = 0;
+    multi_io->n_esr = 0;
 }
 
-static inline void
+void
 multi_tcp_set_global_rw_flags(struct multi_context *m, struct multi_instance *mi)
 {
     if (mi)
     {
         mi->socket_set_called = true;
         socket_set(mi->context.c2.link_sockets[0],
-                   m->mtcp->es,
+                   m->multi_io->es,
                    mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,
                    &mi->ev_arg,
                    &mi->tcp_rwflags);
     }
 }
 
-static inline int
-multi_tcp_wait(const struct context *c,
-               struct multi_tcp *mtcp)
-{
-    int status;
-    unsigned int *persistent = &mtcp->tun_rwflags;
-
-    for (int i = 0; i < c->c1.link_sockets_num; i++)
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
-            mtcp->esr[0].arg = MTCP_TUN;
-            mtcp->esr[0].rwflags = EVENT_READ;
-            mtcp->n_esr = 1;
-            return 1;
-        }
-        persistent = NULL;
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
-        management_socket_set(management, mtcp->es, MTCP_MANAGEMENT, &mtcp->management_persist_flags);
-    }
-#endif
-
-#ifdef ENABLE_ASYNC_PUSH
-    /* arm inotify watcher */
-    event_ctl(mtcp->es, c->c2.inotify_fd, EVENT_READ, MTCP_FILE_CLOSE_WRITE);
-#endif
-
-    status = event_wait(mtcp->es, &c->c2.timeval, mtcp->esr, mtcp->maxevents);
-    update_time();
-    mtcp->n_esr = 0;
-    if (status > 0)
-    {
-        mtcp->n_esr = status;
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
 multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct multi_instance *mi, const unsigned int mpp_flags)
 {
     struct mbuf_item item;
@@ -349,7 +185,7 @@
     return ret;
 }
 
-static bool
+bool
 multi_tcp_process_outgoing_link(struct multi_context *m, bool defer, const unsigned int mpp_flags)
 {
     struct multi_instance *mi = multi_process_outgoing_link_pre(m);
@@ -393,417 +229,6 @@
     return ret;
 }
 
-static int
-multi_tcp_wait_lite(struct multi_context *m, struct multi_instance *mi, const int action, bool *tun_input_pending)
-{
-    struct context *c = multi_tcp_context(m, mi);
-    unsigned int looking_for = 0;
-
-    dmsg(D_MULTI_DEBUG, "MULTI TCP: multi_tcp_wait_lite a=%s mi=" ptr_format,
-         pract(action),
-         (ptr_type)mi);
-
-    tv_clear(&c->c2.timeval); /* ZERO-TIMEOUT */
-
-    switch (action)
-    {
-        case TA_TUN_READ:
-            looking_for = TUN_READ;
-            tun_input_pending = NULL;
-            io_wait(c, IOW_READ_TUN);
-            break;
-
-        case TA_SOCKET_READ:
-            looking_for = SOCKET_READ;
-            tun_input_pending = NULL;
-            io_wait(c, IOW_READ_LINK);
-            break;
-
-        case TA_TUN_WRITE:
-            looking_for = TUN_WRITE;
-            tun_input_pending = NULL;
-            c->c2.timeval.tv_sec = 1; /* For some reason, the Linux 2.2 TUN/TAP driver hits this timeout */
-            perf_push(PERF_PROC_OUT_TUN_MTCP);
-            io_wait(c, IOW_TO_TUN);
-            perf_pop();
-            break;
-
-        case TA_SOCKET_WRITE:
-            looking_for = SOCKET_WRITE;
-            io_wait(c, IOW_TO_LINK|IOW_READ_TUN_FORCE);
-            break;
-
-        default:
-            msg(M_FATAL, "MULTI TCP: multi_tcp_wait_lite, unhandled action=%d", action);
-    }
-
-    if (tun_input_pending && (c->c2.event_set_status & TUN_READ))
-    {
-        *tun_input_pending = true;
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
-multi_tcp_dispatch(struct multi_context *m, struct multi_instance *mi, const int action)
-{
-    const unsigned int mpp_flags = MPP_PRE_SELECT|MPP_RECORD_TOUCH;
-    struct multi_instance *touched = mi;
-    m->mpp_touched = &touched;
-
-    dmsg(D_MULTI_DEBUG, "MULTI TCP: multi_tcp_dispatch a=%s mi=" ptr_format,
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
-            read_incoming_link(&mi->context, mi->context.c2.link_sockets[0]);
-            clear_prefix();
-            if (!IS_SIG(&mi->context))
-            {
-                multi_process_incoming_link(m, mi, mpp_flags,
-                                            mi->context.c2.link_sockets[0]);
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
-            msg(M_FATAL, "MULTI TCP: multi_tcp_dispatch, unhandled action=%d", action);
-    }
-
-    m->mpp_touched = NULL;
-    return touched;
-}
-
-static int
-multi_tcp_post(struct multi_context *m, struct multi_instance *mi, const int action)
-{
-    struct context *c = multi_tcp_context(m, mi);
-    int newaction = TA_UNDEF;
-
-#define MTP_NONE         0
-#define MTP_TUN_OUT      (1<<0)
-#define MTP_LINK_OUT     (1<<1)
-    unsigned int flags = MTP_NONE;
-
-    if (TUN_OUT(c))
-    {
-        flags |= MTP_TUN_OUT;
-    }
-    if (LINK_OUT(c))
-    {
-        flags |= MTP_LINK_OUT;
-    }
-
-    switch (flags)
-    {
-        case MTP_TUN_OUT|MTP_LINK_OUT:
-        case MTP_TUN_OUT:
-            newaction = TA_TUN_WRITE;
-            break;
-
-        case MTP_LINK_OUT:
-            newaction = TA_SOCKET_WRITE;
-            break;
-
-        case MTP_NONE:
-            if (mi && sockets_read_residual(c))
-            {
-                newaction = TA_SOCKET_READ_RESIDUAL;
-            }
-            else
-            {
-                multi_tcp_set_global_rw_flags(m, mi);
-            }
-            break;
-
-        default:
-        {
-            struct gc_arena gc = gc_new();
-            msg(M_FATAL, "MULTI TCP: multi_tcp_post bad state, mi=%s flags=%d",
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
-multi_tcp_action(struct multi_context *m, struct multi_instance *mi, int action, bool poll)
-{
-    bool tun_input_pending = false;
-
-    do
-    {
-        dmsg(D_MULTI_DEBUG, "MULTI TCP: multi_tcp_action a=%s p=%d",
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
-        if (poll && action != TA_SOCKET_READ_RESIDUAL)
-        {
-            const int orig_action = action;
-            action = multi_tcp_wait_lite(m, mi, action, &tun_input_pending);
-            if (action == TA_UNDEF)
-            {
-                msg(M_FATAL, "MULTI TCP: I/O wait required blocking in multi_tcp_action, action=%d", orig_action);
-            }
-        }
-
-        /*
-         * Dispatch the action
-         */
-        struct multi_instance *touched = multi_tcp_dispatch(m, mi, action);
-
-        /*
-         * Signal received or TCP connection
-         * reset by peer?
-         */
-        if (touched && IS_SIG(&touched->context))
-        {
-            if (mi == touched)
-            {
-                mi = NULL;
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
-            mi = m->pending;
-        }
-
-        /*
-         * Based on the effects of the action,
-         * such as generating pending output,
-         * possibly transition to a new action state.
-         */
-        action = multi_tcp_post(m, mi, action);
-
-        /*
-         * If we are finished processing the original action,
-         * check if we have any TUN input.  If so, transition
-         * our action state to processing this input.
-         */
-        if (tun_input_pending && action == TA_UNDEF)
-        {
-            action = TA_TUN_READ;
-            mi = NULL;
-            tun_input_pending = false;
-            poll = false;
-        }
-        else
-        {
-            poll = true;
-        }
-
-    } while (action != TA_UNDEF);
-}
-
-static void
-multi_tcp_process_io(struct multi_context *m)
-{
-    struct multi_tcp *mtcp = m->mtcp;
-    int i;
-
-    for (i = 0; i < mtcp->n_esr; ++i)
-    {
-        struct event_set_return *e = &mtcp->esr[i];
-
-        /* incoming data for instance or listening socket? */
-        if (e->arg >= MULTI_N)
-        {
-            struct event_arg *ev_arg = (struct event_arg *)e->arg;
-            switch (ev_arg->type)
-            {
-                struct multi_instance *mi;
-
-                /* react to event on child instance */
-                case EVENT_ARG_MULTI_INSTANCE:
-                    if (!ev_arg->u.mi)
-                    {
-                        msg(D_MULTI_ERRORS, "MULTI: mtcp_proc_io: null minstance");
-                        break;
-                    }
-
-                    mi = ev_arg->u.mi;
-                    if (e->rwflags & EVENT_WRITE)
-                    {
-                        multi_tcp_action(m, mi, TA_SOCKET_WRITE_READY, false);
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
-                        msg(D_MULTI_ERRORS, "MULTI: mtcp_proc_io: null socket");
-                        break;
-                    }
-
-                    socket_reset_listen_persistent(ev_arg->u.sock);
-                    mi = multi_create_instance_tcp(m, ev_arg->u.sock);
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
-            if (e->arg == MTCP_MANAGEMENT)
-            {
-                ASSERT(management);
-                management_io(management);
-            }
-            else
-#endif
-            /* incoming data on TUN? */
-            if (e->arg == MTCP_TUN)
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
-#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
-            /* incoming data on DCO? */
-            else if (e->arg == MTCP_DCO)
-            {
-                multi_process_incoming_dco(m);
-            }
-#endif
-            /* signal received? */
-            else if (e->arg == MTCP_SIG)
-            {
-                get_signal(&m->top.sig->signal_received);
-            }
-#ifdef ENABLE_ASYNC_PUSH
-            else if (e->arg == MTCP_FILE_CLOSE_WRITE)
-            {
-                multi_process_file_closed(m, MPP_PRE_SELECT | MPP_RECORD_TOUCH);
-            }
-#endif
-        }
-        if (IS_SIG(&m->top))
-        {
-            break;
-        }
-    }
-    mtcp->n_esr = 0;
-
-    /*
-     * Process queued mbuf packets destined for TCP socket
-     */
-    {
-        struct multi_instance *mi;
-        while (!IS_SIG(&m->top) && (mi = mbuf_peek(m->mbuf)) != NULL)
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
-        status = multi_tcp_wait(&multi.top, multi.mtcp);
+        status = multi_io_wait(&multi);
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
         else if (status == 0)
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
-void multi_tcp_dereference_instance(struct multi_tcp *mtcp, struct multi_instance *mi);
+void multi_tcp_dereference_instance(struct multi_io *multi_io, struct multi_instance *mi);
 
 bool multi_tcp_instance_specific_init(struct multi_context *m, struct multi_instance *mi);
 
 void multi_tcp_instance_specific_free(struct multi_instance *mi);
 
+void multi_tcp_set_global_rw_flags(struct multi_context *m, struct multi_instance *mi);
+
+bool multi_tcp_process_outgoing_link(struct multi_context *m, bool defer, const unsigned int mpp_flags);
+
+bool multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct multi_instance *mi, const unsigned int mpp_flags);
+
+struct multi_instance *multi_create_instance_tcp(struct multi_context *m, struct link_socket *ls);
+
+void multi_tcp_link_out_deferred(struct multi_context *m, struct multi_instance *mi);
+
+
 /**************************************************************************/
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
-        m->mtcp = multi_tcp_init(t->options.max_clients, &m->max_clients);
+        m->multi_io = multi_io_init(t->options.max_clients, &m->max_clients);
     }
     m->tcp_queue_limit = t->options.tcp_queue_limit;
 
@@ -665,9 +665,9 @@
             mi->did_iroutes = false;
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
     struct multi_context *m = (struct multi_context *) arg;
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
+    const int extra_events = BASE_N_EVENTS;
+
+    ASSERT(maxevents >= 1);
+    ASSERT(maxclients);
+
+    ALLOC_OBJ_CLEAR(multi_io, struct multi_io);
+    multi_io->maxevents = maxevents + extra_events;
+    multi_io->es = event_set_init(&multi_io->maxevents, 0);
+    wait_signal(multi_io->es, MULTI_IO_SIG);
+    ALLOC_ARRAY(multi_io->esr, struct event_set_return, multi_io->maxevents);
+    *maxclients = max_int(min_int(multi_io->maxevents - extra_events, *maxclients), 1);
+    msg(D_MULTI_LOW, "MULTI IO: MULTI_IO INIT maxclients=%d maxevents=%d", *maxclients, multi_io->maxevents);
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
+    unsigned int *persistent = &m->multi_io->tun_rwflags;
+
+    for (i = 0; i < m->top.c1.link_sockets_num; i++)
+    {
+        socket_set_listen_persistent(m->top.c2.link_sockets[i], m->multi_io->es,
+                                     &m->top.c2.link_sockets[i]->ev_arg);
+    }
+
+#ifdef _WIN32
+    if (tuntap_is_wintun(m->top.c1.tuntap))
+    {
+        if (!tuntap_ring_empty(m->top.c1.tuntap))
+        {
+            /* there is data in wintun ring buffer, read it immediately */
+            m->multi_io->esr[0].arg = MULTI_IO_TUN;
+            m->multi_io->esr[0].rwflags = EVENT_READ;
+            m->multi_io->n_esr = 1;
+            return 1;
+        }
+        persistent = NULL;
+    }
+#endif
+    tun_set(m->top.c1.tuntap, m->multi_io->es, EVENT_READ, MULTI_IO_TUN, persistent);
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+    dco_event_set(&m->top.c1.tuntap->dco, m->multi_io->es, MULTI_IO_DCO);
+#endif
+
+#ifdef ENABLE_MANAGEMENT
+    if (management)
+    {
+        management_socket_set(management, m->multi_io->es, MULTI_IO_MANAGEMENT, &m->multi_io->management_persist_flags);
+    }
+#endif
+
+#ifdef ENABLE_ASYNC_PUSH
+    /* arm inotify watcher */
+    event_ctl(m->multi_io->es, m->top.c2.inotify_fd, EVENT_READ, MULTI_IO_FILE_CLOSE_WRITE);
+#endif
+
+    status = event_wait(m->multi_io->es, &m->top.c2.timeval, m->multi_io->esr, m->multi_io->maxevents);
+    update_time();
+    m->multi_io->n_esr = 0;
+    if (status > 0)
+    {
+        m->multi_io->n_esr = status;
+    }
+    return status;
+}
+
+static int
+multi_io_wait_lite(struct multi_context *m, struct multi_instance *mi, const int action, bool *tun_input_pending)
+{
+    struct context *c = multi_get_context(m, mi);
+    unsigned int looking_for = 0;
+
+    dmsg(D_MULTI_DEBUG, "MULTI IO: multi_io_wait_lite a=%s mi=" ptr_format,
+         pract(action),
+         (ptr_type)mi);
+
+    tv_clear(&c->c2.timeval); /* ZERO-TIMEOUT */
+
+    switch (action)
+    {
+        case TA_TUN_READ:
+            looking_for = TUN_READ;
+            tun_input_pending = NULL;
+            io_wait(c, IOW_READ_TUN);
+            break;
+
+        case TA_SOCKET_READ:
+            looking_for = SOCKET_READ;
+            tun_input_pending = NULL;
+            io_wait(c, IOW_READ_LINK);
+            break;
+
+        case TA_TUN_WRITE:
+            looking_for = TUN_WRITE;
+            tun_input_pending = NULL;
+            c->c2.timeval.tv_sec = 1; /* For some reason, the Linux 2.2 TUN/TAP driver hits this timeout */
+            perf_push(PERF_PROC_OUT_TUN_MTCP);
+            io_wait(c, IOW_TO_TUN);
+            perf_pop();
+            break;
+
+        case TA_SOCKET_WRITE:
+            looking_for = SOCKET_WRITE;
+            io_wait(c, IOW_TO_LINK|IOW_READ_TUN_FORCE);
+            break;
+
+        default:
+            msg(M_FATAL, "MULTI IO: multi_io_wait_lite, unhandled action=%d", action);
+    }
+
+    if (tun_input_pending && (c->c2.event_set_status & TUN_READ))
+    {
+        *tun_input_pending = true;
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
+multi_io_dispatch(struct multi_context *m, struct multi_instance *mi, const int action)
+{
+    const unsigned int mpp_flags = MPP_PRE_SELECT|MPP_RECORD_TOUCH;
+    struct multi_instance *touched = mi;
+    m->mpp_touched = &touched;
+
+    dmsg(D_MULTI_DEBUG, "MULTI IO: multi_io_dispatch a=%s mi=" ptr_format,
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
+            read_incoming_link(&mi->context, mi->context.c2.link_sockets[0]);
+            clear_prefix();
+            if (!IS_SIG(&mi->context))
+            {
+                multi_process_incoming_link(m, mi, mpp_flags,
+                                            mi->context.c2.link_sockets[0]);
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
+            msg(M_FATAL, "MULTI IO: multi_io_dispatch, unhandled action=%d", action);
+    }
+
+    m->mpp_touched = NULL;
+    return touched;
+}
+
+static int
+multi_io_post(struct multi_context *m, struct multi_instance *mi, const int action)
+{
+    struct context *c = multi_get_context(m, mi);
+    int newaction = TA_UNDEF;
+
+#define MTP_NONE         0
+#define MTP_TUN_OUT      (1<<0)
+#define MTP_LINK_OUT     (1<<1)
+    unsigned int flags = MTP_NONE;
+
+    if (TUN_OUT(c))
+    {
+        flags |= MTP_TUN_OUT;
+    }
+    if (LINK_OUT(c))
+    {
+        flags |= MTP_LINK_OUT;
+    }
+
+    switch (flags)
+    {
+        case MTP_TUN_OUT|MTP_LINK_OUT:
+        case MTP_TUN_OUT:
+            newaction = TA_TUN_WRITE;
+            break;
+
+        case MTP_LINK_OUT:
+            newaction = TA_SOCKET_WRITE;
+            break;
+
+        case MTP_NONE:
+            if (mi && sockets_read_residual(c))
+            {
+                newaction = TA_SOCKET_READ_RESIDUAL;
+            }
+            else
+            {
+                multi_tcp_set_global_rw_flags(m, mi);
+            }
+            break;
+
+        default:
+        {
+            struct gc_arena gc = gc_new();
+            msg(M_FATAL, "MULTI IO: multi_io_post bad state, mi=%s flags=%d",
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
+    struct multi_io *multi_io = m->multi_io;
+    int i;
+
+    for (i = 0; i < multi_io->n_esr; ++i)
+    {
+        struct event_set_return *e = &multi_io->esr[i];
+        struct event_arg *ev_arg = (struct event_arg *)e->arg;
+
+        /* incoming data for instance or listening socket? */
+        if (e->arg >= MULTI_N)
+        {
+            switch (ev_arg->type)
+            {
+                struct multi_instance *mi;
+
+                /* react to event on child instance */
+                case EVENT_ARG_MULTI_INSTANCE:
+                    if (!ev_arg->u.mi)
+                    {
+                        msg(D_MULTI_ERRORS, "MULTI IO: multi_io_proc_io: null minstance");
+                        break;
+                    }
+
+                    mi = ev_arg->u.mi;
+                    if (e->rwflags & EVENT_WRITE)
+                    {
+                        multi_io_action(m, mi, TA_SOCKET_WRITE_READY, false);
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
+                        msg(D_MULTI_ERRORS, "MULTI IO: multi_io_proc_io: null socket");
+                        break;
+                    }
+
+                    if (!proto_is_dgram(ev_arg->u.sock->info.proto))
+                    {
+                        socket_reset_listen_persistent(ev_arg->u.sock);
+                        mi = multi_create_instance_tcp(m, ev_arg->u.sock);
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
+            if (e->arg == MULTI_IO_MANAGEMENT)
+            {
+                ASSERT(management);
+                management_io(management);
+            }
+            else
+#endif
+            /* incoming data on TUN? */
+            if (e->arg == MULTI_IO_TUN)
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
+            else if (e->arg == MULTI_IO_SOCKET)
+            {
+                struct multi_instance *mi;
+                ASSERT(m->top.c2.link_sockets[0]);
+                socket_reset_listen_persistent(m->top.c2.link_sockets[0]);
+                mi = multi_create_instance_tcp(m, m->top.c2.link_sockets[0]);
+                if (mi)
+                {
+                    multi_io_action(m, mi, TA_INITIAL, false);
+                }
+            }
+#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
+            /* incoming data on DCO? */
+            else if (e->arg == MULTI_IO_DCO)
+            {
+                multi_process_incoming_dco(m);
+            }
+#endif
+            /* signal received? */
+            else if (e->arg == MULTI_IO_SIG)
+            {
+                get_signal(&m->top.sig->signal_received);
+            }
+#ifdef ENABLE_ASYNC_PUSH
+            else if (e->arg == MULTI_IO_FILE_CLOSE_WRITE)
+            {
+                multi_process_file_closed(m, MPP_PRE_SELECT | MPP_RECORD_TOUCH);
+            }
+#endif
+        }
+        if (IS_SIG(&m->top))
+        {
+            break;
+        }
+    }
+    multi_io->n_esr = 0;
+
+    /*
+     * Process queued mbuf packets destined for TCP socket
+     */
+    {
+        struct multi_instance *mi;
+        while (!IS_SIG(&m->top) && (mi = mbuf_peek(m->mbuf)) != NULL)
+        {
+            multi_io_action(m, mi, TA_SOCKET_WRITE, true);
+        }
+    }
+}
+
+void
+multi_io_action(struct multi_context *m, struct multi_instance *mi, int action, bool poll)
+{
+    bool tun_input_pending = false;
+
+    do
+    {
+        dmsg(D_MULTI_DEBUG, "MULTI IO: multi_io_action a=%s p=%d",
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
+        if (poll && action != TA_SOCKET_READ_RESIDUAL)
+        {
+            const int orig_action = action;
+            action = multi_io_wait_lite(m, mi, action, &tun_input_pending);
+            if (action == TA_UNDEF)
+            {
+                msg(M_FATAL, "MULTI IO: I/O wait required blocking in multi_io_action, action=%d", orig_action);
+            }
+        }
+
+        /*
+         * Dispatch the action
+         */
+        struct multi_instance *touched = multi_io_dispatch(m, mi, action);
+
+        /*
+         * Signal received or connection
+         * reset by peer?
+         */
+        if (touched && IS_SIG(&touched->context))
+        {
+            if (mi == touched)
+            {
+                mi = NULL;
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
+            mi = m->pending;
+        }
+
+        /*
+         * Based on the effects of the action,
+         * such as generating pending output,
+         * possibly transition to a new action state.
+         */
+        action = multi_io_post(m, mi, action);
+
+        /*
+         * If we are finished processing the original action,
+         * check if we have any TUN input.  If so, transition
+         * our action state to processing this input.
+         */
+        if (tun_input_pending && action == TA_UNDEF)
+        {
+            action = TA_TUN_READ;
+            mi = NULL;
+            tun_input_pending = false;
+            poll = false;
+        }
+        else
+        {
+            poll = true;
+        }
+
+    } while (action != TA_UNDEF);
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
+void multi_io_action(struct multi_context *m, struct multi_instance *mi, int action, bool poll);
+
+void multi_io_delete_event(struct multi_io *multi_io, event_t event);
+
+#endif /* ifndef MULTI_IO_H */

