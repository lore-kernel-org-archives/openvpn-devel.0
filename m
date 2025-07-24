From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 24 Jul 2025 13:45:08 +0000
References: <gerrit.1753364704000.Id492cb774c6d022d06bb3cf5fec2a4bdd410e619@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f883610cf290af47c2e314b783d5ff72e0159694-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aBD+N6doVhQ="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Clean up the big
 msglevel type confusion
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

--aBD+N6doVhQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1110?usp=3Demail

to review the following change.


Change subject: Clean up the big msglevel type confusion
......................................................................

Clean up the big msglevel type confusion

msglevel was definitely unsigned as the first
argument to msg(), but many parts of the code
had it as signed. So this produced a LOT of
warnings when enabling -Wsign-conversion.

There is one exception in struct status_output
where -1 is a valid value in the API. Only
positive values are translated into standard
message levels.

Change-Id: Id492cb774c6d022d06bb3cf5fec2a4bdd410e619
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/argv.c
M src/openvpn/argv.h
M src/openvpn/buffer.c
M src/openvpn/clinat.c
M src/openvpn/clinat.h
M src/openvpn/comp.c
M src/openvpn/comp.h
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/dco.c
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_linux.c
M src/openvpn/dco_win.c
M src/openvpn/dns.c
M src/openvpn/dns.h
M src/openvpn/env_set.c
M src/openvpn/env_set.h
M src/openvpn/error.c
M src/openvpn/error.h
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/init.c
M src/openvpn/init.h
M src/openvpn/manage.h
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/options_util.c
M src/openvpn/options_util.h
M src/openvpn/packet_id.c
M src/openvpn/plugin.c
M src/openvpn/plugin.h
M src/openvpn/pool.c
M src/openvpn/pool.h
M src/openvpn/push.c
M src/openvpn/push.h
M src/openvpn/route.c
M src/openvpn/route.h
M src/openvpn/run_command.c
M src/openvpn/run_command.h
M src/openvpn/sig.c
M src/openvpn/sig.h
M src/openvpn/socket.c
M src/openvpn/socket.h
M src/openvpn/ssl_verify_backend.h
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/ssl_verify_openssl.c
M src/openvpn/status.c
M src/openvpn/status.h
M src/openvpn/tun.c
M src/openvpn/tun.h
M tests/unit_tests/openvpn/mock_ssl_dependencies.c
M tests/unit_tests/openvpn/test_argv.c
M tests/unit_tests/openvpn/test_misc.c
M tests/unit_tests/openvpn/test_pkcs11.c
M tests/unit_tests/openvpn/test_pkt.c
M tests/unit_tests/openvpn/test_tls_crypt.c
M tests/unit_tests/openvpn/test_user_pass.c
59 files changed, 185 insertions(+), 185 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/1110/1

diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 95215c0..2db510c 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -236,14 +236,14 @@
 /**
  *  Write the arguments stored in a struct argv via the msg() command.
  *
- *  @param msglev  Integer with the message level used by msg().
- *  @param a       Valid pointer to the struct argv with the arguments to =
write.
+ *  @param msglevel  Integer with the message level used by msg().
+ *  @param a         Valid pointer to the struct argv with the arguments t=
o write.
  */
 void
-argv_msg(const int msglev, const struct argv *a)
+argv_msg(const unsigned int msglevel, const struct argv *a)
 {
     struct gc_arena gc =3D gc_new();
-    msg(msglev, "%s", argv_str(a, &gc, 0));
+    msg(msglevel, "%s", argv_str(a, &gc, 0));
     gc_free(&gc);
 }

@@ -251,16 +251,16 @@
  *  Similar to argv_msg() but prefixes the messages being written with a
  *  given string.
  *
- *  @param msglev  Integer with the message level used by msg().
- *  @param a       Valid pointer to the struct argv with the arguments to =
write
- *  @param prefix  Valid pointer to the prefix string
+ *  @param msglevel  Integer with the message level used by msg().
+ *  @param a         Valid pointer to the struct argv with the arguments t=
o write
+ *  @param prefix    Valid pointer to the prefix string
  *
  */
 void
-argv_msg_prefix(const int msglev, const struct argv *a, const char *prefix)
+argv_msg_prefix(const unsigned int msglevel, const struct argv *a, const c=
har *prefix)
 {
     struct gc_arena gc =3D gc_new();
-    msg(msglev, "%s: %s", prefix, argv_str(a, &gc, 0));
+    msg(msglevel, "%s: %s", prefix, argv_str(a, &gc, 0));
     gc_free(&gc);
 }

diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index 098a1cb..866b405 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -47,9 +47,9 @@

 struct argv argv_insert_head(const struct argv *a, const char *head);

-void argv_msg(const int msglev, const struct argv *a);
+void argv_msg(const unsigned int msglevel, const struct argv *a);

-void argv_msg_prefix(const int msglev, const struct argv *a, const char *p=
refix);
+void argv_msg_prefix(const unsigned int msglevel, const struct argv *a, co=
nst char *prefix);

 void argv_parse_cmd(struct argv *a, const char *s);

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index dd6044b..456f591 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1130,7 +1130,7 @@
 {
     if (buf && buf->len)
     {
-        int msglevel =3D D_ALIGN_DEBUG;
+        unsigned int msglevel =3D D_ALIGN_DEBUG;
         const unsigned int u =3D (unsigned int) BPTR(buf);

         if (u & (PAYLOAD_ALIGN-1))
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index f040724..81af08c 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -49,7 +49,7 @@
 }

 void
-print_client_nat_list(const struct client_nat_option_list *list, int msgle=
vel)
+print_client_nat_list(const struct client_nat_option_list *list, unsigned =
int msglevel)
 {
     struct gc_arena gc =3D gc_new();
     int i;
@@ -108,7 +108,7 @@
                               const char *network,
                               const char *netmask,
                               const char *foreign_network,
-                              int msglevel)
+                              unsigned int msglevel)
 {
     struct client_nat_entry e;
     bool ok;
@@ -166,7 +166,7 @@
 #endif

 static void
-print_pkt(struct openvpn_iphdr *iph, const char *prefix, const int directi=
on, const int msglevel)
+print_pkt(struct openvpn_iphdr *iph, const char *prefix, const int directi=
on, const unsigned int msglevel)
 {
     struct gc_arena gc =3D gc_new();

diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index 334b3f2..c099857 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -51,14 +51,14 @@

 void copy_client_nat_option_list(struct client_nat_option_list *dest, cons=
t struct client_nat_option_list *src);

-void print_client_nat_list(const struct client_nat_option_list *list, int =
msglevel);
+void print_client_nat_list(const struct client_nat_option_list *list, unsi=
gned int msglevel);

 void add_client_nat_to_option_list(struct client_nat_option_list *dest,
                                    const char *type,
                                    const char *network,
                                    const char *netmask,
                                    const char *foreign_network,
-                                   int msglevel);
+                                   unsigned int msglevel);

 void client_nat_transform(const struct client_nat_option_list *list,
                           struct buffer *ipbuf,
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index b2aa07e..2e17af4 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -160,7 +160,7 @@
 #endif /* USE_COMP */

 bool
-check_compression_settings_valid(struct compress_options *info, int msglev=
el)
+check_compression_settings_valid(struct compress_options *info, unsigned i=
nt msglevel)
 {
     /*
      * We also allow comp-stub-v2 here as it technically allows escaping of
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index ee9c16a..37f3be7 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -91,7 +91,7 @@
  * in
  */
 bool
-check_compression_settings_valid(struct compress_options *info, int msglev=
el);
+check_compression_settings_valid(struct compress_options *info, unsigned i=
nt msglevel);

 #ifdef USE_COMP
 #include "buffer.h"
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 7564f82..91b5da04 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1650,7 +1650,7 @@
 }

 int
-ascii2keydirection(int msglevel, const char *str)
+ascii2keydirection(unsigned int msglevel, const char *str)
 {
     if (!str)
     {
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 345e7ce..cd32bb4 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -627,7 +627,7 @@

 void must_have_n_keys(const char *filename, const char *option, const stru=
ct key2 *key2, int n);

-int ascii2keydirection(int msglevel, const char *str);
+int ascii2keydirection(unsigned int msglevel, const char *str);

 const char *keydirection2ascii(int kd, bool remote, bool humanreadable);

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 98cbb72..6ce86a2 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -239,7 +239,7 @@
 }

 static bool
-dco_check_option_ce(const struct connection_entry *ce, int msglevel, int m=
ode)
+dco_check_option_ce(const struct connection_entry *ce, unsigned int msglev=
el, int mode)
 {
     if (ce->fragment)
     {
@@ -297,7 +297,7 @@
 }

 bool
-dco_check_startup_option(int msglevel, const struct options *o)
+dco_check_startup_option(unsigned int msglevel, const struct options *o)
 {
     /* check if no dev name was specified at all. In the case,
      * later logic will most likely stop OpenVPN, so no need to
@@ -433,7 +433,7 @@
 }

 bool
-dco_check_option(int msglevel, const struct options *o)
+dco_check_option(unsigned int msglevel, const struct options *o)
 {
     /* At this point the ciphers have already been normalised */
     if (o->enable_ncp_fallback
@@ -479,7 +479,7 @@
 }

 bool
-dco_check_pull_options(int msglevel, const struct options *o)
+dco_check_pull_options(unsigned int msglevel, const struct options *o)
 {
     if (!o->use_peer_id)
     {
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index f38316d..3dbf19c 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -56,7 +56,7 @@
  * @param msglevel      level to print messages to
  * @return              true if ovpn-dco is available, false otherwise
  */
-bool dco_available(int msglevel);
+bool dco_available(unsigned int msglevel);


 /**
@@ -76,7 +76,7 @@
  * @param o         the options struct that hold the options
  * @return          true if no conflict was detected, false otherwise
  */
-bool dco_check_option(int msglevel, const struct options *o);
+bool dco_check_option(unsigned int msglevel, const struct options *o);

 /**
  * Check whether the options struct has any further option that is not sup=
ported
@@ -88,7 +88,7 @@
  * @param o         the options struct that hold the options
  * @return          true if no conflict was detected, false otherwise
  */
-bool dco_check_startup_option(int msglevel, const struct options *o);
+bool dco_check_startup_option(unsigned int msglevel, const struct options =
*o);

 /**
  * Check whether any of the options pushed by the server is not supported =
by
@@ -99,7 +99,7 @@
  * @param o         the options struct that hold the options
  * @return          true if no conflict was detected, false otherwise
  */
-bool dco_check_pull_options(int msglevel, const struct options *o);
+bool dco_check_pull_options(unsigned int msglevel, const struct options *o=
);

 /**
  * Initialize the DCO context
@@ -267,7 +267,7 @@
 typedef void *dco_context_t;

 static inline bool
-dco_available(int msglevel)
+dco_available(unsigned int msglevel)
 {
     return false;
 }
@@ -279,19 +279,19 @@
 }

 static inline bool
-dco_check_option(int msglevel, const struct options *o)
+dco_check_option(unsigned int msglevel, const struct options *o)
 {
     return false;
 }

 static inline bool
-dco_check_startup_option(int msglevel, const struct options *o)
+dco_check_startup_option(unsigned int msglevel, const struct options *o)
 {
     return false;
 }

 static inline bool
-dco_check_pull_options(int msglevel, const struct options *o)
+dco_check_pull_options(unsigned int msglevel, const struct options *o)
 {
     return false;
 }
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index b8816c6..bcd10b7 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -582,7 +582,7 @@
 }

 bool
-dco_available(int msglevel)
+dco_available(unsigned int msglevel)
 {
     struct if_clonereq ifcr;
     char *buf =3D NULL;
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 3652a49..43753a5 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -76,7 +76,7 @@
  * @return ID on success, negative error code on error
  */
 static int
-resolve_ovpn_netlink_id(int msglevel)
+resolve_ovpn_netlink_id(unsigned int msglevel)
 {
     int ret;
     struct nl_sock *nl_sock =3D nl_socket_alloc();
@@ -1196,7 +1196,7 @@
 }

 bool
-dco_available(int msglevel)
+dco_available(unsigned int msglevel)
 {
     if (resolve_ovpn_netlink_id(D_DCO_DEBUG) < 0)
     {
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 83db739..15f7237 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -598,7 +598,7 @@
 }

 bool
-dco_available(int msglevel)
+dco_available(unsigned int msglevel)
 {
     /* try to open device by symbolic name */
     HANDLE h =3D CreateFile("\\\\.\\ovpn-dco", GENERIC_READ | GENERIC_WRIT=
E,
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index ea3d91b..271186e 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -201,7 +201,7 @@
 }

 bool
-dns_options_verify(int msglevel, const struct dns_options *o)
+dns_options_verify(unsigned int msglevel, const struct dns_options *o)
 {
     const struct dns_server *server =3D
         o->servers ? o->servers : o->servers_prepull;
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index d33f64e..ee70ed8 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -157,7 +157,7 @@
  * @param   o           Pointer to the DNS options to validate
  * @return              True if no error was found
  */
-bool dns_options_verify(int msglevel, const struct dns_options *o);
+bool dns_options_verify(unsigned int msglevel, const struct dns_options *o=
);

 /**
  * Makes a deep copy of the passed DNS options.
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index f20ee8a..cbf7d8f 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -210,7 +210,7 @@
 }

 void
-env_set_print(int msglevel, const struct env_set *es)
+env_set_print(unsigned int msglevel, const struct env_set *es)
 {
     if (check_debug_level(msglevel))
     {
diff --git a/src/openvpn/env_set.h b/src/openvpn/env_set.h
index 52c5312..42ebff0 100644
--- a/src/openvpn/env_set.h
+++ b/src/openvpn/env_set.h
@@ -89,7 +89,7 @@

 const char *env_set_get(const struct env_set *es, const char *name);

-void env_set_print(int msglevel, const struct env_set *es);
+void env_set_print(unsigned int msglevel, const struct env_set *es);

 /**
  * Write a struct env_set to a file. Each item on one line.
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 049cd92..170076a 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -409,8 +409,8 @@
     bool ret =3D true;
     if (mute_cutoff > 0 && !(flags & M_NOMUTE))
     {
-        const int mute_level =3D DECODE_MUTE_LEVEL(flags);
-        if (mute_level > 0 && mute_level =3D=3D mute_category)
+        const unsigned int mute_level =3D DECODE_MUTE_LEVEL(flags);
+        if (mute_level =3D=3D mute_category)
         {
             if (mute_count =3D=3D mute_cutoff)
             {
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index e0a2730..7744ef8 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -84,22 +84,22 @@

 /* msg() flags */

-#define M_DEBUG_LEVEL     (0x0F)         /* debug level mask */
+#define M_DEBUG_LEVEL     (0x0Fu)         /* debug level mask */

-#define M_FATAL           (1<<4)         /* exit program */
-#define M_NONFATAL        (1<<5)         /* non-fatal error */
-#define M_WARN            (1<<6)         /* call syslog with LOG_WARNING */
-#define M_DEBUG           (1<<7)
+#define M_FATAL           (1u<<4)         /* exit program */
+#define M_NONFATAL        (1u<<5)         /* non-fatal error */
+#define M_WARN            (1u<<6)         /* call syslog with LOG_WARNING =
*/
+#define M_DEBUG           (1u<<7)

-#define M_ERRNO           (1<<8)         /* show errno description */
+#define M_ERRNO           (1u<<8)         /* show errno description */

-#define M_NOMUTE          (1<<11)        /* don't do mute processing */
-#define M_NOPREFIX        (1<<12)        /* don't show date/time prefix */
-#define M_USAGE_SMALL     (1<<13)        /* fatal options error, call usag=
e_small */
-#define M_MSG_VIRT_OUT    (1<<14)        /* output message through msg_sta=
tus_output callback */
-#define M_OPTERR          (1<<15)        /* print "Options error:" prefix =
*/
-#define M_NOLF            (1<<16)        /* don't print new line */
-#define M_NOIPREFIX       (1<<17)        /* don't print instance prefix */
+#define M_NOMUTE          (1u<<11)        /* don't do mute processing */
+#define M_NOPREFIX        (1u<<12)        /* don't show date/time prefix */
+#define M_USAGE_SMALL     (1u<<13)        /* fatal options error, call usa=
ge_small */
+#define M_MSG_VIRT_OUT    (1u<<14)        /* output message through msg_st=
atus_output callback */
+#define M_OPTERR          (1u<<15)        /* print "Options error:" prefix=
 */
+#define M_NOLF            (1u<<16)        /* don't print new line */
+#define M_NOIPREFIX       (1u<<17)        /* don't print instance prefix */

 /* flag combinations which are frequently used */
 #define M_ERR     (M_FATAL | M_ERRNO)
@@ -113,7 +113,7 @@
  * A mute level of 0 is always printed.
  */
 #define MUTE_LEVEL_SHIFT 24
-#define MUTE_LEVEL_MASK 0xFF
+#define MUTE_LEVEL_MASK 0xFFu

 #define ENCODE_MUTE_LEVEL(mute_level) (((mute_level) & MUTE_LEVEL_MASK) <<=
 MUTE_LEVEL_SHIFT)
 #define DECODE_MUTE_LEVEL(flags) (((flags) >> MUTE_LEVEL_SHIFT) & MUTE_LEV=
EL_MASK)
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index dfc6708..aab195d 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -379,7 +379,7 @@

 bool
 send_control_channel_string_dowork(struct tls_session *session,
-                                   const char *str, int msglevel)
+                                   const char *str, unsigned int msglevel)
 {
     struct gc_arena gc =3D gc_new();
     bool stat;
@@ -407,7 +407,7 @@
 }

 bool
-send_control_channel_string(struct context *c, const char *str, int msglev=
el)
+send_control_channel_string(struct context *c, const char *str, unsigned i=
nt msglevel)
 {
     if (c->c2.tls_multi)
     {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index b3e424c..aaf47fe 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -287,7 +287,7 @@
  * @param msglevel   - Message level to use for logging
  */
 bool
-send_control_channel_string(struct context *c, const char *str, int msglev=
el);
+send_control_channel_string(struct context *c, const char *str, unsigned i=
nt msglevel);

 /*
  * Send a string to remote over the TLS control channel.
@@ -307,7 +307,7 @@

 bool
 send_control_channel_string_dowork(struct tls_session *session,
-                                   const char *str, int msglevel);
+                                   const char *str, unsigned int msglevel);


 /**
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 77747a2..641d7ee 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4379,7 +4379,7 @@
 }

 void
-management_show_net_callback(void *arg, const int msglevel)
+management_show_net_callback(void *arg, const unsigned int msglevel)
 {
 #ifdef _WIN32
     show_routes(msglevel);
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 5c6b9c1..40d8d04 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -125,7 +125,7 @@

 void close_management(void);

-void management_show_net_callback(void *arg, const int msglevel);
+void management_show_net_callback(void *arg, const unsigned int msglevel);

 #endif

diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index e25a615..3b4c18c 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -178,7 +178,7 @@
     unsigned int flags;

     void (*status) (void *arg, const int version, struct status_output *so=
);
-    void (*show_net) (void *arg, const int msglevel);
+    void (*show_net) (void *arg, const unsigned int msglevel);
     int (*kill_by_cn) (void *arg, const char *common_name);
     int (*kill_by_addr) (void *arg, const in_addr_t addr, const int port, =
const int proto);
     void (*delete_event) (void *arg, event_t event);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index ec260a2..b84f663 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3419,7 +3419,7 @@
     }
     else
     {
-        int msglevel =3D D_DCO;
+        unsigned int msglevel =3D D_DCO;
         if (dco->dco_message_type =3D=3D OVPN_CMD_DEL_PEER
             && dco->dco_del_peer_reason =3D=3D OVPN_DEL_PEER_REASON_USERSP=
ACE)
         {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0662b49..70b5799 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1106,7 +1106,7 @@
 #endif /* ifndef _WIN32 */

 static in_addr_t
-get_ip_addr(const char *ip_string, int msglevel, bool *error)
+get_ip_addr(const char *ip_string, unsigned int msglevel, bool *error)
 {
     unsigned int flags =3D GETADDR_HOST_ORDER;
     bool succeeded =3D false;
@@ -1187,7 +1187,7 @@
  * @param   gc          The returned object will be allocated in this gc
  */
 static struct verify_hash_list *
-parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct g=
c_arena *gc)
+parse_hash_fingerprint(const char *str, int nbytes, unsigned int msglevel,=
 struct gc_arena *gc)
 {
     int i =3D 0;
     const char *cp =3D str;
@@ -1241,7 +1241,7 @@
  * @param   gc          The returned list items will be allocated in this =
gc
  */
 static struct verify_hash_list *
-parse_hash_fingerprint_multiline(const char *str, int nbytes, int msglevel,
+parse_hash_fingerprint_multiline(const char *str, int nbytes, unsigned int=
 msglevel,
                                  struct gc_arena *gc)
 {
     struct gc_arena gc_temp =3D gc_new();
@@ -1335,7 +1335,7 @@
 #endif /* ifdef _WIN32 */

 static void
-dhcp_option_dns6_parse(const char *parm, struct in6_addr *dns6_list, int *=
len, int msglevel)
+dhcp_option_dns6_parse(const char *parm, struct in6_addr *dns6_list, int *=
len, unsigned int msglevel)
 {
     struct in6_addr addr;
     if (*len >=3D N_DHCP_ADDR)
@@ -1349,7 +1349,7 @@
     }
 }
 static void
-dhcp_option_address_parse(const char *name, const char *parm, in_addr_t *a=
rray, int *len, int msglevel)
+dhcp_option_address_parse(const char *name, const char *parm, in_addr_t *a=
rray, int *len, unsigned int msglevel)
 {
     if (*len >=3D N_DHCP_ADDR)
     {
@@ -1480,7 +1480,7 @@
 option_iroute(struct options *o,
               const char *network_str,
               const char *netmask_str,
-              int msglevel)
+              unsigned int msglevel)
 {
     struct iroute *ir;

@@ -1509,7 +1509,7 @@
 static void
 option_iroute_ipv6(struct options *o,
                    const char *prefix_str,
-                   int msglevel)
+                   unsigned int msglevel)
 {
     struct iroute_ipv6 *ir;

@@ -2068,7 +2068,7 @@
 }

 static struct local_entry *
-alloc_local_entry(struct connection_entry *ce, const int msglevel,
+alloc_local_entry(struct connection_entry *ce, const unsigned int msglevel,
                   struct gc_arena *gc)
 {
     struct local_list *l =3D alloc_local_list_if_undef(ce, gc);
@@ -2108,7 +2108,7 @@
 }

 static struct connection_entry *
-alloc_connection_entry(struct options *options, const int msglevel)
+alloc_connection_entry(struct options *options, const unsigned int msgleve=
l)
 {
     struct connection_list *l =3D alloc_connection_list_if_undef(options);
     struct connection_entry *e;
@@ -2141,7 +2141,7 @@
 }

 static struct remote_entry *
-alloc_remote_entry(struct options *options, const int msglevel)
+alloc_remote_entry(struct options *options, const unsigned int msglevel)
 {
     struct remote_list *l =3D alloc_remote_list_if_undef(options);
     struct remote_entry *e;
@@ -2698,7 +2698,7 @@

     if (!options->tls_server && !options->tls_client)
     {
-        int msglevel =3D M_USAGE;
+        unsigned int msglevel =3D M_USAGE;
         if (options->allow_deprecated_insecure_static_crypto)
         {
             msglevel =3D M_INFO;
@@ -4598,7 +4598,7 @@
 }

 static void
-options_warning_safe_scan2(const int msglevel,
+options_warning_safe_scan2(const unsigned int msglevel,
                            const int delim,
                            const bool report_inconsistent,
                            const char *p1,
@@ -4666,7 +4666,7 @@
 }

 static void
-options_warning_safe_scan1(const int msglevel,
+options_warning_safe_scan1(const unsigned int msglevel,
                            const int delim,
                            const bool report_inconsistent,
                            const struct buffer *b1_src,
@@ -4687,7 +4687,7 @@
 }

 static void
-options_warning_safe_ml(const int msglevel, char *actual, const char *expe=
cted, size_t actual_n)
+options_warning_safe_ml(const unsigned int msglevel, char *actual, const c=
har *expected, size_t actual_n)
 {
     struct gc_arena gc =3D gc_new();

@@ -4784,7 +4784,7 @@
  */

 int
-parse_topology(const char *str, const int msglevel)
+parse_topology(const char *str, const unsigned int msglevel)
 {
     if (streq(str, "net30"))
     {
@@ -4840,7 +4840,7 @@
 }

 bool
-auth_retry_set(const int msglevel, const char *option)
+auth_retry_set(const unsigned int msglevel, const char *option)
 {
     if (streq(option, "interact"))
     {
@@ -5004,7 +5004,7 @@

 #if 0
 static void
-ping_rec_err(int msglevel)
+ping_rec_err(unsigned int msglevel)
 {
     msg(msglevel, "only one of --ping-exit or --ping-restart options may b=
e specified");
 }
@@ -5032,7 +5032,7 @@
            const int n,
            const char *file,
            const int line_num,
-           int msglevel,
+           unsigned int msglevel,
            struct gc_arena *gc)
 {
     const int STATE_INITIAL =3D 0;
@@ -5337,7 +5337,7 @@
            const char *file,
            int line,
            const int level,
-           const int msglevel,
+           const unsigned int msglevel,
            const unsigned int permission_mask,
            unsigned int *option_types_found,
            struct env_set *es);
@@ -5348,7 +5348,7 @@
                  int level,
                  const char *top_file,
                  const int top_line,
-                 const int msglevel,
+                 const unsigned int msglevel,
                  const unsigned int permission_mask,
                  unsigned int *option_types_found,
                  struct env_set *es)
@@ -5421,7 +5421,7 @@
 read_config_string(const char *prefix,
                    struct options *options,
                    const char *config,
-                   const int msglevel,
+                   const unsigned int msglevel,
                    const unsigned int permission_mask,
                    unsigned int *option_types_found,
                    struct env_set *es)
@@ -5454,7 +5454,7 @@
 parse_argv(struct options *options,
            const int argc,
            char *argv[],
-           const int msglevel,
+           const unsigned int msglevel,
            const unsigned int permission_mask,
            unsigned int *option_types_found,
            struct env_set *es)
@@ -5573,7 +5573,7 @@
     char line[OPTION_PARM_SIZE];
     int line_num =3D 0;
     const char *file =3D "[PUSH-OPTIONS]";
-    const int msglevel =3D D_PUSH_ERRORS|M_OPTERR;
+    const unsigned int msglevel =3D D_PUSH_ERRORS|M_OPTERR;

     while (buf_parse(buf, ',', line, sizeof(line)))
     {
@@ -5596,7 +5596,7 @@
 void
 options_server_import(struct options *o,
                       const char *filename,
-                      int msglevel,
+                      unsigned int msglevel,
                       unsigned int permission_mask,
                       unsigned int *option_types_found,
                       struct env_set *es)
@@ -5616,7 +5616,7 @@
 void
 options_string_import(struct options *options,
                       const char *config,
-                      const int msglevel,
+                      const unsigned int msglevel,
                       const unsigned int permission_mask,
                       unsigned int *option_types_found,
                       struct env_set *es)
@@ -5639,7 +5639,7 @@
                   const unsigned int type,
                   const unsigned int allowed,
                   unsigned int *found,
-                  const int msglevel,
+                  const unsigned int msglevel,
                   struct options *options,
                   bool is_inline)
 {
@@ -5693,7 +5693,7 @@
 #define NM_QUOTE_HINT (1<<0)

 static bool
-no_more_than_n_args(const int msglevel,
+no_more_than_n_args(const unsigned int msglevel,
                     char *p[],
                     const int max,
                     const unsigned int flags)
@@ -5720,8 +5720,8 @@
     }
 }

-static inline int
-msglevel_forward_compatible(struct options *options, const int msglevel)
+static inline unsigned int
+msglevel_forward_compatible(struct options *options, const unsigned int ms=
glevel)
 {
     return options->forward_compatible ? M_WARN : msglevel;
 }
@@ -5790,14 +5790,14 @@
            const char *file,
            int line,
            const int level,
-           const int msglevel,
+           const unsigned int msglevel,
            const unsigned int permission_mask,
            unsigned int *option_types_found,
            struct env_set *es)
 {
     struct gc_arena gc =3D gc_new();
     const bool pull_mode =3D BOOL_CAST(permission_mask & OPT_P_PULL_MODE);
-    int msglevel_fc =3D msglevel_forward_compatible(options, msglevel);
+    unsigned int msglevel_fc =3D msglevel_forward_compatible(options, msgl=
evel);

     ASSERT(MAX_PARMS >=3D 7);

@@ -9657,7 +9657,7 @@
     else
     {
         int i;
-        int msglevel_unknown =3D msglevel_fc;
+        unsigned int msglevel_unknown =3D msglevel_fc;
         /* Check if an option is in --ignore-unknown-option and
          * set warning level to non fatal */
         for (i =3D 0; options->ignore_unknown_option && options->ignore_un=
known_option[i]; i++)
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 4ba8e3d..78b0d7c 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -797,7 +797,7 @@
 void parse_argv(struct options *options,
                 const int argc,
                 char *argv[],
-                const int msglevel,
+                const unsigned int msglevel,
                 const unsigned int permission_mask,
                 unsigned int *option_types_found,
                 struct env_set *es);
@@ -872,7 +872,7 @@

 void options_server_import(struct options *o,
                            const char *filename,
-                           int msglevel,
+                           unsigned int msglevel,
                            unsigned int permission_mask,
                            unsigned int *option_types_found,
                            struct env_set *es);
@@ -886,14 +886,14 @@
                const int n,
                const char *file,
                const int line_num,
-               int msglevel,
+               unsigned int msglevel,
                struct gc_arena *gc);

 /*
  * parse/print topology coding
  */

-int parse_topology(const char *str, const int msglevel);
+int parse_topology(const char *str, const unsigned int msglevel);

 const char *print_topology(const int topology);

@@ -907,13 +907,13 @@

 int auth_retry_get(void);

-bool auth_retry_set(const int msglevel, const char *option);
+bool auth_retry_set(const unsigned int msglevel, const char *option);

 const char *auth_retry_print(void);

 void options_string_import(struct options *options,
                            const char *config,
-                           const int msglevel,
+                           const unsigned int msglevel,
                            const unsigned int permission_mask,
                            unsigned int *option_types_found,
                            struct env_set *es);
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index 80d0c08..cb2a59c 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -116,7 +116,7 @@
 }

 int
-positive_atoi(const char *str, int msglevel)
+positive_atoi(const char *str, unsigned int msglevel)
 {
     char *endptr;
     long long i =3D strtoll(str, &endptr, 10);
@@ -132,7 +132,7 @@
 }

 int
-atoi_warn(const char *str, int msglevel)
+atoi_warn(const char *str, unsigned int msglevel)
 {
     char *endptr;
     long long i =3D strtoll(str, &endptr, 10);
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 2474e7f..2f0b29b 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -41,13 +41,13 @@
  * integer number. Otherwise print a warning with msglevel and return 0
  */
 int
-positive_atoi(const char *str, int msglevel);
+positive_atoi(const char *str, unsigned int msglevel);

 /**
  * Converts a str to an integer if the string can be represented as an
  * integer number. Otherwise print a warning with msglevel and return 0
  */
 int
-atoi_warn(const char *str, int msglevel);
+atoi_warn(const char *str, unsigned int msglevel);

 #endif /* ifndef OPTIONS_UTIL_H_ */
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 76a81c6..057fdbd 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -54,7 +54,7 @@
 #define SEQ_EXPIRED ((time_t)1)

 #ifdef ENABLE_DEBUG
-static void packet_id_debug_print(int msglevel,
+static void packet_id_debug_print(unsigned int msglevel,
                                   const struct packet_id_rec *p,
                                   const struct packet_id_net *pin,
                                   const char *message,
@@ -63,7 +63,7 @@
 #endif /* ENABLE_DEBUG */

 static inline void
-packet_id_debug(int msglevel,
+packet_id_debug(unsigned int msglevel,
                 const struct packet_id_rec *p,
                 const struct packet_id_net *pin,
                 const char *message,
@@ -592,7 +592,7 @@
 #ifdef ENABLE_DEBUG

 static void
-packet_id_debug_print(int msglevel,
+packet_id_debug_print(unsigned int msglevel,
                       const struct packet_id_rec *p,
                       const struct packet_id_net *pin,
                       const char *message,
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index bafa469..3aafccf 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -51,7 +51,7 @@
 static struct plugin_common *static_plugin_common =3D NULL; /* GLOBAL */

 static void
-plugin_show_string_array(int msglevel, const char *name, const char *array=
[])
+plugin_show_string_array(unsigned int msglevel, const char *name, const ch=
ar *array[])
 {
     int i;
     for (i =3D 0; array[i]; ++i)
@@ -64,7 +64,7 @@
 }

 static void
-plugin_show_args_env(int msglevel, const char *argv[], const char *envp[])
+plugin_show_args_env(unsigned int msglevel, const char *argv[], const char=
 *envp[])
 {
     if (check_debug_level(msglevel))
     {
@@ -186,7 +186,7 @@

 #ifndef ENABLE_SMALL
 void
-plugin_option_list_print(const struct plugin_option_list *list, int msglev=
el)
+plugin_option_list_print(const struct plugin_option_list *list, unsigned i=
nt msglevel)
 {
     int i;
     struct gc_arena gc =3D gc_new();
@@ -1024,7 +1024,7 @@

 #ifdef ENABLE_DEBUG
 void
-plugin_return_print(const int msglevel, const char *prefix, const struct p=
lugin_return *pr)
+plugin_return_print(const unsigned int msglevel, const char *prefix, const=
 struct plugin_return *pr)
 {
     int i;
     msg(msglevel, "PLUGIN_RETURN_PRINT %s", prefix);
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 5e91c60..003fcbb 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -110,7 +110,7 @@
                             struct gc_arena *gc);

 #ifndef ENABLE_SMALL
-void plugin_option_list_print(const struct plugin_option_list *list, int m=
sglevel);
+void plugin_option_list_print(const struct plugin_option_list *list, unsig=
ned int msglevel);

 #endif

@@ -144,7 +144,7 @@
 void plugin_return_free(struct plugin_return *pr);

 #ifdef ENABLE_DEBUG
-void plugin_return_print(const int msglevel, const char *prefix, const str=
uct plugin_return *pr);
+void plugin_return_print(const unsigned int msglevel, const char *prefix, =
const struct plugin_return *pr);

 #endif

diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index ced172c..c144c01 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -118,7 +118,7 @@
  * Verify start/end range
  */
 bool
-ifconfig_pool_verify_range(const int msglevel, const in_addr_t start, cons=
t in_addr_t end)
+ifconfig_pool_verify_range(const unsigned int msglevel, const in_addr_t st=
art, const in_addr_t end)
 {
     struct gc_arena gc =3D gc_new();
     bool ret =3D true;
@@ -534,7 +534,7 @@
 }

 static void
-ifconfig_pool_msg(const struct ifconfig_pool *pool, int msglevel)
+ifconfig_pool_msg(const struct ifconfig_pool *pool, unsigned int msglevel)
 {
     struct status_output *so =3D status_open(NULL, 0, msglevel, NULL, 0);
     ASSERT(so);
diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
index 9c3905d..b47cff0 100644
--- a/src/openvpn/pool.h
+++ b/src/openvpn/pool.h
@@ -79,7 +79,7 @@

 void ifconfig_pool_free(struct ifconfig_pool *pool);

-bool ifconfig_pool_verify_range(const int msglevel, const in_addr_t start,=
 const in_addr_t end);
+bool ifconfig_pool_verify_range(const unsigned int msglevel, const in_addr=
_t start, const in_addr_t end);

 ifconfig_pool_handle ifconfig_pool_acquire(struct ifconfig_pool *pool, in_=
addr_t *local, in_addr_t *remote, struct in6_addr *remote_ipv6, const char =
*common_name);
=20
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index ad8fa3d7..34e5b7a 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -378,7 +378,7 @@
  * @return true on success, false on failure.
  */
 static bool push_option_fmt(struct gc_arena *gc, struct push_list *push_li=
st,
-                            int msglevel, const char *fmt, ...)
+                            unsigned int msglevel, const char *fmt, ...)
 #ifdef __GNUC__
 #if __USE_MINGW_ANSI_STDIO
 __attribute__ ((format(gnu_printf, 4, 5)))
@@ -852,7 +852,7 @@

 static void
 push_option_ex(struct gc_arena *gc, struct push_list *push_list,
-               const char *opt, bool enable, int msglevel)
+               const char *opt, bool enable, unsigned int msglevel)
 {
     if (!string_class(opt, CC_ANY, CC_COMMA))
     {
@@ -880,7 +880,7 @@
 }

 void
-push_option(struct options *o, const char *opt, int msglevel)
+push_option(struct options *o, const char *opt, unsigned int msglevel)
 {
     push_option_ex(&o->gc, &o->push_list, opt, true, msglevel);
 }
@@ -902,7 +902,7 @@
 }

 void
-push_options(struct options *o, char **p, int msglevel, struct gc_arena *g=
c)
+push_options(struct options *o, char **p, unsigned int msglevel, struct gc=
_arena *gc)
 {
     const char **argv =3D make_extended_arg_array(p, false, gc);
     char *opt =3D print_argv(argv, gc, 0);
@@ -911,7 +911,7 @@

 static bool
 push_option_fmt(struct gc_arena *gc, struct push_list *push_list,
-                int msglevel, const char *format, ...)
+                unsigned int msglevel, const char *format, ...)
 {
     va_list arglist;
     char tmp[256] =3D {0};
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 048b4c4..86074d2 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -58,9 +58,9 @@

 void clone_push_list(struct options *o);

-void push_option(struct options *o, const char *opt, int msglevel);
+void push_option(struct options *o, const char *opt, unsigned int msglevel=
);

-void push_options(struct options *o, char **p, int msglevel,
+void push_options(struct options *o, char **p, unsigned int msglevel,
                   struct gc_arena *gc);

 void push_reset(struct options *o);
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 156262a..2b624ba 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1340,7 +1340,7 @@
 }

 void
-print_default_gateway(const int msglevel,
+print_default_gateway(const unsigned int msglevel,
                       const struct route_gateway_info *rgi,
                       const struct route_ipv6_gateway_info *rgi6)
 {
@@ -3314,18 +3314,18 @@
  * Show current routing table
  */
 void
-show_routes(int msglev)
+show_routes(unsigned int msglevel)
 {
     struct gc_arena gc =3D gc_new();

     const MIB_IPFORWARDTABLE *rt =3D get_windows_routing_table(&gc);

-    msg(msglev, "SYSTEM ROUTING TABLE");
+    msg(msglevel, "SYSTEM ROUTING TABLE");
     if (rt)
     {
         for (DWORD i =3D 0; i < rt->dwNumEntries; ++i)
         {
-            msg(msglev, "%s", format_route_entry(&rt->table[i], &gc));
+            msg(msglevel, "%s", format_route_entry(&rt->table[i], &gc));
         }
     }
     gc_free(&gc);
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index f015a12..faae424 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -356,7 +356,7 @@
                               const struct in6_addr *dest,
                               openvpn_net_ctx_t *ctx);

-void print_default_gateway(const int msglevel,
+void print_default_gateway(const unsigned int msglevel,
                            const struct route_gateway_info *rgi,
                            const struct route_ipv6_gateway_info *rgi6);

@@ -381,7 +381,7 @@

 #ifdef _WIN32

-void show_routes(int msglev);
+void show_routes(unsigned int msglevel);

 bool test_routes(const struct route_list *rl, const struct tuntap *tt);

diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index 8b5fa4f..a41b05322 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -108,7 +108,7 @@

 #ifndef WIN32
 bool
-openvpn_waitpid_check(pid_t pid, const char *msg_prefix, int msglevel)
+openvpn_waitpid_check(pid_t pid, const char *msg_prefix, unsigned int msgl=
evel)
 {
     if (pid =3D=3D 0)
     {
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index e9a6fe1..5570065 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -75,7 +75,7 @@
  */
 bool
 openvpn_waitpid_check(pid_t pid, const char *msg_prefix,
-                      int msglevel);
+                      unsigned int msglevel);

 #endif

diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 9334b10..d8b6954 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -291,7 +291,7 @@
 }

 void
-print_signal(const struct signal_info *si, const char *title, int msglevel)
+print_signal(const struct signal_info *si, const char *title, unsigned int=
 msglevel)
 {
     if (si)
     {
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index fe81af9..8c808f6 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -67,7 +67,7 @@

 void restore_signal_state(void);

-void print_signal(const struct signal_info *si, const char *title, int msg=
level);
+void print_signal(const struct signal_info *si, const char *title, unsigne=
d int msglevel);

 void print_status(struct context *c, struct status_output *so);

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 980d8b4..2f31aca 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -81,7 +81,7 @@
 get_addr_generic(sa_family_t af, unsigned int flags, const char *hostname,
                  void *network, unsigned int *netbits,
                  int resolve_retry_seconds, struct signal_info *sig_info,
-                 int msglevel)
+                 unsigned int msglevel)
 {
     char *endp, *sep, *var_host =3D NULL;
     struct addrinfo *ai =3D NULL;
@@ -224,7 +224,7 @@
=20
 bool
 get_ipv6_addr(const char *hostname, struct in6_addr *network,
-              unsigned int *netbits, int msglevel)
+              unsigned int *netbits, unsigned int msglevel)
 {
     if (get_addr_generic(AF_INET6, GETADDR_RESOLVE, hostname, network, net=
bits,
                          0, NULL, msglevel) < 0)
@@ -477,7 +477,7 @@
     struct addrinfo hints;
     int status;
     struct signal_info sigrec =3D {0};
-    int msglevel =3D (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
+    unsigned int msglevel =3D (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLV=
E_ERRORS;
     struct gc_arena gc =3D gc_new();
     const char *print_hostname;
     const char *print_servname;
@@ -541,7 +541,7 @@
         int resolve_retries =3D (flags & GETADDR_TRY_ONCE) ? 1 :
                               ((resolve_retry_seconds + 4)/ fail_wait_inte=
rval);
         const char *fmt;
-        int level =3D 0;
+        unsigned int level =3D 0;

         /* this is not a numeric IP, therefore force resolution using the
          * provided ai_family */
@@ -689,7 +689,7 @@
 done:
     if (sig_info && sig_info->signal_received)
     {
-        int level =3D 0;
+        unsigned int level =3D 0;
         if (flags & GETADDR_FATAL_ON_SIGNAL)
         {
             level =3D M_FATAL;
@@ -2059,7 +2059,7 @@
 linksock_print_addr(struct link_socket *sock)
 {
     struct gc_arena gc =3D gc_new();
-    const int msglevel =3D (sock->mode =3D=3D LS_MODE_TCP_ACCEPT_FROM) ? D=
_INIT_MEDIUM : M_INFO;
+    const unsigned int msglevel =3D (sock->mode =3D=3D LS_MODE_TCP_ACCEPT_=
FROM) ? D_INIT_MEDIUM : M_INFO;

     /* print local address */
     if (sock->bind_local)
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 6d71e83..26a13d6 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -545,7 +545,7 @@
  * Translate an IPv6 addr or hostname from string form to in6_addr
  */
 bool get_ipv6_addr(const char *hostname, struct in6_addr *network,
-                   unsigned int *netbits, int msglevel);
+                   unsigned int *netbits, unsigned int msglevel);
=20
 int openvpn_getaddrinfo(unsigned int flags,
                         const char *hostname,
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_back=
end.h
index eb80cc8..b4711a5 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -195,7 +195,7 @@
  *
  */
 void x509_track_add(const struct x509_track **ll_head, const char *name,
-                    int msglevel, struct gc_arena *gc);
+                    unsigned int msglevel, struct gc_arena *gc);

 /*
  * Save X509 fields to environment, using the naming convention:
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index 25ad09c..2db7b17 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -358,7 +358,7 @@
 }

 void
-x509_track_add(const struct x509_track **ll_head, const char *name, int ms=
glevel, struct gc_arena *gc)
+x509_track_add(const struct x509_track **ll_head, const char *name, unsign=
ed int msglevel, struct gc_arena *gc)
 {
     struct x509_track *xt;
     ALLOC_OBJ_CLEAR_GC(xt, struct x509_track, gc);
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 1546815..57a2570 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -421,7 +421,7 @@
  */

 void
-x509_track_add(const struct x509_track **ll_head, const char *name, int ms=
glevel, struct gc_arena *gc)
+x509_track_add(const struct x509_track **ll_head, const char *name, unsign=
ed int msglevel, struct gc_arena *gc)
 {
     struct x509_track *xt;
     ALLOC_OBJ_CLEAR_GC(xt, struct x509_track, gc);
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 4b0e516..06bb916 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -239,14 +239,13 @@

         if (so->msglevel >=3D 0 && !so->errors)
         {
-            msg(so->msglevel, "%s", buf);
+            msg((unsigned int)so->msglevel, "%s", buf);
         }

         if (so->fd >=3D 0 && !so->errors)
         {
-            int len;
             strcat(buf, "\n");
-            len =3D strlen(buf);
+            size_t len =3D strlen(buf);
             if (len > 0)
             {
                 if (write(so->fd, buf, len) !=3D len)
diff --git a/src/openvpn/status.h b/src/openvpn/status.h
index eaed22a..9cd9325 100644
--- a/src/openvpn/status.h
+++ b/src/openvpn/status.h
@@ -53,6 +53,7 @@

     char *filename;
     int fd;
+    /* NB: -1 is used to indicate that output should only go to the file */
     int msglevel;
     const struct virtual_output *vout;

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index d15d9eb6..d8c292d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -108,9 +108,9 @@
                                    const int addr_len,
                                    DWORD adapter_index);

-static void netsh_command(const struct argv *a, int n, int msglevel);
+static void netsh_command(const struct argv *a, int n, unsigned int msglev=
el);

-static void exec_command(const char *prefix, const struct argv *a, int n, =
int msglevel);
+static void exec_command(const char *prefix, const struct argv *a, int n, =
unsigned int msglevel);

 static const char *netsh_get_id(const char *dev_node, struct gc_arena *gc);

@@ -4201,7 +4201,7 @@
 }

 void
-show_tap_win_adapters(int msglev, int warnlev)
+show_tap_win_adapters(unsigned int msglevel, unsigned int warnlevel)
 {
     struct gc_arena gc =3D gc_new();

@@ -4218,7 +4218,7 @@
     const struct tap_reg *tap_reg =3D get_tap_reg(&gc);
     const struct panel_reg *panel_reg =3D get_panel_reg(&gc);

-    msg(msglev, "Available adapters [name, GUID, driver]:");
+    msg(msglevel, "Available adapters [name, GUID, driver]:");

     /* loop through each TAP-Windows adapter registry entry */
     for (tr =3D tap_reg; tr !=3D NULL; tr =3D tr->next)
@@ -4230,7 +4230,7 @@
         {
             if (!strcmp(tr->guid, pr->guid))
             {
-                msg(msglev, "'%s' %s %s", pr->name, tr->guid, print_tun_ba=
ckend_driver(tr->windows_driver));
+                msg(msglevel, "'%s' %s %s", pr->name, tr->guid, print_tun_=
backend_driver(tr->windows_driver));
                 ++links;
             }
         }
@@ -4244,7 +4244,7 @@
             /* a TAP adapter exists without a link from the network
              * connections control panel */
             warn_panel_null =3D true;
-            msg(msglev, "[NULL] %s", tr->guid);
+            msg(msglevel, "[NULL] %s", tr->guid);
         }
     }

@@ -4263,17 +4263,17 @@
     /* warn on registry inconsistencies */
     if (warn_tap_dup)
     {
-        msg(warnlev, "WARNING: Some TAP-Windows adapters have duplicate GU=
IDs");
+        msg(warnlevel, "WARNING: Some TAP-Windows adapters have duplicate =
GUIDs");
     }

     if (warn_panel_dup)
     {
-        msg(warnlev, "WARNING: Some TAP-Windows adapters have duplicate li=
nks from the Network Connections control panel");
+        msg(warnlevel, "WARNING: Some TAP-Windows adapters have duplicate =
links from the Network Connections control panel");
     }

     if (warn_panel_null)
     {
-        msg(warnlev, "WARNING: Some TAP-Windows adapters have no link from=
 the Network Connections control panel");
+        msg(warnlevel, "WARNING: Some TAP-Windows adapters have no link fr=
om the Network Connections control panel");
     }

     gc_free(&gc);
@@ -5023,31 +5023,31 @@
  * Show info for a single adapter
  */
 static void
-show_adapter(int msglev, const IP_ADAPTER_INFO *a, struct gc_arena *gc)
+show_adapter(unsigned int msglevel, const IP_ADAPTER_INFO *a, struct gc_ar=
ena *gc)
 {
-    msg(msglev, "%s", a->Description);
-    msg(msglev, "  Index =3D %d", (int)a->Index);
-    msg(msglev, "  GUID =3D %s", a->AdapterName);
-    msg(msglev, "  IP =3D %s", format_ip_addr_string(&a->IpAddressList, gc=
));
-    msg(msglev, "  MAC =3D %s", format_hex_ex(a->Address, a->AddressLength=
, 0, 1, ":", gc));
-    msg(msglev, "  GATEWAY =3D %s", format_ip_addr_string(&a->GatewayList,=
 gc));
+    msg(msglevel, "%s", a->Description);
+    msg(msglevel, "  Index =3D %d", (int)a->Index);
+    msg(msglevel, "  GUID =3D %s", a->AdapterName);
+    msg(msglevel, "  IP =3D %s", format_ip_addr_string(&a->IpAddressList, =
gc));
+    msg(msglevel, "  MAC =3D %s", format_hex_ex(a->Address, a->AddressLeng=
th, 0, 1, ":", gc));
+    msg(msglevel, "  GATEWAY =3D %s", format_ip_addr_string(&a->GatewayLis=
t, gc));
     if (a->DhcpEnabled)
     {
-        msg(msglev, "  DHCP SERV =3D %s", format_ip_addr_string(&a->DhcpSe=
rver, gc));
-        msg(msglev, "  DHCP LEASE OBTAINED =3D %s", time_string(a->LeaseOb=
tained, 0, false, gc));
-        msg(msglev, "  DHCP LEASE EXPIRES  =3D %s", time_string(a->LeaseEx=
pires, 0, false, gc));
+        msg(msglevel, "  DHCP SERV =3D %s", format_ip_addr_string(&a->Dhcp=
Server, gc));
+        msg(msglevel, "  DHCP LEASE OBTAINED =3D %s", time_string(a->Lease=
Obtained, 0, false, gc));
+        msg(msglevel, "  DHCP LEASE EXPIRES  =3D %s", time_string(a->Lease=
Expires, 0, false, gc));
     }
     if (a->HaveWins)
     {
-        msg(msglev, "  PRI WINS =3D %s", format_ip_addr_string(&a->Primary=
WinsServer, gc));
-        msg(msglev, "  SEC WINS =3D %s", format_ip_addr_string(&a->Seconda=
ryWinsServer, gc));
+        msg(msglevel, "  PRI WINS =3D %s", format_ip_addr_string(&a->Prima=
ryWinsServer, gc));
+        msg(msglevel, "  SEC WINS =3D %s", format_ip_addr_string(&a->Secon=
daryWinsServer, gc));
     }

     {
         const IP_PER_ADAPTER_INFO *pai =3D get_per_adapter_info(a->Index, =
gc);
         if (pai)
         {
-            msg(msglev, "  DNS SERV =3D %s", format_ip_addr_string(&pai->D=
nsServerList, gc));
+            msg(msglevel, "  DNS SERV =3D %s", format_ip_addr_string(&pai-=
>DnsServerList, gc));
         }
     }
 }
@@ -5056,12 +5056,12 @@
  * Show current adapter list
  */
 void
-show_adapters(int msglev)
+show_adapters(unsigned int msglevel)
 {
     struct gc_arena gc =3D gc_new();
     const IP_ADAPTER_INFO *ai =3D get_adapter_info_list(&gc);

-    msg(msglev, "SYSTEM ADAPTER LIST");
+    msg(msglevel, "SYSTEM ADAPTER LIST");
     if (ai)
     {
         const IP_ADAPTER_INFO *a;
@@ -5069,7 +5069,7 @@
         /* find index in the linked list */
         for (a =3D ai; a !=3D NULL; a =3D a->Next)
         {
-            show_adapter(msglev, a, &gc);
+            show_adapter(msglevel, a, &gc);
         }
     }
     gc_free(&gc);
@@ -5286,7 +5286,7 @@
 }

 static void
-exec_command(const char *prefix, const struct argv *a, int n, int msglevel)
+exec_command(const char *prefix, const struct argv *a, int n, unsigned int=
 msglevel)
 {
     int i;
     for (i =3D 0; i < n; ++i)
@@ -5307,7 +5307,7 @@
 }

 static void
-netsh_command(const struct argv *a, int n, int msglevel)
+netsh_command(const struct argv *a, int n, unsigned int msglevel)
 {
     exec_command("NETSH", a, n, msglevel);
 }
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 5407e47..77c1d76 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -449,9 +449,9 @@
                           int *count,
                           in_addr_t *netmask);

-void show_tap_win_adapters(int msglev, int warnlev);
+void show_tap_win_adapters(unsigned int msglevel, unsigned int warnlevel);

-void show_adapters(int msglev);
+void show_adapters(unsigned int msglevel);

 void tap_allow_nonadmin_access(const char *dev_node);

diff --git a/tests/unit_tests/openvpn/mock_ssl_dependencies.c b/tests/unit_=
tests/openvpn/mock_ssl_dependencies.c
index 5cfe8d0..c8612ab 100644
--- a/tests/unit_tests/openvpn/mock_ssl_dependencies.c
+++ b/tests/unit_tests/openvpn/mock_ssl_dependencies.c
@@ -39,7 +39,7 @@

 int
 parse_line(const char *line, char **p, const int n, const char *file,
-           const int line_num, int msglevel, struct gc_arena *gc)
+           const int line_num, unsigned int msglevel, struct gc_arena *gc)
 {
     /* Dummy function to get the linker happy, should never be called */
     assert_true(false);
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvp=
n/test_argv.c
index 33b3dec..eb232dd 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -23,7 +23,7 @@

 int
 __wrap_parse_line(const char *line, char **p, const int n, const char *fil=
e,
-                  const int line_num, int msglevel, struct gc_arena *gc)
+                  const int line_num, unsigned int msglevel, struct gc_are=
na *gc)
 {
     p[0] =3D PATH1 PATH2;
     p[1] =3D PARAM1;
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index 0c604ff..3272f6b 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -335,7 +335,7 @@
     assert_false(valid_integer("-2147483653", false));


-    int msglevel =3D D_LOW;
+    unsigned int msglevel =3D D_LOW;
     int saved_log_level =3D mock_get_debug_level();
     mock_set_debug_level(D_LOW);

diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/open=
vpn/test_pkcs11.c
index adad40b..052e910 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -60,7 +60,7 @@
 /* stubs for some unused functions instead of pulling in too many dependen=
cies */
 int
 parse_line(const char *line, char **p, const int n, const char *file,
-           const int line_num, int msglevel, struct gc_arena *gc)
+           const int line_num, unsigned int msglevel, struct gc_arena *gc)
 {
     assert_true(0);
     return 0;
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index ebffabe..5f741f6 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -46,7 +46,7 @@

 int
 parse_line(const char *line, char **p, const int n, const char *file,
-           const int line_num, int msglevel, struct gc_arena *gc)
+           const int line_num, unsigned int msglevel, struct gc_arena *gc)
 {
     /* Dummy function to get the linker happy, should never be called */
     assert_true(false);
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
index cc415c8..998e10d 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -100,7 +100,7 @@

 int
 __wrap_parse_line(const char *line, char **p, const int n, const char *fil=
e,
-                  const int line_num, int msglevel, struct gc_arena *gc)
+                  const int line_num, unsigned int msglevel, struct gc_are=
na *gc)
 {
     p[0] =3D PATH1 PATH2;
     p[1] =3D PARAM1;
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index 400c0f4..bc9ba54 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -77,7 +77,7 @@
 /* stubs for some unused functions instead of pulling in too many dependen=
cies */
 int
 parse_line(const char *line, char **p, const int n, const char *file,
-           const int line_num, int msglevel, struct gc_arena *gc)
+           const int line_num, unsigned int msglevel, struct gc_arena *gc)
 {
     assert_true(0);
     return 0;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1110?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id492cb774c6d022d06bb3cf5fec2a4bdd410e619
Gerrit-Change-Number: 1110
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--aBD+N6doVhQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1110?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Clean up the big msglevel type confusion<br><br>msglevel was=
 definitely unsigned as the first<br>argument to msg(), but many parts of t=
he code<br>had it as signed. So this produced a LOT of<br>warnings when ena=
bling -Wsign-conversion.<br><br>There is one exception in struct status_out=
put<br>where -1 is a valid value in the API. Only<br>positive values are tr=
anslated into standard<br>message levels.<br><br>Change-Id: Id492cb774c6d02=
2d06bb3cf5fec2a4bdd410e619<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1186...=
.2641...&gt;<br>---<br>M src/openvpn/argv.c<br>M src/openvpn/argv.h<br>M sr=
c/openvpn/buffer.c<br>M src/openvpn/clinat.c<br>M src/openvpn/clinat.h<br>M=
 src/openvpn/comp.c<br>M src/openvpn/comp.h<br>M src/openvpn/crypto.c<br>M =
src/openvpn/crypto.h<br>M src/openvpn/dco.c<br>M src/openvpn/dco.h<br>M src=
/openvpn/dco_freebsd.c<br>M src/openvpn/dco_linux.c<br>M src/openvpn/dco_wi=
n.c<br>M src/openvpn/dns.c<br>M src/openvpn/dns.h<br>M src/openvpn/env_set.=
c<br>M src/openvpn/env_set.h<br>M src/openvpn/error.c<br>M src/openvpn/erro=
r.h<br>M src/openvpn/forward.c<br>M src/openvpn/forward.h<br>M src/openvpn/=
init.c<br>M src/openvpn/init.h<br>M src/openvpn/manage.h<br>M src/openvpn/m=
ulti.c<br>M src/openvpn/options.c<br>M src/openvpn/options.h<br>M src/openv=
pn/options_util.c<br>M src/openvpn/options_util.h<br>M src/openvpn/packet_i=
d.c<br>M src/openvpn/plugin.c<br>M src/openvpn/plugin.h<br>M src/openvpn/po=
ol.c<br>M src/openvpn/pool.h<br>M src/openvpn/push.c<br>M src/openvpn/push.=
h<br>M src/openvpn/route.c<br>M src/openvpn/route.h<br>M src/openvpn/run_co=
mmand.c<br>M src/openvpn/run_command.h<br>M src/openvpn/sig.c<br>M src/open=
vpn/sig.h<br>M src/openvpn/socket.c<br>M src/openvpn/socket.h<br>M src/open=
vpn/ssl_verify_backend.h<br>M src/openvpn/ssl_verify_mbedtls.c<br>M src/ope=
nvpn/ssl_verify_openssl.c<br>M src/openvpn/status.c<br>M src/openvpn/status=
.h<br>M src/openvpn/tun.c<br>M src/openvpn/tun.h<br>M tests/unit_tests/open=
vpn/mock_ssl_dependencies.c<br>M tests/unit_tests/openvpn/test_argv.c<br>M =
tests/unit_tests/openvpn/test_misc.c<br>M tests/unit_tests/openvpn/test_pkc=
s11.c<br>M tests/unit_tests/openvpn/test_pkt.c<br>M tests/unit_tests/openvp=
n/test_tls_crypt.c<br>M tests/unit_tests/openvpn/test_user_pass.c<br>59 fil=
es changed, 185 insertions(+), 185 deletions(-)<br><br></pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit.openvpn.net:29418/openvpn refs/changes/10/1110/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/argv.c b/src/openvpn/argv.c</span><br><span>index 95215c0..2db5=
10c 100644</span><br><span>--- a/src/openvpn/argv.c</span><br><span>+++ b/s=
rc/openvpn/argv.c</span><br><span>@@ -236,14 +236,14 @@</span><br><span> /*=
*</span><br><span>  *  Write the arguments stored in a struct argv via the =
msg() command.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- *  @param msglev  Integer with the message level used by msg(=
).</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  @param a       =
Valid pointer to the struct argv with the arguments to write.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  @param msglevel  Integer with=
 the message level used by msg().</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  @param a         Valid pointer to the struct argv with th=
e arguments to write.</span><br><span>  */</span><br><span> void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-argv_msg(const int msglev, const=
 struct argv *a)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+arg=
v_msg(const unsigned int msglevel, const struct argv *a)</span><br><span> {=
</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    msg(msglev, &quot;%s&quot;, argv_str(a=
, &amp;gc, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
msg(msglevel, &quot;%s&quot;, argv_str(a, &amp;gc, 0));</span><br><span>   =
  gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span>@@=
 -251,16 +251,16 @@</span><br><span>  *  Similar to argv_msg() but prefixes=
 the messages being written with a</span><br><span>  *  given string.</span=
><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  @pa=
ram msglev  Integer with the message level used by msg().</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *  @param a       Valid pointer to the=
 struct argv with the arguments to write</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- *  @param prefix  Valid pointer to the prefix string</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @param msglevel  I=
nteger with the message level used by msg().</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  @param a         Valid pointer to the struct a=
rgv with the arguments to write</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  @param prefix    Valid pointer to the prefix string</span><=
br><span>  *</span><br><span>  */</span><br><span> void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-argv_msg_prefix(const int msglev, const s=
truct argv *a, const char *prefix)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+argv_msg_prefix(const unsigned int msglevel, const struct ar=
gv *a, const char *prefix)</span><br><span> {</span><br><span>     struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    msg(msglev, &quot;%s: %s&quot;, prefix, argv_str(a, &amp;gc, 0));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(msglevel, &quo=
t;%s: %s&quot;, prefix, argv_str(a, &amp;gc, 0));</span><br><span>     gc_f=
ree(&amp;gc);</span><br><span> }</span><br><span> </span><br><span>diff --g=
it a/src/openvpn/argv.h b/src/openvpn/argv.h</span><br><span>index 098a1cb.=
.866b405 100644</span><br><span>--- a/src/openvpn/argv.h</span><br><span>++=
+ b/src/openvpn/argv.h</span><br><span>@@ -47,9 +47,9 @@</span><br><span> <=
/span><br><span> struct argv argv_insert_head(const struct argv *a, const c=
har *head);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-void argv_msg(const int msglev, const struct argv *a);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void argv_msg(const unsigned int=
 msglevel, const struct argv *a);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void argv_msg_prefix(const int msglev, cons=
t struct argv *a, const char *prefix);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void argv_msg_prefix(const unsigned int msglevel, const =
struct argv *a, const char *prefix);</span><br><span> </span><br><span> voi=
d argv_parse_cmd(struct argv *a, const char *s);</span><br><span> </span><b=
r><span>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br>=
<span>index dd6044b..456f591 100644</span><br><span>--- a/src/openvpn/buffe=
r.c</span><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -1130,7 +=
1130,7 @@</span><br><span> {</span><br><span>     if (buf &amp;&amp; buf-&g=
t;len)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        int msglevel =3D D_ALIGN_DEBUG;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        unsigned int msglevel =3D D_ALIGN_DEBUG=
;</span><br><span>         const unsigned int u =3D (unsigned int) BPTR(buf=
);</span><br><span> </span><br><span>         if (u &amp; (PAYLOAD_ALIGN-1)=
)</span><br><span>diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c<=
/span><br><span>index f040724..81af08c 100644</span><br><span>--- a/src/ope=
nvpn/clinat.c</span><br><span>+++ b/src/openvpn/clinat.c</span><br><span>@@=
 -49,7 +49,7 @@</span><br><span> }</span><br><span> </span><br><span> void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-print_client_nat_list(=
const struct client_nat_option_list *list, int msglevel)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+print_client_nat_list(const struct cli=
ent_nat_option_list *list, unsigned int msglevel)</span><br><span> {</span>=
<br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     int i;=
</span><br><span>@@ -108,7 +108,7 @@</span><br><span>                      =
         const char *network,</span><br><span>                             =
  const char *netmask,</span><br><span>                               const=
 char *foreign_network,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                              int msglevel)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                              unsigned int msglev=
el)</span><br><span> {</span><br><span>     struct client_nat_entry e;</spa=
n><br><span>     bool ok;</span><br><span>@@ -166,7 +166,7 @@</span><br><sp=
an> #endif</span><br><span> </span><br><span> static void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-print_pkt(struct openvpn_iphdr *iph, co=
nst char *prefix, const int direction, const int msglevel)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+print_pkt(struct openvpn_iphdr *iph,=
 const char *prefix, const int direction, const unsigned int msglevel)</spa=
n><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span>=
<br><span> </span><br><span>diff --git a/src/openvpn/clinat.h b/src/openvpn=
/clinat.h</span><br><span>index 334b3f2..c099857 100644</span><br><span>---=
 a/src/openvpn/clinat.h</span><br><span>+++ b/src/openvpn/clinat.h</span><b=
r><span>@@ -51,14 +51,14 @@</span><br><span> </span><br><span> void copy_cl=
ient_nat_option_list(struct client_nat_option_list *dest, const struct clie=
nt_nat_option_list *src);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void print_client_nat_list(const struct client_nat_op=
tion_list *list, int msglevel);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void print_client_nat_list(const struct client_nat_option_list =
*list, unsigned int msglevel);</span><br><span> </span><br><span> void add_=
client_nat_to_option_list(struct client_nat_option_list *dest,</span><br><s=
pan>                                    const char *type,</span><br><span> =
                                   const char *network,</span><br><span>   =
                                 const char *netmask,</span><br><span>     =
                               const char *foreign_network,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                   in=
t msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                            unsigned int msglevel);</span><br><span> </span=
><br><span> void client_nat_transform(const struct client_nat_option_list *=
list,</span><br><span>                           struct buffer *ipbuf,</spa=
n><br><span>diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c</span><br>=
<span>index b2aa07e..2e17af4 100644</span><br><span>--- a/src/openvpn/comp.=
c</span><br><span>+++ b/src/openvpn/comp.c</span><br><span>@@ -160,7 +160,7=
 @@</span><br><span> #endif /* USE_COMP */</span><br><span> </span><br><spa=
n> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_compress=
ion_settings_valid(struct compress_options *info, int msglevel)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+check_compression_settings_vali=
d(struct compress_options *info, unsigned int msglevel)</span><br><span> {<=
/span><br><span>     /*</span><br><span>      * We also allow comp-stub-v2 =
here as it technically allows escaping of</span><br><span>diff --git a/src/=
openvpn/comp.h b/src/openvpn/comp.h</span><br><span>index ee9c16a..37f3be7 =
100644</span><br><span>--- a/src/openvpn/comp.h</span><br><span>+++ b/src/o=
penvpn/comp.h</span><br><span>@@ -91,7 +91,7 @@</span><br><span>  * in</spa=
n><br><span>  */</span><br><span> bool</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-check_compression_settings_valid(struct compress_options *=
info, int msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+check_compression_settings_valid(struct compress_options *info, unsigned i=
nt msglevel);</span><br><span> </span><br><span> #ifdef USE_COMP</span><br>=
<span> #include &quot;buffer.h&quot;</span><br><span>diff --git a/src/openv=
pn/crypto.c b/src/openvpn/crypto.c</span><br><span>index 7564f82..91b5da04 =
100644</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src=
/openvpn/crypto.c</span><br><span>@@ -1650,7 +1650,7 @@</span><br><span> }<=
/span><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-ascii2keydirection(int msglevel, const char *str)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ascii2keydirection(unsigned =
int msglevel, const char *str)</span><br><span> {</span><br><span>     if (=
!str)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/crypt=
o.h b/src/openvpn/crypto.h</span><br><span>index 345e7ce..cd32bb4 100644</s=
pan><br><span>--- a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/=
crypto.h</span><br><span>@@ -627,7 +627,7 @@</span><br><span> </span><br><s=
pan> void must_have_n_keys(const char *filename, const char *option, const =
struct key2 *key2, int n);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-int ascii2keydirection(int msglevel, const char *str=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int ascii2keydire=
ction(unsigned int msglevel, const char *str);</span><br><span> </span><br>=
<span> const char *keydirection2ascii(int kd, bool remote, bool humanreadab=
le);</span><br><span> </span><br><span>diff --git a/src/openvpn/dco.c b/src=
/openvpn/dco.c</span><br><span>index 98cbb72..6ce86a2 100644</span><br><spa=
n>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/openvpn/dco.c</span><br=
><span>@@ -239,7 +239,7 @@</span><br><span> }</span><br><span> </span><br><=
span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_=
check_option_ce(const struct connection_entry *ce, int msglevel, int mode)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_check_option_ce(=
const struct connection_entry *ce, unsigned int msglevel, int mode)</span><=
br><span> {</span><br><span>     if (ce-&gt;fragment)</span><br><span>     =
{</span><br><span>@@ -297,7 +297,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
dco_check_startup_option(int msglevel, const struct options *o)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+dco_check_startup_option(unsign=
ed int msglevel, const struct options *o)</span><br><span> {</span><br><spa=
n>     /* check if no dev name was specified at all. In the case,</span><br=
><span>      * later logic will most likely stop OpenVPN, so no need to</sp=
an><br><span>@@ -433,7 +433,7 @@</span><br><span> }</span><br><span> </span=
><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_c=
heck_option(int msglevel, const struct options *o)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+dco_check_option(unsigned int msglevel, cons=
t struct options *o)</span><br><span> {</span><br><span>     /* At this poi=
nt the ciphers have already been normalised */</span><br><span>     if (o-&=
gt;enable_ncp_fallback</span><br><span>@@ -479,7 +479,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> bool</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-dco_check_pull_options(int msglevel, const struct opti=
ons *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_check_pu=
ll_options(unsigned int msglevel, const struct options *o)</span><br><span>=
 {</span><br><span>     if (!o-&gt;use_peer_id)</span><br><span>     {</spa=
n><br><span>diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h</span><br><s=
pan>index f38316d..3dbf19c 100644</span><br><span>--- a/src/openvpn/dco.h</=
span><br><span>+++ b/src/openvpn/dco.h</span><br><span>@@ -56,7 +56,7 @@</s=
pan><br><span>  * @param msglevel      level to print messages to</span><br=
><span>  * @return              true if ovpn-dco is available, false otherw=
ise</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-bool dco_available(int msglevel);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+bool dco_available(unsigned int msglevel);</span><br><span=
> </span><br><span> </span><br><span> /**</span><br><span>@@ -76,7 +76,7 @@=
</span><br><span>  * @param o         the options struct that hold the opti=
ons</span><br><span>  * @return          true if no conflict was detected, =
false otherwise</span><br><span>  */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-bool dco_check_option(int msglevel, const struct options *o)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool dco_check_opt=
ion(unsigned int msglevel, const struct options *o);</span><br><span> </spa=
n><br><span> /**</span><br><span>  * Check whether the options struct has a=
ny further option that is not supported</span><br><span>@@ -88,7 +88,7 @@</=
span><br><span>  * @param o         the options struct that hold the option=
s</span><br><span>  * @return          true if no conflict was detected, fa=
lse otherwise</span><br><span>  */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-bool dco_check_startup_option(int msglevel, const struct optio=
ns *o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool dco_che=
ck_startup_option(unsigned int msglevel, const struct options *o);</span><b=
r><span> </span><br><span> /**</span><br><span>  * Check whether any of the=
 options pushed by the server is not supported by</span><br><span>@@ -99,7 =
+99,7 @@</span><br><span>  * @param o         the options struct that hold =
the options</span><br><span>  * @return          true if no conflict was de=
tected, false otherwise</span><br><span>  */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-bool dco_check_pull_options(int msglevel, const stru=
ct options *o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
 dco_check_pull_options(unsigned int msglevel, const struct options *o);</s=
pan><br><span> </span><br><span> /**</span><br><span>  * Initialize the DCO=
 context</span><br><span>@@ -267,7 +267,7 @@</span><br><span> typedef void =
*dco_context_t;</span><br><span> </span><br><span> static inline bool</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_available(int msglevel)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_available(unsig=
ned int msglevel)</span><br><span> {</span><br><span>     return false;</sp=
an><br><span> }</span><br><span>@@ -279,19 +279,19 @@</span><br><span> }</s=
pan><br><span> </span><br><span> static inline bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dco_check_option(int msglevel, const struct=
 options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_che=
ck_option(unsigned int msglevel, const struct options *o)</span><br><span> =
{</span><br><span>     return false;</span><br><span> }</span><br><span> </=
span><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-dco_check_startup_option(int msglevel, const struct options *o=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_check_startup_=
option(unsigned int msglevel, const struct options *o)</span><br><span> {</=
span><br><span>     return false;</span><br><span> }</span><br><span> </spa=
n><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-dco_check_pull_options(int msglevel, const struct options *o)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_check_pull_options(=
unsigned int msglevel, const struct options *o)</span><br><span> {</span><b=
r><span>     return false;</span><br><span> }</span><br><span>diff --git a/=
src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br><span>index=
 b8816c6..bcd10b7 100644</span><br><span>--- a/src/openvpn/dco_freebsd.c</s=
pan><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@ -582,7 +58=
2,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-dco_available(int msglevel)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_available(unsigned =
int msglevel)</span><br><span> {</span><br><span>     struct if_clonereq if=
cr;</span><br><span>     char *buf =3D NULL;</span><br><span>diff --git a/s=
rc/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>index 3652=
a49..43753a5 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span><br=
><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -76,7 +76,7 @@</spa=
n><br><span>  * @return ID on success, negative error code on error</span><=
br><span>  */</span><br><span> static int</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-resolve_ovpn_netlink_id(int msglevel)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+resolve_ovpn_netlink_id(unsigned int =
msglevel)</span><br><span> {</span><br><span>     int ret;</span><br><span>=
     struct nl_sock *nl_sock =3D nl_socket_alloc();</span><br><span>@@ -119=
6,7 +1196,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_available(int msgle=
vel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_available(u=
nsigned int msglevel)</span><br><span> {</span><br><span>     if (resolve_o=
vpn_netlink_id(D_DCO_DEBUG) &lt; 0)</span><br><span>     {</span><br><span>=
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>=
index 83db739..15f7237 100644</span><br><span>--- a/src/openvpn/dco_win.c</=
span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -598,7 +598,7=
 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-dco_available(int msglevel)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+dco_available(unsigned int=
 msglevel)</span><br><span> {</span><br><span>     /* try to open device by=
 symbolic name */</span><br><span>     HANDLE h =3D CreateFile(&quot;\\\\.\=
\ovpn-dco&quot;, GENERIC_READ | GENERIC_WRITE,</span><br><span>diff --git a=
/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index ea3d91b..27118=
6e 100644</span><br><span>--- a/src/openvpn/dns.c</span><br><span>+++ b/src=
/openvpn/dns.c</span><br><span>@@ -201,7 +201,7 @@</span><br><span> }</span=
><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-dns_options_verify(int msglevel, const struct dns_options *o)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+dns_options_verify(u=
nsigned int msglevel, const struct dns_options *o)</span><br><span> {</span=
><br><span>     const struct dns_server *server =3D</span><br><span>       =
  o-&gt;servers ? o-&gt;servers : o-&gt;servers_prepull;</span><br><span>di=
ff --git a/src/openvpn/dns.h b/src/openvpn/dns.h</span><br><span>index d33f=
64e..ee70ed8 100644</span><br><span>--- a/src/openvpn/dns.h</span><br><span=
>+++ b/src/openvpn/dns.h</span><br><span>@@ -157,7 +157,7 @@</span><br><spa=
n>  * @param   o           Pointer to the DNS options to validate</span><br=
><span>  * @return              True if no error was found</span><br><span>=
  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool dns_options_=
verify(int msglevel, const struct dns_options *o);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bool dns_options_verify(unsigned int msgleve=
l, const struct dns_options *o);</span><br><span> </span><br><span> /**</sp=
an><br><span>  * Makes a deep copy of the passed DNS options.</span><br><sp=
an>diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c</span><br><sp=
an>index f20ee8a..cbf7d8f 100644</span><br><span>--- a/src/openvpn/env_set.=
c</span><br><span>+++ b/src/openvpn/env_set.c</span><br><span>@@ -210,7 +21=
0,7 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-env_set_print(int msglevel, con=
st struct env_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+env_set_print(unsigned int msglevel, const struct env_set *es)</span><br=
><span> {</span><br><span>     if (check_debug_level(msglevel))</span><br><=
span>     {</span><br><span>diff --git a/src/openvpn/env_set.h b/src/openvp=
n/env_set.h</span><br><span>index 52c5312..42ebff0 100644</span><br><span>-=
-- a/src/openvpn/env_set.h</span><br><span>+++ b/src/openvpn/env_set.h</spa=
n><br><span>@@ -89,7 +89,7 @@</span><br><span> </span><br><span> const char=
 *env_set_get(const struct env_set *es, const char *name);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void env_set_print(i=
nt msglevel, const struct env_set *es);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void env_set_print(unsigned int msglevel, const struct =
env_set *es);</span><br><span> </span><br><span> /**</span><br><span>  * Wr=
ite a struct env_set to a file. Each item on one line.</span><br><span>diff=
 --git a/src/openvpn/error.c b/src/openvpn/error.c</span><br><span>index 04=
9cd92..170076a 100644</span><br><span>--- a/src/openvpn/error.c</span><br><=
span>+++ b/src/openvpn/error.c</span><br><span>@@ -409,8 +409,8 @@</span><b=
r><span>     bool ret =3D true;</span><br><span>     if (mute_cutoff &gt; 0=
 &amp;&amp; !(flags &amp; M_NOMUTE))</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        const int mute_level =3D DECO=
DE_MUTE_LEVEL(flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (mute_level &gt; 0 &amp;&amp; mute_level =3D=3D mute_category)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const unsigne=
d int mute_level =3D DECODE_MUTE_LEVEL(flags);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (mute_level =3D=3D mute_category)</sp=
an><br><span>         {</span><br><span>             if (mute_count =3D=3D =
mute_cutoff)</span><br><span>             {</span><br><span>diff --git a/sr=
c/openvpn/error.h b/src/openvpn/error.h</span><br><span>index e0a2730..7744=
ef8 100644</span><br><span>--- a/src/openvpn/error.h</span><br><span>+++ b/=
src/openvpn/error.h</span><br><span>@@ -84,22 +84,22 @@</span><br><span> </=
span><br><span> /* msg() flags */</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define M_DEBUG_LEVEL     (0x0F)         /*=
 debug level mask */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define M_DEBUG_LEVEL     (0x0Fu)         /* debug level mask */</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define M_FAT=
AL           (1&lt;&lt;4)         /* exit program */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define M_NONFATAL        (1&lt;&lt;5)     =
    /* non-fatal error */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define M_WARN            (1&lt;&lt;6)         /* call syslog with LOG_=
WARNING */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define M_D=
EBUG           (1&lt;&lt;7)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define M_FATAL           (1u&lt;&lt;4)         /* exit program */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define M_NONFATAL  =
      (1u&lt;&lt;5)         /* non-fatal error */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define M_WARN            (1u&lt;&lt;6)      =
   /* call syslog with LOG_WARNING */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define M_DEBUG           (1u&lt;&lt;7)</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define M_ERRNO      =
     (1&lt;&lt;8)         /* show errno description */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define M_ERRNO           (1u&lt;&lt;8) =
        /* show errno description */</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define M_NOMUTE          (1&lt;&lt;11)   =
     /* don&#39;t do mute processing */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define M_NOPREFIX        (1&lt;&lt;12)        /* don&#39=
;t show date/time prefix */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define M_USAGE_SMALL     (1&lt;&lt;13)        /* fatal options error=
, call usage_small */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define M_MSG_VIRT_OUT    (1&lt;&lt;14)        /* output message through ms=
g_status_output callback */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define M_OPTERR          (1&lt;&lt;15)        /* print &quot;Options=
 error:&quot; prefix */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define M_NOLF            (1&lt;&lt;16)        /* don&#39;t print new lin=
e */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define M_NOIPREF=
IX       (1&lt;&lt;17)        /* don&#39;t print instance prefix */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define M_NOMUTE          (=
1u&lt;&lt;11)        /* don&#39;t do mute processing */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define M_NOPREFIX        (1u&lt;&lt;12=
)        /* don&#39;t show date/time prefix */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define M_USAGE_SMALL     (1u&lt;&lt;13)        =
/* fatal options error, call usage_small */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define M_MSG_VIRT_OUT    (1u&lt;&lt;14)        /* =
output message through msg_status_output callback */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define M_OPTERR          (1u&lt;&lt;15) =
       /* print &quot;Options error:&quot; prefix */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define M_NOLF            (1u&lt;&lt;16) =
       /* don&#39;t print new line */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define M_NOIPREFIX       (1u&lt;&lt;17)        /* don&#3=
9;t print instance prefix */</span><br><span> </span><br><span> /* flag com=
binations which are frequently used */</span><br><span> #define M_ERR     (=
M_FATAL | M_ERRNO)</span><br><span>@@ -113,7 +113,7 @@</span><br><span>  * =
A mute level of 0 is always printed.</span><br><span>  */</span><br><span> =
#define MUTE_LEVEL_SHIFT 24</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define MUTE_LEVEL_MASK 0xFF</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define MUTE_LEVEL_MASK 0xFFu</span><br><span> </span><br><s=
pan> #define ENCODE_MUTE_LEVEL(mute_level) (((mute_level) &amp; MUTE_LEVEL_=
MASK) &lt;&lt; MUTE_LEVEL_SHIFT)</span><br><span> #define DECODE_MUTE_LEVEL=
(flags) (((flags) &gt;&gt; MUTE_LEVEL_SHIFT) &amp; MUTE_LEVEL_MASK)</span><=
br><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><=
br><span>index dfc6708..aab195d 100644</span><br><span>--- a/src/openvpn/fo=
rward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -379=
,7 +379,7 @@</span><br><span> </span><br><span> bool</span><br><span> send_=
control_channel_string_dowork(struct tls_session *session,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                                   con=
st char *str, int msglevel)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                   const char *str, unsigned int ms=
glevel)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_n=
ew();</span><br><span>     bool stat;</span><br><span>@@ -407,7 +407,7 @@</=
span><br><span> }</span><br><span> </span><br><span> bool</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-send_control_channel_string(struct cont=
ext *c, const char *str, int msglevel)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+send_control_channel_string(struct context *c, const cha=
r *str, unsigned int msglevel)</span><br><span> {</span><br><span>     if (=
c-&gt;c2.tls_multi)</span><br><span>     {</span><br><span>diff --git a/src=
/openvpn/forward.h b/src/openvpn/forward.h</span><br><span>index b3e424c..a=
af47fe 100644</span><br><span>--- a/src/openvpn/forward.h</span><br><span>+=
++ b/src/openvpn/forward.h</span><br><span>@@ -287,7 +287,7 @@</span><br><s=
pan>  * @param msglevel   - Message level to use for logging</span><br><spa=
n>  */</span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-send_control_channel_string(struct context *c, const char *str, int =
msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_cont=
rol_channel_string(struct context *c, const char *str, unsigned int msgleve=
l);</span><br><span> </span><br><span> /*</span><br><span>  * Send a string=
 to remote over the TLS control channel.</span><br><span>@@ -307,7 +307,7 @=
@</span><br><span> </span><br><span> bool</span><br><span> send_control_cha=
nnel_string_dowork(struct tls_session *session,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                   const char *st=
r, int msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                 const char *str, unsigned int msglevel);</=
span><br><span> </span><br><span> </span><br><span> /**</span><br><span>dif=
f --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index 777=
47a2..641d7ee 100644</span><br><span>--- a/src/openvpn/init.c</span><br><sp=
an>+++ b/src/openvpn/init.c</span><br><span>@@ -4379,7 +4379,7 @@</span><br=
><span> }</span><br><span> </span><br><span> void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-management_show_net_callback(void *arg, const i=
nt msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+managem=
ent_show_net_callback(void *arg, const unsigned int msglevel)</span><br><sp=
an> {</span><br><span> #ifdef _WIN32</span><br><span>     show_routes(msgle=
vel);</span><br><span>diff --git a/src/openvpn/init.h b/src/openvpn/init.h<=
/span><br><span>index 5c6b9c1..40d8d04 100644</span><br><span>--- a/src/ope=
nvpn/init.h</span><br><span>+++ b/src/openvpn/init.h</span><br><span>@@ -12=
5,7 +125,7 @@</span><br><span> </span><br><span> void close_management(void=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-v=
oid management_show_net_callback(void *arg, const int msglevel);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void management_show_net_callb=
ack(void *arg, const unsigned int msglevel);</span><br><span> </span><br><s=
pan> #endif</span><br><span> </span><br><span>diff --git a/src/openvpn/mana=
ge.h b/src/openvpn/manage.h</span><br><span>index e25a615..3b4c18c 100644</=
span><br><span>--- a/src/openvpn/manage.h</span><br><span>+++ b/src/openvpn=
/manage.h</span><br><span>@@ -178,7 +178,7 @@</span><br><span>     unsigned=
 int flags;</span><br><span> </span><br><span>     void (*status) (void *ar=
g, const int version, struct status_output *so);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    void (*show_net) (void *arg, const int msgle=
vel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    void (*sho=
w_net) (void *arg, const unsigned int msglevel);</span><br><span>     int (=
*kill_by_cn) (void *arg, const char *common_name);</span><br><span>     int=
 (*kill_by_addr) (void *arg, const in_addr_t addr, const int port, const in=
t proto);</span><br><span>     void (*delete_event) (void *arg, event_t eve=
nt);</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c=
</span><br><span>index ec260a2..b84f663 100644</span><br><span>--- a/src/op=
envpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ =
-3419,7 +3419,7 @@</span><br><span>     }</span><br><span>     else</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  int msglevel =3D D_DCO;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        unsigned int msglevel =3D D_DCO;</span><br><span>         if =
(dco-&gt;dco_message_type =3D=3D OVPN_CMD_DEL_PEER</span><br><span>        =
     &amp;&amp; dco-&gt;dco_del_peer_reason =3D=3D OVPN_DEL_PEER_REASON_USE=
RSPACE)</span><br><span>         {</span><br><span>diff --git a/src/openvpn=
/options.c b/src/openvpn/options.c</span><br><span>index 0662b49..70b5799 1=
00644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src=
/openvpn/options.c</span><br><span>@@ -1106,7 +1106,7 @@</span><br><span> #=
endif /* ifndef _WIN32 */</span><br><span> </span><br><span> static in_addr=
_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_ip_addr(const c=
har *ip_string, int msglevel, bool *error)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+get_ip_addr(const char *ip_string, unsigned int msgl=
evel, bool *error)</span><br><span> {</span><br><span>     unsigned int fla=
gs =3D GETADDR_HOST_ORDER;</span><br><span>     bool succeeded =3D false;</=
span><br><span>@@ -1187,7 +1187,7 @@</span><br><span>  * @param   gc       =
   The returned object will be allocated in this gc</span><br><span>  */</s=
pan><br><span> static struct verify_hash_list *</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-parse_hash_fingerprint(const char *str, int nbyte=
s, int msglevel, struct gc_arena *gc)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+parse_hash_fingerprint(const char *str, int nbytes, unsig=
ned int msglevel, struct gc_arena *gc)</span><br><span> {</span><br><span> =
    int i =3D 0;</span><br><span>     const char *cp =3D str;</span><br><sp=
an>@@ -1241,7 +1241,7 @@</span><br><span>  * @param   gc          The retur=
ned list items will be allocated in this gc</span><br><span>  */</span><br>=
<span> static struct verify_hash_list *</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-parse_hash_fingerprint_multiline(const char *str, int nby=
tes, int msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+p=
arse_hash_fingerprint_multiline(const char *str, int nbytes, unsigned int m=
sglevel,</span><br><span>                                  struct gc_arena =
*gc)</span><br><span> {</span><br><span>     struct gc_arena gc_temp =3D gc=
_new();</span><br><span>@@ -1335,7 +1335,7 @@</span><br><span> #endif /* if=
def _WIN32 */</span><br><span> </span><br><span> static void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-dhcp_option_dns6_parse(const char *p=
arm, struct in6_addr *dns6_list, int *len, int msglevel)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+dhcp_option_dns6_parse(const char *par=
m, struct in6_addr *dns6_list, int *len, unsigned int msglevel)</span><br><=
span> {</span><br><span>     struct in6_addr addr;</span><br><span>     if =
(*len &gt;=3D N_DHCP_ADDR)</span><br><span>@@ -1349,7 +1349,7 @@</span><br>=
<span>     }</span><br><span> }</span><br><span> static void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-dhcp_option_address_parse(const char=
 *name, const char *parm, in_addr_t *array, int *len, int msglevel)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+dhcp_option_address_parse(c=
onst char *name, const char *parm, in_addr_t *array, int *len, unsigned int=
 msglevel)</span><br><span> {</span><br><span>     if (*len &gt;=3D N_DHCP_=
ADDR)</span><br><span>     {</span><br><span>@@ -1480,7 +1480,7 @@</span><b=
r><span> option_iroute(struct options *o,</span><br><span>               co=
nst char *network_str,</span><br><span>               const char *netmask_s=
tr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              int =
msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
    unsigned int msglevel)</span><br><span> {</span><br><span>     struct i=
route *ir;</span><br><span> </span><br><span>@@ -1509,7 +1509,7 @@</span><b=
r><span> static void</span><br><span> option_iroute_ipv6(struct options *o,=
</span><br><span>                    const char *prefix_str,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                   int msglevel)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                   unsi=
gned int msglevel)</span><br><span> {</span><br><span>     struct iroute_ip=
v6 *ir;</span><br><span> </span><br><span>@@ -2068,7 +2068,7 @@</span><br><=
span> }</span><br><span> </span><br><span> static struct local_entry *</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-alloc_local_entry(struct c=
onnection_entry *ce, const int msglevel,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+alloc_local_entry(struct connection_entry *ce, const u=
nsigned int msglevel,</span><br><span>                   struct gc_arena *g=
c)</span><br><span> {</span><br><span>     struct local_list *l =3D alloc_l=
ocal_list_if_undef(ce, gc);</span><br><span>@@ -2108,7 +2108,7 @@</span><br=
><span> }</span><br><span> </span><br><span> static struct connection_entry=
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-alloc_connection_en=
try(struct options *options, const int msglevel)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+alloc_connection_entry(struct options *options=
, const unsigned int msglevel)</span><br><span> {</span><br><span>     stru=
ct connection_list *l =3D alloc_connection_list_if_undef(options);</span><b=
r><span>     struct connection_entry *e;</span><br><span>@@ -2141,7 +2141,7=
 @@</span><br><span> }</span><br><span> </span><br><span> static struct rem=
ote_entry *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-alloc_remo=
te_entry(struct options *options, const int msglevel)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+alloc_remote_entry(struct options *option=
s, const unsigned int msglevel)</span><br><span> {</span><br><span>     str=
uct remote_list *l =3D alloc_remote_list_if_undef(options);</span><br><span=
>     struct remote_entry *e;</span><br><span>@@ -2698,7 +2698,7 @@</span><=
br><span> </span><br><span>     if (!options-&gt;tls_server &amp;&amp; !opt=
ions-&gt;tls_client)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        int msglevel =3D M_USAGE;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        unsigned int msglevel =3D M_USA=
GE;</span><br><span>         if (options-&gt;allow_deprecated_insecure_stat=
ic_crypto)</span><br><span>         {</span><br><span>             msglevel=
 =3D M_INFO;</span><br><span>@@ -4598,7 +4598,7 @@</span><br><span> }</span=
><br><span> </span><br><span> static void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-options_warning_safe_scan2(const int msglevel,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+options_warning_safe_scan2(c=
onst unsigned int msglevel,</span><br><span>                            con=
st int delim,</span><br><span>                            const bool report=
_inconsistent,</span><br><span>                            const char *p1,<=
/span><br><span>@@ -4666,7 +4666,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-options_warning_safe_scan1(const int msglevel,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+options_warning_safe_scan1(const unsigned=
 int msglevel,</span><br><span>                            const int delim,=
</span><br><span>                            const bool report_inconsistent=
,</span><br><span>                            const struct buffer *b1_src,<=
/span><br><span>@@ -4687,7 +4687,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-options_warning_safe_ml(const int msglevel, char *actual, const char=
 *expected, size_t actual_n)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+options_warning_safe_ml(const unsigned int msglevel, char *actual,=
 const char *expected, size_t actual_n)</span><br><span> {</span><br><span>=
     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ =
-4784,7 +4784,7 @@</span><br><span>  */</span><br><span> </span><br><span> =
int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-parse_topology(con=
st char *str, const int msglevel)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+parse_topology(const char *str, const unsigned int msglevel)<=
/span><br><span> {</span><br><span>     if (streq(str, &quot;net30&quot;))<=
/span><br><span>     {</span><br><span>@@ -4840,7 +4840,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-auth_retry_set(const int msglevel, const char *optio=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+auth_retry_set(co=
nst unsigned int msglevel, const char *option)</span><br><span> {</span><br=
><span>     if (streq(option, &quot;interact&quot;))</span><br><span>     {=
</span><br><span>@@ -5004,7 +5004,7 @@</span><br><span> </span><br><span> #=
if 0</span><br><span> static void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-ping_rec_err(int msglevel)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ping_rec_err(unsigned int msglevel)</span><br><span> {</=
span><br><span>     msg(msglevel, &quot;only one of --ping-exit or --ping-r=
estart options may be specified&quot;);</span><br><span> }</span><br><span>=
@@ -5032,7 +5032,7 @@</span><br><span>            const int n,</span><br><s=
pan>            const char *file,</span><br><span>            const int lin=
e_num,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           int =
msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
 unsigned int msglevel,</span><br><span>            struct gc_arena *gc)</s=
pan><br><span> {</span><br><span>     const int STATE_INITIAL =3D 0;</span>=
<br><span>@@ -5337,7 +5337,7 @@</span><br><span>            const char *fil=
e,</span><br><span>            int line,</span><br><span>            const =
int level,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
const int msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
           const unsigned int msglevel,</span><br><span>            const u=
nsigned int permission_mask,</span><br><span>            unsigned int *opti=
on_types_found,</span><br><span>            struct env_set *es);</span><br>=
<span>@@ -5348,7 +5348,7 @@</span><br><span>                  int level,</s=
pan><br><span>                  const char *top_file,</span><br><span>     =
             const int top_line,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                 const int msglevel,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                 const unsigned int msglevel,</=
span><br><span>                  const unsigned int permission_mask,</span>=
<br><span>                  unsigned int *option_types_found,</span><br><sp=
an>                  struct env_set *es)</span><br><span>@@ -5421,7 +5421,7=
 @@</span><br><span> read_config_string(const char *prefix,</span><br><span=
>                    struct options *options,</span><br><span>             =
       const char *config,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                   const int msglevel,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                   const unsigned int msglevel,</sp=
an><br><span>                    const unsigned int permission_mask,</span>=
<br><span>                    unsigned int *option_types_found,</span><br><=
span>                    struct env_set *es)</span><br><span>@@ -5454,7 +54=
54,7 @@</span><br><span> parse_argv(struct options *options,</span><br><spa=
n>            const int argc,</span><br><span>            char *argv[],</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-           const int msgl=
evel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           con=
st unsigned int msglevel,</span><br><span>            const unsigned int pe=
rmission_mask,</span><br><span>            unsigned int *option_types_found=
,</span><br><span>            struct env_set *es)</span><br><span>@@ -5573,=
7 +5573,7 @@</span><br><span>     char line[OPTION_PARM_SIZE];</span><br><s=
pan>     int line_num =3D 0;</span><br><span>     const char *file =3D &quo=
t;[PUSH-OPTIONS]&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    const int msglevel =3D D_PUSH_ERRORS|M_OPTERR;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const unsigned int msglevel =3D D_PUS=
H_ERRORS|M_OPTERR;</span><br><span> </span><br><span>     while (buf_parse(=
buf, &#39;,&#39;, line, sizeof(line)))</span><br><span>     {</span><br><sp=
an>@@ -5596,7 +5596,7 @@</span><br><span> void</span><br><span> options_ser=
ver_import(struct options *o,</span><br><span>                       const =
char *filename,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                int msglevel,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                      unsigned int msglevel,</span><br><span>    =
                   unsigned int permission_mask,</span><br><span>          =
             unsigned int *option_types_found,</span><br><span>            =
           struct env_set *es)</span><br><span>@@ -5616,7 +5616,7 @@</span>=
<br><span> void</span><br><span> options_string_import(struct options *opti=
ons,</span><br><span>                       const char *config,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                      const int m=
sglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
           const unsigned int msglevel,</span><br><span>                   =
    const unsigned int permission_mask,</span><br><span>                   =
    unsigned int *option_types_found,</span><br><span>                     =
  struct env_set *es)</span><br><span>@@ -5639,7 +5639,7 @@</span><br><span=
>                   const unsigned int type,</span><br><span>              =
     const unsigned int allowed,</span><br><span>                   unsigne=
d int *found,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
          const int msglevel,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                  const unsigned int msglevel,</span><br><span>  =
                 struct options *options,</span><br><span>                 =
  bool is_inline)</span><br><span> {</span><br><span>@@ -5693,7 +5693,7 @@<=
/span><br><span> #define NM_QUOTE_HINT (1&lt;&lt;0)</span><br><span> </span=
><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-no_more_than_n_args(const int msglevel,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+no_more_than_n_args(const unsigned int msglevel,</spa=
n><br><span>                     char *p[],</span><br><span>               =
      const int max,</span><br><span>                     const unsigned in=
t flags)</span><br><span>@@ -5720,8 +5720,8 @@</span><br><span>     }</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-static inline int</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-msglevel_forward_compatible(struct options *options, const int msglev=
el)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline un=
signed int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+msglevel_=
forward_compatible(struct options *options, const unsigned int msglevel)</s=
pan><br><span> {</span><br><span>     return options-&gt;forward_compatible=
 ? M_WARN : msglevel;</span><br><span> }</span><br><span>@@ -5790,14 +5790,=
14 @@</span><br><span>            const char *file,</span><br><span>       =
     int line,</span><br><span>            const int level,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-           const int msglevel,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+           const unsigned =
int msglevel,</span><br><span>            const unsigned int permission_mas=
k,</span><br><span>            unsigned int *option_types_found,</span><br>=
<span>            struct env_set *es)</span><br><span> {</span><br><span>  =
   struct gc_arena gc =3D gc_new();</span><br><span>     const bool pull_mo=
de =3D BOOL_CAST(permission_mask &amp; OPT_P_PULL_MODE);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    int msglevel_fc =3D msglevel_forward=
_compatible(options, msglevel);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    unsigned int msglevel_fc =3D msglevel_forward_compatible(op=
tions, msglevel);</span><br><span> </span><br><span>     ASSERT(MAX_PARMS &=
gt;=3D 7);</span><br><span> </span><br><span>@@ -9657,7 +9657,7 @@</span><b=
r><span>     else</span><br><span>     {</span><br><span>         int i;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        int msglevel_unk=
nown =3D msglevel_fc;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        unsigned int msglevel_unknown =3D msglevel_fc;</span><br><span>  =
       /* Check if an option is in --ignore-unknown-option and</span><br><s=
pan>          * set warning level to non fatal */</span><br><span>         =
for (i =3D 0; options-&gt;ignore_unknown_option &amp;&amp; options-&gt;igno=
re_unknown_option[i]; i++)</span><br><span>diff --git a/src/openvpn/options=
.h b/src/openvpn/options.h</span><br><span>index 4ba8e3d..78b0d7c 100644</s=
pan><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvpn=
/options.h</span><br><span>@@ -797,7 +797,7 @@</span><br><span> void parse_=
argv(struct options *options,</span><br><span>                 const int ar=
gc,</span><br><span>                 char *argv[],</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                const int msglevel,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                const unsigned=
 int msglevel,</span><br><span>                 const unsigned int permissi=
on_mask,</span><br><span>                 unsigned int *option_types_found,=
</span><br><span>                 struct env_set *es);</span><br><span>@@ -=
872,7 +872,7 @@</span><br><span> </span><br><span> void options_server_impo=
rt(struct options *o,</span><br><span>                            const cha=
r *filename,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                  int msglevel,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                           unsigned int msglevel,</span><br><sp=
an>                            unsigned int permission_mask,</span><br><spa=
n>                            unsigned int *option_types_found,</span><br><=
span>                            struct env_set *es);</span><br><span>@@ -8=
86,14 +886,14 @@</span><br><span>                const int n,</span><br><sp=
an>                const char *file,</span><br><span>                const =
int line_num,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
       int msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+               unsigned int msglevel,</span><br><span>                stru=
ct gc_arena *gc);</span><br><span> </span><br><span> /*</span><br><span>  *=
 parse/print topology coding</span><br><span>  */</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-int parse_topology(const char=
 *str, const int msglevel);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+int parse_topology(const char *str, const unsigned int msglevel);</=
span><br><span> </span><br><span> const char *print_topology(const int topo=
logy);</span><br><span> </span><br><span>@@ -907,13 +907,13 @@</span><br><s=
pan> </span><br><span> int auth_retry_get(void);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-bool auth_retry_set(const int =
msglevel, const char *option);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool auth_retry_set(const unsigned int msglevel, const char *opt=
ion);</span><br><span> </span><br><span> const char *auth_retry_print(void)=
;</span><br><span> </span><br><span> void options_string_import(struct opti=
ons *options,</span><br><span>                            const char *confi=
g,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
        const int msglevel,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                           const unsigned int msglevel,</span><br><=
span>                            const unsigned int permission_mask,</span>=
<br><span>                            unsigned int *option_types_found,</sp=
an><br><span>                            struct env_set *es);</span><br><sp=
an>diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c</sp=
an><br><span>index 80d0c08..cb2a59c 100644</span><br><span>--- a/src/openvp=
n/options_util.c</span><br><span>+++ b/src/openvpn/options_util.c</span><br=
><span>@@ -116,7 +116,7 @@</span><br><span> }</span><br><span> </span><br><=
span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-positive_ato=
i(const char *str, int msglevel)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+positive_atoi(const char *str, unsigned int msglevel)</span><b=
r><span> {</span><br><span>     char *endptr;</span><br><span>     long lon=
g i =3D strtoll(str, &amp;endptr, 10);</span><br><span>@@ -132,7 +132,7 @@<=
/span><br><span> }</span><br><span> </span><br><span> int</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-atoi_warn(const char *str, int msglevel=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+atoi_warn(const ch=
ar *str, unsigned int msglevel)</span><br><span> {</span><br><span>     cha=
r *endptr;</span><br><span>     long long i =3D strtoll(str, &amp;endptr, 1=
0);</span><br><span>diff --git a/src/openvpn/options_util.h b/src/openvpn/o=
ptions_util.h</span><br><span>index 2474e7f..2f0b29b 100644</span><br><span=
>--- a/src/openvpn/options_util.h</span><br><span>+++ b/src/openvpn/options=
_util.h</span><br><span>@@ -41,13 +41,13 @@</span><br><span>  * integer num=
ber. Otherwise print a warning with msglevel and return 0</span><br><span> =
 */</span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-positive_atoi(const char *str, int msglevel);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+positive_atoi(const char *str, unsigned int ms=
glevel);</span><br><span> </span><br><span> /**</span><br><span>  * Convert=
s a str to an integer if the string can be represented as an</span><br><spa=
n>  * integer number. Otherwise print a warning with msglevel and return 0<=
/span><br><span>  */</span><br><span> int</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-atoi_warn(const char *str, int msglevel);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+atoi_warn(const char *str, unsign=
ed int msglevel);</span><br><span> </span><br><span> #endif /* ifndef OPTIO=
NS_UTIL_H_ */</span><br><span>diff --git a/src/openvpn/packet_id.c b/src/op=
envpn/packet_id.c</span><br><span>index 76a81c6..057fdbd 100644</span><br><=
span>--- a/src/openvpn/packet_id.c</span><br><span>+++ b/src/openvpn/packet=
_id.c</span><br><span>@@ -54,7 +54,7 @@</span><br><span> #define SEQ_EXPIRE=
D ((time_t)1)</span><br><span> </span><br><span> #ifdef ENABLE_DEBUG</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static void packet_id_debug_=
print(int msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void packet_id_debug_print(unsigned int msglevel,</span><br><span>  =
                                 const struct packet_id_rec *p,</span><br><=
span>                                   const struct packet_id_net *pin,</s=
pan><br><span>                                   const char *message,</span=
><br><span>@@ -63,7 +63,7 @@</span><br><span> #endif /* ENABLE_DEBUG */</sp=
an><br><span> </span><br><span> static inline void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-packet_id_debug(int msglevel,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+packet_id_debug(unsigned int msgleve=
l,</span><br><span>                 const struct packet_id_rec *p,</span><b=
r><span>                 const struct packet_id_net *pin,</span><br><span> =
                const char *message,</span><br><span>@@ -592,7 +592,7 @@</s=
pan><br><span> #ifdef ENABLE_DEBUG</span><br><span> </span><br><span> stati=
c void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-packet_id_debug=
_print(int msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+packet_id_debug_print(unsigned int msglevel,</span><br><span>             =
          const struct packet_id_rec *p,</span><br><span>                  =
     const struct packet_id_net *pin,</span><br><span>                     =
  const char *message,</span><br><span>diff --git a/src/openvpn/plugin.c b/=
src/openvpn/plugin.c</span><br><span>index bafa469..3aafccf 100644</span><b=
r><span>--- a/src/openvpn/plugin.c</span><br><span>+++ b/src/openvpn/plugin=
.c</span><br><span>@@ -51,7 +51,7 @@</span><br><span> static struct plugin_=
common *static_plugin_common =3D NULL; /* GLOBAL */</span><br><span> </span=
><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-plugin_show_string_array(int msglevel, const char *name, const char *arra=
y[])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+plugin_show_str=
ing_array(unsigned int msglevel, const char *name, const char *array[])</sp=
an><br><span> {</span><br><span>     int i;</span><br><span>     for (i =3D=
 0; array[i]; ++i)</span><br><span>@@ -64,7 +64,7 @@</span><br><span> }</sp=
an><br><span> </span><br><span> static void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-plugin_show_args_env(int msglevel, const char *argv[]=
, const char *envp[])</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+plugin_show_args_env(unsigned int msglevel, const char *argv[], const cha=
r *envp[])</span><br><span> {</span><br><span>     if (check_debug_level(ms=
glevel))</span><br><span>     {</span><br><span>@@ -186,7 +186,7 @@</span><=
br><span> </span><br><span> #ifndef ENABLE_SMALL</span><br><span> void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-plugin_option_list_print(c=
onst struct plugin_option_list *list, int msglevel)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+plugin_option_list_print(const struct plu=
gin_option_list *list, unsigned int msglevel)</span><br><span> {</span><br>=
<span>     int i;</span><br><span>     struct gc_arena gc =3D gc_new();</sp=
an><br><span>@@ -1024,7 +1024,7 @@</span><br><span> </span><br><span> #ifde=
f ENABLE_DEBUG</span><br><span> void</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-plugin_return_print(const int msglevel, const char *prefix, =
const struct plugin_return *pr)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+plugin_return_print(const unsigned int msglevel, const char *pr=
efix, const struct plugin_return *pr)</span><br><span> {</span><br><span>  =
   int i;</span><br><span>     msg(msglevel, &quot;PLUGIN_RETURN_PRINT %s&q=
uot;, prefix);</span><br><span>diff --git a/src/openvpn/plugin.h b/src/open=
vpn/plugin.h</span><br><span>index 5e91c60..003fcbb 100644</span><br><span>=
--- a/src/openvpn/plugin.h</span><br><span>+++ b/src/openvpn/plugin.h</span=
><br><span>@@ -110,7 +110,7 @@</span><br><span>                            =
 struct gc_arena *gc);</span><br><span> </span><br><span> #ifndef ENABLE_SM=
ALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void plugin_option=
_list_print(const struct plugin_option_list *list, int msglevel);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void plugin_option_list_print=
(const struct plugin_option_list *list, unsigned int msglevel);</span><br><=
span> </span><br><span> #endif</span><br><span> </span><br><span>@@ -144,7 =
+144,7 @@</span><br><span> void plugin_return_free(struct plugin_return *pr=
);</span><br><span> </span><br><span> #ifdef ENABLE_DEBUG</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void plugin_return_print(const int msgl=
evel, const char *prefix, const struct plugin_return *pr);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void plugin_return_print(const unsig=
ned int msglevel, const char *prefix, const struct plugin_return *pr);</spa=
n><br><span> </span><br><span> #endif</span><br><span> </span><br><span>dif=
f --git a/src/openvpn/pool.c b/src/openvpn/pool.c</span><br><span>index ced=
172c..c144c01 100644</span><br><span>--- a/src/openvpn/pool.c</span><br><sp=
an>+++ b/src/openvpn/pool.c</span><br><span>@@ -118,7 +118,7 @@</span><br><=
span>  * Verify start/end range</span><br><span>  */</span><br><span> bool<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-ifconfig_pool_verify_r=
ange(const int msglevel, const in_addr_t start, const in_addr_t end)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ifconfig_pool_verify_range=
(const unsigned int msglevel, const in_addr_t start, const in_addr_t end)</=
span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</sp=
an><br><span>     bool ret =3D true;</span><br><span>@@ -534,7 +534,7 @@</s=
pan><br><span> }</span><br><span> </span><br><span> static void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-ifconfig_pool_msg(const struct if=
config_pool *pool, int msglevel)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ifconfig_pool_msg(const struct ifconfig_pool *pool, unsigned i=
nt msglevel)</span><br><span> {</span><br><span>     struct status_output *=
so =3D status_open(NULL, 0, msglevel, NULL, 0);</span><br><span>     ASSERT=
(so);</span><br><span>diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h<=
/span><br><span>index 9c3905d..b47cff0 100644</span><br><span>--- a/src/ope=
nvpn/pool.h</span><br><span>+++ b/src/openvpn/pool.h</span><br><span>@@ -79=
,7 +79,7 @@</span><br><span> </span><br><span> void ifconfig_pool_free(stru=
ct ifconfig_pool *pool);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-bool ifconfig_pool_verify_range(const int msglevel, co=
nst in_addr_t start, const in_addr_t end);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bool ifconfig_pool_verify_range(const unsigned int m=
sglevel, const in_addr_t start, const in_addr_t end);</span><br><span> </sp=
an><br><span> ifconfig_pool_handle ifconfig_pool_acquire(struct ifconfig_po=
ol *pool, in_addr_t *local, in_addr_t *remote, struct in6_addr *remote_ipv6=
, const char *common_name);</span><br><span> </span><br><span>diff --git a/=
src/openvpn/push.c b/src/openvpn/push.c</span><br><span>index ad8fa3d7..34e=
5b7a 100644</span><br><span>--- a/src/openvpn/push.c</span><br><span>+++ b/=
src/openvpn/push.c</span><br><span>@@ -378,7 +378,7 @@</span><br><span>  * =
@return true on success, false on failure.</span><br><span>  */</span><br><=
span> static bool push_option_fmt(struct gc_arena *gc, struct push_list *pu=
sh_list,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
               int msglevel, const char *fmt, ...)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                            unsigned int msg=
level, const char *fmt, ...)</span><br><span> #ifdef __GNUC__</span><br><sp=
an> #if __USE_MINGW_ANSI_STDIO</span><br><span> __attribute__ ((format(gnu_=
printf, 4, 5)))</span><br><span>@@ -852,7 +852,7 @@</span><br><span> </span=
><br><span> static void</span><br><span> push_option_ex(struct gc_arena *gc=
, struct push_list *push_list,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-               const char *opt, bool enable, int msglevel)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+               const char *=
opt, bool enable, unsigned int msglevel)</span><br><span> {</span><br><span=
>     if (!string_class(opt, CC_ANY, CC_COMMA))</span><br><span>     {</spa=
n><br><span>@@ -880,7 +880,7 @@</span><br><span> }</span><br><span> </span>=
<br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-push_o=
ption(struct options *o, const char *opt, int msglevel)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+push_option(struct options *o, const ch=
ar *opt, unsigned int msglevel)</span><br><span> {</span><br><span>     pus=
h_option_ex(&amp;o-&gt;gc, &amp;o-&gt;push_list, opt, true, msglevel);</spa=
n><br><span> }</span><br><span>@@ -902,7 +902,7 @@</span><br><span> }</span=
><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-push_options(struct options *o, char **p, int msglevel, struct=
 gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+push_=
options(struct options *o, char **p, unsigned int msglevel, struct gc_arena=
 *gc)</span><br><span> {</span><br><span>     const char **argv =3D make_ex=
tended_arg_array(p, false, gc);</span><br><span>     char *opt =3D print_ar=
gv(argv, gc, 0);</span><br><span>@@ -911,7 +911,7 @@</span><br><span> </spa=
n><br><span> static bool</span><br><span> push_option_fmt(struct gc_arena *=
gc, struct push_list *push_list,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                int msglevel, const char *format, ...)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                unsigned int =
msglevel, const char *format, ...)</span><br><span> {</span><br><span>     =
va_list arglist;</span><br><span>     char tmp[256] =3D {0};</span><br><spa=
n>diff --git a/src/openvpn/push.h b/src/openvpn/push.h</span><br><span>inde=
x 048b4c4..86074d2 100644</span><br><span>--- a/src/openvpn/push.h</span><b=
r><span>+++ b/src/openvpn/push.h</span><br><span>@@ -58,9 +58,9 @@</span><b=
r><span> </span><br><span> void clone_push_list(struct options *o);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void push_o=
ption(struct options *o, const char *opt, int msglevel);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+void push_option(struct options *o, co=
nst char *opt, unsigned int msglevel);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-void push_options(struct options *o, cha=
r **p, int msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void push_options(struct options *o, char **p, unsigned int msglevel,</spa=
n><br><span>                   struct gc_arena *gc);</span><br><span> </spa=
n><br><span> void push_reset(struct options *o);</span><br><span>diff --git=
 a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>index 156262a.=
.2b624ba 100644</span><br><span>--- a/src/openvpn/route.c</span><br><span>+=
++ b/src/openvpn/route.c</span><br><span>@@ -1340,7 +1340,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-print_default_gateway(const int msglevel,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+print_default_gateway(const =
unsigned int msglevel,</span><br><span>                       const struct =
route_gateway_info *rgi,</span><br><span>                       const struc=
t route_ipv6_gateway_info *rgi6)</span><br><span> {</span><br><span>@@ -331=
4,18 +3314,18 @@</span><br><span>  * Show current routing table</span><br><=
span>  */</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-show_routes(int msglev)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+show_routes(unsigned int msglevel)</span><br><span> {</span><=
br><span>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br>=
<span>     const MIB_IPFORWARDTABLE *rt =3D get_windows_routing_table(&amp;=
gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    msg(msglev, &quot;SYSTEM ROUTING TABLE&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(msglevel, &quot;SYSTEM ROUTING TA=
BLE&quot;);</span><br><span>     if (rt)</span><br><span>     {</span><br><=
span>         for (DWORD i =3D 0; i &lt; rt-&gt;dwNumEntries; ++i)</span><b=
r><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         msg(msglev, &quot;%s&quot;, format_route_entry(&amp;rt-&gt;table[i=
], &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      msg(msglevel, &quot;%s&quot;, format_route_entry(&amp;rt-&gt;table[i]=
, &amp;gc));</span><br><span>         }</span><br><span>     }</span><br><s=
pan>     gc_free(&amp;gc);</span><br><span>diff --git a/src/openvpn/route.h=
 b/src/openvpn/route.h</span><br><span>index f015a12..faae424 100644</span>=
<br><span>--- a/src/openvpn/route.h</span><br><span>+++ b/src/openvpn/route=
.h</span><br><span>@@ -356,7 +356,7 @@</span><br><span>                    =
           const struct in6_addr *dest,</span><br><span>                   =
            openvpn_net_ctx_t *ctx);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-void print_default_gateway(const int msgle=
vel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void print_defa=
ult_gateway(const unsigned int msglevel,</span><br><span>                  =
          const struct route_gateway_info *rgi,</span><br><span>           =
                 const struct route_ipv6_gateway_info *rgi6);</span><br><sp=
an> </span><br><span>@@ -381,7 +381,7 @@</span><br><span> </span><br><span>=
 #ifdef _WIN32</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void show_routes(int msglev);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void show_routes(unsigned int msglevel);</span><br><sp=
an> </span><br><span> bool test_routes(const struct route_list *rl, const s=
truct tuntap *tt);</span><br><span> </span><br><span>diff --git a/src/openv=
pn/run_command.c b/src/openvpn/run_command.c</span><br><span>index 8b5fa4f.=
.a41b05322 100644</span><br><span>--- a/src/openvpn/run_command.c</span><br=
><span>+++ b/src/openvpn/run_command.c</span><br><span>@@ -108,7 +108,7 @@<=
/span><br><span> </span><br><span> #ifndef WIN32</span><br><span> bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-openvpn_waitpid_check(pid_=
t pid, const char *msg_prefix, int msglevel)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+openvpn_waitpid_check(pid_t pid, const char *msg_p=
refix, unsigned int msglevel)</span><br><span> {</span><br><span>     if (p=
id =3D=3D 0)</span><br><span>     {</span><br><span>diff --git a/src/openvp=
n/run_command.h b/src/openvpn/run_command.h</span><br><span>index e9a6fe1..=
5570065 100644</span><br><span>--- a/src/openvpn/run_command.h</span><br><s=
pan>+++ b/src/openvpn/run_command.h</span><br><span>@@ -75,7 +75,7 @@</span=
><br><span>  */</span><br><span> bool</span><br><span> openvpn_waitpid_chec=
k(pid_t pid, const char *msg_prefix,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                      int msglevel);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                      unsigned int msglev=
el);</span><br><span> </span><br><span> #endif</span><br><span> </span><br>=
<span>diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c</span><br><span>in=
dex 9334b10..d8b6954 100644</span><br><span>--- a/src/openvpn/sig.c</span><=
br><span>+++ b/src/openvpn/sig.c</span><br><span>@@ -291,7 +291,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-print_signal(const struct signal_info *si, =
const char *title, int msglevel)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+print_signal(const struct signal_info *si, const char *title, =
unsigned int msglevel)</span><br><span> {</span><br><span>     if (si)</spa=
n><br><span>     {</span><br><span>diff --git a/src/openvpn/sig.h b/src/ope=
nvpn/sig.h</span><br><span>index fe81af9..8c808f6 100644</span><br><span>--=
- a/src/openvpn/sig.h</span><br><span>+++ b/src/openvpn/sig.h</span><br><sp=
an>@@ -67,7 +67,7 @@</span><br><span> </span><br><span> void restore_signal=
_state(void);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-void print_signal(const struct signal_info *si, const char *title=
, int msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d print_signal(const struct signal_info *si, const char *title, unsigned in=
t msglevel);</span><br><span> </span><br><span> void print_status(struct co=
ntext *c, struct status_output *so);</span><br><span> </span><br><span>diff=
 --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index =
980d8b4..2f31aca 100644</span><br><span>--- a/src/openvpn/socket.c</span><b=
r><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -81,7 +81,7 @@</span>=
<br><span> get_addr_generic(sa_family_t af, unsigned int flags, const char =
*hostname,</span><br><span>                  void *network, unsigned int *n=
etbits,</span><br><span>                  int resolve_retry_seconds, struct=
 signal_info *sig_info,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                 int msglevel)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                 unsigned int msglevel)</span><br><span> {</sp=
an><br><span>     char *endp, *sep, *var_host =3D NULL;</span><br><span>   =
  struct addrinfo *ai =3D NULL;</span><br><span>@@ -224,7 +224,7 @@</span><=
br><span> </span><br><span> bool</span><br><span> get_ipv6_addr(const char =
*hostname, struct in6_addr *network,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-              unsigned int *netbits, int msglevel)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+              unsigned int *n=
etbits, unsigned int msglevel)</span><br><span> {</span><br><span>     if (=
get_addr_generic(AF_INET6, GETADDR_RESOLVE, hostname, network, netbits,</sp=
an><br><span>                          0, NULL, msglevel) &lt; 0)</span><br=
><span>@@ -477,7 +477,7 @@</span><br><span>     struct addrinfo hints;</spa=
n><br><span>     int status;</span><br><span>     struct signal_info sigrec=
 =3D {0};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int msgl=
evel =3D (flags &amp; GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int msglevel =
=3D (flags &amp; GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;</span><br><sp=
an>     struct gc_arena gc =3D gc_new();</span><br><span>     const char *p=
rint_hostname;</span><br><span>     const char *print_servname;</span><br><=
span>@@ -541,7 +541,7 @@</span><br><span>         int resolve_retries =3D (=
flags &amp; GETADDR_TRY_ONCE) ? 1 :</span><br><span>                       =
        ((resolve_retry_seconds + 4)/ fail_wait_interval);</span><br><span>=
         const char *fmt;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        int level =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        unsigned int level =3D 0;</span><br><span> </span><br><spa=
n>         /* this is not a numeric IP, therefore force resolution using th=
e</span><br><span>          * provided ai_family */</span><br><span>@@ -689=
,7 +689,7 @@</span><br><span> done:</span><br><span>     if (sig_info &amp;=
&amp; sig_info-&gt;signal_received)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        int level =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        unsigned int level =3D 0;=
</span><br><span>         if (flags &amp; GETADDR_FATAL_ON_SIGNAL)</span><b=
r><span>         {</span><br><span>             level =3D M_FATAL;</span><b=
r><span>@@ -2059,7 +2059,7 @@</span><br><span> linksock_print_addr(struct l=
ink_socket *sock)</span><br><span> {</span><br><span>     struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    co=
nst int msglevel =3D (sock-&gt;mode =3D=3D LS_MODE_TCP_ACCEPT_FROM) ? D_INI=
T_MEDIUM : M_INFO;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const unsigned int msglevel =3D (sock-&gt;mode =3D=3D LS_MODE_TCP_ACCEPT=
_FROM) ? D_INIT_MEDIUM : M_INFO;</span><br><span> </span><br><span>     /* =
print local address */</span><br><span>     if (sock-&gt;bind_local)</span>=
<br><span>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><b=
r><span>index 6d71e83..26a13d6 100644</span><br><span>--- a/src/openvpn/soc=
ket.h</span><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -545,7 =
+545,7 @@</span><br><span>  * Translate an IPv6 addr or hostname from strin=
g form to in6_addr</span><br><span>  */</span><br><span> bool get_ipv6_addr=
(const char *hostname, struct in6_addr *network,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                   unsigned int *netbits, int ms=
glevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
        unsigned int *netbits, unsigned int msglevel);</span><br><span> </s=
pan><br><span> int openvpn_getaddrinfo(unsigned int flags,</span><br><span>=
                         const char *hostname,</span><br><span>diff --git a=
/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h</span>=
<br><span>index eb80cc8..b4711a5 100644</span><br><span>--- a/src/openvpn/s=
sl_verify_backend.h</span><br><span>+++ b/src/openvpn/ssl_verify_backend.h<=
/span><br><span>@@ -195,7 +195,7 @@</span><br><span>  *</span><br><span>  *=
/</span><br><span> void x509_track_add(const struct x509_track **ll_head, c=
onst char *name,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               int msglevel, struct gc_arena *gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    unsigned int msglevel, s=
truct gc_arena *gc);</span><br><span> </span><br><span> /*</span><br><span>=
  * Save X509 fields to environment, using the naming convention:</span><br=
><span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_veri=
fy_mbedtls.c</span><br><span>index 25ad09c..2db7b17 100644</span><br><span>=
--- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/src/openvpn/ss=
l_verify_mbedtls.c</span><br><span>@@ -358,7 +358,7 @@</span><br><span> }</=
span><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-x509_track_add(const struct x509_track **ll_head, const ch=
ar *name, int msglevel, struct gc_arena *gc)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+x509_track_add(const struct x509_track **ll_head, =
const char *name, unsigned int msglevel, struct gc_arena *gc)</span><br><sp=
an> {</span><br><span>     struct x509_track *xt;</span><br><span>     ALLO=
C_OBJ_CLEAR_GC(xt, struct x509_track, gc);</span><br><span>diff --git a/src=
/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c</span><br>=
<span>index 1546815..57a2570 100644</span><br><span>--- a/src/openvpn/ssl_v=
erify_openssl.c</span><br><span>+++ b/src/openvpn/ssl_verify_openssl.c</spa=
n><br><span>@@ -421,7 +421,7 @@</span><br><span>  */</span><br><span> </spa=
n><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-x509=
_track_add(const struct x509_track **ll_head, const char *name, int msgleve=
l, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+x509_track_add(const struct x509_track **ll_head, const char *name, uns=
igned int msglevel, struct gc_arena *gc)</span><br><span> {</span><br><span=
>     struct x509_track *xt;</span><br><span>     ALLOC_OBJ_CLEAR_GC(xt, st=
ruct x509_track, gc);</span><br><span>diff --git a/src/openvpn/status.c b/s=
rc/openvpn/status.c</span><br><span>index 4b0e516..06bb916 100644</span><br=
><span>--- a/src/openvpn/status.c</span><br><span>+++ b/src/openvpn/status.=
c</span><br><span>@@ -239,14 +239,13 @@</span><br><span> </span><br><span> =
        if (so-&gt;msglevel &gt;=3D 0 &amp;&amp; !so-&gt;errors)</span><br>=
<span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       msg(so-&gt;msglevel, &quot;%s&quot;, buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            msg((unsigned int)so-&gt;msglevel=
, &quot;%s&quot;, buf);</span><br><span>         }</span><br><span> </span>=
<br><span>         if (so-&gt;fd &gt;=3D 0 &amp;&amp; !so-&gt;errors)</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            int len;</span><br><span>             strcat(buf, &quot;\n&quot=
;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            len =
=3D strlen(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         size_t len =3D strlen(buf);</span><br><span>             if (len &=
gt; 0)</span><br><span>             {</span><br><span>                 if (=
write(so-&gt;fd, buf, len) !=3D len)</span><br><span>diff --git a/src/openv=
pn/status.h b/src/openvpn/status.h</span><br><span>index eaed22a..9cd9325 1=
00644</span><br><span>--- a/src/openvpn/status.h</span><br><span>+++ b/src/=
openvpn/status.h</span><br><span>@@ -53,6 +53,7 @@</span><br><span> </span>=
<br><span>     char *filename;</span><br><span>     int fd;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* NB: -1 is used to indicate t=
hat output should only go to the file */</span><br><span>     int msglevel;=
</span><br><span>     const struct virtual_output *vout;</span><br><span> <=
/span><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><b=
r><span>index d15d9eb6..d8c292d 100644</span><br><span>--- a/src/openvpn/tu=
n.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -108,9 +108,=
9 @@</span><br><span>                                    const int addr_len=
,</span><br><span>                                    DWORD adapter_index);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic void netsh_command(const struct argv *a, int n, int msglevel);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void netsh_command(co=
nst struct argv *a, int n, unsigned int msglevel);</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static void exec_command(con=
st char *prefix, const struct argv *a, int n, int msglevel);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void exec_command(const cha=
r *prefix, const struct argv *a, int n, unsigned int msglevel);</span><br><=
span> </span><br><span> static const char *netsh_get_id(const char *dev_nod=
e, struct gc_arena *gc);</span><br><span> </span><br><span>@@ -4201,7 +4201=
,7 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-show_tap_win_adapters(int msglev=
, int warnlev)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_=
tap_win_adapters(unsigned int msglevel, unsigned int warnlevel)</span><br><=
span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><sp=
an> </span><br><span>@@ -4218,7 +4218,7 @@</span><br><span>     const struc=
t tap_reg *tap_reg =3D get_tap_reg(&amp;gc);</span><br><span>     const str=
uct panel_reg *panel_reg =3D get_panel_reg(&amp;gc);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(msglev, &quot;Avai=
lable adapters [name, GUID, driver]:&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    msg(msglevel, &quot;Available adapters [name, =
GUID, driver]:&quot;);</span><br><span> </span><br><span>     /* loop throu=
gh each TAP-Windows adapter registry entry */</span><br><span>     for (tr =
=3D tap_reg; tr !=3D NULL; tr =3D tr-&gt;next)</span><br><span>@@ -4230,7 +=
4230,7 @@</span><br><span>         {</span><br><span>             if (!strc=
mp(tr-&gt;guid, pr-&gt;guid))</span><br><span>             {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                msg(msglev, &quot;&#=
39;%s&#39; %s %s&quot;, pr-&gt;name, tr-&gt;guid, print_tun_backend_driver(=
tr-&gt;windows_driver));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                msg(msglevel, &quot;&#39;%s&#39; %s %s&quot;, pr-&gt;n=
ame, tr-&gt;guid, print_tun_backend_driver(tr-&gt;windows_driver));</span><=
br><span>                 ++links;</span><br><span>             }</span><br=
><span>         }</span><br><span>@@ -4244,7 +4244,7 @@</span><br><span>   =
          /* a TAP adapter exists without a link from the network</span><br=
><span>              * connections control panel */</span><br><span>       =
      warn_panel_null =3D true;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            msg(msglev, &quot;[NULL] %s&quot;, tr-&gt;guid);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel=
, &quot;[NULL] %s&quot;, tr-&gt;guid);</span><br><span>         }</span><br=
><span>     }</span><br><span> </span><br><span>@@ -4263,17 +4263,17 @@</sp=
an><br><span>     /* warn on registry inconsistencies */</span><br><span>  =
   if (warn_tap_dup)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        msg(warnlev, &quot;WARNING: Some TAP-Windows =
adapters have duplicate GUIDs&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        msg(warnlevel, &quot;WARNING: Some TAP-Windows ad=
apters have duplicate GUIDs&quot;);</span><br><span>     }</span><br><span>=
 </span><br><span>     if (warn_panel_dup)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        msg(warnlev, &quot;WARN=
ING: Some TAP-Windows adapters have duplicate links from the Network Connec=
tions control panel&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(warnlevel, &quot;WARNING: Some TAP-Windows adapters hav=
e duplicate links from the Network Connections control panel&quot;);</span>=
<br><span>     }</span><br><span> </span><br><span>     if (warn_panel_null=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        msg(warnlev, &quot;WARNING: Some TAP-Windows adapters have no li=
nk from the Network Connections control panel&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(warnlevel, &quot;WARNING: Som=
e TAP-Windows adapters have no link from the Network Connections control pa=
nel&quot;);</span><br><span>     }</span><br><span> </span><br><span>     g=
c_free(&amp;gc);</span><br><span>@@ -5023,31 +5023,31 @@</span><br><span>  =
* Show info for a single adapter</span><br><span>  */</span><br><span> stat=
ic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-show_adapter(i=
nt msglev, const IP_ADAPTER_INFO *a, struct gc_arena *gc)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+show_adapter(unsigned int msglevel, c=
onst IP_ADAPTER_INFO *a, struct gc_arena *gc)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    msg(msglev, &quot;%s&quot;, =
a-&gt;Description);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  msg(msglev, &quot;  Index =3D %d&quot;, (int)a-&gt;Index);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    msg(msglev, &quot;  GUID =3D %s&=
quot;, a-&gt;AdapterName);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    msg(msglev, &quot;  IP =3D %s&quot;, format_ip_addr_string(&amp;a-=
&gt;IpAddressList, gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    msg(msglev, &quot;  MAC =3D %s&quot;, format_hex_ex(a-&gt;Address, a=
-&gt;AddressLength, 0, 1, &quot;:&quot;, gc));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    msg(msglev, &quot;  GATEWAY =3D %s&quot;, form=
at_ip_addr_string(&amp;a-&gt;GatewayList, gc));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    msg(msglevel, &quot;%s&quot;, a-&gt;Descrip=
tion);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(msgle=
vel, &quot;  Index =3D %d&quot;, (int)a-&gt;Index);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(msglevel, &quot;  GUID =3D %s&quo=
t;, a-&gt;AdapterName);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    msg(msglevel, &quot;  IP =3D %s&quot;, format_ip_addr_string(&amp;a=
-&gt;IpAddressList, gc));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    msg(msglevel, &quot;  MAC =3D %s&quot;, format_hex_ex(a-&gt;Addre=
ss, a-&gt;AddressLength, 0, 1, &quot;:&quot;, gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(msglevel, &quot;  GATEWAY =3D %s&=
quot;, format_ip_addr_string(&amp;a-&gt;GatewayList, gc));</span><br><span>=
     if (a-&gt;DhcpEnabled)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        msg(msglev, &quot;  DHCP SERV =3D %s&q=
uot;, format_ip_addr_string(&amp;a-&gt;DhcpServer, gc));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        msg(msglev, &quot;  DHCP LEASE O=
BTAINED =3D %s&quot;, time_string(a-&gt;LeaseObtained, 0, false, gc));</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(msglev, &quot;=
  DHCP LEASE EXPIRES  =3D %s&quot;, time_string(a-&gt;LeaseExpires, 0, fals=
e, gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(msglevel, &quot;  DHCP SERV =3D %s&quot;, format_ip_addr_string(&amp;a-&gt=
;DhcpServer, gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(msglevel, &quot;  DHCP LEASE OBTAINED =3D %s&quot;, time_string(=
a-&gt;LeaseObtained, 0, false, gc));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        msg(msglevel, &quot;  DHCP LEASE EXPIRES  =3D %s&q=
uot;, time_string(a-&gt;LeaseExpires, 0, false, gc));</span><br><span>     =
}</span><br><span>     if (a-&gt;HaveWins)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        msg(msglev, &quot;  PRI=
 WINS =3D %s&quot;, format_ip_addr_string(&amp;a-&gt;PrimaryWinsServer, gc)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(msglev,=
 &quot;  SEC WINS =3D %s&quot;, format_ip_addr_string(&amp;a-&gt;SecondaryW=
insServer, gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(msglevel, &quot;  PRI WINS =3D %s&quot;, format_ip_addr_string(&am=
p;a-&gt;PrimaryWinsServer, gc));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(msglevel, &quot;  SEC WINS =3D %s&quot;, format_ip=
_addr_string(&amp;a-&gt;SecondaryWinsServer, gc));</span><br><span>     }</=
span><br><span> </span><br><span>     {</span><br><span>         const IP_P=
ER_ADAPTER_INFO *pai =3D get_per_adapter_info(a-&gt;Index, gc);</span><br><=
span>         if (pai)</span><br><span>         {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            msg(msglev, &quot;  DNS SERV =3D %s=
&quot;, format_ip_addr_string(&amp;pai-&gt;DnsServerList, gc));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot=
;  DNS SERV =3D %s&quot;, format_ip_addr_string(&amp;pai-&gt;DnsServerList,=
 gc));</span><br><span>         }</span><br><span>     }</span><br><span> }=
</span><br><span>@@ -5056,12 +5056,12 @@</span><br><span>  * Show current a=
dapter list</span><br><span>  */</span><br><span> void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-show_adapters(int msglev)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+show_adapters(unsigned int msglevel)=
</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</=
span><br><span>     const IP_ADAPTER_INFO *ai =3D get_adapter_info_list(&am=
p;gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    msg(msglev, &quot;SYSTEM ADAPTER LIST&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(msglevel, &quot;SYSTEM ADAPTER LI=
ST&quot;);</span><br><span>     if (ai)</span><br><span>     {</span><br><s=
pan>         const IP_ADAPTER_INFO *a;</span><br><span>@@ -5069,7 +5069,7 @=
@</span><br><span>         /* find index in the linked list */</span><br><s=
pan>         for (a =3D ai; a !=3D NULL; a =3D a-&gt;Next)</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 show_adapter(msglev, a, &amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            show_adapter(msglevel, a, &amp;gc);</span><br><s=
pan>         }</span><br><span>     }</span><br><span>     gc_free(&amp;gc)=
;</span><br><span>@@ -5286,7 +5286,7 @@</span><br><span> }</span><br><span>=
 </span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-exec_command(const char *prefix, const struct argv *a, int n, int =
msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+exec_comma=
nd(const char *prefix, const struct argv *a, int n, unsigned int msglevel)<=
/span><br><span> {</span><br><span>     int i;</span><br><span>     for (i =
=3D 0; i &lt; n; ++i)</span><br><span>@@ -5307,7 +5307,7 @@</span><br><span=
> }</span><br><span> </span><br><span> static void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-netsh_command(const struct argv *a, int n, int=
 msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+netsh_com=
mand(const struct argv *a, int n, unsigned int msglevel)</span><br><span> {=
</span><br><span>     exec_command(&quot;NETSH&quot;, a, n, msglevel);</spa=
n><br><span> }</span><br><span>diff --git a/src/openvpn/tun.h b/src/openvpn=
/tun.h</span><br><span>index 5407e47..77c1d76 100644</span><br><span>--- a/=
src/openvpn/tun.h</span><br><span>+++ b/src/openvpn/tun.h</span><br><span>@=
@ -449,9 +449,9 @@</span><br><span>                           int *count,</=
span><br><span>                           in_addr_t *netmask);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void show_tap_wi=
n_adapters(int msglev, int warnlev);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void show_tap_win_adapters(unsigned int msglevel, unsigned=
 int warnlevel);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void show_adapters(int msglev);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void show_adapters(unsigned int msglevel);</span><=
br><span> </span><br><span> void tap_allow_nonadmin_access(const char *dev_=
node);</span><br><span> </span><br><span>diff --git a/tests/unit_tests/open=
vpn/mock_ssl_dependencies.c b/tests/unit_tests/openvpn/mock_ssl_dependencie=
s.c</span><br><span>index 5cfe8d0..c8612ab 100644</span><br><span>--- a/tes=
ts/unit_tests/openvpn/mock_ssl_dependencies.c</span><br><span>+++ b/tests/u=
nit_tests/openvpn/mock_ssl_dependencies.c</span><br><span>@@ -39,7 +39,7 @@=
</span><br><span> </span><br><span> int</span><br><span> parse_line(const c=
har *line, char **p, const int n, const char *file,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-           const int line_num, int msglevel=
, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+           const int line_num, unsigned int msglevel, struct gc_arena *g=
c)</span><br><span> {</span><br><span>     /* Dummy function to get the lin=
ker happy, should never be called */</span><br><span>     assert_true(false=
);</span><br><span>diff --git a/tests/unit_tests/openvpn/test_argv.c b/test=
s/unit_tests/openvpn/test_argv.c</span><br><span>index 33b3dec..eb232dd 100=
644</span><br><span>--- a/tests/unit_tests/openvpn/test_argv.c</span><br><s=
pan>+++ b/tests/unit_tests/openvpn/test_argv.c</span><br><span>@@ -23,7 +23=
,7 @@</span><br><span> </span><br><span> int</span><br><span> __wrap_parse_=
line(const char *line, char **p, const int n, const char *file,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                  const int line_=
num, int msglevel, struct gc_arena *gc)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                  const int line_num, unsigned int msgl=
evel, struct gc_arena *gc)</span><br><span> {</span><br><span>     p[0] =3D=
 PATH1 PATH2;</span><br><span>     p[1] =3D PARAM1;</span><br><span>diff --=
git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_=
misc.c</span><br><span>index 0c604ff..3272f6b 100644</span><br><span>--- a/=
tests/unit_tests/openvpn/test_misc.c</span><br><span>+++ b/tests/unit_tests=
/openvpn/test_misc.c</span><br><span>@@ -335,7 +335,7 @@</span><br><span>  =
   assert_false(valid_integer(&quot;-2147483653&quot;, false));</span><br><=
span> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    int msglevel =3D D_LOW;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    unsigned int msglevel =3D D_LOW;</span><br><span>     int sa=
ved_log_level =3D mock_get_debug_level();</span><br><span>     mock_set_deb=
ug_level(D_LOW);</span><br><span> </span><br><span>diff --git a/tests/unit_=
tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c</span>=
<br><span>index adad40b..052e910 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/test_pkcs11.c</span><br><span>+++ b/tests/unit_tests/openvpn/te=
st_pkcs11.c</span><br><span>@@ -60,7 +60,7 @@</span><br><span> /* stubs for=
 some unused functions instead of pulling in too many dependencies */</span=
><br><span> int</span><br><span> parse_line(const char *line, char **p, con=
st int n, const char *file,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-           const int line_num, int msglevel, struct gc_arena *gc)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+           const int li=
ne_num, unsigned int msglevel, struct gc_arena *gc)</span><br><span> {</spa=
n><br><span>     assert_true(0);</span><br><span>     return 0;</span><br><=
span>diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/op=
envpn/test_pkt.c</span><br><span>index ebffabe..5f741f6 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/test_pkt.c</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_pkt.c</span><br><span>@@ -46,7 +46,7 @@</span><br><s=
pan> </span><br><span> int</span><br><span> parse_line(const char *line, ch=
ar **p, const int n, const char *file,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-           const int line_num, int msglevel, struct gc_are=
na *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           c=
onst int line_num, unsigned int msglevel, struct gc_arena *gc)</span><br><s=
pan> {</span><br><span>     /* Dummy function to get the linker happy, shou=
ld never be called */</span><br><span>     assert_true(false);</span><br><s=
pan>diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tes=
ts/openvpn/test_tls_crypt.c</span><br><span>index cc415c8..998e10d 100644</=
span><br><span>--- a/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><s=
pan>+++ b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>@@ -100=
,7 +100,7 @@</span><br><span> </span><br><span> int</span><br><span> __wrap=
_parse_line(const char *line, char **p, const int n, const char *file,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                  const in=
t line_num, int msglevel, struct gc_arena *gc)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                  const int line_num, unsigned i=
nt msglevel, struct gc_arena *gc)</span><br><span> {</span><br><span>     p=
[0] =3D PATH1 PATH2;</span><br><span>     p[1] =3D PARAM1;</span><br><span>=
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c</span><br><span>index 400c0f4..bc9ba54 100644</span=
><br><span>--- a/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>=
+++ b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>@@ -77,7 +7=
7,7 @@</span><br><span> /* stubs for some unused functions instead of pulli=
ng in too many dependencies */</span><br><span> int</span><br><span> parse_=
line(const char *line, char **p, const int n, const char *file,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-           const int line_num, in=
t msglevel, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+           const int line_num, unsigned int msglevel, struct g=
c_arena *gc)</span><br><span> {</span><br><span>     assert_true(0);</span>=
<br><span>     return 0;</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1110?usp=3Demail">change =
1110</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1110?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id492cb774c6d022d06bb3cf5fec=
2a4bdd410e619 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1110 </div>
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


--aBD+N6doVhQ=--

