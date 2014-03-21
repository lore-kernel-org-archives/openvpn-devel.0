From: Arne Schwabe <arne@...1227...>
Date: Fri, 21 Mar 2014 14:18:35 +0100
Message-Id: <1395407925-25518-3-git-send-email-arne@...1227...>
In-Reply-To: <1395407925-25518-1-git-send-email-arne@...1227...>
References: <1395407925-25518-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 02/12] Move the initialization of the
	environment to the top so c2.es is initialized
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

---
 src/openvpn/init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 3b72b96..c50b5c2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3339,6 +3339,10 @@ init_instance (struct context *c, const struct env_set *env, const unsigned int
   /* init garbage collection level */
   gc_init (&c->c2.gc);
 
+  /* inherit environmental variables */
+  if (env)
+     do_inherit_env (c, env);
+
   /* signals caught here will abort */
   c->sig->signal_received = 0;
   c->sig->signal_text = NULL;
@@ -3390,10 +3394,6 @@ init_instance (struct context *c, const struct env_set *env, const unsigned int
   if (c->mode == CM_P2P || c->mode == CM_TOP)
     do_option_warnings (c);
 
-  /* inherit environmental variables */
-  if (env)
-    do_inherit_env (c, env);
-
 #ifdef ENABLE_PLUGIN
   /* initialize plugins */
   if (c->mode == CM_P2P || c->mode == CM_TOP)
-- 
1.8.5.2 (Apple Git-48)


