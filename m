From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Aug 2020 16:36:55 +0200
Message-Id: <20200810143707.5834-6-arne@...1227...>
In-Reply-To: <20200810143707.5834-1-arne@...1227...>
References: <20200810143707.5834-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 05/17] Remove buf argument from
 link_socket_set_outgoing_addr
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

This was only used in a check that is better suited in the calling
functions. This also removes passing the buf argument to
link_socket_connection_initiated that also does not use that
parameter at all.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c |  4 ++--
 src/openvpn/socket.c  |  3 +--
 src/openvpn/socket.h  | 35 +++++++++++++++--------------------
 src/openvpn/ssl.c     |  2 +-
 4 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 79c07e46..8a0d63f7 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1177,9 +1177,9 @@ process_incoming_link_part2(struct context *c, struct link_socket_info *lsi, con
          *
          * Also, update the persisted version of our packet-id.
          */
-        if (!TLS_MODE(c))
+        if (!TLS_MODE(c) && c->c2.buf.len > 0)
         {
-            link_socket_set_outgoing_addr(&c->c2.buf, lsi, &c->c2.from, NULL, c->c2.es);
+            link_socket_set_outgoing_addr(lsi, &c->c2.from, NULL, c->c2.es);
         }
 
         /* reset packet received timer */
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 61463bcd..c486327b 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2450,8 +2450,7 @@ ipchange_fmt(const bool include_cmd, struct argv *argv, const struct link_socket
 }
 
 void
-link_socket_connection_initiated(const struct buffer *buf,
-                                 struct link_socket_info *info,
+link_socket_connection_initiated(struct link_socket_info *info,
                                  const struct link_socket_actual *act,
                                  const char *common_name,
                                  struct env_set *es)
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 8db9e8ba..7aeae527 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -435,8 +435,7 @@ in_addr_t link_socket_current_remote(const struct link_socket_info *info);
 const struct in6_addr *link_socket_current_remote_ipv6
     (const struct link_socket_info *info);
 
-void link_socket_connection_initiated(const struct buffer *buf,
-                                      struct link_socket_info *info,
+void link_socket_connection_initiated(struct link_socket_info *info,
                                       const struct link_socket_actual *addr,
                                       const char *common_name,
                                       struct env_set *es);
@@ -984,29 +983,25 @@ link_socket_get_outgoing_addr(struct buffer *buf,
 }
 
 static inline void
-link_socket_set_outgoing_addr(const struct buffer *buf,
-                              struct link_socket_info *info,
+link_socket_set_outgoing_addr(struct link_socket_info *info,
                               const struct link_socket_actual *act,
                               const char *common_name,
                               struct env_set *es)
 {
-    if (!buf || buf->len > 0)
+    struct link_socket_addr *lsa = info->lsa;
+    if (
+        /* new or changed address? */
+        (!info->connection_established
+         || !addr_match_proto(&act->dest, &lsa->actual.dest, info->proto)
+        )
+        &&
+        /* address undef or address == remote or --float */
+        (info->remote_float
+         || (!lsa->remote_list || addrlist_match_proto(&act->dest, lsa->remote_list, info->proto))
+        )
+        )
     {
-        struct link_socket_addr *lsa = info->lsa;
-        if (
-            /* new or changed address? */
-            (!info->connection_established
-             || !addr_match_proto(&act->dest, &lsa->actual.dest, info->proto)
-            )
-            &&
-            /* address undef or address == remote or --float */
-            (info->remote_float
-             || (!lsa->remote_list || addrlist_match_proto(&act->dest, lsa->remote_list, info->proto))
-            )
-            )
-        {
-            link_socket_connection_initiated(buf, info, act, common_name, es);
-        }
+        link_socket_connection_initiated(info, act, common_name, es);
     }
 }
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3bf0dcf8..a43ee985 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2762,7 +2762,7 @@ tls_process(struct tls_multi *multi,
                 INCR_SUCCESS;
 
                 /* Set outgoing address for data channel packets */
-                link_socket_set_outgoing_addr(NULL, to_link_socket_info, &ks->remote_addr, session->common_name, session->opt->es);
+                link_socket_set_outgoing_addr(to_link_socket_info, &ks->remote_addr, session->common_name, session->opt->es);
 
                 /* Flush any payload packets that were buffered before our state transitioned to S_ACTIVE */
                 flush_payload_buffer(ks);
-- 
2.26.2


