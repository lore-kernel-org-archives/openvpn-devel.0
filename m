From: Steffan Karger <steffan@...1856...>
Date: Wed, 28 Sep 2016 13:08:18 +0200
Message-Id: <1475060898-21462-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Don't deference type-punned pointers
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

Fixes compiler warnings (undefined behavior) by making the copy explicit
to comply to strict aliasing rules.  With newer GCC the old code could
actually lead to undefined behaviour.

See e.g. http://blog.regehr.org/archives/959.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/mroute.h | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 608f70b..1296285 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -189,16 +189,20 @@ mroute_extract_in_addr_t (struct mroute_addr *dest, const in_addr_t src)
   dest->type = MR_ADDR_IPV4;
   dest->netbits = 0;
   dest->len = 4;
-  *(in_addr_t*)dest->addr = htonl (src);
+  in_addr_t tmp_addr = htonl (src);
+  memcpy(dest->addr, &tmp_addr, sizeof(uint32_t));
 }
 
 static inline in_addr_t
 in_addr_t_from_mroute_addr (const struct mroute_addr *addr)
 {
-  if ((addr->type & MR_ADDR_MASK) == MR_ADDR_IPV4 && addr->netbits == 0 && addr->len == 4)
-    return ntohl(*(in_addr_t*)addr->addr);
-  else
+  if ((addr->type & MR_ADDR_MASK) == MR_ADDR_IPV4 && addr->netbits == 0 && addr->len == 4) {
+    in_addr_t tmp = 0;
+    memcpy(&tmp, addr->addr, sizeof(tmp));
+    return ntohl(tmp);
+  } else {
     return 0;
+  }
 }
 
 static inline void
-- 
2.7.4


