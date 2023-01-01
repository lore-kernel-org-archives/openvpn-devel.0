From: selva.nair@...277...
Date: Sun,  1 Jan 2023 16:51:05 -0500
Message-Id: <20230101215109.1521549-2-selva.nair@...277...>
In-Reply-To: <20230101215109.1521549-1-selva.nair@...277...>
References: <20230101215109.1521549-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/5] Preparing for better signal handling:
 some code refactoring
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

From: Selva Nair <selva.nair@...277...>

- Do not directly update signal_received: always use register_signal()
  throw_signal() or signal_reset().
  To facilitate this, register_signal() now takes c->sig as an argument
  instead of the context c itself, and sig_info struct is passed-in to
  functions that need to set a signal.

- openvpn_getaddrinfo() is updated in a following commit as it
  could benefit from some logic changes that we may or may not want
  to do.

No functional changes.

TODO:
(i)   update signal handling in openvpn_getaddrinfo
(ii)  enforce signal priority
(iii) fix signal handling on Windows
for 2.7?
(iv)  replace system-V signal with POSIX sigaction

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/dco_win.c | 11 +++++----
 src/openvpn/dco_win.h |  3 ++-
 src/openvpn/forward.c | 34 +++++++++++++--------------
 src/openvpn/init.c    | 13 ++++-------
 src/openvpn/multi.c   |  6 ++---
 src/openvpn/occ.c     |  3 +--
 src/openvpn/ping.c    |  6 ++---
 src/openvpn/proxy.c   |  7 +++---
 src/openvpn/proxy.h   |  2 +-
 src/openvpn/push.c    | 33 +++++++++++++-------------
 src/openvpn/sig.c     | 17 +++++++-------
 src/openvpn/sig.h     | 37 +++++++++++++++--------------
 src/openvpn/socket.c  | 54 +++++++++++++++++++++----------------------
 src/openvpn/socks.c   | 22 ++++++++++--------
 src/openvpn/socks.h   |  4 ++--
 src/openvpn/win32.c   |  3 +--
 16 files changed, 125 insertions(+), 130 deletions(-)

diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 0d0d7946..825b1cd3 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -106,8 +106,9 @@ dco_start_tun(struct tuntap *tt)
 }
 
 static void
-dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, volatile int *signal_received)
+dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, struct signal_info *sig_info)
 {
+    volatile int *signal_received = &sig_info->signal_received;
     /* GetOverlappedResultEx is available starting from Windows 8 */
     typedef BOOL (*get_overlapped_result_ex_t) (HANDLE, LPOVERLAPPED, LPDWORD, DWORD, BOOL);
     get_overlapped_result_ex_t get_overlapped_result_ex =
@@ -138,7 +139,7 @@ dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, volatile int *signa
         {
             /* dco reported connection error */
             msg(M_NONFATAL | M_ERRNO, "dco connect error");
-            *signal_received = SIGUSR1;
+            register_signal(sig_info, SIGUSR1, "dco-connect-error");
             return;
         }
 
@@ -153,13 +154,13 @@ dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, volatile int *signa
 
     /* we end up here when timeout occurs in userspace */
     msg(M_NONFATAL, "dco connect timeout");
-    *signal_received = SIGUSR1;
+    register_signal(sig_info, SIGUSR1, "dco-connect-timeout");
 }
 
 void
 dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_local,
                   struct addrinfo *bind, int timeout,
-                  volatile int *signal_received)
+                  struct signal_info *sig_info)
 {
     msg(D_DCO_DEBUG, "%s", __func__);
 
@@ -240,7 +241,7 @@ dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_local,
         }
         else
         {
-            dco_connect_wait(handle, &ov, timeout, signal_received);
+            dco_connect_wait(handle, &ov, timeout, sig_info);
         }
     }
 }
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index b3cdbbbd..bba7b340 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -26,6 +26,7 @@
 
 #include "buffer.h"
 #include "ovpn_dco_win.h"
+#include "sig.h"
 
 typedef OVPN_KEY_SLOT dco_key_slot_t;
 typedef OVPN_CIPHER_ALG dco_cipher_t;
@@ -42,7 +43,7 @@ create_dco_handle(const char *devname, struct gc_arena *gc);
 void
 dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_local,
                   struct addrinfo *bind, int timeout,
-                  volatile int *signal_received);
+                  struct signal_info *sig_info);
 
 void
 dco_start_tun(struct tuntap *tt);
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index af4ed05d..ae0512fc 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -82,13 +82,13 @@ static void
 check_tls_errors_co(struct context *c)
 {
     msg(D_STREAM_ERRORS, "Fatal TLS error (check_tls_errors_co), restarting");
-    register_signal(c, c->c2.tls_exit_signal, "tls-error"); /* SOFT-SIGUSR1 -- TLS error */
+    register_signal(c->sig, c->c2.tls_exit_signal, "tls-error"); /* SOFT-SIGUSR1 -- TLS error */
 }
 
 static void
 check_tls_errors_nco(struct context *c)
 {
-    register_signal(c, c->c2.tls_exit_signal, "tls-error"); /* SOFT-SIGUSR1 -- TLS error */
+    register_signal(c->sig, c->c2.tls_exit_signal, "tls-error"); /* SOFT-SIGUSR1 -- TLS error */
 }
 
 /*
@@ -155,7 +155,7 @@ check_dco_key_status(struct context *c)
     {
         /* Something bad happened. Kill the connection to
          * be able to recover. */
-        register_signal(c, SIGUSR1, "dco update keys error");
+        register_signal(c->sig, SIGUSR1, "dco update keys error");
     }
 }
 
@@ -199,7 +199,7 @@ check_tls(struct context *c)
             }
             else
             {
-                register_signal(c, SIGTERM, "auth-control-exit");
+                register_signal(c->sig, SIGTERM, "auth-control-exit");
             }
         }
 
@@ -351,7 +351,7 @@ check_connection_established(struct context *c)
         {
             if (!do_up(c, false, 0))
             {
-                register_signal(c, SIGUSR1, "connection initialisation failed");
+                register_signal(c->sig, SIGUSR1, "connection initialisation failed");
             }
         }
 
@@ -431,7 +431,7 @@ check_add_routes(struct context *c)
         {
             if (!tun_standby(c->c1.tuntap))
             {
-                register_signal(c, SIGHUP, "ip-fail");
+                register_signal(c->sig, SIGHUP, "ip-fail");
                 c->persist.restart_sleep_seconds = 10;
 #ifdef _WIN32
                 show_routes(M_INFO|M_NOPREFIX);
@@ -455,7 +455,7 @@ static void
 check_inactivity_timeout(struct context *c)
 {
     msg(M_INFO, "Inactivity timeout (--inactive), exiting");
-    register_signal(c, SIGTERM, "inactive");
+    register_signal(c->sig, SIGTERM, "inactive");
 }
 
 int
@@ -474,7 +474,7 @@ check_server_poll_timeout(struct context *c)
     if (!tls_initial_packet_received(c->c2.tls_multi))
     {
         msg(M_INFO, "Server poll timeout, restarting");
-        register_signal(c, SIGUSR1, "server_poll");
+        register_signal(c->sig, SIGUSR1, "server_poll");
         c->persist.restart_sleep_seconds = -1;
     }
 }
@@ -499,7 +499,7 @@ schedule_exit(struct context *c, const int n_seconds, const int signal)
 static void
 check_scheduled_exit(struct context *c)
 {
-    register_signal(c, c->c2.scheduled_exit_signal, "delayed-exit");
+    register_signal(c->sig, c->c2.scheduled_exit_signal, "delayed-exit");
 }
 
 /*
@@ -661,7 +661,7 @@ check_session_timeout(struct context *c)
                                  ETT_DEFAULT))
     {
         msg(M_INFO, "Session timeout, exiting");
-        register_signal(c, SIGTERM, "session-timeout");
+        register_signal(c->sig, SIGTERM, "session-timeout");
     }
 }
 
@@ -902,7 +902,7 @@ read_incoming_link(struct context *c)
             const struct buffer *fbuf = socket_foreign_protocol_head(c->c2.link_socket);
             const int sd = socket_foreign_protocol_sd(c->c2.link_socket);
             port_share_redirect(port_share, fbuf, sd);
-            register_signal(c, SIGTERM, "port-share-redirect");
+            register_signal(c->sig, SIGTERM, "port-share-redirect");
         }
         else
 #endif
@@ -915,7 +915,7 @@ read_incoming_link(struct context *c)
             }
             else
             {
-                register_signal(c, SIGUSR1, "connection-reset"); /* SOFT-SIGUSR1 -- TCP connection reset */
+                register_signal(c->sig, SIGUSR1, "connection-reset"); /* SOFT-SIGUSR1 -- TCP connection reset */
                 msg(D_STREAM_ERRORS, "Connection reset, restarting [%d]", status);
             }
         }
@@ -1067,7 +1067,7 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
         if (!decrypt_status && link_socket_connection_oriented(c->c2.link_socket))
         {
             /* decryption errors are fatal in TCP mode */
-            register_signal(c, SIGUSR1, "decryption-error"); /* SOFT-SIGUSR1 -- decryption error in TCP mode */
+            register_signal(c->sig, SIGUSR1, "decryption-error"); /* SOFT-SIGUSR1 -- decryption error in TCP mode */
             msg(D_STREAM_ERRORS, "Fatal decryption error (process_incoming_link), restarting");
         }
     }
@@ -1248,7 +1248,7 @@ read_incoming_tun(struct context *c)
         read_wintun(c->c1.tuntap, &c->c2.buf);
         if (c->c2.buf.len == -1)
         {
-            register_signal(c, SIGHUP, "tun-abort");
+            register_signal(c->sig, SIGHUP, "tun-abort");
             c->persist.restart_sleep_seconds = 1;
             msg(M_INFO, "Wintun read error, restarting");
             perf_pop();
@@ -1277,7 +1277,7 @@ read_incoming_tun(struct context *c)
     /* Was TUN/TAP interface stopped? */
     if (tuntap_stop(c->c2.buf.len))
     {
-        register_signal(c, SIGTERM, "tun-stop");
+        register_signal(c->sig, SIGTERM, "tun-stop");
         msg(M_INFO, "TUN/TAP interface has been stopped, exiting");
         perf_pop();
         return;
@@ -1286,7 +1286,7 @@ read_incoming_tun(struct context *c)
     /* Was TUN/TAP I/O operation aborted? */
     if (tuntap_abort(c->c2.buf.len))
     {
-        register_signal(c, SIGHUP, "tun-abort");
+        register_signal(c->sig, SIGHUP, "tun-abort");
         c->persist.restart_sleep_seconds = 10;
         msg(M_INFO, "TUN/TAP I/O operation aborted, restarting");
         perf_pop();
@@ -1845,7 +1845,7 @@ process_outgoing_link(struct context *c)
             && !tls_initial_packet_received(c->c2.tls_multi) && c->options.mode == MODE_POINT_TO_POINT)
         {
             msg(M_INFO, "Network unreachable, restarting");
-            register_signal(c, SIGUSR1, "network-unreachable");
+            register_signal(c->sig, SIGUSR1, "network-unreachable");
         }
     }
     else
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 3380ed9e..eec25acf 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2934,13 +2934,13 @@ do_init_crypto_tls_c1(struct context *c)
                 /* Intentional [[fallthrough]]; */
 
                 case AR_NOINTERACT:
-                    c->sig->signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- Password failure error */
+                    /* SOFT-SIGUSR1 -- Password failure error */
+                    register_signal(c->sig, SIGUSR1, "private-key-password-failure");
                     break;
 
                 default:
                     ASSERT(0);
             }
-            c->sig->signal_text = "private-key-password-failure";
             return;
         }
 
@@ -4229,9 +4229,7 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
     }
 
     /* signals caught here will abort */
-    c->sig->signal_received = 0;
-    c->sig->signal_text = NULL;
-    c->sig->source = SIG_SOURCE_SOFT;
+    signal_reset(c->sig);
 
     if (c->mode == CM_P2P)
     {
@@ -4733,7 +4731,7 @@ close_context(struct context *c, int sig, unsigned int flags)
 
     if (sig >= 0)
     {
-        c->sig->signal_received = sig;
+        register_signal(c->sig, sig, "close_context");
     }
 
     if (c->sig->signal_received == SIGUSR1)
@@ -4741,8 +4739,7 @@ close_context(struct context *c, int sig, unsigned int flags)
         if ((flags & CC_USR1_TO_HUP)
             || (c->sig->source == SIG_SOURCE_HARD && (flags & CC_HARD_USR1_TO_HUP)))
         {
-            c->sig->signal_received = SIGHUP;
-            c->sig->signal_text = "close_context usr1 to hup";
+            register_signal(c->sig, SIGHUP, "close_context usr1 to hup");
         }
     }
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 92e63dd2..c2254399 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2364,7 +2364,7 @@ multi_client_generate_tls_keys(struct context *c)
                                           get_link_socket_info(c)))
     {
         msg(D_TLS_ERRORS, "TLS Error: initializing data channel failed");
-        register_signal(c, SIGUSR1, "process-push-msg-failed");
+        register_signal(c->sig, SIGUSR1, "process-push-msg-failed");
         return false;
     }
 
@@ -3828,7 +3828,7 @@ multi_push_restart_schedule_exit(struct multi_context *m, bool next_server)
                        &m->deferred_shutdown_signal.wakeup,
                        compute_wakeup_sigma(&m->deferred_shutdown_signal.wakeup));
 
-    m->top.sig->signal_received = 0;
+    signal_reset(m->top.sig);
 }
 
 /*
@@ -3843,7 +3843,7 @@ multi_process_signal(struct multi_context *m)
         struct status_output *so = status_open(NULL, 0, M_INFO, NULL, 0);
         multi_print_status(m, so, m->status_file_version);
         status_close(so);
-        m->top.sig->signal_received = 0;
+        signal_reset(m->top.sig);
         return false;
     }
     else if (proto_is_dgram(m->top.options.ce.proto)
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index eb1f2fae..0b291756 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -431,8 +431,7 @@ process_received_occ_msg(struct context *c)
 
         case OCC_EXIT:
             dmsg(D_PACKET_CONTENT, "RECEIVED OCC_EXIT");
-            c->sig->signal_received = SIGUSR1;
-            c->sig->signal_text = "remote-exit";
+            register_signal(c->sig, SIGUSR1, "remote-exit");
             break;
     }
     c->c2.buf.len = 0; /* don't pass packet on */
diff --git a/src/openvpn/ping.c b/src/openvpn/ping.c
index 588723d0..cf1861a6 100644
--- a/src/openvpn/ping.c
+++ b/src/openvpn/ping.c
@@ -55,15 +55,13 @@ trigger_ping_timeout_signal(struct context *c)
         case PING_EXIT:
             msg(M_INFO, "%sInactivity timeout (--ping-exit), exiting",
                 format_common_name(c, &gc));
-            c->sig->signal_received = SIGTERM;
-            c->sig->signal_text = "ping-exit";
+            register_signal(c->sig, SIGTERM, "ping-exit");
             break;
 
         case PING_RESTART:
             msg(M_INFO, "%sInactivity timeout (--ping-restart), restarting",
                 format_common_name(c, &gc));
-            c->sig->signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- Ping Restart */
-            c->sig->signal_text = "ping-restart";
+            register_signal(c->sig, SIGUSR1, "ping-restart");
             break;
 
         default:
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 633caee0..91121f25 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -636,7 +636,7 @@ establish_http_proxy_passthru(struct http_proxy_info *p,
                               const char *port,          /* openvpn server port */
                               struct event_timeout *server_poll_timeout,
                               struct buffer *lookahead,
-                              volatile int *signal_received)
+                              struct signal_info *sig_info)
 {
     struct gc_arena gc = gc_new();
     char buf[512];
@@ -646,6 +646,7 @@ establish_http_proxy_passthru(struct http_proxy_info *p,
     int nparms;
     bool ret = false;
     bool processed = false;
+    volatile int *signal_received = &sig_info->signal_received;
 
     /* get user/pass if not previously given */
     if (p->auth_method == HTTP_AUTH_BASIC
@@ -1079,9 +1080,9 @@ done:
     return ret;
 
 error:
-    if (!*signal_received)
+    if (!sig_info->signal_received)
     {
-        *signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- HTTP proxy error */
+        register_signal(sig_info, SIGUSR1, "HTTP proxy error"); /* SOFT-SIGUSR1 -- HTTP proxy error */
     }
     gc_free(&gc);
     return ret;
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 9d719382..4fe2a08f 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -86,7 +86,7 @@ bool establish_http_proxy_passthru(struct http_proxy_info *p,
                                    const char *port,          /* openvpn server port */
                                    struct event_timeout *server_poll_timeout,
                                    struct buffer *lookahead,
-                                   volatile int *signal_received);
+                                   struct signal_info *sig_info);
 
 uint8_t *make_base64_string2(const uint8_t *str, int str_len, struct gc_arena *gc);
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index e765d2a9..9796da4e 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -74,8 +74,7 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
     if (authfail_extended && buf_string_match_head_str(&buf, "TEMP"))
     {
         parse_auth_failed_temp(&c->options, reason + strlen("TEMP"));
-        c->sig->signal_received = SIGUSR1;
-        c->sig->signal_text = "auth-temp-failure (server temporary reject)";
+        register_signal(c->sig, SIGUSR1, "auth-temp-failure (server temporary reject)");
     }
 
     /* Before checking how to react on AUTH_FAILED, first check if the
@@ -85,8 +84,8 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
      * identical for this scenario */
     else if (ssl_clean_auth_token())
     {
-        c->sig->signal_received = SIGUSR1;     /* SOFT-SIGUSR1 -- Auth failure error */
-        c->sig->signal_text = "auth-failure (auth-token)";
+        /* SOFT-SIGUSR1 -- Auth failure error */
+        register_signal(c->sig, SIGUSR1, "auth-failure (auth-token)");
         c->options.no_advance = true;
     }
     else
@@ -94,20 +93,21 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
         switch (auth_retry_get())
         {
             case AR_NONE:
-                c->sig->signal_received = SIGTERM;     /* SOFT-SIGTERM -- Auth failure error */
+                /* SOFT-SIGTERM -- Auth failure error */
+                register_signal(c->sig, SIGTERM, "auth-failure");
                 break;
 
             case AR_INTERACT:
                 ssl_purge_auth(false);
 
             case AR_NOINTERACT:
-                c->sig->signal_received = SIGUSR1;     /* SOFT-SIGUSR1 -- Auth failure error */
+                /* SOFT-SIGTUSR1 -- Auth failure error */
+                register_signal(c->sig, SIGUSR1, "auth-failure");
                 break;
 
             default:
                 ASSERT(0);
         }
-        c->sig->signal_text = "auth-failure";
     }
 #ifdef ENABLE_MANAGEMENT
     if (management)
@@ -171,14 +171,14 @@ server_pushed_signal(struct context *c, const struct buffer *buffer, const bool
         if (restart)
         {
             msg(D_STREAM_ERRORS, "Connection reset command was pushed by server ('%s')", m);
-            c->sig->signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- server-pushed connection reset */
-            c->sig->signal_text = "server-pushed-connection-reset";
+            /* SOFT-SIGUSR1 -- server-pushed connection reset */
+            register_signal(c->sig, SIGUSR1, "server-pushed-connection-reset");
         }
         else
         {
             msg(D_STREAM_ERRORS, "Halt command was pushed by server ('%s')", m);
-            c->sig->signal_received = SIGTERM; /* SOFT-SIGTERM -- server-pushed halt */
-            c->sig->signal_text = "server-pushed-halt";
+            /* SOFT-SIGTERM -- server-pushed halt */
+            register_signal(c->sig, SIGTERM, "server-pushed-halt");
         }
 #ifdef ENABLE_MANAGEMENT
         if (management)
@@ -210,13 +210,12 @@ receive_exit_message(struct context *c)
     }
     else
     {
-        c->sig->signal_received = SIGUSR1;
+        register_signal(c->sig, SIGUSR1, "remote-exit");
     }
-    c->sig->signal_text = "remote-exit";
 #ifdef ENABLE_MANAGEMENT
     if (management)
     {
-        management_notify(management, "info", c->sig->signal_text, "EXIT");
+        management_notify(management, "info", "remote-exit", "EXIT");
     }
 #endif
 }
@@ -527,7 +526,7 @@ incoming_push_message(struct context *c, const struct buffer *buffer)
     goto cleanup;
 
 error:
-    register_signal(c, SIGUSR1, "process-push-msg-failed");
+    register_signal(c->sig, SIGUSR1, "process-push-msg-failed");
 cleanup:
     gc_free(&gc);
 }
@@ -555,8 +554,8 @@ send_push_request(struct context *c)
     {
         msg(D_STREAM_ERRORS, "No reply from server to push requests in %ds",
             (int)(now - ks->established));
-        c->sig->signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- server-pushed connection reset */
-        c->sig->signal_text = "no-push-reply";
+        /* SOFT-SIGUSR1 -- server-pushed connection reset */
+        register_signal(c->sig, SIGUSR1, "no-push-reply");
         return false;
     }
 }
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 65cd25c6..e462b93e 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -115,7 +115,7 @@ throw_signal_soft(const int signum, const char *signal_text)
     siginfo_static.signal_text = signal_text;
 }
 
-static void
+void
 signal_reset(struct signal_info *si)
 {
     if (si)
@@ -374,8 +374,7 @@ process_explicit_exit_notification_timer_wakeup(struct context *c)
         if (now >= c->c2.explicit_exit_notification_time_wait + c->options.ce.explicit_exit_notification)
         {
             event_timeout_clear(&c->c2.explicit_exit_notification_interval);
-            c->sig->signal_received = SIGTERM;
-            c->sig->signal_text = "exit-with-notification";
+            register_signal(c->sig, SIGTERM, "exit-with-notification");
         }
         else if (!cc_exit_notify_enabled(c))
         {
@@ -393,7 +392,7 @@ remap_signal(struct context *c)
 {
     if (c->sig->signal_received == SIGUSR1 && c->options.remap_sigusr1)
     {
-        c->sig->signal_received = c->options.remap_sigusr1;
+        register_signal(c->sig, c->options.remap_sigusr1, c->sig->signal_text);
     }
 }
 
@@ -442,7 +441,7 @@ ignore_restart_signals(struct context *c)
         {
             msg(M_INFO, "Converting soft %s received during exit notification to SIGTERM",
                 signal_name(c->sig->signal_received, true));
-            register_signal(c, SIGTERM, "exit-with-notification");
+            register_signal(c->sig, SIGTERM, "exit-with-notification");
             ret = false;
         }
     }
@@ -471,11 +470,11 @@ process_signal(struct context *c)
 }
 
 void
-register_signal(struct context *c, int sig, const char *text)
+register_signal(struct signal_info *si, int sig, const char *text)
 {
-    if (c->sig->signal_received != SIGTERM)
+    if (si->signal_received != SIGTERM)
     {
-        c->sig->signal_received = sig;
+        si->signal_received = sig;
     }
-    c->sig->signal_text = text;
+    si->signal_text = text;
 }
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index 091f16b3..83adc543 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -27,8 +27,6 @@
 #include "status.h"
 #include "win32.h"
 
-
-
 #define SIG_SOURCE_SOFT 0
 #define SIG_SOURCE_HARD 1
 /* CONNECTION_FAILED is also a "soft" status,
@@ -79,41 +77,42 @@ void signal_restart_status(const struct signal_info *si);
 
 bool process_signal(struct context *c);
 
-void register_signal(struct context *c, int sig, const char *text);
+void register_signal(struct signal_info *si, int sig, const char *text);
 
 void process_explicit_exit_notification_timer_wakeup(struct context *c);
 
-#ifdef _WIN32
-
-static inline void
-get_signal(volatile int *sig)
-{
-    *sig = win32_signal_get(&win32_signal);
-}
+void signal_reset(struct signal_info *si);
 
 static inline void
 halt_non_edge_triggered_signals(void)
 {
+#ifdef _WIN32
     win32_signal_close(&win32_signal);
+#endif
 }
 
-#else  /* ifdef _WIN32 */
+/**
+ * Copy the global signal_received (if non-zero) to the passed-in argument sig.
+ * As the former is volatile, do not assign if sig and &signal_received are the
+ * same.  Even on windows signal_received is really volatile as it can change if
+ * a ctrl-C or ctrl-break is delivered. So use the same logic as above.
+ *
+ * Also, on windows always call win32_signal_get to pickup any signals simulated by
+ * key-board short cuts or the exit event.
+ */
 
 static inline void
 get_signal(volatile int *sig)
 {
+#ifdef _WIN32
+    const int i = win32_signal_get(&win32_signal);
+#else
     const int i = siginfo_static.signal_received;
-    if (i)
+#endif
+    if (i && sig != &siginfo_static.signal_received)
     {
         *sig = i;
     }
 }
 
-static inline void
-halt_non_edge_triggered_signals(void)
-{
-}
-
-#endif /* ifdef _WIN32 */
-
 #endif /* ifndef SIG_H */
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index c7ec0e06..273f378e 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1586,7 +1586,7 @@ socket_connect(socket_descriptor_t *sd,
 
         openvpn_close_socket(*sd);
         *sd = SOCKET_UNDEFINED;
-        sig_info->signal_received = SIGUSR1;
+        register_signal(sig_info, SIGUSR1, "connection-failed");
         sig_info->source = SIG_SOURCE_CONNECTION_FAILED;
     }
     else
@@ -1694,8 +1694,9 @@ static void
 resolve_remote(struct link_socket *sock,
                int phase,
                const char **remote_dynamic,
-               volatile int *signal_received)
+               struct signal_info *sig_info)
 {
+    volatile int *signal_received = sig_info ? &sig_info->signal_received : NULL;
     struct gc_arena gc = gc_new();
 
     /* resolve remote address if undefined */
@@ -1774,18 +1775,16 @@ resolve_remote(struct link_socket *sock,
                      signal_received ? *signal_received : -1,
                      status);
             }
-            if (signal_received)
+            if (signal_received && *signal_received)
             {
-                if (*signal_received)
-                {
-                    goto done;
-                }
+                goto done;
             }
             if (status!=0)
             {
                 if (signal_received)
                 {
-                    *signal_received = SIGUSR1;
+                    /* potential overwrite of signal */
+                    register_signal(sig_info, SIGUSR1, "socks-resolve-failure");
                 }
                 goto done;
             }
@@ -2002,8 +2001,9 @@ linksock_print_addr(struct link_socket *sock)
 
 static void
 phase2_tcp_server(struct link_socket *sock, const char *remote_dynamic,
-                  volatile int *signal_received)
+                  struct signal_info *sig_info)
 {
+    volatile int *signal_received = sig_info ? &sig_info->signal_received : NULL;
     switch (sock->mode)
     {
         case LS_MODE_DEFAULT:
@@ -2029,7 +2029,7 @@ phase2_tcp_server(struct link_socket *sock, const char *remote_dynamic,
                                         false);
             if (!socket_defined(sock->sd))
             {
-                *signal_received = SIGTERM;
+                register_signal(sig_info, SIGTERM, "socket-undefiled");
                 return;
             }
             tcp_connection_established(&sock->info.lsa->actual);
@@ -2065,7 +2065,7 @@ phase2_tcp_client(struct link_socket *sock, struct signal_info *sig_info)
                                                         sock->proxy_dest_port,
                                                         sock->server_poll_timeout,
                                                         &sock->stream_buf.residual,
-                                                        &sig_info->signal_received);
+                                                        sig_info);
         }
         else if (sock->socks_proxy)
         {
@@ -2073,7 +2073,7 @@ phase2_tcp_client(struct link_socket *sock, struct signal_info *sig_info)
                                            sock->sd,
                                            sock->proxy_dest_host,
                                            sock->proxy_dest_port,
-                                           &sig_info->signal_received);
+                                           sig_info);
         }
         if (proxy_retry)
         {
@@ -2102,7 +2102,7 @@ phase2_socks_client(struct link_socket *sock, struct signal_info *sig_info)
                                    sock->ctrl_sd,
                                    sock->sd,
                                    &sock->socks_relay.dest,
-                                   &sig_info->signal_received);
+                                   sig_info);
 
     if (sig_info->signal_received)
     {
@@ -2120,13 +2120,13 @@ phase2_socks_client(struct link_socket *sock, struct signal_info *sig_info)
         sock->info.lsa->remote_list = NULL;
     }
 
-    resolve_remote(sock, 1, NULL, &sig_info->signal_received);
+    resolve_remote(sock, 1, NULL, sig_info);
 }
 
 #if defined(_WIN32)
 static void
 create_socket_dco_win(struct context *c, struct link_socket *sock,
-                      volatile int *signal_received)
+                      struct signal_info *sig_info)
 {
     if (!c->c1.tuntap)
     {
@@ -2145,11 +2145,11 @@ create_socket_dco_win(struct context *c, struct link_socket *sock,
                       sock->info.lsa->current_remote,
                       sock->bind_local, sock->info.lsa->bind_local,
                       get_server_poll_remaining_time(sock->server_poll_timeout),
-                      signal_received);
+                      sig_info);
 
     sock->dco_installed = true;
 
-    if (*signal_received)
+    if (sig_info->signal_received)
     {
         return;
     }
@@ -2168,15 +2168,15 @@ link_socket_init_phase2(struct context *c)
     struct signal_info *sig_info = c->sig;
 
     const char *remote_dynamic = NULL;
-    int sig_save = 0;
+    struct signal_info sig_save = {0};
 
     ASSERT(sock);
     ASSERT(sig_info);
 
     if (sig_info->signal_received)
     {
-        sig_save = sig_info->signal_received;
-        sig_info->signal_received = 0;
+        sig_save = *sig_info;
+        signal_reset(sig_info);
     }
 
     /* initialize buffers */
@@ -2193,7 +2193,7 @@ link_socket_init_phase2(struct context *c)
     }
 
     /* Second chance to resolv/create socket */
-    resolve_remote(sock, 2, &remote_dynamic,  &sig_info->signal_received);
+    resolve_remote(sock, 2, &remote_dynamic,  sig_info);
 
     /* If a valid remote has been found, create the socket with its addrinfo */
     if (sock->info.lsa->current_remote)
@@ -2201,7 +2201,7 @@ link_socket_init_phase2(struct context *c)
 #if defined(_WIN32)
         if (dco_enabled(&c->options))
         {
-            create_socket_dco_win(c, sock, &sig_info->signal_received);
+            create_socket_dco_win(c, sock, sig_info);
             goto done;
         }
         else
@@ -2237,7 +2237,7 @@ link_socket_init_phase2(struct context *c)
     if (sock->sd == SOCKET_UNDEFINED)
     {
         msg(M_WARN, "Could not determine IPv4/IPv6 protocol");
-        sig_info->signal_received = SIGUSR1;
+        register_signal(sig_info, SIGUSR1, "Could not determine IPv4/IPv6 protocol");
         goto done;
     }
 
@@ -2248,8 +2248,7 @@ link_socket_init_phase2(struct context *c)
 
     if (sock->info.proto == PROTO_TCP_SERVER)
     {
-        phase2_tcp_server(sock, remote_dynamic,
-                          &sig_info->signal_received);
+        phase2_tcp_server(sock, remote_dynamic, sig_info);
     }
     else if (sock->info.proto == PROTO_TCP_CLIENT)
     {
@@ -2275,11 +2274,12 @@ link_socket_init_phase2(struct context *c)
     linksock_print_addr(sock);
 
 done:
-    if (sig_save)
+    if (sig_save.signal_received)
     {
+        /* This can potentially lose a saved high priority signal -- to be fixed */
         if (!sig_info->signal_received)
         {
-            sig_info->signal_received = sig_save;
+            register_signal(sig_info, sig_save.signal_received, sig_save.signal_text);
         }
     }
 }
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index ef178a35..b2ca3744 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -448,12 +448,12 @@ establish_socks_proxy_passthru(struct socks_proxy_info *p,
                                socket_descriptor_t sd,  /* already open to proxy */
                                const char *host,        /* openvpn server remote */
                                const char *servname,    /* openvpn server port */
-                               volatile int *signal_received)
+                               struct signal_info *sig_info)
 {
     char buf[270];
     size_t len;
 
-    if (!socks_handshake(p, sd, signal_received))
+    if (!socks_handshake(p, sd, &sig_info->signal_received))
     {
         goto error;
     }
@@ -491,7 +491,7 @@ establish_socks_proxy_passthru(struct socks_proxy_info *p,
 
 
     /* receive reply from Socks proxy and discard */
-    if (!recv_socks_reply(sd, NULL, signal_received))
+    if (!recv_socks_reply(sd, NULL, &sig_info->signal_received))
     {
         goto error;
     }
@@ -499,9 +499,10 @@ establish_socks_proxy_passthru(struct socks_proxy_info *p,
     return;
 
 error:
-    if (!*signal_received)
+    if (!sig_info->signal_received)
     {
-        *signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- socks error */
+        /* SOFT-SIGUSR1 -- socks error */
+        register_signal(sig_info, SIGUSR1, "socks-error");
     }
     return;
 }
@@ -511,9 +512,9 @@ establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
                                socket_descriptor_t ctrl_sd,  /* already open to proxy */
                                socket_descriptor_t udp_sd,
                                struct openvpn_sockaddr *relay_addr,
-                               volatile int *signal_received)
+                               struct signal_info *sig_info)
 {
-    if (!socks_handshake(p, ctrl_sd, signal_received))
+    if (!socks_handshake(p, ctrl_sd, &sig_info->signal_received))
     {
         goto error;
     }
@@ -534,7 +535,7 @@ establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
 
     /* receive reply from Socks proxy */
     CLEAR(*relay_addr);
-    if (!recv_socks_reply(ctrl_sd, relay_addr, signal_received))
+    if (!recv_socks_reply(ctrl_sd, relay_addr, &sig_info->signal_received))
     {
         goto error;
     }
@@ -542,9 +543,10 @@ establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
     return;
 
 error:
-    if (!*signal_received)
+    if (!sig_info->signal_received)
     {
-        *signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- socks error */
+        /* SOFT-SIGUSR1 -- socks error */
+        register_signal(sig_info, SIGUSR1, "socks-error");
     }
     return;
 }
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index 47cdac10..55c75c60 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -52,13 +52,13 @@ void establish_socks_proxy_passthru(struct socks_proxy_info *p,
                                     socket_descriptor_t sd,  /* already open to proxy */
                                     const char *host,        /* openvpn server remote */
                                     const char *servname,          /* openvpn server port */
-                                    volatile int *signal_received);
+                                    struct signal_info *sig_info);
 
 void establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
                                     socket_descriptor_t ctrl_sd,  /* already open to proxy */
                                     socket_descriptor_t udp_sd,
                                     struct openvpn_sockaddr *relay_addr,
-                                    volatile int *signal_received);
+                                    struct signal_info *sig_info);
 
 void socks_process_incoming_udp(struct buffer *buf,
                                 struct link_socket_actual *from);
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index cfe4dbde..c3520bca 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -682,8 +682,7 @@ win32_signal_get(struct win32_signal *ws)
         }
         if (ret)
         {
-            siginfo_static.signal_received = ret;
-            siginfo_static.source = SIG_SOURCE_HARD;
+            throw_signal(ret); /* this will update signinfo_static.signal received */
         }
     }
     return ret;
-- 
2.34.1


