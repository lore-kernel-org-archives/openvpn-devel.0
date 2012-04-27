Date: Fri, 27 Apr 2012 06:01:20 -0700
From: Alon Bar-Lev <alon.barlev@...277...>
Message-ID: <4f9a98a089d42_74dddffae8179818@...1710...>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--==_mimepart_4f9a98a086851_74dddffae81796f4";
	charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [Openvpn-devel] [OpenVPN/openvpn] bff413: Clean-up: Presume that
 Linux is always IPv6 capabl...
Reply-To: Alon Bar-Lev <alon.barlev@...277...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net



----==_mimepart_4f9a98a086851_74dddffae81796f4
Date: Fri, 27 Apr 2012 06:01:20 -0700
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-ID: <4f9a98a088e72_74dddffae8179730@...1710...>

  Branch: refs/heads/master
  Home:   https://github.com/OpenVPN/openvpn
  Commit: bff413d5c47645b525988a66c138abf7d198e228
      https://github.com/OpenVPN/openvpn/commit/bff413d5c47645b525988a66c138abf7d198e228
  Author: David Sommerseth <davids@...1347...>
  Date:   2012-04-27 (Fri, 27 Apr 2012)

  Changed paths:
    M configure.ac
    M src/openvpn/tun.c

  Log Message:
  -----------
  Clean-up: Presume that Linux is always IPv6 capable at build time

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
Acked-by: Gert Doering <gert@...1296...>
Acked-by: Alon Bar-Lev <alon.barlev@...277...>
Message-Id: 1335521425-23391-1-git-send-email-davids@...1347...
URL: http://article.gmane.org/gmane.network.openvpn.devel/6351


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
@@ -1373,14 +1373,6 @@ void delete_route_connected_v6_net(struct tuntap * tt,
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
@@ -1388,13 +1380,6 @@ void delete_route_connected_v6_net(struct tuntap * tt,
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
@@ -1623,7 +1608,6 @@ void delete_route_connected_v6_net(struct tuntap * tt,
 int
 write_tun (struct tuntap* tt, uint8_t *buf, int len)
 {
-#if LINUX_IPV6
   if (tt->ipv6)
     {
       struct tun_pi pi;
@@ -1649,14 +1633,12 @@ void delete_route_connected_v6_net(struct tuntap * tt,
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
@@ -1672,7 +1654,6 @@ void delete_route_connected_v6_net(struct tuntap * tt,
       return(ret - sizeof(pi));
     }
   else
-#endif
     return read (tt->fd, buf, len);
 }
 


================================================================
  Commit: 4e846b39a35b5f9501e4283be0af620d7c9c8b5c
      https://github.com/OpenVPN/openvpn/commit/4e846b39a35b5f9501e4283be0af620d7c9c8b5c
  Author: Alon Bar-Lev <alon.barlev@...277...>
  Date:   2012-04-27 (Fri, 27 Apr 2012)

  Changed paths:
    M src/openvpn/packet_id.c

  Log Message:
  -----------
  crash: packet_id_debug_print: sl may be null

Program received signal SIGSEGV, Segmentation fault.
packet_id_debug_print (msglevel=1174405255, p=0xa36bd0718,
pin=0x3de5feec1b0,
message=0xa330dde80 "PID_TEST", value=0) at
../../../src/openvpn/packet_id.c:504
504       for (i = 0; i < sl->x_size; ++i)

(gdb) print sl
$2 = (const struct seq_list *) 0x0

Reported in the past[1].

[1] http://thread.gmane.org/gmane.network.openvpn.devel/5466

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
Acked-by: James Yonan <james@...515...>
Message-Id: 1333879485-2417-1-git-send-email-alon.barlev@...277...
URL: http://article.gmane.org/gmane.network.openvpn.devel/6259
Message-Id: 4F9A6B4B.7060502@...515...
URL: http://article.gmane.org/gmane.network.openvpn.devel/6350
Signed-off-by: David Sommerseth <davids@...1347...>


diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 0102129..baa4966 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -501,7 +501,7 @@ static void packet_id_debug_print (int msglevel,
 
   buf_printf (&out, "%s [%d]", message, value);
   buf_printf (&out, " [%s-%d] [", p->name, p->unit);
-  for (i = 0; i < sl->x_size; ++i)
+  for (i = 0; sl != NULL && i < sl->x_size; ++i)
     {
       char c;
       time_t v;
@@ -538,11 +538,15 @@ static void packet_id_debug_print (int msglevel,
 	      p->time_backtrack,
 	      p->max_backtrack_stat,
 	      (int)p->initialized);
-  buf_printf (&out, " sl=[%d,%d,%d,%d]",
-	      sl->x_head,
-	      sl->x_size,
-	      sl->x_cap,
-	      sl->x_sizeof);
+  if (sl != NULL)
+    {
+	  buf_printf (&out, " sl=[%d,%d,%d,%d]",
+		      sl->x_head,
+		      sl->x_size,
+		      sl->x_cap,
+		      sl->x_sizeof);
+    }
+
 
   msg (msglevel, "%s", BSTR(&out));
   gc_free (&gc);


================================================================
Compare: https://github.com/OpenVPN/openvpn/compare/f99d8fa...4e846b3

----==_mimepart_4f9a98a086851_74dddffae81796f4--

