From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 12 May 2012 22:19:44 +0300
Message-Id: <1336850389-23719-12-git-send-email-alon.barlev@...277...>
In-Reply-To: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
References: <1336850389-23719-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 11/16] cleanup: syshead: move
	_P1003_1B_VISIBLE to autoconf
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
To: openvpn-devel@lists.sourceforge.net, openvpn.list@...1114..., openvpn-devel@lists.sourceforge.net, openvpn.list@...1114...
Cc: Alon Bar-Lev <alon.barlev@...277...>

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac          |    2 +-
 src/openvpn/syshead.h |    3 ---
 2 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 078e46f..2c80ef4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -291,7 +291,7 @@ case "$host" in
 		AC_DEFINE([TARGET_DARWIN], [1], [Are we running on Mac OS X?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["M"], [Target prefix])
 		dnl some Mac OS X tendering (we use vararg macros...)
-		CPPFLAGS="$CPPFLAGS -no-cpp-precomp"
+		CPPFLAGS="$CPPFLAGS -no-cpp-precomp -D_P1003_1B_VISIBLE"
 		;;
 	*-mingw*)
 		AC_DEFINE([TARGET_WIN32], [1], [Are we running WIN32?])
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index e522876..3fd955d 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -328,9 +328,6 @@
 #endif
 
 #ifdef HAVE_SYS_MMAN_H
-#ifdef TARGET_DARWIN
-#define _P1003_1B_VISIBLE
-#endif /* TARGET_DARWIN */
 #include <sys/mman.h>
 #endif
 
-- 
1.7.3.4


