Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8D0606A32E
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZjfsU49p;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BL5uvRiX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iczv2DPl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=upU86YsgUhxqIvpz7tYWKHfNfs2zh95HMZO5mCjncdM=; b=ZjfsU49pc+mPVS
	vSAXWCM6SObxdyOY6/Qx3Oig38K3X65Y9mYWkIft9xaiBfnbV0xSy4yv0LToxcaMYng4QTQbMB/Lj
	omcqsrXrFZ8COF200KRKarm1Ldj19SdYjc0eiuz4OYR+v/WRJI0znf/sZWz1cykMwTjsucB0aID0f
	sL0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVV5Y-000000004nN-1IhO;
	Mon, 23 Nov 2026 14:32:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xVV5X-000000004nF-05XM for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 14:32:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=be7SqBg4b9BIs3y/zak8F7+WDpi+LzC5tfI+aY0qERw=; b=BL5uvRiXFEw1Rm5lK82LJE7s/D
 DrHSJh6jRP4AF0E40jtYqkO5pCsHQz+LbB/67aWNAHS1PKZJBmtr35/634MMDcwer0U5jyor3eyW/
 ZbwBH6edj1AVDucS3NqFKiBd4Ul0yuiIj5WmFE/CgzzG7utejoYB6Kz14RHHJCqFqUYI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=be7SqBg4b9BIs3y/zak8F7+WDpi+LzC5tfI+aY0qERw=; b=iczv2DPlF9Ka3LZog4cmdkd/JF
 pbS3iD37EcPp36+zd/mlX4uRayP8QXC4STj61W3axgpu8R1vX2sKpp9PfDBemzkmvR3MT3l3yRLnf
 LGUsrpWU6GDw5+cTevLkcHStSIIyoWMPjwR37mZDKAO0ztF5OIu5VBpzn5jytXwSDfUc=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVV5V-0000000057e-0bpl for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 14:32:10 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ANEW2Qf004074
 for <openvpn-devel@lists.sourceforge.net>; Mon, 23 Nov 2026 15:32:02 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ANEW21r004073
 for openvpn-devel@lists.sourceforge.net; Mon, 23 Nov 2026 15:32:02 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 23 Nov 2026 15:31:56 +0100
Message-ID: <20261123143201.4058-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795442905000.I189f3a311719b5c4476351702a44870d485d10d8@gerrit.openvpn.net>
References: <gerrit.1795442905000.I189f3a311719b5c4476351702a44870d485d10d8@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xVV5V-0000000057e-0bpl
Subject: [Openvpn-devel] [PATCH v1] comp: drop compression on send leftovers
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

7f0214c9 ("Remove support for compression on send") left the LZO
compression workspace, adaptive compression state and related defines
behind. lzo1x_decompress_safe() ignores its work memory argument, so
stop allocating LZO1X_1_15_MEM_COMPRESS bytes (256 KiB on 64-bit) per
LZO compression context and pass NULL instead.

Remove the now empty compress_workspace_union, COMPRESS_THRESHOLD and
D_COMP_LOW, probe for lzo1x_decompress_safe() instead of the unused
compressor in configure, and update the compression module docs.

Change-Id: I189f3a311719b5c4476351702a44870d485d10d8
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2328
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2328
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/configure.ac b/configure.ac
index 585c3bd..05fa964 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1001,11 +1001,11 @@
 	have_lzo="yes"
 	AC_CHECK_LIB(
 		[lzo2],
-		[lzo1x_1_15_compress],
+		[lzo1x_decompress_safe],
 		[LZO_LIBS="-llzo2"],
 		[AC_CHECK_LIB(
 			[lzo],
-			[lzo1x_1_15_compress],
+			[lzo1x_decompress_safe],
 			[LZO_LIBS="-llzo"],
 			[have_lzo="no"]
 		)]
diff --git a/doc/doxygen/doc_compression.h b/doc/doxygen/doc_compression.h
index efd18bf..4c60e74 100644
--- a/doc/doxygen/doc_compression.h
+++ b/doc/doxygen/doc_compression.h
@@ -29,31 +29,21 @@
 /**
  * @defgroup compression Data Channel Compression module
  *
- * This module offers compression of data channel packets.
+ * This module decompresses incoming data channel packets and adds
+ * compression framing to outgoing ones.
  *
  * @par State structures
  * The Data Channel Compression module stores its internal state in a \c
- * lzo_compress_workspace structure.  This state includes flags which
- * control the module's behavior and preallocated working memory.  One
- * such structure is present for each VPN tunnel, and is stored in the \c
- * context.c2.lzo_compwork of the \c context associated with that VPN
- * tunnel.
+ * compress_context structure.  One such structure is present for each VPN
+ * tunnel, and is stored in the \c context.c2.comp_context of the \c
+ * context associated with that VPN tunnel.
  *
  * @par Initialization and cleanup
- * Every time a new \c lzo_compress_workspace is needed, it must be
- * initialized using the \c lzo_compress_init() function.  Similarly,
- * every time a \c lzo_compress_workspace is no longer needed, it must be
- * cleaned up using the \c lzo_compress_uninit() function.  These
- * functions take care of the allocation and freeing of internal working
- * memory, but not of the \c lzo_compress_workspace structures themselves.
- *
- * @par
- * Because of the one-to-one relationship between \c
- * lzo_compress_workspace structures and VPN tunnels, the above-mentioned
- * initialization and cleanup functions are called directly from the \c
- * init_instance() and \c close_instance() functions, which control the
- * initialization and cleanup of VPN tunnel instances and their associated
- * \c context structures.
+ * \c comp_init() allocates a \c compress_context and calls the \c
+ * compress_init method of its \c compress_alg; \c comp_uninit() calls
+ * the \c compress_uninit method and frees the structure.  Both are called
+ * from \c init_instance() and \c close_instance(), and when pushed
+ * options change.
  *
  * @par Packet processing functions
  * This module receives data channel packets from the \link data_control
@@ -67,25 +57,25 @@
  *
  * @par Settings that control this module's activity
  * Whether or not the Data Channel Compression module is active depends on
- * the compile-time \c ENABLE_LZO preprocessor macro and the runtime flags
- * stored in \c lzo_compress_workspace.flags of the associated VPN tunnel.
- * The latter are initialized from \c options.lzo, which gets its value
- * from the process's configuration sources, such as its configuration
- * file or command line %options.
+ * the compile-time \c USE_COMP preprocessor macro and on \c
+ * options.comp.alg, which gets its value from the process's configuration
+ * sources, such as its configuration file or command line %options.
+ * \c comp_init() creates no \c compress_context if no algorithm is set.
+ * The flags in \c compress_context.flags, copied from \c
+ * options.comp.flags, only adjust framing, option checks and which
+ * algorithms are advertised to the peer.
  *
- * @par Adaptive compression
- * The compression module supports adaptive compression.  If this feature
- * is enabled, the compression routines monitor their own performance and
- * turn compression on or off depending on whether it is leading to
- * significantly reduced payload size.
+ * @par Outgoing packets
+ * Outgoing packets are never compressed, only framed so that the peer
+ * can parse them.
  *
  * @par Compression algorithms
- * This module uses the Lempel-Ziv-Oberhumer (LZO) compression algorithms.
- * These offer lossless compression and are designed for high-performance
- * decompression.  This module uses the external \c lzo library's
- * implementation of the algorithms.
+ * This module supports the Lempel-Ziv-Oberhumer (LZO) and LZ4
+ * algorithms, as implemented by the external \c lzo and \c lz4
+ * libraries.
  *
  * @par
- * For more information on the LZO library, see:\n
- * https://www.oberhumer.com/opensource/lzo/
+ * For more information on these libraries, see:\n
+ * https://www.oberhumer.com/opensource/lzo/ \n
+ * https://lz4.org/
  */
diff --git a/src/openvpn/comp-lz4.h b/src/openvpn/comp-lz4.h
index 3d04771..10dbe59 100644
--- a/src/openvpn/comp-lz4.h
+++ b/src/openvpn/comp-lz4.h
@@ -31,10 +31,5 @@
 extern const struct compress_alg lz4_alg;
 extern const struct compress_alg lz4v2_alg;
 
-struct lz4_workspace
-{
-    int dummy;
-};
-
 #endif /* ENABLE_LZ4 */
 #endif
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 3f6411b..4abf870 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -132,11 +132,6 @@
  */
 #define COMP_EXTRA_BUFFER(len) ((len) / 6 + 128 + 3 + COMP_PREFIX_LEN)
 
-/*
- * Don't try to compress any packet smaller than this.
- */
-#define COMPRESS_THRESHOLD 100
-
 /* Forward declaration of compression context */
 struct compress_context;
 
@@ -167,26 +162,12 @@
 #endif
 
 /*
- * Workspace union of all supported compression algorithms
- */
-union compress_workspace_union
-{
-#ifdef ENABLE_LZO
-    struct lzo_compress_workspace lzo;
-#endif
-#ifdef ENABLE_LZ4
-    struct lz4_workspace lz4;
-#endif
-};
-
-/*
  * Context for active compression session
  */
 struct compress_context
 {
     unsigned int flags;
     struct compress_alg alg;
-    union compress_workspace_union wu;
 
     /* statistics */
     counter_type pre_decompress;
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index 5cea0ad..62ec731 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -123,7 +123,6 @@
 #define D_MTU_DEBUG        LOGLEV(7, 70, M_DEBUG)  /* show MTU debugging info */
 #define D_MULTI_DEBUG      LOGLEV(7, 70, M_DEBUG)  /* show medium-freq multi debugging info */
 #define D_MSS              LOGLEV(7, 70, M_DEBUG)  /* show MSS adjustments */
-#define D_COMP_LOW         LOGLEV(7, 70, M_DEBUG)  /* show adaptive compression state changes */
 #define D_CONNECTION_LIST  LOGLEV(7, 70, M_DEBUG)  /* show <connection> list info */
 #define D_SCRIPT           LOGLEV(7, 70, M_DEBUG)  /* show parms & env vars passed to scripts */
 #define D_SHOW_NET         LOGLEV(7, 70, M_DEBUG)  /* show routing table and adapter list */
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 207cea6..f5ae776 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -35,7 +35,6 @@
 
 #include "comp.h"
 #include "error.h"
-#include "otime.h"
 
 #include "memdbg.h"
 
@@ -50,7 +49,6 @@
 {
     msg(D_INIT_MEDIUM, "LZO compression initializing");
     ASSERT(!(compctx->flags & COMP_F_SWAP));
-    compctx->wu.lzo.wmem_size = LZO_WORKSPACE;
 
     int lzo_status = lzo_init();
     if (lzo_status != LZO_E_OK)
@@ -58,15 +56,11 @@
         msg(M_FATAL, "Cannot initialize LZO compression library (lzo_init() returns %d)",
             lzo_status);
     }
-    compctx->wu.lzo.wmem = (lzo_voidp)malloc(compctx->wu.lzo.wmem_size);
-    check_malloc_return(compctx->wu.lzo.wmem);
 }
 
 static void
 lzo_compress_uninit(struct compress_context *compctx)
 {
-    free(compctx->wu.lzo.wmem);
-    compctx->wu.lzo.wmem = NULL;
 }
 
 static void
@@ -89,7 +83,7 @@
     if (c == LZO_COMPRESS_BYTE) /* packet was compressed */
     {
         ASSERT(buf_safe(&work, zlen));
-        int err = LZO_DECOMPRESS(BPTR(buf), BLENZ(buf), BPTR(&work), &zlen, compctx->wu.lzo.wmem);
+        int err = LZO_DECOMPRESS(BPTR(buf), BLENZ(buf), BPTR(&work), &zlen, NULL);
         if (err != LZO_E_OK)
         {
             dmsg(D_COMP_ERRORS, "LZO decompression error: %d", err);
diff --git a/src/openvpn/lzo.h b/src/openvpn/lzo.h
index bb9cc81..3a8586c 100644
--- a/src/openvpn/lzo.h
+++ b/src/openvpn/lzo.h
@@ -57,17 +57,6 @@
 
 /**************************************************************************/
 /** @name LZO library interface defines */ /** @{ */ /***********************/
-#define LZO_COMPRESS   lzo1x_1_15_compress
-/**< LZO library compression function.
- *
- *   Use \c lzo1x_1_15_compress because it
- *   is described as faster than the
- *   standard routine, although it does
- *   need a bit more memory. */
-#define LZO_WORKSPACE  LZO1X_1_15_MEM_COMPRESS
-/**< The size in bytes of the memory
- *   %buffer required by the LZO library
- *   compression algorithm. */
 #define LZO_DECOMPRESS lzo1x_decompress_safe
 /**< LZO library decompression function.
  *
@@ -80,52 +69,6 @@
  *   using the non-safe version. */
 /** @} name LZO library interface */ /**************************************/
 
-
-/**************************************************************************/
-/** @name Adaptive compression defines */ /** @{ */ /************************/
-#define AC_SAMP_SEC 2                               /**< Number of seconds in a sample period. */
-#define AC_MIN_BYTES                                                                      \
-    1000                                            /**< Minimum number of bytes a sample \
-                                                     *   period must contain for it to be \
-                                                     *   evaluated. */
-#define AC_SAVE_PCT                                                                        \
-    5                                               /**< Minimum size reduction percentage \
-                                                     *   below which compression will be   \
-                                                     *   turned off. */
-#define AC_OFF_SEC                                                                             \
-    60                                              /**< Seconds to wait after compression has \
-                                                     *   been turned off before retesting. */
-/** @} name Adaptive compression defines */         /*******************************/
-
-/**
- * Adaptive compression state.
- */
-struct lzo_adaptive_compress
-{
-    bool compress_state;
-    time_t next;
-    int n_total;
-    int n_comp;
-};
-
-
-/**
- * State for the compression and decompression routines.
- *
- * This structure contains compression module state, such as whether
- * compression is enabled and the status of the adaptive compression
- * routines.  It also contains an allocated working buffer.
- *
- * One of these compression workspace structures is maintained for each
- * VPN tunnel.
- */
-struct lzo_compress_workspace
-{
-    lzo_voidp wmem;
-    int wmem_size;
-    struct lzo_adaptive_compress ac;
-};
-
 /** @} addtogroup compression */
 
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
