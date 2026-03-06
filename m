From: Gert Doering <gert@...1296...>
Date: Fri,  6 Mar 2026 17:33:31 +0100
Message-ID: <20260306163337.2756-1-gert@...1296...>
In-Reply-To: <gerrit.1770735307000.I3eb4581980f532cb2960b37a6fa43a7baee4b603@...2715...>
References: <gerrit.1770735307000.I3eb4581980f532cb2960b37a6fa43a7baee4b603@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Fix various sign-compare warnings due to
 write return value
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

From: Frank Lichtenheld <frank@...2641...>

write takes size_t as count (unsigned int on
Windows) and returns ssize_t (int on Windows).
But we often want to compare the return value
to the count.

Generally we can just rely on the fact that
sizeof(ssize_t) == sizeof(size_t) and use that
for all values. (Until we want to introduce
-Wsign-conversion that is...)

Change-Id: I3eb4581980f532cb2960b37a6fa43a7baee4b603
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1513
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1513
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index c589248..c3f54ed 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -327,11 +327,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /*
  * Record IP/port of client in filesystem, so that server receiving
  * the proxy can determine true client origin.
@@ -357,7 +352,8 @@
         int fd = platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR | S_IRGRP);
         if (fd != -1)
         {
-            if (write(fd, f, strlen(f)) != strlen(f))
+            ssize_t write_len = strlen(f);
+            if (write(fd, f, write_len) != write_len)
             {
                 msg(M_WARN, "PORT SHARE: writing to journal file (%s) failed", jfn);
             }
@@ -373,10 +369,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Cleanup function, on proxy process exit.
  */
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 4d42863..c7d375b 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -206,11 +206,6 @@
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 #define STATUS_PRINTF_MAXLEN 512
 
 void
@@ -240,7 +235,7 @@
         if (so->fd >= 0 && !so->errors)
         {
             strcat(buf, "\n");
-            size_t len = strlen(buf);
+            ssize_t len = strlen(buf);
             if (len > 0)
             {
                 if (write(so->fd, buf, (unsigned int)len) != len)
@@ -258,10 +253,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 bool
 status_read(struct status_output *so, struct buffer *buf)
 {
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 0f3346f..3b7bcc2 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -184,15 +184,10 @@
     return -1;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static ssize_t
 send_string(int fd, const char *string)
 {
-    const size_t len = strlen(string) + 1;
+    const ssize_t len = strlen(string) + 1;
     const ssize_t size = write(fd, string, len);
     if (size == len)
     {
@@ -204,10 +199,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #ifdef DO_DAEMONIZE
 
 /*

