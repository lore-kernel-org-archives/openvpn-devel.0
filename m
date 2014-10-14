From: alp@...1937...
Date: Tue, 14 Oct 2014 23:43:21 +0400
Message-Id: <1413315802-62359-4-git-send-email-alp@...1937...>
In-Reply-To: <1413315802-62359-1-git-send-email-alp@...1937...>
References: <20141014151709.GT396@...1296...>
	<1413315802-62359-1-git-send-email-alp@...1937...>
Subject: [Openvpn-devel] [PATCH] Default gateway can't be determined on
	illumos/Solaris platforms
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
Cc: Alexander Pyhalov <apyhalov@...277...>

From: Alexander Pyhalov <apyhalov@...277...>

The logic which is used on BSD is preserved. The only distinction
is that illumos doesn't provide sa_len field in sockaddr structures.
---
 src/openvpn/route.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index cc85e4d..c7e9ddd 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2601,7 +2601,7 @@ get_default_gateway (struct route_gateway_info *rgi)
   gc_free (&gc);
 }
 
-#elif defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)
+#elif defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)||defined(TARGET_SOLARIS)
 
 #include <sys/types.h>
 #include <sys/socket.h>
@@ -2629,6 +2629,8 @@ get_default_gateway (struct route_gateway_info *rgi)
   struct sockaddr *gate = NULL, *sa;
   struct  rt_msghdr *rtm_aux;
 
+#if defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)
+
 #define NEXTADDR(w, u) \
         if (rtm_addrs & (w)) {\
             l = ROUNDUP(u.sa_len); memmove(cp, &(u), l); cp += l;\
@@ -2636,6 +2638,18 @@ get_default_gateway (struct route_gateway_info *rgi)
 
 #define ADVANCE(x, n) (x += ROUNDUP((n)->sa_len))
 
+#else /* TARGET_SOLARIS */
+
+#define NEXTADDR(w, u) \
+        if (rtm_addrs & (w)) {\
+            l = ROUNDUP(sizeof(struct sockaddr_in)); memmove(cp, &(u), l); cp += l;\
+        }
+
+#define ADVANCE(x, n) (x += ROUNDUP(sizeof(struct sockaddr_in)))
+
+#endif
+
+
 #define rtm m_rtmsg.m_rtm
 
   CLEAR(*rgi);
@@ -2655,9 +2669,12 @@ get_default_gateway (struct route_gateway_info *rgi)
   rtm.rtm_addrs = rtm_addrs; 
 
   so_dst.sa_family = AF_INET;
-  so_dst.sa_len = sizeof(struct sockaddr_in);
   so_mask.sa_family = AF_INET;
+
+#if defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)
+  so_dst.sa_len = sizeof(struct sockaddr_in);
   so_mask.sa_len = sizeof(struct sockaddr_in);
+#endif
 
   NEXTADDR(RTA_DST, so_dst);
   NEXTADDR(RTA_NETMASK, so_mask);
-- 
1.7.9.2


