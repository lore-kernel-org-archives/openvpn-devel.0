From: Vladislav Grishenko <themiron@...2010...>
Date: Tue,  8 Sep 2020 07:53:30 +0500
Message-Id: <20200908025330.17364-1-themiron@...2010...>
In-Reply-To: <20200907151139.GA75094@...1296...>
References: <20200907151139.GA75094@...1296...>
Subject: [Openvpn-devel] [PATCH v2] Fix best gateway selection over netlink
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
so some host/net route w/o gateway is likely be returned as first,
causing gateway to be invalid or empty.
After refactoring in 2.6.38 kernel first routes are the default
(or more specific 0.0.0.0/n), so it's gateway is usually valid,
hiding the problem.

Fix this behavior by requesting exact route with corresponding
full prefix size, and filter dumped routes against default
route /0 if dst was not set. Empty dst is not valid address,
so it's handled as default route request too.

If there's several default routes dumped with different
metrics, the first one will be less-numbered, so we can stop
w/o additional iteration for metric comparison.

Tested on 5.4.0, 4.1.51 and 2.6.36 kernels.

Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 src/openvpn/networking_sitnl.c | 47 +++++++++++++++++++++++++++++-----
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 713a213a..81d52710 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -90,7 +90,7 @@ struct sitnl_route_req {
     char buf[256];
 };
 
-typedef int (*sitnl_parse_reply_cb)(struct nlmsghdr *msg, void *arg);
+typedef int (*sitnl_parse_reply_cb)(struct nlmsghdr *req, struct nlmsghdr *msg, void *arg);
 
 /**
  * Object returned by route request operation
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
+                            int r = cb(payload, h, arg_cb);
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
+                int r = cb(payload, h, arg_cb);
+                if (r <= 0)
+                {
+                    ret = r;
+                    goto out;
+                }
             }
             else
             {
@@ -413,14 +428,21 @@ typedef struct {
 } route_res_t;
 
 static int
-sitnl_route_save(struct nlmsghdr *n, void *arg)
+sitnl_route_save(struct nlmsghdr *req, struct nlmsghdr *n, void *arg)
 {
     route_res_t *res = arg;
+    struct rtmsg *q = NLMSG_DATA(req);
     struct rtmsg *r = NLMSG_DATA(n);
     struct rtattr *rta = RTM_RTA(r);
     int len = n->nlmsg_len - NLMSG_LENGTH(sizeof(*r));
     unsigned int ifindex = 0;
 
+    /* if dumped, filter out non-default routes */
+    if (q->rtm_dst_len == 0 && r->rtm_dst_len)
+    {
+        return 1;
+    }
+
     while (RTA_OK(rta, len))
     {
         switch (rta->rta_type)
@@ -477,11 +499,24 @@ sitnl_route_best_gw(sa_family_t af_family, const inet_address_t *dst,
     {
         case AF_INET:
             res.addr_size = sizeof(in_addr_t);
-            req.n.nlmsg_flags |= NLM_F_DUMP;
+            /*
+             * kernel can't return 0.0.0.0/32 host route, therefore
+             * need to dump all the routes and filter them in cb()
+             */
+            if (!dst || dst->ipv4 == htonl(INADDR_ANY))
+            {
+                req.n.nlmsg_flags |= NLM_F_DUMP;
+            }
+            else
+            {
+                req.r.rtm_dst_len = 32;
+            }
             break;
 
         case AF_INET6:
             res.addr_size = sizeof(struct in6_addr);
+            /* kernel cat return 0.0.0.0/128 host route */
+            req.r.rtm_dst_len = 128;
             break;
 
         default:
-- 
2.17.1


