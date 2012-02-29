From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:12:08 +0200
Message-Id: <1330546342-17794-39-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 38/52] build: properly process lzo-stub
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac          |   12 +++++++-----
 src/openvpn/lzo.c     |   20 ++++++++++----------
 src/openvpn/lzo.h     |   20 ++++++++++----------
 src/openvpn/ssl.c     |    2 +-
 src/openvpn/syshead.h |   12 ------------
 5 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/configure.ac b/configure.ac
index baa66b2..da41554 100644
--- a/configure.ac
+++ b/configure.ac
@@ -701,11 +701,6 @@ if test "${enable_lzo}" = "yes" && test "${enable_lzo_stub}" = "no"; then
    fi
 fi
 
-dnl enable multi-client mode
-if test "${enable_lzo_stub}" = "yes"; then
-	AC_DEFINE([LZO_STUB], [1], [Enable LZO stub capability])
-fi
-
 PKG_CHECK_MODULES(
 	[PKCS11_HELPER],
 	[libpkcs11-helper-1 >= 1.02],
@@ -867,6 +862,13 @@ if test "${enable_selinux}" = "yes"; then
 	AC_DEFINE([ENABLE_SELINUX], [1], [SELinux support])
 fi
 
+if test "${enable_lzo_stub}" = "yes"; then
+	test "${enable_lzo}" = "yes" && AC_MSG_ERROR([Cannot have both lzo stub and lzo enabled])
+	AC_DEFINE([ENABLE_LZO_STUB], [1], [Enable LZO stub capability])
+	AC_DEFINE([USE_LZO], [1], [Enable LZO compression library])
+	AC_DEFINE([LZO_VERSION_NUM], ["STUB"], [LZO version number])
+fi
+
 if test "${enable_pkcs11}" = "yes"; then
 	test "${have_pkcs11_helper}" != "yes" && AC_MSG_ERROR([PKCS11 enabled but libpkcs11-helper is missing])
 	test "${enable_ssl}" != "yes" && AC_MSG_ERROR([PKCS11 can be enabled only if SSL is enabled])
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 7e50fc9..ca06f71 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -36,7 +36,7 @@
 
 #include "memdbg.h"
 
-#ifndef LZO_STUB
+#ifndef ENABLE_LZO_STUB
 /**
  * Perform adaptive compression housekeeping.
  *
@@ -91,7 +91,7 @@ lzo_adaptive_compress_data (struct lzo_adaptive_compress *ac, int n_total, int n
   ac->n_comp += n_comp;
 }
 
-#endif /* LZO_STUB */
+#endif /* ENABLE_LZO_STUB */
 
 void lzo_adjust_frame_parameters (struct frame *frame)
 {
@@ -109,7 +109,7 @@ lzo_compress_init (struct lzo_compress_workspace *lzowork, unsigned int flags)
   CLEAR (*lzowork);
 
   lzowork->flags = flags;
-#ifndef LZO_STUB
+#ifndef ENABLE_LZO_STUB
   lzowork->wmem_size = LZO_WORKSPACE;
 
   if (lzo_init () != LZO_E_OK)
@@ -129,7 +129,7 @@ lzo_compress_uninit (struct lzo_compress_workspace *lzowork)
   if (lzowork)
     {
       ASSERT (lzowork->defined);
-#ifndef LZO_STUB
+#ifndef ENABLE_LZO_STUB
       lzo_free (lzowork->wmem);
       lzowork->wmem = NULL;
 #endif
@@ -140,7 +140,7 @@ lzo_compress_uninit (struct lzo_compress_workspace *lzowork)
 static inline bool
 lzo_compression_enabled (struct lzo_compress_workspace *lzowork)
 {
-#ifndef LZO_STUB
+#ifndef ENABLE_LZO_STUB
   if ((lzowork->flags & (LZO_SELECTED|LZO_ON)) == (LZO_SELECTED|LZO_ON))
     {
       if (lzowork->flags & LZO_ADAPTIVE)
@@ -157,7 +157,7 @@ lzo_compress (struct buffer *buf, struct buffer work,
 	      struct lzo_compress_workspace *lzowork,
 	      const struct frame* frame)
 {
-#ifndef LZO_STUB
+#ifndef ENABLE_LZO_STUB
   lzo_uint zlen = 0;
   int err;
   bool compressed = false;
@@ -168,7 +168,7 @@ lzo_compress (struct buffer *buf, struct buffer work,
   if (buf->len <= 0)
     return;
 
-#ifndef LZO_STUB
+#ifndef ENABLE_LZO_STUB
   /*
    * In order to attempt compression, length must be at least COMPRESS_THRESHOLD,
    * and our adaptive level must give the OK.
@@ -226,7 +226,7 @@ lzo_decompress (struct buffer *buf, struct buffer work,
 		struct lzo_compress_workspace *lzowork,
 		const struct frame* frame)
 {
-#ifndef LZO_STUB
+#ifndef ENABLE_LZO_STUB
   lzo_uint zlen = EXPANDED_SIZE (frame);
   int err;
 #endif
@@ -244,7 +244,7 @@ lzo_decompress (struct buffer *buf, struct buffer work,
 
   if (c == YES_COMPRESS)	/* packet was compressed */
     {
-#ifndef LZO_STUB
+#ifndef ENABLE_LZO_STUB
       ASSERT (buf_safe (&work, zlen));
       err = LZO_DECOMPRESS (BPTR (buf), BLEN (buf), BPTR (&work), &zlen,
 			    lzowork->wmem);
@@ -291,7 +291,7 @@ void lzo_print_stats (const struct lzo_compress_workspace *lzo_compwork, struct
 {
   ASSERT (lzo_compwork->defined);
 
-#ifndef LZO_STUB
+#ifndef ENABLE_LZO_STUB
   status_printf (so, "pre-compress bytes," counter_format, lzo_compwork->pre_compress);
   status_printf (so, "post-compress bytes," counter_format, lzo_compwork->post_compress);
   status_printf (so, "pre-decompress bytes," counter_format, lzo_compwork->pre_decompress);
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index 5fb2a15..da4bd88 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -39,7 +39,7 @@
  * @{
  */
 
-#ifndef LZO_STUB
+#ifndef ENABLE_LZO_STUB
 #ifdef LZO_HEADER_DIR
 #include "lzo/lzoutil.h"
 #include "lzo/lzo1x.h"
@@ -68,7 +68,7 @@
 
 /**************************************************************************/
 /** @name LZO library interface defines *//** @{ *//***********************/
-#ifndef LZO_STUB
+#ifndef ENABLE_LZO_STUB
 #define LZO_COMPRESS    lzo1x_1_15_compress
                                 /**< LZO library compression function.
                                  *
@@ -90,7 +90,7 @@
                                  *   verify the integrity of incoming
                                  *   packets, you might want to consider
                                  *   using the non-safe version. */
-#endif /* LZO_STUB */
+#endif /* ENABLE_LZO_STUB */
 /** @} name LZO library interface *//**************************************/
 
 
@@ -98,10 +98,10 @@
 /** @name Miscellaneous compression defines *//** @{ *//*******************/
 #define LZO_EXTRA_BUFFER(len) ((len)/8 + 128 + 3)
                                 /**< LZO 2.0 worst-case size expansion. */
-#ifndef LZO_STUB
+#ifndef ENABLE_LZO_STUB
 #define COMPRESS_THRESHOLD 100  /**< Minimum packet size to attempt
                                  *   compression. */
-#endif /* LZO_STUB */
+#endif /* ENABLE_LZO_STUB */
 /** @} name Miscellaneous compression defines *//**************************/
 
 
@@ -119,7 +119,7 @@
 
 /**************************************************************************/
 /** @name Adaptive compression defines *//** @{ *//************************/
-#ifndef LZO_STUB
+#ifndef ENABLE_LZO_STUB
 #define AC_SAMP_SEC    2        /**< Number of seconds in a sample period. */
 #define AC_MIN_BYTES   1000     /**< Minimum number of bytes a sample
                                  *   period must contain for it to be
@@ -129,10 +129,10 @@
                                  *   turned off. */
 #define AC_OFF_SEC     60       /**< Seconds to wait after compression has
                                  *   been turned off before retesting. */
-#endif /* LZO_STUB */
+#endif /* ENABLE_LZO_STUB */
 /** @} name Adaptive compression defines *//*******************************/
 
-#ifndef LZO_STUB
+#ifndef ENABLE_LZO_STUB
 
 /**
  * Adaptive compression state.
@@ -144,7 +144,7 @@ struct lzo_adaptive_compress {
   int n_comp;
 };
 
-#endif /* LZO_STUB */
+#endif /* ENABLE_LZO_STUB */
 
 
 /**
@@ -161,7 +161,7 @@ struct lzo_compress_workspace
 {
   bool defined;
   unsigned int flags;
-#ifndef LZO_STUB
+#ifndef ENABLE_LZO_STUB
   lzo_voidp wmem;
   int wmem_size;
   struct lzo_adaptive_compress ac;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e260718..ba06ff7 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1652,7 +1652,7 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
       }
 
       /* push LZO status */
-#ifdef LZO_STUB
+#ifdef ENABLE_LZO_STUB
       buf_printf (&out, "IV_LZO_STUB=1\n");
 #endif
 
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 53b7580..bfdf148 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -700,18 +700,6 @@ socket_defined (const socket_descriptor_t sd)
 #define ENABLE_CLIENT_NAT
 
 /*
- * Support LZO as a stub in client? (LZO lib not included, but we
- * we still support LZO protocol changes that allow us to
- * communicate with an LZO-enabled server)
- */
-#ifdef LZO_STUB
-#undef USE_LZO
-#undef LZO_VERSION_NUM
-#define USE_LZO 1
-#define LZO_VERSION_NUM "STUB"
-#endif
-
-/*
  * Enable --memstats option
  */
 #ifdef TARGET_LINUX
-- 
1.7.3.4


