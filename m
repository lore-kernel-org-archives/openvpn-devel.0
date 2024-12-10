From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 10 Dec 2024 17:23:28 +0000
References: <gerrit.1733851405000.I4f766fa22865eaf4466c31cf55e3d73b00008c38@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f7ec7f48fa1ed277583f4f239b90ec55093ba207-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rxfTALYXk9w="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: Cleanup and
 simplify options_postprocess_verify_ce
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rxfTALYXk9w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/832?usp=3Demail

to review the following change.


Change subject: options: Cleanup and simplify options_postprocess_verify_ce
......................................................................

options: Cleanup and simplify options_postprocess_verify_ce

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
---
M src/openvpn/options.c
1 file changed, 142 insertions(+), 274 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/32/832/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d8dd518..d7f1a8f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2300,6 +2300,13 @@
 static void
 check_ca_required(const struct options *options)
 {
+#ifdef ENABLE_CRYPTO_MBEDTLS
+    if (options->ca_path)
+    {
+        msg(M_USAGE, "Parameter --capath cannot be used with the mbed TLS =
version of OpenVPN.");
+    }
+#endif
+
     if (options->verify_hash_no_ca
         || options->pkcs12_file
         || options->ca_file
@@ -2319,6 +2326,11 @@
     msg(M_USAGE, "%s", str);
 }

+#define MUST_BE_UNDEF(parm, parm_name) \
+    if (options->parm !=3D defaults.parm) { msg(M_USAGE, use_err, parm_nam=
e); }
+#define MUST_BE_FALSE(condition, parm_name) \
+    if (condition) { msg(M_USAGE, use_err, parm_name); }
+
 static void
 options_postprocess_verify_ce(const struct options *options,
                               const struct connection_entry *ce)
@@ -2555,6 +2567,8 @@
      */
     if (options->mode =3D=3D MODE_SERVER)
     {
+        const char use_err[] =3D "--%s cannot be used with --mode server.";
+
 #define USAGE_VALID_SERVER_PROTOS "--mode server currently only supports "=
 \
     "--proto values of udp, tcp-server, tcp4-server, or tcp6-server"
 #ifdef TARGET_ANDROID
@@ -2564,10 +2578,7 @@
         {
             msg(M_USAGE, "--mode server only works with --dev tun or --dev=
 tap");
         }
-        if (options->pull)
-        {
-            msg(M_USAGE, "--pull cannot be used with --mode server");
-        }
+        MUST_BE_UNDEF(pull, "pull");
         if (options->pull_filter_list)
         {
             msg(M_WARN, "--pull-filter ignored for --mode server");
@@ -2588,22 +2599,10 @@
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
-            msg(M_USAGE, "--socks-proxy cannot be used with --mode server"=
);
-        }
+        MUST_BE_FALSE(ce->remote, "remote");
+        MUST_BE_FALSE(!ce->bind_local, "nobind");
+        MUST_BE_FALSE(ce->http_proxy_options, "http-proxy");
+        MUST_BE_FALSE(ce->socks_proxy_server, "socks-proxy");
         /* <connection> blocks force to have a remote embedded, so we check
          * for the --remote and bail out if it is present
          */
@@ -2613,10 +2612,7 @@
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
@@ -2639,14 +2635,8 @@
         {
             msg(M_USAGE, "--redirect-gateway cannot be used with --mode se=
rver (however --push \"redirect-gateway\" is fine)");
         }
-        if (options->route_delay_defined)
-        {
-            msg(M_USAGE, "--route-delay cannot be used with --mode server"=
);
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
@@ -2658,10 +2648,7 @@
         {
             msg(M_USAGE, "--ifconfig-ipv6-pool needs --ifconfig-ipv6");
         }
-        if (options->allow_recursive_routing)
-        {
-            msg(M_USAGE, "--allow-recursive-routing cannot be used with --=
mode server");
-        }
+        MUST_BE_UNDEF(allow_recursive_routing, "allow-recursive-routing");
         if (options->auth_user_pass_file)
         {
             msg(M_USAGE, "--auth-user-pass cannot be used with --mode serv=
er (it should be used on the client side only)");
@@ -2683,23 +2670,19 @@
                 options->handshake_window);

         }
+        if (!options->auth_user_pass_verify_script
+            || PLUGIN_OPTION_LIST(options)
+            || MAN_CLIENT_AUTH_ENABLED(options))
         {
-            const bool ccnr =3D (options->auth_user_pass_verify_script
-                               || PLUGIN_OPTION_LIST(options)
-                               || MAN_CLIENT_AUTH_ENABLED(options));
-            const char *postfix =3D "must be used with --management-client=
-auth, an --auth-user-pass-verify script, or plugin";
-            if ((options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_=
CLIENT_CERT_OPTIONAL)) && !ccnr)
-            {
-                msg(M_USAGE, "--verify-client-cert none|optional %s", post=
fix);
-            }
-            if ((options->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) && !cc=
nr)
-            {
-                msg(M_USAGE, "--username-as-common-name %s", postfix);
-            }
-            if ((options->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) && !cc=
nr)
-            {
-                msg(M_USAGE, "--auth-user-pass-optional %s", postfix);
-            }
+            const char *use_err =3D "--%s must be used with --management-c=
lient-auth, an --auth-user-pass-verify script, or plugin";
+
+            MUST_BE_FALSE(options->ssl_flags
+                          & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CER=
T_OPTIONAL),
+                          "verify-client-cert none|optional");
+            MUST_BE_FALSE(options->ssl_flags & SSLF_USERNAME_AS_COMMON_NAM=
E,
+                          "username-as-common-name");
+            MUST_BE_FALSE(options->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONA=
L,
+                          "auth-user-pass-optional");
         }

         if (options->vlan_tagging && dev !=3D DEV_TYPE_TAP)
@@ -2708,125 +2691,65 @@
         }
         if (!options->vlan_tagging)
         {
-            if (options->vlan_accept !=3D defaults.vlan_accept)
-            {
-                msg(M_USAGE, "--vlan-accept requires --vlan-tagging");
-            }
-            if (options->vlan_pvid !=3D defaults.vlan_pvid)
-            {
-                msg(M_USAGE, "--vlan-pvid requires --vlan-tagging");
-            }
+            const char use_err[] =3D "--%s requires --vlan-tagging";
+            MUST_BE_UNDEF(vlan_accept, "vlan-accept");
+            MUST_BE_UNDEF(vlan_pvid, "vlan-pvid");
         }
     }
     else
     {
+        const char use_err[] =3D "--%s requires --mode server";
         /*
          * When not in server mode, err if parameters are
          * specified which require --mode server.
          */
-        if (options->ifconfig_pool_defined || options->ifconfig_pool_persi=
st_filename)
-        {
-            msg(M_USAGE, "--ifconfig-pool/--ifconfig-pool-persist requires=
 --mode server");
-        }
-        if (options->ifconfig_ipv6_pool_defined)
-        {
-            msg(M_USAGE, "--ifconfig-ipv6-pool requires --mode server");
-        }
-        if (options->real_hash_size !=3D defaults.real_hash_size
-            || options->virtual_hash_size !=3D defaults.virtual_hash_size)
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
-            msg(M_USAGE, "--client-config-dir/--ccd-exclusive requires --m=
ode server");
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
-        if (options->ssl_flags & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIEN=
T_CERT_OPTIONAL))
-        {
-            msg(M_USAGE, "--verify-client-cert requires --mode server");
-        }
-        if (options->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
-        {
-            msg(M_USAGE, "--username-as-common-name requires --mode server=
");
-        }
-        if (options->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL)
-        {
-            msg(M_USAGE, "--auth-user-pass-optional requires --mode server=
");
-        }
-        if (options->ssl_flags & SSLF_OPT_VERIFY)
-        {
-            msg(M_USAGE, "--opt-verify requires --mode server");
-        }
+        MUST_BE_UNDEF(ifconfig_pool_defined, "ifconfig-pool");
+        MUST_BE_UNDEF(ifconfig_pool_persist_filename, "ifconfig-pool-persi=
st");
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
+                      & (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CERT_OP=
TIONAL),
+                      "verify-client-cert");
+        MUST_BE_FALSE(options->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME, "=
username-as-common-name");
+        MUST_BE_FALSE(options->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL, "=
auth-user-pass-optional");
+        MUST_BE_FALSE(options->ssl_flags & SSLF_OPT_VERIFY, "opt-verify");
         if (options->server_flags & SF_TCP_NODELAY_HELPER)
         {
             msg(M_WARN, "WARNING: setting tcp-nodelay on the client side w=
ill not "
                 "affect the server. To have TCP_NODELAY in both direction =
use "
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
+        MUST_BE_UNDEF(auth_user_pass_verify_script, "auth-user-pass-verify=
");
+        MUST_BE_UNDEF(auth_token_generate, "auth-gen-token");
 #if PORT_SHARE
         if (options->port_share_host || options->port_share_port)
         {
             msg(M_USAGE, "--port-share requires TCP server mode (--mode se=
rver --proto tcp-server)");
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
-            msg(M_USAGE, "--force-tls-key-material-export requires --mode =
server");
-        }
+        MUST_BE_UNDEF(stale_routes_check_interval, "stale-routes-check");
+        MUST_BE_UNDEF(vlan_tagging, "vlan-tagging");
+        MUST_BE_UNDEF(vlan_accept, "vlan-accept");
+        MUST_BE_UNDEF(vlan_pvid, "vlan-pvid");
+        MUST_BE_UNDEF(force_key_material_export, "force-key-material-expor=
t");
     }

     /*
      * SSL/TLS mode sanity checks.
      */
     if (options->tls_server + options->tls_client
-        +(options->shared_secret_file !=3D NULL) > 1)
+        + (options->shared_secret_file !=3D NULL) > 1)
     {
         msg(M_USAGE, "specify only one of --tls-server, --tls-client, or -=
-secret");
     }
@@ -2843,9 +2766,9 @@
             "configuration detected. OpenVPN 2.8 will remove the "
             "functionality to run a VPN without TLS. "
             "See the examples section in the manual page for "
-            "examples of a similar quick setup with peer-fingerprint."
+            "examples of a similar quick setup with peer-fingerprint. "
             "OpenVPN 2.7 allows using this configuration when using "
-            "--allow-deprecated-insecure-static-crypto but you should move"
+            "--allow-deprecated-insecure-static-crypto but you should move=
 "
             "to a proper configuration using TLS as soon as possible."
             );
     }
@@ -2892,112 +2815,58 @@
             {
                 msg(M_USAGE, "Parameter --pkcs11-id or --pkcs11-id-managem=
ent should be specified.");
             }
-            if (options->cert_file)
-            {
-                msg(M_USAGE, "Parameter --cert cannot be used when --pkcs1=
1-provider is also specified.");
-            }
-            if (options->priv_key_file)
-            {
-                msg(M_USAGE, "Parameter --key cannot be used when --pkcs11=
-provider is also specified.");
-            }
-            if (options->management_flags & MF_EXTERNAL_KEY)
-            {
-                msg(M_USAGE, "Parameter --management-external-key cannot b=
e used when --pkcs11-provider is also specified.");
-            }
-            if (options->management_flags & MF_EXTERNAL_CERT)
-            {
-                msg(M_USAGE, "Parameter --management-external-cert cannot =
be used when --pkcs11-provider is also specified.");
-            }
-            if (options->pkcs12_file)
-            {
-                msg(M_USAGE, "Parameter --pkcs12 cannot be used when --pkc=
s11-provider is also specified.");
-            }
-#ifdef ENABLE_CRYPTOAPI
-            if (options->cryptoapi_cert)
-            {
-                msg(M_USAGE, "Parameter --cryptoapicert cannot be used whe=
n --pkcs11-provider is also specified.");
-            }
-#endif
+            const char use_err[] =3D "Parameter --%s cannot be used when -=
-pkcs11-provider is also specified.";
+            MUST_BE_UNDEF(cert_file, "cert");
+            MUST_BE_UNDEF(priv_key_file, "key");
+            MUST_BE_UNDEF(pkcs12_file, "pkcs12");
+            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "ma=
nagement-external-key");
+            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_CERT, "m=
anagement-external-cert");
+            MUST_BE_UNDEF(cryptoapi_cert, "cryptoapicert");
         }
         else
 #endif /* ifdef ENABLE_PKCS11 */
-        if ((options->management_flags & MF_EXTERNAL_KEY) && options->priv=
_key_file)
-        {
-            msg(M_USAGE, "--key and --management-external-key are mutually=
 exclusive");
-        }
-        else if ((options->management_flags & MF_EXTERNAL_CERT))
-        {
-            if (options->cert_file)
-            {
-                msg(M_USAGE, "--cert and --management-external-cert are mu=
tually exclusive");
-            }
-            else if (!(options->management_flags & MF_EXTERNAL_KEY))
-            {
-                msg(M_USAGE, "--management-external-cert must be used with=
 --management-external-key");
-            }
-        }
-        else
 #ifdef ENABLE_CRYPTOAPI
         if (options->cryptoapi_cert)
         {
-            if (options->cert_file)
-            {
-                msg(M_USAGE, "Parameter --cert cannot be used when --crypt=
oapicert is also specified.");
-            }
-            if (options->priv_key_file)
-            {
-                msg(M_USAGE, "Parameter --key cannot be used when --crypto=
apicert is also specified.");
-            }
-            if (options->pkcs12_file)
-            {
-                msg(M_USAGE, "Parameter --pkcs12 cannot be used when --cry=
ptoapicert is also specified.");
-            }
-            if (options->management_flags & MF_EXTERNAL_KEY)
-            {
-                msg(M_USAGE, "Parameter --management-external-key cannot b=
e used when --cryptoapicert is also specified.");
-            }
-            if (options->management_flags & MF_EXTERNAL_CERT)
-            {
-                msg(M_USAGE, "Parameter --management-external-cert cannot =
be used when --cryptoapicert is also specified.");
-            }
+            const char use_err[] =3D "Parameter --%s cannot be used when -=
-cryptoapicert is also specified.";
+            MUST_BE_UNDEF(cert_file, "cert");
+            MUST_BE_UNDEF(priv_key_file, "key");
+            MUST_BE_UNDEF(pkcs12_file, "pkcs12");
+            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "ma=
nagement-external-key");
+            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_CERT, "m=
anagement-external-cert");
         }
         else
-#endif /* ifdef ENABLE_CRYPTOAPI */
+#endif
         if (options->pkcs12_file)
         {
 #ifdef ENABLE_CRYPTO_MBEDTLS
             msg(M_USAGE, "Parameter --pkcs12 cannot be used with the mbed =
TLS version of OpenVPN.");
 #else
-            if (options->ca_path)
-            {
-                msg(M_USAGE, "Parameter --capath cannot be used when --pkc=
s12 is also specified.");
-            }
-            if (options->cert_file)
-            {
-                msg(M_USAGE, "Parameter --cert cannot be used when --pkcs1=
2 is also specified.");
-            }
-            if (options->priv_key_file)
-            {
-                msg(M_USAGE, "Parameter --key cannot be used when --pkcs12=
 is also specified.");
-            }
-            if (options->management_flags & MF_EXTERNAL_KEY)
-            {
-                msg(M_USAGE, "Parameter --management-external-key cannot b=
e used when --pkcs12 is also specified.");
-            }
-            if (options->management_flags & MF_EXTERNAL_CERT)
-            {
-                msg(M_USAGE, "Parameter --management-external-cert cannot =
be used when --pkcs12 is also specified.");
-            }
+            const char use_err[] =3D "Parameter --%s cannot be used when -=
-pkcs12 is also specified.";
+            MUST_BE_UNDEF(ca_path, "capath");
+            MUST_BE_UNDEF(cert_file, "cert");
+            MUST_BE_UNDEF(priv_key_file, "key");
+            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_KEY, "ma=
nagement-external-key");
+            MUST_BE_FALSE(options->management_flags & MF_EXTERNAL_CERT, "m=
anagement-external-cert");
 #endif /* ifdef ENABLE_CRYPTO_MBEDTLS */
         }
-        else
+        else /* cert/key from none of pkcs11, pkcs12, cryptoapi */
         {
-#ifdef ENABLE_CRYPTO_MBEDTLS
-            if (options->ca_path)
+            if ((options->management_flags & MF_EXTERNAL_KEY) && options->=
priv_key_file)
             {
-                msg(M_USAGE, "Parameter --capath cannot be used with the m=
bed TLS version of OpenVPN.");
+                msg(M_USAGE, "--key and --management-external-key are mutu=
ally exclusive");
             }
-#endif  /* ifdef ENABLE_CRYPTO_MBEDTLS */
+            if ((options->management_flags & MF_EXTERNAL_CERT))
+            {
+                if (options->cert_file)
+                {
+                    msg(M_USAGE, "--cert and --management-external-cert ar=
e mutually exclusive");
+                }
+                else if (!(options->management_flags & MF_EXTERNAL_KEY))
+                {
+                    msg(M_USAGE, "--management-external-cert must be used =
with --management-external-key");
+                }
+            }
             if (pull)
             {

@@ -3049,55 +2918,51 @@
          * when in non-TLS mode.
          */

-#define MUST_BE_UNDEF(parm) if (options->parm !=3D defaults.parm) {msg(M_U=
SAGE, err, #parm); \
-}
+        const char use_err[] =3D "Parameter %s can only be specified in TL=
S-mode, "
+            "i.e. where --tls-server or --tls-client is also specified.";

-        const char err[] =3D "Parameter %s can only be specified in TLS-mo=
de, i.e. where --tls-server or --tls-client is also specified.";
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
@@ -3106,6 +2971,9 @@
     uninit_options(&defaults);
 }

+#undef MUST_BE_UNDEF
+#undef MUST_BE_FALSE
+
 static void
 options_postprocess_mutate_ce(struct options *o, struct connection_entry *=
ce)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/832?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4f766fa22865eaf4466c31cf55e3d73b00008c38
Gerrit-Change-Number: 832
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--rxfTALYXk9w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/832?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">options: Cleanup and simplify options_postprocess_verify_ce<b=
r><br>- Reuse the MUST_BE_UNDEF macro in more places<br>- Add a second para=
meter so it actually reports the<br>  correct option name<br>- Add MUST_BE_=
FALSE for similar cases<br>- Reorder the checks for cert/key options to mak=
e<br>  more sense. Some of the checks could have never<br>  fired due to wr=
ong placement of the management<br>  checks<br>- Some other small cleanups =
like missing spaces<br>  in multiline string literal<br><br>Change-Id: I4f7=
66fa22865eaf4466c31cf55e3d73b00008c38<br>Signed-off-by: Frank Lichtenheld &=
lt;frank@...2641...&gt;<br>---<br>M src/openvpn/options.c<br>1 file changed=
, 142 insertions(+), 274 deletions(-)<br><br></pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/32/832/1</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn=
/options.c b/src/openvpn/options.c</span><br><span>index d8dd518..d7f1a8f 1=
00644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src=
/openvpn/options.c</span><br><span>@@ -2300,6 +2300,13 @@</span><br><span> =
static void</span><br><span> check_ca_required(const struct options *option=
s)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#ifdef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (options-&gt;ca_path)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(M_USAGE, &quot;Parameter --capath cannot be used with the=
 mbed TLS version of OpenVPN.&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>     if (options-&gt;verify_hash_no_ca</span><br><span>         || =
options-&gt;pkcs12_file</span><br><span>         || options-&gt;ca_file</sp=
an><br><span>@@ -2319,6 +2326,11 @@</span><br><span>     msg(M_USAGE, &quot=
;%s&quot;, str);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define MUST_BE_UNDEF(parm, parm_name) \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;=
parm !=3D defaults.parm) { msg(M_USAGE, use_err, parm_name); }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define MUST_BE_FALSE(condition,=
 parm_name) \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (condition) { msg(M_USAGE, use_err, parm_name); }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><spa=
n> options_postprocess_verify_ce(const struct options *options,</span><br><=
span>                               const struct connection_entry *ce)</spa=
n><br><span>@@ -2555,6 +2567,8 @@</span><br><span>      */</span><br><span>=
     if (options-&gt;mode =3D=3D MODE_SERVER)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        const char use_err=
[] =3D &quot;--%s cannot be used with --mode server.&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #define USAGE_VAL=
ID_SERVER_PROTOS &quot;--mode server currently only supports &quot; \</span=
><br><span>     &quot;--proto values of udp, tcp-server, tcp4-server, or tc=
p6-server&quot;</span><br><span> #ifdef TARGET_ANDROID</span><br><span>@@ -=
2564,10 +2578,7 @@</span><br><span>         {</span><br><span>             =
msg(M_USAGE, &quot;--mode server only works with --dev tun or --dev tap&quo=
t;);</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (options-&gt;pull)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            msg(M_USAGE, &quot;--pull cannot be used with --mode serv=
er&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF=
(pull, &quot;pull&quot;);</span><br><span>         if (options-&gt;pull_fil=
ter_list)</span><br><span>         {</span><br><span>             msg(M_WAR=
N, &quot;--pull-filter ignored for --mode server&quot;);</span><br><span>@@=
 -2588,22 +2599,10 @@</span><br><span>         {</span><br><span>          =
   msg(M_USAGE, &quot;--mode server requires --tls-server&quot;);</span><br=
><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (ce-&gt;remote)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 msg(M_USAGE, &quot;--remote cannot be used with --mode server&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (!ce-&gt;bind_local)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot;--nobind =
cannot be used with --mode server&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (ce-&gt;http_proxy_options)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            msg(M_USAGE, &quot;--http-proxy cannot be used wit=
h --mode server&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (ce-&gt;socks_proxy_server)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       msg(M_USAGE, &quot;--socks-proxy cannot be used with --mode server&q=
uot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_FALSE(ce-=
&gt;remote, &quot;remote&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        MUST_BE_FALSE(!ce-&gt;bind_local, &quot;nobind&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_FAL=
SE(ce-&gt;http_proxy_options, &quot;http-proxy&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_FALSE(ce-&gt;socks_proxy=
_server, &quot;socks-proxy&quot;);</span><br><span>         /* &lt;connecti=
on&gt; blocks force to have a remote embedded, so we check</span><br><span>=
          * for the --remote and bail out if it is present</span><br><span>=
          */</span><br><span>@@ -2613,10 +2612,7 @@</span><br><span>       =
      msg(M_USAGE, &quot;&lt;connection&gt; cannot be used with --mode serv=
er&quot;);</span><br><span>         }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;shaper)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot;--shaper can=
not be used with --mode server&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        MUST_BE_UNDEF(shaper, &quot;shaper&quot;);</span><br><span> =
        if (options-&gt;ipchange)</span><br><span>         {</span><br><spa=
n>             msg(M_USAGE,</span><br><span>@@ -2639,14 +2635,8 @@</span><b=
r><span>         {</span><br><span>             msg(M_USAGE, &quot;--redire=
ct-gateway cannot be used with --mode server (however --push \&quot;redirec=
t-gateway\&quot; is fine)&quot;);</span><br><span>         }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;route_delay_=
defined)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAGE, =
&quot;--route-delay cannot be used with --mode server&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (options-&gt;up_delay)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot;--up-delay canno=
t be used with --mode server&quot;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        MUST_BE_UNDEF(route_delay_defined, &quot;route-delay&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF=
(up_delay, &quot;up-delay&quot;);</span><br><span>         if (!options-&gt=
;ifconfig_pool_defined</span><br><span>             &amp;&amp; !options-&gt=
;ifconfig_ipv6_pool_defined</span><br><span>             &amp;&amp; options=
-&gt;ifconfig_pool_persist_filename)</span><br><span>@@ -2658,10 +2648,7 @@=
</span><br><span>         {</span><br><span>             msg(M_USAGE, &quot=
;--ifconfig-ipv6-pool needs --ifconfig-ipv6&quot;);</span><br><span>       =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (option=
s-&gt;allow_recursive_routing)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         msg(M_USAGE, &quot;--allow-recursive-routing cannot be used with -=
-mode server&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUS=
T_BE_UNDEF(allow_recursive_routing, &quot;allow-recursive-routing&quot;);</=
span><br><span>         if (options-&gt;auth_user_pass_file)</span><br><spa=
n>         {</span><br><span>             msg(M_USAGE, &quot;--auth-user-pa=
ss cannot be used with --mode server (it should be used on the client side =
only)&quot;);</span><br><span>@@ -2683,23 +2670,19 @@</span><br><span>     =
            options-&gt;handshake_window);</span><br><span> </span><br><spa=
n>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (!options-&gt;auth_user_pass_verify_script</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            || PLUGIN_OPTION_LIST(options)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            || MAN_CLIENT=
_AUTH_ENABLED(options))</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            const bool ccnr =3D (options-&gt;a=
uth_user_pass_verify_script</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                               || PLUGIN_OPTION_LIST(options)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
  || MAN_CLIENT_AUTH_ENABLED(options));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            const char *postfix =3D &quot;must be used wi=
th --management-client-auth, an --auth-user-pass-verify script, or plugin&q=
uot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (=
(options-&gt;ssl_flags &amp; (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CER=
T_OPTIONAL)) &amp;&amp; !ccnr)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                msg(M_USAGE, &quot;--verify-client-cert none|optional %s&q=
uot;, postfix);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if=
 ((options-&gt;ssl_flags &amp; SSLF_USERNAME_AS_COMMON_NAME) &amp;&amp; !cc=
nr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_USAG=
E, &quot;--username-as-common-name %s&quot;, postfix);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            if ((options-&gt;ssl_flags &amp; SSLF_=
AUTH_USER_PASS_OPTIONAL) &amp;&amp; !ccnr)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                msg(M_USAGE, &quot;--auth-user-pass-optional %=
s&quot;, postfix);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   const char *use_err =3D &quot;--%s must be used with --management-client=
-auth, an --auth-user-pass-verify script, or plugin&quot;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            MUST_BE_FALSE(options-&gt;ssl_flags</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                          &=
amp; (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT_CERT_OPTIONAL),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                          &quot=
;verify-client-cert none|optional&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            MUST_BE_FALSE(options-&gt;ssl_flags &amp;=
 SSLF_USERNAME_AS_COMMON_NAME,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                          &quot;username-as-common-name&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            MUST_BE_=
FALSE(options-&gt;ssl_flags &amp; SSLF_AUTH_USER_PASS_OPTIONAL,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                          &quot=
;auth-user-pass-optional&quot;);</span><br><span>         }</span><br><span=
> </span><br><span>         if (options-&gt;vlan_tagging &amp;&amp; dev !=
=3D DEV_TYPE_TAP)</span><br><span>@@ -2708,125 +2691,65 @@</span><br><span>=
         }</span><br><span>         if (!options-&gt;vlan_tagging)</span><b=
r><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         if (options-&gt;vlan_accept !=3D defaults.vlan_accept)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                msg(M_USAGE, &quot;--vlan=
-accept requires --vlan-tagging&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            if (options-&gt;vlan_pvid !=3D defaults.vlan_pvid)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_USAGE, &qu=
ot;--vlan-pvid requires --vlan-tagging&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            const char use_err[] =3D &quot;--%s requires=
 --vlan-tagging&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            MUST_BE_UNDEF(vlan_accept, &quot;vlan-accept&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            MUST_BE_UNDEF(v=
lan_pvid, &quot;vlan-pvid&quot;);</span><br><span>         }</span><br><spa=
n>     }</span><br><span>     else</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        const char use_err[] =3D &quo=
t;--%s requires --mode server&quot;;</span><br><span>         /*</span><br>=
<span>          * When not in server mode, err if parameters are</span><br>=
<span>          * specified which require --mode server.</span><br><span>  =
        */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(options-&gt;ifconfig_pool_defined || options-&gt;ifconfig_pool_persist_fil=
ename)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAGE, &q=
uot;--ifconfig-pool/--ifconfig-pool-persist requires --mode server&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;ifconfig_i=
pv6_pool_defined)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(=
M_USAGE, &quot;--ifconfig-ipv6-pool requires --mode server&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;real_hash_size !=
=3D defaults.real_hash_size</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            || options-&gt;virtual_hash_size !=3D defaults.virtual_ha=
sh_size)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAGE, =
&quot;--hash-size requires --mode server&quot;);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (options-&gt;learn_address_script)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot;--learn-address r=
equires --mode server&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (options-&gt;client_connect_script)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            msg(M_USAGE, &quot;--client-connect requires --mode se=
rver&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (options-&=
gt;client_crresponse_script)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       msg(M_USAGE, &quot;--client-crresponse requires --mode server&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;client_d=
isconnect_script)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(=
M_USAGE, &quot;--client-disconnect requires --mode server&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;client_config_dir |=
| options-&gt;ccd_exclusive)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       msg(M_USAGE, &quot;--client-config-dir/--ccd-exclusive requires --mo=
de server&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (opti=
ons-&gt;enable_c2c)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ms=
g(M_USAGE, &quot;--client-to-client requires --mode server&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;duplicate_cn)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot;--dupli=
cate-cn requires --mode server&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (options-&gt;cf_max || options-&gt;cf_per)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot;--connect-freq requ=
ires --mode server&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (options-&gt;ssl_flags &amp; (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_CLIENT=
_CERT_OPTIONAL))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M=
_USAGE, &quot;--verify-client-cert requires --mode server&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;ssl_flags &amp; SSL=
F_USERNAME_AS_COMMON_NAME)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     msg(M_USAGE, &quot;--username-as-common-name requires --mode server&qu=
ot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;ssl_=
flags &amp; SSLF_AUTH_USER_PASS_OPTIONAL)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            msg(M_USAGE, &quot;--auth-user-pass-optional requires -=
-mode server&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (o=
ptions-&gt;ssl_flags &amp; SSLF_OPT_VERIFY)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            msg(M_USAGE, &quot;--opt-verify requires --mode serve=
r&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(=
ifconfig_pool_defined, &quot;ifconfig-pool&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(ifconfig_pool_persist_=
filename, &quot;ifconfig-pool-persist&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(ifconfig_ipv6_pool_defined,=
 &quot;ifconfig-ipv6-pool&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        MUST_BE_UNDEF(real_hash_size, &quot;hash-size&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UND=
EF(virtual_hash_size, &quot;hash-size&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(learn_address_script, &quot=
;learn-address&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        MUST_BE_UNDEF(client_connect_script, &quot;client-connect&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UN=
DEF(client_crresponse_script, &quot;client-crresponse&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(client_disc=
onnect_script, &quot;client-disconnect&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(client_config_dir, &quot;c=
lient-config-dir&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        MUST_BE_UNDEF(ccd_exclusive, &quot;ccd-exclusive&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(ena=
ble_c2c, &quot;client-to-client&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        MUST_BE_UNDEF(duplicate_cn, &quot;duplicate-cn&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST=
_BE_UNDEF(cf_max, &quot;connect-freq&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(cf_per, &quot;connect-freq&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_=
BE_FALSE(options-&gt;ssl_flags</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                      &amp; (SSLF_CLIENT_CERT_NOT_REQUIRED|SSLF_=
CLIENT_CERT_OPTIONAL),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                      &quot;verify-client-cert&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_FALSE(options-&gt;ssl=
_flags &amp; SSLF_USERNAME_AS_COMMON_NAME, &quot;username-as-common-name&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_B=
E_FALSE(options-&gt;ssl_flags &amp; SSLF_AUTH_USER_PASS_OPTIONAL, &quot;aut=
h-user-pass-optional&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        MUST_BE_FALSE(options-&gt;ssl_flags &amp; SSLF_OPT_VERIFY,=
 &quot;opt-verify&quot;);</span><br><span>         if (options-&gt;server_f=
lags &amp; SF_TCP_NODELAY_HELPER)</span><br><span>         {</span><br><spa=
n>             msg(M_WARN, &quot;WARNING: setting tcp-nodelay on the client=
 side will not &quot;</span><br><span>                 &quot;affect the ser=
ver. To have TCP_NODELAY in both direction use &quot;</span><br><span>     =
            &quot;tcp-nodelay in the server configuration instead.&quot;);<=
/span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (options-&gt;auth_user_pass_verify_script)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot;--auth-user-pass-ve=
rify requires --mode server&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (options-&gt;auth_token_generate)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            msg(M_USAGE, &quot;--auth-gen-token requires --mod=
e server&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE=
_UNDEF(auth_user_pass_verify_script, &quot;auth-user-pass-verify&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(=
auth_token_generate, &quot;auth-gen-token&quot;);</span><br><span> #if PORT=
_SHARE</span><br><span>         if (options-&gt;port_share_host || options-=
&gt;port_share_port)</span><br><span>         {</span><br><span>           =
  msg(M_USAGE, &quot;--port-share requires TCP server mode (--mode server -=
-proto tcp-server)&quot;);</span><br><span>         }</span><br><span> #end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;stale_routes_che=
ck_interval)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_USA=
GE, &quot;--stale-routes-check requires --mode server&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (options-&gt;vlan_tagging)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            msg(M_USAGE, &quot;--vlan-tagging requires --mode se=
rver&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (options-&gt;force_key_material=
_export)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_USAGE, =
&quot;--force-tls-key-material-export requires --mode server&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(stale_routes_che=
ck_interval, &quot;stale-routes-check&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(vlan_tagging, &quot;vlan-ta=
gging&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  MUST_BE_UNDEF(vlan_accept, &quot;vlan-accept&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(vlan_pvid, &quot;v=
lan-pvid&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     MUST_BE_UNDEF(force_key_material_export, &quot;force-key-material-expo=
rt&quot;);</span><br><span>     }</span><br><span> </span><br><span>     /*=
</span><br><span>      * SSL/TLS mode sanity checks.</span><br><span>      =
*/</span><br><span>     if (options-&gt;tls_server + options-&gt;tls_client=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        +(options-&gt=
;shared_secret_file !=3D NULL) &gt; 1)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        + (options-&gt;shared_secret_file !=3D NULL) &gt=
; 1)</span><br><span>     {</span><br><span>         msg(M_USAGE, &quot;spe=
cify only one of --tls-server, --tls-client, or --secret&quot;);</span><br>=
<span>     }</span><br><span>@@ -2843,9 +2766,9 @@</span><br><span>        =
     &quot;configuration detected. OpenVPN 2.8 will remove the &quot;</span=
><br><span>             &quot;functionality to run a VPN without TLS. &quot=
;</span><br><span>             &quot;See the examples section in the manual=
 page for &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       &quot;examples of a similar quick setup with peer-fingerprint.&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;e=
xamples of a similar quick setup with peer-fingerprint. &quot;</span><br><s=
pan>             &quot;OpenVPN 2.7 allows using this configuration when usi=
ng &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
&quot;--allow-deprecated-insecure-static-crypto but you should move&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;--a=
llow-deprecated-insecure-static-crypto but you should move &quot;</span><br=
><span>             &quot;to a proper configuration using TLS as soon as po=
ssible.&quot;</span><br><span>             );</span><br><span>     }</span>=
<br><span>@@ -2892,112 +2815,58 @@</span><br><span>             {</span><br=
><span>                 msg(M_USAGE, &quot;Parameter --pkcs11-id or --pkcs1=
1-id-management should be specified.&quot;);</span><br><span>             }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (optio=
ns-&gt;cert_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    msg(M_USAGE, &quot;Parameter --cert cannot be used when --pkcs11-provid=
er is also specified.&quot;);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            if (options-&gt;priv_key_file)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                msg(M_USAGE, &quot;Parameter --key cannot be u=
sed when --pkcs11-provider is also specified.&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            if (options-&gt;management_flags &amp; =
MF_EXTERNAL_KEY)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   msg(M_USAGE, &quot;Parameter --management-external-key cannot be used wh=
en --pkcs11-provider is also specified.&quot;);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            if (options-&gt;management_flags &amp; MF_EXT=
ERNAL_CERT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ms=
g(M_USAGE, &quot;Parameter --management-external-cert cannot be used when -=
-pkcs11-provider is also specified.&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            if (options-&gt;pkcs12_file)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                msg(M_USAGE, &quot;Parameter --pkc=
s12 cannot be used when --pkcs11-provider is also specified.&quot;);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_CRYPTOAPI</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            if (options-&gt;crypto=
api_cert)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(=
M_USAGE, &quot;Parameter --cryptoapicert cannot be used when --pkcs11-provi=
der is also specified.&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
const char use_err[] =3D &quot;Parameter --%s cannot be used when --pkcs11-=
provider is also specified.&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            MUST_BE_UNDE=
F(priv_key_file, &quot;key&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            MUST_BE_UNDEF(pkcs12_file, &quot;pkcs12&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            MUST_BE_=
FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_KEY, &quot;management-=
external-key&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            MUST_BE_FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_C=
ERT, &quot;management-external-cert&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            MUST_BE_UNDEF(cryptoapi_cert, &quot;cry=
ptoapicert&quot;);</span><br><span>         }</span><br><span>         else=
</span><br><span> #endif /* ifdef ENABLE_PKCS11 */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if ((options-&gt;management_flags &amp=
; MF_EXTERNAL_KEY) &amp;&amp; options-&gt;priv_key_file)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            msg(M_USAGE, &quot;--key and --managemen=
t-external-key are mutually exclusive&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        else if ((options-&gt;management_flags &amp; MF_EXTERNA=
L_CERT))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (options-&=
gt;cert_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
msg(M_USAGE, &quot;--cert and --management-external-cert are mutually exclu=
sive&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            else =
if (!(options-&gt;management_flags &amp; MF_EXTERNAL_KEY))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                msg(M_USAGE, &quot;--managemen=
t-external-cert must be used with --management-external-key&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        else</span><br><span> #ifdef ENABLE_CRYPT=
OAPI</span><br><span>         if (options-&gt;cryptoapi_cert)</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    if (options-&gt;cert_file)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                msg(M_USAGE, &quot;Parameter --cert cannot be used when --=
cryptoapicert is also specified.&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            if (options-&gt;priv_key_file)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                msg(M_USAGE, &quot;Parameter --key =
cannot be used when --cryptoapicert is also specified.&quot;);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            if (options-&gt;pkcs12_file)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_USAGE, &q=
uot;Parameter --pkcs12 cannot be used when --cryptoapicert is also specifie=
d.&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (opt=
ions-&gt;management_flags &amp; MF_EXTERNAL_KEY)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                msg(M_USAGE, &quot;Parameter --managemen=
t-external-key cannot be used when --cryptoapicert is also specified.&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (options-&gt=
;management_flags &amp; MF_EXTERNAL_CERT)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                msg(M_USAGE, &quot;Parameter --management-exter=
nal-cert cannot be used when --cryptoapicert is also specified.&quot;);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            const char use_err[=
] =3D &quot;Parameter --%s cannot be used when --cryptoapicert is also spec=
ified.&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            MUST_BE_UNDEF(priv_key_file, &quo=
t;key&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      MUST_BE_UNDEF(pkcs12_file, &quot;pkcs12&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            MUST_BE_FALSE(options-&gt;man=
agement_flags &amp; MF_EXTERNAL_KEY, &quot;management-external-key&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            MUST_BE_=
FALSE(options-&gt;management_flags &amp; MF_EXTERNAL_CERT, &quot;management=
-external-cert&quot;);</span><br><span>         }</span><br><span>         =
else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef E=
NABLE_CRYPTOAPI */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif</span><br><span>         if (options-&gt;pkcs12_file)</span><br><span=
>         {</span><br><span> #ifdef ENABLE_CRYPTO_MBEDTLS</span><br><span> =
            msg(M_USAGE, &quot;Parameter --pkcs12 cannot be used with the m=
bed TLS version of OpenVPN.&quot;);</span><br><span> #else</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            if (options-&gt;ca_path)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_USAGE, &q=
uot;Parameter --capath cannot be used when --pkcs12 is also specified.&quot=
;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (options-&g=
t;cert_file)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                m=
sg(M_USAGE, &quot;Parameter --cert cannot be used when --pkcs12 is also spe=
cified.&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if=
 (options-&gt;priv_key_file)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               msg(M_USAGE, &quot;Parameter --key cannot be used when --pkc=
s12 is also specified.&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            if (options-&gt;management_flags &amp; MF_EXTERNAL_KEY)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                msg(M_USAGE, &quot;P=
arameter --management-external-key cannot be used when --pkcs12 is also spe=
cified.&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if=
 (options-&gt;management_flags &amp; MF_EXTERNAL_CERT)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                msg(M_USAGE, &quot;Parameter --man=
agement-external-cert cannot be used when --pkcs12 is also specified.&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            const char us=
e_err[] =3D &quot;Parameter --%s cannot be used when --pkcs12 is also speci=
fied.&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     MUST_BE_UNDEF(ca_path, &quot;capath&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            MUST_BE_UNDEF(cert_file, &quot;cer=
t&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  MUST_BE_UNDEF(priv_key_file, &quot;key&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            MUST_BE_FALSE(options-&gt;manageme=
nt_flags &amp; MF_EXTERNAL_KEY, &quot;management-external-key&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            MUST_BE_FALSE=
(options-&gt;management_flags &amp; MF_EXTERNAL_CERT, &quot;management-exte=
rnal-cert&quot;);</span><br><span> #endif /* ifdef ENABLE_CRYPTO_MBEDTLS */=
</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       else /* cert/key from none of pkcs11, pkcs12, cryptoapi */</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef ENABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            if (options-&gt;ca_path)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if ((options-&gt;management_flags &amp; MF_=
EXTERNAL_KEY) &amp;&amp; options-&gt;priv_key_file)</span><br><span>       =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  msg(M_USAGE, &quot;Parameter --capath cannot be used with the mbed TLS ve=
rsion of OpenVPN.&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                msg(M_USAGE, &quot;--key and --management-external-ke=
y are mutually exclusive&quot;);</span><br><span>             }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif  /* ifdef ENABLE_CRYPTO_MB=
EDTLS */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if ((options-&gt;management_flags &amp; MF_EXTERNAL_CERT))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                if (options-&gt;cert_file=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
msg(M_USAGE, &quot;--cert and --management-external-cert are mutually exclu=
sive&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       else if (!(options-&gt;management_flags &amp; MF_EXTERNAL_KEY))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    msg(M_=
USAGE, &quot;--management-external-cert must be used with --management-exte=
rnal-key&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span>             if (pull)</span><br><span>           =
  {</span><br><span> </span><br><span>@@ -3049,55 +2918,51 @@</span><br><sp=
an>          * when in non-TLS mode.</span><br><span>          */</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define MUST_=
BE_UNDEF(parm) if (options-&gt;parm !=3D defaults.parm) {msg(M_USAGE, err, =
#parm); \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        const char use_err[] =
=3D &quot;Parameter %s can only be specified in TLS-mode, &quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            &quot;i.e. where -=
-tls-server or --tls-client is also specified.&quot;;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char err[] =
=3D &quot;Parameter %s can only be specified in TLS-mode, i.e. where --tls-=
server or --tls-client is also specified.&quot;;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        MUST_BE_UNDEF(ca_file);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        MUST_BE_UNDEF(ca_path);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(dh_file);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(cert_file);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(priv_=
key_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        M=
UST_BE_UNDEF(ca_file, &quot;ca&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        MUST_BE_UNDEF(ca_path, &quot;capath&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(dh=
_file, &quot;dh&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        MUST_BE_UNDEF(cert_file, &quot;cert&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(priv_key_file, &q=
uot;key&quot;);</span><br><span> #ifndef ENABLE_CRYPTO_MBEDTLS</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(pkcs12_file)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UN=
DEF(pkcs12_file, &quot;pkcs12&quot;);</span><br><span> #endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(cipher_list);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF=
(cipher_list_tls13);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       MUST_BE_UNDEF(tls_cert_profile);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_verify);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_export_peer_cert_=
dir);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_=
UNDEF(verify_x509_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        MUST_BE_UNDEF(tls_timeout);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        MUST_BE_UNDEF(renegotiate_bytes);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(renegotiate_pack=
ets);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_=
UNDEF(renegotiate_seconds);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        MUST_BE_UNDEF(handshake_window);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(transition_window);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(tls_auth=
_file);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_B=
E_UNDEF(tls_crypt_file);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        MUST_BE_UNDEF(tls_crypt_v2_file);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(single_session);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(push_peer_inf=
o);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UN=
DEF(tls_exit);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 MUST_BE_UNDEF(crl_file);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        MUST_BE_UNDEF(ns_cert_type);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        MUST_BE_UNDEF(remote_cert_ku[0]);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(remote_cert_ek=
u);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_=
UNDEF(cipher_list, &quot;tls-cipher&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(cipher_list_tls13, &quot;tls-=
ciphersuites&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        MUST_BE_UNDEF(tls_cert_profile, &quot;tls-cert-profile&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(t=
ls_verify, &quot;tls-verify&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        MUST_BE_UNDEF(tls_export_peer_cert_dir, &quot;tls-e=
xport-cert&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       MUST_BE_UNDEF(verify_x509_name, &quot;verify-x509-name&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(tls=
_timeout, &quot;tls-timeout&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        MUST_BE_UNDEF(renegotiate_bytes, &quot;reneg-bytes&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST=
_BE_UNDEF(renegotiate_packets, &quot;reneg-pkts&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(renegotiate_secon=
ds, &quot;reneg-sec&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        MUST_BE_UNDEF(handshake_window, &quot;hand-window&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF=
(transition_window, &quot;tran-window&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(tls_auth_file, &quot;tls-au=
th&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        M=
UST_BE_UNDEF(tls_crypt_file, &quot;tls-crypt&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(tls_crypt_v2_file, =
&quot;tls-crypt-v2&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        MUST_BE_UNDEF(single_session, &quot;single-session&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF=
(push_peer_info, &quot;push-peer-info&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(tls_exit, &quot;tls-exit&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_B=
E_UNDEF(crl_file, &quot;crl-verify&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(ns_cert_type, &quot;ns-cert-ty=
pe&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        M=
UST_BE_UNDEF(remote_cert_ku[0], &quot;remote-cert-ku&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(remote_cert_=
eku, &quot;remote-cert-eku&quot;);</span><br><span> #ifdef ENABLE_PKCS11</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(pk=
cs11_providers[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      MUST_BE_UNDEF(pkcs11_private_mode[0]);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(pkcs11_id);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        MUST_BE_UNDEF(pkcs11_id_manageme=
nt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE=
_UNDEF(pkcs11_providers[0], &quot;pkcs11-providers&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(pkcs11_private=
_mode[0], &quot;pkcs11-private-mode&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(pkcs11_id, &quot;pkcs11-id&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_B=
E_UNDEF(pkcs11_id_management, &quot;pkcs11-id-management&quot;);</span><br>=
<span> #endif</span><br><span> </span><br><span>         if (pull)</span><b=
r><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         msg(M_USAGE, err, &quot;--pull&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            msg(M_USAGE, use_err, &quot;--pull&=
quot;);</span><br><span>         }</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#undef MUST_BE_UNDEF</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (options-&gt;au=
th_user_pass_file &amp;&amp; !options-&gt;pull)</span><br><span>     {</spa=
n><br><span>         msg(M_USAGE, &quot;--auth-user-pass requires --pull&qu=
ot;);</span><br><span>@@ -3106,6 +2971,9 @@</span><br><span>     uninit_opt=
ions(&amp;defaults);</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#undef MUST_BE_UNDEF</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#undef MUST_BE_FALSE</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span=
><br><span> options_postprocess_mutate_ce(struct options *o, struct connect=
ion_entry *ce)</span><br><span> {</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/832?usp=3Demail"=
>change 832</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/832?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4f766fa22865eaf4466c31cf55e=
3d73b00008c38 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 832 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--rxfTALYXk9w=--

