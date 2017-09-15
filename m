From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 15 Sep 2017 08:39:16 +0200
Message-ID: <1505457556-8557-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <c39d1e54-04f8-8ca3-34dc-5d023078286a@...2181...>
References: <c39d1e54-04f8-8ca3-34dc-5d023078286a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] pf: clean up temporary files if plugin
 init fails
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

close_instance() tries to remove the file in c2.pf.filename, but that only
works if we actually set that if we fail.  So, set that filename as soon
as we know we've created the file.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v2: As suggested by Antionio, get rid of local 'gc' and 'file' vars.

 src/openvpn/pf.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index 5fe1734..7479347 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -618,19 +618,18 @@ pf_load_from_buffer_list(struct context *c, const struct buffer_list *config)
 void
 pf_init_context(struct context *c)
 {
-    struct gc_arena gc = gc_new();
 #ifdef PLUGIN_PF
     if (plugin_defined(c->plugins, OPENVPN_PLUGIN_ENABLE_PF))
     {
-        const char *pf_file = create_temp_file(c->options.tmp_dir, "pf", &gc);
-        if (pf_file)
+        c->c2.pf.filename = create_temp_file(c->options.tmp_dir, "pf",
+                                             &c->c2.gc);
+        if (c->c2.pf.filename)
         {
-            setenv_str(c->c2.es, "pf_file", pf_file);
+            setenv_str(c->c2.es, "pf_file", c->c2.pf.filename);
 
             if (plugin_call(c->plugins, OPENVPN_PLUGIN_ENABLE_PF, NULL, NULL, c->c2.es) == OPENVPN_PLUGIN_FUNC_SUCCESS)
             {
                 event_timeout_init(&c->c2.pf.reload, 1, now);
-                c->c2.pf.filename = string_alloc(pf_file, &c->c2.gc);
                 c->c2.pf.enabled = true;
 #ifdef ENABLE_DEBUG
                 if (check_debug_level(D_PF_DEBUG))
@@ -658,7 +657,6 @@ pf_init_context(struct context *c)
 #endif
     }
 #endif
-    gc_free(&gc);
 }
 
 void
-- 
2.7.4


