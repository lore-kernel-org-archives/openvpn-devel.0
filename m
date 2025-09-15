From: Sebastian Marsching <sebastian-git-2016@...2913...>
Date: Mon, 15 Sep 2025 13:05:07 +0200
Message-ID: <20250915110507.20557-1-sebastian-git-2016@...2913...>
In-Reply-To: <aMXW3jwQJ9TyvOae@...1296...>
References: <aMXW3jwQJ9TyvOae@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Bugfix: Set broadcast address on
 interface.
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
Cc: gert@...1296..., Sebastian Marsching <sebastian-git-2016@...2913...>

This fixes a problem that was introduced in OpenVPN 2.5. Previously,
the ifconfig utility was used for adding the local address to an
interface. This utility automatically sets the correct broadcast address
based on the given unicast address and netmask.

Due to switching to iproute and Netlink, this does not happen
automatically any longer, which means that applications that rely on
broadcasts do not work correctly.

This patch fixes this issue both when using iproute (by telling iproute
to set the broadcast address based on the local address and prefix) and
when using Netlink (by calculating the correct broadcast address and
setting it).

Signed-off-by: Sebastian Marsching <sebastian-git-2016@...2913...>
---
 src/openvpn/networking_iproute2.c | 2 +-
 src/openvpn/networking_sitnl.c    | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index e9be3a45..773571d6 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -150,7 +150,7 @@ net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface, const in_addr_t *addr
 
     const char *addr_str = print_in_addr_t(*addr, 0, &ctx->gc);
 
-    argv_printf(&argv, "%s addr add dev %s %s/%d", iproute_path, iface, addr_str, prefixlen);
+    argv_printf(&argv, "%s addr add dev %s %s/%d broadcast +", iproute_path, iface, addr_str, prefixlen);
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip addr add failed");
 
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 4210e92c..00d61067 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -31,6 +31,7 @@
 #include "misc.h"
 #include "networking.h"
 #include "proto.h"
+#include "route.h"
 
 #include <errno.h>
 #include <string.h>
@@ -803,6 +804,13 @@ sitnl_addr_set(int cmd, uint32_t flags, int ifindex, sa_family_t af_family,
         SITNL_ADDATTR(&req.n, sizeof(req), IFA_LOCAL, local, size);
     }
 
+    if (af_family == AF_INET && local && !remote && prefixlen <= 30)
+    {
+        inet_address_t broadcast = *local;
+        broadcast.ipv4 |= htonl(~netbits_to_netmask(prefixlen));
+        SITNL_ADDATTR(&req.n, sizeof(req), IFA_BROADCAST, &broadcast, size);
+    }
+
     ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
     if (ret == -EEXIST)
     {
-- 
2.50.0


