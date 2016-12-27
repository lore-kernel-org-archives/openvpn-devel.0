From: David Sommerseth <davids@...515...>
Date: Tue, 27 Dec 2016 11:52:24 +0100
Message-Id: <1482835944-563-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] build: Ensure Changes.rst is shipped and
	installed as a doc file
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

Signed-off-by: David Sommerseth <davids@...515...>
---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index d1a72da..1197aad 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -60,6 +60,7 @@ dist_doc_DATA = \
 	README \
 	README.IPv6 \
 	README.polarssl \
+	Changes.rst \
 	COPYRIGHT.GPL \
 	COPYING
 
-- 
1.8.3.1


