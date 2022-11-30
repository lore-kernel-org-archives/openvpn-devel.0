From: Arne Schwabe <arne@...1227...>
Date: Wed, 30 Nov 2022 17:57:12 +0100
Message-Id: <20221130165712.159683-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Signal USR1 when connection initialising
 fails
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

When we fail initialisation the connection (e.g. P2P cipher NCP), we have
a non-working connection. Even though previous version would then stay in
this state, it does not really make sense to be in this state until the
keepalive timeout expires and triggers a USR1 anyway.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 37340aef5..1b418b1bc 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -344,7 +344,10 @@ check_connection_established(struct context *c)
         }
         else
         {
-            do_up(c, false, 0);
+            if (!do_up(c, false, 0))
+            {
+                register_signal(c, SIGUSR1, "connection initialisation failed");
+            }
         }
 
         event_timeout_clear(&c->c2.wait_for_connect);
-- 
2.37.1 (Apple Git-137.1)


