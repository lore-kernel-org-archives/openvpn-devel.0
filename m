From: Arne Schwabe <arne@...1227...>
Date: Thu,  8 Apr 2021 16:02:27 +0200
Message-Id: <20210408140229.31824-3-arne@...1227...>
In-Reply-To: <20210408140229.31824-1-arne@...1227...>
References: <20210408140229.31824-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/3] Remove --ncp-disable option
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

NCP has proven to be stable and apart from the one VPN Provider doing
hacky things with homebrewed NCP we have not had any reports about
ncp-disable being required. Remove ncp-disable to simplify code paths.

Note: This patch breaks client without --pull. The follow up patch
for P2P NCP will restore that. But to avoid all the NCP/non-NCP special
cases to be implemented in P2P. P2P will directly switch from always
non-NCP to always NCP.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                           |  4 +++
 doc/man-sections/protocol-options.rst |  8 ++----
 src/openvpn/init.c                    | 17 ++++---------
 src/openvpn/multi.c                   |  4 ---
 src/openvpn/options.c                 | 36 +++------------------------
 src/openvpn/options.h                 |  1 -
 src/openvpn/ssl.c                     |  3 +--
 src/openvpn/ssl_common.h              |  1 -
 src/openvpn/ssl_ncp.c                 |  4 ---
 9 files changed, 16 insertions(+), 62 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 457dfc07e..d6ccc1c92 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -47,6 +47,10 @@ Deprecated features
     is considered "too complicated", using ``--peer-fingerprint`` makes
     TLS mode about as easy as using ``--secret``.
 
+``ncp-disable`` has been removed
+    This option mainly served a role as debug option when NCP was first
+    introduced. It should now no longer be necessary.
+
 Overview of changes in 2.5
 ==========================
 
diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 4b6928c68..fe8ca8fd1 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -65,8 +65,8 @@ configured in a compatible way between both the local and remote side.
   The default is :code:`BF-CBC`, an abbreviation for Blowfish in Cipher
   Block Chaining mode. When cipher negotiation (NCP) is allowed,
   OpenVPN 2.4 and newer on both client and server side will automatically
-  upgrade to :code:`AES-256-GCM`.  See ``--data-ciphers`` and
-  ``--ncp-disable`` for more details on NCP.
+  upgrade to :code:`AES-256-GCM`.  See ``--data-ciphers`` for more details
+  on NCP.
 
   Using :code:`BF-CBC` is no longer recommended, because of its 64-bit
   block size. This small block size allows attacks based on collisions, as
@@ -230,10 +230,6 @@ configured in a compatible way between both the local and remote side.
     have been configured with `--enable-small`
     (typically used on routers or other embedded devices).
 
---ncp-disable
-  **DEPRECATED** Disable "Negotiable Crypto Parameters". This completely
-  disables cipher negotiation.
-
 --secret args
   **DEPRECATED** Enable Static Key encryption mode (non-TLS). Use pre-shared secret
   ``file`` which was generated with ``--genkey``.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 28d183aa0..4a6b84914 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2226,18 +2226,14 @@ pull_permission_mask(const struct context *c)
         | OPT_P_EXPLICIT_NOTIFY
         | OPT_P_ECHO
         | OPT_P_PULL_MODE
-        | OPT_P_PEER_ID;
+        | OPT_P_PEER_ID
+        | OPT_P_NCP;
 
     if (!c->options.route_nopull)
     {
         flags |= (OPT_P_ROUTE | OPT_P_IPWIN32);
     }
 
-    if (c->options.ncp_enabled)
-    {
-        flags |= OPT_P_NCP;
-    }
-
     return flags;
 }
 
@@ -2734,8 +2730,6 @@ do_init_crypto_tls_c1(struct context *c)
         *
         * Therefore, the key structure has to be initialized when:
         * - any non-BF-CBC cipher was selected; or
-        * - BF-CBC is selected and NCP is disabled (explicit request to
-        *   use the BF-CBC cipher); or
         * - BF-CBC is selected, NCP is enabled and fallback is enabled
         *   (BF-CBC will be the fallback).
         * - BF-CBC is in data-ciphers and we negotiate to use BF-CBC:
@@ -2745,12 +2739,12 @@ do_init_crypto_tls_c1(struct context *c)
         * Note that BF-CBC will still be part of the OCC string to retain
         * backwards compatibility with older clients.
         */
-        if (!streq(options->ciphername, "BF-CBC") || !options->ncp_enabled
-            || (options->ncp_enabled && tls_item_in_cipher_list("BF-CBC", options->ncp_ciphers))
+        if (!streq(options->ciphername, "BF-CBC")
+            || tls_item_in_cipher_list("BF-CBC", options->ncp_ciphers)
             || options->enable_ncp_fallback)
         {
             /* Do not warn if the if the cipher is used only in OCC */
-            bool warn = !options->ncp_enabled || options->enable_ncp_fallback;
+            bool warn = options->enable_ncp_fallback;
             init_key_type(&c->c1.ks.key_type, options->ciphername, options->authname,
                           true, warn);
         }
@@ -2847,7 +2841,6 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.tcp_mode = link_socket_proto_connection_oriented(options->ce.proto);
     to.config_ciphername = c->options.ciphername;
     to.config_ncp_ciphers = c->options.ncp_ciphers;
-    to.ncp_enabled = options->ncp_enabled;
     to.transition_window = options->transition_window;
     to.handshake_window = options->handshake_window;
     to.packet_timeout = options->tls_timeout;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e6eb34bfb..1dd7c8983 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1790,10 +1790,6 @@ multi_client_set_protocol_options(struct context *c)
 #endif
 
     /* Select cipher if client supports Negotiable Crypto Parameters */
-    if (!o->ncp_enabled)
-    {
-        return true;
-    }
 
     /* if we have already created our key, we cannot *change* our own
      * cipher -> so log the fact and push the "what we have now" cipher
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 24d722fd5..e2759a1ac 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -526,7 +526,6 @@ static const char usage_message[] =
     "                  (default=%s).\n"
     "                  Set alg=none to disable encryption.\n"
     "--data-ciphers list : List of ciphers that are allowed to be negotiated.\n"
-    "--ncp-disable   : (DEPRECATED) Disable cipher negotiation.\n"
     "--prng alg [nsl] : For PRNG, use digest algorithm alg, and\n"
     "                   nonce_secret_len=nsl.  Set alg=none to disable PRNG.\n"
 #ifndef ENABLE_CRYPTO_MBEDTLS
@@ -843,7 +842,6 @@ init_options(struct options *o, const bool init_gc)
     o->stale_routes_check_interval = 0;
     o->ifconfig_pool_persist_refresh_freq = 600;
     o->scheduled_exit_interval = 5;
-    o->ncp_enabled = true;
     o->ncp_ciphers = "AES-256-GCM:AES-128-GCM";
     o->authname = "SHA1";
     o->prng_hash = "SHA1";
@@ -1715,7 +1713,6 @@ show_settings(const struct options *o)
     SHOW_STR_INLINE(shared_secret_file);
     SHOW_PARM(key_direction, keydirection2ascii(o->key_direction, false, true), "%s");
     SHOW_STR(ciphername);
-    SHOW_BOOL(ncp_enabled);
     SHOW_STR(ncp_ciphers);
     SHOW_STR(authname);
     SHOW_STR(prng_hash);
@@ -3061,7 +3058,6 @@ options_postprocess_cipher(struct options *o)
     if (!o->pull && !(o->mode == MODE_SERVER))
     {
         /* we are in the classic P2P mode */
-        o->ncp_enabled = false;
         msg( M_WARN, "Cipher negotiation is disabled since neither "
              "P2MP client nor server mode is enabled");
 
@@ -3078,18 +3074,6 @@ options_postprocess_cipher(struct options *o)
     /* pull or P2MP mode */
     if (!o->ciphername)
     {
-        if (!o->ncp_enabled)
-        {
-            msg(M_USAGE, "--ncp-disable needs an explicit --cipher or "
-                         "--data-ciphers-fallback config option");
-        }
-
-        msg(M_WARN, "--cipher is not set. Previous OpenVPN version defaulted to "
-            "BF-CBC as fallback when cipher negotiation failed in this case. "
-            "If you need this fallback please add '--data-ciphers-fallback "
-            "BF-CBC' to your configuration and/or add BF-CBC to "
-            "--data-ciphers.");
-
         /* We still need to set the ciphername to BF-CBC since various other
          * parts of OpenVPN assert that the ciphername is set */
         o->ciphername = "BF-CBC";
@@ -3131,13 +3115,10 @@ options_postprocess_mutate(struct options *o)
     options_postprocess_cipher(o);
     options_postprocess_mutate_invariant(o);
 
-    if (o->ncp_enabled)
+    o->ncp_ciphers = mutate_ncp_cipher_list(o->ncp_ciphers, &o->gc);
+    if (o->ncp_ciphers == NULL)
     {
-        o->ncp_ciphers = mutate_ncp_cipher_list(o->ncp_ciphers, &o->gc);
-        if (o->ncp_ciphers == NULL)
-        {
-            msg(M_USAGE, "NCP cipher list contains unsupported ciphers or is too long.");
-        }
+        msg(M_USAGE, "NCP cipher list contains unsupported ciphers or is too long.");
     }
 
     if (o->remote_list && !o->connection_list)
@@ -3879,8 +3860,7 @@ options_string(const struct options *o,
         }
         /* Only announce the cipher to our peer if we are willing to
          * support it */
-        if (p2p_nopull || !o->ncp_enabled
-            || tls_item_in_cipher_list(ciphername, o->ncp_ciphers))
+        if (p2p_nopull || tls_item_in_cipher_list(ciphername, o->ncp_ciphers))
         {
             buf_printf(&out, ",cipher %s", ciphername);
         }
@@ -7957,14 +7937,6 @@ add_option(struct options *options,
             msg(msglevel, "Unknown key-derivation method %s", p[1]);
         }
     }
-    else if (streq(p[0], "ncp-disable") && !p[1])
-    {
-        VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
-        options->ncp_enabled = false;
-        msg(M_WARN, "DEPRECATED OPTION: ncp-disable. Disabling "
-            "cipher negotiation is a deprecated debug feature that "
-            "will be removed in OpenVPN 2.6");
-    }
     else if (streq(p[0], "prng") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b80cd3d1b..17f21103d 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -506,7 +506,6 @@ struct options
     const char *ciphername;
     bool enable_ncp_fallback;      /**< If defined fall back to
                                     * ciphername if NCP fails */
-    bool ncp_enabled;
     const char *ncp_ciphers;
     const char *authname;
     const char *prng_hash;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 5d65c3da5..068b66616 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2149,8 +2149,7 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
         }
 
         /* support for Negotiable Crypto Parameters */
-        if (session->opt->ncp_enabled
-            && (session->opt->mode == MODE_SERVER || session->opt->pull))
+        if (session->opt->mode == MODE_SERVER || session->opt->pull)
         {
             if (tls_item_in_cipher_list("AES-128-GCM", session->opt->config_ncp_ciphers)
                 && tls_item_in_cipher_list("AES-256-GCM", session->opt->config_ncp_ciphers))
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 5b24623d4..3f8dd0178 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -308,7 +308,6 @@ struct tls_options
 
     const char *config_ciphername;
     const char *config_ncp_ciphers;
-    bool ncp_enabled;
 
     bool tls_crypt_v2;
     const char *tls_crypt_v2_verify_script;
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index f02a3103c..722256b42 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -289,10 +289,6 @@ check_pull_client_ncp(struct context *c, const int found)
         return true;
     }
 
-    if (!c->options.ncp_enabled)
-    {
-        return true;
-    }
     /* If the server did not push a --cipher, we will switch to the
      * remote cipher if it is in our ncp-ciphers list */
     if(tls_poor_mans_ncp(&c->options, c->c2.tls_multi->remote_ciphername))
-- 
2.31.1


