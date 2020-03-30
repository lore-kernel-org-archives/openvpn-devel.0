From: selva.nair@...277...
Date: Mon, 30 Mar 2020 14:05:26 -0400
Message-Id: <1585591527-23734-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1585513970-32658-2-git-send-email-selva.nair@...277...>
References: <1585513970-32658-2-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2 1/2] Move querying username/password from
 management to a function
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

Signed-off-by: Selva Nair <selva.nair@...277...>
---
No changes from v1

 src/openvpn/misc.c | 54 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 20 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 1931149..0d5ac30 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -116,6 +116,38 @@ hostname_randomize(const char *hostname, struct gc_arena *gc)
 #undef n_rnd_bytes
 }
 
+#ifdef ENABLE_MANAGEMENT
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
+    if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE))
+    {
+        sc = auth_challenge;
+    }
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
+#endif
+
 /*
  * Get and store a username/password
  */
@@ -149,28 +181,10 @@ get_user_pass_cr(struct user_pass *up,
             && (!from_authfile && (flags & GET_USER_PASS_MANAGEMENT))
             && management_query_user_pass_enabled(management))
         {
-            const char *sc = NULL;
             response_from_stdin = false;
-
-            if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
+            if (!auth_user_pass_mgmt(up, prefix, flags, auth_challenge))
             {
-                management_auth_failure(management, prefix, "previous auth credentials failed");
-            }
-
-            if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE))
-            {
-                sc = auth_challenge;
-            }
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


