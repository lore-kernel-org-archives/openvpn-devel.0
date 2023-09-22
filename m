From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 22 Sep 2023 12:38:30 +0200
Message-Id: <20230922103830.37151-1-frank@...2641...>
In-Reply-To: <gerrit.1685031225000.I58706019add6d348483ba222dd74e1466ff6c709@...2715...>
References: <gerrit.1685031225000.I58706019add6d348483ba222dd74e1466ff6c709@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove --no-replay option
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
Cc: Heiko Hund <heiko@...515...>

Officially deprecated since v2.4.
We have warned about using this forever.
It is time to pull the plug.

Change-Id: I58706019add6d348483ba222dd74e1466ff6c709
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Heiko Hund <heiko@...515...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/281
This mail reflects revision 3 of this Change.
Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@...515...>

        
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index 14e76b4..675fee4 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -366,8 +366,7 @@
   order they were received to the TCP/IP protocol stack, provided they
   satisfy several constraints.
 
-  (a)   The packet cannot be a replay (unless ``--no-replay`` is
-        specified, which disables replay protection altogether).
+  (a)   The packet cannot be a replay.
 
   (b)   If a packet arrives out of order, it will only be accepted if
         the difference between its sequence number and the highest sequence
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 6b9ad21..80dc77d 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -406,7 +406,7 @@
   Options that will be compared for compatibility include ``dev-type``,
   ``link-mtu``, ``tun-mtu``, ``proto``, ``ifconfig``,
   ``comp-lzo``, ``fragment``, ``keydir``, ``cipher``,
-  ``auth``, ``keysize``, ``secret``, ``no-replay``,
+  ``auth``, ``keysize``, ``secret``,
   ``tls-auth``, ``key-method``, ``tls-server``
   and ``tls-client``.
 
diff --git a/doc/man-sections/unsupported-options.rst b/doc/man-sections/unsupported-options.rst
index 5c4e3a0..a0c1232 100644
--- a/doc/man-sections/unsupported-options.rst
+++ b/doc/man-sections/unsupported-options.rst
@@ -30,8 +30,9 @@
   VPN tunnel security.  This has been a NOOP option since OpenVPN 2.4.
 
 --no-replay
-  Removed in OpenVPN 2.5.  This option should not be used as it weakens the
-  VPN tunnel security.
+  Removed in OpenVPN 2.7.  This option should not be used as it weakens the
+  VPN tunnel security.  Previously we claimed to have removed this in
+  OpenVPN 2.5, but this wasn't actually the case.
 
 --ns-cert-type
   Removed in OpenVPN 2.5.  The ``nsCertType`` field is no longer supported
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index a77b5a1..e4452d7 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -328,7 +328,7 @@
         if (!(opt->flags & CO_MUTE_REPLAY_WARNINGS))
         {
             msg(D_REPLAY_ERRORS, "%s: bad packet ID (may be a replay): %s -- "
-                "see the man page entry for --no-replay and --replay-window for "
+                "see the man page entry for --replay-window for "
                 "more info or silence this warning with --mute-replay-warnings",
                 error_prefix, packet_id_net_print(pin, true, gc));
         }
@@ -942,18 +942,6 @@
     return true;
 }
 
-void
-check_replay_consistency(const struct key_type *kt, bool packet_id)
-{
-    ASSERT(kt);
-
-    if (!packet_id && (cipher_kt_mode_ofb_cfb(kt->cipher)
-                       || cipher_kt_mode_aead(kt->cipher)))
-    {
-        msg(M_FATAL, "--no-replay cannot be used with a CFB, OFB or AEAD mode cipher");
-    }
-}
-
 /*
  * Generate a random key.
  */
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 88f8f44..c5fd253 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -40,7 +40,7 @@
  *    HMAC at all.
  *  - \b Ciphertext \b IV. The IV size depends on the \c \-\-cipher option.
  *  - \b Packet \b ID, a 32-bit incrementing packet counter that provides replay
- *    protection (if not disabled by \c \-\-no-replay).
+ *    protection.
  *  - \b Timestamp, a 32-bit timestamp of the current time.
  *  - \b Payload, the plain text network packet to be encrypted (unless
  *    encryption is disabled by using \c \-\-cipher \c none). The payload might
@@ -304,8 +304,6 @@
  */
 int write_key_file(const int nkeys, const char *filename);
 
-void check_replay_consistency(const struct key_type *kt, bool packet_id);
-
 bool check_key(struct key *key, const struct key_type *kt);
 
 bool write_key(const struct key *key, const struct key_type *kt,
@@ -445,7 +443,7 @@
  * this and add it themselves.
  *
  * @param kt            Struct with the crypto algorithm to use
- * @param packet_id_size Size of the packet id, can be 0 if no-replay is used
+ * @param packet_id_size Size of the packet id
  * @param occ           if true calculates the overhead for crypto in the same
  *                      incorrect way as all previous OpenVPN versions did, to
  *                      end up with identical numbers for OCC compatibility
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 6fb6900..1fe56a2 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3019,17 +3019,14 @@
     }
 
     /* Initialize packet ID tracking */
-    if (options->replay)
-    {
-        packet_id_init(&c->c2.crypto_options.packet_id,
-                       options->replay_window,
-                       options->replay_time,
-                       "STATIC", 0);
-        c->c2.crypto_options.pid_persist = &c->c1.pid_persist;
-        c->c2.crypto_options.flags |= CO_PACKET_ID_LONG_FORM;
-        packet_id_persist_load_obj(&c->c1.pid_persist,
-                                   &c->c2.crypto_options.packet_id);
-    }
+    packet_id_init(&c->c2.crypto_options.packet_id,
+                   options->replay_window,
+                   options->replay_time,
+                   "STATIC", 0);
+    c->c2.crypto_options.pid_persist = &c->c1.pid_persist;
+    c->c2.crypto_options.flags |= CO_PACKET_ID_LONG_FORM;
+    packet_id_persist_load_obj(&c->c1.pid_persist,
+                               &c->c2.crypto_options.packet_id);
 
     if (!key_ctx_bi_defined(&c->c1.ks.static_key))
     {
@@ -3051,9 +3048,6 @@
 
     /* Get key schedule */
     c->c2.crypto_options.key_ctx_bi = c->c1.ks.static_key;
-
-    /* Sanity check on sequence number, and cipher mode options */
-    check_replay_consistency(&c->c1.ks.key_type, options->replay);
 }
 
 /*
@@ -3256,9 +3250,6 @@
         return;
     }
 
-    /* Sanity check on sequence number, and cipher mode options */
-    check_replay_consistency(&c->c1.ks.key_type, options->replay);
-
     /* In short form, unique datagram identifier is 32 bits, in long form 64 bits */
     packet_id_long_form = cipher_kt_mode_ofb_cfb(c->c1.ks.key_type.cipher);
 
@@ -3279,7 +3270,6 @@
     to.ssl_ctx = c->c1.ks.ssl_ctx;
     to.key_type = c->c1.ks.key_type;
     to.server = options->tls_server;
-    to.replay = options->replay;
     to.replay_window = options->replay_window;
     to.replay_time = options->replay_time;
     to.tcp_mode = link_socket_proto_connection_oriented(options->ce.proto);
@@ -3645,11 +3635,6 @@
         }
     }
 
-    if (!o->replay)
-    {
-        msg(M_WARN, "WARNING: You have disabled Replay Protection (--no-replay) which may make " PACKAGE_NAME " less secure");
-    }
-
     if (o->tls_server)
     {
         warn_on_use_of_common_subnets(&c->net_ctx);
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 132f93c..56db118 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -52,13 +52,6 @@
 unsigned int
 calc_packet_id_size_dc(const struct options *options, const struct key_type *kt)
 {
-    /* Unless no-replay is enabled, we have a packet id, no matter if
-     * encryption is used or not */
-    if (!options->replay)
-    {
-        return 0;
-    }
-
     bool tlsmode = options->tls_server || options->tls_client;
 
     bool packet_id_long_form = !tlsmode || cipher_kt_mode_ofb_cfb(kt->cipher);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 90d85be..e9d5720 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -549,7 +549,6 @@
 #ifndef ENABLE_CRYPTO_MBEDTLS
     "--engine [name] : Enable OpenSSL hardware crypto engine functionality.\n"
 #endif
-    "--no-replay     : (DEPRECATED) Disable replay protection.\n"
     "--mute-replay-warnings : Silence the output of replay warnings to log file.\n"
     "--replay-window n [t]  : Use a replay protection sliding window of size n\n"
     "                         and a time window of t seconds.\n"
@@ -868,7 +867,6 @@
     o->ifconfig_pool_persist_refresh_freq = 600;
     o->scheduled_exit_interval = 5;
     o->authname = "SHA1";
-    o->replay = true;
     o->replay_window = DEFAULT_SEQ_BACKTRACK;
     o->replay_time = DEFAULT_TIME_BACKTRACK;
     o->key_direction = KEY_DIRECTION_BIDIRECTIONAL;
@@ -1954,7 +1952,6 @@
 #ifndef ENABLE_CRYPTO_MBEDTLS
     SHOW_BOOL(engine);
 #endif /* ENABLE_CRYPTO_MBEDTLS */
-    SHOW_BOOL(replay);
     SHOW_BOOL(mute_replay_warnings);
     SHOW_INT(replay_window);
     SHOW_INT(replay_time);
@@ -2817,16 +2814,6 @@
     }
 
     /*
-     * Check consistency of replay options
-     */
-    if (!options->replay
-        && (options->replay_window != defaults.replay_window
-            || options->replay_time != defaults.replay_time))
-    {
-        msg(M_USAGE, "--replay-window doesn't make sense when replay protection is disabled with --no-replay");
-    }
-
-    /*
      * SSL/TLS mode sanity checks.
      */
     if (options->tls_server + options->tls_client
@@ -4198,7 +4185,6 @@
  * --cipher
  * --auth
  * --secret
- * --no-replay
  *
  * SSL Options:
  *
@@ -4364,10 +4350,6 @@
         {
             buf_printf(&out, ",secret");
         }
-        if (!o->replay)
-        {
-            buf_printf(&out, ",no-replay");
-        }
 
 #ifdef ENABLE_PREDICTION_RESISTANCE
         if (o->use_prediction_resistance)
@@ -8670,7 +8652,9 @@
     else if (streq(p[0], "no-replay") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->replay = false;
+        /* always error out, this breaks the connection */
+        msg(M_FATAL, "--no-replay was removed in OpenVPN 2.7. "
+            "Update your configuration.");
     }
     else if (streq(p[0], "replay-window") && !p[3])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f5890b9..5810fd1 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -560,7 +560,6 @@
     const char *authname;
     const char *engine;
     struct provider_list providers;
-    bool replay;
     bool mute_replay_warnings;
     int replay_window;
     int replay_time;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index c975dbc..5e6205c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1007,12 +1007,9 @@
     reliable_set_timeout(ks->send_reliable, session->opt->packet_timeout);
 
     /* init packet ID tracker */
-    if (session->opt->replay)
-    {
-        packet_id_init(&ks->crypto_options.packet_id,
-                       session->opt->replay_window, session->opt->replay_time, "SSL",
-                       ks->key_id);
-    }
+    packet_id_init(&ks->crypto_options.packet_id,
+                   session->opt->replay_window, session->opt->replay_time, "SSL",
+                   ks->key_id);
 
     ks->crypto_options.pid_persist = NULL;
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 27b0294..d3edc5f 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -310,7 +310,6 @@
     const char *remote_options;
 
     /* from command line */
-    bool replay;
     bool single_session;
     bool disable_occ;
     int mode;
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 58eebc0..5564524 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -247,7 +247,6 @@
 
     /* common defaults */
     o.ce.tun_mtu = 1400;
-    o.replay = true;
     o.ce.proto = PROTO_UDP;
 
     /* No crypto at all */
@@ -334,15 +333,6 @@
     linkmtu = calc_options_string_link_mtu(&o, &f);
     assert_int_equal(linkmtu, 1405);
 
-    /* tls client, auth none, cipher none, no-replay */
-    o.replay = false;
-
-    linkmtu = calc_options_string_link_mtu(&o, &f);
-    assert_int_equal(linkmtu, 1401);
-
-
-    o.replay = true;
-
     /* tls client, auth SHA1, cipher AES-256-GCM */
     o.authname = "SHA1";
     o.ciphername = "AES-256-GCM";
@@ -378,7 +368,6 @@
     /* common defaults */
     o.ce.tun_mtu = 1400;
     o.ce.mssfix = 1000;
-    o.replay = true;
     o.ce.proto = PROTO_UDP;
 
     /* No crypto at all */

