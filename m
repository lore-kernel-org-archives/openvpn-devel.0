From: Gert Doering <gert@...1296...>
Date: Mon, 27 Apr 2026 19:47:50 +0200
Message-ID: <20260427174757.4075-1-gert@...1296...>
In-Reply-To: <gerrit.1774451380000.I53e7b984980cb1e2b3f68e80358b61c9e1045725@...2715...>
References: <gerrit.1774451380000.I53e7b984980cb1e2b3f68e80358b61c9e1045725@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] configure: Remove --enable-strict
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

From: Frank Lichtenheld <frank@...2641...>

Both -Wsign-compare (via -Wextra) and -Wuninitalized (via
-Wall) are enabled by default. So this does not do anything
anymore.

While here also remove rest of --enable-strict-options which
was mostly removed in commit
2104ea62430e4d203f2cd998e053f4192798b9f1

Change-Id: I53e7b984980cb1e2b3f68e80358b61c9e1045725
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1590
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1590
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 198c98f..f9cbbfd 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -112,7 +112,7 @@
         add_link_options("$<$<CONFIG:Release>:/CETCOMPAT>")
     endif()
 else ()
-    add_compile_options(-Wall -Wuninitialized)
+    add_compile_options(-Wall)
     check_and_add_compiler_flag(-Wno-stringop-truncation NoStringOpTruncation)
     check_and_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)
     check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)
diff --git a/configure.ac b/configure.ac
index ecef2b9..5da877a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -203,13 +203,6 @@
 )
 
 AC_ARG_ENABLE(
-	[strict],
-	[AS_HELP_STRING([--enable-strict], [enable strict compiler warnings (debugging option) @<:@default=no@:>@])],
-	,
-	[enable_strict="no"]
-)
-
-AC_ARG_ENABLE(
 	[pedantic],
 	[AS_HELP_STRING([--enable-pedantic], [enable pedantic compiler warnings, will not generate a working executable (debugging option) @<:@default=no@:>@])],
 	,
@@ -224,13 +217,6 @@
 )
 
 AC_ARG_ENABLE(
-	[strict-options],
-	[AS_HELP_STRING([--enable-strict-options], [enable strict options check between peers (debugging option) @<:@default=no@:>@])],
-	,
-	[enable_strict_options="no"]
-)
-
-AC_ARG_ENABLE(
 	[selinux],
 	[AS_HELP_STRING([--enable-selinux], [enable SELinux support @<:@default=no@:>@])],
 	,
@@ -1270,13 +1256,9 @@
 fi
 
 if test "${enable_pedantic}" = "yes"; then
-	enable_strict="yes"
 	CFLAGS="${CFLAGS} -pedantic"
 	AC_DEFINE([PEDANTIC], [1], [Enable pedantic mode])
 fi
-if test "${enable_strict}" = "yes"; then
-	CFLAGS="${CFLAGS} -Wsign-compare -Wuninitialized"
-fi
 if test "${enable_werror}" = "yes"; then
 	CFLAGS="${CFLAGS} -Werror"
 fi

