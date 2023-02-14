From: Arne Schwabe <arne@...1227...>
Date: Tue, 14 Feb 2023 12:20:44 +0100
Message-Id: <20230214112044.1021962-1-arne@...1227...>
In-Reply-To: <20230210142712.572303-8-arne@...1227...>
References: <20230210142712.572303-8-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 4/4] Reduce initialisation spam from verb
 <= 3 and print summary instead
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

The messages about cipher initialisation are currently very noisy, especially if tls-auth/tls-crypt is
in use.

Typically messages like this is display for AES-256-CBC with SHA256:

   Outgoing Data Channel: Cipher 'AES-256-CBC' initialized with 256 bit key
   Outgoing Data Channel: Using 256 bit message hash 'SHA256' for HMAC authentication
   Incoming Data Channel: Cipher 'AES-256-CBC' initialized with 256 bit key
   Incoming Data Channel: Using 256 bit message hash 'SHA256' for HMAC authentication

in addition to the tls-crypt/tls-auth messages that has the amount of messages.

These message are not that helpful. The only meaningful information is better suited in
compat messages. This commit moves the spammy messages to verb 4 and consistently prints out
the cipher/auth used in the data channel instead on verb 2:

   Data Channel: cipher 'AES-256-CBC' auth 'SHA256'

This patches also summarises other aspects of the imported options for VPN connection and
prints them (even if not coming from pulled options):

    Data Channel: cipher 'AES-256-GCM'
    Timers: ping 8, ping-restart 40
    Protocol options: explicit-exit-notify 1, protocol-flags tls-ekm

And move the OPTIONS IMPORT: xx modified that are included in the new messages to
D_PUSH_DEBUG (verb 7) since they do not add any useful information anymore.

Patch v2: also compile with compression disabled

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto.c   |   4 +-
 src/openvpn/errlevel.h |   1 +
 src/openvpn/init.c     | 145 +++++++++++++++++++++++++++++++++++++++--
 src/openvpn/occ.h      |  16 +++++
 src/openvpn/sig.c      |  15 -----
 src/openvpn/ssl.c      |   5 --
 src/openvpn/ssl_ncp.c  |   2 +-
 7 files changed, 161 insertions(+), 27 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 073f47e47..5e1c495b0 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -835,7 +835,7 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,
         cipher_ctx_init(ctx->cipher, key->cipher, kt->cipher, enc);
 
         const char *ciphername = cipher_kt_name(kt->cipher);
-        msg(D_HANDSHAKE, "%s: Cipher '%s' initialized with %d bit key",
+        msg(D_CIPHER_INIT, "%s: Cipher '%s' initialized with %d bit key",
             prefix, ciphername, cipher_kt_key_size(kt->cipher) * 8);
 
         dmsg(D_SHOW_KEYS, "%s: CIPHER KEY: %s", prefix,
@@ -850,7 +850,7 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,
         ctx->hmac = hmac_ctx_new();
         hmac_ctx_init(ctx->hmac, key->hmac, kt->digest);
 
-        msg(D_HANDSHAKE,
+        msg(D_CIPHER_INIT,
             "%s: Using %d bit message hash '%s' for HMAC authentication",
             prefix, md_kt_size(kt->digest) * 8, md_kt_name(kt->digest));
 
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index c69ea91d6..4699d1ac2 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -105,6 +105,7 @@
 #define D_MTU_INFO           LOGLEV(4, 61, 0)        /* show terse MTU info */
 #define D_PID_DEBUG_LOW      LOGLEV(4, 63, 0)        /* show low-freq packet-id debugging info */
 #define D_PID_DEBUG_MEDIUM   LOGLEV(4, 64, 0)        /* show medium-freq packet-id debugging info */
+#define D_CIPHER_INIT        LOGLEV(4, 65, 0)        /* show messages about cipher init */
 
 #define D_LOG_RW             LOGLEV(5, 0,  0)        /* Print 'R' or 'W' to stdout for read/write */
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b500d3543..a2bf9548b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2209,6 +2209,141 @@ p2p_set_dco_keepalive(struct context *c)
     }
     return true;
 }
+
+/**
+ * Helper function for tls_print_deferred_options_results
+ * Adds the ", " delimitor if there already some data in the
+ * buffer.
+ */
+static void
+add_delim_if_non_empty(struct buffer *buf, const char *header)
+{
+    if (buf_len(buf) > strlen(header))
+    {
+        buf_printf(buf, ", ");
+    }
+}
+
+
+/**
+ * Prints the results of options imported for the data channel
+ * @param o
+ */
+static void
+tls_print_deferred_options_results(struct context *c)
+{
+    struct options *o = &c->options;
+
+    struct buffer out;
+    uint8_t line[1024] = { 0 };
+    buf_set_write(&out, line, sizeof(line));
+
+
+    if (cipher_kt_mode_aead(o->ciphername))
+    {
+        buf_printf(&out, "Data Channel: cipher '%s'",
+                   cipher_kt_name(o->ciphername));
+    }
+    else
+    {
+        buf_printf(&out, "Data Channel: cipher '%s', auth '%s'",
+                   cipher_kt_name(o->ciphername), md_kt_name(o->authname));
+    }
+
+    if (o->use_peer_id)
+    {
+        buf_printf(&out, ", peer-id: %d", o->peer_id);
+    }
+
+#ifdef USE_COMP
+    if (c->c2.comp_context)
+    {
+        buf_printf(&out, ", compression: '%s'", c->c2.comp_context->alg.name);
+    }
+#endif
+
+    msg(D_HANDSHAKE, "%s", BSTR(&out));
+
+    buf_clear(&out);
+
+    const char *header = "Timers: ";
+
+    buf_printf(&out, "%s", header);
+
+    if (o->ping_send_timeout)
+    {
+        buf_printf(&out, "ping %d", o->ping_send_timeout);
+    }
+
+    if (o->ping_rec_timeout_action != PING_UNDEF)
+    {
+        /* yes unidirectional ping is possible .... */
+        add_delim_if_non_empty(&out, header);
+
+        if (o->ping_rec_timeout_action == PING_EXIT)
+        {
+            buf_printf(&out, "ping-exit %d", o->ping_rec_timeout);
+        }
+        else
+        {
+            buf_printf(&out, "ping-restart %d", o->ping_rec_timeout);
+        }
+    }
+
+    if (o->inactivity_timeout)
+    {
+        add_delim_if_non_empty(&out, header);
+
+        buf_printf(&out, "inactive %d", o->inactivity_timeout);
+        if (o->inactivity_minimum_bytes)
+        {
+            buf_printf(&out, " %" PRIu64, o->inactivity_minimum_bytes);
+        }
+    }
+
+    if (o->session_timeout)
+    {
+        add_delim_if_non_empty(&out, header);
+        buf_printf(&out, "session-timeout %d", o->session_timeout);
+    }
+
+    if (buf_len(&out) > strlen(header))
+    {
+        msg(D_HANDSHAKE, "%s", BSTR(&out));
+    }
+
+    buf_clear(&out);
+    header = "Protocol options: ";
+    buf_printf(&out, "%s", header);
+
+    if (c->options.ce.explicit_exit_notification)
+    {
+        buf_printf(&out, "explicit-exit-notify %d",
+                   c->options.ce.explicit_exit_notification);
+    }
+    if (c->options.imported_protocol_flags)
+    {
+        add_delim_if_non_empty(&out, header);
+
+        buf_printf(&out, "protocol-flags");
+
+        if (o->imported_protocol_flags & CO_USE_CC_EXIT_NOTIFY)
+        {
+            buf_printf(&out, " cc-exit");
+        }
+        if (o->imported_protocol_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT)
+        {
+            buf_printf(&out, " tls-ekm");
+        }
+    }
+
+    if (buf_len(&out) > strlen(header))
+    {
+        msg(D_HANDSHAKE, "%s", BSTR(&out));
+    }
+}
+
+
 /**
  * This function is expected to be invoked after open_tun() was performed.
  *
@@ -2370,6 +2505,8 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
             initialization_sequence_completed(c, error_flags); /* client/p2p restart with --persist-tun */
         }
 
+        tls_print_deferred_options_results(c);
+
         c->c2.do_up_ran = true;
         if (c->c2.tls_multi)
         {
@@ -2470,7 +2607,7 @@ do_deferred_options(struct context *c, const unsigned int found)
     if (found & OPT_P_TIMER)
     {
         do_init_timers(c, true);
-        msg(D_PUSH, "OPTIONS IMPORT: timers and/or timeouts modified");
+        msg(D_PUSH_DEBUG, "OPTIONS IMPORT: timers and/or timeouts modified");
     }
 
     if (found & OPT_P_EXPLICIT_NOTIFY)
@@ -2482,14 +2619,14 @@ do_deferred_options(struct context *c, const unsigned int found)
         }
         else
         {
-            msg(D_PUSH, "OPTIONS IMPORT: explicit notify parm(s) modified");
+            msg(D_PUSH_DEBUG, "OPTIONS IMPORT: explicit notify parm(s) modified");
         }
     }
 
 #ifdef USE_COMP
     if (found & OPT_P_COMP)
     {
-        msg(D_PUSH, "OPTIONS IMPORT: compression parms modified");
+        msg(D_PUSH_DEBUG, "OPTIONS IMPORT: compression parms modified");
         comp_uninit(c->c2.comp_context);
         c->c2.comp_context = comp_init(&c->options.comp);
     }
@@ -2540,7 +2677,7 @@ do_deferred_options(struct context *c, const unsigned int found)
 
     if (found & OPT_P_PEER_ID)
     {
-        msg(D_PUSH, "OPTIONS IMPORT: peer-id set");
+        msg(D_PUSH_DEBUG, "OPTIONS IMPORT: peer-id set");
         c->c2.tls_multi->use_peer_id = true;
         c->c2.tls_multi->peer_id = c->options.peer_id;
     }
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index 4320bd119..e382482f6 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -153,4 +153,20 @@ check_send_occ_msg(struct context *c)
     }
 }
 
+/**
+ * Small helper function to determine if we should send the exit notification
+ * via control channel.
+ * @return control channel exit message should be used */
+static inline bool
+cc_exit_notify_enabled(struct context *c)
+{
+    /* Check if we have TLS active at all */
+    if (!c->c2.tls_multi)
+    {
+        return false;
+    }
+
+    const struct key_state *ks = get_primary_key(c->c2.tls_multi);
+    return (ks->crypto_options.flags & CO_USE_CC_EXIT_NOTIFY);
+}
 #endif /* ifndef OCC_H */
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 0d5346010..5b89bb42b 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -342,21 +342,6 @@ print_status(const struct context *c, struct status_output *so)
 }
 
 
-/* Small helper function to determine if we should send the exit notification
- * via control channel */
-static inline bool
-cc_exit_notify_enabled(struct context *c)
-{
-    /* Check if we have TLS active at all */
-    if (!c->c2.tls_multi)
-    {
-        return false;
-    }
-
-    const struct key_state *ks = get_primary_key(c->c2.tls_multi);
-    return (ks->crypto_options.flags & CO_USE_CC_EXIT_NOTIFY);
-}
-
 /*
  * Handle the triggering and time-wait of explicit
  * exit notification.
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 016bdc57f..47f3702b2 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1730,11 +1730,6 @@ tls_session_update_crypto_params_do_work(struct tls_multi *multi,
         return true;
 
     }
-    if (strcmp(options->ciphername, session->opt->config_ciphername))
-    {
-        msg(D_HANDSHAKE, "Data Channel: using negotiated cipher '%s'",
-            options->ciphername);
-    }
 
     init_key_type(&session->opt->key_type, options->ciphername,
                   options->authname, true, true);
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index fe6f6fa7c..97619be5e 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -318,7 +318,7 @@ check_pull_client_ncp(struct context *c, const int found)
 {
     if (found & OPT_P_NCP)
     {
-        msg(D_PUSH, "OPTIONS IMPORT: data channel crypto options modified");
+        msg(D_PUSH_DEBUG, "OPTIONS IMPORT: data channel crypto options modified");
         return true;
     }
 
-- 
2.37.1 (Apple Git-137.1)


