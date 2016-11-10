From: Gert Doering <gert@...1296...>
Date: Thu, 10 Nov 2016 09:21:52 +0100
Message-Id: <20161110082152.98252-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Replace WIN32 by _WIN32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

With c99, "WIN32" is no longer automatically defined when (cross-)building
for Windows, and proper compilation relies on including <windefs.h>,
before checking the macro.  "_WIN32" is the official define that is
guaranteed to be defined by the compiler itself, no includes are needed.

So, mechanically change all occurrances of "WIN32" to "_WIN32".

While at it, get rid of unused WIN32_0_1 #define in syshead.h

See also: http://nadeausoftware.com/articles/2012/01/c_c_tip_how_use_compiler_predefined_macros_detect_operating_system#WindowsCygwinnonPOSIXandMinGW

Trac #746

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/doxygen/openvpn.doxyfile     |  2 +-
 include/openvpn-plugin.h.in      |  2 +-
 m4/ax_socklen_t.m4               |  2 +-
 src/compat/compat-gettimeofday.c |  4 ++--
 src/compat/compat-inet_ntop.c    |  2 +-
 src/compat/compat-inet_pton.c    |  2 +-
 src/openvpn/block_dns.c          |  2 +-
 src/openvpn/block_dns.h          |  2 +-
 src/openvpn/common.h             |  2 +-
 src/openvpn/console.c            |  4 ++--
 src/openvpn/cryptoapi.c          |  2 +-
 src/openvpn/error.c              | 10 +++++-----
 src/openvpn/error.h              |  6 +++---
 src/openvpn/event.c              |  8 ++++----
 src/openvpn/event.h              |  4 ++--
 src/openvpn/fdmisc.c             |  4 ++--
 src/openvpn/fdmisc.h             |  2 +-
 src/openvpn/forward.c            |  4 ++--
 src/openvpn/init.c               | 36 ++++++++++++++++++------------------
 src/openvpn/manage.c             | 18 +++++++++---------
 src/openvpn/manage.h             |  2 +-
 src/openvpn/misc.c               | 16 ++++++++--------
 src/openvpn/misc.h               |  2 +-
 src/openvpn/openvpn.c            |  8 ++++----
 src/openvpn/options.c            | 40 ++++++++++++++++++++--------------------
 src/openvpn/options.h            |  6 +++---
 src/openvpn/otime.h              |  8 ++++----
 src/openvpn/platform.c           | 20 ++++++++++----------
 src/openvpn/platform.h           |  2 +-
 src/openvpn/plugin.c             |  8 ++++----
 src/openvpn/plugin.h             |  2 +-
 src/openvpn/route.c              | 26 +++++++++++++-------------
 src/openvpn/route.h              | 10 +++++-----
 src/openvpn/sig.c                |  8 ++++----
 src/openvpn/sig.h                |  2 +-
 src/openvpn/socket.c             | 40 ++++++++++++++++++++--------------------
 src/openvpn/socket.h             | 18 +++++++++---------
 src/openvpn/ssl.c                |  4 ++--
 src/openvpn/ssl_backend.h        |  2 +-
 src/openvpn/ssl_mbedtls.c        |  2 +-
 src/openvpn/ssl_openssl.c        |  2 +-
 src/openvpn/syshead.h            | 26 ++++++++------------------
 src/openvpn/tun.c                | 24 ++++++++++++------------
 src/openvpn/tun.h                | 18 +++++++++---------
 src/openvpn/win32.c              |  2 +-
 src/openvpn/win32.h              |  2 +-
 46 files changed, 204 insertions(+), 214 deletions(-)

diff --git a/doc/doxygen/openvpn.doxyfile b/doc/doxygen/openvpn.doxyfile
index 7a02028..a7d9728 100644
--- a/doc/doxygen/openvpn.doxyfile
+++ b/doc/doxygen/openvpn.doxyfile
@@ -235,7 +235,7 @@ EXPAND_ONLY_PREDEF     = NO
 SEARCH_INCLUDES        = YES
 INCLUDE_PATH           =
 INCLUDE_FILE_PATTERNS  =
-PREDEFINED             = WIN32 NTLM USE_LZO ENABLE_FRAGMENT P2MP P2MP_SERVER ENABLE_CRYPTO ENABLE_CRYPTO_OPENSSL ENABLE_PLUGIN ENABLE_MANAGEMENT ENABLE_OCC HAVE_GETTIMEOFDAY
+PREDEFINED             = _WIN32 NTLM USE_LZO ENABLE_FRAGMENT P2MP P2MP_SERVER ENABLE_CRYPTO ENABLE_CRYPTO_OPENSSL ENABLE_PLUGIN ENABLE_MANAGEMENT ENABLE_OCC HAVE_GETTIMEOFDAY
 EXPAND_AS_DEFINED      =
 SKIP_FUNCTION_MACROS   = YES
 #---------------------------------------------------------------------------
diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index b03a9df..34ad18b 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -154,7 +154,7 @@ typedef void *openvpn_plugin_handle_t;
 /*
  * For Windows (needs to be modified for MSVC)
  */
-#if defined(WIN32) && !defined(OPENVPN_PLUGIN_H)
+#if defined(_WIN32) && !defined(OPENVPN_PLUGIN_H)
 # define OPENVPN_EXPORT __declspec(dllexport)
 #else
 # define OPENVPN_EXPORT
diff --git a/m4/ax_socklen_t.m4 b/m4/ax_socklen_t.m4
index cd7cad8..b420a17 100644
--- a/m4/ax_socklen_t.m4
+++ b/m4/ax_socklen_t.m4
@@ -55,7 +55,7 @@ getpeername(0,0,&len);
 		],
 		[[
 #include <sys/types.h>
-#ifdef WIN32
+#ifdef _WIN32
 #include <ws2tcpip.h>
 #else
 #include <sys/socket.h>
diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeofday.c
index 0f32d5d..19feaae 100644
--- a/src/compat/compat-gettimeofday.c
+++ b/src/compat/compat-gettimeofday.c
@@ -32,7 +32,7 @@
 
 #include "compat.h"
 
-#ifdef WIN32
+#ifdef _WIN32
 /*
  * NOTICE: mingw has much faster gettimeofday!
  * autoconf will set HAVE_GETTIMEOFDAY
@@ -126,6 +126,6 @@ gettimeofday (struct timeval *tv, void *tz)
 	return 0;
 }
 
-#endif /* WIN32 */
+#endif /* _WIN32 */
 
 #endif /* HAVE_GETTIMEOFDAY */
diff --git a/src/compat/compat-inet_ntop.c b/src/compat/compat-inet_ntop.c
index 0d52142..786c973 100644
--- a/src/compat/compat-inet_ntop.c
+++ b/src/compat/compat-inet_ntop.c
@@ -32,7 +32,7 @@
 
 #include "compat.h"
 
-#ifdef WIN32
+#ifdef _WIN32
 
 #include <windows.h>
 
diff --git a/src/compat/compat-inet_pton.c b/src/compat/compat-inet_pton.c
index cdc8d4b..5965f0d 100644
--- a/src/compat/compat-inet_pton.c
+++ b/src/compat/compat-inet_pton.c
@@ -32,7 +32,7 @@
 
 #include "compat.h"
 
-#ifdef WIN32
+#ifdef _WIN32
 
 #include <windows.h>
 #include <string.h>
diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
index ee20c68..d161e9e 100644
--- a/src/openvpn/block_dns.c
+++ b/src/openvpn/block_dns.c
@@ -35,7 +35,7 @@
 
 #include "syshead.h"
 
-#ifdef WIN32
+#ifdef _WIN32
 
 #include <fwpmu.h>
 #include <initguid.h>
diff --git a/src/openvpn/block_dns.h b/src/openvpn/block_dns.h
index e945351..f8b6d4f 100644
--- a/src/openvpn/block_dns.h
+++ b/src/openvpn/block_dns.h
@@ -22,7 +22,7 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#ifdef WIN32
+#ifdef _WIN32
 
 #ifndef OPENVPN_BLOCK_DNS_H
 #define OPENVPN_BLOCK_DNS_H
diff --git a/src/openvpn/common.h b/src/openvpn/common.h
index 2f85bec..1134101 100644
--- a/src/openvpn/common.h
+++ b/src/openvpn/common.h
@@ -30,7 +30,7 @@
  */
 #ifdef USE_64_BIT_COUNTERS
   typedef unsigned long long int counter_type;
-# ifdef WIN32
+# ifdef _WIN32
 #  define counter_format  "%I64u"
 # else
 #  define counter_format  "%llu"
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index 86331a1..e70cda9 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -38,7 +38,7 @@
 #include <systemd/sd-daemon.h>
 #endif
 
-#ifdef WIN32
+#ifdef _WIN32
 
 #include "win32.h"
 
@@ -206,7 +206,7 @@ get_console_input (const char *prompt, const bool echo, char *input, const int c
     return get_console_input_systemd (prompt, echo, input, capacity);
 #endif
 
-#if defined(WIN32)
+#if defined(_WIN32)
   return get_console_input_win32 (prompt, echo, input, capacity);
 #elif defined(HAVE_GETPASS)
 
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 853c07b..e107bd3 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -465,4 +465,4 @@ int SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
 #ifdef _MSC_VER  /* Dummy function needed to avoid empty file compiler warning in Microsoft VC */
 static void dummy (void) {}
 #endif
-#endif				/* WIN32 */
+#endif				/* _WIN32 */
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index bb0ab5b..425bc30 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -453,7 +453,7 @@ close_syslog ()
 #endif
 }
 
-#ifdef WIN32
+#ifdef _WIN32
 
 static HANDLE orig_stderr;
 
@@ -471,7 +471,7 @@ get_orig_stderr (void)
 void
 redirect_stdout_stderr (const char *file, bool append)
 {
-#if defined(WIN32)
+#if defined(_WIN32)
   if (!std_redir)
     {
       struct gc_arena gc = gc_new ();
@@ -622,7 +622,7 @@ x_check_status (int status,
 	      sock->info.mtu_changed = true;
 	    }
 	}
-#elif defined(WIN32)
+#elif defined(_WIN32)
       /* get possible driver error from TAP-Windows driver */
       extended_msg = tap_win_getinfo (tt, &gc);
 #endif
@@ -677,7 +677,7 @@ openvpn_exit (const int status)
 
       tun_abort();
 
-#ifdef WIN32
+#ifdef _WIN32
       uninit_win32 ();
 #endif
 
@@ -737,7 +737,7 @@ crash (void)
 }
 #endif
 
-#ifdef WIN32
+#ifdef _WIN32
 
 const char *
 strerror_win32 (DWORD errnum, struct gc_arena *gc)
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index ced2fdf..98657a5 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -66,7 +66,7 @@ struct gc_arena;
 
 /* String and Error functions */
 
-#ifdef WIN32
+#ifdef _WIN32
 # define openvpn_errno()             GetLastError()
 # define openvpn_strerror(e, gc)     strerror_win32(e, gc)
   const char *strerror_win32 (DWORD errnum, struct gc_arena *gc);
@@ -248,7 +248,7 @@ void close_syslog ();
 /* log file output */
 void redirect_stdout_stderr (const char *file, bool append);
 
-#ifdef WIN32
+#ifdef _WIN32
 /* get original stderr handle, even if redirected by --log/--log-append */
 HANDLE get_orig_stderr (void);
 #endif
@@ -343,7 +343,7 @@ static inline bool
 ignore_sys_error (const int err)
 {
   /* I/O operation pending */
-#ifdef WIN32
+#ifdef _WIN32
   if (err == WSAEWOULDBLOCK || err == WSAEINVAL)
     return true;
 #else
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index c642691..409ad13 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -49,7 +49,7 @@
 /*
  * All non-windows OSes are assumed to have select()
  */
-#ifdef WIN32
+#ifdef _WIN32
 #define SELECT 0
 #else
 #define SELECT 1
@@ -74,7 +74,7 @@ tv_to_ms_timeout (const struct timeval *tv)
     return max_int (tv->tv_sec * 1000 + (tv->tv_usec + 500) / 1000, 1);
 }
 
-#ifdef WIN32
+#ifdef _WIN32
 
 struct we_set
 {
@@ -462,7 +462,7 @@ we_init (int *maxevents, unsigned int flags)
   return (struct event_set *) wes;
 }
 
-#endif /* WIN32 */
+#endif /* _WIN32 */
 
 #if EPOLL
 
@@ -1007,7 +1007,7 @@ static struct event_set *
 event_set_init_simple (int *maxevents, unsigned int flags)
 {
   struct event_set *ret = NULL;
-#ifdef WIN32
+#ifdef _WIN32
   ret = we_init (maxevents, flags);
 #elif POLL && SELECT
 #if 0 /* Define to 1 if EVENT_METHOD_US_TIMEOUT should cause select to be favored over poll */
diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index bd29fdc..565343d 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -42,7 +42,7 @@
 #define EVENT_METHOD_US_TIMEOUT   (1<<0)
 #define EVENT_METHOD_FAST         (1<<1)
 
-#ifdef WIN32
+#ifdef _WIN32
 
 typedef const struct rw_handle *event_t;
 
@@ -137,7 +137,7 @@ event_set_return_init (struct event_set_return *esr)
   esr->arg = NULL;
 }
 
-#ifdef WIN32
+#ifdef _WIN32
 
 static inline void
 wait_signal (struct event_set *es, void *arg)
diff --git a/src/openvpn/fdmisc.c b/src/openvpn/fdmisc.c
index 7fe449c..ce01319 100644
--- a/src/openvpn/fdmisc.c
+++ b/src/openvpn/fdmisc.c
@@ -39,7 +39,7 @@
 bool
 set_nonblock_action (int fd)
 {
-#ifdef WIN32
+#ifdef _WIN32
   u_long arg = 1;
   if (ioctlsocket (fd, FIONBIO, &arg))
     return false;
@@ -54,7 +54,7 @@ set_nonblock_action (int fd)
 bool
 set_cloexec_action (int fd)
 {
-#ifndef WIN32
+#ifndef _WIN32
   if (fcntl (fd, F_SETFD, FD_CLOEXEC) < 0)
     return false;
 #endif
diff --git a/src/openvpn/fdmisc.h b/src/openvpn/fdmisc.h
index 13d6552..d34db9b 100644
--- a/src/openvpn/fdmisc.h
+++ b/src/openvpn/fdmisc.h
@@ -37,7 +37,7 @@ void set_cloexec (int fd);
 
 static inline void openvpn_fd_set(int fd, fd_set *setp)
 {
-#ifndef WIN32 /* The Windows FD_SET() implementation does not overflow */
+#ifndef _WIN32 /* The Windows FD_SET() implementation does not overflow */
   ASSERT (fd >= 0 && fd < FD_SETSIZE);
 #endif
   FD_SET (fd, setp);
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6c11439..1355d15 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -301,7 +301,7 @@ check_add_routes_dowork (struct context *c)
 	    {
 	      register_signal (c, SIGHUP, "ip-fail");
 	      c->persist.restart_sleep_seconds = 10;
-#ifdef WIN32
+#ifdef _WIN32
 	      show_routes (M_INFO|M_NOPREFIX);
 	      show_adapters (M_INFO|M_NOPREFIX);
 #endif
@@ -1348,7 +1348,7 @@ pre_select (struct context *c)
   c->c2.timeval.tv_sec = BIG_TIMEOUT;
   c->c2.timeval.tv_usec = 0;
 
-#if defined(WIN32)
+#if defined(_WIN32)
   if (check_debug_level (D_TAP_WIN_DEBUG))
     {
       c->c2.timeval.tv_sec = 1;
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e3206b0..6976eaf 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -577,7 +577,7 @@ init_static (void)
   error_reset ();		/* initialize error.c */
   reset_check_status ();	/* initialize status check code in socket.c */
 
-#ifdef WIN32
+#ifdef _WIN32
   init_win32 ();
 #endif
 
@@ -1024,7 +1024,7 @@ format_common_name (struct context *c, struct gc_arena *gc)
 void
 pre_setup (const struct options *options)
 {
-#ifdef WIN32
+#ifdef _WIN32
   if (options->exit_event_name)
     {
       win32_signal_open (&win32_signal,
@@ -1257,7 +1257,7 @@ initialization_sequence_completed (struct context *c, const unsigned int flags)
   /* Test if errors */
   if (flags & ISC_ERRORS)
     {
-#ifdef WIN32
+#ifdef _WIN32
       show_routes (M_INFO|M_NOPREFIX);
       show_adapters (M_INFO|M_NOPREFIX);
       msg (M_INFO, "%s With Errors ( see http://openvpn.net/faq.html#dhcpclientserv )", message);
@@ -1272,7 +1272,7 @@ initialization_sequence_completed (struct context *c, const unsigned int flags)
   if ((flags & (ISC_ERRORS|ISC_SERVER)) == 0)
     c->options.no_advance=true;
 
-#ifdef WIN32
+#ifdef _WIN32
   fork_register_dns_action (c->c1.tuntap);
 #endif
 
@@ -1367,7 +1367,7 @@ do_route (const struct options *options,
       argv_reset (&argv);
     }
 
-#ifdef WIN32
+#ifdef _WIN32
   if (options->show_net_up)
     {
       show_routes (M_INFO|M_NOPREFIX);
@@ -1439,7 +1439,7 @@ do_open_tun (struct context *c)
       /* initialize (but do not open) tun/tap object */
       do_init_tun (c);
 
-#ifdef WIN32
+#ifdef _WIN32
       /* store (hide) interactive service handle in tuntap_options */
       c->c1.tuntap->options.msg_channel = c->options.msg_channel;
       msg (D_ROUTE, "interactive service msg_channel=%u", (unsigned int) c->options.msg_channel);
@@ -1497,7 +1497,7 @@ do_open_tun (struct context *c)
 		   c->plugins,
 		   OPENVPN_PLUGIN_UP,
 		   c->c1.tuntap->actual_name,
-#ifdef WIN32
+#ifdef _WIN32
 		   c->c1.tuntap->adapter_index,
 #endif
 		   dev_type_string (c->options.dev, c->options.dev_type),
@@ -1510,7 +1510,7 @@ do_open_tun (struct context *c)
 		   "up",
 		   c->c2.es);
 
-#if defined(WIN32)
+#if defined(_WIN32)
       if (c->options.block_outside_dns)
       {
         dmsg (D_LOW, "Blocking outside DNS");
@@ -1550,7 +1550,7 @@ do_open_tun (struct context *c)
 		     c->plugins,
 		     OPENVPN_PLUGIN_UP,
 		     c->c1.tuntap->actual_name,
-#ifdef WIN32
+#ifdef _WIN32
 		     c->c1.tuntap->adapter_index,
 #endif
 		     dev_type_string (c->options.dev, c->options.dev_type),
@@ -1562,7 +1562,7 @@ do_open_tun (struct context *c)
 		     NULL,
 		     "up",
 		     c->c2.es);
-#if defined(WIN32)
+#if defined(_WIN32)
       if (c->options.block_outside_dns)
         {
           dmsg (D_LOW, "Blocking outside DNS");
@@ -1600,7 +1600,7 @@ do_close_tun (struct context *c, bool force)
   if (c->c1.tuntap && c->c1.tuntap_owned)
     {
       const char *tuntap_actual = string_alloc (c->c1.tuntap->actual_name, &gc);
-#ifdef WIN32
+#ifdef _WIN32
       DWORD adapter_index = c->c1.tuntap->adapter_index;
 #endif
       const in_addr_t local = c->c1.tuntap->local;
@@ -1626,7 +1626,7 @@ do_close_tun (struct context *c, bool force)
                            c->plugins,
                            OPENVPN_PLUGIN_ROUTE_PREDOWN,
                            tuntap_actual,
-#ifdef WIN32
+#ifdef _WIN32
                            adapter_index,
 #endif
                            NULL,
@@ -1654,7 +1654,7 @@ do_close_tun (struct context *c, bool force)
 		       c->plugins,
 		       OPENVPN_PLUGIN_DOWN,
 		       tuntap_actual,
-#ifdef WIN32
+#ifdef _WIN32
 		       adapter_index,
 #endif
 		       NULL,
@@ -1668,7 +1668,7 @@ do_close_tun (struct context *c, bool force)
 		       "down",
 		       c->c2.es);
 
-#if defined(WIN32)
+#if defined(_WIN32)
             if (c->options.block_outside_dns)
             {
                 if (!win_wfp_uninit(c->options.msg_channel))
@@ -1688,7 +1688,7 @@ do_close_tun (struct context *c, bool force)
 			 c->plugins,
 			 OPENVPN_PLUGIN_DOWN,
 			 tuntap_actual,
-#ifdef WIN32
+#ifdef _WIN32
 			 adapter_index,
 #endif
 			 NULL,
@@ -1702,7 +1702,7 @@ do_close_tun (struct context *c, bool force)
 			 "down",
 			 c->c2.es);
 
-#if defined(WIN32)
+#if defined(_WIN32)
           if (c->options.block_outside_dns)
             {
               if (!win_wfp_uninit(c->options.msg_channel))
@@ -3213,7 +3213,7 @@ do_setup_fast_io (struct context *c)
 {
   if (c->options.fast_io)
     {
-#ifdef WIN32
+#ifdef _WIN32
       msg (M_INFO, "NOTE: --fast-io is disabled since we are running on Windows");
 #else
       if (!proto_is_udp(c->options.ce.proto))
@@ -3326,7 +3326,7 @@ management_callback_status_p2p (void *arg, const int version, struct status_outp
 void
 management_show_net_callback (void *arg, const int msglevel)
 {
-#ifdef WIN32
+#ifdef _WIN32
   show_routes (msglevel);
   show_adapters (msglevel);
   msg (msglevel, "END");
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index dcb1bc1..72a5c73 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -270,7 +270,7 @@ man_delete_unix_socket (struct management *man)
 static void
 man_close_socket (struct management *man, const socket_descriptor_t sd)
 {
-#ifndef WIN32
+#ifndef _WIN32
   /*
    * Windows doesn't need this because the ne32 event is permanently
    * enabled at struct management scope.
@@ -1413,7 +1413,7 @@ man_dispatch_command (struct management *man, struct status_output *so, const ch
   gc_free (&gc);
 }
 
-#ifdef WIN32
+#ifdef _WIN32
 
 static void
 man_start_ne32 (struct management *man)
@@ -1503,7 +1503,7 @@ man_new_connection_post (struct management *man, const char *description)
 
   man_connection_settings_reset (man);
 
-#ifdef WIN32
+#ifdef _WIN32
   man_start_ne32 (man);
 #endif
 
@@ -1590,7 +1590,7 @@ man_accept (struct management *man)
 
       if (socket_defined (man->connection.sd_top))
 	{
-#ifdef WIN32
+#ifdef _WIN32
 	  man_stop_ne32 (man);
 #endif
 	}
@@ -1654,7 +1654,7 @@ man_listen (struct management *man)
 	     print_sockaddr (man->settings.local->ai_addr, &gc));
     }
 
-#ifdef WIN32
+#ifdef _WIN32
   man_start_ne32 (man);
 #endif
   
@@ -1737,7 +1737,7 @@ man_reset_client_socket (struct management *man, const bool exiting)
 {
   if (socket_defined (man->connection.sd_cli))
     {
-#ifdef WIN32
+#ifdef _WIN32
       man_stop_ne32 (man);
 #endif
       man_close_socket (man, man->connection.sd_cli);
@@ -2254,7 +2254,7 @@ man_connection_init (struct management *man)
 {
   if (man->connection.state == MS_INITIAL)
     {
-#ifdef WIN32
+#ifdef _WIN32
       /*
        * This object is a sort of TCP/IP helper
        * for Windows.
@@ -2295,7 +2295,7 @@ man_connection_close (struct management *man)
 
   if (mc->es)
     event_free (mc->es);
-#ifdef WIN32
+#ifdef _WIN32
   net_event_win32_close (&mc->ne32);
 #endif
   if (socket_defined (mc->sd_top))
@@ -2731,7 +2731,7 @@ man_persist_state (unsigned int *persistent, const int n)
   return true;
 }
 
-#ifdef WIN32
+#ifdef _WIN32
 
 void
 management_socket_set (struct management *man,
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 988600f..141cbb8 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -257,7 +257,7 @@ struct man_connection {
   socket_descriptor_t sd_cli;
   struct openvpn_sockaddr remote;
 
-#ifdef WIN32
+#ifdef _WIN32
   struct net_event_win32 ne32;
 #endif
 
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 2982cd0..fcdd8e5 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -62,7 +62,7 @@ run_up_down (const char *command,
 	     const struct plugin_list *plugins,
 	     int plugin_type,
 	     const char *arg,
-#ifdef WIN32
+#ifdef _WIN32
 	     DWORD adapter_index,
 #endif
 	     const char *dev_type,
@@ -85,7 +85,7 @@ run_up_down (const char *command,
   setenv_str (es, "dev", arg);
   if (dev_type)
     setenv_str (es, "dev_type", dev_type);
-#ifdef WIN32
+#ifdef _WIN32
   setenv_int (es, "dev_idx", adapter_index);
 #endif
 
@@ -197,7 +197,7 @@ save_inetd_socket_descriptor (void)
 void
 warn_if_group_others_accessible (const char* filename)
 {
-#ifndef WIN32
+#ifndef _WIN32
 #ifdef HAVE_STAT
   if (strcmp (filename, INLINE_FILE_TAG))
     {
@@ -223,7 +223,7 @@ const char *
 system_error_message (int stat, struct gc_arena *gc)
 {
   struct buffer out = alloc_buf_gc (256, gc);
-#ifdef WIN32
+#ifdef _WIN32
   if (stat == -1)
     buf_printf (&out, "external program did not execute -- ");
   buf_printf (&out, "returned error code %d", stat);
@@ -279,7 +279,7 @@ openvpn_execve_allowed (const unsigned int flags)
 }
 
 
-#ifndef WIN32
+#ifndef _WIN32
 /*
  * Run execve() inside a fork().  Designed to replicate the semantics of system() but
  * in a safer way that doesn't require the invocation of a shell or the risks
@@ -977,7 +977,7 @@ hostname_randomize(const char *hostname, struct gc_arena *gc)
 const char *
 gen_path (const char *directory, const char *filename, struct gc_arena *gc)
 {
-#ifdef WIN32
+#ifdef _WIN32
   const int CC_PATH_RESERVED = CC_LESS_THAN|CC_GREATER_THAN|CC_COLON|
     CC_DOUBLE_QUOTE|CC_SLASH|CC_BACKSLASH|CC_PIPE|CC_QUESTION_MARK|CC_ASTERISK;
 #else
@@ -988,7 +988,7 @@ gen_path (const char *directory, const char *filename, struct gc_arena *gc)
   if (safe_filename
       && strcmp (safe_filename, ".")
       && strcmp (safe_filename, "..")
-#ifdef WIN32
+#ifdef _WIN32
       && win_safe_filename (safe_filename)
 #endif
       )
@@ -1016,7 +1016,7 @@ absolute_pathname (const char *pathname)
   if (pathname)
     {
       const int c = pathname[0];
-#ifdef WIN32
+#ifdef _WIN32
       return c == '\\' || (isalpha(c) && pathname[1] == ':' && pathname[2] == '\\');
 #else
       return c == '/';
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index b694096..77f32cf 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -63,7 +63,7 @@ void run_up_down (const char *command,
 		  const struct plugin_list *plugins,
 		  int plugin_type,
 		  const char *arg,
-#ifdef WIN32
+#ifdef _WIN32
 		  DWORD adapter_index,
 #endif
 		  const char *dev_type,
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 823c3dd..5fb2fd9 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -138,7 +138,7 @@ openvpn_main (int argc, char *argv[])
   return 1;
 #endif
 
-#ifdef WIN32
+#ifdef _WIN32
   SetConsoleOutputCP (CP_UTF8);
 #endif
 
@@ -172,7 +172,7 @@ openvpn_main (int argc, char *argv[])
 
 	  /* initialize environmental variable store */
 	  c.es = env_set_create (NULL);
-#ifdef WIN32
+#ifdef _WIN32
 	  set_win_sys_path_via_env (c.es);
 #endif
 
@@ -220,7 +220,7 @@ openvpn_main (int argc, char *argv[])
 
 	  /* print version number */
 	  msg (M_INFO, "%s", title_string);
-#ifdef WIN32
+#ifdef _WIN32
 	  show_windows_version(M_INFO);
 #endif
 	  show_library_versions(M_INFO);
@@ -312,7 +312,7 @@ openvpn_main (int argc, char *argv[])
   return 0;			            /* NOTREACHED */
 }
 
-#ifdef WIN32
+#ifdef _WIN32
 int
 wmain (int argc, wchar_t *wargv[]) {
   char **argv;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9f6099c..83d2946 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -584,7 +584,7 @@ static const char usage_message[] =
   "                        Default is CN in the Subject field.\n"
 #endif
   "--verify-hash   : Specify SHA1 fingerprint for level-1 cert.\n"
-#ifdef WIN32
+#ifdef _WIN32
   "--cryptoapicert select-string : Load the certificate and private key from the\n"
   "                  Windows Certificate System Store.\n"
 #endif
@@ -662,7 +662,7 @@ static const char usage_message[] =
   "--show-digests  : Show message digest algorithms to use with --auth option.\n"
   "--show-engines  : Show hardware crypto accelerator engines (if available).\n"
   "--show-tls      : Show all TLS ciphers (TLS used only as a control channel).\n"
-#ifdef WIN32
+#ifdef _WIN32
   "\n"
   "Windows Specific:\n"
   "--win-sys path    : Pathname of Windows system directory. Default is the pathname\n"
@@ -712,7 +712,7 @@ static const char usage_message[] =
   "                       optional parameter controls the initial state of ex.\n"
   "--show-net-up   : Show " PACKAGE_NAME "'s view of routing table and net adapter list\n"
   "                  after TAP adapter is up and routes have been added.\n"
-#ifdef WIN32
+#ifdef _WIN32
   "--block-outside-dns   : Block DNS on other network adapters to prevent DNS leaks\n"
 #endif
   "Windows Standalone Options:\n"
@@ -808,7 +808,7 @@ init_options (struct options *o, const bool init_gc)
 #ifdef TARGET_LINUX
   o->tuntap_options.txqueuelen = 100;
 #endif
-#ifdef WIN32
+#ifdef _WIN32
 #if 0
   o->tuntap_options.ip_win32_type = IPW32_SET_ADAPTIVE;
 #else
@@ -868,7 +868,7 @@ init_options (struct options *o, const bool init_gc)
 /* tmp is only used in P2MP server context */
 #if P2MP_SERVER
   /* Set default --tmp-dir */
-#ifdef WIN32
+#ifdef _WIN32
   /* On Windows, find temp dir via enviroment variables */
   o->tmp_dir = win_get_tempdir();
 #else
@@ -877,7 +877,7 @@ init_options (struct options *o, const bool init_gc)
   if( !o->tmp_dir ) {
           o->tmp_dir = "/tmp";
   }
-#endif /* WIN32 */
+#endif /* _WIN32 */
 #endif /* P2MP_SERVER */
 }
 
@@ -1129,7 +1129,7 @@ parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_aren
 }
 #endif
 
-#ifdef WIN32
+#ifdef _WIN32
 
 #ifndef ENABLE_SMALL
 
@@ -1174,7 +1174,7 @@ show_tuntap_options (const struct tuntap_options *o)
 #endif
 #endif
 
-#if defined(WIN32) || defined(TARGET_ANDROID)
+#if defined(_WIN32) || defined(TARGET_ANDROID)
 static void
 dhcp_option_address_parse (const char *name, const char *parm, in_addr_t *array, int *len, int msglevel)
 {
@@ -1728,7 +1728,7 @@ show_settings (const struct options *o)
   show_p2mp_parms (o);
 #endif
 
-#ifdef WIN32
+#ifdef _WIN32
   SHOW_BOOL (show_net_up);
   SHOW_INT (route_method);
   SHOW_BOOL (block_outside_dns);
@@ -2020,7 +2020,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
    * Windows-specific options.
    */
 
-#ifdef WIN32
+#ifdef _WIN32
       if (dev == DEV_TYPE_TUN && !(pull || (options->ifconfig_local && options->ifconfig_remote_netmask)))
 	msg (M_USAGE, "On Windows, --ifconfig is required when --dev tun is used");
 
@@ -2495,7 +2495,7 @@ options_postprocess_mutate_ce (struct options *o, struct connection_entry *ce)
 static void
 options_postprocess_mutate_invariant (struct options *options)
 {
-#ifdef WIN32
+#ifdef _WIN32
   const int dev = dev_type_enum (options->dev, options->dev_type);
 #endif
 
@@ -2506,7 +2506,7 @@ options_postprocess_mutate_invariant (struct options *options)
   if (options->inetd == INETD_NOWAIT)
     options->ifconfig_noexec = true;
 
-#ifdef WIN32
+#ifdef _WIN32
   if ((dev == DEV_TYPE_TUN || dev == DEV_TYPE_TAP) && !options->route_delay_defined)
     {
       if (options->mode == MODE_POINT_TO_POINT)
@@ -2529,7 +2529,7 @@ options_postprocess_mutate_invariant (struct options *options)
    */
   if (options->mode == MODE_SERVER)
     {
-#ifdef WIN32
+#ifdef _WIN32
       /*
        * We need to explicitly set --tap-sleep because
        * we do not schedule event timers in the top-level context.
@@ -3558,7 +3558,7 @@ usage_small (void)
   openvpn_exit (OPENVPN_EXIT_STATUS_USAGE); /* exit point */
 }
 
-#ifdef WIN32
+#ifdef _WIN32
 void show_windows_version(const unsigned int flags)
 {
   struct gc_arena gc = gc_new ();
@@ -3592,7 +3592,7 @@ usage_version (void)
 {
   msg (M_INFO|M_NOPREFIX, "%s", title_string);
   show_library_versions( M_INFO|M_NOPREFIX );
-#ifdef WIN32
+#ifdef _WIN32
   show_windows_version( M_INFO|M_NOPREFIX );
 #endif
   msg (M_INFO|M_NOPREFIX, "Originally developed by James Yonan");
@@ -3639,7 +3639,7 @@ positive_atoi (const char *str)
   return i < 0 ? 0 : i;
 }
 
-#ifdef WIN32  /* This function is only used when compiling on Windows */
+#ifdef _WIN32  /* This function is only used when compiling on Windows */
 static unsigned int
 atou (const char *str)
 {
@@ -6217,7 +6217,7 @@ add_option (struct options *options,
 #endif
   else if (streq (p[0], "msg-channel") && p[1])
     {
-#ifdef WIN32
+#ifdef _WIN32
       VERIFY_PERMISSION (OPT_P_GENERAL);
       HANDLE process = GetCurrentProcess ();
       HANDLE handle = (HANDLE) atoi (p[1]);
@@ -6233,7 +6233,7 @@ add_option (struct options *options,
       goto err;
 #endif
     }
-#ifdef WIN32
+#ifdef _WIN32
   else if (streq (p[0], "win-sys") && p[1] && !p[2])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -6314,7 +6314,7 @@ add_option (struct options *options,
       to->ip_win32_defined = true; 
     }
 #endif
-#if defined(WIN32) || defined(TARGET_ANDROID)
+#if defined(_WIN32) || defined(TARGET_ANDROID)
   else if (streq (p[0], "dhcp-option") && p[1] && !p[3])
     {
       struct tuntap_options *o = &options->tuntap_options;
@@ -6367,7 +6367,7 @@ add_option (struct options *options,
       o->dhcp_options = true;
     }
 #endif
-#ifdef WIN32
+#ifdef _WIN32
   else if (streq (p[0], "show-adapters") && !p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 9b7b57c..87506cc 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -577,7 +577,7 @@ struct options
   /* special state parms */
   int foreign_option_index;
 
-#ifdef WIN32
+#ifdef _WIN32
   HANDLE msg_channel;
   const char *exit_event_name;
   bool exit_event_initial_state;
@@ -650,7 +650,7 @@ struct options
 #define PUSH_DEFINED(opt) (false)
 #endif
 
-#ifdef WIN32
+#ifdef _WIN32
 #define ROUTE_OPTION_FLAGS(o) ((o)->route_method & ROUTE_METHOD_MASK)
 #else
 #define ROUTE_OPTION_FLAGS(o) (0)
@@ -688,7 +688,7 @@ void usage_small (void);
 
 void show_library_versions(const unsigned int flags);
 
-#ifdef WIN32
+#ifdef _WIN32
 void show_windows_version(const unsigned int flags);
 #endif
 
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index 4ca1032..c0b0f38 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -76,8 +76,8 @@ openvpn_gettimeofday (struct timeval *tv, void *tz)
 static inline void
 update_time (void)
 {
-#ifdef WIN32
-  /* on WIN32, gettimeofday is faster than time(NULL) */
+#ifdef _WIN32
+  /* on _WIN32, gettimeofday is faster than time(NULL) */
   struct timeval tv;
   openvpn_gettimeofday (&tv, NULL);
 #else
@@ -90,8 +90,8 @@ update_time (void)
 static inline void
 update_time (void)
 {
-#if defined(WIN32)
-  /* on WIN32, gettimeofday is faster than time(NULL) */
+#if defined(_WIN32)
+  /* on _WIN32, gettimeofday is faster than time(NULL) */
   struct timeval tv;
   if (!gettimeofday (&tv, NULL))
     {
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 16d4dac..6343647 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -158,7 +158,7 @@ platform_nice (int niceval)
 unsigned int
 platform_getpid ()
 {
-#ifdef WIN32
+#ifdef _WIN32
   return (unsigned int) GetCurrentProcessId ();
 #else
 #ifdef HAVE_GETPID
@@ -190,7 +190,7 @@ int
 platform_chdir (const char* dir)
 {
 #ifdef HAVE_CHDIR
-#ifdef WIN32
+#ifdef _WIN32
   int res;
   struct gc_arena gc = gc_new ();
   res = _wchdir (wide_string (dir, &gc));
@@ -210,7 +210,7 @@ platform_chdir (const char* dir)
 bool
 platform_system_ok (int stat)
 {
-#ifdef WIN32
+#ifdef _WIN32
   return stat == 0;
 #else
   return stat != -1 && WIFEXITED (stat) && WEXITSTATUS (stat) == 0;
@@ -220,7 +220,7 @@ platform_system_ok (int stat)
 int
 platform_access (const char *path, int mode)
 {
-#ifdef WIN32
+#ifdef _WIN32
   struct gc_arena gc = gc_new ();
   int ret = _waccess (wide_string (path, &gc), mode & ~X_OK);
   gc_free (&gc);
@@ -236,7 +236,7 @@ platform_access (const char *path, int mode)
 void
 platform_sleep_milliseconds (unsigned int n)
 {
-#ifdef WIN32
+#ifdef _WIN32
   Sleep (n);
 #else
   struct timeval tv;
@@ -252,7 +252,7 @@ platform_sleep_milliseconds (unsigned int n)
 void
 platform_sleep_until_signal (void)
 {
-#ifdef WIN32
+#ifdef _WIN32
   ASSERT (0);
 #else
   select (0, NULL, NULL, NULL, NULL);
@@ -263,7 +263,7 @@ platform_sleep_until_signal (void)
 bool
 platform_unlink (const char *filename)
 {
-#if defined(WIN32)
+#if defined(_WIN32)
   struct gc_arena gc = gc_new ();
   BOOL ret = DeleteFileW (wide_string (filename, &gc));
   gc_free (&gc);
@@ -278,7 +278,7 @@ platform_unlink (const char *filename)
 FILE *
 platform_fopen (const char *path, const char *mode)
 {
-#ifdef WIN32
+#ifdef _WIN32
   struct gc_arena gc = gc_new ();
   FILE *f = _wfopen (wide_string (path, &gc), wide_string (mode, &gc));
   gc_free (&gc);
@@ -291,7 +291,7 @@ platform_fopen (const char *path, const char *mode)
 int
 platform_open (const char *path, int flags, int mode)
 {
-#ifdef WIN32
+#ifdef _WIN32
   struct gc_arena gc = gc_new ();
   int fd = _wopen (wide_string (path, &gc), flags, mode);
   gc_free (&gc);
@@ -304,7 +304,7 @@ platform_open (const char *path, int flags, int mode)
 int
 platform_stat (const char *path, platform_stat_t *buf)
 {
-#ifdef WIN32
+#ifdef _WIN32
   struct gc_arena gc = gc_new ();
   int res = _wstat (wide_string (path, &gc), buf);
   gc_free (&gc);
diff --git a/src/openvpn/platform.h b/src/openvpn/platform.h
index 7c0a4d7..fe2685a 100644
--- a/src/openvpn/platform.h
+++ b/src/openvpn/platform.h
@@ -130,7 +130,7 @@ int platform_putenv (char *string);
 FILE *platform_fopen (const char *path, const char *mode);
 int platform_open (const char *path, int flags, int mode);
 
-#ifdef WIN32
+#ifdef _WIN32
 typedef struct _stat platform_stat_t;
 #else
 typedef struct stat platform_stat_t;
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 542e5b1..2443438 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -175,7 +175,7 @@ plugin_option_list_print (const struct plugin_option_list *list, int msglevel)
 }
 #endif
 
-#ifndef WIN32
+#ifndef _WIN32
 
 static void
 libdl_resolve_symbol (void *handle, void **dest, const char *symbol, const char *plugin_name, const unsigned int flags)
@@ -206,7 +206,7 @@ plugin_init_item (struct plugin *p, const struct plugin_option *o)
   p->so_pathname = o->so_pathname;
   p->plugin_type_mask = plugin_supported_types ();
 
-#ifndef WIN32
+#ifndef _WIN32
 
   p->handle = NULL;
 #if defined(PLUGIN_LIBDIR)
@@ -519,10 +519,10 @@ plugin_close_item (struct plugin *p)
       if (p->plugin_handle)
 	(*p->close)(p->plugin_handle);
 
-#ifndef WIN32
+#ifndef _WIN32
       if (dlclose (p->handle))
 	msg (M_WARN, "PLUGIN_CLOSE: dlclose() failed on plugin: %s", p->so_pathname);
-#elif defined(WIN32)
+#elif defined(_WIN32)
       if (!FreeLibrary (p->module))
 	msg (M_WARN, "PLUGIN_CLOSE: FreeLibrary() failed on plugin: %s", p->so_pathname);
 #endif
diff --git a/src/openvpn/plugin.h b/src/openvpn/plugin.h
index 3c01047..b1e0458 100644
--- a/src/openvpn/plugin.h
+++ b/src/openvpn/plugin.h
@@ -59,7 +59,7 @@ struct plugin {
   unsigned int plugin_type_mask;
   int requested_initialization_point;
 
-#ifndef WIN32
+#ifndef _WIN32
   void *handle;
 #else
   HMODULE module;
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 3073666..09bdb15 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -49,7 +49,7 @@
 #include <linux/rtnetlink.h>		/* RTM_GETROUTE etc. */
 #endif
 
-#ifdef WIN32
+#ifdef _WIN32
 #include "openvpn-msg.h"
 
 #define METRIC_NOT_USED ((DWORD)-1)
@@ -807,7 +807,7 @@ init_route_ipv6_list (struct route_ipv6_list *rl6,
 	  if ( !(rl6->rgi6.flags & RGI_ON_LINK) )
 	    { r6->gateway = rl6->rgi6.gateway.addr_ipv6; }
 	  r6->metric = 1;
-#ifdef WIN32
+#ifdef _WIN32
 	  r6->adapter_index = rl6->rgi6.adapter_index;
 #else
 	  r6->iface = rl6->rgi6.iface;
@@ -1214,7 +1214,7 @@ print_default_gateway(const int msglevel,
 	buf_printf (&out, " %s", print_in_addr_t (rgi->gateway.addr, 0, &gc));
       if (rgi->flags & RGI_NETMASK_DEFINED)
 	buf_printf (&out, "/%s", print_in_addr_t (rgi->gateway.netmask, 0, &gc));
-#ifdef WIN32
+#ifdef _WIN32
       if (rgi->flags & RGI_IFACE_DEFINED)
 	buf_printf (&out, " I=%u", (unsigned int)rgi->adapter_index);
 #else
@@ -1235,7 +1235,7 @@ print_default_gateway(const int msglevel,
 	buf_printf (&out, " ON_LINK");
       if (rgi6->flags & RGI_NETMASK_DEFINED)
 	buf_printf (&out, "/%d", rgi6->gateway.netbits_ipv6);
-#ifdef WIN32
+#ifdef _WIN32
       if (rgi6->flags & RGI_IFACE_DEFINED)
 	buf_printf (&out, " I=%u", (unsigned int)rgi6->adapter_index);
 #else
@@ -1455,7 +1455,7 @@ add_route (struct route_ipv4 *r,
     buf_printf (&out, "%s %s %s", network, netmask, gateway);
   management_android_control (management, "ROUTE", buf_bptr(&out));
 
-#elif defined (WIN32)
+#elif defined (_WIN32)
   {
     DWORD ai = TUN_ADAPTER_INDEX_INVALID;
     argv_printf (&argv, "%s%sc ADD %s MASK %s %s",
@@ -1683,7 +1683,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
   if (! (r6->flags & RT_DEFINED) )
     return;
 
-#ifndef WIN32
+#ifndef _WIN32
   if ( r6->iface != NULL )		/* vpn server special route */
     {
       device = r6->iface;
@@ -1778,7 +1778,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
 
     management_android_control (management, "ROUTE6", buf_bptr(&out));
 
-#elif defined (WIN32)
+#elif defined (_WIN32)
 
   if (tt->options.msg_channel)
     status = add_route_ipv6_service (r6, tt);
@@ -1969,7 +1969,7 @@ delete_route (struct route_ipv4 *r,
   argv_msg (D_ROUTE, &argv);
   openvpn_execve_check (&argv, es, 0, "ERROR: Linux route delete command failed");
 
-#elif defined (WIN32)
+#elif defined (_WIN32)
   
   argv_printf (&argv, "%s%sc DELETE %s MASK %s %s",
 	       get_win_sys_path(),
@@ -2116,7 +2116,7 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
   if ((r6->flags & (RT_DEFINED|RT_ADDED)) != (RT_DEFINED|RT_ADDED))
     return;
 
-#ifndef WIN32
+#ifndef _WIN32
   if ( r6->iface != NULL )		/* vpn server special route */
     {
       device = r6->iface;
@@ -2190,7 +2190,7 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
   argv_msg (D_ROUTE, &argv);
   openvpn_execve_check (&argv, es, 0, "ERROR: Linux route -6/-A inet6 del command failed");
 
-#elif defined (WIN32)
+#elif defined (_WIN32)
 
   if (tt->options.msg_channel)
     del_route_ipv6_service (r6, tt);
@@ -2326,7 +2326,7 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
  * to get the current default gateway.
  */
 
-#if defined(WIN32)
+#if defined(_WIN32)
 
 static const MIB_IPFORWARDTABLE *
 get_windows_routing_table (struct gc_arena *gc)
@@ -3704,7 +3704,7 @@ int netmask_to_netbits2 (in_addr_t netmask)
  * so that outgoing packets to these servers don't end up in the tunnel.
  */
 
-#if defined(WIN32)
+#if defined(_WIN32)
 
 static void
 add_host_route_if_nonlocal (struct route_bypass *rb, const in_addr_t addr)
@@ -3778,7 +3778,7 @@ get_bypass_addresses (struct route_bypass *rb, const unsigned int flags)  /* PLA
  * Used by redirect-gateway autolocal feature
  */
 
-#if defined(WIN32)
+#if defined(_WIN32)
 
 int
 test_local_addr (const in_addr_t addr, const struct route_gateway_info *rgi)
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 58a5748..c358681 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -33,7 +33,7 @@
 #include "tun.h"
 #include "misc.h"
 
-#ifdef WIN32
+#ifdef _WIN32
 /*
  * Windows route methods
  */
@@ -130,7 +130,7 @@ struct route_ipv6 {
   struct in6_addr gateway;
   int metric;
   /* gateway interface */
-# ifdef WIN32
+# ifdef _WIN32
   DWORD adapter_index;		/* interface or ~0 if undefined */
 #else
   char * iface;			/* interface name (null terminated) */
@@ -153,7 +153,7 @@ struct route_gateway_info {
   unsigned int flags;
 
   /* gateway interface */
-# ifdef WIN32
+# ifdef _WIN32
   DWORD adapter_index;  /* interface or ~0 if undefined */
 #else
   char iface[16]; /* interface name (null terminated), may be empty */
@@ -181,7 +181,7 @@ struct route_ipv6_gateway_info {
   unsigned int flags;
 
   /* gateway interface */
-# ifdef WIN32
+# ifdef _WIN32
   DWORD adapter_index;  /* interface or ~0 if undefined */
 #else
   char iface[16]; /* interface name (null terminated), may be empty */
@@ -333,7 +333,7 @@ void print_route_options (const struct route_option_list *rol,
 
 void print_routes (const struct route_list *rl, int level);
 
-#ifdef WIN32
+#ifdef _WIN32
 
 void show_routes (int msglev);
 bool test_routes (const struct route_list *rl, const struct tuntap *tt);
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 718b786..0ff1437 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -221,7 +221,7 @@ static int signal_mode; /* GLOBAL */
 void
 pre_init_signal_catch (void)
 {
-#ifndef WIN32
+#ifndef _WIN32
 #ifdef HAVE_SIGNAL_H
   signal_mode = SM_PRE_INIT;
   signal (SIGINT, signal_handler);
@@ -231,13 +231,13 @@ pre_init_signal_catch (void)
   signal (SIGUSR2, SIG_IGN);
   signal (SIGPIPE, SIG_IGN);
 #endif /* HAVE_SIGNAL_H */
-#endif /* WIN32 */
+#endif /* _WIN32 */
 }
 
 void
 post_init_signal_catch (void)
 {
-#ifndef WIN32
+#ifndef _WIN32
 #ifdef HAVE_SIGNAL_H
   signal_mode = SM_POST_INIT;
   signal (SIGINT, signal_handler);
@@ -291,7 +291,7 @@ print_status (const struct context *c, struct status_output *so)
   status_printf (so, "Pre-encrypt truncations," counter_format, c->c2.n_trunc_pre_encrypt);
   status_printf (so, "Post-decrypt truncations," counter_format, c->c2.n_trunc_post_decrypt);
 #endif
-#ifdef WIN32
+#ifdef _WIN32
   if (tuntap_defined (c->c1.tuntap))
     status_printf (so, "TAP-WIN32 driver status,\"%s\"",
 	 tap_win_getinfo (c->c1.tuntap, &gc));
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index c2c7b54..2875a4c 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -79,7 +79,7 @@ void register_signal (struct context *c, int sig, const char *text);
 void process_explicit_exit_notification_timer_wakeup (struct context *c);
 #endif
 
-#ifdef WIN32
+#ifdef _WIN32
 
 static inline void
 get_signal (volatile int *sig)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 184c7ad..858cc2f 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -376,7 +376,7 @@ openvpn_getaddrinfo (unsigned int flags,
        */
       while (true)
         {
-#ifndef WIN32
+#ifndef _WIN32
 	  res_init ();
 #endif
           /* try hostname lookup */
@@ -690,7 +690,7 @@ socket_set_buffers (int fd, const struct socket_buffer_size *sbs)
 static bool
 socket_set_tcp_nodelay (int sd, int state)
 {
-#if defined(WIN32) || (defined(HAVE_SETSOCKOPT) && defined(IPPROTO_TCP) && defined(TCP_NODELAY))
+#if defined(_WIN32) || (defined(HAVE_SETSOCKOPT) && defined(IPPROTO_TCP) && defined(TCP_NODELAY))
   if (setsockopt (sd, IPPROTO_TCP, TCP_NODELAY, (void *) &state, sizeof (state)) != 0)
     {
       msg (M_WARN, "NOTE: setsockopt TCP_NODELAY=%d failed", state);
@@ -761,7 +761,7 @@ create_socket_tcp (struct addrinfo* addrinfo)
   if ((sd = socket (addrinfo->ai_family, addrinfo->ai_socktype, addrinfo->ai_protocol)) < 0)
     msg (M_ERR, "Cannot create TCP socket");
 
-#ifndef WIN32 /* using SO_REUSEADDR on Windows will cause bind to succeed on port conflicts! */
+#ifndef _WIN32 /* using SO_REUSEADDR on Windows will cause bind to succeed on port conflicts! */
   /* set SO_REUSEADDR on socket */
   {
     int on = 1;
@@ -1066,7 +1066,7 @@ socket_listen_accept (socket_descriptor_t sd,
 /* older mingw versions and WinXP do not have this define,
  * but Vista and up support the functionality - just define it here
  */
-#ifdef WIN32
+#ifdef _WIN32
 # ifndef IPV6_V6ONLY
 #  define IPV6_V6ONLY 27
 # endif
@@ -1141,7 +1141,7 @@ openvpn_connect (socket_descriptor_t sd,
   if (status)
     status = openvpn_errno ();
   if (
-#ifdef WIN32
+#ifdef _WIN32
     status == WSAEWOULDBLOCK
 #else
     status == EINPROGRESS
@@ -1184,7 +1184,7 @@ openvpn_connect (socket_descriptor_t sd,
 	    {
 	      if (--connect_timeout < 0)
 		{
-#ifdef WIN32
+#ifdef _WIN32
 		  status = WSAETIMEDOUT;
 #else
 		  status = ETIMEDOUT;
@@ -1296,7 +1296,7 @@ socket_connect (socket_descriptor_t* sd,
 static void
 socket_frame_init (const struct frame *frame, struct link_socket *sock)
 {
-#ifdef WIN32
+#ifdef _WIN32
   overlapped_io_init (&sock->reads, frame, FALSE, false);
   overlapped_io_init (&sock->writes, frame, TRUE, false);
   sock->rw_handle.read = sock->reads.overlapped.hEvent;
@@ -1305,7 +1305,7 @@ socket_frame_init (const struct frame *frame, struct link_socket *sock)
 
   if (link_socket_connection_oriented (sock))
     {
-#ifdef WIN32
+#ifdef _WIN32
       stream_buf_init (&sock->stream_buf,
 		       &sock->reads.buf_init,
 		       sock->sockflags,
@@ -1970,7 +1970,7 @@ link_socket_close (struct link_socket *sock)
 
       if (socket_defined (sock->sd))
 	{
-#ifdef WIN32
+#ifdef _WIN32
 	  close_net_event_win32 (&sock->listen_handle, sock->sd, 0);
 #endif
 	  if (!gremlin)
@@ -1980,7 +1980,7 @@ link_socket_close (struct link_socket *sock)
 		msg (M_WARN | M_ERRNO, "TCP/UDP: Close Socket failed");
 	    }
 	  sock->sd = SOCKET_UNDEFINED;
-#ifdef WIN32
+#ifdef _WIN32
 	  if (!gremlin)
 	    {
 	      overlapped_io_close (&sock->reads);
@@ -2174,7 +2174,7 @@ socket_stat (const struct link_socket *s, unsigned int rwflags, struct gc_arena
 	{
 	  buf_printf (&out, "S%s",
 		      (s->rwflags_debug & EVENT_READ) ? "R" : "r");
-#ifdef WIN32
+#ifdef _WIN32
 	  buf_printf (&out, "%s",
 		      overlapped_io_state_ascii (&s->reads));
 #endif
@@ -2183,7 +2183,7 @@ socket_stat (const struct link_socket *s, unsigned int rwflags, struct gc_arena
 	{
 	  buf_printf (&out, "S%s",
 		      (s->rwflags_debug & EVENT_WRITE) ? "W" : "w");
-#ifdef WIN32
+#ifdef _WIN32
 	  buf_printf (&out, "%s",
 		      overlapped_io_state_ascii (&s->writes));
 #endif
@@ -2358,7 +2358,7 @@ stream_buf_close (struct stream_buf* sb)
 event_t
 socket_listen_event_handle (struct link_socket *s)
 {
-#ifdef WIN32
+#ifdef _WIN32
   if (!defined_net_event_win32 (&s->listen_handle))
     init_net_event_win32 (&s->listen_handle, FD_ACCEPT, s->sd, 0);
   return &s->listen_handle;
@@ -2834,7 +2834,7 @@ link_socket_read_tcp (struct link_socket *sock,
 
   if (!sock->stream_buf.residual_fully_formed)
     {
-#ifdef WIN32
+#ifdef _WIN32
       len = socket_finalize (sock->sd, &sock->reads, buf, NULL);
 #else
       struct buffer frag;
@@ -2859,7 +2859,7 @@ link_socket_read_tcp (struct link_socket *sock,
     return buf->len = 0; /* no error, but packet is still incomplete */
 }
 
-#ifndef WIN32
+#ifndef _WIN32
 
 #if ENABLE_IP_PKTINFO
 
@@ -2980,7 +2980,7 @@ link_socket_write_tcp (struct link_socket *sock,
   ASSERT (len <= sock->stream_buf.maxlen);
   len = htonps (len);
   ASSERT (buf_write_prepend (buf, &len, sizeof (len)));
-#ifdef WIN32
+#ifdef _WIN32
   return link_socket_write_win32 (sock, buf, to);
 #else
   return link_socket_write_tcp_posix (sock, buf, to);  
@@ -3068,7 +3068,7 @@ link_socket_write_udp_posix_sendmsg (struct link_socket *sock,
  * Win32 overlapped socket I/O functions.
  */
 
-#ifdef WIN32
+#ifdef _WIN32
 
 int
 socket_recv_queue (struct link_socket *sock, int maxsize)
@@ -3376,7 +3376,7 @@ socket_finalize (SOCKET s,
 	    case sizeof(struct sockaddr_in):
 	    case sizeof(struct sockaddr_in6):
 	    /* TODO(jjo): for some reason (?) I'm getting 24,28 for AF_INET6
-	     * under WIN32*/
+	     * under _WIN32*/
 	    case sizeof(struct sockaddr_in6)-4:
 	      break;
 	    default:
@@ -3402,7 +3402,7 @@ socket_finalize (SOCKET s,
   return ret;
 }
 
-#endif /* WIN32 */
+#endif /* _WIN32 */
 
 /*
  * Socket event notification
@@ -3423,7 +3423,7 @@ socket_set (struct link_socket *s,
 	  rwflags &= ~EVENT_READ;
 	}
       
-#ifdef WIN32
+#ifdef _WIN32
       if (rwflags & EVENT_READ)
 	socket_recv_queue (s, 0);
 #endif
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index e1607f4..2a82d88 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -169,7 +169,7 @@ struct link_socket
   socket_descriptor_t sd;
   socket_descriptor_t ctrl_sd;  /* only used for UDP over Socks */
 
-#ifdef WIN32
+#ifdef _WIN32
   struct overlapped_io reads;
   struct overlapped_io writes;
   struct rw_handle rw_handle;
@@ -257,7 +257,7 @@ struct link_socket
 #define MSG_NOSIGNAL 0
 #endif
 
-#ifdef WIN32
+#ifdef _WIN32
 
 #define openvpn_close_socket(s) closesocket(s)
 
@@ -842,7 +842,7 @@ socket_connection_reset (const struct link_socket *sock, int status)
       else if (status < 0)
 	{
 	  const int err = openvpn_errno ();
-#ifdef WIN32
+#ifdef _WIN32
 	  return err == WSAECONNRESET || err == WSAECONNABORTED;
 #else
 	  return err == ECONNRESET;
@@ -950,7 +950,7 @@ stream_buf_read_setup (struct link_socket* sock)
 int link_socket_read_tcp (struct link_socket *sock,
 			  struct buffer *buf);
 
-#ifdef WIN32
+#ifdef _WIN32
 
 static inline int
 link_socket_read_udp_win32 (struct link_socket *sock,
@@ -978,7 +978,7 @@ link_socket_read (struct link_socket *sock,
     {
       int res;
 
-#ifdef WIN32
+#ifdef _WIN32
       res = link_socket_read_udp_win32 (sock, buf, from);
 #else
       res = link_socket_read_udp_posix (sock, buf, from);
@@ -1006,7 +1006,7 @@ int link_socket_write_tcp (struct link_socket *sock,
 			   struct buffer *buf,
 			   struct link_socket_actual *to);
 
-#ifdef WIN32
+#ifdef _WIN32
 
 static inline int
 link_socket_write_win32 (struct link_socket *sock,
@@ -1068,7 +1068,7 @@ link_socket_write_udp (struct link_socket *sock,
 		       struct buffer *buf,
 		       struct link_socket_actual *to)
 {
-#ifdef WIN32
+#ifdef _WIN32
   return link_socket_write_win32 (sock, buf, to);
 #else
   return link_socket_write_udp_posix (sock, buf, to);
@@ -1138,7 +1138,7 @@ socket_read_residual (const struct link_socket *s)
 static inline event_t
 socket_event_handle (const struct link_socket *s)
 {
-#ifdef WIN32
+#ifdef _WIN32
   return &s->rw_handle;
 #else
   return s->sd;
@@ -1169,7 +1169,7 @@ socket_set_listen_persistent (struct link_socket *s,
 static inline void
 socket_reset_listen_persistent (struct link_socket *s)
 {
-#ifdef WIN32
+#ifdef _WIN32
   reset_net_event_win32 (&s->listen_handle, s->sd);
 #endif
 }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index caf3b1f..559ea4a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1950,7 +1950,7 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
       buf_printf (&out, "IV_PLAT=freebsd\n");
 #elif defined(TARGET_ANDROID)
       buf_printf (&out, "IV_PLAT=android\n");
-#elif defined(WIN32)
+#elif defined(_WIN32)
       buf_printf (&out, "IV_PLAT=win\n");
 #endif
 
@@ -1980,7 +1980,7 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
 	  if (rgi.flags & RGI_HWADDR_DEFINED)
 	    buf_printf (&out, "IV_HWADDR=%s\n", format_hex_ex (rgi.hwaddr, 6, 0, 1, ":", &gc));
 	  buf_printf (&out, "IV_SSL=%s\n", get_ssl_library_version() );
-#if defined(WIN32)
+#if defined(_WIN32)
 	  buf_printf (&out, "IV_PLAT_VER=%s\n", win32_version_string (&gc, false));
 #endif
         }
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 542c373..6c104e1 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -230,7 +230,7 @@ int tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
  */
 #ifdef ENABLE_CRYPTOAPI
 void tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert);
-#endif /* WIN32 */
+#endif /* _WIN32 */
 
 /**
  * Load certificate file into the given TLS context. If the given certificate
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 8a761a4..3c88bfd 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -283,7 +283,7 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
 {
   msg(M_FATAL, "Windows CryptoAPI not yet supported for mbed TLS.");
 }
-#endif /* WIN32 */
+#endif /* _WIN32 */
 
 void
 tls_ctx_load_cert_file (struct tls_root_ctx *ctx, const char *cert_file,
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 8909ca3..6540422 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -633,7 +633,7 @@ tls_ctx_load_cryptoapi(struct tls_root_ctx *ctx, const char *cryptoapi_cert)
   if (!SSL_CTX_use_CryptoAPI_certificate (ctx->ctx, cryptoapi_cert))
     crypto_msg (M_FATAL, "Cannot load certificate \"%s\" from Microsoft Certificate Store", cryptoapi_cert);
 }
-#endif /* WIN32 */
+#endif /* _WIN32 */
 
 static void
 tls_ctx_add_extra_certs (struct tls_root_ctx *ctx, BIO *bio)
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index e969ccf..8de7d87 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -37,7 +37,7 @@
 # define unlikely(x)    (x)
 #endif
 
-#ifdef WIN32
+#ifdef _WIN32
 #include <windows.h>
 #include <winsock2.h>
 #define sleep(x) Sleep((x)*1000)
@@ -64,7 +64,7 @@
 # include <sys/wait.h>
 #endif
 
-#ifndef WIN32
+#ifndef _WIN32
 #ifndef WEXITSTATUS
 # define WEXITSTATUS(stat_val) ((unsigned)(stat_val) >> 8)
 #endif
@@ -358,7 +358,7 @@
 
 #endif /* TARGET_DARWIN */
 
-#ifdef WIN32
+#ifdef _WIN32
  // Missing declarations for MinGW 32.
  // #if !defined(__MINGW64_VERSION_MAJOR) || __MINGW64_VERSION_MAJOR < 2
  typedef int MIB_TCP_STATE;
@@ -405,7 +405,7 @@
 /*
  * Do we have nanoseconds gettimeofday?
  */
-#if defined(HAVE_GETTIMEOFDAY) || defined(WIN32)
+#if defined(HAVE_GETTIMEOFDAY) || defined(_WIN32)
 #define HAVE_GETTIMEOFDAY_NANOSECONDS 1
 #endif
 
@@ -470,26 +470,16 @@ typedef unsigned short sa_family_t;
 /*
  * Directory separation char
  */
-#ifdef WIN32
+#ifdef _WIN32
 #define OS_SPECIFIC_DIRSEP '\\'
 #else
 #define OS_SPECIFIC_DIRSEP '/'
 #endif
 
 /*
- * Define a boolean value based
- * on Win32 status.
- */
-#ifdef WIN32
-#define WIN32_0_1 1
-#else
-#define WIN32_0_1 0
-#endif
-
-/*
  * Our socket descriptor type.
  */
-#ifdef WIN32
+#ifdef _WIN32
 #define SOCKET_UNDEFINED (INVALID_SOCKET)
 typedef SOCKET socket_descriptor_t;
 #else
@@ -590,7 +580,7 @@ socket_defined (const socket_descriptor_t sd)
 /*
  * Do we support Unix domain sockets?
  */
-#if defined(PF_UNIX) && !defined(WIN32)
+#if defined(PF_UNIX) && !defined(_WIN32)
 #define UNIX_SOCK_SUPPORT 1
 #else
 #define UNIX_SOCK_SUPPORT 0
@@ -624,7 +614,7 @@ socket_defined (const socket_descriptor_t sd)
 /*
  * Do we have CryptoAPI capability?
  */
-#if defined(WIN32) && defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL)
+#if defined(_WIN32) && defined(ENABLE_CRYPTO) && defined(ENABLE_CRYPTO_OPENSSL)
 #define ENABLE_CRYPTOAPI
 #endif
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 1250547..8316200 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -49,13 +49,13 @@
 
 #include "memdbg.h"
 
-#ifdef WIN32
+#ifdef _WIN32
 #include "openvpn-msg.h"
 #endif
 
 #include <string.h>
 
-#ifdef WIN32
+#ifdef _WIN32
 
 /* #define SIMULATE_DHCP_FAILED */       /* simulate bad DHCP negotiation */
 
@@ -198,7 +198,7 @@ guess_tuntap_dev (const char *dev,
 		  const char *dev_node,
 		  struct gc_arena *gc)
 {
-#ifdef WIN32
+#ifdef _WIN32
   const int dt = dev_type_enum (dev, dev_type);
   if (dt == DEV_TYPE_TUN || dt == DEV_TYPE_TAP)
     {
@@ -421,7 +421,7 @@ tun_stat (const struct tuntap *tt, unsigned int rwflags, struct gc_arena *gc)
 	{
 	  buf_printf (&out, "T%s",
 		      (tt->rwflags_debug & EVENT_READ) ? "R" : "r");
-#ifdef WIN32
+#ifdef _WIN32
 	  buf_printf (&out, "%s",
 		      overlapped_io_state_ascii (&tt->reads));
 #endif
@@ -430,7 +430,7 @@ tun_stat (const struct tuntap *tt, unsigned int rwflags, struct gc_arena *gc)
 	{
 	  buf_printf (&out, "T%s",
 		      (tt->rwflags_debug & EVENT_WRITE) ? "W" : "w");
-#ifdef WIN32
+#ifdef _WIN32
 	  buf_printf (&out, "%s",
 		      overlapped_io_state_ascii (&tt->writes));
 #endif
@@ -611,7 +611,7 @@ init_tun (const char *dev,       /* --dev option */
 	  tt->broadcast = generate_ifconfig_broadcast_addr (tt->local, tt->remote_netmask);
 	}
 
-#ifdef WIN32
+#ifdef _WIN32
       /*
        * Make sure that both ifconfig addresses are part of the
        * same .252 subnet.
@@ -665,7 +665,7 @@ init_tun_post (struct tuntap *tt,
 	       const struct tuntap_options *options)
 {
   tt->options = *options;
-#ifdef WIN32
+#ifdef _WIN32
   overlapped_io_init (&tt->reads, frame, FALSE, true);
   overlapped_io_init (&tt->writes, frame, TRUE, true);
   tt->rw_handle.read = tt->reads.overlapped.hEvent;
@@ -674,7 +674,7 @@ init_tun_post (struct tuntap *tt,
 #endif
 }
 
-#if defined(WIN32) || \
+#if defined(_WIN32) || \
     defined(TARGET_DARWIN) || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD)
 
 /* some of the platforms will auto-add a "network route" pointing
@@ -1340,7 +1340,7 @@ do_ifconfig (struct tuntap *tt,
 	  }
 	env_set_destroy (aix_es);
       }
-#elif defined (WIN32)
+#elif defined (_WIN32)
       {
         ASSERT (actual != NULL);
 
@@ -1399,7 +1399,7 @@ static void
 clear_tuntap (struct tuntap *tuntap)
 {
   CLEAR (*tuntap);
-#ifdef WIN32
+#ifdef _WIN32
   tuntap->hand = NULL;
 #else
   tuntap->fd = -1;
@@ -1497,7 +1497,7 @@ read_tun_header (struct tuntap* tt, uint8_t *buf, int len)
 #endif
 
 
-#ifndef WIN32
+#ifndef _WIN32
 static void
 open_tun_generic (const char *dev, const char *dev_type, const char *dev_node,
 		  bool ipv6_explicitly_supported, bool dynamic,
@@ -3109,7 +3109,7 @@ read_tun (struct tuntap* tt, uint8_t *buf, int len)
     return read (tt->fd, buf, len);
 }
 
-#elif defined(WIN32)
+#elif defined(_WIN32)
 
 int
 tun_read_queue (struct tuntap *tt, int maxsize)
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 1ccf378..9a13735 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -25,7 +25,7 @@
 #ifndef TUN_H
 #define TUN_H
 
-#ifdef WIN32
+#ifdef _WIN32
 #include <winioctl.h>
 #include <tap-windows.h>
 #endif
@@ -38,7 +38,7 @@
 #include "proto.h"
 #include "misc.h"
 
-#if defined(WIN32) || defined(TARGET_ANDROID)
+#if defined(_WIN32) || defined(TARGET_ANDROID)
 
 #define TUN_ADAPTER_INDEX_INVALID ((DWORD)-1)
 
@@ -58,7 +58,7 @@ struct tuntap_options {
 # define IPW32_SET_N            5
   int ip_win32_type;
 
-#ifdef WIN32
+#ifdef _WIN32
   HANDLE msg_channel;
 #endif
 
@@ -159,7 +159,7 @@ struct tuntap
   struct in6_addr remote_ipv6;
   int netbits_ipv6;
 
-#ifdef WIN32
+#ifdef _WIN32
   HANDLE hand;
   struct overlapped_io reads;
   struct overlapped_io writes;
@@ -199,7 +199,7 @@ struct tuntap
 static inline bool
 tuntap_defined (const struct tuntap *tt)
 {
-#ifdef WIN32
+#ifdef _WIN32
   return tt && tt->hand != NULL;
 #else
   return tt && tt->fd >= 0;
@@ -300,7 +300,7 @@ ifconfig_order(void)
   return IFCONFIG_AFTER_TUN_OPEN;
 #elif defined(TARGET_NETBSD)
   return IFCONFIG_AFTER_TUN_OPEN;
-#elif defined(WIN32)
+#elif defined(_WIN32)
   return IFCONFIG_AFTER_TUN_OPEN;
 #elif defined(TARGET_ANDROID)
   return IFCONFIG_BEFORE_TUN_OPEN;
@@ -324,7 +324,7 @@ route_order(void)
 }
 
 
-#ifdef WIN32
+#ifdef _WIN32
 
 #define TUN_PASS_BUFFER
 
@@ -478,7 +478,7 @@ tun_standby (struct tuntap *tt)
 static inline event_t
 tun_event_handle (const struct tuntap *tt)
 {
-#ifdef WIN32
+#ifdef _WIN32
   return &tt->rw_handle;
 #else
   return tt->fd;
@@ -501,7 +501,7 @@ tun_set (struct tuntap *tt,
 	  if (persistent)
 	    *persistent = rwflags;
 	}
-#ifdef WIN32
+#ifdef _WIN32
       if (rwflags & EVENT_READ)
 	tun_read_queue (tt, 0);
 #endif
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index ad721cd..00bc7ac 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -35,7 +35,7 @@
 
 #include "syshead.h"
 
-#ifdef WIN32
+#ifdef _WIN32
 
 #include "buffer.h"
 #include "error.h"
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 619878f..11e42f4 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -22,7 +22,7 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-#ifdef WIN32
+#ifdef _WIN32
 #ifndef OPENVPN_WIN32_H
 #define OPENVPN_WIN32_H
 
-- 
1.9.1


