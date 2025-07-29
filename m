From: Terrance <sourceforge@...2900...>
Date: Tue, 29 Jul 2025 19:00:05 +0100
Message-ID: <20250729180014.11550-2-sourceforge@...2900...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Update systemd service name param to match
 command
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

From: Terrance <git@...2900...>

The service name displays `%I` which invokes systemd's path mangling
(notably, converting `-` to `/`), suggesting you need to provide an
encoded parameter (via e.g. `systemd-escape`), but the start command
itself uses `%i` which doesn't do the conversion.

This updates the service name to match the start command.
---
Additional discussion: https://github.com/OpenVPN/openvpn/pull/802

 distro/systemd/openvpn-client@...2221... | 2 +-
 distro/systemd/openvpn-server@...2221... | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/distro/systemd/openvpn-client@...2221... b/distro/systemd/open=
vpn-client@...2221...
index ae62e8c7..c32bb333 100644
--- a/distro/systemd/openvpn-client@...2221...
+++ b/distro/systemd/openvpn-client@...2221...
@@ -1,4 +1,4 @@
 [Unit]
-Description=3DOpenVPN tunnel for %I
+Description=3DOpenVPN tunnel for %i
 After=3Dnetwork-online.target
 Wants=3Dnetwork-online.target
diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/open=
vpn-server@...2221...
index 5123e072..547f5f54 100644
--- a/distro/systemd/openvpn-server@...2221...
+++ b/distro/systemd/openvpn-server@...2221...
@@ -1,4 +1,4 @@
 [Unit]
-Description=3DOpenVPN service for %I
+Description=3DOpenVPN service for %i
 After=3Dnetwork-online.target
 Wants=3Dnetwork-online.target
--
2.50.1

