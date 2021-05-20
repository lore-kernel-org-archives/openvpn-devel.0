From: Arne Schwabe <arne@...1227...>
Date: Thu, 20 May 2021 17:09:31 +0200
Message-Id: <20210520150932.2565217-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 1/2] Move examples into
 openvpn-examples(5) man page
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .gitignore                 |  2 ++
 doc/Makefile.am            | 25 +++++++++++++++++++++----
 doc/openvpn-examples.5.rst | 17 +++++++++++++++++
 doc/openvpn.8.rst          |  2 +-
 4 files changed, 41 insertions(+), 5 deletions(-)
 create mode 100644 doc/openvpn-examples.5.rst

diff --git a/.gitignore b/.gitignore
index 25d06235b..178076ede 100644
--- a/.gitignore
+++ b/.gitignore
@@ -49,6 +49,8 @@ version.sh
 msvc-env-local.bat
 config-msvc-local.h
 config-msvc-version.h
+doc/openvpn-examples.5
+doc/openvpn-examples.5.html
 doc/openvpn.8
 doc/openvpn.8.html
 /doc/doxygen/html/
diff --git a/doc/Makefile.am b/doc/Makefile.am
index e411f5f9d..1dbbddf58 100644
--- a/doc/Makefile.am
+++ b/doc/Makefile.am
@@ -20,6 +20,7 @@ dist_doc_DATA = \
 dist_noinst_DATA = \
 	README.plugins interactive-service-notes.rst \
 	openvpn.8.rst \
+    openvpn-examples.5.rst \
 	man-sections/advanced-options.rst \
 	man-sections/client-options.rst \
 	man-sections/connection-profiles.rst \
@@ -52,6 +53,14 @@ else
 	@echo "Missing python-docutils - skipping man page generation"
 endif
 
+openvpn-examples.5 :
+if HAVE_PYDOCUTILS
+	$(RST2MAN) $(srcdir)/$@.rst > $@
+else
+	@echo "Missing python-docutils - skipping man page generation"
+endif
+
+
 openvpn.8.html:
 if HAVE_PYDOCUTILS
 	$(RST2HTML) $(srcdir)/openvpn.8.rst > $@
@@ -59,13 +68,21 @@ else
 	@echo "Missing python-docutils - skipping man/html page generation"
 endif
 
+openvpn-examples.5.html:
+if HAVE_PYDOCUTILS
+	$(RST2HTML) $(srcdir)/openvpn-examples.5.rst > $@
+else
+	@echo "Missing python-docutils - skipping man/html page generation"
+endif
+
+
 if HAVE_PYDOCUTILS
-dist_noinst_DATA += openvpn.8
-dist_html_DATA = openvpn.8.html
+dist_noinst_DATA += openvpn.8 openvpn-examples.5
+dist_html_DATA = openvpn.8.html openvpn-examples.5.html
 
 # Failsafe - do not delete these files unless we can recreate them
 CLEANFILES = \
-	 openvpn.8 openvpn.8.html
+	 openvpn.8 openvpn.8.html openvpn-examples.5 openvpn-examples.5.html
 
 endif
 
@@ -74,4 +91,4 @@ else
 dist_man_MANS = openvpn.8
 endif
 
-dist-hook : openvpn.8 openvpn.8.html
+dist-hook : openvpn.8 openvpn.8.html openvpn-examples.5 openvpn-examples.5.html
diff --git a/doc/openvpn-examples.5.rst b/doc/openvpn-examples.5.rst
new file mode 100644
index 000000000..988b6027b
--- /dev/null
+++ b/doc/openvpn-examples.5.rst
@@ -0,0 +1,17 @@
+===============================
+ openvpn examples
+===============================
+-------------------------
+ Secure IP tunnel daemon
+-------------------------
+
+:Manual section: 5
+:Manual group: Configuration files
+
+
+INTRODUCTION
+============
+
+This man page gives a few simple examples to create OpenVPN setups and configuration files.
+
+.. include:: man-sections/examples.rst
diff --git a/doc/openvpn.8.rst b/doc/openvpn.8.rst
index db81274fa..995467478 100644
--- a/doc/openvpn.8.rst
+++ b/doc/openvpn.8.rst
@@ -86,7 +86,6 @@ placed in a configuration file.
 .. include:: man-sections/connection-profiles.rst
 .. include:: man-sections/inline-files.rst
 .. include:: man-sections/signals.rst
-.. include:: man-sections/examples.rst
 
 
 FAQ
@@ -134,6 +133,7 @@ Report all bugs to the OpenVPN team info@...515...
 SEE ALSO
 ========
 
+``openvpn-examples``\(5),
 ``dhcpcd``\(8),
 ``ifconfig``\(8),
 ``openssl``\(1),
-- 
2.31.1


