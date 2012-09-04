Resent-Message-ID: <20120905100716.GB11781@...1758...>
Resent-To: openvpn-devel@lists.sourceforge.net
Date: Tue, 4 Sep 2012 20:03:03 +0200
From: "Bernhard R. Link" <brl+list+openvpn@...1757...>
Message-ID: <20120904180303.GA7243@...1758...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [RCC] remove left over ipv4_tun variable breaking
 dynamic MTU with ipv6 payload
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Author: Bernhard R. Link <brlink@...334...>

The old ipv4_tun variable (meaning IPv4 only payload) is apperently
a left over from openvpn 1.4 when openvpn was still sending Path MTU
information via ICMP if packages transported fragmented.
Since 1.5 it no longer does that so no longer restricted to IPv4 only
payload, but appearently one usage of that flag was forgotten and now
causes openvpn to ignore dynamic MTU information (thus causing
--mtu-disc yes --fragment to fail if --tun_ipv6 is given).
This patch removed those left overs.

Signed-off-by: Bernhard R. Link <brlink@...334...>

---
For history see:
svn diff -r 278:318 http://svn.openvpn.net/projects/openvpn/obsolete/BETA20/
or the more specific:
svn diff -r 290:292 http://svn.openvpn.net/projects/openvpn/obsolete/BETA15/

Still needs testing with tap devices. But I guess it also only fixes
things there.

---
 src/openvpn/forward.c |    2 +-
 src/openvpn/init.c    |    3 ---
 src/openvpn/openvpn.h |    5 -----
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 57c7846..4751d38 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -384,7 +384,7 @@ check_fragment_dowork (struct context *c)
   struct link_socket_info *lsi = get_link_socket_info (c);
 
   /* OS MTU Hint? */
-  if (lsi->mtu_changed && c->c2.ipv4_tun)
+  if (lsi->mtu_changed)
     {
       frame_adjust_path_mtu (&c->c2.frame_fragment, c->c2.link_socket->mtu,
 			     c->options.ce.proto);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 270ee6a..9dc5029 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1399,9 +1399,6 @@ do_open_tun (struct context *c)
   struct gc_arena gc = gc_new ();
   bool ret = false;
 
-  c->c2.ipv4_tun = (!c->options.tun_ipv6
-		    && is_dev_type (c->options.dev, c->options.dev_type, "tun"));
-
   if (!c->c1.tuntap)
     {
       /* initialize (but do not open) tun/tap object */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 0732d0f..7785938 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -394,11 +394,6 @@ struct context_2
   struct buffer to_tun;
   struct buffer to_link;
 
-  /*
-   * IPv4 TUN device?
-   */
-  bool ipv4_tun;
-
   /* should we print R|W|r|w to console on packet transfers? */
   bool log_rw;
 
-- 
1.7.10.4



