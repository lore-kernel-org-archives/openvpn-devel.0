From: Steffan Karger <steffan@...1856...>
Date: Wed, 15 Mar 2017 22:20:20 +0100
Message-Id: <1489612820-15284-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Be less picky about keyUsage extensions
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

We long recommended users to use --ns-cert-type to distinguish between
client and server certificates, but that extension is long deprecated and
now can even no longer be accurately checked in OpenSSL 1.1+.  We support
a more modern alternative, --remote-cert-tls (which expands to
--remote-cert-ku + --remote-cert-eku), but are overly strict in checking
the keyUsage.  This patch makes our implementation less picky, so that
correct-but-slightly-weird certicates will not immediately be rejected.

We currently allow users to specify a list of allowed keyUsage values, and
require that the remote certificate matches one of these values exactly.
This is for more strict than keyUsage usually requires; which is that a
certificate is okay to use if it can *at least* be used for our intended
purpose.  This patch changes the behaviour to match that, by using the
library-provided mbedtls_x509_crt_check_key_usage() function in mbed TLS
builds, and performing the 'at least bits xyz' check for OpenSSL builds
(OpenSSL unfortunately does not expose a similar function).

Furthermore, this patch adds better error messages when the checking fails;
it now explains that is expects to match either of the supplied values,
and only does so if the check actually failed.

This patch also changes --remote-cert-tls to still require a specific EKU,
but only *some* keyUsage value.  Both our supported crypto libraries will
check the keyUsage value for correctness during the handshake, but only if
it is present.  So this still enforces a correct keyUsage, but is a bit
less picky about certificates that do not exactly match expectations.

This patch should be applied together with the 'deprecate --ns-cert-type'
patch I sent earlier.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 Changes.rst                      |  7 ++++
 doc/openvpn.8                    | 33 ++++++++++--------
 src/openvpn/options.c            | 15 +++++----
 src/openvpn/ssl_verify.h         |  3 ++
 src/openvpn/ssl_verify_mbedtls.c | 42 ++++++++++++++---------
 src/openvpn/ssl_verify_openssl.c | 72 +++++++++++++++++++++-------------------
 6 files changed, 102 insertions(+), 70 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 0af29e3..2a94990 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -306,6 +306,13 @@ Maintainer-visible changes
 
 Version 2.4.1
 =============
+ - ``--remote-cert-ku`` now only requires the certificate to have at least the
+   bits set of one of the values in the supplied list, instead of requiring an
+   exact match to one of the values in the list.
+ - ``--remote-cert-tls`` now only requires that a keyUsage is present in the
+   certificate, and leaves the verification of the value up to the crypto
+   library, which has more information (i.e. the key exchange method in use)
+   to verify that the keyUsage is correct.
  - ``--ns-cert-type`` is deprecated.  Use ``--remote-cert-tls`` instead.
    The nsCertType x509 extension is very old, and barely used.
    ``--remote-cert-tls`` uses the far more common keyUsage and extendedKeyUsage
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index f6822ec..89229fb 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5344,15 +5344,25 @@ or
 .B \-\-tls\-verify.
 .\"*********************************************************
 .TP
-.B \-\-remote\-cert\-ku v...
+.B \-\-remote\-cert\-ku [v...]
 Require that peer certificate was signed with an explicit
 .B key usage.
 
-This is a useful security option for clients, to ensure that
-the host they connect to is a designated server.
+If present in the certificate, the keyUsage value is validated by the TLS
+library during the TLS handshake.  Specifying this option without arguments
+requires this extension to be present (so the TLS library will verify it).
 
-The key usage should be encoded in hex, more than one key
-usage can be specified.
+If the list
+.B v...
+is also supplied, the keyUsage field must have
+.B at least
+the same bits set as the bits in
+.B one of
+the values supplied in the list
+.B v...
+
+The key usage values in the list must be encoded in hex, e.g.
+"\-\-remote\-cert\-ku a0"
 .\"*********************************************************
 .TP
 .B \-\-remote\-cert\-eku oid
@@ -5373,24 +5383,21 @@ and
 .B extended key usage
 based on RFC3280 TLS rules.
 
-This is a useful security option for clients, to ensure that
-the host they connect to is a designated server.
+This is a useful security option for clients, to ensure that the host they
+connect to is a designated server.  Or the other way around; for a server to
+verify that only hosts with a client certificate can connect.
 
 The
 .B \-\-remote\-cert\-tls client
 option is equivalent to
 .B
-\-\-remote\-cert\-ku 80 08 88 \-\-remote\-cert\-eku "TLS Web Client Authentication"
-
-The key usage is digitalSignature and/or keyAgreement.
+\-\-remote\-cert\-ku \-\-remote\-cert\-eku "TLS Web Client Authentication"
 
 The
 .B \-\-remote\-cert\-tls server
 option is equivalent to
 .B
-\-\-remote\-cert\-ku a0 88 \-\-remote\-cert\-eku "TLS Web Server Authentication"
-
-The key usage is digitalSignature and ( keyEncipherment or keyAgreement ).
+\-\-remote\-cert\-ku \-\-remote\-cert\-eku "TLS Web Server Authentication"
 
 This is an important security precaution to protect against
 a man-in-the-middle attack where an authorized client
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1243db0..d0d39f6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7950,14 +7950,18 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "remote-cert-ku"))
     {
-        int j;
-
         VERIFY_PERMISSION(OPT_P_GENERAL);
 
+        size_t j;
         for (j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
         {
             sscanf(p[j], "%x", &(options->remote_cert_ku[j-1]));
         }
+        if (j == 1)
+        {
+            /* No specific KU required, but require KU to be present */
+            options->remote_cert_ku[0] = OPENVPN_KU_REQUIRED;
+        }
     }
     else if (streq(p[0], "remote-cert-eku") && p[1] && !p[2])
     {
@@ -7970,15 +7974,12 @@ add_option(struct options *options,
 
         if (streq(p[1], "server"))
         {
-            options->remote_cert_ku[0] = 0xa0;
-            options->remote_cert_ku[1] = 0x88;
+            options->remote_cert_ku[0] = OPENVPN_KU_REQUIRED;
             options->remote_cert_eku = "TLS Web Server Authentication";
         }
         else if (streq(p[1], "client"))
         {
-            options->remote_cert_ku[0] = 0x80;
-            options->remote_cert_ku[1] = 0x08;
-            options->remote_cert_ku[2] = 0x88;
+            options->remote_cert_ku[0] = OPENVPN_KU_REQUIRED;
             options->remote_cert_eku = "TLS Web Client Authentication";
         }
         else
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index ffab218..22a6190 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -218,6 +218,9 @@ struct x509_track
 /** Do not perform Netscape certificate type verification */
 #define NS_CERT_CHECK_CLIENT (1<<1)
 
+/** Require keyUsage to be present in cert (0xFFFF is an invalid KU value) */
+#define OPENVPN_KU_REQUIRED (0xFFFF)
+
 /*
  * TODO: document
  */
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 4068dd3..c32e481 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -437,32 +437,42 @@ result_t
 x509_verify_cert_ku(mbedtls_x509_crt *cert, const unsigned *const expected_ku,
                     int expected_len)
 {
-    result_t fFound = FAILURE;
+    msg(D_HANDSHAKE, "Validating certificate key usage");
 
     if (!(cert->ext_types & MBEDTLS_X509_EXT_KEY_USAGE))
     {
-        msg(D_HANDSHAKE, "Certificate does not have key usage extension");
+        msg(D_TLS_ERRORS,
+            "ERROR: Certificate does not have key usage extension");
+        return FAILURE;
     }
-    else
+
+    if (expected_ku[0] == OPENVPN_KU_REQUIRED)
     {
-        int i;
-        unsigned nku = cert->key_usage;
+        /* Extension required, value checked by TLS library */
+        return SUCCESS;
+    }
 
-        msg(D_HANDSHAKE, "Validating certificate key usage");
-        for (i = 0; SUCCESS != fFound && i<expected_len; i++)
+    result_t fFound = FAILURE;
+    for (size_t i = 0; SUCCESS != fFound && i<expected_len; i++)
+    {
+        if (expected_ku[i] != 0
+            && 0 == mbedtls_x509_crt_check_key_usage(cert, expected_ku[i]))
         {
-            if (expected_ku[i] != 0)
-            {
-                msg(D_HANDSHAKE, "++ Certificate has key usage  %04x, expects "
-                    "%04x", nku, expected_ku[i]);
+            fFound = SUCCESS;
+        }
+    }
 
-                if (nku == expected_ku[i])
-                {
-                    fFound = SUCCESS;
-                }
-            }
+    if (fFound != SUCCESS)
+    {
+        msg(D_TLS_ERRORS,
+            "ERROR: Certificate has key usage %04x, expected one of:",
+            cert->key_usage);
+        for (size_t i = 0; i < expected_len && expected_ku[i]; i++)
+        {
+            msg(D_TLS_ERRORS, " * %04x", expected_ku[i]);
         }
     }
+
     return fFound;
 }
 
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 5bdd1e3..d598240 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -600,55 +600,59 @@ result_t
 x509_verify_cert_ku(X509 *x509, const unsigned *const expected_ku,
                     int expected_len)
 {
-    ASN1_BIT_STRING *ku = NULL;
-    result_t fFound = FAILURE;
+    ASN1_BIT_STRING *ku = X509_get_ext_d2i(x509, NID_key_usage, NULL, NULL);
 
-    if ((ku = (ASN1_BIT_STRING *) X509_get_ext_d2i(x509, NID_key_usage, NULL,
-                                                   NULL)) == NULL)
+    if (ku == NULL)
     {
-        msg(D_HANDSHAKE, "Certificate does not have key usage extension");
+        msg(D_TLS_ERRORS, "Certificate does not have key usage extension");
+        return FAILURE;
     }
-    else
+
+    if (expected_ku[0] == OPENVPN_KU_REQUIRED)
     {
-        unsigned nku = 0;
-        int i;
-        for (i = 0; i < 8; i++)
-        {
-            if (ASN1_BIT_STRING_get_bit(ku, i))
-            {
-                nku |= 1 << (7 - i);
-            }
-        }
+        /* Extension required, value checked by TLS library */
+        return SUCCESS;
+    }
 
-        /*
-         * Fixup if no LSB bits
-         */
-        if ((nku & 0xff) == 0)
+    unsigned nku = 0;
+    for (size_t i = 0; i < 8; i++)
+    {
+        if (ASN1_BIT_STRING_get_bit(ku, i))
         {
-            nku >>= 8;
+            nku |= 1 << (7 - i);
         }
+    }
 
-        msg(D_HANDSHAKE, "Validating certificate key usage");
-        for (i = 0; fFound != SUCCESS && i < expected_len; i++)
-        {
-            if (expected_ku[i] != 0)
-            {
-                msg(D_HANDSHAKE, "++ Certificate has key usage  %04x, expects "
-                    "%04x", nku, expected_ku[i]);
+    /*
+     * Fixup if no LSB bits
+     */
+    if ((nku & 0xff) == 0)
+    {
+        nku >>= 8;
+    }
 
-                if (nku == expected_ku[i])
-                {
-                    fFound = SUCCESS;
-                }
-            }
+    msg(D_HANDSHAKE, "Validating certificate key usage");
+    result_t fFound = FAILURE;
+    for (size_t i = 0; fFound != SUCCESS && i < expected_len; i++)
+    {
+        if (expected_ku[i] != 0 && (nku & expected_ku[i]) == expected_ku[i])
+        {
+            fFound = SUCCESS;
         }
     }
 
-    if (ku != NULL)
+    if (fFound != SUCCESS)
     {
-        ASN1_BIT_STRING_free(ku);
+        msg(D_TLS_ERRORS,
+            "ERROR: Certificate has key usage %04x, expected one of:", nku);
+        for (size_t i = 0; i < expected_len && expected_ku[i]; i++)
+        {
+            msg(D_TLS_ERRORS, " * %04x", expected_ku[i]);
+        }
     }
 
+    ASN1_BIT_STRING_free(ku);
+
     return fFound;
 }
 
-- 
2.7.4


