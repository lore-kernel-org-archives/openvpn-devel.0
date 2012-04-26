From: David Sommerseth <davids@...1347...>
Date: Thu, 26 Apr 2012 13:51:25 +0200
Message-Id: <1335441085-18186-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Presume that Linux is always IPv6 capable
	at build time
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

These days it is highly unlikely that OpenVPN will be built in a non-IPv6
capable Linux environment.  So remove compile-time related macros identifying
that.

This also solves an issue which was introduced in commit 51bd56f46f55177cf0f8b
where HAVE_TUN_PI and HAVE_IPHDR is no longer detected.  As these macros where
only used to detect if IPv6 support was available on Linux, it makes no sense
looking for them any more.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 configure.ac      |   13 -------------
 src/openvpn/tun.c |   19 -------------------
 2 files changed, 0 insertions(+), 32 deletions(-)

diff --git a/configure.ac b/configure.ac
index e962323..4286866 100644
--- a/configure.ac
+++ b/configure.ac
@@ -404,7 +404,6 @@ AC_CHECK_HEADERS(
 	,
 	[[${SOCKET_INCLUDES}]]
 )
-
 AC_CHECK_TYPES(
 	[in_addr_t],
 	,
@@ -412,18 +411,6 @@ AC_CHECK_TYPES(
 	[[${SOCKET_INCLUDES}]]
 )
 AC_CHECK_TYPE(
-	[struct tun_pi],
-	[AC_DEFINE(HAVE_TUN_PI, 1, [struct tun_pi needed for IPv6 support])],
-	,
-	[[${SOCKET_INCLUDES}]]
-)
-AC_CHECK_TYPE(
-	[struct iphdr],
-	[AC_DEFINE(HAVE_IPHDR, 1, [struct iphdr needed for IPv6 support])],
-	,
-	[[${SOCKET_INCLUDES}]]
-)
-AC_CHECK_TYPE(
 	[struct sock_extended_err],
 	[AC_DEFINE(HAVE_SOCK_EXTENDED_ERR, 1, [struct sock_extended_err needed for extended socket error support])],
 	,
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index b99071c..63e6f77 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1373,14 +1373,6 @@ close_tun_generic (struct tuntap *tt)
 #error header file linux/sockios.h required
 #endif
 
-#if defined(HAVE_TUN_PI) && defined(HAVE_IPHDR) && defined(HAVE_IOVEC) && defined(ETH_P_IPV6) && defined(ETH_P_IP) && defined(HAVE_READV) && defined(HAVE_WRITEV)
-#define LINUX_IPV6 1
-/* #warning IPv6 ON */
-#else
-#define LINUX_IPV6 0
-/* #warning IPv6 OFF */
-#endif
-
 #if !PEDANTIC
 
 void
@@ -1388,13 +1380,6 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 {
   struct ifreq ifr;
 
-  /* warn if a very old linux version is used & --tun-ipv6 set
-   */
-#if LINUX_IPV6 == 0
-  if ( tt->ipv6 )
-    msg (M_WARN, "NOTE: explicit support for IPv6 tun devices is not provided for this OS");
-#endif
-
   /*
    * We handle --dev null specially, we do not open /dev/null for this.
    */
@@ -1623,7 +1608,6 @@ close_tun (struct tuntap *tt)
 int
 write_tun (struct tuntap* tt, uint8_t *buf, int len)
 {
-#if LINUX_IPV6
   if (tt->ipv6)
     {
       struct tun_pi pi;
@@ -1649,14 +1633,12 @@ write_tun (struct tuntap* tt, uint8_t *buf, int len)
       return(ret - sizeof(pi));
     }
   else
-#endif
     return write (tt->fd, buf, len);
 }
 
 int
 read_tun (struct tuntap* tt, uint8_t *buf, int len)
 {
-#if LINUX_IPV6
   if (tt->ipv6)
     {
       struct iovec vect[2];
@@ -1672,7 +1654,6 @@ read_tun (struct tuntap* tt, uint8_t *buf, int len)
       return(ret - sizeof(pi));
     }
   else
-#endif
     return read (tt->fd, buf, len);
 }
 
-- 
1.7.4.4


