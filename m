From: Gert Doering <gert@...1296...>
Date: Tue, 18 Mar 2025 16:53:11 +0100
Message-ID: <20250318155320.32573-1-gert@...1296...>
In-Reply-To: <gerrit.1733851405000.I4f766fa22865eaf4466c31cf55e3d73b00008c38@...2715...>
References: <gerrit.1733851405000.I4f766fa22865eaf4466c31cf55e3d73b00008c38@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] options: Cleanup and simplify
 options_postprocess_verify_ce
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

From: Frank Lichtenheld <frank@...2641...>

- Reuse the MUST_BE_UNDEF macro in more places
- Add a second parameter so it actually reports the
  correct option name
- Add MUST_BE_FALSE for similar cases
- Reorder the checks for cert/key options to make
  more sense. Some of the checks could have never
  fired due to wrong placement of the management
  checks
- Some other small cleanups like missing spaces
  in multiline string literal

Change-Id: I4f766fa22865eaf4466c31cf55e3d73b00008c38
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/832
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 31000e9..67ef55b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2369,6 +2369,13 @@
 static void
 check_ca_required(const struct options *options)
 {
+#ifdef ENABLE_CRYPTO_MBEDTLS
+    if (options->ca_path)
+    {
+        msg(M_USAGE, "Parameter --capath cannot be used with the mbed TLS version of OpenVPN.");
+    }
+#endif
+
     if (options->verify_hash_no_ca
         || options->pkcs12_file
         || options->ca_file
@@ -2388,6 +2395,11 @@
     msg(M_USAGE, "%s", str);
 }
 
+#define MUST_BE_UNDEF(parm, parm_name) \
+    if (options->parm != defaults.parm) { msg(M_USAGE, use_err, parm_name); }
+#define MUST_BE_FALSE(condition, parm_name) \
+    if (condition) { msg(M_USAGE, use_err, parm_name); }
+
 static void
 options_postprocess_verify_ce(const struct options *options,
                               const struct connection_entry *ce)
@@ -2636,6 +2648,8 @@
      */
     if (options->mode == MODE_SERVER)
     {
+        const char use_err[] = "--%s cannot be used with --mode server.";
+
 #define USAGE_VALID_SERVER_PROTOS "--mode server currently only supports " \
     "--proto values of udp, tcp-server, tcp4-server, or tcp6-server"
 #ifdef TARGET_ANDROID
@@ -2645,10 +2659,7 @@
         {
             msg(M_USAGE, "--mode server only works with --dev tun or --dev tap");
         }
-        if (options->pull)
-        {
-            msg(M_USAGE, "--pull cannot be used with --mode server");
-        }
+        MUST_BE_UNDEF(pull, "pull");
         if (options->pull_filter_list)
         {
             msg(M_WARN, "--pull-filter ignored for --mode server");
@@ -2669,22 +2680,10 @@
         {
             msg(M_USAGE, "--mode server requires --tls-server");
         }
-        if (ce->remote)
-        {
-            msg(M_USAGE, "--remote cannot be used with --mode server");
-        }
-        if (!ce->bind_local)
-        {
-            msg(M_USAGE, "--nobind cannot be used with --mode server");
-        }
-        if (ce->http_proxy_options)
-        {
-            msg(M_USAGE, "--http-proxy cannot be used with --mode server");
-        }
-        if (ce->socks_proxy_server)
-        {
-            msg(M_USAGE, "--socks-proxy cannot be used with --mode server");
-        }
+        MUST_BE_FALSE(ce->remote, "remote");
+        MUST_BE_FALSE(!ce->bind_local, "nobind");
+        MUST_BE_FALSE(ce->http_proxy_options, "http-proxy");
+        MUST_BE_FALSE(ce->socks_proxy_server, "socks-proxy");
         /* <connection> blocks force to have a remote embedded, so we check
          * for the --remote and bail out if it is present
          */
@@ -2694,10 +2693,7 @@
             msg(M_USAGE, "<connection> cannot be used with --mode server");
         }
 
-        if (options->shaper)
-        {
-            msg(M_USAGE, "--shaper cannot be used with --mode server");
-        }
+        MUST_BE_UNDEF(shaper, "shaper");
         if (options->ipchange)
         {
             msg(M_USAGE,
@@ -2720,14 +2716,8 @@
         {
             msg(M_USAGE, "--redirect-gateway cannot be used with --mode server (however --push \"redirect-gateway\" is fine)");
         }
-        if (options->route_delay_defined)
-        {
-            msg(M_USAGE, "--route-delay cannot be used with --mode server");
-        }
-        if (options->up_delay)
-        {
-            msg(M_USAGE, "--up-delay cannot be used with --mode server");
-        }
+        MUST_BE_UNDEF(route_delay_defined, "route-delay");
+        MUST_BE_UNDEF(up_delay, "up-delay");
         if (!options->ifconfig_pool_defined
             && !options->ifconfig_ipv6_pool_defined
             && options->ifconfig_pool_persist_filename)
@@ -2739,10 +2729,7 @@
         {
             msg(M_USAGE, "--ifconfig-ipv6-pool needs --ifconfig-ipv6");
         }
-        if (options->allow_recursive_routing)
-        {
-            msg(M_USAGE, "--allow-recursive-routing cannot be used with --mode server");
-        }
+        MUST_BE_UNDEF(allow_recursive_routing, "allow-recursive-routing");
         if (options->auth_user_pass_file)
         {
             msg(M_USAGE, "--auth-user-pass cannot be used with --mode server (it should be used on the client side only)");
@@ -2764,23 +2751,19 @@
                 options->handshake_window);
 
         }
+        if (!options->auth_user_pass_verify_script
+            || PLUGIN_OPTION_LIST(options)
+            || MAN_CLIENT_AUTH_ENABLED(options))
         {
-            const bool ccnr = (options->auth_user_pass_verify_script
-                               || PLUGIN_OPTION_LIST(options)
-                               || MAN_CLIENT_AUTH_ENABLED(options));
-            const char *postfix = "must be used with --management-client-auth, an --auth-user-pass-verify script, or plugin";
-            if ((options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CERT_OPTIONAL)) && !ccnr)
-            {
-                msg(M_USAGE, "--verify-client-cert none|optional %s", postfix);
-            }
-            if ((options->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) && !ccnr)
-            {
-                msg(M_USAGE, "--username-as-common-name %s", postfix);
-            }
-            if ((options->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) && !ccnr)
-            {
-                msg(M_USAGE, "--auth-user-pass-optional %s", postfix);
-            }
+            const char *use_err = "--%s must be used with --management-client-auth, an --auth-user-pass-verify script, or plugin";
+
+            MUST_BE_FALSE(options->ssl_flags
+                          & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CERT_OPTIONAL),
+                          "verify-client-cert none|optional");
+            MUST_BE_FALSE(options->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME,
+                          "username-as-common-name");
+            MUST_BE_FALSE(options->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL,
+                          "auth-user-pass-optional");
         }
 
         if (options->vlan_tagging && dev != DEV_TYPE_TAP)
@@ -2789,125 +2772,65 @@
         }
         if (!options->vlan_tagging)
         {
-            if (options->vlan_accept != defaults.vlan_accept)
-            {
-                msg(M_USAGE, "--vlan-accept requires --vlan-tagging");
-            }
-            if (options->vlan_pvid != defaults.vlan_pvid)
-            {
-                msg(M_USAGE, "--vlan-pvid requires --vlan-tagging");
-            }
+            const char use_err[] = "--%s requires --vlan-tagging";
+            MUST_BE_UNDEF(vlan_accept, "vlan-accept");
+            MUST_BE_UNDEF(vlan_pvid, "vlan-pvid");
         }
     }
     else
     {
+        const char use_err[] = "--%s requires --mode server";
         /*
          * When not in server mode, err if parameters are
          * specified which require --mode server.
          */
-        if (options->ifconfig_pool_defined || options->ifconfig_pool_persist_filename)
-        {
-            msg(M_USAGE, "--ifconfig-pool/--ifconfig-pool-persist requires --mode server");
-        }
-        if (options->ifconfig_ipv6_pool_defined)
-        {
-            msg(M_USAGE, "--ifconfig-ipv6-pool requires --mode server");
-        }
-        if (options->real_hash_size != defaults.real_hash_size
-            || options->virtual_hash_size != defaults.virtual_hash_size)
-        {
-            msg(M_USAGE, "--hash-size requires --mode server");
-        }
-        if (options->learn_address_script)
-        {
-            msg(M_USAGE, "--learn-address requires --mode server");
-        }
-        if (options->client_connect_script)
-        {
-            msg(M_USAGE, "--client-connect requires --mode server");
-        }
-        if (options->client_crresponse_script)
-        {
-            msg(M_USAGE, "--client-crresponse requires --mode server");
-        }
-        if (options->client_disconnect_script)
-        {
-            msg(M_USAGE, "--client-disconnect requires --mode server");
-        }
-        if (options->client_config_dir || options->ccd_exclusive)
-        {
-            msg(M_USAGE, "--client-config-dir/--ccd-exclusive requires --mode server");
-        }
-        if (options->enable_c2c)
-        {
-            msg(M_USAGE, "--client-to-client requires --mode server");
-        }
-        if (options->duplicate_cn)
-        {
-            msg(M_USAGE, "--duplicate-cn requires --mode server");
-        }
-        if (options->cf_max || options->cf_per)
-        {
-            msg(M_USAGE, "--connect-freq requires --mode server");
-        }
-        if (options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CERT_OPTIONAL))
-        {
-            msg(M_USAGE, "--verify-client-cert requires --mode server");
-        }
-        if (options->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
-        {
-            msg(M_USAGE, "--username-as-common-name requires --mode server");
-        }
-        if (options->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL)
-        {
-            msg(M_USAGE, "--auth-user-pass-optional requires --mode server");
-        }
-        if (options->ssl_flags & SSLF_OPT_VERIFY)
-        {
-            msg(M_USAGE, "--opt-verify requires --mode server");
-        }
+        MUST_BE_UNDEF(ifconfig_pool_defined, "ifconfig-pool");
+        MUST_BE_UNDEF(ifconfig_pool_persist_filename, "ifconfig-pool-persist");
+        MUST_BE_UNDEF(ifconfig_ipv6_pool_defined, "ifconfig-ipv6-pool");
+        MUST_BE_UNDEF(real_hash_size, "hash-size");
+        MUST_BE_UNDEF(virtual_hash_size, "hash-size");
+        MUST_BE_UNDEF(learn_address_script, "learn-address");
+        MUST_BE_UNDEF(client_connect_script, "client-connect");
+        MUST_BE_UNDEF(client_crresponse_script, "client-crresponse");
+        MUST_BE_UNDEF(client_disconnect_script, "client-disconnect");
+        MUST_BE_UNDEF(client_config_dir, "client-config-dir");
+        MUST_BE_UNDEF(ccd_exclusive, "ccd-exclusive");
+        MUST_BE_UNDEF(enable_c2c, "client-to-client");
+        MUST_BE_UNDEF(duplicate_cn, "duplicate-cn");
+        MUST_BE_UNDEF(cf_max, "connect-freq");
+        MUST_BE_UNDEF(cf_per, "connect-freq");
+        MUST_BE_FALSE(options->ssl_flags
+                      & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CERT_OPTIONAL),
+                      "verify-client-cert");
+        MUST_BE_FALSE(options->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME, "username-as-common-name");
+        MUST_BE_FALSE(options->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL, "auth-user-pass-optional");
+        MUST_BE_FALSE(options->ssl_flags & SSLF_OPT_VERIFY, "opt-verify");
         if (options->server_flags & SF_TCP_NODELAY_HELPER)
         {
             msg(M_WARN, "WARNING: setting tcp-nodelay on the client side will not "
                 "affect the server. To have TCP_NODELAY in both direction use "
                 "tcp-nodelay in the server configuration instead.");
         }
-        if (options->auth_user_pass_verify_script)
-        {
-            msg(M_USAGE, "--auth-user-pass-verify requires --mode server");
-        }
-        if (options->auth_token_generate)
-        {
-            msg(M_USAGE, "--auth-gen-token requires --mode server");
-        }
+        MUST_BE_UNDEF(auth_user_pass_verify_script, "auth-user-pass-verify");
+        MUST_BE_UNDEF(auth_token_generate, "auth-gen-token");
 #if PORT_SHARE
         if (options->port_share_host || options->port_share_port)
         {
             msg(M_USAGE, "--port-share requires TCP server mode (--mode server --proto tcp-server)");
         }
 #endif
-
-        if (options->stale_routes_check_interval)
-        {
-            msg(M_USAGE, "--stale-routes-check requires --mode server");
-        }
-
-        if (options->vlan_tagging)
-        {
-            msg(M_USAGE, "--vlan-tagging requires --mode server");
-        }
-
-        if (options->force_key_material_export)
-        {
-            msg(M_USAGE, "--force-tls-key-material-export requires --mode server");
-        }
+        MUST_BE_UNDEF(stale_routes_check_interval, "stale-routes-check");
+        MUST_BE_UNDEF(vlan_tagging, "vlan-tagging");
+        MUST_BE_UNDEF(vlan_accept, "vlan-accept");
+        MUST_BE_UNDEF(vlan_pvid, "vlan-pvid");
+        MUST_BE_UNDEF(force_key_material_export, "force-key-material-export");
     }
 
     /*
      * SSL/TLS mode sanity checks.
      */
     if (options->tls_server + options->tls_client
-        +(options->shared_secret_file != NULL) > 1)
+        + (options->shared_secret_file != NULL) > 1)
     {
         msg(M_USAGE, "specify only one of --tls-server, --tls-client, or --secret");
     }
@@ -2924,9 +2847,9 @@
             "configuration detected. OpenVPN 2.8 will remove the "
             "functionality to run a VPN without TLS. "
             "See the examples section in the manual page for "
-            "examples of a similar quick setup with peer-fingerprint."
+            "examples of a similar quick setup with peer-fingerprint. "
             "OpenVPN 2.7 allows using this configuration when using "
-            "--allow-deprecated-insecure-static-crypto but you should move"
+            "--allow-deprecated-insecure-static-crypto but you should move "
             "to a proper configuration using TLS as soon as possible."
             );
     }
@@ -2973,112 +2896,60 @@
             {
                 msg(M_USAGE, "Parameter --pkcs11-id or --pkcs11-id-management should be specified.");
             }
-            if (options->cert_file)
-            {
-                msg(M_USAGE, "Parameter --cert cannot be used when --pkcs11-provider is also specified.");
-            }
-            if (options->priv_key_file)
-            {
-                msg(M_USAGE, "Parameter --key cannot be used when --pkcs11-provider is also specified.");
-            }
-            if (options->management_flags & MF_EXTERNAL_KEY)
-            {
-                msg(M_USAGE, "Parameter --management-external-key cannot be used when --pkcs11-provider is also specified.");
-            }
-            if (options->management_flags & MF_EXTERNAL_CERT)
-            {
-                msg(M_USAGE, "Parameter --management-external-cert cannot be used when --pkcs11-provider is also specified.");
-            }
-            if (options->pkcs12_file)
-            {
-                msg(M_USAGE, "Parameter --pkcs12 cannot be used when --pkcs11-provider is also specified.");
-            }
+            const char use_err[] = "Parameter --%s cannot be used when --pkcs11-provider is also specified.";
+            MUST_BE_UNDEF(cert_file, "cert");
+            MUST_BE_UNDEF(priv_key_file, "key");
+            MUST_BE_UNDEF(pkcs12_file, "pkcs12");
+            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "management-external-key");
+            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_CERT, "management-external-cert");
 #ifdef ENABLE_CRYPTOAPI
-            if (options->cryptoapi_cert)
-            {
-                msg(M_USAGE, "Parameter --cryptoapicert cannot be used when --pkcs11-provider is also specified.");
-            }
+            MUST_BE_UNDEF(cryptoapi_cert, "cryptoapicert");
 #endif
         }
         else
 #endif /* ifdef ENABLE_PKCS11 */
-        if ((options->management_flags & MF_EXTERNAL_KEY) && options->priv_key_file)
-        {
-            msg(M_USAGE, "--key and --management-external-key are mutually exclusive");
-        }
-        else if ((options->management_flags & MF_EXTERNAL_CERT))
-        {
-            if (options->cert_file)
-            {
-                msg(M_USAGE, "--cert and --management-external-cert are mutually exclusive");
-            }
-            else if (!(options->management_flags & MF_EXTERNAL_KEY))
-            {
-                msg(M_USAGE, "--management-external-cert must be used with --management-external-key");
-            }
-        }
-        else
 #ifdef ENABLE_CRYPTOAPI
         if (options->cryptoapi_cert)
         {
-            if (options->cert_file)
-            {
-                msg(M_USAGE, "Parameter --cert cannot be used when --cryptoapicert is also specified.");
-            }
-            if (options->priv_key_file)
-            {
-                msg(M_USAGE, "Parameter --key cannot be used when --cryptoapicert is also specified.");
-            }
-            if (options->pkcs12_file)
-            {
-                msg(M_USAGE, "Parameter --pkcs12 cannot be used when --cryptoapicert is also specified.");
-            }
-            if (options->management_flags & MF_EXTERNAL_KEY)
-            {
-                msg(M_USAGE, "Parameter --management-external-key cannot be used when --cryptoapicert is also specified.");
-            }
-            if (options->management_flags & MF_EXTERNAL_CERT)
-            {
-                msg(M_USAGE, "Parameter --management-external-cert cannot be used when --cryptoapicert is also specified.");
-            }
+            const char use_err[] = "Parameter --%s cannot be used when --cryptoapicert is also specified.";
+            MUST_BE_UNDEF(cert_file, "cert");
+            MUST_BE_UNDEF(priv_key_file, "key");
+            MUST_BE_UNDEF(pkcs12_file, "pkcs12");
+            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "management-external-key");
+            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_CERT, "management-external-cert");
         }
         else
-#endif /* ifdef ENABLE_CRYPTOAPI */
+#endif
         if (options->pkcs12_file)
         {
 #ifdef ENABLE_CRYPTO_MBEDTLS
             msg(M_USAGE, "Parameter --pkcs12 cannot be used with the mbed TLS version of OpenVPN.");
 #else
-            if (options->ca_path)
-            {
-                msg(M_USAGE, "Parameter --capath cannot be used when --pkcs12 is also specified.");
-            }
-            if (options->cert_file)
-            {
-                msg(M_USAGE, "Parameter --cert cannot be used when --pkcs12 is also specified.");
-            }
-            if (options->priv_key_file)
-            {
-                msg(M_USAGE, "Parameter --key cannot be used when --pkcs12 is also specified.");
-            }
-            if (options->management_flags & MF_EXTERNAL_KEY)
-            {
-                msg(M_USAGE, "Parameter --management-external-key cannot be used when --pkcs12 is also specified.");
-            }
-            if (options->management_flags & MF_EXTERNAL_CERT)
-            {
-                msg(M_USAGE, "Parameter --management-external-cert cannot be used when --pkcs12 is also specified.");
-            }
+            const char use_err[] = "Parameter --%s cannot be used when --pkcs12 is also specified.";
+            MUST_BE_UNDEF(ca_path, "capath");
+            MUST_BE_UNDEF(cert_file, "cert");
+            MUST_BE_UNDEF(priv_key_file, "key");
+            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "management-external-key");
+            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_CERT, "management-external-cert");
 #endif /* ifdef ENABLE_CRYPTO_MBEDTLS */
         }
-        else
+        else /* cert/key from none of pkcs11, pkcs12, cryptoapi */
         {
-#ifdef ENABLE_CRYPTO_MBEDTLS
-            if (options->ca_path)
+            if ((options->management_flags & MF_EXTERNAL_KEY) && options->priv_key_file)
             {
-                msg(M_USAGE, "Parameter --capath cannot be used with the mbed TLS version of OpenVPN.");
+                msg(M_USAGE, "--key and --management-external-key are mutually exclusive");
             }
-#endif  /* ifdef ENABLE_CRYPTO_MBEDTLS */
+            if ((options->management_flags & MF_EXTERNAL_CERT))
+            {
+                if (options->cert_file)
+                {
+                    msg(M_USAGE, "--cert and --management-external-cert are mutually exclusive");
+                }
+                else if (!(options->management_flags & MF_EXTERNAL_KEY))
+                {
+                    msg(M_USAGE, "--management-external-cert must be used with --management-external-key");
+                }
+            }
             if (pull)
             {
 
@@ -3130,55 +3001,51 @@
          * when in non-TLS mode.
          */
 
-#define MUST_BE_UNDEF(parm) if (options->parm != defaults.parm) {msg(M_USAGE, err, #parm); \
-}
+        const char use_err[] = "Parameter %s can only be specified in TLS-mode, "
+                               "i.e. where --tls-server or --tls-client is also specified.";
 
-        const char err[] = "Parameter %s can only be specified in TLS-mode, i.e. where --tls-server or --tls-client is also specified.";
-
-        MUST_BE_UNDEF(ca_file);
-        MUST_BE_UNDEF(ca_path);
-        MUST_BE_UNDEF(dh_file);
-        MUST_BE_UNDEF(cert_file);
-        MUST_BE_UNDEF(priv_key_file);
+        MUST_BE_UNDEF(ca_file, "ca");
+        MUST_BE_UNDEF(ca_path, "capath");
+        MUST_BE_UNDEF(dh_file, "dh");
+        MUST_BE_UNDEF(cert_file, "cert");
+        MUST_BE_UNDEF(priv_key_file, "key");
 #ifndef ENABLE_CRYPTO_MBEDTLS
-        MUST_BE_UNDEF(pkcs12_file);
+        MUST_BE_UNDEF(pkcs12_file, "pkcs12");
 #endif
-        MUST_BE_UNDEF(cipher_list);
-        MUST_BE_UNDEF(cipher_list_tls13);
-        MUST_BE_UNDEF(tls_cert_profile);
-        MUST_BE_UNDEF(tls_verify);
-        MUST_BE_UNDEF(tls_export_peer_cert_dir);
-        MUST_BE_UNDEF(verify_x509_name);
-        MUST_BE_UNDEF(tls_timeout);
-        MUST_BE_UNDEF(renegotiate_bytes);
-        MUST_BE_UNDEF(renegotiate_packets);
-        MUST_BE_UNDEF(renegotiate_seconds);
-        MUST_BE_UNDEF(handshake_window);
-        MUST_BE_UNDEF(transition_window);
-        MUST_BE_UNDEF(tls_auth_file);
-        MUST_BE_UNDEF(tls_crypt_file);
-        MUST_BE_UNDEF(tls_crypt_v2_file);
-        MUST_BE_UNDEF(single_session);
-        MUST_BE_UNDEF(push_peer_info);
-        MUST_BE_UNDEF(tls_exit);
-        MUST_BE_UNDEF(crl_file);
-        MUST_BE_UNDEF(ns_cert_type);
-        MUST_BE_UNDEF(remote_cert_ku[0]);
-        MUST_BE_UNDEF(remote_cert_eku);
+        MUST_BE_UNDEF(cipher_list, "tls-cipher");
+        MUST_BE_UNDEF(cipher_list_tls13, "tls-ciphersuites");
+        MUST_BE_UNDEF(tls_cert_profile, "tls-cert-profile");
+        MUST_BE_UNDEF(tls_verify, "tls-verify");
+        MUST_BE_UNDEF(tls_export_peer_cert_dir, "tls-export-cert");
+        MUST_BE_UNDEF(verify_x509_name, "verify-x509-name");
+        MUST_BE_UNDEF(tls_timeout, "tls-timeout");
+        MUST_BE_UNDEF(renegotiate_bytes, "reneg-bytes");
+        MUST_BE_UNDEF(renegotiate_packets, "reneg-pkts");
+        MUST_BE_UNDEF(renegotiate_seconds, "reneg-sec");
+        MUST_BE_UNDEF(handshake_window, "hand-window");
+        MUST_BE_UNDEF(transition_window, "tran-window");
+        MUST_BE_UNDEF(tls_auth_file, "tls-auth");
+        MUST_BE_UNDEF(tls_crypt_file, "tls-crypt");
+        MUST_BE_UNDEF(tls_crypt_v2_file, "tls-crypt-v2");
+        MUST_BE_UNDEF(single_session, "single-session");
+        MUST_BE_UNDEF(push_peer_info, "push-peer-info");
+        MUST_BE_UNDEF(tls_exit, "tls-exit");
+        MUST_BE_UNDEF(crl_file, "crl-verify");
+        MUST_BE_UNDEF(ns_cert_type, "ns-cert-type");
+        MUST_BE_UNDEF(remote_cert_ku[0], "remote-cert-ku");
+        MUST_BE_UNDEF(remote_cert_eku, "remote-cert-eku");
 #ifdef ENABLE_PKCS11
-        MUST_BE_UNDEF(pkcs11_providers[0]);
-        MUST_BE_UNDEF(pkcs11_private_mode[0]);
-        MUST_BE_UNDEF(pkcs11_id);
-        MUST_BE_UNDEF(pkcs11_id_management);
+        MUST_BE_UNDEF(pkcs11_providers[0], "pkcs11-providers");
+        MUST_BE_UNDEF(pkcs11_private_mode[0], "pkcs11-private-mode");
+        MUST_BE_UNDEF(pkcs11_id, "pkcs11-id");
+        MUST_BE_UNDEF(pkcs11_id_management, "pkcs11-id-management");
 #endif
 
         if (pull)
         {
-            msg(M_USAGE, err, "--pull");
+            msg(M_USAGE, use_err, "--pull");
         }
     }
-#undef MUST_BE_UNDEF
-
     if (options->auth_user_pass_file && !options->pull)
     {
         msg(M_USAGE, "--auth-user-pass requires --pull");
@@ -3187,6 +3054,9 @@
     uninit_options(&defaults);
 }
 
+#undef MUST_BE_UNDEF
+#undef MUST_BE_FALSE
+
 static void
 options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
 {

