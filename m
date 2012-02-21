From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 21 Feb 2012 03:22:11 +0200
Message-Id: <1329787361-26096-6-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 05/35] build: correct place to alter WINVER
	is at build system
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
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac    |    2 +-
 syshead.h       |    4 ----
 win/msvc.mak.in |    2 +-
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1c4d66c..aa1d509 100644
--- a/configure.ac
+++ b/configure.ac
@@ -342,7 +342,7 @@ case "$host" in
 	;;
 *-mingw*)
 	AC_DEFINE(TARGET_WIN32, 1, [Are we running WIN32?])
-	CPPFLAGS="${CPPFLAGS} -DWIN32_LEAN_AND_MEAN"
+	CPPFLAGS="${CPPFLAGS} -DWIN32_LEAN_AND_MEAN -DWINVER=0x0501"
 	OPENVPN_ADD_LIBS(-lgdi32)
 	OPENVPN_ADD_LIBS(-lws2_32)
 	OPENVPN_ADD_LIBS(-lwininet)
diff --git a/syshead.h b/syshead.h
index 0235abd..e8e70d2 100644
--- a/syshead.h
+++ b/syshead.h
@@ -28,10 +28,6 @@
 /*
  * Only include if not during configure
  */
-#ifdef WIN32
-/* PF_INET6: win32 ipv6 exists only after 0x0501 (XP) */
-#define WINVER 0x0501
-#endif
 #ifndef PACKAGE_NAME
 #include "config.h"
 #include "compat.h"
diff --git a/win/msvc.mak.in b/win/msvc.mak.in
index 191f370..43c3335 100644
--- a/win/msvc.mak.in
+++ b/win/msvc.mak.in
@@ -38,7 +38,7 @@ LIB_DIRS = -LIBPATH:$(OPENSSL)\lib -LIBPATH:$(POLARSSL)\build\library -LIBPATH:$
 EXE = openvpn.exe
 
 CPP=cl.exe
-CPP_ARG_COMMON=/nologo /W3 -DWIN32 -DWIN32_LEAN_AND_MEAN -D_CONSOLE -D_MBCS -D_CRT_SECURE_NO_DEPRECATE -D_CRT_NONSTDC_NO_WARNINGS -D_CRT_SECURE_NO_WARNINGS $(INCLUDE_DIRS) /FD /c
+CPP_ARG_COMMON=/nologo /W3 -DWIN32 -DWIN32_LEAN_AND_MEAN -DWINVER=0x0501 -D_CONSOLE -D_MBCS -D_CRT_SECURE_NO_DEPRECATE -D_CRT_NONSTDC_NO_WARNINGS -D_CRT_SECURE_NO_WARNINGS $(INCLUDE_DIRS) /FD /c
 
 LINK32=link.exe
 
-- 
1.7.3.4


