From: David Sommerseth <openvpn@...2080...>
Date: Sun, 13 Mar 2022 20:31:53 +0100
Message-Id: <20220313193154.9350-3-openvpn@...2080...>
In-Reply-To: <20220313193154.9350-1-openvpn@...2080...>
References: <20220313193154.9350-1-openvpn@...2080...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4 2/3] plug-ins: Disallow multiple deferred
 authentication plug-ins
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

From: David Sommerseth <davids@...515...>

The plug-in API in OpenVPN 2.x is not designed for running multiple
deferred authentication processes in parallel. The authentication
results of such configurations are not to be trusted.  For now we bail
out when this discovered with an error in the log.

CVE: 2022-0547
Signed-off-by: David Sommerseth <davids@...515...>

---
v2 - flip CONSTANT==var to var==CONSTANT in if() clause
v3 - Use M_FATAL instead of M_ERR
---
 doc/man-sections/plugin-options.rst |  9 ++++++++
 src/openvpn/plugin.c                | 33 ++++++++++++++++++++++++++---
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/doc/man-sections/plugin-options.rst b/doc/man-sections/plugin-options.rst
index 51c574fe..6cbbc2f3 100644
--- a/doc/man-sections/plugin-options.rst
+++ b/doc/man-sections/plugin-options.rst
@@ -55,3 +55,12 @@ plug-ins must be prebuilt and adhere to the OpenVPN Plug-In API.
   (such as tls-verify, auth-user-pass-verify, or client-connect), then
   every module and script must return success (:code:`0`) in order for the
   connection to be authenticated.
+
+  **WARNING**:
+        Plug-ins may do deferred execution, meaning the plug-in will
+        return the control back to the main OpenVPN process and provide
+        the plug-in result later on via a different thread or process.
+        OpenVPN does **NOT** support multiple authentication plug-ins
+        **where more than one of them** do deferred authentication.
+        If this behaviour is detected, OpenVPN will shut down upon first
+        authentication.
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index e3a89293..8236e29e 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -802,7 +802,7 @@ plugin_call_ssl(const struct plugin_list *pl,
         const char **envp;
         const int n = plugin_n(pl);
         bool error = false;
-        bool deferred = false;
+        bool deferred_auth_done = false;
 
         setenv_del(es, "script_type");
         envp = make_env_array(es, false, &gc);
@@ -824,7 +824,34 @@ plugin_call_ssl(const struct plugin_list *pl,
                     break;
 
                 case OPENVPN_PLUGIN_FUNC_DEFERRED:
-                    deferred = true;
+                    if ((type == OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
+                        && deferred_auth_done)
+                    {
+                        /*
+                         * Do not allow deferred auth if a deferred auth has
+                         * already been started.  This should allow a single
+                         * deferred auth call to happen, with one or more
+                         * auth calls with an instant authentication result.
+                         *
+                         * The plug-in API is not designed for multiple
+                         * deferred authentications to happen, as the
+                         * auth_control_file file will be shared across all
+                         * the plug-ins.
+                         *
+                         * Since this is considered a critical configuration
+                         * error, we bail out and exit the OpenVPN process.
+                         */
+                        error = true;
+                        msg(M_FATAL,
+                            "Exiting due to multiple authentication plug-ins "
+                            "performing deferred authentication. Only one "
+                            "authentication plug-in doing deferred auth is "
+                            "allowed.  Ignoring the result and stopping now, "
+                            "the current authentication result is not to be "
+                            "trusted.");
+                        break;
+                    }
+                    deferred_auth_done = true;
                     break;
 
                 default:
@@ -844,7 +871,7 @@ plugin_call_ssl(const struct plugin_list *pl,
         {
             return OPENVPN_PLUGIN_FUNC_ERROR;
         }
-        else if (deferred)
+        else if (deferred_auth_done)
         {
             return OPENVPN_PLUGIN_FUNC_DEFERRED;
         }
-- 
2.27.0


