From: Arne Schwabe <arne@...1227...>
Date: Fri, 26 Apr 2013 21:59:32 +0200
Message-Id: <1367006372-14815-1-git-send-email-arne@...1227...>
In-Reply-To: <1367006045-13576-1-git-send-email-arne@...1227...>
References: <1367006045-13576-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [[Patch v3] 4/4] Emulate persist-tun on Android
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

On Android changing the configuration of tun is not possible. So instead of reconfiguring the tun device, open a new tun device and close the old one if needed
---
 src/openvpn/init.c |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f08583b..9ff6600 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1402,8 +1402,19 @@ do_open_tun (struct context *c)
   c->c2.ipv4_tun = (!c->options.tun_ipv6
 		    && is_dev_type (c->options.dev, c->options.dev_type, "tun"));
 
+#ifndef TARGET_ANDROID
   if (!c->c1.tuntap)
     {
+#endif
+      
+#ifdef TARGET_ANDROID
+      /* If we emulate persist-tun on android we still have to open a new tun and
+         then close the old */
+      int oldtunfd=-1;
+      if(c->c1.tuntap)
+          oldtunfd = c->c1.tuntap->fd;
+#endif
+        
       /* initialize (but do not open) tun/tap object */
       do_init_tun (c);
 
@@ -1439,7 +1450,10 @@ do_open_tun (struct context *c)
       /* open the tun device */
       open_tun (c->options.dev, c->options.dev_type, c->options.dev_node,
 		c->c1.tuntap);
-
+#ifdef TARGET_ANDROID
+      if(oldtunfd>=0)
+        close(oldtunfd);
+#endif
       /* set the hardware address */
       if (c->options.lladdr)
 	  set_lladdr(c->c1.tuntap->actual_name, c->options.lladdr, c->c2.es);
@@ -1481,6 +1495,7 @@ do_open_tun (struct context *c)
 
       ret = true;
       static_context = c;
+#ifndef TARGET_ANDROID
     }
   else
     {
@@ -1503,6 +1518,7 @@ do_open_tun (struct context *c)
 		     "up",
 		     c->c2.es);
     }
+#endif
   gc_free (&gc);
   return ret;
 }
-- 
1.7.9.5


