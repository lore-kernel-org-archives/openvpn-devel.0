From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 15 Nov 2023 13:45:20 +0000
References: <gerrit.1700055887000.Id2d7957f5950115d9baade4c09fd9679b01f749b@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b652ef4fc6537557bc044bccd1b9f5817c4b69f9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/+HJ+sN5qjY="; charset=UTF-8
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

--/+HJ+sN5qjY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/441?usp=3Demail

to review the following change.


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

Change-Id: Id2d7957f5950115d9baade4c09fd9679b01f749b
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M CMakeLists.txt
M src/openvpn/Makefile.am
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/mtcp.c
M src/openvpn/mtcp.h
M src/openvpn/mudp.c
M src/openvpn/multi.c
M src/openvpn/multi.h
A src/openvpn/multi_io.c
A src/openvpn/multi_io.h
11 files changed, 821 insertions(+), 777 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/441/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index d21c9bd..ee27465 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -402,6 +402,8 @@
     src/openvpn/mudp.h
     src/openvpn/multi.c
     src/openvpn/multi.h
+    src/openvpn/multi_io.c
+    src/openvpn/multi_io.h
     src/openvpn/ntlm.c
     src/openvpn/ntlm.h
     src/openvpn/occ.c
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 52deef8..17fcb1b 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -89,6 +89,7 @@
 	mtu.c mtu.h \
 	mudp.c mudp.h \
 	multi.c multi.h \
+	multi_io.c multi_io.h \
 	networking_freebsd.c \
 	networking_iproute2.c networking_iproute2.h \
 	networking_sitnl.c networking_sitnl.h \
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index ee18f8b..0e5b611 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2053,7 +2053,7 @@
  */

 void
-get_io_flags_dowork_udp(struct context *c, struct multi_tcp *mtcp, const u=
nsigned int flags)
+get_io_flags_dowork_udp(struct context *c, struct multi_protocol *multi_io=
, const unsigned int flags)
 {
     unsigned int socket =3D 0;
     unsigned int tuntap =3D 0;
@@ -2064,7 +2064,7 @@
      */
     if (flags & IOW_WAIT_SIGNAL)
     {
-        wait_signal(mtcp->es, (void *)err_shift);
+        wait_signal(multi_io->es, (void *)err_shift);
     }

     if (flags & IOW_TO_LINK)
@@ -2156,17 +2156,17 @@
     {
         if (proto_is_dgram(c->c2.link_sockets[i]->info.proto))
         {
-            socket_set(c->c2.link_sockets[i], mtcp->es, socket,
+            socket_set(c->c2.link_sockets[i], multi_io->es, socket,
                        &c->c2.link_sockets[i]->ev_arg, NULL);
         }
     }
-    mtcp->udp_flags =3D socket | tuntap;
+    multi_io->udp_flags =3D socket | tuntap;
 }

 void
-get_io_flags_udp(struct context *c, struct multi_tcp *mtcp, const unsigned=
 int flags)
+get_io_flags_udp(struct context *c, struct multi_protocol *multi_io, const=
 unsigned int flags)
 {
-    mtcp->udp_flags =3D ES_ERROR;
+    multi_io->udp_flags =3D ES_ERROR;
     if (c->c2.fast_io && (flags & (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))
     {
         /* fast path -- only for TUN/TAP/UDP writes */
@@ -2179,7 +2179,7 @@
         {
             ret |=3D SOCKET_WRITE;
         }
-        mtcp->udp_flags =3D ret;
+        multi_io->udp_flags =3D ret;
     }
     else
     {
@@ -2205,13 +2205,13 @@
             {
                 ret |=3D TUN_READ;
             }
-            mtcp->udp_flags =3D ret;
+            multi_io->udp_flags =3D ret;
         }
         else
 #endif /* ifdef _WIN32 */
         {
             /* slow path - delegate to io_wait_dowork_udp to calculate fla=
gs */
-            get_io_flags_dowork_udp(c, mtcp, flags);
+            get_io_flags_dowork_udp(c, multi_io, flags);
         }
     }
 }
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 39ac975..a251d04 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -50,7 +50,7 @@
 #include "openvpn.h"
 #include "occ.h"
 #include "ping.h"
-#include "mtcp.h"
+#include "multi_io.h"

 #define IOW_TO_TUN          (1<<0)
 #define IOW_TO_LINK         (1<<1)
@@ -65,13 +65,19 @@

 #define IOW_READ            (IOW_READ_TUN|IOW_READ_LINK)

+
+/* forward declaration */
+/*struct multi_context;
+ * struct multi_protocol;
+ * struct context;*/
+
 extern counter_type link_read_bytes_global;

 extern counter_type link_write_bytes_global;

-void get_io_flags_dowork_udp(struct context *c, struct multi_tcp *mtcp, co=
nst unsigned int flags);
+void get_io_flags_dowork_udp(struct context *c, struct multi_protocol *mul=
ti_io, const unsigned int flags);

-void get_io_flags_udp(struct context *c, struct multi_tcp *mtcp, const uns=
igned int flags);
+void get_io_flags_udp(struct context *c, struct multi_protocol *multi_io, =
const unsigned int flags);

 void io_wait_dowork(struct context *c, const unsigned int flags);

diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 128a375..4efce35 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -29,6 +29,8 @@

 #include "multi.h"
 #include "forward.h"
+#include "mtcp.h"
+#include "multi_io.h"

 #include "memdbg.h"

@@ -36,70 +38,7 @@
 #include <sys/inotify.h>
 #endif

-/*
- * Special tags passed to event.[ch] functions
- */
-#define MTCP_SOCKET      ((void *)1)
-#define MTCP_TUN         ((void *)2)
-#define MTCP_SIG         ((void *)3) /* Only on Windows */
-#define MTCP_MANAGEMENT ((void *)4)
-#define MTCP_FILE_CLOSE_WRITE ((void *)5)
-#define MTCP_DCO        ((void *)6)
-
-struct ta_iow_flags
-{
-    unsigned int flags;
-    unsigned int ret;
-    unsigned int tun;
-    unsigned int sock;
-};
-
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
@@ -180,126 +119,19 @@
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
-{
-    if (mtcp && mtcp->es)
-    {
-        event_del(mtcp->es, event);
-    }
-}
-
-void
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
+multi_tcp_dereference_instance(struct multi_protocol *multi_io, struct mul=
ti_instance *mi)
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
-multi_tcp_set_global_rw_flags(struct multi_context *m, struct multi_instan=
ce *mi)
-{
-    if (mi)
-    {
-        mi->socket_set_called =3D true;
-        socket_set(mi->context.c2.link_sockets[0],
-                   m->mtcp->es,
-                   mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE :=
 EVENT_READ,
-                   &mi->ev_arg,
-                   &mi->tcp_rwflags);
-    }
-}
-
-int
-multi_tcp_wait(struct context *c,
-               struct multi_tcp *mtcp)
-{
-    int status, i;
-    unsigned int *persistent =3D &mtcp->tun_rwflags;
-
-    for (i =3D 0; i < c->c1.link_sockets_num; i++)
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
@@ -312,7 +144,7 @@
     }
 }

-static bool
+bool
 multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct mult=
i_instance *mi, const unsigned int mpp_flags)
 {
     struct mbuf_item item;
@@ -336,7 +168,7 @@
     return ret;
 }

-static bool
+bool
 multi_tcp_process_outgoing_link(struct multi_context *m, bool defer, const=
 unsigned int mpp_flags)
 {
     struct multi_instance *mi =3D multi_process_outgoing_link_pre(m);
@@ -379,566 +211,3 @@
     }
     return ret;
 }
-
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
-void
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
-void
-multi_tcp_process_io(struct multi_context *m)
-{
-    struct multi_tcp *mtcp =3D m->mtcp;
-    const unsigned int udp_status =3D mtcp->udp_flags;
-    const unsigned int mpp_flags =3D m->top.c2.fast_io
-                                   ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLO=
SE_ON_SIGNAL)
-                                   : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL=
);
-    int i;
-
-    for (i =3D 0; i < mtcp->n_esr; ++i)
-    {
-        struct event_set_return *e =3D &mtcp->esr[i];
-        struct event_arg *ev_arg =3D (struct event_arg *)e->arg;
-
-        /* incoming data for instance or listening socket? */
-        if (e->arg >=3D MULTI_N)
-        {
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
-                    if (!ev_arg->u.ls)
-                    {
-                        msg(D_MULTI_ERRORS, "MULTI: mtcp_proc_io: null soc=
ket");
-                        break;
-                    }
-
-                    if (!proto_is_dgram(ev_arg->u.ls->info.proto))
-                    {
-                        socket_reset_listen_persistent(ev_arg->u.ls);
-                        mi =3D multi_create_instance_tcp(m, ev_arg->u.ls);
-                        if (mi)
-                        {
-                            multi_tcp_action(m, mi, TA_INITIAL, false);
-                        }
-                        break;
-                    }
-                    else
-                    {
-                        if (e->arg >=3D MULTI_N)
-                        {
-                            struct event_arg *ev_arg =3D (struct event_arg=
 *)e->arg;
-                            if (ev_arg->type !=3D EVENT_ARG_LINK_SOCKET)
-                            {
-                                mtcp->udp_flags =3D ES_ERROR;
-                                msg(D_LINK_ERRORS,
-                                    "io_work: non socket event delivered");
-                                break;
-                            }
-                        }
-                        else
-                        {
-                            ev_arg->pending =3D true;
-                        }
-
-                        if (udp_status & SOCKET_READ)
-                        {
-                            read_incoming_link(&m->top, ev_arg->u.ls);
-                            if (!IS_SIG(&m->top))
-                            {
-                                multi_process_incoming_link(m, NULL, mpp_f=
lags,
-                                                            ev_arg->u.ls);
-                            }
-                        }
-
-                        while (true)
-                        {
-                            multi_get_timeout(m, &m->top.c2.timeval);
-                            get_io_flags_udp(&m->top, m->mtcp, p2mp_iow_fl=
ags(m));
-                            MULTI_CHECK_SIG(m);
-
-                            multi_process_per_second_timers(m);
-
-                            if (m->mtcp->udp_flags =3D=3D ES_TIMEOUT)
-                            {
-                                multi_process_timeout(m, MPP_PRE_SELECT | =
MPP_CLOSE_ON_SIGNAL);
-                            }
-                            else
-                            {
-                                multi_process_io_udp(m);
-                                MULTI_CHECK_SIG(m);
-                                break;
-                            }
-                        }
-                        break;
-                    }
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
-            /* new incoming TCP client attempting to connect? */
-            else if (e->arg =3D=3D MTCP_SOCKET)
-            {
-                struct multi_instance *mi;
-                ASSERT(m->top.c2.link_sockets[0]);
-                socket_reset_listen_persistent(m->top.c2.link_sockets[0]);
-                mi =3D multi_create_instance_tcp(m, m->top.c2.link_sockets=
[0]);
-                if (mi)
-                {
-                    multi_tcp_action(m, mi, TA_INITIAL, false);
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
-/*
- * Top level event loop for single-threaded operation.
- * TCP mode.
- */
-void
-tunnel_server_tcp(struct context *top)
-{
-    struct multi_context multi;
-    int status;
-
-    top->mode =3D CM_TOP;
-    context_clear_2(top);
-
-    /* initialize top-tunnel instance */
-    init_instance_handle_signals(top, top->es, CC_HARD_USR1_TO_HUP);
-    if (IS_SIG(top))
-    {
-        return;
-    }
-
-    /* initialize global multi_context object */
-    multi_init(&multi, top);
-
-    /* initialize our cloned top object */
-    multi_top_init(&multi, top);
-
-    /* initialize management interface */
-    init_management_callback_multi(&multi);
-
-    /* finished with initialization */
-    initialization_sequence_completed(top, ISC_SERVER); /* --mode server -=
-proto tcp-server */
-
-#ifdef ENABLE_ASYNC_PUSH
-    multi.top.c2.inotify_fd =3D inotify_init();
-    if (multi.top.c2.inotify_fd < 0)
-    {
-        msg(D_MULTI_ERRORS | M_ERRNO, "MULTI: inotify_init error");
-    }
-#endif
-
-    /* per-packet event loop */
-    while (true)
-    {
-        perf_push(PERF_EVENT_LOOP);
-
-        /* wait on tun/socket list */
-        multi_get_timeout(&multi, &multi.top.c2.timeval);
-        status =3D multi_tcp_wait(&multi.top, multi.mtcp);
-        MULTI_CHECK_SIG(&multi);
-
-        /* check on status of coarse timers */
-        multi_process_per_second_timers(&multi);
-
-        /* timeout? */
-        if (status > 0)
-        {
-            /* process the I/O which triggered select */
-            /*multi_tcp_process_io(&multi); */
-            MULTI_CHECK_SIG(&multi);
-        }
-        else if (status =3D=3D 0)
-        {
-            /*multi_tcp_action(&multi, NULL, TA_TIMEOUT, false); */
-        }
-
-        perf_pop();
-    }
-
-#ifdef ENABLE_ASYNC_PUSH
-    close(top->c2.inotify_fd);
-#endif
-
-    /* shut down management interface */
-    uninit_management_callback();
-
-    /* save ifconfig-pool */
-    multi_ifconfig_pool_persist(&multi, true);
-
-    /* tear down tunnel instance (unless --persist-tun) */
-    multi_uninit(&multi);
-    multi_top_free(&multi);
-    close_instance(top);
-}
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index d55bdfd..b8a0191 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -63,26 +63,23 @@

 struct multi_instance;
 struct context;
+struct multi_protocol;

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

-int multi_tcp_wait(struct context *c, struct multi_tcp *mtcp);
+bool multi_tcp_process_outgoing_link(struct multi_context *m, bool defer, =
const unsigned int mpp_flags);

-void multi_tcp_process_io(struct multi_context *m);
+bool multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct=
 multi_instance *mi, const unsigned int mpp_flags);

-void multi_tcp_action(struct multi_context *m, struct multi_instance *mi, =
int action, bool poll);
-
+struct multi_instance *multi_create_instance_tcp(struct multi_context *m, =
struct link_socket *ls);

 void multi_tcp_link_out_deferred(struct multi_context *m, struct multi_ins=
tance *mi);

+struct context *multi_tcp_context(struct multi_context *m, struct multi_in=
stance *mi);

 /*************************************************************************=
*/
 /**
@@ -91,9 +88,6 @@
  *
  * @param top - Top-level context structure.
  */
-void tunnel_server_tcp(struct context *top);
-
-
-void multi_tcp_delete_event(struct multi_tcp *mtcp, event_t event);
+/*void tunnel_server_tcp(struct context *top); */

 #endif /* ifndef MTCP_H */
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 8945a55..d29f7a5 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -379,7 +379,7 @@
 void
 multi_process_io_udp(struct multi_context *m)
 {
-    unsigned int status =3D m->mtcp->udp_flags;
+    unsigned int status =3D m->multi_io->udp_flags;
     const unsigned int mpp_flags =3D m->top.c2.fast_io
                                    ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLO=
SE_ON_SIGNAL)
                                    : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL=
);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 108a5a8..b29134e 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -440,7 +440,7 @@
     /*
      * Initialize multi-socket TCP I/O wait object
      */
-    m->mtcp =3D multi_tcp_init(t->options.max_clients, &m->max_clients);
+    m->multi_io =3D multi_protocol_init(t->options.max_clients, &m->max_cl=
ients);

     m->tcp_queue_limit =3D t->options.tcp_queue_limit;

@@ -668,7 +668,7 @@

         if (!is_dgram)
         {
-            multi_tcp_dereference_instance(m->mtcp, mi);
+            multi_tcp_dereference_instance(m->multi_io, mi);
         }

         mbuf_dereference_instance(m->mbuf, mi);
@@ -746,7 +746,7 @@
         initial_rate_limit_free(m->initial_rate_limiter);
         multi_reap_free(m->reaper);
         mroute_helper_free(m->route_helper);
-        multi_tcp_free(m->mtcp);
+        multi_protocol_free(m->multi_io);
     }
 }

@@ -3997,9 +3997,9 @@
 management_delete_event(void *arg, event_t event)
 {
     struct multi_context *m =3D (struct multi_context *) arg;
-    if (m->mtcp)
+    if (m->multi_io)
     {
-        multi_tcp_delete_event(m->mtcp, event);
+        multi_protocol_delete_event(m->multi_io, event);
     }
 }

@@ -4177,7 +4177,7 @@
     ASSERT(mi->context.c2.tls_multi->peer_id < m->max_clients);
 }

-
+/* Actual multi protocol event loop in server mode */
 void
 tunnel_server_loop(struct multi_context *multi)
 {
@@ -4189,7 +4189,7 @@

         /* wait on tun/socket list */
         multi_get_timeout(multi, &multi->top.c2.timeval);
-        status =3D multi_tcp_wait(&multi->top, multi->mtcp);
+        status =3D multi_protocol_io_wait(&multi->top, multi->multi_io);
         MULTI_CHECK_SIG(multi);

         /* check on status of coarse timers */
@@ -4199,18 +4199,25 @@
         if (status > 0)
         {
             /* process the I/O which triggered select */
-            multi_tcp_process_io(multi);
+            multi_protocol_process_io(multi);
             MULTI_CHECK_SIG(multi);
         }
         else if (status =3D=3D 0)
         {
-            multi_tcp_action(multi, NULL, TA_TIMEOUT, false);
+            multi_protocol_action(multi, NULL, TA_TIMEOUT, false);
         }

         perf_pop();
     }
 }

+/*************************************************************************=
*/
+/**
+ * Main event loop for OpenVPN in server mode.
+ * @ingroup eventloop
+ *
+ * @param top - Top-level context structure.
+ */
 void
 tunnel_server_init(struct context *top)
 {
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 472c2a3..dd7a29c 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -37,6 +37,7 @@
 #include "pool.h"
 #include "mudp.h"
 #include "mtcp.h"
+#include "multi_io.h"
 #include "perf.h"
 #include "vlan.h"
 #include "reflect_filter.h"
@@ -169,8 +170,8 @@
     struct mbuf_set *mbuf;      /**< Set of buffers for passing data
                                  *   channel packets between VPN tunnel
                                  *   instances. */
-    struct multi_tcp *mtcp;     /**< State specific to OpenVPN using TCP
-                                 *   as external transport. */
+    struct multi_protocol *multi_io;     /**< State specific to OpenVPN us=
ing both TCP
+                                          *   and UDP as external transpor=
t. */
     struct ifconfig_pool *ifconfig_pool;
     struct frequency_limit *new_connection_limiter;
     struct initial_packet_rate_limit *initial_rate_limiter;
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
new file mode 100644
index 0000000..a1ea7fb
--- /dev/null
+++ b/src/openvpn/multi_io.c
@@ -0,0 +1,687 @@
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
+multi_protocol_io_wait(struct context *c,
+                       struct multi_protocol *multi_io)
+{
+    int status, i;
+    unsigned int *persistent =3D &multi_io->tun_rwflags;
+
+    for (i =3D 0; i < c->c1.link_sockets_num; i++)
+    {
+        socket_set_listen_persistent(c->c2.link_sockets[i], multi_io->es,
+                                     &c->c2.link_sockets[i]->ev_arg);
+    }
+
+#ifdef _WIN32
+    if (tuntap_is_wintun(c->c1.tuntap))
+    {
+        if (!tuntap_ring_empty(c->c1.tuntap))
+        {
+            /* there is data in wintun ring buffer, read it immediately */
+            multi_io->esr[0].arg =3D MULTI_IO_TUN;
+            multi_io->esr[0].rwflags =3D EVENT_READ;
+            multi_io->n_esr =3D 1;
+            return 1;
+        }
+        persistent =3D NULL;
+    }
+#endif
+    tun_set(c->c1.tuntap, multi_io->es, EVENT_READ, MULTI_IO_TUN, persiste=
nt);
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+    dco_event_set(&c->c1.tuntap->dco, multi_io->es, MULTI_IO_DCO);
+#endif
+
+#ifdef ENABLE_MANAGEMENT
+    if (management)
+    {
+        management_socket_set(management, multi_io->es, MULTI_IO_MANAGEMEN=
T, &multi_io->management_persist_flags);
+    }
+#endif
+
+#ifdef ENABLE_ASYNC_PUSH
+    /* arm inotify watcher */
+    event_ctl(multi_io->es, c->c2.inotify_fd, EVENT_READ, MULTI_IO_FILE_CL=
OSE_WRITE);
+#endif
+
+    status =3D event_wait(multi_io->es, &c->c2.timeval, multi_io->esr, mul=
ti_io->maxevents);
+    update_time();
+    multi_io->n_esr =3D 0;
+    if (status > 0)
+    {
+        multi_io->n_esr =3D status;
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
+static inline void
+multi_protocol_set_global_rw_flags(struct multi_context *m, struct multi_i=
nstance *mi)
+{
+    if (mi)
+    {
+        mi->socket_set_called =3D true;
+        socket_set(mi->context.c2.link_sockets[0],
+                   m->multi_io->es,
+                   mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE :=
 EVENT_READ,
+                   &mi->ev_arg,
+                   &mi->tcp_rwflags);
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
+            multi_protocol_set_global_rw_flags(m, mi);
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
+                multi_protocol_set_global_rw_flags(m, mi);
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
+    const unsigned int udp_status =3D multi_io->udp_flags;
+    const unsigned int mpp_flags =3D m->top.c2.fast_io
+                                   ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLO=
SE_ON_SIGNAL)
+                                   : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL=
);
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
+                    if (!ev_arg->u.ls)
+                    {
+                        msg(D_MULTI_ERRORS, "MULTI PROTOCOL: multi_proto_p=
roc_io: null socket");
+                        break;
+                    }
+
+                    if (!proto_is_dgram(ev_arg->u.ls->info.proto))
+                    {
+                        socket_reset_listen_persistent(ev_arg->u.ls);
+                        mi =3D multi_create_instance_tcp(m, ev_arg->u.ls);
+                        if (mi)
+                        {
+                            multi_protocol_action(m, mi, TA_INITIAL, false=
);
+                        }
+                        break;
+                    }
+                    else
+                    {
+                        if (e->arg >=3D MULTI_N)
+                        {
+                            struct event_arg *ev_arg =3D (struct event_arg=
 *)e->arg;
+                            if (ev_arg->type !=3D EVENT_ARG_LINK_SOCKET)
+                            {
+                                multi_io->udp_flags =3D ES_ERROR;
+                                msg(D_LINK_ERRORS,
+                                    "MULTI PROTOCOL: io_work: non socket e=
vent delivered");
+                                break;
+                            }
+                        }
+                        else
+                        {
+                            ev_arg->pending =3D true;
+                        }
+
+                        if (udp_status & SOCKET_READ)
+                        {
+                            read_incoming_link(&m->top, ev_arg->u.ls);
+                            if (!IS_SIG(&m->top))
+                            {
+                                multi_process_incoming_link(m, NULL, mpp_f=
lags,
+                                                            ev_arg->u.ls);
+                            }
+                        }
+
+                        while (true)
+                        {
+                            multi_get_timeout(m, &m->top.c2.timeval);
+                            get_io_flags_udp(&m->top, m->multi_io, p2mp_io=
w_flags(m));
+                            MULTI_CHECK_SIG(m);
+
+                            multi_process_per_second_timers(m);
+
+                            if (m->multi_io->udp_flags =3D=3D ES_TIMEOUT)
+                            {
+                                multi_process_timeout(m, MPP_PRE_SELECT | =
MPP_CLOSE_ON_SIGNAL);
+                            }
+                            else
+                            {
+                                multi_process_io_udp(m);
+                                MULTI_CHECK_SIG(m);
+                                break;
+                            }
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
index 0000000..bd27f08
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
+int multi_protocol_io_wait(struct context *c, struct multi_protocol *multi=
_io);
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
To view, visit http://gerrit.openvpn.net/c/openvpn/+/441?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id2d7957f5950115d9baade4c09fd9679b01f749b
Gerrit-Change-Number: 441
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--/+HJ+sN5qjY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/441?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">multiproto: move generic event handling code in dedicated fil=
es<br><br>Introduced multi_io.h and multi_io.c files to centralize<br>all c=
odes related to multiple protocols.<br><br>Renamed the struct mtcp to struc=
t multi_protocol since it<br>encompasses the event_set used by the parent c=
ontext in server mode.<br><br>Several methods have also been renamed and mo=
ved to fit the<br>multiproto structure:<br><br>- multi_tcp_init() -&gt; mul=
ti_protocol_init();<br>- multi_tcp_free() -&gt; multi_protocol_free();<br>-=
 multi_tcp_wait() -&gt; multi_protocol_io_wait();<br>and so forth.<br><br>C=
hange-Id: Id2d7957f5950115d9baade4c09fd9679b01f749b<br>Signed-off-by: Gianm=
arco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M CMakeLists.txt<br>=
M src/openvpn/Makefile.am<br>M src/openvpn/forward.c<br>M src/openvpn/forwa=
rd.h<br>M src/openvpn/mtcp.c<br>M src/openvpn/mtcp.h<br>M src/openvpn/mudp.=
c<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>A src/openvpn/multi_=
io.c<br>A src/openvpn/multi_io.h<br>11 files changed, 821 insertions(+), 77=
7 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/41/441/1</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</s=
pan><br><span>index d21c9bd..ee27465 100644</span><br><span>--- a/CMakeList=
s.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -402,6 +402,8=
 @@</span><br><span>     src/openvpn/mudp.h</span><br><span>     src/openvp=
n/multi.c</span><br><span>     src/openvpn/multi.h</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    src/openvpn/multi_io.c</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/multi_io.h</span><br>=
<span>     src/openvpn/ntlm.c</span><br><span>     src/openvpn/ntlm.h</span=
><br><span>     src/openvpn/occ.c</span><br><span>diff --git a/src/openvpn/=
Makefile.am b/src/openvpn/Makefile.am</span><br><span>index 52deef8..17fcb1=
b 100644</span><br><span>--- a/src/openvpn/Makefile.am</span><br><span>+++ =
b/src/openvpn/Makefile.am</span><br><span>@@ -89,6 +89,7 @@</span><br><span=
> 	mtu.c mtu.h \</span><br><span> 	mudp.c mudp.h \</span><br><span> 	multi.=
c multi.h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	multi_i=
o.c multi_io.h \</span><br><span> 	networking_freebsd.c \</span><br><span> =
	networking_iproute2.c networking_iproute2.h \</span><br><span> 	networking=
_sitnl.c networking_sitnl.h \</span><br><span>diff --git a/src/openvpn/forw=
ard.c b/src/openvpn/forward.c</span><br><span>index ee18f8b..0e5b611 100644=
</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/open=
vpn/forward.c</span><br><span>@@ -2053,7 +2053,7 @@</span><br><span>  */</s=
pan><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-get_io_flags_dowork_udp(struct context *c, struct multi_tcp=
 *mtcp, const unsigned int flags)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+get_io_flags_dowork_udp(struct context *c, struct multi_proto=
col *multi_io, const unsigned int flags)</span><br><span> {</span><br><span=
>     unsigned int socket =3D 0;</span><br><span>     unsigned int tuntap =
=3D 0;</span><br><span>@@ -2064,7 +2064,7 @@</span><br><span>      */</span=
><br><span>     if (flags &amp; IOW_WAIT_SIGNAL)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        wait_signal(mtcp-=
&gt;es, (void *)err_shift);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        wait_signal(multi_io-&gt;es, (void *)err_shift);</span><br>=
<span>     }</span><br><span> </span><br><span>     if (flags &amp; IOW_TO_=
LINK)</span><br><span>@@ -2156,17 +2156,17 @@</span><br><span>     {</span>=
<br><span>         if (proto_is_dgram(c-&gt;c2.link_sockets[i]-&gt;info.pro=
to))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            socket_set(c-&gt;c2.link_sockets[i], mtcp-&gt;es, soc=
ket,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            soc=
ket_set(c-&gt;c2.link_sockets[i], multi_io-&gt;es, socket,</span><br><span>=
                        &amp;c-&gt;c2.link_sockets[i]-&gt;ev_arg, NULL);</s=
pan><br><span>         }</span><br><span>     }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    mtcp-&gt;udp_flags =3D socket | tuntap;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_io-&gt;udp_flag=
s =3D socket | tuntap;</span><br><span> }</span><br><span> </span><br><span=
> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_io_flags_ud=
p(struct context *c, struct multi_tcp *mtcp, const unsigned int flags)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+get_io_flags_udp(struct =
context *c, struct multi_protocol *multi_io, const unsigned int flags)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mtc=
p-&gt;udp_flags =3D ES_ERROR;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    multi_io-&gt;udp_flags =3D ES_ERROR;</span><br><span>     if =
(c-&gt;c2.fast_io &amp;&amp; (flags &amp; (IOW_TO_TUN | IOW_TO_LINK | IOW_M=
BUF)))</span><br><span>     {</span><br><span>         /* fast path -- only=
 for TUN/TAP/UDP writes */</span><br><span>@@ -2179,7 +2179,7 @@</span><br>=
<span>         {</span><br><span>             ret |=3D SOCKET_WRITE;</span>=
<br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       mtcp-&gt;udp_flags =3D ret;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        multi_io-&gt;udp_flags =3D ret;</span><br><span>    =
 }</span><br><span>     else</span><br><span>     {</span><br><span>@@ -220=
5,13 +2205,13 @@</span><br><span>             {</span><br><span>           =
      ret |=3D TUN_READ;</span><br><span>             }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            mtcp-&gt;udp_flags =3D ret;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi_io-=
&gt;udp_flags =3D ret;</span><br><span>         }</span><br><span>         =
else</span><br><span> #endif /* ifdef _WIN32 */</span><br><span>         {<=
/span><br><span>             /* slow path - delegate to io_wait_dowork_udp =
to calculate flags */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            get_io_flags_dowork_udp(c, mtcp, flags);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            get_io_flags_dowork_udp(c, mu=
lti_io, flags);</span><br><span>         }</span><br><span>     }</span><br=
><span> }</span><br><span>diff --git a/src/openvpn/forward.h b/src/openvpn/=
forward.h</span><br><span>index 39ac975..a251d04 100644</span><br><span>---=
 a/src/openvpn/forward.h</span><br><span>+++ b/src/openvpn/forward.h</span>=
<br><span>@@ -50,7 +50,7 @@</span><br><span> #include &quot;openvpn.h&quot;=
</span><br><span> #include &quot;occ.h&quot;</span><br><span> #include &quo=
t;ping.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#includ=
e &quot;mtcp.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;multi_io.h&quot;</span><br><span> </span><br><span> #define=
 IOW_TO_TUN          (1&lt;&lt;0)</span><br><span> #define IOW_TO_LINK     =
    (1&lt;&lt;1)</span><br><span>@@ -65,13 +65,19 @@</span><br><span> </spa=
n><br><span> #define IOW_READ            (IOW_READ_TUN|IOW_READ_LINK)</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* forward declaration */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*struct multi_conte=
xt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * struct multi_=
protocol;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * struct =
context;*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> extern counter_type link_read_bytes_global;</span><br><span> </spa=
n><br><span> extern counter_type link_write_bytes_global;</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void get_io_flags_dow=
ork_udp(struct context *c, struct multi_tcp *mtcp, const unsigned int flags=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void get_io_flags=
_dowork_udp(struct context *c, struct multi_protocol *multi_io, const unsig=
ned int flags);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void get_io_flags_udp(struct context *c, struct multi_tcp *mtcp=
, const unsigned int flags);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void get_io_flags_udp(struct context *c, struct multi_protocol *mu=
lti_io, const unsigned int flags);</span><br><span> </span><br><span> void =
io_wait_dowork(struct context *c, const unsigned int flags);</span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</s=
pan><br><span>index 128a375..4efce35 100644</span><br><span>--- a/src/openv=
pn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -29,6=
 +29,8 @@</span><br><span> </span><br><span> #include &quot;multi.h&quot;</=
span><br><span> #include &quot;forward.h&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;mtcp.h&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi_io.h&quot;</span><b=
r><span> </span><br><span> #include &quot;memdbg.h&quot;</span><br><span> <=
/span><br><span>@@ -36,70 +38,7 @@</span><br><span> #include &lt;sys/inotif=
y.h&gt;</span><br><span> #endif</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * Special tags passed to event.[ch] functions</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define MTCP_SOCKET      ((void *)1)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define MTCP_TUN         ((void *)2)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define MTCP_SIG         ((v=
oid *)3) /* Only on Windows */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define MTCP_MANAGEMENT ((void *)4)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define MTCP_FILE_CLOSE_WRITE ((void *)5)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define MTCP_DCO        ((void *=
)6)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-struct ta_iow_flags</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    unsigned int flags;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    unsigned int ret;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    unsigned int tun;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    unsigned int sock;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static const char *</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-pract(int action)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    switch (action)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        case TA_UNDEF:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            return &quot;TA_UNDEF&quot;;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        case TA_SOCKET_READ:</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            return &quot;TA_SOCKET_READ&quot;;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        case TA_SOCKET_READ_RESIDUAL:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            return &quot;TA_SOCKET_READ_RES=
IDUAL&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKET_WRITE:<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return &qu=
ot;TA_SOCKET_WRITE&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_S=
OCKET_WRITE_READY:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         return &quot;TA_SOCKET_WRITE_READY&quot;;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        case TA_SOCKET_WRITE_DEFERRED:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            return &quot;TA_SOCKET_WRITE_DEFERRED&=
quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        case TA_TUN_READ:</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            return &quot;TA_TUN_=
READ&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_TUN_WRITE:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            return &quot;T=
A_TUN_WRITE&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_INITIAL:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return &q=
uot;TA_INITIAL&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_TIMEO=
UT:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return=
 &quot;TA_TIMEOUT&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_TU=
N_WRITE_TIMEOUT:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       return &quot;TA_TUN_WRITE_TIMEOUT&quot;;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            return &quot;?&quot;;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ENABLE_DEBUG *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-static struct multi_instance *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+struct multi_instance *</span>=
<br><span> multi_create_instance_tcp(struct multi_context *m, struct link_s=
ocket *ls)</span><br><span> {</span><br><span>     struct gc_arena gc =3D g=
c_new();</span><br><span>@@ -180,126 +119,19 @@</span><br><span>     mbuf_f=
ree(mi-&gt;tcp_link_out_deferred);</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-struct multi_tcp *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_init(int maxevents=
, int *maxclients)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_tcp *m=
tcp;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int ext=
ra_events =3D BASE_N_EVENTS;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(max=
events &gt;=3D 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 ASSERT(maxclients);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ_CLEAR(mt=
cp, struct multi_tcp);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    mtcp-&gt;maxevents =3D maxevents + extra_events;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    mtcp-&gt;es =3D event_set_init(&amp;mtc=
p-&gt;maxevents, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   wait_signal(mtcp-&gt;es, MTCP_SIG);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    ALLOC_ARRAY(mtcp-&gt;esr, struct event_set_return, mtc=
p-&gt;maxevents);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
*maxclients =3D max_int(min_int(mtcp-&gt;maxevents - extra_events, *maxclie=
nts), 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_MU=
LTI_LOW, &quot;MULTI: TCP INIT maxclients=3D%d maxevents=3D%d&quot;, *maxcl=
ients, mtcp-&gt;maxevents);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return mtcp;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_delete_e=
vent(struct multi_tcp *mtcp, event_t event)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (mtcp &amp;&amp; mtcp-&gt;es)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        event_del(mtcp-&gt;es, event);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-multi_tcp_free(struct multi_tcp *mtcp)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (mtcp)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
event_free(mtcp-&gt;es);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        free(mtcp-&gt;esr);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        free(mtcp);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-multi_tcp_dereference_instance(struct multi_tcp *mtcp, struct multi=
_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi=
_tcp_dereference_instance(struct multi_protocol *multi_io, struct multi_ins=
tance *mi)</span><br><span> {</span><br><span>     struct link_socket *ls =
=3D mi-&gt;context.c2.link_sockets[0];</span><br><span>     if (ls &amp;&am=
p; mi-&gt;socket_set_called)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        event_del(mtcp-&gt;es, socket_event=
_handle(ls));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  event_del(multi_io-&gt;es, socket_event_handle(ls));</span><br><span>    =
     mi-&gt;socket_set_called =3D false;</span><br><span>     }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    mtcp-&gt;n_esr =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_io-&gt;n_esr =3D =
0;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static inline void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-multi_tcp_set_global_rw_flags(struct multi_context *m, struc=
t multi_instance *mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mi)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        mi-&gt;socket_set_called =3D true;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        socket_set(mi-&gt=
;context.c2.link_sockets[0],</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                   m-&gt;mtcp-&gt;es,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                   mbuf_defined(mi-&gt;tcp_link_out_=
deferred) ? EVENT_WRITE : EVENT_READ,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                   &amp;mi-&gt;ev_arg,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                   &amp;mi-&gt;tcp_rwflags=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-i=
nt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_wait(stru=
ct context *c,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
        struct multi_tcp *mtcp)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int st=
atus, i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned =
int *persistent =3D &amp;mtcp-&gt;tun_rwflags;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        socket_set_listen_persistent(c-&gt;c2.link_s=
ockets[i], mtcp-&gt;es,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                     &amp;c-&gt;c2.link_sockets[i]-&gt;ev=
_arg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (tuntap_is_wintun(c-&gt;c1.tuntap))</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (!tuntap_ring_empty(c-&gt;c1.tuntap))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            /* there is data in wintun r=
ing buffer, read it immediately */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            mtcp-&gt;esr[0].arg =3D MTCP_TUN;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            mtcp-&gt;esr[0].rwflags =
=3D EVENT_READ;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      mtcp-&gt;n_esr =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            return 1;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  persistent =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    tun_set(c-&gt;c1.tuntap, m=
tcp-&gt;es, EVENT_READ, MTCP_TUN, persistent);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX) || defined(TARGET_FREEBS=
D)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco_event_set(&=
amp;c-&gt;c1.tuntap-&gt;dco, mtcp-&gt;es, MTCP_DCO);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (management)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        management_=
socket_set(management, mtcp-&gt;es, MTCP_MANAGEMENT, &amp;mtcp-&gt;manageme=
nt_persist_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /* arm inotify watcher */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    event_ctl(mtcp-&gt;es, c-&gt;c2.inotify=
_fd, EVENT_READ, MTCP_FILE_CLOSE_WRITE);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D ev=
ent_wait(mtcp-&gt;es, &amp;c-&gt;c2.timeval, mtcp-&gt;esr, mtcp-&gt;maxeven=
ts);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    update_time()=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mtcp-&gt;n_esr =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (status =
&gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        mtcp-&gt;n_esr =3D sta=
tus;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return status;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
atic inline struct context *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+struct context *</span><br><span> multi_tcp_context(struct multi_c=
ontext *m, struct multi_instance *mi)</span><br><span> {</span><br><span>  =
   if (mi)</span><br><span>@@ -312,7 +144,7 @@</span><br><span>     }</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bool</span><br><span> multi_tcp_process_outgoing_link_ready(struct multi_=
context *m, struct multi_instance *mi, const unsigned int mpp_flags)</span>=
<br><span> {</span><br><span>     struct mbuf_item item;</span><br><span>@@=
 -336,7 +168,7 @@</span><br><span>     return ret;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><s=
pan> multi_tcp_process_outgoing_link(struct multi_context *m, bool defer, c=
onst unsigned int mpp_flags)</span><br><span> {</span><br><span>     struct=
 multi_instance *mi =3D multi_process_outgoing_link_pre(m);</span><br><span=
>@@ -379,566 +211,3 @@</span><br><span>     }</span><br><span>     return r=
et;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_wait_lite(struct mult=
i_context *m, struct multi_instance *mi, const int action, bool *tun_input_=
pending)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct context *c =3D multi_t=
cp_context(m, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 unsigned int looking_for =3D 0;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D=
_MULTI_DEBUG, &quot;MULTI TCP: multi_tcp_wait_lite a=3D%s mi=3D&quot; ptr_f=
ormat,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         pract(=
action),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         (ptr=
_type)mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    tv_clear(&amp;c-&gt;c2.timev=
al); /* ZERO-TIMEOUT */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (action)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        case TA_TUN_READ:</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            looking_for =3D TUN_R=
EAD;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            tun_i=
nput_pending =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            io_wait(c, IOW_READ_TUN);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 case TA_SOCKET_READ:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            looking_for =3D SOCKET_READ;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            tun_input_pending =3D NULL;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            io_wait(c, IOW_READ_LINK);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        case TA_TUN_WRITE:</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            looking_for =3D TUN_WRITE;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            tun_input=
_pending =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         c-&gt;c2.timeval.tv_sec =3D 1; /* For some reason, the Linux 2.2 T=
UN/TAP driver hits this timeout */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            perf_push(PERF_PROC_OUT_TUN_MTCP);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            io_wait(c, IOW_TO_TUN);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            perf_pop();=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKET_WRITE:</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            looking_for =3D SOCKET_=
WRITE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            io_=
wait(c, IOW_TO_LINK|IOW_READ_TUN_FORCE);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  msg(M_FATAL, &quot;MULTI TCP: multi_tcp_wait_lite, unhandled action=3D%d&=
quot;, action);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (tun_input_pending &amp;&amp; (c-&gt=
;c2.event_set_status &amp; TUN_READ))</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        *tun_input_pending =3D true;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;c2.event=
_set_status &amp; looking_for)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 return action;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        switch (action)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            /* TCP socket output buffer is full */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            case TA_SOCKET_WRITE=
:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                retu=
rn TA_SOCKET_WRITE_DEFERRED;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /*=
 TUN device timed out on accepting write */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            case TA_TUN_WRITE:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                return TA_TUN_WRITE_TIMEOUT=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        return TA_UNDEF;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-static struct multi_instance *</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_dispatch(stru=
ct multi_context *m, struct multi_instance *mi, const int action)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    const unsigned int mpp_flags =3D MPP_PRE_SELECT=
|MPP_RECORD_TOUCH;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 struct multi_instance *touched =3D mi;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    m-&gt;mpp_touched =3D &amp;touched;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    dmsg(D_MULTI_DEBUG, &quot;MULTI TCP: multi_tcp_dispatch =
a=3D%s mi=3D&quot; ptr_format,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-         pract(action),</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-         (ptr_type)mi);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    swit=
ch (action)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_TUN_READ:<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            read_incom=
ing_tun(&amp;m-&gt;top);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            if (!IS_SIG(&amp;m-&gt;top))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                multi_process_incoming_tun(m, mpp_flags);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        case TA_SOCKET_READ:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        case TA_SOCKET_READ_RESIDUAL:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(mi);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(mi-&gt;contex=
t.c2.link_sockets);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          ASSERT(mi-&gt;context.c2.link_sockets[0]);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            set_prefix(mi);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            read_incoming_link(&amp;m=
i-&gt;context, mi-&gt;context.c2.link_sockets[0]);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            clear_prefix();</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            if (!IS_SIG(&amp;mi-&gt;cont=
ext))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                multi_pr=
ocess_incoming_link(m, mi, mpp_flags,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                                            mi-&gt;context.=
c2.link_sockets[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               if (!IS_SIG(&amp;mi-&gt;context))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    stream_buf_read_setup(mi-&gt;con=
text.c2.link_sockets[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        case TA_TIMEOUT:</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_process_tim=
eout(m, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_TUN_WRITE:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_pro=
cess_outgoing_tun(m, mpp_flags);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            break;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case =
TA_TUN_WRITE_TIMEOUT:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            multi_process_drop_outgoing_tun(m, mpp_flags);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        case TA_SOCKET_WRITE_READY:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            ASSERT(mi);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            multi_tcp_process_outgoing_link_re=
ady(m, mi, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKET_=
WRITE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mul=
ti_tcp_process_outgoing_link(m, false, mpp_flags);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        case TA_SOCKET_WRITE_DEFERRED:</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            multi_tcp_process_outgoing_link(m, true, =
mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        case TA_INITIAL:</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(mi);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_tcp_set_glo=
bal_rw_flags(m, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           multi_process_post(m, mi, mpp_flags);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          msg(M_FATAL, &quot;MULTI TCP: multi_tcp_dispatch, unhandled actio=
n=3D%d&quot;, action);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;mpp_touched =3D NULL;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return touched;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi=
_tcp_post(struct multi_context *m, struct multi_instance *mi, const int act=
ion)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct context *c =3D multi_tcp_c=
ontext(m, mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int=
 newaction =3D TA_UNDEF;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define MTP_NONE  =
       0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define MTP_T=
UN_OUT      (1&lt;&lt;0)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define MTP_LINK_OUT     (1&lt;&lt;1)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    unsigned int flags =3D MTP_NONE;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (TUN_OUT(c))</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   flags |=3D MTP_TUN_OUT;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (LIN=
K_OUT(c))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        flags |=3D MTP_LINK_=
OUT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    switch (flags)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        case MTP_TUN_OUT|MTP_LINK_OUT:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        case MTP_TUN_OUT:</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            newaction =3D TA_TUN_WRITE;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        case MTP_LINK_OUT:</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            newaction =3D TA_SOCKET_WRITE;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        case MTP_NONE:</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (mi &amp;&amp; sockets_read_residual(c))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                newaction =3D=
 TA_SOCKET_READ_RESIDUAL;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                m=
ulti_tcp_set_global_rw_flags(m, mi);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        default:<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 msg(M_FATAL, &quot;MULTI TCP: multi_tcp_post bad state, mi=3D%s flags=3D%d=
&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  multi_instance_string(mi, false, &amp;gc),</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                flags);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            gc_free(&amp;gc);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_MULTI_=
DEBUG, &quot;MULTI TCP: multi_tcp_post %s -&gt; %s&quot;,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-         pract(action),</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-         pract(newaction));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return newaction;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_action(struct multi_conte=
xt *m, struct multi_instance *mi, int action, bool poll)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    bool tun_input_pending =3D false;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_MULTI=
_DEBUG, &quot;MULTI TCP: multi_tcp_action a=3D%s p=3D%d&quot;,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-             pract(action),</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-             poll);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-         * If TA_SOCKET_READ_RESIDUAL, it means we still have =
pending</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * inp=
ut packets which were read by a prior TCP recv.</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-         *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-         * Otherwise do a &quot;lite&quot; wait, which means=
 we wait with 0 timeout</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-         * on I/O events only related to the current instance, not</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-         * the big list of e=
vents.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         *</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-         * On our first pa=
ss, poll will be false because we already know</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-         * that input is available, and to call io=
_wait would be redundant.</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (poll &amp;&amp; action !=3D TA_SOCKET_READ_RESIDUAL)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            const int orig_action =3D action;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            action =3D mul=
ti_tcp_wait_lite(m, mi, action, &amp;tun_input_pending);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            if (action =3D=3D TA_UNDEF)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_FATAL, &=
quot;MULTI TCP: I/O wait required blocking in multi_tcp_action, action=3D%d=
&quot;, orig_action);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-         * Dispatch the action</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        struct multi_instance *touched =3D multi_tcp_=
dispatch(m, mi, action);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-         * Signal received or=
 TCP connection</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
   * reset by peer?</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
       */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
touched &amp;&amp; IS_SIG(&amp;touched-&gt;context))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (mi =3D=3D touched)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                mi =3D NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            multi_close_instance_on_signal(m, touch=
ed);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
  * If dispatch produced any pending output</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-         * for a particular instance, point to</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-         * that instance.</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (m-&gt;pending)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            mi =3D m-&gt;pending;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        /*</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-         * Based on the effects of the action,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-         * such as generating pending output,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-         * possibly tran=
sition to a new action state.</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      action =3D multi_tcp_post(m, mi, action);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
   * If we are finished processing the original action,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-         * check if we have any TUN input=
.  If so, transition</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
        * our action state to processing this input.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (tun_input_pending &amp;&amp; action =3D=
=3D TA_UNDEF)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            action =
=3D TA_TUN_READ;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       mi =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          tun_input_pending =3D false;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            poll =3D false;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  poll =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    } while (action !=3D TA_UNDEF);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_=
tcp_process_io(struct multi_context *m)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct multi_tcp *mtcp =3D m-&gt;mtcp;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    const unsigned int udp_status =3D mtcp-&gt;udp_flags=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const unsigned i=
nt mpp_flags =3D m-&gt;top.c2.fast_io</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                                   ? (MPP_CONDITIONAL_PRE_S=
ELECT | MPP_CLOSE_ON_SIGNAL)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                                   : (MPP_PRE_SELECT | MPP_CLOSE_ON_=
SIGNAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; mtcp-&gt;n_esr; ++=
i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        struct event_set_return *e =
=3D &amp;mtcp-&gt;esr[i];</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        struct event_arg *ev_arg =3D (struct event_arg *)e-&gt;arg;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        /* incoming data for instance or liste=
ning socket? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (e-&gt;arg &gt;=3D MULTI_N)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           switch (ev_arg-&gt;type)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                struct multi_instance *mi;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                /* react to event on child instance */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                case EVENT_ARG_MULTI=
_INSTANCE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         if (!ev_arg-&gt;u.mi)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                        msg(D_MULTI_ERRORS, &quot;MULTI: mtcp_proc=
_io: null minstance&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                        break;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              mi =3D ev_arg-&gt;u.mi;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    if (e-&gt;rwflags &amp; EVENT_WRITE)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
multi_tcp_action(m, mi, TA_SOCKET_WRITE_READY, false);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    else if (e-&gt;rwflags=
 &amp; EVENT_READ)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                     multi_tcp_action(m, mi, TA_SOCKET_READ, false);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    break;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                /* new incoming TCP client =
attempting to connect? */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                case EVENT_ARG_LINK_SOCKET:</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    if (!ev_arg-&gt;u.ls)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                        msg(D=
_MULTI_ERRORS, &quot;MULTI: mtcp_proc_io: null socket&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                        break;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    if (!proto_is_dgram(ev_arg-=
&gt;u.ls-&gt;info.proto))</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                        socket_reset_listen_persistent(ev_arg-&gt;u.ls)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
    mi =3D multi_create_instance_tcp(m, ev_arg-&gt;u.ls);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                        if (mi)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
   multi_tcp_action(m, mi, TA_INITIAL, false);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                        }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                        break;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    else</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                        if (e-&gt;=
arg &gt;=3D MULTI_N)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                       {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                            struct event_arg *ev_arg =3D (struct event_a=
rg *)e-&gt;arg;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                      if (ev_arg-&gt;type !=3D EVENT_ARG_LINK_SOCKET)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
             mtcp-&gt;udp_flags =3D ES_ERROR;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                msg(D_LINK_ERRORS,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
              &quot;io_work: non socket event delivered&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                b=
reak;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                            ev_arg-&gt;pending =3D true;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                        if (udp_status &amp; SOCKE=
T_READ)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                  read_incoming_link(&amp;m-&gt;top, ev_arg-&gt;u.ls);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
  if (!IS_SIG(&amp;m-&gt;top))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                            {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                multi_process_incoming_lin=
k(m, NULL, mpp_flags,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                                            ev_arg-&gt;u.ls=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        whil=
e (true)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                   multi_get_timeout(m, &amp;m-&gt;top.c2.timeval);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                            g=
et_io_flags_udp(&amp;m-&gt;top, m-&gt;mtcp, p2mp_iow_flags(m));</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                            MULTI=
_CHECK_SIG(m);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
multi_process_per_second_timers(m);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                     if (m-&gt;mtcp-&gt;udp_flags =3D=3D ES_TIMEOUT)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
            multi_process_timeout(m, MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
               else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                          {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                multi_process_io_udp(m);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                MU=
LTI_CHECK_SIG(m);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                            break;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                            }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                        }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                        break;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef =
ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        if (e-&gt;arg =3D=3D MTCP_MANAGEMENT)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                ASSERT(management);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                management_io(management);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            else</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            /* incoming data on TUN? */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            if (e-&gt;arg =3D=3D=
 MTCP_TUN)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if =
(e-&gt;rwflags &amp; EVENT_WRITE)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    multi_tcp_action(m, NULL, TA_TUN_WRITE, false);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                else if (=
e-&gt;rwflags &amp; EVENT_READ)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                    multi_tcp_action(m, NULL, TA_TUN_READ, false);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            /* new incoming TCP clie=
nt attempting to connect? */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            else if (e-&gt;arg =3D=3D MTCP_SOCKET)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                struct multi_instance *mi;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                ASSERT(m-&=
gt;top.c2.link_sockets[0]);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                socket_reset_listen_persistent(m-&gt;top.c2.link_sock=
ets[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   mi =3D multi_create_instance_tcp(m, m-&gt;top.c2.link_sockets[0]);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (mi)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    multi_tcp=
_action(m, mi, TA_INITIAL, false);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#if defined(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || defined(TARGE=
T_FREEBSD))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  /* incoming data on DCO? */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            else if (e-&gt;arg =3D=3D MTCP_DCO)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                multi_process_incoming_dco(m);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            /* signal received? */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            else if (e-&gt;arg =3D=
=3D MTCP_SIG)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
get_signal(&amp;m-&gt;top.sig-&gt;signal_received);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            else if (e-&gt;arg =3D=3D MTCP_FILE_=
CLOSE_WRITE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                m=
ulti_process_file_closed(m, MPP_PRE_SELECT | MPP_RECORD_TOUCH);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (IS_SIG(&amp;m-&gt;top))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mtcp-&gt;n_esr =3D=
 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-     * Process queued mbuf packets destined for TCP so=
cket</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        struct multi_instance *mi;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        while (!IS_SIG(&amp;m-&gt;=
top) &amp;&amp; (mi =3D mbuf_peek(m-&gt;mbuf)) !=3D NULL)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            multi_tcp_action(m, mi, TA_SOCKET_WRITE=
, true);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * Top level event loop fo=
r single-threaded operation.</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * TCP mode.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-tunnel_server_tcp(struct context *top=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct multi_context multi;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int status;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    top-&gt;mode =3D CM_TOP;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    context_clear_2(top);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    /* initialize top-tunnel instance */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    init_instance_handle_signals(top, top-&gt;es=
, CC_HARD_USR1_TO_HUP);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (IS_SIG(top))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    /* initialize global multi_context object */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    multi_init(&amp;multi, top)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* initialize our cloned top object *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_top_init(&=
amp;multi, top);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* initialize manageme=
nt interface */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
it_management_callback_multi(&amp;multi);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* finished with initialization */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    initialization_sequence_completed(top, ISC_SERVER); /* =
--mode server --proto tcp-server */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef =
ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
multi.top.c2.inotify_fd =3D inotify_init();</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (multi.top.c2.inotify_fd &lt; 0)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        msg(D_MULTI_ERRORS | M_ERRNO, &quot;MULTI: =
inotify_init error&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /* per-packet event loop */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    while (true)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        perf_push(PERF_EVENT_LOOP);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /* wait on tun/socket list */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        multi_get_timeout(&amp;multi, &amp;multi=
.top.c2.timeval);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    status =3D multi_tcp_wait(&amp;multi.top, multi.mtcp);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        MULTI_CHECK_SIG(&amp;multi);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* check on status of coarse timers=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_proc=
ess_per_second_timers(&amp;multi);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
/* timeout? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (status &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /*=
 process the I/O which triggered select */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            /*multi_tcp_process_io(&amp;multi); */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            MULTI_CHECK_S=
IG(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else if (s=
tatus =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /*mult=
i_tcp_action(&amp;multi, NULL, TA_TIMEOUT, false); */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       perf_pop();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    close(top-&gt;c2.inotify_fd);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* shut down management interface */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    uninit_management_callback();</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* save ifconfig-pool */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    multi_ifconfig_pool_persist(&amp;multi,=
 true);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    /* tear down tunnel instance (u=
nless --persist-tun) */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    multi_uninit(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    multi_top_free(&amp;multi);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    close_instance(top);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span>diff --git a/src/openvpn/mtcp.h b/=
src/openvpn/mtcp.h</span><br><span>index d55bdfd..b8a0191 100644</span><br>=
<span>--- a/src/openvpn/mtcp.h</span><br><span>+++ b/src/openvpn/mtcp.h</sp=
an><br><span>@@ -63,26 +63,23 @@</span><br><span> </span><br><span> struct =
multi_instance;</span><br><span> struct context;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+struct multi_protocol;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-struct multi_tcp *multi_tcp=
_init(int maxevents, int *maxclients);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void=
 multi_tcp_free(struct multi_tcp *mtcp);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-vo=
id multi_tcp_dereference_instance(struct multi_tcp *mtcp, struct multi_inst=
ance *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void mult=
i_tcp_dereference_instance(struct multi_protocol *multi_io, struct multi_in=
stance *mi);</span><br><span> </span><br><span> bool multi_tcp_instance_spe=
cific_init(struct multi_context *m, struct multi_instance *mi);</span><br><=
span> </span><br><span> void multi_tcp_instance_specific_free(struct multi_=
instance *mi);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-int multi_tcp_wait(struct context *c, struct multi_tcp *mtcp);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool multi_tcp_proces=
s_outgoing_link(struct multi_context *m, bool defer, const unsigned int mpp=
_flags);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-void multi_tcp_process_io(struct multi_context *m);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+bool multi_tcp_process_outgoing_link_r=
eady(struct multi_context *m, struct multi_instance *mi, const unsigned int=
 mpp_flags);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void multi_tcp_action(struct multi_context *m, struct multi_instan=
ce *mi, int action, bool poll);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct mu=
lti_instance *multi_create_instance_tcp(struct multi_context *m, struct lin=
k_socket *ls);</span><br><span> </span><br><span> void multi_tcp_link_out_d=
eferred(struct multi_context *m, struct multi_instance *mi);</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct context *=
multi_tcp_context(struct multi_context *m, struct multi_instance *mi);</spa=
n><br><span> </span><br><span> /*******************************************=
*******************************/</span><br><span> /**</span><br><span>@@ -9=
1,9 +88,6 @@</span><br><span>  *</span><br><span>  * @param top - Top-level=
 context structure.</span><br><span>  */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void tunnel_server_tcp(struct context *top);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
void multi_tcp_delete_event(struct multi_tcp *mtcp, event_t event);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/*void tunnel_server_tcp(st=
ruct context *top); */</span><br><span> </span><br><span> #endif /* ifndef =
MTCP_H */</span><br><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mud=
p.c</span><br><span>index 8945a55..d29f7a5 100644</span><br><span>--- a/src=
/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@=
 -379,7 +379,7 @@</span><br><span> void</span><br><span> multi_process_io_u=
dp(struct multi_context *m)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    unsigned int status =3D m-&gt;mtcp-&gt;udp_fla=
gs;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int=
 status =3D m-&gt;multi_io-&gt;udp_flags;</span><br><span>     const unsign=
ed int mpp_flags =3D m-&gt;top.c2.fast_io</span><br><span>                 =
                   ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLOSE_ON_SIGNAL)</sp=
an><br><span>                                    : (MPP_PRE_SELECT | MPP_CL=
OSE_ON_SIGNAL);</span><br><span>diff --git a/src/openvpn/multi.c b/src/open=
vpn/multi.c</span><br><span>index 108a5a8..b29134e 100644</span><br><span>-=
-- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><b=
r><span>@@ -440,7 +440,7 @@</span><br><span>     /*</span><br><span>      *=
 Initialize multi-socket TCP I/O wait object</span><br><span>      */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;mtcp =3D multi_tc=
p_init(t-&gt;options.max_clients, &amp;m-&gt;max_clients);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;multi_io =3D multi_protoco=
l_init(t-&gt;options.max_clients, &amp;m-&gt;max_clients);</span><br><span>=
 </span><br><span>     m-&gt;tcp_queue_limit =3D t-&gt;options.tcp_queue_li=
mit;</span><br><span> </span><br><span>@@ -668,7 +668,7 @@</span><br><span>=
 </span><br><span>         if (!is_dgram)</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_tcp_derefe=
rence_instance(m-&gt;mtcp, mi);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            multi_tcp_dereference_instance(m-&gt;multi_io, mi);=
</span><br><span>         }</span><br><span> </span><br><span>         mbuf=
_dereference_instance(m-&gt;mbuf, mi);</span><br><span>@@ -746,7 +746,7 @@<=
/span><br><span>         initial_rate_limit_free(m-&gt;initial_rate_limiter=
);</span><br><span>         multi_reap_free(m-&gt;reaper);</span><br><span>=
         mroute_helper_free(m-&gt;route_helper);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        multi_tcp_free(m-&gt;mtcp);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        multi_protocol_free(m-&g=
t;multi_io);</span><br><span>     }</span><br><span> }</span><br><span> </s=
pan><br><span>@@ -3997,9 +3997,9 @@</span><br><span> management_delete_even=
t(void *arg, event_t event)</span><br><span> {</span><br><span>     struct =
multi_context *m =3D (struct multi_context *) arg;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (m-&gt;mtcp)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (m-&gt;multi_io)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        multi_tcp_del=
ete_event(m-&gt;mtcp, event);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        multi_protocol_delete_event(m-&gt;multi_io, event);</span=
><br><span>     }</span><br><span> }</span><br><span> </span><br><span>@@ -=
4177,7 +4177,7 @@</span><br><span>     ASSERT(mi-&gt;context.c2.tls_multi-&=
gt;peer_id &lt; m-&gt;max_clients);</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Actual multi protocol event loop in se=
rver mode */</span><br><span> void</span><br><span> tunnel_server_loop(stru=
ct multi_context *multi)</span><br><span> {</span><br><span>@@ -4189,7 +418=
9,7 @@</span><br><span> </span><br><span>         /* wait on tun/socket lis=
t */</span><br><span>         multi_get_timeout(multi, &amp;multi-&gt;top.c=
2.timeval);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        st=
atus =3D multi_tcp_wait(&amp;multi-&gt;top, multi-&gt;mtcp);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        status =3D multi_protocol_=
io_wait(&amp;multi-&gt;top, multi-&gt;multi_io);</span><br><span>         M=
ULTI_CHECK_SIG(multi);</span><br><span> </span><br><span>         /* check =
on status of coarse timers */</span><br><span>@@ -4199,18 +4199,25 @@</span=
><br><span>         if (status &gt; 0)</span><br><span>         {</span><br=
><span>             /* process the I/O which triggered select */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            multi_tcp_process_io=
(multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 multi_protocol_process_io(multi);</span><br><span>             MULTI_CHECK=
_SIG(multi);</span><br><span>         }</span><br><span>         else if (s=
tatus =3D=3D 0)</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            multi_tcp_action(multi, NULL, TA_TIMEOUT, =
false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
multi_protocol_action(multi, NULL, TA_TIMEOUT, false);</span><br><span>    =
     }</span><br><span> </span><br><span>         perf_pop();</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/***********************************************=
***************************/</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Main=
 event loop for OpenVPN in server mode.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @ingroup eventloop</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param top - Top-level context structure.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span> void</span><br><span> tu=
nnel_server_init(struct context *top)</span><br><span> {</span><br><span>di=
ff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br><span>index =
472c2a3..dd7a29c 100644</span><br><span>--- a/src/openvpn/multi.h</span><br=
><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -37,6 +37,7 @@</span><b=
r><span> #include &quot;pool.h&quot;</span><br><span> #include &quot;mudp.h=
&quot;</span><br><span> #include &quot;mtcp.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi_io.h&quot;</span><br=
><span> #include &quot;perf.h&quot;</span><br><span> #include &quot;vlan.h&=
quot;</span><br><span> #include &quot;reflect_filter.h&quot;</span><br><spa=
n>@@ -169,8 +170,8 @@</span><br><span>     struct mbuf_set *mbuf;      /**&=
lt; Set of buffers for passing data</span><br><span>                       =
           *   channel packets between VPN tunnel</span><br><span>         =
                         *   instances. */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct multi_tcp *mtcp;     /**&lt; State specific=
 to OpenVPN using TCP</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                 *   as external transport. */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct multi_protocol *multi=
_io;     /**&lt; State specific to OpenVPN using both TCP</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                     =
     *   and UDP as external transport. */</span><br><span>     struct ifco=
nfig_pool *ifconfig_pool;</span><br><span>     struct frequency_limit *new_=
connection_limiter;</span><br><span>     struct initial_packet_rate_limit *=
initial_rate_limiter;</span><br><span>diff --git a/src/openvpn/multi_io.c b=
/src/openvpn/multi_io.c</span><br><span>new file mode 100644</span><br><spa=
n>index 0000000..a1ea7fb</span><br><span>--- /dev/null</span><br><span>+++ =
b/src/openvpn/multi_io.c</span><br><span>@@ -0,0 +1,687 @@</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP n=
etworks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   over a single TCP/UDP port, with support for SSL/TLS-based</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             session authentica=
tion and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *             packet encryption, packet authentication, and</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compressi=
on.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2023 OpenV=
PN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Th=
is program is free software; you can redistribute it and/or modify</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of th=
e GNU General Public License version 2</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  as published by the Free Software Foundation.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the ho=
pe that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of=
 the GNU General Public License along</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  with this program; if not, write to the Free Software=
 Foundation, Inc.,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;config.h&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;syshead.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;memdbg=
.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi.h&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;forwar=
d.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;multi_io.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_SYS_I=
NOTIFY_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;sys/inotify.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Special tags passed to event.[ch] functions</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define MULTI_IO_SOCKET      ((void *)=
1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MULTI_IO_=
TUN         ((void *)2)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define MULTI_IO_SIG         ((void *)3) /* Only on Windows */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define MULTI_IO_MANAGEMENT =
((void *)4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
MULTI_IO_FILE_CLOSE_WRITE ((void *)5)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define MULTI_IO_DCO        ((void *)6)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+struct ta_iow_flags</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    unsigned int flags;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    unsigned int ret;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    unsigned int tun;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    unsigned int sock;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_DEBUG</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static const char *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+pract(int action)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    switch (action)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        case TA_UNDEF:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            return &quot;TA_UNDEF&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        case TA_SOCKET_READ:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            return &quot;TA_SOCKET_READ&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        case TA_SOCKET_READ_RESIDUAL=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return=
 &quot;TA_SOCKET_READ_RESIDUAL&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       case TA_SOCKET_WRITE:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return &quot;TA_SOCKET_WRITE&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        case TA_SOCKET_WRITE_READY:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return &quot;TA_SOCKET_WRITE_=
READY&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        case TA_SOCKET_WRI=
TE_DEFERRED:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return &quot;TA_SOCKET_WRITE_DEFERRED&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        case TA_TUN_READ:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            return &quot;TA_TUN_READ&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        case TA_TUN_WRITE:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            return &quot;TA_TUN_WRITE&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        case TA_INITIAL:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            return &quot;TA_INITIAL=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        case TA_TIMEOUT:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            return &quot;T=
A_TIMEOUT&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        case TA_TUN_WR=
ITE_TIMEOUT:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return &quot;TA_TUN_WRITE_TIMEOUT&quot;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        default:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            return &quot;?&quot;;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ENAB=
LE_DEBUG */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+struct multi_protocol *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_protocol_init(int=
 maxevents, int *maxclients)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t multi_protocol *multi_io;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const int extra_events =3D BASE_N_EVENTS;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ASSERT(maxevents &gt;=3D 1);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ASSERT(maxclients);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ALLOC_OBJ_CLEAR(multi_io, struct multi_protocol);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_io-&gt;maxevents=
 =3D maxevents + extra_events;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    multi_io-&gt;es =3D event_set_init(&amp;multi_io-&gt;maxeven=
ts, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wait_sig=
nal(multi_io-&gt;es, MULTI_IO_SIG);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ALLOC_ARRAY(multi_io-&gt;esr, struct event_set_return, =
multi_io-&gt;maxevents);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    *maxclients =3D max_int(min_int(multi_io-&gt;maxevents - extra_eve=
nts, *maxclients), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    msg(D_MULTI_LOW, &quot;MULTI: TCP INIT maxclients=3D%d maxevents=3D%=
d&quot;, *maxclients, multi_io-&gt;maxevents);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return multi_io;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_protocol_free(stru=
ct multi_protocol *multi_io)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (m=
ulti_io)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        event_free(multi_=
io-&gt;es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
free(multi_io-&gt;esr);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        free(multi_io);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+multi_protocol_io_wait(struct context *c,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                       struct multi=
_protocol *multi_io)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int status, i=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int *=
persistent =3D &amp;multi_io-&gt;tun_rwflags;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        socket_set_listen_persistent(c-&gt;c2=
.link_sockets[i], multi_io-&gt;es,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                     &amp;c-&gt;c2.link_sock=
ets[i]-&gt;ev_arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (tuntap_is_wintun(c-&gt;c1.tunta=
p))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (!tuntap_ring_empty=
(c-&gt;c1.tuntap))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 /* there is data in wintun ring buffer, read it immediately */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            multi_io-&gt;esr[0]=
.arg =3D MULTI_IO_TUN;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            multi_io-&gt;esr[0].rwflags =3D EVENT_READ;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            multi_io-&gt;n_esr =3D 1=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return=
 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        persistent =3D NUL=
L;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    tun_set(c-&gt;c1.tuntap, multi_io-&gt;es=
, EVENT_READ, MULTI_IO_TUN, persistent);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_event_set(&am=
p;c-&gt;c1.tuntap-&gt;dco, multi_io-&gt;es, MULTI_IO_DCO);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (management)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      management_socket_set(management, multi_io-&gt;es, MULTI_IO_MANAGEMEN=
T, &amp;multi_io-&gt;management_persist_flags);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_ASYN=
C_PUSH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* arm in=
otify watcher */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 event_ctl(multi_io-&gt;es, c-&gt;c2.inotify_fd, EVENT_READ, MULTI_IO_FILE_=
CLOSE_WRITE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    status =3D event_wait(multi_io-&gt=
;es, &amp;c-&gt;c2.timeval, multi_io-&gt;esr, multi_io-&gt;maxevents);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    update_time();</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_io-&gt;n_esr =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (statu=
s &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi_io-&gt;n_e=
sr =3D status;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return status;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+multi_protocol_wait_lite(struct multi_context *m, struct multi_ins=
tance *mi, const int action, bool *tun_input_pending)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct context *c =3D multi_tcp_context(m, mi);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int looking_fo=
r =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_MULTI_DEBUG, &quot;=
MULTI PROTOCOL: multi_protocol_wait_lite a=3D%s mi=3D&quot; ptr_format,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+         pract(action),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         (ptr_type)=
mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    tv_clear(&amp;c-&gt;c2.timeval=
); /* ZERO-TIMEOUT */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (actio=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        case TA_TUN_READ:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            looking_for =
=3D TUN_READ;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      tun_input_pending =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            io_wait(c, IOW_READ_TUN);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        case TA_SOCKET_READ:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            looking_for =3D SOCKET_READ;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            tun_input_pending =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  io_wait(c, IOW_READ_LINK);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cas=
e TA_TUN_WRITE:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        looking_for =3D TUN_WRITE;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            tun_input_pending =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2.timeval.tv_sec =3D =
1; /* For some reason, the Linux 2.2 TUN/TAP driver hits this timeout */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            perf_push(=
PERF_PROC_OUT_TUN_MTCP);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            io_wait(c, IOW_TO_TUN);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            perf_pop();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        case TA_SOCKET_WRITE:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            looking_for =3D SOCKET_WRITE;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            io_wait(c, IOW_TO_LINK|IOW=
_READ_TUN_FORCE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        default:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, =
&quot;MULTI PROTOCOL: multi_protocol_wait_lite, unhandled action=3D%d&quot;=
, action);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (tun_input_pending &amp;&amp; (c-&=
gt;c2.event_set_status &amp; TUN_READ))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        *tun_input_pending =3D true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-=
&gt;c2.event_set_status &amp; looking_for)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return action;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        switch (action)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            /* MULTI PROTOCOL soc=
ket output buffer is full */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            case TA_SOCKET_WRITE:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                return TA_SOCKET_WRITE_DEFERRED;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* TUN device timed out on ac=
cepting write */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         case TA_TUN_WRITE:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                return TA_TUN_WRITE_TIMEOUT;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return TA_UNDEF;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static inline void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+multi_protocol_set_global_rw_flags(struct=
 multi_context *m, struct multi_instance *mi)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt=
;socket_set_called =3D true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        socket_set(mi-&gt;context.c2.link_sockets[0],</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                   m-&gt;multi_i=
o-&gt;es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
         mbuf_defined(mi-&gt;tcp_link_out_deferred) ? EVENT_WRITE : EVENT_R=
EAD,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
    &amp;mi-&gt;ev_arg,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                   &amp;mi-&gt;tcp_rwflags);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct multi_in=
stance *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_proto=
col_dispatch(struct multi_context *m, struct multi_instance *mi, const int =
action)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned int mpp_fla=
gs =3D MPP_PRE_SELECT|MPP_RECORD_TOUCH;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct multi_instance *touched =3D mi;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;mpp_touched =3D &amp;t=
ouched;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_MULTI_DEBUG, &quot;M=
ULTI PROTOCOL: multi_protocol_dispatch a=3D%s mi=3D&quot; ptr_format,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+         pract(action),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+         (ptr_type)mi=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    switch (action)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        case TA_TUN_READ:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            read_incoming_tun(&amp;m-&gt;top=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!=
IS_SIG(&amp;m-&gt;top))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              multi_process_incoming_tun(m, mpp_flags);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        case TA_SOCKET_READ:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        case TA_SOCKET_READ_RESIDUAL:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            ASSERT(mi);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(mi-&gt;context.=
c2.link_sockets);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          ASSERT(mi-&gt;context.c2.link_sockets[0]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            set_prefix(mi);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            read_incoming_link(&a=
mp;mi-&gt;context, mi-&gt;context.c2.link_sockets[0]);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            clear_prefix();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (!IS_SIG(&amp;mi-=
&gt;context))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    multi_process_incoming_link(m, mi, mpp_flags,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                            m=
i-&gt;context.c2.link_sockets[0]);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                if (!IS_SIG(&amp;mi-&gt;context))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    stream_buf_r=
ead_setup(mi-&gt;context.c2.link_sockets[0]);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      case TA_TIMEOUT:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            multi_process_timeout(m, mpp_flags);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        case TA_TUN_WRITE:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            multi_process_outgoing_tun(m, mpp_flags);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        case TA_TUN_WRITE_TIMEOUT:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi_proces=
s_drop_outgoing_tun(m, mpp_flags);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   case TA_SOCKET_WRITE_READY:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            ASSERT(mi);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            multi_tcp_process_outgoing_link_ready(m, mi, mpp=
_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        case TA_SOCKET_WRITE:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi_tcp=
_process_outgoing_link(m, false, mpp_flags);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        case TA_SOCKET_WRITE_DEFERRED:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            multi_tcp_process_outgoing_link(m, true=
, mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        case TA_INITIAL:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(mi=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi=
_protocol_set_global_rw_flags(m, mi);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            multi_process_post(m, mi, mpp_flags);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        default:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quot;MULTI PROTOCOL: mul=
ti_protocol_dispatch, unhandled action=3D%d&quot;, action);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    m-&gt;mpp_touched =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return touched;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+multi_protocol_post(struct =
multi_context *m, struct multi_instance *mi, const int action)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct context *c =3D multi_tcp_context(m, mi)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int newaction =
=3D TA_UNDEF;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MTP_NONE         =
0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MTP_TUN_OU=
T      (1&lt;&lt;0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define MTP_LINK_OUT     (1&lt;&lt;1)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    unsigned int flags =3D MTP_NONE;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (TUN_OUT(c))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        flags |=3D MTP_TUN_OUT;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (LINK_OUT(c))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        flags=
 |=3D MTP_LINK_OUT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    switch (flags)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        case MTP_TUN_OUT|MTP_LINK_OUT:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        case MTP_TUN_OUT:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            newaction =
=3D TA_TUN_WRITE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        case MTP_LINK_=
OUT:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            new=
action =3D TA_SOCKET_WRITE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case=
 MTP_NONE:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   if (mi &amp;&amp; sockets_read_residual(c))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                newaction =3D TA_SOCKET_READ_RESIDUAL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                multi_protocol_set=
_global_rw_flags(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        default:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(M_FATAL, &quot;MULTI PROTOCOL: multi_protocol_post bad state, mi=3D%=
s flags=3D%d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                multi_instance_string(mi, false, &amp;gc),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                flags);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    dmsg(D_MULTI_DEBUG, &quot;MULTI PROTOCOL: multi_protocol_post =
%s -&gt; %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        pract(action),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+         pract(newaction));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn newaction;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+multi_protocol_process_io(struct multi_context *m)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct multi_protocol *multi_io =3D m=
-&gt;multi_io;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst unsigned int udp_status =3D multi_io-&gt;udp_flags;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const unsigned int mpp_flags =3D m=
-&gt;top.c2.fast_io</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                   ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLOS=
E_ON_SIGNAL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                            : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int i;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (i =3D 0; i &lt; multi_io-&gt;n_esr; ++i)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct event_set_return *e =
=3D &amp;multi_io-&gt;esr[i];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct event_arg *ev_arg =3D (struct event_arg *)e-&gt;ar=
g;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* incoming data for instanc=
e or listening socket? */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (e-&gt;arg &gt;=3D MULTI_N)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            switch (ev_arg-&gt;type)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                struct multi_instance *mi;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                /* react to event on chil=
d instance */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          case EVENT_ARG_MULTI_INSTANCE:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    if (!ev_arg-&gt;u.mi)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                        msg(D_=
MULTI_ERRORS, &quot;MULTI PROTOCOL: multi_proto_proc_io: null minstance&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    m=
i =3D ev_arg-&gt;u.mi;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    if (e-&gt;rwflags &amp; EVENT_WRITE)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                        multi_pro=
tocol_action(m, mi, TA_SOCKET_WRITE_READY, false);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    else if (e-&gt;rwflag=
s &amp; EVENT_READ)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                        multi_protocol_action(m, mi, TA_SOCKET_READ, fals=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                /* new inc=
oming TCP client attempting to connect? */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                case EVENT_ARG_LINK_SOCKET:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    if (!ev_=
arg-&gt;u.ls)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                    msg(D_MULTI_ERRORS, &quot;MULTI PROTOCOL: multi_proto_p=
roc_io: null socket&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        break;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    if (!proto_is_dgram(ev_arg-&gt;u.ls-&gt;info.proto))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
      socket_reset_listen_persistent(ev_arg-&gt;u.ls);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        mi =3D multi_cre=
ate_instance_tcp(m, ev_arg-&gt;u.ls);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                        if (mi)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                            multi_proto=
col_action(m, mi, TA_INITIAL, false);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        break;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        if (e-&=
gt;arg &gt;=3D MULTI_N)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                            struct event_arg *ev_arg =3D (struct =
event_arg *)e-&gt;arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                            if (ev_arg-&gt;type !=3D EVENT_ARG_LINK_SOCK=
ET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                          multi_io-&gt;udp_flags =3D ES_ERROR;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
msg(D_LINK_ERRORS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                   &quot;MULTI PROTOCOL: io_work: non socke=
t event delivered&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                break;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
         ev_arg-&gt;pending =3D true;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                        if (udp_status &amp; SOCKET_READ)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
  read_incoming_link(&amp;m-&gt;top, ev_arg-&gt;u.ls);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                            if (!IS_SIG(=
&amp;m-&gt;top))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                         {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                multi_process_incoming_link(m, NULL,=
 mpp_flags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                                                    ev_arg-&gt;u.ls);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        whil=
e (true)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
             {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                       multi_get_timeout(m, &amp;m-&gt;top.c2.timeval);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
     get_io_flags_udp(&amp;m-&gt;top, m-&gt;multi_io, p2mp_iow_flags(m));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
       MULTI_CHECK_SIG(m);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                multi_process_per_second_timers(m);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                            if (m-&gt;multi_io-&gt;udp_flags=
 =3D=3D ES_TIMEOUT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                multi_process_timeout(m, MPP_PRE_=
SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                            else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
 multi_process_io_udp(m);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                MULTI_CHECK_SIG(m);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                break=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      break;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEME=
NT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (e=
-&gt;arg =3D=3D MULTI_IO_MANAGEMENT)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                ASSERT(management);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                management_io(management);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            /* incoming data on TUN? */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (e-&gt;arg =
=3D=3D MULTI_IO_TUN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           if (e-&gt;rwflags &amp; EVENT_WRITE)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    multi_protocol_action(m, NULL=
, TA_TUN_WRITE, false);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                else if (e-&gt;rwflags &amp; EVENT_READ)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    multi_protocol_act=
ion(m, NULL, TA_TUN_READ, false);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            /* new incoming TCP client attempting to connect? */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            else if (e-&=
gt;arg =3D=3D MULTI_IO_SOCKET)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                struct multi_instance *mi;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                ASSERT(m-&gt;top.c2.link_socket=
s[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   socket_reset_listen_persistent(m-&gt;top.c2.link_sockets[0]);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                mi =3D multi_c=
reate_instance_tcp(m, m-&gt;top.c2.link_sockets[0]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                if (mi)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    multi_protocol_acti=
on(m, mi, TA_INITIAL, false);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || defined(TARG=
ET_FREEBSD))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     /* incoming data on DCO? */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            else if (e-&gt;arg =3D=3D MULTI_IO_DCO)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                multi_process_incomi=
ng_dco(m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            /* signal receiv=
ed? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e=
lse if (e-&gt;arg =3D=3D MULTI_IO_SIG)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                get_signal(&amp;m-&gt;top.sig-&gt;signal_recei=
ved);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_ASYNC_=
PUSH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            els=
e if (e-&gt;arg =3D=3D MULTI_IO_FILE_CLOSE_WRITE)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                multi_process_file_closed(m, MPP_PR=
E_SELECT | MPP_RECORD_TOUCH);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (IS_SIG(=
&amp;m-&gt;top))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            b=
reak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    multi_io-&gt;n_esr =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * Process queued mbuf packets destined for TCP socket</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct multi_instance *mi;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        while (!IS_SIG(&amp;m-&g=
t;top) &amp;&amp; (mi =3D mbuf_peek(m-&gt;mbuf)) !=3D NULL)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            multi_protocol_action(m, mi, TA_S=
OCKET_WRITE, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
multi_protocol_action(struct multi_context *m, struct multi_instance *mi, i=
nt action, bool poll)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool tun_inp=
ut_pending =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    do</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        dmsg(D_MULTI_DEBUG, &quot;MULTI PROT=
OCOL: multi_protocol_action a=3D%s p=3D%d&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+             pract(action),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+             poll);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        /*</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         * If TA_SOCKET_READ_RESIDUAL, it means we still have pend=
ing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * input=
 packets which were read by a prior recv.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+         *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * Otherwise do a &quot;lite&quot; wait, which means w=
e wait with 0 timeout</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         * on I/O events only related to the current instance, not</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+         * the big list of=
 events.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * On our fi=
rst pass, poll will be false because we already know</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         * that input is available, and t=
o call io_wait would be redundant.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (poll &amp;&amp; action !=3D TA_SOCKET_READ_RESIDUAL)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            const int orig_action=
 =3D action;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     action =3D multi_protocol_wait_lite(m, mi, action, &amp;tun_input_pend=
ing);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if=
 (action =3D=3D TA_UNDEF)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                msg(M_FATAL, &quot;MULTI PROTOCOL: I/O wait required blocki=
ng in multi_protocol_action, action=3D%d&quot;, orig_action);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       * Dispatch the action</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        struct multi_instance *touched =3D multi_protocol_dispatch(m, mi, =
action);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /*</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * Signal received or connectio=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * reset b=
y peer?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (touched =
&amp;&amp; IS_SIG(&amp;touched-&gt;context))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (mi =3D=3D touched)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                mi =3D NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            multi_close_instance_on_signal(m, t=
ouched);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /*</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+         * If dispatch produced any pending output</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+         * for a particular instance,=
 point to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *=
 that instance.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
m-&gt;pending)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi =
=3D m-&gt;pending;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /*</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+         * Based on the effects of the =
action,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * s=
uch as generating pending output,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * possibly transition to a new action state.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        action =3D multi_protocol_p=
ost(m, mi, action);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+         * If we are finishe=
d processing the original action,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * check if we have any TUN input.  If so, transition=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * our acti=
on state to processing this input.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (tun_input_pending &amp;&amp; action =3D=3D TA_UNDEF)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            action =3D TA_TUN_REA=
D;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  tun_input_pending =3D false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            poll =3D false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    poll =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    } while (action !=3D TA_UN=
DEF);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+multi_protocol_delete_event(struct multi_protocol *multi_io, event=
_t event)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi_io &amp;&amp; =
multi_io-&gt;es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        event_del=
(multi_io-&gt;es, event);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span>diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h</spa=
n><br><span>new file mode 100644</span><br><span>index 0000000..bd27f08</sp=
an><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/multi_io.h</sp=
an><br><span>@@ -0,0 +1,77 @@</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Ope=
nVPN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             session authentication and key exchange,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encr=
yption, packet authentication, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet compression.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  Copyright (C) 2002-2023 OpenVPN Inc &lt;sales@...515...&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; =
you can redistribute it and/or modify</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  it under the terms of the GNU General Public License =
version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as pub=
lished by the Free Software Foundation.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  This program is distributed in the hope that it will be useful,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARR=
ANTY; without even the implied warranty of</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE.  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GN=
U General Public License for more details.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  You should have received a copy of the GNU General Public License=
 along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this=
 program; if not, write to the Free Software Foundation, Inc.,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Fl=
oor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Multi-protocol specific code for --mo=
de server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifndef MULTI_IO_H</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define MULTI_IO_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;event.h&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * I/O processing =
States</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define TA_UNDEF                 0</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define TA_SOCKET_READ           =
1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TA_SOCKET_=
READ_RESIDUAL  2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine TA_SOCKET_WRITE          3</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define TA_SOCKET_WRITE_READY    4</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define TA_SOCKET_WRITE_DEFERRED 5</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define TA_TUN_READ              =
6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TA_TUN_WRI=
TE             7</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine TA_INITIAL               8</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define TA_TIMEOUT               9</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define TA_TUN_WRITE_TIMEOUT     10</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Extra state info needed for Multi-protocol</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+struct multi_protocol</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct event_set *es;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct event_set_return *esr;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    int n_esr;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int maxevents;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    unsigned int tun_rwflags;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    unsigned int udp_flags;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    unsigned int management_persist_=
flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+struct multi_protocol *multi_protocol_init(int maxevents, in=
t *maxclients);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void multi_protocol_fre=
e(struct multi_protocol *multi_io);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int=
 multi_protocol_io_wait(struct context *c, struct multi_protocol *multi_io)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void multi_protocol_process_io(struct=
 multi_context *m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void multi_protocol=
_action(struct multi_context *m, struct multi_instance *mi, int action, boo=
l poll);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void multi_protocol_delete_eve=
nt(struct multi_protocol *multi_io, event_t event);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif /* ifndef MULTI_IO_H */</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/441?=
usp=3Demail">change 441</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/441?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id2d7957f5950115d9baade4c09f=
d9679b01f749b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 441 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--/+HJ+sN5qjY=--

