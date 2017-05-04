From: David Sommerseth <davids@...515...>
Date: Thu,  4 May 2017 22:42:01 +0200
Message-Id: <20170504204201.1257-1-davids@...515...>
In-Reply-To: <20170426160021.25122-1-davids@...515...>
References: <20170426160021.25122-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH v2] crypto: Enable SHA256 fingerprint
	checking in --verify-hash
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

This enhances --verify-hash with an optional algorithm flag.  If not
provided, it defaults to SHA1 to preserve backwards compatbilitity with
existing configurations.  The only valid flags are SHA1 and SHA256.

In addition enhance the layout of the --verify-hash section in the man
page.

Signed-off-by: David Sommerseth <davids@...515...>
---

 v2 - Ensure ca_hash is initialized to a known value
    - Add a default target to the switch()
    - Move back to memcmp(), as memcmp_constant_time() isn't really
      needed here; the result of MD hashes have defined lengths
      regardless of the certificates an attacker may decide to use.

Simple test script
==================

* Server:
  # openvpn --dev tun --reneg-sec 60 --verb 4 \
            --server 10.8.0.0 255.255.255.0 --topology subnet \
            --ca sample/sample-keys/ca.crt \
            --key sample/sample-keys/server.key \
            --cert sample/sample-keys/server.crt \
            --dh sample/sample-keys/dh2048.pem \
            --cipher AES-256-CBC --auth SHA256 \
            --verify-hash 57:4D:B3:49:7E:FB:9E:FD:DC:BC:A4:ED:BC:B3:C2:8D:C3:D7:2A:E3:0F:6F:76:57:F0:BB:F4:90:56:1C:DC:F8 SHA256

* Client:
  # openvpn --dev tun --verb 4 \
            --remote 192.168.122.1 --explicit-exit-notify \
            --client --ca sample/sample-keys/ca.crt \
            --key sample/sample-keys/client.key \
            --cert sample/sample-keys/client.crt \
            --cipher AES-256-CBC --auth SHA256 \
            --verify-hash 06:30:DA:EA:77:41:5B:D6:8C:C5:CC:CA:F5:D7:91:87:FA:6D:89:44

  Alternative --verify-hash variant which must succeed:
     --verify-hash 06:30:DA:EA:77:41:5B:D6:8C:C5:CC:CA:F5:D7:91:87:FA:6D:89:44 SHA1

  These --verify-hash variants must fail:
     --verify-hash 06:30:DA:EA:77:41:5B:D6:8C:C5:CC:CA:F5:D7:91:87:FA:6D:89:44 SHA256
     --verify-hash 57:4D:B3:49:7E:FB:9E:FD:DC:BC:A4:ED:BC:B3:C2:8D:C3:D7:2A:E3:0F:6F:76:57:F0:BB:F4:90:56:1C:DC:F9
     --verify-hash 57:4D:B3:49:7E:FB:9E:FD:DC:BC:A4:ED:BC:B3:C2:8D:C3:D7:2A:E3:0F:6F:76:57:F0:BB:F4:90:56:1C:DC:00 SHA256
     --verify-hash 06:30:DA:EA:77:41:5B:D6:8C:C5:CC:CA:F5:D7:91:87:FA:6D:89:00 SHA1
     --verify-hash 06:30:DA:EA:77:41:5B:D6:8C:C5:CC:CA:F5:D7:91:87:FA:6D:89:00
     --verify-hash 06:30:DA:EA:77:41:5B:D6:8C:C5:CC:CA:F5:D7:91:87:FA:6D:89:XX

To retrieve the SHA fingerprints in certificates:

    $ openssl x509 -noout -fingerprint -in sample/sample-keys/ca.crt
    $ openssl x509 -noout -fingerprint -sha256 -in sample/sample-keys/ca.crt
---
 Changes.rst                  |  3 +++
 doc/openvpn.8                | 18 +++++++++++++++---
 src/openvpn/crypto_backend.h |  6 ++++++
 src/openvpn/init.c           |  1 +
 src/openvpn/options.c        | 22 +++++++++++++++++++---
 src/openvpn/options.h        |  5 +++++
 src/openvpn/ssl_common.h     |  1 +
 src/openvpn/ssl_verify.c     | 27 +++++++++++++++++++++++++--
 8 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 2a94990e..da93060c 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -318,3 +318,6 @@ Version 2.4.1
    ``--remote-cert-tls`` uses the far more common keyUsage and extendedKeyUsage
    extension instead.  Make sure your certificates carry these to be able to
    use ``--remote-cert-tls``.
+ - ``--verify-hash`` can now take an optional flag which changes the hashing
+   algorithm. It can be either SHA1 or SHA256.  The default if not provided is
+   SHA1 to preserve backwards compatibility with existing configurations.
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index c3248fde..fcf825c6 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4694,15 +4694,27 @@ and
 Not available with PolarSSL.
 .\"*********************************************************
 .TP
-.B \-\-verify\-hash hash
-Specify SHA1 fingerprint for level-1 cert.  The level-1 cert is the
+.B \-\-verify\-hash hash [algo]
+Specify SHA1 or SHA256 fingerprint for level-1 cert.  The level-1 cert is the
 CA (or intermediate cert) that signs the leaf certificate, and is
 one removed from the leaf certificate in the direction of the root.
 When accepting a connection from a peer, the level-1 cert
 fingerprint must match
 .B hash
 or certificate verification will fail.  Hash is specified
-as XX:XX:...  For example: AD:B0:95:D8:09:C8:36:45:12:A9:89:C8:90:09:CB:13:72:A6:AD:16
+as XX:XX:... For example:
+
+.nf
+.ft 3
+.in +4
+AD:B0:95:D8:09:C8:36:45:12:A9:89:C8:90:09:CB:13:72:A6:AD:16
+.in -4
+.ft
+.fi
+
+The
+.B algo
+flag can be either SHA1 or SHA256.  If not provided, it defaults to SHA1.
 .\"*********************************************************
 .TP
 .B \-\-pkcs11\-cert\-private [0|1]...
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 2c79baa1..9b113d7b 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -47,6 +47,12 @@
 /* Maximum HMAC digest size (bytes) */
 #define OPENVPN_MAX_HMAC_SIZE   64
 
+/** Types referencing specific message digest hashing algorithms */
+typedef enum {
+    MD_SHA1,
+    MD_SHA256
+} hash_algo_type ;
+
 /** Struct used in cipher name translation table */
 typedef struct {
     const char *openvpn_name;   /**< Cipher name used by OpenVPN */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ee14f672..e9455039 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2619,6 +2619,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     memmove(to.remote_cert_ku, options->remote_cert_ku, sizeof(to.remote_cert_ku));
     to.remote_cert_eku = options->remote_cert_eku;
     to.verify_hash = options->verify_hash;
+    to.verify_hash_algo = options->verify_hash_algo;
 #ifdef ENABLE_X509ALTUSERNAME
     to.x509_username_field = (char *) options->x509_username_field;
 #else
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index dcb6ecfa..f38abad7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -591,7 +591,8 @@ static const char usage_message[] =
     "--x509-username-field : Field in x509 certificate containing the username.\n"
     "                        Default is CN in the Subject field.\n"
 #endif
-    "--verify-hash   : Specify SHA1 fingerprint for level-1 cert.\n"
+    "--verify-hash hash [algo] : Specify fingerprint for level-1 certificate.\n"
+    "                            Valid algo flags are SHA1 and SHA256. \n"
 #ifdef _WIN32
     "--cryptoapicert select-string : Load the certificate and private key from the\n"
     "                  Windows Certificate System Store.\n"
@@ -7687,10 +7688,25 @@ add_option(struct options *options,
             options->extra_certs_file_inline = p[2];
         }
     }
-    else if (streq(p[0], "verify-hash") && p[1] && !p[2])
+    else if (streq(p[0], "verify-hash") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->verify_hash = parse_hash_fingerprint(p[1], SHA_DIGEST_LENGTH, msglevel, &options->gc);
+
+        if (!p[2] || (p[2] && streq(p[2], "SHA1")))
+        {
+            options->verify_hash = parse_hash_fingerprint(p[1], SHA_DIGEST_LENGTH, msglevel, &options->gc);
+            options->verify_hash_algo = MD_SHA1;
+        }
+        else if (p[2] && streq(p[2], "SHA256"))
+        {
+            options->verify_hash = parse_hash_fingerprint(p[1], SHA256_DIGEST_LENGTH, msglevel, &options->gc);
+            options->verify_hash_algo = MD_SHA256;
+        }
+        else
+        {
+            msg(msglevel, "invalid or unsupported hashing algorithm: %s  (only SHA1 and SHA256 are valid)", p[2]);
+            goto err;
+        }
     }
 #ifdef ENABLE_CRYPTOAPI
     else if (streq(p[0], "cryptoapicert") && p[1] && !p[2])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index dc63aeda..5ad087e0 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -42,6 +42,10 @@
 #include "comp.h"
 #include "pushlist.h"
 #include "clinat.h"
+#ifdef ENABLE_CRYPTO
+#include "crypto_backend.h"
+#endif
+
 
 /*
  * Maximum number of parameters associated with an option,
@@ -518,6 +522,7 @@ struct options
     unsigned remote_cert_ku[MAX_PARMS];
     const char *remote_cert_eku;
     uint8_t *verify_hash;
+    hash_algo_type verify_hash_algo;
     unsigned int ssl_flags; /* set to SSLF_x flags from ssl.h */
 
 #ifdef ENABLE_PKCS11
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 9a16d77e..a99d24d6 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -271,6 +271,7 @@ struct tls_options
     unsigned remote_cert_ku[MAX_PARMS];
     const char *remote_cert_eku;
     uint8_t *verify_hash;
+    hash_algo_type verify_hash_algo;
     char *x509_username_field;
 
     /* allow openvpn config info to be
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index ac1e110a..078b65ad 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -718,8 +718,31 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
     /* verify level 1 cert, i.e. the CA that signed our leaf cert */
     if (cert_depth == 1 && opt->verify_hash)
     {
-        struct buffer sha1_hash = x509_get_sha1_fingerprint(cert, &gc);
-        if (memcmp(BPTR(&sha1_hash), opt->verify_hash, BLEN(&sha1_hash)))
+        struct buffer ca_hash = {0};
+
+        switch (opt->verify_hash_algo)
+        {
+        case MD_SHA1:
+            ca_hash = x509_get_sha1_fingerprint(cert, &gc);
+            break;
+
+        case MD_SHA256:
+            ca_hash = x509_get_sha256_fingerprint(cert, &gc);
+            break;
+
+        default:
+            /* This should normally not happen at all; the algorithm used
+             * is parsed by add_option() [options.c] and set to a predefined
+             * value in an enumerated type.  So if this unlikely scenario
+             * happens, consider this a failure
+             */
+            msg(M_WARN, "Unexpected invalid algorithm used with "
+                "--verify-hash (%i)", opt->verify_hash_algo);
+            ret = FAILURE;
+            goto cleanup;
+        }
+
+        if (memcmp(BPTR(&ca_hash), opt->verify_hash, BLEN(&ca_hash)))
         {
             msg(D_TLS_ERRORS, "TLS Error: level-1 certificate hash verification failed");
             goto cleanup;
-- 
2.11.0


