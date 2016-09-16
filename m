From: Gert Doering <gert@...1296...>
Date: Fri, 16 Sep 2016 21:02:42 +0200
Message-Id: <20160916190242.44897-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix IP_PKTINFO related compilation failure
	on NetBSD 7.0
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

NetBSD has introduced IP_PKTINFO and struct in_pktinfo, but does not
have the "ipi_spec_dst" structure element, causing compilation errors.

Introduce a check for that (AC_CHECK_MEMBER) in configure.ac, and
change all "#ifdef HAVE_IN_PKTINFO" to also check "HAVE_IPI_SPEC_DST".

Patch inspired by NetBSD pkgsrc patch set.

(Note: with that patch, OpenVPN --multihome is still broken for IPv4
on NetBSD 7.0.1 / amd64, but that's a different issue)

Signed-off-by: Gert Doering <gert@...1296...>
---
 configure.ac         |  9 +++++++++
 src/openvpn/init.c   |  2 +-
 src/openvpn/socket.c | 12 ++++++------
 src/openvpn/socket.h |  4 ++--
 4 files changed, 18 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9189c94..144d15d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -455,6 +455,9 @@ SOCKET_INCLUDES="
 #ifdef HAVE_SYS_SOCKET_H
 #include <sys/socket.h>
 #endif
+#ifdef HAVE_NET_IF_H
+#include <net/if.h>
+#endif
 #ifdef HAVE_NETINET_IN_H
 #include <netinet/in.h>
 #endif
@@ -524,6 +527,12 @@ AC_CHECK_TYPE(
         ,
         [[${SOCKET_INCLUDES}]]
 )
+AC_CHECK_MEMBER(
+	[struct in_pktinfo.ipi_spec_dst],
+	[AC_DEFINE([HAVE_IPI_SPEC_DST], [1], [struct in_pktinfo.ipi_spec_dst needed for IP_PKTINFO support])],
+	,
+	[[${SOCKET_INCLUDES}]]
+)
 AC_CHECK_TYPE(
 	[struct sockaddr_in6],
 	,
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c4d904d..45ce025 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1299,7 +1299,7 @@ initialization_sequence_completed (struct context *c, const unsigned int flags)
           switch (local.addr.sa.sa_family)
             {
             case AF_INET:
-#ifdef IP_PKTINFO
+#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
               local.addr.in4.sin_addr = actual->pi.in4.ipi_spec_dst;
 #else
               local.addr.in4.sin_addr = actual->pi.in4;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 0ea4a3d..e096132 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -790,7 +790,7 @@ create_socket_udp (struct addrinfo* addrinfo, const unsigned int flags)
       int pad = 1;
       if(addrinfo->ai_family == AF_INET)
         {
-#ifdef IP_PKTINFO
+#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
           if (setsockopt (sd, SOL_IP, IP_PKTINFO,
                           (void*)&pad, sizeof(pad)) < 0)
             msg(M_ERR, "UDP: failed setsockopt for IP_PKTINFO");
@@ -2465,7 +2465,7 @@ print_link_socket_actual_ex (const struct link_socket_actual *act,
 		  struct openvpn_sockaddr sa;
 		  CLEAR (sa);
 		  sa.addr.in4.sin_family = AF_INET;
-#ifdef IP_PKTINFO
+#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
 		  sa.addr.in4.sin_addr = act->pi.in4.ipi_spec_dst;
 		  if_indextoname(act->pi.in4.ipi_ifindex, ifname);
 #elif defined(IP_RECVDSTADDR)
@@ -2867,7 +2867,7 @@ link_socket_read_tcp (struct link_socket *sock,
 struct openvpn_in4_pktinfo
 {
   struct cmsghdr cmsghdr;
-#ifdef HAVE_IN_PKTINFO
+#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
   struct in_pktinfo pi4;
 #elif defined(IP_RECVDSTADDR)
   struct in_addr pi4;
@@ -2911,7 +2911,7 @@ link_socket_read_udp_posix_recvmsg (struct link_socket *sock,
       cmsg = CMSG_FIRSTHDR (&mesg);
       if (cmsg != NULL
 	  && CMSG_NXTHDR (&mesg, cmsg) == NULL
-#ifdef IP_PKTINFO
+#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
 	  && cmsg->cmsg_level == SOL_IP 
 	  && cmsg->cmsg_type == IP_PKTINFO
 #elif defined(IP_RECVDSTADDR)
@@ -2922,7 +2922,7 @@ link_socket_read_udp_posix_recvmsg (struct link_socket *sock,
 #endif
 	  && cmsg->cmsg_len >= sizeof (struct openvpn_in4_pktinfo))
 	{
-#ifdef IP_PKTINFO
+#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
 	  struct in_pktinfo *pkti = (struct in_pktinfo *) CMSG_DATA (cmsg);
 	  from->pi.in4.ipi_ifindex = pkti->ipi_ifindex;
 	  from->pi.in4.ipi_spec_dst = pkti->ipi_spec_dst;
@@ -3021,7 +3021,7 @@ link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
         mesg.msg_namelen = sizeof (struct sockaddr_in);
         mesg.msg_control = &opi;
         mesg.msg_flags = 0;
-#ifdef HAVE_IN_PKTINFO
+#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
         mesg.msg_controllen = sizeof (struct openvpn_in4_pktinfo);
         cmsg = CMSG_FIRSTHDR (&mesg);
         cmsg->cmsg_len = sizeof (struct openvpn_in4_pktinfo);
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 66824c7..e1607f4 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -90,7 +90,7 @@ struct link_socket_actual
   struct openvpn_sockaddr dest;
 #if ENABLE_IP_PKTINFO
   union {
-#ifdef HAVE_IN_PKTINFO
+#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
     struct in_pktinfo in4;
 #elif defined(IP_RECVDSTADDR)
     struct in_addr in4;
@@ -626,7 +626,7 @@ addr_defined_ipi (const struct link_socket_actual *lsa)
 #if ENABLE_IP_PKTINFO
   if (!lsa) return 0;
   switch (lsa->dest.addr.sa.sa_family) {
-#ifdef HAVE_IN_PKTINFO
+#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
     case AF_INET: return lsa->pi.in4.ipi_spec_dst.s_addr != 0;
 #elif defined(IP_RECVDSTADDR)
     case AF_INET: return lsa->pi.in4.s_addr != 0;
-- 
2.9.0


