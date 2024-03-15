From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 15 Mar 2024 17:20:11 +0100
Message-Id: <20240315162011.1661139-1-frank@...2641...>
In-Reply-To: <20230830130502.1029-1-sandro.trianni@...277...>
References: <20230830130502.1029-1-sandro.trianni@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Implement server_poll_timeout for socks
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

From: 5andr0 <sandro.trianni@...277...>

So far --server-poll-timeout was only applied
for HTTP proxies, apply it also to SOCKS proxies.

This removes the default 5 second socks connect timeout
which can be too small depending on network setup and
replaces it with the configurable overall connect timeout
(default 120 seconds).

Trac: #328
Change-Id: I2b109f8c551c23045a1be355778b08f0fd4d309f
Signed-off-by: 5andr0 <sandro.trianni@...277...>
---
 src/openvpn/socket.c |  2 ++
 src/openvpn/socks.c  | 25 ++++++++++++++-----------
 src/openvpn/socks.h  |  2 ++
 3 files changed, 18 insertions(+), 11 deletions(-)

Trying to move this forward by adding a commit message.

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 480f4e51..ecb408a3 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2075,6 +2075,7 @@ phase2_tcp_client(struct link_socket *sock, struct signal_info *sig_info)
                                            sock->sd,
                                            sock->proxy_dest_host,
                                            sock->proxy_dest_port,
+                                           sock->server_poll_timeout,
                                            sig_info);
         }
         if (proxy_retry)
@@ -2104,6 +2105,7 @@ phase2_socks_client(struct link_socket *sock, struct signal_info *sig_info)
                                    sock->ctrl_sd,
                                    sock->sd,
                                    &sock->socks_relay.dest,
+                                   sock->server_poll_timeout,
                                    sig_info);
 
     if (sig_info->signal_received)
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index a29eb83a..2cb83a66 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -42,6 +42,7 @@
 #include "fdmisc.h"
 #include "misc.h"
 #include "proxy.h"
+#include "forward.h"
 
 #include "memdbg.h"
 
@@ -85,12 +86,12 @@ socks_proxy_close(struct socks_proxy_info *sp)
 static bool
 socks_username_password_auth(struct socks_proxy_info *p,
                              socket_descriptor_t sd,
+                             struct event_timeout *server_poll_timeout,
                              volatile int *signal_received)
 {
     char to_send[516];
     char buf[2];
     int len = 0;
-    const int timeout_sec = 5;
     struct user_pass creds;
     ssize_t size;
     bool ret = false;
@@ -129,7 +130,7 @@ socks_username_password_auth(struct socks_proxy_info *p,
 
         FD_ZERO(&reads);
         openvpn_fd_set(sd, &reads);
-        tv.tv_sec = timeout_sec;
+        tv.tv_sec = get_server_poll_remaining_time(server_poll_timeout);
         tv.tv_usec = 0;
 
         status = select(sd + 1, &reads, NULL, NULL, &tv);
@@ -185,11 +186,11 @@ cleanup:
 static bool
 socks_handshake(struct socks_proxy_info *p,
                 socket_descriptor_t sd,
+                struct event_timeout *server_poll_timeout,
                 volatile int *signal_received)
 {
     char buf[2];
     int len = 0;
-    const int timeout_sec = 5;
     ssize_t size;
 
     /* VER = 5, NMETHODS = 1, METHODS = [0 (no auth)] */
@@ -216,7 +217,7 @@ socks_handshake(struct socks_proxy_info *p,
 
         FD_ZERO(&reads);
         openvpn_fd_set(sd, &reads);
-        tv.tv_sec = timeout_sec;
+        tv.tv_sec = get_server_poll_remaining_time(server_poll_timeout);
         tv.tv_usec = 0;
 
         status = select(sd + 1, &reads, NULL, NULL, &tv);
@@ -283,7 +284,7 @@ socks_handshake(struct socks_proxy_info *p,
                 return false;
             }
 
-            if (!socks_username_password_auth(p, sd, signal_received))
+            if (!socks_username_password_auth(p, sd, server_poll_timeout, signal_received))
             {
                 return false;
             }
@@ -301,13 +302,13 @@ socks_handshake(struct socks_proxy_info *p,
 static bool
 recv_socks_reply(socket_descriptor_t sd,
                  struct openvpn_sockaddr *addr,
+                 struct event_timeout *server_poll_timeout,
                  volatile int *signal_received)
 {
     char atyp = '\0';
     int alen = 0;
     int len = 0;
     char buf[270];              /* 4 + alen(max 256) + 2 */
-    const int timeout_sec = 5;
 
     if (addr != NULL)
     {
@@ -326,7 +327,7 @@ recv_socks_reply(socket_descriptor_t sd,
 
         FD_ZERO(&reads);
         openvpn_fd_set(sd, &reads);
-        tv.tv_sec = timeout_sec;
+        tv.tv_sec = get_server_poll_remaining_time(server_poll_timeout);
         tv.tv_usec = 0;
 
         status = select(sd + 1, &reads, NULL, NULL, &tv);
@@ -451,12 +452,13 @@ establish_socks_proxy_passthru(struct socks_proxy_info *p,
                                socket_descriptor_t sd,  /* already open to proxy */
                                const char *host,        /* openvpn server remote */
                                const char *servname,    /* openvpn server port */
+                               struct event_timeout *server_poll_timeout,
                                struct signal_info *sig_info)
 {
     char buf[270];
     size_t len;
 
-    if (!socks_handshake(p, sd, &sig_info->signal_received))
+    if (!socks_handshake(p, sd, server_poll_timeout, &sig_info->signal_received))
     {
         goto error;
     }
@@ -494,7 +496,7 @@ establish_socks_proxy_passthru(struct socks_proxy_info *p,
 
 
     /* receive reply from Socks proxy and discard */
-    if (!recv_socks_reply(sd, NULL, &sig_info->signal_received))
+    if (!recv_socks_reply(sd, NULL, server_poll_timeout, &sig_info->signal_received))
     {
         goto error;
     }
@@ -512,9 +514,10 @@ establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
                                socket_descriptor_t ctrl_sd,  /* already open to proxy */
                                socket_descriptor_t udp_sd,
                                struct openvpn_sockaddr *relay_addr,
+                               struct event_timeout *server_poll_timeout,
                                struct signal_info *sig_info)
 {
-    if (!socks_handshake(p, ctrl_sd, &sig_info->signal_received))
+    if (!socks_handshake(p, ctrl_sd, server_poll_timeout, &sig_info->signal_received))
     {
         goto error;
     }
@@ -535,7 +538,7 @@ establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
 
     /* receive reply from Socks proxy */
     CLEAR(*relay_addr);
-    if (!recv_socks_reply(ctrl_sd, relay_addr, &sig_info->signal_received))
+    if (!recv_socks_reply(ctrl_sd, relay_addr, server_poll_timeout, &sig_info->signal_received))
     {
         goto error;
     }
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index 3a89245b..a7094f06 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -52,12 +52,14 @@ void establish_socks_proxy_passthru(struct socks_proxy_info *p,
                                     socket_descriptor_t sd,  /* already open to proxy */
                                     const char *host,        /* openvpn server remote */
                                     const char *servname,          /* openvpn server port */
+                                    struct event_timeout *server_poll_timeout,
                                     struct signal_info *sig_info);
 
 void establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
                                     socket_descriptor_t ctrl_sd,  /* already open to proxy */
                                     socket_descriptor_t udp_sd,
                                     struct openvpn_sockaddr *relay_addr,
+                                    struct event_timeout *server_poll_timeout,
                                     struct signal_info *sig_info);
 
 void socks_process_incoming_udp(struct buffer *buf,
-- 
2.34.1


