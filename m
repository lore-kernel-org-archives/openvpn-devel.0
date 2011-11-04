From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 4 Nov 2011 14:28:13 +0100
Message-ID: <1320413293-12380-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] add check for struct in_pktinfo.ipi_spec_dst
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

While Windows has struct in_pktinfo it's missing the ipi_spec_dst
member. The current autoconf check needs to be extended to also
check for availablity of ipi_spec_dst for openvpn to compile cleanly.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 configure.ac |    6 ++++++
 socket.h     |    2 +-
 syshead.h    |    2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index a4d68e6..a89c89c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -503,6 +503,12 @@ AC_CHECK_TYPE(
 	[AC_DEFINE(HAVE_IN_PKTINFO, 1, [struct in_pktinfo needed for IP_PKTINFO support])],
 	[],
 	[#include "syshead.h"])
+AC_CHECK_MEMBER(
+	[struct in_pktinfo.ipi_spec_dst],
+	[AC_DEFINE(HAVE_IPI_SPEC_DST, 1, [struct in_pktinfo.ipi_spec_dst needed for IP_PKTINFO support])],
+	[],
+	[#include "syshead.h"])
+
 
 AC_CHECK_SIZEOF(unsigned int)
 AC_CHECK_SIZEOF(unsigned long)
diff --git a/socket.h b/socket.h
index 4a4f75d..63ef53e 100644
--- a/socket.h
+++ b/socket.h
@@ -586,7 +586,7 @@ addr_defined_ipi (const struct link_socket_actual *lsa)
 #if ENABLE_IP_PKTINFO
   if (!lsa) return 0;
   switch (lsa->dest.addr.sa.sa_family) {
-#ifdef HAVE_IN_PKTINFO
+#if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
     case AF_INET: return lsa->pi.in4.ipi_spec_dst.s_addr != 0;
 #elif defined(IP_RECVDSTADDR)
     case AF_INET: return lsa->pi.in4.s_addr != 0;
diff --git a/syshead.h b/syshead.h
index f3c0ac9..200cdb8 100644
--- a/syshead.h
+++ b/syshead.h
@@ -404,7 +404,7 @@
  * Does this platform support linux-style IP_PKTINFO
  * or bsd-style IP_RECVDSTADDR ?
  */
-#if defined(ENABLE_MULTIHOME) && ((defined(HAVE_IN_PKTINFO)&&defined(IP_PKTINFO)) || defined(IP_RECVDSTADDR)) && defined(HAVE_MSGHDR) && defined(HAVE_CMSGHDR) && defined(HAVE_IOVEC) && defined(CMSG_FIRSTHDR) && defined(CMSG_NXTHDR) && defined(HAVE_RECVMSG) && defined(HAVE_SENDMSG)
+#if defined(ENABLE_MULTIHOME) && ((defined(HAVE_IN_PKTINFO)&&defined(HAVE_IPI_SPEC_DST)&&defined(IP_PKTINFO)) || defined(IP_RECVDSTADDR)) && defined(HAVE_MSGHDR) && defined(HAVE_CMSGHDR) && defined(HAVE_IOVEC) && defined(CMSG_FIRSTHDR) && defined(CMSG_NXTHDR) && defined(HAVE_RECVMSG) && defined(HAVE_SENDMSG)
 #define ENABLE_IP_PKTINFO 1
 #else
 #define ENABLE_IP_PKTINFO 0
-- 
1.7.4.1


