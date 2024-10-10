From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 10 Oct 2024 11:46:17 +0000
References: <gerrit.1728560771000.I7a852eb5fafae3a0e85dd89ea6d4c91fcf2fab4e@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <04f630392574fa0aca1b963cf1620af714cb4910-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ANCM1oz97Sw="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Review doxygen
 warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ANCM1oz97Sw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/778?usp=3Demail

to review the following change.


Change subject: Review doxygen warnings
......................................................................

Review doxygen warnings

We write doxygen comments but we do not verify them. So
quite some errors have crept in. Trying to reduce them
by reviewing the warnings output of doxygen and addressing
most of them.

Did generally ignore "The following parameter is not documented"
warnings (except those caused by typos). Fixing those will
require more work.

Usual errors fixed:
 - Wrong usage of @file
 - Wrong spellings of @param
 - Desync between function declaration and comment
   (usually param names)

Change-Id: I7a852eb5fafae3a0e85dd89ea6d4c91fcf2fab4e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M doc/doxygen/doc_compression.h
M doc/doxygen/doc_protocol_overview.h
M sample/sample-plugins/simple/base64.c
M src/openvpn/argv.c
M src/openvpn/buffer.h
M src/openvpn/console.h
M src/openvpn/console_builtin.c
M src/openvpn/console_systemd.c
M src/openvpn/crypto.h
M src/openvpn/crypto_backend.h
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_mbedtls.h
M src/openvpn/crypto_openssl.c
M src/openvpn/crypto_openssl.h
M src/openvpn/dns.c
M src/openvpn/forward.h
M src/openvpn/init.c
M src/openvpn/lzo.c
M src/openvpn/manage.c
M src/openvpn/mbedtls_compat.h
M src/openvpn/multi.h
M src/openvpn/openssl_compat.h
M src/openvpn/pkcs11_backend.h
M src/openvpn/pkcs11_mbedtls.c
M src/openvpn/pkcs11_openssl.c
M src/openvpn/push.c
M src/openvpn/ssl.c
M src/openvpn/ssl.h
M src/openvpn/ssl_backend.h
M src/openvpn/ssl_common.h
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_mbedtls.h
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_ncp.h
M src/openvpn/ssl_openssl.c
M src/openvpn/ssl_openssl.h
M src/openvpn/ssl_pkt.h
M src/openvpn/ssl_util.h
M src/openvpn/ssl_verify.c
M src/openvpn/ssl_verify.h
M src/openvpn/ssl_verify_backend.h
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/ssl_verify_mbedtls.h
M src/openvpn/ssl_verify_openssl.c
M src/openvpn/ssl_verify_openssl.h
M src/openvpn/tls_crypt.h
M src/openvpn/tun.c
M src/openvpn/tun.h
M src/tapctl/tap.c
49 files changed, 152 insertions(+), 117 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/778/1

diff --git a/doc/doxygen/doc_compression.h b/doc/doxygen/doc_compression.h
index f67eba3..c5678be 100644
--- a/doc/doxygen/doc_compression.h
+++ b/doc/doxygen/doc_compression.h
@@ -23,7 +23,8 @@
  */

 /**
- * @file Data Channel Compression module documentation file.
+ * @file
+ * Data Channel Compression module documentation file.
  */

 /**
diff --git a/doc/doxygen/doc_protocol_overview.h b/doc/doxygen/doc_protocol=
_overview.h
index 37de1cb..65a9c85 100644
--- a/doc/doxygen/doc_protocol_overview.h
+++ b/doc/doxygen/doc_protocol_overview.h
@@ -23,7 +23,8 @@
  */

 /**
- * @file Network protocol overview documentation file.
+ * @file
+ * Network protocol overview documentation file.
  */

 /**
diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/=
simple/base64.c
index daafc41..291f9e1 100644
--- a/sample/sample-plugins/simple/base64.c
+++ b/sample/sample-plugins/simple/base64.c
@@ -44,7 +44,7 @@
  * returns, any returned pointers are invalid.
  *
  * @param name  String containing the env.var name to search for
- * @param envp  String array pointer to the environment variable
+ * @param envp  String array pointer to the environment variables
  *
  * @return Returns a pointer to the value in the environment variable
  *         table on successful match.  Otherwise NULL is returned
@@ -138,10 +138,11 @@
  * For the arguments, see the include/openvpn-plugin.h file
  * for details on the function parameters
  *
- * @param args        Pointer to a struct with details about the plug-in
- *                    call from the main OpenVPN process.
- * @param returndata  Pointer to a struct where the plug-in can provide
- *                    information back to OpenVPN to be processed
+ * @param handle   Pointer to the plug-in global context buffer, which
+ *                 need to be released by this function
+ * @param type     Type of the hook
+ * @param argv     String array pointer to arguments for the hook
+ * @param envp     String array pointer to current environment variables
  *
  * @return  Must return OPENVPN_PLUGIN_FUNC_SUCCESS or
  *          OPENVPN_PLUGIN_FUNC_DEFERRED on success.  Otherwise it
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index b87a42f..2ece991 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -42,7 +42,7 @@
  *  Resizes the list of arguments struct argv can carry.  This resize
  *  operation will only increase the size, never decrease the size.
  *
- *  @param *a      Valid pointer to a struct argv to resize
+ *  @param a       Valid pointer to a struct argv to resize
  *  @param newcap  size_t with the new size of the argument list.
  */
 static void
@@ -66,7 +66,7 @@
  *  Initialise an already allocated struct argv.
  *  It is expected that the input argument is a valid pointer.
  *
- *  @param *a  Pointer to a struct argv to initialise
+ *  @param a  Pointer to a struct argv to initialise
  */
 static void
 argv_init(struct argv *a)
@@ -96,7 +96,7 @@
  *  Frees all memory allocations allocated by the struct argv
  *  related functions.
  *
- *  @param *a  Valid pointer to a struct argv to release memory from
+ *  @param a  Valid pointer to a struct argv to release memory from
  */
 void
 argv_free(struct argv *a)
@@ -108,7 +108,7 @@
  *  Resets the struct argv to an initial state.  No memory buffers
  *  will be released by this call.
  *
- *  @param *a      Valid pointer to a struct argv to resize
+ *  @param a      Valid pointer to a struct argv to resize
  */
 static void
 argv_reset(struct argv *a)
@@ -133,7 +133,7 @@
  *  This approach ensures that the list does grow bulks and only when the
  *  current limit is reached.
  *
- *  @param *a   Valid pointer to the struct argv to extend
+ *  @param a    Valid pointer to the struct argv to extend
  *  @param add  size_t with the number of elements to add.
  *
  */
@@ -150,9 +150,9 @@
  *  This will ensure the list size in struct argv has the needed capacity =
to
  *  store the value.
  *
- *  @param *a    struct argv where to append the new string value
- *  @param *str  Pointer to string to append.  The provided string *MUST* =
have
- *               been malloc()ed or NULL.
+ *  @param a    struct argv where to append the new string value
+ *  @param str  Pointer to string to append.  The provided string *MUST* h=
ave
+ *              been malloc()ed or NULL.
  */
 static void
 argv_append(struct argv *a, char *str)
@@ -167,7 +167,7 @@
  *  values being copied from the source input.
  *
  *
- *  @param *source   Valid pointer to the source struct argv to clone.  It=
 may
+ *  @param source    Valid pointer to the source struct argv to clone.  It=
 may
  *                   be NULL.
  *  @param headroom  Number of slots to leave empty in front of the slots
  *                   copied from the source.
@@ -199,8 +199,8 @@
 /**
  *  Inserts an argument string in front of all other argument slots.
  *
- *  @param  *a     Valid pointer to the struct argv to insert the argument=
 into
- *  @param  *head  Pointer to the char * string with the argument to insert
+ *  @param  a     Valid pointer to the struct argv to insert the argument =
into
+ *  @param  head  Pointer to the string with the argument to insert
  *
  *  @returns Returns a new struct argv with the inserted argument in front
  */
@@ -217,8 +217,8 @@
  *  Generate a single string with all the arguments in a struct argv
  *  concatenated.
  *
- *  @param *a    Valid pointer to the struct argv with the arguments to li=
st
- *  @param *gc   Pointer to a struct gc_arena managed buffer
+ *  @param a     Valid pointer to the struct argv with the arguments to li=
st
+ *  @param gc    Pointer to a struct gc_arena managed buffer
  *  @param flags Flags passed to the print_argv() function.
  *
  *  @returns Returns a string generated by print_argv() with all the argum=
ents
@@ -237,7 +237,7 @@
  *  Write the arguments stored in a struct argv via the msg() command.
  *
  *  @param msglev  Integer with the message level used by msg().
- *  @param *a      Valid pointer to the struct argv with the arguments to =
write.
+ *  @param a       Valid pointer to the struct argv with the arguments to =
write.
  */
 void
 argv_msg(const int msglev, const struct argv *a)
@@ -251,9 +251,9 @@
  *  Similar to argv_msg() but prefixes the messages being written with a
  *  given string.
  *
- *  @param msglev   Integer with the message level used by msg().
- *  @param *a       Valid pointer to the struct argv with the arguments to=
 write
- *  @param *prefix  Valid char * pointer to the prefix string
+ *  @param msglev  Integer with the message level used by msg().
+ *  @param a       Valid pointer to the struct argv with the arguments to =
write
+ *  @param prefix  Valid pointer to the prefix string
  *
  */
 void
@@ -272,13 +272,13 @@
  *  format string, with space replaced by delim and adds the number of
  *  arguments to the count parameter.
  *
- *  @param *format  Pointer to a the format string to process
- *  @param delim    Char with the delimiter to use
- *  @param *count   size_t pointer used to return the number of
- *                  tokens (argument slots) found in the format string.
- *  @param *gc      Pointer to a gc_arena managed buffer.
+ *  @param format  Pointer to a the format string to process
+ *  @param delim   Char with the delimiter to use
+ *  @param count   size_t pointer used to return the number of
+ *                 tokens (argument slots) found in the format string.
+ *  @param gc      Pointer to a gc_arena managed buffer.
  *
- *  @returns Returns a parsed format string (char *), together with the
+ *  @returns Returns a parsed format string, together with the
  *           number of tokens parts found (via *count).  The result string
  *           is allocated within the gc_arena managed buffer.  If the
  *           gc_arena pointer is NULL, the returned string must be explici=
tly
@@ -332,11 +332,11 @@
  *  argv_prep_format() before we let libc's printf() do the parsing.
  *  Then split the resulting string at the injected delimiters.
  *
- *  @param *argres  Valid pointer to a struct argv where the resulting par=
sed
- *                  arguments, based on the format string.
- *  @param *format  Char* string with a printf() compliant format string
- *  @param arglist  A va_list with the arguments to be consumed by the for=
mat
- *                  string
+ *  @param argres  Valid pointer to a struct argv where the resulting pars=
ed
+ *                 arguments, based on the format string.
+ *  @param format  Char string with a printf() compliant format string
+ *  @param arglist A va_list with the arguments to be consumed by the form=
at
+ *                 string
  *
  *  @returns Returns true if the parsing and processing was successfully. =
 If
  *           the resulting number of arguments does not match the expected
@@ -429,8 +429,8 @@
  *  This will always reset and ensure the result is based on a pristine
  *  struct argv.
  *
- *  @param *argres  Valid pointer to a struct argv where the result will b=
e put.
- *  @param *format  printf() compliant (char *) format string.
+ *  @param argres  Valid pointer to a struct argv where the result will be=
 put.
+ *  @param format  printf() compliant format string.
  *
  *  @returns Returns true if the parsing was successful.  See
  *           argv_printf_arglist() for more details.  The parsed result wi=
ll
@@ -453,8 +453,8 @@
  *  struct argv and populets the argument slots based on the printf() based
  *  format string.
  *
- *  @param *argres  Valid pointer to a struct argv where the result will b=
e put.
- *  @param *format  printf() compliant (char *) format string.
+ *  @param argres  Valid pointer to a struct argv where the result will be=
 put.
+ *  @param format  printf() compliant format string.
  *
  *  @returns Returns true if the parsing was successful.  See
  *           argv_printf_arglist() for more details.  The parsed result wi=
ll
@@ -474,9 +474,9 @@
  *  Parses a command string, tokenizes it and puts each element into a sep=
arate
  *  struct argv argument slot.
  *
- *  @params *argres  Valid pointer to a struct argv where the parsed result
- *                   will be found.
- *  @params *cmdstr  Char * based string to parse
+ *  @param argres  Valid pointer to a struct argv where the parsed result
+ *                 will be found.
+ *  @param cmdstr  Char based string to parse
  *
  */
 void
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 8a40010..235b150 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -1223,7 +1223,7 @@
 /**
  * buffer_read_from_file - copy the content of a file into a buffer
  *
- * @param file      path to the file to read
+ * @param filename  path to the file to read
  * @param gc        the garbage collector to use when allocating the buffe=
r. It
  *                  is passed to alloc_buf_gc() and therefore can be NULL.
  *
diff --git a/src/openvpn/console.h b/src/openvpn/console.h
index 72ae8e0..81876d3 100644
--- a/src/openvpn/console.h
+++ b/src/openvpn/console.h
@@ -112,7 +112,7 @@


 /**
- * A plain "make Gert happy" wrapper.  Same arguments as @query_user_add
+ * A plain "make Gert happy" wrapper.  Same arguments as query_user_add()
  *
  * FIXME/TODO: Remove this when refactoring the complete user query process
  *             to be called at start-up initialization of OpenVPN.
diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 6af7a3e..cb4cb16 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -166,7 +166,7 @@
 /**
  * Closes the TTY FILE pointer, but only if it is not a stdin/stderr FILE =
object.
  *
- * @params fp     FILE pointer to close
+ * @param fp     FILE pointer to close
  *
  */
 static void
@@ -184,10 +184,10 @@
 /**
  *  Core function for getting input from console
  *
- *  @params prompt    The prompt to present to the user
- *  @params echo      Should the user see what is being typed
- *  @params input     Pointer to the buffer used to save the user input
- *  @params capacity  Size of the input buffer
+ *  @param prompt    The prompt to present to the user
+ *  @param echo      Should the user see what is being typed
+ *  @param input     Pointer to the buffer used to save the user input
+ *  @param capacity  Size of the input buffer
  *
  *  @returns Returns True if user input was gathered
  */
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index cc91cd1..858504d 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -23,7 +23,8 @@
  */

 /**
- * @file Alternative method to query for user input, using systemd
+ * @file
+ * Alternative method to query for user input, using systemd
  *
  */

diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 61184bc..3995069 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -23,7 +23,8 @@
  */

 /**
- * @file Data Channel Cryptography Module
+ * @file
+ * Data Channel Cryptography Module
  *
  * @addtogroup data_crypto Data Channel Crypto module
  *
@@ -441,7 +442,7 @@
  * this and add it themselves.
  *
  * @param kt            Struct with the crypto algorithm to use
- * @param packet_id_size Size of the packet id
+ * @param pkt_id_size   Size of the packet id
  * @param occ           if true calculates the overhead for crypto in the =
same
  *                      incorrect way as all previous OpenVPN versions did=
, to
  *                      end up with identical numbers for OCC compatibility
@@ -459,7 +460,7 @@
  * and write to file.
  *
  * @param filename          Filename of the server key file to create.
- * @param pem_name          The name to use in the PEM header/footer.
+ * @param key_name          The name to use in the PEM header/footer.
  */
 void
 write_pem_key_file(const char *filename, const char *key_name);
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index c454c64..6371013 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -23,7 +23,8 @@
  */

 /**
- * @file Data Channel Cryptography SSL library-specific backend interface
+ * @file
+ * Data Channel Cryptography SSL library-specific backend interface
  */

 #ifndef CRYPTO_BACKEND_H_
@@ -339,7 +340,7 @@
  *                      \c OPENVPN_OP_ENCRYPT or \c OPENVPN_OP_DECRYPT).
  */
 void cipher_ctx_init(cipher_ctx_t *ctx, const uint8_t *key,
-                     const char *cipername, crypto_operation_t enc);
+                     const char *ciphername, crypto_operation_t enc);

 /**
  * Returns the size of the IV used by the cipher, in bytes, or 0 if no IV =
is
@@ -357,7 +358,7 @@
  *
  * @param ctx           The cipher's context
  * @param tag           The buffer to write computed tag in.
- * @param tag_size      The tag buffer size, in bytes.
+ * @param tag_len       The tag buffer size, in bytes.
  */
 int cipher_ctx_get_tag(cipher_ctx_t *ctx, uint8_t *tag, int tag_len);

diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 32511f0..2696330 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -23,7 +23,8 @@
  */

 /**
- * @file Data Channel Cryptography mbed TLS-specific backend interface
+ * @file
+ * Data Channel Cryptography mbed TLS-specific backend interface
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 48d1e20..e37f25f 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -23,7 +23,8 @@
  */

 /**
- * @file Data Channel Cryptography mbed TLS-specific backend interface
+ * @file
+ * Data Channel Cryptography mbed TLS-specific backend interface
  */

 #ifndef CRYPTO_MBEDTLS_H_
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index fbd38f3..914b1c4 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -23,7 +23,8 @@
  */

 /**
- * @file Data Channel Cryptography OpenSSL-specific backend interface
+ * @file
+ * Data Channel Cryptography OpenSSL-specific backend interface
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 4cd988a..004176a 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -23,7 +23,8 @@
  */

 /**
- * @file Data Channel Cryptography OpenSSL-specific backend interface
+ * @file
+ * Data Channel Cryptography OpenSSL-specific backend interface
  */

 #ifndef CRYPTO_OPENSSL_H_
@@ -111,8 +112,7 @@
  * This is just a convenience wrapper for often occurring situations.
  *
  * @param flags         Flags to indicate error type and priority.
- * @param format        Format string to print.
- * @param format args   (optional) arguments for the format string.
+ * @param ...           Format string and optional format arguments
  */
 #define crypto_msg(flags, ...) \
     do { \
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 0539ca5..6cb15d1 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -34,7 +34,7 @@
  * Parses a string as port and stores it
  *
  * @param   port        Pointer to in_port_t where the port value is stored
- * @param   addr        Port number as string
+ * @param   port_str    Port number as string
  * @return              True if parsing was successful
  */
 static bool
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 422c591..0e2bded 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -85,11 +85,11 @@
  * - Check that the client authentication has succeeded; if not, drop the
  *   packet.
  * - If the \a comp_frag argument is true:
- *   - Call \c lzo_compress() of the \link Data Channel Compression
+ *   - Call \c lzo_compress() of the \link compression Data Channel Compre=
ssion
  *     module\endlink to (possibly) compress the packet.
- *   - Call \c fragment_outgoing() of the \link Data Channel Fragmentation
+ *   - Call \c fragment_outgoing() of the \link fragmentation Data Channel=
 Fragmentation
  *     module\endlink to (possibly) fragment the packet.
- * - Activate the \link Data Channel Crypto module\endlink to perform
+ * - Activate the \link data_crypto Data Channel Crypto module\endlink to =
perform
  *   security operations on the packet.
  *   - Call \c tls_pre_encrypt() to choose the appropriate security
  *     parameters for this packet.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ae911a9..be66a02 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -294,8 +294,8 @@
  *
  * This will write the control message
  *
- *  command parm1,parm2,..
- *  .
+ *  command parm1,parm2,...
+ *
  * to the control channel.
  *
  * @param arg           The context struct
@@ -2280,7 +2280,7 @@

 /**
  * Prints the results of options imported for the data channel
- * @param o
+ * @param c
  */
 static void
 tls_print_deferred_options_results(struct context *c)
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index bab2d78..f8337f1 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -22,7 +22,8 @@
  */

 /**
- * @file Data Channel Compression module function definitions.
+ * @file
+ * Data Channel Compression module function definitions.
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 05b5a1a..c7ccee8 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1240,6 +1240,7 @@
  * Checks if the correct number of arguments to a management command are p=
resent
  * and otherwise prints an error and returns false.
  *
+ * @param man       The management interface struct
  * @param p         pointer to the parameter array
  * @param n         number of arguments required
  * @param flags     if MN_AT_LEAST require at least n parameters and not e=
xactly n
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index 8559c2e..145a7ae 100644
--- a/src/openvpn/mbedtls_compat.h
+++ b/src/openvpn/mbedtls_compat.h
@@ -22,8 +22,8 @@
  */

 /**
- * @file mbedtls compatibility stub
- *
+ * @file
+ * mbedtls compatibility stub.
  * This file provide compatibility stubs for the mbedtls libraries
  * prior to version 3. This version made most fields in structs private
  * and requires accessor functions to be used. For earlier versions, we
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 7167639..20940a3 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -22,7 +22,8 @@
  */

 /**
- * @file Header file for server-mode related structures and functions.
+ * @file
+ * Header file for server-mode related structures and functions.
  */

 #ifndef MULTI_H
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 95417b2..89f22d1 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -23,7 +23,8 @@
  */

 /**
- * @file OpenSSL compatibility stub
+ * @file
+ * OpenSSL compatibility stub
  *
  * This file provide compatibility stubs for the OpenSSL libraries
  * prior to version 1.1. This version introduces many changes in the
diff --git a/src/openvpn/pkcs11_backend.h b/src/openvpn/pkcs11_backend.h
index df5259f..6a67a7f 100644
--- a/src/openvpn/pkcs11_backend.h
+++ b/src/openvpn/pkcs11_backend.h
@@ -23,7 +23,8 @@
  */

 /**
- * @file PKCS #11 SSL library-specific backend
+ * @file
+ * PKCS #11 SSL library-specific backend
  */

 #ifndef PKCS11_BACKEND_H_
diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/openvpn/pkcs11_mbedtls.c
index 2f1b1ac..0a930f9 100644
--- a/src/openvpn/pkcs11_mbedtls.c
+++ b/src/openvpn/pkcs11_mbedtls.c
@@ -23,7 +23,8 @@
  */

 /**
- * @file PKCS #11 mbed TLS backend
+ * @file
+ * PKCS #11 mbed TLS backend
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index a013b3f..9382049 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -23,7 +23,8 @@
  */

 /**
- * @file PKCS #11 OpenSSL backend
+ * @file
+ * PKCS #11 OpenSSL backend
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 6c06374..de44eb2 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -604,7 +604,7 @@
 /**
  * Prepare push options, based on local options
  *
- * @param context       context structure storing data for VPN tunnel
+ * @param c             context structure storing data for VPN tunnel
  * @param gc            gc arena for allocating push options
  * @param push_list     push list to where options are added
  *
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e2be614..eb7afcc 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -24,7 +24,8 @@
  */

 /**
- * @file Control Channel SSL/Data channel negotiation Module
+ * @file
+ * Control Channel SSL/Data channel negotiation Module
  */

 /*
@@ -113,7 +114,7 @@
 /**
  * Limit the reneg_bytes value when using a small-block (<128 bytes) ciphe=
r.
  *
- * @param cipher        The current cipher (may be NULL).
+ * @param ciphername    The current cipher (may be NULL).
  * @param reneg_bytes   Pointer to the current reneg_bytes, updated if nee=
ded.
  *                      May *not* be NULL.
  */
@@ -454,10 +455,10 @@
  * - the CRL file was passed inline
  * - the CRL file was not modified since the last (re)load
  *
- * @param ssl_ctx       The TLS context to use when reloading the CRL
- * @param crl_file      The file name to load the CRL from, or
- *                      "[[INLINE]]" in the case of inline files.
- * @param crl_inline    A string containing the CRL
+ * @param ssl_ctx         The TLS context to use when reloading the CRL
+ * @param crl_file        The file name to load the CRL from, or
+ *                        or an array containing the inline CRL.
+ * @param crl_file_inline True if crl_file is an inline CRL.
  */
 static void
 tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx, const char *crl_file,
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index eea1323..3561c41 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -23,7 +23,8 @@
  */

 /**
- * @file Control Channel SSL/Data channel negotiation module
+ * @file
+ * Control Channel SSL/Data channel negotiation module
  */

 #ifndef OPENVPN_SSL_H
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 285705f..a6a9695 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -23,7 +23,8 @@
  */

 /**
- * @file Control Channel SSL library backend module
+ * @file
+ * Control Channel SSL library backend module
  */


@@ -252,7 +253,7 @@
  * context.
  *
  * @param ctx                   TLS context to use
- * @param crypto_api_cert       String representing the certificate to loa=
d.
+ * @param cryptoapi_cert       String representing the certificate to load.
  */
 #ifdef ENABLE_CRYPTOAPI
 void tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoap=
i_cert);
@@ -506,7 +507,6 @@
  * @param ks_ssl       - The security parameter state for this %key
  *                       session.
  * @param buf          - A buffer in which to store the plaintext.
- * @param maxlen       - The maximum number of bytes to extract.
  *
  * @return The return value indicates whether the data was successfully
  *     processed:
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 5bc2f2a..421ced1 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -23,7 +23,8 @@
  */

 /**
- * @file Control Channel Common Data Structures
+ * @file
+ * Control Channel Common Data Structures
  */

 #ifndef SSL_COMMON_H_
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index bb88da9..56eef36 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -24,7 +24,8 @@
  */

 /**
- * @file Control Channel mbed TLS Backend
+ * @file
+ * Control Channel mbed TLS Backend
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 34b4f02..ec30bb5 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -23,7 +23,8 @@
  */

 /**
- * @file Control Channel mbed TLS Backend
+ * @file
+ * Control Channel mbed TLS Backend
  */

 #ifndef SSL_MBEDTLS_H_
@@ -67,9 +68,9 @@
  *
  * @param sign_ctx  The context for the signing function.
  * @param src       The data to be signed,
- * @param src_len   The length of src, in bytes.
+ * @param src_size  The length of src, in bytes.
  * @param dst       The destination buffer for the signature.
- * @param dst_len   The length of the destination buffer.
+ * @param dst_size  The length of the destination buffer.
  *
  * @return true if signing succeeded, false otherwise.
  */
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 968858e..167bdb2 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -24,7 +24,8 @@
  */

 /**
- * @file Control Channel SSL/Data dynamic negotiation Module
+ * @file
+ * Control Channel SSL/Data dynamic negotiation Module
  * This file is split from ssl.c to be able to unit test it.
  */

diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index afbe331..0bdb6a0 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -23,7 +23,8 @@
  */

 /**
- * @file Control Channel SSL/Data dynamic negotiation Module
+ * @file
+ * Control Channel SSL/Data dynamic negotiation Module
  * This file is split from ssl.h to be able to unit test it.
  */

@@ -90,7 +91,7 @@
  * Check whether the ciphers in the supplied list are supported.
  *
  * @param list          Colon-separated list of ciphers
- * @parms gc            gc_arena to allocate the returned string
+ * @param gc            gc_arena to allocate the returned string
  *
  * @returns             colon separated string of normalised (via
  *                      translate_cipher_name_from_openvpn) and
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 5fd6572..98eba9d 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -23,7 +23,8 @@
  */

 /**
- * @file Control Channel OpenSSL Backend
+ * @file
+ * Control Channel OpenSSL Backend
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/ssl_openssl.h b/src/openvpn/ssl_openssl.h
index cf00478..222dd4f 100644
--- a/src/openvpn/ssl_openssl.h
+++ b/src/openvpn/ssl_openssl.h
@@ -23,7 +23,8 @@
  */

 /**
- * @file Control Channel OpenSSL Backend
+ * @file
+ * Control Channel OpenSSL Backend
  */

 #ifndef SSL_OPENSSL_H_
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index c8a27fb..b2c4b37 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -22,9 +22,10 @@
  */

 /**
- * @file SSL control channel wrap/unwrap and decode functions. This file
- *        (and its .c file) is designed to to be included in units/etc wit=
hout
- *        pulling in a lot of dependencies
+ * @file
+ * SSL control channel wrap/unwrap and decode functions.
+ * This file (and its .c file) is designed to to be included in units/etc =
without
+ * pulling in a lot of dependencies.
  */

 #ifndef SSL_PKT_H
@@ -182,7 +183,7 @@
 /**
  * Checks if a control packet has a correct HMAC server session id
  *
- * @param client_sid    session id of the client
+ * @param state         session information
  * @param from          link_socket from the client
  * @param hmac          the hmac context to use for the calculation
  * @param handwindow    the quantisation of the current time
diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h
index e858d64..71a37d4 100644
--- a/src/openvpn/ssl_util.h
+++ b/src/openvpn/ssl_util.h
@@ -22,8 +22,10 @@
  */

 /**
- * @file SSL utility function. This file (and its .c file) is designed to
- *       to be included in units/etc without pulling in a lot of dependenc=
ies
+ * @file
+ * SSL utility functions.
+ * This file (and its .c file) is designed to to be included in units/etc
+ * without pulling in a lot of dependencies.
  */

 #ifndef SSL_UTIL_H_
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 74b2775..4c4b58d 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -23,7 +23,8 @@
  */

 /**
- * @file Control Channel Verification Module
+ * @file
+ * Control Channel Verification Module
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 7012f41..cd2ec24 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -23,7 +23,8 @@
  */

 /**
- * @file Control Channel Verification Module
+ * @file
+ * Control Channel Verification Module
  */

 #ifndef SSL_VERIFY_H_
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_back=
end.h
index 550b3c3..3c80324 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -23,7 +23,8 @@
  */

 /**
- * @file Control Channel Verification Module library-specific backend inte=
rface
+ * @file
+ * Control Channel Verification Module library-specific backend interface
  */

 #ifndef SSL_VERIFY_BACKEND_H_
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index ca14ceb..7b387ec 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -23,7 +23,8 @@
  */

 /**
- * @file Control Channel Verification Module mbed TLS backend
+ * @file
+ * Control Channel Verification Module mbed TLS backend
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbed=
tls.h
index d2ba6b6..300b2f5 100644
--- a/src/openvpn/ssl_verify_mbedtls.h
+++ b/src/openvpn/ssl_verify_mbedtls.h
@@ -23,7 +23,8 @@
  */

 /**
- * @file Control Channel Verification Module mbed TLS backend
+ * @file
+ * Control Channel Verification Module mbed TLS backend
  */

 #ifndef SSL_VERIFY_MBEDTLS_H_
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 7d41d4a..ce1e7da 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -23,7 +23,8 @@
  */

 /**
- * @file Control Channel Verification Module OpenSSL implementation
+ * @file
+ * Control Channel Verification Module OpenSSL implementation
  */

 #ifdef HAVE_CONFIG_H
diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_open=
ssl.h
index a73b810..c31daa3 100644
--- a/src/openvpn/ssl_verify_openssl.h
+++ b/src/openvpn/ssl_verify_openssl.h
@@ -23,7 +23,8 @@
  */

 /**
- * @file Control Channel Verification Module OpenSSL backend
+ * @file
+ * Control Channel Verification Module OpenSSL backend
  */


diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index 8c87e20..ffb1f2a 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -167,8 +167,8 @@
 /**
  * Initialize a tls-crypt-v2 server key (used to encrypt/decrypt client ke=
ys).
  *
- * @param key           Key structure to be initialized.  Must be non-NULL.
- * @parem encrypt       If true, initialize the key structure for encrypti=
on,
+ * @param key_ctx       Key structure to be initialized.  Must be non-NULL.
+ * @param encrypt       If true, initialize the key structure for encrypti=
on,
  *                      otherwise for decryption.
  * @param key_file      File path of the key file to load or the key itsel=
f if
  *                      key_inline is true.
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 85fe01a..b39dae1 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1104,7 +1104,7 @@
  *
  * @param tt        the tuntap interface context
  * @param ifname    the human readable interface name
- * @param mtu       the MTU value to set the interface to
+ * @param tun_mtu   the MTU value to set the interface to
  * @param es        the environment to be used when executing the commands
  * @param ctx       the networking API opaque context
  */
@@ -1303,7 +1303,7 @@
  *
  * @param tt        the tuntap interface context
  * @param ifname    the human readable interface name
- * @param mtu       the MTU value to set the interface to
+ * @param tun_mtu   the MTU value to set the interface to
  * @param es        the environment to be used when executing the commands
  * @param ctx       the networking API opaque context
  */
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 329cd10..ccba0bc 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -330,7 +330,7 @@
  *
  * @param tt        the tuntap interface context
  * @param ifname    the human readable interface name
- * @param mtu       the MTU value to set the interface to
+ * @param tun_mtu   the MTU value to set the interface to
  * @param es        the environment to be used when executing the commands
  * @param ctx       the networking API opaque context
  */
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 2e53596..4dde2e6 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -632,7 +632,7 @@
  * @param dwProperty     Specifies the property to be retrieved. See
  *                       https://msdn.microsoft.com/en-us/library/windows/=
hardware/ff551967.aspx
  *
- * @pdwPropertyRegDataType  A pointer to a variable that receives the data=
 type of the
+ * @param pdwPropertyRegDataType  A pointer to a variable that receives th=
e data type of the
  *                       property that is being retrieved. This is one of =
the standard
  *                       registry data types. This parameter is optional a=
nd can be NULL.
  *

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/778?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7a852eb5fafae3a0e85dd89ea6d4c91fcf2fab4e
Gerrit-Change-Number: 778
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--ANCM1oz97Sw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/778?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Review doxygen warnings<br><br>We write doxygen comments but =
we do not verify them. So<br>quite some errors have crept in. Trying to red=
uce them<br>by reviewing the warnings output of doxygen and addressing<br>m=
ost of them.<br><br>Did generally ignore &quot;The following parameter is n=
ot documented&quot;<br>warnings (except those caused by typos). Fixing thos=
e will<br>require more work.<br><br>Usual errors fixed:<br> - Wrong usage o=
f @file<br> - Wrong spellings of @param<br> - Desync between function decla=
ration and comment<br>   (usually param names)<br><br>Change-Id: I7a852eb5f=
afae3a0e85dd89ea6d4c91fcf2fab4e<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@...2641...&gt;<br>---<br>M doc/doxygen/doc_compression.h<br>M doc/doxyge=
n/doc_protocol_overview.h<br>M sample/sample-plugins/simple/base64.c<br>M s=
rc/openvpn/argv.c<br>M src/openvpn/buffer.h<br>M src/openvpn/console.h<br>M=
 src/openvpn/console_builtin.c<br>M src/openvpn/console_systemd.c<br>M src/=
openvpn/crypto.h<br>M src/openvpn/crypto_backend.h<br>M src/openvpn/crypto_=
mbedtls.c<br>M src/openvpn/crypto_mbedtls.h<br>M src/openvpn/crypto_openssl=
.c<br>M src/openvpn/crypto_openssl.h<br>M src/openvpn/dns.c<br>M src/openvp=
n/forward.h<br>M src/openvpn/init.c<br>M src/openvpn/lzo.c<br>M src/openvpn=
/manage.c<br>M src/openvpn/mbedtls_compat.h<br>M src/openvpn/multi.h<br>M s=
rc/openvpn/openssl_compat.h<br>M src/openvpn/pkcs11_backend.h<br>M src/open=
vpn/pkcs11_mbedtls.c<br>M src/openvpn/pkcs11_openssl.c<br>M src/openvpn/pus=
h.c<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl.h<br>M src/openvpn/ssl_back=
end.h<br>M src/openvpn/ssl_common.h<br>M src/openvpn/ssl_mbedtls.c<br>M src=
/openvpn/ssl_mbedtls.h<br>M src/openvpn/ssl_ncp.c<br>M src/openvpn/ssl_ncp.=
h<br>M src/openvpn/ssl_openssl.c<br>M src/openvpn/ssl_openssl.h<br>M src/op=
envpn/ssl_pkt.h<br>M src/openvpn/ssl_util.h<br>M src/openvpn/ssl_verify.c<b=
r>M src/openvpn/ssl_verify.h<br>M src/openvpn/ssl_verify_backend.h<br>M src=
/openvpn/ssl_verify_mbedtls.c<br>M src/openvpn/ssl_verify_mbedtls.h<br>M sr=
c/openvpn/ssl_verify_openssl.c<br>M src/openvpn/ssl_verify_openssl.h<br>M s=
rc/openvpn/tls_crypt.h<br>M src/openvpn/tun.c<br>M src/openvpn/tun.h<br>M s=
rc/tapctl/tap.c<br>49 files changed, 152 insertions(+), 117 deletions(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/78/778=
/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/doc/doxygen/doc_compression.h b/doc/doxygen/doc_com=
pression.h</span><br><span>index f67eba3..c5678be 100644</span><br><span>--=
- a/doc/doxygen/doc_compression.h</span><br><span>+++ b/doc/doxygen/doc_com=
pression.h</span><br><span>@@ -23,7 +23,8 @@</span><br><span>  */</span><br=
><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * @file Data Channel Compression module documentation file.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Data Channel Compression module do=
cumentation file.</span><br><span>  */</span><br><span> </span><br><span> /=
**</span><br><span>diff --git a/doc/doxygen/doc_protocol_overview.h b/doc/d=
oxygen/doc_protocol_overview.h</span><br><span>index 37de1cb..65a9c85 10064=
4</span><br><span>--- a/doc/doxygen/doc_protocol_overview.h</span><br><span=
>+++ b/doc/doxygen/doc_protocol_overview.h</span><br><span>@@ -23,7 +23,8 @=
@</span><br><span>  */</span><br><span> </span><br><span> /**</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * @file Network protocol overview =
documentation file.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Network =
protocol overview documentation file.</span><br><span>  */</span><br><span>=
 </span><br><span> /**</span><br><span>diff --git a/sample/sample-plugins/s=
imple/base64.c b/sample/sample-plugins/simple/base64.c</span><br><span>inde=
x daafc41..291f9e1 100644</span><br><span>--- a/sample/sample-plugins/simpl=
e/base64.c</span><br><span>+++ b/sample/sample-plugins/simple/base64.c</spa=
n><br><span>@@ -44,7 +44,7 @@</span><br><span>  * returns, any returned poi=
nters are invalid.</span><br><span>  *</span><br><span>  * @param name  Str=
ing containing the env.var name to search for</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * @param envp  String array pointer to the environ=
ment variable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram envp  String array pointer to the environment variables</span><br><span=
>  *</span><br><span>  * @return Returns a pointer to the value in the envi=
ronment variable</span><br><span>  *         table on successful match.  Ot=
herwise NULL is returned</span><br><span>@@ -138,10 +138,11 @@</span><br><s=
pan>  * For the arguments, see the include/openvpn-plugin.h file</span><br>=
<span>  * for details on the function parameters</span><br><span>  *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * @param args        Pointe=
r to a struct with details about the plug-in</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *                    call from the main OpenVPN pro=
cess.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param return=
data  Pointer to a struct where the plug-in can provide</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *                    information back to=
 OpenVPN to be processed</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param handle   Pointer to the plug-in global context buffer, which=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                 =
need to be released by this function</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param type     Type of the hook</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param argv     String array pointer t=
o arguments for the hook</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param envp     String array pointer to current environment variabl=
es</span><br><span>  *</span><br><span>  * @return  Must return OPENVPN_PLU=
GIN_FUNC_SUCCESS or</span><br><span>  *          OPENVPN_PLUGIN_FUNC_DEFERR=
ED on success.  Otherwise it</span><br><span>diff --git a/src/openvpn/argv.=
c b/src/openvpn/argv.c</span><br><span>index b87a42f..2ece991 100644</span>=
<br><span>--- a/src/openvpn/argv.c</span><br><span>+++ b/src/openvpn/argv.c=
</span><br><span>@@ -42,7 +42,7 @@</span><br><span>  *  Resizes the list of=
 arguments struct argv can carry.  This resize</span><br><span>  *  operati=
on will only increase the size, never decrease the size.</span><br><span>  =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  @param *a      V=
alid pointer to a struct argv to resize</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  @param a       Valid pointer to a struct argv to re=
size</span><br><span>  *  @param newcap  size_t with the new size of the ar=
gument list.</span><br><span>  */</span><br><span> static void</span><br><s=
pan>@@ -66,7 +66,7 @@</span><br><span>  *  Initialise an already allocated =
struct argv.</span><br><span>  *  It is expected that the input argument is=
 a valid pointer.</span><br><span>  *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- *  @param *a  Pointer to a struct argv to initialise</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @param a  Pointer to =
a struct argv to initialise</span><br><span>  */</span><br><span> static vo=
id</span><br><span> argv_init(struct argv *a)</span><br><span>@@ -96,7 +96,=
7 @@</span><br><span>  *  Frees all memory allocations allocated by the str=
uct argv</span><br><span>  *  related functions.</span><br><span>  *</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *  @param *a  Valid pointer=
 to a struct argv to release memory from</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  @param a  Valid pointer to a struct argv to releas=
e memory from</span><br><span>  */</span><br><span> void</span><br><span> a=
rgv_free(struct argv *a)</span><br><span>@@ -108,7 +108,7 @@</span><br><spa=
n>  *  Resets the struct argv to an initial state.  No memory buffers</span=
><br><span>  *  will be released by this call.</span><br><span>  *</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- *  @param *a      Valid point=
er to a struct argv to resize</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  @param a      Valid pointer to a struct argv to resize</span>=
<br><span>  */</span><br><span> static void</span><br><span> argv_reset(str=
uct argv *a)</span><br><span>@@ -133,7 +133,7 @@</span><br><span>  *  This =
approach ensures that the list does grow bulks and only when the</span><br>=
<span>  *  current limit is reached.</span><br><span>  *</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- *  @param *a   Valid pointer to the str=
uct argv to extend</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  @param a    Valid pointer to the struct argv to extend</span><br><span> =
 *  @param add  size_t with the number of elements to add.</span><br><span>=
  *</span><br><span>  */</span><br><span>@@ -150,9 +150,9 @@</span><br><spa=
n>  *  This will ensure the list size in struct argv has the needed capacit=
y to</span><br><span>  *  store the value.</span><br><span>  *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *  @param *a    struct argv where=
 to append the new string value</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- *  @param *str  Pointer to string to append.  The provided strin=
g *MUST* have</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *      =
         been malloc()ed or NULL.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  @param a    struct argv where to append the new string va=
lue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @param str  =
Pointer to string to append.  The provided string *MUST* have</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *              been malloc()ed o=
r NULL.</span><br><span>  */</span><br><span> static void</span><br><span> =
argv_append(struct argv *a, char *str)</span><br><span>@@ -167,7 +167,7 @@<=
/span><br><span>  *  values being copied from the source input.</span><br><=
span>  *</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *  @param *source   Valid pointer to the source struct argv to clon=
e.  It may</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @para=
m source    Valid pointer to the source struct argv to clone.  It may</span=
><br><span>  *                   be NULL.</span><br><span>  *  @param headr=
oom  Number of slots to leave empty in front of the slots</span><br><span> =
 *                   copied from the source.</span><br><span>@@ -199,8 +199=
,8 @@</span><br><span> /**</span><br><span>  *  Inserts an argument string =
in front of all other argument slots.</span><br><span>  *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *  @param  *a     Valid pointer to the=
 struct argv to insert the argument into</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  @param  *head  Pointer to the char * string with the=
 argument to insert</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  @param  a     Valid pointer to the struct argv to insert the argument i=
nto</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @param  head=
  Pointer to the string with the argument to insert</span><br><span>  *</sp=
an><br><span>  *  @returns Returns a new struct argv with the inserted argu=
ment in front</span><br><span>  */</span><br><span>@@ -217,8 +217,8 @@</spa=
n><br><span>  *  Generate a single string with all the arguments in a struc=
t argv</span><br><span>  *  concatenated.</span><br><span>  *</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *  @param *a    Valid pointer to t=
he struct argv with the arguments to list</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *  @param *gc   Pointer to a struct gc_arena managed b=
uffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @param a  =
   Valid pointer to the struct argv with the arguments to list</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  @param gc    Pointer to a st=
ruct gc_arena managed buffer</span><br><span>  *  @param flags Flags passed=
 to the print_argv() function.</span><br><span>  *</span><br><span>  *  @re=
turns Returns a string generated by print_argv() with all the arguments</sp=
an><br><span>@@ -237,7 +237,7 @@</span><br><span>  *  Write the arguments s=
tored in a struct argv via the msg() command.</span><br><span>  *</span><br=
><span>  *  @param msglev  Integer with the message level used by msg().</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *  @param *a      Valid=
 pointer to the struct argv with the arguments to write.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  @param a       Valid pointer to th=
e struct argv with the arguments to write.</span><br><span>  */</span><br><=
span> void</span><br><span> argv_msg(const int msglev, const struct argv *a=
)</span><br><span>@@ -251,9 +251,9 @@</span><br><span>  *  Similar to argv_=
msg() but prefixes the messages being written with a</span><br><span>  *  g=
iven string.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  @param msglev   Integer with the message level used by msg()=
.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  @param *a       =
Valid pointer to the struct argv with the arguments to write</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- *  @param *prefix  Valid char * poi=
nter to the prefix string</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  @param msglev  Integer with the message level used by msg().</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @param a       Valid=
 pointer to the struct argv with the arguments to write</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  @param prefix  Valid pointer to the=
 prefix string</span><br><span>  *</span><br><span>  */</span><br><span> vo=
id</span><br><span>@@ -272,13 +272,13 @@</span><br><span>  *  format string=
, with space replaced by delim and adds the number of</span><br><span>  *  =
arguments to the count parameter.</span><br><span>  *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  @param *format  Pointer to a the format=
 string to process</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 @param delim    Char with the delimiter to use</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- *  @param *count   size_t pointer used to return=
 the number of</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *     =
             tokens (argument slots) found in the format string.</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- *  @param *gc      Pointer to a=
 gc_arena managed buffer.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  @param format  Pointer to a the format string to process</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  @param delim   Char with=
 the delimiter to use</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  @param count   size_t pointer used to return the number of</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *                 tokens (arg=
ument slots) found in the format string.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  @param gc      Pointer to a gc_arena managed buffe=
r.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *  @returns Returns a parsed format string (char *), together with the</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @returns Returns a=
 parsed format string, together with the</span><br><span>  *           numb=
er of tokens parts found (via *count).  The result string</span><br><span> =
 *           is allocated within the gc_arena managed buffer.  If the</span=
><br><span>  *           gc_arena pointer is NULL, the returned string must=
 be explicitly</span><br><span>@@ -332,11 +332,11 @@</span><br><span>  *  a=
rgv_prep_format() before we let libc&#39;s printf() do the parsing.</span><=
br><span>  *  Then split the resulting string at the injected delimiters.</=
span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 @param *argres  Valid pointer to a struct argv where the resulting parsed<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *                  ar=
guments, based on the format string.</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *  @param *format  Char* string with a printf() compliant f=
ormat string</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  @para=
m arglist  A va_list with the arguments to be consumed by the format</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *                  string</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @param argres  Va=
lid pointer to a struct argv where the resulting parsed</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *                 arguments, based on =
the format string.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  @param format  Char string with a printf() compliant format string</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @param arglist A va_l=
ist with the arguments to be consumed by the format</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *                 string</span><br><span=
>  *</span><br><span>  *  @returns Returns true if the parsing and processi=
ng was successfully.  If</span><br><span>  *           the resulting number=
 of arguments does not match the expected</span><br><span>@@ -429,8 +429,8 =
@@</span><br><span>  *  This will always reset and ensure the result is bas=
ed on a pristine</span><br><span>  *  struct argv.</span><br><span>  *</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *  @param *argres  Valid =
pointer to a struct argv where the result will be put.</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *  @param *format  printf() compliant (ch=
ar *) format string.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  @param argres  Valid pointer to a struct argv where the result will be=
 put.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @param for=
mat  printf() compliant format string.</span><br><span>  *</span><br><span>=
  *  @returns Returns true if the parsing was successful.  See</span><br><s=
pan>  *           argv_printf_arglist() for more details.  The parsed resul=
t will</span><br><span>@@ -453,8 +453,8 @@</span><br><span>  *  struct argv=
 and populets the argument slots based on the printf() based</span><br><spa=
n>  *  format string.</span><br><span>  *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *  @param *argres  Valid pointer to a struct argv wher=
e the result will be put.</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *  @param *format  printf() compliant (char *) format string.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  @param argres  Valid poi=
nter to a struct argv where the result will be put.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  @param format  printf() compliant for=
mat string.</span><br><span>  *</span><br><span>  *  @returns Returns true =
if the parsing was successful.  See</span><br><span>  *           argv_prin=
tf_arglist() for more details.  The parsed result will</span><br><span>@@ -=
474,9 +474,9 @@</span><br><span>  *  Parses a command string, tokenizes it =
and puts each element into a separate</span><br><span>  *  struct argv argu=
ment slot.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- *  @params *argres  Valid pointer to a struct argv where the pars=
ed result</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *          =
         will be found.</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *  @params *cmdstr  Char * based string to parse</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  @param argres  Valid pointer to a str=
uct argv where the parsed result</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *                 will be found.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  @param cmdstr  Char based string to parse</s=
pan><br><span>  *</span><br><span>  */</span><br><span> void</span><br><spa=
n>diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h</span><br><span>=
index 8a40010..235b150 100644</span><br><span>--- a/src/openvpn/buffer.h</s=
pan><br><span>+++ b/src/openvpn/buffer.h</span><br><span>@@ -1223,7 +1223,7=
 @@</span><br><span> /**</span><br><span>  * buffer_read_from_file - copy t=
he content of a file into a buffer</span><br><span>  *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * @param file      path to the file to re=
ad</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param filenam=
e  path to the file to read</span><br><span>  * @param gc        the garbag=
e collector to use when allocating the buffer. It</span><br><span>  *      =
            is passed to alloc_buf_gc() and therefore can be NULL.</span><b=
r><span>  *</span><br><span>diff --git a/src/openvpn/console.h b/src/openvp=
n/console.h</span><br><span>index 72ae8e0..81876d3 100644</span><br><span>-=
-- a/src/openvpn/console.h</span><br><span>+++ b/src/openvpn/console.h</spa=
n><br><span>@@ -112,7 +112,7 @@</span><br><span> </span><br><span> </span><=
br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * A pla=
in &quot;make Gert happy&quot; wrapper.  Same arguments as @query_user_add<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A plain &quot;mak=
e Gert happy&quot; wrapper.  Same arguments as query_user_add()</span><br><=
span>  *</span><br><span>  * FIXME/TODO: Remove this when refactoring the c=
omplete user query process</span><br><span>  *             to be called at =
start-up initialization of OpenVPN.</span><br><span>diff --git a/src/openvp=
n/console_builtin.c b/src/openvpn/console_builtin.c</span><br><span>index 6=
af7a3e..cb4cb16 100644</span><br><span>--- a/src/openvpn/console_builtin.c<=
/span><br><span>+++ b/src/openvpn/console_builtin.c</span><br><span>@@ -166=
,7 +166,7 @@</span><br><span> /**</span><br><span>  * Closes the TTY FILE p=
ointer, but only if it is not a stdin/stderr FILE object.</span><br><span> =
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @params fp     F=
ILE pointer to close</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param fp     FILE pointer to close</span><br><span>  *</span><br><span=
>  */</span><br><span> static void</span><br><span>@@ -184,10 +184,10 @@</s=
pan><br><span> /**</span><br><span>  *  Core function for getting input fro=
m console</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *  @params prompt    The prompt to present to the user</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *  @params echo      Should the =
user see what is being typed</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *  @params input     Pointer to the buffer used to save the user in=
put</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  @params capaci=
ty  Size of the input buffer</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  @param prompt    The prompt to present to the user</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  @param echo      Should the=
 user see what is being typed</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  @param input     Pointer to the buffer used to save the user =
input</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @param cap=
acity  Size of the input buffer</span><br><span>  *</span><br><span>  *  @r=
eturns Returns True if user input was gathered</span><br><span>  */</span><=
br><span>diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_s=
ystemd.c</span><br><span>index cc91cd1..858504d 100644</span><br><span>--- =
a/src/openvpn/console_systemd.c</span><br><span>+++ b/src/openvpn/console_s=
ystemd.c</span><br><span>@@ -23,7 +23,8 @@</span><br><span>  */</span><br><=
span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * @file Alternative method to query for user input, using systemd</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Alternative method to query fo=
r user input, using systemd</span><br><span>  *</span><br><span>  */</span>=
<br><span> </span><br><span>diff --git a/src/openvpn/crypto.h b/src/openvpn=
/crypto.h</span><br><span>index 61184bc..3995069 100644</span><br><span>---=
 a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</span><b=
r><span>@@ -23,7 +23,8 @@</span><br><span>  */</span><br><span> </span><br>=
<span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @file Da=
ta Channel Cryptography Module</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Data Channel Cryptography Module</span><br><span>  *</span><br><span>  *=
 @addtogroup data_crypto Data Channel Crypto module</span><br><span>  *</sp=
an><br><span>@@ -441,7 +442,7 @@</span><br><span>  * this and add it themse=
lves.</span><br><span>  *</span><br><span>  * @param kt            Struct w=
ith the crypto algorithm to use</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * @param packet_id_size Size of the packet id</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param pkt_id_size   Size of the pa=
cket id</span><br><span>  * @param occ           if true calculates the ove=
rhead for crypto in the same</span><br><span>  *                      incor=
rect way as all previous OpenVPN versions did, to</span><br><span>  *      =
                end up with identical numbers for OCC compatibility</span><=
br><span>@@ -459,7 +460,7 @@</span><br><span>  * and write to file.</span><=
br><span>  *</span><br><span>  * @param filename          Filename of the s=
erver key file to create.</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * @param pem_name          The name to use in the PEM header/footer.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param key_name   =
       The name to use in the PEM header/footer.</span><br><span>  */</span=
><br><span> void</span><br><span> write_pem_key_file(const char *filename, =
const char *key_name);</span><br><span>diff --git a/src/openvpn/crypto_back=
end.h b/src/openvpn/crypto_backend.h</span><br><span>index c454c64..6371013=
 100644</span><br><span>--- a/src/openvpn/crypto_backend.h</span><br><span>=
+++ b/src/openvpn/crypto_backend.h</span><br><span>@@ -23,7 +23,8 @@</span>=
<br><span>  */</span><br><span> </span><br><span> /**</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @file Data Channel Cryptography SSL libr=
ary-specific backend interface</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Data Channel Cryptography SSL library-specific backend interface</span><=
br><span>  */</span><br><span> </span><br><span> #ifndef CRYPTO_BACKEND_H_<=
/span><br><span>@@ -339,7 +340,7 @@</span><br><span>  *                    =
  \c OPENVPN_OP_ENCRYPT or \c OPENVPN_OP_DECRYPT).</span><br><span>  */</sp=
an><br><span> void cipher_ctx_init(cipher_ctx_t *ctx, const uint8_t *key,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     co=
nst char *cipername, crypto_operation_t enc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                     const char *ciphername, cryp=
to_operation_t enc);</span><br><span> </span><br><span> /**</span><br><span=
>  * Returns the size of the IV used by the cipher, in bytes, or 0 if no IV=
 is</span><br><span>@@ -357,7 +358,7 @@</span><br><span>  *</span><br><span=
>  * @param ctx           The cipher&#39;s context</span><br><span>  * @par=
am tag           The buffer to write computed tag in.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param tag_size      The tag buffer size=
, in bytes.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m tag_len       The tag buffer size, in bytes.</span><br><span>  */</span><=
br><span> int cipher_ctx_get_tag(cipher_ctx_t *ctx, uint8_t *tag, int tag_l=
en);</span><br><span> </span><br><span>diff --git a/src/openvpn/crypto_mbed=
tls.c b/src/openvpn/crypto_mbedtls.c</span><br><span>index 32511f0..2696330=
 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls.c</span><br><span>=
+++ b/src/openvpn/crypto_mbedtls.c</span><br><span>@@ -23,7 +23,8 @@</span>=
<br><span>  */</span><br><span> </span><br><span> /**</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @file Data Channel Cryptography mbed TLS=
-specific backend interface</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Data Channel Cryptography mbed TLS-specific backend interface</span><br><sp=
an>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><=
span>diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls=
.h</span><br><span>index 48d1e20..e37f25f 100644</span><br><span>--- a/src/=
openvpn/crypto_mbedtls.h</span><br><span>+++ b/src/openvpn/crypto_mbedtls.h=
</span><br><span>@@ -23,7 +23,8 @@</span><br><span>  */</span><br><span> </=
span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 @file Data Channel Cryptography mbed TLS-specific backend interface</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Data Channel Cryptography mbed TLS=
-specific backend interface</span><br><span>  */</span><br><span> </span><b=
r><span> #ifndef CRYPTO_MBEDTLS_H_</span><br><span>diff --git a/src/openvpn=
/crypto_openssl.c b/src/openvpn/crypto_openssl.c</span><br><span>index fbd3=
8f3..914b1c4 100644</span><br><span>--- a/src/openvpn/crypto_openssl.c</spa=
n><br><span>+++ b/src/openvpn/crypto_openssl.c</span><br><span>@@ -23,7 +23=
,8 @@</span><br><span>  */</span><br><span> </span><br><span> /**</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * @file Data Channel Cryptogra=
phy OpenSSL-specific backend interface</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Data Channel Cryptography OpenSSL-specific backend interface</sp=
an><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</=
span><br><span>diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/cryp=
to_openssl.h</span><br><span>index 4cd988a..004176a 100644</span><br><span>=
--- a/src/openvpn/crypto_openssl.h</span><br><span>+++ b/src/openvpn/crypto=
_openssl.h</span><br><span>@@ -23,7 +23,8 @@</span><br><span>  */</span><br=
><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * @file Data Channel Cryptography OpenSSL-specific backend interfa=
ce</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Data Channel Cryptography=
 OpenSSL-specific backend interface</span><br><span>  */</span><br><span> <=
/span><br><span> #ifndef CRYPTO_OPENSSL_H_</span><br><span>@@ -111,8 +112,7=
 @@</span><br><span>  * This is just a convenience wrapper for often occurr=
ing situations.</span><br><span>  *</span><br><span>  * @param flags       =
  Flags to indicate error type and priority.</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * @param format        Format string to print.</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param format args   (o=
ptional) arguments for the format string.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param ...           Format string and optional fo=
rmat arguments</span><br><span>  */</span><br><span> #define crypto_msg(fla=
gs, ...) \</span><br><span>     do { \</span><br><span>diff --git a/src/ope=
nvpn/dns.c b/src/openvpn/dns.c</span><br><span>index 0539ca5..6cb15d1 10064=
4</span><br><span>--- a/src/openvpn/dns.c</span><br><span>+++ b/src/openvpn=
/dns.c</span><br><span>@@ -34,7 +34,7 @@</span><br><span>  * Parses a strin=
g as port and stores it</span><br><span>  *</span><br><span>  * @param   po=
rt        Pointer to in_port_t where the port value is stored</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * @param   addr        Port number=
 as string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
   port_str    Port number as string</span><br><span>  * @return           =
   True if parsing was successful</span><br><span>  */</span><br><span> sta=
tic bool</span><br><span>diff --git a/src/openvpn/forward.h b/src/openvpn/f=
orward.h</span><br><span>index 422c591..0e2bded 100644</span><br><span>--- =
a/src/openvpn/forward.h</span><br><span>+++ b/src/openvpn/forward.h</span><=
br><span>@@ -85,11 +85,11 @@</span><br><span>  * - Check that the client au=
thentication has succeeded; if not, drop the</span><br><span>  *   packet.<=
/span><br><span>  * - If the \a comp_frag argument is true:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *   - Call \c lzo_compress() of the =
\link Data Channel Compression</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *   - Call \c lzo_compress() of the \link compression Data Chan=
nel Compression</span><br><span>  *     module\endlink to (possibly) compre=
ss the packet.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   - =
Call \c fragment_outgoing() of the \link Data Channel Fragmentation</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *   - Call \c fragment_out=
going() of the \link fragmentation Data Channel Fragmentation</span><br><sp=
an>  *     module\endlink to (possibly) fragment the packet.</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * - Activate the \link Data Channel=
 Crypto module\endlink to perform</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * - Activate the \link data_crypto Data Channel Crypto modul=
e\endlink to perform</span><br><span>  *   security operations on the packe=
t.</span><br><span>  *   - Call \c tls_pre_encrypt() to choose the appropri=
ate security</span><br><span>  *     parameters for this packet.</span><br>=
<span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>=
index ae911a9..be66a02 100644</span><br><span>--- a/src/openvpn/init.c</spa=
n><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -294,8 +294,8 @@</s=
pan><br><span>  *</span><br><span>  * This will write the control message</=
span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 command parm1,parm2,..</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *  .</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  command =
parm1,parm2,...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span>  * to the control channel.</span><br><span>  *</span><br><s=
pan>  * @param arg           The context struct</span><br><span>@@ -2280,7 =
+2280,7 @@</span><br><span> </span><br><span> /**</span><br><span>  * Print=
s the results of options imported for the data channel</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * @param o</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param c</span><br><span>  */</span><br><span> =
static void</span><br><span> tls_print_deferred_options_results(struct cont=
ext *c)</span><br><span>diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c<=
/span><br><span>index bab2d78..f8337f1 100644</span><br><span>--- a/src/ope=
nvpn/lzo.c</span><br><span>+++ b/src/openvpn/lzo.c</span><br><span>@@ -22,7=
 +22,8 @@</span><br><span>  */</span><br><span> </span><br><span> /**</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * @file Data Channel Compr=
ession module function definitions.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Data Channel Compression module function definitions.</span><br><sp=
an>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><=
span>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><sp=
an>index 05b5a1a..c7ccee8 100644</span><br><span>--- a/src/openvpn/manage.c=
</span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -1240,6 +124=
0,7 @@</span><br><span>  * Checks if the correct number of arguments to a m=
anagement command are present</span><br><span>  * and otherwise prints an e=
rror and returns false.</span><br><span>  *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param man       The management interface struct=
</span><br><span>  * @param p         pointer to the parameter array</span>=
<br><span>  * @param n         number of arguments required</span><br><span=
>  * @param flags     if MN_AT_LEAST require at least n parameters and not =
exactly n</span><br><span>diff --git a/src/openvpn/mbedtls_compat.h b/src/o=
penvpn/mbedtls_compat.h</span><br><span>index 8559c2e..145a7ae 100644</span=
><br><span>--- a/src/openvpn/mbedtls_compat.h</span><br><span>+++ b/src/ope=
nvpn/mbedtls_compat.h</span><br><span>@@ -22,8 +22,8 @@</span><br><span>  *=
/</span><br><span> </span><br><span> /**</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * @file mbedtls compatibility stub</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * mbedtls compatibility stub.</span><br><span>  * This file provide c=
ompatibility stubs for the mbedtls libraries</span><br><span>  * prior to v=
ersion 3. This version made most fields in structs private</span><br><span>=
  * and requires accessor functions to be used. For earlier versions, we</s=
pan><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span>=
<br><span>index 7167639..20940a3 100644</span><br><span>--- a/src/openvpn/m=
ulti.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -22,7 +=
22,8 @@</span><br><span>  */</span><br><span> </span><br><span> /**</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * @file Header file for serv=
er-mode related structures and functions.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Header file for server-mode related structures and functions.=
</span><br><span>  */</span><br><span> </span><br><span> #ifndef MULTI_H</s=
pan><br><span>diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/opens=
sl_compat.h</span><br><span>index 95417b2..89f22d1 100644</span><br><span>-=
-- a/src/openvpn/openssl_compat.h</span><br><span>+++ b/src/openvpn/openssl=
_compat.h</span><br><span>@@ -23,7 +23,8 @@</span><br><span>  */</span><br>=
<span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * @file OpenSSL compatibility stub</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * OpenSSL compatibility stub</span><br><span>  *</span><br><sp=
an>  * This file provide compatibility stubs for the OpenSSL libraries</spa=
n><br><span>  * prior to version 1.1. This version introduces many changes =
in the</span><br><span>diff --git a/src/openvpn/pkcs11_backend.h b/src/open=
vpn/pkcs11_backend.h</span><br><span>index df5259f..6a67a7f 100644</span><b=
r><span>--- a/src/openvpn/pkcs11_backend.h</span><br><span>+++ b/src/openvp=
n/pkcs11_backend.h</span><br><span>@@ -23,7 +23,8 @@</span><br><span>  */</=
span><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * @file PKCS #11 SSL library-specific backend</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * PKCS #11 SSL library-specific backend<=
/span><br><span>  */</span><br><span> </span><br><span> #ifndef PKCS11_BACK=
END_H_</span><br><span>diff --git a/src/openvpn/pkcs11_mbedtls.c b/src/open=
vpn/pkcs11_mbedtls.c</span><br><span>index 2f1b1ac..0a930f9 100644</span><b=
r><span>--- a/src/openvpn/pkcs11_mbedtls.c</span><br><span>+++ b/src/openvp=
n/pkcs11_mbedtls.c</span><br><span>@@ -23,7 +23,8 @@</span><br><span>  */</=
span><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * @file PKCS #11 mbed TLS backend</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * PKCS #11 mbed TLS backend</span><br><span>  */</span=
><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --g=
it a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c</span><br>=
<span>index a013b3f..9382049 100644</span><br><span>--- a/src/openvpn/pkcs1=
1_openssl.c</span><br><span>+++ b/src/openvpn/pkcs11_openssl.c</span><br><s=
pan>@@ -23,7 +23,8 @@</span><br><span>  */</span><br><span> </span><br><spa=
n> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @file PKCS #=
11 OpenSSL backend</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * PKCS #11 =
OpenSSL backend</span><br><span>  */</span><br><span> </span><br><span> #if=
def HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/push.c b/src/ope=
nvpn/push.c</span><br><span>index 6c06374..de44eb2 100644</span><br><span>-=
-- a/src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br>=
<span>@@ -604,7 +604,7 @@</span><br><span> /**</span><br><span>  * Prepare =
push options, based on local options</span><br><span>  *</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * @param context       context structur=
e storing data for VPN tunnel</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param c             context structure storing data for VPN tu=
nnel</span><br><span>  * @param gc            gc arena for allocating push =
options</span><br><span>  * @param push_list     push list to where options=
 are added</span><br><span>  *</span><br><span>diff --git a/src/openvpn/ssl=
.c b/src/openvpn/ssl.c</span><br><span>index e2be614..eb7afcc 100644</span>=
<br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</=
span><br><span>@@ -24,7 +24,8 @@</span><br><span>  */</span><br><span> </sp=
an><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @=
file Control Channel SSL/Data channel negotiation Module</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Control Channel SSL/Data channel negotiation M=
odule</span><br><span>  */</span><br><span> </span><br><span> /*</span><br>=
<span>@@ -113,7 +114,7 @@</span><br><span> /**</span><br><span>  * Limit th=
e reneg_bytes value when using a small-block (&lt;128 bytes) cipher.</span>=
<br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @para=
m cipher        The current cipher (may be NULL).</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param ciphername    The current cipher (m=
ay be NULL).</span><br><span>  * @param reneg_bytes   Pointer to the curren=
t reneg_bytes, updated if needed.</span><br><span>  *                      =
May *not* be NULL.</span><br><span>  */</span><br><span>@@ -454,10 +455,10 =
@@</span><br><span>  * - the CRL file was passed inline</span><br><span>  *=
 - the CRL file was not modified since the last (re)load</span><br><span>  =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param ssl_ctx   =
    The TLS context to use when reloading the CRL</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * @param crl_file      The file name to load t=
he CRL from, or</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *    =
                  &quot;[[INLINE]]&quot; in the case of inline files.</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param crl_inline    A s=
tring containing the CRL</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param ssl_ctx         The TLS context to use when reloading the CR=
L</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param crl_file=
        The file name to load the CRL from, or</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *                        or an array containing=
 the inline CRL.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param crl_file_inline True if crl_file is an inline CRL.</span><br><span> =
 */</span><br><span> static void</span><br><span> tls_ctx_reload_crl(struct=
 tls_root_ctx *ssl_ctx, const char *crl_file,</span><br><span>diff --git a/=
src/openvpn/ssl.h b/src/openvpn/ssl.h</span><br><span>index eea1323..3561c4=
1 100644</span><br><span>--- a/src/openvpn/ssl.h</span><br><span>+++ b/src/=
openvpn/ssl.h</span><br><span>@@ -23,7 +23,8 @@</span><br><span>  */</span>=
<br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * @file Control Channel SSL/Data channel negotiation module</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Control Channel SSL/Data channe=
l negotiation module</span><br><span>  */</span><br><span> </span><br><span=
> #ifndef OPENVPN_SSL_H</span><br><span>diff --git a/src/openvpn/ssl_backen=
d.h b/src/openvpn/ssl_backend.h</span><br><span>index 285705f..a6a9695 1006=
44</span><br><span>--- a/src/openvpn/ssl_backend.h</span><br><span>+++ b/sr=
c/openvpn/ssl_backend.h</span><br><span>@@ -23,7 +23,8 @@</span><br><span> =
 */</span><br><span> </span><br><span> /**</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * @file Control Channel SSL library backend module</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Control Channel SSL library ba=
ckend module</span><br><span>  */</span><br><span> </span><br><span> </span=
><br><span>@@ -252,7 +253,7 @@</span><br><span>  * context.</span><br><span=
>  *</span><br><span>  * @param ctx                   TLS context to use</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param crypto_api_cer=
t       String representing the certificate to load.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param cryptoapi_cert       String rep=
resenting the certificate to load.</span><br><span>  */</span><br><span> #i=
fdef ENABLE_CRYPTOAPI</span><br><span> void tls_ctx_load_cryptoapi(struct t=
ls_root_ctx *ctx, const char *cryptoapi_cert);</span><br><span>@@ -506,7 +5=
07,6 @@</span><br><span>  * @param ks_ssl       - The security parameter st=
ate for this %key</span><br><span>  *                       session.</span>=
<br><span>  * @param buf          - A buffer in which to store the plaintex=
t.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param maxlen   =
    - The maximum number of bytes to extract.</span><br><span>  *</span><br=
><span>  * @return The return value indicates whether the data was successf=
ully</span><br><span>  *     processed:</span><br><span>diff --git a/src/op=
envpn/ssl_common.h b/src/openvpn/ssl_common.h</span><br><span>index 5bc2f2a=
..421ced1 100644</span><br><span>--- a/src/openvpn/ssl_common.h</span><br><=
span>+++ b/src/openvpn/ssl_common.h</span><br><span>@@ -23,7 +23,8 @@</span=
><br><span>  */</span><br><span> </span><br><span> /**</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * @file Control Channel Common Data Struc=
tures</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Control Channel Common=
 Data Structures</span><br><span>  */</span><br><span> </span><br><span> #i=
fndef SSL_COMMON_H_</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c =
b/src/openvpn/ssl_mbedtls.c</span><br><span>index bb88da9..56eef36 100644</=
span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/op=
envpn/ssl_mbedtls.c</span><br><span>@@ -24,7 +24,8 @@</span><br><span>  */<=
/span><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * @file Control Channel mbed TLS Backend</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Control Channel mbed TLS Backend</span><br><=
span>  */</span><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br=
><span>diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h</=
span><br><span>index 34b4f02..ec30bb5 100644</span><br><span>--- a/src/open=
vpn/ssl_mbedtls.h</span><br><span>+++ b/src/openvpn/ssl_mbedtls.h</span><br=
><span>@@ -23,7 +23,8 @@</span><br><span>  */</span><br><span> </span><br><=
span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @file Con=
trol Channel mbed TLS Backend</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Control Channel mbed TLS Backend</span><br><span>  */</span><br><span> </=
span><br><span> #ifndef SSL_MBEDTLS_H_</span><br><span>@@ -67,9 +68,9 @@</s=
pan><br><span>  *</span><br><span>  * @param sign_ctx  The context for the =
signing function.</span><br><span>  * @param src       The data to be signe=
d,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param src_len  =
 The length of src, in bytes.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param src_size  The length of src, in bytes.</span><br><span>=
  * @param dst       The destination buffer for the signature.</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * @param dst_len   The length of =
the destination buffer.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param dst_size  The length of the destination buffer.</span><br><sp=
an>  *</span><br><span>  * @return true if signing succeeded, false otherwi=
se.</span><br><span>  */</span><br><span>diff --git a/src/openvpn/ssl_ncp.c=
 b/src/openvpn/ssl_ncp.c</span><br><span>index 968858e..167bdb2 100644</spa=
n><br><span>--- a/src/openvpn/ssl_ncp.c</span><br><span>+++ b/src/openvpn/s=
sl_ncp.c</span><br><span>@@ -24,7 +24,8 @@</span><br><span>  */</span><br><=
span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * @file Control Channel SSL/Data dynamic negotiation Module</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Control Channel SSL/Data dynamic neg=
otiation Module</span><br><span>  * This file is split from ssl.c to be abl=
e to unit test it.</span><br><span>  */</span><br><span> </span><br><span>d=
iff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h</span><br><span>i=
ndex afbe331..0bdb6a0 100644</span><br><span>--- a/src/openvpn/ssl_ncp.h</s=
pan><br><span>+++ b/src/openvpn/ssl_ncp.h</span><br><span>@@ -23,7 +23,8 @@=
</span><br><span>  */</span><br><span> </span><br><span> /**</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * @file Control Channel SSL/Data dy=
namic negotiation Module</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Con=
trol Channel SSL/Data dynamic negotiation Module</span><br><span>  * This f=
ile is split from ssl.h to be able to unit test it.</span><br><span>  */</s=
pan><br><span> </span><br><span>@@ -90,7 +91,7 @@</span><br><span>  * Check=
 whether the ciphers in the supplied list are supported.</span><br><span>  =
*</span><br><span>  * @param list          Colon-separated list of ciphers<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @parms gc          =
  gc_arena to allocate the returned string</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param gc            gc_arena to allocate the ret=
urned string</span><br><span>  *</span><br><span>  * @returns             c=
olon separated string of normalised (via</span><br><span>  *               =
       translate_cipher_name_from_openvpn) and</span><br><span>diff --git a=
/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>inde=
x 5fd6572..98eba9d 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</=
span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -23,7 +23=
,8 @@</span><br><span>  */</span><br><span> </span><br><span> /**</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * @file Control Channel OpenSS=
L Backend</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Control Channel Op=
enSSL Backend</span><br><span>  */</span><br><span> </span><br><span> #ifde=
f HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/ssl_openssl.h b/sr=
c/openvpn/ssl_openssl.h</span><br><span>index cf00478..222dd4f 100644</span=
><br><span>--- a/src/openvpn/ssl_openssl.h</span><br><span>+++ b/src/openvp=
n/ssl_openssl.h</span><br><span>@@ -23,7 +23,8 @@</span><br><span>  */</spa=
n><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * @file Control Channel OpenSSL Backend</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Control Channel OpenSSL Backend</span><br><span> =
 */</span><br><span> </span><br><span> #ifndef SSL_OPENSSL_H_</span><br><sp=
an>diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h</span><br><sp=
an>index c8a27fb..b2c4b37 100644</span><br><span>--- a/src/openvpn/ssl_pkt.=
h</span><br><span>+++ b/src/openvpn/ssl_pkt.h</span><br><span>@@ -22,9 +22,=
10 @@</span><br><span>  */</span><br><span> </span><br><span> /**</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * @file SSL control channel wr=
ap/unwrap and decode functions. This file</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">- *        (and its .c file) is designed to to be includ=
ed in units/etc without</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *        pulling in a lot of dependencies</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * SSL control channel wrap/unwrap and decode functions.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This file (and its .c=
 file) is designed to to be included in units/etc without</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * pulling in a lot of dependencies.<=
/span><br><span>  */</span><br><span> </span><br><span> #ifndef SSL_PKT_H</=
span><br><span>@@ -182,7 +183,7 @@</span><br><span> /**</span><br><span>  *=
 Checks if a control packet has a correct HMAC server session id</span><br>=
<span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param cl=
ient_sid    session id of the client</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param state         session information</span><br><spa=
n>  * @param from          link_socket from the client</span><br><span>  * =
@param hmac          the hmac context to use for the calculation</span><br>=
<span>  * @param handwindow    the quantisation of the current time</span><=
br><span>diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h</span=
><br><span>index e858d64..71a37d4 100644</span><br><span>--- a/src/openvpn/=
ssl_util.h</span><br><span>+++ b/src/openvpn/ssl_util.h</span><br><span>@@ =
-22,8 +22,10 @@</span><br><span>  */</span><br><span> </span><br><span> /**=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @file SSL utility =
function. This file (and its .c file) is designed to</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *       to be included in units/etc withou=
t pulling in a lot of dependencies</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * SSL utility functions.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * This file (and its .c file) is designed to to be included in u=
nits/etc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * without =
pulling in a lot of dependencies.</span><br><span>  */</span><br><span> </s=
pan><br><span> #ifndef SSL_UTIL_H_</span><br><span>diff --git a/src/openvpn=
/ssl_verify.c b/src/openvpn/ssl_verify.c</span><br><span>index 74b2775..4c4=
b58d 100644</span><br><span>--- a/src/openvpn/ssl_verify.c</span><br><span>=
+++ b/src/openvpn/ssl_verify.c</span><br><span>@@ -23,7 +23,8 @@</span><br>=
<span>  */</span><br><span> </span><br><span> /**</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * @file Control Channel Verification Module</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Control Channel Verification M=
odule</span><br><span>  */</span><br><span> </span><br><span> #ifdef HAVE_C=
ONFIG_H</span><br><span>diff --git a/src/openvpn/ssl_verify.h b/src/openvpn=
/ssl_verify.h</span><br><span>index 7012f41..cd2ec24 100644</span><br><span=
>--- a/src/openvpn/ssl_verify.h</span><br><span>+++ b/src/openvpn/ssl_verif=
y.h</span><br><span>@@ -23,7 +23,8 @@</span><br><span>  */</span><br><span>=
 </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- * @file Control Channel Verification Module</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Control Channel Verification Module</span><br><span>  */<=
/span><br><span> </span><br><span> #ifndef SSL_VERIFY_H_</span><br><span>di=
ff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backen=
d.h</span><br><span>index 550b3c3..3c80324 100644</span><br><span>--- a/src=
/openvpn/ssl_verify_backend.h</span><br><span>+++ b/src/openvpn/ssl_verify_=
backend.h</span><br><span>@@ -23,7 +23,8 @@</span><br><span>  */</span><br>=
<span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * @file Control Channel Verification Module library-specific backen=
d interface</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Control Channel =
Verification Module library-specific backend interface</span><br><span>  */=
</span><br><span> </span><br><span> #ifndef SSL_VERIFY_BACKEND_H_</span><br=
><span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_veri=
fy_mbedtls.c</span><br><span>index ca14ceb..7b387ec 100644</span><br><span>=
--- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/src/openvpn/ss=
l_verify_mbedtls.c</span><br><span>@@ -23,7 +23,8 @@</span><br><span>  */</=
span><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * @file Control Channel Verification Module mbed TLS backe=
nd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Control Channel Verificat=
ion Module mbed TLS backend</span><br><span>  */</span><br><span> </span><b=
r><span> #ifdef HAVE_CONFIG_H</span><br><span>diff --git a/src/openvpn/ssl_=
verify_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h</span><br><span>index d=
2ba6b6..300b2f5 100644</span><br><span>--- a/src/openvpn/ssl_verify_mbedtls=
.h</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls.h</span><br><span>@=
@ -23,7 +23,8 @@</span><br><span>  */</span><br><span> </span><br><span> /*=
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @file Control Cha=
nnel Verification Module mbed TLS backend</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Control Channel Verification Module mbed TLS backend</span><b=
r><span>  */</span><br><span> </span><br><span> #ifndef SSL_VERIFY_MBEDTLS_=
H_</span><br><span>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/open=
vpn/ssl_verify_openssl.c</span><br><span>index 7d41d4a..ce1e7da 100644</spa=
n><br><span>--- a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/sr=
c/openvpn/ssl_verify_openssl.c</span><br><span>@@ -23,7 +23,8 @@</span><br>=
<span>  */</span><br><span> </span><br><span> /**</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * @file Control Channel Verification Module Op=
enSSL implementation</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Control=
 Channel Verification Module OpenSSL implementation</span><br><span>  */</s=
pan><br><span> </span><br><span> #ifdef HAVE_CONFIG_H</span><br><span>diff =
--git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_openssl.h=
</span><br><span>index a73b810..c31daa3 100644</span><br><span>--- a/src/op=
envpn/ssl_verify_openssl.h</span><br><span>+++ b/src/openvpn/ssl_verify_ope=
nssl.h</span><br><span>@@ -23,7 +23,8 @@</span><br><span>  */</span><br><sp=
an> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * @file Control Channel Verification Module OpenSSL backend</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Control Channel Verification Module Op=
enSSL backend</span><br><span>  */</span><br><span> </span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h<=
/span><br><span>index 8c87e20..ffb1f2a 100644</span><br><span>--- a/src/ope=
nvpn/tls_crypt.h</span><br><span>+++ b/src/openvpn/tls_crypt.h</span><br><s=
pan>@@ -167,8 +167,8 @@</span><br><span> /**</span><br><span>  * Initialize=
 a tls-crypt-v2 server key (used to encrypt/decrypt client keys).</span><br=
><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param k=
ey           Key structure to be initialized.  Must be non-NULL.</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- * @parem encrypt       If true,=
 initialize the key structure for encryption,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param key_ctx       Key structure to be initi=
alized.  Must be non-NULL.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param encrypt       If true, initialize the key structure for en=
cryption,</span><br><span>  *                      otherwise for decryption=
.</span><br><span>  * @param key_file      File path of the key file to loa=
d or the key itself if</span><br><span>  *                      key_inline =
is true.</span><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c=
</span><br><span>index 85fe01a..b39dae1 100644</span><br><span>--- a/src/op=
envpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -110=
4,7 +1104,7 @@</span><br><span>  *</span><br><span>  * @param tt        the=
 tuntap interface context</span><br><span>  * @param ifname    the human re=
adable interface name</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @param mtu       the MTU value to set the interface to</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param tun_mtu   the MTU value to =
set the interface to</span><br><span>  * @param es        the environment t=
o be used when executing the commands</span><br><span>  * @param ctx       =
the networking API opaque context</span><br><span>  */</span><br><span>@@ -=
1303,7 +1303,7 @@</span><br><span>  *</span><br><span>  * @param tt        =
the tuntap interface context</span><br><span>  * @param ifname    the human=
 readable interface name</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * @param mtu       the MTU value to set the interface to</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param tun_mtu   the MTU value =
to set the interface to</span><br><span>  * @param es        the environmen=
t to be used when executing the commands</span><br><span>  * @param ctx    =
   the networking API opaque context</span><br><span>  */</span><br><span>d=
iff --git a/src/openvpn/tun.h b/src/openvpn/tun.h</span><br><span>index 329=
cd10..ccba0bc 100644</span><br><span>--- a/src/openvpn/tun.h</span><br><spa=
n>+++ b/src/openvpn/tun.h</span><br><span>@@ -330,7 +330,7 @@</span><br><sp=
an>  *</span><br><span>  * @param tt        the tuntap interface context</s=
pan><br><span>  * @param ifname    the human readable interface name</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * @param mtu       the MTU =
value to set the interface to</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param tun_mtu   the MTU value to set the interface to</span><=
br><span>  * @param es        the environment to be used when executing the=
 commands</span><br><span>  * @param ctx       the networking API opaque co=
ntext</span><br><span>  */</span><br><span>diff --git a/src/tapctl/tap.c b/=
src/tapctl/tap.c</span><br><span>index 2e53596..4dde2e6 100644</span><br><s=
pan>--- a/src/tapctl/tap.c</span><br><span>+++ b/src/tapctl/tap.c</span><br=
><span>@@ -632,7 +632,7 @@</span><br><span>  * @param dwProperty     Specif=
ies the property to be retrieved. See</span><br><span>  *                  =
     https://msdn.microsoft.com/en-us/library/windows/hardware/ff551967.asp=
x</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @pdwPropertyRegDataType  A pointer to a variable that receives the data =
type of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m pdwPropertyRegDataType  A pointer to a variable that receives the data ty=
pe of the</span><br><span>  *                       property that is being =
retrieved. This is one of the standard</span><br><span>  *                 =
      registry data types. This parameter is optional and can be NULL.</spa=
n><br><span>  *</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/778?usp=3Demail">change 778</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/778?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7a852eb5fafae3a0e85dd89ea6d=
4c91fcf2fab4e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 778 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--ANCM1oz97Sw=--

