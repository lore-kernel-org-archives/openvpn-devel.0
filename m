From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 10 Feb 2022 11:44:45 +0100
Message-Id: <20220210104445.16767-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2.5] doc/Makefile: rebuild rst docs if input
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

Also delete empty example-fingerprint.rst.

(cherry picked from commit 529cc6a52fc45a1a67abb5c91819ba4fb2f631e3)
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/Makefile.am                          | 19 ++++++++++++++-----
 doc/man-sections/example-fingerprint.rst |  0
 2 files changed, 14 insertions(+), 5 deletions(-)
 delete mode 100644 doc/man-sections/example-fingerprint.rst

diff --git a/doc/Makefile.am b/doc/Makefile.am
index db73cef5..cc9a661c 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -23,15 +23,11 @@ build_html_pages = openvpn.8.html openvpn-examples.5.html
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
-	man-sections/examples.rst \
 	man-sections/generic-options.rst \
 	man-sections/inline-files.rst \
 	man-sections/link-options.rst \
@@ -52,6 +48,19 @@ dist_noinst_DATA = \
 	man-sections/vpn-network-options.rst \
 	man-sections/windows-options.rst
 
+openvpn_examples_sections = \
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
 
diff --git a/doc/man-sections/example-fingerprint.rst b/doc/man-sections/example-fingerprint.rst
deleted file mode 100644
index e69de29b..00000000
-- 
2.30.2


