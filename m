From: Antonio Quartulli <a@...2181...>
Date: Mon, 28 Aug 2017 16:56:20 +0800
Message-Id: <20170828085620.23186-2-a@...2181...>
In-Reply-To: <20170828085620.23186-1-a@...2181...>
References: <20170828085620.23186-1-a@...2181...>
Subject: [Openvpn-devel] [PATCHv3 2/2] ensure function declarations are
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

v2: rebased on top of latest master to avoid conflicts
v3: rebased on top of "merge *-inline.h files with their main header"

patch has been verified with travis-ci

 src/openvpn/crypto.h   |  8 ++++++++
 src/openvpn/error.c    |  3 +--
 src/openvpn/forward.h  | 35 +++++++++++++++++++++++++++++++++++
 src/openvpn/fragment.c |  1 +
 src/openvpn/gremlin.c  |  1 +
 src/openvpn/init.h     |  2 ++
 src/openvpn/lladdr.c   |  1 +
 src/openvpn/manage.h   | 10 +++++-----
 src/openvpn/mbuf.h     |  4 ++--
 src/openvpn/misc.h     |  8 --------
 src/openvpn/mroute.h   | 20 ++++++++++----------
 src/openvpn/multi.h    |  7 +++----
 src/openvpn/occ.h      | 19 +++++++++++++------
 src/openvpn/pf.h       | 15 +++++++++++++++
 src/openvpn/ping.h     |  4 ++++
 src/openvpn/plugin.h   |  2 ++
 src/openvpn/socket.h   | 13 +++++++------
 17 files changed, 110 insertions(+), 43 deletions(-)

diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 6d60ef8c..c489ef1e 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -459,6 +459,9 @@ void prng_bytes(uint8_t *output, int len);
 
 void prng_uninit(void);
 
+/* an analogue to the random() function, but use prng_bytes */
+long int get_random(void);
+
 void test_crypto(struct crypto_options *co, struct frame *f);
 
 
@@ -514,5 +517,10 @@ key_ctx_bi_defined(const struct key_ctx_bi *key)
 }
 
 
+#else
+
+/* use plain random is no crypto support is compiled */
+#define get_random random
+
 #endif /* ENABLE_CRYPTO */
 #endif /* CRYPTO_H */
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
 
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 0b7f1250..248c941e 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -63,6 +63,41 @@
 
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
 
diff --git a/src/openvpn/fragment.c b/src/openvpn/fragment.c
index 38de62f1..25ffc4cf 100644
--- a/src/openvpn/fragment.c
+++ b/src/openvpn/fragment.c
@@ -31,6 +31,7 @@
 
 #ifdef ENABLE_FRAGMENT
 
+#include "crypto.h"
 #include "misc.h"
 #include "fragment.h"
 #include "integer.h"
diff --git a/src/openvpn/gremlin.c b/src/openvpn/gremlin.c
index e85ce9cf..dca506a9 100644
--- a/src/openvpn/gremlin.c
+++ b/src/openvpn/gremlin.c
@@ -38,6 +38,7 @@
 
 #include "error.h"
 #include "common.h"
+#include "crypto.h"
 #include "misc.h"
 #include "otime.h"
 #include "gremlin.h"
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
index 676be640..23339ee7 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -583,17 +583,17 @@ management_bytes_in(struct management *man, const int size)
 
 #ifdef MANAGEMENT_DEF_AUTH
 
+void man_bytecount_output_server(struct management *man,
+                                 const counter_type *bytes_in_total,
+                                 const counter_type *bytes_out_total,
+                                 struct man_def_auth_context *mdac);
+
 static inline void
 management_bytes_server(struct management *man,
                         const counter_type *bytes_in_total,
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
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index eb39ce3f..6daf9515 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -142,14 +142,6 @@ const char **make_arg_array(const char *first, const char *parms, struct gc_aren
 
 const char **make_extended_arg_array(char **p, struct gc_arena *gc);
 
-/* an analogue to the random() function, but use OpenSSL functions if available */
-#ifdef ENABLE_CRYPTO
-long int get_random(void);
-
-#else
-#define get_random random
-#endif
-
 /* return true if filename can be opened for read */
 bool test_file(const char *filename);
 
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 35361fbd..fc37211c 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -169,6 +169,16 @@ void mroute_helper_add_iroute46(struct mroute_helper *mh, int netbits);
 
 void mroute_helper_del_iroute46(struct mroute_helper *mh, int netbits);
 
+unsigned int mroute_extract_addr_ip(struct mroute_addr *src,
+                                    struct mroute_addr *dest,
+                                    const struct buffer *buf);
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
@@ -181,16 +191,6 @@ mroute_extract_addr_from_packet(struct mroute_addr *src,
                                 const struct buffer *buf,
                                 int tunnel_type)
 {
-    unsigned int mroute_extract_addr_ip(struct mroute_addr *src,
-                                     struct mroute_addr *dest,
-                                     const struct buffer *buf);
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
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index 369ebac4..f81e68d7 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -90,6 +90,19 @@ is_occ_msg(const struct buffer *buf)
 
 void process_received_occ_msg(struct context *c);
 
+<<<<<<< HEAD
+=======
+void check_send_occ_req_dowork(struct context *c);
+
+void check_send_occ_load_test_dowork(struct context *c);
+
+void check_send_occ_msg_dowork(struct context *c);
+
+/*
+ * Inline functions
+ */
+
+>>>>>>> 5222207d... ensure function declarations are compiled with their definitions
 static inline int
 occ_reset_op(void)
 {
@@ -102,8 +115,6 @@ occ_reset_op(void)
 static inline void
 check_send_occ_req(struct context *c)
 {
-    void check_send_occ_req_dowork(struct context *c);
-
     if (event_timeout_defined(&c->c2.occ_interval)
         && event_timeout_trigger(&c->c2.occ_interval,
                                  &c->c2.timeval,
@@ -119,8 +130,6 @@ check_send_occ_req(struct context *c)
 static inline void
 check_send_occ_load_test(struct context *c)
 {
-    void check_send_occ_load_test_dowork(struct context *c);
-
     if (event_timeout_defined(&c->c2.occ_mtu_load_test_interval)
         && event_timeout_trigger(&c->c2.occ_mtu_load_test_interval,
                                  &c->c2.timeval,
@@ -136,8 +145,6 @@ check_send_occ_load_test(struct context *c)
 static inline void
 check_send_occ_msg(struct context *c)
 {
-    void check_send_occ_msg_dowork(struct context *c);
-
     if (c->c2.occ_op >= 0)
     {
         if (!TO_LINK_DEF(c))
diff --git a/src/openvpn/pf.h b/src/openvpn/pf.h
index 480d5b7b..e588f0e0 100644
--- a/src/openvpn/pf.h
+++ b/src/openvpn/pf.h
@@ -104,6 +104,21 @@ void pf_context_print(const struct pf_context *pfc, const char *prefix, const in
 
 #endif
 
+<<<<<<< HEAD
+=======
+bool pf_cn_test(struct pf_set *pfs, const struct tls_multi *tm, const int type,
+                const char *prefix);
+
+bool pf_addr_test_dowork(const struct context *src,
+                         const struct mroute_addr *dest, const char *prefix);
+
+/*
+ * Inline functions
+ */
+
+#define PCT_SRC  1
+#define PCT_DEST 2
+>>>>>>> 5222207d... ensure function declarations are compiled with their definitions
 bool pf_c2c_test(const struct context *src, const struct context *dest,
                  const char *prefix);
 
diff --git a/src/openvpn/ping.h b/src/openvpn/ping.h
index 9c5ef8e1..ff2eb939 100644
--- a/src/openvpn/ping.h
+++ b/src/openvpn/ping.h
@@ -43,6 +43,10 @@ is_ping_msg(const struct buffer *buf)
     return buf_string_match(buf, ping_string, PING_STRING_SIZE);
 }
 
+void check_ping_restart_dowork(struct context *c);
+
+void check_ping_send_dowork(struct context *c);
+
 /*
  * Should we exit or restart due to ping (or other authenticated packet)
  * not received in n seconds?
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 0cffee0f..1c98857f 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -215,4 +215,6 @@ plugin_call(const struct plugin_list *pl,
                            );
 }
 
+void plugin_abort(void);
+
 #endif /* OPENVPN_PLUGIN_H */
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 2d7f2187..b0fb55e1 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -1009,11 +1009,11 @@ void stream_buf_close(struct stream_buf *sb);
 
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
@@ -1118,16 +1118,17 @@ link_socket_write_win32(struct link_socket *sock,
 
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
2.14.1


