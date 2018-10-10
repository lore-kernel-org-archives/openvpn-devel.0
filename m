From: Arne Schwabe <arne@...1227...>
Date: Wed, 10 Oct 2018 17:32:25 +0200
Message-Id: <20181010153225.27820-1-arne@...1227...>
In-Reply-To: <20181008214923.11058-2-arne@...1227...>
References: <20181008214923.11058-2-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3 2/3] Add support for OpenSSL TLS 1.3 when
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

For TLS 1.0 to 1.2 OpenSSL calls us and requires a PKCS1 padded
response, for TLS 1.3 it requires to an unpadded response. Since we
can PCKS1 pad an unpadded response, we prefer to always query for
an unpadded response from the management interface and add the PCKS1
padding ourselves when needed.

This patch adds an 'unpadded' parameter to the management-external-key
option to signal that it is uses the new unpadded API. Since we cannot
support TLS 1.3 without unpadded queries we disable TLS 1.3 otherwise.
We also do the same for cryptoapi since it uses the same API.

Using the management api client version instead might seem like the
more logical way but since we only now that version very late,
it would extra logic and complexity to deal with this asynchronous
behaviour.

Signed-off-by: Arne Schwabe <arne@...1227...>
---

Patch v3: fix overlong lines and few other style patches. Note
      two overlong lines concerning mbedtls are not fixed as they
      are removed/shortend by the mbed tls patch to avoid conflicts

 doc/management-notes.txt  |  7 ++++-
 src/openvpn/manage.h      |  9 +++---
 src/openvpn/options.c     | 58 +++++++++++++++++++++++++++++++++++++--
 src/openvpn/ssl_openssl.c | 34 +++++++++++++++++------
 4 files changed, 92 insertions(+), 16 deletions(-)

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 17645c1d..7e61ff50 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -832,7 +832,12 @@ END
 
 Base 64 encoded output of RSA_private_encrypt for RSA or ECDSA_sign()
 for EC using OpenSSL or mbedtls_pk_sign() using mbed TLS will provide a
-correct signature.
+correct signature. With the 'nopadding' argument to the
+external-management-interface the interface expects unpadded signatures
+(RSA_NO_PADDING in OpenSSL). When the 'nopadding' keyword is missing the
+interfaces expects PKCS1 padded signatures for RSA keys (RSA_PKCS1_PADDING).
+EC signatures are always unpadded. To support TLS 1.3 using unpadded
+signatures is required.
 
 This capability is intended to allow the use of arbitrary cryptographic
 service providers with OpenVPN via the management interface.
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index d24abe09..4fe66abf 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -343,10 +343,11 @@ struct management *management_init(void);
 #endif
 #define MF_UNIX_SOCK       (1<<8)
 #define MF_EXTERNAL_KEY    (1<<9)
-#define MF_UP_DOWN          (1<<10)
-#define MF_QUERY_REMOTE     (1<<11)
-#define MF_QUERY_PROXY      (1<<12)
-#define MF_EXTERNAL_CERT    (1<<13)
+#define MF_EXTERNAL_KEY_NOPADDING   (1<<10)
+#define MF_UP_DOWN          (1<<11)
+#define MF_QUERY_REMOTE     (1<<12)
+#define MF_QUERY_PROXY      (1<<13)
+#define MF_EXTERNAL_CERT    (1<<14)
 
 bool management_open(struct management *man,
                      const char *addr,
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bf25ef06..a3e0e90c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3025,6 +3025,35 @@ options_postprocess_verify(const struct options *o)
     }
 }
 
+#if defined(ENABLE_CRYPTOAPI) || (defined(ENABLE_CRYPTO_OPENSSL) && defined(ENABLE_MANAGEMENT))
+static void
+disable_tls13_if_avilable(struct options *o, const char *msg)
+{
+#if OPENSSL_VERSION_NUMBER >= 0x10100000L
+    const int tls_version_max =
+        (o->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) &
+            SSLF_TLS_VERSION_MAX_MASK;
+
+    /*
+     * The library we are *linked* against is OpenSSL 1.1.1 and therefore 
+     * supports TLS 1.3. This needs to be checked at runtime since we can be
+     * compiled against 1.1.0 and then the library can be upgraded to 1.1.1
+     */
+    if (OpenSSL_version_num() >= 0x1010100fL &&
+        (tls_version_max == TLS_VER_UNSPEC || tls_version_max > TLS_VER_1_2))
+    {
+        msg(M_WARN, "%s Setting maximum TLS version to 1.2 ", msg);
+        o->ssl_flags &= ~(SSLF_TLS_VERSION_MAX_MASK <<
+                                                    SSLF_TLS_VERSION_MAX_SHIFT);
+        o->ssl_flags |= (TLS_VER_1_1 << SSLF_TLS_VERSION_MAX_SHIFT);
+
+    }
+#else
+    return;
+#endif
+}
+#endif
+
 static void
 options_postprocess_mutate(struct options *o)
 {
@@ -3105,6 +3134,27 @@ options_postprocess_mutate(struct options *o)
     }
 #endif
 
+#if defined(ENABLE_CRYPTO_MBEDTLS) && defined(MANAGMENT_EXTERNAL_KEY)
+    if (o->management_flags & MF_EXTERNAL_KEY_NOPADDING)
+    {
+        msg(M_FATAL, "mbed TLS does not support the 'nopadding' argument for the --management-external-key option");
+    }
+#endif
+
+#if defined(ENABLE_CRYPTOAPI)
+    if (o->cryptoapi_cert)
+    {
+        disable_tls13_if_avilable(o, "Warning: cryptapicert used.");
+    }
+#endif
+#if defined(ENABLE_CRYPTO_OPENSSL) && defined(ENABLE_MANAGEMENT)
+    if ((o->management_flags & MF_EXTERNAL_KEY) &&
+        !(o->management_flags & MF_EXTERNAL_KEY_NOPADDING))
+    {
+        disable_tls13_if_avilable(o, "Warning: Using management-external-key "
+                                     "without nopadding option.");
+    }
+#endif
 #if P2MP
     /*
      * Save certain parms before modifying options via --pull
@@ -5181,9 +5231,13 @@ add_option(struct options *options,
         options->management_write_peer_info_file = p[1];
     }
 #ifdef ENABLE_MANAGEMENT
-    else if (streq(p[0], "management-external-key") && !p[1])
+    else if (streq(p[0], "management-external-key") && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
+        if (p[1] && streq(p[1], "nopadding"))
+        {
+            options->management_flags |= MF_EXTERNAL_KEY_NOPADDING;
+        }
         options->management_flags |= MF_EXTERNAL_KEY;
     }
     else if (streq(p[0], "management-external-cert") && p[1] && !p[2])
@@ -8455,4 +8509,4 @@ add_option(struct options *options,
     }
 err:
     gc_free(&gc);
-}
\ No newline at end of file
+}
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 99a8719f..f081d44c 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1093,22 +1093,37 @@ openvpn_extkey_rsa_finish(RSA *rsa)
     return 1;
 }
 
-/* Pass the input hash in 'dgst' to management and get the signature back.
+/*
+ * Pass the input hash in 'dgst' to management and get the signature back.
  * On input siglen contains the capacity of the buffer 'sig'.
  * On return signature is in sig.
+ * pkcs1 controls if pkcs1 padding is required
  * Return value is signature length or -1 on error.
  */
 static int
 get_sig_from_man(const unsigned char *dgst, unsigned int dgstlen,
-                 unsigned char *sig, unsigned int siglen)
+                 unsigned char *sig, unsigned int siglen,
+                 bool pkcs1pad)
 {
     char *in_b64 = NULL;
     char *out_b64 = NULL;
     int len = -1;
+    int bencret = -1;
 
-    /* convert 'dgst' to base64 */
-    if (management
-        && openvpn_base64_encode(dgst, dgstlen, &in_b64) > 0)
+    if ((management->settings.flags & MF_EXTERNAL_KEY_NOPADDING) && pkcs1pad)
+    {
+        /*
+         * Add PKCS1 signature and replace input with it
+         * Use our output buffer also als temporary buffer
+         */
+        RSA_padding_add_PKCS1_type_1(sig, siglen, dgst, dgstlen);
+        bencret = openvpn_base64_encode(sig, siglen, &in_b64);
+    }
+    else
+    {
+        bencret = openvpn_base64_encode(dgst, dgstlen, &in_b64);
+    }
+    if (management && bencret > 0)
     {
         out_b64 = management_query_pk_sig(management, in_b64);
     }
@@ -1124,18 +1139,19 @@ get_sig_from_man(const unsigned char *dgst, unsigned int dgstlen,
 
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
+    ret = get_sig_from_man(from, flen, to, len, padding == RSA_PKCS1_PADDING);
 
     return (ret == len)? ret : -1;
 }
@@ -1229,7 +1245,7 @@ ecdsa_sign(int type, const unsigned char *dgst, int dgstlen, unsigned char *sig,
            unsigned int *siglen, const BIGNUM *kinv, const BIGNUM *r, EC_KEY *ec)
 {
     int capacity = ECDSA_size(ec);
-    int len = get_sig_from_man(dgst, dgstlen, sig, capacity);
+    int len = get_sig_from_man(dgst, dgstlen, sig, capacity, false);
 
     if (len > 0)
     {
-- 
2.19.0


