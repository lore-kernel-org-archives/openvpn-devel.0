From: Gert Doering <gert@...1296...>
Date: Tue, 15 Apr 2025 17:57:11 +0200
Message-ID: <20250415155720.13034-1-gert@...1296...>
In-Reply-To: <gerrit.1744192676000.I9a27248557fabcd9f7584deb4aba16cd71fb803c@...2715...>
References: <gerrit.1744192676000.I9a27248557fabcd9f7584deb4aba16cd71fb803c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Doxygen: Clean up tls-crypt documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Frank Lichtenheld <frank@...2641...>

- Fix broken links to OpenSSL documentation
- Remove some unnecessary \c for function names.
  Doxygen does handle them automatically.
- Add some \c for --option since otherwise --
  gets converted to one character (e.g. &ndash; in
  HTML).

Change-Id: I9a27248557fabcd9f7584deb4aba16cd71fb803c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/936
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/doc/doxygen/doc_control_tls.h b/doc/doxygen/doc_control_tls.h
index 7ff5e99..3c92a76 100644
--- a/doc/doxygen/doc_control_tls.h
+++ b/doc/doxygen/doc_control_tls.h
@@ -49,7 +49,7 @@
  *
  * @par
  * The former role is described below.  The latter is described in the
- * documentation for the \c verify_callback() function.
+ * documentation for the verify_callback() function.
  *
  * @par
  * In other words, this module takes care of the confidentiality and
@@ -61,7 +61,7 @@
  * Because of the one-to-one relationship between control channel TLS
  * state and \c key_state structures, the initialization and cleanup of an
  * instance of the Control Channel TLS module's state happens within the
- * \c key_state_init() and \c key_state_free() functions.  In other words,
+ * key_state_init() and key_state_free() functions.  In other words,
  * each \c key_state object contains exactly one OpenSSL SSL-BIO object,
  * which is initialized and cleaned up together with the rest of the \c
  * key_state object.
@@ -69,26 +69,26 @@
  * @par Packet processing functions
  * This object behaves somewhat like a black box with a ciphertext and a
  * plaintext I/O port. Its interaction with OpenVPN's control channel
- * during operation takes place within the \c tls_process() function of
+ * during operation takes place within the tls_process() function of
  * the \link control_processor Control Channel Processor\endlink.  The
  * following functions are available for processing packets:
  * - If ciphertext received from the remote peer is available in the \link
  *   reliable Reliability Layer\endlink:
  *   - Insert it into the ciphertext-side of the SSL-BIO.
- *   - Use function: \c key_state_write_ciphertext()
+ *   - Use function: key_state_write_ciphertext()
  * - If ciphertext can be extracted from the ciphertext-side of the
  *   SSL-BIO:
  *   - Pass it to the \link reliable Reliability Layer\endlink for sending
  *     to the remote peer.
- *   - Use function: \c key_state_read_ciphertext()
+ *   - Use function: key_state_read_ciphertext()
  * - If plaintext can be extracted from the plaintext-side of the SSL-BIO:
  *   - Pass it on to the \link control_processor Control Channel
  *     Processor\endlink for local processing.
- *   - Use function: \c key_state_read_plaintext()
+ *   - Use function: key_state_read_plaintext()
  * - If plaintext from the \link control_processor Control Channel
  *   Processor\endlink is available to be sent to the remote peer:
  *   - Insert it into the plaintext-side of the SSL-BIO.
- *   - Use function: \c key_state_write_plaintext() or \c
+ *   - Use function: key_state_write_plaintext() or
  *     key_state_write_plaintext_const()
  *
  * @par Transport Layer Security protocol implementation
@@ -98,7 +98,7 @@
  * @par
  * For more information on the OpenSSL library's BIO objects, please see:
  *  - OpenSSL's generic BIO objects:
- *    http://www.openssl.org/docs/crypto/bio.html
+ *    https://docs.openssl.org/master/man7/bio/#bio
  *  - OpenSSL's SSL-BIO object:
- *    http://www.openssl.org/docs/crypto/BIO_f_ssl.html
+ *    https://docs.openssl.org/master/man3/BIO_f_ssl/#bio_f_ssl
  */
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index 1a604ce..87e9867 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -22,11 +22,11 @@
  */
 
 /**
- * @defgroup tls_crypt Control channel encryption (--tls-crypt, --tls-crypt-v2)
+ * @defgroup tls_crypt Control channel encryption (tls-crypt, tls-crypt-v2)
  * @ingroup control_tls
  * @{
  *
- * Control channel encryption uses a pre-shared static key (like the --tls-auth
+ * Control channel encryption uses a pre-shared static key (like the @c --tls-auth
  * key) to encrypt control channel packets.
  *
  * Encrypting control channel packets has three main advantages:
@@ -36,8 +36,8 @@
  *  - It provides "poor-man's" post-quantum security, against attackers who
  *    will never know the pre-shared key (i.e. no forward secrecy).
  *
- * --tls-crypt uses a tls-auth-style group key, where all servers and clients
- * share the same group key. --tls-crypt-v2 adds support for client-specific
+ * @c --tls-crypt uses a tls-auth-style group key, where all servers and clients
+ * share the same group key. @c --tls-crypt-v2 adds support for client-specific
  * keys, where all servers share the same client-key encryption key, and each
  * clients receives a unique client key, both in plaintext and in encrypted
  * form.  When connecting to a server, the client sends the encrypted key to
@@ -103,7 +103,7 @@
                                                     + sizeof(uint16_t)))
 
 /**
- * Initialize a key_ctx_bi structure for use with --tls-crypt.
+ * Initialize a key_ctx_bi structure for use with @c --tls-crypt.
  *
  * @param key           The key context to initialize
  * @param key_file      The file to read the key from or the key itself if
@@ -141,7 +141,7 @@
  * @param dst   Any data present in this buffer is first authenticated, then
  *              the wrapped packet id and data from the src buffer are appended.
  *              Must have at least tls_crypt_buf_overhead()+BLEN(src) headroom.
- * @param opt   The crypto state for this --tls-crypt instance.
+ * @param opt   The crypto state for this @c --tls-crypt instance.
  *
  * @returns true iff wrapping succeeded.
  */
@@ -154,7 +154,7 @@
  *
  * @param src   Data to decrypt and authenticate.
  * @param dst   Returns the decrypted data, if unwrapping was successful.
- * @param opt   The crypto state for this --tls-crypt instance.
+ * @param opt   The crypto state for this @c --tls-crypt instance.
  *
  * @returns true iff unwrapping succeeded (data authenticated correctly and was
  * no replay).

