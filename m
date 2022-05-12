From: Arne Schwabe <arne@...1227...>
Date: Thu, 12 May 2022 14:14:27 +0200
Message-Id: <20220512121429.2096164-6-arne@...1227...>
In-Reply-To: <20220512121429.2096164-1-arne@...1227...>
References: <20220512121429.2096164-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/7] Add --with-openssl-engine autoconf
 option (auto|yes|no)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This is a cherry-pick to release2.5 from 0df2261da. The OpenSSL engine
tests fail  otherwise and it is good to have the same behaviour as in
master/2.6

This allows to select engine support at configure time. For OpenSSL 1.1 the
default is not changed and we detect if engine support is available.

Engine support is deprecated in OpenSSL 3.0 and for OpenSSL 3.0 the default
is to disable engine support as engine support is deprecated and generates
compiler warnings which in turn also break -Werror.

By using --with-openssl-engine=no or --with-openssl-engine=yes engine
support can be forced on or off. If it is enabled but not detected an
error will be thown.

This commit cleans up the configure logic a bit and removes the
ENGINE_cleanup checks as we can just assume that it will be also
available as macro or function if the other engine functions are
available. Before the cleanup we would only check for the existance
of engine.h if ENGINE_cleanup was not found.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst  |  3 +++
 configure.ac | 60 ++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 50 insertions(+), 13 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 884c122a9..d15ffbb87 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -27,6 +27,9 @@ New features
     algorithm by default and the new option ``--providers`` allows loading
     the legacy provider to renable these algorithms.
 
+    The OpenSSL engine feature ``--engine`` is not enabled by default
+    anymore if OpenSSL 3.0 is detected.
+
 
 Bugfixes
 --------
diff --git a/configure.ac b/configure.ac
index 6242cc22e..2f5f6bc7c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -281,6 +281,18 @@ AC_ARG_WITH(
 	[with_crypto_library="openssl"]
 )
 
+AC_ARG_WITH(
+	[openssl-engine],
+	[AS_HELP_STRING([--with-openssl-engine], [enable engine support with OpenSSL. Default enabled for OpenSSL < 3.0, auto,yes,no @<:@default=auto@:>@])],
+	[
+		case "${withval}" in
+			auto|yes|no) ;;
+			*) AC_MSG_ERROR([bad value ${withval} for --with-engine]) ;;
+		esac
+	],
+	[with_openssl_engine="auto"]
+)
+
 AC_ARG_VAR([PLUGINDIR], [Path of plug-in directory @<:@default=LIBDIR/openvpn/plugins@:>@])
 if test -n "${PLUGINDIR}"; then
 	plugindir="${PLUGINDIR}"
@@ -880,22 +892,44 @@ if test "${with_crypto_library}" = "openssl"; then
 				   [AC_MSG_ERROR([openssl check failed])]
 	)
 
-	have_openssl_engine="yes"
-	AC_CHECK_FUNCS(
-		[ \
+	if test "${with_openssl_engine}" = "auto"; then
+	    AC_COMPILE_IFELSE(
+				    [AC_LANG_PROGRAM(
+					    [[
+	    #include <openssl/opensslv.h>
+					    ]],
+					    [[
+	    /*	     Version encoding: MNNFFPPS - see opensslv.h for details */
+	    #if OPENSSL_VERSION_NUMBER >= 0x30000000L
+	    #error Engine supported disabled by default in OpenSSL 3.0+
+	    #endif
+					    ]]
+				    )],
+				    [have_openssl_engine="yes"],
+				    [have_openssl_engine="no"]
+	    )
+	    if test "${have_openssl_engine}" = "yes"; then
+		AC_CHECK_FUNCS(
+		    [ \
 			ENGINE_load_builtin_engines \
 			ENGINE_register_all_complete \
-			ENGINE_cleanup \
-		],
-		,
-		[have_openssl_engine="no"; break]
-	)
-	if test "${have_openssl_engine}" = "no"; then
-		AC_CHECK_DECL( [ENGINE_cleanup], [have_openssl_engine="yes"],,
-			[[
-				#include <openssl/engine.h>
-			]]
+		    ],
+		    ,
+		    [have_openssl_engine="no"; break]
+		)
+	    fi
+	else
+	    have_openssl_engine="${with_openssl_engine}"
+	    if test "${have_openssl_engine}" = "yes"; then
+		AC_CHECK_FUNCS(
+		    [ \
+			ENGINE_load_builtin_engines \
+			ENGINE_register_all_complete \
+		    ],
+		    ,
+		    [AC_MSG_ERROR([OpenSSL engine support not found])]
 		)
+	    fi
 	fi
 	if test "${have_openssl_engine}" = "yes"; then
 		AC_DEFINE([HAVE_OPENSSL_ENGINE], [1], [OpenSSL engine support available])
-- 
2.32.0 (Apple Git-132)


