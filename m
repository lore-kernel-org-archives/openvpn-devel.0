From: Steffan Karger <steffan@...1856...>
Date: Sun, 26 Jul 2015 13:27:19 +0200
Message-Id: <1437910039-30101-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] reintroduce md5_digest wrapper struct to
	fix gcc warnings
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

I was wrong to assume that adding the const qualifier to the pointer-to-
fixed-size-array contruction used in options_hash_changed_or_zero() was
allowed.  GCC actually warns about this, but I was using clang and clang
seems to be fine with the contruction.  To make GCC happy too, reintroduce
the md5_digest wrapped struct, and use that when passing around the digest.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.h  |  5 +++++
 src/openvpn/init.c    | 12 ++++++------
 src/openvpn/openvpn.h |  4 ++--
 src/openvpn/push.c    |  2 +-
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 504896d..b32a900 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -108,6 +108,11 @@
 #include "packet_id.h"
 #include "mtu.h"
 
+/** Wrapper struct to pass around MD5 digests */
+struct md5_digest {
+  uint8_t digest[MD5_DIGEST_LENGTH];
+};
+
 /*
  * Defines a key type and key length for both cipher and HMAC.
  */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 98cd288..b7c153b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1616,11 +1616,12 @@ tun_abort()
  * equal, or either one is all-zeroes.
  */
 static bool
-options_hash_changed_or_zero(const uint8_t (*a)[MD5_DIGEST_LENGTH],
-    const uint8_t (*b)[MD5_DIGEST_LENGTH])
+options_hash_changed_or_zero(const struct md5_digest *a,
+    const struct md5_digest *b)
 {
-  const uint8_t zero[MD5_DIGEST_LENGTH] = {0};
-  return memcmp (*a, *b, MD5_DIGEST_LENGTH) || memcmp (*a, zero, MD5_DIGEST_LENGTH);
+  const struct md5_digest zero = {{0}};
+  return memcmp (a, b, sizeof(struct md5_digest)) ||
+      memcmp (a, &zero, sizeof(struct md5_digest));
 }
 #endif /* P2MP */
 
@@ -1664,8 +1665,7 @@ do_up (struct context *c, bool pulled_options, unsigned int option_types_found)
       if (c->c2.did_open_tun)
 	{
 #if P2MP
-	  memcpy(c->c1.pulled_options_digest_save, c->c2.pulled_options_digest,
-	      sizeof(c->c1.pulled_options_digest_save));
+	  c->c1.pulled_options_digest_save = c->c2.pulled_options_digest;
 #endif
 
 	  /* if --route-delay was specified, start timer */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index ef7ca1d..1c2a80b 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -199,7 +199,7 @@ struct context_1
 #endif
 
   /* if client mode, hash of option strings we pulled from server */
-  uint8_t pulled_options_digest_save[MD5_DIGEST_LENGTH];
+  struct md5_digest pulled_options_digest_save;
                                 /**< Hash of option strings received from the
                                  *   remote OpenVPN server.  Only used in
                                  *   client-mode. */
@@ -465,7 +465,7 @@ struct context_2
   /* hash of pulled options, so we can compare when options change */
   bool pulled_options_md5_init_done;
   md_ctx_t pulled_options_state;
-  uint8_t pulled_options_digest[MD5_DIGEST_LENGTH];
+  struct md5_digest pulled_options_digest;
 
   struct event_timeout server_poll_interval;
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 46a44b1..6e92392 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -481,7 +481,7 @@ process_incoming_push_msg (struct context *c,
 	      case 0:
 	      case 1:
 		md_ctx_update (&c->c2.pulled_options_state, BPTR(&buf_orig), BLEN(&buf_orig));
-		md_ctx_final (&c->c2.pulled_options_state, c->c2.pulled_options_digest);
+		md_ctx_final (&c->c2.pulled_options_state, c->c2.pulled_options_digest.digest);
 		md_ctx_cleanup (&c->c2.pulled_options_state);
 	        c->c2.pulled_options_md5_init_done = false;
 		ret = PUSH_MSG_REPLY;
-- 
2.1.4


