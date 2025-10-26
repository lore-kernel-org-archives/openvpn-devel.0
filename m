From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 26 Oct 2025 21:50:21 +0000
In-Reply-To: <gerrit.1761487758000.I5bb666a73b4381066e86f53d957e1987fa07303b@...2715...>
References: <gerrit.1761487758000.I5bb666a73b4381066e86f53d957e1987fa07303b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., steffan@...1856...
Message-ID: <4ca51b260fad9527cb6480604d3224b57aa2afbc-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TUHb5yE4YEY="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove perf.c/perf.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: syzzer <steffan@...1856...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TUHb5yE4YEY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 syzzer. ( http://gerrit.openvpn.net/c/openvpn/+/1303?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/1303/2

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

Gerrit-MessageType: newpatchset
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

--TUHb5yE4YEY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by syzzer.</p>=
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1303?usp=3Demail">View =
Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Remove perf.c/perf.h<br><br>This co=
de was always disabled by ENABLE_PERFORMANCE_METRICS being<br>commented out=
 in perf.h. There was no configure flag. None of the<br>active developers r=
emembers using it, the git log shows no actual<br>code changes since at lea=
st the project structure overhaul of 2012,<br>and tools like gprof are nowa=
days the go-to tool for performance<br>profiling. So, out with our custom i=
mplementation.<br><br>This was triggered by a bug report submitted by Joshu=
a Rogers, who<br>used ZeroPath to discover we missed a perf_pop() call in o=
ne of the<br>error paths of ssl_mbedtls.c. This commit resolves that using =
git rm.<br><br>Change-Id: I5bb666a73b4381066e86f53d957e1987fa07303b<br>Sign=
ed-off-by: Steffan Karger &lt;steffan@...1856...&gt;<br>Acked-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/ope=
nvpn/+/1303<br>Message-Id: &lt;20251026142100.12147-1-gert@...1296...&gt;<b=
r>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg=
33868.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br=
>M CMakeLists.txt<br>M src/openvpn/Makefile.am<br>M src/openvpn/error.c<br>=
M src/openvpn/event.h<br>M src/openvpn/forward.c<br>M src/openvpn/multi.c<b=
r>M src/openvpn/multi.h<br>M src/openvpn/multi_io.c<br>M src/openvpn/openvp=
n.c<br>M src/openvpn/openvpn.h<br>D src/openvpn/perf.c<br>D src/openvpn/per=
f.h<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl_mbedtls.c<br>M src/openvpn/=
ssl_openssl.c<br>M src/openvpn/status.c<br>16 files changed, 0 insertions(+=
), 496 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/03/1303/2</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.=
txt b/CMakeLists.txt</span><br><span>index 23fb4a5..5954a6e 100644</span><b=
r><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br=
><span>@@ -519,8 +519,6 @@</span><br><span>     src/openvpn/ovpn_dco_win.h<=
/span><br><span>     src/openvpn/packet_id.c</span><br><span>     src/openv=
pn/packet_id.h</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    src=
/openvpn/perf.c</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sr=
c/openvpn/perf.h</span><br><span>     src/openvpn/ping.c</span><br><span>  =
   src/openvpn/ping.h</span><br><span>     src/openvpn/pkcs11.c</span><br><=
span>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am</span><=
br><span>index e44fb2b..dc58cd1 100644</span><br><span>--- a/src/openvpn/Ma=
kefile.am</span><br><span>+++ b/src/openvpn/Makefile.am</span><br><span>@@ =
-112,7 +112,6 @@</span><br><span> 	options_parse.c \</span><br><span> 	otim=
e.c otime.h \</span><br><span> 	packet_id.c packet_id.h \</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	perf.c perf.h \</span><br><span> 	ping=
.c ping.h \</span><br><span> 	plugin.c plugin.h \</span><br><span> 	pool.c =
pool.h \</span><br><span>diff --git a/src/openvpn/error.c b/src/openvpn/err=
or.c</span><br><span>index 58c2fd1..735d259 100644</span><br><span>--- a/sr=
c/openvpn/error.c</span><br><span>+++ b/src/openvpn/error.c</span><br><span=
>@@ -34,7 +34,6 @@</span><br><span> #include &quot;socket.h&quot;</span><br=
><span> #include &quot;tun.h&quot;</span><br><span> #include &quot;otime.h&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;p=
erf.h&quot;</span><br><span> #include &quot;status.h&quot;</span><br><span>=
 #include &quot;integer.h&quot;</span><br><span> #include &quot;ps.h&quot;<=
/span><br><span>@@ -734,11 +733,6 @@</span><br><span>             abort();<=
/span><br><span>         }</span><br><span> #endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (status =3D=3D OPENVPN_EXIT_STATUS_GOOD)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            perf_output_results();</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span>     }</sp=
an><br><span> </span><br><span>     exit(status);</span><br><span>diff --gi=
t a/src/openvpn/event.h b/src/openvpn/event.h</span><br><span>index 8a89a25=
..f6aa9c4 100644</span><br><span>--- a/src/openvpn/event.h</span><br><span>=
+++ b/src/openvpn/event.h</span><br><span>@@ -25,7 +25,6 @@</span><br><span=
> </span><br><span> #include &quot;win32.h&quot;</span><br><span> #include =
&quot;sig.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#inc=
lude &quot;perf.h&quot;</span><br><span> </span><br><span> /*</span><br><sp=
an>  * rwflags passed to event_ctl and returned by</span><br><span>@@ -189,=
9 +188,7 @@</span><br><span> event_wait(struct event_set *es, const struct =
timeval *tv, struct event_set_return *out, int outlen)</span><br><span> {</=
span><br><span>     int ret;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    perf_push(PERF_IO_WAIT);</span><br><span>     ret =3D (*es-&gt;f=
unc.wait)(es, tv, out, outlen);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    perf_pop();</span><br><span>     return ret;</span><br><span>=
 }</span><br><span> </span><br><span>diff --git a/src/openvpn/forward.c b/s=
rc/openvpn/forward.c</span><br><span>index 79a6fc7..7f72000 100644</span><b=
r><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forwa=
rd.c</span><br><span>@@ -932,8 +932,6 @@</span><br><span> </span><br><span>=
     /*ASSERT (!c-&gt;c2.to_tun.len);*/</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    perf_push(PERF_READ_IN_LINK);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     c-&gt=
;c2.buf =3D c-&gt;c2.buffers-&gt;read_link_buf;</span><br><span>     ASSERT=
(buf_init(&amp;c-&gt;c2.buf, c-&gt;c2.frame.buf.headroom));</span><br><span=
> </span><br><span>@@ -966,7 +964,6 @@</span><br><span>                 msg=
(D_STREAM_ERRORS, &quot;Connection reset, restarting [%d]&quot;, status);</=
span><br><span>             }</span><br><span>         }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        perf_pop();</span><br><span>    =
     return;</span><br><span>     }</span><br><span> </span><br><span>@@ -9=
83,8 +980,6 @@</span><br><span> </span><br><span>     /* Remove socks heade=
r if applicable */</span><br><span>     socks_postprocess_incoming_link(c, =
sock);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    perf_pop();</span><br><span> }</=
span><br><span> </span><br><span> bool</span><br><span>@@ -1212,15 +1207,11=
 @@</span><br><span> static void</span><br><span> process_incoming_link(str=
uct context *c, struct link_socket *sock)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    perf_push(PERF_PROC_IN_LINK);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     st=
ruct link_socket_info *lsi =3D &amp;sock-&gt;info;</span><br><span>     con=
st uint8_t *orig_buf =3D c-&gt;c2.buf.data;</span><br><span> </span><br><sp=
an>     process_incoming_link_part1(c, lsi, false);</span><br><span>     pr=
ocess_incoming_link_part2(c, lsi, orig_buf);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    perf_pop();</span><br><span> }</span><br><span> </span><br><span> voi=
d</span><br><span>@@ -1326,8 +1317,6 @@</span><br><span>      */</span><br>=
<span>     /*ASSERT (!c-&gt;c2.to_link.len);*/</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    perf_push(PERF_READ_IN_TUN);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>    =
 c-&gt;c2.buf =3D c-&gt;c2.buffers-&gt;read_tun_buf;</span><br><span> </spa=
n><br><span> #ifdef _WIN32</span><br><span>@@ -1360,7 +1349,6 @@</span><br>=
<span>     {</span><br><span>         register_signal(c-&gt;sig, SIGTERM, &=
quot;tun-stop&quot;);</span><br><span>         msg(M_INFO, &quot;TUN/TAP in=
terface has been stopped, exiting&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        perf_pop();</span><br><span>         return;</s=
pan><br><span>     }</span><br><span> </span><br><span>@@ -1370,14 +1358,11=
 @@</span><br><span>         register_signal(c-&gt;sig, SIGHUP, &quot;tun-a=
bort&quot;);</span><br><span>         c-&gt;persist.restart_sleep_seconds =
=3D 10;</span><br><span>         msg(M_INFO, &quot;TUN/TAP I/O operation ab=
orted, restarting&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        perf_pop();</span><br><span>         return;</span><br><span>  =
   }</span><br><span> </span><br><span>     /* Check the status return from=
 read() */</span><br><span>     check_status(c-&gt;c2.buf.len, &quot;read f=
rom TUN/TAP&quot;, NULL, c-&gt;c1.tuntap);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    perf_pop();</span><br><span> }</span><br><span> </span><br><span> /**</=
span><br><span>@@ -1497,8 +1482,6 @@</span><br><span> {</span><br><span>   =
  struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    perf_push(PERF_PROC_IN_TUN);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (c-&gt;=
c2.buf.len &gt; 0)</span><br><span>     {</span><br><span>         c-&gt;c2=
.tun_read_bytes +=3D c-&gt;c2.buf.len;</span><br><span>@@ -1542,7 +1525,6 @=
@</span><br><span>     {</span><br><span>         buf_reset(&amp;c-&gt;c2.t=
o_link);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    perf_pop();</span><br><span>     gc_free(&amp;gc);</span><br>=
<span> }</span><br><span> </span><br><span>@@ -1770,8 +1752,6 @@</span><br>=
<span>     struct gc_arena gc =3D gc_new();</span><br><span>     int error_=
code =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    perf_push(PERF_PROC_OUT_LINK);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span>     if (c-&gt;c2.to_link.len &gt; 0 =
&amp;&amp; c-&gt;c2.to_link.len &lt;=3D c-&gt;c2.frame.buf.payload_size)</s=
pan><br><span>     {</span><br><span>         /*</span><br><span>@@ -1899,7=
 +1879,6 @@</span><br><span> </span><br><span>     buf_reset(&amp;c-&gt;c2.=
to_link);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    perf_pop();</span><br><span>     gc_free(&amp;gc);</span><br><spa=
n> }</span><br><span> </span><br><span>@@ -1919,8 +1898,6 @@</span><br><spa=
n>         return;</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    perf_push(PERF_PROC_OUT_TUN);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /*<=
/span><br><span>      * The --mssfix option requires</span><br><span>      =
* us to examine the IP header (IPv4 or IPv6).</span><br><span>@@ -1993,8 +1=
970,6 @@</span><br><span>     }</span><br><span> </span><br><span>     buf_=
reset(&amp;c-&gt;c2.to_tun);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_pop()=
;</span><br><span> }</span><br><span> </span><br><span> #if defined(__GNUC_=
_) || defined(__clang__)</span><br><span>diff --git a/src/openvpn/multi.c b=
/src/openvpn/multi.c</span><br><span>index fa9c654..f60944d 100644</span><b=
r><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c=
</span><br><span>@@ -580,8 +580,6 @@</span><br><span> void</span><br><span>=
 multi_close_instance(struct multi_context *m, struct multi_instance *mi, b=
ool shutdown)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    perf_push(PERF_MULTI_CLOSE_INSTANCE);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(!mi-&gt;halt);=
</span><br><span>     mi-&gt;halt =3D true;</span><br><span>     bool is_dg=
ram =3D proto_is_dgram(mi-&gt;context.c2.link_sockets[0]-&gt;info.proto);</=
span><br><span>@@ -672,8 +670,6 @@</span><br><span>      * vhash reaper dea=
l with it.</span><br><span>      */</span><br><span>     multi_instance_dec=
_refcount(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_pop();</span><br><s=
pan> }</span><br><span> </span><br><span> /*</span><br><span>@@ -734,8 +730=
,6 @@</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span=
>     struct multi_instance *mi;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    perf_push(PERF_MULTI_CREATE_INSTANCE);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     msg=
(D_MULTI_MEDIUM, &quot;MULTI: multi_create_instance called&quot;);</span><b=
r><span> </span><br><span>     ALLOC_OBJ_CLEAR(mi, struct multi_instance);<=
/span><br><span>@@ -807,13 +801,11 @@</span><br><span>     mi-&gt;ev_arg.ty=
pe =3D EVENT_ARG_MULTI_INSTANCE;</span><br><span>     mi-&gt;ev_arg.u.mi =
=3D mi;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    perf_pop();</span><br><span>     gc_free(&amp;gc);</span><br><span>=
     return mi;</span><br><span> </span><br><span> err:</span><br><span>   =
  multi_close_instance(m, mi, false);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    perf_pop();</span><br><span>     gc_free(&amp;gc);</spa=
n><br><span>     return NULL;</span><br><span> }</span><br><span>@@ -2907,7=
 +2899,6 @@</span><br><span> </span><br><span>     if (BLEN(buf) &gt; 0)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       perf_push(PERF_MULTI_BCAST);</span><br><span> #ifdef MULTI_DEBUG_EVE=
NT_LOOP</span><br><span>         printf(&quot;BCAST len=3D%d\n&quot;, BLEN(=
buf));</span><br><span> #endif</span><br><span>@@ -2929,7 +2920,6 @@</span>=
<br><span> </span><br><span>         hash_iterator_free(&amp;hi);</span><br=
><span>         mbuf_free_buf(mb);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        perf_pop();</span><br><span>     }</span><br><span> }<=
/span><br><span> </span><br><span>@@ -3399,7 +3389,6 @@</span><br><span> </=
span><br><span>             /* decrypt in instance context */</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-            perf_=
push(PERF_PROC_IN_LINK);</span><br><span>             lsi =3D &amp;sock-&gt=
;info;</span><br><span>             orig_buf =3D c-&gt;c2.buf.data;</span><=
br><span>             if (process_incoming_link_part1(c, lsi, floated))</sp=
an><br><span>@@ -3412,7 +3401,6 @@</span><br><span> </span><br><span>      =
           process_incoming_link_part2(c, lsi, orig_buf);</span><br><span> =
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    perf_pop();</span><br><span> </span><br><span>             if (TUNNEL_T=
YPE(m-&gt;top.c1.tuntap) =3D=3D DEV_TYPE_TUN)</span><br><span>             =
{</span><br><span>@@ -4180,8 +4168,6 @@</span><br><span> </span><br><span> =
    while (true)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        perf_push(PERF_EVENT_LOOP);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         /* wait on tun/so=
cket list */</span><br><span>         multi_get_timeout(multi, &amp;multi-&=
gt;top.c2.timeval);</span><br><span>         status =3D multi_io_wait(multi=
);</span><br><span>@@ -4202,7 +4188,6 @@</span><br><span>         }</span><=
br><span> </span><br><span>         MULTI_CHECK_SIG(multi);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        perf_pop();</span><br><span> =
    }</span><br><span> }</span><br><span> </span><br><span>diff --git a/src=
/openvpn/multi.h b/src/openvpn/multi.h</span><br><span>index 97bbc4a..594ea=
3a 100644</span><br><span>--- a/src/openvpn/multi.h</span><br><span>+++ b/s=
rc/openvpn/multi.h</span><br><span>@@ -38,7 +38,6 @@</span><br><span> #incl=
ude &quot;mudp.h&quot;</span><br><span> #include &quot;mtcp.h&quot;</span><=
br><span> #include &quot;multi_io.h&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#include &quot;perf.h&quot;</span><br><span> #include &=
quot;vlan.h&quot;</span><br><span> #include &quot;reflect_filter.h&quot;</s=
pan><br><span> </span><br><span>diff --git a/src/openvpn/multi_io.c b/src/o=
penvpn/multi_io.c</span><br><span>index 0bfbb63..6e31687 100644</span><br><=
span>--- a/src/openvpn/multi_io.c</span><br><span>+++ b/src/openvpn/multi_i=
o.c</span><br><span>@@ -242,9 +242,7 @@</span><br><span>             tun_in=
put_pending =3D NULL;</span><br><span>             /* For some reason, the =
Linux 2.2 TUN/TAP driver hits this timeout */</span><br><span>             =
c-&gt;c2.timeval.tv_sec =3D 1;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            perf_push(PERF_PROC_OUT_TUN_MTCP);</span><br><span>   =
          io_wait(c, IOW_TO_TUN);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            perf_pop();</span><br><span>             break;</sp=
an><br><span> </span><br><span>         case TA_SOCKET_WRITE:</span><br><sp=
an>diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c</span><br><sp=
an>index 64b4f8c..eaaa59b 100644</span><br><span>--- a/src/openvpn/openvpn.=
c</span><br><span>+++ b/src/openvpn/openvpn.c</span><br><span>@@ -72,8 +72,=
6 @@</span><br><span>     /* main event loop */</span><br><span>     while =
(true)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        perf_push(PERF_EVENT_LOOP);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span>         /* process timers, TLS, etc=
. */</span><br><span>         pre_select(c);</span><br><span>         P2P_C=
HECK_SIG();</span><br><span>@@ -85,15 +83,12 @@</span><br><span>         /*=
 timeout? */</span><br><span>         if (c-&gt;c2.event_set_status =3D=3D =
ES_TIMEOUT)</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            perf_pop();</span><br><span>             conti=
nue;</span><br><span>         }</span><br><span> </span><br><span>         =
/* process the I/O which triggered select */</span><br><span>         proce=
ss_io(c, c-&gt;c2.link_sockets[0]);</span><br><span>         P2P_CHECK_SIG(=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        perf_pop();</span><br><span>    =
 }</span><br><span> </span><br><span>     persist_client_stats(c);</span><b=
r><span>diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h</span><b=
r><span>index cd99cd4..a198fcf 100644</span><br><span>--- a/src/openvpn/ope=
nvpn.h</span><br><span>+++ b/src/openvpn/openvpn.h</span><br><span>@@ -524,=
7 +524,6 @@</span><br><span>     if (IS_SIG(c))                            =
\</span><br><span>     {                                         \</span><b=
r><span>         const int brk =3D func(arg);            \</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        perf_pop();                   =
        \</span><br><span>         if (brk)                              \<=
/span><br><span>         {                                     \</span><br>=
<span>             break;                            \</span><br><span>diff=
 --git a/src/openvpn/perf.c b/src/openvpn/perf.c</span><br><span>deleted fi=
le mode 100644</span><br><span>index 51c1a97..0000000</span><br><span>--- a=
/src/openvpn/perf.c</span><br><span>+++ /dev/null</span><br><span>@@ -1,306=
 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *  OpenVPN -- An application to=
 securely tunnel IP networks</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *             over a single TCP/UDP port, with support for SSL/TLS-=
based</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *             s=
ession authentication and key exchange,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *             packet encryption, packet authentication, =
and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *             pac=
ket compression.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2002-2=
025 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*  This program is free software; you can redistribute it and/or modify</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  it under the terms of=
 the GNU General Public License version 2</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *  as published by the Free Software Foundation.</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *  This program is distributed in the hope th=
at it will be useful,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *  MERCHANTABILITY or FITNESS=
 FOR A PARTICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *  GNU General Public License for more details.</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- *  You should have received a copy of the GNU Genera=
l Public License along</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *  with this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#include &quot;config.h&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;=
syshead.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;perf.h&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_PERFORMANCE_METRICS</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#include &quot;error.h&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#include &quot;otime.h&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#include &quot;memdbg.h&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static const char *metric_names[] =3D { &quot;PERF_BIO_READ_PLAINTEXT&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                       &quot;PERF_BIO_WRITE_PLAINTEXT&quot;,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                    =
  &quot;PERF_BIO_READ_CIPHERTEXT&quot;,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                      &quot;PERF_BIO_WRIT=
E_CIPHERTEXT&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                                    &quot;PERF_TLS_MULTI_PROCESS&quot;,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
             &quot;PERF_IO_WAIT&quot;,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                      &quot;PERF_EVENT_LOO=
P&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                         &quot;PERF_MULTI_CREATE_INSTANCE&quot;,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                                =
      &quot;PERF_MULTI_CLOSE_INSTANCE&quot;,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                                      &quot;PERF_MUL=
TI_SHOW_STATS&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                     &quot;PERF_MULTI_BCAST&quot;,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
        &quot;PERF_MULTI_MCAST&quot;,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                                      &quot;PERF_SCRIPT&quo=
t;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
                    &quot;PERF_READ_IN_LINK&quot;,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                      &quot;PE=
RF_PROC_IN_LINK&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                      &quot;PERF_READ_IN_TUN&quot;,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
          &quot;PERF_PROC_IN_TUN&quot;,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                      &quot;PERF_PROC_OUT=
_LINK&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                             &quot;PERF_PROC_OUT_TUN&quot;,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                     =
 &quot;PERF_PROC_OUT_TUN_MTCP&quot; };</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stru=
ct perf</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define PS_INITIAL           0</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PS_METER_RUNNING =
    1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PS_METER=
_INTERRUPTED 2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int=
 state;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct timeval start;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    double sofar;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    double sum;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    double max;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    double count;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct perf_set<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    int stack_len;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int stack[STACK_N];</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    struct perf perf[PERF_N];</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-static struct perf_set perf_set;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static v=
oid perf_print_state(int lev);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inlin=
e int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_stack_index(=
int sdelta)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    const int sindex =3D perf_=
set.stack_len + sdelta;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (sindex &gt;=3D 0 &amp;&amp; sindex &lt; STACK_N)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        return sindex;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return -1;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static i=
nt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_perf_index(int =
sdelta)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    const int sindex =3D get_stack=
_index(sdelta);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (sindex &gt;=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const int =
pindex =3D perf_set.stack[sindex];</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (pindex &gt;=3D 0 &amp;&amp; pindex &lt; PERF_N)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            return pindex;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            return -1;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return -1;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static struct perf *</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-get_perf(int sdelta)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    const int pindex =3D get_perf_index(sdelta);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (pindex &gt;=3D =
0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        return &amp;perf_set.perf[p=
index];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return NULL;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-push_perf_index(int pindex)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    const int sindex =3D get_stack_index(0);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const int newlen =3D get_stack_index(1)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (sindex &gt;=
=3D 0 &amp;&amp; newlen &gt;=3D 0 &amp;&amp; pindex &gt;=3D 0 &amp;&amp; pi=
ndex &lt; PERF_N)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt=
; sindex; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (per=
f_set.stack[i] =3D=3D pindex)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                perf_print_state(M_INFO);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                msg(M_FATAL, &quot;PERF: push_perf_inde=
x %s failed&quot;, metric_names[pindex]);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_set.stac=
k[sindex] =3D pindex;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        perf_set.stack_len =3D newlen;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_FATAL, &quot;P=
ERF: push_perf_index: stack push error&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-pop_perf_index(void)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    const int newlen =3D get_stack_index(-1);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (newlen &gt;=3D 0)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        perf_set.stack_len =3D newlen;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    msg(M_FATAL, &quot;PERF: pop_perf_index: stack pop error&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-state_must_be(const=
 struct perf *p, const int wanted)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(p-&gt;state !=3D wanted)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(=
M_FATAL, &quot;PERF: bad state actual=3D%d wanted=3D%d&quot;, p-&gt;state, =
wanted);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-updat=
e_sofar(struct perf *p)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct timeval=
 current;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(!=
gettimeofday(&amp;current, NULL));</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    p-&gt;sofar +=3D (double)tv_subtract(&amp;current, &amp;p-=
&gt;start, 600) / 1000000.0;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    tv_clear(&amp;p-&gt;start);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-perf_start(struct perf *p)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    state_must_be(p, PS_INITIAL);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(!gettimeofday(&amp;p-&gt;s=
tart, NULL));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p-&g=
t;sofar =3D 0.0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p=
-&gt;state =3D PS_METER_RUNNING;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-perf_stop(struct perf *p)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    state_must_be(p, PS_METER_RUNNING);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    update_sofar(p);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    p-&gt;sum +=3D p-&gt;sofar;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (p-&gt;sofar &gt; p-&g=
t;max)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        p-&gt;max =3D p-&gt;sof=
ar;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;count +=3D 1.0;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;sofar =3D 0.0;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    p-&gt;state =3D PS_INIT=
IAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-perf_interrupt(struct perf *p)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
state_must_be(p, PS_METER_RUNNING);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    update_sofar(p);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    p-&gt;state =3D PS_METER_INTERRUPTED;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-perf_resume(struct=
 perf *p)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    state_must_be(p, PS_METER_IN=
TERRUPTED);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT=
(!gettimeofday(&amp;p-&gt;start, NULL));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    p-&gt;state =3D PS_METER_RUNNING;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-perf_push(int type)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct perf *prev;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct perf *cur;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ASSERT(SIZE(metric_names) =3D=3D PERF_N);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    push_perf_index(type);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    prev =3D get_perf(-2);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    cur =3D get_perf(-1);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    ASSERT(cur);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (prev)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        perf_interrupt(prev);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    perf_start(cur);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-perf_pop(void)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct perf *prev;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    struct perf *cur;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    pr=
ev =3D get_perf(-2);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   cur =3D get_perf(-1);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(cur);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_stop(cur);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (prev)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        perf_resume(prev);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    pop_perf_index();</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-perf_outpu=
t_results(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    msg(M_INFO, &quot;LATENCY PROFILE=
 (mean and max are in milliseconds)&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; PERF_N; ++i)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        struct perf *p =3D &amp;perf_set.perf[i];</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (p-&gt;count &=
gt; 0.0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            const double =
mean =3D p-&gt;sum / p-&gt;count;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            msg(M_INFO, &quot;%s n=3D%.0f mean=3D%.3f max=3D%.3=
f&quot;, metric_names[i], p-&gt;count, mean * 1000.0,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                p-&gt;max * 1000.0);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-perf_print_state(int lev)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(lev, &quot;PERF STATE&quot;);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(lev, &quot;Stack:&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D =
0; i &lt; perf_set.stack_len; ++i)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     const int j =3D perf_set.stack[i];</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        const struct perf *p =3D &amp;perf_set.perf[j];</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(lev, &quot;=
[%d] %s state=3D%d start=3D%s sofar=3D%f sum=3D%f max=3D%f count=3D%f&quot;=
, i, metric_names[j],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            p-&gt;state, tv_string(&amp;p-&gt;start, &amp;gc), p-&gt;sofar,=
 p-&gt;sum, p-&gt;max, p-&gt;count);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABL=
E_PERFORMANCE_METRICS */</span><br><span>diff --git a/src/openvpn/perf.h b/=
src/openvpn/perf.h</span><br><span>deleted file mode 100644</span><br><span=
>index 2a178a1..0000000</span><br><span>--- a/src/openvpn/perf.h</span><br>=
<span>+++ /dev/null</span><br><span>@@ -1,91 +0,0 @@</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  OpenVPN -- An application to securely tunnel IP networks</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">- *             over a s=
ingle TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *             session authentication and key =
exchange,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *          =
   packet encryption, packet authentication, and</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *             packet compression.</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *  Copyright (C) 2002-2025 OpenVPN Inc &lt;sales@...1696...=
15...&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *  This program is free softwa=
re; you can redistribute it and/or modify</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *  it under the terms of the GNU General Public Licens=
e version 2</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  as pub=
lished by the Free Software Foundation.</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
*  This program is distributed in the hope that it will be useful,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *  but WITHOUT ANY WARRANTY; =
without even the implied warranty of</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  Se=
e the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  GNU General =
Public License for more details.</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  You =
should have received a copy of the GNU General Public License along</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not=
, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * The interval_ routines are desig=
ned to optimize the calling of a routine</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * (normally tls_multi_process()) which can be called le=
ss frequently</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * betwe=
en triggers.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#ifndef PERF_H</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define PERF_H</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*#defin=
e ENABLE_PERFORMANCE_METRICS*/</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * Metrics</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define PERF_BIO_READ_PLAINTEXT    0</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define PERF_BIO_WRITE_PLAINTEXT   1</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define PERF_BIO_READ_CIPHER=
TEXT   2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PERF_=
BIO_WRITE_CIPHERTEXT  3</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define PERF_TLS_MULTI_PROCESS     4</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define PERF_IO_WAIT               5</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define PERF_EVENT_LOOP            6</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define PERF_MULTI_CREATE_IN=
STANCE 7</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PERF_=
MULTI_CLOSE_INSTANCE  8</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define PERF_MULTI_SHOW_STATS      9</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define PERF_MULTI_BCAST           10</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define PERF_MULTI_MCAST           11</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PERF_SCRIPT       =
         12</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PE=
RF_READ_IN_LINK          13</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define PERF_PROC_IN_LINK          14</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define PERF_READ_IN_TUN           15</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define PERF_PROC_IN_TUN           16=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define PERF_PROC_OUT=
_LINK         17</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne PERF_PROC_OUT_TUN          18</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define PERF_PROC_OUT_TUN_MTCP     19</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define PERF_N                     20</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#ifdef ENABLE_PERFORMANCE_METRICS</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#include &quot;basic.h&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Stack size</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#define STACK_N 64</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-void perf_push(int type);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void perf_po=
p(void);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-void perf_output_results(void);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#else  /* ifdef ENABLE_PERFORMANCE_METRICS =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-perf_push(int type)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static i=
nline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-perf_pop(vo=
id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static inline void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-perf_output_results(void)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef ENABLE_PERFORMANCE_METRICS =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef PERF_H */</span><br><sp=
an>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index=
 567560f..908854a 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br>=
<span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -47,7 +47,6 @@</span><br><=
span> #include &quot;misc.h&quot;</span><br><span> #include &quot;fdmisc.h&=
quot;</span><br><span> #include &quot;interval.h&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#include &quot;perf.h&quot;</span><br><spa=
n> #include &quot;status.h&quot;</span><br><span> #include &quot;gremlin.h&=
quot;</span><br><span> #include &quot;pkcs11.h&quot;</span><br><span>@@ -32=
20,8 +3219,6 @@</span><br><span>     int active =3D TLSMP_INACTIVE;</span><=
br><span>     bool error =3D false;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    perf_push(PERF_TLS_MULTI_PROCESS);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     tls_=
clear_error();</span><br><span> </span><br><span>     /*</span><br><span>@@=
 -3413,7 +3410,6 @@</span><br><span>     }</span><br><span> #endif</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_pop=
();</span><br><span>     gc_free(&amp;gc);</span><br><span> </span><br><spa=
n>     return (tas =3D=3D TLS_AUTHENTICATION_FAILED) ? TLSMP_KILL : active;=
</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_m=
bedtls.c</span><br><span>index 80eb51b..488f9b9 100644</span><br><span>--- =
a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c=
</span><br><span>@@ -1286,14 +1286,12 @@</span><br><span> key_state_write_p=
laintext_const(struct key_state_ssl *ks, const uint8_t *data, int len)</spa=
n><br><span> {</span><br><span>     int retval =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    perf_push(PERF_BIO_WRITE_PLAINTEXT);</s=
pan><br><span> </span><br><span>     ASSERT(NULL !=3D ks);</span><br><span>=
     ASSERT(len &gt;=3D 0);</span><br><span> </span><br><span>     if (0 =
=3D=3D len)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        perf_pop();</span><br><span>         return 0;</span><=
br><span>     }</span><br><span> </span><br><span>@@ -1303,7 +1301,6 @@</sp=
an><br><span> </span><br><span>     if (retval &lt; 0)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_pop();=
</span><br><span>         if (MBEDTLS_ERR_SSL_WANT_WRITE =3D=3D retval || M=
BEDTLS_ERR_SSL_WANT_READ =3D=3D retval)</span><br><span>         {</span><b=
r><span>             return 0;</span><br><span>@@ -1316,14 +1313,12 @@</spa=
n><br><span>     {</span><br><span>         msg(D_TLS_ERRORS, &quot;TLS ERR=
OR: write tls_write_plaintext_const incomplete %d/%d&quot;, retval,</span><=
br><span>             len);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        perf_pop();</span><br><span>         return -1;</span><br><sp=
an>     }</span><br><span> </span><br><span>     /* successful write */</sp=
an><br><span>     dmsg(D_HANDSHAKE_VERBOSE, &quot;write tls_write_plaintext=
_const %d bytes&quot;, retval);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    perf_pop();</span><br><span>     return 1;<=
/span><br><span> }</span><br><span> </span><br><span>@@ -1333,15 +1328,12 @=
@</span><br><span>     int retval =3D 0;</span><br><span>     int len =3D 0=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  perf_push(PERF_BIO_READ_CIPHERTEXT);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span>     ASSERT(NULL !=3D ks);</span><br><spa=
n>     ASSERT(buf);</span><br><span>     ASSERT(buf-&gt;len &gt;=3D 0);</sp=
an><br><span> </span><br><span>     if (buf-&gt;len)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_pop();</=
span><br><span>         return 0;</span><br><span>     }</span><br><span> <=
/span><br><span>@@ -1352,7 +1344,6 @@</span><br><span>     /* Error during =
read, check for retry error */</span><br><span>     if (retval &lt; 0)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     perf_pop();</span><br><span>         if (MBEDTLS_ERR_SSL_WANT_WRITE =
=3D=3D retval || MBEDTLS_ERR_SSL_WANT_READ =3D=3D retval)</span><br><span> =
        {</span><br><span>             return 0;</span><br><span>@@ -1365,1=
4 +1356,12 @@</span><br><span>     if (0 =3D=3D retval)</span><br><span>   =
  {</span><br><span>         buf-&gt;len =3D 0;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        perf_pop();</span><br><span>         retu=
rn 0;</span><br><span>     }</span><br><span> </span><br><span>     /* succ=
essful read */</span><br><span>     dmsg(D_HANDSHAKE_VERBOSE, &quot;read tl=
s_read_ciphertext %d bytes&quot;, retval);</span><br><span>     buf-&gt;len=
 =3D retval;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_=
pop();</span><br><span>     return 1;</span><br><span> }</span><br><span> <=
/span><br><span>@@ -1380,7 +1369,6 @@</span><br><span> key_state_write_ciph=
ertext(struct key_state_ssl *ks, struct buffer *buf)</span><br><span> {</sp=
an><br><span>     int retval =3D 0;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    perf_push(PERF_BIO_WRITE_CIPHERTEXT);</span><br><span> </=
span><br><span>     ASSERT(NULL !=3D ks);</span><br><span>     ASSERT(buf);=
</span><br><span>@@ -1388,7 +1376,6 @@</span><br><span> </span><br><span>  =
   if (0 =3D=3D buf-&gt;len)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        perf_pop();</span><br><span>       =
  return 0;</span><br><span>     }</span><br><span> </span><br><span>@@ -13=
96,8 +1383,6 @@</span><br><span> </span><br><span>     if (retval &lt; 0)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        perf_pop();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span>         if (MBEDTLS_ERR_SSL_WANT_WRITE =3D=3D retval || MBE=
DTLS_ERR_SSL_WANT_READ =3D=3D retval)</span><br><span>         {</span><br>=
<span>             return 0;</span><br><span>@@ -1410,7 +1395,6 @@</span><b=
r><span>     {</span><br><span>         msg(D_TLS_ERRORS, &quot;TLS ERROR: =
write tls_write_ciphertext incomplete %d/%d&quot;, retval,</span><br><span>=
             buf-&gt;len);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        perf_pop();</span><br><span>         return -1;</span><br><spa=
n>     }</span><br><span> </span><br><span>@@ -1420,7 +1404,6 @@</span><br>=
<span>     memset(BPTR(buf), 0, BLEN(buf)); /* erase data just written */</=
span><br><span>     buf-&gt;len =3D 0;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    perf_pop();</span><br><span>     ret=
urn 1;</span><br><span> }</span><br><span> </span><br><span>@@ -1430,15 +14=
13,12 @@</span><br><span>     int retval =3D 0;</span><br><span>     int le=
n =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    perf_push(PERF_BIO_READ_PLAINTEXT);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(NULL !=3D ks);</span><b=
r><span>     ASSERT(buf);</span><br><span>     ASSERT(buf-&gt;len &gt;=3D 0=
);</span><br><span> </span><br><span>     if (buf-&gt;len)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_po=
p();</span><br><span>         return 0;</span><br><span>     }</span><br><s=
pan> </span><br><span>@@ -1455,14 +1435,12 @@</span><br><span>         }</s=
pan><br><span>         mbed_log_err(D_TLS_ERRORS, retval, &quot;TLS_ERROR: =
read tls_read_plaintext error&quot;);</span><br><span>         buf-&gt;len =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_po=
p();</span><br><span>         return -1;</span><br><span>     }</span><br><=
span>     /* Nothing read, try again */</span><br><span>     if (0 =3D=3D r=
etval)</span><br><span>     {</span><br><span>         buf-&gt;len =3D 0;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_pop();</sp=
an><br><span>         return 0;</span><br><span>     }</span><br><span> </s=
pan><br><span>@@ -1470,7 +1448,6 @@</span><br><span>     dmsg(D_HANDSHAKE_V=
ERBOSE, &quot;read tls_read_plaintext %d bytes&quot;, retval);</span><br><s=
pan>     buf-&gt;len =3D retval;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    perf_pop();</span><br><span>     return 1;=
</span><br><span> }</span><br><span> </span><br><span>diff --git a/src/open=
vpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index 434df7d=
..d997141 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</span><br>=
<span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -2208,14 +2208,12 =
@@</span><br><span> key_state_write_plaintext(struct key_state_ssl *ks_ssl,=
 struct buffer *buf)</span><br><span> {</span><br><span>     int ret =3D 0;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_push(PERF_BI=
O_WRITE_PLAINTEXT);</span><br><span> </span><br><span>     ASSERT(NULL !=3D=
 ks_ssl);</span><br><span> </span><br><span>     ret =3D bio_write(ks_ssl-&=
gt;ssl_bio, BPTR(buf), BLEN(buf), &quot;tls_write_plaintext&quot;);</span><=
br><span>     bio_write_post(ret, buf);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    perf_pop();</span><br><span>     re=
turn ret;</span><br><span> }</span><br><span> </span><br><span>@@ -2223,13 =
+2221,11 @@</span><br><span> key_state_write_plaintext_const(struct key_sta=
te_ssl *ks_ssl, const uint8_t *data, int len)</span><br><span> {</span><br>=
<span>     int ret =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    perf_push(PERF_BIO_WRITE_PLAINTEXT);</span><br><span> </span><br><s=
pan>     ASSERT(NULL !=3D ks_ssl);</span><br><span> </span><br><span>     r=
et =3D bio_write(ks_ssl-&gt;ssl_bio, data, len, &quot;tls_write_plaintext_c=
onst&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    perf_pop();</span><br><span>     return ret;</span><br><span> =
}</span><br><span> </span><br><span>@@ -2237,13 +2233,11 @@</span><br><span=
> key_state_read_ciphertext(struct key_state_ssl *ks_ssl, struct buffer *bu=
f)</span><br><span> {</span><br><span>     int ret =3D 0;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    perf_push(PERF_BIO_READ_CIPHERTEXT)=
;</span><br><span> </span><br><span>     ASSERT(NULL !=3D ks_ssl);</span><b=
r><span> </span><br><span>     ret =3D bio_read(ks_ssl-&gt;ct_out, buf, &qu=
ot;tls_read_ciphertext&quot;);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    perf_pop();</span><br><span>     return ret;=
</span><br><span> }</span><br><span> </span><br><span>@@ -2251,14 +2245,12 =
@@</span><br><span> key_state_write_ciphertext(struct key_state_ssl *ks_ssl=
, struct buffer *buf)</span><br><span> {</span><br><span>     int ret =3D 0=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_push(PERF_B=
IO_WRITE_CIPHERTEXT);</span><br><span> </span><br><span>     ASSERT(NULL !=
=3D ks_ssl);</span><br><span> </span><br><span>     ret =3D bio_write(ks_ss=
l-&gt;ct_in, BPTR(buf), BLEN(buf), &quot;tls_write_ciphertext&quot;);</span=
><br><span>     bio_write_post(ret, buf);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    perf_pop();</span><br><span>     =
return ret;</span><br><span> }</span><br><span> </span><br><span>@@ -2266,1=
3 +2258,11 @@</span><br><span> key_state_read_plaintext(struct key_state_ss=
l *ks_ssl, struct buffer *buf)</span><br><span> {</span><br><span>     int =
ret =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_pu=
sh(PERF_BIO_READ_PLAINTEXT);</span><br><span> </span><br><span>     ASSERT(=
NULL !=3D ks_ssl);</span><br><span> </span><br><span>     ret =3D bio_read(=
ks_ssl-&gt;ssl_bio, buf, &quot;tls_read_plaintext&quot;);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    perf_pop();</span=
><br><span>     return ret;</span><br><span> }</span><br><span> </span><br>=
<span>diff --git a/src/openvpn/status.c b/src/openvpn/status.c</span><br><s=
pan>index 1e1e3fb..5ca33cb 100644</span><br><span>--- a/src/openvpn/status.=
c</span><br><span>+++ b/src/openvpn/status.c</span><br><span>@@ -27,7 +27,6=
 @@</span><br><span> #include &quot;syshead.h&quot;</span><br><span> </span=
><br><span> #include &quot;status.h&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#include &quot;perf.h&quot;</span><br><span> #include &=
quot;misc.h&quot;</span><br><span> #include &quot;fdmisc.h&quot;</span><br>=
<span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1303?usp=3Demail">change 1303</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1303?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--TUHb5yE4YEY=--

