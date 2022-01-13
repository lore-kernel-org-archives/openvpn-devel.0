From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 13 Jan 2022 23:52:26 +0200
Message-Id: <20220113215226.161-1-lstipakov@...277...>
In-Reply-To: <222922b3-377a-3eab-1edc-7dc692471196@...2181...>
References: <222922b3-377a-3eab-1edc-7dc692471196@...2181...>
Subject: [Openvpn-devel] [PATCH v2] tun: remove tun_finalize()
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

tun_finalize() is essentially subset of socket_finalize() apart from:

 - using WSAFoo() functions instead of Foo()

 - "from" address is not returned

There is no clear official statement that one can use non-WSA
API on handles, so let's be on a safe side and use both.

Introduce sockethandle_t abstraction, which represents
socket and handle. Add SocketHandle* macros which call
proper API depends on underlying type in abstraction.

Rename socket_finalize() to sockethandle_finalize(), take
sockethandle_t and new macros into use and kick tun_finalize().

Signed-off-by: Lev Stipakov <lev@...515...>
---
 v2: explicitly initialize .is_handle to false for readablity

 src/openvpn/forward.c |  3 +-
 src/openvpn/socket.c  | 37 ++++++++---------
 src/openvpn/socket.h  | 31 ++++++++++++--
 src/openvpn/tun.c     | 94 +++++++++----------------------------------
 src/openvpn/tun.h     | 34 +---------------
 5 files changed, 65 insertions(+), 134 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index f82386a1..a905f993 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1115,7 +1115,8 @@ read_incoming_tun(struct context *c)
     }
     else
     {
-        read_tun_buffered(c->c1.tuntap, &c->c2.buf);
+        sockethandle_t sh = { .is_handle = true, .h = c->c1.tuntap->hand };
+        sockethandle_finalize(sh, &c->c1.tuntap->reads, &c->c2.buf, NULL);
     }
 #else  /* ifdef _WIN32 */
     ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index df736746..5687646d 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3198,7 +3198,8 @@ link_socket_read_tcp(struct link_socket *sock,
     if (!sock->stream_buf.residual_fully_formed)
     {
 #ifdef _WIN32
-        len = socket_finalize(sock->sd, &sock->reads, buf, NULL);
+        sockethandle_t sh = { .is_handle = false, .s = sock->sd };
+        len = sockethandle_finalize(sh, &sock->reads, buf, NULL);
 #else
         struct buffer frag;
         stream_buf_get_next(&sock->stream_buf, &frag);
@@ -3664,10 +3665,10 @@ socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct lin
 }
 
 int
-socket_finalize(SOCKET s,
-                struct overlapped_io *io,
-                struct buffer *buf,
-                struct link_socket_actual *from)
+sockethandle_finalize(sockethandle_t sh,
+                      struct overlapped_io *io,
+                      struct buffer *buf,
+                      struct link_socket_actual *from)
 {
     int ret = -1;
     BOOL status;
@@ -3675,13 +3676,7 @@ socket_finalize(SOCKET s,
     switch (io->iostate)
     {
         case IOSTATE_QUEUED:
-            status = WSAGetOverlappedResult(
-                s,
-                &io->overlapped,
-                &io->size,
-                FALSE,
-                &io->flags
-                );
+            status = SocketHandleGetOverlappedResult(sh, &io);
             if (status)
             {
                 /* successful return for a queued operation */
@@ -3693,18 +3688,18 @@ socket_finalize(SOCKET s,
                 io->iostate = IOSTATE_INITIAL;
                 ASSERT(ResetEvent(io->overlapped.hEvent));
 
-                dmsg(D_WIN32_IO, "WIN32 I/O: Socket Completion success [%d]", ret);
+                dmsg(D_WIN32_IO, "WIN32 I/O: Completion success [%d]", ret);
             }
             else
             {
                 /* error during a queued operation */
                 ret = -1;
-                if (WSAGetLastError() != WSA_IO_INCOMPLETE)
+                if (SocketHandleGetLastError(sh) != ERROR_IO_INCOMPLETE)
                 {
                     /* if no error (i.e. just not finished yet), then DON'T execute this code */
                     io->iostate = IOSTATE_INITIAL;
                     ASSERT(ResetEvent(io->overlapped.hEvent));
-                    msg(D_WIN32_IO | M_ERRNO, "WIN32 I/O: Socket Completion error");
+                    msg(D_WIN32_IO | M_ERRNO, "WIN32 I/O: Completion error");
                 }
             }
             break;
@@ -3715,9 +3710,9 @@ socket_finalize(SOCKET s,
             if (io->status)
             {
                 /* error return for a non-queued operation */
-                WSASetLastError(io->status);
+                SocketHandleSetLastError(sh, io->status);
                 ret = -1;
-                msg(D_WIN32_IO | M_ERRNO, "WIN32 I/O: Socket Completion non-queued error");
+                msg(D_WIN32_IO | M_ERRNO, "WIN32 I/O: Completion non-queued error");
             }
             else
             {
@@ -3727,14 +3722,14 @@ socket_finalize(SOCKET s,
                     *buf = io->buf;
                 }
                 ret = io->size;
-                dmsg(D_WIN32_IO, "WIN32 I/O: Socket Completion non-queued success [%d]", ret);
+                dmsg(D_WIN32_IO, "WIN32 I/O: Completion non-queued success [%d]", ret);
             }
             break;
 
         case IOSTATE_INITIAL: /* were we called without proper queueing? */
-            WSASetLastError(WSAEINVAL);
+            SocketHandleSetInvalError(sh);
             ret = -1;
-            dmsg(D_WIN32_IO, "WIN32 I/O: Socket Completion BAD STATE");
+            dmsg(D_WIN32_IO, "WIN32 I/O: Completion BAD STATE");
             break;
 
         default:
@@ -3742,7 +3737,7 @@ socket_finalize(SOCKET s,
     }
 
     /* return from address if requested */
-    if (from)
+    if (!sh.is_handle && from)
     {
         if (ret >= 0 && io->addr_defined)
         {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index cc1e0c36..9d439fc6 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -262,12 +262,33 @@ int socket_send_queue(struct link_socket *sock,
                       struct buffer *buf,
                       const struct link_socket_actual *to);
 
-int socket_finalize(
-    SOCKET s,
+typedef struct {
+    union {
+        SOCKET s;
+        HANDLE h;
+    };
+    bool is_handle;
+} sockethandle_t;
+
+int sockethandle_finalize(
+    sockethandle_t sh,
     struct overlapped_io *io,
     struct buffer *buf,
     struct link_socket_actual *from);
 
+#define SocketHandleGetOverlappedResult(sh, io) (sh.is_handle ? \
+    GetOverlappedResult(sh.h, io->overlapped, io->size, FALSE) : \
+    WSAGetOverlappedResult(sh.s, io->overlapped, io->size, FALSE, io->flags))
+
+#define SocketHandleGetLastError(sh) (sh.is_handle ? \
+    GetLastError() : WSAGetLastError())
+
+#define SocketHandleSetLastError(sh, ...) (sh.is_handle ? \
+    SetLastError(__VA_ARGS__) : WSASetLastError(__VA_ARGS__))
+
+#define SocketHandleSetInvalError(sh) (sh.is_handle ? \
+    SetLastError(ERROR_INVALID_FUNCTION) : WSASetLastError(WSAEINVAL))
+
 #else  /* ifdef _WIN32 */
 
 #define openvpn_close_socket(s) close(s)
@@ -1020,7 +1041,8 @@ link_socket_read_udp_win32(struct link_socket *sock,
                            struct buffer *buf,
                            struct link_socket_actual *from)
 {
-    return socket_finalize(sock->sd, &sock->reads, buf, from);
+    sockethandle_t sh = { .is_handle = false, .s = sock->sd };
+    return sockethandle_finalize(sh, &sock->reads, buf, from);
 }
 
 #else  /* ifdef _WIN32 */
@@ -1078,9 +1100,10 @@ link_socket_write_win32(struct link_socket *sock,
 {
     int err = 0;
     int status = 0;
+    sockethandle_t sh = { .is_handle = false, .s = sock->sd };
     if (overlapped_io_active(&sock->writes))
     {
-        status = socket_finalize(sock->sd, &sock->writes, NULL, NULL);
+        status = sockethandle_finalize(sh, &sock->writes, NULL, NULL);
         if (status < 0)
         {
             err = WSAGetLastError();
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 12bdd200..fe32127b 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3561,87 +3561,29 @@ tun_write_queue(struct tuntap *tt, struct buffer *buf)
 }
 
 int
-tun_finalize(
-    HANDLE h,
-    struct overlapped_io *io,
-    struct buffer *buf)
+tun_write_win32(struct tuntap *tt, struct buffer *buf)
 {
-    int ret = -1;
-    BOOL status;
-
-    switch (io->iostate)
+    int err = 0;
+    int status = 0;
+    if (overlapped_io_active(&tt->writes))
     {
-        case IOSTATE_QUEUED:
-            status = GetOverlappedResult(
-                h,
-                &io->overlapped,
-                &io->size,
-                FALSE
-                );
-            if (status)
-            {
-                /* successful return for a queued operation */
-                if (buf)
-                {
-                    *buf = io->buf;
-                }
-                ret = io->size;
-                io->iostate = IOSTATE_INITIAL;
-                ASSERT(ResetEvent(io->overlapped.hEvent));
-                dmsg(D_WIN32_IO, "WIN32 I/O: TAP Completion success [%d]", ret);
-            }
-            else
-            {
-                /* error during a queued operation */
-                ret = -1;
-                if (GetLastError() != ERROR_IO_INCOMPLETE)
-                {
-                    /* if no error (i.e. just not finished yet),
-                     * then DON'T execute this code */
-                    io->iostate = IOSTATE_INITIAL;
-                    ASSERT(ResetEvent(io->overlapped.hEvent));
-                    msg(D_WIN32_IO | M_ERRNO, "WIN32 I/O: TAP Completion error");
-                }
-            }
-            break;
-
-        case IOSTATE_IMMEDIATE_RETURN:
-            io->iostate = IOSTATE_INITIAL;
-            ASSERT(ResetEvent(io->overlapped.hEvent));
-            if (io->status)
-            {
-                /* error return for a non-queued operation */
-                SetLastError(io->status);
-                ret = -1;
-                msg(D_WIN32_IO | M_ERRNO, "WIN32 I/O: TAP Completion non-queued error");
-            }
-            else
-            {
-                /* successful return for a non-queued operation */
-                if (buf)
-                {
-                    *buf = io->buf;
-                }
-                ret = io->size;
-                dmsg(D_WIN32_IO, "WIN32 I/O: TAP Completion non-queued success [%d]", ret);
-            }
-            break;
-
-        case IOSTATE_INITIAL: /* were we called without proper queueing? */
-            SetLastError(ERROR_INVALID_FUNCTION);
-            ret = -1;
-            dmsg(D_WIN32_IO, "WIN32 I/O: TAP Completion BAD STATE");
-            break;
-
-        default:
-            ASSERT(0);
+        sockethandle_t sh = { .is_handle = true, .h = tt->hand };
+        status = sockethandle_finalize(sh, &tt->writes, NULL, NULL);
+        if (status < 0)
+        {
+            err = GetLastError();
+        }
     }
-
-    if (buf)
+    tun_write_queue(tt, buf);
+    if (status < 0)
     {
-        buf->len = ret;
+        SetLastError(err);
+        return status;
+    }
+    else
+    {
+        return BLEN(buf);
     }
-    return ret;
 }
 
 static const struct device_instance_id_interface *
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index d4657537..a6661be0 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -437,8 +437,6 @@ int tun_read_queue(struct tuntap *tt, int maxsize);
 
 int tun_write_queue(struct tuntap *tt, struct buffer *buf);
 
-int tun_finalize(HANDLE h, struct overlapped_io *io, struct buffer *buf);
-
 static inline bool
 tuntap_stop(int status)
 {
@@ -466,36 +464,8 @@ tuntap_abort(int status)
     return false;
 }
 
-static inline int
-tun_write_win32(struct tuntap *tt, struct buffer *buf)
-{
-    int err = 0;
-    int status = 0;
-    if (overlapped_io_active(&tt->writes))
-    {
-        status = tun_finalize(tt->hand, &tt->writes, NULL);
-        if (status < 0)
-        {
-            err = GetLastError();
-        }
-    }
-    tun_write_queue(tt, buf);
-    if (status < 0)
-    {
-        SetLastError(err);
-        return status;
-    }
-    else
-    {
-        return BLEN(buf);
-    }
-}
-
-static inline int
-read_tun_buffered(struct tuntap *tt, struct buffer *buf)
-{
-    return tun_finalize(tt->hand, &tt->reads, buf);
-}
+int
+tun_write_win32(struct tuntap *tt, struct buffer *buf);
 
 static inline ULONG
 wintun_ring_packet_align(ULONG size)
-- 
2.23.0.windows.1


