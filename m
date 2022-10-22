From: Antonio Quartulli <a@...2181...>
Date: Sat, 22 Oct 2022 22:55:21 +0200
Message-Id: <20221022205521.29406-1-a@...2181...>
In-Reply-To: 20220818001358.175361-1-a@...2181...
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] close_tun: print interface type
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
Changes from v1:
* use termary if instead of full blown if block
---
 src/openvpn/init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c48048a1..01d6dab5 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1946,7 +1946,9 @@ do_open_tun(struct context *c)
 static void
 do_close_tun_simple(struct context *c)
 {
-    msg(D_CLOSE, "Closing TUN/TAP interface");
+    msg(D_CLOSE, "Closing %s interface",
+        dco_enabled(&c->options) ? "DCO": "TUN/TAP");
+
     if (c->c1.tuntap)
     {
         if (!c->options.ifconfig_noexec)
-- 
2.37.4


