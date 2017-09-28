From: Steffan Karger <steffan@...1856...>
Date: Thu, 28 Sep 2017 17:54:46 +0200
Message-Id: <20170928155446.32382-1-steffan@...1856...>
In-Reply-To: <57ab9396-0960-f915-e1d8-2c4fe0906f2d@...2181...>
References: <57ab9396-0960-f915-e1d8-2c4fe0906f2d@...2181...>
Subject: [Openvpn-devel] [PATCH 3/2] create_temp_file: prevent memory leak
 if gc == NULL
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

If gc == NULL, the data allocated in the alloc_gc_buf() call would never
be free'd.  The function is never called that way, but let's prevent
future problems.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/misc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 90632706..86f80a6a 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -724,10 +724,13 @@ const char *
 create_temp_file(const char *directory, const char *prefix, struct gc_arena *gc)
 {
     static unsigned int counter;
-    struct buffer fname = alloc_buf_gc(256, gc);
     int fd;
     const char *retfname = NULL;
     unsigned int attempts = 0;
+    struct buffer fname = (struct buffer) { 0 };
+    char buf_data[256] = { 0 };
+
+    buf_set_write(&fname, buf_data, sizeof(buf_data));
 
     do
     {
-- 
2.11.0


