From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 26 Oct 2025 21:50:24 +0000
In-Reply-To: <gerrit.1761487758000.I5bb666a73b4381066e86f53d957e1987fa07303b@...2715...>
References: <gerrit.1761487758000.I5bb666a73b4381066e86f53d957e1987fa07303b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., steffan@...1856...
Message-ID: <4ca51b260fad9527cb6480604d3224b57aa2afbc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="w1pvwflIiX0="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove perf.c/perf.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: syzzer <steffan@...1856...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--w1pvwflIiX0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
03?usp=3Demail )

Change subject: Remove perf.c/perf.h
......................................................................

Remove perf.c/perf.h

This code was always disabled by ENABLE_PERFORMANCE_METRICS being
commented out in perf.h. There was no configure flag. None of the
active developers remembers using it, the git log shows no actual
code changes since at least the project structure overhaul of 2012,
and tools like gprof are nowadays the go-to tool for performance
profiling. So, out with our custom implementation.

This was triggered by a bug report submitted by Joshua Rogers, who
used ZeroPath to discover we missed a perf_pop() call in one of the
error paths of ssl_mbedtls.c. This commit resolves that using git rm.

Change-Id: I5bb666a73b4381066e86f53d957e1987fa07303b
Signed-off-by: Steffan Karger <steffan@...1856...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1303
Message-Id: <20251026142100.12147-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
868.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M src/openvpn/Makefile.am
M src/openvpn/error.c
M src/openvpn/event.h
M src/openvpn/forward.c
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/multi_io.c
M src/openvpn/openvpn.c
M src/openvpn/openvpn.h
D src/openvpn/perf.c
D src/openvpn/perf.h
M src/openvpn/ssl.c
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_openssl.c
M src/openvpn/status.c
16 files changed, 0 insertions(+), 496 deletions(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index 23fb4a5..5954a6e 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -519,8 +519,6 @@
     src/openvpn/ovpn_dco_win.h
     src/openvpn/packet_id.c
     src/openvpn/packet_id.h
-    src/openvpn/perf.c
-    src/openvpn/perf.h
     src/openvpn/ping.c
     src/openvpn/ping.h
     src/openvpn/pkcs11.c
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index e44fb2b..dc58cd1 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -112,7 +112,6 @@
 	options_parse.c \
 	otime.c otime.h \
 	packet_id.c packet_id.h \
-	perf.c perf.h \
 	ping.c ping.h \
 	plugin.c plugin.h \
 	pool.c pool.h \
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 58c2fd1..735d259 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -34,7 +34,6 @@
 #include "socket.h"
 #include "tun.h"
 #include "otime.h"
-#include "perf.h"
 #include "status.h"
 #include "integer.h"
 #include "ps.h"
@@ -734,11 +733,6 @@
             abort();
         }
 #endif
-
-        if (status =3D=3D OPENVPN_EXIT_STATUS_GOOD)
-        {
-            perf_output_results();
-        }
     }

     exit(status);
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 8a89a25..f6aa9c4 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -25,7 +25,6 @@

 #include "win32.h"
 #include "sig.h"
-#include "perf.h"

 /*
  * rwflags passed to event_ctl and returned by
@@ -189,9 +188,7 @@
 event_wait(struct event_set *es, const struct timeval *tv, struct event_se=
t_return *out, int outlen)
 {
     int ret;
-    perf_push(PERF_IO_WAIT);
     ret =3D (*es->func.wait)(es, tv, out, outlen);
-    perf_pop();
     return ret;
 }
=20
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 79a6fc7..7f72000 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -932,8 +932,6 @@

     /*ASSERT (!c->c2.to_tun.len);*/

-    perf_push(PERF_READ_IN_LINK);
-
     c->c2.buf =3D c->c2.buffers->read_link_buf;
     ASSERT(buf_init(&c->c2.buf, c->c2.frame.buf.headroom));

@@ -966,7 +964,6 @@
                 msg(D_STREAM_ERRORS, "Connection reset, restarting [%d]", =
status);
             }
         }
-        perf_pop();
         return;
     }

@@ -983,8 +980,6 @@

     /* Remove socks header if applicable */
     socks_postprocess_incoming_link(c, sock);
-
-    perf_pop();
 }

 bool
@@ -1212,15 +1207,11 @@
 static void
 process_incoming_link(struct context *c, struct link_socket *sock)
 {
-    perf_push(PERF_PROC_IN_LINK);
-
     struct link_socket_info *lsi =3D &sock->info;
     const uint8_t *orig_buf =3D c->c2.buf.data;

     process_incoming_link_part1(c, lsi, false);
     process_incoming_link_part2(c, lsi, orig_buf);
-
-    perf_pop();
 }

 void
@@ -1326,8 +1317,6 @@
      */
     /*ASSERT (!c->c2.to_link.len);*/

-    perf_push(PERF_READ_IN_TUN);
-
     c->c2.buf =3D c->c2.buffers->read_tun_buf;

 #ifdef _WIN32
@@ -1360,7 +1349,6 @@
     {
         register_signal(c->sig, SIGTERM, "tun-stop");
         msg(M_INFO, "TUN/TAP interface has been stopped, exiting");
-        perf_pop();
         return;
     }

@@ -1370,14 +1358,11 @@
         register_signal(c->sig, SIGHUP, "tun-abort");
         c->persist.restart_sleep_seconds =3D 10;
         msg(M_INFO, "TUN/TAP I/O operation aborted, restarting");
-        perf_pop();
         return;
     }

     /* Check the status return from read() */
     check_status(c->c2.buf.len, "read from TUN/TAP", NULL, c->c1.tuntap);
-
-    perf_pop();
 }

 /**
@@ -1497,8 +1482,6 @@
 {
     struct gc_arena gc =3D gc_new();

-    perf_push(PERF_PROC_IN_TUN);
-
     if (c->c2.buf.len > 0)
     {
         c->c2.tun_read_bytes +=3D c->c2.buf.len;
@@ -1542,7 +1525,6 @@
     {
         buf_reset(&c->c2.to_link);
     }
-    perf_pop();
     gc_free(&gc);
 }

@@ -1770,8 +1752,6 @@
     struct gc_arena gc =3D gc_new();
     int error_code =3D 0;

-    perf_push(PERF_PROC_OUT_LINK);
-
     if (c->c2.to_link.len > 0 && c->c2.to_link.len <=3D c->c2.frame.buf.pa=
yload_size)
     {
         /*
@@ -1899,7 +1879,6 @@

     buf_reset(&c->c2.to_link);

-    perf_pop();
     gc_free(&gc);
 }

@@ -1919,8 +1898,6 @@
         return;
     }

-    perf_push(PERF_PROC_OUT_TUN);
-
     /*
      * The --mssfix option requires
      * us to examine the IP header (IPv4 or IPv6).
@@ -1993,8 +1970,6 @@
     }

     buf_reset(&c->c2.to_tun);
-
-    perf_pop();
 }

 #if defined(__GNUC__) || defined(__clang__)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index fa9c654..f60944d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -580,8 +580,6 @@
 void
 multi_close_instance(struct multi_context *m, struct multi_instance *mi, b=
ool shutdown)
 {
-    perf_push(PERF_MULTI_CLOSE_INSTANCE);
-
     ASSERT(!mi->halt);
     mi->halt =3D true;
     bool is_dgram =3D proto_is_dgram(mi->context.c2.link_sockets[0]->info.=
proto);
@@ -672,8 +670,6 @@
      * vhash reaper deal with it.
      */
     multi_instance_dec_refcount(mi);
-
-    perf_pop();
 }

 /*
@@ -734,8 +730,6 @@
     struct gc_arena gc =3D gc_new();
     struct multi_instance *mi;

-    perf_push(PERF_MULTI_CREATE_INSTANCE);
-
     msg(D_MULTI_MEDIUM, "MULTI: multi_create_instance called");

     ALLOC_OBJ_CLEAR(mi, struct multi_instance);
@@ -807,13 +801,11 @@
     mi->ev_arg.type =3D EVENT_ARG_MULTI_INSTANCE;
     mi->ev_arg.u.mi =3D mi;

-    perf_pop();
     gc_free(&gc);
     return mi;

 err:
     multi_close_instance(m, mi, false);
-    perf_pop();
     gc_free(&gc);
     return NULL;
 }
@@ -2907,7 +2899,6 @@

     if (BLEN(buf) > 0)
     {
-        perf_push(PERF_MULTI_BCAST);
 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("BCAST len=3D%d\n", BLEN(buf));
 #endif
@@ -2929,7 +2920,6 @@

         hash_iterator_free(&hi);
         mbuf_free_buf(mb);
-        perf_pop();
     }
 }

@@ -3399,7 +3389,6 @@
=20
             /* decrypt in instance context */

-            perf_push(PERF_PROC_IN_LINK);
             lsi =3D &sock->info;
             orig_buf =3D c->c2.buf.data;
             if (process_incoming_link_part1(c, lsi, floated))
@@ -3412,7 +3401,6 @@

                 process_incoming_link_part2(c, lsi, orig_buf);
             }
-            perf_pop();

             if (TUNNEL_TYPE(m->top.c1.tuntap) =3D=3D DEV_TYPE_TUN)
             {
@@ -4180,8 +4168,6 @@

     while (true)
     {
-        perf_push(PERF_EVENT_LOOP);
-
         /* wait on tun/socket list */
         multi_get_timeout(multi, &multi->top.c2.timeval);
         status =3D multi_io_wait(multi);
@@ -4202,7 +4188,6 @@
         }

         MULTI_CHECK_SIG(multi);
-        perf_pop();
     }
 }

diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 97bbc4a..594ea3a 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -38,7 +38,6 @@
 #include "mudp.h"
 #include "mtcp.h"
 #include "multi_io.h"
-#include "perf.h"
 #include "vlan.h"
 #include "reflect_filter.h"

diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 0bfbb63..6e31687 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -242,9 +242,7 @@
             tun_input_pending =3D NULL;
             /* For some reason, the Linux 2.2 TUN/TAP driver hits this tim=
eout */
             c->c2.timeval.tv_sec =3D 1;
-            perf_push(PERF_PROC_OUT_TUN_MTCP);
             io_wait(c, IOW_TO_TUN);
-            perf_pop();
             break;

         case TA_SOCKET_WRITE:
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 64b4f8c..eaaa59b 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -72,8 +72,6 @@
     /* main event loop */
     while (true)
     {
-        perf_push(PERF_EVENT_LOOP);
-
         /* process timers, TLS, etc. */
         pre_select(c);
         P2P_CHECK_SIG();
@@ -85,15 +83,12 @@
         /* timeout? */
         if (c->c2.event_set_status =3D=3D ES_TIMEOUT)
         {
-            perf_pop();
             continue;
         }

         /* process the I/O which triggered select */
         process_io(c, c->c2.link_sockets[0]);
         P2P_CHECK_SIG();
-
-        perf_pop();
     }

     persist_client_stats(c);
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index cd99cd4..a198fcf 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -524,7 +524,6 @@
     if (IS_SIG(c))                            \
     {                                         \
         const int brk =3D func(arg);            \
-        perf_pop();                           \
         if (brk)                              \
         {                                     \
             break;                            \
diff --git a/src/openvpn/perf.c b/src/openvpn/perf.c
deleted file mode 100644
index 51c1a97..0000000
--- a/src/openvpn/perf.c
+++ /dev/null
@@ -1,306 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, see <https://www.gnu.org/licenses/>.
- */
-
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#endif
-
-#include "syshead.h"
-
-#include "perf.h"
-
-#ifdef ENABLE_PERFORMANCE_METRICS
-
-#include "error.h"
-#include "otime.h"
-
-#include "memdbg.h"
-
-static const char *metric_names[] =3D { "PERF_BIO_READ_PLAINTEXT",
-                                      "PERF_BIO_WRITE_PLAINTEXT",
-                                      "PERF_BIO_READ_CIPHERTEXT",
-                                      "PERF_BIO_WRITE_CIPHERTEXT",
-                                      "PERF_TLS_MULTI_PROCESS",
-                                      "PERF_IO_WAIT",
-                                      "PERF_EVENT_LOOP",
-                                      "PERF_MULTI_CREATE_INSTANCE",
-                                      "PERF_MULTI_CLOSE_INSTANCE",
-                                      "PERF_MULTI_SHOW_STATS",
-                                      "PERF_MULTI_BCAST",
-                                      "PERF_MULTI_MCAST",
-                                      "PERF_SCRIPT",
-                                      "PERF_READ_IN_LINK",
-                                      "PERF_PROC_IN_LINK",
-                                      "PERF_READ_IN_TUN",
-                                      "PERF_PROC_IN_TUN",
-                                      "PERF_PROC_OUT_LINK",
-                                      "PERF_PROC_OUT_TUN",
-                                      "PERF_PROC_OUT_TUN_MTCP" };
-
-struct perf
-{
-#define PS_INITIAL           0
-#define PS_METER_RUNNING     1
-#define PS_METER_INTERRUPTED 2
-    int state;
-
-    struct timeval start;
-    double sofar;
-    double sum;
-    double max;
-    double count;
-};
-
-struct perf_set
-{
-    int stack_len;
-    int stack[STACK_N];
-    struct perf perf[PERF_N];
-};
-
-static struct perf_set perf_set;
-
-static void perf_print_state(int lev);
-
-static inline int
-get_stack_index(int sdelta)
-{
-    const int sindex =3D perf_set.stack_len + sdelta;
-    if (sindex >=3D 0 && sindex < STACK_N)
-    {
-        return sindex;
-    }
-    else
-    {
-        return -1;
-    }
-}
-
-static int
-get_perf_index(int sdelta)
-{
-    const int sindex =3D get_stack_index(sdelta);
-    if (sindex >=3D 0)
-    {
-        const int pindex =3D perf_set.stack[sindex];
-        if (pindex >=3D 0 && pindex < PERF_N)
-        {
-            return pindex;
-        }
-        else
-        {
-            return -1;
-        }
-    }
-    else
-    {
-        return -1;
-    }
-}
-
-static struct perf *
-get_perf(int sdelta)
-{
-    const int pindex =3D get_perf_index(sdelta);
-    if (pindex >=3D 0)
-    {
-        return &perf_set.perf[pindex];
-    }
-    else
-    {
-        return NULL;
-    }
-}
-
-static void
-push_perf_index(int pindex)
-{
-    const int sindex =3D get_stack_index(0);
-    const int newlen =3D get_stack_index(1);
-    if (sindex >=3D 0 && newlen >=3D 0 && pindex >=3D 0 && pindex < PERF_N)
-    {
-        int i;
-        for (i =3D 0; i < sindex; ++i)
-        {
-            if (perf_set.stack[i] =3D=3D pindex)
-            {
-                perf_print_state(M_INFO);
-                msg(M_FATAL, "PERF: push_perf_index %s failed", metric_nam=
es[pindex]);
-            }
-        }
-
-        perf_set.stack[sindex] =3D pindex;
-        perf_set.stack_len =3D newlen;
-    }
-    else
-    {
-        msg(M_FATAL, "PERF: push_perf_index: stack push error");
-    }
-}
-
-static void
-pop_perf_index(void)
-{
-    const int newlen =3D get_stack_index(-1);
-    if (newlen >=3D 0)
-    {
-        perf_set.stack_len =3D newlen;
-    }
-    else
-    {
-        msg(M_FATAL, "PERF: pop_perf_index: stack pop error");
-    }
-}
-
-static void
-state_must_be(const struct perf *p, const int wanted)
-{
-    if (p->state !=3D wanted)
-    {
-        msg(M_FATAL, "PERF: bad state actual=3D%d wanted=3D%d", p->state, =
wanted);
-    }
-}
-
-static void
-update_sofar(struct perf *p)
-{
-    struct timeval current;
-    ASSERT(!gettimeofday(&current, NULL));
-    p->sofar +=3D (double)tv_subtract(&current, &p->start, 600) / 1000000.=
0;
-    tv_clear(&p->start);
-}
-
-static void
-perf_start(struct perf *p)
-{
-    state_must_be(p, PS_INITIAL);
-    ASSERT(!gettimeofday(&p->start, NULL));
-    p->sofar =3D 0.0;
-    p->state =3D PS_METER_RUNNING;
-}
-
-static void
-perf_stop(struct perf *p)
-{
-    state_must_be(p, PS_METER_RUNNING);
-    update_sofar(p);
-    p->sum +=3D p->sofar;
-    if (p->sofar > p->max)
-    {
-        p->max =3D p->sofar;
-    }
-    p->count +=3D 1.0;
-    p->sofar =3D 0.0;
-    p->state =3D PS_INITIAL;
-}
-
-static void
-perf_interrupt(struct perf *p)
-{
-    state_must_be(p, PS_METER_RUNNING);
-    update_sofar(p);
-    p->state =3D PS_METER_INTERRUPTED;
-}
-
-static void
-perf_resume(struct perf *p)
-{
-    state_must_be(p, PS_METER_INTERRUPTED);
-    ASSERT(!gettimeofday(&p->start, NULL));
-    p->state =3D PS_METER_RUNNING;
-}
-
-void
-perf_push(int type)
-{
-    struct perf *prev;
-    struct perf *cur;
-
-    ASSERT(SIZE(metric_names) =3D=3D PERF_N);
-    push_perf_index(type);
-
-    prev =3D get_perf(-2);
-    cur =3D get_perf(-1);
-
-    ASSERT(cur);
-
-    if (prev)
-    {
-        perf_interrupt(prev);
-    }
-    perf_start(cur);
-}
-
-void
-perf_pop(void)
-{
-    struct perf *prev;
-    struct perf *cur;
-
-    prev =3D get_perf(-2);
-    cur =3D get_perf(-1);
-
-    ASSERT(cur);
-    perf_stop(cur);
-
-    if (prev)
-    {
-        perf_resume(prev);
-    }
-
-    pop_perf_index();
-}
-
-void
-perf_output_results(void)
-{
-    int i;
-    msg(M_INFO, "LATENCY PROFILE (mean and max are in milliseconds)");
-    for (i =3D 0; i < PERF_N; ++i)
-    {
-        struct perf *p =3D &perf_set.perf[i];
-        if (p->count > 0.0)
-        {
-            const double mean =3D p->sum / p->count;
-            msg(M_INFO, "%s n=3D%.0f mean=3D%.3f max=3D%.3f", metric_names=
[i], p->count, mean * 1000.0,
-                p->max * 1000.0);
-        }
-    }
-}
-
-static void
-perf_print_state(int lev)
-{
-    struct gc_arena gc =3D gc_new();
-    int i;
-    msg(lev, "PERF STATE");
-    msg(lev, "Stack:");
-    for (i =3D 0; i < perf_set.stack_len; ++i)
-    {
-        const int j =3D perf_set.stack[i];
-        const struct perf *p =3D &perf_set.perf[j];
-        msg(lev, "[%d] %s state=3D%d start=3D%s sofar=3D%f sum=3D%f max=3D=
%f count=3D%f", i, metric_names[j],
-            p->state, tv_string(&p->start, &gc), p->sofar, p->sum, p->max,=
 p->count);
-    }
-    gc_free(&gc);
-}
-#endif /* ifdef ENABLE_PERFORMANCE_METRICS */
diff --git a/src/openvpn/perf.h b/src/openvpn/perf.h
deleted file mode 100644
index 2a178a1..0000000
--- a/src/openvpn/perf.h
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2025 OpenVPN Inc <sales@...515...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, see <https://www.gnu.org/licenses/>.
- */
-
-/*
- * The interval_ routines are designed to optimize the calling of a routine
- * (normally tls_multi_process()) which can be called less frequently
- * between triggers.
- */
-
-#ifndef PERF_H
-#define PERF_H
-
-/*#define ENABLE_PERFORMANCE_METRICS*/
-
-/*
- * Metrics
- */
-#define PERF_BIO_READ_PLAINTEXT    0
-#define PERF_BIO_WRITE_PLAINTEXT   1
-#define PERF_BIO_READ_CIPHERTEXT   2
-#define PERF_BIO_WRITE_CIPHERTEXT  3
-#define PERF_TLS_MULTI_PROCESS     4
-#define PERF_IO_WAIT               5
-#define PERF_EVENT_LOOP            6
-#define PERF_MULTI_CREATE_INSTANCE 7
-#define PERF_MULTI_CLOSE_INSTANCE  8
-#define PERF_MULTI_SHOW_STATS      9
-#define PERF_MULTI_BCAST           10
-#define PERF_MULTI_MCAST           11
-#define PERF_SCRIPT                12
-#define PERF_READ_IN_LINK          13
-#define PERF_PROC_IN_LINK          14
-#define PERF_READ_IN_TUN           15
-#define PERF_PROC_IN_TUN           16
-#define PERF_PROC_OUT_LINK         17
-#define PERF_PROC_OUT_TUN          18
-#define PERF_PROC_OUT_TUN_MTCP     19
-#define PERF_N                     20
-
-#ifdef ENABLE_PERFORMANCE_METRICS
-
-#include "basic.h"
-
-/*
- * Stack size
- */
-#define STACK_N 64
-
-void perf_push(int type);
-
-void perf_pop(void);
-
-void perf_output_results(void);
-
-#else  /* ifdef ENABLE_PERFORMANCE_METRICS */
-
-static inline void
-perf_push(int type)
-{
-}
-static inline void
-perf_pop(void)
-{
-}
-static inline void
-perf_output_results(void)
-{
-}
-
-#endif /* ifdef ENABLE_PERFORMANCE_METRICS */
-
-#endif /* ifndef PERF_H */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 567560f..908854a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -47,7 +47,6 @@
 #include "misc.h"
 #include "fdmisc.h"
 #include "interval.h"
-#include "perf.h"
 #include "status.h"
 #include "gremlin.h"
 #include "pkcs11.h"
@@ -3220,8 +3219,6 @@
     int active =3D TLSMP_INACTIVE;
     bool error =3D false;

-    perf_push(PERF_TLS_MULTI_PROCESS);
-
     tls_clear_error();

     /*
@@ -3413,7 +3410,6 @@
     }
 #endif

-    perf_pop();
     gc_free(&gc);

     return (tas =3D=3D TLS_AUTHENTICATION_FAILED) ? TLSMP_KILL : active;
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 80eb51b..488f9b9 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1286,14 +1286,12 @@
 key_state_write_plaintext_const(struct key_state_ssl *ks, const uint8_t *d=
ata, int len)
 {
     int retval =3D 0;
-    perf_push(PERF_BIO_WRITE_PLAINTEXT);

     ASSERT(NULL !=3D ks);
     ASSERT(len >=3D 0);

     if (0 =3D=3D len)
     {
-        perf_pop();
         return 0;
     }

@@ -1303,7 +1301,6 @@

     if (retval < 0)
     {
-        perf_pop();
         if (MBEDTLS_ERR_SSL_WANT_WRITE =3D=3D retval || MBEDTLS_ERR_SSL_WA=
NT_READ =3D=3D retval)
         {
             return 0;
@@ -1316,14 +1313,12 @@
     {
         msg(D_TLS_ERRORS, "TLS ERROR: write tls_write_plaintext_const inco=
mplete %d/%d", retval,
             len);
-        perf_pop();
         return -1;
     }

     /* successful write */
     dmsg(D_HANDSHAKE_VERBOSE, "write tls_write_plaintext_const %d bytes", =
retval);

-    perf_pop();
     return 1;
 }

@@ -1333,15 +1328,12 @@
     int retval =3D 0;
     int len =3D 0;

-    perf_push(PERF_BIO_READ_CIPHERTEXT);
-
     ASSERT(NULL !=3D ks);
     ASSERT(buf);
     ASSERT(buf->len >=3D 0);

     if (buf->len)
     {
-        perf_pop();
         return 0;
     }

@@ -1352,7 +1344,6 @@
     /* Error during read, check for retry error */
     if (retval < 0)
     {
-        perf_pop();
         if (MBEDTLS_ERR_SSL_WANT_WRITE =3D=3D retval || MBEDTLS_ERR_SSL_WA=
NT_READ =3D=3D retval)
         {
             return 0;
@@ -1365,14 +1356,12 @@
     if (0 =3D=3D retval)
     {
         buf->len =3D 0;
-        perf_pop();
         return 0;
     }

     /* successful read */
     dmsg(D_HANDSHAKE_VERBOSE, "read tls_read_ciphertext %d bytes", retval);
     buf->len =3D retval;
-    perf_pop();
     return 1;
 }

@@ -1380,7 +1369,6 @@
 key_state_write_ciphertext(struct key_state_ssl *ks, struct buffer *buf)
 {
     int retval =3D 0;
-    perf_push(PERF_BIO_WRITE_CIPHERTEXT);

     ASSERT(NULL !=3D ks);
     ASSERT(buf);
@@ -1388,7 +1376,6 @@

     if (0 =3D=3D buf->len)
     {
-        perf_pop();
         return 0;
     }

@@ -1396,8 +1383,6 @@

     if (retval < 0)
     {
-        perf_pop();
-
         if (MBEDTLS_ERR_SSL_WANT_WRITE =3D=3D retval || MBEDTLS_ERR_SSL_WA=
NT_READ =3D=3D retval)
         {
             return 0;
@@ -1410,7 +1395,6 @@
     {
         msg(D_TLS_ERRORS, "TLS ERROR: write tls_write_ciphertext incomplet=
e %d/%d", retval,
             buf->len);
-        perf_pop();
         return -1;
     }

@@ -1420,7 +1404,6 @@
     memset(BPTR(buf), 0, BLEN(buf)); /* erase data just written */
     buf->len =3D 0;

-    perf_pop();
     return 1;
 }

@@ -1430,15 +1413,12 @@
     int retval =3D 0;
     int len =3D 0;

-    perf_push(PERF_BIO_READ_PLAINTEXT);
-
     ASSERT(NULL !=3D ks);
     ASSERT(buf);
     ASSERT(buf->len >=3D 0);

     if (buf->len)
     {
-        perf_pop();
         return 0;
     }

@@ -1455,14 +1435,12 @@
         }
         mbed_log_err(D_TLS_ERRORS, retval, "TLS_ERROR: read tls_read_plain=
text error");
         buf->len =3D 0;
-        perf_pop();
         return -1;
     }
     /* Nothing read, try again */
     if (0 =3D=3D retval)
     {
         buf->len =3D 0;
-        perf_pop();
         return 0;
     }

@@ -1470,7 +1448,6 @@
     dmsg(D_HANDSHAKE_VERBOSE, "read tls_read_plaintext %d bytes", retval);
     buf->len =3D retval;

-    perf_pop();
     return 1;
 }

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 434df7d..d997141 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2208,14 +2208,12 @@
 key_state_write_plaintext(struct key_state_ssl *ks_ssl, struct buffer *buf)
 {
     int ret =3D 0;
-    perf_push(PERF_BIO_WRITE_PLAINTEXT);

     ASSERT(NULL !=3D ks_ssl);

     ret =3D bio_write(ks_ssl->ssl_bio, BPTR(buf), BLEN(buf), "tls_write_pl=
aintext");
     bio_write_post(ret, buf);

-    perf_pop();
     return ret;
 }

@@ -2223,13 +2221,11 @@
 key_state_write_plaintext_const(struct key_state_ssl *ks_ssl, const uint8_=
t *data, int len)
 {
     int ret =3D 0;
-    perf_push(PERF_BIO_WRITE_PLAINTEXT);

     ASSERT(NULL !=3D ks_ssl);

     ret =3D bio_write(ks_ssl->ssl_bio, data, len, "tls_write_plaintext_con=
st");

-    perf_pop();
     return ret;
 }

@@ -2237,13 +2233,11 @@
 key_state_read_ciphertext(struct key_state_ssl *ks_ssl, struct buffer *buf)
 {
     int ret =3D 0;
-    perf_push(PERF_BIO_READ_CIPHERTEXT);

     ASSERT(NULL !=3D ks_ssl);

     ret =3D bio_read(ks_ssl->ct_out, buf, "tls_read_ciphertext");

-    perf_pop();
     return ret;
 }

@@ -2251,14 +2245,12 @@
 key_state_write_ciphertext(struct key_state_ssl *ks_ssl, struct buffer *bu=
f)
 {
     int ret =3D 0;
-    perf_push(PERF_BIO_WRITE_CIPHERTEXT);

     ASSERT(NULL !=3D ks_ssl);

     ret =3D bio_write(ks_ssl->ct_in, BPTR(buf), BLEN(buf), "tls_write_ciph=
ertext");
     bio_write_post(ret, buf);

-    perf_pop();
     return ret;
 }

@@ -2266,13 +2258,11 @@
 key_state_read_plaintext(struct key_state_ssl *ks_ssl, struct buffer *buf)
 {
     int ret =3D 0;
-    perf_push(PERF_BIO_READ_PLAINTEXT);

     ASSERT(NULL !=3D ks_ssl);

     ret =3D bio_read(ks_ssl->ssl_bio, buf, "tls_read_plaintext");

-    perf_pop();
     return ret;
 }

diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 1e1e3fb..5ca33cb 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -27,7 +27,6 @@
 #include "syshead.h"

 #include "status.h"
-#include "perf.h"
 #include "misc.h"
 #include "fdmisc.h"


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1303?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5bb666a73b4381066e86f53d957e1987fa07303b
Gerrit-Change-Number: 1303
Gerrit-PatchSet: 2
Gerrit-Owner: syzzer <steffan@...1856...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--w1pvwflIiX0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1303?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Remove perf.c/perf.h<br><br>This code was always=
 disabled by ENABLE_PERFORMANCE_METRICS being<br>commented out in perf.h. T=
here was no configure flag. None of the<br>active developers remembers usin=
g it, the git log shows no actual<br>code changes since at least the projec=
t structure overhaul of 2012,<br>and tools like gprof are nowadays the go-t=
o tool for performance<br>profiling. So, out with our custom implementation=
.<br><br>This was triggered by a bug report submitted by Joshua Rogers, who=
<br>used ZeroPath to discover we missed a perf_pop() call in one of the<br>=
error paths of ssl_mbedtls.c. This commit resolves that using git rm.<br><b=
r>Change-Id: I5bb666a73b4381066e86f53d957e1987fa07303b<br>Signed-off-by: St=
effan Karger &lt;steffan@...1856...&gt;<br>Acked-by: Gert Doering &lt;gert@=
...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1303<b=
r>Message-Id: &lt;20251026142100.12147-1-gert@...1296...&gt;<br>URL: https:=
//www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33868.html<br=
>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeLists=
.txt<br>M src/openvpn/Makefile.am<br>M src/openvpn/error.c<br>M src/openvpn=
/event.h<br>M src/openvpn/forward.c<br>M src/openvpn/multi.c<br>M src/openv=
pn/multi.h<br>M src/openvpn/multi_io.c<br>M src/openvpn/openvpn.c<br>M src/=
openvpn/openvpn.h<br>D src/openvpn/perf.c<br>D src/openvpn/perf.h<br>M src/=
openvpn/ssl.c<br>M src/openvpn/ssl_mbedtls.c<br>M src/openvpn/ssl_openssl.c=
<br>M src/openvpn/status.c<br>16 files changed, 0 insertions(+), 496 deleti=
ons(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 23fb4=
a5..5954a6e 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -519,8 +519,6 @@</span><br><span>     =
src/openvpn/ovpn_dco_win.h</span><br><span>     src/openvpn/packet_id.c</sp=
an><br><span>     src/openvpn/packet_id.h</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    src/openvpn/perf.c</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    src/openvpn/perf.h</span><br><span>     src/openvp=
n/ping.c</span><br><span>     src/openvpn/ping.h</span><br><span>     src/o=
penvpn/pkcs11.c</span><br><span>diff --git a/src/openvpn/Makefile.am b/src/=
openvpn/Makefile.am</span><br><span>index e44fb2b..dc58cd1 100644</span><br=
><span>--- a/src/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Make=
file.am</span><br><span>@@ -112,7 +112,6 @@</span><br><span> 	options_parse=
.c \</span><br><span> 	otime.c otime.h \</span><br><span> 	packet_id.c pack=
et_id.h \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	perf.c perf=
.h \</span><br><span> 	ping.c ping.h \</span><br><span> 	plugin.c plugin.h =
\</span><br><span> 	pool.c pool.h \</span><br><span>diff --git a/src/openvp=
n/error.c b/src/openvpn/error.c</span><br><span>index 58c2fd1..735d259 1006=
44</span><br><span>--- a/src/openvpn/error.c</span><br><span>+++ b/src/open=
vpn/error.c</span><br><span>@@ -34,7 +34,6 @@</span><br><span> #include &qu=
ot;socket.h&quot;</span><br><span> #include &quot;tun.h&quot;</span><br><sp=
an> #include &quot;otime.h&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#include &quot;perf.h&quot;</span><br><span> #include &quot;stat=
us.h&quot;</span><br><span> #include &quot;integer.h&quot;</span><br><span>=
 #include &quot;ps.h&quot;</span><br><span>@@ -734,11 +733,6 @@</span><br><=
span>             abort();</span><br><span>         }</span><br><span> #end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (status =3D=3D OPENVPN_EXIT_S=
TATUS_GOOD)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            perf_outpu=
t_results();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }=
</span><br><span>     }</span><br><span> </span><br><span>     exit(status)=
;</span><br><span>diff --git a/src/openvpn/event.h b/src/openvpn/event.h</s=
pan><br><span>index 8a89a25..f6aa9c4 100644</span><br><span>--- a/src/openv=
pn/event.h</span><br><span>+++ b/src/openvpn/event.h</span><br><span>@@ -25=
,7 +25,6 @@</span><br><span> </span><br><span> #include &quot;win32.h&quot;=
</span><br><span> #include &quot;sig.h&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#include &quot;perf.h&quot;</span><br><span> </span>=
<br><span> /*</span><br><span>  * rwflags passed to event_ctl and returned =
by</span><br><span>@@ -189,9 +188,7 @@</span><br><span> event_wait(struct e=
vent_set *es, const struct timeval *tv, struct event_set_return *out, int o=
utlen)</span><br><span> {</span><br><span>     int ret;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    perf_push(PERF_IO_WAIT);</span><br><s=
pan>     ret =3D (*es-&gt;func.wait)(es, tv, out, outlen);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    perf_pop();</span><br><span>     r=
eturn ret;</span><br><span> }</span><br><span> </span><br><span>diff --git =
a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>index 79a6f=
c7..7f72000 100644</span><br><span>--- a/src/openvpn/forward.c</span><br><s=
pan>+++ b/src/openvpn/forward.c</span><br><span>@@ -932,8 +932,6 @@</span><=
br><span> </span><br><span>     /*ASSERT (!c-&gt;c2.to_tun.len);*/</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_pus=
h(PERF_READ_IN_LINK);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span>     c-&gt;c2.buf =3D c-&gt;c2.buffers-&gt;read_link_buf;<=
/span><br><span>     ASSERT(buf_init(&amp;c-&gt;c2.buf, c-&gt;c2.frame.buf.=
headroom));</span><br><span> </span><br><span>@@ -966,7 +964,6 @@</span><br=
><span>                 msg(D_STREAM_ERRORS, &quot;Connection reset, restar=
ting [%d]&quot;, status);</span><br><span>             }</span><br><span>  =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_=
pop();</span><br><span>         return;</span><br><span>     }</span><br><s=
pan> </span><br><span>@@ -983,8 +980,6 @@</span><br><span> </span><br><span=
>     /* Remove socks header if applicable */</span><br><span>     socks_po=
stprocess_incoming_link(c, sock);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_=
pop();</span><br><span> }</span><br><span> </span><br><span> bool</span><br=
><span>@@ -1212,15 +1207,11 @@</span><br><span> static void</span><br><span=
> process_incoming_link(struct context *c, struct link_socket *sock)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_=
push(PERF_PROC_IN_LINK);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span>     struct link_socket_info *lsi =3D &amp;sock-&gt;inf=
o;</span><br><span>     const uint8_t *orig_buf =3D c-&gt;c2.buf.data;</spa=
n><br><span> </span><br><span>     process_incoming_link_part1(c, lsi, fals=
e);</span><br><span>     process_incoming_link_part2(c, lsi, orig_buf);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    perf_pop();</span><br><span> }</span><br><=
span> </span><br><span> void</span><br><span>@@ -1326,8 +1317,6 @@</span><b=
r><span>      */</span><br><span>     /*ASSERT (!c-&gt;c2.to_link.len);*/</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p=
erf_push(PERF_READ_IN_TUN);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span>     c-&gt;c2.buf =3D c-&gt;c2.buffers-&gt;read_tun_=
buf;</span><br><span> </span><br><span> #ifdef _WIN32</span><br><span>@@ -1=
360,7 +1349,6 @@</span><br><span>     {</span><br><span>         register_s=
ignal(c-&gt;sig, SIGTERM, &quot;tun-stop&quot;);</span><br><span>         m=
sg(M_INFO, &quot;TUN/TAP interface has been stopped, exiting&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_pop();</span><b=
r><span>         return;</span><br><span>     }</span><br><span> </span><br=
><span>@@ -1370,14 +1358,11 @@</span><br><span>         register_signal(c-&=
gt;sig, SIGHUP, &quot;tun-abort&quot;);</span><br><span>         c-&gt;pers=
ist.restart_sleep_seconds =3D 10;</span><br><span>         msg(M_INFO, &quo=
t;TUN/TAP I/O operation aborted, restarting&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        perf_pop();</span><br><span>       =
  return;</span><br><span>     }</span><br><span> </span><br><span>     /* =
Check the status return from read() */</span><br><span>     check_status(c-=
&gt;c2.buf.len, &quot;read from TUN/TAP&quot;, NULL, c-&gt;c1.tuntap);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    perf_pop();</span><br><span> }</span><br><s=
pan> </span><br><span> /**</span><br><span>@@ -1497,8 +1482,6 @@</span><br>=
<span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_push(PE=
RF_PROC_IN_TUN);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span>     if (c-&gt;c2.buf.len &gt; 0)</span><br><span>     {</span>=
<br><span>         c-&gt;c2.tun_read_bytes +=3D c-&gt;c2.buf.len;</span><br=
><span>@@ -1542,7 +1525,6 @@</span><br><span>     {</span><br><span>       =
  buf_reset(&amp;c-&gt;c2.to_link);</span><br><span>     }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    perf_pop();</span><br><span>     g=
c_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span>@@ -1=
770,8 +1752,6 @@</span><br><span>     struct gc_arena gc =3D gc_new();</spa=
n><br><span>     int error_code =3D 0;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    perf_push(PERF_PROC_OUT_LINK);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (c=
-&gt;c2.to_link.len &gt; 0 &amp;&amp; c-&gt;c2.to_link.len &lt;=3D c-&gt;c2=
.frame.buf.payload_size)</span><br><span>     {</span><br><span>         /*=
</span><br><span>@@ -1899,7 +1879,6 @@</span><br><span> </span><br><span>  =
   buf_reset(&amp;c-&gt;c2.to_link);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    perf_pop();</span><br><span>     gc_fr=
ee(&amp;gc);</span><br><span> }</span><br><span> </span><br><span>@@ -1919,=
8 +1898,6 @@</span><br><span>         return;</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_p=
ush(PERF_PROC_OUT_TUN);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span>     /*</span><br><span>      * The --mssfix option requ=
ires</span><br><span>      * us to examine the IP header (IPv4 or IPv6).</s=
pan><br><span>@@ -1993,8 +1970,6 @@</span><br><span>     }</span><br><span>=
 </span><br><span>     buf_reset(&amp;c-&gt;c2.to_tun);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    perf_pop();</span><br><span> }</span><br><span> </span><br=
><span> #if defined(__GNUC__) || defined(__clang__)</span><br><span>diff --=
git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index fa9c6=
54..f60944d 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><spa=
n>+++ b/src/openvpn/multi.c</span><br><span>@@ -580,8 +580,6 @@</span><br><=
span> void</span><br><span> multi_close_instance(struct multi_context *m, s=
truct multi_instance *mi, bool shutdown)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    perf_push(PERF_MULTI_CLOSE_INSTAN=
CE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
     ASSERT(!mi-&gt;halt);</span><br><span>     mi-&gt;halt =3D true;</span=
><br><span>     bool is_dgram =3D proto_is_dgram(mi-&gt;context.c2.link_soc=
kets[0]-&gt;info.proto);</span><br><span>@@ -672,8 +670,6 @@</span><br><spa=
n>      * vhash reaper deal with it.</span><br><span>      */</span><br><sp=
an>     multi_instance_dec_refcount(mi);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  perf_pop();</span><br><span> }</span><br><span> </span><br><span> /*</spa=
n><br><span>@@ -734,8 +730,6 @@</span><br><span>     struct gc_arena gc =3D=
 gc_new();</span><br><span>     struct multi_instance *mi;</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_push(PERF_M=
ULTI_CREATE_INSTANCE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span>     msg(D_MULTI_MEDIUM, &quot;MULTI: multi_create_instan=
ce called&quot;);</span><br><span> </span><br><span>     ALLOC_OBJ_CLEAR(mi=
, struct multi_instance);</span><br><span>@@ -807,13 +801,11 @@</span><br><=
span>     mi-&gt;ev_arg.type =3D EVENT_ARG_MULTI_INSTANCE;</span><br><span>=
     mi-&gt;ev_arg.u.mi =3D mi;</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    perf_pop();</span><br><span>     gc_free(&a=
mp;gc);</span><br><span>     return mi;</span><br><span> </span><br><span> =
err:</span><br><span>     multi_close_instance(m, mi, false);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    perf_pop();</span><br><span>   =
  gc_free(&amp;gc);</span><br><span>     return NULL;</span><br><span> }</s=
pan><br><span>@@ -2907,7 +2899,6 @@</span><br><span> </span><br><span>     =
if (BLEN(buf) &gt; 0)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        perf_push(PERF_MULTI_BCAST);</span><br><span=
> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span>         printf(&quot;BCAST=
 len=3D%d\n&quot;, BLEN(buf));</span><br><span> #endif</span><br><span>@@ -=
2929,7 +2920,6 @@</span><br><span> </span><br><span>         hash_iterator_=
free(&amp;hi);</span><br><span>         mbuf_free_buf(mb);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        perf_pop();</span><br><span>  =
   }</span><br><span> }</span><br><span> </span><br><span>@@ -3399,7 +3389,=
6 @@</span><br><span> </span><br><span>             /* decrypt in instance =
context */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            perf_push(PERF_PROC_IN_LINK);</span><br><span>          =
   lsi =3D &amp;sock-&gt;info;</span><br><span>             orig_buf =3D c-=
&gt;c2.buf.data;</span><br><span>             if (process_incoming_link_par=
t1(c, lsi, floated))</span><br><span>@@ -3412,7 +3401,6 @@</span><br><span>=
 </span><br><span>                 process_incoming_link_part2(c, lsi, orig=
_buf);</span><br><span>             }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            perf_pop();</span><br><span> </span><br><span> =
            if (TUNNEL_TYPE(m-&gt;top.c1.tuntap) =3D=3D DEV_TYPE_TUN)</span=
><br><span>             {</span><br><span>@@ -4180,8 +4168,6 @@</span><br><=
span> </span><br><span>     while (true)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        perf_push(PERF_EVENT_LOOP=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>  =
       /* wait on tun/socket list */</span><br><span>         multi_get_tim=
eout(multi, &amp;multi-&gt;top.c2.timeval);</span><br><span>         status=
 =3D multi_io_wait(multi);</span><br><span>@@ -4202,7 +4188,6 @@</span><br>=
<span>         }</span><br><span> </span><br><span>         MULTI_CHECK_SIG=
(multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_=
pop();</span><br><span>     }</span><br><span> }</span><br><span> </span><b=
r><span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br><s=
pan>index 97bbc4a..594ea3a 100644</span><br><span>--- a/src/openvpn/multi.h=
</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -38,7 +38,6 @=
@</span><br><span> #include &quot;mudp.h&quot;</span><br><span> #include &q=
uot;mtcp.h&quot;</span><br><span> #include &quot;multi_io.h&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;perf.h&quot;</sp=
an><br><span> #include &quot;vlan.h&quot;</span><br><span> #include &quot;r=
eflect_filter.h&quot;</span><br><span> </span><br><span>diff --git a/src/op=
envpn/multi_io.c b/src/openvpn/multi_io.c</span><br><span>index 0bfbb63..6e=
31687 100644</span><br><span>--- a/src/openvpn/multi_io.c</span><br><span>+=
++ b/src/openvpn/multi_io.c</span><br><span>@@ -242,9 +242,7 @@</span><br><=
span>             tun_input_pending =3D NULL;</span><br><span>             =
/* For some reason, the Linux 2.2 TUN/TAP driver hits this timeout */</span=
><br><span>             c-&gt;c2.timeval.tv_sec =3D 1;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            perf_push(PERF_PROC_OUT_TUN_MT=
CP);</span><br><span>             io_wait(c, IOW_TO_TUN);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            perf_pop();</span><br><span=
>             break;</span><br><span> </span><br><span>         case TA_SOC=
KET_WRITE:</span><br><span>diff --git a/src/openvpn/openvpn.c b/src/openvpn=
/openvpn.c</span><br><span>index 64b4f8c..eaaa59b 100644</span><br><span>--=
- a/src/openvpn/openvpn.c</span><br><span>+++ b/src/openvpn/openvpn.c</span=
><br><span>@@ -72,8 +72,6 @@</span><br><span>     /* main event loop */</sp=
an><br><span>     while (true)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        perf_push(PERF_EVENT_LOOP);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         /* =
process timers, TLS, etc. */</span><br><span>         pre_select(c);</span>=
<br><span>         P2P_CHECK_SIG();</span><br><span>@@ -85,15 +83,12 @@</sp=
an><br><span>         /* timeout? */</span><br><span>         if (c-&gt;c2.=
event_set_status =3D=3D ES_TIMEOUT)</span><br><span>         {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            perf_pop();</span><br>=
<span>             continue;</span><br><span>         }</span><br><span> </=
span><br><span>         /* process the I/O which triggered select */</span>=
<br><span>         process_io(c, c-&gt;c2.link_sockets[0]);</span><br><span=
>         P2P_CHECK_SIG();</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_pop=
();</span><br><span>     }</span><br><span> </span><br><span>     persist_c=
lient_stats(c);</span><br><span>diff --git a/src/openvpn/openvpn.h b/src/op=
envpn/openvpn.h</span><br><span>index cd99cd4..a198fcf 100644</span><br><sp=
an>--- a/src/openvpn/openvpn.h</span><br><span>+++ b/src/openvpn/openvpn.h<=
/span><br><span>@@ -524,7 +524,6 @@</span><br><span>     if (IS_SIG(c))    =
                        \</span><br><span>     {                           =
              \</span><br><span>         const int brk =3D func(arg);      =
      \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_p=
op();                           \</span><br><span>         if (brk)        =
                      \</span><br><span>         {                         =
            \</span><br><span>             break;                          =
  \</span><br><span>diff --git a/src/openvpn/perf.c b/src/openvpn/perf.c</s=
pan><br><span>deleted file mode 100644</span><br><span>index 51c1a97..00000=
00</span><br><span>--- a/src/openvpn/perf.c</span><br><span>+++ /dev/null</=
span><br><span>@@ -1,306 +0,0 @@</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Open=
VPN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *             over a single TCP/UDP port, =
with support for SSL/TLS-based</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *             session authentication and key exchange,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *             packet encryption=
, packet authentication, and</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *             packet compression.</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sales@...515...&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- *  This program is free software; you can redistri=
bute it and/or modify</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *  it under the terms of the GNU General Public License version 2</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *  as published by the Free S=
oftware Foundation.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  This program is d=
istributed in the hope that it will be useful,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- *  but WITHOUT ANY WARRANTY; without even the imp=
lied warranty of</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  M=
ERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *  GNU General Public License for m=
ore details.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *  You should have received=
 a copy of the GNU General Public License along</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  with this program; if not, see &lt;https://ww=
w.gnu.org/licenses/&gt;.</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_CONFIG_H</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config.h&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#include &quot;syshead.h&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
include &quot;perf.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_PE=
RFORMANCE_METRICS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;error.h&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;oti=
me.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;memdbg.h&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static const char *metric_names[] =3D { &qu=
ot;PERF_BIO_READ_PLAINTEXT&quot;,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                      &quot;PERF_BIO_WRITE_PLAI=
NTEXT&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                             &quot;PERF_BIO_READ_CIPHERTEXT&quot;,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
        &quot;PERF_BIO_WRITE_CIPHERTEXT&quot;,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                      &quot;PERF_T=
LS_MULTI_PROCESS&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                      &quot;PERF_IO_WAIT&quot;,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
       &quot;PERF_EVENT_LOOP&quot;,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                                      &quot;PERF_MULTI_CREATE=
_INSTANCE&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                                 &quot;PERF_MULTI_CLOSE_INSTANCE&quot;,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
             &quot;PERF_MULTI_SHOW_STATS&quot;,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                      &quot;PERF_=
MULTI_BCAST&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                                   &quot;PERF_MULTI_MCAST&quot;,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                                =
      &quot;PERF_SCRIPT&quot;,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                                      &quot;PERF_READ_IN_LINK&quot=
;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
                   &quot;PERF_PROC_IN_LINK&quot;,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                                      &quot;PER=
F_READ_IN_TUN&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                     &quot;PERF_PROC_IN_TUN&quot;,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
        &quot;PERF_PROC_OUT_LINK&quot;,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                      &quot;PERF_PROC_OUT=
_TUN&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                            &quot;PERF_PROC_OUT_TUN_MTCP&quot; };</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-struct perf</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 PS_INITIAL           0</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define PS_METER_RUNNING     1</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define PS_METER_INTERRUPTED 2</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    int state;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct timeval start;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
double sofar;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    doub=
le sum;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    double max=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    double count;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-struct perf_set</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int stack_l=
en;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int stack[STAC=
K_N];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct perf =
perf[PERF_N];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-static struct perf_set perf_set;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static void perf_print_state(int lev);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-static inline int</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-get_stack_index(int sdelta)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
onst int sindex =3D perf_set.stack_len + sdelta;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (sindex &gt;=3D 0 &amp;&amp; sindex &lt; =
STACK_N)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        return sindex;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        return -1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-get_perf_index(int sdelta)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t int sindex =3D get_stack_index(sdelta);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (sindex &gt;=3D 0)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        const int pindex =3D perf_set.stack[sindex];</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (pindex &gt;=3D 0 &amp;&a=
mp; pindex &lt; PERF_N)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  return pindex;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            return -1;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return -1;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic struct perf *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_p=
erf(int sdelta)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int pindex =3D g=
et_perf_index(sdelta);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (pindex &gt;=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ret=
urn &amp;perf_set.perf[pindex];</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    el=
se</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        return NULL;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-push_perf_index(int pindex)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    const int sindex =3D get_stack_index(0=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int newle=
n =3D get_stack_index(1);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (sindex &gt;=3D 0 &amp;&amp; newlen &gt;=3D 0 &amp;&amp; pindex =
&gt;=3D 0 &amp;&amp; pindex &lt; PERF_N)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    for (i =3D 0; i &lt; sindex; ++i)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            if (perf_set.stack[i] =3D=3D pindex)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                perf_print_state(M_INFO);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_FATAL, &q=
uot;PERF: push_perf_index %s failed&quot;, metric_names[pindex]);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        perf_set.stack[sindex] =3D pindex;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        perf_set.stack_len =3D newlen;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    msg(M_FATAL, &quot;PERF: push_perf_index: stack push error&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pop_perf_index(voi=
d)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const int newlen =3D get_stack_inde=
x(-1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (newlen =
&gt;=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_set.stack_len =
=3D newlen;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        msg(M_FATAL, &quot;PERF: pop_perf_index: stack =
pop error&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-state_must_be(const struct perf *p, const int wanted)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (p-&gt;state !=3D wanted)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        msg(M_FATAL, &quot;PERF: bad state actual=3D%d wanted=3D=
%d&quot;, p-&gt;state, wanted);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-update_sofar(struct perf *p)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct timeval current;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    ASSERT(!gettimeofday(&amp;current, NULL));</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    p-&gt;sofar +=3D (double)tv_subtrac=
t(&amp;current, &amp;p-&gt;start, 600) / 1000000.0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    tv_clear(&amp;p-&gt;start);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-perf_star=
t(struct perf *p)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    state_must_be(p, PS_=
INITIAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(!=
gettimeofday(&amp;p-&gt;start, NULL));</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    p-&gt;sofar =3D 0.0;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    p-&gt;state =3D PS_METER_RUNNING;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stati=
c void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-perf_stop(struc=
t perf *p)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    state_must_be(p, PS_METER_R=
UNNING);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    update_so=
far(p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;sum =
+=3D p-&gt;sofar;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (p-&gt;sofar &gt; p-&gt;max)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  p-&gt;max =3D p-&gt;sofar;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p-&gt=
;count +=3D 1.0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p=
-&gt;sofar =3D 0.0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  p-&gt;state =3D PS_INITIAL;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-perf_interrupt(struct perf *p)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    state_must_be(p, PS_METER_RUNNING);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    update_sofar(p);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;state =3D PS_METER_INTERRUP=
TED;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-perf_resume(struct perf *p)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sta=
te_must_be(p, PS_METER_INTERRUPTED);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    ASSERT(!gettimeofday(&amp;p-&gt;start, NULL));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;state =3D PS_METER_RU=
NNING;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-perf_push(int type)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct perf *pre=
v;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct perf *cu=
r;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    ASSERT(SIZE(metric_names) =3D=3D PER=
F_N);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    push_perf_in=
dex(type);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    prev =3D get_perf(-2);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    cur =3D get_perf(-1);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ASSERT(cur);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (prev)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_inter=
rupt(prev);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_start(cur);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-perf_pop(v=
oid)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct perf *prev;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct perf *cur;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    prev =3D get_perf(-2);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    cur =3D get_perf(-1);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    ASSERT(cur);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    perf_stop(cur);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (prev)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        perf_resume(prev);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 pop_perf_index();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-perf_output_results(void)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_IN=
FO, &quot;LATENCY PROFILE (mean and max are in milliseconds)&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; PER=
F_N; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        struct perf *p =3D &=
amp;perf_set.perf[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (p-&gt;count &gt; 0.0)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            const double mean =3D p-&gt;sum / p-&gt;count;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            msg(M_INFO, &quot;%s n=3D%=
.0f mean=3D%.3f max=3D%.3f&quot;, metric_names[i], p-&gt;count, mean * 1000=
.0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                p-=
&gt;max * 1000.0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-perf_pr=
int_state(int lev)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int =
i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(lev, &quot;=
PERF STATE&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 msg(lev, &quot;Stack:&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    for (i =3D 0; i &lt; perf_set.stack_len; ++i)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        const int j =3D perf_set.stack[i];</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        const struct perf *p =3D =
&amp;perf_set.perf[j];</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        msg(lev, &quot;[%d] %s state=3D%d start=3D%s sofar=3D%f sum=3D%f m=
ax=3D%f count=3D%f&quot;, i, metric_names[j],</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            p-&gt;state, tv_string(&amp;p-&gt;start=
, &amp;gc), p-&gt;sofar, p-&gt;sum, p-&gt;max, p-&gt;count);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif /* ifdef ENABLE_PERFORMANCE_METRICS */</span><br><span>diff --git=
 a/src/openvpn/perf.h b/src/openvpn/perf.h</span><br><span>deleted file mod=
e 100644</span><br><span>index 2a178a1..0000000</span><br><span>--- a/src/o=
penvpn/perf.h</span><br><span>+++ /dev/null</span><br><span>@@ -1,91 +0,0 @=
@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *  OpenVPN -- An application to secure=
ly tunnel IP networks</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *             over a single TCP/UDP port, with support for SSL/TLS-based</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *             session =
authentication and key exchange,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *             packet encryption, packet authentication, and</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *             packet com=
pression.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2002-2025 Ope=
nVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  This=
 program is free software; you can redistribute it and/or modify</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *  it under the terms of the GN=
U General Public License version 2</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  as published by the Free Software Foundation.</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *  This program is distributed in the hope that it w=
ill be useful,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  but=
 WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *  MERCHANTABILITY or FITNESS FOR A =
PARTICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *  GNU General Public License for more details.</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *  You should have received a copy of the GNU General Publi=
c License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  wi=
th this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * The inter=
val_ routines are designed to optimize the calling of a routine</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * (normally tls_multi_process())=
 which can be called less frequently</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * between triggers.</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef PERF_H</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define PERF_H</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-/*#define ENABLE_PERFORMANCE_METRICS*/</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Metri=
cs</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define PERF_BIO_READ_PLAINTEXT    0<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PERF_BIO_WRITE=
_PLAINTEXT   1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 PERF_BIO_READ_CIPHERTEXT   2</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define PERF_BIO_WRITE_CIPHERTEXT  3</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define PERF_TLS_MULTI_PROCESS     4</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define PERF_IO_WAIT               5<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PERF_EVENT_LOO=
P            6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 PERF_MULTI_CREATE_INSTANCE 7</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define PERF_MULTI_CLOSE_INSTANCE  8</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define PERF_MULTI_SHOW_STATS      9</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define PERF_MULTI_BCAST           10=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PERF_MULTI_MC=
AST           11</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne PERF_SCRIPT                12</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define PERF_READ_IN_LINK          13</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define PERF_PROC_IN_LINK          14</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define PERF_READ_IN_TUN        =
   15</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PERF_PRO=
C_IN_TUN           16</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define PERF_PROC_OUT_LINK         17</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define PERF_PROC_OUT_TUN          18</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define PERF_PROC_OUT_TUN_MTCP     19</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PERF_N             =
        20</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_PERFORMANCE_METRIC=
S</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#include &quot;basic.h&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * Stack size</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define STACK_N 64</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-void perf_push(int type);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void perf_pop(void);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void perf_o=
utput_results(void);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* ifdef ENABLE=
_PERFORMANCE_METRICS */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-perf_push(int type)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-static inline void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-perf_pop(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-perf_output_results(void)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_=
PERFORMANCE_METRICS */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef PER=
F_H */</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</=
span><br><span>index 567560f..908854a 100644</span><br><span>--- a/src/open=
vpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -47,7 =
+47,6 @@</span><br><span> #include &quot;misc.h&quot;</span><br><span> #inc=
lude &quot;fdmisc.h&quot;</span><br><span> #include &quot;interval.h&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;perf.h&=
quot;</span><br><span> #include &quot;status.h&quot;</span><br><span> #incl=
ude &quot;gremlin.h&quot;</span><br><span> #include &quot;pkcs11.h&quot;</s=
pan><br><span>@@ -3220,8 +3219,6 @@</span><br><span>     int active =3D TLS=
MP_INACTIVE;</span><br><span>     bool error =3D false;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_push(PERF_TLS_=
MULTI_PROCESS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span>     tls_clear_error();</span><br><span> </span><br><span>     /=
*</span><br><span>@@ -3413,7 +3410,6 @@</span><br><span>     }</span><br><s=
pan> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    perf_pop();</span><br><span>     gc_free(&amp;gc);</span><br><s=
pan> </span><br><span>     return (tas =3D=3D TLS_AUTHENTICATION_FAILED) ? =
TLSMP_KILL : active;</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c=
 b/src/openvpn/ssl_mbedtls.c</span><br><span>index 80eb51b..488f9b9 100644<=
/span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/o=
penvpn/ssl_mbedtls.c</span><br><span>@@ -1286,14 +1286,12 @@</span><br><spa=
n> key_state_write_plaintext_const(struct key_state_ssl *ks, const uint8_t =
*data, int len)</span><br><span> {</span><br><span>     int retval =3D 0;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_push(PERF_BIO_=
WRITE_PLAINTEXT);</span><br><span> </span><br><span>     ASSERT(NULL !=3D k=
s);</span><br><span>     ASSERT(len &gt;=3D 0);</span><br><span> </span><br=
><span>     if (0 =3D=3D len)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        perf_pop();</span><br><span>       =
  return 0;</span><br><span>     }</span><br><span> </span><br><span>@@ -13=
03,7 +1301,6 @@</span><br><span> </span><br><span>     if (retval &lt; 0)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        perf_pop();</span><br><span>         if (MBEDTLS_ERR_SSL_WANT_WRITE=
 =3D=3D retval || MBEDTLS_ERR_SSL_WANT_READ =3D=3D retval)</span><br><span>=
         {</span><br><span>             return 0;</span><br><span>@@ -1316,=
14 +1313,12 @@</span><br><span>     {</span><br><span>         msg(D_TLS_ER=
RORS, &quot;TLS ERROR: write tls_write_plaintext_const incomplete %d/%d&quo=
t;, retval,</span><br><span>             len);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        perf_pop();</span><br><span>         retur=
n -1;</span><br><span>     }</span><br><span> </span><br><span>     /* succ=
essful write */</span><br><span>     dmsg(D_HANDSHAKE_VERBOSE, &quot;write =
tls_write_plaintext_const %d bytes&quot;, retval);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_pop();</span><br><s=
pan>     return 1;</span><br><span> }</span><br><span> </span><br><span>@@ =
-1333,15 +1328,12 @@</span><br><span>     int retval =3D 0;</span><br><span=
>     int len =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    perf_push(PERF_BIO_READ_CIPHERTEXT);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(NULL !=3D =
ks);</span><br><span>     ASSERT(buf);</span><br><span>     ASSERT(buf-&gt;=
len &gt;=3D 0);</span><br><span> </span><br><span>     if (buf-&gt;len)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      perf_pop();</span><br><span>         return 0;</span><br><span>     }=
</span><br><span> </span><br><span>@@ -1352,7 +1344,6 @@</span><br><span>  =
   /* Error during read, check for retry error */</span><br><span>     if (=
retval &lt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        perf_pop();</span><br><span>         if (MBEDTLS_ER=
R_SSL_WANT_WRITE =3D=3D retval || MBEDTLS_ERR_SSL_WANT_READ =3D=3D retval)<=
/span><br><span>         {</span><br><span>             return 0;</span><br=
><span>@@ -1365,14 +1356,12 @@</span><br><span>     if (0 =3D=3D retval)</s=
pan><br><span>     {</span><br><span>         buf-&gt;len =3D 0;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        perf_pop();</span><br><s=
pan>         return 0;</span><br><span>     }</span><br><span> </span><br><=
span>     /* successful read */</span><br><span>     dmsg(D_HANDSHAKE_VERBO=
SE, &quot;read tls_read_ciphertext %d bytes&quot;, retval);</span><br><span=
>     buf-&gt;len =3D retval;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    perf_pop();</span><br><span>     return 1;</span><br><span> }</=
span><br><span> </span><br><span>@@ -1380,7 +1369,6 @@</span><br><span> key=
_state_write_ciphertext(struct key_state_ssl *ks, struct buffer *buf)</span=
><br><span> {</span><br><span>     int retval =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    perf_push(PERF_BIO_WRITE_CIPHERTEXT);</=
span><br><span> </span><br><span>     ASSERT(NULL !=3D ks);</span><br><span=
>     ASSERT(buf);</span><br><span>@@ -1388,7 +1376,6 @@</span><br><span> <=
/span><br><span>     if (0 =3D=3D buf-&gt;len)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_pop();</span><=
br><span>         return 0;</span><br><span>     }</span><br><span> </span>=
<br><span>@@ -1396,8 +1383,6 @@</span><br><span> </span><br><span>     if (=
retval &lt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        perf_pop();</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span>         if (MBEDTLS_ERR_SSL_WANT_WRITE =3D=
=3D retval || MBEDTLS_ERR_SSL_WANT_READ =3D=3D retval)</span><br><span>    =
     {</span><br><span>             return 0;</span><br><span>@@ -1410,7 +1=
395,6 @@</span><br><span>     {</span><br><span>         msg(D_TLS_ERRORS, =
&quot;TLS ERROR: write tls_write_ciphertext incomplete %d/%d&quot;, retval,=
</span><br><span>             buf-&gt;len);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        perf_pop();</span><br><span>         return -=
1;</span><br><span>     }</span><br><span> </span><br><span>@@ -1420,7 +140=
4,6 @@</span><br><span>     memset(BPTR(buf), 0, BLEN(buf)); /* erase data =
just written */</span><br><span>     buf-&gt;len =3D 0;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_pop();</span><=
br><span>     return 1;</span><br><span> }</span><br><span> </span><br><spa=
n>@@ -1430,15 +1413,12 @@</span><br><span>     int retval =3D 0;</span><br>=
<span>     int len =3D 0;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    perf_push(PERF_BIO_READ_PLAINTEXT);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(NULL !=
=3D ks);</span><br><span>     ASSERT(buf);</span><br><span>     ASSERT(buf-=
&gt;len &gt;=3D 0);</span><br><span> </span><br><span>     if (buf-&gt;len)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        perf_pop();</span><br><span>         return 0;</span><br><span>  =
   }</span><br><span> </span><br><span>@@ -1455,14 +1435,12 @@</span><br><s=
pan>         }</span><br><span>         mbed_log_err(D_TLS_ERRORS, retval, =
&quot;TLS_ERROR: read tls_read_plaintext error&quot;);</span><br><span>    =
     buf-&gt;len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        perf_pop();</span><br><span>         return -1;</span><br><span> =
    }</span><br><span>     /* Nothing read, try again */</span><br><span>  =
   if (0 =3D=3D retval)</span><br><span>     {</span><br><span>         buf=
-&gt;len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  perf_pop();</span><br><span>         return 0;</span><br><span>     }</sp=
an><br><span> </span><br><span>@@ -1470,7 +1448,6 @@</span><br><span>     d=
msg(D_HANDSHAKE_VERBOSE, &quot;read tls_read_plaintext %d bytes&quot;, retv=
al);</span><br><span>     buf-&gt;len =3D retval;</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_pop();</span><br><sp=
an>     return 1;</span><br><span> }</span><br><span> </span><br><span>diff=
 --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><s=
pan>index 434df7d..d997141 100644</span><br><span>--- a/src/openvpn/ssl_ope=
nssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -=
2208,14 +2208,12 @@</span><br><span> key_state_write_plaintext(struct key_s=
tate_ssl *ks_ssl, struct buffer *buf)</span><br><span> {</span><br><span>  =
   int ret =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
perf_push(PERF_BIO_WRITE_PLAINTEXT);</span><br><span> </span><br><span>    =
 ASSERT(NULL !=3D ks_ssl);</span><br><span> </span><br><span>     ret =3D b=
io_write(ks_ssl-&gt;ssl_bio, BPTR(buf), BLEN(buf), &quot;tls_write_plaintex=
t&quot;);</span><br><span>     bio_write_post(ret, buf);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_pop();</span>=
<br><span>     return ret;</span><br><span> }</span><br><span> </span><br><=
span>@@ -2223,13 +2221,11 @@</span><br><span> key_state_write_plaintext_con=
st(struct key_state_ssl *ks_ssl, const uint8_t *data, int len)</span><br><s=
pan> {</span><br><span>     int ret =3D 0;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    perf_push(PERF_BIO_WRITE_PLAINTEXT);</span><br><sp=
an> </span><br><span>     ASSERT(NULL !=3D ks_ssl);</span><br><span> </span=
><br><span>     ret =3D bio_write(ks_ssl-&gt;ssl_bio, data, len, &quot;tls_=
write_plaintext_const&quot;);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    perf_pop();</span><br><span>     return ret;<=
/span><br><span> }</span><br><span> </span><br><span>@@ -2237,13 +2233,11 @=
@</span><br><span> key_state_read_ciphertext(struct key_state_ssl *ks_ssl, =
struct buffer *buf)</span><br><span> {</span><br><span>     int ret =3D 0;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_push(PERF_BIO=
_READ_CIPHERTEXT);</span><br><span> </span><br><span>     ASSERT(NULL !=3D =
ks_ssl);</span><br><span> </span><br><span>     ret =3D bio_read(ks_ssl-&gt=
;ct_out, buf, &quot;tls_read_ciphertext&quot;);</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    perf_pop();</span><br><span=
>     return ret;</span><br><span> }</span><br><span> </span><br><span>@@ -=
2251,14 +2245,12 @@</span><br><span> key_state_write_ciphertext(struct key_=
state_ssl *ks_ssl, struct buffer *buf)</span><br><span> {</span><br><span> =
    int ret =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 perf_push(PERF_BIO_WRITE_CIPHERTEXT);</span><br><span> </span><br><span>  =
   ASSERT(NULL !=3D ks_ssl);</span><br><span> </span><br><span>     ret =3D=
 bio_write(ks_ssl-&gt;ct_in, BPTR(buf), BLEN(buf), &quot;tls_write_cipherte=
xt&quot;);</span><br><span>     bio_write_post(ret, buf);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_pop();</span=
><br><span>     return ret;</span><br><span> }</span><br><span> </span><br>=
<span>@@ -2266,13 +2258,11 @@</span><br><span> key_state_read_plaintext(str=
uct key_state_ssl *ks_ssl, struct buffer *buf)</span><br><span> {</span><br=
><span>     int ret =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    perf_push(PERF_BIO_READ_PLAINTEXT);</span><br><span> </span><br><s=
pan>     ASSERT(NULL !=3D ks_ssl);</span><br><span> </span><br><span>     r=
et =3D bio_read(ks_ssl-&gt;ssl_bio, buf, &quot;tls_read_plaintext&quot;);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p=
erf_pop();</span><br><span>     return ret;</span><br><span> }</span><br><s=
pan> </span><br><span>diff --git a/src/openvpn/status.c b/src/openvpn/statu=
s.c</span><br><span>index 1e1e3fb..5ca33cb 100644</span><br><span>--- a/src=
/openvpn/status.c</span><br><span>+++ b/src/openvpn/status.c</span><br><spa=
n>@@ -27,7 +27,6 @@</span><br><span> #include &quot;syshead.h&quot;</span><=
br><span> </span><br><span> #include &quot;status.h&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#include &quot;perf.h&quot;</span><br><=
span> #include &quot;misc.h&quot;</span><br><span> #include &quot;fdmisc.h&=
quot;</span><br><span> </span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1303?usp=3Demail">change 1=
303</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1303?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5bb666a73b4381066e86f53d957=
e1987fa07303b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1303 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: syzzer &lt;steffan@...1856...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--w1pvwflIiX0=--

