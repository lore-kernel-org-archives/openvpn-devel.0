From: Gert Doering <gert@...1296...>
Date: Fri, 11 Sep 2015 17:33:45 +0200
Message-Id: <1441985627-14822-9-git-send-email-gert@...1296...>
In-Reply-To: <1441985627-14822-1-git-send-email-gert@...1296...>
References: <1441985627-14822-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 08/10] get_default_gateway_ipv6(): *BSD /
	MacOS / Solaris PF_ROUTE implementation
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

As for IPv4, a common implementation for all (supported) BSD families
and Solaris.  Supporting the latter requires separate implementations
for IPv4 and IPv6, unfortunately, so it's quite a bit of duplicate
code.

Further, extend add_route_ipv6() and delete_route_ipv6() to handle
link-local gateway addresses that require "gateway + interface" in
scoped notation ("fe80::1%em0").

Tested on FreeBSD 7.4/amd64, 9.3/sparc64, 10.0/amd64, NetBSD 5.1/amd64,
OpenBSD 4.9/i386, MacOS X 10.5/32 and 10.10/64 and OpenSolaris 10.11/i386.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 187 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 183 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 555c3a6..29dd3fa 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1677,6 +1677,24 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
   network = print_in6_addr_netbits_only( r6->network, r6->netbits, &gc);
   gateway = print_in6_addr( r6->gateway, 0, &gc);
 
+#if defined(TARGET_DARWIN) || \
+	defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || \
+	defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
+
+  /* the BSD platforms cannot specify gateway and interface independently,
+   * but for link-local destinations, we MUST specify the interface, so
+   * we build a combined "$gateway%$interface" gateway string
+   */
+  if ( r6->iface != NULL && gateway_needed &&
+       IN6_IS_ADDR_LINKLOCAL(&r6->gateway) )		/* fe80::...%intf */
+    {
+      int len = strlen(gateway) + 1 + strlen(r6->iface)+1;
+      char * tmp = gc_malloc( len, true, &gc );
+      snprintf( tmp, len, "%s%%%s", gateway, r6->iface );
+      gateway = tmp;
+    }
+#endif
+
   if ( !tt->ipv6 )
     {
       msg( M_INFO, "add_route_ipv6(): not adding %s/%d, no IPv6 on if %s",
@@ -2059,6 +2077,24 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
   network = print_in6_addr_netbits_only( r6->network, r6->netbits, &gc);
   gateway = print_in6_addr( r6->gateway, 0, &gc);
 
+#if defined(TARGET_DARWIN) || \
+	defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || \
+	defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
+
+  /* the BSD platforms cannot specify gateway and interface independently,
+   * but for link-local destinations, we MUST specify the interface, so
+   * we build a combined "$gateway%$interface" gateway string
+   */
+  if ( r6->iface != NULL && gateway_needed &&
+       IN6_IS_ADDR_LINKLOCAL(&r6->gateway) )		/* fe80::...%intf */
+    {
+      int len = strlen(gateway) + 1 + strlen(r6->iface)+1;
+      char * tmp = gc_malloc( len, true, &gc );
+      snprintf( tmp, len, "%s%%%s", gateway, r6->iface );
+      gateway = tmp;
+    }
+#endif
+
   if ( !tt->ipv6 )
     {
       msg( M_INFO, "delete_route_ipv6(): not deleting %s/%d, no IPv6 on if %s",
@@ -2948,14 +2984,14 @@ struct rtmsg {
 #if defined(TARGET_SOLARIS)
 #define NEXTADDR(w, u) \
         if (rtm_addrs & (w)) {\
-            l = ROUNDUP(sizeof(struct sockaddr_in)); memmove(cp, &(u), l); cp += l;\
+            l = ROUNDUP(sizeof(u)); memmove(cp, &(u), l); cp += l;\
         }
 
 #define ADVANCE(x, n) (x += ROUNDUP(sizeof(struct sockaddr_in)))
 #else
 #define NEXTADDR(w, u) \
         if (rtm_addrs & (w)) {\
-            l = ROUNDUP(u.sa_len); memmove(cp, &(u), l); cp += l;\
+            l = ROUNDUP( ((struct sockaddr *)&(u))->sa_len); memmove(cp, &(u), l); cp += l;\
         }
 
 #define ADVANCE(x, n) (x += ROUNDUP((n)->sa_len))
@@ -3152,14 +3188,157 @@ get_default_gateway (struct route_gateway_info *rgi)
   gc_free (&gc);
 }
 
-/* BSD implementation using routing socket (as does IPv4) (TBD)
+/* BSD implementation using routing socket (as does IPv4)
+ * (the code duplication is somewhat unavoidable if we want this to
+ * work on OpenSolaris as well.  *sigh*)
  */
+
+/* Solaris has no length field - this is ugly, but less #ifdef in total
+ */
+#if defined(TARGET_SOLARIS)
+# undef ADVANCE
+# define ADVANCE(x, n) (x += ROUNDUP(sizeof(struct sockaddr_in6)))
+#endif
+
 void
 get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
 			 const struct in6_addr *dest)
 {
-    msg(D_ROUTE, "no support for get_default_gateway_ipv6() on this system (BSD and OSX)");
+
+    struct rtmsg m_rtmsg;
+    int sockfd = -1;
+    int seq, l, pid, rtm_addrs, i;
+    struct sockaddr_in6 so_dst, so_mask;
+    char *cp = m_rtmsg.m_space;
+    struct sockaddr *gate = NULL, *ifp = NULL, *sa;
+    struct rt_msghdr *rtm_aux;
+
     CLEAR(*rgi6);
+
+    /* setup data to send to routing socket */
+    pid = getpid();
+    seq = 0;
+    rtm_addrs = RTA_DST | RTA_NETMASK | RTA_IFP;
+
+    bzero(&m_rtmsg, sizeof(m_rtmsg));
+    bzero(&so_dst, sizeof(so_dst));
+    bzero(&so_mask, sizeof(so_mask));
+    bzero(&rtm, sizeof(struct rt_msghdr));
+
+    rtm.rtm_type = RTM_GET;
+    rtm.rtm_flags = RTF_UP;
+    rtm.rtm_version = RTM_VERSION;
+    rtm.rtm_seq = ++seq;
+
+    so_dst.sin6_family = AF_INET6;
+    so_mask.sin6_family = AF_INET6;
+
+    if ( dest != NULL &&		/* specific host? */
+	 !IN6_IS_ADDR_UNSPECIFIED(dest) )
+    {
+	so_dst.sin6_addr = *dest;
+	/* :: needs /0 "netmask", host route wants "no netmask */
+	rtm_addrs &= ~RTA_NETMASK;
+    }
+
+    rtm.rtm_addrs = rtm_addrs;
+
+#ifndef TARGET_SOLARIS
+    so_dst.sin6_len = sizeof(struct sockaddr_in6);
+    so_mask.sin6_len = sizeof(struct sockaddr_in6);
+#endif
+
+    NEXTADDR(RTA_DST, so_dst);
+    NEXTADDR(RTA_NETMASK, so_mask);
+
+    rtm.rtm_msglen = l = cp - (char *)&m_rtmsg;
+
+    /* transact with routing socket */
+    sockfd = socket(PF_ROUTE, SOCK_RAW, 0);
+    if (sockfd < 0)
+    {
+	msg (M_WARN, "GDG6: socket #1 failed");
+	goto done;
+    }
+    if (write(sockfd, (char *)&m_rtmsg, l) < 0)
+    {
+	msg (M_WARN, "GDG6: problem writing to routing socket");
+	goto done;
+    }
+
+    do
+    {
+	l = read(sockfd, (char *)&m_rtmsg, sizeof(m_rtmsg));
+    }
+    while (l > 0 && (rtm.rtm_seq != seq || rtm.rtm_pid != pid));
+
+    close(sockfd);
+    sockfd = -1;
+
+    /* extract return data from routing socket */
+    rtm_aux = &rtm;
+    cp = ((char *)(rtm_aux + 1));
+    if (rtm_aux->rtm_addrs)
+    {
+	for (i = 1; i; i <<= 1)
+	{
+	    if (i & rtm_aux->rtm_addrs)
+	    {
+		sa = (struct sockaddr *)cp;
+		if (i == RTA_GATEWAY )
+		    gate = sa;
+		else if (i == RTA_IFP)
+		    ifp = sa;
+		ADVANCE(cp, sa);
+	    }
+	}
+    }
+    else
+      goto done;
+
+    /* get gateway addr and interface name */
+    if (gate != NULL )
+    {
+	struct sockaddr_in6 * s6 = (struct sockaddr_in6 *)gate;
+	struct in6_addr gw = s6->sin6_addr;
+
+#ifndef TARGET_SOLARIS
+	/* You do not really want to know... from FreeBSD's route.c
+	 * (KAME encodes the 16 bit scope_id in s6_addr[2] + [3],
+         * but for a correct link-local address these must be :0000: )
+	 */
+	if ( gate->sa_len == sizeof(struct sockaddr_in6) &&
+	     IN6_IS_ADDR_LINKLOCAL(&gw) )
+        {
+	    gw.s6_addr[2] = gw.s6_addr[3] = 0;
+	}
+
+	if ( gate->sa_len != sizeof(struct sockaddr_in6) ||
+	     IN6_IS_ADDR_UNSPECIFIED(&gw) )
+	{
+	    rgi6->flags |= RGI_ON_LINK;
+	}
+	else
+#endif
+
+	rgi6->gateway.addr_ipv6 = gw;
+	rgi6->flags |= RGI_ADDR_DEFINED;
+
+	if (ifp)
+	{
+	    /* get interface name */
+	    const struct sockaddr_dl *adl = (struct sockaddr_dl *) ifp;
+	    if (adl->sdl_nlen && adl->sdl_nlen < sizeof(rgi6->iface))
+	    {
+		memcpy (rgi6->iface, adl->sdl_data, adl->sdl_nlen);
+		rgi6->flags |= RGI_IFACE_DEFINED;
+	    }
+	}
+    }
+
+  done:
+    if (sockfd >= 0)
+	close(sockfd);
 }
 
 #undef max
-- 
2.3.6


