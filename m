From: Christian Hesse <list@...1798...>
Date: Sat, 10 Dec 2016 00:19:07 +0100
Message-Id: <20161209231907.16486-1-list@...1798...>
In-Reply-To: <20161209183724.5c11d987@...1799...>
References: <20161209183724.5c11d987@...1799...>
Subject: [Openvpn-devel] [PATCH 1/1] bind mount systemd notification socket
	into chroot
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
Cc: Christian Hesse <mail@...1798...>, David Sommerseth <davids@...515...>

From: Christian Hesse <mail@...1798...>

sd_notify() uses a socket to communicate with systemd. Communication
fails if the socket is not available within the chroot. So bind mount
the socket into the chroot when startet from systemd.

Unsharing namespace and mounting requires extra capability CAP_SYS_ADMIN.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 distro/systemd/openvpn-client@...1685... |  2 +-
 distro/systemd/openvpn-server@...1685... |  2 +-
 src/openvpn/init.c                     | 37 +++++++++++++++++++---------------
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/distro/systemd/openvpn-client@...1685... b/distro/systemd/openvpn-client@...1685...
index 5618af3..3ebd1da 100644
--- a/distro/systemd/openvpn-client@...1685...
+++ b/distro/systemd/openvpn-client@...1685...
@@ -13,7 +13,7 @@ RuntimeDirectory=openvpn-client
 RuntimeDirectoryMode=0710
 WorkingDirectory=/etc/openvpn/client
 ExecStart=/usr/sbin/openvpn --suppress-timestamps --nobind --config %i.conf
-CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
+CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_ADMIN CAP_SYS_CHROOT CAP_DAC_OVERRIDE
 LimitNPROC=10
 DeviceAllow=/dev/null rw
 DeviceAllow=/dev/net/tun rw
diff --git a/distro/systemd/openvpn-server@...1685... b/distro/systemd/openvpn-server@...1685...
index b9b4dba..bcf1bcf 100644
--- a/distro/systemd/openvpn-server@...1685...
+++ b/distro/systemd/openvpn-server@...1685...
@@ -13,7 +13,7 @@ RuntimeDirectory=openvpn-server
 RuntimeDirectoryMode=0710
 WorkingDirectory=/etc/openvpn/server
 ExecStart=/usr/sbin/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
-CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
+CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_ADMIN CAP_SYS_CHROOT CAP_DAC_OVERRIDE
 LimitNPROC=10
 DeviceAllow=/dev/null rw
 DeviceAllow=/dev/net/tun rw
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 26b236d..81bf9ab 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -31,6 +31,9 @@
 #include "syshead.h"
 
 #ifdef ENABLE_SYSTEMD
+#include <string.h>
+#include <sched.h>
+#include <sys/mount.h>
 #include <systemd/sd-daemon.h>
 #endif
 
@@ -969,22 +972,24 @@ do_uid_gid_chroot (struct context *c, bool no_delay)
 	  if (no_delay)
             {
 #ifdef ENABLE_SYSTEMD
-              /* If OpenVPN is started by systemd, the OpenVPN process needs
-               * to provide a preliminary status report to systemd.  This is
-               * needed as $NOTIFY_SOCKET will not be available inside the
-               * chroot, which sd_notify()/sd_notifyf() depends on.
-               *
-               * This approach is the simplest and the most non-intrusive
-               * solution right before the 2.4_rc2 release.
-               *
-               * TODO: Consider altnernative solutions - bind mount?
-               * systemd does not grok OpenVPN configuration files, thus cannot
-               * have a sane way to know if OpenVPN will chroot or not and to
-               * which subdirectory it will chroot into.
-               */
-              sd_notifyf(0, "READY=1\n"
-                "STATUS=Entering chroot, most of the init completed successfully\n"
-                "MAINPID=%lu", (unsigned long) getpid());
+              int fd;
+              char * chroot_notify = NULL;
+
+              if (sd_notify(0, "READY=0") > 0)
+                {
+                  asprintf(&chroot_notify, "%s/notify", c->options.chroot_dir);
+
+                  if (unshare(CLONE_NEWNS) != 0)
+                    msg (M_ERR, "unshare failed");
+                  if ((fd = open(chroot_notify, O_WRONLY | O_CREAT | O_TRUNC, 0644)) < 0)
+                    msg (M_ERR, "touch failed");
+                  close(fd);
+                  if (mount(getenv("NOTIFY_SOCKET"), chroot_notify, NULL, MS_BIND, NULL) != 0)
+                    msg (M_ERR, "bind mounting notification socket failed");
+
+                  setenv("NOTIFY_SOCKET", "/notify", 1);
+                  free(chroot_notify);
+                }
 #endif
               platform_chroot (c->options.chroot_dir);
             }
-- 
2.10.2


