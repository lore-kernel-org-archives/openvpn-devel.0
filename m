From: Arne Schwabe <arne@...1227...>
Date: Tue, 17 Dec 2013 11:22:47 +0100
Message-Id: <1387275767-10303-1-git-send-email-arne@...1227...>
In-Reply-To: <1387221007-17736-1-git-send-email-arne@...1227...>
References: <1387221007-17736-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [Patch v2] Add warning for using connection block
	variables after connection blocks
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

In 2.3  some options that were allowed only in global config before have been moved to connection blocks. This changes the behaviour if the variables were defined after connection block. This patch adds a warning to catch these mistakes.

Also let warnings errors show [CONNECTION-OPTIONS] instead of [CMD-LINE] for connection blocks
---
 src/openvpn/options.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f390314..6d9c3b8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3838,7 +3838,7 @@ read_config_string (const char *prefix,
 	{
 	  bypass_doubledash (&p[0]);
 	  check_inline_file_via_buf (&multiline, p, &options->gc);
-	  add_option (options, p, NULL, line_num, 0, msglevel, permission_mask, option_types_found, es);
+	  add_option (options, p, prefix, line_num, 0, msglevel, permission_mask, option_types_found, es);
 	}
       CLEAR (p);
     }
@@ -3958,27 +3958,43 @@ void options_string_import (struct options *options,
 
 #if P2MP
 
-#define VERIFY_PERMISSION(mask) { if (!verify_permission(p[0], file, (mask), permission_mask, option_types_found, msglevel)) goto err; }
+#define VERIFY_PERMISSION(mask) { if (!verify_permission(p[0], file, line, (mask), permission_mask, option_types_found, msglevel, options)) goto err; }
 
 static bool
 verify_permission (const char *name,
 		   const char* file,
+		   int line,
 		   const unsigned int type,
 		   const unsigned int allowed,
 		   unsigned int *found,
-		   const int msglevel)
+		   const int msglevel,
+		   struct options* options)
 {
   if (!(type & allowed))
     {
       msg (msglevel, "option '%s' cannot be used in this context (%s)", name, file);
       return false;
     }
-  else
+
+  if (found)
+    *found |= type;
+
+#ifndef ENABLE_SMALL
+  /* Check if this options is allowed in connection block,
+   * but we are currently not in a connection block
+   * Parsing a connection block uses a temporary options struct without
+   * connection_list
+   */
+
+  if ((type & OPT_P_CONNECTION) && options->connection_list)
     {
-      if (found)
-	*found |= type;
-      return true;
+      if (file)
+	msg (M_WARN, "Option '%s' in %s:%d is ignored by previous <connection> blocks ", name, file, line);
+      else
+	msg (M_WARN, "Option '%s' is ignored by previous <connection> blocks", name);
     }
+#endif
+  return true;
 }
 
 #else
-- 
1.8.3.4 (Apple Git-47)


