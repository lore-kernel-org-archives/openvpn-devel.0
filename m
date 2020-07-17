From: Gert Doering <gert@...1296...>
Date: Fri, 17 Jul 2020 21:08:01 +0200
Message-Id: <20200717190801.17780-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add demo plugin that excercises
 "CLIENT_CONNECT" and "CLIENT_CONNECT_V2" paths
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

This is a new "samples" plugin which does not do many useful things,
besides
 - show how a plugin is programmed
 - how the various messages get dispatched
 - how to pass back information from a client-connect/v2 plugin
 - how to do async-cc plugins  [not yet implemented]

the operation of the plugin is controlled by UV_WANT_* environment variables
controlled by the client ("--setenv UV_WANT_CC_FAIL 1 --push-peer-info"),
to "fail CLIENT_CONNECT" or "use async-cc for CLIENT_CONNECT_V2" or
"send 'disable' back from ...") - which is useful for automated testing
of server success/defer/fail code paths for the CLIENT_CONNECT_* functions.

See samples/sample-plugins/client-connect/README for details how to do this.
---
 sample/sample-plugins/client-connect/README   |  33 ++
 sample/sample-plugins/client-connect/build    |  15 +
 .../client-connect/sample-client-connect.c    | 375 ++++++++++++++++++
 3 files changed, 423 insertions(+)
 create mode 100644 sample/sample-plugins/client-connect/README
 create mode 100755 sample/sample-plugins/client-connect/build
 create mode 100644 sample/sample-plugins/client-connect/sample-client-connect.c

diff --git a/sample/sample-plugins/client-connect/README b/sample/sample-plugins/client-connect/README
new file mode 100644
index 00000000..2dd10dc3
--- /dev/null
+++ b/sample/sample-plugins/client-connect/README
@@ -0,0 +1,33 @@
+OpenVPN plugin examples.
+
+Examples provided:
+
+sample-client-connect.c
+
+  - hook to all plugin hooks that openvpn offers
+  - log which hook got called
+  - on CLIENT_CONNECT or CLIENT_CONNECT_V2 set some config variables
+    (push "route 192.0.2.x" and other easy recognizeable things)
+
+  - if the environment variable UV_WANT_CC_FAIL is set, fail
+  - if the environment variable UV_WANT_CC_DISABLE is set, reject ("disable")
+  - if the environment variable UV_WANT_CC_ASYNC is set, go to 
+    asynchronous/deferred mode on CLIENT_CONNECT, and sleep for 
+    ${UV_WANT_CC_ASYNC} seconds
+
+  - if the environment variable UV_WANT_CC2_FAIL is set, fail CC2
+  - if the environment variable UV_WANT_CC2_DISABLE is set, reject ("disable")
+  - if the environment variable UV_WANT_CC2_ASYNC is set, go to 
+    asynchronous/deferred mode on CLIENT_CONNECT_V2, and sleep for 
+    ${UV_WANT_CC2_ASYNC} seconds
+
+    (this can be client-controlled with --setenv UV_WANT_CC_ASYNC nnn
+     etc. --> for easy testing server code paths)
+
+To build:
+
+  ./build sample-client-connect (Linux/BSD/etc.)
+
+To use in OpenVPN, add to config file:
+
+  plugin sample-client-connect.so (Linux/BSD/etc.)
diff --git a/sample/sample-plugins/client-connect/build b/sample/sample-plugins/client-connect/build
new file mode 100755
index 00000000..3f93aa4f
--- /dev/null
+++ b/sample/sample-plugins/client-connect/build
@@ -0,0 +1,15 @@
+#!/bin/sh
+
+#
+# Build an OpenVPN plugin module on *nix.  The argument should
+# be the base name of the C source file (without the .c).
+#
+
+# This directory is where we will look for openvpn-plugin.h
+CPPFLAGS="${CPPFLAGS:--I../../../include}"
+
+CC="${CC:-gcc}"
+CFLAGS="${CFLAGS:--O2 -Wall -Wno-unused-variable -g}"
+
+$CC $CPPFLAGS $CFLAGS -fPIC -c $1.c && \
+$CC $CFLAGS -fPIC -shared $LDFLAGS -Wl,-soname,$1.so -o $1.so $1.o -lc
diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b/sample/sample-plugins/client-connect/sample-client-connect.c
new file mode 100644
index 00000000..36dad4b9
--- /dev/null
+++ b/sample/sample-plugins/client-connect/sample-client-connect.c
@@ -0,0 +1,375 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/*
+ * This file implements a simple OpenVPN plugin module which
+ * will log the calls made, and send back some config statements
+ * when called on the CLIENT_CONNECT and CLIENT_CONNECT_V2 hooks.
+ *
+ * it can be asked to fail or go to async/deferred mode by setting
+ * environment variables (UV_WANT_CC_FAIL, UV_WANT_CC_ASYNC,
+ * UV_WANT_CC2_ASYNC) - mostly used as a testing vehicle for the
+ * server side code to handle these cases
+ *
+ * See the README file for build instructions.
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+
+#include "openvpn-plugin.h"
+
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <stdbool.h>
+
+#include "openvpn-plugin.h"
+
+/* Pointers to functions exported from openvpn */
+static plugin_log_t plugin_log = NULL;
+static plugin_secure_memzero_t plugin_secure_memzero = NULL;
+static plugin_base64_decode_t plugin_base64_decode = NULL;
+
+/* module name for plugin_log() */
+static char *MODULE = "sample-cc";
+
+/*
+ * Our context, where we keep our state.
+ */
+
+struct plugin_context {
+    int verb;				/* logging verbosity */
+};
+
+/* TODO: see if this should go (together with constructor/destructor)
+ * or if we can make it into a useful demo
+ */
+struct plugin_per_client_context {
+    int n_calls;
+    bool generated_pf_file;
+};
+
+/*
+ * Given an environmental variable name, search
+ * the envp array for its value, returning it
+ * if found or NULL otherwise.
+ */
+static const char *
+get_env(const char *name, const char *envp[])
+{
+    if (envp)
+    {
+        int i;
+        const int namelen = strlen(name);
+        for (i = 0; envp[i]; ++i)
+        {
+            if (!strncmp(envp[i], name, namelen))
+            {
+                const char *cp = envp[i] + namelen;
+                if (*cp == '=')
+                {
+                    return cp + 1;
+                }
+            }
+        }
+    }
+    return NULL;
+}
+
+
+static int
+atoi_null0(const char *str)
+{
+    if (str)
+    {
+        return atoi(str);
+    }
+    else
+    {
+        return 0;
+    }
+}
+
+/* use v3 functions so we can use openvpn's logging and base64 etc. */
+OPENVPN_EXPORT int
+openvpn_plugin_open_v3(const int v3structver,
+                       struct openvpn_plugin_args_open_in const *args,
+                       struct openvpn_plugin_args_open_return *ret)
+{
+    const char **argv = args->argv;
+    const char **envp = args->envp;
+
+    /* Check API compatibility -- struct version 5 or higher needed */
+    if (v3structver < 5)
+    {
+        fprintf(stderr, "sample-client-connect: this plugin is incompatible with the running version of OpenVPN\n");
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
+    /*
+     * Allocate our context
+     */
+    struct plugin_context *context = calloc(1, sizeof(struct plugin_context));
+    if (!context)
+    {
+        goto error;
+    }
+
+    /*
+     * Intercept just about everything...
+     */
+    ret->type_mask =
+        OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_UP)
+        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_DOWN)
+        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_ROUTE_UP)
+        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_IPCHANGE)
+        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_VERIFY)
+        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT)
+        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT_V2)
+        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_DISCONNECT)
+        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_LEARN_ADDRESS)
+        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_FINAL);
+
+    /* Save global pointers to functions exported from openvpn */
+    plugin_log = args->callbacks->plugin_log;
+    plugin_secure_memzero = args->callbacks->plugin_secure_memzero;
+    plugin_base64_decode = args->callbacks->plugin_base64_decode;
+
+    /*
+     * Get verbosity level from environment
+     */
+    context->verb = atoi_null0(get_env("verb", envp));
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
+    return OPENVPN_PLUGIN_FUNC_ERROR;
+}
+
+
+/* there are two possible interfaces for an openvpn plugin how
+ * to be called on "client connect", which primarily differ in the
+ * way config options are handed back to the client instance
+ * (see openvpn/multi.c, multi_client_connect_call_plugin_{v1,v2}())
+ *
+ * OPENVPN_PLUGIN_CLIENT_CONNECT
+ *   openvpn creates a temp file and passes the name to the plugin
+ *    (via argv[1] variable, argv[0] is the name of the plugin)
+ *   the plugin can write config statements to that file, and openvpn
+ *    reads it in like a "ccd/$cn" per-client config file
+ *
+ * OPENVPN_PLUGIN_CLIENT_CONNECT_V2
+ *   the caller passes in a pointer to an "openvpn_plugin_string_list"
+ *   (openvpn-plugin.h), which is a linked list of (name,value) pairs
+ *
+ *   we fill in one node with name="config" and value="our config"
+ *
+ *   both "l" and "l->name" and "l->value" are malloc()ed by the plugin
+ *   and free()ed by the caller (openvpn_plugin_string_list_free())
+ */
+
+int
+openvpn_plugin_client_connect(struct plugin_context *context,
+			      const char **argv,
+			      const char **envp)
+{
+    /* log environment variables handed to us by OpenVPN, but
+     * only if "setenv verb" is 3 or higher (arbitrary number)
+     */
+    if (context->verb>=3)
+    {
+	for (int i = 0; argv[i]; i++)
+	{
+	    plugin_log(PLOG_NOTE, MODULE, "per-client argv: %s", argv[i]);
+        }
+	for (int i = 0; envp[i]; i++)
+	{
+	    plugin_log(PLOG_NOTE, MODULE, "per-client env: %s", envp[i]);
+	}
+    }
+
+    /* by setting "UV_WANT_CC_FAIL" we can be triggered to fail */
+    const char *p = get_env("UV_WANT_CC_FAIL", envp);
+    if (p)
+    {
+	plugin_log(PLOG_NOTE, MODULE, "env has UV_WANT_CC_FAIL=%s -> fail", p);
+	return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
+    /* does the caller want options?  give them some */
+    if (argv[1])
+    {
+	FILE *fp = fopen(argv[1],"w");
+	if (!fp)
+	{
+	    plugin_log(PLOG_ERR, MODULE, "fopen('%s') failed", argv[1]);
+	    return OPENVPN_PLUGIN_FUNC_ERROR;
+	}
+	fprintf(fp, "push \"route 192.0.2.1 255.255.255.255\"\n");
+	fprintf(fp, "push \"echo sample-cc plugin 1 called\"\n");
+	if (get_env("UV_WANT_CC_DISABLE", envp))
+	{
+	    plugin_log(PLOG_NOTE, MODULE, "env has UV_WANT_CC_DISABLE, reject");
+	    fprintf(fp, "disable\n");
+	}
+	fclose(fp);
+    }
+
+    return OPENVPN_PLUGIN_FUNC_SUCCESS;
+}
+
+int
+openvpn_plugin_client_connect_v2(struct plugin_context *context,
+				 const char **envp,
+				 struct openvpn_plugin_string_list **return_list)
+{
+    /* by setting "UV_WANT_CC2_FAIL" we can be triggered to fail here */
+    const char *p = get_env("UV_WANT_CC2_FAIL", envp);
+    if (p)
+    {
+	plugin_log(PLOG_NOTE, MODULE, "env has UV_WANT_CC2_FAIL=%s -> fail", p);
+	return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
+    struct openvpn_plugin_string_list *rl = 
+	calloc(1, sizeof(struct openvpn_plugin_string_list));
+    if (!rl)
+    {
+	plugin_log(PLOG_ERR, MODULE, "malloc(return_list) failed");
+	return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+    rl->name = strdup("config");
+    if (get_env("UV_WANT_CC2_DISABLE", envp))
+    {
+	plugin_log(PLOG_NOTE, MODULE, "env has UV_WANT_CC2_DISABLE, reject");
+	rl->value = strdup("disable\n");
+    }
+    else
+    {
+	rl->value = strdup("push \"route 192.0.2.2 255.255.255.255\"\npush \"setenv MOOH\"\n");
+    }
+
+    if (!rl->name || !rl->value)
+    {
+	plugin_log(PLOG_ERR, MODULE, "malloc(return_list->xx) failed");
+	return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+
+    *return_list = rl;
+
+    return OPENVPN_PLUGIN_FUNC_SUCCESS;
+}
+
+OPENVPN_EXPORT int
+openvpn_plugin_func_v2(openvpn_plugin_handle_t handle,
+                       const int type,
+                       const char *argv[],
+                       const char *envp[],
+                       void *per_client_context,
+                       struct openvpn_plugin_string_list **return_list)
+{
+    struct plugin_context *context = (struct plugin_context *) handle;
+    struct plugin_per_client_context *pcc = (struct plugin_per_client_context *) per_client_context;
+
+    /* for most functions, we just "don't do anything" but log the
+     * event received (so one can follow it in the log and understand
+     * the sequence of events).  CONNECT and CONNECT_V2 are handled
+     */
+    switch (type)
+    {
+        case OPENVPN_PLUGIN_UP:
+	    plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_UP");
+	    break;
+
+        case OPENVPN_PLUGIN_DOWN:
+	    plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_DOWN");
+	    break;
+
+        case OPENVPN_PLUGIN_ROUTE_UP:
+	    plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_ROUTE_UP");
+	    break;
+
+        case OPENVPN_PLUGIN_IPCHANGE:
+	    plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_IPCHANGE");
+	    break;
+
+        case OPENVPN_PLUGIN_TLS_VERIFY:
+	    plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_TLS_VERIFY");
+	    break;
+
+        case OPENVPN_PLUGIN_CLIENT_CONNECT:
+	    plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_CLIENT_CONNECT");
+	    return openvpn_plugin_client_connect(context, argv, envp);
+
+        case OPENVPN_PLUGIN_CLIENT_CONNECT_V2:
+	    plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_CLIENT_CONNECT_V2");
+	    return openvpn_plugin_client_connect_v2(context, envp,
+						    return_list);
+
+        case OPENVPN_PLUGIN_CLIENT_DISCONNECT:
+	    plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_CLIENT_DISCONNECT");
+	    break;
+
+        case OPENVPN_PLUGIN_LEARN_ADDRESS:
+	    plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_LEARN_ADDRESS");
+	    break;
+
+        case OPENVPN_PLUGIN_TLS_FINAL:
+	    plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_TLS_FINAL");
+	    break;
+
+        default:
+	    plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_? type=%d\n", type);
+    }
+    return OPENVPN_PLUGIN_FUNC_SUCCESS;
+}
+
+OPENVPN_EXPORT void *
+openvpn_plugin_client_constructor_v1(openvpn_plugin_handle_t handle)
+{
+    printf("FUNC: openvpn_plugin_client_constructor_v1\n");
+    return calloc(1, sizeof(struct plugin_per_client_context));
+}
+
+OPENVPN_EXPORT void
+openvpn_plugin_client_destructor_v1(openvpn_plugin_handle_t handle, void *per_client_context)
+{
+    printf("FUNC: openvpn_plugin_client_destructor_v1\n");
+    free(per_client_context);
+}
+
+OPENVPN_EXPORT void
+openvpn_plugin_close_v1(openvpn_plugin_handle_t handle)
+{
+    struct plugin_context *context = (struct plugin_context *) handle;
+    printf("FUNC: openvpn_plugin_close_v1\n");
+    free(context);
+}
-- 
2.26.2


