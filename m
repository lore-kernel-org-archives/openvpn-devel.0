From: David Sommerseth <davids@...515...>
Date: Mon, 14 Nov 2016 12:20:08 +0100
Message-Id: <1479122408-6867-1-git-send-email-davids@...515...>
In-Reply-To: <1476996158-5390-1-git-send-email-davids@...515...>
References: <1476996158-5390-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH v3] systemd: Improve the systemd unit files
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

There are several changes which allows systemd to take care of several
aspects of hardening the execution of OpenVPN.

- Let systemd take care of the process tracking directly, instead
  of doing that via PID files

- Make systemd prepare proper runtime directories for the OpenVPN
  process.

- Let systemd do the chdir() before starting OpenVPN.  This allows
  us to avoid using the --cd option when executing openvpn.

- CAP_DAC_OVERRIDE was needed when using --chroot.  Otherwise
  the root user would not be allowed to access files/directories
  not owned by root.  This will change in the future, when we
  find better ways to avoid calling chroot() in OpenVPN and
  rather let systemd prepare a more isolated namespace.

- Client configurations are now started with --nobind and
  the OpenVPN client process have lost the CAP_NET_BIND_SERVICE
  capability which allows binding to port < 1024.

- Documentation URL now points at the OpenVPN 2.4 man page URL

The majority of these changes have been proposed by Elias Probst
(eliasp) in the GitHub PR #22.

v3 - Add ExecPreStart= to check if OpenVPN configuration contains
     'daemon'. That can break the process tracking as we now use
     Type=simple (default)

v2 - Change RuntimeDirectory= to a profile specific (client, server)
     directory to avoid clashing with older distro unit files

Contribution-by: Elias Probst <mail@...2185...>
Signed-off-by: David Sommerseth <davids@...515...>
---
 distro/systemd/openvpn-client@...1685... | 12 +++++++-----
 distro/systemd/openvpn-server@...1685... | 15 +++++++++------
 2 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/distro/systemd/openvpn-client@...1685... b/distro/systemd/openvpn-client@...1685...
index 56d93a9..18b84dd 100644
--- a/distro/systemd/openvpn-client@...1685...
+++ b/distro/systemd/openvpn-client@...1685...
@@ -3,15 +3,17 @@ Description=OpenVPN tunnel for %I
 After=syslog.target network-online.target
 Wants=network-online.target
 Documentation=man:openvpn(8)
-Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn23ManPage
+Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage
 Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 
 [Service]
 PrivateTmp=true
-Type=forking
-PIDFile=/var/run/openvpn/client_%i.pid
-ExecStart=/usr/sbin/openvpn --cd /etc/openvpn/client --config %i.conf --daemon --writepid /var/run/openvpn/client_%i.pid
-CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_READ_SEARCH
+RuntimeDirectory=openvpn-client
+RuntimeDirectoryMode=0710
+WorkingDirectory=/etc/openvpn/client
+ExecStartPre=/bin/sh -c 'grep -q -E ^daemon %i.conf || exit 0 && /usr/bin/echo "OpenVPN configuration cannot contain --daemon when being managed by systemd" ; exit 1'
+ExecStart=/usr/sbin/openvpn --suppress-timestamps --nobind --config %i.conf
+CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
 LimitNPROC=10
 DeviceAllow=/dev/null rw
 DeviceAllow=/dev/net/tun rw
diff --git a/distro/systemd/openvpn-server@...1685... b/distro/systemd/openvpn-server@...1685...
index c4c9a12..a2b7b52 100644
--- a/distro/systemd/openvpn-server@...1685...
+++ b/distro/systemd/openvpn-server@...1685...
@@ -1,16 +1,19 @@
 [Unit]
 Description=OpenVPN service for %I
-After=syslog.target network.target
+After=syslog.target network-online.target
+Wants=network-online.target
 Documentation=man:openvpn(8)
-Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn23ManPage
+Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage
 Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 
 [Service]
 PrivateTmp=true
-Type=forking
-PIDFile=/var/run/openvpn/server_%i.pid
-ExecStart=/usr/sbin/openvpn --cd /etc/openvpn/server --status /var/run/openvpn/server_%i-status.log --status-version 2 --config %i.conf --daemon --writepid /var/run/openvpn/server_%i.pid
-CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_READ_SEARCH
+RuntimeDirectory=openvpn-server
+RuntimeDirectoryMode=0710
+WorkingDirectory=/etc/openvpn/server
+ExecStartPre=/bin/sh -c 'grep -q -E ^daemon %i.conf || exit 0 && /usr/bin/echo "OpenVPN configuration cannot contain --daemon when being managed by systemd" ; exit 1'
+ExecStart=/usr/sbin/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
+CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_OVERRIDE
 LimitNPROC=10
 DeviceAllow=/dev/null rw
 DeviceAllow=/dev/net/tun rw
-- 
1.8.3.1


