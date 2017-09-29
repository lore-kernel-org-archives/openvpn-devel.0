From: Steffan Karger <steffan@...1856...>
Date: Fri, 29 Sep 2017 18:10:25 +0200
Message-Id: <20170929161025.13654-1-steffan@...1856...>
In-Reply-To: <c0a7b735-640b-23e3-c39f-96e8961fd25c@...2181...>
References: <c0a7b735-640b-23e3-c39f-96e8961fd25c@...2181...>
Subject: [Openvpn-devel] [PATCH v2] create_temp_file/gen_path: prevent
 memory leak if gc == NULL
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

If gc == NULL, the data allocated in the alloc_gc_buf() call in
create_temp_file or the string_mod_const call in gen_path would never
be free'd.

These functions are currently never called that way, but let's prevent
future problems.

While touching create_temp_file, also remove the counter variable, which is
never read.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
v2:
 - change create_temp_file to avoid using a struct buffer (simpler)
 - add gc != NULL check for gen_path (avoid similar memleak pitfall)

 src/openvpn/misc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 90632706..b6f92526 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -723,21 +723,20 @@ test_file(const char *filename)
 const char *
 create_temp_file(const char *directory, const char *prefix, struct gc_arena *gc)
 {
-    static unsigned int counter;
-    struct buffer fname = alloc_buf_gc(256, gc);
     int fd;
     const char *retfname = NULL;
     unsigned int attempts = 0;
+    char fname[256] = { 0 };
 
     do
     {
         ++attempts;
-        ++counter;
 
-        buf_printf(&fname, PACKAGE "_%s_%08lx%08lx.tmp", prefix,
-                   (unsigned long) get_random(), (unsigned long) get_random());
+        openvpn_snprintf(fname, sizeof(fname), PACKAGE "_%s_%08lx%08lx.tmp",
+                         prefix, (unsigned long) get_random(),
+                         (unsigned long) get_random());
 
-        retfname = gen_path(directory, BSTR(&fname), gc);
+        retfname = gen_path(directory, fname, gc);
         if (!retfname)
         {
             msg(M_WARN, "Failed to create temporary filename and path");
@@ -812,6 +811,12 @@ gen_path(const char *directory, const char *filename, struct gc_arena *gc)
 #else
     const int CC_PATH_RESERVED = CC_SLASH;
 #endif
+
+    if (!gc)
+    {
+        return NULL; /* Would leak memory otherwise */
+    }
+
     const char *safe_filename = string_mod_const(filename, CC_PRINT, CC_PATH_RESERVED, '_', gc);
 
     if (safe_filename
-- 
2.11.0


