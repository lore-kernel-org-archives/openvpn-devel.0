From: Steffan Karger <steffan@...1856...>
Date: Thu, 28 Sep 2017 17:52:35 +0200
Message-Id: <20170928155235.32237-1-steffan@...1856...>
In-Reply-To: <57ab9396-0960-f915-e1d8-2c4fe0906f2d@...2181...>
References: <57ab9396-0960-f915-e1d8-2c4fe0906f2d@...2181...>
Subject: [Openvpn-devel] [PATCH 2/2 v3] pf: clean up temporary files if
 plugin init fails
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

From: Steffan Karger <steffan.karger@...1435...>

close_instance() tries to remove the file in c2.pf.filename, but that only
works if we actually set that if we fail.  So, set that filename as soon
as we know we've created the file.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v2: As suggested by Antionio, get rid of local 'gc' and 'file' vars.
v3: Make (struct pf_context).filename a const char *

 src/openvpn/pf.c | 10 ++++------
 src/openvpn/pf.h |  2 +-
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index 29231b67..1c7aeac9 100644
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
@@ -659,7 +658,6 @@ pf_init_context(struct context *c)
 #endif
     }
 #endif
-    gc_free(&gc);
 }
 
 void
diff --git a/src/openvpn/pf.h b/src/openvpn/pf.h
index 414c85b8..b839fd2e 100644
--- a/src/openvpn/pf.h
+++ b/src/openvpn/pf.h
@@ -75,7 +75,7 @@ struct pf_context {
     bool enabled;
     struct pf_set *pfs;
 #ifdef PLUGIN_PF
-    char *filename;
+    const char *filename;
     time_t file_last_mod;
     unsigned int n_check_reload;
     struct event_timeout reload;
-- 
2.11.0


