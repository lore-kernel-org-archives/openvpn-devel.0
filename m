From: Antonio Quartulli <a@...2181...>
Date: Wed, 13 Jul 2022 14:14:16 +0200
Message-Id: <20220713121416.1912-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] networking_sitnl: always return negative
 error code in case of failure
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

The API is designed to always return a negative error code in case of
failure, therefore we should return '-errno' when ifindex has failed.

Signed-off-by: Antonio Quartulli <a@...2181...>
---

** This patch should also go to 2.5 **

 src/openvpn/networking_sitnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 0944ad0a..46db2361 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1374,7 +1374,7 @@ net_iface_del(openvpn_net_ctx_t *ctx, const char *iface)
 
     if (!ifindex)
     {
-        return errno;
+        return -errno;
     }
 
     req.n.nlmsg_len = NLMSG_LENGTH(sizeof(req.i));
-- 
2.35.1


