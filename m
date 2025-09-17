From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 17 Sep 2025 11:58:48 +0000
In-Reply-To: <gerrit.1753364704000.Id492cb774c6d022d06bb3cf5fec2a4bdd410e619@...2715...>
References: <gerrit.1753364704000.Id492cb774c6d022d06bb3cf5fec2a4bdd410e619@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...,
 gert@...1296...
Message-ID: <352548ad08d6ee94c3952f95c3060c26628209b2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PIMVmQXh28k="; charset=UTF-8
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

--PIMVmQXh28k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1110?usp=3Demail

to look at the new patch set (#14).


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
M src/openvpn/mtu.c
M src/openvpn/mtu.h
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
M src/openvpn/socket_util.c
M src/openvpn/socket_util.h
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
M tests/unit_tests/openvpn/test_push_update_msg.c
M tests/unit_tests/openvpn/test_tls_crypt.c
M tests/unit_tests/openvpn/test_user_pass.c
63 files changed, 238 insertions(+), 229 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/1110/14

diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 903fc0a..55deef5 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -235,14 +235,14 @@
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

@@ -250,16 +250,16 @@
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
index 056fe31..724b827 100644
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
index 0f0d17e..b6d6669 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1127,7 +1127,7 @@
 {
     if (buf && buf->len)
     {
-        int msglevel =3D D_ALIGN_DEBUG;
+        unsigned int msglevel =3D D_ALIGN_DEBUG;
         const unsigned int u =3D (unsigned int)BPTR(buf);

         if (u & (PAYLOAD_ALIGN - 1))
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 48a2057..2d21daf 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -47,7 +47,7 @@
 }

 void
-print_client_nat_list(const struct client_nat_option_list *list, int msgle=
vel)
+print_client_nat_list(const struct client_nat_option_list *list, unsigned =
int msglevel)
 {
     struct gc_arena gc =3D gc_new();
     int i;
@@ -101,7 +101,7 @@
 void
 add_client_nat_to_option_list(struct client_nat_option_list *dest, const c=
har *type,
                               const char *network, const char *netmask, co=
nst char *foreign_network,
-                              int msglevel)
+                              unsigned int msglevel)
 {
     struct client_nat_entry e;
     bool ok;
@@ -159,7 +159,7 @@
 #endif

 static void
-print_pkt(struct openvpn_iphdr *iph, const char *prefix, const int directi=
on, const int msglevel)
+print_pkt(struct openvpn_iphdr *iph, const char *prefix, const int directi=
on, const unsigned int msglevel)
 {
     struct gc_arena gc =3D gc_new();

diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index abfa0b7..3fcdf70 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -54,11 +54,11 @@
 void copy_client_nat_option_list(struct client_nat_option_list *dest,
                                  const struct client_nat_option_list *src);

-void print_client_nat_list(const struct client_nat_option_list *list, int =
msglevel);
+void print_client_nat_list(const struct client_nat_option_list *list, unsi=
gned int msglevel);

 void add_client_nat_to_option_list(struct client_nat_option_list *dest, co=
nst char *type,
                                    const char *network, const char *netmas=
k,
-                                   const char *foreign_network, int msglev=
el);
+                                   const char *foreign_network, unsigned i=
nt msglevel);

 void client_nat_transform(const struct client_nat_option_list *list, struc=
t buffer *ipbuf,
                           const int direction);
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 1a2e775..305184d 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -159,7 +159,7 @@
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
index 0354896..5327eae 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -89,7 +89,7 @@
  * flags of allow-compression and also the whether algorithms are compiled
  * in
  */
-bool check_compression_settings_valid(struct compress_options *info, int m=
sglevel);
+bool check_compression_settings_valid(struct compress_options *info, unsig=
ned int msglevel);

 #ifdef USE_COMP
 #include "buffer.h"
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 1535c78..cec66da 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1618,7 +1618,7 @@
 }

 int
-ascii2keydirection(int msglevel, const char *str)
+ascii2keydirection(unsigned int msglevel, const char *str)
 {
     if (!str)
     {
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index efd7f60..a403f32 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -618,7 +618,7 @@

 void must_have_n_keys(const char *filename, const char *option, const stru=
ct key2 *key2, int n);

-int ascii2keydirection(int msglevel, const char *str);
+int ascii2keydirection(unsigned int msglevel, const char *str);

 const char *keydirection2ascii(int kd, bool remote, bool humanreadable);

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 823b4f9..8f39e80 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -233,7 +233,7 @@
 }

 static bool
-dco_check_option_ce(const struct connection_entry *ce, int msglevel, int m=
ode)
+dco_check_option_ce(const struct connection_entry *ce, unsigned int msglev=
el, int mode)
 {
     if (ce->fragment)
     {
@@ -293,7 +293,7 @@
 }

 bool
-dco_check_startup_option(int msglevel, const struct options *o)
+dco_check_startup_option(unsigned int msglevel, const struct options *o)
 {
     /* check if no dev name was specified at all. In the case,
      * later logic will most likely stop OpenVPN, so no need to
@@ -430,7 +430,7 @@
 }

 bool
-dco_check_option(int msglevel, const struct options *o)
+dco_check_option(unsigned int msglevel, const struct options *o)
 {
     /* At this point the ciphers have already been normalised */
     if (o->enable_ncp_fallback
@@ -480,7 +480,7 @@
 }

 bool
-dco_check_pull_options(int msglevel, const struct options *o)
+dco_check_pull_options(unsigned int msglevel, const struct options *o)
 {
     if (!o->use_peer_id)
     {
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 59acb18..7fa8055 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -55,7 +55,7 @@
  * @param msglevel      level to print messages to
  * @return              true if ovpn-dco is available, false otherwise
  */
-bool dco_available(int msglevel);
+bool dco_available(unsigned int msglevel);


 /**
@@ -75,7 +75,7 @@
  * @param o         the options struct that hold the options
  * @return          true if no conflict was detected, false otherwise
  */
-bool dco_check_option(int msglevel, const struct options *o);
+bool dco_check_option(unsigned int msglevel, const struct options *o);

 /**
  * Check whether the options struct has any further option that is not sup=
ported
@@ -87,7 +87,7 @@
  * @param o         the options struct that hold the options
  * @return          true if no conflict was detected, false otherwise
  */
-bool dco_check_startup_option(int msglevel, const struct options *o);
+bool dco_check_startup_option(unsigned int msglevel, const struct options =
*o);

 /**
  * Check whether any of the options pushed by the server is not supported =
by
@@ -98,7 +98,7 @@
  * @param o         the options struct that hold the options
  * @return          true if no conflict was detected, false otherwise
  */
-bool dco_check_pull_options(int msglevel, const struct options *o);
+bool dco_check_pull_options(unsigned int msglevel, const struct options *o=
);

 /**
  * Initialize the DCO context
@@ -261,7 +261,7 @@
 typedef void *dco_context_t;

 static inline bool
-dco_available(int msglevel)
+dco_available(unsigned int msglevel)
 {
     return false;
 }
@@ -273,19 +273,19 @@
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
index 56a774d..cb76211 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -663,7 +663,7 @@
 }

 bool
-dco_available(int msglevel)
+dco_available(unsigned int msglevel)
 {
     struct if_clonereq ifcr;
     char *buf =3D NULL;
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 3b08f33..accd432 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -79,7 +79,7 @@
  * @return ID on success, negative error code on error
  */
 static int
-resolve_ovpn_netlink_id(int msglevel)
+resolve_ovpn_netlink_id(unsigned int msglevel)
 {
     int ret;
     struct nl_sock *nl_sock =3D nl_socket_alloc();
@@ -1204,7 +1204,7 @@
 }

 bool
-dco_available(int msglevel)
+dco_available(unsigned int msglevel)
 {
     if (resolve_ovpn_netlink_id(D_DCO_DEBUG) < 0)
     {
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 1dc5cf8..39a5ab6 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -609,7 +609,7 @@
 }

 bool
-dco_available(int msglevel)
+dco_available(unsigned int msglevel)
 {
     /* try to open device by symbolic name */
     HANDLE h =3D CreateFile("\\\\.\\ovpn-dco", GENERIC_READ | GENERIC_WRIT=
E, 0, NULL, OPEN_EXISTING,
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 5421004..6455cc9 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -200,7 +200,7 @@
 }

 bool
-dns_options_verify(int msglevel, const struct dns_options *o)
+dns_options_verify(unsigned int msglevel, const struct dns_options *o)
 {
     const struct dns_server *server =3D o->servers ? o->servers : o->serve=
rs_prepull;
     while (server)
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 6d97b40..833b937 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -166,7 +166,7 @@
  * @param   o           Pointer to the DNS options to validate
  * @return              True if no error was found
  */
-bool dns_options_verify(int msglevel, const struct dns_options *o);
+bool dns_options_verify(unsigned int msglevel, const struct dns_options *o=
);

 /**
  * Makes a deep copy of the passed DNS options.
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index 6c7df8e..487a5e2 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -209,7 +209,7 @@
 }

 void
-env_set_print(int msglevel, const struct env_set *es)
+env_set_print(unsigned int msglevel, const struct env_set *es)
 {
     if (check_debug_level(msglevel))
     {
diff --git a/src/openvpn/env_set.h b/src/openvpn/env_set.h
index 3973a4e..130de75 100644
--- a/src/openvpn/env_set.h
+++ b/src/openvpn/env_set.h
@@ -85,7 +85,7 @@

 const char *env_set_get(const struct env_set *es, const char *name);

-void env_set_print(int msglevel, const struct env_set *es);
+void env_set_print(unsigned int msglevel, const struct env_set *es);

 /**
  * Write a struct env_set to a file. Each item on one line.
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 1b98235..90c0f75 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -390,8 +390,8 @@
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
index 8388f82..2ad2c5d 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -83,22 +83,22 @@

 /* msg() flags */

-#define M_DEBUG_LEVEL (0x0F) /* debug level mask */
+#define M_DEBUG_LEVEL (0x0Fu) /* debug level mask */

-#define M_FATAL    (1 << 4)  /* exit program */
-#define M_NONFATAL (1 << 5)  /* non-fatal error */
-#define M_WARN     (1 << 6)  /* call syslog with LOG_WARNING */
-#define M_DEBUG    (1 << 7)
+#define M_FATAL    (1u << 4)  /* exit program */
+#define M_NONFATAL (1u << 5)  /* non-fatal error */
+#define M_WARN     (1u << 6)  /* call syslog with LOG_WARNING */
+#define M_DEBUG    (1u << 7)

-#define M_ERRNO (1 << 8)         /* show errno description */
+#define M_ERRNO (1u << 8)         /* show errno description */

-#define M_NOMUTE       (1 << 11) /* don't do mute processing */
-#define M_NOPREFIX     (1 << 12) /* don't show date/time prefix */
-#define M_USAGE_SMALL  (1 << 13) /* fatal options error, call usage_small =
*/
-#define M_MSG_VIRT_OUT (1 << 14) /* output message through msg_status_outp=
ut callback */
-#define M_OPTERR       (1 << 15) /* print "Options error:" prefix */
-#define M_NOLF         (1 << 16) /* don't print new line */
-#define M_NOIPREFIX    (1 << 17) /* don't print instance prefix */
+#define M_NOMUTE       (1u << 11) /* don't do mute processing */
+#define M_NOPREFIX     (1u << 12) /* don't show date/time prefix */
+#define M_USAGE_SMALL  (1u << 13) /* fatal options error, call usage_small=
 */
+#define M_MSG_VIRT_OUT (1u << 14) /* output message through msg_status_out=
put callback */
+#define M_OPTERR       (1u << 15) /* print "Options error:" prefix */
+#define M_NOLF         (1u << 16) /* don't print new line */
+#define M_NOIPREFIX    (1u << 17) /* don't print instance prefix */

 /* flag combinations which are frequently used */
 #define M_ERR    (M_FATAL | M_ERRNO)
@@ -112,7 +112,7 @@
  * A mute level of 0 is always printed.
  */
 #define MUTE_LEVEL_SHIFT 24
-#define MUTE_LEVEL_MASK  0xFF
+#define MUTE_LEVEL_MASK  0xFFu

 #define ENCODE_MUTE_LEVEL(mute_level) (((mute_level) & MUTE_LEVEL_MASK) <<=
 MUTE_LEVEL_SHIFT)
 #define DECODE_MUTE_LEVEL(flags)      (((flags) >> MUTE_LEVEL_SHIFT) & MUT=
E_LEVEL_MASK)
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index e82b544..cafd8e75 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -373,7 +373,8 @@
 #endif

 bool
-send_control_channel_string_dowork(struct tls_session *session, const char=
 *str, int msglevel)
+send_control_channel_string_dowork(struct tls_session *session, const char=
 *str,
+                                   unsigned int msglevel)
 {
     struct gc_arena gc =3D gc_new();
     bool stat;
@@ -400,7 +401,7 @@
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
index 79d0f8b..581eae1 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -285,7 +285,7 @@
  * @param str        - The message to be sent
  * @param msglevel   - Message level to use for logging
  */
-bool send_control_channel_string(struct context *c, const char *str, int m=
sglevel);
+bool send_control_channel_string(struct context *c, const char *str, unsig=
ned int msglevel);

 /*
  * Send a string to remote over the TLS control channel.
@@ -303,7 +303,8 @@
  * @param msglevel   - Message level to use for logging
  */

-bool send_control_channel_string_dowork(struct tls_session *session, const=
 char *str, int msglevel);
+bool send_control_channel_string_dowork(struct tls_session *session, const=
 char *str,
+                                        unsigned int msglevel);


 /**
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 24aebc0..e6b3b14 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4282,7 +4282,7 @@
 }
=20
 void
-management_show_net_callback(void *arg, const int msglevel)
+management_show_net_callback(void *arg, const unsigned int msglevel)
 {
 #ifdef _WIN32
     show_routes(msglevel);
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index a807874..432cf31 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -136,7 +136,7 @@

 void close_management(void);

-void management_show_net_callback(void *arg, const int msglevel);
+void management_show_net_callback(void *arg, const unsigned int msglevel);

 #endif

diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 7c189ba..4b62b04 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -176,7 +176,7 @@
     unsigned int flags;

     void (*status)(void *arg, const int version, struct status_output *so);
-    void (*show_net)(void *arg, const int msglevel);
+    void (*show_net)(void *arg, const unsigned int msglevel);
     int (*kill_by_cn)(void *arg, const char *common_name);
     int (*kill_by_addr)(void *arg, const in_addr_t addr, const int port, c=
onst int proto);
     void (*delete_event)(void *arg, event_t event);
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 1e021e3..f5bc814 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -187,7 +187,7 @@
 }

 void
-frame_print(const struct frame *frame, int level, const char *prefix)
+frame_print(const struct frame *frame, unsigned int msglevel, const char *=
prefix)
 {
     struct gc_arena gc =3D gc_new();
     struct buffer out =3D alloc_buf_gc(256, &gc);
@@ -208,7 +208,7 @@
     buf_printf(&out, " ET:%d", frame->extra_tun);
     buf_printf(&out, " ]");

-    msg(level, "%s", out.data);
+    msg(msglevel, "%s", out.data);
     gc_free(&gc);
 }

diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index c092461..c555f51 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -181,7 +181,7 @@
  * Function prototypes.
  */
=20
-void frame_print(const struct frame *frame, int level, const char *prefix);
+void frame_print(const struct frame *frame, unsigned int msglevel, const c=
har *prefix);

 void set_mtu_discover_type(socket_descriptor_t sd, int mtu_type, sa_family=
_t proto_af);

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 579eeea..a68832b 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3321,7 +3321,7 @@
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
index e47d54c..f398de0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1107,7 +1107,7 @@
 #endif /* ifndef _WIN32 */

 static in_addr_t
-get_ip_addr(const char *ip_string, int msglevel, bool *error)
+get_ip_addr(const char *ip_string, unsigned int msglevel, bool *error)
 {
     unsigned int flags =3D GETADDR_HOST_ORDER;
     bool succeeded =3D false;
@@ -1192,7 +1192,7 @@
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
@@ -1245,7 +1245,8 @@
  * @param   gc          The returned list items will be allocated in this =
gc
  */
 static struct verify_hash_list *
-parse_hash_fingerprint_multiline(const char *str, int nbytes, int msglevel=
, struct gc_arena *gc)
+parse_hash_fingerprint_multiline(const char *str, int nbytes, unsigned int=
 msglevel,
+                                 struct gc_arena *gc)
 {
     struct gc_arena gc_temp =3D gc_new();
     char *lines =3D string_alloc(str, &gc_temp);
@@ -1334,7 +1335,7 @@
 #endif /* ifdef _WIN32 */

 static void
-dhcp_option_dns6_parse(const char *parm, struct in6_addr *dns6_list, int *=
len, int msglevel)
+dhcp_option_dns6_parse(const char *parm, struct in6_addr *dns6_list, int *=
len, unsigned int msglevel)
 {
     struct in6_addr addr;
     if (*len >=3D N_DHCP_ADDR)
@@ -1349,7 +1350,7 @@
 }
 static void
 dhcp_option_address_parse(const char *name, const char *parm, in_addr_t *a=
rray, int *len,
-                          int msglevel)
+                          unsigned int msglevel)
 {
     if (*len >=3D N_DHCP_ADDR)
     {
@@ -1485,7 +1486,8 @@
 #endif /* ! ENABLE_SMALL */

 static void
-option_iroute(struct options *o, const char *network_str, const char *netm=
ask_str, int msglevel)
+option_iroute(struct options *o, const char *network_str, const char *netm=
ask_str,
+              unsigned int msglevel)
 {
     struct iroute *ir;

@@ -1511,7 +1513,7 @@
 }

 static void
-option_iroute_ipv6(struct options *o, const char *prefix_str, int msglevel)
+option_iroute_ipv6(struct options *o, const char *prefix_str, unsigned int=
 msglevel)
 {
     struct iroute_ipv6 *ir;

@@ -2068,7 +2070,7 @@
 }

 static struct local_entry *
-alloc_local_entry(struct connection_entry *ce, const int msglevel, struct =
gc_arena *gc)
+alloc_local_entry(struct connection_entry *ce, const unsigned int msglevel=
, struct gc_arena *gc)
 {
     struct local_list *l =3D alloc_local_list_if_undef(ce, gc);
     struct local_entry *e;
@@ -2109,7 +2111,7 @@
 }

 static struct connection_entry *
-alloc_connection_entry(struct options *options, const int msglevel)
+alloc_connection_entry(struct options *options, const unsigned int msgleve=
l)
 {
     struct connection_list *l =3D alloc_connection_list_if_undef(options);
     struct connection_entry *e;
@@ -2145,7 +2147,7 @@
 }

 static struct remote_entry *
-alloc_remote_entry(struct options *options, const int msglevel)
+alloc_remote_entry(struct options *options, const unsigned int msglevel)
 {
     struct remote_list *l =3D alloc_remote_list_if_undef(options);
     struct remote_entry *e;
@@ -2699,7 +2701,7 @@

     if (!options->tls_server && !options->tls_client)
     {
-        int msglevel =3D M_USAGE;
+        unsigned int msglevel =3D M_USAGE;
         if (options->allow_deprecated_insecure_static_crypto)
         {
             msglevel =3D M_INFO;
@@ -4571,8 +4573,9 @@
 }

 static void
-options_warning_safe_scan2(const int msglevel, const int delim, const bool=
 report_inconsistent,
-                           const char *p1, const struct buffer *b2_src, co=
nst char *b1_name,
+options_warning_safe_scan2(const unsigned int msglevel, const int delim,
+                           const bool report_inconsistent, const char *p1,
+                           const struct buffer *b2_src, const char *b1_nam=
e,
                            const char *b2_name)
 {
     /* We will stop sending 'key-method', 'keydir', 'proto' and 'tls-auth'=
 in
@@ -4624,9 +4627,9 @@
 }
=20
 static void
-options_warning_safe_scan1(const int msglevel, const int delim, const bool=
 report_inconsistent,
-                           const struct buffer *b1_src, const struct buffe=
r *b2_src,
-                           const char *b1_name, const char *b2_name)
+options_warning_safe_scan1(const unsigned int msglevel, const int delim,
+                           const bool report_inconsistent, const struct bu=
ffer *b1_src,
+                           const struct buffer *b2_src, const char *b1_nam=
e, const char *b2_name)
 {
     struct gc_arena gc =3D gc_new();
     struct buffer b =3D *b1_src;
@@ -4642,7 +4645,7 @@
 }

 static void
-options_warning_safe_ml(const int msglevel, char *actual, const char *expe=
cted, size_t actual_n)
+options_warning_safe_ml(const unsigned int msglevel, char *actual, const c=
har *expected, size_t actual_n)
 {
     struct gc_arena gc =3D gc_new();

@@ -4734,7 +4737,7 @@
  */

 int
-parse_topology(const char *str, const int msglevel)
+parse_topology(const char *str, const unsigned int msglevel)
 {
     if (streq(str, "net30"))
     {
@@ -4790,7 +4793,7 @@
 }

 bool
-auth_retry_set(const int msglevel, const char *option)
+auth_retry_set(const unsigned int msglevel, const char *option)
 {
     if (streq(option, "interact"))
     {
@@ -4947,7 +4950,7 @@

 #if 0
 static void
-ping_rec_err(int msglevel)
+ping_rec_err(unsigned int msglevel)
 {
     msg(msglevel, "only one of --ping-exit or --ping-restart options may b=
e specified");
 }
@@ -4971,7 +4974,7 @@

 int
 parse_line(const char *line, char *p[], const int n, const char *file, con=
st int line_num,
-           int msglevel, struct gc_arena *gc)
+           unsigned int msglevel, struct gc_arena *gc)
 {
     const int STATE_INITIAL =3D 0;
     const int STATE_READING_QUOTED_PARM =3D 1;
@@ -5276,24 +5279,25 @@
 }

 static void add_option(struct options *options, char *p[], bool is_inline,=
 const char *file,
-                       int line, const int level, const int msglevel,
+                       int line, const int level, const unsigned int msgle=
vel,
                        const unsigned int permission_mask, unsigned int *o=
ption_types_found,
                        struct env_set *es);

 static void remove_option(struct context *c, struct options *options, char=
 *p[], bool is_inline,
-                          const char *file, int line, const int msglevel,
+                          const char *file, int line, const unsigned int m=
sglevel,
                           const unsigned int permission_mask, unsigned int=
 *option_types_found,
                           struct env_set *es);

 static void update_option(struct context *c, struct options *options, char=
 *p[], bool is_inline,
-                          const char *file, int line, const int level, con=
st int msglevel,
+                          const char *file, int line, const int level, con=
st unsigned int msglevel,
                           const unsigned int permission_mask, unsigned int=
 *option_types_found,
                           struct env_set *es, unsigned int *update_options=
_found);

 static void
 read_config_file(struct options *options, const char *file, int level, con=
st char *top_file,
-                 const int top_line, const int msglevel, const unsigned in=
t permission_mask,
-                 unsigned int *option_types_found, struct env_set *es)
+                 const int top_line, const unsigned int msglevel,
+                 const unsigned int permission_mask, unsigned int *option_=
types_found,
+                 struct env_set *es)
 {
     const int max_recursive_levels =3D 10;
     FILE *fp;
@@ -5365,7 +5369,7 @@

 static void
 read_config_string(const char *prefix, struct options *options, const char=
 *config,
-                   const int msglevel, const unsigned int permission_mask,
+                   const unsigned int msglevel, const unsigned int permiss=
ion_mask,
                    unsigned int *option_types_found, struct env_set *es)
 {
     char line[OPTION_LINE_SIZE];
@@ -5393,7 +5397,7 @@
 }

 void
-parse_argv(struct options *options, const int argc, char *argv[], const in=
t msglevel,
+parse_argv(struct options *options, const int argc, char *argv[], const un=
signed int msglevel,
            const unsigned int permission_mask, unsigned int *option_types_=
found, struct env_set *es)
 {
     /* usage message */
@@ -5462,7 +5466,7 @@
     char line[OPTION_PARM_SIZE];
     int line_num =3D 0;
     const char *file =3D "[PUSH-OPTIONS]";
-    const int msglevel =3D D_PUSH_ERRORS | M_OPTERR;
+    const unsigned int msglevel =3D D_PUSH_ERRORS | M_OPTERR;
     unsigned int update_options_found =3D 0;

     while (buf_parse(buf, ',', line, sizeof(line)))
@@ -5519,7 +5523,7 @@
 }

 void
-options_server_import(struct options *o, const char *filename, int msgleve=
l,
+options_server_import(struct options *o, const char *filename, unsigned in=
t msglevel,
                       unsigned int permission_mask, unsigned int *option_t=
ypes_found,
                       struct env_set *es)
 {
@@ -5529,7 +5533,7 @@
 }

 void
-options_string_import(struct options *options, const char *config, const i=
nt msglevel,
+options_string_import(struct options *options, const char *config, const u=
nsigned int msglevel,
                       const unsigned int permission_mask, unsigned int *op=
tion_types_found,
                       struct env_set *es)
 {
@@ -5548,7 +5552,7 @@

 static bool
 verify_permission(const char *name, const char *file, int line, const unsi=
gned int type,
-                  const unsigned int allowed, unsigned int *found, const i=
nt msglevel,
+                  const unsigned int allowed, unsigned int *found, const u=
nsigned int msglevel,
                   struct options *options, bool is_inline)
 {
     if (!(type & allowed))
@@ -5600,7 +5604,7 @@
 #define NM_QUOTE_HINT (1 << 0)

 static bool
-no_more_than_n_args(const int msglevel, char *p[], const int max, const un=
signed int flags)
+no_more_than_n_args(const unsigned int msglevel, char *p[], const int max,=
 const unsigned int flags)
 {
     const int len =3D string_array_len((const char **)p);

@@ -5624,8 +5628,8 @@
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
@@ -5659,10 +5663,11 @@
  */
 static void
 remove_option(struct context *c, struct options *options, char *p[], bool =
is_inline,
-              const char *file, int line, const int msglevel, const unsign=
ed int permission_mask,
-              unsigned int *option_types_found, struct env_set *es)
+              const char *file, int line, const unsigned int msglevel,
+              const unsigned int permission_mask, unsigned int *option_typ=
es_found,
+              struct env_set *es)
 {
-    int msglevel_fc =3D msglevel_forward_compatible(options, msglevel);
+    unsigned int msglevel_fc =3D msglevel_forward_compatible(options, msgl=
evel);

     if (streq(p[0], "ifconfig") && !p[1])
     {
@@ -5797,11 +5802,10 @@
 #endif
     else
     {
-        int i;
-        int msglevel_unknown =3D msglevel_fc;
+        unsigned int msglevel_unknown =3D msglevel_fc;
         /* Check if an option is in --ignore-unknown-option and
          * set warning level to non fatal */
-        for (i =3D 0; options->ignore_unknown_option && options->ignore_un=
known_option[i]; i++)
+        for (int i =3D 0; options->ignore_unknown_option && options->ignor=
e_unknown_option[i]; i++)
         {
             if (streq(p[0], options->ignore_unknown_option[i]))
             {
@@ -5820,7 +5824,7 @@


 static bool
-check_route_option(struct options *options, char *p[], const int msglevel,=
 bool pull_mode)
+check_route_option(struct options *options, char *p[], const unsigned int =
msglevel, bool pull_mode)
 {
     rol_check_alloc(options);
     if (pull_mode)
@@ -5848,7 +5852,7 @@


 static bool
-check_route6_option(struct options *options, char *p[], const int msglevel=
, bool pull_mode)
+check_route6_option(struct options *options, char *p[], const unsigned int=
 msglevel, bool pull_mode)
 {
     rol6_check_alloc(options);
     if (pull_mode)
@@ -5869,7 +5873,7 @@
 }

 static bool
-check_dns_option(struct options *options, char *p[], const int msglevel, b=
ool pull_mode)
+check_dns_option(struct options *options, char *p[], const unsigned int ms=
glevel, bool pull_mode)
 {
     if (streq(p[1], "search-domains") && p[2])
     {
@@ -5989,7 +5993,7 @@
  */
 static void
 update_option(struct context *c, struct options *options, char *p[], bool =
is_inline,
-              const char *file, int line, const int level, const int msgle=
vel,
+              const char *file, int line, const int level, const unsigned =
int msglevel,
               const unsigned int permission_mask, unsigned int *option_typ=
es_found,
               struct env_set *es, unsigned int *update_options_found)
 {
@@ -6174,12 +6178,12 @@

 static void
 add_option(struct options *options, char *p[], bool is_inline, const char =
*file, int line,
-           const int level, const int msglevel, const unsigned int permiss=
ion_mask,
+           const int level, const unsigned int msglevel, const unsigned in=
t permission_mask,
            unsigned int *option_types_found, struct env_set *es)
 {
     struct gc_arena gc =3D gc_new();
     const bool pull_mode =3D BOOL_CAST(permission_mask & OPT_P_PULL_MODE);
-    int msglevel_fc =3D msglevel_forward_compatible(options, msglevel);
+    unsigned int msglevel_fc =3D msglevel_forward_compatible(options, msgl=
evel);

     ASSERT(MAX_PARMS >=3D 7);

@@ -9874,7 +9878,7 @@
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
index bb2c052..5e918bb 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -822,7 +822,7 @@
     struct pull_filter *tail;
 };

-void parse_argv(struct options *options, const int argc, char *argv[], con=
st int msglevel,
+void parse_argv(struct options *options, const int argc, char *argv[], con=
st unsigned int msglevel,
                 const unsigned int permission_mask, unsigned int *option_t=
ypes_found,
                 struct env_set *es);

@@ -888,7 +888,7 @@

 void options_detach(struct options *o);

-void options_server_import(struct options *o, const char *filename, int ms=
glevel,
+void options_server_import(struct options *o, const char *filename, unsign=
ed int msglevel,
                            unsigned int permission_mask, unsigned int *opt=
ion_types_found,
                            struct env_set *es);

@@ -897,13 +897,13 @@
 void rol_check_alloc(struct options *options);

 int parse_line(const char *line, char *p[], const int n, const char *file,=
 const int line_num,
-               int msglevel, struct gc_arena *gc);
+               unsigned int msglevel, struct gc_arena *gc);

 /*
  * parse/print topology coding
  */

-int parse_topology(const char *str, const int msglevel);
+int parse_topology(const char *str, const unsigned int msglevel);

 const char *print_topology(const int topology);

@@ -917,11 +917,11 @@

 int auth_retry_get(void);

-bool auth_retry_set(const int msglevel, const char *option);
+bool auth_retry_set(const unsigned int msglevel, const char *option);

 const char *auth_retry_print(void);

-void options_string_import(struct options *options, const char *config, co=
nst int msglevel,
+void options_string_import(struct options *options, const char *config, co=
nst unsigned int msglevel,
                            const unsigned int permission_mask, unsigned in=
t *option_types_found,
                            struct env_set *es);

diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index a351967..eeaabe1 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -117,7 +117,7 @@
 }

 int
-positive_atoi(const char *str, int msglevel)
+positive_atoi(const char *str, unsigned int msglevel)
 {
     char *endptr;
     long long i =3D strtoll(str, &endptr, 10);
@@ -132,7 +132,7 @@
 }

 bool
-positive_atoll(const char *str, int64_t *value, const char *name, int msgl=
evel)
+positive_atoll(const char *str, int64_t *value, const char *name, unsigned=
 int msglevel)
 {
     char *endptr;
     long long ll =3D strtoll(str, &endptr, 10);
@@ -148,7 +148,7 @@
 }

 int
-atoi_warn(const char *str, int msglevel)
+atoi_warn(const char *str, unsigned int msglevel)
 {
     char *endptr;
     long long i =3D strtoll(str, &endptr, 10);
@@ -165,10 +165,11 @@
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wconversion"
+#pragma GCC diagnostic ignored "-Wsign-conversion"
 #endif

 bool
-atoi_constrained(const char *str, int *value, const char *name, int min, i=
nt max, int msglevel)
+atoi_constrained(const char *str, int *value, const char *name, int min, i=
nt max, unsigned int msglevel)
 {
     ASSERT(min < max);

diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 45417d9..15a9a28 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -37,7 +37,7 @@
  * Converts a str to a positive number if the string represents a postive
  * integer number. Otherwise print a warning with msglevel and return 0
  */
-int positive_atoi(const char *str, int msglevel);
+int positive_atoi(const char *str, unsigned int msglevel);

 /**
  * Converts a str to an integer if the string can be represented as an
@@ -48,13 +48,13 @@
  *
  * @return \c true if the integer has been parsed and stored in value, \c =
false otherwise
  */
-bool positive_atoll(const char *str, int64_t *value, const char *name, int=
 msglevel);
+bool positive_atoll(const char *str, int64_t *value, const char *name, uns=
igned int msglevel);

 /**
  * Converts a str to an integer if the string can be represented as an
  * integer number. Otherwise print a warning with \p msglevel and return 0
  */
-int atoi_warn(const char *str, int msglevel);
+int atoi_warn(const char *str, unsigned int msglevel);

 /**
  * Converts a str to an integer if the string can be represented as an
@@ -66,7 +66,7 @@
  * @return \c true if the integer has been parsed and stored in value, \c =
false otherwise
  */
 bool atoi_constrained(const char *str, int *value, const char *name, int m=
in, int max,
-                      int msglevel);
+                      unsigned int msglevel);

 /**
  * Filter an option line by all pull filters.
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 0b33c9c..63a4cae 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -53,15 +53,15 @@
 #define SEQ_EXPIRED ((time_t)1)

 #ifdef ENABLE_DEBUG
-static void packet_id_debug_print(int msglevel, const struct packet_id_rec=
 *p,
+static void packet_id_debug_print(unsigned int msglevel, const struct pack=
et_id_rec *p,
                                   const struct packet_id_net *pin, const c=
har *message,
                                   packet_id_print_type value);

 #endif /* ENABLE_DEBUG */

 static inline void
-packet_id_debug(int msglevel, const struct packet_id_rec *p, const struct =
packet_id_net *pin,
-                const char *message, uint64_t value)
+packet_id_debug(unsigned int msglevel, const struct packet_id_rec *p,
+                const struct packet_id_net *pin, const char *message, uint=
64_t value)
 {
 #ifdef ENABLE_DEBUG
     if (unlikely(check_debug_level(msglevel)))
@@ -578,7 +578,8 @@
 #ifdef ENABLE_DEBUG

 static void
-packet_id_debug_print(int msglevel, const struct packet_id_rec *p, const s=
truct packet_id_net *pin,
+packet_id_debug_print(unsigned int msglevel, const struct packet_id_rec *p,
+                      const struct packet_id_net *pin,
                       const char *message, packet_id_print_type value)
 {
     struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index ea76a08..8223a2c 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -50,7 +50,7 @@
 static struct plugin_common *static_plugin_common =3D NULL; /* GLOBAL */

 static void
-plugin_show_string_array(int msglevel, const char *name, const char *array=
[])
+plugin_show_string_array(unsigned int msglevel, const char *name, const ch=
ar *array[])
 {
     int i;
     for (i =3D 0; array[i]; ++i)
@@ -63,7 +63,7 @@
 }

 static void
-plugin_show_args_env(int msglevel, const char *argv[], const char *envp[])
+plugin_show_args_env(unsigned int msglevel, const char *argv[], const char=
 *envp[])
 {
     if (check_debug_level(msglevel))
     {
@@ -184,7 +184,7 @@

 #ifndef ENABLE_SMALL
 void
-plugin_option_list_print(const struct plugin_option_list *list, int msglev=
el)
+plugin_option_list_print(const struct plugin_option_list *list, unsigned i=
nt msglevel)
 {
     int i;
     struct gc_arena gc =3D gc_new();
@@ -995,7 +995,7 @@

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
index 63999b6..91d3fba 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -111,7 +111,7 @@
 bool plugin_option_list_add(struct plugin_option_list *list, char **p, str=
uct gc_arena *gc);

 #ifndef ENABLE_SMALL
-void plugin_option_list_print(const struct plugin_option_list *list, int m=
sglevel);
+void plugin_option_list_print(const struct plugin_option_list *list, unsig=
ned int msglevel);

 #endif

@@ -136,7 +136,7 @@
 void plugin_return_free(struct plugin_return *pr);

 #ifdef ENABLE_DEBUG
-void plugin_return_print(const int msglevel, const char *prefix, const str=
uct plugin_return *pr);
+void plugin_return_print(const unsigned int msglevel, const char *prefix, =
const struct plugin_return *pr);

 #endif

diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index fde6cea..0e95c5e 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -114,7 +114,7 @@
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
@@ -521,7 +521,7 @@
 }

 static void
-ifconfig_pool_msg(const struct ifconfig_pool *pool, int msglevel)
+ifconfig_pool_msg(const struct ifconfig_pool *pool, unsigned int msglevel)
 {
     struct status_output *so =3D status_open(NULL, 0, msglevel, NULL, 0);
     ASSERT(so);
diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
index 6cecef0..9c69512 100644
--- a/src/openvpn/pool.h
+++ b/src/openvpn/pool.h
@@ -78,7 +78,7 @@

 void ifconfig_pool_free(struct ifconfig_pool *pool);

-bool ifconfig_pool_verify_range(const int msglevel, const in_addr_t start,=
 const in_addr_t end);
+bool ifconfig_pool_verify_range(const unsigned int msglevel, const in_addr=
_t start, const in_addr_t end);

 ifconfig_pool_handle ifconfig_pool_acquire(struct ifconfig_pool *pool, in_=
addr_t *local,
                                            in_addr_t *remote, struct in6_a=
ddr *remote_ipv6,
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 671b015..d4019e5 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -373,8 +373,8 @@
  *
  * @return true on success, false on failure.
  */
-static bool push_option_fmt(struct gc_arena *gc, struct push_list *push_li=
st, int msglevel,
-                            const char *fmt, ...)
+static bool push_option_fmt(struct gc_arena *gc, struct push_list *push_li=
st,
+                            unsigned int msglevel, const char *fmt, ...)
 #ifdef __GNUC__
 #if __USE_MINGW_ANSI_STDIO
     __attribute__((format(gnu_printf, 4, 5)))
@@ -857,7 +857,7 @@

 static void
 push_option_ex(struct gc_arena *gc, struct push_list *push_list, const cha=
r *opt, bool enable,
-               int msglevel)
+               unsigned int msglevel)
 {
     if (!string_class(opt, CC_ANY, CC_COMMA))
     {
@@ -885,7 +885,7 @@
 }

 void
-push_option(struct options *o, const char *opt, int msglevel)
+push_option(struct options *o, const char *opt, unsigned int msglevel)
 {
     push_option_ex(&o->gc, &o->push_list, opt, true, msglevel);
 }
@@ -906,7 +906,7 @@
 }

 void
-push_options(struct options *o, char **p, int msglevel, struct gc_arena *g=
c)
+push_options(struct options *o, char **p, unsigned int msglevel, struct gc=
_arena *gc)
 {
     const char **argv =3D make_extended_arg_array(p, false, gc);
     char *opt =3D print_argv(argv, gc, 0);
@@ -914,8 +914,8 @@
 }

 static bool
-push_option_fmt(struct gc_arena *gc, struct push_list *push_list, int msgl=
evel, const char *format,
-                ...)
+push_option_fmt(struct gc_arena *gc, struct push_list *push_list,
+                unsigned int msglevel, const char *format, ...)
 {
     va_list arglist;
     char tmp[256] =3D { 0 };
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 8ffd0c2..a13e24f 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -99,9 +99,9 @@

 void clone_push_list(struct options *o);

-void push_option(struct options *o, const char *opt, int msglevel);
+void push_option(struct options *o, const char *opt, unsigned int msglevel=
);

-void push_options(struct options *o, char **p, int msglevel, struct gc_are=
na *gc);
+void push_options(struct options *o, char **p, unsigned int msglevel, stru=
ct gc_arena *gc);

 void push_reset(struct options *o);

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d3d2954..72e763d 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1228,28 +1228,28 @@
 }

 static void
-print_route_option(const struct route_option *ro, int level)
+print_route_option(const struct route_option *ro, unsigned int msglevel)
 {
-    msg(level, "  route %s/%s/%s/%s", show_opt(ro->network), show_opt(ro->=
netmask),
+    msg(msglevel, "  route %s/%s/%s/%s", show_opt(ro->network), show_opt(r=
o->netmask),
         show_opt(ro->gateway), show_opt(ro->metric));
 }

 void
-print_route_options(const struct route_option_list *rol, int level)
+print_route_options(const struct route_option_list *rol, unsigned int msgl=
evel)
 {
     struct route_option *ro;
     if (rol->flags & RG_ENABLE)
     {
-        msg(level, "  [redirect_default_gateway local=3D%d]", (rol->flags =
& RG_LOCAL) !=3D 0);
+        msg(msglevel, "  [redirect_default_gateway local=3D%d]", (rol->fla=
gs & RG_LOCAL) !=3D 0);
     }
     for (ro =3D rol->routes; ro; ro =3D ro->next)
     {
-        print_route_option(ro, level);
+        print_route_option(ro, msglevel);
     }
 }

 void
-print_default_gateway(const int msglevel, const struct route_gateway_info =
*rgi,
+print_default_gateway(const unsigned int msglevel, const struct route_gate=
way_info *rgi,
                       const struct route_ipv6_gateway_info *rgi6)
 {
     struct gc_arena gc =3D gc_new();
@@ -1323,23 +1323,23 @@
 #endif /* ifndef ENABLE_SMALL */

 static void
-print_route(const struct route_ipv4 *r, int level)
+print_route(const struct route_ipv4 *r, unsigned int msglevel)
 {
     struct gc_arena gc =3D gc_new();
     if (r->flags & RT_DEFINED)
     {
-        msg(level, "%s", route_string(r, &gc));
+        msg(msglevel, "%s", route_string(r, &gc));
     }
     gc_free(&gc);
 }

 void
-print_routes(const struct route_list *rl, int level)
+print_routes(const struct route_list *rl, unsigned int msglevel)
 {
     struct route_ipv4 *r;
     for (r =3D rl->routes; r; r =3D r->next)
     {
-        print_route(r, level);
+        print_route(r, msglevel);
     }
 }

@@ -3067,18 +3067,18 @@
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
index 9b6a47e..b8c8244 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -356,7 +356,7 @@
 void get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi, const s=
truct in6_addr *dest,
                               openvpn_net_ctx_t *ctx);

-void print_default_gateway(const int msglevel, const struct route_gateway_=
info *rgi,
+void print_default_gateway(const unsigned int msglevel, const struct route=
_gateway_info *rgi,
                            const struct route_ipv6_gateway_info *rgi6);

 /*
@@ -371,15 +371,15 @@
 int test_local_addr(const in_addr_t addr, const struct route_gateway_info =
*rgi);

 #ifndef ENABLE_SMALL
-void print_route_options(const struct route_option_list *rol, int level);
+void print_route_options(const struct route_option_list *rol, unsigned int=
 msglevel);

 #endif

-void print_routes(const struct route_list *rl, int level);
+void print_routes(const struct route_list *rl, unsigned int msglevel);

 #ifdef _WIN32

-void show_routes(int msglev);
+void show_routes(unsigned int msglevel);

 bool test_routes(const struct route_list *rl, const struct tuntap *tt);

diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index 4a1ef22..942434c 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -107,7 +107,7 @@

 #ifndef WIN32
 bool
-openvpn_waitpid_check(pid_t pid, const char *msg_prefix, int msglevel)
+openvpn_waitpid_check(pid_t pid, const char *msg_prefix, unsigned int msgl=
evel)
 {
     if (pid =3D=3D 0)
     {
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index afd1b88..222272c 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -71,13 +71,13 @@
  * This function is currently not implemented for Windows as the helper
  * macros used by this function are not available.
  *
- * @param pid               pid of the process to be checked
+ * @param pid            pid of the process to be checked
  * @param msg_prefix     prefixed of the message that be printed
- * @param msglevel          msglevel of the messages to be printed
- * @return                  true if the process is still running, false if
- *                          an error condition occurred
+ * @param msglevel       msglevel of the messages to be printed
+ * @return               true if the process is still running, false if
+ *                       an error condition occurred
  */
-bool openvpn_waitpid_check(pid_t pid, const char *msg_prefix, int msglevel=
);
+bool openvpn_waitpid_check(pid_t pid, const char *msg_prefix, unsigned int=
 msglevel);

 #endif

diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index ecea635..35c2249 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -287,7 +287,7 @@
 }

 void
-print_signal(const struct signal_info *si, const char *title, int msglevel)
+print_signal(const struct signal_info *si, const char *title, unsigned int=
 msglevel)
 {
     if (si)
     {
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index 7e5dd9f..06558d7 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -66,7 +66,7 @@

 void restore_signal_state(void);

-void print_signal(const struct signal_info *si, const char *title, int msg=
level);
+void print_signal(const struct signal_info *si, const char *title, unsigne=
d int msglevel);

 void print_status(struct context *c, struct status_output *so);

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 248c690..6f73514 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -83,7 +83,7 @@
 static int
 get_addr_generic(sa_family_t af, unsigned int flags, const char *hostname,=
 void *network,
                  unsigned int *netbits, int resolve_retry_seconds, struct =
signal_info *sig_info,
-                 int msglevel)
+                 unsigned int msglevel)
 {
     char *endp, *sep, *var_host =3D NULL;
     struct addrinfo *ai =3D NULL;
@@ -216,7 +216,8 @@
 }

 bool
-get_ipv6_addr(const char *hostname, struct in6_addr *network, unsigned int=
 *netbits, int msglevel)
+get_ipv6_addr(const char *hostname, struct in6_addr *network, unsigned int=
 *netbits,
+              unsigned int msglevel)
 {
     if (get_addr_generic(AF_INET6, GETADDR_RESOLVE, hostname, network, net=
bits, 0, NULL, msglevel)
         < 0)
@@ -1521,7 +1522,7 @@
 linksock_print_addr(struct link_socket *sock)
 {
     struct gc_arena gc =3D gc_new();
-    const int msglevel =3D (sock->mode =3D=3D LS_MODE_TCP_ACCEPT_FROM) ? D=
_INIT_MEDIUM : M_INFO;
+    const unsigned int msglevel =3D (sock->mode =3D=3D LS_MODE_TCP_ACCEPT_=
FROM) ? D_INIT_MEDIUM : M_INFO;

     /* print local address */
     if (sock->bind_local)
diff --git a/src/openvpn/socket_util.c b/src/openvpn/socket_util.c
index 9b7312d..454b151 100644
--- a/src/openvpn/socket_util.c
+++ b/src/openvpn/socket_util.c
@@ -541,7 +541,7 @@
     struct addrinfo hints;
     int status;
     struct signal_info sigrec =3D { 0 };
-    int msglevel =3D (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
+    unsigned int msglevel =3D (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLV=
E_ERRORS;
     struct gc_arena gc =3D gc_new();
     const char *print_hostname;
     const char *print_servname;
@@ -604,7 +604,7 @@
         int resolve_retries =3D
             (flags & GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) =
/ fail_wait_interval);
         const char *fmt;
-        int level =3D 0;
+        unsigned int level =3D 0;

         /* this is not a numeric IP, therefore force resolution using the
          * provided ai_family */
@@ -739,7 +739,7 @@
 done:
     if (sig_info && sig_info->signal_received)
     {
-        int level =3D 0;
+        unsigned int level =3D 0;
         if (flags & GETADDR_FATAL_ON_SIGNAL)
         {
             level =3D M_FATAL;
diff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h
index 361edff..8a30527 100644
--- a/src/openvpn/socket_util.h
+++ b/src/openvpn/socket_util.h
@@ -142,7 +142,7 @@
  * Translate an IPv6 addr or hostname from string form to in6_addr
  */
 bool get_ipv6_addr(const char *hostname, struct in6_addr *network, unsigne=
d int *netbits,
-                   int msglevel);
+                   unsigned int msglevel);

 int openvpn_getaddrinfo(unsigned int flags, const char *hostname, const ch=
ar *servname,
                         int resolve_retry_seconds, struct signal_info *sig=
_info, int ai_family,
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_back=
end.h
index a0559c9..af7a08f 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -193,8 +193,8 @@
  * @param gc            Garbage collection arena for temp data
  *
  */
-void x509_track_add(const struct x509_track **ll_head, const char *name, i=
nt msglevel,
-                    struct gc_arena *gc);
+void x509_track_add(const struct x509_track **ll_head, const char *name,
+                    unsigned int msglevel, struct gc_arena *gc);

 /*
  * Save X509 fields to environment, using the naming convention:
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index a2c702d..2ea410d 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -359,7 +359,7 @@
 }

 void
-x509_track_add(const struct x509_track **ll_head, const char *name, int ms=
glevel,
+x509_track_add(const struct x509_track **ll_head, const char *name, unsign=
ed int msglevel,
                struct gc_arena *gc)
 {
     struct x509_track *xt;
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 122101c..e3c18a4 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -414,7 +414,7 @@
  */

 void
-x509_track_add(const struct x509_track **ll_head, const char *name, int ms=
glevel,
+x509_track_add(const struct x509_track **ll_head, const char *name, unsign=
ed int msglevel,
                struct gc_arena *gc)
 {
     struct x509_track *xt;
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index fbd2168..a9f9498 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -235,14 +235,13 @@

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
index 0c7a869..25e1663 100644
--- a/src/openvpn/status.h
+++ b/src/openvpn/status.h
@@ -53,6 +53,7 @@

     char *filename;
     int fd;
+    /* NB: -1 is used to indicate that output should only go to the file */
     int msglevel;
     const struct virtual_output *vout;

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index d299e81..308a283 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -105,9 +105,9 @@
 static void netsh_set_dns6_servers(const struct in6_addr *addr_list, const=
 int addr_len,
                                    DWORD adapter_index);

-static void netsh_command(const struct argv *a, int n, int msglevel);
+static void netsh_command(const struct argv *a, int n, unsigned int msglev=
el);

-static void exec_command(const char *prefix, const struct argv *a, int n, =
int msglevel);
+static void exec_command(const char *prefix, const struct argv *a, int n, =
unsigned int msglevel);

 static const char *netsh_get_id(const char *dev_node, struct gc_arena *gc);

@@ -4035,7 +4035,7 @@
 }

 void
-show_tap_win_adapters(int msglev, int warnlev)
+show_tap_win_adapters(unsigned int msglevel, unsigned int warnlevel)
 {
     struct gc_arena gc =3D gc_new();

@@ -4052,7 +4052,7 @@
     const struct tap_reg *tap_reg =3D get_tap_reg(&gc);
     const struct panel_reg *panel_reg =3D get_panel_reg(&gc);

-    msg(msglev, "Available adapters [name, GUID, driver]:");
+    msg(msglevel, "Available adapters [name, GUID, driver]:");

     /* loop through each TAP-Windows adapter registry entry */
     for (tr =3D tap_reg; tr !=3D NULL; tr =3D tr->next)
@@ -4064,7 +4064,7 @@
         {
             if (!strcmp(tr->guid, pr->guid))
             {
-                msg(msglev, "'%s' %s %s", pr->name, tr->guid,
+                msg(msglevel, "'%s' %s %s", pr->name, tr->guid,
                     print_tun_backend_driver(tr->windows_driver));
                 ++links;
             }
@@ -4079,7 +4079,7 @@
             /* a TAP adapter exists without a link from the network
              * connections control panel */
             warn_panel_null =3D true;
-            msg(msglev, "[NULL] %s", tr->guid);
+            msg(msglevel, "[NULL] %s", tr->guid);
         }
     }

@@ -4098,18 +4098,18 @@
     /* warn on registry inconsistencies */
     if (warn_tap_dup)
     {
-        msg(warnlev, "WARNING: Some TAP-Windows adapters have duplicate GU=
IDs");
+        msg(warnlevel, "WARNING: Some TAP-Windows adapters have duplicate =
GUIDs");
     }
=20
     if (warn_panel_dup)
     {
-        msg(warnlev,
+        msg(warnlevel,
             "WARNING: Some TAP-Windows adapters have duplicate links from =
the Network Connections control panel");
     }

     if (warn_panel_null)
     {
-        msg(warnlev,
+        msg(warnlevel,
             "WARNING: Some TAP-Windows adapters have no link from the Netw=
ork Connections control panel");
     }

@@ -4839,31 +4839,31 @@
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
@@ -4872,12 +4872,12 @@
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
@@ -4885,7 +4885,7 @@
         /* find index in the linked list */
         for (a =3D ai; a !=3D NULL; a =3D a->Next)
         {
-            show_adapter(msglev, a, &gc);
+            show_adapter(msglevel, a, &gc);
         }
     }
     gc_free(&gc);
@@ -5082,7 +5082,7 @@
 }

 static void
-exec_command(const char *prefix, const struct argv *a, int n, int msglevel)
+exec_command(const char *prefix, const struct argv *a, int n, unsigned int=
 msglevel)
 {
     int i;
     for (i =3D 0; i < n; ++i)
@@ -5103,7 +5103,7 @@
 }

 static void
-netsh_command(const struct argv *a, int n, int msglevel)
+netsh_command(const struct argv *a, int n, unsigned int msglevel)
 {
     exec_command("NETSH", a, n, msglevel);
 }
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 06fc729..fd2d270 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -445,9 +445,9 @@
 DWORD adapter_index_of_ip(const IP_ADAPTER_INFO *list, const in_addr_t ip,=
 int *count,
                           in_addr_t *netmask);

-void show_tap_win_adapters(int msglev, int warnlev);
+void show_tap_win_adapters(unsigned int msglevel, unsigned int warnlevel);

-void show_adapters(int msglev);
+void show_adapters(unsigned int msglevel);

 void tap_allow_nonadmin_access(const char *dev_node);

diff --git a/tests/unit_tests/openvpn/mock_ssl_dependencies.c b/tests/unit_=
tests/openvpn/mock_ssl_dependencies.c
index 7333c47..3abab43 100644
--- a/tests/unit_tests/openvpn/mock_ssl_dependencies.c
+++ b/tests/unit_tests/openvpn/mock_ssl_dependencies.c
@@ -38,7 +38,7 @@

 int
 parse_line(const char *line, char **p, const int n, const char *file, cons=
t int line_num,
-           int msglevel, struct gc_arena *gc)
+           unsigned int msglevel, struct gc_arena *gc)
 {
     /* Dummy function to get the linker happy, should never be called */
     assert_true(false);
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvp=
n/test_argv.c
index a65857b..a4f9e84 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -23,7 +23,7 @@

 int
 __wrap_parse_line(const char *line, char **p, const int n, const char *fil=
e, const int line_num,
-                  int msglevel, struct gc_arena *gc)
+                  unsigned int msglevel, struct gc_arena *gc)
 {
     p[0] =3D PATH1 PATH2;
     p[1] =3D PARAM1;
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index 3433b73..5348e53 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -348,7 +348,7 @@
     assert_false(valid_integer("-2147483653", false));


-    int msglevel =3D D_LOW;
+    unsigned int msglevel =3D D_LOW;
     int saved_log_level =3D mock_get_debug_level();
     mock_set_debug_level(D_LOW);

diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/open=
vpn/test_pkcs11.c
index 9ba6cfc..1519fd6 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -59,7 +59,7 @@
 /* stubs for some unused functions instead of pulling in too many dependen=
cies */
 int
 parse_line(const char *line, char **p, const int n, const char *file, cons=
t int line_num,
-           int msglevel, struct gc_arena *gc)
+           unsigned int msglevel, struct gc_arena *gc)
 {
     assert_true(0);
     return 0;
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index 5122766..f349824 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -45,7 +45,7 @@

 int
 parse_line(const char *line, char **p, const int n, const char *file, cons=
t int line_num,
-           int msglevel, struct gc_arena *gc)
+           unsigned int msglevel, struct gc_arena *gc)
 {
     /* Dummy function to get the linker happy, should never be called */
     assert_true(false);
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_t=
ests/openvpn/test_push_update_msg.c
index 87329b1..8948f7b 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -111,7 +111,7 @@

 #ifndef ENABLE_MANAGEMENT
 bool
-send_control_channel_string(struct context *c, const char *str, int msglev=
el)
+send_control_channel_string(struct context *c, const char *str, unsigned i=
nt msglevel)
 {
     return true;
 }
@@ -120,7 +120,7 @@
 int i;
=20
 bool
-send_control_channel_string(struct context *c, const char *str, int msglev=
el)
+send_control_channel_string(struct context *c, const char *str, unsigned i=
nt msglevel)
 {
     if (res && res[i] && strcmp(res[i], str))
     {
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
index 532bfcd..e2b2e38 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -98,7 +98,7 @@

 int
 __wrap_parse_line(const char *line, char **p, const int n, const char *fil=
e, const int line_num,
-                  int msglevel, struct gc_arena *gc)
+                  unsigned int msglevel, struct gc_arena *gc)
 {
     p[0] =3D PATH1 PATH2;
     p[1] =3D PARAM1;
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index 460b37f..30b0a73 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -73,7 +73,7 @@
 /* stubs for some unused functions instead of pulling in too many dependen=
cies */
 int
 parse_line(const char *line, char **p, const int n, const char *file, cons=
t int line_num,
-           int msglevel, struct gc_arena *gc)
+           unsigned int msglevel, struct gc_arena *gc)
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
Gerrit-PatchSet: 14
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-MessageType: newpatchset

--PIMVmQXh28k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #14</strong> to this change.</p>=
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1110?usp=3Demail">View =
Change</a></p><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">Clean up the big msglevel type confusion<br><br>msglevel was def=
initely unsigned as the first<br>argument to msg(), but many parts of the c=
ode<br>had it as signed. So this produced a LOT of<br>warnings when enablin=
g -Wsign-conversion.<br><br>There is one exception in struct status_output<=
br>where -1 is a valid value in the API. Only<br>positive values are transl=
ated into standard<br>message levels.<br><br>Change-Id: Id492cb774c6d022d06=
bb3cf5fec2a4bdd410e619<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2716...=
1...&gt;<br>---<br>M src/openvpn/argv.c<br>M src/openvpn/argv.h<br>M src/op=
envpn/buffer.c<br>M src/openvpn/clinat.c<br>M src/openvpn/clinat.h<br>M src=
/openvpn/comp.c<br>M src/openvpn/comp.h<br>M src/openvpn/crypto.c<br>M src/=
openvpn/crypto.h<br>M src/openvpn/dco.c<br>M src/openvpn/dco.h<br>M src/ope=
nvpn/dco_freebsd.c<br>M src/openvpn/dco_linux.c<br>M src/openvpn/dco_win.c<=
br>M src/openvpn/dns.c<br>M src/openvpn/dns.h<br>M src/openvpn/env_set.c<br=
>M src/openvpn/env_set.h<br>M src/openvpn/error.c<br>M src/openvpn/error.h<=
br>M src/openvpn/forward.c<br>M src/openvpn/forward.h<br>M src/openvpn/init=
.c<br>M src/openvpn/init.h<br>M src/openvpn/manage.h<br>M src/openvpn/mtu.c=
<br>M src/openvpn/mtu.h<br>M src/openvpn/multi.c<br>M src/openvpn/options.c=
<br>M src/openvpn/options.h<br>M src/openvpn/options_util.c<br>M src/openvp=
n/options_util.h<br>M src/openvpn/packet_id.c<br>M src/openvpn/plugin.c<br>=
M src/openvpn/plugin.h<br>M src/openvpn/pool.c<br>M src/openvpn/pool.h<br>M=
 src/openvpn/push.c<br>M src/openvpn/push.h<br>M src/openvpn/route.c<br>M s=
rc/openvpn/route.h<br>M src/openvpn/run_command.c<br>M src/openvpn/run_comm=
and.h<br>M src/openvpn/sig.c<br>M src/openvpn/sig.h<br>M src/openvpn/socket=
.c<br>M src/openvpn/socket_util.c<br>M src/openvpn/socket_util.h<br>M src/o=
penvpn/ssl_verify_backend.h<br>M src/openvpn/ssl_verify_mbedtls.c<br>M src/=
openvpn/ssl_verify_openssl.c<br>M src/openvpn/status.c<br>M src/openvpn/sta=
tus.h<br>M src/openvpn/tun.c<br>M src/openvpn/tun.h<br>M tests/unit_tests/o=
penvpn/mock_ssl_dependencies.c<br>M tests/unit_tests/openvpn/test_argv.c<br=
>M tests/unit_tests/openvpn/test_misc.c<br>M tests/unit_tests/openvpn/test_=
pkcs11.c<br>M tests/unit_tests/openvpn/test_pkt.c<br>M tests/unit_tests/ope=
nvpn/test_push_update_msg.c<br>M tests/unit_tests/openvpn/test_tls_crypt.c<=
br>M tests/unit_tests/openvpn/test_user_pass.c<br>63 files changed, 238 ins=
ertions(+), 229 deletions(-)<br><br></pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29=
418/openvpn refs/changes/10/1110/14</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/argv.c=
 b/src/openvpn/argv.c</span><br><span>index 903fc0a..55deef5 100644</span><=
br><span>--- a/src/openvpn/argv.c</span><br><span>+++ b/src/openvpn/argv.c<=
/span><br><span>@@ -235,14 +235,14 @@</span><br><span> /**</span><br><span>=
  *  Write the arguments stored in a struct argv via the msg() command.</sp=
an><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  @=
param msglev  Integer with the message level used by msg().</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *  @param a       Valid pointer to t=
he struct argv with the arguments to write.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  @param msglevel  Integer with the message level=
 used by msg().</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
@param a         Valid pointer to the struct argv with the arguments to wri=
te.</span><br><span>  */</span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-argv_msg(const int msglev, const struct argv *a)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+argv_msg(const unsign=
ed int msglevel, const struct argv *a)</span><br><span> {</span><br><span> =
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    msg(msglev, &quot;%s&quot;, argv_str(a, &amp;gc, 0));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(msglevel, &quo=
t;%s&quot;, argv_str(a, &amp;gc, 0));</span><br><span>     gc_free(&amp;gc)=
;</span><br><span> }</span><br><span> </span><br><span>@@ -250,16 +250,16 @=
@</span><br><span>  *  Similar to argv_msg() but prefixes the messages bein=
g written with a</span><br><span>  *  given string.</span><br><span>  *</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- *  @param msglev  Intege=
r with the message level used by msg().</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *  @param a       Valid pointer to the struct argv with =
the arguments to write</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- *  @param prefix  Valid pointer to the prefix string</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  @param msglevel  Integer with the me=
ssage level used by msg().</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  @param a         Valid pointer to the struct argv with the argum=
ents to write</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @p=
aram prefix    Valid pointer to the prefix string</span><br><span>  *</span=
><br><span>  */</span><br><span> void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-argv_msg_prefix(const int msglev, const struct argv *a, con=
st char *prefix)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+arg=
v_msg_prefix(const unsigned int msglevel, const struct argv *a, const char =
*prefix)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_=
new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(msglev,=
 &quot;%s: %s&quot;, prefix, argv_str(a, &amp;gc, 0));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    msg(msglevel, &quot;%s: %s&quot;, pr=
efix, argv_str(a, &amp;gc, 0));</span><br><span>     gc_free(&amp;gc);</spa=
n><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/a=
rgv.h b/src/openvpn/argv.h</span><br><span>index 056fe31..724b827 100644</s=
pan><br><span>--- a/src/openvpn/argv.h</span><br><span>+++ b/src/openvpn/ar=
gv.h</span><br><span>@@ -47,9 +47,9 @@</span><br><span> </span><br><span> s=
truct argv argv_insert_head(const struct argv *a, const char *head);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void argv_=
msg(const int msglev, const struct argv *a);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void argv_msg(const unsigned int msglevel, const s=
truct argv *a);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void argv_msg_prefix(const int msglev, const struct argv *a, co=
nst char *prefix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid argv_msg_prefix(const unsigned int msglevel, const struct argv *a, cons=
t char *prefix);</span><br><span> </span><br><span> void argv_parse_cmd(str=
uct argv *a, const char *s);</span><br><span> </span><br><span>diff --git a=
/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span>index 0f0d17e.=
.b6d6669 100644</span><br><span>--- a/src/openvpn/buffer.c</span><br><span>=
+++ b/src/openvpn/buffer.c</span><br><span>@@ -1127,7 +1127,7 @@</span><br>=
<span> {</span><br><span>     if (buf &amp;&amp; buf-&gt;len)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int =
msglevel =3D D_ALIGN_DEBUG;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        unsigned int msglevel =3D D_ALIGN_DEBUG;</span><br><span>  =
       const unsigned int u =3D (unsigned int)BPTR(buf);</span><br><span> <=
/span><br><span>         if (u &amp; (PAYLOAD_ALIGN - 1))</span><br><span>d=
iff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c</span><br><span>ind=
ex 48a2057..2d21daf 100644</span><br><span>--- a/src/openvpn/clinat.c</span=
><br><span>+++ b/src/openvpn/clinat.c</span><br><span>@@ -47,7 +47,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-print_client_nat_list(const struct client=
_nat_option_list *list, int msglevel)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+print_client_nat_list(const struct client_nat_option_list=
 *list, unsigned int msglevel)</span><br><span> {</span><br><span>     stru=
ct gc_arena gc =3D gc_new();</span><br><span>     int i;</span><br><span>@@=
 -101,7 +101,7 @@</span><br><span> void</span><br><span> add_client_nat_to_=
option_list(struct client_nat_option_list *dest, const char *type,</span><b=
r><span>                               const char *network, const char *net=
mask, const char *foreign_network,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                              int msglevel)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                              unsigned=
 int msglevel)</span><br><span> {</span><br><span>     struct client_nat_en=
try e;</span><br><span>     bool ok;</span><br><span>@@ -159,7 +159,7 @@</s=
pan><br><span> #endif</span><br><span> </span><br><span> static void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-print_pkt(struct openvpn_iph=
dr *iph, const char *prefix, const int direction, const int msglevel)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+print_pkt(struct openvpn_=
iphdr *iph, const char *prefix, const int direction, const unsigned int msg=
level)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_ne=
w();</span><br><span> </span><br><span>diff --git a/src/openvpn/clinat.h b/=
src/openvpn/clinat.h</span><br><span>index abfa0b7..3fcdf70 100644</span><b=
r><span>--- a/src/openvpn/clinat.h</span><br><span>+++ b/src/openvpn/clinat=
.h</span><br><span>@@ -54,11 +54,11 @@</span><br><span> void copy_client_na=
t_option_list(struct client_nat_option_list *dest,</span><br><span>        =
                          const struct client_nat_option_list *src);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void print=
_client_nat_list(const struct client_nat_option_list *list, int msglevel);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void print_client_na=
t_list(const struct client_nat_option_list *list, unsigned int msglevel);</=
span><br><span> </span><br><span> void add_client_nat_to_option_list(struct=
 client_nat_option_list *dest, const char *type,</span><br><span>          =
                          const char *network, const char *netmask,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
      const char *foreign_network, int msglevel);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                   const char=
 *foreign_network, unsigned int msglevel);</span><br><span> </span><br><spa=
n> void client_nat_transform(const struct client_nat_option_list *list, str=
uct buffer *ipbuf,</span><br><span>                           const int dir=
ection);</span><br><span>diff --git a/src/openvpn/comp.c b/src/openvpn/comp=
.c</span><br><span>index 1a2e775..305184d 100644</span><br><span>--- a/src/=
openvpn/comp.c</span><br><span>+++ b/src/openvpn/comp.c</span><br><span>@@ =
-159,7 +159,7 @@</span><br><span> #endif /* USE_COMP */</span><br><span> </=
span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-c=
heck_compression_settings_valid(struct compress_options *info, int msglevel=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_compression_=
settings_valid(struct compress_options *info, unsigned int msglevel)</span>=
<br><span> {</span><br><span>     /*</span><br><span>      * We also allow =
comp-stub-v2 here as it technically allows escaping of</span><br><span>diff=
 --git a/src/openvpn/comp.h b/src/openvpn/comp.h</span><br><span>index 0354=
896..5327eae 100644</span><br><span>--- a/src/openvpn/comp.h</span><br><spa=
n>+++ b/src/openvpn/comp.h</span><br><span>@@ -89,7 +89,7 @@</span><br><spa=
n>  * flags of allow-compression and also the whether algorithms are compil=
ed</span><br><span>  * in</span><br><span>  */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-bool check_compression_settings_valid(struct compr=
ess_options *info, int msglevel);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+bool check_compression_settings_valid(struct compress_options=
 *info, unsigned int msglevel);</span><br><span> </span><br><span> #ifdef U=
SE_COMP</span><br><span> #include &quot;buffer.h&quot;</span><br><span>diff=
 --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span>index =
1535c78..cec66da 100644</span><br><span>--- a/src/openvpn/crypto.c</span><b=
r><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -1618,7 +1618,7 @@</s=
pan><br><span> }</span><br><span> </span><br><span> int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-ascii2keydirection(int msglevel, const ch=
ar *str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ascii2keydi=
rection(unsigned int msglevel, const char *str)</span><br><span> {</span><b=
r><span>     if (!str)</span><br><span>     {</span><br><span>diff --git a/=
src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><span>index efd7f60..=
a403f32 100644</span><br><span>--- a/src/openvpn/crypto.h</span><br><span>+=
++ b/src/openvpn/crypto.h</span><br><span>@@ -618,7 +618,7 @@</span><br><sp=
an> </span><br><span> void must_have_n_keys(const char *filename, const cha=
r *option, const struct key2 *key2, int n);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-int ascii2keydirection(int msglevel=
, const char *str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
int ascii2keydirection(unsigned int msglevel, const char *str);</span><br><=
span> </span><br><span> const char *keydirection2ascii(int kd, bool remote,=
 bool humanreadable);</span><br><span> </span><br><span>diff --git a/src/op=
envpn/dco.c b/src/openvpn/dco.c</span><br><span>index 823b4f9..8f39e80 1006=
44</span><br><span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/openvp=
n/dco.c</span><br><span>@@ -233,7 +233,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> static bool</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-dco_check_option_ce(const struct connection_entry *ce, int msg=
level, int mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco=
_check_option_ce(const struct connection_entry *ce, unsigned int msglevel, =
int mode)</span><br><span> {</span><br><span>     if (ce-&gt;fragment)</spa=
n><br><span>     {</span><br><span>@@ -293,7 +293,7 @@</span><br><span> }</=
span><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-dco_check_startup_option(int msglevel, const struct option=
s *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_check_star=
tup_option(unsigned int msglevel, const struct options *o)</span><br><span>=
 {</span><br><span>     /* check if no dev name was specified at all. In th=
e case,</span><br><span>      * later logic will most likely stop OpenVPN, =
so no need to</span><br><span>@@ -430,7 +430,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-dco_check_option(int msglevel, const struct options *o)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+dco_check_option(unsigned i=
nt msglevel, const struct options *o)</span><br><span> {</span><br><span>  =
   /* At this point the ciphers have already been normalised */</span><br><=
span>     if (o-&gt;enable_ncp_fallback</span><br><span>@@ -480,7 +480,7 @@=
</span><br><span> }</span><br><span> </span><br><span> bool</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-dco_check_pull_options(int msglevel, =
const struct options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+dco_check_pull_options(unsigned int msglevel, const struct options *o)=
</span><br><span> {</span><br><span>     if (!o-&gt;use_peer_id)</span><br>=
<span>     {</span><br><span>diff --git a/src/openvpn/dco.h b/src/openvpn/d=
co.h</span><br><span>index 59acb18..7fa8055 100644</span><br><span>--- a/sr=
c/openvpn/dco.h</span><br><span>+++ b/src/openvpn/dco.h</span><br><span>@@ =
-55,7 +55,7 @@</span><br><span>  * @param msglevel      level to print mess=
ages to</span><br><span>  * @return              true if ovpn-dco is availa=
ble, false otherwise</span><br><span>  */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-bool dco_available(int msglevel);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool dco_available(unsigned int msglevel)=
;</span><br><span> </span><br><span> </span><br><span> /**</span><br><span>=
@@ -75,7 +75,7 @@</span><br><span>  * @param o         the options struct t=
hat hold the options</span><br><span>  * @return          true if no confli=
ct was detected, false otherwise</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-bool dco_check_option(int msglevel, const s=
truct options *o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ool dco_check_option(unsigned int msglevel, const struct options *o);</span=
><br><span> </span><br><span> /**</span><br><span>  * Check whether the opt=
ions struct has any further option that is not supported</span><br><span>@@=
 -87,7 +87,7 @@</span><br><span>  * @param o         the options struct tha=
t hold the options</span><br><span>  * @return          true if no conflict=
 was detected, false otherwise</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-bool dco_check_startup_option(int msglevel,=
 const struct options *o);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool dco_check_startup_option(unsigned int msglevel, const struct op=
tions *o);</span><br><span> </span><br><span> /**</span><br><span>  * Check=
 whether any of the options pushed by the server is not supported by</span>=
<br><span>@@ -98,7 +98,7 @@</span><br><span>  * @param o         the option=
s struct that hold the options</span><br><span>  * @return          true if=
 no conflict was detected, false otherwise</span><br><span>  */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-bool dco_check_pull_options(int m=
sglevel, const struct options *o);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool dco_check_pull_options(unsigned int msglevel, const str=
uct options *o);</span><br><span> </span><br><span> /**</span><br><span>  *=
 Initialize the DCO context</span><br><span>@@ -261,7 +261,7 @@</span><br><=
span> typedef void *dco_context_t;</span><br><span> </span><br><span> stati=
c inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_avai=
lable(int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
dco_available(unsigned int msglevel)</span><br><span> {</span><br><span>   =
  return false;</span><br><span> }</span><br><span>@@ -273,19 +273,19 @@</s=
pan><br><span> }</span><br><span> </span><br><span> static inline bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_check_option(int msgle=
vel, const struct options *o)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+dco_check_option(unsigned int msglevel, const struct options *o)<=
/span><br><span> {</span><br><span>     return false;</span><br><span> }</s=
pan><br><span> </span><br><span> static inline bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dco_check_startup_option(int msglevel, cons=
t struct options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+dco_check_startup_option(unsigned int msglevel, const struct options *o)</=
span><br><span> {</span><br><span>     return false;</span><br><span> }</sp=
an><br><span> </span><br><span> static inline bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-dco_check_pull_options(int msglevel, const str=
uct options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_=
check_pull_options(unsigned int msglevel, const struct options *o)</span><b=
r><span> {</span><br><span>     return false;</span><br><span> }</span><br>=
<span>diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</s=
pan><br><span>index 56a774d..cb76211 100644</span><br><span>--- a/src/openv=
pn/dco_freebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br>=
<span>@@ -663,7 +663,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_availabl=
e(int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_=
available(unsigned int msglevel)</span><br><span> {</span><br><span>     st=
ruct if_clonereq ifcr;</span><br><span>     char *buf =3D NULL;</span><br><=
span>diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><=
br><span>index 3b08f33..accd432 100644</span><br><span>--- a/src/openvpn/dc=
o_linux.c</span><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ =
-79,7 +79,7 @@</span><br><span>  * @return ID on success, negative error co=
de on error</span><br><span>  */</span><br><span> static int</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-resolve_ovpn_netlink_id(int msglevel=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+resolve_ovpn_netli=
nk_id(unsigned int msglevel)</span><br><span> {</span><br><span>     int re=
t;</span><br><span>     struct nl_sock *nl_sock =3D nl_socket_alloc();</spa=
n><br><span>@@ -1204,7 +1204,7 @@</span><br><span> }</span><br><span> </spa=
n><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_=
available(int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+dco_available(unsigned int msglevel)</span><br><span> {</span><br><span=
>     if (resolve_ovpn_netlink_id(D_DCO_DEBUG) &lt; 0)</span><br><span>    =
 {</span><br><span>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win=
.c</span><br><span>index 1dc5cf8..39a5ab6 100644</span><br><span>--- a/src/=
openvpn/dco_win.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><sp=
an>@@ -609,7 +609,7 @@</span><br><span> }</span><br><span> </span><br><span=
> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_available(i=
nt msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_ava=
ilable(unsigned int msglevel)</span><br><span> {</span><br><span>     /* tr=
y to open device by symbolic name */</span><br><span>     HANDLE h =3D Crea=
teFile(&quot;\\\\.\\ovpn-dco&quot;, GENERIC_READ | GENERIC_WRITE, 0, NULL, =
OPEN_EXISTING,</span><br><span>diff --git a/src/openvpn/dns.c b/src/openvpn=
/dns.c</span><br><span>index 5421004..6455cc9 100644</span><br><span>--- a/=
src/openvpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</span><br><span>@=
@ -200,7 +200,7 @@</span><br><span> }</span><br><span> </span><br><span> bo=
ol</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dns_options_verify(=
int msglevel, const struct dns_options *o)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+dns_options_verify(unsigned int msglevel, const stru=
ct dns_options *o)</span><br><span> {</span><br><span>     const struct dns=
_server *server =3D o-&gt;servers ? o-&gt;servers : o-&gt;servers_prepull;<=
/span><br><span>     while (server)</span><br><span>diff --git a/src/openvp=
n/dns.h b/src/openvpn/dns.h</span><br><span>index 6d97b40..833b937 100644</=
span><br><span>--- a/src/openvpn/dns.h</span><br><span>+++ b/src/openvpn/dn=
s.h</span><br><span>@@ -166,7 +166,7 @@</span><br><span>  * @param   o     =
      Pointer to the DNS options to validate</span><br><span>  * @return   =
           True if no error was found</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-bool dns_options_verify(int msglevel, =
const struct dns_options *o);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+bool dns_options_verify(unsigned int msglevel, const struct dns_o=
ptions *o);</span><br><span> </span><br><span> /**</span><br><span>  * Make=
s a deep copy of the passed DNS options.</span><br><span>diff --git a/src/o=
penvpn/env_set.c b/src/openvpn/env_set.c</span><br><span>index 6c7df8e..487=
a5e2 100644</span><br><span>--- a/src/openvpn/env_set.c</span><br><span>+++=
 b/src/openvpn/env_set.c</span><br><span>@@ -209,7 +209,7 @@</span><br><spa=
n> }</span><br><span> </span><br><span> void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-env_set_print(int msglevel, const struct env_set *es=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+env_set_print(unsi=
gned int msglevel, const struct env_set *es)</span><br><span> {</span><br><=
span>     if (check_debug_level(msglevel))</span><br><span>     {</span><br=
><span>diff --git a/src/openvpn/env_set.h b/src/openvpn/env_set.h</span><br=
><span>index 3973a4e..130de75 100644</span><br><span>--- a/src/openvpn/env_=
set.h</span><br><span>+++ b/src/openvpn/env_set.h</span><br><span>@@ -85,7 =
+85,7 @@</span><br><span> </span><br><span> const char *env_set_get(const s=
truct env_set *es, const char *name);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-void env_set_print(int msglevel, const st=
ruct env_set *es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid env_set_print(unsigned int msglevel, const struct env_set *es);</span><=
br><span> </span><br><span> /**</span><br><span>  * Write a struct env_set =
to a file. Each item on one line.</span><br><span>diff --git a/src/openvpn/=
error.c b/src/openvpn/error.c</span><br><span>index 1b98235..90c0f75 100644=
</span><br><span>--- a/src/openvpn/error.c</span><br><span>+++ b/src/openvp=
n/error.c</span><br><span>@@ -390,8 +390,8 @@</span><br><span>     bool ret=
 =3D true;</span><br><span>     if (mute_cutoff &gt; 0 &amp;&amp; !(flags &=
amp; M_NOMUTE))</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        const int mute_level =3D DECODE_MUTE_LEVEL(flags);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (mute_leve=
l &gt; 0 &amp;&amp; mute_level =3D=3D mute_category)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const unsigned int mute_level =3D=
 DECODE_MUTE_LEVEL(flags);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (mute_level =3D=3D mute_category)</span><br><span>       =
  {</span><br><span>             if (mute_count =3D=3D mute_cutoff)</span><=
br><span>             {</span><br><span>diff --git a/src/openvpn/error.h b/=
src/openvpn/error.h</span><br><span>index 8388f82..2ad2c5d 100644</span><br=
><span>--- a/src/openvpn/error.h</span><br><span>+++ b/src/openvpn/error.h<=
/span><br><span>@@ -83,22 +83,22 @@</span><br><span> </span><br><span> /* m=
sg() flags */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define M_DEBUG_LEVEL (0x0F) /* debug level mask */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define M_DEBUG_LEVEL (0x0Fu) /* =
debug level mask */</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define M_FATAL    (1 &lt;&lt; 4)  /* exit program */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#define M_NONFATAL (1 &lt;&=
lt; 5)  /* non-fatal error */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define M_WARN     (1 &lt;&lt; 6)  /* call syslog with LOG_WARNING =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define M_DEBUG    =
(1 &lt;&lt; 7)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne M_FATAL    (1u &lt;&lt; 4)  /* exit program */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define M_NONFATAL (1u &lt;&lt; 5)  /* non-fa=
tal error */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 M_WARN     (1u &lt;&lt; 6)  /* call syslog with LOG_WARNING */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define M_DEBUG    (1u &lt;&lt;=
 7)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define M_ERRNO (1 &lt;&lt; 8)         /* show errno description */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define M_ERRNO (1u &lt;&lt=
; 8)         /* show errno description */</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define M_NOMUTE       (1 &lt;&lt; 11=
) /* don&#39;t do mute processing */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define M_NOPREFIX     (1 &lt;&lt; 12) /* don&#39;t show dat=
e/time prefix */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne M_USAGE_SMALL  (1 &lt;&lt; 13) /* fatal options error, call usage_small =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define M_MSG_VIRT_=
OUT (1 &lt;&lt; 14) /* output message through msg_status_output callback */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define M_OPTERR     =
  (1 &lt;&lt; 15) /* print &quot;Options error:&quot; prefix */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define M_NOLF         (1 &lt;&lt=
; 16) /* don&#39;t print new line */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define M_NOIPREFIX    (1 &lt;&lt; 17) /* don&#39;t print in=
stance prefix */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine M_NOMUTE       (1u &lt;&lt; 11) /* don&#39;t do mute processing */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define M_NOPREFIX     =
(1u &lt;&lt; 12) /* don&#39;t show date/time prefix */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define M_USAGE_SMALL  (1u &lt;&lt; 13) =
/* fatal options error, call usage_small */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define M_MSG_VIRT_OUT (1u &lt;&lt; 14) /* output m=
essage through msg_status_output callback */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define M_OPTERR       (1u &lt;&lt; 15) /* print &=
quot;Options error:&quot; prefix */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define M_NOLF         (1u &lt;&lt; 16) /* don&#39;t print =
new line */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
M_NOIPREFIX    (1u &lt;&lt; 17) /* don&#39;t print instance prefix */</span=
><br><span> </span><br><span> /* flag combinations which are frequently use=
d */</span><br><span> #define M_ERR    (M_FATAL | M_ERRNO)</span><br><span>=
@@ -112,7 +112,7 @@</span><br><span>  * A mute level of 0 is always printed=
.</span><br><span>  */</span><br><span> #define MUTE_LEVEL_SHIFT 24</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define MUTE_LEVEL_MASK  0xFF=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MUTE_LEVEL_=
MASK  0xFFu</span><br><span> </span><br><span> #define ENCODE_MUTE_LEVEL(mu=
te_level) (((mute_level) &amp; MUTE_LEVEL_MASK) &lt;&lt; MUTE_LEVEL_SHIFT)<=
/span><br><span> #define DECODE_MUTE_LEVEL(flags)      (((flags) &gt;&gt; M=
UTE_LEVEL_SHIFT) &amp; MUTE_LEVEL_MASK)</span><br><span>diff --git a/src/op=
envpn/forward.c b/src/openvpn/forward.c</span><br><span>index e82b544..cafd=
8e75 100644</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++=
 b/src/openvpn/forward.c</span><br><span>@@ -373,7 +373,8 @@</span><br><spa=
n> #endif</span><br><span> </span><br><span> bool</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-send_control_channel_string_dowork(struct tls_s=
ession *session, const char *str, int msglevel)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+send_control_channel_string_dowork(struct tls_s=
ession *session, const char *str,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                   unsigned int msglevel)</sp=
an><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span=
><br><span>     bool stat;</span><br><span>@@ -400,7 +401,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> bool</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-send_control_channel_string(struct context *c, con=
st char *str, int msglevel)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+send_control_channel_string(struct context *c, const char *str, uns=
igned int msglevel)</span><br><span> {</span><br><span>     if (c-&gt;c2.tl=
s_multi)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/fo=
rward.h b/src/openvpn/forward.h</span><br><span>index 79d0f8b..581eae1 1006=
44</span><br><span>--- a/src/openvpn/forward.h</span><br><span>+++ b/src/op=
envpn/forward.h</span><br><span>@@ -285,7 +285,7 @@</span><br><span>  * @pa=
ram str        - The message to be sent</span><br><span>  * @param msglevel=
   - Message level to use for logging</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-bool send_control_channel_string(struc=
t context *c, const char *str, int msglevel);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool send_control_channel_string(struct context *=
c, const char *str, unsigned int msglevel);</span><br><span> </span><br><sp=
an> /*</span><br><span>  * Send a string to remote over the TLS control cha=
nnel.</span><br><span>@@ -303,7 +303,8 @@</span><br><span>  * @param msglev=
el   - Message level to use for logging</span><br><span>  */</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool send_control_=
channel_string_dowork(struct tls_session *session, const char *str, int msg=
level);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool send_co=
ntrol_channel_string_dowork(struct tls_session *session, const char *str,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                   unsigned int msglevel);</span><br><span> </span><br><spa=
n> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/init.c b/=
src/openvpn/init.c</span><br><span>index 24aebc0..e6b3b14 100644</span><br>=
<span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</sp=
an><br><span>@@ -4282,7 +4282,7 @@</span><br><span> }</span><br><span> </sp=
an><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man=
agement_show_net_callback(void *arg, const int msglevel)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+management_show_net_callback(void *arg=
, const unsigned int msglevel)</span><br><span> {</span><br><span> #ifdef _=
WIN32</span><br><span>     show_routes(msglevel);</span><br><span>diff --gi=
t a/src/openvpn/init.h b/src/openvpn/init.h</span><br><span>index a807874..=
432cf31 100644</span><br><span>--- a/src/openvpn/init.h</span><br><span>+++=
 b/src/openvpn/init.h</span><br><span>@@ -136,7 +136,7 @@</span><br><span> =
</span><br><span> void close_management(void);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-void management_show_net_callbac=
k(void *arg, const int msglevel);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+void management_show_net_callback(void *arg, const unsigned i=
nt msglevel);</span><br><span> </span><br><span> #endif</span><br><span> </=
span><br><span>diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h</sp=
an><br><span>index 7c189ba..4b62b04 100644</span><br><span>--- a/src/openvp=
n/manage.h</span><br><span>+++ b/src/openvpn/manage.h</span><br><span>@@ -1=
76,7 +176,7 @@</span><br><span>     unsigned int flags;</span><br><span> </=
span><br><span>     void (*status)(void *arg, const int version, struct sta=
tus_output *so);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    v=
oid (*show_net)(void *arg, const int msglevel);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    void (*show_net)(void *arg, const unsigned =
int msglevel);</span><br><span>     int (*kill_by_cn)(void *arg, const char=
 *common_name);</span><br><span>     int (*kill_by_addr)(void *arg, const i=
n_addr_t addr, const int port, const int proto);</span><br><span>     void =
(*delete_event)(void *arg, event_t event);</span><br><span>diff --git a/src=
/openvpn/mtu.c b/src/openvpn/mtu.c</span><br><span>index 1e021e3..f5bc814 1=
00644</span><br><span>--- a/src/openvpn/mtu.c</span><br><span>+++ b/src/ope=
nvpn/mtu.c</span><br><span>@@ -187,7 +187,7 @@</span><br><span> }</span><br=
><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-frame_print(const struct frame *frame, int level, const char *pref=
ix)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+frame_print(cons=
t struct frame *frame, unsigned int msglevel, const char *prefix)</span><br=
><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><=
span>     struct buffer out =3D alloc_buf_gc(256, &amp;gc);</span><br><span=
>@@ -208,7 +208,7 @@</span><br><span>     buf_printf(&amp;out, &quot; ET:%d=
&quot;, frame-&gt;extra_tun);</span><br><span>     buf_printf(&amp;out, &qu=
ot; ]&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    msg(level, &quot;%s&quot;, out.data);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(msglevel, &quot;%s&quot;, out.dat=
a);</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h</sp=
an><br><span>index c092461..c555f51 100644</span><br><span>--- a/src/openvp=
n/mtu.h</span><br><span>+++ b/src/openvpn/mtu.h</span><br><span>@@ -181,7 +=
181,7 @@</span><br><span>  * Function prototypes.</span><br><span>  */</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void fra=
me_print(const struct frame *frame, int level, const char *prefix);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void frame_print(const stru=
ct frame *frame, unsigned int msglevel, const char *prefix);</span><br><spa=
n> </span><br><span> void set_mtu_discover_type(socket_descriptor_t sd, int=
 mtu_type, sa_family_t proto_af);</span><br><span> </span><br><span>diff --=
git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 579ee=
ea..a68832b 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><spa=
n>+++ b/src/openvpn/multi.c</span><br><span>@@ -3321,7 +3321,7 @@</span><br=
><span>     }</span><br><span>     else</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        int msglevel =3D D_DCO;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int m=
sglevel =3D D_DCO;</span><br><span>         if (dco-&gt;dco_message_type =
=3D=3D OVPN_CMD_DEL_PEER</span><br><span>             &amp;&amp; dco-&gt;dc=
o_del_peer_reason =3D=3D OVPN_DEL_PEER_REASON_USERSPACE)</span><br><span>  =
       {</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/o=
ptions.c</span><br><span>index e47d54c..f398de0 100644</span><br><span>--- =
a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><=
br><span>@@ -1107,7 +1107,7 @@</span><br><span> #endif /* ifndef _WIN32 */<=
/span><br><span> </span><br><span> static in_addr_t</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-get_ip_addr(const char *ip_string, int msgl=
evel, bool *error)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+g=
et_ip_addr(const char *ip_string, unsigned int msglevel, bool *error)</span=
><br><span> {</span><br><span>     unsigned int flags =3D GETADDR_HOST_ORDE=
R;</span><br><span>     bool succeeded =3D false;</span><br><span>@@ -1192,=
7 +1192,7 @@</span><br><span>  * @param   gc          The returned object w=
ill be allocated in this gc</span><br><span>  */</span><br><span> static st=
ruct verify_hash_list *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct =
gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_=
hash_fingerprint(const char *str, int nbytes, unsigned int msglevel, struct=
 gc_arena *gc)</span><br><span> {</span><br><span>     int i =3D 0;</span><=
br><span>     const char *cp =3D str;</span><br><span>@@ -1245,7 +1245,8 @@=
</span><br><span>  * @param   gc          The returned list items will be a=
llocated in this gc</span><br><span>  */</span><br><span> static struct ver=
ify_hash_list *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-parse_=
hash_fingerprint_multiline(const char *str, int nbytes, int msglevel, struc=
t gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pars=
e_hash_fingerprint_multiline(const char *str, int nbytes, unsigned int msgl=
evel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                   struct gc_arena *gc)</span><br><span> {</span><br><span>=
     struct gc_arena gc_temp =3D gc_new();</span><br><span>     char *lines=
 =3D string_alloc(str, &amp;gc_temp);</span><br><span>@@ -1334,7 +1335,7 @@=
</span><br><span> #endif /* ifdef _WIN32 */</span><br><span> </span><br><sp=
an> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dhcp_o=
ption_dns6_parse(const char *parm, struct in6_addr *dns6_list, int *len, in=
t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dhcp_opt=
ion_dns6_parse(const char *parm, struct in6_addr *dns6_list, int *len, unsi=
gned int msglevel)</span><br><span> {</span><br><span>     struct in6_addr =
addr;</span><br><span>     if (*len &gt;=3D N_DHCP_ADDR)</span><br><span>@@=
 -1349,7 +1350,7 @@</span><br><span> }</span><br><span> static void</span><=
br><span> dhcp_option_address_parse(const char *name, const char *parm, in_=
addr_t *array, int *len,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                          int msglevel)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                          unsigned int msglevel)</sp=
an><br><span> {</span><br><span>     if (*len &gt;=3D N_DHCP_ADDR)</span><b=
r><span>     {</span><br><span>@@ -1485,7 +1486,8 @@</span><br><span> #endi=
f /* ! ENABLE_SMALL */</span><br><span> </span><br><span> static void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-option_iroute(struct option=
s *o, const char *network_str, const char *netmask_str, int msglevel)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+option_iroute(struct opti=
ons *o, const char *network_str, const char *netmask_str,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+              unsigned int msglevel)<=
/span><br><span> {</span><br><span>     struct iroute *ir;</span><br><span>=
 </span><br><span>@@ -1511,7 +1513,7 @@</span><br><span> }</span><br><span>=
 </span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-option_iroute_ipv6(struct options *o, const char *prefix_str, int =
msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+option_iro=
ute_ipv6(struct options *o, const char *prefix_str, unsigned int msglevel)<=
/span><br><span> {</span><br><span>     struct iroute_ipv6 *ir;</span><br><=
span> </span><br><span>@@ -2068,7 +2070,7 @@</span><br><span> }</span><br><=
span> </span><br><span> static struct local_entry *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-alloc_local_entry(struct connection_entry *=
ce, const int msglevel, struct gc_arena *gc)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+alloc_local_entry(struct connection_entry *ce, con=
st unsigned int msglevel, struct gc_arena *gc)</span><br><span> {</span><br=
><span>     struct local_list *l =3D alloc_local_list_if_undef(ce, gc);</sp=
an><br><span>     struct local_entry *e;</span><br><span>@@ -2109,7 +2111,7=
 @@</span><br><span> }</span><br><span> </span><br><span> static struct con=
nection_entry *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-alloc_=
connection_entry(struct options *options, const int msglevel)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+alloc_connection_entry(struct opt=
ions *options, const unsigned int msglevel)</span><br><span> {</span><br><s=
pan>     struct connection_list *l =3D alloc_connection_list_if_undef(optio=
ns);</span><br><span>     struct connection_entry *e;</span><br><span>@@ -2=
145,7 +2147,7 @@</span><br><span> }</span><br><span> </span><br><span> stat=
ic struct remote_entry *</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-alloc_remote_entry(struct options *options, const int msglevel)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+alloc_remote_entry(struct op=
tions *options, const unsigned int msglevel)</span><br><span> {</span><br><=
span>     struct remote_list *l =3D alloc_remote_list_if_undef(options);</s=
pan><br><span>     struct remote_entry *e;</span><br><span>@@ -2699,7 +2701=
,7 @@</span><br><span> </span><br><span>     if (!options-&gt;tls_server &a=
mp;&amp; !options-&gt;tls_client)</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        int msglevel =3D M_USAGE;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int msgle=
vel =3D M_USAGE;</span><br><span>         if (options-&gt;allow_deprecated_=
insecure_static_crypto)</span><br><span>         {</span><br><span>        =
     msglevel =3D M_INFO;</span><br><span>@@ -4571,8 +4573,9 @@</span><br><=
span> }</span><br><span> </span><br><span> static void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-options_warning_safe_scan2(const int msgle=
vel, const int delim, const bool report_inconsistent,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                           const char *p1, =
const struct buffer *b2_src, const char *b1_name,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+options_warning_safe_scan2(const unsigned int=
 msglevel, const int delim,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                           const bool report_inconsistent, const ch=
ar *p1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
               const struct buffer *b2_src, const char *b1_name,</span><br>=
<span>                            const char *b2_name)</span><br><span> {</=
span><br><span>     /* We will stop sending &#39;key-method&#39;, &#39;keyd=
ir&#39;, &#39;proto&#39; and &#39;tls-auth&#39; in</span><br><span>@@ -4624=
,9 +4627,9 @@</span><br><span> }</span><br><span> </span><br><span> static =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-options_warning_s=
afe_scan1(const int msglevel, const int delim, const bool report_inconsiste=
nt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
         const struct buffer *b1_src, const struct buffer *b2_src,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                           con=
st char *b1_name, const char *b2_name)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+options_warning_safe_scan1(const unsigned int msglevel, =
const int delim,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                        const bool report_inconsistent, const struct buffer=
 *b1_src,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                 const struct buffer *b2_src, const char *b1_name, const ch=
ar *b2_name)</span><br><span> {</span><br><span>     struct gc_arena gc =3D=
 gc_new();</span><br><span>     struct buffer b =3D *b1_src;</span><br><spa=
n>@@ -4642,7 +4645,7 @@</span><br><span> }</span><br><span> </span><br><spa=
n> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-options=
_warning_safe_ml(const int msglevel, char *actual, const char *expected, si=
ze_t actual_n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+optio=
ns_warning_safe_ml(const unsigned int msglevel, char *actual, const char *e=
xpected, size_t actual_n)</span><br><span> {</span><br><span>     struct gc=
_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ -4734,7 +4737,=
7 @@</span><br><span>  */</span><br><span> </span><br><span> int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-parse_topology(const char *str, =
const int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
parse_topology(const char *str, const unsigned int msglevel)</span><br><spa=
n> {</span><br><span>     if (streq(str, &quot;net30&quot;))</span><br><spa=
n>     {</span><br><span>@@ -4790,7 +4793,7 @@</span><br><span> }</span><br=
><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-auth_retry_set(const int msglevel, const char *option)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+auth_retry_set(const unsigned i=
nt msglevel, const char *option)</span><br><span> {</span><br><span>     if=
 (streq(option, &quot;interact&quot;))</span><br><span>     {</span><br><sp=
an>@@ -4947,7 +4950,7 @@</span><br><span> </span><br><span> #if 0</span><br=
><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pi=
ng_rec_err(int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ping_rec_err(unsigned int msglevel)</span><br><span> {</span><br><span=
>     msg(msglevel, &quot;only one of --ping-exit or --ping-restart options=
 may be specified&quot;);</span><br><span> }</span><br><span>@@ -4971,7 +49=
74,7 @@</span><br><span> </span><br><span> int</span><br><span> parse_line(=
const char *line, char *p[], const int n, const char *file, const int line_=
num,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           int ms=
glevel, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+           unsigned int msglevel, struct gc_arena *gc)</span><br><=
span> {</span><br><span>     const int STATE_INITIAL =3D 0;</span><br><span=
>     const int STATE_READING_QUOTED_PARM =3D 1;</span><br><span>@@ -5276,2=
4 +5279,25 @@</span><br><span> }</span><br><span> </span><br><span> static =
void add_option(struct options *options, char *p[], bool is_inline, const c=
har *file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
            int line, const int level, const int msglevel,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                       int line, con=
st int level, const unsigned int msglevel,</span><br><span>                =
        const unsigned int permission_mask, unsigned int *option_types_foun=
d,</span><br><span>                        struct env_set *es);</span><br><=
span> </span><br><span> static void remove_option(struct context *c, struct=
 options *options, char *p[], bool is_inline,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                          const char *file, int lin=
e, const int msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                          const char *file, int line, const unsigned int=
 msglevel,</span><br><span>                           const unsigned int pe=
rmission_mask, unsigned int *option_types_found,</span><br><span>          =
                 struct env_set *es);</span><br><span> </span><br><span> st=
atic void update_option(struct context *c, struct options *options, char *p=
[], bool is_inline,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                        const char *file, int line, const int level, const =
int msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                    const char *file, int line, const int level, const unsi=
gned int msglevel,</span><br><span>                           const unsigne=
d int permission_mask, unsigned int *option_types_found,</span><br><span>  =
                         struct env_set *es, unsigned int *update_options_f=
ound);</span><br><span> </span><br><span> static void</span><br><span> read=
_config_file(struct options *options, const char *file, int level, const ch=
ar *top_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
         const int top_line, const int msglevel, const unsigned int permiss=
ion_mask,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
     unsigned int *option_types_found, struct env_set *es)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                 const int top_line,=
 const unsigned int msglevel,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                 const unsigned int permission_mask, unsigned int=
 *option_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                 struct env_set *es)</span><br><span> {</span><br><span> =
    const int max_recursive_levels =3D 10;</span><br><span>     FILE *fp;</=
span><br><span>@@ -5365,7 +5369,7 @@</span><br><span> </span><br><span> sta=
tic void</span><br><span> read_config_string(const char *prefix, struct opt=
ions *options, const char *config,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                   const int msglevel, const unsigned int perm=
ission_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
            const unsigned int msglevel, const unsigned int permission_mask=
,</span><br><span>                    unsigned int *option_types_found, str=
uct env_set *es)</span><br><span> {</span><br><span>     char line[OPTION_L=
INE_SIZE];</span><br><span>@@ -5393,7 +5397,7 @@</span><br><span> }</span><=
br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-parse_argv(struct options *options, const int argc, char *argv[]=
, const int msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+parse_argv(struct options *options, const int argc, char *argv[], const u=
nsigned int msglevel,</span><br><span>            const unsigned int permis=
sion_mask, unsigned int *option_types_found, struct env_set *es)</span><br>=
<span> {</span><br><span>     /* usage message */</span><br><span>@@ -5462,=
7 +5466,7 @@</span><br><span>     char line[OPTION_PARM_SIZE];</span><br><s=
pan>     int line_num =3D 0;</span><br><span>     const char *file =3D &quo=
t;[PUSH-OPTIONS]&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    const int msglevel =3D D_PUSH_ERRORS | M_OPTERR;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const unsigned int msglevel =3D D_PU=
SH_ERRORS | M_OPTERR;</span><br><span>     unsigned int update_options_foun=
d =3D 0;</span><br><span> </span><br><span>     while (buf_parse(buf, &#39;=
,&#39;, line, sizeof(line)))</span><br><span>@@ -5519,7 +5523,7 @@</span><b=
r><span> }</span><br><span> </span><br><span> void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-options_server_import(struct options *o, const=
 char *filename, int msglevel,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+options_server_import(struct options *o, const char *filename, u=
nsigned int msglevel,</span><br><span>                       unsigned int p=
ermission_mask, unsigned int *option_types_found,</span><br><span>         =
              struct env_set *es)</span><br><span> {</span><br><span>@@ -55=
29,7 +5533,7 @@</span><br><span> }</span><br><span> </span><br><span> void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-options_string_import(=
struct options *options, const char *config, const int msglevel,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+options_string_import(struct o=
ptions *options, const char *config, const unsigned int msglevel,</span><br=
><span>                       const unsigned int permission_mask, unsigned =
int *option_types_found,</span><br><span>                       struct env_=
set *es)</span><br><span> {</span><br><span>@@ -5548,7 +5552,7 @@</span><br=
><span> </span><br><span> static bool</span><br><span> verify_permission(co=
nst char *name, const char *file, int line, const unsigned int type,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                  const unsi=
gned int allowed, unsigned int *found, const int msglevel,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                  const unsigned int=
 allowed, unsigned int *found, const unsigned int msglevel,</span><br><span=
>                   struct options *options, bool is_inline)</span><br><spa=
n> {</span><br><span>     if (!(type &amp; allowed))</span><br><span>@@ -56=
00,7 +5604,7 @@</span><br><span> #define NM_QUOTE_HINT (1 &lt;&lt; 0)</span=
><br><span> </span><br><span> static bool</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-no_more_than_n_args(const int msglevel, char *p[], cons=
t int max, const unsigned int flags)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+no_more_than_n_args(const unsigned int msglevel, char *p[]=
, const int max, const unsigned int flags)</span><br><span> {</span><br><sp=
an>     const int len =3D string_array_len((const char **)p);</span><br><sp=
an> </span><br><span>@@ -5624,8 +5628,8 @@</span><br><span>     }</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-msglevel_forward_compatible(struct options *options, const int msglevel)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline unsign=
ed int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+msglevel_forw=
ard_compatible(struct options *options, const unsigned int msglevel)</span>=
<br><span> {</span><br><span>     return options-&gt;forward_compatible ? M=
_WARN : msglevel;</span><br><span> }</span><br><span>@@ -5659,10 +5663,11 @=
@</span><br><span>  */</span><br><span> static void</span><br><span> remove=
_option(struct context *c, struct options *options, char *p[], bool is_inli=
ne,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              cons=
t char *file, int line, const int msglevel, const unsigned int permission_m=
ask,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              uns=
igned int *option_types_found, struct env_set *es)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+              const char *file, int line, co=
nst unsigned int msglevel,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+              const unsigned int permission_mask, unsigned int *opti=
on_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
          struct env_set *es)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int msglevel_fc =3D msglevel_forward_compati=
ble(options, msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    unsigned int msglevel_fc =3D msglevel_forward_compatible(options, m=
sglevel);</span><br><span> </span><br><span>     if (streq(p[0], &quot;ifco=
nfig&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>@@ -57=
97,11 +5802,10 @@</span><br><span> #endif</span><br><span>     else</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int m=
sglevel_unknown =3D msglevel_fc;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        unsigned int msglevel_unknown =3D msglevel_fc;</span><=
br><span>         /* Check if an option is in --ignore-unknown-option and</=
span><br><span>          * set warning level to non fatal */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; options-&gt;ig=
nore_unknown_option &amp;&amp; options-&gt;ignore_unknown_option[i]; i++)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =
=3D 0; options-&gt;ignore_unknown_option &amp;&amp; options-&gt;ignore_unkn=
own_option[i]; i++)</span><br><span>         {</span><br><span>            =
 if (streq(p[0], options-&gt;ignore_unknown_option[i]))</span><br><span>   =
          {</span><br><span>@@ -5820,7 +5824,7 @@</span><br><span> </span><=
br><span> </span><br><span> static bool</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-check_route_option(struct options *options, char *p[], co=
nst int msglevel, bool pull_mode)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+check_route_option(struct options *options, char *p[], const =
unsigned int msglevel, bool pull_mode)</span><br><span> {</span><br><span> =
    rol_check_alloc(options);</span><br><span>     if (pull_mode)</span><br=
><span>@@ -5848,7 +5852,7 @@</span><br><span> </span><br><span> </span><br>=
<span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-che=
ck_route6_option(struct options *options, char *p[], const int msglevel, bo=
ol pull_mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_=
route6_option(struct options *options, char *p[], const unsigned int msglev=
el, bool pull_mode)</span><br><span> {</span><br><span>     rol6_check_allo=
c(options);</span><br><span>     if (pull_mode)</span><br><span>@@ -5869,7 =
+5873,7 @@</span><br><span> }</span><br><span> </span><br><span> static boo=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_dns_option(str=
uct options *options, char *p[], const int msglevel, bool pull_mode)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+check_dns_option(struct op=
tions *options, char *p[], const unsigned int msglevel, bool pull_mode)</sp=
an><br><span> {</span><br><span>     if (streq(p[1], &quot;search-domains&q=
uot;) &amp;&amp; p[2])</span><br><span>     {</span><br><span>@@ -5989,7 +5=
993,7 @@</span><br><span>  */</span><br><span> static void</span><br><span>=
 update_option(struct context *c, struct options *options, char *p[], bool =
is_inline,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
   const char *file, int line, const int level, const int msglevel,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+              const char *f=
ile, int line, const int level, const unsigned int msglevel,</span><br><spa=
n>               const unsigned int permission_mask, unsigned int *option_t=
ypes_found,</span><br><span>               struct env_set *es, unsigned int=
 *update_options_found)</span><br><span> {</span><br><span>@@ -6174,12 +617=
8,12 @@</span><br><span> </span><br><span> static void</span><br><span> add=
_option(struct options *options, char *p[], bool is_inline, const char *fil=
e, int line,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
  const int level, const int msglevel, const unsigned int permission_mask,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+           const int=
 level, const unsigned int msglevel, const unsigned int permission_mask,</s=
pan><br><span>            unsigned int *option_types_found, struct env_set =
*es)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new(=
);</span><br><span>     const bool pull_mode =3D BOOL_CAST(permission_mask =
&amp; OPT_P_PULL_MODE);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int msglevel_fc =3D msglevel_forward_compatible(options, msglevel);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int msgl=
evel_fc =3D msglevel_forward_compatible(options, msglevel);</span><br><span=
> </span><br><span>     ASSERT(MAX_PARMS &gt;=3D 7);</span><br><span> </spa=
n><br><span>@@ -9874,7 +9878,7 @@</span><br><span>     else</span><br><span=
>     {</span><br><span>         int i;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        int msglevel_unknown =3D msglevel_fc;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int msglevel_u=
nknown =3D msglevel_fc;</span><br><span>         /* Check if an option is i=
n --ignore-unknown-option and</span><br><span>          * set warning level=
 to non fatal */</span><br><span>         for (i =3D 0; options-&gt;ignore_=
unknown_option &amp;&amp; options-&gt;ignore_unknown_option[i]; i++)</span>=
<br><span>diff --git a/src/openvpn/options.h b/src/openvpn/options.h</span>=
<br><span>index bb2c052..5e918bb 100644</span><br><span>--- a/src/openvpn/o=
ptions.h</span><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -82=
2,7 +822,7 @@</span><br><span>     struct pull_filter *tail;</span><br><spa=
n> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-void parse_argv(struct options *options, const int argc, char *argv[], co=
nst int msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id parse_argv(struct options *options, const int argc, char *argv[], const =
unsigned int msglevel,</span><br><span>                 const unsigned int =
permission_mask, unsigned int *option_types_found,</span><br><span>        =
         struct env_set *es);</span><br><span> </span><br><span>@@ -888,7 +=
888,7 @@</span><br><span> </span><br><span> void options_detach(struct opti=
ons *o);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-void options_server_import(struct options *o, const char *filename, in=
t msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void opt=
ions_server_import(struct options *o, const char *filename, unsigned int ms=
glevel,</span><br><span>                            unsigned int permission=
_mask, unsigned int *option_types_found,</span><br><span>                  =
          struct env_set *es);</span><br><span> </span><br><span>@@ -897,13=
 +897,13 @@</span><br><span> void rol_check_alloc(struct options *options);=
</span><br><span> </span><br><span> int parse_line(const char *line, char *=
p[], const int n, const char *file, const int line_num,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-               int msglevel, struct gc_ar=
ena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
     unsigned int msglevel, struct gc_arena *gc);</span><br><span> </span><=
br><span> /*</span><br><span>  * parse/print topology coding</span><br><spa=
n>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-int parse_topology(const char *str, const int msglevel);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+int parse_topology(const char *str,=
 const unsigned int msglevel);</span><br><span> </span><br><span> const cha=
r *print_topology(const int topology);</span><br><span> </span><br><span>@@=
 -917,11 +917,11 @@</span><br><span> </span><br><span> int auth_retry_get(v=
oid);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-bool auth_retry_set(const int msglevel, const char *option);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool auth_retry_set(const unsign=
ed int msglevel, const char *option);</span><br><span> </span><br><span> co=
nst char *auth_retry_print(void);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void options_string_import(struct options *=
options, const char *config, const int msglevel,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void options_string_import(struct options *opt=
ions, const char *config, const unsigned int msglevel,</span><br><span>    =
                        const unsigned int permission_mask, unsigned int *o=
ption_types_found,</span><br><span>                            struct env_s=
et *es);</span><br><span> </span><br><span>diff --git a/src/openvpn/options=
_util.c b/src/openvpn/options_util.c</span><br><span>index a351967..eeaabe1=
 100644</span><br><span>--- a/src/openvpn/options_util.c</span><br><span>++=
+ b/src/openvpn/options_util.c</span><br><span>@@ -117,7 +117,7 @@</span><b=
r><span> }</span><br><span> </span><br><span> int</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-positive_atoi(const char *str, int msglevel)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+positive_atoi(const ch=
ar *str, unsigned int msglevel)</span><br><span> {</span><br><span>     cha=
r *endptr;</span><br><span>     long long i =3D strtoll(str, &amp;endptr, 1=
0);</span><br><span>@@ -132,7 +132,7 @@</span><br><span> }</span><br><span>=
 </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-positive_atoll(const char *str, int64_t *value, const char *name, int msg=
level)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+positive_atol=
l(const char *str, int64_t *value, const char *name, unsigned int msglevel)=
</span><br><span> {</span><br><span>     char *endptr;</span><br><span>    =
 long long ll =3D strtoll(str, &amp;endptr, 10);</span><br><span>@@ -148,7 =
+148,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-atoi_warn(const char *str, in=
t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+atoi_war=
n(const char *str, unsigned int msglevel)</span><br><span> {</span><br><spa=
n>     char *endptr;</span><br><span>     long long i =3D strtoll(str, &amp=
;endptr, 10);</span><br><span>@@ -165,10 +165,11 @@</span><br><span> #if de=
fined(__GNUC__) || defined(__clang__)</span><br><span> #pragma GCC diagnost=
ic push</span><br><span> #pragma GCC diagnostic ignored &quot;-Wconversion&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma GCC di=
agnostic ignored &quot;-Wsign-conversion&quot;</span><br><span> #endif</spa=
n><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-atoi_constrained(const char *str, int *value, const char *nam=
e, int min, int max, int msglevel)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+atoi_constrained(const char *str, int *value, const char *na=
me, int min, int max, unsigned int msglevel)</span><br><span> {</span><br><=
span>     ASSERT(min &lt; max);</span><br><span> </span><br><span>diff --gi=
t a/src/openvpn/options_util.h b/src/openvpn/options_util.h</span><br><span=
>index 45417d9..15a9a28 100644</span><br><span>--- a/src/openvpn/options_ut=
il.h</span><br><span>+++ b/src/openvpn/options_util.h</span><br><span>@@ -3=
7,7 +37,7 @@</span><br><span>  * Converts a str to a positive number if the=
 string represents a postive</span><br><span>  * integer number. Otherwise =
print a warning with msglevel and return 0</span><br><span>  */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-int positive_atoi(const char *str=
, int msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int=
 positive_atoi(const char *str, unsigned int msglevel);</span><br><span> </=
span><br><span> /**</span><br><span>  * Converts a str to an integer if the=
 string can be represented as an</span><br><span>@@ -48,13 +48,13 @@</span>=
<br><span>  *</span><br><span>  * @return \c true if the integer has been p=
arsed and stored in value, \c false otherwise</span><br><span>  */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-bool positive_atoll(const char=
 *str, int64_t *value, const char *name, int msglevel);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool positive_atoll(const char *str, in=
t64_t *value, const char *name, unsigned int msglevel);</span><br><span> </=
span><br><span> /**</span><br><span>  * Converts a str to an integer if the=
 string can be represented as an</span><br><span>  * integer number. Otherw=
ise print a warning with \p msglevel and return 0</span><br><span>  */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-int atoi_warn(const char *=
str, int msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
int atoi_warn(const char *str, unsigned int msglevel);</span><br><span> </s=
pan><br><span> /**</span><br><span>  * Converts a str to an integer if the =
string can be represented as an</span><br><span>@@ -66,7 +66,7 @@</span><br=
><span>  * @return \c true if the integer has been parsed and stored in val=
ue, \c false otherwise</span><br><span>  */</span><br><span> bool atoi_cons=
trained(const char *str, int *value, const char *name, int min, int max,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                      in=
t msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
               unsigned int msglevel);</span><br><span> </span><br><span> /=
**</span><br><span>  * Filter an option line by all pull filters.</span><br=
><span>diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c</span=
><br><span>index 0b33c9c..63a4cae 100644</span><br><span>--- a/src/openvpn/=
packet_id.c</span><br><span>+++ b/src/openvpn/packet_id.c</span><br><span>@=
@ -53,15 +53,15 @@</span><br><span> #define SEQ_EXPIRED ((time_t)1)</span><=
br><span> </span><br><span> #ifdef ENABLE_DEBUG</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-static void packet_id_debug_print(int msglevel, c=
onst struct packet_id_rec *p,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void packet_id_debug_print(unsigned int msglevel, const st=
ruct packet_id_rec *p,</span><br><span>                                   c=
onst struct packet_id_net *pin, const char *message,</span><br><span>      =
                             packet_id_print_type value);</span><br><span> =
</span><br><span> #endif /* ENABLE_DEBUG */</span><br><span> </span><br><sp=
an> static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-packet_id_debug(int msglevel, const struct packet_id_rec *p, const struct =
packet_id_net *pin,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              const char *message, uint64_t value)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+packet_id_debug(unsigned int msglevel, const=
 struct packet_id_rec *p,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                const struct packet_id_net *pin, const char *message,=
 uint64_t value)</span><br><span> {</span><br><span> #ifdef ENABLE_DEBUG</s=
pan><br><span>     if (unlikely(check_debug_level(msglevel)))</span><br><sp=
an>@@ -578,7 +578,8 @@</span><br><span> #ifdef ENABLE_DEBUG</span><br><span=
> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-packet_id_debug_print(int msglevel, const struct packet_id_rec *p=
, const struct packet_id_net *pin,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+packet_id_debug_print(unsigned int msglevel, const struct pa=
cket_id_rec *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                  const struct packet_id_net *pin,</span><br><span>        =
               const char *message, packet_id_print_type value)</span><br><=
span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><sp=
an>diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c</span><br><span=
>index ea76a08..8223a2c 100644</span><br><span>--- a/src/openvpn/plugin.c</=
span><br><span>+++ b/src/openvpn/plugin.c</span><br><span>@@ -50,7 +50,7 @@=
</span><br><span> static struct plugin_common *static_plugin_common =3D NUL=
L; /* GLOBAL */</span><br><span> </span><br><span> static void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-plugin_show_string_array(int msgle=
vel, const char *name, const char *array[])</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+plugin_show_string_array(unsigned int msglevel, con=
st char *name, const char *array[])</span><br><span> {</span><br><span>    =
 int i;</span><br><span>     for (i =3D 0; array[i]; ++i)</span><br><span>@=
@ -63,7 +63,7 @@</span><br><span> }</span><br><span> </span><br><span> stat=
ic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-plugin_show_ar=
gs_env(int msglevel, const char *argv[], const char *envp[])</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+plugin_show_args_env(unsigned int =
msglevel, const char *argv[], const char *envp[])</span><br><span> {</span>=
<br><span>     if (check_debug_level(msglevel))</span><br><span>     {</spa=
n><br><span>@@ -184,7 +184,7 @@</span><br><span> </span><br><span> #ifndef =
ENABLE_SMALL</span><br><span> void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-plugin_option_list_print(const struct plugin_option_list *list=
, int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+plug=
in_option_list_print(const struct plugin_option_list *list, unsigned int ms=
glevel)</span><br><span> {</span><br><span>     int i;</span><br><span>    =
 struct gc_arena gc =3D gc_new();</span><br><span>@@ -995,7 +995,7 @@</span=
><br><span> </span><br><span> #ifdef ENABLE_DEBUG</span><br><span> void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-plugin_return_print(const=
 int msglevel, const char *prefix, const struct plugin_return *pr)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+plugin_return_print(const un=
signed int msglevel, const char *prefix, const struct plugin_return *pr)</s=
pan><br><span> {</span><br><span>     int i;</span><br><span>     msg(msgle=
vel, &quot;PLUGIN_RETURN_PRINT %s&quot;, prefix);</span><br><span>diff --gi=
t a/src/openvpn/plugin.h b/src/openvpn/plugin.h</span><br><span>index 63999=
b6..91d3fba 100644</span><br><span>--- a/src/openvpn/plugin.h</span><br><sp=
an>+++ b/src/openvpn/plugin.h</span><br><span>@@ -111,7 +111,7 @@</span><br=
><span> bool plugin_option_list_add(struct plugin_option_list *list, char *=
*p, struct gc_arena *gc);</span><br><span> </span><br><span> #ifndef ENABLE=
_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void plugin_opt=
ion_list_print(const struct plugin_option_list *list, int msglevel);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void plugin_option_list_pr=
int(const struct plugin_option_list *list, unsigned int msglevel);</span><b=
r><span> </span><br><span> #endif</span><br><span> </span><br><span>@@ -136=
,7 +136,7 @@</span><br><span> void plugin_return_free(struct plugin_return =
*pr);</span><br><span> </span><br><span> #ifdef ENABLE_DEBUG</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void plugin_return_print(const int m=
sglevel, const char *prefix, const struct plugin_return *pr);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void plugin_return_print(const un=
signed int msglevel, const char *prefix, const struct plugin_return *pr);</=
span><br><span> </span><br><span> #endif</span><br><span> </span><br><span>=
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c</span><br><span>index =
fde6cea..0e95c5e 100644</span><br><span>--- a/src/openvpn/pool.c</span><br>=
<span>+++ b/src/openvpn/pool.c</span><br><span>@@ -114,7 +114,7 @@</span><b=
r><span>  * Verify start/end range</span><br><span>  */</span><br><span> bo=
ol</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ifconfig_pool_verif=
y_range(const int msglevel, const in_addr_t start, const in_addr_t end)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ifconfig_pool_verify_ra=
nge(const unsigned int msglevel, const in_addr_t start, const in_addr_t end=
)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();<=
/span><br><span>     bool ret =3D true;</span><br><span>@@ -521,7 +521,7 @@=
</span><br><span> }</span><br><span> </span><br><span> static void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-ifconfig_pool_msg(const struct=
 ifconfig_pool *pool, int msglevel)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ifconfig_pool_msg(const struct ifconfig_pool *pool, unsigne=
d int msglevel)</span><br><span> {</span><br><span>     struct status_outpu=
t *so =3D status_open(NULL, 0, msglevel, NULL, 0);</span><br><span>     ASS=
ERT(so);</span><br><span>diff --git a/src/openvpn/pool.h b/src/openvpn/pool=
.h</span><br><span>index 6cecef0..9c69512 100644</span><br><span>--- a/src/=
openvpn/pool.h</span><br><span>+++ b/src/openvpn/pool.h</span><br><span>@@ =
-78,7 +78,7 @@</span><br><span> </span><br><span> void ifconfig_pool_free(s=
truct ifconfig_pool *pool);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-bool ifconfig_pool_verify_range(const int msglevel,=
 const in_addr_t start, const in_addr_t end);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool ifconfig_pool_verify_range(const unsigned in=
t msglevel, const in_addr_t start, const in_addr_t end);</span><br><span> <=
/span><br><span> ifconfig_pool_handle ifconfig_pool_acquire(struct ifconfig=
_pool *pool, in_addr_t *local,</span><br><span>                            =
                in_addr_t *remote, struct in6_addr *remote_ipv6,</span><br>=
<span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><span>=
index 671b015..d4019e5 100644</span><br><span>--- a/src/openvpn/push.c</spa=
n><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -373,8 +373,8 @@</s=
pan><br><span>  *</span><br><span>  * @return true on success, false on fai=
lure.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static bool push_option_fmt(struct gc_arena *gc, struct push_list *pus=
h_list, int msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                            const char *fmt, ...)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static bool push_option_fmt(struct gc_arena *=
gc, struct push_list *push_list,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                            unsigned int msglevel, const char =
*fmt, ...)</span><br><span> #ifdef __GNUC__</span><br><span> #if __USE_MING=
W_ANSI_STDIO</span><br><span>     __attribute__((format(gnu_printf, 4, 5)))=
</span><br><span>@@ -857,7 +857,7 @@</span><br><span> </span><br><span> sta=
tic void</span><br><span> push_option_ex(struct gc_arena *gc, struct push_l=
ist *push_list, const char *opt, bool enable,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-               int msglevel)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+               unsigned int msglevel)</sp=
an><br><span> {</span><br><span>     if (!string_class(opt, CC_ANY, CC_COMM=
A))</span><br><span>     {</span><br><span>@@ -885,7 +885,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-push_option(struct options *o, const char *opt, in=
t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+push_opt=
ion(struct options *o, const char *opt, unsigned int msglevel)</span><br><s=
pan> {</span><br><span>     push_option_ex(&amp;o-&gt;gc, &amp;o-&gt;push_l=
ist, opt, true, msglevel);</span><br><span> }</span><br><span>@@ -906,7 +90=
6,7 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-push_options(struct options *o,=
 char **p, int msglevel, struct gc_arena *gc)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+push_options(struct options *o, char **p, unsigne=
d int msglevel, struct gc_arena *gc)</span><br><span> {</span><br><span>   =
  const char **argv =3D make_extended_arg_array(p, false, gc);</span><br><s=
pan>     char *opt =3D print_argv(argv, gc, 0);</span><br><span>@@ -914,8 +=
914,8 @@</span><br><span> }</span><br><span> </span><br><span> static bool<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-push_option_fmt(struct=
 gc_arena *gc, struct push_list *push_list, int msglevel, const char *forma=
t,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                ...=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+push_option_fmt(st=
ruct gc_arena *gc, struct push_list *push_list,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                unsigned int msglevel, const ch=
ar *format, ...)</span><br><span> {</span><br><span>     va_list arglist;</=
span><br><span>     char tmp[256] =3D { 0 };</span><br><span>diff --git a/s=
rc/openvpn/push.h b/src/openvpn/push.h</span><br><span>index 8ffd0c2..a13e2=
4f 100644</span><br><span>--- a/src/openvpn/push.h</span><br><span>+++ b/sr=
c/openvpn/push.h</span><br><span>@@ -99,9 +99,9 @@</span><br><span> </span>=
<br><span> void clone_push_list(struct options *o);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-void push_option(struct opt=
ions *o, const char *opt, int msglevel);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void push_option(struct options *o, const char *opt, u=
nsigned int msglevel);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void push_options(struct options *o, char **p, int msgle=
vel, struct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void push_options(struct options *o, char **p, unsigned int msglevel=
, struct gc_arena *gc);</span><br><span> </span><br><span> void push_reset(=
struct options *o);</span><br><span> </span><br><span>diff --git a/src/open=
vpn/route.c b/src/openvpn/route.c</span><br><span>index d3d2954..72e763d 10=
0644</span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/op=
envpn/route.c</span><br><span>@@ -1228,28 +1228,28 @@</span><br><span> }</s=
pan><br><span> </span><br><span> static void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-print_route_option(const struct route_option *ro, in=
t level)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_route=
_option(const struct route_option *ro, unsigned int msglevel)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(level, &=
quot;  route %s/%s/%s/%s&quot;, show_opt(ro-&gt;network), show_opt(ro-&gt;n=
etmask),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(msg=
level, &quot;  route %s/%s/%s/%s&quot;, show_opt(ro-&gt;network), show_opt(=
ro-&gt;netmask),</span><br><span>         show_opt(ro-&gt;gateway), show_op=
t(ro-&gt;metric));</span><br><span> }</span><br><span> </span><br><span> vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-print_route_options=
(const struct route_option_list *rol, int level)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+print_route_options(const struct route_option_=
list *rol, unsigned int msglevel)</span><br><span> {</span><br><span>     s=
truct route_option *ro;</span><br><span>     if (rol-&gt;flags &amp; RG_ENA=
BLE)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        msg(level, &quot;  [redirect_default_gateway local=3D%d]&quot=
;, (rol-&gt;flags &amp; RG_LOCAL) !=3D 0);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        msg(msglevel, &quot;  [redirect_default_gate=
way local=3D%d]&quot;, (rol-&gt;flags &amp; RG_LOCAL) !=3D 0);</span><br><s=
pan>     }</span><br><span>     for (ro =3D rol-&gt;routes; ro; ro =3D ro-&=
gt;next)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        print_route_option(ro, level);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        print_route_option(ro, msglevel);</spa=
n><br><span>     }</span><br><span> }</span><br><span> </span><br><span> vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-print_default_gatew=
ay(const int msglevel, const struct route_gateway_info *rgi,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+print_default_gateway(const unsign=
ed int msglevel, const struct route_gateway_info *rgi,</span><br><span>    =
                   const struct route_ipv6_gateway_info *rgi6)</span><br><s=
pan> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><spa=
n>@@ -1323,23 +1323,23 @@</span><br><span> #endif /* ifndef ENABLE_SMALL */=
</span><br><span> </span><br><span> static void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-print_route(const struct route_ipv4 *r, int level=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_route(const =
struct route_ipv4 *r, unsigned int msglevel)</span><br><span> {</span><br><=
span>     struct gc_arena gc =3D gc_new();</span><br><span>     if (r-&gt;f=
lags &amp; RT_DEFINED)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        msg(level, &quot;%s&quot;, route_string(r, =
&amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
sg(msglevel, &quot;%s&quot;, route_string(r, &amp;gc));</span><br><span>   =
  }</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><sp=
an> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-print_routes(const struct route_list *rl, int level)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+print_routes(const struct route_list =
*rl, unsigned int msglevel)</span><br><span> {</span><br><span>     struct =
route_ipv4 *r;</span><br><span>     for (r =3D rl-&gt;routes; r; r =3D r-&g=
t;next)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        print_route(r, level);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        print_route(r, msglevel);</span><br><span>     =
}</span><br><span> }</span><br><span> </span><br><span>@@ -3067,18 +3067,18=
 @@</span><br><span>  * Show current routing table</span><br><span>  */</sp=
an><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sho=
w_routes(int msglev)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+show_routes(unsigned int msglevel)</span><br><span> {</span><br><span>    =
 struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>     co=
nst MIB_IPFORWARDTABLE *rt =3D get_windows_routing_table(&amp;gc);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(msgl=
ev, &quot;SYSTEM ROUTING TABLE&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    msg(msglevel, &quot;SYSTEM ROUTING TABLE&quot;);</sp=
an><br><span>     if (rt)</span><br><span>     {</span><br><span>         f=
or (DWORD i =3D 0; i &lt; rt-&gt;dwNumEntries; ++i)</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(ms=
glev, &quot;%s&quot;, format_route_entry(&amp;rt-&gt;table[i], &amp;gc));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msgle=
vel, &quot;%s&quot;, format_route_entry(&amp;rt-&gt;table[i], &amp;gc));</s=
pan><br><span>         }</span><br><span>     }</span><br><span>     gc_fre=
e(&amp;gc);</span><br><span>diff --git a/src/openvpn/route.h b/src/openvpn/=
route.h</span><br><span>index 9b6a47e..b8c8244 100644</span><br><span>--- a=
/src/openvpn/route.h</span><br><span>+++ b/src/openvpn/route.h</span><br><s=
pan>@@ -356,7 +356,7 @@</span><br><span> void get_default_gateway_ipv6(stru=
ct route_ipv6_gateway_info *rgi, const struct in6_addr *dest,</span><br><sp=
an>                               openvpn_net_ctx_t *ctx);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void print_default_g=
ateway(const int msglevel, const struct route_gateway_info *rgi,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void print_default_gateway(con=
st unsigned int msglevel, const struct route_gateway_info *rgi,</span><br><=
span>                            const struct route_ipv6_gateway_info *rgi6=
);</span><br><span> </span><br><span> /*</span><br><span>@@ -371,15 +371,15=
 @@</span><br><span> int test_local_addr(const in_addr_t addr, const struct=
 route_gateway_info *rgi);</span><br><span> </span><br><span> #ifndef ENABL=
E_SMALL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void print_rou=
te_options(const struct route_option_list *rol, int level);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void print_route_options(const stru=
ct route_option_list *rol, unsigned int msglevel);</span><br><span> </span>=
<br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-void print_routes(const struct route_list *rl, int level);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void print_routes(cons=
t struct route_list *rl, unsigned int msglevel);</span><br><span> </span><b=
r><span> #ifdef _WIN32</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void show_routes(int msglev);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void show_routes(unsigned int msglevel);</span=
><br><span> </span><br><span> bool test_routes(const struct route_list *rl,=
 const struct tuntap *tt);</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/run_command.c b/src/openvpn/run_command.c</span><br><span>index =
4a1ef22..942434c 100644</span><br><span>--- a/src/openvpn/run_command.c</sp=
an><br><span>+++ b/src/openvpn/run_command.c</span><br><span>@@ -107,7 +107=
,7 @@</span><br><span> </span><br><span> #ifndef WIN32</span><br><span> boo=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-openvpn_waitpid_chec=
k(pid_t pid, const char *msg_prefix, int msglevel)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+openvpn_waitpid_check(pid_t pid, const char =
*msg_prefix, unsigned int msglevel)</span><br><span> {</span><br><span>    =
 if (pid =3D=3D 0)</span><br><span>     {</span><br><span>diff --git a/src/=
openvpn/run_command.h b/src/openvpn/run_command.h</span><br><span>index afd=
1b88..222272c 100644</span><br><span>--- a/src/openvpn/run_command.h</span>=
<br><span>+++ b/src/openvpn/run_command.h</span><br><span>@@ -71,13 +71,13 =
@@</span><br><span>  * This function is currently not implemented for Windo=
ws as the helper</span><br><span>  * macros used by this function are not a=
vailable.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * @param pid               pid of the process to be checked</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pid            p=
id of the process to be checked</span><br><span>  * @param msg_prefix     p=
refixed of the message that be printed</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">- * @param msglevel          msglevel of the messages to be=
 printed</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @return   =
               true if the process is still running, false if</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- *                          an erro=
r condition occurred</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param msglevel       msglevel of the messages to be printed</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @return               true =
if the process is still running, false if</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *                       an error condition occurred<=
/span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-b=
ool openvpn_waitpid_check(pid_t pid, const char *msg_prefix, int msglevel);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool openvpn_waitpi=
d_check(pid_t pid, const char *msg_prefix, unsigned int msglevel);</span><b=
r><span> </span><br><span> #endif</span><br><span> </span><br><span>diff --=
git a/src/openvpn/sig.c b/src/openvpn/sig.c</span><br><span>index ecea635..=
35c2249 100644</span><br><span>--- a/src/openvpn/sig.c</span><br><span>+++ =
b/src/openvpn/sig.c</span><br><span>@@ -287,7 +287,7 @@</span><br><span> }<=
/span><br><span> </span><br><span> void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-print_signal(const struct signal_info *si, const char *ti=
tle, int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+p=
rint_signal(const struct signal_info *si, const char *title, unsigned int m=
sglevel)</span><br><span> {</span><br><span>     if (si)</span><br><span>  =
   {</span><br><span>diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h</sp=
an><br><span>index 7e5dd9f..06558d7 100644</span><br><span>--- a/src/openvp=
n/sig.h</span><br><span>+++ b/src/openvpn/sig.h</span><br><span>@@ -66,7 +6=
6,7 @@</span><br><span> </span><br><span> void restore_signal_state(void);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void=
 print_signal(const struct signal_info *si, const char *title, int msglevel=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void print_signal=
(const struct signal_info *si, const char *title, unsigned int msglevel);</=
span><br><span> </span><br><span> void print_status(struct context *c, stru=
ct status_output *so);</span><br><span> </span><br><span>diff --git a/src/o=
penvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 248c690..6f735=
14 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/=
src/openvpn/socket.c</span><br><span>@@ -83,7 +83,7 @@</span><br><span> sta=
tic int</span><br><span> get_addr_generic(sa_family_t af, unsigned int flag=
s, const char *hostname, void *network,</span><br><span>                  u=
nsigned int *netbits, int resolve_retry_seconds, struct signal_info *sig_in=
fo,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 i=
nt msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
          unsigned int msglevel)</span><br><span> {</span><br><span>     ch=
ar *endp, *sep, *var_host =3D NULL;</span><br><span>     struct addrinfo *a=
i =3D NULL;</span><br><span>@@ -216,7 +216,8 @@</span><br><span> }</span><b=
r><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-get_ipv6_addr(const char *hostname, struct in6_addr *network, uns=
igned int *netbits, int msglevel)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+get_ipv6_addr(const char *hostname, struct in6_addr *network,=
 unsigned int *netbits,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+              unsigned int msglevel)</span><br><span> {</span><br><span=
>     if (get_addr_generic(AF_INET6, GETADDR_RESOLVE, hostname, network, ne=
tbits, 0, NULL, msglevel)</span><br><span>         &lt; 0)</span><br><span>=
@@ -1521,7 +1522,7 @@</span><br><span> linksock_print_addr(struct link_sock=
et *sock)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc=
_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int =
msglevel =3D (sock-&gt;mode =3D=3D LS_MODE_TCP_ACCEPT_FROM) ? D_INIT_MEDIUM=
 : M_INFO;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 unsigned int msglevel =3D (sock-&gt;mode =3D=3D LS_MODE_TCP_ACCEPT_FROM) ?=
 D_INIT_MEDIUM : M_INFO;</span><br><span> </span><br><span>     /* print lo=
cal address */</span><br><span>     if (sock-&gt;bind_local)</span><br><spa=
n>diff --git a/src/openvpn/socket_util.c b/src/openvpn/socket_util.c</span>=
<br><span>index 9b7312d..454b151 100644</span><br><span>--- a/src/openvpn/s=
ocket_util.c</span><br><span>+++ b/src/openvpn/socket_util.c</span><br><spa=
n>@@ -541,7 +541,7 @@</span><br><span>     struct addrinfo hints;</span><br=
><span>     int status;</span><br><span>     struct signal_info sigrec =3D =
{ 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int msgleve=
l =3D (flags &amp; GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int msglevel =3D (=
flags &amp; GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;</span><br><span>  =
   struct gc_arena gc =3D gc_new();</span><br><span>     const char *print_=
hostname;</span><br><span>     const char *print_servname;</span><br><span>=
@@ -604,7 +604,7 @@</span><br><span>         int resolve_retries =3D</span>=
<br><span>             (flags &amp; GETADDR_TRY_ONCE) ? 1 : ((resolve_retry=
_seconds + 4) / fail_wait_interval);</span><br><span>         const char *f=
mt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int level =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        unsig=
ned int level =3D 0;</span><br><span> </span><br><span>         /* this is =
not a numeric IP, therefore force resolution using the</span><br><span>    =
      * provided ai_family */</span><br><span>@@ -739,7 +739,7 @@</span><br=
><span> done:</span><br><span>     if (sig_info &amp;&amp; sig_info-&gt;sig=
nal_received)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        int level =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        unsigned int level =3D 0;</span><br><span>     =
    if (flags &amp; GETADDR_FATAL_ON_SIGNAL)</span><br><span>         {</sp=
an><br><span>             level =3D M_FATAL;</span><br><span>diff --git a/s=
rc/openvpn/socket_util.h b/src/openvpn/socket_util.h</span><br><span>index =
361edff..8a30527 100644</span><br><span>--- a/src/openvpn/socket_util.h</sp=
an><br><span>+++ b/src/openvpn/socket_util.h</span><br><span>@@ -142,7 +142=
,7 @@</span><br><span>  * Translate an IPv6 addr or hostname from string fo=
rm to in6_addr</span><br><span>  */</span><br><span> bool get_ipv6_addr(con=
st char *hostname, struct in6_addr *network, unsigned int *netbits,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                   int msglev=
el);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
    unsigned int msglevel);</span><br><span> </span><br><span> int openvpn_=
getaddrinfo(unsigned int flags, const char *hostname, const char *servname,=
</span><br><span>                         int resolve_retry_seconds, struct=
 signal_info *sig_info, int ai_family,</span><br><span>diff --git a/src/ope=
nvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h</span><br><spa=
n>index a0559c9..af7a08f 100644</span><br><span>--- a/src/openvpn/ssl_verif=
y_backend.h</span><br><span>+++ b/src/openvpn/ssl_verify_backend.h</span><b=
r><span>@@ -193,8 +193,8 @@</span><br><span>  * @param gc            Garbag=
e collection arena for temp data</span><br><span>  *</span><br><span>  */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-void x509_track_add(con=
st struct x509_track **ll_head, const char *name, int msglevel,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    struct gc_are=
na *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void x509_t=
rack_add(const struct x509_track **ll_head, const char *name,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    unsigned int =
msglevel, struct gc_arena *gc);</span><br><span> </span><br><span> /*</span=
><br><span>  * Save X509 fields to environment, using the naming convention=
:</span><br><span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openv=
pn/ssl_verify_mbedtls.c</span><br><span>index a2c702d..2ea410d 100644</span=
><br><span>--- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/src=
/openvpn/ssl_verify_mbedtls.c</span><br><span>@@ -359,7 +359,7 @@</span><br=
><span> }</span><br><span> </span><br><span> void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-x509_track_add(const struct x509_track **ll_hea=
d, const char *name, int msglevel,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+x509_track_add(const struct x509_track **ll_head, const char=
 *name, unsigned int msglevel,</span><br><span>                struct gc_ar=
ena *gc)</span><br><span> {</span><br><span>     struct x509_track *xt;</sp=
an><br><span>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ss=
l_verify_openssl.c</span><br><span>index 122101c..e3c18a4 100644</span><br>=
<span>--- a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/src/open=
vpn/ssl_verify_openssl.c</span><br><span>@@ -414,7 +414,7 @@</span><br><spa=
n>  */</span><br><span> </span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-x509_track_add(const struct x509_track **ll_head, =
const char *name, int msglevel,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+x509_track_add(const struct x509_track **ll_head, const char *n=
ame, unsigned int msglevel,</span><br><span>                struct gc_arena=
 *gc)</span><br><span> {</span><br><span>     struct x509_track *xt;</span>=
<br><span>diff --git a/src/openvpn/status.c b/src/openvpn/status.c</span><b=
r><span>index fbd2168..a9f9498 100644</span><br><span>--- a/src/openvpn/sta=
tus.c</span><br><span>+++ b/src/openvpn/status.c</span><br><span>@@ -235,14=
 +235,13 @@</span><br><span> </span><br><span>         if (so-&gt;msglevel =
&gt;=3D 0 &amp;&amp; !so-&gt;errors)</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            msg(so-&gt;msglevel, =
&quot;%s&quot;, buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg((unsigned int)so-&gt;msglevel, &quot;%s&quot;, buf);</spa=
n><br><span>         }</span><br><span> </span><br><span>         if (so-&g=
t;fd &gt;=3D 0 &amp;&amp; !so-&gt;errors)</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            int len;</span><=
br><span>             strcat(buf, &quot;\n&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            len =3D strlen(buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            size_t len =3D strlen=
(buf);</span><br><span>             if (len &gt; 0)</span><br><span>       =
      {</span><br><span>                 if (write(so-&gt;fd, buf, len) !=
=3D len)</span><br><span>diff --git a/src/openvpn/status.h b/src/openvpn/st=
atus.h</span><br><span>index 0c7a869..25e1663 100644</span><br><span>--- a/=
src/openvpn/status.h</span><br><span>+++ b/src/openvpn/status.h</span><br><=
span>@@ -53,6 +53,7 @@</span><br><span> </span><br><span>     char *filenam=
e;</span><br><span>     int fd;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* NB: -1 is used to indicate that output should only go to=
 the file */</span><br><span>     int msglevel;</span><br><span>     const =
struct virtual_output *vout;</span><br><span> </span><br><span>diff --git a=
/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index d299e81..308a2=
83 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src=
/openvpn/tun.c</span><br><span>@@ -105,9 +105,9 @@</span><br><span> static =
void netsh_set_dns6_servers(const struct in6_addr *addr_list, const int add=
r_len,</span><br><span>                                    DWORD adapter_in=
dex);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-static void netsh_command(const struct argv *a, int n, int msglevel);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void netsh_comma=
nd(const struct argv *a, int n, unsigned int msglevel);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void exec_comman=
d(const char *prefix, const struct argv *a, int n, int msglevel);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void exec_command(cons=
t char *prefix, const struct argv *a, int n, unsigned int msglevel);</span>=
<br><span> </span><br><span> static const char *netsh_get_id(const char *de=
v_node, struct gc_arena *gc);</span><br><span> </span><br><span>@@ -4035,7 =
+4035,7 @@</span><br><span> }</span><br><span> </span><br><span> void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-show_tap_win_adapters(int m=
sglev, int warnlev)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
show_tap_win_adapters(unsigned int msglevel, unsigned int warnlevel)</span>=
<br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><b=
r><span> </span><br><span>@@ -4052,7 +4052,7 @@</span><br><span>     const =
struct tap_reg *tap_reg =3D get_tap_reg(&amp;gc);</span><br><span>     cons=
t struct panel_reg *panel_reg =3D get_panel_reg(&amp;gc);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(msglev, &quot=
;Available adapters [name, GUID, driver]:&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    msg(msglevel, &quot;Available adapters [n=
ame, GUID, driver]:&quot;);</span><br><span> </span><br><span>     /* loop =
through each TAP-Windows adapter registry entry */</span><br><span>     for=
 (tr =3D tap_reg; tr !=3D NULL; tr =3D tr-&gt;next)</span><br><span>@@ -406=
4,7 +4064,7 @@</span><br><span>         {</span><br><span>             if (=
!strcmp(tr-&gt;guid, pr-&gt;guid))</span><br><span>             {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                msg(msglev, &qu=
ot;&#39;%s&#39; %s %s&quot;, pr-&gt;name, tr-&gt;guid,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;&#39=
;%s&#39; %s %s&quot;, pr-&gt;name, tr-&gt;guid,</span><br><span>           =
          print_tun_backend_driver(tr-&gt;windows_driver));</span><br><span=
>                 ++links;</span><br><span>             }</span><br><span>@=
@ -4079,7 +4079,7 @@</span><br><span>             /* a TAP adapter exists w=
ithout a link from the network</span><br><span>              * connections =
control panel */</span><br><span>             warn_panel_null =3D true;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msglev, &=
quot;[NULL] %s&quot;, tr-&gt;guid);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(msglevel, &quot;[NULL] %s&quot;, tr-&gt;gui=
d);</span><br><span>         }</span><br><span>     }</span><br><span> </sp=
an><br><span>@@ -4098,18 +4098,18 @@</span><br><span>     /* warn on regist=
ry inconsistencies */</span><br><span>     if (warn_tap_dup)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(w=
arnlev, &quot;WARNING: Some TAP-Windows adapters have duplicate GUIDs&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(warnl=
evel, &quot;WARNING: Some TAP-Windows adapters have duplicate GUIDs&quot;);=
</span><br><span>     }</span><br><span> </span><br><span>     if (warn_pan=
el_dup)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msg(warnlev,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        msg(warnlevel,</span><br><span>             &quot;WARNING=
: Some TAP-Windows adapters have duplicate links from the Network Connectio=
ns control panel&quot;);</span><br><span>     }</span><br><span> </span><br=
><span>     if (warn_panel_null)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        msg(warnlev,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(warnlevel,</span><br><span> =
            &quot;WARNING: Some TAP-Windows adapters have no link from the =
Network Connections control panel&quot;);</span><br><span>     }</span><br>=
<span> </span><br><span>@@ -4839,31 +4839,31 @@</span><br><span>  * Show in=
fo for a single adapter</span><br><span>  */</span><br><span> static void</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-show_adapter(int msglev=
, const IP_ADAPTER_INFO *a, struct gc_arena *gc)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+show_adapter(unsigned int msglevel, const IP_A=
DAPTER_INFO *a, struct gc_arena *gc)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    msg(msglev, &quot;%s&quot;, a-&gt;Des=
cription);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(msg=
lev, &quot;  Index =3D %d&quot;, (int)a-&gt;Index);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(msglev, &quot;  GUID =3D %s&quot;, =
a-&gt;AdapterName);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  msg(msglev, &quot;  IP =3D %s&quot;, format_ip_addr_string(&amp;a-&gt;IpA=
ddressList, gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
msg(msglev, &quot;  MAC =3D %s&quot;, format_hex_ex(a-&gt;Address, a-&gt;Ad=
dressLength, 0, 1, &quot;:&quot;, gc));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    msg(msglev, &quot;  GATEWAY =3D %s&quot;, format_ip_a=
ddr_string(&amp;a-&gt;GatewayList, gc));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    msg(msglevel, &quot;%s&quot;, a-&gt;Description);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(msglevel, &q=
uot;  Index =3D %d&quot;, (int)a-&gt;Index);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    msg(msglevel, &quot;  GUID =3D %s&quot;, a-&gt=
;AdapterName);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
sg(msglevel, &quot;  IP =3D %s&quot;, format_ip_addr_string(&amp;a-&gt;IpAd=
dressList, gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 msg(msglevel, &quot;  MAC =3D %s&quot;, format_hex_ex(a-&gt;Address, a-&gt=
;AddressLength, 0, 1, &quot;:&quot;, gc));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    msg(msglevel, &quot;  GATEWAY =3D %s&quot;, form=
at_ip_addr_string(&amp;a-&gt;GatewayList, gc));</span><br><span>     if (a-=
&gt;DhcpEnabled)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        msg(msglev, &quot;  DHCP SERV =3D %s&quot;, forma=
t_ip_addr_string(&amp;a-&gt;DhcpServer, gc));</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        msg(msglev, &quot;  DHCP LEASE OBTAINED =3D=
 %s&quot;, time_string(a-&gt;LeaseObtained, 0, false, gc));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        msg(msglev, &quot;  DHCP LEAS=
E EXPIRES  =3D %s&quot;, time_string(a-&gt;LeaseExpires, 0, false, gc));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, =
&quot;  DHCP SERV =3D %s&quot;, format_ip_addr_string(&amp;a-&gt;DhcpServer=
, gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
msglevel, &quot;  DHCP LEASE OBTAINED =3D %s&quot;, time_string(a-&gt;Lease=
Obtained, 0, false, gc));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(msglevel, &quot;  DHCP LEASE EXPIRES  =3D %s&quot;, time_=
string(a-&gt;LeaseExpires, 0, false, gc));</span><br><span>     }</span><br=
><span>     if (a-&gt;HaveWins)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        msg(msglev, &quot;  PRI WINS =3D %=
s&quot;, format_ip_addr_string(&amp;a-&gt;PrimaryWinsServer, gc));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        msg(msglev, &quot;  SE=
C WINS =3D %s&quot;, format_ip_addr_string(&amp;a-&gt;SecondaryWinsServer, =
gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(ms=
glevel, &quot;  PRI WINS =3D %s&quot;, format_ip_addr_string(&amp;a-&gt;Pri=
maryWinsServer, gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(msglevel, &quot;  SEC WINS =3D %s&quot;, format_ip_addr_strin=
g(&amp;a-&gt;SecondaryWinsServer, gc));</span><br><span>     }</span><br><s=
pan> </span><br><span>     {</span><br><span>         const IP_PER_ADAPTER_=
INFO *pai =3D get_per_adapter_info(a-&gt;Index, gc);</span><br><span>      =
   if (pai)</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            msg(msglev, &quot;  DNS SERV =3D %s&quot;, for=
mat_ip_addr_string(&amp;pai-&gt;DnsServerList, gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;  DNS SER=
V =3D %s&quot;, format_ip_addr_string(&amp;pai-&gt;DnsServerList, gc));</sp=
an><br><span>         }</span><br><span>     }</span><br><span> }</span><br=
><span>@@ -4872,12 +4872,12 @@</span><br><span>  * Show current adapter lis=
t</span><br><span>  */</span><br><span> void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-show_adapters(int msglev)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+show_adapters(unsigned int msglevel)</span><br=
><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><=
span>     const IP_ADAPTER_INFO *ai =3D get_adapter_info_list(&amp;gc);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg=
(msglev, &quot;SYSTEM ADAPTER LIST&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    msg(msglevel, &quot;SYSTEM ADAPTER LIST&quot;);<=
/span><br><span>     if (ai)</span><br><span>     {</span><br><span>       =
  const IP_ADAPTER_INFO *a;</span><br><span>@@ -4885,7 +4885,7 @@</span><br=
><span>         /* find index in the linked list */</span><br><span>       =
  for (a =3D ai; a !=3D NULL; a =3D a-&gt;Next)</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            show_adapt=
er(msglev, a, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            show_adapter(msglevel, a, &amp;gc);</span><br><span>       =
  }</span><br><span>     }</span><br><span>     gc_free(&amp;gc);</span><br=
><span>@@ -5082,7 +5082,7 @@</span><br><span> }</span><br><span> </span><br=
><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ex=
ec_command(const char *prefix, const struct argv *a, int n, int msglevel)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+exec_command(const ch=
ar *prefix, const struct argv *a, int n, unsigned int msglevel)</span><br><=
span> {</span><br><span>     int i;</span><br><span>     for (i =3D 0; i &l=
t; n; ++i)</span><br><span>@@ -5103,7 +5103,7 @@</span><br><span> }</span><=
br><span> </span><br><span> static void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-netsh_command(const struct argv *a, int n, int msglevel)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+netsh_command(const =
struct argv *a, int n, unsigned int msglevel)</span><br><span> {</span><br>=
<span>     exec_command(&quot;NETSH&quot;, a, n, msglevel);</span><br><span=
> }</span><br><span>diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h</spa=
n><br><span>index 06fc729..fd2d270 100644</span><br><span>--- a/src/openvpn=
/tun.h</span><br><span>+++ b/src/openvpn/tun.h</span><br><span>@@ -445,9 +4=
45,9 @@</span><br><span> DWORD adapter_index_of_ip(const IP_ADAPTER_INFO *l=
ist, const in_addr_t ip, int *count,</span><br><span>                      =
     in_addr_t *netmask);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void show_tap_win_adapters(int msglev, int warnlev);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void show_tap_win_ad=
apters(unsigned int msglevel, unsigned int warnlevel);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-void show_adapters(int m=
sglev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void show_ad=
apters(unsigned int msglevel);</span><br><span> </span><br><span> void tap_=
allow_nonadmin_access(const char *dev_node);</span><br><span> </span><br><s=
pan>diff --git a/tests/unit_tests/openvpn/mock_ssl_dependencies.c b/tests/u=
nit_tests/openvpn/mock_ssl_dependencies.c</span><br><span>index 7333c47..3a=
bab43 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_ssl_depend=
encies.c</span><br><span>+++ b/tests/unit_tests/openvpn/mock_ssl_dependenci=
es.c</span><br><span>@@ -38,7 +38,7 @@</span><br><span> </span><br><span> i=
nt</span><br><span> parse_line(const char *line, char **p, const int n, con=
st char *file, const int line_num,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-           int msglevel, struct gc_arena *gc)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+           unsigned int msglevel, st=
ruct gc_arena *gc)</span><br><span> {</span><br><span>     /* Dummy functio=
n to get the linker happy, should never be called */</span><br><span>     a=
ssert_true(false);</span><br><span>diff --git a/tests/unit_tests/openvpn/te=
st_argv.c b/tests/unit_tests/openvpn/test_argv.c</span><br><span>index a658=
57b..a4f9e84 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_arg=
v.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_argv.c</span><br><s=
pan>@@ -23,7 +23,7 @@</span><br><span> </span><br><span> int</span><br><spa=
n> __wrap_parse_line(const char *line, char **p, const int n, const char *f=
ile, const int line_num,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                  int msglevel, struct gc_arena *gc)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                  unsigned int msglevel=
, struct gc_arena *gc)</span><br><span> {</span><br><span>     p[0] =3D PAT=
H1 PATH2;</span><br><span>     p[1] =3D PARAM1;</span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc=
.c</span><br><span>index 3433b73..5348e53 100644</span><br><span>--- a/test=
s/unit_tests/openvpn/test_misc.c</span><br><span>+++ b/tests/unit_tests/ope=
nvpn/test_misc.c</span><br><span>@@ -348,7 +348,7 @@</span><br><span>     a=
ssert_false(valid_integer(&quot;-2147483653&quot;, false));</span><br><span=
> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int msglevel =3D D_LOW;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    unsigned int msglevel =3D D_LOW;</span><br><span>     int saved_=
log_level =3D mock_get_debug_level();</span><br><span>     mock_set_debug_l=
evel(D_LOW);</span><br><span> </span><br><span>diff --git a/tests/unit_test=
s/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c</span><br>=
<span>index 9ba6cfc..1519fd6 100644</span><br><span>--- a/tests/unit_tests/=
openvpn/test_pkcs11.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_p=
kcs11.c</span><br><span>@@ -59,7 +59,7 @@</span><br><span> /* stubs for som=
e unused functions instead of pulling in too many dependencies */</span><br=
><span> int</span><br><span> parse_line(const char *line, char **p, const i=
nt n, const char *file, const int line_num,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-           int msglevel, struct gc_arena *gc)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+           unsigned int msg=
level, struct gc_arena *gc)</span><br><span> {</span><br><span>     assert_=
true(0);</span><br><span>     return 0;</span><br><span>diff --git a/tests/=
unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c</span><=
br><span>index 5122766..f349824 100644</span><br><span>--- a/tests/unit_tes=
ts/openvpn/test_pkt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_p=
kt.c</span><br><span>@@ -45,7 +45,7 @@</span><br><span> </span><br><span> i=
nt</span><br><span> parse_line(const char *line, char **p, const int n, con=
st char *file, const int line_num,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-           int msglevel, struct gc_arena *gc)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+           unsigned int msglevel, st=
ruct gc_arena *gc)</span><br><span> {</span><br><span>     /* Dummy functio=
n to get the linker happy, should never be called */</span><br><span>     a=
ssert_true(false);</span><br><span>diff --git a/tests/unit_tests/openvpn/te=
st_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c</spa=
n><br><span>index 87329b1..8948f7b 100644</span><br><span>--- a/tests/unit_=
tests/openvpn/test_push_update_msg.c</span><br><span>+++ b/tests/unit_tests=
/openvpn/test_push_update_msg.c</span><br><span>@@ -111,7 +111,7 @@</span><=
br><span> </span><br><span> #ifndef ENABLE_MANAGEMENT</span><br><span> bool=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-send_control_channel_=
string(struct context *c, const char *str, int msglevel)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+send_control_channel_string(struct con=
text *c, const char *str, unsigned int msglevel)</span><br><span> {</span><=
br><span>     return true;</span><br><span> }</span><br><span>@@ -120,7 +12=
0,7 @@</span><br><span> int i;</span><br><span> </span><br><span> bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-send_control_channel_strin=
g(struct context *c, const char *str, int msglevel)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+send_control_channel_string(struct contex=
t *c, const char *str, unsigned int msglevel)</span><br><span> {</span><br>=
<span>     if (res &amp;&amp; res[i] &amp;&amp; strcmp(res[i], str))</span>=
<br><span>     {</span><br><span>diff --git a/tests/unit_tests/openvpn/test=
_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>in=
dex 532bfcd..e2b2e38 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_tls_crypt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_tls_cr=
ypt.c</span><br><span>@@ -98,7 +98,7 @@</span><br><span> </span><br><span> =
int</span><br><span> __wrap_parse_line(const char *line, char **p, const in=
t n, const char *file, const int line_num,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                  int msglevel, struct gc_arena *gc)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  uns=
igned int msglevel, struct gc_arena *gc)</span><br><span> {</span><br><span=
>     p[0] =3D PATH1 PATH2;</span><br><span>     p[1] =3D PARAM1;</span><br=
><span>diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_=
tests/openvpn/test_user_pass.c</span><br><span>index 460b37f..30b0a73 10064=
4</span><br><span>--- a/tests/unit_tests/openvpn/test_user_pass.c</span><br=
><span>+++ b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>@@ -=
73,7 +73,7 @@</span><br><span> /* stubs for some unused functions instead o=
f pulling in too many dependencies */</span><br><span> int</span><br><span>=
 parse_line(const char *line, char **p, const int n, const char *file, cons=
t int line_num,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
     int msglevel, struct gc_arena *gc)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+           unsigned int msglevel, struct gc_arena *gc)<=
/span><br><span> {</span><br><span>     assert_true(0);</span><br><span>   =
  return 0;</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1110?usp=3Demail">change 1110</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1110?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id492cb774c6d022d06bb3cf5fec=
2a4bdd410e619 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1110 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@...2726...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--PIMVmQXh28k=--

