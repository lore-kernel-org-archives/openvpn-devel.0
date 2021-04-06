From: Arne Schwabe <arne@...1227...>
Date: Tue,  6 Apr 2021 18:25:15 +0200
Message-Id: <20210406162518.4075-2-arne@...1227...>
In-Reply-To: <20210406162518.4075-1-arne@...1227...>
References: <20210406162518.4075-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/5] Remove checks for uint* types that are
 part of C99
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 compat.m4             | 18 ------------------
 configure.ac          |  8 --------
 src/openvpn/syshead.h |  4 +---
 3 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/compat.m4 b/compat.m4
index 47650f6d3..8fa9abee1 100644
--- a/compat.m4
+++ b/compat.m4
@@ -46,24 +46,6 @@ ifdef(
 	,
 	[AC_DEFUN([AC_PROG_SED], [AC_CHECK_PROGS([SED], [sed])])]
 )
-ifdef(
-	[AC_TYPE_INT8_T],
-	,
-	[
-		AC_CHECK_HEADERS([inttypes.h stdint.h])
-		test -z "${ac_cv_header_inttypes_h}${ac_cv_header_stdint_h}" && \
-			AC_MSG_ERROR([Required inttypes.h stdint.h not found])
-		
-		AC_DEFUN([AC_TYPE_INT8_T], [])
-		AC_DEFUN([AC_TYPE_INT16_T], [])
-		AC_DEFUN([AC_TYPE_INT32_T], [])
-		AC_DEFUN([AC_TYPE_INT64_T], [])
-		AC_DEFUN([AC_TYPE_UINT8_T], [])
-		AC_DEFUN([AC_TYPE_UINT16_T], [])
-		AC_DEFUN([AC_TYPE_UINT32_T], [])
-		AC_DEFUN([AC_TYPE_UINT64_T], [])
-	]
-)
 ifdef(
 	[PKG_CHECK_VAR],
 	,
diff --git a/configure.ac b/configure.ac
index 23dac74f1..07a62ad8f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -409,14 +409,6 @@ AC_TYPE_OFF_T
 AC_TYPE_PID_T
 AC_TYPE_SIZE_T
 AC_TYPE_UID_T
-AC_TYPE_INT8_T
-AC_TYPE_INT16_T
-AC_TYPE_INT32_T
-AC_TYPE_INT64_T
-AC_TYPE_UINT8_T
-AC_TYPE_UINT16_T
-AC_TYPE_UINT32_T
-AC_TYPE_UINT64_T
 AC_TYPE_SIGNAL
 AX_TYPE_SOCKLEN_T
 AC_CHECK_SIZEOF([unsigned int])
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 16f5ab11f..bca71d5cf 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -118,11 +118,9 @@
 #include <stdlib.h>
 #endif
 
-#ifdef HAVE_INTTYPES_H
+/* These headers belong to C99 and should be always be present */
 #include <inttypes.h>
-#elif defined(HAVE_STDINT_H)
 #include <stdint.h>
-#endif
 
 #ifdef HAVE_STDARG_H
 #include <stdarg.h>
-- 
2.30.1


