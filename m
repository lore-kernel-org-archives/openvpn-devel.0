From: Tom Yan <tom.ty89@...277...>
Date: Wed, 13 Nov 2019 18:07:01 +0800
Message-Id: <20191113100702.6863-3-tom.ty89@...277...>
In-Reply-To: <61c1b837-3f81-6783-5934-8128bb81881b@...2181...>
References: <61c1b837-3f81-6783-5934-8128bb81881b@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 3/4] Avoid reserving one more address at
 pool end
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

It appears to be a copy-and-paste kind of typo (pool start is network address + 2).
---
 src/openvpn/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 5b2ca0cc..6e2f0891 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -349,7 +349,7 @@ helper_client_server(struct options *o)
             {
                 o->ifconfig_pool_defined = true;
                 o->ifconfig_pool_start = o->server_network + ptp + 1;
-                o->ifconfig_pool_end = (o->server_network | ~o->server_netmask) - ptp * 2;
+                o->ifconfig_pool_end = (o->server_network | ~o->server_netmask) - ptp;
                 ifconfig_pool_verify_range(M_USAGE, o->ifconfig_pool_start, o->ifconfig_pool_end);
             }
             o->ifconfig_pool_netmask = o->server_netmask;
-- 
2.24.0


