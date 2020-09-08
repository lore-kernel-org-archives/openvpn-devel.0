From: Vladislav Grishenko <themiron@...2010...>
Date: Tue,  8 Sep 2020 17:36:25 +0500
Message-Id: <20200908123625.23179-1-themiron@...2010...>
In-Reply-To: <011701d6858cyandex-team.ru>
References: <011701d6858cyandex-team.ru>
Subject: [Openvpn-devel] [PATCH v3] Fix best gateway selection over netlink
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

Netlink route request with NLM_F_DUMP flag set means to return
all entries matching criteria passed in message content -
matching supplied family & dst address in our case.
So, gateway from the first ipv4 route was always used.

On kernels earlier than 2.6.38 default routes are the last ones,
so arbitrary host/net route w/o gateway is likely be returned as
first, causing gateway to be invalid or empty.
After refactoring in 2.6.38 kernel default routes are on top, so
the problem with older kernels was hidden.

Fix this behavior by selecting first 0.0.0.0/0 if dst was not set
or empty. For IPv6, no behavior is changed - request ::/128 route,
so just clarify the sizes via netlink route api.

Tested on 5.4.0, 4.1.51, 2.6.36 and 2.6.22 kernels.

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 doc/man-sections/advanced-options.rst |  7 +++--
 src/openvpn/networking_sitnl.c        | 44 ++++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/doc/man-sections/advanced-options.rst b/doc/man-sections/advanced-options.rst
index 9b96e406..bedc8841 100644
--- a/doc/man-sections/advanced-options.rst
+++ b/doc/man-sections/advanced-options.rst
@@ -11,8 +11,11 @@ Standalone Debug Options
      --show-gateway
      --show-gateway IPv6-target
 
-  If an IPv6 target address is passed as argument, the IPv6 route for this
-  host is reported.
+  For IPv6 this queries the route towards ::/128, or the specified IPv6
+  target address if passed as argument.
+  For IPv4 on Linux, Windows, MacOS and BSD it looks for a 0.0.0.0/0 route.
+  If there are more specific routes, the result will not always be matching
+  the route of the IPv4 packets to the VPN gateway.
 
 
 Advanced Expert Options
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 713a213a..2bc70a50 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -345,6 +345,13 @@ sitnl_send(struct nlmsghdr *payload, pid_t peer, unsigned int groups,
  *               continue;
  *           }
  */
+
+            if (h->nlmsg_type == NLMSG_DONE)
+            {
+                ret = 0;
+                goto out;
+            }
+
             if (h->nlmsg_type == NLMSG_ERROR)
             {
                 err = (struct nlmsgerr *)NLMSG_DATA(h);
@@ -360,7 +367,11 @@ sitnl_send(struct nlmsghdr *payload, pid_t peer, unsigned int groups,
                         ret = 0;
                         if (cb)
                         {
-                            ret = cb(h, arg_cb);
+                            int r = cb(h, arg_cb);
+                            if (r <= 0)
+                            {
+                                ret = r;
+                            }
                         }
                     }
                     else
@@ -375,8 +386,12 @@ sitnl_send(struct nlmsghdr *payload, pid_t peer, unsigned int groups,
 
             if (cb)
             {
-                ret = cb(h, arg_cb);
-                goto out;
+                int r = cb(h, arg_cb);
+                if (r <= 0)
+                {
+                    ret = r;
+                    goto out;
+                }
             }
             else
             {
@@ -410,6 +425,7 @@ typedef struct {
     int addr_size;
     inet_address_t gw;
     char iface[IFNAMSIZ];
+    bool default_only;
 } route_res_t;
 
 static int
@@ -421,6 +437,12 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)
     int len = n->nlmsg_len - NLMSG_LENGTH(sizeof(*r));
     unsigned int ifindex = 0;
 
+    /* filter-out non-zero dst prefixes */
+    if (res->default_only && r->rtm_dst_len != 0)
+    {
+        return 1;
+    }
+
     while (RTA_OK(rta, len))
     {
         switch (rta->rta_type)
@@ -477,11 +499,25 @@ sitnl_route_best_gw(sa_family_t af_family, const inet_address_t *dst,
     {
         case AF_INET:
             res.addr_size = sizeof(in_addr_t);
-            req.n.nlmsg_flags |= NLM_F_DUMP;
+            /*
+             * kernel can't return 0.0.0.0/8 host route, dump all
+             * the routes and filter for 0.0.0.0/0 in cb()
+             */
+            if (!dst || !dst->ipv4)
+            {
+                req.n.nlmsg_flags |= NLM_F_DUMP;
+                res.default_only = true;
+            }
+            else
+            {
+                req.r.rtm_dst_len = 32;
+            }
             break;
 
         case AF_INET6:
             res.addr_size = sizeof(struct in6_addr);
+            /* kernel can return ::/128 host route */
+            req.r.rtm_dst_len = 128;
             break;
 
         default:
-- 
2.17.1


