From: Adriaan de Jong <dejong@...1435...>
Date: Wed, 22 Jun 2011 08:51:32 +0200
Message-ID: <1308725496-10620-5-git-send-email-dejong@...1435...>
In-Reply-To: <1308725496-10620-1-git-send-email-dejong@...1435...>
References: <1308725496-10620-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/8] Added compression docs
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

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 doc_compression.h |   92 ++++++++++++++++++
 lzo.c             |   19 ++--
 lzo.h             |  279 +++++++++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 341 insertions(+), 49 deletions(-)
 create mode 100644 doc_compression.h

diff --git a/doc_compression.h b/doc_compression.h
new file mode 100644
index 0000000..0296b27
--- /dev/null
+++ b/doc_compression.h
@@ -0,0 +1,92 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
+ *
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
+/**
+ * @file Data Channel Compression module documentation file.
+ */
+
+/**
+ * @defgroup compression Data Channel Compression module
+ * 
+ * This module offers compression of data channel packets.
+ * 
+ * @par State structures
+ * The Data Channel Compression module stores its internal state in a \c
+ * lzo_compress_workspace structure.  This state includes flags which
+ * control the module's behavior and preallocated working memory.  One
+ * such structure is present for each VPN tunnel, and is stored in the \c
+ * context.c2.lzo_compwork of the \c context associated with that VPN
+ * tunnel.
+ * 
+ * @par Initialization and cleanup
+ * Every time a new \c lzo_compress_workspace is needed, it must be
+ * initialized using the \c lzo_compress_init() function.  Similarly,
+ * every time a \c lzo_compress_workspace is no longer needed, it must be
+ * cleaned up using the \c lzo_compress_uninit() function.  These
+ * functions take care of the allocation and freeing of internal working
+ * memory, but not of the \c lzo_compress_workspace structures themselves.
+ * 
+ * @par
+ * Because of the one-to-one relationship between \c
+ * lzo_compress_workspace structures and VPN tunnels, the above-mentioned
+ * initialization and cleanup functions are called directly from the \c
+ * init_instance() and \c close_instance() functions, which control the
+ * initialization and cleanup of VPN tunnel instances and their associated
+ * \c context structures.
+ * 
+ * @par Packet processing functions
+ * This module receives data channel packets from the \link data_control
+ * Data Channel Control module\endlink and processes them according to the
+ * settings of the packet's VPN tunnel.  The \link data_control Data
+ * Channel Control module\endlink uses the following interface functions:
+ * - For packets which will be sent to a remote OpenVPN peer: \c
+ *   lzo_compress()
+ * - For packets which have been received from a remote OpenVPN peer: \c
+ *   lzo_decompress()
+ * 
+ * @par Settings that control this module's activity
+ * Whether or not the Data Channel Compression module is active depends on
+ * the compile-time \c USE_LZO preprocessor macro and the runtime flags
+ * stored in \c lzo_compress_workspace.flags of the associated VPN tunnel.
+ * The latter are initialized from \c options.lzo, which gets its value
+ * from the process's configuration sources, such as its configuration
+ * file or command line %options.
+ * 
+ * @par Adaptive compression
+ * The compression module supports adaptive compression.  If this feature
+ * is enabled, the compression routines monitor their own performance and
+ * turn compression on or off depending on whether it is leading to
+ * significantly reduced payload size.
+ * 
+ * @par Compression algorithms
+ * This module uses the Lempel-Ziv-Oberhumer (LZO) compression algorithms.
+ * These offer lossless compression and are designed for high-performance
+ * decompression.  This module uses the external \c lzo library's
+ * implementation of the algorithms.
+ * 
+ * @par
+ * For more information on the LZO library, see:\n
+ * http://www.oberhumer.com/opensource/lzo/
+ */
diff --git a/lzo.c b/lzo.c
index 3d6aa5a..64945d0 100644
--- a/lzo.c
+++ b/lzo.c
@@ -22,6 +22,10 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+/**
+ * @file Data Channel Compression module function definitions.
+ */
+
 #include "syshead.h"
 
 #ifdef USE_LZO
@@ -33,7 +37,13 @@
 #include "memdbg.h"
 
 #ifndef LZO_STUB
-
+/**
+ * Perform adaptive compression housekeeping.
+ * 
+ * @param ac the adaptive compression state structure.
+ * 
+ * @return 
+ */
 static bool
 lzo_adaptive_compress_test (struct lzo_adaptive_compress *ac)
 {
@@ -142,10 +152,6 @@ lzo_compression_enabled (struct lzo_compress_workspace *lzowork)
   return false;
 }
 
-/* Magic numbers to tell our peer if we compressed or not */
-#define YES_COMPRESS 0x66
-#define NO_COMPRESS  0xFA
-
 void
 lzo_compress (struct buffer *buf, struct buffer work,
 	      struct lzo_compress_workspace *lzowork,
@@ -281,9 +287,6 @@ lzo_modify_flags (struct lzo_compress_workspace *lzowork, unsigned int flags)
   lzowork->flags = flags;
 }
 
-/*
- * Print statistics
- */
 void lzo_print_stats (const struct lzo_compress_workspace *lzo_compwork, struct status_output *so)
 {
   ASSERT (lzo_compwork->defined);
diff --git a/lzo.h b/lzo.h
index 831f204..cc25869 100644
--- a/lzo.h
+++ b/lzo.h
@@ -25,8 +25,20 @@
 #ifndef OPENVPN_LZO_H
 #define OPENVPN_LZO_H
 
+
+/**
+ * @file
+ * Data Channel Compression module header file.
+ */
+
+
 #ifdef USE_LZO
 
+/**
+ * @addtogroup compression
+ * @{
+ */
+
 #ifndef LZO_STUB
 #ifdef LZO_HEADER_DIR
 #include "lzo/lzoutil.h"
@@ -42,52 +54,89 @@
 #include "common.h"
 #include "status.h"
 
-/* LZO flags */
-#define LZO_SELECTED   (1<<0)
-#define LZO_ON         (1<<1)
-#define LZO_ADAPTIVE   (1<<2)  
-
-/*
- * Length of prepended prefix on LZO packets
- */ 
-#define LZO_PREFIX_LEN 1
-
-/*
- * LZO 2.0 worst case size expansion
- */
-#define LZO_EXTRA_BUFFER(len) ((len)/8 + 128 + 3)
+/**************************************************************************/
+/** @name Bit-flags which control data channel packet compression *//******/
+/** @{ */
+#define LZO_SELECTED   (1<<0)   /**< Bit-flag indicating that compression
+                                 *   of data channel packets is enabled. */
+#define LZO_ON         (1<<1)   /**< Bit-flag indicating that compression
+                                 *   of data channel packets is active. */
+#define LZO_ADAPTIVE   (1<<2)   /**< Bit-flag indicating that adaptive
+                                 *   compression of data channel packets
+                                 *   has been selected. */
+/** @} name Bit-flags which control data channel packet compression *//****/
 
+/**************************************************************************/
+/** @name LZO library interface defines *//** @{ *//***********************/
 #ifndef LZO_STUB
-
-/*
- * Use LZO compress routine lzo1x_1_15_compress which is described
- * as faster but needs a bit more memory than the standard routine.
- * Use safe decompress (i.e. check for buffer overflows).
- * You may want to use the non-safe version
- * of decompress if speed is essential and if you know
- * that you will always be using a MAC to verify the
- * integrity of incoming packets.
- */
 #define LZO_COMPRESS    lzo1x_1_15_compress
+                                /**< LZO library compression function.
+                                 *   
+                                 *   Use \c lzo1x_1_15_compress because it
+                                 *   is described as faster than the
+                                 *   standard routine, although it does
+                                 *   need a bit more memory. */
 #define LZO_WORKSPACE	LZO1X_1_15_MEM_COMPRESS
+                                /**< The size in bytes of the memory
+                                 *   %buffer required by the LZO library
+                                 *   compression algorithm. */
 #define LZO_DECOMPRESS  lzo1x_decompress_safe
+                                /**< LZO library decompression function.
+                                 *   
+                                 *   Use safe decompress because it
+                                 *   includes checks for possible %buffer
+                                 *   overflows. If speed is essential and
+                                 *   you will always be using a MAC to
+                                 *   verify the integrity of incoming
+                                 *   packets, you might want to consider
+                                 *   using the non-safe version. */
+#endif /* LZO_STUB */
+/** @} name LZO library interface *//**************************************/
 
-/*
- * Don't try to compress any packet smaller than this.
- */
-#define COMPRESS_THRESHOLD 100
 
-/*
- * Adaptive compress parameters
- */
-#define AC_SAMP_SEC    2      /* number of seconds in sample period */
-#define AC_MIN_BYTES   1000   /* sample period must have at least n bytes
-				 to be valid for testing */
-#define AC_SAVE_PCT    5      /* turn off compress if we didn't save at
-				 least this % during sample period */
-#define AC_OFF_SEC     60     /* if we turn off compression, don't do sample
-				 retest for n seconds */
+/**************************************************************************/
+/** @name Miscellaneous compression defines *//** @{ *//*******************/
+#define LZO_EXTRA_BUFFER(len) ((len)/8 + 128 + 3)
+                                /**< LZO 2.0 worst-case size expansion. */
+#ifndef LZO_STUB
+#define COMPRESS_THRESHOLD 100  /**< Minimum packet size to attempt
+                                 *   compression. */
+#endif /* LZO_STUB */
+/** @} name Miscellaneous compression defines *//**************************/
+
+
+/**************************************************************************/
+/** @name Compression header defines *//** @{ *//**************************/
+#define LZO_PREFIX_LEN 1        /**< Length in bytes of prepended
+                                 *   compression header. */
+#define YES_COMPRESS 0x66       /**< Single-byte compression header
+                                 *   indicating this packet has been
+                                 *   compressed. */
+#define NO_COMPRESS  0xFA       /**< Single-byte compression header
+                                 *   indicating this packet has not been
+                                 *   compressed. */
+/** @} name Compression header defines *//*********************************/
+
+/**************************************************************************/
+/** @name Adaptive compression defines *//** @{ *//************************/
+#ifndef LZO_STUB
+#define AC_SAMP_SEC    2        /**< Number of seconds in a sample period. */
+#define AC_MIN_BYTES   1000     /**< Minimum number of bytes a sample
+                                 *   period must contain for it to be
+                                 *   evaluated. */
+#define AC_SAVE_PCT    5        /**< Minimum size reduction percentage
+                                 *   below which compression will be
+                                 *   turned off. */
+#define AC_OFF_SEC     60       /**< Seconds to wait after compression has
+                                 *   been turned off before retesting. */
+#endif /* LZO_STUB */
+/** @} name Adaptive compression defines *//*******************************/
 
+#ifndef LZO_STUB
+
+/**
+ * Adaptive compression state.
+ */
 struct lzo_adaptive_compress {
   bool compress_state;
   time_t next;
@@ -97,10 +146,17 @@ struct lzo_adaptive_compress {
 
 #endif /* LZO_STUB */
 
-/*
- * Compress and Uncompress routines.
- */
 
+/**
+ * State for the compression and decompression routines.
+ * 
+ * This structure contains compression module state, such as whether
+ * compression is enabled and the status of the adaptive compression
+ * routines.  It also contains an allocated working buffer.
+ * 
+ * One of these compression workspace structures is maintained for each
+ * VPN tunnel.
+ */
 struct lzo_compress_workspace
 {
   bool defined;
@@ -118,30 +174,171 @@ struct lzo_compress_workspace
 #endif
 };
 
+
+/**************************************************************************/
+/** @name Functions for initialization and cleanup *//** @{ *//************/
+
+/**
+ * Adjust %frame parameters for data channel payload compression.
+ * 
+ * Data channel packet compression requires a single-byte header to
+ * indicate whether a packet has been compressed or not. The packet
+ * handling buffers must also allow for worst-case payload compression
+ * where the compressed content size is actually larger than the original
+ * content size. This function adjusts the parameters of a given frame
+ * structure to include the header and allow for worst-case compression
+ * expansion.
+ * 
+ * @param frame        - The frame structure to adjust.
+ */
 void lzo_adjust_frame_parameters(struct frame *frame);
 
+/**
+ * Initialize a compression workspace structure.
+ * 
+ * This function initializes the given workspace structure \a lzowork.
+ * This includes allocating a work buffer for internal use and setting its
+ * flags to the given value of \a flags.
+ * 
+ * This function also initializes the lzo library.
+ * 
+ * @param lzowork      - A pointer to the workspace structure to
+ *                       initialize.
+ * @param flags        - The initial flags to set in the workspace
+ *                       structure.
+ */
 void lzo_compress_init (struct lzo_compress_workspace *lzowork, unsigned int flags);
 
+/**
+ * Cleanup a compression workspace structure.
+ * 
+ * This function cleans up the given workspace structure \a lzowork.  This
+ * includes freeing the structure's internal work buffer.
+ * 
+ * @param lzowork      - A pointer to the workspace structure to clean up.
+ */
 void lzo_compress_uninit (struct lzo_compress_workspace *lzowork);
 
+/**
+ * Set a workspace structure's flags.
+ * 
+ * @param lzowork      - The workspace structure of which to modify the
+ *                       flags.
+ * @param flags        - The new value to assign to the workspace
+ *                       structure's flags.
+ */
 void lzo_modify_flags (struct lzo_compress_workspace *lzowork, unsigned int flags);
 
+/** @} name Functions for initialization and cleanup *//*******************/
+
+
+/**************************************************************************/
+/** @name Function for packets to be sent to a remote OpenVPN peer *//*****/
+/** @{ */
+
+/**
+ * Process an outgoing packet according to a VPN tunnel's settings.
+ * @ingroup compression
+ * 
+ * This function processes the packet contained in \a buf.  Its behavior
+ * depends on the settings contained within \a lzowork.  If compression is
+ * enabled and active, this function compresses the packet.  After
+ * compression, the size of the uncompressed and compressed packets are
+ * compared, and the smallest is used.
+ * 
+ * This function prepends a one-byte header indicating whether the packet
+ * was or was not compressed, so as to let the peer know how to handle the
+ * packet.
+ * 
+ * If an error occurs during processing, an error message is logged and
+ * the length of \a buf is set to zero.
+ * 
+ * @param buf          - A pointer to the buffer containing the outgoing
+ *                       packet.  This pointer will be modified to point
+ *                       to the processed packet on return.
+ * @param work         - A preallocated working buffer.
+ * @param lzowork      - The compression workspace structure associated
+ *                       with this VPN tunnel.
+ * @param frame        - The frame parameters of this tunnel.
+ * 
+ * @return Void.\n  On return, \a buf will point to a buffer containing
+ *     the processed, possibly compressed, packet data with a compression
+ *     header prepended.
+ */
 void lzo_compress (struct buffer *buf, struct buffer work,
 		   struct lzo_compress_workspace *lzowork,
 		   const struct frame* frame);
 
+/** @} name Function for packets to be sent to a remote OpenVPN peer *//***/
+
+
+/**************************************************************************/
+/** @name Function for packets received from a remote OpenVPN peer *//*****/
+/** @{ */
+
+/**
+ * Inspect an incoming packet and decompress if it is compressed.
+ * 
+ * This function inspects the incoming packet contained in \a buf.  If its
+ * one-byte compression header indicates that it was compressed (i.e. \c
+ * YES_COMPRESS), then it will be decompressed.  If its header indicates
+ * that it was not compressed (i.e. \c NO_COMPRESS), then the buffer is
+ * not modified except for removing the compression header.
+ * 
+ * If an error occurs during processing, for example if the compression
+ * header has a value other than \c YES_COMPRESS or \c NO_COMPRESS, then
+ * the error is logged and the length of \a buf is set to zero.
+ * 
+ * @param buf          - A pointer to the buffer containing the incoming
+ *                       packet.  This pointer will be modified to point
+ *                       to the processed packet on return.
+ * @param work         - A preallocated working buffer.
+ * @param lzowork      - The compression workspace structure associated
+ *                       with this VPN tunnel.
+ * @param frame        - The frame parameters of this tunnel.
+ * 
+ * @return Void.\n  On return, \a buf will point to a buffer containing
+ *     the uncompressed packet data and the one-byte compression header
+ *     will have been removed.
+ */
 void lzo_decompress (struct buffer *buf, struct buffer work,
 		     struct lzo_compress_workspace *lzowork,
 		     const struct frame* frame);
 
+/** @} name Function for packets received from a remote OpenVPN peer *//***/
+
+
+/**************************************************************************/
+/** @name Utility functions *//** @{ *//***********************************/
+
+/**
+ * Print statistics on compression and decompression performance.
+ * 
+ * @param lzo_compwork - The workspace structure from which to get the
+ *                       statistics.
+ * @param so           - The status output structure to which to write the
+ *                       statistics.
+ */
 void lzo_print_stats (const struct lzo_compress_workspace *lzo_compwork, struct status_output *so);
 
+/**
+ * Check whether compression is enabled for a workspace structure.
+ * 
+ * @param lzowork      - The workspace structure to check.
+ * 
+ * @return true if compression is enabled; false otherwise.
+ */
 static inline bool
 lzo_defined (const struct lzo_compress_workspace *lzowork)
 {
   return lzowork->defined;
 }
 
+/** @} name Utility functions *//******************************************/
+
+
+/** @} addtogroup compression */
+
 
 #endif /* USE_LZO */
 #endif
-- 
1.7.4.1


