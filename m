From: Steffan Karger <steffan@...1856...>
Date: Sat, 24 Dec 2016 14:22:19 +0100
Message-Id: <1482585739-14441-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Feedback wanted: proof-of-concept
	recvmmsg() support
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

This patch is not done, but I would like to get some early feedback
because I'm not very familiar with this part of the code, nor with the
APIs involved.  So I expect to have made some rooky mistakes.

A while back, I experimented a bit with recvmmsg(), to see if using it
would yield some performance gain.  Simple tests (I don't have a good
stress test setup handy) indicate that this improves throughput by a few
percent.  I would expect more gain on the server side for P2MP servers
though, where multiple client can be spamming the server at once.

What definitely still needs to be done:
 * Improve error messages
 * Improve documentation (doxygen, openvpn.8, Changes.rst)
 * Figure out good default values

So, please, let me know what you think of the code.  And if you do have
a good setup for performance testing, I'd love to hear what this change
does for you.

XXX step towards dynamic allocation (still working)

further move towards dynamic alloc

init more-or-less-properly (no alloc yet)

dynamic alloc

refactor1

Signed-off-by: Steffan Karger <steffan@...1856...>

refactor2

Signed-off-by: Steffan Karger <steffan@...1856...>

refactor3

Finish prototype code
---
 configure.ac          |   2 +-
 src/openvpn/forward.c |   3 +-
 src/openvpn/init.c    |   7 +++
 src/openvpn/integer.h |   7 +++
 src/openvpn/options.c |   6 ++
 src/openvpn/options.h |   1 +
 src/openvpn/socket.c  | 152 +++++++++++++++++++++++++++++++++++++++++++++++---
 src/openvpn/socket.h  |  43 ++++++++++++++
 8 files changed, 210 insertions(+), 11 deletions(-)

diff --git a/configure.ac b/configure.ac
index 43487b0..6bfb600 100644
--- a/configure.ac
+++ b/configure.ac
@@ -672,7 +672,7 @@ AC_SUBST([SOCKETS_LIBS])
 
 old_LIBS="${LIBS}"
 LIBS="${LIBS} ${SOCKETS_LIBS}"
-AC_CHECK_FUNCS([sendmsg recvmsg])
+AC_CHECK_FUNCS([sendmsg recvmsg sendmmsg recvmmsg])
 # Windows use stdcall for winsock so we cannot auto detect these
 m4_define(
 	[SOCKET_FUNCS],
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8102e94..0c6af66 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1754,7 +1754,8 @@ io_wait_dowork(struct context *c, const unsigned int flags)
 
     if (!c->sig->signal_received)
     {
-        if (!(flags & IOW_CHECK_RESIDUAL) || !socket_read_residual(c->c2.link_socket))
+        if ((!(flags & IOW_CHECK_RESIDUAL) || !socket_read_residual(c->c2.link_socket))
+            && !openvpn_mmsg_ctx_available(&c->c2.link_socket->recvmmsg_ctx))
         {
             int status;
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4ff7725..1996d4d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3157,6 +3157,13 @@ do_init_socket_2(struct context *c)
 {
     link_socket_init_phase2(c->c2.link_socket, &c->c2.frame,
                             c->sig);
+
+    if (c->options.sockflags | SF_USE_IP_PKTINFO)
+    {
+        openvpn_mmsg_ctx_init(&c->c2.link_socket->recvmmsg_ctx,
+                              BUF_SIZE(&c->c2.frame),
+                              c->options.recvmmsg_buf_count);
+    }
 }
 
 /*
diff --git a/src/openvpn/integer.h b/src/openvpn/integer.h
index 5ea32c4..8ea6708 100644
--- a/src/openvpn/integer.h
+++ b/src/openvpn/integer.h
@@ -31,6 +31,13 @@
  * min/max functions
  */
 
+#ifndef MIN
+#define MIN(a,b) (((a)<(b)) ? (a) : (b))
+#endif
+#ifndef MAX
+#define MAX(a,b) (((a)>(b)) ? (a) : (b))
+#endif
+
 static inline int
 max_int(int x, int y)
 {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 953e376..cf08186 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -811,6 +811,7 @@ init_options(struct options *o, const bool init_gc)
     o->resolve_retry_seconds = RESOLV_RETRY_INFINITE;
     o->resolve_in_advance = false;
     o->proto_force = -1;
+    o->recvmmsg_buf_count = 16;
 #ifdef ENABLE_OCC
     o->occ = true;
 #endif
@@ -5655,6 +5656,11 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->sockflags |= SF_USE_IP_PKTINFO;
     }
+    else if (streq(p[0], "recvmmsg-buf-count") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->recvmmsg_buf_count = strtoul(p[1], NULL, 10);
+    }
 #endif
     else if (streq(p[0], "verb") && p[1] && !p[2])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index b3ab029..9b3897e 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -325,6 +325,7 @@ struct options
 
     /* socket flags */
     unsigned int sockflags;
+    size_t recvmmsg_buf_count;
 
     /* route management */
     const char *route_script;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index ae12832..c0fa8d4 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -55,6 +55,13 @@ const int proto_overhead[] = { /* indexed by PROTO_x */
     IPv6_TCP_HEADER_SIZE,
 };
 
+#ifdef HAVE_RECVMMSG
+/** Free all memory allocated within ctx */
+void openvpn_mmsg_ctx_cleanup(struct openvpn_mmsg_ctx *ctx);
+#else
+#define openvpn_mmsg_ctx_cleanup(...) do { } while (false)
+#endif /* HAVE_RECVMMSG */
+
 /*
  * Convert sockflags/getaddr_flags into getaddr_flags
  */
@@ -2255,6 +2262,7 @@ link_socket_close(struct link_socket *sock)
 
         stream_buf_close(&sock->stream_buf);
         free_buf(&sock->stream_buf_data);
+        openvpn_mmsg_ctx_cleanup(&sock->recvmmsg_ctx);
         if (!gremlin)
         {
             free(sock);
@@ -3222,23 +3230,139 @@ link_socket_read_tcp(struct link_socket *sock,
  * both IPv4 and IPv6 destination addresses, plus padding (see RFC 2292)
  */
 #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
-#define PKTINFO_BUF_SIZE max_int( CMSG_SPACE(sizeof(struct in6_pktinfo)), \
-                                  CMSG_SPACE(sizeof(struct in_pktinfo)) )
+#define PKTINFO_BUF_SIZE MAX(CMSG_SPACE(sizeof(struct in6_pktinfo)), \
+                             CMSG_SPACE(sizeof(struct in_pktinfo)))
 #else
-#define PKTINFO_BUF_SIZE max_int( CMSG_SPACE(sizeof(struct in6_pktinfo)), \
-                                  CMSG_SPACE(sizeof(struct in_addr)) )
+#define PKTINFO_BUF_SIZE MAX(CMSG_SPACE(sizeof(struct in6_pktinfo)), \
+                             CMSG_SPACE(sizeof(struct in_addr)))
 #endif
 
+#ifdef HAVE_RECVMMSG
+
+/** XXX doxygen */
+struct openvpn_recv_meta {
+    struct openvpn_sockaddr sockaddr;
+    struct iovec iov;
+    uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];
+};
+
+void
+openvpn_mmsg_ctx_init(struct openvpn_mmsg_ctx *ctx, size_t buf_size,
+                      size_t buf_count)
+{
+    /* Allocate buffer and administration memory */
+    ctx->meta = calloc(buf_count, sizeof(struct openvpn_recv_meta));
+    check_malloc_return(ctx->meta);
+
+    ctx->hdrs = calloc(buf_count, sizeof(struct mmsghdr));
+    check_malloc_return(ctx->hdrs);
+
+    ctx->iov_data = calloc(buf_count, buf_size);
+    check_malloc_return(ctx->iov_data);
+
+    ctx->len = buf_count;
+
+    /* Initialize administration */
+    for (size_t i = 0; i < ctx->len; i++)
+    {
+        struct openvpn_recv_meta *meta = &ctx->meta[i];
+        struct mmsghdr *hdr = &ctx->hdrs[i];
+        meta->iov.iov_base = ctx->iov_data + (i * buf_size);
+        meta->iov.iov_len = buf_size;
+        hdr->msg_hdr.msg_iov = &meta->iov;
+        hdr->msg_hdr.msg_iovlen = 1;
+        hdr->msg_hdr.msg_name = &meta->sockaddr;
+        hdr->msg_hdr.msg_namelen = sizeof(meta->sockaddr);
+        hdr->msg_hdr.msg_control = &meta->pktinfo_buf;
+        hdr->msg_hdr.msg_controllen = sizeof(meta->pktinfo_buf);
+    }
+    ctx->msg_cur = 0;
+    ctx->msg_last = 0;
+
+    ctx->initialized = true;
+}
+
+void
+openvpn_mmsg_ctx_cleanup(struct openvpn_mmsg_ctx *ctx)
+{
+    free(ctx->meta);
+    free(ctx->hdrs);
+    free(ctx->iov_data);
+
+    ctx->len = 0;
+    ctx->initialized = false;
+}
+
+static void
+openvpn_mmsg_ctx_reset(struct openvpn_mmsg_ctx *ctx)
+{
+    dmsg(D_SOCKET_DEBUG, __func__);
+
+    for (size_t i = 0; i < ctx->msg_last; i++)
+    {
+        const struct openvpn_recv_meta *meta = &ctx->meta[i];
+        struct mmsghdr *hdr = &ctx->hdrs[i];
+        hdr->msg_hdr.msg_namelen = sizeof(meta->sockaddr.addr);
+        hdr->msg_hdr.msg_controllen = sizeof(meta->pktinfo_buf);
+    }
+    ctx->msg_cur = 0;
+    ctx->msg_last = 0;
+}
+int
+
+openvpn_recvmmsg(struct openvpn_mmsg_ctx *ctx, socket_descriptor_t sd,
+                 struct msghdr *mesg)
+{
+    if (ctx->msg_last <= ctx->msg_cur)
+    {
+        openvpn_mmsg_ctx_reset(ctx);
+        ctx->msg_last = recvmmsg(sd, ctx->hdrs, ctx->len, 0, NULL);
+        msg(M_WARN, "%s: recvmmsg got %i msgs", __func__, ctx->msg_last);
+        if (ctx->msg_last < 0)
+        {
+            msg(M_WARN, "ERROR ERROR ERROR - recvmmsg(): %s", strerror(errno));
+            ctx->msg_last = 0;
+        }
+    }
+
+    if (ctx->msg_last > 0)
+    {
+        struct mmsghdr *msg = &ctx->hdrs[ctx->msg_cur];
+        ctx->msg_cur++;
+        *mesg = msg->msg_hdr;
+        return msg->msg_len;
+    }
+    else
+    {
+        return -1;
+    }
+}
+
+#endif /* HAVE_RECVMMSG */
+
 static socklen_t
 link_socket_read_udp_posix_recvmsg(struct link_socket *sock,
                                    struct buffer *buf,
                                    struct link_socket_actual *from)
 {
-    struct iovec iov;
-    uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];
     struct msghdr mesg;
     socklen_t fromlen = sizeof(from->dest.addr);
 
+#ifdef HAVE_RECVMMSG
+    int msg_len = openvpn_recvmmsg(&sock->recvmmsg_ctx, sock->sd, &mesg);
+    dmsg(D_SOCKET_DEBUG, "%s: copying %i-byte message into buf", __func__,
+         msg_len);
+    if (!buf_write(buf, mesg.msg_iov->iov_base, msg_len))
+    {
+        msg(M_WARN, "ERROR ERROR ERROR - msg_len");
+        buf->len = 0;
+        return 0;
+    }
+    from->dest = *((struct openvpn_sockaddr *)mesg.msg_name);
+#else
+    struct iovec iov;
+    uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];
+
     iov.iov_base = BPTR(buf);
     iov.iov_len = buf_forward_capacity_total(buf);
     mesg.msg_iov = &iov;
@@ -3248,6 +3372,8 @@ link_socket_read_udp_posix_recvmsg(struct link_socket *sock,
     mesg.msg_control = pktinfo_buf;
     mesg.msg_controllen = sizeof pktinfo_buf;
     buf->len = recvmsg(sock->sd, &mesg, 0);
+#endif
+
     if (buf->len >= 0)
     {
         struct cmsghdr *cmsg;
@@ -3307,19 +3433,27 @@ link_socket_read_udp_posix(struct link_socket *sock,
     addr_zero_host(&from->dest);
 #if ENABLE_IP_PKTINFO
     /* Both PROTO_UDPv4 and PROTO_UDPv6 */
-    if (sock->info.proto == PROTO_UDP && sock->sockflags & SF_USE_IP_PKTINFO)
+    msg(D_SOCKET_DEBUG, "%s: proto = %i, sockflags = %x", __func__,
+        sock->info.proto, sock->sockflags);
+    if (sock->info.proto == PROTO_UDP && (sock->sockflags & SF_USE_IP_PKTINFO))
     {
         fromlen = link_socket_read_udp_posix_recvmsg(sock, buf, from);
     }
     else
 #endif
-    buf->len = recvfrom(sock->sd, BPTR(buf), buf_forward_capacity(buf), 0,
-                        &from->dest.addr.sa, &fromlen);
+    {
+        buf->len = recvfrom(sock->sd, BPTR(buf), buf_forward_capacity(buf), 0,
+                            &from->dest.addr.sa, &fromlen);
+    }
     /* FIXME: won't do anything when sock->info.af == AF_UNSPEC */
     if (buf->len >= 0 && expectedlen && fromlen != expectedlen)
     {
         bad_address_length(fromlen, expectedlen);
     }
+    struct gc_arena gc = gc_new();
+    msg(D_SOCKET_DEBUG, "%s: buf->len=%i, data=%s", __func__, buf->len,
+        format_hex(BPTR(buf), BLEN(buf), 0, &gc));
+    gc_free(&gc);
     return buf->len;
 }
 
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 63e601e..8d17590 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -157,6 +157,19 @@ struct socket_buffer_size
     int sndbuf;
 };
 
+#ifdef HAVE_RECVMMSG
+/** XXX doxygen */
+struct openvpn_mmsg_ctx {
+    bool initialized;
+    size_t len;
+    void *iov_data;
+    struct openvpn_recv_meta *meta;
+    struct mmsghdr *hdrs;
+    int msg_last;
+    size_t msg_cur;
+};
+#endif /* HAVE_RECVMMSG */
+
 /*
  * This is the main socket structure used by OpenVPN.  The SOCKET_
  * defines try to abstract away our implementation differences between
@@ -244,6 +257,10 @@ struct link_socket
     bool ptos_defined;
 #endif
 
+#ifdef HAVE_RECVMMSG
+    struct openvpn_mmsg_ctx recvmmsg_ctx;
+#endif
+
 #ifdef ENABLE_DEBUG
     int gremlin; /* --gremlin bits */
 #endif
@@ -333,6 +350,32 @@ void link_socket_init_phase2(struct link_socket *sock,
                              const struct frame *frame,
                              struct signal_info *sig_info);
 
+#ifdef HAVE_RECVMMSG
+
+/** TODO doxygen */
+void openvpn_mmsg_ctx_init(struct openvpn_mmsg_ctx *ctx, size_t buf_size,
+                           size_t buf_count);
+
+/** Return true iff msgs available in ctx */
+static inline bool
+openvpn_mmsg_ctx_available(const struct openvpn_mmsg_ctx *ctx)
+{
+    return ctx->initialized && (ctx->msg_cur < ctx->msg_last);
+}
+
+#else /* HAVE_RECVMMSG */
+
+#define openvpn_mmsg_ctx_init(...) do {} while (false)
+
+static inline bool
+openvpn_mmsg_ctx_available(const struct openvpn_mmsg_ctx *ctx)
+{
+    return false;
+}
+
+#endif /* HAVE_RECVMMSG */
+
+
 void do_preresolve(struct context *c);
 
 void socket_adjust_frame_parameters(struct frame *frame, int proto);
-- 
2.7.4


