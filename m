From: Gert Doering <gert@...1296...>
Date: Fri, 27 Dec 2024 17:16:48 +0100
Message-ID: <20241227161648.3350-1-gert@...1296...>
In-Reply-To: <gerrit.1728560771000.I7a852eb5fafae3a0e85dd89ea6d4c91fcf2fab4e@...2715...>
References: <gerrit.1728560771000.I7a852eb5fafae3a0e85dd89ea6d4c91fcf2fab4e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Review doxygen warnings
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
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/778
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
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
diff --git a/doc/doxygen/doc_protocol_overview.h b/doc/doxygen/doc_protocol_overview.h
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
diff --git a/sample/sample-plugins/simple/base64.c b/sample/sample-plugins/simple/base64.c
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
  *  This will ensure the list size in struct argv has the needed capacity to
  *  store the value.
  *
- *  @param *a    struct argv where to append the new string value
- *  @param *str  Pointer to string to append.  The provided string *MUST* have
- *               been malloc()ed or NULL.
+ *  @param a    struct argv where to append the new string value
+ *  @param str  Pointer to string to append.  The provided string *MUST* have
+ *              been malloc()ed or NULL.
  */
 static void
 argv_append(struct argv *a, char *str)
@@ -167,7 +167,7 @@
  *  values being copied from the source input.
  *
  *
- *  @param *source   Valid pointer to the source struct argv to clone.  It may
+ *  @param source    Valid pointer to the source struct argv to clone.  It may
  *                   be NULL.
  *  @param headroom  Number of slots to leave empty in front of the slots
  *                   copied from the source.
@@ -199,8 +199,8 @@
 /**
  *  Inserts an argument string in front of all other argument slots.
  *
- *  @param  *a     Valid pointer to the struct argv to insert the argument into
- *  @param  *head  Pointer to the char * string with the argument to insert
+ *  @param  a     Valid pointer to the struct argv to insert the argument into
+ *  @param  head  Pointer to the string with the argument to insert
  *
  *  @returns Returns a new struct argv with the inserted argument in front
  */
@@ -217,8 +217,8 @@
  *  Generate a single string with all the arguments in a struct argv
  *  concatenated.
  *
- *  @param *a    Valid pointer to the struct argv with the arguments to list
- *  @param *gc   Pointer to a struct gc_arena managed buffer
+ *  @param a     Valid pointer to the struct argv with the arguments to list
+ *  @param gc    Pointer to a struct gc_arena managed buffer
  *  @param flags Flags passed to the print_argv() function.
  *
  *  @returns Returns a string generated by print_argv() with all the arguments
@@ -237,7 +237,7 @@
  *  Write the arguments stored in a struct argv via the msg() command.
  *
  *  @param msglev  Integer with the message level used by msg().
- *  @param *a      Valid pointer to the struct argv with the arguments to write.
+ *  @param a       Valid pointer to the struct argv with the arguments to write.
  */
 void
 argv_msg(const int msglev, const struct argv *a)
@@ -251,9 +251,9 @@
  *  Similar to argv_msg() but prefixes the messages being written with a
  *  given string.
  *
- *  @param msglev   Integer with the message level used by msg().
- *  @param *a       Valid pointer to the struct argv with the arguments to write
- *  @param *prefix  Valid char * pointer to the prefix string
+ *  @param msglev  Integer with the message level used by msg().
+ *  @param a       Valid pointer to the struct argv with the arguments to write
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
  *           gc_arena pointer is NULL, the returned string must be explicitly
@@ -332,11 +332,11 @@
  *  argv_prep_format() before we let libc's printf() do the parsing.
  *  Then split the resulting string at the injected delimiters.
  *
- *  @param *argres  Valid pointer to a struct argv where the resulting parsed
- *                  arguments, based on the format string.
- *  @param *format  Char* string with a printf() compliant format string
- *  @param arglist  A va_list with the arguments to be consumed by the format
- *                  string
+ *  @param argres  Valid pointer to a struct argv where the resulting parsed
+ *                 arguments, based on the format string.
+ *  @param format  Char string with a printf() compliant format string
+ *  @param arglist A va_list with the arguments to be consumed by the format
+ *                 string
  *
  *  @returns Returns true if the parsing and processing was successfully.  If
  *           the resulting number of arguments does not match the expected
@@ -429,8 +429,8 @@
  *  This will always reset and ensure the result is based on a pristine
  *  struct argv.
  *
- *  @param *argres  Valid pointer to a struct argv where the result will be put.
- *  @param *format  printf() compliant (char *) format string.
+ *  @param argres  Valid pointer to a struct argv where the result will be put.
+ *  @param format  printf() compliant format string.
  *
  *  @returns Returns true if the parsing was successful.  See
  *           argv_printf_arglist() for more details.  The parsed result will
@@ -453,8 +453,8 @@
  *  struct argv and populets the argument slots based on the printf() based
  *  format string.
  *
- *  @param *argres  Valid pointer to a struct argv where the result will be put.
- *  @param *format  printf() compliant (char *) format string.
+ *  @param argres  Valid pointer to a struct argv where the result will be put.
+ *  @param format  printf() compliant format string.
  *
  *  @returns Returns true if the parsing was successful.  See
  *           argv_printf_arglist() for more details.  The parsed result will
@@ -474,9 +474,9 @@
  *  Parses a command string, tokenizes it and puts each element into a separate
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
index 2f804fb..02e72dc 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -1218,7 +1218,7 @@
 /**
  * buffer_read_from_file - copy the content of a file into a buffer
  *
- * @param file      path to the file to read
+ * @param filename  path to the file to read
  * @param gc        the garbage collector to use when allocating the buffer. It
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
  * Closes the TTY FILE pointer, but only if it is not a stdin/stderr FILE object.
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
index b3612fb..1f291b2 100644
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
@@ -466,7 +467,7 @@
  * this and add it themselves.
  *
  * @param kt            Struct with the crypto algorithm to use
- * @param packet_id_size Size of the packet id
+ * @param pkt_id_size   Size of the packet id
  * @param occ           if true calculates the overhead for crypto in the same
  *                      incorrect way as all previous OpenVPN versions did, to
  *                      end up with identical numbers for OCC compatibility
@@ -484,7 +485,7 @@
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
  * Returns the size of the IV used by the cipher, in bytes, or 0 if no IV is
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
index fe51359..4a36d6f 100644
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
index 288c2fa..bed8844 100644
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
@@ -110,8 +111,7 @@
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
index e22ea00..cf48c22 100644
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
index 8ef19b4..4cd470a 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -86,11 +86,11 @@
  * - Check that the client authentication has succeeded; if not, drop the
  *   packet.
  * - If the \a comp_frag argument is true:
- *   - Call \c lzo_compress() of the \link Data Channel Compression
+ *   - Call \c lzo_compress() of the \link compression Data Channel Compression
  *     module\endlink to (possibly) compress the packet.
- *   - Call \c fragment_outgoing() of the \link Data Channel Fragmentation
+ *   - Call \c fragment_outgoing() of the \link fragmentation Data Channel Fragmentation
  *     module\endlink to (possibly) fragment the packet.
- * - Activate the \link Data Channel Crypto module\endlink to perform
+ * - Activate the \link data_crypto Data Channel Crypto module\endlink to perform
  *   security operations on the packet.
  *   - Call \c tls_pre_encrypt() to choose the appropriate security
  *     parameters for this packet.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9371024..7145495 100644
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
@@ -2278,7 +2278,7 @@
 
 /**
  * Prints the results of options imported for the data channel
- * @param o
+ * @param c
  */
 static void
 tls_print_deferred_options_results(struct context *c)
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 5cd5ea2..bd7e2f9 100644
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
index e79a118..0c77f85 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1240,6 +1240,7 @@
  * Checks if the correct number of arguments to a management command are present
  * and otherwise prints an error and returns false.
  *
+ * @param man       The management interface struct
  * @param p         pointer to the parameter array
  * @param n         number of arguments required
  * @param flags     if MN_AT_LEAST require at least n parameters and not exactly n
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
index f386a3b..93ac9e7 100644
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
index a222d5b..cf7f34f 100644
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
@@ -98,7 +99,7 @@
 /**
  * Limit the reneg_bytes value when using a small-block (<128 bytes) cipher.
  *
- * @param cipher        The current cipher (may be NULL).
+ * @param ciphername    The current cipher (may be NULL).
  * @param reneg_bytes   Pointer to the current reneg_bytes, updated if needed.
  *                      May *not* be NULL.
  */
@@ -461,10 +462,10 @@
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
- * @param crypto_api_cert       String representing the certificate to load.
+ * @param cryptoapi_cert       String representing the certificate to load.
  */
 #ifdef ENABLE_CRYPTOAPI
 void tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert);
@@ -506,7 +507,6 @@
  * @param ks_ssl       - The security parameter state for this %key
  *                       session.
  * @param buf          - A buffer in which to store the plaintext.
- * @param maxlen       - The maximum number of bytes to extract.
  *
  * @return The return value indicates whether the data was successfully
  *     processed:
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index ccbc053..e697d68 100644
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
- *        (and its .c file) is designed to to be included in units/etc without
- *        pulling in a lot of dependencies
+ * @file
+ * SSL control channel wrap/unwrap and decode functions.
+ * This file (and its .c file) is designed to to be included in units/etc without
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
- *       to be included in units/etc without pulling in a lot of dependencies
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
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index 550b3c3..3c80324 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -23,7 +23,8 @@
  */
 
 /**
- * @file Control Channel Verification Module library-specific backend interface
+ * @file
+ * Control Channel Verification Module library-specific backend interface
  */
 
 #ifndef SSL_VERIFY_BACKEND_H_
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
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
diff --git a/src/openvpn/ssl_verify_mbedtls.h b/src/openvpn/ssl_verify_mbedtls.h
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
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
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
diff --git a/src/openvpn/ssl_verify_openssl.h b/src/openvpn/ssl_verify_openssl.h
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
  * Initialize a tls-crypt-v2 server key (used to encrypt/decrypt client keys).
  *
- * @param key           Key structure to be initialized.  Must be non-NULL.
- * @parem encrypt       If true, initialize the key structure for encryption,
+ * @param key_ctx       Key structure to be initialized.  Must be non-NULL.
+ * @param encrypt       If true, initialize the key structure for encryption,
  *                      otherwise for decryption.
  * @param key_file      File path of the key file to load or the key itself if
  *                      key_inline is true.
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 1e67d37..7fbd6c3 100644
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
  *                       https://msdn.microsoft.com/en-us/library/windows/hardware/ff551967.aspx
  *
- * @pdwPropertyRegDataType  A pointer to a variable that receives the data type of the
+ * @param pdwPropertyRegDataType  A pointer to a variable that receives the data type of the
  *                       property that is being retrieved. This is one of the standard
  *                       registry data types. This parameter is optional and can be NULL.
  *

