From: selva.nair@...277...
Date: Sun, 29 Mar 2020 16:32:50 -0400
Message-Id: <1585513970-32658-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1585513970-32658-1-git-send-email-selva.nair@...277...>
References: <1585513970-32658-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 2/2] When auth-user-pass file has no
 password, query the management
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

From: Selva Nair <selva.nair@...277...>

If only username is found in the file, redirect the auth-user-pass
query to the management on Windows if (i) management-query-passwords
is enabled and (ii) stdout is redirected to a log file. These
restrictions avoid regressive behaviour: those running from the
command line will continue to get the prompt on the console
and if both username and password are in the file those will
continue to get used.

Note that the management will prompt for both username and password
ignoring the username read from the file. As the GUI saves the
username, this is a one-time inconvenience.

Currently, the password is queried on the console (or systemd)
in such cases. This is not sensible on windows if log file is
redirected (prompt goes to the log file), or the console
is not available as happens when the GUI is in use.

Trac # 757

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/error.c |  9 +++++++++
 src/openvpn/error.h |  3 +++
 src/openvpn/misc.c  | 17 +++++++++++++++++
 3 files changed, 29 insertions(+)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index ad4f0ef..8ce6873 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -190,6 +190,15 @@ errors_to_stderr(void)
 }
 
 /*
+ * Return true if stdout is redirected to log file
+ */
+bool
+is_stdout_redirected(void)
+{
+    return std_redir;
+}
+
+/*
  * Return a file to print messages to before syslog is opened.
  */
 FILE *
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index eaedf17..5078f6a 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -398,6 +398,9 @@ nonfatal(const unsigned int err)
     return err & M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err;
 }
 
+/** Return true if stdout is redirected to log file */
+bool is_stdout_redirected(void);
+
 #include "errlevel.h"
 
 #endif /* ifndef ERROR_H */
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 0d5ac30..02afd98 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -261,6 +261,23 @@ get_user_pass_cr(struct user_pass *up,
             {
                 strncpy(up->password, password_buf, USER_PASS_LEN);
             }
+            /* The auth-file does not have the password: if we are on Windows
+             * and stdout has been redirected to log file, try to get both username
+             * and password from the management.
+             * Otherwise set to read password from console.
+             */
+#if defined(ENABLE_MANAGEMENT) && defined(_WIN32)
+            else if (is_stdout_redirected()
+                     && management
+                     && (flags & GET_USER_PASS_MANAGEMENT)
+                     && management_query_user_pass_enabled(management))
+            {
+                if (!auth_user_pass_mgmt(up, prefix, flags, auth_challenge))
+                {
+                    return false;
+                }
+            }
+#endif
             else
             {
                 password_from_stdin = 1;
-- 
2.1.4


