From: Antonio Quartulli <a@...2181...>
Date: Thu,  7 Apr 2022 22:14:11 +0200
Message-Id: <20220407201411.22486-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] networking_iproute2: don't pass M_WARN to
 openvpn_execve_check()
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

openvpn_execve_check() expects a set of flags as third argument and not
a loglevel. For this reason, if no FATAL behaviour is expected, we
should simply pass 0. openvpn_execve_check() will then pick the
appropriate loglevel on its own.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/networking_iproute2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 3ca2bb35..02fd3cb6 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -105,8 +105,8 @@ net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
                 iproute_path, MAC_PRINT_ARG(addr), iface);
 
     argv_msg(M_INFO, &argv);
-    if (!openvpn_execve_check(&argv, ctx->es, M_WARN,
-                              "Linux ip link set addr failed"))
+    if (!openvpn_execve_check(&argv, ctx->es, 0,
+			      "Linux ip link set addr failed"))
     {
         ret = -1;
     }
-- 
2.35.1


