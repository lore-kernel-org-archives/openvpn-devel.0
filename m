From: Antonio Quartulli <a@...2181...>
Date: Sat, 18 Apr 2020 03:31:23 +0200
Message-Id: <20200418013123.22551-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] sitnl: fix TUN/TAP confusion in error
 messages
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

The is_tun_p2p() function can return false for both TAP or TUN
interfaces (under certain conditions), therefore we should not
assume any TUN/TAP type when printing related messages.

Remove reference to TUN/TAP when printing messages under conditions
based on is_tun_p2p().

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/tun.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 79d92ea6..8e692977 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1093,7 +1093,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
         if (net_addr_ptp_v4_add(ctx, ifname, &tt->local,
                                 &tt->remote_netmask) < 0)
         {
-            msg(M_FATAL, "Linux can't add IP to TUN interface %s", ifname);
+            msg(M_FATAL, "Linux can't add IP to interface %s", ifname);
         }
     }
     else
@@ -1101,7 +1101,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
         if (net_addr_v4_add(ctx, ifname, &tt->local,
                             netmask_to_netbits2(tt->remote_netmask)) < 0)
         {
-            msg(M_FATAL, "Linux can't add IP to TAP interface %s", ifname);
+            msg(M_FATAL, "Linux can't add IP to interface %s", ifname);
         }
     }
 #elif defined(TARGET_ANDROID)
@@ -1970,7 +1970,7 @@ undo_ifconfig_ipv4(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         if (net_addr_ptp_v4_del(ctx, tt->actual_name, &tt->local,
                                 &tt->remote_netmask) < 0)
         {
-            msg(M_WARN, "Linux can't del IP from TUN iface %s",
+            msg(M_WARN, "Linux can't del IP from iface %s",
                 tt->actual_name);
         }
     }
@@ -1978,7 +1978,7 @@ undo_ifconfig_ipv4(struct tuntap *tt, openvpn_net_ctx_t *ctx)
     {
         if (net_addr_v4_del(ctx, tt->actual_name, &tt->local, netbits) < 0)
         {
-            msg(M_WARN, "Linux can't del IP from TAP iface %s",
+            msg(M_WARN, "Linux can't del IP from iface %s",
                 tt->actual_name);
         }
     }
-- 
2.26.1


