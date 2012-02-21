From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 21 Feb 2012 03:22:28 +0200
Message-Id: <1329787361-26096-23-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 22/35] build: remove awk and non-standard
	autoconf output processing
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

Replace with simpler environment solution.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 Makefile.am       |   12 ++----------
 configure.ac      |    3 +++
 configure_h.awk   |   39 ---------------------------------------
 configure_log.awk |   33 ---------------------------------
 options.c         |    4 ----
 5 files changed, 5 insertions(+), 86 deletions(-)
 delete mode 100644 configure_h.awk
 delete mode 100644 configure_log.awk

diff --git a/Makefile.am b/Makefile.am
index c198238..d0086de 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -36,7 +36,7 @@ MAINTAINERCLEANFILES = \
 	$(srcdir)/depcomp $(srcdir)/aclocal.m4 \
 	$(srcdir)/config.guess $(srcdir)/config.sub \
 	$(srcdir)/openvpn.spec
-CLEANFILES = openvpn.8.html configure.h
+CLEANFILES = openvpn.8.html
 
 EXTRA_DIST = \
 	sample-config-files \
@@ -58,8 +58,7 @@ dist_doc_DATA = \
 
 dist_noinst_SCRIPTS = \
 	$(test_scripts) \
-	t_cltsrv-down.sh \
-	configure_h.awk configure_log.awk
+	t_cltsrv-down.sh
 
 dist_noinst_DATA = \
 	.gitignore \
@@ -149,13 +148,6 @@ openvpn_SOURCES = \
 	win32.h win32.c \
 	cryptoapi.h cryptoapi.c
 
-nodist_openvpn_SOURCES = configure.h
-options.$(OBJEXT): configure.h
-
-configure.h: Makefile
-	awk -f $(srcdir)/configure_h.awk config.h > $@
-	awk -f $(srcdir)/configure_log.awk config.log >> $@
-
 if WIN32
 dist_noinst_DATA += openvpn.8
 nodist_html_DATA = openvpn.8.html
diff --git a/configure.ac b/configure.ac
index 2dae0f3..9941ee0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -891,6 +891,9 @@ if test "${enable_strict}" = "yes"; then
 	CFLAGS="${CFLAGS} -Wall -Wno-unused-parameter -Wno-unused-function"
 fi
 
+CONFIGURE_DEFINES="`set | grep '^enable_.*=' ; set | grep '^with_.*='`"
+AC_DEFINE_UNQUOTED([CONFIGURE_DEFINES], ["`echo ${CONFIGURE_DEFINES}`"], [Configuration settings])
+
 TAP_WIN_COMPONENT_ID="PRODUCT_TAP_WIN_COMPONENT_ID"
 TAP_WIN_MIN_MAJOR="PRODUCT_TAP_WIN_MIN_MAJOR"
 TAP_WIN_MIN_MINOR="PRODUCT_TAP_WIN_MIN_MINOR"
diff --git a/configure_h.awk b/configure_h.awk
deleted file mode 100644
index 672e745..0000000
--- a/configure_h.awk
+++ /dev/null
@@ -1,39 +0,0 @@
-#
-#  OpenVPN -- An application to securely tunnel IP networks
-#             over a single UDP port, with support for SSL/TLS-based
-#             session authentication and key exchange,
-#             packet encryption, packet authentication, and
-#             packet compression.
-#
-#  Copyright (C) 2010  David Sommerseth <dazo@...384...>
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License version 2
-#  as published by the Free Software Foundation.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program (see the file COPYING included with this
-#  distribution); if not, write to the Free Software Foundation, Inc.,
-#  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-#
-#  This script will build up a line which can be included into a C program.
-#  The line will contain all interesting #define statements from f.ex. ./config.h
-#
-
-BEGIN {
-	printf ("#define CONFIGURE_DEFINES \"")
-}
-
-/^#define (ENABLE|DISABLE|DEPRECATED|USE)_/ {
-	printf (" %s", $2)
-}
-
-END {
-	printf ("\"\n")
-}
diff --git a/configure_log.awk b/configure_log.awk
deleted file mode 100644
index 099e5c4..0000000
--- a/configure_log.awk
+++ /dev/null
@@ -1,33 +0,0 @@
-#
-#  OpenVPN -- An application to securely tunnel IP networks
-#             over a single UDP port, with support for SSL/TLS-based
-#             session authentication and key exchange,
-#             packet encryption, packet authentication, and
-#             packet compression.
-#
-#  Copyright (C) 2010  David Sommerseth <dazo@...384...>
-#
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License version 2
-#  as published by the Free Software Foundation.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program (see the file COPYING included with this
-#  distribution); if not, write to the Free Software Foundation, Inc.,
-#  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
-#
-#
-#  This script will build up a line which can be included into a C program.
-#  The line will only contain the first entry of the ./configure line from
-#  ./config.log.
-#
-
-/\$ (.*)\/configure/ {
-	printf ("#define CONFIGURE_CALL \"%s\"\n", $0)
-	exit 0
-}
diff --git a/options.c b/options.c
index 4883c48..8577dac 100644
--- a/options.c
+++ b/options.c
@@ -49,7 +49,6 @@
 #include "helper.h"
 #include "manage.h"
 #include "forward.h"
-#include "configure.h"
 #include <ctype.h>
 
 #include "memdbg.h"
@@ -3403,9 +3402,6 @@ usage_version (void)
   msg (M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
   msg (M_INFO|M_NOPREFIX, "Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>");
 #ifndef ENABLE_SMALL
-#ifdef CONFIGURE_CALL
-  msg (M_INFO|M_NOPREFIX, "\n%s\n", CONFIGURE_CALL);
-#endif
 #ifdef CONFIGURE_DEFINES
   msg (M_INFO|M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
 #endif
-- 
1.7.3.4


