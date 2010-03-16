From: David Sommerseth <openvpn.list@...1114...>
Date: Tue, 16 Mar 2010 23:11:56 +0100
Message-Id: <1268777516-3666-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] Debian patch: Sets FD_CLOEXEC in socket
	initialization BEFORE running up-script
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
Cc: David Sommerseth <dazo@...384...>

From: Alberto Gonzalez Iniesta <agi@...64...>

This patch sets FD_CLOEXEC in socket initialization BEFORE
running the 'up script' to avoid passing fds to the scripts, which broke
things like quagga.

<http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=367716>

Signed-off-by: David Sommerseth <dazo@...384...>
---
 socket.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/socket.c b/socket.c
index 62bf881..50a72b9 100644
--- a/socket.c
+++ b/socket.c
@@ -1293,6 +1293,10 @@ link_socket_init_phase1 (struct link_socket *sock,
       resolve_bind_local (sock);
       resolve_remote (sock, 1, NULL, NULL);
     }
+
+  /* set socket file descriptor to not pass across execs, so that
+     scripts don't have access to it */
+  set_cloexec (sock->sd);
 }
 
 /* finalize socket initialization */
@@ -1501,10 +1505,6 @@ link_socket_init_phase2 (struct link_socket *sock,
   /* set socket to non-blocking mode */
   set_nonblock (sock->sd);
 
-  /* set socket file descriptor to not pass across execs, so that
-     scripts don't have access to it */
-  set_cloexec (sock->sd);
-
 #ifdef ENABLE_SOCKS
   if (socket_defined (sock->ctrl_sd))
     set_cloexec (sock->ctrl_sd);
-- 
1.6.6.1


