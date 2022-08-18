From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 18 Aug 2022 22:15:04 +0200
Message-Id: <20220818201505.656149-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] reformat: remove newline after return
 type of function prototype
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

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/auth_token.h        | 16 ++++-----
 src/openvpn/block_dns.h         | 16 ++++-----
 src/openvpn/buffer.h            |  7 ++--
 src/openvpn/crypto.h            | 18 ++++------
 src/openvpn/crypto_openssl.h    |  3 +-
 src/openvpn/dco_win.h           | 14 ++++----
 src/openvpn/forward.h           |  8 ++---
 src/openvpn/misc.h              |  6 ++--
 src/openvpn/mtu.h               | 33 ++++++++---------
 src/openvpn/multi.h             |  3 +-
 src/openvpn/options.c           | 21 ++++++-----
 src/openvpn/pkcs11.h            | 24 +++++--------
 src/openvpn/proto.h             |  5 ++-
 src/openvpn/push.h              |  8 ++---
 src/openvpn/reliable.h          |  5 ++-
 src/openvpn/socket.c            | 11 +++---
 src/openvpn/socket.h            | 11 +++---
 src/openvpn/ssl.c               |  3 +-
 src/openvpn/ssl.h               | 28 ++++++---------
 src/openvpn/ssl_backend.h       | 14 ++++----
 src/openvpn/ssl_ncp.h           | 25 +++++--------
 src/openvpn/ssl_pkt.h           | 64 +++++++++++++++------------------
 src/openvpn/ssl_verify.h        |  3 +-
 src/openvpn/vlan.h              |  9 ++---
 src/openvpn/win32.c             |  3 +-
 src/openvpn/win32.h             |  6 ++--
 src/openvpn/xkey_common.h       | 15 ++++----
 src/openvpn/xkey_provider.c     |  8 ++---
 src/openvpnmsica/msica_arg.h    | 15 +++-----
 src/openvpnmsica/msiex.h        | 12 +++----
 src/openvpnmsica/openvpnmsica.h | 24 +++++--------
 src/openvpnserv/validate.h      |  6 ++--
 src/plugins/auth-pam/utils.h    |  9 ++---
 src/tapctl/tap.h                | 18 ++++------
 34 files changed, 183 insertions(+), 288 deletions(-)

Follow-up to the earlier patch.

diff --git a/src/openvpn/auth_token.h b/src/openvpn/auth_token.h
index 50b90cfa..06a4d0bc 100644
--- a/src/openvpn/auth_token.h
+++ b/src/openvpn/auth_token.h
@@ -59,17 +59,15 @@
  * This function will free() an existing multi->auth_token and keep the
  * existing initial timestamp and session id contained in that token.
  */
-void
-generate_auth_token(const struct user_pass *up, struct tls_multi *multi);
+void generate_auth_token(const struct user_pass *up, struct tls_multi *multi);
 
 /**
  * Verifies the auth token to be in the format that generate_auth_token
  * create and checks if the token is valid.
  *
  */
-unsigned
-verify_auth_token(struct user_pass *up, struct tls_multi *multi,
-                  struct tls_session *session);
+unsigned verify_auth_token(struct user_pass *up, struct tls_multi *multi,
+                           struct tls_session *session);
 
 
 
@@ -77,9 +75,8 @@ verify_auth_token(struct user_pass *up, struct tls_multi *multi,
  * Loads an HMAC secret from a file or if no file is present generates a
  * epheremal secret for the run time of the server and stores it into ctx
  */
-void
-auth_token_init_secret(struct key_ctx *key_ctx, const char *key_file,
-                       bool key_inline);
+void auth_token_init_secret(struct key_ctx *key_ctx, const char *key_file,
+                            bool key_inline);
 
 
 /**
@@ -135,7 +132,6 @@ is_auth_token(const char *password)
  * @param multi     Pointer the multi object of the TLS session
  * @param session   Pointer to the TLS session itself
  */
-void
-resend_auth_token_renegotiation(struct tls_multi *multi, struct tls_session *session);
+void resend_auth_token_renegotiation(struct tls_multi *multi, struct tls_session *session);
 
 #endif /* AUTH_TOKEN_H */
diff --git a/src/openvpn/block_dns.h b/src/openvpn/block_dns.h
index b937a922..7c709633 100644
--- a/src/openvpn/block_dns.h
+++ b/src/openvpn/block_dns.h
@@ -31,12 +31,10 @@
 
 typedef void (*block_dns_msg_handler_t) (DWORD err, const char *msg);
 
-DWORD
-delete_block_dns_filters(HANDLE engine);
+DWORD delete_block_dns_filters(HANDLE engine);
 
-DWORD
-add_block_dns_filters(HANDLE *engine, int iface_index, const WCHAR *exe_path,
-                      block_dns_msg_handler_t msg_handler_callback);
+DWORD add_block_dns_filters(HANDLE *engine, int iface_index, const WCHAR *exe_path,
+                            block_dns_msg_handler_t msg_handler_callback);
 
 /**
  * Return interface metric value for the specified interface index.
@@ -48,8 +46,7 @@ add_block_dns_filters(HANDLE *engine, int iface_index, const WCHAR *exe_path,
  *
  * @return positive interface metric on success or -1 on error
  */
-int
-get_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family, int *is_auto);
+int get_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family, int *is_auto);
 
 /**
  * Sets interface metric value for specified interface index.
@@ -61,9 +58,8 @@ get_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family, int *
  * @return 0 on success, a non-zero status code of the last failed action on failure.
  */
 
-DWORD
-set_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family,
-                     const ULONG metric);
+DWORD set_interface_metric(const NET_IFINDEX index, const ADDRESS_FAMILY family,
+                           const ULONG metric);
 
 #endif /* ifndef OPENVPN_BLOCK_DNS_H */
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index fece6336..f7dc7663 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -501,10 +501,9 @@ bool buf_parse(struct buffer *buf, const int delim, char *line, const int size);
  */
 #define FHE_SPACE_BREAK_MASK 0xFF /* space_break parameter in lower 8 bits */
 #define FHE_CAPS 0x100            /* output hex in caps */
-char *
-format_hex_ex(const uint8_t *data, int size, int maxoutput,
-              unsigned int space_break_flags, const char *separator,
-              struct gc_arena *gc);
+char *format_hex_ex(const uint8_t *data, int size, int maxoutput,
+                    unsigned int space_break_flags, const char *separator,
+                    struct gc_arena *gc);
 
 static inline char *
 format_hex(const uint8_t *data, int size, int maxoutput, struct gc_arena *gc)
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 98e2c766..8f2a1036 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -436,10 +436,9 @@ void crypto_adjust_frame_parameters(struct frame *frame,
  *                      incorrect way as all previous OpenVPN versions did, to
  *                      end up with identical numbers for OCC compatibility
  */
-unsigned int
-calculate_crypto_overhead(const struct key_type *kt,
-                          unsigned int pkt_id_size,
-                          bool occ);
+unsigned int calculate_crypto_overhead(const struct key_type *kt,
+                                       unsigned int pkt_id_size,
+                                       bool occ);
 
 /** Return the worst-case OpenVPN crypto overhead (in bytes) */
 unsigned int crypto_max_overhead(void);
@@ -451,8 +450,7 @@ unsigned int crypto_max_overhead(void);
  * @param filename          Filename of the server key file to create.
  * @param pem_name          The name to use in the PEM header/footer.
  */
-void
-write_pem_key_file(const char *filename, const char *key_name);
+void write_pem_key_file(const char *filename, const char *key_name);
 
 /**
  * Generate ephermal key material into the key structure
@@ -461,8 +459,7 @@ write_pem_key_file(const char *filename, const char *key_name);
  * @param pem_name      the name used for logging
  * @return              true if key generation was successful
  */
-bool
-generate_ephemeral_key(struct buffer *key, const char *pem_name);
+bool generate_ephemeral_key(struct buffer *key, const char *pem_name);
 
 /**
  * Read key material from a PEM encoded files into the key structure
@@ -474,9 +471,8 @@ generate_ephemeral_key(struct buffer *key, const char *pem_name);
  *                      otherwise.
  * @return              true if reading into key was successful
  */
-bool
-read_pem_key_file(struct buffer *key, const char *pem_name,
-                  const char *key_file, bool key_inline);
+bool read_pem_key_file(struct buffer *key, const char *pem_name,
+                       const char *key_file, bool key_inline);
 
 /*
  * Message digest-based pseudo random number generator.
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index c1c04840..6e49147c 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -127,7 +127,6 @@ void crypto_print_openssl_errors(const unsigned int flags);
  *
  * @return      The private key if successful or NULL if not
  */
-EVP_PKEY *
-engine_load_key(const char *file, SSL_CTX *ctx);
+EVP_PKEY *engine_load_key(const char *file, SSL_CTX *ctx);
 
 #endif /* CRYPTO_OPENSSL_H_ */
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 348fc568..c5bed379 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -36,14 +36,12 @@ struct dco_context {
 
 typedef struct dco_context dco_context_t;
 
-struct tuntap
-dco_create_socket(struct addrinfo *remoteaddr, bool bind_local,
-                  struct addrinfo *bind, const char *devname,
-                  struct gc_arena *gc, int timeout,
-                  volatile int *signal_received);
-
-void
-dco_start_tun(struct tuntap *tt);
+struct tuntap dco_create_socket(struct addrinfo *remoteaddr, bool bind_local,
+                                struct addrinfo *bind, const char *devname,
+                                struct gc_arena *gc, int timeout,
+                                volatile int *signal_received);
+
+void dco_start_tun(struct tuntap *tt);
 
 #else /* if defined(ENABLE_DCO) && defined(_WIN32) */
 
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index bd2d9601..a49f2e3d 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -260,8 +260,7 @@ void process_outgoing_tun(struct context *c);
  * @param str        - The message to be sent
  * @param msglevel   - Message level to use for logging
  */
-bool
-send_control_channel_string(struct context *c, const char *str, int msglevel);
+bool send_control_channel_string(struct context *c, const char *str, int msglevel);
 
 /*
  * Send a string to remote over the TLS control channel.
@@ -278,9 +277,8 @@ send_control_channel_string(struct context *c, const char *str, int msglevel);
  * @param msglevel   - Message level to use for logging
  */
 
-bool
-send_control_channel_string_dowork(struct tls_multi *multi,
-                                   const char *str, int msglevel);
+bool send_control_channel_string_dowork(struct tls_multi *multi,
+                                        const char *str, int msglevel);
 
 
 /**
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 2a6c0b8b..f9890b94 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -202,14 +202,12 @@ void output_peer_info_env(struct env_set *es, const char *peer_info);
  * @param delimiter     the delimiter to count, typically ':'
  * @return              occrrences of delimiter + 1
  */
-int
-get_num_elements(const char *string, char delimiter);
+int get_num_elements(const char *string, char delimiter);
 
 /**
  * Prepend a directory to a path.
  */
-struct buffer
-prepend_dir(const char *dir, const char *path, struct gc_arena *gc);
+struct buffer prepend_dir(const char *dir, const char *path, struct gc_arena *gc);
 
 #define _STRINGIFY(S) #S
 /* *INDENT-OFF* - uncrustify need to ignore this macro */
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index d4856f16..9942dde0 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -187,10 +187,9 @@ struct key_type;
  *
  * *  [IP][UDP][OPENVPN PROTOCOL HEADER][ **PAYLOAD incl compression header** ]
  */
-size_t
-frame_calculate_payload_size(const struct frame *frame,
-                             const struct options *options,
-                             const struct key_type *kt);
+size_t frame_calculate_payload_size(const struct frame *frame,
+                                    const struct options *options,
+                                    const struct key_type *kt);
 
 /**
  * Calculates the size of the payload overhead according to tun-mtu and
@@ -208,11 +207,10 @@ frame_calculate_payload_size(const struct frame *frame,
  *
  * *  [IP][UDP][OPENVPN PROTOCOL HEADER][ **PAYLOAD incl compression header** ]
  */
-size_t
-frame_calculate_payload_overhead(const struct frame *frame,
-                                 const struct options *options,
-                                 const struct key_type *kt,
-                                 bool extra_tun);
+size_t frame_calculate_payload_overhead(const struct frame *frame,
+                                        const struct options *options,
+                                        const struct key_type *kt,
+                                        bool extra_tun);
 
 /**
  * Calculates the size of the OpenVPN protocol header. This includes
@@ -229,10 +227,9 @@ frame_calculate_payload_overhead(const struct frame *frame,
  * @param occ           Use the calculation for the OCC link-mtu
  * @return              size of the overhead in bytes
  */
-size_t
-frame_calculate_protocol_header_size(const struct key_type *kt,
-                                     const struct options *options,
-                                     bool occ);
+size_t frame_calculate_protocol_header_size(const struct key_type *kt,
+                                            const struct options *options,
+                                            bool occ);
 
 /**
  * Calculate the link-mtu to advertise to our peer.  The actual value is not
@@ -241,17 +238,15 @@ frame_calculate_protocol_header_size(const struct key_type *kt,
  * value they expect.  This assumes that the traditional cipher/auth directives
  * in the config match the config of the peer.
  */
-size_t
-calc_options_string_link_mtu(const struct options *options,
-                             const struct frame *frame);
+size_t calc_options_string_link_mtu(const struct options *options,
+                                    const struct frame *frame);
 
 /**
  * Return the size of the packet ID size that is currently in use by cipher and
  * options for the data channel.
  */
-unsigned int
-calc_packet_id_size_dc(const struct options *options,
-                       const struct key_type *kt);
+unsigned int calc_packet_id_size_dc(const struct options *options,
+                                    const struct key_type *kt);
 
 /*
  * allocate a buffer for socket or tun layer
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 370d795c..1ec24cc8 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -524,8 +524,7 @@ multi_route_defined(const struct multi_context *m,
 /*
  * Takes prefix away from multi_instance.
  */
-void
-ungenerate_prefix(struct multi_instance *mi);
+void ungenerate_prefix(struct multi_instance *mi);
 
 /*
  * Set a msg() function prefix with our current client instance ID.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2415c1a8..861df2d0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5103,17 +5103,16 @@ check_inline_file_via_buf(struct buffer *multiline, char *p[],
     return check_inline_file(&is, p, gc);
 }
 
-static void
-add_option(struct options *options,
-           char *p[],
-           bool is_inline,
-           const char *file,
-           int line,
-           const int level,
-           const int msglevel,
-           const unsigned int permission_mask,
-           unsigned int *option_types_found,
-           struct env_set *es);
+static void add_option(struct options *options,
+                       char *p[],
+                       bool is_inline,
+                       const char *file,
+                       int line,
+                       const int level,
+                       const int msglevel,
+                       const unsigned int permission_mask,
+                       unsigned int *option_types_found,
+                       struct env_set *es);
 
 static void
 read_config_file(struct options *options,
diff --git a/src/openvpn/pkcs11.h b/src/openvpn/pkcs11.h
index 554bc295..e6bdb7ba 100644
--- a/src/openvpn/pkcs11.h
+++ b/src/openvpn/pkcs11.h
@@ -28,45 +28,37 @@
 
 #include "ssl_common.h"
 
-bool
-pkcs11_initialize(
+bool pkcs11_initialize(
     const bool fProtectedAuthentication,
     const int nPINCachePeriod
     );
 
-void
-pkcs11_terminate();
+void pkcs11_terminate();
 
-bool
-pkcs11_addProvider(
+bool pkcs11_addProvider(
     const char *const provider,
     const bool fProtectedAuthentication,
     const unsigned private_mode,
     const bool fCertIsPrivate
     );
 
-int
-pkcs11_logout();
+int pkcs11_logout();
 
-int
-pkcs11_management_id_count();
+int pkcs11_management_id_count();
 
-bool
-pkcs11_management_id_get(
+bool pkcs11_management_id_get(
     const int index,
     char **id,
     char **base64
     );
 
-int
-tls_ctx_use_pkcs11(
+int tls_ctx_use_pkcs11(
     struct tls_root_ctx *const ssl_ctx,
     bool pkcs11_id_management,
     const char *const pkcs11_id
     );
 
-void
-show_pkcs11_ids(
+void show_pkcs11_ids(
     const char *const provider,
     bool cert_private
     );
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 5b52a10a..a4390f6c 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -308,9 +308,8 @@ bool is_ipv6(int tunnel_type, struct buffer *buf);
  * @param proto next    - header or IP protocol of the packet
  * @return The calculated checksum in host order
  */
-uint16_t
-ip_checksum(const sa_family_t af, const uint8_t *payload, const int len_payload,
-            const uint8_t *src_addr, const uint8_t *dest_addr,  const int proto);
+uint16_t ip_checksum(const sa_family_t af, const uint8_t *payload, const int len_payload,
+                     const uint8_t *src_addr, const uint8_t *dest_addr,  const int proto);
 
 #ifdef PACKET_TRUNCATION_CHECK
 void ipv4_packet_size_verify(const uint8_t *data,
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 62fad4a1..f6ed8374 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -75,9 +75,8 @@ void send_auth_failed(struct context *c, const char *client_reason);
  * doc/management-notes.txt under client-pending-auth for
  * more details on message format
  */
-bool
-send_auth_pending_messages(struct tls_multi *tls_multi, const char *extra,
-                           unsigned int timeout);
+bool send_auth_pending_messages(struct tls_multi *tls_multi, const char *extra,
+                                unsigned int timeout);
 
 void send_restart(struct context *c, const char *kill_msg);
 
@@ -95,7 +94,6 @@ void send_push_reply_auth_token(struct tls_multi *multi);
  * @param c             The context struct
  * @param buffer        Buffer containing the control message with AUTH_PENDING
  */
-void
-receive_auth_pending(struct context *c, const struct buffer *buffer);
+void receive_auth_pending(struct context *c, const struct buffer *buffer);
 
 #endif /* ifndef PUSH_H */
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index b9863efe..699b26fa 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -142,9 +142,8 @@ bool reliable_ack_read(struct reliable_ack *ack,
  * @li True, if processing was successful.
  * @li False, if an error occurs during processing.
  */
-bool
-reliable_ack_parse(struct buffer *buf, struct reliable_ack *ack,
-                   struct session_id *session_id_remote);
+bool reliable_ack_parse(struct buffer *buf, struct reliable_ack *ack,
+                        struct session_id *session_id_remote);
 
 /**
  * Remove acknowledged packets from a reliable structure.
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index b4c20f69..4f5871f0 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1605,15 +1605,12 @@ done:
  * such as TCP.
  */
 
-static void
-stream_buf_init(struct stream_buf *sb, struct buffer *buf,
-                const unsigned int sockflags, const int proto);
+static void stream_buf_init(struct stream_buf *sb, struct buffer *buf,
+                            const unsigned int sockflags, const int proto);
 
-static void
-stream_buf_close(struct stream_buf *sb);
+static void stream_buf_close(struct stream_buf *sb);
 
-static bool
-stream_buf_added(struct stream_buf *sb, int length_added);
+static bool stream_buf_added(struct stream_buf *sb, int length_added);
 
 /* For stream protocols, allocate a buffer to build up packet.
  * Called after frame has been finalized. */
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 0d521d22..8859a229 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -1248,12 +1248,11 @@ socket_event_handle(const struct link_socket *s)
 
 event_t socket_listen_event_handle(struct link_socket *s);
 
-unsigned int
-socket_set(struct link_socket *s,
-           struct event_set *es,
-           unsigned int rwflags,
-           void *arg,
-           unsigned int *persistent);
+unsigned int socket_set(struct link_socket *s,
+                        struct event_set *es,
+                        unsigned int rwflags,
+                        void *arg,
+                        unsigned int *persistent);
 
 static inline void
 socket_set_listen_persistent(struct link_socket *s,
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 33e145b3..5533fea8 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -253,8 +253,7 @@ static const tls_cipher_name_pair tls_cipher_name_translation_table[] = {
  * @param key                   HMAC key, used to calculate implicit IV
  * @param key_len               HMAC key length
  */
-static void
-key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len);
+static void key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len);
 
 const tls_cipher_name_pair *
 tls_get_cipher_name_pair(const char *cipher_name, size_t len)
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 76b1b674..59b3dcf3 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -325,8 +325,7 @@ struct key_state *tls_select_encryption_key(struct tls_multi *multi);
  *
  * @ingroup data_crypto
  */
-void
-tls_prepend_opcode_v1(const struct tls_multi *multi, struct buffer *buf);
+void tls_prepend_opcode_v1(const struct tls_multi *multi, struct buffer *buf);
 
 /**
  * Prepend an OpenVPN data channel P_DATA_V2 header to the packet.  The
@@ -344,8 +343,7 @@ tls_prepend_opcode_v1(const struct tls_multi *multi, struct buffer *buf);
  *
  * @ingroup data_crypto
  */
-void
-tls_prepend_opcode_v2(const struct tls_multi *multi, struct buffer *buf);
+void tls_prepend_opcode_v2(const struct tls_multi *multi, struct buffer *buf);
 
 /**
  * Perform some accounting for the key state used.
@@ -540,10 +538,9 @@ void ssl_clean_user_pass(void);
  * @param cipher_list_tls13 list of allowed TLS 1.3+ cipher, or NULL
  * @param tls_cert_profile  TLS certificate crypto profile name.
  */
-void
-show_available_tls_ciphers(const char *cipher_list,
-                           const char *cipher_list_tls13,
-                           const char *tls_cert_profile);
+void show_available_tls_ciphers(const char *cipher_list,
+                                const char *cipher_list_tls13,
+                                const char *tls_cert_profile);
 
 
 /**
@@ -552,22 +549,19 @@ show_available_tls_ciphers(const char *cipher_list,
  * This erases the source material used to generate the data channel keys, and
  * can thus be called only once per session.
  */
-bool
-tls_session_generate_data_channel_keys(struct tls_multi *multi,
-                                       struct tls_session *session);
+bool tls_session_generate_data_channel_keys(struct tls_multi *multi,
+                                            struct tls_session *session);
 
 /**
  * Load ovpn.xkey provider used for external key signing
  */
-void
-load_xkey_provider(void);
+void load_xkey_provider(void);
 
 /* Special method to skip the three way handshake RESET stages. This is
  * used by the HMAC code when seeing a packet that matches the previous
  * HMAC based stateless server state */
-bool
-session_skip_to_pre_start(struct tls_session *session,
-                          struct tls_pre_decrypt_state *state,
-                          struct link_socket_actual *from);
+bool session_skip_to_pre_start(struct tls_session *session,
+                               struct tls_pre_decrypt_state *state,
+                               struct link_socket_actual *from);
 
 #endif /* ifndef OPENVPN_SSL_H */
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 1bd33699..5871155e 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -403,10 +403,9 @@ void backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx,
  * @param ekm_size     The size of ekm, in bytes
  * @returns            true if exporting succeeded, false otherwise
  */
-bool
-key_state_export_keying_material(struct tls_session *session,
-                                 const char *label, size_t label_size,
-                                 void *ekm, size_t ekm_size);
+bool key_state_export_keying_material(struct tls_session *session,
+                                      const char *label, size_t label_size,
+                                      void *ekm, size_t ekm_size);
 
 /**************************************************************************/
 /** @addtogroup control_tls
@@ -547,10 +546,9 @@ void print_details(struct key_state_ssl *ks_ssl, const char *prefix);
  * @param tls13             Select if <=TLS1.2 or TLS1.3+ ciphers
  *                          should be shown
  */
-void
-show_available_tls_ciphers_list(const char *cipher_list,
-                                const char *tls_cert_profile,
-                                bool tls13);
+void show_available_tls_ciphers_list(const char *cipher_list,
+                                     const char *tls_cert_profile,
+                                     bool tls13);
 
 /*
  * Show the available elliptic curves in the crypto library
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index 97c04302..23331c7f 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -38,8 +38,7 @@
  * Returns whether the client supports NCP either by
  * announcing IV_NCP>=2 or the IV_CIPHERS list
  */
-bool
-tls_peer_supports_ncp(const char *peer_info);
+bool tls_peer_supports_ncp(const char *peer_info);
 
 /* forward declaration to break include dependency loop */
 struct context;
@@ -50,8 +49,7 @@ struct context;
  *
  * @return  Wether the client NCP process suceeded or failed
  */
-bool
-check_pull_client_ncp(struct context *c, int found);
+bool check_pull_client_ncp(struct context *c, int found);
 
 /**
  * Iterates through the ciphers in server_list and return the first
@@ -70,9 +68,8 @@ check_pull_client_ncp(struct context *c, int found);
  * @returns NULL if no common cipher is available, otherwise the best common
  * cipher
  */
-char *
-ncp_get_best_cipher(const char *server_list, const char *peer_info,
-                    const char *remote_cipher, struct gc_arena *gc);
+char *ncp_get_best_cipher(const char *server_list, const char *peer_info,
+                          const char *remote_cipher, struct gc_arena *gc);
 
 
 /**
@@ -83,8 +80,7 @@ ncp_get_best_cipher(const char *server_list, const char *peer_info,
  * or allocated via gc. If no information is available an empty string
  * ("") is returned.
  */
-const char *
-tls_peer_ncp_list(const char *peer_info, struct gc_arena *gc);
+const char *tls_peer_ncp_list(const char *peer_info, struct gc_arena *gc);
 
 /**
  * Check whether the ciphers in the supplied list are supported.
@@ -99,8 +95,7 @@ tls_peer_ncp_list(const char *peer_info, struct gc_arena *gc);
  *                      is short than MAX_NCP_CIPHERS_LENGTH. NULL
  *                      otherwise.
  */
-char *
-mutate_ncp_cipher_list(const char *list, struct gc_arena *gc);
+char *mutate_ncp_cipher_list(const char *list, struct gc_arena *gc);
 
 /**
  * Appends the cipher specified by the ciphernamer parameter to to
@@ -144,16 +139,14 @@ void p2p_mode_ncp(struct tls_multi *multi, struct tls_session *session);
  * @param gc            gc arena that will be used to allocate the returned cipher
  * @return              common cipher if one exist.
  */
-const char *
-get_p2p_ncp_cipher(struct tls_session *session, const char *peer_info,
-                   struct gc_arena *gc);
+const char *get_p2p_ncp_cipher(struct tls_session *session, const char *peer_info,
+                               struct gc_arena *gc);
 
 
 /**
  * Checks if the cipher is allowed, otherwise returns false and reset the
  * cipher to the config cipher.
  */
-bool
-check_session_cipher(struct tls_session *session, struct options *options);
+bool check_session_cipher(struct tls_session *session, struct options *options);
 
 #endif /* ifndef OPENVPN_SSL_NCP_H */
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 45e0a81f..d5d5d10f 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -146,11 +146,10 @@ void free_tls_pre_decrypt_state(struct tls_pre_decrypt_state *state);
  * @li False if the packet is not valid, did not pass the HMAC firewall
  *     test, or some other error occurred.
  */
-enum first_packet_verdict
-tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
-                     struct tls_pre_decrypt_state *state,
-                     const struct link_socket_actual *from,
-                     const struct buffer *buf);
+enum first_packet_verdict tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
+                                               struct tls_pre_decrypt_state *state,
+                                               const struct link_socket_actual *from,
+                                               const struct buffer *buf);
 
 /* Creates an SHA256 HMAC context with a random key that is used for the
  * session id.
@@ -172,11 +171,10 @@ hmac_ctx_t *session_id_hmac_init(void);
  * @param offset        offset to 'now' to use
  * @return              the expected server session id
  */
-struct session_id
-calculate_session_id_hmac(struct session_id client_sid,
-                          const struct openvpn_sockaddr *from,
-                          hmac_ctx_t *hmac,
-                          int handwindow, int offset);
+struct session_id calculate_session_id_hmac(struct session_id client_sid,
+                                            const struct openvpn_sockaddr *from,
+                                            hmac_ctx_t *hmac,
+                                            int handwindow, int offset);
 
 /**
  * Checks if a control packet has a correct HMAC server session id
@@ -187,33 +185,30 @@ calculate_session_id_hmac(struct session_id client_sid,
  * @param handwindow    the quantisation of the current time
  * @return              the expected server session id
  */
-bool
-check_session_id_hmac(struct tls_pre_decrypt_state *state,
-                      const struct openvpn_sockaddr *from,
-                      hmac_ctx_t *hmac,
-                      int handwindow);
+bool check_session_id_hmac(struct tls_pre_decrypt_state *state,
+                           const struct openvpn_sockaddr *from,
+                           hmac_ctx_t *hmac,
+                           int handwindow);
 
 /*
  * Write a control channel authentication record.
  */
-void
-write_control_auth(struct tls_session *session,
-                   struct key_state *ks,
-                   struct buffer *buf,
-                   struct link_socket_actual **to_link_addr,
-                   int opcode,
-                   int max_ack,
-                   bool prepend_ack);
+void write_control_auth(struct tls_session *session,
+                        struct key_state *ks,
+                        struct buffer *buf,
+                        struct link_socket_actual **to_link_addr,
+                        int opcode,
+                        int max_ack,
+                        bool prepend_ack);
 
 
 /*
  * Read a control channel authentication record.
  */
-bool
-read_control_auth(struct buffer *buf,
-                  struct tls_wrap_ctx *ctx,
-                  const struct link_socket_actual *from,
-                  const struct tls_options *opt);
+bool read_control_auth(struct buffer *buf,
+                       struct tls_wrap_ctx *ctx,
+                       const struct link_socket_actual *from,
+                       const struct tls_options *opt);
 
 
 /**
@@ -222,13 +217,12 @@ read_control_auth(struct buffer *buf,
  *
  * The returned buf needs to be free with \c free_buf
  */
-struct buffer
-tls_reset_standalone(struct tls_wrap_ctx *ctx,
-                     struct tls_auth_standalone *tas,
-                     struct session_id *own_sid,
-                     struct session_id *remote_sid,
-                     uint8_t header,
-                     bool request_resend_wkc);
+struct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx,
+                                   struct tls_auth_standalone *tas,
+                                   struct session_id *own_sid,
+                                   struct session_id *remote_sid,
+                                   uint8_t header,
+                                   bool request_resend_wkc);
 
 static inline const char *
 packet_opcode_name(int op)
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 15ef0b40..11f19b84 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -88,8 +88,7 @@ enum tls_auth_status
  *
  * @return              Current authentication status of the tls_multi
  */
-enum tls_auth_status
-tls_authentication_status(struct tls_multi *multi);
+enum tls_auth_status tls_authentication_status(struct tls_multi *multi);
 
 /** Check whether the \a ks \c key_state has finished the key exchange part
  *  of the OpenVPN hand shake. This is that the key_method_2read/write
diff --git a/src/openvpn/vlan.h b/src/openvpn/vlan.h
index 89dc7d46..ce8cbf61 100644
--- a/src/openvpn/vlan.h
+++ b/src/openvpn/vlan.h
@@ -32,13 +32,10 @@
 struct multi_context;
 struct multi_instance;
 
-int16_t
-vlan_decapsulate(const struct context *c, struct buffer *buf);
+int16_t vlan_decapsulate(const struct context *c, struct buffer *buf);
 
-bool
-vlan_is_tagged(const struct buffer *buf);
+bool vlan_is_tagged(const struct buffer *buf);
 
-void
-vlan_process_outgoing_tun(struct multi_context *m, struct multi_instance *mi);
+void vlan_process_outgoing_tun(struct multi_context *m, struct multi_instance *mi);
 
 #endif /* VLAN_H */
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 82f0c73f..33f8d654 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -105,8 +105,7 @@ static char *win_sys_path = NULL; /* GLOBAL */
 /**
  * Set OpenSSL environment variables to a safe directory
  */
-static void
-set_openssl_env_vars();
+static void set_openssl_env_vars();
 
 void
 init_win32(void)
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index b1371999..74b80ed0 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -319,16 +319,14 @@ bool send_msg_iservice(HANDLE pipe, const void *data, size_t size,
 /*
  * Attempt to simulate fork/execve on Windows
  */
-int
-openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags);
+int openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags);
 
 /*
  * openvpn_swprintf() is currently only used by Windows code paths
  * and when enabled for all platforms it will currently break older
  * OpenBSD versions lacking vswprintf(3) support in their libc.
  */
-bool
-openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const format, ...);
+bool openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const format, ...);
 
 #endif /* ifndef OPENVPN_WIN32_H */
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/xkey_common.h b/src/openvpn/xkey_common.h
index 6d6a1e2c..107d43c9 100644
--- a/src/openvpn/xkey_common.h
+++ b/src/openvpn/xkey_common.h
@@ -115,9 +115,8 @@ EVP_PKEY *xkey_load_management_key(OSSL_LIB_CTX *libctx, EVP_PKEY *pubkey);
  * to the required size and false is returned.
  *
  */
-bool
-encode_pkcs1(unsigned char *enc, size_t *enc_len, const char *mdname,
-             const unsigned char *tbs, size_t tbslen);
+bool encode_pkcs1(unsigned char *enc, size_t *enc_len, const char *mdname,
+                  const unsigned char *tbs, size_t tbslen);
 
 /**
  * Compute message digest
@@ -133,9 +132,8 @@ encode_pkcs1(unsigned char *enc, size_t *enc_len, const char *mdname,
  * On successful return *buflen is set to the actual size of the result.
  * TIP: EVP_MD_MAX_SIZE should be enough capacity of buf for al algorithms.
  */
-int
-xkey_digest(const unsigned char *src, size_t srclen, unsigned char *buf,
-            size_t *buflen, const char *mdname);
+int xkey_digest(const unsigned char *src, size_t srclen, unsigned char *buf,
+                size_t *buflen, const char *mdname);
 
 /**
  * Load a generic external key with custom sign and free ops
@@ -150,9 +148,8 @@ xkey_digest(const unsigned char *src, size_t srclen, unsigned char *buf,
  * IMPORTANT: a reference to the handle is retained by the provider and
  * relased by calling free_op. The caller should not free it.
  */
-EVP_PKEY *
-xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handle, EVP_PKEY *pubkey,
-                      XKEY_EXTERNAL_SIGN_fn *sign_op, XKEY_PRIVKEY_FREE_fn *free_op);
+EVP_PKEY *xkey_load_generic_key(OSSL_LIB_CTX *libctx, void *handle, EVP_PKEY *pubkey,
+                                XKEY_EXTERNAL_SIGN_fn *sign_op, XKEY_PRIVKEY_FREE_fn *free_op);
 
 extern OSSL_LIB_CTX *tls_libctx; /* Global */
 
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index c6965718..f48a42a4 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -131,9 +131,8 @@ KEYSIZE(const XKEY_KEYDATA *key)
  * Helper sign function for native keys
  * Implemented using OpenSSL calls.
  */
-int
-xkey_native_sign(XKEY_KEYDATA *key, unsigned char *sig, size_t *siglen,
-                 const unsigned char *tbs, size_t tbslen, XKEY_SIGALG sigalg);
+int xkey_native_sign(XKEY_KEYDATA *key, unsigned char *sig, size_t *siglen,
+                     const unsigned char *tbs, size_t tbslen, XKEY_SIGALG sigalg);
 
 
 /* keymgmt provider */
@@ -153,8 +152,7 @@ static OSSL_FUNC_keymgmt_set_params_fn keymgmt_set_params;
 static OSSL_FUNC_keymgmt_query_operation_name_fn rsa_keymgmt_name;
 static OSSL_FUNC_keymgmt_query_operation_name_fn ec_keymgmt_name;
 
-static int
-keymgmt_import_helper(XKEY_KEYDATA *key, const OSSL_PARAM params[]);
+static int keymgmt_import_helper(XKEY_KEYDATA *key, const OSSL_PARAM params[]);
 
 static XKEY_KEYDATA *
 keydata_new()
diff --git a/src/openvpnmsica/msica_arg.h b/src/openvpnmsica/msica_arg.h
index 7444f442..b86de3c5 100644
--- a/src/openvpnmsica/msica_arg.h
+++ b/src/openvpnmsica/msica_arg.h
@@ -57,8 +57,7 @@ struct msica_arg_seq
  *
  * @param seq           Pointer to uninitialized argument sequence
  */
-void
-msica_arg_seq_init(_Inout_ struct msica_arg_seq *seq);
+void msica_arg_seq_init(_Inout_ struct msica_arg_seq *seq);
 
 
 /**
@@ -66,8 +65,7 @@ msica_arg_seq_init(_Inout_ struct msica_arg_seq *seq);
  *
  * @param seq           Pointer to the argument sequence
  */
-void
-msica_arg_seq_free(_Inout_ struct msica_arg_seq *seq);
+void msica_arg_seq_free(_Inout_ struct msica_arg_seq *seq);
 
 
 /**
@@ -77,8 +75,7 @@ msica_arg_seq_free(_Inout_ struct msica_arg_seq *seq);
  *
  * @param argument      Zero-terminated argument string to insert.
  */
-void
-msica_arg_seq_add_head(
+void msica_arg_seq_add_head(
     _Inout_ struct msica_arg_seq *seq,
     _In_z_ LPCTSTR argument);
 
@@ -90,8 +87,7 @@ msica_arg_seq_add_head(
  *
  * @param argument      Zero-terminated argument string to append.
  */
-void
-msica_arg_seq_add_tail(
+void msica_arg_seq_add_tail(
     _Inout_ struct msica_arg_seq *seq,
     _Inout_ LPCTSTR argument);
 
@@ -102,8 +98,7 @@ msica_arg_seq_add_tail(
  *
  * @return Joined argument string. Must be released with free() after use.
  */
-LPTSTR
-msica_arg_seq_join(_In_ const struct msica_arg_seq *seq);
+LPTSTR msica_arg_seq_join(_In_ const struct msica_arg_seq *seq);
 
 #ifdef _MSC_VER
 #pragma warning(pop)
diff --git a/src/openvpnmsica/msiex.h b/src/openvpnmsica/msiex.h
index a944ff01..f9712ef6 100644
--- a/src/openvpnmsica/msiex.h
+++ b/src/openvpnmsica/msiex.h
@@ -38,8 +38,7 @@
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  */
-UINT
-msi_get_string(
+UINT msi_get_string(
     _In_ MSIHANDLE hInstall,
     _In_z_ LPCTSTR szName,
     _Out_ LPTSTR *pszValue);
@@ -57,8 +56,7 @@ msi_get_string(
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  */
-UINT
-msi_get_record_string(
+UINT msi_get_record_string(
     _In_ MSIHANDLE hRecord,
     _In_ unsigned int iField,
     _Out_ LPTSTR *pszValue);
@@ -79,8 +77,7 @@ msi_get_record_string(
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  */
-UINT
-msi_format_record(
+UINT msi_format_record(
     _In_ MSIHANDLE hInstall,
     _In_ MSIHANDLE hRecord,
     _Out_ LPTSTR *pszValue);
@@ -102,8 +99,7 @@ msi_format_record(
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  */
-UINT
-msi_format_field(
+UINT msi_format_field(
     _In_ MSIHANDLE hInstall,
     _In_ MSIHANDLE hRecord,
     _In_ unsigned int iField,
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index ec059706..ef8fe3b1 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -97,8 +97,7 @@ extern "C" {
  * @return ERROR_SUCCESS on success; An error code otherwise
  *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
  */
-DLLEXP_DECL UINT __stdcall
-FindSystemInfo(_In_ MSIHANDLE hInstall);
+DLLEXP_DECL UINT __stdcall FindSystemInfo(_In_ MSIHANDLE hInstall);
 
 
 /**
@@ -109,8 +108,7 @@ FindSystemInfo(_In_ MSIHANDLE hInstall);
  * @return ERROR_SUCCESS on success; An error code otherwise
  *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
  */
-DLLEXP_DECL UINT __stdcall
-CloseOpenVPNGUI(_In_ MSIHANDLE hInstall);
+DLLEXP_DECL UINT __stdcall CloseOpenVPNGUI(_In_ MSIHANDLE hInstall);
 
 
 /**
@@ -122,8 +120,7 @@ CloseOpenVPNGUI(_In_ MSIHANDLE hInstall);
  * @return ERROR_SUCCESS on success; An error code otherwise
  *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
  */
-DLLEXP_DECL UINT __stdcall
-StartOpenVPNGUI(_In_ MSIHANDLE hInstall);
+DLLEXP_DECL UINT __stdcall StartOpenVPNGUI(_In_ MSIHANDLE hInstall);
 
 
 /**
@@ -135,8 +132,7 @@ StartOpenVPNGUI(_In_ MSIHANDLE hInstall);
  * @return ERROR_SUCCESS on success; An error code otherwise
  *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
  */
-DLLEXP_DECL UINT __stdcall
-EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall);
+DLLEXP_DECL UINT __stdcall EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall);
 
 
 /**
@@ -147,8 +143,7 @@ EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall);
  * @return ERROR_SUCCESS on success; An error code otherwise
  *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
  */
-DLLEXP_DECL UINT __stdcall
-ProcessDeferredAction(_In_ MSIHANDLE hInstall);
+DLLEXP_DECL UINT __stdcall ProcessDeferredAction(_In_ MSIHANDLE hInstall);
 
 
 /**
@@ -160,8 +155,7 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall);
  * @return ERROR_SUCCESS on success; An error code otherwise
  *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
  */
-DLLEXP_DECL UINT __stdcall
-EvaluateDriver(_In_ MSIHANDLE hInstall);
+DLLEXP_DECL UINT __stdcall EvaluateDriver(_In_ MSIHANDLE hInstall);
 
 
 /**
@@ -173,8 +167,7 @@ EvaluateDriver(_In_ MSIHANDLE hInstall);
  * @return ERROR_SUCCESS on success; An error code otherwise
  *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
  */
-DLLEXP_DECL UINT __stdcall
-ProcessDriver(_In_ MSIHANDLE hInstall);
+DLLEXP_DECL UINT __stdcall ProcessDriver(_In_ MSIHANDLE hInstall);
 
 
 /**
@@ -186,8 +179,7 @@ ProcessDriver(_In_ MSIHANDLE hInstall);
  * @return ERROR_SUCCESS on success; An error code otherwise
  *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
  */
-DLLEXP_DECL UINT __stdcall
-CheckAndScheduleReboot(_In_ MSIHANDLE hInstall);
+DLLEXP_DECL UINT __stdcall CheckAndScheduleReboot(_In_ MSIHANDLE hInstall);
 
 #ifdef __cplusplus
 }
diff --git a/src/openvpnserv/validate.h b/src/openvpnserv/validate.h
index 735485be..021ac7d3 100644
--- a/src/openvpnserv/validate.h
+++ b/src/openvpnserv/validate.h
@@ -32,11 +32,9 @@
 #define OVPN_ADMIN_GROUP TEXT("OpenVPN Administrators")
 /* The last one may be reset in registry: HKLM\Software\OpenVPN\ovpn_admin_group */
 
-BOOL
-IsAuthorizedUser(PSID sid, const HANDLE token, const WCHAR *ovpn_admin_group);
+BOOL IsAuthorizedUser(PSID sid, const HANDLE token, const WCHAR *ovpn_admin_group);
 
-BOOL
-CheckOption(const WCHAR *workdir, int narg, WCHAR *argv[], const settings_t *s);
+BOOL CheckOption(const WCHAR *workdir, int narg, WCHAR *argv[], const settings_t *s);
 
 static inline BOOL
 IsOption(const WCHAR *o)
diff --git a/src/plugins/auth-pam/utils.h b/src/plugins/auth-pam/utils.h
index 23d30f67..56fcacaa 100644
--- a/src/plugins/auth-pam/utils.h
+++ b/src/plugins/auth-pam/utils.h
@@ -38,8 +38,7 @@
  *  @return Returns NULL when any parameter is NULL or the worst-case result is to large ( >= SIZE_MAX).
  *          Otherwise it returns a pointer to a new buffer containing the modified input
  */
-char *
-searchandreplace(const char *tosearch, const char *searchfor, const char *replacewith);
+char *searchandreplace(const char *tosearch, const char *searchfor, const char *replacewith);
 
 /**
  * Given an environmental variable name, search
@@ -50,8 +49,7 @@ searchandreplace(const char *tosearch, const char *searchfor, const char *replac
  *
  * @return Returns a pointer to the value of the environment variable if found, otherwise NULL is returned.
  */
-const char *
-get_env(const char *name, const char *envp[]);
+const char *get_env(const char *name, const char *envp[]);
 
 /**
  * Return the length of a string array
@@ -59,7 +57,6 @@ get_env(const char *name, const char *envp[]);
  * @param array   Pointer to the array to calculate size of
  *
  */
-int
-string_array_len(const char *array[]);
+int string_array_len(const char *array[]);
 
 #endif
diff --git a/src/tapctl/tap.h b/src/tapctl/tap.h
index 670903b3..640f2abe 100644
--- a/src/tapctl/tap.h
+++ b/src/tapctl/tap.h
@@ -49,8 +49,7 @@
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
-DWORD
-tap_create_adapter(
+DWORD tap_create_adapter(
     _In_opt_ HWND hwndParent,
     _In_opt_ LPCTSTR szDeviceDescription,
     _In_ LPCTSTR szHwId,
@@ -76,8 +75,7 @@ tap_create_adapter(
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
-DWORD
-tap_delete_adapter(
+DWORD tap_delete_adapter(
     _In_opt_ HWND hwndParent,
     _In_ LPCGUID pguidAdapter,
     _Inout_ LPBOOL pbRebootRequired);
@@ -103,8 +101,7 @@ tap_delete_adapter(
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
-DWORD
-tap_enable_adapter(
+DWORD tap_enable_adapter(
     _In_opt_ HWND hwndParent,
     _In_ LPCGUID pguidAdapter,
     _In_ BOOL bEnable,
@@ -123,8 +120,7 @@ tap_enable_adapter(
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  **/
-DWORD
-tap_set_adapter_name(
+DWORD tap_set_adapter_name(
     _In_ LPCGUID pguidAdapter,
     _In_ LPCTSTR szName,
     _In_ BOOL bSilent);
@@ -162,8 +158,7 @@ struct tap_adapter_node
  *
  * @return ERROR_SUCCESS on success; Win32 error code otherwise
  */
-DWORD
-tap_list_adapters(
+DWORD tap_list_adapters(
     _In_opt_ HWND hwndParent,
     _In_opt_ LPCTSTR szzHwIDs,
     _Out_ struct tap_adapter_node **ppAdapterList);
@@ -174,8 +169,7 @@ tap_list_adapters(
  *
  * @param pAdapterList  A pointer to the first adapter in the list to free.
  */
-void
-tap_free_adapter_list(
+void tap_free_adapter_list(
     _In_ struct tap_adapter_node *pAdapterList);
 
 #endif /* ifndef TAP_H */
-- 
2.34.1


