From: Arne Schwabe <arne@...1227...>
Date: Tue,  7 Dec 2021 18:02:05 +0100
Message-Id: <20211207170211.3275837-16-arne@...1227...>
In-Reply-To: <20211207170211.3275837-1-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 15/21] Update fragment and mssfix related
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 31ae250bc..4f08e560a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3183,12 +3183,17 @@ do_init_frame(struct context *c)
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
+                    "set --fragment (%d) larger than --mssfix (%d)",
+                    c->options.ce.fragment, c->options.ce.mssfix);
+    }
+    if (c->options.ce.fragment > 0 && c->options.ce.mssfix > 0
+        && c->options.ce.fragment_encap != c->options.ce.mssfix_encap)
+    {
+        msg(M_WARN, "WARNING: if you use --mssfix and --fragment, you should "
+                    "use the mtu for both or none.");
     }
 #endif
 }
-- 
2.33.0


