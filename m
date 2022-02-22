From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 22 Feb 2022 05:14:24 +0200
Message-Id: <20220222031424.406-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Fix M_ERRNO behavior on Windows
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

We use M_ERRNO flag in logging to display error code
and error message. This has been broken on Windows,
where we use error code from GetLastError() and
error description from strerror(). strerror() expects
C runtime error code, which is quite different from
last error code from WinAPI call. As a result, we got
incorrect error description.

The ultimate fix would be introducing another flag
for WinAPI errors, like M_WINERR and use either that or
M_ERRNO depends on context. However, the change would be
quite intrusive and in some cases it is hard to say which
one to use without looking into internals.

Instead we stick to M_ERRNO and in Windows case we
first try to obtain error code from GetLastError() and
if it returns ERROR_SUCCESS (which is 0), we assume that
we have C runtime error and use errno. To get error
description we use strerror_win32() with GetLastError()
and strerror() with errno.

strerror_win32() uses FormatMessage() internally, which
is the right way to get WinAPI error description.

While on it, add a new flag M_SKERR to display socket
error. On Linux it is resolved into M_ERRNO and on Windows
to an conjunction of another new flag M_WSAERR and M_ERRNO.
With M_WSAERR we use WSAGetLastError() to get error code
and strerror_win32() to get error description.
WSAGetLastError() is a correct way to get WinSock error code,
according to documentation.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/error.c    | 26 ++++++++++++++++++++++----
 src/openvpn/error.h    | 11 ++++++++++-
 src/openvpn/manage.c   |  4 ++--
 src/openvpn/mtu.c      |  2 +-
 src/openvpn/platform.c |  2 +-
 src/openvpn/proxy.c    |  8 ++++----
 src/openvpn/ps.c       |  2 +-
 src/openvpn/socket.c   | 20 ++++++++++----------
 src/openvpn/socket.h   |  6 ++++++
 src/openvpn/socks.c    | 26 +++++++++++++-------------
 10 files changed, 70 insertions(+), 37 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index b0e9a48c..5da588d9 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -242,7 +242,25 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
         return;
     }
 
-    e = openvpn_errno();
+    bool use_strerr = false;
+#ifdef _WIN32
+    if (flags & M_WSAERR)
+    {
+        e = WSAGetLastError();
+    }
+    else
+    {
+        e = GetLastError();
+        if (e == ERROR_SUCCESS)
+        {
+            /* error is likely C runtime, fallback to errno/strerr */
+            use_strerr = true;
+            e = errno;
+        }
+    }
+#else
+    e = errno;
+#endif
 
     /*
      * Apply muting filter.
@@ -264,7 +282,7 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
     if ((flags & M_ERRNO) && e)
     {
         openvpn_snprintf(m2, ERR_BUF_SIZE, "%s: %s (errno=%d)",
-                         m1, strerror(e), e);
+                         m1, use_strerr ? strerror(e) : openvpn_strerror(e, &gc), e);
         SWAP;
     }
 
@@ -678,13 +696,13 @@ x_check_status(int status,
             {
                 msg(x_cs_info_level, "%s %s [%s]: %s (fd=%d,code=%d)", description,
                     sock ? proto2ascii(sock->info.proto, sock->info.af, true) : "",
-                    extended_msg, strerror(my_errno), sock ? sock->sd : -1, my_errno);
+                    extended_msg, openvpn_strerror(my_errno, &gc), sock ? sock->sd : -1, my_errno);
             }
             else
             {
                 msg(x_cs_info_level, "%s %s: %s (fd=%d,code=%d)", description,
                     sock ? proto2ascii(sock->info.proto, sock->info.af, true) : "",
-                    strerror(my_errno), sock ? sock->sd : -1, my_errno);
+                    openvpn_strerror(my_errno, &gc), sock ? sock->sd : -1, my_errno);
             }
 
             if (x_cs_err_delay_ms)
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index ad7defe8..9c3f4dfb 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -99,9 +99,18 @@ extern int x_msg_line_num;
 #define M_NONFATAL        (1<<5)         /* non-fatal error */
 #define M_WARN            (1<<6)         /* call syslog with LOG_WARNING */
 #define M_DEBUG           (1<<7)
-
 #define M_ERRNO           (1<<8)         /* show errno description */
 
+#ifdef _WIN32
+#define M_WSAERR          (1<<9)         /* WinSock errors */
+#endif
+
+#ifdef _WIN32
+#define M_SKERR           (M_ERRNO | M_WSAERR) /* socket errors */
+#else
+#define M_SKERR           M_ERRNO
+#endif
+
 #define M_NOMUTE          (1<<11)        /* don't do mute processing */
 #define M_NOPREFIX        (1<<12)        /* don't show date/time prefix */
 #define M_USAGE_SMALL     (1<<13)        /* fatal options error, call usage_small */
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 496042a6..2fa508ef 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1890,13 +1890,13 @@ man_connect(struct management *man)
 #if UNIX_SOCK_SUPPORT
         if (man->settings.flags & MF_UNIX_SOCK)
         {
-            msg(D_LINK_ERRORS | M_ERRNO,
+            msg(D_LINK_ERRORS | M_SKERR,
                 "MANAGEMENT: connect to unix socket %s failed",
                 sockaddr_unix_name(&man->settings.local_unix, "NULL"));
         }
         else
 #endif
-        msg(D_LINK_ERRORS | M_ERRNO,
+        msg(D_LINK_ERRORS | M_SKERR,
             "MANAGEMENT: connect to %s failed",
             print_sockaddr(man->settings.local->ai_addr, &gc));
         throw_signal_soft(SIGTERM, "management-connect-failed");
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index aa810f1c..45398953 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -407,7 +407,7 @@ set_sock_extended_error_passing(int sd)
     int on = 1;
     if (setsockopt(sd, SOL_IP, IP_RECVERR, (void *) &on, sizeof(on)))
     {
-        msg(M_WARN | M_ERRNO,
+        msg(M_WARN | M_SKERR,
             "Note: enable extended error passing on TCP/UDP socket failed (IP_RECVERR)");
     }
 }
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 450f28ba..1aafd604 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -532,7 +532,7 @@ platform_test_file(const char *filename)
         }
         else
         {
-            if (openvpn_errno() == EACCES)
+            if (errno == EACCES)
             {
                 msg( M_WARN | M_ERRNO, "Could not access file '%s'", filename);
             }
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index ed720161..409bc4af 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -110,7 +110,7 @@ recv_line(socket_descriptor_t sd,
         {
             if (verbose)
             {
-                msg(D_LINK_ERRORS | M_ERRNO, "recv_line: TCP port read timeout expired");
+                msg(D_LINK_ERRORS | M_SKERR, "recv_line: TCP port read timeout expired");
             }
             goto error;
         }
@@ -120,7 +120,7 @@ recv_line(socket_descriptor_t sd,
         {
             if (verbose)
             {
-                msg(D_LINK_ERRORS | M_ERRNO, "recv_line: TCP port read failed on select()");
+                msg(D_LINK_ERRORS | M_SKERR, "recv_line: TCP port read failed on select()");
             }
             goto error;
         }
@@ -133,7 +133,7 @@ recv_line(socket_descriptor_t sd,
         {
             if (verbose)
             {
-                msg(D_LINK_ERRORS | M_ERRNO, "recv_line: TCP port read failed on recv()");
+                msg(D_LINK_ERRORS | M_SKERR, "recv_line: TCP port read failed on recv()");
             }
             goto error;
         }
@@ -199,7 +199,7 @@ send_line(socket_descriptor_t sd,
     const ssize_t size = send(sd, buf, strlen(buf), MSG_NOSIGNAL);
     if (size != (ssize_t) strlen(buf))
     {
-        msg(D_LINK_ERRORS | M_ERRNO, "send_line: TCP port write failed on send()");
+        msg(D_LINK_ERRORS | M_SKERR, "send_line: TCP port write failed on send()");
         return false;
     }
     return true;
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 9dca53c8..64cc1ed3 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -429,7 +429,7 @@ proxy_entry_new(struct proxy_connection **list,
     /* connect to port share server */
     if ((sd_server = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP)) < 0)
     {
-        msg(M_WARN|M_ERRNO, "PORT SHARE PROXY: cannot create socket");
+        msg(M_WARN|M_SKERR, "PORT SHARE PROXY: cannot create socket");
         return false;
     }
     status = openvpn_connect(sd_server,(const struct sockaddr *)  &server_addr, 5, NULL);
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 0f34a5de..acfcfd65 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1143,7 +1143,7 @@ create_socket(struct link_socket *sock, struct addrinfo *addr)
         msg(M_INFO, "Using bind-dev %s", sock->bind_dev);
         if (setsockopt(sock->sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_dev, strlen(sock->bind_dev) + 1) != 0)
         {
-            msg(M_WARN|M_ERRNO, "WARN: setsockopt SO_BINDTODEVICE=%s failed", sock->bind_dev);
+            msg(M_WARN|M_SKERR, "WARN: setsockopt SO_BINDTODEVICE=%s failed", sock->bind_dev);
         }
 
     }
@@ -1222,7 +1222,7 @@ socket_do_accept(socket_descriptor_t sd,
 
         if (!socket_defined(new_sd))
         {
-            msg(D_LINK_ERRORS | M_ERRNO, "TCP: getpeername() failed");
+            msg(D_LINK_ERRORS | M_SKERR, "TCP: getpeername() failed");
         }
         else
         {
@@ -1247,7 +1247,7 @@ socket_do_accept(socket_descriptor_t sd,
 
     if (!socket_defined(new_sd))
     {
-        msg(D_LINK_ERRORS | M_ERRNO, "TCP: accept(%d) failed", (int)sd);
+        msg(D_LINK_ERRORS | M_SKERR, "TCP: accept(%d) failed", (int)sd);
     }
     /* only valid if we have remote_len_af!=0 */
     else if (remote_len_af && remote_len != remote_len_af)
@@ -1313,7 +1313,7 @@ socket_listen_accept(socket_descriptor_t sd,
 
         if (status < 0)
         {
-            msg(D_LINK_ERRORS | M_ERRNO, "TCP: select() failed");
+            msg(D_LINK_ERRORS | M_SKERR, "TCP: select() failed");
         }
 
         if (status <= 0)
@@ -1409,12 +1409,12 @@ socket_bind(socket_descriptor_t sd,
         msg(M_INFO, "setsockopt(IPV6_V6ONLY=%d)", v6only);
         if (setsockopt(sd, IPPROTO_IPV6, IPV6_V6ONLY, (void *) &v6only, sizeof(v6only)))
         {
-            msg(M_NONFATAL|M_ERRNO, "Setting IPV6_V6ONLY=%d failed", v6only);
+            msg(M_NONFATAL | M_SKERR, "Setting IPV6_V6ONLY=%d failed", v6only);
         }
     }
     if (bind(sd, cur->ai_addr, cur->ai_addrlen))
     {
-        msg(M_FATAL | M_ERRNO, "%s: Socket bind failed on local address %s",
+        msg(M_FATAL | M_SKERR, "%s: Socket bind failed on local address %s",
             prefix,
             print_sockaddr_ex(local->ai_addr, ":", PS_SHOW_PORT, &gc));
     }
@@ -2254,7 +2254,7 @@ link_socket_close(struct link_socket *sock)
                 msg(D_LOW, "TCP/UDP: Closing socket");
                 if (openvpn_close_socket(sock->sd))
                 {
-                    msg(M_WARN | M_ERRNO, "TCP/UDP: Close Socket failed");
+                    msg(M_WARN | M_SKERR, "TCP/UDP: Close Socket failed");
                 }
             }
             sock->sd = SOCKET_UNDEFINED;
@@ -2271,7 +2271,7 @@ link_socket_close(struct link_socket *sock)
         {
             if (openvpn_close_socket(sock->ctrl_sd))
             {
-                msg(M_WARN | M_ERRNO, "TCP/UDP: Close Socket (ctrl_sd) failed");
+                msg(M_WARN | M_SKERR, "TCP/UDP: Close Socket (ctrl_sd) failed");
             }
             sock->ctrl_sd = SOCKET_UNDEFINED;
         }
@@ -3668,7 +3668,7 @@ sockethandle_finalize(sockethandle_t sh,
                     /* if no error (i.e. just not finished yet), then DON'T execute this code */
                     io->iostate = IOSTATE_INITIAL;
                     ASSERT(ResetEvent(io->overlapped.hEvent));
-                    msg(D_WIN32_IO | M_ERRNO, "WIN32 I/O: Completion error");
+                    msg(D_WIN32_IO | SocketHandleErrorFlag(sh), "WIN32 I/O: Completion error");
                 }
             }
             break;
@@ -3681,7 +3681,7 @@ sockethandle_finalize(sockethandle_t sh,
                 /* error return for a non-queued operation */
                 SocketHandleSetLastError(sh, io->status);
                 ret = -1;
-                msg(D_WIN32_IO | M_ERRNO, "WIN32 I/O: Completion non-queued error");
+                msg(D_WIN32_IO | SocketHandleErrorFlag(sh), "WIN32 I/O: Completion non-queued error");
             }
             else
             {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index e9f1524d..a7ec827a 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -301,6 +301,12 @@ SocketHandleSetInvalError(sockethandle_t sh)
     sh.is_handle ? SetLastError(ERROR_INVALID_FUNCTION) : WSASetLastError(WSAEINVAL);
 }
 
+static inline int
+SocketHandleErrorFlag(sockethandle_t sh)
+{
+    return sh.is_handle ? M_ERRNO : M_SKERR;
+}
+
 #else  /* ifdef _WIN32 */
 
 #define openvpn_close_socket(s) close(s)
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 768bb613..10107c18 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -117,7 +117,7 @@ socks_username_password_auth(struct socks_proxy_info *p,
 
     if (size != strlen(to_send))
     {
-        msg(D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth: TCP port write failed on send()");
+        msg(D_LINK_ERRORS | M_SKERR, "socks_username_password_auth: TCP port write failed on send()");
         goto cleanup;
     }
 
@@ -145,14 +145,14 @@ socks_username_password_auth(struct socks_proxy_info *p,
         /* timeout? */
         if (status == 0)
         {
-            msg(D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth: TCP port read timeout expired");
+            msg(D_LINK_ERRORS | M_SKERR, "socks_username_password_auth: TCP port read timeout expired");
             goto cleanup;
         }
 
         /* error */
         if (status < 0)
         {
-            msg(D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth: TCP port read failed on select()");
+            msg(D_LINK_ERRORS | M_SKERR, "socks_username_password_auth: TCP port read failed on select()");
             goto cleanup;
         }
 
@@ -162,7 +162,7 @@ socks_username_password_auth(struct socks_proxy_info *p,
         /* error? */
         if (size != 1)
         {
-            msg(D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth: TCP port read failed on recv()");
+            msg(D_LINK_ERRORS | M_SKERR, "socks_username_password_auth: TCP port read failed on recv()");
             goto cleanup;
         }
 
@@ -204,7 +204,7 @@ socks_handshake(struct socks_proxy_info *p,
     size = send(sd, method_sel, sizeof(method_sel), MSG_NOSIGNAL);
     if (size != sizeof(method_sel))
     {
-        msg(D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port write failed on send()");
+        msg(D_LINK_ERRORS | M_SKERR, "socks_handshake: TCP port write failed on send()");
         return false;
     }
 
@@ -232,14 +232,14 @@ socks_handshake(struct socks_proxy_info *p,
         /* timeout? */
         if (status == 0)
         {
-            msg(D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port read timeout expired");
+            msg(D_LINK_ERRORS | M_SKERR, "socks_handshake: TCP port read timeout expired");
             return false;
         }
 
         /* error */
         if (status < 0)
         {
-            msg(D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port read failed on select()");
+            msg(D_LINK_ERRORS | M_SKERR, "socks_handshake: TCP port read failed on select()");
             return false;
         }
 
@@ -249,7 +249,7 @@ socks_handshake(struct socks_proxy_info *p,
         /* error? */
         if (size != 1)
         {
-            msg(D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port read failed on recv()");
+            msg(D_LINK_ERRORS | M_SKERR, "socks_handshake: TCP port read failed on recv()");
             return false;
         }
 
@@ -342,14 +342,14 @@ recv_socks_reply(socket_descriptor_t sd,
         /* timeout? */
         if (status == 0)
         {
-            msg(D_LINK_ERRORS | M_ERRNO, "recv_socks_reply: TCP port read timeout expired");
+            msg(D_LINK_ERRORS | M_SKERR, "recv_socks_reply: TCP port read timeout expired");
             return false;
         }
 
         /* error */
         if (status < 0)
         {
-            msg(D_LINK_ERRORS | M_ERRNO, "recv_socks_reply: TCP port read failed on select()");
+            msg(D_LINK_ERRORS | M_SKERR, "recv_socks_reply: TCP port read failed on select()");
             return false;
         }
 
@@ -359,7 +359,7 @@ recv_socks_reply(socket_descriptor_t sd,
         /* error? */
         if (size != 1)
         {
-            msg(D_LINK_ERRORS | M_ERRNO, "recv_socks_reply: TCP port read failed on recv()");
+            msg(D_LINK_ERRORS | M_SKERR, "recv_socks_reply: TCP port read failed on recv()");
             return false;
         }
 
@@ -484,7 +484,7 @@ establish_socks_proxy_passthru(struct socks_proxy_info *p,
         const ssize_t size = send(sd, buf, 5 + len + 2, MSG_NOSIGNAL);
         if ((int)size != 5 + (int)len + 2)
         {
-            msg(D_LINK_ERRORS | M_ERRNO, "establish_socks_proxy_passthru: TCP port write failed on send()");
+            msg(D_LINK_ERRORS | M_SKERR, "establish_socks_proxy_passthru: TCP port write failed on send()");
             goto error;
         }
     }
@@ -527,7 +527,7 @@ establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
                                   10, MSG_NOSIGNAL);
         if (size != 10)
         {
-            msg(D_LINK_ERRORS | M_ERRNO, "establish_socks_proxy_passthru: TCP port write failed on send()");
+            msg(D_LINK_ERRORS | M_SKERR, "establish_socks_proxy_passthru: TCP port write failed on send()");
             goto error;
         }
     }
-- 
2.23.0.windows.1


