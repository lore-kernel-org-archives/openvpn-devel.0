From: David Sommerseth <davids@...515...>
Date: Tue, 15 Nov 2016 00:13:05 +0100
Message-Id: <1479165185-11730-1-git-send-email-davids@...515...>
In-Reply-To: <1478870201-17943-1-git-send-email-davids@...515...>
References: <1478870201-17943-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH v2] tun: Fix compiler warnings
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

Fixes two compiler warnings idetified by using CFLAGS=-O2

1) ifconfig_ipv6_remote is only used on Solaris, move the
   declaration and assignment of this variable into the
   TARGET_SOLARIS block.

2) Linux have it's own open_tun() function and does not
   depend on open_tun_generic() at all.  So do not exclude
   open_tun_generic() if TARGET_LINUX is defined.

v2 - Move changes from 1) into the proper if() block
     directly
   - Fix up incorrect comment tags related to changes in 2)

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/tun.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 2a87e09..8c74c8f 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -751,7 +751,6 @@ do_ifconfig (struct tuntap *tt,
       const char *ifconfig_remote_netmask = NULL;
       const char *ifconfig_broadcast = NULL;
       const char *ifconfig_ipv6_local = NULL;
-      const char *ifconfig_ipv6_remote = NULL;
       bool do_ipv6 = false;
       struct argv argv = argv_new ();
 
@@ -772,7 +771,6 @@ do_ifconfig (struct tuntap *tt,
       if (tt->did_ifconfig_ipv6_setup )
         {
 	  ifconfig_ipv6_local = print_in6_addr (tt->local_ipv6, 0, &gc);
-	  ifconfig_ipv6_remote = print_in6_addr (tt->remote_ipv6, 0, &gc);
 	  do_ipv6 = true;
 	}
 
@@ -915,7 +913,6 @@ do_ifconfig (struct tuntap *tt,
       management_android_control (management, "IFCONFIG", buf_bptr(&out));
 
 #elif defined(TARGET_SOLARIS)
-
       /* Solaris 2.6 (and 7?) cannot set all parameters in one go...
        * example:
        *    ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 up
@@ -977,6 +974,9 @@ do_ifconfig (struct tuntap *tt,
 
 	  if ( tt->type == DEV_TYPE_TUN )
 	   {
+	      const char *ifconfig_ipv6_remote = NULL;
+
+	      ifconfig_ipv6_remote = print_in6_addr (tt->remote_ipv6, 0, &gc);
 	      argv_printf (&argv,
 			    "%s %s inet6 plumb %s/%d %s up",
 			    IFCONFIG_PATH,
@@ -1502,7 +1502,7 @@ read_tun_header (struct tuntap* tt, uint8_t *buf, int len)
 #endif
 
 
-#ifndef WIN32
+#if !(defined(WIN32) || defined(TARGET_LINUX))
 static void
 open_tun_generic (const char *dev, const char *dev_type, const char *dev_node,
 		  bool dynamic, struct tuntap *tt)
@@ -1604,7 +1604,9 @@ open_tun_generic (const char *dev, const char *dev_type, const char *dev_node,
       tt->actual_name = string_alloc (dynamic_opened ? dynamic_name : dev, NULL);
     }
 }
+#endif /* !WIN32 && !TARGET_LINUX */
 
+#if !defined(WIN32)
 static void
 close_tun_generic (struct tuntap *tt)
 {
@@ -1615,7 +1617,7 @@ close_tun_generic (struct tuntap *tt)
   clear_tuntap (tt);
 }
 
-#endif
+#endif /* !WIN32 */
 
 #if defined (TARGET_ANDROID)
 void
-- 
1.8.3.1


