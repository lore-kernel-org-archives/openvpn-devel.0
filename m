From: David Sommerseth <davids@...515...>
Date: Fri, 14 Oct 2016 11:45:02 +0200
Message-Id: <1476438302-25307-1-git-send-email-davids@...515...>
In-Reply-To: <1476388771-16492-3-git-send-email-davids@...515...>
References: <1476388771-16492-3-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] auth-gen-token: Add --auth-gen-token option
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

This sets the flag if the OpenVPN server should create authentication
tokens on-the-fly on successful --auth-user-pass-verify or --plugin with
OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY processing.

If an OpenVPN server is running without this option, it should behave
as before.  Next patches will implement the auth-token generation and
passing it on to the clients.

The --auth-gen-token can be given an optional integer argument which
defines the lifetime of generated tokens.  The lifetime argument
must be given in number of seconds.

  v2 - Update Changes.rst
     - Improve man page in regards to lifetime argument
     - Rename struct member auth_generate_token to auth_token_generate
       to have a consistent naming scheme

Signed-off-by: David Sommerseth <davids@...515...>
---
 Changes.rst              | 15 +++++++++++++++
 doc/openvpn.8            | 22 ++++++++++++++++++++++
 src/openvpn/init.c       |  2 ++
 src/openvpn/options.c    | 16 ++++++++++++++++
 src/openvpn/options.h    |  2 ++
 src/openvpn/ssl_common.h |  3 +++
 6 files changed, 60 insertions(+)

diff --git a/Changes.rst b/Changes.rst
index 9fcba75..fa9bf7e 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -62,6 +62,21 @@ Cipher negotiation
     to use that cipher.  Data channel cipher negotiation can be controlled
     using --ncp-ciphers and --ncp-disable.
 
+Authentication tokens
+    In situations where it is not suitable to save users passwords on the client
+    OpenVPN have since v2.3 had support for --auth-token.  This option is
+    pushed from the server to the client with a token value to be used instead
+    of the users password.  For this to work, the authentication plug-in would
+    need to implement this support as well.  In OpenVPN 2.4 --auth-gen-token
+    is introduced, which will allow the OpenVPN server to generate a random
+    token and push it to the client without any changes to the authentication
+    modules.  When the clients need to re-authenticate the OpenVPN server will
+    instead of sending the re-authentication request to the authentication
+    module do the authentication internally.  This feature is especially
+    useful in configurations which adds One Time Password (OTP) authentication
+    schemes, as this allows the tunnel to be renegotiated regularly without
+    any need to supply new OTP codes.
+
 
 User-visible Changes
 --------------------
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 1c341ae..24d0ab3 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3595,6 +3595,28 @@ For a sample script that performs PAM authentication, see
 in the OpenVPN source distribution.
 .\"*********************************************************
 .TP
+.B \-\-auth\-gen\-token [lifetime]
+After successful user/password authentication, the OpenVPN
+server will with this option generate a temporary
+authentication token and push that to client.  On the following
+renegotiations, the OpenVPN client will pass this token instead
+of the users password.  On the server side the server will do
+the token authentication internally and it will NOT do any
+additional authentications against configured external
+user/password authentication mechanisms.
+
+The
+.B lifetime
+argument defines how long the generated token is valid.  The
+lifetime is defined in seconds.  If lifetime is not set
+or it is set to 0, the token will never expire.
+
+This feature is useful for environments which is configured
+to use One Time Passwords (OTP) as part of the user/password
+authentications and that authentication mechanism does not
+implement any auth-token support.
+.\"*********************************************************
+.TP
 .B \-\-opt\-verify
 Clients that connect with options that are incompatible
 with those of the server will be disconnected.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index cc8e945..65bcb2a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2427,6 +2427,8 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   if (options->ccd_exclusive)
     to.client_config_dir_exclusive = options->client_config_dir;
   to.auth_user_pass_file = options->auth_user_pass_file;
+  to.auth_token_generate = options->auth_token_generate;
+  to.auth_token_lifetime = options->auth_token_lifetime;
 #endif
 
   to.x509_track = options->x509_track;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1ed14b0..b6adf55 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -445,6 +445,11 @@ static const char usage_message[] =
   "                  run command cmd to verify.  If method='via-env', pass\n"
   "                  user/pass via environment, if method='via-file', pass\n"
   "                  user/pass via temporary file.\n"
+  "--auth-gen-token  [lifetime] Generate a random authentication token which is pushed\n"
+  "                  to each client, replacing the password.  Usefull when\n"
+  "                  OTP based two-factor auth mechanisms are in use and\n"
+  "                  --reneg-* options are enabled. Optionally a lifetime in seconds\n"
+  "                  for generated tokens can be set.\n"
   "--opt-verify    : Clients that connect with options that are incompatible\n"
   "                  with those of the server will be disconnected.\n"
   "--auth-user-pass-optional : Allow connections by clients that don't\n"
@@ -864,6 +869,7 @@ init_options (struct options *o, const bool init_gc)
 #ifdef ENABLE_PKCS11
   o->pkcs11_pin_cache_period = -1;
 #endif			/* ENABLE_PKCS11 */
+  o->auth_token_generate = false;
 
 /* tmp is only used in P2MP server context */
 #if P2MP_SERVER
@@ -1264,6 +1270,8 @@ show_p2mp_parms (const struct options *o)
   SHOW_INT (max_routes_per_client);
   SHOW_STR (auth_user_pass_verify_script);
   SHOW_BOOL (auth_user_pass_verify_script_via_file);
+  SHOW_BOOL (auth_token_generate);
+  SHOW_INT (auth_token_lifetime);
 #if PORT_SHARE
   SHOW_STR (port_share_host);
   SHOW_STR (port_share_port);
@@ -2194,6 +2202,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
              "tcp-nodelay in the server configuration instead.");
       if (options->auth_user_pass_verify_script)
 	msg (M_USAGE, "--auth-user-pass-verify requires --mode server");
+      if (options->auth_token_generate)
+	msg (M_USAGE, "--auth-gen-token requires --mode server");
 #if PORT_SHARE
       if (options->port_share_host || options->port_share_port)
 	msg (M_USAGE, "--port-share requires TCP server mode (--mode server --proto tcp-server)");
@@ -5973,6 +5983,12 @@ add_option (struct options *options,
 		       &options->auth_user_pass_verify_script,
 		       p[1], "auth-user-pass-verify", true);
     }
+  else if (streq (p[0], "auth-gen-token"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->auth_token_generate = true;
+      options->auth_token_lifetime = p[1] ? positive_atoi (p[1]) : 0;
+    }
   else if (streq (p[0], "client-connect") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_SCRIPT);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 9b7b57c..e6b7dbe 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -443,6 +443,8 @@ struct options
 
   const char *auth_user_pass_verify_script;
   bool auth_user_pass_verify_script_via_file;
+  bool auth_token_generate;
+  unsigned int auth_token_lifetime;
 #if PORT_SHARE
   char *port_share_host;
   char *port_share_port;
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index eb2ad6f..50c4a9c 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -289,6 +289,9 @@ struct tls_options
   bool auth_user_pass_verify_script_via_file;
   const char *tmp_dir;
   const char *auth_user_pass_file;
+  bool auth_token_generate;     /**< Generate auth-tokens on successful user/pass auth,
+                                 *   set via options->auth_token_generate. */
+  unsigned int auth_token_lifetime;
 
   /* use the client-config-dir as a positive authenticator */
   const char *client_config_dir_exclusive;
-- 
1.8.3.1


