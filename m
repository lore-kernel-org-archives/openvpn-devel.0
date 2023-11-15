From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 15 Nov 2023 13:45:18 +0000
References: <gerrit.1700055887000.I81ec69d12abc9a661875c93c7f1bd97e525df55f@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <cf863340b528c9e1903d181a54a2a96484427899-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vgZH2vw5n+4="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Using the same wait
 function for both TCP and UDP
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

--vgZH2vw5n+4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/440?usp=3Demail

to review the following change.


Change subject: Using the same wait function for both TCP and UDP
......................................................................

Using the same wait function for both TCP and UDP

FORWARD: added a new function to collect UDP flags.

MTCP: the mtcp structure has been modified to carry around those flags.
      The second wait function (in UDP case) has been removed.

MULTI: properly remove TCP instances by checking the multi_instance
       protocol instead of the global one.

TLS: set the tls_option xmit_hold bool value to true only in case of
     TCP child instance to avoid checking the global protocol
     value.

INIT: initialize the c->c2.event_set in the inherit_context_top()
      by default and not only in case of UDP since we could have
      multiple different sockets.

Change-Id: I81ec69d12abc9a661875c93c7f1bd97e525df55f
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/init.c
M src/openvpn/mtcp.c
M src/openvpn/mtcp.h
M src/openvpn/mudp.c
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/options.h
9 files changed, 177 insertions(+), 244 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/440/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 63a684b..ee18f8b 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2053,48 +2053,20 @@
  */

 void
-io_wait_dowork_udp(struct context *c, struct multi_tcp *mtcp, const unsign=
ed int flags)
+get_io_flags_dowork_udp(struct context *c, struct multi_tcp *mtcp, const u=
nsigned int flags)
 {
     unsigned int socket =3D 0;
     unsigned int tuntap =3D 0;
-    struct event_set_return esr[4];
-
-    /* These shifts all depend on EVENT_READ and EVENT_WRITE */
-    static uintptr_t socket_shift =3D 0;   /* depends on SOCKET_READ and S=
OCKET_WRITE */
-    static uintptr_t tun_shift =3D 2;      /* depends on TUN_READ and TUN_=
WRITE */
-    static uintptr_t err_shift =3D 4;      /* depends on ES_ERROR */
-#ifdef ENABLE_MANAGEMENT
-    static uintptr_t management_shift =3D 6; /* depends on MANAGEMENT_READ=
 and MANAGEMENT_WRITE */
-#endif
-#ifdef ENABLE_ASYNC_PUSH
-    static int file_shift =3D FILE_SHIFT;
-#endif
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
-    static int dco_shift =3D DCO_SHIFT;    /* Event from DCO linux kernel =
module */
-#endif
-    int i;
+    static uintptr_t err_shift =3D 4;

     /*
-     * Decide what kind of events we want to wait for.
-     */
-    /*c->c2.event_set =3D mtcp->es; */
-    /*event_reset(mtcp->es); */
-    /*event_reset(c->c2.event_set); */
-
-    /*
-     * On win32 we use the keyboard or an event object as a source
-     * of asynchronous signals.
+     * Calculate the flags based on the provided 'flags' argument.
      */
     if (flags & IOW_WAIT_SIGNAL)
     {
         wait_signal(mtcp->es, (void *)err_shift);
     }

-    /*
-     * If outgoing data (for TCP/UDP port) pending, wait for ready-to-send
-     * status from TCP/UDP port. Otherwise, wait for incoming data on
-     * TUN/TAP device.
-     */
     if (flags & IOW_TO_LINK)
     {
         if (flags & IOW_SHAPER)
@@ -2180,117 +2152,68 @@
     /*
      * Configure event wait based on socket, tuntap flags.
      */
-    for (i =3D 0; i < c->c1.link_sockets_num; i++)
+    for (int i =3D 0; i < c->c1.link_sockets_num; i++)
     {
-        socket_set(c->c2.link_sockets[i], mtcp->es, socket,
-                   &c->c2.link_sockets[i]->ev_arg, NULL);
-    }
-    tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)tun_shift, NULL=
);
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
-    if (socket & EVENT_READ && c->c2.did_open_tun)
-    {
-        dco_event_set(&c->c1.tuntap->dco, mtcp->es, (void *)&dco_shift);
-    }
-#endif
-
-#ifdef ENABLE_MANAGEMENT
-    if (management)
-    {
-        management_socket_set(management, mtcp->es, (void *)management_shi=
ft, NULL);
-    }
-#endif
-
-#ifdef ENABLE_ASYNC_PUSH
-    /* arm inotify watcher */
-    if (c->options.mode =3D=3D MODE_SERVER)
-    {
-        event_ctl(mtcp->es, c->c2.inotify_fd, EVENT_READ, (void *)&file_sh=
ift);
-    }
-#endif
-
-    /*
-     * Possible scenarios:
-     *  (1) tcp/udp port has data available to read
-     *  (2) tcp/udp port is ready to accept more data to write
-     *  (3) tun dev has data available to read
-     *  (4) tun dev is ready to accept more data to write
-     *  (5) we received a signal (handler sets signal_received)
-     *  (6) timeout (tv) expired
-     */
-
-    mtcp->event_set_status =3D ES_ERROR;
-
-    if (!c->sig->signal_received)
-    {
-        if (!(flags & IOW_CHECK_RESIDUAL) || !sockets_read_residual(c))
+        if (proto_is_dgram(c->c2.link_sockets[i]->info.proto))
         {
-            int status;
-
-#ifdef ENABLE_DEBUG
-            if (check_debug_level(D_EVENT_WAIT))
-            {
-                show_wait_status(c);
-            }
-#endif
-
-            /*
-             * Wait for something to happen.
-             */
-            status =3D event_wait(mtcp->es, &c->c2.timeval, esr, SIZE(esr)=
);
-
-            check_status(status, "event_wait", NULL, NULL);
-
-            if (status > 0)
-            {
-                /*printf("\nstatus: %d\n", status); */
-                int i;
-                mtcp->event_set_status =3D 0;
-                for (i =3D 0; i < status; ++i)
-                {
-                    const struct event_set_return *e =3D &esr[i];
-                    uintptr_t shift;
-
-                    if (e->arg >=3D MULTI_N)
-                    {
-                        struct event_arg *ev_arg =3D (struct event_arg *)e=
->arg;
-                        if (ev_arg->type !=3D EVENT_ARG_LINK_SOCKET)
-                        {
-                            mtcp->event_set_status =3D ES_ERROR;
-                            msg(D_LINK_ERRORS,
-                                "io_work: non socket event delivered");
-                            return;
-                        }
-
-                        shift =3D socket_shift;
-                        /* mark socket so that the multi code knows where =
we
-                         * have pending i/o */
-                        ev_arg->pending =3D true;
-                    }
-                    else
-                    {
-                        shift =3D (uintptr_t)e->arg;
-                    }
-
-                    mtcp->event_set_status |=3D ((e->rwflags & 3) << shift=
);
-                }
-            }
-            else if (status =3D=3D 0)
-            {
-                mtcp->event_set_status =3D ES_TIMEOUT;
-            }
+            socket_set(c->c2.link_sockets[i], mtcp->es, socket,
+                       &c->c2.link_sockets[i]->ev_arg, NULL);
         }
     }
+    mtcp->udp_flags =3D socket | tuntap;
+}

-    /* 'now' should always be a reasonably up-to-date timestamp */
-    update_time();
-
-    /* set signal_received if a signal was received */
-    if (mtcp->event_set_status & ES_ERROR)
+void
+get_io_flags_udp(struct context *c, struct multi_tcp *mtcp, const unsigned=
 int flags)
+{
+    mtcp->udp_flags =3D ES_ERROR;
+    if (c->c2.fast_io && (flags & (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))
     {
-        get_signal(&c->sig->signal_received);
+        /* fast path -- only for TUN/TAP/UDP writes */
+        unsigned int ret =3D 0;
+        if (flags & IOW_TO_TUN)
+        {
+            ret |=3D TUN_WRITE;
+        }
+        if (flags & (IOW_TO_LINK | IOW_MBUF))
+        {
+            ret |=3D SOCKET_WRITE;
+        }
+        mtcp->udp_flags =3D ret;
     }
-
-    dmsg(D_EVENT_WAIT, "I/O WAIT status=3D0x%04x", mtcp->event_set_status);
+    else
+    {
+#ifdef _WIN32
+        bool skip_iowait =3D flags & IOW_TO_TUN;
+        if (flags & IOW_READ_TUN)
+        {
+            /*
+             * don't read from tun if we have pending write to link,
+             * since every tun read overwrites to_link buffer filled
+             * by previous tun read
+             */
+            skip_iowait =3D !(flags & IOW_TO_LINK);
+        }
+        if (tuntap_is_wintun(c->c1.tuntap) && skip_iowait)
+        {
+            unsigned int ret =3D 0;
+            if (flags & IOW_TO_TUN)
+            {
+                ret |=3D TUN_WRITE;
+            }
+            if (flags & IOW_READ_TUN)
+            {
+                ret |=3D TUN_READ;
+            }
+            mtcp->udp_flags =3D ret;
+        }
+        else
+#endif /* ifdef _WIN32 */
+        {
+            /* slow path - delegate to io_wait_dowork_udp to calculate fla=
gs */
+            get_io_flags_dowork_udp(c, mtcp, flags);
+        }
+    }
 }

 void
@@ -2308,10 +2231,10 @@
     static uintptr_t management_shift =3D 6; /* depends on MANAGEMENT_READ=
 and MANAGEMENT_WRITE */
 #endif
 #ifdef ENABLE_ASYNC_PUSH
-    static int file_shift =3D FILE_SHIFT;
+    static uintptr_t file_shift =3D FILE_SHIFT;
 #endif
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
-    static int dco_shift =3D DCO_SHIFT;    /* Event from DCO linux kernel =
module */
+    static uintptr_t dco_shift =3D DCO_SHIFT;    /* Event from DCO linux k=
ernel module */
 #endif
     int i;

@@ -2428,7 +2351,7 @@
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (socket & EVENT_READ && c->c2.did_open_tun)
     {
-        dco_event_set(&c->c1.tuntap->dco, c->c2.event_set, (void *)&dco_sh=
ift);
+        dco_event_set(&c->c1.tuntap->dco, c->c2.event_set, (void *)dco_shi=
ft);
     }
 #endif

@@ -2443,7 +2366,7 @@
     /* arm inotify watcher */
     if (c->options.mode =3D=3D MODE_SERVER)
     {
-        event_ctl(c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void *)&=
file_shift);
+        event_ctl(c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void *)f=
ile_shift);
     }
 #endif

diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index cb184a8..39ac975 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -69,7 +69,9 @@

 extern counter_type link_write_bytes_global;

-void io_wait_dowork_udp(struct context *c, struct multi_tcp *mtcp, const u=
nsigned int flags);
+void get_io_flags_dowork_udp(struct context *c, struct multi_tcp *mtcp, co=
nst unsigned int flags);
+
+void get_io_flags_udp(struct context *c, struct multi_tcp *mtcp, const uns=
igned int flags);

 void io_wait_dowork(struct context *c, const unsigned int flags);

@@ -366,58 +368,6 @@
     return flags;
 }

-static inline void
-io_wait_udp(struct context *c, struct multi_tcp *mtcp, const unsigned int =
flags)
-{
-    if (c->c2.fast_io && (flags & (IOW_TO_TUN|IOW_TO_LINK|IOW_MBUF)))
-    {
-        /* fast path -- only for TUN/TAP/UDP writes */
-        unsigned int ret =3D 0;
-        if (flags & IOW_TO_TUN)
-        {
-            ret |=3D TUN_WRITE;
-        }
-        if (flags & (IOW_TO_LINK|IOW_MBUF))
-        {
-            ret |=3D SOCKET_WRITE;
-        }
-        mtcp->event_set_status =3D ret;
-    }
-    else
-    {
-#ifdef _WIN32
-        bool skip_iowait =3D flags & IOW_TO_TUN;
-        if (flags & IOW_READ_TUN)
-        {
-            /*
-             * don't read from tun if we have pending write to link,
-             * since every tun read overwrites to_link buffer filled
-             * by previous tun read
-             */
-            skip_iowait =3D !(flags & IOW_TO_LINK);
-        }
-        if (tuntap_is_wintun(c->c1.tuntap) && skip_iowait)
-        {
-            unsigned int ret =3D 0;
-            if (flags & IOW_TO_TUN)
-            {
-                ret |=3D TUN_WRITE;
-            }
-            if (flags & IOW_READ_TUN)
-            {
-                ret |=3D TUN_READ;
-            }
-            mtcp->event_set_status =3D ret;
-        }
-        else
-#endif /* ifdef _WIN32 */
-        {
-            /* slow path */
-            io_wait_dowork_udp(c, mtcp, flags);
-        }
-    }
-}
-
 /*
  * This is the core I/O wait function, used for all I/O waits except
  * for TCP in server mode.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 762793a..2b88551 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -230,7 +230,7 @@
         if (streq(p[1], "HTTP"))
         {
             struct http_proxy_options *ho;
-            if (ce->proto !=3D PROTO_TCP && ce->proto !=3D PROTO_TCP_CLIEN=
T)
+            if (ce->proto !=3D PROTO_TCP && c->mode !=3D CM_CHILD_TCP)
             {
                 msg(M_WARN, "HTTP proxy support only works for TCP based c=
onnections");
                 return false;
@@ -607,7 +607,10 @@
             ce_defined =3D false;
         }

+        int proto =3D c->options.ce.proto;
         c->options.ce =3D *ce;
+        c->options.ce.proto =3D proto;
+
 #ifdef ENABLE_MANAGEMENT
         if (ce_defined && management && management_query_remote_enabled(ma=
nagement))
         {
@@ -2628,7 +2631,7 @@
=20
     if (found & OPT_P_EXPLICIT_NOTIFY)
     {
-        if (!proto_is_udp(c->options.ce.proto) && c->options.ce.explicit_e=
xit_notification)
+        if (!proto_is_udp(c->c2.link_sockets[0]->info.proto) && c->options=
.ce.explicit_exit_notification)
         {
             msg(D_PUSH, "OPTIONS IMPORT: --explicit-exit-notify can only b=
e used with --proto udp");
             c->options.ce.explicit_exit_notification =3D 0;
@@ -2788,14 +2791,21 @@
     int sec =3D 2;
     int backoff =3D 0;

-    switch (c->options.ce.proto)
+    switch (c->mode)
     {
-        case PROTO_TCP_SERVER:
-            sec =3D 1;
+        case CM_TOP:
+            if (has_udp_in_local_list(&c->options))
+            {
+                sec =3D c->options.ce.connect_retry_seconds;
+            }
+            else
+            {
+                sec =3D 1;
+            }
             break;

-        case PROTO_UDP:
-        case PROTO_TCP_CLIENT:
+        case CM_CHILD_UDP:
+        case CM_CHILD_TCP:
             sec =3D c->options.ce.connect_retry_seconds;
             break;
     }
@@ -2813,7 +2823,7 @@
     }

     /* Slow down reconnection after 5 retries per remote -- for TCP client=
 or UDP tls-client only */
-    if (c->options.ce.proto =3D=3D PROTO_TCP_CLIENT
+    if (c->mode =3D=3D CM_CHILD_TCP
         || (c->options.ce.proto =3D=3D PROTO_UDP && c->options.tls_client))
     {
         backoff =3D (c->options.unsuccessful_attempts / c->options.connect=
ion_list->len) - 4;
@@ -3293,7 +3303,21 @@
     to.server =3D options->tls_server;
     to.replay_window =3D options->replay_window;
     to.replay_time =3D options->replay_time;
-    to.tcp_mode =3D link_socket_proto_connection_oriented(options->ce.prot=
o);
+
+    if (c->options.ce.local_list->len > 1)
+    {
+        for (int i =3D 0; i < c->options.ce.local_list->len; i++)
+        {
+            if (proto_is_dgram(c->options.ce.local_list->array[i]->proto))
+            {
+                to.tcp_mode =3D false;
+            }
+        }
+    }
+    else
+    {
+        to.tcp_mode =3D link_socket_proto_connection_oriented(c->options.c=
e.local_list->array[0]->proto);
+    }
     to.config_ciphername =3D c->options.ciphername;
     to.config_ncp_ciphers =3D c->options.ncp_ciphers;
     to.transition_window =3D options->transition_window;
@@ -3338,7 +3362,7 @@

     /* should we not xmit any packets until we get an initial
      * response from client? */
-    if (to.server && options->ce.proto =3D=3D PROTO_TCP_SERVER)
+    if (to.server && c->mode =3D=3D CM_CHILD_TCP)
     {
         to.xmit_hold =3D true;
     }
@@ -4257,20 +4281,13 @@
 #ifdef _WIN32
         msg(M_INFO, "NOTE: --fast-io is disabled since we are running on W=
indows");
 #else
-        if (!proto_is_udp(c->options.ce.proto))
+        if (c->options.shaper)
         {
-            msg(M_INFO, "NOTE: --fast-io is disabled since we are not usin=
g UDP");
+            msg(M_INFO, "NOTE: --fast-io is disabled since we are using --=
shaper");
         }
         else
         {
-            if (c->options.shaper)
-            {
-                msg(M_INFO, "NOTE: --fast-io is disabled since we are usin=
g --shaper");
-            }
-            else
-            {
-                c->c2.fast_io =3D true;
-            }
+            c->c2.fast_io =3D true;
         }
 #endif
     }
@@ -4967,6 +4984,7 @@

     /* options */
     dest->options =3D src->options;
+    dest->options.ce.proto =3D ls->info.proto;
     options_detach(&dest->options);

     dest->c2.event_set =3D src->c2.event_set;
@@ -5065,10 +5083,7 @@
     dest->c2.es_owned =3D false;

     dest->c2.event_set =3D NULL;
-    if (proto_is_dgram(src->options.ce.proto))
-    {
-        do_event_set_init(dest, false);
-    }
+    do_event_set_init(dest, false);

 #ifdef USE_COMP
     dest->c2.comp_context =3D NULL;
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index ba0905e..128a375 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -680,11 +680,11 @@
 void
 multi_tcp_process_io(struct multi_context *m)
 {
+    struct multi_tcp *mtcp =3D m->mtcp;
+    const unsigned int udp_status =3D mtcp->udp_flags;
     const unsigned int mpp_flags =3D m->top.c2.fast_io
                                    ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLO=
SE_ON_SIGNAL)
                                    : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL=
);
-    struct multi_tcp *mtcp =3D m->mtcp;
-    const unsigned int status =3D mtcp->event_set_status;
     int i;

     for (i =3D 0; i < mtcp->n_esr; ++i)
@@ -725,9 +725,10 @@
                         msg(D_MULTI_ERRORS, "MULTI: mtcp_proc_io: null soc=
ket");
                         break;
                     }
-                    socket_reset_listen_persistent(ev_arg->u.ls);
+
                     if (!proto_is_dgram(ev_arg->u.ls->info.proto))
                     {
+                        socket_reset_listen_persistent(ev_arg->u.ls);
                         mi =3D multi_create_instance_tcp(m, ev_arg->u.ls);
                         if (mi)
                         {
@@ -737,7 +738,23 @@
                     }
                     else
                     {
-                        if (status & SOCKET_READ)
+                        if (e->arg >=3D MULTI_N)
+                        {
+                            struct event_arg *ev_arg =3D (struct event_arg=
 *)e->arg;
+                            if (ev_arg->type !=3D EVENT_ARG_LINK_SOCKET)
+                            {
+                                mtcp->udp_flags =3D ES_ERROR;
+                                msg(D_LINK_ERRORS,
+                                    "io_work: non socket event delivered");
+                                break;
+                            }
+                        }
+                        else
+                        {
+                            ev_arg->pending =3D true;
+                        }
+
+                        if (udp_status & SOCKET_READ)
                         {
                             read_incoming_link(&m->top, ev_arg->u.ls);
                             if (!IS_SIG(&m->top))
@@ -750,12 +767,12 @@
                         while (true)
                         {
                             multi_get_timeout(m, &m->top.c2.timeval);
-                            io_wait_udp(&m->top, m->mtcp, p2mp_iow_flags(m=
));
+                            get_io_flags_udp(&m->top, m->mtcp, p2mp_iow_fl=
ags(m));
                             MULTI_CHECK_SIG(m);

                             multi_process_per_second_timers(m);

-                            if (m->mtcp->event_set_status =3D=3D ES_TIMEOU=
T)
+                            if (m->mtcp->udp_flags =3D=3D ES_TIMEOUT)
                             {
                                 multi_process_timeout(m, MPP_PRE_SELECT | =
MPP_CLOSE_ON_SIGNAL);
                             }
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index b2fdb6e..d55bdfd 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -55,7 +55,7 @@
     int n_esr;
     int maxevents;
     unsigned int tun_rwflags;
-    unsigned int event_set_status;
+    unsigned int udp_flags;
 #ifdef ENABLE_MANAGEMENT
     unsigned int management_persist_flags;
 #endif
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 4979751..8945a55 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -198,7 +198,6 @@
     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true)
         && m->top.c2.buf.len > 0)
     {
-        /*real.proto =3D ls->info.proto; */
         struct hash_element *he;
         const uint32_t hv =3D hash_value(hash, &real);
         struct hash_bucket *bucket =3D hash_bucket(hash, hv);
@@ -380,9 +379,7 @@
 void
 multi_process_io_udp(struct multi_context *m)
 {
-    const unsigned int status =3D m->mtcp->event_set_status;
-    /*p2mp_iow_flags(m); */
-    /*m->top.c2.event_set_status; */
+    unsigned int status =3D m->mtcp->udp_flags;
     const unsigned int mpp_flags =3D m->top.c2.fast_io
                                    ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLO=
SE_ON_SIGNAL)
                                    : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL=
);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 5098581..108a5a8 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -607,6 +607,7 @@

     ASSERT(!mi->halt);
     mi->halt =3D true;
+    bool is_dgram =3D proto_is_dgram(mi->context.c2.link_sockets[0]->info.=
proto);

     dmsg(D_MULTI_DEBUG, "MULTI: multi_close_instance called");

@@ -665,7 +666,7 @@
             mi->did_iroutes =3D false;
         }

-        if (m->mtcp && !proto_is_dgram(m->top.options.ce.proto))
+        if (!is_dgram)
         {
             multi_tcp_dereference_instance(m->mtcp, mi);
         }
@@ -3406,6 +3407,7 @@

             perf_push(PERF_PROC_IN_LINK);
             lsi =3D get_link_socket_info(c);
+            /*lsi =3D &ls->info; */
             orig_buf =3D c->c2.buf.data;
             if (process_incoming_link_part1(c, lsi, floated))
             {
@@ -3856,7 +3858,7 @@
     while ((he =3D hash_iterator_next(&hi)))
     {
         struct multi_instance *mi =3D (struct multi_instance *) he->value;
-        if (!mi->halt)
+        if (!mi->halt && proto_is_dgram(mi->context.options.ce.proto))
         {
             send_control_channel_string(&mi->context, next_server ? "RESTA=
RT,[N]" : "RESTART", D_PUSH);
             multi_schedule_context_wakeup(m, mi);
@@ -3894,13 +3896,15 @@
         status_close(so);
         return false;
     }
-    else if (proto_is_dgram(m->top.options.ce.proto)
-             && is_exit_restart(m->top.sig->signal_received)
-             && (m->deferred_shutdown_signal.signal_received =3D=3D 0)
-             && m->top.options.ce.explicit_exit_notification !=3D 0)
+    else if (has_udp_in_local_list(&m->top.options))
     {
-        multi_push_restart_schedule_exit(m, m->top.options.ce.explicit_exi=
t_notification =3D=3D 2);
-        return false;
+        if (is_exit_restart(m->top.sig->signal_received)
+            && (m->deferred_shutdown_signal.signal_received =3D=3D 0)
+            && m->top.options.ce.explicit_exit_notification !=3D 0)
+        {
+            multi_push_restart_schedule_exit(m, m->top.options.ce.explicit=
_exit_notification =3D=3D 2);
+            return false;
+        }
     }
     return true;
 }
@@ -4198,10 +4202,10 @@
             multi_tcp_process_io(multi);
             MULTI_CHECK_SIG(multi);
         }
-        /*else if (status =3D=3D 0)
-         * {
-         *  multi_tcp_action(multi, NULL, TA_TIMEOUT, false);
-         * }*/
+        else if (status =3D=3D 0)
+        {
+            multi_tcp_action(multi, NULL, TA_TIMEOUT, false);
+        }

         perf_pop();
     }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9e800bb..553bc26 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -987,10 +987,13 @@
                         const struct connection_entry *e,
                         const int i)
 {
-    setenv_str_i(es, "proto", proto2ascii(e->proto, e->af, false), i);
-    /* expected to befor single socket contexts only */
-    setenv_str_i(es, "local", e->local_list->array[0]->local, i);
-    setenv_str_i(es, "local_port", e->local_list->array[0]->port, i);
+    for (int j =3D 0; j < e->local_list->len; j++)
+    {
+        setenv_str_i(es, "proto", proto2ascii(e->local_list->array[j]->pro=
to, e->af, false), i);
+        /* expected to befor single socket contexts only */
+        setenv_str_i(es, "local", e->local_list->array[j]->local, i);
+        setenv_str_i(es, "local_port", e->local_list->array[j]->port, i);
+    }
     setenv_str_i(es, "remote", e->remote, i);
     setenv_str_i(es, "remote_port", e->remote_port, i);

@@ -2455,7 +2458,7 @@
     {
         struct local_entry *le =3D ce->local_list->array[i];

-        if (proto_is_net(ce->proto)
+        if (proto_is_net(le->proto)
             && string_defined_equal(le->local, ce->remote)
             && string_defined_equal(le->port, ce->remote_port))
         {
@@ -3781,6 +3784,12 @@
         options_postprocess_mutate_ce(o, o->connection_list->array[i]);
     }

+    if (!has_udp_in_local_list(o))
+    {
+        o->fast_io =3D false;
+        msg(M_INFO, "NOTE: --fast-io is disabled while using multi-socket"=
);
+    }
+
     if (o->ce.local_list)
     {
         for (i =3D 0; i < o->ce.local_list->len; i++)
@@ -9629,3 +9638,19 @@
 err:
     gc_free(&gc);
 }
+
+bool
+has_udp_in_local_list(const struct options *options)
+{
+    if (options->ce.local_list)
+    {
+        for (int i =3D 0; i < options->ce.local_list->len; i++)
+        {
+            if (proto_is_dgram(options->ce.local_list->array[i]->proto))
+            {
+                return true;
+            }
+        }
+    }
+    return false;
+}
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index cba0333..59035f8 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -913,6 +913,8 @@

 bool key_is_external(const struct options *options);

+bool has_udp_in_local_list(const struct options *options);
+
 /**
  * Returns whether the current configuration has dco enabled.
  */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/440?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I81ec69d12abc9a661875c93c7f1bd97e525df55f
Gerrit-Change-Number: 440
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--vgZH2vw5n+4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/440?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Using the same wait function for both TCP and UDP<br><br>FORW=
ARD: added a new function to collect UDP flags.<br><br>MTCP: the mtcp struc=
ture has been modified to carry around those flags.<br>      The second wai=
t function (in UDP case) has been removed.<br><br>MULTI: properly remove TC=
P instances by checking the multi_instance<br>       protocol instead of th=
e global one.<br><br>TLS: set the tls_option xmit_hold bool value to true o=
nly in case of<br>     TCP child instance to avoid checking the global prot=
ocol<br>     value.<br><br>INIT: initialize the c-&gt;c2.event_set in the i=
nherit_context_top()<br>      by default and not only in case of UDP since =
we could have<br>      multiple different sockets.<br><br>Change-Id: I81ec6=
9d12abc9a661875c93c7f1bd97e525df55f<br>Signed-off-by: Gianmarco De Gregori =
&lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/forward.c<br>M src/ope=
nvpn/forward.h<br>M src/openvpn/init.c<br>M src/openvpn/mtcp.c<br>M src/ope=
nvpn/mtcp.h<br>M src/openvpn/mudp.c<br>M src/openvpn/multi.c<br>M src/openv=
pn/options.c<br>M src/openvpn/options.h<br>9 files changed, 177 insertions(=
+), 244 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/40/440/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/=
openvpn/forward.c</span><br><span>index 63a684b..ee18f8b 100644</span><br><=
span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.=
c</span><br><span>@@ -2053,48 +2053,20 @@</span><br><span>  */</span><br><s=
pan> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-io_wait_dowork_udp(struct context *c, struct multi_tcp *mtcp, const u=
nsigned int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+g=
et_io_flags_dowork_udp(struct context *c, struct multi_tcp *mtcp, const uns=
igned int flags)</span><br><span> {</span><br><span>     unsigned int socke=
t =3D 0;</span><br><span>     unsigned int tuntap =3D 0;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct event_set_return esr[4];</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /* These shifts all depend on EVENT_READ an=
d EVENT_WRITE */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
tatic uintptr_t socket_shift =3D 0;   /* depends on SOCKET_READ and SOCKET_=
WRITE */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    static ui=
ntptr_t tun_shift =3D 2;      /* depends on TUN_READ and TUN_WRITE */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    static uintptr_t err_sh=
ift =3D 4;      /* depends on ES_ERROR */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    static uintptr_t management_shift =3D 6; /* depe=
nds on MANAGEMENT_READ and MANAGEMENT_WRITE */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    static int file_shift =3D FILE_SHIFT;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    static int dco_shift =
=3D DCO_SHIFT;    /* Event from DCO linux kernel module */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    static uintptr_t err_shift =3D 4;</span><br><span> </span>=
<br><span>     /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
 * Decide what kind of events we want to wait for.</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    /*c-&gt;c2.event_set =3D mtcp-&gt;es; */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    /*event_reset(mtcp-&gt;es); */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*event_reset(c-&gt;=
c2.event_set); */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-     * On win32 we use the keyboard or a=
n event object as a source</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-     * of asynchronous signals.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * Calculate the flags based on the provided &#39;flag=
s&#39; argument.</span><br><span>      */</span><br><span>     if (flags &a=
mp; IOW_WAIT_SIGNAL)</span><br><span>     {</span><br><span>         wait_s=
ignal(mtcp-&gt;es, (void *)err_shift);</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-     * If outgoing data (for TCP=
/UDP port) pending, wait for ready-to-send</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-     * status from TCP/UDP port. Otherwise, wait for i=
ncoming data on</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *=
 TUN/TAP device.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
*/</span><br><span>     if (flags &amp; IOW_TO_LINK)</span><br><span>     {=
</span><br><span>         if (flags &amp; IOW_SHAPER)</span><br><span>@@ -2=
180,117 +2152,68 @@</span><br><span>     /*</span><br><span>      * Configu=
re event wait based on socket, tuntap flags.</span><br><span>      */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; c-=
&gt;c1.link_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     socket_set(c-&gt;c2.link_sockets[i], mtcp-&gt;es, socket,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                   &amp;c-&gt;c2.l=
ink_sockets[i]-&gt;ev_arg, NULL);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
tun_set(c-&gt;c1.tuntap, c-&gt;c2.event_set, tuntap, (void *)tun_shift, NUL=
L);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET=
_LINUX) || defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (socket &amp; EVENT_READ &amp;&amp; c-&gt;c2.did_open_t=
un)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        dco_event_set(&amp;c-&gt;c=
1.tuntap-&gt;dco, mtcp-&gt;es, (void *)&amp;dco_shift);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANA=
GEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (managem=
ent)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        management_socket_set(man=
agement, mtcp-&gt;es, (void *)management_shift, NULL);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC=
_PUSH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* arm inoti=
fy watcher */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
c-&gt;options.mode =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        event_ctl(mtcp-&gt;es, c-&gt;c2.inotify_fd, EVENT_READ, (void *)&a=
mp;file_shift);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-     * Possible scenarios:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-     *  (1) tcp/udp port has data available to read</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-     *  (2) tcp/udp port is ready to a=
ccept more data to write</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-     *  (3) tun dev has data available to read</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-     *  (4) tun dev is ready to accept more dat=
a to write</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *  (5)=
 we received a signal (handler sets signal_received)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     *  (6) timeout (tv) expired</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    mtcp-&gt;event_set_status =3D ES_ERROR;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!c-&gt;sig-&gt;signal_received)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (!(flags &amp; IOW_CHECK_RESIDUAL) || !sockets_read=
_residual(c))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (proto_is_dgram(c-&gt;c2.link_sockets[i]-&gt;info.proto))</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     int status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_DEBUG</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            if (check_debug_=
level(D_EVENT_WAIT))</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       show_wait_status(c);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            /*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-             * Wait for something to happen=
.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            status =3D eve=
nt_wait(mtcp-&gt;es, &amp;c-&gt;c2.timeval, esr, SIZE(esr));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            check_status(status, &quot;event_wait&quot;, =
NULL, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            if (status &gt; 0)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                /*printf(&quo=
t;\nstatus: %d\n&quot;, status); */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                int i;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                mtcp-&gt;event_set_status =3D 0;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                for (i =3D 0; i &=
lt; status; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           const struct event_set_return *e =3D &amp;esr[i];</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    uintptr_t shift;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    if (e-&gt;arg &gt;=3D =
MULTI_N)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
           struct event_arg *ev_arg =3D (struct event_arg *)e-&gt;arg;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                        if=
 (ev_arg-&gt;type !=3D EVENT_ARG_LINK_SOCKET)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                        {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                            mtcp-&gt;event_set_=
status =3D ES_ERROR;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                           msg(D_LINK_ERRORS,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                &quot;io_work: non =
socket event delivered&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                            return;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                        }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                        shift =3D socket_shift;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        /* mark socket so t=
hat the multi code knows where we</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                         * have pending i/o */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                        ev_arg-&gt;pen=
ding =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    shift =3D (uintptr_t)e-&gt;arg;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                    mtcp-&gt;event_set_status |=3D ((e-&gt;rwfla=
gs &amp; 3) &lt;&lt; shift);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       else if (status =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                mtcp-&gt;event_set_status =3D ES_TIMEOUT;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            socket_set(c-&gt;c2.link_sock=
ets[i], mtcp-&gt;es, socket,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                       &amp;c-&gt;c2.link_sockets[i]-&gt;ev_arg, N=
ULL);</span><br><span>         }</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    mtcp-&gt;udp_flags =3D socket | tun=
tap;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* &#39;now&#=
39; should always be a reasonably up-to-date timestamp */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    update_time();</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /* set signal_received if a signal was received */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (mtcp-&gt;event_set_sta=
tus &amp; ES_ERROR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_io_flags_ud=
p(struct context *c, struct multi_tcp *mtcp, const unsigned int flags)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    mtcp-&gt;udp_flags =3D ES_ERROR;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2.fast_io=
 &amp;&amp; (flags &amp; (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        g=
et_signal(&amp;c-&gt;sig-&gt;signal_received);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* fast path -- only for TUN/TAP/UDP wri=
tes */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsig=
ned int ret =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (flags &amp; IOW_TO_TUN)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            ret |=3D TUN_WRITE;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (flags &amp; (IOW_TO_LINK | IOW_MBUF))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            ret |=3D SOCKET_WRITE;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        mtcp-&gt;udp_flags =3D ret;</span=
><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_EVENT_WAIT, &q=
uot;I/O WAIT status=3D0x%04x&quot;, mtcp-&gt;event_set_status);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        bool skip_iowait =3D flags &amp; IOW_TO_TUN;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (flags &amp; IOW_=
READ_TUN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+             * don&#39;t =
read from tun if we have pending write to link,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+             * since every tun read overwrites =
to_link buffer filled</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+             * by previous tun read</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+             */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            skip_iowait =3D !(flags &amp; IOW_TO_LINK);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (tuntap_is_wintun(c-&gt;=
c1.tuntap) &amp;&amp; skip_iowait)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            unsigned int ret =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (flags &amp; IOW_TO_TUN)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                ret |=3D TUN_WRITE;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (flags &amp; IO=
W_READ_TUN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  ret |=3D TUN_READ;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       mtcp-&gt;udp_flags =3D ret;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif /* ifdef _WIN32 */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      /* slow path - delegate to io_wait_dowork_udp to calculate flags */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            get_io_fl=
ags_dowork_udp(c, mtcp, flags);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span> }</span><br><span> </span><br><span> void</span><b=
r><span>@@ -2308,10 +2231,10 @@</span><br><span>     static uintptr_t manag=
ement_shift =3D 6; /* depends on MANAGEMENT_READ and MANAGEMENT_WRITE */</s=
pan><br><span> #endif</span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    static int file_shift =3D FIL=
E_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    static =
uintptr_t file_shift =3D FILE_SHIFT;</span><br><span> #endif</span><br><spa=
n> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    static int dco_shift =3D DCO_SHIFT;  =
  /* Event from DCO linux kernel module */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    static uintptr_t dco_shift =3D DCO_SHIFT;    /* =
Event from DCO linux kernel module */</span><br><span> #endif</span><br><sp=
an>     int i;</span><br><span> </span><br><span>@@ -2428,7 +2351,7 @@</spa=
n><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br=
><span>     if (socket &amp; EVENT_READ &amp;&amp; c-&gt;c2.did_open_tun)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        dco_event_set(&amp;c-&gt;c1.tuntap-&gt;dco, c-&gt;c2.event_set, (vo=
id *)&amp;dco_shift);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        dco_event_set(&amp;c-&gt;c1.tuntap-&gt;dco, c-&gt;c2.event_set, (=
void *)dco_shift);</span><br><span>     }</span><br><span> #endif</span><br=
><span> </span><br><span>@@ -2443,7 +2366,7 @@</span><br><span>     /* arm =
inotify watcher */</span><br><span>     if (c-&gt;options.mode =3D=3D MODE_=
SERVER)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        event_ctl(c-&gt;c2.event_set, c-&gt;c2.inotify_fd, EVENT_R=
EAD, (void *)&amp;file_shift);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        event_ctl(c-&gt;c2.event_set, c-&gt;c2.inotify_fd, EVENT=
_READ, (void *)file_shift);</span><br><span>     }</span><br><span> #endif<=
/span><br><span> </span><br><span>diff --git a/src/openvpn/forward.h b/src/=
openvpn/forward.h</span><br><span>index cb184a8..39ac975 100644</span><br><=
span>--- a/src/openvpn/forward.h</span><br><span>+++ b/src/openvpn/forward.=
h</span><br><span>@@ -69,7 +69,9 @@</span><br><span> </span><br><span> exte=
rn counter_type link_write_bytes_global;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-void io_wait_dowork_udp(struct context=
 *c, struct multi_tcp *mtcp, const unsigned int flags);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void get_io_flags_dowork_udp(struct con=
text *c, struct multi_tcp *mtcp, const unsigned int flags);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void get_io_flags_udp(struct context *c, struct multi_=
tcp *mtcp, const unsigned int flags);</span><br><span> </span><br><span> vo=
id io_wait_dowork(struct context *c, const unsigned int flags);</span><br><=
span> </span><br><span>@@ -366,58 +368,6 @@</span><br><span>     return fla=
gs;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-static inline void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-io_wait_udp(struct context *c, struct multi_tcp *mtcp, cons=
t unsigned int flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;c2.fas=
t_io &amp;&amp; (flags &amp; (IOW_TO_TUN|IOW_TO_LINK|IOW_MBUF)))</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        /* fast path -- only for TUN/TAP/UDP wri=
tes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        unsigne=
d int ret =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (flags &amp; IOW_TO_TUN)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         ret |=3D TUN_WRITE;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (flags &amp; (IOW_TO_LINK|IOW_MBUF))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            ret |=3D SOCKET_WRITE;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        mtcp-&gt;event_set_status =3D ret;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bool skip_iow=
ait =3D flags &amp; IOW_TO_TUN;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (flags &amp; IOW_READ_TUN)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            /*</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-             * don&#39;t read from tun if we have pending write to l=
ink,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             * si=
nce every tun read overwrites to_link buffer filled</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-             * by previous tun read</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-             */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            skip_iowait =3D !(flags=
 &amp; IOW_TO_LINK);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (t=
untap_is_wintun(c-&gt;c1.tuntap) &amp;&amp; skip_iowait)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            unsigned int ret =3D 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            if (flags &amp; IOW_TO_TUN=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                ret |=3D TUN=
_WRITE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (flags =
&amp; IOW_READ_TUN)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      ret |=3D TUN_READ;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       mtcp-&gt;event_set_status =3D ret;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif /* ifdef _WIN32 */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   /* slow path */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         io_wait_dowork_udp(c, mtcp, flags);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</spa=
n><br><span>  * This is the core I/O wait function, used for all I/O waits =
except</span><br><span>  * for TCP in server mode.</span><br><span>diff --g=
it a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index 762793a.=
.2b88551 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>++=
+ b/src/openvpn/init.c</span><br><span>@@ -230,7 +230,7 @@</span><br><span>=
         if (streq(p[1], &quot;HTTP&quot;))</span><br><span>         {</spa=
n><br><span>             struct http_proxy_options *ho;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            if (ce-&gt;proto !=3D PROTO_T=
CP &amp;&amp; ce-&gt;proto !=3D PROTO_TCP_CLIENT)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (ce-&gt;proto !=3D PROTO_TCP &=
amp;&amp; c-&gt;mode !=3D CM_CHILD_TCP)</span><br><span>             {</spa=
n><br><span>                 msg(M_WARN, &quot;HTTP proxy support only work=
s for TCP based connections&quot;);</span><br><span>                 return=
 false;</span><br><span>@@ -607,7 +607,10 @@</span><br><span>             c=
e_defined =3D false;</span><br><span>         }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        int proto =3D c-&gt;o=
ptions.ce.proto;</span><br><span>         c-&gt;options.ce =3D *ce;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;options.ce.pr=
oto =3D proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>         if (ce_defin=
ed &amp;&amp; management &amp;&amp; management_query_remote_enabled(managem=
ent))</span><br><span>         {</span><br><span>@@ -2628,7 +2631,7 @@</spa=
n><br><span> </span><br><span>     if (found &amp; OPT_P_EXPLICIT_NOTIFY)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (!proto_is_udp(c-&gt;options.ce.proto) &amp;&amp; c-&gt;options.=
ce.explicit_exit_notification)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (!proto_is_udp(c-&gt;c2.link_sockets[0]-&gt;info.prot=
o) &amp;&amp; c-&gt;options.ce.explicit_exit_notification)</span><br><span>=
         {</span><br><span>             msg(D_PUSH, &quot;OPTIONS IMPORT: -=
-explicit-exit-notify can only be used with --proto udp&quot;);</span><br><=
span>             c-&gt;options.ce.explicit_exit_notification =3D 0;</span>=
<br><span>@@ -2788,14 +2791,21 @@</span><br><span>     int sec =3D 2;</span=
><br><span>     int backoff =3D 0;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    switch (c-&gt;options.ce.proto)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (c-&gt;mode)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      case PROTO_TCP_SERVER:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            sec =3D 1;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        case CM_TOP:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (has_udp_in_local_list(&amp;c-&gt;options))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                sec =3D c-&gt;o=
ptions.ce.connect_retry_seconds;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              sec =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span>             break;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        case PROTO_UDP:<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        case PROTO_TCP=
_CLIENT:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cas=
e CM_CHILD_UDP:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    case CM_CHILD_TCP:</span><br><span>             sec =3D c-&gt;options.c=
e.connect_retry_seconds;</span><br><span>             break;</span><br><spa=
n>     }</span><br><span>@@ -2813,7 +2823,7 @@</span><br><span>     }</span=
><br><span> </span><br><span>     /* Slow down reconnection after 5 retries=
 per remote -- for TCP client or UDP tls-client only */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;options.ce.proto =3D=3D PRO=
TO_TCP_CLIENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (c-&gt;mode =3D=3D CM_CHILD_TCP</span><br><span>         || (c-&gt;options=
.ce.proto =3D=3D PROTO_UDP &amp;&amp; c-&gt;options.tls_client))</span><br>=
<span>     {</span><br><span>         backoff =3D (c-&gt;options.unsuccessf=
ul_attempts / c-&gt;options.connection_list-&gt;len) - 4;</span><br><span>@=
@ -3293,7 +3303,21 @@</span><br><span>     to.server =3D options-&gt;tls_se=
rver;</span><br><span>     to.replay_window =3D options-&gt;replay_window;<=
/span><br><span>     to.replay_time =3D options-&gt;replay_time;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    to.tcp_mode =3D link_socket_=
proto_connection_oriented(options-&gt;ce.proto);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (c-&gt;options.ce.local_list-&gt;len &gt; 1)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; c-&gt;options.=
ce.local_list-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (proto_is_dgram(c-&gt;options.ce.local_list-&gt;array[i]-&gt;p=
roto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                to.=
tcp_mode =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        to.tcp_mode =3D link_socket_proto_connection_or=
iented(c-&gt;options.ce.local_list-&gt;array[0]-&gt;proto);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     to.confi=
g_ciphername =3D c-&gt;options.ciphername;</span><br><span>     to.config_n=
cp_ciphers =3D c-&gt;options.ncp_ciphers;</span><br><span>     to.transitio=
n_window =3D options-&gt;transition_window;</span><br><span>@@ -3338,7 +336=
2,7 @@</span><br><span> </span><br><span>     /* should we not xmit any pac=
kets until we get an initial</span><br><span>      * response from client? =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (to.server &=
amp;&amp; options-&gt;ce.proto =3D=3D PROTO_TCP_SERVER)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (to.server &amp;&amp; c-&gt;mode=
 =3D=3D CM_CHILD_TCP)</span><br><span>     {</span><br><span>         to.xm=
it_hold =3D true;</span><br><span>     }</span><br><span>@@ -4257,20 +4281,=
13 @@</span><br><span> #ifdef _WIN32</span><br><span>         msg(M_INFO, &=
quot;NOTE: --fast-io is disabled since we are running on Windows&quot;);</s=
pan><br><span> #else</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (!proto_is_udp(c-&gt;options.ce.proto))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (c-&gt;options.shaper)</span><br><=
span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      msg(M_INFO, &quot;NOTE: --fast-io is disabled since we are not using =
UDP&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(M_INFO, &quot;NOTE: --fast-io is disabled since we are using --shap=
er&quot;);</span><br><span>         }</span><br><span>         else</span><=
br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          if (c-&gt;options.shaper)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                msg(M_INFO, &quot;NOTE: --fast-io is disabled since w=
e are using --shaper&quot;);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  c-&gt;c2.fast_io =3D true;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            c-&gt;c2.fast_io =3D true;</span><br><span>         }</span><b=
r><span> #endif</span><br><span>     }</span><br><span>@@ -4967,6 +4984,7 @=
@</span><br><span> </span><br><span>     /* options */</span><br><span>    =
 dest-&gt;options =3D src-&gt;options;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    dest-&gt;options.ce.proto =3D ls-&gt;info.proto;</sp=
an><br><span>     options_detach(&amp;dest-&gt;options);</span><br><span> <=
/span><br><span>     dest-&gt;c2.event_set =3D src-&gt;c2.event_set;</span>=
<br><span>@@ -5065,10 +5083,7 @@</span><br><span>     dest-&gt;c2.es_owned =
=3D false;</span><br><span> </span><br><span>     dest-&gt;c2.event_set =3D=
 NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (proto_i=
s_dgram(src-&gt;options.ce.proto))</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     do_event_set_init(dest, false);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    do_event_set_init(dest, false);</span><br><span> </span><br><span> #if=
def USE_COMP</span><br><span>     dest-&gt;c2.comp_context =3D NULL;</span>=
<br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><s=
pan>index ba0905e..128a375 100644</span><br><span>--- a/src/openvpn/mtcp.c<=
/span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -680,11 +680,11=
 @@</span><br><span> void</span><br><span> multi_tcp_process_io(struct mult=
i_context *m)</span><br><span> {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct multi_tcp *mtcp =3D m-&gt;mtcp;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const unsigned int udp_status =3D m=
tcp-&gt;udp_flags;</span><br><span>     const unsigned int mpp_flags =3D m-=
&gt;top.c2.fast_io</span><br><span>                                    ? (M=
PP_CONDITIONAL_PRE_SELECT | MPP_CLOSE_ON_SIGNAL)</span><br><span>          =
                          : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_tcp *mtcp =
=3D m-&gt;mtcp;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    co=
nst unsigned int status =3D mtcp-&gt;event_set_status;</span><br><span>    =
 int i;</span><br><span> </span><br><span>     for (i =3D 0; i &lt; mtcp-&g=
t;n_esr; ++i)</span><br><span>@@ -725,9 +725,10 @@</span><br><span>        =
                 msg(D_MULTI_ERRORS, &quot;MULTI: mtcp_proc_io: null socket=
&quot;);</span><br><span>                         break;</span><br><span>  =
                   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   socket_reset_listen_persistent(ev_arg-&gt;u.ls);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>          =
           if (!proto_is_dgram(ev_arg-&gt;u.ls-&gt;info.proto))</span><br><=
span>                     {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        socket_reset_listen_persistent(ev_arg-&gt;u=
.ls);</span><br><span>                         mi =3D multi_create_instance=
_tcp(m, ev_arg-&gt;u.ls);</span><br><span>                         if (mi)<=
/span><br><span>                         {</span><br><span>@@ -737,7 +738,2=
3 @@</span><br><span>                     }</span><br><span>               =
      else</span><br><span>                     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                        if (status &amp; SOCKET=
_READ)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
           if (e-&gt;arg &gt;=3D MULTI_N)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                            struct event_arg *e=
v_arg =3D (struct event_arg *)e-&gt;arg;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                            if (ev_arg-&gt;type !=3D E=
VENT_ARG_LINK_SOCKET)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                mtcp-&gt;udp_flags =3D ES_ERROR=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
              msg(D_LINK_ERRORS,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                    &quot;io_work: non socket =
event delivered&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                break;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                        else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
        ev_arg-&gt;pending =3D true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                        }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                        if (udp_status &amp; SOCKET_READ)</span><br><sp=
an>                         {</span><br><span>                             =
read_incoming_link(&amp;m-&gt;top, ev_arg-&gt;u.ls);</span><br><span>      =
                       if (!IS_SIG(&amp;m-&gt;top))</span><br><span>@@ -750=
,12 +767,12 @@</span><br><span>                         while (true)</span>=
<br><span>                         {</span><br><span>                      =
       multi_get_timeout(m, &amp;m-&gt;top.c2.timeval);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                            io_wait_udp(&=
amp;m-&gt;top, m-&gt;mtcp, p2mp_iow_flags(m));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                            get_io_flags_udp(&am=
p;m-&gt;top, m-&gt;mtcp, p2mp_iow_flags(m));</span><br><span>              =
               MULTI_CHECK_SIG(m);</span><br><span> </span><br><span>      =
                       multi_process_per_second_timers(m);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
        if (m-&gt;mtcp-&gt;event_set_status =3D=3D ES_TIMEOUT)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                            if (=
m-&gt;mtcp-&gt;udp_flags =3D=3D ES_TIMEOUT)</span><br><span>               =
              {</span><br><span>                                 multi_proc=
ess_timeout(m, MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span>     =
                        }</span><br><span>diff --git a/src/openvpn/mtcp.h b=
/src/openvpn/mtcp.h</span><br><span>index b2fdb6e..d55bdfd 100644</span><br=
><span>--- a/src/openvpn/mtcp.h</span><br><span>+++ b/src/openvpn/mtcp.h</s=
pan><br><span>@@ -55,7 +55,7 @@</span><br><span>     int n_esr;</span><br><=
span>     int maxevents;</span><br><span>     unsigned int tun_rwflags;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int event_se=
t_status;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsign=
ed int udp_flags;</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span=
>     unsigned int management_persist_flags;</span><br><span> #endif</span>=
<br><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><s=
pan>index 4979751..8945a55 100644</span><br><span>--- a/src/openvpn/mudp.c<=
/span><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -198,7 +198,6 @=
@</span><br><span>     if (mroute_extract_openvpn_sockaddr(&amp;real, &amp;=
m-&gt;top.c2.from.dest, true)</span><br><span>         &amp;&amp; m-&gt;top=
.c2.buf.len &gt; 0)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        /*real.proto =3D ls-&gt;info.proto; */</span><=
br><span>         struct hash_element *he;</span><br><span>         const u=
int32_t hv =3D hash_value(hash, &amp;real);</span><br><span>         struct=
 hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span>@@ -380,9 +=
379,7 @@</span><br><span> void</span><br><span> multi_process_io_udp(struct=
 multi_context *m)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    const unsigned int status =3D m-&gt;mtcp-&gt;event_set_=
status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*p2mp_iow=
_flags(m); */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*m-=
&gt;top.c2.event_set_status; */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    unsigned int status =3D m-&gt;mtcp-&gt;udp_flags;</span><br=
><span>     const unsigned int mpp_flags =3D m-&gt;top.c2.fast_io</span><br=
><span>                                    ? (MPP_CONDITIONAL_PRE_SELECT | =
MPP_CLOSE_ON_SIGNAL)</span><br><span>                                    : =
(MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span>diff --git a/src/op=
envpn/multi.c b/src/openvpn/multi.c</span><br><span>index 5098581..108a5a8 =
100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/=
openvpn/multi.c</span><br><span>@@ -607,6 +607,7 @@</span><br><span> </span=
><br><span>     ASSERT(!mi-&gt;halt);</span><br><span>     mi-&gt;halt =3D =
true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool is_dg=
ram =3D proto_is_dgram(mi-&gt;context.c2.link_sockets[0]-&gt;info.proto);</=
span><br><span> </span><br><span>     dmsg(D_MULTI_DEBUG, &quot;MULTI: mult=
i_close_instance called&quot;);</span><br><span> </span><br><span>@@ -665,7=
 +666,7 @@</span><br><span>             mi-&gt;did_iroutes =3D false;</span=
><br><span>         }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (m-&gt;mtcp &amp;&amp; !proto_is_dgram(m-&gt;t=
op.options.ce.proto))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (!is_dgram)</span><br><span>         {</span><br><span>       =
      multi_tcp_dereference_instance(m-&gt;mtcp, mi);</span><br><span>     =
    }</span><br><span>@@ -3406,6 +3407,7 @@</span><br><span> </span><br><sp=
an>             perf_push(PERF_PROC_IN_LINK);</span><br><span>             =
lsi =3D get_link_socket_info(c);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            /*lsi =3D &amp;ls-&gt;info; */</span><br><span>   =
          orig_buf =3D c-&gt;c2.buf.data;</span><br><span>             if (=
process_incoming_link_part1(c, lsi, floated))</span><br><span>             =
{</span><br><span>@@ -3856,7 +3858,7 @@</span><br><span>     while ((he =3D=
 hash_iterator_next(&amp;hi)))</span><br><span>     {</span><br><span>     =
    struct multi_instance *mi =3D (struct multi_instance *) he-&gt;value;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!mi-&gt;hal=
t)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!mi-&=
gt;halt &amp;&amp; proto_is_dgram(mi-&gt;context.options.ce.proto))</span><=
br><span>         {</span><br><span>             send_control_channel_strin=
g(&amp;mi-&gt;context, next_server ? &quot;RESTART,[N]&quot; : &quot;RESTAR=
T&quot;, D_PUSH);</span><br><span>             multi_schedule_context_wakeu=
p(m, mi);</span><br><span>@@ -3894,13 +3896,15 @@</span><br><span>         =
status_close(so);</span><br><span>         return false;</span><br><span>  =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (prot=
o_is_dgram(m-&gt;top.options.ce.proto)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-             &amp;&amp; is_exit_restart(m-&gt;top.sig-&gt;=
signal_received)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
        &amp;&amp; (m-&gt;deferred_shutdown_signal.signal_received =3D=3D 0=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             &amp;&a=
mp; m-&gt;top.options.ce.explicit_exit_notification !=3D 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    else if (has_udp_in_local_list(=
&amp;m-&gt;top.options))</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        multi_push_restart_schedule_exit(m, m-&gt=
;top.options.ce.explicit_exit_notification =3D=3D 2);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (is_exit_restart(m-&gt;top.sig=
-&gt;signal_received)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            &amp;&amp; (m-&gt;deferred_shutdown_signal.signal_received =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  &amp;&amp; m-&gt;top.options.ce.explicit_exit_notification !=3D 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            multi_push_restart_sched=
ule_exit(m, m-&gt;top.options.ce.explicit_exit_notification =3D=3D 2);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span>     }</span><br><span>     return true;</span><br><span> }</span><=
br><span>@@ -4198,10 +4202,10 @@</span><br><span>             multi_tcp_pro=
cess_io(multi);</span><br><span>             MULTI_CHECK_SIG(multi);</span>=
<br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       /*else if (status =3D=3D 0)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-         * {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-         *  multi_tcp_action(multi, NULL, TA_TIMEOUT, false);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-         * }*/</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        else if (status =3D=3D 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            multi_tcp_action(mul=
ti, NULL, TA_TIMEOUT, false);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span> </span><br><span>         perf_pop();<=
/span><br><span>     }</span><br><span>diff --git a/src/openvpn/options.c b=
/src/openvpn/options.c</span><br><span>index 9e800bb..553bc26 100644</span>=
<br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/opt=
ions.c</span><br><span>@@ -987,10 +987,13 @@</span><br><span>              =
           const struct connection_entry *e,</span><br><span>              =
           const int i)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    setenv_str_i(es, &quot;proto&quot;, proto2ascii(e-=
&gt;proto, e-&gt;af, false), i);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* expected to befor single socket contexts only */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    setenv_str_i(es, &quot;loc=
al&quot;, e-&gt;local_list-&gt;array[0]-&gt;local, i);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    setenv_str_i(es, &quot;local_port&quot=
;, e-&gt;local_list-&gt;array[0]-&gt;port, i);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    for (int j =3D 0; j &lt; e-&gt;local_list-&g=
t;len; j++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        setenv_str_i(e=
s, &quot;proto&quot;, proto2ascii(e-&gt;local_list-&gt;array[j]-&gt;proto, =
e-&gt;af, false), i);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* expected to befor single socket contexts only */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        setenv_str_i(es, &quot;lo=
cal&quot;, e-&gt;local_list-&gt;array[j]-&gt;local, i);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        setenv_str_i(es, &quot;local_po=
rt&quot;, e-&gt;local_list-&gt;array[j]-&gt;port, i);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     setenv_str_i(e=
s, &quot;remote&quot;, e-&gt;remote, i);</span><br><span>     setenv_str_i(=
es, &quot;remote_port&quot;, e-&gt;remote_port, i);</span><br><span> </span=
><br><span>@@ -2455,7 +2458,7 @@</span><br><span>     {</span><br><span>   =
      struct local_entry *le =3D ce-&gt;local_list-&gt;array[i];</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (pr=
oto_is_net(ce-&gt;proto)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (proto_is_net(le-&gt;proto)</span><br><span>             &a=
mp;&amp; string_defined_equal(le-&gt;local, ce-&gt;remote)</span><br><span>=
             &amp;&amp; string_defined_equal(le-&gt;port, ce-&gt;remote_por=
t))</span><br><span>         {</span><br><span>@@ -3781,6 +3784,12 @@</span=
><br><span>         options_postprocess_mutate_ce(o, o-&gt;connection_list-=
&gt;array[i]);</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!has_udp_in_local_list(o))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        o-&gt;fast_io =3D false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO, &quot=
;NOTE: --fast-io is disabled while using multi-socket&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>     if (o-&gt;ce.local_list)<=
/span><br><span>     {</span><br><span>         for (i =3D 0; i &lt; o-&gt;=
ce.local_list-&gt;len; i++)</span><br><span>@@ -9629,3 +9638,19 @@</span><b=
r><span> err:</span><br><span>     gc_free(&amp;gc);</span><br><span> }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+has_udp_in_local_list(const struct options *options)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;ce.local_list)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; options=
-&gt;ce.local_list-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (proto_is_dgram(options-&gt;ce.local_list-&gt;array[i]-&g=
t;proto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/open=
vpn/options.h b/src/openvpn/options.h</span><br><span>index cba0333..59035f=
8 100644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/=
src/openvpn/options.h</span><br><span>@@ -913,6 +913,8 @@</span><br><span> =
</span><br><span> bool key_is_external(const struct options *options);</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool h=
as_udp_in_local_list(const struct options *options);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *=
 Returns whether the current configuration has dco enabled.</span><br><span=
>  */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/440?usp=3Demail">change 440</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/440?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I81ec69d12abc9a661875c93c7f1=
bd97e525df55f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 440 </div>
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


--vgZH2vw5n+4=--

