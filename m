From: Gert Doering <gert@...1296...>
Date: Sun, 26 Oct 2025 15:20:52 +0100
Message-ID: <20251026142100.12147-1-gert@...1296...>
In-Reply-To: <gerrit.1761487758000.I5bb666a73b4381066e86f53d957e1987fa07303b@...2715...>
References: <gerrit.1761487758000.I5bb666a73b4381066e86f53d957e1987fa07303b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove perf.c/perf.h
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

From: Steffan Karger <steffan@...1856...>

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
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1303
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
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
-        if (status == OPENVPN_EXIT_STATUS_GOOD)
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
 event_wait(struct event_set *es, const struct timeval *tv, struct event_set_return *out, int outlen)
 {
     int ret;
-    perf_push(PERF_IO_WAIT);
     ret = (*es->func.wait)(es, tv, out, outlen);
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
     c->c2.buf = c->c2.buffers->read_link_buf;
     ASSERT(buf_init(&c->c2.buf, c->c2.frame.buf.headroom));
 
@@ -966,7 +964,6 @@
                 msg(D_STREAM_ERRORS, "Connection reset, restarting [%d]", status);
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
     struct link_socket_info *lsi = &sock->info;
     const uint8_t *orig_buf = c->c2.buf.data;
 
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
     c->c2.buf = c->c2.buffers->read_tun_buf;
 
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
         c->persist.restart_sleep_seconds = 10;
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
     struct gc_arena gc = gc_new();
 
-    perf_push(PERF_PROC_IN_TUN);
-
     if (c->c2.buf.len > 0)
     {
         c->c2.tun_read_bytes += c->c2.buf.len;
@@ -1542,7 +1525,6 @@
     {
         buf_reset(&c->c2.to_link);
     }
-    perf_pop();
     gc_free(&gc);
 }
 
@@ -1770,8 +1752,6 @@
     struct gc_arena gc = gc_new();
     int error_code = 0;
 
-    perf_push(PERF_PROC_OUT_LINK);
-
     if (c->c2.to_link.len > 0 && c->c2.to_link.len <= c->c2.frame.buf.payload_size)
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
 multi_close_instance(struct multi_context *m, struct multi_instance *mi, bool shutdown)
 {
-    perf_push(PERF_MULTI_CLOSE_INSTANCE);
-
     ASSERT(!mi->halt);
     mi->halt = true;
     bool is_dgram = proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto);
@@ -672,8 +670,6 @@
      * vhash reaper deal with it.
      */
     multi_instance_dec_refcount(mi);
-
-    perf_pop();
 }
 
 /*
@@ -734,8 +730,6 @@
     struct gc_arena gc = gc_new();
     struct multi_instance *mi;
 
-    perf_push(PERF_MULTI_CREATE_INSTANCE);
-
     msg(D_MULTI_MEDIUM, "MULTI: multi_create_instance called");
 
     ALLOC_OBJ_CLEAR(mi, struct multi_instance);
@@ -807,13 +801,11 @@
     mi->ev_arg.type = EVENT_ARG_MULTI_INSTANCE;
     mi->ev_arg.u.mi = mi;
 
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
         printf("BCAST len=%d\n", BLEN(buf));
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
             lsi = &sock->info;
             orig_buf = c->c2.buf.data;
             if (process_incoming_link_part1(c, lsi, floated))
@@ -3412,7 +3401,6 @@
 
                 process_incoming_link_part2(c, lsi, orig_buf);
             }
-            perf_pop();
 
             if (TUNNEL_TYPE(m->top.c1.tuntap) == DEV_TYPE_TUN)
             {
@@ -4180,8 +4168,6 @@
 
     while (true)
     {
-        perf_push(PERF_EVENT_LOOP);
-
         /* wait on tun/socket list */
         multi_get_timeout(multi, &multi->top.c2.timeval);
         status = multi_io_wait(multi);
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
             tun_input_pending = NULL;
             /* For some reason, the Linux 2.2 TUN/TAP driver hits this timeout */
             c->c2.timeval.tv_sec = 1;
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
         if (c->c2.event_set_status == ES_TIMEOUT)
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
         const int brk = func(arg);            \
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
-static const char *metric_names[] = { "PERF_BIO_READ_PLAINTEXT",
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
-    const int sindex = perf_set.stack_len + sdelta;
-    if (sindex >= 0 && sindex < STACK_N)
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
-    const int sindex = get_stack_index(sdelta);
-    if (sindex >= 0)
-    {
-        const int pindex = perf_set.stack[sindex];
-        if (pindex >= 0 && pindex < PERF_N)
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
-    const int pindex = get_perf_index(sdelta);
-    if (pindex >= 0)
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
-    const int sindex = get_stack_index(0);
-    const int newlen = get_stack_index(1);
-    if (sindex >= 0 && newlen >= 0 && pindex >= 0 && pindex < PERF_N)
-    {
-        int i;
-        for (i = 0; i < sindex; ++i)
-        {
-            if (perf_set.stack[i] == pindex)
-            {
-                perf_print_state(M_INFO);
-                msg(M_FATAL, "PERF: push_perf_index %s failed", metric_names[pindex]);
-            }
-        }
-
-        perf_set.stack[sindex] = pindex;
-        perf_set.stack_len = newlen;
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
-    const int newlen = get_stack_index(-1);
-    if (newlen >= 0)
-    {
-        perf_set.stack_len = newlen;
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
-    if (p->state != wanted)
-    {
-        msg(M_FATAL, "PERF: bad state actual=%d wanted=%d", p->state, wanted);
-    }
-}
-
-static void
-update_sofar(struct perf *p)
-{
-    struct timeval current;
-    ASSERT(!gettimeofday(&current, NULL));
-    p->sofar += (double)tv_subtract(&current, &p->start, 600) / 1000000.0;
-    tv_clear(&p->start);
-}
-
-static void
-perf_start(struct perf *p)
-{
-    state_must_be(p, PS_INITIAL);
-    ASSERT(!gettimeofday(&p->start, NULL));
-    p->sofar = 0.0;
-    p->state = PS_METER_RUNNING;
-}
-
-static void
-perf_stop(struct perf *p)
-{
-    state_must_be(p, PS_METER_RUNNING);
-    update_sofar(p);
-    p->sum += p->sofar;
-    if (p->sofar > p->max)
-    {
-        p->max = p->sofar;
-    }
-    p->count += 1.0;
-    p->sofar = 0.0;
-    p->state = PS_INITIAL;
-}
-
-static void
-perf_interrupt(struct perf *p)
-{
-    state_must_be(p, PS_METER_RUNNING);
-    update_sofar(p);
-    p->state = PS_METER_INTERRUPTED;
-}
-
-static void
-perf_resume(struct perf *p)
-{
-    state_must_be(p, PS_METER_INTERRUPTED);
-    ASSERT(!gettimeofday(&p->start, NULL));
-    p->state = PS_METER_RUNNING;
-}
-
-void
-perf_push(int type)
-{
-    struct perf *prev;
-    struct perf *cur;
-
-    ASSERT(SIZE(metric_names) == PERF_N);
-    push_perf_index(type);
-
-    prev = get_perf(-2);
-    cur = get_perf(-1);
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
-    prev = get_perf(-2);
-    cur = get_perf(-1);
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
-    for (i = 0; i < PERF_N; ++i)
-    {
-        struct perf *p = &perf_set.perf[i];
-        if (p->count > 0.0)
-        {
-            const double mean = p->sum / p->count;
-            msg(M_INFO, "%s n=%.0f mean=%.3f max=%.3f", metric_names[i], p->count, mean * 1000.0,
-                p->max * 1000.0);
-        }
-    }
-}
-
-static void
-perf_print_state(int lev)
-{
-    struct gc_arena gc = gc_new();
-    int i;
-    msg(lev, "PERF STATE");
-    msg(lev, "Stack:");
-    for (i = 0; i < perf_set.stack_len; ++i)
-    {
-        const int j = perf_set.stack[i];
-        const struct perf *p = &perf_set.perf[j];
-        msg(lev, "[%d] %s state=%d start=%s sofar=%f sum=%f max=%f count=%f", i, metric_names[j],
-            p->state, tv_string(&p->start, &gc), p->sofar, p->sum, p->max, p->count);
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
     int active = TLSMP_INACTIVE;
     bool error = false;
 
-    perf_push(PERF_TLS_MULTI_PROCESS);
-
     tls_clear_error();
 
     /*
@@ -3413,7 +3410,6 @@
     }
 #endif
 
-    perf_pop();
     gc_free(&gc);
 
     return (tas == TLS_AUTHENTICATION_FAILED) ? TLSMP_KILL : active;
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 80eb51b..488f9b9 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1286,14 +1286,12 @@
 key_state_write_plaintext_const(struct key_state_ssl *ks, const uint8_t *data, int len)
 {
     int retval = 0;
-    perf_push(PERF_BIO_WRITE_PLAINTEXT);
 
     ASSERT(NULL != ks);
     ASSERT(len >= 0);
 
     if (0 == len)
     {
-        perf_pop();
         return 0;
     }
 
@@ -1303,7 +1301,6 @@
 
     if (retval < 0)
     {
-        perf_pop();
         if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
         {
             return 0;
@@ -1316,14 +1313,12 @@
     {
         msg(D_TLS_ERRORS, "TLS ERROR: write tls_write_plaintext_const incomplete %d/%d", retval,
             len);
-        perf_pop();
         return -1;
     }
 
     /* successful write */
     dmsg(D_HANDSHAKE_VERBOSE, "write tls_write_plaintext_const %d bytes", retval);
 
-    perf_pop();
     return 1;
 }
 
@@ -1333,15 +1328,12 @@
     int retval = 0;
     int len = 0;
 
-    perf_push(PERF_BIO_READ_CIPHERTEXT);
-
     ASSERT(NULL != ks);
     ASSERT(buf);
     ASSERT(buf->len >= 0);
 
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
         if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
         {
             return 0;
@@ -1365,14 +1356,12 @@
     if (0 == retval)
     {
         buf->len = 0;
-        perf_pop();
         return 0;
     }
 
     /* successful read */
     dmsg(D_HANDSHAKE_VERBOSE, "read tls_read_ciphertext %d bytes", retval);
     buf->len = retval;
-    perf_pop();
     return 1;
 }
 
@@ -1380,7 +1369,6 @@
 key_state_write_ciphertext(struct key_state_ssl *ks, struct buffer *buf)
 {
     int retval = 0;
-    perf_push(PERF_BIO_WRITE_CIPHERTEXT);
 
     ASSERT(NULL != ks);
     ASSERT(buf);
@@ -1388,7 +1376,6 @@
 
     if (0 == buf->len)
     {
-        perf_pop();
         return 0;
     }
 
@@ -1396,8 +1383,6 @@
 
     if (retval < 0)
     {
-        perf_pop();
-
         if (MBEDTLS_ERR_SSL_WANT_WRITE == retval || MBEDTLS_ERR_SSL_WANT_READ == retval)
         {
             return 0;
@@ -1410,7 +1395,6 @@
     {
         msg(D_TLS_ERRORS, "TLS ERROR: write tls_write_ciphertext incomplete %d/%d", retval,
             buf->len);
-        perf_pop();
         return -1;
     }
 
@@ -1420,7 +1404,6 @@
     memset(BPTR(buf), 0, BLEN(buf)); /* erase data just written */
     buf->len = 0;
 
-    perf_pop();
     return 1;
 }
 
@@ -1430,15 +1413,12 @@
     int retval = 0;
     int len = 0;
 
-    perf_push(PERF_BIO_READ_PLAINTEXT);
-
     ASSERT(NULL != ks);
     ASSERT(buf);
     ASSERT(buf->len >= 0);
 
     if (buf->len)
     {
-        perf_pop();
         return 0;
     }
 
@@ -1455,14 +1435,12 @@
         }
         mbed_log_err(D_TLS_ERRORS, retval, "TLS_ERROR: read tls_read_plaintext error");
         buf->len = 0;
-        perf_pop();
         return -1;
     }
     /* Nothing read, try again */
     if (0 == retval)
     {
         buf->len = 0;
-        perf_pop();
         return 0;
     }
 
@@ -1470,7 +1448,6 @@
     dmsg(D_HANDSHAKE_VERBOSE, "read tls_read_plaintext %d bytes", retval);
     buf->len = retval;
 
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
     int ret = 0;
-    perf_push(PERF_BIO_WRITE_PLAINTEXT);
 
     ASSERT(NULL != ks_ssl);
 
     ret = bio_write(ks_ssl->ssl_bio, BPTR(buf), BLEN(buf), "tls_write_plaintext");
     bio_write_post(ret, buf);
 
-    perf_pop();
     return ret;
 }
 
@@ -2223,13 +2221,11 @@
 key_state_write_plaintext_const(struct key_state_ssl *ks_ssl, const uint8_t *data, int len)
 {
     int ret = 0;
-    perf_push(PERF_BIO_WRITE_PLAINTEXT);
 
     ASSERT(NULL != ks_ssl);
 
     ret = bio_write(ks_ssl->ssl_bio, data, len, "tls_write_plaintext_const");
 
-    perf_pop();
     return ret;
 }
 
@@ -2237,13 +2233,11 @@
 key_state_read_ciphertext(struct key_state_ssl *ks_ssl, struct buffer *buf)
 {
     int ret = 0;
-    perf_push(PERF_BIO_READ_CIPHERTEXT);
 
     ASSERT(NULL != ks_ssl);
 
     ret = bio_read(ks_ssl->ct_out, buf, "tls_read_ciphertext");
 
-    perf_pop();
     return ret;
 }
 
@@ -2251,14 +2245,12 @@
 key_state_write_ciphertext(struct key_state_ssl *ks_ssl, struct buffer *buf)
 {
     int ret = 0;
-    perf_push(PERF_BIO_WRITE_CIPHERTEXT);
 
     ASSERT(NULL != ks_ssl);
 
     ret = bio_write(ks_ssl->ct_in, BPTR(buf), BLEN(buf), "tls_write_ciphertext");
     bio_write_post(ret, buf);
 
-    perf_pop();
     return ret;
 }
 
@@ -2266,13 +2258,11 @@
 key_state_read_plaintext(struct key_state_ssl *ks_ssl, struct buffer *buf)
 {
     int ret = 0;
-    perf_push(PERF_BIO_READ_PLAINTEXT);
 
     ASSERT(NULL != ks_ssl);
 
     ret = bio_read(ks_ssl->ssl_bio, buf, "tls_read_plaintext");
 
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
 

