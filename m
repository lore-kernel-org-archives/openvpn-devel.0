From: Arne Schwabe <arne@...1227...>
Date: Mon, 16 Dec 2013 20:10:07 +0100
Message-Id: <1387221007-17736-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Add warning for using connection block
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
---
 src/openvpn/common.h  |  5 +++++
 src/openvpn/options.c | 34 +++++++++++++++++++++++++---------
 2 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index 2f85bec..4f32ef1 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -98,6 +98,11 @@ typedef unsigned long ptr_type;
 #define INLINE_FILE_TAG "[[INLINE]]"
 
 /*
+ * Pseudo filename for connection blocks 
+ */
+#define CONNECTION_FILE_TAG "[CONNECTION-OPTIONS]"
+
+/*
  * Script security warning
  */
 #define SCRIPT_SECURITY_WARNING "WARNING: External program may not be called unless '--script-security 2' or higher is enabled. See --help text or man page for detailed info."
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 07a9b89..4066a67 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3465,7 +3465,7 @@ int
 parse_line (const char *line,
 	    char *p[],
 	    const int n,
-	    const char *file,
+const char *file,
 	    const int line_num,
 	    int msglevel,
 	    struct gc_arena *gc)
@@ -3805,7 +3805,7 @@ read_config_string (const char *prefix,
 	{
 	  bypass_doubledash (&p[0]);
 	  check_inline_file_via_buf (&multiline, p, &options->gc);
-	  add_option (options, p, NULL, line_num, 0, msglevel, permission_mask, option_types_found, es);
+	  add_option (options, p, prefix, line_num, 0, msglevel, permission_mask, option_types_found, es);
 	}
       CLEAR (p);
     }
@@ -3925,27 +3925,43 @@ void options_string_import (struct options *options,
 
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
@@ -4377,7 +4393,7 @@ add_option (struct options *options,
 
 	  init_options (&sub, true);
 	  sub.ce = options->ce;
-	  read_config_string ("[CONNECTION-OPTIONS]", &sub, p[2], msglevel, OPT_P_CONNECTION, option_types_found, es);
+	  read_config_string (CONNECTION_FILE_TAG, &sub, p[2], msglevel, OPT_P_CONNECTION, option_types_found, es);
 	  if (!sub.ce.remote)
 	    {
 	      msg (msglevel, "Each 'connection' block must contain exactly one 'remote' directive");
-- 
1.8.3.4 (Apple Git-47)


