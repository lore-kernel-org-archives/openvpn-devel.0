From: Adriaan de Jong <dejong@...1435...>
Date: Wed, 22 Jun 2011 08:51:35 +0200
Message-ID: <1308725496-10620-8-git-send-email-dejong@...1435...>
In-Reply-To: <1308725496-10620-1-git-send-email-dejong@...1435...>
References: <1308725496-10620-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 7/8] Added data channel fragmentation docs
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
 doc_fragmentation.h |   96 +++++++++++
 fragment.h          |  439 ++++++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 461 insertions(+), 74 deletions(-)
 create mode 100644 doc_fragmentation.h

diff --git a/doc_fragmentation.h b/doc_fragmentation.h
new file mode 100644
index 0000000..e7e9c1e
--- /dev/null
+++ b/doc_fragmentation.h
@@ -0,0 +1,96 @@
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
+ * @file
+ * Data Channel Fragmentation module documentation file.
+ */
+
+/**
+ * @defgroup fragmentation Data Channel Fragmentation module
+ * 
+ * The Data Channel Fragmentation module offers fragmentation of data
+ * channel packets.
+ * 
+ * @par State structures
+ * The Data Channel Fragmentation module stores its internal state in a \c
+ * fragment_master structure.  One such structure is present for each VPN
+ * tunnel, and is stored in \c context.c2.fragment of the \c context
+ * associated with that VPN tunnel.
+ * 
+ * @par
+ * The \c fragment_master structure contains one \c fragment_list
+ * structure \c fragment_master.incoming.  This is a list of \c fragment
+ * structures, each of which can store the parts of one fragmented packet
+ * while it is being reassembled.  The \c fragment_master structure also
+ * contains one \c buffer called \c fragment_master.outgoing, in which a
+ * data channel large packet to be sent to a remote OpenVPN peer can be
+ * broken up into parts to be sent one by one.
+ * 
+ * @par Initialization and cleanup
+ * Every time a new \c fragment_master is needed, it must be allocated and
+ * initialized by the \c fragment_init() function.  Similarly, every time
+ * a \c fragment_master is no longer needed, it must be cleaned up using
+ * the \c fragment_free() function.  These functions take care of the
+ * allocation and freeing of the \c fragment_master structure itself and
+ * all internal memory required for the use of that structure.  Note that
+ * this behavior is different from that displayed by the \link compression
+ * Data Channel Compression module\endlink.
+ * 
+ * @par
+ * Because of the one-to-one relationship between \c fragment_master
+ * structures and VPN tunnels, the above-mentioned initialization and
+ * cleanup functions are called directly from the \c init_instance() and
+ * \c close_instance() functions, which control the initialization and
+ * cleanup of VPN tunnel instances and their associated \c context
+ * structures.
+ * 
+ * @par Packet processing functions
+ * This module receives data channel packets from the \link data_control
+ * Data Channel Control module\endlink and processes them according to the
+ * settings of the packet's VPN tunnel.  The \link data_control Data
+ * Channel Control module\endlink uses the following interface functions:
+ * - For packets which will be sent to a remote OpenVPN peer: \c
+ *   fragment_outgoing() \n This function inspects data channel packets as
+ *   they are being made ready to be sent as VPN tunnel packets to a
+ *   remote OpenVPN peer.  If a packet's size is larger than its
+ *   destination VPN tunnel's maximum transmission unit (MTU), then this
+ *   module breaks that packet up into smaller parts, each of which is
+ *   smaller than or equal to the VPN tunnel's MTU.  See \c
+ *   fragment_outgoing() for details.
+ * - For packets which have been received from a remote OpenVPN peer: \c
+ *   fragment_incoming() \n This function inspects data channel packets
+ *   that have been received from a remote OpenVPN peer through a VPN
+ *   tunnel.  It reads the fragmentation header of the packet, and
+ *   depending on its value performs the appropriate action.  See \c
+ *   fragment_incoming() for details.
+ * 
+ * @par Settings that control this module's activity
+ * Whether the Data Channel Fragmentation module is active or not depends
+ * on the compile-time \c ENABLE_FRAGMENT preprocessor macro and the
+ * runtime flag \c options.fragment, which gets its value from the
+ * process's configuration sources, such as the configuration file and
+ * commandline %options.
+ */
diff --git a/fragment.h b/fragment.h
index fc2b1b8..10bb6b2 100644
--- a/fragment.h
+++ b/fragment.h
@@ -25,8 +25,20 @@
 #ifndef FRAGMENT_H
 #define FRAGMENT_H
 
+/**
+ * @file
+ * Data Channel Fragmentation module header file.
+ */
+
+
 #ifdef ENABLE_FRAGMENT
 
+/**
+ * @addtogroup fragmentation
+ * @{
+ */
+
+
 #include "common.h"
 #include "buffer.h"
 #include "interval.h"
@@ -34,143 +46,422 @@
 #include "shaper.h"
 #include "error.h"
 
-#define N_FRAG_BUF                   25      /* number of packet buffers */
-#define FRAG_TTL_SEC                 10      /* number of seconds time-to-live for a fragment */
-#define FRAG_WAKEUP_INTERVAL         5       /* wakeup code called once per n seconds */
 
-struct fragment {
-  bool defined;
+#define N_FRAG_BUF                   25
+                                /**< Number of packet buffers for
+                                 *   reassembling incoming fragmented
+                                 *   packets. */
 
-  int max_frag_size;               /* maximum size of each fragment */
+#define FRAG_TTL_SEC                 10
+                                /**< Time-to-live in seconds for a %fragment. */
 
-  /*
-   * 32 bit array corresponding to each fragment.  A 1 bit in element n means that
-   * the fragment n has been received.  Needs to have at least MAX_FRAGS bits.
-   */
-# define FRAG_MAP_MASK 0xFFFFFFFF
-# define MAX_FRAGS             32  /* maximum number of fragments per packet */
-  unsigned int map;
+#define FRAG_WAKEUP_INTERVAL         5
+                                /**< Interval in seconds between calls to
+                                 *   wakeup code. */
 
-  time_t timestamp;                /* timestamp for time-to-live purposes */
+/**************************************************************************/
+/**
+ * Structure for reassembling one incoming fragmented packet.
+ */
+struct fragment {
+  bool defined;                 /**< Whether reassembly is currently
+                                 *   taking place in this structure. */
+	
+  int max_frag_size;		/**< Maximum size of each %fragment. */
 
-  struct buffer buf;               /* fragment assembly buffer for received datagrams */
+# define FRAG_MAP_MASK 0xFFFFFFFF
+                                /**< Mask for reassembly map. */
+# define MAX_FRAGS 32		/**< Maximum number of fragments per packet. */
+  unsigned int map;             
+                                /**< Reassembly map for recording which
+                                 *   fragments have been received.
+                                 *   
+                                 *   A bit array where each bit
+                                 *   corresponds to a %fragment.  A 1 bit
+                                 *   in element n means that the %fragment
+                                 *   n has been received.  Needs to have
+                                 *   at least \c MAX_FRAGS bits. */
+
+  time_t timestamp;		/**< Timestamp for time-to-live purposes. */
+
+  struct buffer buf;            /**< Buffer in which received datagrams
+                                 *   are reassembled. */
 };
 
+
+/**
+ * List of fragment structures for reassembling multiple incoming packets
+ * concurrently.
+ */
 struct fragment_list {
-  int seq_id;
-  int index;
+  int seq_id;                   /**< Highest fragmentation sequence ID of
+                                 *   the packets currently being
+                                 *   reassembled. */
+  int index;                    /**< Index of the packet being reassembled
+                                 *   with the highest fragmentation
+                                 *   sequence ID into the \c
+                                 *   fragment_list.fragments array. */
+
+/** Array of reassembly structures, each can contain one whole packet.
+ *  
+ *  The fragmentation sequence IDs of the packets being reassembled in
+ *  this array are linearly increasing. \c
+ *  fragment_list.fragments[fragment_list.index] has an ID of \c
+ *  fragment_list.seq_id.  This means that one of these \c fragment_list
+ *  structures can at any one time contain at most packets with the
+ *  fragmentation sequence IDs in the range \c fragment_list.seq_id \c -
+ *  \c N_FRAG_BUF \c + \c 1 to \c fragment_list.seq_id, inclusive.
+ */
   struct fragment fragments[N_FRAG_BUF];
 };
 
-struct fragment_master {
-  struct event_timeout wakeup;     /* when should main openvpn event loop wake us up */
-
-  /* true if the OS has explicitly recommended an MTU value */
-  bool received_os_mtu_hint;
 
-  /* a sequence ID describes a set of fragments that make up one datagram */
-# define N_SEQ_ID            256   /* sequence number wraps to 0 at this value (should be a power of 2) */
-  int outgoing_seq_id;             /* sent as FRAG_SEQ_ID below */
-
-  /* outgoing packet is possibly sent as a series of fragments */
-
-# define MAX_FRAG_PKT_SIZE 65536   /* maximum packet size */
-  int outgoing_frag_size;          /* sent to peer via FRAG_SIZE when FRAG_YES_LAST set */
-
-  int outgoing_frag_id;            /* each fragment in a datagram is numbered 0 to MAX_FRAGS-1 */ 
-
-  struct buffer outgoing;          /* outgoing datagram, free if current_frag_id == 0 */
-  struct buffer outgoing_return;   /* buffer to return outgoing fragment */
+/**
+ * Fragmentation and reassembly state for one VPN tunnel instance.
+ * 
+ * This structure contains all the state necessary for sending and
+ * receiving fragmented data channel packets associated with one VPN
+ * tunnel.
+ * 
+ * The fragmented packet currently being sent to a remote OpenVPN peer is
+ * stored in \c fragment_master.outgoing.  It is copied into that buffer
+ * by the \c fragment_outgoing() function and the remaining parts to be
+ * sent can be retrieved by successive calls to \c
+ * fragment_ready_to_send().
+ * 
+ * The received packets currently being reassembled are stored in the \c
+ * fragment_master.incoming array of \c fragment structures.  The \c
+ * fragment_incoming() function adds newly received parts into this array
+ * and returns the whole packets once reassembly is complete.
+ */
+struct fragment_master {
+  struct event_timeout wakeup;  /**< Timeout structure used by the main
+                                 *   event loop to know when to do
+                                 *   fragmentation housekeeping. */
+  bool received_os_mtu_hint;    /**< Whether the operating system has
+                                 *   explicitly recommended an MTU value. */
+# define N_SEQ_ID            256
+                                /**< One more than the maximum fragment
+                                 *   sequence ID, above which the IDs wrap
+                                 *   to zero.  Should be a power of 2. */
+  int outgoing_seq_id;          /**< Fragment sequence ID of the current
+                                 *   fragmented packet waiting to be sent.
+                                 *   
+                                 *   All parts of a fragmented packet
+                                 *   share the same sequence ID, so that
+                                 *   the remote OpenVPN peer can determine
+                                 *   which parts belong to which original
+                                 *   packet. */
+# define MAX_FRAG_PKT_SIZE 65536
+                                /**< (Not used) Maximum packet size before
+                                 *   fragmenting. */
+  int outgoing_frag_size;       /**< Size in bytes of each part to be
+                                 *   sent, except for the last part which
+                                 *   may be smaller.
+                                 *   
+                                 *   This value is computed by the \c
+                                 *   optimal_fragment_size() function. Its
+                                 *   value is sent to the remote peer in
+                                 *   the fragmentation header of the last
+                                 *   part (i.e. with %fragment type \c
+                                 *   FRAG_YES_LAST) using the \c
+                                 *   FRAG_SIZE_MASK and \c FRAG_SIZE_SHIFT
+                                 *   bits. */
+  int outgoing_frag_id;         /**< The fragment ID of the next part to
+                                 *   be sent.  Must have a value between 0
+                                 *   and \c MAX_FRAGS-1. */
+  struct buffer outgoing;       /**< Buffer containing the remaining parts
+                                 *   of the fragmented packet being sent. */
+  struct buffer outgoing_return;
+                                /**< Buffer used by \c
+                                 *   fragment_ready_to_send() to return a
+                                 *   part to send. */
 
-  /* incoming fragments from remote */
   struct fragment_list incoming;
+                                /**< List of structures for reassembling
+                                 *   incoming packets. */
 };
 
-/*
- * Fragment header sent over the wire.
- */
+
+/**************************************************************************/
+/** @name Fragment header
+ *  @todo Add description of %fragment header format.
+ *//** @{ *//*************************************/
 
 typedef uint32_t fragment_header_type;
+                                /**< Fragmentation information is stored in
+                                 *   a 32-bit packet header. */
 
-/* convert a fragment_header_type from host to network order */
 #define hton_fragment_header_type(x) htonl(x)
+                                /**< Convert a fragment_header_type from
+                                 *   host to network order. */
 
-/* convert a fragment_header_type from network to host order */
 #define ntoh_fragment_header_type(x) ntohl(x)
+                                /**< Convert a \c fragment_header_type
+                                 *   from network to host order. */
 
-/* FRAG_TYPE 2 bits */
 #define FRAG_TYPE_MASK        0x00000003
-#define FRAG_TYPE_SHIFT       0
-
-#define FRAG_WHOLE            0    /* packet is whole, FRAG_N_PACKETS_RECEIVED echoed back to peer */
-#define FRAG_YES_NOTLAST      1    /* packet is a fragment, but is not the last fragment,
-				      FRAG_N_PACKETS_RECEIVED set as above */
-#define FRAG_YES_LAST         2    /* packet is the last fragment, FRAG_SIZE = size of non-last frags */
-#define FRAG_TEST             3    /* control packet for establishing MTU size (not implemented yet) */
+                                /**< Bit mask for %fragment type info. */
+#define FRAG_TYPE_SHIFT       0 /**< Bit shift for %fragment type info. */
+
+#define FRAG_WHOLE            0 /**< Fragment type indicating packet is
+                                 *   whole. */
+#define FRAG_YES_NOTLAST      1 /**< Fragment type indicating packet is
+                                 *   part of a fragmented packet, but not
+                                 *   the last part in the sequence. */
+#define FRAG_YES_LAST         2 /**< Fragment type indicating packet is
+                                 *   the last part in the sequence of
+                                 *   parts. */
+#define FRAG_TEST             3 /**< Fragment type not implemented yet. 
+                                 *   In the future might be used as a
+                                 *   control packet for establishing MTU
+                                 *   size. */
 
-/* FRAG_SEQ_ID 8 bits */
 #define FRAG_SEQ_ID_MASK      0x000000ff
-#define FRAG_SEQ_ID_SHIFT     2
+                                /**< Bit mask for %fragment sequence ID. */
+#define FRAG_SEQ_ID_SHIFT     2 /**< Bit shift for %fragment sequence ID. */
 
-/* FRAG_ID 5 bits */
 #define FRAG_ID_MASK          0x0000001f
+                                /**< Bit mask for %fragment ID. */
 #define FRAG_ID_SHIFT         10
+                                /**< Bit shift for %fragment ID. */
 
 /*
  * FRAG_SIZE  14 bits
  *
  * IF FRAG_YES_LAST (FRAG_SIZE):
- *   The max size of a fragment.  If a fragment is not the last fragment in the packet,
- *   then the fragment size is guaranteed to be equal to the max fragment size.  Therefore,
+ *   The max size of a %fragment.  If a %fragment is not the last %fragment in the packet,
+ *   then the %fragment size is guaranteed to be equal to the max %fragment size.  Therefore,
  *   max_frag_size is only sent over the wire if FRAG_LAST is set.  Otherwise it is assumed
- *   to be the actual fragment size received.
+ *   to be the actual %fragment size received.
  */
-
-/* FRAG_SIZE 14 bits */
 #define FRAG_SIZE_MASK        0x00003fff
+                                /**< Bit mask for %fragment size. */
 #define FRAG_SIZE_SHIFT       15
-#define FRAG_SIZE_ROUND_SHIFT 2  /* fragment/datagram sizes represented as multiple of 4 */
-
+                                /**< Bit shift for %fragment size. */
+#define FRAG_SIZE_ROUND_SHIFT 2 /**< Bit shift for %fragment size rounding. */
 #define FRAG_SIZE_ROUND_MASK ((1 << FRAG_SIZE_ROUND_SHIFT) - 1)
+                                /**< Bit mask for %fragment size rounding. */
 
 /*
  * FRAG_EXTRA 16 bits
  *
  * IF FRAG_WHOLE or FRAG_YES_NOTLAST, these 16 bits are available (not currently used)
  */
-
-/* FRAG_EXTRA 16 bits */
 #define FRAG_EXTRA_MASK         0x0000ffff
+                                /**< Bit mask for extra bits. */
 #define FRAG_EXTRA_SHIFT        15
+                                /**< Bit shift for extra bits. */
 
-/*
- * Public functions
- */
+/** @} name Fragment header *//********************************************/
 
+
+/**************************************************************************/
+/** @name Functions for initialization and cleanup *//** @{ *//************/
+
+/**
+ * Allocate and initialize a \c fragment_master structure.
+ * 
+ * This function also modifies the \a frame packet geometry parameters to
+ * include space for the fragmentation header.
+ * 
+ * @param frame        - The packet geometry parameters for this VPN
+ *                       tunnel, modified by this function to include the
+ *                       fragmentation header.
+ * 
+ * @return A pointer to the new \c fragment_master structure.
+ */
 struct fragment_master *fragment_init (struct frame *frame);
 
+
+/**
+ * Allocate internal packet buffers for a \c fragment_master structure.
+ * 
+ * @param f            - The \c fragment_master structure for which to
+ *                       allocate the internal buffers.
+ * @param frame        - The packet geometry parameters for this VPN
+ *                       tunnel, used to determine how much memory to
+ *                       allocate for each packet buffer.
+ */
 void fragment_frame_init (struct fragment_master *f, const struct frame *frame);
 
+
+/**
+ * Free a \c fragment_master structure and its internal packet buffers.
+ * 
+ * @param f            - The \c fragment_master structure to free.
+ */
 void fragment_free (struct fragment_master *f);
 
+/** @} name Functions for initialization and cleanup *//*******************/
+
+
+/**************************************************************************/
+/** @name Functions for processing packets received from a remote OpenVPN peer */
+/** @{ */
+
+/**
+ * Process an incoming packet, which may or may not be fragmented.
+ * 
+ * This function inspects the fragmentation header of the incoming packet
+ * and processes the packet accordingly. Depending on the %fragment type
+ * bits (\c FRAG_TYPE_MASK and \c FRAG_TYPE_SHIFT) the packet is processed
+ * in the following ways:
+ *  - \c FRAG_WHOLE: the packet is not fragmented, and this function does
+ *    not modify its contents, except for removing the fragmentation
+ *    header.
+ *  - \c FRAG_YES_NOTLAST or \c FRAG_YES_LAST: the packet is part of a
+ *    fragmented packet.  This function copies the packet into an internal
+ *    reassembly buffer.  If the incoming part completes the packet being
+ *    reassembled, the \a buf argument is modified to point to the fully
+ *    reassembled packet.  If, on the other hand, reassembly is not yet
+ *    complete, then the the \a buf buffer is set to empty.
+ *  - Any other value: error.
+ * 
+ * If an error occurs during processing, an error message is logged and
+ * the length of \a buf is set to zero.
+ * 
+ * @param f            - The \c fragment_master structure for this VPN
+ *                       tunnel.
+ * @param buf          - A pointer to the buffer structure containing the
+ *                       incoming packet.  This pointer will have been
+ *                       modified on return either to point to a
+ *                       completely reassembled packet, or to have length
+ *                       set to zero if reassembly is not yet complete.
+ * @param frame        - The packet geometry parameters for this VPN
+ *                       tunnel.
+ * 
+ * @return Void.\n On return, the \a buf argument will point to a buffer.
+ *     The buffer will have nonzero length if the incoming packet passed
+ *     to this function was whole and unfragmented, or if it was the final
+ *     part of a fragmented packet thereby completing reassembly.  On the
+ *     other hand, the buffer will have a length of zero if the incoming
+ *     packet was part of a fragmented packet and reassembly is not yet
+ *     complete.  If an error occurs during processing, the buffer length
+ *     is also set to zero.
+ */
 void fragment_incoming (struct fragment_master *f, struct buffer *buf,
 			const struct frame* frame);
 
+/** @} name Functions for processing packets received from a VPN tunnel */
+
+
+/**************************************************************************/
+/** @name Functions for processing packets to be sent to a remote OpenVPN peer */
+/** @{ */
+
+/**
+ * Process an outgoing packet, which may or may not need to be fragmented.
+ * 
+ * This function inspects the outgoing packet, determines whether it needs
+ * to be fragmented, and processes it accordingly.
+ * 
+ * Depending on the size of the outgoing packet and the packet geometry
+ * parameters for the VPN tunnel, the packet will or will not be
+ * fragmented.
+ * @li Packet size is less than or equal to the maximum packet size for
+ *     this VPN tunnel: fragmentation is not necessary.  The \a buf
+ *     argument points to a buffer containing the unmodified outgoing
+ *     packet with a fragmentation header indicating the packet is whole
+ *     (FRAG_WHOLE) prepended.
+ * @li Packet size is greater than the maximum packet size for this VPN
+ *     tunnel: fragmentation is necessary.  The original outgoing packet
+ *     is copied into an internal buffer for fragmentation.  The \a buf
+ *     argument is modified to point to the first part of the fragmented
+ *     packet. The remaining parts remain stored in the internal buffer,
+ *     and can be retrieved using the \c fragment_ready_to_send()
+ *     function.
+ * 
+ * If an error occurs during processing, an error message is logged and
+ * the length of \a buf is set to zero.
+ * 
+ * @param f            - The \c fragment_master structure for this VPN
+ *                       tunnel.
+ * @param buf          - A pointer to the buffer structure containing the
+ *                       outgoing packet.  This pointer will be modified
+ *                       to point to a whole unfragmented packet or to the
+ *                       first part of a fragmented packet on return.
+ * @param frame        - The packet geometry parameters for this VPN
+ *                       tunnel.
+ * 
+ * @return Void.\n On return, the \a buf argument will point to a buffer.
+ *     This buffer contains either the whole original outgoing packet if
+ *     fragmentation was not necessary, or the first part of the
+ *     fragmented outgoing packet if fragmentation was necessary. In both
+ *     cases a fragmentation header will have been prepended to inform the
+ *     remote peer how to handle the packet.
+ */
 void fragment_outgoing (struct fragment_master *f, struct buffer *buf,
 			const struct frame* frame);
 
+/**
+ * Check whether outgoing fragments are ready to be send, and if so make
+ * one available.
+ * 
+ * This function checks whether the internal buffer for fragmenting
+ * outgoing packets contains any unsent parts.  If it does not, meaning
+ * there is nothing waiting to be sent, it returns false.  Otherwise there
+ * are parts ready to be sent, and it returns true.  In that case it also
+ * modifies the \a buf argument to point to a buffer containing the next
+ * part to be sent.
+ * 
+ * @param f            - The \a fragment_master structure for this VPN
+ *                       tunnel.
+ * @param buf          - A pointer to a buffer structure which on return,
+ *                       if there are parts waiting to be sent, will point
+ *                       to the next part to be sent.
+ * @param frame        - The packet geometry parameters for this VPN
+ *                       tunnel.
+ * 
+ * @return
+ * @li True, if an outgoing packet has been fragmented and not all parts
+ *     have been sent yet.  In this case this function will modify the \a
+ *     buf argument to point to a buffer containing the next part to be
+ *     sent.
+ * @li False, if there are no outgoing fragmented parts waiting to be
+ *     sent.
+ */
 bool fragment_ready_to_send (struct fragment_master *f, struct buffer *buf,
 			     const struct frame* frame);
 
-/*
- * Private functions.
+/**
+ * Check whether a \c fragment_master structure contains fragments ready
+ * to be sent.
+ * 
+ * @param f            - The \c fragment_master structure for this VPN
+ *                       tunnel.
+ * 
+ * @return
+ * @li True, if there are one or more fragments ready to be sent.
+ * @li False, otherwise.
  */
+static inline bool
+fragment_outgoing_defined (struct fragment_master *f)
+{
+  return f->outgoing.len > 0;
+}
+
+/** @} name Functions for processing packets going out through a VPN tunnel */
+
+
 void fragment_wakeup (struct fragment_master *f, struct frame *frame);
 
-/*
- * Inline functions
- */
 
+/**************************************************************************/
+/** @name Functions for regular housekeeping *//** @{ *//******************/
+
+/**
+ * Perform housekeeping of a \c fragment_master structure.
+ * 
+ * Housekeeping includes scanning incoming packet reassembly buffers for
+ * packets which have not yet been reassembled completely but are already
+ * older than their time-to-live.
+ * 
+ * @param f            - The \c fragment_master structure for this VPN
+ *                       tunnel.
+ * @param frame        - The packet geometry parameters for this VPN
+ *                       tunnel.
+ */
 static inline void
 fragment_housekeeping (struct fragment_master *f, struct frame *frame, struct timeval *tv)
 {
@@ -178,11 +469,11 @@ fragment_housekeeping (struct fragment_master *f, struct frame *frame, struct ti
     fragment_wakeup (f, frame);
 }
 
-static inline bool
-fragment_outgoing_defined (struct fragment_master *f)
-{
-  return f->outgoing.len > 0;
-}
+/** @} name Functions for regular housekeeping *//*************************/
+
+
+/** @} addtogroup fragmentation *//****************************************/
+
 
 #endif
 #endif
-- 
1.7.4.1


