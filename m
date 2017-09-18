From: Antonio Quartulli <a@...2181...>
Date: Tue, 19 Sep 2017 02:13:41 +0800
Message-Id: <20170918181343.12924-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v4 1/3] pf: restyle pf_c2c/addr_test() to
 make them 'struct context' agnostic
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
Cc: Antonio Quartulli <a@...2181...>, Steffan Karger <steffan@...1856...>

In the attempt of getting rid of any pf-inline.h file, we need
to make sure that inline functions do not trigger any circular
include dependency.

For this reason, avoid pf_c2c/addr_test() to be 'struct context'
aware, so that pf-inline.h does not need to rely on the content
of openvpn.h.

Cc: Steffan Karger <steffan@...1856...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

v1-v3: skipped
v4: this is the first version of this patch, but named v4 for conveniency


 src/openvpn/multi.c     | 25 ++++++++++++++++++-------
 src/openvpn/pf-inline.h | 16 ++++++++++------
 src/openvpn/pf.c        |  6 +++++-
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index c798c438..641b825a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2233,7 +2233,10 @@ multi_bcast(struct multi_context *m,
 #ifdef ENABLE_PF
                 if (sender_instance)
                 {
-                    if (!pf_c2c_test(&sender_instance->context, &mi->context, "bcast_c2c"))
+                    if (!pf_c2c_test(&sender_instance->context.c2.pf,
+                                     &sender_instance->context,
+                                     &mi->context.c2.pf, &mi->context,
+                                     "bcast_c2c"))
                     {
                         msg(D_PF_DROPPED_BCAST, "PF: client[%s] -> client[%s] packet dropped by BCAST packet filter",
                             mi_prefix(sender_instance),
@@ -2243,7 +2246,8 @@ multi_bcast(struct multi_context *m,
                 }
                 if (sender_addr)
                 {
-                    if (!pf_addr_test(&mi->context, sender_addr, "bcast_src_addr"))
+                    if (!pf_addr_test(&mi->context.c2.pf, &mi->context,
+                                      sender_addr, "bcast_src_addr"))
                     {
                         struct gc_arena gc = gc_new();
                         msg(D_PF_DROPPED_BCAST, "PF: addr[%s] -> client[%s] packet dropped by BCAST packet filter",
@@ -2602,7 +2606,8 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                         if (mi)
                         {
 #ifdef ENABLE_PF
-                            if (!pf_c2c_test(c, &mi->context, "tun_c2c"))
+                            if (!pf_c2c_test(&c->c2.pf, c, &mi->context.c2.pf,
+                                             &mi->context, "tun_c2c"))
                             {
                                 msg(D_PF_DROPPED, "PF: client -> client[%s] packet dropped by TUN packet filter",
                                     mi_prefix(mi));
@@ -2618,7 +2623,8 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                     }
                 }
 #ifdef ENABLE_PF
-                if (c->c2.to_tun.len && !pf_addr_test(c, &dest, "tun_dest_addr"))
+                if (c->c2.to_tun.len && !pf_addr_test(&c->c2.pf, c, &dest,
+                                                      "tun_dest_addr"))
                 {
                     msg(D_PF_DROPPED, "PF: client -> addr[%s] packet dropped by TUN packet filter",
                         mroute_addr_print_ex(&dest, MAPF_SHOW_ARP, &gc));
@@ -2663,7 +2669,10 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                                 if (mi)
                                 {
 #ifdef ENABLE_PF
-                                    if (!pf_c2c_test(c, &mi->context, "tap_c2c"))
+                                    if (!pf_c2c_test(&c->c2.pf, c,
+                                                     &mi->context.c2.pf,
+                                                     &mi->context,
+                                                     "tap_c2c"))
                                     {
                                         msg(D_PF_DROPPED, "PF: client -> client[%s] packet dropped by TAP packet filter",
                                             mi_prefix(mi));
@@ -2679,7 +2688,9 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                             }
                         }
 #ifdef ENABLE_PF
-                        if (c->c2.to_tun.len && !pf_addr_test(c, &edest, "tap_dest_addr"))
+                        if (c->c2.to_tun.len && !pf_addr_test(&c->c2.pf, c,
+                                                              &edest,
+                                                              "tap_dest_addr"))
                         {
                             msg(D_PF_DROPPED, "PF: client -> addr[%s] packet dropped by TAP packet filter",
                                 mroute_addr_print_ex(&edest, MAPF_SHOW_ARP, &gc));
@@ -2792,7 +2803,7 @@ multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags
                     set_prefix(m->pending);
 
 #ifdef ENABLE_PF
-                    if (!pf_addr_test(c, e2, "tun_tap_src_addr"))
+                    if (!pf_addr_test(&c->c2.pf, c, e2, "tun_tap_src_addr"))
                     {
                         msg(D_PF_DROPPED, "PF: addr[%s] -> client packet dropped by packet filter",
                             mroute_addr_print_ex(&src, MAPF_SHOW_ARP, &gc));
diff --git a/src/openvpn/pf-inline.h b/src/openvpn/pf-inline.h
index ac19ac4c..7e38e674 100644
--- a/src/openvpn/pf-inline.h
+++ b/src/openvpn/pf-inline.h
@@ -31,20 +31,24 @@
 #define PCT_SRC  1
 #define PCT_DEST 2
 static inline bool
-pf_c2c_test(const struct context *src, const struct context *dest, const char *prefix)
+pf_c2c_test(const struct pf_context *src_pf, const struct context *src,
+            const struct pf_context *dest_pf, const struct context *dest,
+            const char *prefix)
 {
-    bool pf_cn_test(struct pf_set *pfs, const struct tls_multi *tm, const int type, const char *prefix);
+    bool pf_cn_test(const struct context *src, const struct context *dest,
+                    const int type, const char *prefix);
 
-    return (!src->c2.pf.enabled  || pf_cn_test(src->c2.pf.pfs,  dest->c2.tls_multi, PCT_DEST, prefix))
-           && (!dest->c2.pf.enabled || pf_cn_test(dest->c2.pf.pfs, src->c2.tls_multi,  PCT_SRC,  prefix));
+    return (!src_pf->enabled || pf_cn_test(src, dest, PCT_DEST, prefix))
+           && (!dest_pf->enabled || pf_cn_test(dest, src, PCT_SRC, prefix));
 }
 
 static inline bool
-pf_addr_test(const struct context *src, const struct mroute_addr *dest, const char *prefix)
+pf_addr_test(const struct pf_context *src_pf, const struct context *src,
+             const struct mroute_addr *dest, const char *prefix)
 {
     bool pf_addr_test_dowork(const struct context *src, const struct mroute_addr *dest, const char *prefix);
 
-    if (src->c2.pf.enabled)
+    if (src_pf->enabled)
     {
         return pf_addr_test_dowork(src, dest, prefix);
     }
diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index 5cb002bf..135cb15d 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -442,8 +442,12 @@ lookup_cn_rule(struct hash *h, const char *cn, const uint32_t cn_hash)
 }
 
 bool
-pf_cn_test(struct pf_set *pfs, const struct tls_multi *tm, const int type, const char *prefix)
+pf_cn_test(const struct context *src, const struct context *dest,
+           const int type, const char *prefix)
 {
+    struct pf_set *pfs = src->c2.pf.pfs;
+    struct tls_multi *tm = dest->c2.tls_multi;
+
     if (pfs && !pfs->kill)
     {
         const char *cn;
-- 
2.14.1


