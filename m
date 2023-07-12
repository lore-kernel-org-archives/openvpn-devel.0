From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 Jul 2023 11:46:20 +0200
Message-Id: <20230712094620.569273-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Ignore Ipv6 route delete request on Android
 and set ipv4 verbosity to 7
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

Android has no facility nor need one to delete routes as routes are
automatically cleaned up when the tun interface is closed. Also adjust
the IPv4 message to be only shown and verb 7 and rephrase the message.

Change-Id: If8f920d378c31e9ea773ce1f56f3df50f1ec36cd
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/route.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 0b369da44..6028de9c2 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2302,8 +2302,9 @@ delete_route(struct route_ipv4 *r,
     openvpn_execve_check(&argv, es, 0, "ERROR: OpenBSD/NetBSD route delete command failed");
 
 #elif defined(TARGET_ANDROID)
-    msg(M_NONFATAL, "Sorry, deleting routes on Android is not possible. The VpnService API allows routes to be set on connect only.");
-
+    msg(D_ROUTE_DEBUG, "Deleting routes on Android is not possible/not "
+                       "needed. The VpnService API allows routes to be set "
+                       "on connect only and will clean up automatically.");
 #elif defined(TARGET_AIX)
 
     {
@@ -2490,7 +2491,10 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
                 network, r6->netbits, gateway);
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: AIX route add command failed");
-
+#elif defined(TARGET_ANDROID)
+    msg(D_ROUTE_DEBUG, "Deleting routes on Android is not possible/not "
+                       "needed. The VpnService API allows routes to be set "
+                       "on connect only and will clean up automatically.");
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'route ipv6' commands on this operating system.  Try putting your routes in a --route-down script");
 #endif /* if defined(TARGET_LINUX) */
-- 
2.39.2 (Apple Git-143)


