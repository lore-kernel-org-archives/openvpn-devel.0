From: Matthias Andree <ma+ovpnd@...31...>
Subject: Second half of variadic macro fix (was: [Openvpn-devel] Pre-1.3.3 beta available for testing)
Message-ID: <20030219211936.GA5358@...33...>
References: <20030219181048.GA21087@...33...> <Pine.LNX.4.44.0302191128560.12503-100000@...41...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.44.0302191128560.12503-100000@...41...>
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
Date: Wed Feb 19 13:20:18 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Dear Jim,

this second patch completes the varargs stuff. Tested on all machines I
listed last time, and SUNpro 6 is very happy with the ISO C99 stuff and
uses the macro (rather than the function). I tried to force the function
underneath gcc 2.95 (edited config.cache, ran ./config.status --recheck,
./config.status, remade stuff), seems fine here.

Please give it a try (sorry for listing the files in the wrong reading
order, shell globbed .c before .h).

Cheers,
Matthias

Index: error.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/error.c,v
retrieving revision 1.10
diff -u -r1.10 error.c
--- error.c	9 Dec 2002 15:40:34 -0000	1.10
+++ error.c	19 Feb 2003 21:13:27 -0000
@@ -113,10 +113,24 @@
 
 int msg_line_num;
 
-void
-_msg (unsigned int flags, const char *format, ...)
+#if !MSGMACRO
+void msg(unsigned int flags, const char *format, ...) {
+    va_list ap;
+    va_start(ap, format);
+    _msg(flags, format, ap);
+    va_end(ap);
+}
+#endif
+
+#if MSGMACRO
+void _msg (unsigned int flags, const char *format, ...)
+#else
+void _msg (unsigned int flags, const char *format, va_list arglist)
+#endif
 {
+#if MSGMACRO
   va_list arglist;
+#endif
   int level;
   char msg1[ERR_BUF_SIZE];
   char msg2[ERR_BUF_SIZE];
@@ -161,9 +175,13 @@
   m1 = msg1;
   m2 = msg2;
 
+#if MSGMACRO
   va_start (arglist, format);
+#endif
   vsnprintf (m1, ERR_BUF_SIZE, format, arglist);
+#if MSGMACRO
   va_end (arglist);
+#endif
 
   if ((flags & M_ERRNO) && e)
     {
@@ -180,7 +198,7 @@
     {
       int nerrs = 0;
       int err;
-      while (err = ERR_get_error ())
+      while ((err = ERR_get_error ()))
 	{
 	  snprintf (m2, ERR_BUF_SIZE, "%s: %s", m1, ERR_error_string (err, NULL));
 	  SWAP;
Index: error.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/error.h,v
retrieving revision 1.8
diff -u -r1.8 error.h
--- error.h	9 Dec 2002 15:40:34 -0000	1.8
+++ error.h	19 Feb 2003 21:13:27 -0000
@@ -76,11 +76,26 @@
  */
 #define LOGLEV(log_level, mute_level, other) (((log_level)-1) | ENCODE_MUTE_LEVEL(mute_level) | other)
 
+#if OPENVPN_VARMAC_ISOC99
+#define msg(flags, ...) \
+    do { if (((flags) & M_DEBUG_LEVEL) < _debug_level || ((flags) & M_FATAL)) \
+    _msg((flags), __VA_ARGS__); } while (false)
+#define MSGMACRO 1
+#elif OPENVPN_VARMAC_GCC
 #define msg(flags, args...) \
     do { if (((flags) & M_DEBUG_LEVEL) < _debug_level || ((flags) & M_FATAL)) \
     _msg((flags), args); } while (false)
+#define MSGMACRO 1
+#else
+#define MSGMACRO 0
+    void msg(unsigned int flags, const char *format, ...);
+#endif
 
-void _msg (unsigned int flags, const char *format, ...); /* should be called via msg above */
+#if MSGMACRO
+void _msg(unsigned int flags, const char *format, ...); /* should be called via msg above */
+#else
+void _msg(unsigned int flags, const char *format, va_list ap);
+#endif
 
 void error_reset ();
 void set_check_status (int info_level, int verbose_level);

