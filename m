From: selva.nair@...277...
Date: Wed,  2 Jun 2021 15:47:39 -0400
Message-Id: <20210602194739.29488-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Apply the connect-retry backoff to only one
 side of a connection
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

From: Selva Nair <selva.nair@...277...>

p2p connections with both ends backing off seldom succeed
as their connection attempt durations becomes increasingly
unlikely to overlap when the retry wait time is long.

Avoid this by applying the backoff logic only on TCP clients
or the tls_client side for UDP.

Regression warning: shared secret setups are left out of the
backoff logic.

Trac #1010

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 49c74292..2889f355 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2423,8 +2423,9 @@ socket_restart_pause(struct context *c)
         sec = 10;
     }
 
-    /* Slow down reconnection after 5 retries per remote -- for tcp only in client mode */
-    if (c->options.ce.proto != PROTO_TCP_SERVER)
+    /* Slow down reconnection after 5 retries per remote -- for TCP client or UDP tls-client only */
+    if (c->options.ce.proto == PROTO_TCP_CLIENT
+        || (c->options.ce.proto == PROTO_UDP && c->options.tls_client))
     {
         backoff = (c->options.unsuccessful_attempts / c->options.connection_list->len) - 4;
         if (backoff > 0)
-- 
2.20.1


