From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 26 Jul 2022 10:33:13 +0200
Message-Id: <20220726083313.14067-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] systemd: remove generated service files on
 clean
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

Found this when trying to build the Debian package
twice in a row. Which failed since then there were
additional files.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 distro/systemd/Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/distro/systemd/Makefile.am b/distro/systemd/Makefile.am
index 322bd535..d35c137d 100644
--- a/distro/systemd/Makefile.am
+++ b/distro/systemd/Makefile.am
@@ -21,6 +21,7 @@ if ENABLE_SYSTEMD
 systemdunit_DATA = \
 	openvpn-client@...1685... \
 	openvpn-server@...1685...
+CLEANFILES = $(systemdunit_DATA)
 tmpfiles_DATA = \
 	tmpfiles-openvpn.conf
 dist_doc_DATA = \
-- 
2.34.1


