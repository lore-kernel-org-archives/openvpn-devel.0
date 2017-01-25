From: Christian Hesse <list@...1798...>
Date: Wed, 25 Jan 2017 20:37:27 +0100
Message-Id: <20170125193727.32061-1-list@...1798...>
In-Reply-To: <20170125195758.47ba7586@...1799...>
References: <20170125195758.47ba7586@...1799...>
Subject: [Openvpn-devel] [PATCH v4 1/1] Clean up plugin path handling
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

Drop --with-plugindir, instead use an environment variable PLUGINDIR
to specify the plugin directory.

This makes src/openvpn/plugin.h a template (moved the file to
src/openvpn/plugin.h.in). The real header file is generated on the fly,
including a define for the plugin path.
As the path is always available remove the compile time condition (and
dead code) from src/openvpn/plugin.c.

v2: The configure script can not evaluate the final $libdir path. So
    use make to create a header file on the containing the final path.

v3: Fix whitespace errors and gitignore location.

v4: No extra header file, generate src/openvpn/plugin.h on the fly.
    Remove condition and dead code.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 .gitignore                            |  1 +
 configure.ac                          | 14 ++++++--------
 src/openvpn/Makefile.am               |  7 ++++++-
 src/openvpn/plugin.c                  | 10 +---------
 src/openvpn/{plugin.h => plugin.h.in} |  2 ++
 5 files changed, 16 insertions(+), 18 deletions(-)
 rename src/openvpn/{plugin.h => plugin.h.in} (99%)

diff --git a/.gitignore b/.gitignore
index 30e289b..780be68 100644
--- a/.gitignore
+++ b/.gitignore
@@ -63,6 +63,7 @@ t_client_ips.rc
 tests/unit_tests/**/*_testdriver
 
 src/openvpn/openvpn
+src/openvpn/plugin.h
 include/openvpn-plugin.h
 config-version.h
 nbproject
diff --git a/configure.ac b/configure.ac
index 79fb1ba..b29f8b4 100644
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
@@ -1284,7 +1283,6 @@ AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_root}" = "
 AM_CONDITIONAL([ENABLE_CRYPTO], [test "${enable_crypto}" = "yes"])
 AM_CONDITIONAL([HAVE_LD_WRAP_SUPPORT], [test "${have_ld_wrap_support}" = "yes"])
 
-plugindir="${with_plugindir}"
 sampledir="\$(docdir)/sample"
 AC_SUBST([plugindir])
 AC_SUBST([sampledir])
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index bea294b..4f8a315 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -11,12 +11,17 @@
 
 include $(top_srcdir)/build/ltrc.inc
 
+plugin.h: plugin.h.in Makefile
+	$(AM_V_GEN)sed -e 's|\@PLUGINDIR\@|$(plugindir)|' \
+		$< > $@.tmp && mv $@.tmp $@
+
 MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
 EXTRA_DIST = \
 	openvpn.vcxproj \
-	openvpn.vcxproj.filters
+	openvpn.vcxproj.filters \
+	plugin.h.in
 
 AM_CPPFLAGS = \
 	-I$(top_srcdir)/include \
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index e530c0c..f777027 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -234,23 +234,15 @@ plugin_init_item(struct plugin *p, const struct plugin_option *o)
 #ifndef _WIN32
 
     p->handle = NULL;
-#if defined(PLUGIN_LIBDIR)
+
     if (!absolute_pathname(p->so_pathname))
     {
         char full[PATH_MAX];
 
         openvpn_snprintf(full, sizeof(full), "%s/%s", PLUGIN_LIBDIR, p->so_pathname);
         p->handle = dlopen(full, RTLD_NOW);
-#if defined(ENABLE_PLUGIN_SEARCH)
-        if (!p->handle)
-        {
-            rel = true;
-            p->handle = dlopen(p->so_pathname, RTLD_NOW);
-        }
-#endif
     }
     else
-#endif
     {
         rel = !absolute_pathname(p->so_pathname);
         p->handle = dlopen(p->so_pathname, RTLD_NOW);
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h.in
similarity index 99%
rename from src/openvpn/plugin.h
rename to src/openvpn/plugin.h.in
index 4ded529..3d6e312 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h.in
@@ -43,6 +43,8 @@
 
 #define MAX_PLUGINS 16
 
+#define PLUGIN_LIBDIR "@PLUGINDIR@"
+
 struct plugin_option {
     const char *so_pathname;
     const char **argv;
-- 
2.11.0


