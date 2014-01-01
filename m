From: Gert Doering <gert@...1296...>
Date: Wed,  1 Jan 2014 22:57:58 +0100
Message-Id: <1388613479-22377-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 1/2] Implement LZ4 compression.
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

Implement LZ4 compression, similar to the existing snappy / push-peer-info
model: a LZ4 capable client will send IV_LZ4=1 to the server, and the
algorithm is selected by pushing "compress lz4" back.

LZ4 does not compress as well as LZO or Snappy, but needs far less CPU
and is much faster, thus better suited for mobile devices.  See
https://code.google.com/p/lz4/ for more details.

LZ4 include and library path can be specified by specifying LZ4_LIBS=...
and LZ4_CFLAGS=... on the configure command line.

Signed-off-by: Gert Doering <gert@...1296...>
---
 configure.ac            |  50 +++++++++++++
 src/openvpn/Makefile.am |   3 +
 src/openvpn/comp-lz4.c  | 191 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/comp-lz4.h  |  40 ++++++++++
 src/openvpn/comp.c      |  11 +++
 src/openvpn/comp.h      |  11 ++-
 src/openvpn/init.c      |   4 +-
 src/openvpn/options.c   |  10 +++
 src/openvpn/syshead.h   |   3 +-
 9 files changed, 319 insertions(+), 4 deletions(-)
 create mode 100644 src/openvpn/comp-lz4.c
 create mode 100644 src/openvpn/comp-lz4.h

diff --git a/configure.ac b/configure.ac
index 23e76f6..497dd44 100644
--- a/configure.ac
+++ b/configure.ac
@@ -52,6 +52,12 @@ AC_ARG_ENABLE(snappy,
 	[enable_snappy="yes"]
 )
 
+AC_ARG_ENABLE(lz4,
+	[  --disable-lz4           Disable LZ4 compression support],
+	[enable_lz4="$enableval"],
+	[enable_lz4="yes"]
+)
+
 AC_ARG_ENABLE(comp-stub,
 	[  --enable-comp-stub      Don't compile compression support but still allow limited interoperability with compression-enabled peers],
 	[enable_comp_stub="$enableval"],
@@ -934,6 +940,47 @@ if test "$enable_snappy" = "yes" && test "$enable_comp_stub" = "no"; then
     CFLAGS="${saved_CFLAGS}"
 fi
 
+dnl
+dnl check for LZ4 library
+dnl
+
+AC_ARG_VAR([LZ4_CFLAGS], [C compiler flags for lz4])
+AC_ARG_VAR([LZ4_LIBS], [linker flags for lz4])
+if test "$enable_lz4" = "yes" && test "$enable_comp_stub" = "no"; then
+    AC_CHECKING([for LZ4 Library and Header files])
+    havelz4lib=1
+
+    # if LZ4_LIBS is set, we assume it will work, otherwise test
+    if test -z "${LZ4_LIBS}"; then
+	AC_CHECK_LIB(lz4, LZ4_compress,
+	    [ LZ4_LIBS="-llz4" ],
+	    [
+	        AC_MSG_RESULT([LZ4 library not found.])
+	        havelz4lib=0
+	    ])
+    fi
+
+    saved_CFLAGS="${CFLAGS}"
+    CFLAGS="${CFLAGS} ${LZ4_CFLAGS}"
+    AC_CHECK_HEADER(lz4.h,
+       ,
+       [
+	   AC_MSG_RESULT([LZ4 headers not found.])
+	   havelz4lib=0
+       ])
+
+    if test $havelz4lib = 0 ; then
+	AC_MSG_RESULT([LZ4 library available from http://code.google.com/p/lz4/])
+        AC_MSG_ERROR([Or try ./configure --disable-lz4 OR ./configure --enable-comp-stub])
+    fi
+    OPTIONAL_LZ4_CFLAGS="${LZ4_CFLAGS}"
+    OPTIONAL_LZ4_LIBS="${LZ4_LIBS}"
+    AC_DEFINE(ENABLE_LZ4, 1, [Enable LZ4 compression library])
+    CFLAGS="${saved_CFLAGS}"
+fi
+
+
+
 
 AC_MSG_CHECKING([git checkout])
 GIT_CHECKOUT="no"
@@ -1045,6 +1092,7 @@ fi
 if test "${enable_comp_stub}" = "yes"; then
 	test "${enable_lzo}" = "yes" && AC_MSG_ERROR([Cannot have both comp stub and lzo enabled (use --disable-lzo)])
 	test "${enable_snappy}" = "yes" && AC_MSG_ERROR([Cannot have both comp stub and snappy enabled (use --disable-snappy)])
+	test "${enable_lz4}" = "yes" && AC_MSG_ERROR([Cannot have both comp stub and LZ4 enabled (use --disable-lz4)])
 	AC_DEFINE([ENABLE_COMP_STUB], [1], [Enable compression stub capability])
 fi
 
@@ -1101,6 +1149,8 @@ AC_SUBST([OPTIONAL_LZO_CFLAGS])
 AC_SUBST([OPTIONAL_LZO_LIBS])
 AC_SUBST([OPTIONAL_SNAPPY_CFLAGS])
 AC_SUBST([OPTIONAL_SNAPPY_LIBS])
+AC_SUBST([OPTIONAL_LZ4_CFLAGS])
+AC_SUBST([OPTIONAL_LZ4_LIBS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_CFLAGS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
 
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 70e19c2..0b79e10 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -27,6 +27,7 @@ AM_CFLAGS = \
 	$(OPTIONAL_CRYPTO_CFLAGS) \
 	$(OPTIONAL_LZO_CFLAGS) \
 	$(OPTIONAL_SNAPPY_CFLAGS) \
+	$(OPTIONAL_LZ4_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS)
 if WIN32
 # we want unicode entry point but not the macro
@@ -43,6 +44,7 @@ openvpn_SOURCES = \
 	clinat.c clinat.h \
 	common.h \
 	comp.c comp.h compstub.c \
+	comp-lz4.c comp-lz4.h \
 	crypto.c crypto.h crypto_backend.h \
 	crypto_openssl.c crypto_openssl.h \
 	crypto_polarssl.c crypto_polarssl.h \
@@ -120,6 +122,7 @@ openvpn_LDADD = \
 	$(SOCKETS_LIBS) \
 	$(OPTIONAL_LZO_LIBS) \
 	$(OPTIONAL_SNAPPY_LIBS) \
+	$(OPTIONAL_LZ4_LIBS) \
 	$(OPTIONAL_PKCS11_HELPER_LIBS) \
 	$(OPTIONAL_CRYPTO_LIBS) \
 	$(OPTIONAL_SELINUX_LIBS) \
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
new file mode 100644
index 0000000..a42a124
--- /dev/null
+++ b/src/openvpn/comp-lz4.c
@@ -0,0 +1,191 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2012 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2013      Gert Doering <gert@...1296...>
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
+#if defined(ENABLE_LZ4)
+
+#include "lz4.h"
+
+#include "comp.h"
+#include "error.h"
+
+#include "memdbg.h"
+
+/* Initial command byte to tell our peer if we compressed */
+#define LZ4_COMPRESS_BYTE 0x69
+
+static void
+lz4_compress_init (struct compress_context *compctx)
+{
+  msg (D_INIT_MEDIUM, "LZ4 compression initializing");
+  ASSERT(compctx->flags & COMP_F_SWAP);
+}
+
+static void
+lz4_compress_uninit (struct compress_context *compctx)
+{
+}
+
+static void
+lz4_compress (struct buffer *buf, struct buffer work,
+	       struct compress_context *compctx,
+	       const struct frame* frame)
+{
+  int result;
+  bool compressed = false;
+
+  if (buf->len <= 0)
+    return;
+
+  /*
+   * In order to attempt compression, length must be at least COMPRESS_THRESHOLD.
+   */
+  if (buf->len >= COMPRESS_THRESHOLD)
+    {
+      const size_t ps = PAYLOAD_SIZE (frame);
+      int zlen_max = ps + COMP_EXTRA_BUFFER (ps);
+      int zlen;
+
+      ASSERT (buf_init (&work, FRAME_HEADROOM (frame)));
+      ASSERT (buf_safe (&work, zlen_max));
+
+      if (buf->len > ps)
+	{
+	  dmsg (D_COMP_ERRORS, "LZ4 compression buffer overflow");
+	  buf->len = 0;
+	  return;
+	}
+
+      zlen = LZ4_compress_limitedOutput((const char *)BPTR(buf), (char *)BPTR(&work), BLEN(buf), zlen_max );
+      
+      if (zlen <= 0)
+	{
+	  dmsg (D_COMP_ERRORS, "LZ4 compression error");
+	  buf->len = 0;
+	  return;
+	}
+
+      ASSERT (buf_safe (&work, zlen));
+      work.len = zlen;
+      compressed = true;
+
+      dmsg (D_COMP, "LZ4 compress %d -> %d", buf->len, work.len);
+      compctx->pre_compress += buf->len;
+      compctx->post_compress += work.len;
+    }
+
+  /* did compression save us anything? */
+  {
+    uint8_t comp_head_byte = NO_COMPRESS_BYTE_SWAP;
+    if (compressed && work.len < buf->len)
+      {
+	*buf = work;
+	comp_head_byte = LZ4_COMPRESS_BYTE;
+      }
+
+    {
+      uint8_t *head = BPTR (buf);
+      uint8_t *tail  = BEND (buf);
+      ASSERT (buf_safe (buf, 1));
+      ++buf->len;
+
+      /* move head byte of payload to tail */
+      *tail = *head;
+      *head = comp_head_byte;
+    }
+  }
+}
+
+static void
+lz4_decompress (struct buffer *buf, struct buffer work,
+		 struct compress_context *compctx,
+		 const struct frame* frame)
+{
+  size_t zlen_max = EXPANDED_SIZE (frame);
+  int uncomp_len;
+  uint8_t c;		/* flag indicating whether or not our peer compressed */
+
+  if (buf->len <= 0)
+    return;
+
+  ASSERT (buf_init (&work, FRAME_HEADROOM (frame)));
+
+  /* do unframing/swap (assumes buf->len > 0) */
+  {
+    uint8_t *head = BPTR (buf);
+    c = *head;
+    --buf->len;
+    *head = *BEND (buf);
+  }
+
+  if (c == LZ4_COMPRESS_BYTE)	/* packet was compressed */
+    {
+      ASSERT (buf_safe (&work, zlen_max));
+      uncomp_len = LZ4_decompress_safe((const char *)BPTR(buf), (char *)BPTR(&work), (size_t)BLEN(buf), zlen_max);
+      if (uncomp_len <= 0)
+	{
+	  dmsg (D_COMP_ERRORS, "LZ4 decompression error: %d", uncomp_len);
+	  buf->len = 0;
+	  return;
+	}
+
+      ASSERT (buf_safe (&work, uncomp_len));
+      work.len = uncomp_len;
+
+      dmsg (D_COMP, "LZ4 decompress %d -> %d", buf->len, work.len);
+      compctx->pre_decompress += buf->len;
+      compctx->post_decompress += work.len;
+
+      *buf = work;
+    }
+  else if (c == NO_COMPRESS_BYTE_SWAP)	/* packet was not compressed */
+    {
+      ;
+    }
+  else
+    {
+      dmsg (D_COMP_ERRORS, "Bad LZ4 decompression header byte: %d", c);
+      buf->len = 0;
+    }
+}
+
+const struct compress_alg lz4_alg = {
+  "lz4",
+  lz4_compress_init,
+  lz4_compress_uninit,
+  lz4_compress,
+  lz4_decompress
+};
+
+#else
+static void dummy(void) {}
+#endif /* ENABLE_LZ4 */
diff --git a/src/openvpn/comp-lz4.h b/src/openvpn/comp-lz4.h
new file mode 100644
index 0000000..ca1dfa9
--- /dev/null
+++ b/src/openvpn/comp-lz4.h
@@ -0,0 +1,40 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2012 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2013      Gert Doering <gert@...1296...>
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
+ */
+
+#ifndef OPENVPN_COMP_LZ4_H
+#define OPENVPN_COMP_LZ4_H
+
+#if defined(ENABLE_LZ4)
+
+#include "buffer.h"
+
+extern const struct compress_alg lz4_alg;
+
+struct lz4_workspace
+{
+};
+
+#endif /* ENABLE_LZ4 */
+#endif
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 9692257..4ac589f 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -66,6 +66,14 @@ comp_init(const struct compress_options *opt)
       (*compctx->alg.compress_init)(compctx);
       break;
 #endif
+#ifdef ENABLE_LZ4
+    case COMP_ALG_LZ4:
+      ALLOC_OBJ_CLEAR (compctx, struct compress_context);
+      compctx->flags = opt->flags;
+      compctx->alg = lz4_alg;
+      (*compctx->alg.compress_init)(compctx);
+      break;
+#endif
     }
   return compctx;
 }
@@ -118,6 +126,9 @@ comp_generate_peer_info_string(const struct compress_options *opt, struct buffer
       bool lzo_avail = false;
       if (!(opt->flags & COMP_F_ADVERTISE_STUBS_ONLY))
 	{
+#if defined(ENABLE_LZ4)
+	  buf_printf (out, "IV_LZ4=1\n");
+#endif
 #if defined(ENABLE_SNAPPY)
 	  buf_printf (out, "IV_SNAPPY=1\n");
 #endif
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 0d2f1bc..5776400 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -24,7 +24,7 @@
 
 /*
  * Generic compression support.  Currently we support
- * Snappy and LZO 2.
+ * Snappy, LZO 2 and LX4.
  */
 #ifndef OPENVPN_COMP_H
 #define OPENVPN_COMP_H
@@ -41,6 +41,7 @@
 #define COMP_ALG_STUB   1 /* support compression command byte and framing without actual compression */
 #define COMP_ALG_LZO    2 /* LZO algorithm */
 #define COMP_ALG_SNAPPY 3 /* Snappy algorithm */
+#define COMP_ALG_LZ4    4 /* LZ4 algorithm */
 
 /* Compression flags */
 #define COMP_F_ADAPTIVE   (1<<0) /* COMP_ALG_LZO only */
@@ -64,6 +65,7 @@
  *
  * LZO:    len + len/8 + 128 + 3
  * Snappy: len + len/6 + 32
+ * LZ4:    len + len/255 + 16  (LZ4_COMPRESSBOUND(len))
  */
 #define COMP_EXTRA_BUFFER(len) ((len)/6 + 128 + 3 + COMP_PREFIX_LEN)
 
@@ -103,6 +105,10 @@ struct compress_alg
 #include "snappy.h"
 #endif
 
+#ifdef ENABLE_LZ4
+#include "comp-lz4.h"
+#endif
+
 /*
  * Information that basically identifies a compression
  * algorithm and related flags.
@@ -124,6 +130,9 @@ union compress_workspace_union
 #ifdef ENABLE_SNAPPY
   struct snappy_workspace snappy;
 #endif
+#ifdef ENABLE_LZ4
+  struct lz4_workspace lz4;
+#endif
 };
 
 /*
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ae08562..c5b966c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2379,7 +2379,7 @@ do_init_frame (struct context *c)
     {
       comp_add_to_extra_frame (&c->c2.frame);
 
-#if !defined(ENABLE_SNAPPY)
+#if !defined(ENABLE_SNAPPY) && !defined(ENABLE_LZ4)
       /*
        * Compression usage affects buffer alignment when non-swapped algs
        * such as LZO is used.
@@ -2394,7 +2394,7 @@ do_init_frame (struct context *c)
        * dispatch if packet is uncompressed) at the cost of requiring
        * decryption output to be written to an unaligned buffer, so
        * it's more of a tradeoff than an optimal solution and we don't
-       * include it when we are doing a modern build with Snappy.
+       * include it when we are doing a modern build with Snappy or LZ4.
        * Strictly speaking, on the server it would be better to execute
        * this code for every connection after we decide the compression
        * method, but currently the frame code doesn't appear to be
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6d9c3b8..6165faa 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -92,6 +92,9 @@ const char title_string[] =
 #ifdef ENABLE_SNAPPY
   " [SNAPPY]"
 #endif
+#ifdef ENABLE_LZ4
+  " [LZ4]"
+#endif
 #ifdef ENABLE_COMP_STUB
   " [COMP_STUB]"
 #endif
@@ -6259,6 +6262,13 @@ add_option (struct options *options,
 	      options->comp.flags = COMP_F_SWAP;
 	    }
 #endif
+#if defined(ENABLE_LZ4)
+	  else if (streq (p[1], "lz4"))
+	    {
+	      options->comp.alg = COMP_ALG_LZ4;
+	      options->comp.flags = COMP_F_SWAP;
+	    }
+#endif
 	  else
 	    {
 	      msg (msglevel, "bad comp option: %s", p[1]);
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 51b2402..ab6fa01 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -715,7 +715,8 @@ socket_defined (const socket_descriptor_t sd)
 /*
  * Compression support
  */
-#if defined(ENABLE_SNAPPY) || defined(ENABLE_LZO) || defined(ENABLE_COMP_STUB)
+#if defined(ENABLE_SNAPPY) || defined(ENABLE_LZO) || defined(ENABLE_LZ4) || \
+    defined(ENABLE_COMP_STUB)
 #define USE_COMP
 #endif
 
-- 
1.8.1.5


