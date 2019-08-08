From: Arne Schwabe <arne@...1227...>
Date: Thu,  8 Aug 2019 16:53:39 +0200
Message-Id: <20190808145339.1265-1-arne@...1227...>
In-Reply-To: <414b5e76-c18d-5348-0d3c-84b121ca46bd@...2080...>
References: <414b5e76-c18d-5348-0d3c-84b121ca46bd@...2080...>
Subject: [Openvpn-devel] [PATCH v6 6/7] Send indication that a session is
 expired to clients
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
Cc: Arne Schwabe <arne@...515...>

From: Arne Schwabe <arne@...515...>

This allows OpenVPN 3 core to fall back to the original authentication
method.

This commit changes man_def_auth_set_client_reason to
auth_set_client_reason since it now used in more contexts.

Also remove a FIXME about client_reason not being freed, as it is freed
in tls_multi_free with auth_set_client_reason(multi, NULL);

Patch V4: Rebase on master
---
 src/openvpn/auth_token.c |  3 +++
 src/openvpn/ssl.c        |  6 ++----
 src/openvpn/ssl_common.h | 10 +++++-----
 src/openvpn/ssl_verify.c |  8 ++++----
 src/openvpn/ssl_verify.h | 15 ++++++++++-----
 5 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 5568a144..1edc8069 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -15,6 +15,7 @@
 #include "push.h"
 #include "integer.h"
 #include "ssl.h"
+#include "ssl_verify.h"
 #include <inttypes.h>
 
 const char *auth_token_pem_name = "OpenVPN auth-token server key";
@@ -378,6 +379,8 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
 
     if (ret & AUTH_TOKEN_EXPIRED)
     {
+        /* Tell client that the session token is expired */
+        auth_set_client_reason(multi, "SESSION: token expired");
         msg(M_INFO, "--auth-token-gen: auth-token from client expired");
     }
     return ret;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 0d79f91e..4455ebb8 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1349,11 +1349,9 @@ tls_multi_free(struct tls_multi *multi, bool clear)
 
     ASSERT(multi);
 
-#ifdef MANAGEMENT_DEF_AUTH
-    man_def_auth_set_client_reason(multi, NULL);
-
-#endif
 #if P2MP_SERVER
+    auth_set_client_reason(multi, NULL);
+
     free(multi->peer_info);
 #endif
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 047aa59b..aad6af2f 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -526,16 +526,16 @@ struct tls_multi
     struct cert_hash_set *locked_cert_hash_set;
 
 #ifdef ENABLE_DEF_AUTH
-    /*
-     * An error message to send to client on AUTH_FAILED
-     */
-    char *client_reason;
-
     /* Time of last call to tls_authentication_status */
     time_t tas_last;
 #endif
 
 #if P2MP_SERVER
+    /*
+     * An error message to send to client on AUTH_FAILED
+     */
+    char *client_reason;
+
     /*
      * A multi-line string of general-purpose info received from peer
      * over control channel.
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 6535ad8d..f61c621b 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -803,9 +803,8 @@ cleanup:
 #define ACF_FAILED    3
 #endif
 
-#ifdef MANAGEMENT_DEF_AUTH
 void
-man_def_auth_set_client_reason(struct tls_multi *multi, const char *client_reason)
+auth_set_client_reason(struct tls_multi* multi, const char* client_reason)
 {
     if (multi->client_reason)
     {
@@ -814,11 +813,12 @@ man_def_auth_set_client_reason(struct tls_multi *multi, const char *client_reaso
     }
     if (client_reason && strlen(client_reason))
     {
-        /* FIXME: Last alloc will never be freed */
         multi->client_reason = string_alloc(client_reason, NULL);
     }
 }
 
+#ifdef MANAGEMENT_DEF_AUTH
+
 static inline unsigned int
 man_def_auth_test(const struct key_state *ks)
 {
@@ -1022,7 +1022,7 @@ tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id, con
     if (multi)
     {
         int i;
-        man_def_auth_set_client_reason(multi, client_reason);
+        auth_set_client_reason(multi, client_reason);
         for (i = 0; i < KEY_SCAN_SIZE; ++i)
         {
             struct key_state *ks = multi->key_scan[i];
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 64f27efb..c54b89a6 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -224,18 +224,23 @@ struct x509_track
 #ifdef MANAGEMENT_DEF_AUTH
 bool tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id, const bool auth, const char *client_reason);
 
-void man_def_auth_set_client_reason(struct tls_multi *multi, const char *client_reason);
+#endif
 
+#ifdef P2MP_SERVER
+/**
+ * Sets the reason why authentication of a client failed. This be will send to the client
+ * when the AUTH_FAILED message is sent
+ * An example would be "SESSION: Token expired"
+ * @param multi             The multi tls struct
+ * @param client_reason     The string to send to the client as part of AUTH_FAILED
+ */
+void auth_set_client_reason(struct tls_multi* multi, const char* client_reason);
 #endif
 
 static inline const char *
 tls_client_reason(struct tls_multi *multi)
 {
-#ifdef ENABLE_DEF_AUTH
     return multi->client_reason;
-#else
-    return NULL;
-#endif
 }
 
 /** Remove any X509_ env variables from env_set es */
-- 
2.22.0


