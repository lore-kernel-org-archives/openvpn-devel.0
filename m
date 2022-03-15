From: David Sommerseth <openvpn@...2080...>
Date: Tue, 15 Mar 2022 16:53:43 +0100
Message-Id: <20220315155344.37787-3-openvpn@...2080...>
In-Reply-To: <20220315155344.37787-1-openvpn@...2080...>
References: <20220315155344.37787-1-openvpn@...2080...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2.4 v5 2/3] plug-ins: Disallow multiple
 deferred authentication plug-ins
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
Note: The man page snippet is copied from the generated nroff formatting from
the git master generated man page.

v3 - flip CONSTANT==var to var==CONSTANT in if() clause
v4 - Use M_FATAL instead of M_ERR
v5 - Fix missing ) in if() clause
---
 doc/openvpn.8        | 13 +++++++++++++
 src/openvpn/plugin.c | 33 ++++++++++++++++++++++++++++++---
 2 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 598d5fce..a6a5feb6 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2805,6 +2805,19 @@ function (such as tls\-verify, auth\-user\-pass\-verify, or
 client\-connect), then
 every module and script must return success (0) in order for
 the connection to be authenticated.
+
+.INDENT 7.0
+.TP
+.B \fBWARNING\fP:
+Plug\-ins may do deferred execution, meaning the plug\-in will
+return the control back to the main OpenVPN process and provide
+the plug\-in result later on via a different thread or process.
+OpenVPN does \fBNOT\fP support multiple authentication plug\-ins
+\fBwhere more than one of them\fP do deferred authentication.
+If this behaviour is detected, OpenVPN will shut down upon first
+authentication.
+.UNINDENT
+.UNINDENT
 .\"*********************************************************
 .TP
 .B \-\-keying\-material\-exporter label len
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 0ab99ab5..a019ec77 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -809,7 +809,7 @@ plugin_call_ssl(const struct plugin_list *pl,
         const int n = plugin_n(pl);
         bool success = false;
         bool error = false;
-        bool deferred = false;
+        bool deferred_auth_done = false;
 
         setenv_del(es, "script_type");
         envp = make_env_array(es, false, &gc);
@@ -834,7 +834,34 @@ plugin_call_ssl(const struct plugin_list *pl,
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
@@ -858,7 +885,7 @@ plugin_call_ssl(const struct plugin_list *pl,
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


