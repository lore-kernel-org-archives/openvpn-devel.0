From: selva.nair@...277...
Date: Sun, 23 Oct 2022 15:51:05 -0400
Message-Id: <20221023195105.31714-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Ensure --auth-nocache is handled during
 renegotiation
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

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/init.c | 13 -------------
 src/openvpn/misc.c | 10 ++--------
 src/openvpn/ssl.c  | 23 +++++------------------
 src/openvpn/ssl.h  |  6 ------
 4 files changed, 7 insertions(+), 45 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c48048a1..65a822e6 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1548,19 +1548,6 @@ initialization_sequence_completed(struct context *c, const unsigned int flags)
     /* If we delayed UID/GID downgrade or chroot, do it now */
     do_uid_gid_chroot(c, true);
 
-
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
-
     /* Test if errors */
     if (flags & ISC_ERRORS)
     {
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 50f7f975..d78106cd 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -504,19 +504,13 @@ set_auth_token(struct user_pass *up, struct user_pass *tk, const char *token)
          * --auth-token has no username, so it needs the username
          * either already set or copied from up, or later set by
          * --auth-token-user
-         *
-         * Do not overwrite the username if already set to avoid
-         * overwriting an username set by --auth-token-user
+         * If already set, tk is fully defined.
          */
-        if (up->defined && !tk->defined)
+        if (strlen(tk->username))
         {
-            strncpynt(tk->username, up->username, USER_PASS_LEN);
             tk->defined = true;
         }
     }
-
-    /* Cleans user/pass for nocache */
-    purge_user_pass(up, false);
 }
 
 void
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4c0d78a1..765861b1 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2180,20 +2180,13 @@ key_method_2_write(struct buffer *buf, struct tls_multi *multi, struct tls_sessi
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
+        if (session->opt->pull)
         {
-            purge_user_pass(&auth_user_pass, false);
+            strncpynt(auth_token.username, up->username, USER_PASS_LEN);
         }
+        /* respect auth-nocache */
+        purge_user_pass(&auth_user_pass, false);
     }
     else
     {
@@ -4092,9 +4085,3 @@ print_data:
 done:
     return BSTR(&out);
 }
-
-void
-ssl_clean_user_pass(void)
-{
-    purge_user_pass(&auth_user_pass, false);
-}
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 9ae6ae8f..96de9ccc 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -538,12 +538,6 @@ void extract_x509_field_test(void);
  */
 bool is_hard_reset_method2(int op);
 
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


