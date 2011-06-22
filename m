From: Adriaan de Jong <dejong@...1435...>
Date: Wed, 22 Jun 2011 08:51:30 +0200
Message-ID: <1308725496-10620-3-git-send-email-dejong@...1435...>
In-Reply-To: <1308725496-10620-1-git-send-email-dejong@...1435...>
References: <1308725496-10620-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/8] Added data channel crypto docs
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
 crypto.h          |  168 +++++++++++++++++++++++++++++++++++++++++++++--------
 doc_data_crypto.h |   75 ++++++++++++++++++++++++
 2 files changed, 218 insertions(+), 25 deletions(-)
 create mode 100644 doc_data_crypto.h

diff --git a/crypto.h b/crypto.h
index fcd4661..973677d 100644
--- a/crypto.h
+++ b/crypto.h
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+
+/**
+ * @file
+ */
+
+
 #ifndef CRYPTO_H
 #define CRYPTO_H
 #ifdef USE_CRYPTO
@@ -199,72 +205,118 @@ struct key_type
   const EVP_MD *digest;
 };
 
-/*
- * A random key.
+
+/**
+ * Container for unidirectional cipher and HMAC %key material.
+ * @ingroup control_processor
  */
 struct key
 {
   uint8_t cipher[MAX_CIPHER_KEY_LENGTH];
+                                /**< %Key material for cipher operations. */
   uint8_t hmac[MAX_HMAC_KEY_LENGTH];
+                                /**< %Key material for HMAC operations. */
 };
 
 #define KEY_DIRECTION_BIDIRECTIONAL 0 /* same keys for both directions */
 #define KEY_DIRECTION_NORMAL        1 /* encrypt with keys[0], decrypt with keys[1] */
 #define KEY_DIRECTION_INVERSE       2 /* encrypt with keys[1], decrypt with keys[0] */
 
-/*
- * Dual random keys (for encrypt/decrypt)
+/**
+ * Container for bidirectional cipher and HMAC %key material.
+ * @ingroup control_processor
  */
 struct key2
 {
-  int n;
-  struct key keys[2];
+  int n;                        /**< The number of \c key objects stored
+                                 *   in the \c key2.keys array. */
+  struct key keys[2];           /**< Two unidirectional sets of %key
+                                 *   material. */
 };
 
-/*
- * Used for controlling bidirectional keys
- * vs. a separate key for each direction.
+/**
+ * %Key ordering of the \c key2.keys array.
+ * @ingroup control_processor
+ * 
+ * This structure takes care of correct ordering when using unidirectional
+ * or bidirectional %key material, and allows the same shared secret %key
+ * file to be loaded in the same way by client and server by having one of
+ * the hosts use an reversed ordering.
  */
 struct key_direction_state
 {
-  int out_key;
-  int in_key;
-  int need_keys;
+  int out_key;                  /**< Index into the \c key2.keys array for
+                                 *   the sending direction. */
+  int in_key;                   /**< Index into the \c key2.keys array for
+                                 *   the receiving direction. */
+  int need_keys;                /**< The number of key objects necessary
+                                 *   to support both sending and
+                                 *   receiving.
+                                 *   
+                                 *   This will be 1 if the same keys are
+                                 *   used in both directions, or 2 if
+                                 *   there are two sets of unidirectional
+                                 *   keys. */
 };
 
-/*
- * A key context for cipher and/or HMAC.
+/**
+ * Container for one set of OpenSSL cipher and/or HMAC contexts.
+ * @ingroup control_processor
  */
 struct key_ctx
 {
-  EVP_CIPHER_CTX *cipher;
-  HMAC_CTX *hmac;
+  EVP_CIPHER_CTX *cipher;       /**< OpenSSL cipher %context. */
+  HMAC_CTX *hmac;               /**< OpenSSL HMAC %context. */
 };
 
-/*
- * Cipher/HMAC key context for both sending and receiving
- * directions.
+/**
+ * Container for two sets of OpenSSL cipher and/or HMAC contexts for both
+ * sending and receiving directions.
+ * @ingroup control_processor
  */
 struct key_ctx_bi
 {
-  struct key_ctx encrypt;
-  struct key_ctx decrypt;
+  struct key_ctx encrypt;       /**< OpenSSL cipher and/or HMAC contexts
+                                 *   for sending direction. */
+  struct key_ctx decrypt;       /**< OpenSSL cipher and/or HMAC contexts
+                                 *   for receiving direction. */
 };
 
-/*
- * Options for encrypt/decrypt.
+/**
+ * Security parameter state for processing data channel packets.
+ * @ingroup data_crypto
  */
 struct crypto_options
 {
   struct key_ctx_bi *key_ctx_bi;
-  struct packet_id *packet_id;
+                                /**< OpenSSL cipher and HMAC contexts for
+                                 *   both sending and receiving
+                                 *   directions. */
+  struct packet_id *packet_id;  /**< Current packet ID state for both
+                                 *   sending and receiving directions. */
   struct packet_id_persist *pid_persist;
+                                /**< Persistent packet ID state for
+                                 *   keeping state between successive
+                                 *   OpenVPN process startups. */
 
 # define CO_PACKET_ID_LONG_FORM  (1<<0)
+                                /**< Bit-flag indicating whether to use
+                                 *   OpenVPN's long packet ID format. */
 # define CO_USE_IV               (1<<1)
+                                /**< Bit-flag indicating whether to
+                                 *   generate a pseudo-random IV for each
+                                 *   packet being encrypted. */
 # define CO_IGNORE_PACKET_ID     (1<<2)
+                                /**< Bit-flag indicating whether to ignore
+                                 *   the packet ID of a received packet. 
+                                 *   This flag is used during processing
+                                 *   of the first packet received from a
+                                 *   client. */
 # define CO_MUTE_REPLAY_WARNINGS (1<<3)
-  unsigned int flags;
+                                /**< Bit-flag indicating not to display
+                                 *   replay warnings. */
+  unsigned int flags;           /**< Bit-flags determining behavior of
+                                 *   security operation functions. */
 };
 
 void init_key_type (struct key_type *kt, const char *ciphername,
@@ -313,14 +365,80 @@ void init_key_ctx (struct key_ctx *ctx, struct key *key,
 void free_key_ctx (struct key_ctx *ctx);
 void free_key_ctx_bi (struct key_ctx_bi *ctx);
 
+
+/**************************************************************************/
+/** @name Functions for performing security operations on data channel packets
+ *  @{ */
+
+/**
+ * Encrypt and HMAC sign a packet so that it can be sent as a data channel
+ * VPN tunnel packet to a remote OpenVPN peer.
+ * @ingroup data_crypto
+ * 
+ * This function handles encryption and HMAC signing of a data channel
+ * packet before it is sent to its remote OpenVPN peer.  It receives the
+ * necessary security parameters in the \a opt argument, which should have
+ * been set to the correct values by the \c tls_pre_encrypt() function.
+ * 
+ * This function calls the \c EVP_Cipher* and \c HMAC_* functions of the
+ * OpenSSL library to perform the actual security operations.
+ * 
+ * If an error occurs during processing, then the \a buf %buffer is set to
+ * empty.
+ * 
+ * @param buf          - The %buffer containing the packet on which to
+ *                       perform security operations.
+ * @param work         - A working %buffer.
+ * @param opt          - The security parameter state for this VPN tunnel.
+ * @param frame        - The packet geometry parameters for this VPN
+ *                       tunnel.
+ * @return This function returns void.\n On return, the \a buf argument
+ *     will point to the resulting %buffer.  This %buffer will either
+ *     contain the processed packet ready for sending, or be empty if an
+ *     error occurred.
+ */
 void openvpn_encrypt (struct buffer *buf, struct buffer work,
 		      const struct crypto_options *opt,
 		      const struct frame* frame);
 
+
+/**
+ * HMAC verify and decrypt a data channel packet received from a remote
+ * OpenVPN peer.
+ * @ingroup data_crypto
+ * 
+ * This function handles authenticating and decrypting a data channel
+ * packet received from a remote OpenVPN peer.  It receives the necessary
+ * security parameters in the \a opt argument, which should have been set
+ * to the correct values by the \c tls_pre_decrypt() function.
+ * 
+ * This function calls the \c EVP_Cipher* and \c HMAC_* functions of the
+ * OpenSSL library to perform the actual security operations.
+ * 
+ * If an error occurs during processing, then the \a buf %buffer is set to
+ * empty.
+ * 
+ * @param buf          - The %buffer containing the packet received from a
+ *                       remote OpenVPN peer on which to perform security
+ *                       operations.
+ * @param work         - A working %buffer.
+ * @param opt          - The security parameter state for this VPN tunnel.
+ * @param frame        - The packet geometry parameters for this VPN
+ *                       tunnel.
+ * 
+ * @return
+ * @li True, if the packet was authenticated and decrypted successfully.
+ * @li False, if an error occurred. \n On return, the \a buf argument will
+ *     point to the resulting %buffer.  This %buffer will either contain
+ *     the plaintext packet ready for further processing, or be empty if
+ *     an error occurred.
+ */
 bool openvpn_decrypt (struct buffer *buf, struct buffer work,
 		      const struct crypto_options *opt,
 		      const struct frame* frame);
 
+/** @} name Functions for performing security operations on data channel packets */
+
 
 void crypto_adjust_frame_parameters(struct frame *frame,
 				    const struct key_type* kt,
diff --git a/doc_data_crypto.h b/doc_data_crypto.h
new file mode 100644
index 0000000..1e281e9
--- /dev/null
+++ b/doc_data_crypto.h
@@ -0,0 +1,75 @@
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
+ * Data Channel Crypto module documentation file.
+ */
+
+/**
+ * @addtogroup data_crypto Data Channel Crypto module
+ * 
+ * The Data Channel Crypto Module performs cryptographic operations on
+ * data channel packets.
+ * 
+ * @par Security parameters
+ * This module is merely the user of a VPN tunnel's security parameters.
+ * It does not perform the negotiation and setup of the security
+ * parameters, nor the %key generation involved.  These actions are done
+ * by the \link control_processor Control Channel Processor\endlink.  This
+ * module receives the appropriate security parameters from that module in
+ * the form of a \c crypto_options structure when they are necessary for
+ * processing a packet.
+ * 
+ * @par Packet processing functions
+ * This module receives data channel packets from the \link data_control
+ * Data Channel Control module\endlink and processes them according to the
+ * security parameters of the packet's VPN tunnel.  The \link data_control
+ * Data Channel Control module\endlink uses the following interface
+ * functions:
+ *  - For packets which will be sent to a remote OpenVPN peer:
+ *     - \c tls_pre_encrypt()
+ *     - \c openvpn_encrypt()
+ *     - \c tls_post_encrypt()
+ *  - For packets which have been received from a remote OpenVPN peer:
+ *     - \c tls_pre_decrypt() (documented as part of the \link
+ *       external_multiplexer External Multiplexer\endlink)
+ *     - \c openvpn_decrypt()
+ * 
+ * @par Settings that control this module's activity
+ * Whether or not the Data Channel Crypto module is active depends on the
+ * compile-time \c USE_CRYPTO and \c USE_SSL preprocessor macros.  How it
+ * processes packets received from the \link data_control Data Channel
+ * Control module\endlink at runtime depends on the associated \c
+ * crypto_options structure.  To perform cryptographic operations, the \c
+ * crypto_options.key_ctx_bi must contain the correct cipher and HMAC
+ * security parameters for the direction the packet is traveling in.
+ * 
+ * @par Crypto algorithms
+ * This module uses the crypto algorithm implementations of the external
+ * OpenSSL library.  More precisely, it uses the OpenSSL library's \c
+ * EVP_Cipher* and \c HMAC_* set of functions to perform cryptographic
+ * operations on data channel packets.
+ */
-- 
1.7.4.1


