From: Gert Doering <gert@...1296...>
Date: Mon, 27 Jul 2015 22:46:50 +0200
Message-Id: <1438030010-953-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix build on OpenSolaris (non-gmake)
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

Was broken in commit 9de35d4, missing backslash in include/Makefile.am

Signed-off-by: Gert Doering <gert@...1296...>
---
 include/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/Makefile.am b/include/Makefile.am
index 70f20e9..c5a91b1 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -10,7 +10,7 @@
 #
 
 MAINTAINERCLEANFILES = \
-	$(srcdir)/Makefile.in
+	$(srcdir)/Makefile.in \
 	$(srcdir)/openvpn-plugin.h.in
 
 include_HEADERS = openvpn-plugin.h
-- 
2.3.6


