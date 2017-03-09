From: Steffan Karger <steffan.karger@...1435...>
Date: Thu, 9 Mar 2017 11:47:35 +0100
Message-ID: <1489056455-6004-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix types in WIN32 socket_listen_accept()
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

SOCKET_UNDEFINED is of type socket_descriptor_t (or SOCKET, in MS types),
so new_sd should be too.  Also, the return value of this function is
always stored in a socket_descriptor_t variable, so it should return that
type (which makes sense now, because it returns new_sd) instead of an int.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 6aa2e6d..672634a 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1146,7 +1146,7 @@ tcp_connection_established(const struct link_socket_actual *act)
     gc_free(&gc);
 }
 
-static int
+static socket_descriptor_t
 socket_listen_accept(socket_descriptor_t sd,
                      struct link_socket_actual *act,
                      const char *remote_dynamic,
@@ -1158,7 +1158,7 @@ socket_listen_accept(socket_descriptor_t sd,
     struct gc_arena gc = gc_new();
     /* struct openvpn_sockaddr *remote = &act->dest; */
     struct openvpn_sockaddr remote_verify = act->dest;
-    int new_sd = SOCKET_UNDEFINED;
+    socket_descriptor_t new_sd = SOCKET_UNDEFINED;
 
     CLEAR(*act);
     socket_do_listen(sd, local, do_listen, true);
-- 
2.7.4


