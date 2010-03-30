From: David Sommerseth <dazo@...384...>
Date: Tue, 30 Mar 2010 14:12:58 +0200
Message-Id: <1269951178-30419-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH] Add comile time settings from ./configure
	information to --version
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
Cc: David Sommerseth <dazo@...384...>

This patch will create ./configure.h which will contain two new #define
strings.  CONFIGURE_DEFINES will contain all USE, ENABLED, DISABLED and
DEPRECATED defines from ./config.h.  CONFIGURE_CALL will contain the
complete ./configure line which was used when configuring the package
for building.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 Makefile.am       |    7 +++++++
 configure_h.awk   |   39 +++++++++++++++++++++++++++++++++++++++
 configure_log.awk |   36 ++++++++++++++++++++++++++++++++++++
 options.c         |    3 +++
 4 files changed, 85 insertions(+), 0 deletions(-)
 create mode 100644 configure_h.awk
 create mode 100644 configure_log.awk

diff --git a/Makefile.am b/Makefile.am
index e199b17..0b909f9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -6,6 +6,7 @@
 #             packet compression.
 #
 #  Copyright (C) 2002-2009 OpenVPN Technologies, Inc. <sales@...515...>
+#  Copyright (C) 2010      David Sommerseth <dazo@...384...>
 #
 #  This program is free software; you can redistribute it and/or modify
 #  it under the terms of the GNU General Public License version 2
@@ -141,6 +142,12 @@ openvpn_SOURCES = \
 	cryptoapi.h cryptoapi.c \
 	deprecated.h deprecated.c
 
+configure.h: Makefile
+	awk -f configure_h.awk config.h > $@
+	awk -f configure_log.awk config.log >> $@
+
+clean-local:
+	-rm -f configure.h
 
 dist-hook:
 	cd $(distdir) && for i in $(EXTRA_DIST) $(SUBDIRS) ; do find $$i -name .svn -type d -prune -exec rm -rf '{}' ';' ; rm -f `find $$i -type f | grep -E '(^|\/)\.?\#|\~$$|\.s?o$$'` ; done
diff --git a/configure_h.awk b/configure_h.awk
new file mode 100644
index 0000000..672e745
--- /dev/null
+++ b/configure_h.awk
@@ -0,0 +1,39 @@
+#
+#  OpenVPN -- An application to securely tunnel IP networks
+#             over a single UDP port, with support for SSL/TLS-based
+#             session authentication and key exchange,
+#             packet encryption, packet authentication, and
+#             packet compression.
+#
+#  Copyright (C) 2010  David Sommerseth <dazo@...384...>
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License version 2
+#  as published by the Free Software Foundation.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program (see the file COPYING included with this
+#  distribution); if not, write to the Free Software Foundation, Inc.,
+#  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+#
+#
+#  This script will build up a line which can be included into a C program.
+#  The line will contain all interesting #define statements from f.ex. ./config.h
+#
+
+BEGIN {
+	printf ("#define CONFIGURE_DEFINES \"")
+}
+
+/^#define (ENABLE|DISABLE|DEPRECATED|USE)_/ {
+	printf (" %s", $2)
+}
+
+END {
+	printf ("\"\n")
+}
diff --git a/configure_log.awk b/configure_log.awk
new file mode 100644
index 0000000..b305f71
--- /dev/null
+++ b/configure_log.awk
@@ -0,0 +1,36 @@
+#
+#  OpenVPN -- An application to securely tunnel IP networks
+#             over a single UDP port, with support for SSL/TLS-based
+#             session authentication and key exchange,
+#             packet encryption, packet authentication, and
+#             packet compression.
+#
+#  Copyright (C) 2010  David Sommerseth <dazo@...384...>
+#
+#  This program is free software; you can redistribute it and/or modify
+#  it under the terms of the GNU General Public License version 2
+#  as published by the Free Software Foundation.
+#
+#  This program is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#  GNU General Public License for more details.
+#
+#  You should have received a copy of the GNU General Public License
+#  along with this program (see the file COPYING included with this
+#  distribution); if not, write to the Free Software Foundation, Inc.,
+#  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+#
+#
+#  This script will build up a line which can be included into a C program.
+#  The line will only contain the first entry of the ./configure line from
+#  ./config.log.
+#
+
+BEGIN {
+	printf ("#define CONFIGURE_CALL \"")
+}
+/\$ .\/configure/ {
+	print $0,"\""
+	exit 0
+}
diff --git a/options.c b/options.c
index f2f6504..d0e76f7 100644
--- a/options.c
+++ b/options.c
@@ -48,6 +48,7 @@
 #include "pool.h"
 #include "helper.h"
 #include "manage.h"
+#include "configure.h"
 
 #include "memdbg.h"
 
@@ -2950,6 +2951,8 @@ usage_version (void)
   msg (M_INFO|M_NOPREFIX, "%s", title_string);
   msg (M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
   msg (M_INFO|M_NOPREFIX, "Copyright (C) 2002-2009 OpenVPN Technologies, Inc. <sales@...515...>");
+  msg (M_INFO|M_NOPREFIX, "\n%s\n", CONFIGURE_CALL);
+  msg (M_INFO|M_NOPREFIX, "Compile time defines: %s", CONFIGURE_DEFINES);
   openvpn_exit (OPENVPN_EXIT_STATUS_USAGE); /* exit point */
 }
 
-- 
1.6.6.1


