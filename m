From: Adriaan de Jong <dejong@...1435...>
Date: Wed, 22 Jun 2011 10:34:02 +0200
Message-ID: <1308731642-27020-1-git-send-email-dejong@...1435...>
In-Reply-To: <4E01A5DB.4050808@...1114...>
References: <4E01A5DB.4050808@...1114...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 9/9] Moved doxygen-specific files to a
	separate directory
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

---
 doc_compression.h                  |   92 ------------
 doc_control_processor.h            |  189 ------------------------
 doc_control_tls.h                  |  105 --------------
 doc_data_control.h                 |  103 -------------
 doc_data_crypto.h                  |   75 ----------
 doc_eventloop.h                    |   67 ---------
 doc_external_multiplexer.h         |   46 ------
 doc_fragmentation.h                |   96 ------------
 doc_internal_multiplexer.h         |   44 ------
 doc_key_generation.h               |  148 -------------------
 doc_mainpage.h                     |  162 ---------------------
 doc_memory_management.h            |   99 -------------
 doc_protocol_overview.h            |  199 -------------------------
 doc_reliable.h                     |   49 -------
 doc_tunnel_state.h                 |  155 --------------------
 doxygen/doc_compression.h          |   92 ++++++++++++
 doxygen/doc_control_processor.h    |  189 ++++++++++++++++++++++++
 doxygen/doc_control_tls.h          |  105 ++++++++++++++
 doxygen/doc_data_control.h         |  103 +++++++++++++
 doxygen/doc_data_crypto.h          |   75 ++++++++++
 doxygen/doc_eventloop.h            |   67 +++++++++
 doxygen/doc_external_multiplexer.h |   46 ++++++
 doxygen/doc_fragmentation.h        |   96 ++++++++++++
 doxygen/doc_internal_multiplexer.h |   44 ++++++
 doxygen/doc_key_generation.h       |  148 +++++++++++++++++++
 doxygen/doc_mainpage.h             |  162 +++++++++++++++++++++
 doxygen/doc_memory_management.h    |   99 +++++++++++++
 doxygen/doc_protocol_overview.h    |  199 +++++++++++++++++++++++++
 doxygen/doc_reliable.h             |   49 +++++++
 doxygen/doc_tunnel_state.h         |  155 ++++++++++++++++++++
 doxygen/openvpn.doxyfile           |  279 ++++++++++++++++++++++++++++++++++++
 openvpn.doxyfile                   |  279 ------------------------------------
 32 files changed, 1908 insertions(+), 1908 deletions(-)
 delete mode 100644 doc_compression.h
 delete mode 100644 doc_control_processor.h
 delete mode 100644 doc_control_tls.h
 delete mode 100644 doc_data_control.h
 delete mode 100644 doc_data_crypto.h
 delete mode 100644 doc_eventloop.h
 delete mode 100644 doc_external_multiplexer.h
 delete mode 100644 doc_fragmentation.h
 delete mode 100644 doc_internal_multiplexer.h
 delete mode 100644 doc_key_generation.h
 delete mode 100644 doc_mainpage.h
 delete mode 100644 doc_memory_management.h
 delete mode 100644 doc_protocol_overview.h
 delete mode 100644 doc_reliable.h
 delete mode 100644 doc_tunnel_state.h
 create mode 100644 doxygen/doc_compression.h
 create mode 100644 doxygen/doc_control_processor.h
 create mode 100644 doxygen/doc_control_tls.h
 create mode 100644 doxygen/doc_data_control.h
 create mode 100644 doxygen/doc_data_crypto.h
 create mode 100644 doxygen/doc_eventloop.h
 create mode 100644 doxygen/doc_external_multiplexer.h
 create mode 100644 doxygen/doc_fragmentation.h
 create mode 100644 doxygen/doc_internal_multiplexer.h
 create mode 100644 doxygen/doc_key_generation.h
 create mode 100644 doxygen/doc_mainpage.h
 create mode 100644 doxygen/doc_memory_management.h
 create mode 100644 doxygen/doc_protocol_overview.h
 create mode 100644 doxygen/doc_reliable.h
 create mode 100644 doxygen/doc_tunnel_state.h
 create mode 100644 doxygen/openvpn.doxyfile
 delete mode 100644 openvpn.doxyfile

diff --git a/doc_compression.h b/doc_compression.h
deleted file mode 100644
index 0296b27..0000000
--- a/doc_compression.h
+++ /dev/null
@@ -1,92 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
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
-/**
- * @file Data Channel Compression module documentation file.
- */
-
-/**
- * @defgroup compression Data Channel Compression module
- * 
- * This module offers compression of data channel packets.
- * 
- * @par State structures
- * The Data Channel Compression module stores its internal state in a \c
- * lzo_compress_workspace structure.  This state includes flags which
- * control the module's behavior and preallocated working memory.  One
- * such structure is present for each VPN tunnel, and is stored in the \c
- * context.c2.lzo_compwork of the \c context associated with that VPN
- * tunnel.
- * 
- * @par Initialization and cleanup
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
- * 
- * @par Packet processing functions
- * This module receives data channel packets from the \link data_control
- * Data Channel Control module\endlink and processes them according to the
- * settings of the packet's VPN tunnel.  The \link data_control Data
- * Channel Control module\endlink uses the following interface functions:
- * - For packets which will be sent to a remote OpenVPN peer: \c
- *   lzo_compress()
- * - For packets which have been received from a remote OpenVPN peer: \c
- *   lzo_decompress()
- * 
- * @par Settings that control this module's activity
- * Whether or not the Data Channel Compression module is active depends on
- * the compile-time \c USE_LZO preprocessor macro and the runtime flags
- * stored in \c lzo_compress_workspace.flags of the associated VPN tunnel.
- * The latter are initialized from \c options.lzo, which gets its value
- * from the process's configuration sources, such as its configuration
- * file or command line %options.
- * 
- * @par Adaptive compression
- * The compression module supports adaptive compression.  If this feature
- * is enabled, the compression routines monitor their own performance and
- * turn compression on or off depending on whether it is leading to
- * significantly reduced payload size.
- * 
- * @par Compression algorithms
- * This module uses the Lempel-Ziv-Oberhumer (LZO) compression algorithms.
- * These offer lossless compression and are designed for high-performance
- * decompression.  This module uses the external \c lzo library's
- * implementation of the algorithms.
- * 
- * @par
- * For more information on the LZO library, see:\n
- * http://www.oberhumer.com/opensource/lzo/
- */
diff --git a/doc_control_processor.h b/doc_control_processor.h
deleted file mode 100644
index 506f8ab..0000000
--- a/doc_control_processor.h
+++ /dev/null
@@ -1,189 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
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
-/**
- * @file
- * Control Channel Processor module documentation file.
- */
-
-/**
- * @defgroup control_processor Control Channel Processor module
- * 
- * This module controls the setup and maintenance of VPN tunnels and the
- * associated security parameters.
- * 
- * @par This module's role
- * The Control Channel Processor module lies at the core of OpenVPN's
- * activities.  It handles the setup of new VPN tunnels, the negotiation
- * of data channel security parameters, the managing of active VPN
- * tunnels, and finally the cleanup of expired VPN tunnels.
- * 
- * @par State structures
- * A large amount of VPN tunnel state information must be stored within an
- * OpenVPN process.  A wide variety of container structures are used by
- * this module for that purpose.  Several of these structures are listed
- * below, and the function of the first three VPN tunnel state containers
- * is described in more detail later.
- *  - VPN tunnel state containers:
- *     - \c tls_multi, security parameter state for a single VPN tunnel.
- *       Contains three instances of the \c tls_session structure.
- *     - \c tls_session, security parameter state of a single session
- *       within a VPN tunnel.  Contains two instances of the \c key_state
- *       structure.
- *     - \c key_state, security parameter state of one TLS and data
- *       channel %key set.
- *  - Data channel security parameter containers:
- *     - \c key_ctx_bi, container for two sets of OpenSSL cipher and/or
- *       HMAC context (both directions).  Contains two instances of the \c
- *       key_ctx structure.
- *     - \c key_ctx, container for one set of OpenSSL cipher and/or HMAC
- *       context (one directions.
- *  - Key material containers:
- *     - \c key2, container for two sets of cipher and/or HMAC %key
- *       material (both directions).  Contains two instances of the \c key
- *       structure.
- *     - \c key, container for one set of cipher and/or HMAC %key material
- *       (one direction).
- *     - \c key_direction_state, ordering of %key material within the \c
- *       key2.key array.
- *  - Key method 2 random material containers:
- *     - \c key_source2, container for both halves of random material used
- *       for %key method 2.  Contains two instances of the \c key_source
- *       structure.
- *     - \c key_source, container for one half of random material used for
- *       %key method 2.
- * 
- * @par The life of a \c tls_multi object
- * A \c tls_multi structure contains all the security parameter state
- * information related to the control and data channels of one VPN tunnel.
- * Its life cycle can be summarized as follows:
- *  -# Initialization: \c tls_multi_init() and \c
- *     tls_multi_init_finalize(), which are called (indirectly) from \c
- *     init_instance() when initializing a new \c context structure.
- *     - Initializes a \c tls_multi structure.
- *     - Allocates the three \c tls_session objects contained by the \c
- *       tls_multi structure, and initializes as appropriate.
- *  -# Management: \c tls_multi_process() and \c tls_pre_decrypt()
- *     - If a new session is initiated by the remote peer, then \c
- *       tls_pre_decrypt() starts the new session negotiation in the
- *       un-trusted \c tls_session.
- *     - If the, as yet, un-trusted \c tls_session authenticates
- *       successfully, then \c tls_multi_process() moves it so as to be
- *       the active \c tls_session.
- *     - If an error occurs during processing of a \c key_state object,
- *       then \c tls_multi_process() cleans up and initializes the
- *       associated \c tls_session object.  If the error occurred in the
- *       active \c key_state of the active \c tls_session and the
- *       lame-duck \c key_state of that \c tls_session has not yet
- *       expired, it is preserved as fallback.
- *  -# Cleanup: \c tls_multi_free(), which is called (indirectly) from \c
- *     close_instance() when cleaning up a \c context structure.
- *     - Cleans up a \c tls_multi structure.
- *     - Cleans up the three \c tls_session objects contained by the \c
- *       tls_multi structure.
- * 
- * @par The life of a \c tls_session object
- * A \c tls_session structure contains the state information related to an
- * active and a lame-duck \c key_state.  Its life cycle can be summarized
- * as follows:
- *  -# Initialization: \c tls_session_init()
- *     - Initializes a \c tls_session structure.
- *     - Initializes the primary \c key_state by calling \c
- *       key_state_init().
- *  -# Renegotiation: \c key_state_soft_reset()
- *     - Cleans up the old lame-duck \c key_state by calling \c
- *       key_state_free().
- *     - Moves the old primary \c key_state to be the new lame-duck \c
- *       key_state.
- *     - Initializes a new primary \c key_state by calling \c
- *       key_state_init().
- *  -# Cleanup: \c tls_session_free()
- *     - Cleans up a \c tls_session structure.
- *     - Cleans up all \c key_state objects associated with the session by
- *       calling \c key_state_free() for each.
- * 
- * @par The life of a \c key_state object
- * A \c key_state structure represents one control and data channel %key
- * set.  It contains an OpenSSL TLS object that encapsulates the control
- * channel, and the data channel security parameters needed by the \link
- * data_crypto Data Channel Crypto module\endlink to perform cryptographic
- * operations on data channel packets.  Its life cycle can be summarized
- * as follows:
- *  -# Initialization: \c key_state_init()
- *     - Initializes a \c key_state structure.
- *     - Creates a new OpenSSL TLS object to encapsulate this new control
- *       channel session.
- *     - Sets \c key_state.state to \c S_INITIAL.
- *     - Allocates several internal buffers.
- *     - Initializes new reliability layer structures for this key set.
- *  -# Negotiation: \c tls_process()
- *     - The OpenSSL TLS object negotiates a TLS session between itself
- *       and the remote peer's TLS object.
- *     - Key material is generated and exchanged through the TLS session
- *       between OpenVPN peers.
- *     - Both peers initialize their data channel cipher and HMAC key
- *       contexts.
- *     - On successful negotiation, the \c key_state.state will progress
- *       from \c S_INITIAL to \c S_ACTIVE and \c S_NORMAL.
- *  -# Active tunneling: \link data_crypto Data Channel Crypto
- *     module\endlink
- *     - Data channel packet to be sent to a remote OpenVPN peer:
- *        - \c tls_pre_encrypt() loads the security parameters from the \c
- *          key_state into a \c crypto_options structure.
- *        - \c openvpn_encrypt() uses the \c crypto_options to an encrypt
- *          and HMAC sign the data channel packet.
- *     - Data channel packet received from a remote OpenVPN peer:
- *        - \c tls_pre_decrypt() loads the security parameters from the \c
- *          key_state into a \c crypto_options structure.
- *        - \c openvpn_encrypt() uses the \c crypto_options to
- *          authenticate and decrypt the data channel packet.
- *  -# Cleanup: \c key_state_free()
- *     - Cleans up a \c key_state structure together with its OpenSSL TLS
- *       object, key material, internal buffers, and reliability layer
- *       structures.
- * 
- * @par Control functions
- * The following two functions drive the Control Channel Processor's
- * activities.
- *  - \c tls_multi_process(), iterates through the \c tls_session objects
- *    within a given \c tls_multi of a VPN tunnel, and calls \c
- *    tls_process() for each \c tls_session which is being set up, is
- *    already active, or is busy expiring.
- *  - \c tls_process(), performs the Control Channel Processor module's
- *    core handling of received control channel messages, and generates
- *    appropriate messages to be sent.
- * 
- * @par Functions which control data channel key generation
- *  - Key method 1 key exchange functions:
- *     - \c key_method_1_write(), generates and processes key material to
- *       be sent to the remote OpenVPN peer.
- *     - \c key_method_1_read(), processes key material received from the
- *       remote OpenVPN peer.
- *  - Key method 2 key exchange functions:
- *     - \c key_method_2_write(), generates and processes key material to
- *       be sent to the remote OpenVPN peer.
- *     - \c key_method_2_read(), processes key material received from the
- *       remote OpenVPN peer.
- */
diff --git a/doc_control_tls.h b/doc_control_tls.h
deleted file mode 100644
index dd3a41c..0000000
--- a/doc_control_tls.h
+++ /dev/null
@@ -1,105 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
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
-/**
- * @file
- * Control Channel TLS module documentation file.
- */
-
-/**
- * @defgroup control_tls Control Channel TLS module
- * 
- * This module provides secure encapsulation of control channel messages
- * exchanged between OpenVPN peers.
- * 
- * The Control Channel TLS module uses the Transport Layer Security (TLS)
- * protocol to provide an encrypted communication channel between the
- * local OpenVPN process and a remote peer.  This protocol simultaneously
- * offers certificate-based authentication of the communicating parties.
- * 
- * @par This module's roles
- * The Control Channel TLS module is essential for the security of any
- * OpenVPN-based system.  On the one hand, it performs the security
- * operations necessary to protect control channel messages exchanged
- * between OpenVPN peers.  On the other hand, before the control and data
- * channels are even setup, it controls the exchange of certificates and
- * verification of the remote's identity during negotiation of VPN
- * tunnels.
- * 
- * @par
- * The former role is described below.  The latter is described in the
- * documentation for the \c verify_callback() function.
- * 
- * @par
- * In other words, this module takes care of the confidentiality and
- * integrity of data channel communications, and the authentication of
- * both the communicating parties and the control channel messages
- * exchanged.
- * 
- * @par Initialization and cleanup
- * Because of the one-to-one relationship between control channel TLS
- * state and \c key_state structures, the initialization and cleanup of an
- * instance of the Control Channel TLS module's state happens within the
- * \c key_state_init() and \c key_state_free() functions.  In other words,
- * each \c key_state object contains exactly one OpenSSL SSL-BIO object,
- * which is initialized and cleaned up together with the rest of the \c
- * key_state object.
- * 
- * @par Packet processing functions
- * This object behaves somewhat like a black box with a ciphertext and a
- * plaintext I/O port. Its interaction with OpenVPN's control channel
- * during operation takes place within the \c tls_process() function of
- * the \link control_processor Control Channel Processor\endlink.  The
- * following functions are available for processing packets:
- * - If ciphertext received from the remote peer is available in the \link
- *   reliable Reliability Layer\endlink:
- *   - Insert it into the ciphertext-side of the SSL-BIO.
- *   - Use function: \c key_state_write_ciphertext()
- * - If ciphertext can be extracted from the ciphertext-side of the
- *   SSL-BIO:
- *   - Pass it to the \link reliable Reliability Layer\endlink for sending
- *     to the remote peer.
- *   - Use function: \c key_state_read_ciphertext()
- * - If plaintext can be extracted from the plaintext-side of the SSL-BIO:
- *   - Pass it on to the \link control_processor Control Channel
- *     Processor\endlink for local processing.
- *   - Use function: \c key_state_read_plaintext()
- * - If plaintext from the \link control_processor Control Channel
- *   Processor\endlink is available to be sent to the remote peer:
- *   - Insert it into the plaintext-side of the SSL-BIO.
- *   - Use function: \c key_state_write_plaintext() or \c
- *     key_state_write_plaintext_const()
- * 
- * @par Transport Layer Security protocol implementation
- * This module uses the OpenSSL library's implementation of the TLS
- * protocol in the form of an OpenSSL SSL-BIO object.
- * 
- * @par
- * For more information on the OpenSSL library's BIO objects, please see:
- *  - OpenSSL's generic BIO objects:
- *    http://www.openssl.org/docs/crypto/bio.html
- *  - OpenSSL's SSL-BIO object:
- *    http://www.openssl.org/docs/crypto/BIO_f_ssl.html
- */
diff --git a/doc_data_control.h b/doc_data_control.h
deleted file mode 100644
index cebe28e..0000000
--- a/doc_data_control.h
+++ /dev/null
@@ -1,103 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
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
-/**
- * @file
- * Data Channel Control module documentation file.
- */
-
-/**
- * @defgroup data_control Data Channel Control module
- * 
- * This module controls the processing of packets as they pass through the
- * data channel.
- * 
- * The Data Channel Control module controls the processing of packets as
- * they pass through the data channel.  The processing includes packet
- * compression, fragmentation, and the performing of security operations
- * on the packets.  This module does not do the processing itself, but
- * passes the packet to other data channel modules to perform the
- * appropriate actions.
- * 
- * Packets can travel in two directions through the data channel.  They
- * can be going to a remote destination which is reachable through a VPN
- * tunnel, in which case this module prepares them to be sent out through
- * a VPN tunnel.  On the other hand, they can have been received through a
- * VPN tunnel from a remote OpenVPN peer, in which case this module
- * retrieves the packet in its original form as it was before entering the
- * VPN tunnel on the remote OpenVPN peer.  How this module processes
- * packets traveling in the two directions is discussed in more detail
- * below.
- * 
- * @par Packets to be sent to a remote OpenVPN peer
- * This module's main function for processing packets traveling in this
- * direction is \c encrypt_sign(), which performs the following processing
- * steps:
- * - Call the \link compression Data Channel Compression module\endlink to
- *   perform packet compression if necessary.
- * - Call the \link fragmentation Data Channel Fragmentation
- *   module\endlink to perform packet fragmentation if necessary.
- * - Call the \link data_crypto Data Channel Crypto module\endlink to
- *   perform the required security operations.
- * 
- * @par
- * See the \c encrypt_sign() documentation for details of these
- * interactions.
- * 
- * @par
- * After the above processing is complete, the packet is ready to be sent
- * to a remote OpenVPN peer as a VPN tunnel packet.  The actual sending of
- * the packet is handled by the \link external_multiplexer External
- * Multiplexer\endlink.
- * 
- * @par Packets received from a remote OpenVPN peer
- * The function that controls how packets traveling in this direction are
- * processed is \c process_incoming_link().  That function, however, also
- * performs some of the tasks required for the \link external_multiplexer
- * External Multiplexer\endlink and is therefore listed as part of that
- * module, instead of here.
- * 
- * @par
- * After the \c process_incoming_link() function has determined that a
- * received packet is a data channel packet, it performs the following
- * processing steps:
- * - Call the \link data_crypto Data Channel Crypto module\endlink to
- *   perform the required security operations.
- * - Call the \link fragmentation Data Channel Fragmentation
- *   module\endlink to perform packet reassembly if necessary.
- * - Call the \link compression Data Channel Compression module\endlink to
- *   perform packet decompression if necessary.
- * 
- * @par
- * See the \c process_incoming_link() documentation for details of these
- * interactions.
- * 
- * @par
- * After the above processing is complete, the packet is in its original
- * form again as it was received by the remote OpenVPN peer.  It can now
- * be routed further to its final destination.  If that destination is a
- * locally reachable host, then the \link internal_multiplexer Internal
- * Multiplexer\endlink will send it there.
- */
diff --git a/doc_data_crypto.h b/doc_data_crypto.h
deleted file mode 100644
index 1e281e9..0000000
--- a/doc_data_crypto.h
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
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
-/**
- * @file
- * Data Channel Crypto module documentation file.
- */
-
-/**
- * @addtogroup data_crypto Data Channel Crypto module
- * 
- * The Data Channel Crypto Module performs cryptographic operations on
- * data channel packets.
- * 
- * @par Security parameters
- * This module is merely the user of a VPN tunnel's security parameters.
- * It does not perform the negotiation and setup of the security
- * parameters, nor the %key generation involved.  These actions are done
- * by the \link control_processor Control Channel Processor\endlink.  This
- * module receives the appropriate security parameters from that module in
- * the form of a \c crypto_options structure when they are necessary for
- * processing a packet.
- * 
- * @par Packet processing functions
- * This module receives data channel packets from the \link data_control
- * Data Channel Control module\endlink and processes them according to the
- * security parameters of the packet's VPN tunnel.  The \link data_control
- * Data Channel Control module\endlink uses the following interface
- * functions:
- *  - For packets which will be sent to a remote OpenVPN peer:
- *     - \c tls_pre_encrypt()
- *     - \c openvpn_encrypt()
- *     - \c tls_post_encrypt()
- *  - For packets which have been received from a remote OpenVPN peer:
- *     - \c tls_pre_decrypt() (documented as part of the \link
- *       external_multiplexer External Multiplexer\endlink)
- *     - \c openvpn_decrypt()
- * 
- * @par Settings that control this module's activity
- * Whether or not the Data Channel Crypto module is active depends on the
- * compile-time \c USE_CRYPTO and \c USE_SSL preprocessor macros.  How it
- * processes packets received from the \link data_control Data Channel
- * Control module\endlink at runtime depends on the associated \c
- * crypto_options structure.  To perform cryptographic operations, the \c
- * crypto_options.key_ctx_bi must contain the correct cipher and HMAC
- * security parameters for the direction the packet is traveling in.
- * 
- * @par Crypto algorithms
- * This module uses the crypto algorithm implementations of the external
- * OpenSSL library.  More precisely, it uses the OpenSSL library's \c
- * EVP_Cipher* and \c HMAC_* set of functions to perform cryptographic
- * operations on data channel packets.
- */
diff --git a/doc_eventloop.h b/doc_eventloop.h
deleted file mode 100644
index f7e46cc..0000000
--- a/doc_eventloop.h
+++ /dev/null
@@ -1,67 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
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
-/**
- * @file
- * Main Event Loop module documentation file.
- */
-
-/**
- * @defgroup eventloop Main Event Loop module
- * 
- * This main event loop module drives the packet processing of OpenVPN.
- * 
- * OpenVPN is an event driven system.  Its activities are driven by a main
- * event loop, which repeatedly waits for one of several predefined events
- * to occur, and then calls the appropriate module to handle the event.
- * The major types of network events that OpenVPN processes are:
- * - A packet can be read from the external network interface.
- *   - The main event loop activates the \link external_multiplexer
- *     External Multiplexer\endlink to read and process the packet.
- * - A packet can be read from the virtual tun/tap network interface.
- *   - The main event loop activates the \link internal_multiplexer
- *     Internal Multiplexer\endlink to read and process the packet.
- * - If a packet is ready to be sent out as a VPN tunnel packet: the
- *   external network interface can be written to.
- *   - The main event loop activates the \link external_multiplexer
- *     External Multiplexer\endlink to send the packet.
- * - If a packet is ready to be sent to a locally reachable destination:
- *   the virtual tun/tap network interface can be written to.
- *   - The main event loop activates the \link internal_multiplexer
- *     Internal Multiplexer\endlink to send the packet.
- * 
- * Beside these external events, OpenVPN also processes other types of
- * internal events.  These include scheduled events, such as resending of
- * non-acknowledged control channel messages.
- * 
- * @par Main event loop implementations
- * 
- * Depending on the mode in which OpenVPN is running, a different main
- * event loop function is called to drive the event processing.  The
- * following implementations are available:
- * - Client mode using UDP or TCP: \c tunnel_point_to_point()
- * - Server mode using UDP: \c tunnel_server_udp_single_threaded()
- * - Server mode using TCP: \c tunnel_server_tcp()
- */
diff --git a/doc_external_multiplexer.h b/doc_external_multiplexer.h
deleted file mode 100644
index f78f648..0000000
--- a/doc_external_multiplexer.h
+++ /dev/null
@@ -1,46 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
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
-/**
- * @file
- * External Multiplexer module documentation file.
- */
-
-/**
- * @addtogroup external_multiplexer External Multiplexer module
- * 
- * The External Multiplexer is the link between the external network
- * interface and the other OpenVPN modules.  It reads packets from the
- * external network interface, determines which remote OpenVPN peer and
- * VPN tunnel they are associated with, and whether they are data channel
- * or control channel packets.  It then passes the packets on to the
- * appropriate processing module.
- * 
- * This module also handles packets traveling in the reverse direction,
- * which have been generated by the local control channel or which have
- * already been processed by the \link data_control Data Channel Control
- * module\endlink and are destined for a remote host reachable through a
- * VPN tunnel.
- */
diff --git a/doc_fragmentation.h b/doc_fragmentation.h
deleted file mode 100644
index e7e9c1e..0000000
--- a/doc_fragmentation.h
+++ /dev/null
@@ -1,96 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
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
-/**
- * @file
- * Data Channel Fragmentation module documentation file.
- */
-
-/**
- * @defgroup fragmentation Data Channel Fragmentation module
- * 
- * The Data Channel Fragmentation module offers fragmentation of data
- * channel packets.
- * 
- * @par State structures
- * The Data Channel Fragmentation module stores its internal state in a \c
- * fragment_master structure.  One such structure is present for each VPN
- * tunnel, and is stored in \c context.c2.fragment of the \c context
- * associated with that VPN tunnel.
- * 
- * @par
- * The \c fragment_master structure contains one \c fragment_list
- * structure \c fragment_master.incoming.  This is a list of \c fragment
- * structures, each of which can store the parts of one fragmented packet
- * while it is being reassembled.  The \c fragment_master structure also
- * contains one \c buffer called \c fragment_master.outgoing, in which a
- * data channel large packet to be sent to a remote OpenVPN peer can be
- * broken up into parts to be sent one by one.
- * 
- * @par Initialization and cleanup
- * Every time a new \c fragment_master is needed, it must be allocated and
- * initialized by the \c fragment_init() function.  Similarly, every time
- * a \c fragment_master is no longer needed, it must be cleaned up using
- * the \c fragment_free() function.  These functions take care of the
- * allocation and freeing of the \c fragment_master structure itself and
- * all internal memory required for the use of that structure.  Note that
- * this behavior is different from that displayed by the \link compression
- * Data Channel Compression module\endlink.
- * 
- * @par
- * Because of the one-to-one relationship between \c fragment_master
- * structures and VPN tunnels, the above-mentioned initialization and
- * cleanup functions are called directly from the \c init_instance() and
- * \c close_instance() functions, which control the initialization and
- * cleanup of VPN tunnel instances and their associated \c context
- * structures.
- * 
- * @par Packet processing functions
- * This module receives data channel packets from the \link data_control
- * Data Channel Control module\endlink and processes them according to the
- * settings of the packet's VPN tunnel.  The \link data_control Data
- * Channel Control module\endlink uses the following interface functions:
- * - For packets which will be sent to a remote OpenVPN peer: \c
- *   fragment_outgoing() \n This function inspects data channel packets as
- *   they are being made ready to be sent as VPN tunnel packets to a
- *   remote OpenVPN peer.  If a packet's size is larger than its
- *   destination VPN tunnel's maximum transmission unit (MTU), then this
- *   module breaks that packet up into smaller parts, each of which is
- *   smaller than or equal to the VPN tunnel's MTU.  See \c
- *   fragment_outgoing() for details.
- * - For packets which have been received from a remote OpenVPN peer: \c
- *   fragment_incoming() \n This function inspects data channel packets
- *   that have been received from a remote OpenVPN peer through a VPN
- *   tunnel.  It reads the fragmentation header of the packet, and
- *   depending on its value performs the appropriate action.  See \c
- *   fragment_incoming() for details.
- * 
- * @par Settings that control this module's activity
- * Whether the Data Channel Fragmentation module is active or not depends
- * on the compile-time \c ENABLE_FRAGMENT preprocessor macro and the
- * runtime flag \c options.fragment, which gets its value from the
- * process's configuration sources, such as the configuration file and
- * commandline %options.
- */
diff --git a/doc_internal_multiplexer.h b/doc_internal_multiplexer.h
deleted file mode 100644
index cdaf4a2..0000000
--- a/doc_internal_multiplexer.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
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
-/**
- * @file
- * Internal Multiplexer module documentation file.
- */
-
-/**
- * @addtogroup internal_multiplexer Internal Multiplexer module
- * 
- * The Internal Multiplexer is the link between the virtual tun/tap
- * network interface and the \link data_control Data Channel Control
- * module\endlink.  It reads packets from the virtual network interface,
- * determines for which remote OpenVPN peer they are destined, and then
- * passes the packets on to the Data Channel Control module together with
- * information about their destination VPN tunnel instance.
- * 
- * This module also handles packets traveling in the reverse direction,
- * which have already been processed by the Data Channel Control module
- * and are destined for a locally reachable host.
- */
diff --git a/doc_key_generation.h b/doc_key_generation.h
deleted file mode 100644
index cc8d677..0000000
--- a/doc_key_generation.h
+++ /dev/null
@@ -1,148 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
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
-/**
- * @file
- * Key generation documentation file.
- */
-
-/**
- * @page key_generation Data channel %key generation
- * 
- * This section describes how OpenVPN peers generate and exchange %key
- * material necessary for the security operations performed on data
- * channel packets.
- * 
- * The %key generation and exchange process between OpenVPN client and
- * server occurs every time data channel security parameters are
- * negotiated, for example during the initial setup of a VPN tunnel or
- * when the active security parameters expire.  In source code terms, this
- * is when a new key_state structure is initialized.
- * 
- * @section key_generation_method Key methods
- * 
- * OpenVPN supports two different ways of generating and exchanging %key
- * material between client and server.  These are known as %key method 1
- * and %key method 2.  %Key method 2 is the recommended method. Both are
- * explained below.
- * 
- * @subsection key_generation_method_1 Key method 1
- * 
- * -# Each host generates its own random material.
- * -# Each host uses its locally generated random material as %key data
- *    for encrypting and signing packets sent to the remote peer.
- * -# Each host then sends its random material to the remote peer, so that
- *    the remote peer can use that %key data for authenticating and
- *    decrypting received packets.
- * 
- * @subsection key_generation_method_2 Key method 2
- * 
- * -# The client generates random material in the following amounts:
- *    - Pre-master secret: 48 bytes
- *    - Client's PRF seed for master secret: 32 bytes
- *    - Client's PRF seed for %key expansion: 32 bytes
- * -# The client sends its share of random material to the server.
- * -# The server generates random material in the following amounts:
- *    - Server's PRF seed for master secret: 32 bytes
- *    - Server's PRF seed for %key expansion: 32 bytes
- * -# The server computes the %key expansion using its own and the
- *    client's random material.
- * -# The server sends its share of random material to the client.
- * -# The client computes the %key expansion using its own and the
- *    server's random material.
- * 
- * %Key method 2 %key expansion is performed by the \c
- * generate_key_expansion() function.  Please refer to its source code for
- * details of the %key expansion process.
- * 
- * @subsection key_generation_random Source of random material
- * 
- * OpenVPN uses the OpenSSL library as its source of random material. More
- * specifically, the \c RAND_bytes() function is called to supply
- * cryptographically strong pseudo-random data.  The following links
- * contain more information on this subject:
- * - For OpenSSL's \c RAND_bytes() function:
- *   http://www.openssl.org/docs/crypto/RAND_bytes.html
- * - For OpenSSL's pseudo-random number generating system:
- *   http://www.openssl.org/docs/crypto/rand.html
- * - For OpenSSL's support for external crypto modules:
- *   http://www.openssl.org/docs/crypto/engine.html
- * 
- * @section key_generation_exchange Key exchange:
- * 
- * The %key exchange process is initiated by the OpenVPN process running
- * in client mode.  After the initial three-way handshake has successfully
- * completed, the client sends its share of random material to the server,
- * after which the server responds with its part.  This process is
- * depicted below:
- * 
-@...1467...
-  Client           Client                           Server          Server
-  State            Action                           Action          State
-----------  --------------------            --------------------  ----------
-
-             ... waiting until three-way handshake complete ...
-S_START                                                              S_START
-            key_method_?_write()
-            send to server  --> --> --> -->  receive from client
-S_SENT_KEY                                   key_method_?_read()
-                                                                   S_GOT_KEY
-                                            key_method_?_write()
-            receive from server  <-- <-- <-- <--  send to client
-            key_method_?_read()                                   S_SENT_KEY
-S_GOT_KEY
-          ... waiting until control channel fully synchronized ...
-S_ACTIVE                                                            S_ACTIVE
-@...1468...
- * 
- * For more information about the client and server state values, see the
- * \link control_processor Control Channel Processor module\endlink.
- * 
- * Depending on which %key method is used, the \c ? in the function names
- * of the diagram above is a \c 1 or a \c 2.  For example, if %key method
- * 2 is used, that %key exchange would be started by the client calling \c
- * key_method_2_write().  These functions are called from the \link
- * control_processor Control Channel Processor module's\endlink \c
- * tls_process() function and control the %key generation and exchange
- * process as follows:
- * - %Key method 1:
- *   - \c key_method_1_write(): generate random material locally, and load
- *     as "sending" keys.
- *   - \c key_method_1_read(): read random material received from remote
- *     peer, and load as "receiving" keys.
- * - %Key method 2:
- *   - \c key_method_2_write(): generate random material locally, and if
- *     in server mode generate %key expansion.
- *   - \c key_method_2_read(): read random material received from remote
- *     peer, and if in client mode generate %key expansion.
- * 
- * @subsection key_generation_encapsulation Transmission of key material
- * 
- * The OpenVPN client and server communicate with each other through their
- * control channel.  This means that all of the data transmitted over the
- * network, such as random material for %key generation, is encapsulated
- * in a TLS layer.  For more details, see the \link control_tls Control
- * Channel TLS module\endlink documentation.
- */
diff --git a/doc_mainpage.h b/doc_mainpage.h
deleted file mode 100644
index ade5f5b..0000000
--- a/doc_mainpage.h
+++ /dev/null
@@ -1,162 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
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
-/**
- * @file
- * Main page documentation file.
- */
-
-/**
- * @mainpage OpenVPN v2.1 source code documentation
- * 
- * This documentation describes the internal structure of OpenVPN.  It was
- * automatically generated from specially formatted comment blocks in
- * OpenVPN's source code using Doxygen.  (See
- * http://www.stack.nl/~dimitri/doxygen/ for more information on Doxygen)
- * 
- * The \ref mainpage_modules "Modules section" below gives an introduction
- * into the high-level module concepts used throughout this documentation.
- * The \ref mainpage_relatedpages "Related Pages section" below describes
- * various special subjects related to OpenVPN's implementation which are
- * discussed in the related pages section.
- * 
- * @section mainpage_modules Modules
- * 
- * For the purpose of describing the internal structure of OpenVPN, this
- * documentation and the underlying source code has been broken up into a
- * number of conceptually well-defined parts, known as modules. Each
- * module plays a specific role within the OpenVPN process, and in most
- * cases each module has a clear interfacing strategy for interacting with
- * other modules.
- * 
- * The following modules have been defined:
- * - Driver module:
- *   - The \link eventloop Main Event Loop\endlink: this module drives the
- *     event handling of OpenVPN.  It implements various types of
- *     select-loop which wait until an event happens, and then delegate
- *     the handling of that event to the appropriate module.
- * - Network interface modules:
- *   - The \link external_multiplexer External Multiplexer\endlink: this
- *     module sends and receives packets to and from remote OpenVPN peers
- *     over the external network interface.  It also takes care of
- *     demultiplexing received packets to their appropriate VPN tunnel and
- *     splitting control channel and data channel packets.
- *   - The \link internal_multiplexer Internal Multiplexer\endlink: this
- *     module sends and receives packets to and from locally reachable
- *     posts over the virtual tun/tap network interface.  It also takes
- *     care of determining through which VPN tunnel a received packet must
- *     be sent to reach its destination.
- * - Control channel modules:
- *   - The \link reliable Reliability Layer\endlink: this module offers a
- *     %reliable and sequential transport layer for control channel
- *     messages.
- *   - The \link control_tls Control Channel TLS module\endlink: this
- *     module offers a secure encapsulation of control channel messages
- *     using the TLS protocol.
- *   - The \link control_processor Control Channel Processor\endlink: his
- *     module manages the setup, maintenance, and shut down of VPN
- *     tunnels.
- * - Data channel modules:
- *   - The \link data_control Data Channel Control module\endlink: this
- *     module controls the processing of data channel packets and,
- *     depending on the settings of the packet's VPN tunnel, passes the
- *     packet to the three modules below for handling.
- *   - The \link data_crypto Data Channel Crypto module\endlink: this
- *     module performs security operations on data channel packets.
- *   - The \link fragmentation Data Channel Fragmentation module\endlink:
- *     this module offers fragmentation of data channel packets larger
- *     than the VPN tunnel's MTU.
- *   - The \link compression Data Channel Compression module\endlink: this
- *     module offers compression of data channel packets.
- * 
- * @subsection mainpage_modules_example Example event: receiving a packet
- * 
- * OpenVPN handles many types of events during operation.  These include
- * external events, such as network traffic being received, and internal
- * events, such as a %key session timing out causing renegotiation.  An
- * example event, receiving a packet over the network, is described here
- * together with which modules play what roles:
- * -# The \link eventloop Main Event Loop\endlink detects that a packet
- *    can be read from the external or the virtual tun/tap network
- *    interface.
- * -# The \link eventloop Main Event Loop\endlink calls the \link
- *    external_multiplexer External Multiplexer\endlink or \link
- *    internal_multiplexer Internal Multiplexer\endlink to read and
- *    process the packet.
- * -# The multiplexer module determines the type of packet and its
- *    destination, and passes the packet on to the appropriate handling
- *    module:
- *    - A control channel packet received by the \link
- *      external_multiplexer External Multiplexer\endlink is passed on
- *      through the \link reliable Reliability Layer\endlink and the \link
- *      control_tls Control Channel TLS module\endlink to the \link
- *      control_processor Control Channel Processor\endlink.
- *    - A data channel packet received by either multiplexer module is
- *      passed on to the \link data_control Data Channel Control
- *      module\endlink.
- * -# The packet is processed by the appropriate control channel or data
- *    channel modules.
- * -# If, after processing the packet, a resulting packet is generated
- *    that needs to be sent to a local or remote destination, it is given
- *    to the \link external_multiplexer External Multiplexer\endlink or
- *    \link internal_multiplexer Internal Multiplexer\endlink for sending.
- * -# If a packet is waiting to be sent by either multiplexer module and
- *    the \link eventloop Main Event Loop\endlink detects that data can be
- *    written to the associated network interface, it calls the
- *    multiplexer module to send the packet.
- * 
- * @section mainpage_relatedpages Related pages
- * 
- * This documentation includes a number of descriptions of various aspects
- * of OpenVPN and its implementation.  These are not directly related to
- * one module, function, or data structure, and are therefore listed
- * separately under "Related Pages".
- * 
- * @subsection mainpage_relatedpages_key_generation Data channel key generation
- * 
- * The @ref key_generation "Data channel key generation" related page
- * describes how, during VPN tunnel setup and renegotiation, OpenVPN peers
- * generate and exchange the %key material required for the symmetric
- * encryption/decryption and HMAC signing/verifying security operations
- * performed on data channel packets.
- * 
- * @subsection mainpage_relatedpages_tunnel_state VPN tunnel state
- * 
- * The @ref tunnel_state "Structure of VPN tunnel state storage" related
- * page describes how an OpenVPN process manages the state information
- * associated with its active VPN tunnels.
- * 
- * @subsection mainpage_relatedpages_network_protocol Network protocol
- * 
- * The @ref network_protocol "Network protocol" related page describes the
- * format and content of VPN tunnel packets exchanged between OpenVPN
- * peers.
- * 
- * @subsection mainpage_relatedpages_memory_management Memory management
- * 
- * The @ref memory_management "Memory management strategies" related page
- * gives a brief introduction into OpenVPN's memory %buffer library and
- * garbage collection facilities.
- */
diff --git a/doc_memory_management.h b/doc_memory_management.h
deleted file mode 100644
index 4549498..0000000
--- a/doc_memory_management.h
+++ /dev/null
@@ -1,99 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
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
-/**
- * @file
- * Memory management strategies documentation file.
- */
-
-/**
- * @page memory_management OpenVPN's memory management strategies
- * 
- * This section describes several implementation details relating to
- * OpenVPN's memory management strategies.
- * 
- * During operation, the OpenVPN process performs all kinds of operations
- * on blocks of data.  Receiving packets, encrypting content, prepending
- * headers, etc.  To make the programmer's job easier and to decrease the
- * likelihood of memory-related bugs, OpenVPN uses its own memory %buffer
- * library and garbage collection facilities.  These are described in
- * brief here.
- * 
- * @section memory_management_buffer The buffer structure
- * 
- * The \c buffer structure is a wrapper around a block of dynamically
- * allocated memory which keeps track of the block's capacity \c
- * buffer.capacity and location in memory \c buffer.data.  This structure
- * supports efficient prepending and appending within the allocated memory
- * through the use of offset \c buffer.offset and length \c buffer.len
- * fields.  See the \c buffer documentation for more details on the
- * structure itself.
- * 
- * OpenVPN's %buffer library, implemented in the \c buffer.h and \c
- * buffer.c files, contains many utility functions for working with \c
- * buffer structures.  These functions facilitate common operations, such
- * as allocating, freeing, reading and writing to \c buffer structures,
- * and even offer several more advanced operations, such as string
- * matching and creating sub-buffers.
- * 
- * Not only do these utility functions make working with \c buffer
- * structures easy, they also perform extensive error checking.  Each
- * function, where necessary, checks whether enough space is available
- * before performing its actions.  This minimizes the chance of bugs
- * leading to %buffer overflows and other vulnerabilities.
- * 
- * @section memory_management_frame The frame structure
- * 
- * The \c frame structure keeps track of the maximum allowed packet
- * geometries of a network connection.
- * 
- * It is used, for example, to determine the size of \c buffer structures
- * in which to store data channel packets.  This is done by having each
- * data channel processing module register the maximum amount of extra
- * space it will need for header prepending and content expansion in the
- * \c frame structure. Once these parameters are known, \c buffer
- * structures can be allocated, based on the \c frame parameters, so that
- * they are large enough to allow efficient prepending of headers and
- * processing of content.
- * 
- * @section memory_management_garbage Garbage collection
- * 
- * OpenVPN has many sizable functions which perform various actions
- * depending on their %context.  This makes it difficult to know in advance
- * exactly how much memory must be allocated.  The garbage collection
- * facilities are used to keep track of dynamic allocations, thereby
- * allowing easy collective freeing of the allocated memory.
- * 
- * The garbage collection system is implemented by the \c gc_arena and \c
- * gc_entry structures.  The arena represents a garbage collecting unit,
- * and contains a linked list of entries.  Each entry represents one block
- * of dynamically allocated memory.
- * 
- * The garbage collection system also contains various utility functions
- * for working with the garbage collection structures.  These include
- * functions for initializing new arenas, allocating memory of a given
- * size and registering the allocation in an arena, and freeing all the
- * allocated memory associated with an arena.
- */
diff --git a/doc_protocol_overview.h b/doc_protocol_overview.h
deleted file mode 100644
index de844e7..0000000
--- a/doc_protocol_overview.h
+++ /dev/null
@@ -1,199 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
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
-/**
- * @file Network protocol overview documentation file.
- */
-
-/**
- * @page network_protocol OpenVPN's network protocol
- * 
- * Description of packet structure in OpenVPN's network protocol.
- * 
- * This document describes the structure of packets exchanged between
- * OpenVPN peers.  It is based on the protocol description in the \c ssl.h
- * file.
- * 
- * @section network_protocol_external Outer structure of packets exchanged between OpenVPN peers
- * 
- * VPN tunnel packets are transported between OpenVPN peers using the UDP
- * or TCP protocols.  Their structure is described below.
- * 
- * @subsection network_protocol_external_structure External packet structure
- * 
- *  - packet length (16 bits, unsigned) [TCP-mode only]: always sent as
- *    plain text.  Since TCP is a stream protocol, this packet length
- *    defines the packetization of the stream.
- *  - packet opcode and key_id (8 bits) [TLS-mode only]:
- *     - package message type (high 5 bits)
- *     - key_id (low 3 bits): the key_id refers to an already negotiated
- *       TLS session.  OpenVPN seamlessly renegotiates the TLS session by
- *       using a new key_id for the new session.  Overlap (controlled by
- *       user definable parameters) between old and new TLS sessions is
- *       allowed, providing a seamless transition during tunnel operation.
- *  - payload (n bytes)
- * 
- * @subsection network_protocol_external_types Message types
- * 
- * The type of a VPN tunnel packet is indicated by its opcode.  The
- * following describes the various opcodes available.
- * 
- *  - Control channel messages:
- *     - \c P_CONTROL_HARD_RESET_CLIENT_V1 -- %Key method 1, initial %key
- *       from client, forget previous state.
- *     - \c P_CONTROL_HARD_RESET_SERVER_V1 -- %Key method 1, initial %key
- *       from server, forget previous state.
- *     - \c P_CONTROL_HARD_RESET_CLIENT_V2 -- %Key method 2, initial %key
- *       from client, forget previous state.
- *     - \c P_CONTROL_HARD_RESET_SERVER_V2 -- %Key method 2, initial %key
- *       from server, forget previous state.
- *     - \c P_CONTROL_SOFT_RESET_V1 -- New %key, with a graceful
- *       transition from old to new %key in the sense that a transition
- *       window exists where both the old or new key_id can be used.
- *     - \c P_CONTROL_V1 -- Control channel packet (usually TLS
- *       ciphertext).
- *     - \c P_ACK_V1 -- Acknowledgement for control channel packets
- *       received.
- *  - Data channel messages:
- *     - \c P_DATA_V1 -- Data channel packet containing data channel
- *       ciphertext.
- * 
- * @subsection network_protocol_external_key_id Session IDs and Key IDs
- * 
- * OpenVPN uses two different forms of packet identifiers:
- *  - The first form is 64 bits and is used for all control channel
- *    messages.  This form is referred to as a \c session_id.
- *  - Data channel messages on the other hand use a shortened form of 3
- *    bits for efficiency reasons since the vast majority of OpenVPN
- *    packets in an active tunnel will be data channel messages.  This
- *    form is referred to as a \c key_id.
- * 
- * The control and data channels use independent packet-id sequences,
- * because the data channel is an unreliable channel while the control
- * channel is a %reliable channel.  Each use their own independent HMAC
- * keys.
- * 
- * @subsection network_protocol_external_reliable Control channel reliability layer
- * 
- * Control channel messages (\c P_CONTROL_* and \c P_ACK_* message types)
- * are TLS ciphertext packets which have been encapsulated inside of a
- * reliability layer.  The reliability layer is implemented as a
- * straightforward acknowledge and retransmit model.
- * 
- * Acknowledgments of received messages can be encoded in either the
- * dedicated \c P_ACK_* record or they can be prepended to a \c
- * P_CONTROL_* message.
- * 
- * See the \link reliable Reliability Layer\endlink module for a detailed
- * description.
- * 
- * @section network_protocol_control Structure of control channel messages
- * 
- * @subsection network_protocol_control_ciphertext Structure of ciphertext control channel messages
- * 
- * Control channel packets in ciphertext form consist of the following
- * parts:
- * 
- *  - local \c session_id (random 64 bit value to identify TLS session).
- *  - HMAC signature of entire encapsulation header for HMAC firewall
- *    [only if \c --tls-auth is specified] (usually 16 or 20 bytes).
- *  - packet-id for replay protection (4 or 8 bytes, includes sequence
- *    number and optional \c time_t timestamp).
- *  - acknowledgment packet-id array length (1 byte).
- *  - acknowledgment packet-id array (if length > 0).
- *  - acknowledgment remote session-id (if length > 0).
- *  - packet-id of this message (4 bytes).
- *  - TLS payload ciphertext (n bytes) (only for \c P_CONTROL_V1).
- * 
- * Note that when \c --tls-auth is used, all message types are protected
- * with an HMAC signature, even the initial packets of the TLS handshake.
- * This makes it easy for OpenVPN to throw away bogus packets quickly,
- * without wasting resources on attempting a TLS handshake which will
- * ultimately fail.
- * 
- * @subsection network_protocol_control_key_methods Control channel key methods and
- * 
- * Once the TLS session has been initialized and authenticated, the TLS
- * channel is used to exchange random %key material for bidirectional
- * cipher and HMAC keys which will be used to secure data channel packets.
- * OpenVPN currently implements two %key methods.  %Key method 1 directly
- * derives keys using random bits obtained from the \c RAND_bytes()
- * OpenSSL function.  %Key method 2 mixes random %key material from both
- * sides of the connection using the TLS PRF mixing function.  %Key method
- * 2 is the preferred method and is the default for OpenVPN 2.0.
- * 
- * The @ref key_generation "Data channel key generation" related page
- * describes the %key methods in more detail.
- * 
- * @subsection network_protocol_control_plaintext Structure of plaintext control channel messages
- * 
- *  - %Key method 1:
- *     - Cipher %key length in bytes (1 byte).
- *     - Cipher %key (n bytes).
- *     - HMAC %key length in bytes (1 byte).
- *     - HMAC %key (n bytes).
- *     - %Options string (n bytes, null terminated, client/server %options
- *       string should match).
- *  - %Key method 2:
- *     - Literal 0 (4 bytes).
- *     - %Key method (1 byte).
- *     - \c key_source structure (\c key_source.pre_master only defined
- *       for client -> server).
- *     - %Options string length, including null (2 bytes).
- *     - %Options string (n bytes, null terminated, client/server %options
- *       string must match).
- *     - [The username/password data below is optional, record can end at
- *       this point.]
- *     - Username string length, including null (2 bytes).
- *     - Username string (n bytes, null terminated).
- *     - Password string length, including null (2 bytes).
- *     - Password string (n bytes, null terminated).
- * 
- * @section network_protocol_data Structure of data channel messages
- * 
- * @subsection network_protocol_data_ciphertext Structure of ciphertext data channel messages
- * 
- * The P_DATA_* payload represents encrypted, encapsulated tunnel packets
- * which tend to be either IP packets or Ethernet frames. This is
- * essentially the "payload" of the VPN.
- * 
- * Data channel packets in ciphertext form consist of the following parts:
- *  - HMAC of ciphertext IV + ciphertext (if not disabled by \c --auth
- *    none).
- *  - Ciphertext IV (size is cipher-dependent, if not disabled by \c
- *    --no-iv).
- *  - Tunnel packet ciphertext.
- * 
- * @subsection network_protocol_data_plaintext Structure of plaintext data channel messages
- * 
- * Data channel packets in plaintext form consist of the following parts:
- *  - packet-id (4 or 8 bytes, if not disabled by --no-replay).
- *     - In TLS mode, 4 bytes are used because the implementation can
- *       force a TLS renegotation before \c 2^32 packets are sent.
- *     - In pre-shared %key mode, 8 bytes are used (sequence number and \c
- *       time_t value) to allow long-term %key usage without packet-id
- *       collisions.
- *  - User plaintext (n bytes).
- */
diff --git a/doc_reliable.h b/doc_reliable.h
deleted file mode 100644
index 9877d8c..0000000
--- a/doc_reliable.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
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
-/**
- * @file
- * Reliability Layer module documentation file.
- */
-
-/**
- * @defgroup reliable Reliability Layer module
- * 
- * The Reliability Layer is part of OpenVPN's control channel.  It
- * provides a reliable and sequential transport mechanism for control
- * channel messages between OpenVPN peers.  This module forms the
- * interface between the \link external_multiplexer External
- * Multiplexer\endlink and the \link control_tls Control Channel TLS
- * module\endlink.
- * 
- * @par UDP or TCP as VPN tunnel transport
- * 
- * This is especially important when OpenVPN is configured to communicate
- * over UDP, because UDP does not offer a reliable and sequential
- * transport.  OpenVPN endpoints can also communicate over TCP which does
- * provide a reliable and sequential transport.  In both cases, using UDP
- * or TCP as an external transport, the internal Reliability Layer is
- * active.
- */
diff --git a/doc_tunnel_state.h b/doc_tunnel_state.h
deleted file mode 100644
index 7a24a0f..0000000
--- a/doc_tunnel_state.h
+++ /dev/null
@@ -1,155 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single TCP/UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
- *
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
-/**
- * @file
- * VPN tunnel state documentation file.
- */
-
-/**
- * @page tunnel_state Structure of the VPN tunnel state storage
- * 
- * This section describes how OpenVPN stores its VPN tunnel state during
- * operation.
- * 
- * OpenVPN uses several data structures as storage containers for state
- * information of active VPN tunnels.  These are described in this
- * section, together with a little bit of history to help understand the
- * origin of the current architecture.
- * 
- * Whether an OpenVPN process is running in client-mode or server-mode
- * determines whether it can support only one or multiple simultaneously
- * active VPN tunnels.  This consequently also determines how the
- * associated state information is wrapped up internally.  This section
- * gives an overview of the differences.
- * 
- * @section tunnel_state_history Historic developments
- * 
- * In the old v1.x series, an OpenVPN process managed only one single VPN
- * tunnel.  This allowed the VPN tunnel state to be stored together with
- * process-global information in one single \c context structure.
- * 
- * This changed, however, in the v2.x series, as new OpenVPN versions
- * running in server-mode can support multiple simultaneously active VPN
- * tunnels.  This necessitated a redesign of the VPN tunnel state
- * container structures, and modification of the \link
- * external_multiplexer External Multiplexer\endlink and \link
- * internal_multiplexer Internal Multiplexer\endlink systems.  The
- * majority of these changes are only relevant for OpenVPN processes
- * running in server-mode, and the client-mode structure has remained very
- * similar to the v1.x single-tunnel form.
- * 
- * @section tunnel_state_client Client-mode state
- * 
- * An OpenVPN process running in client-mode can manage at most one single
- * VPN tunnel at any one time.  The state information for a client's VPN
- * tunnel is stored in a \c context structure.
- * 
- * The \c context structure is created in the \c main() function.  That is
- * also where process-wide initialization takes place, such as parsing
- * command line %options and reading configuration files.  The \c context
- * is then passed to \c tunnel_point_to_point() which drives OpenVPN's
- * main event processing loop.  These functions are both part of the \link
- * eventloop Main Event Loop\endlink module.
- * 
- * @subsection tunnel_state_client_init Initialization and cleanup
- * 
- * Because there is only one \c context structure present, it can be
- * initialized and cleaned up from the client's main event processing
- * function.  Before the \c tunnel_point_to_point() function enters its
- * event loop, it calls \c init_instance_handle_signals() which calls \c
- * init_instance() to initialize the single \c context structure.  After
- * the event loop stops, it calls \c close_instance() to clean up the \c
- * context.
- * 
- * @subsection tunnel_state_client_event Event processing
- * 
- * When the main event processing loop activates the external or internal
- * multiplexer to handle a network event, it is not necessary to determine
- * which VPN tunnel the event is associated with, because there is only
- * one VPN tunnel active.
- * 
- * @section tunnel_state_server Server-mode state
- * 
- * An OpenVPN process running in server-mode can manage multiple
- * simultaneously active VPN tunnels.  For every VPN tunnel active, in
- * other words for every OpenVPN client which is connected to a server,
- * the OpenVPN server has one \c context structure in which it stores that
- * particular VPN tunnel's state information.
- * 
- * @subsection tunnel_state_server_multi Multi_context and multi_instance structures
- * 
- * To support multiple \c context structures, each is wrapped in a \c
- * multi_instance structure, and all the \c multi_instance structures are
- * registered in one single \c multi_context structure.  The \link
- * external_multiplexer External Multiplexer\endlink and \link
- * internal_multiplexer Internal Multiplexer\endlink then use the \c
- * multi_context to retrieve the correct \c multi_instance and \c context
- * associated with a given network address.
- * 
- * @subsection tunnel_state_server_init Startup and initialization
- * 
- * An OpenVPN process running in server-mode starts in the same \c main()
- * function as it would in client-mode.  The same process-wide
- * initialization is performed, and the resulting state and configuration
- * is stored in a \c context structure. The server-mode and client-mode
- * processes diverge when the \c main() function calls one of \c
- * tunnel_point_to_point() or \c tunnel_server().
- * 
- * In server-mode, \c main() calls the \c tunnel_server() function, which
- * transfers control to \c tunnel_server_udp_single_threaded() or \c
- * tunnel_server_tcp() depending on the external transport protocol.
- * 
- * These functions receive the \c context created in \c main().  This
- * object has a special status in server-mode, as it does not represent an
- * active VPN tunnel, but does contain process-wide configuration
- * parameters.  In the source code, it is often stored in "top" variables.
- * To distinguish this object from other instances of the same type, its
- * \c context.mode value is set to \c CM_TOP.  Other \c context objects,
- * which do represent active VPN tunnels, have a \c context.mode set to \c
- * CM_CHILD_UDP or \c CM_CHILD_TCP, depending on the external transport
- * protocol.
- * 
- * Both \c tunnel_server_udp_single_threaded() and \c tunnel_server_tcp()
- * perform similar initialization.  In either case, a \c multi_context
- * structure is created, and it is initialized according to the
- * configuration stored in the top \c context by the \c multi_init() and
- * \c multi_top_init() functions.
- * 
- * @subsection tunnel_state_server_tunnels Creating and destroying VPN tunnels
- * 
- * When an OpenVPN client makes a new connection to a server, the server
- * creates a new \c context and \c multi_instance.  The latter is
- * registered in the \c multi_context, which makes it possible for the
- * external and internal multiplexers to retrieve the correct \c
- * multi_instance and \c context when a network event occurs.
- * 
- * @subsection tunnel_state_server_cleanup Final cleanup
- * 
- * After the main event loop exits, both \c
- * tunnel_server_udp_single_threaded() and \c tunnel_server_tcp() perform
- * similar cleanup.  They call \c multi_uninit() followed by \c
- * multi_top_free() to clean up the \c multi_context structure.
- */
diff --git a/doxygen/doc_compression.h b/doxygen/doc_compression.h
new file mode 100644
index 0000000..0296b27
--- /dev/null
+++ b/doxygen/doc_compression.h
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
diff --git a/doxygen/doc_control_processor.h b/doxygen/doc_control_processor.h
new file mode 100644
index 0000000..506f8ab
--- /dev/null
+++ b/doxygen/doc_control_processor.h
@@ -0,0 +1,189 @@
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
+ * Control Channel Processor module documentation file.
+ */
+
+/**
+ * @defgroup control_processor Control Channel Processor module
+ * 
+ * This module controls the setup and maintenance of VPN tunnels and the
+ * associated security parameters.
+ * 
+ * @par This module's role
+ * The Control Channel Processor module lies at the core of OpenVPN's
+ * activities.  It handles the setup of new VPN tunnels, the negotiation
+ * of data channel security parameters, the managing of active VPN
+ * tunnels, and finally the cleanup of expired VPN tunnels.
+ * 
+ * @par State structures
+ * A large amount of VPN tunnel state information must be stored within an
+ * OpenVPN process.  A wide variety of container structures are used by
+ * this module for that purpose.  Several of these structures are listed
+ * below, and the function of the first three VPN tunnel state containers
+ * is described in more detail later.
+ *  - VPN tunnel state containers:
+ *     - \c tls_multi, security parameter state for a single VPN tunnel.
+ *       Contains three instances of the \c tls_session structure.
+ *     - \c tls_session, security parameter state of a single session
+ *       within a VPN tunnel.  Contains two instances of the \c key_state
+ *       structure.
+ *     - \c key_state, security parameter state of one TLS and data
+ *       channel %key set.
+ *  - Data channel security parameter containers:
+ *     - \c key_ctx_bi, container for two sets of OpenSSL cipher and/or
+ *       HMAC context (both directions).  Contains two instances of the \c
+ *       key_ctx structure.
+ *     - \c key_ctx, container for one set of OpenSSL cipher and/or HMAC
+ *       context (one directions.
+ *  - Key material containers:
+ *     - \c key2, container for two sets of cipher and/or HMAC %key
+ *       material (both directions).  Contains two instances of the \c key
+ *       structure.
+ *     - \c key, container for one set of cipher and/or HMAC %key material
+ *       (one direction).
+ *     - \c key_direction_state, ordering of %key material within the \c
+ *       key2.key array.
+ *  - Key method 2 random material containers:
+ *     - \c key_source2, container for both halves of random material used
+ *       for %key method 2.  Contains two instances of the \c key_source
+ *       structure.
+ *     - \c key_source, container for one half of random material used for
+ *       %key method 2.
+ * 
+ * @par The life of a \c tls_multi object
+ * A \c tls_multi structure contains all the security parameter state
+ * information related to the control and data channels of one VPN tunnel.
+ * Its life cycle can be summarized as follows:
+ *  -# Initialization: \c tls_multi_init() and \c
+ *     tls_multi_init_finalize(), which are called (indirectly) from \c
+ *     init_instance() when initializing a new \c context structure.
+ *     - Initializes a \c tls_multi structure.
+ *     - Allocates the three \c tls_session objects contained by the \c
+ *       tls_multi structure, and initializes as appropriate.
+ *  -# Management: \c tls_multi_process() and \c tls_pre_decrypt()
+ *     - If a new session is initiated by the remote peer, then \c
+ *       tls_pre_decrypt() starts the new session negotiation in the
+ *       un-trusted \c tls_session.
+ *     - If the, as yet, un-trusted \c tls_session authenticates
+ *       successfully, then \c tls_multi_process() moves it so as to be
+ *       the active \c tls_session.
+ *     - If an error occurs during processing of a \c key_state object,
+ *       then \c tls_multi_process() cleans up and initializes the
+ *       associated \c tls_session object.  If the error occurred in the
+ *       active \c key_state of the active \c tls_session and the
+ *       lame-duck \c key_state of that \c tls_session has not yet
+ *       expired, it is preserved as fallback.
+ *  -# Cleanup: \c tls_multi_free(), which is called (indirectly) from \c
+ *     close_instance() when cleaning up a \c context structure.
+ *     - Cleans up a \c tls_multi structure.
+ *     - Cleans up the three \c tls_session objects contained by the \c
+ *       tls_multi structure.
+ * 
+ * @par The life of a \c tls_session object
+ * A \c tls_session structure contains the state information related to an
+ * active and a lame-duck \c key_state.  Its life cycle can be summarized
+ * as follows:
+ *  -# Initialization: \c tls_session_init()
+ *     - Initializes a \c tls_session structure.
+ *     - Initializes the primary \c key_state by calling \c
+ *       key_state_init().
+ *  -# Renegotiation: \c key_state_soft_reset()
+ *     - Cleans up the old lame-duck \c key_state by calling \c
+ *       key_state_free().
+ *     - Moves the old primary \c key_state to be the new lame-duck \c
+ *       key_state.
+ *     - Initializes a new primary \c key_state by calling \c
+ *       key_state_init().
+ *  -# Cleanup: \c tls_session_free()
+ *     - Cleans up a \c tls_session structure.
+ *     - Cleans up all \c key_state objects associated with the session by
+ *       calling \c key_state_free() for each.
+ * 
+ * @par The life of a \c key_state object
+ * A \c key_state structure represents one control and data channel %key
+ * set.  It contains an OpenSSL TLS object that encapsulates the control
+ * channel, and the data channel security parameters needed by the \link
+ * data_crypto Data Channel Crypto module\endlink to perform cryptographic
+ * operations on data channel packets.  Its life cycle can be summarized
+ * as follows:
+ *  -# Initialization: \c key_state_init()
+ *     - Initializes a \c key_state structure.
+ *     - Creates a new OpenSSL TLS object to encapsulate this new control
+ *       channel session.
+ *     - Sets \c key_state.state to \c S_INITIAL.
+ *     - Allocates several internal buffers.
+ *     - Initializes new reliability layer structures for this key set.
+ *  -# Negotiation: \c tls_process()
+ *     - The OpenSSL TLS object negotiates a TLS session between itself
+ *       and the remote peer's TLS object.
+ *     - Key material is generated and exchanged through the TLS session
+ *       between OpenVPN peers.
+ *     - Both peers initialize their data channel cipher and HMAC key
+ *       contexts.
+ *     - On successful negotiation, the \c key_state.state will progress
+ *       from \c S_INITIAL to \c S_ACTIVE and \c S_NORMAL.
+ *  -# Active tunneling: \link data_crypto Data Channel Crypto
+ *     module\endlink
+ *     - Data channel packet to be sent to a remote OpenVPN peer:
+ *        - \c tls_pre_encrypt() loads the security parameters from the \c
+ *          key_state into a \c crypto_options structure.
+ *        - \c openvpn_encrypt() uses the \c crypto_options to an encrypt
+ *          and HMAC sign the data channel packet.
+ *     - Data channel packet received from a remote OpenVPN peer:
+ *        - \c tls_pre_decrypt() loads the security parameters from the \c
+ *          key_state into a \c crypto_options structure.
+ *        - \c openvpn_encrypt() uses the \c crypto_options to
+ *          authenticate and decrypt the data channel packet.
+ *  -# Cleanup: \c key_state_free()
+ *     - Cleans up a \c key_state structure together with its OpenSSL TLS
+ *       object, key material, internal buffers, and reliability layer
+ *       structures.
+ * 
+ * @par Control functions
+ * The following two functions drive the Control Channel Processor's
+ * activities.
+ *  - \c tls_multi_process(), iterates through the \c tls_session objects
+ *    within a given \c tls_multi of a VPN tunnel, and calls \c
+ *    tls_process() for each \c tls_session which is being set up, is
+ *    already active, or is busy expiring.
+ *  - \c tls_process(), performs the Control Channel Processor module's
+ *    core handling of received control channel messages, and generates
+ *    appropriate messages to be sent.
+ * 
+ * @par Functions which control data channel key generation
+ *  - Key method 1 key exchange functions:
+ *     - \c key_method_1_write(), generates and processes key material to
+ *       be sent to the remote OpenVPN peer.
+ *     - \c key_method_1_read(), processes key material received from the
+ *       remote OpenVPN peer.
+ *  - Key method 2 key exchange functions:
+ *     - \c key_method_2_write(), generates and processes key material to
+ *       be sent to the remote OpenVPN peer.
+ *     - \c key_method_2_read(), processes key material received from the
+ *       remote OpenVPN peer.
+ */
diff --git a/doxygen/doc_control_tls.h b/doxygen/doc_control_tls.h
new file mode 100644
index 0000000..dd3a41c
--- /dev/null
+++ b/doxygen/doc_control_tls.h
@@ -0,0 +1,105 @@
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
+ * Control Channel TLS module documentation file.
+ */
+
+/**
+ * @defgroup control_tls Control Channel TLS module
+ * 
+ * This module provides secure encapsulation of control channel messages
+ * exchanged between OpenVPN peers.
+ * 
+ * The Control Channel TLS module uses the Transport Layer Security (TLS)
+ * protocol to provide an encrypted communication channel between the
+ * local OpenVPN process and a remote peer.  This protocol simultaneously
+ * offers certificate-based authentication of the communicating parties.
+ * 
+ * @par This module's roles
+ * The Control Channel TLS module is essential for the security of any
+ * OpenVPN-based system.  On the one hand, it performs the security
+ * operations necessary to protect control channel messages exchanged
+ * between OpenVPN peers.  On the other hand, before the control and data
+ * channels are even setup, it controls the exchange of certificates and
+ * verification of the remote's identity during negotiation of VPN
+ * tunnels.
+ * 
+ * @par
+ * The former role is described below.  The latter is described in the
+ * documentation for the \c verify_callback() function.
+ * 
+ * @par
+ * In other words, this module takes care of the confidentiality and
+ * integrity of data channel communications, and the authentication of
+ * both the communicating parties and the control channel messages
+ * exchanged.
+ * 
+ * @par Initialization and cleanup
+ * Because of the one-to-one relationship between control channel TLS
+ * state and \c key_state structures, the initialization and cleanup of an
+ * instance of the Control Channel TLS module's state happens within the
+ * \c key_state_init() and \c key_state_free() functions.  In other words,
+ * each \c key_state object contains exactly one OpenSSL SSL-BIO object,
+ * which is initialized and cleaned up together with the rest of the \c
+ * key_state object.
+ * 
+ * @par Packet processing functions
+ * This object behaves somewhat like a black box with a ciphertext and a
+ * plaintext I/O port. Its interaction with OpenVPN's control channel
+ * during operation takes place within the \c tls_process() function of
+ * the \link control_processor Control Channel Processor\endlink.  The
+ * following functions are available for processing packets:
+ * - If ciphertext received from the remote peer is available in the \link
+ *   reliable Reliability Layer\endlink:
+ *   - Insert it into the ciphertext-side of the SSL-BIO.
+ *   - Use function: \c key_state_write_ciphertext()
+ * - If ciphertext can be extracted from the ciphertext-side of the
+ *   SSL-BIO:
+ *   - Pass it to the \link reliable Reliability Layer\endlink for sending
+ *     to the remote peer.
+ *   - Use function: \c key_state_read_ciphertext()
+ * - If plaintext can be extracted from the plaintext-side of the SSL-BIO:
+ *   - Pass it on to the \link control_processor Control Channel
+ *     Processor\endlink for local processing.
+ *   - Use function: \c key_state_read_plaintext()
+ * - If plaintext from the \link control_processor Control Channel
+ *   Processor\endlink is available to be sent to the remote peer:
+ *   - Insert it into the plaintext-side of the SSL-BIO.
+ *   - Use function: \c key_state_write_plaintext() or \c
+ *     key_state_write_plaintext_const()
+ * 
+ * @par Transport Layer Security protocol implementation
+ * This module uses the OpenSSL library's implementation of the TLS
+ * protocol in the form of an OpenSSL SSL-BIO object.
+ * 
+ * @par
+ * For more information on the OpenSSL library's BIO objects, please see:
+ *  - OpenSSL's generic BIO objects:
+ *    http://www.openssl.org/docs/crypto/bio.html
+ *  - OpenSSL's SSL-BIO object:
+ *    http://www.openssl.org/docs/crypto/BIO_f_ssl.html
+ */
diff --git a/doxygen/doc_data_control.h b/doxygen/doc_data_control.h
new file mode 100644
index 0000000..cebe28e
--- /dev/null
+++ b/doxygen/doc_data_control.h
@@ -0,0 +1,103 @@
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
+ * Data Channel Control module documentation file.
+ */
+
+/**
+ * @defgroup data_control Data Channel Control module
+ * 
+ * This module controls the processing of packets as they pass through the
+ * data channel.
+ * 
+ * The Data Channel Control module controls the processing of packets as
+ * they pass through the data channel.  The processing includes packet
+ * compression, fragmentation, and the performing of security operations
+ * on the packets.  This module does not do the processing itself, but
+ * passes the packet to other data channel modules to perform the
+ * appropriate actions.
+ * 
+ * Packets can travel in two directions through the data channel.  They
+ * can be going to a remote destination which is reachable through a VPN
+ * tunnel, in which case this module prepares them to be sent out through
+ * a VPN tunnel.  On the other hand, they can have been received through a
+ * VPN tunnel from a remote OpenVPN peer, in which case this module
+ * retrieves the packet in its original form as it was before entering the
+ * VPN tunnel on the remote OpenVPN peer.  How this module processes
+ * packets traveling in the two directions is discussed in more detail
+ * below.
+ * 
+ * @par Packets to be sent to a remote OpenVPN peer
+ * This module's main function for processing packets traveling in this
+ * direction is \c encrypt_sign(), which performs the following processing
+ * steps:
+ * - Call the \link compression Data Channel Compression module\endlink to
+ *   perform packet compression if necessary.
+ * - Call the \link fragmentation Data Channel Fragmentation
+ *   module\endlink to perform packet fragmentation if necessary.
+ * - Call the \link data_crypto Data Channel Crypto module\endlink to
+ *   perform the required security operations.
+ * 
+ * @par
+ * See the \c encrypt_sign() documentation for details of these
+ * interactions.
+ * 
+ * @par
+ * After the above processing is complete, the packet is ready to be sent
+ * to a remote OpenVPN peer as a VPN tunnel packet.  The actual sending of
+ * the packet is handled by the \link external_multiplexer External
+ * Multiplexer\endlink.
+ * 
+ * @par Packets received from a remote OpenVPN peer
+ * The function that controls how packets traveling in this direction are
+ * processed is \c process_incoming_link().  That function, however, also
+ * performs some of the tasks required for the \link external_multiplexer
+ * External Multiplexer\endlink and is therefore listed as part of that
+ * module, instead of here.
+ * 
+ * @par
+ * After the \c process_incoming_link() function has determined that a
+ * received packet is a data channel packet, it performs the following
+ * processing steps:
+ * - Call the \link data_crypto Data Channel Crypto module\endlink to
+ *   perform the required security operations.
+ * - Call the \link fragmentation Data Channel Fragmentation
+ *   module\endlink to perform packet reassembly if necessary.
+ * - Call the \link compression Data Channel Compression module\endlink to
+ *   perform packet decompression if necessary.
+ * 
+ * @par
+ * See the \c process_incoming_link() documentation for details of these
+ * interactions.
+ * 
+ * @par
+ * After the above processing is complete, the packet is in its original
+ * form again as it was received by the remote OpenVPN peer.  It can now
+ * be routed further to its final destination.  If that destination is a
+ * locally reachable host, then the \link internal_multiplexer Internal
+ * Multiplexer\endlink will send it there.
+ */
diff --git a/doxygen/doc_data_crypto.h b/doxygen/doc_data_crypto.h
new file mode 100644
index 0000000..1e281e9
--- /dev/null
+++ b/doxygen/doc_data_crypto.h
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
diff --git a/doxygen/doc_eventloop.h b/doxygen/doc_eventloop.h
new file mode 100644
index 0000000..f7e46cc
--- /dev/null
+++ b/doxygen/doc_eventloop.h
@@ -0,0 +1,67 @@
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
+ * Main Event Loop module documentation file.
+ */
+
+/**
+ * @defgroup eventloop Main Event Loop module
+ * 
+ * This main event loop module drives the packet processing of OpenVPN.
+ * 
+ * OpenVPN is an event driven system.  Its activities are driven by a main
+ * event loop, which repeatedly waits for one of several predefined events
+ * to occur, and then calls the appropriate module to handle the event.
+ * The major types of network events that OpenVPN processes are:
+ * - A packet can be read from the external network interface.
+ *   - The main event loop activates the \link external_multiplexer
+ *     External Multiplexer\endlink to read and process the packet.
+ * - A packet can be read from the virtual tun/tap network interface.
+ *   - The main event loop activates the \link internal_multiplexer
+ *     Internal Multiplexer\endlink to read and process the packet.
+ * - If a packet is ready to be sent out as a VPN tunnel packet: the
+ *   external network interface can be written to.
+ *   - The main event loop activates the \link external_multiplexer
+ *     External Multiplexer\endlink to send the packet.
+ * - If a packet is ready to be sent to a locally reachable destination:
+ *   the virtual tun/tap network interface can be written to.
+ *   - The main event loop activates the \link internal_multiplexer
+ *     Internal Multiplexer\endlink to send the packet.
+ * 
+ * Beside these external events, OpenVPN also processes other types of
+ * internal events.  These include scheduled events, such as resending of
+ * non-acknowledged control channel messages.
+ * 
+ * @par Main event loop implementations
+ * 
+ * Depending on the mode in which OpenVPN is running, a different main
+ * event loop function is called to drive the event processing.  The
+ * following implementations are available:
+ * - Client mode using UDP or TCP: \c tunnel_point_to_point()
+ * - Server mode using UDP: \c tunnel_server_udp_single_threaded()
+ * - Server mode using TCP: \c tunnel_server_tcp()
+ */
diff --git a/doxygen/doc_external_multiplexer.h b/doxygen/doc_external_multiplexer.h
new file mode 100644
index 0000000..f78f648
--- /dev/null
+++ b/doxygen/doc_external_multiplexer.h
@@ -0,0 +1,46 @@
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
+ * External Multiplexer module documentation file.
+ */
+
+/**
+ * @addtogroup external_multiplexer External Multiplexer module
+ * 
+ * The External Multiplexer is the link between the external network
+ * interface and the other OpenVPN modules.  It reads packets from the
+ * external network interface, determines which remote OpenVPN peer and
+ * VPN tunnel they are associated with, and whether they are data channel
+ * or control channel packets.  It then passes the packets on to the
+ * appropriate processing module.
+ * 
+ * This module also handles packets traveling in the reverse direction,
+ * which have been generated by the local control channel or which have
+ * already been processed by the \link data_control Data Channel Control
+ * module\endlink and are destined for a remote host reachable through a
+ * VPN tunnel.
+ */
diff --git a/doxygen/doc_fragmentation.h b/doxygen/doc_fragmentation.h
new file mode 100644
index 0000000..e7e9c1e
--- /dev/null
+++ b/doxygen/doc_fragmentation.h
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
diff --git a/doxygen/doc_internal_multiplexer.h b/doxygen/doc_internal_multiplexer.h
new file mode 100644
index 0000000..cdaf4a2
--- /dev/null
+++ b/doxygen/doc_internal_multiplexer.h
@@ -0,0 +1,44 @@
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
+ * Internal Multiplexer module documentation file.
+ */
+
+/**
+ * @addtogroup internal_multiplexer Internal Multiplexer module
+ * 
+ * The Internal Multiplexer is the link between the virtual tun/tap
+ * network interface and the \link data_control Data Channel Control
+ * module\endlink.  It reads packets from the virtual network interface,
+ * determines for which remote OpenVPN peer they are destined, and then
+ * passes the packets on to the Data Channel Control module together with
+ * information about their destination VPN tunnel instance.
+ * 
+ * This module also handles packets traveling in the reverse direction,
+ * which have already been processed by the Data Channel Control module
+ * and are destined for a locally reachable host.
+ */
diff --git a/doxygen/doc_key_generation.h b/doxygen/doc_key_generation.h
new file mode 100644
index 0000000..cc8d677
--- /dev/null
+++ b/doxygen/doc_key_generation.h
@@ -0,0 +1,148 @@
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
+ * Key generation documentation file.
+ */
+
+/**
+ * @page key_generation Data channel %key generation
+ * 
+ * This section describes how OpenVPN peers generate and exchange %key
+ * material necessary for the security operations performed on data
+ * channel packets.
+ * 
+ * The %key generation and exchange process between OpenVPN client and
+ * server occurs every time data channel security parameters are
+ * negotiated, for example during the initial setup of a VPN tunnel or
+ * when the active security parameters expire.  In source code terms, this
+ * is when a new key_state structure is initialized.
+ * 
+ * @section key_generation_method Key methods
+ * 
+ * OpenVPN supports two different ways of generating and exchanging %key
+ * material between client and server.  These are known as %key method 1
+ * and %key method 2.  %Key method 2 is the recommended method. Both are
+ * explained below.
+ * 
+ * @subsection key_generation_method_1 Key method 1
+ * 
+ * -# Each host generates its own random material.
+ * -# Each host uses its locally generated random material as %key data
+ *    for encrypting and signing packets sent to the remote peer.
+ * -# Each host then sends its random material to the remote peer, so that
+ *    the remote peer can use that %key data for authenticating and
+ *    decrypting received packets.
+ * 
+ * @subsection key_generation_method_2 Key method 2
+ * 
+ * -# The client generates random material in the following amounts:
+ *    - Pre-master secret: 48 bytes
+ *    - Client's PRF seed for master secret: 32 bytes
+ *    - Client's PRF seed for %key expansion: 32 bytes
+ * -# The client sends its share of random material to the server.
+ * -# The server generates random material in the following amounts:
+ *    - Server's PRF seed for master secret: 32 bytes
+ *    - Server's PRF seed for %key expansion: 32 bytes
+ * -# The server computes the %key expansion using its own and the
+ *    client's random material.
+ * -# The server sends its share of random material to the client.
+ * -# The client computes the %key expansion using its own and the
+ *    server's random material.
+ * 
+ * %Key method 2 %key expansion is performed by the \c
+ * generate_key_expansion() function.  Please refer to its source code for
+ * details of the %key expansion process.
+ * 
+ * @subsection key_generation_random Source of random material
+ * 
+ * OpenVPN uses the OpenSSL library as its source of random material. More
+ * specifically, the \c RAND_bytes() function is called to supply
+ * cryptographically strong pseudo-random data.  The following links
+ * contain more information on this subject:
+ * - For OpenSSL's \c RAND_bytes() function:
+ *   http://www.openssl.org/docs/crypto/RAND_bytes.html
+ * - For OpenSSL's pseudo-random number generating system:
+ *   http://www.openssl.org/docs/crypto/rand.html
+ * - For OpenSSL's support for external crypto modules:
+ *   http://www.openssl.org/docs/crypto/engine.html
+ * 
+ * @section key_generation_exchange Key exchange:
+ * 
+ * The %key exchange process is initiated by the OpenVPN process running
+ * in client mode.  After the initial three-way handshake has successfully
+ * completed, the client sends its share of random material to the server,
+ * after which the server responds with its part.  This process is
+ * depicted below:
+ * 
+@verbatim
+  Client           Client                           Server          Server
+  State            Action                           Action          State
+----------  --------------------            --------------------  ----------
+
+             ... waiting until three-way handshake complete ...
+S_START                                                              S_START
+            key_method_?_write()
+            send to server  --> --> --> -->  receive from client
+S_SENT_KEY                                   key_method_?_read()
+                                                                   S_GOT_KEY
+                                            key_method_?_write()
+            receive from server  <-- <-- <-- <--  send to client
+            key_method_?_read()                                   S_SENT_KEY
+S_GOT_KEY
+          ... waiting until control channel fully synchronized ...
+S_ACTIVE                                                            S_ACTIVE
+@endverbatim
+ * 
+ * For more information about the client and server state values, see the
+ * \link control_processor Control Channel Processor module\endlink.
+ * 
+ * Depending on which %key method is used, the \c ? in the function names
+ * of the diagram above is a \c 1 or a \c 2.  For example, if %key method
+ * 2 is used, that %key exchange would be started by the client calling \c
+ * key_method_2_write().  These functions are called from the \link
+ * control_processor Control Channel Processor module's\endlink \c
+ * tls_process() function and control the %key generation and exchange
+ * process as follows:
+ * - %Key method 1:
+ *   - \c key_method_1_write(): generate random material locally, and load
+ *     as "sending" keys.
+ *   - \c key_method_1_read(): read random material received from remote
+ *     peer, and load as "receiving" keys.
+ * - %Key method 2:
+ *   - \c key_method_2_write(): generate random material locally, and if
+ *     in server mode generate %key expansion.
+ *   - \c key_method_2_read(): read random material received from remote
+ *     peer, and if in client mode generate %key expansion.
+ * 
+ * @subsection key_generation_encapsulation Transmission of key material
+ * 
+ * The OpenVPN client and server communicate with each other through their
+ * control channel.  This means that all of the data transmitted over the
+ * network, such as random material for %key generation, is encapsulated
+ * in a TLS layer.  For more details, see the \link control_tls Control
+ * Channel TLS module\endlink documentation.
+ */
diff --git a/doxygen/doc_mainpage.h b/doxygen/doc_mainpage.h
new file mode 100644
index 0000000..ade5f5b
--- /dev/null
+++ b/doxygen/doc_mainpage.h
@@ -0,0 +1,162 @@
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
+ * Main page documentation file.
+ */
+
+/**
+ * @mainpage OpenVPN v2.1 source code documentation
+ * 
+ * This documentation describes the internal structure of OpenVPN.  It was
+ * automatically generated from specially formatted comment blocks in
+ * OpenVPN's source code using Doxygen.  (See
+ * http://www.stack.nl/~dimitri/doxygen/ for more information on Doxygen)
+ * 
+ * The \ref mainpage_modules "Modules section" below gives an introduction
+ * into the high-level module concepts used throughout this documentation.
+ * The \ref mainpage_relatedpages "Related Pages section" below describes
+ * various special subjects related to OpenVPN's implementation which are
+ * discussed in the related pages section.
+ * 
+ * @section mainpage_modules Modules
+ * 
+ * For the purpose of describing the internal structure of OpenVPN, this
+ * documentation and the underlying source code has been broken up into a
+ * number of conceptually well-defined parts, known as modules. Each
+ * module plays a specific role within the OpenVPN process, and in most
+ * cases each module has a clear interfacing strategy for interacting with
+ * other modules.
+ * 
+ * The following modules have been defined:
+ * - Driver module:
+ *   - The \link eventloop Main Event Loop\endlink: this module drives the
+ *     event handling of OpenVPN.  It implements various types of
+ *     select-loop which wait until an event happens, and then delegate
+ *     the handling of that event to the appropriate module.
+ * - Network interface modules:
+ *   - The \link external_multiplexer External Multiplexer\endlink: this
+ *     module sends and receives packets to and from remote OpenVPN peers
+ *     over the external network interface.  It also takes care of
+ *     demultiplexing received packets to their appropriate VPN tunnel and
+ *     splitting control channel and data channel packets.
+ *   - The \link internal_multiplexer Internal Multiplexer\endlink: this
+ *     module sends and receives packets to and from locally reachable
+ *     posts over the virtual tun/tap network interface.  It also takes
+ *     care of determining through which VPN tunnel a received packet must
+ *     be sent to reach its destination.
+ * - Control channel modules:
+ *   - The \link reliable Reliability Layer\endlink: this module offers a
+ *     %reliable and sequential transport layer for control channel
+ *     messages.
+ *   - The \link control_tls Control Channel TLS module\endlink: this
+ *     module offers a secure encapsulation of control channel messages
+ *     using the TLS protocol.
+ *   - The \link control_processor Control Channel Processor\endlink: his
+ *     module manages the setup, maintenance, and shut down of VPN
+ *     tunnels.
+ * - Data channel modules:
+ *   - The \link data_control Data Channel Control module\endlink: this
+ *     module controls the processing of data channel packets and,
+ *     depending on the settings of the packet's VPN tunnel, passes the
+ *     packet to the three modules below for handling.
+ *   - The \link data_crypto Data Channel Crypto module\endlink: this
+ *     module performs security operations on data channel packets.
+ *   - The \link fragmentation Data Channel Fragmentation module\endlink:
+ *     this module offers fragmentation of data channel packets larger
+ *     than the VPN tunnel's MTU.
+ *   - The \link compression Data Channel Compression module\endlink: this
+ *     module offers compression of data channel packets.
+ * 
+ * @subsection mainpage_modules_example Example event: receiving a packet
+ * 
+ * OpenVPN handles many types of events during operation.  These include
+ * external events, such as network traffic being received, and internal
+ * events, such as a %key session timing out causing renegotiation.  An
+ * example event, receiving a packet over the network, is described here
+ * together with which modules play what roles:
+ * -# The \link eventloop Main Event Loop\endlink detects that a packet
+ *    can be read from the external or the virtual tun/tap network
+ *    interface.
+ * -# The \link eventloop Main Event Loop\endlink calls the \link
+ *    external_multiplexer External Multiplexer\endlink or \link
+ *    internal_multiplexer Internal Multiplexer\endlink to read and
+ *    process the packet.
+ * -# The multiplexer module determines the type of packet and its
+ *    destination, and passes the packet on to the appropriate handling
+ *    module:
+ *    - A control channel packet received by the \link
+ *      external_multiplexer External Multiplexer\endlink is passed on
+ *      through the \link reliable Reliability Layer\endlink and the \link
+ *      control_tls Control Channel TLS module\endlink to the \link
+ *      control_processor Control Channel Processor\endlink.
+ *    - A data channel packet received by either multiplexer module is
+ *      passed on to the \link data_control Data Channel Control
+ *      module\endlink.
+ * -# The packet is processed by the appropriate control channel or data
+ *    channel modules.
+ * -# If, after processing the packet, a resulting packet is generated
+ *    that needs to be sent to a local or remote destination, it is given
+ *    to the \link external_multiplexer External Multiplexer\endlink or
+ *    \link internal_multiplexer Internal Multiplexer\endlink for sending.
+ * -# If a packet is waiting to be sent by either multiplexer module and
+ *    the \link eventloop Main Event Loop\endlink detects that data can be
+ *    written to the associated network interface, it calls the
+ *    multiplexer module to send the packet.
+ * 
+ * @section mainpage_relatedpages Related pages
+ * 
+ * This documentation includes a number of descriptions of various aspects
+ * of OpenVPN and its implementation.  These are not directly related to
+ * one module, function, or data structure, and are therefore listed
+ * separately under "Related Pages".
+ * 
+ * @subsection mainpage_relatedpages_key_generation Data channel key generation
+ * 
+ * The @ref key_generation "Data channel key generation" related page
+ * describes how, during VPN tunnel setup and renegotiation, OpenVPN peers
+ * generate and exchange the %key material required for the symmetric
+ * encryption/decryption and HMAC signing/verifying security operations
+ * performed on data channel packets.
+ * 
+ * @subsection mainpage_relatedpages_tunnel_state VPN tunnel state
+ * 
+ * The @ref tunnel_state "Structure of VPN tunnel state storage" related
+ * page describes how an OpenVPN process manages the state information
+ * associated with its active VPN tunnels.
+ * 
+ * @subsection mainpage_relatedpages_network_protocol Network protocol
+ * 
+ * The @ref network_protocol "Network protocol" related page describes the
+ * format and content of VPN tunnel packets exchanged between OpenVPN
+ * peers.
+ * 
+ * @subsection mainpage_relatedpages_memory_management Memory management
+ * 
+ * The @ref memory_management "Memory management strategies" related page
+ * gives a brief introduction into OpenVPN's memory %buffer library and
+ * garbage collection facilities.
+ */
diff --git a/doxygen/doc_memory_management.h b/doxygen/doc_memory_management.h
new file mode 100644
index 0000000..4549498
--- /dev/null
+++ b/doxygen/doc_memory_management.h
@@ -0,0 +1,99 @@
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
+ * Memory management strategies documentation file.
+ */
+
+/**
+ * @page memory_management OpenVPN's memory management strategies
+ * 
+ * This section describes several implementation details relating to
+ * OpenVPN's memory management strategies.
+ * 
+ * During operation, the OpenVPN process performs all kinds of operations
+ * on blocks of data.  Receiving packets, encrypting content, prepending
+ * headers, etc.  To make the programmer's job easier and to decrease the
+ * likelihood of memory-related bugs, OpenVPN uses its own memory %buffer
+ * library and garbage collection facilities.  These are described in
+ * brief here.
+ * 
+ * @section memory_management_buffer The buffer structure
+ * 
+ * The \c buffer structure is a wrapper around a block of dynamically
+ * allocated memory which keeps track of the block's capacity \c
+ * buffer.capacity and location in memory \c buffer.data.  This structure
+ * supports efficient prepending and appending within the allocated memory
+ * through the use of offset \c buffer.offset and length \c buffer.len
+ * fields.  See the \c buffer documentation for more details on the
+ * structure itself.
+ * 
+ * OpenVPN's %buffer library, implemented in the \c buffer.h and \c
+ * buffer.c files, contains many utility functions for working with \c
+ * buffer structures.  These functions facilitate common operations, such
+ * as allocating, freeing, reading and writing to \c buffer structures,
+ * and even offer several more advanced operations, such as string
+ * matching and creating sub-buffers.
+ * 
+ * Not only do these utility functions make working with \c buffer
+ * structures easy, they also perform extensive error checking.  Each
+ * function, where necessary, checks whether enough space is available
+ * before performing its actions.  This minimizes the chance of bugs
+ * leading to %buffer overflows and other vulnerabilities.
+ * 
+ * @section memory_management_frame The frame structure
+ * 
+ * The \c frame structure keeps track of the maximum allowed packet
+ * geometries of a network connection.
+ * 
+ * It is used, for example, to determine the size of \c buffer structures
+ * in which to store data channel packets.  This is done by having each
+ * data channel processing module register the maximum amount of extra
+ * space it will need for header prepending and content expansion in the
+ * \c frame structure. Once these parameters are known, \c buffer
+ * structures can be allocated, based on the \c frame parameters, so that
+ * they are large enough to allow efficient prepending of headers and
+ * processing of content.
+ * 
+ * @section memory_management_garbage Garbage collection
+ * 
+ * OpenVPN has many sizable functions which perform various actions
+ * depending on their %context.  This makes it difficult to know in advance
+ * exactly how much memory must be allocated.  The garbage collection
+ * facilities are used to keep track of dynamic allocations, thereby
+ * allowing easy collective freeing of the allocated memory.
+ * 
+ * The garbage collection system is implemented by the \c gc_arena and \c
+ * gc_entry structures.  The arena represents a garbage collecting unit,
+ * and contains a linked list of entries.  Each entry represents one block
+ * of dynamically allocated memory.
+ * 
+ * The garbage collection system also contains various utility functions
+ * for working with the garbage collection structures.  These include
+ * functions for initializing new arenas, allocating memory of a given
+ * size and registering the allocation in an arena, and freeing all the
+ * allocated memory associated with an arena.
+ */
diff --git a/doxygen/doc_protocol_overview.h b/doxygen/doc_protocol_overview.h
new file mode 100644
index 0000000..de844e7
--- /dev/null
+++ b/doxygen/doc_protocol_overview.h
@@ -0,0 +1,199 @@
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
+ * @file Network protocol overview documentation file.
+ */
+
+/**
+ * @page network_protocol OpenVPN's network protocol
+ * 
+ * Description of packet structure in OpenVPN's network protocol.
+ * 
+ * This document describes the structure of packets exchanged between
+ * OpenVPN peers.  It is based on the protocol description in the \c ssl.h
+ * file.
+ * 
+ * @section network_protocol_external Outer structure of packets exchanged between OpenVPN peers
+ * 
+ * VPN tunnel packets are transported between OpenVPN peers using the UDP
+ * or TCP protocols.  Their structure is described below.
+ * 
+ * @subsection network_protocol_external_structure External packet structure
+ * 
+ *  - packet length (16 bits, unsigned) [TCP-mode only]: always sent as
+ *    plain text.  Since TCP is a stream protocol, this packet length
+ *    defines the packetization of the stream.
+ *  - packet opcode and key_id (8 bits) [TLS-mode only]:
+ *     - package message type (high 5 bits)
+ *     - key_id (low 3 bits): the key_id refers to an already negotiated
+ *       TLS session.  OpenVPN seamlessly renegotiates the TLS session by
+ *       using a new key_id for the new session.  Overlap (controlled by
+ *       user definable parameters) between old and new TLS sessions is
+ *       allowed, providing a seamless transition during tunnel operation.
+ *  - payload (n bytes)
+ * 
+ * @subsection network_protocol_external_types Message types
+ * 
+ * The type of a VPN tunnel packet is indicated by its opcode.  The
+ * following describes the various opcodes available.
+ * 
+ *  - Control channel messages:
+ *     - \c P_CONTROL_HARD_RESET_CLIENT_V1 -- %Key method 1, initial %key
+ *       from client, forget previous state.
+ *     - \c P_CONTROL_HARD_RESET_SERVER_V1 -- %Key method 1, initial %key
+ *       from server, forget previous state.
+ *     - \c P_CONTROL_HARD_RESET_CLIENT_V2 -- %Key method 2, initial %key
+ *       from client, forget previous state.
+ *     - \c P_CONTROL_HARD_RESET_SERVER_V2 -- %Key method 2, initial %key
+ *       from server, forget previous state.
+ *     - \c P_CONTROL_SOFT_RESET_V1 -- New %key, with a graceful
+ *       transition from old to new %key in the sense that a transition
+ *       window exists where both the old or new key_id can be used.
+ *     - \c P_CONTROL_V1 -- Control channel packet (usually TLS
+ *       ciphertext).
+ *     - \c P_ACK_V1 -- Acknowledgement for control channel packets
+ *       received.
+ *  - Data channel messages:
+ *     - \c P_DATA_V1 -- Data channel packet containing data channel
+ *       ciphertext.
+ * 
+ * @subsection network_protocol_external_key_id Session IDs and Key IDs
+ * 
+ * OpenVPN uses two different forms of packet identifiers:
+ *  - The first form is 64 bits and is used for all control channel
+ *    messages.  This form is referred to as a \c session_id.
+ *  - Data channel messages on the other hand use a shortened form of 3
+ *    bits for efficiency reasons since the vast majority of OpenVPN
+ *    packets in an active tunnel will be data channel messages.  This
+ *    form is referred to as a \c key_id.
+ * 
+ * The control and data channels use independent packet-id sequences,
+ * because the data channel is an unreliable channel while the control
+ * channel is a %reliable channel.  Each use their own independent HMAC
+ * keys.
+ * 
+ * @subsection network_protocol_external_reliable Control channel reliability layer
+ * 
+ * Control channel messages (\c P_CONTROL_* and \c P_ACK_* message types)
+ * are TLS ciphertext packets which have been encapsulated inside of a
+ * reliability layer.  The reliability layer is implemented as a
+ * straightforward acknowledge and retransmit model.
+ * 
+ * Acknowledgments of received messages can be encoded in either the
+ * dedicated \c P_ACK_* record or they can be prepended to a \c
+ * P_CONTROL_* message.
+ * 
+ * See the \link reliable Reliability Layer\endlink module for a detailed
+ * description.
+ * 
+ * @section network_protocol_control Structure of control channel messages
+ * 
+ * @subsection network_protocol_control_ciphertext Structure of ciphertext control channel messages
+ * 
+ * Control channel packets in ciphertext form consist of the following
+ * parts:
+ * 
+ *  - local \c session_id (random 64 bit value to identify TLS session).
+ *  - HMAC signature of entire encapsulation header for HMAC firewall
+ *    [only if \c --tls-auth is specified] (usually 16 or 20 bytes).
+ *  - packet-id for replay protection (4 or 8 bytes, includes sequence
+ *    number and optional \c time_t timestamp).
+ *  - acknowledgment packet-id array length (1 byte).
+ *  - acknowledgment packet-id array (if length > 0).
+ *  - acknowledgment remote session-id (if length > 0).
+ *  - packet-id of this message (4 bytes).
+ *  - TLS payload ciphertext (n bytes) (only for \c P_CONTROL_V1).
+ * 
+ * Note that when \c --tls-auth is used, all message types are protected
+ * with an HMAC signature, even the initial packets of the TLS handshake.
+ * This makes it easy for OpenVPN to throw away bogus packets quickly,
+ * without wasting resources on attempting a TLS handshake which will
+ * ultimately fail.
+ * 
+ * @subsection network_protocol_control_key_methods Control channel key methods and
+ * 
+ * Once the TLS session has been initialized and authenticated, the TLS
+ * channel is used to exchange random %key material for bidirectional
+ * cipher and HMAC keys which will be used to secure data channel packets.
+ * OpenVPN currently implements two %key methods.  %Key method 1 directly
+ * derives keys using random bits obtained from the \c RAND_bytes()
+ * OpenSSL function.  %Key method 2 mixes random %key material from both
+ * sides of the connection using the TLS PRF mixing function.  %Key method
+ * 2 is the preferred method and is the default for OpenVPN 2.0.
+ * 
+ * The @ref key_generation "Data channel key generation" related page
+ * describes the %key methods in more detail.
+ * 
+ * @subsection network_protocol_control_plaintext Structure of plaintext control channel messages
+ * 
+ *  - %Key method 1:
+ *     - Cipher %key length in bytes (1 byte).
+ *     - Cipher %key (n bytes).
+ *     - HMAC %key length in bytes (1 byte).
+ *     - HMAC %key (n bytes).
+ *     - %Options string (n bytes, null terminated, client/server %options
+ *       string should match).
+ *  - %Key method 2:
+ *     - Literal 0 (4 bytes).
+ *     - %Key method (1 byte).
+ *     - \c key_source structure (\c key_source.pre_master only defined
+ *       for client -> server).
+ *     - %Options string length, including null (2 bytes).
+ *     - %Options string (n bytes, null terminated, client/server %options
+ *       string must match).
+ *     - [The username/password data below is optional, record can end at
+ *       this point.]
+ *     - Username string length, including null (2 bytes).
+ *     - Username string (n bytes, null terminated).
+ *     - Password string length, including null (2 bytes).
+ *     - Password string (n bytes, null terminated).
+ * 
+ * @section network_protocol_data Structure of data channel messages
+ * 
+ * @subsection network_protocol_data_ciphertext Structure of ciphertext data channel messages
+ * 
+ * The P_DATA_* payload represents encrypted, encapsulated tunnel packets
+ * which tend to be either IP packets or Ethernet frames. This is
+ * essentially the "payload" of the VPN.
+ * 
+ * Data channel packets in ciphertext form consist of the following parts:
+ *  - HMAC of ciphertext IV + ciphertext (if not disabled by \c --auth
+ *    none).
+ *  - Ciphertext IV (size is cipher-dependent, if not disabled by \c
+ *    --no-iv).
+ *  - Tunnel packet ciphertext.
+ * 
+ * @subsection network_protocol_data_plaintext Structure of plaintext data channel messages
+ * 
+ * Data channel packets in plaintext form consist of the following parts:
+ *  - packet-id (4 or 8 bytes, if not disabled by --no-replay).
+ *     - In TLS mode, 4 bytes are used because the implementation can
+ *       force a TLS renegotation before \c 2^32 packets are sent.
+ *     - In pre-shared %key mode, 8 bytes are used (sequence number and \c
+ *       time_t value) to allow long-term %key usage without packet-id
+ *       collisions.
+ *  - User plaintext (n bytes).
+ */
diff --git a/doxygen/doc_reliable.h b/doxygen/doc_reliable.h
new file mode 100644
index 0000000..9877d8c
--- /dev/null
+++ b/doxygen/doc_reliable.h
@@ -0,0 +1,49 @@
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
+ * Reliability Layer module documentation file.
+ */
+
+/**
+ * @defgroup reliable Reliability Layer module
+ * 
+ * The Reliability Layer is part of OpenVPN's control channel.  It
+ * provides a reliable and sequential transport mechanism for control
+ * channel messages between OpenVPN peers.  This module forms the
+ * interface between the \link external_multiplexer External
+ * Multiplexer\endlink and the \link control_tls Control Channel TLS
+ * module\endlink.
+ * 
+ * @par UDP or TCP as VPN tunnel transport
+ * 
+ * This is especially important when OpenVPN is configured to communicate
+ * over UDP, because UDP does not offer a reliable and sequential
+ * transport.  OpenVPN endpoints can also communicate over TCP which does
+ * provide a reliable and sequential transport.  In both cases, using UDP
+ * or TCP as an external transport, the internal Reliability Layer is
+ * active.
+ */
diff --git a/doxygen/doc_tunnel_state.h b/doxygen/doc_tunnel_state.h
new file mode 100644
index 0000000..7a24a0f
--- /dev/null
+++ b/doxygen/doc_tunnel_state.h
@@ -0,0 +1,155 @@
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
+ * VPN tunnel state documentation file.
+ */
+
+/**
+ * @page tunnel_state Structure of the VPN tunnel state storage
+ * 
+ * This section describes how OpenVPN stores its VPN tunnel state during
+ * operation.
+ * 
+ * OpenVPN uses several data structures as storage containers for state
+ * information of active VPN tunnels.  These are described in this
+ * section, together with a little bit of history to help understand the
+ * origin of the current architecture.
+ * 
+ * Whether an OpenVPN process is running in client-mode or server-mode
+ * determines whether it can support only one or multiple simultaneously
+ * active VPN tunnels.  This consequently also determines how the
+ * associated state information is wrapped up internally.  This section
+ * gives an overview of the differences.
+ * 
+ * @section tunnel_state_history Historic developments
+ * 
+ * In the old v1.x series, an OpenVPN process managed only one single VPN
+ * tunnel.  This allowed the VPN tunnel state to be stored together with
+ * process-global information in one single \c context structure.
+ * 
+ * This changed, however, in the v2.x series, as new OpenVPN versions
+ * running in server-mode can support multiple simultaneously active VPN
+ * tunnels.  This necessitated a redesign of the VPN tunnel state
+ * container structures, and modification of the \link
+ * external_multiplexer External Multiplexer\endlink and \link
+ * internal_multiplexer Internal Multiplexer\endlink systems.  The
+ * majority of these changes are only relevant for OpenVPN processes
+ * running in server-mode, and the client-mode structure has remained very
+ * similar to the v1.x single-tunnel form.
+ * 
+ * @section tunnel_state_client Client-mode state
+ * 
+ * An OpenVPN process running in client-mode can manage at most one single
+ * VPN tunnel at any one time.  The state information for a client's VPN
+ * tunnel is stored in a \c context structure.
+ * 
+ * The \c context structure is created in the \c main() function.  That is
+ * also where process-wide initialization takes place, such as parsing
+ * command line %options and reading configuration files.  The \c context
+ * is then passed to \c tunnel_point_to_point() which drives OpenVPN's
+ * main event processing loop.  These functions are both part of the \link
+ * eventloop Main Event Loop\endlink module.
+ * 
+ * @subsection tunnel_state_client_init Initialization and cleanup
+ * 
+ * Because there is only one \c context structure present, it can be
+ * initialized and cleaned up from the client's main event processing
+ * function.  Before the \c tunnel_point_to_point() function enters its
+ * event loop, it calls \c init_instance_handle_signals() which calls \c
+ * init_instance() to initialize the single \c context structure.  After
+ * the event loop stops, it calls \c close_instance() to clean up the \c
+ * context.
+ * 
+ * @subsection tunnel_state_client_event Event processing
+ * 
+ * When the main event processing loop activates the external or internal
+ * multiplexer to handle a network event, it is not necessary to determine
+ * which VPN tunnel the event is associated with, because there is only
+ * one VPN tunnel active.
+ * 
+ * @section tunnel_state_server Server-mode state
+ * 
+ * An OpenVPN process running in server-mode can manage multiple
+ * simultaneously active VPN tunnels.  For every VPN tunnel active, in
+ * other words for every OpenVPN client which is connected to a server,
+ * the OpenVPN server has one \c context structure in which it stores that
+ * particular VPN tunnel's state information.
+ * 
+ * @subsection tunnel_state_server_multi Multi_context and multi_instance structures
+ * 
+ * To support multiple \c context structures, each is wrapped in a \c
+ * multi_instance structure, and all the \c multi_instance structures are
+ * registered in one single \c multi_context structure.  The \link
+ * external_multiplexer External Multiplexer\endlink and \link
+ * internal_multiplexer Internal Multiplexer\endlink then use the \c
+ * multi_context to retrieve the correct \c multi_instance and \c context
+ * associated with a given network address.
+ * 
+ * @subsection tunnel_state_server_init Startup and initialization
+ * 
+ * An OpenVPN process running in server-mode starts in the same \c main()
+ * function as it would in client-mode.  The same process-wide
+ * initialization is performed, and the resulting state and configuration
+ * is stored in a \c context structure. The server-mode and client-mode
+ * processes diverge when the \c main() function calls one of \c
+ * tunnel_point_to_point() or \c tunnel_server().
+ * 
+ * In server-mode, \c main() calls the \c tunnel_server() function, which
+ * transfers control to \c tunnel_server_udp_single_threaded() or \c
+ * tunnel_server_tcp() depending on the external transport protocol.
+ * 
+ * These functions receive the \c context created in \c main().  This
+ * object has a special status in server-mode, as it does not represent an
+ * active VPN tunnel, but does contain process-wide configuration
+ * parameters.  In the source code, it is often stored in "top" variables.
+ * To distinguish this object from other instances of the same type, its
+ * \c context.mode value is set to \c CM_TOP.  Other \c context objects,
+ * which do represent active VPN tunnels, have a \c context.mode set to \c
+ * CM_CHILD_UDP or \c CM_CHILD_TCP, depending on the external transport
+ * protocol.
+ * 
+ * Both \c tunnel_server_udp_single_threaded() and \c tunnel_server_tcp()
+ * perform similar initialization.  In either case, a \c multi_context
+ * structure is created, and it is initialized according to the
+ * configuration stored in the top \c context by the \c multi_init() and
+ * \c multi_top_init() functions.
+ * 
+ * @subsection tunnel_state_server_tunnels Creating and destroying VPN tunnels
+ * 
+ * When an OpenVPN client makes a new connection to a server, the server
+ * creates a new \c context and \c multi_instance.  The latter is
+ * registered in the \c multi_context, which makes it possible for the
+ * external and internal multiplexers to retrieve the correct \c
+ * multi_instance and \c context when a network event occurs.
+ * 
+ * @subsection tunnel_state_server_cleanup Final cleanup
+ * 
+ * After the main event loop exits, both \c
+ * tunnel_server_udp_single_threaded() and \c tunnel_server_tcp() perform
+ * similar cleanup.  They call \c multi_uninit() followed by \c
+ * multi_top_free() to clean up the \c multi_context structure.
+ */
diff --git a/doxygen/openvpn.doxyfile b/doxygen/openvpn.doxyfile
new file mode 100644
index 0000000..528472b
--- /dev/null
+++ b/doxygen/openvpn.doxyfile
@@ -0,0 +1,279 @@
+# Doxyfile 1.5.5
+
+#---------------------------------------------------------------------------
+# Project related configuration options
+#---------------------------------------------------------------------------
+DOXYFILE_ENCODING      = UTF-8
+PROJECT_NAME           = "OpenVPN"
+PROJECT_NUMBER         = 
+OUTPUT_DIRECTORY       = doxygen
+CREATE_SUBDIRS         = NO
+OUTPUT_LANGUAGE        = English
+BRIEF_MEMBER_DESC      = YES
+REPEAT_BRIEF           = YES
+ABBREVIATE_BRIEF       = "The $name class" \
+                         "The $name widget" \
+                         "The $name file" \
+                         is \
+                         provides \
+                         specifies \
+                         contains \
+                         represents \
+                         a \
+                         an \
+                         the
+ALWAYS_DETAILED_SEC    = NO
+INLINE_INHERITED_MEMB  = NO
+FULL_PATH_NAMES        = YES
+STRIP_FROM_PATH        = ""
+STRIP_FROM_INC_PATH    = 
+SHORT_NAMES            = NO
+JAVADOC_AUTOBRIEF      = YES # NO
+QT_AUTOBRIEF           = NO
+MULTILINE_CPP_IS_BRIEF = NO
+DETAILS_AT_TOP         = NO
+INHERIT_DOCS           = YES
+SEPARATE_MEMBER_PAGES  = NO
+TAB_SIZE               = 8
+ALIASES                = 
+OPTIMIZE_OUTPUT_FOR_C  = YES
+OPTIMIZE_OUTPUT_JAVA   = NO
+OPTIMIZE_FOR_FORTRAN   = NO
+OPTIMIZE_OUTPUT_VHDL   = NO
+BUILTIN_STL_SUPPORT    = NO
+CPP_CLI_SUPPORT        = NO
+SIP_SUPPORT            = NO
+DISTRIBUTE_GROUP_DOC   = NO
+SUBGROUPING            = YES
+TYPEDEF_HIDES_STRUCT   = NO
+#---------------------------------------------------------------------------
+# Build related configuration options
+#---------------------------------------------------------------------------
+EXTRACT_ALL            = YES
+EXTRACT_PRIVATE        = YES
+EXTRACT_STATIC         = YES
+EXTRACT_LOCAL_CLASSES  = YES
+EXTRACT_LOCAL_METHODS  = YES
+EXTRACT_ANON_NSPACES   = YES
+HIDE_UNDOC_MEMBERS     = NO
+HIDE_UNDOC_CLASSES     = NO
+HIDE_FRIEND_COMPOUNDS  = NO
+HIDE_IN_BODY_DOCS      = NO
+INTERNAL_DOCS          = NO
+CASE_SENSE_NAMES       = NO
+HIDE_SCOPE_NAMES       = NO
+SHOW_INCLUDE_FILES     = YES
+INLINE_INFO            = YES
+SORT_MEMBER_DOCS       = YES
+SORT_BRIEF_DOCS        = NO
+SORT_GROUP_NAMES       = NO
+SORT_BY_SCOPE_NAME     = NO
+GENERATE_TODOLIST      = YES
+GENERATE_TESTLIST      = YES
+GENERATE_BUGLIST       = YES
+GENERATE_DEPRECATEDLIST= YES
+ENABLED_SECTIONS       = 
+MAX_INITIALIZER_LINES  = 30
+SHOW_USED_FILES        = YES
+SHOW_DIRECTORIES       = NO
+FILE_VERSION_FILTER    = 
+#---------------------------------------------------------------------------
+# configuration options related to warning and progress messages
+#---------------------------------------------------------------------------
+QUIET                  = NO
+WARNINGS               = YES
+WARN_IF_UNDOCUMENTED   = YES
+WARN_IF_DOC_ERROR      = YES
+WARN_NO_PARAMDOC       = NO
+WARN_FORMAT            = "$file:$line: $text"
+WARN_LOGFILE           = 
+#---------------------------------------------------------------------------
+# configuration options related to the input files
+#---------------------------------------------------------------------------
+INPUT                  = .
+INPUT_ENCODING         = UTF-8
+FILE_PATTERNS          = *.c \
+                         *.cc \
+                         *.cxx \
+                         *.cpp \
+                         *.c++ \
+                         *.d \
+                         *.java \
+                         *.ii \
+                         *.ixx \
+                         *.ipp \
+                         *.i++ \
+                         *.inl \
+                         *.h \
+                         *.hh \
+                         *.hxx \
+                         *.hpp \
+                         *.h++ \
+                         *.idl \
+                         *.odl \
+                         *.cs \
+                         *.php \
+                         *.php3 \
+                         *.inc \
+                         *.m \
+                         *.mm \
+                         *.dox \
+                         *.py \
+                         *.f90 \
+                         *.f \
+                         *.vhd \
+                         *.vhdl
+RECURSIVE              = YES
+EXCLUDE                = 
+EXCLUDE_SYMLINKS       = NO
+EXCLUDE_PATTERNS       = 
+EXCLUDE_SYMBOLS        = 
+EXAMPLE_PATH           = 
+EXAMPLE_PATTERNS       = *
+EXAMPLE_RECURSIVE      = NO
+IMAGE_PATH             = 
+INPUT_FILTER           = 
+FILTER_PATTERNS        = 
+FILTER_SOURCE_FILES    = NO
+#---------------------------------------------------------------------------
+# configuration options related to source browsing
+#---------------------------------------------------------------------------
+SOURCE_BROWSER         = YES
+INLINE_SOURCES         = NO
+STRIP_CODE_COMMENTS    = YES
+REFERENCED_BY_RELATION = YES
+REFERENCES_RELATION    = YES
+REFERENCES_LINK_SOURCE = YES
+USE_HTAGS              = NO
+VERBATIM_HEADERS       = YES
+#---------------------------------------------------------------------------
+# configuration options related to the alphabetical class index
+#---------------------------------------------------------------------------
+ALPHABETICAL_INDEX     = NO
+COLS_IN_ALPHA_INDEX    = 5
+IGNORE_PREFIX          = 
+#---------------------------------------------------------------------------
+# configuration options related to the HTML output
+#---------------------------------------------------------------------------
+GENERATE_HTML          = YES
+HTML_OUTPUT            = html
+HTML_FILE_EXTENSION    = .html
+HTML_HEADER            = 
+HTML_FOOTER            = 
+HTML_STYLESHEET        = 
+HTML_ALIGN_MEMBERS     = YES
+GENERATE_HTMLHELP      = NO
+GENERATE_DOCSET        = NO
+DOCSET_FEEDNAME        = "Doxygen generated docs"
+DOCSET_BUNDLE_ID       = org.doxygen.Project
+HTML_DYNAMIC_SECTIONS  = NO
+CHM_FILE               = 
+HHC_LOCATION           = 
+GENERATE_CHI           = NO
+BINARY_TOC             = NO
+TOC_EXPAND             = NO
+DISABLE_INDEX          = NO
+ENUM_VALUES_PER_LINE   = 4
+GENERATE_TREEVIEW      = NO
+TREEVIEW_WIDTH         = 250
+#---------------------------------------------------------------------------
+# configuration options related to the LaTeX output
+#---------------------------------------------------------------------------
+GENERATE_LATEX         = YES
+LATEX_OUTPUT           = latex
+LATEX_CMD_NAME         = latex
+MAKEINDEX_CMD_NAME     = makeindex
+COMPACT_LATEX          = YES # NO
+PAPER_TYPE             = a4wide
+EXTRA_PACKAGES         = 
+LATEX_HEADER           = 
+PDF_HYPERLINKS         = YES
+USE_PDFLATEX           = YES
+LATEX_BATCHMODE        = NO
+LATEX_HIDE_INDICES     = NO
+#---------------------------------------------------------------------------
+# configuration options related to the RTF output
+#---------------------------------------------------------------------------
+GENERATE_RTF           = NO
+RTF_OUTPUT             = rtf
+COMPACT_RTF            = NO
+RTF_HYPERLINKS         = NO
+RTF_STYLESHEET_FILE    = 
+RTF_EXTENSIONS_FILE    = 
+#---------------------------------------------------------------------------
+# configuration options related to the man page output
+#---------------------------------------------------------------------------
+GENERATE_MAN           = NO
+MAN_OUTPUT             = man
+MAN_EXTENSION          = .3
+MAN_LINKS              = NO
+#---------------------------------------------------------------------------
+# configuration options related to the XML output
+#---------------------------------------------------------------------------
+GENERATE_XML           = NO
+XML_OUTPUT             = xml
+XML_SCHEMA             = 
+XML_DTD                = 
+XML_PROGRAMLISTING     = YES
+#---------------------------------------------------------------------------
+# configuration options for the AutoGen Definitions output
+#---------------------------------------------------------------------------
+GENERATE_AUTOGEN_DEF   = NO
+#---------------------------------------------------------------------------
+# configuration options related to the Perl module output
+#---------------------------------------------------------------------------
+GENERATE_PERLMOD       = NO
+PERLMOD_LATEX          = NO
+PERLMOD_PRETTY         = YES
+PERLMOD_MAKEVAR_PREFIX = 
+#---------------------------------------------------------------------------
+# Configuration options related to the preprocessor   
+#---------------------------------------------------------------------------
+ENABLE_PREPROCESSING   = YES
+MACRO_EXPANSION        = NO
+EXPAND_ONLY_PREDEF     = NO
+SEARCH_INCLUDES        = YES
+INCLUDE_PATH           = 
+INCLUDE_FILE_PATTERNS  = 
+PREDEFINED             = WIN32 NTLM USE_LZO ENABLE_FRAGMENT P2MP P2MP_SERVER USE_CRYPTO USE_SSL ENABLE_PLUGIN ENABLE_MANAGEMENT ENABLE_OCC HAVE_GETTIMEOFDAY
+EXPAND_AS_DEFINED      = 
+SKIP_FUNCTION_MACROS   = YES
+#---------------------------------------------------------------------------
+# Configuration::additions related to external references   
+#---------------------------------------------------------------------------
+TAGFILES               = 
+GENERATE_TAGFILE       = 
+ALLEXTERNALS           = NO
+EXTERNAL_GROUPS        = YES
+PERL_PATH              = /usr/bin/perl
+#---------------------------------------------------------------------------
+# Configuration options related to the dot tool   
+#---------------------------------------------------------------------------
+CLASS_DIAGRAMS         = NO
+MSCGEN_PATH            = 
+HIDE_UNDOC_RELATIONS   = YES
+HAVE_DOT               = YES
+CLASS_GRAPH            = YES
+COLLABORATION_GRAPH    = YES
+GROUP_GRAPHS           = YES
+UML_LOOK               = NO
+TEMPLATE_RELATIONS     = NO
+INCLUDE_GRAPH          = YES
+INCLUDED_BY_GRAPH      = YES
+CALL_GRAPH             = NO # YES
+CALLER_GRAPH           = NO # YES
+GRAPHICAL_HIERARCHY    = YES
+DIRECTORY_GRAPH        = YES
+DOT_IMAGE_FORMAT       = png
+DOT_PATH               = "/usr/bin/dot"
+DOTFILE_DIRS           = 
+DOT_GRAPH_MAX_NODES    = 50
+MAX_DOT_GRAPH_DEPTH    = 1000
+DOT_TRANSPARENT        = YES
+DOT_MULTI_TARGETS      = NO
+GENERATE_LEGEND        = YES
+DOT_CLEANUP            = YES
+#---------------------------------------------------------------------------
+# Configuration::additions related to the search engine   
+#---------------------------------------------------------------------------
+SEARCHENGINE           = NO
diff --git a/openvpn.doxyfile b/openvpn.doxyfile
deleted file mode 100644
index be06bfb..0000000
--- a/openvpn.doxyfile
+++ /dev/null
@@ -1,279 +0,0 @@
-# Doxyfile 1.5.5
-
-#---------------------------------------------------------------------------
-# Project related configuration options
-#---------------------------------------------------------------------------
-DOXYFILE_ENCODING      = UTF-8
-PROJECT_NAME           = "OpenVPN"
-PROJECT_NUMBER         = 
-OUTPUT_DIRECTORY       = doxygen/output
-CREATE_SUBDIRS         = NO
-OUTPUT_LANGUAGE        = English
-BRIEF_MEMBER_DESC      = YES
-REPEAT_BRIEF           = YES
-ABBREVIATE_BRIEF       = "The $name class" \
-                         "The $name widget" \
-                         "The $name file" \
-                         is \
-                         provides \
-                         specifies \
-                         contains \
-                         represents \
-                         a \
-                         an \
-                         the
-ALWAYS_DETAILED_SEC    = NO
-INLINE_INHERITED_MEMB  = NO
-FULL_PATH_NAMES        = YES
-STRIP_FROM_PATH        = ""
-STRIP_FROM_INC_PATH    = 
-SHORT_NAMES            = NO
-JAVADOC_AUTOBRIEF      = YES # NO
-QT_AUTOBRIEF           = NO
-MULTILINE_CPP_IS_BRIEF = NO
-DETAILS_AT_TOP         = NO
-INHERIT_DOCS           = YES
-SEPARATE_MEMBER_PAGES  = NO
-TAB_SIZE               = 8
-ALIASES                = 
-OPTIMIZE_OUTPUT_FOR_C  = YES
-OPTIMIZE_OUTPUT_JAVA   = NO
-OPTIMIZE_FOR_FORTRAN   = NO
-OPTIMIZE_OUTPUT_VHDL   = NO
-BUILTIN_STL_SUPPORT    = NO
-CPP_CLI_SUPPORT        = NO
-SIP_SUPPORT            = NO
-DISTRIBUTE_GROUP_DOC   = NO
-SUBGROUPING            = YES
-TYPEDEF_HIDES_STRUCT   = NO
-#---------------------------------------------------------------------------
-# Build related configuration options
-#---------------------------------------------------------------------------
-EXTRACT_ALL            = YES
-EXTRACT_PRIVATE        = YES
-EXTRACT_STATIC         = YES
-EXTRACT_LOCAL_CLASSES  = YES
-EXTRACT_LOCAL_METHODS  = YES
-EXTRACT_ANON_NSPACES   = YES
-HIDE_UNDOC_MEMBERS     = NO
-HIDE_UNDOC_CLASSES     = NO
-HIDE_FRIEND_COMPOUNDS  = NO
-HIDE_IN_BODY_DOCS      = NO
-INTERNAL_DOCS          = NO
-CASE_SENSE_NAMES       = NO
-HIDE_SCOPE_NAMES       = NO
-SHOW_INCLUDE_FILES     = YES
-INLINE_INFO            = YES
-SORT_MEMBER_DOCS       = YES
-SORT_BRIEF_DOCS        = NO
-SORT_GROUP_NAMES       = NO
-SORT_BY_SCOPE_NAME     = NO
-GENERATE_TODOLIST      = YES
-GENERATE_TESTLIST      = YES
-GENERATE_BUGLIST       = YES
-GENERATE_DEPRECATEDLIST= YES
-ENABLED_SECTIONS       = 
-MAX_INITIALIZER_LINES  = 30
-SHOW_USED_FILES        = YES
-SHOW_DIRECTORIES       = NO
-FILE_VERSION_FILTER    = 
-#---------------------------------------------------------------------------
-# configuration options related to warning and progress messages
-#---------------------------------------------------------------------------
-QUIET                  = NO
-WARNINGS               = YES
-WARN_IF_UNDOCUMENTED   = YES
-WARN_IF_DOC_ERROR      = YES
-WARN_NO_PARAMDOC       = NO
-WARN_FORMAT            = "$file:$line: $text"
-WARN_LOGFILE           = 
-#---------------------------------------------------------------------------
-# configuration options related to the input files
-#---------------------------------------------------------------------------
-INPUT                  = .
-INPUT_ENCODING         = UTF-8
-FILE_PATTERNS          = *.c \
-                         *.cc \
-                         *.cxx \
-                         *.cpp \
-                         *.c++ \
-                         *.d \
-                         *.java \
-                         *.ii \
-                         *.ixx \
-                         *.ipp \
-                         *.i++ \
-                         *.inl \
-                         *.h \
-                         *.hh \
-                         *.hxx \
-                         *.hpp \
-                         *.h++ \
-                         *.idl \
-                         *.odl \
-                         *.cs \
-                         *.php \
-                         *.php3 \
-                         *.inc \
-                         *.m \
-                         *.mm \
-                         *.dox \
-                         *.py \
-                         *.f90 \
-                         *.f \
-                         *.vhd \
-                         *.vhdl
-RECURSIVE              = YES
-EXCLUDE                = 
-EXCLUDE_SYMLINKS       = NO
-EXCLUDE_PATTERNS       = 
-EXCLUDE_SYMBOLS        = 
-EXAMPLE_PATH           = 
-EXAMPLE_PATTERNS       = *
-EXAMPLE_RECURSIVE      = NO
-IMAGE_PATH             = 
-INPUT_FILTER           = 
-FILTER_PATTERNS        = 
-FILTER_SOURCE_FILES    = NO
-#---------------------------------------------------------------------------
-# configuration options related to source browsing
-#---------------------------------------------------------------------------
-SOURCE_BROWSER         = YES
-INLINE_SOURCES         = NO
-STRIP_CODE_COMMENTS    = YES
-REFERENCED_BY_RELATION = YES
-REFERENCES_RELATION    = YES
-REFERENCES_LINK_SOURCE = YES
-USE_HTAGS              = NO
-VERBATIM_HEADERS       = YES
-#---------------------------------------------------------------------------
-# configuration options related to the alphabetical class index
-#---------------------------------------------------------------------------
-ALPHABETICAL_INDEX     = NO
-COLS_IN_ALPHA_INDEX    = 5
-IGNORE_PREFIX          = 
-#---------------------------------------------------------------------------
-# configuration options related to the HTML output
-#---------------------------------------------------------------------------
-GENERATE_HTML          = YES
-HTML_OUTPUT            = html
-HTML_FILE_EXTENSION    = .html
-HTML_HEADER            = 
-HTML_FOOTER            = 
-HTML_STYLESHEET        = 
-HTML_ALIGN_MEMBERS     = YES
-GENERATE_HTMLHELP      = NO
-GENERATE_DOCSET        = NO
-DOCSET_FEEDNAME        = "Doxygen generated docs"
-DOCSET_BUNDLE_ID       = org.doxygen.Project
-HTML_DYNAMIC_SECTIONS  = NO
-CHM_FILE               = 
-HHC_LOCATION           = 
-GENERATE_CHI           = NO
-BINARY_TOC             = NO
-TOC_EXPAND             = NO
-DISABLE_INDEX          = NO
-ENUM_VALUES_PER_LINE   = 4
-GENERATE_TREEVIEW      = NO
-TREEVIEW_WIDTH         = 250
-#---------------------------------------------------------------------------
-# configuration options related to the LaTeX output
-#---------------------------------------------------------------------------
-GENERATE_LATEX         = YES
-LATEX_OUTPUT           = latex
-LATEX_CMD_NAME         = latex
-MAKEINDEX_CMD_NAME     = makeindex
-COMPACT_LATEX          = YES # NO
-PAPER_TYPE             = a4wide
-EXTRA_PACKAGES         = 
-LATEX_HEADER           = 
-PDF_HYPERLINKS         = YES
-USE_PDFLATEX           = YES
-LATEX_BATCHMODE        = NO
-LATEX_HIDE_INDICES     = NO
-#---------------------------------------------------------------------------
-# configuration options related to the RTF output
-#---------------------------------------------------------------------------
-GENERATE_RTF           = NO
-RTF_OUTPUT             = rtf
-COMPACT_RTF            = NO
-RTF_HYPERLINKS         = NO
-RTF_STYLESHEET_FILE    = 
-RTF_EXTENSIONS_FILE    = 
-#---------------------------------------------------------------------------
-# configuration options related to the man page output
-#---------------------------------------------------------------------------
-GENERATE_MAN           = NO
-MAN_OUTPUT             = man
-MAN_EXTENSION          = .3
-MAN_LINKS              = NO
-#---------------------------------------------------------------------------
-# configuration options related to the XML output
-#---------------------------------------------------------------------------
-GENERATE_XML           = NO
-XML_OUTPUT             = xml
-XML_SCHEMA             = 
-XML_DTD                = 
-XML_PROGRAMLISTING     = YES
-#---------------------------------------------------------------------------
-# configuration options for the AutoGen Definitions output
-#---------------------------------------------------------------------------
-GENERATE_AUTOGEN_DEF   = NO
-#---------------------------------------------------------------------------
-# configuration options related to the Perl module output
-#---------------------------------------------------------------------------
-GENERATE_PERLMOD       = NO
-PERLMOD_LATEX          = NO
-PERLMOD_PRETTY         = YES
-PERLMOD_MAKEVAR_PREFIX = 
-#---------------------------------------------------------------------------
-# Configuration options related to the preprocessor   
-#---------------------------------------------------------------------------
-ENABLE_PREPROCESSING   = YES
-MACRO_EXPANSION        = NO
-EXPAND_ONLY_PREDEF     = NO
-SEARCH_INCLUDES        = YES
-INCLUDE_PATH           = 
-INCLUDE_FILE_PATTERNS  = 
-PREDEFINED             = WIN32 NTLM USE_LZO ENABLE_FRAGMENT P2MP P2MP_SERVER USE_CRYPTO USE_SSL ENABLE_PLUGIN ENABLE_MANAGEMENT ENABLE_OCC HAVE_GETTIMEOFDAY
-EXPAND_AS_DEFINED      = 
-SKIP_FUNCTION_MACROS   = YES
-#---------------------------------------------------------------------------
-# Configuration::additions related to external references   
-#---------------------------------------------------------------------------
-TAGFILES               = 
-GENERATE_TAGFILE       = 
-ALLEXTERNALS           = NO
-EXTERNAL_GROUPS        = YES
-PERL_PATH              = /usr/bin/perl
-#---------------------------------------------------------------------------
-# Configuration options related to the dot tool   
-#---------------------------------------------------------------------------
-CLASS_DIAGRAMS         = NO
-MSCGEN_PATH            = 
-HIDE_UNDOC_RELATIONS   = YES
-HAVE_DOT               = YES
-CLASS_GRAPH            = YES
-COLLABORATION_GRAPH    = YES
-GROUP_GRAPHS           = YES
-UML_LOOK               = NO
-TEMPLATE_RELATIONS     = NO
-INCLUDE_GRAPH          = YES
-INCLUDED_BY_GRAPH      = YES
-CALL_GRAPH             = NO # YES
-CALLER_GRAPH           = NO # YES
-GRAPHICAL_HIERARCHY    = YES
-DIRECTORY_GRAPH        = YES
-DOT_IMAGE_FORMAT       = png
-DOT_PATH               = "/usr/bin/dot"
-DOTFILE_DIRS           = 
-DOT_GRAPH_MAX_NODES    = 50
-MAX_DOT_GRAPH_DEPTH    = 1000
-DOT_TRANSPARENT        = YES
-DOT_MULTI_TARGETS      = NO
-GENERATE_LEGEND        = YES
-DOT_CLEANUP            = YES
-#---------------------------------------------------------------------------
-# Configuration::additions related to the search engine   
-#---------------------------------------------------------------------------
-SEARCHENGINE           = NO
-- 
1.7.4.1


