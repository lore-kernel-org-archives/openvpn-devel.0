From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 26 Aug 2022 10:54:27 +0200
Message-Id: <20220826085427.25302-7-frank@...2641...>
In-Reply-To: <20220826085427.25302-1-frank@...2641...>
References: <20220826085427.25302-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 6/6] reformat for sp_arith=add
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

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 include/openvpn-plugin.h.in                   |   2 +-
 .../client-connect/sample-client-connect.c    |  30 +--
 sample/sample-plugins/defer/multi-auth.c      |  10 +-
 sample/sample-plugins/log/log.c               |  18 +-
 sample/sample-plugins/log/log_v3.c            |  18 +-
 sample/sample-plugins/simple/base64.c         |   2 +-
 src/compat/compat-gettimeofday.c              |   2 +-
 src/compat/compat-versionhelpers.h            |   2 +-
 src/openvpn/auth_token.c                      |  22 +-
 src/openvpn/basic.h                           |   2 +-
 src/openvpn/buffer.c                          |   2 +-
 src/openvpn/buffer.h                          |  74 +++----
 src/openvpn/common.h                          |   2 +-
 src/openvpn/comp.h                            |  18 +-
 src/openvpn/console_builtin.c                 |   2 +-
 src/openvpn/crypto.c                          |   2 +-
 src/openvpn/crypto.h                          |  16 +-
 src/openvpn/crypto_mbedtls.c                  |  16 +-
 src/openvpn/crypto_openssl.c                  |   6 +-
 src/openvpn/cryptoapi.c                       |  34 +--
 src/openvpn/dco.c                             |   2 +-
 src/openvpn/dco_freebsd.c                     |   4 +-
 src/openvpn/dco_linux.c                       |   2 +-
 src/openvpn/error.c                           |  12 +-
 src/openvpn/error.h                           |  26 +--
 src/openvpn/event.c                           |  14 +-
 src/openvpn/event.h                           |   4 +-
 src/openvpn/forward.c                         |   8 +-
 src/openvpn/forward.h                         |  44 ++--
 src/openvpn/gremlin.h                         |  10 +-
 src/openvpn/httpdigest.c                      |   8 +-
 src/openvpn/init.c                            |  38 ++--
 src/openvpn/init.h                            |  16 +-
 src/openvpn/list.c                            |  18 +-
 src/openvpn/list.h                            |   2 +-
 src/openvpn/manage.c                          |  44 ++--
 src/openvpn/manage.h                          |  74 +++----
 src/openvpn/mbuf.h                            |   2 +-
 src/openvpn/misc.c                            |   4 +-
 src/openvpn/misc.h                            |  28 +--
 src/openvpn/mroute.h                          |  26 +--
 src/openvpn/mss.c                             |   6 +-
 src/openvpn/mstats.c                          |   2 +-
 src/openvpn/mtcp.c                            |  10 +-
 src/openvpn/mtu.c                             |   2 +-
 src/openvpn/mudp.c                            |   4 +-
 src/openvpn/multi.c                           |  14 +-
 src/openvpn/multi.h                           |  16 +-
 src/openvpn/ntlm.c                            |   2 +-
 src/openvpn/openssl_compat.h                  |   2 +-
 src/openvpn/openvpn.h                         |   6 +-
 src/openvpn/options.c                         | 198 +++++++++---------
 src/openvpn/options.h                         |  74 +++----
 src/openvpn/perf.c                            |   2 +-
 src/openvpn/pkcs11.c                          |  14 +-
 src/openvpn/pkcs11_openssl.c                  |   2 +-
 src/openvpn/platform.c                        |   8 +-
 src/openvpn/plugin.c                          |   4 +-
 src/openvpn/pool.c                            |   2 +-
 src/openvpn/proto.h                           |  16 +-
 src/openvpn/ps.c                              |  10 +-
 src/openvpn/push.c                            |   4 +-
 src/openvpn/reliable.c                        |   2 +-
 src/openvpn/route.c                           |  22 +-
 src/openvpn/route.h                           |  50 ++---
 src/openvpn/run_command.h                     |   6 +-
 src/openvpn/shaper.h                          |   4 +-
 src/openvpn/socket.c                          |  28 +--
 src/openvpn/socket.h                          |  56 ++---
 src/openvpn/ssl.c                             |   6 +-
 src/openvpn/ssl.h                             |  18 +-
 src/openvpn/ssl_common.h                      |  20 +-
 src/openvpn/ssl_mbedtls.c                     |  22 +-
 src/openvpn/ssl_openssl.c                     |  12 +-
 src/openvpn/ssl_pkt.c                         |   2 +-
 src/openvpn/ssl_verify.c                      |   2 +-
 src/openvpn/ssl_verify.h                      |   8 +-
 src/openvpn/ssl_verify_openssl.c              |   4 +-
 src/openvpn/status.c                          |   4 +-
 src/openvpn/status.h                          |   4 +-
 src/openvpn/syshead.h                         |   2 +-
 src/openvpn/tls_crypt.c                       |   2 +-
 src/openvpn/tls_crypt.h                       |   4 +-
 src/openvpn/tun.c                             |  20 +-
 src/openvpn/win32.c                           |  24 +--
 src/openvpn/win32.h                           |   4 +-
 src/openvpn/xkey_common.h                     |   2 +-
 src/openvpn/xkey_provider.c                   |   4 +-
 src/openvpnmsica/openvpnmsica.c               |   6 +-
 src/openvpnserv/common.c                      |   2 +-
 src/openvpnserv/interactive.c                 |  18 +-
 src/openvpnserv/service.h                     |   6 +-
 src/plugins/auth-pam/auth-pam.c               |  32 +--
 src/plugins/auth-pam/pamdl.c                  |   2 +-
 src/tapctl/basic.h                            |   2 +-
 src/tapctl/error.h                            |  28 +--
 src/tapctl/main.c                             |   2 +-
 tests/unit_tests/openvpn/test_auth_token.c    |  26 +--
 tests/unit_tests/openvpn/test_buffer.c        |   8 +-
 tests/unit_tests/openvpn/test_pkt.c           |   4 +-
 tests/unit_tests/openvpn/test_provider.c      |   4 +-
 101 files changed, 768 insertions(+), 768 deletions(-)

diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index dc7c5306..5e64f9bb 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -133,7 +133,7 @@ extern "C" {
 /*
  * Build a mask out of a set of plug-in types.
  */
-#define OPENVPN_PLUGIN_MASK(x) (1<<(x))
+#define OPENVPN_PLUGIN_MASK(x) (1 << (x))
 
 /*
  * A pointer to a plugin-defined object which contains
diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b/sample/sample-plugins/client-connect/sample-client-connect.c
index 27d676ef..f07cee99 100644
--- a/sample/sample-plugins/client-connect/sample-client-connect.c
+++ b/sample/sample-plugins/client-connect/sample-client-connect.c
@@ -147,16 +147,16 @@ openvpn_plugin_open_v3(const int v3structver,
      */
     ret->type_mask =
         OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_UP)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_DOWN)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_ROUTE_UP)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_IPCHANGE)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_VERIFY)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT_V2)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_DISCONNECT)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_LEARN_ADDRESS)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_FINAL);
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_DOWN)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_ROUTE_UP)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_IPCHANGE)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_VERIFY)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT_V2)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_DISCONNECT)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_LEARN_ADDRESS)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_FINAL);
 
     /* Save global pointers to functions exported from openvpn */
     plugin_log = args->callbacks->plugin_log;
@@ -259,13 +259,13 @@ cc_handle_deferred_v1(int seconds, const char *name, const char **envp)
     int fd = open(ccd_file, O_WRONLY);
     if (fd < 0)
     {
-        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "open('%s') failed", ccd_file);
+        plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "open('%s') failed", ccd_file);
         return OPENVPN_PLUGIN_FUNC_ERROR;
     }
 
     if (write(fd, "2", 1) != 1)
     {
-        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "write to '%s' failed", ccd_file );
+        plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "write to '%s' failed", ccd_file );
         close(fd);
         return OPENVPN_PLUGIN_FUNC_ERROR;
     }
@@ -293,7 +293,7 @@ cc_handle_deferred_v1(int seconds, const char *name, const char **envp)
     pid_t p2 = fork();
     if (p2 < 0)
     {
-        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: fork(2) failed");
+        plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "BACKGROUND: fork(2) failed");
         exit(1);
     }
     if (p2 > 0)                 /* new parent: exit right away */
@@ -326,7 +326,7 @@ cc_handle_deferred_v1(int seconds, const char *name, const char **envp)
     fd = open(ccd_file, O_WRONLY);
     if (fd < 0)
     {
-        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "open('%s') failed", ccd_file);
+        plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "open('%s') failed", ccd_file);
         exit(1);
     }
 
@@ -335,7 +335,7 @@ cc_handle_deferred_v1(int seconds, const char *name, const char **envp)
 
     if (write(fd, (ret == OPENVPN_PLUGIN_FUNC_SUCCESS) ? "1" : "0", 1) != 1)
     {
-        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "write to '%s' failed", ccd_file );
+        plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "write to '%s' failed", ccd_file );
     }
     close(fd);
 
diff --git a/sample/sample-plugins/defer/multi-auth.c b/sample/sample-plugins/defer/multi-auth.c
index c2672981..b3e76215 100644
--- a/sample/sample-plugins/defer/multi-auth.c
+++ b/sample/sample-plugins/defer/multi-auth.c
@@ -318,7 +318,7 @@ auth_user_pass_verify(struct plugin_context *context,
     pid_t p2 = fork();
     if (p2 < 0)
     {
-        plog(context, PLOG_ERR|PLOG_ERRNO, "BACKGROUND: fork(2) failed");
+        plog(context, PLOG_ERR | PLOG_ERRNO, "BACKGROUND: fork(2) failed");
         exit(1);
     }
 
@@ -335,14 +335,14 @@ auth_user_pass_verify(struct plugin_context *context,
 
     /* do mighty complicated work that will really take time here... */
     plog(context, PLOG_NOTE, "in async/deferred handler, usleep(%d)",
-         context->test_deferred_auth*1000);
-    usleep(context->test_deferred_auth*1000);
+         context->test_deferred_auth * 1000);
+    usleep(context->test_deferred_auth * 1000);
 
     /* now signal success state to openvpn */
     int fd = open(auth_control_file, O_WRONLY);
     if (fd < 0)
     {
-        plog(context, PLOG_ERR|PLOG_ERRNO,
+        plog(context, PLOG_ERR | PLOG_ERRNO,
              "open('%s') failed", auth_control_file);
         exit(1);
     }
@@ -355,7 +355,7 @@ auth_user_pass_verify(struct plugin_context *context,
 
     if (write(fd, result, 1) != 1)
     {
-        plog(context, PLOG_ERR|PLOG_ERRNO, "write to '%s' failed", auth_control_file );
+        plog(context, PLOG_ERR | PLOG_ERRNO, "write to '%s' failed", auth_control_file );
     }
     close(fd);
 
diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/log.c
index 2adbb2df..1f7a7e3f 100644
--- a/sample/sample-plugins/log/log.c
+++ b/sample/sample-plugins/log/log.c
@@ -95,15 +95,15 @@ openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const char *
      */
     *type_mask =
         OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_UP)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_DOWN)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_ROUTE_UP)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_IPCHANGE)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_VERIFY)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT_V2)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_DISCONNECT)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_LEARN_ADDRESS)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_FINAL);
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_DOWN)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_ROUTE_UP)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_IPCHANGE)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_VERIFY)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT_V2)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_DISCONNECT)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_LEARN_ADDRESS)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_FINAL);
 
     return (openvpn_plugin_handle_t) context;
 }
diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log/log_v3.c
index 5f569c92..9d1eb0a5 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -100,15 +100,15 @@ openvpn_plugin_open_v3(const int v3structver,
     /*  Which callbacks to intercept.  */
     ret->type_mask =
         OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_UP)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_DOWN)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_ROUTE_UP)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_IPCHANGE)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_VERIFY)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT_V2)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_DISCONNECT)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_LEARN_ADDRESS)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_FINAL);
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_DOWN)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_ROUTE_UP)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_IPCHANGE)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_VERIFY)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT_V2)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_DISCONNECT)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_LEARN_ADDRESS)
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_FINAL);
 
 
     /* Allocate our context */
diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/simple/base64.c
index e94ee963..ac96ef65 100644
--- a/sample/sample-plugins/simple/base64.c
+++ b/sample/sample-plugins/simple/base64.c
@@ -110,7 +110,7 @@ openvpn_plugin_open_v3(const int v3structver,
     /*  Which callbacks to intercept.  */
     ret->type_mask =
         OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_VERIFY)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT_V2);
+        | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT_V2);
 
     /* we don't need a plug-in context in this example, but OpenVPN expects "something" */
     ret->handle = calloc(1, 1);
diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeofday.c
index f2f91ba6..a63f76db 100644
--- a/src/compat/compat-gettimeofday.c
+++ b/src/compat/compat-gettimeofday.c
@@ -51,7 +51,7 @@ gettimeofday_calibrate(void)
 {
     const time_t t = time(NULL);
     const DWORD gtc = GetTickCount();
-    gtc_base = t - gtc/1000;
+    gtc_base = t - gtc / 1000;
     gtc_last = gtc;
 }
 
diff --git a/src/compat/compat-versionhelpers.h b/src/compat/compat-versionhelpers.h
index b071602b..8b91a7e6 100644
--- a/src/compat/compat-versionhelpers.h
+++ b/src/compat/compat-versionhelpers.h
@@ -26,7 +26,7 @@ VERSIONHELPERAPI
 IsWindowsVersionOrGreater(WORD major, WORD minor, WORD servpack)
 {
     OSVERSIONINFOEXW vi = {sizeof(vi), major, minor, 0, 0, {0}, servpack};
-    return VerifyVersionInfoW(&vi, VER_MAJORVERSION|VER_MINORVERSION|VER_SERVICEPACKMAJOR,
+    return VerifyVersionInfoW(&vi, VER_MAJORVERSION | VER_MINORVERSION | VER_SERVICEPACKMAJOR,
                               VerSetConditionMask(VerSetConditionMask(VerSetConditionMask(0,
                                                                                           VER_MAJORVERSION, VER_GREATER_EQUAL),
                                                                       VER_MINORVERSION, VER_GREATER_EQUAL),
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index b5f9f6dd..6a2a7c83 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -55,7 +55,7 @@ add_session_token_env(struct tls_session *session, struct tls_multi *multi,
     }
     else if (auth_token_state_flags & AUTH_TOKEN_HMAC_OK)
     {
-        switch (auth_token_state_flags & (AUTH_TOKEN_VALID_EMPTYUSER|AUTH_TOKEN_EXPIRED))
+        switch (auth_token_state_flags & (AUTH_TOKEN_VALID_EMPTYUSER | AUTH_TOKEN_EXPIRED))
         {
             case 0:
                 state = "Authenticated";
@@ -109,9 +109,9 @@ add_session_token_env(struct tls_session *session, struct tls_multi *multi,
      * in the encoding
      */
 
-    char session_id[AUTH_TOKEN_SESSION_ID_LEN*2] = {0};
+    char session_id[AUTH_TOKEN_SESSION_ID_LEN * 2] = {0};
     memcpy(session_id, session_id_source + strlen(SESSION_ID_PREFIX),
-           AUTH_TOKEN_SESSION_ID_LEN*8/6);
+           AUTH_TOKEN_SESSION_ID_LEN * 8 / 6);
 
     setenv_str(session->opt->es, "session_id", session_id);
 }
@@ -168,7 +168,7 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
     int64_t initial_timestamp = timestamp;
 
     hmac_ctx_t *ctx = multi->opt.auth_token_key.hmac;
-    ASSERT(hmac_ctx_size(ctx) == 256/8);
+    ASSERT(hmac_ctx_size(ctx) == 256 / 8);
 
     uint8_t sessid[AUTH_TOKEN_SESSION_ID_LEN];
 
@@ -184,7 +184,7 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
         char *initial_token_copy = string_alloc(multi->auth_token_initial, &gc);
 
         char *old_sessid = initial_token_copy + strlen(SESSION_ID_PREFIX);
-        char *old_tsamp_initial = old_sessid + AUTH_TOKEN_SESSION_ID_LEN*8/6;
+        char *old_tsamp_initial = old_sessid + AUTH_TOKEN_SESSION_ID_LEN * 8 / 6;
 
         /*
          * We null terminate the old token just after the session ID to let
@@ -215,7 +215,7 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
      * with \0 in them is asking for troubles in so many ways anyway that we
      * ignore that corner case here
      */
-    uint8_t hmac_output[256/8];
+    uint8_t hmac_output[256 / 8];
 
     hmac_ctx_reset(ctx);
 
@@ -240,7 +240,7 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
 
     /* Construct the unencoded session token */
     struct buffer token = alloc_buf_gc(
-        2*sizeof(uint64_t) + AUTH_TOKEN_SESSION_ID_LEN + 256/8, &gc);
+        2 * sizeof(uint64_t) + AUTH_TOKEN_SESSION_ID_LEN + 256 / 8, &gc);
 
     ASSERT(buf_write(&token, sessid, sizeof(sessid)));
     ASSERT(buf_write(&token, &initial_timestamp, sizeof(initial_timestamp)));
@@ -282,16 +282,16 @@ generate_auth_token(const struct user_pass *up, struct tls_multi *multi)
 static bool
 check_hmac_token(hmac_ctx_t *ctx, const uint8_t *b64decoded, const char *username)
 {
-    ASSERT(hmac_ctx_size(ctx) == 256/8);
+    ASSERT(hmac_ctx_size(ctx) == 256 / 8);
 
-    uint8_t hmac_output[256/8];
+    uint8_t hmac_output[256 / 8];
 
     hmac_ctx_reset(ctx);
     hmac_ctx_update(ctx, (uint8_t *) username, (int)strlen(username));
-    hmac_ctx_update(ctx, b64decoded, TOKEN_DATA_LEN - 256/8);
+    hmac_ctx_update(ctx, b64decoded, TOKEN_DATA_LEN - 256 / 8);
     hmac_ctx_final(ctx, hmac_output);
 
-    const uint8_t *hmac = b64decoded + TOKEN_DATA_LEN - 256/8;
+    const uint8_t *hmac = b64decoded + TOKEN_DATA_LEN - 256 / 8;
     return memcmp_constant_time(&hmac_output, hmac, 32) == 0;
 }
 
diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index f33ce875..09bcf161 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -27,7 +27,7 @@
 #define BOOL_CAST(x) ((x) ? (true) : (false))
 
 /* size of an array */
-#define SIZE(x) (sizeof(x)/sizeof(x[0]))
+#define SIZE(x) (sizeof(x) / sizeof(x[0]))
 
 /* clear an object (may be optimized away, use secure_memzero() to erase secrets) */
 #define CLEAR(x) memset(&(x), 0, sizeof(x))
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index d3a299e5..0647fa1c 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -573,7 +573,7 @@ buf_chomp(struct buffer *buf)
         {
             break;
         }
-        if (char_class(*last, CC_CRLF|CC_NULL))
+        if (char_class(*last, CC_CRLF | CC_NULL))
         {
             if (!buf_inc_len(buf, -1))
             {
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 25c484b2..d8af4d28 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -141,7 +141,7 @@ int string_array_len(const char **array);
 
 size_t array_mult_safe(const size_t m1, const size_t m2, const size_t extra);
 
-#define PA_BRACKET (1<<0)
+#define PA_BRACKET (1 << 0)
 char *print_argv(const char **p, struct gc_arena *gc, const unsigned int flags);
 
 void buf_size_error(const size_t size);
@@ -887,44 +887,44 @@ const char *np(const char *str);
 
 /* character classes */
 
-#define CC_ANY                (1<<0)
-#define CC_NULL               (1<<1)
-
-#define CC_ALNUM              (1<<2)
-#define CC_ALPHA              (1<<3)
-#define CC_ASCII              (1<<4)
-#define CC_CNTRL              (1<<5)
-#define CC_DIGIT              (1<<6)
-#define CC_PRINT              (1<<7)
-#define CC_PUNCT              (1<<8)
-#define CC_SPACE              (1<<9)
-#define CC_XDIGIT             (1<<10)
-
-#define CC_BLANK              (1<<11)
-#define CC_NEWLINE            (1<<12)
-#define CC_CR                 (1<<13)
-
-#define CC_BACKSLASH          (1<<14)
-#define CC_UNDERBAR           (1<<15)
-#define CC_DASH               (1<<16)
-#define CC_DOT                (1<<17)
-#define CC_COMMA              (1<<18)
-#define CC_COLON              (1<<19)
-#define CC_SLASH              (1<<20)
-#define CC_SINGLE_QUOTE       (1<<21)
-#define CC_DOUBLE_QUOTE       (1<<22)
-#define CC_REVERSE_QUOTE      (1<<23)
-#define CC_AT                 (1<<24)
-#define CC_EQUAL              (1<<25)
-#define CC_LESS_THAN          (1<<26)
-#define CC_GREATER_THAN       (1<<27)
-#define CC_PIPE               (1<<28)
-#define CC_QUESTION_MARK      (1<<29)
-#define CC_ASTERISK           (1<<30)
+#define CC_ANY                (1 << 0)
+#define CC_NULL               (1 << 1)
+
+#define CC_ALNUM              (1 << 2)
+#define CC_ALPHA              (1 << 3)
+#define CC_ASCII              (1 << 4)
+#define CC_CNTRL              (1 << 5)
+#define CC_DIGIT              (1 << 6)
+#define CC_PRINT              (1 << 7)
+#define CC_PUNCT              (1 << 8)
+#define CC_SPACE              (1 << 9)
+#define CC_XDIGIT             (1 << 10)
+
+#define CC_BLANK              (1 << 11)
+#define CC_NEWLINE            (1 << 12)
+#define CC_CR                 (1 << 13)
+
+#define CC_BACKSLASH          (1 << 14)
+#define CC_UNDERBAR           (1 << 15)
+#define CC_DASH               (1 << 16)
+#define CC_DOT                (1 << 17)
+#define CC_COMMA              (1 << 18)
+#define CC_COLON              (1 << 19)
+#define CC_SLASH              (1 << 20)
+#define CC_SINGLE_QUOTE       (1 << 21)
+#define CC_DOUBLE_QUOTE       (1 << 22)
+#define CC_REVERSE_QUOTE      (1 << 23)
+#define CC_AT                 (1 << 24)
+#define CC_EQUAL              (1 << 25)
+#define CC_LESS_THAN          (1 << 26)
+#define CC_GREATER_THAN       (1 << 27)
+#define CC_PIPE               (1 << 28)
+#define CC_QUESTION_MARK      (1 << 29)
+#define CC_ASTERISK           (1 << 30)
 
 /* macro classes */
-#define CC_NAME               (CC_ALNUM|CC_UNDERBAR)
-#define CC_CRLF               (CC_CR|CC_NEWLINE)
+#define CC_NAME               (CC_ALNUM | CC_UNDERBAR)
+#define CC_CRLF               (CC_CR | CC_NEWLINE)
 
 bool char_class(const unsigned char c, const unsigned int flags);
 
diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index b9468088..8f8d2f95 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -38,7 +38,7 @@ typedef int interval_t;
 /*
  * Used as an upper bound for timeouts.
  */
-#define BIG_TIMEOUT  (60*60*24*7)  /* one week (in seconds) */
+#define BIG_TIMEOUT  (60 * 60 * 24 * 7)  /* one week (in seconds) */
 
 /*
  * Printf formats for special types
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 874036dc..8e93badf 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -52,14 +52,14 @@
  */
 
 /* Compression flags */
-#define COMP_F_ADAPTIVE             (1<<0) /* COMP_ALG_LZO only */
-#define COMP_F_ALLOW_COMPRESS       (1<<1) /* not only downlink is compressed but also uplink */
-#define COMP_F_SWAP                 (1<<2) /* initial command byte is swapped with last byte in buffer to preserve payload alignment */
-#define COMP_F_ADVERTISE_STUBS_ONLY (1<<3) /* tell server that we only support compression stubs */
-#define COMP_F_ALLOW_STUB_ONLY      (1<<4) /* Only accept stub compression, even with COMP_F_ADVERTISE_STUBS_ONLY
-                                            * we still accept other compressions to be pushed */
-#define COMP_F_MIGRATE              (1<<5) /* push stub-v2 or comp-lzo no when we see a client with comp-lzo in occ */
-#define COMP_F_ALLOW_ASYM           (1<<6) /* Compression was explicitly set to allow asymetric compression */
+#define COMP_F_ADAPTIVE             (1 << 0) /* COMP_ALG_LZO only */
+#define COMP_F_ALLOW_COMPRESS       (1 << 1) /* not only downlink is compressed but also uplink */
+#define COMP_F_SWAP                 (1 << 2) /* initial command byte is swapped with last byte in buffer to preserve payload alignment */
+#define COMP_F_ADVERTISE_STUBS_ONLY (1 << 3) /* tell server that we only support compression stubs */
+#define COMP_F_ALLOW_STUB_ONLY      (1 << 4) /* Only accept stub compression, even with COMP_F_ADVERTISE_STUBS_ONLY
+                                              * we still accept other compressions to be pushed */
+#define COMP_F_MIGRATE              (1 << 5) /* push stub-v2 or comp-lzo no when we see a client with comp-lzo in occ */
+#define COMP_F_ALLOW_ASYM           (1 << 6) /* Compression was explicitly set to allow asymetric compression */
 
 
 /*
@@ -92,7 +92,7 @@
  * Snappy: len + len/6 + 32
  * LZ4:    len + len/255 + 16  (LZ4_COMPRESSBOUND(len))
  */
-#define COMP_EXTRA_BUFFER(len) ((len)/6 + 128 + 3 + COMP_PREFIX_LEN)
+#define COMP_EXTRA_BUFFER(len) ((len) / 6 + 128 + 3 + COMP_PREFIX_LEN)
 
 /*
  * Don't try to compress any packet smaller than this.
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 3b97aad9..bc281729 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -74,7 +74,7 @@ get_console_input_win32(const char *prompt, const bool echo, char *input, const
         || win32_service_interrupt(&win32_signal)
         || (_write(orig_stderr, prompt, strlen(prompt)) == -1))
     {
-        msg(M_WARN|M_ERRNO, "get_console_input_win32(): unexpected error");
+        msg(M_WARN | M_ERRNO, "get_console_input_win32(): unexpected error");
         return false;
     }
 
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index d582cc8f..0e360c75 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -734,7 +734,7 @@ warn_insecure_key_type(const char *ciphername)
             "using a --cipher with a larger block size (e.g. AES-256-CBC). "
             "Support for these insecure ciphers will be removed in "
             "OpenVPN 2.7.",
-            ciphername, cipher_kt_block_size(ciphername)*8);
+            ciphername, cipher_kt_block_size(ciphername) * 8);
     }
 }
 
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 98e2c766..5d6d896f 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -240,27 +240,27 @@ struct crypto_options
      *   keeping state between successive
      *   OpenVPN process startups. */
 
-#define CO_PACKET_ID_LONG_FORM  (1<<0)
+#define CO_PACKET_ID_LONG_FORM  (1 << 0)
     /**< Bit-flag indicating whether to use
     *   OpenVPN's long packet ID format. */
-#define CO_IGNORE_PACKET_ID     (1<<1)
+#define CO_IGNORE_PACKET_ID     (1 << 1)
     /**< Bit-flag indicating whether to ignore
      *   the packet ID of a received packet.
      *   This flag is used during processing
      *   of the first packet received from a
      *   client. */
-#define CO_MUTE_REPLAY_WARNINGS (1<<2)
+#define CO_MUTE_REPLAY_WARNINGS (1 << 2)
     /**< Bit-flag indicating not to display
      *   replay warnings. */
-#define CO_USE_TLS_KEY_MATERIAL_EXPORT  (1<<3)
+#define CO_USE_TLS_KEY_MATERIAL_EXPORT  (1 << 3)
     /**< Bit-flag indicating that data channel key derivation
      * is done using TLS keying material export [RFC5705]
      */
-#define CO_RESEND_WKC (1<<4)
+#define CO_RESEND_WKC (1 << 4)
     /**< Bit-flag indicating that the client is expected to
      * resend the wrapped client key with the 2nd packet (packet-id 1)
      * like with the HARD_RESET_CLIENT_V3 packet */
-#define CO_FORCE_TLSCRYPTV2_COOKIE  (1<<5)
+#define CO_FORCE_TLSCRYPTV2_COOKIE  (1 << 5)
     /**< Bit-flag indicating that we do not allow clients that do
      * not support resending the wrapped client key (WKc) with the
      * third packet of the three-way handshake */
@@ -277,8 +277,8 @@ struct crypto_options
  */
 #define OPENVPN_AEAD_MIN_IV_LEN (sizeof(packet_id_type) + 8)
 
-#define RKF_MUST_SUCCEED (1<<0)
-#define RKF_INLINE       (1<<1)
+#define RKF_MUST_SUCCEED (1 << 0)
+#define RKF_INLINE       (1 << 1)
 void read_key_file(struct key2 *key2, const char *file, const unsigned int flags);
 
 /**
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index f036744d..841ffe0a 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -418,11 +418,11 @@ cipher_valid_reason(const char *ciphername, const char **reason)
         return false;
     }
 
-    if (cipher->key_bitlen/8 > MAX_CIPHER_KEY_LENGTH)
+    if (cipher->key_bitlen / 8 > MAX_CIPHER_KEY_LENGTH)
     {
         msg(D_LOW, "Cipher algorithm '%s' uses a default key size (%d bytes) "
             "which is larger than " PACKAGE_NAME "'s current maximum key size "
-            "(%d bytes)", ciphername, cipher->key_bitlen/8, MAX_CIPHER_KEY_LENGTH);
+            "(%d bytes)", ciphername, cipher->key_bitlen / 8, MAX_CIPHER_KEY_LENGTH);
         *reason = "disabled due to key size too large";
         return false;
     }
@@ -453,7 +453,7 @@ cipher_kt_key_size(const char *ciphername)
         return 0;
     }
 
-    return cipher_kt->key_bitlen/8;
+    return cipher_kt->key_bitlen / 8;
 }
 
 int
@@ -568,7 +568,7 @@ cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key,
     CLEAR(*ctx);
 
     const mbedtls_cipher_info_t *kt = cipher_get(ciphername);
-    int key_len = kt->key_bitlen/8;
+    int key_len = kt->key_bitlen / 8;
 
     ASSERT(kt);
 
@@ -577,13 +577,13 @@ cipher_ctx_init(mbedtls_cipher_context_t *ctx, const uint8_t *key,
         msg(M_FATAL, "mbed TLS cipher context init #1");
     }
 
-    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, key_len*8, operation)))
+    if (!mbed_ok(mbedtls_cipher_setkey(ctx, key, key_len * 8, operation)))
     {
         msg(M_FATAL, "mbed TLS cipher set key");
     }
 
     /* make sure we used a big enough key */
-    ASSERT(ctx->key_bitlen <= key_len*8);
+    ASSERT(ctx->key_bitlen <= key_len * 8);
 }
 
 int
@@ -1097,10 +1097,10 @@ ssl_tls1_PRF(const uint8_t *label, int label_len, const uint8_t *sec,
 
     uint8_t *out2 = (uint8_t *)gc_malloc(olen, false, &gc);
 
-    int len = slen/2;
+    int len = slen / 2;
     const uint8_t *S1 = sec;
     const uint8_t *S2 = &(sec[len]);
-    len += (slen&1); /* add for odd, make longer */
+    len += (slen & 1); /* add for odd, make longer */
 
     tls1_P_hash(md5, S1, len, label, label_len, out1, olen);
     tls1_P_hash(sha1, S2, len, label, label_len, out2, olen);
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 5c86268d..7196de25 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -986,7 +986,7 @@ cipher_des_encrypt_ecb(const unsigned char key[DES_KEY_LENGTH],
         crypto_msg(M_FATAL, "%s: EVP_CIPHER_CTX_new() failed", __func__);
     }
 
-    unsigned char key3[DES_KEY_LENGTH*3];
+    unsigned char key3[DES_KEY_LENGTH * 3];
     for (int i = 0; i < 3; i++)
     {
         memcpy(key3 + (i * DES_KEY_LENGTH), key, DES_KEY_LENGTH);
@@ -1615,10 +1615,10 @@ ssl_tls1_PRF(const uint8_t *label, int label_len, const uint8_t *sec,
 
     uint8_t *out2 = (uint8_t *)gc_malloc(olen, false, &gc);
 
-    int len = slen/2;
+    int len = slen / 2;
     const uint8_t *S1 = sec;
     const uint8_t *S2 = &(sec[len]);
-    len += (slen&1); /* add for odd, make longer */
+    len += (slen & 1); /* add for odd, make longer */
 
     if (!tls1_P_hash(md5, S1, len, label, label_len, out1, olen))
     {
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 355a1149..a68c8c84 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -113,7 +113,7 @@ cng_hash_algo(int md_type)
             break;
 
         default:
-            msg(M_WARN|M_INFO, "cryptoapicert: Unknown hash type NID=0x%x", md_type);
+            msg(M_WARN | M_INFO, "cryptoapicert: Unknown hash type NID=0x%x", md_type);
             break;
     }
     return alg;
@@ -170,7 +170,7 @@ cng_padding_type(int padding)
             break;
 
         default:
-            msg(M_WARN|M_INFO, "cryptoapicert: unknown OpenSSL padding type %d.",
+            msg(M_WARN | M_INFO, "cryptoapicert: unknown OpenSSL padding type %d.",
                 padding);
     }
 
@@ -222,7 +222,7 @@ priv_enc_CNG(const CAPI_DATA *cd, const wchar_t *hash_algo, const unsigned char
     if (status != ERROR_SUCCESS)
     {
         SetLastError(status);
-        msg(M_NONFATAL|M_ERRNO, "Error in cryptoapicert: NCryptSignHash failed");
+        msg(M_NONFATAL | M_ERRNO, "Error in cryptoapicert: NCryptSignHash failed");
         len = 0;
     }
 
@@ -277,7 +277,7 @@ static ECDSA_SIG *
 ecdsa_bin2sig(unsigned char *buf, int len)
 {
     ECDSA_SIG *ecsig = NULL;
-    DWORD rlen = len/2;
+    DWORD rlen = len / 2;
     BIGNUM *r = BN_bin2bn(buf, rlen, NULL);
     BIGNUM *s = BN_bin2bn(buf + rlen, rlen, NULL);
     if (!r || !s)
@@ -323,7 +323,7 @@ ecdsa_sign_sig(const unsigned char *dgst, int dgstlen,
     if (status != ERROR_SUCCESS)
     {
         SetLastError(status);
-        msg(M_NONFATAL|M_ERRNO, "Error in cryptoapticert: NCryptSignHash failed");
+        msg(M_NONFATAL | M_ERRNO, "Error in cryptoapticert: NCryptSignHash failed");
     }
     else
     {
@@ -484,7 +484,7 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
             }
             if (!*++p)  /* unexpected end of string */
             {
-                msg(M_WARN|M_INFO, "WARNING: cryptoapicert: error parsing <THUMB:%s>.", cert_prop);
+                msg(M_WARN | M_INFO, "WARNING: cryptoapicert: error parsing <THUMB:%s>.", cert_prop);
                 goto out;
             }
             if (*p >= '0' && *p <= '9')
@@ -527,7 +527,7 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
         {
             break;
         }
-        msg(M_WARN|M_INFO, "WARNING: cryptoapicert: ignoring certificate in store %s.",
+        msg(M_WARN | M_INFO, "WARNING: cryptoapicert: ignoring certificate in store %s.",
             validity < 0 ? "not yet valid" : "that has expired");
     }
 
@@ -667,7 +667,7 @@ pkey_rsa_sign(EVP_PKEY_CTX *ctx, unsigned char *sig, size_t *siglen,
 
         if (!EVP_PKEY_CTX_get_rsa_pss_saltlen(ctx, &saltlen))
         {
-            msg(M_WARN|M_INFO, "cryptoapicert: unable to get the salt length from context."
+            msg(M_WARN | M_INFO, "cryptoapicert: unable to get the salt length from context."
                 " Using the default value.");
             saltlen = -1;
         }
@@ -685,7 +685,7 @@ pkey_rsa_sign(EVP_PKEY_CTX *ctx, unsigned char *sig, size_t *siglen,
         {
             const RSA *rsa = EVP_PKEY_get0_RSA(pkey);
             saltlen = RSA_size(rsa) - hashlen - 2; /* max salt length for RSASSA-PSS */
-            if (RSA_bits(rsa) &0x7) /* number of bits in the key not a multiple of 8 */
+            if (RSA_bits(rsa) & 0x7) /* number of bits in the key not a multiple of 8 */
             {
                 saltlen--;
             }
@@ -799,7 +799,7 @@ xkey_cng_ec_sign(CAPI_DATA *cd, unsigned char *sig, size_t *siglen, const unsign
     if (status != ERROR_SUCCESS)
     {
         SetLastError(status);
-        msg(M_NONFATAL|M_ERRNO, "Error in cryptoapicert: ECDSA signature using CNG failed.");
+        msg(M_NONFATAL | M_ERRNO, "Error in cryptoapicert: ECDSA signature using CNG failed.");
         return 0;
     }
 
@@ -884,7 +884,7 @@ xkey_cng_rsa_sign(CAPI_DATA *cd, unsigned char *sig, size_t *siglen, const unsig
     if (status != ERROR_SUCCESS)
     {
         SetLastError(status);
-        msg(M_NONFATAL|M_ERRNO, "Error in cryptoapicert: RSA signature using CNG failed.");
+        msg(M_NONFATAL | M_ERRNO, "Error in cryptoapicert: RSA signature using CNG failed.");
         return 0;
     }
 
@@ -948,10 +948,10 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     }
     /* search CURRENT_USER first, then LOCAL_MACHINE */
     cs = CertOpenStore((LPCSTR) CERT_STORE_PROV_SYSTEM, 0, 0, CERT_SYSTEM_STORE_CURRENT_USER
-                       |CERT_STORE_OPEN_EXISTING_FLAG | CERT_STORE_READONLY_FLAG, L"MY");
+                       | CERT_STORE_OPEN_EXISTING_FLAG | CERT_STORE_READONLY_FLAG, L"MY");
     if (cs == NULL)
     {
-        msg(M_NONFATAL|M_ERRNO, "Error in cryptoapicert: failed to open user certficate store");
+        msg(M_NONFATAL | M_ERRNO, "Error in cryptoapicert: failed to open user certficate store");
         goto err;
     }
     cd->cert_context = find_certificate_in_store(cert_prop, cs);
@@ -959,10 +959,10 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     if (!cd->cert_context)
     {
         cs = CertOpenStore((LPCSTR) CERT_STORE_PROV_SYSTEM, 0, 0, CERT_SYSTEM_STORE_LOCAL_MACHINE
-                           |CERT_STORE_OPEN_EXISTING_FLAG | CERT_STORE_READONLY_FLAG, L"MY");
+                           | CERT_STORE_OPEN_EXISTING_FLAG | CERT_STORE_READONLY_FLAG, L"MY");
         if (cs == NULL)
         {
-            msg(M_NONFATAL|M_ERRNO, "Error in cryptoapicert: failed to open machine certficate store");
+            msg(M_NONFATAL | M_ERRNO, "Error in cryptoapicert: failed to open machine certficate store");
             goto err;
         }
         cd->cert_context = find_certificate_in_store(cert_prop, cs);
@@ -991,7 +991,7 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
                                            &cd->crypt_prov, &cd->key_spec, &cd->free_crypt_prov))
     {
         /* private key may be in a token not available, or incompatible with CNG */
-        msg(M_NONFATAL|M_ERRNO, "Error in cryptoapicert: failed to acquire key. Key not present or "
+        msg(M_NONFATAL | M_ERRNO, "Error in cryptoapicert: failed to acquire key. Key not present or "
             "is in a legacy token not supported by Windows CNG API");
         goto err;
     }
@@ -1037,7 +1037,7 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
     }
     else
     {
-        msg(M_WARN|M_INFO, "WARNING: cryptoapicert: key type <%d> not supported",
+        msg(M_WARN | M_INFO, "WARNING: cryptoapicert: key type <%d> not supported",
             EVP_PKEY_id(pkey));
         goto err;
     }
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 78023eea..7c370710 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -570,7 +570,7 @@ dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
         multi_tcp_dereference_instance(m->mtcp, mi);
         if (close(sd))
         {
-            msg(D_DCO|M_ERRNO, "error closing TCP socket after DCO handover");
+            msg(D_DCO | M_ERRNO, "error closing TCP socket after DCO handover");
         }
         c->c2.link_socket->info.dco_installed = true;
         c->c2.link_socket->sd = SOCKET_UNDEFINED;
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index c6da6ce3..20c53e1e 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -179,7 +179,7 @@ create_interface(struct tuntap *tt, const char *dev)
     if (ret)
     {
         ret = -errno;
-        msg(M_WARN|M_ERRNO, "Failed to create interface %s (SIOCIFCREATE2)", ifr.ifr_name);
+        msg(M_WARN | M_ERRNO, "Failed to create interface %s (SIOCIFCREATE2)", ifr.ifr_name);
         return ret;
     }
 
@@ -198,7 +198,7 @@ create_interface(struct tuntap *tt, const char *dev)
         ret = -errno;
         /* Delete the created interface again. */
         (void)ioctl(tt->dco.fd, SIOCIFDESTROY, &ifr);
-        msg(M_WARN|M_ERRNO, "Failed to create interface %s (SIOCSIFNAME)", ifr.ifr_data);
+        msg(M_WARN | M_ERRNO, "Failed to create interface %s (SIOCSIFNAME)", ifr.ifr_data);
         return ret;
     }
 
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 98e10507..c2bd8b4a 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -153,7 +153,7 @@ ovpn_nl_recvmsgs(dco_context_t *dco, const char *prefix)
         default:
             if (ret)
             {
-                msg(M_NONFATAL|M_ERRNO, "%s: netlink reports error (%d): %s", prefix, ret, nl_geterror(-ret));
+                msg(M_NONFATAL | M_ERRNO, "%s: netlink reports error (%d): %s", prefix, ret, nl_geterror(-ret));
             }
             break;
     }
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index c8c77358..20d11e50 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -198,7 +198,7 @@ msg_fp(const unsigned int flags)
     FILE *fp = msgfp;
     if (!fp)
     {
-        fp = (flags & (M_FATAL|M_USAGE_SMALL)) ? default_err : default_out;
+        fp = (flags & (M_FATAL | M_USAGE_SMALL)) ? default_err : default_out;
     }
     if (!fp)
     {
@@ -288,7 +288,7 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
     }
 
 #if SYSLOG_CAPABILITY
-    if (flags & (M_FATAL|M_NONFATAL|M_USAGE_SMALL))
+    if (flags & (M_FATAL | M_NONFATAL | M_USAGE_SMALL))
     {
         level = LOG_ERR;
     }
@@ -368,7 +368,7 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
                         prefix,
                         prefix_sep,
                         m1,
-                        (flags&M_NOLF) ? "" : "\n");
+                        (flags & M_NOLF) ? "" : "\n");
             }
             else
             {
@@ -377,7 +377,7 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
                         prefix,
                         prefix_sep,
                         m1,
-                        (flags&M_NOLF) ? "" : "\n");
+                        (flags & M_NOLF) ? "" : "\n");
             }
             fflush(fp);
             ++x_msg_line_num;
@@ -540,7 +540,7 @@ redirect_stdout_stderr(const char *file, bool append)
 
         if (log_handle == INVALID_HANDLE_VALUE)
         {
-            msg(M_WARN|M_ERRNO, "Warning: cannot open --log file: %s", file);
+            msg(M_WARN | M_ERRNO, "Warning: cannot open --log file: %s", file);
             return;
         }
 
@@ -593,7 +593,7 @@ redirect_stdout_stderr(const char *file, bool append)
 
         if (out < 0)
         {
-            msg(M_WARN|M_ERRNO, "Warning: Error redirecting stdout/stderr to --log file: %s", file);
+            msg(M_WARN | M_ERRNO, "Warning: Error redirecting stdout/stderr to --log file: %s", file);
             return;
         }
 
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 89adb3e6..4e4bd3d3 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -92,20 +92,20 @@ extern int x_msg_line_num;
 
 #define M_DEBUG_LEVEL     (0x0F)         /* debug level mask */
 
-#define M_FATAL           (1<<4)         /* exit program */
-#define M_NONFATAL        (1<<5)         /* non-fatal error */
-#define M_WARN            (1<<6)         /* call syslog with LOG_WARNING */
-#define M_DEBUG           (1<<7)
+#define M_FATAL           (1 << 4)         /* exit program */
+#define M_NONFATAL        (1 << 5)         /* non-fatal error */
+#define M_WARN            (1 << 6)         /* call syslog with LOG_WARNING */
+#define M_DEBUG           (1 << 7)
 
-#define M_ERRNO           (1<<8)         /* show errno description */
+#define M_ERRNO           (1 << 8)         /* show errno description */
 
-#define M_NOMUTE          (1<<11)        /* don't do mute processing */
-#define M_NOPREFIX        (1<<12)        /* don't show date/time prefix */
-#define M_USAGE_SMALL     (1<<13)        /* fatal options error, call usage_small */
-#define M_MSG_VIRT_OUT    (1<<14)        /* output message through msg_status_output callback */
-#define M_OPTERR          (1<<15)        /* print "Options error:" prefix */
-#define M_NOLF            (1<<16)        /* don't print new line */
-#define M_NOIPREFIX       (1<<17)        /* don't print instance prefix */
+#define M_NOMUTE          (1 << 11)        /* don't do mute processing */
+#define M_NOPREFIX        (1 << 12)        /* don't show date/time prefix */
+#define M_USAGE_SMALL     (1 << 13)        /* fatal options error, call usage_small */
+#define M_MSG_VIRT_OUT    (1 << 14)        /* output message through msg_status_output callback */
+#define M_OPTERR          (1 << 15)        /* print "Options error:" prefix */
+#define M_NOLF            (1 << 16)        /* don't print new line */
+#define M_NOIPREFIX       (1 << 17)        /* don't print instance prefix */
 
 /* flag combinations which are frequently used */
 #define M_ERR     (M_FATAL | M_ERRNO)
@@ -180,7 +180,7 @@ void set_suppress_timestamps(bool suppressed);
 void set_machine_readable_output(bool parsable);
 
 
-#define SDL_CONSTRAIN (1<<0)
+#define SDL_CONSTRAIN (1 << 0)
 bool set_debug_level(const int level, const unsigned int flags);
 
 bool set_mute_cutoff(const int cutoff);
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index 4d3bf1a1..2465f1cc 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -333,11 +333,11 @@ we_ctl(struct event_set *es, event_t event, unsigned int rwflags, void *arg)
                 }
                 break;
 
-            case EVENT_READ|EVENT_WRITE:
+            case EVENT_READ | EVENT_WRITE:
                 switch (n)
                 {
                     case 0:
-                        if (!we_append_event(wes, event, EVENT_READ|EVENT_WRITE, arg))
+                        if (!we_append_event(wes, event, EVENT_READ | EVENT_WRITE, arg))
                         {
                             goto err;
                         }
@@ -561,7 +561,7 @@ ep_del(struct event_set *es, event_t event)
     CLEAR(ev);
     if (epoll_ctl(eps->epfd, EPOLL_CTL_DEL, event, &ev) < 0)
     {
-        msg(M_WARN|M_ERRNO, "EVENT: epoll_ctl EPOLL_CTL_DEL failed, sd=%d", (int)event);
+        msg(M_WARN | M_ERRNO, "EVENT: epoll_ctl EPOLL_CTL_DEL failed, sd=%d", (int)event);
     }
 }
 
@@ -627,7 +627,7 @@ ep_wait(struct event_set *es, const struct timeval *tv, struct event_set_return
         for (i = 0; i < stat; ++i)
         {
             esr->rwflags = 0;
-            if (ev->events & (EPOLLIN|EPOLLPRI|EPOLLERR|EPOLLHUP))
+            if (ev->events & (EPOLLIN | EPOLLPRI | EPOLLERR | EPOLLHUP))
             {
                 esr->rwflags |= EVENT_READ;
             }
@@ -753,7 +753,7 @@ po_set_pollfd_events(struct pollfd *pfdp, unsigned int rwflags)
     }
     if (rwflags & EVENT_READ)
     {
-        pfdp->events |= (POLLIN|POLLPRI);
+        pfdp->events |= (POLLIN | POLLPRI);
     }
 }
 
@@ -832,10 +832,10 @@ po_wait(struct event_set *es, const struct timeval *tv, struct event_set_return
         const struct pollfd *pfdp = pos->events;
         for (i = 0; i < pos->n_events && j < outlen; ++i)
         {
-            if (pfdp->revents & (POLLIN|POLLPRI|POLLERR|POLLHUP|POLLOUT))
+            if (pfdp->revents & (POLLIN | POLLPRI | POLLERR | POLLHUP | POLLOUT))
             {
                 out->rwflags = 0;
-                if (pfdp->revents & (POLLIN|POLLPRI|POLLERR|POLLHUP))
+                if (pfdp->revents & (POLLIN | POLLPRI | POLLERR | POLLHUP))
                 {
                     out->rwflags |= EVENT_READ;
                 }
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index f2438f97..df299c60 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -79,8 +79,8 @@
 /*
  * Initialization flags passed to event_set_init
  */
-#define EVENT_METHOD_US_TIMEOUT   (1<<0)
-#define EVENT_METHOD_FAST         (1<<1)
+#define EVENT_METHOD_US_TIMEOUT   (1 << 0)
+#define EVENT_METHOD_FAST         (1 << 1)
 
 #ifdef _WIN32
 
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index e45aa0f9..34472af0 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -410,8 +410,8 @@ check_add_routes(struct context *c)
                 register_signal(c, SIGHUP, "ip-fail");
                 c->persist.restart_sleep_seconds = 10;
 #ifdef _WIN32
-                show_routes(M_INFO|M_NOPREFIX);
-                show_adapters(M_INFO|M_NOPREFIX);
+                show_routes(M_INFO | M_NOPREFIX);
+                show_adapters(M_INFO | M_NOPREFIX);
 #endif
             }
         }
@@ -1588,7 +1588,7 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
                     mss_fixup_ipv6(&ipbuf, c->c2.frame.mss_fix);
                 }
                 if (!(flags & PIP_OUTGOING) && (flags
-                                                &(PIPV6_IMCP_NOHOST_CLIENT | PIPV6_IMCP_NOHOST_SERVER)))
+                                                & (PIPV6_IMCP_NOHOST_CLIENT | PIPV6_IMCP_NOHOST_SERVER)))
                 {
                     ipv6_send_icmp_unreachable(c, buf,
                                                (bool)(flags & PIPV6_IMCP_NOHOST_CLIENT));
@@ -2177,7 +2177,7 @@ process_io(struct context *c)
     const unsigned int status = c->c2.event_set_status;
 
 #ifdef ENABLE_MANAGEMENT
-    if (status & (MANAGEMENT_READ|MANAGEMENT_WRITE))
+    if (status & (MANAGEMENT_READ | MANAGEMENT_WRITE))
     {
         ASSERT(management);
         management_io(management);
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index bd2d9601..6d66ee33 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -51,18 +51,18 @@
 #include "occ.h"
 #include "ping.h"
 
-#define IOW_TO_TUN          (1<<0)
-#define IOW_TO_LINK         (1<<1)
-#define IOW_READ_TUN        (1<<2)
-#define IOW_READ_LINK       (1<<3)
-#define IOW_SHAPER          (1<<4)
-#define IOW_CHECK_RESIDUAL  (1<<5)
-#define IOW_FRAG            (1<<6)
-#define IOW_MBUF            (1<<7)
-#define IOW_READ_TUN_FORCE  (1<<8)
-#define IOW_WAIT_SIGNAL     (1<<9)
-
-#define IOW_READ            (IOW_READ_TUN|IOW_READ_LINK)
+#define IOW_TO_TUN          (1 << 0)
+#define IOW_TO_LINK         (1 << 1)
+#define IOW_READ_TUN        (1 << 2)
+#define IOW_READ_LINK       (1 << 3)
+#define IOW_SHAPER          (1 << 4)
+#define IOW_CHECK_RESIDUAL  (1 << 5)
+#define IOW_FRAG            (1 << 6)
+#define IOW_MBUF            (1 << 7)
+#define IOW_READ_TUN_FORCE  (1 << 8)
+#define IOW_WAIT_SIGNAL     (1 << 9)
+
+#define IOW_READ            (IOW_READ_TUN | IOW_READ_LINK)
 
 extern counter_type link_read_bytes_global;
 
@@ -291,13 +291,13 @@ send_control_channel_string_dowork(struct tls_multi *multi,
  */
 void reschedule_multi_process(struct context *c);
 
-#define PIPV4_PASSTOS                   (1<<0)
-#define PIP_MSSFIX                      (1<<1)         /* v4 and v6 */
-#define PIP_OUTGOING                    (1<<2)
-#define PIPV4_EXTRACT_DHCP_ROUTER       (1<<3)
-#define PIPV4_CLIENT_NAT                (1<<4)
-#define PIPV6_IMCP_NOHOST_CLIENT        (1<<5)
-#define PIPV6_IMCP_NOHOST_SERVER        (1<<6)
+#define PIPV4_PASSTOS                   (1 << 0)
+#define PIP_MSSFIX                      (1 << 1)         /* v4 and v6 */
+#define PIP_OUTGOING                    (1 << 2)
+#define PIPV4_EXTRACT_DHCP_ROUTER       (1 << 3)
+#define PIPV4_CLIENT_NAT                (1 << 4)
+#define PIPV6_IMCP_NOHOST_CLIENT        (1 << 5)
+#define PIPV6_IMCP_NOHOST_SERVER        (1 << 6)
 
 void process_ip_header(struct context *c, unsigned int flags, struct buffer *buf);
 
@@ -337,7 +337,7 @@ register_activity(struct context *c, const int size)
 static inline unsigned int
 p2p_iow_flags(const struct context *c)
 {
-    unsigned int flags = (IOW_SHAPER|IOW_CHECK_RESIDUAL|IOW_FRAG|IOW_READ|IOW_WAIT_SIGNAL);
+    unsigned int flags = (IOW_SHAPER | IOW_CHECK_RESIDUAL | IOW_FRAG | IOW_READ | IOW_WAIT_SIGNAL);
     if (c->c2.to_link.len > 0)
     {
         flags |= IOW_TO_LINK;
@@ -362,7 +362,7 @@ p2p_iow_flags(const struct context *c)
 static inline void
 io_wait(struct context *c, const unsigned int flags)
 {
-    if (c->c2.fast_io && (flags & (IOW_TO_TUN|IOW_TO_LINK|IOW_MBUF)))
+    if (c->c2.fast_io && (flags & (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))
     {
         /* fast path -- only for TUN/TAP/UDP writes */
         unsigned int ret = 0;
@@ -370,7 +370,7 @@ io_wait(struct context *c, const unsigned int flags)
         {
             ret |= TUN_WRITE;
         }
-        if (flags & (IOW_TO_LINK|IOW_MBUF))
+        if (flags & (IOW_TO_LINK | IOW_MBUF))
         {
             ret |= SOCKET_WRITE;
         }
diff --git a/src/openvpn/gremlin.h b/src/openvpn/gremlin.h
index b75ae7e0..4c38e23a 100644
--- a/src/openvpn/gremlin.h
+++ b/src/openvpn/gremlin.h
@@ -49,11 +49,11 @@
 
 /* extract gremlin parms */
 
-#define GREMLIN_CONNECTION_FLOOD_LEVEL(x) (((x)>>GREMLIN_CONNECTION_FLOOD_SHIFT) & GREMLIN_CONNECTION_FLOOD_MASK)
-#define GREMLIN_PACKET_FLOOD_LEVEL(x)     (((x)>>GREMLIN_PACKET_FLOOD_SHIFT)     & GREMLIN_PACKET_FLOOD_MASK)
-#define GREMLIN_CORRUPT_LEVEL(x)          (((x)>>GREMLIN_CORRUPT_SHIFT)          & GREMLIN_CORRUPT_MASK)
-#define GREMLIN_UP_DOWN_LEVEL(x)          (((x)>>GREMLIN_UP_DOWN_SHIFT)          & GREMLIN_UP_DOWN_MASK)
-#define GREMLIN_DROP_LEVEL(x)             (((x)>>GREMLIN_DROP_SHIFT)             & GREMLIN_DROP_MASK)
+#define GREMLIN_CONNECTION_FLOOD_LEVEL(x) (((x) >> GREMLIN_CONNECTION_FLOOD_SHIFT) & GREMLIN_CONNECTION_FLOOD_MASK)
+#define GREMLIN_PACKET_FLOOD_LEVEL(x)     (((x) >> GREMLIN_PACKET_FLOOD_SHIFT)     & GREMLIN_PACKET_FLOOD_MASK)
+#define GREMLIN_CORRUPT_LEVEL(x)          (((x) >> GREMLIN_CORRUPT_SHIFT)          & GREMLIN_CORRUPT_MASK)
+#define GREMLIN_UP_DOWN_LEVEL(x)          (((x) >> GREMLIN_UP_DOWN_SHIFT)          & GREMLIN_UP_DOWN_MASK)
+#define GREMLIN_DROP_LEVEL(x)             (((x) >> GREMLIN_DROP_SHIFT)             & GREMLIN_DROP_MASK)
 
 #include "buffer.h"
 
diff --git a/src/openvpn/httpdigest.c b/src/openvpn/httpdigest.c
index 833315ce..112cd648 100644
--- a/src/openvpn/httpdigest.c
+++ b/src/openvpn/httpdigest.c
@@ -48,20 +48,20 @@ CvtHex(
         j = (Bin[i] >> 4) & 0xf;
         if (j <= 9)
         {
-            Hex[i*2] = (j + '0');
+            Hex[i * 2] = (j + '0');
         }
         else
         {
-            Hex[i*2] = (j + 'a' - 10);
+            Hex[i * 2] = (j + 'a' - 10);
         }
         j = Bin[i] & 0xf;
         if (j <= 9)
         {
-            Hex[i*2 + 1] = (j + '0');
+            Hex[i * 2 + 1] = (j + '0');
         }
         else
         {
-            Hex[i*2 + 1] = (j + 'a' - 10);
+            Hex[i * 2 + 1] = (j + 'a' - 10);
         }
     }
     Hex[HASHHEXLEN] = '\0';
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 598b4df2..d151dc6f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -66,9 +66,9 @@ static const char *saved_pid_file_name; /* GLOBAL */
 /*
  * Crypto initialization flags
  */
-#define CF_LOAD_PERSISTED_PACKET_ID (1<<0)
-#define CF_INIT_TLS_MULTI           (1<<1)
-#define CF_INIT_TLS_AUTH_STANDALONE (1<<2)
+#define CF_LOAD_PERSISTED_PACKET_ID (1 << 0)
+#define CF_INIT_TLS_MULTI           (1 << 1)
+#define CF_INIT_TLS_AUTH_STANDALONE (1 << 2)
 
 static void do_init_first_time(struct context *c);
 static bool do_deferred_p2p_ncp(struct context *c);
@@ -334,7 +334,7 @@ management_callback_remote_cmd(void *arg, const char **p)
     struct context *c = (struct context *) arg;
     struct connection_entry *ce = &c->options.ce;
     int ret = false;
-    if (p[1] && ((ce->flags>>CE_MAN_QUERY_REMOTE_SHIFT)&CE_MAN_QUERY_REMOTE_MASK) == CE_MAN_QUERY_REMOTE_QUERY)
+    if (p[1] && ((ce->flags >> CE_MAN_QUERY_REMOTE_SHIFT) & CE_MAN_QUERY_REMOTE_MASK) == CE_MAN_QUERY_REMOTE_QUERY)
     {
         int flags = 0;
         if (!strcmp(p[1], "ACCEPT"))
@@ -368,8 +368,8 @@ management_callback_remote_cmd(void *arg, const char **p)
         }
         if (ret)
         {
-            ce->flags &= ~(CE_MAN_QUERY_REMOTE_MASK<<CE_MAN_QUERY_REMOTE_SHIFT);
-            ce->flags |= ((flags&CE_MAN_QUERY_REMOTE_MASK)<<CE_MAN_QUERY_REMOTE_SHIFT);
+            ce->flags &= ~(CE_MAN_QUERY_REMOTE_MASK << CE_MAN_QUERY_REMOTE_SHIFT);
+            ce->flags |= ((flags & CE_MAN_QUERY_REMOTE_MASK) << CE_MAN_QUERY_REMOTE_SHIFT);
         }
     }
     return ret;
@@ -693,7 +693,7 @@ context_init_1(struct context *c)
         struct user_pass up;
         CLEAR(up);
         strcpy(up.username, "Please insert your cryptographic token"); /* put the high-level message in up.username */
-        get_user_pass(&up, NULL, "token-insertion-request", GET_USER_PASS_MANAGEMENT|GET_USER_PASS_NEED_OK);
+        get_user_pass(&up, NULL, "token-insertion-request", GET_USER_PASS_MANAGEMENT | GET_USER_PASS_NEED_OK);
         msg(M_INFO, "RET:%s", up.password); /* will return the third argument to management interface
                                              * 'needok' command, usually 'ok' or 'cancel'. */
     }
@@ -1067,7 +1067,7 @@ do_persist_tuntap(struct options *options, openvpn_net_ctx_t *ctx)
             || options->tls_server || options->tls_client
             )
         {
-            msg(M_FATAL|M_OPTERR,
+            msg(M_FATAL | M_OPTERR,
                 "options --mktun or --rmtun should only be used together with --dev");
         }
 
@@ -1101,7 +1101,7 @@ do_persist_tuntap(struct options *options, openvpn_net_ctx_t *ctx)
         }
         return true;
 #else  /* ifdef ENABLE_FEATURE_TUN_PERSIST */
-        msg( M_FATAL|M_OPTERR,
+        msg( M_FATAL | M_OPTERR,
              "options --mktun and --rmtun are not available on your operating "
              "system.  Please check 'man tun' (or 'tap'), whether your system "
              "supports using 'ifconfig %s create' / 'destroy' to create/remove "
@@ -1537,8 +1537,8 @@ initialization_sequence_completed(struct context *c, const unsigned int flags)
     if (flags & ISC_ERRORS)
     {
 #ifdef _WIN32
-        show_routes(M_INFO|M_NOPREFIX);
-        show_adapters(M_INFO|M_NOPREFIX);
+        show_routes(M_INFO | M_NOPREFIX);
+        show_adapters(M_INFO | M_NOPREFIX);
         msg(M_INFO, "%s With Errors ( see http://openvpn.net/faq.html#dhcpclientserv )", message);
 #else
 #ifdef ENABLE_SYSTEMD
@@ -1556,7 +1556,7 @@ initialization_sequence_completed(struct context *c, const unsigned int flags)
     }
 
     /* Flag that we initialized */
-    if ((flags & (ISC_ERRORS|ISC_SERVER)) == 0)
+    if ((flags & (ISC_ERRORS | ISC_SERVER)) == 0)
     {
         c->options.no_advance = true;
     }
@@ -1670,13 +1670,13 @@ do_route(const struct options *options,
 #ifdef _WIN32
     if (options->show_net_up)
     {
-        show_routes(M_INFO|M_NOPREFIX);
-        show_adapters(M_INFO|M_NOPREFIX);
+        show_routes(M_INFO | M_NOPREFIX);
+        show_adapters(M_INFO | M_NOPREFIX);
     }
     else if (check_debug_level(D_SHOW_NET))
     {
-        show_routes(D_SHOW_NET|M_NOPREFIX);
-        show_adapters(D_SHOW_NET|M_NOPREFIX);
+        show_routes(D_SHOW_NET | M_NOPREFIX);
+        show_adapters(D_SHOW_NET | M_NOPREFIX);
     }
 #endif
 }
@@ -2345,7 +2345,7 @@ do_deferred_options(struct context *c, const unsigned int found)
 {
     if (found & OPT_P_MESSAGES)
     {
-        init_verb_mute(c, IVM_LEVEL_1|IVM_LEVEL_2);
+        init_verb_mute(c, IVM_LEVEL_1 | IVM_LEVEL_2);
         msg(D_PUSH, "OPTIONS IMPORT: --verb and/or --mute level changed");
     }
     if (found & OPT_P_TIMER)
@@ -3505,7 +3505,7 @@ do_init_first_time(struct context *c)
         /* get user and/or group that we want to setuid/setgid to */
         c0->uid_gid_specified =
             platform_group_get(c->options.groupname, &c0->platform_state_group)
-            |platform_user_get(c->options.username, &c0->platform_state_user);
+            | platform_user_get(c->options.username, &c0->platform_state_user);
 
         /* perform postponed chdir if --daemon */
         if (c->did_we_daemonize && c->options.cd_dir == NULL)
@@ -3860,7 +3860,7 @@ open_plugins(struct context *c, const bool import_options, int init_point)
                     {
                         options_string_import(&c->options,
                                               config.list[i]->value,
-                                              D_IMPORT_ERRORS|M_OPTERR,
+                                              D_IMPORT_ERRORS | M_OPTERR,
                                               OPT_P_DEFAULT & ~OPT_P_PLUGIN,
                                               &option_types_found,
                                               c->es);
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index f53b65ee..a584a48c 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -46,8 +46,8 @@ bool init_static(void);
 
 void uninit_static(void);
 
-#define IVM_LEVEL_1 (1<<0)
-#define IVM_LEVEL_2 (1<<1)
+#define IVM_LEVEL_1 (1 << 0)
+#define IVM_LEVEL_2 (1 << 1)
 void init_verb_mute(struct context *c, unsigned int flags);
 
 void init_options_dev(struct options *options);
@@ -103,10 +103,10 @@ void inherit_context_child(struct context *dest,
 void inherit_context_top(struct context *dest,
                          const struct context *src);
 
-#define CC_GC_FREE          (1<<0)
-#define CC_USR1_TO_HUP      (1<<1)
-#define CC_HARD_USR1_TO_HUP (1<<2)
-#define CC_NO_CLOSE         (1<<3)
+#define CC_GC_FREE          (1 << 0)
+#define CC_USR1_TO_HUP      (1 << 1)
+#define CC_HARD_USR1_TO_HUP (1 << 2)
+#define CC_NO_CLOSE         (1 << 3)
 
 void close_context(struct context *c, int sig, unsigned int flags);
 
@@ -114,8 +114,8 @@ struct context_buffers *init_context_buffers(const struct frame *frame);
 
 void free_context_buffers(struct context_buffers *b);
 
-#define ISC_ERRORS (1<<0)
-#define ISC_SERVER (1<<1)
+#define ISC_ERRORS (1 << 0)
+#define ISC_SERVER (1 << 1)
 void initialization_sequence_completed(struct context *c, const unsigned int flags);
 
 #ifdef ENABLE_MANAGEMENT
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 3f60438e..1efec5a8 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -574,15 +574,15 @@ list_test(void)
 
 #define mix(a, b, c)               \
     {                                \
-        a -= b; a -= c; a ^= (c>>13);  \
-        b -= c; b -= a; b ^= (a<<8);   \
-        c -= a; c -= b; c ^= (b>>13);  \
-        a -= b; a -= c; a ^= (c>>12);  \
-        b -= c; b -= a; b ^= (a<<16);  \
-        c -= a; c -= b; c ^= (b>>5);   \
-        a -= b; a -= c; a ^= (c>>3);   \
-        b -= c; b -= a; b ^= (a<<10);  \
-        c -= a; c -= b; c ^= (b>>15);  \
+        a -= b; a -= c; a ^= (c >> 13);  \
+        b -= c; b -= a; b ^= (a << 8);   \
+        c -= a; c -= b; c ^= (b >> 13);  \
+        a -= b; a -= c; a ^= (c >> 12);  \
+        b -= c; b -= a; b ^= (a << 16);  \
+        c -= a; c -= b; c ^= (b >> 5);   \
+        a -= b; a -= c; a ^= (c >> 3);   \
+        b -= c; b -= a; b ^= (a << 10);  \
+        c -= a; c -= b; c ^= (b >> 15);  \
     }
 
 uint32_t
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index 8260bd94..5fd84e3f 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -39,7 +39,7 @@
 #include "basic.h"
 #include "buffer.h"
 
-#define hashsize(n) ((uint32_t)1<<(n))
+#define hashsize(n) ((uint32_t)1 << (n))
 #define hashmask(n) (hashsize(n) - 1)
 
 struct hash_element
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index a691c69d..132fdc0d 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -281,7 +281,7 @@ static void
 man_delete_unix_socket(struct management *man)
 {
 #if UNIX_SOCK_SUPPORT
-    if ((man->settings.flags & (MF_UNIX_SOCK|MF_CONNECT_AS_CLIENT)) == MF_UNIX_SOCK)
+    if ((man->settings.flags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) == MF_UNIX_SOCK)
     {
         socket_delete_unix(&man->settings.local_unix);
     }
@@ -310,8 +310,8 @@ virtual_output_callback_func(void *arg, const unsigned int flags, const char *st
     struct management *man = (struct management *) arg;
     static int recursive_level = 0; /* GLOBAL */
 
-#define AF_DID_PUSH  (1<<0)
-#define AF_DID_RESET (1<<1)
+#define AF_DID_PUSH  (1 << 0)
+#define AF_DID_RESET (1 << 1)
     if (recursive_level < 5) /* limit recursion */
     {
         struct gc_arena gc = gc_new();
@@ -357,11 +357,11 @@ virtual_output_callback_func(void *arg, const unsigned int flags, const char *st
             }
             if (flags & M_FATAL)
             {
-                out = log_entry_print(&e, LOG_FATAL_NOTIFY|LOG_PRINT_CRLF, &gc);
+                out = log_entry_print(&e, LOG_FATAL_NOTIFY | LOG_PRINT_CRLF, &gc);
                 if (out)
                 {
                     man_output_list_push_str(man, out);
-                    action_flags |= (AF_DID_PUSH|AF_DID_RESET);
+                    action_flags |= (AF_DID_PUSH | AF_DID_RESET);
                 }
             }
         }
@@ -518,7 +518,7 @@ man_kill(struct management *man, const char *victim)
         {
             /* IP:port specified */
             bool status;
-            const in_addr_t addr = getaddr(GETADDR_HOST_ORDER|GETADDR_MSG_VIRT_OUT, p1, 0, &status, NULL);
+            const in_addr_t addr = getaddr(GETADDR_HOST_ORDER | GETADDR_MSG_VIRT_OUT, p1, 0, &status, NULL);
             if (status)
             {
                 const int port = atoi(p2);
@@ -633,7 +633,7 @@ man_log(struct management *man, const char *parm)
                 "log",
                 man->persist.log,
                 &man->connection.log_realtime,
-                LOG_PRINT_INT_DATE|LOG_PRINT_MSG_FLAGS);
+                LOG_PRINT_INT_DATE | LOG_PRINT_MSG_FLAGS);
 }
 
 static void
@@ -644,7 +644,7 @@ man_echo(struct management *man, const char *parm)
                 "echo",
                 man->persist.echo,
                 &man->connection.echo_realtime,
-                LOG_PRINT_INT_DATE|MANAGEMENT_ECHO_FLAGS);
+                LOG_PRINT_INT_DATE | MANAGEMENT_ECHO_FLAGS);
 }
 
 static void
@@ -655,8 +655,8 @@ man_state(struct management *man, const char *parm)
                 "state",
                 man->persist.state,
                 &man->connection.state_realtime,
-                LOG_PRINT_INT_DATE|LOG_PRINT_STATE
-                |LOG_PRINT_LOCAL_IP|LOG_PRINT_REMOTE_IP);
+                LOG_PRINT_INT_DATE | LOG_PRINT_STATE
+                | LOG_PRINT_LOCAL_IP | LOG_PRINT_REMOTE_IP);
 }
 
 static void
@@ -1149,7 +1149,7 @@ man_load_stats(struct management *man)
         link_write_bytes_global);
 }
 
-#define MN_AT_LEAST (1<<0)
+#define MN_AT_LEAST (1 << 0)
 /**
  * Checks if the correct number of arguments to a management command are present
  * and otherwise prints an error and returns false.
@@ -1600,7 +1600,7 @@ man_start_ne32(struct management *man)
 
         case MS_CC_WAIT_READ:
         case MS_CC_WAIT_WRITE:
-            net_event_win32_start(&man->connection.ne32, FD_READ|FD_WRITE|FD_CLOSE, man->connection.sd_cli);
+            net_event_win32_start(&man->connection.ne32, FD_READ | FD_WRITE | FD_CLOSE, man->connection.sd_cli);
             break;
 
         default:
@@ -1818,7 +1818,7 @@ man_listen(struct management *man)
             }
             else
             {
-                msg(M_WARN|M_ERRNO,
+                msg(M_WARN | M_ERRNO,
                     "Failed to get the management socket address");
             }
             msg(D_MANAGEMENT, "MANAGEMENT: TCP Socket listening on %s",
@@ -2426,7 +2426,7 @@ man_settings_init(struct man_settings *ms,
             else
             {
                 int status;
-                int resolve_flags = GETADDR_RESOLVE|GETADDR_WARN_ON_SIGNAL|GETADDR_FATAL;
+                int resolve_flags = GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL | GETADDR_FATAL;
 
                 if (!(flags & MF_CONNECT_AS_CLIENT))
                 {
@@ -2940,7 +2940,7 @@ management_echo(struct management *man, const char *string, const bool pull)
 
         if (man->connection.echo_realtime)
         {
-            out = log_entry_print(&e, LOG_PRINT_INT_DATE|LOG_PRINT_ECHO_PREFIX|LOG_PRINT_CRLF|MANAGEMENT_ECHO_FLAGS, &gc);
+            out = log_entry_print(&e, LOG_PRINT_INT_DATE | LOG_PRINT_ECHO_PREFIX | LOG_PRINT_CRLF | MANAGEMENT_ECHO_FLAGS, &gc);
         }
 
         if (out)
@@ -3049,7 +3049,7 @@ management_socket_set(struct management *man,
             case MS_CC_WAIT_WRITE:
                 if (man_persist_state(persistent, 3))
                 {
-                    event_ctl(es, ev, EVENT_READ|EVENT_WRITE, arg);
+                    event_ctl(es, ev, EVENT_READ | EVENT_WRITE, arg);
                 }
                 break;
 
@@ -3292,9 +3292,9 @@ man_standalone_event_loop(struct management *man, volatile int *signal_received,
     return status;
 }
 
-#define MWCC_PASSWORD_WAIT (1<<0)
-#define MWCC_HOLD_WAIT     (1<<1)
-#define MWCC_OTHER_WAIT    (1<<2)
+#define MWCC_PASSWORD_WAIT (1 << 0)
+#define MWCC_HOLD_WAIT     (1 << 1)
+#define MWCC_OTHER_WAIT    (1 << 2)
 
 /*
  * Block until client connects
@@ -3805,7 +3805,7 @@ command_line_add(struct command_line *cl, const unsigned char *buf, const int le
     int i;
     for (i = 0; i < len; ++i)
     {
-        if (buf[i] && char_class(buf[i], (CC_PRINT|CC_NEWLINE)))
+        if (buf[i] && char_class(buf[i], (CC_PRINT | CC_NEWLINE)))
         {
             if (!buf_write_u8(&cl->buf, buf[i]))
             {
@@ -3890,9 +3890,9 @@ log_entry_print(const struct log_entry *e, unsigned int flags, struct gc_arena *
     if (flags & LOG_PRINT_REMOTE_IP)
     {
         buf_printf(&out, ",%s", (!addr_defined(&e->remote_sock) ? "," :
-                                 print_sockaddr_ex(&e->remote_sock.addr.sa, ",", PS_DONT_SHOW_FAMILY|PS_SHOW_PORT, gc)));
+                                 print_sockaddr_ex(&e->remote_sock.addr.sa, ",", PS_DONT_SHOW_FAMILY | PS_SHOW_PORT, gc)));
         buf_printf(&out, ",%s", (!addr_defined(&e->local_sock) ? "," :
-                                 print_sockaddr_ex(&e->local_sock.addr.sa, ",", PS_DONT_SHOW_FAMILY|PS_SHOW_PORT, gc)));
+                                 print_sockaddr_ex(&e->local_sock.addr.sa, ",", PS_DONT_SHOW_FAMILY | PS_SHOW_PORT, gc)));
     }
     if (flags & LOG_PRINT_LOCAL_IP && !IN6_IS_ADDR_UNSPECIFIED(&e->local_ip6))
     {
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index f46274e6..1769d000 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -43,9 +43,9 @@
 struct man_def_auth_context {
     unsigned long cid;
 
-#define DAF_CONNECTION_ESTABLISHED (1<<0)
-#define DAF_CONNECTION_CLOSED      (1<<1)
-#define DAF_INITIAL_AUTH           (1<<2)
+#define DAF_CONNECTION_ESTABLISHED (1 << 0)
+#define DAF_CONNECTION_CLOSED      (1 << 1)
+#define DAF_INITIAL_AUTH           (1 << 2)
     unsigned int flags;
 
     unsigned int mda_key_id_counter;
@@ -95,23 +95,23 @@ struct log_entry
     union log_entry_union u;
 };
 
-#define LOG_PRINT_LOG_PREFIX   (1<<0)
-#define LOG_PRINT_ECHO_PREFIX  (1<<1)
-#define LOG_PRINT_STATE_PREFIX (1<<2)
+#define LOG_PRINT_LOG_PREFIX   (1 << 0)
+#define LOG_PRINT_ECHO_PREFIX  (1 << 1)
+#define LOG_PRINT_STATE_PREFIX (1 << 2)
 
-#define LOG_PRINT_INT_DATE     (1<<3)
-#define LOG_PRINT_MSG_FLAGS    (1<<4)
-#define LOG_PRINT_STATE        (1<<5)
-#define LOG_PRINT_LOCAL_IP     (1<<6)
+#define LOG_PRINT_INT_DATE     (1 << 3)
+#define LOG_PRINT_MSG_FLAGS    (1 << 4)
+#define LOG_PRINT_STATE        (1 << 5)
+#define LOG_PRINT_LOCAL_IP     (1 << 6)
 
-#define LOG_PRINT_CRLF         (1<<7)
-#define LOG_FATAL_NOTIFY       (1<<8)
+#define LOG_PRINT_CRLF         (1 << 7)
+#define LOG_FATAL_NOTIFY       (1 << 8)
 
-#define LOG_PRINT_INTVAL       (1<<9)
+#define LOG_PRINT_INTVAL       (1 << 9)
 
-#define LOG_PRINT_REMOTE_IP    (1<<10)
+#define LOG_PRINT_REMOTE_IP    (1 << 10)
 
-#define LOG_ECHO_TO_LOG        (1<<11)
+#define LOG_ECHO_TO_LOG        (1 << 11)
 
 const char *log_entry_print(const struct log_entry *e, unsigned int flags, struct gc_arena *gc);
 
@@ -153,7 +153,7 @@ struct management_callback
 {
     void *arg;
 
-#define MCF_SERVER (1<<0)  /* is OpenVPN being run as a server? */
+#define MCF_SERVER (1 << 0)  /* is OpenVPN being run as a server? */
     unsigned int flags;
 
     void (*status) (void *arg, const int version, struct status_output *so);
@@ -233,9 +233,9 @@ struct man_settings {
     int client_gid;
 
 /* flags for handling the management interface "signal" command */
-#define MANSIG_IGNORE_USR1_HUP  (1<<0)
-#define MANSIG_MAP_USR1_TO_HUP  (1<<1)
-#define MANSIG_MAP_USR1_TO_TERM (1<<2)
+#define MANSIG_IGNORE_USR1_HUP  (1 << 0)
+#define MANSIG_MAP_USR1_TO_HUP  (1 << 1)
+#define MANSIG_MAP_USR1_TO_TERM (1 << 2)
     unsigned int mansig;
 };
 
@@ -322,24 +322,24 @@ struct user_pass;
 struct management *management_init(void);
 
 /* management_open flags */
-#define MF_SERVER            (1<<0)
-#define MF_QUERY_PASSWORDS   (1<<1)
-#define MF_HOLD              (1<<2)
-#define MF_SIGNAL            (1<<3)
-#define MF_FORGET_DISCONNECT (1<<4)
-#define MF_CONNECT_AS_CLIENT (1<<5)
-#define MF_CLIENT_AUTH       (1<<6)
+#define MF_SERVER            (1 << 0)
+#define MF_QUERY_PASSWORDS   (1 << 1)
+#define MF_HOLD              (1 << 2)
+#define MF_SIGNAL            (1 << 3)
+#define MF_FORGET_DISCONNECT (1 << 4)
+#define MF_CONNECT_AS_CLIENT (1 << 5)
+#define MF_CLIENT_AUTH       (1 << 6)
 /* #define MF_CLIENT_PF         (1<<7) *REMOVED FEATURE* */
-#define MF_UNIX_SOCK                (1<<8)
-#define MF_EXTERNAL_KEY             (1<<9)
-#define MF_EXTERNAL_KEY_NOPADDING   (1<<10)
-#define MF_EXTERNAL_KEY_PKCS1PAD    (1<<11)
-#define MF_UP_DOWN                  (1<<12)
-#define MF_QUERY_REMOTE             (1<<13)
-#define MF_QUERY_PROXY              (1<<14)
-#define MF_EXTERNAL_CERT            (1<<15)
-#define MF_EXTERNAL_KEY_PSSPAD      (1<<16)
-#define MF_EXTERNAL_KEY_DIGEST      (1<<17)
+#define MF_UNIX_SOCK                (1 << 8)
+#define MF_EXTERNAL_KEY             (1 << 9)
+#define MF_EXTERNAL_KEY_NOPADDING   (1 << 10)
+#define MF_EXTERNAL_KEY_PKCS1PAD    (1 << 11)
+#define MF_UP_DOWN                  (1 << 12)
+#define MF_QUERY_REMOTE             (1 << 13)
+#define MF_QUERY_PROXY              (1 << 14)
+#define MF_EXTERNAL_CERT            (1 << 15)
+#define MF_EXTERNAL_KEY_PSSPAD      (1 << 16)
+#define MF_EXTERNAL_KEY_DIGEST      (1 << 17)
 
 bool management_open(struct management *man,
                      const char *addr,
@@ -570,7 +570,7 @@ management_bytes_server(struct management *man,
 {
     if (man->connection.bytecount_update_seconds > 0
         && now >= mdac->bytecount_last_update + man->connection.bytecount_update_seconds
-        && (mdac->flags & (DAF_CONNECTION_ESTABLISHED|DAF_CONNECTION_CLOSED)) == DAF_CONNECTION_ESTABLISHED)
+        && (mdac->flags & (DAF_CONNECTION_ESTABLISHED | DAF_CONNECTION_CLOSED)) == DAF_CONNECTION_ESTABLISHED)
     {
         man_bytecount_output_server(man, bytes_in_total, bytes_out_total, mdac);
     }
diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index c7b21aa3..088babd5 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -43,7 +43,7 @@ struct mbuf_buffer
     struct buffer buf;
     int refcount;
 
-#define MF_UNICAST (1<<0)
+#define MF_UNICAST (1 << 0)
     unsigned int flags;
 };
 
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 0ec806fc..055a62c2 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -87,7 +87,7 @@ hostname_randomize(const char *hostname, struct gc_arena *gc)
 
     uint8_t rnd_bytes[n_rnd_bytes];
     const char *rnd_str;
-    struct buffer hname = alloc_buf_gc(strlen(hostname) + sizeof(rnd_bytes)*2 + 4, gc);
+    struct buffer hname = alloc_buf_gc(strlen(hostname) + sizeof(rnd_bytes) * 2 + 4, gc);
 
     prng_bytes(rnd_bytes, sizeof(rnd_bytes));
     rnd_str = format_hex_ex(rnd_bytes, sizeof(rnd_bytes), 40, 0, NULL, gc);
@@ -294,7 +294,7 @@ get_user_pass_cr(struct user_pass *up,
                     buf_set_write(&packed_resp, (uint8_t *)up->password, USER_PASS_LEN);
 
                     if (!query_user_SINGLE(BSTR(&challenge), BLEN(&challenge),
-                                           response, USER_PASS_LEN, BOOL_CAST(ac->flags&CR_ECHO)))
+                                           response, USER_PASS_LEN, BOOL_CAST(ac->flags & CR_ECHO)))
                     {
                         msg(M_FATAL, "ERROR: could not read challenge response from stdin");
                     }
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 2a6c0b8b..7ad19bf7 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -76,8 +76,8 @@ struct user_pass
  * Challenge response info on client as pushed by server.
  */
 struct auth_challenge_info {
-#define CR_ECHO     (1<<0)  /* echo response when typed by user */
-#define CR_RESPONSE (1<<1)  /* response needed */
+#define CR_ECHO     (1 << 0)  /* echo response when typed by user */
+#define CR_RESPONSE (1 << 1)  /* response needed */
     unsigned int flags;
 
     const char *user;
@@ -91,7 +91,7 @@ struct auth_challenge_info *get_auth_challenge(const char *auth_challenge, struc
  * Challenge response info on client as pushed by server.
  */
 struct static_challenge_info {
-#define SC_ECHO     (1<<0)  /* echo response when typed by user */
+#define SC_ECHO     (1 << 0)  /* echo response when typed by user */
     unsigned int flags;
 
     const char *challenge_text;
@@ -105,19 +105,19 @@ struct static_challenge_info {};
 /*
  * Flags for get_user_pass and management_query_user_pass
  */
-#define GET_USER_PASS_MANAGEMENT    (1<<0)
+#define GET_USER_PASS_MANAGEMENT    (1 << 0)
 /* GET_USER_PASS_SENSITIVE     (1<<1)  not used anymore */
-#define GET_USER_PASS_PASSWORD_ONLY (1<<2)
-#define GET_USER_PASS_NEED_OK       (1<<3)
-#define GET_USER_PASS_NOFATAL       (1<<4)
-#define GET_USER_PASS_NEED_STR      (1<<5)
-#define GET_USER_PASS_PREVIOUS_CREDS_FAILED (1<<6)
+#define GET_USER_PASS_PASSWORD_ONLY (1 << 2)
+#define GET_USER_PASS_NEED_OK       (1 << 3)
+#define GET_USER_PASS_NOFATAL       (1 << 4)
+#define GET_USER_PASS_NEED_STR      (1 << 5)
+#define GET_USER_PASS_PREVIOUS_CREDS_FAILED (1 << 6)
 
-#define GET_USER_PASS_DYNAMIC_CHALLENGE      (1<<7) /* CRV1 protocol  -- dynamic challenge */
-#define GET_USER_PASS_STATIC_CHALLENGE       (1<<8) /* SCRV1 protocol -- static challenge */
-#define GET_USER_PASS_STATIC_CHALLENGE_ECHO  (1<<9) /* SCRV1 protocol -- echo response */
+#define GET_USER_PASS_DYNAMIC_CHALLENGE      (1 << 7) /* CRV1 protocol  -- dynamic challenge */
+#define GET_USER_PASS_STATIC_CHALLENGE       (1 << 8) /* SCRV1 protocol -- static challenge */
+#define GET_USER_PASS_STATIC_CHALLENGE_ECHO  (1 << 9) /* SCRV1 protocol -- echo response */
 
-#define GET_USER_PASS_INLINE_CREDS (1<<10)  /* indicates that auth_file is actually inline creds */
+#define GET_USER_PASS_INLINE_CREDS (1 << 10)  /* indicates that auth_file is actually inline creds */
 
 bool get_user_pass_cr(struct user_pass *up,
                       const char *auth_file,
@@ -217,7 +217,7 @@ prepend_dir(const char *dir, const char *path, struct gc_arena *gc);
 /* *INDENT-ON* */
 #define MAC_PRINT_ARG(_mac) _mac[0], _mac[1], _mac[2],  \
     _mac[3], _mac[4], _mac[5]
-#define MAC_SCAN_ARG(_mac) &_mac[0], &_mac[1], &_mac[2], \
+#define MAC_SCAN_ARG(_mac) & _mac[0], &_mac[1], &_mac[2], \
     &_mac[3], &_mac[4], &_mac[5]
 
 #endif /* ifndef MISC_H */
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 6268d218..fbe3c8c8 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -30,20 +30,20 @@
 
 #include <stddef.h>
 
-#define IP_MCAST_SUBNET_MASK  ((in_addr_t)240<<24)
-#define IP_MCAST_NETWORK      ((in_addr_t)224<<24)
+#define IP_MCAST_SUBNET_MASK  ((in_addr_t)240 << 24)
+#define IP_MCAST_NETWORK      ((in_addr_t)224 << 24)
 
 /* Return status values for mroute_extract_addr_from_packet */
 
-#define MROUTE_EXTRACT_SUCCEEDED (1<<0)
-#define MROUTE_EXTRACT_BCAST     (1<<1)
-#define MROUTE_EXTRACT_MCAST     (1<<2)
-#define MROUTE_EXTRACT_IGMP      (1<<3)
+#define MROUTE_EXTRACT_SUCCEEDED (1 << 0)
+#define MROUTE_EXTRACT_BCAST     (1 << 1)
+#define MROUTE_EXTRACT_MCAST     (1 << 2)
+#define MROUTE_EXTRACT_IGMP      (1 << 3)
 
-#define MROUTE_SEC_EXTRACT_SUCCEEDED (1<<(0 + MROUTE_SEC_SHIFT))
-#define MROUTE_SEC_EXTRACT_BCAST     (1<<(1 + MROUTE_SEC_SHIFT))
-#define MROUTE_SEC_EXTRACT_MCAST     (1<<(2 + MROUTE_SEC_SHIFT))
-#define MROUTE_SEC_EXTRACT_IGMP      (1<<(3 + MROUTE_SEC_SHIFT))
+#define MROUTE_SEC_EXTRACT_SUCCEEDED (1 << (0 + MROUTE_SEC_SHIFT))
+#define MROUTE_SEC_EXTRACT_BCAST     (1 << (1 + MROUTE_SEC_SHIFT))
+#define MROUTE_SEC_EXTRACT_MCAST     (1 << (2 + MROUTE_SEC_SHIFT))
+#define MROUTE_SEC_EXTRACT_IGMP      (1 << (3 + MROUTE_SEC_SHIFT))
 
 #define MROUTE_SEC_SHIFT         4
 
@@ -154,9 +154,9 @@ void mroute_addr_init(struct mroute_addr *addr);
 const char *mroute_addr_print(const struct mroute_addr *ma,
                               struct gc_arena *gc);
 
-#define MAPF_SUBNET            (1<<0)
-#define MAPF_IA_EMPTY_IF_UNDEF (1<<1)
-#define MAPF_SHOW_ARP          (1<<2)
+#define MAPF_SUBNET            (1 << 0)
+#define MAPF_IA_EMPTY_IF_UNDEF (1 << 1)
+#define MAPF_SHOW_ARP          (1 << 2)
 const char *mroute_addr_print_ex(const struct mroute_addr *ma,
                                  const unsigned int flags,
                                  struct gc_arena *gc);
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index d0a83090..43393147 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -193,13 +193,13 @@ mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)
                 {
                     continue;
                 }
-                mssval = (opt[2]<<8) + opt[3];
+                mssval = (opt[2] << 8) + opt[3];
                 if (mssval > maxmss)
                 {
                     dmsg(D_MSS, "MSS: %d -> %d", (int) mssval, (int) maxmss);
                     accumulate = htons(mssval);
-                    opt[2] = (maxmss>>8)&0xff;
-                    opt[3] = maxmss&0xff;
+                    opt[2] = (maxmss >> 8) & 0xff;
+                    opt[3] = maxmss & 0xff;
                     accumulate -= htons(maxmss);
                     ADJUST_CHECKSUM(accumulate, tc->check);
                 }
diff --git a/src/openvpn/mstats.c b/src/openvpn/mstats.c
index dd252d2c..d6a42997 100644
--- a/src/openvpn/mstats.c
+++ b/src/openvpn/mstats.c
@@ -86,7 +86,7 @@ mstats_open(const char *fn)
     }
 
     /* mmap the file */
-    data = mmap(NULL, sizeof(struct mmap_stats), PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
+    data = mmap(NULL, sizeof(struct mmap_stats), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
     if (data == MAP_FAILED)
     {
         msg(M_ERR, "mstats_open: write error: %s", fn);
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 1abb903f..0c8c96ba 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -439,7 +439,7 @@ multi_tcp_wait_lite(struct multi_context *m, struct multi_instance *mi, const in
 
         case TA_SOCKET_WRITE:
             looking_for = SOCKET_WRITE;
-            io_wait(c, IOW_TO_LINK|IOW_READ_TUN_FORCE);
+            io_wait(c, IOW_TO_LINK | IOW_READ_TUN_FORCE);
             break;
 
         default:
@@ -475,7 +475,7 @@ multi_tcp_wait_lite(struct multi_context *m, struct multi_instance *mi, const in
 static struct multi_instance *
 multi_tcp_dispatch(struct multi_context *m, struct multi_instance *mi, const int action)
 {
-    const unsigned int mpp_flags = MPP_PRE_SELECT|MPP_RECORD_TOUCH;
+    const unsigned int mpp_flags = MPP_PRE_SELECT | MPP_RECORD_TOUCH;
     struct multi_instance *touched = mi;
     m->mpp_touched = &touched;
 
@@ -559,8 +559,8 @@ multi_tcp_post(struct multi_context *m, struct multi_instance *mi, const int act
     int newaction = TA_UNDEF;
 
 #define MTP_NONE         0
-#define MTP_TUN_OUT      (1<<0)
-#define MTP_LINK_OUT     (1<<1)
+#define MTP_TUN_OUT      (1 << 0)
+#define MTP_LINK_OUT     (1 << 1)
     unsigned int flags = MTP_NONE;
 
     if (TUN_OUT(c))
@@ -574,7 +574,7 @@ multi_tcp_post(struct multi_context *m, struct multi_instance *mi, const int act
 
     switch (flags)
     {
-        case MTP_TUN_OUT|MTP_LINK_OUT:
+        case MTP_TUN_OUT | MTP_LINK_OUT:
         case MTP_TUN_OUT:
             newaction = TA_TUN_WRITE;
             break;
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index f60f4853..f6b38573 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -189,7 +189,7 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
          * overhead */
 
         /* overhead of BF-CBC: 64 bit block size, 64 bit IV size */
-        overhead += 64/8 + 64/8;
+        overhead += 64 / 8 + 64 / 8;
         /* set ciphername to none, so its size does get added in the
          * fake_kt and the cipher is not tried to be resolved */
         ciphername = "none";
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 4ab18b72..dabf318f 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -339,7 +339,7 @@ multi_process_io_udp(struct multi_context *m)
 #endif /* ifdef MULTI_DEBUG_EVENT_LOOP */
 
 #ifdef ENABLE_MANAGEMENT
-    if (status & (MANAGEMENT_READ|MANAGEMENT_WRITE))
+    if (status & (MANAGEMENT_READ | MANAGEMENT_WRITE))
     {
         ASSERT(management);
         management_io(management);
@@ -488,7 +488,7 @@ tunnel_server_udp(struct context *top)
         /* timeout? */
         if (multi.top.c2.event_set_status == ES_TIMEOUT)
         {
-            multi_process_timeout(&multi, MPP_PRE_SELECT|MPP_CLOSE_ON_SIGNAL);
+            multi_process_timeout(&multi, MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);
         }
         else
         {
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index b58bea7b..0aadd519 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1173,7 +1173,7 @@ multi_get_instance_by_virtual_addr(struct multi_context *m,
             {
                 /* found an applicable route, cache host route */
                 struct multi_instance *mi = route->instance;
-                multi_learn_addr(m, mi, addr, MULTI_ROUTE_CACHE|MULTI_ROUTE_AGEABLE);
+                multi_learn_addr(m, mi, addr, MULTI_ROUTE_CACHE | MULTI_ROUTE_AGEABLE);
                 ret = mi;
                 break;
             }
@@ -1635,7 +1635,7 @@ multi_client_connect_post(struct multi_context *m,
     {
         options_server_import(&mi->context.options,
                               dc_file,
-                              D_IMPORT_ERRORS|M_OPTERR,
+                              D_IMPORT_ERRORS | M_OPTERR,
                               CLIENT_CONNECT_OPT_MASK,
                               option_types_found,
                               mi->context.c2.es);
@@ -1676,7 +1676,7 @@ multi_client_connect_post_plugin(struct multi_context *m,
             {
                 options_string_import(&mi->context.options,
                                       config.list[i]->value,
-                                      D_IMPORT_ERRORS|M_OPTERR,
+                                      D_IMPORT_ERRORS | M_OPTERR,
                                       CLIENT_CONNECT_OPT_MASK,
                                       option_types_found,
                                       mi->context.c2.es);
@@ -1718,7 +1718,7 @@ multi_client_connect_mda(struct multi_context *m,
             const char *opt = BSTR(&be->buf);
             options_string_import(&mi->context.options,
                                   opt,
-                                  D_IMPORT_ERRORS|M_OPTERR,
+                                  D_IMPORT_ERRORS | M_OPTERR,
                                   CLIENT_CONNECT_OPT_MASK,
                                   option_types_found,
                                   mi->context.c2.es);
@@ -2581,7 +2581,7 @@ multi_client_connect_source_ccd(struct multi_context *m,
         {
             options_server_import(&mi->context.options,
                                   ccd_file,
-                                  D_IMPORT_ERRORS|M_OPTERR,
+                                  D_IMPORT_ERRORS | M_OPTERR,
                                   CLIENT_CONNECT_OPT_MASK,
                                   option_types_found,
                                   mi->context.c2.es);
@@ -3422,7 +3422,7 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                         /* check for broadcast */
                         if (m->enable_c2c)
                         {
-                            if (mroute_flags & (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))
+                            if (mroute_flags & (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))
                             {
                                 multi_bcast(m, &c->c2.to_tun, m->pending, NULL,
                                             vid);
@@ -3517,7 +3517,7 @@ multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp_flags
             struct context *c;
 
             /* broadcast or multicast dest addr? */
-            if (mroute_flags & (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))
+            if (mroute_flags & (MROUTE_EXTRACT_BCAST | MROUTE_EXTRACT_MCAST))
             {
                 /* for now, treat multicast as broadcast */
                 multi_bcast(m, &m->top.c2.buf, NULL, NULL, vid);
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 370d795c..68f1eaa9 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -228,8 +228,8 @@ struct multi_route
     struct mroute_addr addr;
     struct multi_instance *instance;
 
-#define MULTI_ROUTE_CACHE   (1<<0)
-#define MULTI_ROUTE_AGEABLE (1<<1)
+#define MULTI_ROUTE_CACHE   (1 << 0)
+#define MULTI_ROUTE_AGEABLE (1 << 1)
     unsigned int flags;
 
     unsigned int cache_generation;
@@ -282,10 +282,10 @@ bool multi_process_timeout(struct multi_context *m, const unsigned int mpp_flags
  */
 void multi_process_float(struct multi_context *m, struct multi_instance *mi);
 
-#define MPP_PRE_SELECT             (1<<0)
-#define MPP_CONDITIONAL_PRE_SELECT (1<<1)
-#define MPP_CLOSE_ON_SIGNAL        (1<<2)
-#define MPP_RECORD_TOUCH           (1<<3)
+#define MPP_PRE_SELECT             (1 << 0)
+#define MPP_CONDITIONAL_PRE_SELECT (1 << 1)
+#define MPP_CLOSE_ON_SIGNAL        (1 << 2)
+#define MPP_RECORD_TOUCH           (1 << 3)
 
 
 /**************************************************************************/
@@ -667,8 +667,8 @@ multi_process_outgoing_tun(struct multi_context *m, const unsigned int mpp_flags
 }
 
 #define CLIENT_CONNECT_OPT_MASK (OPT_P_INSTANCE | OPT_P_INHERIT   \
-                                 |OPT_P_PUSH | OPT_P_TIMER | OPT_P_CONFIG   \
-                                 |OPT_P_ECHO | OPT_P_COMP | OPT_P_SOCKFLAGS)
+                                 | OPT_P_PUSH | OPT_P_TIMER | OPT_P_CONFIG   \
+                                 | OPT_P_ECHO | OPT_P_COMP | OPT_P_SOCKFLAGS)
 
 static inline bool
 multi_process_outgoing_link_dowork(struct multi_context *m, struct multi_instance *mi, const unsigned int mpp_flags)
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index d7d7f264..41e17d72 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -312,7 +312,7 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2,
          */
         const size_t hoff = 0x14;
         unsigned long flags = buf2[hoff] | (buf2[hoff + 1] << 8)
-                              |(buf2[hoff + 2] << 16) | (buf2[hoff + 3] << 24);
+                              | (buf2[hoff + 2] << 16) | (buf2[hoff + 3] << 24);
         if ((flags & 0x00800000) == 0x00800000)
         {
             tib_len = buf2[0x28];            /* Get Target Information block size */
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 9d89bd0a..26e99f24 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -211,7 +211,7 @@ X509_get0_pubkey(const X509 *x)
  * @return                   the X509 object stack
  */
 static inline STACK_OF(X509_OBJECT)
-*X509_STORE_get0_objects(X509_STORE *store)
+* X509_STORE_get0_objects(X509_STORE * store)
 {
     return store ? store->objs : NULL;
 }
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 00cd652f..cffb1159 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -528,11 +528,11 @@ struct context
  */
 
 #define TLS_MODE(c) ((c)->c2.tls_multi != NULL)
-#define PROTO_DUMP_FLAGS (check_debug_level(D_LINK_RW_VERBOSE) ? (PD_SHOW_DATA|PD_VERBOSE) : 0)
+#define PROTO_DUMP_FLAGS (check_debug_level(D_LINK_RW_VERBOSE) ? (PD_SHOW_DATA | PD_VERBOSE) : 0)
 #define PROTO_DUMP(buf, gc) protocol_dump((buf), \
                                           PROTO_DUMP_FLAGS   \
-                                          |(c->c2.tls_multi ? PD_TLS : 0)   \
-                                          |(c->options.tls_auth_file ? md_kt_size(c->c1.ks.key_type.digest) : 0), \
+                                          | (c->c2.tls_multi ? PD_TLS : 0)   \
+                                          | (c->options.tls_auth_file ? md_kt_size(c->c1.ks.key_type.digest) : 0), \
                                           gc)
 
 /* this represents "disabled peer-id" */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d3ebe056..1070b8ac 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2629,7 +2629,7 @@ options_postprocess_verify_ce(const struct options *options,
                                || PLUGIN_OPTION_LIST(options)
                                || MAN_CLIENT_AUTH_ENABLED(options));
             const char *postfix = "must be used with --management-client-auth, an --auth-user-pass-verify script, or plugin";
-            if ((options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CERT_OPTIONAL)) && !ccnr)
+            if ((options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL)) && !ccnr)
             {
                 msg(M_USAGE, "--verify-client-cert none|optional %s", postfix);
             }
@@ -2706,7 +2706,7 @@ options_postprocess_verify_ce(const struct options *options,
         {
             msg(M_USAGE, "--connect-freq requires --mode server");
         }
-        if (options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CERT_OPTIONAL))
+        if (options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL))
         {
             msg(M_USAGE, "--verify-client-cert requires --mode server");
         }
@@ -2782,7 +2782,7 @@ options_postprocess_verify_ce(const struct options *options,
             "examples of a similar quick setup with peer-fingerprint.");
     }
 
-    if (options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CERT_OPTIONAL))
+    if (options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED | SSLF_CLIENT_CERT_OPTIONAL))
     {
         msg(M_WARN, "WARNING: POTENTIALLY DANGEROUS OPTION "
             "--verify-client-cert none|optional "
@@ -3585,7 +3585,7 @@ options_set_backwards_compatible_options(struct options *o)
     if (!comp_non_stub_enabled(&o->comp) && !need_compatibility_before(o, 20600)
         && (o->comp.flags == 0))
     {
-        o->comp.flags = COMP_F_ALLOW_STUB_ONLY|COMP_F_ADVERTISE_STUBS_ONLY;
+        o->comp.flags = COMP_F_ALLOW_STUB_ONLY | COMP_F_ADVERTISE_STUBS_ONLY;
     }
 #endif
 }
@@ -3727,11 +3727,11 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
  */
 #ifndef ENABLE_SMALL  /** Expect people using the stripped down version to know what they do */
 
-#define CHKACC_FILE (1<<0)       /** Check for a file/directory presence */
-#define CHKACC_DIRPATH (1<<1)    /** Check for directory presence where a file should reside */
-#define CHKACC_FILEXSTWR (1<<2)  /** If file exists, is it writable? */
-#define CHKACC_ACPTSTDIN (1<<3)  /** If filename is stdin, it's allowed and "exists" */
-#define CHKACC_PRIVATE (1<<4)    /** Warn if this (private) file is group/others accessible */
+#define CHKACC_FILE (1 << 0)       /** Check for a file/directory presence */
+#define CHKACC_DIRPATH (1 << 1)    /** Check for directory presence where a file should reside */
+#define CHKACC_FILEXSTWR (1 << 2)  /** If file exists, is it writable? */
+#define CHKACC_ACPTSTDIN (1 << 3)  /** If filename is stdin, it's allowed and "exists" */
+#define CHKACC_PRIVATE (1 << 4)    /** Warn if this (private) file is group/others accessible */
 
 static bool
 check_file_access(const int type, const char *file, const int mode, const char *opt)
@@ -3758,7 +3758,7 @@ check_file_access(const int type, const char *file, const int mode, const char *
         char *fullpath = string_alloc(file, NULL); /* POSIX dirname() implementation may modify its arguments */
         char *dirpath = dirname(fullpath);
 
-        if (platform_access(dirpath, mode|X_OK) != 0)
+        if (platform_access(dirpath, mode | X_OK) != 0)
         {
             errcode = errno;
         }
@@ -3791,7 +3791,7 @@ check_file_access(const int type, const char *file, const int mode, const char *
 #ifndef _WIN32
         else
         {
-            if (st.st_mode & (S_IRWXG|S_IRWXO))
+            if (st.st_mode & (S_IRWXG | S_IRWXO))
             {
                 msg(M_WARN, "WARNING: file '%s' is group or others accessible", file);
             }
@@ -3918,7 +3918,7 @@ check_cmd_access(const char *command, const char *opt, const char *chroot)
     }
     else
     {
-        msg(M_NOPREFIX|M_OPTERR, "%s fails with '%s': No path to executable.",
+        msg(M_NOPREFIX | M_OPTERR, "%s fails with '%s': No path to executable.",
             opt, command);
         return_code = true;
     }
@@ -3962,18 +3962,18 @@ options_postprocess_filechecks(struct options *options)
 #endif
     {
         errs |= check_file_access_inline(options->priv_key_file_inline,
-                                         CHKACC_FILE|CHKACC_PRIVATE,
+                                         CHKACC_FILE | CHKACC_PRIVATE,
                                          options->priv_key_file, R_OK, "--key");
     }
 
     errs |= check_file_access_inline(options->pkcs12_file_inline,
-                                     CHKACC_FILE|CHKACC_PRIVATE,
+                                     CHKACC_FILE | CHKACC_PRIVATE,
                                      options->pkcs12_file, R_OK, "--pkcs12");
 
     if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
     {
         errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE,
-                                         options->crl_file, R_OK|X_OK,
+                                         options->crl_file, R_OK | X_OK,
                                          "--crl-verify directory");
     }
     else
@@ -3990,55 +3990,55 @@ options_postprocess_filechecks(struct options *options)
         struct connection_entry *ce = options->connection_list->array[i];
 
         errs |= check_file_access_inline(ce->tls_auth_file_inline,
-                                         CHKACC_FILE|CHKACC_PRIVATE,
+                                         CHKACC_FILE | CHKACC_PRIVATE,
                                          ce->tls_auth_file, R_OK,
                                          "--tls-auth");
         errs |= check_file_access_inline(ce->tls_crypt_file_inline,
-                                         CHKACC_FILE|CHKACC_PRIVATE,
+                                         CHKACC_FILE | CHKACC_PRIVATE,
                                          ce->tls_crypt_file, R_OK,
                                          "--tls-crypt");
         errs |= check_file_access_inline(ce->tls_crypt_v2_file_inline,
-                                         CHKACC_FILE|CHKACC_PRIVATE,
+                                         CHKACC_FILE | CHKACC_PRIVATE,
                                          ce->tls_crypt_v2_file, R_OK,
                                          "--tls-crypt-v2");
     }
 
     errs |= check_file_access_inline(options->shared_secret_file_inline,
-                                     CHKACC_FILE|CHKACC_PRIVATE,
+                                     CHKACC_FILE | CHKACC_PRIVATE,
                                      options->shared_secret_file, R_OK,
                                      "--secret");
 
-    errs |= check_file_access(CHKACC_DIRPATH|CHKACC_FILEXSTWR,
-                              options->packet_id_file, R_OK|W_OK, "--replay-persist");
+    errs |= check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR,
+                              options->packet_id_file, R_OK | W_OK, "--replay-persist");
 
     /* ** Password files ** */
-    errs |= check_file_access(CHKACC_FILE|CHKACC_ACPTSTDIN|CHKACC_PRIVATE,
+    errs |= check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
                               options->key_pass_file, R_OK, "--askpass");
 #ifdef ENABLE_MANAGEMENT
-    errs |= check_file_access(CHKACC_FILE|CHKACC_ACPTSTDIN|CHKACC_PRIVATE,
+    errs |= check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
                               options->management_user_pass, R_OK,
                               "--management user/password file");
 #endif /* ENABLE_MANAGEMENT */
-    errs |= check_file_access(CHKACC_FILE|CHKACC_ACPTSTDIN|CHKACC_PRIVATE,
+    errs |= check_file_access(CHKACC_FILE | CHKACC_ACPTSTDIN | CHKACC_PRIVATE,
                               options->auth_user_pass_file, R_OK,
                               "--auth-user-pass");
     /* ** System related ** */
     errs |= check_file_access(CHKACC_FILE, options->chroot_dir,
-                              R_OK|X_OK, "--chroot directory");
-    errs |= check_file_access(CHKACC_DIRPATH|CHKACC_FILEXSTWR, options->writepid,
-                              R_OK|W_OK, "--writepid");
+                              R_OK | X_OK, "--chroot directory");
+    errs |= check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->writepid,
+                              R_OK | W_OK, "--writepid");
 
     /* ** Log related ** */
-    errs |= check_file_access(CHKACC_DIRPATH|CHKACC_FILEXSTWR, options->status_file,
-                              R_OK|W_OK, "--status");
+    errs |= check_file_access(CHKACC_DIRPATH | CHKACC_FILEXSTWR, options->status_file,
+                              R_OK | W_OK, "--status");
 
     /* ** Config related ** */
     errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->tls_export_cert,
-                                     R_OK|W_OK|X_OK, "--tls-export-cert");
+                                     R_OK | W_OK | X_OK, "--tls-export-cert");
     errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->client_config_dir,
-                                     R_OK|X_OK, "--client-config-dir");
+                                     R_OK | X_OK, "--client-config-dir");
     errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->tmp_dir,
-                                     R_OK|W_OK|X_OK, "Temporary directory (--tmp-dir)");
+                                     R_OK | W_OK | X_OK, "Temporary directory (--tmp-dir)");
 
     if (errs)
     {
@@ -4723,7 +4723,7 @@ usage(void)
 void
 usage_small(void)
 {
-    msg(M_WARN|M_NOPREFIX, "Use --help for more information.");
+    msg(M_WARN | M_NOPREFIX, "Use --help for more information.");
     openvpn_exit(OPENVPN_EXIT_STATUS_USAGE); /* exit point */
 }
 
@@ -4755,19 +4755,19 @@ show_library_versions(const unsigned int flags)
 static void
 usage_version(void)
 {
-    msg(M_INFO|M_NOPREFIX, "%s", title_string);
-    show_library_versions( M_INFO|M_NOPREFIX );
+    msg(M_INFO | M_NOPREFIX, "%s", title_string);
+    show_library_versions( M_INFO | M_NOPREFIX );
 #ifdef _WIN32
-    show_windows_version( M_INFO|M_NOPREFIX );
+    show_windows_version( M_INFO | M_NOPREFIX );
 #endif
-    msg(M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
-    msg(M_INFO|M_NOPREFIX, "Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>");
+    msg(M_INFO | M_NOPREFIX, "Originally developed by James Yonan");
+    msg(M_INFO | M_NOPREFIX, "Copyright (C) 2002-2022 OpenVPN Inc <sales@...515...>");
 #ifndef ENABLE_SMALL
 #ifdef CONFIGURE_DEFINES
-    msg(M_INFO|M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
+    msg(M_INFO | M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
 #endif
 #ifdef CONFIGURE_SPECIAL_BUILD
-    msg(M_INFO|M_NOPREFIX, "special build: %s", CONFIGURE_SPECIAL_BUILD);
+    msg(M_INFO | M_NOPREFIX, "special build: %s", CONFIGURE_SPECIAL_BUILD);
 #endif
 #endif
     openvpn_exit(OPENVPN_EXIT_STATUS_GOOD);
@@ -4993,7 +4993,7 @@ parse_line(const char *line,
         int i;
         for (i = 0; i < ret; ++i)
         {
-            msg(M_INFO|M_NOPREFIX, "%s:%d ARG[%d] '%s'", file, line_num, i, p[i]);
+            msg(M_INFO | M_NOPREFIX, "%s:%d ARG[%d] '%s'", file, line_num, i, p[i]);
         }
     }
 #endif
@@ -5047,7 +5047,7 @@ read_inline_file(struct in_src *is, const char *close_tag,
                  int *num_lines, struct gc_arena *gc)
 {
     char line[OPTION_LINE_SIZE];
-    struct buffer buf = alloc_buf(8*OPTION_LINE_SIZE);
+    struct buffer buf = alloc_buf(8 * OPTION_LINE_SIZE);
     char *ret;
     bool endtagfound = false;
 
@@ -5368,7 +5368,7 @@ apply_push_options(struct options *options,
     char line[OPTION_PARM_SIZE];
     int line_num = 0;
     const char *file = "[PUSH-OPTIONS]";
-    const int msglevel = D_PUSH_ERRORS|M_OPTERR;
+    const int msglevel = D_PUSH_ERRORS | M_OPTERR;
 
     while (buf_parse(buf, ',', line, sizeof(line)))
     {
@@ -5485,7 +5485,7 @@ verify_permission(const char *name,
  * many parameters.
  */
 
-#define NM_QUOTE_HINT (1<<0)
+#define NM_QUOTE_HINT (1 << 0)
 
 static bool
 no_more_than_n_args(const int msglevel,
@@ -5817,7 +5817,7 @@ add_option(struct options *options,
          * padding is supported
          */
         if (!(options->management_flags
-              &(MF_EXTERNAL_KEY_NOPADDING | MF_EXTERNAL_KEY_PKCS1PAD)))
+              & (MF_EXTERNAL_KEY_NOPADDING | MF_EXTERNAL_KEY_PKCS1PAD)))
         {
             options->management_flags |= MF_EXTERNAL_KEY_PKCS1PAD;
         }
@@ -5991,7 +5991,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "local") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
         options->ce.local = p[1];
     }
     else if (streq(p[0], "remote-random") && !p[1])
@@ -6001,7 +6001,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "connection") && p[1] && !p[3])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);
         if (is_inline)
         {
             struct options sub;
@@ -6094,7 +6094,7 @@ add_option(struct options *options,
         re.proto = -1;
         re.af = 0;
 
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
         re.remote = p[1];
         if (p[2])
         {
@@ -6153,7 +6153,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "connect-retry") && p[1] && !p[3])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
         options->ce.connect_retry_seconds = positive_atoi(p[1]);
         /*
          * Limit the base value of retry wait interval to 16 bits to avoid
@@ -6175,12 +6175,12 @@ add_option(struct options *options,
     else if ((streq(p[0], "connect-timeout") || streq(p[0], "server-poll-timeout"))
              && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
         options->ce.connect_timeout = positive_atoi(p[1]);
     }
     else if (streq(p[0], "connect-retry-max") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
         options->connect_retry_max = positive_atoi(p[1]);
     }
     else if (streq(p[0], "ipchange") && p[1])
@@ -6197,7 +6197,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "float") && !p[1])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
         options->ce.remote_float = true;
     }
 #ifdef ENABLE_DEBUG
@@ -6403,32 +6403,32 @@ add_option(struct options *options,
     }
     else if ((streq(p[0], "link-mtu") || streq(p[0], "udp-mtu")) && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
         options->ce.link_mtu = positive_atoi(p[1]);
         options->ce.link_mtu_defined = true;
     }
     else if (streq(p[0], "tun-mtu") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
         options->ce.tun_mtu = positive_atoi(p[1]);
         options->ce.tun_mtu_defined = true;
     }
     else if (streq(p[0], "tun-mtu-extra") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
         options->ce.tun_mtu_extra = positive_atoi(p[1]);
         options->ce.tun_mtu_extra_defined = true;
     }
 #ifdef ENABLE_FRAGMENT
     else if (streq(p[0], "mtu-dynamic"))
     {
-        VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
         msg(msglevel, "--mtu-dynamic has been replaced by --fragment");
         goto err;
     }
     else if (streq(p[0], "fragment") && p[1] && !p[3])
     {
-        VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
         options->ce.fragment = positive_atoi(p[1]);
 
         if (p[2] && streq(p[2], "mtu"))
@@ -6443,7 +6443,7 @@ add_option(struct options *options,
 #endif /* ifdef ENABLE_FRAGMENT */
     else if (streq(p[0], "mtu-disc") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
         options->ce.mtu_discover_type = translate_mtu_discover_type_name(p[1]);
     }
     else if (streq(p[0], "mtu-test") && !p[1])
@@ -6522,23 +6522,23 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "port") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
         options->ce.local_port = options->ce.remote_port = p[1];
     }
     else if (streq(p[0], "lport") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
         options->ce.local_port_defined = true;
         options->ce.local_port = p[1];
     }
     else if (streq(p[0], "rport") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
         options->ce.remote_port = p[1];
     }
     else if (streq(p[0], "bind") && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
         options->ce.bind_defined = true;
         if (p[1] && streq(p[1], "ipv6only"))
         {
@@ -6548,7 +6548,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "nobind") && !p[1])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
         options->ce.bind_local = false;
     }
     else if (streq(p[0], "fast-io") && !p[1])
@@ -6578,7 +6578,7 @@ add_option(struct options *options,
     {
         int proto;
         sa_family_t af;
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
         proto = ascii2proto(p[1]);
         af = ascii2af(p[1]);
         if (proto < 0)
@@ -6608,7 +6608,7 @@ add_option(struct options *options,
     {
         struct http_proxy_options *ho;
 
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
 
         {
             if (!p[2])
@@ -6655,21 +6655,21 @@ add_option(struct options *options,
     else if (streq(p[0], "http-proxy-user-pass") && p[1])
     {
         struct http_proxy_options *ho;
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);
         ho = init_http_proxy_options_once(&options->ce.http_proxy_options, &options->gc);
         ho->auth_file = p[1];
         ho->inline_creds = is_inline;
     }
     else if (streq(p[0], "http-proxy-retry") || streq(p[0], "socks-proxy-retry"))
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
         msg(M_WARN, "DEPRECATED OPTION: http-proxy-retry and socks-proxy-retry: "
             "In OpenVPN 2.4 proxy connection retries are handled like regular connections. "
             "Use connect-retry-max 1 to get a similar behavior as before.");
     }
     else if (streq(p[0], "http-proxy-timeout") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
         msg(M_WARN, "DEPRECATED OPTION: http-proxy-timeout: In OpenVPN 2.4 the timeout until a connection to a "
             "server is established is managed with a single timeout set by connect-timeout");
     }
@@ -6677,7 +6677,7 @@ add_option(struct options *options,
     {
         struct http_proxy_options *ho;
 
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
         ho = init_http_proxy_options_once(&options->ce.http_proxy_options, &options->gc);
 
         if (streq(p[1], "VERSION") && p[2] && !p[3])
@@ -6724,7 +6724,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "socks-proxy") && p[1] && !p[4])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
 
         if (p[2])
         {
@@ -6767,7 +6767,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "explicit-exit-notify") && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION|OPT_P_EXPLICIT_NOTIFY);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION | OPT_P_EXPLICIT_NOTIFY);
         if (p[1])
         {
             options->ce.explicit_exit_notification = positive_atoi(p[1]);
@@ -7101,7 +7101,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "mssfix") && !p[3])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
         if (p[1])
         {
             /* value specified, assume encapsulation is not
@@ -7453,7 +7453,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "auth-gen-token-secret") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);
         options->auth_token_secret_file = p[1];
         options->auth_token_secret_file_inline = is_inline;
 
@@ -7561,8 +7561,8 @@ add_option(struct options *options,
         in_addr_t local, remote_netmask;
 
         VERIFY_PERMISSION(OPT_P_INSTANCE);
-        local = getaddr(GETADDR_HOST_ORDER|GETADDR_RESOLVE, p[1], 0, NULL, NULL);
-        remote_netmask = getaddr(GETADDR_HOST_ORDER|GETADDR_RESOLVE, p[2], 0, NULL, NULL);
+        local = getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[1], 0, NULL, NULL);
+        remote_netmask = getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[2], 0, NULL, NULL);
         if (local && remote_netmask)
         {
             options->push_ifconfig_defined = true;
@@ -7570,7 +7570,7 @@ add_option(struct options *options,
             options->push_ifconfig_remote_netmask = remote_netmask;
             if (p[3])
             {
-                options->push_ifconfig_local_alias = getaddr(GETADDR_HOST_ORDER|GETADDR_RESOLVE, p[3], 0, NULL, NULL);
+                options->push_ifconfig_local_alias = getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[3], 0, NULL, NULL);
             }
         }
         else
@@ -7584,7 +7584,7 @@ add_option(struct options *options,
         in_addr_t network, netmask;
 
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        network = getaddr(GETADDR_HOST_ORDER|GETADDR_RESOLVE, p[1], 0, NULL, NULL);
+        network = getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[1], 0, NULL, NULL);
         netmask = getaddr(GETADDR_HOST_ORDER, p[2], 0, NULL, NULL);
         if (network && netmask)
         {
@@ -8024,14 +8024,14 @@ add_option(struct options *options,
     else if (streq(p[0], "show-adapters") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        show_tap_win_adapters(M_INFO|M_NOPREFIX, M_WARN|M_NOPREFIX);
+        show_tap_win_adapters(M_INFO | M_NOPREFIX, M_WARN | M_NOPREFIX);
         openvpn_exit(OPENVPN_EXIT_STATUS_GOOD); /* exit point */
     }
     else if (streq(p[0], "show-net") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        show_routes(M_INFO|M_NOPREFIX);
-        show_adapters(M_INFO|M_NOPREFIX);
+        show_routes(M_INFO | M_NOPREFIX);
+        show_adapters(M_INFO | M_NOPREFIX);
         openvpn_exit(OPENVPN_EXIT_STATUS_GOOD); /* exit point */
     }
     else if (streq(p[0], "show-net-up") && !p[1])
@@ -8181,7 +8181,7 @@ add_option(struct options *options,
         if (streq(p[1], "no"))
         {
             options->comp.flags =
-                COMP_F_ALLOW_STUB_ONLY|COMP_F_ADVERTISE_STUBS_ONLY;
+                COMP_F_ALLOW_STUB_ONLY | COMP_F_ADVERTISE_STUBS_ONLY;
             if (comp_non_stub_enabled(&options->comp))
             {
                 msg(msglevel, "'--allow-compression no' conflicts with "
@@ -8281,7 +8281,7 @@ add_option(struct options *options,
             if (streq(p[1], "stub"))
             {
                 options->comp.alg = COMP_ALG_STUB;
-                options->comp.flags |= (COMP_F_SWAP|COMP_F_ADVERTISE_STUBS_ONLY);
+                options->comp.flags |= (COMP_F_SWAP | COMP_F_ADVERTISE_STUBS_ONLY);
             }
             else if (streq(p[1], "stub-v2"))
             {
@@ -8352,7 +8352,7 @@ add_option(struct options *options,
     {
         int key_direction;
 
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
 
         key_direction = ascii2keydirection(msglevel, p[1]);
         if (key_direction >= 0)
@@ -8374,7 +8374,7 @@ add_option(struct options *options,
     else if (streq(p[0], "secret") && p[1] && !p[3])
     {
         msg(M_WARN, "DEPRECATED OPTION: The option --secret is deprecated.");
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);
         options->shared_secret_file = p[1];
         options->shared_secret_file_inline = is_inline;
         if (!is_inline && p[2])
@@ -8441,19 +8441,19 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "cipher") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_NCP|OPT_P_INSTANCE);
+        VERIFY_PERMISSION(OPT_P_NCP | OPT_P_INSTANCE);
         options->ciphername = p[1];
     }
     else if (streq(p[0], "data-ciphers-fallback") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INSTANCE);
         options->ciphername = p[1];
         options->enable_ncp_fallback = true;
     }
     else if ((streq(p[0], "data-ciphers") || streq(p[0], "ncp-ciphers"))
              && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INSTANCE);
         if (streq(p[0], "ncp-ciphers"))
         {
             msg(M_INFO, "Note: Treating option '--ncp-ciphers' as "
@@ -8597,7 +8597,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "ca") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);
         options->ca_file = p[1];
         options->ca_file_inline = is_inline;
     }
@@ -8610,26 +8610,26 @@ add_option(struct options *options,
 #endif /* ENABLE_CRYPTO_MBEDTLS */
     else if (streq(p[0], "dh") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);
         options->dh_file = p[1];
         options->dh_file_inline = is_inline;
     }
     else if (streq(p[0], "cert") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);
         options->cert_file = p[1];
         options->cert_file_inline = is_inline;
     }
     else if (streq(p[0], "extra-certs") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);
         options->extra_certs_file = p[1];
         options->extra_certs_file_inline = is_inline;
     }
     else if ((streq(p[0], "verify-hash") && p[1] && !p[3])
              || (streq(p[0], "peer-fingerprint") && p[1] && !p[2]))
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);
 
         int verify_hash_depth = 0;
         if (streq(p[0], "verify-hash"))
@@ -8698,7 +8698,7 @@ add_option(struct options *options,
 #endif
     else if (streq(p[0], "key") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);
         options->priv_key_file = p[1];
         options->priv_key_file_inline = is_inline;
     }
@@ -8733,7 +8733,7 @@ add_option(struct options *options,
 #ifndef ENABLE_CRYPTO_MBEDTLS
     else if (streq(p[0], "pkcs12") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);
         options->pkcs12_file = p[1];
         options->pkcs12_file_inline = is_inline;
     }
@@ -8809,7 +8809,7 @@ add_option(struct options *options,
     else if (streq(p[0], "crl-verify") && p[1] && ((p[2] && streq(p[2], "dir"))
                                                    || !p[2]))
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INLINE);
         if (p[2] && streq(p[2], "dir"))
         {
             options->ssl_flags |= SSLF_CRL_VERIFY_DIR;
@@ -8971,7 +8971,7 @@ add_option(struct options *options,
     {
         int key_direction = -1;
 
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION|OPT_P_INLINE);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION | OPT_P_INLINE);
 
         if (permission_mask & OPT_P_GENERAL)
         {
@@ -9008,7 +9008,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "tls-crypt") && p[1] && !p[3])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION|OPT_P_INLINE);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION | OPT_P_INLINE);
         if (permission_mask & OPT_P_GENERAL)
         {
             options->tls_crypt_file = p[1];
@@ -9022,7 +9022,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "tls-crypt-v2") && p[1] && !p[3])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION|OPT_P_INLINE);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION | OPT_P_INLINE);
         if (permission_mask & OPT_P_GENERAL)
         {
             options->tls_crypt_v2_file = p[1];
@@ -9274,7 +9274,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "vlan-pvid") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
+        VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INSTANCE);
         options->vlan_pvid = positive_atoi(p[1]);
         if (options->vlan_pvid < OPENVPN_8021Q_MIN_VID
             || options->vlan_pvid > OPENVPN_8021Q_MAX_VID)
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 6d9174a4..a2df8b26 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -138,8 +138,8 @@ struct connection_entry
 
     int explicit_exit_notification; /* Explicitly tell peer when we are exiting via OCC_EXIT or [RESTART] message */
 
-#define CE_DISABLED (1<<0)
-#define CE_MAN_QUERY_PROXY (1<<1)
+#define CE_DISABLED (1 << 0)
+#define CE_MAN_QUERY_PROXY (1 << 1)
 #define CE_MAN_QUERY_REMOTE_UNDEF  0
 #define CE_MAN_QUERY_REMOTE_QUERY  1
 #define CE_MAN_QUERY_REMOTE_ACCEPT 2
@@ -443,9 +443,9 @@ struct options
     struct in6_addr server_network_ipv6;                /* IPv6 */
     unsigned int server_netbits_ipv6;                   /* IPv6 */
 
-#define SF_NOPOOL (1<<0)
-#define SF_TCP_NODELAY_HELPER (1<<1)
-#define SF_NO_PUSH_ROUTE_GATEWAY (1<<2)
+#define SF_NOPOOL (1 << 0)
+#define SF_TCP_NODELAY_HELPER (1 << 1)
+#define SF_NO_PUSH_ROUTE_GATEWAY (1 << 2)
     unsigned int server_flags;
 
     bool server_bridge_proxy_dhcp;
@@ -688,38 +688,38 @@ struct options
 /*
  * Option classes.
  */
-#define OPT_P_GENERAL         (1<<0)
-#define OPT_P_UP              (1<<1)
-#define OPT_P_ROUTE           (1<<2)
-#define OPT_P_DHCPDNS         (1<<3)    /* includes ip windows options like */
-#define OPT_P_SCRIPT          (1<<4)
-#define OPT_P_SETENV          (1<<5)
-#define OPT_P_SHAPER          (1<<6)
-#define OPT_P_TIMER           (1<<7)
-#define OPT_P_PERSIST         (1<<8)
-#define OPT_P_PERSIST_IP      (1<<9)
-#define OPT_P_COMP            (1<<10) /* TODO */
-#define OPT_P_MESSAGES        (1<<11)
-#define OPT_P_NCP             (1<<12) /**< Negotiable crypto parameters */
-#define OPT_P_TLS_PARMS       (1<<13) /* TODO */
-#define OPT_P_MTU             (1<<14) /* TODO */
-#define OPT_P_NICE            (1<<15)
-#define OPT_P_PUSH            (1<<16)
-#define OPT_P_INSTANCE        (1<<17) /**< allowed in ccd, client-connect etc*/
-#define OPT_P_CONFIG          (1<<18)
-#define OPT_P_EXPLICIT_NOTIFY (1<<19)
-#define OPT_P_ECHO            (1<<20)
-#define OPT_P_INHERIT         (1<<21)
-#define OPT_P_ROUTE_EXTRAS    (1<<22)
-#define OPT_P_PULL_MODE       (1<<23)
-#define OPT_P_PLUGIN          (1<<24)
-#define OPT_P_SOCKBUF         (1<<25)
-#define OPT_P_SOCKFLAGS       (1<<26)
-#define OPT_P_CONNECTION      (1<<27)
-#define OPT_P_PEER_ID         (1<<28)
-#define OPT_P_INLINE          (1<<29)
-
-#define OPT_P_DEFAULT   (~(OPT_P_INSTANCE|OPT_P_PULL_MODE))
+#define OPT_P_GENERAL         (1 << 0)
+#define OPT_P_UP              (1 << 1)
+#define OPT_P_ROUTE           (1 << 2)
+#define OPT_P_DHCPDNS         (1 << 3)    /* includes ip windows options like */
+#define OPT_P_SCRIPT          (1 << 4)
+#define OPT_P_SETENV          (1 << 5)
+#define OPT_P_SHAPER          (1 << 6)
+#define OPT_P_TIMER           (1 << 7)
+#define OPT_P_PERSIST         (1 << 8)
+#define OPT_P_PERSIST_IP      (1 << 9)
+#define OPT_P_COMP            (1 << 10) /* TODO */
+#define OPT_P_MESSAGES        (1 << 11)
+#define OPT_P_NCP             (1 << 12) /**< Negotiable crypto parameters */
+#define OPT_P_TLS_PARMS       (1 << 13) /* TODO */
+#define OPT_P_MTU             (1 << 14) /* TODO */
+#define OPT_P_NICE            (1 << 15)
+#define OPT_P_PUSH            (1 << 16)
+#define OPT_P_INSTANCE        (1 << 17) /**< allowed in ccd, client-connect etc*/
+#define OPT_P_CONFIG          (1 << 18)
+#define OPT_P_EXPLICIT_NOTIFY (1 << 19)
+#define OPT_P_ECHO            (1 << 20)
+#define OPT_P_INHERIT         (1 << 21)
+#define OPT_P_ROUTE_EXTRAS    (1 << 22)
+#define OPT_P_PULL_MODE       (1 << 23)
+#define OPT_P_PLUGIN          (1 << 24)
+#define OPT_P_SOCKBUF         (1 << 25)
+#define OPT_P_SOCKFLAGS       (1 << 26)
+#define OPT_P_CONNECTION      (1 << 27)
+#define OPT_P_PEER_ID         (1 << 28)
+#define OPT_P_INLINE          (1 << 29)
+
+#define OPT_P_DEFAULT   (~(OPT_P_INSTANCE | OPT_P_PULL_MODE))
 
 #define PULL_DEFINED(opt) ((opt)->pull)
 #define PUSH_DEFINED(opt) ((opt)->push_list)
diff --git a/src/openvpn/perf.c b/src/openvpn/perf.c
index adab5bc2..28203d50 100644
--- a/src/openvpn/perf.c
+++ b/src/openvpn/perf.c
@@ -290,7 +290,7 @@ perf_output_results(void)
         if (p->count > 0.0)
         {
             const double mean = p->sum / p->count;
-            msg(M_INFO, "%s n=%.0f mean=%.3f max=%.3f", metric_names[i], p->count, mean*1000.0, p->max*1000.0);
+            msg(M_INFO, "%s n=%.0f mean=%.3f max=%.3f", metric_names[i], p->count, mean * 1000.0, p->max * 1000.0);
         }
     }
 }
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index a2f7b52a..2287686f 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -63,7 +63,7 @@ void
 __mysleep(const unsigned long usec)
 {
 #if defined(_WIN32)
-    Sleep(usec/1000);
+    Sleep(usec / 1000);
 #else
     usleep(usec);
 #endif
@@ -173,7 +173,7 @@ _pkcs11_openvpn_log(
     va_list args
     )
 {
-    char Buffer[10*1024];
+    char Buffer[10 * 1024];
 
     (void)global_data;
 
@@ -215,7 +215,7 @@ _pkcs11_openvpn_token_prompt(
             &token_resp,
             NULL,
             "token-insertion-request",
-            GET_USER_PASS_MANAGEMENT|GET_USER_PASS_NEED_OK|GET_USER_PASS_NOFATAL
+            GET_USER_PASS_MANAGEMENT | GET_USER_PASS_NEED_OK | GET_USER_PASS_NOFATAL
             )
         )
     {
@@ -257,7 +257,7 @@ _pkcs11_openvpn_pin_prompt(
             &token_pass,
             NULL,
             prompt,
-            GET_USER_PASS_MANAGEMENT|GET_USER_PASS_PASSWORD_ONLY|GET_USER_PASS_NOFATAL
+            GET_USER_PASS_MANAGEMENT | GET_USER_PASS_PASSWORD_ONLY | GET_USER_PASS_NOFATAL
             )
         )
     {
@@ -692,7 +692,7 @@ tls_ctx_use_pkcs11(
                 &id_resp,
                 NULL,
                 "pkcs11-id-request",
-                GET_USER_PASS_MANAGEMENT|GET_USER_PASS_NEED_STR|GET_USER_PASS_NOFATAL
+                GET_USER_PASS_MANAGEMENT | GET_USER_PASS_NEED_STR | GET_USER_PASS_NOFATAL
                 )
             )
         {
@@ -884,7 +884,7 @@ show_pkcs11_ids(
     }
 
     msg(
-        M_INFO|M_NOPREFIX|M_NOLF,
+        M_INFO | M_NOPREFIX | M_NOLF,
         (
             "\n"
             "The following objects are available for use.\n"
@@ -969,7 +969,7 @@ show_pkcs11_ids(
         }
 
         msg(
-            M_INFO|M_NOPREFIX|M_NOLF,
+            M_INFO | M_NOPREFIX | M_NOLF,
             (
                 "\n"
                 "Certificate\n"
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index de492ddd..f5f819e7 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -45,7 +45,7 @@
 #ifdef HAVE_XKEY_PROVIDER
 static XKEY_EXTERNAL_SIGN_fn xkey_pkcs11h_sign;
 
-#if PKCS11H_VERSION > ((1<<16) | (27<<8)) /* version > 1.27 */
+#if PKCS11H_VERSION > ((1 << 16) | (27 << 8)) /* version > 1.27 */
 
 /* Table linking OpenSSL digest NID with CKM and CKG constants in PKCS#11 */
 #define MD_TYPE(n) {NID_sha ## n, CKM_SHA ## n, CKG_MGF1_SHA ## n}
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 327a2d23..868a9785 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -348,11 +348,11 @@ platform_mlockall(bool print_msg)
     {
         msg(M_INFO, "mlock: MEMLOCK limit: soft=%ld KB, hard=%ld KB",
             ((long int) rl.rlim_cur) / 1024, ((long int) rl.rlim_max) / 1024);
-        if (rl.rlim_cur < MIN_LOCKED_MEM_MB*1024*1024)
+        if (rl.rlim_cur < MIN_LOCKED_MEM_MB * 1024 * 1024)
         {
             msg(M_INFO, "mlock: RLIMIT_MEMLOCK < %d MB, increase limit",
                 MIN_LOCKED_MEM_MB);
-            rl.rlim_cur = MIN_LOCKED_MEM_MB*1024*1024;
+            rl.rlim_cur = MIN_LOCKED_MEM_MB * 1024 * 1024;
             if (rl.rlim_max < rl.rlim_cur)
             {
                 rl.rlim_max = rl.rlim_cur;
@@ -600,8 +600,8 @@ platform_gen_path(const char *directory, const char *filename,
                   struct gc_arena *gc)
 {
 #ifdef _WIN32
-    const int CC_PATH_RESERVED = CC_LESS_THAN|CC_GREATER_THAN|CC_COLON
-                                 |CC_DOUBLE_QUOTE|CC_SLASH|CC_BACKSLASH|CC_PIPE|CC_QUESTION_MARK|CC_ASTERISK;
+    const int CC_PATH_RESERVED = CC_LESS_THAN | CC_GREATER_THAN | CC_COLON
+                                 | CC_DOUBLE_QUOTE | CC_SLASH | CC_BACKSLASH | CC_PIPE | CC_QUESTION_MARK | CC_ASTERISK;
 #else
     const int CC_PATH_RESERVED = CC_SLASH;
 #endif
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 9190a43b..659c0501 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -47,7 +47,7 @@
 #include "win32.h"
 #include "memdbg.h"
 
-#define PLUGIN_SYMBOL_REQUIRED (1<<0)
+#define PLUGIN_SYMBOL_REQUIRED (1 << 0)
 
 /* used only for program aborts */
 static struct plugin_common *static_plugin_common = NULL; /* GLOBAL */
@@ -152,7 +152,7 @@ plugin_mask_string(const unsigned int type_mask, struct gc_arena *gc)
 static inline unsigned int
 plugin_supported_types(void)
 {
-    return ((1<<OPENVPN_PLUGIN_N) - 1);
+    return ((1 << OPENVPN_PLUGIN_N) - 1);
 }
 
 struct plugin_option_list *
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 2bbedfcc..79ce8904 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -560,7 +560,7 @@ ifconfig_pool_persist_init(const char *filename, int refresh_freq)
     if (refresh_freq > 0)
     {
         ret->fixed = false;
-        ret->file = status_open(filename, refresh_freq, -1, NULL, STATUS_OUTPUT_READ|STATUS_OUTPUT_WRITE);
+        ret->file = status_open(filename, refresh_freq, -1, NULL, STATUS_OUTPUT_READ | STATUS_OUTPUT_WRITE);
     }
     else
     {
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 5b52a10a..90606757 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -184,14 +184,14 @@ struct openvpn_tcphdr {
 #define OPENVPN_TCPH_GET_DOFF(d) (((d) & 0xF0) >> 2)
     uint8_t doff_res;
 
-#define OPENVPN_TCPH_FIN_MASK (1<<0)
-#define OPENVPN_TCPH_SYN_MASK (1<<1)
-#define OPENVPN_TCPH_RST_MASK (1<<2)
-#define OPENVPN_TCPH_PSH_MASK (1<<3)
-#define OPENVPN_TCPH_ACK_MASK (1<<4)
-#define OPENVPN_TCPH_URG_MASK (1<<5)
-#define OPENVPN_TCPH_ECE_MASK (1<<6)
-#define OPENVPN_TCPH_CWR_MASK (1<<7)
+#define OPENVPN_TCPH_FIN_MASK (1 << 0)
+#define OPENVPN_TCPH_SYN_MASK (1 << 1)
+#define OPENVPN_TCPH_RST_MASK (1 << 2)
+#define OPENVPN_TCPH_PSH_MASK (1 << 3)
+#define OPENVPN_TCPH_ACK_MASK (1 << 4)
+#define OPENVPN_TCPH_URG_MASK (1 << 5)
+#define OPENVPN_TCPH_ECE_MASK (1 << 6)
+#define OPENVPN_TCPH_CWR_MASK (1 << 7)
     uint8_t flags;
 
     uint16_t window;
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 20a62681..fc6d62fd 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -243,7 +243,7 @@ port_share_sendmsg(const socket_descriptor_t sd,
         status = sendmsg(sd, &mesg, MSG_NOSIGNAL);
         if (status == -1)
         {
-            msg(M_WARN|M_ERRNO, "PORT SHARE: sendmsg failed -- unable to communicate with background process (%d,%d,%d,%d)",
+            msg(M_WARN | M_ERRNO, "PORT SHARE: sendmsg failed -- unable to communicate with background process (%d,%d,%d,%d)",
                 sd, sd_send, sd_null[0], sd_null[1]
                 );
         }
@@ -370,7 +370,7 @@ journal_add(const char *journal_dir, struct proxy_connection *pc, struct proxy_c
         }
         else
         {
-            msg(M_WARN|M_ERRNO, "PORT SHARE: unable to write journal file in %s", jfn);
+            msg(M_WARN | M_ERRNO, "PORT SHARE: unable to write journal file in %s", jfn);
             free(jfn);
         }
     }
@@ -429,7 +429,7 @@ proxy_entry_new(struct proxy_connection **list,
     /* connect to port share server */
     if ((sd_server = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
     {
-        msg(M_WARN|M_ERRNO, "PORT SHARE PROXY: cannot create socket");
+        msg(M_WARN | M_ERRNO, "PORT SHARE PROXY: cannot create socket");
         return false;
     }
     status = openvpn_connect(sd_server, (const struct sockaddr *)  &server_addr, 5, NULL);
@@ -479,7 +479,7 @@ proxy_entry_new(struct proxy_connection **list,
 
     /* set initial i/o states */
     proxy_connection_io_requeue(pc, EVENT_READ, es);
-    proxy_connection_io_requeue(cp, EVENT_READ|EVENT_WRITE, es);
+    proxy_connection_io_requeue(cp, EVENT_READ | EVENT_WRITE, es);
 
     return true;
 }
@@ -837,7 +837,7 @@ port_share_open(const char *host,
      * Get host's IP address
      */
 
-    status = openvpn_getaddrinfo(GETADDR_RESOLVE|GETADDR_FATAL,
+    status = openvpn_getaddrinfo(GETADDR_RESOLVE | GETADDR_FATAL,
                                  host, port,  0, NULL, AF_INET, &ai);
     ASSERT(status == 0);
     hostaddr = *((struct sockaddr_in *) ai->ai_addr);
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index b24550b3..755f7017 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -292,7 +292,7 @@ receive_auth_pending(struct context *c, const struct buffer *buffer)
 
     /* Cap the increase at the maximum time we are willing stay in the
      * pending authentication state */
-    unsigned int max_timeout = max_uint(c->options.renegotiate_seconds/2,
+    unsigned int max_timeout = max_uint(c->options.renegotiate_seconds / 2,
                                         c->options.handshake_window);
 
     /* try to parse parameter keywords, default to hand-winow timeout if the
@@ -386,7 +386,7 @@ send_auth_pending_messages(struct tls_multi *tls_multi, const char *extra,
 
 
     /* Calculate the maximum timeout and subtract the time we already waited */
-    unsigned int max_timeout = max_uint(tls_multi->opt.renegotiate_seconds/2,
+    unsigned int max_timeout = max_uint(tls_multi->opt.renegotiate_seconds / 2,
                                         tls_multi->opt.handshake_window);
     max_timeout = max_timeout - (now - ks->initial);
     timeout = min_uint(max_timeout, timeout);
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 7856d6a2..bd5ca8c8 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -128,7 +128,7 @@ reliable_ack_read_packet_id(struct buffer *buf, packet_id_type *pid)
     {
         *pid = ntohpid(net_pid);
         dmsg(D_REL_DEBUG, "ACK read ID " packet_id_format " (buf->len=%d)",
-             (packet_id_print_type)*pid, buf->len);
+             (packet_id_print_type) * pid, buf->len);
         return true;
     }
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 33d2812b..aade0e85 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -552,7 +552,7 @@ add_block_local_item(struct route_list *rl,
                      const struct route_gateway_address *gateway,
                      in_addr_t target)
 {
-    const int rgi_needed = (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
+    const int rgi_needed = (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED);
     if ((rl->rgi.flags & rgi_needed) == rgi_needed
         && rl->rgi.gateway.netmask < 0xFFFFFFFF)
     {
@@ -563,7 +563,7 @@ add_block_local_item(struct route_list *rl,
         ALLOC_OBJ_GC(r2, struct route_ipv4, &rl->gc);
 
         /* split a route into two smaller blocking routes, and direct them to target */
-        l2 = ((~gateway->netmask) + 1)>>1;
+        l2 = ((~gateway->netmask) + 1) >> 1;
         r1->flags = RT_DEFINED;
         r1->gateway = target;
         r1->network = gateway->addr & gateway->netmask;
@@ -581,7 +581,7 @@ add_block_local_item(struct route_list *rl,
 static void
 add_block_local(struct route_list *rl)
 {
-    const int rgi_needed = (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
+    const int rgi_needed = (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED);
     if ((rl->flags & RG_BLOCK_LOCAL)
         && (rl->rgi.flags & rgi_needed) == rgi_needed
         && (rl->spec.flags & RTSA_REMOTE_ENDPOINT)
@@ -867,8 +867,8 @@ init_route_ipv6_list(struct route_ipv6_list *rl6,
     /* add VPN server host route if needed */
     if (need_remote_ipv6_route)
     {
-        if ( (rl6->rgi6.flags & (RGI_ADDR_DEFINED|RGI_IFACE_DEFINED) ) ==
-             (RGI_ADDR_DEFINED|RGI_IFACE_DEFINED) )
+        if ( (rl6->rgi6.flags & (RGI_ADDR_DEFINED | RGI_IFACE_DEFINED) ) ==
+             (RGI_ADDR_DEFINED | RGI_IFACE_DEFINED) )
         {
             struct route_ipv6 *r6;
             ALLOC_OBJ_CLEAR_GC(r6, struct route_ipv6, &rl6->gc);
@@ -931,7 +931,7 @@ del_route3(in_addr_t network,
 {
     struct route_ipv4 r;
     CLEAR(r);
-    r.flags = RT_DEFINED|RT_ADDED;
+    r.flags = RT_DEFINED | RT_ADDED;
     r.network = network;
     r.netmask = netmask;
     r.gateway = gateway;
@@ -1527,7 +1527,7 @@ local_route(in_addr_t network,
             const struct route_gateway_info *rgi)
 {
     /* set LR_MATCH on local host routes */
-    const int rgi_needed = (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED|RGI_IFACE_DEFINED);
+    const int rgi_needed = (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED | RGI_IFACE_DEFINED);
     if (rgi
         && (rgi->flags & rgi_needed) == rgi_needed
         && gateway == rgi->gateway.addr
@@ -2160,7 +2160,7 @@ delete_route(struct route_ipv4 *r,
 #endif
     int is_local_route;
 
-    if ((r->flags & (RT_DEFINED|RT_ADDED)) != (RT_DEFINED|RT_ADDED))
+    if ((r->flags & (RT_DEFINED | RT_ADDED)) != (RT_DEFINED | RT_ADDED))
     {
         return;
     }
@@ -2346,7 +2346,7 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
 #endif
     bool gateway_needed = false;
 
-    if ((r6->flags & (RT_DEFINED|RT_ADDED)) != (RT_DEFINED|RT_ADDED))
+    if ((r6->flags & (RT_DEFINED | RT_ADDED)) != (RT_DEFINED | RT_ADDED))
     {
         return;
     }
@@ -2742,7 +2742,7 @@ get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
             if (a_index != TUN_ADAPTER_INDEX_INVALID)
             {
                 rgi->adapter_index = a_index;
-                rgi->flags |= (RGI_IFACE_DEFINED|RGI_NETMASK_DEFINED);
+                rgi->flags |= (RGI_IFACE_DEFINED | RGI_NETMASK_DEFINED);
                 ai = get_adapter(adapters, a_index);
                 if (ai)
                 {
@@ -3727,7 +3727,7 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
     }
     if (write(sockfd, (char *)&m_rtmsg, l) < 0)
     {
-        msg(M_WARN|M_ERRNO, "GDG6: problem writing to routing socket");
+        msg(M_WARN | M_ERRNO, "GDG6: problem writing to routing socket");
         goto done;
     }
 
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 1afd0dbb..1e75129d 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -47,8 +47,8 @@
 /*
  * Route add/delete flags (must stay clear of ROUTE_METHOD bits)
  */
-#define ROUTE_DELETE_FIRST  (1<<2)
-#define ROUTE_REF_GW        (1<<3)
+#define ROUTE_DELETE_FIRST  (1 << 2)
+#define ROUTE_REF_GW        (1 << 3)
 
 struct route_bypass
 {
@@ -60,9 +60,9 @@ struct route_bypass
 struct route_special_addr
 {
     /* bits indicating which members below are defined */
-#define RTSA_REMOTE_ENDPOINT  (1<<0)
-#define RTSA_REMOTE_HOST      (1<<1)
-#define RTSA_DEFAULT_METRIC   (1<<2)
+#define RTSA_REMOTE_ENDPOINT  (1 << 0)
+#define RTSA_REMOTE_HOST      (1 << 1)
+#define RTSA_DEFAULT_METRIC   (1 << 2)
     unsigned int flags;
 
     in_addr_t remote_endpoint;
@@ -81,14 +81,14 @@ struct route_option {
 };
 
 /* redirect-gateway flags */
-#define RG_ENABLE         (1<<0)
-#define RG_LOCAL          (1<<1)
-#define RG_DEF1           (1<<2)
-#define RG_BYPASS_DHCP    (1<<3)
-#define RG_BYPASS_DNS     (1<<4)
-#define RG_REROUTE_GW     (1<<5)
-#define RG_AUTO_LOCAL     (1<<6)
-#define RG_BLOCK_LOCAL    (1<<7)
+#define RG_ENABLE         (1 << 0)
+#define RG_LOCAL          (1 << 1)
+#define RG_DEF1           (1 << 2)
+#define RG_BYPASS_DHCP    (1 << 3)
+#define RG_BYPASS_DNS     (1 << 4)
+#define RG_REROUTE_GW     (1 << 5)
+#define RG_AUTO_LOCAL     (1 << 6)
+#define RG_BLOCK_LOCAL    (1 << 7)
 
 struct route_option_list {
     unsigned int flags; /* RG_x flags */
@@ -110,9 +110,9 @@ struct route_ipv6_option_list {
 };
 
 struct route_ipv4 {
-#define RT_DEFINED        (1<<0)
-#define RT_ADDED          (1<<1)
-#define RT_METRIC_DEFINED (1<<2)
+#define RT_DEFINED        (1 << 0)
+#define RT_ADDED          (1 << 1)
+#define RT_METRIC_DEFINED (1 << 2)
     struct route_ipv4 *next;
     unsigned int flags;
     const struct route_option *option;
@@ -144,12 +144,12 @@ struct route_gateway_address {
 };
 
 struct route_gateway_info {
-#define RGI_ADDR_DEFINED     (1<<0)  /* set if gateway.addr defined */
-#define RGI_NETMASK_DEFINED  (1<<1)  /* set if gateway.netmask defined */
-#define RGI_HWADDR_DEFINED   (1<<2)  /* set if hwaddr is defined */
-#define RGI_IFACE_DEFINED    (1<<3)  /* set if iface is defined */
-#define RGI_OVERFLOW         (1<<4)  /* set if more interface addresses than will fit in addrs */
-#define RGI_ON_LINK          (1<<5)
+#define RGI_ADDR_DEFINED     (1 << 0)  /* set if gateway.addr defined */
+#define RGI_NETMASK_DEFINED  (1 << 1)  /* set if gateway.netmask defined */
+#define RGI_HWADDR_DEFINED   (1 << 2)  /* set if hwaddr is defined */
+#define RGI_IFACE_DEFINED    (1 << 3)  /* set if iface is defined */
+#define RGI_OVERFLOW         (1 << 4)  /* set if more interface addresses than will fit in addrs */
+#define RGI_ON_LINK          (1 << 5)
     unsigned int flags;
 
     /* gateway interface */
@@ -204,9 +204,9 @@ struct route_ipv6_gateway_info {
 };
 
 struct route_list {
-#define RL_DID_REDIRECT_DEFAULT_GATEWAY (1<<0)
-#define RL_DID_LOCAL                    (1<<1)
-#define RL_ROUTES_ADDED                 (1<<2)
+#define RL_DID_REDIRECT_DEFAULT_GATEWAY (1 << 0)
+#define RL_DID_LOCAL                    (1 << 1)
+#define RL_ROUTES_ADDED                 (1 << 2)
     unsigned int iflags;
 
     struct route_special_addr spec;
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index 966283ab..5a9cf222 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -42,11 +42,11 @@ int script_security(void);
 void script_security_set(int level);
 
 /* openvpn_execve flags */
-#define S_SCRIPT    (1<<0)
-#define S_FATAL     (1<<1)
+#define S_SCRIPT    (1 << 0)
+#define S_FATAL     (1 << 1)
 /** Instead of returning 1/0 for success/fail,
  * return exit code when between 0 and 255 and -1 otherwise */
-#define S_EXITCODE  (1<<2)
+#define S_EXITCODE  (1 << 2)
 
 /* wrapper around the execve() call */
 int openvpn_popen(const struct argv *a,  const struct env_set *es);
diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
index 7e42e81c..b36c01d6 100644
--- a/src/openvpn/shaper.h
+++ b/src/openvpn/shaper.h
@@ -132,10 +132,10 @@ shaper_wrote_bytes(struct shaper *s, int nbytes)
     /* compute delay in microseconds */
     tv.tv_sec = 0;
 #ifdef SHAPER_USE_FP
-    tv.tv_usec = min_int((int)((double)max_int(nbytes, 100) * s->factor), (SHAPER_MAX_TIMEOUT*1000000));
+    tv.tv_usec = min_int((int)((double)max_int(nbytes, 100) * s->factor), (SHAPER_MAX_TIMEOUT * 1000000));
 #else
     tv.tv_usec = s->bytes_per_second
-                 ? min_int(max_int(nbytes, 100) * s->factor, (SHAPER_MAX_TIMEOUT*1000000))
+                 ? min_int(max_int(nbytes, 100) * s->factor, (SHAPER_MAX_TIMEOUT * 1000000))
                  : 0;
 #endif
 
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index c05704f1..6979a249 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -332,9 +332,9 @@ do_preresolve(struct context *c)
     int i;
     struct connection_list *l = c->options.connection_list;
     const unsigned int preresolve_flags = GETADDR_RESOLVE
-                                          |GETADDR_UPDATE_MANAGEMENT_STATE
-                                          |GETADDR_MENTION_RESOLVE_RETRY
-                                          |GETADDR_FATAL;
+                                          | GETADDR_UPDATE_MANAGEMENT_STATE
+                                          | GETADDR_MENTION_RESOLVE_RETRY
+                                          | GETADDR_FATAL;
 
 
     for (i = 0; i < l->len; ++i)
@@ -463,7 +463,7 @@ openvpn_getaddrinfo(unsigned int flags,
         msglevel |= M_MSG_VIRT_OUT;
     }
 
-    if ((flags & (GETADDR_FATAL_ON_SIGNAL|GETADDR_WARN_ON_SIGNAL))
+    if ((flags & (GETADDR_FATAL_ON_SIGNAL | GETADDR_WARN_ON_SIGNAL))
         && !signal_received)
     {
         signal_received = &sigrec;
@@ -495,7 +495,7 @@ openvpn_getaddrinfo(unsigned int flags,
         const int fail_wait_interval = 5; /* seconds */
         /* Add +4 to cause integer division rounding up (1 + 4) = 5, (0+4)/5=0 */
         int resolve_retries = (flags & GETADDR_TRY_ONCE) ? 1 :
-                              ((resolve_retry_seconds + 4)/ fail_wait_interval);
+                              ((resolve_retry_seconds + 4) / fail_wait_interval);
         const char *fmt;
         int level = 0;
 
@@ -670,11 +670,11 @@ openvpn_inet_aton(const char *dotted_quad, struct in_addr *addr)
     {
         if (a < 256 && b < 256 && c < 256 && d < 256)
         {
-            addr->s_addr = htonl(a<<24 | b<<16 | c<<8 | d);
+            addr->s_addr = htonl(a << 24 | b << 16 | c << 8 | d);
             return OIA_IP; /* good dotted quad */
         }
     }
-    if (string_class(dotted_quad, CC_DIGIT|CC_DOT, 0))
+    if (string_class(dotted_quad, CC_DIGIT | CC_DOT, 0))
     {
         return OIA_ERROR; /* probably a badly formatted dotted quad */
     }
@@ -762,7 +762,7 @@ dns_addr_safe(const char *addr)
     if (addr)
     {
         const size_t len = strlen(addr);
-        return len > 0 && len <= 255 && string_class(addr, CC_ALNUM|CC_DASH|CC_DOT, 0);
+        return len > 0 && len <= 255 && string_class(addr, CC_ALNUM | CC_DASH | CC_DOT, 0);
     }
     else
     {
@@ -1147,7 +1147,7 @@ create_socket(struct link_socket *sock, struct addrinfo *addr)
         msg(M_INFO, "Using bind-dev %s", sock->bind_dev);
         if (setsockopt(sock->sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_dev, strlen(sock->bind_dev) + 1) != 0)
         {
-            msg(M_WARN|M_ERRNO, "WARN: setsockopt SO_BINDTODEVICE=%s failed", sock->bind_dev);
+            msg(M_WARN | M_ERRNO, "WARN: setsockopt SO_BINDTODEVICE=%s failed", sock->bind_dev);
         }
 
     }
@@ -1413,7 +1413,7 @@ socket_bind(socket_descriptor_t sd,
         msg(M_INFO, "setsockopt(IPV6_V6ONLY=%d)", v6only);
         if (setsockopt(sd, IPPROTO_IPV6, IPV6_V6ONLY, (void *) &v6only, sizeof(v6only)))
         {
-            msg(M_NONFATAL|M_ERRNO, "Setting IPV6_V6ONLY=%d failed", v6only);
+            msg(M_NONFATAL | M_ERRNO, "Setting IPV6_V6ONLY=%d failed", v6only);
         }
     }
     if (bind(sd, cur->ai_addr, cur->ai_addrlen))
@@ -1657,7 +1657,7 @@ resolve_bind_local(struct link_socket *sock, const sa_family_t af)
     if (!sock->info.lsa->bind_local)
     {
         int flags = GETADDR_RESOLVE | GETADDR_WARN_ON_SIGNAL
-                    |GETADDR_FATAL | GETADDR_PASSIVE;
+                    | GETADDR_FATAL | GETADDR_PASSIVE;
         int status;
 
         if (proto_is_dgram(sock->info.proto))
@@ -1703,7 +1703,7 @@ resolve_remote(struct link_socket *sock,
     {
         if (sock->remote_host)
         {
-            unsigned int flags = sf2gaf(GETADDR_RESOLVE|GETADDR_UPDATE_MANAGEMENT_STATE, sock->sockflags);
+            unsigned int flags = sf2gaf(GETADDR_RESOLVE | GETADDR_UPDATE_MANAGEMENT_STATE, sock->sockflags);
             int retry = 0;
             int status = -1;
             struct addrinfo *ai;
@@ -2814,7 +2814,7 @@ print_sockaddr_ex(const struct sockaddr *sa,
 const char *
 print_link_socket_actual(const struct link_socket_actual *act, struct gc_arena *gc)
 {
-    return print_link_socket_actual_ex(act, ":", PS_SHOW_PORT|PS_SHOW_PKTINFO, gc);
+    return print_link_socket_actual_ex(act, ":", PS_SHOW_PORT | PS_SHOW_PKTINFO, gc);
 }
 
 #ifndef IF_NAMESIZE
@@ -2962,7 +2962,7 @@ add_in6_addr( struct in6_addr base, uint32_t add )
          * 8-bit and(!) 32-bit overruns nicely
          */
         carry = ((h & 0xff)  + (add & 0xff)) >> 8;
-        add = (add>>8) + carry;
+        add = (add >> 8) + carry;
     }
     return base;
 }
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 462afa31..7eaa16ce 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -202,11 +202,11 @@ struct link_socket
 
     int mtu;                    /* OS discovered MTU, or 0 if unknown */
 
-#define SF_USE_IP_PKTINFO (1<<0)
-#define SF_TCP_NODELAY (1<<1)
-#define SF_PORT_SHARE (1<<2)
-#define SF_HOST_RANDOMIZE (1<<3)
-#define SF_GETADDRINFO_DGRAM (1<<4)
+#define SF_USE_IP_PKTINFO (1 << 0)
+#define SF_TCP_NODELAY (1 << 1)
+#define SF_PORT_SHARE (1 << 2)
+#define SF_HOST_RANDOMIZE (1 << 3)
+#define SF_GETADDRINFO_DGRAM (1 << 4)
     unsigned int sockflags;
     int mark;
     const char *bind_dev;
@@ -337,11 +337,11 @@ void link_socket_close(struct link_socket *sock);
 
 void sd_close(socket_descriptor_t *sd);
 
-#define PS_SHOW_PORT_IF_DEFINED (1<<0)
-#define PS_SHOW_PORT            (1<<1)
-#define PS_SHOW_PKTINFO         (1<<2)
-#define PS_DONT_SHOW_ADDR       (1<<3)
-#define PS_DONT_SHOW_FAMILY     (1<<4)
+#define PS_SHOW_PORT_IF_DEFINED (1 << 0)
+#define PS_SHOW_PORT            (1 << 1)
+#define PS_SHOW_PKTINFO         (1 << 2)
+#define PS_DONT_SHOW_ADDR       (1 << 3)
+#define PS_DONT_SHOW_FAMILY     (1 << 4)
 
 const char *print_sockaddr_ex(const struct sockaddr *addr,
                               const char *separator,
@@ -385,8 +385,8 @@ const char *print_link_socket_actual(const struct link_socket_actual *act,
                                      struct gc_arena *gc);
 
 
-#define IA_EMPTY_IF_UNDEF (1<<0)
-#define IA_NET_ORDER      (1<<1)
+#define IA_EMPTY_IF_UNDEF (1 << 0)
+#define IA_NET_ORDER      (1 << 1)
 const char *print_in_addr_t(in_addr_t addr, unsigned int flags, struct gc_arena *gc);
 
 const char *print_in6_addr(struct in6_addr addr6, unsigned int flags, struct gc_arena *gc);
@@ -395,8 +395,8 @@ const char *print_in_port_t(in_port_t port, struct gc_arena *gc);
 
 struct in6_addr add_in6_addr( struct in6_addr base, uint32_t add );
 
-#define SA_IP_PORT        (1<<0)
-#define SA_SET_IF_NONZERO (1<<1)
+#define SA_IP_PORT        (1 << 0)
+#define SA_SET_IF_NONZERO (1 << 1)
 void setenv_sockaddr(struct env_set *es,
                      const char *name_prefix,
                      const struct openvpn_sockaddr *addr,
@@ -501,20 +501,20 @@ bool unix_socket_get_peer_uid_gid(const socket_descriptor_t sd, int *uid, int *g
  * DNS resolution
  */
 
-#define GETADDR_RESOLVE               (1<<0)
-#define GETADDR_FATAL                 (1<<1)
-#define GETADDR_HOST_ORDER            (1<<2)
-#define GETADDR_MENTION_RESOLVE_RETRY (1<<3)
-#define GETADDR_FATAL_ON_SIGNAL       (1<<4)
-#define GETADDR_WARN_ON_SIGNAL        (1<<5)
-#define GETADDR_MSG_VIRT_OUT          (1<<6)
-#define GETADDR_TRY_ONCE              (1<<7)
-#define GETADDR_UPDATE_MANAGEMENT_STATE (1<<8)
-#define GETADDR_RANDOMIZE             (1<<9)
-#define GETADDR_PASSIVE               (1<<10)
-#define GETADDR_DATAGRAM              (1<<11)
-
-#define GETADDR_CACHE_MASK              (GETADDR_DATAGRAM|GETADDR_PASSIVE)
+#define GETADDR_RESOLVE               (1 << 0)
+#define GETADDR_FATAL                 (1 << 1)
+#define GETADDR_HOST_ORDER            (1 << 2)
+#define GETADDR_MENTION_RESOLVE_RETRY (1 << 3)
+#define GETADDR_FATAL_ON_SIGNAL       (1 << 4)
+#define GETADDR_WARN_ON_SIGNAL        (1 << 5)
+#define GETADDR_MSG_VIRT_OUT          (1 << 6)
+#define GETADDR_TRY_ONCE              (1 << 7)
+#define GETADDR_UPDATE_MANAGEMENT_STATE (1 << 8)
+#define GETADDR_RANDOMIZE             (1 << 9)
+#define GETADDR_PASSIVE               (1 << 10)
+#define GETADDR_DATAGRAM              (1 << 11)
+
+#define GETADDR_CACHE_MASK              (GETADDR_DATAGRAM | GETADDR_PASSIVE)
 
 /**
  * Translate an IPv4 addr or hostname from string form to in_addr_t
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d13556b2..85e7d580 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -363,7 +363,7 @@ pem_password_setup(const char *auth_file)
 {
     if (!strlen(passbuf.password))
     {
-        get_user_pass(&passbuf, auth_file, UP_TYPE_PRIVATE_KEY, GET_USER_PASS_MANAGEMENT|GET_USER_PASS_PASSWORD_ONLY);
+        get_user_pass(&passbuf, auth_file, UP_TYPE_PRIVATE_KEY, GET_USER_PASS_MANAGEMENT | GET_USER_PASS_PASSWORD_ONLY);
     }
 }
 
@@ -406,12 +406,12 @@ auth_user_pass_setup(const char *auth_file, const struct static_challenge_info *
             get_user_pass_cr(&auth_user_pass,
                              auth_file,
                              UP_TYPE_AUTH,
-                             GET_USER_PASS_MANAGEMENT|GET_USER_PASS_DYNAMIC_CHALLENGE,
+                             GET_USER_PASS_MANAGEMENT | GET_USER_PASS_DYNAMIC_CHALLENGE,
                              auth_challenge);
         }
         else if (sci) /* static challenge response */
         {
-            int flags = GET_USER_PASS_MANAGEMENT|GET_USER_PASS_STATIC_CHALLENGE;
+            int flags = GET_USER_PASS_MANAGEMENT | GET_USER_PASS_STATIC_CHALLENGE;
             if (sci->flags & SC_ECHO)
             {
                 flags |= GET_USER_PASS_STATIC_CHALLENGE_ECHO;
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 76b1b674..9395d34f 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -76,25 +76,25 @@
  * as reserved for this reason */
 
 /** Support P_DATA_V2 */
-#define IV_PROTO_DATA_V2        (1<<1)
+#define IV_PROTO_DATA_V2        (1 << 1)
 
 /** Assume client will send a push request and server does not need
  * to wait for a push-request to send a push-reply */
-#define IV_PROTO_REQUEST_PUSH   (1<<2)
+#define IV_PROTO_REQUEST_PUSH   (1 << 2)
 
 /** Supports key derivation via TLS key material exporter [RFC5705] */
-#define IV_PROTO_TLS_KEY_EXPORT (1<<3)
+#define IV_PROTO_TLS_KEY_EXPORT (1 << 3)
 
 /** Supports signaling keywords with AUTH_PENDING, e.g. timeout=xy */
-#define IV_PROTO_AUTH_PENDING_KW (1<<4)
+#define IV_PROTO_AUTH_PENDING_KW (1 << 4)
 
 /** Support doing NCP in P2P mode. This mode works by both peers looking at
  * each other's IV_ variables and deterministically deciding both on the same
  * result. */
-#define IV_PROTO_NCP_P2P         (1<<5)
+#define IV_PROTO_NCP_P2P         (1 << 5)
 
 /** Supports the --dns option introduced in version 2.6 */
-#define IV_PROTO_DNS_OPTION      (1<<6)
+#define IV_PROTO_DNS_OPTION      (1 << 6)
 
 /* Default field in X509 to be username */
 #define X509_USERNAME_FIELD_DEFAULT "CN"
@@ -499,9 +499,9 @@ tls_set_single_session(struct tls_multi *multi)
  * protocol_dump() flags
  */
 #define PD_TLS_AUTH_HMAC_SIZE_MASK 0xFF
-#define PD_SHOW_DATA               (1<<8)
-#define PD_TLS                     (1<<9)
-#define PD_VERBOSE                 (1<<10)
+#define PD_SHOW_DATA               (1 << 8)
+#define PD_TLS                     (1 << 9)
+#define PD_VERBOSE                 (1 << 10)
 
 const char *protocol_dump(struct buffer *buffer,
                           unsigned int flags,
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index c565d78c..448dc548 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -388,17 +388,17 @@ struct tls_options
 #endif
 
     /* configuration file SSL-related boolean and low-permutation options */
-#define SSLF_CLIENT_CERT_NOT_REQUIRED (1<<0)
-#define SSLF_CLIENT_CERT_OPTIONAL     (1<<1)
-#define SSLF_USERNAME_AS_COMMON_NAME  (1<<2)
-#define SSLF_AUTH_USER_PASS_OPTIONAL  (1<<3)
-#define SSLF_OPT_VERIFY               (1<<4)
-#define SSLF_CRL_VERIFY_DIR           (1<<5)
+#define SSLF_CLIENT_CERT_NOT_REQUIRED (1 << 0)
+#define SSLF_CLIENT_CERT_OPTIONAL     (1 << 1)
+#define SSLF_USERNAME_AS_COMMON_NAME  (1 << 2)
+#define SSLF_AUTH_USER_PASS_OPTIONAL  (1 << 3)
+#define SSLF_OPT_VERIFY               (1 << 4)
+#define SSLF_CRL_VERIFY_DIR           (1 << 5)
 #define SSLF_TLS_VERSION_MIN_SHIFT    6
 #define SSLF_TLS_VERSION_MIN_MASK     0xF  /* (uses bit positions 6 to 9) */
 #define SSLF_TLS_VERSION_MAX_SHIFT    10
 #define SSLF_TLS_VERSION_MAX_MASK     0xF  /* (uses bit positions 10 to 13) */
-#define SSLF_TLS_DEBUG_ENABLED        (1<<14)
+#define SSLF_TLS_DEBUG_ENABLED        (1 << 14)
     unsigned int ssl_flags;
 
 #ifdef ENABLE_MANAGEMENT
@@ -625,11 +625,11 @@ struct tls_multi
     /**< The first auth-token we sent to a client. We use this to remember
      * the session ID and initial timestamp when generating new auth-token.
      */
-#define  AUTH_TOKEN_HMAC_OK              (1<<0)
+#define  AUTH_TOKEN_HMAC_OK              (1 << 0)
     /**< Auth-token sent from client has valid hmac */
-#define  AUTH_TOKEN_EXPIRED              (1<<1)
+#define  AUTH_TOKEN_EXPIRED              (1 << 1)
     /**< Auth-token sent from client has expired */
-#define  AUTH_TOKEN_VALID_EMPTYUSER      (1<<2)
+#define  AUTH_TOKEN_VALID_EMPTYUSER      (1 << 2)
     /**<
      * Auth-token is only valid for an empty username
      * and not the username actually supplied from the client
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 87bee0f5..9f0fbf0a 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -83,11 +83,11 @@ static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_legacy =
 {
     /* Hashes from SHA-1 and above */
     MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA1 )
-    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_RIPEMD160 )
-    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 )
-    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 )
-    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 )
-    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
+    | MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_RIPEMD160 )
+    | MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 )
+    | MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 )
+    | MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 )
+    | MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
     0xFFFFFFF, /* Any PK alg    */
     0xFFFFFFF, /* Any curve     */
     1024,      /* RSA-1024 and larger */
@@ -97,9 +97,9 @@ static const mbedtls_x509_crt_profile openvpn_x509_crt_profile_preferred =
 {
     /* SHA-2 and above */
     MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 )
-    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 )
-    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 )
-    |MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
+    | MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 )
+    | MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 )
+    | MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
     0xFFFFFFF, /* Any PK alg    */
     0xFFFFFFF, /* Any curve     */
     2048,      /* RSA-2048 and larger */
@@ -1147,7 +1147,7 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
     {
         const int tls_version_min =
             (session->opt->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT)
-            &SSLF_TLS_VERSION_MIN_MASK;
+            & SSLF_TLS_VERSION_MIN_MASK;
 
         /* default to TLS 1.0 */
         int major = MBEDTLS_SSL_MAJOR_VERSION_3;
@@ -1165,7 +1165,7 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
     {
         const int tls_version_max =
             (session->opt->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT)
-            &SSLF_TLS_VERSION_MAX_MASK;
+            & SSLF_TLS_VERSION_MAX_MASK;
 
         if (tls_version_max > TLS_VER_UNSPEC)
         {
@@ -1541,7 +1541,7 @@ get_ssl_library_version(void)
     static char mbedtls_version[30];
     unsigned int pv = mbedtls_version_get_number();
     sprintf( mbedtls_version, "mbed TLS %d.%d.%d",
-             (pv>>24)&0xff, (pv>>16)&0xff, (pv>>8)&0xff );
+             (pv >> 24) & 0xff, (pv >> 16) & 0xff, (pv >> 8) & 0xff );
     return mbedtls_version;
 }
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 0ff39c35..5753630d 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -797,7 +797,7 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
     FILE *fp;
     EVP_PKEY *pkey;
     X509 *cert;
-    STACK_OF(X509) *ca = NULL;
+    STACK_OF(X509) * ca = NULL;
     PKCS12 *p12;
     int i;
     char password[256];
@@ -1103,7 +1103,7 @@ backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
     /* Always start with a cleared CRL list, for that we
      * we need to manually find the CRL object from the stack
      * and remove it */
-    STACK_OF(X509_OBJECT) *objs = X509_STORE_get0_objects(store);
+    STACK_OF(X509_OBJECT) * objs = X509_STORE_get0_objects(store);
     for (int i = 0; i < sk_X509_OBJECT_num(objs); i++)
     {
         X509_OBJECT *obj = sk_X509_OBJECT_value(objs, i);
@@ -1552,8 +1552,8 @@ void
 tls_ctx_load_ca(struct tls_root_ctx *ctx, const char *ca_file,
                 bool ca_file_inline, const char *ca_path, bool tls_server)
 {
-    STACK_OF(X509_INFO) *info_stack = NULL;
-    STACK_OF(X509_NAME) *cert_names = NULL;
+    STACK_OF(X509_INFO) * info_stack = NULL;
+    STACK_OF(X509_NAME) * cert_names = NULL;
     X509_LOOKUP *lookup = NULL;
     X509_STORE *store = NULL;
     X509_NAME *xn = NULL;
@@ -2199,9 +2199,9 @@ show_available_tls_ciphers_list(const char *cipher_list,
     }
 
 #if OPENSSL_VERSION_NUMBER < 0x1010000fL
-    STACK_OF(SSL_CIPHER) *sk = SSL_get_ciphers(ssl);
+    STACK_OF(SSL_CIPHER) * sk = SSL_get_ciphers(ssl);
 #else
-    STACK_OF(SSL_CIPHER) *sk = SSL_get1_supported_ciphers(ssl);
+    STACK_OF(SSL_CIPHER) * sk = SSL_get1_supported_ciphers(ssl);
 #endif
     for (int i = 0; i < sk_SSL_CIPHER_num(sk); i++)
     {
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index bbce6259..e4ac2826 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -485,7 +485,7 @@ calculate_session_id_hmac(struct session_id client_sid,
     /* Get the valid time quantisation for our hmac,
      * we divide time by handwindow/2 and allow the previous
      * and future session time if specified by offset */
-    uint32_t session_id_time = now/((handwindow + 1)/2) + offset;
+    uint32_t session_id_time = now / ((handwindow + 1) / 2) + offset;
 
     hmac_ctx_reset(hmac);
     /* We do not care about endian here since it does not need to be
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index da55b4e6..c20484d6 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -510,7 +510,7 @@ verify_cert_export_cert(openvpn_x509_cert_t *peercert, const char *tmp_dir, stru
     peercert_file = fopen(peercert_filename, "w+");
     if (!peercert_file)
     {
-        msg(M_NONFATAL|M_ERRNO, "Failed to open temporary file: %s",
+        msg(M_NONFATAL | M_ERRNO, "Failed to open temporary file: %s",
             peercert_filename);
         return NULL;
     }
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 15ef0b40..ba57566a 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -52,7 +52,7 @@
 
 /** Structure containing the hash for a single certificate */
 struct cert_hash {
-    unsigned char sha256_hash[256/8];
+    unsigned char sha256_hash[256 / 8];
 };
 
 /** Structure containing the hashes for a full certificate chain */
@@ -192,7 +192,7 @@ struct x509_track
 {
     const struct x509_track *next;
     const char *name;
-#define XT_FULL_CHAIN (1<<0)
+#define XT_FULL_CHAIN (1 << 0)
     unsigned int flags;
     int nid;
 };
@@ -203,9 +203,9 @@ struct x509_track
 /** Do not perform Netscape certificate type verification */
 #define NS_CERT_CHECK_NONE (0)
 /** Do not perform Netscape certificate type verification */
-#define NS_CERT_CHECK_SERVER (1<<0)
+#define NS_CERT_CHECK_SERVER (1 << 0)
 /** Do not perform Netscape certificate type verification */
-#define NS_CERT_CHECK_CLIENT (1<<1)
+#define NS_CERT_CHECK_CLIENT (1 << 1)
 
 /** Require keyUsage to be present in cert (0xFFFF is an invalid KU value) */
 #define OPENVPN_KU_REQUIRED (0xFFFF)
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 501cb621..e6754310 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -357,7 +357,7 @@ x509_get_subject(X509 *cert, struct gc_arena *gc)
 
     X509_NAME_print_ex(subject_bio, X509_get_subject_name(cert),
                        0, XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN
-                       |ASN1_STRFLGS_UTF8_CONVERT | ASN1_STRFLGS_ESC_CTRL);
+                       | ASN1_STRFLGS_UTF8_CONVERT | ASN1_STRFLGS_ESC_CTRL);
 
     if (BIO_eof(subject_bio))
     {
@@ -789,7 +789,7 @@ tls_verify_crl_missing(const struct tls_options *opt)
         crypto_msg(M_FATAL, "Cannot get certificate store");
     }
 
-    STACK_OF(X509_OBJECT) *objs = X509_STORE_get0_objects(store);
+    STACK_OF(X509_OBJECT) * objs = X509_STORE_get0_objects(store);
     for (int i = 0; i < sk_X509_OBJECT_num(objs); i++)
     {
         X509_OBJECT *obj = sk_X509_OBJECT_value(objs, i);
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index d1a00b53..d2114b66 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -51,7 +51,7 @@ print_status_mode(unsigned int flags)
         case STATUS_OUTPUT_READ:
             return "READ";
 
-        case STATUS_OUTPUT_READ|STATUS_OUTPUT_WRITE:
+        case STATUS_OUTPUT_READ | STATUS_OUTPUT_WRITE:
             return "READ/WRITE";
 
         default:
@@ -92,7 +92,7 @@ status_open(const char *filename,
                                            S_IRUSR | S_IWUSR);
                     break;
 
-                case STATUS_OUTPUT_READ|STATUS_OUTPUT_WRITE:
+                case STATUS_OUTPUT_READ | STATUS_OUTPUT_WRITE:
                     so->fd = platform_open(filename,
                                            O_CREAT | O_RDWR,
                                            S_IRUSR | S_IWUSR);
diff --git a/src/openvpn/status.h b/src/openvpn/status.h
index fc3a97d7..8722e313 100644
--- a/src/openvpn/status.h
+++ b/src/openvpn/status.h
@@ -47,8 +47,8 @@ virtual_output_print(const struct virtual_output *vo, const unsigned int flags,
 
 struct status_output
 {
-#define STATUS_OUTPUT_READ  (1<<0)
-#define STATUS_OUTPUT_WRITE (1<<1)
+#define STATUS_OUTPUT_READ  (1 << 0)
+#define STATUS_OUTPUT_WRITE (1 << 1)
     unsigned int flags;
 
     char *filename;
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 5a673a7b..fa9a0bc3 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -40,7 +40,7 @@
 #include <windows.h>
 #include <winsock2.h>
 #include <tlhelp32.h>
-#define sleep(x) Sleep((x)*1000)
+#define sleep(x) Sleep((x) * 1000)
 #define random rand
 #define srandom srand
 #endif
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 2fc79111..c0026c7b 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -85,7 +85,7 @@ tls_crypt_wrap(const struct buffer *src, struct buffer *dst,
     ASSERT(ctx->cipher);
     ASSERT(ctx->hmac);
     ASSERT(packet_id_initialized(&opt->packet_id));
-    ASSERT(hmac_ctx_size(ctx->hmac) == 256/8);
+    ASSERT(hmac_ctx_size(ctx->hmac) == 256 / 8);
 
     gc_init(&gc);
 
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index 928ff547..20c6c5fd 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -86,9 +86,9 @@
 #include "session_id.h"
 #include "ssl_common.h"
 
-#define TLS_CRYPT_TAG_SIZE (256/8)
+#define TLS_CRYPT_TAG_SIZE (256 / 8)
 #define TLS_CRYPT_PID_SIZE (sizeof(packet_id_type) + sizeof(net_time_t))
-#define TLS_CRYPT_BLOCK_SIZE (128/8)
+#define TLS_CRYPT_BLOCK_SIZE (128 / 8)
 
 #define TLS_CRYPT_OFF_PID (1 + SID_SIZE)
 #define TLS_CRYPT_OFF_TAG (TLS_CRYPT_OFF_PID + TLS_CRYPT_PID_SIZE)
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8ad031e6..6433a0fb 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -64,9 +64,9 @@ const static GUID GUID_DEVINTERFACE_NET = { 0xcac88484, 0x7515, 0x4c03, { 0x82,
 
 /* #define SIMULATE_DHCP_FAILED */       /* simulate bad DHCP negotiation */
 
-#define NI_TEST_FIRST  (1<<0)
-#define NI_IP_NETMASK  (1<<1)
-#define NI_OPTIONS     (1<<2)
+#define NI_TEST_FIRST  (1 << 0)
+#define NI_IP_NETMASK  (1 << 1)
+#define NI_OPTIONS     (1 << 2)
 
 static void netsh_ifconfig(const struct tuntap_options *to,
                            DWORD adapter_index,
@@ -569,7 +569,7 @@ warn_on_use_of_common_subnets(openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc = gc_new();
     struct route_gateway_info rgi;
-    const int needed = (RGI_ADDR_DEFINED|RGI_NETMASK_DEFINED);
+    const int needed = (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED);
 
     get_default_gateway(&rgi, ctx);
     if ((rgi.flags & needed) == needed)
@@ -1557,7 +1557,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
     else if (tt->options.ip_win32_type == IPW32_SET_NETSH)
     {
         netsh_ifconfig(&tt->options, tt->adapter_index, tt->local,
-                       tt->adapter_netmask, NI_IP_NETMASK|NI_OPTIONS);
+                       tt->adapter_netmask, NI_IP_NETMASK | NI_OPTIONS);
     }
     if (tt->options.msg_channel)
     {
@@ -2792,7 +2792,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
     if (tt->fd >= 0)
     {
-        int i = IFF_POINTOPOINT|IFF_MULTICAST;
+        int i = IFF_POINTOPOINT | IFF_MULTICAST;
         ioctl(tt->fd, TUNSIFMODE, &i);   /* multicast on */
         i = 0;
         ioctl(tt->fd, TUNSLMODE, &i);    /* link layer mode off */
@@ -5065,7 +5065,7 @@ tap_allow_nonadmin_access_handle(const char *device_path, HANDLE hand)
     }
     else
     {
-        msg(M_INFO|M_NOPREFIX, "TAP-Windows device: %s [Non-admin access allowed]", device_path);
+        msg(M_INFO | M_NOPREFIX, "TAP-Windows device: %s [Non-admin access allowed]", device_path);
     }
 }
 
@@ -5760,9 +5760,9 @@ tun_standby(struct tuntap *tt)
                            tt->adapter_index,
                            tt->local,
                            tt->adapter_netmask,
-                           NI_TEST_FIRST|NI_IP_NETMASK|NI_OPTIONS);
+                           NI_TEST_FIRST | NI_IP_NETMASK | NI_OPTIONS);
         }
-        else if (tt->standby_iter >= IPW32_SET_ADAPTIVE_TRY_NETSH*2)
+        else if (tt->standby_iter >= IPW32_SET_ADAPTIVE_TRY_NETSH * 2)
         {
             ret = false;
         }
@@ -6759,7 +6759,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
     }
     else if (tt->type != DEV_TYPE_TAP && tt->type != DEV_TYPE_TUN)
     {
-        msg(M_FATAL|M_NOPREFIX, "Unknown virtual device type: '%s'", dev);
+        msg(M_FATAL | M_NOPREFIX, "Unknown virtual device type: '%s'", dev);
     }
 
     struct gc_arena gc = gc_new(); /* used also for device_guid allocation */
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index d3fb2686..8d65290d 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -337,7 +337,7 @@ net_event_win32_start(struct net_event_win32 *ne, long network_events, socket_de
     ASSERT(!socket_defined(ne->sd));
     ne->sd = sd;
     ne->event_mask = 0;
-    init_net_event_win32(&ne->handle, network_events, sd, NE32_PERSIST_EVENT|NE32_WRITE_EVENT);
+    init_net_event_win32(&ne->handle, network_events, sd, NE32_PERSIST_EVENT | NE32_WRITE_EVENT);
 }
 
 void
@@ -411,7 +411,7 @@ win_trigger_event(struct win32_signal *ws)
         ir.Event.KeyEvent.bKeyDown = true;
         if (!stdin_handle || !WriteConsoleInput(stdin_handle, &ir, 1, &tmp))
         {
-            msg(M_WARN|M_ERRNO, "WARN: win_trigger_event: WriteConsoleInput");
+            msg(M_WARN | M_ERRNO, "WARN: win_trigger_event: WriteConsoleInput");
         }
     }
 }
@@ -522,7 +522,7 @@ win32_signal_open(struct win32_signal *ws,
                                   exit_event_name);
         if (ws->in.read == NULL)
         {
-            msg(M_WARN|M_ERRNO, "NOTE: CreateEvent '%s' failed", exit_event_name);
+            msg(M_WARN | M_ERRNO, "NOTE: CreateEvent '%s' failed", exit_event_name);
         }
         else
         {
@@ -539,7 +539,7 @@ win32_signal_open(struct win32_signal *ws,
     /* set the ctrl handler in both console and service modes */
     if (!SetConsoleCtrlHandler((PHANDLER_ROUTINE) win_ctrl_handler, true))
     {
-        msg(M_WARN|M_ERRNO, "WARN: SetConsoleCtrlHandler failed");
+        msg(M_WARN | M_ERRNO, "WARN: SetConsoleCtrlHandler failed");
     }
 }
 
@@ -694,7 +694,7 @@ win32_pause(struct win32_signal *ws)
 {
     if (ws->mode == WSO_MODE_CONSOLE && HANDLE_DEFINED(ws->in.read))
     {
-        msg(M_INFO|M_NOPREFIX, "Press any key to continue...");
+        msg(M_INFO | M_NOPREFIX, "Press any key to continue...");
         do
         {
             WaitForSingleObject(ws->in.read, INFINITE);
@@ -774,7 +774,7 @@ semaphore_open(struct semaphore *s, const char *name)
 
     if (s->hand == NULL)
     {
-        msg(M_WARN|M_ERRNO, "WARNING: Cannot create Win32 semaphore '%s'", name);
+        msg(M_WARN | M_ERRNO, "WARNING: Cannot create Win32 semaphore '%s'", name);
     }
     else
     {
@@ -986,7 +986,7 @@ wide_cmd_line(const struct argv *a, struct gc_arena *gc)
     {
         const char *arg = a->argv[i];
         strcpy(work, arg);
-        string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE|CC_CRLF, '_');
+        string_mod(work, CC_PRINT, CC_DOUBLE_QUOTE | CC_CRLF, '_');
         if (i)
         {
             buf_printf(&buf, " ");
@@ -1048,13 +1048,13 @@ openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned in
                 }
                 else
                 {
-                    msg(M_WARN|M_ERRNO, "openvpn_execve: GetExitCodeProcess %ls failed", cmd);
+                    msg(M_WARN | M_ERRNO, "openvpn_execve: GetExitCodeProcess %ls failed", cmd);
                 }
                 CloseHandle(proc_info.hProcess);
             }
             else
             {
-                msg(M_WARN|M_ERRNO, "openvpn_execve: CreateProcess %ls failed", cmd);
+                msg(M_WARN | M_ERRNO, "openvpn_execve: CreateProcess %ls failed", cmd);
             }
             free(env);
             gc_free(&gc);
@@ -1095,7 +1095,7 @@ fork_to_self(const char *cmdline)
     status = GetModuleFileName(NULL, self_exe, sizeof(self_exe));
     if (status == 0 || status == sizeof(self_exe))
     {
-        msg(M_WARN|M_ERRNO, "fork_to_self: CreateProcess failed: cannot get module name via GetModuleFileName");
+        msg(M_WARN | M_ERRNO, "fork_to_self: CreateProcess failed: cannot get module name via GetModuleFileName");
         goto done;
     }
 
@@ -1112,7 +1112,7 @@ fork_to_self(const char *cmdline)
     }
     else
     {
-        msg(M_WARN|M_ERRNO, "fork_to_self: CreateProcess failed: %s", cmdline);
+        msg(M_WARN | M_ERRNO, "fork_to_self: CreateProcess failed: %s", cmdline);
     }
 
 done:
@@ -1249,7 +1249,7 @@ win_wfp_block_dns(const NET_IFINDEX index, const HANDLE msg_channel)
     status = GetModuleFileNameW(NULL, openvpnpath, _countof(openvpnpath));
     if (status == 0 || status == _countof(openvpnpath))
     {
-        msg(M_WARN|M_ERRNO, "block_dns: cannot get executable path");
+        msg(M_WARN | M_ERRNO, "block_dns: cannot get executable path");
         goto out;
     }
 
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index b1371999..3edbec4e 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -82,8 +82,8 @@ struct rw_handle {
  * Event-based notification of incoming TCP connections
  */
 
-#define NE32_PERSIST_EVENT (1<<0)
-#define NE32_WRITE_EVENT   (1<<1)
+#define NE32_PERSIST_EVENT (1 << 0)
+#define NE32_WRITE_EVENT   (1 << 1)
 
 static inline bool
 defined_net_event_win32(const struct rw_handle *event)
diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index 6d6a1e2c..3601a84f 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -166,7 +166,7 @@ extern OSSL_LIB_CTX *tls_libctx; /* Global */
 static inline int
 xkey_max_saltlen(int modBits, int hLen)
 {
-    int emLen = (modBits - 1 + 7)/8; /* ceil((modBits - 1)/8) */
+    int emLen = (modBits - 1 + 7) / 8; /* ceil((modBits - 1)/8) */
 
     return emLen - hLen - 2;
 }
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index 5f442213..540f6f72 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -55,8 +55,8 @@ typedef struct
 /* helper to print debug messages */
 #define xkey_dmsg(f, ...) \
     do {                                                        \
-        dmsg(f|M_NOLF, "xkey_provider: In %s: ", __func__);    \
-        dmsg(f|M_NOPREFIX, __VA_ARGS__);                      \
+        dmsg(f | M_NOLF, "xkey_provider: In %s: ", __func__);    \
+        dmsg(f | M_NOPREFIX, __VA_ARGS__);                      \
     } while(0)
 
 typedef enum
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 9235a8ed..fda789b3 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -61,7 +61,7 @@
  * Local constants
  */
 
-#define MSICA_ADAPTER_TICK_SIZE (16*1024) /** Amount of tick space to reserve for one TAP/TUN adapter creation/deletition. */
+#define MSICA_ADAPTER_TICK_SIZE (16 * 1024) /** Amount of tick space to reserve for one TAP/TUN adapter creation/deletition. */
 
 #define FILE_NEED_REBOOT        L".ovpn_need_reboot"
 #define CMP_OVPN_DCO_INF        L"CMP_ovpn_dco.inf"
@@ -171,7 +171,7 @@ find_adapters(
 
     /* Get IPv4/v6 info for all network adapters. Actually, we're interested in link status only: up/down? */
     PIP_ADAPTER_ADDRESSES pAdapterAdresses = NULL;
-    ULONG ulAdapterAdressesSize = 16*1024;
+    ULONG ulAdapterAdressesSize = 16 * 1024;
     for (size_t iteration = 0; iteration < 2; iteration++)
     {
         pAdapterAdresses = (PIP_ADAPTER_ADDRESSES)malloc(ulAdapterAdressesSize);
@@ -768,7 +768,7 @@ EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
             {
                 goto cleanup_szDisplayName;
             }
-            memcpy_s(szzHardwareIDs, sizeof(szzHardwareIDs) - 2*sizeof(TCHAR) /*requires double zero termination*/, szHwId, _tcslen(szHwId)*sizeof(TCHAR));
+            memcpy_s(szzHardwareIDs, sizeof(szzHardwareIDs) - 2 * sizeof(TCHAR) /*requires double zero termination*/, szHwId, _tcslen(szHwId) * sizeof(TCHAR));
             free(szHwId);
         }
 
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index f9406120..539d336f 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -65,7 +65,7 @@ GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD size, LPCTSTR default_v
 
     if (status == ERROR_FILE_NOT_FOUND && default_value)
     {
-        size_t len = size/sizeof(data[0]);
+        size_t len = size / sizeof(data[0]);
         if (openvpn_swprintf(data, len, default_value))
         {
             status = ERROR_SUCCESS;
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 5f460173..8c8d77d4 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -326,14 +326,14 @@ ReturnError(HANDLE pipe, DWORD error, LPCWSTR func, DWORD count, LPHANDLE events
     if (error != ERROR_OPENVPN_STARTUP)
     {
         FormatMessageW(FORMAT_MESSAGE_FROM_SYSTEM
-                       |FORMAT_MESSAGE_ALLOCATE_BUFFER
-                       |FORMAT_MESSAGE_IGNORE_INSERTS,
+                       | FORMAT_MESSAGE_ALLOCATE_BUFFER
+                       | FORMAT_MESSAGE_IGNORE_INSERTS,
                        0, error, 0, (LPWSTR) &args[2], 0, NULL);
     }
 
     result_len = FormatMessageW(FORMAT_MESSAGE_FROM_STRING
-                                |FORMAT_MESSAGE_ALLOCATE_BUFFER
-                                |FORMAT_MESSAGE_ARGUMENT_ARRAY,
+                                | FORMAT_MESSAGE_ALLOCATE_BUFFER
+                                | FORMAT_MESSAGE_ARGUMENT_ARRAY,
                                 L"0x%1!08x!\n%2!s!\n%3!s!", 0, 0,
                                 (LPWSTR) &result, 0, (va_list *) args);
 
@@ -875,7 +875,7 @@ ExecCommand(const WCHAR *argv0, const WCHAR *cmdline, DWORD timeout)
     DWORD exit_code;
     STARTUPINFOW si;
     PROCESS_INFORMATION pi;
-    DWORD proc_flags = CREATE_NO_WINDOW|CREATE_UNICODE_ENVIRONMENT;
+    DWORD proc_flags = CREATE_NO_WINDOW | CREATE_UNICODE_ENVIRONMENT;
     WCHAR *cmdline_dup = NULL;
 
     ZeroMemory(&si, sizeof(si));
@@ -1040,7 +1040,7 @@ netsh_dns_cmd(const wchar_t *action, const wchar_t *proto, const wchar_t *if_nam
 
     /* max cmdline length in wchars -- include room for worst case and some */
     size_t ncmdline = wcslen(fmt) + wcslen(if_name) + wcslen(addr) + 32 + 1;
-    cmdline = malloc(ncmdline*sizeof(wchar_t));
+    cmdline = malloc(ncmdline * sizeof(wchar_t));
     if (!cmdline)
     {
         err = ERROR_OUTOFMEMORY;
@@ -1092,7 +1092,7 @@ wmic_nicconfig_cmd(const wchar_t *action, const NET_IFINDEX if_index,
 
     size_t ncmdline = wcslen(fmt) + 20 + wcslen(action) /* max 20 for ifindex */
                       + (data ? wcslen(data) + 1 : 1);
-    cmdline = malloc(ncmdline*sizeof(wchar_t));
+    cmdline = malloc(ncmdline * sizeof(wchar_t));
     if (!cmdline)
     {
         return ERROR_OUTOFMEMORY;
@@ -1294,7 +1294,7 @@ HandleEnableDHCPMessage(const enable_dhcp_message_t *dhcp)
      * 10 chars for 32 bit int in decimal and +1 for NUL
      */
     size_t ncmdline = wcslen(fmt) + 10 + 1;
-    wchar_t *cmdline = malloc(ncmdline*sizeof(wchar_t));
+    wchar_t *cmdline = malloc(ncmdline * sizeof(wchar_t));
     if (!cmdline)
     {
         err = ERROR_OUTOFMEMORY;
@@ -1726,7 +1726,7 @@ RunOpenvpn(LPVOID p)
     ea[0].Trustee.TrusteeType = TRUSTEE_IS_UNKNOWN;
     ea[0].Trustee.ptstrName = (LPTSTR) svc_user->User.Sid;
     ea[1].grfAccessPermissions = READ_CONTROL | SYNCHRONIZE | PROCESS_VM_READ
-                                 |SYNCHRONIZE | PROCESS_TERMINATE | PROCESS_QUERY_INFORMATION;
+                                 | SYNCHRONIZE | PROCESS_TERMINATE | PROCESS_QUERY_INFORMATION;
     ea[1].grfAccessMode = SET_ACCESS;
     ea[1].grfInheritance = NO_INHERITANCE;
     ea[1].Trustee.TrusteeForm = TRUSTEE_IS_SID;
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index 93c3440a..ef3ca86d 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -46,10 +46,10 @@
 /*
  * Message handling
  */
-#define MSG_FLAGS_ERROR     (1<<0)
-#define MSG_FLAGS_SYS_CODE  (1<<1)
+#define MSG_FLAGS_ERROR     (1 << 0)
+#define MSG_FLAGS_SYS_CODE  (1 << 1)
 #define M_INFO    (0)                                  /* informational */
-#define M_SYSERR  (MSG_FLAGS_ERROR|MSG_FLAGS_SYS_CODE) /* error + system code */
+#define M_SYSERR  (MSG_FLAGS_ERROR | MSG_FLAGS_SYS_CODE) /* error + system code */
 #define M_ERR     (MSG_FLAGS_ERROR)                    /* error */
 
 typedef enum {
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 2ba7272d..4cf6f977 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -221,7 +221,7 @@ daemonize(const char *envp[])
 #endif
         if (daemon(0, 0) < 0)
         {
-            plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "daemonization failed");
+            plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "daemonization failed");
         }
 #if defined(__APPLE__) && defined(__clang__)
 #pragma clang diagnostic pop
@@ -448,7 +448,7 @@ openvpn_plugin_open_v3(const int v3structver,
      */
     if (socketpair(PF_UNIX, SOCK_DGRAM, 0, fd) == -1)
     {
-        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "socketpair call failed");
+        plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "socketpair call failed");
         goto error;
     }
 
@@ -474,7 +474,7 @@ openvpn_plugin_open_v3(const int v3structver,
         /* don't let future subprocesses inherit child socket */
         if (fcntl(fd[0], F_SETFD, FD_CLOEXEC) < 0)
         {
-            plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "Set FD_CLOEXEC flag on socket file descriptor failed");
+            plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "Set FD_CLOEXEC flag on socket file descriptor failed");
         }
 
         /* wait for background child process to initialize */
@@ -556,7 +556,7 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const cha
                 || send_string(context->foreground_fd, common_name) == -1
                 || send_string(context->foreground_fd, auth_control_file) == -1)
             {
-                plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "Error sending auth info to background process");
+                plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "Error sending auth info to background process");
             }
             else
             {
@@ -575,7 +575,7 @@ openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const cha
                 }
                 if (status == -1)
                 {
-                    plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "Error receiving auth confirmation from background process");
+                    plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "Error receiving auth confirmation from background process");
                 }
             }
         }
@@ -598,7 +598,7 @@ openvpn_plugin_close_v1(openvpn_plugin_handle_t handle)
         /* tell background process to exit */
         if (send_control(context->foreground_fd, COMMAND_EXIT) == -1)
         {
-            plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "Error signaling background process to exit");
+            plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "Error signaling background process to exit");
         }
 
         /* wait for background process to exit */
@@ -831,7 +831,7 @@ do_deferred_pam_auth(int fd, const char *ac_file_name,
 {
     if (send_control(fd, RESPONSE_DEFER) == -1)
     {
-        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: write error on response socket [4]");
+        plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "BACKGROUND: write error on response socket [4]");
         return;
     }
 
@@ -840,7 +840,7 @@ do_deferred_pam_auth(int fd, const char *ac_file_name,
 
     if (p1 < 0)
     {
-        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: fork(1) failed");
+        plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "BACKGROUND: fork(1) failed");
         return;
     }
     if (p1 != 0)                           /* parent */
@@ -855,7 +855,7 @@ do_deferred_pam_auth(int fd, const char *ac_file_name,
     pid_t p2 = fork();
     if (p2 < 0)
     {
-        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: fork(2) failed");
+        plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "BACKGROUND: fork(2) failed");
         exit(1);
     }
 
@@ -872,7 +872,7 @@ do_deferred_pam_auth(int fd, const char *ac_file_name,
     int ac_fd = open( ac_file_name, O_WRONLY );
     if (ac_fd < 0)
     {
-        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "cannot open '%s' for writing",
+        plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "cannot open '%s' for writing",
                    ac_file_name );
         exit(1);
     }
@@ -880,7 +880,7 @@ do_deferred_pam_auth(int fd, const char *ac_file_name,
 
     if (write( ac_fd, pam_success ? "1" : "0", 1 ) != 1)
     {
-        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "cannot write to '%s'",
+        plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "cannot write to '%s'",
                    ac_file_name );
     }
     close(ac_fd);
@@ -927,7 +927,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
      */
     if (send_control(fd, RESPONSE_INIT_SUCCEEDED) == -1)
     {
-        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: write error on response socket [1]");
+        plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "BACKGROUND: write error on response socket [1]");
         goto done;
     }
 
@@ -958,7 +958,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
                     || recv_string(fd, up.common_name, sizeof(up.common_name)) == -1
                     || recv_string(fd, ac_file_name, sizeof(ac_file_name)) == -1)
                 {
-                    plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: read error on command channel: code=%d, exiting",
+                    plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "BACKGROUND: read error on command channel: code=%d, exiting",
                                command);
                     goto done;
                 }
@@ -992,7 +992,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
                 {
                     if (send_control(fd, RESPONSE_VERIFY_SUCCEEDED) == -1)
                     {
-                        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: write error on response socket [2]");
+                        plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "BACKGROUND: write error on response socket [2]");
                         goto done;
                     }
                 }
@@ -1000,7 +1000,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
                 {
                     if (send_control(fd, RESPONSE_VERIFY_FAILED) == -1)
                     {
-                        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: write error on response socket [3]");
+                        plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "BACKGROUND: write error on response socket [3]");
                         goto done;
                     }
                 }
@@ -1011,7 +1011,7 @@ pam_server(int fd, const char *service, int verb, const struct name_value_list *
                 goto done;
 
             case -1:
-                plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: read error on command channel");
+                plugin_log(PLOG_ERR | PLOG_ERRNO, MODULE, "BACKGROUND: read error on command channel");
                 goto done;
 
             default:
diff --git a/src/plugins/auth-pam/pamdl.c b/src/plugins/auth-pam/pamdl.c
index 02ea71a4..491fa8b0 100644
--- a/src/plugins/auth-pam/pamdl.c
+++ b/src/plugins/auth-pam/pamdl.c
@@ -34,7 +34,7 @@ dlopen_pam(const char *so)
 {
     if (libpam_h == NULL)
     {
-        libpam_h = dlopen(so, RTLD_GLOBAL|RTLD_NOW);
+        libpam_h = dlopen(so, RTLD_GLOBAL | RTLD_NOW);
     }
     return libpam_h != NULL;
 }
diff --git a/src/tapctl/basic.h b/src/tapctl/basic.h
index 9a563569..ec2f2b88 100644
--- a/src/tapctl/basic.h
+++ b/src/tapctl/basic.h
@@ -33,7 +33,7 @@
 #define PRIGUID_PARAM(g) \
     (g).Data1, (g).Data2, (g).Data3, (g).Data4[0], (g).Data4[1], (g).Data4[2], (g).Data4[3], (g).Data4[4], (g).Data4[5], (g).Data4[6], (g).Data4[7]
 #define PRIGUID_PARAM_REF(g) \
-    &(g).Data1, &(g).Data2, &(g).Data3, &(g).Data4[0], &(g).Data4[1], &(g).Data4[2], &(g).Data4[3], &(g).Data4[4], &(g).Data4[5], &(g).Data4[6], &(g).Data4[7]
+    & (g).Data1, &(g).Data2, &(g).Data3, &(g).Data4[0], &(g).Data4[1], &(g).Data4[2], &(g).Data4[3], &(g).Data4[4], &(g).Data4[5], &(g).Data4[6], &(g).Data4[7]
 
 #define __L(q)          L ## q
 #define _L(q)           __L(q)
diff --git a/src/tapctl/error.h b/src/tapctl/error.h
index 7316af5f..6bbe3ce5 100644
--- a/src/tapctl/error.h
+++ b/src/tapctl/error.h
@@ -37,20 +37,20 @@ extern int x_msg_line_num;
 
 #define M_DEBUG_LEVEL     (0x0F)         /* debug level mask */
 
-#define M_FATAL           (1<<4)         /* exit program */
-#define M_NONFATAL        (1<<5)         /* non-fatal error */
-#define M_WARN            (1<<6)         /* call syslog with LOG_WARNING */
-#define M_DEBUG           (1<<7)
-
-#define M_ERRNO           (1<<8)         /* show errno description */
-
-#define M_NOMUTE          (1<<11)        /* don't do mute processing */
-#define M_NOPREFIX        (1<<12)        /* don't show date/time prefix */
-#define M_USAGE_SMALL     (1<<13)        /* fatal options error, call usage_small */
-#define M_MSG_VIRT_OUT    (1<<14)        /* output message through msg_status_output callback */
-#define M_OPTERR          (1<<15)        /* print "Options error:" prefix */
-#define M_NOLF            (1<<16)        /* don't print new line */
-#define M_NOIPREFIX       (1<<17)        /* don't print instance prefix */
+#define M_FATAL           (1 << 4)         /* exit program */
+#define M_NONFATAL        (1 << 5)         /* non-fatal error */
+#define M_WARN            (1 << 6)         /* call syslog with LOG_WARNING */
+#define M_DEBUG           (1 << 7)
+
+#define M_ERRNO           (1 << 8)         /* show errno description */
+
+#define M_NOMUTE          (1 << 11)        /* don't do mute processing */
+#define M_NOPREFIX        (1 << 12)        /* don't show date/time prefix */
+#define M_USAGE_SMALL     (1 << 13)        /* fatal options error, call usage_small */
+#define M_MSG_VIRT_OUT    (1 << 14)        /* output message through msg_status_output callback */
+#define M_OPTERR          (1 << 15)        /* print "Options error:" prefix */
+#define M_NOLF            (1 << 16)        /* don't print new line */
+#define M_NOIPREFIX       (1 << 17)        /* don't print instance prefix */
 
 /* flag combinations which are frequently used */
 #define M_ERR     (M_FATAL | M_ERRNO)
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 0724cc4d..15642f0e 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -285,7 +285,7 @@ create_delete_adapter:
             {
                 memset(szzHwId, 0, sizeof(szzHwId));
                 ++i;
-                memcpy_s(szzHwId, sizeof(szzHwId) - 2*sizeof(TCHAR) /*requires double zero termination*/, argv[i], _tcslen(argv[i])*sizeof(TCHAR));
+                memcpy_s(szzHwId, sizeof(szzHwId) - 2 * sizeof(TCHAR) /*requires double zero termination*/, argv[i], _tcslen(argv[i]) * sizeof(TCHAR));
             }
             else
             {
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index 5299c364..58c3b909 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -185,22 +185,22 @@ auth_token_test_timeout(void **state)
     /* Token before validity, should be rejected */
     now = 100000 - 100;
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
-                     AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_EXPIRED);
+                     AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_EXPIRED);
 
     /* Token still in validity, should be accepted */
-    now = 100000 + 2*ctx->session->opt->renegotiate_seconds - 20;
+    now = 100000 + 2 * ctx->session->opt->renegotiate_seconds - 20;
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
                      AUTH_TOKEN_HMAC_OK);
 
     /* Token past validity, should be rejected */
-    now = 100000 + 2*ctx->session->opt->renegotiate_seconds + 20;
+    now = 100000 + 2 * ctx->session->opt->renegotiate_seconds + 20;
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
-                     AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_EXPIRED);
+                     AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_EXPIRED);
 
     /* But not when we reached our timeout */
     now = 100000 + ctx->session->opt->auth_token_lifetime + 1;
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
-                     AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_EXPIRED);
+                     AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_EXPIRED);
 
     free(ctx->multi.auth_token_initial);
     ctx->multi.auth_token_initial = NULL;
@@ -218,7 +218,7 @@ auth_token_test_timeout(void **state)
 
 
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
-                     AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_EXPIRED);
+                     AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_EXPIRED);
     ctx->multi.opt.auth_token_lifetime = 0;
 
     /* Non expiring token should be fine */
@@ -230,7 +230,7 @@ static void
 zerohmac(char *token)
 {
     char *hmacstart = token + AUTH_TOKEN_SESSION_ID_LEN
-                      + strlen(SESSION_ID_PREFIX) + 2*sizeof(uint64_t);
+                      + strlen(SESSION_ID_PREFIX) + 2 * sizeof(uint64_t);
     memset(hmacstart, 0x8d, strlen(hmacstart));
 }
 
@@ -312,17 +312,17 @@ auth_token_test_empty_user(void **state)
 
     now = 100000;
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
-                     AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_EXPIRED);
+                     AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_EXPIRED);
     strcpy(ctx->up.username, "test user name");
 
     now = 0;
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
-                     AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_VALID_EMPTYUSER);
+                     AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_VALID_EMPTYUSER);
 
     strcpy(ctx->up.username, "test user name");
     now = 100000;
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
-                     AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_EXPIRED|AUTH_TOKEN_VALID_EMPTYUSER);
+                     AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_EXPIRED | AUTH_TOKEN_VALID_EMPTYUSER);
 
     zerohmac(ctx->up.password);
     assert_int_equal(verify_auth_token(&ctx->up, &ctx->multi, ctx->session),
@@ -350,15 +350,15 @@ auth_token_test_env(void **state)
     add_session_token_env(ctx->session, &ctx->multi, &ctx->up);
     assert_string_equal(lastsesion_statevalue, "Authenticated");
 
-    ks->auth_token_state_flags = AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_EXPIRED;
+    ks->auth_token_state_flags = AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_EXPIRED;
     add_session_token_env(ctx->session, &ctx->multi, &ctx->up);
     assert_string_equal(lastsesion_statevalue, "Expired");
 
-    ks->auth_token_state_flags = AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_VALID_EMPTYUSER;
+    ks->auth_token_state_flags = AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_VALID_EMPTYUSER;
     add_session_token_env(ctx->session, &ctx->multi, &ctx->up);
     assert_string_equal(lastsesion_statevalue, "AuthenticatedEmptyUser");
 
-    ks->auth_token_state_flags = AUTH_TOKEN_HMAC_OK|AUTH_TOKEN_EXPIRED|AUTH_TOKEN_VALID_EMPTYUSER;
+    ks->auth_token_state_flags = AUTH_TOKEN_HMAC_OK | AUTH_TOKEN_EXPIRED | AUTH_TOKEN_VALID_EMPTYUSER;
     add_session_token_env(ctx->session, &ctx->multi, &ctx->up);
     assert_string_equal(lastsesion_statevalue, "ExpiredEmptyUser");
 }
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index ac701669..6356533d 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -144,7 +144,7 @@ test_buffer_list_aggregate_separator_all(void **state)
     struct test_buffer_list_aggregate_ctx *ctx = *state;
 
     /* Aggregate all */
-    buffer_list_aggregate_separator(ctx->one_two_three, 1<<16, testsep);
+    buffer_list_aggregate_separator(ctx->one_two_three, 1 << 16, testsep);
     assert_int_equal(ctx->one_two_three->size, 1);
     struct buffer *buf = buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_str(buf,
@@ -157,7 +157,7 @@ test_buffer_list_aggregate_separator_nosep(void **state)
     struct test_buffer_list_aggregate_ctx *ctx = *state;
 
     /* Aggregate all */
-    buffer_list_aggregate_separator(ctx->one_two_three, 1<<16, testnosep);
+    buffer_list_aggregate_separator(ctx->one_two_three, 1 << 16, testnosep);
     assert_int_equal(ctx->one_two_three->size, 1);
     struct buffer *buf = buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_str(buf, teststr1 teststr2 teststr3);
@@ -170,7 +170,7 @@ test_buffer_list_aggregate_separator_zerolen(void **state)
     struct buffer_list *bl_zerolen = ctx->zero_length_strings;
 
     /* Aggregate all */
-    buffer_list_aggregate_separator(bl_zerolen, 1<<16, testnosep);
+    buffer_list_aggregate_separator(bl_zerolen, 1 << 16, testnosep);
     assert_int_equal(bl_zerolen->size, 1);
     struct buffer *buf = buffer_list_peek(bl_zerolen);
     assert_buf_equals_str(buf, "");
@@ -183,7 +183,7 @@ test_buffer_list_aggregate_separator_emptybuffers(void **state)
     struct buffer_list *bl_emptybuffers = ctx->empty_buffers;
 
     /* Aggregate all */
-    buffer_list_aggregate_separator(bl_emptybuffers, 1<<16, testnosep);
+    buffer_list_aggregate_separator(bl_emptybuffers, 1 << 16, testnosep);
     assert_int_equal(bl_emptybuffers->size, 1);
     struct buffer *buf = buffer_list_peek(bl_emptybuffers);
     assert_int_equal(BLEN(buf), 0);
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 5dce6b62..151803c8 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -176,7 +176,7 @@ init_tas_auth(int key_direction)
 
     tas.tls_wrap.mode = TLS_WRAP_AUTH;
     /* we ignore packet ids on for the first packet check */
-    tas.tls_wrap.opt.flags |= (CO_IGNORE_PACKET_ID|CO_PACKET_ID_LONG_FORM);
+    tas.tls_wrap.opt.flags |= (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_FORM);
 
     struct key_type tls_crypt_kt;
     init_key_type(&tls_crypt_kt, "none", "SHA1", true, false);
@@ -193,7 +193,7 @@ init_tas_crypt(bool server)
 {
     struct tls_auth_standalone tas = { 0 };
     tas.tls_wrap.mode = TLS_WRAP_CRYPT;
-    tas.tls_wrap.opt.flags |= (CO_IGNORE_PACKET_ID|CO_PACKET_ID_LONG_FORM);
+    tas.tls_wrap.opt.flags |= (CO_IGNORE_PACKET_ID | CO_PACKET_ID_LONG_FORM);
 
     tls_crypt_init_key(&tas.tls_wrap.opt.key_ctx_bi, static_key, true, server);
 
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
index 9451a6e7..4a5d370e 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -46,7 +46,7 @@ struct management *management; /* global */
 static int mgmt_callback_called;
 
 #ifndef _countof
-#define _countof(x) sizeof((x))/sizeof(*(x))
+#define _countof(x) sizeof((x)) / sizeof(*(x))
 #endif
 
 static OSSL_PROVIDER *prov[2];
@@ -291,7 +291,7 @@ xkey_provider_test_mgmt_sign_cb(void **state)
         EVP_PKEY *privkey = xkey_load_management_key(NULL, pubkey);
         assert_true(privkey != NULL);
 
-        management->settings.flags = MF_EXTERNAL_KEY|MF_EXTERNAL_KEY_PSSPAD;
+        management->settings.flags = MF_EXTERNAL_KEY | MF_EXTERNAL_KEY_PSSPAD;
 
         /* first without digest support in management client */
 again:
-- 
2.34.1


