From: David Sommerseth <openvpn@...2080...>
Date: Wed, 30 Jun 2021 20:51:34 +0200
Message-Id: <20210630185134.144826-1-openvpn@...2080...>
In-Reply-To: <20210630180643.139673-1-openvpn@...2080...>
References: <20210630180643.139673-1-openvpn@...2080...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] doc: Use generic rules for man/html
 generation
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
Cc: David Sommerseth <davids@...515...>

From: David Sommerseth <davids@...515...>

Prior to this patch, the Makefile.am needs to be modified multiple
places to add a new man or HTML page to be generated.  Since it is not
too often we modify this, it is easy to miss these finer details.

This changes the man and HTML generator rules to be more generic and use
variables as many places as possible.  Also moved all the lines which
should not need to be changed as much towards the bottom-half of the
file.

Signed-off-by: David Sommerseth <davids@...515...>

---

v2 - Fix incorrect HTML generation, use rst2html
---
 doc/Makefile.am | 52 ++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/doc/Makefile.am b/doc/Makefile.am
index f5b08f9e..b9d0df7c 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -9,11 +9,17 @@
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
-MAINTAINERCLEANFILES = \
-	$(srcdir)/Makefile.in
-
 SUBDIRS = doxygen
 
+#
+# List of man and HTML pages we build when rst2man/rst2html is available
+#
+# NOTE: Remember to add source .rst files to $(dist_noinst_DATA) below
+#       This could be automated with GNU Make, but we need BSD Make support
+#
+build_man_pages = openvpn.8 openvpn-examples.5
+build_html_pages = openvpn.8.html openvpn-examples.5.html
+
 dist_doc_DATA = \
 	management-notes.txt gui-notes.txt
 
@@ -47,49 +53,41 @@ dist_noinst_DATA = \
 	man-sections/vpn-network-options.rst \
 	man-sections/windows-options.rst
 
-openvpn.8 :
-if HAVE_PYDOCUTILS
-	$(RST2MAN) $(srcdir)/$@.rst > $@
-else
-	@echo "Missing python-docutils - skipping man page generation"
-endif
 
-openvpn-examples.5 :
-if HAVE_PYDOCUTILS
-	$(RST2MAN) $(srcdir)/$@.rst > $@
-else
-	@echo "Missing python-docutils - skipping man page generation"
-endif
+######  GENERIC  RULES  ##########
+
+SUFFIXES = .8.rst .8 .8.html .5.rst .5 .5.html
 
+MAINTAINERCLEANFILES = \
+	$(srcdir)/Makefile.in
 
-openvpn.8.html:
+.8.rst.8 .5.rst.5 :
 if HAVE_PYDOCUTILS
-	$(RST2HTML) $(srcdir)/openvpn.8.rst > $@
+	$(RST2MAN) $< > $@
 else
-	@echo "Missing python-docutils - skipping man/html page generation"
+	@echo "Missing python-docutils - skipping man page generation ($@)"
 endif
 
-openvpn-examples.5.html:
+.8.rst.8.html .5.rst.5.html :
 if HAVE_PYDOCUTILS
-	$(RST2HTML) $(srcdir)/openvpn-examples.5.rst > $@
+	$(RST2HTML) $< > $@
 else
-	@echo "Missing python-docutils - skipping man/html page generation"
+	@echo "Missing python-docutils - skipping html page generation ($@)"
 endif
 
 
 if HAVE_PYDOCUTILS
-dist_noinst_DATA += openvpn.8 openvpn-examples.5
-dist_html_DATA = openvpn.8.html openvpn-examples.5.html
+dist_noinst_DATA += $(build_man_pages)
+dist_html_DATA = $(build_html_pages)
 
 # Failsafe - do not delete these files unless we can recreate them
-CLEANFILES = \
-	 openvpn.8 openvpn.8.html openvpn-examples.5 openvpn-examples.5.html
+CLEANFILES = $(build_man_pages) $(build_html_pages)
 
 endif
 
 if WIN32
 else
-dist_man_MANS = openvpn.8
+dist_man_MANS = $(build_man_pages)
 endif
 
-dist-hook : openvpn.8 openvpn.8.html openvpn-examples.5 openvpn-examples.5.html
+dist-hook : $(build_man_pages) $(build_html_pages)
-- 
2.27.0


