From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Pre-1.3.3 beta available for testing
Message-ID: <20030219153803.GA32749@...33...>
References: <200302161913.h1GJDuf19905@...41...> <20030219133617.GE6319@...33...>
Mime-Version: 1.0
In-Reply-To: <20030219133617.GE6319@...33...>
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
Date: Wed Feb 19 07:39:04 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Wed, 19 Feb 2003, Matthias Andree wrote:

> On Sun, 16 Feb 2003, James Yonan wrote:
> 
> > Beta is available on CVS as well as here:
> > 
> > http://openvpn.sourceforge.net/beta/openvpn-1.3.2.9.tar.gz
> 
> I tried the current CVS as of some minutes ago on Linux, Solaris and
> FreeBSD.  This first mail is about Linux, Solaris status is in a
> separate mail.

I also found there were some issues with Solaris, patches below.

Note the error message when the Solaris net/if_tun.h include file is
missing is pretty unspecific; ultimately, openvpn.c:504 complains about
an undefined TUNNEWPPA. This might warrant improvement (maybe an
explicit check in configure.ac).

Anyways, there are some bugs in configure.ac that break the VPATH build
on Solaris for me, here is the patch, to be applied on top of my
previous configure.ac patch.

Note that the stuff cannot be compiled on C89 compilers (SunPro Workshop
6) because of the variadic msg() macros in error.h:79.

I understand it's convenient to use a macro like that, and might be more
efficient because the optimizer has something to crunch away (DCE), but
it's a compile killer.

Please also note that _* names are reserved name space. Don't use them
for your functions if you can avoid it, for portability -- they might
screw some linker.

diff -u configure.ac configure.ac
--- configure.ac	19 Feb 2003 12:46:32 -0000
+++ configure.ac	19 Feb 2003 15:04:00 -0000
@@ -27,6 +27,7 @@
 
 AC_INIT([OpenVPN], [1.3.2.9], [openvpn-users@lists.sourceforge.net], [openvpn])
 AM_CONFIG_HEADER(config.h)
+AC_CONFIG_SRCDIR(syshead.h)
 
 AC_ARG_ENABLE(lzo,
    [  --disable-lzo           Do not compile LZO compression support],
@@ -66,7 +67,7 @@
 
 AC_ARG_WITH(ssl-lib,
    [  --with-ssl-lib=DIR      Crypto/SSL Library location],
-   [LIBS="$LIBS -L$withval"] 
+   [LDFLAGS="$LDFLAGS -L$withval"] 
 )
 
 AC_ARG_WITH(lzo-headers,
@@ -77,7 +78,7 @@
 
 AC_ARG_WITH(lzo-lib,
    [  --with-lzo-lib=DIR      LZO Library location],
-   [LIBS="$LIBS -L$withval"] 
+   [LDFLAGS="$LDFLAGS -L$withval"] 
 )
 
 AC_ARG_WITH(ifconfig-path,
@@ -97,6 +98,9 @@
 AC_CANONICAL_SYSTEM
 AM_INIT_AUTOMAKE(openvpn, [$PACKAGE_VERSION])
 
+dnl fix search path, to allow compilers to find syshead.h
+CPPFLAGS="$CPPFLAGS -I${srcdir}"
+
 dnl check target OS
 openvpn_target=$target
 if test $target_alias; then

I also need these two patches to compile the stuff on SUNpro:

Index: error.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/error.c,v
retrieving revision 1.10
diff -u -r1.10 error.c
--- error.c	9 Dec 2002 15:40:34 -0000	1.10
+++ error.c	19 Feb 2003 15:14:07 -0000
@@ -114,7 +114,7 @@
 int msg_line_num;
 
 void
-_msg (unsigned int flags, const char *format, ...)
+msg (unsigned int flags, const char *format, ...)
 {
   va_list arglist;
   int level;
@@ -124,6 +124,9 @@
   char *m2;
   char *tmp;
   int e;
+
+  if (!(((flags) & M_DEBUG_LEVEL) < _debug_level || ((flags) & M_FATAL)))
+      return;
 
   e = errno;
 
Index: error.h
===================================================================
RCS file: /cvsroot/openvpn/openvpn/error.h,v
retrieving revision 1.8
diff -u -r1.8 error.h
--- error.h	9 Dec 2002 15:40:34 -0000	1.8
+++ error.h	19 Feb 2003 15:14:07 -0000
@@ -76,11 +76,7 @@
  */
 #define LOGLEV(log_level, mute_level, other) (((log_level)-1) | ENCODE_MUTE_LEVEL(mute_level) | other)
 
-#define msg(flags, args...) \
-    do { if (((flags) & M_DEBUG_LEVEL) < _debug_level || ((flags) & M_FATAL)) \
-    _msg((flags), args); } while (false)
-
-void _msg (unsigned int flags, const char *format, ...); /* should be called via msg above */
+void msg (unsigned int flags, const char *format, ...);
 
 void error_reset ();
 void set_check_status (int info_level, int verbose_level);


Index: buffer.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/buffer.c,v
retrieving revision 1.7
diff -u -r1.7 buffer.c
--- buffer.c	9 May 2002 19:30:42 -0000	1.7
+++ buffer.c	19 Feb 2003 15:36:09 -0000
@@ -160,7 +160,7 @@
   e->back = thread->gc_stack;
   thread->gc_stack = e;
   /*printf("GC MALLOC " ptr_format " size=%d lev=%d\n", e, s, e->level); */
-  return (void *) e + sizeof (struct gc_entry);
+  return (char *) e + sizeof (struct gc_entry);
 }
 
 void
Index: crypto.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/crypto.c,v
retrieving revision 1.11
diff -u -r1.11 crypto.c
--- crypto.c	6 Feb 2003 09:49:51 -0000	1.11
+++ crypto.c	19 Feb 2003 15:36:10 -0000
@@ -77,9 +77,6 @@
 #define CRYPT_ERROR(format) \
   do { msg (D_CRYPT_ERRORS, "%s: " format, error_prefix); goto error_exit; } while (false)
 
-#define CRYPT_ERROR_ARGS(format, args...) \
-  do { msg (D_CRYPT_ERRORS, "%s: " format, error_prefix, args); goto error_exit; } while (false)
-
 void
 openvpn_encrypt (struct buffer *buf, struct buffer work,
 		 const struct crypto_options *opt,
@@ -339,9 +336,10 @@
 	      packet_id_add (&opt->packet_id->rec, &pin);
 	      if (opt->pid_persist && opt->packet_id_long_form)
 		packet_id_persist_save_obj (opt->pid_persist, opt->packet_id);
-	    }
-	  else
-	    CRYPT_ERROR_ARGS ("bad packet ID (may be a replay): %s", packet_id_net_print (&pin));
+	    } else {
+	      msg(D_CRYPT_ERRORS, "%s: bad packet ID (may be a replay): %s", error_prefix, packet_id_net_print(&pin));
+	      goto error_exit;
+	  }
 	}
       *buf = work;
     }

