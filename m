From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 19 May 2022 10:54:27 +0200
Message-Id: <20220519085428.6783-2-frank@...2641...>
In-Reply-To: <20220519085428.6783-1-frank@...2641...>
References: <20220519085428.6783-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Reformat for sp_after_comma=add
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

It is our usual style.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 .../client-connect/sample-client-connect.c    |  2 +-
 .../keyingmaterialexporter.c                  |  2 +-
 src/compat/compat-versionhelpers.h            |  8 ++++----
 src/openvpn/buffer.c                          |  2 +-
 src/openvpn/comp-lz4.c                        |  4 ++--
 src/openvpn/crypto_mbedtls.c                  |  2 +-
 src/openvpn/cryptoapi.c                       |  2 +-
 src/openvpn/list.c                            |  2 +-
 src/openvpn/manage.c                          |  8 ++++----
 src/openvpn/mtu.c                             |  4 ++--
 src/openvpn/networking_sitnl.c                |  2 +-
 src/openvpn/options.c                         |  8 ++++----
 src/openvpn/pkcs11_openssl.c                  |  2 +-
 src/openvpn/pool.c                            |  2 +-
 src/openvpn/ps.c                              |  2 +-
 src/openvpn/route.c                           |  2 +-
 src/openvpn/run_command.c                     |  2 +-
 src/openvpn/socket.c                          | 12 +++++------
 src/openvpn/socket.h                          |  2 +-
 src/openvpn/ssl_ncp.c                         |  2 +-
 src/openvpn/ssl_openssl.c                     | 10 +++++-----
 src/openvpn/ssl_verify_openssl.c              |  2 +-
 src/openvpn/syshead.h                         |  4 ++--
 src/openvpn/win32.h                           |  2 +-
 src/openvpn/xkey_helper.c                     |  4 ++--
 src/openvpn/xkey_provider.c                   |  4 ++--
 src/plugins/auth-pam/utils.c                  |  8 ++++----
 tests/unit_tests/openvpn/test_ncp.c           |  4 ++--
 tests/unit_tests/openvpn/test_pkt.c           |  6 +++---
 tests/unit_tests/openvpn/test_provider.c      |  2 +-
 .../auth-pam/test_search_and_replace.c        | 20 +++++++++----------
 31 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b/sample/sample-plugins/client-connect/sample-client-connect.c
index cd6db870..bd691a94 100644
--- a/sample/sample-plugins/client-connect/sample-client-connect.c
+++ b/sample/sample-plugins/client-connect/sample-client-connect.c
@@ -210,7 +210,7 @@ write_cc_options_file(const char *name, const char **envp)
         return OPENVPN_PLUGIN_FUNC_SUCCESS;
     }
 
-    FILE *fp = fopen(name,"w");
+    FILE *fp = fopen(name, "w");
     if (!fp)
     {
         plugin_log(PLOG_ERR, MODULE, "fopen('%s') failed", name);
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
index 16648a3e..63c10fb5 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter.c
@@ -105,7 +105,7 @@ openvpn_plugin_open_v3(const int version,
     plugin->mask  = OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_FINAL);
     plugin->mask |= OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_VERIFY);
 
-    ovpn_note("vpn endpoint type=%s",plugin->type == CLIENT ? "client" : "server");
+    ovpn_note("vpn endpoint type=%s", plugin->type == CLIENT ? "client" : "server");
 
     rv->type_mask = plugin->mask;
     rv->handle = (void *)plugin;
diff --git a/src/compat/compat-versionhelpers.h b/src/compat/compat-versionhelpers.h
index 27d65559..b071602b 100644
--- a/src/compat/compat-versionhelpers.h
+++ b/src/compat/compat-versionhelpers.h
@@ -25,11 +25,11 @@
 VERSIONHELPERAPI
 IsWindowsVersionOrGreater(WORD major, WORD minor, WORD servpack)
 {
-    OSVERSIONINFOEXW vi = {sizeof(vi),major,minor,0,0,{0},servpack};
+    OSVERSIONINFOEXW vi = {sizeof(vi), major, minor, 0, 0, {0}, servpack};
     return VerifyVersionInfoW(&vi, VER_MAJORVERSION|VER_MINORVERSION|VER_SERVICEPACKMAJOR,
                               VerSetConditionMask(VerSetConditionMask(VerSetConditionMask(0,
-                                                                                          VER_MAJORVERSION,VER_GREATER_EQUAL),
-                                                                      VER_MINORVERSION,VER_GREATER_EQUAL),
+                                                                                          VER_MAJORVERSION, VER_GREATER_EQUAL),
+                                                                      VER_MINORVERSION, VER_GREATER_EQUAL),
                                                   VER_SERVICEPACKMAJOR, VER_GREATER_EQUAL));
 }
 
@@ -108,7 +108,7 @@ IsWindows10OrGreater()
 VERSIONHELPERAPI
 IsWindowsServer(void)
 {
-    OSVERSIONINFOEXW vi = {sizeof(vi),0,0,0,0,{0},0,0,0,VER_NT_WORKSTATION};
+    OSVERSIONINFOEXW vi = {sizeof(vi), 0, 0, 0, 0, {0}, 0, 0, 0, VER_NT_WORKSTATION};
     return !VerifyVersionInfoW(&vi, VER_PRODUCT_TYPE, VerSetConditionMask(0, VER_PRODUCT_TYPE, VER_EQUAL));
 }
 
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index c516426b..575d45a1 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -273,7 +273,7 @@ buf_puts(struct buffer *buf, const char *str)
     int cap = buf_forward_capacity(buf);
     if (cap > 0)
     {
-        strncpynt((char *)ptr,str, cap);
+        strncpynt((char *)ptr, str, cap);
         *(buf->data + buf->capacity - 1) = 0; /* windows vsnprintf needs this */
         buf->len += (int) strlen((char *)ptr);
         ret = true;
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index bf0c05b1..b456182e 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -280,12 +280,12 @@ lz4v2_decompress(struct buffer *buf, struct buffer work,
     c = head[1];
     if (c == COMP_ALGV2_LZ4_BYTE) /* packet was compressed */
     {
-        buf_advance(buf,2);
+        buf_advance(buf, 2);
         do_lz4_decompress(zlen_max, &work, buf, compctx);
     }
     else if (c == COMP_ALGV2_UNCOMPRESSED_BYTE)
     {
-        buf_advance(buf,2);
+        buf_advance(buf, 2);
     }
     else
     {
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 10c21edb..da4ed980 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -1033,7 +1033,7 @@ tls1_P_hash(const mbedtls_md_info_t *md_kt, const uint8_t *sec, int sec_len,
     ASSERT(0 == mbedtls_md_setup(ctx_tmp, md_kt, 1));
     ASSERT(0 == mbedtls_md_hmac_starts(ctx_tmp, sec, sec_len));
 
-    hmac_ctx_update(ctx,seed,seed_len);
+    hmac_ctx_update(ctx, seed, seed_len);
     hmac_ctx_final(ctx, A1);
 
     for (;; )
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 9fa081f0..661a9a6d 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -352,7 +352,7 @@ ecdsa_sign(int type, const unsigned char *dgst, int dgstlen, unsigned char *sig,
     if (len > ECDSA_size(ec))
     {
         ECDSA_SIG_free(s);
-        msg(M_NONFATAL,"Error in cryptoapicert: DER encoded ECDSA signature is too long (%d bytes)", len);
+        msg(M_NONFATAL, "Error in cryptoapicert: DER encoded ECDSA signature is too long (%d bytes)", len);
         return 0;
     }
     *siglen = i2d_ECDSA_SIG(s, &sig);
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 7e4e8081..3f60438e 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -572,7 +572,7 @@ list_test(void)
  * --------------------------------------------------------------------
  */
 
-#define mix(a,b,c)               \
+#define mix(a, b, c)               \
     {                                \
         a -= b; a -= c; a ^= (c>>13);  \
         b -= c; b -= a; b ^= (a<<8);   \
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index aeea5f9f..ba9f806b 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2119,7 +2119,7 @@ management_android_control(struct management *man, const char *command, const ch
     CLEAR(up);
     strncpy(up.username, msg, sizeof(up.username)-1);
 
-    management_query_user_pass(management, &up, command, GET_USER_PASS_NEED_OK,(void *) 0);
+    management_query_user_pass(management, &up, command, GET_USER_PASS_NEED_OK, (void *) 0);
     return strcmp("ok", up.password)==0;
 }
 
@@ -2134,9 +2134,9 @@ managment_android_persisttun_action(struct management *man)
 {
     struct user_pass up;
     CLEAR(up);
-    strcpy(up.username,"tunmethod");
+    strcpy(up.username, "tunmethod");
     management_query_user_pass(management, &up, "PERSIST_TUN_ACTION",
-                               GET_USER_PASS_NEED_OK,(void *) 0);
+                               GET_USER_PASS_NEED_OK, (void *) 0);
     if (!strcmp("NOACTION", up.password))
     {
         return ANDROID_KEEP_OLD_TUN;
@@ -2266,7 +2266,7 @@ man_write(struct management *man)
 #ifdef TARGET_ANDROID
         if (man->connection.fdtosend > 0)
         {
-            sent = man_send_with_fd(man->connection.sd_cli, BPTR(buf), len, MSG_NOSIGNAL,man->connection.fdtosend);
+            sent = man_send_with_fd(man->connection.sd_cli, BPTR(buf), len, MSG_NOSIGNAL, man->connection.fdtosend);
             man->connection.fdtosend = -1;
         }
         else
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 84310349..59b91798 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -349,7 +349,7 @@ format_extended_socket_error(int fd, int *mtu, struct gc_arena *gc)
                 }
                 else
                 {
-                    buf_printf(&out,"CMSG=%d|", cmsg->cmsg_type);
+                    buf_printf(&out, "CMSG=%d|", cmsg->cmsg_type);
                 }
             }
             else if (cmsg->cmsg_level == IPPROTO_IPV6)
@@ -360,7 +360,7 @@ format_extended_socket_error(int fd, int *mtu, struct gc_arena *gc)
                 }
                 else
                 {
-                    buf_printf(&out,"CMSG=%d|", cmsg->cmsg_type);
+                    buf_printf(&out, "CMSG=%d|", cmsg->cmsg_type);
                 }
             }
         }
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index e6328090..bffcb067 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -1034,7 +1034,7 @@ net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface,
     addr_v4.ipv4 = htonl(*addr);
 
     msg(M_INFO, "%s: %s/%d dev %s", __func__,
-        inet_ntop(AF_INET, &addr_v4.ipv4, buf, sizeof(buf)), prefixlen,iface);
+        inet_ntop(AF_INET, &addr_v4.ipv4, buf, sizeof(buf)), prefixlen, iface);
 
     return sitnl_addr_add(AF_INET, iface, &addr_v4, prefixlen);
 }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9ff384d0..20cc849d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1819,7 +1819,7 @@ show_settings(const struct options *o)
 #ifdef ENABLE_MANAGEMENT
     if ((o->management_flags & MF_EXTERNAL_CERT))
     {
-        SHOW_PARM("cert_file","EXTERNAL_CERT","%s");
+        SHOW_PARM("cert_file", "EXTERNAL_CERT", "%s");
     }
     else
 #endif
@@ -1829,7 +1829,7 @@ show_settings(const struct options *o)
 #ifdef ENABLE_MANAGEMENT
     if ((o->management_flags & MF_EXTERNAL_KEY))
     {
-        SHOW_PARM("priv_key_file","EXTERNAL_PRIVATE_KEY","%s");
+        SHOW_PARM("priv_key_file", "EXTERNAL_PRIVATE_KEY", "%s");
     }
     else
 #endif
@@ -4349,7 +4349,7 @@ options_string_version(const char *s, struct gc_arena *gc)
 }
 
 char *
-options_string_extract_option(const char *options_string,const char *opt_name,
+options_string_extract_option(const char *options_string, const char *opt_name,
                               struct gc_arena *gc)
 {
     char *ret = NULL;
@@ -7100,7 +7100,7 @@ add_option(struct options *options,
     {
         VERIFY_PERMISSION(OPT_P_INSTANCE);
         msg(D_PUSH, "PUSH_REMOVE '%s'", p[1]);
-        push_remove_option(options,p[1]);
+        push_remove_option(options, p[1]);
     }
     else if (streq(p[0], "ifconfig-pool") && p[1] && p[2] && !p[4])
     {
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index d561fc08..60bc1c47 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -193,7 +193,7 @@ xkey_pkcs11h_sign(void *handle, unsigned char *sig,
     {
         msg(D_XKEY, "xkey_pkcs11h_sign: signing with RSA key: padmode = %s",
             sigalg.padmode);
-        if (!strcmp(sigalg.padmode,"none"))
+        if (!strcmp(sigalg.padmode, "none"))
         {
             mech.mechanism = CKM_RSA_X_509;
         }
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index e3aad9dc..88af4b55 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -722,7 +722,7 @@ ifconfig_pool_read(struct ifconfig_pool_persist *persist, struct ifconfig_pool *
              */
             if (h >= 0)
             {
-                msg(M_INFO, "succeeded -> ifconfig_pool_set(hand=%d)",h);
+                msg(M_INFO, "succeeded -> ifconfig_pool_set(hand=%d)", h);
                 ifconfig_pool_set(pool, cn_buf, h, persist->fixed);
             }
         }
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 9dca53c8..a69da2f9 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -432,7 +432,7 @@ proxy_entry_new(struct proxy_connection **list,
         msg(M_WARN|M_ERRNO, "PORT SHARE PROXY: cannot create socket");
         return false;
     }
-    status = openvpn_connect(sd_server,(const struct sockaddr *)  &server_addr, 5, NULL);
+    status = openvpn_connect(sd_server, (const struct sockaddr *)  &server_addr, 5, NULL);
     if (status)
     {
         msg(M_WARN, "PORT SHARE PROXY: connect to port-share server failed");
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 200f82c5..7eaf1121 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3440,7 +3440,7 @@ struct rtmsg {
 #define ADVANCE(x, n) (x += ROUNDUP((n)->sa_len))
 #endif
 
-#define max(a,b) ((a) > (b) ? (a) : (b))
+#define max(a, b) ((a) > (b) ? (a) : (b))
 
 void
 get_default_gateway(struct route_gateway_info *rgi, openvpn_net_ctx_t *ctx)
diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index 2eb759c6..8b44d177 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -252,7 +252,7 @@ openvpn_popen(const struct argv *a,  const struct env_set *es)
                 if (pid == (pid_t)0)       /* child side */
                 {
                     close(pipe_stdout[0]);         /* Close read end */
-                    dup2(pipe_stdout[1],1);
+                    dup2(pipe_stdout[1], 1);
                     execve(cmd, argv, envp);
                     exit(OPENVPN_EXECVE_FAILURE);
                 }
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index bec9308f..4e4a3a2f 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -525,7 +525,7 @@ openvpn_getaddrinfo(unsigned int flags,
         if (!(flags & GETADDR_RESOLVE) || status == EAI_FAIL)
         {
             msg(msglevel, "RESOLVE: Cannot parse IP address: %s:%s (%s)",
-                print_hostname,print_servname, gai_strerror(status));
+                print_hostname, print_servname, gai_strerror(status));
             goto done;
         }
 
@@ -1978,7 +1978,7 @@ linksock_print_addr(struct link_socket *sock)
         ASSERT(cur);
         msg(msglevel, "%s link local (bound): %s",
             proto2ascii(sock->info.proto, sock->info.af, true),
-            print_sockaddr(cur->ai_addr,&gc));
+            print_sockaddr(cur->ai_addr, &gc));
     }
     else
     {
@@ -2374,12 +2374,12 @@ link_socket_bad_incoming_addr(struct buffer *buf,
                 "TCP/UDP: Incoming packet rejected from %s[%d], expected peer address: %s (allow this incoming source address/port by removing --remote or adding --float)",
                 print_link_socket_actual(from_addr, &gc),
                 (int)from_addr->dest.addr.sa.sa_family,
-                print_sockaddr_ex(info->lsa->remote_list->ai_addr,":",PS_SHOW_PORT, &gc));
+                print_sockaddr_ex(info->lsa->remote_list->ai_addr, ":", PS_SHOW_PORT, &gc));
             /* print additional remote addresses */
             for (ai = info->lsa->remote_list->ai_next; ai; ai = ai->ai_next)
             {
-                msg(D_LINK_ERRORS,"or from peer address: %s",
-                    print_sockaddr_ex(ai->ai_addr,":",PS_SHOW_PORT, &gc));
+                msg(D_LINK_ERRORS, "or from peer address: %s",
+                    print_sockaddr_ex(ai->ai_addr, ":", PS_SHOW_PORT, &gc));
             }
             break;
     }
@@ -2730,7 +2730,7 @@ print_sockaddr_ex(const struct sockaddr *sa,
 
     if (status!=0)
     {
-        buf_printf(&out,"[nameinfo() err: %s]",gai_strerror(status));
+        buf_printf(&out, "[nameinfo() err: %s]", gai_strerror(status));
         return BSTR(&out);
     }
 
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 270a829f..a75adb00 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -873,7 +873,7 @@ addr_inet4or6(struct sockaddr *addr)
     return addr->sa_family == AF_INET || addr->sa_family == AF_INET6;
 }
 
-int addr_guess_family(sa_family_t af,const char *name);
+int addr_guess_family(sa_family_t af, const char *name);
 
 static inline int
 af_addr_size(sa_family_t af)
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 5d7e6dd3..43d4e60c 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -221,7 +221,7 @@ const char *
 tls_peer_ncp_list(const char *peer_info, struct gc_arena *gc)
 {
     /* Check if the peer sends the IV_CIPHERS list */
-    const char *iv_ciphers = extract_var_peer_info(peer_info,"IV_CIPHERS=", gc);
+    const char *iv_ciphers = extract_var_peer_info(peer_info, "IV_CIPHERS=", gc);
     if (iv_ciphers)
     {
         return iv_ciphers;
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index c9ea10d4..710c9c06 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -362,7 +362,7 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 }
 
 void
-convert_tls_list_to_openssl(char *openssl_ciphers, size_t len,const char *ciphers)
+convert_tls_list_to_openssl(char *openssl_ciphers, size_t len, const char *ciphers)
 {
     /* Parse supplied cipher list and pass on to OpenSSL */
     size_t begin_of_cipher, end_of_cipher;
@@ -886,13 +886,13 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
             for (i = 0; i < sk_X509_num(ca); i++)
             {
                 X509_STORE *cert_store = SSL_CTX_get_cert_store(ctx->ctx);
-                if (!X509_STORE_add_cert(cert_store,sk_X509_value(ca, i)))
+                if (!X509_STORE_add_cert(cert_store, sk_X509_value(ca, i)))
                 {
-                    crypto_msg(M_FATAL,"Cannot add certificate to certificate chain (X509_STORE_add_cert)");
+                    crypto_msg(M_FATAL, "Cannot add certificate to certificate chain (X509_STORE_add_cert)");
                 }
                 if (!SSL_CTX_add_client_CA(ctx->ctx, sk_X509_value(ca, i)))
                 {
-                    crypto_msg(M_FATAL,"Cannot add certificate to client CA list (SSL_CTX_add_client_CA)");
+                    crypto_msg(M_FATAL, "Cannot add certificate to client CA list (SSL_CTX_add_client_CA)");
                 }
             }
         }
@@ -908,7 +908,7 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
         {
             for (i = 0; i < sk_X509_num(ca); i++)
             {
-                if (!SSL_CTX_add_extra_chain_cert(ctx->ctx,sk_X509_value(ca, i)))
+                if (!SSL_CTX_add_extra_chain_cert(ctx->ctx, sk_X509_value(ca, i)))
                 {
                     crypto_msg(M_FATAL, "Cannot add extra certificate to chain (SSL_CTX_add_extra_chain_cert)");
                 }
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 5f0c9638..78efa70a 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -262,7 +262,7 @@ backend_x509_get_username(char *common_name, int cn_len,
                           char *x509_username_field, X509 *peer_cert)
 {
 #ifdef ENABLE_X509ALTUSERNAME
-    if (strncmp("ext:",x509_username_field,4) == 0)
+    if (strncmp("ext:", x509_username_field, 4) == 0)
     {
         if (!extract_x509_extension(peer_cert, x509_username_field+4, common_name, cn_len))
         {
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 3dd9f0bf..5a673a7b 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -29,8 +29,8 @@
 
 /* branch prediction hints */
 #if defined(__GNUC__)
-#define likely(x)       __builtin_expect((x),1)
-#define unlikely(x)     __builtin_expect((x),0)
+#define likely(x)       __builtin_expect((x), 1)
+#define unlikely(x)     __builtin_expect((x), 0)
 #else
 #define likely(x)      (x)
 #define unlikely(x)    (x)
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 314d523f..b1371999 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -46,7 +46,7 @@
 
 /* MSVC headers do not define this macro, so do it here */
 #ifndef IN6_ARE_ADDR_EQUAL
-#define IN6_ARE_ADDR_EQUAL(a,b) \
+#define IN6_ARE_ADDR_EQUAL(a, b) \
     (memcmp((const void *)(a), (const void *)(b), sizeof(struct in6_addr)) == 0)
 #endif
 
diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index ecc7b120..898ea8a6 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -235,7 +235,7 @@ xkey_management_sign(void *unused, unsigned char *sig, size_t *siglen,
     else if (!strcmp(alg.padmode, "pss") && (flags & MF_EXTERNAL_KEY_PSSPAD))
     {
         openvpn_snprintf(alg_str, sizeof(alg_str), "%s,hashalg=%s,saltlen=%s",
-                         "RSA_PKCS1_PSS_PADDING", alg.mdname,alg.saltlen);
+                         "RSA_PKCS1_PSS_PADDING", alg.mdname, alg.saltlen);
     }
     else
     {
@@ -328,7 +328,7 @@ encode_pkcs1(unsigned char *enc, size_t *enc_len, const char *mdname,
 
     DIG_INFO dinfo[] = {MAKE_DI(sha1), MAKE_DI(sha256), MAKE_DI(sha384),
                         MAKE_DI(sha512), MAKE_DI(sha224), MAKE_DI(sha512_224),
-                        MAKE_DI(sha512_256), {0,NULL,0}};
+                        MAKE_DI(sha512_256), {0, NULL, 0}};
 
     int out_len = 0;
     int ret = 0;
diff --git a/src/openvpn/xkey_provider.c b/src/openvpn/xkey_provider.c
index 46e57e0f..a9f16d7c 100644
--- a/src/openvpn/xkey_provider.c
+++ b/src/openvpn/xkey_provider.c
@@ -626,7 +626,7 @@ const struct {
     int nid;
     const char *name;
 } digest_names[] = {{NID_md5_sha1, "MD5-SHA1"}, {NID_sha1, "SHA1"},
-                    {NID_sha224, "SHA224",}, {NID_sha256, "SHA256"}, {NID_sha384, "SHA384"},
+                    {NID_sha224, "SHA224", }, {NID_sha256, "SHA256"}, {NID_sha384, "SHA384"},
                     {NID_sha512, "SHA512"}, {0, NULL}};
 /* Use of NIDs as opposed to EVP_MD_fetch is okay here
  * as these are only used for converting names passed in
@@ -808,7 +808,7 @@ signature_set_ctx_params(void *ctx, const OSSL_PARAM params[])
 static const OSSL_PARAM *
 signature_gettable_ctx_params(void *ctx, void *provctx)
 {
-    xkey_dmsg(D_XKEY,"entry");
+    xkey_dmsg(D_XKEY, "entry");
 
     static OSSL_PARAM gettable[] = { OSSL_PARAM_END }; /* Empty list */
 
diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index 1d2fd4f4..e65ed21b 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -71,7 +71,7 @@ searchandreplace(const char *tosearch, const char *searchfor, const char *replac
     char temp[templen+1];
     temp[0] = 0;
 
-    scratch = strstr(searching,searchfor);
+    scratch = strstr(searching, searchfor);
     if (!scratch)
     {
         return strdup(tosearch);
@@ -79,11 +79,11 @@ searchandreplace(const char *tosearch, const char *searchfor, const char *replac
 
     while (scratch)
     {
-        strncat(temp,searching,scratch-searching);
-        strcat(temp,replacewith);
+        strncat(temp, searching, scratch-searching);
+        strcat(temp, replacewith);
 
         searching = scratch+strlen(searchfor);
-        scratch = strstr(searching,searchfor);
+        scratch = strstr(searching, searchfor);
     }
     return strdup(temp);
 }
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index 18c40362..2595d8c4 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -138,7 +138,7 @@ test_extract_client_ciphers(void **state)
 
     client_peer_info = "foo=bar\nIV_foo=y\nIV_NCP=2";
     peer_list = tls_peer_ncp_list(client_peer_info, &gc);
-    assert_string_equal(aes_ciphers,peer_list);
+    assert_string_equal(aes_ciphers, peer_list);
     assert_true(tls_peer_supports_ncp(client_peer_info));
 
     client_peer_info = "foo=bar\nIV_foo=y\nIV_NCP=2\nIV_CIPHERS=BF-CBC";
@@ -210,7 +210,7 @@ test_poor_man(void **state)
                                       "none", &gc);
     assert_string_equal(best_cipher, "none");
 
-    best_cipher = ncp_get_best_cipher(serverlist, NULL,NULL, &gc);
+    best_cipher = ncp_get_best_cipher(serverlist, NULL, NULL, &gc);
     assert_ptr_equal(best_cipher, NULL);
 
     gc_free(&gc);
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 9d038b77..2d771e30 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -157,7 +157,7 @@ const uint8_t client_ack_tls_auth_randomid[] = {
 const uint8_t client_control_with_ack[] = {
     0x20, 0x78, 0x19, 0xbf, 0x2e, 0xbc, 0xd1, 0x9a,
     0x45, 0x01, 0x00, 0x00, 0x00, 0x00, 0xea,
-    0xfe,0xbf, 0xa4, 0x41, 0x8a, 0xe3, 0x1b,
+    0xfe, 0xbf, 0xa4, 0x41, 0x8a, 0xe3, 0x1b,
     0x00, 0x00, 0x00, 0x01, 0x16, 0x03, 0x01
 };
 
@@ -490,7 +490,7 @@ test_calc_session_id_hmac_static(void **ut_state)
     now = 1005;
     struct session_id server_id = calculate_session_id_hmac(client_id, &addr, hmac, handwindow, 0);
 
-    struct session_id expected_server_id = { {0xba,  0x83, 0xa9, 0x00, 0x72, 0xbd,0x93, 0xba }};
+    struct session_id expected_server_id = { {0xba,  0x83, 0xa9, 0x00, 0x72, 0xbd, 0x93, 0xba }};
     assert_memory_equal(expected_server_id.id, server_id.id, SID_SIZE);
 
     struct session_id server_id_m1 = calculate_session_id_hmac(client_id, &addr, hmac, handwindow, -1);
@@ -580,7 +580,7 @@ test_generate_reset_packet_tls_auth(void **ut_state)
 
     /* Assure repeated generation of reset is deterministic/stateless*/
     reset_packet_id_send(&tas_client.tls_wrap.opt.packet_id.send);
-    struct buffer buf2 = tls_reset_standalone(&tas_client.tls_wrap, &tas_client, &client_id, &server_id, header,false);
+    struct buffer buf2 = tls_reset_standalone(&tas_client.tls_wrap, &tas_client, &client_id, &server_id, header, false);
     assert_int_equal(BLEN(&buf), BLEN(&buf2));
     assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLEN(&buf));
 
diff --git a/tests/unit_tests/openvpn/test_provider.c b/tests/unit_tests/openvpn/test_provider.c
index 0b0952ee..dc39534e 100644
--- a/tests/unit_tests/openvpn/test_provider.c
+++ b/tests/unit_tests/openvpn/test_provider.c
@@ -116,7 +116,7 @@ load_pubkey(const char *pem)
 static void
 init_test()
 {
-    prov[0] = OSSL_PROVIDER_load(NULL,"default");
+    prov[0] = OSSL_PROVIDER_load(NULL, "default");
     OSSL_PROVIDER_add_builtin(NULL, prov_name, xkey_provider_init);
     prov[1] = OSSL_PROVIDER_load(NULL, prov_name);
 
diff --git a/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c b/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
index 34a9a884..ee7a1518 100644
--- a/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
+++ b/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
@@ -14,9 +14,9 @@ pass_any_null_param__returns_null()
 
     char DUMMY[] = "DUMMY";
 
-    assert_null(searchandreplace(NULL,DUMMY,DUMMY));
-    assert_null(searchandreplace(DUMMY,NULL,DUMMY));
-    assert_null(searchandreplace(DUMMY,DUMMY,NULL));
+    assert_null(searchandreplace(NULL, DUMMY, DUMMY));
+    assert_null(searchandreplace(DUMMY, NULL, DUMMY));
+    assert_null(searchandreplace(DUMMY, DUMMY, NULL));
 }
 
 static void
@@ -26,15 +26,15 @@ pass_any_empty_string__returns_null()
     char DUMMY[] = "DUMMY";
     char EMPTY[] = "";
 
-    assert_null(searchandreplace(EMPTY,DUMMY,DUMMY));
-    assert_null(searchandreplace(DUMMY,EMPTY,DUMMY));
-    assert_null(searchandreplace(DUMMY,DUMMY,EMPTY));
+    assert_null(searchandreplace(EMPTY, DUMMY, DUMMY));
+    assert_null(searchandreplace(DUMMY, EMPTY, DUMMY));
+    assert_null(searchandreplace(DUMMY, DUMMY, EMPTY));
 }
 
 static void
 replace_single_char__one_time__match_is_replaced()
 {
-    char *replaced = searchandreplace("X","X","Y");
+    char *replaced = searchandreplace("X", "X", "Y");
 
     assert_non_null(replaced);
     assert_string_equal("Y", replaced);
@@ -45,7 +45,7 @@ replace_single_char__one_time__match_is_replaced()
 static void
 replace_single_char__multiple_times__match_all_matches_are_replaced()
 {
-    char *replaced = searchandreplace("XaX","X","Y");
+    char *replaced = searchandreplace("XaX", "X", "Y");
 
     assert_non_null(replaced);
     assert_string_equal("YaY", replaced);
@@ -56,7 +56,7 @@ replace_single_char__multiple_times__match_all_matches_are_replaced()
 static void
 replace_longer_text__multiple_times__match_all_matches_are_replaced()
 {
-    char *replaced = searchandreplace("XXaXX","XX","YY");
+    char *replaced = searchandreplace("XXaXX", "XX", "YY");
 
     assert_non_null(replaced);
     assert_string_equal("YYaYY", replaced);
@@ -67,7 +67,7 @@ replace_longer_text__multiple_times__match_all_matches_are_replaced()
 static void
 pattern_not_found__returns_original()
 {
-    char *replaced = searchandreplace("abc","X","Y");
+    char *replaced = searchandreplace("abc", "X", "Y");
 
     assert_non_null(replaced);
     assert_string_equal("abc", replaced);
-- 
2.30.2


