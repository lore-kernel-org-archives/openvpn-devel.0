From: Selva Nair <selva.nair@...277...>
Date: Sat,  4 Jun 2016 00:57:43 -0400
Message-Id: <1465016263-23048-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Fix the comparison of pull options hash on
	restart
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/init.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 42baf97..4b044f4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1717,7 +1717,7 @@ options_hash_changed_or_zero(const struct md5_digest *a,
 {
   const struct md5_digest zero = {{0}};
   return memcmp (a, b, sizeof(struct md5_digest)) ||
-      memcmp (a, &zero, sizeof(struct md5_digest));
+      !memcmp (a, &zero, sizeof(struct md5_digest));
 }
 #endif /* P2MP */
 
-- 
1.7.10.4


