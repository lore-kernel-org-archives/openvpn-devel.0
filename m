From: Gert Doering <gert@...1296...>
Date: Wed, 18 Sep 2024 22:48:44 +0200
Message-ID: <20240918204844.2820-1-gert@...1296...>
In-Reply-To: <gerrit.1725970450000.I7852c06d331326c1dbab7b642254c0c00d4cebb8@...2715...>
References: <gerrit.1725970450000.I7852c06d331326c1dbab7b642254c0c00d4cebb8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] socket: Change return types of
 link_socket_write* to ssize_t
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

From: Frank Lichtenheld <frank@...2641...>

This is the actual return value of send/sendto/sendmsg.
We will leave it to the single caller of link_socket_write()
to decide how to map that to the int buffer world. For now
just cast it explicitly.

Change-Id: I7852c06d331326c1dbab7b642254c0c00d4cebb8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/740
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 40b7cc4..84c23b3 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1790,7 +1790,7 @@
                 socks_preprocess_outgoing_link(c, &to_addr, &size_delta);
 
                 /* Send packet */
-                size = link_socket_write(c->c2.link_socket, &c->c2.to_link, to_addr);
+                size = (int)link_socket_write(c->c2.link_socket, &c->c2.to_link, to_addr);
 
                 /* Undo effect of prepend */
                 link_socket_write_post_size_adjust(&size, size_delta, &c->c2.to_link);
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 17c5e76..6c790a0 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3399,7 +3399,7 @@
  * Socket Write Routines
  */
 
-int
+ssize_t
 link_socket_write_tcp(struct link_socket *sock,
                       struct buffer *buf,
                       struct link_socket_actual *to)
@@ -3418,7 +3418,7 @@
 
 #if ENABLE_IP_PKTINFO
 
-size_t
+ssize_t
 link_socket_write_udp_posix_sendmsg(struct link_socket *sock,
                                     struct buffer *buf,
                                     struct link_socket_actual *to)
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 47083ad..bbdabfb 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -1099,9 +1099,9 @@
  * Socket Write routines
  */
 
-int link_socket_write_tcp(struct link_socket *sock,
-                          struct buffer *buf,
-                          struct link_socket_actual *to);
+ssize_t link_socket_write_tcp(struct link_socket *sock,
+                              struct buffer *buf,
+                              struct link_socket_actual *to);
 
 #ifdef _WIN32
 
@@ -1135,12 +1135,12 @@
 
 #else  /* ifdef _WIN32 */
 
-size_t link_socket_write_udp_posix_sendmsg(struct link_socket *sock,
-                                           struct buffer *buf,
-                                           struct link_socket_actual *to);
+ssize_t link_socket_write_udp_posix_sendmsg(struct link_socket *sock,
+                                            struct buffer *buf,
+                                            struct link_socket_actual *to);
 
 
-static inline size_t
+static inline ssize_t
 link_socket_write_udp_posix(struct link_socket *sock,
                             struct buffer *buf,
                             struct link_socket_actual *to)
@@ -1158,7 +1158,7 @@
                   (socklen_t) af_addr_size(to->dest.addr.sa.sa_family));
 }
 
-static inline size_t
+static inline ssize_t
 link_socket_write_tcp_posix(struct link_socket *sock,
                             struct buffer *buf,
                             struct link_socket_actual *to)
@@ -1168,7 +1168,7 @@
 
 #endif /* ifdef _WIN32 */
 
-static inline size_t
+static inline ssize_t
 link_socket_write_udp(struct link_socket *sock,
                       struct buffer *buf,
                       struct link_socket_actual *to)
@@ -1181,7 +1181,7 @@
 }
 
 /* write a TCP or UDP packet to link */
-static inline int
+static inline ssize_t
 link_socket_write(struct link_socket *sock,
                   struct buffer *buf,
                   struct link_socket_actual *to)

