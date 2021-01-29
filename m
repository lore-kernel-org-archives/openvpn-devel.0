From: David Sommerseth <openvpn@...2080...>
Date: Sat, 30 Jan 2021 00:53:40 +0100
Message-Id: <20210129235340.59785-1-openvpn@...2080...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] sample-plugin/defer: Add simple test case
 for additional web-auth
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
Cc: David Sommerseth <davids@...515...>

From: David Sommerseth <davids@...515...>

Extend the defer/simple sample-plugin supporting test_defer_timeout
and test_defer_openurl environment variables to trigger an additional
web based authentication.  Both variables are required to enable this
feature.

Since this plug-in will require clients to use --auth-user-pass, this
may seem like an odd feature.  But in real life scenarious this can be
useful for opening up a web page with terms of services which needs to
be accepted or other kinds of MFA based authentications which are
triggered via web calls.

In a proper plug-in, the real authentication must then ensure it sends
a proper URL to the client which can be used to map this user with a
reference it can use to identify the proper client in the web
authentication.  The external authentication service will also need to
provide a response back to the OpenVPN authentication plug-in via some
back-channel, which the OpenVPN plug-in can pick up to evaluate if the
authentication result.

Signed-off-by: David Sommerseth <davids@...515...>
---
 sample/sample-plugins/defer/simple.c | 78 +++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 2 deletions(-)

diff --git a/sample/sample-plugins/defer/simple.c b/sample/sample-plugins/defer/simple.c
index 22bc2276..b74de77e 100644
--- a/sample/sample-plugins/defer/simple.c
+++ b/sample/sample-plugins/defer/simple.c
@@ -39,6 +39,29 @@
  * seconds after the initial TLS negotiation, using
  * {common-name}.pf as the source.
  *
+ * Additional web based authentication is also partly
+ * demonstrated if adding these two lines:
+ *
+ * setenv test_deferred_openurl https://auth.example.org/
+ * setenv test_deferred_timeout 30
+ *
+ * This will NOT do any real authentication, but will send
+ * the URL to the client which can open the authentication
+ * page.  If the test_deferred_timeout is higher than
+ * test_deferred_auth, the authentication will pass (regardless
+ * of username/password provided and what ever happens on the
+ * authentication URL).  If the test_deferred_timeout is lower
+ * than test_deferred_auth, the authentication will fail.
+ * For the fail or pass to work properly make sure there are
+ * at least 10-15 seconds difference between test_deferred_auth
+ * and test_deferred_timeout.
+ *
+ * This kind of additional web authentication can be useful
+ * in real life scenarios for various types of 2FA methods
+ * triggered via web; or to open a page with disclaimers and
+ * terms of service needed to be accepted before getting a
+ * connection.
+ *
  * Sample packet filter configuration:
  *
  * [CLIENTS DROP]
@@ -72,6 +95,8 @@ static plugin_log_t plugin_log = NULL;
 struct plugin_context {
     int test_deferred_auth;
     int test_packet_filter;
+    int test_deferred_timeout;
+    char *test_deferred_openurl;
 };
 
 struct plugin_per_client_context {
@@ -169,6 +194,23 @@ openvpn_plugin_open_v3(const int v3structver,
     context->test_deferred_auth = atoi_null0(get_env("test_deferred_auth", envp));
     plugin_log(PLOG_NOTE, MODULE, "TEST_DEFERRED_AUTH %d", context->test_deferred_auth);
 
+    context->test_deferred_timeout = atoi_null0(get_env("test_deferred_timeout", envp));
+    plugin_log(PLOG_NOTE, MODULE, "TEST_DEFERRED_TIMEOUT %d", context->test_deferred_timeout);
+
+    const char *openurl = get_env("test_deferred_openurl", envp);
+    if (openurl)
+    {
+        if (context->test_deferred_timeout < 1)
+        {
+            plugin_log(PLOG_ERR, MODULE, "test_deferred_timeout also requires test_deferred_openurl");
+            goto error;
+        }
+        size_t len = strlen(openurl);
+        context->test_deferred_openurl = calloc(1, len+1);
+        strncpy(context->test_deferred_openurl, openurl, len);
+        plugin_log(PLOG_NOTE, MODULE, "TEST_DEFERRED_OPENURL %s", openurl);
+    }
+
     context->test_packet_filter = atoi_null0(get_env("test_packet_filter", envp));
     plugin_log(PLOG_NOTE, MODULE, "TEST_PACKET_FILTER %d", context->test_packet_filter);
 
@@ -222,11 +264,13 @@ auth_user_pass_verify(struct plugin_context *context,
 
     /* get auth_control_file filename from envp string array*/
     const char *auth_control_file = get_env("auth_control_file", envp);
+    const char *auth_pending_file = get_env("auth_pending_file", envp);
 
-    plugin_log(PLOG_NOTE, MODULE, "DEFER u='%s' p='%s' acf='%s'",
+    plugin_log(PLOG_NOTE, MODULE, "DEFER u='%s' p='%s' acf='%s' apf='%s'",
                np(username),
                np(password),
-               np(auth_control_file));
+               np(auth_control_file),
+               np(auth_pending_file));
 
     /* Authenticate asynchronously in n seconds */
     if (!auth_control_file)
@@ -234,6 +278,32 @@ auth_user_pass_verify(struct plugin_context *context,
         return OPENVPN_PLUGIN_FUNC_ERROR;
     }
 
+    if (auth_pending_file && context->test_deferred_openurl)
+    {
+        /*
+         * This will make OpenVPN clients capable of web authentication open the
+         * the provided URL - but this plug-in does not provide any side-channel
+         * authentication services.  This is purely for demonstration how to
+         * make a client open an URL for authentication, NOT the web authentication
+         * impelementation itself.
+         *
+         * Remember, this plug-in will NOT do any real authentication.  Any
+         * username/password is considered valid.  It only demonstrates various
+         * deferred authentication mechanisms.
+         *
+         */
+        FILE *pfd = fopen(auth_pending_file, "w");
+        if (!pfd)
+        {
+            plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "auth_pending_file open('%s') failed", auth_pending_file);
+            return OPENVPN_PLUGIN_FUNC_ERROR;
+        }
+        fprintf(pfd, "%d\n", context->test_deferred_timeout);
+        fprintf(pfd, "openurl\n");
+        fprintf(pfd, "OPEN_URL:%s\n", context->test_deferred_openurl);
+        fclose(pfd);
+    }
+
     /* we do not want to complicate our lives with having to wait()
      * for child processes (so they are not zombiefied) *and* we MUST NOT
      * fiddle with signal handlers (= shared with openvpn main), so
@@ -513,5 +583,9 @@ openvpn_plugin_close_v1(openvpn_plugin_handle_t handle)
 {
     struct plugin_context *context = (struct plugin_context *) handle;
     plugin_log(PLOG_NOTE, MODULE, "FUNC: openvpn_plugin_close_v1");
+    if (context->test_deferred_openurl)
+    {
+        free(context->test_deferred_openurl);
+    }
     free(context);
 }
-- 
2.27.0


