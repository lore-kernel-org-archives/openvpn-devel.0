From: Gert Doering <gert@...1296...>
Date: Fri, 29 Mar 2024 11:37:39 +0100
Message-ID: <20240329103739.28254-1-gert@...1296...>
In-Reply-To: <gerrit.1711616186000.Ic440f2c8d46dfcb5ff41ba2f33bf28bb7286eec4@...2715...>
References: <gerrit.1711616186000.Ic440f2c8d46dfcb5ff41ba2f33bf28bb7286eec4@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] misc.c: remove unused code
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

From: Lev Stipakov <lev@...515...>

Commit

  3a4fb1 "Ensure --auth-nocache is handled during renegotiation"

has changed the behavior of set_auth_token(), but left unused parameter

  struct user_pass *up

Remove this parameter and amend comments accordingly. Also remove
unused function definition from misc.h.

Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>

Change-Id: Ic440f2c8d46dfcb5ff41ba2f33bf28bb7286eec4
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/550
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 3ff0857..598fbae 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -491,19 +491,15 @@
 }
 
 void
-set_auth_token(struct user_pass *up, struct user_pass *tk, const char *token)
+set_auth_token(struct user_pass *tk, const char *token)
 {
-
     if (strlen(token))
     {
         strncpynt(tk->password, token, USER_PASS_LEN);
         tk->token_defined = true;
 
         /*
-         * --auth-token has no username, so it needs the username
-         * either already set or copied from up, or later set by
-         * --auth-token-user
-         * If already set, tk is fully defined.
+         * If username already set, tk is fully defined.
          */
         if (strlen(tk->username))
         {
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index cb3bf68..963f3e6 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -152,26 +152,18 @@
     return get_user_pass_cr(up, auth_file, prefix, flags, NULL);
 }
 
-void fail_user_pass(const char *prefix,
-                    const unsigned int flags,
-                    const char *reason);
-
 void purge_user_pass(struct user_pass *up, const bool force);
 
 /**
- * Sets the auth-token to token. If a username is available from
- * either up or already present in tk that will be used as default
- * username for the token. The method will also purge up if
+ * Sets the auth-token to token. The method will also purge up if
  * the auth-nocache option is active.
  *
- * @param up        (non Auth-token) Username/password
  * @param tk        auth-token userpass to set
  * @param token     token to use as password for the auth-token
  *
  * @note    all parameters to this function must not be null.
  */
-void set_auth_token(struct user_pass *up, struct user_pass *tk,
-                    const char *token);
+void set_auth_token(struct user_pass *tk, const char *token);
 
 /**
  * Sets the auth-token username by base64 decoding the passed
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 7895a37..7c49451 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -340,7 +340,7 @@
 void
 ssl_set_auth_token(const char *token)
 {
-    set_auth_token(&auth_user_pass, &auth_token, token);
+    set_auth_token(&auth_token, token);
 }
 
 void

