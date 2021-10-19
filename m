From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:23:07 +0200
Message-Id: <20211019182332.613155-3-arne@...1227...>
In-Reply-To: <20211019182332.613155-1-arne@...1227...>
References: <20211019182332.613155-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 02/20] [OSSL 3.0] Add
 --with-openssl-engine autoconf option (auto|yes|no)
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

This allows to select engine support at configure time. For OpenSSL 1.1 the
default is not changed and we detect if engine support is available.

Engine support is deprecated in OpenSSL 3.0 and for OpenSSL 3.0 the default
is to disable engine support as engine support is deprecated and generates
compiler warnings which in turn also break -Werror.

By using --with-openssl-engine=no or --with-openssl-engine=yes engine support
can be forced on or off. If it is enabled but not detected an error will be
thown.

This commit cleans up the configurelogic a bit and removes the ENGINE_cleanup
checks as we can just assume that it will be also available as macro or function
if the other engine functions are available. Before the cleanup we would only
check for the existance of engine.h if ENGINE_cleanup was not found.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 configure.ac | 68 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 17 deletions(-)

diff --git a/configure.ac b/configure.ac
index a37dc762f..31adb875b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -267,6 +267,18 @@ AC_ARG_ENABLE(
 	[enable_wolfssl_options_h="yes"]
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
@@ -800,23 +812,45 @@ if test "${with_crypto_library}" = "openssl"; then
 				   [AC_MSG_ERROR([openssl check failed])]
 	)
 
-	have_openssl_engine="yes"
-	AC_CHECK_FUNCS(
-		[ \
-			ENGINE_load_builtin_engines \
-			ENGINE_register_all_complete \
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
-		)
-	fi
+    if test "${with_openssl_engine}" = "auto"; then
+        AC_COMPILE_IFELSE(
+        			[AC_LANG_PROGRAM(
+        				[[
+        #include <openssl/opensslv.h>
+        				]],
+        				[[
+        /*	     Version encoding: MNNFFPPS - see opensslv.h for details */
+        #if OPENSSL_VERSION_NUMBER >= 0x30000000L
+        #error Engine supported disabled by default in OpenSSL 3.0+
+        #endif
+        				]]
+        			)],
+        			[have_openssl_engine="yes"],
+        			[have_openssl_engine="no"]
+        )
+        if test "${have_openssl_engine}" = "yes"; then
+            AC_CHECK_FUNCS(
+                [ \
+                    ENGINE_load_builtin_engines \
+                    ENGINE_register_all_complete \
+                ],
+                ,
+                [have_openssl_engine="no"; break]
+            )
+        fi
+    else
+        have_openssl_engine="${with_openssl_engine}"
+        if test "${have_openssl_engine}" = "yes"; then
+            AC_CHECK_FUNCS(
+                [ \
+                    ENGINE_load_builtin_engines \
+                    ENGINE_register_all_complete \
+                ],
+                ,
+                [AC_MSG_ERROR([OpenSSL engine support not found])]
+            )
+        fi
+    fi
 	if test "${have_openssl_engine}" = "yes"; then
 		AC_DEFINE([HAVE_OPENSSL_ENGINE], [1], [OpenSSL engine support available])
 	fi
-- 
2.33.0


