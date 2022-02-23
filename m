From: Antonio Quartulli <a@...2181...>
Date: Wed, 23 Feb 2022 08:58:47 +0100
Message-Id: <20220223075847.11704-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] networking: use OPENVPN_ETH_ALEN instead of
 ETH_ALEN
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

With the introduction of SITNL two occurrences of ETH_ALEN
were introduced in the code. This define exists on Linux in
the linux/if_ether.h header, however the latter is included
in linux/if_tun.h which may or may not exist (depending on
how old your system is).

If the system lacks if_tun.h then the compilation fails because
ETH_ALEN cannot be found.

For this reason, swap ETH_ALEN with OPENVPN_ETH_ALEN which is
already used in other places of the code.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/lladdr.c           | 2 +-
 src/openvpn/networking_sitnl.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/lladdr.c b/src/openvpn/lladdr.c
index 3ddbebb3..4abe8c54 100644
--- a/src/openvpn/lladdr.c
+++ b/src/openvpn/lladdr.c
@@ -26,7 +26,7 @@ set_lladdr(openvpn_net_ctx_t *ctx, const char *ifname, const char *lladdr,
     }
 
 #if defined(TARGET_LINUX)
-    uint8_t addr[ETH_ALEN];
+    uint8_t addr[OPENVPN_ETH_ALEN];
 
     sscanf(lladdr, MAC_FMT, MAC_SCAN_ARG(addr));
     r = (net_addr_ll_set(ctx, ifname, addr) == 0);
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 959c897f..c16323ac 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -748,7 +748,7 @@ net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
     req.i.ifi_family = AF_PACKET;
     req.i.ifi_index = ifindex;
 
-    SITNL_ADDATTR(&req.n, sizeof(req), IFLA_ADDRESS, addr, ETH_ALEN);
+    SITNL_ADDATTR(&req.n, sizeof(req), IFLA_ADDRESS, addr, OPENVPN_ETH_ALEN);
 
     msg(M_INFO, "%s: lladdr " MAC_FMT " for %s", __func__, MAC_PRINT_ARG(addr),
         iface);
-- 
2.34.1


