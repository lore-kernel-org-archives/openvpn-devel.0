From: Gert Doering <gert@...1296...>
Date: Wed, 17 Sep 2025 19:04:19 +0200
Message-ID: <20250917170428.3310-1-gert@...1296...>
In-Reply-To: <gerrit.1753364704000.Id492cb774c6d022d06bb3cf5fec2a4bdd410e619@...2715...>
References: <gerrit.1753364704000.Id492cb774c6d022d06bb3cf5fec2a4bdd410e619@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v16] Introduce msglvl_t to unify msglevel
 type handling
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
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1110
This mail reflects revision 16 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 903fc0a..79b541a 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -235,14 +235,14 @@
 /**
  *  Write the arguments stored in a struct argv via the msg() command.
  *
- *  @param msglev  Integer with the message level used by msg().
- *  @param a       Valid pointer to the struct argv with the arguments to write.
+ *  @param msglevel  Integer with the message level used by msg().
+ *  @param a         Valid pointer to the struct argv with the arguments to write.
  */
 void
-argv_msg(const int msglev, const struct argv *a)
+argv_msg(const msglvl_t msglevel, const struct argv *a)
 {
     struct gc_arena gc = gc_new();
-    msg(msglev, "%s", argv_str(a, &gc, 0));
+    msg(msglevel, "%s", argv_str(a, &gc, 0));
     gc_free(&gc);
 }
 
@@ -250,16 +250,16 @@
  *  Similar to argv_msg() but prefixes the messages being written with a
  *  given string.
  *
- *  @param msglev  Integer with the message level used by msg().
- *  @param a       Valid pointer to the struct argv with the arguments to write
- *  @param prefix  Valid pointer to the prefix string
+ *  @param msglevel  Integer with the message level used by msg().
+ *  @param a         Valid pointer to the struct argv with the arguments to write
+ *  @param prefix    Valid pointer to the prefix string
  *
  */
 void
-argv_msg_prefix(const int msglev, const struct argv *a, const char *prefix)
+argv_msg_prefix(const msglvl_t msglevel, const struct argv *a, const char *prefix)
 {
     struct gc_arena gc = gc_new();
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
 
-void argv_msg_prefix(const int msglev, const struct argv *a, const char *prefix);
+void argv_msg_prefix(const msglvl_t msglevel, const struct argv *a, const char *prefix);
 
 void argv_parse_cmd(struct argv *a, const char *s);
 
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 0f0d17e..c0b85b2 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1127,7 +1127,7 @@
 {
     if (buf && buf->len)
     {
-        int msglevel = D_ALIGN_DEBUG;
+        msglvl_t msglevel = D_ALIGN_DEBUG;
         const unsigned int u = (unsigned int)BPTR(buf);
 
         if (u & (PAYLOAD_ALIGN - 1))
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index 48a2057..b49d4bb 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -47,7 +47,7 @@
 }
 
 void
-print_client_nat_list(const struct client_nat_option_list *list, int msglevel)
+print_client_nat_list(const struct client_nat_option_list *list, msglvl_t msglevel)
 {
     struct gc_arena gc = gc_new();
     int i;
@@ -101,7 +101,7 @@
 void
 add_client_nat_to_option_list(struct client_nat_option_list *dest, const char *type,
                               const char *network, const char *netmask, const char *foreign_network,
-                              int msglevel)
+                              msglvl_t msglevel)
 {
     struct client_nat_entry e;
     bool ok;
@@ -159,7 +159,7 @@
 #endif
 
 static void
-print_pkt(struct openvpn_iphdr *iph, const char *prefix, const int direction, const int msglevel)
+print_pkt(struct openvpn_iphdr *iph, const char *prefix, const int direction, const msglvl_t msglevel)
 {
     struct gc_arena gc = gc_new();
 
diff --git a/src/openvpn/clinat.h b/src/openvpn/clinat.h
index abfa0b7..7d787e0 100644
--- a/src/openvpn/clinat.h
+++ b/src/openvpn/clinat.h
@@ -54,11 +54,11 @@
 void copy_client_nat_option_list(struct client_nat_option_list *dest,
                                  const struct client_nat_option_list *src);
 
-void print_client_nat_list(const struct client_nat_option_list *list, int msglevel);
+void print_client_nat_list(const struct client_nat_option_list *list, msglvl_t msglevel);
 
 void add_client_nat_to_option_list(struct client_nat_option_list *dest, const char *type,
                                    const char *network, const char *netmask,
-                                   const char *foreign_network, int msglevel);
+                                   const char *foreign_network, msglvl_t msglevel);
 
 void client_nat_transform(const struct client_nat_option_list *list, struct buffer *ipbuf,
                           const int direction);
diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 1a2e775..9d35141 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -159,7 +159,7 @@
 #endif /* USE_COMP */
 
 bool
-check_compression_settings_valid(struct compress_options *info, int msglevel)
+check_compression_settings_valid(struct compress_options *info, msglvl_t msglevel)
 {
     /*
      * We also allow comp-stub-v2 here as it technically allows escaping of
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 0354896..1717029 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -84,12 +84,14 @@
            && info->alg != COMP_ALG_UNDEF;
 }
 
+#include "error.h"
+
 /**
  * Checks if the compression settings are valid. Takes into account the
  * flags of allow-compression and also the whether algorithms are compiled
  * in
  */
-bool check_compression_settings_valid(struct compress_options *info, int msglevel);
+bool check_compression_settings_valid(struct compress_options *info, msglvl_t msglevel);
 
 #ifdef USE_COMP
 #include "buffer.h"
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 1535c78..0e930d6 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1618,7 +1618,7 @@
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
 
 void must_have_n_keys(const char *filename, const char *option, const struct key2 *key2, int n);
 
-int ascii2keydirection(int msglevel, const char *str);
+int ascii2keydirection(msglvl_t msglevel, const char *str);
 
 const char *keydirection2ascii(int kd, bool remote, bool humanreadable);
 
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 823b4f9..2cf90af 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -233,7 +233,7 @@
 }
 
 static bool
-dco_check_option_ce(const struct connection_entry *ce, int msglevel, int mode)
+dco_check_option_ce(const struct connection_entry *ce, msglvl_t msglevel, int mode)
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
  * Check whether the options struct has any further option that is not supported
@@ -87,7 +87,7 @@
  * @param o         the options struct that hold the options
  * @return          true if no conflict was detected, false otherwise
  */
-bool dco_check_startup_option(int msglevel, const struct options *o);
+bool dco_check_startup_option(msglvl_t msglevel, const struct options *o);
 
 /**
  * Check whether any of the options pushed by the server is not supported by
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
index 56a774d..b9f6bc7 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -663,7 +663,7 @@
 }
 
 bool
-dco_available(int msglevel)
+dco_available(msglvl_t msglevel)
 {
     struct if_clonereq ifcr;
     char *buf = NULL;
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 3b08f33..395a38f 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -79,7 +79,7 @@
  * @return ID on success, negative error code on error
  */
 static int
-resolve_ovpn_netlink_id(int msglevel)
+resolve_ovpn_netlink_id(msglvl_t msglevel)
 {
     int ret;
     struct nl_sock *nl_sock = nl_socket_alloc();
@@ -1204,7 +1204,7 @@
 }
 
 bool
-dco_available(int msglevel)
+dco_available(msglvl_t msglevel)
 {
     if (resolve_ovpn_netlink_id(D_DCO_DEBUG) < 0)
     {
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 1dc5cf8..9e52859 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -609,7 +609,7 @@
 }
 
 bool
-dco_available(int msglevel)
+dco_available(msglvl_t msglevel)
 {
     /* try to open device by symbolic name */
     HANDLE h = CreateFile("\\\\.\\ovpn-dco", GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING,
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
     const struct dns_server *server = o->servers ? o->servers : o->servers_prepull;
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
-    const int ceiling = 15;
-
-    if (level >= 0 && level <= ceiling)
+    if (level >= 0 && level <= M_DEBUG_LEVEL)
     {
-        x_debug_level = level;
+        x_debug_level = (msglvl_t)level;
         return true;
     }
     else if (flags & SDL_CONSTRAIN)
     {
-        x_debug_level = constrain_int(level, 0, ceiling);
+        x_debug_level = (msglvl_t)constrain_int(level, 0, M_DEBUG_LEVEL);
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
     FILE *fp = msgfp;
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
     bool ret = true;
     if (mute_cutoff > 0 && !(flags & M_NOMUTE))
     {
-        const int mute_level = DECODE_MUTE_LEVEL(flags);
-        if (mute_level > 0 && mute_level == mute_category)
+        const msglvl_t mute_level = DECODE_MUTE_LEVEL(flags);
+        if (mute_level == mute_category)
         {
             if (mute_count == mute_cutoff)
             {
@@ -750,7 +748,7 @@
  * Translate msg flags into a string
  */
 const char *
-msg_flags_string(const unsigned int flags, struct gc_arena *gc)
+msg_flags_string(const msglvl_t flags, struct gc_arena *gc)
 {
     struct buffer out = alloc_buf_gc(16, gc);
     if (flags == M_INFO)
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
-#define M_USAGE_SMALL  (1 << 13) /* fatal options error, call usage_small */
-#define M_MSG_VIRT_OUT (1 << 14) /* output message through msg_status_output callback */
-#define M_OPTERR       (1 << 15) /* print "Options error:" prefix */
-#define M_NOLF         (1 << 16) /* don't print new line */
-#define M_NOIPREFIX    (1 << 17) /* don't print instance prefix */
+#define M_NOMUTE       (1u << 11) /* don't do mute processing */
+#define M_NOPREFIX     (1u << 12) /* don't show date/time prefix */
+#define M_USAGE_SMALL  (1u << 13) /* fatal options error, call usage_small */
+#define M_MSG_VIRT_OUT (1u << 14) /* output message through msg_status_output callback */
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
 
 #define ENCODE_MUTE_LEVEL(mute_level) (((mute_level) & MUTE_LEVEL_MASK) << MUTE_LEVEL_SHIFT)
 #define DECODE_MUTE_LEVEL(flags)      (((flags) >> MUTE_LEVEL_SHIFT) & MUTE_LEVEL_MASK)
@@ -135,7 +137,7 @@
  */
 
 /** Check muting filter */
-bool dont_mute(unsigned int flags);
+bool dont_mute(msglvl_t flags);
 
 /* Macro to ensure (and teach static analysis tools) we exit on fatal errors */
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
 
-void x_msg_va(const unsigned int flags, const char *format, va_list arglist);
+void x_msg_va(const msglvl_t flags, const char *format, va_list arglist);
 
 /*
  * Function prototypes
@@ -201,16 +203,16 @@
 
 bool set_mute_cutoff(const int cutoff);
 
-int get_debug_level(void);
+msglvl_t get_debug_level(void);
 
 int get_mute_cutoff(void);
 
-const char *msg_flags_string(const unsigned int flags, struct gc_arena *gc);
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
     return (level & M_DEBUG_LEVEL) <= x_debug_level;
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
index e82b544..f342958 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -373,7 +373,8 @@
 #endif
 
 bool
-send_control_channel_string_dowork(struct tls_session *session, const char *str, int msglevel)
+send_control_channel_string_dowork(struct tls_session *session, const char *str,
+                                   msglvl_t msglevel)
 {
     struct gc_arena gc = gc_new();
     bool stat;
@@ -400,7 +401,7 @@
 }
 
 bool
-send_control_channel_string(struct context *c, const char *str, int msglevel)
+send_control_channel_string(struct context *c, const char *str, msglvl_t msglevel)
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
-bool send_control_channel_string(struct context *c, const char *str, int msglevel);
+bool send_control_channel_string(struct context *c, const char *str, msglvl_t msglevel);
 
 /*
  * Send a string to remote over the TLS control channel.
@@ -303,7 +303,8 @@
  * @param msglevel   - Message level to use for logging
  */
 
-bool send_control_channel_string_dowork(struct tls_session *session, const char *str, int msglevel);
+bool send_control_channel_string_dowork(struct tls_session *session, const char *str,
+                                        msglvl_t msglevel);
 
 
 /**
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 24aebc0..f8a0fee 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4282,7 +4282,7 @@
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
index 4f37bd2..5a41a0f 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1484,7 +1484,7 @@
         }
         else
         {
-            msg(M_CLIENT, "SUCCESS: verb=%d", get_debug_level());
+            msg(M_CLIENT, "SUCCESS: verb=%u", get_debug_level());
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
     int (*kill_by_addr)(void *arg, const in_addr_t addr, const int port, const int proto);
     void (*delete_event)(void *arg, event_t event);
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 1e021e3..66f81a6 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -187,7 +187,7 @@
 }
 
 void
-frame_print(const struct frame *frame, int level, const char *prefix)
+frame_print(const struct frame *frame, msglvl_t msglevel, const char *prefix)
 {
     struct gc_arena gc = gc_new();
     struct buffer out = alloc_buf_gc(256, &gc);
@@ -208,7 +208,7 @@
     buf_printf(&out, " ET:%d", frame->extra_tun);
     buf_printf(&out, " ]");
 
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
+void frame_print(const struct frame *frame, msglvl_t msglevel, const char *prefix);
 
 void set_mtu_discover_type(socket_descriptor_t sd, int mtu_type, sa_family_t proto_af);
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 579eeea..3877f8d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3321,7 +3321,7 @@
     }
     else
     {
-        int msglevel = D_DCO;
+        msglvl_t msglevel = D_DCO;
         if (dco->dco_message_type == OVPN_CMD_DEL_PEER
             && dco->dco_del_peer_reason == OVPN_DEL_PEER_REASON_USERSPACE)
         {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e47d54c..9e8d9c1 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1107,7 +1107,7 @@
 #endif /* ifndef _WIN32 */
 
 static in_addr_t
-get_ip_addr(const char *ip_string, int msglevel, bool *error)
+get_ip_addr(const char *ip_string, msglvl_t msglevel, bool *error)
 {
     unsigned int flags = GETADDR_HOST_ORDER;
     bool succeeded = false;
@@ -1192,7 +1192,7 @@
  * @param   gc          The returned object will be allocated in this gc
  */
 static struct verify_hash_list *
-parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_arena *gc)
+parse_hash_fingerprint(const char *str, int nbytes, msglvl_t msglevel, struct gc_arena *gc)
 {
     int i = 0;
     const char *cp = str;
@@ -1245,7 +1245,8 @@
  * @param   gc          The returned list items will be allocated in this gc
  */
 static struct verify_hash_list *
-parse_hash_fingerprint_multiline(const char *str, int nbytes, int msglevel, struct gc_arena *gc)
+parse_hash_fingerprint_multiline(const char *str, int nbytes, msglvl_t msglevel,
+                                 struct gc_arena *gc)
 {
     struct gc_arena gc_temp = gc_new();
     char *lines = string_alloc(str, &gc_temp);
@@ -1334,7 +1335,7 @@
 #endif /* ifdef _WIN32 */
 
 static void
-dhcp_option_dns6_parse(const char *parm, struct in6_addr *dns6_list, int *len, int msglevel)
+dhcp_option_dns6_parse(const char *parm, struct in6_addr *dns6_list, int *len, msglvl_t msglevel)
 {
     struct in6_addr addr;
     if (*len >= N_DHCP_ADDR)
@@ -1349,7 +1350,7 @@
 }
 static void
 dhcp_option_address_parse(const char *name, const char *parm, in_addr_t *array, int *len,
-                          int msglevel)
+                          msglvl_t msglevel)
 {
     if (*len >= N_DHCP_ADDR)
     {
@@ -1485,7 +1486,8 @@
 #endif /* ! ENABLE_SMALL */
 
 static void
-option_iroute(struct options *o, const char *network_str, const char *netmask_str, int msglevel)
+option_iroute(struct options *o, const char *network_str, const char *netmask_str,
+              msglvl_t msglevel)
 {
     struct iroute *ir;
 
@@ -1511,7 +1513,7 @@
 }
 
 static void
-option_iroute_ipv6(struct options *o, const char *prefix_str, int msglevel)
+option_iroute_ipv6(struct options *o, const char *prefix_str, msglvl_t msglevel)
 {
     struct iroute_ipv6 *ir;
 
@@ -2068,7 +2070,7 @@
 }
 
 static struct local_entry *
-alloc_local_entry(struct connection_entry *ce, const int msglevel, struct gc_arena *gc)
+alloc_local_entry(struct connection_entry *ce, const msglvl_t msglevel, struct gc_arena *gc)
 {
     struct local_list *l = alloc_local_list_if_undef(ce, gc);
     struct local_entry *e;
@@ -2109,7 +2111,7 @@
 }
 
 static struct connection_entry *
-alloc_connection_entry(struct options *options, const int msglevel)
+alloc_connection_entry(struct options *options, const msglvl_t msglevel)
 {
     struct connection_list *l = alloc_connection_list_if_undef(options);
     struct connection_entry *e;
@@ -2145,7 +2147,7 @@
 }
 
 static struct remote_entry *
-alloc_remote_entry(struct options *options, const int msglevel)
+alloc_remote_entry(struct options *options, const msglvl_t msglevel)
 {
     struct remote_list *l = alloc_remote_list_if_undef(options);
     struct remote_entry *e;
@@ -2699,7 +2701,7 @@
 
     if (!options->tls_server && !options->tls_client)
     {
-        int msglevel = M_USAGE;
+        msglvl_t msglevel = M_USAGE;
         if (options->allow_deprecated_insecure_static_crypto)
         {
             msglevel = M_INFO;
@@ -4571,8 +4573,9 @@
 }
 
 static void
-options_warning_safe_scan2(const int msglevel, const int delim, const bool report_inconsistent,
-                           const char *p1, const struct buffer *b2_src, const char *b1_name,
+options_warning_safe_scan2(const msglvl_t msglevel, const int delim,
+                           const bool report_inconsistent, const char *p1,
+                           const struct buffer *b2_src, const char *b1_name,
                            const char *b2_name)
 {
     /* We will stop sending 'key-method', 'keydir', 'proto' and 'tls-auth' in
@@ -4624,9 +4627,9 @@
 }
 
 static void
-options_warning_safe_scan1(const int msglevel, const int delim, const bool report_inconsistent,
-                           const struct buffer *b1_src, const struct buffer *b2_src,
-                           const char *b1_name, const char *b2_name)
+options_warning_safe_scan1(const msglvl_t msglevel, const int delim,
+                           const bool report_inconsistent, const struct buffer *b1_src,
+                           const struct buffer *b2_src, const char *b1_name, const char *b2_name)
 {
     struct gc_arena gc = gc_new();
     struct buffer b = *b1_src;
@@ -4642,7 +4645,7 @@
 }
 
 static void
-options_warning_safe_ml(const int msglevel, char *actual, const char *expected, size_t actual_n)
+options_warning_safe_ml(const msglvl_t msglevel, char *actual, const char *expected, size_t actual_n)
 {
     struct gc_arena gc = gc_new();
 
@@ -4734,7 +4737,7 @@
  */
 
 int
-parse_topology(const char *str, const int msglevel)
+parse_topology(const char *str, const msglvl_t msglevel)
 {
     if (streq(str, "net30"))
     {
@@ -4790,7 +4793,7 @@
 }
 
 bool
-auth_retry_set(const int msglevel, const char *option)
+auth_retry_set(const msglvl_t msglevel, const char *option)
 {
     if (streq(option, "interact"))
     {
@@ -4947,7 +4950,7 @@
 
 #if 0
 static void
-ping_rec_err(int msglevel)
+ping_rec_err(msglvl_t msglevel)
 {
     msg(msglevel, "only one of --ping-exit or --ping-restart options may be specified");
 }
@@ -4971,7 +4974,7 @@
 
 int
 parse_line(const char *line, char *p[], const int n, const char *file, const int line_num,
-           int msglevel, struct gc_arena *gc)
+           msglvl_t msglevel, struct gc_arena *gc)
 {
     const int STATE_INITIAL = 0;
     const int STATE_READING_QUOTED_PARM = 1;
@@ -5276,24 +5279,25 @@
 }
 
 static void add_option(struct options *options, char *p[], bool is_inline, const char *file,
-                       int line, const int level, const int msglevel,
+                       int line, const int level, const msglvl_t msglevel,
                        const unsigned int permission_mask, unsigned int *option_types_found,
                        struct env_set *es);
 
 static void remove_option(struct context *c, struct options *options, char *p[], bool is_inline,
-                          const char *file, int line, const int msglevel,
+                          const char *file, int line, const msglvl_t msglevel,
                           const unsigned int permission_mask, unsigned int *option_types_found,
                           struct env_set *es);
 
 static void update_option(struct context *c, struct options *options, char *p[], bool is_inline,
-                          const char *file, int line, const int level, const int msglevel,
+                          const char *file, int line, const int level, const msglvl_t msglevel,
                           const unsigned int permission_mask, unsigned int *option_types_found,
                           struct env_set *es, unsigned int *update_options_found);
 
 static void
 read_config_file(struct options *options, const char *file, int level, const char *top_file,
-                 const int top_line, const int msglevel, const unsigned int permission_mask,
-                 unsigned int *option_types_found, struct env_set *es)
+                 const int top_line, const msglvl_t msglevel,
+                 const unsigned int permission_mask, unsigned int *option_types_found,
+                 struct env_set *es)
 {
     const int max_recursive_levels = 10;
     FILE *fp;
@@ -5365,7 +5369,7 @@
 
 static void
 read_config_string(const char *prefix, struct options *options, const char *config,
-                   const int msglevel, const unsigned int permission_mask,
+                   const msglvl_t msglevel, const unsigned int permission_mask,
                    unsigned int *option_types_found, struct env_set *es)
 {
     char line[OPTION_LINE_SIZE];
@@ -5393,7 +5397,7 @@
 }
 
 void
-parse_argv(struct options *options, const int argc, char *argv[], const int msglevel,
+parse_argv(struct options *options, const int argc, char *argv[], const msglvl_t msglevel,
            const unsigned int permission_mask, unsigned int *option_types_found, struct env_set *es)
 {
     /* usage message */
@@ -5462,7 +5466,7 @@
     char line[OPTION_PARM_SIZE];
     int line_num = 0;
     const char *file = "[PUSH-OPTIONS]";
-    const int msglevel = D_PUSH_ERRORS | M_OPTERR;
+    const msglvl_t msglevel = D_PUSH_ERRORS | M_OPTERR;
     unsigned int update_options_found = 0;
 
     while (buf_parse(buf, ',', line, sizeof(line)))
@@ -5519,7 +5523,7 @@
 }
 
 void
-options_server_import(struct options *o, const char *filename, int msglevel,
+options_server_import(struct options *o, const char *filename, msglvl_t msglevel,
                       unsigned int permission_mask, unsigned int *option_types_found,
                       struct env_set *es)
 {
@@ -5529,7 +5533,7 @@
 }
 
 void
-options_string_import(struct options *options, const char *config, const int msglevel,
+options_string_import(struct options *options, const char *config, const msglvl_t msglevel,
                       const unsigned int permission_mask, unsigned int *option_types_found,
                       struct env_set *es)
 {
@@ -5548,7 +5552,7 @@
 
 static bool
 verify_permission(const char *name, const char *file, int line, const unsigned int type,
-                  const unsigned int allowed, unsigned int *found, const int msglevel,
+                  const unsigned int allowed, unsigned int *found, const msglvl_t msglevel,
                   struct options *options, bool is_inline)
 {
     if (!(type & allowed))
@@ -5600,7 +5604,7 @@
 #define NM_QUOTE_HINT (1 << 0)
 
 static bool
-no_more_than_n_args(const int msglevel, char *p[], const int max, const unsigned int flags)
+no_more_than_n_args(const msglvl_t msglevel, char *p[], const int max, const unsigned int flags)
 {
     const int len = string_array_len((const char **)p);
 
@@ -5624,8 +5628,8 @@
     }
 }
 
-static inline int
-msglevel_forward_compatible(struct options *options, const int msglevel)
+static inline msglvl_t
+msglevel_forward_compatible(struct options *options, const msglvl_t msglevel)
 {
     return options->forward_compatible ? M_WARN : msglevel;
 }
@@ -5659,10 +5663,11 @@
  */
 static void
 remove_option(struct context *c, struct options *options, char *p[], bool is_inline,
-              const char *file, int line, const int msglevel, const unsigned int permission_mask,
-              unsigned int *option_types_found, struct env_set *es)
+              const char *file, int line, const msglvl_t msglevel,
+              const unsigned int permission_mask, unsigned int *option_types_found,
+              struct env_set *es)
 {
-    int msglevel_fc = msglevel_forward_compatible(options, msglevel);
+    msglvl_t msglevel_fc = msglevel_forward_compatible(options, msglevel);
 
     if (streq(p[0], "ifconfig") && !p[1])
     {
@@ -5797,11 +5802,10 @@
 #endif
     else
     {
-        int i;
-        int msglevel_unknown = msglevel_fc;
+        msglvl_t msglevel_unknown = msglevel_fc;
         /* Check if an option is in --ignore-unknown-option and
          * set warning level to non fatal */
-        for (i = 0; options->ignore_unknown_option && options->ignore_unknown_option[i]; i++)
+        for (int i = 0; options->ignore_unknown_option && options->ignore_unknown_option[i]; i++)
         {
             if (streq(p[0], options->ignore_unknown_option[i]))
             {
@@ -5820,7 +5824,7 @@
 
 
 static bool
-check_route_option(struct options *options, char *p[], const int msglevel, bool pull_mode)
+check_route_option(struct options *options, char *p[], const msglvl_t msglevel, bool pull_mode)
 {
     rol_check_alloc(options);
     if (pull_mode)
@@ -5848,7 +5852,7 @@
 
 
 static bool
-check_route6_option(struct options *options, char *p[], const int msglevel, bool pull_mode)
+check_route6_option(struct options *options, char *p[], const msglvl_t msglevel, bool pull_mode)
 {
     rol6_check_alloc(options);
     if (pull_mode)
@@ -5869,7 +5873,7 @@
 }
 
 static bool
-check_dns_option(struct options *options, char *p[], const int msglevel, bool pull_mode)
+check_dns_option(struct options *options, char *p[], const msglvl_t msglevel, bool pull_mode)
 {
     if (streq(p[1], "search-domains") && p[2])
     {
@@ -5989,7 +5993,7 @@
  */
 static void
 update_option(struct context *c, struct options *options, char *p[], bool is_inline,
-              const char *file, int line, const int level, const int msglevel,
+              const char *file, int line, const int level, const msglvl_t msglevel,
               const unsigned int permission_mask, unsigned int *option_types_found,
               struct env_set *es, unsigned int *update_options_found)
 {
@@ -6174,12 +6178,12 @@
 
 static void
 add_option(struct options *options, char *p[], bool is_inline, const char *file, int line,
-           const int level, const int msglevel, const unsigned int permission_mask,
+           const int level, const msglvl_t msglevel, const unsigned int permission_mask,
            unsigned int *option_types_found, struct env_set *es)
 {
     struct gc_arena gc = gc_new();
     const bool pull_mode = BOOL_CAST(permission_mask & OPT_P_PULL_MODE);
-    int msglevel_fc = msglevel_forward_compatible(options, msglevel);
+    msglvl_t msglevel_fc = msglevel_forward_compatible(options, msglevel);
 
     ASSERT(MAX_PARMS >= 7);
 
@@ -9874,7 +9878,7 @@
     else
     {
         int i;
-        int msglevel_unknown = msglevel_fc;
+        msglvl_t msglevel_unknown = msglevel_fc;
         /* Check if an option is in --ignore-unknown-option and
          * set warning level to non fatal */
         for (i = 0; options->ignore_unknown_option && options->ignore_unknown_option[i]; i++)
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index bb2c052..a737711 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -822,7 +822,7 @@
     struct pull_filter *tail;
 };
 
-void parse_argv(struct options *options, const int argc, char *argv[], const int msglevel,
+void parse_argv(struct options *options, const int argc, char *argv[], const msglvl_t msglevel,
                 const unsigned int permission_mask, unsigned int *option_types_found,
                 struct env_set *es);
 
@@ -888,7 +888,7 @@
 
 void options_detach(struct options *o);
 
-void options_server_import(struct options *o, const char *filename, int msglevel,
+void options_server_import(struct options *o, const char *filename, msglvl_t msglevel,
                            unsigned int permission_mask, unsigned int *option_types_found,
                            struct env_set *es);
 
@@ -897,13 +897,13 @@
 void rol_check_alloc(struct options *options);
 
 int parse_line(const char *line, char *p[], const int n, const char *file, const int line_num,
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
 
-void options_string_import(struct options *options, const char *config, const int msglevel,
+void options_string_import(struct options *options, const char *config, const msglvl_t msglevel,
                            const unsigned int permission_mask, unsigned int *option_types_found,
                            struct env_set *es);
 
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index a351967..125d47c 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -117,7 +117,7 @@
 }
 
 int
-positive_atoi(const char *str, int msglevel)
+positive_atoi(const char *str, msglvl_t msglevel)
 {
     char *endptr;
     long long i = strtoll(str, &endptr, 10);
@@ -132,7 +132,7 @@
 }
 
 bool
-positive_atoll(const char *str, int64_t *value, const char *name, int msglevel)
+positive_atoll(const char *str, int64_t *value, const char *name, msglvl_t msglevel)
 {
     char *endptr;
     long long ll = strtoll(str, &endptr, 10);
@@ -148,7 +148,7 @@
 }
 
 int
-atoi_warn(const char *str, int msglevel)
+atoi_warn(const char *str, msglvl_t msglevel)
 {
     char *endptr;
     long long i = strtoll(str, &endptr, 10);
@@ -168,7 +168,7 @@
 #endif
 
 bool
-atoi_constrained(const char *str, int *value, const char *name, int min, int max, int msglevel)
+atoi_constrained(const char *str, int *value, const char *name, int min, int max, msglvl_t msglevel)
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
  * @return \c true if the integer has been parsed and stored in value, \c false otherwise
  */
-bool positive_atoll(const char *str, int64_t *value, const char *name, int msglevel);
+bool positive_atoll(const char *str, int64_t *value, const char *name, msglvl_t msglevel);
 
 /**
  * Converts a str to an integer if the string can be represented as an
  * integer number. Otherwise print a warning with \p msglevel and return 0
  */
-int atoi_warn(const char *str, int msglevel);
+int atoi_warn(const char *str, msglvl_t msglevel);
 
 /**
  * Converts a str to an integer if the string can be represented as an
@@ -66,7 +66,7 @@
  * @return \c true if the integer has been parsed and stored in value, \c false otherwise
  */
 bool atoi_constrained(const char *str, int *value, const char *name, int min, int max,
-                      int msglevel);
+                      msglvl_t msglevel);
 
 /**
  * Filter an option line by all pull filters.
diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
index 0b33c9c..880eee1 100644
--- a/src/openvpn/packet_id.c
+++ b/src/openvpn/packet_id.c
@@ -53,15 +53,15 @@
 #define SEQ_EXPIRED ((time_t)1)
 
 #ifdef ENABLE_DEBUG
-static void packet_id_debug_print(int msglevel, const struct packet_id_rec *p,
+static void packet_id_debug_print(msglvl_t msglevel, const struct packet_id_rec *p,
                                   const struct packet_id_net *pin, const char *message,
                                   packet_id_print_type value);
 
 #endif /* ENABLE_DEBUG */
 
 static inline void
-packet_id_debug(int msglevel, const struct packet_id_rec *p, const struct packet_id_net *pin,
-                const char *message, uint64_t value)
+packet_id_debug(msglvl_t msglevel, const struct packet_id_rec *p,
+                const struct packet_id_net *pin, const char *message, uint64_t value)
 {
 #ifdef ENABLE_DEBUG
     if (unlikely(check_debug_level(msglevel)))
@@ -578,7 +578,8 @@
 #ifdef ENABLE_DEBUG
 
 static void
-packet_id_debug_print(int msglevel, const struct packet_id_rec *p, const struct packet_id_net *pin,
+packet_id_debug_print(msglvl_t msglevel, const struct packet_id_rec *p,
+                      const struct packet_id_net *pin,
                       const char *message, packet_id_print_type value)
 {
     struct gc_arena gc = gc_new();
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index d9c16d9..16149ca 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -77,10 +77,10 @@
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
@@ -117,7 +117,7 @@
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
 static struct plugin_common *static_plugin_common = NULL; /* GLOBAL */
 
 static void
-plugin_show_string_array(int msglevel, const char *name, const char *array[])
+plugin_show_string_array(msglvl_t msglevel, const char *name, const char *array[])
 {
     int i;
     for (i = 0; array[i]; ++i)
@@ -63,7 +63,7 @@
 }
 
 static void
-plugin_show_args_env(int msglevel, const char *argv[], const char *envp[])
+plugin_show_args_env(msglvl_t msglevel, const char *argv[], const char *envp[])
 {
     if (check_debug_level(msglevel))
     {
@@ -184,7 +184,7 @@
 
 #ifndef ENABLE_SMALL
 void
-plugin_option_list_print(const struct plugin_option_list *list, int msglevel)
+plugin_option_list_print(const struct plugin_option_list *list, msglvl_t msglevel)
 {
     int i;
     struct gc_arena gc = gc_new();
@@ -995,7 +995,7 @@
 
 #ifdef ENABLE_DEBUG
 void
-plugin_return_print(const int msglevel, const char *prefix, const struct plugin_return *pr)
+plugin_return_print(const msglvl_t msglevel, const char *prefix, const struct plugin_return *pr)
 {
     int i;
     msg(msglevel, "PLUGIN_RETURN_PRINT %s", prefix);
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 63999b6..81d3739 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -111,7 +111,7 @@
 bool plugin_option_list_add(struct plugin_option_list *list, char **p, struct gc_arena *gc);
 
 #ifndef ENABLE_SMALL
-void plugin_option_list_print(const struct plugin_option_list *list, int msglevel);
+void plugin_option_list_print(const struct plugin_option_list *list, msglvl_t msglevel);
 
 #endif
 
@@ -136,7 +136,7 @@
 void plugin_return_free(struct plugin_return *pr);
 
 #ifdef ENABLE_DEBUG
-void plugin_return_print(const int msglevel, const char *prefix, const struct plugin_return *pr);
+void plugin_return_print(const msglvl_t msglevel, const char *prefix, const struct plugin_return *pr);
 
 #endif
 
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index fde6cea..28ddd2c 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -114,7 +114,7 @@
  * Verify start/end range
  */
 bool
-ifconfig_pool_verify_range(const int msglevel, const in_addr_t start, const in_addr_t end)
+ifconfig_pool_verify_range(const msglvl_t msglevel, const in_addr_t start, const in_addr_t end)
 {
     struct gc_arena gc = gc_new();
     bool ret = true;
diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
index 6cecef0..36e9fca 100644
--- a/src/openvpn/pool.h
+++ b/src/openvpn/pool.h
@@ -78,7 +78,7 @@
 
 void ifconfig_pool_free(struct ifconfig_pool *pool);
 
-bool ifconfig_pool_verify_range(const int msglevel, const in_addr_t start, const in_addr_t end);
+bool ifconfig_pool_verify_range(const msglvl_t msglevel, const in_addr_t start, const in_addr_t end);
 
 ifconfig_pool_handle ifconfig_pool_acquire(struct ifconfig_pool *pool, in_addr_t *local,
                                            in_addr_t *remote, struct in6_addr *remote_ipv6,
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 34b3378..ab77887 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -183,7 +183,7 @@
             int hlen;
             int totlen;
             const char *msgstr = "PACKET SIZE INFO";
-            unsigned int msglevel = D_PACKET_TRUNC_DEBUG;
+            msglvl_t msglevel = D_PACKET_TRUNC_DEBUG;
 
             if (BLEN(&buf) < (int)sizeof(struct openvpn_iphdr))
             {
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 671b015..e7fc50c 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -373,8 +373,8 @@
  *
  * @return true on success, false on failure.
  */
-static bool push_option_fmt(struct gc_arena *gc, struct push_list *push_list, int msglevel,
-                            const char *fmt, ...)
+static bool push_option_fmt(struct gc_arena *gc, struct push_list *push_list,
+                            msglvl_t msglevel, const char *fmt, ...)
 #ifdef __GNUC__
 #if __USE_MINGW_ANSI_STDIO
     __attribute__((format(gnu_printf, 4, 5)))
@@ -857,7 +857,7 @@
 
 static void
 push_option_ex(struct gc_arena *gc, struct push_list *push_list, const char *opt, bool enable,
-               int msglevel)
+               msglvl_t msglevel)
 {
     if (!string_class(opt, CC_ANY, CC_COMMA))
     {
@@ -885,7 +885,7 @@
 }
 
 void
-push_option(struct options *o, const char *opt, int msglevel)
+push_option(struct options *o, const char *opt, msglvl_t msglevel)
 {
     push_option_ex(&o->gc, &o->push_list, opt, true, msglevel);
 }
@@ -906,7 +906,7 @@
 }
 
 void
-push_options(struct options *o, char **p, int msglevel, struct gc_arena *gc)
+push_options(struct options *o, char **p, msglvl_t msglevel, struct gc_arena *gc)
 {
     const char **argv = make_extended_arg_array(p, false, gc);
     char *opt = print_argv(argv, gc, 0);
@@ -914,8 +914,8 @@
 }
 
 static bool
-push_option_fmt(struct gc_arena *gc, struct push_list *push_list, int msglevel, const char *format,
-                ...)
+push_option_fmt(struct gc_arena *gc, struct push_list *push_list,
+                msglvl_t msglevel, const char *format, ...)
 {
     va_list arglist;
     char tmp[256] = { 0 };
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 8ffd0c2..6b3275e 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -99,9 +99,9 @@
 
 void clone_push_list(struct options *o);
 
-void push_option(struct options *o, const char *opt, int msglevel);
+void push_option(struct options *o, const char *opt, msglvl_t msglevel);
 
-void push_options(struct options *o, char **p, int msglevel, struct gc_arena *gc);
+void push_options(struct options *o, char **p, msglvl_t msglevel, struct gc_arena *gc);
 
 void push_reset(struct options *o);
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d3d2954..156a99e 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1228,28 +1228,28 @@
 }
 
 static void
-print_route_option(const struct route_option *ro, int level)
+print_route_option(const struct route_option *ro, msglvl_t msglevel)
 {
-    msg(level, "  route %s/%s/%s/%s", show_opt(ro->network), show_opt(ro->netmask),
+    msg(msglevel, "  route %s/%s/%s/%s", show_opt(ro->network), show_opt(ro->netmask),
         show_opt(ro->gateway), show_opt(ro->metric));
 }
 
 void
-print_route_options(const struct route_option_list *rol, int level)
+print_route_options(const struct route_option_list *rol, msglvl_t msglevel)
 {
     struct route_option *ro;
     if (rol->flags & RG_ENABLE)
     {
-        msg(level, "  [redirect_default_gateway local=%d]", (rol->flags & RG_LOCAL) != 0);
+        msg(msglevel, "  [redirect_default_gateway local=%d]", (rol->flags & RG_LOCAL) != 0);
     }
     for (ro = rol->routes; ro; ro = ro->next)
     {
-        print_route_option(ro, level);
+        print_route_option(ro, msglevel);
     }
 }
 
 void
-print_default_gateway(const int msglevel, const struct route_gateway_info *rgi,
+print_default_gateway(const msglvl_t msglevel, const struct route_gateway_info *rgi,
                       const struct route_ipv6_gateway_info *rgi6)
 {
     struct gc_arena gc = gc_new();
@@ -1323,23 +1323,23 @@
 #endif /* ifndef ENABLE_SMALL */
 
 static void
-print_route(const struct route_ipv4 *r, int level)
+print_route(const struct route_ipv4 *r, msglvl_t msglevel)
 {
     struct gc_arena gc = gc_new();
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
     for (r = rl->routes; r; r = r->next)
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
+show_routes(msglvl_t msglevel)
 {
     struct gc_arena gc = gc_new();
 
     const MIB_IPFORWARDTABLE *rt = get_windows_routing_table(&gc);
 
-    msg(msglev, "SYSTEM ROUTING TABLE");
+    msg(msglevel, "SYSTEM ROUTING TABLE");
     if (rt)
     {
         for (DWORD i = 0; i < rt->dwNumEntries; ++i)
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
 void get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi, const struct in6_addr *dest,
                               openvpn_net_ctx_t *ctx);
 
-void print_default_gateway(const int msglevel, const struct route_gateway_info *rgi,
+void print_default_gateway(const msglvl_t msglevel, const struct route_gateway_info *rgi,
                            const struct route_ipv6_gateway_info *rgi6);
 
 /*
@@ -371,15 +371,15 @@
 int test_local_addr(const in_addr_t addr, const struct route_gateway_info *rgi);
 
 #ifndef ENABLE_SMALL
-void print_route_options(const struct route_option_list *rol, int level);
+void print_route_options(const struct route_option_list *rol, msglvl_t msglevel);
 
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
     if (pid == 0)
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
-bool openvpn_waitpid_check(pid_t pid, const char *msg_prefix, int msglevel);
+bool openvpn_waitpid_check(pid_t pid, const char *msg_prefix, msglvl_t msglevel);
 
 #endif
 
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index ecea635..42ad823 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -287,7 +287,7 @@
 }
 
 void
-print_signal(const struct signal_info *si, const char *title, int msglevel)
+print_signal(const struct signal_info *si, const char *title, msglvl_t msglevel)
 {
     if (si)
     {
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index 7e5dd9f..b5d81fc 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -66,7 +66,7 @@
 
 void restore_signal_state(void);
 
-void print_signal(const struct signal_info *si, const char *title, int msglevel);
+void print_signal(const struct signal_info *si, const char *title, msglvl_t msglevel);
 
 void print_status(struct context *c, struct status_output *so);
 
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 248c690..69445d9 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -83,7 +83,7 @@
 static int
 get_addr_generic(sa_family_t af, unsigned int flags, const char *hostname, void *network,
                  unsigned int *netbits, int resolve_retry_seconds, struct signal_info *sig_info,
-                 int msglevel)
+                 msglvl_t msglevel)
 {
     char *endp, *sep, *var_host = NULL;
     struct addrinfo *ai = NULL;
@@ -216,7 +216,8 @@
 }
 
 bool
-get_ipv6_addr(const char *hostname, struct in6_addr *network, unsigned int *netbits, int msglevel)
+get_ipv6_addr(const char *hostname, struct in6_addr *network, unsigned int *netbits,
+              msglvl_t msglevel)
 {
     if (get_addr_generic(AF_INET6, GETADDR_RESOLVE, hostname, network, netbits, 0, NULL, msglevel)
         < 0)
@@ -1521,7 +1522,7 @@
 linksock_print_addr(struct link_socket *sock)
 {
     struct gc_arena gc = gc_new();
-    const int msglevel = (sock->mode == LS_MODE_TCP_ACCEPT_FROM) ? D_INIT_MEDIUM : M_INFO;
+    const msglvl_t msglevel = (sock->mode == LS_MODE_TCP_ACCEPT_FROM) ? D_INIT_MEDIUM : M_INFO;
 
     /* print local address */
     if (sock->bind_local)
diff --git a/src/openvpn/socket_util.c b/src/openvpn/socket_util.c
index 9b7312d..fa566e7 100644
--- a/src/openvpn/socket_util.c
+++ b/src/openvpn/socket_util.c
@@ -541,7 +541,7 @@
     struct addrinfo hints;
     int status;
     struct signal_info sigrec = { 0 };
-    int msglevel = (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
+    msglvl_t msglevel = (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;
     struct gc_arena gc = gc_new();
     const char *print_hostname;
     const char *print_servname;
@@ -604,7 +604,7 @@
         int resolve_retries =
             (flags & GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / fail_wait_interval);
         const char *fmt;
-        int level = 0;
+        msglvl_t level = 0;
 
         /* this is not a numeric IP, therefore force resolution using the
          * provided ai_family */
@@ -739,7 +739,7 @@
 done:
     if (sig_info && sig_info->signal_received)
     {
-        int level = 0;
+        msglvl_t level = 0;
         if (flags & GETADDR_FATAL_ON_SIGNAL)
         {
             level = M_FATAL;
diff --git a/src/openvpn/socket_util.h b/src/openvpn/socket_util.h
index 361edff..ada52a4 100644
--- a/src/openvpn/socket_util.h
+++ b/src/openvpn/socket_util.h
@@ -142,7 +142,7 @@
  * Translate an IPv6 addr or hostname from string form to in6_addr
  */
 bool get_ipv6_addr(const char *hostname, struct in6_addr *network, unsigned int *netbits,
-                   int msglevel);
+                   msglvl_t msglevel);
 
 int openvpn_getaddrinfo(unsigned int flags, const char *hostname, const char *servname,
                         int resolve_retry_seconds, struct signal_info *sig_info, int ai_family,
diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h
index a0559c9..2bad3eb 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -193,8 +193,8 @@
  * @param gc            Garbage collection arena for temp data
  *
  */
-void x509_track_add(const struct x509_track **ll_head, const char *name, int msglevel,
-                    struct gc_arena *gc);
+void x509_track_add(const struct x509_track **ll_head, const char *name,
+                    msglvl_t msglevel, struct gc_arena *gc);
 
 /*
  * Save X509 fields to environment, using the naming convention:
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index a2c702d..0915e3e 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -359,7 +359,7 @@
 }
 
 void
-x509_track_add(const struct x509_track **ll_head, const char *name, int msglevel,
+x509_track_add(const struct x509_track **ll_head, const char *name, msglvl_t msglevel,
                struct gc_arena *gc)
 {
     struct x509_track *xt;
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 122101c..12aae62 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -414,7 +414,7 @@
  */
 
 void
-x509_track_add(const struct x509_track **ll_head, const char *name, int msglevel,
+x509_track_add(const struct x509_track **ll_head, const char *name, msglvl_t msglevel,
                struct gc_arena *gc)
 {
     struct x509_track *xt;
diff --git a/src/openvpn/status.c b/src/openvpn/status.c
index fbd2168..1e1e3fb 100644
--- a/src/openvpn/status.c
+++ b/src/openvpn/status.c
@@ -235,14 +235,13 @@
 
         if (so->msglevel >= 0 && !so->errors)
         {
-            msg(so->msglevel, "%s", buf);
+            msg((msglvl_t)so->msglevel, "%s", buf);
         }
 
         if (so->fd >= 0 && !so->errors)
         {
-            int len;
             strcat(buf, "\n");
-            len = strlen(buf);
+            size_t len = strlen(buf);
             if (len > 0)
             {
                 if (write(so->fd, buf, len) != len)
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
index d299e81..8cdff11a 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -105,9 +105,9 @@
 static void netsh_set_dns6_servers(const struct in6_addr *addr_list, const int addr_len,
                                    DWORD adapter_index);
 
-static void netsh_command(const struct argv *a, int n, int msglevel);
+static void netsh_command(const struct argv *a, int n, msglvl_t msglevel);
 
-static void exec_command(const char *prefix, const struct argv *a, int n, int msglevel);
+static void exec_command(const char *prefix, const struct argv *a, int n, msglvl_t msglevel);
 
 static const char *netsh_get_id(const char *dev_node, struct gc_arena *gc);
 
@@ -4035,7 +4035,7 @@
 }
 
 void
-show_tap_win_adapters(int msglev, int warnlev)
+show_tap_win_adapters(msglvl_t msglevel, msglvl_t warnlevel)
 {
     struct gc_arena gc = gc_new();
 
@@ -4052,7 +4052,7 @@
     const struct tap_reg *tap_reg = get_tap_reg(&gc);
     const struct panel_reg *panel_reg = get_panel_reg(&gc);
 
-    msg(msglev, "Available adapters [name, GUID, driver]:");
+    msg(msglevel, "Available adapters [name, GUID, driver]:");
 
     /* loop through each TAP-Windows adapter registry entry */
     for (tr = tap_reg; tr != NULL; tr = tr->next)
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
             warn_panel_null = true;
-            msg(msglev, "[NULL] %s", tr->guid);
+            msg(msglevel, "[NULL] %s", tr->guid);
         }
     }
 
@@ -4098,18 +4098,18 @@
     /* warn on registry inconsistencies */
     if (warn_tap_dup)
     {
-        msg(warnlev, "WARNING: Some TAP-Windows adapters have duplicate GUIDs");
+        msg(warnlevel, "WARNING: Some TAP-Windows adapters have duplicate GUIDs");
     }
 
     if (warn_panel_dup)
     {
-        msg(warnlev,
+        msg(warnlevel,
             "WARNING: Some TAP-Windows adapters have duplicate links from the Network Connections control panel");
     }
 
     if (warn_panel_null)
     {
-        msg(warnlev,
+        msg(warnlevel,
             "WARNING: Some TAP-Windows adapters have no link from the Network Connections control panel");
     }
 
@@ -4839,31 +4839,31 @@
  * Show info for a single adapter
  */
 static void
-show_adapter(int msglev, const IP_ADAPTER_INFO *a, struct gc_arena *gc)
+show_adapter(msglvl_t msglevel, const IP_ADAPTER_INFO *a, struct gc_arena *gc)
 {
-    msg(msglev, "%s", a->Description);
-    msg(msglev, "  Index = %d", (int)a->Index);
-    msg(msglev, "  GUID = %s", a->AdapterName);
-    msg(msglev, "  IP = %s", format_ip_addr_string(&a->IpAddressList, gc));
-    msg(msglev, "  MAC = %s", format_hex_ex(a->Address, a->AddressLength, 0, 1, ":", gc));
-    msg(msglev, "  GATEWAY = %s", format_ip_addr_string(&a->GatewayList, gc));
+    msg(msglevel, "%s", a->Description);
+    msg(msglevel, "  Index = %d", (int)a->Index);
+    msg(msglevel, "  GUID = %s", a->AdapterName);
+    msg(msglevel, "  IP = %s", format_ip_addr_string(&a->IpAddressList, gc));
+    msg(msglevel, "  MAC = %s", format_hex_ex(a->Address, a->AddressLength, 0, 1, ":", gc));
+    msg(msglevel, "  GATEWAY = %s", format_ip_addr_string(&a->GatewayList, gc));
     if (a->DhcpEnabled)
     {
-        msg(msglev, "  DHCP SERV = %s", format_ip_addr_string(&a->DhcpServer, gc));
-        msg(msglev, "  DHCP LEASE OBTAINED = %s", time_string(a->LeaseObtained, 0, false, gc));
-        msg(msglev, "  DHCP LEASE EXPIRES  = %s", time_string(a->LeaseExpires, 0, false, gc));
+        msg(msglevel, "  DHCP SERV = %s", format_ip_addr_string(&a->DhcpServer, gc));
+        msg(msglevel, "  DHCP LEASE OBTAINED = %s", time_string(a->LeaseObtained, 0, false, gc));
+        msg(msglevel, "  DHCP LEASE EXPIRES  = %s", time_string(a->LeaseExpires, 0, false, gc));
     }
     if (a->HaveWins)
     {
-        msg(msglev, "  PRI WINS = %s", format_ip_addr_string(&a->PrimaryWinsServer, gc));
-        msg(msglev, "  SEC WINS = %s", format_ip_addr_string(&a->SecondaryWinsServer, gc));
+        msg(msglevel, "  PRI WINS = %s", format_ip_addr_string(&a->PrimaryWinsServer, gc));
+        msg(msglevel, "  SEC WINS = %s", format_ip_addr_string(&a->SecondaryWinsServer, gc));
     }
 
     {
         const IP_PER_ADAPTER_INFO *pai = get_per_adapter_info(a->Index, gc);
         if (pai)
         {
-            msg(msglev, "  DNS SERV = %s", format_ip_addr_string(&pai->DnsServerList, gc));
+            msg(msglevel, "  DNS SERV = %s", format_ip_addr_string(&pai->DnsServerList, gc));
         }
     }
 }
@@ -4872,12 +4872,12 @@
  * Show current adapter list
  */
 void
-show_adapters(int msglev)
+show_adapters(msglvl_t msglevel)
 {
     struct gc_arena gc = gc_new();
     const IP_ADAPTER_INFO *ai = get_adapter_info_list(&gc);
 
-    msg(msglev, "SYSTEM ADAPTER LIST");
+    msg(msglevel, "SYSTEM ADAPTER LIST");
     if (ai)
     {
         const IP_ADAPTER_INFO *a;
@@ -4885,7 +4885,7 @@
         /* find index in the linked list */
         for (a = ai; a != NULL; a = a->Next)
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
+exec_command(const char *prefix, const struct argv *a, int n, msglvl_t msglevel)
 {
     int i;
     for (i = 0; i < n; ++i)
@@ -5103,7 +5103,7 @@
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
 DWORD adapter_index_of_ip(const IP_ADAPTER_INFO *list, const in_addr_t ip, int *count,
                           in_addr_t *netmask);
 
-void show_tap_win_adapters(int msglev, int warnlev);
+void show_tap_win_adapters(msglvl_t msglevel, msglvl_t warnlevel);
 
-void show_adapters(int msglev);
+void show_adapters(msglvl_t msglevel);
 
 void tap_allow_nonadmin_access(const char *dev_node);
 
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c
index 603520b..69d2d1d 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -38,8 +38,8 @@
 #include "error.h"
 #include "mock_msg.h"
 
-unsigned int x_debug_level = 0; /* Default to (almost) no debugging output */
-unsigned int print_x_debug_level = 0;
+msglvl_t x_debug_level = 0; /* Default to (almost) no debugging output */
+msglvl_t print_x_debug_level = 0;
 
 bool fatal_error_triggered = false;
 
@@ -47,31 +47,31 @@
 
 
 void
-mock_set_debug_level(int level)
+mock_set_debug_level(msglvl_t level)
 {
     x_debug_level = level;
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
     print_x_debug_level = level;
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
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn/mock_msg.h
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
diff --git a/tests/unit_tests/openvpn/mock_ssl_dependencies.c b/tests/unit_tests/openvpn/mock_ssl_dependencies.c
index 7333c47..f2fa93a 100644
--- a/tests/unit_tests/openvpn/mock_ssl_dependencies.c
+++ b/tests/unit_tests/openvpn/mock_ssl_dependencies.c
@@ -38,7 +38,7 @@
 
 int
 parse_line(const char *line, char **p, const int n, const char *file, const int line_num,
-           int msglevel, struct gc_arena *gc)
+           msglvl_t msglevel, struct gc_arena *gc)
 {
     /* Dummy function to get the linker happy, should never be called */
     assert_true(false);
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index a65857b..a04fabc 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -23,7 +23,7 @@
 
 int
 __wrap_parse_line(const char *line, char **p, const int n, const char *file, const int line_num,
-                  int msglevel, struct gc_arena *gc)
+                  msglvl_t msglevel, struct gc_arena *gc)
 {
     p[0] = PATH1 PATH2;
     p[1] = PARAM1;
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 3433b73..5260a31 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -348,8 +348,8 @@
     assert_false(valid_integer("-2147483653", false));
 
 
-    int msglevel = D_LOW;
-    int saved_log_level = mock_get_debug_level();
+    msglvl_t msglevel = D_LOW;
+    msglvl_t saved_log_level = mock_get_debug_level();
     mock_set_debug_level(D_LOW);
 
     /* check happy path */
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index 9ba6cfc..d568865 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -59,7 +59,7 @@
 /* stubs for some unused functions instead of pulling in too many dependencies */
 int
 parse_line(const char *line, char **p, const int n, const char *file, const int line_num,
-           int msglevel, struct gc_arena *gc)
+           msglvl_t msglevel, struct gc_arena *gc)
 {
     assert_true(0);
     return 0;
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 5122766..b6c612b 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -45,7 +45,7 @@
 
 int
 parse_line(const char *line, char **p, const int n, const char *file, const int line_num,
-           int msglevel, struct gc_arena *gc)
+           msglvl_t msglevel, struct gc_arena *gc)
 {
     /* Dummy function to get the linker happy, should never be called */
     assert_true(false);
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c
index 87329b1..8a5beeb 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -111,7 +111,7 @@
 
 #ifndef ENABLE_MANAGEMENT
 bool
-send_control_channel_string(struct context *c, const char *str, int msglevel)
+send_control_channel_string(struct context *c, const char *str, msglvl_t msglevel)
 {
     return true;
 }
@@ -120,7 +120,7 @@
 int i;
 
 bool
-send_control_channel_string(struct context *c, const char *str, int msglevel)
+send_control_channel_string(struct context *c, const char *str, msglvl_t msglevel)
 {
     if (res && res[i] && strcmp(res[i], str))
     {
diff --git a/tests/unit_tests/openvpn/test_socket.c b/tests/unit_tests/openvpn/test_socket.c
index 2da2529..7f740ac 100644
--- a/tests/unit_tests/openvpn/test_socket.c
+++ b/tests/unit_tests/openvpn/test_socket.c
@@ -59,7 +59,7 @@
 
 int
 parse_line(const char *line, char **p, const int n, const char *file, const int line_num,
-           int msglevel, struct gc_arena *gc)
+           msglvl_t msglevel, struct gc_arena *gc)
 {
     assert_true(0);
     return 0;
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 532bfcd..44d51fe 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -98,7 +98,7 @@
 
 int
 __wrap_parse_line(const char *line, char **p, const int n, const char *file, const int line_num,
-                  int msglevel, struct gc_arena *gc)
+                  msglvl_t msglevel, struct gc_arena *gc)
 {
     p[0] = PATH1 PATH2;
     p[1] = PARAM1;
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
index 460b37f..32ec59f 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -73,7 +73,7 @@
 /* stubs for some unused functions instead of pulling in too many dependencies */
 int
 parse_line(const char *line, char **p, const int n, const char *file, const int line_num,
-           int msglevel, struct gc_arena *gc)
+           msglvl_t msglevel, struct gc_arena *gc)
 {
     assert_true(0);
     return 0;

