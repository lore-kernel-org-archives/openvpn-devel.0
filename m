From: Adriaan de Jong <dejong@...1435...>
Date: Wed, 22 Jun 2011 08:51:31 +0200
Message-ID: <1308725496-10620-4-git-send-email-dejong@...1435...>
In-Reply-To: <1308725496-10620-1-git-send-email-dejong@...1435...>
References: <1308725496-10620-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/8] Added control channel crypto docs
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
 doc_control_tls.h    |  105 ++++++++++
 doc_key_generation.h |  148 ++++++++++++++
 ssl.c                |  303 ++++++++++++++++++++++++++---
 ssl.h                |  528 +++++++++++++++++++++++++++++---------------------
 4 files changed, 841 insertions(+), 243 deletions(-)
 create mode 100644 doc_control_tls.h
 create mode 100644 doc_key_generation.h

diff --git a/doc_control_tls.h b/doc_control_tls.h
new file mode 100644
index 0000000..dd3a41c
--- /dev/null
+++ b/doc_control_tls.h
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
diff --git a/doc_key_generation.h b/doc_key_generation.h
new file mode 100644
index 0000000..cc8d677
--- /dev/null
+++ b/doc_key_generation.h
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
diff --git a/ssl.c b/ssl.c
index a0493ff..2260ccb 100644
--- a/ssl.c
+++ b/ssl.c
@@ -923,11 +923,33 @@ get_peer_cert(X509_STORE_CTX *ctx, const char *tmp_dir, struct gc_arena *gc)
 
 char * x509_username_field; /* GLOBAL */
 
-/*
- * Our verify callback function -- check
- * that an incoming peer certificate is good.
+/** @name Function for authenticating a new connection from a remote OpenVPN peer
+ *  @{ */
+
+/**
+ * Verify that the remote OpenVPN peer's certificate allows setting up a
+ * VPN tunnel.
+ * @ingroup control_tls
+ * 
+ * This callback function is called every time a new TLS session is being
+ * setup to determine whether the remote OpenVPN peer's certificate is
+ * allowed to connect.  The callback functionality is configured in the \c
+ * init_ssl() function, which calls the OpenSSL library's \c
+ * SSL_CTX_set_verify() function with \c verify_callback() as its callback
+ * argument.
+ * 
+ * @param preverify_ok - Whether the remote OpenVPN peer's certificate
+ *                       past verification.  A value of 1 means it
+ *                       verified successfully, 0 means it failed.
+ * @param ctx          - The complete context used by the OpenSSL library
+ *                       to verify the certificate chain.
+ * 
+ * @return The return value indicates whether the supplied certificate is
+ *     allowed to set up a VPN tunnel.  The following values can be
+ *     returned:
+ *      - \c 0: failure, this certificate is not allowed to connect.
+ *      - \c 1: success, this certificate is allowed to connect.
  */
-
 static int
 verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
 {
@@ -1299,6 +1321,9 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
   goto done;
 }
 
+/** @} name Function for authenticating a new connection from a remote OpenVPN peer */
+
+
 void
 tls_set_common_name (struct tls_multi *multi, const char *common_name)
 {
@@ -2726,6 +2751,32 @@ bio_write_post (const int status, struct buffer *buf)
     }
 }
 
+
+/**************************************************************************/
+/** @addtogroup control_tls
+ *  @{ */
+
+/** @name Functions for packets to be sent to a remote OpenVPN peer
+ *  @{ */
+
+/**
+ * Insert a plaintext buffer into the TLS module.
+ * 
+ * After successfully processing the data, the data in \a buf is zeroized,
+ * its length set to zero, and a value of \c 1 is returned.
+ * 
+ * @param multi        - The security parameter state for this VPN tunnel.
+ * @param ks           - The security parameter state for this %key
+ *                       session.
+ * @param buf          - The plaintext message to process.
+ * 
+ * @return The return value indicates whether the data was successfully
+ *     processed:
+ * - \c 1: All the data was processed successfully.
+ * - \c 0: The data was not processed, this function should be called
+ *   again later to retry.
+ * - \c -1: An error occurred.
+ */
 static int
 key_state_write_plaintext (struct tls_multi *multi, struct key_state *ks, struct buffer *buf)
 {
@@ -2737,6 +2788,22 @@ key_state_write_plaintext (struct tls_multi *multi, struct key_state *ks, struct
   return ret;
 }
 
+/**
+ * Insert plaintext data into the TLS module.
+ * 
+ * @param multi        - The security parameter state for this VPN tunnel.
+ * @param ks           - The security parameter state for this %key
+ *                       session.
+ * @param data         - A pointer to the data to process.
+ * @param len          - The length in bytes of the data to process.
+ * 
+ * @return The return value indicates whether the data was successfully
+ *     processed:
+ * - \c 1: All the data was processed successfully.
+ * - \c 0: The data was not processed, this function should be called
+ *   again later to retry.
+ * - \c -1: An error occurred.
+ */
 static int
 key_state_write_plaintext_const (struct tls_multi *multi, struct key_state *ks, const uint8_t *data, int len)
 {
@@ -2747,6 +2814,60 @@ key_state_write_plaintext_const (struct tls_multi *multi, struct key_state *ks,
   return ret;
 }
 
+/**
+ * Extract ciphertext data from the TLS module.
+ * 
+ * If the \a buf buffer has a length other than zero, this function does
+ * not perform any action and returns 0.
+ * 
+ * @param multi        - The security parameter state for this VPN tunnel.
+ * @param ks           - The security parameter state for this %key
+ *                       session.
+ * @param buf          - A buffer in which to store the ciphertext.
+ * @param maxlen       - The maximum number of bytes to extract.
+ * 
+ * @return The return value indicates whether the data was successfully
+ *     processed:
+ * - \c 1: Data was extracted successfully.
+ * - \c 0: No data was extracted, this function should be called again
+ *   later to retry.
+ * - \c -1: An error occurred.
+ */
+static int
+key_state_read_ciphertext (struct tls_multi *multi, struct key_state *ks, struct buffer *buf,
+			   int maxlen)
+{
+  int ret;
+  perf_push (PERF_BIO_READ_CIPHERTEXT);
+  ret = bio_read (multi, ks->ct_out, buf, maxlen, "tls_read_ciphertext");
+  perf_pop ();
+  return ret;
+}
+
+/** @} name Functions for packets to be sent to a remote OpenVPN peer */
+
+
+/** @name Functions for packets received from a remote OpenVPN peer
+ *  @{ */
+
+/**
+ * Insert a ciphertext buffer into the TLS module.
+ * 
+ * After successfully processing the data, the data in \a buf is zeroized,
+ * its length set to zero, and a value of \c 1 is returned.
+ * 
+ * @param multi        - The security parameter state for this VPN tunnel.
+ * @param ks           - The security parameter state for this %key
+ *                       session.
+ * @param buf          - The ciphertext message to process.
+ * 
+ * @return The return value indicates whether the data was successfully
+ *     processed:
+ * - \c 1: All the data was processed successfully.
+ * - \c 0: The data was not processed, this function should be called
+ *   again later to retry.
+ * - \c -1: An error occurred.
+ */
 static int
 key_state_write_ciphertext (struct tls_multi *multi, struct key_state *ks, struct buffer *buf)
 {
@@ -2758,6 +2879,25 @@ key_state_write_ciphertext (struct tls_multi *multi, struct key_state *ks, struc
   return ret;
 }
 
+/**
+ * Extract plaintext data from the TLS module.
+ * 
+ * If the \a buf buffer has a length other than zero, this function does
+ * not perform any action and returns 0.
+ * 
+ * @param multi        - The security parameter state for this VPN tunnel.
+ * @param ks           - The security parameter state for this %key
+ *                       session.
+ * @param buf          - A buffer in which to store the plaintext.
+ * @param maxlen       - The maximum number of bytes to extract.
+ * 
+ * @return The return value indicates whether the data was successfully
+ *     processed:
+ * - \c 1: Data was extracted successfully.
+ * - \c 0: No data was extracted, this function should be called again
+ *   later to retry.
+ * - \c -1: An error occurred.
+ */
 static int
 key_state_read_plaintext (struct tls_multi *multi, struct key_state *ks, struct buffer *buf,
 			  int maxlen)
@@ -2769,20 +2909,33 @@ key_state_read_plaintext (struct tls_multi *multi, struct key_state *ks, struct
   return ret;
 }
 
-static int
-key_state_read_ciphertext (struct tls_multi *multi, struct key_state *ks, struct buffer *buf,
-			   int maxlen)
-{
-  int ret;
-  perf_push (PERF_BIO_READ_CIPHERTEXT);
-  ret = bio_read (multi, ks->ct_out, buf, maxlen, "tls_read_ciphertext");
-  perf_pop ();
-  return ret;
-}
+/** @} name Functions for packets received from a remote OpenVPN peer */
 
-/*
- * Initialize a key_state.  Each key_state corresponds to
- * a specific SSL/TLS session.
+/** @} addtogroup control_tls */
+
+
+/** @addtogroup control_processor
+ *  @{ */
+
+/** @name Functions for initialization and cleanup of key_state structures
+ *  @{ */
+
+/**
+ * Initialize a \c key_state structure.
+ * @ingroup control_processor
+ * 
+ * This function initializes a \c key_state structure associated with a \c
+ * tls_session.  It sets up the structure's SSL-BIO, sets the object's \c
+ * key_state.state to \c S_INITIAL, and sets the session ID and key ID two
+ * appropriate values based on the \c tls_session's internal state.  It
+ * also initializes a new set of structures for the \link reliable
+ * Reliability Layer\endlink.
+ * 
+ * @param session      - A pointer to the \c tls_session structure
+ *                       associated with the \a ks argument.
+ * @param ks           - A pointer to the \c key_state structure to be
+ *                       initialized.  This structure should already have
+ *                       been allocated before calling this function.
  */
 static void
 key_state_init (struct tls_session *session, struct key_state *ks)
@@ -2868,6 +3021,20 @@ key_state_init (struct tls_session *session, struct key_state *ks)
 #endif
 }
 
+
+/**
+ * Cleanup a \c key_state structure.
+ * @ingroup control_processor
+ * 
+ * This function cleans up a \c key_state structure.  It frees the
+ * associated SSL-BIO, and the structures allocated for the \link reliable
+ * Reliability Layer\endlink.
+ * 
+ * @param ks           - A pointer to the \c key_state structure to be
+ *                       cleaned up.
+ * @param clear        - Whether the memory allocated for the \a ks object
+ *                       should be overwritten with 0s.
+ */
 static void
 key_state_free (struct key_state *ks, bool clear)
 {
@@ -2917,6 +3084,11 @@ key_state_free (struct key_state *ks, bool clear)
     CLEAR (*ks);
 }
 
+/** @} name Functions for initialization and cleanup of key_state structures */
+
+/** @} addtogroup control_processor */
+
+
 /*
  * Must be called if we move a tls_session in memory.
  */
@@ -2924,9 +3096,26 @@ static inline void tls_session_set_self_referential_pointers (struct tls_session
   session->tls_auth.packet_id = &session->tls_auth_pid;
 }
 
-/*
- * Initialize a TLS session.  A TLS session normally has 2 key_state objects,
- * one for the current key, and one for the lame duck (i.e. retiring) key.
+
+/** @addtogroup control_processor
+ *  @{ */
+
+/** @name Functions for initialization and cleanup of tls_session structures
+ *  @{ */
+
+/**
+ * Initialize a \c tls_session structure.
+ * @ingroup control_processor
+ * 
+ * This function initializes a \c tls_session structure.  This includes
+ * generating a random session ID, and initializing the \c KS_PRIMARY \c
+ * key_state in the \c tls_session.key array.
+ * 
+ * @param multi        - A pointer to the \c tls_multi structure
+ *                       associated with the \a session argument.
+ * @param session      - A pointer to the \c tls_session structure to be
+ *                       initialized.  This structure should already have
+ *                       been allocated before calling this function.
  */
 static void
 tls_session_init (struct tls_multi *multi, struct tls_session *session)
@@ -2981,6 +3170,18 @@ tls_session_init (struct tls_multi *multi, struct tls_session *session)
   gc_free (&gc);
 }
 
+/**
+ * Clean up a \c tls_session structure.
+ * @ingroup control_processor
+ * 
+ * This function cleans up a \c tls_session structure.  This includes
+ * cleaning up all associated \c key_state structures.
+ * 
+ * @param session      - A pointer to the \c tls_session structure to be
+ *                       cleaned up.
+ * @param clear        - Whether the memory allocated for the \a session
+ *                       object should be overwritten with 0s.
+ */
 static void
 tls_session_free (struct tls_session *session, bool clear)
 {
@@ -3001,6 +3202,11 @@ tls_session_free (struct tls_session *session, bool clear)
     CLEAR (*session);
 }
 
+/** @} name Functions for initialization and cleanup of tls_session structures */
+
+/** @} addtogroup control_processor */
+
+
 static void
 move_session (struct tls_multi* multi, int dest, int src, bool reinit_src)
 {
@@ -3084,9 +3290,26 @@ lame_duck_must_die (const struct tls_session* session, interval_t *wakeup)
     return false;
 }
 
-/*
- * A tls_multi object fully encapsulates OpenVPN's TLS state.
- * See ssl.h for more comments.
+
+/** @addtogroup control_processor
+ *  @{ */
+
+/** @name Functions for initialization and cleanup of tls_multi structures
+ *  @{ */
+
+/**
+ * Allocate and initialize a \c tls_multi structure.
+ * @ingroup control_processor
+ * 
+ * This function allocates a new \c tls_multi structure, and performs some
+ * amount of initialization.  Afterwards, the \c tls_multi_init_finalize()
+ * function must be called to finalize the structure's initialization
+ * process.
+ * 
+ * @param tls_options  - The configuration options to be used for this VPN
+ *                       tunnel.
+ * 
+ * @return A newly allocated and initialized \c tls_multi structure.
  */
 struct tls_multi *
 tls_multi_init (struct tls_options *tls_options)
@@ -3110,8 +3333,20 @@ tls_multi_init (struct tls_options *tls_options)
   return ret;
 }
 
-/*
- * Finalize our computation of frame sizes.
+
+/**
+ * Finalize initialization of a \c tls_multi structure.
+ * @ingroup control_processor
+ * 
+ * This function initializes the \c TM_ACTIVE \c tls_session, and in
+ * server mode also the \c TM_UNTRUSTED \c tls_session, associated with
+ * this \c tls_multi structure.  It also configures the control channel's
+ * \c frame structure based on the data channel's \c frame given in
+ * argument \a frame.
+ * 
+ * @param multi        - The \c tls_multi structure of which to finalize
+ *                       initialization.
+ * @param frame        - The data channel's \c frame structure.
  */
 void
 tls_multi_init_finalize (struct tls_multi* multi, const struct frame* frame)
@@ -3173,6 +3408,19 @@ tls_multi_init_set_options (struct tls_multi* multi,
 #endif
 }
 
+
+/**
+ * Cleanup a \c tls_multi structure and free associated memory
+ * allocations.
+ * @ingroup control_processor
+ * 
+ * This function cleans up a \c tls_multi structure.  This includes
+ * cleaning up all associated \c tls_session structures.
+ * 
+ * @param multi        - The \c tls_multi structure to clean up in free.
+ * @param clear        - Whether the memory allocated for the \a multi
+ *                       object should be overwritten with 0s.
+ */
 void
 tls_multi_free (struct tls_multi *multi, bool clear)
 {
@@ -3203,6 +3451,11 @@ tls_multi_free (struct tls_multi *multi, bool clear)
   free(multi);
 }
 
+/** @} name Functions for initialization and cleanup of tls_multi structures */
+
+/** @} addtogroup control_processor */
+
+
 /*
  * Move a packet authentication HMAC + related fields to or from the front
  * of the buffer so it can be processed by encrypt/decrypt.
diff --git a/ssl.h b/ssl.h
index 790a57e..0735917 100644
--- a/ssl.h
+++ b/ssl.h
@@ -22,6 +22,12 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+
+/**
+ * @file header file
+ */
+
+
 #ifndef OPENVPN_SSL_H
 #define OPENVPN_SSL_H
 
@@ -45,153 +51,6 @@
 #include "options.h"
 #include "plugin.h"
 
-/*
- * OpenVPN Protocol, taken from ssl.h in OpenVPN source code.
- *
- * TCP/UDP Packet:  This represents the top-level encapsulation.
- *
- * TCP/UDP packet format:
- *
- *   Packet length (16 bits, unsigned) -- TCP only, always sent as
- *       plaintext.  Since TCP is a stream protocol, the packet
- *       length words define the packetization of the stream.
- *
- *   Packet opcode/key_id (8 bits) -- TLS only, not used in
- *       pre-shared secret mode.
- *            packet message type, a P_* constant (high 5 bits)
- *            key_id (low 3 bits, see key_id in struct tls_session
- *              below for comment).  The key_id refers to an
- *              already negotiated TLS session.  OpenVPN seamlessly
- *              renegotiates the TLS session by using a new key_id
- *              for the new session.  Overlap (controlled by
- *              user definable parameters) between old and new TLS
- *              sessions is allowed, providing a seamless transition
- *              during tunnel operation.
- *
- *   Payload (n bytes), which may be a P_CONTROL, P_ACK, or P_DATA
- *       message.
- *
- * Message types:
- *
- *  P_CONTROL_HARD_RESET_CLIENT_V1 -- Key method 1, initial key from
- *    client, forget previous state.
- *
- *  P_CONTROL_HARD_RESET_SERVER_V1 -- Key method 2, initial key
- *    from server, forget previous state.
- *
- *  P_CONTROL_SOFT_RESET_V1 -- New key, with a graceful transition
- *    from old to new key in the sense that a transition window
- *    exists where both the old or new key_id can be used.  OpenVPN
- *    uses two different forms of key_id.  The first form is 64 bits
- *    and is used for all P_CONTROL messages.  P_DATA messages on the
- *    other hand use a shortened key_id of 3 bits for efficiency
- *    reasons since the vast majority of OpenVPN packets in an
- *    active tunnel will be P_DATA messages.  The 64 bit form
- *    is referred to as a session_id, while the 3 bit form is
- *    referred to as a key_id.
- *
- *  P_CONTROL_V1 -- Control channel packet (usually TLS ciphertext).
- *
- *  P_ACK_V1 -- Acknowledgement for P_CONTROL packets received.
- *
- *  P_DATA_V1 -- Data channel packet containing actual tunnel data
- *    ciphertext.
- *
- *  P_CONTROL_HARD_RESET_CLIENT_V2 -- Key method 2, initial key from
- *   client, forget previous state.
- *
- *  P_CONTROL_HARD_RESET_SERVER_V2 -- Key method 2, initial key from
- *   server, forget previous state.
- *
- * P_CONTROL* and P_ACK Payload:  The P_CONTROL message type
- * indicates a TLS ciphertext packet which has been encapsulated
- * inside of a reliability layer.  The reliability layer is
- * implemented as a straightforward ACK and retransmit model.
- *
- * P_CONTROL message format:
- *
- *   local session_id (random 64 bit value to identify TLS session).
- *   HMAC signature of entire encapsulation header for integrity
- *       check if --tls-auth is specified (usually 16 or 20 bytes).
- *   packet-id for replay protection (4 or 8 bytes, includes
- *       sequence number and optional time_t timestamp).
- *   P_ACK packet_id array length (1 byte).
- *   P_ACK packet-id array (if length > 0).
- *   P_ACK remote session_id (if length > 0).
- *   message packet-id (4 bytes).
- *   TLS payload ciphertext (n bytes) (only for P_CONTROL).
- *
- * Once the TLS session has been initialized and authenticated,
- * the TLS channel is used to exchange random key material for
- * bidirectional cipher and HMAC keys which will be
- * used to secure actual tunnel packets.  OpenVPN currently
- * implements two key methods.  Key method 1 directly
- * derives keys using random bits obtained from the RAND_bytes
- * OpenSSL function.  Key method 2 mixes random key material
- * from both sides of the connection using the TLS PRF mixing
- * function.  Key method 2 is the preferred method and is the default
- * for OpenVPN 2.0.
- * 
- * TLS plaintext content:
- *
- * TLS plaintext packet (if key_method == 1):
- *
- *   Cipher key length in bytes (1 byte).
- *   Cipher key (n bytes).
- *   HMAC key length in bytes (1 byte).
- *   HMAC key (n bytes).
- *   Options string (n bytes, null terminated, client/server options
- *       string should match).
- *
- * TLS plaintext packet (if key_method == 2):
- *
- *   Literal 0 (4 bytes).
- *   key_method type (1 byte).
- *   key_source structure (pre_master only defined for client ->
- *       server).
- *   options_string_length, including null (2 bytes).
- *   Options string (n bytes, null terminated, client/server options
- *       string must match).
- *   [The username/password data below is optional, record can end
- *       at this point.]
- *   username_string_length, including null (2 bytes).
- *   Username string (n bytes, null terminated).
- *   password_string_length, including null (2 bytes).
- *   Password string (n bytes, null terminated).
- *
- * The P_DATA payload represents encrypted, encapsulated tunnel
- * packets which tend to be either IP packets or Ethernet frames.
- * This is essentially the "payload" of the VPN.
- *
- * P_DATA message content:
- *   HMAC of ciphertext IV + ciphertext (if not disabled by
- *       --auth none).
- *   Ciphertext IV (size is cipher-dependent, if not disabled by
- *       --no-iv).
- *   Tunnel packet ciphertext.
- *
- * P_DATA plaintext
- *   packet_id (4 or 8 bytes, if not disabled by --no-replay).
- *       In SSL/TLS mode, 4 bytes are used because the implementation
- *       can force a TLS renegotation before 2^32 packets are sent.
- *       In pre-shared key mode, 8 bytes are used (sequence number
- *       and time_t value) to allow long-term key usage without
- *       packet_id collisions.
- *   User plaintext (n bytes).
- *
- * Notes:
- *   (1) ACK messages can be encoded in either the dedicated
- *       P_ACK record or they can be prepended to a P_CONTROL message.
- *   (2) P_DATA and P_CONTROL/P_ACK use independent packet-id
- *       sequences because P_DATA is an unreliable channel while
- *       P_CONTROL/P_ACK is a reliable channel.  Each use their
- *       own independent HMAC keys.
- *   (3) Note that when --tls-auth is used, all message types are
- *       protected with an HMAC signature, even the initial packets
- *       of the TLS handshake.  This makes it easy for OpenVPN to
- *       throw away bogus packets quickly, without wasting resources
- *       on attempting a TLS handshake which will ultimately fail.
- */
 
 /* Used in the TLS PRF function */
 #define KEY_EXPANSION_ID "OpenVPN"
@@ -220,28 +79,82 @@
 #define P_FIRST_OPCODE                 1
 #define P_LAST_OPCODE                  8
 
-/* key negotiation states */
-#define S_ERROR          -1
-#define S_UNDEF           0
-#define S_INITIAL         1	/* tls_init() was called */
-#define S_PRE_START       2	/* waiting for initial reset & acknowledgement */
-#define S_START           3	/* ready to exchange keys */
-#define S_SENT_KEY        4	/* client does S_SENT_KEY -> S_GOT_KEY */
-#define S_GOT_KEY         5	/* server does S_GOT_KEY -> S_SENT_KEY */
-#define S_ACTIVE          6	/* ready to exchange data channel packets */
-#define S_NORMAL_OP       7	/* normal operations */
-
-/*
- * Are we ready to receive data channel packets?
- *
- * Also, if true, we can safely assume session has been
- * authenticated by TLS.
- *
- * NOTE: Assumes S_SENT_KEY + 1 == S_GOT_KEY.
+/** @addtogroup control_processor
+ *  @{ */
+/**
+ * @name Control channel negotiation states
+ *
+ * These states represent the different phases of control channel
+ * negotiation between OpenVPN peers.  OpenVPN servers and clients
+ * progress through the states in a different order, because of their
+ * different roles during exchange of random material.  The references to
+ * the \c key_source2 structure in the list below is only valid if %key
+ * method 2 is being used.  See the \link key_generation data channel key
+ * generation\endlink related page for more information.
+ *
+ * Clients follow this order:
+ *   -# \c S_INITIAL, ready to begin three-way handshake and control
+ *      channel negotiation.
+ *   -# \c S_PRE_START, have started three-way handshake, waiting for
+ *      acknowledgment from remote.
+ *   -# \c S_START, initial three-way handshake complete.
+ *   -# \c S_SENT_KEY, have sent local part of \c key_source2 random
+ *      material.
+ *   -# \c S_GOT_KEY, have received remote part of \c key_source2 random
+ *      material.
+ *   -# \c S_ACTIVE, normal operation during remaining handshake window.
+ *   -# \c S_NORMAL_OP, normal operation.
+ *
+ * Servers follow the same order, except for \c S_SENT_KEY and \c
+ * S_GOT_KEY being reversed, because the server first receives the
+ * client's \c key_source2 random material before generating and sending
+ * its own.
+ *
+ * @{
  */
-#define DECRYPT_KEY_ENABLED(multi, ks) ((ks)->state >= (S_GOT_KEY - (multi)->opt.server))
+#define S_ERROR          -1     /**< Error state.  */
+#define S_UNDEF           0     /**< Undefined state, used after a \c
+                                 *   key_state is cleaned up. */
+#define S_INITIAL         1     /**< Initial \c key_state state after
+                                 *   initialization by \c key_state_init()
+                                 *   before start of three-way handshake. */
+#define S_PRE_START       2     /**< Waiting for the remote OpenVPN peer
+                                 *   to acknowledge during the initial
+                                 *   three-way handshake. */
+#define S_START           3     /**< Three-way handshake is complete,
+                                 *   start of key exchange. */
+#define S_SENT_KEY        4     /**< Local OpenVPN process has sent its
+                                 *   part of the key material. */
+#define S_GOT_KEY         5     /**< Local OpenVPN process has received
+                                 *   the remote's part of the key
+                                 *   material. */
+#define S_ACTIVE          6     /**< Operational \c key_state state
+                                 *   immediately after negotiation has
+                                 *   completed while still within the
+                                 *   handshake window. */
+/* ready to exchange data channel packets */
+#define S_NORMAL_OP       7     /**< Normal operational \c key_state
+                                 *   state. */
+/** @} name Control channel negotiation states */
+/** @} addtogroup control_processor */
+
 
-/* Should we aggregate TLS acknowledgements, and tack them onto control packets? */
+#define DECRYPT_KEY_ENABLED(multi, ks) ((ks)->state >= (S_GOT_KEY - (multi)->opt.server))
+                                /**< Check whether the \a ks \c key_state
+                                 *   is ready to receive data channel
+                                 *   packets.
+                                 *   @ingroup data_crypto
+                                 *
+                                 *   If true, it is safe to assume that
+                                 *   this session has been authenticated
+                                 *   by TLS.
+                                 *
+                                 *   @note This macro only works if
+                                 *       S_SENT_KEY + 1 == S_GOT_KEY. */
+
+/* Should we aggregate TLS
+ * acknowledgements, and tack them onto
+ * control packets? */
 #define TLS_AGGREGATE_ACK
 
 /*
@@ -319,33 +232,50 @@ struct cert_hash_set {
   struct cert_hash *ch[MAX_CERT_DEPTH];
 };
 
-/*
- * Key material, used as source for PRF-based
- * key expansion.
+/**
+ * Container for one half of random material to be used in %key method 2
+ * \ref key_generation "data channel key generation".
+ * @ingroup control_processor
  */
-
 struct key_source {
-  uint8_t pre_master[48]; /* client generated */
-  uint8_t random1[32];    /* generated by both client and server */
-  uint8_t random2[32];    /* generated by both client and server */
+  uint8_t pre_master[48];       /**< Random used for master secret
+                                 *   generation, provided only by client
+                                 *   OpenVPN peer. */
+  uint8_t random1[32];          /**< Seed used for master secret
+                                 *   generation, provided by both client
+                                 *   and server. */
+  uint8_t random2[32];          /**< Seed used for key expansion, provided
+                                 *   by both client and server. */
 };
 
+
+/**
+ * Container for both halves of random material to be used in %key method
+ * 2 \ref key_generation "data channel key generation".
+ * @ingroup control_processor
+ */
 struct key_source2 {
-  struct key_source client;
-  struct key_source server;
+  struct key_source client;     /**< Random provided by client. */
+  struct key_source server;     /**< Random provided by server. */
 };
 
-/*
- * Represents a single instantiation of a TLS negotiation and
- * data channel key exchange.  4 keys are kept: encrypt hmac,
- * decrypt hmac, encrypt cipher, and decrypt cipher.  The TLS
- * control channel is used to exchange these keys.
- * Each hard or soft reset will build
- * a fresh key_state.  Normally an openvpn session will contain two
- * key_state objects, one for the current TLS connection, and other
- * for the retiring or "lame duck" key.  The lame duck key_state is
- * used to maintain transmission continuity on the data-channel while
- * a key renegotiation is taking place.
+/**
+ * Security parameter state of one TLS and data channel %key session.
+ * @ingroup control_processor
+ *
+ * This structure represents one security parameter session between
+ * OpenVPN peers.  It includes the control channel TLS state and the data
+ * channel crypto state.  It also contains the reliability layer
+ * structures used for control channel messages.
+ *
+ * A new \c key_state structure is initialized for each hard or soft
+ * reset.
+ *
+ * @see
+ *  - This structure should be initialized using the \c key_state_init()
+ *    function.
+ *  - This structure should be cleaned up using the \c key_state_free()
+ *    function.
  */
 struct key_state
 {
@@ -523,23 +453,37 @@ struct tls_options
   int gremlin;
 };
 
-/* index into tls_session.key */
-#define KS_PRIMARY    0		/* the primary key */
-#define KS_LAME_DUCK  1		/* the key that's going to retire soon */
-#define KS_SIZE       2
 
-/*
- * A tls_session lives through multiple key_state life-cycles.  Soft resets
- * will reuse a tls_session object, but hard resets or errors will require
- * that a fresh object be built.  Normally three tls_session objects are maintained
- * by an active openvpn session.  The first is the current, TLS authenticated
- * session, the second is used to process connection requests from a new
- * client that would usurp the current session if successfully authenticated,
- * and the third is used as a repository for a "lame-duck" key in the event
- * that the primary session resets due to error while the lame-duck key still
- * has time left before its expiration.  Lame duck keys are used to maintain
- * the continuity of the data channel connection while a new key is being
- * negotiated.
+/** @addtogroup control_processor
+ *  @{ */
+/** @name Index of key_state objects within a tls_session structure
+ *  
+ *  This is the index of \c tls_session.key
+ *  
+ *  @{ */
+#define KS_PRIMARY    0         /**< Primary %key state index. */
+#define KS_LAME_DUCK  1         /**< %Key state index that will retire
+                                 *   soon. */
+#define KS_SIZE       2         /**< Size of the \c tls_session.key array. */
+/** @} name Index of key_state objects within a tls_session structure */
+/** @} addtogroup control_processor */
+
+
+/**
+ * Security parameter state of a single session within a VPN tunnel.
+ * @ingroup control_processor
+ * 
+ * This structure represents an OpenVPN peer-to-peer control channel
+ * session.
+ * 
+ * A \c tls_session remains over soft resets, but a new instance is
+ * initialized for each hard reset.
+ * 
+ * @see
+ *  - This structure should be initialized using the \c tls_session_init()
+ *    function.
+ *  - This structure should be cleaned up using the \c tls_session_free()
+ *    function.
  */
 struct tls_session
 {
@@ -577,11 +521,34 @@ struct tls_session
   struct key_state key[KS_SIZE];
 };
 
-/* index into tls_multi.session */
-#define TM_ACTIVE    0
-#define TM_UNTRUSTED 1
-#define TM_LAME_DUCK 2
-#define TM_SIZE      3
+
+
+/** @addtogroup control_processor
+ *  @{ */
+/** @name Index of tls_session objects within a tls_multi structure
+ *  
+ *  This is the index of \c tls_multi.session
+ *  
+ *  Normally three tls_session objects are maintained by an active openvpn
+ *  session.  The first is the current, TLS authenticated session, the
+ *  second is used to process connection requests from a new client that
+ *  would usurp the current session if successfully authenticated, and the
+ *  third is used as a repository for a "lame-duck" %key in the event that
+ *  the primary session resets due to error while the lame-duck %key still
+ *  has time left before its expiration.  Lame duck keys are used to
+ *  maintain the continuity of the data channel connection while a new %key
+ *  is being negotiated.
+ *  
+ *  @{ */
+#define TM_ACTIVE    0          /**< Active \c tls_session. */
+#define TM_UNTRUSTED 1          /**< As yet un-trusted \c tls_session
+                                 *   being negotiated. */
+#define TM_LAME_DUCK 2          /**< Old \c tls_session. */
+#define TM_SIZE      3          /**< Size of the \c tls_multi.session
+                                 *   array. */
+/** @} name Index of tls_session objects within a tls_multi structure */
+/** @} addtogroup control_processor */
+
 
 /*
  * The number of keys we will scan on encrypt or decrypt.  The first
@@ -595,19 +562,29 @@ struct tls_session
  */
 #define KEY_SCAN_SIZE 3
 
-/*
- * An openvpn session running with TLS enabled has one tls_multi object.
+
+/**
+ * Security parameter state for a single VPN tunnel.
+ * @ingroup control_processor
+ * 
+ * An active VPN tunnel running with TLS enabled has one \c tls_multi
+ * object, in which it stores all control channel and data channel
+ * security parameter state.  This structure can contain multiple,
+ * possibly simultaneously active, \c tls_context objects to allow for
+ * interruption-less transitions during session renegotiations.  Each \c
+ * tls_context represents one control channel session, which can span
+ * multiple data channel security parameter sessions stored in \c
+ * key_state structures.
  */
 struct tls_multi
 {
   /* const options and config info */
   struct tls_options opt;
 
-  /*
-   * A list of key_state objects in the order they should be
-   * scanned by data channel encrypt and decrypt routines.
-   */
   struct key_state* key_scan[KEY_SCAN_SIZE];
+                                /**< List of \c key_state objects in the
+                                 *   order they should be scanned by data
+                                 *   channel modules. */
 
   /*
    * used by tls_pre_encrypt to communicate the encrypt key
@@ -621,10 +598,8 @@ struct tls_multi
    */
   struct link_socket_actual to_link_addr;
 
-  /*
-   * Number of sessions negotiated thus far.
-   */
-  int n_sessions;
+  int n_sessions;               /**< Number of sessions negotiated thus
+                                 *   far. */
 
   /*
    * Number of errors.
@@ -659,6 +634,9 @@ struct tls_multi
    * Our session objects.
    */
   struct tls_session session[TM_SIZE];
+                                /**< Array of \c tls_session objects
+                                 *   representing control channel
+                                 *   sessions with the remote peer. */
 };
 
 /*
@@ -704,20 +682,134 @@ int tls_multi_process (struct tls_multi *multi,
 
 void tls_multi_free (struct tls_multi *multi, bool clear);
 
+
+/**************************************************************************/
+/**
+ * Determine whether an incoming packet is a data channel or control
+ * channel packet, and process accordingly.
+ * @ingroup external_multiplexer
+ * 
+ * When OpenVPN is in TLS mode, this is the first function to process an
+ * incoming packet.  It inspects the packet's one-byte header which
+ * contains the packet's opcode and key ID.  Depending on the opcode, the
+ * packet is processed as a data channel or as a control channel packet.
+ * 
+ * @par Data channel packets
+ * 
+ * If the opcode indicates the packet is a data channel packet, then the
+ * packet's key ID is used to find the local TLS state it is associated
+ * with.  This state is checked whether it is active, authenticated, and
+ * its remote peer is the source of this packet.  If these checks passed,
+ * the state's security parameters are loaded into the \a opt crypto
+ * options so that \p openvpn_decrypt() can later use them to authenticate
+ * and decrypt the packet.
+ * 
+ * This function then returns false.  The \a buf buffer has not been
+ * modified, except for removing the header.
+ * 
+ * @par Control channel packets
+ * 
+ * If the opcode indicates the packet is a control channel packet, then
+ * this function will process it based on its plaintext header. depending
+ * on the packet's opcode and session ID this function determines if it is
+ * destined for an active TLS session, or whether a new TLS session should
+ * be started.  This function also initiates data channel session key
+ * renegotiation if the received opcode requests that.
+ * 
+ * If the incoming packet is destined for an active TLS session, then the
+ * packet is inserted into the Reliability Layer and will be handled
+ * later.
+ * 
+ * @param multi - The TLS multi structure associated with the VPN tunnel
+ *     of this packet.
+ * @param from - The source address of the packet.
+ * @param buf - A buffer structure containing the incoming packet.
+ * @param opt - A crypto options structure that will be loaded with the
+ *     appropriate security parameters to handle the packet if it is a
+ *     data channel packet.
+ * 
+ * @return
+ * @li True if the packet is a control channel packet that has been
+ *     processed successfully.
+ * @li False if the packet is a data channel packet, or if an error
+ *     occurred during processing of a control channel packet.
+ */
 bool tls_pre_decrypt (struct tls_multi *multi,
 		      const struct link_socket_actual *from,
 		      struct buffer *buf,
 		      struct crypto_options *opt);
 
+
+/**************************************************************************/
+/** @name Functions for managing security parameter state for data channel packets
+ *  @{ */
+
+/**
+ * Inspect an incoming packet for which no VPN tunnel is active, and
+ * determine whether a new VPN tunnel should be created.
+ * @ingroup data_crypto
+ * 
+ * This function receives the initial incoming packet from a client that
+ * wishes to establish a new VPN tunnel, and determines the packet is a
+ * valid initial packet.  It is only used when OpenVPN is running in
+ * server mode.
+ * 
+ * The tests performed by this function are whether the packet's opcode is
+ * correct for establishing a new VPN tunnel, whether its key ID is 0, and
+ * whether its size is not too large.  This function also performs the
+ * initial HMAC firewall test, if configured to do so.
+ * 
+ * The incoming packet and the local VPN tunnel state are not modified by
+ * this function.  Its sole purpose is to inspect the packet and determine
+ * whether a new VPN tunnel should be created.  If so, that new VPN tunnel
+ * instance will handle processing of the packet.
+ * 
+ * @param tas - The standalone TLS authentication setting structure for
+ *     this process.
+ * @param from - The source address of the packet.
+ * @param buf - A buffer structure containing the incoming packet.
+ * 
+ * @return
+ * @li True if the packet is valid and a new VPN tunnel should be created
+ *     for this client.
+ * @li False if the packet is not valid, did not pass the HMAC firewall
+ *     test, or some other error occurred.
+ */
 bool tls_pre_decrypt_lite (const struct tls_auth_standalone *tas,
 			   const struct link_socket_actual *from,
 			   const struct buffer *buf);
 
+
+/**
+ * Choose the appropriate security parameters with which to process an
+ * outgoing packet.
+ * @ingroup data_crypto
+ * 
+ * If no appropriate security parameters can be found, or if some other
+ * error occurs, then the buffer is set to empty.
+ * 
+ * @param multi - The TLS state for this packet's destination VPN tunnel.
+ * @param buf - The buffer containing the outgoing packet.
+ * @param opt - The crypto options structure into which the appropriate
+ *     security parameters should be loaded.
+ */
 void tls_pre_encrypt (struct tls_multi *multi,
 		      struct buffer *buf, struct crypto_options *opt);
 
+
+/**
+ * Prepend the one-byte OpenVPN header to the packet, and perform some
+ * accounting for the key state used.
+ * @ingroup data_crypto
+ * 
+ * @param multi - The TLS state for this packet's destination VPN tunnel.
+ * @param buf - The buffer containing the outgoing packet.
+ */
 void tls_post_encrypt (struct tls_multi *multi, struct buffer *buf);
 
+/** @} name Functions for managing security parameter state for data channel packets */
+
+
 void show_available_tls_ciphers (void);
 void get_highest_preference_tls_cipher (char *buf, int size);
 
-- 
1.7.4.1


