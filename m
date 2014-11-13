From: David Sommerseth <openvpn.list@...1114...>
Date: Thu, 13 Nov 2014 15:43:37 +0100
Message-Id: <1415889817-28049-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] systemd: Reworked the systemd unit file to
	handle server and client configs better
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

From: David Sommerseth <davids@...1347...>

Systemd can delay starting a service if the network isn't fully available
yet.  This feature is useful in client configurations, where OpenVPN will
not be started before the client can reach the Internet.  It is the network
service manager which tells systemd if the system is "online" or not.

For server configurations, the OpenVPN should be able to be started,
regardless if the system is "online" or not.  This is also the old
behaviour of most of the old init.d script and the last systemd unit file.

This patch splits the previous systemd unit file into to two files.  One
which is aimed at clients (openvpn-client@...1685...) and one for server
configurations (openvpn-server@...1685...).  These files will also pick
the configurations from different sub-directories.  The unit file for
openvpn-client@ will use /etc/openvpn/client and the server unit file
will use /etc/openvpn/server.  This also ensures that config files
are not started in the wrong manner.

The arguments given to the openvpn binary have also shifted order,
to ensure that some of them cannot be overridden by the config file,
such as --daemon and --writepid.  For server configurations a
--status file is also added with the status format set to 2.  This
can be overridden by the configuration file.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 distro/systemd/{openvpn@...1685... => openvpn-client@...1685...} | 7 ++++---
 distro/systemd/{openvpn@...1685... => openvpn-server@...1685...} | 6 +++---
 2 files changed, 7 insertions(+), 6 deletions(-)
 copy distro/systemd/{openvpn@...1685... => openvpn-client@...1685...} (68%)
 rename distro/systemd/{openvpn@...1685... => openvpn-server@...1685...} (65%)

diff --git a/distro/systemd/openvpn@...1685... b/distro/systemd/openvpn-client@...1685...
similarity index 68%
copy from distro/systemd/openvpn@...1685...
copy to distro/systemd/openvpn-client@...1685...
index 7cd36c3..56d93a9 100644
--- a/distro/systemd/openvpn@...1685...
+++ b/distro/systemd/openvpn-client@...1685...
@@ -1,6 +1,7 @@
 [Unit]
 Description=OpenVPN tunnel for %I
-After=syslog.target network.target
+After=syslog.target network-online.target
+Wants=network-online.target
 Documentation=man:openvpn(8)
 Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn23ManPage
 Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
@@ -8,8 +9,8 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 [Service]
 PrivateTmp=true
 Type=forking
-PIDFile=/var/run/openvpn/%i.pid
-ExecStart=/usr/sbin/openvpn --daemon --writepid /var/run/openvpn/%i.pid --cd /etc/openvpn/ --config %i.conf
+PIDFile=/var/run/openvpn/client_%i.pid
+ExecStart=/usr/sbin/openvpn --cd /etc/openvpn/client --config %i.conf --daemon --writepid /var/run/openvpn/client_%i.pid
 CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_READ_SEARCH
 LimitNPROC=10
 DeviceAllow=/dev/null rw
diff --git a/distro/systemd/openvpn@...1685... b/distro/systemd/openvpn-server@...1685...
similarity index 65%
rename from distro/systemd/openvpn@...1685...
rename to distro/systemd/openvpn-server@...1685...
index 7cd36c3..c4c9a12 100644
--- a/distro/systemd/openvpn@...1685...
+++ b/distro/systemd/openvpn-server@...1685...
@@ -1,5 +1,5 @@
 [Unit]
-Description=OpenVPN tunnel for %I
+Description=OpenVPN service for %I
 After=syslog.target network.target
 Documentation=man:openvpn(8)
 Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn23ManPage
@@ -8,8 +8,8 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 [Service]
 PrivateTmp=true
 Type=forking
-PIDFile=/var/run/openvpn/%i.pid
-ExecStart=/usr/sbin/openvpn --daemon --writepid /var/run/openvpn/%i.pid --cd /etc/openvpn/ --config %i.conf
+PIDFile=/var/run/openvpn/server_%i.pid
+ExecStart=/usr/sbin/openvpn --cd /etc/openvpn/server --status /var/run/openvpn/server_%i-status.log --status-version 2 --config %i.conf --daemon --writepid /var/run/openvpn/server_%i.pid
 CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SYS_CHROOT CAP_DAC_READ_SEARCH
 LimitNPROC=10
 DeviceAllow=/dev/null rw
-- 
1.8.3.1


