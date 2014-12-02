From: Mike Gilbert <floppym@...594...>
Date: Tue,  2 Dec 2014 14:34:22 -0500
Message-Id: <1417548862-24990-1-git-send-email-floppym@...594...>
Subject: [Openvpn-devel] [PATCH] Include systemd units in the source tarball
	(make dist)
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

---
 distro/Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/distro/Makefile.am b/distro/Makefile.am
index 2dd6a6e..bd65b79 100644
--- a/distro/Makefile.am
+++ b/distro/Makefile.am
@@ -13,3 +13,5 @@ MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
 SUBDIRS = rpm
+
+EXTRA_DIST = systemd/openvpn-client@...1685... systemd/openvpn-server@...1685...
-- 
2.1.3


