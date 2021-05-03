From: Arne Schwabe <arne@...1227...>
Date: Mon,  3 May 2021 12:56:38 +0200
Message-Id: <20210503105638.3903379-1-arne@...1227...>
In-Reply-To: <20210503060713.GS976@...1296...>
References: <20210503060713.GS976@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Remove --disable-multihome option
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

Patch v2: Remove also from config-msvc.h
Patch v3: Remove also another line from configure.ac

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 config-msvc.h         | 1 -
 configure.ac          | 8 --------
 src/openvpn/syshead.h | 2 +-
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/config-msvc.h b/config-msvc.h
index 360e50a05..979232282 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -10,7 +10,6 @@
 #define ENABLE_LZO 1
 #define ENABLE_LZ4 1
 #define ENABLE_MANAGEMENT 1
-#define ENABLE_MULTIHOME 1
 #define ENABLE_PKCS11 1
 #define ENABLE_PLUGIN 1
 #define ENABLE_PORT_SHARE 1
diff --git a/configure.ac b/configure.ac
index 267ffee8e..f05faf991 100644
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
@@ -1150,7 +1143,6 @@ fi
 
 test "${ac_cv_header_sys_uio_h}" = "yes" && AC_DEFINE([HAVE_IOVEC], [1], [struct iovec needed for IPv6 support])
 test "${enable_management}" = "yes" && AC_DEFINE([ENABLE_MANAGEMENT], [1], [Enable management server capability])
-test "${enable_multihome}" = "yes" && AC_DEFINE([ENABLE_MULTIHOME], [1], [Enable multi-homed UDP server capability])
 test "${enable_debug}" = "yes" && AC_DEFINE([ENABLE_DEBUG], [1], [Enable debugging support])
 test "${enable_small}" = "yes" && AC_DEFINE([ENABLE_SMALL], [1], [Enable smaller executable size])
 test "${enable_fragment}" = "yes" && AC_DEFINE([ENABLE_FRAGMENT], [1], [Enable internal fragmentation support])
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 0a3bc0b94..321e20f5b 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -381,7 +381,7 @@ typedef int MIB_TCP_STATE;
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


