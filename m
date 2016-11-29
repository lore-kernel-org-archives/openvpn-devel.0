From: Christian Hesse <list@...1798...>
Date: Tue, 29 Nov 2016 12:07:16 +0100
Message-Id: <20161129110716.3946-1-list@...1798...>
In-Reply-To: <20161129120559.5be3e4ad@...1799...>
References: <20161129120559.5be3e4ad@...1799...>
Subject: [Openvpn-devel] [PATCH 1/1] Clean up plugin path handling
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

This always defines PLUGIN_LIBDIR and enables plugin search path.

Signed-off-by: Christian Hesse <mail@...1798...>
---
 configure.ac            | 14 ++++++--------
 src/openvpn/Makefile.am |  3 ++-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index f4073d0..5fe652e 100644
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
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 4c18449..188834a 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -27,7 +27,8 @@ AM_CFLAGS = \
 	$(OPTIONAL_CRYPTO_CFLAGS) \
 	$(OPTIONAL_LZO_CFLAGS) \
 	$(OPTIONAL_LZ4_CFLAGS) \
-	$(OPTIONAL_PKCS11_HELPER_CFLAGS)
+	$(OPTIONAL_PKCS11_HELPER_CFLAGS) \
+	-DPLUGIN_LIBDIR=\"${plugindir}\"
 if WIN32
 # we want unicode entry point but not the macro
 AM_CFLAGS += -municode -UUNICODE
-- 
2.10.2


