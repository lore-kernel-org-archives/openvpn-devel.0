MIME-version: 1.0
From: David Sommerseth <davids@...1347...>
Date: Sun, 23 Oct 2011 13:15:08 +0200
Message-id: <1319368508-3411-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Fix plugin_call() struct env_set corruption
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <davids@...1347...>

For some odd reasons, the static inline plugin_call() function managed
to corrupt the struct env_set *es pointer.  The result was that es->list
pointed at an invalid address, which again caused SEGV.

This patch replaces the static inline function with a macro instead, and
let the plugin_call_ssl() keep all its arguments - no matter if SSL is
enabled or not.

This issues appeared first in commit 1876ccd012e9e2ca6f8e1cd9e7e9bb4bf24ccecb,
which does modify the plugin system.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 plugin.c |    5 +----
 plugin.h |   21 +++------------------
 2 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/plugin.c b/plugin.c
index 737a868..2fdf0d4 100644
--- a/plugin.c
+++ b/plugin.c
@@ -584,11 +584,8 @@ plugin_call_ssl (const struct plugin_list *pl,
 	     const int type,
 	     const struct argv *av,
 	     struct plugin_return *pr,
-	     struct env_set *es
-#ifdef USE_SSL
-             , int certdepth,
+	     struct env_set *es, int certdepth,
 	     x509_cert_t *current_cert
-#endif
 	    )
 {
   if (pr)
diff --git a/plugin.h b/plugin.h
index 8782751..2ad8883 100644
--- a/plugin.h
+++ b/plugin.h
@@ -122,30 +122,15 @@ void plugin_list_open (struct plugin_list *pl,
 
 struct plugin_list *plugin_list_inherit (const struct plugin_list *src);
 
-
-static inline int
-plugin_call(const struct plugin_list *pl,
-	const int type,
-	const struct argv *av,
-	struct plugin_return *pr,
-	struct env_set *es)
-{
-  return plugin_call_ssl(pl, type, av, pr, es
-#ifdef USE_SSL
-      -1, NULL
-#endif
-      );
-}
+/** Wrapper for function calls not needing to pass SSL certificate information */
+#define plugin_call(pl, type, av, pr, es) plugin_call_ssl(pl, type, av, pr, es, -1, NULL)
 
 int plugin_call_ssl (const struct plugin_list *pl,
 		 const int type,
 		 const struct argv *av,
 		 struct plugin_return *pr,
-		 struct env_set *es
-#ifdef USE_SSL
-		 , int current_cert_depth,
+		 struct env_set *es, int current_cert_depth,
 		 x509_cert_t *current_cert
-#endif
 		);
 
 void plugin_list_close (struct plugin_list *pl);
-- 
1.7.4.4


