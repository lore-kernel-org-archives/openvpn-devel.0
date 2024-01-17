From: Gert Doering <gert@...1296...>
Date: Wed, 17 Jan 2024 14:49:29 +0100
Message-ID: <20240117134929.5317-1-gert@...1296...>
In-Reply-To: <gerrit.1705463396000.Ib1a5c788269949d8de95d1da2cb0c32a65bf13f2@...2715...>
References: <gerrit.1705463396000.Ib1a5c788269949d8de95d1da2cb0c32a65bf13f2@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] cmake: symlink whole build dir not just
 .json file
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

From: Heiko Hund <heiko@...2662...>

It turned out that symlinking compile_commands.json from the top level
source dir has some issues:
  * file is not created on Windows and symlinking may cause an error
  * some IDEs create their own json and error out b/c a file exists

Since clangd also looks for the json in build/ directories by default,
we now symlink the whole build directory instead, not just the json file.

This approach requires for the existing build/ dir in the repo to
vanish. Luckily it only contains one automake include file, which is
moved to the top level source dir.

Lastly, make this an opt-in feature, so that the default configuration
of the buildsystem never causes a build failure because of this.

Change-Id: Ib1a5c788269949d8de95d1da2cb0c32a65bf13f2
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/501
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/.gitignore b/.gitignore
index 4153a3e..92d65bf 100644
--- a/.gitignore
+++ b/.gitignore
@@ -40,7 +40,7 @@
 m4/ltversion.m4
 m4/lt~obsolete.m4
 
-compile_commands.json
+build
 doc/openvpn-examples.5
 doc/openvpn-examples.5.html
 doc/openvpn.8
diff --git a/CMakeLists.txt b/CMakeLists.txt
index bc46c27..4e5c8fa 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -43,9 +43,17 @@
 set(PLUGIN_DIR /usr/local/lib/openvpn/plugins CACHE FILEPATH "Location of the plugin directory")
 
 # Create machine readable compile commands
-set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
-file(CREATE_LINK ${CMAKE_CURRENT_BINARY_DIR}/compile_commands.json
-                 ${CMAKE_CURRENT_SOURCE_DIR}/compile_commands.json SYMBOLIC)
+option(ENABLE_COMPILE_COMMANDS "Generate compile_commands.json and a symlink for clangd to find it" OFF)
+if (ENABLE_COMPILE_COMMANDS)
+    if (EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/build AND NOT IS_SYMLINK ${CMAKE_CURRENT_SOURCE_DIR}/build)
+        message(FATAL_ERROR "The top level source directory contains a 'build' file or directory. Please remove or rename it. CMake creates a symlink with that name during build.")
+    endif()
+    set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
+    add_custom_target(
+        symlink-build-dir ALL
+        ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/build
+        )
+endif ()
 
 # AddressSanitize - use CXX=clang++ CC=clang cmake -DCMAKE_BUILD_TYPE=asan to build with ASAN
 set(CMAKE_C_FLAGS_ASAN
diff --git a/Makefile.am b/Makefile.am
index 2305ab4..792588a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -42,6 +42,7 @@
 EXTRA_DIST = \
 	contrib \
 	debug \
+	ltrc.inc \
 	CMakeLists.txt \
 	CMakePresets.json \
 	config.h.cmake.in
@@ -53,7 +54,7 @@
 	config-version.h
 endif
 
-SUBDIRS = build distro include src sample doc tests
+SUBDIRS = distro include src sample doc tests
 
 dist_doc_DATA = \
 	README \
diff --git a/README.cmake.md b/README.cmake.md
index d181b64..4f41c70 100644
--- a/README.cmake.md
+++ b/README.cmake.md
@@ -135,3 +135,17 @@
 The `unix-native` CMake preset is available for these builds. This preset does
 not require VCPKG and instead assumes all build-dependencies are provided by
 the system natively.
+
+Generating compile_commands.json
+--------------------------------
+
+To have the CMake buildsystem generate compile_commands.json you can specify
+`-DENABLE_COMPILE_COMMANDS=ON` on the command line or enable the CMake option
+another way you like. For supported generators the file will then be created.
+Additionally, the buildsystem will create a symlink `build/` to the --preset
+build directory that contains the generated JSON file. This is done so that
+clangd is able to find it.
+
+Enabling this option may cause an error on Windows, since creating a symlink
+is a privileged operation there. If you enable Developer Mode for the system,
+symlinks can be created by regular users.
diff --git a/build/Makefile.am b/build/Makefile.am
deleted file mode 100644
index e7cc4d8..0000000
--- a/build/Makefile.am
+++ /dev/null
@@ -1,15 +0,0 @@
-#
-#  OpenVPN -- An application to securely tunnel IP networks
-#             over a single UDP port, with support for SSL/TLS-based
-#             session authentication and key exchange,
-#             packet encryption, packet authentication, and
-#             packet compression.
-#
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
-#
-
-MAINTAINERCLEANFILES = \
-	$(srcdir)/Makefile.in
-
-EXTRA_DIST = \
-	ltrc.inc
diff --git a/build/ltrc.inc b/build/ltrc.inc
deleted file mode 100644
index 701f200..0000000
--- a/build/ltrc.inc
+++ /dev/null
@@ -1,23 +0,0 @@
-#
-#  OpenVPN -- An application to securely tunnel IP networks
-#             over a single UDP port, with support for SSL/TLS-based
-#             session authentication and key exchange,
-#             packet encryption, packet authentication, and
-#             packet compression.
-#
-#  Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
-#
-# Required to build Windows resource file
-
-RCCOMPILE = $(RC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) \
-	$(AM_CPPFLAGS) $(CPPFLAGS)
-LTRCCOMPILE = $(LIBTOOL) --mode=compile --tag=RC $(RCCOMPILE)
-
-.rc.lo:
-	$(LTRCCOMPILE) -i "$<" -o "$@"
-
-.rc.o:
-	$(RCCOMPILE) -i "$<" -o "$@"
-
-.mc.rc:
-	$(WINDMC) "$<"
diff --git a/configure.ac b/configure.ac
index 2823f04..0710f71 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1515,7 +1515,6 @@
 
 AC_CONFIG_FILES([
 	Makefile
-	build/Makefile
 	distro/Makefile
 	distro/systemd/Makefile
 	doc/Makefile
diff --git a/ltrc.inc b/ltrc.inc
new file mode 100644
index 0000000..701f200
--- /dev/null
+++ b/ltrc.inc
@@ -0,0 +1,23 @@
+#
+#  OpenVPN -- An application to securely tunnel IP networks
+#             over a single UDP port, with support for SSL/TLS-based
+#             session authentication and key exchange,
+#             packet encryption, packet authentication, and
+#             packet compression.
+#
+#  Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
+#
+# Required to build Windows resource file
+
+RCCOMPILE = $(RC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) \
+	$(AM_CPPFLAGS) $(CPPFLAGS)
+LTRCCOMPILE = $(LIBTOOL) --mode=compile --tag=RC $(RCCOMPILE)
+
+.rc.lo:
+	$(LTRCCOMPILE) -i "$<" -o "$@"
+
+.rc.o:
+	$(RCCOMPILE) -i "$<" -o "$@"
+
+.mc.rc:
+	$(WINDMC) "$<"
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index b953961..1dc1dda 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -9,7 +9,7 @@
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
-include $(top_srcdir)/build/ltrc.inc
+include $(top_srcdir)/ltrc.inc
 
 MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index dc53f75..b10ce82 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -18,7 +18,7 @@
 #  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #
 
-include $(top_srcdir)/build/ltrc.inc
+include $(top_srcdir)/ltrc.inc
 
 MAINTAINERCLEANFILES = $(srcdir)/Makefile.in
 
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index d8ba4eb..0c64cce 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -9,7 +9,7 @@
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
-include $(top_srcdir)/build/ltrc.inc
+include $(top_srcdir)/ltrc.inc
 
 MAINTAINERCLEANFILES = $(srcdir)/Makefile.in
 
diff --git a/src/tapctl/Makefile.am b/src/tapctl/Makefile.am
index 69ea161..4c2958b 100644
--- a/src/tapctl/Makefile.am
+++ b/src/tapctl/Makefile.am
@@ -18,7 +18,7 @@
 #  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #
 
-include $(top_srcdir)/build/ltrc.inc
+include $(top_srcdir)/ltrc.inc
 
 MAINTAINERCLEANFILES = $(srcdir)/Makefile.in
 

