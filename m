From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] First half of macro-vs-function hacks (was: Pre-1.3.3 beta available for testing)
Message-ID: <20030220121321.GB9006@...33...>
References: <20030219204918.GD18493@...33...> <Pine.LNX.4.44.0302192319420.31668-100000@...41...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.44.0302192319420.31668-100000@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Thu Feb 20 04:16:04 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net
Cc: James Yonan <jim@...41...>

[resend, first send went to James but not the list]

Hi,

after the merge, I got some rejects for minor differences, usually
coding style.

My coding style is: add parentheses without space for function and macro
calls, add a space for control constructs:

printf("something");
if (test == true) { ... }
while (1) { munch_cpu(); }

On Wed, 19 Feb 2003, James Yonan wrote:

> Still to do:
> (1) _* name renaming

I'm not pressing towards this before 1.3.3, if 1.3.3 ships with the
_names in place, that's fine with me.

> (2) merge your warnings quencher #1
> (3) the removal of install-sh seems to have broken rpmbuild -tb [tarball]

I don't have rpmbuild (rpm 3.0.x here, SuSE Linux 8.1), but I can
successfully build a binary rpm by: (the same i586 target is used for
any other SuSE Linux 8.1 package)

make dist
rpm --target=i586 -tb openvpn-1.3.2.10.tar.gz

> (4) reconcile macro vararg approaches

Leaving the acinclude.m4/configure.ac aside for a moment, how about this
patch to reduce special casing in the preprocessor, rename _msg to x_msg
and fix warnings?

# error.h |   25 ++++++++++++-------------
# error.c |   20 ++++++++------------
# 2 files changed, 20 insertions(+), 25 deletions(-)

Index: error.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/error.h,v
retrieving revision 1.9
diff -u -r1.9 error.h
--- error.h	20 Feb 2003 05:02:38 -0000	1.9
+++ error.h	20 Feb 2003 12:03:52 -0000
@@ -34,9 +34,9 @@
  * These globals should not be accessed directly,
  * but rather through macros or inline functions defined below.
  */
-extern int _debug_level;
-extern int _cs_info_level;
-extern int _cs_verbose_level;
+extern unsigned int _debug_level;
+extern unsigned int _cs_info_level;
+extern unsigned int _cs_verbose_level;
 
 extern int msg_line_num;
 
@@ -85,25 +85,24 @@
 
 #if defined(HAVE_VARARG_MACROS_ISO)
 #define HAVE_VARARG_MACROS
-#define msg(flags, ...) do { if (MSG_TEST(flags)) _msg((flags), __VA_ARGS__); } while (false)
+#define msg(flags, ...) do { if (MSG_TEST(flags)) x_msg((flags), __VA_ARGS__); } while (false)
 #elif defined(HAVE_VARARG_MACROS_GCC)
 #define HAVE_VARARG_MACROS
-#define msg(flags, args...) do { if (MSG_TEST(flags)) _msg((flags), args); } while (false)
-#endif
-
-#ifdef HAVE_VARARG_MACROS
-void _msg (unsigned int flags, const char *format, ...); /* should be called via msg above */
+#define msg(flags, args...) do { if (MSG_TEST(flags)) x_msg((flags), args); } while (false)
 #else
-void msg (unsigned int flags, const char *format, ...);
+#define x_msg msg
+#undef HAVE_VARARG_MACROS
 #endif
 
+void x_msg (unsigned int flags, const char *format, ...);
+
 /*
  * Function prototypes
  */
 
 void error_reset ();
-void set_check_status (int info_level, int verbose_level);
-void set_debug_level (int level);
+void set_check_status (unsigned int info_level, unsigned int verbose_level);
+void set_debug_level (unsigned int level);
 void set_mute_cutoff (int cutoff);
 
 /*
@@ -119,7 +118,7 @@
 /* Inline functions */
 
 static inline bool
-check_debug_level (int level)
+check_debug_level (unsigned int level)
 {
   return (level & M_DEBUG_LEVEL) < _debug_level;
 }
Index: error.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/error.c,v
retrieving revision 1.11
diff -u -r1.11 error.c
--- error.c	20 Feb 2003 05:02:38 -0000	1.11
+++ error.c	20 Feb 2003 12:03:52 -0000
@@ -39,9 +39,9 @@
 #include "memdbg.h"
 
 /* Globals */
-int _debug_level;
-int _cs_info_level;
-int _cs_verbose_level;
+unsigned int _debug_level;
+unsigned int _cs_info_level;
+unsigned int _cs_verbose_level;
 
 /* Mute state */
 static int mute_cutoff;
@@ -55,7 +55,7 @@
 static FILE *msgfp;
 
 void
-set_debug_level (int level)
+set_debug_level (unsigned int level)
 {
   _debug_level = level;
 }
@@ -87,7 +87,7 @@
 }
 
 void
-set_check_status (int info_level, int verbose_level)
+set_check_status (unsigned int info_level, unsigned int verbose_level)
 {
   _cs_info_level = info_level;
   _cs_verbose_level = verbose_level;
@@ -113,11 +113,7 @@
 
 int msg_line_num;
 
-#ifdef HAVE_VARARG_MACROS
-void _msg (unsigned int flags, const char *format, ...)
-#else
-void msg (unsigned int flags, const char *format, ...)
-#endif
+void x_msg (unsigned int flags, const char *format, ...)
 {
   va_list arglist;
   int level;
@@ -187,8 +183,8 @@
   if (flags & M_SSL)
     {
       int nerrs = 0;
-      int err;
-      while (err = ERR_get_error ())
+      unsigned long err;
+      while ((err = ERR_get_error ()))
 	{
 	  snprintf (m2, ERR_BUF_SIZE, "%s: %s", m1, ERR_error_string (err, NULL));
 	  SWAP;

> Question: What's the best way to generate a tarball that has ./configure 
> already generated, so that openvpn can be built and installed with the 
> usual "./configure && make && make install"?

The canonical way is:

make distcheck

If you're absolutely confident it works, because you just changed
documentation, "make dist" will suffice.

-- 
Matthias Andree

