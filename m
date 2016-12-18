From: Steffan Karger <steffan@...1856...>
Date: Sun, 18 Dec 2016 17:40:55 +0100
Message-Id: <1482079255-15159-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Use SHA256 for the internal digest,
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

Signed-off-by: Steffan Karger <steffan@...1856...>
---

This patch is meant for the master branch only.

 src/openvpn/crypto.h         |  6 +++---
 src/openvpn/crypto_mbedtls.h |  1 +
 src/openvpn/crypto_openssl.h |  1 +
 src/openvpn/init.c           | 10 +++++-----
 src/openvpn/openvpn.h        |  6 +++---
 src/openvpn/push.c           | 23 ++++++++---------------
 6 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 574a625..a7ed0bc 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -132,9 +132,9 @@
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
index 16f9007..85072f8 100644
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
index 6cf009e..bcc190c 100644
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
index f6a5ac7..69c5439 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1903,12 +1903,12 @@ tun_abort()
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
index 36c53e8..e0acdfe 100644
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
index b6e12e1..a1733b0 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -677,23 +677,17 @@ process_incoming_push_request(struct context *c)
 #endif /* if P2MP_SERVER */
 
 static void
-push_update_digest(md_ctx_t *ctx, struct buffer *buf, const struct options *opt)
+push_update_digest(md_ctx_t *ctx, struct buffer *buf)
 {
     char line[OPTION_PARM_SIZE];
     while (buf_parse(buf, ',', line, sizeof(line)))
     {
         /* peer-id might change on restart and this should not trigger reopening tun */
-        if (strprefix(line, "peer-id "))
+        if (strstr(line, "peer-id ") != line)
         {
-            continue;
-        }
-        /* tun reopen only needed if cipher change can change tun MTU */
-        if (strprefix(line, "cipher ") && !opt->ce.tun_mtu_defined)
-        {
-            continue;
+            md_ctx_update(ctx, (const uint8_t *) line, strlen(line));
         }
     }
-    md_ctx_update(ctx, (const uint8_t *) line, strlen(line)+1);
 }
 
 int
@@ -720,10 +714,10 @@ process_incoming_push_msg(struct context *c,
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
@@ -736,15 +730,14 @@ process_incoming_push_msg(struct context *c,
                                    option_types_found,
                                    c->c2.es))
             {
-                push_update_digest(&c->c2.pulled_options_state, &buf_orig,
-                                   &c->options);
+                push_update_digest(&c->c2.pulled_options_state, &buf_orig);
                 switch (c->options.push_continuation)
                 {
                     case 0:
                     case 1:
                         md_ctx_final(&c->c2.pulled_options_state, c->c2.pulled_options_digest.digest);
                         md_ctx_cleanup(&c->c2.pulled_options_state);
-                        c->c2.pulled_options_md5_init_done = false;
+                        c->c2.pulled_options_digest_init_done = false;
                         ret = PUSH_MSG_REPLY;
                         break;
 
-- 
2.7.4


