From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 15 Sep 2025 14:14:59 +0000
References: <gerrit.1757945695000.I4b0078d099e975d223825194ad104945b1247554@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <71eecd7e21c55461cf7fb07e89e4542e8746ed7d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="weuBPlnz8+M="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change msglevel
 flags to int
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

--weuBPlnz8+M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1189?usp=3Demail

to review the following change.


Change subject: Change msglevel flags to int
......................................................................

Change msglevel flags to int

The API said they are unsigned, but most callers
actually used int. So this produced a LOT of
warnings when enabling -Wsign-conversion.

Since changing the API is actually a smaller change
than changing all the callers, we do that.

Change-Id: I4b0078d099e975d223825194ad104945b1247554
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_mbedtls.h
M src/openvpn/crypto_openssl.c
M src/openvpn/crypto_openssl.h
M src/openvpn/error.c
M src/openvpn/error.h
M src/openvpn/manage.c
M src/openvpn/manage.h
M src/openvpn/options.c
M src/openvpn/options.h
M src/openvpn/pkcs11.c
M src/openvpn/platform.c
M src/openvpn/plugin.c
M src/openvpn/proto.c
M src/openvpn/status.h
M src/openvpnmsica/dllmain.c
M src/tapctl/error.c
M src/tapctl/error.h
M src/tapctl/main.c
M tests/unit_tests/openvpn/mock_msg.c
M tests/unit_tests/openvpn/test_cryptoapi.c
M tests/unit_tests/openvpn/test_pkcs11.c
22 files changed, 71 insertions(+), 72 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1189/1

diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 0c15812..3c2b66f 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -105,7 +105,7 @@
 }

 bool
-mbed_log_err(unsigned int flags, int errval, const char *prefix)
+mbed_log_err(int flags, int errval, const char *prefix)
 {
     if (0 !=3D errval)
     {
@@ -123,7 +123,7 @@
 }

 bool
-mbed_log_func_line(unsigned int flags, int errval, const char *func, int l=
ine)
+mbed_log_func_line(int flags, int errval, const char *func, int line)
 {
     char prefix[256];

diff --git a/src/openvpn/crypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h
index 80f1d16..c9d4fe6 100644
--- a/src/openvpn/crypto_mbedtls.h
+++ b/src/openvpn/crypto_mbedtls.h
@@ -106,7 +106,7 @@
  *
  * @returns true if no errors are detected, false otherwise.
  */
-bool mbed_log_err(unsigned int flags, int errval, const char *prefix);
+bool mbed_log_err(int flags, int errval, const char *prefix);

 /**
  * Log the supplied mbed TLS error, prefixed by function name and line num=
ber.
@@ -118,11 +118,11 @@
  *
  * @returns true if no errors are detected, false otherwise.
  */
-bool mbed_log_func_line(unsigned int flags, int errval, const char *func, =
int line);
+bool mbed_log_func_line(int flags, int errval, const char *func, int line);

 /** Wraps mbed_log_func_line() to prevent function calls for non-errors */
 static inline bool
-mbed_log_func_line_lite(unsigned int flags, int errval, const char *func, =
int line)
+mbed_log_func_line_lite(int flags, int errval, const char *func, int line)
 {
     if (errval)
     {
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 19ca88c..bacc89f 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -227,7 +227,7 @@
 }

 void
-crypto_print_openssl_errors(const unsigned int flags)
+crypto_print_openssl_errors(const int flags)
 {
     unsigned long err =3D 0;
     int line, errflags;
diff --git a/src/openvpn/crypto_openssl.h b/src/openvpn/crypto_openssl.h
index 6218b39..21dae4f 100644
--- a/src/openvpn/crypto_openssl.h
+++ b/src/openvpn/crypto_openssl.h
@@ -103,7 +103,7 @@
  *
  * @param flags         Flags to indicate error type and priority.
  */
-void crypto_print_openssl_errors(const unsigned int flags);
+void crypto_print_openssl_errors(const int flags);

 /**
  * Retrieve any OpenSSL errors, then print the supplied error message.
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 1b98235..8043afe 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -48,7 +48,7 @@
 #endif

 /* Globals */
-unsigned int x_debug_level; /* GLOBAL */
+int x_debug_level; /* GLOBAL */

 /* Mute state */
 static int mute_cutoff;   /* GLOBAL */
@@ -101,7 +101,7 @@
 }

 bool
-set_debug_level(const int level, const unsigned int flags)
+set_debug_level(const int level, const int flags)
 {
     const int ceiling =3D 15;

@@ -190,7 +190,7 @@
  * Return a file to print messages to before syslog is opened.
  */
 FILE *
-msg_fp(const unsigned int flags)
+msg_fp(const int flags)
 {
     FILE *fp =3D msgfp;
     if (!fp)
@@ -214,7 +214,7 @@
 int x_msg_line_num; /* GLOBAL */

 void
-x_msg(const unsigned int flags, const char *format, ...)
+x_msg(const int flags, const char *format, ...)
 {
     va_list arglist;
     va_start(arglist, format);
@@ -235,7 +235,7 @@
 }

 void
-x_msg_va(const unsigned int flags, const char *format, va_list arglist)
+x_msg_va(const int flags, const char *format, va_list arglist)
 {
     struct gc_arena gc;
 #if SYSLOG_CAPABILITY
@@ -385,7 +385,7 @@
  * Apply muting filter.
  */
 bool
-dont_mute(unsigned int flags)
+dont_mute(int flags)
 {
     bool ret =3D true;
     if (mute_cutoff > 0 && !(flags & M_NOMUTE))
@@ -599,9 +599,9 @@
  * of I/O operations.
  */

-unsigned int x_cs_info_level;    /* GLOBAL */
-unsigned int x_cs_verbose_level; /* GLOBAL */
-unsigned int x_cs_err_delay_ms;  /* GLOBAL */
+int x_cs_info_level;            /* GLOBAL */
+int x_cs_verbose_level;         /* GLOBAL */
+unsigned int x_cs_err_delay_ms; /* GLOBAL */

 void
 reset_check_status(void)
@@ -611,7 +611,7 @@
 }

 void
-set_check_status(unsigned int info_level, unsigned int verbose_level)
+set_check_status(int info_level, int verbose_level)
 {
     x_cs_info_level =3D info_level;
     x_cs_verbose_level =3D verbose_level;
@@ -750,7 +750,7 @@
  * Translate msg flags into a string
  */
 const char *
-msg_flags_string(const unsigned int flags, struct gc_arena *gc)
+msg_flags_string(const int flags, struct gc_arena *gc)
 {
     struct buffer out =3D alloc_buf_gc(16, gc);
     if (flags =3D=3D M_INFO)
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 8388f82..babb42f 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -78,7 +78,7 @@
  * These globals should not be accessed directly,
  * but rather through macros or inline functions defined below.
  */
-extern unsigned int x_debug_level;
+extern int x_debug_level;
 extern int x_msg_line_num;

 /* msg() flags */
@@ -135,7 +135,7 @@
  */

 /** Check muting filter */
-bool dont_mute(unsigned int flags);
+bool dont_mute(int flags);

 /* Macro to ensure (and teach static analysis tools) we exit on fatal erro=
rs */
 #define EXIT_FATAL(flags)      \
@@ -170,7 +170,7 @@
 #define dmsg(flags, ...)
 #endif

-void x_msg(const unsigned int flags, const char *format, ...)
+void x_msg(const int flags, const char *format, ...)
 #ifdef __GNUC__
 #if __USE_MINGW_ANSI_STDIO
     __attribute__((format(gnu_printf, 2, 3)))
@@ -180,7 +180,7 @@
 #endif
     ; /* should be called via msg above */

-void x_msg_va(const unsigned int flags, const char *format, va_list arglis=
t);
+void x_msg_va(const int flags, const char *format, va_list arglist);

 /*
  * Function prototypes
@@ -197,7 +197,7 @@


 #define SDL_CONSTRAIN (1 << 0)
-bool set_debug_level(const int level, const unsigned int flags);
+bool set_debug_level(const int level, const int flags);

 bool set_mute_cutoff(const int cutoff);

@@ -205,12 +205,12 @@

 int get_mute_cutoff(void);

-const char *msg_flags_string(const unsigned int flags, struct gc_arena *gc=
);
+const char *msg_flags_string(const int flags, struct gc_arena *gc);

 /*
  * File to print messages to before syslog is opened.
  */
-FILE *msg_fp(const unsigned int flags);
+FILE *msg_fp(const int flags);

 /* Fatal logic errors */
 #ifndef ENABLE_SMALL
@@ -254,14 +254,14 @@
 /* Inline functions */

 static inline bool
-check_debug_level(unsigned int level)
+check_debug_level(int level)
 {
     return (level & M_DEBUG_LEVEL) <=3D x_debug_level;
 }

 /** Return true if flags represent an enabled, not muted log level */
 static inline bool
-msg_test(unsigned int flags)
+msg_test(int flags)
 {
     return check_debug_level(flags) && dont_mute(flags);
 }
@@ -297,13 +297,13 @@
 struct link_socket;
 struct tuntap;

-extern unsigned int x_cs_info_level;
-extern unsigned int x_cs_verbose_level;
+extern int x_cs_info_level;
+extern int x_cs_verbose_level;
 extern unsigned int x_cs_err_delay_ms;

 void reset_check_status(void);

-void set_check_status(unsigned int info_level, unsigned int verbose_level);
+void set_check_status(int info_level, int verbose_level);

 void x_check_status(int status, const char *description, struct link_socke=
t *sock,
                     struct tuntap *tt);
@@ -400,8 +400,8 @@
 }

 /** Convert fatal errors to nonfatal, don't touch other errors */
-static inline unsigned int
-nonfatal(const unsigned int err)
+static inline int
+nonfatal(const int err)
 {
     return err & M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err;
 }
@@ -409,21 +409,20 @@
 static inline int
 openvpn_errno_maybe_crt(bool *crt_error)
 {
-    int err =3D 0;
     *crt_error =3D false;
 #ifdef _WIN32
-    err =3D GetLastError();
+    int err =3D (int)GetLastError();
     if (err =3D=3D ERROR_SUCCESS)
     {
         /* error is likely C runtime */
         *crt_error =3D true;
         err =3D errno;
     }
+    return err;
 #else /* ifdef _WIN32 */
     *crt_error =3D true;
-    err =3D errno;
+    return errno;
 #endif
-    return err;
 }

 #include "errlevel.h"
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 4f37bd2..87981d2 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -352,7 +352,7 @@
 }

 static void
-virtual_output_callback_func(void *arg, const unsigned int flags, const ch=
ar *str)
+virtual_output_callback_func(void *arg, const int flags, const char *str)
 {
     struct management *man =3D (struct management *)arg;
     static int recursive_level =3D 0; /* GLOBAL */
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 7c189ba..7196210 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -98,7 +98,7 @@

 union log_entry_union
 {
-    unsigned int msg_flags;
+    int msg_flags;
     int state;
     int intval;
 };
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e47d54c..22b36a3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4869,7 +4869,7 @@

 #ifdef _WIN32
 void
-show_windows_version(const unsigned int flags)
+show_windows_version(const int flags)
 {
     struct gc_arena gc =3D gc_new();
     msg(flags, "Windows version: %s", win32_version_string(&gc));
@@ -4878,7 +4878,7 @@
 #endif

 void
-show_dco_version(const unsigned int flags)
+show_dco_version(const int flags)
 {
 #ifdef ENABLE_DCO
     struct gc_arena gc =3D gc_new();
@@ -4888,7 +4888,7 @@
 }

 void
-show_library_versions(const unsigned int flags)
+show_library_versions(const int flags)
 {
 #ifdef ENABLE_LZO
 #define LZO_LIB_VER_STR ", LZO ", lzo_version_string()
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index bb2c052..b8efdf8 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -830,14 +830,14 @@

 void usage_small(void);

-void show_library_versions(const unsigned int flags);
+void show_library_versions(const int flags);

 #ifdef _WIN32
-void show_windows_version(const unsigned int flags);
+void show_windows_version(const int flags);

 #endif

-void show_dco_version(const unsigned int flags);
+void show_dco_version(const int flags);

 void init_options(struct options *o, const bool init_gc);

diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index d9c16d9..ba81c54 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -77,10 +77,10 @@
 #endif
 };

-static unsigned
-_pkcs11_msg_pkcs112openvpn(const unsigned flags)
+static int
+_pkcs11_msg_pkcs112openvpn(const unsigned int flags)
 {
-    unsigned openvpn_flags;
+    int openvpn_flags;

     switch (flags)
     {
@@ -117,7 +117,7 @@
 }

 static unsigned
-_pkcs11_msg_openvpn2pkcs11(const unsigned flags)
+_pkcs11_msg_openvpn2pkcs11(const int flags)
 {
     unsigned pkcs11_flags;

diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 880d14e..78c56d3 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -223,7 +223,7 @@
                         const struct platform_state_group *group_state, st=
ruct context *c)
 {
     int keep_caps =3D need_keep_caps(c);
-    unsigned int err_flags =3D (keep_caps > 0) ? M_FATAL : M_NONFATAL;
+    int err_flags =3D (keep_caps > 0) ? M_FATAL : M_NONFATAL;
 #ifdef HAVE_LIBCAPNG
     int new_gid =3D -1, new_uid =3D -1;
     int res;
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index ea76a08..b14ce5c 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -371,7 +371,7 @@
 static void
 plugin_vlog(openvpn_plugin_log_flags_t flags, const char *name, const char=
 *format, va_list arglist)
 {
-    unsigned int msg_flags =3D 0;
+    int msg_flags =3D 0;

     if (!format)
     {
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 34b3378..b0373df 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -183,7 +183,7 @@
             int hlen;
             int totlen;
             const char *msgstr =3D "PACKET SIZE INFO";
-            unsigned int msglevel =3D D_PACKET_TRUNC_DEBUG;
+            int msglevel =3D D_PACKET_TRUNC_DEBUG;

             if (BLEN(&buf) < (int)sizeof(struct openvpn_iphdr))
             {
diff --git a/src/openvpn/status.h b/src/openvpn/status.h
index 0c7a869..c318683 100644
--- a/src/openvpn/status.h
+++ b/src/openvpn/status.h
@@ -32,11 +32,11 @@
 {
     void *arg;
     unsigned int flags_default;
-    void (*func)(void *arg, const unsigned int flags, const char *str);
+    void (*func)(void *arg, const int flags, const char *str);
 };

 static inline void
-virtual_output_print(const struct virtual_output *vo, const unsigned int f=
lags, const char *str)
+virtual_output_print(const struct virtual_output *vo, const int flags, con=
st char *str)
 {
     (*vo->func)(vo->arg, flags, str);
 }
diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica/dllmain.c
index e7d4a4b..8b1b7e9 100644
--- a/src/openvpnmsica/dllmain.c
+++ b/src/openvpnmsica/dllmain.c
@@ -91,7 +91,7 @@


 bool
-dont_mute(unsigned int flags)
+dont_mute(int flags)
 {
     UNREFERENCED_PARAMETER(flags);

@@ -100,7 +100,7 @@


 void
-x_msg_va(const unsigned int flags, const char *format, va_list arglist)
+x_msg_va(const int flags, const char *format, va_list arglist)
 {
     /* Secure last error before it is overridden. */
     DWORD dwResult =3D (flags & M_ERRNO) !=3D 0 ? GetLastError() : ERROR_S=
UCCESS;
diff --git a/src/tapctl/error.c b/src/tapctl/error.c
index 9f5094e..27a475a 100644
--- a/src/tapctl/error.c
+++ b/src/tapctl/error.c
@@ -22,11 +22,11 @@


 /* Globals */
-unsigned int x_debug_level; /* GLOBAL */
+int x_debug_level; /* GLOBAL */


 void
-x_msg(const unsigned int flags, const char *format, ...)
+x_msg(const int flags, const char *format, ...)
 {
     va_list arglist;
     va_start(arglist, format);
diff --git a/src/tapctl/error.h b/src/tapctl/error.h
index fb24a61..ee9909a 100644
--- a/src/tapctl/error.h
+++ b/src/tapctl/error.h
@@ -29,7 +29,7 @@
  * These globals should not be accessed directly,
  * but rather through macros or inline functions defined below.
  */
-extern unsigned int x_debug_level;
+extern int x_debug_level;
 extern int x_msg_line_num;

 /* msg() flags */
@@ -58,7 +58,7 @@


 /** Check muting filter */
-bool dont_mute(unsigned int flags);
+bool dont_mute(int flags);

 /* Macro to ensure (and teach static analysis tools) we exit on fatal erro=
rs */
 #ifdef _MSC_VER
@@ -97,21 +97,21 @@
 #define dmsg(flags, ...)
 #endif

-void x_msg(const unsigned int flags, const char *format, ...); /* should b=
e called via msg above */
+void x_msg(const int flags, const char *format, ...); /* should be called =
via msg above */

-void x_msg_va(const unsigned int flags, const char *format, va_list arglis=
t);
+void x_msg_va(const int flags, const char *format, va_list arglist);
=20
 /* Inline functions */

 static inline bool
-check_debug_level(unsigned int level)
+check_debug_level(int level)
 {
     return (level & M_DEBUG_LEVEL) <=3D x_debug_level;
 }

 /** Return true if flags represent and enabled, not muted log level */
 static inline bool
-msg_test(unsigned int flags)
+msg_test(int flags)
 {
     return check_debug_level(flags) && dont_mute(flags);
 }
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 031e262..52cc8e22 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -479,7 +479,7 @@


 bool
-dont_mute(unsigned int flags)
+dont_mute(int flags)
 {
     UNREFERENCED_PARAMETER(flags);

@@ -488,7 +488,7 @@
=20

 void
-x_msg_va(const unsigned int flags, const char *format, va_list arglist)
+x_msg_va(const int flags, const char *format, va_list arglist)
 {
     /* Output message string. Note: Message strings don't contain line ter=
minators. */
     vfprintf(stderr, format, arglist);
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn=
/mock_msg.c
index 603520b..a2d9c72 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -38,8 +38,8 @@
 #include "error.h"
 #include "mock_msg.h"

-unsigned int x_debug_level =3D 0; /* Default to (almost) no debugging outp=
ut */
-unsigned int print_x_debug_level =3D 0;
+int x_debug_level =3D 0; /* Default to (almost) no debugging output */
+int print_x_debug_level =3D 0;

 bool fatal_error_triggered =3D false;

@@ -71,7 +71,7 @@
 }

 void
-x_msg_va(const unsigned int flags, const char *format, va_list arglist)
+x_msg_va(const int flags, const char *format, va_list arglist)
 {
     if (flags & M_FATAL)
     {
@@ -89,7 +89,7 @@
 }

 void
-x_msg(const unsigned int flags, const char *format, ...)
+x_msg(const int flags, const char *format, ...)
 {
     va_list arglist;
     va_start(arglist, format);
@@ -128,7 +128,7 @@
 }

 bool
-dont_mute(unsigned int flags)
+dont_mute(int flags)
 {
     return true;
 }
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/o=
penvpn/test_cryptoapi.c
index 6e83465..cff9547 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -59,7 +59,7 @@

 /* replacement for crypto_print_openssl_errors() */
 void
-crypto_print_openssl_errors(const unsigned int flags)
+crypto_print_openssl_errors(const int flags)
 {
     unsigned long e;
     while ((e =3D ERR_get_error()))
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/open=
vpn/test_pkcs11.c
index 9ba6cfc..961d78b 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -47,7 +47,7 @@

 /* replacement for crypto_print_openssl_errors() */
 void
-crypto_print_openssl_errors(const unsigned int flags)
+crypto_print_openssl_errors(const int flags)
 {
     unsigned long e;
     while ((e =3D ERR_get_error()))

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1189?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4b0078d099e975d223825194ad104945b1247554
Gerrit-Change-Number: 1189
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--weuBPlnz8+M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1189?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Change msglevel flags to int<br><br>The API said they are un=
signed, but most callers<br>actually used int. So this produced a LOT of<br=
>warnings when enabling -Wsign-conversion.<br><br>Since changing the API is=
 actually a smaller change<br>than changing all the callers, we do that.<br=
><br>Change-Id: I4b0078d099e975d223825194ad104945b1247554<br>Signed-off-by:=
 Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/crypto_=
mbedtls.c<br>M src/openvpn/crypto_mbedtls.h<br>M src/openvpn/crypto_openssl=
.c<br>M src/openvpn/crypto_openssl.h<br>M src/openvpn/error.c<br>M src/open=
vpn/error.h<br>M src/openvpn/manage.c<br>M src/openvpn/manage.h<br>M src/op=
envpn/options.c<br>M src/openvpn/options.h<br>M src/openvpn/pkcs11.c<br>M s=
rc/openvpn/platform.c<br>M src/openvpn/plugin.c<br>M src/openvpn/proto.c<br=
>M src/openvpn/status.h<br>M src/openvpnmsica/dllmain.c<br>M src/tapctl/err=
or.c<br>M src/tapctl/error.h<br>M src/tapctl/main.c<br>M tests/unit_tests/o=
penvpn/mock_msg.c<br>M tests/unit_tests/openvpn/test_cryptoapi.c<br>M tests=
/unit_tests/openvpn/test_pkcs11.c<br>22 files changed, 71 insertions(+), 72=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/89/1189/1</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_mbedtls.c b/src=
/openvpn/crypto_mbedtls.c</span><br><span>index 0c15812..3c2b66f 100644</sp=
an><br><span>--- a/src/openvpn/crypto_mbedtls.c</span><br><span>+++ b/src/o=
penvpn/crypto_mbedtls.c</span><br><span>@@ -105,7 +105,7 @@</span><br><span=
> }</span><br><span> </span><br><span> bool</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-mbed_log_err(unsigned int flags, int errval, const ch=
ar *prefix)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbed_log=
_err(int flags, int errval, const char *prefix)</span><br><span> {</span><b=
r><span>     if (0 !=3D errval)</span><br><span>     {</span><br><span>@@ -=
123,7 +123,7 @@</span><br><span> }</span><br><span> </span><br><span> bool<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbed_log_func_line(uns=
igned int flags, int errval, const char *func, int line)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+mbed_log_func_line(int flags, int errv=
al, const char *func, int line)</span><br><span> {</span><br><span>     cha=
r prefix[256];</span><br><span> </span><br><span>diff --git a/src/openvpn/c=
rypto_mbedtls.h b/src/openvpn/crypto_mbedtls.h</span><br><span>index 80f1d1=
6..c9d4fe6 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls.h</span>=
<br><span>+++ b/src/openvpn/crypto_mbedtls.h</span><br><span>@@ -106,7 +106=
,7 @@</span><br><span>  *</span><br><span>  * @returns true if no errors ar=
e detected, false otherwise.</span><br><span>  */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-bool mbed_log_err(unsigned int flags, int errva=
l, const char *prefix);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool mbed_log_err(int flags, int errval, const char *prefix);</span><br=
><span> </span><br><span> /**</span><br><span>  * Log the supplied mbed TLS=
 error, prefixed by function name and line number.</span><br><span>@@ -118,=
11 +118,11 @@</span><br><span>  *</span><br><span>  * @returns true if no e=
rrors are detected, false otherwise.</span><br><span>  */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-bool mbed_log_func_line(unsigned int fl=
ags, int errval, const char *func, int line);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+bool mbed_log_func_line(int flags, int errval, co=
nst char *func, int line);</span><br><span> </span><br><span> /** Wraps mbe=
d_log_func_line() to prevent function calls for non-errors */</span><br><sp=
an> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-mbed_log_func_line_lite(unsigned int flags, int errval, const char *func, =
int line)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbed_log_f=
unc_line_lite(int flags, int errval, const char *func, int line)</span><br>=
<span> {</span><br><span>     if (errval)</span><br><span>     {</span><br>=
<span>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openss=
l.c</span><br><span>index 19ca88c..bacc89f 100644</span><br><span>--- a/src=
/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto_openssl.=
c</span><br><span>@@ -227,7 +227,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
crypto_print_openssl_errors(const unsigned int flags)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+crypto_print_openssl_errors(const int fla=
gs)</span><br><span> {</span><br><span>     unsigned long err =3D 0;</span>=
<br><span>     int line, errflags;</span><br><span>diff --git a/src/openvpn=
/crypto_openssl.h b/src/openvpn/crypto_openssl.h</span><br><span>index 6218=
b39..21dae4f 100644</span><br><span>--- a/src/openvpn/crypto_openssl.h</spa=
n><br><span>+++ b/src/openvpn/crypto_openssl.h</span><br><span>@@ -103,7 +1=
03,7 @@</span><br><span>  *</span><br><span>  * @param flags         Flags =
to indicate error type and priority.</span><br><span>  */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void crypto_print_openssl_errors(const =
unsigned int flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void crypto_print_openssl_errors(const int flags);</span><br><span> </span=
><br><span> /**</span><br><span>  * Retrieve any OpenSSL errors, then print=
 the supplied error message.</span><br><span>diff --git a/src/openvpn/error=
.c b/src/openvpn/error.c</span><br><span>index 1b98235..8043afe 100644</spa=
n><br><span>--- a/src/openvpn/error.c</span><br><span>+++ b/src/openvpn/err=
or.c</span><br><span>@@ -48,7 +48,7 @@</span><br><span> #endif</span><br><s=
pan> </span><br><span> /* Globals */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-unsigned int x_debug_level; /* GLOBAL */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+int x_debug_level; /* GLOBAL */</span><=
br><span> </span><br><span> /* Mute state */</span><br><span> static int mu=
te_cutoff;   /* GLOBAL */</span><br><span>@@ -101,7 +101,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> bool</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-set_debug_level(const int level, const unsigned int=
 flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set_debug_le=
vel(const int level, const int flags)</span><br><span> {</span><br><span>  =
   const int ceiling =3D 15;</span><br><span> </span><br><span>@@ -190,7 +1=
90,7 @@</span><br><span>  * Return a file to print messages to before syslo=
g is opened.</span><br><span>  */</span><br><span> FILE *</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-msg_fp(const unsigned int flags)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+msg_fp(const int flags)</s=
pan><br><span> {</span><br><span>     FILE *fp =3D msgfp;</span><br><span> =
    if (!fp)</span><br><span>@@ -214,7 +214,7 @@</span><br><span> int x_msg=
_line_num; /* GLOBAL */</span><br><span> </span><br><span> void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-x_msg(const unsigned int flags, c=
onst char *format, ...)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+x_msg(const int flags, const char *format, ...)</span><br><span> {</spa=
n><br><span>     va_list arglist;</span><br><span>     va_start(arglist, fo=
rmat);</span><br><span>@@ -235,7 +235,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-x_msg_va(const unsigned int flags, const char *format, va_list arglist=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+x_msg_va(const int=
 flags, const char *format, va_list arglist)</span><br><span> {</span><br><=
span>     struct gc_arena gc;</span><br><span> #if SYSLOG_CAPABILITY</span>=
<br><span>@@ -385,7 +385,7 @@</span><br><span>  * Apply muting filter.</spa=
n><br><span>  */</span><br><span> bool</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-dont_mute(unsigned int flags)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+dont_mute(int flags)</span><br><span> {</span><b=
r><span>     bool ret =3D true;</span><br><span>     if (mute_cutoff &gt; 0=
 &amp;&amp; !(flags &amp; M_NOMUTE))</span><br><span>@@ -599,9 +599,9 @@</s=
pan><br><span>  * of I/O operations.</span><br><span>  */</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned int x_cs_inf=
o_level;    /* GLOBAL */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-unsigned int x_cs_verbose_level; /* GLOBAL */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-unsigned int x_cs_err_delay_ms;  /* GLOBAL */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+int x_cs_info_level;  =
          /* GLOBAL */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+int x_cs_verbose_level;         /* GLOBAL */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+unsigned int x_cs_err_delay_ms; /* GLOBAL */</s=
pan><br><span> </span><br><span> void</span><br><span> reset_check_status(v=
oid)</span><br><span>@@ -611,7 +611,7 @@</span><br><span> }</span><br><span=
> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-set_check_status(unsigned int info_level, unsigned int verbose_level)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+set_check_status(int i=
nfo_level, int verbose_level)</span><br><span> {</span><br><span>     x_cs_=
info_level =3D info_level;</span><br><span>     x_cs_verbose_level =3D verb=
ose_level;</span><br><span>@@ -750,7 +750,7 @@</span><br><span>  * Translat=
e msg flags into a string</span><br><span>  */</span><br><span> const char =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-msg_flags_string(con=
st unsigned int flags, struct gc_arena *gc)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+msg_flags_string(const int flags, struct gc_arena *=
gc)</span><br><span> {</span><br><span>     struct buffer out =3D alloc_buf=
_gc(16, gc);</span><br><span>     if (flags =3D=3D M_INFO)</span><br><span>=
diff --git a/src/openvpn/error.h b/src/openvpn/error.h</span><br><span>inde=
x 8388f82..babb42f 100644</span><br><span>--- a/src/openvpn/error.h</span><=
br><span>+++ b/src/openvpn/error.h</span><br><span>@@ -78,7 +78,7 @@</span>=
<br><span>  * These globals should not be accessed directly,</span><br><spa=
n>  * but rather through macros or inline functions defined below.</span><b=
r><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-extern un=
signed int x_debug_level;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+extern int x_debug_level;</span><br><span> extern int x_msg_line_num;=
</span><br><span> </span><br><span> /* msg() flags */</span><br><span>@@ -1=
35,7 +135,7 @@</span><br><span>  */</span><br><span> </span><br><span> /** =
Check muting filter */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-bool dont_mute(unsigned int flags);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+bool dont_mute(int flags);</span><br><span> </span><br><sp=
an> /* Macro to ensure (and teach static analysis tools) we exit on fatal e=
rrors */</span><br><span> #define EXIT_FATAL(flags)      \</span><br><span>=
@@ -170,7 +170,7 @@</span><br><span> #define dmsg(flags, ...)</span><br><sp=
an> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-void x_msg(const unsigned int flags, const char *format, ...)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void x_msg(const int flags=
, const char *format, ...)</span><br><span> #ifdef __GNUC__</span><br><span=
> #if __USE_MINGW_ANSI_STDIO</span><br><span>     __attribute__((format(gnu=
_printf, 2, 3)))</span><br><span>@@ -180,7 +180,7 @@</span><br><span> #endi=
f</span><br><span>     ; /* should be called via msg above */</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void x_msg_va(con=
st unsigned int flags, const char *format, va_list arglist);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void x_msg_va(const int flags, con=
st char *format, va_list arglist);</span><br><span> </span><br><span> /*</s=
pan><br><span>  * Function prototypes</span><br><span>@@ -197,7 +197,7 @@</=
span><br><span> </span><br><span> </span><br><span> #define SDL_CONSTRAIN (=
1 &lt;&lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool set=
_debug_level(const int level, const unsigned int flags);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+bool set_debug_level(const int level, =
const int flags);</span><br><span> </span><br><span> bool set_mute_cutoff(c=
onst int cutoff);</span><br><span> </span><br><span>@@ -205,12 +205,12 @@</=
span><br><span> </span><br><span> int get_mute_cutoff(void);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-const char *msg_fl=
ags_string(const unsigned int flags, struct gc_arena *gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+const char *msg_flags_string(const i=
nt flags, struct gc_arena *gc);</span><br><span> </span><br><span> /*</span=
><br><span>  * File to print messages to before syslog is opened.</span><br=
><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-FILE *msg_=
fp(const unsigned int flags);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+FILE *msg_fp(const int flags);</span><br><span> </span><br><span>=
 /* Fatal logic errors */</span><br><span> #ifndef ENABLE_SMALL</span><br><=
span>@@ -254,14 +254,14 @@</span><br><span> /* Inline functions */</span><b=
r><span> </span><br><span> static inline bool</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-check_debug_level(unsigned int level)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+check_debug_level(int level)</spa=
n><br><span> {</span><br><span>     return (level &amp; M_DEBUG_LEVEL) &lt;=
=3D x_debug_level;</span><br><span> }</span><br><span> </span><br><span> /*=
* Return true if flags represent an enabled, not muted log level */</span><=
br><span> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-msg_test(unsigned int flags)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+msg_test(int flags)</span><br><span> {</span><br><span>    =
 return check_debug_level(flags) &amp;&amp; dont_mute(flags);</span><br><sp=
an> }</span><br><span>@@ -297,13 +297,13 @@</span><br><span> struct link_so=
cket;</span><br><span> struct tuntap;</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-extern unsigned int x_cs_info_level;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-extern unsigned int x_cs_v=
erbose_level;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+extern=
 int x_cs_info_level;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+extern int x_cs_verbose_level;</span><br><span> extern unsigned int x_cs_=
err_delay_ms;</span><br><span> </span><br><span> void reset_check_status(vo=
id);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void set_check_status(unsigned int info_level, unsigned int verbose_level)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void set_check_sta=
tus(int info_level, int verbose_level);</span><br><span> </span><br><span> =
void x_check_status(int status, const char *description, struct link_socket=
 *sock,</span><br><span>                     struct tuntap *tt);</span><br>=
<span>@@ -400,8 +400,8 @@</span><br><span> }</span><br><span> </span><br><s=
pan> /** Convert fatal errors to nonfatal, don&#39;t touch other errors */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline unsigned=
 int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nonfatal(const un=
signed int err)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic inline int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+nonfat=
al(const int err)</span><br><span> {</span><br><span>     return err &amp; =
M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err;</span><br><span> }</span><br>=
<span>@@ -409,21 +409,20 @@</span><br><span> static inline int</span><br><s=
pan> openvpn_errno_maybe_crt(bool *crt_error)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int err =3D 0;</span><br><sp=
an>     *crt_error =3D false;</span><br><span> #ifdef _WIN32</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    err =3D GetLastError();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int err =3D (int)GetLast=
Error();</span><br><span>     if (err =3D=3D ERROR_SUCCESS)</span><br><span=
>     {</span><br><span>         /* error is likely C runtime */</span><br>=
<span>         *crt_error =3D true;</span><br><span>         err =3D errno;=
</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return err;</span><br><span> #else /* ifdef _WIN32 */</span><br><sp=
an>     *crt_error =3D true;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    err =3D errno;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return errno;</span><br><span> #endif</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return err;</span><br><span> }</span><br><spa=
n> </span><br><span> #include &quot;errlevel.h&quot;</span><br><span>diff -=
-git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>index 4f=
37bd2..87981d2 100644</span><br><span>--- a/src/openvpn/manage.c</span><br>=
<span>+++ b/src/openvpn/manage.c</span><br><span>@@ -352,7 +352,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> static void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-virtual_output_callback_func(void *ar=
g, const unsigned int flags, const char *str)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+virtual_output_callback_func(void *arg, const int=
 flags, const char *str)</span><br><span> {</span><br><span>     struct man=
agement *man =3D (struct management *)arg;</span><br><span>     static int =
recursive_level =3D 0; /* GLOBAL */</span><br><span>diff --git a/src/openvp=
n/manage.h b/src/openvpn/manage.h</span><br><span>index 7c189ba..7196210 10=
0644</span><br><span>--- a/src/openvpn/manage.h</span><br><span>+++ b/src/o=
penvpn/manage.h</span><br><span>@@ -98,7 +98,7 @@</span><br><span> </span><=
br><span> union log_entry_union</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    unsigned int msg_flags;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int msg_flags;</span><br><span>   =
  int state;</span><br><span>     int intval;</span><br><span> };</span><br=
><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br=
><span>index e47d54c..22b36a3 100644</span><br><span>--- a/src/openvpn/opti=
ons.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -4869,=
7 +4869,7 @@</span><br><span> </span><br><span> #ifdef _WIN32</span><br><sp=
an> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-show_windows_=
version(const unsigned int flags)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+show_windows_version(const int flags)</span><br><span> {</spa=
n><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     msg(=
flags, &quot;Windows version: %s&quot;, win32_version_string(&amp;gc));</sp=
an><br><span>@@ -4878,7 +4878,7 @@</span><br><span> #endif</span><br><span>=
 </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-show_dco_version(const unsigned int flags)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+show_dco_version(const int flags)</span><br><span>=
 {</span><br><span> #ifdef ENABLE_DCO</span><br><span>     struct gc_arena =
gc =3D gc_new();</span><br><span>@@ -4888,7 +4888,7 @@</span><br><span> }</=
span><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-show_library_versions(const unsigned int flags)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+show_library_versions(const in=
t flags)</span><br><span> {</span><br><span> #ifdef ENABLE_LZO</span><br><s=
pan> #define LZO_LIB_VER_STR &quot;, LZO &quot;, lzo_version_string()</span=
><br><span>diff --git a/src/openvpn/options.h b/src/openvpn/options.h</span=
><br><span>index bb2c052..b8efdf8 100644</span><br><span>--- a/src/openvpn/=
options.h</span><br><span>+++ b/src/openvpn/options.h</span><br><span>@@ -8=
30,14 +830,14 @@</span><br><span> </span><br><span> void usage_small(void);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-voi=
d show_library_versions(const unsigned int flags);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void show_library_versions(const int flags);=
</span><br><span> </span><br><span> #ifdef _WIN32</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-void show_windows_version(const unsigned int fl=
ags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void show_wind=
ows_version(const int flags);</span><br><span> </span><br><span> #endif</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void sh=
ow_dco_version(const unsigned int flags);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void show_dco_version(const int flags);</span><br><sp=
an> </span><br><span> void init_options(struct options *o, const bool init_=
gc);</span><br><span> </span><br><span>diff --git a/src/openvpn/pkcs11.c b/=
src/openvpn/pkcs11.c</span><br><span>index d9c16d9..ba81c54 100644</span><b=
r><span>--- a/src/openvpn/pkcs11.c</span><br><span>+++ b/src/openvpn/pkcs11=
.c</span><br><span>@@ -77,10 +77,10 @@</span><br><span> #endif</span><br><s=
pan> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-static unsigned</span><br><span style=3D"color: hsl(0, 100%, 40%);">-_p=
kcs11_msg_pkcs112openvpn(const unsigned flags)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+_pkcs11_msg_pkcs112openvpn(const unsigned int flags)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uns=
igned openvpn_flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int openvpn_flags;</span><br><span> </span><br><span>     switch (flag=
s)</span><br><span>     {</span><br><span>@@ -117,7 +117,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> static unsigned</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-_pkcs11_msg_openvpn2pkcs11(const unsigne=
d flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+_pkcs11_msg=
_openvpn2pkcs11(const int flags)</span><br><span> {</span><br><span>     un=
signed pkcs11_flags;</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/platform.c b/src/openvpn/platform.c</span><br><span>index 880d14e..78c=
56d3 100644</span><br><span>--- a/src/openvpn/platform.c</span><br><span>++=
+ b/src/openvpn/platform.c</span><br><span>@@ -223,7 +223,7 @@</span><br><s=
pan>                         const struct platform_state_group *group_state=
, struct context *c)</span><br><span> {</span><br><span>     int keep_caps =
=3D need_keep_caps(c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    unsigned int err_flags =3D (keep_caps &gt; 0) ? M_FATAL : M_NONFATAL;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int err_flags =
=3D (keep_caps &gt; 0) ? M_FATAL : M_NONFATAL;</span><br><span> #ifdef HAVE=
_LIBCAPNG</span><br><span>     int new_gid =3D -1, new_uid =3D -1;</span><b=
r><span>     int res;</span><br><span>diff --git a/src/openvpn/plugin.c b/s=
rc/openvpn/plugin.c</span><br><span>index ea76a08..b14ce5c 100644</span><br=
><span>--- a/src/openvpn/plugin.c</span><br><span>+++ b/src/openvpn/plugin.=
c</span><br><span>@@ -371,7 +371,7 @@</span><br><span> static void</span><b=
r><span> plugin_vlog(openvpn_plugin_log_flags_t flags, const char *name, co=
nst char *format, va_list arglist)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    unsigned int msg_flags =3D 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int msg_flags =3D 0;</spa=
n><br><span> </span><br><span>     if (!format)</span><br><span>     {</spa=
n><br><span>diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c</span><b=
r><span>index 34b3378..b0373df 100644</span><br><span>--- a/src/openvpn/pro=
to.c</span><br><span>+++ b/src/openvpn/proto.c</span><br><span>@@ -183,7 +1=
83,7 @@</span><br><span>             int hlen;</span><br><span>            =
 int totlen;</span><br><span>             const char *msgstr =3D &quot;PACK=
ET SIZE INFO&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          unsigned int msglevel =3D D_PACKET_TRUNC_DEBUG;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            int msglevel =3D D_PACKET=
_TRUNC_DEBUG;</span><br><span> </span><br><span>             if (BLEN(&amp;=
buf) &lt; (int)sizeof(struct openvpn_iphdr))</span><br><span>             {=
</span><br><span>diff --git a/src/openvpn/status.h b/src/openvpn/status.h</=
span><br><span>index 0c7a869..c318683 100644</span><br><span>--- a/src/open=
vpn/status.h</span><br><span>+++ b/src/openvpn/status.h</span><br><span>@@ =
-32,11 +32,11 @@</span><br><span> {</span><br><span>     void *arg;</span><=
br><span>     unsigned int flags_default;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    void (*func)(void *arg, const unsigned int flags, c=
onst char *str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 void (*func)(void *arg, const int flags, const char *str);</span><br><span=
> };</span><br><span> </span><br><span> static inline void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-virtual_output_print(const struct virt=
ual_output *vo, const unsigned int flags, const char *str)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+virtual_output_print(const struct vi=
rtual_output *vo, const int flags, const char *str)</span><br><span> {</spa=
n><br><span>     (*vo-&gt;func)(vo-&gt;arg, flags, str);</span><br><span> }=
</span><br><span>diff --git a/src/openvpnmsica/dllmain.c b/src/openvpnmsica=
/dllmain.c</span><br><span>index e7d4a4b..8b1b7e9 100644</span><br><span>--=
- a/src/openvpnmsica/dllmain.c</span><br><span>+++ b/src/openvpnmsica/dllma=
in.c</span><br><span>@@ -91,7 +91,7 @@</span><br><span> </span><br><span> <=
/span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
dont_mute(unsigned int flags)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+dont_mute(int flags)</span><br><span> {</span><br><span>     UNRE=
FERENCED_PARAMETER(flags);</span><br><span> </span><br><span>@@ -100,7 +100=
,7 @@</span><br><span> </span><br><span> </span><br><span> void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-x_msg_va(const unsigned int flags=
, const char *format, va_list arglist)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+x_msg_va(const int flags, const char *format, va_list ar=
glist)</span><br><span> {</span><br><span>     /* Secure last error before =
it is overridden. */</span><br><span>     DWORD dwResult =3D (flags &amp; M=
_ERRNO) !=3D 0 ? GetLastError() : ERROR_SUCCESS;</span><br><span>diff --git=
 a/src/tapctl/error.c b/src/tapctl/error.c</span><br><span>index 9f5094e..2=
7a475a 100644</span><br><span>--- a/src/tapctl/error.c</span><br><span>+++ =
b/src/tapctl/error.c</span><br><span>@@ -22,11 +22,11 @@</span><br><span> <=
/span><br><span> </span><br><span> /* Globals */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-unsigned int x_debug_level; /* GLOBAL */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+int x_debug_level; /* GLOBA=
L */</span><br><span> </span><br><span> </span><br><span> void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-x_msg(const unsigned int flags, co=
nst char *format, ...)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+x_msg(const int flags, const char *format, ...)</span><br><span> {</span=
><br><span>     va_list arglist;</span><br><span>     va_start(arglist, for=
mat);</span><br><span>diff --git a/src/tapctl/error.h b/src/tapctl/error.h<=
/span><br><span>index fb24a61..ee9909a 100644</span><br><span>--- a/src/tap=
ctl/error.h</span><br><span>+++ b/src/tapctl/error.h</span><br><span>@@ -29=
,7 +29,7 @@</span><br><span>  * These globals should not be accessed direct=
ly,</span><br><span>  * but rather through macros or inline functions defin=
ed below.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-extern unsigned int x_debug_level;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+extern int x_debug_level;</span><br><span> extern i=
nt x_msg_line_num;</span><br><span> </span><br><span> /* msg() flags */</sp=
an><br><span>@@ -58,7 +58,7 @@</span><br><span> </span><br><span> </span><b=
r><span> /** Check muting filter */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-bool dont_mute(unsigned int flags);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool dont_mute(int flags);</span><br><span> <=
/span><br><span> /* Macro to ensure (and teach static analysis tools) we ex=
it on fatal errors */</span><br><span> #ifdef _MSC_VER</span><br><span>@@ -=
97,21 +97,21 @@</span><br><span> #define dmsg(flags, ...)</span><br><span> =
#endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-void x_msg(const unsigned int flags, const char *format, ...); /* should=
 be called via msg above */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void x_msg(const int flags, const char *format, ...); /* should be =
called via msg above */</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-void x_msg_va(const unsigned int flags, const char *for=
mat, va_list arglist);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void x_msg_va(const int flags, const char *format, va_list arglist);</sp=
an><br><span> </span><br><span> /* Inline functions */</span><br><span> </s=
pan><br><span> static inline bool</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-check_debug_level(unsigned int level)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+check_debug_level(int level)</span><br><span>=
 {</span><br><span>     return (level &amp; M_DEBUG_LEVEL) &lt;=3D x_debug_=
level;</span><br><span> }</span><br><span> </span><br><span> /** Return tru=
e if flags represent and enabled, not muted log level */</span><br><span> s=
tatic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-msg_=
test(unsigned int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+msg_test(int flags)</span><br><span> {</span><br><span>     return che=
ck_debug_level(flags) &amp;&amp; dont_mute(flags);</span><br><span> }</span=
><br><span>diff --git a/src/tapctl/main.c b/src/tapctl/main.c</span><br><sp=
an>index 031e262..52cc8e22 100644</span><br><span>--- a/src/tapctl/main.c</=
span><br><span>+++ b/src/tapctl/main.c</span><br><span>@@ -479,7 +479,7 @@<=
/span><br><span> </span><br><span> </span><br><span> bool</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-dont_mute(unsigned int flags)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+dont_mute(int flags)</span><b=
r><span> {</span><br><span>     UNREFERENCED_PARAMETER(flags);</span><br><s=
pan> </span><br><span>@@ -488,7 +488,7 @@</span><br><span> </span><br><span=
> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-x_msg_va(const unsigned int flags, const char *format, va_list arglist)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+x_msg_va(const int f=
lags, const char *format, va_list arglist)</span><br><span> {</span><br><sp=
an>     /* Output message string. Note: Message strings don&#39;t contain l=
ine terminators. */</span><br><span>     vfprintf(stderr, format, arglist);=
</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/u=
nit_tests/openvpn/mock_msg.c</span><br><span>index 603520b..a2d9c72 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/mock_msg.c</span><br><span>+=
++ b/tests/unit_tests/openvpn/mock_msg.c</span><br><span>@@ -38,8 +38,8 @@<=
/span><br><span> #include &quot;error.h&quot;</span><br><span> #include &qu=
ot;mock_msg.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-unsigned int x_debug_level =3D 0; /* Default to (almost) no=
 debugging output */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-u=
nsigned int print_x_debug_level =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+int x_debug_level =3D 0; /* Default to (almost) no debug=
ging output */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int p=
rint_x_debug_level =3D 0;</span><br><span> </span><br><span> bool fatal_err=
or_triggered =3D false;</span><br><span> </span><br><span>@@ -71,7 +71,7 @@=
</span><br><span> }</span><br><span> </span><br><span> void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-x_msg_va(const unsigned int flags, co=
nst char *format, va_list arglist)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+x_msg_va(const int flags, const char *format, va_list arglis=
t)</span><br><span> {</span><br><span>     if (flags &amp; M_FATAL)</span><=
br><span>     {</span><br><span>@@ -89,7 +89,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-x_msg(const unsigned int flags, const char *format, ...)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+x_msg(const int flags, con=
st char *format, ...)</span><br><span> {</span><br><span>     va_list argli=
st;</span><br><span>     va_start(arglist, format);</span><br><span>@@ -128=
,7 +128,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-dont_mute(unsigned int fl=
ags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dont_mute(int f=
lags)</span><br><span> {</span><br><span>     return true;</span><br><span>=
 }</span><br><span>diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b=
/tests/unit_tests/openvpn/test_cryptoapi.c</span><br><span>index 6e83465..c=
ff9547 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_cryptoapi=
.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_cryptoapi.c</span><b=
r><span>@@ -59,7 +59,7 @@</span><br><span> </span><br><span> /* replacement=
 for crypto_print_openssl_errors() */</span><br><span> void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-crypto_print_openssl_errors(const uns=
igned int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cry=
pto_print_openssl_errors(const int flags)</span><br><span> {</span><br><spa=
n>     unsigned long e;</span><br><span>     while ((e =3D ERR_get_error())=
)</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tes=
ts/unit_tests/openvpn/test_pkcs11.c</span><br><span>index 9ba6cfc..961d78b =
100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkcs11.c</span><=
br><span>+++ b/tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>@@ -4=
7,7 +47,7 @@</span><br><span> </span><br><span> /* replacement for crypto_p=
rint_openssl_errors() */</span><br><span> void</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-crypto_print_openssl_errors(const unsigned int fla=
gs)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_print_ope=
nssl_errors(const int flags)</span><br><span> {</span><br><span>     unsign=
ed long e;</span><br><span>     while ((e =3D ERR_get_error()))</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1189?usp=3Demail">change 1189</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
189?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4b0078d099e975d223825194ad1=
04945b1247554 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1189 </div>
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


--weuBPlnz8+M=--

