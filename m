From: Antonio Quartulli <a@...2181...>
Date: Wed, 29 Sep 2021 13:59:05 +0200
Message-Id: <20210929115905.1281-1-a@...2181...>
In-Reply-To: <202109291121.18TBLdrH038680@...2054...>
References: <202109291121.18TBLdrH038680@...2054...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] networking: add missing brackets
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

Our codestyle demands having brackets also around if-blocks made up
by one line only.

In patch "networking: add and implement net_addr_ll_set() API" this
rule was not respected and a new one-line-if-block was added with no
brackets.

Fix this by adding the related brackets as needed.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/networking_iproute2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index c6623b19..67b8894b 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -107,7 +107,9 @@ net_addr_ll_set(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,
     argv_msg(M_INFO, &argv);
     if (!openvpn_execve_check(&argv, ctx->es, M_WARN,
                               "Linux ip link set addr failed"))
+    {
         ret = -1;
+    }
 
     argv_free(&argv);
 
-- 
2.32.0


