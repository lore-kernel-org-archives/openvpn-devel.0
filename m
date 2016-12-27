From: Christian Hesse <list@...1798...>
Date: Tue, 27 Dec 2016 23:24:06 +0100
Message-Id: <20161227222406.931-1-list@...1798...>
In-Reply-To: <20161129110716.3946-1-list@...1798...>
References: <20161129110716.3946-1-list@...1798...>
Subject: [Openvpn-devel] [PATCH v2 1/1] Clean up plugin path handling
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
define for the plugindir.

v2: The configure script can not evaluate the final $libdir path. So
    use make to create a header file on the containing the final path.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 configure.ac               | 14 ++++++--------
 src/openvpn/.gitignore     |  1 +
 src/openvpn/Makefile.am    | 12 ++++++++++--
 src/openvpn/plugin.c       |  1 +
 src/openvpn/plugindir.h.in | 34 ++++++++++++++++++++++++++++++++++
 5 files changed, 52 insertions(+), 10 deletions(-)
 create mode 100644 src/openvpn/.gitignore
 create mode 100644 src/openvpn/plugindir.h.in

diff --git a/configure.ac b/configure.ac
index 43487b0..182ea21 100644
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
@@ -1245,7 +1244,6 @@ AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugin_auth_pam}" = "ye
 AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_root}" = "yes"])
 AM_CONDITIONAL([ENABLE_CRYPTO], [test "${enable_crypto}" = "yes"])
 
-plugindir="${with_plugindir}"
 sampledir="\$(docdir)/sample"
 AC_SUBST([plugindir])
 AC_SUBST([sampledir])
diff --git a/src/openvpn/.gitignore b/src/openvpn/.gitignore
new file mode 100644
index 0000000..450575a
--- /dev/null
+++ b/src/openvpn/.gitignore
@@ -0,0 +1 @@
+plugindir.h
\ No newline at end of file
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index bea294b..11854b6 100644
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
@@ -131,3 +138,4 @@ if WIN32
 openvpn_SOURCES += openvpn_win32_resources.rc block_dns.c block_dns.h
 openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4
 endif
+
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 17eb2d8..a891ef4 100644
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
+ * define the plugin directory
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


