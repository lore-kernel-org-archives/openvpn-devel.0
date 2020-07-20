From: Arne Schwabe <arne@...1227...>
Date: Mon, 20 Jul 2020 16:27:03 +0200
Message-Id: <20200720142703.3324-1-arne@...1227...>
In-Reply-To: <E1jxUNh-0007hr-Bd@...2479...>
References: <E1jxUNh-0007hr-Bd@...2479...>
Subject: [Openvpn-devel] [PATCH v7] client-connect: Add documentation for
 the deferred client connect feature
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

Signed-off-by: David Sommerseth <davids@...515...>
Signed-off-by: Arne Schwabe <arne@...1227...>

Patch V5: Fix typos, clarify man page section about deferred client-connect
          script. Add section to Changes.rst

Patch V6: Convert manpage to rst

          It also incoroporates suggested changes from Richard Bonhomme
<tincanteksup@...277...> [0]

[0] Message-ID: <82c2d70f-e2f9-f810-2c55-788358a0cb08@...277...>
    URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20331.html

Patch V7: Reinclude the changes of Changes.rst and openvpn-plugin.h
          Clarify some parts of the documentation.
---
 Changes.rst                          |  5 +++++
 doc/man-sections/generic-options.rst | 11 ++++++----
 doc/man-sections/script-options.rst  | 33 ++++++++++++++++++++++++++++
 include/openvpn-plugin.h.in          | 21 +++++++++++++-----
 4 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 34abcd97..78a66650 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -25,6 +25,11 @@ Improved Data channel cipher negotiation
 Asynchronous (deferred) authentication support for auth-pam plugin.
     See src/plugins/auth-pam/README.auth-pam for details.
 
+Deferred client-connect
+    The ``--client-connect`` option and the connect plugin API allow
+    asynchronous/deferred return of the configuration file in the same way
+    as the auth-plugin.
+
 Deprecated features
 -------------------
 For an up-to-date list of all deprecated options, see this wiki page:
diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generic-options.rst
index d44dc05f..a07fe7e7 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -394,11 +394,14 @@ which mode OpenVPN is configured as.
 
   This directory will be used by in the following cases:
 
-  * ``--client-connect`` scripts to dynamically generate client-specific
-    configuration files.
+  * ``--client-connect`` scripts and :code:`OPENVPN_PLUGIN_CLIENT_CONNECT`
+    plug-in hook to dynamically generate client-specific configuration
+    :code:`client_connect_config_file` and return success/failure via
+    :code:`client_connect_deferred_file` when using deferred client connect
+    method
 
-  * :code:`OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY` plugin hook to return
-    success/failure via ``auth_control_file`` when using deferred auth
+  * :code:`OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY` plug-in hooks returns
+    success/failure via :code:`auth_control_file` when using deferred auth
     method
 
   * :code:`OPENVPN_PLUGIN_ENABLE_PF` plugin hook to pass filtering rules
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index ddc1363c..a1d489b8 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -137,6 +137,13 @@ SCRIPT HOOKS
   returns a non-zero error status, it will cause the client to be
   disconnected.
 
+  If a ``--client-connect`` wants to defer the generating of the
+  configuration then the script should use the
+  :code:`client_connect_deferred_file` and
+  :code:`client_connect_config_file` environment variables. And write
+  status accordingly into these files.  See the `Environmental Variables`_
+  section for more details.
+
 --client-disconnect cmd
   Like ``--client-connect`` but called on client instance shutdown. Will
   not be called unless the ``--client-connect`` script and plugins (if
@@ -512,6 +519,32 @@ instances.
     Total number of bytes sent to client during VPN session. Set prior to
     execution of the ``--client-disconnect`` script.
 
+:code:`client_connect_config_file`
+    The path to the configuration file that should be written by the
+    ``--client-connect`` script.  The content of this environment variable
+    is identical to the file as an argument of the called
+    ``--client-connect`` script.
+
+:code:`client_connect_deferred_file`
+    This file can be optionally written to to communicate a status code of
+    the ``--client-connect`` script.  The first character in the file must
+    be either :code:`1` to indicate normal script execution, :code:`0`
+    indicates an error (in the same way that a non zero exit status does)
+    or :code:`2` to indicate that the script deferred returning the config
+    file. When the script defers returning the configuration, it must also
+    write :code:`2` to the file to indicate the deferral.
+
+    A background process or similar must then take care of writing the
+    configuration to the file indicated by the
+    :code:`client_connect_config_file` environment variable and when
+    finished, write the a :code:`1` to this file (or :code:`0` in case of
+    an error).
+
+    The absence of any character in the file when the script finishes
+    executing is interpreted the same as :code:`1`. This allows scripts
+    that are not written to support the defer mechanism to be used
+    unmodified.
+
 :code:`common_name`
     The X509 common name of an authenticated client. Set prior to execution
     of ``--client-connect``, ``--client-disconnect`` and
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index 38fbe097..64b20886 100644
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
+ * this is done by writing a single char to the file named by
+ * auth_control_file/client_connect_deferred_file
+ * in the environmental variable list (envp).
+ *
+ * In addition the OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER and
+ * OPENVPN_PLUGIN_CLIENT_CONNECT_DEFER_V2 are called when OpenVPN tries to
+ * get the deferred result. For a V2 call implementing this function is
+ * required as information is not passed by files. For the normal version
+ * the call is optional.
  *
  * first char of auth_control_file:
  * '0' -- indicates auth failure
-- 
2.26.2


