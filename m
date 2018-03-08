From: Steffan Karger <steffan@...1856...>
Date: Thu,  8 Mar 2018 20:47:48 +0100
Message-Id: <20180308194748.4627-1-steffan@...1856...>
In-Reply-To: <1487344823-8125-1-git-send-email-steffan@...1856...>
References: <1487344823-8125-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Allow changing cipher from a ccd file
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

As described in msg  <374a7eb7-f539-5231-623b-41f208ed856e@...1823...> on
openvpn-devel@lists.sourceforge.net, clients that are compiled with
--disable-occ (included in --enable-small) won't send an options string.
Without the options string, the 2.4 server doesn't know which cipher to
use for poor man's NCP.

This patch allows working around that issue by allowing the 'cipher'
directive to be used in --client-config-dir files.  That way, a server
admin can add ccd files to specify per-client which cipher to use.

Because the ccd files are read after where we would normally generate keys,
this patch delays key generation for non-NCP p2mp servers until after
reading the ccd file.

Thanks to a sharp review comment from Gert, it turns out that
multi_connections_establised() is actually a better place than
incoming_push_message() to do the server-side NCP cipher selection and key
generation.  Doing it here removes the need for handling with multiple
received push requests.  Technically, the check for .authenticated before
generating keys should even not be necessary, but I think it's good to
leave it in as a double-check to prevent future mistakes.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
v2: postpone p2mp non-NCP key generation, such that setting cipher in
    a ccd file for a non-NCP client actually works.
v3: merge all server-side NCP key generation to the new place.

 src/openvpn/multi.c   | 45 +++++++++++++++++++++++++++++++++------------
 src/openvpn/options.c |  2 +-
 src/openvpn/options.h |  2 +-
 src/openvpn/push.c    | 22 ----------------------
 src/openvpn/ssl.c     |  9 ++++-----
 5 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 6a72a1dc..77dd6724 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1786,6 +1786,7 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
     {
         struct gc_arena gc = gc_new();
         unsigned int option_types_found = 0;
+        struct options *options = &mi->context.options;
 
         const unsigned int option_permissions_mask =
             OPT_P_INSTANCE
@@ -1810,7 +1811,7 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
         generate_prefix(mi);
 
         /* delete instances of previous clients with same common-name */
-        if (!mi->context.options.duplicate_cn)
+        if (!options->duplicate_cn)
         {
             multi_delete_dup(m, mi);
         }
@@ -1822,11 +1823,11 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
          * Try to source a dynamic config file from the
          * --client-config-dir directory.
          */
-        if (mi->context.options.client_config_dir)
+        if (options->client_config_dir)
         {
             const char *ccd_file;
 
-            ccd_file = gen_path(mi->context.options.client_config_dir,
+            ccd_file = gen_path(options->client_config_dir,
                                 tls_common_name(mi->context.c2.tls_multi, false),
                                 &gc);
 
@@ -1842,7 +1843,7 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
             }
             else /* try default file */
             {
-                ccd_file = gen_path(mi->context.options.client_config_dir,
+                ccd_file = gen_path(options->client_config_dir,
                                     CCD_DEFAULT,
                                     &gc);
 
@@ -1876,7 +1877,7 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
         if (plugin_defined(mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT))
         {
             struct argv argv = argv_new();
-            const char *dc_file = create_temp_file(mi->context.options.tmp_dir, "cc", &gc);
+            const char *dc_file = create_temp_file(options->tmp_dir, "cc", &gc);
 
             if (!dc_file)
             {
@@ -1931,21 +1932,21 @@ script_depr_failed:
         /*
          * Run --client-connect script.
          */
-        if (mi->context.options.client_connect_script && cc_succeeded)
+        if (options->client_connect_script && cc_succeeded)
         {
             struct argv argv = argv_new();
             const char *dc_file = NULL;
 
             setenv_str(mi->context.c2.es, "script_type", "client-connect");
 
-            dc_file = create_temp_file(mi->context.options.tmp_dir, "cc", &gc);
+            dc_file = create_temp_file(options->tmp_dir, "cc", &gc);
             if (!dc_file)
             {
                 cc_succeeded = false;
                 goto script_failed;
             }
 
-            argv_parse_cmd(&argv, mi->context.options.client_connect_script);
+            argv_parse_cmd(&argv, options->client_connect_script);
             argv_printf_cat(&argv, "%s", dc_file);
 
             if (openvpn_run_script(&argv, mi->context.c2.es, 0, "--client-connect"))
@@ -1983,13 +1984,33 @@ script_failed:
          * Check for "disable" directive in client-config-dir file
          * or config file generated by --client-connect script.
          */
-        if (mi->context.options.disable)
+        if (options->disable)
         {
             msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to 'disable' directive");
             cc_succeeded = false;
             cc_succeeded_count = 0;
         }
 
+        /* Determine data channel cipher and generate data channel keys */
+        struct tls_multi *multi = mi->context.c2.tls_multi;
+        if (tls_peer_info_ncp_ver(multi->peer_info) >= 2 && options->ncp_enabled)
+        {
+            /* Select the first cipher from --ncp-ciphers for the data channel.
+             * TODO: actual negotiation, instead of server dictatorship. */
+            char *push_cipher = string_alloc(options->ncp_ciphers, &options->gc);
+            options->ciphername = strtok(push_cipher, ":");
+        }
+
+        struct tls_session *session = &multi->session[TM_ACTIVE];
+        if (!session->key[KS_PRIMARY].authenticated
+            || !tls_session_update_crypto_params(session, &mi->context.options,
+                                                 &mi->context.c2.frame))
+        {
+            msg(D_TLS_ERRORS, "TLS Error: updating crypto parameters failed");
+            cc_succeeded = false;
+            cc_succeeded_count = 0;
+        }
+
         if (cc_succeeded)
         {
             /*
@@ -2015,8 +2036,8 @@ script_failed:
                 msg(D_MULTI_ERRORS, "MULTI ERROR: primary virtual IP for %s (%s) violates tunnel network/netmask constraint (%s/%s)",
                     multi_instance_string(mi, false, &gc),
                     print_in_addr_t(mi->context.c2.push_ifconfig_local, 0, &gc),
-                    print_in_addr_t(mi->context.options.push_ifconfig_constraint_network, 0, &gc),
-                    print_in_addr_t(mi->context.options.push_ifconfig_constraint_netmask, 0, &gc));
+                    print_in_addr_t(options->push_ifconfig_constraint_network, 0, &gc),
+                    print_in_addr_t(options->push_ifconfig_constraint_netmask, 0, &gc));
             }
 
             /*
@@ -2053,7 +2074,7 @@ script_failed:
                  */
                 remove_iroutes_from_push_route_list(&mi->context.options);
             }
-            else if (mi->context.options.iroutes)
+            else if (options->iroutes)
             {
                 msg(D_MULTI_ERRORS, "MULTI: --iroute options rejected for %s -- iroute only works with tun-style tunnels",
                     multi_instance_string(mi, false, &gc));
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 587f73ad..5443b204 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7505,7 +7505,7 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "cipher") && p[1] && !p[2])
     {
-        VERIFY_PERMISSION(OPT_P_NCP);
+        VERIFY_PERMISSION(OPT_P_NCP|OPT_P_INSTANCE);
         options->ciphername = p[1];
     }
     else if (streq(p[0], "ncp-ciphers") && p[1] && !p[2])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 636bb8db..565b3697 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -624,7 +624,7 @@ struct options
 #define OPT_P_MTU             (1<<14) /* TODO */
 #define OPT_P_NICE            (1<<15)
 #define OPT_P_PUSH            (1<<16)
-#define OPT_P_INSTANCE        (1<<17)
+#define OPT_P_INSTANCE        (1<<17) /**< Allow usage in ccd file */
 #define OPT_P_CONFIG          (1<<18)
 #define OPT_P_EXPLICIT_NOTIFY (1<<19)
 #define OPT_P_ECHO            (1<<20)
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index fee3eaab..d58d7119 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -270,21 +270,6 @@ incoming_push_message(struct context *c, const struct buffer *buffer)
         }
         event_timeout_clear(&c->c2.push_request_interval);
     }
-    else if (status == PUSH_MSG_REQUEST)
-    {
-        if (c->options.mode == MODE_SERVER)
-        {
-            struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
-            /* Do not regenerate keys if client send a second push request */
-            if (!session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized
-                && !tls_session_update_crypto_params(session, &c->options,
-                                                     &c->c2.frame))
-            {
-                msg(D_TLS_ERRORS, "TLS Error: initializing data channel failed");
-                goto error;
-            }
-        }
-    }
 
     goto cleanup;
 error:
@@ -384,13 +369,6 @@ prepare_push_reply(struct context *c, struct gc_arena *gc,
                  "re-sending previously negotiated cipher '%s'",
                  o->ciphername );
         }
-        else
-        {
-            /* Push the first cipher from --ncp-ciphers to the client.
-             * TODO: actual negotiation, instead of server dictatorship. */
-            char *push_cipher = string_alloc(o->ncp_ciphers, &o->gc);
-            o->ciphername = strtok(push_cipher, ":");
-        }
         push_option_fmt(gc, push_list, M_USAGE, "cipher %s", o->ciphername);
     }
     else if (o->ncp_enabled)
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 21a29195..48de2e32 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2426,12 +2426,11 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
     }
 
     /* Generate tunnel keys if we're a TLS server.
-     * If we're a p2mp server and IV_NCP >= 2 is negotiated, the first key
-     * generation is postponed until after the pull/push, so we can process pushed
-     * cipher directives.
+     * If we're a p2mp server, the first key generation is postponed so we can
+     * switch cipher during the connection setup phase.
      */
-    if (session->opt->server && !(session->opt->ncp_enabled
-                                  && session->opt->mode == MODE_SERVER && ks->key_id <= 0))
+    if (session->opt->server
+        && !(session->opt->mode == MODE_SERVER && ks->key_id <= 0))
     {
         if (ks->authenticated)
         {
-- 
2.15.1


