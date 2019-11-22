From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Nov 2019 15:33:15 +0100
Message-Id: <20191122143315.8564-2-arne@...1227...>
In-Reply-To: <20191122143315.8564-1-arne@...1227...>
References: <20191122143315.8564-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v7 2/2] Add support for OpenSSL TLS 1.3 when
 using management-external-key
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

For TLS 1.0 to 1.2 and OpenSSL 1.1.0 calls us and requires a PKCS1
padded response. As TLS 1.3 mandates RSA-PSS padding support and also
requires an TLS 1.3 implementation to support RSA-PSS for older TLS
version, OpenSSL will query us to sign an already RSA-PSS padded
string.

This patch adds an 'unpadded' and 'pkcs1' parameter to the
management-external-key option to signal that the client is
able to support pkcs1 as well as unpadded signature requests.

Since clients that implement the management-external-key interface
are usually rather tightly integrated solutions (OpenVPN Connect in the
past, OpenVPN for Android), it is reasonable to expect that
upgrading the OpenSSL library can be done together with
management interface changes. Therefore we provide no backwards
compatbility for mangement-interface clients not supporting
OpenSSL 1.1.1.

Using the management api client version instead might seem like the
more logical way but since we only now that version very late,
it would extra logic and complexity to deal with this asynchronous
behaviour. Instead just give an error early if OpenSSL 1.1.1 and
management-external-key without nopadding is detected.

The interface is prepared for signalling PCKS1 and RSA-PSS support
instead of signalling unpadded support.

Patch v3: fix overlong lines and few other style patches. Note
      two overlong lines concerning mbedtls are not fixed as they
      are removed/shortend by the mbed tls patch to avoid conflicts

Patch v4: Setting minimum TLS version proved to be not enough and
      instead of implementing a whole compability layer we require
      mangement-clients to implement the new feature when they want
      to use OpenSSL 1.1.1

      Add a padding=ALGORITHM argument to pk-sig to indicate the
      algorithm. Drop adding PKCS1 ourselves.

Patch v5: Send the right version of the patch
Patch v6: rebase on master
Patch v7: change style and reword documentation. Make thing more consistent

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/management-notes.txt  | 21 ++++++++++++-
 doc/openvpn.8             |  7 +++--
 src/openvpn/manage.c      | 20 +++++++++---
 src/openvpn/manage.h      | 19 +++++++-----
 src/openvpn/options.c     | 36 +++++++++++++++++++++-
 src/openvpn/ssl_mbedtls.c |  8 +++--
 src/openvpn/ssl_openssl.c | 64 ++++++++++++++++++++++++++++++---------
 7 files changed, 143 insertions(+), 32 deletions(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 17645c1d..c64e594d 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -816,6 +816,7 @@ actual private key. When the SSL protocol needs to perform a sign
 operation, the data to be signed will be sent to the management interface
 via a notification as follows:
 
+>PK_SIGN:[BASE64_DATA],[ALG] (if client announces support for management version > 2)
 >PK_SIGN:[BASE64_DATA] (if client announces support for management version > 1)
 >RSA_SIGN:[BASE64_DATA] (only older clients will be prompted like this)
 
@@ -823,7 +824,7 @@ The management interface client should then create an appropriate signature of
 the (decoded) BASE64_DATA using the private key and return the SSL signature as
 follows:
 
-pk-sig   (or rsa-sig)
+pk-sig (or rsa-sig)
 [BASE64_SIG_LINE]
 .
 .
@@ -833,6 +834,12 @@ END
 Base 64 encoded output of RSA_private_encrypt for RSA or ECDSA_sign()
 for EC using OpenSSL or mbedtls_pk_sign() using mbed TLS will provide a
 correct signature.
+The rsa-sig interfaces expects PKCS1 padded signatures for RSA keys
+(RSA_PKCS1_PADDING). EC signatures are always unpadded.
+
+The padding field is only present when pk-sig is used and
+currently the following values can be requested PCKS1 and NOPADDING for RSA
+certificates and NOPADDING for EC certificates.
 
 This capability is intended to allow the use of arbitrary cryptographic
 service providers with OpenVPN via the management interface.
@@ -840,6 +847,18 @@ service providers with OpenVPN via the management interface.
 New and updated clients are expected to use the version command to announce
 a version > 1 and handle '>PK_SIGN' prompt and respond with 'pk-sig'.
 
+The signature algorithm is indicated in the PK_SIGN request only if the
+management client-version is >= 2.  In particular, to support TLS1.3 and
+TLS1.2 using OpenSSL 1.1.1, not padded signature support is required  and this
+can be indicated in the signing request only if the client version is > 2"
+
+The currently defined padding algorithm are:
+
+ - RSA_PKCS1_PADDING  -  PKCS1 padding and RSA signature
+ - RSA_NO_PADDING     -  No padding may be added for the signature
+ - ECDSA              -  EC signature.
+
+
 COMMAND -- certificate (OpenVPN 2.4 or higher)
 ----------------------------------------------
 Provides support for external storage of the certificate. Requires the
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 457c2667..28d4516a 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -2708,10 +2708,13 @@ Allow management interface to override
 directives (client\-only).
 .\"*********************************************************
 .TP
-.B \-\-management\-external\-key
+.B \-\-management\-external\-key [nopadding] [pkcs1]
 Allows usage for external private key file instead of
 .B \-\-key
-option (client\-only).
+option (client\-only). The optional parameters nopadding and
+pkcs1 signal support for different padding algorithms. See
+doc/mangement-notes.txt for a complete description of this
+feature.
 .\"*********************************************************
 .TP
 .B \-\-management\-external\-cert certificate\-hint
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 1d97c2b6..49864c0a 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3641,18 +3641,30 @@ management_query_multiline_flatten(struct management *man,
 
 char *
 /* returns allocated base64 signature */
-management_query_pk_sig(struct management *man,
-                        const char *b64_data)
+management_query_pk_sig(struct management *man, const char *b64_data,
+                        const char *algorithm)
 {
     const char *prompt = "PK_SIGN";
     const char *desc = "pk-sign";
+    struct buffer buf_data = alloc_buf(strlen(b64_data) + strlen(algorithm) + 20);
+
     if (man->connection.client_version <= 1)
     {
         prompt = "RSA_SIGN";
         desc = "rsa-sign";
     }
-    return management_query_multiline_flatten(man, b64_data, prompt, desc,
-                                              &man->connection.ext_key_state, &man->connection.ext_key_input);
+
+    buf_write(&buf_data, b64_data, (int) strlen(b64_data));
+    if (man->connection.client_version > 2)
+    {
+        buf_write(&buf_data, ",", (int) strlen(","));
+        buf_write(&buf_data, algorithm, (int) strlen(algorithm));
+    }
+    char* ret = management_query_multiline_flatten(man,
+            (char *)buf_bptr(&buf_data), prompt, desc,
+            &man->connection.ext_key_state, &man->connection.ext_key_input);
+    free_buf(&buf_data);
+    return ret;
 }
 
 char *
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index d24abe09..6f5f34c1 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -31,7 +31,7 @@
 #include "socket.h"
 #include "mroute.h"
 
-#define MANAGEMENT_VERSION                      2
+#define MANAGEMENT_VERSION                      3
 #define MANAGEMENT_N_PASSWORD_RETRIES           3
 #define MANAGEMENT_LOG_HISTORY_INITIAL_SIZE   100
 #define MANAGEMENT_ECHO_BUFFER_SIZE           100
@@ -341,12 +341,14 @@ struct management *management_init(void);
 #ifdef MANAGEMENT_PF
 #define MF_CLIENT_PF         (1<<7)
 #endif
-#define MF_UNIX_SOCK       (1<<8)
-#define MF_EXTERNAL_KEY    (1<<9)
-#define MF_UP_DOWN          (1<<10)
-#define MF_QUERY_REMOTE     (1<<11)
-#define MF_QUERY_PROXY      (1<<12)
-#define MF_EXTERNAL_CERT    (1<<13)
+#define MF_UNIX_SOCK                (1<<8)
+#define MF_EXTERNAL_KEY             (1<<9)
+#define MF_EXTERNAL_KEY_NOPADDING   (1<<10)
+#define MF_EXTERNAL_KEY_PKCS1PAD    (1<<11)
+#define MF_UP_DOWN                  (1<<12)
+#define MF_QUERY_REMOTE             (1<<13)
+#define MF_QUERY_PROXY              (1<<14)
+#define MF_EXTERNAL_CERT            (1<<15)
 
 bool management_open(struct management *man,
                      const char *addr,
@@ -430,7 +432,8 @@ void management_learn_addr(struct management *management,
 
 #endif
 
-char *management_query_pk_sig(struct management *man, const char *b64_data);
+char *management_query_pk_sig(struct management *man, const char *b64_data,
+                              const char *algorithm);
 
 char *management_query_cert(struct management *man, const char *cert_name);
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c282b582..ebe553af 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2171,6 +2171,16 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
 
 #endif /* ifdef ENABLE_MANAGEMENT */
 
+#if  defined(ENABLE_MANAGEMENT)
+    if ((tls_version_max() >= TLS_VER_1_3)
+        && (options->management_flags & MF_EXTERNAL_KEY)
+        && !(options->management_flags & (MF_EXTERNAL_KEY_NOPADDING))
+        )
+    {
+        msg(M_ERR, "management-external-key with OpenSSL 1.1.1 requires "
+            "the nopadding argument/support");
+    }
+#endif
     /*
      * Windows-specific options.
      */
@@ -5241,9 +5251,33 @@ add_option(struct options *options,
         options->management_write_peer_info_file = p[1];
     }
 #ifdef ENABLE_MANAGEMENT
-    else if (streq(p[0], "management-external-key") && !p[1])
+    else if (streq(p[0], "management-external-key"))
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
+        for (int j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
+        {
+            if (streq(p[j], "nopadding"))
+            {
+                options->management_flags |= MF_EXTERNAL_KEY_NOPADDING;
+            }
+            else if (streq(p[j], "pkcs1"))
+            {
+                options->management_flags |= MF_EXTERNAL_KEY_PKCS1PAD;
+            }
+            else
+            {
+                msg(msglevel, "Unknown management-external-key flag: %s", p[j]);
+            }
+        }
+        /*
+         * When no option is present, assume that only PKCS1
+         * padding is supported
+         */
+        if (!(options->management_flags
+              &(MF_EXTERNAL_KEY_NOPADDING | MF_EXTERNAL_KEY_PKCS1PAD)))
+        {
+            options->management_flags |= MF_EXTERNAL_KEY_PKCS1PAD;
+        }
         options->management_flags |= MF_EXTERNAL_KEY;
     }
     else if (streq(p[0], "management-external-cert") && p[1] && !p[2])
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index a4197cba..6fdef406 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -626,7 +626,6 @@ tls_ctx_use_external_signing_func(struct tls_root_ctx *ctx,
 }
 
 #ifdef ENABLE_MANAGEMENT
-
 /** Query the management interface for a signature, see external_sign_func. */
 static bool
 management_sign_func(void *sign_ctx, const void *src, size_t src_len,
@@ -641,7 +640,12 @@ management_sign_func(void *sign_ctx, const void *src, size_t src_len,
         goto cleanup;
     }
 
-    if (!(dst_b64 = management_query_pk_sig(management, src_b64)))
+    /*
+     * We only support RSA external keys and PKCS1 signatures at the moment
+     * in mbed TLS, so the signature parameter is hardcoded to this encoding
+     */
+    if (!(dst_b64 = management_query_pk_sig(management, src_b64,
+                                            "RSA_PKCS1_PADDING")))
     {
         goto cleanup;
     }
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index a080338e..b7cfc77a 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -225,7 +225,9 @@ tls_version_max(void)
      * However, the library we are *linked* against might be OpenSSL 1.1.1
      * and therefore supports TLS 1.3. This needs to be checked at runtime
      * since we can be compiled against 1.1.0 and then the library can be
-     * upgraded to 1.1.1
+     * upgraded to 1.1.1.
+     * We only need need to this check for OpenSSL versions that can be
+     * upgraded to 1.1.1 without recompile (>= 1.1.0)
      */
     if (OpenSSL_version_num() >= 0x1010100fL)
     {
@@ -1133,24 +1135,52 @@ openvpn_extkey_rsa_finish(RSA *rsa)
     return 1;
 }
 
-/* Pass the input hash in 'dgst' to management and get the signature back.
- * On input siglen contains the capacity of the buffer 'sig'.
- * On return signature is in sig.
- * Return value is signature length or -1 on error.
+/*
+ * Convert OpenSSL's constant to the strings used in the management
+ * interface query
+ */
+const char *
+get_rsa_padding_name (const int padding)
+{
+    switch (padding)
+    {
+        case RSA_PKCS1_PADDING:
+            return "RSA_PKCS1_PADDING";
+
+        case RSA_NO_PADDING:
+            return "RSA_NO_PADDING";
+
+        default:
+            return "UNKNOWN";
+    }
+}
+
+/**
+ * Pass the input hash in 'dgst' to management and get the signature back.
+  *
+ * @param dgst		hash to be signed
+ * @param dgstlen	len of data in dgst
+ * @param sig 		On successful return signature is in sig.
+ * @param siglen	length of buffer sig
+ * @param algorithm	padding/hasing algorithm for the signature
+ *
+ * @return 		signature length or -1 on error.
  */
 static int
 get_sig_from_man(const unsigned char *dgst, unsigned int dgstlen,
-                 unsigned char *sig, unsigned int siglen)
+                 unsigned char *sig, unsigned int siglen,
+                 const char *algorithm)
 {
     char *in_b64 = NULL;
     char *out_b64 = NULL;
     int len = -1;
 
-    /* convert 'dgst' to base64 */
-    if (management
-        && openvpn_base64_encode(dgst, dgstlen, &in_b64) > 0)
+    int bencret = openvpn_base64_encode(dgst, dgstlen, &in_b64);
+
+    if (management && bencret > 0)
     {
-        out_b64 = management_query_pk_sig(management, in_b64);
+        out_b64 = management_query_pk_sig(management, in_b64, algorithm);
+
     }
     if (out_b64)
     {
@@ -1164,18 +1194,19 @@ get_sig_from_man(const unsigned char *dgst, unsigned int dgstlen,
 
 /* sign arbitrary data */
 static int
-rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa, int padding)
+rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa,
+             int padding)
 {
     unsigned int len = RSA_size(rsa);
     int ret = -1;
 
-    if (padding != RSA_PKCS1_PADDING)
+    if (padding != RSA_PKCS1_PADDING && padding != RSA_NO_PADDING)
     {
         RSAerr(RSA_F_RSA_OSSL_PRIVATE_ENCRYPT, RSA_R_UNKNOWN_PADDING_TYPE);
         return -1;
     }
 
-    ret = get_sig_from_man(from, flen, to, len);
+    ret = get_sig_from_man(from, flen, to, len, get_rsa_padding_name (padding));
 
     return (ret == len) ? ret : -1;
 }
@@ -1271,7 +1302,12 @@ ecdsa_sign(int type, const unsigned char *dgst, int dgstlen, unsigned char *sig,
            unsigned int *siglen, const BIGNUM *kinv, const BIGNUM *r, EC_KEY *ec)
 {
     int capacity = ECDSA_size(ec);
-    int len = get_sig_from_man(dgst, dgstlen, sig, capacity);
+    /*
+     * ECDSA does not seem to have proper constants for paddings since
+     * there are only signatures without padding at the moment, use
+     * a generic ECDSA for the moment
+     */
+    int len = get_sig_from_man(dgst, dgstlen, sig, capacity, "ECDSA");
 
     if (len > 0)
     {
-- 
2.24.0


