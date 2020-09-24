From: Simon Rozman <simon@...2293...>
Date: Thu, 24 Sep 2020 08:44:52 +0200
Message-Id: <20200924064452.1001-3-simon@...2293...>
In-Reply-To: <20200924064452.1001-1-simon@...2293...>
References: <20200924064452.1001-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] netsh: Delete WINS servers on TUN close
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

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpn/tun.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index b1cd7a1b..80ae6958 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6706,6 +6706,16 @@ netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_arena *gc
         netsh_command(&argv, 1, M_WARN);
     }
 
+    if (!ipv6 && tt->options.wins_len > 0)
+    {
+        argv_printf(&argv,
+                    "%s%s interface ipv4 delete winsservers %lu all",
+                    get_win_sys_path(),
+                    NETSH_PATH_SUFFIX,
+                    tt->adapter_index);
+        netsh_command(&argv, 1, M_WARN);
+    }
+
     if (ipv6 && tt->type == DEV_TYPE_TUN)
     {
         delete_route_connected_v6_net(tt);
-- 
2.28.0.windows.1


