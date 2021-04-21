From: Arne Schwabe <arne@...1227...>
Date: Wed, 21 Apr 2021 15:43:42 +0200
Message-Id: <20210421134348.1950392-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/7] Remove --disable-multihome option
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

With this change we always build multihome support if the operating
system supports it.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 configure.ac          | 7 -------
 src/openvpn/syshead.h | 2 +-
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index 747325164..aaac65c3d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -121,13 +121,6 @@ AC_ARG_ENABLE(
 	[enable_fragment="yes"]
 )
 
-AC_ARG_ENABLE(
-	[multihome],
-	[AS_HELP_STRING([--disable-multihome], [disable multi-homed UDP server support (--multihome) @<:@default=yes@:>@])],
-	,
-	[enable_multihome="yes"]
-)
-
 AC_ARG_ENABLE(
 	[port-share],
 	[AS_HELP_STRING([--disable-port-share], [disable TCP server port-share support (--port-share) @<:@default=yes@:>@])],
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index bac07d102..0b029c648 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -391,7 +391,7 @@ typedef int MIB_TCP_STATE;
  * Does this platform support linux-style IP_PKTINFO
  * or bsd-style IP_RECVDSTADDR ?
  */
-#if defined(ENABLE_MULTIHOME) && ((defined(HAVE_IN_PKTINFO) && defined(IP_PKTINFO)) || defined(IP_RECVDSTADDR)) && defined(HAVE_MSGHDR) && defined(HAVE_CMSGHDR) && defined(HAVE_IOVEC) && defined(CMSG_FIRSTHDR) && defined(CMSG_NXTHDR) && defined(HAVE_RECVMSG) && defined(HAVE_SENDMSG)
+#if ((defined(HAVE_IN_PKTINFO) && defined(IP_PKTINFO)) || defined(IP_RECVDSTADDR)) && defined(HAVE_MSGHDR) && defined(HAVE_CMSGHDR) && defined(HAVE_IOVEC) && defined(CMSG_FIRSTHDR) && defined(CMSG_NXTHDR) && defined(HAVE_RECVMSG) && defined(HAVE_SENDMSG)
 #define ENABLE_IP_PKTINFO 1
 #else
 #define ENABLE_IP_PKTINFO 0
-- 
2.31.1


