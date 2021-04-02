From: Gert Doering <gert@...1296...>
Date: Fri,  2 Apr 2021 19:34:14 +0200
Message-Id: <20210402173414.14216-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix potential NULL ptr crash if compiled
 with DMALLOC
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

In the unlikely case that we are compiled with -DDMALLOC *and*
malloc() returns NULL, there is an uncaught memset() which would
crash then.  Remove the memset(), as the right the next operation
after check_malloc_return() is a mempcy() which will overwrite
the whole memory block anyway.

Trac: #586

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/buffer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 48bf25d5..e7031a4f 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -706,7 +706,6 @@ string_alloc(const char *str, struct gc_arena *gc)
              */
 #ifdef DMALLOC
             ret = openvpn_dmalloc(file, line, n);
-            memset(ret, 0, n);
 #else
             ret = calloc(1, n);
 #endif
-- 
2.26.2


