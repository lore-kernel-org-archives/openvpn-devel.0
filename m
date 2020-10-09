From: Steffan Karger <steffan@...1856...>
Date: Fri,  9 Oct 2020 15:46:03 +0200
Message-Id: <20201009134603.36263-1-steffan@...1856...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] networking_iproute2: fix memory leak in
 net_iface_mtu_set()
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

ASAN yelled at me that someone forgot to call argv_free(). Fix that.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/networking_iproute2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index f3b9c614..3b460527 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -88,6 +88,8 @@ net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface, uint32_t mtu)
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip link set failed");
 
+    argv_free(&argv);
+
     return 0;
 }
 
-- 
2.25.1


