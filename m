From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 21 Feb 2012 03:22:30 +0200
Message-Id: <1329787361-26096-25-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] =?utf-8?q?=5BPATCH_24/35=5D_build=3A_add_libtool_?=
	=?utf-8?q?+_windows_resources_for_executables?=
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
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 .gitignore                               |    6 ++++
 Makefile.am                              |    2 +-
 build/Makefile.am                        |   15 +++++++++++
 build/ltrc.inc                           |   23 ++++++++++++++++
 configure.ac                             |   20 ++++++++++++++-
 src/openvpn/Makefile.am                  |    6 ++++
 src/openvpn/openvpn_win32_resources.rc   |   41 ++++++++++++++++++++++++++++++
 src/openvpnserv/Makefile.am              |    5 +++-
 src/openvpnserv/openvpnserv_resources.rc |   41 ++++++++++++++++++++++++++++++
 version.m4                               |    1 +
 10 files changed, 157 insertions(+), 3 deletions(-)
 create mode 100644 build/Makefile.am
 create mode 100644 build/ltrc.inc
 create mode 100644 src/openvpn/openvpn_win32_resources.rc
 create mode 100644 src/openvpnserv/openvpnserv_resources.rc

diff --git a/.gitignore b/.gitignore
index 46cd4c8..156b2c2 100644
--- a/.gitignore
+++ b/.gitignore
@@ -26,6 +26,12 @@ depcomp
 stamp-h1
 install-sh
 missing
+ltmain.sh
+m4/libtool.m4
+m4/ltoptions.m4
+m4/ltsugar.m4
+m4/ltversion.m4
+m4/lt~obsolete.m4
 
 doc/openvpn.8.html
 distro/rpm/openvpn.spec
diff --git a/Makefile.am b/Makefile.am
index e08df3e..66b0c92 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -41,7 +41,7 @@ EXTRA_DIST = \
 	contrib \
 	debug
 
-SUBDIRS = distro include src sample doc tests
+SUBDIRS = build distro include src sample doc tests
 
 dist_noinst_DATA = \
 	.gitignore \
diff --git a/build/Makefile.am b/build/Makefile.am
new file mode 100644
index 0000000..a993b20
--- /dev/null
+++ b/build/Makefile.am
@@ -0,0 +1,15 @@
+#
+#  OpenVPN -- An application to securely tunnel IP networks
+#             over a single UDP port, with support for SSL/TLS-based
+#             session authentication and key exchange,
+#             packet encryption, packet authentication, and
+#             packet compression.
+#
+#  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+#
+
+MAINTAINERCLEANFILES = \
+	$(srcdir)/Makefile.in
+
+EXTRA_DIST = \
+	ltrc.inc
diff --git a/build/ltrc.inc b/build/ltrc.inc
new file mode 100644
index 0000000..701f200
--- /dev/null
+++ b/build/ltrc.inc
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
diff --git a/configure.ac b/configure.ac
index 74f06ac..5afcacc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -28,6 +28,8 @@ AC_PREREQ(2.60)
 
 m4_include(version.m4)
 AC_INIT([PRODUCT_NAME], [PRODUCT_VERSION], [PRODUCT_BUGREPORT], [PRODUCT_TARNAME])
+AC_DEFINE([OPENVPN_VERSION_RESOURCE], [PRODUCT_VERSION_RESOURCE], [Version in windows resource format])
+
 AC_CONFIG_AUX_DIR([.])
 AM_CONFIG_HEADER([config.h])
 AC_CONFIG_SRCDIR([src/openvpn/syshead.h])
@@ -339,7 +341,6 @@ case "$host" in
 		AC_DEFINE([TARGET_WIN32], [1], [Are we running WIN32?])
 		CPPFLAGS="${CPPFLAGS} -DWIN32_LEAN_AND_MEAN -D_POSIX -DWINVER=0x0501"
 		WIN32=yes
-		LIBS="${LIBS} -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lshell32"
 		;;
 	*-*-dragonfly*)
 		AC_DEFINE([TARGET_DRAGONFLY], [1], [Are we running on DragonFlyBSD?])
@@ -354,6 +355,22 @@ AC_PROG_MKDIR_P
 AC_PROG_SED
 AC_PROG_MAKE_SET
 
+#
+# Libtool
+#
+ifdef(
+	[LT_INIT],
+	[
+		LT_INIT([win32-dll])
+		LT_LANG([Windows Resource])
+	],
+	[
+		AC_LIBTOOL_WIN32_DLL
+		AC_LIBTOOL_RC
+		AC_PROG_LIBTOOL
+	]
+)
+
 if test "${WIN32}" = "yes"; then
 	AC_ARG_VAR([MAN2HTML], [man2html utility])
 	AC_CHECK_PROGS([MAN2HTML], [man2html])
@@ -908,6 +925,7 @@ AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
 
 AC_CONFIG_FILES([
 	Makefile
+	build/Makefile
 	distro/Makefile
 	distro/rpm/Makefile
 	distro/rpm/openvpn.spec
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 545c054..deb3f84 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -9,6 +9,8 @@
 #  Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
+include $(top_srcdir)/build/ltrc.inc
+
 MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
@@ -93,3 +95,7 @@ openvpn_SOURCES = \
 	tun.c tun.h \
 	win32.h win32.c \
 	cryptoapi.h cryptoapi.c
+if WIN32
+openvpn_SOURCES += openvpn_win32_resources.rc
+openvpn_LDADD = -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lshell32
+endif
diff --git a/src/openvpn/openvpn_win32_resources.rc b/src/openvpn/openvpn_win32_resources.rc
new file mode 100644
index 0000000..e91bfa1
--- /dev/null
+++ b/src/openvpn/openvpn_win32_resources.rc
@@ -0,0 +1,41 @@
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#else
+#include <config-msc-version.h>
+#endif
+#include <winresrc.h>
+
+LANGUAGE LANG_NEUTRAL, SUBLANG_NEUTRAL
+
+VS_VERSION_INFO VERSIONINFO
+ FILEVERSION OPENVPN_VERSION_RESOURCE
+ PRODUCTVERSION OPENVPN_VERSION_RESOURCE
+ FILEFLAGSMASK 0x3fL
+#ifdef _DEBUG
+ FILEFLAGS 0x1L
+#else
+ FILEFLAGS 0x0L
+#endif
+ FILEOS 0x40004L
+ FILETYPE 0x2L
+ FILESUBTYPE 0x0L
+BEGIN
+    BLOCK "StringFileInfo"
+    BEGIN
+        BLOCK "040904b0"
+        BEGIN
+            VALUE "CompanyName", "OpenVPN.net"
+            VALUE "FileDescription", "OpenVPN"
+            VALUE "FileVersion", PACKAGE_VERSION ".0"
+            VALUE "InternalName", "OpenVPN"
+            VALUE "LegalCopyright", "Copyright � OpenVPN Project" 
+            VALUE "OriginalFilename", "openvpn.exe"
+            VALUE "ProductName", "OpenVPN"
+            VALUE "ProductVersion", PACKAGE_VERSION ".0"
+        END
+    END
+    BLOCK "VarFileInfo"
+    BEGIN
+        VALUE "Translation", 0x409, 1200
+    END
+END
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index ba828e8..f5a59fb 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -9,6 +9,8 @@
 #  Copyright (C) 2008-2012 Alon Bar-Lev <alon.barlev@...277...>
 #
 
+include $(top_srcdir)/build/ltrc.inc
+
 MAINTAINERCLEANFILES = $(srcdir)/Makefile.in
 
 if WIN32
@@ -17,4 +19,5 @@ endif
 
 openvpnserv_SOURCES = \
 	openvpnserv.c \
-	service.h service.c
+	service.h service.c \
+	openvpnserv_resources.rc
diff --git a/src/openvpnserv/openvpnserv_resources.rc b/src/openvpnserv/openvpnserv_resources.rc
new file mode 100644
index 0000000..b87f4a3
--- /dev/null
+++ b/src/openvpnserv/openvpnserv_resources.rc
@@ -0,0 +1,41 @@
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#else
+#include <config-msc-version.h>
+#endif
+#include <winresrc.h>
+
+LANGUAGE LANG_NEUTRAL, SUBLANG_NEUTRAL
+
+VS_VERSION_INFO VERSIONINFO
+ FILEVERSION OPENVPN_VERSION_RESOURCE
+ PRODUCTVERSION OPENVPN_VERSION_RESOURCE
+ FILEFLAGSMASK 0x3fL
+#ifdef _DEBUG
+ FILEFLAGS 0x1L
+#else
+ FILEFLAGS 0x0L
+#endif
+ FILEOS 0x40004L
+ FILETYPE 0x2L
+ FILESUBTYPE 0x0L
+BEGIN
+    BLOCK "StringFileInfo"
+    BEGIN
+        BLOCK "040904b0"
+        BEGIN
+            VALUE "CompanyName", "OpenVPN.net"
+            VALUE "FileDescription", "OpenVPN Service"
+            VALUE "FileVersion", PACKAGE_VERSION ".0"
+            VALUE "InternalName", "OpenVPN"
+            VALUE "LegalCopyright", "Copyright � OpenVPN Project" 
+            VALUE "OriginalFilename", "openvpnserv.exe"
+            VALUE "ProductName", "OpenVPN"
+            VALUE "ProductVersion", PACKAGE_VERSION ".0"
+        END
+    END
+    BLOCK "VarFileInfo"
+    BEGIN
+        VALUE "Translation", 0x409, 1200
+    END
+END
diff --git a/version.m4 b/version.m4
index 42bab30..c0ae24b 100644
--- a/version.m4
+++ b/version.m4
@@ -3,6 +3,7 @@ define([PRODUCT_NAME], [OpenVPN])
 define([PRODUCT_TARNAME], [openvpn])
 define([PRODUCT_VERSION], [2.x-master])
 define([PRODUCT_BUGREPORT], [openvpn-users@lists.sourceforge.net])
+define([PRODUCT_VERSION_RESOURCE], [2,2,0,0])
 dnl define the TAP version
 define([PRODUCT_TAP_WIN_COMPONENT_ID], [tap0901])
 define([PRODUCT_TAP_WIN_MIN_MAJOR], [9])
-- 
1.7.3.4


