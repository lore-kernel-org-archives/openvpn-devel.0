From: David Sommerseth <davids@...515...>
Date: Thu,  6 Feb 2020 14:21:03 +0100
Message-Id: <20200206132103.15977-5-davids@...515...>
In-Reply-To: <20200206132103.15977-1-davids@...515...>
References: <20200206132103.15977-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH 4/4] Documented all the argv related code
 with minor refactoring
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

Added doxygen comments for all the functions in argv.c.

There are some slight refactoring, renaming a few variables to make
their use case more obvious and ensure lines do not break our 80-chars
per line coding style limit.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/argv.c | 251 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 211 insertions(+), 40 deletions(-)

diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 7d949d24..b799c974 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -40,6 +40,13 @@
 #include "env_set.h"
 #include "options.h"
 
+/**
+ *  Resizes the list of arguments struct argv can carry.  This resize
+ *  operation will only increase the size, never decrease the size.
+ *
+ *  @param *a      Valid pointer to a struct argv to resize
+ *  @param newcap  size_t with the new size of the argument list.
+ */
 static void
 argv_extend(struct argv *a, const size_t newcap)
 {
@@ -57,6 +64,12 @@ argv_extend(struct argv *a, const size_t newcap)
     }
 }
 
+/**
+ *  Initialise an already allocated struct argv.
+ *  It is expected that the input argument is a valid pointer.
+ *
+ *  @param *a  Pointer to a struct argv to initialise
+ */
 static void
 argv_init(struct argv *a)
 {
@@ -67,6 +80,12 @@ argv_init(struct argv *a)
     argv_extend(a, 8);
 }
 
+/**
+ *  Allocates a new struct argv and ensures it is initialised.
+ *  Note that it does not return a pointer, but a struct argv directly.
+ *
+ *  @returns Returns an initialised and empty struct argv.
+ */
 struct argv
 argv_new(void)
 {
@@ -75,12 +94,24 @@ argv_new(void)
     return ret;
 }
 
+/**
+ *  Frees all memory allocations allocated by the struct argv
+ *  related functions.
+ *
+ *  @param *a  Valid pointer to a struct argv to release memory from
+ */
 void
 argv_free(struct argv *a)
 {
     gc_free(&a->gc);
 }
 
+/**
+ *  Resets the struct argv to an initial state.  No memory buffers
+ *  will be released by this call.
+ *
+ *  @param *a      Valid pointer to a struct argv to resize
+ */
 static void
 argv_reset(struct argv *a)
 {
@@ -95,6 +126,19 @@ argv_reset(struct argv *a)
     }
 }
 
+/**
+ *  Extends an existing struct argv to carry minimum 'add' number
+ *  of new arguments.  This builds on argv_extend(), which ensures the
+ *  new size will only be higher than the current capacity.
+ *
+ *  The new size is also calculated based on the result of adjust_power_of_2().
+ *  This approach ensures that the list does grow bulks and only when the
+ *  current limit is reached.
+ *
+ *  @param *a   Valid pointer to the struct argv to extend
+ *  @param add  size_t with the number of elements to add.
+ *
+ */
 static void
 argv_grow(struct argv *a, const size_t add)
 {
@@ -103,15 +147,39 @@ argv_grow(struct argv *a, const size_t add)
     argv_extend(a, adjust_power_of_2(newargc));
 }
 
+/**
+ *  Appends a string to to the list of arguments stored in a struct argv
+ *  This will ensure the list size in struct argv has the needed capacity to
+ *  store the value.
+ *
+ *  @param *a    struct argv where to append the new string value
+ *  @param *str  Pointer to string to append.  The provided string *MUST* have
+ *               been malloc()ed or NULL.
+ */
 static void
-argv_append(struct argv *a, char *str)  /* str must have been gc_malloced or be NULL */
+argv_append(struct argv *a, char *str)
 {
     argv_grow(a, 1);
     a->argv[a->argc++] = str;
 }
 
+/**
+ *  Clones a struct argv with all the contents to a new allocated struct argv.
+ *  If 'headroom' is larger than 0, it will create a head-room in front of the
+ *  values being copied from the source input.
+ *
+ *
+ *  @param *source   Valid pointer to the source struct argv to clone.  It may
+ *                   be NULL.
+ *  @param headroom  Number of slots to leave empty in front of the slots
+ *                   copied from the source.
+ *
+ *  @returns Returns a new struct argv containing a copy of the source
+ *           struct argv, with the given headroom in front of the copy.
+ *
+ */
 static struct argv
-argv_clone(const struct argv *a, const size_t headroom)
+argv_clone(const struct argv *source, const size_t headroom)
 {
     struct argv r;
     argv_init(&r);
@@ -120,16 +188,24 @@ argv_clone(const struct argv *a, const size_t headroom)
     {
         argv_append(&r, NULL);
     }
-    if (a)
+    if (source)
     {
-        for (size_t i = 0; i < a->argc; ++i)
+        for (size_t i = 0; i < source->argc; ++i)
         {
-            argv_append(&r, string_alloc(a->argv[i], &r.gc));
+            argv_append(&r, string_alloc(source->argv[i], &r.gc));
         }
     }
     return r;
 }
 
+/**
+ *  Inserts an argument string in front of all other argument slots.
+ *
+ *  @param  *a     Valid pointer to the struct argv to insert the argument into
+ *  @param  *head  Pointer to the char * string with the argument to insert
+ *
+ *  @returns Returns a new struct argv with the inserted argument in front
+ */
 struct argv
 argv_insert_head(const struct argv *a, const char *head)
 {
@@ -139,12 +215,32 @@ argv_insert_head(const struct argv *a, const char *head)
     return r;
 }
 
+/**
+ *  Generate a single string with all the arguments in a struct argv
+ *  concatenated.
+ *
+ *  @param *a    Valid pointer to the struct argv with the arguments to list
+ *  @param *gc   Pointer to a struct gc_arena managed buffer
+ *  @param flags Flags passed to the print_argv() function.
+ *
+ *  @returns Returns a string generated by print_argv() with all the arguments
+ *           concatenated.  If the argument count is 0, it will return an empty
+ *           string.  The return string is allocated in the gc_arena managed
+ *           buffer.  If the gc_arena pointer is NULL, the returned string
+ *           must be free()d explicitly to avoid memory leaks.
+ */
 const char *
 argv_str(const struct argv *a, struct gc_arena *gc, const unsigned int flags)
 {
     return print_argv((const char **)a->argv, gc, flags);
 }
 
+/**
+ *  Write the arguments stored in a struct argv via the msg() command.
+ *
+ *  @param msglev  Integer with the message level used by msg().
+ *  @param *a      Valid pointer to the struct argv with the arguments to write.
+ */
 void
 argv_msg(const int msglev, const struct argv *a)
 {
@@ -153,6 +249,15 @@ argv_msg(const int msglev, const struct argv *a)
     gc_free(&gc);
 }
 
+/**
+ *  Similar to argv_msg() but prefixes the messages being written with a
+ *  given string.
+ *
+ *  @param msglev   Integer with the message level used by msg().
+ *  @param *a       Valid pointer to the struct argv with the arguments to write
+ *  @param *prefix  Valid char * pointer to the prefix string
+ *
+ */
 void
 argv_msg_prefix(const int msglev, const struct argv *a, const char *prefix)
 {
@@ -161,16 +266,29 @@ argv_msg_prefix(const int msglev, const struct argv *a, const char *prefix)
     gc_free(&gc);
 }
 
-
-/*
- * argv_prep_format - prepare argv format string for further processing
+/**
+ *  Prepares argv format string for further processing
  *
- * Individual argument must be separated by space. Ignores leading and trailing spaces.
- * Consecutive spaces count as one. Returns prepared format string, with space replaced
- * by delim and adds the number of arguments to the count parameter.
+ *  Individual argument must be separated by space. Ignores leading and
+ *  trailing spaces.  Consecutive spaces count as one. Returns prepared
+ *  format string, with space replaced by delim and adds the number of
+ *  arguments to the count parameter.
+ *
+ *  @param *format  Pointer to a the format string to process
+ *  @param delim    Char with the delimiter to use
+ *  @param *count   size_t pointer used to return the number of
+ *                  tokens (argument slots) found in the format string.
+ *  @param *gc      Pointer to a gc_arena managed buffer.
+ *
+ *  @returns Returns a parsed format string (char *), together with the
+ *           number of tokens parts found (via *count).  The result string
+ *           is allocated within the gc_arena managed buffer.  If the
+ *           gc_arena pointer is NULL, the returned string must be explicitly
+ *           free()d to avoid memory leaks.
  */
 static char *
-argv_prep_format(const char *format, const char delim, size_t *count, struct gc_arena *gc)
+argv_prep_format(const char *format, const char delim, size_t *count,
+                 struct gc_arena *gc)
 {
     if (format == NULL)
     {
@@ -209,15 +327,28 @@ argv_prep_format(const char *format, const char delim, size_t *count, struct gc_
     return f;
 }
 
-/*
- * argv_printf_arglist - create a struct argv from a format string
+/**
+ *  Create a struct argv based on a format string
  *
- * Instead of parsing the format string ourselves place delimiters via argv_prep_format()
- * before we let libc's printf() do the parsing. Then split the resulting string at the
- * injected delimiters.
+ *  Instead of parsing the format string ourselves place delimiters via
+ *  argv_prep_format() before we let libc's printf() do the parsing.
+ *  Then split the resulting string at the injected delimiters.
+ *
+ *  @param *argres  Valid pointer to a struct argv where the resulting parsed
+ *                  arguments, based on the format string.
+ *  @param *format  Char* string with a printf() compliant format string
+ *  @param arglist  A va_list with the arguments to be consumed by the format
+ *                  string
+ *
+ *  @returns Returns true if the parsing and processing was successfully.  If
+ *           the resulting number of arguments does not match the expected
+ *           number of arguments (based on the format string), it is
+ *           considered a failure, which returns false.  This can happen if
+ *           the ASCII Group Separator (GS - 0x1D) is put into the arguments
+ *           list or format string.
  */
 static bool
-argv_printf_arglist(struct argv *a, const char *format, va_list arglist)
+argv_printf_arglist(struct argv *argres, const char *format, va_list arglist)
 {
     const char delim = 0x1D;  /* ASCII Group Separator (GS) */
     bool res = false;
@@ -231,14 +362,19 @@ argv_printf_arglist(struct argv *a, const char *format, va_list arglist)
      * saved in the struct argv.
      *
      */
-    size_t argc = a->argc;
-    char *f = argv_prep_format(format, delim, &argc, &a->gc);
+    size_t argc = argres->argc;
+    char *f = argv_prep_format(format, delim, &argc, &argres->gc);
     if (f == NULL)
     {
         goto out;
     }
 
-    /* determine minimum buffer size */
+    /*
+     * Determine minimum buffer size.
+     *
+     * With C99, vsnprintf(NULL, 0, ...) will return the number of bytes
+     * it would have written, had the buffer been large enough.
+     */
     va_list tmplist;
     va_copy(tmplist, arglist);
     int len = vsnprintf(NULL, 0, f, tmplist);
@@ -252,8 +388,8 @@ argv_printf_arglist(struct argv *a, const char *format, va_list arglist)
      *  Do the actual vsnprintf() operation, which expands the format
      *  string with the provided arguments.
      */
-    size_t size = adjust_power_of_2(len + 1);
-    char *buf = gc_malloc(size, false, &a->gc);
+    size_t size = len + 1;
+    char *buf = gc_malloc(size, false, &argres->gc);
     len = vsnprintf(buf, size, f, arglist);
     if (len < 0 || len >= size)
     {
@@ -268,16 +404,16 @@ argv_printf_arglist(struct argv *a, const char *format, va_list arglist)
     while (end)
     {
         *end = '\0';
-        argv_append(a, buf);
+        argv_append(argres, buf);
         buf = end + 1;
         end = strchr(buf, delim);
     }
-    argv_append(a, buf);
+    argv_append(argres, buf);
 
-    if (a->argc != argc)
+    if (argres->argc != argc)
     {
         /* Someone snuck in a GS (0x1D), fail gracefully */
-        argv_reset(a);
+        argv_reset(argres);
         goto out;
     }
     res = true;
@@ -286,48 +422,83 @@ out:
     return res;
 }
 
-
-
+/**
+ *  printf() variant which populates a struct argv.  It processes the
+ *  format string with the provided arguments.  For each space separator found
+ *  in the format string, a new argument will be added to the resulting
+ *  struct argv.
+ *
+ *  This will always reset and ensure the result is based on a pristine
+ *  struct argv.
+ *
+ *  @param *argres  Valid pointer to a struct argv where the result will be put.
+ *  @param *format  printf() compliant (char *) format string.
+ *
+ *  @returns Returns true if the parsing was successful.  See
+ *           argv_printf_arglist() for more details.  The parsed result will
+ *           be put into argres.
+ */
 bool
-argv_printf(struct argv *a, const char *format, ...)
+argv_printf(struct argv *argres, const char *format, ...)
 {
     va_list arglist;
     va_start(arglist, format);
 
-    argv_reset(a);
-    bool res = argv_printf_arglist(a, format, arglist);
+    argv_reset(argres);
+    bool res = argv_printf_arglist(argres, format, arglist);
     va_end(arglist);
     return res;
 }
 
+/**
+ *  printf() inspired argv concatenation.  Adds arguments to an existing
+ *  struct argv and populets the argument slots based on the printf() based
+ *  format string.
+ *
+ *  @param *argres  Valid pointer to a struct argv where the result will be put.
+ *  @param *format  printf() compliant (char *) format string.
+ *
+ *  @returns Returns true if the parsing was successful.  See
+ *           argv_printf_arglist() for more details.  The parsed result will
+ *           be put into argres.
+ */
 bool
-argv_printf_cat(struct argv *a, const char *format, ...)
+argv_printf_cat(struct argv *argres, const char *format, ...)
 {
     va_list arglist;
     va_start(arglist, format);
-
-    bool res = argv_printf_arglist(a, format, arglist);
+    bool res = argv_printf_arglist(argres, format, arglist);
     va_end(arglist);
     return res;
 }
 
+/**
+ *  Parses a command string, tokenizes it and puts each element into a separate
+ *  struct argv argument slot.
+ *
+ *  @params *argres  Valid pointer to a struct argv where the parsed result
+ *                   will be found.
+ *  @params *cmdstr  Char * based string to parse
+ *
+ */
 void
-argv_parse_cmd(struct argv *a, const char *s)
+argv_parse_cmd(struct argv *argres, const char *cmdstr)
 {
-    argv_reset(a);
+    argv_reset(argres);
 
     char *parms[MAX_PARMS + 1] = { 0 };
-    int nparms = parse_line(s, parms, MAX_PARMS, "SCRIPT-ARGV", 0, D_ARGV_PARSE_CMD, &a->gc);
+    int nparms = parse_line(cmdstr, parms, MAX_PARMS, "SCRIPT-ARGV", 0,
+                            D_ARGV_PARSE_CMD, &argres->gc);
     if (nparms)
     {
         int i;
         for (i = 0; i < nparms; ++i)
         {
-            argv_append(a, parms[i]);
+            argv_append(argres, parms[i]);
         }
     }
     else
     {
-        argv_append(a, string_alloc(s, &a->gc));
+        argv_append(argres, string_alloc(cmdstr, &argres->gc));
     }
 }
-- 
2.17.1


