From: Selva Nair <selva.nair@...277...>
Date: Sat,  4 Jun 2016 11:54:08 -0400
Message-Id: <1465055649-13628-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH release/2.3] Make block-outside-dns work
	with persist-tun
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

- Remove and recreate WFP filters during restart even when
  tun/tap is not re-opened. This is needed for resolving the remote.

See also: http://article.gmane.org/gmane.network.openvpn.user/36990

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/init.c |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2148777..593fbf4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1522,6 +1522,15 @@ do_open_tun (struct context *c)
 		     NULL,
 		     "up",
 		     c->c2.es);
+#if defined(WIN32)
+      if (c->options.block_outside_dns)
+        {
+          dmsg (D_LOW, "Blocking outside DNS");
+          if (!win_wfp_block_dns(c->c1.tuntap->adapter_index))
+            msg (M_FATAL, "Blocking DNS failed!");
+        }
+#endif
+
     }
   gc_free (&gc);
   return ret;
@@ -1651,6 +1660,15 @@ do_close_tun (struct context *c, bool force)
 					     c->sig->signal_text),
 			 "down",
 			 c->c2.es);
+
+#if defined(WIN32)
+          if (c->options.block_outside_dns)
+            {
+              if (!win_wfp_uninit())
+                  msg (M_FATAL, "Uninitialising WFP failed!");
+            }
+#endif
+
 	}
     }
   gc_free (&gc);
-- 
1.7.10.4


