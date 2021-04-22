From: Arne Schwabe <arne@...1227...>
Date: Thu, 22 Apr 2021 17:29:35 +0200
Message-Id: <20210422152939.2134046-2-arne@...1227...>
In-Reply-To: <20210422152939.2134046-1-arne@...1227...>
References: <20210422152939.2134046-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 2/6] Remove --disable-multihome option
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 config-msvc.h         | 1 -
 configure.ac          | 7 -------
 src/openvpn/syshead.h | 2 +-
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/config-msvc.h b/config-msvc.h
index 2d5e1a51c..3750f0799 100644
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
index e7657b880..4650846fe 100644
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


