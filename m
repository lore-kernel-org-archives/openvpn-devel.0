From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 28 Oct 2016 18:42:39 +0200
Message-ID: <1477672963-5724-4-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/7] remove unused system_str from struct
	argv
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

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/argv.c | 86 ------------------------------------------------------
 src/openvpn/argv.h |  1 -
 2 files changed, 87 deletions(-)

diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 89c9b14..a279a40 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -45,7 +45,6 @@ argv_init (struct argv *a)
   a->capacity = 0;
   a->argc = 0;
   a->argv = NULL;
-  a->system_str = NULL;
 }
 
 struct argv
@@ -63,7 +62,6 @@ argv_reset (struct argv *a)
   for (i = 0; i < a->argc; ++i)
     free (a->argv[i]);
   free (a->argv);
-  free (a->system_str);
   argv_init (a);
 }
 
@@ -98,65 +96,6 @@ argv_append (struct argv *a, char *str) /* str must have been malloced or be NUL
   a->argv[a->argc++] = str;
 }
 
-static void
-argv_system_str_append (struct argv *a, const char *str, const bool enquote)
-{
-  if (str)
-    {
-      char *newstr;
-
-      /* compute length of new system_str */
-      size_t l = strlen (str) + 1; /* space for new string plus trailing '\0' */
-      if (a->system_str)
-        l += strlen (a->system_str) + 1; /* space for existing string + space (" ") separator */
-      if (enquote)
-        l += 2; /* space for two quotes */
-
-      /* build new system_str */
-      newstr = (char *) malloc (l);
-      newstr[0] = '\0';
-      check_malloc_return (newstr);
-      if (a->system_str)
-        {
-          strcpy (newstr, a->system_str);
-          strcat (newstr, " ");
-        }
-      if (enquote)
-        strcat (newstr, "\"");
-      strcat (newstr, str);
-      if (enquote)
-        strcat (newstr, "\"");
-      free (a->system_str);
-      a->system_str = newstr;
-    }
-}
-
-static char *
-argv_extract_cmd_name (const char *path)
-{
-  char *ret = NULL;
-  if (path)
-    {
-      char *path_cp = string_alloc(path, NULL); /* POSIX basename() implementaions may modify its arguments */
-      const char *bn = basename (path_cp);
-      if (bn)
-        {
-          char *dot = NULL;
-          ret = string_alloc (bn, NULL);
-          dot = strrchr (ret, '.');
-          if (dot)
-            *dot = '\0';
-          free(path_cp);
-          if (ret[0] == '\0')
-            {
-              free(ret);
-              ret = NULL;
-            }
-        }
-    }
-  return ret;
-}
-
 static struct argv
 argv_clone (const struct argv *a, const size_t headroom)
 {
@@ -170,7 +109,6 @@ argv_clone (const struct argv *a, const size_t headroom)
     {
       for (i = 0; i < a->argc; ++i)
         argv_append (&r, string_alloc (a->argv[i], NULL));
-      r.system_str = string_alloc (a->system_str, NULL);
     }
   return r;
 }
@@ -179,17 +117,8 @@ struct argv
 argv_insert_head (const struct argv *a, const char *head)
 {
   struct argv r;
-  char *s;
-
   r = argv_clone (a, 1);
   r.argv[0] = string_alloc (head, NULL);
-  s = r.system_str;
-  r.system_str = string_alloc (head, NULL);
-  if (s)
-    {
-      argv_system_str_append (&r, s, false);
-      free (s);
-    }
   return r;
 }
 
@@ -285,7 +214,6 @@ argv_printf_arglist (struct argv *a, const char *format, va_list arglist)
               if (!s)
                 s = "";
               argv_append (a, string_alloc (s, NULL));
-              argv_system_str_append (a, s, true);
             }
           else if (!strcmp (term, "%sc"))
             {
@@ -304,13 +232,10 @@ argv_printf_arglist (struct argv *a, const char *format, va_list arglist)
                     }
                   else
                     argv_append (a, string_alloc (s, NULL));
-
-                  argv_system_str_append (a, s, false);
                 }
               else
                 {
                   argv_append (a, string_alloc ("", NULL));
-                  argv_system_str_append (a, "echo", false);
                 }
             }
           else if (!strcmp (term, "%d"))
@@ -318,14 +243,12 @@ argv_printf_arglist (struct argv *a, const char *format, va_list arglist)
               char numstr[64];
               openvpn_snprintf (numstr, sizeof (numstr), "%d", va_arg (arglist, int));
               argv_append (a, string_alloc (numstr, NULL));
-              argv_system_str_append (a, numstr, false);
             }
           else if (!strcmp (term, "%u"))
             {
               char numstr[64];
               openvpn_snprintf (numstr, sizeof (numstr), "%u", va_arg (arglist, unsigned int));
               argv_append (a, string_alloc (numstr, NULL));
-              argv_system_str_append (a, numstr, false);
             }
           else if (!strcmp (term, "%s/%d"))
             {
@@ -346,7 +269,6 @@ argv_printf_arglist (struct argv *a, const char *format, va_list arglist)
                 strcat (combined, "/");
                 strcat (combined, numstr);
                 argv_append (a, combined);
-                argv_system_str_append (a, combined, false);
               }
             }
           else if (!strcmp (term, "%s%sc"))
@@ -363,13 +285,6 @@ argv_printf_arglist (struct argv *a, const char *format, va_list arglist)
               strcpy (combined, s1);
               strcat (combined, s2);
               argv_append (a, combined);
-
-              cmd_name = argv_extract_cmd_name (combined);
-              if (cmd_name)
-                {
-                  argv_system_str_append (a, cmd_name, false);
-                  free (cmd_name);
-                }
             }
           else
             ASSERT (0);
@@ -378,7 +293,6 @@ argv_printf_arglist (struct argv *a, const char *format, va_list arglist)
       else
         {
           argv_append (a, term);
-          argv_system_str_append (a, term, false);
         }
     }
   gc_free (&gc);
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index 5f8e21c..c45bec8 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -37,7 +37,6 @@ struct argv {
   size_t capacity;
   size_t argc;
   char **argv;
-  char *system_str;
 };
 
 struct argv argv_new (void);
-- 
2.7.4


