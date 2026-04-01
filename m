From: =?UTF-8?q?Christian=20Sch=C3=BCrmann?= <spike@...1385...>
Date: Wed,  1 Apr 2026 16:19:21 +0200
Message-ID: <20260401141921.1073929-1-spike@...1385...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Update patch file so it applies on
 release/2.7 and master without fuzz
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

Since openvpn-server@...2221... changed recently and the default fuzz level
for RPM's patch macro is 0, patch file can no longer be applied.
This should fix the recently failing builds on copr.fedoraproject.org

Signed-off-by: Christian Schürmann <spike@...1385...>
---
 ...hange-the-default-cipher-to-AES-256-GCM-for-server-.patch | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/0001-Change-the-default-cipher-to-AES-256-GCM-for-server-.patch b/0001-Change-the-default-cipher-to-AES-256-GCM-for-server-.patch
index a281989..2c6ab5b 100644
--- a/0001-Change-the-default-cipher-to-AES-256-GCM-for-server-.patch
+++ b/0001-Change-the-default-cipher-to-AES-256-GCM-for-server-.patch
@@ -17,7 +17,6 @@ cipher is no longer available by default in OpenSSL 3.0.  It can be enabled
 via the legacy provider in OpenSSL 3.0, but BF-CBC is deprecated and should
 not be used any more.  OpenVPN 2.4 and newer will always negotiate a stronger
 cipher by default and older OpenVPN releases are no longer supported upstream.
-
 ---
  distro/systemd/openvpn-server@...2221... | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)
@@ -26,12 +25,12 @@ diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/openvpn-
 index 6e8e7d9..6acbc8e 100644
 --- a/distro/systemd/openvpn-server@...2221...
 +++ b/distro/systemd/openvpn-server@...2221...
-@@ -10,7 +10,7 @@
+@@ -10,7 +10,7 @@ Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
  Type=notify
  PrivateTmp=true
  WorkingDirectory=/etc/openvpn/server
 -ExecStart=@sbindir@/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --config %i.conf
 +ExecStart=@sbindir@/openvpn --status %t/openvpn-server/status-%i.log --status-version 2 --suppress-timestamps --cipher AES-256-GCM --data-ciphers AES-256-GCM:AES-128-GCM:AES-256-CBC:AES-128-CBC --config %i.conf
  CapabilityBoundingSet=CAP_IPC_LOCK CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW CAP_SETGID CAP_SETUID CAP_SETPCAP CAP_SYS_CHROOT CAP_DAC_OVERRIDE CAP_SYS_NICE CAP_AUDIT_WRITE
- LimitNPROC=10
+ TasksMax=20
  DeviceAllow=/dev/null rw
-- 
2.53.0


