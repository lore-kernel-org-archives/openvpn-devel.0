From: Antonio Quartulli <a@...2181...>
Date: Sat, 13 Aug 2022 22:42:20 +0200
Message-Id: <20220813204224.22576-3-a@...2181...>
In-Reply-To: <20220813204224.22576-1-a@...2181...>
References: <20220813204224.22576-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v101 3/7] dco-win: implement ovpn-dco
 support in P2P Windows code path
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
Cc: Antonio Quartulli <a@...2181...>, Arne Schwabe <arne@...1227...>, Lev Stipakov <lev@...515...>

With this change it is possible to use ovpn-dco-win when running OpenVPN
in client or P2P mode.

Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Lev Stipakov <lev@...515...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
Changes from v100:
* rebased (fixed conflicts in options.h and tun.h)

Changes from v3:
* rename WINDOWS_DRIVER_WINDCO to WINDOWS_DRIVER_DCO
* add reference string check

Changes from v2:
* added is_tun_type_set() and removed real_tun_init flag
* moved link-close to do_close_tun()

Changes from v1:
* use suffix _dco_win instead of _windco
* create helper function to retrieve last error from socket object
---
 src/openvpn/forward.c |  8 ++++
 src/openvpn/init.c    | 33 ++++++++++++---
 src/openvpn/options.c | 23 ++++++++---
 src/openvpn/options.h | 15 +++----
 src/openvpn/socket.c  | 93 ++++++++++++++++++++++++++++++++++++++++---
 src/openvpn/socket.h  | 25 ++++++++----
 src/openvpn/tun.c     | 52 +++++++++++++++++++-----
 src/openvpn/tun.h     | 66 +++++++++++++++++++++++-------
 8 files changed, 255 insertions(+), 60 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 14ad24fa..f6d416a3 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -864,9 +864,17 @@ read_incoming_link(struct context *c)
         return;
     }
 
+    /* check_status() call below resets last-error code */
+    bool dco_win_timeout = tuntap_is_dco_win_timeout(c->c1.tuntap, status);
+
     /* check recvfrom status */
     check_status(status, "read", c->c2.link_socket, NULL);
 
+    if (dco_win_timeout)
+    {
+        trigger_ping_timeout_signal(c);
+    }
+
     /* Remove socks header if applicable */
     socks_postprocess_incoming_link(c);
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4d4c7192..0610f070 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1699,7 +1699,8 @@ do_init_tun(struct context *c)
                             c->c1.link_socket_addr.remote_list,
                             !c->options.ifconfig_nowarn,
                             c->c2.es,
-                            &c->net_ctx);
+                            &c->net_ctx,
+                            c->c1.tuntap);
 
 #ifdef _WIN32
     c->c1.tuntap->windows_driver = c->options.windows_driver;
@@ -1723,7 +1724,7 @@ can_preserve_tun(struct tuntap *tt)
 #ifdef TARGET_ANDROID
     return false;
 #else
-    return tt;
+    return is_tun_type_set(tt);
 #endif
 }
 
@@ -1810,9 +1811,12 @@ do_open_tun(struct context *c)
             ovpn_dco_init(c->mode, &c->c1.tuntap->dco);
         }
 
-        /* open the tun device */
-        open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
-                 c->c1.tuntap, &c->net_ctx);
+        /* open the tun device (ovpn-dco-win already opened the device for the socket) */
+        if (!tuntap_is_dco_win(c->c1.tuntap))
+        {
+            open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
+                     c->c1.tuntap, &c->net_ctx);
+        }
 
         /* set the hardware address */
         if (c->options.lladdr)
@@ -1930,6 +1934,16 @@ do_close_tun_simple(struct context *c)
 static void
 do_close_tun(struct context *c, bool force)
 {
+    /* With dco-win we open tun handle in the very beginning.
+     * In case when tun wasn't opened - like we haven't connected,
+     * we still need to close tun handle
+     */
+    if (tuntap_is_dco_win(c->c1.tuntap) && !is_tun_type_set(c->c1.tuntap))
+    {
+        do_close_tun_simple(c);
+        return;
+    }
+
     if (!c->c1.tuntap || !c->c1.tuntap_owned)
     {
         return;
@@ -3570,6 +3584,15 @@ do_close_free_key_schedule(struct context *c, bool free_ssl_ctx)
 static void
 do_close_link_socket(struct context *c)
 {
+    /* in dco-win case, link socket is a tun handle which is
+     * closed in do_close_tun(). Set it to UNDEFINED so
+     * we won't use WinSock API to close it. */
+    if (tuntap_is_dco_win(c->c1.tuntap) && c->c2.link_socket
+        && c->c2.link_socket->info.dco_installed)
+    {
+        c->c2.link_socket->sd = SOCKET_UNDEFINED;
+    }
+
     if (c->c2.link_socket && c->c2.link_socket_owned)
     {
         link_socket_close(c->c2.link_socket);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index cec6cf10..966d6da9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3343,9 +3343,11 @@ options_postprocess_mutate_invariant(struct options *options)
 #ifdef _WIN32
     const int dev = dev_type_enum(options->dev, options->dev_type);
 
-    /* when using wintun, kernel doesn't send DHCP requests, so don't use it */
-    if (options->windows_driver == WINDOWS_DRIVER_WINTUN
-        && (options->tuntap_options.ip_win32_type == IPW32_SET_DHCP_MASQ || options->tuntap_options.ip_win32_type == IPW32_SET_ADAPTIVE))
+    /* when using wintun/ovpn-dco-win, kernel doesn't send DHCP requests, so don't use it */
+    if ((options->windows_driver == WINDOWS_DRIVER_WINTUN
+         || options->windows_driver == WINDOWS_DRIVER_DCO)
+        && (options->tuntap_options.ip_win32_type == IPW32_SET_DHCP_MASQ
+            || options->tuntap_options.ip_win32_type == IPW32_SET_ADAPTIVE))
     {
         options->tuntap_options.ip_win32_type = IPW32_SET_NETSH;
     }
@@ -3439,10 +3441,12 @@ options_postprocess_setdefault_ncpciphers(struct options *o)
         /* custom --data-ciphers set, keep list */
         return;
     }
+#if !defined(_WIN32)
     else if (cipher_valid("CHACHA20-POLY1305"))
     {
         o->ncp_ciphers = "AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
     }
+#endif
     else
     {
         o->ncp_ciphers = "AES-256-GCM:AES-128-GCM";
@@ -4165,7 +4169,8 @@ options_string(const struct options *o,
                       NULL,
                       false,
                       NULL,
-                      ctx);
+                      ctx,
+                      NULL);
         if (tt)
         {
             tt_local = true;
@@ -4552,13 +4557,19 @@ parse_windows_driver(const char *str, const int msglevel)
     {
         return WINDOWS_DRIVER_WINTUN;
     }
+
+    else if (streq(str, "ovpn-dco-win"))
+    {
+        return WINDOWS_DRIVER_DCO;
+    }
     else
     {
-        msg(msglevel, "--windows-driver must be tap-windows6 or wintun");
+        msg(msglevel, "--windows-driver must be tap-windows6, wintun "
+            "or ovpn-dco-win");
         return WINDOWS_DRIVER_UNSPECIFIED;
     }
 }
-#endif
+#endif /* ifdef _WIN32 */
 
 /*
  * parse/print topology coding
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 212f4b05..64731db0 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -876,24 +876,19 @@ void options_string_import(struct options *options,
 
 bool key_is_external(const struct options *options);
 
-#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
-
 /**
  * Returns whether the current configuration has dco enabled.
  */
 static inline bool
 dco_enabled(const struct options *o)
 {
+#if defined(_WIN32)
+    return o->windows_driver == WINDOWS_DRIVER_DCO;
+#elif defined(ENABLE_DCO)
     return !o->tuntap_options.disable_dco;
-}
-
-#else /* if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))*/
-
-static inline bool
-dco_enabled(const struct options *o)
-{
+#else
     return false;
+#endif /* defined(_WIN32) */
 }
 
-#endif
 #endif /* ifndef OPTIONS_H */
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index b4c20f69..db73b35d 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2123,6 +2123,41 @@ phase2_socks_client(struct link_socket *sock, struct signal_info *sig_info)
     resolve_remote(sock, 1, NULL, &sig_info->signal_received);
 }
 
+#if defined(_WIN32)
+static void
+create_socket_dco_win(struct context *c, struct link_socket *sock,
+                      volatile int *signal_received)
+{
+    struct tuntap *tt;
+    /* In this case persist-tun is enabled, which we don't support yet */
+    ASSERT(!c->c1.tuntap);
+
+    ALLOC_OBJ(tt, struct tuntap);
+
+    *tt = dco_create_socket(sock->info.lsa->current_remote,
+                            sock->bind_local,
+                            sock->info.lsa->bind_local,
+                            c->options.dev_node,
+                            &c->gc,
+                            get_server_poll_remaining_time(sock->server_poll_timeout),
+                            signal_received);
+
+    /* This state is used by signal handler which does teardown,
+     * so it has to be set before return */
+    c->c1.tuntap = tt;
+    sock->info.dco_installed = true;
+
+    if (*signal_received)
+    {
+        return;
+    }
+
+    /* Ensure we can "safely" cast the handle to a socket */
+    static_assert(sizeof(sock->sd) == sizeof(tt->hand), "HANDLE and SOCKET size differs");
+    sock->sd = (SOCKET)tt->hand;
+}
+#endif /* if defined(_WIN32) */
+
 /* finalize socket initialization */
 void
 link_socket_init_phase2(struct context *c)
@@ -2162,7 +2197,24 @@ link_socket_init_phase2(struct context *c)
     /* If a valid remote has been found, create the socket with its addrinfo */
     if (sock->info.lsa->current_remote)
     {
-        create_socket(sock, sock->info.lsa->current_remote);
+#if defined(_WIN32)
+        if (dco_enabled(&c->options))
+        {
+            create_socket_dco_win(c, sock, &sig_info->signal_received);
+            if (sig_info->signal_received)
+            {
+                goto done;
+            }
+
+            linksock_print_addr(sock);
+            goto done;
+        }
+        else
+#endif
+        {
+            create_socket(sock, sock->info.lsa->current_remote);
+        }
+
     }
 
     /* If socket has not already been created create it now */
@@ -3430,6 +3482,17 @@ link_socket_write_udp_posix_sendmsg(struct link_socket *sock,
 
 #ifdef _WIN32
 
+static int
+socket_get_last_error(const struct link_socket *sock)
+{
+    if (sock->info.dco_installed)
+    {
+        return GetLastError();
+    }
+
+    return WSAGetLastError();
+}
+
 int
 socket_recv_queue(struct link_socket *sock, int maxsize)
 {
@@ -3463,7 +3526,14 @@ socket_recv_queue(struct link_socket *sock, int maxsize)
         ASSERT(ResetEvent(sock->reads.overlapped.hEvent));
         sock->reads.flags = 0;
 
-        if (proto_is_udp(sock->info.proto))
+        if (sock->info.dco_installed)
+        {
+            status = ReadFile((HANDLE)sock->sd, wsabuf[0].buf, wsabuf[0].len,
+                              &sock->reads.size, &sock->reads.overlapped);
+            /* Readfile status is inverted from WSARecv */
+            status = !status;
+        }
+        else if (proto_is_udp(sock->info.proto))
         {
             sock->reads.addr_defined = true;
             sock->reads.addrlen = sizeof(sock->reads.addr6);
@@ -3516,7 +3586,7 @@ socket_recv_queue(struct link_socket *sock, int maxsize)
         }
         else
         {
-            status = WSAGetLastError();
+            status = socket_get_last_error(sock);
             if (status == WSA_IO_PENDING) /* operation queued? */
             {
                 sock->reads.iostate = IOSTATE_QUEUED;
@@ -3561,7 +3631,16 @@ socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct lin
         ASSERT(ResetEvent(sock->writes.overlapped.hEvent));
         sock->writes.flags = 0;
 
-        if (proto_is_udp(sock->info.proto))
+        if (sock->info.dco_installed)
+        {
+            status = WriteFile((HANDLE)sock->sd, wsabuf[0].buf, wsabuf[0].len,
+                               &sock->writes.size, &sock->writes.overlapped);
+
+            /* WriteFile status is inverted from WSASendTo */
+            status = !status;
+
+        }
+        else if (proto_is_udp(sock->info.proto))
         {
             /* set destination address for UDP writes */
             sock->writes.addr_defined = true;
@@ -3622,8 +3701,9 @@ socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct lin
         }
         else
         {
-            status = WSAGetLastError();
-            if (status == WSA_IO_PENDING) /* operation queued? */
+            status = socket_get_last_error(sock);
+            /* both status code have the identical value */
+            if (status == WSA_IO_PENDING || status == ERROR_IO_PENDING) /* operation queued? */
             {
                 sock->writes.iostate = IOSTATE_QUEUED;
                 sock->writes.status = status;
@@ -3648,6 +3728,7 @@ socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct lin
     return sock->writes.iostate;
 }
 
+/* Returns the number of bytes successfully read */
 int
 sockethandle_finalize(sockethandle_t sh,
                       struct overlapped_io *io,
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 0d521d22..462afa31 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -34,6 +34,7 @@
 #include "proxy.h"
 #include "socks.h"
 #include "misc.h"
+#include "tun.h"
 
 /*
  * OpenVPN's default port number as assigned by IANA.
@@ -937,7 +938,8 @@ socket_connection_reset(const struct link_socket *sock, int status)
         {
             const int err = openvpn_errno();
 #ifdef _WIN32
-            return err == WSAECONNRESET || err == WSAECONNABORTED;
+            return err == WSAECONNRESET || err == WSAECONNABORTED
+                   || err == ERROR_CONNECTION_ABORTED;
 #else
             return err == ECONNRESET;
 #endif
@@ -1048,6 +1050,11 @@ link_socket_read_udp_win32(struct link_socket *sock,
                            struct link_socket_actual *from)
 {
     sockethandle_t sh = { .s = sock->sd };
+    if (sock->info.dco_installed)
+    {
+        addr_copy_sa(&from->dest, &sock->info.lsa->actual.dest);
+        sh.is_handle = true;
+    }
     return sockethandle_finalize(sh, &sock->reads, buf, from);
 }
 
@@ -1057,7 +1064,7 @@ int link_socket_read_udp_posix(struct link_socket *sock,
                                struct buffer *buf,
                                struct link_socket_actual *from);
 
-#endif
+#endif /* ifdef _WIN32 */
 
 /* read a TCP or UDP packet from link */
 static inline int
@@ -1065,7 +1072,10 @@ link_socket_read(struct link_socket *sock,
                  struct buffer *buf,
                  struct link_socket_actual *from)
 {
-    if (proto_is_udp(sock->info.proto)) /* unified UDPv4 and UDPv6 */
+    if (proto_is_udp(sock->info.proto)
+        || sock->info.dco_installed)
+    /* unified UDPv4 and UDPv6, for DCO the kernel
+     * will strip the length header */
     {
         int res;
 
@@ -1106,19 +1116,19 @@ link_socket_write_win32(struct link_socket *sock,
 {
     int err = 0;
     int status = 0;
-    sockethandle_t sh = { .s = sock->sd };
+    sockethandle_t sh = { .s = sock->sd, .is_handle = sock->info.dco_installed };
     if (overlapped_io_active(&sock->writes))
     {
         status = sockethandle_finalize(sh, &sock->writes, NULL, NULL);
         if (status < 0)
         {
-            err = WSAGetLastError();
+            err = SocketHandleGetLastError(sh);
         }
     }
     socket_send_queue(sock, buf, to);
     if (status < 0)
     {
-        WSASetLastError(err);
+        SocketHandleSetLastError(sh, err);
         return status;
     }
     else
@@ -1180,8 +1190,9 @@ link_socket_write(struct link_socket *sock,
                   struct buffer *buf,
                   struct link_socket_actual *to)
 {
-    if (proto_is_udp(sock->info.proto)) /* unified UDPv4 and UDPv6 */
+    if (proto_is_udp(sock->info.proto) || sock->info.dco_installed)
     {
+        /* unified UDPv4 and UDPv6 and DCO (kernel adds size header) */
         return link_socket_write_udp(sock, buf, to);
     }
     else if (proto_is_tcp(sock->info.proto)) /* unified TCPv4 and TCPv6 */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 93cf0301..96d2e4e1 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -743,12 +743,14 @@ init_tun(const char *dev,        /* --dev option */
          struct addrinfo *remote_public,
          const bool strict_warn,
          struct env_set *es,
-         openvpn_net_ctx_t *ctx)
+         openvpn_net_ctx_t *ctx,
+         struct tuntap *tt)
 {
-    struct tuntap *tt;
-
-    ALLOC_OBJ(tt, struct tuntap);
-    clear_tuntap(tt);
+    if (!tt)
+    {
+        ALLOC_OBJ(tt, struct tuntap);
+        clear_tuntap(tt);
+    }
 
     tt->type = dev_type_enum(dev, dev_type);
     tt->topology = topology;
@@ -890,6 +892,12 @@ init_tun_post(struct tuntap *tt,
 {
     tt->options = *options;
 #ifdef _WIN32
+    if (tt->windows_driver == WINDOWS_DRIVER_DCO)
+    {
+        dco_start_tun(tt);
+        return;
+    }
+
     overlapped_io_init(&tt->reads, frame, FALSE, true);
     overlapped_io_init(&tt->writes, frame, TRUE, true);
     tt->adapter_index = TUN_ADAPTER_INDEX_INVALID;
@@ -3536,6 +3544,9 @@ print_windows_driver(enum windows_driver_type windows_driver)
         case WINDOWS_DRIVER_WINTUN:
             return "wintun";
 
+        case WINDOWS_DRIVER_DCO:
+            return "ovpn-dco-win";
+
         default:
             return "unspecified";
     }
@@ -3923,6 +3934,10 @@ get_tap_reg(struct gc_arena *gc)
                     {
                         windows_driver = WINDOWS_DRIVER_WINTUN;
                     }
+                    else if (strcasecmp(component_id, "ovpn-dco") == 0)
+                    {
+                        windows_driver = WINDOWS_DRIVER_DCO;
+                    }
 
                     if (windows_driver != WINDOWS_DRIVER_UNSPECIFIED)
                     {
@@ -4277,7 +4292,9 @@ at_least_one_tap_win(const struct tap_reg *tap_reg)
 {
     if (!tap_reg)
     {
-        msg(M_FATAL, "There are no TAP-Windows nor Wintun adapters on this system.  You should be able to create an adapter by using tapctl.exe utility.");
+        msg(M_FATAL, "There are no TAP-Windows, Wintun or ovpn-dco-win adapters "
+            "on this system.  You should be able to create an adapter "
+            "by using tapctl.exe utility.");
     }
 }
 
@@ -6477,17 +6494,30 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
     const char *path = NULL;
     char tuntap_device_path[256];
 
-    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
+    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN
+        || tt->windows_driver == WINDOWS_DRIVER_DCO)
     {
         const struct device_instance_id_interface *dev_if;
 
         for (dev_if = device_instance_id_interface; dev_if != NULL; dev_if = dev_if->next)
         {
-            if (strcmp((const char *)dev_if->net_cfg_instance_id, device_guid) == 0)
+            if (strcmp((const char *)dev_if->net_cfg_instance_id, device_guid) != 0)
             {
-                path = dev_if->device_interface;
-                break;
+                continue;
+            }
+
+            if (tt->windows_driver == WINDOWS_DRIVER_DCO)
+            {
+                char *last_sep = strrchr(dev_if->device_interface, '\\');
+                if (!last_sep
+                    || strcmp(last_sep + 1, DCO_WIN_REFERENCE_STRING) != 0)
+                {
+                    continue;
+                }
             }
+
+            path = dev_if->device_interface;
+            break;
         }
         if (path == NULL)
         {
@@ -6496,7 +6526,7 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
     }
     else
     {
-        /* Open TAP-Windows adapter */
+        /* Open TAP-Windows */
         openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path), "%s%s%s",
                          USERMODEDEVICEDIR,
                          device_guid,
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index de2f68fc..814dbdf0 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -44,6 +44,7 @@
 
 #ifdef _WIN32
 #define WINTUN_COMPONENT_ID "wintun"
+#define DCO_WIN_REFERENCE_STRING "ovpn-dco"
 
 enum windows_driver_type {
     WINDOWS_DRIVER_UNSPECIFIED,
@@ -293,7 +294,8 @@ struct tuntap *init_tun(const char *dev,        /* --dev option */
                         struct addrinfo *remote_public,
                         const bool strict_warn,
                         struct env_set *es,
-                        openvpn_net_ctx_t *ctx);
+                        openvpn_net_ctx_t *ctx,
+                        struct tuntap *tt);
 
 void init_tun_post(struct tuntap *tt,
                    const struct frame *frame,
@@ -638,6 +640,18 @@ write_tun_buffered(struct tuntap *tt, struct buffer *buf)
     }
 }
 
+static inline bool
+tuntap_is_dco_win(struct tuntap *tt)
+{
+    return tt && tt->windows_driver == WINDOWS_DRIVER_DCO;
+}
+
+static inline bool
+tuntap_is_dco_win_timeout(struct tuntap *tt, int status)
+{
+    return tuntap_is_dco_win(tt) && (status < 0) && (openvpn_errno() == ERROR_NETNAME_DELETED);
+}
+
 #else  /* ifdef _WIN32 */
 
 static inline bool
@@ -663,6 +677,19 @@ tun_standby(struct tuntap *tt)
     return true;
 }
 
+
+static inline bool
+tuntap_is_dco_win(struct tuntap *tt)
+{
+    return false;
+}
+
+static inline bool
+tuntap_is_dco_win_timeout(struct tuntap *tt, int status)
+{
+    return false;
+}
+
 #endif /* ifdef _WIN32 */
 
 /*
@@ -686,28 +713,37 @@ tun_set(struct tuntap *tt,
         void *arg,
         unsigned int *persistent)
 {
-    if (tuntap_defined(tt))
+    if (!tuntap_defined(tt) || tuntap_is_dco_win(tt))
     {
-        /* if persistent is defined, call event_ctl only if rwflags has changed since last call */
-        if (!persistent || *persistent != rwflags)
+        return;
+    }
+
+    /* if persistent is defined, call event_ctl only if rwflags has changed since last call */
+    if (!persistent || *persistent != rwflags)
+    {
+        event_ctl(es, tun_event_handle(tt), rwflags, arg);
+        if (persistent)
         {
-            event_ctl(es, tun_event_handle(tt), rwflags, arg);
-            if (persistent)
-            {
-                *persistent = rwflags;
-            }
+            *persistent = rwflags;
         }
+    }
 #ifdef _WIN32
-        if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6 && (rwflags & EVENT_READ))
-        {
-            tun_read_queue(tt, 0);
-        }
-#endif
-        tt->rwflags_debug = rwflags;
+    if (tt->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6 && (rwflags & EVENT_READ))
+    {
+        tun_read_queue(tt, 0);
     }
+#endif
+    tt->rwflags_debug = rwflags;
+
 }
 
 const char *tun_stat(const struct tuntap *tt, unsigned int rwflags, struct gc_arena *gc);
 bool tun_name_is_fixed(const char *dev);
 
+static inline bool
+is_tun_type_set(const struct tuntap *tt)
+{
+    return tt && tt->type != DEV_TYPE_UNDEF;
+}
+
 #endif /* TUN_H */
-- 
2.35.1


