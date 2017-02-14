From: Antonio Quartulli <a@...2181...>
Date: Tue, 14 Feb 2017 23:27:47 +0800
Message-Id: <20170214152747.344-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] Allow learning iroutes with network made up
	of all 0s (only if netbits < 8)
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
Cc: Antonio Quartulli <a@...2181...>

It is plausible for a user to be willing to add a route for a network
made up of all 0s via a VPN client (i.e. 0.0.0.0/1), therefore such
iroute should be supported.

As of now the option parsing code will accept such iroute, but
the learning routine will (silently) reject it after a sanity check.

Such check prevents routes with network made up of all 0s to be
learnt at all..

Change the sanity check so that it will reject iroutes to network
made up of 0s only when netbits is greater than 7.

The reason for choosing 7 is because anything within 0.0.0.0/8 is not
really routable among networks.

While at it, make the sanity check louder so that it can print the
reason why a route is being rejected.

Trac: #726
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/mroute.c | 37 +++++++++++++++++++++++++++++++------
 src/openvpn/mroute.h |  3 ++-
 src/openvpn/multi.c  |  9 ++++-----
 3 files changed, 37 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 33c2ef43..6df0f383 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -66,25 +66,50 @@ is_mac_mcast_maddr(const struct mroute_addr *addr)
  * Don't learn certain addresses.
  */
 bool
-mroute_learnable_address(const struct mroute_addr *addr)
+mroute_learnable_address(const struct mroute_addr *addr, int msglevel,
+                         struct gc_arena *gc)
 {
     int i;
-    bool not_all_zeros = false;
-    bool not_all_ones = false;
+    bool all_zeros = true;
+    bool all_ones = true;
 
     for (i = 0; i < addr->len; ++i)
     {
         int b = addr->raw_addr[i];
         if (b != 0x00)
         {
-            not_all_zeros = true;
+            all_zeros = false;
         }
         if (b != 0xFF)
         {
-            not_all_ones = true;
+            all_ones = false;
         }
     }
-    return not_all_zeros && not_all_ones && !is_mac_mcast_maddr(addr);
+
+    /* only networkss shorter than 8 bits are allowed to be all 0s. */
+    if (all_zeros
+        && !((addr->type & MR_WITH_NETBITS) && (addr->netbits < 8)))
+    {
+        msg(msglevel, "Can't learn %s: network is all 0s, but netbits >= 8",
+            mroute_addr_print(addr, gc));
+        return false;
+    }
+
+    if (all_ones)
+    {
+        msg(msglevel, "Can't learn %s: network is all 1s",
+            mroute_addr_print(addr, gc));
+        return false;
+    }
+
+    if (is_mac_mcast_maddr(addr))
+    {
+        msg(msglevel, "Can't learn %s: network is a multicast address",
+            mroute_addr_print(addr, gc));
+        return false;
+    }
+
+    return true;
 }
 
 static inline void
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 06983487..23786b48 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -142,7 +142,8 @@ bool mroute_extract_openvpn_sockaddr(struct mroute_addr *addr,
                                      const struct openvpn_sockaddr *osaddr,
                                      bool use_port);
 
-bool mroute_learnable_address(const struct mroute_addr *addr);
+bool mroute_learnable_address(const struct mroute_addr *addr, int msglevel,
+                              struct gc_arena *gc);
 
 uint32_t mroute_addr_hash_function(const void *key, uint32_t iv);
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 56009b73..a728fd9c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1078,6 +1078,7 @@ multi_learn_addr(struct multi_context *m,
     struct hash_bucket *bucket = hash_bucket(m->vhash, hv);
     struct multi_route *oldroute = NULL;
     struct multi_instance *owner = NULL;
+    struct gc_arena gc = gc_new();
 
     /* if route currently exists, get the instance which owns it */
     he = hash_lookup_fast(m->vhash, bucket, addr, hv);
@@ -1091,11 +1092,10 @@ multi_learn_addr(struct multi_context *m,
     }
 
     /* do we need to add address to hash table? */
-    if ((!owner || owner != mi)
-        && mroute_learnable_address(addr)
+    if ((!owner || owner != mi) && mroute_learnable_address(addr, D_MULTI_LOW,
+                                                            &gc)
         && !mroute_addr_equal(addr, &m->local))
     {
-        struct gc_arena gc = gc_new();
         struct multi_route *newroute;
         bool learn_succeeded = false;
 
@@ -1152,9 +1152,8 @@ multi_learn_addr(struct multi_context *m,
         {
             free(newroute);
         }
-
-        gc_free(&gc);
     }
+    gc_free(&gc);
 
     return owner;
 }
-- 
2.11.1


