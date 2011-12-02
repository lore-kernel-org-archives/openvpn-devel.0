MIME-version: 1.0
From: David Sommerseth <davids@...1347...>
Date: Fri, 02 Dec 2011 16:34:24 +0100
Message-id: <1322840064-30528-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Don't look for 'stdin' file when using
	--auth-user-pass
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

This argument allows the keyword 'stdin' to indicate that the input
is to be read from the stdin.  Don't check for file existence if the
file name is set to 'stdin'

Signed-off-by: David Sommerseth <davids@...1347...>
---
 options.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/options.c b/options.c
index 28296a5..3a819c9 100644
--- a/options.c
+++ b/options.c
@@ -2688,8 +2688,9 @@ options_postprocess_filechecks (struct options *options)
   errs |= check_file_access (CHKACC_FILE, options->management_user_pass, R_OK,
                              "--management user/password file");
 #endif /* ENABLE_MANAGEMENT */
-  errs |= check_file_access (CHKACC_FILE, options->auth_user_pass_file, R_OK,
-                             "--auth-user-pass");
+  if( options->auth_user_pass_file && strcmp(options->auth_user_pass_file, "stdin") != 0 )
+    errs |= check_file_access (CHKACC_FILE, options->auth_user_pass_file, R_OK,
+                               "--auth-user-pass");
 
 
   /* ** System related ** */
-- 
1.7.4.4


