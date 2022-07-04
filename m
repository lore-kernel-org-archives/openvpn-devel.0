From: selva.nair@...277...
Date: Sun,  3 Jul 2022 22:58:40 -0400
Message-Id: <20220704025840.2558-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix auth-token usage with
 management-def-auth
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

When auth-token verify succeeds during a reauth, other auth
methods (plugin, script, management) are skipped unless
external-auth is in effect (skip_auth gets set to true).

However, in this case, the status of management-def-auth
(ks->mda_satus) stays at its default value of ACF_PENDING
and will never change. This causes TLS keys to go out of sync
and an eventual client disconnect.

Further, a message saying username/password authentication is
"deferred" gets logged which is misleading.
For example:

test/127.0.0.1:35874 TLS: Username/auth-token authentication
    succeeded for username 'test'

followed by

test/127.0.0.1:35874 TLS: Username/Password authentication
    deferred for username 'test' [CN SET]

Fix by setting ks->mda_status to ACF_DISABLED, and do not
set ks->authenticated = KS_AUTH_DEFERRED when skip_auth is true.

Also log a warning message when token is marked as expired on
missing the reneg window.

Reported by: Connor Edwards <connor.edwards@...2680...>

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/auth_token.c | 8 +++++---
 src/openvpn/ssl_verify.c | 9 ++++++++-
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 096edc75..b5f9f6dd 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -346,20 +346,22 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
         return 0;
     }
 
-    /* Accept session tokens that not expired are in the acceptable range
-     * for renogiations */
+    /* Accept session tokens only if their timestamp is in the acceptable range
+     * for renegotiations */
     bool in_renegotiation_time = now >= timestamp
                                  && now < timestamp + 2 * session->opt->renegotiate_seconds;
 
     if (!in_renegotiation_time)
     {
+        msg(M_WARN, "Timestamp (%" PRIu64 ") of auth-token is out of the renegotiation window",
+            timestamp);
         ret |= AUTH_TOKEN_EXPIRED;
     }
 
     /* Sanity check the initial timestamp */
     if (timestamp < timestamp_initial)
     {
-        msg(M_WARN, "Initial timestamp (%" PRIu64 " in token from client earlier than "
+        msg(M_WARN, "Initial timestamp (%" PRIu64 ") in token from client earlier than "
             "current timestamp %" PRIu64 ". Broken/unsynchronised clock?",
             timestamp_initial, timestamp);
         ret |= AUTH_TOKEN_EXPIRED;
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index c01841fa..45eaf8ed 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1599,7 +1599,14 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
 #ifdef ENABLE_MANAGEMENT
         if (man_def_auth != KMDA_UNDEF)
         {
-            ks->authenticated = KS_AUTH_DEFERRED;
+            if (skip_auth)
+            {
+                ks->mda_status = ACF_DISABLED;
+            }
+            else
+            {
+                ks->authenticated = KS_AUTH_DEFERRED;
+            }
         }
 #endif
         if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME))
-- 
2.30.2


