From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 24 Mar 2023 14:18:18 +0200
Message-Id: <20230324121818.2358-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Don't overwrite socket flags when using DCO
 on Windows
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Socket flags can be pushed, in which case they overwrite
existing value. We use socket flags to distingust between
DCO handle and socket on Windows. If server pushes --socket-flags,
we treat DCO handle as socket and everything explodes.

Fix by making link_socket_update_flags() update flags
(like name suggests) instead of overwriting them. Also
do not set TCP_NODELAY on DCO handle on Windows because
it doesn't make sense.

Change-Id: Ia34d73ca49041cb0ce22b84751cdbff57de96048
Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/socket.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 216f2ad7..ab8cc754 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -957,7 +957,8 @@ socket_set_mark(socket_descriptor_t sd, int mark)
 static bool
 socket_set_flags(socket_descriptor_t sd, unsigned int sockflags)
 {
-    if (sockflags & SF_TCP_NODELAY)
+    /* SF_TCP_NODELAY doesn't make sense for dco-win */
+    if ((sockflags & SF_TCP_NODELAY) && (!(sockflags & SF_DCO_WIN)))
     {
         return socket_set_tcp_nodelay(sd, 1);
     }
@@ -972,7 +973,8 @@ link_socket_update_flags(struct link_socket *ls, unsigned int sockflags)
 {
     if (ls && socket_defined(ls->sd))
     {
-        return socket_set_flags(ls->sd, ls->sockflags = sockflags);
+        ls->sockflags |= sockflags;
+        return socket_set_flags(ls->sd, ls->sockflags);
     }
     else
     {
-- 
2.38.1.windows.1


