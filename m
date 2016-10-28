From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 28 Oct 2016 18:42:37 +0200
Message-ID: <1477672963-5724-2-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/7] put argv_* functions into own file,
	add unit tests
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

misc.c is too crowded with different things to perform any
sane unit testing due to its dependencies. So, in order to re-write
the #ifdef'ed tests for the argv_* family of functions into unit
tests I moved them into a dedicated file.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 configure.ac                         |   1 +
 src/openvpn/Makefile.am              |   1 +
 src/openvpn/argv.c                   | 412 +++++++++++++++++++++++++++++++
 src/openvpn/argv.h                   |  76 ++++++
 src/openvpn/misc.c                   | 459 -----------------------------------
 src/openvpn/misc.h                   |  48 +---
 tests/unit_tests/Makefile.am         |   2 +-
 tests/unit_tests/openvpn/Makefile.am |  15 ++
 tests/unit_tests/openvpn/test_argv.c | 194 +++++++++++++++
 9 files changed, 701 insertions(+), 507 deletions(-)
 create mode 100644 src/openvpn/argv.c
 create mode 100644 src/openvpn/argv.h
 create mode 100644 tests/unit_tests/openvpn/Makefile.am
 create mode 100644 tests/unit_tests/openvpn/test_argv.c

diff --git a/configure.ac b/configure.ac
index 357ba29..a42257a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1273,6 +1273,7 @@ AC_CONFIG_FILES([
         tests/unit_tests/plugins/Makefile
         tests/unit_tests/plugins/auth-pam/Makefile
         tests/unit_tests/example_test/Makefile
+        tests/unit_tests/openvpn/Makefile
         vendor/Makefile
 	sample/Makefile
 	doc/Makefile
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index a306726..12b9ebf 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -36,6 +36,7 @@ endif
 sbin_PROGRAMS = openvpn
 
 openvpn_SOURCES = \
+	argv.c argv.h \
 	base64.c base64.h \
 	basic.h \
 	buffer.c buffer.h \
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
new file mode 100644
index 0000000..60534ac
--- /dev/null
+++ b/src/openvpn/argv.c
@@ -0,0 +1,412 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *
+ *  A printf-like function (that only recognizes a subset of standard printf
+ *  format operators) that prints arguments to an argv list instead
+ *  of a standard string.  This is used to build up argv arrays for passing
+ *  to execve.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#include "argv.h"
+#include "options.h"
+
+void
+argv_init (struct argv *a)
+{
+  a->capacity = 0;
+  a->argc = 0;
+  a->argv = NULL;
+  a->system_str = NULL;
+}
+
+struct argv
+argv_new (void)
+{
+  struct argv ret;
+  argv_init (&ret);
+  return ret;
+}
+
+void
+argv_reset (struct argv *a)
+{
+  size_t i;
+  for (i = 0; i < a->argc; ++i)
+    free (a->argv[i]);
+  free (a->argv);
+  free (a->system_str);
+  argv_init (a);
+}
+
+static void
+argv_extend (struct argv *a, const size_t newcap)
+{
+  if (newcap > a->capacity)
+    {
+      char **newargv;
+      size_t i;
+      ALLOC_ARRAY_CLEAR (newargv, char *, newcap);
+      for (i = 0; i < a->argc; ++i)
+        newargv[i] = a->argv[i];
+      free (a->argv);
+      a->argv = newargv;
+      a->capacity = newcap;
+    }
+}
+
+static void
+argv_grow (struct argv *a, const size_t add)
+{
+  const size_t newargc = a->argc + add + 1;
+  ASSERT (newargc > a->argc);
+  argv_extend (a, adjust_power_of_2 (newargc));
+}
+
+static void
+argv_append (struct argv *a, char *str) /* str must have been malloced or be NULL */
+{
+  argv_grow (a, 1);
+  a->argv[a->argc++] = str;
+}
+
+static void
+argv_system_str_append (struct argv *a, const char *str, const bool enquote)
+{
+  if (str)
+    {
+      char *newstr;
+
+      /* compute length of new system_str */
+      size_t l = strlen (str) + 1; /* space for new string plus trailing '\0' */
+      if (a->system_str)
+        l += strlen (a->system_str) + 1; /* space for existing string + space (" ") separator */
+      if (enquote)
+        l += 2; /* space for two quotes */
+
+      /* build new system_str */
+      newstr = (char *) malloc (l);
+      newstr[0] = '\0';
+      check_malloc_return (newstr);
+      if (a->system_str)
+        {
+          strcpy (newstr, a->system_str);
+          strcat (newstr, " ");
+        }
+      if (enquote)
+        strcat (newstr, "\"");
+      strcat (newstr, str);
+      if (enquote)
+        strcat (newstr, "\"");
+      free (a->system_str);
+      a->system_str = newstr;
+    }
+}
+
+static char *
+argv_extract_cmd_name (const char *path)
+{
+  char *ret = NULL;
+  if (path)
+    {
+      char *path_cp = string_alloc(path, NULL); /* POSIX basename() implementaions may modify its arguments */
+      const char *bn = basename (path_cp);
+      if (bn)
+        {
+          char *dot = NULL;
+          ret = string_alloc (bn, NULL);
+          dot = strrchr (ret, '.');
+          if (dot)
+            *dot = '\0';
+          free(path_cp);
+          if (ret[0] == '\0')
+            {
+              free(ret);
+              ret = NULL;
+            }
+        }
+    }
+  return ret;
+}
+
+const char *
+argv_system_str (const struct argv *a)
+{
+  return a->system_str;
+}
+
+static struct argv
+argv_clone (const struct argv *a, const size_t headroom)
+{
+  struct argv r;
+  size_t i;
+
+  argv_init (&r);
+  for (i = 0; i < headroom; ++i)
+    argv_append (&r, NULL);
+  if (a)
+    {
+      for (i = 0; i < a->argc; ++i)
+        argv_append (&r, string_alloc (a->argv[i], NULL));
+      r.system_str = string_alloc (a->system_str, NULL);
+    }
+  return r;
+}
+
+struct argv
+argv_insert_head (const struct argv *a, const char *head)
+{
+  struct argv r;
+  char *s;
+
+  r = argv_clone (a, 1);
+  r.argv[0] = string_alloc (head, NULL);
+  s = r.system_str;
+  r.system_str = string_alloc (head, NULL);
+  if (s)
+    {
+      argv_system_str_append (&r, s, false);
+      free (s);
+    }
+  return r;
+}
+
+char *
+argv_term (const char **f)
+{
+  const char *p = *f;
+  const char *term = NULL;
+  size_t termlen = 0;
+
+  if (*p == '\0')
+    return NULL;
+
+  while (true)
+    {
+      const int c = *p;
+      if (c == '\0')
+        break;
+      if (term)
+        {
+          if (!isspace (c))
+            ++termlen;
+          else
+            break;
+        }
+      else
+        {
+          if (!isspace (c))
+            {
+              term = p;
+              termlen = 1;
+            }
+        }
+      ++p;
+    }
+  *f = p;
+
+  if (term)
+    {
+      char *ret;
+      ASSERT (termlen > 0);
+      ret = malloc (termlen + 1);
+      check_malloc_return (ret);
+      memcpy (ret, term, termlen);
+      ret[termlen] = '\0';
+      return ret;
+    }
+  else
+    return NULL;
+}
+
+const char *
+argv_str (const struct argv *a, struct gc_arena *gc, const unsigned int flags)
+{
+  if (a->argv)
+    return print_argv ((const char **)a->argv, gc, flags);
+  else
+    return "";
+}
+
+void
+argv_msg (const int msglev, const struct argv *a)
+{
+  struct gc_arena gc = gc_new ();
+  msg (msglev, "%s", argv_str (a, &gc, 0));
+  gc_free (&gc);
+}
+
+void
+argv_msg_prefix (const int msglev, const struct argv *a, const char *prefix)
+{
+  struct gc_arena gc = gc_new ();
+  msg (msglev, "%s: %s", prefix, argv_str (a, &gc, 0));
+  gc_free (&gc);
+}
+
+void
+argv_printf (struct argv *a, const char *format, ...)
+{
+  va_list arglist;
+  va_start (arglist, format);
+  argv_printf_arglist (a, format, 0, arglist);
+  va_end (arglist);
+ }
+
+void
+argv_printf_cat (struct argv *a, const char *format, ...)
+{
+  va_list arglist;
+  va_start (arglist, format);
+  argv_printf_arglist (a, format, APA_CAT, arglist);
+  va_end (arglist);
+}
+
+void
+argv_printf_arglist (struct argv *a, const char *format, const unsigned int flags, va_list arglist)
+{
+  struct gc_arena gc = gc_new ();
+  char *term;
+  const char *f = format;
+
+  if (!(flags & APA_CAT))
+    argv_reset (a);
+  argv_extend (a, 1); /* ensure trailing NULL */
+
+  while ((term = argv_term (&f)) != NULL)
+    {
+      if (term[0] == '%')
+        {
+          if (!strcmp (term, "%s"))
+            {
+              char *s = va_arg (arglist, char *);
+              if (!s)
+                s = "";
+              argv_append (a, string_alloc (s, NULL));
+              argv_system_str_append (a, s, true);
+            }
+          else if (!strcmp (term, "%sc"))
+            {
+              char *s = va_arg (arglist, char *);
+              if (s)
+                {
+                  int nparms;
+                  char *parms[MAX_PARMS+1];
+                  int i;
+
+                  nparms = parse_line (s, parms, MAX_PARMS, "SCRIPT-ARGV", 0, D_ARGV_PARSE_CMD, &gc);
+                  if (nparms)
+                    {
+                      for (i = 0; i < nparms; ++i)
+                        argv_append (a, string_alloc (parms[i], NULL));
+                    }
+                  else
+                    argv_append (a, string_alloc (s, NULL));
+
+                  argv_system_str_append (a, s, false);
+                }
+              else
+                {
+                  argv_append (a, string_alloc ("", NULL));
+                  argv_system_str_append (a, "echo", false);
+                }
+            }
+          else if (!strcmp (term, "%d"))
+            {
+              char numstr[64];
+              openvpn_snprintf (numstr, sizeof (numstr), "%d", va_arg (arglist, int));
+              argv_append (a, string_alloc (numstr, NULL));
+              argv_system_str_append (a, numstr, false);
+            }
+          else if (!strcmp (term, "%u"))
+            {
+              char numstr[64];
+              openvpn_snprintf (numstr, sizeof (numstr), "%u", va_arg (arglist, unsigned int));
+              argv_append (a, string_alloc (numstr, NULL));
+              argv_system_str_append (a, numstr, false);
+            }
+          else if (!strcmp (term, "%s/%d"))
+            {
+              char numstr[64];
+              char *s = va_arg (arglist, char *);
+
+              if (!s)
+                s = "";
+
+              openvpn_snprintf (numstr, sizeof (numstr), "%d", va_arg (arglist, int));
+
+              {
+                const size_t len = strlen(s) + strlen(numstr) + 2;
+                char *combined = (char *) malloc (len);
+                check_malloc_return (combined);
+
+                strcpy (combined, s);
+                strcat (combined, "/");
+                strcat (combined, numstr);
+                argv_append (a, combined);
+                argv_system_str_append (a, combined, false);
+              }
+            }
+          else if (!strcmp (term, "%s%sc"))
+            {
+              char *s1 = va_arg (arglist, char *);
+              char *s2 = va_arg (arglist, char *);
+              char *combined;
+              char *cmd_name;
+
+              if (!s1) s1 = "";
+              if (!s2) s2 = "";
+              combined = (char *) malloc (strlen(s1) + strlen(s2) + 1);
+              check_malloc_return (combined);
+              strcpy (combined, s1);
+              strcat (combined, s2);
+              argv_append (a, combined);
+
+              cmd_name = argv_extract_cmd_name (combined);
+              if (cmd_name)
+                {
+                  argv_system_str_append (a, cmd_name, false);
+                  free (cmd_name);
+                }
+            }
+          else
+            ASSERT (0);
+          free (term);
+        }
+      else
+        {
+          argv_append (a, term);
+          argv_system_str_append (a, term, false);
+        }
+    }
+  gc_free (&gc);
+}
+
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
new file mode 100644
index 0000000..df658a0
--- /dev/null
+++ b/src/openvpn/argv.h
@@ -0,0 +1,76 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ *
+ *  A printf-like function (that only recognizes a subset of standard printf
+ *  format operators) that prints arguments to an argv list instead
+ *  of a standard string.  This is used to build up argv arrays for passing
+ *  to execve.
+ */
+
+#ifndef ARGV_H
+#define ARGV_H
+
+#include "buffer.h"
+
+struct argv {
+  size_t capacity;
+  size_t argc;
+  char **argv;
+  char *system_str;
+};
+
+void argv_init (struct argv *a);
+struct argv argv_new (void);
+void argv_reset (struct argv *a);
+char *argv_term (const char **f);
+const char *argv_str (const struct argv *a, struct gc_arena *gc, const unsigned int flags);
+struct argv argv_insert_head (const struct argv *a, const char *head);
+void argv_msg (const int msglev, const struct argv *a);
+void argv_msg_prefix (const int msglev, const struct argv *a, const char *prefix);
+const char *argv_system_str (const struct argv *a);
+
+#define APA_CAT (1<<0) /* concatentate onto existing struct argv list */
+void argv_printf_arglist (struct argv *a, const char *format, const unsigned int flags, va_list arglist);
+
+void argv_printf (struct argv *a, const char *format, ...)
+#ifdef __GNUC__
+#if __USE_MINGW_ANSI_STDIO
+        __attribute__ ((format (gnu_printf, 2, 3)))
+#else
+        __attribute__ ((format (__printf__, 2, 3)))
+#endif
+#endif
+  ;
+
+void argv_printf_cat (struct argv *a, const char *format, ...)
+#ifdef __GNUC__
+#if __USE_MINGW_ANSI_STDIO
+        __attribute__ ((format (gnu_printf, 2, 3)))
+#else
+        __attribute__ ((format (__printf__, 2, 3)))
+#endif
+#endif
+  ;
+
+#endif
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 225f0bf..af362e9 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1588,465 +1588,6 @@ adjust_power_of_2 (size_t u)
 }
 
 /*
- * A printf-like function (that only recognizes a subset of standard printf
- * format operators) that prints arguments to an argv list instead
- * of a standard string.  This is used to build up argv arrays for passing
- * to execve.
- */
-
-void
-argv_init (struct argv *a)
-{
-  a->capacity = 0;
-  a->argc = 0;
-  a->argv = NULL;
-  a->system_str = NULL;
-}
-
-struct argv
-argv_new (void)
-{
-  struct argv ret;
-  argv_init (&ret);
-  return ret;
-}
-
-void
-argv_reset (struct argv *a)
-{
-  size_t i;
-  for (i = 0; i < a->argc; ++i)
-    free (a->argv[i]);
-  free (a->argv);
-  free (a->system_str);
-  argv_init (a);
-}
-
-static void
-argv_extend (struct argv *a, const size_t newcap)
-{
-  if (newcap > a->capacity)
-    {
-      char **newargv;
-      size_t i;
-      ALLOC_ARRAY_CLEAR (newargv, char *, newcap);
-      for (i = 0; i < a->argc; ++i)
-	newargv[i] = a->argv[i];
-      free (a->argv);
-      a->argv = newargv;
-      a->capacity = newcap;
-    }
-}
-
-static void
-argv_grow (struct argv *a, const size_t add)
-{
-  const size_t newargc = a->argc + add + 1;
-  ASSERT (newargc > a->argc);
-  argv_extend (a, adjust_power_of_2 (newargc));
-}
-
-static void
-argv_append (struct argv *a, char *str) /* str must have been malloced or be NULL */
-{
-  argv_grow (a, 1);
-  a->argv[a->argc++] = str;
-}
-
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
-	l += strlen (a->system_str) + 1; /* space for existing string + space (" ") separator */
-      if (enquote)
-	l += 2; /* space for two quotes */
-
-      /* build new system_str */
-      newstr = (char *) malloc (l);
-      newstr[0] = '\0';
-      check_malloc_return (newstr);
-      if (a->system_str)
-	{
-	  strcpy (newstr, a->system_str);
-	  strcat (newstr, " ");
-	}
-      if (enquote)
-	strcat (newstr, "\"");
-      strcat (newstr, str);
-      if (enquote)
-	strcat (newstr, "\"");
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
-	{
-	  char *dot = NULL;
-	  ret = string_alloc (bn, NULL);
-	  dot = strrchr (ret, '.');
-	  if (dot)
-	    *dot = '\0';
-	  free(path_cp);
-	  if (ret[0] == '\0')
-	    {
-	      free(ret);
-	      ret = NULL;
-	    }
-	}
-    }
-  return ret;
-}
-
-const char *
-argv_system_str (const struct argv *a)
-{
-  return a->system_str;
-}
-
-struct argv
-argv_clone (const struct argv *a, const size_t headroom)
-{
-  struct argv r;
-  size_t i;
-
-  argv_init (&r);
-  for (i = 0; i < headroom; ++i)
-    argv_append (&r, NULL);
-  if (a)
-    {
-      for (i = 0; i < a->argc; ++i)
-	argv_append (&r, string_alloc (a->argv[i], NULL));
-      r.system_str = string_alloc (a->system_str, NULL);
-    }
-  return r;
-}
-
-struct argv
-argv_insert_head (const struct argv *a, const char *head)
-{
-  struct argv r;
-  char *s;
-
-  r = argv_clone (a, 1);
-  r.argv[0] = string_alloc (head, NULL);
-  s = r.system_str;
-  r.system_str = string_alloc (head, NULL);
-  if (s)
-    {
-      argv_system_str_append (&r, s, false);
-      free (s);
-    }
-  return r;
-}
-
-char *
-argv_term (const char **f)
-{
-  const char *p = *f;
-  const char *term = NULL;
-  size_t termlen = 0;
-
-  if (*p == '\0')
-    return NULL;
-
-  while (true)
-    {
-      const int c = *p;
-      if (c == '\0')
-	break;
-      if (term)
-	{
-	  if (!isspace (c))
-	    ++termlen;
-	  else
-	    break;
-	}
-      else
-	{
-	  if (!isspace (c))
-	    {
-	      term = p;
-	      termlen = 1;
-	    }
-	}
-      ++p;
-    }
-  *f = p;
-
-  if (term)
-    {
-      char *ret;
-      ASSERT (termlen > 0);
-      ret = malloc (termlen + 1);
-      check_malloc_return (ret);
-      memcpy (ret, term, termlen);
-      ret[termlen] = '\0';
-      return ret;
-    }
-  else
-    return NULL;
-}
-
-const char *
-argv_str (const struct argv *a, struct gc_arena *gc, const unsigned int flags)
-{
-  if (a->argv)
-    return print_argv ((const char **)a->argv, gc, flags);
-  else
-    return "";
-}
-
-void
-argv_msg (const int msglev, const struct argv *a)
-{
-  struct gc_arena gc = gc_new ();
-  msg (msglev, "%s", argv_str (a, &gc, 0));
-  gc_free (&gc);
-}
-
-void
-argv_msg_prefix (const int msglev, const struct argv *a, const char *prefix)
-{
-  struct gc_arena gc = gc_new ();
-  msg (msglev, "%s: %s", prefix, argv_str (a, &gc, 0));
-  gc_free (&gc);
-}
-
-void
-argv_printf (struct argv *a, const char *format, ...)
-{
-  va_list arglist;
-  va_start (arglist, format);
-  argv_printf_arglist (a, format, 0, arglist);
-  va_end (arglist);
- }
-
-void
-argv_printf_cat (struct argv *a, const char *format, ...)
-{
-  va_list arglist;
-  va_start (arglist, format);
-  argv_printf_arglist (a, format, APA_CAT, arglist);
-  va_end (arglist);
-}
-
-void
-argv_printf_arglist (struct argv *a, const char *format, const unsigned int flags, va_list arglist)
-{
-  struct gc_arena gc = gc_new ();
-  char *term;
-  const char *f = format;
-
-  if (!(flags & APA_CAT))
-    argv_reset (a);
-  argv_extend (a, 1); /* ensure trailing NULL */
-
-  while ((term = argv_term (&f)) != NULL) 
-    {
-      if (term[0] == '%')
-	{
-	  if (!strcmp (term, "%s"))
-	    {
-	      char *s = va_arg (arglist, char *);
-	      if (!s)
-		s = "";
-	      argv_append (a, string_alloc (s, NULL));
-	      argv_system_str_append (a, s, true);
-	    }
-	  else if (!strcmp (term, "%sc"))
-	    {
-	      char *s = va_arg (arglist, char *);
-	      if (s)
-		{
-		  int nparms;
-		  char *parms[MAX_PARMS+1];
-		  int i;
-
-		  nparms = parse_line (s, parms, MAX_PARMS, "SCRIPT-ARGV", 0, D_ARGV_PARSE_CMD, &gc);
-		  if (nparms)
-		    {
-		      for (i = 0; i < nparms; ++i)
-			argv_append (a, string_alloc (parms[i], NULL));
-		    }
-		  else
-		    argv_append (a, string_alloc (s, NULL));
-
-		  argv_system_str_append (a, s, false);
-		}
-	      else
-		{
-		  argv_append (a, string_alloc ("", NULL));
-		  argv_system_str_append (a, "echo", false);
-		}
-	    }
-	  else if (!strcmp (term, "%d"))
-	    {
-	      char numstr[64];
-	      openvpn_snprintf (numstr, sizeof (numstr), "%d", va_arg (arglist, int));
-	      argv_append (a, string_alloc (numstr, NULL));
-	      argv_system_str_append (a, numstr, false);
-	    }
-	  else if (!strcmp (term, "%u"))
-	    {
-	      char numstr[64];
-	      openvpn_snprintf (numstr, sizeof (numstr), "%u", va_arg (arglist, unsigned int));
-	      argv_append (a, string_alloc (numstr, NULL));
-	      argv_system_str_append (a, numstr, false);
-	    }
-	  else if (!strcmp (term, "%s/%d"))
-	    {
-	      char numstr[64];
-	      char *s = va_arg (arglist, char *);
-
-	      if (!s)
-		s = "";
-
-	      openvpn_snprintf (numstr, sizeof (numstr), "%d", va_arg (arglist, int));
-
-	      {
-		const size_t len = strlen(s) + strlen(numstr) + 2;
-		char *combined = (char *) malloc (len);
-		check_malloc_return (combined);
-
-		strcpy (combined, s);
-		strcat (combined, "/");
-		strcat (combined, numstr);
-		argv_append (a, combined);
-		argv_system_str_append (a, combined, false);
-	      }
-	    }
-	  else if (!strcmp (term, "%s%sc"))
-	    {
-	      char *s1 = va_arg (arglist, char *);
-	      char *s2 = va_arg (arglist, char *);
-	      char *combined;
-	      char *cmd_name;
-
-	      if (!s1) s1 = "";
-	      if (!s2) s2 = "";
-	      combined = (char *) malloc (strlen(s1) + strlen(s2) + 1);
-	      check_malloc_return (combined);
-	      strcpy (combined, s1);
-	      strcat (combined, s2);
-	      argv_append (a, combined);
-
-	      cmd_name = argv_extract_cmd_name (combined);
-	      if (cmd_name)
-		{
-		  argv_system_str_append (a, cmd_name, false);
-		  free (cmd_name);
-		}
-	    }
-	  else
-	    ASSERT (0);
-	  free (term);
-	}
-      else
-	{
-	  argv_append (a, term);
-	  argv_system_str_append (a, term, false);
-	}
-    }
-  gc_free (&gc);
-}
-
-#ifdef ARGV_TEST
-void
-argv_test (void)
-{
-  struct gc_arena gc = gc_new ();
-  const char *s;
-
-  struct argv a;
-
-  argv_init (&a);
-  argv_printf (&a, "%sc foo bar %s", "c:\\\\src\\\\test\\\\jyargs.exe", "foo bar");
-  argv_msg_prefix (M_INFO, &a, "ARGV");
-  msg (M_INFO, "ARGV-S: %s", argv_system_str(&a));
-  /*openvpn_execve_check (&a, NULL, 0, "command failed");*/
-
-  argv_printf (&a, "%sc %s %s", "c:\\\\src\\\\test files\\\\batargs.bat", "foo", "bar");  
-  argv_msg_prefix (M_INFO, &a, "ARGV");
-  msg (M_INFO, "ARGV-S: %s", argv_system_str(&a));
-  /*openvpn_execve_check (&a, NULL, 0, "command failed");*/
-
-  argv_printf (&a, "%s%sc foo bar %s %s/%d %d %u", "/foo", "/bar.exe", "one two", "1.2.3.4", 24, -69, 96);
-  argv_msg_prefix (M_INFO, &a, "ARGV");
-  msg (M_INFO, "ARGV-S: %s", argv_system_str(&a));
-  /*openvpn_execve_check (&a, NULL, 0, "command failed");*/
-
-  argv_printf (&a, "this is a %s test of int %d unsigned %u", "FOO", -69, 42);
-  s = argv_str (&a, &gc, PA_BRACKET);
-  printf ("PF: %s\n", s);
-  printf ("PF-S: %s\n", argv_system_str(&a));
-
-  {
-    struct argv b = argv_insert_head (&a, "MARK");
-    s = argv_str (&b, &gc, PA_BRACKET);
-    printf ("PF: %s\n", s);
-    printf ("PF-S: %s\n", argv_system_str(&b));
-    argv_reset (&b);
-  }
-
-  argv_printf (&a, "%sc foo bar %d", "\"multi term\" command      following \\\"spaces", 99);
-  s = argv_str (&a, &gc, PA_BRACKET);
-  printf ("PF: %s\n", s);
-  printf ("PF-S: %s\n", argv_system_str(&a));
-  argv_reset (&a);
-
-  s = argv_str (&a, &gc, PA_BRACKET);
-  printf ("PF: %s\n", s);
-  printf ("PF-S: %s\n", argv_system_str(&a));
-  argv_reset (&a);
-
-  argv_printf (&a, "foo bar %d", 99);
-  argv_printf_cat (&a, "bar %d foo %sc", 42, "nonesuch");
-  argv_printf_cat (&a, "cool %s %d u %s/%d end", "frood", 4, "hello", 7);
-  s = argv_str (&a, &gc, PA_BRACKET);
-  printf ("PF: %s\n", s);
-  printf ("PF-S: %s\n", argv_system_str(&a));
-  argv_reset (&a);
-
-#if 0
-  {
-    char line[512];
-    while (fgets (line, sizeof(line), stdin) != NULL)
-      {
-	char *term;
-	const char *f = line;
-	int i = 0;
-
-	while ((term = argv_term (&f)) != NULL) 
-	  {
-	    printf ("[%d] '%s'\n", i, term);
-	    ++i;
-	    free (term);
-	  }
-      }
-  }
-#endif
-
-  argv_reset (&a);
-  gc_free (&gc);
-}
-#endif
-
-/*
  * Remove security-sensitive strings from control message
  * so that they will not be output to log file.
  */
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index b694096..ceda323 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -25,6 +25,7 @@
 #ifndef MISC_H
 #define MISC_H
 
+#include "argv.h"
 #include "basic.h"
 #include "common.h"
 #include "integer.h"
@@ -37,14 +38,6 @@
 /* forward declarations */
 struct plugin_list;
 
-/* used by argv_x functions */
-struct argv {
-  size_t capacity;
-  size_t argc;
-  char **argv;
-  char *system_str;
-};
-
 /*
  * Handle environmental variable lists
  */
@@ -325,45 +318,6 @@ extern int script_security; /* GLOBAL */
 /* return the next largest power of 2 */
 size_t adjust_power_of_2 (size_t u);
 
-/*
- * A printf-like function (that only recognizes a subset of standard printf
- * format operators) that prints arguments to an argv list instead
- * of a standard string.  This is used to build up argv arrays for passing
- * to execve.
- */
-void argv_init (struct argv *a);
-struct argv argv_new (void);
-void argv_reset (struct argv *a);
-char *argv_term (const char **f);
-const char *argv_str (const struct argv *a, struct gc_arena *gc, const unsigned int flags);
-struct argv argv_insert_head (const struct argv *a, const char *head);
-void argv_msg (const int msglev, const struct argv *a);
-void argv_msg_prefix (const int msglev, const struct argv *a, const char *prefix);
-const char *argv_system_str (const struct argv *a);
-
-#define APA_CAT (1<<0) /* concatentate onto existing struct argv list */
-void argv_printf_arglist (struct argv *a, const char *format, const unsigned int flags, va_list arglist);
-
-void argv_printf (struct argv *a, const char *format, ...)
-#ifdef __GNUC__
-#if __USE_MINGW_ANSI_STDIO
-	__attribute__ ((format (gnu_printf, 2, 3)))
-#else
-	__attribute__ ((format (__printf__, 2, 3)))
-#endif
-#endif
-  ;
-
-void argv_printf_cat (struct argv *a, const char *format, ...)
-#ifdef __GNUC__
-#if __USE_MINGW_ANSI_STDIO
-	__attribute__ ((format (gnu_printf, 2, 3)))
-#else
-	__attribute__ ((format (__printf__, 2, 3)))
-#endif
-#endif
-  ;
-
 #define COMPAT_FLAG_QUERY         0       /** compat_flags operator: Query for a flag */
 #define COMPAT_FLAG_SET           (1<<0)  /** compat_flags operator: Set a compat flag */
 #define COMPAT_NAMES              (1<<1)  /** compat flag: --compat-names set */
diff --git a/tests/unit_tests/Makefile.am b/tests/unit_tests/Makefile.am
index 8868c1c..44ab26b 100644
--- a/tests/unit_tests/Makefile.am
+++ b/tests/unit_tests/Makefile.am
@@ -1,5 +1,5 @@
 AUTOMAKE_OPTIONS = foreign
 
 if CMOCKA_INITIALIZED
-SUBDIRS = example_test plugins
+SUBDIRS = example_test plugins openvpn
 endif
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
new file mode 100644
index 0000000..af7f12f
--- /dev/null
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -0,0 +1,15 @@
+AUTOMAKE_OPTIONS = foreign
+
+check_PROGRAMS = argv_testdriver
+
+TESTS = $(check_PROGRAMS)
+
+openvpn_srcdir = $(top_srcdir)/src/openvpn
+compat_srcdir = $(top_srcdir)/src/compat
+
+argv_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_srcdir)
+argv_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wrap=parse_line
+argv_testdriver_SOURCES = test_argv.c \
+	$(openvpn_srcdir)/platform.c \
+	$(openvpn_srcdir)/buffer.c \
+	$(openvpn_srcdir)/argv.c
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
new file mode 100644
index 0000000..f07a5fb
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -0,0 +1,194 @@
+#include "config.h"
+#include "syshead.h"
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <setjmp.h>
+#include <cmocka.h>
+#include <assert.h>
+
+#include "argv.h"
+#include "buffer.h"
+
+/*
+ * Dummy symbols that need to be defined due to them being
+ * referenced in #include'd header files and their includes
+ */
+unsigned int x_debug_level;
+bool dont_mute (unsigned int flags) { return true; }
+void assert_failed (const char *filename, int line, const char *condition) { exit(0); }
+void out_of_memory (void) { }
+void x_msg (const unsigned int flags, const char *format, ...) { }
+
+/*
+ * This is defined here to prevent #include'ing misc.h
+ * which makes things difficult beyond any recognition
+ */
+size_t
+adjust_power_of_2 (size_t u)
+{
+  size_t ret = 1;
+
+  while (ret < u)
+    {
+      ret <<= 1;
+      assert (ret > 0);
+    }
+
+  return ret;
+}
+
+/* Defines for use in the tests and the mock parse_line() */
+#define PATH1       "/s p a c e"
+#define PATH2       "/foo bar/baz"
+#define PARAM1      "param1"
+#define PARAM2      "param two"
+#define SCRIPT_CMD  "\"" PATH1 PATH2 "\"" PARAM1 "\"" PARAM2 "\""
+
+int
+__wrap_parse_line (const char *line, char **p, const int n, const char *file,
+                   const int line_num, int msglevel, struct gc_arena *gc)
+{
+  p[0] = PATH1 PATH2;
+  p[1] = PARAM1;
+  p[2] = PARAM2;
+  return 3;
+}
+
+static void
+argv_printf__multiple_spaces_in_format__parsed_as_one (void **state)
+{
+  struct argv a = argv_new ();
+
+  argv_printf (&a, "    %s     %s  %d   ", PATH1, PATH2, 42);
+  assert_int_equal (a.argc, 3);
+
+  argv_reset (&a);
+}
+
+static void
+argv_printf_cat__multiple_spaces_in_format__parsed_as_one (void **state)
+{
+  struct argv a = argv_new ();
+
+  argv_printf (&a, "%s ", PATH1);
+  argv_printf_cat (&a, " %s  %s", PATH2, PARAM1);
+  assert_int_equal (a.argc, 3);
+
+  argv_reset (&a);
+}
+
+static void
+argv_printf__combined_path_with_spaces__argc_correct (void **state)
+{
+  struct argv a = argv_new ();
+
+  argv_printf (&a, "%s%sc", PATH1, PATH2);
+  assert_int_equal (a.argc, 1);
+
+  argv_printf (&a, "%s%sc %d", PATH1, PATH2, 42);
+  assert_int_equal (a.argc, 2);
+
+  argv_printf (&a, "foo %s%sc %s x y", PATH2, PATH1, "foo");
+  assert_int_equal (a.argc, 5);
+
+  argv_reset (&a);
+}
+
+static void
+argv_printf__script_command__argc_correct (void **state)
+{
+  struct argv a = argv_new ();
+
+  argv_printf (&a, "%sc", SCRIPT_CMD);
+  assert_int_equal (a.argc, 3);
+
+  argv_printf (&a, "bar baz %sc %d %s", SCRIPT_CMD, 42, PATH1);
+  assert_int_equal (a.argc, 7);
+
+  argv_reset (&a);
+}
+
+static void
+argv_printf_cat__used_twice__argc_correct (void **state)
+{
+  struct argv a = argv_new ();
+
+  argv_printf (&a, "%s %s %s", PATH1, PATH2, PARAM1);
+  argv_printf_cat (&a, "%s", PARAM2);
+  argv_printf_cat (&a, "foo");
+  assert_int_equal (a.argc, 5);
+
+  argv_reset (&a);
+}
+
+static void
+argv_str__multiple_argv__correct_output (void **state)
+{
+  struct argv a = argv_new ();
+  struct gc_arena gc = gc_new ();
+  const char *output;
+
+  argv_printf (&a, "%s%sc", PATH1, PATH2);
+  argv_printf_cat (&a, "%s", PARAM1);
+  argv_printf_cat (&a, "%s", PARAM2);
+  output = argv_str (&a, &gc, PA_BRACKET);
+  assert_string_equal (output, "[" PATH1 PATH2 "] [" PARAM1 "] [" PARAM2 "]");
+
+  argv_reset (&a);
+  gc_free (&gc);
+}
+
+static void
+argv_insert_head__empty_argv__head_only (void **state)
+{
+  struct argv a = argv_new ();
+  struct argv b;
+
+  b = argv_insert_head (&a, PATH1);
+  assert_int_equal (b.argc, 1);
+  assert_string_equal (b.argv[0], PATH1);
+  argv_reset (&b);
+
+  argv_reset (&a);
+}
+
+static void
+argv_insert_head__non_empty_argv__head_added (void **state)
+{
+  struct argv a = argv_new ();
+  struct argv b;
+  int i;
+
+  argv_printf (&a, "%s", PATH2);
+  b = argv_insert_head (&a, PATH1);
+  assert_int_equal (b.argc, a.argc + 1);
+  for (i = 0; i < b.argc; i++) {
+    if (i == 0)
+      assert_string_equal (b.argv[i], PATH1);
+    else
+      assert_string_equal (b.argv[i], a.argv[i - 1]);
+  }
+  argv_reset (&b);
+
+  argv_reset (&a);
+}
+
+int
+main(void)
+{
+  const struct CMUnitTest tests[] = {
+    cmocka_unit_test (argv_printf__multiple_spaces_in_format__parsed_as_one),
+    cmocka_unit_test (argv_printf_cat__multiple_spaces_in_format__parsed_as_one),
+    cmocka_unit_test (argv_printf__combined_path_with_spaces__argc_correct),
+    cmocka_unit_test (argv_printf__script_command__argc_correct),
+    cmocka_unit_test (argv_printf_cat__used_twice__argc_correct),
+    cmocka_unit_test (argv_str__multiple_argv__correct_output),
+    cmocka_unit_test (argv_insert_head__non_empty_argv__head_added),
+  };
+
+  return cmocka_run_group_tests_name ("argv", tests, NULL, NULL);
+}
-- 
2.7.4


