From: Steffan Karger <steffan.karger@...1435...>
Date: Thu, 14 Sep 2017 23:34:32 +0200
Message-ID: <1505424872-27434-2-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] pf: clean up temporary files if plugin
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
 src/openvpn/pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/pf.c b/src/openvpn/pf.c
index 5fe1734..3faaebd 100644
--- a/src/openvpn/pf.c
+++ b/src/openvpn/pf.c
@@ -625,12 +625,12 @@ pf_init_context(struct context *c)
         const char *pf_file = create_temp_file(c->options.tmp_dir, "pf", &gc);
         if (pf_file)
         {
+            c->c2.pf.filename = string_alloc(pf_file, &c->c2.gc);
             setenv_str(c->c2.es, "pf_file", pf_file);
 
             if (plugin_call(c->plugins, OPENVPN_PLUGIN_ENABLE_PF, NULL, NULL, c->c2.es) == OPENVPN_PLUGIN_FUNC_SUCCESS)
             {
                 event_timeout_init(&c->c2.pf.reload, 1, now);
-                c->c2.pf.filename = string_alloc(pf_file, &c->c2.gc);
                 c->c2.pf.enabled = true;
 #ifdef ENABLE_DEBUG
                 if (check_debug_level(D_PF_DEBUG))
-- 
2.7.4


