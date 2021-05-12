From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 May 2021 15:15:03 +0200
Message-Id: <20210512131511.1309914-2-arne@...1227...>
In-Reply-To: <20210512131511.1309914-1-arne@...1227...>
References: <20210512131511.1309914-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/9] Remove explicit struct iovec check
 (HAVE_IOVEC)
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

This macro is currently used only in 3 places in syshead.h
- EXTENDED_SOCKET_ERROR_CAPABILITY is linux specific anyway and
  starts with #if defined(HAVE_LINUX_TYPES_H)
- port share and ip_pktinfo macros depends on sendmsg/recvmsg
  that implicitly also require iovec

So in all three cases we can implicitly assume that iovec is present
and do not need to make this explicit check

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 configure.ac          | 1 -
 src/openvpn/syshead.h | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index f05faf991..dce7982cc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1141,7 +1141,6 @@ if test "${enable_x509_alt_username}" = "yes"; then
 	AC_DEFINE([ENABLE_X509ALTUSERNAME], [1], [Enable --x509-username-field feature])
 fi
 
-test "${ac_cv_header_sys_uio_h}" = "yes" && AC_DEFINE([HAVE_IOVEC], [1], [struct iovec needed for IPv6 support])
 test "${enable_management}" = "yes" && AC_DEFINE([ENABLE_MANAGEMENT], [1], [Enable management server capability])
 test "${enable_debug}" = "yes" && AC_DEFINE([ENABLE_DEBUG], [1], [Enable debugging support])
 test "${enable_small}" = "yes" && AC_DEFINE([ENABLE_SMALL], [1], [Enable smaller executable size])
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index a9680f72f..5e0176fb9 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -371,7 +371,7 @@ typedef int MIB_TCP_STATE;
 /*
  * Do we have the capability to report extended socket errors?
  */
-#if defined(HAVE_LINUX_TYPES_H) && defined(HAVE_LINUX_ERRQUEUE_H) && defined(HAVE_SOCK_EXTENDED_ERR) && defined(HAVE_MSGHDR) && defined(HAVE_CMSGHDR) && defined(CMSG_FIRSTHDR) && defined(CMSG_NXTHDR) && defined(IP_RECVERR) && defined(MSG_ERRQUEUE) && defined(SOL_IP) && defined(HAVE_IOVEC)
+#if defined(HAVE_LINUX_TYPES_H) && defined(HAVE_LINUX_ERRQUEUE_H) && defined(HAVE_SOCK_EXTENDED_ERR) && defined(HAVE_MSGHDR) && defined(HAVE_CMSGHDR) && defined(CMSG_FIRSTHDR) && defined(CMSG_NXTHDR) && defined(IP_RECVERR) && defined(MSG_ERRQUEUE) && defined(SOL_IP)
 #define EXTENDED_SOCKET_ERROR_CAPABILITY 1
 #else
 #define EXTENDED_SOCKET_ERROR_CAPABILITY 0
@@ -381,7 +381,7 @@ typedef int MIB_TCP_STATE;
  * Does this platform support linux-style IP_PKTINFO
  * or bsd-style IP_RECVDSTADDR ?
  */
-#if ((defined(HAVE_IN_PKTINFO) && defined(IP_PKTINFO)) || defined(IP_RECVDSTADDR)) && defined(HAVE_MSGHDR) && defined(HAVE_CMSGHDR) && defined(HAVE_IOVEC) && defined(CMSG_FIRSTHDR) && defined(CMSG_NXTHDR) && defined(HAVE_RECVMSG) && defined(HAVE_SENDMSG)
+#if ((defined(HAVE_IN_PKTINFO) && defined(IP_PKTINFO)) || defined(IP_RECVDSTADDR)) && defined(HAVE_MSGHDR) && defined(HAVE_CMSGHDR) && defined(CMSG_FIRSTHDR) && defined(CMSG_NXTHDR) && defined(HAVE_RECVMSG) && defined(HAVE_SENDMSG)
 #define ENABLE_IP_PKTINFO 1
 #else
 #define ENABLE_IP_PKTINFO 0
@@ -465,7 +465,7 @@ socket_defined(const socket_descriptor_t sd)
 /*
  * HTTPS port sharing capability
  */
-#if defined(ENABLE_PORT_SHARE) && defined(SCM_RIGHTS) && defined(HAVE_MSGHDR) && defined(HAVE_CMSGHDR) && defined(HAVE_IOVEC) && defined(CMSG_FIRSTHDR) && defined(CMSG_NXTHDR) && defined(HAVE_RECVMSG) && defined(HAVE_SENDMSG)
+#if defined(ENABLE_PORT_SHARE) && defined(SCM_RIGHTS) && defined(HAVE_MSGHDR) && defined(HAVE_CMSGHDR) && defined(CMSG_FIRSTHDR) && defined(CMSG_NXTHDR) && defined(HAVE_RECVMSG) && defined(HAVE_SENDMSG)
 #define PORT_SHARE 1
 #else
 #define PORT_SHARE 0
-- 
2.31.1


