From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 19 Sep 2025 14:51:40 +0000
In-Reply-To: <gerrit.1753364704000.Id492cb774c6d022d06bb3cf5fec2a4bdd410e619@...2715...>
References: <gerrit.1753364704000.Id492cb774c6d022d06bb3cf5fec2a4bdd410e619@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <8bc89d7a6a3d4beef5166f2e6b21f63e59856d21-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dlby/pvO9xY="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Introduce msglvl_t
 to unify msglevel type handling
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dlby/pvO9xY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
10?usp=3Demail )

Change subject: Introduce msglvl_t to unify msglevel type handling
......................................................................

Introduce msglvl_t to unify msglevel type handling

msglevel was definitely unsigned as the first
argument to msg(), but many parts of the code
had it as signed. So this produced a LOT of
warnings when enabling -Wsign-conversion.

Introduce a msglvl_t typedef and switch all
users to it. This includes any values that
are stored in the msglevel field, including
debug level and mute level.

There is one exception in struct status_output
where -1 is a valid value in the API. Only
positive values are translated into standard
message levels.

Change-Id: Id492cb774c6d022d06bb3cf5fec2a4bdd410e619
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1110
Message-Id: <20250917170428.3310-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
028.html
Signed-off-by: Gert Doering <gert@...1296...>
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
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/mtu.c
M src/openvpn/mtu.h
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/options_util.c
M src/openvpn/options_util.h
M src/openvpn/packet_id.c
M src/openvpn/pkcs11.c
M src/openvpn/plugin.c
M src/openvpn/plugin.h
M src/openvpn/pool.c
M src/openvpn/pool.h
M src/openvpn/proto.c
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
M tests/unit_tests/openvpn/mock_msg.c
M tests/unit_tests/openvpn/mock_msg.h
M tests/unit_tests/openvpn/mock_ssl_dependencies.c
M tests/unit_tests/openvpn/test_argv.c
M tests/unit_tests/openvpn/test_misc.c
M tests/unit_tests/openvpn/test_pkcs11.c
M tests/unit_tests/openvpn/test_pkt.c
M tests/unit_tests/openvpn/test_push_update_msg.c
M tests/unit_tests/openvpn/test_socket.c
M tests/unit_tests/openvpn/test_tls_crypt.c
M tests/unit_tests/openvpn/test_user_pass.c
69 files changed, 283 insertions(+), 275 deletions(-)




diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 903fc0a..79b541a 100644
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
+argv_msg(const msglvl_t msglevel, const struct argv *a)
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
+argv_msg_prefix(const msglvl_t msglevel, const struct argv *a, const char =
*prefix)
 {
     struct gc_arena gc =3D gc_new();
-    msg(msglev, "%s: %s", prefix, argv_str(a, &gc, 0));
+    msg(msglevel, "%s: %s", prefix, argv_str(a, &gc, 0));
     gc_free(&gc);
 }

diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index 056fe31..969d7b1 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -47,9 +47,9 @@

 struct argv argv_insert_head(const struct argv *a, const char *head);

-void argv_msg(const int msglev, const struct argv *a);
+void argv_msg(const msglvl_t msglevel, const struct argv *a);

-void argv_msg_prefix(const int msglev, const struct argv *a, const char *p=
refix);
+void argv_msg_prefix(const msglvl_t msglevel, const struct argv *a, const =
char *prefix);

 void argv_parse_cmd(struct argv *a, const char *s);

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 0f0d17e..c0b85b2 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1127,7 +1127,7 @@
 {
     if (buf && buf->len)
     {
-        int msglevel =3D D_ALIGN_DEBUG;
+        msglvl_t msglevel =3D D_ALIGN_DEBUG;
         const unsigned int u =3D (unsigned int)BPTR(buf);

         if (u & (PAYLOAD_ALIGN - 1))
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 48a2057..b49d4bb 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -47,7 +47,7 @@
 }

 void
-print_client_nat_list(const struct client_nat_option_list *list, int msgle=
vel)
+print_client_nat_list(const struct client_nat_option_list *list, msglvl_t =
msglevel)
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
+                              msglvl_t msglevel)
 {
     struct client_nat_entry e;
     bool ok;
@@ -159,7 +159,7 @@
 #endif

 static void
-print_pkt(struct openvpn_iphdr *iph, const char *prefix, const int directi=
on, const int msglevel)
+print_pkt(struct openvpn_iphdr *iph, const char *prefix, const int directi=
on, const msglvl_t msglevel)
 {
     struct gc_arena gc =3D gc_new();

diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index abfa0b7..7d787e0 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -54,11 +54,11 @@
 void copy_client_nat_option_list(struct client_nat_option_list *dest,
                                  const struct client_nat_option_list *src);

-void print_client_nat_list(const struct client_nat_option_list *list, int =
msglevel);
+void print_client_nat_list(const struct client_nat_option_list *list, msgl=
vl_t msglevel);

 void add_client_nat_to_option_list(struct client_nat_option_list *dest, co=
nst char *type,
                                    const char *network, const char *netmas=
k,
-                                   const char *foreign_network, int msglev=
el);
+                                   const char *foreign_network, msglvl_t m=
sglevel);

 void client_nat_transform(const struct client_nat_option_list *list, struc=
t buffer *ipbuf,
                           const int direction);
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 1a2e775..9d35141 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -159,7 +159,7 @@
 #endif /* USE_COMP */

 bool
-check_compression_settings_valid(struct compress_options *info, int msglev=
el)
+check_compression_settings_valid(struct compress_options *info, msglvl_t m=
sglevel)
 {
     /*
      * We also allow comp-stub-v2 here as it technically allows escaping of
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 0354896..1717029 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -84,12 +84,14 @@
            && info->alg !=3D COMP_ALG_UNDEF;
 }

+#include "error.h"
+
 /**
  * Checks if the compression settings are valid. Takes into account the
  * flags of allow-compression and also the whether algorithms are compiled
  * in
  */
-bool check_compression_settings_valid(struct compress_options *info, int m=
sglevel);
+bool check_compression_settings_valid(struct compress_options *info, msglv=
l_t msglevel);

 #ifdef USE_COMP
 #include "buffer.h"
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 4c0f684..0abcd7f 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1609,7 +1609,7 @@
 }

 int
-ascii2keydirection(int msglevel, const char *str)
+ascii2keydirection(msglvl_t msglevel, const char *str)
 {
     if (!str)
     {
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index efd7f60..d69db59 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -618,7 +618,7 @@

 void must_have_n_keys(const char *filename, const char *option, const stru=
ct key2 *key2, int n);

-int ascii2keydirection(int msglevel, const char *str);
+int ascii2keydirection(msglvl_t msglevel, const char *str);

 const char *keydirection2ascii(int kd, bool remote, bool humanreadable);

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 70a8c0a..881459c 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -233,7 +233,7 @@
 }

 static bool
-dco_check_option_ce(const struct connection_entry *ce, int msglevel, int m=
ode)
+dco_check_option_ce(const struct connection_entry *ce, msglvl_t msglevel, =
int mode)
 {
     if (ce->fragment)
     {
@@ -293,7 +293,7 @@
 }

 bool
-dco_check_startup_option(int msglevel, const struct options *o)
+dco_check_startup_option(msglvl_t msglevel, const struct options *o)
 {
     /* check if no dev name was specified at all. In the case,
      * later logic will most likely stop OpenVPN, so no need to
@@ -430,7 +430,7 @@
 }

 bool
-dco_check_option(int msglevel, const struct options *o)
+dco_check_option(msglvl_t msglevel, const struct options *o)
 {
     /* At this point the ciphers have already been normalised */
     if (o->enable_ncp_fallback
@@ -480,7 +480,7 @@
 }

 bool
-dco_check_pull_options(int msglevel, const struct options *o)
+dco_check_pull_options(msglvl_t msglevel, const struct options *o)
 {
     if (!o->use_peer_id)
     {
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 59acb18..a362977 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -55,7 +55,7 @@
  * @param msglevel      level to print messages to
  * @return              true if ovpn-dco is available, false otherwise
  */
-bool dco_available(int msglevel);
+bool dco_available(msglvl_t msglevel);


 /**
@@ -75,7 +75,7 @@
  * @param o         the options struct that hold the options
  * @return          true if no conflict was detected, false otherwise
  */
-bool dco_check_option(int msglevel, const struct options *o);
+bool dco_check_option(msglvl_t msglevel, const struct options *o);

 /**
  * Check whether the options struct has any further option that is not sup=
ported
@@ -87,7 +87,7 @@
  * @param o         the options struct that hold the options
  * @return          true if no conflict was detected, false otherwise
  */
-bool dco_check_startup_option(int msglevel, const struct options *o);
+bool dco_check_startup_option(msglvl_t msglevel, const struct options *o);

 /**
  * Check whether any of the options pushed by the server is not supported =
by
@@ -98,7 +98,7 @@
  * @param o         the options struct that hold the options
  * @return          true if no conflict was detected, false otherwise
  */
-bool dco_check_pull_options(int msglevel, const struct options *o);
+bool dco_check_pull_options(msglvl_t msglevel, const struct options *o);

 /**
  * Initialize the DCO context
@@ -261,7 +261,7 @@
 typedef void *dco_context_t;

 static inline bool
-dco_available(int msglevel)
+dco_available(msglvl_t msglevel)
 {
     return false;
 }
@@ -273,19 +273,19 @@
 }

 static inline bool
-dco_check_option(int msglevel, const struct options *o)
+dco_check_option(msglvl_t msglevel, const struct options *o)
 {
     return false;
 }

 static inline bool
-dco_check_startup_option(int msglevel, const struct options *o)
+dco_check_startup_option(msglvl_t msglevel, const struct options *o)
 {
     return false;
 }

 static inline bool
-dco_check_pull_options(int msglevel, const struct options *o)
+dco_check_pull_options(msglvl_t msglevel, const struct options *o)
 {
     return false;
 }
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 65303cd..d5ca277 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -658,7 +658,7 @@
 }
=20
 bool
-dco_available(int msglevel)
+dco_available(msglvl_t msglevel)
 {
     struct if_clonereq ifcr;
     char *buf =3D NULL;
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 40674e7..d8357ca 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -74,7 +74,7 @@
  * @return ID on success, negative error code on error
  */
 static int
-resolve_ovpn_netlink_id(int msglevel)
+resolve_ovpn_netlink_id(msglvl_t msglevel)
 {
     int ret;
     struct nl_sock *nl_sock =3D nl_socket_alloc();
@@ -1199,7 +1199,7 @@
 }

 bool
-dco_available(int msglevel)
+dco_available(msglvl_t msglevel)
 {
     if (resolve_ovpn_netlink_id(D_DCO_DEBUG) < 0)
     {
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 01ba017..2d08ed8 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -599,7 +599,7 @@
 }

 bool
-dco_available(int msglevel)
+dco_available(msglvl_t msglevel)
 {
     /* try to open device by symbolic name */
     HANDLE h =3D CreateFile("\\\\.\\ovpn-dco", GENERIC_READ | GENERIC_WRIT=
E, 0, NULL, OPEN_EXISTING,
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 5421004..efb888a 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -200,7 +200,7 @@
 }

 bool
-dns_options_verify(int msglevel, const struct dns_options *o)
+dns_options_verify(msglvl_t msglevel, const struct dns_options *o)
 {
     const struct dns_server *server =3D o->servers ? o->servers : o->serve=
rs_prepull;
     while (server)
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 6d97b40..6cd98f2 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -166,7 +166,7 @@
  * @param   o           Pointer to the DNS options to validate
  * @return              True if no error was found
  */
-bool dns_options_verify(int msglevel, const struct dns_options *o);
+bool dns_options_verify(msglvl_t msglevel, const struct dns_options *o);

 /**
  * Makes a deep copy of the passed DNS options.
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index 6c7df8e..2ae71ab 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -209,7 +209,7 @@
 }
=20
 void
-env_set_print(int msglevel, const struct env_set *es)
+env_set_print(msglvl_t msglevel, const struct env_set *es)
 {
     if (check_debug_level(msglevel))
     {
diff --git a/src/openvpn/env_set.h b/src/openvpn/env_set.h
index 3973a4e..ddcfa14 100644
--- a/src/openvpn/env_set.h
+++ b/src/openvpn/env_set.h
@@ -85,7 +85,7 @@

 const char *env_set_get(const struct env_set *es, const char *name);

-void env_set_print(int msglevel, const struct env_set *es);
+void env_set_print(msglvl_t msglevel, const struct env_set *es);

 /**
  * Write a struct env_set to a file. Each item on one line.
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 1b98235..58c2fd1 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -48,12 +48,12 @@
 #endif

 /* Globals */
-unsigned int x_debug_level; /* GLOBAL */
+msglvl_t x_debug_level; /* GLOBAL */

 /* Mute state */
-static int mute_cutoff;   /* GLOBAL */
-static int mute_count;    /* GLOBAL */
-static int mute_category; /* GLOBAL */
+static int mute_cutoff;        /* GLOBAL */
+static int mute_count;         /* GLOBAL */
+static msglvl_t mute_category; /* GLOBAL */

 /*
  * Output mode priorities are as follows:
@@ -103,16 +103,14 @@
 bool
 set_debug_level(const int level, const unsigned int flags)
 {
-    const int ceiling =3D 15;
-
-    if (level >=3D 0 && level <=3D ceiling)
+    if (level >=3D 0 && level <=3D M_DEBUG_LEVEL)
     {
-        x_debug_level =3D level;
+        x_debug_level =3D (msglvl_t)level;
         return true;
     }
     else if (flags & SDL_CONSTRAIN)
     {
-        x_debug_level =3D constrain_int(level, 0, ceiling);
+        x_debug_level =3D (msglvl_t)constrain_int(level, 0, M_DEBUG_LEVEL);
         return true;
     }
     return false;
@@ -132,7 +130,7 @@
     }
 }

-int
+msglvl_t
 get_debug_level(void)
 {
     return x_debug_level;
@@ -190,7 +188,7 @@
  * Return a file to print messages to before syslog is opened.
  */
 FILE *
-msg_fp(const unsigned int flags)
+msg_fp(const msglvl_t flags)
 {
     FILE *fp =3D msgfp;
     if (!fp)
@@ -214,7 +212,7 @@
 int x_msg_line_num; /* GLOBAL */

 void
-x_msg(const unsigned int flags, const char *format, ...)
+x_msg(const msglvl_t flags, const char *format, ...)
 {
     va_list arglist;
     va_start(arglist, format);
@@ -235,7 +233,7 @@
 }

 void
-x_msg_va(const unsigned int flags, const char *format, va_list arglist)
+x_msg_va(const msglvl_t flags, const char *format, va_list arglist)
 {
     struct gc_arena gc;
 #if SYSLOG_CAPABILITY
@@ -385,13 +383,13 @@
  * Apply muting filter.
  */
 bool
-dont_mute(unsigned int flags)
+dont_mute(msglvl_t flags)
 {
     bool ret =3D true;
     if (mute_cutoff > 0 && !(flags & M_NOMUTE))
     {
-        const int mute_level =3D DECODE_MUTE_LEVEL(flags);
-        if (mute_level > 0 && mute_level =3D=3D mute_category)
+        const msglvl_t mute_level =3D DECODE_MUTE_LEVEL(flags);
+        if (mute_level =3D=3D mute_category)
         {
             if (mute_count =3D=3D mute_cutoff)
             {
@@ -750,7 +748,7 @@
  * Translate msg flags into a string
  */
 const char *
-msg_flags_string(const unsigned int flags, struct gc_arena *gc)
+msg_flags_string(const msglvl_t flags, struct gc_arena *gc)
 {
     struct buffer out =3D alloc_buf_gc(16, gc);
     if (flags =3D=3D M_INFO)
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 8388f82..2913498 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -74,31 +74,33 @@
 #define openvpn_errno() errno
 #endif

+typedef unsigned int msglvl_t;
+
 /*
  * These globals should not be accessed directly,
  * but rather through macros or inline functions defined below.
  */
-extern unsigned int x_debug_level;
+extern msglvl_t x_debug_level;
 extern int x_msg_line_num;

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
@@ -112,7 +114,7 @@
  * A mute level of 0 is always printed.
  */
 #define MUTE_LEVEL_SHIFT 24
-#define MUTE_LEVEL_MASK  0xFF
+#define MUTE_LEVEL_MASK  0xFFu

 #define ENCODE_MUTE_LEVEL(mute_level) (((mute_level) & MUTE_LEVEL_MASK) <<=
 MUTE_LEVEL_SHIFT)
 #define DECODE_MUTE_LEVEL(flags)      (((flags) >> MUTE_LEVEL_SHIFT) & MUT=
E_LEVEL_MASK)
@@ -135,7 +137,7 @@
  */

 /** Check muting filter */
-bool dont_mute(unsigned int flags);
+bool dont_mute(msglvl_t flags);

 /* Macro to ensure (and teach static analysis tools) we exit on fatal erro=
rs */
 #define EXIT_FATAL(flags)      \
@@ -170,7 +172,7 @@
 #define dmsg(flags, ...)
 #endif

-void x_msg(const unsigned int flags, const char *format, ...)
+void x_msg(const msglvl_t flags, const char *format, ...)
 #ifdef __GNUC__
 #if __USE_MINGW_ANSI_STDIO
     __attribute__((format(gnu_printf, 2, 3)))
@@ -180,7 +182,7 @@
 #endif
     ; /* should be called via msg above */

-void x_msg_va(const unsigned int flags, const char *format, va_list arglis=
t);
+void x_msg_va(const msglvl_t flags, const char *format, va_list arglist);

 /*
  * Function prototypes
@@ -201,16 +203,16 @@

 bool set_mute_cutoff(const int cutoff);

-int get_debug_level(void);
+msglvl_t get_debug_level(void);

 int get_mute_cutoff(void);

-const char *msg_flags_string(const unsigned int flags, struct gc_arena *gc=
);
+const char *msg_flags_string(const msglvl_t flags, struct gc_arena *gc);

 /*
  * File to print messages to before syslog is opened.
  */
-FILE *msg_fp(const unsigned int flags);
+FILE *msg_fp(const msglvl_t flags);

 /* Fatal logic errors */
 #ifndef ENABLE_SMALL
@@ -254,14 +256,14 @@
 /* Inline functions */

 static inline bool
-check_debug_level(unsigned int level)
+check_debug_level(msglvl_t level)
 {
     return (level & M_DEBUG_LEVEL) <=3D x_debug_level;
 }

 /** Return true if flags represent an enabled, not muted log level */
 static inline bool
-msg_test(unsigned int flags)
+msg_test(msglvl_t flags)
 {
     return check_debug_level(flags) && dont_mute(flags);
 }
@@ -400,8 +402,8 @@
 }

 /** Convert fatal errors to nonfatal, don't touch other errors */
-static inline unsigned int
-nonfatal(const unsigned int err)
+static inline msglvl_t
+nonfatal(const msglvl_t err)
 {
     return err & M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err;
 }
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 5d22fa3..12dd6a7 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -368,7 +368,8 @@
 }

 bool
-send_control_channel_string_dowork(struct tls_session *session, const char=
 *str, int msglevel)
+send_control_channel_string_dowork(struct tls_session *session, const char=
 *str,
+                                   msglvl_t msglevel)
 {
     struct gc_arena gc =3D gc_new();
     bool stat;
@@ -395,7 +396,7 @@
 }

 bool
-send_control_channel_string(struct context *c, const char *str, int msglev=
el)
+send_control_channel_string(struct context *c, const char *str, msglvl_t m=
sglevel)
 {
     if (c->c2.tls_multi)
     {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 79d0f8b..a575faf 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -285,7 +285,7 @@
  * @param str        - The message to be sent
  * @param msglevel   - Message level to use for logging
  */
-bool send_control_channel_string(struct context *c, const char *str, int m=
sglevel);
+bool send_control_channel_string(struct context *c, const char *str, msglv=
l_t msglevel);

 /*
  * Send a string to remote over the TLS control channel.
@@ -303,7 +303,8 @@
  * @param msglevel   - Message level to use for logging
  */
=20
-bool send_control_channel_string_dowork(struct tls_session *session, const=
 char *str, int msglevel);
+bool send_control_channel_string_dowork(struct tls_session *session, const=
 char *str,
+                                        msglvl_t msglevel);


 /**
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2821cd4..0d7a2ec 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4273,7 +4273,7 @@
 }

 void
-management_show_net_callback(void *arg, const int msglevel)
+management_show_net_callback(void *arg, const msglvl_t msglevel)
 {
 #ifdef _WIN32
     show_routes(msglevel);
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index a807874..e89615b 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -136,7 +136,7 @@

 void close_management(void);

-void management_show_net_callback(void *arg, const int msglevel);
+void management_show_net_callback(void *arg, const msglvl_t msglevel);

 #endif

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 4decdfe..c675e95 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1475,7 +1475,7 @@
         }
         else
         {
-            msg(M_CLIENT, "SUCCESS: verb=3D%d", get_debug_level());
+            msg(M_CLIENT, "SUCCESS: verb=3D%u", get_debug_level());
         }
     }
     else if (streq(p[0], "mute"))
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 7c189ba..bff96d3 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -176,7 +176,7 @@
     unsigned int flags;

     void (*status)(void *arg, const int version, struct status_output *so);
-    void (*show_net)(void *arg, const int msglevel);
+    void (*show_net)(void *arg, const msglvl_t msglevel);
     int (*kill_by_cn)(void *arg, const char *common_name);
     int (*kill_by_addr)(void *arg, const in_addr_t addr, const int port, c=
onst int proto);
     void (*delete_event)(void *arg, event_t event);
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index a419e32..9c1a772 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -187,7 +187,7 @@
 }

 void
-frame_print(const struct frame *frame, int level, const char *prefix)
+frame_print(const struct frame *frame, msglvl_t msglevel, const char *pref=
ix)
 {
     struct gc_arena gc =3D gc_new();
     struct buffer out =3D alloc_buf_gc(256, &gc);
@@ -208,7 +208,7 @@
     buf_printf(&out, " ET:%d", frame->extra_tun);
     buf_printf(&out, " ]");
=20
-    msg(level, "%s", out.data);
+    msg(msglevel, "%s", out.data);
     gc_free(&gc);
 }

diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index c092461..3bbff6f 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -181,7 +181,7 @@
  * Function prototypes.
  */

-void frame_print(const struct frame *frame, int level, const char *prefix);
+void frame_print(const struct frame *frame, msglvl_t msglevel, const char =
*prefix);

 void set_mtu_discover_type(socket_descriptor_t sd, int mtu_type, sa_family=
_t proto_af);

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 6e4cc42..8676a09 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3316,7 +3316,7 @@
     }
     else
     {
-        int msglevel =3D D_DCO;
+        msglvl_t msglevel =3D D_DCO;
         if (dco->dco_message_type =3D=3D OVPN_CMD_DEL_PEER
             && dco->dco_del_peer_reason =3D=3D OVPN_DEL_PEER_REASON_USERSP=
ACE)
         {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ae285d9..f1f66b9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1107,7 +1107,7 @@
 #endif /* ifndef _WIN32 */

 static in_addr_t
-get_ip_addr(const char *ip_string, int msglevel, bool *error)
+get_ip_addr(const char *ip_string, msglvl_t msglevel, bool *error)
 {
     unsigned int flags =3D GETADDR_HOST_ORDER;
     bool succeeded =3D false;
@@ -1187,7 +1187,7 @@
  * @param   gc          The returned object will be allocated in this gc
  */
 static struct verify_hash_list *
-parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct g=
c_arena *gc)
+parse_hash_fingerprint(const char *str, int nbytes, msglvl_t msglevel, str=
uct gc_arena *gc)
 {
     int i =3D 0;
     const char *cp =3D str;
@@ -1240,7 +1240,8 @@
  * @param   gc          The returned list items will be allocated in this =
gc
  */
 static struct verify_hash_list *
-parse_hash_fingerprint_multiline(const char *str, int nbytes, int msglevel=
, struct gc_arena *gc)
+parse_hash_fingerprint_multiline(const char *str, int nbytes, msglvl_t msg=
level,
+                                 struct gc_arena *gc)
 {
     struct gc_arena gc_temp =3D gc_new();
     char *lines =3D string_alloc(str, &gc_temp);
@@ -1329,7 +1330,7 @@
 #endif /* ifdef _WIN32 */

 static void
-dhcp_option_dns6_parse(const char *parm, struct in6_addr *dns6_list, int *=
len, int msglevel)
+dhcp_option_dns6_parse(const char *parm, struct in6_addr *dns6_list, int *=
len, msglvl_t msglevel)
 {
     struct in6_addr addr;
     if (*len >=3D N_DHCP_ADDR)
@@ -1344,7 +1345,7 @@
 }
 static void
 dhcp_option_address_parse(const char *name, const char *parm, in_addr_t *a=
rray, int *len,
-                          int msglevel)
+                          msglvl_t msglevel)
 {
     if (*len >=3D N_DHCP_ADDR)
     {
@@ -1480,7 +1481,8 @@
 #endif /* ! ENABLE_SMALL */

 static void
-option_iroute(struct options *o, const char *network_str, const char *netm=
ask_str, int msglevel)
+option_iroute(struct options *o, const char *network_str, const char *netm=
ask_str,
+              msglvl_t msglevel)
 {
     struct iroute *ir;

@@ -1506,7 +1508,7 @@
 }

 static void
-option_iroute_ipv6(struct options *o, const char *prefix_str, int msglevel)
+option_iroute_ipv6(struct options *o, const char *prefix_str, msglvl_t msg=
level)
 {
     struct iroute_ipv6 *ir;

@@ -2063,7 +2065,7 @@
 }

 static struct local_entry *
-alloc_local_entry(struct connection_entry *ce, const int msglevel, struct =
gc_arena *gc)
+alloc_local_entry(struct connection_entry *ce, const msglvl_t msglevel, st=
ruct gc_arena *gc)
 {
     struct local_list *l =3D alloc_local_list_if_undef(ce, gc);
     struct local_entry *e;
@@ -2104,7 +2106,7 @@
 }

 static struct connection_entry *
-alloc_connection_entry(struct options *options, const int msglevel)
+alloc_connection_entry(struct options *options, const msglvl_t msglevel)
 {
     struct connection_list *l =3D alloc_connection_list_if_undef(options);
     struct connection_entry *e;
@@ -2140,7 +2142,7 @@
 }

 static struct remote_entry *
-alloc_remote_entry(struct options *options, const int msglevel)
+alloc_remote_entry(struct options *options, const msglvl_t msglevel)
 {
     struct remote_list *l =3D alloc_remote_list_if_undef(options);
     struct remote_entry *e;
@@ -2694,7 +2696,7 @@

     if (!options->tls_server && !options->tls_client)
     {
-        int msglevel =3D M_USAGE;
+        msglvl_t msglevel =3D M_USAGE;
         if (options->allow_deprecated_insecure_static_crypto)
         {
             msglevel =3D M_INFO;
@@ -4566,8 +4568,9 @@
 }

 static void
-options_warning_safe_scan2(const int msglevel, const int delim, const bool=
 report_inconsistent,
-                           const char *p1, const struct buffer *b2_src, co=
nst char *b1_name,
+options_warning_safe_scan2(const msglvl_t msglevel, const int delim,
+                           const bool report_inconsistent, const char *p1,
+                           const struct buffer *b2_src, const char *b1_nam=
e,
                            const char *b2_name)
 {
     /* We will stop sending 'key-method', 'keydir', 'proto' and 'tls-auth'=
 in
@@ -4619,9 +4622,9 @@
 }

 static void
-options_warning_safe_scan1(const int msglevel, const int delim, const bool=
 report_inconsistent,
-                           const struct buffer *b1_src, const struct buffe=
r *b2_src,
-                           const char *b1_name, const char *b2_name)
+options_warning_safe_scan1(const msglvl_t msglevel, const int delim,
+                           const bool report_inconsistent, const struct bu=
ffer *b1_src,
+                           const struct buffer *b2_src, const char *b1_nam=
e, const char *b2_name)
 {
     struct gc_arena gc =3D gc_new();
     struct buffer b =3D *b1_src;
@@ -4637,7 +4640,7 @@
 }

 static void
-options_warning_safe_ml(const int msglevel, char *actual, const char *expe=
cted, size_t actual_n)
+options_warning_safe_ml(const msglvl_t msglevel, char *actual, const char =
*expected, size_t actual_n)
 {
     struct gc_arena gc =3D gc_new();

@@ -4729,7 +4732,7 @@
  */

 int
-parse_topology(const char *str, const int msglevel)
+parse_topology(const char *str, const msglvl_t msglevel)
 {
     if (streq(str, "net30"))
     {
@@ -4785,7 +4788,7 @@
 }

 bool
-auth_retry_set(const int msglevel, const char *option)
+auth_retry_set(const msglvl_t msglevel, const char *option)
 {
     if (streq(option, "interact"))
     {
@@ -4942,7 +4945,7 @@

 #if 0
 static void
-ping_rec_err(int msglevel)
+ping_rec_err(msglvl_t msglevel)
 {
     msg(msglevel, "only one of --ping-exit or --ping-restart options may b=
e specified");
 }
@@ -4966,7 +4969,7 @@

 int
 parse_line(const char *line, char *p[], const int n, const char *file, con=
st int line_num,
-           int msglevel, struct gc_arena *gc)
+           msglvl_t msglevel, struct gc_arena *gc)
 {
     const int STATE_INITIAL =3D 0;
     const int STATE_READING_QUOTED_PARM =3D 1;
@@ -5271,24 +5274,25 @@
 }

 static void add_option(struct options *options, char *p[], bool is_inline,=
 const char *file,
-                       int line, const int level, const int msglevel,
+                       int line, const int level, const msglvl_t msglevel,
                        const unsigned int permission_mask, unsigned int *o=
ption_types_found,
                        struct env_set *es);

 static void remove_option(struct context *c, struct options *options, char=
 *p[], bool is_inline,
-                          const char *file, int line, const int msglevel,
+                          const char *file, int line, const msglvl_t msgle=
vel,
                           const unsigned int permission_mask, unsigned int=
 *option_types_found,
                           struct env_set *es);

 static void update_option(struct context *c, struct options *options, char=
 *p[], bool is_inline,
-                          const char *file, int line, const int level, con=
st int msglevel,
+                          const char *file, int line, const int level, con=
st msglvl_t msglevel,
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
+                 const int top_line, const msglvl_t msglevel,
+                 const unsigned int permission_mask, unsigned int *option_=
types_found,
+                 struct env_set *es)
 {
     const int max_recursive_levels =3D 10;
     FILE *fp;
@@ -5360,7 +5364,7 @@

 static void
 read_config_string(const char *prefix, struct options *options, const char=
 *config,
-                   const int msglevel, const unsigned int permission_mask,
+                   const msglvl_t msglevel, const unsigned int permission_=
mask,
                    unsigned int *option_types_found, struct env_set *es)
 {
     char line[OPTION_LINE_SIZE];
@@ -5388,7 +5392,7 @@
 }

 void
-parse_argv(struct options *options, const int argc, char *argv[], const in=
t msglevel,
+parse_argv(struct options *options, const int argc, char *argv[], const ms=
glvl_t msglevel,
            const unsigned int permission_mask, unsigned int *option_types_=
found, struct env_set *es)
 {
     /* usage message */
@@ -5457,7 +5461,7 @@
     char line[OPTION_PARM_SIZE];
     int line_num =3D 0;
     const char *file =3D "[PUSH-OPTIONS]";
-    const int msglevel =3D D_PUSH_ERRORS | M_OPTERR;
+    const msglvl_t msglevel =3D D_PUSH_ERRORS | M_OPTERR;
     unsigned int update_options_found =3D 0;

     while (buf_parse(buf, ',', line, sizeof(line)))
@@ -5514,7 +5518,7 @@
 }

 void
-options_server_import(struct options *o, const char *filename, int msgleve=
l,
+options_server_import(struct options *o, const char *filename, msglvl_t ms=
glevel,
                       unsigned int permission_mask, unsigned int *option_t=
ypes_found,
                       struct env_set *es)
 {
@@ -5524,7 +5528,7 @@
 }

 void
-options_string_import(struct options *options, const char *config, const i=
nt msglevel,
+options_string_import(struct options *options, const char *config, const m=
sglvl_t msglevel,
                       const unsigned int permission_mask, unsigned int *op=
tion_types_found,
                       struct env_set *es)
 {
@@ -5543,7 +5547,7 @@

 static bool
 verify_permission(const char *name, const char *file, int line, const unsi=
gned int type,
-                  const unsigned int allowed, unsigned int *found, const i=
nt msglevel,
+                  const unsigned int allowed, unsigned int *found, const m=
sglvl_t msglevel,
                   struct options *options, bool is_inline)
 {
     if (!(type & allowed))
@@ -5595,7 +5599,7 @@
 #define NM_QUOTE_HINT (1 << 0)

 static bool
-no_more_than_n_args(const int msglevel, char *p[], const int max, const un=
signed int flags)
+no_more_than_n_args(const msglvl_t msglevel, char *p[], const int max, con=
st unsigned int flags)
 {
     const int len =3D string_array_len((const char **)p);

@@ -5619,8 +5623,8 @@
     }
 }

-static inline int
-msglevel_forward_compatible(struct options *options, const int msglevel)
+static inline msglvl_t
+msglevel_forward_compatible(struct options *options, const msglvl_t msglev=
el)
 {
     return options->forward_compatible ? M_WARN : msglevel;
 }
@@ -5654,10 +5658,11 @@
  */
 static void
 remove_option(struct context *c, struct options *options, char *p[], bool =
is_inline,
-              const char *file, int line, const int msglevel, const unsign=
ed int permission_mask,
-              unsigned int *option_types_found, struct env_set *es)
+              const char *file, int line, const msglvl_t msglevel,
+              const unsigned int permission_mask, unsigned int *option_typ=
es_found,
+              struct env_set *es)
 {
-    int msglevel_fc =3D msglevel_forward_compatible(options, msglevel);
+    msglvl_t msglevel_fc =3D msglevel_forward_compatible(options, msglevel=
);

     if (streq(p[0], "ifconfig") && !p[1])
     {
@@ -5792,11 +5797,10 @@
 #endif
     else
     {
-        int i;
-        int msglevel_unknown =3D msglevel_fc;
+        msglvl_t msglevel_unknown =3D msglevel_fc;
         /* Check if an option is in --ignore-unknown-option and
          * set warning level to non fatal */
-        for (i =3D 0; options->ignore_unknown_option && options->ignore_un=
known_option[i]; i++)
+        for (int i =3D 0; options->ignore_unknown_option && options->ignor=
e_unknown_option[i]; i++)
         {
             if (streq(p[0], options->ignore_unknown_option[i]))
             {
@@ -5815,7 +5819,7 @@


 static bool
-check_route_option(struct options *options, char *p[], const int msglevel,=
 bool pull_mode)
+check_route_option(struct options *options, char *p[], const msglvl_t msgl=
evel, bool pull_mode)
 {
     rol_check_alloc(options);
     if (pull_mode)
@@ -5843,7 +5847,7 @@


 static bool
-check_route6_option(struct options *options, char *p[], const int msglevel=
, bool pull_mode)
+check_route6_option(struct options *options, char *p[], const msglvl_t msg=
level, bool pull_mode)
 {
     rol6_check_alloc(options);
     if (pull_mode)
@@ -5864,7 +5868,7 @@
 }

 static bool
-check_dns_option(struct options *options, char *p[], const int msglevel, b=
ool pull_mode)
+check_dns_option(struct options *options, char *p[], const msglvl_t msglev=
el, bool pull_mode)
 {
     if (streq(p[1], "search-domains") && p[2])
     {
@@ -5984,7 +5988,7 @@
  */
 static void
 update_option(struct context *c, struct options *options, char *p[], bool =
is_inline,
-              const char *file, int line, const int level, const int msgle=
vel,
+              const char *file, int line, const int level, const msglvl_t =
msglevel,
               const unsigned int permission_mask, unsigned int *option_typ=
es_found,
               struct env_set *es, unsigned int *update_options_found)
 {
@@ -6169,12 +6173,12 @@

 static void
 add_option(struct options *options, char *p[], bool is_inline, const char =
*file, int line,
-           const int level, const int msglevel, const unsigned int permiss=
ion_mask,
+           const int level, const msglvl_t msglevel, const unsigned int pe=
rmission_mask,
            unsigned int *option_types_found, struct env_set *es)
 {
     struct gc_arena gc =3D gc_new();
     const bool pull_mode =3D BOOL_CAST(permission_mask & OPT_P_PULL_MODE);
-    int msglevel_fc =3D msglevel_forward_compatible(options, msglevel);
+    msglvl_t msglevel_fc =3D msglevel_forward_compatible(options, msglevel=
);

     ASSERT(MAX_PARMS >=3D 7);

@@ -9869,7 +9873,7 @@
     else
     {
         int i;
-        int msglevel_unknown =3D msglevel_fc;
+        msglvl_t msglevel_unknown =3D msglevel_fc;
         /* Check if an option is in --ignore-unknown-option and
          * set warning level to non fatal */
         for (i =3D 0; options->ignore_unknown_option && options->ignore_un=
known_option[i]; i++)
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index bb2c052..a737711 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -822,7 +822,7 @@
     struct pull_filter *tail;
 };

-void parse_argv(struct options *options, const int argc, char *argv[], con=
st int msglevel,
+void parse_argv(struct options *options, const int argc, char *argv[], con=
st msglvl_t msglevel,
                 const unsigned int permission_mask, unsigned int *option_t=
ypes_found,
                 struct env_set *es);

@@ -888,7 +888,7 @@

 void options_detach(struct options *o);

-void options_server_import(struct options *o, const char *filename, int ms=
glevel,
+void options_server_import(struct options *o, const char *filename, msglvl=
_t msglevel,
                            unsigned int permission_mask, unsigned int *opt=
ion_types_found,
                            struct env_set *es);

@@ -897,13 +897,13 @@
 void rol_check_alloc(struct options *options);

 int parse_line(const char *line, char *p[], const int n, const char *file,=
 const int line_num,
-               int msglevel, struct gc_arena *gc);
+               msglvl_t msglevel, struct gc_arena *gc);

 /*
  * parse/print topology coding
  */

-int parse_topology(const char *str, const int msglevel);
+int parse_topology(const char *str, const msglvl_t msglevel);

 const char *print_topology(const int topology);

@@ -917,11 +917,11 @@

 int auth_retry_get(void);

-bool auth_retry_set(const int msglevel, const char *option);
+bool auth_retry_set(const msglvl_t msglevel, const char *option);

 const char *auth_retry_print(void);

-void options_string_import(struct options *options, const char *config, co=
nst int msglevel,
+void options_string_import(struct options *options, const char *config, co=
nst msglvl_t msglevel,
                            const unsigned int permission_mask, unsigned in=
t *option_types_found,
                            struct env_set *es);

diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index 5740ee5..cb4229e 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -117,7 +117,7 @@
 }

 int
-positive_atoi(const char *str, int msglevel)
+positive_atoi(const char *str, msglvl_t msglevel)
 {
     char *endptr;
     long long i =3D strtoll(str, &endptr, 10);
@@ -132,7 +132,7 @@
 }

 bool
-positive_atoll(const char *str, int64_t *value, const char *name, int msgl=
evel)
+positive_atoll(const char *str, int64_t *value, const char *name, msglvl_t=
 msglevel)
 {
     char *endptr;
     long long ll =3D strtoll(str, &endptr, 10);
@@ -148,7 +148,7 @@
 }

 int
-atoi_warn(const char *str, int msglevel)
+atoi_warn(const char *str, msglvl_t msglevel)
 {
     char *endptr;
     long long i =3D strtoll(str, &endptr, 10);
@@ -163,7 +163,7 @@
 }

 bool
-atoi_constrained(const char *str, int *value, const char *name, int min, i=
nt max, int msglevel)
+atoi_constrained(const char *str, int *value, const char *name, int min, i=
nt max, msglvl_t msglevel)
 {
     ASSERT(min < max);

diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 45417d9..1492eef 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -37,7 +37,7 @@
  * Converts a str to a positive number if the string represents a postive
  * integer number. Otherwise print a warning with msglevel and return 0
  */
-int positive_atoi(const char *str, int msglevel);
+int positive_atoi(const char *str, msglvl_t msglevel);

 /**
  * Converts a str to an integer if the string can be represented as an
@@ -48,13 +48,13 @@
  *
  * @return \c true if the integer has been parsed and stored in value, \c =
false otherwise
  */
-bool positive_atoll(const char *str, int64_t *value, const char *name, int=
 msglevel);
+bool positive_atoll(const char *str, int64_t *value, const char *name, msg=
lvl_t msglevel);

 /**
  * Converts a str to an integer if the string can be represented as an
  * integer number. Otherwise print a warning with \p msglevel and return 0
  */
-int atoi_warn(const char *str, int msglevel);
+int atoi_warn(const char *str, msglvl_t msglevel);

 /**
  * Converts a str to an integer if the string can be represented as an
@@ -66,7 +66,7 @@
  * @return \c true if the integer has been parsed and stored in value, \c =
false otherwise
  */
 bool atoi_constrained(const char *str, int *value, const char *name, int m=
in, int max,
-                      int msglevel);
+                      msglvl_t msglevel);

 /**
  * Filter an option line by all pull filters.
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 09696db..ca318eb 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -53,15 +53,15 @@
 #define SEQ_EXPIRED ((time_t)1)

 #ifdef ENABLE_DEBUG
-static void packet_id_debug_print(int msglevel, const struct packet_id_rec=
 *p,
+static void packet_id_debug_print(msglvl_t msglevel, const struct packet_i=
d_rec *p,
                                   const struct packet_id_net *pin, const c=
har *message,
                                   packet_id_print_type value);

 #endif /* ENABLE_DEBUG */

 static inline void
-packet_id_debug(int msglevel, const struct packet_id_rec *p, const struct =
packet_id_net *pin,
-                const char *message, uint64_t value)
+packet_id_debug(msglvl_t msglevel, const struct packet_id_rec *p,
+                const struct packet_id_net *pin, const char *message, uint=
64_t value)
 {
 #ifdef ENABLE_DEBUG
     if (unlikely(check_debug_level(msglevel)))
@@ -573,7 +573,8 @@
 #ifdef ENABLE_DEBUG

 static void
-packet_id_debug_print(int msglevel, const struct packet_id_rec *p, const s=
truct packet_id_net *pin,
+packet_id_debug_print(msglvl_t msglevel, const struct packet_id_rec *p,
+                      const struct packet_id_net *pin,
                       const char *message, packet_id_print_type value)
 {
     struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index dfc87f6..8a7a320 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -72,10 +72,10 @@
 #endif
 };

-static unsigned
+static msglvl_t
 _pkcs11_msg_pkcs112openvpn(const unsigned flags)
 {
-    unsigned openvpn_flags;
+    msglvl_t openvpn_flags;

     switch (flags)
     {
@@ -112,7 +112,7 @@
 }

 static unsigned
-_pkcs11_msg_openvpn2pkcs11(const unsigned flags)
+_pkcs11_msg_openvpn2pkcs11(const msglvl_t flags)
 {
     unsigned pkcs11_flags;

diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index ea76a08..a105058 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -50,7 +50,7 @@
 static struct plugin_common *static_plugin_common =3D NULL; /* GLOBAL */

 static void
-plugin_show_string_array(int msglevel, const char *name, const char *array=
[])
+plugin_show_string_array(msglvl_t msglevel, const char *name, const char *=
array[])
 {
     int i;
     for (i =3D 0; array[i]; ++i)
@@ -63,7 +63,7 @@
 }

 static void
-plugin_show_args_env(int msglevel, const char *argv[], const char *envp[])
+plugin_show_args_env(msglvl_t msglevel, const char *argv[], const char *en=
vp[])
 {
     if (check_debug_level(msglevel))
     {
@@ -184,7 +184,7 @@

 #ifndef ENABLE_SMALL
 void
-plugin_option_list_print(const struct plugin_option_list *list, int msglev=
el)
+plugin_option_list_print(const struct plugin_option_list *list, msglvl_t m=
sglevel)
 {
     int i;
     struct gc_arena gc =3D gc_new();
@@ -995,7 +995,7 @@

 #ifdef ENABLE_DEBUG
 void
-plugin_return_print(const int msglevel, const char *prefix, const struct p=
lugin_return *pr)
+plugin_return_print(const msglvl_t msglevel, const char *prefix, const str=
uct plugin_return *pr)
 {
     int i;
     msg(msglevel, "PLUGIN_RETURN_PRINT %s", prefix);
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 63999b6..81d3739 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -111,7 +111,7 @@
 bool plugin_option_list_add(struct plugin_option_list *list, char **p, str=
uct gc_arena *gc);

 #ifndef ENABLE_SMALL
-void plugin_option_list_print(const struct plugin_option_list *list, int m=
sglevel);
+void plugin_option_list_print(const struct plugin_option_list *list, msglv=
l_t msglevel);

 #endif

@@ -136,7 +136,7 @@
 void plugin_return_free(struct plugin_return *pr);

 #ifdef ENABLE_DEBUG
-void plugin_return_print(const int msglevel, const char *prefix, const str=
uct plugin_return *pr);
+void plugin_return_print(const msglvl_t msglevel, const char *prefix, cons=
t struct plugin_return *pr);

 #endif

diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index fde6cea..28ddd2c 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -114,7 +114,7 @@
  * Verify start/end range
  */
 bool
-ifconfig_pool_verify_range(const int msglevel, const in_addr_t start, cons=
t in_addr_t end)
+ifconfig_pool_verify_range(const msglvl_t msglevel, const in_addr_t start,=
 const in_addr_t end)
 {
     struct gc_arena gc =3D gc_new();
     bool ret =3D true;
diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
index 6cecef0..36e9fca 100644
--- a/src/openvpn/pool.h
+++ b/src/openvpn/pool.h
@@ -78,7 +78,7 @@

 void ifconfig_pool_free(struct ifconfig_pool *pool);
=20
-bool ifconfig_pool_verify_range(const int msglevel, const in_addr_t start,=
 const in_addr_t end);
+bool ifconfig_pool_verify_range(const msglvl_t msglevel, const in_addr_t s=
tart, const in_addr_t end);

 ifconfig_pool_handle ifconfig_pool_acquire(struct ifconfig_pool *pool, in_=
addr_t *local,
                                            in_addr_t *remote, struct in6_a=
ddr *remote_ipv6,
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 34b3378..ab77887 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -183,7 +183,7 @@
             int hlen;
             int totlen;
             const char *msgstr =3D "PACKET SIZE INFO";
-            unsigned int msglevel =3D D_PACKET_TRUNC_DEBUG;
+            msglvl_t msglevel =3D D_PACKET_TRUNC_DEBUG;

             if (BLEN(&buf) < (int)sizeof(struct openvpn_iphdr))
             {
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 1ea7ed9..60ca25f 100644
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
+                            msglvl_t msglevel, const char *fmt, ...)
 #ifdef __GNUC__
 #if __USE_MINGW_ANSI_STDIO
     __attribute__((format(gnu_printf, 4, 5)))
@@ -853,7 +853,7 @@

 static void
 push_option_ex(struct gc_arena *gc, struct push_list *push_list, const cha=
r *opt, bool enable,
-               int msglevel)
+               msglvl_t msglevel)
 {
     if (!string_class(opt, CC_ANY, CC_COMMA))
     {
@@ -881,7 +881,7 @@
 }

 void
-push_option(struct options *o, const char *opt, int msglevel)
+push_option(struct options *o, const char *opt, msglvl_t msglevel)
 {
     push_option_ex(&o->gc, &o->push_list, opt, true, msglevel);
 }
@@ -902,7 +902,7 @@
 }

 void
-push_options(struct options *o, char **p, int msglevel, struct gc_arena *g=
c)
+push_options(struct options *o, char **p, msglvl_t msglevel, struct gc_are=
na *gc)
 {
     const char **argv =3D make_extended_arg_array(p, false, gc);
     char *opt =3D print_argv(argv, gc, 0);
@@ -910,8 +910,8 @@
 }

 static bool
-push_option_fmt(struct gc_arena *gc, struct push_list *push_list, int msgl=
evel, const char *format,
-                ...)
+push_option_fmt(struct gc_arena *gc, struct push_list *push_list,
+                msglvl_t msglevel, const char *format, ...)
 {
     va_list arglist;
     char tmp[256] =3D { 0 };
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 8ffd0c2..6b3275e 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -99,9 +99,9 @@

 void clone_push_list(struct options *o);

-void push_option(struct options *o, const char *opt, int msglevel);
+void push_option(struct options *o, const char *opt, msglvl_t msglevel);

-void push_options(struct options *o, char **p, int msglevel, struct gc_are=
na *gc);
+void push_options(struct options *o, char **p, msglvl_t msglevel, struct g=
c_arena *gc);

 void push_reset(struct options *o);

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index e504485..aa5ce69 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1228,28 +1228,28 @@
 }
=20
 static void
-print_route_option(const struct route_option *ro, int level)
+print_route_option(const struct route_option *ro, msglvl_t msglevel)
 {
-    msg(level, "  route %s/%s/%s/%s", show_opt(ro->network), show_opt(ro->=
netmask),
+    msg(msglevel, "  route %s/%s/%s/%s", show_opt(ro->network), show_opt(r=
o->netmask),
         show_opt(ro->gateway), show_opt(ro->metric));
 }

 void
-print_route_options(const struct route_option_list *rol, int level)
+print_route_options(const struct route_option_list *rol, msglvl_t msglevel)
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
+print_default_gateway(const msglvl_t msglevel, const struct route_gateway_=
info *rgi,
                       const struct route_ipv6_gateway_info *rgi6)
 {
     struct gc_arena gc =3D gc_new();
@@ -1323,23 +1323,23 @@
 #endif /* ifndef ENABLE_SMALL */

 static void
-print_route(const struct route_ipv4 *r, int level)
+print_route(const struct route_ipv4 *r, msglvl_t msglevel)
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
+print_routes(const struct route_list *rl, msglvl_t msglevel)
 {
     struct route_ipv4 *r;
     for (r =3D rl->routes; r; r =3D r->next)
     {
-        print_route(r, level);
+        print_route(r, msglevel);
     }
 }

@@ -3059,18 +3059,18 @@
  * Show current routing table
  */
 void
-show_routes(int msglev)
+show_routes(msglvl_t msglevel)
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
index 9b6a47e..c5006ae 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -356,7 +356,7 @@
 void get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi, const s=
truct in6_addr *dest,
                               openvpn_net_ctx_t *ctx);

-void print_default_gateway(const int msglevel, const struct route_gateway_=
info *rgi,
+void print_default_gateway(const msglvl_t msglevel, const struct route_gat=
eway_info *rgi,
                            const struct route_ipv6_gateway_info *rgi6);

 /*
@@ -371,15 +371,15 @@
 int test_local_addr(const in_addr_t addr, const struct route_gateway_info =
*rgi);

 #ifndef ENABLE_SMALL
-void print_route_options(const struct route_option_list *rol, int level);
+void print_route_options(const struct route_option_list *rol, msglvl_t msg=
level);

 #endif

-void print_routes(const struct route_list *rl, int level);
+void print_routes(const struct route_list *rl, msglvl_t msglevel);

 #ifdef _WIN32

-void show_routes(int msglev);
+void show_routes(msglvl_t msglevel);

 bool test_routes(const struct route_list *rl, const struct tuntap *tt);

diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index 4a1ef22..a0c9484 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -107,7 +107,7 @@

 #ifndef WIN32
 bool
-openvpn_waitpid_check(pid_t pid, const char *msg_prefix, int msglevel)
+openvpn_waitpid_check(pid_t pid, const char *msg_prefix, msglvl_t msglevel)
 {
     if (pid =3D=3D 0)
     {
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index afd1b88..234055e 100644
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
+bool openvpn_waitpid_check(pid_t pid, const char *msg_prefix, msglvl_t msg=
level);

 #endif

diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index ecea635..42ad823 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -287,7 +287,7 @@
 }

 void
-print_signal(const struct signal_info *si, const char *title, int msglevel)
+print_signal(const struct signal_info *si, const char *title, msglvl_t msg=
level)
 {
     if (si)
     {
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index 7e5dd9f..b5d81fc 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -66,7 +66,7 @@

 void restore_signal_state(void);

-void print_signal(const struct signal_info *si, const char *title, int msg=
level);
+void print_signal(const struct signal_info *si, const char *title, msglvl_=
t msglevel);

 void print_status(struct context *c, struct status_output *so);

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 306170c..eeb42d1 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -78,7 +78,7 @@
 static int
 get_addr_generic(sa_family_t af, unsigned int flags, const char *hostname,=
 void *network,
                  unsigned int *netbits, int resolve_retry_seconds, struct =
signal_info *sig_info,
-                 int msglevel)
+                 msglvl_t msglevel)
 {
     char *endp, *sep, *var_host =3D NULL;
     struct addrinfo *ai =3D NULL;
@@ -211,7 +211,8 @@
 }

 bool
-get_ipv6_addr(const char *hostname, struct in6_addr *network, unsigned int=
 *netbits, int msglevel)
+get_ipv6_addr(const char *hostname, struct in6_addr *network, unsigned int=
 *netbits,
+              msglvl_t msglevel)
 {
     if (get_addr_generic(AF_INET6, GETADDR_RESOLVE, hostname, network, net=
bits, 0, NULL, msglevel)
         < 0)
@@ -1516,7 +1517,7 @@
 linksock_print_addr(struct link_socket *sock)
 {
     struct gc_arena gc =3D gc_new();
-    const int msglevel =3D (sock->mode =3D=3D LS_MODE_TCP_ACCEPT_FROM) ? D=
_INIT_MEDIUM : M_INFO;
+    const msglvl_t msglevel =3D (sock->mode =3D=3D LS_MODE_TCP_ACCEPT_FROM=
) ? D_INIT_MEDIUM : M_INFO;

     /* print local address */
     if (sock->bind_local)
diff --git a/src/openvpn/socket_util.c b/src/openvpn/socket_util.c
index 9b7312d..fa566e7 100644
--- a/src/openvpn/socket_util.c
+++ b/src/openvpn/socket_util.c
@@ -541,7 +541,7 @@
     struct addrinfo hints;
     int status;
     struct signal_info sigrec =3D { 0 };
-    int msglevel =3D (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
+    msglvl_t msglevel =3D (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ER=
RORS;
     struct gc_arena gc =3D gc_new();
     const char *print_hostname;
     const char *print_servname;
@@ -604,7 +604,7 @@
         int resolve_retries =3D
             (flags & GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) =
/ fail_wait_interval);
         const char *fmt;
-        int level =3D 0;
+        msglvl_t level =3D 0;

         /* this is not a numeric IP, therefore force resolution using the
          * provided ai_family */
@@ -739,7 +739,7 @@
 done:
     if (sig_info && sig_info->signal_received)
     {
-        int level =3D 0;
+        msglvl_t level =3D 0;
         if (flags & GETADDR_FATAL_ON_SIGNAL)
         {
             level =3D M_FATAL;
diff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h
index 361edff..ada52a4 100644
--- a/src/openvpn/socket_util.h
+++ b/src/openvpn/socket_util.h
@@ -142,7 +142,7 @@
  * Translate an IPv6 addr or hostname from string form to in6_addr
  */
 bool get_ipv6_addr(const char *hostname, struct in6_addr *network, unsigne=
d int *netbits,
-                   int msglevel);
+                   msglvl_t msglevel);

 int openvpn_getaddrinfo(unsigned int flags, const char *hostname, const ch=
ar *servname,
                         int resolve_retry_seconds, struct signal_info *sig=
_info, int ai_family,
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_back=
end.h
index a0559c9..2bad3eb 100644
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
+                    msglvl_t msglevel, struct gc_arena *gc);

 /*
  * Save X509 fields to environment, using the naming convention:
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index cfcfb25..3588071 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -350,7 +350,7 @@
 }

 void
-x509_track_add(const struct x509_track **ll_head, const char *name, int ms=
glevel,
+x509_track_add(const struct x509_track **ll_head, const char *name, msglvl=
_t msglevel,
                struct gc_arena *gc)
 {
     struct x509_track *xt;
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 6de7e2a..0f257e2 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -414,7 +414,7 @@
  */

 void
-x509_track_add(const struct x509_track **ll_head, const char *name, int ms=
glevel,
+x509_track_add(const struct x509_track **ll_head, const char *name, msglvl=
_t msglevel,
                struct gc_arena *gc)
 {
     struct x509_track *xt;
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index 34e5a2f..cea31f5 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -230,14 +230,13 @@

         if (so->msglevel >=3D 0 && !so->errors)
         {
-            msg(so->msglevel, "%s", buf);
+            msg((msglvl_t)so->msglevel, "%s", buf);
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
index ee0733a..9618301 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -105,9 +105,9 @@
 static void netsh_set_dns6_servers(const struct in6_addr *addr_list, const=
 int addr_len,
                                    DWORD adapter_index);

-static void netsh_command(const struct argv *a, int n, int msglevel);
+static void netsh_command(const struct argv *a, int n, msglvl_t msglevel);

-static void exec_command(const char *prefix, const struct argv *a, int n, =
int msglevel);
+static void exec_command(const char *prefix, const struct argv *a, int n, =
msglvl_t msglevel);

 static const char *netsh_get_id(const char *dev_node, struct gc_arena *gc);

@@ -4001,7 +4001,7 @@
 }

 void
-show_tap_win_adapters(int msglev, int warnlev)
+show_tap_win_adapters(msglvl_t msglevel, msglvl_t warnlevel)
 {
     struct gc_arena gc =3D gc_new();

@@ -4018,7 +4018,7 @@
     const struct tap_reg *tap_reg =3D get_tap_reg(&gc);
     const struct panel_reg *panel_reg =3D get_panel_reg(&gc);

-    msg(msglev, "Available adapters [name, GUID, driver]:");
+    msg(msglevel, "Available adapters [name, GUID, driver]:");

     /* loop through each TAP-Windows adapter registry entry */
     for (tr =3D tap_reg; tr !=3D NULL; tr =3D tr->next)
@@ -4030,7 +4030,7 @@
         {
             if (!strcmp(tr->guid, pr->guid))
             {
-                msg(msglev, "'%s' %s %s", pr->name, tr->guid,
+                msg(msglevel, "'%s' %s %s", pr->name, tr->guid,
                     print_tun_backend_driver(tr->windows_driver));
                 ++links;
             }
@@ -4045,7 +4045,7 @@
             /* a TAP adapter exists without a link from the network
              * connections control panel */
             warn_panel_null =3D true;
-            msg(msglev, "[NULL] %s", tr->guid);
+            msg(msglevel, "[NULL] %s", tr->guid);
         }
     }

@@ -4064,18 +4064,18 @@
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

@@ -4805,31 +4805,31 @@
  * Show info for a single adapter
  */
 static void
-show_adapter(int msglev, const IP_ADAPTER_INFO *a, struct gc_arena *gc)
+show_adapter(msglvl_t msglevel, const IP_ADAPTER_INFO *a, struct gc_arena =
*gc)
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
@@ -4838,12 +4838,12 @@
  * Show current adapter list
  */
 void
-show_adapters(int msglev)
+show_adapters(msglvl_t msglevel)
 {
     struct gc_arena gc =3D gc_new();
     const IP_ADAPTER_INFO *ai =3D get_adapter_info_list(&gc);

-    msg(msglev, "SYSTEM ADAPTER LIST");
+    msg(msglevel, "SYSTEM ADAPTER LIST");
     if (ai)
     {
         const IP_ADAPTER_INFO *a;
@@ -4851,7 +4851,7 @@
         /* find index in the linked list */
         for (a =3D ai; a !=3D NULL; a =3D a->Next)
         {
-            show_adapter(msglev, a, &gc);
+            show_adapter(msglevel, a, &gc);
         }
     }
     gc_free(&gc);
@@ -5048,7 +5048,7 @@
 }

 static void
-exec_command(const char *prefix, const struct argv *a, int n, int msglevel)
+exec_command(const char *prefix, const struct argv *a, int n, msglvl_t msg=
level)
 {
     int i;
     for (i =3D 0; i < n; ++i)
@@ -5069,7 +5069,7 @@
 }

 static void
-netsh_command(const struct argv *a, int n, int msglevel)
+netsh_command(const struct argv *a, int n, msglvl_t msglevel)
 {
     exec_command("NETSH", a, n, msglevel);
 }
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 06fc729..6562c22 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -445,9 +445,9 @@
 DWORD adapter_index_of_ip(const IP_ADAPTER_INFO *list, const in_addr_t ip,=
 int *count,
                           in_addr_t *netmask);

-void show_tap_win_adapters(int msglev, int warnlev);
+void show_tap_win_adapters(msglvl_t msglevel, msglvl_t warnlevel);

-void show_adapters(int msglev);
+void show_adapters(msglvl_t msglevel);

 void tap_allow_nonadmin_access(const char *dev_node);

diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn=
/mock_msg.c
index 603520b..69d2d1d 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -38,8 +38,8 @@
 #include "error.h"
 #include "mock_msg.h"

-unsigned int x_debug_level =3D 0; /* Default to (almost) no debugging outp=
ut */
-unsigned int print_x_debug_level =3D 0;
+msglvl_t x_debug_level =3D 0; /* Default to (almost) no debugging output */
+msglvl_t print_x_debug_level =3D 0;

 bool fatal_error_triggered =3D false;

@@ -47,31 +47,31 @@


 void
-mock_set_debug_level(int level)
+mock_set_debug_level(msglvl_t level)
 {
     x_debug_level =3D level;
 }

-int
+msglvl_t
 mock_get_debug_level(void)
 {
     return x_debug_level;
 }

 void
-mock_set_print_debug_level(int level)
+mock_set_print_debug_level(msglvl_t level)
 {
     print_x_debug_level =3D level;
 }

-int
+msglvl_t
 get_debug_level(void)
 {
     return x_debug_level;
 }

 void
-x_msg_va(const unsigned int flags, const char *format, va_list arglist)
+x_msg_va(const msglvl_t flags, const char *format, va_list arglist)
 {
     if (flags & M_FATAL)
     {
@@ -89,7 +89,7 @@
 }

 void
-x_msg(const unsigned int flags, const char *format, ...)
+x_msg(const msglvl_t flags, const char *format, ...)
 {
     va_list arglist;
     va_start(arglist, format);
@@ -128,7 +128,7 @@
 }

 bool
-dont_mute(unsigned int flags)
+dont_mute(msglvl_t flags)
 {
     return true;
 }
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn=
/mock_msg.h
index f4ebc23..6dddf0b 100644
--- a/tests/unit_tests/openvpn/mock_msg.h
+++ b/tests/unit_tests/openvpn/mock_msg.h
@@ -28,17 +28,15 @@
  * this function from your test driver to increase debug output when you
  * need debug output.
  */
-void mock_set_debug_level(int level);
+void mock_set_debug_level(msglvl_t level);

 #define MOCK_MSG_BUF 2048

 extern bool fatal_error_triggered;
 extern char mock_msg_buf[MOCK_MSG_BUF];

-void mock_set_debug_level(int level);
+msglvl_t mock_get_debug_level(void);

-int mock_get_debug_level(void);
-
-void mock_set_print_debug_level(int level);
+void mock_set_print_debug_level(msglvl_t level);

 #endif /* MOCK_MSG */
diff --git a/tests/unit_tests/openvpn/mock_ssl_dependencies.c b/tests/unit_=
tests/openvpn/mock_ssl_dependencies.c
index 7333c47..f2fa93a 100644
--- a/tests/unit_tests/openvpn/mock_ssl_dependencies.c
+++ b/tests/unit_tests/openvpn/mock_ssl_dependencies.c
@@ -38,7 +38,7 @@

 int
 parse_line(const char *line, char **p, const int n, const char *file, cons=
t int line_num,
-           int msglevel, struct gc_arena *gc)
+           msglvl_t msglevel, struct gc_arena *gc)
 {
     /* Dummy function to get the linker happy, should never be called */
     assert_true(false);
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvp=
n/test_argv.c
index a65857b..a04fabc 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -23,7 +23,7 @@

 int
 __wrap_parse_line(const char *line, char **p, const int n, const char *fil=
e, const int line_num,
-                  int msglevel, struct gc_arena *gc)
+                  msglvl_t msglevel, struct gc_arena *gc)
 {
     p[0] =3D PATH1 PATH2;
     p[1] =3D PARAM1;
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index 93e2460..dbfdd56 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -339,8 +339,8 @@
     assert_false(valid_integer("-2147483653", false));


-    int msglevel =3D D_LOW;
-    int saved_log_level =3D mock_get_debug_level();
+    msglvl_t msglevel =3D D_LOW;
+    msglvl_t saved_log_level =3D mock_get_debug_level();
     mock_set_debug_level(D_LOW);

     /* check happy path */
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/open=
vpn/test_pkcs11.c
index 9ba6cfc..d568865 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -59,7 +59,7 @@
 /* stubs for some unused functions instead of pulling in too many dependen=
cies */
 int
 parse_line(const char *line, char **p, const int n, const char *file, cons=
t int line_num,
-           int msglevel, struct gc_arena *gc)
+           msglvl_t msglevel, struct gc_arena *gc)
 {
     assert_true(0);
     return 0;
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index 5122766..b6c612b 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -45,7 +45,7 @@

 int
 parse_line(const char *line, char **p, const int n, const char *file, cons=
t int line_num,
-           int msglevel, struct gc_arena *gc)
+           msglvl_t msglevel, struct gc_arena *gc)
 {
     /* Dummy function to get the linker happy, should never be called */
     assert_true(false);
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_t=
ests/openvpn/test_push_update_msg.c
index 87329b1..8a5beeb 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -111,7 +111,7 @@

 #ifndef ENABLE_MANAGEMENT
 bool
-send_control_channel_string(struct context *c, const char *str, int msglev=
el)
+send_control_channel_string(struct context *c, const char *str, msglvl_t m=
sglevel)
 {
     return true;
 }
@@ -120,7 +120,7 @@
 int i;

 bool
-send_control_channel_string(struct context *c, const char *str, int msglev=
el)
+send_control_channel_string(struct context *c, const char *str, msglvl_t m=
sglevel)
 {
     if (res && res[i] && strcmp(res[i], str))
     {
diff --git a/tests/unit_tests/openvpn/test_socket.c b/tests/unit_tests/open=
vpn/test_socket.c
index 2da2529..7f740ac 100644
--- a/tests/unit_tests/openvpn/test_socket.c
+++ b/tests/unit_tests/openvpn/test_socket.c
@@ -59,7 +59,7 @@

 int
 parse_line(const char *line, char **p, const int n, const char *file, cons=
t int line_num,
-           int msglevel, struct gc_arena *gc)
+           msglvl_t msglevel, struct gc_arena *gc)
 {
     assert_true(0);
     return 0;
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
index 532bfcd..44d51fe 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -98,7 +98,7 @@

 int
 __wrap_parse_line(const char *line, char **p, const int n, const char *fil=
e, const int line_num,
-                  int msglevel, struct gc_arena *gc)
+                  msglvl_t msglevel, struct gc_arena *gc)
 {
     p[0] =3D PATH1 PATH2;
     p[1] =3D PARAM1;
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index 460b37f..32ec59f 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -73,7 +73,7 @@
 /* stubs for some unused functions instead of pulling in too many dependen=
cies */
 int
 parse_line(const char *line, char **p, const int n, const char *file, cons=
t int line_num,
-           int msglevel, struct gc_arena *gc)
+           msglvl_t msglevel, struct gc_arena *gc)
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
Gerrit-PatchSet: 17
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--dlby/pvO9xY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1110?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Introduce msglvl_t to unify msglevel type han=
dling<br><br>msglevel was definitely unsigned as the first<br>argument to m=
sg(), but many parts of the code<br>had it as signed. So this produced a LO=
T of<br>warnings when enabling -Wsign-conversion.<br><br>Introduce a msglvl=
_t typedef and switch all<br>users to it. This includes any values that<br>=
are stored in the msglevel field, including<br>debug level and mute level.<=
br><br>There is one exception in struct status_output<br>where -1 is a vali=
d value in the API. Only<br>positive values are translated into standard<br=
>message levels.<br><br>Change-Id: Id492cb774c6d022d06bb3cf5fec2a4bdd410e61=
9<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn=
.net/c/openvpn/+/1110<br>Message-Id: &lt;20250917170428.3310-1-gert@...1726...=
...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1483...=
e.net/msg33028.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<=
br>---<br>M src/openvpn/argv.c<br>M src/openvpn/argv.h<br>M src/openvpn/buf=
fer.c<br>M src/openvpn/clinat.c<br>M src/openvpn/clinat.h<br>M src/openvpn/=
comp.c<br>M src/openvpn/comp.h<br>M src/openvpn/crypto.c<br>M src/openvpn/c=
rypto.h<br>M src/openvpn/dco.c<br>M src/openvpn/dco.h<br>M src/openvpn/dco_=
freebsd.c<br>M src/openvpn/dco_linux.c<br>M src/openvpn/dco_win.c<br>M src/=
openvpn/dns.c<br>M src/openvpn/dns.h<br>M src/openvpn/env_set.c<br>M src/op=
envpn/env_set.h<br>M src/openvpn/error.c<br>M src/openvpn/error.h<br>M src/=
openvpn/forward.c<br>M src/openvpn/forward.h<br>M src/openvpn/init.c<br>M s=
rc/openvpn/init.h<br>M src/openvpn/manage.c<br>M src/openvpn/manage.h<br>M =
src/openvpn/mtu.c<br>M src/openvpn/mtu.h<br>M src/openvpn/multi.c<br>M src/=
openvpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn/options_util.=
c<br>M src/openvpn/options_util.h<br>M src/openvpn/packet_id.c<br>M src/ope=
nvpn/pkcs11.c<br>M src/openvpn/plugin.c<br>M src/openvpn/plugin.h<br>M src/=
openvpn/pool.c<br>M src/openvpn/pool.h<br>M src/openvpn/proto.c<br>M src/op=
envpn/push.c<br>M src/openvpn/push.h<br>M src/openvpn/route.c<br>M src/open=
vpn/route.h<br>M src/openvpn/run_command.c<br>M src/openvpn/run_command.h<b=
r>M src/openvpn/sig.c<br>M src/openvpn/sig.h<br>M src/openvpn/socket.c<br>M=
 src/openvpn/socket_util.c<br>M src/openvpn/socket_util.h<br>M src/openvpn/=
ssl_verify_backend.h<br>M src/openvpn/ssl_verify_mbedtls.c<br>M src/openvpn=
/ssl_verify_openssl.c<br>M src/openvpn/status.c<br>M src/openvpn/status.h<b=
r>M src/openvpn/tun.c<br>M src/openvpn/tun.h<br>M tests/unit_tests/openvpn/=
mock_msg.c<br>M tests/unit_tests/openvpn/mock_msg.h<br>M tests/unit_tests/o=
penvpn/mock_ssl_dependencies.c<br>M tests/unit_tests/openvpn/test_argv.c<br=
>M tests/unit_tests/openvpn/test_misc.c<br>M tests/unit_tests/openvpn/test_=
pkcs11.c<br>M tests/unit_tests/openvpn/test_pkt.c<br>M tests/unit_tests/ope=
nvpn/test_push_update_msg.c<br>M tests/unit_tests/openvpn/test_socket.c<br>=
M tests/unit_tests/openvpn/test_tls_crypt.c<br>M tests/unit_tests/openvpn/t=
est_user_pass.c<br>69 files changed, 283 insertions(+), 275 deletions(-)<br=
><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c</span><br><span>ind=
ex 903fc0a..79b541a 100644</span><br><span>--- a/src/openvpn/argv.c</span><=
br><span>+++ b/src/openvpn/argv.c</span><br><span>@@ -235,14 +235,14 @@</sp=
an><br><span> /**</span><br><span>  *  Write the arguments stored in a stru=
ct argv via the msg() command.</span><br><span>  *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- *  @param msglev  Integer with the message le=
vel used by msg().</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * =
 @param a       Valid pointer to the struct argv with the arguments to writ=
e.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @param msglev=
el  Integer with the message level used by msg().</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  @param a         Valid pointer to the str=
uct argv with the arguments to write.</span><br><span>  */</span><br><span>=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-argv_msg(const i=
nt msglev, const struct argv *a)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+argv_msg(const msglvl_t msglevel, const struct argv *a)</span>=
<br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    msg(msglev, &quot;%s&quot;=
, argv_str(a, &amp;gc, 0));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    msg(msglevel, &quot;%s&quot;, argv_str(a, &amp;gc, 0));</span><=
br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span>=
<br><span>@@ -250,16 +250,16 @@</span><br><span>  *  Similar to argv_msg() =
but prefixes the messages being written with a</span><br><span>  *  given s=
tring.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- *  @param msglev  Integer with the message level used by msg().</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *  @param a       Valid po=
inter to the struct argv with the arguments to write</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  @param prefix  Valid pointer to the pre=
fix string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  @para=
m msglevel  Integer with the message level used by msg().</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  @param a         Valid pointer to=
 the struct argv with the arguments to write</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  @param prefix    Valid pointer to the prefix s=
tring</span><br><span>  *</span><br><span>  */</span><br><span> void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-argv_msg_prefix(const int ms=
glev, const struct argv *a, const char *prefix)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+argv_msg_prefix(const msglvl_t msglevel, const =
struct argv *a, const char *prefix)</span><br><span> {</span><br><span>    =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    msg(msglev, &quot;%s: %s&quot;, prefix, argv_str(a, &amp;gc=
, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(msgle=
vel, &quot;%s: %s&quot;, prefix, argv_str(a, &amp;gc, 0));</span><br><span>=
     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span=
>diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h</span><br><span>index=
 056fe31..969d7b1 100644</span><br><span>--- a/src/openvpn/argv.h</span><br=
><span>+++ b/src/openvpn/argv.h</span><br><span>@@ -47,9 +47,9 @@</span><br=
><span> </span><br><span> struct argv argv_insert_head(const struct argv *a=
, const char *head);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-void argv_msg(const int msglev, const struct argv *a);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void argv_msg(const msg=
lvl_t msglevel, const struct argv *a);</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-void argv_msg_prefix(const int msglev, c=
onst struct argv *a, const char *prefix);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void argv_msg_prefix(const msglvl_t msglevel, const s=
truct argv *a, const char *prefix);</span><br><span> </span><br><span> void=
 argv_parse_cmd(struct argv *a, const char *s);</span><br><span> </span><br=
><span>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><=
span>index 0f0d17e..c0b85b2 100644</span><br><span>--- a/src/openvpn/buffer=
.c</span><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -1127,7 +1=
127,7 @@</span><br><span> {</span><br><span>     if (buf &amp;&amp; buf-&gt=
;len)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        int msglevel =3D D_ALIGN_DEBUG;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        msglvl_t msglevel =3D D_ALIGN_DEBUG;</sp=
an><br><span>         const unsigned int u =3D (unsigned int)BPTR(buf);</sp=
an><br><span> </span><br><span>         if (u &amp; (PAYLOAD_ALIGN - 1))</s=
pan><br><span>diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c</spa=
n><br><span>index 48a2057..b49d4bb 100644</span><br><span>--- a/src/openvpn=
/clinat.c</span><br><span>+++ b/src/openvpn/clinat.c</span><br><span>@@ -47=
,7 +47,7 @@</span><br><span> }</span><br><span> </span><br><span> void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-print_client_nat_list(cons=
t struct client_nat_option_list *list, int msglevel)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+print_client_nat_list(const struct client=
_nat_option_list *list, msglvl_t msglevel)</span><br><span> {</span><br><sp=
an>     struct gc_arena gc =3D gc_new();</span><br><span>     int i;</span>=
<br><span>@@ -101,7 +101,7 @@</span><br><span> void</span><br><span> add_cl=
ient_nat_to_option_list(struct client_nat_option_list *dest, const char *ty=
pe,</span><br><span>                               const char *network, con=
st char *netmask, const char *foreign_network,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                              int msglevel)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
    msglvl_t msglevel)</span><br><span> {</span><br><span>     struct clien=
t_nat_entry e;</span><br><span>     bool ok;</span><br><span>@@ -159,7 +159=
,7 @@</span><br><span> #endif</span><br><span> </span><br><span> static voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-print_pkt(struct ope=
nvpn_iphdr *iph, const char *prefix, const int direction, const int msgleve=
l)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_pkt(struct =
openvpn_iphdr *iph, const char *prefix, const int direction, const msglvl_t=
 msglevel)</span><br><span> {</span><br><span>     struct gc_arena gc =3D g=
c_new();</span><br><span> </span><br><span>diff --git a/src/openvpn/clinat.=
h b/src/openvpn/clinat.h</span><br><span>index abfa0b7..7d787e0 100644</spa=
n><br><span>--- a/src/openvpn/clinat.h</span><br><span>+++ b/src/openvpn/cl=
inat.h</span><br><span>@@ -54,11 +54,11 @@</span><br><span> void copy_clien=
t_nat_option_list(struct client_nat_option_list *dest,</span><br><span>    =
                              const struct client_nat_option_list *src);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void p=
rint_client_nat_list(const struct client_nat_option_list *list, int msgleve=
l);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void print_clien=
t_nat_list(const struct client_nat_option_list *list, msglvl_t msglevel);</=
span><br><span> </span><br><span> void add_client_nat_to_option_list(struct=
 client_nat_option_list *dest, const char *type,</span><br><span>          =
                          const char *network, const char *netmask,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                             =
      const char *foreign_network, int msglevel);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                   const char=
 *foreign_network, msglvl_t msglevel);</span><br><span> </span><br><span> v=
oid client_nat_transform(const struct client_nat_option_list *list, struct =
buffer *ipbuf,</span><br><span>                           const int directi=
on);</span><br><span>diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c</=
span><br><span>index 1a2e775..9d35141 100644</span><br><span>--- a/src/open=
vpn/comp.c</span><br><span>+++ b/src/openvpn/comp.c</span><br><span>@@ -159=
,7 +159,7 @@</span><br><span> #endif /* USE_COMP */</span><br><span> </span=
><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check=
_compression_settings_valid(struct compress_options *info, int msglevel)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+check_compression_sett=
ings_valid(struct compress_options *info, msglvl_t msglevel)</span><br><spa=
n> {</span><br><span>     /*</span><br><span>      * We also allow comp-stu=
b-v2 here as it technically allows escaping of</span><br><span>diff --git a=
/src/openvpn/comp.h b/src/openvpn/comp.h</span><br><span>index 0354896..171=
7029 100644</span><br><span>--- a/src/openvpn/comp.h</span><br><span>+++ b/=
src/openvpn/comp.h</span><br><span>@@ -84,12 +84,14 @@</span><br><span>    =
        &amp;&amp; info-&gt;alg !=3D COMP_ALG_UNDEF;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;error.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> /**</span><br><span>  * Checks if the compression set=
tings are valid. Takes into account the</span><br><span>  * flags of allow-=
compression and also the whether algorithms are compiled</span><br><span>  =
* in</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-bool check_compression_settings_valid(struct compress_options *info, in=
t msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ch=
eck_compression_settings_valid(struct compress_options *info, msglvl_t msgl=
evel);</span><br><span> </span><br><span> #ifdef USE_COMP</span><br><span> =
#include &quot;buffer.h&quot;</span><br><span>diff --git a/src/openvpn/cryp=
to.c b/src/openvpn/crypto.c</span><br><span>index 4c0f684..0abcd7f 100644</=
span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn=
/crypto.c</span><br><span>@@ -1609,7 +1609,7 @@</span><br><span> }</span><b=
r><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-ascii2keydirection(int msglevel, const char *str)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ascii2keydirection(msglvl_t msglevel=
, const char *str)</span><br><span> {</span><br><span>     if (!str)</span>=
<br><span>     {</span><br><span>diff --git a/src/openvpn/crypto.h b/src/op=
envpn/crypto.h</span><br><span>index efd7f60..d69db59 100644</span><br><spa=
n>--- a/src/openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</sp=
an><br><span>@@ -618,7 +618,7 @@</span><br><span> </span><br><span> void mu=
st_have_n_keys(const char *filename, const char *option, const struct key2 =
*key2, int n);</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-int ascii2keydirection(int msglevel, const char *str);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+int ascii2keydirection(msglvl=
_t msglevel, const char *str);</span><br><span> </span><br><span> const cha=
r *keydirection2ascii(int kd, bool remote, bool humanreadable);</span><br><=
span> </span><br><span>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</=
span><br><span>index 70a8c0a..881459c 100644</span><br><span>--- a/src/open=
vpn/dco.c</span><br><span>+++ b/src/openvpn/dco.c</span><br><span>@@ -233,7=
 +233,7 @@</span><br><span> }</span><br><span> </span><br><span> static boo=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_check_option_ce(=
const struct connection_entry *ce, int msglevel, int mode)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+dco_check_option_ce(const struct con=
nection_entry *ce, msglvl_t msglevel, int mode)</span><br><span> {</span><b=
r><span>     if (ce-&gt;fragment)</span><br><span>     {</span><br><span>@@=
 -293,7 +293,7 @@</span><br><span> }</span><br><span> </span><br><span> boo=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_check_startup_op=
tion(int msglevel, const struct options *o)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+dco_check_startup_option(msglvl_t msglevel, const s=
truct options *o)</span><br><span> {</span><br><span>     /* check if no de=
v name was specified at all. In the case,</span><br><span>      * later log=
ic will most likely stop OpenVPN, so no need to</span><br><span>@@ -430,7 +=
430,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-dco_check_option(int msglevel=
, const struct options *o)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+dco_check_option(msglvl_t msglevel, const struct options *o)</span><=
br><span> {</span><br><span>     /* At this point the ciphers have already =
been normalised */</span><br><span>     if (o-&gt;enable_ncp_fallback</span=
><br><span>@@ -480,7 +480,7 @@</span><br><span> }</span><br><span> </span><=
br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_che=
ck_pull_options(int msglevel, const struct options *o)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+dco_check_pull_options(msglvl_t msglevel=
, const struct options *o)</span><br><span> {</span><br><span>     if (!o-&=
gt;use_peer_id)</span><br><span>     {</span><br><span>diff --git a/src/ope=
nvpn/dco.h b/src/openvpn/dco.h</span><br><span>index 59acb18..a362977 10064=
4</span><br><span>--- a/src/openvpn/dco.h</span><br><span>+++ b/src/openvpn=
/dco.h</span><br><span>@@ -55,7 +55,7 @@</span><br><span>  * @param msgleve=
l      level to print messages to</span><br><span>  * @return              =
true if ovpn-dco is available, false otherwise</span><br><span>  */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-bool dco_available(int msglev=
el);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool dco_availa=
ble(msglvl_t msglevel);</span><br><span> </span><br><span> </span><br><span=
> /**</span><br><span>@@ -75,7 +75,7 @@</span><br><span>  * @param o       =
  the options struct that hold the options</span><br><span>  * @return     =
     true if no conflict was detected, false otherwise</span><br><span>  */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool dco_check_option=
(int msglevel, const struct options *o);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool dco_check_option(msglvl_t msglevel, const struct =
options *o);</span><br><span> </span><br><span> /**</span><br><span>  * Che=
ck whether the options struct has any further option that is not supported<=
/span><br><span>@@ -87,7 +87,7 @@</span><br><span>  * @param o         the =
options struct that hold the options</span><br><span>  * @return          t=
rue if no conflict was detected, false otherwise</span><br><span>  */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-bool dco_check_startup_opti=
on(int msglevel, const struct options *o);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bool dco_check_startup_option(msglvl_t msglevel, con=
st struct options *o);</span><br><span> </span><br><span> /**</span><br><sp=
an>  * Check whether any of the options pushed by the server is not support=
ed by</span><br><span>@@ -98,7 +98,7 @@</span><br><span>  * @param o       =
  the options struct that hold the options</span><br><span>  * @return     =
     true if no conflict was detected, false otherwise</span><br><span>  */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool dco_check_pull_o=
ptions(int msglevel, const struct options *o);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool dco_check_pull_options(msglvl_t msglevel, c=
onst struct options *o);</span><br><span> </span><br><span> /**</span><br><=
span>  * Initialize the DCO context</span><br><span>@@ -261,7 +261,7 @@</sp=
an><br><span> typedef void *dco_context_t;</span><br><span> </span><br><spa=
n> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
dco_available(int msglevel)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+dco_available(msglvl_t msglevel)</span><br><span> {</span><br><span=
>     return false;</span><br><span> }</span><br><span>@@ -273,19 +273,19 @=
@</span><br><span> }</span><br><span> </span><br><span> static inline bool<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_check_option(int m=
sglevel, const struct options *o)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+dco_check_option(msglvl_t msglevel, const struct options *o)<=
/span><br><span> {</span><br><span>     return false;</span><br><span> }</s=
pan><br><span> </span><br><span> static inline bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dco_check_startup_option(int msglevel, cons=
t struct options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+dco_check_startup_option(msglvl_t msglevel, const struct options *o)</span=
><br><span> {</span><br><span>     return false;</span><br><span> }</span><=
br><span> </span><br><span> static inline bool</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-dco_check_pull_options(int msglevel, const struct =
options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_chec=
k_pull_options(msglvl_t msglevel, const struct options *o)</span><br><span>=
 {</span><br><span>     return false;</span><br><span> }</span><br><span>di=
ff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c</span><br>=
<span>index 65303cd..d5ca277 100644</span><br><span>--- a/src/openvpn/dco_f=
reebsd.c</span><br><span>+++ b/src/openvpn/dco_freebsd.c</span><br><span>@@=
 -658,7 +658,7 @@</span><br><span> }</span><br><span> </span><br><span> boo=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_available(int ms=
glevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_availabl=
e(msglvl_t msglevel)</span><br><span> {</span><br><span>     struct if_clon=
ereq ifcr;</span><br><span>     char *buf =3D NULL;</span><br><span>diff --=
git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c</span><br><span>ind=
ex 40674e7..d8357ca 100644</span><br><span>--- a/src/openvpn/dco_linux.c</s=
pan><br><span>+++ b/src/openvpn/dco_linux.c</span><br><span>@@ -74,7 +74,7 =
@@</span><br><span>  * @return ID on success, negative error code on error<=
/span><br><span>  */</span><br><span> static int</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-resolve_ovpn_netlink_id(int msglevel)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+resolve_ovpn_netlink_id(msglvl=
_t msglevel)</span><br><span> {</span><br><span>     int ret;</span><br><sp=
an>     struct nl_sock *nl_sock =3D nl_socket_alloc();</span><br><span>@@ -=
1199,7 +1199,7 @@</span><br><span> }</span><br><span> </span><br><span> boo=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_available(int ms=
glevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_availabl=
e(msglvl_t msglevel)</span><br><span> {</span><br><span>     if (resolve_ov=
pn_netlink_id(D_DCO_DEBUG) &lt; 0)</span><br><span>     {</span><br><span>d=
iff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><span>i=
ndex 01ba017..2d08ed8 100644</span><br><span>--- a/src/openvpn/dco_win.c</s=
pan><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -599,7 +599,7 =
@@</span><br><span> }</span><br><span> </span><br><span> bool</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-dco_available(int msglevel)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+dco_available(msglvl_t msgl=
evel)</span><br><span> {</span><br><span>     /* try to open device by symb=
olic name */</span><br><span>     HANDLE h =3D CreateFile(&quot;\\\\.\\ovpn=
-dco&quot;, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING,</span><br=
><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>i=
ndex 5421004..efb888a 100644</span><br><span>--- a/src/openvpn/dns.c</span>=
<br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -200,7 +200,7 @@</span=
><br><span> }</span><br><span> </span><br><span> bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dns_options_verify(int msglevel, const stru=
ct dns_options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+d=
ns_options_verify(msglvl_t msglevel, const struct dns_options *o)</span><br=
><span> {</span><br><span>     const struct dns_server *server =3D o-&gt;se=
rvers ? o-&gt;servers : o-&gt;servers_prepull;</span><br><span>     while (=
server)</span><br><span>diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h<=
/span><br><span>index 6d97b40..6cd98f2 100644</span><br><span>--- a/src/ope=
nvpn/dns.h</span><br><span>+++ b/src/openvpn/dns.h</span><br><span>@@ -166,=
7 +166,7 @@</span><br><span>  * @param   o           Pointer to the DNS opt=
ions to validate</span><br><span>  * @return              True if no error =
was found</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-bool dns_options_verify(int msglevel, const struct dns_options *o)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool dns_options_v=
erify(msglvl_t msglevel, const struct dns_options *o);</span><br><span> </s=
pan><br><span> /**</span><br><span>  * Makes a deep copy of the passed DNS =
options.</span><br><span>diff --git a/src/openvpn/env_set.c b/src/openvpn/e=
nv_set.c</span><br><span>index 6c7df8e..2ae71ab 100644</span><br><span>--- =
a/src/openvpn/env_set.c</span><br><span>+++ b/src/openvpn/env_set.c</span><=
br><span>@@ -209,7 +209,7 @@</span><br><span> }</span><br><span> </span><br=
><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-env_set_p=
rint(int msglevel, const struct env_set *es)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+env_set_print(msglvl_t msglevel, const struct env_=
set *es)</span><br><span> {</span><br><span>     if (check_debug_level(msgl=
evel))</span><br><span>     {</span><br><span>diff --git a/src/openvpn/env_=
set.h b/src/openvpn/env_set.h</span><br><span>index 3973a4e..ddcfa14 100644=
</span><br><span>--- a/src/openvpn/env_set.h</span><br><span>+++ b/src/open=
vpn/env_set.h</span><br><span>@@ -85,7 +85,7 @@</span><br><span> </span><br=
><span> const char *env_set_get(const struct env_set *es, const char *name)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-vo=
id env_set_print(int msglevel, const struct env_set *es);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void env_set_print(msglvl_t msglevel,=
 const struct env_set *es);</span><br><span> </span><br><span> /**</span><b=
r><span>  * Write a struct env_set to a file. Each item on one line.</span>=
<br><span>diff --git a/src/openvpn/error.c b/src/openvpn/error.c</span><br>=
<span>index 1b98235..58c2fd1 100644</span><br><span>--- a/src/openvpn/error=
.c</span><br><span>+++ b/src/openvpn/error.c</span><br><span>@@ -48,12 +48,=
12 @@</span><br><span> #endif</span><br><span> </span><br><span> /* Globals=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned int x_deb=
ug_level; /* GLOBAL */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+msglvl_t x_debug_level; /* GLOBAL */</span><br><span> </span><br><span> =
/* Mute state */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stati=
c int mute_cutoff;   /* GLOBAL */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-static int mute_count;    /* GLOBAL */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-static int mute_category; /* GLOBAL */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static int mute_cutoff;    =
    /* GLOBAL */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic int mute_count;         /* GLOBAL */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static msglvl_t mute_category; /* GLOBAL */</span><br>=
<span> </span><br><span> /*</span><br><span>  * Output mode priorities are =
as follows:</span><br><span>@@ -103,16 +103,14 @@</span><br><span> bool</sp=
an><br><span> set_debug_level(const int level, const unsigned int flags)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c=
onst int ceiling =3D 15;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (level &gt;=
=3D 0 &amp;&amp; level &lt;=3D ceiling)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (level &gt;=3D 0 &amp;&amp; level &lt;=3D M_DEBU=
G_LEVEL)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        x_debug_level =3D level;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        x_debug_level =3D (msglvl_t)level;</span><br=
><span>         return true;</span><br><span>     }</span><br><span>     el=
se if (flags &amp; SDL_CONSTRAIN)</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        x_debug_level =3D constrain_int(=
level, 0, ceiling);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        x_debug_level =3D (msglvl_t)constrain_int(level, 0, M_DEBUG_LEVEL);=
</span><br><span>         return true;</span><br><span>     }</span><br><sp=
an>     return false;</span><br><span>@@ -132,7 +130,7 @@</span><br><span> =
    }</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+msglvl_t</span><br><span> get_debug_level(void)</span><br><span> {</sp=
an><br><span>     return x_debug_level;</span><br><span>@@ -190,7 +188,7 @@=
</span><br><span>  * Return a file to print messages to before syslog is op=
ened.</span><br><span>  */</span><br><span> FILE *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-msg_fp(const unsigned int flags)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+msg_fp(const msglvl_t flags)</spa=
n><br><span> {</span><br><span>     FILE *fp =3D msgfp;</span><br><span>   =
  if (!fp)</span><br><span>@@ -214,7 +212,7 @@</span><br><span> int x_msg_l=
ine_num; /* GLOBAL */</span><br><span> </span><br><span> void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-x_msg(const unsigned int flags, con=
st char *format, ...)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+x_msg(const msglvl_t flags, const char *format, ...)</span><br><span> {</=
span><br><span>     va_list arglist;</span><br><span>     va_start(arglist,=
 format);</span><br><span>@@ -235,7 +233,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-x_msg_va(const unsigned int flags, const char *format, va_list argl=
ist)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+x_msg_va(const =
msglvl_t flags, const char *format, va_list arglist)</span><br><span> {</sp=
an><br><span>     struct gc_arena gc;</span><br><span> #if SYSLOG_CAPABILIT=
Y</span><br><span>@@ -385,13 +383,13 @@</span><br><span>  * Apply muting fi=
lter.</span><br><span>  */</span><br><span> bool</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-dont_mute(unsigned int flags)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+dont_mute(msglvl_t flags)</span><br><s=
pan> {</span><br><span>     bool ret =3D true;</span><br><span>     if (mut=
e_cutoff &gt; 0 &amp;&amp; !(flags &amp; M_NOMUTE))</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const int mute=
_level =3D DECODE_MUTE_LEVEL(flags);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (mute_level &gt; 0 &amp;&amp; mute_level =3D=3D m=
ute_category)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  const msglvl_t mute_level =3D DECODE_MUTE_LEVEL(flags);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (mute_level =3D=3D mute_ca=
tegory)</span><br><span>         {</span><br><span>             if (mute_co=
unt =3D=3D mute_cutoff)</span><br><span>             {</span><br><span>@@ -=
750,7 +748,7 @@</span><br><span>  * Translate msg flags into a string</span=
><br><span>  */</span><br><span> const char *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-msg_flags_string(const unsigned int flags, struct g=
c_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+msg_fla=
gs_string(const msglvl_t flags, struct gc_arena *gc)</span><br><span> {</sp=
an><br><span>     struct buffer out =3D alloc_buf_gc(16, gc);</span><br><sp=
an>     if (flags =3D=3D M_INFO)</span><br><span>diff --git a/src/openvpn/e=
rror.h b/src/openvpn/error.h</span><br><span>index 8388f82..2913498 100644<=
/span><br><span>--- a/src/openvpn/error.h</span><br><span>+++ b/src/openvpn=
/error.h</span><br><span>@@ -74,31 +74,33 @@</span><br><span> #define openv=
pn_errno() errno</span><br><span> #endif</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+typedef unsigned int msglvl_t;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</spa=
n><br><span>  * These globals should not be accessed directly,</span><br><s=
pan>  * but rather through macros or inline functions defined below.</span>=
<br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-extern =
unsigned int x_debug_level;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+extern msglvl_t x_debug_level;</span><br><span> extern int x_msg_li=
ne_num;</span><br><span> </span><br><span> /* msg() flags */</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define M_DEBUG_LE=
VEL (0x0F) /* debug level mask */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define M_DEBUG_LEVEL (0x0Fu) /* debug level mask */</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define M_FA=
TAL    (1 &lt;&lt; 4)  /* exit program */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define M_NONFATAL (1 &lt;&lt; 5)  /* non-fatal error *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define M_WARN     (=
1 &lt;&lt; 6)  /* call syslog with LOG_WARNING */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define M_DEBUG    (1 &lt;&lt; 7)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define M_FATAL    (1u &lt;&lt; 4=
)  /* exit program */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define M_NONFATAL (1u &lt;&lt; 5)  /* non-fatal error */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define M_WARN     (1u &lt;&lt; 6) =
 /* call syslog with LOG_WARNING */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define M_DEBUG    (1u &lt;&lt; 7)</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define M_ERRNO (1 &lt;&lt; =
8)         /* show errno description */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define M_ERRNO (1u &lt;&lt; 8)         /* show errno d=
escription */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define M_NOMUTE       (1 &lt;&lt; 11) /* don&#39;t do mute proce=
ssing */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define M_NOP=
REFIX     (1 &lt;&lt; 12) /* don&#39;t show date/time prefix */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define M_USAGE_SMALL  (1 &lt;&lt=
; 13) /* fatal options error, call usage_small */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define M_MSG_VIRT_OUT (1 &lt;&lt; 14) /* outpu=
t message through msg_status_output callback */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#define M_OPTERR       (1 &lt;&lt; 15) /* print &=
quot;Options error:&quot; prefix */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define M_NOLF         (1 &lt;&lt; 16) /* don&#39;t print new=
 line */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define M_NOI=
PREFIX    (1 &lt;&lt; 17) /* don&#39;t print instance prefix */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define M_NOMUTE       (1u &lt;=
&lt; 11) /* don&#39;t do mute processing */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define M_NOPREFIX     (1u &lt;&lt; 12) /* don&#39;=
t show date/time prefix */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define M_USAGE_SMALL  (1u &lt;&lt; 13) /* fatal options error, call=
 usage_small */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine M_MSG_VIRT_OUT (1u &lt;&lt; 14) /* output message through msg_status_ou=
tput callback */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine M_OPTERR       (1u &lt;&lt; 15) /* print &quot;Options error:&quot; pr=
efix */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define M_NO=
LF         (1u &lt;&lt; 16) /* don&#39;t print new line */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define M_NOIPREFIX    (1u &lt;&lt; =
17) /* don&#39;t print instance prefix */</span><br><span> </span><br><span=
> /* flag combinations which are frequently used */</span><br><span> #defin=
e M_ERR    (M_FATAL | M_ERRNO)</span><br><span>@@ -112,7 +114,7 @@</span><b=
r><span>  * A mute level of 0 is always printed.</span><br><span>  */</span=
><br><span> #define MUTE_LEVEL_SHIFT 24</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define MUTE_LEVEL_MASK  0xFF</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define MUTE_LEVEL_MASK  0xFFu</span><br><span>=
 </span><br><span> #define ENCODE_MUTE_LEVEL(mute_level) (((mute_level) &am=
p; MUTE_LEVEL_MASK) &lt;&lt; MUTE_LEVEL_SHIFT)</span><br><span> #define DEC=
ODE_MUTE_LEVEL(flags)      (((flags) &gt;&gt; MUTE_LEVEL_SHIFT) &amp; MUTE_=
LEVEL_MASK)</span><br><span>@@ -135,7 +137,7 @@</span><br><span>  */</span>=
<br><span> </span><br><span> /** Check muting filter */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-bool dont_mute(unsigned int flags);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+bool dont_mute(msglvl_t f=
lags);</span><br><span> </span><br><span> /* Macro to ensure (and teach sta=
tic analysis tools) we exit on fatal errors */</span><br><span> #define EXI=
T_FATAL(flags)      \</span><br><span>@@ -170,7 +172,7 @@</span><br><span> =
#define dmsg(flags, ...)</span><br><span> #endif</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-void x_msg(const unsigned int =
flags, const char *format, ...)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void x_msg(const msglvl_t flags, const char *format, ...)</span=
><br><span> #ifdef __GNUC__</span><br><span> #if __USE_MINGW_ANSI_STDIO</sp=
an><br><span>     __attribute__((format(gnu_printf, 2, 3)))</span><br><span=
>@@ -180,7 +182,7 @@</span><br><span> #endif</span><br><span>     ; /* shou=
ld be called via msg above */</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-void x_msg_va(const unsigned int flags, const cha=
r *format, va_list arglist);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void x_msg_va(const msglvl_t flags, const char *format, va_list ar=
glist);</span><br><span> </span><br><span> /*</span><br><span>  * Function =
prototypes</span><br><span>@@ -201,16 +203,16 @@</span><br><span> </span><b=
r><span> bool set_mute_cutoff(const int cutoff);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-int get_debug_level(void);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+msglvl_t get_debug_leve=
l(void);</span><br><span> </span><br><span> int get_mute_cutoff(void);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-const ch=
ar *msg_flags_string(const unsigned int flags, struct gc_arena *gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+const char *msg_flags_stri=
ng(const msglvl_t flags, struct gc_arena *gc);</span><br><span> </span><br>=
<span> /*</span><br><span>  * File to print messages to before syslog is op=
ened.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-FILE *msg_fp(const unsigned int flags);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+FILE *msg_fp(const msglvl_t flags);</span><br><spa=
n> </span><br><span> /* Fatal logic errors */</span><br><span> #ifndef ENAB=
LE_SMALL</span><br><span>@@ -254,14 +256,14 @@</span><br><span> /* Inline f=
unctions */</span><br><span> </span><br><span> static inline bool</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-check_debug_level(unsigned int =
level)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_debug_l=
evel(msglvl_t level)</span><br><span> {</span><br><span>     return (level =
&amp; M_DEBUG_LEVEL) &lt;=3D x_debug_level;</span><br><span> }</span><br><s=
pan> </span><br><span> /** Return true if flags represent an enabled, not m=
uted log level */</span><br><span> static inline bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-msg_test(unsigned int flags)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+msg_test(msglvl_t flags)</span><br=
><span> {</span><br><span>     return check_debug_level(flags) &amp;&amp; d=
ont_mute(flags);</span><br><span> }</span><br><span>@@ -400,8 +402,8 @@</sp=
an><br><span> }</span><br><span> </span><br><span> /** Convert fatal errors=
 to nonfatal, don&#39;t touch other errors */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-static inline unsigned int</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-nonfatal(const unsigned int err)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static inline msglvl_t</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+nonfatal(const msglvl_t err)</=
span><br><span> {</span><br><span>     return err &amp; M_FATAL ? (err ^ M_=
FATAL) | M_NONFATAL : err;</span><br><span> }</span><br><span>diff --git a/=
src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>index 5d22fa3=
..12dd6a7 100644</span><br><span>--- a/src/openvpn/forward.c</span><br><spa=
n>+++ b/src/openvpn/forward.c</span><br><span>@@ -368,7 +368,8 @@</span><br=
><span> }</span><br><span> </span><br><span> bool</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-send_control_channel_string_dowork(struct tls_s=
ession *session, const char *str, int msglevel)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+send_control_channel_string_dowork(struct tls_s=
ession *session, const char *str,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                   msglvl_t msglevel)</span><=
br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br=
><span>     bool stat;</span><br><span>@@ -395,7 +396,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> bool</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-send_control_channel_string(struct context *c, const c=
har *str, int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+send_control_channel_string(struct context *c, const char *str, msglvl_=
t msglevel)</span><br><span> {</span><br><span>     if (c-&gt;c2.tls_multi)=
</span><br><span>     {</span><br><span>diff --git a/src/openvpn/forward.h =
b/src/openvpn/forward.h</span><br><span>index 79d0f8b..a575faf 100644</span=
><br><span>--- a/src/openvpn/forward.h</span><br><span>+++ b/src/openvpn/fo=
rward.h</span><br><span>@@ -285,7 +285,7 @@</span><br><span>  * @param str =
       - The message to be sent</span><br><span>  * @param msglevel   - Mes=
sage level to use for logging</span><br><span>  */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-bool send_control_channel_string(struct contex=
t *c, const char *str, int msglevel);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+bool send_control_channel_string(struct context *c, const=
 char *str, msglvl_t msglevel);</span><br><span> </span><br><span> /*</span=
><br><span>  * Send a string to remote over the TLS control channel.</span>=
<br><span>@@ -303,7 +303,8 @@</span><br><span>  * @param msglevel   - Messa=
ge level to use for logging</span><br><span>  */</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-bool send_control_channel_stri=
ng_dowork(struct tls_session *session, const char *str, int msglevel);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool send_control_channe=
l_string_dowork(struct tls_session *session, const char *str,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
       msglvl_t msglevel);</span><br><span> </span><br><span> </span><br><s=
pan> /**</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init=
.c</span><br><span>index 2821cd4..0d7a2ec 100644</span><br><span>--- a/src/=
openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ =
-4273,7 +4273,7 @@</span><br><span> }</span><br><span> </span><br><span> vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-management_show_net=
_callback(void *arg, const int msglevel)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+management_show_net_callback(void *arg, const msglvl_t=
 msglevel)</span><br><span> {</span><br><span> #ifdef _WIN32</span><br><spa=
n>     show_routes(msglevel);</span><br><span>diff --git a/src/openvpn/init=
.h b/src/openvpn/init.h</span><br><span>index a807874..e89615b 100644</span=
><br><span>--- a/src/openvpn/init.h</span><br><span>+++ b/src/openvpn/init.=
h</span><br><span>@@ -136,7 +136,7 @@</span><br><span> </span><br><span> vo=
id close_management(void);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void management_show_net_callback(void *arg, const i=
nt msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void m=
anagement_show_net_callback(void *arg, const msglvl_t msglevel);</span><br>=
<span> </span><br><span> #endif</span><br><span> </span><br><span>diff --gi=
t a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>index 4decd=
fe..c675e95 100644</span><br><span>--- a/src/openvpn/manage.c</span><br><sp=
an>+++ b/src/openvpn/manage.c</span><br><span>@@ -1475,7 +1475,7 @@</span><=
br><span>         }</span><br><span>         else</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_CL=
IENT, &quot;SUCCESS: verb=3D%d&quot;, get_debug_level());</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;SUCCE=
SS: verb=3D%u&quot;, get_debug_level());</span><br><span>         }</span><=
br><span>     }</span><br><span>     else if (streq(p[0], &quot;mute&quot;)=
)</span><br><span>diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h<=
/span><br><span>index 7c189ba..bff96d3 100644</span><br><span>--- a/src/ope=
nvpn/manage.h</span><br><span>+++ b/src/openvpn/manage.h</span><br><span>@@=
 -176,7 +176,7 @@</span><br><span>     unsigned int flags;</span><br><span>=
 </span><br><span>     void (*status)(void *arg, const int version, struct =
status_output *so);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  void (*show_net)(void *arg, const int msglevel);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    void (*show_net)(void *arg, const msglvl=
_t msglevel);</span><br><span>     int (*kill_by_cn)(void *arg, const char =
*common_name);</span><br><span>     int (*kill_by_addr)(void *arg, const in=
_addr_t addr, const int port, const int proto);</span><br><span>     void (=
*delete_event)(void *arg, event_t event);</span><br><span>diff --git a/src/=
openvpn/mtu.c b/src/openvpn/mtu.c</span><br><span>index a419e32..9c1a772 10=
0644</span><br><span>--- a/src/openvpn/mtu.c</span><br><span>+++ b/src/open=
vpn/mtu.c</span><br><span>@@ -187,7 +187,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-frame_print(const struct frame *frame, int level, const char *prefi=
x)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+frame_print(const=
 struct frame *frame, msglvl_t msglevel, const char *prefix)</span><br><spa=
n> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>=
     struct buffer out =3D alloc_buf_gc(256, &amp;gc);</span><br><span>@@ -=
208,7 +208,7 @@</span><br><span>     buf_printf(&amp;out, &quot; ET:%d&quot=
;, frame-&gt;extra_tun);</span><br><span>     buf_printf(&amp;out, &quot; ]=
&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    msg(level, &quot;%s&quot;, out.data);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    msg(msglevel, &quot;%s&quot;, out.data);</sp=
an><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h</span><br>=
<span>index c092461..3bbff6f 100644</span><br><span>--- a/src/openvpn/mtu.h=
</span><br><span>+++ b/src/openvpn/mtu.h</span><br><span>@@ -181,7 +181,7 @=
@</span><br><span>  * Function prototypes.</span><br><span>  */</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void frame_prin=
t(const struct frame *frame, int level, const char *prefix);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void frame_print(const struct fram=
e *frame, msglvl_t msglevel, const char *prefix);</span><br><span> </span><=
br><span> void set_mtu_discover_type(socket_descriptor_t sd, int mtu_type, =
sa_family_t proto_af);</span><br><span> </span><br><span>diff --git a/src/o=
penvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 6e4cc42..8676a09=
 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src=
/openvpn/multi.c</span><br><span>@@ -3316,7 +3316,7 @@</span><br><span>    =
 }</span><br><span>     else</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        int msglevel =3D D_DCO;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msglvl_t msglevel =3D D=
_DCO;</span><br><span>         if (dco-&gt;dco_message_type =3D=3D OVPN_CMD=
_DEL_PEER</span><br><span>             &amp;&amp; dco-&gt;dco_del_peer_reas=
on =3D=3D OVPN_DEL_PEER_REASON_USERSPACE)</span><br><span>         {</span>=
<br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span>=
<br><span>index ae285d9..f1f66b9 100644</span><br><span>--- a/src/openvpn/o=
ptions.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -11=
07,7 +1107,7 @@</span><br><span> #endif /* ifndef _WIN32 */</span><br><span=
> </span><br><span> static in_addr_t</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-get_ip_addr(const char *ip_string, int msglevel, bool *error=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_ip_addr(const =
char *ip_string, msglvl_t msglevel, bool *error)</span><br><span> {</span><=
br><span>     unsigned int flags =3D GETADDR_HOST_ORDER;</span><br><span>  =
   bool succeeded =3D false;</span><br><span>@@ -1187,7 +1187,7 @@</span><b=
r><span>  * @param   gc          The returned object will be allocated in t=
his gc</span><br><span>  */</span><br><span> static struct verify_hash_list=
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-parse_hash_fingerpr=
int(const char *str, int nbytes, int msglevel, struct gc_arena *gc)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+parse_hash_fingerprint(cons=
t char *str, int nbytes, msglvl_t msglevel, struct gc_arena *gc)</span><br>=
<span> {</span><br><span>     int i =3D 0;</span><br><span>     const char =
*cp =3D str;</span><br><span>@@ -1240,7 +1240,8 @@</span><br><span>  * @par=
am   gc          The returned list items will be allocated in this gc</span=
><br><span>  */</span><br><span> static struct verify_hash_list *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-parse_hash_fingerprint_multilin=
e(const char *str, int nbytes, int msglevel, struct gc_arena *gc)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+parse_hash_fingerprint_multil=
ine(const char *str, int nbytes, msglvl_t msglevel,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                 struct g=
c_arena *gc)</span><br><span> {</span><br><span>     struct gc_arena gc_tem=
p =3D gc_new();</span><br><span>     char *lines =3D string_alloc(str, &amp=
;gc_temp);</span><br><span>@@ -1329,7 +1330,7 @@</span><br><span> #endif /*=
 ifdef _WIN32 */</span><br><span> </span><br><span> static void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-dhcp_option_dns6_parse(const char=
 *parm, struct in6_addr *dns6_list, int *len, int msglevel)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+dhcp_option_dns6_parse(const char *=
parm, struct in6_addr *dns6_list, int *len, msglvl_t msglevel)</span><br><s=
pan> {</span><br><span>     struct in6_addr addr;</span><br><span>     if (=
*len &gt;=3D N_DHCP_ADDR)</span><br><span>@@ -1344,7 +1345,7 @@</span><br><=
span> }</span><br><span> static void</span><br><span> dhcp_option_address_p=
arse(const char *name, const char *parm, in_addr_t *array, int *len,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                          in=
t msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                  msglvl_t msglevel)</span><br><span> {</span><br><span>   =
  if (*len &gt;=3D N_DHCP_ADDR)</span><br><span>     {</span><br><span>@@ -=
1480,7 +1481,8 @@</span><br><span> #endif /* ! ENABLE_SMALL */</span><br><s=
pan> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-option_iroute(struct options *o, const char *network_str, cons=
t char *netmask_str, int msglevel)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+option_iroute(struct options *o, const char *network_str, co=
nst char *netmask_str,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+              msglvl_t msglevel)</span><br><span> {</span><br><span>    =
 struct iroute *ir;</span><br><span> </span><br><span>@@ -1506,7 +1508,7 @@=
</span><br><span> }</span><br><span> </span><br><span> static void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-option_iroute_ipv6(struct opti=
ons *o, const char *prefix_str, int msglevel)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+option_iroute_ipv6(struct options *o, const char =
*prefix_str, msglvl_t msglevel)</span><br><span> {</span><br><span>     str=
uct iroute_ipv6 *ir;</span><br><span> </span><br><span>@@ -2063,7 +2065,7 @=
@</span><br><span> }</span><br><span> </span><br><span> static struct local=
_entry *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-alloc_local_e=
ntry(struct connection_entry *ce, const int msglevel, struct gc_arena *gc)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+alloc_local_entry(st=
ruct connection_entry *ce, const msglvl_t msglevel, struct gc_arena *gc)</s=
pan><br><span> {</span><br><span>     struct local_list *l =3D alloc_local_=
list_if_undef(ce, gc);</span><br><span>     struct local_entry *e;</span><b=
r><span>@@ -2104,7 +2106,7 @@</span><br><span> }</span><br><span> </span><b=
r><span> static struct connection_entry *</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-alloc_connection_entry(struct options *options, const i=
nt msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+alloc_c=
onnection_entry(struct options *options, const msglvl_t msglevel)</span><br=
><span> {</span><br><span>     struct connection_list *l =3D alloc_connecti=
on_list_if_undef(options);</span><br><span>     struct connection_entry *e;=
</span><br><span>@@ -2140,7 +2142,7 @@</span><br><span> }</span><br><span> =
</span><br><span> static struct remote_entry *</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-alloc_remote_entry(struct options *options, const =
int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+alloc_=
remote_entry(struct options *options, const msglvl_t msglevel)</span><br><s=
pan> {</span><br><span>     struct remote_list *l =3D alloc_remote_list_if_=
undef(options);</span><br><span>     struct remote_entry *e;</span><br><spa=
n>@@ -2694,7 +2696,7 @@</span><br><span> </span><br><span>     if (!options=
-&gt;tls_server &amp;&amp; !options-&gt;tls_client)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int msglevel =
=3D M_USAGE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msglvl_t msglevel =3D M_USAGE;</span><br><span>         if (options-&gt;al=
low_deprecated_insecure_static_crypto)</span><br><span>         {</span><br=
><span>             msglevel =3D M_INFO;</span><br><span>@@ -4566,8 +4568,9=
 @@</span><br><span> }</span><br><span> </span><br><span> static void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-options_warning_safe_scan2(=
const int msglevel, const int delim, const bool report_inconsistent,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                           c=
onst char *p1, const struct buffer *b2_src, const char *b1_name,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+options_warning_safe_scan2(con=
st msglvl_t msglevel, const int delim,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                           const bool report_inconsisten=
t, const char *p1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                          const struct buffer *b2_src, const char *b1_name,=
</span><br><span>                            const char *b2_name)</span><br=
><span> {</span><br><span>     /* We will stop sending &#39;key-method&#39;=
, &#39;keydir&#39;, &#39;proto&#39; and &#39;tls-auth&#39; in</span><br><sp=
an>@@ -4619,9 +4622,9 @@</span><br><span> }</span><br><span> </span><br><sp=
an> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-option=
s_warning_safe_scan1(const int msglevel, const int delim, const bool report=
_inconsistent,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                    const struct buffer *b1_src, const struct buffer *b2_sr=
c,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
        const char *b1_name, const char *b2_name)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+options_warning_safe_scan1(const msglvl_t msg=
level, const int delim,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                           const bool report_inconsistent, const struct=
 buffer *b1_src,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                        const struct buffer *b2_src, const char *b1_name, c=
onst char *b2_name)</span><br><span> {</span><br><span>     struct gc_arena=
 gc =3D gc_new();</span><br><span>     struct buffer b =3D *b1_src;</span><=
br><span>@@ -4637,7 +4640,7 @@</span><br><span> }</span><br><span> </span><=
br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
options_warning_safe_ml(const int msglevel, char *actual, const char *expec=
ted, size_t actual_n)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+options_warning_safe_ml(const msglvl_t msglevel, char *actual, const char=
 *expected, size_t actual_n)</span><br><span> {</span><br><span>     struct=
 gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ -4729,7 +47=
32,7 @@</span><br><span>  */</span><br><span> </span><br><span> int</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-parse_topology(const char *st=
r, const int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+parse_topology(const char *str, const msglvl_t msglevel)</span><br><span=
> {</span><br><span>     if (streq(str, &quot;net30&quot;))</span><br><span=
>     {</span><br><span>@@ -4785,7 +4788,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-auth_retry_set(const int msglevel, const char *option)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+auth_retry_set(const msglvl_t ms=
glevel, const char *option)</span><br><span> {</span><br><span>     if (str=
eq(option, &quot;interact&quot;))</span><br><span>     {</span><br><span>@@=
 -4942,7 +4945,7 @@</span><br><span> </span><br><span> #if 0</span><br><spa=
n> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ping_re=
c_err(int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
ping_rec_err(msglvl_t msglevel)</span><br><span> {</span><br><span>     msg=
(msglevel, &quot;only one of --ping-exit or --ping-restart options may be s=
pecified&quot;);</span><br><span> }</span><br><span>@@ -4966,7 +4969,7 @@</=
span><br><span> </span><br><span> int</span><br><span> parse_line(const cha=
r *line, char *p[], const int n, const char *file, const int line_num,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-           int msglevel, s=
truct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
           msglvl_t msglevel, struct gc_arena *gc)</span><br><span> {</span=
><br><span>     const int STATE_INITIAL =3D 0;</span><br><span>     const i=
nt STATE_READING_QUOTED_PARM =3D 1;</span><br><span>@@ -5271,24 +5274,25 @@=
</span><br><span> }</span><br><span> </span><br><span> static void add_opti=
on(struct options *options, char *p[], bool is_inline, const char *file,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                       i=
nt line, const int level, const int msglevel,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                       int line, const int level,=
 const msglvl_t msglevel,</span><br><span>                        const uns=
igned int permission_mask, unsigned int *option_types_found,</span><br><spa=
n>                        struct env_set *es);</span><br><span> </span><br>=
<span> static void remove_option(struct context *c, struct options *options=
, char *p[], bool is_inline,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                          const char *file, int line, const int msgl=
evel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
            const char *file, int line, const msglvl_t msglevel,</span><br>=
<span>                           const unsigned int permission_mask, unsign=
ed int *option_types_found,</span><br><span>                           stru=
ct env_set *es);</span><br><span> </span><br><span> static void update_opti=
on(struct context *c, struct options *options, char *p[], bool is_inline,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
   const char *file, int line, const int level, const int msglevel,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                          c=
onst char *file, int line, const int level, const msglvl_t msglevel,</span>=
<br><span>                           const unsigned int permission_mask, un=
signed int *option_types_found,</span><br><span>                           =
struct env_set *es, unsigned int *update_options_found);</span><br><span> <=
/span><br><span> static void</span><br><span> read_config_file(struct optio=
ns *options, const char *file, int level, const char *top_file,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                 const int top_li=
ne, const int msglevel, const unsigned int permission_mask,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                 unsigned int *option=
_types_found, struct env_set *es)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                 const int top_line, const msglvl_t msglevel,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 co=
nst unsigned int permission_mask, unsigned int *option_types_found,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                 struct env=
_set *es)</span><br><span> {</span><br><span>     const int max_recursive_l=
evels =3D 10;</span><br><span>     FILE *fp;</span><br><span>@@ -5360,7 +53=
64,7 @@</span><br><span> </span><br><span> static void</span><br><span> rea=
d_config_string(const char *prefix, struct options *options, const char *co=
nfig,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
   const int msglevel, const unsigned int permission_mask,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                   const msglvl_t ms=
glevel, const unsigned int permission_mask,</span><br><span>               =
     unsigned int *option_types_found, struct env_set *es)</span><br><span>=
 {</span><br><span>     char line[OPTION_LINE_SIZE];</span><br><span>@@ -53=
88,7 +5392,7 @@</span><br><span> }</span><br><span> </span><br><span> void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-parse_argv(struct opti=
ons *options, const int argc, char *argv[], const int msglevel,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+parse_argv(struct options *opti=
ons, const int argc, char *argv[], const msglvl_t msglevel,</span><br><span=
>            const unsigned int permission_mask, unsigned int *option_types=
_found, struct env_set *es)</span><br><span> {</span><br><span>     /* usag=
e message */</span><br><span>@@ -5457,7 +5461,7 @@</span><br><span>     cha=
r line[OPTION_PARM_SIZE];</span><br><span>     int line_num =3D 0;</span><b=
r><span>     const char *file =3D &quot;[PUSH-OPTIONS]&quot;;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    const int msglevel =3D D_PUSH_E=
RRORS | M_OPTERR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const msglvl_t msglevel =3D D_PUSH_ERRORS | M_OPTERR;</span><br><span>   =
  unsigned int update_options_found =3D 0;</span><br><span> </span><br><spa=
n>     while (buf_parse(buf, &#39;,&#39;, line, sizeof(line)))</span><br><s=
pan>@@ -5514,7 +5518,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-options_serv=
er_import(struct options *o, const char *filename, int msglevel,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+options_server_import(struct o=
ptions *o, const char *filename, msglvl_t msglevel,</span><br><span>       =
                unsigned int permission_mask, unsigned int *option_types_fo=
und,</span><br><span>                       struct env_set *es)</span><br><=
span> {</span><br><span>@@ -5524,7 +5528,7 @@</span><br><span> }</span><br>=
<span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-options_string_import(struct options *options, const char *config, =
const int msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
options_string_import(struct options *options, const char *config, const ms=
glvl_t msglevel,</span><br><span>                       const unsigned int =
permission_mask, unsigned int *option_types_found,</span><br><span>        =
               struct env_set *es)</span><br><span> {</span><br><span>@@ -5=
543,7 +5547,7 @@</span><br><span> </span><br><span> static bool</span><br><=
span> verify_permission(const char *name, const char *file, int line, const=
 unsigned int type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                const unsigned int allowed, unsigned int *found, const int =
msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
        const unsigned int allowed, unsigned int *found, const msglvl_t msg=
level,</span><br><span>                   struct options *options, bool is_=
inline)</span><br><span> {</span><br><span>     if (!(type &amp; allowed))<=
/span><br><span>@@ -5595,7 +5599,7 @@</span><br><span> #define NM_QUOTE_HIN=
T (1 &lt;&lt; 0)</span><br><span> </span><br><span> static bool</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-no_more_than_n_args(const int msg=
level, char *p[], const int max, const unsigned int flags)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+no_more_than_n_args(const msglvl_t m=
sglevel, char *p[], const int max, const unsigned int flags)</span><br><spa=
n> {</span><br><span>     const int len =3D string_array_len((const char **=
)p);</span><br><span> </span><br><span>@@ -5619,8 +5623,8 @@</span><br><spa=
n>     }</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-static inline int</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-msglevel_forward_compatible(struct options *options, co=
nst int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic inline msglvl_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+msglevel_forward_compatible(struct options *options, const msglvl_t msglev=
el)</span><br><span> {</span><br><span>     return options-&gt;forward_comp=
atible ? M_WARN : msglevel;</span><br><span> }</span><br><span>@@ -5654,10 =
+5658,11 @@</span><br><span>  */</span><br><span> static void</span><br><sp=
an> remove_option(struct context *c, struct options *options, char *p[], bo=
ol is_inline,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
      const char *file, int line, const int msglevel, const unsigned int pe=
rmission_mask,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
       unsigned int *option_types_found, struct env_set *es)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+              const char *file, in=
t line, const msglvl_t msglevel,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+              const unsigned int permission_mask, unsigned int=
 *option_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+              struct env_set *es)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    int msglevel_fc =3D msglevel_forward_c=
ompatible(options, msglevel);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    msglvl_t msglevel_fc =3D msglevel_forward_compatible(options,=
 msglevel);</span><br><span> </span><br><span>     if (streq(p[0], &quot;if=
config&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>@@ -=
5792,11 +5797,10 @@</span><br><span> #endif</span><br><span>     else</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int=
 msglevel_unknown =3D msglevel_fc;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msglvl_t msglevel_unknown =3D msglevel_fc;</span><br=
><span>         /* Check if an option is in --ignore-unknown-option and</sp=
an><br><span>          * set warning level to non fatal */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; options-&gt;igno=
re_unknown_option &amp;&amp; options-&gt;ignore_unknown_option[i]; i++)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D =
0; options-&gt;ignore_unknown_option &amp;&amp; options-&gt;ignore_unknown_=
option[i]; i++)</span><br><span>         {</span><br><span>             if =
(streq(p[0], options-&gt;ignore_unknown_option[i]))</span><br><span>       =
      {</span><br><span>@@ -5815,7 +5819,7 @@</span><br><span> </span><br><=
span> </span><br><span> static bool</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-check_route_option(struct options *options, char *p[], const =
int msglevel, bool pull_mode)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+check_route_option(struct options *options, char *p[], const msgl=
vl_t msglevel, bool pull_mode)</span><br><span> {</span><br><span>     rol_=
check_alloc(options);</span><br><span>     if (pull_mode)</span><br><span>@=
@ -5843,7 +5847,7 @@</span><br><span> </span><br><span> </span><br><span> s=
tatic bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_route=
6_option(struct options *options, char *p[], const int msglevel, bool pull_=
mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_route6_o=
ption(struct options *options, char *p[], const msglvl_t msglevel, bool pul=
l_mode)</span><br><span> {</span><br><span>     rol6_check_alloc(options);<=
/span><br><span>     if (pull_mode)</span><br><span>@@ -5864,7 +5868,7 @@</=
span><br><span> }</span><br><span> </span><br><span> static bool</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-check_dns_option(struct options =
*options, char *p[], const int msglevel, bool pull_mode)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+check_dns_option(struct options *optio=
ns, char *p[], const msglvl_t msglevel, bool pull_mode)</span><br><span> {<=
/span><br><span>     if (streq(p[1], &quot;search-domains&quot;) &amp;&amp;=
 p[2])</span><br><span>     {</span><br><span>@@ -5984,7 +5988,7 @@</span><=
br><span>  */</span><br><span> static void</span><br><span> update_option(s=
truct context *c, struct options *options, char *p[], bool is_inline,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-              const char *f=
ile, int line, const int level, const int msglevel,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+              const char *file, int line,=
 const int level, const msglvl_t msglevel,</span><br><span>               c=
onst unsigned int permission_mask, unsigned int *option_types_found,</span>=
<br><span>               struct env_set *es, unsigned int *update_options_f=
ound)</span><br><span> {</span><br><span>@@ -6169,12 +6173,12 @@</span><br>=
<span> </span><br><span> static void</span><br><span> add_option(struct opt=
ions *options, char *p[], bool is_inline, const char *file, int line,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-           const int level,=
 const int msglevel, const unsigned int permission_mask,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+           const int level, const msgl=
vl_t msglevel, const unsigned int permission_mask,</span><br><span>        =
    unsigned int *option_types_found, struct env_set *es)</span><br><span> =
{</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>   =
  const bool pull_mode =3D BOOL_CAST(permission_mask &amp; OPT_P_PULL_MODE)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int msglevel_fc =
=3D msglevel_forward_compatible(options, msglevel);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msglvl_t msglevel_fc =3D msglevel_for=
ward_compatible(options, msglevel);</span><br><span> </span><br><span>     =
ASSERT(MAX_PARMS &gt;=3D 7);</span><br><span> </span><br><span>@@ -9869,7 +=
9873,7 @@</span><br><span>     else</span><br><span>     {</span><br><span>=
         int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  int msglevel_unknown =3D msglevel_fc;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msglvl_t msglevel_unknown =3D msglevel_fc;</spa=
n><br><span>         /* Check if an option is in --ignore-unknown-option an=
d</span><br><span>          * set warning level to non fatal */</span><br><=
span>         for (i =3D 0; options-&gt;ignore_unknown_option &amp;&amp; op=
tions-&gt;ignore_unknown_option[i]; i++)</span><br><span>diff --git a/src/o=
penvpn/options.h b/src/openvpn/options.h</span><br><span>index bb2c052..a73=
7711 100644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++=
 b/src/openvpn/options.h</span><br><span>@@ -822,7 +822,7 @@</span><br><spa=
n>     struct pull_filter *tail;</span><br><span> };</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-void parse_argv(struct opt=
ions *options, const int argc, char *argv[], const int msglevel,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void parse_argv(struct options=
 *options, const int argc, char *argv[], const msglvl_t msglevel,</span><br=
><span>                 const unsigned int permission_mask, unsigned int *o=
ption_types_found,</span><br><span>                 struct env_set *es);</s=
pan><br><span> </span><br><span>@@ -888,7 +888,7 @@</span><br><span> </span=
><br><span> void options_detach(struct options *o);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-void options_server_import(=
struct options *o, const char *filename, int msglevel,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void options_server_import(struct option=
s *o, const char *filename, msglvl_t msglevel,</span><br><span>            =
                unsigned int permission_mask, unsigned int *option_types_fo=
und,</span><br><span>                            struct env_set *es);</span=
><br><span> </span><br><span>@@ -897,13 +897,13 @@</span><br><span> void ro=
l_check_alloc(struct options *options);</span><br><span> </span><br><span> =
int parse_line(const char *line, char *p[], const int n, const char *file, =
const int line_num,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
             int msglevel, struct gc_arena *gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+               msglvl_t msglevel, struct gc_ar=
ena *gc);</span><br><span> </span><br><span> /*</span><br><span>  * parse/p=
rint topology coding</span><br><span>  */</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-int parse_topology(const char *str, c=
onst int msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
int parse_topology(const char *str, const msglvl_t msglevel);</span><br><sp=
an> </span><br><span> const char *print_topology(const int topology);</span=
><br><span> </span><br><span>@@ -917,11 +917,11 @@</span><br><span> </span>=
<br><span> int auth_retry_get(void);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-bool auth_retry_set(const int msglevel, co=
nst char *option);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ool auth_retry_set(const msglvl_t msglevel, const char *option);</span><br>=
<span> </span><br><span> const char *auth_retry_print(void);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void options_strin=
g_import(struct options *options, const char *config, const int msglevel,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void options_string_i=
mport(struct options *options, const char *config, const msglvl_t msglevel,=
</span><br><span>                            const unsigned int permission_=
mask, unsigned int *option_types_found,</span><br><span>                   =
         struct env_set *es);</span><br><span> </span><br><span>diff --git =
a/src/openvpn/options_util.c b/src/openvpn/options_util.c</span><br><span>i=
ndex 5740ee5..cb4229e 100644</span><br><span>--- a/src/openvpn/options_util=
.c</span><br><span>+++ b/src/openvpn/options_util.c</span><br><span>@@ -117=
,7 +117,7 @@</span><br><span> }</span><br><span> </span><br><span> int</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-positive_atoi(const char *=
str, int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+p=
ositive_atoi(const char *str, msglvl_t msglevel)</span><br><span> {</span><=
br><span>     char *endptr;</span><br><span>     long long i =3D strtoll(st=
r, &amp;endptr, 10);</span><br><span>@@ -132,7 +132,7 @@</span><br><span> }=
</span><br><span> </span><br><span> bool</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-positive_atoll(const char *str, int64_t *value, const ch=
ar *name, int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+positive_atoll(const char *str, int64_t *value, const char *name, msglv=
l_t msglevel)</span><br><span> {</span><br><span>     char *endptr;</span><=
br><span>     long long ll =3D strtoll(str, &amp;endptr, 10);</span><br><sp=
an>@@ -148,7 +148,7 @@</span><br><span> }</span><br><span> </span><br><span=
> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-atoi_warn(const =
char *str, int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+atoi_warn(const char *str, msglvl_t msglevel)</span><br><span> {</span=
><br><span>     char *endptr;</span><br><span>     long long i =3D strtoll(=
str, &amp;endptr, 10);</span><br><span>@@ -163,7 +163,7 @@</span><br><span>=
 }</span><br><span> </span><br><span> bool</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-atoi_constrained(const char *str, int *value, const ch=
ar *name, int min, int max, int msglevel)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+atoi_constrained(const char *str, int *value, const c=
har *name, int min, int max, msglvl_t msglevel)</span><br><span> {</span><b=
r><span>     ASSERT(min &lt; max);</span><br><span> </span><br><span>diff -=
-git a/src/openvpn/options_util.h b/src/openvpn/options_util.h</span><br><s=
pan>index 45417d9..1492eef 100644</span><br><span>--- a/src/openvpn/options=
_util.h</span><br><span>+++ b/src/openvpn/options_util.h</span><br><span>@@=
 -37,7 +37,7 @@</span><br><span>  * Converts a str to a positive number if =
the string represents a postive</span><br><span>  * integer number. Otherwi=
se print a warning with msglevel and return 0</span><br><span>  */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-int positive_atoi(const char *=
str, int msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
int positive_atoi(const char *str, msglvl_t msglevel);</span><br><span> </s=
pan><br><span> /**</span><br><span>  * Converts a str to an integer if the =
string can be represented as an</span><br><span>@@ -48,13 +48,13 @@</span><=
br><span>  *</span><br><span>  * @return \c true if the integer has been pa=
rsed and stored in value, \c false otherwise</span><br><span>  */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-bool positive_atoll(const char =
*str, int64_t *value, const char *name, int msglevel);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+bool positive_atoll(const char *str, int=
64_t *value, const char *name, msglvl_t msglevel);</span><br><span> </span>=
<br><span> /**</span><br><span>  * Converts a str to an integer if the stri=
ng can be represented as an</span><br><span>  * integer number. Otherwise p=
rint a warning with \p msglevel and return 0</span><br><span>  */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-int atoi_warn(const char *str, =
int msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int a=
toi_warn(const char *str, msglvl_t msglevel);</span><br><span> </span><br><=
span> /**</span><br><span>  * Converts a str to an integer if the string ca=
n be represented as an</span><br><span>@@ -66,7 +66,7 @@</span><br><span>  =
* @return \c true if the integer has been parsed and stored in value, \c fa=
lse otherwise</span><br><span>  */</span><br><span> bool atoi_constrained(c=
onst char *str, int *value, const char *name, int min, int max,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                      int msgleve=
l);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
      msglvl_t msglevel);</span><br><span> </span><br><span> /**</span><br>=
<span>  * Filter an option line by all pull filters.</span><br><span>diff -=
-git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c</span><br><span>in=
dex 09696db..ca318eb 100644</span><br><span>--- a/src/openvpn/packet_id.c</=
span><br><span>+++ b/src/openvpn/packet_id.c</span><br><span>@@ -53,15 +53,=
15 @@</span><br><span> #define SEQ_EXPIRED ((time_t)1)</span><br><span> </s=
pan><br><span> #ifdef ENABLE_DEBUG</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-static void packet_id_debug_print(int msglevel, const struct p=
acket_id_rec *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void packet_id_debug_print(msglvl_t msglevel, const struct packet_id_re=
c *p,</span><br><span>                                   const struct packe=
t_id_net *pin, const char *message,</span><br><span>                       =
            packet_id_print_type value);</span><br><span> </span><br><span>=
 #endif /* ENABLE_DEBUG */</span><br><span> </span><br><span> static inline=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-packet_id_debug(=
int msglevel, const struct packet_id_rec *p, const struct packet_id_net *pi=
n,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                con=
st char *message, uint64_t value)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+packet_id_debug(msglvl_t msglevel, const struct packet_id_rec=
 *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 const struct packet_id_net *pin, const char *message, uint64_t value)</spa=
n><br><span> {</span><br><span> #ifdef ENABLE_DEBUG</span><br><span>     if=
 (unlikely(check_debug_level(msglevel)))</span><br><span>@@ -573,7 +573,8 @=
@</span><br><span> #ifdef ENABLE_DEBUG</span><br><span> </span><br><span> s=
tatic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-packet_id_d=
ebug_print(int msglevel, const struct packet_id_rec *p, const struct packet=
_id_net *pin,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+packet=
_id_debug_print(msglvl_t msglevel, const struct packet_id_rec *p,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                      const s=
truct packet_id_net *pin,</span><br><span>                       const char=
 *message, packet_id_print_type value)</span><br><span> {</span><br><span> =
    struct gc_arena gc =3D gc_new();</span><br><span>diff --git a/src/openv=
pn/pkcs11.c b/src/openvpn/pkcs11.c</span><br><span>index dfc87f6..8a7a320 1=
00644</span><br><span>--- a/src/openvpn/pkcs11.c</span><br><span>+++ b/src/=
openvpn/pkcs11.c</span><br><span>@@ -72,10 +72,10 @@</span><br><span> #endi=
f</span><br><span> };</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static unsigned</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static msglvl_t</span><br><span> _pkcs11_msg_pkcs112openvpn(c=
onst unsigned flags)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    unsigned openvpn_flags;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    msglvl_t openvpn_flags;</span><br><span> </sp=
an><br><span>     switch (flags)</span><br><span>     {</span><br><span>@@ =
-112,7 +112,7 @@</span><br><span> }</span><br><span> </span><br><span> stat=
ic unsigned</span><br><span style=3D"color: hsl(0, 100%, 40%);">-_pkcs11_ms=
g_openvpn2pkcs11(const unsigned flags)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+_pkcs11_msg_openvpn2pkcs11(const msglvl_t flags)</span><=
br><span> {</span><br><span>     unsigned pkcs11_flags;</span><br><span> </=
span><br><span>diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c</sp=
an><br><span>index ea76a08..a105058 100644</span><br><span>--- a/src/openvp=
n/plugin.c</span><br><span>+++ b/src/openvpn/plugin.c</span><br><span>@@ -5=
0,7 +50,7 @@</span><br><span> static struct plugin_common *static_plugin_co=
mmon =3D NULL; /* GLOBAL */</span><br><span> </span><br><span> static void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-plugin_show_string_arr=
ay(int msglevel, const char *name, const char *array[])</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+plugin_show_string_array(msglvl_t msgle=
vel, const char *name, const char *array[])</span><br><span> {</span><br><s=
pan>     int i;</span><br><span>     for (i =3D 0; array[i]; ++i)</span><br=
><span>@@ -63,7 +63,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-plugin=
_show_args_env(int msglevel, const char *argv[], const char *envp[])</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+plugin_show_args_env(msglv=
l_t msglevel, const char *argv[], const char *envp[])</span><br><span> {</s=
pan><br><span>     if (check_debug_level(msglevel))</span><br><span>     {<=
/span><br><span>@@ -184,7 +184,7 @@</span><br><span> </span><br><span> #ifn=
def ENABLE_SMALL</span><br><span> void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-plugin_option_list_print(const struct plugin_option_list *=
list, int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
plugin_option_list_print(const struct plugin_option_list *list, msglvl_t ms=
glevel)</span><br><span> {</span><br><span>     int i;</span><br><span>    =
 struct gc_arena gc =3D gc_new();</span><br><span>@@ -995,7 +995,7 @@</span=
><br><span> </span><br><span> #ifdef ENABLE_DEBUG</span><br><span> void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-plugin_return_print(const=
 int msglevel, const char *prefix, const struct plugin_return *pr)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+plugin_return_print(const ms=
glvl_t msglevel, const char *prefix, const struct plugin_return *pr)</span>=
<br><span> {</span><br><span>     int i;</span><br><span>     msg(msglevel,=
 &quot;PLUGIN_RETURN_PRINT %s&quot;, prefix);</span><br><span>diff --git a/=
src/openvpn/plugin.h b/src/openvpn/plugin.h</span><br><span>index 63999b6..=
81d3739 100644</span><br><span>--- a/src/openvpn/plugin.h</span><br><span>+=
++ b/src/openvpn/plugin.h</span><br><span>@@ -111,7 +111,7 @@</span><br><sp=
an> bool plugin_option_list_add(struct plugin_option_list *list, char **p, =
struct gc_arena *gc);</span><br><span> </span><br><span> #ifndef ENABLE_SMA=
LL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void plugin_option_=
list_print(const struct plugin_option_list *list, int msglevel);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void plugin_option_list_print(=
const struct plugin_option_list *list, msglvl_t msglevel);</span><br><span>=
 </span><br><span> #endif</span><br><span> </span><br><span>@@ -136,7 +136,=
7 @@</span><br><span> void plugin_return_free(struct plugin_return *pr);</s=
pan><br><span> </span><br><span> #ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void plugin_return_print(const int msglevel=
, const char *prefix, const struct plugin_return *pr);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void plugin_return_print(const msglvl_t =
msglevel, const char *prefix, const struct plugin_return *pr);</span><br><s=
pan> </span><br><span> #endif</span><br><span> </span><br><span>diff --git =
a/src/openvpn/pool.c b/src/openvpn/pool.c</span><br><span>index fde6cea..28=
ddd2c 100644</span><br><span>--- a/src/openvpn/pool.c</span><br><span>+++ b=
/src/openvpn/pool.c</span><br><span>@@ -114,7 +114,7 @@</span><br><span>  *=
 Verify start/end range</span><br><span>  */</span><br><span> bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-ifconfig_pool_verify_range(con=
st int msglevel, const in_addr_t start, const in_addr_t end)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ifconfig_pool_verify_range(const m=
sglvl_t msglevel, const in_addr_t start, const in_addr_t end)</span><br><sp=
an> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span=
>     bool ret =3D true;</span><br><span>diff --git a/src/openvpn/pool.h b/=
src/openvpn/pool.h</span><br><span>index 6cecef0..36e9fca 100644</span><br>=
<span>--- a/src/openvpn/pool.h</span><br><span>+++ b/src/openvpn/pool.h</sp=
an><br><span>@@ -78,7 +78,7 @@</span><br><span> </span><br><span> void ifco=
nfig_pool_free(struct ifconfig_pool *pool);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-bool ifconfig_pool_verify_range(con=
st int msglevel, const in_addr_t start, const in_addr_t end);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+bool ifconfig_pool_verify_range(c=
onst msglvl_t msglevel, const in_addr_t start, const in_addr_t end);</span>=
<br><span> </span><br><span> ifconfig_pool_handle ifconfig_pool_acquire(str=
uct ifconfig_pool *pool, in_addr_t *local,</span><br><span>                =
                            in_addr_t *remote, struct in6_addr *remote_ipv6=
,</span><br><span>diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c</s=
pan><br><span>index 34b3378..ab77887 100644</span><br><span>--- a/src/openv=
pn/proto.c</span><br><span>+++ b/src/openvpn/proto.c</span><br><span>@@ -18=
3,7 +183,7 @@</span><br><span>             int hlen;</span><br><span>      =
       int totlen;</span><br><span>             const char *msgstr =3D &quo=
t;PACKET SIZE INFO&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            unsigned int msglevel =3D D_PACKET_TRUNC_DEBUG;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            msglvl_t msglevel =
=3D D_PACKET_TRUNC_DEBUG;</span><br><span> </span><br><span>             if=
 (BLEN(&amp;buf) &lt; (int)sizeof(struct openvpn_iphdr))</span><br><span>  =
           {</span><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/=
push.c</span><br><span>index 1ea7ed9..60ca25f 100644</span><br><span>--- a/=
src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span=
>@@ -373,8 +373,8 @@</span><br><span>  *</span><br><span>  * @return true o=
n success, false on failure.</span><br><span>  */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-static bool push_option_fmt(struct gc_arena *gc=
, struct push_list *push_list, int msglevel,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                            const char *fmt, ...)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool push_optio=
n_fmt(struct gc_arena *gc, struct push_list *push_list,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                            msglvl_t ms=
glevel, const char *fmt, ...)</span><br><span> #ifdef __GNUC__</span><br><s=
pan> #if __USE_MINGW_ANSI_STDIO</span><br><span>     __attribute__((format(=
gnu_printf, 4, 5)))</span><br><span>@@ -853,7 +853,7 @@</span><br><span> </=
span><br><span> static void</span><br><span> push_option_ex(struct gc_arena=
 *gc, struct push_list *push_list, const char *opt, bool enable,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-               int msglevel)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+               msglvl_t=
 msglevel)</span><br><span> {</span><br><span>     if (!string_class(opt, C=
C_ANY, CC_COMMA))</span><br><span>     {</span><br><span>@@ -881,7 +881,7 @=
@</span><br><span> }</span><br><span> </span><br><span> void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-push_option(struct options *o, const=
 char *opt, int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+push_option(struct options *o, const char *opt, msglvl_t msglevel)</s=
pan><br><span> {</span><br><span>     push_option_ex(&amp;o-&gt;gc, &amp;o-=
&gt;push_list, opt, true, msglevel);</span><br><span> }</span><br><span>@@ =
-902,7 +902,7 @@</span><br><span> }</span><br><span> </span><br><span> void=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-push_options(struct o=
ptions *o, char **p, int msglevel, struct gc_arena *gc)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+push_options(struct options *o, char **=
p, msglvl_t msglevel, struct gc_arena *gc)</span><br><span> {</span><br><sp=
an>     const char **argv =3D make_extended_arg_array(p, false, gc);</span>=
<br><span>     char *opt =3D print_argv(argv, gc, 0);</span><br><span>@@ -9=
10,8 +910,8 @@</span><br><span> }</span><br><span> </span><br><span> static=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-push_option_fmt(=
struct gc_arena *gc, struct push_list *push_list, int msglevel, const char =
*format,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   ...)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+push_option_=
fmt(struct gc_arena *gc, struct push_list *push_list,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msglvl_t msglevel, const =
char *format, ...)</span><br><span> {</span><br><span>     va_list arglist;=
</span><br><span>     char tmp[256] =3D { 0 };</span><br><span>diff --git a=
/src/openvpn/push.h b/src/openvpn/push.h</span><br><span>index 8ffd0c2..6b3=
275e 100644</span><br><span>--- a/src/openvpn/push.h</span><br><span>+++ b/=
src/openvpn/push.h</span><br><span>@@ -99,9 +99,9 @@</span><br><span> </spa=
n><br><span> void clone_push_list(struct options *o);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void push_option(struct o=
ptions *o, const char *opt, int msglevel);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void push_option(struct options *o, const char *opt,=
 msglvl_t msglevel);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-void push_options(struct options *o, char **p, int msgleve=
l, struct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void push_options(struct options *o, char **p, msglvl_t msglevel, stru=
ct gc_arena *gc);</span><br><span> </span><br><span> void push_reset(struct=
 options *o);</span><br><span> </span><br><span>diff --git a/src/openvpn/ro=
ute.c b/src/openvpn/route.c</span><br><span>index e504485..aa5ce69 100644</=
span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/=
route.c</span><br><span>@@ -1228,28 +1228,28 @@</span><br><span> }</span><b=
r><span> </span><br><span> static void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-print_route_option(const struct route_option *ro, int leve=
l)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+print_route_optio=
n(const struct route_option *ro, msglvl_t msglevel)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(level, &quot;  rou=
te %s/%s/%s/%s&quot;, show_opt(ro-&gt;network), show_opt(ro-&gt;netmask),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(msglevel, &qu=
ot;  route %s/%s/%s/%s&quot;, show_opt(ro-&gt;network), show_opt(ro-&gt;net=
mask),</span><br><span>         show_opt(ro-&gt;gateway), show_opt(ro-&gt;m=
etric));</span><br><span> }</span><br><span> </span><br><span> void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-print_route_options(const str=
uct route_option_list *rol, int level)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+print_route_options(const struct route_option_list *rol,=
 msglvl_t msglevel)</span><br><span> {</span><br><span>     struct route_op=
tion *ro;</span><br><span>     if (rol-&gt;flags &amp; RG_ENABLE)</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
msg(level, &quot;  [redirect_default_gateway local=3D%d]&quot;, (rol-&gt;fl=
ags &amp; RG_LOCAL) !=3D 0);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(msglevel, &quot;  [redirect_default_gateway local=3D%d=
]&quot;, (rol-&gt;flags &amp; RG_LOCAL) !=3D 0);</span><br><span>     }</sp=
an><br><span>     for (ro =3D rol-&gt;routes; ro; ro =3D ro-&gt;next)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    print_route_option(ro, level);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        print_route_option(ro, msglevel);</span><br><span>  =
   }</span><br><span> }</span><br><span> </span><br><span> void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-print_default_gateway(const int m=
sglevel, const struct route_gateway_info *rgi,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+print_default_gateway(const msglvl_t msglevel, c=
onst struct route_gateway_info *rgi,</span><br><span>                      =
 const struct route_ipv6_gateway_info *rgi6)</span><br><span> {</span><br><=
span>     struct gc_arena gc =3D gc_new();</span><br><span>@@ -1323,23 +132=
3,23 @@</span><br><span> #endif /* ifndef ENABLE_SMALL */</span><br><span> =
</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-print_route(const struct route_ipv4 *r, int level)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+print_route(const struct route_ipv4 =
*r, msglvl_t msglevel)</span><br><span> {</span><br><span>     struct gc_ar=
ena gc =3D gc_new();</span><br><span>     if (r-&gt;flags &amp; RT_DEFINED)=
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msg(level, &quot;%s&quot;, route_string(r, &amp;gc));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;%s&=
quot;, route_string(r, &amp;gc));</span><br><span>     }</span><br><span>  =
   gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-print_routes(cons=
t struct route_list *rl, int level)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+print_routes(const struct route_list *rl, msglvl_t msglevel=
)</span><br><span> {</span><br><span>     struct route_ipv4 *r;</span><br><=
span>     for (r =3D rl-&gt;routes; r; r =3D r-&gt;next)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        print_rou=
te(r, level);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  print_route(r, msglevel);</span><br><span>     }</span><br><span> }</span=
><br><span> </span><br><span>@@ -3059,18 +3059,18 @@</span><br><span>  * Sh=
ow current routing table</span><br><span>  */</span><br><span> void</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-show_routes(int msglev)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+show_routes(msglvl_t msgl=
evel)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new=
();</span><br><span> </span><br><span>     const MIB_IPFORWARDTABLE *rt =3D=
 get_windows_routing_table(&amp;gc);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    msg(msglev, &quot;SYSTEM ROUTING TABLE=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(msg=
level, &quot;SYSTEM ROUTING TABLE&quot;);</span><br><span>     if (rt)</spa=
n><br><span>     {</span><br><span>         for (DWORD i =3D 0; i &lt; rt-&=
gt;dwNumEntries; ++i)</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            msg(msglev, &quot;%s&quot;, format_r=
oute_entry(&amp;rt-&gt;table[i], &amp;gc));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(msglevel, &quot;%s&quot;, format_ro=
ute_entry(&amp;rt-&gt;table[i], &amp;gc));</span><br><span>         }</span=
><br><span>     }</span><br><span>     gc_free(&amp;gc);</span><br><span>di=
ff --git a/src/openvpn/route.h b/src/openvpn/route.h</span><br><span>index =
9b6a47e..c5006ae 100644</span><br><span>--- a/src/openvpn/route.h</span><br=
><span>+++ b/src/openvpn/route.h</span><br><span>@@ -356,7 +356,7 @@</span>=
<br><span> void get_default_gateway_ipv6(struct route_ipv6_gateway_info *rg=
i, const struct in6_addr *dest,</span><br><span>                           =
    openvpn_net_ctx_t *ctx);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-void print_default_gateway(const int msglevel, con=
st struct route_gateway_info *rgi,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void print_default_gateway(const msglvl_t msglevel, const st=
ruct route_gateway_info *rgi,</span><br><span>                            c=
onst struct route_ipv6_gateway_info *rgi6);</span><br><span> </span><br><sp=
an> /*</span><br><span>@@ -371,15 +371,15 @@</span><br><span> int test_loca=
l_addr(const in_addr_t addr, const struct route_gateway_info *rgi);</span><=
br><span> </span><br><span> #ifndef ENABLE_SMALL</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-void print_route_options(const struct route_opti=
on_list *rol, int level);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void print_route_options(const struct route_option_list *rol, msglvl_=
t msglevel);</span><br><span> </span><br><span> #endif</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-void print_routes(const =
struct route_list *rl, int level);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void print_routes(const struct route_list *rl, msglvl_t msgl=
evel);</span><br><span> </span><br><span> #ifdef _WIN32</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-void show_routes(int ms=
glev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void show_rou=
tes(msglvl_t msglevel);</span><br><span> </span><br><span> bool test_routes=
(const struct route_list *rl, const struct tuntap *tt);</span><br><span> </=
span><br><span>diff --git a/src/openvpn/run_command.c b/src/openvpn/run_com=
mand.c</span><br><span>index 4a1ef22..a0c9484 100644</span><br><span>--- a/=
src/openvpn/run_command.c</span><br><span>+++ b/src/openvpn/run_command.c</=
span><br><span>@@ -107,7 +107,7 @@</span><br><span> </span><br><span> #ifnd=
ef WIN32</span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-openvpn_waitpid_check(pid_t pid, const char *msg_prefix, int msgle=
vel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn_waitpid=
_check(pid_t pid, const char *msg_prefix, msglvl_t msglevel)</span><br><spa=
n> {</span><br><span>     if (pid =3D=3D 0)</span><br><span>     {</span><b=
r><span>diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h<=
/span><br><span>index afd1b88..234055e 100644</span><br><span>--- a/src/ope=
nvpn/run_command.h</span><br><span>+++ b/src/openvpn/run_command.h</span><b=
r><span>@@ -71,13 +71,13 @@</span><br><span>  * This function is currently =
not implemented for Windows as the helper</span><br><span>  * macros used b=
y this function are not available.</span><br><span>  *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">- * @param pid               pid of the pro=
cess to be checked</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param pid            pid of the process to be checked</span><br><span>  =
* @param msg_prefix     prefixed of the message that be printed</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * @param msglevel          msgle=
vel of the messages to be printed</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * @return                  true if the process is still runnin=
g, false if</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *        =
                  an error condition occurred</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param msglevel       msglevel of the messages=
 to be printed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn               true if the process is still running, false if</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *                       an =
error condition occurred</span><br><span>  */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-bool openvpn_waitpid_check(pid_t pid, const char *m=
sg_prefix, int msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+bool openvpn_waitpid_check(pid_t pid, const char *msg_prefix, msglvl_=
t msglevel);</span><br><span> </span><br><span> #endif</span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c</span><br>=
<span>index ecea635..42ad823 100644</span><br><span>--- a/src/openvpn/sig.c=
</span><br><span>+++ b/src/openvpn/sig.c</span><br><span>@@ -287,7 +287,7 @=
@</span><br><span> }</span><br><span> </span><br><span> void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-print_signal(const struct signal_inf=
o *si, const char *title, int msglevel)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+print_signal(const struct signal_info *si, const char *=
title, msglvl_t msglevel)</span><br><span> {</span><br><span>     if (si)</=
span><br><span>     {</span><br><span>diff --git a/src/openvpn/sig.h b/src/=
openvpn/sig.h</span><br><span>index 7e5dd9f..b5d81fc 100644</span><br><span=
>--- a/src/openvpn/sig.h</span><br><span>+++ b/src/openvpn/sig.h</span><br>=
<span>@@ -66,7 +66,7 @@</span><br><span> </span><br><span> void restore_sig=
nal_state(void);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void print_signal(const struct signal_info *si, const char *ti=
tle, int msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void print_signal(const struct signal_info *si, const char *title, msglvl_t=
 msglevel);</span><br><span> </span><br><span> void print_status(struct con=
text *c, struct status_output *so);</span><br><span> </span><br><span>diff =
--git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 3=
06170c..eeb42d1 100644</span><br><span>--- a/src/openvpn/socket.c</span><br=
><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -78,7 +78,7 @@</span><=
br><span> static int</span><br><span> get_addr_generic(sa_family_t af, unsi=
gned int flags, const char *hostname, void *network,</span><br><span>      =
            unsigned int *netbits, int resolve_retry_seconds, struct signal=
_info *sig_info,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
            int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                 msglvl_t msglevel)</span><br><span> {</span><br><spa=
n>     char *endp, *sep, *var_host =3D NULL;</span><br><span>     struct ad=
drinfo *ai =3D NULL;</span><br><span>@@ -211,7 +211,8 @@</span><br><span> }=
</span><br><span> </span><br><span> bool</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-get_ipv6_addr(const char *hostname, struct in6_addr *net=
work, unsigned int *netbits, int msglevel)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+get_ipv6_addr(const char *hostname, struct in6_addr =
*network, unsigned int *netbits,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+              msglvl_t msglevel)</span><br><span> {</span><br>=
<span>     if (get_addr_generic(AF_INET6, GETADDR_RESOLVE, hostname, networ=
k, netbits, 0, NULL, msglevel)</span><br><span>         &lt; 0)</span><br><=
span>@@ -1516,7 +1517,7 @@</span><br><span> linksock_print_addr(struct link=
_socket *sock)</span><br><span> {</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t int msglevel =3D (sock-&gt;mode =3D=3D LS_MODE_TCP_ACCEPT_FROM) ? D_INIT_=
MEDIUM : M_INFO;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const msglvl_t msglevel =3D (sock-&gt;mode =3D=3D LS_MODE_TCP_ACCEPT_FROM)=
 ? D_INIT_MEDIUM : M_INFO;</span><br><span> </span><br><span>     /* print =
local address */</span><br><span>     if (sock-&gt;bind_local)</span><br><s=
pan>diff --git a/src/openvpn/socket_util.c b/src/openvpn/socket_util.c</spa=
n><br><span>index 9b7312d..fa566e7 100644</span><br><span>--- a/src/openvpn=
/socket_util.c</span><br><span>+++ b/src/openvpn/socket_util.c</span><br><s=
pan>@@ -541,7 +541,7 @@</span><br><span>     struct addrinfo hints;</span><=
br><span>     int status;</span><br><span>     struct signal_info sigrec =
=3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int msg=
level =3D (flags &amp; GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    msglvl_t msglevel =3D (=
flags &amp; GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;</span><br><span>  =
   struct gc_arena gc =3D gc_new();</span><br><span>     const char *print_=
hostname;</span><br><span>     const char *print_servname;</span><br><span>=
@@ -604,7 +604,7 @@</span><br><span>         int resolve_retries =3D</span>=
<br><span>             (flags &amp; GETADDR_TRY_ONCE) ? 1 : ((resolve_retry=
_seconds + 4) / fail_wait_interval);</span><br><span>         const char *f=
mt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int level =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msglv=
l_t level =3D 0;</span><br><span> </span><br><span>         /* this is not =
a numeric IP, therefore force resolution using the</span><br><span>        =
  * provided ai_family */</span><br><span>@@ -739,7 +739,7 @@</span><br><sp=
an> done:</span><br><span>     if (sig_info &amp;&amp; sig_info-&gt;signal_=
received)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        int level =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msglvl_t level =3D 0;</span><br><span>         if (=
flags &amp; GETADDR_FATAL_ON_SIGNAL)</span><br><span>         {</span><br><=
span>             level =3D M_FATAL;</span><br><span>diff --git a/src/openv=
pn/socket_util.h b/src/openvpn/socket_util.h</span><br><span>index 361edff.=
.ada52a4 100644</span><br><span>--- a/src/openvpn/socket_util.h</span><br><=
span>+++ b/src/openvpn/socket_util.h</span><br><span>@@ -142,7 +142,7 @@</s=
pan><br><span>  * Translate an IPv6 addr or hostname from string form to in=
6_addr</span><br><span>  */</span><br><span> bool get_ipv6_addr(const char =
*hostname, struct in6_addr *network, unsigned int *netbits,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                   int msglevel);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                   msgl=
vl_t msglevel);</span><br><span> </span><br><span> int openvpn_getaddrinfo(=
unsigned int flags, const char *hostname, const char *servname,</span><br><=
span>                         int resolve_retry_seconds, struct signal_info=
 *sig_info, int ai_family,</span><br><span>diff --git a/src/openvpn/ssl_ver=
ify_backend.h b/src/openvpn/ssl_verify_backend.h</span><br><span>index a055=
9c9..2bad3eb 100644</span><br><span>--- a/src/openvpn/ssl_verify_backend.h<=
/span><br><span>+++ b/src/openvpn/ssl_verify_backend.h</span><br><span>@@ -=
193,8 +193,8 @@</span><br><span>  * @param gc            Garbage collection=
 arena for temp data</span><br><span>  *</span><br><span>  */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-void x509_track_add(const struct x5=
09_track **ll_head, const char *name, int msglevel,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    struct gc_arena *gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void x509_track_add(c=
onst struct x509_track **ll_head, const char *name,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    msglvl_t msglevel, st=
ruct gc_arena *gc);</span><br><span> </span><br><span> /*</span><br><span> =
 * Save X509 fields to environment, using the naming convention:</span><br>=
<span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verif=
y_mbedtls.c</span><br><span>index cfcfb25..3588071 100644</span><br><span>-=
-- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl=
_verify_mbedtls.c</span><br><span>@@ -350,7 +350,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-x509_track_add(const struct x509_track **ll_head, const cha=
r *name, int msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+x509_track_add(const struct x509_track **ll_head, const char *name, msgl=
vl_t msglevel,</span><br><span>                struct gc_arena *gc)</span><=
br><span> {</span><br><span>     struct x509_track *xt;</span><br><span>dif=
f --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl=
.c</span><br><span>index 6de7e2a..0f257e2 100644</span><br><span>--- a/src/=
openvpn/ssl_verify_openssl.c</span><br><span>+++ b/src/openvpn/ssl_verify_o=
penssl.c</span><br><span>@@ -414,7 +414,7 @@</span><br><span>  */</span><br=
><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-x509_track_add(const struct x509_track **ll_head, const char *name=
, int msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+x509=
_track_add(const struct x509_track **ll_head, const char *name, msglvl_t ms=
glevel,</span><br><span>                struct gc_arena *gc)</span><br><spa=
n> {</span><br><span>     struct x509_track *xt;</span><br><span>diff --git=
 a/src/openvpn/status.c b/src/openvpn/status.c</span><br><span>index 34e5a2=
f..cea31f5 100644</span><br><span>--- a/src/openvpn/status.c</span><br><spa=
n>+++ b/src/openvpn/status.c</span><br><span>@@ -230,14 +230,13 @@</span><b=
r><span> </span><br><span>         if (so-&gt;msglevel &gt;=3D 0 &amp;&amp;=
 !so-&gt;errors)</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            msg(so-&gt;msglevel, &quot;%s&quot;, buf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg((m=
sglvl_t)so-&gt;msglevel, &quot;%s&quot;, buf);</span><br><span>         }</=
span><br><span> </span><br><span>         if (so-&gt;fd &gt;=3D 0 &amp;&amp=
; !so-&gt;errors)</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            int len;</span><br><span>             st=
rcat(buf, &quot;\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            len =3D strlen(buf);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            size_t len =3D strlen(buf);</span><br><span> =
            if (len &gt; 0)</span><br><span>             {</span><br><span>=
                 if (write(so-&gt;fd, buf, len) !=3D len)</span><br><span>d=
iff --git a/src/openvpn/status.h b/src/openvpn/status.h</span><br><span>ind=
ex 0c7a869..25e1663 100644</span><br><span>--- a/src/openvpn/status.h</span=
><br><span>+++ b/src/openvpn/status.h</span><br><span>@@ -53,6 +53,7 @@</sp=
an><br><span> </span><br><span>     char *filename;</span><br><span>     in=
t fd;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* NB: -1 =
is used to indicate that output should only go to the file */</span><br><sp=
an>     int msglevel;</span><br><span>     const struct virtual_output *vou=
t;</span><br><span> </span><br><span>diff --git a/src/openvpn/tun.c b/src/o=
penvpn/tun.c</span><br><span>index ee0733a..9618301 100644</span><br><span>=
--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><=
span>@@ -105,9 +105,9 @@</span><br><span> static void netsh_set_dns6_server=
s(const struct in6_addr *addr_list, const int addr_len,</span><br><span>   =
                                 DWORD adapter_index);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-static void netsh_comman=
d(const struct argv *a, int n, int msglevel);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void netsh_command(const struct argv *a, i=
nt n, msglvl_t msglevel);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-static void exec_command(const char *prefix, const st=
ruct argv *a, int n, int msglevel);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void exec_command(const char *prefix, const struct a=
rgv *a, int n, msglvl_t msglevel);</span><br><span> </span><br><span> stati=
c const char *netsh_get_id(const char *dev_node, struct gc_arena *gc);</spa=
n><br><span> </span><br><span>@@ -4001,7 +4001,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-show_tap_win_adapters(int msglev, int warnlev)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+show_tap_win_adapters(msglvl_t msg=
level, msglvl_t warnlevel)</span><br><span> {</span><br><span>     struct g=
c_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ -4018,7 +4018=
,7 @@</span><br><span>     const struct tap_reg *tap_reg =3D get_tap_reg(&a=
mp;gc);</span><br><span>     const struct panel_reg *panel_reg =3D get_pane=
l_reg(&amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    msg(msglev, &quot;Available adapters [name, GUID, driver]:&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(msgl=
evel, &quot;Available adapters [name, GUID, driver]:&quot;);</span><br><spa=
n> </span><br><span>     /* loop through each TAP-Windows adapter registry =
entry */</span><br><span>     for (tr =3D tap_reg; tr !=3D NULL; tr =3D tr-=
&gt;next)</span><br><span>@@ -4030,7 +4030,7 @@</span><br><span>         {<=
/span><br><span>             if (!strcmp(tr-&gt;guid, pr-&gt;guid))</span><=
br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                msg(msglev, &quot;&#39;%s&#39; %s %s&quot;, pr-&gt;name, =
tr-&gt;guid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         msg(msglevel, &quot;&#39;%s&#39; %s %s&quot;, pr-&gt;name, tr-&gt;=
guid,</span><br><span>                     print_tun_backend_driver(tr-&gt;=
windows_driver));</span><br><span>                 ++links;</span><br><span=
>             }</span><br><span>@@ -4045,7 +4045,7 @@</span><br><span>     =
        /* a TAP adapter exists without a link from the network</span><br><=
span>              * connections control panel */</span><br><span>         =
    warn_panel_null =3D true;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            msg(msglev, &quot;[NULL] %s&quot;, tr-&gt;guid);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, =
&quot;[NULL] %s&quot;, tr-&gt;guid);</span><br><span>         }</span><br><=
span>     }</span><br><span> </span><br><span>@@ -4064,18 +4064,18 @@</span=
><br><span>     /* warn on registry inconsistencies */</span><br><span>    =
 if (warn_tap_dup)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        msg(warnlev, &quot;WARNING: Some TAP-Windows ad=
apters have duplicate GUIDs&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(warnlevel, &quot;WARNING: Some TAP-Windows adap=
ters have duplicate GUIDs&quot;);</span><br><span>     }</span><br><span> <=
/span><br><span>     if (warn_panel_dup)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(warnlev,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(warnlevel,</span><br=
><span>             &quot;WARNING: Some TAP-Windows adapters have duplicate=
 links from the Network Connections control panel&quot;);</span><br><span> =
    }</span><br><span> </span><br><span>     if (warn_panel_null)</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
msg(warnlev,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 msg(warnlevel,</span><br><span>             &quot;WARNING: Some TAP-Window=
s adapters have no link from the Network Connections control panel&quot;);<=
/span><br><span>     }</span><br><span> </span><br><span>@@ -4805,31 +4805,=
31 @@</span><br><span>  * Show info for a single adapter</span><br><span>  =
*/</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-show_adapter(int msglev, const IP_ADAPTER_INFO *a, struct gc_aren=
a *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_adapter(=
msglvl_t msglevel, const IP_ADAPTER_INFO *a, struct gc_arena *gc)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(msgl=
ev, &quot;%s&quot;, a-&gt;Description);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    msg(msglev, &quot;  Index =3D %d&quot;, (int)a-&gt;In=
dex);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(msglev, =
&quot;  GUID =3D %s&quot;, a-&gt;AdapterName);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    msg(msglev, &quot;  IP =3D %s&quot;, format_ip=
_addr_string(&amp;a-&gt;IpAddressList, gc));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    msg(msglev, &quot;  MAC =3D %s&quot;, format_hex=
_ex(a-&gt;Address, a-&gt;AddressLength, 0, 1, &quot;:&quot;, gc));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    msg(msglev, &quot;  GATEWA=
Y =3D %s&quot;, format_ip_addr_string(&amp;a-&gt;GatewayList, gc));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(msglevel, &quot;%s&=
quot;, a-&gt;Description);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    msg(msglevel, &quot;  Index =3D %d&quot;, (int)a-&gt;Index);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(msglevel, &quot=
;  GUID =3D %s&quot;, a-&gt;AdapterName);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    msg(msglevel, &quot;  IP =3D %s&quot;, format_ip_=
addr_string(&amp;a-&gt;IpAddressList, gc));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    msg(msglevel, &quot;  MAC =3D %s&quot;, format_=
hex_ex(a-&gt;Address, a-&gt;AddressLength, 0, 1, &quot;:&quot;, gc));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(msglevel, &quot; =
 GATEWAY =3D %s&quot;, format_ip_addr_string(&amp;a-&gt;GatewayList, gc));<=
/span><br><span>     if (a-&gt;DhcpEnabled)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        msg(msglev, &quot;  DH=
CP SERV =3D %s&quot;, format_ip_addr_string(&amp;a-&gt;DhcpServer, gc));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(msglev, &quo=
t;  DHCP LEASE OBTAINED =3D %s&quot;, time_string(a-&gt;LeaseObtained, 0, f=
alse, gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ms=
g(msglev, &quot;  DHCP LEASE EXPIRES  =3D %s&quot;, time_string(a-&gt;Lease=
Expires, 0, false, gc));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(msglevel, &quot;  DHCP SERV =3D %s&quot;, format_ip_addr_s=
tring(&amp;a-&gt;DhcpServer, gc));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(msglevel, &quot;  DHCP LEASE OBTAINED =3D %s&quo=
t;, time_string(a-&gt;LeaseObtained, 0, false, gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;  DHCP LEASE =
EXPIRES  =3D %s&quot;, time_string(a-&gt;LeaseExpires, 0, false, gc));</spa=
n><br><span>     }</span><br><span>     if (a-&gt;HaveWins)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(ms=
glev, &quot;  PRI WINS =3D %s&quot;, format_ip_addr_string(&amp;a-&gt;Prima=
ryWinsServer, gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      msg(msglev, &quot;  SEC WINS =3D %s&quot;, format_ip_addr_string(&amp=
;a-&gt;SecondaryWinsServer, gc));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(msglevel, &quot;  PRI WINS =3D %s&quot;, format_i=
p_addr_string(&amp;a-&gt;PrimaryWinsServer, gc));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;  SEC WINS =3D %s=
&quot;, format_ip_addr_string(&amp;a-&gt;SecondaryWinsServer, gc));</span><=
br><span>     }</span><br><span> </span><br><span>     {</span><br><span>  =
       const IP_PER_ADAPTER_INFO *pai =3D get_per_adapter_info(a-&gt;Index,=
 gc);</span><br><span>         if (pai)</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msglev, &quot;=
  DNS SERV =3D %s&quot;, format_ip_addr_string(&amp;pai-&gt;DnsServerList, =
gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ms=
g(msglevel, &quot;  DNS SERV =3D %s&quot;, format_ip_addr_string(&amp;pai-&=
gt;DnsServerList, gc));</span><br><span>         }</span><br><span>     }</=
span><br><span> }</span><br><span>@@ -4838,12 +4838,12 @@</span><br><span> =
 * Show current adapter list</span><br><span>  */</span><br><span> void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-show_adapters(int msglev)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+show_adapters(msglv=
l_t msglevel)</span><br><span> {</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span>     const IP_ADAPTER_INFO *ai =3D get_adapte=
r_info_list(&amp;gc);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    msg(msglev, &quot;SYSTEM ADAPTER LIST&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(msglevel, &quot;SYS=
TEM ADAPTER LIST&quot;);</span><br><span>     if (ai)</span><br><span>     =
{</span><br><span>         const IP_ADAPTER_INFO *a;</span><br><span>@@ -48=
51,7 +4851,7 @@</span><br><span>         /* find index in the linked list *=
/</span><br><span>         for (a =3D ai; a !=3D NULL; a =3D a-&gt;Next)</s=
pan><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            show_adapter(msglev, a, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            show_adapter(msglevel, a, &amp;gc)=
;</span><br><span>         }</span><br><span>     }</span><br><span>     gc=
_free(&amp;gc);</span><br><span>@@ -5048,7 +5048,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> static void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-exec_command(const char *prefix, const struct argv *=
a, int n, int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+exec_command(const char *prefix, const struct argv *a, int n, msglvl_t =
msglevel)</span><br><span> {</span><br><span>     int i;</span><br><span>  =
   for (i =3D 0; i &lt; n; ++i)</span><br><span>@@ -5069,7 +5069,7 @@</span=
><br><span> }</span><br><span> </span><br><span> static void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-netsh_command(const struct argv *a, =
int n, int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+netsh_command(const struct argv *a, int n, msglvl_t msglevel)</span><br><s=
pan> {</span><br><span>     exec_command(&quot;NETSH&quot;, a, n, msglevel)=
;</span><br><span> }</span><br><span>diff --git a/src/openvpn/tun.h b/src/o=
penvpn/tun.h</span><br><span>index 06fc729..6562c22 100644</span><br><span>=
--- a/src/openvpn/tun.h</span><br><span>+++ b/src/openvpn/tun.h</span><br><=
span>@@ -445,9 +445,9 @@</span><br><span> DWORD adapter_index_of_ip(const I=
P_ADAPTER_INFO *list, const in_addr_t ip, int *count,</span><br><span>     =
                      in_addr_t *netmask);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void show_tap_win_adapters(int msgle=
v, int warnlev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d show_tap_win_adapters(msglvl_t msglevel, msglvl_t warnlevel);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void show_adapt=
ers(int msglev);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d show_adapters(msglvl_t msglevel);</span><br><span> </span><br><span> void=
 tap_allow_nonadmin_access(const char *dev_node);</span><br><span> </span><=
br><span>diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_test=
s/openvpn/mock_msg.c</span><br><span>index 603520b..69d2d1d 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/mock_msg.c</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/mock_msg.c</span><br><span>@@ -38,8 +38,8 @@</span><b=
r><span> #include &quot;error.h&quot;</span><br><span> #include &quot;mock_=
msg.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-unsigned int x_debug_level =3D 0; /* Default to (almost) no debuggi=
ng output */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned =
int print_x_debug_level =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+msglvl_t x_debug_level =3D 0; /* Default to (almost) no debuggin=
g output */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+msglvl_t=
 print_x_debug_level =3D 0;</span><br><span> </span><br><span> bool fatal_e=
rror_triggered =3D false;</span><br><span> </span><br><span>@@ -47,31 +47,3=
1 @@</span><br><span> </span><br><span> </span><br><span> void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-mock_set_debug_level(int level)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+mock_set_debug_level(m=
sglvl_t level)</span><br><span> {</span><br><span>     x_debug_level =3D le=
vel;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+msglvl_t</span><br><span> mock_get_debug_level(void)</span><br><span> {=
</span><br><span>     return x_debug_level;</span><br><span> }</span><br><s=
pan> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-mock_set_print_debug_level(int level)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+mock_set_print_debug_level(msglvl_t level)</span><b=
r><span> {</span><br><span>     print_x_debug_level =3D level;</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+msglvl_t</spa=
n><br><span> get_debug_level(void)</span><br><span> {</span><br><span>     =
return x_debug_level;</span><br><span> }</span><br><span> </span><br><span>=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-x_msg_va(const u=
nsigned int flags, const char *format, va_list arglist)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+x_msg_va(const msglvl_t flags, const ch=
ar *format, va_list arglist)</span><br><span> {</span><br><span>     if (fl=
ags &amp; M_FATAL)</span><br><span>     {</span><br><span>@@ -89,7 +89,7 @@=
</span><br><span> }</span><br><span> </span><br><span> void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-x_msg(const unsigned int flags, const=
 char *format, ...)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
x_msg(const msglvl_t flags, const char *format, ...)</span><br><span> {</sp=
an><br><span>     va_list arglist;</span><br><span>     va_start(arglist, f=
ormat);</span><br><span>@@ -128,7 +128,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-dont_mute(unsigned int flags)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+dont_mute(msglvl_t flags)</span><br><span> {</span><br><spa=
n>     return true;</span><br><span> }</span><br><span>diff --git a/tests/u=
nit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn/mock_msg.h</span><b=
r><span>index f4ebc23..6dddf0b 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/mock_msg.h</span><br><span>+++ b/tests/unit_tests/openvpn/mock_ms=
g.h</span><br><span>@@ -28,17 +28,15 @@</span><br><span>  * this function f=
rom your test driver to increase debug output when you</span><br><span>  * =
need debug output.</span><br><span>  */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-void mock_set_debug_level(int level);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void mock_set_debug_level(msglvl_t leve=
l);</span><br><span> </span><br><span> #define MOCK_MSG_BUF 2048</span><br>=
<span> </span><br><span> extern bool fatal_error_triggered;</span><br><span=
> extern char mock_msg_buf[MOCK_MSG_BUF];</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-void mock_set_debug_level(int level);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+msglvl_t mock_get_d=
ebug_level(void);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-int mock_get_debug_level(void);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-void mock_set_print_debug_level(int level);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void mock_set_print_debug_level(msglvl_t level);=
</span><br><span> </span><br><span> #endif /* MOCK_MSG */</span><br><span>d=
iff --git a/tests/unit_tests/openvpn/mock_ssl_dependencies.c b/tests/unit_t=
ests/openvpn/mock_ssl_dependencies.c</span><br><span>index 7333c47..f2fa93a=
 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_ssl_dependencie=
s.c</span><br><span>+++ b/tests/unit_tests/openvpn/mock_ssl_dependencies.c<=
/span><br><span>@@ -38,7 +38,7 @@</span><br><span> </span><br><span> int</s=
pan><br><span> parse_line(const char *line, char **p, const int n, const ch=
ar *file, const int line_num,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-           int msglevel, struct gc_arena *gc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           msglvl_t msglevel, struct gc_a=
rena *gc)</span><br><span> {</span><br><span>     /* Dummy function to get =
the linker happy, should never be called */</span><br><span>     assert_tru=
e(false);</span><br><span>diff --git a/tests/unit_tests/openvpn/test_argv.c=
 b/tests/unit_tests/openvpn/test_argv.c</span><br><span>index a65857b..a04f=
abc 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_argv.c</span=
><br><span>+++ b/tests/unit_tests/openvpn/test_argv.c</span><br><span>@@ -2=
3,7 +23,7 @@</span><br><span> </span><br><span> int</span><br><span> __wrap=
_parse_line(const char *line, char **p, const int n, const char *file, cons=
t int line_num,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
            int msglevel, struct gc_arena *gc)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                  msglvl_t msglevel, struct gc_a=
rena *gc)</span><br><span> {</span><br><span>     p[0] =3D PATH1 PATH2;</sp=
an><br><span>     p[1] =3D PARAM1;</span><br><span>diff --git a/tests/unit_=
tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c</span><br>=
<span>index 93e2460..dbfdd56 100644</span><br><span>--- a/tests/unit_tests/=
openvpn/test_misc.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_mis=
c.c</span><br><span>@@ -339,8 +339,8 @@</span><br><span>     assert_false(v=
alid_integer(&quot;-2147483653&quot;, false));</span><br><span> </span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int msglev=
el =3D D_LOW;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int =
saved_log_level =3D mock_get_debug_level();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    msglvl_t msglevel =3D D_LOW;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    msglvl_t saved_log_level =3D mock_=
get_debug_level();</span><br><span>     mock_set_debug_level(D_LOW);</span>=
<br><span> </span><br><span>     /* check happy path */</span><br><span>dif=
f --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn=
/test_pkcs11.c</span><br><span>index 9ba6cfc..d568865 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_pkcs11.c</span><br><span>@@ -59,7 +59,7 @@</span><b=
r><span> /* stubs for some unused functions instead of pulling in too many =
dependencies */</span><br><span> int</span><br><span> parse_line(const char=
 *line, char **p, const int n, const char *file, const int line_num,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-           int msglevel, str=
uct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
         msglvl_t msglevel, struct gc_arena *gc)</span><br><span> {</span><=
br><span>     assert_true(0);</span><br><span>     return 0;</span><br><spa=
n>diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openv=
pn/test_pkt.c</span><br><span>index 5122766..b6c612b 100644</span><br><span=
>--- a/tests/unit_tests/openvpn/test_pkt.c</span><br><span>+++ b/tests/unit=
_tests/openvpn/test_pkt.c</span><br><span>@@ -45,7 +45,7 @@</span><br><span=
> </span><br><span> int</span><br><span> parse_line(const char *line, char =
**p, const int n, const char *file, const int line_num,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-           int msglevel, struct gc_arena =
*gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           msgl=
vl_t msglevel, struct gc_arena *gc)</span><br><span> {</span><br><span>    =
 /* Dummy function to get the linker happy, should never be called */</span=
><br><span>     assert_true(false);</span><br><span>diff --git a/tests/unit=
_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_=
update_msg.c</span><br><span>index 87329b1..8a5beeb 100644</span><br><span>=
--- a/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><span>+++ b=
/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><span>@@ -111,7 =
+111,7 @@</span><br><span> </span><br><span> #ifndef ENABLE_MANAGEMENT</spa=
n><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-send=
_control_channel_string(struct context *c, const char *str, int msglevel)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_control_channel_=
string(struct context *c, const char *str, msglvl_t msglevel)</span><br><sp=
an> {</span><br><span>     return true;</span><br><span> }</span><br><span>=
@@ -120,7 +120,7 @@</span><br><span> int i;</span><br><span> </span><br><sp=
an> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-send_control_=
channel_string(struct context *c, const char *str, int msglevel)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+send_control_channel_string(st=
ruct context *c, const char *str, msglvl_t msglevel)</span><br><span> {</sp=
an><br><span>     if (res &amp;&amp; res[i] &amp;&amp; strcmp(res[i], str))=
</span><br><span>     {</span><br><span>diff --git a/tests/unit_tests/openv=
pn/test_socket.c b/tests/unit_tests/openvpn/test_socket.c</span><br><span>i=
ndex 2da2529..7f740ac 100644</span><br><span>--- a/tests/unit_tests/openvpn=
/test_socket.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_socket.c=
</span><br><span>@@ -59,7 +59,7 @@</span><br><span> </span><br><span> int</=
span><br><span> parse_line(const char *line, char **p, const int n, const c=
har *file, const int line_num,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-           int msglevel, struct gc_arena *gc)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+           msglvl_t msglevel, struct gc_=
arena *gc)</span><br><span> {</span><br><span>     assert_true(0);</span><b=
r><span>     return 0;</span><br><span>diff --git a/tests/unit_tests/openvp=
n/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><s=
pan>index 532bfcd..44d51fe 100644</span><br><span>--- a/tests/unit_tests/op=
envpn/test_tls_crypt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
tls_crypt.c</span><br><span>@@ -98,7 +98,7 @@</span><br><span> </span><br><=
span> int</span><br><span> __wrap_parse_line(const char *line, char **p, co=
nst int n, const char *file, const int line_num,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                  int msglevel, struct gc_arena =
*gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
   msglvl_t msglevel, struct gc_arena *gc)</span><br><span> {</span><br><sp=
an>     p[0] =3D PATH1 PATH2;</span><br><span>     p[1] =3D PARAM1;</span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/uni=
t_tests/openvpn/test_user_pass.c</span><br><span>index 460b37f..32ec59f 100=
644</span><br><span>--- a/tests/unit_tests/openvpn/test_user_pass.c</span><=
br><span>+++ b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>@@=
 -73,7 +73,7 @@</span><br><span> /* stubs for some unused functions instead=
 of pulling in too many dependencies */</span><br><span> int</span><br><spa=
n> parse_line(const char *line, char **p, const int n, const char *file, co=
nst int line_num,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
       int msglevel, struct gc_arena *gc)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+           msglvl_t msglevel, struct gc_arena *gc)</s=
pan><br><span> {</span><br><span>     assert_true(0);</span><br><span>     =
return 0;</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1110?usp=3Demail">change 1110</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1110?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id492cb774c6d022d06bb3cf5fec=
2a4bdd410e619 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1110 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 17 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--dlby/pvO9xY=--

