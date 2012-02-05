From: Adriaan de Jong <dejong@...1435...>
Date: Sun, 5 Feb 2012 12:51:24 +0100
Message-ID: <1328442685-8550-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Moved out of memory prototype to
	error.h, as the definition is in error.c
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

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 buffer.h |    4 +---
 error.h  |    3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/buffer.h b/buffer.h
index e6113f9..6c79007 100644
--- a/buffer.h
+++ b/buffer.h
@@ -26,6 +26,7 @@
 #define BUFFER_H
 
 #include "basic.h"
+#include "error.h"
 
 #define BUF_SIZE_MAX 1000000
 
@@ -810,8 +811,6 @@ gc_reset (struct gc_arena *a)
  * Allocate memory to hold a structure
  */
 
-void out_of_memory (void);
-
 #define ALLOC_OBJ(dptr, type) \
 { \
   check_malloc_return ((dptr) = (type *) malloc (sizeof (type))); \
@@ -862,7 +861,6 @@ void out_of_memory (void);
 static inline void
 check_malloc_return (void *p)
 {
-  void out_of_memory (void);
   if (!p)
     out_of_memory ();
 }
diff --git a/error.h b/error.h
index 13221bd..aafd055 100644
--- a/error.h
+++ b/error.h
@@ -244,6 +244,9 @@ HANDLE get_orig_stderr (void);
 /* exit program */
 void openvpn_exit (const int status);
 
+/* exit program on out of memory error */
+void out_of_memory (void);
+
 /*
  * Check the return status of read/write routines.
  */
-- 
1.7.5.4


