From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Pre-1.3.3 beta available for testing
Message-ID: <20030219154840.GB32749@...33...>
References: <200302161913.h1GJDuf19905@...41...>
Mime-Version: 1.0
In-Reply-To: <200302161913.h1GJDuf19905@...41...>
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
Date: Wed Feb 19 07:50:30 2003
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

OK,

here is a full patch for your convenience without the "apply on top"
junk, with this patch, the current CVS compiles on:

SuSE Linux 7.3 x86 gcc 2.95.3
SuSE Linux 8.1 x86 gcc 3.2
FreeBSD 4-STABLE x86 gcc 2.95.3+FreeBSD
Solaris 8 Sparc gcc 2.95.3
Solaris 8 Sparc SunPro Workshop 6.

The unfixed bug that remains that I am aware of is the --disable-crypto
issue I reported earlier today. I don't think many people will use this
configure option, but it should be fixed nonetheless, that's what beta
versions are good for :-)

Thanks for the continued maintenance of OpenVPN, BTW.

# Makefile.am  |   18 ++++++++++++++++--
# buffer.c     |    2 +-
# configure.ac |   11 +++++++++--
# crypto.c     |   10 ++++------
# error.c      |    5 ++++-
# error.h      |    6 +-----
# openvpn.spec |    1 -
# 7 files changed, 35 insertions(+), 18 deletions(-)

Index: buffer.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/buffer.c,v
retrieving revision 1.7
diff -u -r1.7 buffer.c
--- buffer.c	9 May 2002 19:30:42 -0000	1.7
+++ buffer.c	19 Feb 2003 15:43:56 -0000
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
+++ crypto.c	19 Feb 2003 15:43:57 -0000
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
Index: error.c
===================================================================
RCS file: /cvsroot/openvpn/openvpn/error.c,v
retrieving revision 1.10
diff -u -r1.10 error.c
--- error.c	9 Dec 2002 15:40:34 -0000	1.10
+++ error.c	19 Feb 2003 15:43:57 -0000
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
+++ error.h	19 Feb 2003 15:43:57 -0000
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
Index: configure.ac
===================================================================
RCS file: /cvsroot/openvpn/openvpn/configure.ac,v
retrieving revision 1.51
diff -u -r1.51 configure.ac
--- configure.ac	16 Feb 2003 19:01:49 -0000	1.51
+++ configure.ac	19 Feb 2003 15:43:57 -0000
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
@@ -137,8 +141,11 @@
 dnl Checks for typedefs, structures, and compiler characteristics.
 AC_C_CONST
 AC_C_INLINE
+AC_C_VOLATILE
+AC_TYPE_OFF_T
 AC_TYPE_PID_T
 AC_TYPE_SIZE_T
+AC_TYPE_UID_T
 AC_HEADER_TIME
 
 dnl Check for more header files.
Index: Makefile.am
===================================================================
RCS file: /cvsroot/openvpn/openvpn/Makefile.am,v
retrieving revision 1.3
diff -u -r1.3 Makefile.am
--- Makefile.am	25 Jun 2002 06:56:16 -0000	1.3
+++ Makefile.am	19 Feb 2003 15:43:57 -0000
@@ -24,9 +24,23 @@
 #
 
 sbin_PROGRAMS = openvpn
-openvpn_SOURCES = basic.h buffer.c buffer.h circ_list.h common.h config.h crypto.c crypto.h errlevel.h error.c error.h fdmisc.c fdmisc.h gremlin.c gremlin.h interval.h lzo.c lzo.h memdbg.h misc.c misc.h mtu.h openvpn.c openvpn.h options.c options.h packet_id.c packet_id.h reliable.c reliable.h session_id.c session_id.h shaper.c shaper.h socket.c socket.h ssl.c ssl.h syshead.h thread.c thread.h tun.c tun.h
+nodist_openvpn_SOURCES = config.h
+openvpn_SOURCES = basic.h buffer.c buffer.h circ_list.h common.h \
+		  crypto.c crypto.h errlevel.h error.c error.h \
+		  fdmisc.c fdmisc.h gremlin.c gremlin.h interval.h \
+		  lzo.c lzo.h memdbg.h misc.c misc.h mtu.h openvpn.c \
+		  openvpn.h options.c options.h packet_id.c \
+		  packet_id.h reliable.c reliable.h session_id.c \
+		  session_id.h shaper.c shaper.h socket.c socket.h \
+		  ssl.c ssl.h syshead.h thread.c thread.h tun.c tun.h
 
 KEY_FILES = dh1024.pem client.crt client.key server.crt server.key tmp-ca.crt tmp-ca.key
 
 man_MANS = openvpn.8
-EXTRA_DIST = $(KEY_FILES)
+EXTRA_DIST = $(KEY_FILES) $(man_MANS) \
+	     COPYRIGHT.GPL PORTS openvpn.spec \
+	     easy-rsa sample-config-files sample-keys \
+	     sample-scripts
+
+dist-hook:
+	cd $(distdir) && for i in $(EXTRA_DIST) ; do find $$i -name CVS -type d -prune -exec rm -r '{}' ';' ; done
Index: openvpn.spec
===================================================================
RCS file: /cvsroot/openvpn/openvpn/openvpn.spec,v
retrieving revision 1.59
diff -u -r1.59 openvpn.spec
--- openvpn.spec	16 Feb 2003 19:01:49 -0000	1.59
+++ openvpn.spec	19 Feb 2003 15:43:57 -0000
@@ -22,7 +22,6 @@
 %setup -q
 
 %build
-./pre-touch
 %configure --enable-pthread
 %__make
 

