From: Vladislav Grishenko <themiron@...2010...>
Date: Fri, 16 Apr 2021 17:07:08 +0500
Message-Id: <20210416120708.1532-2-themiron@...2010...>
In-Reply-To: <20210416120708.1532-1-themiron@...2010...>
References: <20210415230545.22317-1-themiron@...2010...>
 <20210416120708.1532-1-themiron@...2010...>
Subject: [Openvpn-devel] [PATCH v3 2/2] Add basic support for multipath
 gateway
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

Load balancing setup over multiple upstreams may include multipath
gateway route, which is not not supported by OpenVPN.
Let's add basic support for that for selecting best route for zero
destination address - use any one of nexthop addresses as a gateway,
weights are not handled.

Setup example:

    ip route add default \
        nexthop via 192.168.1.1 dev eth1 weight 1 \
        nexthop via 192.168.2.1 dev eth2 weight 1

v2: keep gateway address unchanged on lookup error
v3: reduce ammout of gateway address copying

Reported-by: Donald Sharp <donaldsharp72@...277...>
Signed-off-by: Vladislav Grishenko <themiron@...2010...>
---
 src/openvpn/networking_sitnl.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index ea1621ed..aa35f5f5 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -450,6 +450,9 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)
 
     while (RTA_OK(rta, len))
     {
+        struct rtnexthop *nh;
+        int nhlen;
+
         switch (rta->rta_type)
         {
             /* route interface */
@@ -470,6 +473,37 @@ sitnl_route_save(struct nlmsghdr *n, void *arg)
             case RTA_TABLE:
                 table = *(unsigned int *)RTA_DATA(rta);
                 break;
+
+            /* multipath nexthops */
+            case RTA_MULTIPATH:
+                nh = RTA_DATA(rta);
+                nhlen = RTA_PAYLOAD(rta);
+
+                while (RTNH_OK(nh, nhlen))
+                {
+                    struct rtattr *nha = RTNH_DATA(nh);
+                    int nhalen = nh->rtnh_len - sizeof(*nh);
+
+                    /* init route interface & gateway */
+                    ifindex = nh->rtnh_ifindex;
+                    gw = NULL;
+
+                    while (RTA_OK(nha, nhalen))
+                    {
+                        switch (nha->rta_type)
+                        {
+                            /* GW for the route */
+                            case RTA_GATEWAY:
+                                gw = RTA_DATA(nha);
+                                break;
+                        }
+
+                        nha = RTA_NEXT(nha, nhalen);
+                    }
+
+                    nh = RTNH_NEXT(nh);
+                }
+                break;
         }
 
         rta = RTA_NEXT(rta, len);
-- 
2.17.1


