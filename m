From: Michael Clarke <michael.m.clarke@...277...>
Date: Wed,  6 Nov 2024 16:59:50 +0000
Message-Id: <20241106165950.14469-1-michael.m.clarke@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Allow auth plugins not to be invoked if
 other auth plugins fail
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
To: Openvpn-devel@lists.sourceforge.net

The current authentication process loops through all plugins, invoking
them each in turn, then returning a combined result from each
invocation. This causes a challenge if multiple plugins are configured
and a later plugin should only be executed if an earlier plugin
succeeds - such as sending a Multi-factor authentication challenge only
if a previous username/password verification succeeds - as the OpenVPN
admin has no way of configuring a dependency between plugins, and
plugins have no visibility of the current authentication state, so an
MFA challenge would always be sent even on a password challenge failure
in the stated scenario.

To overcome this, a system similar to Linux PAM's control flags is being
introduced where auth plugins can be marked as one of four states:
allows the plugin to fail without impacting other plugins whilst success
of that plugin prevents any other plugins being run (sufficient),
allow a plugin to fail whilst still then invoking certain other plugins
before failing auth (required), allow a plugin's failure to abort the
process immediately (requisite), or allow the plugin to be invoked but
the result ignored (optional). For backwards compatibility plugins
defined without a scope are treated as having a `required` scope.
Attempting to specify a scope for a plugin that does not return
an `OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY` mask will result in server
startup aborting with an error, as will attempting to specify
`sufficient` plugins after other auth plugins. For simplicity, any
auth plugin that returns a deferred result but isn't specified as being
a `required` scope will result in a server abort so that any subsequent
plugins in the configuration aren't making an assumption about the
deferred result.

To maintain backwards compatibility for plugins being invoked, the
plugin scope is dropped from the command arguments passed to the plugin
initialisation although the plugin binary path continues to be retained.
---
 doc/man-sections/plugin-options.rst |  37 +++++++-
 src/openvpn/plugin.c                | 125 ++++++++++++++++++++++++++--
 src/openvpn/plugin.h                |  10 +++
 3 files changed, 164 insertions(+), 8 deletions(-)

diff --git a/doc/man-sections/plugin-options.rst b/doc/man-sections/plugin-options.rst
index 9266429e..1884fae9 100644
--- a/doc/man-sections/plugin-options.rst
+++ b/doc/man-sections/plugin-options.rst
@@ -13,8 +13,41 @@ plug-ins must be prebuilt and adhere to the OpenVPN Plug-In API.
      plugin module-name
      plugin module-name "arguments"
 
-  The ``module-name`` needs to be the first
-  argument, indicating the plug-in to load.  The second argument is an
+  Additionally, an auth plugin can use the following syntax:
+  ::
+
+     plugin [scope] module-name
+     plugin [scope] module-name "arguments"
+
+  The ``scope`` argument is optional but must be the first argument
+  if specified, and can be one of the following:
+
+    * :code:`sufficient` - If the plugin returns success, the connection is
+      authenticated without calling any other plugins. If the plugin fails
+      then processing will continue on to the next plugin.
+
+      :code:`sufficient` plugins must be listed before any other plugins.
+    * :code:`required` - The plugin must return success for the connection to
+      be authenticated. If the plugin fails then plugins will continue to be
+      invoked until a plugin not defined as :code:`required` is reached, at
+      which point the connection be be aborted as unauthenticated.
+
+      Any plugin returning a deferred result must be in the :code:`required`
+      scope, or not have a scope set.
+    * :code:`requisite` - The plugin must return success for the connection to
+      be authenticated, but if the plugin fails, the connection is immediately
+      terminated without calling any other plugins.
+    * :code:`optional` - The plugin is called, but the result is ignored and
+      will have no bearing on the authentication state of the connection.
+
+  If :code:`scope` is not specified for an auth plugin then the plugin will
+  be treated as :code:`required`.
+
+  If :code:`scope` is specified for a non-auth plugin then the configuration
+  will be treated as invalid.
+
+  The ``module-name`` needs to be the first argument - unless ``scope```, has
+  been specified - indicating the plug-in to load.  The next argument is an
   optional init string which will be passed directly to the plug-in.
   If the init consists of multiple arguments it must be enclosed in
   double-quotes (\").  Multiple plugin modules may be loaded into one
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 944ce94a..6aeb381f 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -172,8 +172,36 @@ plugin_option_list_add(struct plugin_option_list *list, char **p,
     {
         struct plugin_option *o = &list->plugins[list->n++];
         o->argv = make_extended_arg_array(p, false, gc);
-        if (o->argv[0])
+        if (o->argv[0] && o->argv[1])
         {
+            if (!strcmp(o->argv[0], "required"))
+            {
+                o->plugin_scope = PLUGIN_SCOPE_REQUIRED;
+            }
+            else if (!strcmp(o->argv[0], "requisite"))
+            {
+                o->plugin_scope = PLUGIN_SCOPE_REQUISITE;
+            }
+            else if (!strcmp(o->argv[0], "sufficient"))
+            {
+                o->plugin_scope = PLUGIN_SCOPE_SUFFICIENT;
+            }
+            else if (!strcmp(o->argv[0], "optional"))
+            {
+                o->plugin_scope = PLUGIN_SCOPE_OPTIONAL;
+            }
+            else
+            {
+                o->plugin_scope = PLUGIN_SCOPE_UNDEFINED;
+                o->so_pathname = o->argv[0];
+                return true;
+            }
+            o->argv = make_extended_arg_array((char **) &o->argv[1], false, gc);
+            o->so_pathname = o->argv[0];
+        }
+        else if (o->argv[0])
+        {
+            o->plugin_scope = PLUGIN_SCOPE_UNDEFINED;
             o->so_pathname = o->argv[0];
         }
         return true;
@@ -184,6 +212,28 @@ plugin_option_list_add(struct plugin_option_list *list, char **p,
     }
 }
 
+static char *
+plugin_scope_name(enum plugin_scope scope)
+{
+    switch (scope)
+    {
+        case PLUGIN_SCOPE_REQUIRED:
+            return "required";
+
+        case PLUGIN_SCOPE_REQUISITE:
+            return "requisite";
+
+        case PLUGIN_SCOPE_SUFFICIENT:
+            return "sufficient";
+
+        case PLUGIN_SCOPE_OPTIONAL:
+            return "optional";
+
+        default:
+            return "";
+    }
+}
+
 #ifndef ENABLE_SMALL
 void
 plugin_option_list_print(const struct plugin_option_list *list, int msglevel)
@@ -194,7 +244,7 @@ plugin_option_list_print(const struct plugin_option_list *list, int msglevel)
     for (i = 0; i < list->n; ++i)
     {
         const struct plugin_option *o = &list->plugins[i];
-        msg(msglevel, "  plugin[%d] %s '%s'", i, o->so_pathname, print_argv(o->argv, &gc, PA_BRACKET));
+        msg(msglevel, "  plugin[%d] %s %s '%s'", i, plugin_scope_name(o->plugin_scope), o->so_pathname, print_argv(o->argv, &gc, PA_BRACKET));
     }
 
     gc_free(&gc);
@@ -234,6 +284,7 @@ plugin_init_item(struct plugin *p, const struct plugin_option *o)
     bool rel = false;
 
     p->so_pathname = o->so_pathname;
+    p->plugin_scope = o->plugin_scope;
     p->plugin_type_mask = plugin_supported_types();
 
 #ifndef _WIN32
@@ -521,6 +572,13 @@ plugin_open_item(struct plugin *p,
                 plugin_supported_types());
         }
 
+        if ((p->plugin_type_mask & OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)) != OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY) && p->plugin_scope != PLUGIN_SCOPE_UNDEFINED)
+        {
+            msg(M_FATAL, "PLUGIN_INIT: plugin %s is not an OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY plugin, but has a scope: %s",
+                p->so_pathname,
+                plugin_scope_name(p->plugin_scope));
+        }
+
         if (p->plugin_handle == NULL)
         {
             msg(M_FATAL, "PLUGIN_INIT: plugin initialization function failed: %s",
@@ -590,14 +648,16 @@ plugin_call_item(const struct plugin *p,
             ASSERT(0);
         }
 
-        msg(D_PLUGIN, "PLUGIN_CALL: POST %s/%s status=%d",
+        msg(D_PLUGIN, "PLUGIN_CALL: %s POST %s/%s status=%d",
+            plugin_scope_name(p->plugin_scope),
             p->so_pathname,
             plugin_type_name(type),
             status);
 
         if (status == OPENVPN_PLUGIN_FUNC_ERROR)
         {
-            msg(M_WARN, "PLUGIN_CALL: plugin function %s failed with status %d: %s",
+            msg(M_WARN, "PLUGIN_CALL: %s plugin function %s failed with status %d: %s",
+                plugin_scope_name(p->plugin_scope),
                 plugin_type_name(type),
                 status,
                 p->so_pathname);
@@ -739,6 +799,7 @@ plugin_common_open(struct plugin_common *pc,
         plugin_return_init(pr);
     }
 
+    bool non_scope_sufficient_auth_plugin_seen = false;
     for (i = 0; i < pc->n; ++i)
     {
         plugin_open_item(&pc->plugins[i],
@@ -746,6 +807,19 @@ plugin_common_open(struct plugin_common *pc,
                          pr ? &pr->list[i] : NULL,
                          envp,
                          init_point);
+        if (pc->plugins[i].plugin_type_mask != plugin_supported_types() && (pc->plugins[i].plugin_type_mask & OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)) == OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY))
+        {
+            if (non_scope_sufficient_auth_plugin_seen && pc->plugins[i].plugin_scope == PLUGIN_SCOPE_SUFFICIENT)
+            {
+                msg(M_FATAL,
+                    "PLUGIN_INIT: auth plugin %s is defined as 'sufficient' but has been specified after other auth plugins not specified as 'sufficient'",
+                    pc->plugins[i].so_pathname);
+            }
+            if (pc->plugins[i].plugin_scope != PLUGIN_SCOPE_SUFFICIENT)
+            {
+                non_scope_sufficient_auth_plugin_seen = true;
+            }
+        }
     }
 
     if (pr)
@@ -820,9 +894,17 @@ plugin_call_ssl(const struct plugin_list *pl,
         setenv_del(es, "script_type");
         envp = make_env_array(es, false, &gc);
 
+        bool required_failed = false;
+
         for (i = 0; i < n; ++i)
         {
-            const int status = plugin_call_item(&pl->common->plugins[i],
+            const struct plugin *plugin = &pl->common->plugins[i];
+            if (required_failed && plugin->plugin_scope != PLUGIN_SCOPE_REQUIRED && plugin->plugin_scope != PLUGIN_SCOPE_UNDEFINED)
+            {
+                break;
+            }
+
+            const int status = plugin_call_item(plugin,
                                                 pl->per_client.per_client_context[i],
                                                 type,
                                                 av,
@@ -837,6 +919,14 @@ plugin_call_ssl(const struct plugin_list *pl,
                     break;
 
                 case OPENVPN_PLUGIN_FUNC_DEFERRED:
+                    if (plugin->plugin_scope != PLUGIN_SCOPE_REQUIRED && plugin->plugin_scope != PLUGIN_SCOPE_UNDEFINED)
+                    {
+                        error = true;
+                        msg(M_FATAL,
+                            "PLUGIN_CALL: plugin %s returned deferred auth result, but is not in 'required' scope",
+                            plugin->so_pathname);
+                        break;
+                    }
                     if ((type == OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
                         && deferred_auth_done)
                     {
@@ -868,8 +958,31 @@ plugin_call_ssl(const struct plugin_list *pl,
                     break;
 
                 default:
-                    error = true;
+                    if (plugin->plugin_scope != PLUGIN_SCOPE_OPTIONAL)
+                    {
+                        error = true;
+                    }
+                    break;
+            }
+
+            if (plugin->plugin_scope == PLUGIN_SCOPE_SUFFICIENT)
+            {
+                if (error)
+                {
+                    error = false;
+                }
+                else
+                {
                     break;
+                }
+            }
+            if (error && plugin->plugin_scope == PLUGIN_SCOPE_REQUISITE)
+            {
+                break;
+            }
+            if (error && (plugin->plugin_scope == PLUGIN_SCOPE_REQUIRED || plugin->plugin_scope == PLUGIN_SCOPE_UNDEFINED))
+            {
+                required_failed = true;
             }
         }
 
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index ad2e0866..d3ff6c4a 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -42,7 +42,16 @@
 
 #define MAX_PLUGINS 16
 
+enum plugin_scope {
+    PLUGIN_SCOPE_UNDEFINED,
+    PLUGIN_SCOPE_REQUIRED,
+    PLUGIN_SCOPE_REQUISITE,
+    PLUGIN_SCOPE_SUFFICIENT,
+    PLUGIN_SCOPE_OPTIONAL
+};
+
 struct plugin_option {
+    enum plugin_scope plugin_scope;
     const char *so_pathname;
     const char **argv;
 };
@@ -54,6 +63,7 @@ struct plugin_option_list {
 
 struct plugin {
     bool initialized;
+    enum plugin_scope plugin_scope;
     const char *so_pathname;
     unsigned int plugin_type_mask;
     int requested_initialization_point;
-- 
2.39.5 (Apple Git-154)


