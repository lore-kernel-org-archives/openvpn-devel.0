From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  8 Mar 2024 15:03:46 +0100
Message-Id: <20240308140346.4058419-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Update documentation references in systemd
 unit files
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
Cc: Christoph Schug <com+github@...2792...>

From: Christoph Schug <com+github@...2792...>

The systemd unit files for both client and server were referencing
outdated documentation as they were hard-coded to the OpenVPN 2.4.x
release branch.

Change-Id: Iee289aa5df9ee0e9a03c0dc562e45dd39836e794
Signed-off-by: Christoph Schug <com+github@...2792...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---
 distro/systemd/Makefile.am                | 5 ++++-
 distro/systemd/openvpn-client@...2221... | 2 +-
 distro/systemd/openvpn-server@...2221... | 2 +-
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
index 7e8f4753..d1c903f2 100644
--- a/distro/systemd/Makefile.am
+++ b/distro/systemd/Makefile.am
@@ -9,7 +9,10 @@
 #
 
 %.service: %.service.in Makefile
-	$(AM_V_GEN)sed -e 's|\@sbindir\@|$(sbindir)|' \
+	$(AM_V_GEN)sed \
+		-e 's|\@OPENVPN_VERSION_MAJOR\@|$(OPENVPN_VERSION_MAJOR)|g' \
+		-e 's|\@OPENVPN_VERSION_MINOR\@|$(OPENVPN_VERSION_MINOR)|g' \
+		-e 's|\@sbindir\@|$(sbindir)|g' \
 		$< > $@.tmp && mv $@.tmp $@
 
 EXTRA_DIST = \
diff --git a/distro/systemd/openvpn-client@...2221... b/distro/systemd/openvpn-client@...2221...
index 159fb4dc..15c82fad 100644
--- a/distro/systemd/openvpn-client@...2221...
+++ b/distro/systemd/openvpn-client@...2221...
@@ -3,7 +3,7 @@ Description=OpenVPN tunnel for %I
 After=syslog.target network-online.target
 Wants=network-online.target
 Documentation=man:openvpn(8)
-Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage
+Documentation=https://openvpn.net/community-resources/reference-manual-for-openvpn-@...2793...@-@...2740...@/
 Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 
 [Service]
diff --git a/distro/systemd/openvpn-server@...2221... b/distro/systemd/openvpn-server@...2221...
index 6e8e7d94..b26d976b 100644
--- a/distro/systemd/openvpn-server@...2221...
+++ b/distro/systemd/openvpn-server@...2221...
@@ -3,7 +3,7 @@ Description=OpenVPN service for %I
 After=syslog.target network-online.target
 Wants=network-online.target
 Documentation=man:openvpn(8)
-Documentation=https://community.openvpn.net/openvpn/wiki/Openvpn24ManPage
+Documentation=https://openvpn.net/community-resources/reference-manual-for-openvpn-@...2793...@-@...2740...@/
 Documentation=https://community.openvpn.net/openvpn/wiki/HOWTO
 
 [Service]
-- 
2.34.1


