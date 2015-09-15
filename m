From: Arne Schwabe <arne@...1227...>
Date: Tue, 15 Sep 2015 11:23:36 +0200
Message-Id: <1442309019-7586-6-git-send-email-arne@...1227...>
In-Reply-To: <1442309019-7586-1-git-send-email-arne@...1227...>
References: <1442309019-7586-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 5/8] Fix loglevel of protect socket message
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

---
 src/openvpn/socket.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 7f889b1..5248f44 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -898,11 +898,11 @@ static void protect_fd_nonlocal (int fd, const struct sockaddr* addr)
    * as "protected socket" (exempt from being routed into tunnel)
    */
   if (addr_local (addr)) {
-    msg(M_DEBUG, "Address is local, not protecting socket fd %d", fd);
+    msg(D_SOCKET_DEBUG, "Address is local, not protecting socket fd %d", fd);
     return;
   }
 
-  msg(M_DEBUG, "Protecting socket fd %d", fd);
+  msg(D_SOCKET_DEBUG, "Protecting socket fd %d", fd);
   management->connection.fdtosend = fd;
   management_android_control (management, "PROTECTFD", __func__);
 }
-- 
2.3.2 (Apple Git-55)


