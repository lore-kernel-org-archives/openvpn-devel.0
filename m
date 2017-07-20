From: Antonio Quartulli <a@...2181...>
Date: Thu, 20 Jul 2017 16:23:38 +0800
Message-Id: <20170720082338.1302-1-a@...2181...>
In-Reply-To: <20170720082220.31160-1-a@...2181...>
References: <20170720082220.31160-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH v4] route: improve error message
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
Cc: Antonio Quartulli <a@...2181...>

- fix typ0 in message: NLSMG -> NLMSG
- use strerror() to print a human readable message
- don't print error message if error is ENETUNREACH: it means no route
  found

Signed-off-by: Antonio Quartulli <a@...2181...>
---

v2:
- change %d to %s (thanks Michael Shiels for catching this)

v3:
- don't print error when ENETUNREACH is returned

v4:
- put { } around if block

 src/openvpn/route.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 349b2c76..5994cdca 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3445,7 +3445,14 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
         if (nh->nlmsg_type == NLMSG_ERROR)
         {
             struct nlmsgerr *ne = (struct nlmsgerr *)NLMSG_DATA(nh);
-            msg(M_WARN, "GDG6: NLSMG_ERROR: error %d\n", ne->error);
+
+            /* since linux-4.11 -ENETUNREACH is returned when no route can be
+             * found. Don't print any error message in this case */
+            if (ne->error != -ENETUNREACH)
+            {
+                msg(M_WARN, "GDG6: NLMSG_ERROR: error %s\n",
+                    strerror(-ne->error));
+            }
             break;
         }
 
-- 
2.13.3


