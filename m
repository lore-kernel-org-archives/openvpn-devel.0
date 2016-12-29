From: Christian Hesse <list@...1798...>
Date: Thu, 29 Dec 2016 19:57:26 +0100
Message-Id: <20161229185727.17020-1-list@...1798...>
In-Reply-To: <20161228185700.GJ78624@...1296...>
References: <20161228185700.GJ78624@...1296...>
Subject: [Openvpn-devel] [PATCH 1/2] move systemd specific code to platform.c
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
To: OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>

From: Christian Hesse <mail@...1798...>

We have voices that do not want to "litter ENABLE_SYSTEMD all over the
code". So move the systemd specific bits to platform_notify() in
platform.c.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 src/openvpn/init.c     | 23 +++++------------------
 src/openvpn/platform.c | 13 +++++++++++++
 src/openvpn/platform.h |  2 ++
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9a3e29d..46df8ca 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -30,10 +30,6 @@
 
 #include "syshead.h"
 
-#ifdef ENABLE_SYSTEMD
-#include <systemd/sd-daemon.h>
-#endif
-
 #include "win32.h"
 #include "init.h"
 #include "sig.h"
@@ -983,13 +979,11 @@ possibly_become_daemon(const struct options *options)
 {
     bool ret = false;
 
-#ifdef ENABLE_SYSTEMD
     /* return without forking if we are running from systemd */
-    if (sd_notify(0, "READY=0") > 0)
+    if (platform_notify("READY=0", "STATUS=Possibly become daemon") > 0)
     {
         return ret;
     }
-#endif
 
     if (options->daemon)
     {
@@ -1026,7 +1020,6 @@ do_uid_gid_chroot(struct context *c, bool no_delay)
         {
             if (no_delay)
             {
-#ifdef ENABLE_SYSTEMD
                 /* If OpenVPN is started by systemd, the OpenVPN process needs
                  * to provide a preliminary status report to systemd.  This is
                  * needed as $NOTIFY_SOCKET will not be available inside the
@@ -1040,10 +1033,8 @@ do_uid_gid_chroot(struct context *c, bool no_delay)
                  * have a sane way to know if OpenVPN will chroot or not and to
                  * which subdirectory it will chroot into.
                  */
-                sd_notifyf(0, "READY=1\n"
-                           "STATUS=Entering chroot, most of the init completed successfully\n"
-                           "MAINPID=%lu", (unsigned long) getpid());
-#endif
+                platform_notify("READY=1",
+                                "STATUS=Entering chroot, most of the init completed successfully");
                 platform_chroot(c->options.chroot_dir);
             }
             else if (c->first_time)
@@ -1384,17 +1375,13 @@ initialization_sequence_completed(struct context *c, const unsigned int flags)
         show_adapters(M_INFO|M_NOPREFIX);
         msg(M_INFO, "%s With Errors ( see http://openvpn.net/faq.html#dhcpclientserv )", message);
 #else
-#ifdef ENABLE_SYSTEMD
-        sd_notifyf(0, "STATUS=Failed to start up: %s With Errors\nERRNO=1", message);
-#endif /* HAVE_SYSTEMD_SD_DAEMON_H */
+        platform_notify("READY=0", "STATUS=Failed to start up");
         msg(M_INFO, "%s With Errors", message);
 #endif
     }
     else
     {
-#ifdef ENABLE_SYSTEMD
-        sd_notifyf(0, "READY=1\nSTATUS=%s\nMAINPID=%lu", message, (unsigned long) getpid());
-#endif
+        platform_notify("READY=1", "STATUS=Initialization Sequence Completed");
         msg(M_INFO, "%s", message);
     }
 
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 952d633..55a25b0 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -30,6 +30,10 @@
 
 #include "syshead.h"
 
+#ifdef ENABLE_SYSTEMD
+#include <systemd/sd-daemon.h>
+#endif
+
 #include "buffer.h"
 #include "error.h"
 #include "win32.h"
@@ -336,3 +340,12 @@ platform_stat(const char *path, platform_stat_t *buf)
 #endif
 }
 
+int
+platform_notify(const char *status, const char *message)
+{
+#ifdef ENABLE_SYSTEMD
+    return sd_notifyf(0, "%s\n%s", status, message);
+#endif
+
+    return 0;
+}
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index 62396a9..94c92e4 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -144,4 +144,6 @@ typedef struct stat platform_stat_t;
 #endif
 int platform_stat(const char *path, platform_stat_t *buf);
 
+int platform_notify(const char *status, const char *message);
+
 #endif /* ifndef PLATFORM_H */
-- 
2.11.0


