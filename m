From: Antonio Quartulli <a@...2181...>
Date: Sat, 18 Apr 2020 11:43:50 +0200
Message-Id: <20200418094350.26349-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] sitnl: fix ignoring EEXIST when sending a
 netlink command
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

The logic is to treat EEXIST as non-error because it means that the
address/soute we wanted to install already exists, therefore we can
move on and not fail.

However, this logic is currently based on checking errno == EEXIST.
This is wrong, because sitnl_send() does not set errno, but returns the
error directly as negative value.

Fix this issue by directly comparing the the return value with -EEXIST.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/networking_sitnl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 7adcb64c..713a213a 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -717,7 +717,7 @@ sitnl_addr_set(int cmd, uint32_t flags, int ifindex, sa_family_t af_family,
     }
 
     ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
-    if ((ret < 0) && (errno == EEXIST))
+    if (ret == -EEXIST)
     {
         ret = 0;
     }
@@ -858,7 +858,7 @@ sitnl_route_set(int cmd, uint32_t flags, int ifindex, sa_family_t af_family,
     }
 
     ret = sitnl_send(&req.n, 0, 0, NULL, NULL);
-    if ((ret < 0) && (errno == EEXIST))
+    if (ret == -EEXIST)
     {
         ret = 0;
     }
-- 
2.26.1


