From: Frank de Brabander <debrabander@...277...>
Date: Fri, 17 Feb 2012 22:04:50 +0100
Message-Id: <1329512690-18831-1-git-send-email-debrabander@...277...>
Subject: [Openvpn-devel] [PATCH] Bogus check for negative values on an
	unsigned number.
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
Cc: Frank de Brabander <debrabander@...277...>

This causes compiler warnings when using Clang instead of default GCC.

Signed-off-by: Frank de Brabander <debrabander@...277...>
---
 mroute.c |   24 +++++++++---------------
 1 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/mroute.c b/mroute.c
index 285b151..0213a3e 100644
--- a/mroute.c
+++ b/mroute.c
@@ -516,29 +516,23 @@ void
 mroute_helper_add_iroute6 (struct mroute_helper *mh, 
                            const struct iroute_ipv6 *ir6)
 {
-  if (ir6->netbits >= 0)
-    {
-      ASSERT (ir6->netbits < MR_HELPER_NET_LEN);
-      ++mh->cache_generation;
-      ++mh->net_len_refcount[ir6->netbits];
-      if (mh->net_len_refcount[ir6->netbits] == 1)
+  ASSERT (ir6->netbits < MR_HELPER_NET_LEN);
+  ++mh->cache_generation;
+  ++mh->net_len_refcount[ir6->netbits];
+  if (mh->net_len_refcount[ir6->netbits] == 1)
 	mroute_helper_regenerate (mh);
-    }
 }
 
 void
 mroute_helper_del_iroute6 (struct mroute_helper *mh, 
 			   const struct iroute_ipv6 *ir6)
 {
-  if (ir6->netbits >= 0)
-    {
-      ASSERT (ir6->netbits < MR_HELPER_NET_LEN);
-      ++mh->cache_generation;
-      --mh->net_len_refcount[ir6->netbits];
-      ASSERT (mh->net_len_refcount[ir6->netbits] >= 0);
-      if (!mh->net_len_refcount[ir6->netbits])
+  ASSERT (ir6->netbits < MR_HELPER_NET_LEN);
+  ++mh->cache_generation;
+  --mh->net_len_refcount[ir6->netbits];
+  ASSERT (mh->net_len_refcount[ir6->netbits] >= 0);
+  if (!mh->net_len_refcount[ir6->netbits])
 	mroute_helper_regenerate (mh);
-    }
 }
 
 void
-- 
1.7.5.4


