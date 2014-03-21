From: Arne Schwabe <arne@...1227...>
Date: Fri, 21 Mar 2014 14:18:41 +0100
Message-Id: <1395407925-25518-9-git-send-email-arne@...1227...>
In-Reply-To: <1395407925-25518-1-git-send-email-arne@...1227...>
References: <1395407925-25518-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 08/12] Add gateway and device to android
	control messages
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

---
 src/openvpn/route.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 1dd14fb..13eed5f 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1311,9 +1311,12 @@ add_route (struct route_ipv4 *r,
   status = openvpn_execve_check (&argv, es, 0, "ERROR: Linux route add command failed");
 
 #elif defined (TARGET_ANDROID)
-  struct buffer out = alloc_buf_gc (64, &gc);
+  struct buffer out = alloc_buf_gc (128, &gc);
 
-  buf_printf (&out, "%s %s", network, netmask);
+  if (rgi)
+    buf_printf (&out, "%s %s %s dev %s", network, netmask, gateway, rgi->iface);
+  else
+    buf_printf (&out, "%s %s %s", network, netmask, gateway);
   management_android_control (management, "ROUTE", buf_bptr(&out));
 
 #elif defined (WIN32)
@@ -1593,7 +1596,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 #elif defined (TARGET_ANDROID)
     struct buffer out = alloc_buf_gc (64, &gc);
 
-    buf_printf (&out, "%s/%d", network, r6->netbits);
+    buf_printf (&out, "%s/%d %s", network, r6->netbits, device);
 
     management_android_control (management, "ROUTE6", buf_bptr(&out));
 
-- 
1.8.5.2 (Apple Git-48)


