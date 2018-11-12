From: Arne Schwabe <arne@...1227...>
Date: Mon, 12 Nov 2018 12:56:27 +0100
Message-Id: <20181112115627.5096-14-arne@...1227...>
In-Reply-To: <20181112115627.5096-1-arne@...1227...>
References: <20181112115627.5096-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3 13/13] client-connect: Add documentation
 for the deferred client connect feature
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/openvpn.8               | 47 ++++++++++++++++++++++++++++++++++---
 include/openvpn-plugin.h.in | 21 ++++++++++++-----
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 94b5cc4f..9377bbf5 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3346,6 +3346,13 @@ is significant.  If
 .B script
 returns a non\-zero error status, it will cause the client
 to be disconnected.
+
+If a
+.B \-\-client\-connect cmd
+wants to defer the generating the configuration the script should
+use the client_connect_deferred_file and client_connect_config_file
+environment variables and write status acorrdingly into these files
+(See the environment section below for more details).
 .\"*********************************************************
 .TP
 .B \-\-client\-disconnect cmd
@@ -3428,12 +3435,18 @@ This directory will be used by in the following cases:
 
 *
 .B \-\-client\-connect
-scripts to dynamically generate client\-specific
-configuration files.
+scripts and
+.B OPENVPN_PLUGIN_CLIENT_CONNECT
+plugin hook 
+to dynamically generate client\-specific configuration files
+and return success/failure via client_connect_deferred_file
+when using deferred client connect method
 
 *
 .B OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY
-plugin hook to return success/failure via auth_control_file
+and 
+
+plugin hook to return success/failure via auth_control_file/
 when using deferred auth method
 
 *
@@ -6431,6 +6444,34 @@ Set prior to execution of the
 script.
 .\"*********************************************************
 .TP
+.B client_connect_config_file
+The path to the configuration file that should be written by
+the
+.B \-\-client\-connect
+The content of this enviroment variable is identical to the
+file as a argument of the called
+.B \-\-client\-connect
+script.
+.\"*********************************************************
+.TP
+.B client_connect_defferred_file
+This file can be optionally written to communicate a status
+code of the
+.TP
+.B \-\-client\-connect
+script. If used for deferring, this file must be written
+before the
+.B \-\-client\-connect
+script exits. The first character in the file is interpreted
+and 1 is equal to normal script execution, 0 indicated and
+error (in the same way that a non zero exit status does) and
+2 indicates that the script deferred returning the config
+file. When the script defers the executing it must first write 2
+during the execution of the script. A background process or similar
+must then take of writing the client_connect_config_file and when
+finished, write the a 1 to this file.
+.\"*********************************************************
+.TP
 .B common_name
 The X509 common name of an authenticated client.
 Set prior to execution of
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index 38fbe097..fce59422 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -557,12 +557,21 @@ OPENVPN_PLUGIN_DEF openvpn_plugin_handle_t OPENVPN_PLUGIN_FUNC(openvpn_plugin_op
  * OPENVPN_PLUGIN_FUNC_SUCCESS on success, OPENVPN_PLUGIN_FUNC_ERROR on failure
  *
  * In addition, OPENVPN_PLUGIN_FUNC_DEFERRED may be returned by
- * OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY.  This enables asynchronous
- * authentication where the plugin (or one of its agents) may indicate
- * authentication success/failure some number of seconds after the return
- * of the OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY handler by writing a single
- * char to the file named by auth_control_file in the environmental variable
- * list (envp).
+ * OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, OPENVPN_PLUGIN_CLIENT_CONNECT and
+ * OPENVPN_PLUGIN_CLIENT_CONNECT_V2. This enables asynchronous
+ * authentication or client connect  where the plugin (or one of its agents) 
+ * may indicate authentication success/failure or client configuration some
+ * number of seconds after the return of the function handler.
+ * For OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY and OPENVPN_PLUGIN_CLIENT_CONNECT
+ * this done by writing a single char to the file named by
+ * auth_control_file/client_connect_deferred_file
+ * in the environmental variable list (envp).
+ *
+ * In Addition the OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER and 
+ * OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2 are called when OpenVPN tries to
+ * get the deferred result. For V2 call implementing this function is 
+ * required as information is not passed by files. For the normal version
+ * the call is optional.
  *
  * first char of auth_control_file:
  * '0' -- indicates auth failure
-- 
2.19.1


