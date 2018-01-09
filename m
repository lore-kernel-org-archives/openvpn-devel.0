From: Eyal Birger <eyal.birger@...277...>
Date: Tue,  9 Jan 2018 09:16:13 +0200
Message-Id: <1515482173-29447-1-git-send-email-eyal.birger@...277...>
Subject: [Openvpn-devel] [PATCH] Windows: Set interface IPv6 prefix length
 when configuring address
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

Address prefix length defaults to /64 on Windows. This change allows using
Windows clients in setups that use a different prefix length.

Note: the ability to set the prefix length is documented in the netsh
'add address' command, but works on the 'set address' command as well.

Signed-off-by: Eyal Birger <eyal.birger@...277...>
---
 src/openvpn/tun.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 25831ce..b2b4795 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1561,15 +1561,16 @@ do_ifconfig(struct tuntap *tt,
             }
             else
             {
-                /* example: netsh interface ipv6 set address interface=42 2001:608:8003::d store=active */
+                /* example: netsh interface ipv6 set address interface=42 2001:608:8003::d/64 store=active */
                 char iface[64];
                 openvpn_snprintf(iface, sizeof(iface), "interface=%lu", tt->adapter_index );
                 argv_printf(&argv,
-                            "%s%sc interface ipv6 set address %s %s store=active",
+                            "%s%sc interface ipv6 set address %s %s/%d store=active",
                             get_win_sys_path(),
                             NETSH_PATH_SUFFIX,
                             iface,
-                            ifconfig_ipv6_local );
+                            ifconfig_ipv6_local,
+                            tt->netbits_ipv6);
                 netsh_command(&argv, 4, M_FATAL);
                 /* set ipv6 dns servers if any are specified */
                 netsh_set_dns6_servers(tt->options.dns6, tt->options.dns6_len, actual);
-- 
2.7.4


