From: Steffan Karger <steffan@...1856...>
Date: Sun,  7 Dec 2014 19:48:15 +0100
Message-Id: <1417978095-19427-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Update doxygen (a bit)
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

This is not a full update, but just updates some data channel-related docs
I came across. Other pages probably need a bit of attention too.

Stuff that was changed:
 * Explain data channel crypto format in crypto.h
 * Add P_DATA_V1 and P_DATA_V2 packet format spec
 * Remove '2.1' from title
 * Update some OpenSSL-specific text

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 .gitignore                          |  1 +
 doc/doxygen/doc_data_crypto.h       |  4 +--
 doc/doxygen/doc_mainpage.h          |  2 +-
 doc/doxygen/doc_protocol_overview.h | 69 +++++++++++++++++------------------
 src/openvpn/crypto.h                | 72 ++++++++++++++++++++++++++++++++++++-
 5 files changed, 107 insertions(+), 41 deletions(-)

diff --git a/.gitignore b/.gitignore
index 538c020..06ff7c6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -33,6 +33,7 @@ config.sub
 configure
 configure.h
 depcomp
+doxygen/
 stamp-h1
 install-sh
 missing
diff --git a/doc/doxygen/doc_data_crypto.h b/doc/doxygen/doc_data_crypto.h
index 8dcc15a..1172672 100644
--- a/doc/doxygen/doc_data_crypto.h
+++ b/doc/doxygen/doc_data_crypto.h
@@ -69,7 +69,5 @@
  *
  * @par Crypto algorithms
  * This module uses the crypto algorithm implementations of the external
- * OpenSSL library.  More precisely, it uses the OpenSSL library's \c
- * EVP_Cipher* and \c HMAC_* set of functions to perform cryptographic
- * operations on data channel packets.
+ * crypto library (currently either OpenSSL (default), or PolarSSL).
  */
diff --git a/doc/doxygen/doc_mainpage.h b/doc/doxygen/doc_mainpage.h
index 821b2e8..ed8e324 100644
--- a/doc/doxygen/doc_mainpage.h
+++ b/doc/doxygen/doc_mainpage.h
@@ -29,7 +29,7 @@
  */
 
 /**
- * @mainpage OpenVPN v2.1 source code documentation
+ * @mainpage OpenVPN source code documentation
  *
  * This documentation describes the internal structure of OpenVPN.  It was
  * automatically generated from specially formatted comment blocks in
diff --git a/doc/doxygen/doc_protocol_overview.h b/doc/doxygen/doc_protocol_overview.h
index 26fed33..9edafcf 100644
--- a/doc/doxygen/doc_protocol_overview.h
+++ b/doc/doxygen/doc_protocol_overview.h
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2014 Fox Crypto B.V. <openvpn@...1435...>
  *
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -61,24 +61,26 @@
  * following describes the various opcodes available.
  *
  *  - Control channel messages:
- *     - \c P_CONTROL_HARD_RESET_CLIENT_V1 -- %Key method 1, initial %key
+ *     - \ref P_CONTROL_HARD_RESET_CLIENT_V1 -- %Key method 1, initial %key
  *       from client, forget previous state.
- *     - \c P_CONTROL_HARD_RESET_SERVER_V1 -- %Key method 1, initial %key
+ *     - \ref P_CONTROL_HARD_RESET_SERVER_V1 -- %Key method 1, initial %key
  *       from server, forget previous state.
- *     - \c P_CONTROL_HARD_RESET_CLIENT_V2 -- %Key method 2, initial %key
+ *     - \ref P_CONTROL_HARD_RESET_CLIENT_V2 -- %Key method 2, initial %key
  *       from client, forget previous state.
- *     - \c P_CONTROL_HARD_RESET_SERVER_V2 -- %Key method 2, initial %key
+ *     - \ref P_CONTROL_HARD_RESET_SERVER_V2 -- %Key method 2, initial %key
  *       from server, forget previous state.
- *     - \c P_CONTROL_SOFT_RESET_V1 -- New %key, with a graceful
+ *     - \ref P_CONTROL_SOFT_RESET_V1 -- New %key, with a graceful
  *       transition from old to new %key in the sense that a transition
  *       window exists where both the old or new key_id can be used.
- *     - \c P_CONTROL_V1 -- Control channel packet (usually TLS
+ *     - \ref P_CONTROL_V1 -- Control channel packet (usually TLS
  *       ciphertext).
- *     - \c P_ACK_V1 -- Acknowledgement for control channel packets
+ *     - \ref P_ACK_V1 -- Acknowledgement for control channel packets
  *       received.
  *  - Data channel messages:
- *     - \c P_DATA_V1 -- Data channel packet containing data channel
+ *     - \ref P_DATA_V1 -- Data channel packet containing data channel
  *       ciphertext.
+ *     - \ref P_DATA_V2 -- Data channel packet containing peer-id and data
+ *       channel ciphertext.
  *
  * @subsection network_protocol_external_key_id Session IDs and Key IDs
  *
@@ -139,10 +141,10 @@
  * channel is used to exchange random %key material for bidirectional
  * cipher and HMAC keys which will be used to secure data channel packets.
  * OpenVPN currently implements two %key methods.  %Key method 1 directly
- * derives keys using random bits obtained from the \c RAND_bytes()
- * OpenSSL function.  %Key method 2 mixes random %key material from both
- * sides of the connection using the TLS PRF mixing function.  %Key method
- * 2 is the preferred method and is the default for OpenVPN 2.0.
+ * derives keys using random bits obtained from the \c rand_bytes() function.
+ * %Key method 2 mixes random %key material from both sides of the connection
+ * using the TLS PRF mixing function.  %Key method 2 is the preferred method and
+ * is the default for OpenVPN 2.0+.
  *
  * The @ref key_generation "Data channel key generation" related page
  * describes the %key methods in more detail.
@@ -173,27 +175,22 @@
  *
  * @section network_protocol_data Structure of data channel messages
  *
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
+ * The P_DATA_* payload represents encapsulated tunnel packets which tend to be
+ * either IP packets or Ethernet frames. This is essentially the "payload" of
+ * the VPN. Data channel packets consist of a data channel header, and a
+ * payload. There are two possible formats:
+ *
+ * @par P_DATA_V1
+ * P_DATA_V1 packets have a 1-byte header, carrying the \ref P_DATA_V1 \c opcode
+ * and \c key_id, followed by the payload:\n
+ * <tt> [ 5-bit opcode | 3-bit key_id ] [ payload ] </tt>
+ *
+ * @par P_DATA_V2
+ * P_DATA_V2 packets have the same 1-byte opcode/key_id, but carrying the \ref
+ * P_DATA_V2 opcode, followed by a 3-byte peer-id, which uniquely identifies
+ * the peer:\n
+ * <tt> [ 5-bit opcode | 3-bit key_id ] [ 24-bit peer-id ] [ payload ] </tt>
+ *
+ * See @ref data_crypto for details on the data channel payload format.
+ *
  */
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 618b92c..82158f9 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -6,7 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
- *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
+ *  Copyright (C) 2010-2014 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -25,6 +25,76 @@
 
 /**
  * @file Data Channel Cryptography Module
+ *
+ * @addtogroup data_crypto Data Channel Crypto module
+ *
+ * @par Crypto packet formats
+ * The Data Channel Crypto module supports a number of crypto modes and
+ * configurable options. The actual packet format depends on these options. A
+ * Data Channel packet can consist of:
+ *  - \b Opcode, one byte specifying the packet type (see @ref network_protocol
+ *    "Network protocol").
+ *  - \b Peer-id, if using the v2 data channel packet format (see @ref
+ *    network_protocol "Network protocol").
+ *  - \b HMAC, covering the ciphertext IV + ciphertext. The HMAC size depends
+ *    on the \c \-\-auth option. If \c \-\-auth \c none is specified, there is no
+ *    HMAC at all.
+ *  - \b Ciphertext \b IV, if not disabled by \c \-\-no-iv. The IV size depends on
+ *    the \c \-\-cipher option.
+ *  - \b Packet \b ID, a 32-bit incrementing packet counter that provides replay
+ *    protection (if not disabled by \c \-\-no-replay).
+ *  - \b Timestamp, a 32-bit timestamp of the current time.
+ *  - \b Payload, the plain text network packet to be encrypted (unless
+ *    encryption is disabled by using \c \-\-cipher \c none). The payload might
+ *    already be compressed (see @ref compression "Compression module").
+ *
+ * @par
+ * This section does not discuss the opcode and peer-id, since those do not
+ * depend on the data channel crypto. See @ref network_protocol
+ * "Network protocol" for more information on those.
+ *
+ * @par
+ * \e Legenda \n
+ * <tt>[ xxx ]</tt> = unprotected \n
+ * <tt>[ - xxx - ]</tt> = authenticated \n
+ * <tt>[ * xxx * ]</tt> = encrypted and authenticated
+ *
+ * @par
+ * <b>CBC data channel cypto format</b> \n
+ * In CBC mode, both TLS-mode and static key mode are supported. The IV
+ * consists of random bits to provide unpredictable IVs. \n
+ * <i>CBC IV format:</i> \n
+ * <tt> [ - random - ] </tt> \n
+ * <i>CBC data channel crypto format in TLS-mode:</i> \n
+ * <tt> [ HMAC ] [ - IV - ] [ * packet ID * ] [ * packet payload * ] </tt> \n
+ * <i>CBC data channel crypto format in static key mode:</i> \n
+ * <tt> [ HMAC ] [ - IV - ] [ * packet ID * ] [ * timestamp * ]
+ * [ * packet payload * ] </tt>
+ *
+ * @par
+ * <b>CFB/OFB data channel crypto format</b> \n
+ * CFB and OFB modes are only supported in TLS mode. In these modes, the IV
+ * consists of the packet counter and a timestamp. If the IV is more than 8
+ * bytes long, the remaining space is filled with zeroes. The packet counter may
+ * not roll over within a single TLS sessions. This results in a unique IV for
+ * each packet, as required by the CFB and OFB cipher modes.
+ *
+ * @par
+ * <i>CFB/OFB IV format:</i> \n
+ * <tt>   [ - packet ID - ] [ - timestamp - ] [ - opt: zero-padding - ] </tt>\n
+ * <i>CFB/OFB data channel crypto format:</i> \n
+ * <tt>   [ HMAC ] [ - IV - ] [ * packet payload * ] </tt>
+ *
+ * @par
+ * <b>No-crypto data channel format</b> \n
+ * In no-crypto mode (\c \-\-cipher \c none is specified), both TLS-mode and
+ * static key mode are supported. No encryption will be performed on the packet,
+ * but packets can still be authenticated. This mode does not require an IV.\n
+ * <i>No-crypto data channel crypto format in TLS-mode:</i> \n
+ * <tt> [ HMAC ] [ - packet ID - ] [ - packet payload - ] </tt> \n
+ * <i>No-crypto data channel crypto format in static key mode:</i> \n
+ * <tt> [ HMAC ] [ - packet ID - ] [ - timestamp - ] [ - packet payload - ] </tt>
+ *
  */
 
 #ifndef CRYPTO_H
-- 
1.9.1


