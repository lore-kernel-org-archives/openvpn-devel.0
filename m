From: Gert Doering <gert@...1296...>
Date: Fri, 19 Apr 2013 19:41:05 +0200
Message-Id: <1366393268-27392-3-git-send-email-gert@...1296...>
In-Reply-To: <1366393268-27392-1-git-send-email-gert@...1296...>
References: <1366393268-27392-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 2/5] Added support for the Snappy
	compression algorithm
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
Cc: James Yonan <james@...515...>

From: James Yonan <james@...515...>

Added support for the Snappy compression algorithm which has shown to
have considerably better compression speed than LZO at a comparable
compression ratio.

To enable Snappy add:

  compress snappy

to both client and server config files.

Alternatively, enable compression framing on the client:

  compress

and have the server selectively push "compress snappy" to the client.

This change also extends the client capability handshake to include
IV_SNAPPY so the server can be aware that a connecting client supports
Snappy.

Note that the Snappy implementation also includes an improved framing
approach where the first byte of the compressed payload is replaced by
the compression control byte (the first payload byte is moved to the end
of the packet).  This solves off-by-one alignment issues, which improves
performance on ARM.

By default, the configure script will try to build with Snappy support.
To disable, use the --disable-snappy option.

The --enable-lzo-stub configure directive is now --enable-comp-stub
(because it's not actually "lzo" but "compression-enabled packet framing")

Add compression overhead to extra buffer unconditionally, as long
as USE_COMP is defined.

OpenVPN SVN r8206 (2.1.21a) and r8212 (2.1.21b)

Signed-off-by: Gert Doering <gert@...1296...>
---
 configure.ac             |  65 ++++++++++++--
 doc/openvpn.8            |  22 ++++-
 src/openvpn/Makefile.am  |   4 +
 src/openvpn/comp.c       | 135 ++++++++++++++++++++++++++++
 src/openvpn/comp.h       | 171 ++++++++++++++++++++++++++++++++++++
 src/openvpn/compstub.c   | 118 +++++++++++++++++++++++++
 src/openvpn/forward.c    |  12 +--
 src/openvpn/init.c       | 100 +++++++++++++++------
 src/openvpn/lzo.c        | 154 +++++++++++---------------------
 src/openvpn/lzo.h        | 222 +----------------------------------------------
 src/openvpn/openvpn.h    |  16 ++--
 src/openvpn/options.c    | 100 +++++++++++++++++----
 src/openvpn/options.h    |   7 +-
 src/openvpn/sig.c        |   6 +-
 src/openvpn/snappy.c     | 189 ++++++++++++++++++++++++++++++++++++++++
 src/openvpn/snappy.h     |  39 +++++++++
 src/openvpn/ssl.c        |   6 +-
 src/openvpn/ssl_common.h |   5 ++
 src/openvpn/syshead.h    |   7 ++
 19 files changed, 975 insertions(+), 403 deletions(-)
 create mode 100644 src/openvpn/comp.c
 create mode 100644 src/openvpn/comp.h
 create mode 100644 src/openvpn/compstub.c
 create mode 100644 src/openvpn/snappy.c
 create mode 100644 src/openvpn/snappy.h

diff --git a/configure.ac b/configure.ac
index 7b35e50..5da5772 100644
--- a/configure.ac
+++ b/configure.ac
@@ -46,11 +46,16 @@ AC_ARG_ENABLE(
 	[enable_lzo="yes"]
 )
 
-AC_ARG_ENABLE(
-	[lzo-stub],
-	[AS_HELP_STRING([--enable-lzo-stub], [don't compile LZO compression support but still allow limited interoperability with LZO-enabled peers @<:@default=no@:>@])],
-	,
-	[enable_lzo_stub="no"]
+AC_ARG_ENABLE(snappy,
+	[  --disable-snappy        Disable Snappy compression support],
+	[enable_snappy="$enableval"],
+	[enable_snappy="yes"]
+)
+
+AC_ARG_ENABLE(comp-stub,
+	[  --enable-comp-stub      Don't compile compression support but still allow limited interoperability with compression-enabled peers],
+	[enable_comp_stub="$enableval"],
+	[enable_comp_stub="no"]
 )
 
 AC_ARG_ENABLE(
@@ -895,6 +900,46 @@ if test "${have_lzo}" = "yes"; then
 	CFLAGS="${saved_CFLAGS}"
 fi
 
+dnl
+dnl check for Snappy library
+dnl
+
+AC_ARG_VAR([SNAPPY_CFLAGS], [C compiler flags for snappy])
+AC_ARG_VAR([SNAPPY_LIBS], [linker flags for snappy])
+if test "$enable_snappy" = "yes" && test "$enable_comp_stub" = "no"; then
+    AC_CHECKING([for Snappy Library and Header files])
+    havesnappylib=1
+
+    # if SNAPPY_LIBS is set, we assume it will work, otherwise test
+    if test -z "${SNAPPY_LIBS}"; then
+	AC_CHECK_LIB(snappy, snappy_compress,
+	    [ SNAPPY_LIBS="-lsnappy" ],
+	    [
+	        AC_MSG_RESULT([Snappy library not found.])
+	        havesnappylib=0
+	    ])
+    fi
+
+    saved_CFLAGS="${CFLAGS}"
+    CFLAGS="${CFLAGS} ${SNAPPY_CFLAGS}"
+    AC_CHECK_HEADER(snappy-c.h,
+       ,
+       [
+	   AC_MSG_RESULT([Snappy headers not found.])
+	   havesnappylib=0
+       ])
+
+    if test $havesnappylib = 0 ; then
+	AC_MSG_RESULT([Snappy library available from http://code.google.com/p/snappy/])
+        AC_MSG_ERROR([Or try ./configure --disable-snappy OR ./configure --enable-comp-stub])
+    fi
+    OPTIONAL_SNAPPY_CFLAGS="${SNAPPY_CFLAGS}"
+    OPTIONAL_SNAPPY_LIBS="${SNAPPY_LIBS}"
+    AC_DEFINE(ENABLE_SNAPPY, 1, [Enable Snappy compression library])
+    CFLAGS="${saved_CFLAGS}"
+fi
+
+
 AC_MSG_CHECKING([git checkout])
 GIT_CHECKOUT="no"
 if test -n "${GIT}" -a -d "${srcdir}/.git"; then
@@ -1003,10 +1048,10 @@ if test "${enable_lzo}" = "yes"; then
 	OPTIONAL_LZO_LIBS="${LZO_LIBS}"
 	AC_DEFINE([ENABLE_LZO], [1], [Enable LZO compression library])
 fi
-if test "${enable_lzo_stub}" = "yes"; then
-	test "${enable_lzo}" = "yes" && AC_MSG_ERROR([Cannot have both lzo stub and lzo enabled])
-	AC_DEFINE([ENABLE_LZO_STUB], [1], [Enable LZO stub capability])
-	AC_DEFINE([ENABLE_LZO], [1], [Enable LZO compression library])
+if test "${enable_comp_stub}" = "yes"; then
+	test "${enable_lzo}" = "yes" && AC_MSG_ERROR([Cannot have both comp stub and lzo enabled (use --disable-lzo)])
+	test "${enable_snappy}" = "yes" && AC_MSG_ERROR([Cannot have both comp stub and snappy enabled (use --disable-snappy)])
+	AC_DEFINE([ENABLE_COMP_STUB], [1], [Enable compression stub capability])
 fi
 
 if test "${enable_pkcs11}" = "yes"; then
@@ -1060,6 +1105,8 @@ AC_SUBST([OPTIONAL_CRYPTO_CFLAGS])
 AC_SUBST([OPTIONAL_CRYPTO_LIBS])
 AC_SUBST([OPTIONAL_LZO_CFLAGS])
 AC_SUBST([OPTIONAL_LZO_LIBS])
+AC_SUBST([OPTIONAL_SNAPPY_CFLAGS])
+AC_SUBST([OPTIONAL_SNAPPY_LIBS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_CFLAGS])
 AC_SUBST([OPTIONAL_PKCS11_HELPER_LIBS])
 
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index d590714..cab1ed7 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2352,12 +2352,32 @@ consecutive messages in the same category.  This is useful to
 limit repetitive logging of similar message types.
 .\"*********************************************************
 .TP
+.B \-\-compress [algorithm]
+Enable a compression algorithm.
+
+The
+.B algorithm
+parameter may be "snappy", "lzo", or empty.  Snappy and LZO
+are different compression algorithms, with Snappy generally
+offering the best performance.
+
+If the
+.B algorithm
+parameter is empty, compression will be turned off, but the packet
+framing for compression will still be enabled, allowing a different
+setting to be pushed later.
+.\"*********************************************************
+.TP
 .B \-\-comp-lzo [mode]
-Use fast LZO compression \-\- may add up to 1 byte per
+Use LZO compression \-\- may add up to 1 byte per
 packet for incompressible data.
 .B mode
 may be "yes", "no", or "adaptive" (default).
 
+This option is deprecated in favor of the newer
+.B --compress
+option.
+
 In a server mode setup, it is possible to selectively turn
 compression on or off for individual clients.
 
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 5d38628..70e19c2 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -26,6 +26,7 @@ AM_CFLAGS = \
 	$(TAP_CFLAGS) \
 	$(OPTIONAL_CRYPTO_CFLAGS) \
 	$(OPTIONAL_LZO_CFLAGS) \
+	$(OPTIONAL_SNAPPY_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS)
 if WIN32
 # we want unicode entry point but not the macro
@@ -41,6 +42,7 @@ openvpn_SOURCES = \
 	circ_list.h \
 	clinat.c clinat.h \
 	common.h \
+	comp.c comp.h compstub.c \
 	crypto.c crypto.h crypto_backend.h \
 	crypto_openssl.c crypto_openssl.h \
 	crypto_polarssl.c crypto_polarssl.h \
@@ -98,6 +100,7 @@ openvpn_SOURCES = \
 	session_id.c session_id.h \
 	shaper.c shaper.h \
 	sig.c sig.h \
+	snappy.c snappy.h \
 	socket.c socket.h \
 	socks.c socks.h \
 	ssl.c ssl.h  ssl_backend.h \
@@ -116,6 +119,7 @@ openvpn_LDADD = \
 	$(top_builddir)/src/compat/libcompat.la \
 	$(SOCKETS_LIBS) \
 	$(OPTIONAL_LZO_LIBS) \
+	$(OPTIONAL_SNAPPY_LIBS) \
 	$(OPTIONAL_PKCS11_HELPER_LIBS) \
 	$(OPTIONAL_CRYPTO_LIBS) \
 	$(OPTIONAL_SELINUX_LIBS) \
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
new file mode 100644
index 0000000..9692257
--- /dev/null
+++ b/src/openvpn/comp.c
@@ -0,0 +1,135 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2012 OpenVPN Technologies, Inc. <sales@...515...>
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
+#ifdef USE_COMP
+
+#include "comp.h"
+#include "error.h"
+#include "otime.h"
+
+#include "memdbg.h"
+
+struct compress_context *
+comp_init(const struct compress_options *opt)
+{
+  struct compress_context *compctx = NULL;
+  switch (opt->alg)
+    {
+    case COMP_ALG_STUB:
+      ALLOC_OBJ_CLEAR (compctx, struct compress_context);
+      compctx->flags = opt->flags;
+      compctx->alg = comp_stub_alg;
+      (*compctx->alg.compress_init)(compctx);
+      break;
+#ifdef ENABLE_LZO
+    case COMP_ALG_LZO:
+      ALLOC_OBJ_CLEAR (compctx, struct compress_context);
+      compctx->flags = opt->flags;
+      compctx->alg = lzo_alg;
+      (*compctx->alg.compress_init)(compctx);
+      break;
+#endif
+#ifdef ENABLE_SNAPPY
+    case COMP_ALG_SNAPPY:
+      ALLOC_OBJ_CLEAR (compctx, struct compress_context);
+      compctx->flags = opt->flags;
+      compctx->alg = snappy_alg;
+      (*compctx->alg.compress_init)(compctx);
+      break;
+#endif
+    }
+  return compctx;
+}
+
+void
+comp_uninit(struct compress_context *compctx)
+{
+  if (compctx)
+    {
+      (*compctx->alg.compress_uninit)(compctx);
+      free(compctx);
+    }
+}
+
+void
+comp_add_to_extra_frame(struct frame *frame)
+{
+  /* Leave room for our one-byte compressed/didn't-compress prefix byte. */
+  frame_add_to_extra_frame (frame, COMP_PREFIX_LEN);
+}
+
+void
+comp_add_to_extra_buffer(struct frame *frame)
+{
+  /* Leave room for compression buffer to expand in worst case scenario
+     where data is totally uncompressible */
+  frame_add_to_extra_buffer (frame, COMP_EXTRA_BUFFER (EXPANDED_SIZE(frame)));
+}
+
+void
+comp_print_stats (const struct compress_context *compctx, struct status_output *so)
+{
+  if (compctx)
+    {
+      status_printf (so, "pre-compress bytes," counter_format, compctx->pre_compress);
+      status_printf (so, "post-compress bytes," counter_format, compctx->post_compress);
+      status_printf (so, "pre-decompress bytes," counter_format, compctx->pre_decompress);
+      status_printf (so, "post-decompress bytes," counter_format, compctx->post_decompress);
+    }
+}
+
+/*
+ * Tell our peer which compression algorithms we support.
+ */
+void
+comp_generate_peer_info_string(const struct compress_options *opt, struct buffer *out)
+{
+  if (opt)
+    {
+      bool lzo_avail = false;
+      if (!(opt->flags & COMP_F_ADVERTISE_STUBS_ONLY))
+	{
+#if defined(ENABLE_SNAPPY)
+	  buf_printf (out, "IV_SNAPPY=1\n");
+#endif
+#if defined(ENABLE_LZO)
+	  buf_printf (out, "IV_LZO=1\n");
+	  lzo_avail = true;
+#endif
+	}
+      if (!lzo_avail)
+	buf_printf (out, "IV_LZO_STUB=1\n");
+      buf_printf (out, "IV_COMP_STUB=1\n");
+    }
+}
+
+#endif /* USE_COMP */
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
new file mode 100644
index 0000000..0d2f1bc
--- /dev/null
+++ b/src/openvpn/comp.h
@@ -0,0 +1,171 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2012 OpenVPN Technologies, Inc. <sales@...515...>
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
+/*
+ * Generic compression support.  Currently we support
+ * Snappy and LZO 2.
+ */
+#ifndef OPENVPN_COMP_H
+#define OPENVPN_COMP_H
+
+#ifdef USE_COMP
+
+#include "buffer.h"
+#include "mtu.h"
+#include "common.h"
+#include "status.h"
+
+/* algorithms */
+#define COMP_ALG_UNDEF  0
+#define COMP_ALG_STUB   1 /* support compression command byte and framing without actual compression */
+#define COMP_ALG_LZO    2 /* LZO algorithm */
+#define COMP_ALG_SNAPPY 3 /* Snappy algorithm */
+
+/* Compression flags */
+#define COMP_F_ADAPTIVE   (1<<0) /* COMP_ALG_LZO only */
+#define COMP_F_ASYM       (1<<1) /* only downlink is compressed, not uplink */
+#define COMP_F_SWAP       (1<<2) /* initial command byte is swapped with last byte in buffer to preserve payload alignment */
+#define COMP_F_ADVERTISE_STUBS_ONLY (1<<3) /* tell server that we only support compression stubs */
+
+/*
+ * Length of prepended prefix on compressed packets
+ */
+#define COMP_PREFIX_LEN 1
+
+/*
+ * Prefix bytes
+ */
+#define NO_COMPRESS_BYTE      0xFA
+#define NO_COMPRESS_BYTE_SWAP 0xFB /* to maintain payload alignment, replace this byte with last byte of packet */
+
+/*
+ * Compress worst case size expansion (for any algorithm)
+ *
+ * LZO:    len + len/8 + 128 + 3
+ * Snappy: len + len/6 + 32
+ */
+#define COMP_EXTRA_BUFFER(len) ((len)/6 + 128 + 3 + COMP_PREFIX_LEN)
+
+/*
+ * Don't try to compress any packet smaller than this.
+ */
+#define COMPRESS_THRESHOLD 100
+
+/* Forward declaration of compression context */
+struct compress_context;
+
+/*
+ * Virtual methods and other static info for each compression algorithm
+ */
+struct compress_alg
+{
+  const char *name;
+  void (*compress_init)(struct compress_context *compctx);
+  void (*compress_uninit)(struct compress_context *compctx);
+  void (*compress)(struct buffer *buf, struct buffer work,
+		   struct compress_context *compctx,
+		   const struct frame* frame);
+
+  void (*decompress)(struct buffer *buf, struct buffer work,
+		     struct compress_context *compctx,
+		     const struct frame* frame);
+};
+
+/*
+ * Headers for each compression implementation
+ */
+#ifdef ENABLE_LZO
+#include "lzo.h"
+#endif
+
+#ifdef ENABLE_SNAPPY
+#include "snappy.h"
+#endif
+
+/*
+ * Information that basically identifies a compression
+ * algorithm and related flags.
+ */
+struct compress_options
+{
+  int alg;
+  unsigned int flags;
+};
+
+/*
+ * Workspace union of all supported compression algorithms
+ */
+union compress_workspace_union
+{
+#ifdef ENABLE_LZO
+  struct lzo_compress_workspace lzo;
+#endif
+#ifdef ENABLE_SNAPPY
+  struct snappy_workspace snappy;
+#endif
+};
+
+/*
+ * Context for active compression session
+ */
+struct compress_context
+{
+  unsigned int flags;
+  struct compress_alg alg;
+  union compress_workspace_union wu;
+
+  /* statistics */
+  counter_type pre_decompress;
+  counter_type post_decompress;
+  counter_type pre_compress;
+  counter_type post_compress;
+};
+
+extern const struct compress_alg comp_stub_alg;
+
+struct compress_context *comp_init(const struct compress_options *opt);
+
+void comp_uninit(struct compress_context *compctx);
+
+void comp_add_to_extra_frame(struct frame *frame);
+void comp_add_to_extra_buffer(struct frame *frame);
+
+void comp_print_stats (const struct compress_context *compctx, struct status_output *so);
+
+void comp_generate_peer_info_string(const struct compress_options *opt, struct buffer *out);
+
+static inline bool
+comp_enabled(const struct compress_options *info)
+{
+  return info->alg != COMP_ALG_UNDEF;
+}
+
+static inline bool
+comp_unswapped_prefix(const struct compress_options *info)
+{
+  return !(info->flags & COMP_F_SWAP);
+}
+
+#endif /* USE_COMP */
+#endif
diff --git a/src/openvpn/compstub.c b/src/openvpn/compstub.c
new file mode 100644
index 0000000..2ab7163
--- /dev/null
+++ b/src/openvpn/compstub.c
@@ -0,0 +1,118 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2012 OpenVPN Technologies, Inc. <sales@...515...>
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
+#if defined(USE_COMP)
+
+#include "comp.h"
+#include "error.h"
+#include "otime.h"
+
+#include "memdbg.h"
+
+static void
+stub_compress_init (struct compress_context *compctx)
+{
+}
+
+static void
+stub_compress_uninit (struct compress_context *compctx)
+{
+}
+
+static void
+stub_compress (struct buffer *buf, struct buffer work,
+	       struct compress_context *compctx,
+	       const struct frame* frame)
+{
+  if (buf->len <= 0)
+    return;
+  if (compctx->flags & COMP_F_SWAP)
+    {
+      uint8_t *head = BPTR (buf);
+      uint8_t *tail  = BEND (buf);
+      ASSERT (buf_safe (buf, 1));
+      ++buf->len;
+
+      /* move head byte of payload to tail */
+      *tail = *head;
+      *head = NO_COMPRESS_BYTE_SWAP;
+    }
+  else
+    {
+      uint8_t *header = buf_prepend (buf, 1);
+      *header = NO_COMPRESS_BYTE;
+    }
+}
+
+static void
+stub_decompress (struct buffer *buf, struct buffer work,
+		 struct compress_context *compctx,
+		 const struct frame* frame)
+{
+  uint8_t c;
+  if (buf->len <= 0)
+    return;
+  if (compctx->flags & COMP_F_SWAP)
+    {
+      uint8_t *head = BPTR (buf);
+      c = *head;
+      --buf->len;
+      *head = *BEND (buf);
+      if (c != NO_COMPRESS_BYTE_SWAP)
+	{
+	  dmsg (D_COMP_ERRORS, "Bad compression stub (swap) decompression header byte: %d", c);
+	  buf->len = 0;
+	}
+    }
+  else
+    {
+      c = *BPTR (buf);
+      ASSERT (buf_advance (buf, 1));
+      if (c != NO_COMPRESS_BYTE)
+	{
+	  dmsg (D_COMP_ERRORS, "Bad compression stub decompression header byte: %d", c);
+	  buf->len = 0;
+	}
+    }
+}
+
+const struct compress_alg comp_stub_alg = {
+  "stub",
+  stub_compress_init,
+  stub_compress_uninit,
+  stub_compress,
+  stub_decompress
+};
+
+#else
+static void dummy(void) {}
+#endif /* USE_STUB */
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 024cd58..447b86d 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -444,10 +444,10 @@ encrypt_sign (struct context *c, bool comp_frag)
 
   if (comp_frag)
     {
-#ifdef ENABLE_LZO
+#ifdef USE_COMP
       /* Compress the packet. */
-      if (lzo_defined (&c->c2.lzo_compwork))
-	lzo_compress (&c->c2.buf, b->lzo_compress_buf, &c->c2.lzo_compwork, &c->c2.frame);
+      if (c->c2.comp_context)
+	(*c->c2.comp_context->alg.compress)(&c->c2.buf, b->compress_buf, c->c2.comp_context, &c->c2.frame);
 #endif
 #ifdef ENABLE_FRAGMENT
       if (c->c2.fragment)
@@ -846,10 +846,10 @@ process_incoming_link (struct context *c)
 	fragment_incoming (c->c2.fragment, &c->c2.buf, &c->c2.frame_fragment);
 #endif
 
-#ifdef ENABLE_LZO
+#ifdef USE_COMP
       /* decompress the incoming packet */
-      if (lzo_defined (&c->c2.lzo_compwork))
-	lzo_decompress (&c->c2.buf, c->c2.buffers->lzo_decompress_buf, &c->c2.lzo_compwork, &c->c2.frame);
+      if (c->c2.comp_context)
+	(*c->c2.comp_context->alg.decompress)(&c->c2.buf, c->c2.buffers->decompress_buf, c->c2.comp_context, &c->c2.frame);
 #endif
 
 #ifdef PACKET_TRUNCATION_CHECK
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 979ba23..16501fd 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1746,14 +1746,12 @@ do_deferred_options (struct context *c, const unsigned int found)
     }
 #endif
 
-#ifdef ENABLE_LZO
+#ifdef USE_COMP
   if (found & OPT_P_COMP)
     {
-      if (lzo_defined (&c->c2.lzo_compwork))
-	{
-	  msg (D_PUSH, "OPTIONS IMPORT: LZO parms modified");
-	  lzo_modify_flags (&c->c2.lzo_compwork, c->options.lzo);
-	}
+      msg (D_PUSH, "OPTIONS IMPORT: compression parms modified");
+      comp_uninit (c->c2.comp_context);
+      c->c2.comp_context = comp_init (&c->options.comp);
     }
 #endif
 
@@ -2248,6 +2246,10 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
 #endif
 #endif
 
+#ifdef USE_COMP
+  to.comp_options = options->comp;
+#endif
+
   /* TLS handshake authentication (--tls-auth) */
   if (options->tls_auth_file)
     {
@@ -2330,30 +2332,50 @@ do_init_crypto (struct context *c, const unsigned int flags)
 static void
 do_init_frame (struct context *c)
 {
-#ifdef ENABLE_LZO
+#ifdef USE_COMP
   /*
-   * Initialize LZO compression library.
+   * modify frame parameters if compression is enabled
    */
-  if (c->options.lzo & LZO_SELECTED)
+  if (comp_enabled(&c->options.comp))
     {
-      lzo_adjust_frame_parameters (&c->c2.frame);
+      comp_add_to_extra_frame (&c->c2.frame);
 
+#if !defined(ENABLE_SNAPPY)
       /*
-       * LZO usage affects buffer alignment.
+       * Compression usage affects buffer alignment when non-swapped algs
+       * such as LZO is used.
+       * Newer algs like Snappy and comp-stub with COMP_F_SWAP don't need
+       * any special alignment because of the control-byte swap approach.
+       * LZO alignment (on the other hand) is problematic because
+       * the presence of the control byte means that either the output of
+       * decryption must be written to an unaligned buffer, or the input
+       * to compression (or packet dispatch if packet is uncompressed)
+       * must be read from an unaligned buffer.
+       * This code tries to align the input to compression (or packet
+       * dispatch if packet is uncompressed) at the cost of requiring
+       * decryption output to be written to an unaligned buffer, so
+       * it's more of a tradeoff than an optimal solution and we don't
+       * include it when we are doing a modern build with Snappy.
+       * Strictly speaking, on the server it would be better to execute
+       * this code for every connection after we decide the compression
+       * method, but currently the frame code doesn't appear to be
+       * flexible enough for this, since the frame is already established
+       * before it is known which compression options will be pushed.
        */
-      if (CIPHER_ENABLED (c))
+      if (comp_unswapped_prefix (&c->options.comp) && CIPHER_ENABLED (c))
 	{
-	  frame_add_to_align_adjust (&c->c2.frame, LZO_PREFIX_LEN);
+	  frame_add_to_align_adjust (&c->c2.frame, COMP_PREFIX_LEN);
 	  frame_or_align_flags (&c->c2.frame,
 				FRAME_HEADROOM_MARKER_FRAGMENT
 				|FRAME_HEADROOM_MARKER_DECRYPT);
 	}
+#endif
 
 #ifdef ENABLE_FRAGMENT
-      lzo_adjust_frame_parameters (&c->c2.frame_fragment_omit);	/* omit LZO frame delta from final frame_fragment */
+      comp_add_to_extra_frame (&c->c2.frame_fragment_omit); /* omit compression frame delta from final frame_fragment */
 #endif
     }
-#endif /* ENABLE_LZO */
+#endif /* USE_COMP */
 
 #ifdef ENABLE_SOCKS
   /*
@@ -2382,6 +2404,17 @@ do_init_frame (struct context *c)
    */
   frame_finalize_options (c, NULL);
 
+#ifdef USE_COMP
+  /*
+   * Modify frame parameters if compression is compiled in.
+   * Should be called after frame_finalize_options.
+   */
+  comp_add_to_extra_buffer (&c->c2.frame);
+#ifdef ENABLE_FRAGMENT
+  comp_add_to_extra_buffer (&c->c2.frame_fragment_omit); /* omit compression frame delta from final frame_fragment */
+#endif
+#endif /* USE_COMP */
+
 #ifdef ENABLE_FRAGMENT
   /*
    * Set frame parameter for fragment code.  This is necessary because
@@ -2513,9 +2546,9 @@ init_context_buffers (const struct frame *frame)
   b->decrypt_buf = alloc_buf (BUF_SIZE (frame));
 #endif
 
-#ifdef ENABLE_LZO
-  b->lzo_compress_buf = alloc_buf (BUF_SIZE (frame));
-  b->lzo_decompress_buf = alloc_buf (BUF_SIZE (frame));
+#ifdef USE_COMP
+  b->compress_buf = alloc_buf (BUF_SIZE (frame));
+  b->decompress_buf = alloc_buf (BUF_SIZE (frame));
 #endif
 
   return b;
@@ -2530,9 +2563,9 @@ free_context_buffers (struct context_buffers *b)
       free_buf (&b->read_tun_buf);
       free_buf (&b->aux_buf);
 
-#ifdef ENABLE_LZO
-      free_buf (&b->lzo_compress_buf);
-      free_buf (&b->lzo_decompress_buf);
+#ifdef USE_COMP
+      free_buf (&b->compress_buf);
+      free_buf (&b->decompress_buf);
 #endif
 
 #ifdef ENABLE_CRYPTO
@@ -3364,10 +3397,10 @@ init_instance (struct context *c, const struct env_set *env, const unsigned int
       goto sig;
   }
 
-#ifdef ENABLE_LZO
-  /* initialize LZO compression library. */
-  if ((options->lzo & LZO_SELECTED) && (c->mode == CM_P2P || child))
-    lzo_compress_init (&c->c2.lzo_compwork, options->lzo);
+#ifdef USE_COMP
+  /* initialize compression library. */
+  if (comp_enabled(&options->comp) && (c->mode == CM_P2P || child))
+    c->c2.comp_context = comp_init (&options->comp);
 #endif
 
   /* initialize MTU variables */
@@ -3481,9 +3514,12 @@ close_instance (struct context *c)
 	/* if xinetd/inetd mode, don't allow restart */
 	do_close_check_if_restart_permitted (c);
 
-#ifdef ENABLE_LZO
-	if (lzo_defined (&c->c2.lzo_compwork))
-	  lzo_compress_uninit (&c->c2.lzo_compwork);
+#ifdef USE_COMP
+	if (c->c2.comp_context)
+	  {
+	    comp_uninit (c->c2.comp_context);
+	    c->c2.comp_context = NULL;
+	  }
 #endif
 
 	/* free buffers */
@@ -3607,6 +3643,10 @@ inherit_context_child (struct context *dest,
       dest->c2.link_socket_info->lsa = &dest->c1.link_socket_addr;
       dest->c2.link_socket_info->connection_established = false;
     }
+
+#ifdef USE_COMP
+  dest->c2.comp_context = NULL;
+#endif
 }
 
 void
@@ -3655,6 +3695,10 @@ inherit_context_top (struct context *dest,
   dest->c2.event_set = NULL;
   if (proto_is_dgram(src->options.ce.proto))
     do_event_set_init (dest, false);
+
+#ifdef USE_COMP
+  dest->c2.comp_context = NULL;
+#endif
 }
 
 void
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 195b819..daa02ed 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -34,15 +34,17 @@
 
 #include "syshead.h"
 
-#ifdef ENABLE_LZO
+#if defined(ENABLE_LZO)
 
-#include "lzo.h"
+#include "comp.h"
 #include "error.h"
 #include "otime.h"
 
 #include "memdbg.h"
 
-#ifndef ENABLE_LZO_STUB
+/* Initial command byte to tell our peer if we compressed */
+#define LZO_COMPRESS_BYTE 0x66
+
 /**
  * Perform adaptive compression housekeeping.
  *
@@ -97,101 +99,69 @@ lzo_adaptive_compress_data (struct lzo_adaptive_compress *ac, int n_total, int n
   ac->n_comp += n_comp;
 }
 
-#endif /* ENABLE_LZO_STUB */
-
-void lzo_adjust_frame_parameters (struct frame *frame)
-{
-  /* Leave room for our one-byte compressed/didn't-compress prefix byte. */
-  frame_add_to_extra_frame (frame, LZO_PREFIX_LEN);
-
-  /* Leave room for compression buffer to expand in worst case scenario
-     where data is totally uncompressible */
-  frame_add_to_extra_buffer (frame, LZO_EXTRA_BUFFER (EXPANDED_SIZE(frame)));
-}
-
-void
-lzo_compress_init (struct lzo_compress_workspace *lzowork, unsigned int flags)
+static void
+lzo_compress_init (struct compress_context *compctx)
 {
-  CLEAR (*lzowork);
-
-  lzowork->flags = flags;
-#ifndef ENABLE_LZO_STUB
-  lzowork->wmem_size = LZO_WORKSPACE;
-
+  msg (D_INIT_MEDIUM, "LZO compression initializing");
+  ASSERT(!(compctx->flags & COMP_F_SWAP));
+  compctx->wu.lzo.wmem_size = LZO_WORKSPACE;
   if (lzo_init () != LZO_E_OK)
     msg (M_FATAL, "Cannot initialize LZO compression library");
-  lzowork->wmem = (lzo_voidp) lzo_malloc (lzowork->wmem_size);
-  check_malloc_return (lzowork->wmem);
-  msg (D_INIT_MEDIUM, "LZO compression initialized");
-#else
-  msg (D_INIT_MEDIUM, "LZO stub compression initialized");
-#endif
-  lzowork->defined = true;
+  compctx->wu.lzo.wmem = (lzo_voidp) lzo_malloc (compctx->wu.lzo.wmem_size);
+  check_malloc_return (compctx->wu.lzo.wmem);
 }
 
-void
-lzo_compress_uninit (struct lzo_compress_workspace *lzowork)
+static void
+lzo_compress_uninit (struct compress_context *compctx)
 {
-  if (lzowork)
-    {
-      ASSERT (lzowork->defined);
-#ifndef ENABLE_LZO_STUB
-      lzo_free (lzowork->wmem);
-      lzowork->wmem = NULL;
-#endif
-      lzowork->defined = false;
-    }
+  lzo_free (compctx->wu.lzo.wmem);
+  compctx->wu.lzo.wmem = NULL;
 }
 
 static inline bool
-lzo_compression_enabled (struct lzo_compress_workspace *lzowork)
+lzo_compression_enabled (struct compress_context *compctx)
 {
-#ifndef ENABLE_LZO_STUB
-  if ((lzowork->flags & (LZO_SELECTED|LZO_ON)) == (LZO_SELECTED|LZO_ON))
+  if (compctx->flags & COMP_F_ASYM)
+    return false;
+  else
     {
-      if (lzowork->flags & LZO_ADAPTIVE)
-	return lzo_adaptive_compress_test (&lzowork->ac);
+      if (compctx->flags & COMP_F_ADAPTIVE)
+	return lzo_adaptive_compress_test (&compctx->wu.lzo.ac);
       else
 	return true;
     }
-#endif
-  return false;
 }
 
-void
+static void
 lzo_compress (struct buffer *buf, struct buffer work,
-	      struct lzo_compress_workspace *lzowork,
+	      struct compress_context *compctx,
 	      const struct frame* frame)
 {
-#ifndef ENABLE_LZO_STUB
   lzo_uint zlen = 0;
   int err;
   bool compressed = false;
-#endif
-
-  ASSERT (lzowork->defined);
 
   if (buf->len <= 0)
     return;
 
-#ifndef ENABLE_LZO_STUB
   /*
    * In order to attempt compression, length must be at least COMPRESS_THRESHOLD,
    * and our adaptive level must give the OK.
    */
-  if (buf->len >= COMPRESS_THRESHOLD && lzo_compression_enabled (lzowork))
+  if (buf->len >= COMPRESS_THRESHOLD && lzo_compression_enabled (compctx))
     {
+      const size_t ps = PAYLOAD_SIZE (frame);
       ASSERT (buf_init (&work, FRAME_HEADROOM (frame)));
-      ASSERT (buf_safe (&work, LZO_EXTRA_BUFFER (PAYLOAD_SIZE (frame))));
+      ASSERT (buf_safe (&work, ps + COMP_EXTRA_BUFFER (ps)));
 
-      if (!(buf->len <= PAYLOAD_SIZE (frame)))
+      if (buf->len > ps)
 	{
 	  dmsg (D_COMP_ERRORS, "LZO compression buffer overflow");
 	  buf->len = 0;
 	  return;
 	}
 
-      err = LZO_COMPRESS (BPTR (buf), BLEN (buf), BPTR (&work), &zlen, lzowork->wmem);
+      err = LZO_COMPRESS (BPTR (buf), BLEN (buf), BPTR (&work), &zlen, compctx->wu.lzo.wmem);
       if (err != LZO_E_OK)
 	{
 	  dmsg (D_COMP_ERRORS, "LZO compression error: %d", err);
@@ -203,43 +173,38 @@ lzo_compress (struct buffer *buf, struct buffer work,
       work.len = zlen;
       compressed = true;
 
-      dmsg (D_COMP, "compress %d -> %d", buf->len, work.len);
-      lzowork->pre_compress += buf->len;
-      lzowork->post_compress += work.len;
+      dmsg (D_COMP, "LZO compress %d -> %d", buf->len, work.len);
+      compctx->pre_compress += buf->len;
+      compctx->post_compress += work.len;
 
       /* tell adaptive level about our success or lack thereof in getting any size reduction */
-      if (lzowork->flags & LZO_ADAPTIVE)
-	lzo_adaptive_compress_data (&lzowork->ac, buf->len, work.len);
+      if (compctx->flags & COMP_F_ADAPTIVE)
+	lzo_adaptive_compress_data (&compctx->wu.lzo.ac, buf->len, work.len);
     }
 
   /* did compression save us anything ? */
   if (compressed && work.len < buf->len)
     {
       uint8_t *header = buf_prepend (&work, 1);
-      *header = YES_COMPRESS;
+      *header = LZO_COMPRESS_BYTE;
       *buf = work;
     }
   else
-#endif
     {
       uint8_t *header = buf_prepend (buf, 1);
-      *header = NO_COMPRESS;
+      *header = NO_COMPRESS_BYTE;
     }
 }
 
-void
+static void
 lzo_decompress (struct buffer *buf, struct buffer work,
-		struct lzo_compress_workspace *lzowork,
+		struct compress_context *compctx,
 		const struct frame* frame)
 {
-#ifndef ENABLE_LZO_STUB
   lzo_uint zlen = EXPANDED_SIZE (frame);
   int err;
-#endif
   uint8_t c;		/* flag indicating whether or not our peer compressed */
 
-  ASSERT (lzowork->defined);
-
   if (buf->len <= 0)
     return;
 
@@ -248,12 +213,11 @@ lzo_decompress (struct buffer *buf, struct buffer work,
   c = *BPTR (buf);
   ASSERT (buf_advance (buf, 1));
 
-  if (c == YES_COMPRESS)	/* packet was compressed */
+  if (c == LZO_COMPRESS_BYTE)	/* packet was compressed */
     {
-#ifndef ENABLE_LZO_STUB
       ASSERT (buf_safe (&work, zlen));
       err = LZO_DECOMPRESS (BPTR (buf), BLEN (buf), BPTR (&work), &zlen,
-			    lzowork->wmem);
+			    compctx->wu.lzo.wmem);
       if (err != LZO_E_OK)
 	{
 	  dmsg (D_COMP_ERRORS, "LZO decompression error: %d", err);
@@ -264,18 +228,13 @@ lzo_decompress (struct buffer *buf, struct buffer work,
       ASSERT (buf_safe (&work, zlen));
       work.len = zlen;
 
-      dmsg (D_COMP, "decompress %d -> %d", buf->len, work.len);
-      lzowork->pre_decompress += buf->len;
-      lzowork->post_decompress += work.len;
+      dmsg (D_COMP, "LZO decompress %d -> %d", buf->len, work.len);
+      compctx->pre_decompress += buf->len;
+      compctx->post_decompress += work.len;
 
       *buf = work;
-#else
-      dmsg (D_COMP_ERRORS, "LZO decompression error: LZO capability not compiled");
-      buf->len = 0;
-      return;
-#endif
     }
-  else if (c == NO_COMPRESS)	/* packet was not compressed */
+  else if (c == NO_COMPRESS_BYTE)	/* packet was not compressed */
     {
       ;
     }
@@ -286,24 +245,13 @@ lzo_decompress (struct buffer *buf, struct buffer work,
     }
 }
 
-void
-lzo_modify_flags (struct lzo_compress_workspace *lzowork, unsigned int flags)
-{
-  ASSERT (lzowork->defined);
-  lzowork->flags = flags;
-}
-
-void lzo_print_stats (const struct lzo_compress_workspace *lzo_compwork, struct status_output *so)
-{
-  ASSERT (lzo_compwork->defined);
-
-#ifndef ENABLE_LZO_STUB
-  status_printf (so, "pre-compress bytes," counter_format, lzo_compwork->pre_compress);
-  status_printf (so, "post-compress bytes," counter_format, lzo_compwork->post_compress);
-  status_printf (so, "pre-decompress bytes," counter_format, lzo_compwork->pre_decompress);
-  status_printf (so, "post-decompress bytes," counter_format, lzo_compwork->post_decompress);
-#endif
-}
+const struct compress_alg lzo_alg = {
+  "lzo",
+  lzo_compress_init,
+  lzo_compress_uninit,
+  lzo_compress,
+  lzo_decompress
+};
 
 #else
 static void dummy(void) {}
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index 472204d..f33e587 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -32,14 +32,13 @@
  */
 
 
-#ifdef ENABLE_LZO
+#if defined(ENABLE_LZO)
 
 /**
  * @addtogroup compression
  * @{
  */
 
-#ifndef ENABLE_LZO_STUB
 #if defined(HAVE_LZO_LZOUTIL_H)
 #include "lzo/lzoutil.h"
 #elif defined(HAVE_LZOUTIL_H)
@@ -50,28 +49,16 @@
 #elif defined(HAVE_LZO1X_H)
 #include "lzo1x.h"
 #endif
-#endif
 
 #include "buffer.h"
 #include "mtu.h"
 #include "common.h"
 #include "status.h"
 
-/**************************************************************************/
-/** @name Bit-flags which control data channel packet compression *//******/
-/** @{ */
-#define LZO_SELECTED   (1<<0)   /**< Bit-flag indicating that compression
-                                 *   of data channel packets is enabled. */
-#define LZO_ON         (1<<1)   /**< Bit-flag indicating that compression
-                                 *   of data channel packets is active. */
-#define LZO_ADAPTIVE   (1<<2)   /**< Bit-flag indicating that adaptive
-                                 *   compression of data channel packets
-                                 *   has been selected. */
-/** @} name Bit-flags which control data channel packet compression *//****/
+extern const struct compress_alg lzo_alg;
 
 /**************************************************************************/
 /** @name LZO library interface defines *//** @{ *//***********************/
-#ifndef ENABLE_LZO_STUB
 #define LZO_COMPRESS    lzo1x_1_15_compress
                                 /**< LZO library compression function.
                                  *
@@ -93,36 +80,11 @@
                                  *   verify the integrity of incoming
                                  *   packets, you might want to consider
                                  *   using the non-safe version. */
-#endif /* ENABLE_LZO_STUB */
 /** @} name LZO library interface *//**************************************/
 
 
 /**************************************************************************/
-/** @name Miscellaneous compression defines *//** @{ *//*******************/
-#define LZO_EXTRA_BUFFER(len) ((len)/8 + 128 + 3)
-                                /**< LZO 2.0 worst-case size expansion. */
-#ifndef ENABLE_LZO_STUB
-#define COMPRESS_THRESHOLD 100  /**< Minimum packet size to attempt
-                                 *   compression. */
-#endif /* ENABLE_LZO_STUB */
-/** @} name Miscellaneous compression defines *//**************************/
-
-
-/**************************************************************************/
-/** @name Compression header defines *//** @{ *//**************************/
-#define LZO_PREFIX_LEN 1        /**< Length in bytes of prepended
-                                 *   compression header. */
-#define YES_COMPRESS 0x66       /**< Single-byte compression header
-                                 *   indicating this packet has been
-                                 *   compressed. */
-#define NO_COMPRESS  0xFA       /**< Single-byte compression header
-                                 *   indicating this packet has not been
-                                 *   compressed. */
-/** @} name Compression header defines *//*********************************/
-
-/**************************************************************************/
 /** @name Adaptive compression defines *//** @{ *//************************/
-#ifndef ENABLE_LZO_STUB
 #define AC_SAMP_SEC    2        /**< Number of seconds in a sample period. */
 #define AC_MIN_BYTES   1000     /**< Minimum number of bytes a sample
                                  *   period must contain for it to be
@@ -132,11 +94,8 @@
                                  *   turned off. */
 #define AC_OFF_SEC     60       /**< Seconds to wait after compression has
                                  *   been turned off before retesting. */
-#endif /* ENABLE_LZO_STUB */
 /** @} name Adaptive compression defines *//*******************************/
 
-#ifndef ENABLE_LZO_STUB
-
 /**
  * Adaptive compression state.
  */
@@ -147,8 +106,6 @@ struct lzo_adaptive_compress {
   int n_comp;
 };
 
-#endif /* ENABLE_LZO_STUB */
-
 
 /**
  * State for the compression and decompression routines.
@@ -162,186 +119,13 @@ struct lzo_adaptive_compress {
  */
 struct lzo_compress_workspace
 {
-  bool defined;
-  unsigned int flags;
-#ifndef ENABLE_LZO_STUB
   lzo_voidp wmem;
   int wmem_size;
   struct lzo_adaptive_compress ac;
-
-  /* statistics */
-  counter_type pre_decompress;
-  counter_type post_decompress;
-  counter_type pre_compress;
-  counter_type post_compress;
-#endif
 };
 
-
-/**************************************************************************/
-/** @name Functions for initialization and cleanup *//** @{ *//************/
-
-/**
- * Adjust %frame parameters for data channel payload compression.
- *
- * Data channel packet compression requires a single-byte header to
- * indicate whether a packet has been compressed or not. The packet
- * handling buffers must also allow for worst-case payload compression
- * where the compressed content size is actually larger than the original
- * content size. This function adjusts the parameters of a given frame
- * structure to include the header and allow for worst-case compression
- * expansion.
- *
- * @param frame        - The frame structure to adjust.
- */
-void lzo_adjust_frame_parameters(struct frame *frame);
-
-/**
- * Initialize a compression workspace structure.
- *
- * This function initializes the given workspace structure \a lzowork.
- * This includes allocating a work buffer for internal use and setting its
- * flags to the given value of \a flags.
- *
- * This function also initializes the lzo library.
- *
- * @param lzowork      - A pointer to the workspace structure to
- *                       initialize.
- * @param flags        - The initial flags to set in the workspace
- *                       structure.
- */
-void lzo_compress_init (struct lzo_compress_workspace *lzowork, unsigned int flags);
-
-/**
- * Cleanup a compression workspace structure.
- *
- * This function cleans up the given workspace structure \a lzowork.  This
- * includes freeing the structure's internal work buffer.
- *
- * @param lzowork      - A pointer to the workspace structure to clean up.
- */
-void lzo_compress_uninit (struct lzo_compress_workspace *lzowork);
-
-/**
- * Set a workspace structure's flags.
- *
- * @param lzowork      - The workspace structure of which to modify the
- *                       flags.
- * @param flags        - The new value to assign to the workspace
- *                       structure's flags.
- */
-void lzo_modify_flags (struct lzo_compress_workspace *lzowork, unsigned int flags);
-
-/** @} name Functions for initialization and cleanup *//*******************/
-
-
-/**************************************************************************/
-/** @name Function for packets to be sent to a remote OpenVPN peer *//*****/
-/** @{ */
-
-/**
- * Process an outgoing packet according to a VPN tunnel's settings.
- * @ingroup compression
- *
- * This function processes the packet contained in \a buf.  Its behavior
- * depends on the settings contained within \a lzowork.  If compression is
- * enabled and active, this function compresses the packet.  After
- * compression, the size of the uncompressed and compressed packets are
- * compared, and the smallest is used.
- *
- * This function prepends a one-byte header indicating whether the packet
- * was or was not compressed, so as to let the peer know how to handle the
- * packet.
- *
- * If an error occurs during processing, an error message is logged and
- * the length of \a buf is set to zero.
- *
- * @param buf          - A pointer to the buffer containing the outgoing
- *                       packet.  This pointer will be modified to point
- *                       to the processed packet on return.
- * @param work         - A preallocated working buffer.
- * @param lzowork      - The compression workspace structure associated
- *                       with this VPN tunnel.
- * @param frame        - The frame parameters of this tunnel.
- *
- * @return Void.\n  On return, \a buf will point to a buffer containing
- *     the processed, possibly compressed, packet data with a compression
- *     header prepended.
- */
-void lzo_compress (struct buffer *buf, struct buffer work,
-		   struct lzo_compress_workspace *lzowork,
-		   const struct frame* frame);
-
-/** @} name Function for packets to be sent to a remote OpenVPN peer *//***/
-
-
-/**************************************************************************/
-/** @name Function for packets received from a remote OpenVPN peer *//*****/
-/** @{ */
-
-/**
- * Inspect an incoming packet and decompress if it is compressed.
- *
- * This function inspects the incoming packet contained in \a buf.  If its
- * one-byte compression header indicates that it was compressed (i.e. \c
- * YES_COMPRESS), then it will be decompressed.  If its header indicates
- * that it was not compressed (i.e. \c NO_COMPRESS), then the buffer is
- * not modified except for removing the compression header.
- *
- * If an error occurs during processing, for example if the compression
- * header has a value other than \c YES_COMPRESS or \c NO_COMPRESS, then
- * the error is logged and the length of \a buf is set to zero.
- *
- * @param buf          - A pointer to the buffer containing the incoming
- *                       packet.  This pointer will be modified to point
- *                       to the processed packet on return.
- * @param work         - A preallocated working buffer.
- * @param lzowork      - The compression workspace structure associated
- *                       with this VPN tunnel.
- * @param frame        - The frame parameters of this tunnel.
- *
- * @return Void.\n  On return, \a buf will point to a buffer containing
- *     the uncompressed packet data and the one-byte compression header
- *     will have been removed.
- */
-void lzo_decompress (struct buffer *buf, struct buffer work,
-		     struct lzo_compress_workspace *lzowork,
-		     const struct frame* frame);
-
-/** @} name Function for packets received from a remote OpenVPN peer *//***/
-
-
-/**************************************************************************/
-/** @name Utility functions *//** @{ *//***********************************/
-
-/**
- * Print statistics on compression and decompression performance.
- *
- * @param lzo_compwork - The workspace structure from which to get the
- *                       statistics.
- * @param so           - The status output structure to which to write the
- *                       statistics.
- */
-void lzo_print_stats (const struct lzo_compress_workspace *lzo_compwork, struct status_output *so);
-
-/**
- * Check whether compression is enabled for a workspace structure.
- *
- * @param lzowork      - The workspace structure to check.
- *
- * @return true if compression is enabled; false otherwise.
- */
-static inline bool
-lzo_defined (const struct lzo_compress_workspace *lzowork)
-{
-  return lzowork->defined;
-}
-
-/** @} name Utility functions *//******************************************/
-
-
 /** @} addtogroup compression */
 
 
-#endif /* ENABLE_LZO */
+#endif /* ENABLE_LZO && USE_COMP */
 #endif
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index bdfa685..606a4f5 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -31,7 +31,7 @@
 #include "crypto.h"
 #include "ssl.h"
 #include "packet_id.h"
-#include "lzo.h"
+#include "comp.h"
 #include "tun.h"
 #include "interval.h"
 #include "status.h"
@@ -104,10 +104,10 @@ struct context_buffers
   struct buffer decrypt_buf;
 #endif
 
-  /* workspace buffers for LZO compression */
-#ifdef ENABLE_LZO
-  struct buffer lzo_compress_buf;
-  struct buffer lzo_decompress_buf;
+  /* workspace buffers for compression */
+#ifdef USE_COMP
+  struct buffer compress_buf;
+  struct buffer decompress_buf;
 #endif
 
   /*
@@ -372,9 +372,9 @@ struct context_2
 
 #endif /* ENABLE_CRYPTO */
 
-#ifdef ENABLE_LZO
-  struct lzo_compress_workspace lzo_compwork;
-                                /**< Compression workspace used by the
+#ifdef USE_COMP
+  struct compress_context *comp_context;
+                                /**< Compression context used by the
                                  *   \link compression Data Channel
                                  *   Compression module\endlink. */
 #endif
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 88ed88a..cb5778f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -84,13 +84,17 @@ const char title_string[] =
 #endif /* defined(ENABLE_CRYPTO_POLARSSL) */
 #endif /* ENABLE_SSL */
 #endif /* ENABLE_CRYPTO */
+#ifdef USE_COMP
 #ifdef ENABLE_LZO
-#ifdef ENABLE_LZO_STUB
-  " [LZO (STUB)]"
-#else
   " [LZO]"
 #endif
+#ifdef ENABLE_SNAPPY
+  " [SNAPPY]"
+#endif
+#ifdef ENABLE_COMP_STUB
+  " [COMP_STUB]"
 #endif
+#endif /* USE_COMP */
 #if EPOLL
   " [EPOLL]"
 #endif
@@ -362,12 +366,15 @@ static const char usage_message[] =
 #ifdef ENABLE_DEBUG
   "--gremlin mask  : Special stress testing mode (for debugging only).\n"
 #endif
-#ifdef ENABLE_LZO
-  "--comp-lzo      : Use fast LZO compression -- may add up to 1 byte per\n"
+#if defined(USE_COMP)
+  "--compress alg  : Use compression algorithm alg\n"
+#if defined(ENABLE_LZO)
+  "--comp-lzo      : Use LZO compression -- may add up to 1 byte per\n"
   "                  packet for uncompressible data.\n"
   "--comp-noadapt  : Don't use adaptive compression when --comp-lzo\n"
   "                  is specified.\n"
 #endif
+#endif
 #ifdef ENABLE_MANAGEMENT
   "--management ip port [pass] : Enable a TCP server on ip:port to handle\n"
   "                  management functions.  pass is a password file\n"
@@ -1509,8 +1516,9 @@ show_settings (const struct options *o)
 
   SHOW_BOOL (fast_io);
 
-#ifdef ENABLE_LZO
-  SHOW_INT (lzo);
+#ifdef USE_COMP
+  SHOW_INT (comp.alg);
+  SHOW_INT (comp.flags);
 #endif
 
   SHOW_STR (route_script);
@@ -2877,6 +2885,7 @@ pre_pull_restore (struct options *o)
  *                 the other end of the connection]
  *
  * --comp-lzo
+ * --compress alg
  * --fragment
  *
  * Crypto Options:
@@ -2958,9 +2967,9 @@ options_string (const struct options *o,
       tt = NULL;
     }
 
-#ifdef ENABLE_LZO
-  if (o->lzo & LZO_SELECTED)
-    buf_printf (&out, ",comp-lzo");
+#ifdef USE_COMP
+  if (o->comp.alg != COMP_ALG_UNDEF)
+    buf_printf (&out, ",comp-lzo"); /* for compatibility, this simply indicates that compression context is active, not necessarily LZO per-se */
 #endif
 
 #ifdef ENABLE_FRAGMENT
@@ -6132,18 +6141,31 @@ add_option (struct options *options,
       options->passtos = true;
     }
 #endif
-#ifdef ENABLE_LZO
+#if defined(USE_COMP)
   else if (streq (p[0], "comp-lzo"))
     {
       VERIFY_PERMISSION (OPT_P_COMP);
-      if (p[1])
+
+#if defined(ENABLE_LZO)
+      if (p[1] && streq (p[1], "no"))
+#endif
+	{
+	  options->comp.alg = COMP_ALG_STUB;
+	  options->comp.flags = 0;
+	}
+#if defined(ENABLE_LZO)
+      else if (p[1])
 	{
 	  if (streq (p[1], "yes"))
-	    options->lzo = LZO_SELECTED|LZO_ON;
-	  else if (streq (p[1], "no"))
-	    options->lzo = LZO_SELECTED;
+	    {
+	      options->comp.alg = COMP_ALG_LZO;
+	      options->comp.flags = 0;
+	    }
 	  else if (streq (p[1], "adaptive"))
-	    options->lzo = LZO_SELECTED|LZO_ON|LZO_ADAPTIVE;
+	    {
+	      options->comp.alg = COMP_ALG_LZO;
+	      options->comp.flags = COMP_F_ADAPTIVE;
+	    }
 	  else
 	    {
 	      msg (msglevel, "bad comp-lzo option: %s -- must be 'yes', 'no', or 'adaptive'", p[1]);
@@ -6151,14 +6173,54 @@ add_option (struct options *options,
 	    }
 	}
       else
-	options->lzo = LZO_SELECTED|LZO_ON|LZO_ADAPTIVE;
+	{
+	  options->comp.alg = COMP_ALG_LZO;
+	  options->comp.flags = COMP_F_ADAPTIVE;
+	}
+#endif
     }
   else if (streq (p[0], "comp-noadapt"))
     {
       VERIFY_PERMISSION (OPT_P_COMP);
-      options->lzo &= ~LZO_ADAPTIVE;
+      options->comp.flags &= ~COMP_F_ADAPTIVE;
+    }
+  else if (streq (p[0], "compress"))
+    {
+      VERIFY_PERMISSION (OPT_P_COMP);
+      if (p[1])
+	{
+	  if (streq (p[1], "stub"))
+	    {
+	      options->comp.alg = COMP_ALG_STUB;
+	      options->comp.flags = (COMP_F_SWAP|COMP_F_ADVERTISE_STUBS_ONLY);
+	    }
+#if defined(ENABLE_LZO)
+	  else if (streq (p[1], "lzo"))
+	    {
+	      options->comp.alg = COMP_ALG_LZO;
+	      options->comp.flags = 0;
+	    }
+#endif
+#if defined(ENABLE_SNAPPY)
+	  else if (streq (p[1], "snappy"))
+	    {
+	      options->comp.alg = COMP_ALG_SNAPPY;
+	      options->comp.flags = COMP_F_SWAP;
+	    }
+#endif
+	  else
+	    {
+	      msg (msglevel, "bad comp option: %s", p[1]);
+	      goto err;
+	    }
+	}
+      else
+	{
+	  options->comp.alg = COMP_ALG_STUB;
+	  options->comp.flags = COMP_F_SWAP;
+	}
     }
-#endif /* ENABLE_LZO */
+#endif /* USE_COMP */
 #ifdef ENABLE_CRYPTO
   else if (streq (p[0], "show-ciphers"))
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index db1d3f7..9d7aaf2 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -39,7 +39,7 @@
 #include "plugin.h"
 #include "manage.h"
 #include "proxy.h"
-#include "lzo.h"
+#include "comp.h"
 #include "pushlist.h"
 #include "clinat.h"
 
@@ -314,9 +314,8 @@ struct options
   /* optimize TUN/TAP/UDP writes */
   bool fast_io;
 
-#ifdef ENABLE_LZO
-  /* LZO_x flags from lzo.h */
-  unsigned int lzo;
+#ifdef USE_COMP
+  struct compress_options comp;
 #endif
 
   /* buffer sizes */
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 0ebde24..5dee92b 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -265,9 +265,9 @@ print_status (const struct context *c, struct status_output *so)
   status_printf (so, "TCP/UDP read bytes," counter_format, c->c2.link_read_bytes);
   status_printf (so, "TCP/UDP write bytes," counter_format, c->c2.link_write_bytes);
   status_printf (so, "Auth read bytes," counter_format, c->c2.link_read_bytes_auth);
-#ifdef ENABLE_LZO
-  if (lzo_defined (&c->c2.lzo_compwork))
-    lzo_print_stats (&c->c2.lzo_compwork, so);
+#ifdef USE_COMP
+  if (c->c2.comp_context)
+    comp_print_stats (c->c2.comp_context, so);
 #endif
 #ifdef PACKET_TRUNCATION_CHECK
   status_printf (so, "TUN read truncations," counter_format, c->c2.n_trunc_tun_read);
diff --git a/src/openvpn/snappy.c b/src/openvpn/snappy.c
new file mode 100644
index 0000000..24440ba
--- /dev/null
+++ b/src/openvpn/snappy.c
@@ -0,0 +1,189 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2012 OpenVPN Technologies, Inc. <sales@...515...>
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
+#if defined(ENABLE_SNAPPY)
+
+#include "snappy-c.h"
+
+#include "comp.h"
+#include "error.h"
+#include "otime.h"
+
+#include "memdbg.h"
+
+/* Initial command byte to tell our peer if we compressed */
+#define SNAPPY_COMPRESS_BYTE 0x68
+
+static void
+snap_compress_init (struct compress_context *compctx)
+{
+  msg (D_INIT_MEDIUM, "Snappy compression initializing");
+  ASSERT(compctx->flags & COMP_F_SWAP);
+}
+
+static void
+snap_compress_uninit (struct compress_context *compctx)
+{
+}
+
+static void
+snap_compress (struct buffer *buf, struct buffer work,
+	       struct compress_context *compctx,
+	       const struct frame* frame)
+{
+  snappy_status status;
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
+      size_t zlen = ps + COMP_EXTRA_BUFFER (ps);
+
+      ASSERT (buf_init (&work, FRAME_HEADROOM (frame)));
+      ASSERT (buf_safe (&work, zlen));
+
+      if (buf->len > ps)
+	{
+	  dmsg (D_COMP_ERRORS, "Snappy compression buffer overflow");
+	  buf->len = 0;
+	  return;
+	}
+
+      status = snappy_compress((const char *)BPTR(buf), (size_t)BLEN(buf), (char *)BPTR(&work), &zlen);
+      if (status != SNAPPY_OK)
+	{
+	  dmsg (D_COMP_ERRORS, "Snappy compression error: %d", status);
+	  buf->len = 0;
+	  return;
+	}
+
+      ASSERT (buf_safe (&work, zlen));
+      work.len = zlen;
+      compressed = true;
+
+      dmsg (D_COMP, "Snappy compress %d -> %d", buf->len, work.len);
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
+	comp_head_byte = SNAPPY_COMPRESS_BYTE;
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
+snap_decompress (struct buffer *buf, struct buffer work,
+		 struct compress_context *compctx,
+		 const struct frame* frame)
+{
+  size_t zlen = EXPANDED_SIZE (frame);
+  snappy_status status;
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
+  if (c == SNAPPY_COMPRESS_BYTE)	/* packet was compressed */
+    {
+      ASSERT (buf_safe (&work, zlen));
+      status = snappy_uncompress((const char *)BPTR(buf), (size_t)BLEN(buf), (char *)BPTR(&work), &zlen);
+      if (status != SNAPPY_OK)
+	{
+	  dmsg (D_COMP_ERRORS, "Snappy decompression error: %d", status);
+	  buf->len = 0;
+	  return;
+	}
+
+      ASSERT (buf_safe (&work, zlen));
+      work.len = zlen;
+
+      dmsg (D_COMP, "Snappy decompress %d -> %d", buf->len, work.len);
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
+      dmsg (D_COMP_ERRORS, "Bad Snappy decompression header byte: %d", c);
+      buf->len = 0;
+    }
+}
+
+const struct compress_alg snappy_alg = {
+  "snappy",
+  snap_compress_init,
+  snap_compress_uninit,
+  snap_compress,
+  snap_decompress
+};
+
+#else
+static void dummy(void) {}
+#endif /* ENABLE_SNAPPY */
diff --git a/src/openvpn/snappy.h b/src/openvpn/snappy.h
new file mode 100644
index 0000000..361a631
--- /dev/null
+++ b/src/openvpn/snappy.h
@@ -0,0 +1,39 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2012 OpenVPN Technologies, Inc. <sales@...515...>
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
+#ifndef OPENVPN_SNAPPY_H
+#define OPENVPN_SNAPPY_H
+
+#if defined(ENABLE_SNAPPY)
+
+#include "buffer.h"
+
+extern const struct compress_alg snappy_alg;
+
+struct snappy_workspace
+{
+};
+
+#endif /* ENABLE_SNAPPY */
+#endif
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 43b3980..cf36191 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1809,9 +1809,9 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
 	  buf_printf (&out, "IV_HWADDR=%s\n", format_hex_ex (rgi.hwaddr, 6, 0, 1, ":", &gc));
       }
 
-      /* push LZO status */
-#ifdef ENABLE_LZO_STUB
-      buf_printf (&out, "IV_LZO_STUB=1\n");
+      /* push compression status */
+#ifdef USE_COMP
+      comp_generate_peer_info_string(&session->opt->comp_options, &out);
 #endif
 
       /* push env vars that begin with UV_ */
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index c62294f..47dbefb 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -285,6 +285,11 @@ struct tls_options
   struct env_set *es;
   const struct plugin_list *plugins;
 
+  /* compression parms */
+#ifdef USE_COMP
+  struct compress_options comp_options;
+#endif
+
   /* configuration file boolean options */
 # define SSLF_CLIENT_CERT_NOT_REQUIRED (1<<0)
 # define SSLF_USERNAME_AS_COMMON_NAME  (1<<1)
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 4db29cc..629ee80 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -720,6 +720,13 @@ socket_defined (const socket_descriptor_t sd)
 #define ENABLE_CLIENT_NAT
 
 /*
+ * Compression support
+ */
+#if defined(ENABLE_SNAPPY) || defined(ENABLE_LZO) || defined(ENABLE_COMP_STUB)
+#define USE_COMP
+#endif
+
+/*
  * Enable --memstats option
  */
 #ifdef TARGET_LINUX
-- 
1.8.1.5


