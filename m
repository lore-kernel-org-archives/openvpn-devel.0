From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 17 Jul 2012 18:19:53 +0200
Message-ID: <1342541993-32462-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCHv2 1/2] make non-blocking connect work on
	Windows
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

Instead of EINPROGRESS WinSock2 returns WSAEWOULDBLOCK if a non-blocking
connect(2) cannot be completed immediately.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/socket.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 54ebce7..02e2768 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1165,7 +1165,13 @@ openvpn_connect (socket_descriptor_t sd,
   status = connect (sd, &remote->addr.sa, af_addr_size(remote->addr.sa.sa_family));
   if (status)
     status = openvpn_errno_socket ();
-  if (status == EINPROGRESS)
+  if (
+#ifdef WIN32
+    status == WSAEWOULDBLOCK
+#else
+    status == EINPROGRESS
+#endif
+  )
     {
       while (true)
 	{
-- 
1.7.9


