From: Arne Schwabe <arne@...1227...>
Date: Sat,  6 Nov 2021 19:00:55 +0100
Message-Id: <20211106180055.3073072-1-arne@...1227...>
In-Reply-To: <20210520151148.2565578-7-arne@...1227...>
References: <20210520151148.2565578-7-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] Refactor early initialisation and
 uninitialisation into methods
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This put the early initialisation and uninitialisation that needs to
happen between option parsing and post processing into small methods.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/openvpn.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 0ac961429..da06f59c2 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -105,6 +105,20 @@ tunnel_point_to_point(struct context *c)
 
 #undef PROCESS_SIGNAL_P2P
 
+void init_early(struct context *c)
+{
+    net_ctx_init(c, &c->net_ctx);
+
+    /* init verbosity and mute levels */
+    init_verb_mute(c, IVM_LEVEL_1);
+
+}
+
+static void uninit_early(struct context *c)
+{
+    net_ctx_free(&c->net_ctx);
+}
+
 
 /**************************************************************************/
 /**
@@ -193,10 +207,9 @@ openvpn_main(int argc, char *argv[])
             open_plugins(&c, true, OPENVPN_PLUGIN_INIT_PRE_CONFIG_PARSE);
 #endif
 
-            net_ctx_init(&c, &c.net_ctx);
-
-            /* init verbosity and mute levels */
-            init_verb_mute(&c, IVM_LEVEL_1);
+            /* Early initialisation that need to happen before option
+             * post processing and other early startup but after parsing */
+            init_early(&c);
 
             /* set dev options */
             init_options_dev(&c.options);
@@ -308,7 +321,7 @@ openvpn_main(int argc, char *argv[])
             env_set_destroy(c.es);
             uninit_options(&c.options);
             gc_reset(&c.gc);
-            net_ctx_free(&c.net_ctx);
+            uninit_early(&c);
         }
         while (c.sig->signal_received == SIGHUP);
     }
-- 
2.33.0


