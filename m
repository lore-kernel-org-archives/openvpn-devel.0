From: Arne Schwabe <arne@...1227...>
Date: Mon, 30 Nov 2020 13:39:28 +0100
Message-Id: <20201130123928.21837-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix auth-token not being updated if
 auth-nocache is set
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

This fixes the auth-token not being updated if auth-nocache is set. Our
set_auth_token method ensures that the auth-token always has a username
but is a little bit too strict in the check.

Also add doxygen documentation and remove null checks. We use this function
only with non-null pointers and it makes it a bit nicer to read.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/misc.c |  9 +++++++--
 src/openvpn/misc.h | 11 +++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 1038b383..c0c72dd7 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -510,10 +510,15 @@ void
 set_auth_token(struct user_pass *up, struct user_pass *tk, const char *token)
 {
 
-    if (token && strlen(token) && up && up->defined)
+    if (strlen(token) && (up->defined || tk->defined))
     {
+        /* auth-token has no password, so it needs the username
+         * either already set or copied from up */
         strncpynt(tk->password, token, USER_PASS_LEN);
-        strncpynt(tk->username, up->username, USER_PASS_LEN);
+        if (up->defined)
+        {
+            strncpynt(tk->username, up->username, USER_PASS_LEN);
+        }
         tk->defined = true;
     }
 
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index a03d94e2..8c3a1227 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -145,6 +145,17 @@ void fail_user_pass(const char *prefix,
 
 void purge_user_pass(struct user_pass *up, const bool force);
 
+/**
+ * Sets the auth-token to token if a username is available from either
+ * up or already present in tk. The method will also purge up if
+ * the auth-nocache option is active.
+ *
+ * @param up        (non Auth-token) Username/password
+ * @param tk        auth-token userpass to set
+ * @param token     token to use as password for the
+ *
+ * @note    all parameters to this function must not be null.
+ */
 void set_auth_token(struct user_pass *up, struct user_pass *tk,
                     const char *token);
 
-- 
2.26.2


