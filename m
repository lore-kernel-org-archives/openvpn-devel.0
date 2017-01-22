From: Steffan Karger <steffan@...1856...>
Date: Sun, 22 Jan 2017 17:04:41 +0100
Message-Id: <1485101081-9784-1-git-send-email-steffan@...1856...>
In-Reply-To: <6469df40-4b8c-3665-c944-fb873bb2d525@...1856...>
References: <6469df40-4b8c-3665-c944-fb873bb2d525@...1856...>
Subject: [Openvpn-devel] [PATCH v2] Use SHA256 for the internal digest,
	instead of MD5
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

Our internal options digest uses MD5 hashes to store the state, instead of
storing the full options string.  There's nothing wrong with that, but it
would still be better to use SHA256 because:
 * That makes it easier to make OpenVPN "FIPS-compliant" (forbids MD5)
 * We don't have to explain anymore that MD5 is fine too

The slightly less bytes for the digest (16 instead of 32) and operations
per connection setup are not worth sticking to MD5.

Note that might SHA256 not be available in de crypto lib, OpenVPN will
refuse to start and shout "Message hash algorithm 'SHA256' not found".

Signed-off-by: Steffan Karger <steffan@...1856...>
---
v2: fix rebase error that erroneously reverted commit ec4dff3b

 src/openvpn/crypto.h         |  6 +++---
 src/openvpn/crypto_mbedtls.h |  1 +
 src/openvpn/crypto_openssl.h |  1 +
 src/openvpn/init.c           | 10 +++++-----
 src/openvpn/openvpn.h        |  6 +++---
 src/openvpn/push.c           |  8 ++++----
 6 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 42a46d9..afd6fe5 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -131,9 +131,9 @@
 #include "packet_id.h"
 #include "mtu.h"
 
-/** Wrapper struct to pass around MD5 digests */
-struct md5_digest {
-    uint8_t digest[MD5_DIGEST_LENGTH];
+/** Wrapper struct to pass around SHA256 digests */
+struct sha256_digest {
+    uint8_t digest[SHA256_DIGEST_LENGTH];
 };
 
 /*
diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 525b256..da2db16 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -73,6 +73,7 @@ typedef mbedtls_md_context_t hmac_ctx_t;
 #define MD4_DIGEST_LENGTH       16
 #define MD5_DIGEST_LENGTH       16
 #define SHA_DIGEST_LENGTH       20
+#define SHA256_DIGEST_LENGTH    32
 #define DES_KEY_LENGTH 8
 
 /**
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 56ec6e1..f8ddbc8 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -33,6 +33,7 @@
 #include <openssl/evp.h>
 #include <openssl/hmac.h>
 #include <openssl/md5.h>
+#include <openssl/sha.h>
 
 /** Generic cipher key type %context. */
 typedef EVP_CIPHER cipher_kt_t;
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f2e75c8..756bf36 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1919,12 +1919,12 @@ tun_abort()
  * equal, or either one is all-zeroes.
  */
 static bool
-options_hash_changed_or_zero(const struct md5_digest *a,
-                             const struct md5_digest *b)
+options_hash_changed_or_zero(const struct sha256_digest *a,
+                             const struct sha256_digest *b)
 {
-    const struct md5_digest zero = {{0}};
-    return memcmp(a, b, sizeof(struct md5_digest))
-           || !memcmp(a, &zero, sizeof(struct md5_digest));
+    const struct sha256_digest zero = {{0}};
+    return memcmp(a, b, sizeof(struct sha256_digest))
+           || !memcmp(a, &zero, sizeof(struct sha256_digest));
 }
 #endif /* P2MP */
 
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 37edec4..893296e 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -202,7 +202,7 @@ struct context_1
 #endif
 
     /* if client mode, hash of option strings we pulled from server */
-    struct md5_digest pulled_options_digest_save;
+    struct sha256_digest pulled_options_digest_save;
     /**< Hash of option strings received from the
      *   remote OpenVPN server.  Only used in
      *   client-mode. */
@@ -471,9 +471,9 @@ struct context_2
     bool did_pre_pull_restore;
 
     /* hash of pulled options, so we can compare when options change */
-    bool pulled_options_md5_init_done;
+    bool pulled_options_digest_init_done;
     md_ctx_t pulled_options_state;
-    struct md5_digest pulled_options_digest;
+    struct sha256_digest pulled_options_digest;
 
     struct event_timeout scheduled_exit;
     int scheduled_exit_signal;
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index c9c04a6..8c3104e 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -720,10 +720,10 @@ process_incoming_push_msg(struct context *c,
         if (ch == ',')
         {
             struct buffer buf_orig = buf;
-            if (!c->c2.pulled_options_md5_init_done)
+            if (!c->c2.pulled_options_digest_init_done)
             {
-                md_ctx_init(&c->c2.pulled_options_state, md_kt_get("MD5"));
-                c->c2.pulled_options_md5_init_done = true;
+                md_ctx_init(&c->c2.pulled_options_state, md_kt_get("SHA256"));
+                c->c2.pulled_options_digest_init_done = true;
             }
             if (!c->c2.did_pre_pull_restore)
             {
@@ -744,7 +744,7 @@ process_incoming_push_msg(struct context *c,
                     case 1:
                         md_ctx_final(&c->c2.pulled_options_state, c->c2.pulled_options_digest.digest);
                         md_ctx_cleanup(&c->c2.pulled_options_state);
-                        c->c2.pulled_options_md5_init_done = false;
+                        c->c2.pulled_options_digest_init_done = false;
                         ret = PUSH_MSG_REPLY;
                         break;
 
-- 
2.7.4


