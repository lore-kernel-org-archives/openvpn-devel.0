From: Christian Hesse <list@...1798...>
Date: Wed, 25 Jan 2017 17:04:28 +0100
Message-Id: <20170125160428.19928-1-list@...1798...>
In-Reply-To: <20161227222406.931-1-list@...1798...>
References: <20161227222406.931-1-list@...1798...>
Subject: [Openvpn-devel] [PATCH v3 1/1] Clean up plugin path handling
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
To: OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Cc: Christian Hesse <mail@...1798...>

From: Christian Hesse <mail@...1798...>

Drop --with-plugindir, instead use an environment variable PLUGINDIR
to specify the plugin directory.

This generates a header file src/openvpn/plugindir.h which contains a
define file the plugindir.

v2: The configure script can not evaluate the final $libdir path. So
    use make to create a header file on the containing the final path.

v3: Fix whitespace errors and gitignore location.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 .gitignore                 |  1 +
 configure.ac               | 14 ++++++--------
 src/openvpn/Makefile.am    | 11 +++++++++--
 src/openvpn/plugin.c       |  1 +
 src/openvpn/plugindir.h.in | 34 ++++++++++++++++++++++++++++++++++
 5 files changed, 51 insertions(+), 10 deletions(-)
 create mode 100644 src/openvpn/plugindir.h.in

diff --git a/.gitignore b/.gitignore
index e6da21c..28df0f8 100644
--- a/.gitignore
+++ b/.gitignore
@@ -62,6 +62,7 @@ t_client_ips.rc
 tests/unit_tests/**/*_testdriver
 
 src/openvpn/openvpn
+src/openvpn/plugindir.h
 include/openvpn-plugin.h
 config-version.h
 nbproject
diff --git a/configure.ac b/configure.ac
index 8783109..f4c6bda 100644
--- a/configure.ac
+++ b/configure.ac
@@ -301,13 +301,12 @@ AC_ARG_WITH(
 	[with_crypto_library="openssl"]
 )
 
-AC_ARG_WITH(
-	[plugindir],
-	[AS_HELP_STRING([--with-plugindir], [plugin directory @<:@default=LIBDIR/openvpn@:>@])],
-	,
-	[with_plugindir="\$(libdir)/openvpn/plugins"]
-)
-
+AC_ARG_VAR([PLUGINDIR], [Path of plug-in directory @<:@default=LIBDIR/openvpn/plugins@:>@])
+if test -n "${PLUGINDIR}"; then
+	plugindir="${PLUGINDIR}"
+else
+	plugindir="\${libdir}/openvpn/plugins"
+fi
 
 AC_DEFINE_UNQUOTED([TARGET_ALIAS], ["${host}"], [A string representing our host])
 case "$host" in
@@ -1270,7 +1269,6 @@ AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_root}" = "
 AM_CONDITIONAL([ENABLE_CRYPTO], [test "${enable_crypto}" = "yes"])
 AM_CONDITIONAL([HAVE_LD_WRAP_SUPPORT], [test "${have_ld_wrap_support}" = "yes"])
 
-plugindir="${with_plugindir}"
 sampledir="\$(docdir)/sample"
 AC_SUBST([plugindir])
 AC_SUBST([sampledir])
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index bea294b..53f4676 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -11,12 +11,19 @@
 
 include $(top_srcdir)/build/ltrc.inc
 
+plugindir.h: plugindir.h.in Makefile
+	$(AM_V_GEN)sed -e 's|\@PLUGINDIR\@|$(plugindir)|' \
+		$< > $@.tmp && mv $@.tmp $@
+
+plugin.c: plugindir.h
+
 MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
 EXTRA_DIST = \
 	openvpn.vcxproj \
-	openvpn.vcxproj.filters
+	openvpn.vcxproj.filters \
+	plugindir.h.in
 
 AM_CPPFLAGS = \
 	-I$(top_srcdir)/include \
@@ -89,7 +96,7 @@ openvpn_SOURCES = \
 	perf.c perf.h \
 	pf.c pf.h pf-inline.h \
 	ping.c ping.h ping-inline.h \
-	plugin.c plugin.h \
+	plugin.c plugin.h plugindir.h \
 	pool.c pool.h \
 	proto.c proto.h \
 	proxy.c proxy.h \
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index e530c0c..5af6d1e 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -43,6 +43,7 @@
 #include "error.h"
 #include "misc.h"
 #include "plugin.h"
+#include "plugindir.h"
 #include "ssl_backend.h"
 #include "win32.h"
 #include "memdbg.h"
diff --git a/src/openvpn/plugindir.h.in b/src/openvpn/plugindir.h.in
new file mode 100644
index 0000000..6fa7b3e
--- /dev/null
+++ b/src/openvpn/plugindir.h.in
@@ -0,0 +1,34 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2017 OpenVPN Technologies, Inc. <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+/*
+ * define plugindir
+ */
+
+#ifndef OPENVPN_PLUGINDIR_H
+#define OPENVPN_PLUGINDIR_H
+
+#define PLUGIN_LIBDIR "@PLUGINDIR@"
+
+#endif /* OPENVPN_PLUGINDIR_H */
-- 
2.11.0


