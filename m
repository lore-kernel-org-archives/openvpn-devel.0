From: David Sommerseth <davids@...515...>
Date: Fri, 14 Oct 2016 21:07:05 +0200
Message-Id: <1476472025-6912-1-git-send-email-davids@...515...>
In-Reply-To: <1476388771-16492-4-git-send-email-davids@...515...>
References: <1476388771-16492-4-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH v2.1 3/5] auth-gen-token: Generate an
	auth-token per client
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

When --auth-gen-token is used a random token key is generated for
each client after a successful user/password authentication.  This
token is expected to be returned in the password field on the
following authentications.

The token is 256 bits long and BASE64 encoded before it is stored.

  v2 - Fix Doxygen comment typo
     - Don't exceed 80 chars line length

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/ssl.c        |  6 ++++++
 src/openvpn/ssl_common.h |  8 ++++++++
 src/openvpn/ssl_verify.c | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index c7cf78d..54b6686 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1173,6 +1173,12 @@ tls_multi_free (struct tls_multi *multi, bool clear)
 
   cert_hash_free (multi->locked_cert_hash_set);
 
+  if (multi->auth_token)
+    {
+      memset (multi->auth_token, 0, AUTH_TOKEN_SIZE);
+      free (multi->auth_token);
+    }
+
   for (i = 0; i < TM_SIZE; ++i)
     tls_session_free (&multi->session[i], false);
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 50c4a9c..9b63a12 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -351,6 +351,9 @@ struct tls_options
 /** @} name Index of key_state objects within a tls_session structure */
 /** @} addtogroup control_processor */
 
+#define AUTH_TOKEN_SIZE 32      /**< Size of server side generated auth tokens.
+                                 *   32 bytes == 256 bits
+                                 */
 
 /**
  * Security parameter state of a single session within a VPN tunnel.
@@ -525,6 +528,11 @@ struct tls_multi
   uint32_t peer_id;
   bool use_peer_id;
 
+  char *auth_token;      /**< If server sends a generated auth-token,
+                          *   this is the token to use for future
+                          *   user/pass authentications in this session.
+                          */
+  time_t auth_token_tstamp; /**< timestamp of the generated token */
   /*
    * Our session objects.
    */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index d0c22b8..0ac5689 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -39,6 +39,8 @@
 
 #include "misc.h"
 #include "manage.h"
+#include "otime.h"
+#include "base64.h"
 #include "ssl_verify.h"
 #include "ssl_verify_backend.h"
 
@@ -1174,6 +1176,43 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
       if (man_def_auth != KMDA_UNDEF)
 	ks->auth_deferred = true;
 #endif
+
+      if ((session->opt->auth_token_generate) && (NULL == multi->auth_token))
+	{
+	  /* Server is configured with --auth-gen-token but no token has yet
+	   * been generated for this client.  Generate one and save it.
+	   */
+	  uint8_t tok[AUTH_TOKEN_SIZE];
+
+	  if (!rand_bytes(tok, AUTH_TOKEN_SIZE))
+	    {
+	      msg( M_FATAL, "Failed to get enough randomness for "
+                   "authentication token");
+	    }
+
+	  /* The token should be longer than the input when
+           * being base64 encoded
+           */
+	  if( openvpn_base64_encode(tok, AUTH_TOKEN_SIZE,
+                                    &multi->auth_token) < AUTH_TOKEN_SIZE)
+	    {
+	      msg(D_TLS_ERRORS, "BASE64 encoding of token failed. "
+                  "No auth-token will be activated now");
+	      if (multi->auth_token)
+		{
+		  memset (multi->auth_token, 0, AUTH_TOKEN_SIZE);
+		  free (multi->auth_token);
+		  multi->auth_token = NULL;
+		}
+	    }
+	  else
+	    {
+	      multi->auth_token_tstamp = now;
+	      dmsg (D_SHOW_KEYS, "Generated token for client: %s",
+                    multi->auth_token);
+	    }
+	}
+
       if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME))
 	set_common_name (session, up->username);
 #ifdef ENABLE_DEF_AUTH
-- 
1.8.3.1


