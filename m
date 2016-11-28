From: Christian Hesse <list@...1798...>
Date: Mon, 28 Nov 2016 17:16:24 +0100
Message-Id: <20161128161625.11972-2-list@...1798...>
In-Reply-To: <20161128161625.11972-1-list@...1798...>
References: <20161128161625.11972-1-list@...1798...>
Subject: [Openvpn-devel] [PATCH 2/2] allow to enable plugin lookup with
	configure argument
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
Cc: Christian Hesse <mail@...1798...>

From: Christian Hesse <mail@...1798...>

For plugin lookup (give relative path to plugin directory in
configuration) we had to configure with something like this:

CFLAGS="$CFLAGS -DPLUGIN_LIBDIR=\\\"/usr/lib/openvpn/plugins\\\"" ./configure

This allows to pass --enable-plugin-lookup to configure to achieve the
same. As a bonus we can be sure that install path and lookup path in
openvpn binary are the same.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 configure.ac            | 8 ++++++++
 src/openvpn/Makefile.am | 4 ++++
 2 files changed, 12 insertions(+)

diff --git a/configure.ac b/configure.ac
index d0fe889..193b5f0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -308,6 +308,14 @@ AC_ARG_WITH(
 	[with_plugindir="\$(libdir)/openvpn/plugins"]
 )
 
+AC_ARG_ENABLE(
+	[plugin-lookup],
+	[AS_HELP_STRING([--enable-plugin-lookup], [enable plugin lookup in plugin directory @<:@default=no@:>@])],
+	[enable_plugin_lookup="$enableval"],
+	[enable_plugin_lookup="no"]
+)
+AM_CONDITIONAL([ENABLE_PLUGIN_LOOKUP], [test x$enable_plugin_lookup = xyes])
+
 
 AC_DEFINE_UNQUOTED([TARGET_ALIAS], ["${host}"], [A string representing our host])
 case "$host" in
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 4c18449..46afc9a 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -33,6 +33,10 @@ if WIN32
 AM_CFLAGS += -municode -UUNICODE
 endif
 
+if ENABLE_PLUGIN_LOOKUP
+AM_CFLAGS += -DPLUGIN_LIBDIR=\"$(plugindir)\"
+endif
+
 sbin_PROGRAMS = openvpn
 
 openvpn_SOURCES = \
-- 
2.10.2


