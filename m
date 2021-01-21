From: Gert Doering <gert@...1296...>
Date: Thu, 21 Jan 2021 18:25:36 +0100
Message-Id: <20210121172536.32500-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] clean up / rewrite
 sample-plugins/defer/simple.c
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

If we ship something that we consider a form of documentation
"this is how to write an OpenVPN plugin" it should meet our standards
for secure and modern code.  This plugin did neither.

  - get rid of system() calls, especially those that enabled a
    remote-root exploit if this code was used "as is"

  - change logging from printf() to OpenVPN's plugin_log()

  - this requires changing to openvpn_plugin_open_v3() to get
    to the function pointers

  - change wacky "background and sleep in the shell call" to the
    double-fork/waitpid model we use in plugins/auth-pam
    (copy-paste code reuse)

  - OpenVPN 2.5 and later react badly to OPENVPN_PLUGIN_FUNC_ERROR
    returns to OPENVPN_PLUGIN_ENABLE_PF calls (SIGSEGV crash), so
    always return SUCCESS.  Only hook ENABLE_PF if that functionality
    is actually requested ("setenv test_packet_filter NN").

  - change deeply-nested functions auth_user_pass_verify() and
    tls_final() to use early-return style

  - actually make defered PF setup *work* with recent OpenVPNs
    (pre-creating temp files broke this, so unlink() the pre-created
    file in the ENABLE_PF hook, and re-create asyncronously later)

  - add lots of comments explaining why we do things this way

Security issue reported by "oxr463" on HackerOne.

Signed-off-by: Gert Doering <gert@...1296...>
---
 sample/sample-plugins/defer/simple.c | 357 ++++++++++++++++++++-------
 1 file changed, 265 insertions(+), 92 deletions(-)

diff --git a/sample/sample-plugins/defer/simple.c b/sample/sample-plugins/defer/simple.c
index 64338b4a..7be1c0a0 100644
--- a/sample/sample-plugins/defer/simple.c
+++ b/sample/sample-plugins/defer/simple.c
@@ -54,13 +54,16 @@
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
+#include <unistd.h>
+#include <stdbool.h>
+#include <fcntl.h>
+#include <sys/types.h>
+#include <sys/wait.h>
 
 #include "openvpn-plugin.h"
 
-/* bool definitions */
-#define bool int
-#define true 1
-#define false 0
+/* Pointers to functions exported from openvpn */
+static plugin_log_t plugin_log = NULL;
 
 /*
  * Our context, where we keep our state.
@@ -76,6 +79,9 @@ struct plugin_per_client_context {
     bool generated_pf_file;
 };
 
+/* module name for plugin_log() */
+static char *MODULE = "defer/simple";
+
 /*
  * Given an environmental variable name, search
  * the envp array for its value, returning it
@@ -130,33 +136,46 @@ atoi_null0(const char *str)
     }
 }
 
-OPENVPN_EXPORT openvpn_plugin_handle_t
-openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const char *envp[])
+/* use v3 functions so we can use openvpn's logging and base64 etc. */
+OPENVPN_EXPORT int
+openvpn_plugin_open_v3(const int v3structver,
+                       struct openvpn_plugin_args_open_in const *args,
+                       struct openvpn_plugin_args_open_return *ret)
 {
+    const char **envp = args->envp;       /* environment variables */
     struct plugin_context *context;
 
-    printf("FUNC: openvpn_plugin_open_v1\n");
+    /* Check API compatibility -- struct version 5 or higher needed */
+    if (v3structver < 5)
+    {
+        fprintf(stderr, "sample-client-connect: this plugin is incompatible with the running version of OpenVPN\n");
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
+    /* Save global pointers to functions exported from openvpn */
+    plugin_log = args->callbacks->plugin_log;
+
+    plugin_log(PLOG_NOTE, MODULE, "FUNC: openvpn_plugin_open_v3");
 
     /*
      * Allocate our context
      */
     context = (struct plugin_context *) calloc(1, sizeof(struct plugin_context));
-    if (context == NULL)
+    if (!context)
     {
-        printf("PLUGIN: allocating memory for context failed\n");
-        return NULL;
+        goto error;
     }
 
     context->test_deferred_auth = atoi_null0(get_env("test_deferred_auth", envp));
-    printf("TEST_DEFERRED_AUTH %d\n", context->test_deferred_auth);
+    plugin_log(PLOG_NOTE, MODULE, "TEST_DEFERRED_AUTH %d", context->test_deferred_auth);
 
     context->test_packet_filter = atoi_null0(get_env("test_packet_filter", envp));
-    printf("TEST_PACKET_FILTER %d\n", context->test_packet_filter);
+    plugin_log(PLOG_NOTE, MODULE, "TEST_PACKET_FILTER %d", context->test_packet_filter);
 
     /*
      * Which callbacks to intercept.
      */
-    *type_mask =
+    ret->type_mask =
         OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_UP)
         |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_DOWN)
         |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_ROUTE_UP)
@@ -166,90 +185,241 @@ openvpn_plugin_open_v1(unsigned int *type_mask, const char *argv[], const char *
         |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT_V2)
         |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_DISCONNECT)
         |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_LEARN_ADDRESS)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_FINAL)
-        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_ENABLE_PF);
+        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_FINAL);
 
-    return (openvpn_plugin_handle_t) context;
+    /* ENABLE_PF should only be called if we're actually willing to do PF */
+    if (context->test_packet_filter)
+    {
+        ret->type_mask |= OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_ENABLE_PF);
+    }
+
+    ret->handle = (openvpn_plugin_handle_t *) context;
+    plugin_log(PLOG_NOTE, MODULE, "initialization succeeded");
+    return OPENVPN_PLUGIN_FUNC_SUCCESS;
+
+error:
+    if (context)
+    {
+        free(context);
+    }
+    plugin_log(PLOG_NOTE, MODULE, "initialization failed");
+    return OPENVPN_PLUGIN_FUNC_ERROR;
 }
 
 static int
-auth_user_pass_verify(struct plugin_context *context, struct plugin_per_client_context *pcc, const char *argv[], const char *envp[])
+auth_user_pass_verify(struct plugin_context *context,
+                      struct plugin_per_client_context *pcc,
+                      const char *argv[], const char *envp[])
 {
-    if (context->test_deferred_auth)
+    if (!context->test_deferred_auth)
     {
-        /* get username/password from envp string array */
-        const char *username = get_env("username", envp);
-        const char *password = get_env("password", envp);
+        return OPENVPN_PLUGIN_FUNC_SUCCESS;
+    }
+
+    /* get username/password from envp string array */
+    const char *username = get_env("username", envp);
+    const char *password = get_env("password", envp);
 
-        /* get auth_control_file filename from envp string array*/
-        const char *auth_control_file = get_env("auth_control_file", envp);
+    /* get auth_control_file filename from envp string array*/
+    const char *auth_control_file = get_env("auth_control_file", envp);
 
-        printf("DEFER u='%s' p='%s' acf='%s'\n",
+    plugin_log(PLOG_NOTE, MODULE, "DEFER u='%s' p='%s' acf='%s'",
                np(username),
                np(password),
                np(auth_control_file));
 
-        /* Authenticate asynchronously in n seconds */
-        if (auth_control_file)
-        {
-            char buf[256];
-            int auth = 2;
-            sscanf(username, "%d", &auth);
-            snprintf(buf, sizeof(buf), "( sleep %d ; echo AUTH %s %d ; echo %d >%s ) &",
-                     context->test_deferred_auth,
-                     auth_control_file,
-                     auth,
-                     pcc->n_calls < auth,
-                     auth_control_file);
-            printf("%s\n", buf);
-            system(buf);
-            pcc->n_calls++;
-            return OPENVPN_PLUGIN_FUNC_DEFERRED;
-        }
-        else
-        {
-            return OPENVPN_PLUGIN_FUNC_ERROR;
-        }
+    /* Authenticate asynchronously in n seconds */
+    if (!auth_control_file)
+    {
+        return OPENVPN_PLUGIN_FUNC_ERROR;
     }
-    else
+
+    /* we do not want to complicate our lives with having to wait()
+     * for child processes (so they are not zombiefied) *and* we MUST NOT
+     * fiddle with signal handlers (= shared with openvpn main), so
+     * we use double-fork() trick.
+     */
+
+    /* fork, sleep, succeed (no "real" auth done = always succeed) */
+    pid_t p1 = fork();
+    if (p1 < 0)                 /* Fork failed */
     {
-        return OPENVPN_PLUGIN_FUNC_SUCCESS;
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+    if (p1 > 0)                 /* parent process */
+    {
+        waitpid(p1, NULL, 0);
+        return OPENVPN_PLUGIN_FUNC_DEFERRED;
+    }
+
+    /* first gen child process, fork() again and exit() right away */
+    pid_t p2 = fork();
+    if (p2 < 0)
+    {
+        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: fork(2) failed");
+        exit(1);
     }
+
+    if (p2 != 0)                            /* new parent: exit right away */
+    {
+        exit(0);
+    }
+
+    /* (grand-)child process
+     *  - never call "return" now (would mess up openvpn)
+     *  - return status is communicated by file
+     *  - then exit()
+     */
+
+    /* do mighty complicated work that will really take time here... */
+    plugin_log(PLOG_NOTE, MODULE, "in async/deferred handler, sleep(%d)", context->test_deferred_auth);
+    sleep(context->test_deferred_auth);
+
+    /* now signal success state to openvpn */
+    int fd = open(auth_control_file, O_WRONLY);
+    if (fd < 0)
+    {
+        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "open('%s') failed", auth_control_file);
+        exit(1);
+    }
+
+    plugin_log(PLOG_NOTE, MODULE, "auth_user_pass_verify: done" );
+
+    if (write(fd, "1", 1) != 1)
+    {
+        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "write to '%s' failed", auth_control_file );
+    }
+    close(fd);
+
+    exit(0);
 }
 
 static int
 tls_final(struct plugin_context *context, struct plugin_per_client_context *pcc, const char *argv[], const char *envp[])
 {
-    if (context->test_packet_filter)
+    if (!context->test_packet_filter)	/* no PF testing, nothing to do */
+    {
+        return OPENVPN_PLUGIN_FUNC_SUCCESS;
+    }
+
+    if (pcc->generated_pf_file)		/* we already have created a file */
+    {
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
+    const char *pff = get_env("pf_file", envp);
+    const char *cn = get_env("username", envp);
+    if (!pff || !cn)			/* required vars missing */
+    {
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
+    pcc->generated_pf_file = true;
+
+    /* the PF API is, basically
+     *  - OpenVPN sends a filename (pf_file) to the plugin
+     *  - OpenVPN main loop will check every second if that file shows up
+     *  - when it does, it will be read & used for the pf config
+     * the pre-created file needs to be removed in ...ENABLE_PF
+     * to make deferred PF setup work
+     *
+     * the regular PF hook does not know the client username or CN, so
+     * this is deferred to the TLS_FINAL hook which knows these things
+     */
+
+    /* do the double fork dance (see above for more verbose comments)
+     */
+    pid_t p1 = fork();
+    if (p1 < 0)                 /* Fork failed */
+    {
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+    if (p1 > 0)                 /* parent process */
+    {
+        waitpid(p1, NULL, 0);
+        return OPENVPN_PLUGIN_FUNC_SUCCESS;	/* no _DEFERRED here! */
+    }
+
+    /* first gen child process, fork() again and exit() right away */
+    pid_t p2 = fork();
+    if (p2 < 0)
+    {
+        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "BACKGROUND: fork(2) failed");
+        exit(1);
+    }
+
+    if (p2 != 0)                            /* new parent: exit right away */
+    {
+        exit(0);
+    }
+
+    /* (grand-)child process
+     *  - never call "return" now (would mess up openvpn)
+     *  - return status is communicated by file
+     *  - then exit()
+     */
+
+    /* at this point, the plugin can take its time, because OpenVPN will
+     * no longer block waiting for the call to finish
+     *
+     * in this example, we build a PF file by copying over a file
+     * named "<username>.pf" to the OpenVPN-provided pf file name
+     *
+     * a real example could do a LDAP lookup, a REST call, ...
+     */
+    plugin_log(PLOG_NOTE, MODULE, "in async/deferred tls_final handler, sleep(%d)", context->test_packet_filter);
+    sleep(context->test_packet_filter);
+
+    char buf[256];
+    snprintf(buf, sizeof(buf), "%s.pf", cn );
+
+    /* there is a small race condition here - OpenVPN could detect our
+     * file while we have only written half of it.  So "perfect" code
+     * needs to create this with a temp file name, and then rename() it
+     * after it has been written.  But I am lazy.
+     */
+
+    int w_fd = open( pff, O_WRONLY|O_CREAT, 0600 );
+    if (w_fd < 0)
     {
-        if (!pcc->generated_pf_file)
+        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "can't write to '%s'", pff);
+        exit(0);
+    }
+
+    int r_fd = open( buf, O_RDONLY );
+    if (r_fd < 0 )
+    {
+        plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "can't read '%s', creating empty pf file", buf);
+        close(w_fd);
+        exit(0);
+    }
+
+    char data[1024];
+
+    int r;
+    do
+    {
+        r = read(r_fd, data, sizeof(data));
+        if (r < 0)
         {
-            const char *pff = get_env("pf_file", envp);
-            const char *cn = get_env("username", envp);
-            if (pff && cn)
-            {
-                char buf[256];
-                snprintf(buf, sizeof(buf), "( sleep %d ; echo PF %s/%s ; cp \"%s.pf\" \"%s\" ) &",
-                         context->test_packet_filter, cn, pff, cn, pff);
-                printf("%s\n", buf);
-                system(buf);
-                pcc->generated_pf_file = true;
-                return OPENVPN_PLUGIN_FUNC_SUCCESS;
-            }
-            else
-            {
-                return OPENVPN_PLUGIN_FUNC_ERROR;
-            }
+            plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "error reading '%s'", buf);
+            close(r_fd);
+            close(w_fd);
+            exit(0);
         }
-        else
+        int w = write(w_fd, data, r);
+        if (w < 0 || w != r)
         {
-            return OPENVPN_PLUGIN_FUNC_ERROR;
+            plugin_log(PLOG_ERR|PLOG_ERRNO, MODULE, "error writing %d bytes to '%s'", r, pff);
+            close(r_fd);
+            close(w_fd);
+            exit(0);
         }
     }
-    else
-    {
-        return OPENVPN_PLUGIN_FUNC_SUCCESS;
-    }
+    while( r>0 );
+
+    plugin_log(PLOG_NOTE, MODULE, "copied PF config from '%s' to '%s', job done", buf, pff);
+    exit(0);
 }
 
 OPENVPN_EXPORT int
@@ -265,58 +435,61 @@ openvpn_plugin_func_v2(openvpn_plugin_handle_t handle,
     switch (type)
     {
         case OPENVPN_PLUGIN_UP:
-            printf("OPENVPN_PLUGIN_UP\n");
+            plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_UP");
             return OPENVPN_PLUGIN_FUNC_SUCCESS;
 
         case OPENVPN_PLUGIN_DOWN:
-            printf("OPENVPN_PLUGIN_DOWN\n");
+            plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_DOWN");
             return OPENVPN_PLUGIN_FUNC_SUCCESS;
 
         case OPENVPN_PLUGIN_ROUTE_UP:
-            printf("OPENVPN_PLUGIN_ROUTE_UP\n");
+            plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_ROUTE_UP");
             return OPENVPN_PLUGIN_FUNC_SUCCESS;
 
         case OPENVPN_PLUGIN_IPCHANGE:
-            printf("OPENVPN_PLUGIN_IPCHANGE\n");
+            plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_IPCHANGE");
             return OPENVPN_PLUGIN_FUNC_SUCCESS;
 
         case OPENVPN_PLUGIN_TLS_VERIFY:
-            printf("OPENVPN_PLUGIN_TLS_VERIFY\n");
+            plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_TLS_VERIFY");
             return OPENVPN_PLUGIN_FUNC_SUCCESS;
 
         case OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY:
-            printf("OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY\n");
+            plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY");
             return auth_user_pass_verify(context, pcc, argv, envp);
 
         case OPENVPN_PLUGIN_CLIENT_CONNECT_V2:
-            printf("OPENVPN_PLUGIN_CLIENT_CONNECT_V2\n");
+            plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_CLIENT_CONNECT_V2");
             return OPENVPN_PLUGIN_FUNC_SUCCESS;
 
         case OPENVPN_PLUGIN_CLIENT_DISCONNECT:
-            printf("OPENVPN_PLUGIN_CLIENT_DISCONNECT\n");
+            plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_CLIENT_DISCONNECT");
             return OPENVPN_PLUGIN_FUNC_SUCCESS;
 
         case OPENVPN_PLUGIN_LEARN_ADDRESS:
-            printf("OPENVPN_PLUGIN_LEARN_ADDRESS\n");
+            plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_LEARN_ADDRESS");
             return OPENVPN_PLUGIN_FUNC_SUCCESS;
 
         case OPENVPN_PLUGIN_TLS_FINAL:
-            printf("OPENVPN_PLUGIN_TLS_FINAL\n");
+            plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_TLS_FINAL");
             return tls_final(context, pcc, argv, envp);
 
         case OPENVPN_PLUGIN_ENABLE_PF:
-            printf("OPENVPN_PLUGIN_ENABLE_PF\n");
-            if (context->test_packet_filter)
-            {
-                return OPENVPN_PLUGIN_FUNC_SUCCESS;
-            }
-            else
+            plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_ENABLE_PF");
+
+            /* OpenVPN pre-creates the file, which gets in the way of
+             * deferred pf setup - so remove it here, and re-create
+             * it in the background handler (in tls_final()) when ready
+             */
+            const char *pff = get_env("pf_file", envp);
+            if (pff)
             {
-                return OPENVPN_PLUGIN_FUNC_ERROR;
+                (void) unlink(pff);
             }
+            return OPENVPN_PLUGIN_FUNC_SUCCESS;           /* must succeed */
 
         default:
-            printf("OPENVPN_PLUGIN_?\n");
+            plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_?");
             return OPENVPN_PLUGIN_FUNC_ERROR;
     }
 }
@@ -324,14 +497,14 @@ openvpn_plugin_func_v2(openvpn_plugin_handle_t handle,
 OPENVPN_EXPORT void *
 openvpn_plugin_client_constructor_v1(openvpn_plugin_handle_t handle)
 {
-    printf("FUNC: openvpn_plugin_client_constructor_v1\n");
+    plugin_log(PLOG_NOTE, MODULE, "FUNC: openvpn_plugin_client_constructor_v1");
     return calloc(1, sizeof(struct plugin_per_client_context));
 }
 
 OPENVPN_EXPORT void
 openvpn_plugin_client_destructor_v1(openvpn_plugin_handle_t handle, void *per_client_context)
 {
-    printf("FUNC: openvpn_plugin_client_destructor_v1\n");
+    plugin_log(PLOG_NOTE, MODULE, "FUNC: openvpn_plugin_client_destructor_v1");
     free(per_client_context);
 }
 
@@ -339,6 +512,6 @@ OPENVPN_EXPORT void
 openvpn_plugin_close_v1(openvpn_plugin_handle_t handle)
 {
     struct plugin_context *context = (struct plugin_context *) handle;
-    printf("FUNC: openvpn_plugin_close_v1\n");
+    plugin_log(PLOG_NOTE, MODULE, "FUNC: openvpn_plugin_close_v1");
     free(context);
 }
-- 
2.26.2


