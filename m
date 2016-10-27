From: David Sommerseth <davids@...515...>
Date: Thu, 27 Oct 2016 18:49:41 +0200
Message-Id: <1477586981-5047-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] Remove last rest of INSTALL-win32.txt
	references
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

Commit 04341beb1d8e0fad3425bfec5f281fe431895cd6 removed the
INSTALL-win32.txt file.  But there were crucial parts left in
Makefile.am which broke building OpenVPN.  In addition, removed
other references in INSTALL and README to the same file to be
complete.

Signed-off-by: David Sommerseth <davids@...515...>
---
 INSTALL     | 4 ----
 Makefile.am | 6 ------
 README      | 3 ---
 3 files changed, 13 deletions(-)

diff --git a/INSTALL b/INSTALL
index f0965c7..4c6d21f 100644
--- a/INSTALL
+++ b/INSTALL
@@ -12,10 +12,6 @@ QUICK START:
   Unix:
     ./configure && make && make-install
 
-  Cross-compile for Windows on Unix
-
-    See INSTALL-win32.txt
-
 *************************************************************************
 
 To download OpenVPN, go to:
diff --git a/Makefile.am b/Makefile.am
index 364785c..8e9581b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -74,12 +74,6 @@ dist_noinst_DATA = \
 	msvc-dev.bat \
 	msvc-build.bat
 
-if WIN32
-dist_doc_DATA += INSTALL-win32.txt
-else
-dist_noinst_DATA += INSTALL-win32.txt
-endif
-
 dist_noinst_HEADERS = \
 	config-msvc.h \
 	config-msvc-version.h.in
diff --git a/README b/README
index ee76951..103a75a 100644
--- a/README
+++ b/README
@@ -39,9 +39,6 @@ For a description of OpenVPN's underlying protocol,
 
 Other Files & Directories:
 
-* INSTALL-win32.txt -- installation instructions
-  for Windows
-
 * configure.ac -- script to rebuild our configure
   script and makefile.
 
-- 
1.8.3.1


