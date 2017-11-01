From: Steffan Karger <steffan@...1856...>
Date: Wed,  1 Nov 2017 23:03:42 +0100
Message-Id: <20171101220342.14648-5-steffan@...1856...>
In-Reply-To: <20171101220342.14648-1-steffan@...1856...>
References: <1505424872-27434-1-git-send-email-steffan.karger@...1435...>
 <20171101220342.14648-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 4/4 v3] create_temp_file/gen_path: prevent
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
never read, simplify the do-while to a while loop, and truncate the prefix
(if needed) to preserve the random and extension of the created filename.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
v2:
 - change create_temp_file to avoid using a struct buffer (simpler)
 - add gc != NULL check for gen_path (avoid similar memleak pitfall)
v3:
 - Check the return value of openvpn_snprintf()

 src/openvpn/misc.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 25f38003..67011169 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -723,21 +723,26 @@ test_file(const char *filename)
 const char *
 create_temp_file(const char *directory, const char *prefix, struct gc_arena *gc)
 {
-    static unsigned int counter;
-    struct buffer fname = alloc_buf_gc(256, gc);
     int fd;
     const char *retfname = NULL;
     unsigned int attempts = 0;
+    char fname[256] = { 0 };
+    const char *fname_fmt = PACKAGE "_%.*s_%08lx%08lx.tmp";
+    const int max_prefix_len = sizeof(fname) - (sizeof(PACKAGE) + 7 + (2 * 8));
 
-    do
+    while (attempts < 6)
     {
         ++attempts;
-        ++counter;
 
-        buf_printf(&fname, PACKAGE "_%s_%08lx%08lx.tmp", prefix,
-                   (unsigned long) get_random(), (unsigned long) get_random());
+        if (!openvpn_snprintf(fname, sizeof(fname), fname_fmt, max_prefix_len,
+                              prefix, (unsigned long) get_random(),
+                              (unsigned long) get_random()))
+        {
+            msg(M_WARN, "ERROR: temporary filename too long");
+            return NULL;
+        }
 
-        retfname = gen_path(directory, BSTR(&fname), gc);
+        retfname = gen_path(directory, fname, gc);
         if (!retfname)
         {
             msg(M_WARN, "Failed to create temporary filename and path");
@@ -760,7 +765,6 @@ create_temp_file(const char *directory, const char *prefix, struct gc_arena *gc)
             return NULL;
         }
     }
-    while (attempts < 6);
 
     msg(M_WARN, "Failed to create temporary file after %i attempts", attempts);
     return NULL;
@@ -812,6 +816,12 @@ gen_path(const char *directory, const char *filename, struct gc_arena *gc)
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
2.14.1


