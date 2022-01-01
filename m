From: Arne Schwabe <arne@...1227...>
Date: Sat,  1 Jan 2022 17:25:24 +0100
Message-Id: <20220101162532.2251835-7-arne@...1227...>
In-Reply-To: <20220101162532.2251835-1-arne@...1227...>
References: <20220101162532.2251835-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 06/14] Update fragment and mssfix related
 warnings
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

The warning that fragment/mssfix needs also tun-mtu set to 1500 makes
little sense. Remove it completely. Instead warn if there are incosistencies
between --fragment and mssfix.

Patch v2: clarify the mssfix and fragment mtu warning message

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 642460c1..f3b0776c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3255,12 +3255,17 @@ do_init_frame(struct context *c)
 #endif
 
 #ifdef ENABLE_FRAGMENT
-    if ((c->options.ce.mssfix || c->options.ce.fragment)
-        && TUN_MTU_SIZE(&c->c2.frame_fragment) != ETHERNET_MTU)
+    if (c->options.ce.fragment > 0 && c->options.ce.mssfix > c->options.ce.fragment)
     {
-        msg(M_WARN,
-            "WARNING: normally if you use --mssfix and/or --fragment, you should also set --tun-mtu %d (currently it is %d)",
-            ETHERNET_MTU, TUN_MTU_SIZE(&c->c2.frame_fragment));
+        msg(M_WARN, "WARNING: if you use --mssfix and --fragment, you should "
+                    "set --fragment (%d) larger or equal than --mssfix (%d)",
+                    c->options.ce.fragment, c->options.ce.mssfix);
+    }
+    if (c->options.ce.fragment > 0 && c->options.ce.mssfix > 0
+        && c->options.ce.fragment_encap != c->options.ce.mssfix_encap)
+    {
+        msg(M_WARN, "WARNING: if you use --mssfix and --fragment, you should "
+                    "use the \"mtu\" flag for both or none of of them.");
     }
 #endif
 }
-- 
2.33.0


