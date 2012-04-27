From: David Sommerseth <davids@...1347...>
Date: Fri, 27 Apr 2012 12:10:25 +0200
Message-Id: <1335521425-23391-1-git-send-email-davids@...1347...>
In-Reply-To: <1335441085-18186-1-git-send-email-davids@...1347...>
References: <1335441085-18186-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Clean-up: Presume that Linux is always IPv6
	capable at build time
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
where HAVE_TUN_PI is no longer detected.  The tun_pi struct is defined in
linux/if_tun.h, which will be checked for later on.  As this struct has history
in linux/if_tun.h all back to the beginning of the kernel git tree (2.6.12-rc2,
April 2005), it is considered not needed to check for this struct explicit.

[ v2: Commit 7c0a2b5f2b4409 modifies some of the checks this patch touches.  This
      patch just adopts to those changes ]

Signed-off-by: David Sommerseth <davids@...1347...>
---
 configure.ac      |    6 ------
 src/openvpn/tun.c |   19 -------------------
 2 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8ac5ac4..e808cb4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -415,12 +415,6 @@ AC_CHECK_TYPES(
 	[[${SOCKET_INCLUDES}]]
 )
 AC_CHECK_TYPE(
-	[struct tun_pi],
-	[AC_DEFINE([HAVE_TUN_PI], [1], [struct tun_pi needed for IPv6 support])],
-	,
-	[[${SOCKET_INCLUDES}]]
-)
-AC_CHECK_TYPE(
 	[struct iphdr],
 	[AC_DEFINE([HAVE_IPHDR], [1], [struct iphdr needed for IPv6 support])],
 	,
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 227bfde..633150f 100644
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


