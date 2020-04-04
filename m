From: selva.nair@...277...
Date: Fri,  3 Apr 2020 21:17:44 -0400
Message-Id: <1585963064-10311-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1585963064-10311-1-git-send-email-selva.nair@...277...>
References: <1585591527-23734-1-git-send-email-selva.nair@...277...>
 <1585963064-10311-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 2/2] When auth-user-pass file has no
 password query the management interface (if available).
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

When only username is found in the file, redirect the auth-user-pass
query to the management interface if management-query-passwords is
enabled.  Otherwise the user is prompted on console, if available,
as before.

This changes the behaviour for those who run from the command line,
with --management-query-passwords, but still expect the prompt
on the console.

Note that the management interface will prompt for both username and
password ignoring the username read from the file. As most GUIs can
save the the username, this is a one-time inconvenience.

Currently, the password is queried on the console (or systemd)
in such cases. This is not sensible when console is not available
(windows GUI, tunnelblick etc.) or when the log is redirected
to a file on Windows (for some reason prompt goes to the log file).

Trac # 757

Signed-off-by: Selva Nair <selva.nair@...277...>
---
This may be cherry-picked from 57578310992d1fbe8eff97049087c5308089acb5
in master without conflicts.

 src/openvpn/misc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 2b0d10c..9c5e96e 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1030,6 +1030,22 @@ get_user_pass_cr(struct user_pass *up,
             {
                 strncpy(up->password, password_buf, USER_PASS_LEN);
             }
+            /* The auth-file does not have the password: get both username
+             * and password from the management interface if possible.
+             * Otherwise set to read password from console.
+             */
+#if defined(ENABLE_MANAGEMENT)
+            else if (management
+                     && (flags & GET_USER_PASS_MANAGEMENT)
+                     && management_query_user_pass_enabled(management))
+            {
+                msg(D_LOW, "No password found in %s authfile '%s'. Querying the management interface", prefix, auth_file);
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


