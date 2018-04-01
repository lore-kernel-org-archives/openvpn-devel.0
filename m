From: Christian Hesse <list@...1798...>
Date: Sun,  1 Apr 2018 21:13:08 +0200
Message-Id: <20180401191309.32211-3-list@...1798...>
In-Reply-To: <20180401191309.32211-1-list@...1798...>
References: <20180401191309.32211-1-list@...1798...>
Subject: [Openvpn-devel] [RFC 2/3] systemd: do not downgrade UID/GID
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
To: OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>

From: Christian Hesse <mail@...1798...>

Now that systemd starts the process with dedicated user we do no longer
want to downgrade privileges. Also remove CAP_SETGID and CAP_SETUID
from granted privileges.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 distro/systemd/openvpn-client@...2221... | 2 +-
 distro/systemd/openvpn-server@...2221... | 2 +-
 src/openvpn/init.c                        | 8 ++++++++
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/distro/systemd/openvpn-client@...2221... b/distro/systemd/openvpn-client@...2221...
index a103d751..ee7957a6 100644
--- a/distro/systemd/openvpn-client@...2221...
+++ b/distro/systemd/openvpn-client@...2221...
@@ -13,7 +13,7 @@ User=openvpn
 Group=openvpn
 WorkingDirectory=/etc/openvpn/client
 ExecStart=@sbindir@/openvpn --suppress-timestamps --nobind --config %i.conf
-AmbientCapabilities=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
+AmbientCapabilities=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SYS_CHROOT CAP_DAC_OVERRIDE
 LimitNPROC=10
 DeviceAllow=/dev/null rw
 DeviceAllow=/dev/net/tun rw
diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/openvpn-server@...2221...
index 7275e86a..03d28a2e 100644
--- a/distro/systemd/openvpn-server@...2221...
+++ b/distro/systemd/openvpn-server@...2221...
@@ -13,7 +13,7 @@ User=openvpn
 Group=openvpn
 WorkingDirectory=/etc/openvpn/server
 ExecStart=@sbindir@/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
-AmbientCapabilities=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
+AmbientCapabilities=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SYS_CHROOT CAP_DAC_OVERRIDE
 LimitNPROC=10
 DeviceAllow=/dev/null rw
 DeviceAllow=/dev/net/tun rw
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 36c1a4c4..0fc60d62 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1151,6 +1151,14 @@ do_uid_gid_chroot(struct context *c, bool no_delay)
         /* set user and/or group if we want to setuid/setgid */
         if (c0->uid_gid_specified)
         {
+#ifdef ENABLE_SYSTEMD
+            if (sd_notify(0, "READY=0") > 0 && getuid() != 0)
+            {
+                msg(M_INFO, "NOTE: Running from systemd with non-root uid, skipping downgrade");
+                return;
+            }
+#endif
+
             if (no_delay)
             {
                 platform_group_set(&c0->platform_state_group);

