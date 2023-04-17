From: Arne Schwabe <arne@...1227...>
Date: Mon, 17 Apr 2023 15:40:46 +0200
Message-Id: <20230417134046.81761-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix compile error on TARGET_ANDROID
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

Commit 3132bead49 accidentially was submitted with a missing semicolon
at the end of the line. Whoops.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index ab8cc754..fc643c1c 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1165,7 +1165,7 @@ protect_fd_nonlocal(int fd, const struct sockaddr *addr)
 {
     if (!management)
     {
-        msg(M_FATAL, "Required management interface not available.")
+        msg(M_FATAL, "Required management interface not available.");
     }
 
     /* pass socket FD to management interface to pass on to VPNService API
-- 
2.39.2 (Apple Git-143)


