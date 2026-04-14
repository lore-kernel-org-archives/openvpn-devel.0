From: Gert Doering <gert@...1296...>
Date: Tue, 14 Apr 2026 07:58:54 +0200
Message-ID: <20260414055900.17132-1-gert@...1296...>
In-Reply-To: <gerrit.1774983232000.Ieeb2f980330d485739dbf3d722f107c1dbf704fc@...2715...>
References: <gerrit.1774983232000.Ieeb2f980330d485739dbf3d722f107c1dbf704fc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Inlined credentials: read missing
 password from management interface
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

When commit 39619b7fab added support for inlining username only,
fallback for password was from console. This is not ideal when
graphical UI is in use as there is no console. Instead, query the
management interface when possible.

This patch just extends a similar fix when username is read from
a file and password is missing. As before, any username read
from file or inlined is not peserved as we currently have no way
of locking the username in the management interface prompt.

Change-Id: Ieeb2f980330d485739dbf3d722f107c1dbf704fc
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1599
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1599
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index c00a3ce..979293f 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -305,24 +305,6 @@
                 {
                     strncpy(up->password, password_buf, USER_PASS_LEN);
                 }
-                /* The auth-file does not have the password: get both username
-                 * and password from the management interface if possible.
-                 * Otherwise set to read password from console.
-                 */
-#if defined(ENABLE_MANAGEMENT)
-                else if (management && (flags & GET_USER_PASS_MANAGEMENT)
-                         && management_query_user_pass_enabled(management))
-                {
-                    msg(D_LOW,
-                        "No password found in %s authfile '%s'. Querying the management interface",
-                        prefix, auth_file);
-                    if (!auth_user_pass_mgmt(up, prefix, flags, auth_challenge))
-                    {
-                        fclose(fp);
-                        return false;
-                    }
-                }
-#endif
                 else
                 {
                     password_from_stdin = 1;
@@ -348,7 +330,23 @@
         if (username_from_stdin || password_from_stdin || response_from_stdin)
         {
 #ifdef ENABLE_MANAGEMENT
-            if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE) && response_from_stdin)
+            /* If management-query-passwords is true, we could be here because
+             * of no password present in auth-file or inline. In that case
+             * query via the management interface instead of stdin/console.
+             */
+            if (management && (flags & GET_USER_PASS_MANAGEMENT)
+                && management_query_user_pass_enabled(management)
+                && !(flags & GET_USER_PASS_USERNAME_ONLY))
+            {
+                msg(D_LOW,
+                    "No '%s' password found in authfile or inline. Querying the management interface",
+                    prefix);
+                if (!auth_user_pass_mgmt(up, prefix, flags, auth_challenge))
+                {
+                    return false;
+                }
+            }
+            else if (auth_challenge && (flags & GET_USER_PASS_DYNAMIC_CHALLENGE) && response_from_stdin)
             {
                 struct auth_challenge_info *ac = parse_auth_challenge(auth_challenge, &gc);
                 if (ac)

