From: Gert Doering <gert@...1296...>
Date: Wed, 12 Nov 2025 10:22:10 +0100
Message-ID: <20251112092216.22703-1-gert@...1296...>
In-Reply-To: <gerrit.1762462761000.I50f189048ef1a624e6ac84b71d7b22fcbbc3ab6b@...2715...>
References: <gerrit.1762462761000.I50f189048ef1a624e6ac84b71d7b22fcbbc3ab6b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] win: remove checks for
 PATHCCH_ENSURE_TRAILING_SLASH
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

From: Heiko Hund <heiko@...2662...>

Since the define is no longer used, remove configuration-time checks if
it exists, and also code dealing with situations where it doesn't.

Change-Id: I50f189048ef1a624e6ac84b71d7b22fcbbc3ab6b
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1354
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1354
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/configure.ac b/configure.ac
index 3117e13..8f3c01d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1383,17 +1383,6 @@
 	fi
 fi
 
-if test "${WIN32}" == "yes"; then
-	AC_CHECK_DECLS(
-		[PATHCCH_ENSURE_TRAILING_SLASH],
-		[AC_DEFINE([HAVE_PATHCCH_ENSURE_TRAILING_SLASH], [1], [PATHCCH_ENSURE_TRAILING_SLASH is defined])],
-		,
-		[[
-			#include <pathcch.h>
-		]]
-	)
-fi
-
 # When testing a compiler option, we add -Werror to force
 # an error when the option is unsupported. This is not
 # required for gcc, but some compilers such as clang need it.
diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index a92ee08..2c8f310 100644
--- a/src/openvpnserv/CMakeLists.txt
+++ b/src/openvpnserv/CMakeLists.txt
@@ -8,9 +8,6 @@
 
 include(CheckSymbolExists)
 
-# Some old versions of mingw does not have PATHCCH_OPTIONS enums -- add a check
-check_symbol_exists(PATHCCH_ENSURE_TRAILING_SLASH pathcch.h HAVE_PATHCCH_ENSURE_TRAILING_SLASH)
-
 set(MC_GEN_DIR ${CMAKE_CURRENT_BINARY_DIR}/mc)
 
 target_include_directories(openvpnserv PRIVATE
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 2dcfe1a..b3189b7 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -27,10 +27,6 @@
 #include <pathcch.h>
 #include <lm.h>
 
-#ifndef HAVE_PATHCCH_ENSURE_TRAILING_SLASH
-#define PATHCCH_ENSURE_TRAILING_SLASH 0x20
-#endif
-
 static const WCHAR *white_list[] = {
     L"auth-retry",
     L"config",

