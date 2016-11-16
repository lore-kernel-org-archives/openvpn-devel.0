From: David Sommerseth <davids@...515...>
Date: Wed, 16 Nov 2016 19:38:15 +0100
Message-Id: <1479321495-1339-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] tun: Fix weird commit error causing a
	double assignment
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

When committing 7756043c01dd0b, something odd happened causing
the patch to have a duplicate 'ifconfig_ipv6_remote =' assignment.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 3815f0f..77ae72f 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -975,7 +975,7 @@ do_ifconfig (struct tuntap *tt,
 	  if ( tt->type == DEV_TYPE_TUN )
 	   {
 	      const char *ifconfig_ipv6_remote =
-                ifconfig_ipv6_remote = print_in6_addr (tt->remote_ipv6, 0, &gc);
+                print_in6_addr (tt->remote_ipv6, 0, &gc);
 
 	      argv_printf (&argv,
 			    "%s %s inet6 plumb %s/%d %s up",
-- 
1.8.3.1


