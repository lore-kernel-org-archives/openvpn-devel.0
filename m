From: Steffan Karger <steffan@...1856...>
Date: Wed, 21 Jun 2017 23:10:43 +0200
Message-Id: <20170621211043.6490-1-steffan@...1856...>
In-Reply-To: <62da7142-d087-7d89-5974-7533b1be0713@...1856...>
References: <62da7142-d087-7d89-5974-7533b1be0713@...1856...>
Subject: [Openvpn-devel] [PATCH v2] Move adjust_power_of_2() to integer.h
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

From: Steffan Karger <steffan.karger@...1435...>

misc.c is a mess of incoherent functions, and is therefore included by
virtually all our source files.  That makes testing harder than it should
be.  As a first step of cleaning up misc.c, move adjust_power_of_2() to
integer.h, which is a more suitable place for a function like this.

This allows us to remove the duplicate implementation from test_argv.c.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
v2: fix includes, fix typo in commit msg

 src/openvpn/argv.c                   |  1 +
 src/openvpn/integer.h                | 18 ++++++++++++++++++
 src/openvpn/list.c                   |  1 +
 src/openvpn/mbuf.c                   |  1 +
 src/openvpn/misc.c                   | 18 ------------------
 src/openvpn/misc.h                   |  2 --
 tests/unit_tests/openvpn/test_argv.c | 18 ------------------
 7 files changed, 21 insertions(+), 38 deletions(-)

diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index a71d261c..95bdfeac 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -36,6 +36,7 @@
 #include "syshead.h"
 
 #include "argv.h"
+#include "integer.h"
 #include "options.h"
 
 static void
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index 884b849f..600e1384 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -114,6 +114,24 @@ modulo_add(int x, int y, int mod)
     return sum;
 }
 
+/*
+ * Return the next largest power of 2
+ * or u if u is a power of 2.
+ */
+static inline size_t
+adjust_power_of_2(size_t u)
+{
+    size_t ret = 1;
+
+    while (ret < u)
+    {
+        ret <<= 1;
+        ASSERT(ret > 0);
+    }
+
+    return ret;
+}
+
 static inline int
 index_verify(int index, int size, const char *file, int line)
 {
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index edca6f79..91765d20 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -31,6 +31,7 @@
 
 #if P2MP_SERVER
 
+#include "integer.h"
 #include "list.h"
 #include "misc.h"
 
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index fafbce01..f969a2b5 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -33,6 +33,7 @@
 
 #include "buffer.h"
 #include "error.h"
+#include "integer.h"
 #include "misc.h"
 #include "mbuf.h"
 
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 608204ee..0b65e6e2 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1646,24 +1646,6 @@ openvpn_sleep(const int n)
 }
 
 /*
- * Return the next largest power of 2
- * or u if u is a power of 2.
- */
-size_t
-adjust_power_of_2(size_t u)
-{
-    size_t ret = 1;
-
-    while (ret < u)
-    {
-        ret <<= 1;
-        ASSERT(ret > 0);
-    }
-
-    return ret;
-}
-
-/*
  * Remove security-sensitive strings from control message
  * so that they will not be output to log file.
  */
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index d504e68a..c9fa97ab 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -328,8 +328,6 @@ extern const char *iproute_path;
 #define SSEC_PW_ENV    3 /* allow calling of built-in programs and user-defined scripts that may receive a password as an environmental variable */
 extern int script_security; /* GLOBAL */
 
-/* return the next largest power of 2 */
-size_t adjust_power_of_2(size_t u);
 
 #define COMPAT_FLAG_QUERY         0       /** compat_flags operator: Query for a flag */
 #define COMPAT_FLAG_SET           (1<<0)  /** compat_flags operator: Set a compat flag */
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index 8c90eb9c..4a3ba559 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -13,24 +13,6 @@
 #include "argv.h"
 #include "buffer.h"
 
-/*
- * This is defined here to prevent #include'ing misc.h
- * which makes things difficult beyond any recognition
- */
-size_t
-adjust_power_of_2(size_t u)
-{
-    size_t ret = 1;
-
-    while (ret < u)
-    {
-        ret <<= 1;
-        assert(ret > 0);
-    }
-
-    return ret;
-}
-
 /* Defines for use in the tests and the mock parse_line() */
 #define PATH1       "/s p a c e"
 #define PATH2       "/foo bar/baz"
-- 
2.11.0


