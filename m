From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20030417105647.GA4239@...33...>
References: <200304170843.h3H8h0121046@...41...>
Mime-Version: 1.0
In-Reply-To: <200304170843.h3H8h0121046@...41...>
Subject: [Openvpn-devel] Re: New beta available + progress update
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
Date: Thu Apr 17 03:58:51 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

> http://openvpn.sourceforge.net/beta/openvpn-1.3.2.21.tar.gz (or CVS)

I have a next round of patches to fix prototypes and types to quench
compiler warnings and get a more robust source code against changed
environments, to aid possible later debugging; it also includes GCC
extensions (only used when GCC is being used) that allow stricter msg()
and buf_printf() format string vs. argument checking, to avoid printing
bogus data when type sizes differ (think 64 bit).

One problem remains after applying the patch:
openvpn.c: In function `openvpn':
openvpn.c:470: warning: cast discards qualifiers from pointer target type

Other than that, we have unused parameter warnings (you said before
you're not fixing them), shadow parameter warnings (variable names being
the same as system functions, such as time or nice) and in particular,
aggregate (struct) values in function calls and function returns, these
are inefficient (as the compiler must toss the whole struct on the
stack, which involves copy overhead), and some of them (buffer.c in
particular) look pretty suspicious. Is there any C standard that
guarantees that returning an auto struct works and copies the return
value?

Index: buffer.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/buffer.c,v
retrieving revision 1.12
diff -u -r1.12 buffer.c
--- buffer.c	16 Mar 2003 08:34:12 -0000	1.12
+++ buffer.c	17 Apr 2003 10:51:16 -0000
@@ -111,7 +111,7 @@
  * printf append to a buffer with overflow check
  */
 void
-buf_printf (struct buffer *buf, char *format, ...)
+buf_printf (struct buffer *buf, const char *format, ...)
 {
   va_list arglist;
 
@@ -223,7 +223,7 @@
 
 char *
 format_hex_ex (const uint8_t *data, int size, int maxoutput,
-	       int space_break, char* separator)
+	       int space_break, const char* separator)
 {
   struct buffer out = alloc_buf_gc (maxoutput ? maxoutput :
 				    ((size * 2) + (size / space_break) + 2));
Index: buffer.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/buffer.h,v
retrieving revision 1.11
diff -u -r1.11 buffer.h
--- buffer.h	17 Apr 2003 07:12:04 -0000	1.11
+++ buffer.h	17 Apr 2003 10:51:16 -0000
@@ -47,7 +47,7 @@
 struct buffer alloc_buf (size_t size);
 struct buffer clone_buf (const struct buffer* buf);
 struct buffer alloc_buf_gc (size_t size);	/* allocate buffer with garbage collection */
-struct buffer clear_buf ();
+struct buffer clear_buf (void);
 void free_buf (struct buffer *buf);
 
 static inline bool
@@ -93,7 +93,7 @@
 
 /* Like strncpy but makes sure dest is always null terminated */
 static inline void
-strncpynt (char *dest, const char *src, int maxlen)
+strncpynt (char *dest, const char *src, size_t maxlen)
 {
   strncpy (dest, src, maxlen);
   if (maxlen > 0)
@@ -116,7 +116,11 @@
 /*
  * printf append to a buffer with overflow check
  */
-void buf_printf (struct buffer *buf, char *format, ...);
+void buf_printf (struct buffer *buf, const char *format, ...)
+#ifdef __GNUC__
+    __attribute__ ((format (printf, 2, 3)))
+#endif
+    ;
 
 /*
  * remove trailing newline
@@ -149,7 +153,7 @@
  */
 char *
 format_hex_ex (const uint8_t *data, int size, int maxoutput,
-	       int space_break, char* separator);
+	       int space_break, const char* separator);
 
 static inline char *
 format_hex (const uint8_t *data, int size, int maxoutput)
@@ -353,7 +357,7 @@
 void x_gc_free (void *p);
 
 static inline int
-gc_new_level ()
+gc_new_level (void)
 {
   struct gc_thread* thread = &x_gc_thread[thread_number()];
   return ++thread->gc_level;
Index: common.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/common.h,v
retrieving revision 1.14
diff -u -r1.14 common.h
--- common.h	17 Apr 2003 07:12:04 -0000	1.14
+++ common.h	17 Apr 2003 10:51:16 -0000
@@ -41,8 +41,12 @@
  */
 #define counter_format        "%10lu"
 #define ptr_format            "0x%08zx"
-#define time_format           "%u"
+#define time_format           "%lu"
 #define fragment_type_format  "0x%08x"
+
+/* these are used to cast the arguments
+ * and MUST match the formats above */
+typedef unsigned long time_type;
 
 /*
  * Functions used for circular buffer index arithmetic.
Index: configure.ac
===================================================================
RCS file: /cvsroot/openvpn/openvpn/configure.ac,v
retrieving revision 1.64
diff -u -r1.64 configure.ac
--- configure.ac	17 Apr 2003 07:12:04 -0000	1.64
+++ configure.ac	17 Apr 2003 10:51:17 -0000
@@ -223,6 +223,9 @@
 	[],
 	[#include "syshead.h"])
 
+AC_CHECK_SIZEOF(unsigned int)
+AC_CHECK_SIZEOF(unsigned long)
+
 AC_CACHE_SAVE
 
 dnl check for other types
Index: crypto.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/crypto.h,v
retrieving revision 1.11
diff -u -r1.11 crypto.h
--- crypto.h	21 Feb 2003 16:14:05 -0000	1.11
+++ crypto.h	17 Apr 2003 10:51:17 -0000
@@ -262,11 +262,11 @@
 
 void test_crypto (const struct crypto_options *co, struct frame* f);
 
-void show_available_ciphers ();
+void show_available_ciphers (void);
 
-void show_available_digests ();
+void show_available_digests (void);
 
-void init_crypto_lib ();
+void init_crypto_lib (void);
 
 #ifdef USE_SSL
 
Index: error.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/error.c,v
retrieving revision 1.17
diff -u -r1.17 error.c
--- error.c	17 Apr 2003 07:12:05 -0000	1.17
+++ error.c	17 Apr 2003 10:51:17 -0000
@@ -251,7 +251,7 @@
 }
 
 void
-become_inetd_server ()
+become_inetd_server (void)
 {
 #if defined(HAVE_OPENLOG) && defined(HAVE_SYSLOG)
   if (!msgfp)
Index: error.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/error.h,v
retrieving revision 1.14
diff -u -r1.14 error.h
--- error.h	16 Mar 2003 08:34:12 -0000	1.14
+++ error.h	17 Apr 2003 10:51:17 -0000
@@ -88,30 +88,34 @@
 
 #define MSG_TEST(flags) ((((unsigned int)flags) & M_DEBUG_LEVEL) < x_debug_level || ((flags) & M_FATAL))
 
-#if defined(HAVE_CPP_VARARG_MACRO_ISO)
+#if defined(HAVE_CPP_VARARG_MACRO_ISO) && !defined(__LCLINT__)
 #define HAVE_VARARG_MACROS
 #define msg(flags, ...) do { if (MSG_TEST(flags)) x_msg((flags), __VA_ARGS__); } while (false)
-#elif defined(HAVE_CPP_VARARG_MACRO_CPP)
+#elif defined(HAVE_CPP_VARARG_MACRO_CPP) && !defined(__LCLINT__)
 #define HAVE_VARARG_MACROS
 #define msg(flags, args...) do { if (MSG_TEST(flags)) x_msg((flags), args); } while (false)
 #else
 #define msg x_msg
 #endif
 
-void x_msg (unsigned int flags, const char *format, ...); /* should be called via msg above */
+void x_msg (unsigned int flags, const char *format, ...)
+#ifdef __GNUC__
+    __attribute__ ((format (printf, 2, 3)))
+#endif
+    ; /* should be called via msg above */
 
 /*
  * Function prototypes
  */
 
-void error_reset ();
+void error_reset (void);
 void set_debug_level (int level);
 void set_mute_cutoff (int cutoff);
 
 /*
  * File to print messages to before syslog is opened.
  */
-FILE *msg_fp();
+FILE *msg_fp(void);
 
 /* Fatal logic errors */
 #define ASSERT(x) do { if (!(x)) assert_failed(__FILE__, __LINE__); } while (false)
@@ -127,7 +131,7 @@
 }
 
 void become_daemon (const char *cd);
-void become_inetd_server ();
+void become_inetd_server (void);
 
 #include "errlevel.h"
 
Index: gremlin.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/gremlin.c,v
retrieving revision 1.9
diff -u -r1.9 gremlin.c
--- gremlin.c	17 Apr 2003 07:12:06 -0000	1.9
+++ gremlin.c	17 Apr 2003 10:51:17 -0000
@@ -103,7 +103,7 @@
  * Return false if we should drop a packet.
  */
 bool
-ask_gremlin()
+ask_gremlin(void)
 {
   struct timeval tv;
 
Index: gremlin.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/gremlin.h,v
retrieving revision 1.3
diff -u -r1.3 gremlin.h
--- gremlin.h	21 Feb 2003 16:14:06 -0000	1.3
+++ gremlin.h	17 Apr 2003 10:51:17 -0000
@@ -25,5 +25,5 @@
 
 #include "buffer.h"
 
-bool ask_gremlin();
+bool ask_gremlin(void);
 void corrupt_gremlin(struct buffer* buf);
Index: misc.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/misc.h,v
retrieving revision 1.13
diff -u -r1.13 misc.h
--- misc.h	17 Apr 2003 07:12:07 -0000	1.13
+++ misc.h	17 Apr 2003 10:51:17 -0000
@@ -51,8 +51,8 @@
 int openvpn_system (const char *command);
 
 /* interpret the status code returned by system() */
-bool system_ok(int stat);
-const char *system_error_message (int stat);
+bool system_ok(int);
+const char *system_error_message (int);
 
 /* run system() with error check, return true if success,
    false if error, exit if error and fatal==true */
@@ -62,11 +62,11 @@
 const char* time_string (time_t t);
 
 /* init random() function, only used as source for weak random numbers, when !USE_CRYPTO */
-void init_random_seed();
+void init_random_seed(void);
 
 /* an analogue to the random() function, but use OpenSSL functions if available */
 #ifdef USE_CRYPTO
-long int get_random();
+long int get_random(void);
 #else
 #define get_random random
 #endif
Index: options.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/options.c,v
retrieving revision 1.31
diff -u -r1.31 options.c
--- options.c	17 Apr 2003 07:12:10 -0000	1.31
+++ options.c	17 Apr 2003 10:51:19 -0000
@@ -491,7 +491,7 @@
 }
 
 static void
-usage ()
+usage (void)
 {
   struct options o;
   FILE *fp = msg_fp();
@@ -518,14 +518,14 @@
 }
 
 void
-usage_small ()
+usage_small (void)
 {
   msg (M_WARN, "Use --help for more information");
   exit (OPENVPN_EXIT_STATUS_USAGE); /* exit point */
 }
 
-void
-usage_version ()
+static void
+usage_version (void)
 {
   msg (M_INFO, "%s", TITLE);
   msg (M_INFO, "Copyright (C) 2002-2003 James Yonan <jim@...41...>");
@@ -552,7 +552,7 @@
 }
 
 static void
-ping_rec_err ()
+ping_rec_err (void)
 {
   msg (M_WARN, "Options error: only one of --ping-exit or --ping-restart options may be specified");
   usage_small ();
Index: options.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/options.h,v
retrieving revision 1.23
diff -u -r1.23 options.h
--- options.h	17 Apr 2003 07:12:10 -0000	1.23
+++ options.h	17 Apr 2003 10:51:19 -0000
@@ -175,7 +175,7 @@
 
 void notnull (const char *arg, const char *description);
 
-void usage_small ();
+void usage_small (void);
 
 void init_options (struct options *o);
 void show_settings (const struct options *o);
Index: packet_id.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/packet_id.c,v
retrieving revision 1.13
diff -u -r1.13 packet_id.c
--- packet_id.c	17 Apr 2003 07:12:11 -0000	1.13
+++ packet_id.c	17 Apr 2003 10:51:19 -0000
@@ -86,7 +86,8 @@
 
   msg (D_PID_DEBUG,
        "PID TEST " time_format ":" packet_id_format " " time_format ":" packet_id_format "",
-       p->time, p->id, pin->time, pin->id);
+       (time_type)p->time, (packet_id_print_type)p->id, (time_type)pin->time,
+       (packet_id_print_type)pin->id);
 
   if (!pin->id)
     return false;
@@ -114,10 +115,10 @@
 packet_id_net_print (const struct packet_id_net *pin, bool print_timestamp)
 {
   struct buffer out = alloc_buf_gc (256);
-  
-  buf_printf (&out, "[ #" packet_id_format, pin->id);
+
+  buf_printf (&out, "[ #" packet_id_format, (packet_id_print_type)pin->id);
   if (print_timestamp && pin->time)
-      buf_printf (&out, " / time = (" packet_id_format ") %s", pin->time, time_string (pin->time));
+      buf_printf (&out, " / time = (" packet_id_format ") %s", (packet_id_print_type)pin->time, time_string (pin->time));
 
   buf_printf (&out, " ]");
   return BSTR (&out);
@@ -244,14 +245,14 @@
 packet_id_persist_print (const struct packet_id_persist *p)
 {
   struct buffer out = alloc_buf_gc (256);
-  
+
   buf_printf (&out, "[");
 
   if (packet_id_persist_enabled (p))
     {
-      buf_printf (&out, " #" packet_id_format, p->id);
+      buf_printf (&out, " #" packet_id_format, (packet_id_print_type)p->id);
       if (p->time)
-	buf_printf (&out, " / time = (" packet_id_format ") %s", p->time, time_string (p->time));
+	buf_printf (&out, " / time = (" packet_id_format ") %s", (packet_id_print_type)p->time, time_string (p->time));
     }
 
   buf_printf (&out, " ]");
Index: packet_id.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/packet_id.h,v
retrieving revision 1.13
diff -u -r1.13 packet_id.h
--- packet_id.h	17 Apr 2003 07:12:11 -0000	1.13
+++ packet_id.h	17 Apr 2003 10:51:19 -0000
@@ -93,7 +93,15 @@
 /*
  * Printf formats for special types
  */
+#if SIZEOF_UNSIGNED_LONG == 4
+#define packet_id_format "%lu"
+typedef unsigned long packet_id_print_type;
+#elif SIZEOF_UNSIGNED_INT == 4
 #define packet_id_format "%u"
+typedef unsigned int packet_id_print_type;
+#else
+#error "cannot figure proper format to print uint32_t"
+#endif
 
 /*
  * Maximum allowed backtrack in
Index: reliable.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/reliable.c,v
retrieving revision 1.12
diff -u -r1.12 reliable.c
--- reliable.c	17 Apr 2003 07:12:11 -0000	1.12
+++ reliable.c	17 Apr 2003 10:51:19 -0000
@@ -62,7 +62,7 @@
     {
       *pid = ntohpid (net_pid);
       msg (D_REL_DEBUG, "ACK read ID " packet_id_format " (buf->len=%d)",
-	   *pid, buf->len);
+	   (packet_id_print_type)*pid, buf->len);
       return true;
     }
 
@@ -78,12 +78,12 @@
     {
       ack->packet_id[ack->len++] = pid;
       msg (D_REL_DEBUG, "ACK acknowledge ID " packet_id_format " (ack->len=%d)",
-	   pid, ack->len);
+	   (packet_id_print_type)pid, ack->len);
       return true;
     }
 
   msg (D_REL_LOW, "ACK acknowledge ID " packet_id_format " FAILED (ack->len=%d)",
-       pid, ack->len);
+       (packet_id_print_type)pid, ack->len);
   return false;
 }
 
@@ -153,7 +153,7 @@
       packet_id_type pid = ack->packet_id[i];
       packet_id_type net_pid = htonpid (pid);
       ASSERT (buf_write (&sub, &net_pid, sizeof (net_pid)));
-      msg (D_REL_DEBUG, "ACK write ID " packet_id_format " (ack->len=%d, n=%d)", pid, ack->len, n);
+      msg (D_REL_DEBUG, "ACK write ID " packet_id_format " (ack->len=%d, n=%d)", (packet_id_print_type)pid, ack->len, n);
     }
   if (n)
     {
@@ -195,7 +195,7 @@
       if (!buf_read (buf, &pid, sizeof (pid)))
 	goto done;
       pid = ntohpid (pid);
-      buf_printf (&out, " " packet_id_format, pid);
+      buf_printf (&out, " " packet_id_format, (packet_id_print_type)pid);
     }
   if (n_ack)
     {
@@ -294,7 +294,7 @@
 	    {
 	      msg (D_REL_DEBUG,
 		   "ACK received for pid " packet_id_format ", deleting from send buffer",
-		   pid);
+		   (packet_id_print_type)pid);
 #if 0
 	      /* DEBUGGING -- how close were we timing out on ACK failure and resending? */
 	      {
@@ -316,12 +316,12 @@
   struct buffer out = alloc_buf_gc (512);
   int i;
 
-  buf_printf (&out, "[" packet_id_format "]", rel->packet_id);
+  buf_printf (&out, "[" packet_id_format "]", (packet_id_print_type)rel->packet_id);
   for (i = 0; i < rel->size; ++i)
     {
       const struct reliable_entry *e = &rel->array[i];
       if (e->active)
-	buf_printf (&out, " " packet_id_format, e->packet_id);
+	buf_printf (&out, " " packet_id_format, (packet_id_print_type)e->packet_id);
     }
   return BSTR (&out);
 }
@@ -357,7 +357,7 @@
   return true;
 
  bad:
-  msg (D_REL_DEBUG, "ACK " packet_id_format " is a replay: %s", id, reliable_print_ids (rel));
+  msg (D_REL_DEBUG, "ACK " packet_id_format " is a replay: %s", (packet_id_print_type)id, reliable_print_ids (rel));
   return false;
 }
 
@@ -372,7 +372,7 @@
   else
     {
       msg (D_REL_DEBUG, "ACK " packet_id_format " breaks sequentiality: %s",
-	   id, reliable_print_ids (rel));
+	   (packet_id_print_type)id, reliable_print_ids (rel));
       return false;
     }
 }
@@ -504,7 +504,7 @@
 #endif
       *opcode = best->opcode;
       msg (D_REL_DEBUG, "ACK reliable_send ID " packet_id_format " (size=%d to=%d)",
-	   best->packet_id, best->buf.len, (int) best->next_try - current);
+	   (packet_id_print_type)best->packet_id, best->buf.len, (int)(best->next_try - current));
       return &best->buf;
     }
   return NULL;
@@ -552,7 +552,7 @@
 	  e->opcode = opcode;
 	  e->next_try = 0;
 	  e->timeout = 0;
-	  msg (D_REL_DEBUG, "ACK mark active incoming ID " packet_id_format, e->packet_id);
+	  msg (D_REL_DEBUG, "ACK mark active incoming ID " packet_id_format, (packet_id_print_type)e->packet_id);
 	  return;
 	}
     }
@@ -582,7 +582,7 @@
 	  e->opcode = opcode;
 	  e->next_try = 0;
 	  e->timeout = rel->initial_timeout;
-	  msg (D_REL_DEBUG, "ACK mark active outgoing ID " packet_id_format, e->packet_id);
+	  msg (D_REL_DEBUG, "ACK mark active outgoing ID " packet_id_format, (packet_id_print_type)e->packet_id);
 	  return;
 	}
     }
Index: shaper.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/shaper.c,v
retrieving revision 1.6
diff -u -r1.6 shaper.c
--- shaper.c	17 Apr 2003 07:12:12 -0000	1.6
+++ shaper.c	17 Apr 2003 10:51:19 -0000
@@ -113,7 +113,7 @@
 	}
     }
   msg (D_SHAPER_DEBUG, "SHAPER shaper_soonest_event sec=%d usec=%d",
-       tv->tv_sec, tv->tv_usec);
+       (int)tv->tv_sec, (int)tv->tv_usec);
 }
 
 /*
@@ -138,7 +138,7 @@
       s->wakeup.tv_usec -= 1000000;
     }
   msg (D_SHAPER_DEBUG, "SHAPER shaper_wrote_bytes bytes=%d delay=%d sec=%d usec=%d",
-       nbytes, delay, s->wakeup.tv_sec, s->wakeup.tv_usec);
+       nbytes, delay, (int)s->wakeup.tv_sec, (int)s->wakeup.tv_usec);
 }
 
 /*
Index: socket.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/socket.h,v
retrieving revision 1.10
diff -u -r1.10 socket.h
--- socket.h	17 Apr 2003 07:12:15 -0000	1.10
+++ socket.h	17 Apr 2003 10:51:19 -0000
@@ -109,7 +109,7 @@
 extern unsigned int x_cs_info_level;
 extern unsigned int x_cs_verbose_level;
 
-void reset_check_status ();
+void reset_check_status (void);
 void set_check_status (unsigned int info_level, unsigned int verbose_level);
 void x_check_status (int status, const char *description, struct udp_socket *sock);
 
Index: ssl.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/ssl.c,v
retrieving revision 1.32
diff -u -r1.32 ssl.c
--- ssl.c	17 Apr 2003 07:12:15 -0000	1.32
+++ ssl.c	17 Apr 2003 10:51:21 -0000
@@ -1284,7 +1284,7 @@
        || (packet_id_close_to_wrapping (&ks->packet_id.send))))
     {
       msg (D_TLS_DEBUG_LOW, "TLS: soft reset sec=%d bytes=%d/%d pkts=%d/%d",
-	   (int) ks->established + session->opt->renegotiate_seconds - current,
+	   (int)(ks->established + session->opt->renegotiate_seconds - current),
 	   ks->n_bytes, session->opt->renegotiate_bytes,
 	   ks->n_packets, session->opt->renegotiate_packets);
       key_state_soft_reset (session, current);
@@ -1732,7 +1732,7 @@
  * Errors are fatal if they are of these types.
  */
 static inline bool
-local_sock_fatal ()
+local_sock_fatal (void)
 {
   return errno == ENOTCONN || errno == ECONNREFUSED;
 }
@@ -2487,7 +2487,7 @@
     if (!buf_read (&buf, &l, sizeof (l)))
       goto done;
     l = ntohpid (l);
-    buf_printf (&out, " pid=" packet_id_format, l);
+    buf_printf (&out, " pid=" packet_id_format, (packet_id_print_type)l);
   }
 
 print_data:
Index: ssl.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/ssl.h,v
retrieving revision 1.11
diff -u -r1.11 ssl.h
--- ssl.h	17 Apr 2003 07:12:16 -0000	1.11
+++ ssl.h	17 Apr 2003 10:51:21 -0000
@@ -331,8 +331,8 @@
   struct tls_session session[TM_SIZE];
 };
 
-void init_ssl_lib ();
-void free_ssl_lib ();
+void init_ssl_lib (void);
+void free_ssl_lib (void);
 
 /* Build master SSL_CTX object that serves for the whole of openvpn instantiation */
 SSL_CTX *init_ssl (bool server,
@@ -366,7 +366,7 @@
 
 void tls_post_encrypt (struct tls_multi *multi, struct buffer *buf);
 
-void show_available_tls_ciphers ();
+void show_available_tls_ciphers (void);
 void get_highest_preference_tls_cipher (char *buf, int size);
 
 int pem_password_callback (char *buf, int size, int rwflag, void *u);
Index: syshead.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/syshead.h,v
retrieving revision 1.16
diff -u -r1.16 syshead.h
--- syshead.h	15 Mar 2003 07:18:00 -0000	1.16
+++ syshead.h	17 Apr 2003 10:51:21 -0000
@@ -134,7 +134,7 @@
 #endif
 
 #ifdef HAVE_ARPA_INET_H
-#ifndef TARGET_OPENBSD
+#if !defined(TARGET_OPENBSD) && !defined(__LCLINT__)
 #include <arpa/inet.h>
 #endif
 #endif
@@ -145,7 +145,7 @@
 
 #ifdef TARGET_LINUX
 
-#ifdef HAVE_NETINET_IF_ETHER_H
+#if defined(HAVE_NETINET_IF_ETHER_H) && !defined(__LCLINT__)
 #include <netinet/if_ether.h>
 #endif
 
Index: thread.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/thread.c,v
retrieving revision 1.5
diff -u -r1.5 thread.c
--- thread.c	16 Mar 2003 08:34:12 -0000	1.5
+++ thread.c	17 Apr 2003 10:51:21 -0000
@@ -45,7 +45,7 @@
 static void
 ssl_pthreads_locking_callback (int mode, int type, char *file, int line)
 {
-  msg (D_OPENSSL_LOCK, "SSL LOCK thread=%4d mode=%s lock=%s %s:%d",
+  msg (D_OPENSSL_LOCK, "SSL LOCK thread=%4lu mode=%s lock=%s %s:%d",
 	   CRYPTO_thread_id (),
 	   (mode & CRYPTO_LOCK) ? "l" : "u",
 	   (type & CRYPTO_READ) ? "r" : "w", file, line);
@@ -83,8 +83,8 @@
       pthread_mutex_init (&(ssl_lock_cs[i]), NULL);
     }
 
-  CRYPTO_set_id_callback ((unsigned long (*)()) ssl_pthreads_thread_id);
-  CRYPTO_set_locking_callback ((void (*)()) ssl_pthreads_locking_callback);
+  CRYPTO_set_id_callback ((unsigned long (*)(void)) ssl_pthreads_thread_id);
+  CRYPTO_set_locking_callback ((void (*)(int, int, const char*, int)) ssl_pthreads_locking_callback);
 }
 
 static void
@@ -113,7 +113,7 @@
   ASSERT (x_main_thread_id);
   ASSERT (!x_work_thread_id);
   ASSERT (!pthread_create (&x_work_thread_id, NULL, start_routine, arg));
-  msg (D_THREAD_DEBUG, "CREATE THREAD ID=%d", x_work_thread_id);
+  msg (D_THREAD_DEBUG, "CREATE THREAD ID=%lu", (unsigned long)x_work_thread_id);
 }
 
 void
Index: thread.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/thread.h,v
retrieving revision 1.5
diff -u -r1.5 thread.h
--- thread.h	21 Feb 2003 16:14:06 -0000	1.5
+++ thread.h	17 Apr 2003 10:51:21 -0000
@@ -58,7 +58,7 @@
 #define MUTEX_UNLOCK(lock)         pthread_mutex_unlock (&lock)
 
 static inline int
-thread_number()
+thread_number(void)
 {
   return (!x_main_thread_id || pthread_self () == x_main_thread_id) ? MAIN_THREAD : WORK_THREAD;
 }
@@ -100,11 +100,11 @@
     }
 }
 
-void thread_init();
-void thread_cleanup();
+void thread_init(void);
+void thread_cleanup(void);
 
 void work_thread_create (void *(*start_routine) (void *), void* arg);
-void work_thread_join ();
+void work_thread_join (void);
 
 #else /* USE_PTHREAD */
 
Index: tun.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/tun.c,v
retrieving revision 1.28
diff -u -r1.28 tun.c
--- tun.c	17 Apr 2003 07:12:16 -0000	1.28
+++ tun.c	17 Apr 2003 10:51:22 -0000
@@ -417,7 +417,7 @@
 	  int		fd;
  
 	  if ((fd = socket(PF_INET, SOCK_DGRAM, 0)) < 0)
-	    msg (M_WARN, "Cannot open control_fd", dev);
+	    msg (M_WARN, "Cannot open control_fd");
 	  else
 	    {
 	      strncpynt (r.ifr_name, tt->actual, IFNAMSIZ);
Index: tun.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/tun.h,v
retrieving revision 1.20
diff -u -r1.20 tun.h
--- tun.h	17 Apr 2003 07:12:16 -0000	1.20
+++ tun.h	17 Apr 2003 10:51:22 -0000
@@ -88,7 +88,7 @@
 #define IFCONFIG_DEFAULT         1
 
 static inline int
-ifconfig_order()
+ifconfig_order(void)
 {
 #if defined(TARGET_LINUX)
   return IFCONFIG_AFTER_TUN_OPEN;

-- 
Matthias Andree

