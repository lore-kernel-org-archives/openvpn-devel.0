From: Christian Hesse <list@...1798...>
Date: Thu,  1 Dec 2016 16:41:19 +0100
Message-Id: <20161201154119.28958-2-list@...1798...>
In-Reply-To: <20161201154119.28958-1-list@...1798...>
References: <20161201154119.28958-1-list@...1798...>
Subject: [Openvpn-devel] [PATCH v2 2/2] Refuse to daemonize when running
	from systemd
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

We start with systemd Type=notify, so refuse to daemonize. This does not
affect starting openvpn from script or command line.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 distro/systemd/openvpn-client@...1685... | 1 -
 distro/systemd/openvpn-server@...1685... | 1 -
 src/openvpn/init.c                     | 7 +++++++
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/distro/systemd/openvpn-client@...1685... b/distro/systemd/openvpn-client@...1685...
index f64a239..5618af3 100644
--- a/distro/systemd/openvpn-client@...1685...
+++ b/distro/systemd/openvpn-client@...1685...
@@ -12,7 +12,6 @@ PrivateTmp=true
 RuntimeDirectory=openvpn-client
 RuntimeDirectoryMode=0710
 WorkingDirectory=/etc/openvpn/client
-ExecStartPre=/bin/sh -c 'grep -q -E ^daemon %i.conf || exit 0 && /usr/bin/echo "OpenVPN configuration cannot contain --daemon when being managed by systemd" ; exit 1'
 ExecStart=/usr/sbin/openvpn --suppress-timestamps --nobind --config %i.conf
 CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
 LimitNPROC=10
diff --git a/distro/systemd/openvpn-server@...1685... b/distro/systemd/openvpn-server@...1685...
index 890e6a9..b9b4dba 100644
--- a/distro/systemd/openvpn-server@...1685...
+++ b/distro/systemd/openvpn-server@...1685...
@@ -12,7 +12,6 @@ PrivateTmp=true
 RuntimeDirectory=openvpn-server
 RuntimeDirectoryMode=0710
 WorkingDirectory=/etc/openvpn/server
-ExecStartPre=/bin/sh -c 'grep -q -E ^daemon %i.conf || exit 0 && /usr/bin/echo "OpenVPN configuration cannot contain --daemon when being managed by systemd" ; exit 1'
 ExecStart=/usr/sbin/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
 CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
 LimitNPROC=10
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index aea3590..63a5fee 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -926,6 +926,13 @@ bool
 possibly_become_daemon (const struct options *options)
 {
   bool ret = false;
+
+#ifdef ENABLE_SYSTEMD
+  /* return without forking if we are running from systemd */
+  if (sd_notify(0, "READY=0") > 0)
+    return ret;
+#endif
+
   if (options->daemon)
     {
       ASSERT (!options->inetd);
-- 
2.10.2


