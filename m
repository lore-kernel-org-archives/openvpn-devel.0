From: Simon Rozman <simon@...2293...>
Date: Fri, 13 Apr 2018 17:55:17 +0200
Message-Id: <20180413155517.895-1-simon@...2293...>
Subject: [Openvpn-devel] [PATCH] Change quoted to angled form when
 #including external .h files
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

---
 src/openvpn/comp-lz4.c | 2 +-
 src/openvpn/lzo.h      | 8 ++++----
 src/openvpn/memdbg.h   | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index f2916bdd..f52fdbfb 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -35,7 +35,7 @@
 #if defined(NEED_COMPAT_LZ4)
 #include "compat-lz4.h"
 #else
-#include "lz4.h"
+#include <lz4.h>
 #endif
 
 #include "comp.h"
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index 11e1c39f..453cd8ee 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -39,14 +39,14 @@
  */
 
 #if defined(HAVE_LZO_LZOUTIL_H)
-#include "lzo/lzoutil.h"
+#include <lzo/lzoutil.h>
 #elif defined(HAVE_LZOUTIL_H)
-#include "lzoutil.h"
+#include <lzoutil.h>
 #endif
 #if defined(HAVE_LZO_LZO1X_H)
-#include "lzo/lzo1x.h"
+#include <lzo/lzo1x.h>
 #elif defined(HAVE_LZO1X_H)
-#include "lzo1x.h"
+#include <lzo1x.h>
 #endif
 
 #include "buffer.h"
diff --git a/src/openvpn/memdbg.h b/src/openvpn/memdbg.h
index 70c6365d..6da9712b 100644
--- a/src/openvpn/memdbg.h
+++ b/src/openvpn/memdbg.h
@@ -44,7 +44,7 @@
 
 #ifdef USE_VALGRIND
 
-#include "valgrind/memcheck.h"
+#include <valgrind/memcheck.h>
 
 #define VALGRIND_MAKE_READABLE(addr, len)
 
@@ -84,7 +84,7 @@
  *  #define INTERNAL_MEMORY_SPACE (1024 * 1024 * 50)
  */
 
-#include "dmalloc.h"
+#include <dmalloc.h>
 
 #define openvpn_dmalloc(file, line, size) dmalloc_malloc((file), (line), (size), DMALLOC_FUNC_MALLOC, 0, 0)
 
-- 
2.15.1 (Apple Git-101)


