From: David Sommerseth <dazo@...384...>
Date: Fri, 10 Dec 2010 01:30:50 +0100
Message-Id: <1291941053-748-2-git-send-email-dazo@...384...>
In-Reply-To: <1291941053-748-1-git-send-email-dazo@...384...>
References: <1291941053-748-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH v2 1/4] Define the new openvpn_plugin_{open,
	func}_v3() API
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
Cc: David Sommerseth <dazo@...384...>

This just implements the basic API changes needed for the newer and more
flexible plug-in API.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 openvpn-plugin.h |  222 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 plugin.c         |    6 +-
 plugin.h         |    2 +
 3 files changed, 227 insertions(+), 3 deletions(-)

diff --git a/openvpn-plugin.h b/openvpn-plugin.h
index 173a0c1..43c1d3a 100644
--- a/openvpn-plugin.h
+++ b/openvpn-plugin.h
@@ -22,7 +22,7 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#define OPENVPN_PLUGIN_VERSION 2
+#define OPENVPN_PLUGIN_VERSION 3
 
 /*
  * Plug-in types.  These types correspond to the set of script callbacks
@@ -163,6 +163,114 @@ struct openvpn_plugin_string_list
   char *value;
 };
 
+
+/* openvpn_plugin_{open,func}_v3() related structs */
+
+/**
+ * Arguments used to transport variables to the plug-in.
+ * The struct openvpn_plugin_args_open_in is only used
+ * by the openvpn_plugin_open_v3() function.
+ *
+ * STRUCT MEMBERS
+ *
+ * type_mask : Set by OpenVPN to the logical OR of all script
+ *             types which this version of OpenVPN supports.
+ *
+ * argv : a NULL-terminated array of options provided to the OpenVPN
+ *        "plug-in" directive.  argv[0] is the dynamic library pathname.
+ *
+ * envp : a NULL-terminated array of OpenVPN-set environmental
+ *        variables in "name=value" format.  Note that for security reasons,
+ *        these variables are not actually written to the "official"
+ *        environmental variable store of the process.
+ */
+struct openvpn_plugin_args_open_in
+{
+  const int type_mask;
+  const char const **argv;
+  const char const **envp;
+};
+
+
+/**
+ * Aruguments used to transport variables from the plug-in back
+ * to the OpenVPN process.  The struct openvpn_plugin_args_open_return
+ * is only used by the openvpn_plugin_open_v3() function.
+ *
+ * STRUCT MEMBERS
+ *
+ * *type_mask : The plug-in should set this value to the logical OR of all script
+ *              types which the plug-in wants to intercept.  For example, if the
+ *              script wants to intercept the client-connect and client-disconnect
+ *              script types:
+ *
+ *              *type_mask = OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT)
+ *                         | OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_DISCONNECT)
+ *
+ * *handle :    Pointer to a global plug-in context, created by the plug-in.  This pointer
+ *              is passed on to the other plug-in calls.
+ *
+ * return_list : used to return data back to OpenVPN.
+ *
+ */
+struct openvpn_plugin_args_open_return
+{
+  int  type_mask;
+  openvpn_plugin_handle_t *handle;
+  struct openvpn_plugin_string_list **return_list;
+};
+
+/**
+ * Aruguments used to transport variables to and from the
+ * plug-in.  The struct openvpn_plugin_args_func is only used
+ * by the openvpn_plugin_func_v3() function.
+ *
+ * STRUCT MEMBERS:
+ *
+ * type : one of the PLUGIN_x types.
+ *
+ * argv : a NULL-terminated array of "command line" options which
+ *        would normally be passed to the script.  argv[0] is the dynamic
+ *        library pathname.
+ *
+ * envp : a NULL-terminated array of OpenVPN-set environmental
+ *        variables in "name=value" format.  Note that for security reasons,
+ *        these variables are not actually written to the "official"
+ *        environmental variable store of the process.
+ *
+ * *handle : Pointer to a global plug-in context, created by the plug-in's openvpn_plugin_open_v3().
+ *
+ * *per_client_context : the per-client context pointer which was returned by
+ *        openvpn_plugin_client_constructor_v1, if defined.
+ *
+ *
+ */
+struct openvpn_plugin_args_func_in
+{
+  const int type;
+  const char const **argv;
+  const char const **envp;
+  openvpn_plugin_handle_t handle;
+  void *per_client_context;
+};
+
+
+/**
+ * Aruguments used to transport variables to and from the
+ * plug-in.  The struct openvpn_plugin_args_func is only used
+ * by the openvpn_plugin_func_v3() function.
+ *
+ * STRUCT MEMBERS:
+ *
+ * return_list : used to return data back to OpenVPN for further processing/usage by
+ *               the OpenVPN executable.
+ *
+ */
+struct openvpn_plugin_args_func_return
+{
+  struct openvpn_plugin_string_list **return_list;
+};
+
 /*
  * Multiple plugin modules can be cascaded, and modules can be
  * used in tandem with scripts.  The order of operation is that
@@ -329,6 +437,118 @@ OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_func_v2)
       void *per_client_context,
       struct openvpn_plugin_string_list **return_list);
 
+
+/*
+ * FUNCTION: openvpn_plugin_open_v3
+ *
+ * REQUIRED: YES
+ *
+ * Called on initial plug-in load.  OpenVPN will preserve plug-in state
+ * across SIGUSR1 restarts but not across SIGHUP restarts.  A SIGHUP reset
+ * will cause the plugin to be closed and reopened.
+ *
+ * ARGUMENTS
+ *
+ * version : fixed value, defines the API version of the OpenVPN plug-in API.  The plug-in
+ *	     should validate that this value is matching the OPENVPN_PLUGIN_VERSION value.
+ *
+ * arguments : Structure with all arguments available to the plug-in.
+ *
+ * retptr :    used to return data back to OpenVPN.
+ *
+ * RETURN VALUE
+ *
+ * OPENVPN_PLUGIN_FUNC_SUCCESS on success, OPENVPN_PLUGIN_FUNC_ERROR on failure
+ */
+OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_open_v3)
+     (const int version,
+      struct openvpn_plugin_args_open_in const *arguments,
+      struct openvpn_plugin_args_open_return *retptr);
+
+/*
+ * FUNCTION: openvpn_plugin_func_v3
+ *
+ * Called to perform the work of a given script type.
+ *
+ * REQUIRED: YES
+ *
+ * ARGUMENTS
+ *
+ * version : fixed value, defines the API version of the OpenVPN plug-in API.  The plug-in
+ *           should validate that this value is matching the OPENVPN_PLUGIN_VERSION value.
+ *
+ * handle : the openvpn_plugin_handle_t value which was returned by
+ *          openvpn_plugin_open.
+ *
+ * return_list : used to return data back to OpenVPN.
+ *
+ * RETURN VALUE
+ *
+ * OPENVPN_PLUGIN_FUNC_SUCCESS on success, OPENVPN_PLUGIN_FUNC_ERROR on failure
+ *
+ * In addition, OPENVPN_PLUGIN_FUNC_DEFERRED may be returned by
+ * OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY.  This enables asynchronous
+ * authentication where the plugin (or one of its agents) may indicate
+ * authentication success/failure some number of seconds after the return
+ * of the OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY handler by writing a single
+ * char to the file named by auth_control_file in the environmental variable
+ * list (envp).
+ *
+ * first char of auth_control_file:
+ * '0' -- indicates auth failure
+ * '1' -- indicates auth success
+ *
+ * OpenVPN will delete the auth_control_file after it goes out of scope.
+ *
+ * If an OPENVPN_PLUGIN_ENABLE_PF handler is defined and returns success
+ * for a particular client instance, packet filtering will be enabled for that
+ * instance.  OpenVPN will then attempt to read the packet filter configuration
+ * from the temporary file named by the environmental variable pf_file.  This
+ * file may be generated asynchronously and may be dynamically updated during the
+ * client session, however the client will be blocked from sending or receiving
+ * VPN tunnel packets until the packet filter file has been generated.  OpenVPN
+ * will periodically test the packet filter file over the life of the client
+ * instance and reload when modified.  OpenVPN will delete the packet filter file
+ * when the client instance goes out of scope.
+ *
+ * Packet filter file grammar:
+ *
+ * [CLIENTS DROP|ACCEPT]
+ * {+|-}common_name1
+ * {+|-}common_name2
+ * . . .
+ * [SUBNETS DROP|ACCEPT]
+ * {+|-}subnet1
+ * {+|-}subnet2
+ * . . .
+ * [END]
+ *
+ * Subnet: IP-ADDRESS | IP-ADDRESS/NUM_NETWORK_BITS
+ *
+ * CLIENTS refers to the set of clients (by their common-name) which
+ * this instance is allowed ('+') to connect to, or is excluded ('-')
+ * from connecting to.  Note that in the case of client-to-client
+ * connections, such communication must be allowed by the packet filter
+ * configuration files of both clients.
+ *
+ * SUBNETS refers to IP addresses or IP address subnets which this
+ * instance may connect to ('+') or is excluded ('-') from connecting
+ * to.
+ *
+ * DROP or ACCEPT defines default policy when there is no explicit match
+ * for a common-name or subnet.  The [END] tag must exist.  A special
+ * purpose tag called [KILL] will immediately kill the client instance.
+ * A given client or subnet rule applies to both incoming and outgoing
+ * packets.
+ *
+ * See plugin/defer/simple.c for an example on using asynchronous
+ * authentication and client-specific packet filtering.
+ */
+OPENVPN_PLUGIN_DEF int OPENVPN_PLUGIN_FUNC(openvpn_plugin_func_v3)
+     (const int version,
+      struct openvpn_plugin_args_func_in const *arguments,
+      struct openvpn_plugin_args_func_return *retptr);
+
 /*
  * FUNCTION: openvpn_plugin_close_v1
  *
diff --git a/plugin.c b/plugin.c
index 769de8d..92f7908 100644
--- a/plugin.c
+++ b/plugin.c
@@ -232,8 +232,10 @@ plugin_init_item (struct plugin *p, const struct plugin_option *o)
 
   PLUGIN_SYM (open1, "openvpn_plugin_open_v1", 0);
   PLUGIN_SYM (open2, "openvpn_plugin_open_v2", 0);
+  PLUGIN_SYM (open3, "openvpn_plugin_open_v3", 0);
   PLUGIN_SYM (func1, "openvpn_plugin_func_v1", 0);
   PLUGIN_SYM (func2, "openvpn_plugin_func_v2", 0);
+  PLUGIN_SYM (func3, "openvpn_plugin_func_v3", 0);
   PLUGIN_SYM (close, "openvpn_plugin_close_v1", PLUGIN_SYMBOL_REQUIRED);
   PLUGIN_SYM (abort, "openvpn_plugin_abort_v1", 0);
   PLUGIN_SYM (client_constructor, "openvpn_plugin_client_constructor_v1", 0);
@@ -241,10 +243,10 @@ plugin_init_item (struct plugin *p, const struct plugin_option *o)
   PLUGIN_SYM (min_version_required, "openvpn_plugin_min_version_required_v1", 0);
   PLUGIN_SYM (initialization_point, "openvpn_plugin_select_initialization_point_v1", 0);
 
-  if (!p->open1 && !p->open2)
+  if (!p->open1 && !p->open2 && !p->open3)
     msg (M_FATAL, "PLUGIN: symbol openvpn_plugin_open_vX is undefined in plugin: %s", p->so_pathname);
 
-  if (!p->func1 && !p->func2)
+  if (!p->func1 && !p->func2 && !p->func3)
     msg (M_FATAL, "PLUGIN: symbol openvpn_plugin_func_vX is undefined in plugin: %s", p->so_pathname);
 
   /*
diff --git a/plugin.h b/plugin.h
index 969d451..214db2f 100644
--- a/plugin.h
+++ b/plugin.h
@@ -61,8 +61,10 @@ struct plugin {
 
   openvpn_plugin_open_v1 open1;
   openvpn_plugin_open_v2 open2;
+  openvpn_plugin_open_v3 open3;
   openvpn_plugin_func_v1 func1;
   openvpn_plugin_func_v2 func2;
+  openvpn_plugin_func_v3 func3;
   openvpn_plugin_close_v1 close;
   openvpn_plugin_abort_v1 abort;
   openvpn_plugin_client_constructor_v1 client_constructor;
-- 
1.7.2.3


