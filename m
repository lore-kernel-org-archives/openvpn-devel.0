From: Antonio Quartulli <a@...2181...>
Date: Fri, 11 Aug 2017 17:07:41 +0800
Message-Id: <20170811090744.31750-3-a@...2181...>
In-Reply-To: <20170811090744.31750-1-a@...2181...>
References: <20170811090744.31750-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 2/5] ensure function declarations are
 compiled with their definitions
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

Function prototypes should be included when compiling their
definitions so that it is clear to compilers and static
analyzers that they are not static.

This means that several declarations have to be moved to the
related header files which in turn have to be included by the
source files implementing them.

Generally speaking this also improves the coding style and
makes this code more consistent with the rest that already
follows this rule.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/crypto.h         |  3 +++
 src/openvpn/error.c          |  3 +--
 src/openvpn/forward-inline.h | 28 ++--------------------------
 src/openvpn/forward.h        | 35 +++++++++++++++++++++++++++++++++++
 src/openvpn/init.h           |  2 ++
 src/openvpn/lladdr.c         |  1 +
 src/openvpn/manage.h         | 11 ++++++-----
 src/openvpn/mbuf.h           |  4 ++--
 src/openvpn/mroute.h         | 21 +++++++++++----------
 src/openvpn/multi.h          |  7 +++----
 src/openvpn/occ-inline.h     |  8 ++------
 src/openvpn/occ.h            |  6 ++++++
 src/openvpn/pf-inline.h      |  6 ++----
 src/openvpn/pf.h             |  6 ++++++
 src/openvpn/ping-inline.h    |  6 ++----
 src/openvpn/ping.h           |  4 ++++
 src/openvpn/plugin.h         |  2 ++
 src/openvpn/socket.h         | 13 +++++++------
 18 files changed, 97 insertions(+), 69 deletions(-)

diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index f1b6c20a..5f0790a6 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -467,6 +467,9 @@ void prng_bytes(uint8_t *output, int len);
 
 void prng_uninit(void);
 
+/* an analogue to the random() function, but use prng_bytes */
+long int get_random(void);
+
 void test_crypto(struct crypto_options *co, struct frame *f);
 
 
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 04bf0da5..e885ec3b 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -31,6 +31,7 @@
 
 #include "error.h"
 #include "buffer.h"
+#include "init.h"
 #include "misc.h"
 #include "win32.h"
 #include "socket.h"
@@ -734,8 +735,6 @@ openvpn_exit(const int status)
 {
     if (!forked)
     {
-        void tun_abort();
-
 #ifdef ENABLE_PLUGIN
         void plugin_abort(void);
 
diff --git a/src/openvpn/forward-inline.h b/src/openvpn/forward-inline.h
index ab83ea40..04601e8c 100644
--- a/src/openvpn/forward-inline.h
+++ b/src/openvpn/forward-inline.h
@@ -24,6 +24,8 @@
 #ifndef FORWARD_INLINE_H
 #define FORWARD_INLINE_H
 
+#include "forward.h"
+
 /*
  * Inline functions
  */
@@ -35,8 +37,6 @@ static inline void
 check_tls(struct context *c)
 {
 #if defined(ENABLE_CRYPTO)
-    void check_tls_dowork(struct context *c);
-
     if (c->c2.tls_multi)
     {
         check_tls_dowork(c);
@@ -52,10 +52,6 @@ static inline void
 check_tls_errors(struct context *c)
 {
 #if defined(ENABLE_CRYPTO)
-    void check_tls_errors_co(struct context *c);
-
-    void check_tls_errors_nco(struct context *c);
-
     if (c->c2.tls_multi && c->c2.tls_exit_signal)
     {
         if (link_socket_connection_oriented(c->c2.link_socket))
@@ -84,8 +80,6 @@ static inline void
 check_incoming_control_channel(struct context *c)
 {
 #if P2MP
-    void check_incoming_control_channel_dowork(struct context *c);
-
     if (tls_test_payload_len(c->c2.tls_multi) > 0)
     {
         check_incoming_control_channel_dowork(c);
@@ -100,8 +94,6 @@ check_incoming_control_channel(struct context *c)
 static inline void
 check_connection_established(struct context *c)
 {
-    void check_connection_established_dowork(struct context *c);
-
     if (event_timeout_defined(&c->c2.wait_for_connect))
     {
         check_connection_established_dowork(c);
@@ -114,8 +106,6 @@ check_connection_established(struct context *c)
 static inline void
 check_add_routes(struct context *c)
 {
-    void check_add_routes_dowork(struct context *c);
-
     if (event_timeout_trigger(&c->c2.route_wakeup, &c->c2.timeval, ETT_DEFAULT))
     {
         check_add_routes_dowork(c);
@@ -128,8 +118,6 @@ check_add_routes(struct context *c)
 static inline void
 check_inactivity_timeout(struct context *c)
 {
-    void check_inactivity_timeout_dowork(struct context *c);
-
     if (c->options.inactivity_timeout
         && event_timeout_trigger(&c->c2.inactivity_interval, &c->c2.timeval, ETT_DEFAULT))
     {
@@ -142,8 +130,6 @@ check_inactivity_timeout(struct context *c)
 static inline void
 check_server_poll_timeout(struct context *c)
 {
-    void check_server_poll_timeout_dowork(struct context *c);
-
     if (c->options.ce.connect_timeout
         && event_timeout_trigger(&c->c2.server_poll_interval, &c->c2.timeval, ETT_DEFAULT))
     {
@@ -157,8 +143,6 @@ check_server_poll_timeout(struct context *c)
 static inline void
 check_scheduled_exit(struct context *c)
 {
-    void check_scheduled_exit_dowork(struct context *c);
-
     if (event_timeout_defined(&c->c2.scheduled_exit))
     {
         if (event_timeout_trigger(&c->c2.scheduled_exit, &c->c2.timeval, ETT_DEFAULT))
@@ -175,8 +159,6 @@ check_scheduled_exit(struct context *c)
 static inline void
 check_status_file(struct context *c)
 {
-    void check_status_file_dowork(struct context *c);
-
     if (c->c1.status_output)
     {
         if (status_trigger_tv(c->c1.status_output, &c->c2.timeval))
@@ -193,8 +175,6 @@ check_status_file(struct context *c)
 static inline void
 check_fragment(struct context *c)
 {
-    void check_fragment_dowork(struct context *c);
-
     if (c->c2.fragment)
     {
         check_fragment_dowork(c);
@@ -210,8 +190,6 @@ check_fragment(struct context *c)
 static inline void
 check_push_request(struct context *c)
 {
-    void check_push_request_dowork(struct context *c);
-
     if (event_timeout_trigger(&c->c2.push_request_interval, &c->c2.timeval, ETT_DEFAULT))
     {
         check_push_request_dowork(c);
@@ -313,8 +291,6 @@ p2p_iow_flags(const struct context *c)
 static inline void
 io_wait(struct context *c, const unsigned int flags)
 {
-    void io_wait_dowork(struct context *c, const unsigned int flags);
-
     if (c->c2.fast_io && (flags & (IOW_TO_TUN|IOW_TO_LINK|IOW_MBUF)))
     {
         /* fast path -- only for TUN/TAP/UDP writes */
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 9fde5a30..bc016e5d 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -60,6 +60,41 @@
 
 #define IOW_READ            (IOW_READ_TUN|IOW_READ_LINK)
 
+extern counter_type link_read_bytes_global;
+
+extern counter_type link_write_bytes_global;
+
+#ifdef ENABLE_CRYPTO
+void check_tls_dowork(struct context *c);
+
+void check_tls_errors_co(struct context *c);
+
+void check_tls_errors_nco(struct context *c);
+#endif /* ENABLE_CRYPTO */
+
+#if P2MP
+void check_incoming_control_channel_dowork(struct context *c);
+
+void check_scheduled_exit_dowork(struct context *c);
+
+void check_push_request_dowork(struct context *c);
+#endif /* P2MP */
+
+#ifdef ENABLE_FRAGMENT
+void check_fragment_dowork(struct context *c);
+#endif /* ENABLE_FRAGMENT */
+
+void check_connection_established_dowork(struct context *c);
+
+void check_add_routes_dowork(struct context *c);
+
+void check_inactivity_timeout_dowork(struct context *c);
+
+void check_server_poll_timeout_dowork(struct context *c);
+
+void check_status_file_dowork(struct context *c);
+
+void io_wait_dowork(struct context *c, const unsigned int flags);
 
 void pre_select(struct context *c);
 
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 15feb677..b681cd9d 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -140,4 +140,6 @@ void open_plugins(struct context *c, const bool import_options, int init_point);
 
 #endif
 
+void tun_abort(void);
+
 #endif /* ifndef INIT_H */
diff --git a/src/openvpn/lladdr.c b/src/openvpn/lladdr.c
index ff71e48c..ea35e4d9 100644
--- a/src/openvpn/lladdr.c
+++ b/src/openvpn/lladdr.c
@@ -11,6 +11,7 @@
 #include "syshead.h"
 #include "error.h"
 #include "misc.h"
+#include "lladdr.h"
 
 int
 set_lladdr(const char *ifname, const char *lladdr,
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 676be640..d77e5f18 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -581,6 +581,12 @@ management_bytes_in(struct management *man, const int size)
     }
 }
 
+
+void man_bytecount_output_server(struct management *man,
+                                 const counter_type *bytes_in_total,
+                                 const counter_type *bytes_out_total,
+                                 struct man_def_auth_context *mdac);
+
 #ifdef MANAGEMENT_DEF_AUTH
 
 static inline void
@@ -589,11 +595,6 @@ management_bytes_server(struct management *man,
                         const counter_type *bytes_out_total,
                         struct man_def_auth_context *mdac)
 {
-    void man_bytecount_output_server(struct management *man,
-                                     const counter_type *bytes_in_total,
-                                     const counter_type *bytes_out_total,
-                                     struct man_def_auth_context *mdac);
-
     if (man->connection.bytecount_update_seconds > 0
         && now >= mdac->bytecount_last_update + man->connection.bytecount_update_seconds
         && (mdac->flags & (DAF_CONNECTION_ESTABLISHED|DAF_CONNECTION_CLOSED)) == DAF_CONNECTION_ESTABLISHED)
diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index e0643de1..1c35432f 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -96,11 +96,11 @@ mbuf_maximum_queued(const struct mbuf_set *ms)
     return (int) ms->max_queued;
 }
 
+struct multi_instance *mbuf_peek_dowork(struct mbuf_set *ms);
+
 static inline struct multi_instance *
 mbuf_peek(struct mbuf_set *ms)
 {
-    struct multi_instance *mbuf_peek_dowork(struct mbuf_set *ms);
-
     if (mbuf_defined(ms))
     {
         return mbuf_peek_dowork(ms);
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index cf3be509..19d2899d 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -170,6 +170,17 @@ void mroute_helper_add_iroute46(struct mroute_helper *mh, int netbits);
 
 void mroute_helper_del_iroute46(struct mroute_helper *mh, int netbits);
 
+
+unsigned int mroute_extract_addr_ipv4(struct mroute_addr *src,
+                                      struct mroute_addr *dest,
+                                      const struct buffer *buf);
+
+unsigned int mroute_extract_addr_ether(struct mroute_addr *src,
+                                       struct mroute_addr *dest,
+                                       struct mroute_addr *esrc,
+                                       struct mroute_addr *edest,
+                                       const struct buffer *buf);
+
 /*
  * Given a raw packet in buf, return the src and dest
  * addresses of the packet.
@@ -182,16 +193,6 @@ mroute_extract_addr_from_packet(struct mroute_addr *src,
                                 const struct buffer *buf,
                                 int tunnel_type)
 {
-    unsigned int mroute_extract_addr_ipv4(struct mroute_addr *src,
-                                          struct mroute_addr *dest,
-                                          const struct buffer *buf);
-
-    unsigned int mroute_extract_addr_ether(struct mroute_addr *src,
-                                           struct mroute_addr *dest,
-                                           struct mroute_addr *esrc,
-                                           struct mroute_addr *edest,
-                                           const struct buffer *buf);
-
     unsigned int ret = 0;
     verify_align_4(buf);
     if (tunnel_type == DEV_TYPE_TUN)
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 63afbaf0..5892ac07 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -536,11 +536,12 @@ clear_prefix(void)
  */
 #define MULTI_CACHE_ROUTE_TTL 60
 
+void multi_reap_process_dowork(const struct multi_context *m);
+void multi_process_per_second_timers_dowork(struct multi_context *m);
+
 static inline void
 multi_reap_process(const struct multi_context *m)
 {
-    void multi_reap_process_dowork(const struct multi_context *m);
-
     if (m->reaper->last_call != now)
     {
         multi_reap_process_dowork(m);
@@ -552,8 +553,6 @@ multi_process_per_second_timers(struct multi_context *m)
 {
     if (m->per_second_trigger != now)
     {
-        void multi_process_per_second_timers_dowork(struct multi_context *m);
-
         multi_process_per_second_timers_dowork(m);
         m->per_second_trigger = now;
     }
diff --git a/src/openvpn/occ-inline.h b/src/openvpn/occ-inline.h
index 0fa8e5ba..7ca2a26f 100644
--- a/src/openvpn/occ-inline.h
+++ b/src/openvpn/occ-inline.h
@@ -26,6 +26,8 @@
 
 #ifdef ENABLE_OCC
 
+#include "occ.h"
+
 /*
  * Inline functions
  */
@@ -42,8 +44,6 @@ occ_reset_op(void)
 static inline void
 check_send_occ_req(struct context *c)
 {
-    void check_send_occ_req_dowork(struct context *c);
-
     if (event_timeout_defined(&c->c2.occ_interval)
         && event_timeout_trigger(&c->c2.occ_interval,
                                  &c->c2.timeval,
@@ -59,8 +59,6 @@ check_send_occ_req(struct context *c)
 static inline void
 check_send_occ_load_test(struct context *c)
 {
-    void check_send_occ_load_test_dowork(struct context *c);
-
     if (event_timeout_defined(&c->c2.occ_mtu_load_test_interval)
         && event_timeout_trigger(&c->c2.occ_mtu_load_test_interval,
                                  &c->c2.timeval,
@@ -76,8 +74,6 @@ check_send_occ_load_test(struct context *c)
 static inline void
 check_send_occ_msg(struct context *c)
 {
-    void check_send_occ_msg_dowork(struct context *c);
-
     if (c->c2.occ_op >= 0)
     {
         if (!TO_LINK_DEF(c))
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index 12d7bc57..29de99c2 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -90,5 +90,11 @@ is_occ_msg(const struct buffer *buf)
 
 void process_received_occ_msg(struct context *c);
 
+void check_send_occ_req_dowork(struct context *c);
+
+void check_send_occ_load_test_dowork(struct context *c);
+
+void check_send_occ_msg_dowork(struct context *c);
+
 #endif /* ifdef ENABLE_OCC */
 #endif /* ifndef OCC_H */
diff --git a/src/openvpn/pf-inline.h b/src/openvpn/pf-inline.h
index ac19ac4c..0db7b262 100644
--- a/src/openvpn/pf-inline.h
+++ b/src/openvpn/pf-inline.h
@@ -24,6 +24,8 @@
 #if defined(ENABLE_PF) && !defined(PF_INLINE_H)
 #define PF_INLINE_H
 
+#include "pf.h"
+
 /*
  * Inline functions
  */
@@ -33,8 +35,6 @@
 static inline bool
 pf_c2c_test(const struct context *src, const struct context *dest, const char *prefix)
 {
-    bool pf_cn_test(struct pf_set *pfs, const struct tls_multi *tm, const int type, const char *prefix);
-
     return (!src->c2.pf.enabled  || pf_cn_test(src->c2.pf.pfs,  dest->c2.tls_multi, PCT_DEST, prefix))
            && (!dest->c2.pf.enabled || pf_cn_test(dest->c2.pf.pfs, src->c2.tls_multi,  PCT_SRC,  prefix));
 }
@@ -42,8 +42,6 @@ pf_c2c_test(const struct context *src, const struct context *dest, const char *p
 static inline bool
 pf_addr_test(const struct context *src, const struct mroute_addr *dest, const char *prefix)
 {
-    bool pf_addr_test_dowork(const struct context *src, const struct mroute_addr *dest, const char *prefix);
-
     if (src->c2.pf.enabled)
     {
         return pf_addr_test_dowork(src, dest, prefix);
diff --git a/src/openvpn/pf.h b/src/openvpn/pf.h
index 414c85b8..f6a3b61e 100644
--- a/src/openvpn/pf.h
+++ b/src/openvpn/pf.h
@@ -101,4 +101,10 @@ void pf_context_print(const struct pf_context *pfc, const char *prefix, const in
 
 #endif
 
+bool pf_cn_test(struct pf_set *pfs, const struct tls_multi *tm, const int type,
+                const char *prefix);
+
+bool pf_addr_test_dowork(const struct context *src,
+                         const struct mroute_addr *dest, const char *prefix);
+
 #endif /* if defined(ENABLE_PF) && !defined(OPENVPN_PF_H) */
diff --git a/src/openvpn/ping-inline.h b/src/openvpn/ping-inline.h
index 0642b851..9d590dc4 100644
--- a/src/openvpn/ping-inline.h
+++ b/src/openvpn/ping-inline.h
@@ -24,6 +24,8 @@
 #ifndef PING_INLINE_H
 #define PING_INLINE_H
 
+#include "ping.h"
+
 /*
  * Should we exit or restart due to ping (or other authenticated packet)
  * not received in n seconds?
@@ -31,8 +33,6 @@
 static inline void
 check_ping_restart(struct context *c)
 {
-    void check_ping_restart_dowork(struct context *c);
-
     if (c->options.ping_rec_timeout
         && event_timeout_trigger(&c->c2.ping_rec_interval,
                                  &c->c2.timeval,
@@ -50,8 +50,6 @@ check_ping_restart(struct context *c)
 static inline void
 check_ping_send(struct context *c)
 {
-    void check_ping_send_dowork(struct context *c);
-
     if (c->options.ping_send_timeout
         && event_timeout_trigger(&c->c2.ping_send_interval,
                                  &c->c2.timeval,
diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
index 5bd5c089..66c3a54f 100644
--- a/src/openvpn/ping.h
+++ b/src/openvpn/ping.h
@@ -43,4 +43,8 @@ is_ping_msg(const struct buffer *buf)
     return buf_string_match(buf, ping_string, PING_STRING_SIZE);
 }
 
+void check_ping_restart_dowork(struct context *c);
+
+void check_ping_send_dowork(struct context *c);
+
 #endif
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 818b6285..67549cda 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -216,4 +216,6 @@ plugin_call(const struct plugin_list *pl,
                            );
 }
 
+void plugin_abort(void);
+
 #endif /* OPENVPN_PLUGIN_H */
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 81e9e9ae..13b94606 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -1021,11 +1021,11 @@ void stream_buf_close(struct stream_buf *sb);
 
 bool stream_buf_added(struct stream_buf *sb, int length_added);
 
+bool stream_buf_read_setup_dowork(struct link_socket *sock);
+
 static inline bool
 stream_buf_read_setup(struct link_socket *sock)
 {
-    bool stream_buf_read_setup_dowork(struct link_socket *sock);
-
     if (link_socket_connection_oriented(sock))
     {
         return stream_buf_read_setup_dowork(sock);
@@ -1130,16 +1130,17 @@ link_socket_write_win32(struct link_socket *sock,
 
 #else  /* ifdef _WIN32 */
 
+size_t link_socket_write_udp_posix_sendmsg(struct link_socket *sock,
+                                           struct buffer *buf,
+                                           struct link_socket_actual *to);
+
+
 static inline size_t
 link_socket_write_udp_posix(struct link_socket *sock,
                             struct buffer *buf,
                             struct link_socket_actual *to)
 {
 #if ENABLE_IP_PKTINFO
-    size_t link_socket_write_udp_posix_sendmsg(struct link_socket *sock,
-                                               struct buffer *buf,
-                                               struct link_socket_actual *to);
-
     if (proto_is_udp(sock->info.proto) && (sock->sockflags & SF_USE_IP_PKTINFO)
         && addr_defined_ipi(to))
     {
-- 
2.14.0


