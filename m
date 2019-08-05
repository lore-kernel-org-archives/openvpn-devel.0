From: Antonio Quartulli <a@...2181...>
Date: Mon,  5 Aug 2019 11:25:28 +0200
Message-Id: <20190805092529.9467-6-a@...2181...>
In-Reply-To: <20190805092529.9467-1-a@...2181...>
References: <20190805092529.9467-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/6] networking_sitnl.c: uncrustify file
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
Cc: Antonio Quartulli <a@...2181...>, Antonio Quartulli <antonio@...515...>

Give this file a run under uncrustify to fix a few style glitches here
and there.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/networking_sitnl.c | 62 +++++++++++++++++++++++-----------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 976ecd28..e5c48932 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -45,7 +45,7 @@
 
 #define SITNL_ADDATTR(_msg, _max_size, _attr, _data, _size)         \
     {                                                               \
-        if (sitnl_addattr(_msg, _max_size, _attr, _data, _size) < 0)\
+        if (sitnl_addattr(_msg, _max_size, _attr, _data, _size) < 0) \
         {                                                           \
             goto err;                                               \
         }                                                           \
@@ -335,16 +335,16 @@ sitnl_send(struct nlmsghdr *payload, pid_t peer, unsigned int groups,
             }
 
 /*            if (((int)nladdr.nl_pid != peer) || (h->nlmsg_pid != nladdr.nl_pid)
-                || (h->nlmsg_seq != seq))
-            {
-                rcv_len -= NLMSG_ALIGN(len);
-                h = (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
-                msg(M_DEBUG, "%s: skipping unrelated message. nl_pid:%d (peer:%d) nl_msg_pid:%d nl_seq:%d seq:%d",
-                    __func__, (int)nladdr.nl_pid, peer, h->nlmsg_pid,
-                    h->nlmsg_seq, seq);
-                continue;
-            }
-*/
+ *               || (h->nlmsg_seq != seq))
+ *           {
+ *               rcv_len -= NLMSG_ALIGN(len);
+ *               h = (struct nlmsghdr *)((char *)h + NLMSG_ALIGN(len));
+ *               msg(M_DEBUG, "%s: skipping unrelated message. nl_pid:%d (peer:%d) nl_msg_pid:%d nl_seq:%d seq:%d",
+ *                   __func__, (int)nladdr.nl_pid, peer, h->nlmsg_pid,
+ *                   h->nlmsg_seq, seq);
+ *               continue;
+ *           }
+ */
             if (h->nlmsg_type == NLMSG_ERROR)
             {
                 err = (struct nlmsgerr *)NLMSG_DATA(h);
@@ -359,7 +359,9 @@ sitnl_send(struct nlmsghdr *payload, pid_t peer, unsigned int groups,
                     {
                         ret = 0;
                         if (cb)
+                        {
                             ret = cb(h, arg_cb);
+                        }
                     }
                     else
                     {
@@ -427,9 +429,11 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)
             case RTA_OIF:
                 ifindex = *(unsigned int *)RTA_DATA(rta);
                 break;
+
             /* route prefix */
             case RTA_DST:
                 break;
+
             /* GW for the route */
             case RTA_GATEWAY:
                 memcpy(&res->gw, RTA_DATA(rta), res->addr_size);
@@ -475,9 +479,11 @@ sitnl_route_best_gw(sa_family_t af_family, const inet_address_t *dst,
             res.addr_size = sizeof(in_addr_t);
             req.n.nlmsg_flags |= NLM_F_DUMP;
             break;
+
         case AF_INET6:
             res.addr_size = sizeof(struct in6_addr);
             break;
+
         default:
             /* unsupported */
             return -EINVAL;
@@ -598,7 +604,8 @@ net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
     }
 
     ifindex = if_nametoindex(iface);
-    if (ifindex == 0) {
+    if (ifindex == 0)
+    {
         msg(M_WARN, "%s: rtnl: cannot get ifindex for %s: %s", __func__, iface,
             strerror(errno));
         return -ENOENT;
@@ -612,9 +619,13 @@ net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
     req.i.ifi_index = ifindex;
     req.i.ifi_change |= IFF_UP;
     if (up)
+    {
         req.i.ifi_flags |= IFF_UP;
+    }
     else
+    {
         req.i.ifi_flags &= ~IFF_UP;
+    }
 
     msg(M_INFO, "%s: set %s %s", __func__, iface, up ? "up" : "down");
 
@@ -631,7 +642,8 @@ net_iface_mtu_set(openvpn_net_ctx_t *ctx, const char *iface,
     CLEAR(req);
 
     ifindex = if_nametoindex(iface);
-    if (ifindex == 0) {
+    if (ifindex == 0)
+    {
         msg(M_WARN | M_ERRNO, "%s: rtnl: cannot get ifindex for %s", __func__,
             iface);
         return -1;
@@ -676,9 +688,11 @@ sitnl_addr_set(int cmd, uint32_t flags, int ifindex, sa_family_t af_family,
         case AF_INET:
             size = sizeof(struct in_addr);
             break;
+
         case AF_INET6:
             size = sizeof(struct in6_addr);
             break;
+
         default:
             msg(M_WARN, "%s: rtnl: unknown address family %d", __func__,
                 af_family);
@@ -723,10 +737,12 @@ sitnl_addr_ptp_add(sa_family_t af_family, const char *iface,
 {
     int ifindex;
 
-    switch (af_family) {
+    switch (af_family)
+    {
         case AF_INET:
         case AF_INET6:
             break;
+
         default:
             return -EINVAL;
     }
@@ -755,10 +771,12 @@ sitnl_addr_ptp_del(sa_family_t af_family, const char *iface,
 {
     int ifindex;
 
-    switch (af_family) {
+    switch (af_family)
+    {
         case AF_INET:
         case AF_INET6:
             break;
+
         default:
             return -EINVAL;
     }
@@ -796,9 +814,11 @@ sitnl_route_set(int cmd, uint32_t flags, int ifindex, sa_family_t af_family,
         case AF_INET:
             size = sizeof(in_addr_t);
             break;
+
         case AF_INET6:
             size = sizeof(struct in6_addr);
             break;
+
         default:
             return -EINVAL;
     }
@@ -859,12 +879,14 @@ sitnl_addr_add(sa_family_t af_family, const char *iface,
 {
     int ifindex;
 
-    switch (af_family) {
+    switch (af_family)
+    {
         case AF_INET:
         case AF_INET6:
             break;
+
         default:
-            return -EINVAL;;
+            return -EINVAL;
     }
 
     if (!iface)
@@ -891,12 +913,14 @@ sitnl_addr_del(sa_family_t af_family, const char *iface, inet_address_t *addr,
 {
     int ifindex;
 
-    switch (af_family) {
+    switch (af_family)
+    {
         case AF_INET:
         case AF_INET6:
             break;
+
         default:
-            return -EINVAL;;
+            return -EINVAL;
     }
 
     if (!iface)
-- 
2.22.0


