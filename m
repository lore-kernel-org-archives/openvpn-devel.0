From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:31:44 +0300
Message-Id: <1336851105-24172-4-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336851105-24172-1-git-send-email-alon.barlev@...277...>
References: <1336851105-24172-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [V2.4 3/4] cleanup: remove
	tun_adjust_frame_parameters
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
To: openvpn-devel@lists.sourceforge.net, openvpn.list@...1114..., openvpn-devel@lists.sourceforge.net, openvpn.list@...1114...
Cc: Alon Bar-Lev <alon.barlev@...277...>

It is a wrapper of frame_add_to_extra_tun, no sense to keep both around.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/init.c |    2 +-
 src/openvpn/tun.h  |    6 ------
 2 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index eb4c5df..0bd3f75 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2437,7 +2437,7 @@ do_init_frame (struct context *c)
    * Adjust frame size based on the --tun-mtu-extra parameter.
    */
   if (c->options.ce.tun_mtu_extra_defined)
-    tun_adjust_frame_parameters (&c->c2.frame, c->options.ce.tun_mtu_extra);
+    frame_add_to_extra_tun (&c->c2.frame, c->options.ce.tun_mtu_extra);
 
   /*
    * Adjust frame size based on link socket parameters.
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 7a8e769..f96bb50 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -255,12 +255,6 @@ bool is_tun_p2p (const struct tuntap *tt);
  * Inline functions
  */
 
-static inline void
-tun_adjust_frame_parameters (struct frame* frame, int size)
-{
-  frame_add_to_extra_tun (frame, size);
-}
-
 /*
  * Should ifconfig be called before or after
  * tun dev open?
-- 
1.7.3.4


