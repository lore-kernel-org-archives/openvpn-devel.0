From: Tom Yan <tom.ty89@...277...>
Date: Sun,  3 Nov 2019 13:31:48 +0800
Message-Id: <20191103053148.18059-1-tom.ty89@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] tun/iproute2: support 31-bit ipv4 prefix
 (RFC 3021)
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

---
 src/openvpn/tun.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 80eaa2c4..f5823516 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -965,13 +965,14 @@ do_ifconfig(struct tuntap *tt,
         else
         {
             argv_printf(&argv,
-                        "%s addr add dev %s %s/%d broadcast %s",
+                        "%s addr add dev %s %s/%d",
                         iproute_path,
                         actual,
                         ifconfig_local,
-                        netmask_to_netbits2(tt->remote_netmask),
-                        ifconfig_broadcast
+                        netmask_to_netbits2(tt->remote_netmask)
                         );
+            if (netmask_to_netbits2(tt->remote_netmask) < 31)
+                argv_printf_cat(&argv, " broadcast %s", ifconfig_broadcast);
             argv_msg(M_INFO, &argv);
             openvpn_execve_check(&argv, es, S_FATAL, "Linux ip addr add failed");
         }
-- 
2.23.0


