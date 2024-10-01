From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 1 Oct 2024 15:30:04 +0000
In-Reply-To: <gerrit.1727098847000.I1e5a84969988e4f027a18658d4ab268c13fbf929@...2715...>
References: <gerrit.1727098847000.I1e5a84969988e4f027a18658d4ab268c13fbf929@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8a13802398d92eb07ddd19c85d89573b114a6142-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6bC2QUqSWHQ="; charset=UTF-8
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

--6bC2QUqSWHQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/763?usp=3Demail

to look at the new patch set (#2).


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
M src/openvpn/forward.c
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
14 files changed, 767 insertions(+), 650 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/763/2

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5db207d..d5202da 100644
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
index ecb2bcf..4436dbc 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -92,6 +92,7 @@
 	mtu.c mtu.h \
 	mudp.c mudp.h \
 	multi.c multi.h \
+	multi_io.c multi_io.h \
 	networking_freebsd.c \
 	networking_iproute2.c networking_iproute2.h \
 	networking_sitnl.c networking_sitnl.h \
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 5e56be0..e7518e7 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1659,7 +1659,7 @@

 void
 process_ip_header(struct context *c, unsigned int flags, struct buffer *bu=
f,
-                  struct link_socket *ls)
+                  struct link_socket *sock)
 {
     if (!c->options.ce.mssfix)
     {
@@ -1693,7 +1693,7 @@
             /* extract TOS from IP header */
             if (flags & PIPV4_PASSTOS)
             {
-                link_socket_extract_tos(ls, &ipbuf);
+                link_socket_extract_tos(sock, &ipbuf);
             }
 #endif

diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 40e718b..c99b779 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -50,6 +50,7 @@
 #include "openvpn.h"
 #include "occ.h"
 #include "ping.h"
+#include "multi_io.h"

 #define IOW_TO_TUN          (1<<0)
 #define IOW_TO_LINK         (1<<1)
@@ -131,7 +132,7 @@
  *
  * @param c    The context structure which contains the external
  *             network socket from which to read incoming packets.
- * @param ls   The socket where the packet can be read from.
+ * @param sock The socket where the packet can be read from.
  */
 void read_incoming_link(struct context *c, struct link_socket *sock);

@@ -201,7 +202,7 @@
  *
  * @param c   The context structure of the VPN tunnel associated with the
  *            packet.
- * @param ls  The socket to be used to send the packet.
+ * @param sock The socket to be used to send the packet.
  */
 void process_outgoing_link(struct context *c, struct link_socket *sock);

@@ -308,7 +309,7 @@
=20

 void process_ip_header(struct context *c, unsigned int flags, struct buffe=
r *buf,
-                       struct link_socket *ls);
+                       struct link_socket *sock);

 bool schedule_exit(struct context *c);

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 575b4d2..4eb286a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4944,7 +4944,7 @@
 void
 inherit_context_child(struct context *dest,
                       const struct context *src,
-                      struct link_socket *ls)
+                      struct link_socket *sock)
 {
     CLEAR(*dest);

@@ -4983,7 +4983,7 @@
          * The CM_TOP context does the socket listen(),
          * and the CM_CHILD_TCP context does the accept().
          */
-        dest->c2.accept_from =3D ls;
+        dest->c2.accept_from =3D sock;
     }

 #ifdef ENABLE_PLUGIN
@@ -5017,13 +5017,13 @@
                        &dest->gc);

         /* inherit parent link_socket and tuntap */
-        dest->c2.link_sockets[0] =3D ls;
+        dest->c2.link_sockets[0] =3D sock;

         ALLOC_ARRAY_GC(dest->c2.link_socket_infos, struct link_socket_info=
 *, 1,
                        &dest->gc);
         ALLOC_OBJ_GC(dest->c2.link_socket_infos[0], struct link_socket_inf=
o,
                      &dest->gc);
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
index c8b5c78..1dae184 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -29,6 +29,8 @@

 #include "multi.h"
 #include "forward.h"
+#include "mtcp.h"
+#include "multi_io.h"

 #include "memdbg.h"

@@ -36,31 +38,6 @@
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
-#define MTCP_SOCKET      ((void *)1)
-#define MTCP_TUN         ((void *)2)
-#define MTCP_SIG         ((void *)3) /* Only on Windows */
-#define MTCP_MANAGEMENT ((void *)4)
-#define MTCP_FILE_CLOSE_WRITE ((void *)5)
-#define MTCP_DCO        ((void *)6)
-
 struct ta_iow_flags
 {
     unsigned int flags;
@@ -69,59 +46,14 @@
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
@@ -194,126 +126,42 @@
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
-    int status, i;
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
-
-    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, &mtcp->tun_rwfla=
gs);
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
@@ -326,7 +174,7 @@
     }
 }

-static bool
+bool
 multi_tcp_process_outgoing_link_ready(struct multi_context *m, struct mult=
i_instance *mi, const unsigned int mpp_flags)
 {
     struct mbuf_item item;
@@ -350,7 +198,7 @@
     return ret;
 }

-static bool
+bool
 multi_tcp_process_outgoing_link(struct multi_context *m, bool defer, const=
 unsigned int mpp_flags)
 {
     struct multi_instance *mi =3D multi_process_outgoing_link_pre(m);
@@ -394,429 +242,6 @@
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
 /*
  * Top level event loop for single-threaded operation.
  * TCP mode.
@@ -864,7 +289,7 @@

         /* wait on tun/socket list */
         multi_get_timeout(&multi, &multi.top.c2.timeval);
-        status =3D multi_tcp_wait(&multi.top, multi.mtcp);
+        status =3D multi_protocol_io_wait(&multi);
         MULTI_CHECK_SIG(&multi);

         /* check on status of coarse timers */
@@ -874,12 +299,12 @@
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
index 886d2cc..b9f73d4 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -30,34 +30,25 @@

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
 void multi_tcp_link_out_deferred(struct multi_context *m, struct multi_ins=
tance *mi);


@@ -71,6 +62,6 @@
 void tunnel_server_tcp(struct context *top);


-void multi_tcp_delete_event(struct multi_tcp *mtcp, event_t event);
+void multi_tcp_delete_event(struct multi_protocol *multi_io, event_t event=
);

 #endif /* ifndef MTCP_H */
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 37af88e..5092665 100644
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
index e7d742b..fc700de 100644
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
@@ -745,7 +745,7 @@
         initial_rate_limit_free(m->initial_rate_limiter);
         multi_reap_free(m->reaper);
         mroute_helper_free(m->route_helper);
-        multi_tcp_free(m->mtcp);
+        multi_protocol_free(m->multi_io);
     }
 }

@@ -754,7 +754,7 @@
  */
 struct multi_instance *
 multi_create_instance(struct multi_context *m, const struct mroute_addr *r=
eal,
-                      struct link_socket *ls)
+                      struct link_socket *sock)
 {
     struct gc_arena gc =3D gc_new();
     struct multi_instance *mi;
@@ -778,7 +778,7 @@
     }

     mi->did_open_context =3D true;
-    inherit_context_child(&mi->context, &m->top, ls);
+    inherit_context_child(&mi->context, &m->top, sock);
     if (IS_SIG(&mi->context))
     {
         goto err;
@@ -3130,7 +3130,7 @@

 void
 multi_process_float(struct multi_context *m, struct multi_instance *mi,
-                    struct link_socket *ls)
+                    struct link_socket *sock)
 {
     struct mroute_addr real =3D {0};
     struct hash *hash =3D m->hash;
@@ -3186,7 +3186,7 @@
     mi->context.c2.to_link_addr =3D &mi->context.c2.from;

     /* inherit parent link_socket and link_socket_info */
-    mi->context.c2.link_sockets[0] =3D ls;
+    mi->context.c2.link_sockets[0] =3D sock;
     mi->context.c2.link_socket_infos[0]->lsa->actual =3D m->top.c2.from;

     tls_update_remote_addr(mi->context.c2.tls_multi, &mi->context.c2.from);
@@ -3336,7 +3336,7 @@
  */
 bool
 multi_process_incoming_link(struct multi_context *m, struct multi_instance=
 *instance, const unsigned int mpp_flags,
-                            struct link_socket *ls)
+                            struct link_socket *sock)
 {
     struct gc_arena gc =3D gc_new();

@@ -3357,7 +3357,7 @@
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
@@ -3398,7 +3398,7 @@
                 /* nonzero length means that we have a valid, decrypted pa=
cked */
                 if (floated && c->c2.buf.len > 0)
                 {
-                    multi_process_float(m, m->pending, ls);
+                    multi_process_float(m, m->pending, sock);
                 }

                 process_incoming_link_part2(c, lsi, orig_buf);
@@ -3978,9 +3978,9 @@
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
index 572a7a4..930d6b9 100644
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
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--6bC2QUqSWHQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/763?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">multiproto: move generic event handling code in dedicated files<br><b=
r>    Introduced multi_io.h and multi_io.c files to centralize<br>    all c=
odes related to multiple protocols.<br><br>    Renamed the struct mtcp to s=
truct multi_protocol since it<br>    encompasses the event_set used by the =
parent context in server mode.<br><br>    Several methods have also been re=
named and moved to fit the<br>    multiproto structure:<br><br>    - multi_=
tcp_init() -&gt; multi_protocol_init();<br>    - multi_tcp_free() -&gt; mul=
ti_protocol_free();<br>    - multi_tcp_wait() -&gt; multi_protocol_io_wait(=
);<br>    and so forth.<br><br>Change-Id: I1e5a84969988e4f027a18658d4ab268c=
13fbf929<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt=
;<br>---<br>M CMakeLists.txt<br>M src/openvpn/Makefile.am<br>M src/openvpn/=
forward.c<br>M src/openvpn/forward.h<br>M src/openvpn/init.c<br>M src/openv=
pn/init.h<br>M src/openvpn/mtcp.c<br>M src/openvpn/mtcp.h<br>M src/openvpn/=
mudp.c<br>M src/openvpn/mudp.h<br>M src/openvpn/multi.c<br>M src/openvpn/mu=
lti.h<br>A src/openvpn/multi_io.c<br>A src/openvpn/multi_io.h<br>14 files c=
hanged, 767 insertions(+), 650 deletions(-)<br><br></pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
.openvpn.net:29418/openvpn refs/changes/63/763/2</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMake=
Lists.txt b/CMakeLists.txt</span><br><span>index 5db207d..d5202da 100644</s=
pan><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</sp=
an><br><span>@@ -458,6 +458,8 @@</span><br><span>     src/openvpn/mudp.h</s=
pan><br><span>     src/openvpn/multi.c</span><br><span>     src/openvpn/mul=
ti.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn=
/multi_io.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/=
openvpn/multi_io.c</span><br><span>     src/openvpn/ntlm.c</span><br><span>=
     src/openvpn/ntlm.h</span><br><span>     src/openvpn/occ.c</span><br><s=
pan>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am</span><b=
r><span>index ecb2bcf..4436dbc 100644</span><br><span>--- a/src/openvpn/Mak=
efile.am</span><br><span>+++ b/src/openvpn/Makefile.am</span><br><span>@@ -=
92,6 +92,7 @@</span><br><span> 	mtu.c mtu.h \</span><br><span> 	mudp.c mudp=
.h \</span><br><span> 	multi.c multi.h \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	multi_io.c multi_io.h \</span><br><span> 	networking_=
freebsd.c \</span><br><span> 	networking_iproute2.c networking_iproute2.h \=
</span><br><span> 	networking_sitnl.c networking_sitnl.h \</span><br><span>=
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>=
index 5e56be0..e7518e7 100644</span><br><span>--- a/src/openvpn/forward.c</=
span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -1659,7 +1659=
,7 @@</span><br><span> </span><br><span> void</span><br><span> process_ip_h=
eader(struct context *c, unsigned int flags, struct buffer *buf,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                  struct link_so=
cket *ls)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
        struct link_socket *sock)</span><br><span> {</span><br><span>     i=
f (!c-&gt;options.ce.mssfix)</span><br><span>     {</span><br><span>@@ -169=
3,7 +1693,7 @@</span><br><span>             /* extract TOS from IP header *=
/</span><br><span>             if (flags &amp; PIPV4_PASSTOS)</span><br><sp=
an>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            link_socket_extract_tos(ls, &amp;ipbuf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                link_socket_extract_tos(s=
ock, &amp;ipbuf);</span><br><span>             }</span><br><span> #endif</s=
pan><br><span> </span><br><span>diff --git a/src/openvpn/forward.h b/src/op=
envpn/forward.h</span><br><span>index 40e718b..c99b779 100644</span><br><sp=
an>--- a/src/openvpn/forward.h</span><br><span>+++ b/src/openvpn/forward.h<=
/span><br><span>@@ -50,6 +50,7 @@</span><br><span> #include &quot;openvpn.h=
&quot;</span><br><span> #include &quot;occ.h&quot;</span><br><span> #includ=
e &quot;ping.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;multi_io.h&quot;</span><br><span> </span><br><span> #define=
 IOW_TO_TUN          (1&lt;&lt;0)</span><br><span> #define IOW_TO_LINK     =
    (1&lt;&lt;1)</span><br><span>@@ -131,7 +132,7 @@</span><br><span>  *</s=
pan><br><span>  * @param c    The context structure which contains the exte=
rnal</span><br><span>  *             network socket from which to read inco=
ming packets.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @para=
m ls   The socket where the packet can be read from.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param sock The socket where the packe=
t can be read from.</span><br><span>  */</span><br><span> void read_incomin=
g_link(struct context *c, struct link_socket *sock);</span><br><span> </spa=
n><br><span>@@ -201,7 +202,7 @@</span><br><span>  *</span><br><span>  * @pa=
ram c   The context structure of the VPN tunnel associated with the</span><=
br><span>  *            packet.</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * @param ls  The socket to be used to send the packet.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param sock The socket to =
be used to send the packet.</span><br><span>  */</span><br><span> void proc=
ess_outgoing_link(struct context *c, struct link_socket *sock);</span><br><=
span> </span><br><span>@@ -308,7 +309,7 @@</span><br><span> </span><br><spa=
n> </span><br><span> void process_ip_header(struct context *c, unsigned int=
 flags, struct buffer *buf,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                       struct link_socket *ls);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                       struct link_socket=
 *sock);</span><br><span> </span><br><span> bool schedule_exit(struct conte=
xt *c);</span><br><span> </span><br><span>diff --git a/src/openvpn/init.c b=
/src/openvpn/init.c</span><br><span>index 575b4d2..4eb286a 100644</span><br=
><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</s=
pan><br><span>@@ -4944,7 +4944,7 @@</span><br><span> void</span><br><span> =
inherit_context_child(struct context *dest,</span><br><span>               =
        const struct context *src,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                      struct link_socket *ls)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                      struct link_so=
cket *sock)</span><br><span> {</span><br><span>     CLEAR(*dest);</span><br=
><span> </span><br><span>@@ -4983,7 +4983,7 @@</span><br><span>          * =
The CM_TOP context does the socket listen(),</span><br><span>          * an=
d the CM_CHILD_TCP context does the accept().</span><br><span>          */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dest-&gt;c2.ac=
cept_from =3D ls;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      dest-&gt;c2.accept_from =3D sock;</span><br><span>     }</span><br><s=
pan> </span><br><span> #ifdef ENABLE_PLUGIN</span><br><span>@@ -5017,13 +50=
17,13 @@</span><br><span>                        &amp;dest-&gt;gc);</span><=
br><span> </span><br><span>         /* inherit parent link_socket and tunta=
p */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dest-&gt;=
c2.link_sockets[0] =3D ls;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        dest-&gt;c2.link_sockets[0] =3D sock;</span><br><span> </spa=
n><br><span>         ALLOC_ARRAY_GC(dest-&gt;c2.link_socket_infos, struct l=
ink_socket_info *, 1,</span><br><span>                        &amp;dest-&gt=
;gc);</span><br><span>         ALLOC_OBJ_GC(dest-&gt;c2.link_socket_infos[0=
], struct link_socket_info,</span><br><span>                      &amp;dest=
-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *des=
t-&gt;c2.link_socket_infos[0] =3D ls-&gt;info;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        *dest-&gt;c2.link_socket_infos[0] =3D so=
ck-&gt;info;</span><br><span> </span><br><span>         /* locally override=
 some link_socket_info fields */</span><br><span>         dest-&gt;c2.link_=
socket_infos[0]-&gt;lsa =3D &amp;dest-&gt;c1.link_socket_addrs[0];</span><b=
r><span>diff --git a/src/openvpn/init.h b/src/openvpn/init.h</span><br><spa=
n>index 11c32ac..50b38e3 100644</span><br><span>--- a/src/openvpn/init.h</s=
pan><br><span>+++ b/src/openvpn/init.h</span><br><span>@@ -96,7 +96,7 @@</s=
pan><br><span> </span><br><span> void inherit_context_child(struct context =
*dest,</span><br><span>                            const struct context *sr=
c,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
        struct link_socket *ls);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                           struct link_socket *sock);</span><b=
r><span> </span><br><span> void inherit_context_top(struct context *dest,</=
span><br><span>                          const struct context *src);</span>=
<br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><s=
pan>index c8b5c78..1dae184 100644</span><br><span>--- a/src/openvpn/mtcp.c<=
/span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -29,6 +29,8 @@<=
/span><br><span> </span><br><span> #include &quot;multi.h&quot;</span><br><=
span> #include &quot;forward.h&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;mtcp.h&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;multi_io.h&quot;</span><br><span> <=
/span><br><span> #include &quot;memdbg.h&quot;</span><br><span> </span><br>=
<span>@@ -36,31 +38,6 @@</span><br><span> #include &lt;sys/inotify.h&gt;</s=
pan><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* TCP States</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TA_UNDEF           =
      0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TA_SOC=
KET_READ           1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define TA_SOCKET_READ_RESIDUAL  2</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define TA_SOCKET_WRITE          3</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define TA_SOCKET_WRITE_READY    4</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define TA_SOCKET_WRITE_DEFERRED 5</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TA_TUN_READ     =
         6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TA_=
TUN_WRITE             7</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define TA_INITIAL               8</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define TA_TIMEOUT               9</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define TA_TUN_WRITE_TIMEOUT     10</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * Special tags passed to event.[ch] functions</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define MTCP_SOCKET      ((void *)1)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define MTCP_TUN         ((void *)2)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#define MTCP_SIG         ((void *)3)=
 /* Only on Windows */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define MTCP_MANAGEMENT ((void *)4)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define MTCP_FILE_CLOSE_WRITE ((void *)5)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define MTCP_DCO        ((void *)6)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> struct t=
a_iow_flags</span><br><span> {</span><br><span>     unsigned int flags;</sp=
an><br><span>@@ -69,59 +46,14 @@</span><br><span>     unsigned int sock;</s=
pan><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-static const char *</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-pract(int action)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    switch (ac=
tion)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        case TA_UNDEF:</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            return &quot;TA_UND=
EF&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKET_READ:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            return &quot;T=
A_SOCKET_READ&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKET=
_READ_RESIDUAL:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      return &quot;TA_SOCKET_READ_RESIDUAL&quot;;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        case TA_SOCKET_WRITE:</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            return &quot;TA_SOCKET_WRITE&quot;;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        case TA_SOCKET_WRITE_READY:</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            return &quot;TA_SOCKET_WRITE_=
READY&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKET_WRITE_D=
EFERRED:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            r=
eturn &quot;TA_SOCKET_WRITE_DEFERRED&quot;;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        case TA_TUN_READ:</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            return &quot;TA_TUN_READ&quot;;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        case TA_TUN_WRITE:</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            return &quot;TA_TUN_WRITE&quot;;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        case TA_INITIAL:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            return &quot;TA_INITIAL&quot;;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        case TA_TIMEOUT:</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            return &quot;TA_TIMEOUT&quot;;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        case TA_TUN_WRITE_TIMEOUT:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            return &quot;TA_TUN_WRITE_TIMEO=
UT&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        default:</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            return &quot;?&quot;;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif /* ENABLE_DEBUG */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic struct multi_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-multi_create_instance_tcp(struct multi_context *m, struct link_socket =
*ls)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct multi_in=
stance *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_creat=
e_instance_tcp(struct multi_context *m, struct link_socket *sock)</span><br=
><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><=
span>     struct multi_instance *mi =3D NULL;</span><br><span>     struct h=
ash *hash =3D m-&gt;hash;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    mi =3D multi_create_instance(m, NULL, ls);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    mi =3D multi_create_in=
stance(m, NULL, sock);</span><br><span>     if (mi)</span><br><span>     {<=
/span><br><span>         struct hash_element *he;</span><br><span>@@ -194,1=
26 +126,42 @@</span><br><span>     mbuf_free(mi-&gt;tcp_link_out_deferred);=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-struct multi_tcp *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-multi_tcp_init(int maxevents, int *maxclients)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct multi_tcp *mtcp;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    const int extra_events =3D BASE_N_EVENTS;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    ASSERT(maxevents &gt;=3D 1);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(maxclients);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    ALLOC_OBJ_CLEAR(mtcp, struct multi_tcp);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    mtcp-&gt;maxevents =3D maxeve=
nts + extra_events;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  mtcp-&gt;es =3D event_set_init(&amp;mtcp-&gt;maxevents, 0);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    wait_signal(mtcp-&gt;es, MTCP_S=
IG);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_ARRAY(m=
tcp-&gt;esr, struct event_set_return, mtcp-&gt;maxevents);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    *maxclients =3D max_int(min_int(mt=
cp-&gt;maxevents - extra_events, *maxclients), 1);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    msg(D_MULTI_LOW, &quot;MULTI: TCP INIT max=
clients=3D%d maxevents=3D%d&quot;, *maxclients, mtcp-&gt;maxevents);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    return mtcp;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-multi_tcp_delete_event(struct multi_tcp *mtcp, event=
_t event)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_tcp_=
delete_event(struct multi_protocol *multi_io, event_t event)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mtcp &amp=
;&amp; mtcp-&gt;es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (multi_io &amp;&amp; multi_io-&gt;es)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        event_del(mtcp-&gt;es=
, event);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ev=
ent_del(multi_io-&gt;es, event);</span><br><span>     }</span><br><span> }<=
/span><br><span> </span><br><span> void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-multi_tcp_free(struct multi_tcp *mtcp)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+multi_tcp_dereference_instance(struct =
multi_protocol *multi_io, struct multi_instance *mi)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mtcp)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct link_socket *sock =
=3D mi-&gt;context.c2.link_sockets[0];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (sock &amp;&amp; mi-&gt;socket_set_called)</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   event_free(mtcp-&gt;es);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        free(mtcp-&gt;esr);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        free(mtcp);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-multi_tcp_dereference_instance(struct multi_tcp *mtcp, struct mu=
lti_instance *mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link_socket *=
ls =3D mi-&gt;context.c2.link_sockets[0];</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (ls &amp;&amp; mi-&gt;socket_set_called)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        event_del(mtcp-&gt;es, socket_event=
_handle(ls));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  event_del(multi_io-&gt;es, socket_event_handle(sock));</span><br><span>  =
       mi-&gt;socket_set_called =3D false;</span><br><span>     }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    mtcp-&gt;n_esr =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_io-&gt;n_esr =
=3D 0;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-static inline void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void</span><br><span> multi_tcp_set_global_rw_flags(st=
ruct multi_context *m, struct multi_instance *mi)</span><br><span> {</span>=
<br><span>     if (mi)</span><br><span>     {</span><br><span>         mi-&=
gt;socket_set_called =3D true;</span><br><span>         socket_set(mi-&gt;c=
ontext.c2.link_sockets[0],</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                   m-&gt;mtcp-&gt;es,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                   m-&gt;multi_io-&gt;es,</span><br>=
<span>                    mbuf_defined(mi-&gt;tcp_link_out_deferred) ? EVEN=
T_WRITE : EVENT_READ,</span><br><span>                    &amp;mi-&gt;ev_ar=
g,</span><br><span>                    &amp;mi-&gt;tcp_rwflags);</span><br>=
<span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-multi_tcp_wait(const struct context *c,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-               struct multi_tcp *=
mtcp)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    int status, i;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        socket_set_listen_persistent(c-&g=
t;c2.link_sockets[i], mtcp-&gt;es,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                     &amp;c-&gt;c2.link_socket=
s[i]-&gt;ev_arg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (tuntap_is_wintun(c-&gt;c1.tuntap))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (!tuntap_ring_empty(c-&gt;c1.tun=
tap))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            /* there is data=
 in wintun ring buffer, read it immediately */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            mtcp-&gt;esr[0].arg =3D MTCP_TUN;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            mtcp-&gt;esr[0=
].rwflags =3D EVENT_READ;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            mtcp-&gt;n_esr =3D 1;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            return 1;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        persistent =3D NULL;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    tun_set(c-&gt;c1.tuntap, mtcp-&gt;es,=
 EVENT_READ, MTCP_TUN, &amp;mtcp-&gt;tun_rwflags);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX) || defined(TARGET_FR=
EEBSD)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dco_event_s=
et(&amp;c-&gt;c1.tuntap-&gt;dco, mtcp-&gt;es, MTCP_DCO);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (management)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        manageme=
nt_socket_set(management, mtcp-&gt;es, MTCP_MANAGEMENT, &amp;mtcp-&gt;manag=
ement_persist_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    /* arm inotify watcher */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    event_ctl(mtcp-&gt;es, c-&gt;c2.inoti=
fy_fd, EVENT_READ, MTCP_FILE_CLOSE_WRITE);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D =
event_wait(mtcp-&gt;es, &amp;c-&gt;c2.timeval, mtcp-&gt;esr, mtcp-&gt;maxev=
ents);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    update_time=
();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mtcp-&gt;n_esr=
 =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (status=
 &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        mtcp-&gt;n_esr =3D st=
atus;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return status;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatic inline struct context *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+struct context *</span><br><span> multi_tcp_context(struct multi_=
context *m, struct multi_instance *mi)</span><br><span> {</span><br><span> =
    if (mi)</span><br><span>@@ -326,7 +174,7 @@</span><br><span>     }</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bool</span><br><span> multi_tcp_process_outgoing_link_ready(struct multi=
_context *m, struct multi_instance *mi, const unsigned int mpp_flags)</span=
><br><span> {</span><br><span>     struct mbuf_item item;</span><br><span>@=
@ -350,7 +198,7 @@</span><br><span>     return ret;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static b=
ool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><=
span> multi_tcp_process_outgoing_link(struct multi_context *m, bool defer, =
const unsigned int mpp_flags)</span><br><span> {</span><br><span>     struc=
t multi_instance *mi =3D multi_process_outgoing_link_pre(m);</span><br><spa=
n>@@ -394,429 +242,6 @@</span><br><span>     return ret;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_wait=
_lite(struct multi_context *m, struct multi_instance *mi, const int action,=
 bool *tun_input_pending)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct conte=
xt *c =3D multi_tcp_context(m, mi);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    unsigned int looking_for =3D 0;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    dmsg(D_MULTI_DEBUG, &quot;MULTI TCP: multi_tcp_wait_lite a=3D%s =
mi=3D&quot; ptr_format,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-         pract(action),</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-         (ptr_type)mi);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tv_clear(&a=
mp;c-&gt;c2.timeval); /* ZERO-TIMEOUT */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  switch (action)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_TUN_=
READ:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            look=
ing_for =3D TUN_READ;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            tun_input_pending =3D NULL;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            io_wait(c, IOW_READ_TUN);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        case TA_SOCKET_READ:</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            looking_for =3D SOCKET_READ;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            tun_input_pending =3D NULL=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            io_wait(=
c, IOW_READ_LINK);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_TUN_WRITE:<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            looking_fo=
r =3D TUN_WRITE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       tun_input_pending =3D NULL;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            c-&gt;c2.timeval.tv_sec =3D 1; /* For some reason,=
 the Linux 2.2 TUN/TAP driver hits this timeout */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            perf_push(PERF_PROC_OUT_TUN_MTCP);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            io_wait(c=
, IOW_TO_TUN);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     perf_pop();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKET_WRITE:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            looking_f=
or =3D SOCKET_WRITE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           io_wait(c, IOW_TO_LINK|IOW_READ_TUN_FORCE);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        default:</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            msg(M_FATAL, &quot;MULTI TCP: multi_tcp_wait_lite, unhand=
led action=3D%d&quot;, action);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tun_input_pending &=
amp;&amp; (c-&gt;c2.event_set_status &amp; TUN_READ))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        *tun_input_pending =3D true;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (c-&gt;c2.event_set_status &amp; looking_for)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        return action;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
lse</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        switch (action)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            /* TCP socket output buffer is =
full */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ca=
se TA_SOCKET_WRITE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              return TA_SOCKET_WRITE_DEFERRED;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            /* TUN device timed out on accepting write */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            case TA_TUN_WRITE:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                return TA_=
TUN_WRITE_TIMEOUT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        return TA_UNDEF;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static struct m=
ulti_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_=
tcp_dispatch(struct multi_context *m, struct multi_instance *mi, const int =
action)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    const unsigned int mpp_flags =
=3D MPP_PRE_SELECT|MPP_RECORD_TOUCH;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct multi_instance *touched =3D mi;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    m-&gt;mpp_touched =3D &amp;touched;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_MULTI_DEBUG, &quot;MULTI TCP: m=
ulti_tcp_dispatch a=3D%s mi=3D&quot; ptr_format,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-         pract(action),</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-         (ptr_type)mi);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    switch (action)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 case TA_TUN_READ:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         read_incoming_tun(&amp;m-&gt;top);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            if (!IS_SIG(&amp;m-&gt;top))</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                multi_process_incoming_tun=
(m, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            br=
eak;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKET_READ:</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKET_READ_RES=
IDUAL:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASS=
ERT(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            A=
SSERT(mi-&gt;context.c2.link_sockets);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            ASSERT(mi-&gt;context.c2.link_sockets[0]);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            set_prefix(mi=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            read_in=
coming_link(&amp;mi-&gt;context, mi-&gt;context.c2.link_sockets[0]);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            clear_prefix();<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!IS_SI=
G(&amp;mi-&gt;context))</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          multi_process_incoming_link(m, mi, mpp_flags,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                                         =
   mi-&gt;context.c2.link_sockets[0]);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                if (!IS_SIG(&amp;mi-&gt;context))</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    stream_buf_rea=
d_setup(mi-&gt;context.c2.link_sockets[0]);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            break;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case T=
A_TIMEOUT:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 multi_process_timeout(m, mpp_flags);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
case TA_TUN_WRITE:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         multi_process_outgoing_tun(m, mpp_flags);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        case TA_TUN_WRITE_TIMEOUT:</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            multi_process_drop_outgoing_tun(m, mpp_flags)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        case TA_SOCKET_WRITE_READY:</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(mi);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_tcp_proce=
ss_outgoing_link_ready(m, mi, mpp_flags);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            break;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    case TA_SOCKET_WRITE:</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            multi_tcp_process_outgoing_link(m, false, mpp_flags);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        case TA_SOCKET_WRITE_DEFERRED:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            multi_tcp_process_outg=
oing_link(m, true, mpp_flags);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            break;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case TA=
_INITIAL:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
ASSERT(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  multi_tcp_set_global_rw_flags(m, mi);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            multi_process_post(m, mi, mpp_flags);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        default:</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            msg(M_FATAL, &quot;MULTI TCP: multi_tcp_dispat=
ch, unhandled action=3D%d&quot;, action);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-&gt;mpp_tou=
ched =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
urn touched;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-multi_tcp_post(struct multi_context *m, struct multi_instance=
 *mi, const int action)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct context=
 *c =3D multi_tcp_context(m, mi);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    int newaction =3D TA_UNDEF;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define MTP_NONE         0</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define MTP_TUN_OUT      (1&lt;&lt;0)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define MTP_LINK_OUT     (1&lt;&lt;1)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    unsigned int flags =3D MTP_NONE;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (TUN_OUT(c))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        flags |=3D MTP_TUN_OUT;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (LINK_OUT(c))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 flags |=3D MTP_LINK_OUT;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    switch (flags)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        case MTP_TUN_OUT|MTP_LINK_OUT:</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        case MTP_TUN_OUT:</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            newaction =3D TA_TU=
N_WRITE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            b=
reak;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        case MTP_LINK_OUT:</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            newaction =3D TA_SOC=
KET_WRITE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        case MTP_NONE:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            if (mi &amp;&amp; sock=
ets_read_residual(c))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        newaction =3D TA_SOCKET_READ_RESIDUAL;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            else</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                multi_tcp_set_global_rw_flags(m, mi);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            s=
truct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            msg(M_FATAL, &quot;MULTI TCP: multi_tcp_post bad stat=
e, mi=3D%s flags=3D%d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                multi_instance_string(mi, false, &amp;gc),</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                flags);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            break;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    dmsg(D_MULTI_DEBUG, &quot;MULTI TCP: multi_tcp_post %s -&gt; %s&quot;=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         pract(actio=
n),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         pract(new=
action));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return newaction;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_tcp=
_action(struct multi_context *m, struct multi_instance *mi, int action, boo=
l poll)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    bool tun_input_pending =3D fal=
se;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    do</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        dmsg(D_MULTI_DEBUG, &quot;MULTI TCP: multi_tcp_action a=3D%s p=
=3D%d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
    pract(action),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
          poll);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-         * If TA_SOCKET_READ_RESIDUAL=
, it means we still have pending</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-         * input packets which were read by a prior TCP recv.</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-         *</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-         * Otherwise do a &quot;lit=
e&quot; wait, which means we wait with 0 timeout</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-         * on I/O events only related to the cur=
rent instance, not</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
      * the big list of events.</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-         *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
        * On our first pass, poll will be false because we already know</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-         * that input is =
available, and to call io_wait would be redundant.</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (poll &amp;&amp; action !=3D TA_SOCKET_READ_R=
ESIDUAL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            const int ori=
g_action =3D action;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           action =3D multi_tcp_wait_lite(m, mi, action, &amp;tun_input_pen=
ding);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if =
(action =3D=3D TA_UNDEF)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           msg(M_FATAL, &quot;MULTI TCP: I/O wait required blocking in mult=
i_tcp_action, action=3D%d&quot;, orig_action);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-         * Dispatch the act=
ion</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        struct multi_instanc=
e *touched =3D multi_tcp_dispatch(m, mi, action);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
     * Signal received or TCP connection</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-         * reset by peer?</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (touched &amp;&amp; IS_SIG(&amp;touched-&gt;context=
))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            if (mi =3D=3D touch=
ed)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                mi =3D NUL=
L;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_close_ins=
tance_on_signal(m, touched);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-         * If dispatch produced any pending output</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-         * for a particular i=
nstance, point to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
     * that instance.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (m-&gt;pending)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mi =
=3D m-&gt;pending;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-         * Based on the effects of the action,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * such as gen=
erating pending output,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-         * possibly transition to a new action state.</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        action =3D multi_tcp_post(m, mi, action);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-         * If we are finished processing the original =
action,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * che=
ck if we have any TUN input.  If so, transition</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-         * our action state to processing this in=
put.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (tun_input_pendi=
ng &amp;&amp; action =3D=3D TA_UNDEF)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            action =3D TA_TUN_READ;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            mi =3D NULL;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            tun_input_pending =3D false;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            poll =3D false;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            poll =3D true;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    } while (ac=
tion !=3D TA_UNDEF);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-multi_tcp_process_io(struct multi_context *m)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct multi_tcp *mtcp =3D m-&gt;mtcp;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    for (i =3D 0; i &lt; mtcp-&gt;n_esr; ++i)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        struct event_set_return *e =3D &amp;mtcp-&g=
t;esr[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        stru=
ct event_arg *ev_arg =3D (struct event_arg *)e-&gt;arg;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        /* incoming data for instance or listening socket? */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (e-&gt;arg =
&gt;=3D MULTI_N)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            switc=
h (ev_arg-&gt;type)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      struct multi_instance *mi;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      /* react to event on child instance */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                case EVENT_ARG_MULTI_INSTANCE:</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    if (!ev=
_arg-&gt;u.mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                 msg(D_MULTI_ERRORS, &quot;MULTI: mtcp_proc_io: null minsta=
nce&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    mi=
 =3D ev_arg-&gt;u.mi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    if (e-&gt;rwflags &amp; EVENT_WRITE)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                        multi_tcp_action=
(m, mi, TA_SOCKET_WRITE_READY, false);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    else if (e-&gt;rwflags &amp; EVENT_REA=
D)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
     multi_tcp_action(m, mi, TA_SOCKET_READ, false);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    break;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                /* new incoming TCP client attempting to co=
nnect? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    case EVENT_ARG_LINK_SOCKET:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    if (!ev_arg-&gt;u.sock)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        msg(D_MULTI_ERRORS,=
 &quot;MULTI: mtcp_proc_io: null socket&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                        break;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    socket_reset_listen_persistent(ev_arg-&gt=
;u.sock);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
        mi =3D multi_create_instance_tcp(m, ev_arg-&gt;u.sock);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    if (mi)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                        mul=
ti_tcp_action(m, mi, TA_INITIAL, false);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    break;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MAN=
AGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if=
 (e-&gt;arg =3D=3D MTCP_MANAGEMENT)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                ASSERT(management);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                management_io(management);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            /* incoming data on TUN? */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (e-&gt;arg =3D=3D MTCP_TUN)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                if (e-&gt;rwfl=
ags &amp; EVENT_WRITE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 multi_tcp_action(m, NULL, TA_TUN_WRITE, false);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                else if (e-&gt;rwfla=
gs &amp; EVENT_READ)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               multi_tcp_action(m, NULL, TA_TUN_READ, false);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            /* new incoming TCP client attempti=
ng to connect? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        else if (e-&gt;arg =3D=3D MTCP_SOCKET)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                struct multi_instance *mi;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                ASSERT(m-&gt;top.c2.l=
ink_sockets[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           socket_reset_listen_persistent(m-&gt;top.c2.link_sockets[0]);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                mi =3D m=
ulti_create_instance_tcp(m, m-&gt;top.c2.link_sockets[0]);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                if (mi)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    multi_tcp_action(m, =
mi, TA_INITIAL, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if define=
d(ENABLE_DCO) &amp;&amp; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* incomi=
ng data on DCO? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         else if (e-&gt;arg =3D=3D MTCP_DCO)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                multi_process_incoming_dco(m);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            /* signal received? */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            else if (e-&gt;arg =3D=3D MTCP_=
SIG)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                get_signa=
l(&amp;m-&gt;top.sig-&gt;signal_received);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            else if (e-&gt;arg =3D=3D MTCP_FILE_CLOSE_WRITE=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                multi_proces=
s_file_closed(m, MPP_PRE_SELECT | MPP_RECORD_TOUCH);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (IS_SIG(&amp;m-&gt;top))</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    mtcp-&gt;n_esr =3D 0;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-     * Process queued mbuf packets destined for TCP socket</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        struct multi_instance *mi;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        while (!IS_SIG(&amp;m-&gt;top) &amp=
;&amp; (mi =3D mbuf_peek(m-&gt;mbuf)) !=3D NULL)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            multi_tcp_action(m, mi, TA_SOCKET_WRITE, true);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> /*</span><br><span>  * Top level event loop for sing=
le-threaded operation.</span><br><span>  * TCP mode.</span><br><span>@@ -86=
4,7 +289,7 @@</span><br><span> </span><br><span>         /* wait on tun/soc=
ket list */</span><br><span>         multi_get_timeout(&amp;multi, &amp;mul=
ti.top.c2.timeval);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      status =3D multi_tcp_wait(&amp;multi.top, multi.mtcp);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        status =3D multi_protocol_=
io_wait(&amp;multi);</span><br><span>         MULTI_CHECK_SIG(&amp;multi);<=
/span><br><span> </span><br><span>         /* check on status of coarse tim=
ers */</span><br><span>@@ -874,12 +299,12 @@</span><br><span>         if (s=
tatus &gt; 0)</span><br><span>         {</span><br><span>             /* pr=
ocess the I/O which triggered select */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            multi_tcp_process_io(&amp;multi);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            multi_protocol_proc=
ess_io(&amp;multi);</span><br><span>             MULTI_CHECK_SIG(&amp;multi=
);</span><br><span>         }</span><br><span>         else if (status =3D=
=3D 0)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            multi_tcp_action(&amp;multi, NULL, TA_TIMEOUT, fals=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mult=
i_protocol_action(&amp;multi, NULL, TA_TIMEOUT, false);</span><br><span>   =
      }</span><br><span> </span><br><span>         perf_pop();</span><br><s=
pan>diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h</span><br><span>in=
dex 886d2cc..b9f73d4 100644</span><br><span>--- a/src/openvpn/mtcp.h</span>=
<br><span>+++ b/src/openvpn/mtcp.h</span><br><span>@@ -30,34 +30,25 @@</spa=
n><br><span> </span><br><span> #include &quot;event.h&quot;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * Extra state info needed for TCP mod=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-struct multi_tcp</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct event_set *es;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct event_set_return *esr;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    int n_esr;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int maxevents;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    unsigned int tun_rwflags;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    unsigned int management_persist_flags;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span> struct multi_instance;</span><br><span> s=
truct context;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-struct multi_tcp *multi_tcp_init(int maxevents, int *maxclients)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-void multi_tcp_free(struct multi_tcp *mtc=
p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void multi_tcp_dereference_instance(str=
uct multi_tcp *mtcp, struct multi_instance *mi);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void multi_tcp_dereference_instance(struct mul=
ti_protocol *multi_io, struct multi_instance *mi);</span><br><span> </span>=
<br><span> bool multi_tcp_instance_specific_init(struct multi_context *m, s=
truct multi_instance *mi);</span><br><span> </span><br><span> void multi_tc=
p_instance_specific_free(struct multi_instance *mi);</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+struct context *multi_tc=
p_context(struct multi_context *m, struct multi_instance *mi);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void multi_tcp_set_global_rw_flags(struct multi_con=
text *m, struct multi_instance *mi);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bo=
ol multi_tcp_process_outgoing_link(struct multi_context *m, bool defer, con=
st unsigned int mpp_flags);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool multi_=
tcp_process_outgoing_link_ready(struct multi_context *m, struct multi_insta=
nce *mi, const unsigned int mpp_flags);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+struct multi_instance *multi_create_instance_tcp(struct multi_context *m, =
struct link_socket *sock);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> void multi_tcp_link_out_deferred(struct multi_cont=
ext *m, struct multi_instance *mi);</span><br><span> </span><br><span> </sp=
an><br><span>@@ -71,6 +62,6 @@</span><br><span> void tunnel_server_tcp(stru=
ct context *top);</span><br><span> </span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void multi_tcp_delete_event(struct multi_tc=
p *mtcp, event_t event);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void multi_tcp_delete_event(struct multi_protocol *multi_io, event_t e=
vent);</span><br><span> </span><br><span> #endif /* ifndef MTCP_H */</span>=
<br><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><s=
pan>index 37af88e..5092665 100644</span><br><span>--- a/src/openvpn/mudp.c<=
/span><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -186,7 +186,7 @=
@</span><br><span> </span><br><span> struct multi_instance *</span><br><spa=
n> multi_get_create_instance_udp(struct multi_context *m, bool *floated,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
      struct link_socket *ls)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                              struct link_socket *sock)</span><br=
><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><=
span>     struct mroute_addr real =3D {0};</span><br><span>@@ -257,7 +257,7=
 @@</span><br><span>                      * connect-freq but not against co=
nnect-freq-initial */</span><br><span>                     reflect_filter_r=
ate_limit_decrease(m-&gt;initial_rate_limiter);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                    mi =3D mult=
i_create_instance(m, &amp;real, ls);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    mi =3D multi_create_instance(m, &amp;r=
eal, sock);</span><br><span>                     if (mi)</span><br><span>  =
                   {</span><br><span>                         hash_add_fast=
(hash, bucket, &amp;mi-&gt;real, hv, mi);</span><br><span>diff --git a/src/=
openvpn/mudp.h b/src/openvpn/mudp.h</span><br><span>index b378754..3107cc6 =
100644</span><br><span>--- a/src/openvpn/mudp.h</span><br><span>+++ b/src/o=
penvpn/mudp.h</span><br><span>@@ -56,13 +56,13 @@</span><br><span>  * succe=
ssful, returns the newly created instance.</span><br><span>  *</span><br><s=
pan>  * @param m           - The single multi_context structure.</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * @param ls          - Listenin=
g socket where this instance is connecting to</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param sock        - Listening socket where th=
is instance is connecting to</span><br><span>  *</span><br><span>  * @retur=
n A pointer to a multi_instance if one already existed for the</span><br><s=
pan>  *     packet&#39;s source address or if one was a newly created succe=
ssfully.</span><br><span>  *      NULL if one did not yet exist and a new o=
ne was not created.</span><br><span>  */</span><br><span> struct multi_inst=
ance *multi_get_create_instance_udp(struct multi_context *m, bool *floated,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
                                struct link_socket *ls);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                      =
               struct link_socket *sock);</span><br><span> </span><br><span=
> #endif /* ifndef MUDP_H */</span><br><span>diff --git a/src/openvpn/multi=
.c b/src/openvpn/multi.c</span><br><span>index e7d742b..fc700de 100644</spa=
n><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/mul=
ti.c</span><br><span>@@ -440,7 +440,7 @@</span><br><span>      */</span><br=
><span>     if (tcp_mode)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        m-&gt;mtcp =3D multi_tcp_init(t-&gt;opti=
ons.max_clients, &amp;m-&gt;max_clients);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        m-&gt;multi_io =3D multi_protocol_init(t-&gt;=
options.max_clients, &amp;m-&gt;max_clients);</span><br><span>     }</span>=
<br><span>     m-&gt;tcp_queue_limit =3D t-&gt;options.tcp_queue_limit;</sp=
an><br><span> </span><br><span>@@ -665,9 +665,9 @@</span><br><span>        =
     mi-&gt;did_iroutes =3D false;</span><br><span>         }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (m-&gt=
;mtcp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (m=
-&gt;multi_io)</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            multi_tcp_dereference_instance(m-&gt;mtcp, =
mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mul=
ti_tcp_dereference_instance(m-&gt;multi_io, mi);</span><br><span>         }=
</span><br><span> </span><br><span>         mbuf_dereference_instance(m-&gt=
;mbuf, mi);</span><br><span>@@ -745,7 +745,7 @@</span><br><span>         in=
itial_rate_limit_free(m-&gt;initial_rate_limiter);</span><br><span>        =
 multi_reap_free(m-&gt;reaper);</span><br><span>         mroute_helper_free=
(m-&gt;route_helper);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        multi_tcp_free(m-&gt;mtcp);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        multi_protocol_free(m-&gt;multi_io);</span><br><spa=
n>     }</span><br><span> }</span><br><span> </span><br><span>@@ -754,7 +75=
4,7 @@</span><br><span>  */</span><br><span> struct multi_instance *</span>=
<br><span> multi_create_instance(struct multi_context *m, const struct mrou=
te_addr *real,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
               struct link_socket *ls)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                      struct link_socket *sock)</span><b=
r><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br>=
<span>     struct multi_instance *mi;</span><br><span>@@ -778,7 +778,7 @@</=
span><br><span>     }</span><br><span> </span><br><span>     mi-&gt;did_ope=
n_context =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  inherit_context_child(&amp;mi-&gt;context, &amp;m-&gt;top, ls);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    inherit_context_child(&am=
p;mi-&gt;context, &amp;m-&gt;top, sock);</span><br><span>     if (IS_SIG(&a=
mp;mi-&gt;context))</span><br><span>     {</span><br><span>         goto er=
r;</span><br><span>@@ -3130,7 +3130,7 @@</span><br><span> </span><br><span>=
 void</span><br><span> multi_process_float(struct multi_context *m, struct =
multi_instance *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  struct link_socket *ls)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    struct link_socket *sock)</span><=
br><span> {</span><br><span>     struct mroute_addr real =3D {0};</span><br=
><span>     struct hash *hash =3D m-&gt;hash;</span><br><span>@@ -3186,7 +3=
186,7 @@</span><br><span>     mi-&gt;context.c2.to_link_addr =3D &amp;mi-&g=
t;context.c2.from;</span><br><span> </span><br><span>     /* inherit parent=
 link_socket and link_socket_info */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    mi-&gt;context.c2.link_sockets[0] =3D ls;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;context.c2.link_sockets=
[0] =3D sock;</span><br><span>     mi-&gt;context.c2.link_socket_infos[0]-&=
gt;lsa-&gt;actual =3D m-&gt;top.c2.from;</span><br><span> </span><br><span>=
     tls_update_remote_addr(mi-&gt;context.c2.tls_multi, &amp;mi-&gt;contex=
t.c2.from);</span><br><span>@@ -3336,7 +3336,7 @@</span><br><span>  */</spa=
n><br><span> bool</span><br><span> multi_process_incoming_link(struct multi=
_context *m, struct multi_instance *instance, const unsigned int mpp_flags,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
       struct link_socket *ls)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                            struct link_socket *sock)</span><br>=
<span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><s=
pan> </span><br><span>@@ -3357,7 +3357,7 @@</span><br><span> #ifdef MULTI_D=
EBUG_EVENT_LOOP</span><br><span>         printf(&quot;TCP/UDP -&gt; TUN [%d=
]\n&quot;, BLEN(&amp;m-&gt;top.c2.buf));</span><br><span> #endif</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        multi_set_pending(m, mul=
ti_get_create_instance_udp(m, &amp;floated, ls));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        multi_set_pending(m, multi_get_create=
_instance_udp(m, &amp;floated, sock));</span><br><span>     }</span><br><sp=
an>     else</span><br><span>     {</span><br><span>@@ -3398,7 +3398,7 @@</=
span><br><span>                 /* nonzero length means that we have a vali=
d, decrypted packed */</span><br><span>                 if (floated &amp;&a=
mp; c-&gt;c2.buf.len &gt; 0)</span><br><span>                 {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    multi_process=
_float(m, m-&gt;pending, ls);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    multi_process_float(m, m-&gt;pending, sock);<=
/span><br><span>                 }</span><br><span> </span><br><span>      =
           process_incoming_link_part2(c, lsi, orig_buf);</span><br><span>@=
@ -3978,9 +3978,9 @@</span><br><span> management_delete_event(void *arg, ev=
ent_t event)</span><br><span> {</span><br><span>     struct multi_context *=
m =3D (struct multi_context *) arg;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (m-&gt;mtcp)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (m-&gt;multi_io)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        multi_tcp_delete_event(m-&gt=
;mtcp, event);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   multi_tcp_delete_event(m-&gt;multi_io, event);</span><br><span>     }</s=
pan><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn=
/multi.h b/src/openvpn/multi.h</span><br><span>index 572a7a4..930d6b9 10064=
4</span><br><span>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/openv=
pn/multi.h</span><br><span>@@ -37,6 +37,7 @@</span><br><span> #include &quo=
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
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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


--6bC2QUqSWHQ=--

