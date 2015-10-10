From: Gert Doering <gert@...1296...>
Date: Sat, 10 Oct 2015 18:34:49 +0200
Message-Id: <1444494889-28925-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Remove support for snappy compression.
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

LZ4 is using less CPU at similar performance, and it is easier to
build and support for binary installs (as it does not require C++
and a C++ runtime).  Since it was never supported in any formally
released OpenVPN version, just drop it again.

This leaves in the compression opcode for Snappy for documentation
purposes.

trac #617

Signed-off-by: Gert Doering <gert@...1296...>
---
 configure.ac            |  48 ------------
 doc/openvpn.8           |   6 +-
 src/openvpn/Makefile.am |   3 -
 src/openvpn/comp.c      |  11 ---
 src/openvpn/comp.h      |  11 +--
 src/openvpn/init.c      |   6 +-
 src/openvpn/options.c   |  10 ---
 src/openvpn/snappy.c    | 189 ------------------------------------------------
 src/openvpn/snappy.h    |  39 ----------
 src/openvpn/syshead.h   |   2 +-
 10 files changed, 9 insertions(+), 316 deletions(-)
 delete mode 100644 src/openvpn/snappy.c
 delete mode 100644 src/openvpn/snappy.h

diff --git a/configure.ac b/configure.ac
index 2e651d8..77b4915 100644
--- a/configure.ac
+++ b/configure.ac
@@ -66,12 +66,6 @@ AC_ARG_ENABLE(
 	[enable_lzo="yes"]
 )
 
-AC_ARG_ENABLE(snappy,
-	[  --disable-snappy        Disable Snappy compression support],
-	[enable_snappy="$enableval"],
-	[enable_snappy="yes"]
-)
-
 AC_ARG_ENABLE(lz4,
 	[  --disable-lz4           Disable LZ4 compression support],
 	[enable_lz4="$enableval"],
@@ -952,45 +946,6 @@ if test "${have_lzo}" = "yes"; then
 fi
 
 dnl
-dnl check for Snappy library
-dnl
-
-AC_ARG_VAR([SNAPPY_CFLAGS], [C compiler flags for snappy])
-AC_ARG_VAR([SNAPPY_LIBS], [linker flags for snappy])
-if test "$enable_snappy" = "yes" && test "$enable_comp_stub" = "no"; then
-    AC_CHECKING([for Snappy Library and Header files])
-    havesnappylib=1
-
-    # if SNAPPY_LIBS is set, we assume it will work, otherwise test
-    if test -z "${SNAPPY_LIBS}"; then
-	AC_CHECK_LIB(snappy, snappy_compress,
-	    [ SNAPPY_LIBS="-lsnappy" ],
-	    [
-	        AC_MSG_RESULT([Snappy library not found.])
-	        havesnappylib=0
-	    ])
-    fi
-
-    saved_CFLAGS="${CFLAGS}"
-    CFLAGS="${CFLAGS} ${SNAPPY_CFLAGS}"
-    AC_CHECK_HEADERS(snappy-c.h,
-       ,
-       [
-	   AC_MSG_RESULT([Snappy headers not found.])
-	   havesnappylib=0
-       ])
-
-    if test $havesnappylib = 0 ; then
-	AC_MSG_RESULT([Snappy library available from http://code.google.com/p/snappy/])
-        AC_MSG_ERROR([Or try ./configure --disable-snappy OR ./configure --enable-comp-stub])
-    fi
-    OPTIONAL_SNAPPY_CFLAGS="${SNAPPY_CFLAGS}"
-    OPTIONAL_SNAPPY_LIBS="${SNAPPY_LIBS}"
-    AC_DEFINE(ENABLE_SNAPPY, 1, [Enable Snappy compression library])
-    CFLAGS="${saved_CFLAGS}"
-fi
-
-dnl
 dnl check for LZ4 library
 dnl
 
@@ -1154,7 +1109,6 @@ if test "${enable_lzo}" = "yes"; then
 fi
 if test "${enable_comp_stub}" = "yes"; then
 	test "${enable_lzo}" = "yes" && AC_MSG_ERROR([Cannot have both comp stub and lzo enabled (use --disable-lzo)])
-	test "${enable_snappy}" = "yes" && AC_MSG_ERROR([Cannot have both comp stub and snappy enabled (use --disable-snappy)])
 	test "${enable_lz4}" = "yes" && AC_MSG_ERROR([Cannot have both comp stub and LZ4 enabled (use --disable-lz4)])
 	AC_DEFINE([ENABLE_COMP_STUB], [1], [Enable compression stub capability])
 fi
@@ -1220,8 +1174,6 @@ AC_SUBST([OPTIONAL_CRYPTO_CFLAGS])
 AC_SUBST([OPTIONAL_CRYPTO_LIBS])
 AC_SUBST([OPTIONAL_LZO_CFLAGS])
 AC_SUBST([OPTIONAL_LZO_LIBS])
-AC_SUBST([OPTIONAL_SNAPPY_CFLAGS])
-AC_SUBST([OPTIONAL_SNAPPY_LIBS])
 AC_SUBST([OPTIONAL_LZ4_CFLAGS])
 AC_SUBST([OPTIONAL_LZ4_LIBS])
 AC_SUBST([OPTIONAL_SYSTEMD_LIBS])
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 829b09c..3a86409 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2495,9 +2495,9 @@ Enable a compression algorithm.
 
 The
 .B algorithm
-parameter may be "snappy", "lzo", "lz4", or empty.  Snappy, LZO and LZ4
-are different compression algorithms, with Snappy generally
-offering the best performance while LZ4 is faster with less CPU usage.
+parameter may be "lzo", "lz4", or empty.  LZO and LZ4
+are different compression algorithms, with LZ4 generally
+offering the best performance with least CPU usage.
 For backwards compatibility with OpenVPN versions before 2.4, use "lzo"
 (which is identical to the older option "\-\-comp\-lzo yes").
 
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index d089f50..c840f16 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -26,7 +26,6 @@ AM_CFLAGS = \
 	$(TAP_CFLAGS) \
 	$(OPTIONAL_CRYPTO_CFLAGS) \
 	$(OPTIONAL_LZO_CFLAGS) \
-	$(OPTIONAL_SNAPPY_CFLAGS) \
 	$(OPTIONAL_LZ4_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS)
 if WIN32
@@ -102,7 +101,6 @@ openvpn_SOURCES = \
 	session_id.c session_id.h \
 	shaper.c shaper.h \
 	sig.c sig.h \
-	snappy.c snappy.h \
 	socket.c socket.h \
 	socks.c socks.h \
 	ssl.c ssl.h  ssl_backend.h \
@@ -121,7 +119,6 @@ openvpn_LDADD = \
 	$(top_builddir)/src/compat/libcompat.la \
 	$(SOCKETS_LIBS) \
 	$(OPTIONAL_LZO_LIBS) \
-	$(OPTIONAL_SNAPPY_LIBS) \
 	$(OPTIONAL_LZ4_LIBS) \
 	$(OPTIONAL_PKCS11_HELPER_LIBS) \
 	$(OPTIONAL_CRYPTO_LIBS) \
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 4ac589f..706ad7e 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -58,14 +58,6 @@ comp_init(const struct compress_options *opt)
       (*compctx->alg.compress_init)(compctx);
       break;
 #endif
-#ifdef ENABLE_SNAPPY
-    case COMP_ALG_SNAPPY:
-      ALLOC_OBJ_CLEAR (compctx, struct compress_context);
-      compctx->flags = opt->flags;
-      compctx->alg = snappy_alg;
-      (*compctx->alg.compress_init)(compctx);
-      break;
-#endif
 #ifdef ENABLE_LZ4
     case COMP_ALG_LZ4:
       ALLOC_OBJ_CLEAR (compctx, struct compress_context);
@@ -129,9 +121,6 @@ comp_generate_peer_info_string(const struct compress_options *opt, struct buffer
 #if defined(ENABLE_LZ4)
 	  buf_printf (out, "IV_LZ4=1\n");
 #endif
-#if defined(ENABLE_SNAPPY)
-	  buf_printf (out, "IV_SNAPPY=1\n");
-#endif
 #if defined(ENABLE_LZO)
 	  buf_printf (out, "IV_LZO=1\n");
 	  lzo_avail = true;
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index bfa25fd..716b1c0 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -24,7 +24,7 @@
 
 /*
  * Generic compression support.  Currently we support
- * Snappy, LZO 2 and LZ4.
+ * LZO 2 and LZ4.
  */
 #ifndef OPENVPN_COMP_H
 #define OPENVPN_COMP_H
@@ -40,7 +40,7 @@
 #define COMP_ALG_UNDEF  0
 #define COMP_ALG_STUB   1 /* support compression command byte and framing without actual compression */
 #define COMP_ALG_LZO    2 /* LZO algorithm */
-#define COMP_ALG_SNAPPY 3 /* Snappy algorithm */
+#define COMP_ALG_SNAPPY 3 /* Snappy algorithm (no longer supported) */
 #define COMP_ALG_LZ4    4 /* LZ4 algorithm */
 
 /* Compression flags */
@@ -101,10 +101,6 @@ struct compress_alg
 #include "lzo.h"
 #endif
 
-#ifdef ENABLE_SNAPPY
-#include "snappy.h"
-#endif
-
 #ifdef ENABLE_LZ4
 #include "comp-lz4.h"
 #endif
@@ -127,9 +123,6 @@ union compress_workspace_union
 #ifdef ENABLE_LZO
   struct lzo_compress_workspace lzo;
 #endif
-#ifdef ENABLE_SNAPPY
-  struct snappy_workspace snappy;
-#endif
 #ifdef ENABLE_LZ4
   struct lz4_workspace lz4;
 #endif
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c32a809..5dd8781 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2379,11 +2379,11 @@ do_init_frame (struct context *c)
     {
       comp_add_to_extra_frame (&c->c2.frame);
 
-#if !defined(ENABLE_SNAPPY) && !defined(ENABLE_LZ4)
+#if !defined(ENABLE_LZ4)
       /*
        * Compression usage affects buffer alignment when non-swapped algs
        * such as LZO is used.
-       * Newer algs like Snappy and comp-stub with COMP_F_SWAP don't need
+       * Newer algs like LZ4 and comp-stub with COMP_F_SWAP don't need
        * any special alignment because of the control-byte swap approach.
        * LZO alignment (on the other hand) is problematic because
        * the presence of the control byte means that either the output of
@@ -2394,7 +2394,7 @@ do_init_frame (struct context *c)
        * dispatch if packet is uncompressed) at the cost of requiring
        * decryption output to be written to an unaligned buffer, so
        * it's more of a tradeoff than an optimal solution and we don't
-       * include it when we are doing a modern build with Snappy or LZ4.
+       * include it when we are doing a modern build with LZ4.
        * Strictly speaking, on the server it would be better to execute
        * this code for every connection after we decide the compression
        * method, but currently the frame code doesn't appear to be
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7906f46..3c3d48c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -80,9 +80,6 @@ const char title_string[] =
 #ifdef ENABLE_LZO
   " [LZO]"
 #endif
-#ifdef ENABLE_SNAPPY
-  " [SNAPPY]"
-#endif
 #ifdef ENABLE_LZ4
   " [LZ4]"
 #endif
@@ -6293,13 +6290,6 @@ add_option (struct options *options,
 	      options->comp.flags = 0;
 	    }
 #endif
-#if defined(ENABLE_SNAPPY)
-	  else if (streq (p[1], "snappy"))
-	    {
-	      options->comp.alg = COMP_ALG_SNAPPY;
-	      options->comp.flags = COMP_F_SWAP;
-	    }
-#endif
 #if defined(ENABLE_LZ4)
 	  else if (streq (p[1], "lz4"))
 	    {
diff --git a/src/openvpn/snappy.c b/src/openvpn/snappy.c
deleted file mode 100644
index 24440ba..0000000
--- a/src/openvpn/snappy.c
+++ /dev/null
@@ -1,189 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2012 OpenVPN Technologies, Inc. <sales@...515...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#elif defined(_MSC_VER)
-#include "config-msvc.h"
-#endif
-
-#include "syshead.h"
-
-#if defined(ENABLE_SNAPPY)
-
-#include "snappy-c.h"
-
-#include "comp.h"
-#include "error.h"
-#include "otime.h"
-
-#include "memdbg.h"
-
-/* Initial command byte to tell our peer if we compressed */
-#define SNAPPY_COMPRESS_BYTE 0x68
-
-static void
-snap_compress_init (struct compress_context *compctx)
-{
-  msg (D_INIT_MEDIUM, "Snappy compression initializing");
-  ASSERT(compctx->flags & COMP_F_SWAP);
-}
-
-static void
-snap_compress_uninit (struct compress_context *compctx)
-{
-}
-
-static void
-snap_compress (struct buffer *buf, struct buffer work,
-	       struct compress_context *compctx,
-	       const struct frame* frame)
-{
-  snappy_status status;
-  bool compressed = false;
-
-  if (buf->len <= 0)
-    return;
-
-  /*
-   * In order to attempt compression, length must be at least COMPRESS_THRESHOLD.
-   */
-  if (buf->len >= COMPRESS_THRESHOLD)
-    {
-      const size_t ps = PAYLOAD_SIZE (frame);
-      size_t zlen = ps + COMP_EXTRA_BUFFER (ps);
-
-      ASSERT (buf_init (&work, FRAME_HEADROOM (frame)));
-      ASSERT (buf_safe (&work, zlen));
-
-      if (buf->len > ps)
-	{
-	  dmsg (D_COMP_ERRORS, "Snappy compression buffer overflow");
-	  buf->len = 0;
-	  return;
-	}
-
-      status = snappy_compress((const char *)BPTR(buf), (size_t)BLEN(buf), (char *)BPTR(&work), &zlen);
-      if (status != SNAPPY_OK)
-	{
-	  dmsg (D_COMP_ERRORS, "Snappy compression error: %d", status);
-	  buf->len = 0;
-	  return;
-	}
-
-      ASSERT (buf_safe (&work, zlen));
-      work.len = zlen;
-      compressed = true;
-
-      dmsg (D_COMP, "Snappy compress %d -> %d", buf->len, work.len);
-      compctx->pre_compress += buf->len;
-      compctx->post_compress += work.len;
-    }
-
-  /* did compression save us anything? */
-  {
-    uint8_t comp_head_byte = NO_COMPRESS_BYTE_SWAP;
-    if (compressed && work.len < buf->len)
-      {
-	*buf = work;
-	comp_head_byte = SNAPPY_COMPRESS_BYTE;
-      }
-
-    {
-      uint8_t *head = BPTR (buf);
-      uint8_t *tail  = BEND (buf);
-      ASSERT (buf_safe (buf, 1));
-      ++buf->len;
-
-      /* move head byte of payload to tail */
-      *tail = *head;
-      *head = comp_head_byte;
-    }
-  }
-}
-
-static void
-snap_decompress (struct buffer *buf, struct buffer work,
-		 struct compress_context *compctx,
-		 const struct frame* frame)
-{
-  size_t zlen = EXPANDED_SIZE (frame);
-  snappy_status status;
-  uint8_t c;		/* flag indicating whether or not our peer compressed */
-
-  if (buf->len <= 0)
-    return;
-
-  ASSERT (buf_init (&work, FRAME_HEADROOM (frame)));
-
-  /* do unframing/swap (assumes buf->len > 0) */
-  {
-    uint8_t *head = BPTR (buf);
-    c = *head;
-    --buf->len;
-    *head = *BEND (buf);
-  }
-
-  if (c == SNAPPY_COMPRESS_BYTE)	/* packet was compressed */
-    {
-      ASSERT (buf_safe (&work, zlen));
-      status = snappy_uncompress((const char *)BPTR(buf), (size_t)BLEN(buf), (char *)BPTR(&work), &zlen);
-      if (status != SNAPPY_OK)
-	{
-	  dmsg (D_COMP_ERRORS, "Snappy decompression error: %d", status);
-	  buf->len = 0;
-	  return;
-	}
-
-      ASSERT (buf_safe (&work, zlen));
-      work.len = zlen;
-
-      dmsg (D_COMP, "Snappy decompress %d -> %d", buf->len, work.len);
-      compctx->pre_decompress += buf->len;
-      compctx->post_decompress += work.len;
-
-      *buf = work;
-    }
-  else if (c == NO_COMPRESS_BYTE_SWAP)	/* packet was not compressed */
-    {
-      ;
-    }
-  else
-    {
-      dmsg (D_COMP_ERRORS, "Bad Snappy decompression header byte: %d", c);
-      buf->len = 0;
-    }
-}
-
-const struct compress_alg snappy_alg = {
-  "snappy",
-  snap_compress_init,
-  snap_compress_uninit,
-  snap_compress,
-  snap_decompress
-};
-
-#else
-static void dummy(void) {}
-#endif /* ENABLE_SNAPPY */
diff --git a/src/openvpn/snappy.h b/src/openvpn/snappy.h
deleted file mode 100644
index 361a631..0000000
--- a/src/openvpn/snappy.h
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2012 OpenVPN Technologies, Inc. <sales@...515...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#ifndef OPENVPN_SNAPPY_H
-#define OPENVPN_SNAPPY_H
-
-#if defined(ENABLE_SNAPPY)
-
-#include "buffer.h"
-
-extern const struct compress_alg snappy_alg;
-
-struct snappy_workspace
-{
-};
-
-#endif /* ENABLE_SNAPPY */
-#endif
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 3aa5c5f..7e77b6c 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -710,7 +710,7 @@ socket_defined (const socket_descriptor_t sd)
 /*
  * Compression support
  */
-#if defined(ENABLE_SNAPPY) || defined(ENABLE_LZO) || defined(ENABLE_LZ4) || \
+#if defined(ENABLE_LZO) || defined(ENABLE_LZ4) || \
     defined(ENABLE_COMP_STUB)
 #define USE_COMP
 #endif
-- 
2.5.3


