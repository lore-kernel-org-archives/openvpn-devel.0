From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 5 May 2026 20:40:05 +0000
References: <gerrit.1778013601000.I2b71dae37ebe63c26a66761f877b25d326ed140f@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3a3dbef049146a80aff37042145abcb1b4734998-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/te0CbntKgk="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constVariable/constVariablePointer cppcheck warnings
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

--/te0CbntKgk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1661?usp=3Demail

to review the following change.


Change subject: Remove instances of constVariable/constVariablePointer cppc=
heck warnings
......................................................................

Remove instances of constVariable/constVariablePointer cppcheck warnings

Of varied usefulness, but easier to just address all of
them.

Change-Id: I2b71dae37ebe63c26a66761f877b25d326ed140f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M dev-tools/cppcheck-suppression
M sample/sample-plugins/defer/multi-auth.c
M sample/sample-plugins/log/log.c
M sample/sample-plugins/log/log_v3.c
M sample/sample-plugins/simple/simple.c
M src/openvpn/argv.c
M src/openvpn/auth_token.c
M src/openvpn/base64.c
M src/openvpn/buffer.c
M src/openvpn/buffer.h
M src/openvpn/comp-lz4.c
M src/openvpn/crypto.c
M src/openvpn/crypto_epoch.c
M src/openvpn/dco.c
M src/openvpn/dco_linux.c
M src/openvpn/dns.c
M src/openvpn/forward.c
M src/openvpn/init.c
M src/openvpn/list.c
M src/openvpn/manage.c
M src/openvpn/misc.c
M src/openvpn/mss.c
M src/openvpn/mtcp.c
M src/openvpn/mudp.c
M src/openvpn/multi.c
M src/openvpn/networking_sitnl.c
M src/openvpn/options.c
M src/openvpn/options_parse.c
M src/openvpn/options_util.c
M src/openvpn/pool.c
M src/openvpn/proxy.c
M src/openvpn/push.c
M src/openvpn/route.c
M src/openvpn/socket.c
M src/openvpn/ssl.c
M src/openvpn/ssl_verify.c
M src/openvpnmsica/msica_arg.c
M src/openvpnmsica/openvpnmsica.c
M src/plugins/auth-pam/auth-pam.c
M src/tapctl/main.c
M tests/unit_tests/openvpn/test_buffer.c
M tests/unit_tests/openvpn/test_crypto.c
M tests/unit_tests/openvpn/test_misc.c
M tests/unit_tests/openvpn/test_pkt.c
M tests/unit_tests/openvpn/test_ssl.c
M tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
46 files changed, 126 insertions(+), 128 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/1661/1

diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index 1f31edb..8a74e84 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -3,8 +3,6 @@
 constParameter
 constParameterCallback
 constParameterPointer
-constVariable
-constVariablePointer
 variableScope
 # We have a lot of library includes, not all of them are really required,
 # so ignore them
@@ -33,12 +31,11 @@
 knownConditionTrueFalse:src/openvpn/forward.c
 knownConditionTrueFalse:src/openvpn/init.c
 knownConditionTrueFalse:src/openvpn/multi_io.c:163
-# FP: cppcheck thinks that management_query_user_pass is always true,
-# but no idea why
+# FP: cppcheck thinks that management_query_user_pass is always true
 knownConditionTrueFalse:src/openvpn/misc.c:97
 # FP: cert_uri_supported is a wrapper around defines, so it's
 # always constant but differs depending on OpenSSL version
-knownConditionTrueFalse:src/openvpn/ssl_openssl.c:1258
+knownConditionTrueFalse:src/openvpn/ssl_openssl.c:1332
 # FP: cppcheck doesn't understand that the function changes szErrMessage
 knownConditionTrueFalse:src/tapctl/main.c:704
 knownConditionTrueFalse:src/openvpnmsica/dllmain.c:164
diff --git a/sample/sample-plugins/defer/multi-auth.c b/sample/sample-plugi=
ns/defer/multi-auth.c
index f6bbf44..33fbe61 100644
--- a/sample/sample-plugins/defer/multi-auth.c
+++ b/sample/sample-plugins/defer/multi-auth.c
@@ -399,7 +399,7 @@
 OPENVPN_EXPORT void *
 openvpn_plugin_client_constructor_v1(openvpn_plugin_handle_t handle)
 {
-    struct plugin_context *context =3D (struct plugin_context *)handle;
+    const struct plugin_context *context =3D (struct plugin_context *)hand=
le;
     plog(context, PLOG_NOTE, "FUNC: openvpn_plugin_client_constructor_v1");
     return calloc(1, sizeof(struct plugin_per_client_context));
 }
@@ -407,7 +407,7 @@
 OPENVPN_EXPORT void
 openvpn_plugin_client_destructor_v1(openvpn_plugin_handle_t handle, void *=
per_client_context)
 {
-    struct plugin_context *context =3D (struct plugin_context *)handle;
+    const struct plugin_context *context =3D (struct plugin_context *)hand=
le;
     plog(context, PLOG_NOTE, "FUNC: openvpn_plugin_client_destructor_v1");
     free(per_client_context);
 }
diff --git a/sample/sample-plugins/log/log.c b/sample/sample-plugins/log/lo=
g.c
index 330e3e0..76350ee 100644
--- a/sample/sample-plugins/log/log.c
+++ b/sample/sample-plugins/log/log.c
@@ -173,7 +173,7 @@
 openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, con=
st char *argv[],
                        const char *envp[])
 {
-    struct plugin_context *context =3D (struct plugin_context *)handle;
+    const struct plugin_context *context =3D (struct plugin_context *)hand=
le;

     show(type, argv, envp);

diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample-plugins/log=
/log_v3.c
index deae590..fae7bc4 100644
--- a/sample/sample-plugins/log/log_v3.c
+++ b/sample/sample-plugins/log/log_v3.c
@@ -245,7 +245,7 @@
 openvpn_plugin_func_v3(const int version, struct openvpn_plugin_args_func_=
in const *args,
                        struct openvpn_plugin_args_func_return *retptr)
 {
-    struct plugin_context *context =3D (struct plugin_context *)args->hand=
le;
+    const struct plugin_context *context =3D (struct plugin_context *)args=
->handle;

     printf("\nopenvpn_plugin_func_v3() :::::>> ");
     show(args->type, args->argv, args->envp);
diff --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/=
simple/simple.c
index 687a633..3182be0 100644
--- a/sample/sample-plugins/simple/simple.c
+++ b/sample/sample-plugins/simple/simple.c
@@ -104,7 +104,7 @@
 openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, con=
st char *argv[],
                        const char *envp[])
 {
-    struct plugin_context *context =3D (struct plugin_context *)handle;
+    const struct plugin_context *context =3D (struct plugin_context *)hand=
le;

     /* get username/password from envp string array */
     const char *username =3D get_env("username", envp);
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 6a5d92e..028671d 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -359,7 +359,7 @@
      *
      */
     size_t argc =3D argres->argc;
-    char *f =3D argv_prep_format(format, delim, &argc, &argres->gc);
+    const char *f =3D argv_prep_format(format, delim, &argc, &argres->gc);
     if (f =3D=3D NULL)
     {
         goto out;
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index d8ca125..0cfcd2d 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -217,7 +217,7 @@
      * a new token with the empty username since we do not want to loose
      * the information that the username cannot be trusted
      */
-    struct key_state *ks =3D &multi->session[TM_ACTIVE].key[KS_PRIMARY];
+    const struct key_state *ks =3D &multi->session[TM_ACTIVE].key[KS_PRIMA=
RY];
     if (ks->auth_token_state_flags & AUTH_TOKEN_VALID_EMPTYUSER)
     {
         hmac_ctx_update(ctx, (const uint8_t *)"", 0);
diff --git a/src/openvpn/base64.c b/src/openvpn/base64.c
index 7af8976..5752844 100644
--- a/src/openvpn/base64.c
+++ b/src/openvpn/base64.c
@@ -161,7 +161,7 @@
 {
     const char *p;
     unsigned char *q;
-    unsigned char *e =3D NULL;
+    const unsigned char *e =3D NULL;

     q =3D data;
     if (size >=3D 0)
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index eec91a6..46c1d12 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -531,7 +531,7 @@
 void
 buf_null_terminate(struct buffer *buf)
 {
-    char *last =3D (char *)BLAST(buf);
+    const char *last =3D (char *)BLAST(buf);
     if (last && *last =3D=3D '\0') /* already terminated? */
     {
         return;
@@ -554,7 +554,7 @@
 {
     while (true)
     {
-        char *last =3D (char *)BLAST(buf);
+        const char *last =3D (char *)BLAST(buf);
         if (!last)
         {
             break;
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index b4e65ef..6a751ad 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -712,7 +712,7 @@
 static inline bool
 buf_copy_n(struct buffer *dest, struct buffer *src, int n)
 {
-    uint8_t *cp =3D buf_read_alloc(src, n);
+    const uint8_t *cp =3D buf_read_alloc(src, n);
     if (!cp)
     {
         return false;
@@ -764,7 +764,7 @@
 static inline bool
 buf_read(struct buffer *src, void *dest, int size)
 {
-    uint8_t *cp =3D buf_read_alloc(src, size);
+    const uint8_t *cp =3D buf_read_alloc(src, size);
     if (!cp)
     {
         return false;
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index 45f138c..48797b0 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -164,7 +164,7 @@
     ASSERT(buf_init(&work, frame->buf.headroom));

     /* do unframing/swap (assumes buf->len > 0) */
-    uint8_t *head =3D BPTR(buf);
+    const uint8_t *head =3D BPTR(buf);
     c =3D *head;

     /* Not compressed */
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index df9b905..a9a33c0 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1210,7 +1210,7 @@

     /* init implicit IV */
     {
-        cipher_ctx_t *cipher =3D co->key_ctx_bi.encrypt.cipher;
+        const cipher_ctx_t *cipher =3D co->key_ctx_bi.encrypt.cipher;
         if (cipher_ctx_mode_aead(cipher))
         {
             ASSERT(cipher_ctx_iv_length(cipher) <=3D OPENVPN_MAX_IV_LENGTH=
);
@@ -1919,7 +1919,7 @@
     const char *seed =3D "tls1-prf-test";
     const char *secret =3D "tls1-prf-test-secret";
     uint8_t out[8];
-    uint8_t expected_out[] =3D { 'q', 'D', 0xfe, '%', '@', 's', 'u', 0x95 =
};
+    const uint8_t expected_out[] =3D { 'q', 'D', 0xfe, '%', '@', 's', 'u',=
 0x95 };

     int ret =3D ssl_tls1_PRF((uint8_t *)seed, strlen(seed), (uint8_t *)sec=
ret,
                            strlen(secret), out, sizeof(out));
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index 54225bf..3812435 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -213,7 +213,7 @@
      *
      * The last generated key might have been moved to the decrypt key alr=
eady.
      */
-    struct key_ctx *highest_future_key =3D
+    const struct key_ctx *highest_future_key =3D
         &co->epoch_data_keys_future[co->epoch_data_keys_future_count - 1];

     ASSERT(co->epoch_key_recv.epoch =3D=3D 1 || highest_future_key->epoch =
=3D=3D co->epoch_key_recv.epoch
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index f5b7081..17acf8e 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -109,7 +109,7 @@
     for (int i =3D 0; i < KEY_SCAN_SIZE; ++i)
     {
         struct key_state *ks =3D get_key_scan(multi, i);
-        struct key_ctx_bi *key =3D &ks->crypto_options.key_ctx_bi;
+        const struct key_ctx_bi *key =3D &ks->crypto_options.key_ctx_bi;

         if (ks =3D=3D primary)
         {
@@ -560,7 +560,7 @@
                         struct sockaddr_storage *local)
 {
 #if ENABLE_IP_PKTINFO
-    struct context *c =3D &mi->context;
+    const struct context *c =3D &mi->context;

     if (!proto_is_udp(c->c2.link_sockets[0]->info.proto)
         || !(c->options.sockflags & SF_USE_IP_PKTINFO))
@@ -608,7 +608,7 @@
 int
 dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
 {
-    struct context *c =3D &mi->context;
+    const struct context *c =3D &mi->context;

     int peer_id =3D c->c2.tls_multi->peer_id;
     struct sockaddr *remoteaddr, *localaddr =3D NULL;
@@ -685,7 +685,7 @@
     }
 #endif

-    struct context *c =3D &mi->context;
+    const struct context *c =3D &mi->context;
     if (addrtype =3D=3D MR_ADDR_IPV6)
     {
 #if defined(_WIN32)
@@ -733,7 +733,7 @@
     }
     ASSERT(TUNNEL_TYPE(mi->context.c1.tuntap) =3D=3D DEV_TYPE_TUN);

-    struct context *c =3D &mi->context;
+    const struct context *c =3D &mi->context;

     if (mi->context.c2.push_ifconfig_defined)
     {
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 40746bd..3732dd7 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -697,7 +697,7 @@
 {
     dco_context_t *dco =3D arg;
     struct nlattr *tb[CTRL_ATTR_MAX + 1];
-    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
+    const struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));

     nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(gnlh, 0), genlmsg_attrle=
n(gnlh, 0), NULL);

@@ -706,7 +706,7 @@
         return NL_SKIP;
     }

-    struct nlattr *mcgrp;
+    const struct nlattr *mcgrp;
     int rem_mcgrp;
     nla_for_each_nested(mcgrp, tb[CTRL_ATTR_MCAST_GROUPS], rem_mcgrp)
     {
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 954ed52..1e49195 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -132,7 +132,7 @@
     }
     else
     {
-        struct sockaddr_in6 *sin6 =3D (struct sockaddr_in6 *)ai->ai_addr;
+        const struct sockaddr_in6 *sin6 =3D (struct sockaddr_in6 *)ai->ai_=
addr;
         server->addr[server->addr_count].in.a6 =3D sin6->sin6_addr;
     }

@@ -156,7 +156,7 @@
     /* Append all domains to the end of the list */
     while (*domains)
     {
-        char *domain =3D *domains++;
+        const char *domain =3D *domains++;
         if (!validate_domain(domain))
         {
             return false;
@@ -699,7 +699,7 @@
 run_up_down_command(bool up, struct options *o, const struct tuntap *tt,
                     struct dns_updown_runner_info *updown_runner)
 {
-    struct dns_options *dns =3D &o->dns_options;
+    const struct dns_options *dns =3D &o->dns_options;
     if (!dns->updown || (o->up_script && !dns_updown_user_set(dns) && !dns=
_updown_forced(dns)))
     {
         return;
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 53eab4d..a4747ed 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1215,7 +1215,7 @@
 {
     if (float_sa->sa_family =3D=3D AF_INET)
     {
-        struct sockaddr_in *float4 =3D (struct sockaddr_in *)float_sa;
+        const struct sockaddr_in *float4 =3D (struct sockaddr_in *)float_s=
a;
         /* DCO treats IPv4-mapped IPv6 addresses as pure IPv4. However, on=
 a
          * dual-stack socket, we need to preserve the mapping otherwise op=
envpn
          * will not be able to find the peer by its transport address.
@@ -1238,7 +1238,7 @@
     }
     else
     {
-        struct sockaddr_in6 *float6 =3D (struct sockaddr_in6 *)float_sa;
+        const struct sockaddr_in6 *float6 =3D (struct sockaddr_in6 *)float=
_sa;
         memcpy(&out_osaddr->addr.in6, float6, sizeof(struct sockaddr_in6));
     }
 }
@@ -1369,7 +1369,7 @@
     }

     struct openvpn_sockaddr *link_addr =3D &c->c2.to_link_addr->dest;
-    struct link_socket_info *lsi =3D get_link_socket_info(c);
+    const struct link_socket_info *lsi =3D get_link_socket_info(c);

     int ip_hdr_offset =3D 0;
     int tun_ip_ver =3D get_tun_ip_ver(TUNNEL_TYPE(c->c1.tuntap), buf, &ip_=
hdr_offset);
@@ -2241,7 +2241,7 @@

                     if (e->arg >=3D MULTI_N)
                     {
-                        struct event_arg *ev_arg =3D (struct event_arg *)e=
->arg;
+                        const struct event_arg *ev_arg =3D (struct event_a=
rg *)e->arg;
                         if (ev_arg->type !=3D EVENT_ARG_LINK_SOCKET)
                         {
                             c->c2.event_set_status =3D ES_ERROR;
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index caaa769..af652ac 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -319,8 +319,8 @@
 management_callback_remote_entry_count(void *arg)
 {
     ASSERT(arg);
-    struct context *c =3D (struct context *)arg;
-    struct connection_list *l =3D c->options.connection_list;
+    const struct context *c =3D (struct context *)arg;
+    const struct connection_list *l =3D c->options.connection_list;

     return l->len;
 }
@@ -342,7 +342,7 @@

     if (index < l->len)
     {
-        struct connection_entry *ce =3D l->array[index];
+        const struct connection_entry *ce =3D l->array[index];
         const char *proto =3D proto2ascii(ce->proto, ce->af, false);
         const char *status =3D (ce->flags & CE_DISABLED) ? "disabled" : "e=
nabled";

@@ -525,7 +525,7 @@
 {
     struct connection_list *l =3D c->options.connection_list;
     bool ce_defined;
-    struct connection_entry *ce;
+    const struct connection_entry *ce;
     int n_cycles =3D 0;

     do
@@ -1582,9 +1582,9 @@
     if (management)
     {
         in_addr_t *tun_local =3D NULL;
-        struct in6_addr *tun_local6 =3D NULL;
+        const struct in6_addr *tun_local6 =3D NULL;
         struct openvpn_sockaddr local, remote;
-        struct link_socket_actual *actual;
+        const struct link_socket_actual *actual;
         socklen_t sa_len =3D sizeof(local);
         const char *detail =3D "SUCCESS";
         if (flags & ISC_ERRORS)
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index f0e9908..2e1cf05 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -165,7 +165,7 @@
 hash_remove_by_value(struct hash *hash, void *value)
 {
     struct hash_iterator hi;
-    struct hash_element *he;
+    const struct hash_element *he;

     hash_iterator_init(hash, &hi);
     while ((he =3D hash_iterator_next(&hi)))
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index c082f51..604bbcd 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3820,7 +3820,7 @@
 {
     int ok;
     char *result =3D NULL;
-    struct buffer *buf;
+    const struct buffer *buf;

     ok =3D management_query_multiline(man, b64_data, prompt, cmd, state, i=
nput);
     if (ok && buffer_list_defined(*input))
@@ -3849,7 +3849,7 @@
 {
     int ok;
     char *result =3D NULL;
-    struct buffer *buf;
+    const struct buffer *buf;

     ok =3D management_query_multiline(man, b64_data, prompt, cmd, state, i=
nput);
     if (ok && buffer_list_defined(*input))
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 10bfc35..6563b83 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -131,7 +131,7 @@
     struct auth_challenge_info *ac;
     const int len =3D strlen(auth_challenge);
     char *work =3D (char *)gc_malloc(len + 1, false, gc);
-    char *cp;
+    const char *cp;

     struct buffer b;
     buf_set_read(&b, (const uint8_t *)auth_challenge, len);
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 14112b4..36bbb43 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -65,7 +65,7 @@
         struct buffer newbuf =3D *buf;
         if (buf_advance(&newbuf, hlen))
         {
-            struct openvpn_tcphdr *tc =3D (struct openvpn_tcphdr *)BPTR(&n=
ewbuf);
+            const struct openvpn_tcphdr *tc =3D (struct openvpn_tcphdr *)B=
PTR(&newbuf);
             if (tc->flags & OPENVPN_TCPH_SYN_MASK)
             {
                 mss_fixup_dowork(&newbuf, maxmss);
@@ -122,7 +122,7 @@
     newbuf =3D *buf;
     if (buf_advance(&newbuf, 40) && BLENZ(&newbuf) >=3D sizeof(struct open=
vpn_tcphdr))
     {
-        struct openvpn_tcphdr *tc =3D (struct openvpn_tcphdr *)BPTR(&newbu=
f);
+        const struct openvpn_tcphdr *tc =3D (struct openvpn_tcphdr *)BPTR(=
&newbuf);
         if (tc->flags & OPENVPN_TCPH_SYN_MASK)
         {
             mss_fixup_dowork(&newbuf, maxmss - 20);
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 7651b4d..df94a70 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -130,7 +130,7 @@
 void
 multi_tcp_dereference_instance(struct multi_io *multi_io, struct multi_ins=
tance *mi)
 {
-    struct link_socket *sock =3D mi->context.c2.link_sockets[0];
+    const struct link_socket *sock =3D mi->context.c2.link_sockets[0];
     if (sock && mi->socket_set_called)
     {
         event_del(multi_io->es, socket_event_handle(sock));
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 432c79a..50d72d5 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -74,7 +74,7 @@
     verdict =3D tls_pre_decrypt_lite(tas, state, &m->top.c2.from, &m->top.=
c2.buf);

     hmac_ctx_t *hmac =3D m->top.c2.session_id_hmac;
-    struct openvpn_sockaddr *from =3D &m->top.c2.from.dest;
+    const struct openvpn_sockaddr *from =3D &m->top.c2.from.dest;
     int handwindow =3D m->top.options.handshake_window;

     if (verdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D VERDICT_VA=
LID_RESET_V2)
@@ -201,7 +201,7 @@
         struct hash_element *he;
         const uint32_t hv =3D hash_value(hash, &real);
         struct hash_bucket *bucket =3D hash_bucket(hash, hv);
-        uint8_t *ptr =3D BPTR(&m->top.c2.buf);
+        const uint8_t *ptr =3D BPTR(&m->top.c2.buf);
         uint8_t op =3D ptr[0] >> P_OPCODE_SHIFT;
         bool v2 =3D (op =3D=3D P_DATA_V2) && (m->top.c2.buf.len >=3D (1 + =
3));
         bool peer_id_disabled =3D false;
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 06e3758..6c833c0 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -86,7 +86,7 @@
     struct gc_arena gc =3D gc_new();
     struct env_set *es;
     bool ret =3D true;
-    struct plugin_list *plugins;
+    const struct plugin_list *plugins;

     /* get environmental variable source */
     if (mi && mi->context.c2.es)
@@ -1794,7 +1794,7 @@
      * Push the first cipher from --data-ciphers to the client that
      * the client announces to be supporting.
      */
-    char *push_cipher =3D
+    const char *push_cipher =3D
         ncp_get_best_cipher(o->ncp_ciphers, peer_info, tls_multi->remote_c=
iphername, &o->gc);
     if (push_cipher)
     {
@@ -1925,7 +1925,7 @@
 static enum client_connect_return
 ccs_test_deferred_ret_file(struct multi_instance *mi)
 {
-    struct client_connect_defer_state *ccs =3D &(mi->client_connect_defer_=
state);
+    const struct client_connect_defer_state *ccs =3D &(mi->client_connect_=
defer_state);
     FILE *fp =3D fopen(ccs->deferred_ret_file, "r");
     if (!fp)
     {
@@ -2166,7 +2166,7 @@
 {
     ASSERT(mi);
     ASSERT(option_types_found);
-    struct client_connect_defer_state *ccs =3D &(mi->client_connect_defer_=
state);
+    const struct client_connect_defer_state *ccs =3D &(mi->client_connect_=
defer_state);
     enum client_connect_return ret =3D CC_RET_SKIPPED;

     ret =3D ccs_test_deferred_ret_file(mi);
@@ -2568,7 +2568,7 @@
 override_locked_username(struct multi_instance *mi)
 {
     struct tls_multi *multi =3D mi->context.c2.tls_multi;
-    struct options *options =3D &mi->context.options;
+    const struct options *options =3D &mi->context.options;
     struct tls_session *session =3D &multi->session[TM_ACTIVE];

     if (!multi->locked_username)
@@ -3104,7 +3104,7 @@
         struct multi_instance *ex_mi =3D (struct multi_instance *)he->valu=
e;

         struct tls_multi *m1 =3D mi->context.c2.tls_multi;
-        struct tls_multi *m2 =3D ex_mi->context.c2.tls_multi;
+        const struct tls_multi *m2 =3D ex_mi->context.c2.tls_multi;

         /* do not float if target address is taken by client with another =
cert */
         if (!cert_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_h=
ash_set))
@@ -3864,7 +3864,7 @@
 static int
 management_callback_n_clients(void *arg)
 {
-    struct multi_context *m =3D (struct multi_context *)arg;
+    const struct multi_context *m =3D (struct multi_context *)arg;
     return m->n_clients;
 }

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index b3f8e2b..e6e72d0 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -462,7 +462,7 @@
     struct rtattr *rta =3D RTM_RTA(r);
     size_t len =3D n->nlmsg_len - NLMSG_LENGTH(sizeof(*r));
     unsigned int table, ifindex =3D 0;
-    void *gw =3D NULL;
+    const void *gw =3D NULL;

     /* filter-out non-zero dst prefixes */
     if (res->default_only && r->rtm_dst_len !=3D 0)
@@ -1179,7 +1179,7 @@
 net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixl=
en, const in_addr_t *gw,
                  const char *iface, uint32_t table, int metric)
 {
-    in_addr_t *dst_ptr =3D NULL, *gw_ptr =3D NULL;
+    const in_addr_t *dst_ptr =3D NULL, *gw_ptr =3D NULL;
     in_addr_t dst_be =3D 0, gw_be =3D 0;
     char dst_str[INET_ADDRSTRLEN];
     char gw_str[INET_ADDRSTRLEN];
@@ -1326,7 +1326,7 @@
 #if defined(ENABLE_DCO)
     if (arg && (strcmp(type, OVPN_FAMILY_NAME) =3D=3D 0))
     {
-        dco_context_t *dco =3D arg;
+        const dco_context_t *dco =3D arg;
         struct rtattr *data =3D SITNL_NEST(&req.n, sizeof(req), IFLA_INFO_=
DATA);

         /* the netlink format is uint8_t for this and using something
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 53fb060..fd0d3fc 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1877,7 +1877,7 @@
         SHOW_INT(verify_hash_algo);
         SHOW_INT(verify_hash_depth);
         struct gc_arena gc =3D gc_new();
-        struct verify_hash_list *hl =3D o->verify_hash;
+        const struct verify_hash_list *hl =3D o->verify_hash;
         int digest_len =3D
             (o->verify_hash_algo =3D=3D MD_SHA1) ? SHA_DIGEST_LENGTH : SHA=
256_DIGEST_LENGTH;
         while (hl)
@@ -2333,7 +2333,7 @@

     for (int i =3D 0; i < ce->local_list->len; i++)
     {
-        struct local_entry *le =3D ce->local_list->array[i];
+        const struct local_entry *le =3D ce->local_list->array[i];

         if (proto_is_net(le->proto) && string_defined_equal(le->local, ce-=
>remote)
             && string_defined_equal(le->port, ce->remote_port))
@@ -3988,7 +3988,7 @@
     {
         char *fullpath =3D
             string_alloc(file, NULL); /* POSIX dirname() implementation ma=
y modify its arguments */
-        char *dirpath =3D dirname(fullpath);
+        const char *dirpath =3D dirname(fullpath);

         if (platform_access(dirpath, mode | X_OK) !=3D 0)
         {
@@ -4219,7 +4219,7 @@
     ASSERT(options->connection_list);
     for (int i =3D 0; i < options->connection_list->len; ++i)
     {
-        struct connection_entry *ce =3D options->connection_list->array[i];
+        const struct connection_entry *ce =3D options->connection_list->ar=
ray[i];

         errs |=3D check_file_access_inline(ce->tls_auth_file_inline, CHKAC=
C_FILE | CHKACC_PRIVATE,
                                          ce->tls_auth_file, R_OK, "--tls-a=
uth");
@@ -9091,7 +9091,7 @@
 #ifdef ENABLE_PKCS11
     else if (streq(p[0], "show-pkcs11-ids") && !p[3])
     {
-        char *provider =3D p[1];
+        const char *provider =3D p[1];
         bool cert_private =3D (p[2] =3D=3D NULL ? false : (atoi_warn(p[2],=
 msglevel) !=3D 0));

 #ifdef DEFAULT_PKCS11_MODULE
diff --git a/src/openvpn/options_parse.c b/src/openvpn/options_parse.c
index a8c4aee..88ab4d2 100644
--- a/src/openvpn/options_parse.c
+++ b/src/openvpn/options_parse.c
@@ -268,7 +268,7 @@
     while (in_src_get(is, line, sizeof(line)))
     {
         (*num_lines)++;
-        char *line_ptr =3D line;
+        const char *line_ptr =3D line;
         /* Remove leading spaces */
         while (isspace(*line_ptr))
         {
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index 47fe0bc..dc4d3ea 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -272,7 +272,7 @@
         return true;
     }

-    struct pull_filter *f;
+    const struct pull_filter *f;

     for (f =3D o->pull_filter_list->head; f; f =3D f->next)
     {
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 15004c0..97f59f3 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -63,7 +63,7 @@

     for (i =3D 0; i < pool->size; ++i)
     {
-        struct ifconfig_pool_entry *ipe =3D &pool->list[i];
+        const struct ifconfig_pool_entry *ipe =3D &pool->list[i];
         if (!ipe->in_use)
         {
             /*
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 9f3ec93..4de7615 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -703,7 +703,7 @@
 #if PROXY_DIGEST_AUTH
         else if (p->auth_method =3D=3D HTTP_AUTH_DIGEST && !processed)
         {
-            char *pa =3D p->proxy_authenticate;
+            const char *pa =3D p->proxy_authenticate;
             const int method =3D p->auth_method;
             ASSERT(pa);

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index ae0f0e2..a030acd 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -271,8 +271,8 @@
     }
 #ifdef ENABLE_MANAGEMENT
     struct tls_session *session =3D &c->c2.tls_multi->session[TM_ACTIVE];
-    struct man_def_auth_context *mda =3D session->opt->mda_context;
-    struct env_set *es =3D session->opt->es;
+    const struct man_def_auth_context *mda =3D session->opt->mda_context;
+    const struct env_set *es =3D session->opt->es;
     unsigned int mda_key_id =3D get_primary_key(c->c2.tls_multi)->mda_key_=
id;

     management_notify_client_cr_response(mda_key_id, mda, es, m);
@@ -913,7 +913,7 @@
 push_options(struct options *o, char **p, msglvl_t msglevel, struct gc_are=
na *gc)
 {
     const char **argv =3D make_extended_arg_array(p, false, gc);
-    char *opt =3D print_argv(argv, gc, 0);
+    const char *opt =3D print_argv(argv, gc, 0);
     push_option(o, opt, msglevel);
 }

@@ -1197,7 +1197,7 @@
                     /* parse route-ipv6 arguments */
                     if (get_ipv6_addr(p[1], &network, &netbits, D_ROUTE_DE=
BUG))
                     {
-                        struct iroute_ipv6 *ir;
+                        const struct iroute_ipv6 *ir;

                         /* does this route-ipv6 match an iroute-ipv6? */
                         for (ir =3D o->iroutes_ipv6; ir !=3D NULL; ir =3D =
ir->next)
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 93e856b..da48d8e 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -667,7 +667,7 @@

     /* parse the routes from opt to rl */
     {
-        struct route_option *ro;
+        const struct route_option *ro;
         for (ro =3D opt->routes; ro; ro =3D ro->next)
         {
             struct addrinfo *netlist =3D NULL;
@@ -799,7 +799,7 @@
     need_remote_ipv6_route =3D false;

     {
-        struct route_ipv6_option *ro6;
+        const struct route_ipv6_option *ro6;
         for (ro6 =3D opt6->routes_ipv6; ro6; ro6 =3D ro6->next)
         {
             struct route_ipv6 *r6;
@@ -1187,7 +1187,7 @@
 {
     if (rl6 && (rl6->iflags & RL_ROUTES_ADDED))
     {
-        struct route_ipv6 *r6;
+        const struct route_ipv6 *r6;
         for (r6 =3D rl6->routes_ipv6; r6; r6 =3D r6->next)
         {
             delete_route_ipv6(r6, tt, es, ctx);
@@ -1226,7 +1226,7 @@
 void
 print_route_options(const struct route_option_list *rol, msglvl_t msglevel)
 {
-    struct route_option *ro;
+    const struct route_option *ro;
     if (rol->flags & RG_ENABLE)
     {
         msg(msglevel, "  [redirect_default_gateway local=3D%d]", (rol->fla=
gs & RG_LOCAL) !=3D 0);
@@ -1335,7 +1335,7 @@
 setenv_routes(struct env_set *es, const struct route_list *rl)
 {
     int i =3D 1;
-    struct route_ipv4 *r;
+    const struct route_ipv4 *r;
     for (r =3D rl->routes; r; r =3D r->next)
     {
         setenv_route(es, r, i++);
@@ -1372,7 +1372,7 @@
 setenv_routes_ipv6(struct env_set *es, const struct route_ipv6_list *rl6)
 {
     int i =3D 1;
-    struct route_ipv6 *r6;
+    const struct route_ipv6 *r6;
     for (r6 =3D rl6->routes_ipv6; r6; r6 =3D r6->next)
     {
         setenv_route_ipv6(es, r6, i++);
@@ -3110,7 +3110,8 @@
     /* scan adapter list */
     if (rgi->flags & RGI_ADDR_DEFINED)
     {
-        struct ifreq *ifr, *ifend;
+        struct ifreq *ifr;
+        const struct ifreq *ifend;
         in_addr_t addr, netmask;
         struct ifreq ifreq;
         struct ifconf ifc;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index da6f870..6cc0209 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -393,7 +393,7 @@

             for (int j =3D 0; j < ce->local_list->len; j++)
             {
-                struct local_entry *le =3D ce->local_list->array[j];
+                const struct local_entry *le =3D ce->local_list->array[j];

                 if (!le->local)
                 {
@@ -1514,7 +1514,7 @@
         /* Socket is always bound on the first matching address,
          * For bound sockets with no remote addr this is the element of
          * the list */
-        struct addrinfo *cur;
+        const struct addrinfo *cur;
         for (cur =3D sock->info.lsa->bind_local; cur; cur =3D cur->ai_next)
         {
             if (!ai_family || ai_family =3D=3D cur->ai_family)
@@ -1930,7 +1930,7 @@
                               const struct link_socket_actual *from_addr)
 {
     struct gc_arena gc =3D gc_new();
-    struct addrinfo *ai;
+    const struct addrinfo *ai;

     switch (from_addr->dest.addr.sa.sa_family)
     {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index d332359c..7f3b4dc 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1478,7 +1478,7 @@
 static bool
 generate_key_expansion(struct tls_multi *multi, struct key_state *ks, stru=
ct tls_session *session)
 {
-    struct key_ctx_bi *key =3D &ks->crypto_options.key_ctx_bi;
+    const struct key_ctx_bi *key =3D &ks->crypto_options.key_ctx_bi;
     bool ret =3D false;
     struct key2 key2;

@@ -1740,7 +1740,7 @@
 static void
 flush_payload_buffer(struct key_state *ks)
 {
-    struct buffer *b;
+    const struct buffer *b;

     while ((b =3D buffer_list_peek(ks->paybuf)))
     {
@@ -2719,7 +2719,7 @@
     /* Outgoing Ciphertext to reliable buffer */
     if (ks->state >=3D S_START)
     {
-        struct buffer *buf =3D reliable_get_buf_output_sequenced(ks->send_=
reliable);
+        const struct buffer *buf =3D reliable_get_buf_output_sequenced(ks-=
>send_reliable);
         if (buf)
         {
             if (!write_outgoing_tls_ciphertext(session, continue_tls_proce=
ss))
@@ -2788,7 +2788,7 @@
     {
         int opcode;

-        struct buffer *buf =3D reliable_send(ks->send_reliable, &opcode);
+        const struct buffer *buf =3D reliable_send(ks->send_reliable, &opc=
ode);
         ASSERT(buf);
         struct buffer b =3D *buf;
         INCR_SENT;
@@ -3151,7 +3151,7 @@
 static void
 check_session_buf_not_used(struct buffer *to_link, struct tls_session *ses=
sion)
 {
-    uint8_t *dataptr =3D to_link->data;
+    const uint8_t *dataptr =3D to_link->data;
     if (!dataptr)
     {
         return;
@@ -3167,7 +3167,7 @@

     for (int i =3D 0; i < KS_SIZE; i++)
     {
-        struct key_state *ks =3D &session->key[i];
+        const struct key_state *ks =3D &session->key[i];
         if (ks->state =3D=3D S_UNDEF)
         {
             continue;
@@ -3232,7 +3232,7 @@
     {
         struct tls_session *session =3D &multi->session[i];
         struct key_state *ks =3D &session->key[KS_PRIMARY];
-        struct key_state *ks_lame =3D &session->key[KS_LAME_DUCK];
+        const struct key_state *ks_lame =3D &session->key[KS_LAME_DUCK];

         /* set initial remote address. This triggers connecting with that
          * session. So we only do that if the TM_ACTIVE session is not
@@ -3433,7 +3433,7 @@

     for (int i =3D 0; i < KEY_SCAN_SIZE; ++i)
     {
-        struct key_state *ks =3D get_key_scan(multi, i);
+        const struct key_state *ks =3D get_key_scan(multi, i);
         if (ks->key_id !=3D key_id)
         {
             continue;
@@ -3985,7 +3985,7 @@
 void
 tls_prepend_opcode_v1(const struct tls_multi *multi, struct buffer *buf)
 {
-    struct key_state *ks =3D multi->save_ks;
+    const struct key_state *ks =3D multi->save_ks;

     msg(D_TLS_DEBUG, __func__);

@@ -3999,7 +3999,7 @@
 void
 tls_prepend_opcode_v2(const struct tls_multi *multi, struct buffer *buf)
 {
-    struct key_state *ks =3D multi->save_ks;
+    const struct key_state *ks =3D multi->save_ks;
     uint32_t peer;

     msg(D_TLS_DEBUG, __func__);
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 0804d2d..e5b55a1 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -409,7 +409,7 @@
                     const char *subject, const struct x509_track *x509_tra=
ck)
 {
     char envname[64];
-    char *serial =3D NULL;
+    const char *serial =3D NULL;
     struct gc_arena gc =3D gc_new();

     /* Save X509 fields in environment */
@@ -699,7 +699,7 @@
                 goto cleanup;
         }

-        struct verify_hash_list *current_hash =3D opt->verify_hash;
+        const struct verify_hash_list *current_hash =3D opt->verify_hash;

         while (current_hash)
         {
@@ -1530,7 +1530,7 @@
 verify_user_pass_management(struct tls_session *session, const struct user=
_pass *up)
 {
     int retval =3D KMDA_ERROR;
-    struct key_state *ks =3D &session->key[KS_PRIMARY]; /* primary key */
+    const struct key_state *ks =3D &session->key[KS_PRIMARY]; /* primary k=
ey */

     /* set username/password in private env space */
     setenv_str(session->opt->es, "password", up->password);
diff --git a/src/openvpnmsica/msica_arg.c b/src/openvpnmsica/msica_arg.c
index a334710..d763d93 100644
--- a/src/openvpnmsica/msica_arg.c
+++ b/src/openvpnmsica/msica_arg.c
@@ -92,7 +92,7 @@
 {
     /* Count required space. */
     size_t size =3D 2 /*x + zero-terminator*/;
-    for (struct msica_arg *p =3D seq->head; p !=3D NULL; p =3D p->next)
+    for (const struct msica_arg *p =3D seq->head; p !=3D NULL; p =3D p->ne=
xt)
     {
         size +=3D wcslen(p->val) + 1 /*space delimiter|zero-terminator*/;
     }
@@ -119,7 +119,7 @@

     /* Join. */
     LPWSTR s =3D str + 1 /*x*/;
-    for (struct msica_arg *p =3D seq->head; p !=3D NULL; p =3D p->next)
+    for (const struct msica_arg *p =3D seq->head; p !=3D NULL; p =3D p->ne=
xt)
     {
         /* Convert zero-terminator into space delimiter. */
         s[0] =3D L' ';
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsic=
a.c
index d698c04..6a71801 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -196,7 +196,7 @@

     /* Count adapters. */
     size_t adapter_count =3D 0;
-    for (struct tap_adapter_node *pAdapter =3D pAdapterList; pAdapter; pAd=
apter =3D pAdapter->pNext)
+    for (const struct tap_adapter_node *pAdapter =3D pAdapterList; pAdapte=
r; pAdapter =3D pAdapter->pNext)
     {
         adapter_count++;
     }
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pa=
m.c
index 3b7bcc2..948b6af 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -526,7 +526,7 @@
 openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, con=
st char *argv[],
                        const char *envp[])
 {
-    struct auth_pam_context *context =3D (struct auth_pam_context *)handle;
+    const struct auth_pam_context *context =3D (struct auth_pam_context *)=
handle;

     if (type =3D=3D OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY && context->foreg=
round_fd >=3D 0)
     {
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 6a4a240..6697d14 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -317,7 +317,7 @@
             return NULL;
         }

-        struct tap_adapter_node *conflict =3D find_adapter_by_name(request=
ed_name, adapter_list);
+        const struct tap_adapter_node *conflict =3D find_adapter_by_name(r=
equested_name, adapter_list);
         if (conflict)
         {
             LPOLESTR adapter_id =3D NULL;
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/open=
vpn/test_buffer.c
index 326de40..ce38bbe 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -88,7 +88,7 @@

     int maxoutput =3D 0;
     unsigned int blocksize =3D 5;
-    char *separator =3D " ";
+    const char *separator =3D " ";
     output =3D format_hex_ex(input, input_size, maxoutput, blocksize, sepa=
rator, &gc);
     assert_string_equal(output, "0100ff10ff 00f00f090a");

@@ -174,7 +174,7 @@
     /* With a max length of 2, no aggregation should take place */
     buffer_list_aggregate_separator(ctx->one_two_three, 2, testsep);
     assert_int_equal(ctx->one_two_three->size, 3);
-    struct buffer *buf =3D buffer_list_peek(ctx->one_two_three);
+    const struct buffer *buf =3D buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_str(buf, teststr1);
 }

@@ -189,7 +189,7 @@
      */
     buffer_list_aggregate_separator(ctx->one_two_three, strlen(expected) +=
 1, testsep);
     assert_int_equal(ctx->one_two_three->size, 2);
-    struct buffer *buf =3D buffer_list_peek(ctx->one_two_three);
+    const struct buffer *buf =3D buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_str(buf, expected);
 }

@@ -201,7 +201,7 @@
     /* Aggregate all */
     buffer_list_aggregate_separator(ctx->one_two_three, 1 << 16, testsep);
     assert_int_equal(ctx->one_two_three->size, 1);
-    struct buffer *buf =3D buffer_list_peek(ctx->one_two_three);
+    const struct buffer *buf =3D buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_str(buf, teststr1 testsep teststr2 testsep teststr3 =
testsep);
 }

@@ -213,7 +213,7 @@
     /* Aggregate all */
     buffer_list_aggregate_separator(ctx->one_two_three, 1 << 16, testnosep=
);
     assert_int_equal(ctx->one_two_three->size, 1);
-    struct buffer *buf =3D buffer_list_peek(ctx->one_two_three);
+    const struct buffer *buf =3D buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_str(buf, teststr1 teststr2 teststr3);
 }

@@ -226,7 +226,7 @@
     /* Aggregate all */
     buffer_list_aggregate_separator(bl_zerolen, 1 << 16, testnosep);
     assert_int_equal(bl_zerolen->size, 1);
-    struct buffer *buf =3D buffer_list_peek(bl_zerolen);
+    const struct buffer *buf =3D buffer_list_peek(bl_zerolen);
     assert_buf_equals_str(buf, "");
 }

@@ -239,7 +239,7 @@
     /* Aggregate all */
     buffer_list_aggregate_separator(bl_emptybuffers, 1 << 16, testnosep);
     assert_int_equal(bl_emptybuffers->size, 1);
-    struct buffer *buf =3D buffer_list_peek(bl_emptybuffers);
+    const struct buffer *buf =3D buffer_list_peek(bl_emptybuffers);
     assert_int_equal(BLEN(buf), 0);
 }

diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index cb4eaa2..8393e1c 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -479,9 +479,9 @@
 crypto_test_hkdf_expand_testa1(void **state)
 {
     /* RFC 5889 A.1 Test Case 1 */
-    uint8_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, =
0x0d, 0xdc, 0x3f,
-                        0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x=
3b, 0xb5, 0x0f,
-                        0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0x=
b3, 0xe5 };
+    const uint8_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, =
0xdf, 0x0d, 0xdc, 0x3f,
+                              0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0x=
c7, 0x3b, 0xb5, 0x0f,
+                              0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0x=
c2, 0xb3, 0xe5 };

     uint8_t info[10] =3D { 0xf0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7,=
 0xf8, 0xf9 };

@@ -500,9 +500,9 @@
 crypto_test_hkdf_expand_testa2(void **state)
 {
     /* RFC 5889 A.2 Test Case 2 */
-    uint8_t prk[32] =3D { 0x06, 0xa6, 0xb8, 0x8c, 0x58, 0x53, 0x36, 0x1a, =
0x06, 0x10, 0x4c,
-                        0x9c, 0xeb, 0x35, 0xb4, 0x5c, 0xef, 0x76, 0x00, 0x=
14, 0x90, 0x46,
-                        0x71, 0x01, 0x4a, 0x19, 0x3f, 0x40, 0xc1, 0x5f, 0x=
c2, 0x44 };
+    const uint8_t prk[32] =3D { 0x06, 0xa6, 0xb8, 0x8c, 0x58, 0x53, 0x36, =
0x1a, 0x06, 0x10, 0x4c,
+                              0x9c, 0xeb, 0x35, 0xb4, 0x5c, 0xef, 0x76, 0x=
00, 0x14, 0x90, 0x46,
+                              0x71, 0x01, 0x4a, 0x19, 0x3f, 0x40, 0xc1, 0x=
5f, 0xc2, 0x44 };

     uint8_t info[80] =3D { 0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7,=
 0xb8, 0xb9, 0xba, 0xbb,
                          0xbc, 0xbd, 0xbe, 0xbf, 0xc0, 0xc1, 0xc2, 0xc3, 0=
xc4, 0xc5, 0xc6, 0xc7,
@@ -531,11 +531,11 @@
 crypto_test_hkdf_expand_testa3(void **state)
 {
     /* RFC 5889 A.3 Test Case 3 */
-    uint8_t prk[32] =3D { 0x19, 0xef, 0x24, 0xa3, 0x2c, 0x71, 0x7b, 0x16, =
0x7f, 0x33, 0xa9,
-                        0x1d, 0x6f, 0x64, 0x8b, 0xdf, 0x96, 0x59, 0x67, 0x=
76, 0xaf, 0xdb,
-                        0x63, 0x77, 0xac, 0x43, 0x4c, 0x1c, 0x29, 0x3c, 0x=
cb, 0x04 };
+    const uint8_t prk[32] =3D { 0x19, 0xef, 0x24, 0xa3, 0x2c, 0x71, 0x7b, =
0x16, 0x7f, 0x33, 0xa9,
+                              0x1d, 0x6f, 0x64, 0x8b, 0xdf, 0x96, 0x59, 0x=
67, 0x76, 0xaf, 0xdb,
+                              0x63, 0x77, 0xac, 0x43, 0x4c, 0x1c, 0x29, 0x=
3c, 0xcb, 0x04 };

-    uint8_t info[] =3D { 0 };
+    const uint8_t info[] =3D { 0 };

     int L =3D 42;
     uint8_t okm[42] =3D { 0x8d, 0xa4, 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f, =
0x71, 0x5f, 0x80,
@@ -555,9 +555,9 @@
     /* tests the HDKF with a label/okm that OpenVPN itself uses in OpenSSL=
 3
      * HDKF unit test*/

-    uint8_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, =
0x0d, 0xdc, 0x3f,
-                        0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x=
3b, 0xb5, 0x0f,
-                        0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0x=
b3, 0xe5 };
+    const uint8_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, =
0xdf, 0x0d, 0xdc, 0x3f,
+                              0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0x=
c7, 0x3b, 0xb5, 0x0f,
+                              0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0x=
c2, 0xb3, 0xe5 };

     uint8_t info[18] =3D { 0x00, 0x1b, 0x0e, 0x6f, 0x76, 0x70, 0x6e, 0x20,=
 0x75,
                          0x6e, 0x69, 0x74, 0x20, 0x74, 0x65, 0x73, 0x74, 0=
x00 };
@@ -677,7 +677,7 @@
 static int
 crypto_test_epoch_setup(void **state)
 {
-    uint16_t *num_future_keys =3D (uint16_t *)*state;
+    const uint16_t *num_future_keys =3D (uint16_t *)*state;
     struct epoch_test_state *data =3D calloc(1, sizeof(struct epoch_test_s=
tate));

     data->gc =3D gc_new();
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index a9ae33f..4a055e7 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -301,7 +301,7 @@
     {
         for (ptr_type i =3D 1; i <=3D 16; ++i)
         {
-            struct hash_element *item =3D hash_lookup_by_value(nhash, (voi=
d *)i);
+            const struct hash_element *item =3D hash_lookup_by_value(nhash=
, (void *)i);
             hash_remove_by_value(nhash, (void *)i);
             /* check item got removed if it was present before */
             if (item)
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index cad2ce0..df9fed7 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -567,7 +567,7 @@
     ASSERT(md_valid("SHA256"));
     hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();

-    uint8_t key[SHA256_DIGEST_LENGTH] =3D { 1, 2, 3, 0 };
+    const uint8_t key[SHA256_DIGEST_LENGTH] =3D { 1, 2, 3, 0 };

     hmac_ctx_init(hmac_ctx, key, "SHA256");
     return hmac_ctx;
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index c40845a..9f5d34a 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -683,7 +683,7 @@
     openvpn_encrypt(&buf, encrypt_workspace, &co);

     /* separate buffer in authenticated data and encrypted data */
-    uint8_t *ad_start =3D BPTR(&buf);
+    const uint8_t *ad_start =3D BPTR(&buf);
     buf_advance(&buf, 4);

     if (epoch)
diff --git a/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c b/=
tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
index a861bfd..89f0642 100644
--- a/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
+++ b/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
@@ -12,7 +12,7 @@
 static void
 pass_any_null_param__returns_null(void **state)
 {
-    char DUMMY[] =3D "DUMMY";
+    const char DUMMY[] =3D "DUMMY";

     assert_null(searchandreplace(NULL, DUMMY, DUMMY));
     assert_null(searchandreplace(DUMMY, NULL, DUMMY));
@@ -22,8 +22,8 @@
 static void
 pass_any_empty_string__returns_null(void **state)
 {
-    char DUMMY[] =3D "DUMMY";
-    char EMPTY[] =3D "";
+    const char DUMMY[] =3D "DUMMY";
+    const char EMPTY[] =3D "";

     assert_null(searchandreplace(EMPTY, DUMMY, DUMMY));
     assert_null(searchandreplace(DUMMY, EMPTY, DUMMY));

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1661?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2b71dae37ebe63c26a66761f877b25d326ed140f
Gerrit-Change-Number: 1661
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--/te0CbntKgk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1661?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Remove instances of constVariable/constVari=
ablePointer cppcheck warnings<br><br>Of varied usefulness, but easier to ju=
st address all of<br>them.<br><br>Change-Id: I2b71dae37ebe63c26a66761f877b2=
5d326ed140f<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br=
>---<br>M dev-tools/cppcheck-suppression<br>M sample/sample-plugins/defer/m=
ulti-auth.c<br>M sample/sample-plugins/log/log.c<br>M sample/sample-plugins=
/log/log_v3.c<br>M sample/sample-plugins/simple/simple.c<br>M src/openvpn/a=
rgv.c<br>M src/openvpn/auth_token.c<br>M src/openvpn/base64.c<br>M src/open=
vpn/buffer.c<br>M src/openvpn/buffer.h<br>M src/openvpn/comp-lz4.c<br>M src=
/openvpn/crypto.c<br>M src/openvpn/crypto_epoch.c<br>M src/openvpn/dco.c<br=
>M src/openvpn/dco_linux.c<br>M src/openvpn/dns.c<br>M src/openvpn/forward.=
c<br>M src/openvpn/init.c<br>M src/openvpn/list.c<br>M src/openvpn/manage.c=
<br>M src/openvpn/misc.c<br>M src/openvpn/mss.c<br>M src/openvpn/mtcp.c<br>=
M src/openvpn/mudp.c<br>M src/openvpn/multi.c<br>M src/openvpn/networking_s=
itnl.c<br>M src/openvpn/options.c<br>M src/openvpn/options_parse.c<br>M src=
/openvpn/options_util.c<br>M src/openvpn/pool.c<br>M src/openvpn/proxy.c<br=
>M src/openvpn/push.c<br>M src/openvpn/route.c<br>M src/openvpn/socket.c<br=
>M src/openvpn/ssl.c<br>M src/openvpn/ssl_verify.c<br>M src/openvpnmsica/ms=
ica_arg.c<br>M src/openvpnmsica/openvpnmsica.c<br>M src/plugins/auth-pam/au=
th-pam.c<br>M src/tapctl/main.c<br>M tests/unit_tests/openvpn/test_buffer.c=
<br>M tests/unit_tests/openvpn/test_crypto.c<br>M tests/unit_tests/openvpn/=
test_misc.c<br>M tests/unit_tests/openvpn/test_pkt.c<br>M tests/unit_tests/=
openvpn/test_ssl.c<br>M tests/unit_tests/plugins/auth-pam/test_search_and_r=
eplace.c<br>46 files changed, 126 insertions(+), 128 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/61/1661/1</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppression b/dev-too=
ls/cppcheck-suppression</span><br><span>index 1f31edb..8a74e84 100644</span=
><br><span>--- a/dev-tools/cppcheck-suppression</span><br><span>+++ b/dev-t=
ools/cppcheck-suppression</span><br><span>@@ -3,8 +3,6 @@</span><br><span> =
constParameter</span><br><span> constParameterCallback</span><br><span> con=
stParameterPointer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-con=
stVariable</span><br><span style=3D"color: hsl(0, 100%, 40%);">-constVariab=
lePointer</span><br><span> variableScope</span><br><span> # We have a lot o=
f library includes, not all of them are really required,</span><br><span> #=
 so ignore them</span><br><span>@@ -33,12 +31,11 @@</span><br><span> knownC=
onditionTrueFalse:src/openvpn/forward.c</span><br><span> knownConditionTrue=
False:src/openvpn/init.c</span><br><span> knownConditionTrueFalse:src/openv=
pn/multi_io.c:163</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# FP=
: cppcheck thinks that management_query_user_pass is always true,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-# but no idea why</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# FP: cppcheck thinks that manage=
ment_query_user_pass is always true</span><br><span> knownConditionTrueFals=
e:src/openvpn/misc.c:97</span><br><span> # FP: cert_uri_supported is a wrap=
per around defines, so it&#39;s</span><br><span> # always constant but diff=
ers depending on OpenSSL version</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-knownConditionTrueFalse:src/openvpn/ssl_openssl.c:1258</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+knownConditionTrueFalse:src/o=
penvpn/ssl_openssl.c:1332</span><br><span> # FP: cppcheck doesn&#39;t under=
stand that the function changes szErrMessage</span><br><span> knownConditio=
nTrueFalse:src/tapctl/main.c:704</span><br><span> knownConditionTrueFalse:s=
rc/openvpnmsica/dllmain.c:164</span><br><span>diff --git a/sample/sample-pl=
ugins/defer/multi-auth.c b/sample/sample-plugins/defer/multi-auth.c</span><=
br><span>index f6bbf44..33fbe61 100644</span><br><span>--- a/sample/sample-=
plugins/defer/multi-auth.c</span><br><span>+++ b/sample/sample-plugins/defe=
r/multi-auth.c</span><br><span>@@ -399,7 +399,7 @@</span><br><span> OPENVPN=
_EXPORT void *</span><br><span> openvpn_plugin_client_constructor_v1(openvp=
n_plugin_handle_t handle)</span><br><span> {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct plugin_context *context =3D (struct plugi=
n_context *)handle;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const struct plugin_context *context =3D (struct plugin_context *)handl=
e;</span><br><span>     plog(context, PLOG_NOTE, &quot;FUNC: openvpn_plugin=
_client_constructor_v1&quot;);</span><br><span>     return calloc(1, sizeof=
(struct plugin_per_client_context));</span><br><span> }</span><br><span>@@ =
-407,7 +407,7 @@</span><br><span> OPENVPN_EXPORT void</span><br><span> open=
vpn_plugin_client_destructor_v1(openvpn_plugin_handle_t handle, void *per_c=
lient_context)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct plugin_context *context =3D (struct plugin_context *=
)handle;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const s=
truct plugin_context *context =3D (struct plugin_context *)handle;</span><b=
r><span>     plog(context, PLOG_NOTE, &quot;FUNC: openvpn_plugin_client_des=
tructor_v1&quot;);</span><br><span>     free(per_client_context);</span><br=
><span> }</span><br><span>diff --git a/sample/sample-plugins/log/log.c b/sa=
mple/sample-plugins/log/log.c</span><br><span>index 330e3e0..76350ee 100644=
</span><br><span>--- a/sample/sample-plugins/log/log.c</span><br><span>+++ =
b/sample/sample-plugins/log/log.c</span><br><span>@@ -173,7 +173,7 @@</span=
><br><span> openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const in=
t type, const char *argv[],</span><br><span>                        const c=
har *envp[])</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    struct plugin_context *context =3D (struct plugin_context *)h=
andle;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const str=
uct plugin_context *context =3D (struct plugin_context *)handle;</span><br>=
<span> </span><br><span>     show(type, argv, envp);</span><br><span> </spa=
n><br><span>diff --git a/sample/sample-plugins/log/log_v3.c b/sample/sample=
-plugins/log/log_v3.c</span><br><span>index deae590..fae7bc4 100644</span><=
br><span>--- a/sample/sample-plugins/log/log_v3.c</span><br><span>+++ b/sam=
ple/sample-plugins/log/log_v3.c</span><br><span>@@ -245,7 +245,7 @@</span><=
br><span> openvpn_plugin_func_v3(const int version, struct openvpn_plugin_a=
rgs_func_in const *args,</span><br><span>                        struct ope=
nvpn_plugin_args_func_return *retptr)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct plugin_context *context =3D (=
struct plugin_context *)args-&gt;handle;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const struct plugin_context *context =3D (struct p=
lugin_context *)args-&gt;handle;</span><br><span> </span><br><span>     pri=
ntf(&quot;\nopenvpn_plugin_func_v3() :::::&gt;&gt; &quot;);</span><br><span=
>     show(args-&gt;type, args-&gt;argv, args-&gt;envp);</span><br><span>di=
ff --git a/sample/sample-plugins/simple/simple.c b/sample/sample-plugins/si=
mple/simple.c</span><br><span>index 687a633..3182be0 100644</span><br><span=
>--- a/sample/sample-plugins/simple/simple.c</span><br><span>+++ b/sample/s=
ample-plugins/simple/simple.c</span><br><span>@@ -104,7 +104,7 @@</span><br=
><span> openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int ty=
pe, const char *argv[],</span><br><span>                        const char =
*envp[])</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct plugin_context *context =3D (struct plugin_context *)handl=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct =
plugin_context *context =3D (struct plugin_context *)handle;</span><br><spa=
n> </span><br><span>     /* get username/password from envp string array */=
</span><br><span>     const char *username =3D get_env(&quot;username&quot;=
, envp);</span><br><span>diff --git a/src/openvpn/argv.c b/src/openvpn/argv=
.c</span><br><span>index 6a5d92e..028671d 100644</span><br><span>--- a/src/=
openvpn/argv.c</span><br><span>+++ b/src/openvpn/argv.c</span><br><span>@@ =
-359,7 +359,7 @@</span><br><span>      *</span><br><span>      */</span><br=
><span>     size_t argc =3D argres-&gt;argc;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    char *f =3D argv_prep_format(format, delim, &amp=
;argc, &amp;argres-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *f =3D argv_prep_format(format, delim, &amp;argc, &a=
mp;argres-&gt;gc);</span><br><span>     if (f =3D=3D NULL)</span><br><span>=
     {</span><br><span>         goto out;</span><br><span>diff --git a/src/=
openvpn/auth_token.c b/src/openvpn/auth_token.c</span><br><span>index d8ca1=
25..0cfcd2d 100644</span><br><span>--- a/src/openvpn/auth_token.c</span><br=
><span>+++ b/src/openvpn/auth_token.c</span><br><span>@@ -217,7 +217,7 @@</=
span><br><span>      * a new token with the empty username since we do not =
want to loose</span><br><span>      * the information that the username can=
not be trusted</span><br><span>      */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct key_state *ks =3D &amp;multi-&gt;session[TM_AC=
TIVE].key[KS_PRIMARY];</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const struct key_state *ks =3D &amp;multi-&gt;session[TM_ACTIVE].key=
[KS_PRIMARY];</span><br><span>     if (ks-&gt;auth_token_state_flags &amp; =
AUTH_TOKEN_VALID_EMPTYUSER)</span><br><span>     {</span><br><span>        =
 hmac_ctx_update(ctx, (const uint8_t *)&quot;&quot;, 0);</span><br><span>di=
ff --git a/src/openvpn/base64.c b/src/openvpn/base64.c</span><br><span>inde=
x 7af8976..5752844 100644</span><br><span>--- a/src/openvpn/base64.c</span>=
<br><span>+++ b/src/openvpn/base64.c</span><br><span>@@ -161,7 +161,7 @@</s=
pan><br><span> {</span><br><span>     const char *p;</span><br><span>     u=
nsigned char *q;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    u=
nsigned char *e =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const unsigned char *e =3D NULL;</span><br><span> </span><br><spa=
n>     q =3D data;</span><br><span>     if (size &gt;=3D 0)</span><br><span=
>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span>i=
ndex eec91a6..46c1d12 100644</span><br><span>--- a/src/openvpn/buffer.c</sp=
an><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -531,7 +531,7 @@=
</span><br><span> void</span><br><span> buf_null_terminate(struct buffer *b=
uf)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    char *last =3D (char *)BLAST(buf);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const char *last =3D (char *)BLAST(buf);</span><br>=
<span>     if (last &amp;&amp; *last =3D=3D &#39;\0&#39;) /* already termin=
ated? */</span><br><span>     {</span><br><span>         return;</span><br>=
<span>@@ -554,7 +554,7 @@</span><br><span> {</span><br><span>     while (tr=
ue)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        char *last =3D (char *)BLAST(buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        const char *last =3D (char *)BLAST(buf)=
;</span><br><span>         if (!last)</span><br><span>         {</span><br>=
<span>             break;</span><br><span>diff --git a/src/openvpn/buffer.h=
 b/src/openvpn/buffer.h</span><br><span>index b4e65ef..6a751ad 100644</span=
><br><span>--- a/src/openvpn/buffer.h</span><br><span>+++ b/src/openvpn/buf=
fer.h</span><br><span>@@ -712,7 +712,7 @@</span><br><span> static inline bo=
ol</span><br><span> buf_copy_n(struct buffer *dest, struct buffer *src, int=
 n)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    uint8_t *cp =3D buf_read_alloc(src, n);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const uint8_t *cp =3D buf_read_alloc(src, n);<=
/span><br><span>     if (!cp)</span><br><span>     {</span><br><span>      =
   return false;</span><br><span>@@ -764,7 +764,7 @@</span><br><span> stati=
c inline bool</span><br><span> buf_read(struct buffer *src, void *dest, int=
 size)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    uint8_t *cp =3D buf_read_alloc(src, size);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const uint8_t *cp =3D buf_read_alloc(src=
, size);</span><br><span>     if (!cp)</span><br><span>     {</span><br><sp=
an>         return false;</span><br><span>diff --git a/src/openvpn/comp-lz4=
.c b/src/openvpn/comp-lz4.c</span><br><span>index 45f138c..48797b0 100644</=
span><br><span>--- a/src/openvpn/comp-lz4.c</span><br><span>+++ b/src/openv=
pn/comp-lz4.c</span><br><span>@@ -164,7 +164,7 @@</span><br><span>     ASSE=
RT(buf_init(&amp;work, frame-&gt;buf.headroom));</span><br><span> </span><b=
r><span>     /* do unframing/swap (assumes buf-&gt;len &gt; 0) */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *head =3D BPTR(buf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t =
*head =3D BPTR(buf);</span><br><span>     c =3D *head;</span><br><span> </s=
pan><br><span>     /* Not compressed */</span><br><span>diff --git a/src/op=
envpn/crypto.c b/src/openvpn/crypto.c</span><br><span>index df9b905..a9a33c=
0 100644</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/s=
rc/openvpn/crypto.c</span><br><span>@@ -1210,7 +1210,7 @@</span><br><span> =
</span><br><span>     /* init implicit IV */</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        cipher_ctx_t *cipher =
=3D co-&gt;key_ctx_bi.encrypt.cipher;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        const cipher_ctx_t *cipher =3D co-&gt;key_ctx_bi.=
encrypt.cipher;</span><br><span>         if (cipher_ctx_mode_aead(cipher))<=
/span><br><span>         {</span><br><span>             ASSERT(cipher_ctx_i=
v_length(cipher) &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><span>@@ -1919,7=
 +1919,7 @@</span><br><span>     const char *seed =3D &quot;tls1-prf-test&q=
uot;;</span><br><span>     const char *secret =3D &quot;tls1-prf-test-secre=
t&quot;;</span><br><span>     uint8_t out[8];</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    uint8_t expected_out[] =3D { &#39;q&#39;, &#39;=
D&#39;, 0xfe, &#39;%&#39;, &#39;@&#39;, &#39;s&#39;, &#39;u&#39;, 0x95 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t exp=
ected_out[] =3D { &#39;q&#39;, &#39;D&#39;, 0xfe, &#39;%&#39;, &#39;@&#39;,=
 &#39;s&#39;, &#39;u&#39;, 0x95 };</span><br><span> </span><br><span>     i=
nt ret =3D ssl_tls1_PRF((uint8_t *)seed, strlen(seed), (uint8_t *)secret,</=
span><br><span>                            strlen(secret), out, sizeof(out)=
);</span><br><span>diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/cr=
ypto_epoch.c</span><br><span>index 54225bf..3812435 100644</span><br><span>=
--- a/src/openvpn/crypto_epoch.c</span><br><span>+++ b/src/openvpn/crypto_e=
poch.c</span><br><span>@@ -213,7 +213,7 @@</span><br><span>      *</span><b=
r><span>      * The last generated key might have been moved to the decrypt=
 key already.</span><br><span>      */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct key_ctx *highest_future_key =3D</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const struct key_ctx *highest_f=
uture_key =3D</span><br><span>         &amp;co-&gt;epoch_data_keys_future[c=
o-&gt;epoch_data_keys_future_count - 1];</span><br><span> </span><br><span>=
     ASSERT(co-&gt;epoch_key_recv.epoch =3D=3D 1 || highest_future_key-&gt;=
epoch =3D=3D co-&gt;epoch_key_recv.epoch</span><br><span>diff --git a/src/o=
penvpn/dco.c b/src/openvpn/dco.c</span><br><span>index f5b7081..17acf8e 100=
644</span><br><span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/openv=
pn/dco.c</span><br><span>@@ -109,7 +109,7 @@</span><br><span>     for (int =
i =3D 0; i &lt; KEY_SCAN_SIZE; ++i)</span><br><span>     {</span><br><span>=
         struct key_state *ks =3D get_key_scan(multi, i);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        struct key_ctx_bi *key =3D &amp=
;ks-&gt;crypto_options.key_ctx_bi;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const struct key_ctx_bi *key =3D &amp;ks-&gt;crypto_=
options.key_ctx_bi;</span><br><span> </span><br><span>         if (ks =3D=
=3D primary)</span><br><span>         {</span><br><span>@@ -560,7 +560,7 @@=
</span><br><span>                         struct sockaddr_storage *local)</=
span><br><span> {</span><br><span> #if ENABLE_IP_PKTINFO</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct context *c =3D &amp;mi-&gt;co=
ntext;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const str=
uct context *c =3D &amp;mi-&gt;context;</span><br><span> </span><br><span> =
    if (!proto_is_udp(c-&gt;c2.link_sockets[0]-&gt;info.proto)</span><br><s=
pan>         || !(c-&gt;options.sockflags &amp; SF_USE_IP_PKTINFO))</span><=
br><span>@@ -608,7 +608,7 @@</span><br><span> int</span><br><span> dco_mult=
i_add_new_peer(struct multi_context *m, struct multi_instance *mi)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
context *c =3D &amp;mi-&gt;context;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const struct context *c =3D &amp;mi-&gt;context;</span>=
<br><span> </span><br><span>     int peer_id =3D c-&gt;c2.tls_multi-&gt;pee=
r_id;</span><br><span>     struct sockaddr *remoteaddr, *localaddr =3D NULL=
;</span><br><span>@@ -685,7 +685,7 @@</span><br><span>     }</span><br><spa=
n> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct context *c =3D &amp;mi-&gt;context;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct context *c =3D &amp;mi-&=
gt;context;</span><br><span>     if (addrtype =3D=3D MR_ADDR_IPV6)</span><b=
r><span>     {</span><br><span> #if defined(_WIN32)</span><br><span>@@ -733=
,7 +733,7 @@</span><br><span>     }</span><br><span>     ASSERT(TUNNEL_TYPE=
(mi-&gt;context.c1.tuntap) =3D=3D DEV_TYPE_TUN);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    struct context *c =3D &amp=
;mi-&gt;context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const struct context *c =3D &amp;mi-&gt;context;</span><br><span> </span><=
br><span>     if (mi-&gt;context.c2.push_ifconfig_defined)</span><br><span>=
     {</span><br><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/d=
co_linux.c</span><br><span>index 40746bd..3732dd7 100644</span><br><span>--=
- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</=
span><br><span>@@ -697,7 +697,7 @@</span><br><span> {</span><br><span>     =
dco_context_t *dco =3D arg;</span><br><span>     struct nlattr *tb[CTRL_ATT=
R_MAX + 1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct=
 genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const struct genlmsghdr *gnlh =3D nlmsg_d=
ata(nlmsg_hdr(msg));</span><br><span> </span><br><span>     nla_parse(tb, C=
TRL_ATTR_MAX, genlmsg_attrdata(gnlh, 0), genlmsg_attrlen(gnlh, 0), NULL);</=
span><br><span> </span><br><span>@@ -706,7 +706,7 @@</span><br><span>      =
   return NL_SKIP;</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct nlattr *mcgrp;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const struct nlattr *mcgrp;=
</span><br><span>     int rem_mcgrp;</span><br><span>     nla_for_each_nest=
ed(mcgrp, tb[CTRL_ATTR_MCAST_GROUPS], rem_mcgrp)</span><br><span>     {</sp=
an><br><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><=
span>index 954ed52..1e49195 100644</span><br><span>--- a/src/openvpn/dns.c<=
/span><br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -132,7 +132,7 @@=
</span><br><span>     }</span><br><span>     else</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct sockaddr_=
in6 *sin6 =3D (struct sockaddr_in6 *)ai-&gt;ai_addr;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const struct sockaddr_in6 *sin6 =
=3D (struct sockaddr_in6 *)ai-&gt;ai_addr;</span><br><span>         server-=
&gt;addr[server-&gt;addr_count].in.a6 =3D sin6-&gt;sin6_addr;</span><br><sp=
an>     }</span><br><span> </span><br><span>@@ -156,7 +156,7 @@</span><br><=
span>     /* Append all domains to the end of the list */</span><br><span> =
    while (*domains)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        char *domain =3D *domains++;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        const char *domain =3D *doma=
ins++;</span><br><span>         if (!validate_domain(domain))</span><br><sp=
an>         {</span><br><span>             return false;</span><br><span>@@=
 -699,7 +699,7 @@</span><br><span> run_up_down_command(bool up, struct opti=
ons *o, const struct tuntap *tt,</span><br><span>                     struc=
t dns_updown_runner_info *updown_runner)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct dns_options *dns =3D &amp;=
o-&gt;dns_options;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const struct dns_options *dns =3D &amp;o-&gt;dns_options;</span><br><spa=
n>     if (!dns-&gt;updown || (o-&gt;up_script &amp;&amp; !dns_updown_user_=
set(dns) &amp;&amp; !dns_updown_forced(dns)))</span><br><span>     {</span>=
<br><span>         return;</span><br><span>diff --git a/src/openvpn/forward=
.c b/src/openvpn/forward.c</span><br><span>index 53eab4d..a4747ed 100644</s=
pan><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn=
/forward.c</span><br><span>@@ -1215,7 +1215,7 @@</span><br><span> {</span><=
br><span>     if (float_sa-&gt;sa_family =3D=3D AF_INET)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct so=
ckaddr_in *float4 =3D (struct sockaddr_in *)float_sa;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const struct sockaddr_in *float4 =
=3D (struct sockaddr_in *)float_sa;</span><br><span>         /* DCO treats =
IPv4-mapped IPv6 addresses as pure IPv4. However, on a</span><br><span>    =
      * dual-stack socket, we need to preserve the mapping otherwise openvp=
n</span><br><span>          * will not be able to find the peer by its tran=
sport address.</span><br><span>@@ -1238,7 +1238,7 @@</span><br><span>     }=
</span><br><span>     else</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        struct sockaddr_in6 *float6 =3D (struct=
 sockaddr_in6 *)float_sa;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        const struct sockaddr_in6 *float6 =3D (struct sockaddr_in6 *)=
float_sa;</span><br><span>         memcpy(&amp;out_osaddr-&gt;addr.in6, flo=
at6, sizeof(struct sockaddr_in6));</span><br><span>     }</span><br><span> =
}</span><br><span>@@ -1369,7 +1369,7 @@</span><br><span>     }</span><br><s=
pan> </span><br><span>     struct openvpn_sockaddr *link_addr =3D &amp;c-&g=
t;c2.to_link_addr-&gt;dest;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct link_socket_info *lsi =3D get_link_socket_info(c);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct link_socke=
t_info *lsi =3D get_link_socket_info(c);</span><br><span> </span><br><span>=
     int ip_hdr_offset =3D 0;</span><br><span>     int tun_ip_ver =3D get_t=
un_ip_ver(TUNNEL_TYPE(c-&gt;c1.tuntap), buf, &amp;ip_hdr_offset);</span><br=
><span>@@ -2241,7 +2241,7 @@</span><br><span> </span><br><span>            =
         if (e-&gt;arg &gt;=3D MULTI_N)</span><br><span>                   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
      struct event_arg *ev_arg =3D (struct event_arg *)e-&gt;arg;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                        const=
 struct event_arg *ev_arg =3D (struct event_arg *)e-&gt;arg;</span><br><spa=
n>                         if (ev_arg-&gt;type !=3D EVENT_ARG_LINK_SOCKET)<=
/span><br><span>                         {</span><br><span>                =
             c-&gt;c2.event_set_status =3D ES_ERROR;</span><br><span>diff -=
-git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index caaa76=
9..af652ac 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>=
+++ b/src/openvpn/init.c</span><br><span>@@ -319,8 +319,8 @@</span><br><spa=
n> management_callback_remote_entry_count(void *arg)</span><br><span> {</sp=
an><br><span>     ASSERT(arg);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    struct context *c =3D (struct context *)arg;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct connection_list *l =3D c-&gt=
;options.connection_list;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const struct context *c =3D (struct context *)arg;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const struct connection_list *=
l =3D c-&gt;options.connection_list;</span><br><span> </span><br><span>    =
 return l-&gt;len;</span><br><span> }</span><br><span>@@ -342,7 +342,7 @@</=
span><br><span> </span><br><span>     if (index &lt; l-&gt;len)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        st=
ruct connection_entry *ce =3D l-&gt;array[index];</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        const struct connection_entry *ce =3D=
 l-&gt;array[index];</span><br><span>         const char *proto =3D proto2a=
scii(ce-&gt;proto, ce-&gt;af, false);</span><br><span>         const char *=
status =3D (ce-&gt;flags &amp; CE_DISABLED) ? &quot;disabled&quot; : &quot;=
enabled&quot;;</span><br><span> </span><br><span>@@ -525,7 +525,7 @@</span>=
<br><span> {</span><br><span>     struct connection_list *l =3D c-&gt;optio=
ns.connection_list;</span><br><span>     bool ce_defined;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct connection_entry *ce;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct connectio=
n_entry *ce;</span><br><span>     int n_cycles =3D 0;</span><br><span> </sp=
an><br><span>     do</span><br><span>@@ -1582,9 +1582,9 @@</span><br><span>=
     if (management)</span><br><span>     {</span><br><span>         in_add=
r_t *tun_local =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        struct in6_addr *tun_local6 =3D NULL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        const struct in6_addr *tun_local6 =3D =
NULL;</span><br><span>         struct openvpn_sockaddr local, remote;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct link_socket_=
actual *actual;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    const struct link_socket_actual *actual;</span><br><span>         sockl=
en_t sa_len =3D sizeof(local);</span><br><span>         const char *detail =
=3D &quot;SUCCESS&quot;;</span><br><span>         if (flags &amp; ISC_ERROR=
S)</span><br><span>diff --git a/src/openvpn/list.c b/src/openvpn/list.c</sp=
an><br><span>index f0e9908..2e1cf05 100644</span><br><span>--- a/src/openvp=
n/list.c</span><br><span>+++ b/src/openvpn/list.c</span><br><span>@@ -165,7=
 +165,7 @@</span><br><span> hash_remove_by_value(struct hash *hash, void *v=
alue)</span><br><span> {</span><br><span>     struct hash_iterator hi;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct hash_element *h=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct =
hash_element *he;</span><br><span> </span><br><span>     hash_iterator_init=
(hash, &amp;hi);</span><br><span>     while ((he =3D hash_iterator_next(&am=
p;hi)))</span><br><span>diff --git a/src/openvpn/manage.c b/src/openvpn/man=
age.c</span><br><span>index c082f51..604bbcd 100644</span><br><span>--- a/s=
rc/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c</span><br><s=
pan>@@ -3820,7 +3820,7 @@</span><br><span> {</span><br><span>     int ok;</=
span><br><span>     char *result =3D NULL;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct buffer *buf;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const struct buffer *buf;</span><br><span> </s=
pan><br><span>     ok =3D management_query_multiline(man, b64_data, prompt,=
 cmd, state, input);</span><br><span>     if (ok &amp;&amp; buffer_list_def=
ined(*input))</span><br><span>@@ -3849,7 +3849,7 @@</span><br><span> {</spa=
n><br><span>     int ok;</span><br><span>     char *result =3D NULL;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer *buf;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct buffer =
*buf;</span><br><span> </span><br><span>     ok =3D management_query_multil=
ine(man, b64_data, prompt, cmd, state, input);</span><br><span>     if (ok =
&amp;&amp; buffer_list_defined(*input))</span><br><span>diff --git a/src/op=
envpn/misc.c b/src/openvpn/misc.c</span><br><span>index 10bfc35..6563b83 10=
0644</span><br><span>--- a/src/openvpn/misc.c</span><br><span>+++ b/src/ope=
nvpn/misc.c</span><br><span>@@ -131,7 +131,7 @@</span><br><span>     struct=
 auth_challenge_info *ac;</span><br><span>     const int len =3D strlen(aut=
h_challenge);</span><br><span>     char *work =3D (char *)gc_malloc(len + 1=
, false, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char=
 *cp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 *cp;</span><br><span> </span><br><span>     struct buffer b;</span><br><sp=
an>     buf_set_read(&amp;b, (const uint8_t *)auth_challenge, len);</span><=
br><span>diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c</span><br><span=
>index 14112b4..36bbb43 100644</span><br><span>--- a/src/openvpn/mss.c</spa=
n><br><span>+++ b/src/openvpn/mss.c</span><br><span>@@ -65,7 +65,7 @@</span=
><br><span>         struct buffer newbuf =3D *buf;</span><br><span>        =
 if (buf_advance(&amp;newbuf, hlen))</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            struct openvpn_tcphdr=
 *tc =3D (struct openvpn_tcphdr *)BPTR(&amp;newbuf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            const struct openvpn_tcphdr *=
tc =3D (struct openvpn_tcphdr *)BPTR(&amp;newbuf);</span><br><span>        =
     if (tc-&gt;flags &amp; OPENVPN_TCPH_SYN_MASK)</span><br><span>        =
     {</span><br><span>                 mss_fixup_dowork(&amp;newbuf, maxms=
s);</span><br><span>@@ -122,7 +122,7 @@</span><br><span>     newbuf =3D *bu=
f;</span><br><span>     if (buf_advance(&amp;newbuf, 40) &amp;&amp; BLENZ(&=
amp;newbuf) &gt;=3D sizeof(struct openvpn_tcphdr))</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct openvpn_=
tcphdr *tc =3D (struct openvpn_tcphdr *)BPTR(&amp;newbuf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        const struct openvpn_tcphdr =
*tc =3D (struct openvpn_tcphdr *)BPTR(&amp;newbuf);</span><br><span>       =
  if (tc-&gt;flags &amp; OPENVPN_TCPH_SYN_MASK)</span><br><span>         {<=
/span><br><span>             mss_fixup_dowork(&amp;newbuf, maxmss - 20);</s=
pan><br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><b=
r><span>index 7651b4d..df94a70 100644</span><br><span>--- a/src/openvpn/mtc=
p.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -130,7 +130=
,7 @@</span><br><span> void</span><br><span> multi_tcp_dereference_instance=
(struct multi_io *multi_io, struct multi_instance *mi)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link_socket =
*sock =3D mi-&gt;context.c2.link_sockets[0];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const struct link_socket *sock =3D mi-&gt;cont=
ext.c2.link_sockets[0];</span><br><span>     if (sock &amp;&amp; mi-&gt;soc=
ket_set_called)</span><br><span>     {</span><br><span>         event_del(m=
ulti_io-&gt;es, socket_event_handle(sock));</span><br><span>diff --git a/sr=
c/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index 432c79a..50d72d=
5 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src=
/openvpn/mudp.c</span><br><span>@@ -74,7 +74,7 @@</span><br><span>     verd=
ict =3D tls_pre_decrypt_lite(tas, state, &amp;m-&gt;top.c2.from, &amp;m-&gt=
;top.c2.buf);</span><br><span> </span><br><span>     hmac_ctx_t *hmac =3D m=
-&gt;top.c2.session_id_hmac;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct openvpn_sockaddr *from =3D &amp;m-&gt;top.c2.from.dest;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct open=
vpn_sockaddr *from =3D &amp;m-&gt;top.c2.from.dest;</span><br><span>     in=
t handwindow =3D m-&gt;top.options.handshake_window;</span><br><span> </spa=
n><br><span>     if (verdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=
=3D VERDICT_VALID_RESET_V2)</span><br><span>@@ -201,7 +201,7 @@</span><br><=
span>         struct hash_element *he;</span><br><span>         const uint3=
2_t hv =3D hash_value(hash, &amp;real);</span><br><span>         struct has=
h_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        uint8_t *ptr =3D BPTR(&amp;m-&gt;top.c2.buf);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const uint8=
_t *ptr =3D BPTR(&amp;m-&gt;top.c2.buf);</span><br><span>         uint8_t o=
p =3D ptr[0] &gt;&gt; P_OPCODE_SHIFT;</span><br><span>         bool v2 =3D =
(op =3D=3D P_DATA_V2) &amp;&amp; (m-&gt;top.c2.buf.len &gt;=3D (1 + 3));</s=
pan><br><span>         bool peer_id_disabled =3D false;</span><br><span>dif=
f --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 0=
6e3758..6c833c0 100644</span><br><span>--- a/src/openvpn/multi.c</span><br>=
<span>+++ b/src/openvpn/multi.c</span><br><span>@@ -86,7 +86,7 @@</span><br=
><span>     struct gc_arena gc =3D gc_new();</span><br><span>     struct en=
v_set *es;</span><br><span>     bool ret =3D true;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct plugin_list *plugins;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const struct plugin_list *plu=
gins;</span><br><span> </span><br><span>     /* get environmental variable =
source */</span><br><span>     if (mi &amp;&amp; mi-&gt;context.c2.es)</spa=
n><br><span>@@ -1794,7 +1794,7 @@</span><br><span>      * Push the first ci=
pher from --data-ciphers to the client that</span><br><span>      * the cli=
ent announces to be supporting.</span><br><span>      */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    char *push_cipher =3D</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const char *push_cipher =3D</s=
pan><br><span>         ncp_get_best_cipher(o-&gt;ncp_ciphers, peer_info, tl=
s_multi-&gt;remote_ciphername, &amp;o-&gt;gc);</span><br><span>     if (pus=
h_cipher)</span><br><span>     {</span><br><span>@@ -1925,7 +1925,7 @@</spa=
n><br><span> static enum client_connect_return</span><br><span> ccs_test_de=
ferred_ret_file(struct multi_instance *mi)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct client_connect_defer_sta=
te *ccs =3D &amp;(mi-&gt;client_connect_defer_state);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct client_connect_defer_sta=
te *ccs =3D &amp;(mi-&gt;client_connect_defer_state);</span><br><span>     =
FILE *fp =3D fopen(ccs-&gt;deferred_ret_file, &quot;r&quot;);</span><br><sp=
an>     if (!fp)</span><br><span>     {</span><br><span>@@ -2166,7 +2166,7 =
@@</span><br><span> {</span><br><span>     ASSERT(mi);</span><br><span>    =
 ASSERT(option_types_found);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct client_connect_defer_state *ccs =3D &amp;(mi-&gt;client_c=
onnect_defer_state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const struct client_connect_defer_state *ccs =3D &amp;(mi-&gt;client_c=
onnect_defer_state);</span><br><span>     enum client_connect_return ret =
=3D CC_RET_SKIPPED;</span><br><span> </span><br><span>     ret =3D ccs_test=
_deferred_ret_file(mi);</span><br><span>@@ -2568,7 +2568,7 @@</span><br><sp=
an> override_locked_username(struct multi_instance *mi)</span><br><span> {<=
/span><br><span>     struct tls_multi *multi =3D mi-&gt;context.c2.tls_mult=
i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct options =
*options =3D &amp;mi-&gt;context.options;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const struct options *options =3D &amp;mi-&gt;con=
text.options;</span><br><span>     struct tls_session *session =3D &amp;mul=
ti-&gt;session[TM_ACTIVE];</span><br><span> </span><br><span>     if (!mult=
i-&gt;locked_username)</span><br><span>@@ -3104,7 +3104,7 @@</span><br><spa=
n>         struct multi_instance *ex_mi =3D (struct multi_instance *)he-&gt=
;value;</span><br><span> </span><br><span>         struct tls_multi *m1 =3D=
 mi-&gt;context.c2.tls_multi;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        struct tls_multi *m2 =3D ex_mi-&gt;context.c2.tls_multi;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct t=
ls_multi *m2 =3D ex_mi-&gt;context.c2.tls_multi;</span><br><span> </span><b=
r><span>         /* do not float if target address is taken by client with =
another cert */</span><br><span>         if (!cert_hash_compare(m1-&gt;lock=
ed_cert_hash_set, m2-&gt;locked_cert_hash_set))</span><br><span>@@ -3864,7 =
+3864,7 @@</span><br><span> static int</span><br><span> management_callback=
_n_clients(void *arg)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct multi_context *m =3D (struct multi_context *)=
arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struc=
t multi_context *m =3D (struct multi_context *)arg;</span><br><span>     re=
turn m-&gt;n_clients;</span><br><span> }</span><br><span> </span><br><span>=
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.=
c</span><br><span>index b3f8e2b..e6e72d0 100644</span><br><span>--- a/src/o=
penvpn/networking_sitnl.c</span><br><span>+++ b/src/openvpn/networking_sitn=
l.c</span><br><span>@@ -462,7 +462,7 @@</span><br><span>     struct rtattr =
*rta =3D RTM_RTA(r);</span><br><span>     size_t len =3D n-&gt;nlmsg_len - =
NLMSG_LENGTH(sizeof(*r));</span><br><span>     unsigned int table, ifindex =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    void *gw =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
void *gw =3D NULL;</span><br><span> </span><br><span>     /* filter-out non=
-zero dst prefixes */</span><br><span>     if (res-&gt;default_only &amp;&a=
mp; r-&gt;rtm_dst_len !=3D 0)</span><br><span>@@ -1179,7 +1179,7 @@</span><=
br><span> net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, in=
t prefixlen, const in_addr_t *gw,</span><br><span>                  const c=
har *iface, uint32_t table, int metric)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    in_addr_t *dst_ptr =3D NULL, *gw_p=
tr =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st in_addr_t *dst_ptr =3D NULL, *gw_ptr =3D NULL;</span><br><span>     in_a=
ddr_t dst_be =3D 0, gw_be =3D 0;</span><br><span>     char dst_str[INET_ADD=
RSTRLEN];</span><br><span>     char gw_str[INET_ADDRSTRLEN];</span><br><spa=
n>@@ -1326,7 +1326,7 @@</span><br><span> #if defined(ENABLE_DCO)</span><br>=
<span>     if (arg &amp;&amp; (strcmp(type, OVPN_FAMILY_NAME) =3D=3D 0))</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       dco_context_t *dco =3D arg;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const dco_context_t *dco =3D arg;</span><br><span>  =
       struct rtattr *data =3D SITNL_NEST(&amp;req.n, sizeof(req), IFLA_INF=
O_DATA);</span><br><span> </span><br><span>         /* the netlink format i=
s uint8_t for this and using something</span><br><span>diff --git a/src/ope=
nvpn/options.c b/src/openvpn/options.c</span><br><span>index 53fb060..fd0d3=
fc 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b=
/src/openvpn/options.c</span><br><span>@@ -1877,7 +1877,7 @@</span><br><spa=
n>         SHOW_INT(verify_hash_algo);</span><br><span>         SHOW_INT(ve=
rify_hash_depth);</span><br><span>         struct gc_arena gc =3D gc_new();=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct verify=
_hash_list *hl =3D o-&gt;verify_hash;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        const struct verify_hash_list *hl =3D o-&gt;verif=
y_hash;</span><br><span>         int digest_len =3D</span><br><span>       =
      (o-&gt;verify_hash_algo =3D=3D MD_SHA1) ? SHA_DIGEST_LENGTH : SHA256_=
DIGEST_LENGTH;</span><br><span>         while (hl)</span><br><span>@@ -2333=
,7 +2333,7 @@</span><br><span> </span><br><span>     for (int i =3D 0; i &l=
t; ce-&gt;local_list-&gt;len; i++)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        struct local_entry *le =3D ce-&=
gt;local_list-&gt;array[i];</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        const struct local_entry *le =3D ce-&gt;local_list-&gt;arra=
y[i];</span><br><span> </span><br><span>         if (proto_is_net(le-&gt;pr=
oto) &amp;&amp; string_defined_equal(le-&gt;local, ce-&gt;remote)</span><br=
><span>             &amp;&amp; string_defined_equal(le-&gt;port, ce-&gt;rem=
ote_port))</span><br><span>@@ -3988,7 +3988,7 @@</span><br><span>     {</sp=
an><br><span>         char *fullpath =3D</span><br><span>             strin=
g_alloc(file, NULL); /* POSIX dirname() implementation may modify its argum=
ents */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        char *=
dirpath =3D dirname(fullpath);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        const char *dirpath =3D dirname(fullpath);</span><br><sp=
an> </span><br><span>         if (platform_access(dirpath, mode | X_OK) !=
=3D 0)</span><br><span>         {</span><br><span>@@ -4219,7 +4219,7 @@</sp=
an><br><span>     ASSERT(options-&gt;connection_list);</span><br><span>    =
 for (int i =3D 0; i &lt; options-&gt;connection_list-&gt;len; ++i)</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  struct connection_entry *ce =3D options-&gt;connection_list-&gt;array[i];=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struc=
t connection_entry *ce =3D options-&gt;connection_list-&gt;array[i];</span>=
<br><span> </span><br><span>         errs |=3D check_file_access_inline(ce-=
&gt;tls_auth_file_inline, CHKACC_FILE | CHKACC_PRIVATE,</span><br><span>   =
                                       ce-&gt;tls_auth_file, R_OK, &quot;--=
tls-auth&quot;);</span><br><span>@@ -9091,7 +9091,7 @@</span><br><span> #if=
def ENABLE_PKCS11</span><br><span>     else if (streq(p[0], &quot;show-pkcs=
11-ids&quot;) &amp;&amp; !p[3])</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        char *provider =3D p[1];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        const char *provider =
=3D p[1];</span><br><span>         bool cert_private =3D (p[2] =3D=3D NULL =
? false : (atoi_warn(p[2], msglevel) !=3D 0));</span><br><span> </span><br>=
<span> #ifdef DEFAULT_PKCS11_MODULE</span><br><span>diff --git a/src/openvp=
n/options_parse.c b/src/openvpn/options_parse.c</span><br><span>index a8c4a=
ee..88ab4d2 100644</span><br><span>--- a/src/openvpn/options_parse.c</span>=
<br><span>+++ b/src/openvpn/options_parse.c</span><br><span>@@ -268,7 +268,=
7 @@</span><br><span>     while (in_src_get(is, line, sizeof(line)))</span>=
<br><span>     {</span><br><span>         (*num_lines)++;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        char *line_ptr =3D line;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *line_p=
tr =3D line;</span><br><span>         /* Remove leading spaces */</span><br=
><span>         while (isspace(*line_ptr))</span><br><span>         {</span=
><br><span>diff --git a/src/openvpn/options_util.c b/src/openvpn/options_ut=
il.c</span><br><span>index 47fe0bc..dc4d3ea 100644</span><br><span>--- a/sr=
c/openvpn/options_util.c</span><br><span>+++ b/src/openvpn/options_util.c</=
span><br><span>@@ -272,7 +272,7 @@</span><br><span>         return true;</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    struct pull_filter *f;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const struct pull_filter *f;</span><br><span> <=
/span><br><span>     for (f =3D o-&gt;pull_filter_list-&gt;head; f; f =3D f=
-&gt;next)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/=
pool.c b/src/openvpn/pool.c</span><br><span>index 15004c0..97f59f3 100644</=
span><br><span>--- a/src/openvpn/pool.c</span><br><span>+++ b/src/openvpn/p=
ool.c</span><br><span>@@ -63,7 +63,7 @@</span><br><span> </span><br><span> =
    for (i =3D 0; i &lt; pool-&gt;size; ++i)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        struct ifconfig_pool_=
entry *ipe =3D &amp;pool-&gt;list[i];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        const struct ifconfig_pool_entry *ipe =3D &amp;po=
ol-&gt;list[i];</span><br><span>         if (!ipe-&gt;in_use)</span><br><sp=
an>         {</span><br><span>             /*</span><br><span>diff --git a/=
src/openvpn/proxy.c b/src/openvpn/proxy.c</span><br><span>index 9f3ec93..4d=
e7615 100644</span><br><span>--- a/src/openvpn/proxy.c</span><br><span>+++ =
b/src/openvpn/proxy.c</span><br><span>@@ -703,7 +703,7 @@</span><br><span> =
#if PROXY_DIGEST_AUTH</span><br><span>         else if (p-&gt;auth_method =
=3D=3D HTTP_AUTH_DIGEST &amp;&amp; !processed)</span><br><span>         {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            char *pa =
=3D p-&gt;proxy_authenticate;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            const char *pa =3D p-&gt;proxy_authenticate;</span><b=
r><span>             const int method =3D p-&gt;auth_method;</span><br><spa=
n>             ASSERT(pa);</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/push.c b/src/openvpn/push.c</span><br><span>index ae0f0e2..a030a=
cd 100644</span><br><span>--- a/src/openvpn/push.c</span><br><span>+++ b/sr=
c/openvpn/push.c</span><br><span>@@ -271,8 +271,8 @@</span><br><span>     }=
</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     struct tls_=
session *session =3D &amp;c-&gt;c2.tls_multi-&gt;session[TM_ACTIVE];</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct man_def_auth_cont=
ext *mda =3D session-&gt;opt-&gt;mda_context;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    struct env_set *es =3D session-&gt;opt-&gt;es;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct man=
_def_auth_context *mda =3D session-&gt;opt-&gt;mda_context;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const struct env_set *es =3D se=
ssion-&gt;opt-&gt;es;</span><br><span>     unsigned int mda_key_id =3D get_=
primary_key(c-&gt;c2.tls_multi)-&gt;mda_key_id;</span><br><span> </span><br=
><span>     management_notify_client_cr_response(mda_key_id, mda, es, m);</=
span><br><span>@@ -913,7 +913,7 @@</span><br><span> push_options(struct opt=
ions *o, char **p, msglvl_t msglevel, struct gc_arena *gc)</span><br><span>=
 {</span><br><span>     const char **argv =3D make_extended_arg_array(p, fa=
lse, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *op=
t =3D print_argv(argv, gc, 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *opt =3D print_argv(argv, gc, 0);</span><br><span=
>     push_option(o, opt, msglevel);</span><br><span> }</span><br><span> </=
span><br><span>@@ -1197,7 +1197,7 @@</span><br><span>                     /=
* parse route-ipv6 arguments */</span><br><span>                     if (ge=
t_ipv6_addr(p[1], &amp;network, &amp;netbits, D_ROUTE_DEBUG))</span><br><sp=
an>                     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                        struct iroute_ipv6 *ir;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        const struct irou=
te_ipv6 *ir;</span><br><span> </span><br><span>                         /* =
does this route-ipv6 match an iroute-ipv6? */</span><br><span>             =
            for (ir =3D o-&gt;iroutes_ipv6; ir !=3D NULL; ir =3D ir-&gt;nex=
t)</span><br><span>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</=
span><br><span>index 93e856b..da48d8e 100644</span><br><span>--- a/src/open=
vpn/route.c</span><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -6=
67,7 +667,7 @@</span><br><span> </span><br><span>     /* parse the routes f=
rom opt to rl */</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        struct route_option *ro;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        const struct route_option *ro;</span=
><br><span>         for (ro =3D opt-&gt;routes; ro; ro =3D ro-&gt;next)</sp=
an><br><span>         {</span><br><span>             struct addrinfo *netli=
st =3D NULL;</span><br><span>@@ -799,7 +799,7 @@</span><br><span>     need_=
remote_ipv6_route =3D false;</span><br><span> </span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct route_ipv6_o=
ption *ro6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
const struct route_ipv6_option *ro6;</span><br><span>         for (ro6 =3D =
opt6-&gt;routes_ipv6; ro6; ro6 =3D ro6-&gt;next)</span><br><span>         {=
</span><br><span>             struct route_ipv6 *r6;</span><br><span>@@ -11=
87,7 +1187,7 @@</span><br><span> {</span><br><span>     if (rl6 &amp;&amp; =
(rl6-&gt;iflags &amp; RL_ROUTES_ADDED))</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        struct route_ipv6 *r6;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct ro=
ute_ipv6 *r6;</span><br><span>         for (r6 =3D rl6-&gt;routes_ipv6; r6;=
 r6 =3D r6-&gt;next)</span><br><span>         {</span><br><span>           =
  delete_route_ipv6(r6, tt, es, ctx);</span><br><span>@@ -1226,7 +1226,7 @@=
</span><br><span> void</span><br><span> print_route_options(const struct ro=
ute_option_list *rol, msglvl_t msglevel)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct route_option *ro;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const struct route_optio=
n *ro;</span><br><span>     if (rol-&gt;flags &amp; RG_ENABLE)</span><br><s=
pan>     {</span><br><span>         msg(msglevel, &quot;  [redirect_default=
_gateway local=3D%d]&quot;, (rol-&gt;flags &amp; RG_LOCAL) !=3D 0);</span><=
br><span>@@ -1335,7 +1335,7 @@</span><br><span> setenv_routes(struct env_se=
t *es, const struct route_list *rl)</span><br><span> {</span><br><span>    =
 int i =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct route_ipv4 *r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const struct route_ipv4 *r;</span><br><span>     for (r =3D rl-&gt;routes=
; r; r =3D r-&gt;next)</span><br><span>     {</span><br><span>         sete=
nv_route(es, r, i++);</span><br><span>@@ -1372,7 +1372,7 @@</span><br><span=
> setenv_routes_ipv6(struct env_set *es, const struct route_ipv6_list *rl6)=
</span><br><span> {</span><br><span>     int i =3D 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct route_ipv6 *r6;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const struct route_ipv6 *r6;</sp=
an><br><span>     for (r6 =3D rl6-&gt;routes_ipv6; r6; r6 =3D r6-&gt;next)<=
/span><br><span>     {</span><br><span>         setenv_route_ipv6(es, r6, i=
++);</span><br><span>@@ -3110,7 +3110,8 @@</span><br><span>     /* scan ada=
pter list */</span><br><span>     if (rgi-&gt;flags &amp; RGI_ADDR_DEFINED)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        struct ifreq *ifr, *ifend;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        struct ifreq *ifr;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        const struct ifreq *ifend;</span><br><span>=
         in_addr_t addr, netmask;</span><br><span>         struct ifreq ifr=
eq;</span><br><span>         struct ifconf ifc;</span><br><span>diff --git =
a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index da6f870=
..6cc0209 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><span=
>+++ b/src/openvpn/socket.c</span><br><span>@@ -393,7 +393,7 @@</span><br><=
span> </span><br><span>             for (int j =3D 0; j &lt; ce-&gt;local_l=
ist-&gt;len; j++)</span><br><span>             {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                struct local_entry *le =3D ce-&g=
t;local_list-&gt;array[j];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                const struct local_entry *le =3D ce-&gt;local_list-&=
gt;array[j];</span><br><span> </span><br><span>                 if (!le-&gt=
;local)</span><br><span>                 {</span><br><span>@@ -1514,7 +1514=
,7 @@</span><br><span>         /* Socket is always bound on the first match=
ing address,</span><br><span>          * For bound sockets with no remote a=
ddr this is the element of</span><br><span>          * the list */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        struct addrinfo *cur;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct=
 addrinfo *cur;</span><br><span>         for (cur =3D sock-&gt;info.lsa-&gt=
;bind_local; cur; cur =3D cur-&gt;ai_next)</span><br><span>         {</span=
><br><span>             if (!ai_family || ai_family =3D=3D cur-&gt;ai_famil=
y)</span><br><span>@@ -1930,7 +1930,7 @@</span><br><span>                  =
             const struct link_socket_actual *from_addr)</span><br><span> {=
</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct addrinfo *ai;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const struct addrinfo *ai;</span>=
<br><span> </span><br><span>     switch (from_addr-&gt;dest.addr.sa.sa_fami=
ly)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/ssl.c b=
/src/openvpn/ssl.c</span><br><span>index d332359c..7f3b4dc 100644</span><br=
><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</spa=
n><br><span>@@ -1478,7 +1478,7 @@</span><br><span> static bool</span><br><s=
pan> generate_key_expansion(struct tls_multi *multi, struct key_state *ks, =
struct tls_session *session)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct key_ctx_bi *key =3D &amp;ks-&gt;crypto=
_options.key_ctx_bi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const struct key_ctx_bi *key =3D &amp;ks-&gt;crypto_options.key_ctx_bi=
;</span><br><span>     bool ret =3D false;</span><br><span>     struct key2=
 key2;</span><br><span> </span><br><span>@@ -1740,7 +1740,7 @@</span><br><s=
pan> static void</span><br><span> flush_payload_buffer(struct key_state *ks=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct buffer *b;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const struct buffer *b;</span><br><span> </span><br><span>     while (=
(b =3D buffer_list_peek(ks-&gt;paybuf)))</span><br><span>     {</span><br><=
span>@@ -2719,7 +2719,7 @@</span><br><span>     /* Outgoing Ciphertext to r=
eliable buffer */</span><br><span>     if (ks-&gt;state &gt;=3D S_START)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       struct buffer *buf =3D reliable_get_buf_output_sequenced(ks-&gt;send=
_reliable);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
const struct buffer *buf =3D reliable_get_buf_output_sequenced(ks-&gt;send_=
reliable);</span><br><span>         if (buf)</span><br><span>         {</sp=
an><br><span>             if (!write_outgoing_tls_ciphertext(session, conti=
nue_tls_process))</span><br><span>@@ -2788,7 +2788,7 @@</span><br><span>   =
  {</span><br><span>         int opcode;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        struct buffer *buf =3D reliabl=
e_send(ks-&gt;send_reliable, &amp;opcode);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        const struct buffer *buf =3D reliable_send(k=
s-&gt;send_reliable, &amp;opcode);</span><br><span>         ASSERT(buf);</s=
pan><br><span>         struct buffer b =3D *buf;</span><br><span>         I=
NCR_SENT;</span><br><span>@@ -3151,7 +3151,7 @@</span><br><span> static voi=
d</span><br><span> check_session_buf_not_used(struct buffer *to_link, struc=
t tls_session *session)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    uint8_t *dataptr =3D to_link-&gt;data;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *dataptr =3D =
to_link-&gt;data;</span><br><span>     if (!dataptr)</span><br><span>     {=
</span><br><span>         return;</span><br><span>@@ -3167,7 +3167,7 @@</sp=
an><br><span> </span><br><span>     for (int i =3D 0; i &lt; KS_SIZE; i++)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        struct key_state *ks =3D &amp;session-&gt;key[i];</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        const struct key_state *ks =
=3D &amp;session-&gt;key[i];</span><br><span>         if (ks-&gt;state =3D=
=3D S_UNDEF)</span><br><span>         {</span><br><span>             contin=
ue;</span><br><span>@@ -3232,7 +3232,7 @@</span><br><span>     {</span><br>=
<span>         struct tls_session *session =3D &amp;multi-&gt;session[i];</=
span><br><span>         struct key_state *ks =3D &amp;session-&gt;key[KS_PR=
IMARY];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct=
 key_state *ks_lame =3D &amp;session-&gt;key[KS_LAME_DUCK];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        const struct key_state *ks_=
lame =3D &amp;session-&gt;key[KS_LAME_DUCK];</span><br><span> </span><br><s=
pan>         /* set initial remote address. This triggers connecting with t=
hat</span><br><span>          * session. So we only do that if the TM_ACTIV=
E session is not</span><br><span>@@ -3433,7 +3433,7 @@</span><br><span> </s=
pan><br><span>     for (int i =3D 0; i &lt; KEY_SCAN_SIZE; ++i)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        st=
ruct key_state *ks =3D get_key_scan(multi, i);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        const struct key_state *ks =3D get_key_s=
can(multi, i);</span><br><span>         if (ks-&gt;key_id !=3D key_id)</spa=
n><br><span>         {</span><br><span>             continue;</span><br><sp=
an>@@ -3985,7 +3985,7 @@</span><br><span> void</span><br><span> tls_prepend=
_opcode_v1(const struct tls_multi *multi, struct buffer *buf)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct key_s=
tate *ks =3D multi-&gt;save_ks;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const struct key_state *ks =3D multi-&gt;save_ks;</span><br=
><span> </span><br><span>     msg(D_TLS_DEBUG, __func__);</span><br><span> =
</span><br><span>@@ -3999,7 +3999,7 @@</span><br><span> void</span><br><spa=
n> tls_prepend_opcode_v2(const struct tls_multi *multi, struct buffer *buf)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct key_state *ks =3D multi-&gt;save_ks;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const struct key_state *ks =3D multi-&gt;save=
_ks;</span><br><span>     uint32_t peer;</span><br><span> </span><br><span>=
     msg(D_TLS_DEBUG, __func__);</span><br><span>diff --git a/src/openvpn/s=
sl_verify.c b/src/openvpn/ssl_verify.c</span><br><span>index 0804d2d..e5b55=
a1 100644</span><br><span>--- a/src/openvpn/ssl_verify.c</span><br><span>++=
+ b/src/openvpn/ssl_verify.c</span><br><span>@@ -409,7 +409,7 @@</span><br>=
<span>                     const char *subject, const struct x509_track *x5=
09_track)</span><br><span> {</span><br><span>     char envname[64];</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    char *serial =3D NULL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *serial=
 =3D NULL;</span><br><span>     struct gc_arena gc =3D gc_new();</span><br>=
<span> </span><br><span>     /* Save X509 fields in environment */</span><b=
r><span>@@ -699,7 +699,7 @@</span><br><span>                 goto cleanup;<=
/span><br><span>         }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        struct verify_hash_list *current_hash =3D op=
t-&gt;verify_hash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       const struct verify_hash_list *current_hash =3D opt-&gt;verify_hash;=
</span><br><span> </span><br><span>         while (current_hash)</span><br>=
<span>         {</span><br><span>@@ -1530,7 +1530,7 @@</span><br><span> ver=
ify_user_pass_management(struct tls_session *session, const struct user_pas=
s *up)</span><br><span> {</span><br><span>     int retval =3D KMDA_ERROR;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct key_state *k=
s =3D &amp;session-&gt;key[KS_PRIMARY]; /* primary key */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const struct key_state *ks =3D &a=
mp;session-&gt;key[KS_PRIMARY]; /* primary key */</span><br><span> </span><=
br><span>     /* set username/password in private env space */</span><br><s=
pan>     setenv_str(session-&gt;opt-&gt;es, &quot;password&quot;, up-&gt;pa=
ssword);</span><br><span>diff --git a/src/openvpnmsica/msica_arg.c b/src/op=
envpnmsica/msica_arg.c</span><br><span>index a334710..d763d93 100644</span>=
<br><span>--- a/src/openvpnmsica/msica_arg.c</span><br><span>+++ b/src/open=
vpnmsica/msica_arg.c</span><br><span>@@ -92,7 +92,7 @@</span><br><span> {</=
span><br><span>     /* Count required space. */</span><br><span>     size_t=
 size =3D 2 /*x + zero-terminator*/;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    for (struct msica_arg *p =3D seq-&gt;head; p !=3D NULL; =
p =3D p-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  for (const struct msica_arg *p =3D seq-&gt;head; p !=3D NULL; p =3D p-&gt=
;next)</span><br><span>     {</span><br><span>         size +=3D wcslen(p-&=
gt;val) + 1 /*space delimiter|zero-terminator*/;</span><br><span>     }</sp=
an><br><span>@@ -119,7 +119,7 @@</span><br><span> </span><br><span>     /* =
Join. */</span><br><span>     LPWSTR s =3D str + 1 /*x*/;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    for (struct msica_arg *p =3D seq-&g=
t;head; p !=3D NULL; p =3D p-&gt;next)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (const struct msica_arg *p =3D seq-&gt;head; p !=
=3D NULL; p =3D p-&gt;next)</span><br><span>     {</span><br><span>        =
 /* Convert zero-terminator into space delimiter. */</span><br><span>      =
   s[0] =3D L&#39; &#39;;</span><br><span>diff --git a/src/openvpnmsica/ope=
nvpnmsica.c b/src/openvpnmsica/openvpnmsica.c</span><br><span>index d698c04=
..6a71801 100644</span><br><span>--- a/src/openvpnmsica/openvpnmsica.c</spa=
n><br><span>+++ b/src/openvpnmsica/openvpnmsica.c</span><br><span>@@ -196,7=
 +196,7 @@</span><br><span> </span><br><span>     /* Count adapters. */</sp=
an><br><span>     size_t adapter_count =3D 0;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    for (struct tap_adapter_node *pAdapter =3D pAda=
pterList; pAdapter; pAdapter =3D pAdapter-&gt;pNext)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (const struct tap_adapter_node *p=
Adapter =3D pAdapterList; pAdapter; pAdapter =3D pAdapter-&gt;pNext)</span>=
<br><span>     {</span><br><span>         adapter_count++;</span><br><span>=
     }</span><br><span>diff --git a/src/plugins/auth-pam/auth-pam.c b/src/p=
lugins/auth-pam/auth-pam.c</span><br><span>index 3b7bcc2..948b6af 100644</s=
pan><br><span>--- a/src/plugins/auth-pam/auth-pam.c</span><br><span>+++ b/s=
rc/plugins/auth-pam/auth-pam.c</span><br><span>@@ -526,7 +526,7 @@</span><b=
r><span> openvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int t=
ype, const char *argv[],</span><br><span>                        const char=
 *envp[])</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    struct auth_pam_context *context =3D (struct auth_pam_context *)=
handle;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const st=
ruct auth_pam_context *context =3D (struct auth_pam_context *)handle;</span=
><br><span> </span><br><span>     if (type =3D=3D OPENVPN_PLUGIN_AUTH_USER_=
PASS_VERIFY &amp;&amp; context-&gt;foreground_fd &gt;=3D 0)</span><br><span=
>     {</span><br><span>diff --git a/src/tapctl/main.c b/src/tapctl/main.c<=
/span><br><span>index 6a4a240..6697d14 100644</span><br><span>--- a/src/tap=
ctl/main.c</span><br><span>+++ b/src/tapctl/main.c</span><br><span>@@ -317,=
7 +317,7 @@</span><br><span>             return NULL;</span><br><span>     =
    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        struct tap_adapter_node *conflict =3D find_adapter_by_name(reques=
ted_name, adapter_list);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        const struct tap_adapter_node *conflict =3D find_adapter_by_na=
me(requested_name, adapter_list);</span><br><span>         if (conflict)</s=
pan><br><span>         {</span><br><span>             LPOLESTR adapter_id =
=3D NULL;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_buffer=
.c b/tests/unit_tests/openvpn/test_buffer.c</span><br><span>index 326de40..=
ce38bbe 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_buffer.c=
</span><br><span>+++ b/tests/unit_tests/openvpn/test_buffer.c</span><br><sp=
an>@@ -88,7 +88,7 @@</span><br><span> </span><br><span>     int maxoutput =
=3D 0;</span><br><span>     unsigned int blocksize =3D 5;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    char *separator =3D &quot; &quot;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *sepa=
rator =3D &quot; &quot;;</span><br><span>     output =3D format_hex_ex(inpu=
t, input_size, maxoutput, blocksize, separator, &amp;gc);</span><br><span> =
    assert_string_equal(output, &quot;0100ff10ff 00f00f090a&quot;);</span><=
br><span> </span><br><span>@@ -174,7 +174,7 @@</span><br><span>     /* With=
 a max length of 2, no aggregation should take place */</span><br><span>   =
  buffer_list_aggregate_separator(ctx-&gt;one_two_three, 2, testsep);</span=
><br><span>     assert_int_equal(ctx-&gt;one_two_three-&gt;size, 3);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer *buf =3D b=
uffer_list_peek(ctx-&gt;one_two_three);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const struct buffer *buf =3D buffer_list_peek(ctx-&=
gt;one_two_three);</span><br><span>     assert_buf_equals_str(buf, teststr1=
);</span><br><span> }</span><br><span> </span><br><span>@@ -189,7 +189,7 @@=
</span><br><span>      */</span><br><span>     buffer_list_aggregate_separa=
tor(ctx-&gt;one_two_three, strlen(expected) + 1, testsep);</span><br><span>=
     assert_int_equal(ctx-&gt;one_two_three-&gt;size, 2);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct buffer *buf =3D buffer_list_=
peek(ctx-&gt;one_two_three);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const struct buffer *buf =3D buffer_list_peek(ctx-&gt;one_two_=
three);</span><br><span>     assert_buf_equals_str(buf, expected);</span><b=
r><span> }</span><br><span> </span><br><span>@@ -201,7 +201,7 @@</span><br>=
<span>     /* Aggregate all */</span><br><span>     buffer_list_aggregate_s=
eparator(ctx-&gt;one_two_three, 1 &lt;&lt; 16, testsep);</span><br><span>  =
   assert_int_equal(ctx-&gt;one_two_three-&gt;size, 1);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    struct buffer *buf =3D buffer_list_pe=
ek(ctx-&gt;one_two_three);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const struct buffer *buf =3D buffer_list_peek(ctx-&gt;one_two_th=
ree);</span><br><span>     assert_buf_equals_str(buf, teststr1 testsep test=
str2 testsep teststr3 testsep);</span><br><span> }</span><br><span> </span>=
<br><span>@@ -213,7 +213,7 @@</span><br><span>     /* Aggregate all */</spa=
n><br><span>     buffer_list_aggregate_separator(ctx-&gt;one_two_three, 1 &=
lt;&lt; 16, testnosep);</span><br><span>     assert_int_equal(ctx-&gt;one_t=
wo_three-&gt;size, 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct buffer *buf =3D buffer_list_peek(ctx-&gt;one_two_three);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct buffer *b=
uf =3D buffer_list_peek(ctx-&gt;one_two_three);</span><br><span>     assert=
_buf_equals_str(buf, teststr1 teststr2 teststr3);</span><br><span> }</span>=
<br><span> </span><br><span>@@ -226,7 +226,7 @@</span><br><span>     /* Agg=
regate all */</span><br><span>     buffer_list_aggregate_separator(bl_zerol=
en, 1 &lt;&lt; 16, testnosep);</span><br><span>     assert_int_equal(bl_zer=
olen-&gt;size, 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 struct buffer *buf =3D buffer_list_peek(bl_zerolen);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct buffer *buf =3D buffer_l=
ist_peek(bl_zerolen);</span><br><span>     assert_buf_equals_str(buf, &quot=
;&quot;);</span><br><span> }</span><br><span> </span><br><span>@@ -239,7 +2=
39,7 @@</span><br><span>     /* Aggregate all */</span><br><span>     buffe=
r_list_aggregate_separator(bl_emptybuffers, 1 &lt;&lt; 16, testnosep);</spa=
n><br><span>     assert_int_equal(bl_emptybuffers-&gt;size, 1);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer *buf =3D buffer=
_list_peek(bl_emptybuffers);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const struct buffer *buf =3D buffer_list_peek(bl_emptybuffers)=
;</span><br><span>     assert_int_equal(BLEN(buf), 0);</span><br><span> }</=
span><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/test=
_crypto.c b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>index cb=
4eaa2..8393e1c 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_c=
rypto.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_crypto.c</span>=
<br><span>@@ -479,9 +479,9 @@</span><br><span> crypto_test_hkdf_expand_test=
a1(void **state)</span><br><span> {</span><br><span>     /* RFC 5889 A.1 Te=
st Case 1 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8=
_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0d, 0xdc=
, 0x3f,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
          0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
   0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t prk[32] =3D =
{ 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0d, 0xdc, 0x3f,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
   0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
    0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };</span><br=
><span> </span><br><span>     uint8_t info[10] =3D { 0xf0, 0xf1, 0xf2, 0xf3=
, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9 };</span><br><span> </span><br><span>@=
@ -500,9 +500,9 @@</span><br><span> crypto_test_hkdf_expand_testa2(void **s=
tate)</span><br><span> {</span><br><span>     /* RFC 5889 A.2 Test Case 2 *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t prk[32] =
=3D { 0x06, 0xa6, 0xb8, 0x8c, 0x58, 0x53, 0x36, 0x1a, 0x06, 0x10, 0x4c,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                        0=
x9c, 0xeb, 0x35, 0xb4, 0x5c, 0xef, 0x76, 0x00, 0x14, 0x90, 0x46,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                        0x71, 0x=
01, 0x4a, 0x19, 0x3f, 0x40, 0xc1, 0x5f, 0xc2, 0x44 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const uint8_t prk[32] =3D { 0x06, 0xa=
6, 0xb8, 0x8c, 0x58, 0x53, 0x36, 0x1a, 0x06, 0x10, 0x4c,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                              0x9c, 0x=
eb, 0x35, 0xb4, 0x5c, 0xef, 0x76, 0x00, 0x14, 0x90, 0x46,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                              0x71, 0=
x01, 0x4a, 0x19, 0x3f, 0x40, 0xc1, 0x5f, 0xc2, 0x44 };</span><br><span> </s=
pan><br><span>     uint8_t info[80] =3D { 0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb=
5, 0xb6, 0xb7, 0xb8, 0xb9, 0xba, 0xbb,</span><br><span>                    =
      0xbc, 0xbd, 0xbe, 0xbf, 0xc0, 0xc1, 0xc2, 0xc3, 0xc4, 0xc5, 0xc6, 0xc=
7,</span><br><span>@@ -531,11 +531,11 @@</span><br><span> crypto_test_hkdf_=
expand_testa3(void **state)</span><br><span> {</span><br><span>     /* RFC =
5889 A.3 Test Case 3 */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    uint8_t prk[32] =3D { 0x19, 0xef, 0x24, 0xa3, 0x2c, 0x71, 0x7b, 0x16,=
 0x7f, 0x33, 0xa9,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                     0x1d, 0x6f, 0x64, 0x8b, 0xdf, 0x96, 0x59, 0x67, 0x76, =
0xaf, 0xdb,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              0x63, 0x77, 0xac, 0x43, 0x4c, 0x1c, 0x29, 0x3c, 0xcb, 0x04 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t p=
rk[32] =3D { 0x19, 0xef, 0x24, 0xa3, 0x2c, 0x71, 0x7b, 0x16, 0x7f, 0x33, 0x=
a9,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
              0x1d, 0x6f, 0x64, 0x8b, 0xdf, 0x96, 0x59, 0x67, 0x76, 0xaf, 0=
xdb,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
               0x63, 0x77, 0xac, 0x43, 0x4c, 0x1c, 0x29, 0x3c, 0xcb, 0x04 }=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  uint8_t info[] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const uint8_t info[] =3D { 0 };</span><br><span> </span><br><sp=
an>     int L =3D 42;</span><br><span>     uint8_t okm[42] =3D { 0x8d, 0xa4=
, 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f, 0x71, 0x5f, 0x80,</span><br><span>@@ =
-555,9 +555,9 @@</span><br><span>     /* tests the HDKF with a label/okm th=
at OpenVPN itself uses in OpenSSL 3</span><br><span>      * HDKF unit test*=
/</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  uint8_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0=
d, 0xdc, 0x3f,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                 0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x3b, 0xb5=
, 0x0f,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
          0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t prk[3=
2] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0d, 0xdc, 0x3f,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
          0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
           0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };</s=
pan><br><span> </span><br><span>     uint8_t info[18] =3D { 0x00, 0x1b, 0x0=
e, 0x6f, 0x76, 0x70, 0x6e, 0x20, 0x75,</span><br><span>                    =
      0x6e, 0x69, 0x74, 0x20, 0x74, 0x65, 0x73, 0x74, 0x00 };</span><br><sp=
an>@@ -677,7 +677,7 @@</span><br><span> static int</span><br><span> crypto_=
test_epoch_setup(void **state)</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    uint16_t *num_future_keys =3D (uint16_t *)*=
state;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uin=
t16_t *num_future_keys =3D (uint16_t *)*state;</span><br><span>     struct =
epoch_test_state *data =3D calloc(1, sizeof(struct epoch_test_state));</spa=
n><br><span> </span><br><span>     data-&gt;gc =3D gc_new();</span><br><spa=
n>diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/open=
vpn/test_misc.c</span><br><span>index a9ae33f..4a055e7 100644</span><br><sp=
an>--- a/tests/unit_tests/openvpn/test_misc.c</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_misc.c</span><br><span>@@ -301,7 +301,7 @@</span><br=
><span>     {</span><br><span>         for (ptr_type i =3D 1; i &lt;=3D 16;=
 ++i)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            struct hash_element *item =3D hash_lookup_by_value(n=
hash, (void *)i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          const struct hash_element *item =3D hash_lookup_by_value(nhash, (=
void *)i);</span><br><span>             hash_remove_by_value(nhash, (void *=
)i);</span><br><span>             /* check item got removed if it was prese=
nt before */</span><br><span>             if (item)</span><br><span>diff --=
git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_p=
kt.c</span><br><span>index cad2ce0..df9fed7 100644</span><br><span>--- a/te=
sts/unit_tests/openvpn/test_pkt.c</span><br><span>+++ b/tests/unit_tests/op=
envpn/test_pkt.c</span><br><span>@@ -567,7 +567,7 @@</span><br><span>     A=
SSERT(md_valid(&quot;SHA256&quot;));</span><br><span>     hmac_ctx_t *hmac_=
ctx =3D hmac_ctx_new();</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    uint8_t key[SHA256_DIGEST_LENGTH] =3D { 1, 2, 3, 0 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t=
 key[SHA256_DIGEST_LENGTH] =3D { 1, 2, 3, 0 };</span><br><span> </span><br>=
<span>     hmac_ctx_init(hmac_ctx, key, &quot;SHA256&quot;);</span><br><spa=
n>     return hmac_ctx;</span><br><span>diff --git a/tests/unit_tests/openv=
pn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>index c=
40845a..9f5d34a 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_=
ssl.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl.c</span><br><=
span>@@ -683,7 +683,7 @@</span><br><span>     openvpn_encrypt(&amp;buf, enc=
rypt_workspace, &amp;co);</span><br><span> </span><br><span>     /* separat=
e buffer in authenticated data and encrypted data */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint8_t *ad_start =3D BPTR(&amp;buf);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *ad=
_start =3D BPTR(&amp;buf);</span><br><span>     buf_advance(&amp;buf, 4);</=
span><br><span> </span><br><span>     if (epoch)</span><br><span>diff --git=
 a/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c b/tests/unit=
_tests/plugins/auth-pam/test_search_and_replace.c</span><br><span>index a86=
1bfd..89f0642 100644</span><br><span>--- a/tests/unit_tests/plugins/auth-pa=
m/test_search_and_replace.c</span><br><span>+++ b/tests/unit_tests/plugins/=
auth-pam/test_search_and_replace.c</span><br><span>@@ -12,7 +12,7 @@</span>=
<br><span> static void</span><br><span> pass_any_null_param__returns_null(v=
oid **state)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    char DUMMY[] =3D &quot;DUMMY&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const char DUMMY[] =3D &quot;DUMMY&quot;;=
</span><br><span> </span><br><span>     assert_null(searchandreplace(NULL, =
DUMMY, DUMMY));</span><br><span>     assert_null(searchandreplace(DUMMY, NU=
LL, DUMMY));</span><br><span>@@ -22,8 +22,8 @@</span><br><span> static void=
</span><br><span> pass_any_empty_string__returns_null(void **state)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char D=
UMMY[] =3D &quot;DUMMY&quot;;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    char EMPTY[] =3D &quot;&quot;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char DUMMY[] =3D &quot;DUMMY&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char EMPTY[] =3D=
 &quot;&quot;;</span><br><span> </span><br><span>     assert_null(searchand=
replace(EMPTY, DUMMY, DUMMY));</span><br><span>     assert_null(searchandre=
place(DUMMY, EMPTY, DUMMY));</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1661?usp=3Demail">cha=
nge 1661</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1661?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2b71dae37ebe63c26a66761f877=
b25d326ed140f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1661 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--/te0CbntKgk=--

