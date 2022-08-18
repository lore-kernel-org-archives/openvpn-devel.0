From: Antonio Quartulli <a@...2181...>
Date: Thu, 18 Aug 2022 02:13:58 +0200
Message-Id: <20220818001358.175361-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] close_tun: print interface type
 consistently in message
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
Cc: Antonio Quartulli <a@...2181...>

When closing the tunnel interface we know if we were using DCO or not.
for this reason we can customize the closing message and make it
consistent with the opening one.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/init.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e8335c53..92c4cab9 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1921,7 +1921,15 @@ do_open_tun(struct context *c)
 static void
 do_close_tun_simple(struct context *c)
 {
-    msg(D_CLOSE, "Closing TUN/TAP interface");
+    if (dco_enabled(&c->options))
+    {
+        msg(D_CLOSE, "Closing DCO interface");
+    }
+    else
+    {
+        msg(D_CLOSE, "Closing TUN/TAP interface");
+    }
+
     if (c->c1.tuntap)
     {
         close_tun(c->c1.tuntap, &c->net_ctx);
-- 
2.30.2


