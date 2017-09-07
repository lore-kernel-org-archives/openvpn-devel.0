From: David Sommerseth <davids@...515...>
Date: Thu,  7 Sep 2017 04:28:27 +0200
Message-Id: <20170907022827.10658-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] lz4: Move towards a newer LZ4 API
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

We are using a deprecated function, LZ4_compress_limitedOutput(), which
will be removed with time.  The correct function to use is LZ4_compress_default().
Both function takes the same number of arguments and data types, so the change
is minimal.

To ensure we still build without issues against older LZ4 libraries without
this new API, a simple wrapper function have been added and will only be enabled
if we don't have the proper LZ4 versions, which means versions older than v1.7.0.

This compat API wrapper is currently located in comp-lz4.c, simply because adding
it to compat-lz4.h would mean adding logic to lz4-rebaser.sh to preserve this
wrapper; lz4-rebaser.sh will overwrite compat-lz4.[ch].  I didn't see any other
files where it would make reasonable sense to add it.  And it seemed overkill
to add a completely new file to support a single file which would basically carry
8 lines of code for a function only used comp-lz4.c.  In addition, adding new
files means Makefile.am files needs to be updated accordingly and the new
header file would be required to be included in comp-lz4.c.  So, placing it
in comp-lz4.c seemed to be the best fit, and it is closely tied to where it
is used so it won't be that easy to just ignore it later on.

This patch is a result of the discussions in this mail thread:
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg14135.html

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/comp-lz4.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index e056caa8..ad95968a 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -43,6 +43,17 @@
 
 #include "memdbg.h"
 
+
+#if defined(LZ4_VERSION_NUMBER) && LZ4_VERSION_NUMBER < 10700
+/* Wrapper to re-enable the old API if LZ4 is older than v1.7.0 */
+static int
+LZ4_compress_default(const char* source, char* dest, int inputSize, int maxOutputSize)
+{
+    return LZ4_compress_limitedOutput(source, dest, inputSize, maxOutputSize);
+}
+#endif
+
+
 static void
 lz4_compress_init(struct compress_context *compctx)
 {
@@ -86,7 +97,7 @@ do_lz4_compress(struct buffer *buf,
             return false;
         }
 
-        zlen = LZ4_compress_limitedOutput((const char *)BPTR(buf), (char *)BPTR(work), BLEN(buf), zlen_max );
+        zlen = LZ4_compress_default((const char *)BPTR(buf), (char *)BPTR(work), BLEN(buf), zlen_max );
 
         if (zlen <= 0)
         {
-- 
2.13.5


