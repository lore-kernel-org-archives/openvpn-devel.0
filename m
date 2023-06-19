From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 19 Jun 2023 15:29:34 +0200
Message-Id: <20230619132934.76085-5-frank@...2641...>
In-Reply-To: <20230619132934.76085-1-frank@...2641...>
References: <20230614102115.138724-1-frank@...2641...>
 <20230619132934.76085-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/4] dist: Include all documentation in
 distribution
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

No need to deprive tar ball users of this information.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 Makefile.am             |  5 ++++-
 doc/Makefile.am         |  9 ++++++++-
 doc/doxygen/Makefile.am | 21 ++++++++++++++++++++-
 3 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 297c3399..27da974d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -62,8 +62,11 @@ dist_doc_DATA = \
 dist_noinst_DATA = \
 	.gitignore \
 	.gitattributes \
+	CONTRIBUTING.rst \
 	PORTS \
-	README.mbedtls \
+	README.dco.md \
+	README.ec \
+	README.wolfssl \
 	openvpn.sln
 
 dist_noinst_HEADERS = \
diff --git a/doc/Makefile.am b/doc/Makefile.am
index bb9c935d..d8ffe2e0 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -54,12 +54,19 @@ openvpn_examples_sections = \
 	man-sections/examples.rst
 
 dist_noinst_DATA = \
-	README.plugins interactive-service-notes.rst \
+	android.txt \
+	interactive-service-notes.rst \
+	keying-material-exporter.txt \
 	openvpn.8.rst \
 	openvpn-examples.5.rst \
+	README.man \
+	README.plugins \
+	tls-crypt-v2.txt \
 	$(openvpn_sections) \
 	$(openvpn_examples_sections)
 
+EXTRA_DIST = tests
+
 # dependencies
 openvpn.8 openvpn.8.html: $(openvpn_sections)
 openvpn-examples.5 openvpn-examples.5.html: $(openvpn_examples_sections)
diff --git a/doc/doxygen/Makefile.am b/doc/doxygen/Makefile.am
index 82d909dd..ec1045eb 100644
--- a/doc/doxygen/Makefile.am
+++ b/doc/doxygen/Makefile.am
@@ -13,8 +13,27 @@ MAINTAINERCLEANFILES = \
 
 DISTCLEANFILES = openvpn.doxyfile
 
+DOXYGEN_EXTRA_FILES = \
+	doc_compression.h \
+	doc_control_processor.h \
+	doc_control_tls.h \
+	doc_data_control.h \
+	doc_data_crypto.h \
+	doc_eventloop.h \
+	doc_external_multiplexer.h \
+	doc_fragmentation.h \
+	doc_internal_multiplexer.h \
+	doc_key_generation.h \
+	doc_mainpage.h \
+	doc_memory_management.h \
+	doc_protocol_overview.h \
+	doc_reliable.h \
+	doc_tunnel_state.h
+
+EXTRA_DIST = $(DOXYGEN_EXTRA_FILES)
+
 .PHONY: doxygen
-doxygen: openvpn.doxyfile
+doxygen: openvpn.doxyfile $(DOXYGEN_EXTRA_FILES)
 	doxygen openvpn.doxyfile
 
 clean-local:
-- 
2.34.1


