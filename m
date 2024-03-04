From: Frank Lichtenheld <frank@...2641...>
Date: Mon,  4 Mar 2024 17:33:13 +0100
Message-Id: <20240304163313.2326923-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/1] openvpn-[client|server].service: Remove
 syslog.target
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
Cc: Martin Rys <martin@...2790...>

From: Martin Rys <martin@...2790...>

Change-Id: If825e5b1ebc6eecc9e5398f0d8274927b53e5b83
Signed-off-by: Martin Rys <martin@...2790...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 distro/systemd/openvpn-client@...2221... | 2 +-
 distro/systemd/openvpn-server@...2221... | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/distro/systemd/openvpn-client@...2221... b/distro/systemd/openvpn-client@...2221...
index 159fb4dc..8e18629b 100644
--- a/distro/systemd/openvpn-client@...2221...
+++ b/distro/systemd/openvpn-client@...2221...
@@ -1,6 +1,6 @@
 [Unit]
 Description=OpenVPN tunnel for %I
-After=syslog.target network-online.target
+After=network-online.target
 Wants=network-online.target
 Documentation=man:openvpn(8)
 Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage
diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/openvpn-server@...2221...
index 6e8e7d94..8752440f 100644
--- a/distro/systemd/openvpn-server@...2221...
+++ b/distro/systemd/openvpn-server@...2221...
@@ -1,6 +1,6 @@
 [Unit]
 Description=OpenVPN service for %I
-After=syslog.target network-online.target
+After=network-online.target
 Wants=network-online.target
 Documentation=man:openvpn(8)
 Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage
-- 
2.34.1


