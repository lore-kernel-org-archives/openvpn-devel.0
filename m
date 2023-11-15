From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 15 Nov 2023 13:45:15 +0000
References: <gerrit.1700055887000.Ia122d5cdc42c2969eef6f32f438e30b52652721f@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9d07277a7ccea9186aa16fea80935634ae99d10d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fgTefzOcTAw="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Bind to multiple
 ipv4/ipv6 addresses
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

--fgTefzOcTAw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/438?usp=3Demail

to review the following change.


Change subject: Bind to multiple ipv4/ipv6 addresses
......................................................................

Bind to multiple ipv4/ipv6 addresses

Enables the binding of multiple listen
sockets based on the specified "--local"
directives.

The main server loop has been updated
to handle both TCP and UDP connections.

The hash function has also been modified
to include the protocol during the
creation of new client instances.

Change-Id: Ia122d5cdc42c2969eef6f32f438e30b52652721f
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/init.c
M src/openvpn/mroute.c
M src/openvpn/mroute.h
M src/openvpn/mtcp.c
M src/openvpn/mtcp.h
M src/openvpn/mudp.c
M src/openvpn/mudp.h
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/options.c
M src/openvpn/options.h
13 files changed, 613 insertions(+), 116 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/438/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 9a6dcd8..27415ee 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1760,7 +1760,7 @@
             if (c->options.shaper)
             {
                 int overhead =3D datagram_overhead(c->c2.to_link_addr->des=
t.addr.sa.sa_family,
-                                                 c->options.ce.proto);
+                                                 ls->info.proto);
                 shaper_wrote_bytes(&c->c2.shaper,
                                    BLEN(&c->c2.to_link) + overhead);
             }
@@ -2050,6 +2050,250 @@
  */

 void
+io_wait_dowork_udp(struct context *c, struct multi_tcp *mtcp, const unsign=
ed int flags)
+{
+    unsigned int socket =3D 0;
+    unsigned int tuntap =3D 0;
+    struct event_set_return esr[4];
+
+    /* These shifts all depend on EVENT_READ and EVENT_WRITE */
+    static uintptr_t socket_shift =3D 0;   /* depends on SOCKET_READ and S=
OCKET_WRITE */
+    static uintptr_t tun_shift =3D 2;      /* depends on TUN_READ and TUN_=
WRITE */
+    static uintptr_t err_shift =3D 4;      /* depends on ES_ERROR */
+#ifdef ENABLE_MANAGEMENT
+    static uintptr_t management_shift =3D 6; /* depends on MANAGEMENT_READ=
 and MANAGEMENT_WRITE */
+#endif
+#ifdef ENABLE_ASYNC_PUSH
+    static int file_shift =3D FILE_SHIFT;
+#endif
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+    static int dco_shift =3D DCO_SHIFT;    /* Event from DCO linux kernel =
module */
+#endif
+    int i;
+
+    /*
+     * Decide what kind of events we want to wait for.
+     */
+    /*c->c2.event_set =3D mtcp->es; */
+    /*event_reset(mtcp->es); */
+    /*event_reset(c->c2.event_set); */
+
+    /*
+     * On win32 we use the keyboard or an event object as a source
+     * of asynchronous signals.
+     */
+    if (flags & IOW_WAIT_SIGNAL)
+    {
+        wait_signal(mtcp->es, (void *)err_shift);
+    }
+
+    /*
+     * If outgoing data (for TCP/UDP port) pending, wait for ready-to-send
+     * status from TCP/UDP port. Otherwise, wait for incoming data on
+     * TUN/TAP device.
+     */
+    if (flags & IOW_TO_LINK)
+    {
+        if (flags & IOW_SHAPER)
+        {
+            /*
+             * If sending this packet would put us over our traffic shaping
+             * quota, don't send -- instead compute the delay we must wait
+             * until it will be OK to send the packet.
+             */
+            int delay =3D 0;
+
+            /* set traffic shaping delay in microseconds */
+            if (c->options.shaper)
+            {
+                delay =3D max_int(delay, shaper_delay(&c->c2.shaper));
+            }
+
+            if (delay < 1000)
+            {
+                socket |=3D EVENT_WRITE;
+            }
+            else
+            {
+                shaper_soonest_event(&c->c2.timeval, delay);
+            }
+        }
+        else
+        {
+            socket |=3D EVENT_WRITE;
+        }
+    }
+    else if (!((flags & IOW_FRAG) && TO_LINK_FRAG(c)))
+    {
+        if (flags & IOW_READ_TUN)
+        {
+            tuntap |=3D EVENT_READ;
+        }
+    }
+
+    /*
+     * If outgoing data (for TUN/TAP device) pending, wait for ready-to-se=
nd status
+     * from device.  Otherwise, wait for incoming data on TCP/UDP port.
+     */
+    if (flags & IOW_TO_TUN)
+    {
+        tuntap |=3D EVENT_WRITE;
+    }
+    else
+    {
+        if (flags & IOW_READ_LINK)
+        {
+            socket |=3D EVENT_READ;
+        }
+    }
+
+    /*
+     * outgoing bcast buffer waiting to be sent?
+     */
+    if (flags & IOW_MBUF)
+    {
+        socket |=3D EVENT_WRITE;
+    }
+
+    /*
+     * Force wait on TUN input, even if also waiting on TCP/UDP output
+     */
+    if (flags & IOW_READ_TUN_FORCE)
+    {
+        tuntap |=3D EVENT_READ;
+    }
+
+#ifdef _WIN32
+    if (tuntap_is_wintun(c->c1.tuntap))
+    {
+        /*
+         * With wintun we are only interested in read event. Ring buffer is
+         * always ready for write, so we don't do wait.
+         */
+        tuntap =3D EVENT_READ;
+    }
+#endif
+
+    /*
+     * Configure event wait based on socket, tuntap flags.
+     */
+    for (i =3D 0; i < c->c1.link_sockets_num; i++)
+    {
+        socket_set(c->c2.link_sockets[i], mtcp->es, socket,
+                   &c->c2.link_sockets[i]->ev_arg, NULL);
+    }
+    tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)tun_shift, NULL=
);
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+    if (socket & EVENT_READ && c->c2.did_open_tun)
+    {
+        dco_event_set(&c->c1.tuntap->dco, mtcp->es, (void *)&dco_shift);
+    }
+#endif
+
+#ifdef ENABLE_MANAGEMENT
+    if (management)
+    {
+        management_socket_set(management, mtcp->es, (void *)management_shi=
ft, NULL);
+    }
+#endif
+
+#ifdef ENABLE_ASYNC_PUSH
+    /* arm inotify watcher */
+    if (c->options.mode =3D=3D MODE_SERVER)
+    {
+        event_ctl(mtcp->es, c->c2.inotify_fd, EVENT_READ, (void *)&file_sh=
ift);
+    }
+#endif
+
+    /*
+     * Possible scenarios:
+     *  (1) tcp/udp port has data available to read
+     *  (2) tcp/udp port is ready to accept more data to write
+     *  (3) tun dev has data available to read
+     *  (4) tun dev is ready to accept more data to write
+     *  (5) we received a signal (handler sets signal_received)
+     *  (6) timeout (tv) expired
+     */
+
+    mtcp->event_set_status =3D ES_ERROR;
+
+    if (!c->sig->signal_received)
+    {
+        if (!(flags & IOW_CHECK_RESIDUAL) || !sockets_read_residual(c))
+        {
+            int status;
+
+#ifdef ENABLE_DEBUG
+            if (check_debug_level(D_EVENT_WAIT))
+            {
+                show_wait_status(c);
+            }
+#endif
+
+            /*
+             * Wait for something to happen.
+             */
+            status =3D event_wait(mtcp->es, &c->c2.timeval, esr, SIZE(esr)=
);
+
+            check_status(status, "event_wait", NULL, NULL);
+
+            if (status > 0)
+            {
+                int i;
+                mtcp->event_set_status =3D 0;
+                for (i =3D 0; i < status; ++i)
+                {
+                    const struct event_set_return *e =3D &esr[i];
+                    uintptr_t shift;
+
+                    if (e->arg >=3D MULTI_N)
+                    {
+                        struct event_arg *ev_arg =3D (struct event_arg *)e=
->arg;
+                        if (ev_arg->type !=3D EVENT_ARG_LINK_SOCKET)
+                        {
+                            mtcp->event_set_status =3D ES_ERROR;
+                            msg(D_LINK_ERRORS,
+                                "io_work: non socket event delivered");
+                            return;
+                        }
+
+                        shift =3D socket_shift;
+                        /* mark socket so that the multi code knows where =
we
+                         * have pending i/o */
+                        ev_arg->pending =3D true;
+                    }
+                    else
+                    {
+                        shift =3D (uintptr_t)e->arg;
+                    }
+
+                    mtcp->event_set_status |=3D ((e->rwflags & 3) << shift=
);
+                }
+            }
+            else if (status =3D=3D 0)
+            {
+                mtcp->event_set_status =3D ES_TIMEOUT;
+            }
+        }
+        else
+        {
+            mtcp->event_set_status =3D SOCKET_READ;
+        }
+    }
+
+    /* 'now' should always be a reasonably up-to-date timestamp */
+    update_time();
+
+    /* set signal_received if a signal was received */
+    if (mtcp->event_set_status & ES_ERROR)
+    {
+        get_signal(&c->sig->signal_received);
+    }
+
+    dmsg(D_EVENT_WAIT, "I/O WAIT status=3D0x%04x", mtcp->event_set_status);
+}
+
+void
 io_wait_dowork(struct context *c, const unsigned int flags)
 {
     unsigned int socket =3D 0;
@@ -2291,6 +2535,7 @@
     dmsg(D_EVENT_WAIT, "I/O WAIT status=3D0x%04x", c->c2.event_set_status);
 }

+
 void
 process_io(struct context *c, struct link_socket *ls)
 {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 333dcdc..cb184a8 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -50,6 +50,7 @@
 #include "openvpn.h"
 #include "occ.h"
 #include "ping.h"
+#include "mtcp.h"

 #define IOW_TO_TUN          (1<<0)
 #define IOW_TO_LINK         (1<<1)
@@ -68,6 +69,8 @@

 extern counter_type link_write_bytes_global;

+void io_wait_dowork_udp(struct context *c, struct multi_tcp *mtcp, const u=
nsigned int flags);
+
 void io_wait_dowork(struct context *c, const unsigned int flags);

 void pre_select(struct context *c);
@@ -363,6 +366,58 @@
     return flags;
 }

+static inline void
+io_wait_udp(struct context *c, struct multi_tcp *mtcp, const unsigned int =
flags)
+{
+    if (c->c2.fast_io && (flags & (IOW_TO_TUN|IOW_TO_LINK|IOW_MBUF)))
+    {
+        /* fast path -- only for TUN/TAP/UDP writes */
+        unsigned int ret =3D 0;
+        if (flags & IOW_TO_TUN)
+        {
+            ret |=3D TUN_WRITE;
+        }
+        if (flags & (IOW_TO_LINK|IOW_MBUF))
+        {
+            ret |=3D SOCKET_WRITE;
+        }
+        mtcp->event_set_status =3D ret;
+    }
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
+            mtcp->event_set_status =3D ret;
+        }
+        else
+#endif /* ifdef _WIN32 */
+        {
+            /* slow path */
+            io_wait_dowork_udp(c, mtcp, flags);
+        }
+    }
+}
+
 /*
  * This is the core I/O wait function, used for all I/O waits except
  * for TCP in server mode.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 659c9e3..762793a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3791,6 +3791,24 @@
     unsigned int sockflags =3D c->options.sockflags;
     int i;

+    int mode =3D LS_MODE_DEFAULT;
+    /* mode allows CM_CHILD_TCP
+     * instances to inherit acceptable fds
+     * from a top-level parent */
+    if (c->options.mode =3D=3D MODE_SERVER)
+    {
+        /* initializing listening socket */
+        if (c->mode =3D=3D CM_TOP)
+        {
+            mode =3D LS_MODE_TCP_LISTEN;
+        }
+        /* initializing socket to client */
+        else if (c->mode =3D=3D CM_CHILD_TCP)
+        {
+            mode =3D LS_MODE_TCP_ACCEPT_FROM;
+        }
+    }
+
 #if PORT_SHARE
     if (c->options.port_share_host && c->options.port_share_port)
     {
@@ -3800,33 +3818,37 @@

     for (i =3D 0; i < c->c1.link_sockets_num; i++)
     {
-        int mode =3D LS_MODE_DEFAULT;
+        const char *host =3D c->options.ce.local_list->array[i]->local;
+        const char *port =3D c->options.ce.local_list->array[i]->port;
+        int proto =3D c->options.ce.local_list->array[i]->proto;
+        bool bind_local =3D c->options.ce.local_list->array[i]->bind_local;

-        /* mode allows CM_CHILD_TCP
-         * instances to inherit acceptable fds
-         * from a top-level parent */
-        if (c->options.mode =3D=3D MODE_SERVER)
+        if (c->mode =3D=3D CM_CHILD_TCP || c->mode =3D=3D CM_CHILD_UDP)
         {
-            /* initializing listening socket */
-            if (c->mode =3D=3D CM_TOP)
+            const struct link_socket *ls =3D NULL;
+            if (c->mode =3D=3D CM_CHILD_TCP)
             {
-                mode =3D LS_MODE_TCP_LISTEN;
+                ls =3D c->c2.accept_from;
             }
-            /* initializing socket to client */
-            else if (c->mode =3D=3D CM_CHILD_TCP)
+            else if (c->mode =3D=3D CM_CHILD_UDP)
             {
-                mode =3D LS_MODE_TCP_ACCEPT_FROM;
+                ls =3D c->c2.link_sockets[0];
             }
+
+            host =3D ls->local_host;
+            port =3D ls->local_port;
+            proto =3D ls->info.proto;
+            bind_local =3D ls->bind_local;
         }

         /* init each socket with its specific port */
         link_socket_init_phase1(c->c2.link_sockets[i],
-                                c->options.ce.local_list->array[i]->local,
-                                c->options.ce.local_list->array[i]->port,
+                                host,
+                                port,
                                 c->options.ce.remote,
                                 c->options.ce.remote_port,
                                 c->c1.dns_cache,
-                                c->options.ce.proto,
+                                proto,
                                 c->options.ce.af,
                                 c->options.ce.bind_ipv6_only,
                                 mode,
@@ -3836,7 +3858,7 @@
 #ifdef ENABLE_DEBUG
                                 c->options.gremlin,
 #endif
-                                c->options.ce.local_list->array[i]->bind_l=
ocal,
+                                bind_local,
                                 c->options.ce.remote_float,
                                 &c->c1.link_socket_addrs[i],
                                 c->options.ipchange,
@@ -4655,7 +4677,7 @@
     }

     /* our wait-for-i/o objects, different for posix vs. win32 */
-    if (c->mode =3D=3D CM_P2P)
+    if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP)
     {
         do_event_set_init(c, SHAPER_DEFINED(&c->options));
     }
@@ -4919,7 +4941,7 @@
     CLEAR(*dest);

     /* proto_is_dgram will ASSERT(0) if proto is invalid */
-    dest->mode =3D proto_is_dgram(src->options.ce.proto) ? CM_CHILD_UDP : =
CM_CHILD_TCP;
+    dest->mode =3D proto_is_dgram(ls->info.proto) ? CM_CHILD_UDP : CM_CHIL=
D_TCP;

     dest->gc =3D gc_new();

@@ -4947,6 +4969,8 @@
     dest->options =3D src->options;
     options_detach(&dest->options);

+    dest->c2.event_set =3D src->c2.event_set;
+
     if (dest->mode =3D=3D CM_CHILD_TCP)
     {
         /*
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 91af2b6..0017a48 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -421,6 +421,7 @@
                 {
                     buf_printf(&out, ":%d", ntohs(maddr.v4.port));
                 }
+                buf_printf(&out, ":%d", maddr.proto);
             }
             break;

diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index a06e872..7c8972f 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -76,6 +76,7 @@
     uint8_t len;    /* length of address */
     uint8_t unused;
     uint8_t type;   /* MR_ADDR/MR_WITH flags */
+    uint8_t proto;
     uint8_t netbits; /* number of bits in network part of address,
                       * valid if MR_WITH_NETBITS is set */
     union {
@@ -211,6 +212,10 @@
     {
         return false;
     }
+    if (a1->proto !=3D a2->proto)
+    {
+        return false;
+    }
     if (a1->netbits !=3D a2->netbits)
     {
         return false;
@@ -232,7 +237,7 @@
 static inline uint32_t
 mroute_addr_hash_len(const struct mroute_addr *a)
 {
-    return (uint32_t) a->len + 2;
+    return (uint32_t) a->len + 3;
 }

 static inline void
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 06073cd..d4ce642 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -37,21 +37,6 @@
 #endif

 /*
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
  * Special tags passed to event.[ch] functions
  */
 #define MTCP_SOCKET      ((void *)1)
@@ -122,8 +107,9 @@
     struct hash *hash =3D m->hash;

     mi =3D multi_create_instance(m, NULL, ls);
-    if (mi)
+    if (mi && !proto_is_dgram(ls->info.proto))
     {
+        printf("\nTCP add\n");
         struct hash_element *he;
         const uint32_t hv =3D hash_value(hash, &mi->real);
         struct hash_bucket *bucket =3D hash_bucket(hash, hv);
@@ -174,7 +160,7 @@
     ASSERT(mi->context.c2.link_sockets);
     ASSERT(mi->context.c2.link_sockets[0]);
     ASSERT(mi->context.c2.link_sockets[0]->info.lsa);
-    ASSERT(mi->context.c2.link_sockets[0]->mode =3D=3D LS_MODE_TCP_ACCEPT_=
FROM);
+    /*ASSERT(mi->context.c2.link_sockets[0]->mode =3D=3D LS_MODE_TCP_ACCEP=
T_FROM); */
     ASSERT(mi->context.c2.link_sockets[0]->info.lsa->actual.dest.addr.sa.s=
a_family =3D=3D AF_INET
            || mi->context.c2.link_sockets[0]->info.lsa->actual.dest.addr.s=
a.sa_family =3D=3D AF_INET6
            );
@@ -259,11 +245,11 @@
     }
 }

-static inline int
-multi_tcp_wait(const struct context *c,
+int
+multi_tcp_wait(struct context *c,
                struct multi_tcp *mtcp)
 {
-    int i, status;
+    int status, i;
     unsigned int *persistent =3D &mtcp->tun_rwflags;
=20
     for (i =3D 0; i < c->c1.link_sockets_num; i++)
@@ -603,7 +589,7 @@
     return newaction;
 }

-static void
+void
 multi_tcp_action(struct multi_context *m, struct multi_instance *mi, int a=
ction, bool poll)
 {
     bool tun_input_pending =3D false;
@@ -691,10 +677,14 @@
     } while (action !=3D TA_UNDEF);
 }

-static void
+void
 multi_tcp_process_io(struct multi_context *m)
 {
+    const unsigned int mpp_flags =3D m->top.c2.fast_io
+                                   ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLO=
SE_ON_SIGNAL)
+                                   : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL=
);
     struct multi_tcp *mtcp =3D m->mtcp;
+    const unsigned int status =3D mtcp->event_set_status;
     int i;

     for (i =3D 0; i < mtcp->n_esr; ++i)
@@ -735,14 +725,45 @@
                         msg(D_MULTI_ERRORS, "MULTI: mtcp_proc_io: null soc=
ket");
                         break;
                     }
-
                     socket_reset_listen_persistent(ev_arg->u.ls);
-                    mi =3D multi_create_instance_tcp(m, ev_arg->u.ls);
-                    if (mi)
+                    if (!proto_is_dgram(ev_arg->u.ls->info.proto))
                     {
-                        multi_tcp_action(m, mi, TA_INITIAL, false);
+                        mi =3D multi_create_instance_tcp(m, ev_arg->u.ls);
+                        if (mi)
+                        {
+                            multi_tcp_action(m, mi, TA_INITIAL, false);
+                        }
+                        break;
                     }
-                    break;
+                    else
+                    {
+                        if (status & SOCKET_READ)
+                        {
+                            read_incoming_link(&m->top, ev_arg->u.ls);
+                            if (!IS_SIG(&m->top))
+                            {
+                                multi_process_incoming_link(m, NULL, mpp_f=
lags,
+                                                            ev_arg->u.ls);
+                            }
+                        }
+                        multi_get_timeout(m, &m->top.c2.timeval);
+                        io_wait_udp(&m->top, m->mtcp, p2mp_iow_flags(m));
+                        MULTI_CHECK_SIG(m);
+
+                        multi_process_per_second_timers(m);
+
+                        if (m->mtcp->event_set_status =3D=3D ES_TIMEOUT)
+                        {
+                            multi_process_timeout(m, MPP_PRE_SELECT | MPP_=
CLOSE_ON_SIGNAL);
+                        }
+                        else
+                        {
+                            multi_process_io_udp(m);
+                            MULTI_CHECK_SIG(m);
+                        }
+
+                        break;
+                    }
             }
         }
         else
@@ -838,7 +859,7 @@
     }

     /* initialize global multi_context object */
-    multi_init(&multi, top, true);
+    multi_init(&multi, top);

     /* initialize our cloned top object */
     multi_top_init(&multi, top);
@@ -874,12 +895,12 @@
         if (status > 0)
         {
             /* process the I/O which triggered select */
-            multi_tcp_process_io(&multi);
+            /*multi_tcp_process_io(&multi); */
             MULTI_CHECK_SIG(&multi);
         }
         else if (status =3D=3D 0)
         {
-            multi_tcp_action(&multi, NULL, TA_TIMEOUT, false);
+            /*multi_tcp_action(&multi, NULL, TA_TIMEOUT, false); */
         }

         perf_pop();
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index bacf723..b2fdb6e 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -31,6 +31,21 @@
 #include "event.h"

 /*
+ * TCP States
+ */
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
  * Extra state info needed for TCP mode
  */
 struct multi_tcp
@@ -40,6 +55,7 @@
     int n_esr;
     int maxevents;
     unsigned int tun_rwflags;
+    unsigned int event_set_status;
 #ifdef ENABLE_MANAGEMENT
     unsigned int management_persist_flags;
 #endif
@@ -58,6 +74,13 @@

 void multi_tcp_instance_specific_free(struct multi_instance *mi);

+int multi_tcp_wait(struct context *c, struct multi_tcp *mtcp);
+
+void multi_tcp_process_io(struct multi_context *m);
+
+void multi_tcp_action(struct multi_context *m, struct multi_instance *mi, =
int action, bool poll);
+
+
 void multi_tcp_link_out_deferred(struct multi_context *m, struct multi_ins=
tance *mi);


diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index dd45720..e9182c8 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -192,10 +192,12 @@
     struct mroute_addr real;
     struct multi_instance *mi =3D NULL;
     struct hash *hash =3D m->hash;
+    real.proto =3D ls->info.proto;

     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true)
         && m->top.c2.buf.len > 0)
     {
+        /*real.proto =3D ls->info.proto; */
         struct hash_element *he;
         const uint32_t hv =3D hash_value(hash, &real);
         struct hash_bucket *bucket =3D hash_bucket(hash, hv);
@@ -318,18 +320,68 @@
         msg_set_prefix("Connection Attempt");
         m->top.c2.to_link =3D m->hmac_reply;
         m->top.c2.to_link_addr =3D m->hmac_reply_dest;
-        process_outgoing_link(&m->top, m->top.c2.link_sockets[0]);
+        for (int i =3D 0; i < m->top.c1.link_sockets_num; i++)
+        {
+            if (!proto_is_dgram(m->top.c2.link_sockets[i]->info.proto))
+            {
+                continue;
+            }
+
+            process_outgoing_link(&m->top, m->top.c2.link_sockets[i]);
+        }
         m->hmac_reply_dest =3D NULL;
     }
 }

 /*
+ * Return the io_wait() flags appropriate for
+ * a point-to-multipoint tunnel.
+ */
+unsigned int
+p2mp_iow_flags(const struct multi_context *m)
+{
+    unsigned int flags =3D IOW_WAIT_SIGNAL;
+    if (m->pending)
+    {
+        if (TUN_OUT(&m->pending->context))
+        {
+            flags |=3D IOW_TO_TUN;
+        }
+        if (LINK_OUT(&m->pending->context))
+        {
+            flags |=3D IOW_TO_LINK;
+        }
+    }
+    else if (mbuf_defined(m->mbuf))
+    {
+        flags |=3D IOW_MBUF;
+    }
+    else if (m->hmac_reply_dest)
+    {
+        flags |=3D IOW_TO_LINK;
+    }
+    else
+    {
+        flags |=3D IOW_READ;
+    }
+#ifdef _WIN32
+    if (tuntap_ring_empty(m->top.c1.tuntap))
+    {
+        flags &=3D ~IOW_READ_TUN;
+    }
+#endif
+    return flags;
+}
+
+/*
  * Process an I/O event.
  */
-static void
+void
 multi_process_io_udp(struct multi_context *m)
 {
-    const unsigned int status =3D m->top.c2.event_set_status;
+    const unsigned int status =3D m->mtcp->event_set_status;
+    /*p2mp_iow_flags(m); */
+    /*m->top.c2.event_set_status; */
     const unsigned int mpp_flags =3D m->top.c2.fast_io
                                    ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLO=
SE_ON_SIGNAL)
                                    : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL=
);
@@ -428,47 +480,6 @@
 #endif
 }

-/*
- * Return the io_wait() flags appropriate for
- * a point-to-multipoint tunnel.
- */
-static inline unsigned int
-p2mp_iow_flags(const struct multi_context *m)
-{
-    unsigned int flags =3D IOW_WAIT_SIGNAL;
-    if (m->pending)
-    {
-        if (TUN_OUT(&m->pending->context))
-        {
-            flags |=3D IOW_TO_TUN;
-        }
-        if (LINK_OUT(&m->pending->context))
-        {
-            flags |=3D IOW_TO_LINK;
-        }
-    }
-    else if (mbuf_defined(m->mbuf))
-    {
-        flags |=3D IOW_MBUF;
-    }
-    else if (m->hmac_reply_dest)
-    {
-        flags |=3D IOW_TO_LINK;
-    }
-    else
-    {
-        flags |=3D IOW_READ;
-    }
-#ifdef _WIN32
-    if (tuntap_ring_empty(m->top.c1.tuntap))
-    {
-        flags &=3D ~IOW_READ_TUN;
-    }
-#endif
-    return flags;
-}
-
-
 void
 tunnel_server_udp(struct context *top)
 {
@@ -485,7 +496,7 @@
     }

     /* initialize global multi_context object */
-    multi_init(&multi, top, false);
+    multi_init(&multi, top);

     /* initialize our cloned top object */
     multi_top_init(&multi, top);
@@ -511,7 +522,7 @@

         /* set up and do the io_wait() */
         multi_get_timeout(&multi, &multi.top.c2.timeval);
-        io_wait(&multi.top, p2mp_iow_flags(&multi));
+        /*io_wait(&multi.top, p2mp_iow_flags(&multi)); */
         MULTI_CHECK_SIG(&multi);

         /* check on status of coarse timers */
@@ -525,7 +536,7 @@
         else
         {
             /* process I/O */
-            multi_process_io_udp(&multi);
+            /*multi_process_io_udp(&multi); */
             MULTI_CHECK_SIG(&multi);
         }

diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 1088246..75e5a5e 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -31,6 +31,8 @@
 struct context;
 struct multi_context;

+unsigned int
+p2mp_iow_flags(const struct multi_context *m);

 /**
  * Main event loop for OpenVPN in UDP server mode.
@@ -40,9 +42,11 @@
  *
  * @param top - Top-level context structure.
  */
+
+
 void tunnel_server_udp(struct context *top);

-
+void multi_process_io_udp(struct multi_context *m);
 /*************************************************************************=
*/
 /**
  * Get, and if necessary create, the multi_instance associated with a
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e9a3945..3522206 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -289,7 +289,7 @@
  * Main initialization function, init multi_context object.
  */
 void
-multi_init(struct multi_context *m, struct context *t, bool tcp_mode)
+multi_init(struct multi_context *m, struct context *t)
 {
     int dev =3D DEV_TYPE_UNDEF;

@@ -435,13 +435,13 @@

     m->instances =3D calloc(m->max_clients, sizeof(struct multi_instance *=
));

+    m->top.c2.event_set =3D t->c2.event_set;
+
     /*
      * Initialize multi-socket TCP I/O wait object
      */
-    if (tcp_mode)
-    {
-        m->mtcp =3D multi_tcp_init(t->options.max_clients, &m->max_clients=
);
-    }
+    m->mtcp =3D multi_tcp_init(t->options.max_clients, &m->max_clients);
+
     m->tcp_queue_limit =3D t->options.tcp_queue_limit;

     /*
@@ -665,7 +665,7 @@
             mi->did_iroutes =3D false;
         }

-        if (m->mtcp)
+        if (m->mtcp && !proto_is_dgram(m->top.options.ce.proto))
         {
             multi_tcp_dereference_instance(m->mtcp, mi);
         }
@@ -776,7 +776,6 @@
         mi->real =3D *real;
         generate_prefix(mi);
     }
-
     mi->did_open_context =3D true;
     inherit_context_child(&mi->context, &m->top, ls);
     if (IS_SIG(&mi->context))
@@ -798,6 +797,7 @@
         {
             goto err;
         }
+        mi->real.proto =3D ls->info.proto;
         generate_prefix(mi);
     }

@@ -4163,6 +4163,92 @@
 }


+void
+tunnel_server_loop(struct multi_context *multi)
+{
+    int status;
+
+    while (true)
+    {
+        perf_push(PERF_EVENT_LOOP);
+
+        /* wait on tun/socket list */
+        multi_get_timeout(multi, &multi->top.c2.timeval);
+        status =3D multi_tcp_wait(&multi->top, multi->mtcp);
+        MULTI_CHECK_SIG(multi);
+
+        /* check on status of coarse timers */
+        multi_process_per_second_timers(multi);
+
+        /* timeout? */
+        if (status > 0)
+        {
+            /* process the I/O which triggered select */
+            multi_tcp_process_io(multi);
+            MULTI_CHECK_SIG(multi);
+        }
+        /*else if (status =3D=3D 0)
+         * {
+         *  multi_tcp_action(multi, NULL, TA_TIMEOUT, false);
+         * }*/
+
+        perf_pop();
+    }
+}
+
+void
+tunnel_server_init(struct context *top)
+{
+    struct multi_context multi;
+
+    top->mode =3D CM_TOP;
+    context_clear_2(top);
+
+    /* initialize top-tunnel instance */
+    init_instance_handle_signals(top, top->es, CC_HARD_USR1_TO_HUP);
+    if (IS_SIG(top))
+    {
+        return;
+    }
+
+    /* initialize global multi_context object */
+    multi_init(&multi, top);
+
+    /* initialize our cloned top object */
+    multi_top_init(&multi, top);
+
+    /* initialize management interface */
+    init_management_callback_multi(&multi);
+
+    /* finished with initialization */
+    initialization_sequence_completed(top, ISC_SERVER); /* --mode server -=
-proto tcp-server */
+
+#ifdef ENABLE_ASYNC_PUSH
+    multi.top.c2.inotify_fd =3D inotify_init();
+    if (multi.top.c2.inotify_fd < 0)
+    {
+        msg(D_MULTI_ERRORS | M_ERRNO, "MULTI: inotify_init error");
+    }
+#endif
+
+    tunnel_server_loop(&multi);
+
+    #ifdef ENABLE_ASYNC_PUSH
+    close(top->c2.inotify_fd);
+#endif
+
+    /* shut down management interface */
+    uninit_management_callback();
+
+    /* save ifconfig-pool */
+    multi_ifconfig_pool_persist(&multi, true);
+
+    /* tear down tunnel instance (unless --persist-tun) */
+    multi_uninit(&multi);
+    multi_top_free(&multi);
+    close_instance(top);
+}
+
 /*
  * Top level event loop.
  */
@@ -4171,12 +4257,6 @@
 {
     ASSERT(top->options.mode =3D=3D MODE_SERVER);

-    if (proto_is_dgram(top->options.ce.proto))
-    {
-        tunnel_server_udp(top);
-    }
-    else
-    {
-        tunnel_server_tcp(top);
-    }
+    tunnel_server_init(top);
+
 }
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 0d4ec63..472c2a3 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -262,7 +262,7 @@
  * Called by mtcp.c, mudp.c, or other (to be written) protocol drivers
  */

-void multi_init(struct multi_context *m, struct context *t, bool tcp_mode);
+void multi_init(struct multi_context *m, struct context *t);

 void multi_uninit(struct multi_context *m);

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9611423..9e800bb 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2188,6 +2188,7 @@
     }

     ALLOC_OBJ_CLEAR_GC(e, struct local_entry, gc);
+    e->proto =3D PROTO_NONE;
     l->array[l->len++] =3D e;

     return e;
@@ -3154,14 +3155,30 @@
         if (ce->proto =3D=3D PROTO_TCP)
         {
             ce->proto =3D PROTO_TCP_SERVER;
+            o->ce.proto =3D ce->proto;
+        }
+        if (ce->local_list)
+        {
+            for (int i =3D 0; i < ce->local_list->len; i++)
+            {
+                if (ce->local_list->array[i]->proto =3D=3D PROTO_TCP)
+                {
+                    ce->local_list->array[i]->proto =3D PROTO_TCP_SERVER;
+                }
+                else if (ce->local_list->array[i]->proto =3D=3D PROTO_NONE)
+                {
+                    ce->local_list->array[i]->proto =3D ce->proto;
+                }
+            }
         }
     }

-    if (o->client)
+    if (o->mode !=3D MODE_SERVER)
     {
         if (ce->proto =3D=3D PROTO_TCP)
         {
             ce->proto =3D PROTO_TCP_CLIENT;
+            o->ce.proto =3D ce->proto;
         }
     }

@@ -3312,6 +3329,10 @@
     {
         le->port =3D o->ce.local_port;
     }
+    if (!le->proto)
+    {
+        le->proto =3D o->ce.proto;
+    }
 }

 #ifdef _WIN32
@@ -3775,6 +3796,7 @@
         ASSERT(e);
         e->port =3D o->ce.local_port;
         e->bind_local =3D o->ce.bind_local;
+        e->proto =3D o->ce.proto;
     }

     /* use the same listen list for every outgoing connection */
@@ -6164,7 +6186,7 @@
         VERIFY_PERMISSION(OPT_P_UP);
         options->ifconfig_nowarn =3D true;
     }
-    else if (streq(p[0], "local") && p[1] && !p[3])
+    else if (streq(p[0], "local") && p[1] && !p[4])
     {
         struct local_entry *e;

@@ -6185,7 +6207,12 @@
         if (p[2])
         {
             e->port =3D p[2];
-            e->bind_local =3D true;
+            /*e->bind_local =3D true; */
+        }
+
+        if (p[3])
+        {
+            e->proto =3D ascii2proto(p[3]);
         }
     }
     else if (streq(p[0], "remote-random") && !p[1])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 747ed56..cba0333 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -99,6 +99,7 @@
     const char *local;
     const char *port;
     bool bind_local;
+    int proto;
 };

 struct connection_entry

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/438?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia122d5cdc42c2969eef6f32f438e30b52652721f
Gerrit-Change-Number: 438
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--fgTefzOcTAw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/438?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Bind to multiple ipv4/ipv6 addresses<br><br>Enables the bindi=
ng of multiple listen<br>sockets based on the specified &quot;--local&quot;=
<br>directives.<br><br>The main server loop has been updated<br>to handle b=
oth TCP and UDP connections.<br><br>The hash function has also been modifie=
d<br>to include the protocol during the<br>creation of new client instances=
.<br><br>Change-Id: Ia122d5cdc42c2969eef6f32f438e30b52652721f<br>Signed-off=
-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M src/open=
vpn/forward.c<br>M src/openvpn/forward.h<br>M src/openvpn/init.c<br>M src/o=
penvpn/mroute.c<br>M src/openvpn/mroute.h<br>M src/openvpn/mtcp.c<br>M src/=
openvpn/mtcp.h<br>M src/openvpn/mudp.c<br>M src/openvpn/mudp.h<br>M src/ope=
nvpn/multi.c<br>M src/openvpn/multi.h<br>M src/openvpn/options.c<br>M src/o=
penvpn/options.h<br>13 files changed, 613 insertions(+), 116 deletions(-)<b=
r><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/43=
8/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</spa=
n><br><span>index 9a6dcd8..27415ee 100644</span><br><span>--- a/src/openvpn=
/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -=
1760,7 +1760,7 @@</span><br><span>             if (c-&gt;options.shaper)</s=
pan><br><span>             {</span><br><span>                 int overhead =
=3D datagram_overhead(c-&gt;c2.to_link_addr-&gt;dest.addr.sa.sa_family,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
                        c-&gt;options.ce.proto);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                              =
   ls-&gt;info.proto);</span><br><span>                 shaper_wrote_bytes(=
&amp;c-&gt;c2.shaper,</span><br><span>                                    B=
LEN(&amp;c-&gt;c2.to_link) + overhead);</span><br><span>             }</spa=
n><br><span>@@ -2050,6 +2050,250 @@</span><br><span>  */</span><br><span> <=
/span><br><span> void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+io_wait_dowork_udp(struct context *c, struct multi_tcp *mtcp, const unsig=
ned int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int socket=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned=
 int tuntap =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct event_set_return esr[4];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* These shifts all depend on EVENT_READ and EVENT_WRITE */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    static uintptr_t socket_shift =
=3D 0;   /* depends on SOCKET_READ and SOCKET_WRITE */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    static uintptr_t tun_shift =3D 2;   =
   /* depends on TUN_READ and TUN_WRITE */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    static uintptr_t err_shift =3D 4;      /* depend=
s on ES_ERROR */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
def ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    static uintptr_t management_shift =3D 6; /* depends on MANAGEMENT_REA=
D and MANAGEMENT_WRITE */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef =
ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  static int file_shift =3D FILE_SHIFT;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    static int dco_shift =3D DCO_SH=
IFT;    /* Event from DCO linux kernel module */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int i;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Decide what kind o=
f events we want to wait for.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /*c-&gt;c2.event_set =3D mtcp-&gt;es; */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /*event_reset(mtcp-&gt;es); */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /*event_reset(c-&gt;c2.event_set)=
; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * On win32 we use the keyboard or an event=
 object as a source</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * of asynchronous signals.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (flags &amp; IOW_WAIT_SIGNAL)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        wait_signal(mtcp-&gt;es, (void *)err_shift);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * If =
outgoing data (for TCP/UDP port) pending, wait for ready-to-send</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * status from TCP/UDP por=
t. Otherwise, wait for incoming data on</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * TUN/TAP device.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (flags &amp; IOW_TO_LINK)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (flags &amp; IOW_SHAPER)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            /*</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+             * If sending this packet would put us over our traf=
fic shaping</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
     * quota, don&#39;t send -- instead compute the delay we must wait</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+             * until it =
will be OK to send the packet.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+             */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            int delay =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         /* set traffic shaping delay in microseconds */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (c-&gt;options.shaper)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                delay =3D =
max_int(delay, shaper_delay(&amp;c-&gt;c2.shaper));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (delay &lt; 1000)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                socket |=3D EVENT_WRITE;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                shaper_soonest_event(&amp;c-&gt;c2.ti=
meval, delay);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            socket |=3D EVENT_WRITE;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    else if (!((flags &amp; IOW_FRAG) &amp;&a=
mp; TO_LINK_FRAG(c)))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
flags &amp; IOW_READ_TUN)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        tuntap |=3D EVENT_READ;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * If outgoing data (for TUN/TAP device)=
 pending, wait for ready-to-send status</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * from device.  Otherwise, wait for incoming data =
on TCP/UDP port.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (flags &=
amp; IOW_TO_TUN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tuntap |=
=3D EVENT_WRITE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (flags &amp; IOW_READ_LINK)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            socket |=3D EVENT_RE=
AD;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * outgoing bcast buffer waiting to be sent?</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (flags &amp; IOW_MBUF)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        socket |=3D EVENT_WRITE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Force=
 wait on TUN input, even if also waiting on TCP/UDP output</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (flags &amp; IOW_READ_TUN_FORCE)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tuntap |=3D EVENT_READ;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (tuntap_is_wintun(c-&gt;c1.tuntap))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /*</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         * With wintun we are only interested in read event. Rin=
g buffer is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
 * always ready for write, so we don&#39;t do wait.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        tuntap =3D EVENT_READ;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Configure event=
 wait based on socket, tuntap flags.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        socket_set(c-&gt;c2.link_sockets[i], mt=
cp-&gt;es, socket,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                  &amp;c-&gt;c2.link_sockets[i]-&gt;ev_arg, NULL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    tun_set(c-&gt;c1.tuntap, c-&gt;c2.eve=
nt_set, tuntap, (void *)tun_shift, NULL);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (socket &amp;=
 EVENT_READ &amp;&amp; c-&gt;c2.did_open_tun)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        dco_event_set(&amp;c-&gt;c1.tuntap-&gt;dco, mtcp-&gt;es=
, (void *)&amp;dco_shift);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (management)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        management_socket_set(management, mtcp-&=
gt;es, (void *)management_shift, NULL);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_ASYNC_PUSH</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* arm inotify wa=
tcher */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&=
gt;options.mode =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        event_ctl(mtcp-&gt;es, c-&gt;c2.inotify_fd, EVENT_READ, (void *)&=
amp;file_shift);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * Possible scenarios:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     *  (1) tcp/udp port has data available to read</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     *  (2) tcp/udp por=
t is ready to accept more data to write</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     *  (3) tun dev has data available to read</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     *  (4) tun dev is ready=
 to accept more data to write</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     *  (5) we received a signal (handler sets signal_received)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *  (6) timeout (=
tv) expired</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    mtcp-&gt;event_set_status =3D ES_ER=
ROR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (!c-&gt;sig-&gt;signal_rece=
ived)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!(flags &amp; IO=
W_CHECK_RESIDUAL) || !sockets_read_residual(c))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            int status;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (check_debug_level(D_EVENT_WAIT))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                show_wait_status(c);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            /*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+             * Wait for something to happen.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+             */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            status =3D event_wait(mtcp-&gt;es, &amp;=
c-&gt;c2.timeval, esr, SIZE(esr));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        check_status(status, &quot;event_wait&quot;, NULL, NULL);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (status &gt; 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                int i;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                mtcp-&gt;event_set_sta=
tus =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       for (i =3D 0; i &lt; status; ++i)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    const struct event_set_return *e =3D=
 &amp;esr[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              uintptr_t shift;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            if (e-&gt;arg &gt;=3D MULTI_N)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        struct event_arg *ev_arg =
=3D (struct event_arg *)e-&gt;arg;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                        if (ev_arg-&gt;type !=3D EVENT_ARG_L=
INK_SOCKET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                          mtcp-&gt;event_set_status =3D ES_ERROR;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                            m=
sg(D_LINK_ERRORS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                              &quot;io_work: non socket event delivered&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
             return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            shift =3D socket_shift;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        /* mark socket so that the multi co=
de knows where we</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                       * have pending i/o */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        ev_arg-&gt;pending =3D tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                shift =3D (uintptr_t)e-&gt;arg;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    mtcp-&gt;event_set_status |=3D ((e-&gt;rwfla=
gs &amp; 3) &lt;&lt; shift);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            else if (status =3D=3D 0)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                mtcp-&gt;event_set_status =3D ES_TIMEOUT;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            mtcp-&gt;event_set_status =3D SOCKET_READ;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* &#39;now&#39; should always be a reasonably up-to-date tim=
estamp */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    update=
_time();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* set signal_received if =
a signal was received */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (mtcp-&gt;event_set_status &amp; ES_ERROR)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        get_signal(&amp;c-&gt;sig-&gt;signal_received)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    dmsg(D_EVENT_WAIT, &quot;I/O WAIT status=3D0x%0=
4x&quot;, mtcp-&gt;event_set_status);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><spa=
n> io_wait_dowork(struct context *c, const unsigned int flags)</span><br><s=
pan> {</span><br><span>     unsigned int socket =3D 0;</span><br><span>@@ -=
2291,6 +2535,7 @@</span><br><span>     dmsg(D_EVENT_WAIT, &quot;I/O WAIT st=
atus=3D0x%04x&quot;, c-&gt;c2.event_set_status);</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> void</span><br><span> process_io(struct context *c, struct link_so=
cket *ls)</span><br><span> {</span><br><span>diff --git a/src/openvpn/forwa=
rd.h b/src/openvpn/forward.h</span><br><span>index 333dcdc..cb184a8 100644<=
/span><br><span>--- a/src/openvpn/forward.h</span><br><span>+++ b/src/openv=
pn/forward.h</span><br><span>@@ -50,6 +50,7 @@</span><br><span> #include &q=
uot;openvpn.h&quot;</span><br><span> #include &quot;occ.h&quot;</span><br><=
span> #include &quot;ping.h&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;mtcp.h&quot;</span><br><span> </span><br><span=
> #define IOW_TO_TUN          (1&lt;&lt;0)</span><br><span> #define IOW_TO_=
LINK         (1&lt;&lt;1)</span><br><span>@@ -68,6 +69,8 @@</span><br><span=
> </span><br><span> extern counter_type link_write_bytes_global;</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void io_wait=
_dowork_udp(struct context *c, struct multi_tcp *mtcp, const unsigned int f=
lags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> void io_wait_dowork(struct context *c, const unsigned int flags);</spa=
n><br><span> </span><br><span> void pre_select(struct context *c);</span><b=
r><span>@@ -363,6 +366,58 @@</span><br><span>     return flags;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static inline void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+io_wait_udp(struct context *c, struct multi_tcp *mtcp, const unsigned =
int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2.fast_io &a=
mp;&amp; (flags &amp; (IOW_TO_TUN|IOW_TO_LINK|IOW_MBUF)))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* fast path -- only for TUN/TAP/UDP writes=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned=
 int ret =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (flags &amp; IOW_TO_TUN)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            ret |=3D TUN_WRITE;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (flags &amp; (IOW_TO_LINK|IOW_MBUF))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            ret |=3D SOCKET_WRITE;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        mtcp-&gt;event_set_status =3D ret;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        bool skip_iowait =3D flags &amp; IOW_TO_TUN;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (flags &amp; IOW_READ_TU=
N)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            /*</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+             * don&#39;t read fr=
om tun if we have pending write to link,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+             * since every tun read overwrites to_link=
 buffer filled</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
        * by previous tun read</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+             */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            skip_iowait =3D !(flags &amp; IOW_TO_LINK);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (tuntap_is_wintun(c-&gt;c1.tun=
tap) &amp;&amp; skip_iowait)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           unsigned int ret =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (flags &amp; IOW_TO_TUN)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                ret |=3D TUN_WRITE;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            if (flags &amp; IOW_READ=
_TUN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ret =
|=3D TUN_READ;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 mtcp-&gt;event_set_status =3D ret;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif /* ifdef _WIN32 */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       /* slow path */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            io_wait_dowork_udp(c, mtcp, flags);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> /*</span><br><span>  * This is the core I/O wait function, used for =
all I/O waits except</span><br><span>  * for TCP in server mode.</span><br>=
<span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>=
index 659c9e3..762793a 100644</span><br><span>--- a/src/openvpn/init.c</spa=
n><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -3791,6 +3791,24 @@=
</span><br><span>     unsigned int sockflags =3D c-&gt;options.sockflags;</=
span><br><span>     int i;</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int mode =3D LS_MODE_DEFAULT;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* mode allows CM_CHILD_TCP</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * instances to inhe=
rit acceptable fds</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * from a top-level parent */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (c-&gt;options.mode =3D=3D MODE_SERVER)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* initializing listening socket */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;mode =
=3D=3D CM_TOP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mod=
e =3D LS_MODE_TCP_LISTEN;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* initializing socket to client */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        else if (c-&gt;mode =3D=3D CM_CHILD_TCP)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            mode =3D LS_MODE_TCP_ACC=
EPT_FROM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if PORT_SHARE</=
span><br><span>     if (c-&gt;options.port_share_host &amp;&amp; c-&gt;opti=
ons.port_share_port)</span><br><span>     {</span><br><span>@@ -3800,33 +38=
18,37 @@</span><br><span> </span><br><span>     for (i =3D 0; i &lt; c-&gt;=
c1.link_sockets_num; i++)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        int mode =3D LS_MODE_DEFAULT;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        const char *host =3D c=
-&gt;options.ce.local_list-&gt;array[i]-&gt;local;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        const char *port =3D c-&gt;options.c=
e.local_list-&gt;array[i]-&gt;port;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        int proto =3D c-&gt;options.ce.local_list-&gt;array=
[i]-&gt;proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   bool bind_local =3D c-&gt;options.ce.local_list-&gt;array[i]-&gt;bind_lo=
cal;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        /* mode allows CM_CHILD_TCP</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-         * instances to inherit acceptable fds</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-         * from a top-level parent =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;o=
ptions.mode =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (c-&gt;mode =3D=3D CM_CHILD_TCP || c-&gt;mode =3D=3D=
 CM_CHILD_UDP)</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            /* initializing listening socket */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            if (c-&gt;mode =
=3D=3D CM_TOP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       const struct link_socket *ls =3D NULL;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            if (c-&gt;mode =3D=3D CM_CHILD_TCP)</=
span><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                mode =3D LS_MODE_TCP_LISTEN;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                ls =3D c-&gt;c2.accept_fr=
om;</span><br><span>             }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            /* initializing socket to client */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            else if (c-&gt;mode =3D=
=3D CM_CHILD_TCP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          else if (c-&gt;mode =3D=3D CM_CHILD_UDP)</span><br><span>        =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 mode =3D LS_MODE_TCP_ACCEPT_FROM;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                ls =3D c-&gt;c2.link_sockets[0];</span><br><=
span>             }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            host =
=3D ls-&gt;local_host;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            port =3D ls-&gt;local_port;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            proto =3D ls-&gt;info.proto;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            bind_local =3D ls-&=
gt;bind_local;</span><br><span>         }</span><br><span> </span><br><span=
>         /* init each socket with its specific port */</span><br><span>   =
      link_socket_init_phase1(c-&gt;c2.link_sockets[i],</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                                c-&gt;opt=
ions.ce.local_list-&gt;array[i]-&gt;local,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                c-&gt;options.ce.local=
_list-&gt;array[i]-&gt;port,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                host,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                port,</span><br>=
<span>                                 c-&gt;options.ce.remote,</span><br><=
span>                                 c-&gt;options.ce.remote_port,</span><=
br><span>                                 c-&gt;c1.dns_cache,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                                c-&=
gt;options.ce.proto,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                proto,</span><br><span>                   =
              c-&gt;options.ce.af,</span><br><span>                        =
         c-&gt;options.ce.bind_ipv6_only,</span><br><span>                 =
                mode,</span><br><span>@@ -3836,7 +3858,7 @@</span><br><span=
> #ifdef ENABLE_DEBUG</span><br><span>                                 c-&g=
t;options.gremlin,</span><br><span> #endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                c-&gt;options.ce.local=
_list-&gt;array[i]-&gt;bind_local,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                bind_local,</span><br><span>=
                                 c-&gt;options.ce.remote_float,</span><br><=
span>                                 &amp;c-&gt;c1.link_socket_addrs[i],</=
span><br><span>                                 c-&gt;options.ipchange,</sp=
an><br><span>@@ -4655,7 +4677,7 @@</span><br><span>     }</span><br><span> =
</span><br><span>     /* our wait-for-i/o objects, different for posix vs. =
win32 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt=
;mode =3D=3D CM_P2P)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (c-&gt;mode =3D=3D CM_P2P || c-&gt;mode =3D=3D CM_TOP)</span><br><s=
pan>     {</span><br><span>         do_event_set_init(c, SHAPER_DEFINED(&am=
p;c-&gt;options));</span><br><span>     }</span><br><span>@@ -4919,7 +4941,=
7 @@</span><br><span>     CLEAR(*dest);</span><br><span> </span><br><span> =
    /* proto_is_dgram will ASSERT(0) if proto is invalid */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    dest-&gt;mode =3D proto_is_dgram(=
src-&gt;options.ce.proto) ? CM_CHILD_UDP : CM_CHILD_TCP;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    dest-&gt;mode =3D proto_is_dgram(l=
s-&gt;info.proto) ? CM_CHILD_UDP : CM_CHILD_TCP;</span><br><span> </span><b=
r><span>     dest-&gt;gc =3D gc_new();</span><br><span> </span><br><span>@@=
 -4947,6 +4969,8 @@</span><br><span>     dest-&gt;options =3D src-&gt;optio=
ns;</span><br><span>     options_detach(&amp;dest-&gt;options);</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dest-&gt;=
c2.event_set =3D src-&gt;c2.event_set;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>     if (dest-&gt;mode =3D=3D CM_CHILD_=
TCP)</span><br><span>     {</span><br><span>         /*</span><br><span>dif=
f --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c</span><br><span>index=
 91af2b6..0017a48 100644</span><br><span>--- a/src/openvpn/mroute.c</span><=
br><span>+++ b/src/openvpn/mroute.c</span><br><span>@@ -421,6 +421,7 @@</sp=
an><br><span>                 {</span><br><span>                     buf_pr=
intf(&amp;out, &quot;:%d&quot;, ntohs(maddr.v4.port));</span><br><span>    =
             }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           buf_printf(&amp;out, &quot;:%d&quot;, maddr.proto);</span><br><s=
pan>             }</span><br><span>             break;</span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h</spa=
n><br><span>index a06e872..7c8972f 100644</span><br><span>--- a/src/openvpn=
/mroute.h</span><br><span>+++ b/src/openvpn/mroute.h</span><br><span>@@ -76=
,6 +76,7 @@</span><br><span>     uint8_t len;    /* length of address */</s=
pan><br><span>     uint8_t unused;</span><br><span>     uint8_t type;   /* =
MR_ADDR/MR_WITH flags */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    uint8_t proto;</span><br><span>     uint8_t netbits; /* number of =
bits in network part of address,</span><br><span>                       * v=
alid if MR_WITH_NETBITS is set */</span><br><span>     union {</span><br><s=
pan>@@ -211,6 +212,10 @@</span><br><span>     {</span><br><span>         re=
turn false;</span><br><span>     }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (a1-&gt;proto !=3D a2-&gt;proto)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span>     if (a1-&gt;netbits !=3D a=
2-&gt;netbits)</span><br><span>     {</span><br><span>         return false=
;</span><br><span>@@ -232,7 +237,7 @@</span><br><span> static inline uint32=
_t</span><br><span> mroute_addr_hash_len(const struct mroute_addr *a)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retu=
rn (uint32_t) a-&gt;len + 2;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return (uint32_t) a-&gt;len + 3;</span><br><span> }</span><br>=
<span> </span><br><span> static inline void</span><br><span>diff --git a/sr=
c/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>index 06073cd..d4ce64=
2 100644</span><br><span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/src=
/openvpn/mtcp.c</span><br><span>@@ -37,21 +37,6 @@</span><br><span> #endif<=
/span><br><span> </span><br><span> /*</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * TCP States</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TA=
_UNDEF                 0</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define TA_SOCKET_READ           1</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define TA_SOCKET_READ_RESIDUAL  2</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define TA_SOCKET_WRITE          3</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define TA_SOCKET_WRITE_READY    =
4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TA_SOCKET_WR=
ITE_DEFERRED 5</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 TA_TUN_READ              6</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define TA_TUN_WRITE             7</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define TA_INITIAL               8</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define TA_TIMEOUT               9</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define TA_TUN_WRITE_TIMEOUT  =
   10</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Special tags p=
assed to event.[ch] functions</span><br><span>  */</span><br><span> #define=
 MTCP_SOCKET      ((void *)1)</span><br><span>@@ -122,8 +107,9 @@</span><br=
><span>     struct hash *hash =3D m-&gt;hash;</span><br><span> </span><br><=
span>     mi =3D multi_create_instance(m, NULL, ls);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (mi)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (mi &amp;&amp; !proto_is_dgram(ls-&gt;info.p=
roto))</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        printf(&quot;\nTCP add\n&quot;);</span><br><span>        =
 struct hash_element *he;</span><br><span>         const uint32_t hv =3D ha=
sh_value(hash, &amp;mi-&gt;real);</span><br><span>         struct hash_buck=
et *bucket =3D hash_bucket(hash, hv);</span><br><span>@@ -174,7 +160,7 @@</=
span><br><span>     ASSERT(mi-&gt;context.c2.link_sockets);</span><br><span=
>     ASSERT(mi-&gt;context.c2.link_sockets[0]);</span><br><span>     ASSER=
T(mi-&gt;context.c2.link_sockets[0]-&gt;info.lsa);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ASSERT(mi-&gt;context.c2.link_sockets[0]-&=
gt;mode =3D=3D LS_MODE_TCP_ACCEPT_FROM);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /*ASSERT(mi-&gt;context.c2.link_sockets[0]-&gt;mod=
e =3D=3D LS_MODE_TCP_ACCEPT_FROM); */</span><br><span>     ASSERT(mi-&gt;co=
ntext.c2.link_sockets[0]-&gt;info.lsa-&gt;actual.dest.addr.sa.sa_family =3D=
=3D AF_INET</span><br><span>            || mi-&gt;context.c2.link_sockets[0=
]-&gt;info.lsa-&gt;actual.dest.addr.sa.sa_family =3D=3D AF_INET6</span><br>=
<span>            );</span><br><span>@@ -259,11 +245,11 @@</span><br><span>=
     }</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-multi_tcp_wait(const struct context *c,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+multi_tcp_wait(struct context *c,</span><br><span>   =
             struct multi_tcp *mtcp)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    int i, status;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int status, i;</span><br><span>     u=
nsigned int *persistent =3D &amp;mtcp-&gt;tun_rwflags;</span><br><span> </s=
pan><br><span>     for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</sp=
an><br><span>@@ -603,7 +589,7 @@</span><br><span>     return newaction;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-static void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void</span><br><span> multi_tcp_action(struct multi_context *m, struct =
multi_instance *mi, int action, bool poll)</span><br><span> {</span><br><sp=
an>     bool tun_input_pending =3D false;</span><br><span>@@ -691,10 +677,1=
4 @@</span><br><span>     } while (action !=3D TA_UNDEF);</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span=
><br><span> multi_tcp_process_io(struct multi_context *m)</span><br><span> =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned=
 int mpp_flags =3D m-&gt;top.c2.fast_io</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                   ? (MPP_CONDITIONAL_P=
RE_SELECT | MPP_CLOSE_ON_SIGNAL)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                   : (MPP_PRE_SELECT | MPP_CLO=
SE_ON_SIGNAL);</span><br><span>     struct multi_tcp *mtcp =3D m-&gt;mtcp;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned i=
nt status =3D mtcp-&gt;event_set_status;</span><br><span>     int i;</span>=
<br><span> </span><br><span>     for (i =3D 0; i &lt; mtcp-&gt;n_esr; ++i)<=
/span><br><span>@@ -735,14 +725,45 @@</span><br><span>                     =
    msg(D_MULTI_ERRORS, &quot;MULTI: mtcp_proc_io: null socket&quot;);</spa=
n><br><span>                         break;</span><br><span>               =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an>                     socket_reset_listen_persistent(ev_arg-&gt;u.ls);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    mi =
=3D multi_create_instance_tcp(m, ev_arg-&gt;u.ls);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    if (mi)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    if (!proto_is_dgra=
m(ev_arg-&gt;u.ls-&gt;info.proto))</span><br><span>                     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 multi_tcp_action(m, mi, TA_INITIAL, false);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        mi =3D multi_create_instan=
ce_tcp(m, ev_arg-&gt;u.ls);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        if (mi)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                            multi_tcp_action(m, m=
i, TA_INITIAL, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        break;</span><br><span>                   =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                    if (status &amp; SOCKET_READ)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                            read_incomi=
ng_link(&amp;m-&gt;top, ev_arg-&gt;u.ls);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                            if (!IS_SIG(&amp;m-&gt;to=
p))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                          multi_process_incoming_link(m, NULL, mpp_flags,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                                       ev_arg-&gt;u.ls);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  multi_get_timeout(m, &amp;m-&gt;top.c2.timeval);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                        io_wait_udp(&amp;m-&=
gt;top, m-&gt;mtcp, p2mp_iow_flags(m));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                        MULTI_CHECK_SIG(m);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                        multi_process_per_second_t=
imers(m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                        if (m=
-&gt;mtcp-&gt;event_set_status =3D=3D ES_TIMEOUT)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                            multi_proce=
ss_timeout(m, MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                        else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
        multi_process_io_udp(m);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                            MULTI_CHECK_SIG(m);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                        break;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><spa=
n>             }</span><br><span>         }</span><br><span>         else</=
span><br><span>@@ -838,7 +859,7 @@</span><br><span>     }</span><br><span> =
</span><br><span>     /* initialize global multi_context object */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    multi_init(&amp;multi, top=
, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_i=
nit(&amp;multi, top);</span><br><span> </span><br><span>     /* initialize =
our cloned top object */</span><br><span>     multi_top_init(&amp;multi, to=
p);</span><br><span>@@ -874,12 +895,12 @@</span><br><span>         if (stat=
us &gt; 0)</span><br><span>         {</span><br><span>             /* proce=
ss the I/O which triggered select */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            multi_tcp_process_io(&amp;multi);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            /*multi_tcp_process_io=
(&amp;multi); */</span><br><span>             MULTI_CHECK_SIG(&amp;multi);<=
/span><br><span>         }</span><br><span>         else if (status =3D=3D =
0)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            multi_tcp_action(&amp;multi, NULL, TA_TIMEOUT, false);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /*multi_=
tcp_action(&amp;multi, NULL, TA_TIMEOUT, false); */</span><br><span>       =
  }</span><br><span> </span><br><span>         perf_pop();</span><br><span>=
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h</span><br><span>index =
bacf723..b2fdb6e 100644</span><br><span>--- a/src/openvpn/mtcp.h</span><br>=
<span>+++ b/src/openvpn/mtcp.h</span><br><span>@@ -31,6 +31,21 @@</span><br=
><span> #include &quot;event.h&quot;</span><br><span> </span><br><span> /*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * TCP States</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define TA_UNDEF                 0</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define TA_SOCKET_READ    =
       1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TA_=
SOCKET_READ_RESIDUAL  2</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define TA_SOCKET_WRITE          3</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define TA_SOCKET_WRITE_READY    4</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define TA_SOCKET_WRITE_DEFERRED 5</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define TA_TUN_READ       =
       6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TA_=
TUN_WRITE             7</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define TA_INITIAL               8</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define TA_TIMEOUT               9</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define TA_TUN_WRITE_TIMEOUT     10</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/*</span><br><span>  * Extra state info need=
ed for TCP mode</span><br><span>  */</span><br><span> struct multi_tcp</spa=
n><br><span>@@ -40,6 +55,7 @@</span><br><span>     int n_esr;</span><br><sp=
an>     int maxevents;</span><br><span>     unsigned int tun_rwflags;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int event_se=
t_status;</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     un=
signed int management_persist_flags;</span><br><span> #endif</span><br><spa=
n>@@ -58,6 +74,13 @@</span><br><span> </span><br><span> void multi_tcp_inst=
ance_specific_free(struct multi_instance *mi);</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+int multi_tcp_wait(struct cont=
ext *c, struct multi_tcp *mtcp);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void m=
ulti_tcp_process_io(struct multi_context *m);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void multi_tcp_action(struct multi_context *m, struct multi_instance=
 *mi, int action, bool poll);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> void multi_tcp_link_out_deferred(struct multi_context *m, struct m=
ulti_instance *mi);</span><br><span> </span><br><span> </span><br><span>dif=
f --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index dd4=
5720..e9182c8 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><sp=
an>+++ b/src/openvpn/mudp.c</span><br><span>@@ -192,10 +192,12 @@</span><br=
><span>     struct mroute_addr real;</span><br><span>     struct multi_inst=
ance *mi =3D NULL;</span><br><span>     struct hash *hash =3D m-&gt;hash;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    real.proto =3D ls=
-&gt;info.proto;</span><br><span> </span><br><span>     if (mroute_extract_=
openvpn_sockaddr(&amp;real, &amp;m-&gt;top.c2.from.dest, true)</span><br><s=
pan>         &amp;&amp; m-&gt;top.c2.buf.len &gt; 0)</span><br><span>     {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*real.prot=
o =3D ls-&gt;info.proto; */</span><br><span>         struct hash_element *h=
e;</span><br><span>         const uint32_t hv =3D hash_value(hash, &amp;rea=
l);</span><br><span>         struct hash_bucket *bucket =3D hash_bucket(has=
h, hv);</span><br><span>@@ -318,18 +320,68 @@</span><br><span>         msg_=
set_prefix(&quot;Connection Attempt&quot;);</span><br><span>         m-&gt;=
top.c2.to_link =3D m-&gt;hmac_reply;</span><br><span>         m-&gt;top.c2.=
to_link_addr =3D m-&gt;hmac_reply_dest;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        process_outgoing_link(&amp;m-&gt;top, m-&gt;top.c=
2.link_sockets[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        for (int i =3D 0; i &lt; m-&gt;top.c1.link_sockets_num; i++)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            if (!proto_is_dgram(m-&g=
t;top.c2.link_sockets[i]-&gt;info.proto))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                continue;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         process_outgoing_link(&amp;m-&gt;top, m-&gt;top.c2.link_sockets[i]=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span>         m-&gt;hmac_reply_dest =3D NULL;</span><br><span>     }</s=
pan><br><span> }</span><br><span> </span><br><span> /*</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Return the io_wait() flags appropriat=
e for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * a point-to-=
multipoint tunnel.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+p2mp_iow_flags(const str=
uct multi_context *m)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int=
 flags =3D IOW_WAIT_SIGNAL;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (m-&gt;pending)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (TUN_OUT(&amp;m-&gt;pending-&gt;context))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            flags |=3D IOW_TO_TUN;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (LINK_OUT(&amp;m-&gt;pending-&gt;contex=
t))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            flags |=3D IOW=
_TO_LINK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else if (mbuf_defined(m-&gt;mb=
uf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        flags |=3D IOW_MBUF;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else if (m-&gt;hmac_reply_dest=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        flags |=3D IOW_TO_LINK;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        flags |=3D IOW_READ;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (tuntap_ring_empty(m-&gt;top.c1.tuntap))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        flags &amp;=3D ~IOW_READ_TUN;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return flags;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span>  * Proce=
ss an I/O event.</span><br><span>  */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void</span><br><span> multi_process_io_udp(struct multi_context *m)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const unsigned int status =3D m-&gt;top.c2.event_set_status;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const unsigned int status =
=3D m-&gt;mtcp-&gt;event_set_status;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /*p2mp_iow_flags(m); */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /*m-&gt;top.c2.event_set_status; */</span><br>=
<span>     const unsigned int mpp_flags =3D m-&gt;top.c2.fast_io</span><br>=
<span>                                    ? (MPP_CONDITIONAL_PRE_SELECT | M=
PP_CLOSE_ON_SIGNAL)</span><br><span>                                    : (=
MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span>@@ -428,47 +480,6 @@=
</span><br><span> #endif</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * Return the io_wait() flags appropriate for</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * a point-to-multipoint tunne=
l.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-static inline unsigned int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-p2mp_iow_flags(const struct mult=
i_context *m)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int flags =3D I=
OW_WAIT_SIGNAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (m-&gt;pending)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (TUN_OUT(&=
amp;m-&gt;pending-&gt;context))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          flags |=3D IOW_TO_TUN;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (LINK_OUT(&amp;m-&gt;pending-&gt;context))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            flags |=3D IOW_TO_LINK;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    else if (mbuf_defined(m-&gt;mbuf))</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        flags |=3D IOW_MBUF;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  else if (m-&gt;hmac_reply_dest)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    flags |=3D IOW_TO_LINK;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        flags |=3D IOW_READ;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (tuntap_ring_empty(m-&gt;top.c1.tuntap))</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        flags &amp;=3D ~IOW_READ_TUN;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    return flags;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><b=
r><span> tunnel_server_udp(struct context *top)</span><br><span> {</span><b=
r><span>@@ -485,7 +496,7 @@</span><br><span>     }</span><br><span> </span>=
<br><span>     /* initialize global multi_context object */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    multi_init(&amp;multi, top, false=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_init(&a=
mp;multi, top);</span><br><span> </span><br><span>     /* initialize our cl=
oned top object */</span><br><span>     multi_top_init(&amp;multi, top);</s=
pan><br><span>@@ -511,7 +522,7 @@</span><br><span> </span><br><span>       =
  /* set up and do the io_wait() */</span><br><span>         multi_get_time=
out(&amp;multi, &amp;multi.top.c2.timeval);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        io_wait(&amp;multi.top, p2mp_iow_flags(&amp;m=
ulti));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*io=
_wait(&amp;multi.top, p2mp_iow_flags(&amp;multi)); */</span><br><span>     =
    MULTI_CHECK_SIG(&amp;multi);</span><br><span> </span><br><span>        =
 /* check on status of coarse timers */</span><br><span>@@ -525,7 +536,7 @@=
</span><br><span>         else</span><br><span>         {</span><br><span> =
            /* process I/O */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            multi_process_io_udp(&amp;multi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /*multi_process_io_udp(&amp;m=
ulti); */</span><br><span>             MULTI_CHECK_SIG(&amp;multi);</span><=
br><span>         }</span><br><span> </span><br><span>diff --git a/src/open=
vpn/mudp.h b/src/openvpn/mudp.h</span><br><span>index 1088246..75e5a5e 1006=
44</span><br><span>--- a/src/openvpn/mudp.h</span><br><span>+++ b/src/openv=
pn/mudp.h</span><br><span>@@ -31,6 +31,8 @@</span><br><span> struct context=
;</span><br><span> struct multi_context;</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+unsigned int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+p2mp_iow_flags(const struct multi_context=
 *m);</span><br><span> </span><br><span> /**</span><br><span>  * Main event=
 loop for OpenVPN in UDP server mode.</span><br><span>@@ -40,9 +42,11 @@</s=
pan><br><span>  *</span><br><span>  * @param top - Top-level context struct=
ure.</span><br><span>  */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> void tunnel_server_udp(struct context *top);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void multi_process_io_udp(struct multi_context *=
m);</span><br><span> /*****************************************************=
*********************/</span><br><span> /**</span><br><span>  * Get, and if=
 necessary create, the multi_instance associated with a</span><br><span>dif=
f --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index e=
9a3945..3522206 100644</span><br><span>--- a/src/openvpn/multi.c</span><br>=
<span>+++ b/src/openvpn/multi.c</span><br><span>@@ -289,7 +289,7 @@</span><=
br><span>  * Main initialization function, init multi_context object.</span=
><br><span>  */</span><br><span> void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-multi_init(struct multi_context *m, struct context *t, bool=
 tcp_mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_ini=
t(struct multi_context *m, struct context *t)</span><br><span> {</span><br>=
<span>     int dev =3D DEV_TYPE_UNDEF;</span><br><span> </span><br><span>@@=
 -435,13 +435,13 @@</span><br><span> </span><br><span>     m-&gt;instances =
=3D calloc(m-&gt;max_clients, sizeof(struct multi_instance *));</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;top=
.c2.event_set =3D t-&gt;c2.event_set;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>     /*</span><br><span>      * Initiali=
ze multi-socket TCP I/O wait object</span><br><span>      */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (tcp_mode)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        m-&gt;mtcp =3D multi_tcp_init(t-&gt;options.max_=
clients, &amp;m-&gt;max_clients);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  m-&gt;mtcp =3D multi_tcp_init(t-&gt;options.max_clients, &amp;m-&gt;max_c=
lients);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>     m-&gt;tcp_queue_limit =3D t-&gt;options.tcp_queue_limit;</span><=
br><span> </span><br><span>     /*</span><br><span>@@ -665,7 +665,7 @@</spa=
n><br><span>             mi-&gt;did_iroutes =3D false;</span><br><span>    =
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (m-&gt;mtcp)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (m-&gt;mtcp &amp;&amp; !proto_is_dgram(m-&gt;top.options.=
ce.proto))</span><br><span>         {</span><br><span>             multi_tc=
p_dereference_instance(m-&gt;mtcp, mi);</span><br><span>         }</span><b=
r><span>@@ -776,7 +776,6 @@</span><br><span>         mi-&gt;real =3D *real;=
</span><br><span>         generate_prefix(mi);</span><br><span>     }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     mi-&g=
t;did_open_context =3D true;</span><br><span>     inherit_context_child(&am=
p;mi-&gt;context, &amp;m-&gt;top, ls);</span><br><span>     if (IS_SIG(&amp=
;mi-&gt;context))</span><br><span>@@ -798,6 +797,7 @@</span><br><span>     =
    {</span><br><span>             goto err;</span><br><span>         }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;real.pro=
to =3D ls-&gt;info.proto;</span><br><span>         generate_prefix(mi);</sp=
an><br><span>     }</span><br><span> </span><br><span>@@ -4163,6 +4163,92 @=
@</span><br><span> }</span><br><span> </span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+tunnel_server_loop(struct multi_context *multi)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int status;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    while (true)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  perf_push(PERF_EVENT_LOOP);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /=
* wait on tun/socket list */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        multi_get_timeout(multi, &amp;multi-&gt;top.c2.timeval);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        status =3D mu=
lti_tcp_wait(&amp;multi-&gt;top, multi-&gt;mtcp);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        MULTI_CHECK_SIG(multi);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /* check on status of coarse timers */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi_process_per=
_second_timers(multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* timeo=
ut? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (s=
tatus &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* p=
rocess the I/O which triggered select */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            multi_tcp_process_io(multi);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            MULTI_CHECK_SIG(multi=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        /*else if (status =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *=
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         *  multi=
_tcp_action(multi, NULL, TA_TIMEOUT, false);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+         * }*/</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        perf_pop();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+tunnel_server_init(struct context *top)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct multi_context multi;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    top-&gt;mode =3D CM_TOP;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    context_clear_2(top);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* initialize top-tunnel instance */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    init_instance_handle_signals(top, top-&gt;es, CC_=
HARD_USR1_TO_HUP);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (IS_SIG(top))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* initialize global multi_context object */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_init(&amp;mu=
lti, top);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* initialize our cloned=
 top object */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
ulti_top_init(&amp;multi, top);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
initialize management interface */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    init_management_callback_multi(&amp;multi);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* finished with initialization */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    initialization_sequence_comp=
leted(top, ISC_SERVER); /* --mode server --proto tcp-server */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    multi.top.c2.inotify_fd =3D inotify_init()=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi.top.=
c2.inotify_fd &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
D_MULTI_ERRORS | M_ERRNO, &quot;MULTI: inotify_init error&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    tunnel_server_loop(&amp;multi);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   #ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    close(top-&gt;c2.inotify_fd);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* shu=
t down management interface */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    uninit_management_callback();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* save ifconfig-pool */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    multi_ifconfig_pool_persist(&amp;multi, true);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* tear down tunnel instance (unless --persi=
st-tun) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi=
_uninit(&amp;multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    multi_top_free(&amp;multi);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    close_instance(top);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> /*</span><br><span>  * Top level event loop.</span><br><s=
pan>  */</span><br><span>@@ -4171,12 +4257,6 @@</span><br><span> {</span><b=
r><span>     ASSERT(top-&gt;options.mode =3D=3D MODE_SERVER);</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (proto_is_=
dgram(top-&gt;options.ce.proto))</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   tunnel_server_udp(top);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        tunnel_server_tcp(top);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    tunnel_server_init(top);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> }</span><br><span=
>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br><span>ind=
ex 0d4ec63..472c2a3 100644</span><br><span>--- a/src/openvpn/multi.h</span>=
<br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -262,7 +262,7 @@</sp=
an><br><span>  * Called by mtcp.c, mudp.c, or other (to be written) protoco=
l drivers</span><br><span>  */</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-void multi_init(struct multi_context *m, struct =
context *t, bool tcp_mode);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void multi_init(struct multi_context *m, struct context *t);</span>=
<br><span> </span><br><span> void multi_uninit(struct multi_context *m);</s=
pan><br><span> </span><br><span>diff --git a/src/openvpn/options.c b/src/op=
envpn/options.c</span><br><span>index 9611423..9e800bb 100644</span><br><sp=
an>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c<=
/span><br><span>@@ -2188,6 +2188,7 @@</span><br><span>     }</span><br><spa=
n> </span><br><span>     ALLOC_OBJ_CLEAR_GC(e, struct local_entry, gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    e-&gt;proto =3D PRO=
TO_NONE;</span><br><span>     l-&gt;array[l-&gt;len++] =3D e;</span><br><sp=
an> </span><br><span>     return e;</span><br><span>@@ -3154,14 +3155,30 @@=
</span><br><span>         if (ce-&gt;proto =3D=3D PROTO_TCP)</span><br><spa=
n>         {</span><br><span>             ce-&gt;proto =3D PROTO_TCP_SERVER=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;=
ce.proto =3D ce-&gt;proto;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (ce-&gt;local_list)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          for (int i =3D 0; i &lt; ce-&gt;local_list-&gt;len; i++)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                if (ce-&gt;local_l=
ist-&gt;array[i]-&gt;proto =3D=3D PROTO_TCP)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    ce-&gt;local_list-&gt;array[i]-&=
gt;proto =3D PROTO_TCP_SERVER;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                else if (ce-&gt;local_list-&gt;array[i]-&gt;proto =
=3D=3D PROTO_NONE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 ce-&gt;local_list-&gt;array[i]-&gt;proto =3D ce-&gt;proto;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><=
br><span>         }</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;client)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;mode !=3D MODE_SERVE=
R)</span><br><span>     {</span><br><span>         if (ce-&gt;proto =3D=3D =
PROTO_TCP)</span><br><span>         {</span><br><span>             ce-&gt;p=
roto =3D PROTO_TCP_CLIENT;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            o-&gt;ce.proto =3D ce-&gt;proto;</span><br><span>       =
  }</span><br><span>     }</span><br><span> </span><br><span>@@ -3312,6 +33=
29,10 @@</span><br><span>     {</span><br><span>         le-&gt;port =3D o-=
&gt;ce.local_port;</span><br><span>     }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (!le-&gt;proto)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        le-&gt;proto =3D o-&gt;ce.proto;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br><span>=
 </span><br><span> #ifdef _WIN32</span><br><span>@@ -3775,6 +3796,7 @@</spa=
n><br><span>         ASSERT(e);</span><br><span>         e-&gt;port =3D o-&=
gt;ce.local_port;</span><br><span>         e-&gt;bind_local =3D o-&gt;ce.bi=
nd_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e-=
&gt;proto =3D o-&gt;ce.proto;</span><br><span>     }</span><br><span> </spa=
n><br><span>     /* use the same listen list for every outgoing connection =
*/</span><br><span>@@ -6164,7 +6186,7 @@</span><br><span>         VERIFY_PE=
RMISSION(OPT_P_UP);</span><br><span>         options-&gt;ifconfig_nowarn =
=3D true;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    else if (streq(p[0], &quot;local&quot;) &amp;&amp; p[1] &amp=
;&amp; !p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    el=
se if (streq(p[0], &quot;local&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</sp=
an><br><span>     {</span><br><span>         struct local_entry *e;</span><=
br><span> </span><br><span>@@ -6185,7 +6207,12 @@</span><br><span>         =
if (p[2])</span><br><span>         {</span><br><span>             e-&gt;por=
t =3D p[2];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  e-&gt;bind_local =3D true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            /*e-&gt;bind_local =3D true; */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     e-&gt;proto =3D ascii2proto(p[3]);</span><br><span>         }</span><b=
r><span>     }</span><br><span>     else if (streq(p[0], &quot;remote-rando=
m&quot;) &amp;&amp; !p[1])</span><br><span>diff --git a/src/openvpn/options=
.h b/src/openvpn/options.h</span><br><span>index 747ed56..cba0333 100644</s=
pan><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn=
/options.h</span><br><span>@@ -99,6 +99,7 @@</span><br><span>     const cha=
r *local;</span><br><span>     const char *port;</span><br><span>     bool =
bind_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
proto;</span><br><span> };</span><br><span> </span><br><span> struct connec=
tion_entry</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/438?usp=3Demail">change 438</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/438?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia122d5cdc42c2969eef6f32f438=
e30b52652721f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 438 </div>
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


--fgTefzOcTAw=--

