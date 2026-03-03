From: Gert Doering <gert@...1296...>
Date: Tue,  3 Mar 2026 15:28:14 +0100
Message-ID: <20260303142819.6123-1-gert@...1296...>
In-Reply-To: <gerrit.1771470576000.I788f76e6a70a9c20bca3367140d2741bd0551582@...2715...>
References: <gerrit.1771470576000.I788f76e6a70a9c20bca3367140d2741bd0551582@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] Add an optional username-only flag for
 auth-user-pass
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

Specify "--auth-user-pass username-only" for openvpn to prompt
for only username, not password. Prompt via management interface
uses the usual ">PASSWORD 'Auth' " prompt with type "username"
instead of "username/password".

Internally, the password gets set as "[[BLANK]]" which is currently
used as tag for blank password.

Not compatible with --static-challenge or when username and
password are inlined or read from a file. In such cases, the user
hard-code a dummy password in the file instead.

Change-Id: I788f76e6a70a9c20bca3367140d2741bd0551582
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1548
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1548
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index b9ae7ce..0b7c308 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -68,7 +68,9 @@
       auth-user-pass up
 
   If ``up`` is present, it must be a file containing username/password on 2
-  lines. If the password line is missing, OpenVPN will prompt for one.
+  lines or a flag named :code:`username-only` to indicate no password
+  should be prompted for. In the former case, if the password line is missing
+  in the file, OpenVPN will prompt for one.
 
   If ``up`` is omitted, username/password will be prompted from the
   console.
@@ -84,6 +86,20 @@
   where password is optional, and will be prompted from the console if
   missing.
 
+  The :code:`username-only` flag is meant to be used with SSO authentication.
+  In this case the user will be asked for a username but not password. Instead,
+  a dummy password :code:`[[BLANK]]` is generated internally and submitted to
+  the server. See management-notes.txt for how this option affects username/password
+  prompt via the management interface. For the console, it simply eliminates
+  the password prompt.
+
+  The :code:`username-only` flag cannot be used along with embedding username and/or
+  password in the config file, or while reading them from an external file. In
+  such cases, if only username is relevant and no password prompt is desired, a
+  dummy password like 'no_passsword' should be embedded as well. This flag is also
+  incompatible with the ``--static-challenge`` option and legacy ``dynamic challenge``
+  protocol.
+
   The server configuration must specify an ``--auth-user-pass-verify``
   script to verify the username/password provided by the client.
 
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 41e2a91..7da4aaf 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -304,6 +304,19 @@
     username "Auth" foo
     password "Auth" bar
 
+  Example 3:
+
+    >PASSWORD:Need 'Auth' username
+
+  OpenVPN needs a --auth-user-pass username.  The
+  management interface client should respond:
+
+    username "Auth" foo
+
+  In this case the user should not be prompted for a password.
+  Support for such username-only prompting is conditional on the
+  client announcing a version >= 4.
+
   The username/password itself can be in quotes, and special
   characters such as double quote or backslash must be escaped,
   for example,
@@ -499,6 +512,7 @@
 Minimum client version required for certain features is listed below:
     >PK_SIGN:[base64]           -- version 2 or greater
     >PK_SIGN:[base64],[alg]     -- version 3 or greater
+    >PASSWORD:Need 'Auth' username -- version 4 or greater
 
 COMMAND -- auth-retry
 ---------------------
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1391aa85..4948b8d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -655,10 +655,10 @@
         enable_auth_user_pass();
 #ifdef ENABLE_MANAGEMENT
         auth_user_pass_setup(c->options.auth_user_pass_file, c->options.auth_user_pass_file_inline,
-                             &c->options.sc_info);
+                             c->options.auth_user_pass_username_only, &c->options.sc_info);
 #else
         auth_user_pass_setup(c->options.auth_user_pass_file, c->options.auth_user_pass_file_inline,
-                             NULL);
+                             c->options.auth_user_pass_username_only, NULL);
 #endif
     }
 }
@@ -3376,6 +3376,7 @@
     }
     to.auth_user_pass_file = options->auth_user_pass_file;
     to.auth_user_pass_file_inline = options->auth_user_pass_file_inline;
+    to.auth_user_pass_username_only = options->auth_user_pass_username_only;
     to.auth_token_generate = options->auth_token_generate;
     to.auth_token_lifetime = options->auth_token_lifetime;
     to.auth_token_renewal = options->auth_token_renewal;
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index d26c9b2..9e77031 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -58,9 +58,6 @@
 #define MANAGEMENT_ECHO_FLAGS 0
 #endif
 
-/* tag for blank username/password */
-static const char blank_up[] = "[[BLANK]]";
-
 /*
  * Management client versions indicating feature support in client.
  * Append new values as needed but do not change exisiting ones.
@@ -70,6 +67,7 @@
     MCV_DEFAULT = 1,
     MCV_PKSIGN = 2,
     MCV_PKSIGN_ALG = 3,
+    MCV_USERNAME_ONLY = 4,
 };
 
 struct management *management; /* GLOBAL */
@@ -740,6 +738,13 @@
 {
     switch (man->connection.up_query_mode)
     {
+        case UP_QUERY_USERNAME:
+            if (strlen(man->connection.up_query.username))
+            {
+                man->connection.up_query.defined = true;
+            }
+            break;
+
         case UP_QUERY_USER_PASS:
             if (!strlen(man->connection.up_query.username))
             {
@@ -794,7 +799,9 @@
 man_query_username(struct management *man, const char *type, const char *string)
 {
     const bool needed =
-        ((man->connection.up_query_mode == UP_QUERY_USER_PASS) && man->connection.up_query_type);
+        ((man->connection.up_query_mode == UP_QUERY_USER_PASS
+          || man->connection.up_query_mode == UP_QUERY_USERNAME)
+         && man->connection.up_query_type);
     man_query_user_pass(man, type, string, needed, "username", man->connection.up_query.username,
                         USER_PASS_LEN);
 }
@@ -3558,6 +3565,12 @@
             prefix = "PASSWORD";
             alert_type = "password";
         }
+        else if ((man->connection.client_version >= MCV_USERNAME_ONLY) && (flags & GET_USER_PASS_USERNAME_ONLY))
+        {
+            up_query_mode = UP_QUERY_USERNAME;
+            prefix = "PASSWORD";
+            alert_type = "username";
+        }
         else
         {
             up_query_mode = UP_QUERY_USER_PASS;
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 38f437f..e5ad23f 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -264,6 +264,7 @@
 #define UP_QUERY_PASS      2
 #define UP_QUERY_NEED_OK   3
 #define UP_QUERY_NEED_STR  4
+#define UP_QUERY_USERNAME  5
 
 /* states */
 #define MS_INITIAL       0 /* all sockets are closed */
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 9ff281c..c00a3ce 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -215,7 +215,6 @@
         {
             msg(M_WARN, "Note: previous '%s' credentials failed", prefix);
         }
-
 #ifdef ENABLE_MANAGEMENT
         /*
          * Get username/password from management interface?
@@ -389,7 +388,7 @@
                     query_user_add(BSTR(&user_prompt), up->username, USER_PASS_LEN, true);
                 }
 
-                if (password_from_stdin)
+                if (password_from_stdin && !(flags & GET_USER_PASS_USERNAME_ONLY))
                 {
                     query_user_add(BSTR(&pass_prompt), up->password, USER_PASS_LEN, false);
                 }
@@ -451,6 +450,12 @@
             }
         }
 
+        /* Use tag for blank password if we are not prompting for one */
+        if (flags & GET_USER_PASS_USERNAME_ONLY)
+        {
+            strncpy(up->password, blank_up, sizeof(up->password));
+        }
+
         string_mod(up->username, CC_PRINT, CC_CRLF, 0);
         string_mod(up->password, CC_PRINT, CC_CRLF, 0);
 
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index e9cfadb..76bcac3 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -48,6 +48,9 @@
  * Get and store a username/password
  */
 
+/* tag for blank username/password */
+static const char blank_up[] = "[[BLANK]]";
+
 struct user_pass
 {
     bool defined;
@@ -123,6 +126,8 @@
 #define GET_USER_PASS_INLINE_CREDS            (1 << 10)
 /** indicates password and response should be concatenated */
 #define GET_USER_PASS_STATIC_CHALLENGE_CONCAT (1 << 11)
+/** indicate that only username should be prompted for auth-user-pass */
+#define GET_USER_PASS_USERNAME_ONLY           (1 << 12)
 
 /**
  * Retrieves the user credentials from various sources depending on the flags.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fdbc678..d266c3e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -510,7 +510,8 @@
     "                  up is a file containing the username on the first line,\n"
     "                  and a password on the second. If either the password or both\n"
     "                  the username and the password are omitted OpenVPN will prompt\n"
-    "                  for them from console.\n"
+    "                  for them from console. If [up] is 'username-only', only username\n"
+    "                  will be prompted for from console or management interface.\n"
     "--pull           : Accept certain config file options from the peer as if they\n"
     "                  were part of the local config file.  Must be specified\n"
     "                  when connecting to a '--mode server' remote host.\n"
@@ -3909,6 +3910,12 @@
     {
         o->auth_token_renewal = o->renegotiate_seconds;
     }
+#if ENABLE_MANAGEMENT
+    if (o->auth_user_pass_username_only && o->sc_info.challenge_text)
+    {
+        msg(M_USAGE, "'auth-user-pass username-only' cannot be used with static challenge");
+    }
+#endif
     pre_connect_save(o);
 }
 
@@ -7705,7 +7712,13 @@
     else if (streq(p[0], "auth-user-pass") && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);
-        if (p[1])
+        options->auth_user_pass_username_only = false;
+        if (p[1] && streq(p[1], "username-only"))
+        {
+            options->auth_user_pass_username_only = true;
+            options->auth_user_pass_file = "stdin";
+        }
+        else if (p[1])
         {
             options->auth_user_pass_file = p[1];
             options->auth_user_pass_file_inline = is_inline;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 3d8b505..f4a36fc 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -557,6 +557,7 @@
     unsigned int push_update_options_found; /* tracks which option types have been reset in current PUSH_UPDATE sequence */
     const char *auth_user_pass_file;
     bool auth_user_pass_file_inline;
+    bool auth_user_pass_username_only;
     struct options_pre_connect *pre_connect;
 
     int scheduled_exit_interval;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 69d0e4e..962f5df 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -290,7 +290,8 @@
 }
 
 void
-auth_user_pass_setup(const char *auth_file, bool is_inline, const struct static_challenge_info *sci)
+auth_user_pass_setup(const char *auth_file, bool is_inline, bool username_only,
+                     const struct static_challenge_info *sci)
 {
     unsigned int flags = GET_USER_PASS_MANAGEMENT;
 
@@ -298,6 +299,10 @@
     {
         flags |= GET_USER_PASS_INLINE_CREDS;
     }
+    if (username_only)
+    {
+        flags |= GET_USER_PASS_USERNAME_ONLY;
+    }
 
     if (!auth_user_pass.defined && !auth_token.defined)
     {
@@ -2099,10 +2104,12 @@
     {
 #ifdef ENABLE_MANAGEMENT
         auth_user_pass_setup(session->opt->auth_user_pass_file,
-                             session->opt->auth_user_pass_file_inline, session->opt->sci);
+                             session->opt->auth_user_pass_file_inline,
+                             session->opt->auth_user_pass_username_only, session->opt->sci);
 #else
         auth_user_pass_setup(session->opt->auth_user_pass_file,
-                             session->opt->auth_user_pass_file_inline, NULL);
+                             session->opt->auth_user_pass_file_inline,
+                             session->opt->auth_user_pass_username_only, NULL);
 #endif
         struct user_pass *up = &auth_user_pass;
 
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 28a3b78..5822336 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -389,7 +389,7 @@
  * credentials stored in the file, however, if is_inline is true then auth_file
  * contains the username/password inline.
  */
-void auth_user_pass_setup(const char *auth_file, bool is_inline,
+void auth_user_pass_setup(const char *auth_file, bool is_inline, bool username_only,
                           const struct static_challenge_info *sc_info);
 
 /*
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index fba01bb..6f310a5 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -396,6 +396,7 @@
     const char *export_peer_cert_dir;
     const char *auth_user_pass_file;
     bool auth_user_pass_file_inline;
+    bool auth_user_pass_username_only;
 
     bool auth_token_generate;  /**< Generate auth-tokens on successful
                                 * user/pass auth,seet via

