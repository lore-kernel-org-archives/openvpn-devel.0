From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 7 Dec 2023 17:49:42 +0000
References: <gerrit.1701971374000.I605394d4f3872a168d05bbbe52d90f6d48935865@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <d21a5c1e55e4a212f8d31f9a135e25bdf6ffcddb-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SVcGJDC1M+8="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Move
 tls_get_cipher_name_pair and get_num_elements to ssl_utils.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SVcGJDC1M+8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/470?usp=3Demail

to review the following change.


Change subject: Move tls_get_cipher_name_pair and get_num_elements to ssl_u=
tils.c
......................................................................

Move tls_get_cipher_name_pair and get_num_elements to ssl_utils.c

This allow these functions to be defined without having to include ssl.c/mi=
sc.c
which pulls in a lot of more dependencies.

Change-Id: I605394d4f3872a168d05bbbe52d90f6d48935865
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/misc.c
M src/openvpn/misc.h
M src/openvpn/ssl.c
M src/openvpn/ssl_backend.h
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_openssl.c
M src/openvpn/ssl_util.c
M src/openvpn/ssl_util.h
8 files changed, 211 insertions(+), 208 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/470/1

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index ce6e4fd..bce63ed 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -773,26 +773,6 @@
     }
 }

-int
-get_num_elements(const char *string, char delimiter)
-{
-    int string_len =3D strlen(string);
-
-    ASSERT(0 !=3D string_len);
-
-    int element_count =3D 1;
-    /* Get number of ciphers */
-    for (int i =3D 0; i < string_len; i++)
-    {
-        if (string[i] =3D=3D delimiter)
-        {
-            element_count++;
-        }
-    }
-
-    return element_count;
-}
-
 struct buffer
 prepend_dir(const char *dir, const char *path, struct gc_arena *gc)
 {
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index b000b72..70a24dd 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -193,20 +193,6 @@
 void output_peer_info_env(struct env_set *es, const char *peer_info);

 /**
- * Returns the occurrences of 'delimiter' in a string +1
- * This is typically used to find out the number elements in a
- * cipher string or similar that is separated by : like
- *
- *   X25519:secp256r1:X448:secp512r1:secp384r1:brainpoolP384r1
- *
- * @param string        the string to work on
- * @param delimiter     the delimiter to count, typically ':'
- * @return              occrrences of delimiter + 1
- */
-int
-get_num_elements(const char *string, char delimiter);
-
-/**
  * Prepend a directory to a path.
  */
 struct buffer
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3e3696c..6eddb68 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -95,152 +95,6 @@
 #endif /* ifdef MEASURE_TLS_HANDSHAKE_STATS */

 /**
- * SSL/TLS Cipher suite name translation table
- */
-static const tls_cipher_name_pair tls_cipher_name_translation_table[] =3D {
-    {"ADH-SEED-SHA", "TLS-DH-anon-WITH-SEED-CBC-SHA"},
-    {"AES128-GCM-SHA256", "TLS-RSA-WITH-AES-128-GCM-SHA256"},
-    {"AES128-SHA256", "TLS-RSA-WITH-AES-128-CBC-SHA256"},
-    {"AES128-SHA", "TLS-RSA-WITH-AES-128-CBC-SHA"},
-    {"AES256-GCM-SHA384", "TLS-RSA-WITH-AES-256-GCM-SHA384"},
-    {"AES256-SHA256", "TLS-RSA-WITH-AES-256-CBC-SHA256"},
-    {"AES256-SHA", "TLS-RSA-WITH-AES-256-CBC-SHA"},
-    {"CAMELLIA128-SHA256", "TLS-RSA-WITH-CAMELLIA-128-CBC-SHA256"},
-    {"CAMELLIA128-SHA", "TLS-RSA-WITH-CAMELLIA-128-CBC-SHA"},
-    {"CAMELLIA256-SHA256", "TLS-RSA-WITH-CAMELLIA-256-CBC-SHA256"},
-    {"CAMELLIA256-SHA", "TLS-RSA-WITH-CAMELLIA-256-CBC-SHA"},
-    {"DES-CBC3-SHA", "TLS-RSA-WITH-3DES-EDE-CBC-SHA"},
-    {"DES-CBC-SHA", "TLS-RSA-WITH-DES-CBC-SHA"},
-    {"DH-DSS-SEED-SHA", "TLS-DH-DSS-WITH-SEED-CBC-SHA"},
-    {"DHE-DSS-AES128-GCM-SHA256", "TLS-DHE-DSS-WITH-AES-128-GCM-SHA256"},
-    {"DHE-DSS-AES128-SHA256", "TLS-DHE-DSS-WITH-AES-128-CBC-SHA256"},
-    {"DHE-DSS-AES128-SHA", "TLS-DHE-DSS-WITH-AES-128-CBC-SHA"},
-    {"DHE-DSS-AES256-GCM-SHA384", "TLS-DHE-DSS-WITH-AES-256-GCM-SHA384"},
-    {"DHE-DSS-AES256-SHA256", "TLS-DHE-DSS-WITH-AES-256-CBC-SHA256"},
-    {"DHE-DSS-AES256-SHA", "TLS-DHE-DSS-WITH-AES-256-CBC-SHA"},
-    {"DHE-DSS-CAMELLIA128-SHA256", "TLS-DHE-DSS-WITH-CAMELLIA-128-CBC-SHA2=
56"},
-    {"DHE-DSS-CAMELLIA128-SHA", "TLS-DHE-DSS-WITH-CAMELLIA-128-CBC-SHA"},
-    {"DHE-DSS-CAMELLIA256-SHA256", "TLS-DHE-DSS-WITH-CAMELLIA-256-CBC-SHA2=
56"},
-    {"DHE-DSS-CAMELLIA256-SHA", "TLS-DHE-DSS-WITH-CAMELLIA-256-CBC-SHA"},
-    {"DHE-DSS-SEED-SHA", "TLS-DHE-DSS-WITH-SEED-CBC-SHA"},
-    {"DHE-RSA-AES128-GCM-SHA256", "TLS-DHE-RSA-WITH-AES-128-GCM-SHA256"},
-    {"DHE-RSA-AES128-SHA256", "TLS-DHE-RSA-WITH-AES-128-CBC-SHA256"},
-    {"DHE-RSA-AES128-SHA", "TLS-DHE-RSA-WITH-AES-128-CBC-SHA"},
-    {"DHE-RSA-AES256-GCM-SHA384", "TLS-DHE-RSA-WITH-AES-256-GCM-SHA384"},
-    {"DHE-RSA-AES256-SHA256", "TLS-DHE-RSA-WITH-AES-256-CBC-SHA256"},
-    {"DHE-RSA-AES256-SHA", "TLS-DHE-RSA-WITH-AES-256-CBC-SHA"},
-    {"DHE-RSA-CAMELLIA128-SHA256", "TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA2=
56"},
-    {"DHE-RSA-CAMELLIA128-SHA", "TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA"},
-    {"DHE-RSA-CAMELLIA256-SHA256", "TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SHA2=
56"},
-    {"DHE-RSA-CAMELLIA256-SHA", "TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SHA"},
-    {"DHE-RSA-CHACHA20-POLY1305", "TLS-DHE-RSA-WITH-CHACHA20-POLY1305-SHA2=
56"},
-    {"DHE-RSA-SEED-SHA", "TLS-DHE-RSA-WITH-SEED-CBC-SHA"},
-    {"DH-RSA-SEED-SHA", "TLS-DH-RSA-WITH-SEED-CBC-SHA"},
-    {"ECDH-ECDSA-AES128-GCM-SHA256", "TLS-ECDH-ECDSA-WITH-AES-128-GCM-SHA2=
56"},
-    {"ECDH-ECDSA-AES128-SHA256", "TLS-ECDH-ECDSA-WITH-AES-128-CBC-SHA256"},
-    {"ECDH-ECDSA-AES128-SHA", "TLS-ECDH-ECDSA-WITH-AES-128-CBC-SHA"},
-    {"ECDH-ECDSA-AES256-GCM-SHA384", "TLS-ECDH-ECDSA-WITH-AES-256-GCM-SHA3=
84"},
-    {"ECDH-ECDSA-AES256-SHA256", "TLS-ECDH-ECDSA-WITH-AES-256-CBC-SHA256"},
-    {"ECDH-ECDSA-AES256-SHA384", "TLS-ECDH-ECDSA-WITH-AES-256-CBC-SHA384"},
-    {"ECDH-ECDSA-AES256-SHA", "TLS-ECDH-ECDSA-WITH-AES-256-CBC-SHA"},
-    {"ECDH-ECDSA-CAMELLIA128-SHA256", "TLS-ECDH-ECDSA-WITH-CAMELLIA-128-CB=
C-SHA256"},
-    {"ECDH-ECDSA-CAMELLIA128-SHA", "TLS-ECDH-ECDSA-WITH-CAMELLIA-128-CBC-S=
HA"},
-    {"ECDH-ECDSA-CAMELLIA256-SHA256", "TLS-ECDH-ECDSA-WITH-CAMELLIA-256-CB=
C-SHA256"},
-    {"ECDH-ECDSA-CAMELLIA256-SHA", "TLS-ECDH-ECDSA-WITH-CAMELLIA-256-CBC-S=
HA"},
-    {"ECDH-ECDSA-DES-CBC3-SHA", "TLS-ECDH-ECDSA-WITH-3DES-EDE-CBC-SHA"},
-    {"ECDH-ECDSA-DES-CBC-SHA", "TLS-ECDH-ECDSA-WITH-DES-CBC-SHA"},
-    {"ECDH-ECDSA-RC4-SHA", "TLS-ECDH-ECDSA-WITH-RC4-128-SHA"},
-    {"ECDHE-ECDSA-AES128-GCM-SHA256", "TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SH=
A256"},
-    {"ECDHE-ECDSA-AES128-SHA256", "TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA256=
"},
-    {"ECDHE-ECDSA-AES128-SHA384", "TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA384=
"},
-    {"ECDHE-ECDSA-AES128-SHA", "TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA"},
-    {"ECDHE-ECDSA-AES256-GCM-SHA384", "TLS-ECDHE-ECDSA-WITH-AES-256-GCM-SH=
A384"},
-    {"ECDHE-ECDSA-AES256-SHA256", "TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA256=
"},
-    {"ECDHE-ECDSA-AES256-SHA384", "TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA384=
"},
-    {"ECDHE-ECDSA-AES256-SHA", "TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA"},
-    {"ECDHE-ECDSA-CAMELLIA128-SHA256", "TLS-ECDHE-ECDSA-WITH-CAMELLIA-128-=
CBC-SHA256"},
-    {"ECDHE-ECDSA-CAMELLIA128-SHA", "TLS-ECDHE-ECDSA-WITH-CAMELLIA-128-CBC=
-SHA"},
-    {"ECDHE-ECDSA-CAMELLIA256-SHA256", "TLS-ECDHE-ECDSA-WITH-CAMELLIA-256-=
CBC-SHA256"},
-    {"ECDHE-ECDSA-CAMELLIA256-SHA", "TLS-ECDHE-ECDSA-WITH-CAMELLIA-256-CBC=
-SHA"},
-    {"ECDHE-ECDSA-CHACHA20-POLY1305", "TLS-ECDHE-ECDSA-WITH-CHACHA20-POLY1=
305-SHA256"},
-    {"ECDHE-ECDSA-DES-CBC3-SHA", "TLS-ECDHE-ECDSA-WITH-3DES-EDE-CBC-SHA"},
-    {"ECDHE-ECDSA-DES-CBC-SHA", "TLS-ECDHE-ECDSA-WITH-DES-CBC-SHA"},
-    {"ECDHE-ECDSA-RC4-SHA", "TLS-ECDHE-ECDSA-WITH-RC4-128-SHA"},
-    {"ECDHE-RSA-AES128-GCM-SHA256", "TLS-ECDHE-RSA-WITH-AES-128-GCM-SHA256=
"},
-    {"ECDHE-RSA-AES128-SHA256", "TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA256"},
-    {"ECDHE-RSA-AES128-SHA384", "TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA384"},
-    {"ECDHE-RSA-AES128-SHA", "TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA"},
-    {"ECDHE-RSA-AES256-GCM-SHA384", "TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384=
"},
-    {"ECDHE-RSA-AES256-SHA256", "TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA256"},
-    {"ECDHE-RSA-AES256-SHA384", "TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA384"},
-    {"ECDHE-RSA-AES256-SHA", "TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA"},
-    {"ECDHE-RSA-CAMELLIA128-SHA256", "TLS-ECDHE-RSA-WITH-CAMELLIA-128-CBC-=
SHA256"},
-    {"ECDHE-RSA-CAMELLIA128-SHA", "TLS-ECDHE-RSA-WITH-CAMELLIA-128-CBC-SHA=
"},
-    {"ECDHE-RSA-CAMELLIA256-SHA256", "TLS-ECDHE-RSA-WITH-CAMELLIA-256-CBC-=
SHA256"},
-    {"ECDHE-RSA-CAMELLIA256-SHA", "TLS-ECDHE-RSA-WITH-CAMELLIA-256-CBC-SHA=
"},
-    {"ECDHE-RSA-CHACHA20-POLY1305", "TLS-ECDHE-RSA-WITH-CHACHA20-POLY1305-=
SHA256"},
-    {"ECDHE-RSA-DES-CBC3-SHA", "TLS-ECDHE-RSA-WITH-3DES-EDE-CBC-SHA"},
-    {"ECDHE-RSA-DES-CBC-SHA", "TLS-ECDHE-RSA-WITH-DES-CBC-SHA"},
-    {"ECDHE-RSA-RC4-SHA", "TLS-ECDHE-RSA-WITH-RC4-128-SHA"},
-    {"ECDH-RSA-AES128-GCM-SHA256", "TLS-ECDH-RSA-WITH-AES-128-GCM-SHA256"},
-    {"ECDH-RSA-AES128-SHA256", "TLS-ECDH-RSA-WITH-AES-128-CBC-SHA256"},
-    {"ECDH-RSA-AES128-SHA384", "TLS-ECDH-RSA-WITH-AES-128-CBC-SHA384"},
-    {"ECDH-RSA-AES128-SHA", "TLS-ECDH-RSA-WITH-AES-128-CBC-SHA"},
-    {"ECDH-RSA-AES256-GCM-SHA384", "TLS-ECDH-RSA-WITH-AES-256-GCM-SHA384"},
-    {"ECDH-RSA-AES256-SHA256", "TLS-ECDH-RSA-WITH-AES-256-CBC-SHA256"},
-    {"ECDH-RSA-AES256-SHA384", "TLS-ECDH-RSA-WITH-AES-256-CBC-SHA384"},
-    {"ECDH-RSA-AES256-SHA", "TLS-ECDH-RSA-WITH-AES-256-CBC-SHA"},
-    {"ECDH-RSA-CAMELLIA128-SHA256", "TLS-ECDH-RSA-WITH-CAMELLIA-128-CBC-SH=
A256"},
-    {"ECDH-RSA-CAMELLIA128-SHA", "TLS-ECDH-RSA-WITH-CAMELLIA-128-CBC-SHA"},
-    {"ECDH-RSA-CAMELLIA256-SHA256", "TLS-ECDH-RSA-WITH-CAMELLIA-256-CBC-SH=
A256"},
-    {"ECDH-RSA-CAMELLIA256-SHA", "TLS-ECDH-RSA-WITH-CAMELLIA-256-CBC-SHA"},
-    {"ECDH-RSA-DES-CBC3-SHA", "TLS-ECDH-RSA-WITH-3DES-EDE-CBC-SHA"},
-    {"ECDH-RSA-DES-CBC-SHA", "TLS-ECDH-RSA-WITH-DES-CBC-SHA"},
-    {"ECDH-RSA-RC4-SHA", "TLS-ECDH-RSA-WITH-RC4-128-SHA"},
-    {"EDH-DSS-DES-CBC3-SHA", "TLS-DHE-DSS-WITH-3DES-EDE-CBC-SHA"},
-    {"EDH-DSS-DES-CBC-SHA", "TLS-DHE-DSS-WITH-DES-CBC-SHA"},
-    {"EDH-RSA-DES-CBC3-SHA", "TLS-DHE-RSA-WITH-3DES-EDE-CBC-SHA"},
-    {"EDH-RSA-DES-CBC-SHA", "TLS-DHE-RSA-WITH-DES-CBC-SHA"},
-    {"EXP-DES-CBC-SHA", "TLS-RSA-EXPORT-WITH-DES40-CBC-SHA"},
-    {"EXP-EDH-DSS-DES-CBC-SHA", "TLS-DH-DSS-EXPORT-WITH-DES40-CBC-SHA"},
-    {"EXP-EDH-RSA-DES-CBC-SHA", "TLS-DH-RSA-EXPORT-WITH-DES40-CBC-SHA"},
-    {"EXP-RC2-CBC-MD5", "TLS-RSA-EXPORT-WITH-RC2-CBC-40-MD5"},
-    {"EXP-RC4-MD5", "TLS-RSA-EXPORT-WITH-RC4-40-MD5"},
-    {"NULL-MD5", "TLS-RSA-WITH-NULL-MD5"},
-    {"NULL-SHA256", "TLS-RSA-WITH-NULL-SHA256"},
-    {"NULL-SHA", "TLS-RSA-WITH-NULL-SHA"},
-    {"PSK-3DES-EDE-CBC-SHA", "TLS-PSK-WITH-3DES-EDE-CBC-SHA"},
-    {"PSK-AES128-CBC-SHA", "TLS-PSK-WITH-AES-128-CBC-SHA"},
-    {"PSK-AES256-CBC-SHA", "TLS-PSK-WITH-AES-256-CBC-SHA"},
-    {"PSK-RC4-SHA", "TLS-PSK-WITH-RC4-128-SHA"},
-    {"RC4-MD5", "TLS-RSA-WITH-RC4-128-MD5"},
-    {"RC4-SHA", "TLS-RSA-WITH-RC4-128-SHA"},
-    {"SEED-SHA", "TLS-RSA-WITH-SEED-CBC-SHA"},
-    {"SRP-DSS-3DES-EDE-CBC-SHA", "TLS-SRP-SHA-DSS-WITH-3DES-EDE-CBC-SHA"},
-    {"SRP-DSS-AES-128-CBC-SHA", "TLS-SRP-SHA-DSS-WITH-AES-128-CBC-SHA"},
-    {"SRP-DSS-AES-256-CBC-SHA", "TLS-SRP-SHA-DSS-WITH-AES-256-CBC-SHA"},
-    {"SRP-RSA-3DES-EDE-CBC-SHA", "TLS-SRP-SHA-RSA-WITH-3DES-EDE-CBC-SHA"},
-    {"SRP-RSA-AES-128-CBC-SHA", "TLS-SRP-SHA-RSA-WITH-AES-128-CBC-SHA"},
-    {"SRP-RSA-AES-256-CBC-SHA", "TLS-SRP-SHA-RSA-WITH-AES-256-CBC-SHA"},
-#ifdef ENABLE_CRYPTO_OPENSSL
-    /* OpenSSL-specific group names */
-    {"DEFAULT", "DEFAULT"},
-    {"ALL", "ALL"},
-    {"HIGH", "HIGH"}, {"!HIGH", "!HIGH"},
-    {"MEDIUM", "MEDIUM"}, {"!MEDIUM", "!MEDIUM"},
-    {"LOW", "LOW"}, {"!LOW", "!LOW"},
-    {"ECDH", "ECDH"}, {"!ECDH", "!ECDH"},
-    {"ECDSA", "ECDSA"}, {"!ECDSA", "!ECDSA"},
-    {"EDH", "EDH"}, {"!EDH", "!EDH"},
-    {"EXP", "EXP"}, {"!EXP", "!EXP"},
-    {"RSA", "RSA"}, {"!RSA", "!RSA"},
-    {"kRSA", "kRSA"}, {"!kRSA", "!kRSA"},
-    {"SRP", "SRP"}, {"!SRP", "!SRP"},
-#endif
-    {NULL, NULL}
-};
-
-/**
  * Update the implicit IV for a key_ctx_bi based on TLS session ids and ci=
pher
  * used.
  *
@@ -254,24 +108,6 @@
 static void
 key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_l=
en);

-const tls_cipher_name_pair *
-tls_get_cipher_name_pair(const char *cipher_name, size_t len)
-{
-    const tls_cipher_name_pair *pair =3D tls_cipher_name_translation_table;
-
-    while (pair->openssl_name !=3D NULL)
-    {
-        if ((strlen(pair->openssl_name) =3D=3D len && 0 =3D=3D memcmp(ciph=
er_name, pair->openssl_name, len))
-            || (strlen(pair->iana_name) =3D=3D len && 0 =3D=3D memcmp(ciph=
er_name, pair->iana_name, len)))
-        {
-            return pair;
-        }
-        pair++;
-    }
-
-    /* No entry found, return NULL */
-    return NULL;
-}

 /**
  * Limit the reneg_bytes value when using a small-block (<128 bytes) ciphe=
r.
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 3854d59..b9466ce 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -53,15 +53,6 @@
  */
 struct tls_session;

-/**
- * Get a tls_cipher_name_pair containing OpenSSL and IANA names for suppli=
ed TLS cipher name
- *
- * @param cipher_name   Can be either OpenSSL or IANA cipher name
- * @return              tls_cipher_name_pair* if found, NULL otherwise
- */
-typedef struct { const char *openssl_name; const char *iana_name; } tls_ci=
pher_name_pair;
-const tls_cipher_name_pair *tls_get_cipher_name_pair(const char *cipher_na=
me, size_t len);
-
 /*
  *
  * Functions implemented in ssl.c for use by the backend SSL library
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 9c9167d..cc88484 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -44,6 +44,7 @@
 #include "mbedtls_compat.h"
 #include "pkcs11_backend.h"
 #include "ssl_common.h"
+#include "ssl_util.h"

 #include "ssl_verify_mbedtls.h"
 #include <mbedtls/debug.h>
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 82872bf..c30e6a9 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -50,6 +50,7 @@
 #endif

 #include "ssl_verify_openssl.h"
+#include "ssl_util.h"

 #include <openssl/bn.h>
 #include <openssl/crypto.h>
diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_util.c
index bca6eed..447e739 100644
--- a/src/openvpn/ssl_util.c
+++ b/src/openvpn/ssl_util.c
@@ -114,3 +114,188 @@

     return BSTR(&buf);
 }
+
+/**
+ * SSL/TLS Cipher suite name translation table
+ */
+static const tls_cipher_name_pair tls_cipher_name_translation_table[] =3D {
+    {"ADH-SEED-SHA", "TLS-DH-anon-WITH-SEED-CBC-SHA"},
+    {"AES128-GCM-SHA256", "TLS-RSA-WITH-AES-128-GCM-SHA256"},
+    {"AES128-SHA256", "TLS-RSA-WITH-AES-128-CBC-SHA256"},
+    {"AES128-SHA", "TLS-RSA-WITH-AES-128-CBC-SHA"},
+    {"AES256-GCM-SHA384", "TLS-RSA-WITH-AES-256-GCM-SHA384"},
+    {"AES256-SHA256", "TLS-RSA-WITH-AES-256-CBC-SHA256"},
+    {"AES256-SHA", "TLS-RSA-WITH-AES-256-CBC-SHA"},
+    {"CAMELLIA128-SHA256", "TLS-RSA-WITH-CAMELLIA-128-CBC-SHA256"},
+    {"CAMELLIA128-SHA", "TLS-RSA-WITH-CAMELLIA-128-CBC-SHA"},
+    {"CAMELLIA256-SHA256", "TLS-RSA-WITH-CAMELLIA-256-CBC-SHA256"},
+    {"CAMELLIA256-SHA", "TLS-RSA-WITH-CAMELLIA-256-CBC-SHA"},
+    {"DES-CBC3-SHA", "TLS-RSA-WITH-3DES-EDE-CBC-SHA"},
+    {"DES-CBC-SHA", "TLS-RSA-WITH-DES-CBC-SHA"},
+    {"DH-DSS-SEED-SHA", "TLS-DH-DSS-WITH-SEED-CBC-SHA"},
+    {"DHE-DSS-AES128-GCM-SHA256", "TLS-DHE-DSS-WITH-AES-128-GCM-SHA256"},
+    {"DHE-DSS-AES128-SHA256", "TLS-DHE-DSS-WITH-AES-128-CBC-SHA256"},
+    {"DHE-DSS-AES128-SHA", "TLS-DHE-DSS-WITH-AES-128-CBC-SHA"},
+    {"DHE-DSS-AES256-GCM-SHA384", "TLS-DHE-DSS-WITH-AES-256-GCM-SHA384"},
+    {"DHE-DSS-AES256-SHA256", "TLS-DHE-DSS-WITH-AES-256-CBC-SHA256"},
+    {"DHE-DSS-AES256-SHA", "TLS-DHE-DSS-WITH-AES-256-CBC-SHA"},
+    {"DHE-DSS-CAMELLIA128-SHA256", "TLS-DHE-DSS-WITH-CAMELLIA-128-CBC-SHA2=
56"},
+    {"DHE-DSS-CAMELLIA128-SHA", "TLS-DHE-DSS-WITH-CAMELLIA-128-CBC-SHA"},
+    {"DHE-DSS-CAMELLIA256-SHA256", "TLS-DHE-DSS-WITH-CAMELLIA-256-CBC-SHA2=
56"},
+    {"DHE-DSS-CAMELLIA256-SHA", "TLS-DHE-DSS-WITH-CAMELLIA-256-CBC-SHA"},
+    {"DHE-DSS-SEED-SHA", "TLS-DHE-DSS-WITH-SEED-CBC-SHA"},
+    {"DHE-RSA-AES128-GCM-SHA256", "TLS-DHE-RSA-WITH-AES-128-GCM-SHA256"},
+    {"DHE-RSA-AES128-SHA256", "TLS-DHE-RSA-WITH-AES-128-CBC-SHA256"},
+    {"DHE-RSA-AES128-SHA", "TLS-DHE-RSA-WITH-AES-128-CBC-SHA"},
+    {"DHE-RSA-AES256-GCM-SHA384", "TLS-DHE-RSA-WITH-AES-256-GCM-SHA384"},
+    {"DHE-RSA-AES256-SHA256", "TLS-DHE-RSA-WITH-AES-256-CBC-SHA256"},
+    {"DHE-RSA-AES256-SHA", "TLS-DHE-RSA-WITH-AES-256-CBC-SHA"},
+    {"DHE-RSA-CAMELLIA128-SHA256", "TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA2=
56"},
+    {"DHE-RSA-CAMELLIA128-SHA", "TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA"},
+    {"DHE-RSA-CAMELLIA256-SHA256", "TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SHA2=
56"},
+    {"DHE-RSA-CAMELLIA256-SHA", "TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SHA"},
+    {"DHE-RSA-CHACHA20-POLY1305", "TLS-DHE-RSA-WITH-CHACHA20-POLY1305-SHA2=
56"},
+    {"DHE-RSA-SEED-SHA", "TLS-DHE-RSA-WITH-SEED-CBC-SHA"},
+    {"DH-RSA-SEED-SHA", "TLS-DH-RSA-WITH-SEED-CBC-SHA"},
+    {"ECDH-ECDSA-AES128-GCM-SHA256", "TLS-ECDH-ECDSA-WITH-AES-128-GCM-SHA2=
56"},
+    {"ECDH-ECDSA-AES128-SHA256", "TLS-ECDH-ECDSA-WITH-AES-128-CBC-SHA256"},
+    {"ECDH-ECDSA-AES128-SHA", "TLS-ECDH-ECDSA-WITH-AES-128-CBC-SHA"},
+    {"ECDH-ECDSA-AES256-GCM-SHA384", "TLS-ECDH-ECDSA-WITH-AES-256-GCM-SHA3=
84"},
+    {"ECDH-ECDSA-AES256-SHA256", "TLS-ECDH-ECDSA-WITH-AES-256-CBC-SHA256"},
+    {"ECDH-ECDSA-AES256-SHA384", "TLS-ECDH-ECDSA-WITH-AES-256-CBC-SHA384"},
+    {"ECDH-ECDSA-AES256-SHA", "TLS-ECDH-ECDSA-WITH-AES-256-CBC-SHA"},
+    {"ECDH-ECDSA-CAMELLIA128-SHA256", "TLS-ECDH-ECDSA-WITH-CAMELLIA-128-CB=
C-SHA256"},
+    {"ECDH-ECDSA-CAMELLIA128-SHA", "TLS-ECDH-ECDSA-WITH-CAMELLIA-128-CBC-S=
HA"},
+    {"ECDH-ECDSA-CAMELLIA256-SHA256", "TLS-ECDH-ECDSA-WITH-CAMELLIA-256-CB=
C-SHA256"},
+    {"ECDH-ECDSA-CAMELLIA256-SHA", "TLS-ECDH-ECDSA-WITH-CAMELLIA-256-CBC-S=
HA"},
+    {"ECDH-ECDSA-DES-CBC3-SHA", "TLS-ECDH-ECDSA-WITH-3DES-EDE-CBC-SHA"},
+    {"ECDH-ECDSA-DES-CBC-SHA", "TLS-ECDH-ECDSA-WITH-DES-CBC-SHA"},
+    {"ECDH-ECDSA-RC4-SHA", "TLS-ECDH-ECDSA-WITH-RC4-128-SHA"},
+    {"ECDHE-ECDSA-AES128-GCM-SHA256", "TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SH=
A256"},
+    {"ECDHE-ECDSA-AES128-SHA256", "TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA256=
"},
+    {"ECDHE-ECDSA-AES128-SHA384", "TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA384=
"},
+    {"ECDHE-ECDSA-AES128-SHA", "TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA"},
+    {"ECDHE-ECDSA-AES256-GCM-SHA384", "TLS-ECDHE-ECDSA-WITH-AES-256-GCM-SH=
A384"},
+    {"ECDHE-ECDSA-AES256-SHA256", "TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA256=
"},
+    {"ECDHE-ECDSA-AES256-SHA384", "TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA384=
"},
+    {"ECDHE-ECDSA-AES256-SHA", "TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA"},
+    {"ECDHE-ECDSA-CAMELLIA128-SHA256", "TLS-ECDHE-ECDSA-WITH-CAMELLIA-128-=
CBC-SHA256"},
+    {"ECDHE-ECDSA-CAMELLIA128-SHA", "TLS-ECDHE-ECDSA-WITH-CAMELLIA-128-CBC=
-SHA"},
+    {"ECDHE-ECDSA-CAMELLIA256-SHA256", "TLS-ECDHE-ECDSA-WITH-CAMELLIA-256-=
CBC-SHA256"},
+    {"ECDHE-ECDSA-CAMELLIA256-SHA", "TLS-ECDHE-ECDSA-WITH-CAMELLIA-256-CBC=
-SHA"},
+    {"ECDHE-ECDSA-CHACHA20-POLY1305", "TLS-ECDHE-ECDSA-WITH-CHACHA20-POLY1=
305-SHA256"},
+    {"ECDHE-ECDSA-DES-CBC3-SHA", "TLS-ECDHE-ECDSA-WITH-3DES-EDE-CBC-SHA"},
+    {"ECDHE-ECDSA-DES-CBC-SHA", "TLS-ECDHE-ECDSA-WITH-DES-CBC-SHA"},
+    {"ECDHE-ECDSA-RC4-SHA", "TLS-ECDHE-ECDSA-WITH-RC4-128-SHA"},
+    {"ECDHE-RSA-AES128-GCM-SHA256", "TLS-ECDHE-RSA-WITH-AES-128-GCM-SHA256=
"},
+    {"ECDHE-RSA-AES128-SHA256", "TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA256"},
+    {"ECDHE-RSA-AES128-SHA384", "TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA384"},
+    {"ECDHE-RSA-AES128-SHA", "TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA"},
+    {"ECDHE-RSA-AES256-GCM-SHA384", "TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384=
"},
+    {"ECDHE-RSA-AES256-SHA256", "TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA256"},
+    {"ECDHE-RSA-AES256-SHA384", "TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA384"},
+    {"ECDHE-RSA-AES256-SHA", "TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA"},
+    {"ECDHE-RSA-CAMELLIA128-SHA256", "TLS-ECDHE-RSA-WITH-CAMELLIA-128-CBC-=
SHA256"},
+    {"ECDHE-RSA-CAMELLIA128-SHA", "TLS-ECDHE-RSA-WITH-CAMELLIA-128-CBC-SHA=
"},
+    {"ECDHE-RSA-CAMELLIA256-SHA256", "TLS-ECDHE-RSA-WITH-CAMELLIA-256-CBC-=
SHA256"},
+    {"ECDHE-RSA-CAMELLIA256-SHA", "TLS-ECDHE-RSA-WITH-CAMELLIA-256-CBC-SHA=
"},
+    {"ECDHE-RSA-CHACHA20-POLY1305", "TLS-ECDHE-RSA-WITH-CHACHA20-POLY1305-=
SHA256"},
+    {"ECDHE-RSA-DES-CBC3-SHA", "TLS-ECDHE-RSA-WITH-3DES-EDE-CBC-SHA"},
+    {"ECDHE-RSA-DES-CBC-SHA", "TLS-ECDHE-RSA-WITH-DES-CBC-SHA"},
+    {"ECDHE-RSA-RC4-SHA", "TLS-ECDHE-RSA-WITH-RC4-128-SHA"},
+    {"ECDH-RSA-AES128-GCM-SHA256", "TLS-ECDH-RSA-WITH-AES-128-GCM-SHA256"},
+    {"ECDH-RSA-AES128-SHA256", "TLS-ECDH-RSA-WITH-AES-128-CBC-SHA256"},
+    {"ECDH-RSA-AES128-SHA384", "TLS-ECDH-RSA-WITH-AES-128-CBC-SHA384"},
+    {"ECDH-RSA-AES128-SHA", "TLS-ECDH-RSA-WITH-AES-128-CBC-SHA"},
+    {"ECDH-RSA-AES256-GCM-SHA384", "TLS-ECDH-RSA-WITH-AES-256-GCM-SHA384"},
+    {"ECDH-RSA-AES256-SHA256", "TLS-ECDH-RSA-WITH-AES-256-CBC-SHA256"},
+    {"ECDH-RSA-AES256-SHA384", "TLS-ECDH-RSA-WITH-AES-256-CBC-SHA384"},
+    {"ECDH-RSA-AES256-SHA", "TLS-ECDH-RSA-WITH-AES-256-CBC-SHA"},
+    {"ECDH-RSA-CAMELLIA128-SHA256", "TLS-ECDH-RSA-WITH-CAMELLIA-128-CBC-SH=
A256"},
+    {"ECDH-RSA-CAMELLIA128-SHA", "TLS-ECDH-RSA-WITH-CAMELLIA-128-CBC-SHA"},
+    {"ECDH-RSA-CAMELLIA256-SHA256", "TLS-ECDH-RSA-WITH-CAMELLIA-256-CBC-SH=
A256"},
+    {"ECDH-RSA-CAMELLIA256-SHA", "TLS-ECDH-RSA-WITH-CAMELLIA-256-CBC-SHA"},
+    {"ECDH-RSA-DES-CBC3-SHA", "TLS-ECDH-RSA-WITH-3DES-EDE-CBC-SHA"},
+    {"ECDH-RSA-DES-CBC-SHA", "TLS-ECDH-RSA-WITH-DES-CBC-SHA"},
+    {"ECDH-RSA-RC4-SHA", "TLS-ECDH-RSA-WITH-RC4-128-SHA"},
+    {"EDH-DSS-DES-CBC3-SHA", "TLS-DHE-DSS-WITH-3DES-EDE-CBC-SHA"},
+    {"EDH-DSS-DES-CBC-SHA", "TLS-DHE-DSS-WITH-DES-CBC-SHA"},
+    {"EDH-RSA-DES-CBC3-SHA", "TLS-DHE-RSA-WITH-3DES-EDE-CBC-SHA"},
+    {"EDH-RSA-DES-CBC-SHA", "TLS-DHE-RSA-WITH-DES-CBC-SHA"},
+    {"EXP-DES-CBC-SHA", "TLS-RSA-EXPORT-WITH-DES40-CBC-SHA"},
+    {"EXP-EDH-DSS-DES-CBC-SHA", "TLS-DH-DSS-EXPORT-WITH-DES40-CBC-SHA"},
+    {"EXP-EDH-RSA-DES-CBC-SHA", "TLS-DH-RSA-EXPORT-WITH-DES40-CBC-SHA"},
+    {"EXP-RC2-CBC-MD5", "TLS-RSA-EXPORT-WITH-RC2-CBC-40-MD5"},
+    {"EXP-RC4-MD5", "TLS-RSA-EXPORT-WITH-RC4-40-MD5"},
+    {"NULL-MD5", "TLS-RSA-WITH-NULL-MD5"},
+    {"NULL-SHA256", "TLS-RSA-WITH-NULL-SHA256"},
+    {"NULL-SHA", "TLS-RSA-WITH-NULL-SHA"},
+    {"PSK-3DES-EDE-CBC-SHA", "TLS-PSK-WITH-3DES-EDE-CBC-SHA"},
+    {"PSK-AES128-CBC-SHA", "TLS-PSK-WITH-AES-128-CBC-SHA"},
+    {"PSK-AES256-CBC-SHA", "TLS-PSK-WITH-AES-256-CBC-SHA"},
+    {"PSK-RC4-SHA", "TLS-PSK-WITH-RC4-128-SHA"},
+    {"RC4-MD5", "TLS-RSA-WITH-RC4-128-MD5"},
+    {"RC4-SHA", "TLS-RSA-WITH-RC4-128-SHA"},
+    {"SEED-SHA", "TLS-RSA-WITH-SEED-CBC-SHA"},
+    {"SRP-DSS-3DES-EDE-CBC-SHA", "TLS-SRP-SHA-DSS-WITH-3DES-EDE-CBC-SHA"},
+    {"SRP-DSS-AES-128-CBC-SHA", "TLS-SRP-SHA-DSS-WITH-AES-128-CBC-SHA"},
+    {"SRP-DSS-AES-256-CBC-SHA", "TLS-SRP-SHA-DSS-WITH-AES-256-CBC-SHA"},
+    {"SRP-RSA-3DES-EDE-CBC-SHA", "TLS-SRP-SHA-RSA-WITH-3DES-EDE-CBC-SHA"},
+    {"SRP-RSA-AES-128-CBC-SHA", "TLS-SRP-SHA-RSA-WITH-AES-128-CBC-SHA"},
+    {"SRP-RSA-AES-256-CBC-SHA", "TLS-SRP-SHA-RSA-WITH-AES-256-CBC-SHA"},
+#ifdef ENABLE_CRYPTO_OPENSSL
+    /* OpenSSL-specific group names */
+    {"DEFAULT", "DEFAULT"},
+    {"ALL", "ALL"},
+    {"HIGH", "HIGH"}, {"!HIGH", "!HIGH"},
+    {"MEDIUM", "MEDIUM"}, {"!MEDIUM", "!MEDIUM"},
+    {"LOW", "LOW"}, {"!LOW", "!LOW"},
+    {"ECDH", "ECDH"}, {"!ECDH", "!ECDH"},
+    {"ECDSA", "ECDSA"}, {"!ECDSA", "!ECDSA"},
+    {"EDH", "EDH"}, {"!EDH", "!EDH"},
+    {"EXP", "EXP"}, {"!EXP", "!EXP"},
+    {"RSA", "RSA"}, {"!RSA", "!RSA"},
+    {"kRSA", "kRSA"}, {"!kRSA", "!kRSA"},
+    {"SRP", "SRP"}, {"!SRP", "!SRP"},
+#endif
+    {NULL, NULL}
+};
+
+const tls_cipher_name_pair *
+tls_get_cipher_name_pair(const char *cipher_name, size_t len)
+{
+    const tls_cipher_name_pair *pair =3D tls_cipher_name_translation_table;
+
+    while (pair->openssl_name !=3D NULL)
+    {
+        if ((strlen(pair->openssl_name) =3D=3D len && 0 =3D=3D memcmp(ciph=
er_name, pair->openssl_name, len))
+            || (strlen(pair->iana_name) =3D=3D len && 0 =3D=3D memcmp(ciph=
er_name, pair->iana_name, len)))
+        {
+            return pair;
+        }
+        pair++;
+    }
+
+    /* No entry found, return NULL */
+    return NULL;
+}
+
+int
+get_num_elements(const char *string, char delimiter)
+{
+    int string_len =3D strlen(string);
+
+    ASSERT(0 !=3D string_len);
+
+    int element_count =3D 1;
+    /* Get number of ciphers */
+    for (int i =3D 0; i < string_len; i++)
+    {
+        if (string[i] =3D=3D delimiter)
+        {
+            element_count++;
+        }
+    }
+
+    return element_count;
+}
diff --git a/src/openvpn/ssl_util.h b/src/openvpn/ssl_util.h
index 4c46f88..b3eaf9f 100644
--- a/src/openvpn/ssl_util.h
+++ b/src/openvpn/ssl_util.h
@@ -66,4 +66,27 @@
  */
 const char *options_string_compat_lzo(const char *options, struct gc_arena=
 *gc);

-#endif
+/**
+ * Get a tls_cipher_name_pair containing OpenSSL and IANA names for suppli=
ed TLS cipher name
+ *
+ * @param cipher_name   Can be either OpenSSL or IANA cipher name
+ * @return              tls_cipher_name_pair* if found, NULL otherwise
+ */
+typedef struct { const char *openssl_name; const char *iana_name; } tls_ci=
pher_name_pair;
+const tls_cipher_name_pair *tls_get_cipher_name_pair(const char *cipher_na=
me, size_t len);
+
+/**
+ * Returns the occurrences of 'delimiter' in a string +1
+ * This is typically used to find out the number elements in a
+ * cipher string or similar that is separated by : like
+ *
+ *   X25519:secp256r1:X448:secp512r1:secp384r1:brainpoolP384r1
+ *
+ * @param string        the string to work on
+ * @param delimiter     the delimiter to count, typically ':'
+ * @return              occrrences of delimiter + 1
+ */
+int
+get_num_elements(const char *string, char delimiter);
+
+#endif /* ifndef SSL_UTIL_H_ */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/470?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I605394d4f3872a168d05bbbe52d90f6d48935865
Gerrit-Change-Number: 470
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--SVcGJDC1M+8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/470?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Move tls_get_cipher_name_pair and get_num_elements to ssl_uti=
ls.c<br><br>This allow these functions to be defined without having to incl=
ude ssl.c/misc.c<br>which pulls in a lot of more dependencies.<br><br>Chang=
e-Id: I605394d4f3872a168d05bbbe52d90f6d48935865<br>Signed-off-by: Arne Schw=
abe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/misc.c<br>M src/openvpn=
/misc.h<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl_backend.h<br>M src/open=
vpn/ssl_mbedtls.c<br>M src/openvpn/ssl_openssl.c<br>M src/openvpn/ssl_util.=
c<br>M src/openvpn/ssl_util.h<br>8 files changed, 211 insertions(+), 208 de=
letions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/70/470/1</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/misc.c b/src/openvpn/misc.=
c</span><br><span>index ce6e4fd..bce63ed 100644</span><br><span>--- a/src/o=
penvpn/misc.c</span><br><span>+++ b/src/openvpn/misc.c</span><br><span>@@ -=
773,26 +773,6 @@</span><br><span>     }</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-get_num_elements(const char *string, c=
har delimiter)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    int string_len =3D strl=
en(string);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(0 !=3D string_len);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int element_count =3D 1;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* Get number of ciphers */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &l=
t; string_len; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (string=
[i] =3D=3D delimiter)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
element_count++;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return element_count;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> struct buffer</span><br><span> prepend_dir(const cha=
r *dir, const char *path, struct gc_arena *gc)</span><br><span> {</span><br=
><span>diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h</span><br><span=
>index b000b72..70a24dd 100644</span><br><span>--- a/src/openvpn/misc.h</sp=
an><br><span>+++ b/src/openvpn/misc.h</span><br><span>@@ -193,20 +193,6 @@<=
/span><br><span> void output_peer_info_env(struct env_set *es, const char *=
peer_info);</span><br><span> </span><br><span> /**</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * Returns the occurrences of &#39;delimiter&#=
39; in a string +1</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
This is typically used to find out the number elements in a</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * cipher string or similar that is s=
eparated by : like</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *   X25519:secp256r1:=
X448:secp512r1:secp384r1:brainpoolP384r1</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @param string        the string to work on</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * @param delimiter     the delimiter to count, typ=
ically &#39;:&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
@return              occrrences of delimiter + 1</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_num_e=
lements(const char *string, char delimiter);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/**</span><br><span>  * Prepend a directory to a path.</span><br><span>  =
*/</span><br><span> struct buffer</span><br><span>diff --git a/src/openvpn/=
ssl.c b/src/openvpn/ssl.c</span><br><span>index 3e3696c..6eddb68 100644</sp=
an><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.=
c</span><br><span>@@ -95,152 +95,6 @@</span><br><span> #endif /* ifdef MEAS=
URE_TLS_HANDSHAKE_STATS */</span><br><span> </span><br><span> /**</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * SSL/TLS Cipher suite name tr=
anslation table</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static const tls_cipher_=
name_pair tls_cipher_name_translation_table[] =3D {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {&quot;ADH-SEED-SHA&quot;, &quot;TLS-DH=
-anon-WITH-SEED-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {&quot;AES128-GCM-SHA256&quot;, &quot;TLS-RSA-WITH-AES-128-GC=
M-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
&quot;AES128-SHA256&quot;, &quot;TLS-RSA-WITH-AES-128-CBC-SHA256&quot;},</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;AES128-SHA&qu=
ot;, &quot;TLS-RSA-WITH-AES-128-CBC-SHA&quot;},</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {&quot;AES256-GCM-SHA384&quot;, &quot;TLS-RSA=
-WITH-AES-256-GCM-SHA384&quot;},</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {&quot;AES256-SHA256&quot;, &quot;TLS-RSA-WITH-AES-256-CBC-S=
HA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&qu=
ot;AES256-SHA&quot;, &quot;TLS-RSA-WITH-AES-256-CBC-SHA&quot;},</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;CAMELLIA128-SHA256&quo=
t;, &quot;TLS-RSA-WITH-CAMELLIA-128-CBC-SHA256&quot;},</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {&quot;CAMELLIA128-SHA&quot;, &quot;TL=
S-RSA-WITH-CAMELLIA-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {&quot;CAMELLIA256-SHA256&quot;, &quot;TLS-RSA-WITH-C=
AMELLIA-256-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {&quot;CAMELLIA256-SHA&quot;, &quot;TLS-RSA-WITH-CAMELLIA-256-=
CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&=
quot;DES-CBC3-SHA&quot;, &quot;TLS-RSA-WITH-3DES-EDE-CBC-SHA&quot;},</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DES-CBC-SHA&quot;=
, &quot;TLS-RSA-WITH-DES-CBC-SHA&quot;},</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {&quot;DH-DSS-SEED-SHA&quot;, &quot;TLS-DH-DSS-WITH-=
SEED-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {&quot;DHE-DSS-AES128-GCM-SHA256&quot;, &quot;TLS-DHE-DSS-WITH-AES-128-G=
CM-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{&quot;DHE-DSS-AES128-SHA256&quot;, &quot;TLS-DHE-DSS-WITH-AES-128-CBC-SHA2=
56&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;=
DHE-DSS-AES128-SHA&quot;, &quot;TLS-DHE-DSS-WITH-AES-128-CBC-SHA&quot;},</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-DSS-AES25=
6-GCM-SHA384&quot;, &quot;TLS-DHE-DSS-WITH-AES-256-GCM-SHA384&quot;},</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-DSS-AES256-S=
HA256&quot;, &quot;TLS-DHE-DSS-WITH-AES-256-CBC-SHA256&quot;},</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-DSS-AES256-SHA&quot=
;, &quot;TLS-DHE-DSS-WITH-AES-256-CBC-SHA&quot;},</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {&quot;DHE-DSS-CAMELLIA128-SHA256&quot;, &q=
uot;TLS-DHE-DSS-WITH-CAMELLIA-128-CBC-SHA256&quot;},</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-DSS-CAMELLIA128-SHA&quot;, &=
quot;TLS-DHE-DSS-WITH-CAMELLIA-128-CBC-SHA&quot;},</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {&quot;DHE-DSS-CAMELLIA256-SHA256&quot;, &=
quot;TLS-DHE-DSS-WITH-CAMELLIA-256-CBC-SHA256&quot;},</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-DSS-CAMELLIA256-SHA&quot;, &=
quot;TLS-DHE-DSS-WITH-CAMELLIA-256-CBC-SHA&quot;},</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {&quot;DHE-DSS-SEED-SHA&quot;, &quot;TLS-D=
HE-DSS-WITH-SEED-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {&quot;DHE-RSA-AES128-GCM-SHA256&quot;, &quot;TLS-DHE-RSA-WI=
TH-AES-128-GCM-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {&quot;DHE-RSA-AES128-SHA256&quot;, &quot;TLS-DHE-RSA-WITH-AES-=
128-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {&quot;DHE-RSA-AES128-SHA&quot;, &quot;TLS-DHE-RSA-WITH-AES-128-CBC-SH=
A&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;D=
HE-RSA-AES256-GCM-SHA384&quot;, &quot;TLS-DHE-RSA-WITH-AES-256-GCM-SHA384&q=
uot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-=
RSA-AES256-SHA256&quot;, &quot;TLS-DHE-RSA-WITH-AES-256-CBC-SHA256&quot;},<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-RSA-AES=
256-SHA&quot;, &quot;TLS-DHE-RSA-WITH-AES-256-CBC-SHA&quot;},</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-RSA-CAMELLIA128-SHA2=
56&quot;, &quot;TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA256&quot;},</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-RSA-CAMELLIA128-S=
HA&quot;, &quot;TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA&quot;},</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-RSA-CAMELLIA256-SHA2=
56&quot;, &quot;TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SHA256&quot;},</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-RSA-CAMELLIA256-S=
HA&quot;, &quot;TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SHA&quot;},</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-RSA-CHACHA20-POLY130=
5&quot;, &quot;TLS-DHE-RSA-WITH-CHACHA20-POLY1305-SHA256&quot;},</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-RSA-SEED-SHA&quot=
;, &quot;TLS-DHE-RSA-WITH-SEED-CBC-SHA&quot;},</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {&quot;DH-RSA-SEED-SHA&quot;, &quot;TLS-DH-RSA=
-WITH-SEED-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {&quot;ECDH-ECDSA-AES128-GCM-SHA256&quot;, &quot;TLS-ECDH-ECDSA-WI=
TH-AES-128-GCM-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {&quot;ECDH-ECDSA-AES128-SHA256&quot;, &quot;TLS-ECDH-ECDSA-WIT=
H-AES-128-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {&quot;ECDH-ECDSA-AES128-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-AE=
S-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {&quot;ECDH-ECDSA-AES256-GCM-SHA384&quot;, &quot;TLS-ECDH-ECDSA-WITH-AE=
S-256-GCM-SHA384&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {&quot;ECDH-ECDSA-AES256-SHA256&quot;, &quot;TLS-ECDH-ECDSA-WITH-AES=
-256-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {&quot;ECDH-ECDSA-AES256-SHA384&quot;, &quot;TLS-ECDH-ECDSA-WITH-AES-=
256-CBC-SHA384&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {&quot;ECDH-ECDSA-AES256-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-AES-256-=
CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&=
quot;ECDH-ECDSA-CAMELLIA128-SHA256&quot;, &quot;TLS-ECDH-ECDSA-WITH-CAMELLI=
A-128-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {&quot;ECDH-ECDSA-CAMELLIA128-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-C=
AMELLIA-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {&quot;ECDH-ECDSA-CAMELLIA256-SHA256&quot;, &quot;TLS-ECDH-ECDSA-=
WITH-CAMELLIA-256-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {&quot;ECDH-ECDSA-CAMELLIA256-SHA&quot;, &quot;TLS-ECDH-=
ECDSA-WITH-CAMELLIA-256-CBC-SHA&quot;},</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {&quot;ECDH-ECDSA-DES-CBC3-SHA&quot;, &quot;TLS-ECDH-=
ECDSA-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {&quot;ECDH-ECDSA-DES-CBC-SHA&quot;, &quot;TLS-ECDH-ECDSA=
-WITH-DES-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {&quot;ECDH-ECDSA-RC4-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-RC4-128-=
SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot=
;ECDHE-ECDSA-AES128-GCM-SHA256&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-128-GC=
M-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
&quot;ECDHE-ECDSA-AES128-SHA256&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-128-C=
BC-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{&quot;ECDHE-ECDSA-AES128-SHA384&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-128-=
CBC-SHA384&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {&quot;ECDHE-ECDSA-AES128-SHA&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-128-CB=
C-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&qu=
ot;ECDHE-ECDSA-AES256-GCM-SHA384&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-256-=
GCM-SHA384&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {&quot;ECDHE-ECDSA-AES256-SHA256&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-256=
-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {&quot;ECDHE-ECDSA-AES256-SHA384&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-25=
6-CBC-SHA384&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {&quot;ECDHE-ECDSA-AES256-SHA&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-256-=
CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&=
quot;ECDHE-ECDSA-CAMELLIA128-SHA256&quot;, &quot;TLS-ECDHE-ECDSA-WITH-CAMEL=
LIA-128-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {&quot;ECDHE-ECDSA-CAMELLIA128-SHA&quot;, &quot;TLS-ECDHE-ECDSA-WI=
TH-CAMELLIA-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {&quot;ECDHE-ECDSA-CAMELLIA256-SHA256&quot;, &quot;TLS-ECDHE-=
ECDSA-WITH-CAMELLIA-256-CBC-SHA256&quot;},</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {&quot;ECDHE-ECDSA-CAMELLIA256-SHA&quot;, &quot;TL=
S-ECDHE-ECDSA-WITH-CAMELLIA-256-CBC-SHA&quot;},</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {&quot;ECDHE-ECDSA-CHACHA20-POLY1305&quot;, &=
quot;TLS-ECDHE-ECDSA-WITH-CHACHA20-POLY1305-SHA256&quot;},</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-ECDSA-DES-CBC3-SHA&qu=
ot;, &quot;TLS-ECDHE-ECDSA-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-ECDSA-DES-CBC-SHA&quot;=
, &quot;TLS-ECDHE-ECDSA-WITH-DES-CBC-SHA&quot;},</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {&quot;ECDHE-ECDSA-RC4-SHA&quot;, &quot;TLS-=
ECDHE-ECDSA-WITH-RC4-128-SHA&quot;},</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {&quot;ECDHE-RSA-AES128-GCM-SHA256&quot;, &quot;TLS-ECDH=
E-RSA-WITH-AES-128-GCM-SHA256&quot;},</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {&quot;ECDHE-RSA-AES128-SHA256&quot;, &quot;TLS-ECDHE-R=
SA-WITH-AES-128-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {&quot;ECDHE-RSA-AES128-SHA384&quot;, &quot;TLS-ECDHE-RSA-=
WITH-AES-128-CBC-SHA384&quot;},</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {&quot;ECDHE-RSA-AES128-SHA&quot;, &quot;TLS-ECDHE-RSA-WITH-A=
ES-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {&quot;ECDHE-RSA-AES256-GCM-SHA384&quot;, &quot;TLS-ECDHE-RSA-WITH-AES=
-256-GCM-SHA384&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {&quot;ECDHE-RSA-AES256-SHA256&quot;, &quot;TLS-ECDHE-RSA-WITH-AES-25=
6-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {&quot;ECDHE-RSA-AES256-SHA384&quot;, &quot;TLS-ECDHE-RSA-WITH-AES-256-C=
BC-SHA384&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{&quot;ECDHE-RSA-AES256-SHA&quot;, &quot;TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA=
&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;EC=
DHE-RSA-CAMELLIA128-SHA256&quot;, &quot;TLS-ECDHE-RSA-WITH-CAMELLIA-128-CBC=
-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&=
quot;ECDHE-RSA-CAMELLIA128-SHA&quot;, &quot;TLS-ECDHE-RSA-WITH-CAMELLIA-128=
-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
&quot;ECDHE-RSA-CAMELLIA256-SHA256&quot;, &quot;TLS-ECDHE-RSA-WITH-CAMELLIA=
-256-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {&quot;ECDHE-RSA-CAMELLIA256-SHA&quot;, &quot;TLS-ECDHE-RSA-WITH-CAME=
LLIA-256-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {&quot;ECDHE-RSA-CHACHA20-POLY1305&quot;, &quot;TLS-ECDHE-RSA-WITH-C=
HACHA20-POLY1305-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {&quot;ECDHE-RSA-DES-CBC3-SHA&quot;, &quot;TLS-ECDHE-RSA-WITH=
-3DES-EDE-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {&quot;ECDHE-RSA-DES-CBC-SHA&quot;, &quot;TLS-ECDHE-RSA-WITH-DES-CB=
C-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&qu=
ot;ECDHE-RSA-RC4-SHA&quot;, &quot;TLS-ECDHE-RSA-WITH-RC4-128-SHA&quot;},</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDH-RSA-AES1=
28-GCM-SHA256&quot;, &quot;TLS-ECDH-RSA-WITH-AES-128-GCM-SHA256&quot;},</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDH-RSA-AES12=
8-SHA256&quot;, &quot;TLS-ECDH-RSA-WITH-AES-128-CBC-SHA256&quot;},</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDH-RSA-AES128-SHA=
384&quot;, &quot;TLS-ECDH-RSA-WITH-AES-128-CBC-SHA384&quot;},</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDH-RSA-AES128-SHA&quot=
;, &quot;TLS-ECDH-RSA-WITH-AES-128-CBC-SHA&quot;},</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {&quot;ECDH-RSA-AES256-GCM-SHA384&quot;, &=
quot;TLS-ECDH-RSA-WITH-AES-256-GCM-SHA384&quot;},</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {&quot;ECDH-RSA-AES256-SHA256&quot;, &quot;=
TLS-ECDH-RSA-WITH-AES-256-CBC-SHA256&quot;},</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {&quot;ECDH-RSA-AES256-SHA384&quot;, &quot;TLS-E=
CDH-RSA-WITH-AES-256-CBC-SHA384&quot;},</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {&quot;ECDH-RSA-AES256-SHA&quot;, &quot;TLS-ECDH-RSA-=
WITH-AES-256-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {&quot;ECDH-RSA-CAMELLIA128-SHA256&quot;, &quot;TLS-ECDH-RSA-WIT=
H-CAMELLIA-128-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {&quot;ECDH-RSA-CAMELLIA128-SHA&quot;, &quot;TLS-ECDH-RSA-W=
ITH-CAMELLIA-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {&quot;ECDH-RSA-CAMELLIA256-SHA256&quot;, &quot;TLS-ECDH-RSA=
-WITH-CAMELLIA-256-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    {&quot;ECDH-RSA-CAMELLIA256-SHA&quot;, &quot;TLS-ECDH-R=
SA-WITH-CAMELLIA-256-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {&quot;ECDH-RSA-DES-CBC3-SHA&quot;, &quot;TLS-ECDH-RSA-W=
ITH-3DES-EDE-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {&quot;ECDH-RSA-DES-CBC-SHA&quot;, &quot;TLS-ECDH-RSA-WITH-DES-C=
BC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&q=
uot;ECDH-RSA-RC4-SHA&quot;, &quot;TLS-ECDH-RSA-WITH-RC4-128-SHA&quot;},</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;EDH-DSS-DES-CB=
C3-SHA&quot;, &quot;TLS-DHE-DSS-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {&quot;EDH-DSS-DES-CBC-SHA&quot=
;, &quot;TLS-DHE-DSS-WITH-DES-CBC-SHA&quot;},</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {&quot;EDH-RSA-DES-CBC3-SHA&quot;, &quot;TLS-DH=
E-RSA-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {&quot;EDH-RSA-DES-CBC-SHA&quot;, &quot;TLS-DHE-RSA-WITH-=
DES-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {&quot;EXP-DES-CBC-SHA&quot;, &quot;TLS-RSA-EXPORT-WITH-DES40-CBC-SHA&quo=
t;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;EXP-ED=
H-DSS-DES-CBC-SHA&quot;, &quot;TLS-DH-DSS-EXPORT-WITH-DES40-CBC-SHA&quot;},=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;EXP-EDH-RS=
A-DES-CBC-SHA&quot;, &quot;TLS-DH-RSA-EXPORT-WITH-DES40-CBC-SHA&quot;},</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;EXP-RC2-CBC-MD=
5&quot;, &quot;TLS-RSA-EXPORT-WITH-RC2-CBC-40-MD5&quot;},</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {&quot;EXP-RC4-MD5&quot;, &quot;TLS=
-RSA-EXPORT-WITH-RC4-40-MD5&quot;},</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {&quot;NULL-MD5&quot;, &quot;TLS-RSA-WITH-NULL-MD5&quot;}=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;NULL-SHA2=
56&quot;, &quot;TLS-RSA-WITH-NULL-SHA256&quot;},</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {&quot;NULL-SHA&quot;, &quot;TLS-RSA-WITH-NU=
LL-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&q=
uot;PSK-3DES-EDE-CBC-SHA&quot;, &quot;TLS-PSK-WITH-3DES-EDE-CBC-SHA&quot;},=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;PSK-AES128=
-CBC-SHA&quot;, &quot;TLS-PSK-WITH-AES-128-CBC-SHA&quot;},</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {&quot;PSK-AES256-CBC-SHA&quot;, &=
quot;TLS-PSK-WITH-AES-256-CBC-SHA&quot;},</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {&quot;PSK-RC4-SHA&quot;, &quot;TLS-PSK-WITH-RC4-12=
8-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&qu=
ot;RC4-MD5&quot;, &quot;TLS-RSA-WITH-RC4-128-MD5&quot;},</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {&quot;RC4-SHA&quot;, &quot;TLS-RSA-=
WITH-RC4-128-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {&quot;SEED-SHA&quot;, &quot;TLS-RSA-WITH-SEED-CBC-SHA&quot;},</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;SRP-DSS-3DES-EDE=
-CBC-SHA&quot;, &quot;TLS-SRP-SHA-DSS-WITH-3DES-EDE-CBC-SHA&quot;},</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;SRP-DSS-AES-128-CB=
C-SHA&quot;, &quot;TLS-SRP-SHA-DSS-WITH-AES-128-CBC-SHA&quot;},</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;SRP-DSS-AES-256-CBC-SH=
A&quot;, &quot;TLS-SRP-SHA-DSS-WITH-AES-256-CBC-SHA&quot;},</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {&quot;SRP-RSA-3DES-EDE-CBC-SHA&q=
uot;, &quot;TLS-SRP-SHA-RSA-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {&quot;SRP-RSA-AES-128-CBC-SHA&quot=
;, &quot;TLS-SRP-SHA-RSA-WITH-AES-128-CBC-SHA&quot;},</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {&quot;SRP-RSA-AES-256-CBC-SHA&quot;, &=
quot;TLS-SRP-SHA-RSA-WITH-AES-256-CBC-SHA&quot;},</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#ifdef ENABLE_CRYPTO_OPENSSL</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    /* OpenSSL-specific group names */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DEFAULT&quot=
;, &quot;DEFAULT&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {&quot;ALL&quot;, &quot;ALL&quot;},</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {&quot;HIGH&quot;, &quot;HIGH&quot;}, {&quot;!HIGH=
&quot;, &quot;!HIGH&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {&quot;MEDIUM&quot;, &quot;MEDIUM&quot;}, {&quot;!MEDIUM&quot;, &=
quot;!MEDIUM&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {&quot;LOW&quot;, &quot;LOW&quot;}, {&quot;!LOW&quot;, &quot;!LOW&quot;}=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDH&quot=
;, &quot;ECDH&quot;}, {&quot;!ECDH&quot;, &quot;!ECDH&quot;},</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDSA&quot;, &quot;ECDSA=
&quot;}, {&quot;!ECDSA&quot;, &quot;!ECDSA&quot;},</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {&quot;EDH&quot;, &quot;EDH&quot;}, {&quot=
;!EDH&quot;, &quot;!EDH&quot;},</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {&quot;EXP&quot;, &quot;EXP&quot;}, {&quot;!EXP&quot;, &quot;=
!EXP&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quo=
t;RSA&quot;, &quot;RSA&quot;}, {&quot;!RSA&quot;, &quot;!RSA&quot;},</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;kRSA&quot;, &quot=
;kRSA&quot;}, {&quot;!kRSA&quot;, &quot;!kRSA&quot;},</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {&quot;SRP&quot;, &quot;SRP&quot;}, {&q=
uot;!SRP&quot;, &quot;!SRP&quot;},</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {NULL, NULL}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-/**</span><br><span>  * Update the implicit IV =
for a key_ctx_bi based on TLS session ids and cipher</span><br><span>  * us=
ed.</span><br><span>  *</span><br><span>@@ -254,24 +108,6 @@</span><br><spa=
n> static void</span><br><span> key_ctx_update_implicit_iv(struct key_ctx *=
ctx, uint8_t *key, size_t key_len);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-const tls_cipher_name_pair *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-tls_get_cipher_name_pair(const char =
*cipher_name, size_t len)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const tls_ci=
pher_name_pair *pair =3D tls_cipher_name_translation_table;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    while (pair-&gt;openssl_name !=3D NULL)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if ((strlen(pair-&gt;openssl_name) =3D=3D le=
n &amp;&amp; 0 =3D=3D memcmp(cipher_name, pair-&gt;openssl_name, len))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            || (strlen(pai=
r-&gt;iana_name) =3D=3D len &amp;&amp; 0 =3D=3D memcmp(cipher_name, pair-&g=
t;iana_name, len)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            re=
turn pair;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        pair++;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* No entry found, return NULL */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return NULL;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span> </span><br><span> /**</span><br><s=
pan>  * Limit the reneg_bytes value when using a small-block (&lt;128 bytes=
) cipher.</span><br><span>diff --git a/src/openvpn/ssl_backend.h b/src/open=
vpn/ssl_backend.h</span><br><span>index 3854d59..b9466ce 100644</span><br><=
span>--- a/src/openvpn/ssl_backend.h</span><br><span>+++ b/src/openvpn/ssl_=
backend.h</span><br><span>@@ -53,15 +53,6 @@</span><br><span>  */</span><br=
><span> struct tls_session;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * Get a tls_cipher_name_pair containing OpenSSL and IANA names for s=
upplied TLS cipher name</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param cipher_=
name   Can be either OpenSSL or IANA cipher name</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * @return              tls_cipher_name_pair* if=
 found, NULL otherwise</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-typedef struct { =
const char *openssl_name; const char *iana_name; } tls_cipher_name_pair;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-const tls_cipher_name_pa=
ir *tls_get_cipher_name_pair(const char *cipher_name, size_t len);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br=
><span>  *</span><br><span>  * Functions implemented in ssl.c for use by th=
e backend SSL library</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.=
c b/src/openvpn/ssl_mbedtls.c</span><br><span>index 9c9167d..cc88484 100644=
</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/=
openvpn/ssl_mbedtls.c</span><br><span>@@ -44,6 +44,7 @@</span><br><span> #i=
nclude &quot;mbedtls_compat.h&quot;</span><br><span> #include &quot;pkcs11_=
backend.h&quot;</span><br><span> #include &quot;ssl_common.h&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_util.h&qu=
ot;</span><br><span> </span><br><span> #include &quot;ssl_verify_mbedtls.h&=
quot;</span><br><span> #include &lt;mbedtls/debug.h&gt;</span><br><span>dif=
f --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><=
span>index 82872bf..c30e6a9 100644</span><br><span>--- a/src/openvpn/ssl_op=
enssl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ =
-50,6 +50,7 @@</span><br><span> #endif</span><br><span> </span><br><span> #=
include &quot;ssl_verify_openssl.h&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;ssl_util.h&quot;</span><br><span> </spa=
n><br><span> #include &lt;openssl/bn.h&gt;</span><br><span> #include &lt;op=
enssl/crypto.h&gt;</span><br><span>diff --git a/src/openvpn/ssl_util.c b/sr=
c/openvpn/ssl_util.c</span><br><span>index bca6eed..447e739 100644</span><b=
r><span>--- a/src/openvpn/ssl_util.c</span><br><span>+++ b/src/openvpn/ssl_=
util.c</span><br><span>@@ -114,3 +114,188 @@</span><br><span> </span><br><s=
pan>     return BSTR(&amp;buf);</span><br><span> }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * S=
SL/TLS Cipher suite name translation table</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static const tls_cipher_name_pair tls_cipher_name_translation_table[=
] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;A=
DH-SEED-SHA&quot;, &quot;TLS-DH-anon-WITH-SEED-CBC-SHA&quot;},</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {&quot;AES128-GCM-SHA256&quo=
t;, &quot;TLS-RSA-WITH-AES-128-GCM-SHA256&quot;},</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {&quot;AES128-SHA256&quot;, &quot;TLS-RSA=
-WITH-AES-128-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {&quot;AES128-SHA&quot;, &quot;TLS-RSA-WITH-AES-128-CBC-SH=
A&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot=
;AES256-GCM-SHA384&quot;, &quot;TLS-RSA-WITH-AES-256-GCM-SHA384&quot;},</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;AES256-SHA25=
6&quot;, &quot;TLS-RSA-WITH-AES-256-CBC-SHA256&quot;},</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {&quot;AES256-SHA&quot;, &quot;TLS-R=
SA-WITH-AES-256-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {&quot;CAMELLIA128-SHA256&quot;, &quot;TLS-RSA-WITH-CAMELLI=
A-128-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {&quot;CAMELLIA128-SHA&quot;, &quot;TLS-RSA-WITH-CAMELLIA-128-CBC-=
SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&qu=
ot;CAMELLIA256-SHA256&quot;, &quot;TLS-RSA-WITH-CAMELLIA-256-CBC-SHA256&quo=
t;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;CAME=
LLIA256-SHA&quot;, &quot;TLS-RSA-WITH-CAMELLIA-256-CBC-SHA&quot;},</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DES-CBC3-SHA&quot=
;, &quot;TLS-RSA-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {&quot;DES-CBC-SHA&quot;, &quot;TLS-RSA-WITH=
-DES-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {&quot;DH-DSS-SEED-SHA&quot;, &quot;TLS-DH-DSS-WITH-SEED-CBC-SHA&quot;=
},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-DS=
S-AES128-GCM-SHA256&quot;, &quot;TLS-DHE-DSS-WITH-AES-128-GCM-SHA256&quot;}=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-DSS=
-AES128-SHA256&quot;, &quot;TLS-DHE-DSS-WITH-AES-128-CBC-SHA256&quot;},</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-DSS-AES1=
28-SHA&quot;, &quot;TLS-DHE-DSS-WITH-AES-128-CBC-SHA&quot;},</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-DSS-AES256-GCM-SHA3=
84&quot;, &quot;TLS-DHE-DSS-WITH-AES-256-GCM-SHA384&quot;},</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-DSS-AES256-SHA256&qu=
ot;, &quot;TLS-DHE-DSS-WITH-AES-256-CBC-SHA256&quot;},</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-DSS-AES256-SHA&quot;, &qu=
ot;TLS-DHE-DSS-WITH-AES-256-CBC-SHA&quot;},</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {&quot;DHE-DSS-CAMELLIA128-SHA256&quot;, &quot;=
TLS-DHE-DSS-WITH-CAMELLIA-128-CBC-SHA256&quot;},</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {&quot;DHE-DSS-CAMELLIA128-SHA&quot;, &quo=
t;TLS-DHE-DSS-WITH-CAMELLIA-128-CBC-SHA&quot;},</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {&quot;DHE-DSS-CAMELLIA256-SHA256&quot;, &q=
uot;TLS-DHE-DSS-WITH-CAMELLIA-256-CBC-SHA256&quot;},</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-DSS-CAMELLIA256-SHA&quot;,=
 &quot;TLS-DHE-DSS-WITH-CAMELLIA-256-CBC-SHA&quot;},</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-DSS-SEED-SHA&quot;, &quot;=
TLS-DHE-DSS-WITH-SEED-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {&quot;DHE-RSA-AES128-GCM-SHA256&quot;, &quot;TLS-DHE=
-RSA-WITH-AES-128-GCM-SHA256&quot;},</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {&quot;DHE-RSA-AES128-SHA256&quot;, &quot;TLS-DHE-RSA-=
WITH-AES-128-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {&quot;DHE-RSA-AES128-SHA&quot;, &quot;TLS-DHE-RSA-WITH-AES=
-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {&quot;DHE-RSA-AES256-GCM-SHA384&quot;, &quot;TLS-DHE-RSA-WITH-AES-256=
-GCM-SHA384&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {&quot;DHE-RSA-AES256-SHA256&quot;, &quot;TLS-DHE-RSA-WITH-AES-256-CBC-=
SHA256&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
&quot;DHE-RSA-AES256-SHA&quot;, &quot;TLS-DHE-RSA-WITH-AES-256-CBC-SHA&quot=
;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-R=
SA-CAMELLIA128-SHA256&quot;, &quot;TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA256=
&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;=
DHE-RSA-CAMELLIA128-SHA&quot;, &quot;TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA&=
quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;D=
HE-RSA-CAMELLIA256-SHA256&quot;, &quot;TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SH=
A256&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&q=
uot;DHE-RSA-CAMELLIA256-SHA&quot;, &quot;TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-=
SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&qu=
ot;DHE-RSA-CHACHA20-POLY1305&quot;, &quot;TLS-DHE-RSA-WITH-CHACHA20-POLY130=
5-SHA256&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {&quot;DHE-RSA-SEED-SHA&quot;, &quot;TLS-DHE-RSA-WITH-SEED-CBC-SHA&quot;},=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DH-RSA-S=
EED-SHA&quot;, &quot;TLS-DH-RSA-WITH-SEED-CBC-SHA&quot;},</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-AES128-GCM-SHA2=
56&quot;, &quot;TLS-ECDH-ECDSA-WITH-AES-128-GCM-SHA256&quot;},</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-AES128-SHA=
256&quot;, &quot;TLS-ECDH-ECDSA-WITH-AES-128-CBC-SHA256&quot;},</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-AES128-SH=
A&quot;, &quot;TLS-ECDH-ECDSA-WITH-AES-128-CBC-SHA&quot;},</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-AES256-GCM-SHA=
384&quot;, &quot;TLS-ECDH-ECDSA-WITH-AES-256-GCM-SHA384&quot;},</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-AES256-SH=
A256&quot;, &quot;TLS-ECDH-ECDSA-WITH-AES-256-CBC-SHA256&quot;},</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-AES256-S=
HA384&quot;, &quot;TLS-ECDH-ECDSA-WITH-AES-256-CBC-SHA384&quot;},</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-AES256-=
SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-AES-256-CBC-SHA&quot;},</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-CAMELLIA128-=
SHA256&quot;, &quot;TLS-ECDH-ECDSA-WITH-CAMELLIA-128-CBC-SHA256&quot;},</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-C=
AMELLIA128-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-CAMELLIA-128-CBC-SHA&quot;}=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH-EC=
DSA-CAMELLIA256-SHA256&quot;, &quot;TLS-ECDH-ECDSA-WITH-CAMELLIA-256-CBC-SH=
A256&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&q=
uot;ECDH-ECDSA-CAMELLIA256-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-CAMELLIA-25=
6-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {&quot;ECDH-ECDSA-DES-CBC3-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-3DES-EDE-=
CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{&quot;ECDH-ECDSA-DES-CBC-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-DES-CBC-SHA&=
quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;E=
CDH-ECDSA-RC4-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-RC4-128-SHA&quot;},</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-ECDSA-A=
ES128-GCM-SHA256&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256&quot;=
},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-=
ECDSA-AES128-SHA256&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA256&qu=
ot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECD=
HE-ECDSA-AES128-SHA384&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA384=
&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;=
ECDHE-ECDSA-AES128-SHA&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA&qu=
ot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECD=
HE-ECDSA-AES256-GCM-SHA384&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-256-GCM-SH=
A384&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&q=
uot;ECDHE-ECDSA-AES256-SHA256&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-256-CBC=
-SHA256&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{&quot;ECDHE-ECDSA-AES256-SHA384&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-256-=
CBC-SHA384&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {&quot;ECDHE-ECDSA-AES256-SHA&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-256-=
CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{&quot;ECDHE-ECDSA-CAMELLIA128-SHA256&quot;, &quot;TLS-ECDHE-ECDSA-WITH-CAM=
ELLIA-128-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {&quot;ECDHE-ECDSA-CAMELLIA128-SHA&quot;, &quot;TLS-ECDHE-ECDS=
A-WITH-CAMELLIA-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {&quot;ECDHE-ECDSA-CAMELLIA256-SHA256&quot;, &quot;TLS-=
ECDHE-ECDSA-WITH-CAMELLIA-256-CBC-SHA256&quot;},</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {&quot;ECDHE-ECDSA-CAMELLIA256-SHA&quot;, =
&quot;TLS-ECDHE-ECDSA-WITH-CAMELLIA-256-CBC-SHA&quot;},</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-ECDSA-CHACHA20-POLY130=
5&quot;, &quot;TLS-ECDHE-ECDSA-WITH-CHACHA20-POLY1305-SHA256&quot;},</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-ECDSA-DES=
-CBC3-SHA&quot;, &quot;TLS-ECDHE-ECDSA-WITH-3DES-EDE-CBC-SHA&quot;},</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-ECDSA-DES=
-CBC-SHA&quot;, &quot;TLS-ECDHE-ECDSA-WITH-DES-CBC-SHA&quot;},</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-ECDSA-RC4-SHA&q=
uot;, &quot;TLS-ECDHE-ECDSA-WITH-RC4-128-SHA&quot;},</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-AES128-GCM-SHA256&qu=
ot;, &quot;TLS-ECDHE-RSA-WITH-AES-128-GCM-SHA256&quot;},</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-AES128-SHA256&quo=
t;, &quot;TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA256&quot;},</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-AES128-SHA384&quot=
;, &quot;TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA384&quot;},</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-AES128-SHA&quot;, &=
quot;TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA&quot;},</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-AES256-GCM-SHA384&quot;, &=
quot;TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384&quot;},</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-AES256-SHA256&quot;, &q=
uot;TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA256&quot;},</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-AES256-SHA384&quot;, &qu=
ot;TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA384&quot;},</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-AES256-SHA&quot;, &quot;T=
LS-ECDHE-RSA-WITH-AES-256-CBC-SHA&quot;},</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-CAMELLIA128-SHA256&quot;, &quot;=
TLS-ECDHE-RSA-WITH-CAMELLIA-128-CBC-SHA256&quot;},</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-CAMELLIA128-SHA&quot;, =
&quot;TLS-ECDHE-RSA-WITH-CAMELLIA-128-CBC-SHA&quot;},</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-CAMELLIA256-SHA256&q=
uot;, &quot;TLS-ECDHE-RSA-WITH-CAMELLIA-256-CBC-SHA256&quot;},</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-CAMELLIA256=
-SHA&quot;, &quot;TLS-ECDHE-RSA-WITH-CAMELLIA-256-CBC-SHA&quot;},</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-CHACHA20=
-POLY1305&quot;, &quot;TLS-ECDHE-RSA-WITH-CHACHA20-POLY1305-SHA256&quot;},<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA=
-DES-CBC3-SHA&quot;, &quot;TLS-ECDHE-RSA-WITH-3DES-EDE-CBC-SHA&quot;},</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-DES=
-CBC-SHA&quot;, &quot;TLS-ECDHE-RSA-WITH-DES-CBC-SHA&quot;},</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-RC4-SHA&quot;=
, &quot;TLS-ECDHE-RSA-WITH-RC4-128-SHA&quot;},</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {&quot;ECDH-RSA-AES128-GCM-SHA256&quot;, &qu=
ot;TLS-ECDH-RSA-WITH-AES-128-GCM-SHA256&quot;},</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {&quot;ECDH-RSA-AES128-SHA256&quot;, &quot;=
TLS-ECDH-RSA-WITH-AES-128-CBC-SHA256&quot;},</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {&quot;ECDH-RSA-AES128-SHA384&quot;, &quot;TLS=
-ECDH-RSA-WITH-AES-128-CBC-SHA384&quot;},</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {&quot;ECDH-RSA-AES128-SHA&quot;, &quot;TLS-ECDH-=
RSA-WITH-AES-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {&quot;ECDH-RSA-AES256-GCM-SHA384&quot;, &quot;TLS-ECDH-RS=
A-WITH-AES-256-GCM-SHA384&quot;},</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {&quot;ECDH-RSA-AES256-SHA256&quot;, &quot;TLS-ECDH-RSA-W=
ITH-AES-256-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {&quot;ECDH-RSA-AES256-SHA384&quot;, &quot;TLS-ECDH-RSA-WITH=
-AES-256-CBC-SHA384&quot;},</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {&quot;ECDH-RSA-AES256-SHA&quot;, &quot;TLS-ECDH-RSA-WITH-AES-2=
56-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {&quot;ECDH-RSA-CAMELLIA128-SHA256&quot;, &quot;TLS-ECDH-RSA-WITH-CAMELL=
IA-128-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {&quot;ECDH-RSA-CAMELLIA128-SHA&quot;, &quot;TLS-ECDH-RSA-WITH-CA=
MELLIA-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {&quot;ECDH-RSA-CAMELLIA256-SHA256&quot;, &quot;TLS-ECDH-RSA-WIT=
H-CAMELLIA-256-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {&quot;ECDH-RSA-CAMELLIA256-SHA&quot;, &quot;TLS-ECDH-RSA=
-WITH-CAMELLIA-256-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {&quot;ECDH-RSA-DES-CBC3-SHA&quot;, &quot;TLS-ECDH-RSA-W=
ITH-3DES-EDE-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {&quot;ECDH-RSA-DES-CBC-SHA&quot;, &quot;TLS-ECDH-RSA-WITH-DES=
-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {&quot;ECDH-RSA-RC4-SHA&quot;, &quot;TLS-ECDH-RSA-WITH-RC4-128-SHA&quot;},=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;EDH-DSS-=
DES-CBC3-SHA&quot;, &quot;TLS-DHE-DSS-WITH-3DES-EDE-CBC-SHA&quot;},</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;EDH-DSS-DES-CBC-=
SHA&quot;, &quot;TLS-DHE-DSS-WITH-DES-CBC-SHA&quot;},</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {&quot;EDH-RSA-DES-CBC3-SHA&quot;, &q=
uot;TLS-DHE-RSA-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {&quot;EDH-RSA-DES-CBC-SHA&quot;, &quot;TLS-D=
HE-RSA-WITH-DES-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {&quot;EXP-DES-CBC-SHA&quot;, &quot;TLS-RSA-EXPORT-WITH-DES=
40-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {&quot;EXP-EDH-DSS-DES-CBC-SHA&quot;, &quot;TLS-DH-DSS-EXPORT-WITH-DES40=
-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {&quot;EXP-EDH-RSA-DES-CBC-SHA&quot;, &quot;TLS-DH-RSA-EXPORT-WITH-DES40-C=
BC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
&quot;EXP-RC2-CBC-MD5&quot;, &quot;TLS-RSA-EXPORT-WITH-RC2-CBC-40-MD5&quot;=
},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;EXP-RC=
4-MD5&quot;, &quot;TLS-RSA-EXPORT-WITH-RC4-40-MD5&quot;},</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {&quot;NULL-MD5&quot;, &quot;TLS-=
RSA-WITH-NULL-MD5&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {&quot;NULL-SHA256&quot;, &quot;TLS-RSA-WITH-NULL-SHA256&quot;},<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;NULL-SHA&=
quot;, &quot;TLS-RSA-WITH-NULL-SHA&quot;},</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {&quot;PSK-3DES-EDE-CBC-SHA&quot;, &quot;TLS-PSK=
-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {&quot;PSK-AES128-CBC-SHA&quot;, &quot;TLS-PSK-WITH-AES-128-=
CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{&quot;PSK-AES256-CBC-SHA&quot;, &quot;TLS-PSK-WITH-AES-256-CBC-SHA&quot;},=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;PSK-RC4-=
SHA&quot;, &quot;TLS-PSK-WITH-RC4-128-SHA&quot;},</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {&quot;RC4-MD5&quot;, &quot;TLS-RSA-WITH-=
RC4-128-MD5&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {&quot;RC4-SHA&quot;, &quot;TLS-RSA-WITH-RC4-128-SHA&quot;},</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;SEED-SHA&quot;, &qu=
ot;TLS-RSA-WITH-SEED-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {&quot;SRP-DSS-3DES-EDE-CBC-SHA&quot;, &quot;TLS-SRP-S=
HA-DSS-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {&quot;SRP-DSS-AES-128-CBC-SHA&quot;, &quot;TLS-SRP-SH=
A-DSS-WITH-AES-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {&quot;SRP-DSS-AES-256-CBC-SHA&quot;, &quot;TLS-SRP-SHA-=
DSS-WITH-AES-256-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {&quot;SRP-RSA-3DES-EDE-CBC-SHA&quot;, &quot;TLS-SRP-SHA-R=
SA-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {&quot;SRP-RSA-AES-128-CBC-SHA&quot;, &quot;TLS-SRP-SHA-RS=
A-WITH-AES-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {&quot;SRP-RSA-AES-256-CBC-SHA&quot;, &quot;TLS-SRP-SHA-RSA-=
WITH-AES-256-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#ifdef ENABLE_CRYPTO_OPENSSL</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* OpenSSL-specific group names */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {&quot;DEFAULT&quot;, &quot;DEFAUL=
T&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot=
;ALL&quot;, &quot;ALL&quot;},</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {&quot;HIGH&quot;, &quot;HIGH&quot;}, {&quot;!HIGH&quot;, &qu=
ot;!HIGH&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {&quot;MEDIUM&quot;, &quot;MEDIUM&quot;}, {&quot;!MEDIUM&quot;, &quot;!MED=
IUM&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&qu=
ot;LOW&quot;, &quot;LOW&quot;}, {&quot;!LOW&quot;, &quot;!LOW&quot;},</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH&quot;, &q=
uot;ECDH&quot;}, {&quot;!ECDH&quot;, &quot;!ECDH&quot;},</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDSA&quot;, &quot;ECDSA&qu=
ot;}, {&quot;!ECDSA&quot;, &quot;!ECDSA&quot;},</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {&quot;EDH&quot;, &quot;EDH&quot;}, {&quot;=
!EDH&quot;, &quot;!EDH&quot;},</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {&quot;EXP&quot;, &quot;EXP&quot;}, {&quot;!EXP&quot;, &quot=
;!EXP&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&=
quot;RSA&quot;, &quot;RSA&quot;}, {&quot;!RSA&quot;, &quot;!RSA&quot;},</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;kRSA&quot;, =
&quot;kRSA&quot;}, {&quot;!kRSA&quot;, &quot;!kRSA&quot;},</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {&quot;SRP&quot;, &quot;SRP&quot=
;}, {&quot;!SRP&quot;, &quot;!SRP&quot;},</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {NULL, NULL}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+const tls_cipher_name_pair *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_get_cipher_name_p=
air(const char *cipher_name, size_t len)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const tls_cipher_name_pair *pair =3D tls_cipher_name_translation_tab=
le;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    while (pair-&gt;openssl_name !=
=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((strlen(pair=
-&gt;openssl_name) =3D=3D len &amp;&amp; 0 =3D=3D memcmp(cipher_name, pair-=
&gt;openssl_name, len))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            || (strlen(pair-&gt;iana_name) =3D=3D len &amp;&amp; 0 =3D=
=3D memcmp(cipher_name, pair-&gt;iana_name, len)))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            return pair;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        pair++;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* No entry found=
, return NULL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+get_num_elements(const char *string, char delimiter)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int string_len =3D strlen(string);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0 !=3D string_len);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int element_count =3D 1;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* Get number of ciphers */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt;=
 string_len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (stri=
ng[i] =3D=3D delimiter)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      element_count++;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return element_count;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src=
/openvpn/ssl_util.h b/src/openvpn/ssl_util.h</span><br><span>index 4c46f88.=
.b3eaf9f 100644</span><br><span>--- a/src/openvpn/ssl_util.h</span><br><spa=
n>+++ b/src/openvpn/ssl_util.h</span><br><span>@@ -66,4 +66,27 @@</span><br=
><span>  */</span><br><span> const char *options_string_compat_lzo(const ch=
ar *options, struct gc_arena *gc);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Get a tls_cipher_name_pair containing OpenSSL and IANA names for supp=
lied TLS cipher name</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param cipher=
_name   Can be either OpenSSL or IANA cipher name</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @return              tls_cipher_name_pair*=
 if found, NULL otherwise</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef st=
ruct { const char *openssl_name; const char *iana_name; } tls_cipher_name_p=
air;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const tls_ciphe=
r_name_pair *tls_get_cipher_name_pair(const char *cipher_name, size_t len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Returns the occurrences of &#39;delimiter&#39; in a=
 string +1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This i=
s typically used to find out the number elements in a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * cipher string or similar that is separ=
ated by : like</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   X25519:secp256r1:=
X448:secp512r1:secp384r1:brainpoolP384r1</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param string        the string to work on</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param delimiter     the delimiter to coun=
t, typically &#39;:&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return              occrrences of delimiter + 1</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+get_num_elements(const char *string, char delimiter);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif /* ifndef SSL_UTIL_H_ */</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/470?usp=3Demail">change 470</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/470?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I605394d4f3872a168d05bbbe52d=
90f6d48935865 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 470 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--SVcGJDC1M+8=--

