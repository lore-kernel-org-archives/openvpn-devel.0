From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 9 Dec 2023 10:05:32 +0000
In-Reply-To: <gerrit.1701971374000.I605394d4f3872a168d05bbbe52d90f6d48935865@...2715...>
References: <gerrit.1701971374000.I605394d4f3872a168d05bbbe52d90f6d48935865@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <37cf7a12ff34b9e19c441e184ed66518d6c51652-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L9w3Q3vnYGU="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--L9w3Q3vnYGU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/47=
0?usp=3Demail )

Change subject: Move tls_get_cipher_name_pair and get_num_elements to ssl_u=
tils.c
......................................................................

Move tls_get_cipher_name_pair and get_num_elements to ssl_utils.c

This allow these functions to be defined without having to include ssl.c/mi=
sc.c
which pulls in a lot of more dependencies.

Change-Id: I605394d4f3872a168d05bbbe52d90f6d48935865
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231208173346.94820-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
726.html
Signed-off-by: Gert Doering <gert@...1296...>
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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--L9w3Q3vnYGU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/470?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Move tls_get_cipher_name_pair and get_num_elem=
ents to ssl_utils.c<br><br>This allow these functions to be defined without=
 having to include ssl.c/misc.c<br>which pulls in a lot of more dependencie=
s.<br><br>Change-Id: I605394d4f3872a168d05bbbe52d90f6d48935865<br>Signed-of=
f-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &=
lt;frank@...2641...&gt;<br>Message-Id: &lt;20231208173346.94820-1-frank@...493...=
2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1659...=
forge.net/msg27726.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&=
gt;<br>---<br>M src/openvpn/misc.c<br>M src/openvpn/misc.h<br>M src/openvpn=
/ssl.c<br>M src/openvpn/ssl_backend.h<br>M src/openvpn/ssl_mbedtls.c<br>M s=
rc/openvpn/ssl_openssl.c<br>M src/openvpn/ssl_util.c<br>M src/openvpn/ssl_u=
til.h<br>8 files changed, 211 insertions(+), 208 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c</span><br><span>ind=
ex ce6e4fd..bce63ed 100644</span><br><span>--- a/src/openvpn/misc.c</span><=
br><span>+++ b/src/openvpn/misc.c</span><br><span>@@ -773,26 +773,6 @@</spa=
n><br><span>     }</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-get_num_elements(const char *string, char delimiter)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int string_len =3D strlen(string);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    ASSERT(0 !=3D string_len);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    int element_count =3D 1;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* Get number of ciphers */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; string_len; i++)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (string[i] =3D=3D delimiter)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            element_count++;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return element_count;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> struct buffer</span><br><span> prepend_dir(const char *dir, const char *p=
ath, struct gc_arena *gc)</span><br><span> {</span><br><span>diff --git a/s=
rc/openvpn/misc.h b/src/openvpn/misc.h</span><br><span>index b000b72..70a24=
dd 100644</span><br><span>--- a/src/openvpn/misc.h</span><br><span>+++ b/sr=
c/openvpn/misc.h</span><br><span>@@ -193,20 +193,6 @@</span><br><span> void=
 output_peer_info_env(struct env_set *es, const char *peer_info);</span><br=
><span> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * Returns the occurrences of &#39;delimiter&#39; in a string +1</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * This is typically use=
d to find out the number elements in a</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * cipher string or similar that is separated by : like</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *   X25519:secp256r1:X448:secp512r1:secp38=
4r1:brainpoolP384r1</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param string     =
   the string to work on</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * @param delimiter     the delimiter to count, typically &#39;:&#39;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return              =
occrrences of delimiter + 1</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-get_num_elements(const char *s=
tring, char delimiter);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span=
>  * Prepend a directory to a path.</span><br><span>  */</span><br><span> s=
truct buffer</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/s=
sl.c</span><br><span>index 3e3696c..6eddb68 100644</span><br><span>--- a/sr=
c/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ =
-95,152 +95,6 @@</span><br><span> #endif /* ifdef MEASURE_TLS_HANDSHAKE_STA=
TS */</span><br><span> </span><br><span> /**</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * SSL/TLS Cipher suite name translation table</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static const tls_cipher_name_pair tls_ciphe=
r_name_translation_table[] =3D {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {&quot;ADH-SEED-SHA&quot;, &quot;TLS-DH-anon-WITH-SEED-CBC-S=
HA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;=
AES128-GCM-SHA256&quot;, &quot;TLS-RSA-WITH-AES-128-GCM-SHA256&quot;},</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;AES128-SHA256&q=
uot;, &quot;TLS-RSA-WITH-AES-128-CBC-SHA256&quot;},</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {&quot;AES128-SHA&quot;, &quot;TLS-RSA-=
WITH-AES-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {&quot;AES256-GCM-SHA384&quot;, &quot;TLS-RSA-WITH-AES-256-GCM-S=
HA384&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&qu=
ot;AES256-SHA256&quot;, &quot;TLS-RSA-WITH-AES-256-CBC-SHA256&quot;},</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;AES256-SHA&quot;=
, &quot;TLS-RSA-WITH-AES-256-CBC-SHA&quot;},</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {&quot;CAMELLIA128-SHA256&quot;, &quot;TLS-RSA-W=
ITH-CAMELLIA-128-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {&quot;CAMELLIA128-SHA&quot;, &quot;TLS-RSA-WITH-CAMELLIA=
-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {&quot;CAMELLIA256-SHA256&quot;, &quot;TLS-RSA-WITH-CAMELLIA-256-CBC-SHA=
256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot=
;CAMELLIA256-SHA&quot;, &quot;TLS-RSA-WITH-CAMELLIA-256-CBC-SHA&quot;},</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DES-CBC3-SHA&q=
uot;, &quot;TLS-RSA-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {&quot;DES-CBC-SHA&quot;, &quot;TLS-RSA-WIT=
H-DES-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {&quot;DH-DSS-SEED-SHA&quot;, &quot;TLS-DH-DSS-WITH-SEED-CBC-SHA&quot;}=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-DSS-A=
ES128-GCM-SHA256&quot;, &quot;TLS-DHE-DSS-WITH-AES-128-GCM-SHA256&quot;},</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-DSS-AES1=
28-SHA256&quot;, &quot;TLS-DHE-DSS-WITH-AES-128-CBC-SHA256&quot;},</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-DSS-AES128-SHA&=
quot;, &quot;TLS-DHE-DSS-WITH-AES-128-CBC-SHA&quot;},</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-DSS-AES256-GCM-SHA384&quot;,=
 &quot;TLS-DHE-DSS-WITH-AES-256-GCM-SHA384&quot;},</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {&quot;DHE-DSS-AES256-SHA256&quot;, &quot;=
TLS-DHE-DSS-WITH-AES-256-CBC-SHA256&quot;},</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {&quot;DHE-DSS-AES256-SHA&quot;, &quot;TLS-DHE-DS=
S-WITH-AES-256-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {&quot;DHE-DSS-CAMELLIA128-SHA256&quot;, &quot;TLS-DHE-DSS-WIT=
H-CAMELLIA-128-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {&quot;DHE-DSS-CAMELLIA128-SHA&quot;, &quot;TLS-DHE-DSS-WIT=
H-CAMELLIA-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {&quot;DHE-DSS-CAMELLIA256-SHA256&quot;, &quot;TLS-DHE-DSS-WIT=
H-CAMELLIA-256-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {&quot;DHE-DSS-CAMELLIA256-SHA&quot;, &quot;TLS-DHE-DSS-WIT=
H-CAMELLIA-256-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {&quot;DHE-DSS-SEED-SHA&quot;, &quot;TLS-DHE-DSS-WITH-SEED-CBC=
-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quo=
t;DHE-RSA-AES128-GCM-SHA256&quot;, &quot;TLS-DHE-RSA-WITH-AES-128-GCM-SHA25=
6&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;D=
HE-RSA-AES128-SHA256&quot;, &quot;TLS-DHE-RSA-WITH-AES-128-CBC-SHA256&quot;=
},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-RSA-=
AES128-SHA&quot;, &quot;TLS-DHE-RSA-WITH-AES-128-CBC-SHA&quot;},</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-RSA-AES256-GCM-SH=
A384&quot;, &quot;TLS-DHE-RSA-WITH-AES-256-GCM-SHA384&quot;},</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-RSA-AES256-SHA256&qu=
ot;, &quot;TLS-DHE-RSA-WITH-AES-256-CBC-SHA256&quot;},</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {&quot;DHE-RSA-AES256-SHA&quot;, &quot=
;TLS-DHE-RSA-WITH-AES-256-CBC-SHA&quot;},</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {&quot;DHE-RSA-CAMELLIA128-SHA256&quot;, &quot;TLS-=
DHE-RSA-WITH-CAMELLIA-128-CBC-SHA256&quot;},</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {&quot;DHE-RSA-CAMELLIA128-SHA&quot;, &quot;TLS-=
DHE-RSA-WITH-CAMELLIA-128-CBC-SHA&quot;},</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {&quot;DHE-RSA-CAMELLIA256-SHA256&quot;, &quot;TLS-=
DHE-RSA-WITH-CAMELLIA-256-CBC-SHA256&quot;},</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {&quot;DHE-RSA-CAMELLIA256-SHA&quot;, &quot;TLS-=
DHE-RSA-WITH-CAMELLIA-256-CBC-SHA&quot;},</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {&quot;DHE-RSA-CHACHA20-POLY1305&quot;, &quot;TLS-D=
HE-RSA-WITH-CHACHA20-POLY1305-SHA256&quot;},</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {&quot;DHE-RSA-SEED-SHA&quot;, &quot;TLS-DHE-RSA=
-WITH-SEED-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {&quot;DH-RSA-SEED-SHA&quot;, &quot;TLS-DH-RSA-WITH-SEED-CBC-SHA&q=
uot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDH=
-ECDSA-AES128-GCM-SHA256&quot;, &quot;TLS-ECDH-ECDSA-WITH-AES-128-GCM-SHA25=
6&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;E=
CDH-ECDSA-AES128-SHA256&quot;, &quot;TLS-ECDH-ECDSA-WITH-AES-128-CBC-SHA256=
&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;EC=
DH-ECDSA-AES128-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-AES-128-CBC-SHA&quot;}=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDH-ECDS=
A-AES256-GCM-SHA384&quot;, &quot;TLS-ECDH-ECDSA-WITH-AES-256-GCM-SHA384&quo=
t;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDH-E=
CDSA-AES256-SHA256&quot;, &quot;TLS-ECDH-ECDSA-WITH-AES-256-CBC-SHA256&quot=
;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDH-EC=
DSA-AES256-SHA384&quot;, &quot;TLS-ECDH-ECDSA-WITH-AES-256-CBC-SHA384&quot;=
},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDH-ECD=
SA-AES256-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-AES-256-CBC-SHA&quot;},</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDH-ECDSA-CAME=
LLIA128-SHA256&quot;, &quot;TLS-ECDH-ECDSA-WITH-CAMELLIA-128-CBC-SHA256&quo=
t;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDH-E=
CDSA-CAMELLIA128-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-CAMELLIA-128-CBC-SHA&=
quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECD=
H-ECDSA-CAMELLIA256-SHA256&quot;, &quot;TLS-ECDH-ECDSA-WITH-CAMELLIA-256-CB=
C-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
&quot;ECDH-ECDSA-CAMELLIA256-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-CAMELLIA-=
256-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {&quot;ECDH-ECDSA-DES-CBC3-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-3DES-EDE-=
CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&=
quot;ECDH-ECDSA-DES-CBC-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-DES-CBC-SHA&qu=
ot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDH-=
ECDSA-RC4-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-RC4-128-SHA&quot;},</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-ECDSA-AES128-=
GCM-SHA256&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256&quot;},</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-ECDSA-AE=
S128-SHA256&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA256&quot;},</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-ECDSA-A=
ES128-SHA384&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA384&quot;},</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-ECDSA-=
AES128-SHA&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA&quot;},</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-ECDSA-AES25=
6-GCM-SHA384&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-256-GCM-SHA384&quot;},</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-ECDSA-=
AES256-SHA256&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA256&quot;},<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-ECDSA=
-AES256-SHA384&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA384&quot;},=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-ECDS=
A-AES256-SHA&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA&quot;},</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-ECDSA-CAM=
ELLIA128-SHA256&quot;, &quot;TLS-ECDHE-ECDSA-WITH-CAMELLIA-128-CBC-SHA256&q=
uot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDH=
E-ECDSA-CAMELLIA128-SHA&quot;, &quot;TLS-ECDHE-ECDSA-WITH-CAMELLIA-128-CBC-=
SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot=
;ECDHE-ECDSA-CAMELLIA256-SHA256&quot;, &quot;TLS-ECDHE-ECDSA-WITH-CAMELLIA-=
256-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {&quot;ECDHE-ECDSA-CAMELLIA256-SHA&quot;, &quot;TLS-ECDHE-ECDSA-WITH-C=
AMELLIA-256-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {&quot;ECDHE-ECDSA-CHACHA20-POLY1305&quot;, &quot;TLS-ECDHE-ECDSA=
-WITH-CHACHA20-POLY1305-SHA256&quot;},</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {&quot;ECDHE-ECDSA-DES-CBC3-SHA&quot;, &quot;TLS-ECDHE=
-ECDSA-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {&quot;ECDHE-ECDSA-DES-CBC-SHA&quot;, &quot;TLS-ECDHE-EC=
DSA-WITH-DES-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {&quot;ECDHE-ECDSA-RC4-SHA&quot;, &quot;TLS-ECDHE-ECDSA-WITH-RC4=
-128-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
&quot;ECDHE-RSA-AES128-GCM-SHA256&quot;, &quot;TLS-ECDHE-RSA-WITH-AES-128-G=
CM-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{&quot;ECDHE-RSA-AES128-SHA256&quot;, &quot;TLS-ECDHE-RSA-WITH-AES-128-CBC-=
SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&q=
uot;ECDHE-RSA-AES128-SHA384&quot;, &quot;TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA=
384&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot=
;ECDHE-RSA-AES128-SHA&quot;, &quot;TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA&quot;=
},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-RS=
A-AES256-GCM-SHA384&quot;, &quot;TLS-ECDHE-RSA-WITH-AES-256-GCM-SHA384&quot=
;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-R=
SA-AES256-SHA256&quot;, &quot;TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA256&quot;},=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-RSA-=
AES256-SHA384&quot;, &quot;TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA384&quot;},</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-RSA-AES=
256-SHA&quot;, &quot;TLS-ECDHE-RSA-WITH-AES-256-CBC-SHA&quot;},</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-RSA-CAMELLIA128-=
SHA256&quot;, &quot;TLS-ECDHE-RSA-WITH-CAMELLIA-128-CBC-SHA256&quot;},</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-RSA-CAMEL=
LIA128-SHA&quot;, &quot;TLS-ECDHE-RSA-WITH-CAMELLIA-128-CBC-SHA&quot;},</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-RSA-CAME=
LLIA256-SHA256&quot;, &quot;TLS-ECDHE-RSA-WITH-CAMELLIA-256-CBC-SHA256&quot=
;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-R=
SA-CAMELLIA256-SHA&quot;, &quot;TLS-ECDHE-RSA-WITH-CAMELLIA-256-CBC-SHA&quo=
t;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-=
RSA-CHACHA20-POLY1305&quot;, &quot;TLS-ECDHE-RSA-WITH-CHACHA20-POLY1305-SHA=
256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot=
;ECDHE-RSA-DES-CBC3-SHA&quot;, &quot;TLS-ECDHE-RSA-WITH-3DES-EDE-CBC-SHA&qu=
ot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE=
-RSA-DES-CBC-SHA&quot;, &quot;TLS-ECDHE-RSA-WITH-DES-CBC-SHA&quot;},</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDHE-RSA-RC4-SHA=
&quot;, &quot;TLS-ECDHE-RSA-WITH-RC4-128-SHA&quot;},</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDH-RSA-AES128-GCM-SHA256&quot;=
, &quot;TLS-ECDH-RSA-WITH-AES-128-GCM-SHA256&quot;},</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDH-RSA-AES128-SHA256&quot;, &q=
uot;TLS-ECDH-RSA-WITH-AES-128-CBC-SHA256&quot;},</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {&quot;ECDH-RSA-AES128-SHA384&quot;, &quot;T=
LS-ECDH-RSA-WITH-AES-128-CBC-SHA384&quot;},</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {&quot;ECDH-RSA-AES128-SHA&quot;, &quot;TLS-ECDH-=
RSA-WITH-AES-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {&quot;ECDH-RSA-AES256-GCM-SHA384&quot;, &quot;TLS-ECDH-RSA-=
WITH-AES-256-GCM-SHA384&quot;},</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {&quot;ECDH-RSA-AES256-SHA256&quot;, &quot;TLS-ECDH-RSA-WITH-=
AES-256-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {&quot;ECDH-RSA-AES256-SHA384&quot;, &quot;TLS-ECDH-RSA-WITH-AES-2=
56-CBC-SHA384&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {&quot;ECDH-RSA-AES256-SHA&quot;, &quot;TLS-ECDH-RSA-WITH-AES-256-CBC-S=
HA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;=
ECDH-RSA-CAMELLIA128-SHA256&quot;, &quot;TLS-ECDH-RSA-WITH-CAMELLIA-128-CBC=
-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&=
quot;ECDH-RSA-CAMELLIA128-SHA&quot;, &quot;TLS-ECDH-RSA-WITH-CAMELLIA-128-C=
BC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&q=
uot;ECDH-RSA-CAMELLIA256-SHA256&quot;, &quot;TLS-ECDH-RSA-WITH-CAMELLIA-256=
-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {&quot;ECDH-RSA-CAMELLIA256-SHA&quot;, &quot;TLS-ECDH-RSA-WITH-CAMELLIA-2=
56-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {&quot;ECDH-RSA-DES-CBC3-SHA&quot;, &quot;TLS-ECDH-RSA-WITH-3DES-EDE-CBC-S=
HA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;=
ECDH-RSA-DES-CBC-SHA&quot;, &quot;TLS-ECDH-RSA-WITH-DES-CBC-SHA&quot;},</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDH-RSA-RC4-S=
HA&quot;, &quot;TLS-ECDH-RSA-WITH-RC4-128-SHA&quot;},</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {&quot;EDH-DSS-DES-CBC3-SHA&quot;, &quo=
t;TLS-DHE-DSS-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {&quot;EDH-DSS-DES-CBC-SHA&quot;, &quot;TLS-DHE-D=
SS-WITH-DES-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {&quot;EDH-RSA-DES-CBC3-SHA&quot;, &quot;TLS-DHE-RSA-WITH-3DES-ED=
E-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{&quot;EDH-RSA-DES-CBC-SHA&quot;, &quot;TLS-DHE-RSA-WITH-DES-CBC-SHA&quot;}=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;EXP-DES-C=
BC-SHA&quot;, &quot;TLS-RSA-EXPORT-WITH-DES40-CBC-SHA&quot;},</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {&quot;EXP-EDH-DSS-DES-CBC-SHA&=
quot;, &quot;TLS-DH-DSS-EXPORT-WITH-DES40-CBC-SHA&quot;},</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {&quot;EXP-EDH-RSA-DES-CBC-SHA&quot=
;, &quot;TLS-DH-RSA-EXPORT-WITH-DES40-CBC-SHA&quot;},</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {&quot;EXP-RC2-CBC-MD5&quot;, &quot;TLS=
-RSA-EXPORT-WITH-RC2-CBC-40-MD5&quot;},</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {&quot;EXP-RC4-MD5&quot;, &quot;TLS-RSA-EXPORT-WITH-R=
C4-40-MD5&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{&quot;NULL-MD5&quot;, &quot;TLS-RSA-WITH-NULL-MD5&quot;},</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {&quot;NULL-SHA256&quot;, &quot;TL=
S-RSA-WITH-NULL-SHA256&quot;},</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {&quot;NULL-SHA&quot;, &quot;TLS-RSA-WITH-NULL-SHA&quot;},</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;PSK-3DES-EDE-C=
BC-SHA&quot;, &quot;TLS-PSK-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {&quot;PSK-AES128-CBC-SHA&quot;, &q=
uot;TLS-PSK-WITH-AES-128-CBC-SHA&quot;},</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {&quot;PSK-AES256-CBC-SHA&quot;, &quot;TLS-PSK-WITH-=
AES-256-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {&quot;PSK-RC4-SHA&quot;, &quot;TLS-PSK-WITH-RC4-128-SHA&quot;},</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;RC4-MD5&quot;, =
&quot;TLS-RSA-WITH-RC4-128-MD5&quot;},</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {&quot;RC4-SHA&quot;, &quot;TLS-RSA-WITH-RC4-128-SHA&q=
uot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;SEED=
-SHA&quot;, &quot;TLS-RSA-WITH-SEED-CBC-SHA&quot;},</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {&quot;SRP-DSS-3DES-EDE-CBC-SHA&quot;, =
&quot;TLS-SRP-SHA-DSS-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {&quot;SRP-DSS-AES-128-CBC-SHA&quot;, &=
quot;TLS-SRP-SHA-DSS-WITH-AES-128-CBC-SHA&quot;},</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {&quot;SRP-DSS-AES-256-CBC-SHA&quot;, &quot=
;TLS-SRP-SHA-DSS-WITH-AES-256-CBC-SHA&quot;},</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {&quot;SRP-RSA-3DES-EDE-CBC-SHA&quot;, &quot;TL=
S-SRP-SHA-RSA-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {&quot;SRP-RSA-AES-128-CBC-SHA&quot;, &quot;TLS-S=
RP-SHA-RSA-WITH-AES-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {&quot;SRP-RSA-AES-256-CBC-SHA&quot;, &quot;TLS-SRP-S=
HA-RSA-WITH-AES-256-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#ifdef ENABLE_CRYPTO_OPENSSL</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /* OpenSSL-specific group names */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {&quot;DEFAULT&quot;, &quot;DEFAU=
LT&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;=
ALL&quot;, &quot;ALL&quot;},</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {&quot;HIGH&quot;, &quot;HIGH&quot;}, {&quot;!HIGH&quot;, &quot;=
!HIGH&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&qu=
ot;MEDIUM&quot;, &quot;MEDIUM&quot;}, {&quot;!MEDIUM&quot;, &quot;!MEDIUM&q=
uot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;LOW&=
quot;, &quot;LOW&quot;}, {&quot;!LOW&quot;, &quot;!LOW&quot;},</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {&quot;ECDH&quot;, &quot;ECDH&=
quot;}, {&quot;!ECDH&quot;, &quot;!ECDH&quot;},</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {&quot;ECDSA&quot;, &quot;ECDSA&quot;}, {&quo=
t;!ECDSA&quot;, &quot;!ECDSA&quot;},</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {&quot;EDH&quot;, &quot;EDH&quot;}, {&quot;!EDH&quot;, &=
quot;!EDH&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{&quot;EXP&quot;, &quot;EXP&quot;}, {&quot;!EXP&quot;, &quot;!EXP&quot;},</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {&quot;RSA&quot;, &=
quot;RSA&quot;}, {&quot;!RSA&quot;, &quot;!RSA&quot;},</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {&quot;kRSA&quot;, &quot;kRSA&quot;}, =
{&quot;!kRSA&quot;, &quot;!kRSA&quot;},</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {&quot;SRP&quot;, &quot;SRP&quot;}, {&quot;!SRP&quot;=
, &quot;!SRP&quot;},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {NULL, NULL}=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-/**</span><br><span>  * Update the implicit IV for a key_ctx_=
bi based on TLS session ids and cipher</span><br><span>  * used.</span><br>=
<span>  *</span><br><span>@@ -254,24 +108,6 @@</span><br><span> static void=
</span><br><span> key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *=
key, size_t key_len);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-const tls_cipher_name_pair *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-tls_get_cipher_name_pair(const char *cipher_name, =
size_t len)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    const tls_cipher_name_pair=
 *pair =3D tls_cipher_name_translation_table;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    while (pair-&gt;openssl_name !=3D NULL)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if ((strlen(pair-&gt;openssl_name) =3D=3D len &amp;&amp; 0=
 =3D=3D memcmp(cipher_name, pair-&gt;openssl_name, len))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            || (strlen(pair-&gt;iana_nam=
e) =3D=3D len &amp;&amp; 0 =3D=3D memcmp(cipher_name, pair-&gt;iana_name, l=
en)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            return pair;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        pair++;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /=
* No entry found, return NULL */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return NULL;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span> </span><br><span> /**</span><br><span>  * Limit th=
e reneg_bytes value when using a small-block (&lt;128 bytes) cipher.</span>=
<br><span>diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.=
h</span><br><span>index 3854d59..b9466ce 100644</span><br><span>--- a/src/o=
penvpn/ssl_backend.h</span><br><span>+++ b/src/openvpn/ssl_backend.h</span>=
<br><span>@@ -53,15 +53,6 @@</span><br><span>  */</span><br><span> struct t=
ls_session;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Get a t=
ls_cipher_name_pair containing OpenSSL and IANA names for supplied TLS ciph=
er name</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * @param cipher_name   Can be ei=
ther OpenSSL or IANA cipher name</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * @return              tls_cipher_name_pair* if found, NULL oth=
erwise</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-typedef struct { const char *open=
ssl_name; const char *iana_name; } tls_cipher_name_pair;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-const tls_cipher_name_pair *tls_get_ciph=
er_name_pair(const char *cipher_name, size_t len);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  *</span=
><br><span>  * Functions implemented in ssl.c for use by the backend SSL li=
brary</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/=
ssl_mbedtls.c</span><br><span>index 9c9167d..cc88484 100644</span><br><span=
>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbed=
tls.c</span><br><span>@@ -44,6 +44,7 @@</span><br><span> #include &quot;mbe=
dtls_compat.h&quot;</span><br><span> #include &quot;pkcs11_backend.h&quot;<=
/span><br><span> #include &quot;ssl_common.h&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;ssl_util.h&quot;</span><br><s=
pan> </span><br><span> #include &quot;ssl_verify_mbedtls.h&quot;</span><br>=
<span> #include &lt;mbedtls/debug.h&gt;</span><br><span>diff --git a/src/op=
envpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index 82872=
bf..c30e6a9 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</span><b=
r><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -50,6 +50,7 @@</=
span><br><span> #endif</span><br><span> </span><br><span> #include &quot;ss=
l_verify_openssl.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;ssl_util.h&quot;</span><br><span> </span><br><span> #in=
clude &lt;openssl/bn.h&gt;</span><br><span> #include &lt;openssl/crypto.h&g=
t;</span><br><span>diff --git a/src/openvpn/ssl_util.c b/src/openvpn/ssl_ut=
il.c</span><br><span>index bca6eed..447e739 100644</span><br><span>--- a/sr=
c/openvpn/ssl_util.c</span><br><span>+++ b/src/openvpn/ssl_util.c</span><br=
><span>@@ -114,3 +114,188 @@</span><br><span> </span><br><span>     return =
BSTR(&amp;buf);</span><br><span> }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * SSL/TLS Cipher su=
ite name translation table</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static co=
nst tls_cipher_name_pair tls_cipher_name_translation_table[] =3D {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ADH-SEED-SHA&quot=
;, &quot;TLS-DH-anon-WITH-SEED-CBC-SHA&quot;},</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {&quot;AES128-GCM-SHA256&quot;, &quot;TLS-RS=
A-WITH-AES-128-GCM-SHA256&quot;},</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {&quot;AES128-SHA256&quot;, &quot;TLS-RSA-WITH-AES-128-CB=
C-SHA256&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {&quot;AES128-SHA&quot;, &quot;TLS-RSA-WITH-AES-128-CBC-SHA&quot;},</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;AES256-GCM-SHA3=
84&quot;, &quot;TLS-RSA-WITH-AES-256-GCM-SHA384&quot;},</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {&quot;AES256-SHA256&quot;, &quot;T=
LS-RSA-WITH-AES-256-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {&quot;AES256-SHA&quot;, &quot;TLS-RSA-WITH-AES-256-=
CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{&quot;CAMELLIA128-SHA256&quot;, &quot;TLS-RSA-WITH-CAMELLIA-128-CBC-SHA256=
&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;=
CAMELLIA128-SHA&quot;, &quot;TLS-RSA-WITH-CAMELLIA-128-CBC-SHA&quot;},</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;CAMELLIA256-S=
HA256&quot;, &quot;TLS-RSA-WITH-CAMELLIA-256-CBC-SHA256&quot;},</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;CAMELLIA256-SHA&quot=
;, &quot;TLS-RSA-WITH-CAMELLIA-256-CBC-SHA&quot;},</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {&quot;DES-CBC3-SHA&quot;, &quot;TLS-RSA=
-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {&quot;DES-CBC-SHA&quot;, &quot;TLS-RSA-WITH-DES-CBC-SHA&quo=
t;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DH-D=
SS-SEED-SHA&quot;, &quot;TLS-DH-DSS-WITH-SEED-CBC-SHA&quot;},</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-DSS-AES128-GCM-SHA=
256&quot;, &quot;TLS-DHE-DSS-WITH-AES-128-GCM-SHA256&quot;},</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-DSS-AES128-SHA256&q=
uot;, &quot;TLS-DHE-DSS-WITH-AES-128-CBC-SHA256&quot;},</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-DSS-AES128-SHA&quot;, &q=
uot;TLS-DHE-DSS-WITH-AES-128-CBC-SHA&quot;},</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {&quot;DHE-DSS-AES256-GCM-SHA384&quot;, &quot;=
TLS-DHE-DSS-WITH-AES-256-GCM-SHA384&quot;},</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {&quot;DHE-DSS-AES256-SHA256&quot;, &quot;TLS-D=
HE-DSS-WITH-AES-256-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {&quot;DHE-DSS-AES256-SHA&quot;, &quot;TLS-DHE-DSS-W=
ITH-AES-256-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {&quot;DHE-DSS-CAMELLIA128-SHA256&quot;, &quot;TLS-DHE-DSS-WITH=
-CAMELLIA-128-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {&quot;DHE-DSS-CAMELLIA128-SHA&quot;, &quot;TLS-DHE-DSS-WI=
TH-CAMELLIA-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {&quot;DHE-DSS-CAMELLIA256-SHA256&quot;, &quot;TLS-DHE-DSS-=
WITH-CAMELLIA-256-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {&quot;DHE-DSS-CAMELLIA256-SHA&quot;, &quot;TLS-DHE-DS=
S-WITH-CAMELLIA-256-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {&quot;DHE-DSS-SEED-SHA&quot;, &quot;TLS-DHE-DSS-WITH-S=
EED-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {&quot;DHE-RSA-AES128-GCM-SHA256&quot;, &quot;TLS-DHE-RSA-WITH-AES-128-=
GCM-SHA256&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {&quot;DHE-RSA-AES128-SHA256&quot;, &quot;TLS-DHE-RSA-WITH-AES-128-CBC-S=
HA256&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&=
quot;DHE-RSA-AES128-SHA&quot;, &quot;TLS-DHE-RSA-WITH-AES-128-CBC-SHA&quot;=
},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-RS=
A-AES256-GCM-SHA384&quot;, &quot;TLS-DHE-RSA-WITH-AES-256-GCM-SHA384&quot;}=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-RSA=
-AES256-SHA256&quot;, &quot;TLS-DHE-RSA-WITH-AES-256-CBC-SHA256&quot;},</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-RSA-AES2=
56-SHA&quot;, &quot;TLS-DHE-RSA-WITH-AES-256-CBC-SHA&quot;},</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-RSA-CAMELLIA128-SHA=
256&quot;, &quot;TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA256&quot;},</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-RSA-CAMELLIA12=
8-SHA&quot;, &quot;TLS-DHE-RSA-WITH-CAMELLIA-128-CBC-SHA&quot;},</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-RSA-CAMELLIA256=
-SHA256&quot;, &quot;TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SHA256&quot;},</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-RSA-CAMELL=
IA256-SHA&quot;, &quot;TLS-DHE-RSA-WITH-CAMELLIA-256-CBC-SHA&quot;},</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-RSA-CHACHA2=
0-POLY1305&quot;, &quot;TLS-DHE-RSA-WITH-CHACHA20-POLY1305-SHA256&quot;},</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;DHE-RSA-SE=
ED-SHA&quot;, &quot;TLS-DHE-RSA-WITH-SEED-CBC-SHA&quot;},</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {&quot;DH-RSA-SEED-SHA&quot;, &qu=
ot;TLS-DH-RSA-WITH-SEED-CBC-SHA&quot;},</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-AES128-GCM-SHA256&quot;, &quot;TL=
S-ECDH-ECDSA-WITH-AES-128-GCM-SHA256&quot;},</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-AES128-SHA256&quot;, &quot;T=
LS-ECDH-ECDSA-WITH-AES-128-CBC-SHA256&quot;},</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-AES128-SHA&quot;, &quot;TLS=
-ECDH-ECDSA-WITH-AES-128-CBC-SHA&quot;},</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-AES256-GCM-SHA384&quot;, &quot;T=
LS-ECDH-ECDSA-WITH-AES-256-GCM-SHA384&quot;},</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-AES256-SHA256&quot;, &quot;=
TLS-ECDH-ECDSA-WITH-AES-256-CBC-SHA256&quot;},</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-AES256-SHA384&quot;, &quot=
;TLS-ECDH-ECDSA-WITH-AES-256-CBC-SHA384&quot;},</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-AES256-SHA&quot;, &quot;T=
LS-ECDH-ECDSA-WITH-AES-256-CBC-SHA&quot;},</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-CAMELLIA128-SHA256&quot;, &quo=
t;TLS-ECDH-ECDSA-WITH-CAMELLIA-128-CBC-SHA256&quot;},</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-CAMELLIA128-SHA&quo=
t;, &quot;TLS-ECDH-ECDSA-WITH-CAMELLIA-128-CBC-SHA&quot;},</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-CAMELLIA256-SH=
A256&quot;, &quot;TLS-ECDH-ECDSA-WITH-CAMELLIA-256-CBC-SHA256&quot;},</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-CAM=
ELLIA256-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-CAMELLIA-256-CBC-SHA&quot;},<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDS=
A-DES-CBC3-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-3DES-EDE-CBC-SHA&quot;},</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-=
DES-CBC-SHA&quot;, &quot;TLS-ECDH-ECDSA-WITH-DES-CBC-SHA&quot;},</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH-ECDSA-RC4-SHA&=
quot;, &quot;TLS-ECDH-ECDSA-WITH-RC4-128-SHA&quot;},</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-ECDSA-AES128-GCM-SHA256&=
quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-128-GCM-SHA256&quot;},</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-ECDSA-AES128-SHA2=
56&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA256&quot;},</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-ECDSA-AES128-S=
HA384&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA384&quot;},</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-ECDSA-AES12=
8-SHA&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-128-CBC-SHA&quot;},</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-ECDSA-AES256-G=
CM-SHA384&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-256-GCM-SHA384&quot;},</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-ECDSA-A=
ES256-SHA256&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA256&quot;},</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-ECDS=
A-AES256-SHA384&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA384&quot;}=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-E=
CDSA-AES256-SHA&quot;, &quot;TLS-ECDHE-ECDSA-WITH-AES-256-CBC-SHA&quot;},</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-ECDS=
A-CAMELLIA128-SHA256&quot;, &quot;TLS-ECDHE-ECDSA-WITH-CAMELLIA-128-CBC-SHA=
256&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&qu=
ot;ECDHE-ECDSA-CAMELLIA128-SHA&quot;, &quot;TLS-ECDHE-ECDSA-WITH-CAMELLIA-1=
28-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {&quot;ECDHE-ECDSA-CAMELLIA256-SHA256&quot;, &quot;TLS-ECDHE-ECDSA-WITH-=
CAMELLIA-256-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {&quot;ECDHE-ECDSA-CAMELLIA256-SHA&quot;, &quot;TLS-ECDHE-E=
CDSA-WITH-CAMELLIA-256-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {&quot;ECDHE-ECDSA-CHACHA20-POLY1305&quot;, &quot;TL=
S-ECDHE-ECDSA-WITH-CHACHA20-POLY1305-SHA256&quot;},</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-ECDSA-DES-CBC3-SHA&quot;=
, &quot;TLS-ECDHE-ECDSA-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-ECDSA-DES-CBC-SHA&quot;,=
 &quot;TLS-ECDHE-ECDSA-WITH-DES-CBC-SHA&quot;},</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {&quot;ECDHE-ECDSA-RC4-SHA&quot;, &quot;TLS=
-ECDHE-ECDSA-WITH-RC4-128-SHA&quot;},</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {&quot;ECDHE-RSA-AES128-GCM-SHA256&quot;, &quot;TLS-E=
CDHE-RSA-WITH-AES-128-GCM-SHA256&quot;},</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {&quot;ECDHE-RSA-AES128-SHA256&quot;, &quot;TLS-EC=
DHE-RSA-WITH-AES-128-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {&quot;ECDHE-RSA-AES128-SHA384&quot;, &quot;TLS-ECD=
HE-RSA-WITH-AES-128-CBC-SHA384&quot;},</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {&quot;ECDHE-RSA-AES128-SHA&quot;, &quot;TLS-ECDHE-R=
SA-WITH-AES-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {&quot;ECDHE-RSA-AES256-GCM-SHA384&quot;, &quot;TLS-ECDHE-R=
SA-WITH-AES-256-GCM-SHA384&quot;},</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {&quot;ECDHE-RSA-AES256-SHA256&quot;, &quot;TLS-ECDHE-RS=
A-WITH-AES-256-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {&quot;ECDHE-RSA-AES256-SHA384&quot;, &quot;TLS-ECDHE-RSA=
-WITH-AES-256-CBC-SHA384&quot;},</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {&quot;ECDHE-RSA-AES256-SHA&quot;, &quot;TLS-ECDHE-RSA-WIT=
H-AES-256-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {&quot;ECDHE-RSA-CAMELLIA128-SHA256&quot;, &quot;TLS-ECDHE-RSA-WI=
TH-CAMELLIA-128-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {&quot;ECDHE-RSA-CAMELLIA128-SHA&quot;, &quot;TLS-ECDHE-=
RSA-WITH-CAMELLIA-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {&quot;ECDHE-RSA-CAMELLIA256-SHA256&quot;, &quot;TLS-=
ECDHE-RSA-WITH-CAMELLIA-256-CBC-SHA256&quot;},</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-CAMELLIA256-SHA&quot;, &quo=
t;TLS-ECDHE-RSA-WITH-CAMELLIA-256-CBC-SHA&quot;},</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-CHACHA20-POLY1305&quot;,=
 &quot;TLS-ECDHE-RSA-WITH-CHACHA20-POLY1305-SHA256&quot;},</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-DES-CBC3-SHA&qu=
ot;, &quot;TLS-ECDHE-RSA-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-DES-CBC-SHA&quot;, =
&quot;TLS-ECDHE-RSA-WITH-DES-CBC-SHA&quot;},</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {&quot;ECDHE-RSA-RC4-SHA&quot;, &quot;TLS-ECDH=
E-RSA-WITH-RC4-128-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {&quot;ECDH-RSA-AES128-GCM-SHA256&quot;, &quot;TLS-ECDH-RSA-=
WITH-AES-128-GCM-SHA256&quot;},</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {&quot;ECDH-RSA-AES128-SHA256&quot;, &quot;TLS-ECDH-RSA-WIT=
H-AES-128-CBC-SHA256&quot;},</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {&quot;ECDH-RSA-AES128-SHA384&quot;, &quot;TLS-ECDH-RSA-WITH-A=
ES-128-CBC-SHA384&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {&quot;ECDH-RSA-AES128-SHA&quot;, &quot;TLS-ECDH-RSA-WITH-AES-128=
-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {&quot;ECDH-RSA-AES256-GCM-SHA384&quot;, &quot;TLS-ECDH-RSA-WITH-AES-256-G=
CM-SHA384&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {&quot;ECDH-RSA-AES256-SHA256&quot;, &quot;TLS-ECDH-RSA-WITH-AES-256-CBC-=
SHA256&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
&quot;ECDH-RSA-AES256-SHA384&quot;, &quot;TLS-ECDH-RSA-WITH-AES-256-CBC-SHA=
384&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&qu=
ot;ECDH-RSA-AES256-SHA&quot;, &quot;TLS-ECDH-RSA-WITH-AES-256-CBC-SHA&quot;=
},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH-R=
SA-CAMELLIA128-SHA256&quot;, &quot;TLS-ECDH-RSA-WITH-CAMELLIA-128-CBC-SHA25=
6&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot=
;ECDH-RSA-CAMELLIA128-SHA&quot;, &quot;TLS-ECDH-RSA-WITH-CAMELLIA-128-CBC-S=
HA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quo=
t;ECDH-RSA-CAMELLIA256-SHA256&quot;, &quot;TLS-ECDH-RSA-WITH-CAMELLIA-256-C=
BC-SHA256&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {&quot;ECDH-RSA-CAMELLIA256-SHA&quot;, &quot;TLS-ECDH-RSA-WITH-CAMELLIA-2=
56-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {&quot;ECDH-RSA-DES-CBC3-SHA&quot;, &quot;TLS-ECDH-RSA-WITH-3DES-EDE-CBC=
-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&q=
uot;ECDH-RSA-DES-CBC-SHA&quot;, &quot;TLS-ECDH-RSA-WITH-DES-CBC-SHA&quot;},=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH-RSA=
-RC4-SHA&quot;, &quot;TLS-ECDH-RSA-WITH-RC4-128-SHA&quot;},</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {&quot;EDH-DSS-DES-CBC3-SHA&quo=
t;, &quot;TLS-DHE-DSS-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {&quot;EDH-DSS-DES-CBC-SHA&quot;, &qu=
ot;TLS-DHE-DSS-WITH-DES-CBC-SHA&quot;},</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {&quot;EDH-RSA-DES-CBC3-SHA&quot;, &quot;TLS-DHE-RS=
A-WITH-3DES-EDE-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {&quot;EDH-RSA-DES-CBC-SHA&quot;, &quot;TLS-DHE-RSA-WITH-DE=
S-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {&quot;EXP-DES-CBC-SHA&quot;, &quot;TLS-RSA-EXPORT-WITH-DES40-CBC-SHA&quo=
t;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;EXP-=
EDH-DSS-DES-CBC-SHA&quot;, &quot;TLS-DH-DSS-EXPORT-WITH-DES40-CBC-SHA&quot;=
},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;EXP-ED=
H-RSA-DES-CBC-SHA&quot;, &quot;TLS-DH-RSA-EXPORT-WITH-DES40-CBC-SHA&quot;},=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;EXP-RC2-=
CBC-MD5&quot;, &quot;TLS-RSA-EXPORT-WITH-RC2-CBC-40-MD5&quot;},</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;EXP-RC4-MD5&quot;, &=
quot;TLS-RSA-EXPORT-WITH-RC4-40-MD5&quot;},</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {&quot;NULL-MD5&quot;, &quot;TLS-RSA-WITH-NULL-=
MD5&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&qu=
ot;NULL-SHA256&quot;, &quot;TLS-RSA-WITH-NULL-SHA256&quot;},</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {&quot;NULL-SHA&quot;, &quot;T=
LS-RSA-WITH-NULL-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {&quot;PSK-3DES-EDE-CBC-SHA&quot;, &quot;TLS-PSK-WITH-3DES-EDE=
-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {&quot;PSK-AES128-CBC-SHA&quot;, &quot;TLS-PSK-WITH-AES-128-CBC-SHA&quot;}=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;PSK-AES=
256-CBC-SHA&quot;, &quot;TLS-PSK-WITH-AES-256-CBC-SHA&quot;},</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {&quot;PSK-RC4-SHA&quot;, &qu=
ot;TLS-PSK-WITH-RC4-128-SHA&quot;},</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {&quot;RC4-MD5&quot;, &quot;TLS-RSA-WITH-RC4-128-MD5&qu=
ot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;RC4=
-SHA&quot;, &quot;TLS-RSA-WITH-RC4-128-SHA&quot;},</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {&quot;SEED-SHA&quot;, &quot;TLS-RSA-WIT=
H-SEED-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {&quot;SRP-DSS-3DES-EDE-CBC-SHA&quot;, &quot;TLS-SRP-SHA-DSS-WITH-3D=
ES-EDE-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {&quot;SRP-DSS-AES-128-CBC-SHA&quot;, &quot;TLS-SRP-SHA-DSS-WITH-AES=
-128-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {&quot;SRP-DSS-AES-256-CBC-SHA&quot;, &quot;TLS-SRP-SHA-DSS-WITH-AES-2=
56-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {&quot;SRP-RSA-3DES-EDE-CBC-SHA&quot;, &quot;TLS-SRP-SHA-RSA-WITH-3DES-E=
DE-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {&quot;SRP-RSA-AES-128-CBC-SHA&quot;, &quot;TLS-SRP-SHA-RSA-WITH-AES-128=
-CBC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {&quot;SRP-RSA-AES-256-CBC-SHA&quot;, &quot;TLS-SRP-SHA-RSA-WITH-AES-256-C=
BC-SHA&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifde=
f ENABLE_CRYPTO_OPENSSL</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* OpenSSL-specific group names */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {&quot;DEFAULT&quot;, &quot;DEFAULT&quot;},</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;ALL&quot;, &q=
uot;ALL&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{&quot;HIGH&quot;, &quot;HIGH&quot;}, {&quot;!HIGH&quot;, &quot;!HIGH&quot;=
},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;MEDIUM=
&quot;, &quot;MEDIUM&quot;}, {&quot;!MEDIUM&quot;, &quot;!MEDIUM&quot;},</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;LOW&quot;, =
&quot;LOW&quot;}, {&quot;!LOW&quot;, &quot;!LOW&quot;},</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {&quot;ECDH&quot;, &quot;ECDH&quot;=
}, {&quot;!ECDH&quot;, &quot;!ECDH&quot;},</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {&quot;ECDSA&quot;, &quot;ECDSA&quot;}, {&quot;!=
ECDSA&quot;, &quot;!ECDSA&quot;},</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {&quot;EDH&quot;, &quot;EDH&quot;}, {&quot;!EDH&quot;, &q=
uot;!EDH&quot;},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {&quot;EXP&quot;, &quot;EXP&quot;}, {&quot;!EXP&quot;, &quot;!EXP&quot;},<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {&quot;RSA&quot;=
, &quot;RSA&quot;}, {&quot;!RSA&quot;, &quot;!RSA&quot;},</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {&quot;kRSA&quot;, &quot;kRSA&quo=
t;}, {&quot;!kRSA&quot;, &quot;!kRSA&quot;},</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {&quot;SRP&quot;, &quot;SRP&quot;}, {&quot;!SR=
P&quot;, &quot;!SRP&quot;},</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
NULL, NULL}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+const tls_cipher_name_pair *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+tls_get_cipher_name_pair(const char=
 *cipher_name, size_t len)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const t=
ls_cipher_name_pair *pair =3D tls_cipher_name_translation_table;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    while (pair-&gt;openssl_name !=3D NULL)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if ((strlen(pair-&gt;openssl_na=
me) =3D=3D len &amp;&amp; 0 =3D=3D memcmp(cipher_name, pair-&gt;openssl_nam=
e, len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 || (strlen(pair-&gt;iana_name) =3D=3D len &amp;&amp; 0 =3D=3D memcmp(ciphe=
r_name, pair-&gt;iana_name, len)))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            return pair;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        pair++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* No entry found, return NULL */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
get_num_elements(const char *string, char delimiter)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int string_len =3D strlen(string);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ASSERT(0 !=3D string_len);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    int element_count =3D 1;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* Get number of ciphers */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; string_len; i++)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (string[i] =3D=3D delim=
iter)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            element_coun=
t++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return element_count;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/ssl_util.=
h b/src/openvpn/ssl_util.h</span><br><span>index 4c46f88..b3eaf9f 100644</s=
pan><br><span>--- a/src/openvpn/ssl_util.h</span><br><span>+++ b/src/openvp=
n/ssl_util.h</span><br><span>@@ -66,4 +66,27 @@</span><br><span>  */</span>=
<br><span> const char *options_string_compat_lzo(const char *options, struc=
t gc_arena *gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Get a tls_cip=
her_name_pair containing OpenSSL and IANA names for supplied TLS cipher nam=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param cipher_name   Can be eith=
er OpenSSL or IANA cipher name</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @return              tls_cipher_name_pair* if found, NULL oth=
erwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+typedef struct { const char *=
openssl_name; const char *iana_name; } tls_cipher_name_pair;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+const tls_cipher_name_pair *tls_ge=
t_cipher_name_pair(const char *cipher_name, size_t len);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Returns the occurrences of &#39;delimiter&#39; in a string +1</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * This is typically used to=
 find out the number elements in a</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * cipher string or similar that is separated by : like</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *   X25519:secp256r1:X448:secp512r1:secp=
384r1:brainpoolP384r1</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param strin=
g        the string to work on</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param delimiter     the delimiter to count, typically &#39;:=
&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return    =
          occrrences of delimiter + 1</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_num_elemen=
ts(const char *string, char delimiter);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif /* ifndef SSL_UTIL_H_ */</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/470?usp=3Demail">=
change 470</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/470?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I605394d4f3872a168d05bbbe52d=
90f6d48935865 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 470 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--L9w3Q3vnYGU=--

