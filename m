From: Frank Lichtenheld <frank@...2641...>
Date: Thu,  9 Dec 2021 18:11:36 +0100
Message-Id: <20211209171138.8589-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] doc/Makefile: rebuild rst docs if input
 files change
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

For now the dependencies are statically defined, which
should be fine and is still a much better solution than
to have no dependencies.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/Makefile.am | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/doc/Makefile.am b/doc/Makefile.am
index 1a67f7b5..a31b8097 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -23,16 +23,11 @@ build_html_pages = openvpn.8.html openvpn-examples.5.html
 dist_doc_DATA = \
 	management-notes.txt gui-notes.txt
 
-dist_noinst_DATA = \
-	README.plugins interactive-service-notes.rst \
-	openvpn.8.rst \
-	openvpn-examples.5.rst \
+openvpn_sections = \
 	man-sections/advanced-options.rst \
 	man-sections/client-options.rst \
 	man-sections/connection-profiles.rst \
 	man-sections/encryption-options.rst \
-	man-sections/example-fingerprint.rst \
-	man-sections/examples.rst \
 	man-sections/generic-options.rst \
 	man-sections/inline-files.rst \
 	man-sections/link-options.rst \
@@ -53,6 +48,20 @@ dist_noinst_DATA = \
 	man-sections/vpn-network-options.rst \
 	man-sections/windows-options.rst
 
+openvpn_examples_sections = \
+	man-sections/example-fingerprint.rst \
+	man-sections/examples.rst
+
+dist_noinst_DATA = \
+	README.plugins interactive-service-notes.rst \
+	openvpn.8.rst \
+	openvpn-examples.5.rst \
+	$(openvpn_sections) \
+	$(openvpn_examples_sections)
+
+# dependencies
+openvpn.8 openvpn.8.html: $(openvpn_sections)
+openvpn-examples.5 openvpn-examples.5.html: $(openvpn_examples_sections)
 
 ######  GENERIC  RULES  ##########
 
-- 
2.30.2


