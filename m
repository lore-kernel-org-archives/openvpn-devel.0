From: Christian Hesse <list@...1798...>
Date: Tue, 29 Nov 2016 16:27:39 +0100
Message-Id: <20161129152739.11582-1-list@...1798...>
Subject: [Openvpn-devel] [PATCH 1/1] Use systemd service manager notification
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
Cc: Christian Hesse <mail@...1798...>

From: Christian Hesse <mail@...1798...>

Notify systemd service manager when our initialization sequence
completed. This helps ordering services as dependencies can rely on vpn
being available.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 distro/systemd/openvpn-client@...1685... | 1 +
 distro/systemd/openvpn-server@...1685... | 1 +
 src/openvpn/init.c                     | 6 ++++++
 src/openvpn/init.h                     | 4 ++++
 4 files changed, 12 insertions(+)

diff --git a/distro/systemd/openvpn-client@...1685... b/distro/systemd/openvpn-client@...1685...
index 18b84dd..f64a239 100644
--- a/distro/systemd/openvpn-client@...1685...
+++ b/distro/systemd/openvpn-client@...1685...
@@ -7,6 +7,7 @@ Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage
 Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 
 [Service]
+Type=notify
 PrivateTmp=true
 RuntimeDirectory=openvpn-client
 RuntimeDirectoryMode=0710
diff --git a/distro/systemd/openvpn-server@...1685... b/distro/systemd/openvpn-server@...1685...
index a2b7b52..890e6a9 100644
--- a/distro/systemd/openvpn-server@...1685...
+++ b/distro/systemd/openvpn-server@...1685...
@@ -7,6 +7,7 @@ Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage
 Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 
 [Service]
+Type=notify
 PrivateTmp=true
 RuntimeDirectory=openvpn-server
 RuntimeDirectoryMode=0710
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2ccbab2..551e579 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1251,10 +1251,16 @@ initialization_sequence_completed (struct context *c, const unsigned int flags)
       show_adapters (M_INFO|M_NOPREFIX);
       msg (M_INFO, "%s With Errors ( see http://openvpn.net/faq.html#dhcpclientserv )", message);
 #else
+#ifdef ENABLE_SYSTEMD
+      sd_notifyf(0, "STATUS=Failed to start up: %s With Errors\nERRNO=1", message);
+#endif /* HAVE_SYSTEMD_SD_DAEMON_H */
       msg (M_INFO, "%s With Errors", message);
 #endif
     }
   else
+#ifdef ENABLE_SYSTEMD
+    sd_notifyf(0, "READY=1\nSTATUS=%s\nMAINPID=%lu", message, (unsigned long) getpid());
+#endif
     msg (M_INFO, "%s", message);
 
   /* Flag that we initialized */
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 524bc64..0518b06 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -27,6 +27,10 @@
 
 #include "openvpn.h"
 
+#ifdef ENABLE_SYSTEMD
+#include <systemd/sd-daemon.h>
+#endif
+
 /*
  * Baseline maximum number of events
  * to wait for.
-- 
2.10.2


