From: Antonio Quartulli <a@...2181...>
Date: Sat, 25 Feb 2017 08:40:14 +0800
Message-Id: <20170225004014.28638-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] Ignore auth-nocache for auth-user-pass if
	auth-token is pushed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Antonio Quartulli <a@...2181...>

When the auth-token option is pushed from the server to the client,
the latter has to ignore the auth-nocache directive (if specified).

The password will now be substituted by the unique token, therefore
it can't be wiped out, otherwise the next renegotiation will fail.

Trac: #840
Cc: David Sommerseth <openvpn@...2080...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/init.c | 12 ++++++++++++
 src/openvpn/misc.c |  7 ++++++-
 src/openvpn/misc.h |  2 ++
 src/openvpn/ssl.c  | 33 ++++++++++++++++++++++++++++++++-
 src/openvpn/ssl.h  |  2 ++
 5 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ff1551ea..3c0bb32b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1383,6 +1383,18 @@ initialization_sequence_completed(struct context *c, const unsigned int flags)
     /* If we delayed UID/GID downgrade or chroot, do it now */
     do_uid_gid_chroot(c, true);
 
+    /*
+     * In some cases (i.e. when receiving auth-token via
+     * push-reply) the auth-nocache option configured on the
+     * client is overridden; for this reason we have to wait
+     * for the push-reply message before attempting to wipe
+     * the user/pass entered by the user
+     */
+    if (c->options.mode == MODE_POINT_TO_POINT)
+    {
+        delayed_auth_pass_purge();
+    }
+
     /* Test if errors */
     if (flags & ISC_ERRORS)
     {
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index a2f45b61..e6678ec8 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1480,7 +1480,11 @@ purge_user_pass(struct user_pass *up, const bool force)
         secure_memzero(up, sizeof(*up));
         up->nocache = nocache;
     }
-    else if (!warn_shown)
+    /*
+     * don't show warning if the pass has been replaced by a token: this is an
+     * artificial "auth-nocache"
+     */
+    else if (!warn_shown && (!up->tokenized))
     {
         msg(M_WARN, "WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this");
         warn_shown = true;
@@ -1494,6 +1498,7 @@ set_auth_token(struct user_pass *up, const char *token)
     {
         CLEAR(up->password);
         strncpynt(up->password, token, USER_PASS_LEN);
+        up->tokenized = true;
     }
 }
 
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 16be6219..201ebf62 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -206,6 +206,8 @@ struct user_pass
 {
     bool defined;
     bool nocache;
+    bool tokenized; /* true if password has been substituted by a token */
+    bool wait_for_push; /* true if this object is waiting for a push-reply */
 
 /* max length of username/password */
 #ifdef ENABLE_PKCS11
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 86450fe0..ce301560 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -452,6 +452,8 @@ ssl_set_auth_nocache(void)
 {
     passbuf.nocache = true;
     auth_user_pass.nocache = true;
+    /* wait for push-reply, because auth-token may invert nocache */
+    auth_user_pass.wait_for_push = true;
 }
 
 /*
@@ -460,6 +462,14 @@ ssl_set_auth_nocache(void)
 void
 ssl_set_auth_token(const char *token)
 {
+    if (auth_user_pass.nocache)
+    {
+        msg(M_INFO,
+            "auth-token received, disabling auth-nocache for the "
+            "authentication token");
+        auth_user_pass.nocache = false;
+    }
+
     set_auth_token(&auth_user_pass, token);
 }
 
@@ -2383,7 +2393,21 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
         {
             goto error;
         }
-        purge_user_pass(&auth_user_pass, false);
+        /* if auth-nocache was specified, the auth_user_pass object reaches
+         * a "complete" state only after having received the push-reply
+         * message.
+         * This is the case because auth-token statement in a push-reply would
+         * invert its nocache.
+         *
+         * For this reason, skip the purge operation here if no push-reply
+         * message has been received yet.
+         *
+         * This normally happens upon first negotiation only.
+         */
+        if (!auth_user_pass.wait_for_push)
+        {
+            purge_user_pass(&auth_user_pass, false);
+        }
     }
     else
     {
@@ -4214,6 +4238,13 @@ done:
     return BSTR(&out);
 }
 
+void
+delayed_auth_pass_purge(void)
+{
+    auth_user_pass.wait_for_push = false;
+    purge_user_pass(&auth_user_pass, false);
+}
+
 #else  /* if defined(ENABLE_CRYPTO) */
 static void
 dummy(void)
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index ed1344e7..33a02544 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -591,6 +591,8 @@ void show_tls_performance_stats(void);
 /*#define EXTRACT_X509_FIELD_TEST*/
 void extract_x509_field_test(void);
 
+void delayed_auth_pass_purge(void);
+
 #endif /* ENABLE_CRYPTO */
 
 #endif /* ifndef OPENVPN_SSL_H */
-- 
2.11.1


