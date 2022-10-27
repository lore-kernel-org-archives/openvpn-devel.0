From: selva.nair@...277...
Date: Thu, 27 Oct 2022 18:32:01 -0400
Message-Id: <20221027223201.24480-1-selva.nair@...277...>
In-Reply-To: <202210270607.29R67xBm021921@...2054...>
References: <202210270607.29R67xBm021921@...2054...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH for 2.4] Ensure --auth-nocache is handled
 during renegotiation
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

Currently, clearing auth_user_pass struct is delayed until
push-reply processing to support auth-token. This results in
username/password not purged after renegotiations that may
not accompany any pushed tokens -- say, when auth-token is not
in use.

Fix by always clearing auth_user_pass soon after it is used,
instead of delaying the purge as in pre-token days. But, when
"pull" is true, retain the username in auth_token in anticipation
of a token that may or may not arrive later.

Remove ssl_clean_user_pass() as there is no delayed purge any
longer -- auth-nocache handling is now done immediately after
writing username/password to the send-buffer.

Same as commit ecad4839caf4c2fab9c6627ceeca9b9cb32e8929 on master,
except:
   dest != src checked before copying username.
   minor edits to match the context in release/2.4 (no code changes).

Note: In 2.4 atuth_token was set as defined even if there is no username.
This patch changes that to set tk->defined only if username is availble,
matching with 2.5 and 2.6.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/init.c | 15 ---------------
 src/openvpn/misc.c | 13 +++++--------
 src/openvpn/ssl.c  | 23 +++++------------------
 src/openvpn/ssl.h  |  6 ------
 4 files changed, 10 insertions(+), 47 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0c2fd03b..4909debf 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1527,21 +1527,6 @@ initialization_sequence_completed(struct context *c, const unsigned int flags)
     /* If we delayed UID/GID downgrade or chroot, do it now */
     do_uid_gid_chroot(c, true);
 
-
-#ifdef ENABLE_CRYPTO
-    /*
-     * In some cases (i.e. when receiving auth-token via
-     * push-reply) the auth-nocache option configured on the
-     * client is overridden; for this reason we have to wait
-     * for the push-reply message before attempting to wipe
-     * the user/pass entered by the user
-     */
-    if (c->options.mode == MODE_POINT_TO_POINT)
-    {
-        ssl_clean_user_pass();
-    }
-#endif /* ENABLE_CRYPTO */
-
     /* Test if errors */
     if (flags & ISC_ERRORS)
     {
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index e3a2ef31..ec769e95 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1326,18 +1326,15 @@ set_auth_token(struct user_pass *up, struct user_pass *tk, const char *token)
 
     if (strlen(token) && (up->defined || tk->defined))
     {
-        /* auth-token has no password, so it needs the username
-         * either already set or copied from up */
         strncpynt(tk->password, token, USER_PASS_LEN);
-        if (up->defined)
+        /* auth-token has no username, so it needs the username
+         * either already set or copied from up. If set, tk is defined.
+         */
+        if (strlen(tk->username))
         {
-            strncpynt(tk->username, up->username, USER_PASS_LEN);
+            tk->defined = true;
         }
-        tk->defined = true;
     }
-
-    /* Cleans user/pass for nocache */
-    purge_user_pass(up, false);
 }
 
 /*
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index f98799ed..1c3bac4a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2437,20 +2437,13 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
         {
             goto error;
         }
-        /* if auth-nocache was specified, the auth_user_pass object reaches
-         * a "complete" state only after having received the push-reply
-         * message. The push message might contain an auth-token that needs
-         * the username of auth_user_pass.
-         *
-         * For this reason, skip the purge operation here if no push-reply
-         * message has been received yet.
-         *
-         * This normally happens upon first negotiation only.
-         */
-        if (!session->opt->pull)
+        /* save username for auth-token which may get pushed later */
+        if (session->opt->pull && up != &auth_token)
         {
-            purge_user_pass(&auth_user_pass, false);
+            strncpynt(auth_token.username, up->username, USER_PASS_LEN);
         }
+        /* respect auth-nocache */
+        purge_user_pass(&auth_user_pass, false);
     }
     else
     {
@@ -4320,12 +4313,6 @@ done:
     return BSTR(&out);
 }
 
-void
-ssl_clean_user_pass(void)
-{
-    purge_user_pass(&auth_user_pass, false);
-}
-
 char *
 mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
 {
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 8cf03789..2cda6c72 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -627,12 +627,6 @@ void extract_x509_field_test(void);
  */
 bool is_hard_reset(int op, int key_method);
 
-/**
- * Cleans the saved user/password unless auth-nocache is in use.
- */
-void ssl_clean_user_pass(void);
-
-
 /*
  * Show the TLS ciphers that are available for us to use in the SSL
  * library with headers hinting their usage and warnings about usage.
-- 
2.30.2


