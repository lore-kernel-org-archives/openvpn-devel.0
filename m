From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 19 Sep 2023 17:56:35 +0200
Message-Id: <20230919155635.708557-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] CMake: various small non-functional
 improvements
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

These are based on review comments for the 2.6 backport.
But since they apply to the original master implementation
as well, I address them in this separate patch.

- Add documentation to contrib/cmake/*.py
- Fix grammar in README.cmake.md
- Update a TODO in CMakeLists.txt to better reflect
  the status quo
- Fix indentation in unit_tests' Makefile.am

Change-Id: I4e16767ee221e1aefdd18d13b3411c27d8dd844a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/342
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Acked-by: lstipakov <lstipakov@...277...>

Manual changes:
 - Fixed Lev's name in Acked-by line.
        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 7dae665..da5f883 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -291,7 +291,7 @@
 
 configure_file(config.h.cmake.in config.h)
 configure_file(include/openvpn-plugin.h.in openvpn-plugin.h)
-# TODO remove later when msvc-config.h is removed and we can always include config.h
+# TODO we should remove the need for this, and always include config.h
 add_definitions(-DHAVE_CONFIG_H)
 
 include_directories(${CMAKE_CURRENT_BINARY_DIR})
diff --git a/README.cmake.md b/README.cmake.md
index 599d8dc..d181b64 100644
--- a/README.cmake.md
+++ b/README.cmake.md
@@ -24,7 +24,7 @@
 -----------
 
 The following tools are expected to be present on the system, you
-can them install with a package manager of your choice (e.g.
+can install them with a package manager of your choice (e.g.
 chocolatey, winget) or manually:
 
 * CMake
diff --git a/contrib/cmake/git-version.py b/contrib/cmake/git-version.py
index c2b4452..4f78ac4 100644
--- a/contrib/cmake/git-version.py
+++ b/contrib/cmake/git-version.py
@@ -22,6 +22,14 @@
 #  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #
 
+# Usage: ./git-version.py [directory]
+# Find a good textual representation of the git commit currently checked out.
+# Make that representation available as CONFIGURE_GIT_REVISION in
+# <directory>/config-version.h.
+# It will prefer a tag name if it is checked out exactly, otherwise will use
+# the branch name. 'none' if no branch is checked out (detached HEAD).
+# This is used to enhance the output of openvpn --version with Git information.
+
 import os
 import sys
 import subprocess
diff --git a/contrib/cmake/parse-version.m4.py b/contrib/cmake/parse-version.m4.py
index d5ff2bd..3dfb31f 100644
--- a/contrib/cmake/parse-version.m4.py
+++ b/contrib/cmake/parse-version.m4.py
@@ -22,6 +22,12 @@
 #  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #
 
+# Usage: ./parse-version.m4.py m4file [directory]
+# Read <m4file>, extract all lines looking like M4 define(), and translate
+# them into CMake style set(). Those are then written out to file
+# <directory>/version.cmake.
+# Intended to be used on top-level version.m4 file.
+
 import os
 import re
 import sys
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 6b56f84..ef45b11 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -110,7 +110,7 @@
 	-Wl,--wrap=parse_line \
 	-Wl,--wrap=rand_bytes
 tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c mock_msg.h \
-    mock_win32_execve.c \
+	mock_win32_execve.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \

