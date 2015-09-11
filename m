From: Gert Doering <gert@...1296...>
Date: Fri, 11 Sep 2015 17:33:42 +0200
Message-Id: <1441985627-14822-6-git-send-email-gert@...1296...>
In-Reply-To: <1441985627-14822-1-git-send-email-gert@...1296...>
References: <1441985627-14822-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 05/10] get_default_gateway_ipv6(): Linux /
	Netlink implementation.
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

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 147 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 135 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index fd8209d..cca5cfe 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -45,6 +45,10 @@
 
 #include "memdbg.h"
 
+#if defined(TARGET_LINUX) || defined(TARGET_ANDROID)
+#include <linux/rtnetlink.h>		/* RTM_GETROUTE etc. */
+#endif
+
 #ifdef WIN32
 #define METRIC_NOT_USED ((DWORD)-1)
 #endif
@@ -1115,10 +1119,9 @@ print_default_gateway(const int msglevel,
     {
       struct buffer out = alloc_buf_gc (256, &gc);
       buf_printf (&out, "ROUTE6_GATEWAY");
+      buf_printf (&out, " %s", print_in6_addr (rgi6->gateway.addr_ipv6, 0, &gc));
       if (rgi6->flags & RGI_ON_LINK)
 	buf_printf (&out, " ON_LINK");
-      else
-	buf_printf (&out, " %s", print_in6_addr (rgi6->gateway.addr_ipv6, 0, &gc));
       if (rgi6->flags & RGI_NETMASK_DEFINED)
 	buf_printf (&out, "/%d", rgi6->gateway.netbits_ipv6);
 #ifdef WIN32
@@ -2659,22 +2662,142 @@ get_default_gateway (struct route_gateway_info *rgi)
   gc_free (&gc);
 }
 
-/* IPv6 implementation using netlink (TBD)
+/* IPv6 implementation using netlink
+ * http://www.linuxjournal.com/article/7356
+ * netlink(3), netlink(7), rtnetlink(7)
+ * http://www.virtualbox.org/svn/vbox/trunk/src/VBox/NetworkServices/NAT/rtmon_linux.c
  */
+struct rtreq {
+	struct nlmsghdr nh;
+	struct rtmsg rtm;
+	char attrbuf[512];
+};
+
 void
 get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
 			 struct in6_addr *dest)
 {
-    msg(D_ROUTE, "no support for get_default_gateway_ipv6() on this system (Linux and Android)");
+    int nls = -1;
+    struct rtreq rtreq;
+    struct rtattr *rta;
+
+    char rtbuf[2000];
+    ssize_t ssize;
+
     CLEAR(*rgi6);
-    struct in6_addr g = IN6ADDR_LOOPBACK_INIT;
-
-    rgi6->flags = RGI_ADDR_DEFINED | RGI_IFACE_DEFINED | RGI_HWADDR_DEFINED | 
-    		RGI_NETMASK_DEFINED;
-    rgi6->gateway.addr_ipv6 = g;
-    rgi6->gateway.netbits_ipv6 = 64;
-    memcpy( rgi6->hwaddr, "\1\2\3\4\5\6", 6 );
-    strcpy( rgi6->iface, "eth1" );
+
+    nls = socket( PF_NETLINK, SOCK_RAW, NETLINK_ROUTE );
+    if ( nls < 0 )
+	{ msg(M_WARN|M_ERRNO, "GDG6: socket() failed" ); goto done; }
+
+    /* bind() is not needed, no unsolicited msgs coming in */
+
+    /* this will give us the best match only, not a full dump */
+    CLEAR(rtreq);
+    rtreq.nh.nlmsg_type = RTM_GETROUTE;
+    rtreq.nh.nlmsg_flags = NLM_F_REQUEST;			/* XXX */
+    rtreq.rtm.rtm_family = AF_INET6;
+    rtreq.rtm.rtm_src_len = 0;
+    rtreq.rtm.rtm_dst_len = 128;				/* exact dst */
+    rtreq.rtm.rtm_table = RT_TABLE_MAIN;
+    rtreq.rtm.rtm_protocol = RTPROT_UNSPEC;
+    rtreq.nh.nlmsg_len = NLMSG_SPACE(sizeof(rtreq.rtm));
+
+    /* set RTA_DST for target IPv6 address we want */
+    rta = (struct rtattr *)(((char *) &rtreq)+NLMSG_ALIGN(rtreq.nh.nlmsg_len));
+    rta->rta_type = RTA_DST;
+    rta->rta_len = RTA_LENGTH(16);
+    rtreq.nh.nlmsg_len = NLMSG_ALIGN(rtreq.nh.nlmsg_len) +
+                                             RTA_LENGTH(16);
+
+    if ( dest == NULL )			/* ::, unspecified */
+	memset( RTA_DATA(rta), 0, 16 );	/* :: = all-zero */
+    else
+	memcpy( RTA_DATA(rta), (void *)dest, 16 );
+
+    /* send and receive reply */
+    if ( send( nls, &rtreq, rtreq.nh.nlmsg_len, 0 ) < 0 )
+	{ msg(M_WARN|M_ERRNO, "GDG6: send() failed" ); goto done; }
+
+    ssize = recv(nls, rtbuf, sizeof(rtbuf), MSG_TRUNC);
+
+    if (ssize < 0)
+	{ msg(M_WARN|M_ERRNO, "GDG6: recv() failed" ); goto done; }
+
+    if (ssize > sizeof(rtbuf))
+    {
+	msg(M_WARN, "get_default_gateway_ipv6: returned message too big for buffer (%d>%d)", (int)ssize, (int)sizeof(rtbuf) );
+	goto done;
+    }
+
+    struct nlmsghdr *nh;
+
+    for (nh = (struct nlmsghdr *)rtbuf;
+         NLMSG_OK(nh, ssize);
+         nh = NLMSG_NEXT(nh, ssize))
+    {
+	struct rtmsg *rtm;
+	int attrlen;
+
+	if (nh->nlmsg_type == NLMSG_DONE) { break; }
+
+	if (nh->nlmsg_type == NLMSG_ERROR) {
+	    struct nlmsgerr *ne = (struct nlmsgerr *)NLMSG_DATA(nh);
+	    msg(M_WARN, "GDG6: NLSMG_ERROR: error %d\n", ne->error);
+	    break;
+	}
+
+	if (nh->nlmsg_type != RTM_NEWROUTE) {
+	    /* shouldn't happen */
+	    msg(M_WARN, "GDG6: unexpected msg_type %d", nh->nlmsg_type );
+	    continue;
+	}
+
+	rtm = (struct rtmsg *)NLMSG_DATA(nh);
+	attrlen = RTM_PAYLOAD(nh);
+
+	/* we're only looking for routes in the main table, as "we have
+	 * no IPv6" will lead to a lookup result in "Local" (::/0 reject)
+	 */
+	if (rtm->rtm_family != AF_INET6 ||
+	    rtm->rtm_table != RT_TABLE_MAIN)
+		{ continue; }		/* we're not interested */
+
+	for (rta = RTM_RTA(rtm);
+	     RTA_OK(rta, attrlen);
+	     rta = RTA_NEXT(rta, attrlen))
+	{
+	    if (rta->rta_type == RTA_GATEWAY) {
+		if ( RTA_PAYLOAD(rta) != sizeof(struct in6_addr) )
+			{ msg(M_WARN, "GDG6: RTA_GW size mismatch"); continue; }
+		rgi6->gateway.addr_ipv6 = *(struct in6_addr*) RTA_DATA(rta);
+		rgi6->flags |= RGI_ADDR_DEFINED;
+	    }
+	    else if (rta->rta_type == RTA_OIF) {
+		char ifname[IF_NAMESIZE+1];
+		int oif;
+		if ( RTA_PAYLOAD(rta) != sizeof(oif) )
+			{ msg(M_WARN, "GDG6: oif size mismatch"); continue; }
+
+		memcpy(&oif, RTA_DATA(rta), sizeof(oif));
+		if_indextoname(oif,ifname);
+		strncpy( rgi6->iface, ifname, sizeof(rgi6->iface)-1 );
+		rgi6->flags |= RGI_IFACE_DEFINED;
+	    }
+	}
+    }
+
+    /* if we have an interface but no gateway, the destination is on-link */
+    if ( ( rgi6->flags & (RGI_IFACE_DEFINED|RGI_ADDR_DEFINED) ) ==
+              RGI_IFACE_DEFINED )
+    {
+	rgi6->flags |= (RGI_ADDR_DEFINED | RGI_ON_LINK);
+	rgi6->gateway.addr_ipv6 = *dest;
+    }
+
+  done:
+    if (nls >= 0)
+	close (nls);
 }
 
 #elif defined(TARGET_DARWIN) || defined(TARGET_SOLARIS) || \
-- 
2.3.6


