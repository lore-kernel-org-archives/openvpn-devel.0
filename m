From: Alon Bar-Lev <alon.barlev@...277...>
Date: Tue, 21 Feb 2012 03:22:38 +0200
Message-Id: <1329787361-26096-33-git-send-email-alon.barlev@...277...>
In-Reply-To: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
References: <1329787361-26096-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 32/35] build: proper lzo detection and usage
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
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac                  |  101 ++++++++++++++++++++---------------------
 doc/doxygen/doc_compression.h |    2 +-
 src/openvpn/Makefile.am       |    2 +
 src/openvpn/forward.c         |    4 +-
 src/openvpn/init.c            |   14 +++---
 src/openvpn/lzo.c             |    4 +-
 src/openvpn/lzo.h             |   13 +++--
 src/openvpn/openvpn.h         |    4 +-
 src/openvpn/options.c         |   18 +++++---
 src/openvpn/options.h         |    2 +-
 src/openvpn/sig.c             |    2 +-
 11 files changed, 86 insertions(+), 80 deletions(-)

diff --git a/configure.ac b/configure.ac
index 71788c7..5a4f8b1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -40,9 +40,9 @@ AC_USE_SYSTEM_EXTENSIONS
 
 AC_ARG_ENABLE(
 	[lzo],
-	[AS_HELP_STRING([--disable-lzo], [disable LZO compression support])],
+	[AS_HELP_STRING([--enable-lzo], [enable LZO compression support])],
 	,
-	[enable_lzo="yes"]
+	[enable_lzo="no"]
 )
 
 AC_ARG_ENABLE(
@@ -240,19 +240,6 @@ AC_ARG_WITH(
 )
 
 AC_ARG_WITH(
-	[lzo-headers],
-	[AS_HELP_STRING([--with-lzo-headers=DIR], [LZO Include files location])],
-	[LZO_HDR_DIR="$withval"]
-	[CPPFLAGS="$CPPFLAGS -I$withval"] 
-)
-
-AC_ARG_WITH(
-	[lzo-lib],
-	[AS_HELP_STRING([--with-lzo-lib=DIR], [LZO Library location])],
-	[LDFLAGS="$LDFLAGS -L$withval"] 
-)
-
-AC_ARG_WITH(
 	[mem-check],
 	[AS_HELP_STRING([--with-mem-check=TYPE], [build with debug memory checking, TYPE=dmalloc|valgrind|ssl])],
 	,
@@ -650,41 +637,44 @@ case "${with_mem_check}" in
 		;;
 esac
 
-dnl
-dnl check for LZO library
-dnl
-if test "${enable_lzo}" = "yes" && test "${enable_lzo_stub}" = "no"; then
-   LZO_H=""
-   AC_CHECKING([for LZO Library and Header files])
-   AC_CHECK_HEADER(lzo/lzo1x.h,
-	[ LZO_H="2"
-	  lzolibs="lzo2 lzo"
-	  AC_DEFINE(LZO_HEADER_DIR, 1, [Use lzo/ directory prefix for LZO header files (for LZO 2.0)])
-	],
-	[ AC_CHECK_HEADER(lzo1x.h, [ LZO_H="1" ; lzolibs=lzo ]) ]
-   )
-
-   if test -n "$LZO_H"; then
-     havelzolib=0
-     for i in $lzolibs ; do
-	if test $havelzolib = 1 ; then break ; fi
-	AC_CHECK_LIB($i, lzo1x_1_15_compress,
-          [
-	    LIBS="${LIBS} -l$i"
-	    AC_DEFINE(USE_LZO, 1, [Use LZO compression library])
-	    AC_DEFINE_UNQUOTED(LZO_VERSION_NUM, "$LZO_H", [LZO version number])
-	    havelzolib=1
-	  ]
-        )
-     done
-     if test $havelzolib = 0 ; then
-       AC_MSG_ERROR([LZO headers were found but LZO library was not found])
-     fi
-   else
-     AC_MSG_RESULT([LZO headers were not found])
-     AC_MSG_RESULT([LZO library available from http://www.oberhumer.com/opensource/lzo/])
-     AC_MSG_ERROR([Or try ./configure --disable-lzo OR ./configure --enable-lzo-stub])
-   fi
+AC_ARG_VAR([LZO_CFLAGS], [C compiler flags for lzo])
+AC_ARG_VAR([LZO_LIBS], [linker flags for lzo])
+have_lzo="yes"
+if test -z "${LZO_LIBS}"; then
+	AC_CHECK_LIB(
+		[lzo2],
+		[lzo1x_1_15_compress],
+		[LZO_LIBS="-llzo2"],
+		[AC_CHECK_LIB(
+			[lzo],
+			[lzo1x_1_15_compress],
+			[LZO_LIBS="-llzo"],
+			[have_lzo="no"]
+		)]
+	)
+fi
+if test "${have_lzo}" = "yes"; then
+	saved_CFLAGS="${CFLAGS}"
+	CFLAGS="${CFLAGS} ${LZO_CFLAGS}"
+	AC_CHECK_HEADERS(
+		[lzo/lzoutil.h],
+		,
+		[AC_CHECK_HEADERS(
+			[lzoutil.h],
+			,
+			[AC_MSG_ERROR([lzoutil.h is missing])]
+		)]
+	)
+	AC_CHECK_HEADERS(
+		[lzo/lzo1x.h],
+		,
+		[AC_CHECK_HEADERS(
+			[lzo1x.h],
+			,
+			[AC_MSG_ERROR([lzo1x.h is missing])]
+		)]
+	)
+	CFLAGS="${saved_CFLAGS}"
 fi
 
 PKG_CHECK_MODULES(
@@ -839,11 +829,16 @@ if test "${enable_selinux}" = "yes"; then
 	AC_DEFINE([ENABLE_SELINUX], [1], [SELinux support])
 fi
 
+if test "${enable_lzo}" = "yes"; then
+	test "${have_lzo}" != "yes" && AC_MSG_ERROR([lzo enabled but missing])
+	OPTIONAL_LZO_CFLAGS="${LZO_CFLAGS}"
+	OPTIONAL_LZO_LIBS="${LZO_LIBS}"
+	AC_DEFINE([ENABLE_LZO], [1], [Enable LZO compression library])
+fi
 if test "${enable_lzo_stub}" = "yes"; then
 	test "${enable_lzo}" = "yes" && AC_MSG_ERROR([Cannot have both lzo stub and lzo enabled])
 	AC_DEFINE([ENABLE_LZO_STUB], [1], [Enable LZO stub capability])
-	AC_DEFINE([USE_LZO], [1], [Enable LZO compression library])
-	AC_DEFINE([LZO_VERSION_NUM], ["STUB"], [LZO version number])
+	AC_DEFINE([ENABLE_LZO], [1], [Enable LZO compression library])
 fi
 
 if test "${enable_pkcs11}" = "yes"; then
@@ -881,6 +876,8 @@ AC_SUBST([TAP_WIN_MIN_MINOR])
 
 AC_SUBST([OPTIONAL_DL_LIBS])
 AC_SUBST([OPTIONAL_SELINUX_LIBS])
+AC_SUBST([OPTIONAL_LZO_CFLAGS])
+AC_SUBST([OPTIONAL_LZO_LIBS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_CFLAGS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
 
diff --git a/doc/doxygen/doc_compression.h b/doc/doxygen/doc_compression.h
index c28c0b6..bdc4a7e 100644
--- a/doc/doxygen/doc_compression.h
+++ b/doc/doxygen/doc_compression.h
@@ -68,7 +68,7 @@
  *
  * @par Settings that control this module's activity
  * Whether or not the Data Channel Compression module is active depends on
- * the compile-time \c USE_LZO preprocessor macro and the runtime flags
+ * the compile-time \c ENABLE_LZO preprocessor macro and the runtime flags
  * stored in \c lzo_compress_workspace.flags of the associated VPN tunnel.
  * The latter are initialized from \c options.lzo, which gets its value
  * from the process's configuration sources, such as its configuration
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 102860e..79016c3 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -17,6 +17,7 @@ MAINTAINERCLEANFILES = \
 INCLUDES = -I$(top_srcdir)/include
 
 AM_CFLAGS = \
+	$(OPTIONAL_LZO_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS)
 
 sbin_PROGRAMS = openvpn
@@ -100,6 +101,7 @@ openvpn_SOURCES = \
 	cryptoapi.h cryptoapi.c
 openvpn_LDADD = \
 	$(SOCKETS_LIBS) \
+	$(OPTIONAL_LZO_LIBS) \
 	$(OPTIONAL_PKCS11_HELPER_LIBS) \
 	$(OPTIONAL_SELINUX_LIBS) \
 	$(OPTIONAL_DL_LIBS)
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index ace7d2a..46bbfe7 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -438,7 +438,7 @@ encrypt_sign (struct context *c, bool comp_frag)
 
   if (comp_frag)
     {
-#ifdef USE_LZO
+#ifdef ENABLE_LZO
       /* Compress the packet. */
       if (lzo_defined (&c->c2.lzo_compwork))
 	lzo_compress (&c->c2.buf, b->lzo_compress_buf, &c->c2.lzo_compwork, &c->c2.frame);
@@ -840,7 +840,7 @@ process_incoming_link (struct context *c)
 	fragment_incoming (c->c2.fragment, &c->c2.buf, &c->c2.frame_fragment);
 #endif
 
-#ifdef USE_LZO
+#ifdef ENABLE_LZO
       /* decompress the incoming packet */
       if (lzo_defined (&c->c2.lzo_compwork))
 	lzo_decompress (&c->c2.buf, c->c2.buffers->lzo_decompress_buf, &c->c2.lzo_compwork, &c->c2.frame);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f2faef3..c3a2c58 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1789,7 +1789,7 @@ do_deferred_options (struct context *c, const unsigned int found)
     }
 #endif
 
-#ifdef USE_LZO
+#ifdef ENABLE_LZO
   if (found & OPT_P_COMP)
     {
       if (lzo_defined (&c->c2.lzo_compwork))
@@ -2368,7 +2368,7 @@ do_init_crypto (struct context *c, const unsigned int flags)
 static void
 do_init_frame (struct context *c)
 {
-#ifdef USE_LZO
+#ifdef ENABLE_LZO
   /*
    * Initialize LZO compression library.
    */
@@ -2391,7 +2391,7 @@ do_init_frame (struct context *c)
       lzo_adjust_frame_parameters (&c->c2.frame_fragment_omit);	/* omit LZO frame delta from final frame_fragment */
 #endif
     }
-#endif /* USE_LZO */
+#endif /* ENABLE_LZO */
 
 #ifdef ENABLE_SOCKS
   /*
@@ -2562,7 +2562,7 @@ init_context_buffers (const struct frame *frame)
   b->decrypt_buf = alloc_buf (BUF_SIZE (frame));
 #endif
 
-#ifdef USE_LZO
+#ifdef ENABLE_LZO
   b->lzo_compress_buf = alloc_buf (BUF_SIZE (frame));
   b->lzo_decompress_buf = alloc_buf (BUF_SIZE (frame));
 #endif
@@ -2579,7 +2579,7 @@ free_context_buffers (struct context_buffers *b)
       free_buf (&b->read_tun_buf);
       free_buf (&b->aux_buf);
 
-#ifdef USE_LZO
+#ifdef ENABLE_LZO
       free_buf (&b->lzo_compress_buf);
       free_buf (&b->lzo_decompress_buf);
 #endif
@@ -3417,7 +3417,7 @@ init_instance (struct context *c, const struct env_set *env, const unsigned int
       goto sig;
   }
 
-#ifdef USE_LZO
+#ifdef ENABLE_LZO
   /* initialize LZO compression library. */
   if ((options->lzo & LZO_SELECTED) && (c->mode == CM_P2P || child))
     lzo_compress_init (&c->c2.lzo_compwork, options->lzo);
@@ -3534,7 +3534,7 @@ close_instance (struct context *c)
 	/* if xinetd/inetd mode, don't allow restart */
 	do_close_check_if_restart_permitted (c);
 
-#ifdef USE_LZO
+#ifdef ENABLE_LZO
 	if (lzo_defined (&c->c2.lzo_compwork))
 	  lzo_compress_uninit (&c->c2.lzo_compwork);
 #endif
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index ca06f71..4becd4d 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -28,7 +28,7 @@
 
 #include "syshead.h"
 
-#ifdef USE_LZO
+#ifdef ENABLE_LZO
 
 #include "lzo.h"
 #include "error.h"
@@ -301,4 +301,4 @@ void lzo_print_stats (const struct lzo_compress_workspace *lzo_compwork, struct
 
 #else
 static void dummy(void) {}
-#endif /* USE_LZO */
+#endif /* ENABLE_LZO */
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index da4bd88..472204d 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -32,7 +32,7 @@
  */
 
 
-#ifdef USE_LZO
+#ifdef ENABLE_LZO
 
 /**
  * @addtogroup compression
@@ -40,11 +40,14 @@
  */
 
 #ifndef ENABLE_LZO_STUB
-#ifdef LZO_HEADER_DIR
+#if defined(HAVE_LZO_LZOUTIL_H)
 #include "lzo/lzoutil.h"
-#include "lzo/lzo1x.h"
-#else
+#elif defined(HAVE_LZOUTIL_H)
 #include "lzoutil.h"
+#endif
+#if defined(HAVE_LZO_LZO1X_H)
+#include "lzo/lzo1x.h"
+#elif defined(HAVE_LZO1X_H)
 #include "lzo1x.h"
 #endif
 #endif
@@ -340,5 +343,5 @@ lzo_defined (const struct lzo_compress_workspace *lzowork)
 /** @} addtogroup compression */
 
 
-#endif /* USE_LZO */
+#endif /* ENABLE_LZO */
 #endif
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index a07b03f..5af422e 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -105,7 +105,7 @@ struct context_buffers
 #endif
 
   /* workspace buffers for LZO compression */
-#ifdef USE_LZO
+#ifdef ENABLE_LZO
   struct buffer lzo_compress_buf;
   struct buffer lzo_decompress_buf;
 #endif
@@ -372,7 +372,7 @@ struct context_2
 
 #endif /* USE_CRYPTO */
 
-#ifdef USE_LZO
+#ifdef ENABLE_LZO
   struct lzo_compress_workspace lzo_compwork;
                                 /**< Compression workspace used by the
                                  *   \link compression Data Channel
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ff5bf08..45d2876 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -75,8 +75,12 @@ const char title_string[] =
 #endif /* defined(USE_POLARSSL) */
 #endif /* USE_SSL */
 #endif /* USE_CRYPTO */
-#ifdef USE_LZO
-  " [LZO" LZO_VERSION_NUM "]"
+#ifdef ENABLE_LZO
+#ifdef ENABLE_LZO_STUB
+  " [LZO (STUB)]"
+#else
+  " [LZO]"
+#endif
 #endif
 #if EPOLL
   " [EPOLL]"
@@ -354,7 +358,7 @@ static const char usage_message[] =
 #ifdef ENABLE_DEBUG
   "--gremlin mask  : Special stress testing mode (for debugging only).\n"
 #endif
-#ifdef USE_LZO
+#ifdef ENABLE_LZO
   "--comp-lzo      : Use fast LZO compression -- may add up to 1 byte per\n"
   "                  packet for uncompressible data.\n"
   "--comp-noadapt  : Don't use adaptive compression when --comp-lzo\n"
@@ -1512,7 +1516,7 @@ show_settings (const struct options *o)
 
   SHOW_BOOL (fast_io);
 
-#ifdef USE_LZO
+#ifdef ENABLE_LZO
   SHOW_INT (lzo);
 #endif
 
@@ -2954,7 +2958,7 @@ options_string (const struct options *o,
       tt = NULL;
     }
 
-#ifdef USE_LZO
+#ifdef ENABLE_LZO
   if (o->lzo & LZO_SELECTED)
     buf_printf (&out, ",comp-lzo");
 #endif
@@ -6180,7 +6184,7 @@ add_option (struct options *options,
       options->passtos = true;
     }
 #endif
-#ifdef USE_LZO
+#ifdef ENABLE_LZO
   else if (streq (p[0], "comp-lzo"))
     {
       VERIFY_PERMISSION (OPT_P_COMP);
@@ -6206,7 +6210,7 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_COMP);
       options->lzo &= ~LZO_ADAPTIVE;
     }
-#endif /* USE_LZO */
+#endif /* ENABLE_LZO */
 #ifdef USE_CRYPTO
   else if (streq (p[0], "show-ciphers"))
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 57b88b7..87fea48 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -343,7 +343,7 @@ struct options
   /* optimize TUN/TAP/UDP writes */
   bool fast_io;
 
-#ifdef USE_LZO
+#ifdef ENABLE_LZO
   /* LZO_x flags from lzo.h */
   unsigned int lzo;
 #endif
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index df8035e..924a343 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -255,7 +255,7 @@ print_status (const struct context *c, struct status_output *so)
   status_printf (so, "TCP/UDP read bytes," counter_format, c->c2.link_read_bytes);
   status_printf (so, "TCP/UDP write bytes," counter_format, c->c2.link_write_bytes);
   status_printf (so, "Auth read bytes," counter_format, c->c2.link_read_bytes_auth);
-#ifdef USE_LZO
+#ifdef ENABLE_LZO
   if (lzo_defined (&c->c2.lzo_compwork))
     lzo_print_stats (&c->c2.lzo_compwork, so);
 #endif
-- 
1.7.3.4


