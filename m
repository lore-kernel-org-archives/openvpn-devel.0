From: selva.nair@...277...
Date: Fri,  3 Apr 2020 21:17:43 -0400
Message-Id: <1585963064-10311-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1585591527-23734-1-git-send-email-selva.nair@...277...>
References: <1585591527-23734-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH for-2.4 1/2] Move querying username/password
 from management interface to a function
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

This helps the next patch. No functionality changes, only
refactoring.

Same as commit 461e566fb274d6f7647dc3aa81c02e4fbf362a23 in master
except for additional ifdef ENABLE_CLIENT_CR

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/misc.c | 61 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 22 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index f44c65f..2b0d10c 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -880,6 +880,43 @@ absolute_pathname(const char *pathname)
     }
 }
 
+#ifdef ENABLE_MANAGEMENT
+
+/* Get username/password from the management interface */
+static bool
+auth_user_pass_mgmt(struct user_pass *up, const char *prefix, const unsigned int flags,
+                    const char *auth_challenge)
+{
+    const char *sc = NULL;
+
+    if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
+    {
+        management_auth_failure(management, prefix, "previous auth credentials failed");
+    }
+
+#ifdef ENABLE_CLIENT_CR
+    if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE))
+    {
+        sc = auth_challenge;
+    }
+#endif
+
+    if (!management_query_user_pass(management, up, prefix, flags, sc))
+    {
+        if ((flags & GET_USER_PASS_NOFATAL) != 0)
+        {
+            return false;
+        }
+        else
+        {
+            msg(M_FATAL, "ERROR: could not read %s username/password/ok/string from management interface", prefix);
+        }
+    }
+    return true;
+}
+
+#endif /* ifdef ENABLE_MANAGEMENT */
+
 /*
  * Get and store a username/password
  */
@@ -913,30 +950,10 @@ get_user_pass_cr(struct user_pass *up,
             && (!from_authfile && (flags & GET_USER_PASS_MANAGEMENT))
             && management_query_user_pass_enabled(management))
         {
-            const char *sc = NULL;
             response_from_stdin = false;
-
-            if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
-            {
-                management_auth_failure(management, prefix, "previous auth credentials failed");
-            }
-
-#ifdef ENABLE_CLIENT_CR
-            if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE))
+            if (!auth_user_pass_mgmt(up, prefix, flags, auth_challenge))
             {
-                sc = auth_challenge;
-            }
-#endif
-            if (!management_query_user_pass(management, up, prefix, flags, sc))
-            {
-                if ((flags & GET_USER_PASS_NOFATAL) != 0)
-                {
-                    return false;
-                }
-                else
-                {
-                    msg(M_FATAL, "ERROR: could not read %s username/password/ok/string from management interface", prefix);
-                }
+                return false;
             }
         }
         else
-- 
2.1.4


