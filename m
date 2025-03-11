From: Gert Doering <gert@...1296...>
Date: Tue, 11 Mar 2025 16:59:04 +0100
Message-ID: <20250311155904.4446-1-gert@...1296...>
In-Reply-To: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
References: <gerrit.1737375148000.Ia4095518d5e4447992a2974e0d7a159d79ba6b6f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] Implement override-username
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

From: Arne Schwabe <arne@...1227...>

This allow the server to set and override the username that is assumed
for the client for interaction with the client after the authentication.

This is especially intended to allow the of use auth-gen-token in
scenarios where the clients use certificates and multi-factor
authentication.

It allows a client to successfully roam to a different server and have
a correct username and auth-token that can be accepted by that server as
fully authenticated user without requiring MFA again.

The scenario that this feature is probably most useful
when --management-client-auth is in use as in this mode the OpenVPN
server can accept clients without username/password but still use
--auth-gen-token with username and password to accept auth-token as
alternative authentication. A client without a username will also not
use the pushed auth-token. So setting/pushing an auth-token-user
will ensure that the client has a username.

Change-Id: Ia4095518d5e4447992a2974e0d7a159d79ba6b6f
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/872
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/Changes.rst b/Changes.rst
index e011811..d6a0ba6 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -49,6 +49,12 @@
     - IV constructed with XOR instead of concatenation to not have (parts) of
       the real IV on the wire
 
+Allow overriding username with ``--override-username``
+    This is intended to allow using auth-gen-token in scenarios where the
+    clients use certificates and multi-factor authentication.  This will
+    also generate a 'push "auth-token-user newusername"' directives in
+    push replies.
+
 Deprecated features
 -------------------
 ``secret`` support has been removed by default.
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 3fe9862..e93b04d 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -89,6 +89,12 @@
   will lead to authentication bypass (as does returning success on a wrong
   password from a script).
 
+  **Note:** the username for ``--auth-gen-token`` can be overridden by
+  ``--override-user``. In this case the client will be pushed also the
+  ``--auth-token-user`` option and an auth token that is valid for that
+  username instead of the original username that the client authenticated
+  with.
+
 --auth-gen-token-secret file
   Specifies a file that holds a secret for the HMAC used in
   ``--auth-gen-token`` If ``file`` is not present OpenVPN will generate a
@@ -412,6 +418,32 @@
 
   This option requires that ``--disable-occ`` NOT be used.
 
+--override-username username
+  Sets the username of a connection to the specified username.  This username
+  will also be used by ``--auth-gen-token``. However, the overridden
+  username comes only into effect *after* the ``--client-config-dir`` has been
+  read and the ``--auth-user-pass-verify`` and ``--client-connect`` scripts
+  have been run.
+
+  Also ``--username-as-common-name`` will use the client provided username
+  as common-name. It is recommended to avoid the use of the
+  ``--override-username`` option if the option ``--username-as-common-name``
+  is being used.
+
+  The changed username will be picked up by the status output and also by
+  the ``--auth-gen-token`` option. It will also be pushed to the client
+  using ``--auth-token-user``.
+
+  Special care should be taken that both the initial username of the client
+  and the overridden username are handled correctly when using
+  ``--override-username`` and the related options to avoid
+  authentication/authorisation bypasses.
+
+  This option is mainly intended for use cases that use certificates and
+  multi factor authentication and therefore do not provide a username that
+  can be used for ``--auth-gen-token`` to allow providing a username in
+  these scenarios.
+
 --port-share args
   Share OpenVPN TCP with another service
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f76dad8..13874a4 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -42,7 +42,9 @@
 #include "ssl_verify.h"
 #include "ssl_ncp.h"
 #include "vlan.h"
+#include "auth_token.h"
 #include <inttypes.h>
+#include <string.h>
 
 #include "memdbg.h"
 
@@ -2675,6 +2677,60 @@
     NULL,
 };
 
+/**
+ * Overrides the locked username with the username of --override-username
+ * @param mi the multi instance that should be modified.
+ */
+static bool
+override_locked_username(struct multi_instance *mi)
+{
+    struct tls_multi *multi = mi->context.c2.tls_multi;
+    struct options *options = &mi->context.options;
+    struct tls_session *session = &multi->session[TM_ACTIVE];
+
+    if (!multi->locked_username)
+    {
+        msg(D_MULTI_ERRORS, "MULTI: Ignoring override-username as no "
+            "user/password method is enabled. Enable "
+            "--management-client-auth, --auth-user-pass-verify, or a "
+            "plugin with user/password verify capability.");
+        return false;
+    }
+
+    if (!multi->locked_original_username
+        && strcmp(multi->locked_username, options->override_username) != 0)
+    {
+        multi->locked_original_username = multi->locked_username;
+        multi->locked_username = strdup(options->override_username);
+
+        /* Override also the common name if username should be set as common
+         * name */
+        if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME))
+        {
+            set_common_name(session, multi->locked_username);
+            free(multi->locked_cn);
+            multi->locked_cn = NULL;
+            tls_lock_common_name(multi);
+        }
+
+        /* Regenerate the auth-token if enabled */
+        if (multi->auth_token_initial)
+        {
+            struct user_pass up;
+            CLEAR(up);
+            strncpynt(up.username, multi->locked_username,
+                      sizeof(up.username));
+
+            generate_auth_token(&up, multi);
+        }
+
+        msg(D_MULTI_LOW, "MULTI: Note, override-username changes username "
+            "from '%s' to '%s'",
+            multi->locked_original_username,
+            multi->locked_username);
+    }
+    return true;
+}
 /*
  * Called as soon as the SSL/TLS connection is authenticated.
  *
@@ -2778,6 +2834,14 @@
         (*cur_handler_index)++;
     }
 
+    if (mi->context.options.override_username)
+    {
+        if (!override_locked_username(mi))
+        {
+            cc_succeeded = false;
+        }
+    }
+
     /* Check if we have forbidding options in the current mode */
     if (dco_enabled(&mi->context.options)
         && !dco_check_option(D_MULTI_ERRORS, &mi->context.options))
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3ae44db..5b8d121 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -452,6 +452,8 @@
     "                  Only valid in a client-specific config file.\n"
     "--disable       : Client is disabled.\n"
     "                  Only valid in a client-specific config file.\n"
+    "--override-username: Overrides the client-specific username to be used.\n"
+    "                  Only valid in a client-specific config file.\n"
     "--verify-client-cert [none|optional|require] : perform no, optional or\n"
     "                  mandatory client certificate verification.\n"
     "                  Default is to require the client to supply a certificate.\n"
@@ -7955,6 +7957,23 @@
         VERIFY_PERMISSION(OPT_P_INSTANCE);
         options->disable = true;
     }
+    else if (streq(p[0], "override-username") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_INSTANCE);
+        if (strlen(p[1]) > TLS_USERNAME_LEN)
+        {
+            msg(msglevel, "override-username exceeds the maximum length of %d "
+                "characters", TLS_USERNAME_LEN);
+
+            /* disable the connection since ignoring the request to
+             * set another username might cause serious problems */
+            options->disable = true;
+        }
+        else
+        {
+            options->override_username = p[1];
+        }
+    }
     else if (streq(p[0], "tcp-nodelay") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 3f4cb90..0b2a9f3 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -504,6 +504,7 @@
     const char *client_config_dir;
     bool ccd_exclusive;
     bool disable;
+    const char *override_username;
     int n_bcast_buf;
     int tcp_queue_limit;
     struct iroute *iroutes;
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index a7cd3bf..894d85b 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -595,9 +595,19 @@
      */
     if (tls_multi->auth_token)
     {
-        push_option_fmt(gc, push_list, M_USAGE,
-                        "auth-token %s",
+        push_option_fmt(gc, push_list, M_USAGE, "auth-token %s",
                         tls_multi->auth_token);
+
+        char *base64user = NULL;
+        int ret = openvpn_base64_encode(tls_multi->locked_username,
+                                        (int)strlen(tls_multi->locked_username),
+                                        &base64user);
+        if (ret < USER_PASS_LEN && ret > 0)
+        {
+            push_option_fmt(gc, push_list, M_USAGE, "auth-token-user %s",
+                            base64user);
+        }
+        free(base64user);
     }
 }
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 439ce79..16fa4cd 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1262,6 +1262,7 @@
     free(multi->peer_info);
     free(multi->locked_cn);
     free(multi->locked_username);
+    free(multi->locked_original_username);
 
     cert_hash_free(multi->locked_cert_hash_set);
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 9625a99..411b64f 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -628,7 +628,16 @@
      * Our locked common name, username, and cert hashes (cannot change during the life of this tls_multi object)
      */
     char *locked_cn;
+
+    /** The locked username is the username we assume the client is using.
+     * Normally the username used for initial authentication unless
+     * overridden by --override-username */
     char *locked_username;
+
+    /** The username that client initially used before being overridden
+     * by --override-user */
+    char *locked_original_username;
+
     struct cert_hash_set *locked_cert_hash_set;
 
     /** Time of last when we updated the cached state of
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index e7d7ed6..dd230e8 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -48,9 +48,6 @@
 #include "push.h"
 #include "ssl_util.h"
 
-/** Maximum length of common name */
-#define TLS_USERNAME_LEN 64
-
 static void
 string_mod_remap_name(char *str)
 {
@@ -85,10 +82,7 @@
     }
 }
 
-/*
- * Set the given session's common_name
- */
-static void
+void
 set_common_name(struct tls_session *session, const char *common_name)
 {
     if (session->common_name)
@@ -153,7 +147,10 @@
 {
     if (multi->locked_username)
     {
-        if (strcmp(username, multi->locked_username) != 0)
+        /* If the username has been overridden, we accept both the original
+         * username and the changed username */
+        if (strcmp(username, multi->locked_username) != 0
+            &&  (!multi->locked_original_username || strcmp(username, multi->locked_original_username) != 0))
         {
             msg(D_TLS_ERRORS, "TLS Auth Error: username attempted to change from '%s' to '%s' -- tunnel disabled",
                 multi->locked_username,
@@ -1613,6 +1610,17 @@
      */
     bool skip_auth = false;
 
+    /* Replace username early if override-username is in effect but only
+     * if client is sending the original username */
+    if (multi->locked_original_username
+        && strncmp(up->username, multi->locked_original_username, sizeof(up->username)) == 0)
+    {
+        msg(D_MULTI_LOW, "TLS: Replacing client provided username '%s' with "
+            "username from override-user '%s'", up->username,
+            multi->locked_username);
+        strncpy(up->username, multi->locked_username, sizeof(up->username));
+    }
+
     /*
      * If server is configured with --auth-gen-token and the client sends
      * something that looks like an authentication token, this
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index cd2ec24..eba3832 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -51,6 +51,9 @@
 /** Maximum certificate depth we will allow */
 #define MAX_CERT_DEPTH 16
 
+/** Maximum length of common name */
+#define TLS_USERNAME_LEN 64
+
 /** Structure containing the hash for a single certificate */
 struct cert_hash {
     unsigned char sha256_hash[256/8];
@@ -146,6 +149,16 @@
  */
 const char *tls_common_name(const struct tls_multi *multi, const bool null);
 
+
+/**
+ * Sets the common name field for the given tunnel
+ *
+ * @param multi         The tunnel to set the common name for
+ * @param common_name   The name to set the common name to
+ */
+void
+set_common_name(struct tls_session *session, const char *common_name);
+
 /**
  * Returns the username field for the given tunnel
  *

