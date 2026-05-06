From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 6 May 2026 11:55:04 +0000
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a3fa783cf4a265f8db133e4d0af1f28376940087-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GF3ptzrJatE="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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

--GF3ptzrJatE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1663?usp=3Demail

to review the following change.


Change subject: Remove instances of constParameterPointer cppcheck warnings
......................................................................

Remove instances of constParameterPointer cppcheck warnings

This requires a few suppressions since cppcheck
doesn't quite understand the different code-paths
implemented by preprocessor defines.

Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M dev-tools/cppcheck-suppression
M dev-tools/run-cppcheck.sh
M sample/sample-plugins/client-connect/sample-client-connect.c
M sample/sample-plugins/defer/multi-auth.c
M sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexporte=
r.c
M src/openvpn/buffer.c
M src/openvpn/buffer.h
M src/openvpn/clinat.c
M src/openvpn/clinat.h
M src/openvpn/comp.c
M src/openvpn/comp.h
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/dco.c
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_internal.h
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
M src/openvpn/dhcp.c
M src/openvpn/dhcp.h
M src/openvpn/event.h
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/init.c
M src/openvpn/init.h
M src/openvpn/interval.h
M src/openvpn/list.c
M src/openvpn/list.h
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/mbuf.c
M src/openvpn/mbuf.h
M src/openvpn/mss.c
M src/openvpn/mss.h
M src/openvpn/mtcp.c
M src/openvpn/mtcp.h
M src/openvpn/mudp.c
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/networking.h
M src/openvpn/networking_iproute2.c
M src/openvpn/networking_sitnl.c
M src/openvpn/occ.h
M src/openvpn/openssl_compat.h
M src/openvpn/options.c
M src/openvpn/options_parse.c
M src/openvpn/otime.c
M src/openvpn/otime.h
M src/openvpn/proto.h
M src/openvpn/proxy.c
M src/openvpn/proxy.h
M src/openvpn/push.c
M src/openvpn/push.h
M src/openvpn/push_util.c
M src/openvpn/reliable.c
M src/openvpn/reliable.h
M src/openvpn/route.c
M src/openvpn/socket.c
M src/openvpn/socket.h
M src/openvpn/socket_util.h
M src/openvpn/socks.c
M src/openvpn/socks.h
M src/openvpn/ssl.c
M src/openvpn/ssl.h
M src/openvpn/ssl_backend.h
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_openssl.c
M src/openvpn/ssl_pkt.c
M src/openvpn/ssl_pkt.h
M src/openvpn/ssl_verify.c
M src/openvpn/ssl_verify.h
M src/openvpn/tun.c
M src/openvpn/tun.h
M src/openvpn/tun_afunix.c
M src/openvpn/tun_afunix.h
M src/openvpn/vlan.c
M src/openvpn/vlan.h
M src/openvpnmsica/openvpnmsica.c
M src/openvpnserv/interactive.c
M tests/t_client.sh.in
M tests/unit_tests/openvpn/mock_management.c
M tests/unit_tests/openvpn/test_misc.c
M tests/unit_tests/openvpn/test_user_pass.c
84 files changed, 248 insertions(+), 226 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/1663/1

diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
index 8a74e84..362d9f9 100644
--- a/dev-tools/cppcheck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -2,7 +2,6 @@
 # occurences right now. They still should be fixed at some point
 constParameter
 constParameterCallback
-constParameterPointer
 variableScope
 # We have a lot of library includes, not all of them are really required,
 # so ignore them
@@ -20,6 +19,27 @@
 # IGN: the code header =3D 0 | (OPCODE << P_OPCODE_SHIFT) is used intentio=
nally
 badBitmaskCheck:src/openvpn/mudp.c
 badBitmaskCheck:tests/unit_tests/openvpn/test_pkt.c
+constParameterPointer:/usr/include/*
+# IGN: test files provide mocks/stubs that match prototypes from headers e=
xactly
+constParameterPointer:tests/unit_tests/openvpn/mock_*
+constParameterPointer:tests/unit_tests/openvpn/test_*
+constParameterPointer:tests/unit_tests/openvpnserv/test_*
+# FP: the restriction to OpenSSL >=3D 3 seems to confuse cppcheck
+constParameterPointer:src/openvpn/crypto_openssl.c:172
+# FP: parameters are modified on Windows (or non-Linux) only
+constParameterPointer:src/openvpn/error.c:223
+constParameterPointer:src/openvpn/manage.c:3332
+constParameterPointer:src/openvpn/misc.c:792
+constParameterPointer:src/openvpn/misc.c:812
+constParameterPointer:src/openvpn/options.c:3205
+constParameterPointer:src/openvpn/route.c:3945
+constParameterPointer:src/openvpn/socket.c:2246
+constParameterPointer:src/openvpn/socket.h:726
+constParameterPointer:src/openvpn/socket.h:825
+constParameterPointer:src/openvpn/ssl_openssl.c:540
+constParameterPointer:src/openvpn/tun.c:560
+# FP: local is modified via cast inside function
+constParameterPointer:src/openvpn/dco.c:560
 # IGN: event code uses a pointer to store integers
 intToPointerCast:src/openvpn/multi_io.c
 intToPointerCast:src/openvpn/forward.c
diff --git a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh
index 674fc092..176d332 100755
--- a/dev-tools/run-cppcheck.sh
+++ b/dev-tools/run-cppcheck.sh
@@ -13,7 +13,7 @@
 mkdir -p "$CPPCHECK_DIR"
 cd "${SOURCE_DIR}"
 cppcheck -j$(nproc) \
-	 -DHAVE_CONFIG_H -U_WIN32 \
+	 -DHAVE_CONFIG_H \
          -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
 	 -I./include/ -I./tests/unit_tests/openvpn/ \
 	 -I./src/compat/ -I./src/openvpn/ -I./src/openvpnserv/ -I./src/plugins/au=
th-pam/ \
diff --git a/sample/sample-plugins/client-connect/sample-client-connect.c b=
/sample/sample-plugins/client-connect/sample-client-connect.c
index 420de61..cbd98e8 100644
--- a/sample/sample-plugins/client-connect/sample-client-connect.c
+++ b/sample/sample-plugins/client-connect/sample-client-connect.c
@@ -344,7 +344,7 @@
 }

 int
-openvpn_plugin_client_connect(struct plugin_context *context, const char *=
*argv, const char **envp)
+openvpn_plugin_client_connect(const struct plugin_context *context, const =
char **argv, const char **envp)
 {
     /* log environment variables handed to us by OpenVPN, but
      * only if "setenv verb" is 3 or higher (arbitrary number)
@@ -465,7 +465,7 @@

 int
 openvpn_plugin_client_connect_defer_v2(struct plugin_context *context,
-                                       struct plugin_per_client_context *p=
cc,
+                                       const struct plugin_per_client_cont=
ext *pcc,
                                        struct openvpn_plugin_string_list *=
*return_list)
 {
     time_t time_left =3D pcc->sleep_until - time(NULL);
diff --git a/sample/sample-plugins/defer/multi-auth.c b/sample/sample-plugi=
ns/defer/multi-auth.c
index 33fbe61..a6cb637 100644
--- a/sample/sample-plugins/defer/multi-auth.c
+++ b/sample/sample-plugins/defer/multi-auth.c
@@ -255,7 +255,7 @@
 }

 static bool
-do_auth_user_pass(struct plugin_context *context, const char *username, co=
nst char *password)
+do_auth_user_pass(const struct plugin_context *context, const char *userna=
me, const char *password)
 {
     plog(context, PLOG_NOTE, "expect_user=3D%s, received_user=3D%s, expect=
_passw=3D%s, received_passw=3D%s",
          np(context->test_valid_user), np(username), np(context->test_vali=
d_pass), np(password));
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmate=
rialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keying=
materialexporter.c
index 25c9ff5..512861a 100644
--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexp=
orter.c
+++ b/sample/sample-plugins/keying-material-exporter-demo/keyingmaterialexp=
orter.c
@@ -186,7 +186,7 @@
 }

 static void
-file_store(char *file, char *content)
+file_store(const char *file, const char *content)
 {
     FILE *f;
     if (!(f =3D fopen(file, "w+")))
@@ -202,7 +202,7 @@
 server_store(struct openvpn_plugin_args_func_in const *args)
 {
     struct plugin *plugin =3D (struct plugin *)args->handle;
-    struct session *sess =3D (struct session *)args->per_client_context;
+    const struct session *sess =3D (struct session *)args->per_client_cont=
ext;

     char file[MAXPATH];
     snprintf(file, sizeof(file) - 1, "/tmp/openvpn_sso_%s", sess->key);
@@ -214,7 +214,7 @@
 client_store(struct openvpn_plugin_args_func_in const *args)
 {
     struct plugin *plugin =3D (struct plugin *)args->handle;
-    struct session *sess =3D (struct session *)args->per_client_context;
+    const struct session *sess =3D (struct session *)args->per_client_cont=
ext;
=20
     char *file =3D "/tmp/openvpn_sso_user";
     ovpn_note("app session file: %s", file);
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 46c1d12..bdc1937 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -285,7 +285,7 @@
  * truncated by buf_printf
  */
 void
-buf_catrunc(struct buffer *buf, const char *str)
+buf_catrunc(const struct buffer *buf, const char *str)
 {
     if (buf_forward_capacity(buf) <=3D 1)
     {
@@ -1086,7 +1086,7 @@
 }

 bool
-string_check_buf(struct buffer *buf, const unsigned int inclusive, const u=
nsigned int exclusive)
+string_check_buf(const struct buffer *buf, const unsigned int inclusive, c=
onst unsigned int exclusive)
 {
     ASSERT(buf);

diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 6a751ad..0d3b202 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -487,7 +487,7 @@
  * write a string to the end of a buffer that was
  * truncated by buf_printf
  */
-void buf_catrunc(struct buffer *buf, const char *str);
+void buf_catrunc(const struct buffer *buf, const char *str);

 /*
  * Parse a string based on a given delimiter char
@@ -774,7 +774,7 @@
 }

 static inline int
-buf_peek_u8(struct buffer *buf)
+buf_peek_u8(const struct buffer *buf)
 {
     int ret;
     if (BLEN(buf) < 1)
@@ -923,7 +923,7 @@
  * @param exclusive Character classes that are not allowed even if they ar=
e also in inclusive.
  * @return True if the string consists only of allowed characters, false o=
therwise.
  */
-bool string_check_buf(struct buffer *buf, const unsigned int inclusive,
+bool string_check_buf(const struct buffer *buf, const unsigned int inclusi=
ve,
                       const unsigned int exclusive);

 /**
@@ -1102,7 +1102,7 @@
     }

 static inline void
-check_malloc_return(void *p)
+check_malloc_return(const void *p)
 {
     if (!p)
     {
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 32c1325..62b7cf9 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -181,7 +181,7 @@
 }

 void
-client_nat_transform(const struct client_nat_option_list *list, struct buf=
fer *ipbuf,
+client_nat_transform(const struct client_nat_option_list *list, const stru=
ct buffer *ipbuf,
                      const int direction)
 {
     struct ip_tcp_udp_hdr *h =3D (struct ip_tcp_udp_hdr *)BPTR(ipbuf);
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index 1e8ceb3..bc56037 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -60,7 +60,7 @@
                                    const char *network, const char *netmas=
k,
                                    const char *foreign_network, msglvl_t m=
sglevel);

-void client_nat_transform(const struct client_nat_option_list *list, struc=
t buffer *ipbuf,
+void client_nat_transform(const struct client_nat_option_list *list, const=
 struct buffer *ipbuf,
                           const int direction);

 #endif /* if !defined(CLINAT_H) */
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index b88b79f..387a7c4 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -159,7 +159,7 @@
 #endif /* USE_COMP */

 bool
-check_compression_settings_valid(struct compress_options *info, msglvl_t m=
sglevel)
+check_compression_settings_valid(const struct compress_options *info, msgl=
vl_t msglevel)
 {
     /*
      * We also allow comp-stub-v2 here as it technically allows escaping of
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 29a90a2..ad80243 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -91,7 +91,7 @@
  * flags of allow-compression and also the whether algorithms are compiled
  * in
  */
-bool check_compression_settings_valid(struct compress_options *info, msglv=
l_t msglevel);
+bool check_compression_settings_valid(const struct compress_options *info,=
 msglvl_t msglevel);

 #ifdef USE_COMP
 #include "buffer.h"
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index a9a33c0..e04eedf 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1105,7 +1105,7 @@
 }

 static bool
-key_is_zero(struct key *key, const struct key_type *kt)
+key_is_zero(const struct key *key, const struct key_type *kt)
 {
     size_t cipher_length =3D cipher_kt_key_size(kt->cipher);
     for (size_t i =3D 0; i < cipher_length; ++i)
@@ -1123,7 +1123,7 @@
  * Make sure that cipher key is a valid key for current key_type.
  */
 bool
-check_key(struct key *key, const struct key_type *kt)
+check_key(const struct key *key, const struct key_type *kt)
 {
     if (cipher_defined(kt->cipher))
     {
@@ -1196,7 +1196,7 @@
 }

 void
-test_crypto(struct crypto_options *co, struct frame *frame)
+test_crypto(struct crypto_options *co, const struct frame *frame)
 {
     int i, j;
     struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index fbca2a0..044f2d2 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -414,7 +414,7 @@
  */
 int write_key_file(const int nkeys, const char *filename);

-bool check_key(struct key *key, const struct key_type *kt);
+bool check_key(const struct key *key, const struct key_type *kt);

 /**
  * Initialize a key_type structure with.
@@ -609,7 +609,7 @@
 /** Print a cipher list entry */
 void print_cipher(const char *cipher);

-void test_crypto(struct crypto_options *co, struct frame *f);
+void test_crypto(struct crypto_options *co, const struct frame *f);


 /* key direction functions */
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 69ce1d7..cc7ef03 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -556,7 +556,7 @@
 }

 static bool
-dco_multi_get_localaddr(struct multi_context *m, struct multi_instance *mi,
+dco_multi_get_localaddr(const struct multi_context *m, const struct multi_=
instance *mi,
                         struct sockaddr_storage *local)
 {
 #if ENABLE_IP_PKTINFO
@@ -568,7 +568,7 @@
         return false;
     }

-    struct link_socket_actual *actual =3D &c->c2.link_socket_infos[0]->lsa=
->actual;
+    const struct link_socket_actual *actual =3D &c->c2.link_socket_infos[0=
]->lsa->actual;

     switch (actual->dest.addr.sa.sa_family)
     {
@@ -606,7 +606,7 @@
 }

 int
-dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
+dco_multi_add_new_peer(const struct multi_context *m, struct multi_instanc=
e *mi)
 {
     const struct context *c =3D &mi->context;

@@ -779,7 +779,7 @@
         /* Checked if we added a host route as the assigned client IP addr=
ess was
          * outside the --ifconfig-ipv6 tun interface config */
 #if !defined(_WIN32)
-        struct in6_addr *dest =3D &mi->context.c2.push_ifconfig_ipv6_local;
+        const struct in6_addr *dest =3D &mi->context.c2.push_ifconfig_ipv6=
_local;
         if (multi_check_push_ifconfig_ipv6_extra_route(mi, dest))
         {
             /* On windows we do not install these routes, so we also do no=
t need to delete them */
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 4e5aad5..55ce38a 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -138,7 +138,7 @@
 /**
  * Install a DCO in the main event loop
  */
-void dco_event_set(dco_context_t *dco, struct event_set *es, void *arg);
+void dco_event_set(const dco_context_t *dco, struct event_set *es, void *a=
rg);

 /**
  * Install the key material in DCO for the specified peer.
@@ -204,7 +204,7 @@
  * @param mi        the client instance
  * @return          0 on success or a negative error code otherwise
  */
-int dco_multi_add_new_peer(struct multi_context *m, struct multi_instance =
*mi);
+int dco_multi_add_new_peer(const struct multi_context *m, struct multi_ins=
tance *mi);

 /**
  * Install an iroute in DCO, which means adding a route to the system rout=
ing
@@ -253,7 +253,7 @@
  * a 64 bit packet counter and AEAD tag at the end.
  */
 bool
-dco_supports_epoch_data(struct context *c);
+dco_supports_epoch_data(const struct context *c);
 #else  /* if defined(ENABLE_DCO) */

 typedef void *dco_context_t;
@@ -313,7 +313,7 @@
 }

 static inline void
-dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
+dco_event_set(const dco_context_t *dco, struct event_set *es, void *arg)
 {
 }

@@ -350,7 +350,7 @@
 }

 static inline int
-dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)
+dco_multi_add_new_peer(const struct multi_context *m, struct multi_instanc=
e *mi)
 {
     return 0;
 }
@@ -384,7 +384,7 @@
 }

 static inline bool
-dco_supports_epoch_data(struct context *c)
+dco_supports_epoch_data(const struct context *c)
 {
     return false;
 }
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index b07df13..908fc73 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -778,7 +778,7 @@
 }

 void
-dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
+dco_event_set(const dco_context_t *dco, struct event_set *es, void *arg)
 {
     struct ifdrv drv;
     nvlist_t *nvl;
@@ -929,7 +929,7 @@
 }

 bool
-dco_supports_epoch_data(struct context *c)
+dco_supports_epoch_data(const struct context *c)
 {
     return false;
 }
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index fcf8aca..1022e66 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -59,8 +59,9 @@
  * They are implemented by dco_linux.c
  */

-int dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descripto=
r_t sd, struct sockaddr *localaddr,
-                 struct sockaddr *remoteaddr, const struct in_addr *vpn_ip=
v4, const struct in6_addr *vpn_ipv6);
+int dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descripto=
r_t sd,
+                 struct sockaddr *localaddr, struct sockaddr *remoteaddr,
+                 const struct in_addr *vpn_ipv4, const struct in6_addr *vp=
n_ipv6);

 int dco_del_peer(dco_context_t *dco, unsigned int peerid);

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 56f6259..7039fea 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -114,7 +114,7 @@
 }

 static struct nl_msg *
-ovpn_dco_nlmsg_create(dco_context_t *dco, uint8_t cmd)
+ovpn_dco_nlmsg_create(const dco_context_t *dco, uint8_t cmd)
 {
     struct nl_msg *nl_msg =3D nlmsg_alloc();
     if (!nl_msg)
@@ -804,7 +804,7 @@

 /* libnl < 3.11.0 does not implement nla_get_uint() */
 static uint64_t
-ovpn_nla_get_uint(struct nlattr *attr)
+ovpn_nla_get_uint(const struct nlattr *attr)
 {
     if (nla_len(attr) =3D=3D sizeof(uint32_t))
     {
@@ -916,7 +916,7 @@
 }

 static bool
-ovpn_iface_check(dco_context_t *dco, struct nlattr *attrs[])
+ovpn_iface_check(const dco_context_t *dco, struct nlattr *attrs[])
 {
     /* we must know which interface this message is referring to in order =
to
      * avoid mixing messages for other instances
@@ -1325,7 +1325,7 @@
 }

 void
-dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
+dco_event_set(const dco_context_t *dco, struct event_set *es, void *arg)
 {
     if (dco && dco->nl_sock)
     {
@@ -1340,7 +1340,7 @@
 }

 bool
-dco_supports_epoch_data(struct context *c)
+dco_supports_epoch_data(const struct context *c)
 {
     return false;
 }
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 102206a..e87ed1e 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -939,7 +939,7 @@
 }

 void
-dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)
+dco_event_set(const dco_context_t *dco, struct event_set *es, void *arg)
 {
     if (dco->ifmode !=3D DCO_MODE_MP)
     {
@@ -1100,7 +1100,7 @@
 }

 bool
-dco_supports_epoch_data(struct context *c)
+dco_supports_epoch_data(const struct context *c)
 {
     OVPN_VERSION ver =3D { 0 };
     return dco_get_version(&ver) && ((ver.Major =3D=3D 2 && ver.Minor >=3D=
 8) || (ver.Major > 2));
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index a54ab3f..68173e6 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -145,7 +145,7 @@
 }

 in_addr_t
-dhcp_extract_router_msg(struct buffer *ipbuf)
+dhcp_extract_router_msg(const struct buffer *ipbuf)
 {
     struct dhcp_full *df =3D (struct dhcp_full *)BPTR(ipbuf);
     const int optlen =3D
diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h
index 38ebf8d..ed8a0c9 100644
--- a/src/openvpn/dhcp.h
+++ b/src/openvpn/dhcp.h
@@ -91,7 +91,7 @@

 #pragma pack()

-in_addr_t dhcp_extract_router_msg(struct buffer *ipbuf);
+in_addr_t dhcp_extract_router_msg(const struct buffer *ipbuf);

 #if defined(_WIN32) || defined(DHCP_UNIT_TEST)
 #include "tun.h"
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index b784dfe..0940a1d 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -204,7 +204,7 @@
 #else /* ifdef _WIN32 */

 static inline void
-wait_signal(struct event_set *es, void *arg)
+wait_signal(const struct event_set *es, const void *arg)
 {
 }

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index a4747ed..bc6adbb 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -231,7 +231,7 @@
 }

 static void
-parse_incoming_control_channel_command(struct context *c, struct buffer *b=
uf)
+parse_incoming_control_channel_command(struct context *c, const struct buf=
fer *buf)
 {
     if (buf_string_match_head_str(buf, "AUTH_FAILED"))
     {
@@ -501,7 +501,7 @@
 }

 int
-get_server_poll_remaining_time(struct event_timeout *server_poll_timeout)
+get_server_poll_remaining_time(const struct event_timeout *server_poll_tim=
eout)
 {
     update_time();
     int remaining =3D event_timeout_remaining(server_poll_timeout);
@@ -598,7 +598,7 @@
  * Buffer reallocation, for use with null encryption.
  */
 static inline void
-buffer_turnover(const uint8_t *orig_buf, struct buffer *dest_stub, struct =
buffer *src_stub,
+buffer_turnover(const uint8_t *orig_buf, struct buffer *dest_stub, const s=
truct buffer *src_stub,
                 struct buffer *storage)
 {
     if (orig_buf =3D=3D src_stub->data && src_stub->data !=3D storage->dat=
a)
@@ -885,7 +885,7 @@
  */

 static inline void
-socks_postprocess_incoming_link(struct context *c, struct link_socket *soc=
k)
+socks_postprocess_incoming_link(struct context *c, const struct link_socke=
t *sock)
 {
     if (sock->socks_proxy && sock->info.proto =3D=3D PROTO_UDP)
     {
@@ -984,7 +984,7 @@
 }

 bool
-process_incoming_link_part1(struct context *c, struct link_socket_info *ls=
i, bool floated)
+process_incoming_link_part1(struct context *c, const struct link_socket_in=
fo *lsi, bool floated)
 {
     struct gc_arena gc =3D gc_new();
     bool decrypt_status =3D false;
@@ -1534,7 +1534,7 @@
  * @param client    Determines whether to the send packet back via tun or =
link
  */
 void
-ipv6_send_icmp_unreachable(struct context *c, struct buffer *buf, bool cli=
ent)
+ipv6_send_icmp_unreachable(struct context *c, const struct buffer *buf, bo=
ol client)
 {
 #define MAX_ICMPV6LEN 1280
     struct openvpn_icmp6hdr icmp6out;
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 0d3e492..d8e07fa 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -112,7 +112,7 @@
  */
 void encrypt_sign(struct context *c, bool comp_frag);

-int get_server_poll_remaining_time(struct event_timeout *server_poll_timeo=
ut);
+int get_server_poll_remaining_time(const struct event_timeout *server_poll=
_timeout);

 /**********************************************************************/
 /**
@@ -163,7 +163,7 @@
  *
  * @return true if packet is authenticated, false otherwise.
  */
-bool process_incoming_link_part1(struct context *c, struct link_socket_inf=
o *lsi, bool floated);
+bool process_incoming_link_part1(struct context *c, const struct link_sock=
et_info *lsi, bool floated);

 /**
  * Continues processing a packet read from the external network interface.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index af652ac..56f39d8 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1269,7 +1269,7 @@
  * prepending to msg() output.
  */
 const char *
-format_common_name(struct context *c, struct gc_arena *gc)
+format_common_name(const struct context *c, struct gc_arena *gc)
 {
     struct buffer out =3D alloc_buf_gc(256, gc);
     if (c->c2.tls_multi)
@@ -1755,7 +1755,7 @@


 static bool
-can_preserve_tun(struct tuntap *tt)
+can_preserve_tun(const struct tuntap *tt)
 {
     if (tt && tt->backend_driver =3D=3D DRIVER_AFUNIX)
     {
@@ -1777,7 +1777,7 @@
  * @param c pointer to the connection context
  */
 static void
-add_wfp_block(struct context *c)
+add_wfp_block(const struct context *c)
 {
 #if defined(_WIN32)
     /* Fortify 'redirect-gateway block-local' with firewall rules? */
@@ -1803,7 +1803,7 @@
  * @param adapter_index the VPN adapter index
  */
 static void
-del_wfp_block(struct context *c, unsigned long adapter_index)
+del_wfp_block(const struct context *c, unsigned long adapter_index)
 {
 #if defined(_WIN32)
     if (c->options.block_outside_dns || block_local_needed(c->c1.route_lis=
t))
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 9d5050d..af4393c 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -91,7 +91,7 @@

 unsigned int pull_permission_mask(const struct context *c);

-const char *format_common_name(struct context *c, struct gc_arena *gc);
+const char *format_common_name(const struct context *c, struct gc_arena *g=
c);

 void reset_coarse_timers(struct context *c);

diff --git a/src/openvpn/interval.h b/src/openvpn/interval.h
index 59051bd..0cfe202 100644
--- a/src/openvpn/interval.h
+++ b/src/openvpn/interval.h
@@ -89,7 +89,7 @@
 }

 static inline void
-interval_schedule_wakeup(struct interval *top, interval_t *wakeup)
+interval_schedule_wakeup(const struct interval *top, interval_t *wakeup)
 {
     const time_t local_now =3D now;
     interval_earliest_wakeup(wakeup, top->last_test_true + top->refresh, l=
ocal_now);
@@ -214,7 +214,7 @@
  * This function does not check if the timeout is actually valid.
  */
 static inline interval_t
-event_timeout_remaining(struct event_timeout *et)
+event_timeout_remaining(const struct event_timeout *et)
 {
     return (interval_t)((et->last + et->n) - now);
 }
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 2e1cf05..c04ee4f 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -162,7 +162,7 @@
 }

 void
-hash_remove_by_value(struct hash *hash, void *value)
+hash_remove_by_value(struct hash *hash, const void *value)
 {
     struct hash_iterator hi;
     const struct hash_element *he;
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index 04cc3ab..089637d 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -73,7 +73,7 @@

 bool hash_remove_fast(struct hash *hash, struct hash_bucket *bucket, const=
 void *key, uint32_t hv);

-void hash_remove_by_value(struct hash *hash, void *value);
+void hash_remove_by_value(struct hash *hash, const void *value);

 struct hash_iterator
 {
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 604bbcd..3f1eabf 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -330,7 +330,7 @@
 }

 static void
-man_delete_unix_socket(struct management *man)
+man_delete_unix_socket(const struct management *man)
 {
 #if UNIX_SOCK_SUPPORT
     if ((man->settings.flags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=
=3D MF_UNIX_SOCK)
@@ -675,7 +675,7 @@
  * for the log and echo commands.
  */
 static void
-man_history(struct management *man, const char *parm, const char *type, st=
ruct log_history *log,
+man_history(struct management *man, const char *parm, const char *type, co=
nst struct log_history *log,
             bool *realtime, const unsigned int lep_flags)
 {
     struct gc_arena gc =3D gc_new();
@@ -843,7 +843,7 @@
 }

 static void
-man_forget_passwords(struct management *man)
+man_forget_passwords(const struct management *man)
 {
     ssl_purge_auth(false);
     (void)ssl_clean_auth_token();
@@ -851,7 +851,7 @@
 }

 static void
-man_net(struct management *man)
+man_net(const struct management *man)
 {
     if (man->persist.callback.show_net)
     {
@@ -887,7 +887,7 @@
 #ifdef ENABLE_PKCS11

 static void
-man_pkcs11_id_count(struct management *man)
+man_pkcs11_id_count(const struct management *man)
 {
     msg(M_CLIENT, ">PKCS11ID-COUNT:%d", pkcs11_management_id_count());
 }
@@ -1350,7 +1350,7 @@
  * @return          Return whether p has n (or at least n) parameters
  */
 static bool
-man_need(struct management *man, const char **p, const int n, unsigned int=
 flags)
+man_need(const struct management *man, const char **p, const int n, unsign=
ed int flags)
 {
     int i;
     ASSERT(p[0]);
@@ -3013,7 +3013,7 @@
 }

 void
-management_up_down(struct management *man, const char *updown, const struc=
t env_set *es)
+management_up_down(const struct management *man, const char *updown, const=
 struct env_set *es)
 {
     if (man->settings.flags & MF_UP_DOWN)
     {
@@ -3023,13 +3023,13 @@
 }

 void
-management_notify(struct management *man, const char *severity, const char=
 *type, const char *text)
+management_notify(const struct management *man, const char *severity, cons=
t char *type, const char *text)
 {
     msg(M_CLIENT, ">NOTIFY:%s,%s,%s", severity, type, text);
 }

 void
-management_notify_generic(struct management *man, const char *str)
+management_notify_generic(const struct management *man, const char *str)
 {
     msg(M_CLIENT, "%s", str);
 }
@@ -3115,7 +3115,8 @@
 }

 void
-management_notify_client_close(struct management *management, struct man_d=
ef_auth_context *mdac,
+management_notify_client_close(const struct management *management,
+                               struct man_def_auth_context *mdac,
                                const struct env_set *es)
 {
     if ((mdac->flags & DAF_INITIAL_AUTH) && !(mdac->flags & DAF_CONNECTION=
_CLOSED))
@@ -3206,7 +3207,7 @@
 }

 void
-management_auth_failure(struct management *man, const char *type, const ch=
ar *reason)
+management_auth_failure(const struct management *man, const char *type, co=
nst char *reason)
 {
     if (reason)
     {
@@ -3219,7 +3220,7 @@
 }

 void
-management_auth_token(struct management *man, const char *token)
+management_auth_token(const struct management *man, const char *token)
 {
     msg(M_CLIENT, ">PASSWORD:Auth-Token:%s", token);
 }
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 1be3549..ab68968 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -376,12 +376,12 @@

 void management_event_loop_n_seconds(struct management *man, int sec);

-void management_up_down(struct management *man, const char *updown, const =
struct env_set *es);
+void management_up_down(const struct management *man, const char *updown, =
const struct env_set *es);

-void management_notify(struct management *man, const char *severity, const=
 char *type,
+void management_notify(const struct management *man, const char *severity,=
 const char *type,
                        const char *text);

-void management_notify_generic(struct management *man, const char *str);
+void management_notify_generic(const struct management *man, const char *s=
tr);

 void management_notify_client_needing_auth(struct management *management,
                                            const unsigned int auth_id,
@@ -391,7 +391,7 @@
 void management_connection_established(struct management *management,
                                        struct man_def_auth_context *mdac, =
const struct env_set *es);

-void management_notify_client_close(struct management *management,
+void management_notify_client_close(const struct management *management,
                                     struct man_def_auth_context *mdac, con=
st struct env_set *es);

 void management_learn_addr(struct management *management, struct man_def_a=
uth_context *mdac,
@@ -476,12 +476,12 @@
  * OpenVPN calls here to indicate a password failure
  */

-void management_auth_failure(struct management *man, const char *type, con=
st char *reason);
+void management_auth_failure(const struct management *man, const char *typ=
e, const char *reason);

 /*
  * Echo an authentication token to management interface
  */
-void management_auth_token(struct management *man, const char *token);
+void management_auth_token(const struct management *man, const char *token=
);

 /*
  * These functions drive the bytecount in/out counters.
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 5e1b585..39f85ba 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -160,7 +160,7 @@
 }

 void
-mbuf_dereference_instance(struct mbuf_set *ms, struct multi_instance *mi)
+mbuf_dereference_instance(struct mbuf_set *ms, const struct multi_instance=
 *mi)
 {
     if (ms)
     {
diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index cfe698c..e368054 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -75,7 +75,7 @@

 bool mbuf_extract_item(struct mbuf_set *ms, struct mbuf_item *item);

-void mbuf_dereference_instance(struct mbuf_set *ms, struct multi_instance =
*mi);
+void mbuf_dereference_instance(struct mbuf_set *ms, const struct multi_ins=
tance *mi);

 static inline bool
 mbuf_defined(const struct mbuf_set *ms)
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 36bbb43..a7242a8 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -43,7 +43,7 @@
  *              if yes, hand to mss_fixup_dowork()
  */
 void
-mss_fixup_ipv4(struct buffer *buf, uint16_t maxmss)
+mss_fixup_ipv4(const struct buffer *buf, uint16_t maxmss)
 {
     const struct openvpn_iphdr *pip;
     int hlen;
@@ -80,7 +80,7 @@
  *              (IPv6 header structure is sufficiently different from IPv4=
...)
  */
 void
-mss_fixup_ipv6(struct buffer *buf, uint16_t maxmss)
+mss_fixup_ipv6(const struct buffer *buf, uint16_t maxmss)
 {
     const struct openvpn_ipv6hdr *pip6;
     struct buffer newbuf;
@@ -136,7 +136,7 @@
  */

 void
-mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)
+mss_fixup_dowork(const struct buffer *buf, uint16_t maxmss)
 {
     int olen, optlen;
     uint8_t *opt;
@@ -239,8 +239,8 @@
 }

 static void
-frame_calculate_fragment(struct frame *frame, struct key_type *kt, const s=
truct options *options,
-                         struct link_socket_info *lsi)
+frame_calculate_fragment(struct frame *frame, const struct key_type *kt, c=
onst struct options *options,
+                         const struct link_socket_info *lsi)
 {
 #if defined(ENABLE_FRAGMENT)
     size_t overhead;
@@ -269,8 +269,8 @@
 }

 static void
-frame_calculate_mssfix(struct frame *frame, struct key_type *kt, const str=
uct options *options,
-                       struct link_socket_info *lsi)
+frame_calculate_mssfix(struct frame *frame, const struct key_type *kt, con=
st struct options *options,
+                       const struct link_socket_info *lsi)
 {
     if (options->ce.mssfix_fixed)
     {
@@ -314,8 +314,8 @@
 }

 void
-frame_calculate_dynamic(struct frame *frame, struct key_type *kt, const st=
ruct options *options,
-                        struct link_socket_info *lsi)
+frame_calculate_dynamic(struct frame *frame, const struct key_type *kt, co=
nst struct options *options,
+                        const struct link_socket_info *lsi)
 {
     if (options->ce.fragment > 0)
     {
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index 1d092bb..6b832a2 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -29,15 +29,15 @@
 #include "socket.h"
 #include "ssl_common.h"

-void mss_fixup_ipv4(struct buffer *buf, uint16_t maxmss);
+void mss_fixup_ipv4(const struct buffer *buf, uint16_t maxmss);

-void mss_fixup_ipv6(struct buffer *buf, uint16_t maxmss);
+void mss_fixup_ipv6(const struct buffer *buf, uint16_t maxmss);

-void mss_fixup_dowork(struct buffer *buf, uint16_t maxmss);
+void mss_fixup_dowork(const struct buffer *buf, uint16_t maxmss);

 /** Set the --mssfix option. */
-void frame_calculate_dynamic(struct frame *frame, struct key_type *kt,
-                             const struct options *options, struct link_so=
cket_info *lsi);
+void frame_calculate_dynamic(struct frame *frame, const struct key_type *k=
t,
+                             const struct options *options, const struct l=
ink_socket_info *lsi);

 /**
  * Checks and adjusts the fragment and mssfix value according to the
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index df94a70..d9f14b3 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -91,7 +91,7 @@
 }

 bool
-multi_tcp_instance_specific_init(struct multi_context *m, struct multi_ins=
tance *mi)
+multi_tcp_instance_specific_init(const struct multi_context *m, struct mul=
ti_instance *mi)
 {
     /* buffer for queued TCP socket output packets */
     mi->tcp_link_out_deferred =3D mbuf_init(m->top.options.n_bcast_buf);
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index 9b7d1d2..bb117fa 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -35,7 +35,7 @@

 void multi_tcp_dereference_instance(struct multi_io *multi_io, struct mult=
i_instance *mi);

-bool multi_tcp_instance_specific_init(struct multi_context *m, struct mult=
i_instance *mi);
+bool multi_tcp_instance_specific_init(const struct multi_context *m, struc=
t multi_instance *mi);

 void multi_tcp_instance_specific_free(struct multi_instance *mi);

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 50d72d5..4828a17 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -39,7 +39,7 @@

 static void
 send_hmac_reset_packet(struct multi_context *m, struct tls_pre_decrypt_sta=
te *state,
-                       struct tls_auth_standalone *tas, struct session_id =
*sid,
+                       const struct tls_auth_standalone *tas, const struct=
 session_id *sid,
                        bool request_resend_wkc)
 {
     reset_packet_id_send(&state->tls_wrap_tmp.opt.packet_id.send);
@@ -69,7 +69,7 @@

     enum first_packet_verdict verdict;

-    struct tls_auth_standalone *tas =3D m->top.c2.tls_auth_standalone;
+    const struct tls_auth_standalone *tas =3D m->top.c2.tls_auth_standalon=
e;

     verdict =3D tls_pre_decrypt_lite(tas, state, &m->top.c2.from, &m->top.=
c2.buf);

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 6c833c0..27b938a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1315,7 +1315,7 @@
  * same common name.
  */
 static void
-multi_delete_dup(struct multi_context *m, struct multi_instance *new_mi)
+multi_delete_dup(struct multi_context *m, const struct multi_instance *new=
_mi)
 {
     if (new_mi)
     {
@@ -2260,7 +2260,7 @@
 }

 static bool
-multi_client_setup_dco_initial(struct multi_context *m, struct multi_insta=
nce *mi,
+multi_client_setup_dco_initial(const struct multi_context *m, struct multi=
_instance *mi,
                                struct gc_arena *gc)
 {
     if (!dco_enabled(&mi->context.options))
@@ -3195,7 +3195,7 @@

 #if defined(ENABLE_DCO)
 static void
-process_incoming_del_peer(struct multi_context *m, struct multi_instance *=
mi, dco_context_t *dco)
+process_incoming_del_peer(struct multi_context *m, struct multi_instance *=
mi, const dco_context_t *dco)
 {
     const char *reason =3D "ovpn-dco: unknown reason";
     switch (dco->dco_del_peer_reason)
@@ -4226,7 +4226,7 @@

 /* Searches for the address and deletes it if it is owned by the multi_ins=
tance */
 static void
-multi_unlearn_addr(struct multi_context *m, struct multi_instance *mi, con=
st struct mroute_addr *addr)
+multi_unlearn_addr(struct multi_context *m, const struct multi_instance *m=
i, const struct mroute_addr *addr)
 {
     struct hash_element *he;
     const uint32_t hv =3D hash_value(m->vhash, addr);
@@ -4261,7 +4261,7 @@
  * @param a     The new IPv4 address in network byte order
  */
 static void
-multi_unlearn_in_addr_t(struct multi_context *m, struct multi_instance *mi=
, in_addr_t a)
+multi_unlearn_in_addr_t(struct multi_context *m, const struct multi_instan=
ce *mi, in_addr_t a)
 {
     struct mroute_addr addr;
     CLEAR(addr);
@@ -4279,7 +4279,7 @@
  * @param a6    The new IPv6 address
  */
 static void
-multi_unlearn_in6_addr(struct multi_context *m, struct multi_instance *mi,=
 struct in6_addr a6)
+multi_unlearn_in6_addr(struct multi_context *m, const struct multi_instanc=
e *mi, struct in6_addr a6)
 {
     struct mroute_addr addr;
     CLEAR(addr);
@@ -4395,7 +4395,7 @@

 bool
 multi_check_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,
-                                           struct in6_addr *dest)
+                                           const struct in6_addr *dest)
 {
     struct options *o =3D &mi->context.options;

diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 3ed08d4..cd7aa3e 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -520,7 +520,7 @@
  */

 static inline void
-set_prefix(struct multi_instance *mi)
+set_prefix(const struct multi_instance *mi)
 {
 #ifdef MULTI_DEBUG_EVENT_LOOP
     if (mi->msg_prefix[0])
@@ -694,7 +694,7 @@
  */
 bool
 multi_check_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,
-                                           struct in6_addr *dest);
+                                           const struct in6_addr *dest);

 /*
  * Check for signals.
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index bce0c19..e52a76a 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -102,7 +102,7 @@
  * @return          0 on success, negative error code on error
  */
 int net_iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface=
, const char *type,
-                  void *arg);
+                  const void *arg);

 /**
  * Retrieve the interface type
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_ipr=
oute2.c
index a1f3525..404d759 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -61,7 +61,7 @@
 }

 int
-net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type,=
 void *arg)
+net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type,=
 const void *arg)
 {
     struct argv argv =3D argv_new();

diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index e6e72d0..a1d220f 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -987,7 +987,7 @@
 }

 static int
-sitnl_addr_del(sa_family_t af_family, const char *iface, inet_address_t *a=
ddr, int prefixlen)
+sitnl_addr_del(sa_family_t af_family, const char *iface, const inet_addres=
s_t *addr, int prefixlen)
 {
     int ifindex;

@@ -1230,8 +1230,8 @@
 }

 static int
-sitnl_route_del(const char *iface, sa_family_t af_family, inet_address_t *=
dst, int prefixlen,
-                inet_address_t *gw, uint32_t table, int metric)
+sitnl_route_del(const char *iface, sa_family_t af_family, const inet_addre=
ss_t *dst, int prefixlen,
+                const inet_address_t *gw, uint32_t table, int metric)
 {
     int ifindex =3D 0;

@@ -1308,7 +1308,7 @@


 int
-net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type,=
 void *arg)
+net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type,=
 const void *arg)
 {
     struct sitnl_link_req req =3D {};
     int ret =3D -1;
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index bda4f18..49def4d 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -156,7 +156,7 @@
  * via control channel.
  * @return control channel exit message should be used */
 static inline bool
-cc_exit_notify_enabled(struct context *c)
+cc_exit_notify_enabled(const struct context *c)
 {
     /* Check if we have TLS active at all */
     if (!c->c2.tls_multi)
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 3494ce6..32e0b6f 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -124,7 +124,7 @@
 /* Mimics the functions but only when the default context without
  * options is chosen */
 static inline const EVP_CIPHER *
-EVP_CIPHER_fetch(void *ctx, const char *algorithm, const char *properties)
+EVP_CIPHER_fetch(const void *ctx, const char *algorithm, const char *prope=
rties)
 {
     ASSERT(!ctx);
     ASSERT(!properties);
@@ -132,7 +132,7 @@
 }

 static inline const EVP_MD *
-EVP_MD_fetch(void *ctx, const char *algorithm, const char *properties)
+EVP_MD_fetch(const void *ctx, const char *algorithm, const char *propertie=
s)
 {
     ASSERT(!ctx);
     ASSERT(!properties);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fd0d3fc..6d85a23 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3050,7 +3050,7 @@
 }

 static void
-options_postprocess_mutate_le(struct connection_entry *ce, struct local_en=
try *le, int mode)
+options_postprocess_mutate_le(const struct connection_entry *ce, struct lo=
cal_entry *le, int mode)
 {
     /* use the global port if none is specified */
     if (!le->port)
@@ -4980,7 +4980,7 @@
 static bool
 verify_permission(const char *name, const char *file, int line, const uint=
64_t type,
                   const uint64_t allowed, uint64_t *found, const msglvl_t =
msglevel,
-                  struct options *options, bool is_inline)
+                  const struct options *options, bool is_inline)
 {
     if (!(type & allowed))
     {
@@ -5547,7 +5547,7 @@
 }

 static void
-show_compression_warning(struct compress_options *info)
+show_compression_warning(const struct compress_options *info)
 {
     if (comp_non_stub_enabled(info))
     {
diff --git a/src/openvpn/options_parse.c b/src/openvpn/options_parse.c
index 88ab4d2..0e94522 100644
--- a/src/openvpn/options_parse.c
+++ b/src/openvpn/options_parse.c
@@ -258,7 +258,7 @@
 }

 static char *
-read_inline_file(struct in_src *is, const char *close_tag, int *num_lines,=
 struct gc_arena *gc)
+read_inline_file(const struct in_src *is, const char *close_tag, int *num_=
lines, struct gc_arena *gc)
 {
     char line[OPTION_LINE_SIZE];
     struct buffer buf =3D alloc_buf(8 * OPTION_LINE_SIZE);
@@ -302,7 +302,7 @@
 }

 static int
-check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
+check_inline_file(const struct in_src *is, char *p[], struct gc_arena *gc)
 {
     int num_inline_lines =3D 0;

diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index 1608458..5d3633c 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -66,7 +66,7 @@
 }

 void
-update_now_usec(struct timeval *tv)
+update_now_usec(const struct timeval *tv)
 {
     const time_t last =3D now;
     update_now(tv->tv_sec);
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index 84e315b..b5a9f7c 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -65,7 +65,7 @@
 void update_now(const time_t system_time);

 extern time_t now_usec;
-void update_now_usec(struct timeval *tv);
+void update_now_usec(const struct timeval *tv);

 static inline int
 openvpn_gettimeofday(struct timeval *tv, void *tz)
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 3570582..33bf4ea 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -248,7 +248,7 @@
  * and offset of IP header (via parameter).
  */
 static inline int
-get_tun_ip_ver(int tunnel_type, struct buffer *buf, int *ip_hdr_offset)
+get_tun_ip_ver(int tunnel_type, const struct buffer *buf, int *ip_hdr_offs=
et)
 {
     int ip_ver =3D -1;

diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 4de7615..59b5ad3 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -597,8 +597,8 @@
                               socket_descriptor_t sd, /* already open to p=
roxy */
                               const char *host,       /* openvpn server re=
mote */
                               const char *port,       /* openvpn server po=
rt */
-                              struct event_timeout *server_poll_timeout, s=
truct buffer *lookahead,
-                              struct signal_info *sig_info)
+                              const struct event_timeout *server_poll_time=
out,
+                              struct buffer *lookahead, struct signal_info=
 *sig_info)
 {
     struct gc_arena gc =3D gc_new();
     char buf[512];
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index e662e7d..a2f4e47 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -89,7 +89,7 @@
                                    socket_descriptor_t sd, /* already open=
 to proxy */
                                    const char *host,       /* openvpn serv=
er remote */
                                    const char *port,       /* openvpn serv=
er port */
-                                   struct event_timeout *server_poll_timeo=
ut,
+                                   const struct event_timeout *server_poll=
_timeout,
                                    struct buffer *lookahead, struct signal=
_info *sig_info);

 uint8_t *make_base64_string2(const uint8_t *str, int str_len, struct gc_ar=
ena *gc);
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index a030acd..373272f 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -435,7 +435,7 @@
 #endif

 bool
-send_auth_pending_messages(struct tls_multi *tls_multi, struct tls_session=
 *session,
+send_auth_pending_messages(const struct tls_multi *tls_multi, struct tls_s=
ession *session,
                            const char *extra, unsigned int timeout)
 {
     struct key_state *ks =3D &session->key[KS_PRIMARY];
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index dff945f..39302f6 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -117,7 +117,7 @@
  * doc/management-notes.txt under client-pending-auth for
  * more details on message format
  */
-bool send_auth_pending_messages(struct tls_multi *tls_multi, struct tls_se=
ssion *session,
+bool send_auth_pending_messages(const struct tls_multi *tls_multi, struct =
tls_session *session,
                                 const char *extra, unsigned int timeout);

 void send_restart(struct context *c, const char *kill_msg);
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index af22af5..008d45f 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -222,7 +222,7 @@

 /* Return true if the client supports push-update */
 static bool
-support_push_update(struct multi_instance *mi)
+support_push_update(const struct multi_instance *mi)
 {
     ASSERT(mi->context.c2.tls_multi);
     const unsigned int iv_proto_peer =3D extract_iv_proto(mi->context.c2.t=
ls_multi->peer_info);
diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
index 52adacf..3588483 100644
--- a/src/openvpn/reliable.c
+++ b/src/openvpn/reliable.c
@@ -92,7 +92,7 @@

 /* check if a particular packet_id is present in ack */
 static inline bool
-reliable_ack_packet_id_present(struct reliable_ack *ack, packet_id_type pi=
d)
+reliable_ack_packet_id_present(const struct reliable_ack *ack, packet_id_t=
ype pid)
 {
     for (int i =3D 0; i < ack->len; ++i)
     {
@@ -733,7 +733,7 @@
  */

 void
-reliable_mark_active_incoming(struct reliable *rel, struct buffer *buf, pa=
cket_id_type pid,
+reliable_mark_active_incoming(struct reliable *rel, const struct buffer *b=
uf, packet_id_type pid,
                               int opcode)
 {
     for (int i =3D 0; i < rel->size; ++i)
@@ -793,7 +793,7 @@

 /* delete a buffer previously activated by reliable_mark_active() */
 void
-reliable_mark_deleted(struct reliable *rel, struct buffer *buf)
+reliable_mark_deleted(struct reliable *rel, const struct buffer *buf)
 {
     for (int i =3D 0; i < rel->size; ++i)
     {
diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
index a5ed75c..8d9e2e3 100644
--- a/src/openvpn/reliable.h
+++ b/src/openvpn/reliable.h
@@ -173,7 +173,7 @@
  * @li False, if there are packet IDs to be acknowledged.
  */
 static inline bool
-reliable_ack_empty(struct reliable_ack *ack)
+reliable_ack_empty(const struct reliable_ack *ack)
 {
     return !ack->len;
 }
@@ -186,7 +186,7 @@
  * @returns the number of outstanding acks
  */
 static inline int
-reliable_ack_outstanding(struct reliable_ack *ack)
+reliable_ack_outstanding(const struct reliable_ack *ack)
 {
     return ack->len;
 }
@@ -336,7 +336,7 @@
  * @param pid The packet's packet ID.
  * @param opcode The packet's opcode.
  */
-void reliable_mark_active_incoming(struct reliable *rel, struct buffer *bu=
f, packet_id_type pid,
+void reliable_mark_active_incoming(struct reliable *rel, const struct buff=
er *buf, packet_id_type pid,
                                    int opcode);

 /**
@@ -389,7 +389,7 @@
  * @param rel The reliable structure associated with the given buffer.
  * @param buf The buffer of the reliable entry which is to be removed.
  */
-void reliable_mark_deleted(struct reliable *rel, struct buffer *buf);
+void reliable_mark_deleted(struct reliable *rel, const struct buffer *buf);

 /** @} name Functions for extracting incoming packets */

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index da48d8e..f1e84ed 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3942,7 +3942,7 @@
 #else  /* if defined(_WIN32) */

 static void
-get_bypass_addresses(struct route_bypass *rb, const unsigned int flags) /*=
 PLATFORM-SPECIFIC */
+get_bypass_addresses(struct route_bypass *rb, const unsigned int flags)
 {
 }

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 6cc0209..8dd5c27 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1125,8 +1125,8 @@
  * such as TCP.
  */

-static void stream_buf_init(struct stream_buf *sb, struct buffer *buf, con=
st unsigned int sockflags,
-                            const int proto);
+static void stream_buf_init(struct stream_buf *sb, const struct buffer *bu=
f,
+                            const unsigned int sockflags, const int proto);

 static void stream_buf_close(struct stream_buf *sb);

@@ -2075,7 +2075,7 @@
 }

 static void
-stream_buf_init(struct stream_buf *sb, struct buffer *buf, const unsigned =
int sockflags,
+stream_buf_init(struct stream_buf *sb, const struct buffer *buf, const uns=
igned int sockflags,
                 const int proto)
 {
     sb->buf_init =3D *buf;
@@ -2464,7 +2464,7 @@
 #if ENABLE_IP_PKTINFO

 ssize_t
-link_socket_write_udp_posix_sendmsg(struct link_socket *sock, struct buffe=
r *buf,
+link_socket_write_udp_posix_sendmsg(struct link_socket *sock, const struct=
 buffer *buf,
                                     struct link_socket_actual *to)
 {
     struct iovec iov;
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 6196af0..316e763 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -484,7 +484,7 @@
 }

 static inline bool
-link_socket_verify_incoming_addr(struct buffer *buf, const struct link_soc=
ket_info *info,
+link_socket_verify_incoming_addr(const struct buffer *buf, const struct li=
nk_socket_info *info,
                                  const struct link_socket_actual *from_add=
r)
 {
     if (buf->len > 0)
@@ -694,12 +694,12 @@

 #else /* ifdef _WIN32 */

-ssize_t link_socket_write_udp_posix_sendmsg(struct link_socket *sock, stru=
ct buffer *buf,
+ssize_t link_socket_write_udp_posix_sendmsg(struct link_socket *sock, cons=
t struct buffer *buf,
                                             struct link_socket_actual *to);


 static inline ssize_t
-link_socket_write_udp_posix(struct link_socket *sock, struct buffer *buf,
+link_socket_write_udp_posix(struct link_socket *sock, const struct buffer =
*buf,
                             struct link_socket_actual *to)
 {
 #if ENABLE_IP_PKTINFO
@@ -715,7 +715,7 @@
 }

 static inline ssize_t
-link_socket_write_tcp_posix(struct link_socket *sock, struct buffer *buf)
+link_socket_write_tcp_posix(struct link_socket *sock, const struct buffer =
*buf)
 {
     return send(sock->sd, BPTR(buf), BLENZ(buf), MSG_NOSIGNAL);
 }
@@ -819,6 +819,8 @@
     }
 }

+/* cppcheck-suppress constParameterPointer
+ * sock is modified on Windows via &sock->listen_handle */
 static inline void
 socket_reset_listen_persistent(struct link_socket *sock)
 {
diff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h
index 13f5962..add08ba 100644
--- a/src/openvpn/socket_util.h
+++ b/src/openvpn/socket_util.h
@@ -439,7 +439,7 @@


 static inline bool
-addrlist_match_proto(const struct openvpn_sockaddr *a1, struct addrinfo *a=
ddr_list, const int proto)
+addrlist_match_proto(const struct openvpn_sockaddr *a1, const struct addri=
nfo *addr_list, const int proto)
 {
     return link_socket_proto_connection_oriented(proto) ? addrlist_match(a=
1, addr_list)
                                                         : addrlist_port_ma=
tch(a1, addr_list);
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 19f3d54..77ca863 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -82,7 +82,7 @@

 static bool
 socks_proxy_recv_char(uint8_t *c, const char *name, socket_descriptor_t sd,
-                      struct event_timeout *server_poll_timeout,
+                      const struct event_timeout *server_poll_timeout,
                       volatile int *signal_received)
 {
     fd_set reads;
@@ -97,8 +97,8 @@
 }

 static bool
-socks_username_password_auth(struct socks_proxy_info *p, socket_descriptor=
_t sd,
-                             struct event_timeout *server_poll_timeout,
+socks_username_password_auth(const struct socks_proxy_info *p, socket_desc=
riptor_t sd,
+                             const struct event_timeout *server_poll_timeo=
ut,
                              volatile int *signal_received)
 {
     char to_send[516];
@@ -156,8 +156,8 @@
 }

 static bool
-socks_handshake(struct socks_proxy_info *p, socket_descriptor_t sd,
-                struct event_timeout *server_poll_timeout, volatile int *s=
ignal_received)
+socks_handshake(const struct socks_proxy_info *p, socket_descriptor_t sd,
+                const struct event_timeout *server_poll_timeout, volatile =
int *signal_received)
 {
     uint8_t buf[2];
     int len =3D 0;
@@ -231,7 +231,7 @@

 static bool
 recv_socks_reply(socket_descriptor_t sd, struct openvpn_sockaddr *addr,
-                 struct event_timeout *server_poll_timeout, volatile int *=
signal_received)
+                 const struct event_timeout *server_poll_timeout, volatile=
 int *signal_received)
 {
     uint8_t atyp =3D 0;
     int alen =3D 0;
@@ -334,11 +334,11 @@
 }

 void
-establish_socks_proxy_passthru(struct socks_proxy_info *p,
+establish_socks_proxy_passthru(const struct socks_proxy_info *p,
                                socket_descriptor_t sd, /* already open to =
proxy */
                                const char *host,       /* openvpn server r=
emote */
                                const char *servname,   /* openvpn server p=
ort */
-                               struct event_timeout *server_poll_timeout,
+                               const struct event_timeout *server_poll_tim=
eout,
                                struct signal_info *sig_info)
 {
     char buf[270];
@@ -392,10 +392,10 @@
 }

 void
-establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
+establish_socks_proxy_udpassoc(const struct socks_proxy_info *p,
                                socket_descriptor_t ctrl_sd, /* already ope=
n to proxy */
                                struct openvpn_sockaddr *relay_addr,
-                               struct event_timeout *server_poll_timeout,
+                               const struct event_timeout *server_poll_tim=
eout,
                                struct signal_info *sig_info)
 {
     if (!socks_handshake(p, ctrl_sd, server_poll_timeout, &sig_info->signa=
l_received))
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index 846113d..f7c93b6 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -47,17 +47,17 @@

 void socks_proxy_close(struct socks_proxy_info *sp);

-void establish_socks_proxy_passthru(struct socks_proxy_info *p,
+void establish_socks_proxy_passthru(const struct socks_proxy_info *p,
                                     socket_descriptor_t sd, /* already ope=
n to proxy */
                                     const char *host,       /* openvpn ser=
ver remote */
                                     const char *servname,   /* openvpn ser=
ver port */
-                                    struct event_timeout *server_poll_time=
out,
+                                    const struct event_timeout *server_pol=
l_timeout,
                                     struct signal_info *sig_info);

-void establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
+void establish_socks_proxy_udpassoc(const struct socks_proxy_info *p,
                                     socket_descriptor_t ctrl_sd, /* alread=
y open to proxy */
                                     struct openvpn_sockaddr *relay_addr,
-                                    struct event_timeout *server_poll_time=
out,
+                                    const struct event_timeout *server_pol=
l_timeout,
                                     struct signal_info *sig_info);

 void socks_process_incoming_udp(struct buffer *buf, struct link_socket_act=
ual *from);
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 7f3b4dc..262522b 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1159,7 +1159,7 @@
 }

 struct tls_multi *
-tls_multi_init(struct tls_options *tls_options)
+tls_multi_init(const struct tls_options *tls_options)
 {
     struct tls_multi *ret;

@@ -1188,7 +1188,7 @@
  */

 struct tls_auth_standalone *
-tls_auth_standalone_init(struct tls_options *tls_options, struct gc_arena =
*gc)
+tls_auth_standalone_init(const struct tls_options *tls_options, struct gc_=
arena *gc)
 {
     struct tls_auth_standalone *tas;

@@ -1336,7 +1336,7 @@

 static void
 init_epoch_keys(struct key_state *ks, struct tls_multi *multi, const struc=
t key_type *key_type,
-                bool server, struct key2 *key2)
+                bool server, const struct key2 *key2)
 {
     /* For now we hardcode this to be 16 for the software based data chann=
el
      * DCO based implementations/HW implementation might adjust this number
@@ -1375,7 +1375,7 @@

 static void
 init_key_contexts(struct key_state *ks, struct tls_multi *multi, const str=
uct key_type *key_type,
-                  bool server, struct key2 *key2, bool dco_enabled)
+                  bool server, const struct key2 *key2, bool dco_enabled)
 {
     struct key_ctx_bi *key =3D &ks->crypto_options.key_ctx_bi;

@@ -1573,8 +1573,9 @@

 bool
 tls_session_update_crypto_params_do_work(struct tls_multi *multi, struct t=
ls_session *session,
-                                         struct options *options, struct f=
rame *frame,
-                                         struct frame *frame_fragment, str=
uct link_socket_info *lsi,
+                                         const struct options *options, st=
ruct frame *frame,
+                                         struct frame *frame_fragment,
+                                         const struct link_socket_info *ls=
i,
                                          dco_context_t *dco)
 {
     if (session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)
@@ -1643,7 +1644,7 @@
 bool
 tls_session_update_crypto_params(struct tls_multi *multi, struct tls_sessi=
on *session,
                                  struct options *options, struct frame *fr=
ame,
-                                 struct frame *frame_fragment, struct link=
_socket_info *lsi,
+                                 struct frame *frame_fragment, const struc=
t link_socket_info *lsi,
                                  dco_context_t *dco)
 {
     if (!check_session_cipher(session, options))
@@ -2495,8 +2496,8 @@
 }

 bool
-session_skip_to_pre_start(struct tls_session *session, struct tls_pre_decr=
ypt_state *state,
-                          struct link_socket_actual *from)
+session_skip_to_pre_start(struct tls_session *session, const struct tls_pr=
e_decrypt_state *state,
+                          const struct link_socket_actual *from)
 {
     struct key_state *ks =3D &session->key[KS_PRIMARY];
     ks->session_id_remote =3D state->peer_session_id;
@@ -4011,7 +4012,7 @@
 }

 void
-tls_post_encrypt(struct tls_multi *multi, struct buffer *buf)
+tls_post_encrypt(struct tls_multi *multi, const struct buffer *buf)
 {
     struct key_state *ks =3D multi->save_ks;
     multi->save_ks =3D NULL;
@@ -4142,7 +4143,7 @@
  * into a garbage collectable string which is returned.
  */
 const char *
-protocol_dump(struct buffer *buffer, unsigned int flags, struct gc_arena *=
gc)
+protocol_dump(const struct buffer *buffer, unsigned int flags, struct gc_a=
rena *gc)
 {
     struct buffer out =3D alloc_buf_gc(256, gc);
     struct buffer buf =3D *buffer;
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 5822336..3370321 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -166,7 +166,7 @@
  *
  * @return A newly allocated and initialized \c tls_multi structure.
  */
-struct tls_multi *tls_multi_init(struct tls_options *tls_options);
+struct tls_multi *tls_multi_init(const struct tls_options *tls_options);

 /**
  * Finalize initialization of a \c tls_multi structure.
@@ -187,7 +187,7 @@
 /*
  * Initialize a standalone tls-auth verification object.
  */
-struct tls_auth_standalone *tls_auth_standalone_init(struct tls_options *t=
ls_options,
+struct tls_auth_standalone *tls_auth_standalone_init(const struct tls_opti=
ons *tls_options,
                                                      struct gc_arena *gc);

 /**
@@ -371,7 +371,7 @@
  * @param multi - The TLS state for this packet's destination VPN tunnel.
  * @param buf - The buffer containing the outgoing packet.
  */
-void tls_post_encrypt(struct tls_multi *multi, struct buffer *buf);
+void tls_post_encrypt(struct tls_multi *multi, const struct buffer *buf);

 /** @} name Functions for managing security parameter state for data chann=
el packets */

@@ -461,7 +461,8 @@
  */
 bool tls_session_update_crypto_params(struct tls_multi *multi, struct tls_=
session *session,
                                       struct options *options, struct fram=
e *frame,
-                                      struct frame *frame_fragment, struct=
 link_socket_info *lsi,
+                                      struct frame *frame_fragment,
+                                      const struct link_socket_info *lsi,
                                       dco_context_t *dco);

 /*
@@ -525,7 +526,7 @@
 #define PD_VERBOSE                 (1 << 10)
 #define PD_TLS_CRYPT               (1 << 11)

-const char *protocol_dump(struct buffer *buffer, unsigned int flags, struc=
t gc_arena *gc);
+const char *protocol_dump(const struct buffer *buffer, unsigned int flags,=
 struct gc_arena *gc);

 /*
  * debugging code
@@ -573,7 +574,7 @@
 /* Special method to skip the three way handshake RESET stages. This is
  * used by the HMAC code when seeing a packet that matches the previous
  * HMAC based stateless server state */
-bool session_skip_to_pre_start(struct tls_session *session, struct tls_pre=
_decrypt_state *state,
-                               struct link_socket_actual *from);
+bool session_skip_to_pre_start(struct tls_session *session, const struct t=
ls_pre_decrypt_state *state,
+                               const struct link_socket_actual *from);

 #endif /* ifndef OPENVPN_SSL_H */
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 816fb9c..ed395e7 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -144,7 +144,7 @@
  *
  * @return      true if the context is initialised, false if not.
  */
-bool tls_ctx_initialised(struct tls_root_ctx *ctx);
+bool tls_ctx_initialised(const struct tls_root_ctx *ctx);

 /**
  * Set any library specific options.
@@ -177,7 +177,7 @@
  * @param ciphers       String containing : delimited cipher names, or NUL=
L to use
  *                                      sane defaults.
  */
-void tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *=
ciphers);
+void tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, const =
char *ciphers);

 /**
  * Set the TLS certificate profile.  The profile defines which crypto
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 8a0f7d2..f771378 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -161,7 +161,7 @@
 }

 bool
-tls_ctx_initialised(struct tls_root_ctx *ctx)
+tls_ctx_initialised(const struct tls_root_ctx *ctx)
 {
     /* either this should be NULL or should be non-null and then have a
      * valid TLS ctx inside as well */
@@ -284,7 +284,7 @@
 }

 void
-tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphe=
rs)
+tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, const char =
*ciphers)
 {
     if (ciphers =3D=3D NULL)
     {
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 83f9db6..b1b808f 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -147,7 +147,7 @@
 }

 bool
-tls_ctx_initialised(struct tls_root_ctx *ctx)
+tls_ctx_initialised(const struct tls_root_ctx *ctx)
 {
     /* either this should be NULL or should be non-null and then have a
      * valid TLS ctx inside as well */
@@ -509,7 +509,7 @@
 #endif

 void
-tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciphe=
rs)
+tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, const char =
*ciphers)
 {
     if (ciphers =3D=3D NULL)
     {
@@ -1165,7 +1165,7 @@
 }

 static void
-tls_ctx_load_cert_uri(struct tls_root_ctx *tls_ctx, const char *uri)
+tls_ctx_load_cert_uri(const struct tls_root_ctx *tls_ctx, const char *uri)
 {
 #if defined(HAVE_OPENSSL_STORE_API)
     X509 *x =3D NULL;
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 1805995..6b53e7e 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -57,7 +57,7 @@
  *  @return         if the swap was successful (buf was large enough)
  */
 static bool
-swap_hmac(struct buffer *buf, const struct crypto_options *co, bool incomi=
ng)
+swap_hmac(const struct buffer *buf, const struct crypto_options *co, bool =
incoming)
 {
     ASSERT(co);

@@ -117,7 +117,7 @@
  */
 static void
 tls_wrap_control(struct tls_wrap_ctx *ctx, uint8_t header, struct buffer *=
buf,
-                 struct session_id *session_id)
+                 const struct session_id *session_id)
 {
     if (ctx->mode =3D=3D TLS_WRAP_AUTH || ctx->mode =3D=3D TLS_WRAP_NONE)
     {
@@ -403,9 +403,9 @@


 struct buffer
-tls_reset_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone =
*tas,
-                     struct session_id *own_sid, struct session_id *remote=
_sid, uint8_t header,
-                     bool request_resend_wkc)
+tls_reset_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_stand=
alone *tas,
+                     const struct session_id *own_sid, const struct sessio=
n_id *remote_sid,
+                     uint8_t header, bool request_resend_wkc)
 {
     /* Copy buffer here to point at the same data but allow tls_wrap_contr=
ol
      * to potentially change buf to point to another buffer without
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index ac9d4be..ffd34f4 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -220,8 +220,9 @@
  * from the tls pre decrypt state.
  *
  */
-struct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, struct tls_au=
th_standalone *tas,
-                                   struct session_id *own_sid, struct sess=
ion_id *remote_sid,
+struct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, const struct =
tls_auth_standalone *tas,
+                                   const struct session_id *own_sid,
+                                   const struct session_id *remote_sid,
                                    uint8_t header, bool request_resend_wkc=
);


diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index e5b55a1..0298106 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1137,7 +1137,7 @@
  * cache.
  */
 static bool
-tls_authentication_status_use_cache(struct tls_multi *multi)
+tls_authentication_status_use_cache(const struct tls_multi *multi)
 {
     unsigned int idx =3D min_uint(multi->tas_cache_num_updates, SIZE(cache=
_intervals) - 1);
     time_t latency =3D cache_intervals[idx];
@@ -1281,7 +1281,7 @@
  * Check if the script/plugin left a message in the auth failed message
  * file and relay it to the user */
 static void
-check_for_client_reason(struct tls_multi *multi, struct auth_deferred_stat=
us *status)
+check_for_client_reason(struct tls_multi *multi, const struct auth_deferre=
d_status *status)
 {
     struct gc_arena gc =3D gc_new();
     const char *msg =3D key_state_check_auth_failed_message_file(status, &=
gc);
@@ -1550,7 +1550,7 @@
 #endif /* ifdef ENABLE_MANAGEMENT */

 static bool
-set_verify_user_pass_env(struct user_pass *up, struct tls_multi *multi, st=
ruct tls_session *session)
+set_verify_user_pass_env(const struct user_pass *up, struct tls_multi *mul=
ti, struct tls_session *session)
 {
     /* Is username defined? */
     if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen=
(up->username))
@@ -1578,7 +1578,7 @@
 }

 bool
-ssl_verify_username_length(struct tls_session *session, const char *userna=
me)
+ssl_verify_username_length(const struct tls_session *session, const char *=
username)
 {
     if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
         && strlen(username) > TLS_USERNAME_LEN)
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 3176d76..e77bc4a 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -202,7 +202,7 @@
  * @return              true if name is under limit or username-as-common-=
name
  *                      is not active
  */
-bool ssl_verify_username_length(struct tls_session *session, const char *u=
sername);
+bool ssl_verify_username_length(const struct tls_session *session, const c=
har *username);

 /**
  * Runs the --client-crresponse script if one is defined.
@@ -275,7 +275,7 @@
 void auth_set_client_reason(struct tls_multi *multi, const char *client_re=
ason);

 static inline const char *
-tls_client_reason(struct tls_multi *multi)
+tls_client_reason(const struct tls_multi *multi)
 {
     return multi->client_reason;
 }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f46802f..d32bf10 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1808,7 +1808,7 @@

 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
 static bool
-tun_dco_enabled(struct tuntap *tt)
+tun_dco_enabled(const struct tuntap *tt)
 {
     return tt->backend_driver =3D=3D DRIVER_DCO;
 }
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 6a7af85..910f3d3 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -351,7 +351,7 @@
 #define IFCONFIG_DEFAULT IFCONFIG_AFTER_TUN_OPEN

 static inline int
-ifconfig_order(struct tuntap *tt)
+ifconfig_order(const struct tuntap *tt)
 {
     if (tt->backend_driver =3D=3D DRIVER_AFUNIX)
     {
@@ -381,7 +381,7 @@
 #define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN

 static inline int
-route_order(struct tuntap *tt)
+route_order(const struct tuntap *tt)
 {
     if (tt->backend_driver =3D=3D DRIVER_AFUNIX)
     {
@@ -555,25 +555,25 @@
 }

 static inline void
-tun_standby_init(struct tuntap *tt)
+tun_standby_init(const struct tuntap *tt)
 {
 }

 static inline bool
-tun_standby(struct tuntap *tt)
+tun_standby(const struct tuntap *tt)
 {
     return true;
 }


 static inline bool
-tuntap_is_dco_win(struct tuntap *tt)
+tuntap_is_dco_win(const struct tuntap *tt)
 {
     return false;
 }

 static inline bool
-tuntap_is_dco_win_timeout(struct tuntap *tt, int status)
+tuntap_is_dco_win_timeout(const struct tuntap *tt, int status)
 {
     return false;
 }
diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index a67a472..e9223bc 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -48,7 +48,7 @@


 static void
-tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, struct env_=
set *env)
+tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, const struc=
t env_set *env)
 {
     const char *msgprefix =3D "ERROR: failure executing process for tun:";
     struct argv argv =3D argv_new();
@@ -73,7 +73,7 @@
 }

 void
-open_tun_afunix(struct options *o, int mtu, struct tuntap *tt, struct env_=
set *orig_env)
+open_tun_afunix(const struct options *o, int mtu, struct tuntap *tt, const=
 struct env_set *orig_env)
 {
     struct gc_arena gc =3D gc_new();

diff --git a/src/openvpn/tun_afunix.h b/src/openvpn/tun_afunix.h
index 5b6a8e0..fb88eb2 100644
--- a/src/openvpn/tun_afunix.h
+++ b/src/openvpn/tun_afunix.h
@@ -31,7 +31,7 @@
  * the user provided taking care of implementing the actual tun
  * device.
  */
-void open_tun_afunix(struct options *o, int mtu, struct tuntap *tt, struct=
 env_set *env);
+void open_tun_afunix(const struct options *o, int mtu, struct tuntap *tt, =
const struct env_set *env);


 /**
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index bffc60e..cd32a9b 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -288,7 +288,7 @@
 }

 void
-vlan_process_outgoing_tun(struct multi_context *m, struct multi_instance *=
mi)
+vlan_process_outgoing_tun(const struct multi_context *m, struct multi_inst=
ance *mi)
 {
     if (!m->top.options.vlan_tagging)
     {
diff --git a/src/openvpn/vlan.h b/src/openvpn/vlan.h
index 9389f89..cd2f66f 100644
--- a/src/openvpn/vlan.h
+++ b/src/openvpn/vlan.h
@@ -35,6 +35,6 @@

 bool vlan_is_tagged(const struct buffer *buf);

-void vlan_process_outgoing_tun(struct multi_context *m, struct multi_insta=
nce *mi);
+void vlan_process_outgoing_tun(const struct multi_context *m, struct multi=
_instance *mi);
=20
 #endif /* VLAN_H */
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsic=
a.c
index 6a71801..593536b 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -77,7 +77,7 @@
  * @return ERROR_SUCCESS on success; An error code otherwise
  */
 static UINT
-setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_ st=
ruct msica_arg_seq *seq)
+setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szProperty, _In_ co=
nst struct msica_arg_seq *seq)
 {
     UINT uiResult;
     LPWSTR szSequence =3D msica_arg_seq_join(seq);
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ace25b9..1ac7027 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -521,7 +521,7 @@


 static SOCKADDR_INET
-sockaddr_inet(short family, inet_address_t *addr)
+sockaddr_inet(short family, const inet_address_t *addr)
 {
     SOCKADDR_INET sa_inet;
     ZeroMemory(&sa_inet, sizeof(sa_inet));
@@ -3722,7 +3722,7 @@

 static DWORD
 UpdateWaitHandles(LPHANDLE *handles_ptr, LPDWORD count, HANDLE io_event, H=
ANDLE exit_event,
-                  list_item_t *threads)
+                  const list_item_t *threads)
 {
     static DWORD size =3D 10;
     static LPHANDLE handles =3D NULL;
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index a49de40..48e2446 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -62,11 +62,6 @@
     exit 1
 fi

-if [ -z "$CA_CERT" ] ; then
-    echo "CA_CERT not defined in 't_client.rc'. SKIP test." >&2
-    exit "${TCLIENT_SKIP_RC}"
-fi
-
 if [ -z "$TEST_RUN_LIST" ] ; then
     echo "TEST_RUN_LIST empty, no tests defined.  SKIP test." >&2
     exit "${TCLIENT_SKIP_RC}"
diff --git a/tests/unit_tests/openvpn/mock_management.c b/tests/unit_tests/=
openvpn/mock_management.c
index 77f6ce2..fff4c2b 100644
--- a/tests/unit_tests/openvpn/mock_management.c
+++ b/tests/unit_tests/openvpn/mock_management.c
@@ -36,7 +36,7 @@
 struct management *management; /* GLOBAL */

 void
-management_auth_failure(struct management *man, const char *type, const ch=
ar *reason)
+management_auth_failure(const struct management *man, const char *type, co=
nst char *reason)
 {
     ASSERT(false);
 }
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index 4a055e7..af96764 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -146,7 +146,7 @@
 }

 static struct hash_element *
-hash_lookup_by_value(struct hash *hash, void *value)
+hash_lookup_by_value(struct hash *hash, const void *value)
 {
     struct hash_iterator hi;
     struct hash_element *he;
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index c0a0866..7636a33 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -59,7 +59,7 @@
     return mock();
 }
 void
-management_auth_failure(struct management *man, const char *type, const ch=
ar *reason)
+management_auth_failure(const struct management *man, const char *type, co=
nst char *reason)
 {
     assert_true(0);
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1663?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
Gerrit-Change-Number: 1663
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--GF3ptzrJatE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1663?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Remove instances of constParameterPointer c=
ppcheck warnings<br><br>This requires a few suppressions since cppcheck<br>=
doesn&#39;t quite understand the different code-paths<br>implemented by pre=
processor defines.<br><br>Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116=
f58<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>=
M dev-tools/cppcheck-suppression<br>M dev-tools/run-cppcheck.sh<br>M sample=
/sample-plugins/client-connect/sample-client-connect.c<br>M sample/sample-p=
lugins/defer/multi-auth.c<br>M sample/sample-plugins/keying-material-export=
er-demo/keyingmaterialexporter.c<br>M src/openvpn/buffer.c<br>M src/openvpn=
/buffer.h<br>M src/openvpn/clinat.c<br>M src/openvpn/clinat.h<br>M src/open=
vpn/comp.c<br>M src/openvpn/comp.h<br>M src/openvpn/crypto.c<br>M src/openv=
pn/crypto.h<br>M src/openvpn/dco.c<br>M src/openvpn/dco.h<br>M src/openvpn/=
dco_freebsd.c<br>M src/openvpn/dco_internal.h<br>M src/openvpn/dco_linux.c<=
br>M src/openvpn/dco_win.c<br>M src/openvpn/dhcp.c<br>M src/openvpn/dhcp.h<=
br>M src/openvpn/event.h<br>M src/openvpn/forward.c<br>M src/openvpn/forwar=
d.h<br>M src/openvpn/init.c<br>M src/openvpn/init.h<br>M src/openvpn/interv=
al.h<br>M src/openvpn/list.c<br>M src/openvpn/list.h<br>M src/openvpn/manag=
e.c<br>M src/openvpn/manage.h<br>M src/openvpn/mbuf.c<br>M src/openvpn/mbuf=
.h<br>M src/openvpn/mss.c<br>M src/openvpn/mss.h<br>M src/openvpn/mtcp.c<br=
>M src/openvpn/mtcp.h<br>M src/openvpn/mudp.c<br>M src/openvpn/multi.c<br>M=
 src/openvpn/multi.h<br>M src/openvpn/networking.h<br>M src/openvpn/network=
ing_iproute2.c<br>M src/openvpn/networking_sitnl.c<br>M src/openvpn/occ.h<b=
r>M src/openvpn/openssl_compat.h<br>M src/openvpn/options.c<br>M src/openvp=
n/options_parse.c<br>M src/openvpn/otime.c<br>M src/openvpn/otime.h<br>M sr=
c/openvpn/proto.h<br>M src/openvpn/proxy.c<br>M src/openvpn/proxy.h<br>M sr=
c/openvpn/push.c<br>M src/openvpn/push.h<br>M src/openvpn/push_util.c<br>M =
src/openvpn/reliable.c<br>M src/openvpn/reliable.h<br>M src/openvpn/route.c=
<br>M src/openvpn/socket.c<br>M src/openvpn/socket.h<br>M src/openvpn/socke=
t_util.h<br>M src/openvpn/socks.c<br>M src/openvpn/socks.h<br>M src/openvpn=
/ssl.c<br>M src/openvpn/ssl.h<br>M src/openvpn/ssl_backend.h<br>M src/openv=
pn/ssl_mbedtls.c<br>M src/openvpn/ssl_openssl.c<br>M src/openvpn/ssl_pkt.c<=
br>M src/openvpn/ssl_pkt.h<br>M src/openvpn/ssl_verify.c<br>M src/openvpn/s=
sl_verify.h<br>M src/openvpn/tun.c<br>M src/openvpn/tun.h<br>M src/openvpn/=
tun_afunix.c<br>M src/openvpn/tun_afunix.h<br>M src/openvpn/vlan.c<br>M src=
/openvpn/vlan.h<br>M src/openvpnmsica/openvpnmsica.c<br>M src/openvpnserv/i=
nteractive.c<br>M tests/t_client.sh.in<br>M tests/unit_tests/openvpn/mock_m=
anagement.c<br>M tests/unit_tests/openvpn/test_misc.c<br>M tests/unit_tests=
/openvpn/test_user_pass.c<br>84 files changed, 248 insertions(+), 226 delet=
ions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/=
openvpn refs/changes/63/1663/1</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-supp=
ression b/dev-tools/cppcheck-suppression</span><br><span>index 8a74e84..362=
d9f9 100644</span><br><span>--- a/dev-tools/cppcheck-suppression</span><br>=
<span>+++ b/dev-tools/cppcheck-suppression</span><br><span>@@ -2,7 +2,6 @@<=
/span><br><span> # occurences right now. They still should be fixed at some=
 point</span><br><span> constParameter</span><br><span> constParameterCallb=
ack</span><br><span style=3D"color: hsl(0, 100%, 40%);">-constParameterPoin=
ter</span><br><span> variableScope</span><br><span> # We have a lot of libr=
ary includes, not all of them are really required,</span><br><span> # so ig=
nore them</span><br><span>@@ -20,6 +19,27 @@</span><br><span> # IGN: the co=
de header =3D 0 | (OPCODE &lt;&lt; P_OPCODE_SHIFT) is used intentionally</s=
pan><br><span> badBitmaskCheck:src/openvpn/mudp.c</span><br><span> badBitma=
skCheck:tests/unit_tests/openvpn/test_pkt.c</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+constParameterPointer:/usr/include/*</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# IGN: test files provide mocks/st=
ubs that match prototypes from headers exactly</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+constParameterPointer:tests/unit_tests/openvpn/m=
ock_*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameter=
Pointer:tests/unit_tests/openvpn/test_*</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+constParameterPointer:tests/unit_tests/openvpnserv/test=
_*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FP: the restric=
tion to OpenSSL &gt;=3D 3 seems to confuse cppcheck</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/crypto_=
openssl.c:172</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FP: =
parameters are modified on Windows (or non-Linux) only</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/error.=
c:223</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameter=
Pointer:src/openvpn/manage.c:3332</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+constParameterPointer:src/openvpn/misc.c:792</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/mi=
sc.c:812</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParame=
terPointer:src/openvpn/options.c:3205</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+constParameterPointer:src/openvpn/route.c:3945</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:src/open=
vpn/socket.c:2246</span><br><span style=3D"color: hsl(120, 100%, 40%);">+co=
nstParameterPointer:src/openvpn/socket.h:726</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+constParameterPointer:src/openvpn/socket.h:825</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+constParameterPointer:s=
rc/openvpn/ssl_openssl.c:540</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+constParameterPointer:src/openvpn/tun.c:560</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# FP: local is modified via cast inside f=
unction</span><br><span style=3D"color: hsl(120, 100%, 40%);">+constParamet=
erPointer:src/openvpn/dco.c:560</span><br><span> # IGN: event code uses a p=
ointer to store integers</span><br><span> intToPointerCast:src/openvpn/mult=
i_io.c</span><br><span> intToPointerCast:src/openvpn/forward.c</span><br><s=
pan>diff --git a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh</spa=
n><br><span>index 674fc092..176d332 100755</span><br><span>--- a/dev-tools/=
run-cppcheck.sh</span><br><span>+++ b/dev-tools/run-cppcheck.sh</span><br><=
span>@@ -13,7 +13,7 @@</span><br><span> mkdir -p &quot;$CPPCHECK_DIR&quot;<=
/span><br><span> cd &quot;${SOURCE_DIR}&quot;</span><br><span> cppcheck -j$=
(nproc) \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	 -DHAVE_CON=
FIG_H -U_WIN32 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	 -=
DHAVE_CONFIG_H \</span><br><span>          -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBE=
DTLS_SSL_KEYING_MATERIAL_EXPORT \</span><br><span> 	 -I./include/ -I./tests=
/unit_tests/openvpn/ \</span><br><span> 	 -I./src/compat/ -I./src/openvpn/ =
-I./src/openvpnserv/ -I./src/plugins/auth-pam/ \</span><br><span>diff --git=
 a/sample/sample-plugins/client-connect/sample-client-connect.c b/sample/sa=
mple-plugins/client-connect/sample-client-connect.c</span><br><span>index 4=
20de61..cbd98e8 100644</span><br><span>--- a/sample/sample-plugins/client-c=
onnect/sample-client-connect.c</span><br><span>+++ b/sample/sample-plugins/=
client-connect/sample-client-connect.c</span><br><span>@@ -344,7 +344,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> int</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-openvpn_plugin_client_connect(struct pl=
ugin_context *context, const char **argv, const char **envp)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+openvpn_plugin_client_connect(cons=
t struct plugin_context *context, const char **argv, const char **envp)</sp=
an><br><span> {</span><br><span>     /* log environment variables handed to=
 us by OpenVPN, but</span><br><span>      * only if &quot;setenv verb&quot;=
 is 3 or higher (arbitrary number)</span><br><span>@@ -465,7 +465,7 @@</spa=
n><br><span> </span><br><span> int</span><br><span> openvpn_plugin_client_c=
onnect_defer_v2(struct plugin_context *context,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                       struct plu=
gin_per_client_context *pcc,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                       const struct plugin_per_cli=
ent_context *pcc,</span><br><span>                                        s=
truct openvpn_plugin_string_list **return_list)</span><br><span> {</span><b=
r><span>     time_t time_left =3D pcc-&gt;sleep_until - time(NULL);</span><=
br><span>diff --git a/sample/sample-plugins/defer/multi-auth.c b/sample/sam=
ple-plugins/defer/multi-auth.c</span><br><span>index 33fbe61..a6cb637 10064=
4</span><br><span>--- a/sample/sample-plugins/defer/multi-auth.c</span><br>=
<span>+++ b/sample/sample-plugins/defer/multi-auth.c</span><br><span>@@ -25=
5,7 +255,7 @@</span><br><span> }</span><br><span> </span><br><span> static =
bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_auth_user_pass=
(struct plugin_context *context, const char *username, const char *password=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+do_auth_user_pass(=
const struct plugin_context *context, const char *username, const char *pas=
sword)</span><br><span> {</span><br><span>     plog(context, PLOG_NOTE, &qu=
ot;expect_user=3D%s, received_user=3D%s, expect_passw=3D%s, received_passw=
=3D%s&quot;,</span><br><span>          np(context-&gt;test_valid_user), np(=
username), np(context-&gt;test_valid_pass), np(password));</span><br><span>=
diff --git a/sample/sample-plugins/keying-material-exporter-demo/keyingmate=
rialexporter.c b/sample/sample-plugins/keying-material-exporter-demo/keying=
materialexporter.c</span><br><span>index 25c9ff5..512861a 100644</span><br>=
<span>--- a/sample/sample-plugins/keying-material-exporter-demo/keyingmater=
ialexporter.c</span><br><span>+++ b/sample/sample-plugins/keying-material-e=
xporter-demo/keyingmaterialexporter.c</span><br><span>@@ -186,7 +186,7 @@</=
span><br><span> }</span><br><span> </span><br><span> static void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-file_store(char *file, char *con=
tent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+file_store(con=
st char *file, const char *content)</span><br><span> {</span><br><span>    =
 FILE *f;</span><br><span>     if (!(f =3D fopen(file, &quot;w+&quot;)))</s=
pan><br><span>@@ -202,7 +202,7 @@</span><br><span> server_store(struct open=
vpn_plugin_args_func_in const *args)</span><br><span> {</span><br><span>   =
  struct plugin *plugin =3D (struct plugin *)args-&gt;handle;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct session *sess =3D (struc=
t session *)args-&gt;per_client_context;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const struct session *sess =3D (struct session *)a=
rgs-&gt;per_client_context;</span><br><span> </span><br><span>     char fil=
e[MAXPATH];</span><br><span>     snprintf(file, sizeof(file) - 1, &quot;/tm=
p/openvpn_sso_%s&quot;, sess-&gt;key);</span><br><span>@@ -214,7 +214,7 @@<=
/span><br><span> client_store(struct openvpn_plugin_args_func_in const *arg=
s)</span><br><span> {</span><br><span>     struct plugin *plugin =3D (struc=
t plugin *)args-&gt;handle;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct session *sess =3D (struct session *)args-&gt;per_client_co=
ntext;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const str=
uct session *sess =3D (struct session *)args-&gt;per_client_context;</span>=
<br><span> </span><br><span>     char *file =3D &quot;/tmp/openvpn_sso_user=
&quot;;</span><br><span>     ovpn_note(&quot;app session file: %s&quot;, fi=
le);</span><br><span>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer=
.c</span><br><span>index 46c1d12..bdc1937 100644</span><br><span>--- a/src/=
openvpn/buffer.c</span><br><span>+++ b/src/openvpn/buffer.c</span><br><span=
>@@ -285,7 +285,7 @@</span><br><span>  * truncated by buf_printf</span><br>=
<span>  */</span><br><span> void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-buf_catrunc(struct buffer *buf, const char *str)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+buf_catrunc(const struct buffer *bu=
f, const char *str)</span><br><span> {</span><br><span>     if (buf_forward=
_capacity(buf) &lt;=3D 1)</span><br><span>     {</span><br><span>@@ -1086,7=
 +1086,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-string_check_buf(struct bu=
ffer *buf, const unsigned int inclusive, const unsigned int exclusive)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+string_check_buf(const s=
truct buffer *buf, const unsigned int inclusive, const unsigned int exclusi=
ve)</span><br><span> {</span><br><span>     ASSERT(buf);</span><br><span> <=
/span><br><span>diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h</s=
pan><br><span>index 6a751ad..0d3b202 100644</span><br><span>--- a/src/openv=
pn/buffer.h</span><br><span>+++ b/src/openvpn/buffer.h</span><br><span>@@ -=
487,7 +487,7 @@</span><br><span>  * write a string to the end of a buffer t=
hat was</span><br><span>  * truncated by buf_printf</span><br><span>  */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-void buf_catrunc(struct =
buffer *buf, const char *str);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void buf_catrunc(const struct buffer *buf, const char *str);</sp=
an><br><span> </span><br><span> /*</span><br><span>  * Parse a string based=
 on a given delimiter char</span><br><span>@@ -774,7 +774,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static inline int</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-buf_peek_u8(struct buffer *buf)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_peek_u8(const struct =
buffer *buf)</span><br><span> {</span><br><span>     int ret;</span><br><sp=
an>     if (BLEN(buf) &lt; 1)</span><br><span>@@ -923,7 +923,7 @@</span><br=
><span>  * @param exclusive Character classes that are not allowed even if =
they are also in inclusive.</span><br><span>  * @return True if the string =
consists only of allowed characters, false otherwise.</span><br><span>  */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool string_check_buf(=
struct buffer *buf, const unsigned int inclusive,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool string_check_buf(const struct buffer *bu=
f, const unsigned int inclusive,</span><br><span>                       con=
st unsigned int exclusive);</span><br><span> </span><br><span> /**</span><b=
r><span>@@ -1102,7 +1102,7 @@</span><br><span>     }</span><br><span> </spa=
n><br><span> static inline void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-check_malloc_return(void *p)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+check_malloc_return(const void *p)</span><br><span> {</s=
pan><br><span>     if (!p)</span><br><span>     {</span><br><span>diff --gi=
t a/src/openvpn/clinat.c b/src/openvpn/clinat.c</span><br><span>index 32c13=
25..62b7cf9 100644</span><br><span>--- a/src/openvpn/clinat.c</span><br><sp=
an>+++ b/src/openvpn/clinat.c</span><br><span>@@ -181,7 +181,7 @@</span><br=
><span> }</span><br><span> </span><br><span> void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-client_nat_transform(const struct client_nat_op=
tion_list *list, struct buffer *ipbuf,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+client_nat_transform(const struct client_nat_option_list=
 *list, const struct buffer *ipbuf,</span><br><span>                      c=
onst int direction)</span><br><span> {</span><br><span>     struct ip_tcp_u=
dp_hdr *h =3D (struct ip_tcp_udp_hdr *)BPTR(ipbuf);</span><br><span>diff --=
git a/src/openvpn/clinat.h b/src/openvpn/clinat.h</span><br><span>index 1e8=
ceb3..bc56037 100644</span><br><span>--- a/src/openvpn/clinat.h</span><br><=
span>+++ b/src/openvpn/clinat.h</span><br><span>@@ -60,7 +60,7 @@</span><br=
><span>                                    const char *network, const char =
*netmask,</span><br><span>                                    const char *f=
oreign_network, msglvl_t msglevel);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void client_nat_transform(const struct clie=
nt_nat_option_list *list, struct buffer *ipbuf,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void client_nat_transform(const struct client_n=
at_option_list *list, const struct buffer *ipbuf,</span><br><span>         =
                  const int direction);</span><br><span> </span><br><span> =
#endif /* if !defined(CLINAT_H) */</span><br><span>diff --git a/src/openvpn=
/comp.c b/src/openvpn/comp.c</span><br><span>index b88b79f..387a7c4 100644<=
/span><br><span>--- a/src/openvpn/comp.c</span><br><span>+++ b/src/openvpn/=
comp.c</span><br><span>@@ -159,7 +159,7 @@</span><br><span> #endif /* USE_C=
OMP */</span><br><span> </span><br><span> bool</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-check_compression_settings_valid(struct compress_o=
ptions *info, msglvl_t msglevel)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+check_compression_settings_valid(const struct compress_options=
 *info, msglvl_t msglevel)</span><br><span> {</span><br><span>     /*</span=
><br><span>      * We also allow comp-stub-v2 here as it technically allows=
 escaping of</span><br><span>diff --git a/src/openvpn/comp.h b/src/openvpn/=
comp.h</span><br><span>index 29a90a2..ad80243 100644</span><br><span>--- a/=
src/openvpn/comp.h</span><br><span>+++ b/src/openvpn/comp.h</span><br><span=
>@@ -91,7 +91,7 @@</span><br><span>  * flags of allow-compression and also =
the whether algorithms are compiled</span><br><span>  * in</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool check_compre=
ssion_settings_valid(struct compress_options *info, msglvl_t msglevel);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool check_compression_=
settings_valid(const struct compress_options *info, msglvl_t msglevel);</sp=
an><br><span> </span><br><span> #ifdef USE_COMP</span><br><span> #include &=
quot;buffer.h&quot;</span><br><span>diff --git a/src/openvpn/crypto.c b/src=
/openvpn/crypto.c</span><br><span>index a9a33c0..e04eedf 100644</span><br><=
span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c<=
/span><br><span>@@ -1105,7 +1105,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-key_is_zero(struct key *key, const struct key_type *kt)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+key_is_zero(const struct key *ke=
y, const struct key_type *kt)</span><br><span> {</span><br><span>     size_=
t cipher_length =3D cipher_kt_key_size(kt-&gt;cipher);</span><br><span>    =
 for (size_t i =3D 0; i &lt; cipher_length; ++i)</span><br><span>@@ -1123,7=
 +1123,7 @@</span><br><span>  * Make sure that cipher key is a valid key fo=
r current key_type.</span><br><span>  */</span><br><span> bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-check_key(struct key *key, const s=
truct key_type *kt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
check_key(const struct key *key, const struct key_type *kt)</span><br><span=
> {</span><br><span>     if (cipher_defined(kt-&gt;cipher))</span><br><span=
>     {</span><br><span>@@ -1196,7 +1196,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-test_crypto(struct crypto_options *co, struct frame *frame)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+test_crypto(struct crypto_o=
ptions *co, const struct frame *frame)</span><br><span> {</span><br><span> =
    int i, j;</span><br><span>     struct gc_arena gc =3D gc_new();</span><=
br><span>diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br=
><span>index fbca2a0..044f2d2 100644</span><br><span>--- a/src/openvpn/cryp=
to.h</span><br><span>+++ b/src/openvpn/crypto.h</span><br><span>@@ -414,7 +=
414,7 @@</span><br><span>  */</span><br><span> int write_key_file(const int=
 nkeys, const char *filename);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-bool check_key(struct key *key, const struct key=
_type *kt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool che=
ck_key(const struct key *key, const struct key_type *kt);</span><br><span> =
</span><br><span> /**</span><br><span>  * Initialize a key_type structure w=
ith.</span><br><span>@@ -609,7 +609,7 @@</span><br><span> /** Print a ciphe=
r list entry */</span><br><span> void print_cipher(const char *cipher);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void te=
st_crypto(struct crypto_options *co, struct frame *f);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void test_crypto(struct crypto_options *=
co, const struct frame *f);</span><br><span> </span><br><span> </span><br><=
span> /* key direction functions */</span><br><span>diff --git a/src/openvp=
n/dco.c b/src/openvpn/dco.c</span><br><span>index 69ce1d7..cc7ef03 100644</=
span><br><span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/openvpn/dc=
o.c</span><br><span>@@ -556,7 +556,7 @@</span><br><span> }</span><br><span>=
 </span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-dco_multi_get_localaddr(struct multi_context *m, struct multi_inst=
ance *mi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_multi_=
get_localaddr(const struct multi_context *m, const struct multi_instance *m=
i,</span><br><span>                         struct sockaddr_storage *local)=
</span><br><span> {</span><br><span> #if ENABLE_IP_PKTINFO</span><br><span>=
@@ -568,7 +568,7 @@</span><br><span>         return false;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    struct link_socket_actual *actual =3D &amp;c-&gt;c2.link_socket_info=
s[0]-&gt;lsa-&gt;actual;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const struct link_socket_actual *actual =3D &amp;c-&gt;c2.link_soc=
ket_infos[0]-&gt;lsa-&gt;actual;</span><br><span> </span><br><span>     swi=
tch (actual-&gt;dest.addr.sa.sa_family)</span><br><span>     {</span><br><s=
pan>@@ -606,7 +606,7 @@</span><br><span> }</span><br><span> </span><br><spa=
n> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_multi_add_n=
ew_peer(struct multi_context *m, struct multi_instance *mi)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+dco_multi_add_new_peer(const struct=
 multi_context *m, struct multi_instance *mi)</span><br><span> {</span><br>=
<span>     const struct context *c =3D &amp;mi-&gt;context;</span><br><span=
> </span><br><span>@@ -779,7 +779,7 @@</span><br><span>         /* Checked =
if we added a host route as the assigned client IP address was</span><br><s=
pan>          * outside the --ifconfig-ipv6 tun interface config */</span><=
br><span> #if !defined(_WIN32)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        struct in6_addr *dest =3D &amp;mi-&gt;context.c2.push_ifco=
nfig_ipv6_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     const struct in6_addr *dest =3D &amp;mi-&gt;context.c2.push_ifconfig_i=
pv6_local;</span><br><span>         if (multi_check_push_ifconfig_ipv6_extr=
a_route(mi, dest))</span><br><span>         {</span><br><span>             =
/* On windows we do not install these routes, so we also do not need to del=
ete them */</span><br><span>diff --git a/src/openvpn/dco.h b/src/openvpn/dc=
o.h</span><br><span>index 4e5aad5..55ce38a 100644</span><br><span>--- a/src=
/openvpn/dco.h</span><br><span>+++ b/src/openvpn/dco.h</span><br><span>@@ -=
138,7 +138,7 @@</span><br><span> /**</span><br><span>  * Install a DCO in t=
he main event loop</span><br><span>  */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-void dco_event_set(dco_context_t *dco, struct event_set *=
es, void *arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
 dco_event_set(const dco_context_t *dco, struct event_set *es, void *arg);<=
/span><br><span> </span><br><span> /**</span><br><span>  * Install the key =
material in DCO for the specified peer.</span><br><span>@@ -204,7 +204,7 @@=
</span><br><span>  * @param mi        the client instance</span><br><span> =
 * @return          0 on success or a negative error code otherwise</span><=
br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int dco_=
multi_add_new_peer(struct multi_context *m, struct multi_instance *mi);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+int dco_multi_add_new_p=
eer(const struct multi_context *m, struct multi_instance *mi);</span><br><s=
pan> </span><br><span> /**</span><br><span>  * Install an iroute in DCO, wh=
ich means adding a route to the system routing</span><br><span>@@ -253,7 +2=
53,7 @@</span><br><span>  * a 64 bit packet counter and AEAD tag at the end=
.</span><br><span>  */</span><br><span> bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct context *c);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(cons=
t struct context *c);</span><br><span> #else  /* if defined(ENABLE_DCO) */<=
/span><br><span> </span><br><span> typedef void *dco_context_t;</span><br><=
span>@@ -313,7 +313,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+dco_event_set(const dco_con=
text_t *dco, struct event_set *es, void *arg)</span><br><span> {</span><br>=
<span> }</span><br><span> </span><br><span>@@ -350,7 +350,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static inline int</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-dco_multi_add_new_peer(struct multi_c=
ontext *m, struct multi_instance *mi)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dco_multi_add_new_peer(const struct multi_context *m, str=
uct multi_instance *mi)</span><br><span> {</span><br><span>     return 0;</=
span><br><span> }</span><br><span>@@ -384,7 +384,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> static inline bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struct context *c)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_d=
ata(const struct context *c)</span><br><span> {</span><br><span>     return=
 false;</span><br><span> }</span><br><span>diff --git a/src/openvpn/dco_fre=
ebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>index b07df13..908fc73 1=
00644</span><br><span>--- a/src/openvpn/dco_freebsd.c</span><br><span>+++ b=
/src/openvpn/dco_freebsd.c</span><br><span>@@ -778,7 +778,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-dco_event_set(dco_context_t *dco, struct event_set=
 *es, void *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco=
_event_set(const dco_context_t *dco, struct event_set *es, void *arg)</span=
><br><span> {</span><br><span>     struct ifdrv drv;</span><br><span>     n=
vlist_t *nvl;</span><br><span>@@ -929,7 +929,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-dco_supports_epoch_data(struct context *c)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(const struct con=
text *c)</span><br><span> {</span><br><span>     return false;</span><br><s=
pan> }</span><br><span>diff --git a/src/openvpn/dco_internal.h b/src/openvp=
n/dco_internal.h</span><br><span>index fcf8aca..1022e66 100644</span><br><s=
pan>--- a/src/openvpn/dco_internal.h</span><br><span>+++ b/src/openvpn/dco_=
internal.h</span><br><span>@@ -59,8 +59,9 @@</span><br><span>  * They are i=
mplemented by dco_linux.c</span><br><span>  */</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-int dco_new_peer(dco_context_t *=
dco, unsigned int peerid, socket_descriptor_t sd, struct sockaddr *localadd=
r,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 st=
ruct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4, const struct in6=
_addr *vpn_ipv6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in=
t dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descriptor_t=
 sd,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
  struct sockaddr *localaddr, struct sockaddr *remoteaddr,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                 const struct in_add=
r *vpn_ipv4, const struct in6_addr *vpn_ipv6);</span><br><span> </span><br>=
<span> int dco_del_peer(dco_context_t *dco, unsigned int peerid);</span><br=
><span> </span><br><span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn=
/dco_linux.c</span><br><span>index 56f6259..7039fea 100644</span><br><span>=
--- a/src/openvpn/dco_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c=
</span><br><span>@@ -114,7 +114,7 @@</span><br><span> }</span><br><span> </=
span><br><span> static struct nl_msg *</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-ovpn_dco_nlmsg_create(dco_context_t *dco, uint8_t cmd)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_dco_nlmsg_create(c=
onst dco_context_t *dco, uint8_t cmd)</span><br><span> {</span><br><span>  =
   struct nl_msg *nl_msg =3D nlmsg_alloc();</span><br><span>     if (!nl_ms=
g)</span><br><span>@@ -804,7 +804,7 @@</span><br><span> </span><br><span> /=
* libnl &lt; 3.11.0 does not implement nla_get_uint() */</span><br><span> s=
tatic uint64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ovpn_nl=
a_get_uint(struct nlattr *attr)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ovpn_nla_get_uint(const struct nlattr *attr)</span><br><span> {=
</span><br><span>     if (nla_len(attr) =3D=3D sizeof(uint32_t))</span><br>=
<span>     {</span><br><span>@@ -916,7 +916,7 @@</span><br><span> }</span><=
br><span> </span><br><span> static bool</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-ovpn_iface_check(dco_context_t *dco, struct nlattr *attrs=
[])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_iface_check=
(const dco_context_t *dco, struct nlattr *attrs[])</span><br><span> {</span=
><br><span>     /* we must know which interface this message is referring t=
o in order to</span><br><span>      * avoid mixing messages for other insta=
nces</span><br><span>@@ -1325,7 +1325,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-dco_event_set(dco_context_t *dco, struct event_set *es, void *arg)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_event_set(const dco=
_context_t *dco, struct event_set *es, void *arg)</span><br><span> {</span>=
<br><span>     if (dco &amp;&amp; dco-&gt;nl_sock)</span><br><span>     {</=
span><br><span>@@ -1340,7 +1340,7 @@</span><br><span> }</span><br><span> </=
span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-d=
co_supports_epoch_data(struct context *c)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+dco_supports_epoch_data(const struct context *c)</spa=
n><br><span> {</span><br><span>     return false;</span><br><span> }</span>=
<br><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span>=
<br><span>index 102206a..e87ed1e 100644</span><br><span>--- a/src/openvpn/d=
co_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -93=
9,7 +939,7 @@</span><br><span> }</span><br><span> </span><br><span> void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_event_set(dco_contex=
t_t *dco, struct event_set *es, void *arg)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+dco_event_set(const dco_context_t *dco, struct event=
_set *es, void *arg)</span><br><span> {</span><br><span>     if (dco-&gt;if=
mode !=3D DCO_MODE_MP)</span><br><span>     {</span><br><span>@@ -1100,7 +1=
100,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epoch_data(struc=
t context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_su=
pports_epoch_data(const struct context *c)</span><br><span> {</span><br><sp=
an>     OVPN_VERSION ver =3D { 0 };</span><br><span>     return dco_get_ver=
sion(&amp;ver) &amp;&amp; ((ver.Major =3D=3D 2 &amp;&amp; ver.Minor &gt;=3D=
 8) || (ver.Major &gt; 2));</span><br><span>diff --git a/src/openvpn/dhcp.c=
 b/src/openvpn/dhcp.c</span><br><span>index a54ab3f..68173e6 100644</span><=
br><span>--- a/src/openvpn/dhcp.c</span><br><span>+++ b/src/openvpn/dhcp.c<=
/span><br><span>@@ -145,7 +145,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> in_addr_t</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-dhcp_extract_router_msg(struct buffer *ipbuf)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+dhcp_extract_router_msg(const struct buffer *i=
pbuf)</span><br><span> {</span><br><span>     struct dhcp_full *df =3D (str=
uct dhcp_full *)BPTR(ipbuf);</span><br><span>     const int optlen =3D</spa=
n><br><span>diff --git a/src/openvpn/dhcp.h b/src/openvpn/dhcp.h</span><br>=
<span>index 38ebf8d..ed8a0c9 100644</span><br><span>--- a/src/openvpn/dhcp.=
h</span><br><span>+++ b/src/openvpn/dhcp.h</span><br><span>@@ -91,7 +91,7 @=
@</span><br><span> </span><br><span> #pragma pack()</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-in_addr_t dhcp_extract_rout=
er_msg(struct buffer *ipbuf);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+in_addr_t dhcp_extract_router_msg(const struct buffer *ipbuf);</s=
pan><br><span> </span><br><span> #if defined(_WIN32) || defined(DHCP_UNIT_T=
EST)</span><br><span> #include &quot;tun.h&quot;</span><br><span>diff --git=
 a/src/openvpn/event.h b/src/openvpn/event.h</span><br><span>index b784dfe.=
.0940a1d 100644</span><br><span>--- a/src/openvpn/event.h</span><br><span>+=
++ b/src/openvpn/event.h</span><br><span>@@ -204,7 +204,7 @@</span><br><spa=
n> #else /* ifdef _WIN32 */</span><br><span> </span><br><span> static inlin=
e void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-wait_signal(str=
uct event_set *es, void *arg)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+wait_signal(const struct event_set *es, const void *arg)</span><b=
r><span> {</span><br><span> }</span><br><span> </span><br><span>diff --git =
a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>index a4747=
ed..bc6adbb 100644</span><br><span>--- a/src/openvpn/forward.c</span><br><s=
pan>+++ b/src/openvpn/forward.c</span><br><span>@@ -231,7 +231,7 @@</span><=
br><span> }</span><br><span> </span><br><span> static void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-parse_incoming_control_channel_command=
(struct context *c, struct buffer *buf)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+parse_incoming_control_channel_command(struct context *=
c, const struct buffer *buf)</span><br><span> {</span><br><span>     if (bu=
f_string_match_head_str(buf, &quot;AUTH_FAILED&quot;))</span><br><span>    =
 {</span><br><span>@@ -501,7 +501,7 @@</span><br><span> }</span><br><span> =
</span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
get_server_poll_remaining_time(struct event_timeout *server_poll_timeout)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_server_poll_remai=
ning_time(const struct event_timeout *server_poll_timeout)</span><br><span>=
 {</span><br><span>     update_time();</span><br><span>     int remaining =
=3D event_timeout_remaining(server_poll_timeout);</span><br><span>@@ -598,7=
 +598,7 @@</span><br><span>  * Buffer reallocation, for use with null encry=
ption.</span><br><span>  */</span><br><span> static inline void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-buffer_turnover(const uint8_t *or=
ig_buf, struct buffer *dest_stub, struct buffer *src_stub,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+buffer_turnover(const uint8_t *orig_=
buf, struct buffer *dest_stub, const struct buffer *src_stub,</span><br><sp=
an>                 struct buffer *storage)</span><br><span> {</span><br><s=
pan>     if (orig_buf =3D=3D src_stub-&gt;data &amp;&amp; src_stub-&gt;data=
 !=3D storage-&gt;data)</span><br><span>@@ -885,7 +885,7 @@</span><br><span=
>  */</span><br><span> </span><br><span> static inline void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-socks_postprocess_incoming_link(struc=
t context *c, struct link_socket *sock)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+socks_postprocess_incoming_link(struct context *c, cons=
t struct link_socket *sock)</span><br><span> {</span><br><span>     if (soc=
k-&gt;socks_proxy &amp;&amp; sock-&gt;info.proto =3D=3D PROTO_UDP)</span><b=
r><span>     {</span><br><span>@@ -984,7 +984,7 @@</span><br><span> }</span=
><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-process_incoming_link_part1(struct context *c, struct link_soc=
ket_info *lsi, bool floated)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+process_incoming_link_part1(struct context *c, const struct link_s=
ocket_info *lsi, bool floated)</span><br><span> {</span><br><span>     stru=
ct gc_arena gc =3D gc_new();</span><br><span>     bool decrypt_status =3D f=
alse;</span><br><span>@@ -1534,7 +1534,7 @@</span><br><span>  * @param clie=
nt    Determines whether to the send packet back via tun or link</span><br>=
<span>  */</span><br><span> void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-ipv6_send_icmp_unreachable(struct context *c, struct buffer *buf=
, bool client)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ipv6_=
send_icmp_unreachable(struct context *c, const struct buffer *buf, bool cli=
ent)</span><br><span> {</span><br><span> #define MAX_ICMPV6LEN 1280</span><=
br><span>     struct openvpn_icmp6hdr icmp6out;</span><br><span>diff --git =
a/src/openvpn/forward.h b/src/openvpn/forward.h</span><br><span>index 0d3e4=
92..d8e07fa 100644</span><br><span>--- a/src/openvpn/forward.h</span><br><s=
pan>+++ b/src/openvpn/forward.h</span><br><span>@@ -112,7 +112,7 @@</span><=
br><span>  */</span><br><span> void encrypt_sign(struct context *c, bool co=
mp_frag);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-int get_server_poll_remaining_time(struct event_timeout *server_poll_=
timeout);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int get_se=
rver_poll_remaining_time(const struct event_timeout *server_poll_timeout);<=
/span><br><span> </span><br><span> /***************************************=
*******************************/</span><br><span> /**</span><br><span>@@ -1=
63,7 +163,7 @@</span><br><span>  *</span><br><span>  * @return true if pack=
et is authenticated, false otherwise.</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-bool process_incoming_link_part1(struc=
t context *c, struct link_socket_info *lsi, bool floated);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool process_incoming_link_part1(str=
uct context *c, const struct link_socket_info *lsi, bool floated);</span><b=
r><span> </span><br><span> /**</span><br><span>  * Continues processing a p=
acket read from the external network interface.</span><br><span>diff --git =
a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index af652ac..56=
f39d8 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b=
/src/openvpn/init.c</span><br><span>@@ -1269,7 +1269,7 @@</span><br><span> =
 * prepending to msg() output.</span><br><span>  */</span><br><span> const =
char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-format_common_n=
ame(struct context *c, struct gc_arena *gc)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+format_common_name(const struct context *c, struct =
gc_arena *gc)</span><br><span> {</span><br><span>     struct buffer out =3D=
 alloc_buf_gc(256, gc);</span><br><span>     if (c-&gt;c2.tls_multi)</span>=
<br><span>@@ -1755,7 +1755,7 @@</span><br><span> </span><br><span> </span><=
br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
can_preserve_tun(struct tuntap *tt)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+can_preserve_tun(const struct tuntap *tt)</span><br><span> =
{</span><br><span>     if (tt &amp;&amp; tt-&gt;backend_driver =3D=3D DRIVE=
R_AFUNIX)</span><br><span>     {</span><br><span>@@ -1777,7 +1777,7 @@</spa=
n><br><span>  * @param c pointer to the connection context</span><br><span>=
  */</span><br><span> static void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-add_wfp_block(struct context *c)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+add_wfp_block(const struct context *c)</span><br><=
span> {</span><br><span> #if defined(_WIN32)</span><br><span>     /* Fortif=
y &#39;redirect-gateway block-local&#39; with firewall rules? */</span><br>=
<span>@@ -1803,7 +1803,7 @@</span><br><span>  * @param adapter_index the VP=
N adapter index</span><br><span>  */</span><br><span> static void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-del_wfp_block(struct context *c=
, unsigned long adapter_index)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+del_wfp_block(const struct context *c, unsigned long adapter_ind=
ex)</span><br><span> {</span><br><span> #if defined(_WIN32)</span><br><span=
>     if (c-&gt;options.block_outside_dns || block_local_needed(c-&gt;c1.ro=
ute_list))</span><br><span>diff --git a/src/openvpn/init.h b/src/openvpn/in=
it.h</span><br><span>index 9d5050d..af4393c 100644</span><br><span>--- a/sr=
c/openvpn/init.h</span><br><span>+++ b/src/openvpn/init.h</span><br><span>@=
@ -91,7 +91,7 @@</span><br><span> </span><br><span> unsigned int pull_permi=
ssion_mask(const struct context *c);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-const char *format_common_name(struct cont=
ext *c, struct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+const char *format_common_name(const struct context *c, struct gc=
_arena *gc);</span><br><span> </span><br><span> void reset_coarse_timers(st=
ruct context *c);</span><br><span> </span><br><span>diff --git a/src/openvp=
n/interval.h b/src/openvpn/interval.h</span><br><span>index 59051bd..0cfe20=
2 100644</span><br><span>--- a/src/openvpn/interval.h</span><br><span>+++ b=
/src/openvpn/interval.h</span><br><span>@@ -89,7 +89,7 @@</span><br><span> =
}</span><br><span> </span><br><span> static inline void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-interval_schedule_wakeup(struct interval =
*top, interval_t *wakeup)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+interval_schedule_wakeup(const struct interval *top, interval_t *wake=
up)</span><br><span> {</span><br><span>     const time_t local_now =3D now;=
</span><br><span>     interval_earliest_wakeup(wakeup, top-&gt;last_test_tr=
ue + top-&gt;refresh, local_now);</span><br><span>@@ -214,7 +214,7 @@</span=
><br><span>  * This function does not check if the timeout is actually vali=
d.</span><br><span>  */</span><br><span> static inline interval_t</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-event_timeout_remaining(struct =
event_timeout *et)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+e=
vent_timeout_remaining(const struct event_timeout *et)</span><br><span> {</=
span><br><span>     return (interval_t)((et-&gt;last + et-&gt;n) - now);</s=
pan><br><span> }</span><br><span>diff --git a/src/openvpn/list.c b/src/open=
vpn/list.c</span><br><span>index 2e1cf05..c04ee4f 100644</span><br><span>--=
- a/src/openvpn/list.c</span><br><span>+++ b/src/openvpn/list.c</span><br><=
span>@@ -162,7 +162,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-hash_remove_b=
y_value(struct hash *hash, void *value)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+hash_remove_by_value(struct hash *hash, const void *val=
ue)</span><br><span> {</span><br><span>     struct hash_iterator hi;</span>=
<br><span>     const struct hash_element *he;</span><br><span>diff --git a/=
src/openvpn/list.h b/src/openvpn/list.h</span><br><span>index 04cc3ab..0896=
37d 100644</span><br><span>--- a/src/openvpn/list.h</span><br><span>+++ b/s=
rc/openvpn/list.h</span><br><span>@@ -73,7 +73,7 @@</span><br><span> </span=
><br><span> bool hash_remove_fast(struct hash *hash, struct hash_bucket *bu=
cket, const void *key, uint32_t hv);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-void hash_remove_by_value(struct hash *has=
h, void *value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d hash_remove_by_value(struct hash *hash, const void *value);</span><br><sp=
an> </span><br><span> struct hash_iterator</span><br><span> {</span><br><sp=
an>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span=
>index 604bbcd..3f1eabf 100644</span><br><span>--- a/src/openvpn/manage.c</=
span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -330,7 +330,7 =
@@</span><br><span> }</span><br><span> </span><br><span> static void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-man_delete_unix_socket(struc=
t management *man)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
an_delete_unix_socket(const struct management *man)</span><br><span> {</spa=
n><br><span> #if UNIX_SOCK_SUPPORT</span><br><span>     if ((man-&gt;settin=
gs.flags &amp; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)<=
/span><br><span>@@ -675,7 +675,7 @@</span><br><span>  * for the log and ech=
o commands.</span><br><span>  */</span><br><span> static void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-man_history(struct management *man,=
 const char *parm, const char *type, struct log_history *log,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+man_history(struct management *ma=
n, const char *parm, const char *type, const struct log_history *log,</span=
><br><span>             bool *realtime, const unsigned int lep_flags)</span=
><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><=
br><span>@@ -843,7 +843,7 @@</span><br><span> }</span><br><span> </span><br=
><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ma=
n_forget_passwords(struct management *man)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+man_forget_passwords(const struct management *man)</=
span><br><span> {</span><br><span>     ssl_purge_auth(false);</span><br><sp=
an>     (void)ssl_clean_auth_token();</span><br><span>@@ -851,7 +851,7 @@</=
span><br><span> }</span><br><span> </span><br><span> static void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-man_net(struct management *man)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_net(const struct=
 management *man)</span><br><span> {</span><br><span>     if (man-&gt;persi=
st.callback.show_net)</span><br><span>     {</span><br><span>@@ -887,7 +887=
,7 @@</span><br><span> #ifdef ENABLE_PKCS11</span><br><span> </span><br><sp=
an> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_pk=
cs11_id_count(struct management *man)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+man_pkcs11_id_count(const struct management *man)</span><=
br><span> {</span><br><span>     msg(M_CLIENT, &quot;&gt;PKCS11ID-COUNT:%d&=
quot;, pkcs11_management_id_count());</span><br><span> }</span><br><span>@@=
 -1350,7 +1350,7 @@</span><br><span>  * @return          Return whether p h=
as n (or at least n) parameters</span><br><span>  */</span><br><span> stati=
c bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_need(struct=
 management *man, const char **p, const int n, unsigned int flags)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+man_need(const struct manage=
ment *man, const char **p, const int n, unsigned int flags)</span><br><span=
> {</span><br><span>     int i;</span><br><span>     ASSERT(p[0]);</span><b=
r><span>@@ -3013,7 +3013,7 @@</span><br><span> }</span><br><span> </span><b=
r><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-manageme=
nt_up_down(struct management *man, const char *updown, const struct env_set=
 *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_up_=
down(const struct management *man, const char *updown, const struct env_set=
 *es)</span><br><span> {</span><br><span>     if (man-&gt;settings.flags &a=
mp; MF_UP_DOWN)</span><br><span>     {</span><br><span>@@ -3023,13 +3023,13=
 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-management_notify(struct managemen=
t *man, const char *severity, const char *type, const char *text)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+management_notify(const struc=
t management *man, const char *severity, const char *type, const char *text=
)</span><br><span> {</span><br><span>     msg(M_CLIENT, &quot;&gt;NOTIFY:%s=
,%s,%s&quot;, severity, type, text);</span><br><span> }</span><br><span> </=
span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-m=
anagement_notify_generic(struct management *man, const char *str)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+management_notify_generic(con=
st struct management *man, const char *str)</span><br><span> {</span><br><s=
pan>     msg(M_CLIENT, &quot;%s&quot;, str);</span><br><span> }</span><br><=
span>@@ -3115,7 +3115,8 @@</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_=
notify_client_close(struct management *management, struct man_def_auth_cont=
ext *mdac,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+managemen=
t_notify_client_close(const struct management *management,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                               struc=
t man_def_auth_context *mdac,</span><br><span>                             =
   const struct env_set *es)</span><br><span> {</span><br><span>     if ((m=
dac-&gt;flags &amp; DAF_INITIAL_AUTH) &amp;&amp; !(mdac-&gt;flags &amp; DAF=
_CONNECTION_CLOSED))</span><br><span>@@ -3206,7 +3207,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-management_auth_failure(struct management *man, const =
char *type, const char *reason)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+management_auth_failure(const struct management *man, const cha=
r *type, const char *reason)</span><br><span> {</span><br><span>     if (re=
ason)</span><br><span>     {</span><br><span>@@ -3219,7 +3220,7 @@</span><b=
r><span> }</span><br><span> </span><br><span> void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-management_auth_token(struct management *man, =
const char *token)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
anagement_auth_token(const struct management *man, const char *token)</span=
><br><span> {</span><br><span>     msg(M_CLIENT, &quot;&gt;PASSWORD:Auth-To=
ken:%s&quot;, token);</span><br><span> }</span><br><span>diff --git a/src/o=
penvpn/manage.h b/src/openvpn/manage.h</span><br><span>index 1be3549..ab689=
68 100644</span><br><span>--- a/src/openvpn/manage.h</span><br><span>+++ b/=
src/openvpn/manage.h</span><br><span>@@ -376,12 +376,12 @@</span><br><span>=
 </span><br><span> void management_event_loop_n_seconds(struct management *=
man, int sec);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void management_up_down(struct management *man, const char *updo=
wn, const struct env_set *es);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void management_up_down(const struct management *man, const char=
 *updown, const struct env_set *es);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-void management_notify(struct management *=
man, const char *severity, const char *type,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void management_notify(const struct management *ma=
n, const char *severity, const char *type,</span><br><span>                =
        const char *text);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void management_notify_generic(struct management *ma=
n, const char *str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void management_notify_generic(const struct management *man, const char *s=
tr);</span><br><span> </span><br><span> void management_notify_client_needi=
ng_auth(struct management *management,</span><br><span>                    =
                        const unsigned int auth_id,</span><br><span>@@ -391=
,7 +391,7 @@</span><br><span> void management_connection_established(struct=
 management *management,</span><br><span>                                  =
      struct man_def_auth_context *mdac, const struct env_set *es);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void manage=
ment_notify_client_close(struct management *management,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void management_notify_client_close(con=
st struct management *management,</span><br><span>                         =
            struct man_def_auth_context *mdac, const struct env_set *es);</=
span><br><span> </span><br><span> void management_learn_addr(struct managem=
ent *management, struct man_def_auth_context *mdac,</span><br><span>@@ -476=
,12 +476,12 @@</span><br><span>  * OpenVPN calls here to indicate a passwor=
d failure</span><br><span>  */</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-void management_auth_failure(struct management *=
man, const char *type, const char *reason);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void management_auth_failure(const struct managemen=
t *man, const char *type, const char *reason);</span><br><span> </span><br>=
<span> /*</span><br><span>  * Echo an authentication token to management in=
terface</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void management_auth_token(struct management *man, const char *token=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void management_a=
uth_token(const struct management *man, const char *token);</span><br><span=
> </span><br><span> /*</span><br><span>  * These functions drive the byteco=
unt in/out counters.</span><br><span>diff --git a/src/openvpn/mbuf.c b/src/=
openvpn/mbuf.c</span><br><span>index 5e1b585..39f85ba 100644</span><br><spa=
n>--- a/src/openvpn/mbuf.c</span><br><span>+++ b/src/openvpn/mbuf.c</span><=
br><span>@@ -160,7 +160,7 @@</span><br><span> }</span><br><span> </span><br=
><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbuf_dere=
ference_instance(struct mbuf_set *ms, struct multi_instance *mi)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+mbuf_dereference_instance(stru=
ct mbuf_set *ms, const struct multi_instance *mi)</span><br><span> {</span>=
<br><span>     if (ms)</span><br><span>     {</span><br><span>diff --git a/=
src/openvpn/mbuf.h b/src/openvpn/mbuf.h</span><br><span>index cfe698c..e368=
054 100644</span><br><span>--- a/src/openvpn/mbuf.h</span><br><span>+++ b/s=
rc/openvpn/mbuf.h</span><br><span>@@ -75,7 +75,7 @@</span><br><span> </span=
><br><span> bool mbuf_extract_item(struct mbuf_set *ms, struct mbuf_item *i=
tem);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-void mbuf_dereference_instance(struct mbuf_set *ms, struct multi_instance=
 *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void mbuf_der=
eference_instance(struct mbuf_set *ms, const struct multi_instance *mi);</s=
pan><br><span> </span><br><span> static inline bool</span><br><span> mbuf_d=
efined(const struct mbuf_set *ms)</span><br><span>diff --git a/src/openvpn/=
mss.c b/src/openvpn/mss.c</span><br><span>index 36bbb43..a7242a8 100644</sp=
an><br><span>--- a/src/openvpn/mss.c</span><br><span>+++ b/src/openvpn/mss.=
c</span><br><span>@@ -43,7 +43,7 @@</span><br><span>  *              if yes=
, hand to mss_fixup_dowork()</span><br><span>  */</span><br><span> void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-mss_fixup_ipv4(struct buf=
fer *buf, uint16_t maxmss)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+mss_fixup_ipv4(const struct buffer *buf, uint16_t maxmss)</span><br>=
<span> {</span><br><span>     const struct openvpn_iphdr *pip;</span><br><s=
pan>     int hlen;</span><br><span>@@ -80,7 +80,7 @@</span><br><span>  *   =
           (IPv6 header structure is sufficiently different from IPv4...)</=
span><br><span>  */</span><br><span> void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-mss_fixup_ipv6(struct buffer *buf, uint16_t maxmss)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+mss_fixup_ipv6(const st=
ruct buffer *buf, uint16_t maxmss)</span><br><span> {</span><br><span>     =
const struct openvpn_ipv6hdr *pip6;</span><br><span>     struct buffer newb=
uf;</span><br><span>@@ -136,7 +136,7 @@</span><br><span>  */</span><br><spa=
n> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+mss_fixup_dowork(const struct buffer =
*buf, uint16_t maxmss)</span><br><span> {</span><br><span>     int olen, op=
tlen;</span><br><span>     uint8_t *opt;</span><br><span>@@ -239,8 +239,8 @=
@</span><br><span> }</span><br><span> </span><br><span> static void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-frame_calculate_fragment(stru=
ct frame *frame, struct key_type *kt, const struct options *options,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                         str=
uct link_socket_info *lsi)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+frame_calculate_fragment(struct frame *frame, const struct key_type =
*kt, const struct options *options,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                         const struct link_socket_info *lsi=
)</span><br><span> {</span><br><span> #if defined(ENABLE_FRAGMENT)</span><b=
r><span>     size_t overhead;</span><br><span>@@ -269,8 +269,8 @@</span><br=
><span> }</span><br><span> </span><br><span> static void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-frame_calculate_mssfix(struct frame *fra=
me, struct key_type *kt, const struct options *options,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                       struct link_socket=
_info *lsi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+frame_ca=
lculate_mssfix(struct frame *frame, const struct key_type *kt, const struct=
 options *options,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                      const struct link_socket_info *lsi)</span><br><span> =
{</span><br><span>     if (options-&gt;ce.mssfix_fixed)</span><br><span>   =
  {</span><br><span>@@ -314,8 +314,8 @@</span><br><span> }</span><br><span>=
 </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-frame_calculate_dynamic(struct frame *frame, struct key_type *kt, const s=
truct options *options,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                        struct link_socket_info *lsi)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+frame_calculate_dynamic(struct frame *f=
rame, const struct key_type *kt, const struct options *options,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        const s=
truct link_socket_info *lsi)</span><br><span> {</span><br><span>     if (op=
tions-&gt;ce.fragment &gt; 0)</span><br><span>     {</span><br><span>diff -=
-git a/src/openvpn/mss.h b/src/openvpn/mss.h</span><br><span>index 1d092bb.=
.6b832a2 100644</span><br><span>--- a/src/openvpn/mss.h</span><br><span>+++=
 b/src/openvpn/mss.h</span><br><span>@@ -29,15 +29,15 @@</span><br><span> #=
include &quot;socket.h&quot;</span><br><span> #include &quot;ssl_common.h&q=
uot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void mss_fixup_ipv4(struct buffer *buf, uint16_t maxmss);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void mss_fixup_ipv4(const struct buf=
fer *buf, uint16_t maxmss);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-void mss_fixup_ipv6(struct buffer *buf, uint16_t ma=
xmss);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void mss_fixu=
p_ipv6(const struct buffer *buf, uint16_t maxmss);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-void mss_fixup_dowork(struct=
 buffer *buf, uint16_t maxmss);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void mss_fixup_dowork(const struct buffer *buf, uint16_t maxmss=
);</span><br><span> </span><br><span> /** Set the --mssfix option. */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-void frame_calculate_dynami=
c(struct frame *frame, struct key_type *kt,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                             const struct options *op=
tions, struct link_socket_info *lsi);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void frame_calculate_dynamic(struct frame *frame, const s=
truct key_type *kt,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                             const struct options *options, const struct li=
nk_socket_info *lsi);</span><br><span> </span><br><span> /**</span><br><spa=
n>  * Checks and adjusts the fragment and mssfix value according to the</sp=
an><br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br=
><span>index df94a70..d9f14b3 100644</span><br><span>--- a/src/openvpn/mtcp=
.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -91,7 +91,7 =
@@</span><br><span> }</span><br><span> </span><br><span> bool</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-multi_tcp_instance_specific_init(st=
ruct multi_context *m, struct multi_instance *mi)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+multi_tcp_instance_specific_init(const struct=
 multi_context *m, struct multi_instance *mi)</span><br><span> {</span><br>=
<span>     /* buffer for queued TCP socket output packets */</span><br><spa=
n>     mi-&gt;tcp_link_out_deferred =3D mbuf_init(m-&gt;top.options.n_bcast=
_buf);</span><br><span>diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h=
</span><br><span>index 9b7d1d2..bb117fa 100644</span><br><span>--- a/src/op=
envpn/mtcp.h</span><br><span>+++ b/src/openvpn/mtcp.h</span><br><span>@@ -3=
5,7 +35,7 @@</span><br><span> </span><br><span> void multi_tcp_dereference_=
instance(struct multi_io *multi_io, struct multi_instance *mi);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool multi_tcp_=
instance_specific_init(struct multi_context *m, struct multi_instance *mi);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool multi_tcp_inst=
ance_specific_init(const struct multi_context *m, struct multi_instance *mi=
);</span><br><span> </span><br><span> void multi_tcp_instance_specific_free=
(struct multi_instance *mi);</span><br><span> </span><br><span>diff --git a=
/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index 50d72d5..482=
8a17 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/=
src/openvpn/mudp.c</span><br><span>@@ -39,7 +39,7 @@</span><br><span> </spa=
n><br><span> static void</span><br><span> send_hmac_reset_packet(struct mul=
ti_context *m, struct tls_pre_decrypt_state *state,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                       struct tls_auth_stan=
dalone *tas, struct session_id *sid,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                       const struct tls_auth_standalone *t=
as, const struct session_id *sid,</span><br><span>                        b=
ool request_resend_wkc)</span><br><span> {</span><br><span>     reset_packe=
t_id_send(&amp;state-&gt;tls_wrap_tmp.opt.packet_id.send);</span><br><span>=
@@ -69,7 +69,7 @@</span><br><span> </span><br><span>     enum first_packet_=
verdict verdict;</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    struct tls_auth_standalone *tas =3D m-&gt;top.c2.tls_auth_=
standalone;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t struct tls_auth_standalone *tas =3D m-&gt;top.c2.tls_auth_standalone;</sp=
an><br><span> </span><br><span>     verdict =3D tls_pre_decrypt_lite(tas, s=
tate, &amp;m-&gt;top.c2.from, &amp;m-&gt;top.c2.buf);</span><br><span> </sp=
an><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><=
br><span>index 6c833c0..27b938a 100644</span><br><span>--- a/src/openvpn/mu=
lti.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -1315,7 =
+1315,7 @@</span><br><span>  * same common name.</span><br><span>  */</span=
><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-multi_delete_dup(struct multi_context *m, struct multi_instance *new_mi)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_delete_dup(str=
uct multi_context *m, const struct multi_instance *new_mi)</span><br><span>=
 {</span><br><span>     if (new_mi)</span><br><span>     {</span><br><span>=
@@ -2260,7 +2260,7 @@</span><br><span> }</span><br><span> </span><br><span>=
 static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_cli=
ent_setup_dco_initial(struct multi_context *m, struct multi_instance *mi,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_client_setup_dc=
o_initial(const struct multi_context *m, struct multi_instance *mi,</span><=
br><span>                                struct gc_arena *gc)</span><br><sp=
an> {</span><br><span>     if (!dco_enabled(&amp;mi-&gt;context.options))</=
span><br><span>@@ -3195,7 +3195,7 @@</span><br><span> </span><br><span> #if=
 defined(ENABLE_DCO)</span><br><span> static void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-process_incoming_del_peer(struct multi_context =
*m, struct multi_instance *mi, dco_context_t *dco)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+process_incoming_del_peer(struct multi_conte=
xt *m, struct multi_instance *mi, const dco_context_t *dco)</span><br><span=
> {</span><br><span>     const char *reason =3D &quot;ovpn-dco: unknown rea=
son&quot;;</span><br><span>     switch (dco-&gt;dco_del_peer_reason)</span>=
<br><span>@@ -4226,7 +4226,7 @@</span><br><span> </span><br><span> /* Searc=
hes for the address and deletes it if it is owned by the multi_instance */<=
/span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-multi_unlearn_addr(struct multi_context *m, struct multi_instance *m=
i, const struct mroute_addr *addr)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+multi_unlearn_addr(struct multi_context *m, const struct mul=
ti_instance *mi, const struct mroute_addr *addr)</span><br><span> {</span><=
br><span>     struct hash_element *he;</span><br><span>     const uint32_t =
hv =3D hash_value(m-&gt;vhash, addr);</span><br><span>@@ -4261,7 +4261,7 @@=
</span><br><span>  * @param a     The new IPv4 address in network byte orde=
r</span><br><span>  */</span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-multi_unlearn_in_addr_t(struct multi_contex=
t *m, struct multi_instance *mi, in_addr_t a)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+multi_unlearn_in_addr_t(struct multi_context *m, =
const struct multi_instance *mi, in_addr_t a)</span><br><span> {</span><br>=
<span>     struct mroute_addr addr;</span><br><span>     CLEAR(addr);</span=
><br><span>@@ -4279,7 +4279,7 @@</span><br><span>  * @param a6    The new I=
Pv6 address</span><br><span>  */</span><br><span> static void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-multi_unlearn_in6_addr(struct multi=
_context *m, struct multi_instance *mi, struct in6_addr a6)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+multi_unlearn_in6_addr(struct multi=
_context *m, const struct multi_instance *mi, struct in6_addr a6)</span><br=
><span> {</span><br><span>     struct mroute_addr addr;</span><br><span>   =
  CLEAR(addr);</span><br><span>@@ -4395,7 +4395,7 @@</span><br><span> </spa=
n><br><span> bool</span><br><span> multi_check_push_ifconfig_ipv6_extra_rou=
te(struct multi_instance *mi,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                                           struct in6_addr *dest)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                      const struct in6_addr *dest)</span><br><span> {</span=
><br><span>     struct options *o =3D &amp;mi-&gt;context.options;</span><b=
r><span> </span><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/mu=
lti.h</span><br><span>index 3ed08d4..cd7aa3e 100644</span><br><span>--- a/s=
rc/openvpn/multi.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><spa=
n>@@ -520,7 +520,7 @@</span><br><span>  */</span><br><span> </span><br><spa=
n> static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
set_prefix(struct multi_instance *mi)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+set_prefix(const struct multi_instance *mi)</span><br><sp=
an> {</span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span>     i=
f (mi-&gt;msg_prefix[0])</span><br><span>@@ -694,7 +694,7 @@</span><br><spa=
n>  */</span><br><span> bool</span><br><span> multi_check_push_ifconfig_ipv=
6_extra_route(struct multi_instance *mi,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                           struct in6_ad=
dr *dest);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                  const struct in6_addr *dest);</span><br><=
span> </span><br><span> /*</span><br><span>  * Check for signals.</span><br=
><span>diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h</sp=
an><br><span>index bce0c19..e52a76a 100644</span><br><span>--- a/src/openvp=
n/networking.h</span><br><span>+++ b/src/openvpn/networking.h</span><br><sp=
an>@@ -102,7 +102,7 @@</span><br><span>  * @return          0 on success, n=
egative error code on error</span><br><span>  */</span><br><span> int net_i=
face_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface, const ch=
ar *type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
      void *arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                const void *arg);</span><br><span> </span><br><span> /**</s=
pan><br><span>  * Retrieve the interface type</span><br><span>diff --git a/=
src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c</span=
><br><span>index a1f3525..404d759 100644</span><br><span>--- a/src/openvpn/=
networking_iproute2.c</span><br><span>+++ b/src/openvpn/networking_iproute2=
.c</span><br><span>@@ -61,7 +61,7 @@</span><br><span> }</span><br><span> </=
span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ne=
t_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, vo=
id *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_n=
ew(openvpn_net_ctx_t *ctx, const char *iface, const char *type, const void =
*arg)</span><br><span> {</span><br><span>     struct argv argv =3D argv_new=
();</span><br><span> </span><br><span>diff --git a/src/openvpn/networking_s=
itnl.c b/src/openvpn/networking_sitnl.c</span><br><span>index e6e72d0..a1d2=
20f 100644</span><br><span>--- a/src/openvpn/networking_sitnl.c</span><br><=
span>+++ b/src/openvpn/networking_sitnl.c</span><br><span>@@ -987,7 +987,7 =
@@</span><br><span> }</span><br><span> </span><br><span> static int</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-sitnl_addr_del(sa_family_t af=
_family, const char *iface, inet_address_t *addr, int prefixlen)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+sitnl_addr_del(sa_family_t af_=
family, const char *iface, const inet_address_t *addr, int prefixlen)</span=
><br><span> {</span><br><span>     int ifindex;</span><br><span> </span><br=
><span>@@ -1230,8 +1230,8 @@</span><br><span> }</span><br><span> </span><br=
><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sit=
nl_route_del(const char *iface, sa_family_t af_family, inet_address_t *dst,=
 int prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          inet_address_t *gw, uint32_t table, int metric)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+sitnl_route_del(const char *iface, sa=
_family_t af_family, const inet_address_t *dst, int prefixlen,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                const inet_addre=
ss_t *gw, uint32_t table, int metric)</span><br><span> {</span><br><span>  =
   int ifindex =3D 0;</span><br><span> </span><br><span>@@ -1308,7 +1308,7 =
@@</span><br><span> </span><br><span> </span><br><span> int</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-net_iface_new(openvpn_net_ctx_t *ctx,=
 const char *iface, const char *type, void *arg)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+net_iface_new(openvpn_net_ctx_t *ctx, const ch=
ar *iface, const char *type, const void *arg)</span><br><span> {</span><br>=
<span>     struct sitnl_link_req req =3D {};</span><br><span>     int ret =
=3D -1;</span><br><span>diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h<=
/span><br><span>index bda4f18..49def4d 100644</span><br><span>--- a/src/ope=
nvpn/occ.h</span><br><span>+++ b/src/openvpn/occ.h</span><br><span>@@ -156,=
7 +156,7 @@</span><br><span>  * via control channel.</span><br><span>  * @r=
eturn control channel exit message should be used */</span><br><span> stati=
c inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cc_exit_=
notify_enabled(struct context *c)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+cc_exit_notify_enabled(const struct context *c)</span><br><sp=
an> {</span><br><span>     /* Check if we have TLS active at all */</span><=
br><span>     if (!c-&gt;c2.tls_multi)</span><br><span>diff --git a/src/ope=
nvpn/openssl_compat.h b/src/openvpn/openssl_compat.h</span><br><span>index =
3494ce6..32e0b6f 100644</span><br><span>--- a/src/openvpn/openssl_compat.h<=
/span><br><span>+++ b/src/openvpn/openssl_compat.h</span><br><span>@@ -124,=
7 +124,7 @@</span><br><span> /* Mimics the functions but only when the defa=
ult context without</span><br><span>  * options is chosen */</span><br><spa=
n> static inline const EVP_CIPHER *</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-EVP_CIPHER_fetch(void *ctx, const char *algorithm, const char=
 *properties)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+EVP_CI=
PHER_fetch(const void *ctx, const char *algorithm, const char *properties)<=
/span><br><span> {</span><br><span>     ASSERT(!ctx);</span><br><span>     =
ASSERT(!properties);</span><br><span>@@ -132,7 +132,7 @@</span><br><span> }=
</span><br><span> </span><br><span> static inline const EVP_MD *</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-EVP_MD_fetch(void *ctx, const ch=
ar *algorithm, const char *properties)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+EVP_MD_fetch(const void *ctx, const char *algorithm, con=
st char *properties)</span><br><span> {</span><br><span>     ASSERT(!ctx);<=
/span><br><span>     ASSERT(!properties);</span><br><span>diff --git a/src/=
openvpn/options.c b/src/openvpn/options.c</span><br><span>index fd0d3fc..6d=
85a23 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>++=
+ b/src/openvpn/options.c</span><br><span>@@ -3050,7 +3050,7 @@</span><br><=
span> }</span><br><span> </span><br><span> static void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-options_postprocess_mutate_le(struct conne=
ction_entry *ce, struct local_entry *le, int mode)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+options_postprocess_mutate_le(const struct c=
onnection_entry *ce, struct local_entry *le, int mode)</span><br><span> {</=
span><br><span>     /* use the global port if none is specified */</span><b=
r><span>     if (!le-&gt;port)</span><br><span>@@ -4980,7 +4980,7 @@</span>=
<br><span> static bool</span><br><span> verify_permission(const char *name,=
 const char *file, int line, const uint64_t type,</span><br><span>         =
          const uint64_t allowed, uint64_t *found, const msglvl_t msglevel,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  str=
uct options *options, bool is_inline)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                  const struct options *options, bool is_=
inline)</span><br><span> {</span><br><span>     if (!(type &amp; allowed))<=
/span><br><span>     {</span><br><span>@@ -5547,7 +5547,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-show_compression_warning(struct compress_op=
tions *info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_co=
mpression_warning(const struct compress_options *info)</span><br><span> {</=
span><br><span>     if (comp_non_stub_enabled(info))</span><br><span>     {=
</span><br><span>diff --git a/src/openvpn/options_parse.c b/src/openvpn/opt=
ions_parse.c</span><br><span>index 88ab4d2..0e94522 100644</span><br><span>=
--- a/src/openvpn/options_parse.c</span><br><span>+++ b/src/openvpn/options=
_parse.c</span><br><span>@@ -258,7 +258,7 @@</span><br><span> }</span><br><=
span> </span><br><span> static char *</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-read_inline_file(struct in_src *is, const char *close_tag, =
int *num_lines, struct gc_arena *gc)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+read_inline_file(const struct in_src *is, const char *clos=
e_tag, int *num_lines, struct gc_arena *gc)</span><br><span> {</span><br><s=
pan>     char line[OPTION_LINE_SIZE];</span><br><span>     struct buffer bu=
f =3D alloc_buf(8 * OPTION_LINE_SIZE);</span><br><span>@@ -302,7 +302,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> static int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-check_inline_file(struct in_src =
*is, char *p[], struct gc_arena *gc)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+check_inline_file(const struct in_src *is, char *p[], stru=
ct gc_arena *gc)</span><br><span> {</span><br><span>     int num_inline_lin=
es =3D 0;</span><br><span> </span><br><span>diff --git a/src/openvpn/otime.=
c b/src/openvpn/otime.c</span><br><span>index 1608458..5d3633c 100644</span=
><br><span>--- a/src/openvpn/otime.c</span><br><span>+++ b/src/openvpn/otim=
e.c</span><br><span>@@ -66,7 +66,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
update_now_usec(struct timeval *tv)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+update_now_usec(const struct timeval *tv)</span><br><span> =
{</span><br><span>     const time_t last =3D now;</span><br><span>     upda=
te_now(tv-&gt;tv_sec);</span><br><span>diff --git a/src/openvpn/otime.h b/s=
rc/openvpn/otime.h</span><br><span>index 84e315b..b5a9f7c 100644</span><br>=
<span>--- a/src/openvpn/otime.h</span><br><span>+++ b/src/openvpn/otime.h</=
span><br><span>@@ -65,7 +65,7 @@</span><br><span> void update_now(const tim=
e_t system_time);</span><br><span> </span><br><span> extern time_t now_usec=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void update_now_usec=
(struct timeval *tv);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void update_now_usec(const struct timeval *tv);</span><br><span> </span><=
br><span> static inline int</span><br><span> openvpn_gettimeofday(struct ti=
meval *tv, void *tz)</span><br><span>diff --git a/src/openvpn/proto.h b/src=
/openvpn/proto.h</span><br><span>index 3570582..33bf4ea 100644</span><br><s=
pan>--- a/src/openvpn/proto.h</span><br><span>+++ b/src/openvpn/proto.h</sp=
an><br><span>@@ -248,7 +248,7 @@</span><br><span>  * and offset of IP heade=
r (via parameter).</span><br><span>  */</span><br><span> static inline int<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_tun_ip_ver(int tun=
nel_type, struct buffer *buf, int *ip_hdr_offset)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+get_tun_ip_ver(int tunnel_type, const struct =
buffer *buf, int *ip_hdr_offset)</span><br><span> {</span><br><span>     in=
t ip_ver =3D -1;</span><br><span> </span><br><span>diff --git a/src/openvpn=
/proxy.c b/src/openvpn/proxy.c</span><br><span>index 4de7615..59b5ad3 10064=
4</span><br><span>--- a/src/openvpn/proxy.c</span><br><span>+++ b/src/openv=
pn/proxy.c</span><br><span>@@ -597,8 +597,8 @@</span><br><span>            =
                   socket_descriptor_t sd, /* already open to proxy */</spa=
n><br><span>                               const char *host,       /* openv=
pn server remote */</span><br><span>                               const ch=
ar *port,       /* openvpn server port */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                              struct event_timeout *ser=
ver_poll_timeout, struct buffer *lookahead,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                              struct signal_info *sig=
_info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                 const struct event_timeout *server_poll_timeout,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
 struct buffer *lookahead, struct signal_info *sig_info)</span><br><span> {=
</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>    =
 char buf[512];</span><br><span>diff --git a/src/openvpn/proxy.h b/src/open=
vpn/proxy.h</span><br><span>index e662e7d..a2f4e47 100644</span><br><span>-=
-- a/src/openvpn/proxy.h</span><br><span>+++ b/src/openvpn/proxy.h</span><b=
r><span>@@ -89,7 +89,7 @@</span><br><span>                                 =
   socket_descriptor_t sd, /* already open to proxy */</span><br><span>    =
                                const char *host,       /* openvpn server r=
emote */</span><br><span>                                    const char *po=
rt,       /* openvpn server port */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                                   struct event_timeout *serv=
er_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                const struct event_timeout *server_poll_tim=
eout,</span><br><span>                                    struct buffer *lo=
okahead, struct signal_info *sig_info);</span><br><span> </span><br><span> =
uint8_t *make_base64_string2(const uint8_t *str, int str_len, struct gc_are=
na *gc);</span><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/push=
.c</span><br><span>index a030acd..373272f 100644</span><br><span>--- a/src/=
openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ =
-435,7 +435,7 @@</span><br><span> #endif</span><br><span> </span><br><span>=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-send_auth_pendin=
g_messages(struct tls_multi *tls_multi, struct tls_session *session,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+send_auth_pending_messages=
(const struct tls_multi *tls_multi, struct tls_session *session,</span><br>=
<span>                            const char *extra, unsigned int timeout)<=
/span><br><span> {</span><br><span>     struct key_state *ks =3D &amp;sessi=
on-&gt;key[KS_PRIMARY];</span><br><span>diff --git a/src/openvpn/push.h b/s=
rc/openvpn/push.h</span><br><span>index dff945f..39302f6 100644</span><br><=
span>--- a/src/openvpn/push.h</span><br><span>+++ b/src/openvpn/push.h</spa=
n><br><span>@@ -117,7 +117,7 @@</span><br><span>  * doc/management-notes.tx=
t under client-pending-auth for</span><br><span>  * more details on message=
 format</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-bool send_auth_pending_messages(struct tls_multi *tls_multi, struct =
tls_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bool send_auth_pending_messages(const struct tls_multi *tls_multi, struct=
 tls_session *session,</span><br><span>                                 con=
st char *extra, unsigned int timeout);</span><br><span> </span><br><span> v=
oid send_restart(struct context *c, const char *kill_msg);</span><br><span>=
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c</span><br><s=
pan>index af22af5..008d45f 100644</span><br><span>--- a/src/openvpn/push_ut=
il.c</span><br><span>+++ b/src/openvpn/push_util.c</span><br><span>@@ -222,=
7 +222,7 @@</span><br><span> </span><br><span> /* Return true if the client=
 supports push-update */</span><br><span> static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-support_push_update(struct multi_instance *=
mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+support_push_upd=
ate(const struct multi_instance *mi)</span><br><span> {</span><br><span>   =
  ASSERT(mi-&gt;context.c2.tls_multi);</span><br><span>     const unsigned =
int iv_proto_peer =3D extract_iv_proto(mi-&gt;context.c2.tls_multi-&gt;peer=
_info);</span><br><span>diff --git a/src/openvpn/reliable.c b/src/openvpn/r=
eliable.c</span><br><span>index 52adacf..3588483 100644</span><br><span>---=
 a/src/openvpn/reliable.c</span><br><span>+++ b/src/openvpn/reliable.c</spa=
n><br><span>@@ -92,7 +92,7 @@</span><br><span> </span><br><span> /* check i=
f a particular packet_id is present in ack */</span><br><span> static inlin=
e bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_ack_pa=
cket_id_present(struct reliable_ack *ack, packet_id_type pid)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+reliable_ack_packet_id_present(co=
nst struct reliable_ack *ack, packet_id_type pid)</span><br><span> {</span>=
<br><span>     for (int i =3D 0; i &lt; ack-&gt;len; ++i)</span><br><span> =
    {</span><br><span>@@ -733,7 +733,7 @@</span><br><span>  */</span><br><s=
pan> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-reliable_mark_active_incoming(struct reliable *rel, struct buffer *bu=
f, packet_id_type pid,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+reliable_mark_active_incoming(struct reliable *rel, const struct buffer =
*buf, packet_id_type pid,</span><br><span>                               in=
t opcode)</span><br><span> {</span><br><span>     for (int i =3D 0; i &lt; =
rel-&gt;size; ++i)</span><br><span>@@ -793,7 +793,7 @@</span><br><span> </s=
pan><br><span> /* delete a buffer previously activated by reliable_mark_act=
ive() */</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-reliable_mark_deleted(struct reliable *rel, struct buffer *buf)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_mark_deleted(=
struct reliable *rel, const struct buffer *buf)</span><br><span> {</span><b=
r><span>     for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>  =
   {</span><br><span>diff --git a/src/openvpn/reliable.h b/src/openvpn/reli=
able.h</span><br><span>index a5ed75c..8d9e2e3 100644</span><br><span>--- a/=
src/openvpn/reliable.h</span><br><span>+++ b/src/openvpn/reliable.h</span><=
br><span>@@ -173,7 +173,7 @@</span><br><span>  * @li False, if there are pa=
cket IDs to be acknowledged.</span><br><span>  */</span><br><span> static i=
nline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_ac=
k_empty(struct reliable_ack *ack)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+reliable_ack_empty(const struct reliable_ack *ack)</span><br>=
<span> {</span><br><span>     return !ack-&gt;len;</span><br><span> }</span=
><br><span>@@ -186,7 +186,7 @@</span><br><span>  * @returns the number of o=
utstanding acks</span><br><span>  */</span><br><span> static inline int</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-reliable_ack_outstanding(=
struct reliable_ack *ack)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+reliable_ack_outstanding(const struct reliable_ack *ack)</span><br><s=
pan> {</span><br><span>     return ack-&gt;len;</span><br><span> }</span><b=
r><span>@@ -336,7 +336,7 @@</span><br><span>  * @param pid The packet&#39;s=
 packet ID.</span><br><span>  * @param opcode The packet&#39;s opcode.</spa=
n><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void =
reliable_mark_active_incoming(struct reliable *rel, struct buffer *buf, pac=
ket_id_type pid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d reliable_mark_active_incoming(struct reliable *rel, const struct buffer *=
buf, packet_id_type pid,</span><br><span>                                  =
  int opcode);</span><br><span> </span><br><span> /**</span><br><span>@@ -3=
89,7 +389,7 @@</span><br><span>  * @param rel The reliable structure associ=
ated with the given buffer.</span><br><span>  * @param buf The buffer of th=
e reliable entry which is to be removed.</span><br><span>  */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-void reliable_mark_deleted(struct r=
eliable *rel, struct buffer *buf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void reliable_mark_deleted(struct reliable *rel, const struc=
t buffer *buf);</span><br><span> </span><br><span> /** @} name Functions fo=
r extracting incoming packets */</span><br><span> </span><br><span>diff --g=
it a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>index da48d8=
e..f1e84ed 100644</span><br><span>--- a/src/openvpn/route.c</span><br><span=
>+++ b/src/openvpn/route.c</span><br><span>@@ -3942,7 +3942,7 @@</span><br>=
<span> #else  /* if defined(_WIN32) */</span><br><span> </span><br><span> s=
tatic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_bypass_=
addresses(struct route_bypass *rb, const unsigned int flags) /* PLATFORM-SP=
ECIFIC */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_bypass=
_addresses(struct route_bypass *rb, const unsigned int flags)</span><br><sp=
an> {</span><br><span> }</span><br><span> </span><br><span>diff --git a/src=
/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 6cc0209..8dd=
5c27 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ =
b/src/openvpn/socket.c</span><br><span>@@ -1125,8 +1125,8 @@</span><br><spa=
n>  * such as TCP.</span><br><span>  */</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static void stream_buf_init(struct stre=
am_buf *sb, struct buffer *buf, const unsigned int sockflags,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                            const i=
nt proto);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id stream_buf_init(struct stream_buf *sb, const struct buffer *buf,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
 const unsigned int sockflags, const int proto);</span><br><span> </span><b=
r><span> static void stream_buf_close(struct stream_buf *sb);</span><br><sp=
an> </span><br><span>@@ -2075,7 +2075,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-stream_buf_init(struct stream_buf *sb, struct buffer *buf, cons=
t unsigned int sockflags,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+stream_buf_init(struct stream_buf *sb, const struct buffer *buf, cons=
t unsigned int sockflags,</span><br><span>                 const int proto)=
</span><br><span> {</span><br><span>     sb-&gt;buf_init =3D *buf;</span><b=
r><span>@@ -2464,7 +2464,7 @@</span><br><span> #if ENABLE_IP_PKTINFO</span>=
<br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-link_socket_write_udp_posix_sendmsg(struct link_socket *sock=
, struct buffer *buf,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+link_socket_write_udp_posix_sendmsg(struct link_socket *sock, const struc=
t buffer *buf,</span><br><span>                                     struct =
link_socket_actual *to)</span><br><span> {</span><br><span>     struct iove=
c iov;</span><br><span>diff --git a/src/openvpn/socket.h b/src/openvpn/sock=
et.h</span><br><span>index 6196af0..316e763 100644</span><br><span>--- a/sr=
c/openvpn/socket.h</span><br><span>+++ b/src/openvpn/socket.h</span><br><sp=
an>@@ -484,7 +484,7 @@</span><br><span> }</span><br><span> </span><br><span=
> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-l=
ink_socket_verify_incoming_addr(struct buffer *buf, const struct link_socke=
t_info *info,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_s=
ocket_verify_incoming_addr(const struct buffer *buf, const struct link_sock=
et_info *info,</span><br><span>                                  const stru=
ct link_socket_actual *from_addr)</span><br><span> {</span><br><span>     i=
f (buf-&gt;len &gt; 0)</span><br><span>@@ -694,12 +694,12 @@</span><br><spa=
n> </span><br><span> #else /* ifdef _WIN32 */</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-ssize_t link_socket_write_udp_pos=
ix_sendmsg(struct link_socket *sock, struct buffer *buf,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ssize_t link_socket_write_udp_posix_se=
ndmsg(struct link_socket *sock, const struct buffer *buf,</span><br><span> =
                                            struct link_socket_actual *to);=
</span><br><span> </span><br><span> </span><br><span> static inline ssize_t=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_write_udp=
_posix(struct link_socket *sock, struct buffer *buf,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+link_socket_write_udp_posix(struct link_s=
ocket *sock, const struct buffer *buf,</span><br><span>                    =
         struct link_socket_actual *to)</span><br><span> {</span><br><span>=
 #if ENABLE_IP_PKTINFO</span><br><span>@@ -715,7 +715,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> static inline ssize_t</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-link_socket_write_tcp_posix(struct li=
nk_socket *sock, struct buffer *buf)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+link_socket_write_tcp_posix(struct link_socket *sock, cons=
t struct buffer *buf)</span><br><span> {</span><br><span>     return send(s=
ock-&gt;sd, BPTR(buf), BLENZ(buf), MSG_NOSIGNAL);</span><br><span> }</span>=
<br><span>@@ -819,6 +819,8 @@</span><br><span>     }</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* cp=
pcheck-suppress constParameterPointer</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * sock is modified on Windows via &amp;sock-&gt;listen_h=
andle */</span><br><span> static inline void</span><br><span> socket_reset_=
listen_persistent(struct link_socket *sock)</span><br><span> {</span><br><s=
pan>diff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h</spa=
n><br><span>index 13f5962..add08ba 100644</span><br><span>--- a/src/openvpn=
/socket_util.h</span><br><span>+++ b/src/openvpn/socket_util.h</span><br><s=
pan>@@ -439,7 +439,7 @@</span><br><span> </span><br><span> </span><br><span=
> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-a=
ddrlist_match_proto(const struct openvpn_sockaddr *a1, struct addrinfo *add=
r_list, const int proto)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+addrlist_match_proto(const struct openvpn_sockaddr *a1, const struct a=
ddrinfo *addr_list, const int proto)</span><br><span> {</span><br><span>   =
  return link_socket_proto_connection_oriented(proto) ? addrlist_match(a1, =
addr_list)</span><br><span>                                                =
         : addrlist_port_match(a1, addr_list);</span><br><span>diff --git a=
/src/openvpn/socks.c b/src/openvpn/socks.c</span><br><span>index 19f3d54..7=
7ca863 100644</span><br><span>--- a/src/openvpn/socks.c</span><br><span>+++=
 b/src/openvpn/socks.c</span><br><span>@@ -82,7 +82,7 @@</span><br><span> <=
/span><br><span> static bool</span><br><span> socks_proxy_recv_char(uint8_t=
 *c, const char *name, socket_descriptor_t sd,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                      struct event_timeout *server=
_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                 const struct event_timeout *server_poll_timeout,</span><br=
><span>                       volatile int *signal_received)</span><br><spa=
n> {</span><br><span>     fd_set reads;</span><br><span>@@ -97,8 +97,8 @@</=
span><br><span> }</span><br><span> </span><br><span> static bool</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-socks_username_password_auth(str=
uct socks_proxy_info *p, socket_descriptor_t sd,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                             struct event_timeou=
t *server_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+socks_username_password_auth(const struct socks_proxy_info *p, socket_d=
escriptor_t sd,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                         const struct event_timeout *server_poll_timeout,</=
span><br><span>                              volatile int *signal_received)=
</span><br><span> {</span><br><span>     char to_send[516];</span><br><span=
>@@ -156,8 +156,8 @@</span><br><span> }</span><br><span> </span><br><span> =
static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socks_hand=
shake(struct socks_proxy_info *p, socket_descriptor_t sd,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                struct event_timeout *s=
erver_poll_timeout, volatile int *signal_received)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+socks_handshake(const struct socks_proxy_inf=
o *p, socket_descriptor_t sd,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                const struct event_timeout *server_poll_timeout, =
volatile int *signal_received)</span><br><span> {</span><br><span>     uint=
8_t buf[2];</span><br><span>     int len =3D 0;</span><br><span>@@ -231,7 +=
231,7 @@</span><br><span> </span><br><span> static bool</span><br><span> re=
cv_socks_reply(socket_descriptor_t sd, struct openvpn_sockaddr *addr,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                 struct eve=
nt_timeout *server_poll_timeout, volatile int *signal_received)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                 const struct e=
vent_timeout *server_poll_timeout, volatile int *signal_received)</span><br=
><span> {</span><br><span>     uint8_t atyp =3D 0;</span><br><span>     int=
 alen =3D 0;</span><br><span>@@ -334,11 +334,11 @@</span><br><span> }</span=
><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-establish_socks_proxy_passthru(struct socks_proxy_info *p,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+establish_socks_proxy_p=
assthru(const struct socks_proxy_info *p,</span><br><span>                 =
               socket_descriptor_t sd, /* already open to proxy */</span><b=
r><span>                                const char *host,       /* openvpn =
server remote */</span><br><span>                                const char=
 *servname,   /* openvpn server port */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                               struct event_timeout *serv=
er_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                            const struct event_timeout *server_poll_timeout=
,</span><br><span>                                struct signal_info *sig_i=
nfo)</span><br><span> {</span><br><span>     char buf[270];</span><br><span=
>@@ -392,10 +392,10 @@</span><br><span> }</span><br><span> </span><br><span=
> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-establish_socks=
_proxy_udpassoc(struct socks_proxy_info *p,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+establish_socks_proxy_udpassoc(const struct socks_p=
roxy_info *p,</span><br><span>                                socket_descri=
ptor_t ctrl_sd, /* already open to proxy */</span><br><span>               =
                 struct openvpn_sockaddr *relay_addr,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                               struct event=
_timeout *server_poll_timeout,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                               const struct event_timeout *serve=
r_poll_timeout,</span><br><span>                                struct sign=
al_info *sig_info)</span><br><span> {</span><br><span>     if (!socks_hands=
hake(p, ctrl_sd, server_poll_timeout, &amp;sig_info-&gt;signal_received))</=
span><br><span>diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h</span=
><br><span>index 846113d..f7c93b6 100644</span><br><span>--- a/src/openvpn/=
socks.h</span><br><span>+++ b/src/openvpn/socks.h</span><br><span>@@ -47,17=
 +47,17 @@</span><br><span> </span><br><span> void socks_proxy_close(struct=
 socks_proxy_info *sp);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-void establish_socks_proxy_passthru(struct socks_proxy_=
info *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void establ=
ish_socks_proxy_passthru(const struct socks_proxy_info *p,</span><br><span>=
                                     socket_descriptor_t sd, /* already ope=
n to proxy */</span><br><span>                                     const ch=
ar *host,       /* openvpn server remote */</span><br><span>               =
                      const char *servname,   /* openvpn server port */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
           struct event_timeout *server_poll_timeout,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                    const=
 struct event_timeout *server_poll_timeout,</span><br><span>               =
                      struct signal_info *sig_info);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-void establish_socks_proxy=
_udpassoc(struct socks_proxy_info *p,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void establish_socks_proxy_udpassoc(const struct socks_pr=
oxy_info *p,</span><br><span>                                     socket_de=
scriptor_t ctrl_sd, /* already open to proxy */</span><br><span>           =
                          struct openvpn_sockaddr *relay_addr,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
  struct event_timeout *server_poll_timeout,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                    const struct e=
vent_timeout *server_poll_timeout,</span><br><span>                        =
             struct signal_info *sig_info);</span><br><span> </span><br><sp=
an> void socks_process_incoming_udp(struct buffer *buf, struct link_socket_=
actual *from);</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn=
/ssl.c</span><br><span>index 7f3b4dc..262522b 100644</span><br><span>--- a/=
src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@=
@ -1159,7 +1159,7 @@</span><br><span> }</span><br><span> </span><br><span> =
struct tls_multi *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls=
_multi_init(struct tls_options *tls_options)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+tls_multi_init(const struct tls_options *tls_optio=
ns)</span><br><span> {</span><br><span>     struct tls_multi *ret;</span><b=
r><span> </span><br><span>@@ -1188,7 +1188,7 @@</span><br><span>  */</span>=
<br><span> </span><br><span> struct tls_auth_standalone *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-tls_auth_standalone_init(struct tls_opt=
ions *tls_options, struct gc_arena *gc)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+tls_auth_standalone_init(const struct tls_options *tls_=
options, struct gc_arena *gc)</span><br><span> {</span><br><span>     struc=
t tls_auth_standalone *tas;</span><br><span> </span><br><span>@@ -1336,7 +1=
336,7 @@</span><br><span> </span><br><span> static void</span><br><span> in=
it_epoch_keys(struct key_state *ks, struct tls_multi *multi, const struct k=
ey_type *key_type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             bool server, struct key2 *key2)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                bool server, const struct key2 *ke=
y2)</span><br><span> {</span><br><span>     /* For now we hardcode this to =
be 16 for the software based data channel</span><br><span>      * DCO based=
 implementations/HW implementation might adjust this number</span><br><span=
>@@ -1375,7 +1375,7 @@</span><br><span> </span><br><span> static void</span=
><br><span> init_key_contexts(struct key_state *ks, struct tls_multi *multi=
, const struct key_type *key_type,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                  bool server, struct key2 *key2, bool dco_ena=
bled)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
    bool server, const struct key2 *key2, bool dco_enabled)</span><br><span=
> {</span><br><span>     struct key_ctx_bi *key =3D &amp;ks-&gt;crypto_opti=
ons.key_ctx_bi;</span><br><span> </span><br><span>@@ -1573,8 +1573,9 @@</sp=
an><br><span> </span><br><span> bool</span><br><span> tls_session_update_cr=
ypto_params_do_work(struct tls_multi *multi, struct tls_session *session,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
                  struct options *options, struct frame *frame,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
        struct frame *frame_fragment, struct link_socket_info *lsi,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
              const struct options *options, struct frame *frame,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
            struct frame *frame_fragment,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                         const struct=
 link_socket_info *lsi,</span><br><span>                                   =
       dco_context_t *dco)</span><br><span> {</span><br><span>     if (sess=
ion-&gt;key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)</span><br><s=
pan>@@ -1643,7 +1644,7 @@</span><br><span> bool</span><br><span> tls_sessio=
n_update_crypto_params(struct tls_multi *multi, struct tls_session *session=
,</span><br><span>                                  struct options *options=
, struct frame *frame,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                 struct frame *frame_fragment, struct link=
_socket_info *lsi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                struct frame *frame_fragment, const struct =
link_socket_info *lsi,</span><br><span>                                  dc=
o_context_t *dco)</span><br><span> {</span><br><span>     if (!check_sessio=
n_cipher(session, options))</span><br><span>@@ -2495,8 +2496,8 @@</span><br=
><span> }</span><br><span> </span><br><span> bool</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-session_skip_to_pre_start(struct tls_session *s=
ession, struct tls_pre_decrypt_state *state,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                          struct link_socket_actual =
*from)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+session_skip_=
to_pre_start(struct tls_session *session, const struct tls_pre_decrypt_stat=
e *state,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                const struct link_socket_actual *from)</span><br><span> {</=
span><br><span>     struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMAR=
Y];</span><br><span>     ks-&gt;session_id_remote =3D state-&gt;peer_sessio=
n_id;</span><br><span>@@ -4011,7 +4012,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-tls_post_encrypt(struct tls_multi *multi, struct buffer *buf)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+tls_post_encrypt(struct tls=
_multi *multi, const struct buffer *buf)</span><br><span> {</span><br><span=
>     struct key_state *ks =3D multi-&gt;save_ks;</span><br><span>     mult=
i-&gt;save_ks =3D NULL;</span><br><span>@@ -4142,7 +4143,7 @@</span><br><sp=
an>  * into a garbage collectable string which is returned.</span><br><span=
>  */</span><br><span> const char *</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-protocol_dump(struct buffer *buffer, unsigned int flags, stru=
ct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pro=
tocol_dump(const struct buffer *buffer, unsigned int flags, struct gc_arena=
 *gc)</span><br><span> {</span><br><span>     struct buffer out =3D alloc_b=
uf_gc(256, gc);</span><br><span>     struct buffer buf =3D *buffer;</span><=
br><span>diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h</span><br><span=
>index 5822336..3370321 100644</span><br><span>--- a/src/openvpn/ssl.h</spa=
n><br><span>+++ b/src/openvpn/ssl.h</span><br><span>@@ -166,7 +166,7 @@</sp=
an><br><span>  *</span><br><span>  * @return A newly allocated and initiali=
zed \c tls_multi structure.</span><br><span>  */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-struct tls_multi *tls_multi_init(struct tls_opti=
ons *tls_options);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
truct tls_multi *tls_multi_init(const struct tls_options *tls_options);</sp=
an><br><span> </span><br><span> /**</span><br><span>  * Finalize initializa=
tion of a \c tls_multi structure.</span><br><span>@@ -187,7 +187,7 @@</span=
><br><span> /*</span><br><span>  * Initialize a standalone tls-auth verific=
ation object.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-struct tls_auth_standalone *tls_auth_standalone_init(struct tl=
s_options *tls_options,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+struct tls_auth_standalone *tls_auth_standalone_init(const struct tls_o=
ptions *tls_options,</span><br><span>                                      =
                struct gc_arena *gc);</span><br><span> </span><br><span> /*=
*</span><br><span>@@ -371,7 +371,7 @@</span><br><span>  * @param multi - Th=
e TLS state for this packet&#39;s destination VPN tunnel.</span><br><span> =
 * @param buf - The buffer containing the outgoing packet.</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void tls_post_enc=
rypt(struct tls_multi *multi, struct buffer *buf);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void tls_post_encrypt(struct tls_multi *mult=
i, const struct buffer *buf);</span><br><span> </span><br><span> /** @} nam=
e Functions for managing security parameter state for data channel packets =
*/</span><br><span> </span><br><span>@@ -461,7 +461,8 @@</span><br><span>  =
*/</span><br><span> bool tls_session_update_crypto_params(struct tls_multi =
*multi, struct tls_session *session,</span><br><span>                      =
                 struct options *options, struct frame *frame,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                                  =
    struct frame *frame_fragment, struct link_socket_info *lsi,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
       struct frame *frame_fragment,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                      const struct link_so=
cket_info *lsi,</span><br><span>                                       dco_=
context_t *dco);</span><br><span> </span><br><span> /*</span><br><span>@@ -=
525,7 +526,7 @@</span><br><span> #define PD_VERBOSE                 (1 &lt;=
&lt; 10)</span><br><span> #define PD_TLS_CRYPT               (1 &lt;&lt; 11=
)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-co=
nst char *protocol_dump(struct buffer *buffer, unsigned int flags, struct g=
c_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const =
char *protocol_dump(const struct buffer *buffer, unsigned int flags, struct=
 gc_arena *gc);</span><br><span> </span><br><span> /*</span><br><span>  * d=
ebugging code</span><br><span>@@ -573,7 +574,7 @@</span><br><span> /* Speci=
al method to skip the three way handshake RESET stages. This is</span><br><=
span>  * used by the HMAC code when seeing a packet that matches the previo=
us</span><br><span>  * HMAC based stateless server state */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-bool session_skip_to_pre_start(struct=
 tls_session *session, struct tls_pre_decrypt_state *state,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                               struct=
 link_socket_actual *from);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool session_skip_to_pre_start(struct tls_session *session, const s=
truct tls_pre_decrypt_state *state,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                               const struct link_socket_act=
ual *from);</span><br><span> </span><br><span> #endif /* ifndef OPENVPN_SSL=
_H */</span><br><span>diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/=
ssl_backend.h</span><br><span>index 816fb9c..ed395e7 100644</span><br><span=
>--- a/src/openvpn/ssl_backend.h</span><br><span>+++ b/src/openvpn/ssl_back=
end.h</span><br><span>@@ -144,7 +144,7 @@</span><br><span>  *</span><br><sp=
an>  * @return      true if the context is initialised, false if not.</span=
><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool t=
ls_ctx_initialised(struct tls_root_ctx *ctx);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool tls_ctx_initialised(const struct tls_root_ct=
x *ctx);</span><br><span> </span><br><span> /**</span><br><span>  * Set any=
 library specific options.</span><br><span>@@ -177,7 +177,7 @@</span><br><s=
pan>  * @param ciphers       String containing : delimited cipher names, or=
 NULL to use</span><br><span>  *                                      sane =
defaults.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, cons=
t char *ciphers);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, const cha=
r *ciphers);</span><br><span> </span><br><span> /**</span><br><span>  * Set=
 the TLS certificate profile.  The profile defines which crypto</span><br><=
span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</sp=
an><br><span>index 8a0f7d2..f771378 100644</span><br><span>--- a/src/openvp=
n/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><=
span>@@ -161,7 +161,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_initi=
alised(struct tls_root_ctx *ctx)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+tls_ctx_initialised(const struct tls_root_ctx *ctx)</span><br>=
<span> {</span><br><span>     /* either this should be NULL or should be no=
n-null and then have a</span><br><span>      * valid TLS ctx inside as well=
 */</span><br><span>@@ -284,7 +284,7 @@</span><br><span> }</span><br><span>=
 </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx *ctx, const char *ciph=
ers)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_ctx_restric=
t_ciphers_tls13(const struct tls_root_ctx *ctx, const char *ciphers)</span>=
<br><span> {</span><br><span>     if (ciphers =3D=3D NULL)</span><br><span>=
     {</span><br><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn=
/ssl_openssl.c</span><br><span>index 83f9db6..b1b808f 100644</span><br><spa=
n>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_ope=
nssl.c</span><br><span>@@ -147,7 +147,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-tls_ctx_initialised(struct tls_root_ctx *ctx)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+tls_ctx_initialised(const struct tls_root_ct=
x *ctx)</span><br><span> {</span><br><span>     /* either this should be NU=
LL or should be non-null and then have a</span><br><span>      * valid TLS =
ctx inside as well */</span><br><span>@@ -509,7 +509,7 @@</span><br><span> =
#endif</span><br><span> </span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-tls_ctx_restrict_ciphers_tls13(struct tls_root_ctx=
 *ctx, const char *ciphers)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+tls_ctx_restrict_ciphers_tls13(const struct tls_root_ctx *ctx, cons=
t char *ciphers)</span><br><span> {</span><br><span>     if (ciphers =3D=3D=
 NULL)</span><br><span>     {</span><br><span>@@ -1165,7 +1165,7 @@</span><=
br><span> }</span><br><span> </span><br><span> static void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_load_cert_uri(struct tls_root_=
ctx *tls_ctx, const char *uri)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+tls_ctx_load_cert_uri(const struct tls_root_ctx *tls_ctx, const =
char *uri)</span><br><span> {</span><br><span> #if defined(HAVE_OPENSSL_STO=
RE_API)</span><br><span>     X509 *x =3D NULL;</span><br><span>diff --git a=
/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c</span><br><span>index 180599=
5..6b53e7e 100644</span><br><span>--- a/src/openvpn/ssl_pkt.c</span><br><sp=
an>+++ b/src/openvpn/ssl_pkt.c</span><br><span>@@ -57,7 +57,7 @@</span><br>=
<span>  *  @return         if the swap was successful (buf was large enough=
)</span><br><span>  */</span><br><span> static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-swap_hmac(struct buffer *buf, const struct =
crypto_options *co, bool incoming)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+swap_hmac(const struct buffer *buf, const struct crypto_opti=
ons *co, bool incoming)</span><br><span> {</span><br><span>     ASSERT(co);=
</span><br><span> </span><br><span>@@ -117,7 +117,7 @@</span><br><span>  */=
</span><br><span> static void</span><br><span> tls_wrap_control(struct tls_=
wrap_ctx *ctx, uint8_t header, struct buffer *buf,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                 struct session_id *session_id=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 c=
onst struct session_id *session_id)</span><br><span> {</span><br><span>    =
 if (ctx-&gt;mode =3D=3D TLS_WRAP_AUTH || ctx-&gt;mode =3D=3D TLS_WRAP_NONE=
)</span><br><span>     {</span><br><span>@@ -403,9 +403,9 @@</span><br><spa=
n> </span><br><span> </span><br><span> struct buffer</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-tls_reset_standalone(struct tls_wrap_ctx *c=
tx, struct tls_auth_standalone *tas,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                     struct session_id *own_sid, struct sess=
ion_id *remote_sid, uint8_t header,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                     bool request_resend_wkc)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+tls_reset_standalone(struct tls_wra=
p_ctx *ctx, const struct tls_auth_standalone *tas,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                     const struct session_id=
 *own_sid, const struct session_id *remote_sid,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                     uint8_t header, bool reque=
st_resend_wkc)</span><br><span> {</span><br><span>     /* Copy buffer here =
to point at the same data but allow tls_wrap_control</span><br><span>      =
* to potentially change buf to point to another buffer without</span><br><s=
pan>diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h</span><br><s=
pan>index ac9d4be..ffd34f4 100644</span><br><span>--- a/src/openvpn/ssl_pkt=
.h</span><br><span>+++ b/src/openvpn/ssl_pkt.h</span><br><span>@@ -220,8 +2=
20,9 @@</span><br><span>  * from the tls pre decrypt state.</span><br><span=
>  *</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-struct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, struct tls=
_auth_standalone *tas,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                   struct session_id *own_sid, struct sess=
ion_id *remote_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
struct buffer tls_reset_standalone(struct tls_wrap_ctx *ctx, const struct t=
ls_auth_standalone *tas,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                   const struct session_id *own_sid,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
              const struct session_id *remote_sid,</span><br><span>        =
                            uint8_t header, bool request_resend_wkc);</span=
><br><span> </span><br><span> </span><br><span>diff --git a/src/openvpn/ssl=
_verify.c b/src/openvpn/ssl_verify.c</span><br><span>index e5b55a1..0298106=
 100644</span><br><span>--- a/src/openvpn/ssl_verify.c</span><br><span>+++ =
b/src/openvpn/ssl_verify.c</span><br><span>@@ -1137,7 +1137,7 @@</span><br>=
<span>  * cache.</span><br><span>  */</span><br><span> static bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-tls_authentication_status_use_=
cache(struct tls_multi *multi)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+tls_authentication_status_use_cache(const struct tls_multi *mult=
i)</span><br><span> {</span><br><span>     unsigned int idx =3D min_uint(mu=
lti-&gt;tas_cache_num_updates, SIZE(cache_intervals) - 1);</span><br><span>=
     time_t latency =3D cache_intervals[idx];</span><br><span>@@ -1281,7 +1=
281,7 @@</span><br><span>  * Check if the script/plugin left a message in t=
he auth failed message</span><br><span>  * file and relay it to the user */=
</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-check_for_client_reason(struct tls_multi *multi, struct auth_deferr=
ed_status *status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
heck_for_client_reason(struct tls_multi *multi, const struct auth_deferred_=
status *status)</span><br><span> {</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span>     const char *msg =3D key_state_check_auth=
_failed_message_file(status, &amp;gc);</span><br><span>@@ -1550,7 +1550,7 @=
@</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </=
span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-set_verify_user_pass_env(struct user_pass *up, struct tls_multi *mult=
i, struct tls_session *session)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+set_verify_user_pass_env(const struct user_pass *up, struct tls=
_multi *multi, struct tls_session *session)</span><br><span> {</span><br><s=
pan>     /* Is username defined? */</span><br><span>     if ((session-&gt;o=
pt-&gt;ssl_flags &amp; SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up-&gt;usern=
ame))</span><br><span>@@ -1578,7 +1578,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-ssl_verify_username_length(struct tls_session *session, const char *u=
sername)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_verify_=
username_length(const struct tls_session *session, const char *username)</s=
pan><br><span> {</span><br><span>     if ((session-&gt;opt-&gt;ssl_flags &a=
mp; SSLF_USERNAME_AS_COMMON_NAME)</span><br><span>         &amp;&amp; strle=
n(username) &gt; TLS_USERNAME_LEN)</span><br><span>diff --git a/src/openvpn=
/ssl_verify.h b/src/openvpn/ssl_verify.h</span><br><span>index 3176d76..e77=
bc4a 100644</span><br><span>--- a/src/openvpn/ssl_verify.h</span><br><span>=
+++ b/src/openvpn/ssl_verify.h</span><br><span>@@ -202,7 +202,7 @@</span><b=
r><span>  * @return              true if name is under limit or username-as=
-common-name</span><br><span>  *                      is not active</span><=
br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool ssl=
_verify_username_length(struct tls_session *session, const char *username);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ssl_verify_use=
rname_length(const struct tls_session *session, const char *username);</spa=
n><br><span> </span><br><span> /**</span><br><span>  * Runs the --client-cr=
response script if one is defined.</span><br><span>@@ -275,7 +275,7 @@</spa=
n><br><span> void auth_set_client_reason(struct tls_multi *multi, const cha=
r *client_reason);</span><br><span> </span><br><span> static inline const c=
har *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_client_reaso=
n(struct tls_multi *multi)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+tls_client_reason(const struct tls_multi *multi)</span><br><span> {<=
/span><br><span>     return multi-&gt;client_reason;</span><br><span> }</sp=
an><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><=
span>index f46802f..d32bf10 100644</span><br><span>--- a/src/openvpn/tun.c<=
/span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -1808,7 +1808,7 =
@@</span><br><span> </span><br><span> #if defined(TARGET_LINUX) || defined(=
TARGET_FREEBSD)</span><br><span> static bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-tun_dco_enabled(struct tuntap *tt)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+tun_dco_enabled(const struct tuntap *=
tt)</span><br><span> {</span><br><span>     return tt-&gt;backend_driver =
=3D=3D DRIVER_DCO;</span><br><span> }</span><br><span>diff --git a/src/open=
vpn/tun.h b/src/openvpn/tun.h</span><br><span>index 6a7af85..910f3d3 100644=
</span><br><span>--- a/src/openvpn/tun.h</span><br><span>+++ b/src/openvpn/=
tun.h</span><br><span>@@ -351,7 +351,7 @@</span><br><span> #define IFCONFIG=
_DEFAULT IFCONFIG_AFTER_TUN_OPEN</span><br><span> </span><br><span> static =
inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ifconfig_or=
der(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ifconfig_order(const struct tuntap *tt)</span><br><span> {</span><br><sp=
an>     if (tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span>   =
  {</span><br><span>@@ -381,7 +381,7 @@</span><br><span> #define ROUTE_ORDE=
R_DEFAULT ROUTE_AFTER_TUN</span><br><span> </span><br><span> static inline =
int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-route_order(struct=
 tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+route_o=
rder(const struct tuntap *tt)</span><br><span> {</span><br><span>     if (t=
t-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span>     {</span><br=
><span>@@ -555,25 +555,25 @@</span><br><span> }</span><br><span> </span><br=
><span> static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-tun_standby_init(struct tuntap *tt)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+tun_standby_init(const struct tuntap *tt)</span><br><s=
pan> {</span><br><span> }</span><br><span> </span><br><span> static inline =
bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_standby(struc=
t tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_st=
andby(const struct tuntap *tt)</span><br><span> {</span><br><span>     retu=
rn true;</span><br><span> }</span><br><span> </span><br><span> </span><br><=
span> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-tuntap_is_dco_win(struct tuntap *tt)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+tuntap_is_dco_win(const struct tuntap *tt)</span><br><s=
pan> {</span><br><span>     return false;</span><br><span> }</span><br><spa=
n> </span><br><span> static inline bool</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-tuntap_is_dco_win_timeout(struct tuntap *tt, int status)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_ti=
meout(const struct tuntap *tt, int status)</span><br><span> {</span><br><sp=
an>     return false;</span><br><span> }</span><br><span>diff --git a/src/o=
penvpn/tun_afunix.c b/src/openvpn/tun_afunix.c</span><br><span>index a67a47=
2..e9223bc 100644</span><br><span>--- a/src/openvpn/tun_afunix.c</span><br>=
<span>+++ b/src/openvpn/tun_afunix.c</span><br><span>@@ -48,7 +48,7 @@</spa=
n><br><span> </span><br><span> </span><br><span> static void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-tun_afunix_exec_child(const char *de=
v_node, struct tuntap *tt, struct env_set *env)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+tun_afunix_exec_child(const char *dev_node, str=
uct tuntap *tt, const struct env_set *env)</span><br><span> {</span><br><sp=
an>     const char *msgprefix =3D &quot;ERROR: failure executing process fo=
r tun:&quot;;</span><br><span>     struct argv argv =3D argv_new();</span><=
br><span>@@ -73,7 +73,7 @@</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-open_tun_af=
unix(struct options *o, int mtu, struct tuntap *tt, struct env_set *orig_en=
v)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+open_tun_afunix(c=
onst struct options *o, int mtu, struct tuntap *tt, const struct env_set *o=
rig_env)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_=
new();</span><br><span> </span><br><span>diff --git a/src/openvpn/tun_afuni=
x.h b/src/openvpn/tun_afunix.h</span><br><span>index 5b6a8e0..fb88eb2 10064=
4</span><br><span>--- a/src/openvpn/tun_afunix.h</span><br><span>+++ b/src/=
openvpn/tun_afunix.h</span><br><span>@@ -31,7 +31,7 @@</span><br><span>  * =
the user provided taking care of implementing the actual tun</span><br><spa=
n>  * device.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void open_tun_afunix(struct options *o, int mtu, struct tuntap=
 *tt, struct env_set *env);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void open_tun_afunix(const struct options *o, int mtu, struct tunta=
p *tt, const struct env_set *env);</span><br><span> </span><br><span> </spa=
n><br><span> /**</span><br><span>diff --git a/src/openvpn/vlan.c b/src/open=
vpn/vlan.c</span><br><span>index bffc60e..cd32a9b 100644</span><br><span>--=
- a/src/openvpn/vlan.c</span><br><span>+++ b/src/openvpn/vlan.c</span><br><=
span>@@ -288,7 +288,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-vlan_process_=
outgoing_tun(struct multi_context *m, struct multi_instance *mi)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+vlan_process_outgoing_tun(cons=
t struct multi_context *m, struct multi_instance *mi)</span><br><span> {</s=
pan><br><span>     if (!m-&gt;top.options.vlan_tagging)</span><br><span>   =
  {</span><br><span>diff --git a/src/openvpn/vlan.h b/src/openvpn/vlan.h</s=
pan><br><span>index 9389f89..cd2f66f 100644</span><br><span>--- a/src/openv=
pn/vlan.h</span><br><span>+++ b/src/openvpn/vlan.h</span><br><span>@@ -35,6=
 +35,6 @@</span><br><span> </span><br><span> bool vlan_is_tagged(const stru=
ct buffer *buf);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void vlan_process_outgoing_tun(struct multi_context *m, struct=
 multi_instance *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void vlan_process_outgoing_tun(const struct multi_context *m, struct mult=
i_instance *mi);</span><br><span> </span><br><span> #endif /* VLAN_H */</sp=
an><br><span>diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsic=
a/openvpnmsica.c</span><br><span>index 6a71801..593536b 100644</span><br><s=
pan>--- a/src/openvpnmsica/openvpnmsica.c</span><br><span>+++ b/src/openvpn=
msica/openvpnmsica.c</span><br><span>@@ -77,7 +77,7 @@</span><br><span>  * =
@return ERROR_SUCCESS on success; An error code otherwise</span><br><span> =
 */</span><br><span> static UINT</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szPropert=
y, _In_ struct msica_arg_seq *seq)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWSTR szPro=
perty, _In_ const struct msica_arg_seq *seq)</span><br><span> {</span><br><=
span>     UINT uiResult;</span><br><span>     LPWSTR szSequence =3D msica_a=
rg_seq_join(seq);</span><br><span>diff --git a/src/openvpnserv/interactive.=
c b/src/openvpnserv/interactive.c</span><br><span>index ace25b9..1ac7027 10=
0644</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><span>++=
+ b/src/openvpnserv/interactive.c</span><br><span>@@ -521,7 +521,7 @@</span=
><br><span> </span><br><span> </span><br><span> static SOCKADDR_INET</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-sockaddr_inet(short family, =
inet_address_t *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+sockaddr_inet(short family, const inet_address_t *addr)</span><br><span> =
{</span><br><span>     SOCKADDR_INET sa_inet;</span><br><span>     ZeroMemo=
ry(&amp;sa_inet, sizeof(sa_inet));</span><br><span>@@ -3722,7 +3722,7 @@</s=
pan><br><span> </span><br><span> static DWORD</span><br><span> UpdateWaitHa=
ndles(LPHANDLE *handles_ptr, LPDWORD count, HANDLE io_event, HANDLE exit_ev=
ent,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
 list_item_t *threads)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                  const list_item_t *threads)</span><br><span> {</span><=
br><span>     static DWORD size =3D 10;</span><br><span>     static LPHANDL=
E handles =3D NULL;</span><br><span>diff --git a/tests/t_client.sh.in b/tes=
ts/t_client.sh.in</span><br><span>index a49de40..48e2446 100755</span><br><=
span>--- a/tests/t_client.sh.in</span><br><span>+++ b/tests/t_client.sh.in<=
/span><br><span>@@ -62,11 +62,6 @@</span><br><span>     exit 1</span><br><s=
pan> fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-if [ -z &quot;$CA_CERT&quot; ] ; then</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    echo &quot;CA_CERT not defined in &#39;t_client.rc&=
#39;. SKIP test.&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    exit &quot;${TCLIENT_SKIP_RC}&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> if [ -z &quot;$TEST_RUN_LIST&quot; ] ; then<=
/span><br><span>     echo &quot;TEST_RUN_LIST empty, no tests defined.  SKI=
P test.&quot; &gt;&amp;2</span><br><span>     exit &quot;${TCLIENT_SKIP_RC}=
&quot;</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_managemen=
t.c b/tests/unit_tests/openvpn/mock_management.c</span><br><span>index 77f6=
ce2..fff4c2b 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_man=
agement.c</span><br><span>+++ b/tests/unit_tests/openvpn/mock_management.c<=
/span><br><span>@@ -36,7 +36,7 @@</span><br><span> struct management *manag=
ement; /* GLOBAL */</span><br><span> </span><br><span> void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-management_auth_failure(struct manage=
ment *man, const char *type, const char *reason)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+management_auth_failure(const struct managemen=
t *man, const char *type, const char *reason)</span><br><span> {</span><br>=
<span>     ASSERT(false);</span><br><span> }</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c<=
/span><br><span>index 4a055e7..af96764 100644</span><br><span>--- a/tests/u=
nit_tests/openvpn/test_misc.c</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_misc.c</span><br><span>@@ -146,7 +146,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> static struct hash_element *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-hash_lookup_by_value(struct hash *hash,=
 void *value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_l=
ookup_by_value(struct hash *hash, const void *value)</span><br><span> {</sp=
an><br><span>     struct hash_iterator hi;</span><br><span>     struct hash=
_element *he;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_us=
er_pass.c b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>index=
 c0a0866..7636a33 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_user_pass.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_user_pass=
.c</span><br><span>@@ -59,7 +59,7 @@</span><br><span>     return mock();</s=
pan><br><span> }</span><br><span> void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-management_auth_failure(struct management *man, const char=
 *type, const char *reason)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+management_auth_failure(const struct management *man, const char *t=
ype, const char *reason)</span><br><span> {</span><br><span>     assert_tru=
e(0);</span><br><span> }</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1663?usp=3Demail">change =
1663</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1663?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1=
e5daf2b116f58 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1663 </div>
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

--GF3ptzrJatE=--

