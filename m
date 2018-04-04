From: Janito Vaqueiro Ferreira Filho <janito@...2382...>
Date: Wed,  4 Apr 2018 14:28:41 -0300
Message-Id: <20180404172841.13134-1-janito@...2382...>
In-Reply-To: <cd251af2-9481-ce03-8849-8eeae44f7216@...2080...>
References: <cd251af2-9481-ce03-8849-8eeae44f7216@...2080...>
Subject: [Openvpn-devel] [PATCH] Send authentication failure reason between
 plugins
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

This patch implements support for sending an authentication failure
reason from a server plugin to a client plugin. Currently this can only
be done using the management interface. To allow this to be done through
the use of plugins, two changes were made.

The first change is to allow a plugin to set the failure reason through
an approach similar to how deferred authentication is done. The reason
should be written as a single line to an external file whose path is
specified in the plugin environment variable "auth_failure_reason_file".

The second change introduces a new plugin event: "AUTH_FAILED". Plugins
running in the client that register to receive this event are notified
when an authentication failure is reported from the server. The
authentication failure reason, if one was received, is set to the
"auth_failed_reason" environment variable.
---
 include/openvpn-plugin.h.in |  3 +-
 src/openvpn/plugin.c        |  3 ++
 src/openvpn/push.c          | 24 ++++++++++++++
 src/openvpn/ssl.c           |  5 +--
 src/openvpn/ssl_common.h    |  1 +
 src/openvpn/ssl_verify.c    | 79 ++++++++++++++++++++++++++++++++++++++++++---
 src/openvpn/ssl_verify.h    | 12 +++++--
 7 files changed, 118 insertions(+), 9 deletions(-)

diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index a90a998e..c3b8c476 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -129,7 +129,8 @@ extern "C" {
 #define OPENVPN_PLUGIN_TLS_FINAL             10
 #define OPENVPN_PLUGIN_ENABLE_PF             11
 #define OPENVPN_PLUGIN_ROUTE_PREDOWN         12
-#define OPENVPN_PLUGIN_N                     13
+#define OPENVPN_PLUGIN_AUTH_FAILED           13
+#define OPENVPN_PLUGIN_N                     14
 
 /*
  * Build a mask out of a set of plug-in types.
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 0f091ef5..3310c69d 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -118,6 +118,9 @@ plugin_type_name(const int type)
         case OPENVPN_PLUGIN_ROUTE_PREDOWN:
             return "PLUGIN_ROUTE_PREDOWN";
 
+        case OPENVPN_PLUGIN_AUTH_FAILED:
+            return "PLUGIN_AUTH_FAILED";
+
         default:
             return "PLUGIN_???";
     }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 6a30e479..3fbaa035 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -34,6 +34,7 @@
 #include "ssl.h"
 #include "ssl_verify.h"
 #include "manage.h"
+#include "plugin.h"
 
 #include "memdbg.h"
 
@@ -72,6 +73,29 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
                 ASSERT(0);
         }
         c->sig->signal_text = "auth-failure";
+
+        if (plugin_defined(c->plugins, OPENVPN_PLUGIN_AUTH_FAILED))
+        {
+            struct argv argv = argv_new();
+            const char *reason = NULL;
+            struct buffer buf = *buffer;
+            if (buf_string_compare_advance(&buf, "AUTH_FAILED,") && BLEN(&buf))
+            {
+                reason = BSTR(&buf);
+                setenv_str(c->c2.es, "auth_failed_reason", reason);
+            }
+
+            if (plugin_call(c->plugins, OPENVPN_PLUGIN_AUTH_FAILED, &argv, NULL, c->c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+            {
+                msg(M_WARN, "WARNING: authfailed plugin call failed");
+            }
+
+            if (reason)
+            {
+                setenv_del(c->c2.es, "auth_failed_reason");
+            }
+        }
+
 #ifdef ENABLE_MANAGEMENT
         if (management)
         {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 669f941b..b416aa3c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1015,6 +1015,7 @@ key_state_free(struct key_state *ks, bool clear)
 
 #ifdef PLUGIN_DEF_AUTH
     key_state_rm_auth_control_file(ks);
+    key_state_rm_auth_failure_reason_file(ks);
 #endif
 
     if (clear)
@@ -1347,8 +1348,8 @@ tls_multi_free(struct tls_multi *multi, bool clear)
 
     ASSERT(multi);
 
-#ifdef MANAGEMENT_DEF_AUTH
-    man_def_auth_set_client_reason(multi, NULL);
+#ifdef ENABLE_DEF_AUTH
+    tls_def_auth_set_client_reason(multi, NULL);
 
 #endif
 #if P2MP_SERVER
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 08ef6ffa..f47609b4 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -199,6 +199,7 @@ struct key_state
     unsigned int auth_control_status;
     time_t acf_last_mod;
     char *auth_control_file;
+    char *auth_failure_reason_file;
 #endif
 #endif
 };
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 25395b27..031bee21 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -837,9 +837,9 @@ cleanup:
 #define ACF_FAILED    3
 #endif
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_DEF_AUTH
 void
-man_def_auth_set_client_reason(struct tls_multi *multi, const char *client_reason)
+tls_def_auth_set_client_reason(struct tls_multi *multi, const char *client_reason)
 {
     if (multi->client_reason)
     {
@@ -852,7 +852,9 @@ man_def_auth_set_client_reason(struct tls_multi *multi, const char *client_reaso
         multi->client_reason = string_alloc(client_reason, NULL);
     }
 }
+#endif /* ifdef ENABLE_DEF_AUTH */
 
+#ifdef MANAGEMENT_DEF_AUTH
 static inline unsigned int
 man_def_auth_test(const struct key_state *ks)
 {
@@ -930,6 +932,58 @@ key_state_test_auth_control_file(struct key_state *ks)
     return ACF_DISABLED;
 }
 
+/*
+ * auth_failure_reason_file functions
+ */
+
+void
+key_state_rm_auth_failure_reason_file(struct key_state *ks)
+{
+    if (ks && ks->auth_failure_reason_file)
+    {
+        platform_unlink(ks->auth_failure_reason_file);
+        free(ks->auth_failure_reason_file);
+        ks->auth_failure_reason_file = NULL;
+    }
+}
+
+static bool
+key_state_gen_auth_failure_reason_file(struct key_state *ks, const struct tls_options *opt)
+{
+    struct gc_arena gc = gc_new();
+
+    key_state_rm_auth_failure_reason_file(ks);
+    const char *acf = create_temp_file(opt->tmp_dir, "afrf", &gc);
+    if (acf)
+    {
+        ks->auth_failure_reason_file = string_alloc(acf, NULL);
+        setenv_str(opt->es, "auth_failure_reason_file", ks->auth_failure_reason_file);
+    }
+
+    gc_free(&gc);
+    return acf;
+}
+
+static char *
+key_state_read_auth_failure_reason_file(struct key_state *ks)
+{
+    char *line = NULL;
+    size_t line_len = 0;
+    if (ks && ks->auth_failure_reason_file)
+    {
+        FILE *fp = fopen(ks->auth_failure_reason_file, "r");
+        if (fp)
+        {
+            if (getline(&line, &line_len, fp) < 0)
+            {
+                line = NULL;
+            }
+            fclose(fp);
+        }
+    }
+    return line;
+}
+
 #endif /* ifdef PLUGIN_DEF_AUTH */
 
 /*
@@ -987,6 +1041,7 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
                 if (ks->authenticated)
                 {
 #ifdef ENABLE_DEF_AUTH
+                    char *reason = NULL;
                     unsigned int s1 = ACF_DISABLED;
                     unsigned int s2 = ACF_DISABLED;
 #ifdef PLUGIN_DEF_AUTH
@@ -1012,6 +1067,12 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
                             break;
 
                         case ACF_FAILED:
+#ifdef PLUGIN_DEF_AUTH
+                            reason = key_state_read_auth_failure_reason_file(ks);
+                            tls_def_auth_set_client_reason(multi, reason);
+                            free(reason);
+                            reason = NULL;
+#endif /* PLUGIN_DEF_AUTH */
                             ks->authenticated = false;
                             break;
 
@@ -1056,7 +1117,7 @@ tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id, con
     if (multi)
     {
         int i;
-        man_def_auth_set_client_reason(multi, client_reason);
+        tls_def_auth_set_client_reason(multi, client_reason);
         for (i = 0; i < KEY_SCAN_SIZE; ++i)
         {
             struct key_state *ks = multi->key_scan[i];
@@ -1195,16 +1256,26 @@ verify_user_pass_plugin(struct tls_session *session, const struct user_pass *up,
                  "could not create deferred auth control file", __func__);
             goto cleanup;
         }
+
+        /* generate filename for deferred auth failure reason file */
+        if (!key_state_gen_auth_failure_reason_file(ks, session->opt))
+        {
+            key_state_rm_auth_failure_reason_file(ks);
+            msg (D_TLS_ERRORS, "TLS Auth Error (%s): "
+                 "could not create deferred auth failure reason file", __func__);
+            goto cleanup;
+        }
 #endif
 
         /* call command */
         retval = plugin_call(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session->opt->es);
 
 #ifdef PLUGIN_DEF_AUTH
-        /* purge auth control filename (and file itself) for non-deferred returns */
+        /* purge auth control filenames (and files themselves) for non-deferred returns */
         if (retval != OPENVPN_PLUGIN_FUNC_DEFERRED)
         {
             key_state_rm_auth_control_file(ks);
+            key_state_rm_auth_failure_reason_file(ks);
         }
 #endif
 
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 64f27efb..88b790ff 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -96,6 +96,13 @@ int tls_authentication_status(struct tls_multi *multi, const int latency);
 void key_state_rm_auth_control_file(struct key_state *ks);
 
 /**
+ * Remove the given key state's auth failure reason file, if it exists.
+ *
+ * @param ks    The key state the remove the file for
+ */
+void key_state_rm_auth_failure_reason_file(struct key_state *ks);
+
+/**
  * Frees the given set of certificate hashes.
  *
  * @param chs   The certificate hash set to free.
@@ -223,9 +230,10 @@ struct x509_track
  */
 #ifdef MANAGEMENT_DEF_AUTH
 bool tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id, const bool auth, const char *client_reason);
+#endif
 
-void man_def_auth_set_client_reason(struct tls_multi *multi, const char *client_reason);
-
+#ifdef ENABLE_DEF_AUTH
+void tls_def_auth_set_client_reason(struct tls_multi *multi, const char *client_reason);
 #endif
 
 static inline const char *
-- 
2.13.6


