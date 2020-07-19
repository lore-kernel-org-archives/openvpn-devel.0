From: David Sommerseth <davids@...515...>
Date: Sun, 19 Jul 2020 13:48:53 +0200
Message-Id: <20200719114853.24168-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] doc/man: Do not install man *.rst files
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

When the man page got split up into several .rst files, these files got
listed into dist_doc_DATA=.  This variable will both distribute (package
in the source tarball) and install these files into /usr/share/doc.
This was not intended, and it duplicates the content and makes the doc
dir quite messy.

By moving these files to dist_noinst_DATA= instead, these files are
still distributed but not installed via 'make install'.

Signed-off-by: David Sommerseth <davids@...515...>
---
 doc/Makefile.am | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/doc/Makefile.am b/doc/Makefile.am
index add92198..340dd553 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -15,7 +15,11 @@ MAINTAINERCLEANFILES = \
 SUBDIRS = doxygen
 
 dist_doc_DATA = \
-	management-notes.txt openvpn.8.rst \
+	management-notes.txt
+
+dist_noinst_DATA = \
+	README.plugins interactive-service-notes.rst \
+	openvpn.8.rst \
 	man-sections/advanced-options.rst \
 	man-sections/client-options.rst \
 	man-sections/connection-profiles.rst \
@@ -41,9 +45,6 @@ dist_doc_DATA = \
 	man-sections/vpn-network-options.rst \
 	man-sections/windows-options.rst
 
-dist_noinst_DATA = \
-	README.plugins interactive-service-notes.rst
-
 openvpn.8 :
 if HAVE_PYDOCUTILS
 	$(RST2MAN) $(srcdir)/$@.rst > $@
-- 
2.26.0


