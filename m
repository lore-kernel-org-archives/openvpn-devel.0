From: Gert Doering <gert@...1296...>
Date: Tue,  4 Jun 2024 23:17:08 +0200
Message-ID: <20240604211708.32315-1-gert@...1296...>
In-Reply-To: <gerrit.1717513301000.I32ee28fde5d38d736f753c782d88a81de7fe2980@...2715...>
References: <gerrit.1717513301000.I32ee28fde5d38d736f753c782d88a81de7fe2980@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] LZO: do not use lzoutils.h macros
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

Instead of lzo_{free,malloc} we can just use the
free and malloc as the lzoutils.h header itself
suggests.

Change-Id: I32ee28fde5d38d736f753c782d88a81de7fe2980
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/642
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 2cdfdcc..effca2a 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -184,9 +184,6 @@
 /* Define to 1 if you have the <lzo1x.h> header file. */
 #define HAVE_LZO1X_H 1
 
-/* Define to 1 if you have the <lzoutil.h> header file. */
-#define HAVE_LZOUTIL_H 1
-
 /* Define to 1 if you have the `mlockall' function. */
 #cmakedefine HAVE_MLOCKALL
 
diff --git a/configure.ac b/configure.ac
index d39cf7d..7f0105b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1174,15 +1174,6 @@
 	saved_CFLAGS="${CFLAGS}"
 	CFLAGS="${CFLAGS} ${LZO_CFLAGS}"
 	AC_CHECK_HEADERS(
-		[lzo/lzoutil.h],
-		,
-		[AC_CHECK_HEADERS(
-			[lzoutil.h],
-			,
-			[AC_MSG_ERROR([lzoutil.h is missing])]
-		)]
-	)
-	AC_CHECK_HEADERS(
 		[lzo/lzo1x.h],
 		,
 		[AC_CHECK_HEADERS(
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index b313284..bab2d78 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -107,14 +107,14 @@
     {
         msg(M_FATAL, "Cannot initialize LZO compression library (lzo_init() returns %d)", lzo_status);
     }
-    compctx->wu.lzo.wmem = (lzo_voidp) lzo_malloc(compctx->wu.lzo.wmem_size);
+    compctx->wu.lzo.wmem = (lzo_voidp) malloc(compctx->wu.lzo.wmem_size);
     check_malloc_return(compctx->wu.lzo.wmem);
 }
 
 static void
 lzo_compress_uninit(struct compress_context *compctx)
 {
-    lzo_free(compctx->wu.lzo.wmem);
+    free(compctx->wu.lzo.wmem);
     compctx->wu.lzo.wmem = NULL;
 }
 
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index e951b49..62d73a1 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -40,16 +40,11 @@
 #if defined(HAVE_LZO_CONF_H)
 /* The lzo.h magic gets confused and still wants
  * to include lzo/lzoconf.h even if our include paths
- * are setup to include the paths without lzo/ include lzoconf.h to
- * avoid it being include by lzoutil.h */
+ * are setup to include the paths without lzo/
+ */
 #include <lzodefs.h>
 #include <lzoconf.h>
 #endif
-#if defined(HAVE_LZO_LZOUTIL_H)
-#include <lzo/lzoutil.h>
-#elif defined(HAVE_LZOUTIL_H)
-#include <lzoutil.h>
-#endif
 #if defined(HAVE_LZO_LZO1X_H)
 #include <lzo/lzo1x.h>
 #elif defined(HAVE_LZO1X_H)

