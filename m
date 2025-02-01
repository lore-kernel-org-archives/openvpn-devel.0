From: Gert Doering <gert@...1296...>
Date: Sat,  1 Feb 2025 13:20:06 +0100
Message-ID: <20250201122006.32098-1-gert@...1296...>
In-Reply-To: <gerrit.1736433762000.I81cbecd19018290d85c6c77fba7769f040d66233@...2715...>
References: <gerrit.1736433762000.I81cbecd19018290d85c6c77fba7769f040d66233@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Improve error reporting from AF_UNIX
 tun/tap support
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

From: Arne Schwabe <arne@...1227...>

When having a non-existent lwipovpn binary or similar problems, the
error reporting would often only report read error that were harder to
identify the real problem.  Add the openvpn_waitpid_check method
that checks for error conditions and reports a better message in cases
of problems.

Change-Id: I81cbecd19018290d85c6c77fba7769f040d66233
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/855
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index d757823..192c8e6 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -106,6 +106,47 @@
     return (const char *)out.data;
 }
 
+#ifndef WIN32
+bool
+openvpn_waitpid_check(pid_t pid, const char *msg_prefix, int msglevel)
+{
+    if (pid == 0)
+    {
+        return false;
+    }
+    int status;
+    pid_t pidret = waitpid(pid, &status, WNOHANG);
+    if (pidret != pid)
+    {
+        return true;
+    }
+
+    if (WIFEXITED(status))
+    {
+        int exitcode = WEXITSTATUS(status);
+
+        if (exitcode == OPENVPN_EXECVE_FAILURE)
+        {
+            msg(msglevel, "%scould not execute external program (exit code 127)",
+                msg_prefix);
+        }
+        else
+        {
+            msg(msglevel, "%sexternal program exited with error status: %d",
+                msg_prefix, exitcode);
+        }
+
+    }
+    else if (WIFSIGNALED(status))
+    {
+        msg(msglevel, "%sexternal program received signal %d",
+            msg_prefix, WTERMSIG(status));
+    }
+
+    return false;
+}
+#endif /* ifndef WIN32 */
+
 bool
 openvpn_execve_allowed(const unsigned int flags)
 {
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index c92edbc..b0b51c3 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -59,6 +59,26 @@
 int openvpn_execve_check(const struct argv *a, const struct env_set *es,
                          const unsigned int flags, const char *error_message);
 
+
+#ifndef WIN32
+/** Checks if a running process is still running. This is mainly useful
+ * for processes started with \c S_NOWAITPID
+ *
+ * This function is currently not implemented for Windows as the helper
+ * macros used by this function are not available.
+ *
+ * @param pid               pid of the process to be checked
+ * @param msg_prefix     prefixed of the message that be printed
+ * @param msglevel          msglevel of the messages to be printed
+ * @return                  true if the process is still running, false if
+ *                          an error condition occurred
+ */
+bool
+openvpn_waitpid_check(pid_t pid, const char *msg_prefix,
+                      int msglevel);
+
+#endif
+
 /**
  * Will run a script and return the exit code of the script if between
  * 0 and 255, -1 otherwise
diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index 6b6c159..c626993 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -47,9 +47,12 @@
 #include <signal.h>
 #include <stdlib.h>
 
+
+
 static void
 tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, struct env_set *env)
 {
+    const char *msgprefix = "ERROR: failure executing process for tun:";
     struct argv argv = argv_new();
 
     /* since we know that dev-node starts with unix: we can just skip that
@@ -58,10 +61,12 @@
 
     argv_printf(&argv, "%s", program);
 
-    argv_msg(M_INFO, &argv);
     tt->afunix.childprocess = openvpn_execve_check(&argv, env, S_NOWAITPID,
-                                                   "ERROR: failure executing "
-                                                   "process for tun");
+                                                   msgprefix);
+    if (!openvpn_waitpid_check(tt->afunix.childprocess, msgprefix, M_WARN))
+    {
+        tt->afunix.childprocess = 0;
+    }
     argv_free(&argv);
 }
 
@@ -138,20 +143,27 @@
 ssize_t
 write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)
 {
-    int ret;
-    pid_t pidret = waitpid(tt->afunix.childprocess, &ret, WNOHANG);
-    if (pidret == tt->afunix.childprocess)
+    const char *msg = "ERROR: failure during write to AF_UNIX socket: ";
+    if (!openvpn_waitpid_check(tt->afunix.childprocess, msg, M_WARN))
     {
-        msg(M_INFO, "Child process PID %d for afunix dead? Return code: %d",
-            tt->afunix.childprocess, ret);
+        tt->afunix.childprocess = 0;
         return -ENXIO;
     }
+
     return write(tt->fd, buf, len);
 }
 
 ssize_t
 read_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)
 {
+    const char *msg = "ERROR: failure during read from AF_UNIX socket: ";
+    if (!openvpn_waitpid_check(tt->afunix.childprocess, msg, M_WARN))
+    {
+        tt->afunix.childprocess = 0;
+    }
+    /* do an actual read on the file descriptor even in the error case since
+     * we otherwise loop on this on this from select and spam the console
+     * with error messages */
     return read(tt->fd, buf, len);
 }
 #else  /* ifndef WIN32 */

