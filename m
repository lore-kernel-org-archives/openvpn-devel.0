From: Steffan Karger <steffan@...1856...>
Date: Sun,  1 Jun 2014 19:58:55 +0200
Message-Id: <1401645536-27849-5-git-send-email-steffan@...1856...>
In-Reply-To: <1401645536-27849-1-git-send-email-steffan@...1856...>
References: <1401645536-27849-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 4/5] Remove dependency on manage.h from
	ssl_verify.h
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

verify_user_pass_enabled() is a function on a tls_session, and belongs in
ssl.c. Moving the function removes the dependency on manage.h.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl.c        | 21 ++++++++++++++++++++-
 src/openvpn/ssl_verify.h | 20 --------------------
 2 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e9e01ad..2d5dde0 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -837,6 +837,25 @@ static inline void tls_session_set_self_referential_pointers (struct tls_session
   session->tls_auth.packet_id = &session->tls_auth_pid;
 }
 
+/**
+ * Returns whether or not the server should check for username/password
+ *
+ * @param session	The current TLS session
+ *
+ * @return		true if username and password verification is enabled,
+ *			false if not.
+ */
+static inline bool
+tls_session_user_pass_enabled(struct tls_session *session)
+{
+  return (session->opt->auth_user_pass_verify_script
+        || plugin_defined (session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
+#ifdef MANAGEMENT_DEF_AUTH
+        || management_enable_def_auth (management)
+#endif
+        );
+}
+
 
 /** @addtogroup control_processor
  *  @{ */
@@ -2069,7 +2088,7 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
       output_peer_info_env (session->opt->es, multi->peer_info);
 #endif
 
-  if (verify_user_pass_enabled(session))
+  if (tls_session_user_pass_enabled(session))
     {
       /* Perform username/password authentication */
       if (!username_status || !password_status)
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index e0bcba4..601d863 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -32,7 +32,6 @@
 
 #include "syshead.h"
 #include "misc.h"
-#include "manage.h"
 #include "ssl_common.h"
 
 /* Include OpenSSL-specific code */
@@ -166,25 +165,6 @@ tls_common_name_hash (const struct tls_multi *multi, const char **cn, uint32_t *
 #endif
 
 /**
- * Returns whether or not the server should check for username/password
- *
- * @param session	The current TLS session
- *
- * @return 		true if username and password verification is enabled,
- * 			false if not.
- *
- */
-static inline bool verify_user_pass_enabled(struct tls_session *session)
-{
-  return (session->opt->auth_user_pass_verify_script
-        || plugin_defined (session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
-#ifdef MANAGEMENT_DEF_AUTH
-        || management_enable_def_auth (management)
-#endif
-        );
-}
-
-/**
  * Verify the given username and password, using either an external script, a
  * plugin, or the management interface.
  *
-- 
1.9.1


