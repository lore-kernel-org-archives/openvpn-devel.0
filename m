From: Gert Doering <gert@...1296...>
Date: Fri, 10 Jan 2014 17:25:42 +0100
Message-Id: <1389371142-26705-2-git-send-email-gert@...1296...>
In-Reply-To: <1389371142-26705-1-git-send-email-gert@...1296...>
References: <1389371142-26705-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 2/2] Cleanup ir6->netbits handling.
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

Get rid of all "if (ir6->netbits>=0)" checks, as those are always true
(unlike ir->netbits for IPv4, we don't do the special case for "if it's
a host, put -1 in there" for IPv6).

Merge mroute_helper_{add,del}_iroute and mroute_helper_{add,del}_iroute6
into unified mroute_helper_{add,del}_iroute46() function as they did the
same thing anyway, just with slightly different parameters.

Make Arne happy.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/mroute.c | 56 +++++++++++-----------------------------------------
 src/openvpn/mroute.h |  6 ++----
 src/openvpn/multi.c  | 15 +++++---------
 3 files changed, 18 insertions(+), 59 deletions(-)

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 850e336..ba4ef46 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -487,62 +487,28 @@ mroute_helper_regenerate (struct mroute_helper *mh)
 }
 
 void
-mroute_helper_add_iroute (struct mroute_helper *mh, const struct iroute *ir)
+mroute_helper_add_iroute46 (struct mroute_helper *mh, int netbits)
 {
-  if (ir->netbits >= 0)
+  if (netbits >= 0)
     {
-      ASSERT (ir->netbits < MR_HELPER_NET_LEN);
+      ASSERT (netbits < MR_HELPER_NET_LEN);
       ++mh->cache_generation;
-      ++mh->net_len_refcount[ir->netbits];
-      if (mh->net_len_refcount[ir->netbits] == 1)
+      ++mh->net_len_refcount[netbits];
+      if (mh->net_len_refcount[netbits] == 1)
 	mroute_helper_regenerate (mh);
     }
 }
 
 void
-mroute_helper_del_iroute (struct mroute_helper *mh, const struct iroute *ir)
+mroute_helper_del_iroute46 (struct mroute_helper *mh, int netbits)
 {
-  if (ir->netbits >= 0)
+  if (netbits >= 0)
     {
-      ASSERT (ir->netbits < MR_HELPER_NET_LEN);
+      ASSERT (netbits < MR_HELPER_NET_LEN);
       ++mh->cache_generation;
-      --mh->net_len_refcount[ir->netbits];
-      ASSERT (mh->net_len_refcount[ir->netbits] >= 0);
-      if (!mh->net_len_refcount[ir->netbits])
-	mroute_helper_regenerate (mh);
-    }
-}
-
-/* this is a bit inelegant, we really should have a helper to that 
- * is only passed the netbits value, and not the whole struct iroute *
- * - thus one helper could do IPv4 and IPv6.  For the sake of "not change
- * code unrelated to IPv4" this is left for later cleanup, for now.
- */
-void
-mroute_helper_add_iroute6 (struct mroute_helper *mh, 
-                           const struct iroute_ipv6 *ir6)
-{
-  if (ir6->netbits >= 0)
-    {
-      ASSERT (ir6->netbits < MR_HELPER_NET_LEN);
-      ++mh->cache_generation;
-      ++mh->net_len_refcount[ir6->netbits];
-      if (mh->net_len_refcount[ir6->netbits] == 1)
-	mroute_helper_regenerate (mh);
-    }
-}
-
-void
-mroute_helper_del_iroute6 (struct mroute_helper *mh, 
-			   const struct iroute_ipv6 *ir6)
-{
-  if (ir6->netbits >= 0)
-    {
-      ASSERT (ir6->netbits < MR_HELPER_NET_LEN);
-      ++mh->cache_generation;
-      --mh->net_len_refcount[ir6->netbits];
-      ASSERT (mh->net_len_refcount[ir6->netbits] >= 0);
-      if (!mh->net_len_refcount[ir6->netbits])
+      --mh->net_len_refcount[netbits];
+      ASSERT (mh->net_len_refcount[netbits] >= 0);
+      if (!mh->net_len_refcount[netbits])
 	mroute_helper_regenerate (mh);
     }
 }
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index b72b5ff..608f70b 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -125,10 +125,8 @@ void mroute_addr_mask_host_bits (struct mroute_addr *ma);
 
 struct mroute_helper *mroute_helper_init (int ageable_ttl_secs);
 void mroute_helper_free (struct mroute_helper *mh);
-void mroute_helper_add_iroute (struct mroute_helper *mh, const struct iroute *ir);
-void mroute_helper_del_iroute (struct mroute_helper *mh, const struct iroute *ir);
-void mroute_helper_add_iroute6 (struct mroute_helper *mh, const struct iroute_ipv6 *ir6);
-void mroute_helper_del_iroute6 (struct mroute_helper *mh, const struct iroute_ipv6 *ir6);
+void mroute_helper_add_iroute46 (struct mroute_helper *mh, int netbits);
+void mroute_helper_del_iroute46 (struct mroute_helper *mh, int netbits);
 
 /*
  * Given a raw packet in buf, return the src and dest
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f016b14..2839b30 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -450,10 +450,10 @@ multi_del_iroutes (struct multi_context *m,
   if (TUNNEL_TYPE (mi->context.c1.tuntap) == DEV_TYPE_TUN)
     {
       for (ir = mi->context.options.iroutes; ir != NULL; ir = ir->next)
-	mroute_helper_del_iroute (m->route_helper, ir);
+	mroute_helper_del_iroute46 (m->route_helper, ir->netbits);
 
       for ( ir6 = mi->context.options.iroutes_ipv6; ir6 != NULL; ir6 = ir6->next )
-	mroute_helper_del_iroute6 (m->route_helper, ir6);
+	mroute_helper_del_iroute46 (m->route_helper, ir6->netbits);
     }
 }
 
@@ -1169,23 +1169,18 @@ multi_add_iroutes (struct multi_context *m,
 		 print_in_addr_t (ir->network, 0, &gc),
 		 multi_instance_string (mi, false, &gc));
 
-	  mroute_helper_add_iroute (m->route_helper, ir);
+	  mroute_helper_add_iroute46 (m->route_helper, ir->netbits);
       
 	  multi_learn_in_addr_t (m, mi, ir->network, ir->netbits, false);
 	}
       for ( ir6 = mi->context.options.iroutes_ipv6; ir6 != NULL; ir6 = ir6->next )
 	{
-	  if (ir6->netbits >= 0)
-	    msg (D_MULTI_LOW, "MULTI: internal route %s/%d -> %s",
+	  msg (D_MULTI_LOW, "MULTI: internal route %s/%d -> %s",
 		 print_in6_addr (ir6->network, 0, &gc),
 		 ir6->netbits,
 		 multi_instance_string (mi, false, &gc));
-	  else
-	    msg (D_MULTI_LOW, "MULTI: internal route %s -> %s",
-		 print_in6_addr (ir6->network, 0, &gc),
-		 multi_instance_string (mi, false, &gc));
 
-	  mroute_helper_add_iroute6 (m->route_helper, ir6);
+	  mroute_helper_add_iroute46 (m->route_helper, ir6->netbits);
       
 	  multi_learn_in6_addr (m, mi, ir6->network, ir6->netbits, false);
 	}
-- 
1.8.3.2


