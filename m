From: selva.nair@...277...
Date: Sat, 16 Feb 2019 20:55:41 -0500
Message-Id: <1550368541-10402-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Better error message when script fails due
 to script-security setting
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

From: Selva Nair <selva.nair@...277...>

- Add a new return value (-2) for openvpn_execve() when external
program execution is not allowed due to a low script-security
setting.

- Add a corresponding error message

Errors and warnings in such cases will now display as
"WARNING: failed running command (<cmd>) :" followed by

"disallowed by script-security setting" on all platforms

instead of the current

"external program did not execute -- returned error code -1"
on Windows and
"external program fork failed" on other platforms.

The error is FATAL for some scripts and that behaviour is unchanged.

This helps the Windows GUI to detect when a connection failure
results from a safer script-security setting enforced by the GUI,
and show a relevant message.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
This is being presented as a better alternative for patch 684.
A separate patch may be needed for 2.4 -- will do if this is found
acceptable.

 src/openvpn/run_command.c | 25 +++++++++++++++++++++----
 src/openvpn/win32.c       | 10 +++++++---
 2 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index 2d75a3e..7df7576 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -65,12 +65,23 @@ system_error_message(int stat, struct gc_arena *gc)
     {
         buf_printf(&out, "external program did not execute -- ");
     }
-    buf_printf(&out, "returned error code %d", stat);
+    if (stat == -2)
+    {
+        buf_printf(&out, "disallowed by script-security setting");
+    }
+    else
+    {
+        buf_printf(&out, "returned error code %d", stat);
+    }
 #else  /* ifdef _WIN32 */
     if (stat == -1)
     {
         buf_printf(&out, "external program fork failed");
     }
+    else if (stat == -2)
+    {
+        buf_printf(&out, "disallowed by script-security setting");
+    }
     else if (!WIFEXITED(stat))
     {
         buf_printf(&out, "external program did not exit normally");
@@ -114,6 +125,8 @@ openvpn_execve_allowed(const unsigned int flags)
  * Run execve() inside a fork().  Designed to replicate the semantics of system() but
  * in a safer way that doesn't require the invocation of a shell or the risks
  * associated with formatting and parsing a command line.
+ * Returns the exit status of child, -2 if openvpn_execve_allowed() returned false,
+ * or -1 on other errors.
  */
 int
 openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags)
@@ -150,10 +163,14 @@ openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned in
                 }
             }
         }
-        else if (!warn_shown && (script_security() < SSEC_SCRIPTS))
+        else
         {
-            msg(M_WARN, SCRIPT_SECURITY_WARNING);
-            warn_shown = true;
+            ret = -2;
+            if (!warn_shown && (script_security() < SSEC_SCRIPTS))
+            {
+                msg(M_WARN, SCRIPT_SECURITY_WARNING);
+                warn_shown = true;
+            }
         }
 #else  /* if defined(ENABLE_FEATURE_EXECVE) */
         msg(M_WARN, "openvpn_execve: execve function not available");
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 463ac07..4eb7c40 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1137,10 +1137,14 @@ openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned in
             free(env);
             gc_free(&gc);
         }
-        else if (!exec_warn && (script_security() < SSEC_SCRIPTS))
+        else
         {
-            msg(M_WARN, SCRIPT_SECURITY_WARNING);
-            exec_warn = true;
+            ret = -2;
+            if (!exec_warn && (script_security() < SSEC_SCRIPTS))
+            {
+                msg(M_WARN, SCRIPT_SECURITY_WARNING);
+                exec_warn = true;
+            }
         }
     }
     else
-- 
2.1.4


