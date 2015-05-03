From: Steffan Karger <steffan@...1856...>
Date: Sun,  3 May 2015 17:07:11 +0200
Message-Id: <1430665631-4022-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] cleanup: remove md5 helper functions
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

The MD5 wrapper functions were used in just a few places, which imho is
not worth the extra code.  Instead of using these wrappers, just use
the generic md_ctx_*() functions directly.

The md5sum() function was only used for logging information that was not
useful to a user; first the full options string would be printed, and
later just the hash.  That hash is less informative than the full
string, so why print it at all?

Finally, also removed save_pulled_options_digest().  The two times it
was called, it executed either one of the possible branches in the
function, where one of these needed a comment to explain what passing
NULL as newdigest is supposed to do...

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c   | 58 --------------------------------------------------
 src/openvpn/crypto.h   | 20 -----------------
 src/openvpn/errlevel.h |  1 -
 src/openvpn/init.c     | 56 ++++++++++++++++++++++--------------------------
 src/openvpn/openvpn.h  |  6 +++---
 src/openvpn/push.c     |  9 ++++----
 6 files changed, 33 insertions(+), 117 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index c1b9df3..588d9f0 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1335,62 +1335,4 @@ get_random()
   return l;
 }
 
-/*
- * md5 functions
- */
-
-const char *
-md5sum (uint8_t *buf, int len, int n_print_chars, struct gc_arena *gc)
-{
-  uint8_t digest[MD5_DIGEST_LENGTH];
-  const md_kt_t *md5_kt = md_kt_get("MD5");
-
-  md_full(md5_kt, buf, len, digest);
-
-  return format_hex (digest, MD5_DIGEST_LENGTH, n_print_chars, gc);
-}
-
-void
-md5_state_init (struct md5_state *s)
-{
-  const md_kt_t *md5_kt = md_kt_get("MD5");
-
-  md_ctx_init(&s->ctx, md5_kt);
-}
-
-void
-md5_state_update (struct md5_state *s, void *data, size_t len)
-{
-  md_ctx_update(&s->ctx, data, len);
-}
-
-void
-md5_state_final (struct md5_state *s, struct md5_digest *out)
-{
-  md_ctx_final(&s->ctx, out->digest);
-  md_ctx_cleanup(&s->ctx);
-}
-
-void
-md5_digest_clear (struct md5_digest *digest)
-{
-  CLEAR (*digest);
-}
-
-bool
-md5_digest_defined (const struct md5_digest *digest)
-{
-  int i;
-  for (i = 0; i < MD5_DIGEST_LENGTH; ++i)
-    if (digest->digest[i])
-      return true;
-  return false;
-}
-
-bool
-md5_digest_equal (const struct md5_digest *d1, const struct md5_digest *d2)
-{
-  return memcmp(d1->digest, d2->digest, MD5_DIGEST_LENGTH) == 0;
-}
-
 #endif /* ENABLE_CRYPTO */
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 82158f9..504896d 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -421,26 +421,6 @@ void get_tls_handshake_key (const struct key_type *key_type,
 			    const unsigned int flags);
 
 /*
- * md5 functions
- */
-
-struct md5_state {
-  md_ctx_t ctx;
-};
-
-struct md5_digest {
-  uint8_t digest [MD5_DIGEST_LENGTH];
-};
-
-const char *md5sum(uint8_t *buf, int len, int n_print_chars, struct gc_arena *gc);
-void md5_state_init (struct md5_state *s);
-void md5_state_update (struct md5_state *s, void *data, size_t len);
-void md5_state_final (struct md5_state *s, struct md5_digest *out);
-void md5_digest_clear (struct md5_digest *digest);
-bool md5_digest_defined (const struct md5_digest *digest);
-bool md5_digest_equal (const struct md5_digest *d1, const struct md5_digest *d2);
-
-/*
  * Inline functions
  */
 
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index 3ee4ebc..da600ab 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -105,7 +105,6 @@
 #define D_X509_ATTR          LOGLEV(4, 59, 0)        /* show x509-track attributes on connection */
 #define D_INIT_MEDIUM        LOGLEV(4, 60, 0)        /* show medium frequency init messages */
 #define D_MTU_INFO           LOGLEV(4, 61, 0)        /* show terse MTU info */
-#define D_SHOW_OCC_HASH      LOGLEV(4, 62, 0)        /* show MD5 hash of option compatibility string */
 #define D_PID_DEBUG_LOW      LOGLEV(4, 63, 0)        /* show low-freq packet-id debugging info */
 #define D_PID_DEBUG_MEDIUM   LOGLEV(4, 64, 0)        /* show medium-freq packet-id debugging info */
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 42cb3e2..1ab5d9b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1330,21 +1330,6 @@ do_route (const struct options *options,
 }
 
 /*
- * Save current pulled options string in the c1 context store, so we can
- * compare against it after possible future restarts.
- */
-#if P2MP
-static void
-save_pulled_options_digest (struct context *c, const struct md5_digest *newdigest)
-{
-  if (newdigest)
-    c->c1.pulled_options_digest_save = *newdigest;
-  else
-    md5_digest_clear (&c->c1.pulled_options_digest_save);
-}
-#endif
-
-/*
  * initialize tun/tap device object
  */
 static void
@@ -1519,7 +1504,7 @@ do_close_tun_simple (struct context *c)
   c->c1.tuntap = NULL;
   c->c1.tuntap_owned = false;
 #if P2MP
-  save_pulled_options_digest (c, NULL); /* delete C1-saved pulled_options_digest */
+  CLEAR (c->c1.pulled_options_digest_save);
 #endif
 }
 
@@ -1631,6 +1616,20 @@ tun_abort()
  * Handle delayed tun/tap interface bringup due to --up-delay or --pull
  */
 
+#if P2MP
+/**
+ * Helper for do_up().  Take two option hashes and return true if they are not
+ * equal, or either one is all-zeroes.
+ */
+static bool
+options_hash_changed_or_zero(const uint8_t (*a)[MD5_DIGEST_LENGTH],
+    const uint8_t (*b)[MD5_DIGEST_LENGTH])
+{
+  const uint8_t zero[MD5_DIGEST_LENGTH] = {0};
+  return memcmp (*a, *b, MD5_DIGEST_LENGTH) || memcmp (*a, zero, MD5_DIGEST_LENGTH);
+}
+#endif /* P2MP */
+
 void
 do_up (struct context *c, bool pulled_options, unsigned int option_types_found)
 {
@@ -1655,8 +1654,8 @@ do_up (struct context *c, bool pulled_options, unsigned int option_types_found)
 	  if (!c->c2.did_open_tun
 	      && PULL_DEFINED (&c->options)
 	      && c->c1.tuntap
-	      && (!md5_digest_defined (&c->c1.pulled_options_digest_save) || !md5_digest_defined (&c->c2.pulled_options_digest)
-		  || !md5_digest_equal (&c->c1.pulled_options_digest_save, &c->c2.pulled_options_digest)))
+	      && options_hash_changed_or_zero (&c->c1.pulled_options_digest_save,
+		  &c->c2.pulled_options_digest))
 	    {
 	      /* if so, close tun, delete routes, then reinitialize tun and add routes */
 	      msg (M_INFO, "NOTE: Pulled options changed on restart, will need to close and reopen TUN/TAP device.");
@@ -1671,7 +1670,8 @@ do_up (struct context *c, bool pulled_options, unsigned int option_types_found)
       if (c->c2.did_open_tun)
 	{
 #if P2MP
-	  save_pulled_options_digest (c, &c->c2.pulled_options_digest);
+	  memcpy(c->c1.pulled_options_digest_save, c->c2.pulled_options_digest,
+	      sizeof(c->c1.pulled_options_digest_save));
 #endif
 
 	  /* if --route-delay was specified, start timer */
@@ -2729,20 +2729,14 @@ do_compute_occ_strings (struct context *c)
   c->c2.options_string_remote =
     options_string (&c->options, &c->c2.frame, c->c1.tuntap, true, &gc);
 
-  msg (D_SHOW_OCC, "Local Options String: '%s'", c->c2.options_string_local);
-  msg (D_SHOW_OCC, "Expected Remote Options String: '%s'",
-       c->c2.options_string_remote);
+  msg (D_SHOW_OCC, "Local Options String (VER=%s): '%s'",
+      options_string_version (c->c2.options_string_local, &gc),
+      c->c2.options_string_local);
+  msg (D_SHOW_OCC, "Expected Remote Options String (VER=%s): '%s'",
+      options_string_version (c->c2.options_string_remote, &gc),
+      c->c2.options_string_remote);
 
 #ifdef ENABLE_CRYPTO
-  msg (D_SHOW_OCC_HASH, "Local Options hash (VER=%s): '%s'",
-       options_string_version (c->c2.options_string_local, &gc),
-       md5sum ((uint8_t*)c->c2.options_string_local,
-	       strlen (c->c2.options_string_local), 9, &gc));
-  msg (D_SHOW_OCC_HASH, "Expected Remote Options hash (VER=%s): '%s'",
-       options_string_version (c->c2.options_string_remote, &gc),
-       md5sum ((uint8_t*)c->c2.options_string_remote,
-	       strlen (c->c2.options_string_remote), 9, &gc));
-
   if (c->c2.tls_multi)
     tls_multi_init_set_options (c->c2.tls_multi,
 				c->c2.options_string_local,
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index fb532a2..9ab50b8 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -202,7 +202,7 @@ struct context_1
 #endif
 
   /* if client mode, hash of option strings we pulled from server */
-  struct md5_digest pulled_options_digest_save;
+  uint8_t pulled_options_digest_save[MD5_DIGEST_LENGTH];
                                 /**< Hash of option strings received from the
                                  *   remote OpenVPN server.  Only used in
                                  *   client-mode. */
@@ -467,8 +467,8 @@ struct context_2
 
   /* hash of pulled options, so we can compare when options change */
   bool pulled_options_md5_init_done;
-  struct md5_state pulled_options_state;
-  struct md5_digest pulled_options_digest;
+  md_ctx_t pulled_options_state;
+  uint8_t pulled_options_digest[MD5_DIGEST_LENGTH];
 
   struct event_timeout server_poll_interval;
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 932df5c..c99a097 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -465,7 +465,7 @@ process_incoming_push_msg (struct context *c,
 	  struct buffer buf_orig = buf;
 	  if (!c->c2.pulled_options_md5_init_done)
 	    {
-	      md5_state_init (&c->c2.pulled_options_state);
+	      md_ctx_init(&c->c2.pulled_options_state, md_kt_get("MD5"));
 	      c->c2.pulled_options_md5_init_done = true;
 	    }
 	  if (!c->c2.did_pre_pull_restore)
@@ -482,13 +482,14 @@ process_incoming_push_msg (struct context *c,
 	      {
 	      case 0:
 	      case 1:
-		md5_state_update (&c->c2.pulled_options_state, BPTR(&buf_orig), BLEN(&buf_orig));
-		md5_state_final (&c->c2.pulled_options_state, &c->c2.pulled_options_digest);
+		md_ctx_update (&c->c2.pulled_options_state, BPTR(&buf_orig), BLEN(&buf_orig));
+		md_ctx_final (&c->c2.pulled_options_state, c->c2.pulled_options_digest);
+		md_ctx_cleanup (&c->c2.pulled_options_state);
 	        c->c2.pulled_options_md5_init_done = false;
 		ret = PUSH_MSG_REPLY;
 		break;
 	      case 2:
-		md5_state_update (&c->c2.pulled_options_state, BPTR(&buf_orig), BLEN(&buf_orig));
+		md_ctx_update (&c->c2.pulled_options_state, BPTR(&buf_orig), BLEN(&buf_orig));
 		ret = PUSH_MSG_CONTINUATION;
 		break;
 	      }
-- 
2.1.4


