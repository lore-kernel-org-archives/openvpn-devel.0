From: David Sommerseth <davids@...515...>
Date: Mon, 31 Oct 2016 13:51:58 +0100
Message-Id: <1477918318-18561-3-git-send-email-davids@...515...>
In-Reply-To: <1477918318-18561-1-git-send-email-davids@...515...>
References: <1477918318-18561-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH 2/2] auth-gen-token: Provide a rejection
	message back to the client on failure
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

This improves the client experience when a auth-token is rejected or
has expired.  The message provided should be visible in all clients
supporting parsing of AUTH_FAILED push messages.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/ssl.c        |  2 +-
 src/openvpn/ssl_verify.c | 13 +++++++++----
 src/openvpn/ssl_verify.h |  2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 61c8aa0..b11439b 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2278,7 +2278,7 @@ key_method_2_read (struct buffer *buf, struct context *c, struct tls_session *se
 	    }
 	}
 
-      verify_user_pass(up, multi, session);
+      verify_user_pass(up, c, session);
     }
   else
     {
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 99a2f70..60304a1 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -37,8 +37,10 @@
 
 #ifdef ENABLE_CRYPTO
 
+#include "openvpn.h"
 #include "misc.h"
 #include "manage.h"
+#include "push.h"
 #include "otime.h"
 #include "base64.h"
 #include "ssl_verify.h"
@@ -1107,12 +1109,13 @@ verify_user_pass_management (struct tls_session *session, const struct user_pass
  * Main username/password verification entry point
  */
 void
-verify_user_pass(struct user_pass *up, struct tls_multi *multi,
+verify_user_pass(struct user_pass *up, struct context *c,
     struct tls_session *session)
 {
   int s1 = OPENVPN_PLUGIN_FUNC_SUCCESS;
   bool s2 = true;
   struct key_state *ks = &session->key[KS_PRIMARY]; 	   /* primary key */
+  struct tls_multi *multi = c->c2.tls_multi;
 
   struct gc_arena gc = gc_new ();
   char *raw_username = NULL;
@@ -1163,7 +1166,9 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
           && (multi->auth_token_tstamp + session->opt->auth_token_lifetime) < now)
         {
           msg (D_HANDSHAKE, "Auth-token for client expired\n");
-          ks->authenticated = false;
+          send_auth_failed(c,
+                           "SESSION: Your session has expired,"
+                           " please reauthenticate");
           goto done;
         }
 
@@ -1175,12 +1180,12 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
           free (multi->auth_token);
           multi->auth_token = NULL;
           multi->auth_token_sent = false;
-          ks->authenticated = false;
-          tls_deauthenticate (multi);
 
           msg (D_TLS_ERRORS, "TLS Auth Error: Auth-token verification "
                "failed for username '%s' %s", up->username,
                (ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) ? "[CN SET]" : "");
+          send_auth_failed(c, "SESSION: The authentication token was invalid, "
+                           "please reauthenticate");
         }
       else
         {
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index e5b5950..873b92e 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -187,7 +187,7 @@ tls_common_name_hash (const struct tls_multi *multi, const char **cn, uint32_t *
  * @param session	The current TLS session
  *
  */
-void verify_user_pass(struct user_pass *up, struct tls_multi *multi,
+void verify_user_pass(struct user_pass *up, struct context *c,
     struct tls_session *session);
 
 /**
-- 
1.8.3.1


