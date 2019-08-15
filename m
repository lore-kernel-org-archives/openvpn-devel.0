From: Gert Doering <gert@...1296...>
Date: Thu, 15 Aug 2019 17:53:19 +0200
Message-Id: <20190815155319.28249-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Increase listen() backlog queue to 32
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

For reasons historically unknown, OpenVPN sets the listen() backlog
queue to "1", which signals the kernel "while there is one TCP connect
waiting for OpenVPN to handle it, refuse all others" - which, on
restarting a busy TCP server, will create connection issues.

The exact "best" value of the backlog queue is subject of discussion,
but for a server that is not extremely busy with many connections
coming in in parallel, there is no real difference between "10" or "500",
as long as it's "more than 1".

Found and debugged by "mjo" in Trac.

Trac: #1208

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/socket.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index c472cf1b..983ed38a 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1175,7 +1175,7 @@ socket_do_listen(socket_descriptor_t sd,
         ASSERT(local);
         msg(M_INFO, "Listening for incoming TCP connection on %s",
             print_sockaddr(local->ai_addr, &gc));
-        if (listen(sd, 1))
+        if (listen(sd, 32))
         {
             msg(M_ERR, "TCP: listen() failed");
         }
-- 
2.21.0


