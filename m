From: Christian Hesse <list@...1798...>
Date: Wed, 25 Jan 2017 21:19:47 +0100
Message-Id: <20170125201947.17197-1-list@...1798...>
In-Reply-To: <20170125193727.32061-1-list@...1798...>
References: <20170125193727.32061-1-list@...1798...>
Subject: [Openvpn-devel] [PATCH v5 1/1] Clean up plugin path handling
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

This puts a define into include/openvpn-plugin.h.in which has the plugin
directory.
The configure script does not know about the final plugin path. Thus we
have to make make generate the final header file for us.

As the path is always available remove the compile time condition (and
dead code) from src/openvpn/plugin.c.

v2: The configure script can not evaluate the final $libdir path. So
    use make to create a header file on the containing the final path.

v3: Fix whitespace errors and gitignore location.

v4: No extra header file, generate src/openvpn/plugin.h on the fly.
    Remove condition and dead code.

v5: Move the define to include/openvpn-plugin.h.in and let make generate
    the final header file.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 configure.ac                | 16 +++++++---------
 include/Makefile.am         |  7 +++++++
 include/openvpn-plugin.h.in |  2 ++
 src/openvpn/plugin.c        | 10 +---------
 4 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/configure.ac b/configure.ac
index 79fb1ba..f305c54 100644
--- a/configure.ac
+++ b/configure.ac
@@ -38,7 +38,7 @@ AC_DEFINE([OPENVPN_VERSION_MINOR], [PRODUCT_VERSION_MINOR], [OpenVPN minor versi
 AC_DEFINE([OPENVPN_VERSION_PATCH], ["PRODUCT_VERSION_PATCH"], [OpenVPN patch level - may be a string or integer])
 
 AC_CONFIG_AUX_DIR([.])
-AC_CONFIG_HEADERS([config.h include/openvpn-plugin.h])
+AC_CONFIG_HEADERS([config.h])
 AC_CONFIG_SRCDIR([src/openvpn/syshead.h])
 AC_CONFIG_MACRO_DIR([m4])
 
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
diff --git a/include/Makefile.am b/include/Makefile.am
index a52c427..37962a6 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -16,3 +16,10 @@ MAINTAINERCLEANFILES = \
 include_HEADERS = \
 	openvpn-plugin.h \
 	openvpn-msg.h
+
+openvpn-plugin.h: openvpn-plugin.h.in Makefile
+	$(AM_V_GEN)sed -e 's|\@PLUGINDIR\@|$(plugindir)|' \
+		-e 's|\@OPENVPN_VERSION_MAJOR\@|$(OPENVPN_VERSION_MAJOR)|' \
+		-e 's|\@OPENVPN_VERSION_MINOR\@|$(OPENVPN_VERSION_MINOR)|' \
+		-e 's|\@OPENVPN_VERSION_PATCH\@|$(OPENVPN_VERSION_PATCH)|' \
+               $< > $@.tmp && mv $@.tmp $@
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index 0b30352..a084fc1 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -27,6 +27,8 @@
 
 #define OPENVPN_PLUGIN_VERSION 3
 
+#define PLUGIN_LIBDIR "@PLUGINDIR@"
+
 #ifdef ENABLE_CRYPTO
 #ifdef ENABLE_CRYPTO_MBEDTLS
 #include <mbedtls/x509_crt.h>
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
-- 
2.11.0


