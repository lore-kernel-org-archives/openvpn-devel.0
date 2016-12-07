From: Steffan Karger <steffan@...1856...>
Date: Wed,  7 Dec 2016 19:01:24 +0100
Message-Id: <1481133684-5325-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix (and cleanup) crypto flags in
	combination with NCP
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

tls_session_update_crypto_params() did not properly set crypto_flags_or,
but instead set crypto_flags_and twice if a OFB/CFB mode was selected.

Also, the crypto flags in ks->crypto_options.flags were set before
tls_session_update_crypto_params() was called, causing those to not be
adjusted.  To fix this, set the crypto flags in
tls_session_generate_data_channel_keys() instead of key_state_init().

While touching that code, remove the to _or and _and variables, which are
not needed at all.

Finally, refuse to accept --no-iv is NCP is enabled.  (we might otherwise
negotiate invalid combinations and ASSERT out later, and using --no-iv is
a bad idea anyway.)

This fixes trac #784.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/init.c       | 4 ++--
 src/openvpn/options.c    | 4 ++++
 src/openvpn/ssl.c        | 8 +++-----
 src/openvpn/ssl_common.h | 2 --
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 18a0d70..7e4f40c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2334,9 +2334,9 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   if (options->mute_replay_warnings)
     to.crypto_flags |= CO_MUTE_REPLAY_WARNINGS;
 
-  to.crypto_flags_and = ~(CO_PACKET_ID_LONG_FORM);
+  to.crypto_flags &= ~(CO_PACKET_ID_LONG_FORM);
   if (packet_id_long_form)
-    to.crypto_flags_or = CO_PACKET_ID_LONG_FORM;
+    to.crypto_flags |= CO_PACKET_ID_LONG_FORM;
 
   to.ssl_ctx = c->c1.ks.ssl_ctx;
   to.key_type = c->c1.ks.key_type;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b97ac7b..4c4b160 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2234,6 +2234,10 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
     {
       msg (M_USAGE, "NCP cipher list contains unsupported ciphers.");
     }
+  if (options->ncp_enabled && !options->use_iv)
+    {
+      msg (M_USAGE, "--no-iv not allowed when NCP is enabled.");
+    }
 
   /*
    * Check consistency of replay options
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 91c7787..f42c1ed 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -881,9 +881,6 @@ key_state_init (struct tls_session *session, struct key_state *ks)
     }
 
   ks->crypto_options.pid_persist = NULL;
-  ks->crypto_options.flags = session->opt->crypto_flags;
-  ks->crypto_options.flags &= session->opt->crypto_flags_and;
-  ks->crypto_options.flags |= session->opt->crypto_flags_or;
 
 #ifdef MANAGEMENT_DEF_AUTH
   ks->mda_key_id = session->opt->mda_context->mda_key_id_counter++;
@@ -1821,6 +1818,7 @@ tls_session_generate_data_channel_keys(struct tls_session *session)
 
   ASSERT (ks->authenticated);
 
+  ks->crypto_options.flags = session->opt->crypto_flags;
   if (!generate_key_expansion (&ks->crypto_options.key_ctx_bi,
       &session->opt->key_type, ks->key_src, client_sid, server_sid,
       session->opt->server))
@@ -1855,9 +1853,9 @@ tls_session_update_crypto_params(struct tls_session *session,
       options->authname, options->keysize, true, true);
 
   bool packet_id_long_form = cipher_kt_mode_ofb_cfb (session->opt->key_type.cipher);
-  session->opt->crypto_flags_and &= ~(CO_PACKET_ID_LONG_FORM);
+  session->opt->crypto_flags &= ~(CO_PACKET_ID_LONG_FORM);
   if (packet_id_long_form)
-    session->opt->crypto_flags_and = CO_PACKET_ID_LONG_FORM;
+    session->opt->crypto_flags |= CO_PACKET_ID_LONG_FORM;
 
   /* Update frame parameters: undo worst-case overhead, add actual overhead */
   frame_add_to_extra_frame (frame, -(crypto_max_overhead()));
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 7938f41..8164bbc 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -279,8 +279,6 @@ struct tls_options
 
   /* struct crypto_option flags */
   unsigned int crypto_flags;
-  unsigned int crypto_flags_and;
-  unsigned int crypto_flags_or;
 
   int replay_window;                   /* --replay-window parm */
   int replay_time;                     /* --replay-window parm */
-- 
2.7.4


