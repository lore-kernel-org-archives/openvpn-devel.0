From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:12:00 +0200
Message-Id: <1330546342-17794-31-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] =?utf-8?q?=5BPATCH_30/52=5D_build=3A_add_libtool_?=
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 .gitignore                               |    6 ++++
 Makefile.am                              |    5 +++-
 build/Makefile.am                        |   15 +++++++++++
 build/ltrc.inc                           |   23 ++++++++++++++++
 configure.ac                             |   20 ++++++++++++++-
 src/openvpn/Makefile.am                  |    6 ++++
 src/openvpn/openvpn_win32_resources.rc   |   41 ++++++++++++++++++++++++++++++
 src/openvpnserv/Makefile.am              |    5 +++-
 src/openvpnserv/openvpnserv_resources.rc |   41 ++++++++++++++++++++++++++++++
 version.m4                               |    1 +
 10 files changed, 160 insertions(+), 3 deletions(-)
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
index 850074b..ebc2252 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -34,6 +34,9 @@ MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in \
 	$(srcdir)/config.h.in $(srcdir)/config.h.in~ $(srcdir)/configure \
 	$(srcdir)/install-sh $(srcdir)/ltmain.sh $(srcdir)/missing \
+	$(srcdir)/m4/libtool.m4 $(srcdir)/m4/lt~obsolete.m4 \
+	$(srcdir)/m4/ltoptions.m4 $(srcdir)/m4/ltsugar.m4 \
+	$(srcdir)/m4/ltversion.m4 \
 	$(srcdir)/depcomp $(srcdir)/aclocal.m4 \
 	$(srcdir)/config.guess $(srcdir)/config.sub
 
@@ -41,7 +44,7 @@ EXTRA_DIST = \
 	contrib \
 	debug
 
-SUBDIRS = distro include src sample doc tests
+SUBDIRS = build distro include src sample doc tests
 
 dist_doc_DATA = \
 	COPYRIGHT.GPL \
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
index fe0fbab..6b5cf71 100644
--- a/configure.ac
+++ b/configure.ac
@@ -29,6 +29,8 @@ AC_PREREQ(2.59)
 m4_include(version.m4)
 AC_INIT([PRODUCT_NAME], [PRODUCT_VERSION], [PRODUCT_BUGREPORT], [PRODUCT_TARNAME])
 m4_include(compat.m4)
+AC_DEFINE([OPENVPN_VERSION_RESOURCE], [PRODUCT_VERSION_RESOURCE], [Version in windows resource format])
+
 AC_CONFIG_AUX_DIR([.])
 AM_CONFIG_HEADER([config.h])
 AC_CONFIG_SRCDIR([src/openvpn/syshead.h])
@@ -352,7 +354,6 @@ case "$host" in
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["W"], [Target prefix])
 		CPPFLAGS="${CPPFLAGS} -DWIN32_LEAN_AND_MEAN -DWINVER=0x0501"
 		WIN32=yes
-		LIBS="${LIBS} -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lshell32"
 		;;
 	*-*-dragonfly*)
 		AC_DEFINE([TARGET_DRAGONFLY], [1], [Are we running on DragonFlyBSD?])
@@ -369,6 +370,22 @@ AC_PROG_INSTALL
 AC_PROG_LN_S
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
@@ -930,6 +947,7 @@ AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
 
 AC_CONFIG_FILES([
 	Makefile
+	build/Makefile
 	distro/Makefile
 	distro/rpm/Makefile
 	distro/rpm/openvpn.spec
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 4a6b497..a509bba 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -9,6 +9,8 @@
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
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
index 7ce3375..58005c0 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -9,6 +9,8 @@
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
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
index 29ec047..2bd1401 100644
--- a/version.m4
+++ b/version.m4
@@ -3,6 +3,7 @@ define([PRODUCT_NAME], [OpenVPN])
 define([PRODUCT_TARNAME], [openvpn])
 define([PRODUCT_VERSION], [2.3_alpha1])
 define([PRODUCT_BUGREPORT], [openvpn-users@lists.sourceforge.net])
+define([PRODUCT_VERSION_RESOURCE], [2,3,0,0])
 dnl define the TAP version
 define([PRODUCT_TAP_WIN_COMPONENT_ID], [tap0901])
 define([PRODUCT_TAP_WIN_MIN_MAJOR], [9])
-- 
1.7.3.4


