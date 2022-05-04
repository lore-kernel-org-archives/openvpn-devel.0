From: Lev Stipakov <lstipakov@...277...>
Date: Wed,  4 May 2022 12:13:05 +0300
Message-Id: <20220504091305.434-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH release/2.5] Fix M_ERRNO behavior on Windows
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
---

 This is a backport of patch acked for master
(https://patchwork.openvpn.net/patch/2429/) with
a conflict resolved in x_check_status() in error.c.

 src/openvpn/error.c    | 32 +++++++++++++++++++++++++-------
 src/openvpn/error.h    | 39 +++++++++++++++++++++++++++++----------
 src/openvpn/forward.c  |  9 ++++++++-
 src/openvpn/manage.c   |  5 +++--
 src/openvpn/platform.c |  2 +-
 src/openvpn/tun.h      |  4 ++--
 6 files changed, 68 insertions(+), 23 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 54796d03..7fbda844 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -220,6 +220,18 @@ x_msg(const unsigned int flags, const char *format, ...)
     va_end(arglist);
 }
 
+static const char*
+openvpn_strerror(int err, bool crt_error, struct gc_arena *gc)
+{
+#ifdef _WIN32
+    if (!crt_error)
+    {
+        return strerror_win32(err, gc);
+    }
+#endif
+    return strerror(err);
+}
+
 void
 x_msg_va(const unsigned int flags, const char *format, va_list arglist)
 {
@@ -244,7 +256,8 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
     }
 #endif
 
-    e = openvpn_errno();
+    bool crt_error = false;
+    e = openvpn_errno_maybe_crt(&crt_error);
 
     /*
      * Apply muting filter.
@@ -268,7 +281,7 @@ x_msg_va(const unsigned int flags, const char *format, va_list arglist)
     if ((flags & M_ERRNO) && e)
     {
         openvpn_snprintf(m2, ERR_BUF_SIZE, "%s: %s (errno=%d)",
-                         m1, strerror(e), e);
+                         m1, openvpn_strerror(e, crt_error, &gc), e);
         SWAP;
     }
 
@@ -649,7 +662,6 @@ x_check_status(int status,
                struct link_socket *sock,
                struct tuntap *tt)
 {
-    const int my_errno = openvpn_errno();
     const char *extended_msg = NULL;
 
     msg(x_cs_verbose_level, "%s %s returned %d",
@@ -672,26 +684,32 @@ x_check_status(int status,
                 sock->info.mtu_changed = true;
             }
         }
-#elif defined(_WIN32)
+#endif /* EXTENDED_SOCKET_ERROR_CAPABILITY */
+
+#ifdef _WIN32
         /* get possible driver error from TAP-Windows driver */
         if (tuntap_defined(tt))
         {
             extended_msg = tap_win_getinfo(tt, &gc);
         }
 #endif
-        if (!ignore_sys_error(my_errno))
+
+        bool crt_error = false;
+        int my_errno = openvpn_errno_maybe_crt(&crt_error);
+
+        if (!ignore_sys_error(my_errno, crt_error))
         {
             if (extended_msg)
             {
                 msg(x_cs_info_level, "%s %s [%s]: %s (code=%d)", description,
                     sock ? proto2ascii(sock->info.proto, sock->info.af, true) : "",
-                    extended_msg, strerror(my_errno), my_errno);
+                    extended_msg, openvpn_strerror(my_errno, crt_error, &gc), my_errno);
             }
             else
             {
                 msg(x_cs_info_level, "%s %s: %s (code=%d)", description,
                     sock ? proto2ascii(sock->info.proto, sock->info.af, true) : "",
-                    strerror(my_errno), my_errno);
+                    openvpn_strerror(my_errno, crt_error, &gc), my_errno);
             }
 
             if (x_cs_err_delay_ms)
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index d2d83c8a..fc878a56 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -71,13 +71,10 @@ struct gc_arena;
 /* String and Error functions */
 
 #ifdef _WIN32
-#define openvpn_errno()             GetLastError()
-#define openvpn_strerror(e, gc)     strerror_win32(e, gc)
+#define openvpn_errno() GetLastError()
 const char *strerror_win32(DWORD errnum, struct gc_arena *gc);
-
 #else
-#define openvpn_errno()             errno
-#define openvpn_strerror(x, gc)     strerror(x)
+#define openvpn_errno() errno
 #endif
 
 /*
@@ -363,20 +360,22 @@ msg_get_virtual_output(void)
  * which can be safely ignored.
  */
 static inline bool
-ignore_sys_error(const int err)
+ignore_sys_error(const int err, bool crt_error)
 {
-    /* I/O operation pending */
 #ifdef _WIN32
-    if (err == WSAEWOULDBLOCK || err == WSAEINVAL)
+    if (!crt_error && ((err == WSAEWOULDBLOCK || err == WSAEINVAL)))
     {
         return true;
     }
 #else
-    if (err == EAGAIN)
+    crt_error = true;
+#endif
+
+    /* I/O operation pending */
+    if (crt_error && (err == EAGAIN))
     {
         return true;
     }
-#endif
 
 #if 0 /* if enabled, suppress ENOBUFS errors */
 #ifdef ENOBUFS
@@ -398,6 +397,26 @@ nonfatal(const unsigned int err)
     return err & M_FATAL ? (err ^ M_FATAL) | M_NONFATAL : err;
 }
 
+static inline int
+openvpn_errno_maybe_crt(bool *crt_error)
+{
+    int err = 0;
+    *crt_error = false;
+#ifdef _WIN32
+    err = GetLastError();
+    if (err == ERROR_SUCCESS)
+    {
+        /* error is likely C runtime */
+        *crt_error = true;
+        err = errno;
+    }
+#else
+    *crt_error = true;
+    err = errno;
+#endif
+    return err;
+}
+
 #include "errlevel.h"
 
 #endif /* ifndef ERROR_H */
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 392a5c9f..de80dcff 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1676,7 +1676,14 @@ process_outgoing_link(struct context *c)
         }
 
         /* for unreachable network and "connecting" state switch to the next host */
-        if (size < 0 && ENETUNREACH == error_code && c->c2.tls_multi
+
+        bool unreachable = error_code ==
+#ifdef _WIN32
+            WSAENETUNREACH;
+#else
+            ENETUNREACH;
+#endif
+        if (size < 0 && unreachable && c->c2.tls_multi
             && !tls_initial_packet_received(c->c2.tls_multi) && c->options.mode == MODE_POINT_TO_POINT)
         {
             msg(M_INFO, "Network unreachable, restarting");
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index a4264056..8d2d9983 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2082,9 +2082,10 @@ man_process_command(struct management *man, const char *line)
 static bool
 man_io_error(struct management *man, const char *prefix)
 {
-    const int err = openvpn_errno();
+    bool crt_error = false;
+    int err = openvpn_errno_maybe_crt(&crt_error);
 
-    if (!ignore_sys_error(err))
+    if (!ignore_sys_error(err, crt_error))
     {
         struct gc_arena gc = gc_new();
         msg(D_MANAGEMENT, "MANAGEMENT: TCP %s error: %s", prefix,
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 2604c27b..4921f035 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -471,7 +471,7 @@ platform_test_file(const char *filename)
         }
         else
         {
-            if (openvpn_errno() == EACCES)
+            if (errno == EACCES)
             {
                 msg( M_WARN | M_ERRNO, "Could not access file '%s'", filename);
             }
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index ea19620d..ae98966b 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -461,7 +461,7 @@ tuntap_stop(int status)
      */
     if (status < 0)
     {
-        return openvpn_errno() == ERROR_FILE_NOT_FOUND;
+        return GetLastError() == ERROR_FILE_NOT_FOUND;
     }
     return false;
 }
@@ -474,7 +474,7 @@ tuntap_abort(int status)
      */
     if (status < 0)
     {
-        return openvpn_errno() == ERROR_OPERATION_ABORTED;
+        return GetLastError() == ERROR_OPERATION_ABORTED;
     }
     return false;
 }
-- 
2.23.0.windows.1


