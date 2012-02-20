From: David Sommerseth <davids@...1347...>
Date: Mon, 20 Feb 2012 10:37:05 +0100
Message-Id: <1329730625-21681-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Revamp check_file_access() checks in stdin
	scenarios
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

It was discovered that --management also can take stdin as argument
instead of a file.  Enabled this by revamping the check_file_access()
flags by adding CHKACC_ACPTSTDIN.  Setting this flag will then consider
filenames as 'stdin' as always present.

The other place where 'stdin' was accepted is also modified to use this
flag instead.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 options.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/options.c b/options.c
index 43e9e27..a596ffe 100644
--- a/options.c
+++ b/options.c
@@ -2605,6 +2605,7 @@ options_postprocess_mutate (struct options *o)
 #define CHKACC_DIRPATH (1<<1)    /** Check for directory precense where a file should reside */
 #define CHKACC_FILEXSTWR (1<<2)  /** If file exists, is it writable? */
 #define CHKACC_INLINE (1<<3)     /** File is present if it's an inline file */
+#define CHKACC_ACPTSTDIN (1<<4)  /** If filename is stdin, it's allowed and "exists" */
 
 static bool
 check_file_access(const int type, const char *file, const int mode, const char *opt)
@@ -2619,6 +2620,12 @@ check_file_access(const int type, const char *file, const int mode, const char *
   if ((type & CHKACC_INLINE) && streq(file, INLINE_FILE_TAG) )
     return false;
 
+  /* If stdin is allowed and the file name is 'stdin', then do no
+   * further checks as stdin is always available
+   */
+  if( (type & CHKACC_ACPTSTDIN) && streq(file, "stdin") )
+      return false;
+
   /* Is the directory path leading to the given file accessible? */
   if (type & CHKACC_DIRPATH)
     {
@@ -2694,13 +2701,14 @@ options_postprocess_filechecks (struct options *options)
                              "--askpass");
 #endif /* USE_SSL */
 #ifdef ENABLE_MANAGEMENT
-  errs |= check_file_access (CHKACC_FILE, options->management_user_pass, R_OK,
+  errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
+                             options->management_user_pass, R_OK,
                              "--management user/password file");
 #endif /* ENABLE_MANAGEMENT */
 #if P2MP
-  if( options->auth_user_pass_file && strcmp(options->auth_user_pass_file, "stdin") != 0 )
-    errs |= check_file_access (CHKACC_FILE, options->auth_user_pass_file, R_OK,
-                               "--auth-user-pass");
+  errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
+                             options->auth_user_pass_file, R_OK,
+                             "--auth-user-pass");
 #endif /* P2MP */
 
   /* ** System related ** */
-- 
1.7.4.4


