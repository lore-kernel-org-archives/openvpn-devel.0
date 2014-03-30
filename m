Resent-Message-Id: <201403301211.s2UCBhT2025604@...1295...>
From: Gert Doering <gert@...1296...>
Date: Sun, 30 Mar 2014 14:09:36 +0200
Message-Id: <1396181376-32022-1-git-send-email-gert@...1296...>
Resent-To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] [PATCH] Fix crash when using --inetd.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Change "local" argument to socket_do_listen() to avoid calling
"local->ai_addr" in the caller for the "do_listen == FALSE" case,
in which case it could be NULL.

Also, ensure "ai" is always initialized in socket_listen_accept() for
the "!remote_dynamic" case - otherwise it will sometimes(!) crash in
addrlist_match() later on.

Get rid of spurious operator precedence warning concerning GETADDR_CACHE_MASK.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/socket.c | 11 ++++++-----
 src/openvpn/socket.h |  2 +-
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index b769171..7deef0a 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -917,15 +917,16 @@ static void protect_fd_nonlocal (int fd, const struct sockaddr* addr)
  */
 static void
 socket_do_listen (socket_descriptor_t sd,
-		  const struct sockaddr *local,
+		  const struct addrinfo *local,
 		  bool do_listen,
 		  bool do_set_nonblock)
 {
   struct gc_arena gc = gc_new ();
   if (do_listen)
     {
+      ASSERT(local);
       msg (M_INFO, "Listening for incoming TCP connection on %s", 
-	   print_sockaddr (local, &gc));
+	   print_sockaddr (local->ai_addr, &gc));
       if (listen (sd, 1))
 	msg (M_ERR, "TCP: listen() failed");
     }
@@ -1018,7 +1019,7 @@ socket_listen_accept (socket_descriptor_t sd,
   int new_sd = SOCKET_UNDEFINED;
 
   CLEAR (*act);
-  socket_do_listen (sd, local->ai_addr, do_listen, true);
+  socket_do_listen (sd, local, do_listen, true);
 
   while (true)
     {
@@ -1053,7 +1054,7 @@ socket_listen_accept (socket_descriptor_t sd,
 
       if (socket_defined (new_sd))
 	{
-          struct addrinfo* ai;
+          struct addrinfo* ai = NULL;
           if(remote_dynamic)
               openvpn_getaddrinfo(0, remote_dynamic, NULL, 1, NULL,
                                     remote_verify.addr.sa.sa_family, &ai);
@@ -1775,7 +1776,7 @@ phase2_tcp_server (struct link_socket *sock, const char *remote_dynamic,
       break;
     case LS_MODE_TCP_LISTEN:
       socket_do_listen (sock->sd,
-			sock->info.lsa->bind_local->ai_addr,
+			sock->info.lsa->bind_local,
 			true,
 			false);
       break;
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index f27e9a9..bffa039 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -524,7 +524,7 @@ bool unix_socket_get_peer_uid_gid (const socket_descriptor_t sd, int *uid, int *
 #define GETADDR_PASSIVE               (1<<10)
 #define GETADDR_DATAGRAM              (1<<11)
 
-#define GETADDR_CACHE_MASK		GETADDR_DATAGRAM|GETADDR_PASSIVE
+#define GETADDR_CACHE_MASK		(GETADDR_DATAGRAM|GETADDR_PASSIVE)
 
 in_addr_t getaddr (unsigned int flags,
 		   const char *hostname,
-- 
1.8.3.2



