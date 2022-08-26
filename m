From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 26 Aug 2022 10:54:23 +0200
Message-Id: <20220826085427.25302-3-frank@...2641...>
In-Reply-To: <20220826085427.25302-1-frank@...2641...>
References: <20220826085427.25302-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/6] reformat for sp_compare=add
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

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 config-msvc.h                                    |  2 +-
 .../client-connect/sample-client-connect.c       |  2 +-
 src/openvpn/crypto.c                             |  4 ++--
 src/openvpn/crypto_mbedtls.c                     |  2 +-
 src/openvpn/init.c                               |  2 +-
 src/openvpn/integer.h                            |  4 ++--
 src/openvpn/manage.c                             |  8 ++++----
 src/openvpn/ntlm.c                               |  4 ++--
 src/openvpn/options.c                            | 14 +++++++-------
 src/openvpn/pkcs11.c                             | 16 ++++++++--------
 src/openvpn/pkcs11_openssl.c                     |  2 +-
 src/openvpn/ps.c                                 |  2 +-
 src/openvpn/route.c                              |  2 +-
 src/openvpn/socket.c                             | 10 +++++-----
 src/openvpn/socks.c                              |  4 ++--
 src/openvpn/ssl_ncp.c                            |  4 ++--
 src/openvpn/ssl_verify.c                         |  2 +-
 src/openvpn/ssl_verify_mbedtls.c                 |  2 +-
 src/openvpn/ssl_verify_openssl.c                 |  2 +-
 src/openvpn/tun.c                                | 16 ++++++++--------
 src/openvpn/xkey_provider.c                      |  2 +-
 tests/unit_tests/openvpn/test_pkt.c              |  2 +-
 22 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/config-msvc.h b/config-msvc.h
index b621f3fb..e777fe07 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -56,7 +56,7 @@
 #define strncasecmp strnicmp
 #define strcasecmp _stricmp
 
-#if _MSC_VER<1900
+#if _MSC_VER < 1900
 #define snprintf _snprintf
 #endif
 
diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b/sample/sample-plugins/client-connect/sample-client-connect.c
index bd691a94..27d676ef 100644
--- a/sample/sample-plugins/client-connect/sample-client-connect.c
+++ b/sample/sample-plugins/client-connect/sample-client-connect.c
@@ -350,7 +350,7 @@ openvpn_plugin_client_connect(struct plugin_context *context,
     /* log environment variables handed to us by OpenVPN, but
      * only if "setenv verb" is 3 or higher (arbitrary number)
      */
-    if (context->verb>=3)
+    if (context->verb >= 3)
     {
         for (int i = 0; argv[i]; i++)
         {
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 9e10f64e..397f4cdb 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1411,7 +1411,7 @@ write_key_file(const int nkeys, const char *filename)
     buf_printf(&out, "%s\n", static_key_foot);
 
     /* write key file to stdout if no filename given */
-    if (!filename || strcmp(filename, "")==0)
+    if (!filename || strcmp(filename, "") == 0)
     {
         printf("%.*s\n", BLEN(&out), BPTR(&out));
     }
@@ -1738,7 +1738,7 @@ write_pem_key_file(const char *filename, const char *pem_name)
         goto cleanup;
     }
 
-    if (!filename || strcmp(filename, "")==0)
+    if (!filename || strcmp(filename, "") == 0)
     {
         printf("%.*s", BLEN(&server_key_pem), BPTR(&server_key_pem));
     }
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index da4ed980..2c748f7c 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -1105,7 +1105,7 @@ ssl_tls1_PRF(const uint8_t *label, int label_len, const uint8_t *sec,
     tls1_P_hash(md5, S1, len, label, label_len, out1, olen);
     tls1_P_hash(sha1, S2, len, label, label_len, out2, olen);
 
-    for (int i = 0; i<olen; i++)
+    for (int i = 0; i < olen; i++)
     {
         out1[i] ^= out2[i];
     }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9917cefe..907c975f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -677,7 +677,7 @@ context_init_1(struct context *c)
     {
         int i;
         pkcs11_initialize(true, c->options.pkcs11_pin_cache_period);
-        for (i = 0; i<MAX_PARMS && c->options.pkcs11_providers[i] != NULL; i++)
+        for (i = 0; i < MAX_PARMS && c->options.pkcs11_providers[i] != NULL; i++)
         {
             pkcs11_addProvider(c->options.pkcs11_providers[i], c->options.pkcs11_protected_authentication[i],
                                c->options.pkcs11_private_mode[i], c->options.pkcs11_cert_private[i]);
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index b1612045..5b2ee631 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -27,12 +27,12 @@
 #include "error.h"
 
 #ifndef htonll
-#define htonll(x) ((1==htonl(1)) ? (x) : \
+#define htonll(x) ((1 == htonl(1)) ? (x) : \
                    ((uint64_t)htonl((x) & 0xFFFFFFFF) << 32) | htonl((x) >> 32))
 #endif
 
 #ifndef ntohll
-#define ntohll(x) ((1==ntohl(1)) ? (x) : \
+#define ntohll(x) ((1 == ntohl(1)) ? (x) : \
                    ((uint64_t)ntohl((x) & 0xFFFFFFFF) << 32) | ntohl((x) >> 32))
 #endif
 
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 5670e594..43048eb9 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2111,7 +2111,7 @@ management_android_control(struct management *man, const char *command, const ch
     strncpy(up.username, msg, sizeof(up.username)-1);
 
     management_query_user_pass(management, &up, command, GET_USER_PASS_NEED_OK, (void *) 0);
-    return strcmp("ok", up.password)==0;
+    return strcmp("ok", up.password) == 0;
 }
 
 /*
@@ -2435,7 +2435,7 @@ man_settings_init(struct man_settings *ms,
 
                 status = openvpn_getaddrinfo(resolve_flags, addr, port, 0,
                                              NULL, AF_UNSPEC, &ms->local);
-                ASSERT(status==0);
+                ASSERT(status == 0);
             }
         }
 
@@ -2848,7 +2848,7 @@ management_notify_client_needing_auth(struct management *management,
         }
         msg(M_CLIENT, ">CLIENT:%s,%lu,%u", mode, mdac->cid, mda_key_id);
         man_output_extra_env(management, "CLIENT");
-        if (management->connection.env_filter_level>0)
+        if (management->connection.env_filter_level > 0)
         {
             man_output_peer_info_env(management, mdac);
         }
@@ -2969,7 +2969,7 @@ management_post_tunnel_open(struct management *man, const in_addr_t tun_local_ip
         ia.s_addr = htonl(tun_local_ip);
         ret = openvpn_getaddrinfo(GETADDR_PASSIVE, inet_ntoa(ia), NULL, 0, NULL,
                                   AF_INET, &man->settings.local);
-        ASSERT(ret==0);
+        ASSERT(ret == 0);
         man_connection_init(man);
     }
 
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 72c13130..ddd725bd 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -122,7 +122,7 @@ gen_nonce(unsigned char *nonce)
     /* Generates 8 random bytes to be used as client nonce */
     int i;
 
-    for (i = 0; i<8; i++)
+    for (i = 0; i < 8; i++)
     {
         nonce[i] = (unsigned char)get_random();
     }
@@ -263,7 +263,7 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2,
      * therefore buf2 needs to be (3/4 * 128) */
 
     /* extract the challenge from bytes 24-31 */
-    for (i = 0; i<8; i++)
+    for (i = 0; i < 8; i++)
     {
         challenge[i] = buf2[i+24];
     }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a296086d..e866c57d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1976,7 +1976,7 @@ show_settings(const struct options *o)
     SHOW_INT(ns_cert_type);
     {
         int i;
-        for (i = 0; i<MAX_PARMS; i++)
+        for (i = 0; i < MAX_PARMS; i++)
         {
             SHOW_INT(remote_cert_ku[i]);
         }
@@ -2019,28 +2019,28 @@ show_settings(const struct options *o)
 #ifdef ENABLE_PKCS11
     {
         int i;
-        for (i = 0; i<MAX_PARMS && o->pkcs11_providers[i] != NULL; i++)
+        for (i = 0; i < MAX_PARMS && o->pkcs11_providers[i] != NULL; i++)
         {
             SHOW_PARM(pkcs11_providers, o->pkcs11_providers[i], "%s");
         }
     }
     {
         int i;
-        for (i = 0; i<MAX_PARMS; i++)
+        for (i = 0; i < MAX_PARMS; i++)
         {
             SHOW_PARM(pkcs11_protected_authentication, o->pkcs11_protected_authentication[i] ? "ENABLED" : "DISABLED", "%s");
         }
     }
     {
         int i;
-        for (i = 0; i<MAX_PARMS; i++)
+        for (i = 0; i < MAX_PARMS; i++)
         {
             SHOW_PARM(pkcs11_private_mode, o->pkcs11_private_mode[i], "%08x");
         }
     }
     {
         int i;
-        for (i = 0; i<MAX_PARMS; i++)
+        for (i = 0; i < MAX_PARMS; i++)
         {
             SHOW_PARM(pkcs11_cert_private, o->pkcs11_cert_private[i] ? "ENABLED" : "DISABLED", "%s");
         }
@@ -2556,7 +2556,7 @@ options_postprocess_verify_ce(const struct options *options,
         /* <connection> blocks force to have a remote embedded, so we check
          * for the --remote and bail out if it is present
          */
-        if (options->connection_list->len >1
+        if (options->connection_list->len > 1
             || options->connection_list->array[0]->remote)
         {
             msg(M_USAGE, "<connection> cannot be used with --mode server");
@@ -6063,7 +6063,7 @@ add_option(struct options *options,
         for (j = 1; p[j]; j++)
         {
             /* Allow the user to specify ignore-unknown-option --opt too */
-            if (p[j][0]=='-' && p[j][1]=='-')
+            if (p[j][0] == '-' && p[j][1] == '-')
             {
                 options->ignore_unknown_option[i] = (p[j]+2);
             }
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 507af17c..7cf04335 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -198,7 +198,7 @@ _pkcs11_openvpn_token_prompt(
     (void)user_data;
     (void)retry;
 
-    ASSERT(token!=NULL);
+    ASSERT(token != NULL);
 
     CLEAR(token_resp);
     token_resp.defined = false;
@@ -245,7 +245,7 @@ _pkcs11_openvpn_pin_prompt(
     (void)user_data;
     (void)retry;
 
-    ASSERT(token!=NULL);
+    ASSERT(token != NULL);
 
     openvpn_snprintf(prompt, sizeof(prompt), "%s token", token->label);
 
@@ -381,7 +381,7 @@ pkcs11_addProvider(
 {
     CK_RV rv = CKR_OK;
 
-    ASSERT(provider!=NULL);
+    ASSERT(provider != NULL);
 
     dmsg(
         D_PKCS11_DEBUG,
@@ -495,8 +495,8 @@ pkcs11_management_id_get(
     int count = 0;
     bool success = false;
 
-    ASSERT(id!=NULL);
-    ASSERT(base64!=NULL);
+    ASSERT(id != NULL);
+    ASSERT(base64 != NULL);
 
     dmsg(
         D_PKCS11_DEBUG,
@@ -662,8 +662,8 @@ tls_ctx_use_pkcs11(
 
     bool ok = false;
 
-    ASSERT(ssl_ctx!=NULL);
-    ASSERT(pkcs11_id_management || pkcs11_id!=NULL);
+    ASSERT(ssl_ctx != NULL);
+    ASSERT(pkcs11_id_management || pkcs11_id != NULL);
 
     dmsg(
         D_PKCS11_DEBUG,
@@ -795,7 +795,7 @@ _pkcs11_openvpn_show_pkcs11_ids_pin_prompt(
     (void)user_data;
     (void)retry;
 
-    ASSERT(token!=NULL);
+    ASSERT(token != NULL);
 
     buf_printf(&pass_prompt, "Please enter '%s' token PIN or 'cancel': ", token->display);
     if (!query_user_SINGLE(BSTR(&pass_prompt), BLEN(&pass_prompt),
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 60bc1c47..8b594346 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -433,7 +433,7 @@ pkcs11_certificate_serial(pkcs11h_certificate_t certificate, char *serial,
     i2a_ASN1_INTEGER(bio, X509_get_serialNumber(x509));
     n = BIO_read(bio, serial, serial_len-1);
 
-    if (n<0)
+    if (n < 0)
     {
         serial[0] = '\x0';
     }
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index a69da2f9..20a62681 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -839,7 +839,7 @@ port_share_open(const char *host,
 
     status = openvpn_getaddrinfo(GETADDR_RESOLVE|GETADDR_FATAL,
                                  host, port,  0, NULL, AF_INET, &ai);
-    ASSERT(status==0);
+    ASSERT(status == 0);
     hostaddr = *((struct sockaddr_in *) ai->ai_addr);
     freeaddrinfo(ai);
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 7eaf1121..5d9bd7ca 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -739,7 +739,7 @@ route_ipv6_match_host( const struct route_ipv6 *r6,
     int i;
     unsigned int mask;
 
-    if (bits>128)
+    if (bits > 128)
     {
         return false;
     }
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 4e29327b..b0f84647 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -191,7 +191,7 @@ getaddr(unsigned int flags,
     status = get_addr_generic(AF_INET, flags, hostname, &addr, NULL,
                               resolve_retry_seconds, signal_received,
                               M_WARN);
-    if (status==0)
+    if (status == 0)
     {
         if (succeeded)
         {
@@ -1679,7 +1679,7 @@ resolve_bind_local(struct link_socket *sock, const sa_family_t af)
                                          NULL, af, &sock->info.lsa->bind_local);
         }
 
-        if (status !=0)
+        if (status != 0)
         {
             msg(M_FATAL, "getaddrinfo() failed for local \"%s:%s\": %s",
                 sock->local_host, sock->local_port,
@@ -1781,7 +1781,7 @@ resolve_remote(struct link_socket *sock,
                     goto done;
                 }
             }
-            if (status!=0)
+            if (status != 0)
             {
                 if (signal_received)
                 {
@@ -2780,7 +2780,7 @@ print_sockaddr_ex(const struct sockaddr *sa,
     status = getnameinfo(sa, salen, hostaddr, sizeof(hostaddr),
                          servname, sizeof(servname), NI_NUMERICHOST | NI_NUMERICSERV);
 
-    if (status!=0)
+    if (status != 0)
     {
         buf_printf(&out, "[nameinfo() err: %s]", gai_strerror(status));
         return BSTR(&out);
@@ -2950,7 +2950,7 @@ add_in6_addr( struct in6_addr base, uint32_t add )
 {
     int i;
 
-    for (i = 15; i>=0 && add > 0; i--)
+    for (i = 15; i >= 0 && add > 0; i--)
     {
         register int carry;
         register uint32_t h;
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index ef178a35..d857f632 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -428,7 +428,7 @@ port_from_servname(const char *servname)
 {
     int port = 0;
     port = atoi(servname);
-    if (port >0 && port < 65536)
+    if (port > 0 && port < 65536)
     {
         return port;
     }
@@ -471,7 +471,7 @@ establish_socks_proxy_passthru(struct socks_proxy_info *p,
     memcpy(buf + 5, host, len);
 
     int port = port_from_servname(servname);
-    if (port ==0)
+    if (port == 0)
     {
         msg(D_LINK_ERRORS, "establish_socks_proxy_passthrough: Cannot convert %s to port number", servname);
         goto error;
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index a58ced53..08e1a670 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -146,7 +146,7 @@ mutate_ncp_cipher_list(const char *list, struct gc_arena *gc)
                 ovpn_cipher_name = "none";
             }
 
-            if (buf_len(&new_list)> 0)
+            if (buf_len(&new_list) > 0)
             {
                 /* The next if condition ensure there is always space for
                  * a :
@@ -226,7 +226,7 @@ tls_peer_ncp_list(const char *peer_info, struct gc_arena *gc)
     {
         return iv_ciphers;
     }
-    else if (tls_peer_info_ncp_ver(peer_info)>=2)
+    else if (tls_peer_info_ncp_ver(peer_info) >= 2)
     {
         /* If the peer announces IV_NCP=2 then it supports the AES GCM
          * ciphers */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 45eaf8ed..147ff67b 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1569,7 +1569,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
 
     /* check sizing of username if it will become our common name */
     if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
-        && strlen(up->username)>TLS_USERNAME_LEN)
+        && strlen(up->username) > TLS_USERNAME_LEN)
     {
         msg(D_TLS_ERRORS,
             "TLS Auth Error: --username-as-common name specified and username is longer than the maximum permitted Common Name length of %d characters",
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index 5463c8da..b2af70c2 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -477,7 +477,7 @@ x509_verify_cert_ku(mbedtls_x509_crt *cert, const unsigned *const expected_ku,
     }
 
     result_t fFound = FAILURE;
-    for (size_t i = 0; SUCCESS != fFound && i<expected_len; i++)
+    for (size_t i = 0; SUCCESS != fFound && i < expected_len; i++)
     {
         if (expected_ku[i] != 0
             && 0 == mbedtls_x509_crt_check_key_usage(cert, expected_ku[i]))
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 78efa70a..0a879f2e 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -150,7 +150,7 @@ extract_x509_extension(X509 *cert, char *fieldname, char *out, int size)
         numalts = sk_GENERAL_NAME_num(extensions);
 
         /* loop through all alternatives */
-        for (i = 0; i<numalts; i++)
+        for (i = 0; i < numalts; i++)
         {
             /* get a handle to alternative name number i */
             const GENERAL_NAME *name = sk_GENERAL_NAME_value(extensions, i );
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 94803acd..9d789408 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -2057,7 +2057,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
     int android_method = managment_android_persisttun_action(management);
 
-    if (oldtunfd >=0  && android_method == ANDROID_KEEP_OLD_TUN)
+    if (oldtunfd >= 0  && android_method == ANDROID_KEEP_OLD_TUN)
     {
         /* keep the old fd */
         opentun = true;
@@ -2486,7 +2486,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
         {
             msg(M_ERR, "Can't set PPA %d", ppa);
         }
-        if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) <0)
+        if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0)
         {
             msg(M_ERR, "Can't get flags\n");
         }
@@ -3257,7 +3257,7 @@ open_darwin_utun(const char *dev, const char *dev_type, const char *dev_node, st
             fd = utun_open_helper(ctlInfo, utunnum);
             /* Break if the fd is valid,
              * or if early initialization failed (-2) */
-            if (fd !=-1)
+            if (fd != -1)
             {
                 break;
             }
@@ -3296,13 +3296,13 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 {
 #ifdef HAVE_NET_IF_UTUN_H
     /* If dev_node does not start start with utun assume regular tun/tap */
-    if ((!dev_node && tt->type==DEV_TYPE_TUN)
+    if ((!dev_node && tt->type == DEV_TYPE_TUN)
         || (dev_node && !strncmp(dev_node, "utun", 4)))
     {
 
         /* Check if user has specific dev_type tap and forced utun with
          * dev-node utun */
-        if (tt->type!=DEV_TYPE_TUN)
+        if (tt->type != DEV_TYPE_TUN)
         {
             msg(M_FATAL, "Cannot use utun devices with --dev-type %s",
                 dev_type_string(dev, dev_type));
@@ -3336,7 +3336,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
          * Unset dev_node variable prior to passing to open_tun_generic to
          * let open_tun_generic pick the first available tun device */
 
-        if (dev_node && strcmp(dev_node, "tun")==0)
+        if (dev_node && strcmp(dev_node, "tun") == 0)
         {
             dev_node = NULL;
         }
@@ -3425,7 +3425,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
     if (strcmp( dev, "tap" ) == 0)              /* find first free tap dev */
     {                                           /* (= no /dev/tapN node) */
         int i;
-        for (i = 0; i<99; i++)
+        for (i = 0; i < 99; i++)
         {
             openvpn_snprintf(tunname, sizeof(tunname), "/dev/tap%d", i);
             if (access( tunname, F_OK ) < 0 && errno == ENOENT)
@@ -5423,7 +5423,7 @@ netsh_set_dns6_servers(const struct in6_addr *addr_list,
         }
 
         /* Treat errors while adding as non-fatal as we do not check for duplicates */
-        netsh_command(&argv, 1, (i==0) ? M_FATAL : M_NONFATAL);
+        netsh_command(&argv, 1, (i == 0) ? M_FATAL : M_NONFATAL);
     }
 
     argv_free(&argv);
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index c6965718..5f442213 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -278,7 +278,7 @@ keymgmt_import(void *keydata, int selection, const OSSL_PARAM params[], const ch
     EVP_PKEY_CTX *ctx = EVP_PKEY_CTX_new_from_name(key->prov->libctx, name, NULL);
     if (!ctx
         || (EVP_PKEY_fromdata_init(ctx) != 1)
-        || (EVP_PKEY_fromdata(ctx, &pkey, selection_pub, (OSSL_PARAM *) params) !=1))
+        || (EVP_PKEY_fromdata(ctx, &pkey, selection_pub, (OSSL_PARAM *) params) != 1))
     {
         msg(M_WARN, "Error: keymgmt_import failed for key type <%s>", name);
         if (pkey)
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 2d771e30..5dce6b62 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -231,7 +231,7 @@ test_tls_decrypt_lite_crypt(void **ut_state)
     free_tls_pre_decrypt_state(&state);
 
     /* flip a byte in various places */
-    for (int i = 0; i<sizeof(client_reset_v2_tls_crypt); i++)
+    for (int i = 0; i < sizeof(client_reset_v2_tls_crypt); i++)
     {
         buf_reset_len(&buf);
         buf_write(&buf, client_reset_v2_tls_crypt, sizeof(client_reset_v2_tls_crypt));
-- 
2.34.1


