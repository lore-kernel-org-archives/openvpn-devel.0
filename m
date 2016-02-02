Date: Tue, 2 Feb 2016 14:11:22 -0500
From: Michael McConville <mmcco@...2118...>
Message-ID: <20160202191122.GE1675@...2119...>
Subject: [Openvpn-devel] [PATCH] Fix undefined signed shift overflow
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Originally discussed here:

https://github.com/OpenVPN/openvpn/pull/42

Thanks for your time,
Michael


diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 2012b5c..f4dee78 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3128,7 +3128,8 @@ get_default_gateway (struct route_gateway_info *rgi)
   struct gc_arena gc = gc_new ();
   struct rtmsg m_rtmsg;
   int sockfd = -1;
-  int seq, l, pid, rtm_addrs, i;
+  int seq, l, pid, rtm_addrs;
+  unsigned int i;
   struct sockaddr so_dst, so_mask;
   char *cp = m_rtmsg.m_space; 
   struct sockaddr *gate = NULL, *ifp = NULL, *sa;
@@ -3330,7 +3331,8 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
 
     struct rtmsg m_rtmsg;
     int sockfd = -1;
-    int seq, l, pid, rtm_addrs, i;
+    int seq, l, pid, rtm_addrs;
+    unsigned int i;
     struct sockaddr_in6 so_dst, so_mask;
     char *cp = m_rtmsg.m_space;
     struct sockaddr *gate = NULL, *ifp = NULL, *sa;

