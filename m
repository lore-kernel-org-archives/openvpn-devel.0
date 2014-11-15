From: Heiko Hund <heiko.hund@...1489...>
Date: Sat, 15 Nov 2014 17:25:08 +0100
Message-Id: <1416068708-6871-2-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1416068708-6871-1-git-send-email-heiko.hund@...1489...>
References: <1416068708-6871-1-git-send-email-heiko.hund@...1489...>
Subject: [Openvpn-devel] [PATCH 2/2] fix warnings on Windows
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

Just add a few valid casts that shut up mingw gcc.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/mtu.c    | 5 ++---
 src/openvpn/route.c  | 2 +-
 src/openvpn/socket.c | 4 ++--
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 13f3f6c..3665a34 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -158,8 +158,7 @@ set_mtu_discover_type (int sd, int mtu_type)
   if (mtu_type >= 0)
     {
 #if defined(HAVE_SETSOCKOPT) && defined(SOL_IP) && defined(IP_MTU_DISCOVER)
-      if (setsockopt
-	  (sd, SOL_IP, IP_MTU_DISCOVER, &mtu_type, sizeof (mtu_type)))
+      if (setsockopt (sd, SOL_IP, IP_MTU_DISCOVER, (void *) &mtu_type, sizeof (mtu_type)))
 	msg (M_ERR, "Error setting IP_MTU_DISCOVER type=%d on TCP/UDP socket",
 	     mtu_type);
 #else
@@ -288,7 +287,7 @@ void
 set_sock_extended_error_passing (int sd)
 {
   int on = 1;
-  if (setsockopt (sd, SOL_IP, IP_RECVERR, &on, sizeof (on)))
+  if (setsockopt (sd, SOL_IP, IP_RECVERR, (void *) &on, sizeof (on)))
     msg (M_WARN | M_ERRNO,
 	 "Note: enable extended error passing on TCP/UDP socket failed (IP_RECVERR)");
 }
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index e76c2bd..5d18213 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -277,7 +277,7 @@ init_route (struct route_ipv4 *r,
   /* get_special_addr replaces specialaddr with a special ip addr
      like gw. getaddrinfo is called to convert a a addrinfo struct */
 
-  if(get_special_addr (rl, ro->network, &special.s_addr, &status))
+  if(get_special_addr (rl, ro->network, (in_addr_t *) &special.s_addr, &status))
     {
       special.s_addr = htonl(special.s_addr);
       ret = openvpn_getaddrinfo(0, inet_ntoa(special), NULL, 0, NULL,
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 9ed8a5a..2499ab0 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -729,7 +729,7 @@ static inline void
 socket_set_mark (int sd, int mark)
 {
 #if defined(TARGET_LINUX) && HAVE_DECL_SO_MARK
-  if (mark && setsockopt (sd, SOL_SOCKET, SO_MARK, &mark, sizeof (mark)) != 0)
+  if (mark && setsockopt (sd, SOL_SOCKET, SO_MARK, (void *) &mark, sizeof (mark)) != 0)
     msg (M_WARN, "NOTE: setsockopt SO_MARK=%d failed", mark);
 #endif
 }
@@ -1117,7 +1117,7 @@ socket_bind (socket_descriptor_t sd,
       int v6only = ipv6only ? 1: 0;	/* setsockopt must have an "int" */
 
       msg (M_INFO, "setsockopt(IPV6_V6ONLY=%d)", v6only);
-      if (setsockopt(sd, IPPROTO_IPV6, IPV6_V6ONLY, &v6only, sizeof(v6only)))
+      if (setsockopt (sd, IPPROTO_IPV6, IPV6_V6ONLY, (void *) &v6only, sizeof(v6only)))
 	{
 	  msg (M_NONFATAL|M_ERRNO, "Setting IPV6_V6ONLY=%d failed", v6only);
 	}
-- 
1.9.1


