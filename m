From: Steffan Karger <steffan@...1856...>
Date: Sun, 27 Mar 2016 17:22:10 +0200
Message-Id: <1459092130-19905-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix memory leak in argv_extract_cmd_name()
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

Reported by coverity (in 2009!):

1648 static char *
1649 argv_extract_cmd_name (const char *path)
1650 {
     1. Condition path, taking true branch
1651   if (path)
1652     {
1653       char *path_cp = string_alloc(path, NULL); /* POSIX basename() implementaions may modify its arguments */
1654       const char *bn = basename (path_cp);
     2. Condition bn, taking true branch
1655       if (bn)
1656         {
     3. alloc_fn: Storage is returned from allocation function string_alloc. [show details]
     4. var_assign: Assigning: ret = storage returned from string_alloc(bn, NULL).
1657           char *ret = string_alloc (bn, NULL);
     5. noescape: Resource ret is not freed or pointed-to in strrchr.
1658           char *dot = strrchr (ret, '.');
     6. Condition dot, taking false branch
1659           if (dot)
1660             *dot = '\0';
1661           free(path_cp);
     7. Condition ret[0] != 0, taking false branch
1662           if (ret[0] != '\0')
1663             return ret;
     CID 27023 (#2-1 of 2): Resource leak (RESOURCE_LEAK)8. leaked_storage: Variable ret going out of scope leaks the storage it points to.
1664         }
1665     }
1666   return NULL;
1667 }

This function is only used by argv_printf_arglist(), and in a very specific
case, so it might be that this leak can not even occur.  But coverity is
clearly right that this is a bug, so let's just fix it.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/misc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 05ed073..f76c2e5 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1648,22 +1648,27 @@ argv_system_str_append (struct argv *a, const char *str, const bool enquote)
 static char *
 argv_extract_cmd_name (const char *path)
 {
+  char *ret = NULL;
   if (path)
     {
       char *path_cp = string_alloc(path, NULL); /* POSIX basename() implementaions may modify its arguments */
       const char *bn = basename (path_cp);
       if (bn)
 	{
-	  char *ret = string_alloc (bn, NULL);
-	  char *dot = strrchr (ret, '.');
+	  char *dot = NULL;
+	  ret = string_alloc (bn, NULL);
+	  dot = strrchr (ret, '.');
 	  if (dot)
 	    *dot = '\0';
 	  free(path_cp);
-	  if (ret[0] != '\0')
-	    return ret;
+	  if (ret[0] == '\0')
+	    {
+	      free(ret);
+	      ret = NULL;
+	    }
 	}
     }
-  return NULL;
+  return ret;
 }
 
 const char *
-- 
2.5.0


