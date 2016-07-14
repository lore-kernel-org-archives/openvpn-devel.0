From: Arne Schwabe <arne@...1227...>
Date: Thu, 14 Jul 2016 13:25:19 +0200
Message-Id: <1468495519-25102-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Incorporate the Debian typo fixes where
	appropriate and make show_opt default message clearer
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

Debian also incorrectly changes that the default for route parameters can be specified by using "nil" instead of "default. The confusion is probably coming from show_opt printing "nil" instead of "default". Change show_opt to show "default (not set)" instead of "nil"

Original author: Alberto Gonzalez Iniesta <agi@...64...>
---
 doc/openvpn.8       | 8 ++++----
 src/openvpn/occ.c   | 2 +-
 src/openvpn/route.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 64cc934..63364e4 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -21,13 +21,13 @@
 .\"  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 .\"
 .\" Manual page for openvpn
-.\
+.\"
 .\" SH section heading
 .\" SS subsection heading
 .\" LP paragraph
 .\" IP indented paragraph
 .\" TP hanging label
-.\
+.\"
 .\" .nf -- no formatting
 .\" .fi -- resume formatting
 .\" .ft 3 -- boldface
@@ -4226,7 +4226,7 @@ is 15 seconds.
 This option is only relevant in UDP mode, i.e.
 when either
 .B \-\-proto udp
-is specifed, or no
+is specified, or no
 .B \-\-proto
 option is specified.
 
@@ -5487,7 +5487,7 @@ virtual DHCP server address.  In
 .B \-\-dev tun
 mode, OpenVPN will cause the DHCP server to masquerade as if it were
 coming from the remote endpoint.  The optional offset parameter is
-an integer which is > -256 and < 256 and which defaults to 0.
+an integer which is > \-256 and < 256 and which defaults to 0.
 If offset is positive, the DHCP server will masquerade as the IP
 address at network address + offset.
 If offset is negative, the DHCP server will masquerade as the IP
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index ff48706..d71381d 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -379,7 +379,7 @@ process_received_occ_msg (struct context *c)
 	      && c->c2.max_send_size_local > TUN_MTU_MIN
 	      && (c->c2.max_recv_size_remote < c->c2.max_send_size_local
 		  || c->c2.max_recv_size_local < c->c2.max_send_size_remote))
-	    msg (M_INFO, "NOTE: This connection is unable to accomodate a UDP packet size of %d. Consider using --fragment or --mssfix options as a workaround.",
+	    msg (M_INFO, "NOTE: This connection is unable to accommodate a UDP packet size of %d. Consider using --fragment or --mssfix options as a workaround.",
 		 c->c2.max_send_size_local);
 	}
       event_timeout_clear (&c->c2.occ_mtu_load_test_interval);
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index a90195f..3073666 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1171,7 +1171,7 @@ static const char *
 show_opt (const char *option)
 {
   if (!option)
-    return "nil";
+    return "default (not set)";
   else
     return option;
 }
-- 
2.7.4 (Apple Git-66)


