From: Antonio Quartulli <a@...2181...>
Date: Mon, 11 Jul 2022 16:19:44 +0200
Message-Id: <20220711141944.21262-1-a@...2181...>
In-Reply-To: <20220624083809.23487-24-a@...2181...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 23/23] dco-win: implement ovpn-dco
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

Changes from v1:
* use suffix _dco_win instead of _windco
* create helper function to retrieve last error from socket object

 src/openvpn/forward.c |  7 ++++
 src/openvpn/init.c    | 29 ++++++++++++--
 src/openvpn/options.c | 19 ++++++---
 src/openvpn/options.h | 15 +++----
 src/openvpn/socket.c  | 93 ++++++++++++++++++++++++++++++++++++++++---
 src/openvpn/socket.h  | 25 ++++++++----
 src/openvpn/tun.c     | 43 +++++++++++++++-----
 src/openvpn/tun.h     | 58 +++++++++++++++++++--------
 8 files changed, 232 insertions(+), 57 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 15bdbbae..1fbad43f 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -860,6 +860,13 @@ read_incoming_link(struct context *c)
     /* check recvfrom status */
     check_status(status, "read", c->c2.link_socket, NULL);
 
+#ifdef _WIN32
+    if (dco_enabled(&c->options) && (status < 0) && (openvpn_errno() == ERROR_NETNAME_DELETED))
+    {
+        trigger_ping_timeout_signal(c);
+    }
+#endif
+
     /* Remove socks header if applicable */
     socks_postprocess_incoming_link(c);
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a6ee1fa8..b4276130 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1698,7 +1698,8 @@ do_init_tun(struct context *c)
                             c->c1.link_socket_addr.remote_list,
                             !c->options.ifconfig_nowarn,
                             c->c2.es,
-                            &c->net_ctx);
+                            &c->net_ctx,
+                            c->c1.tuntap);
 
 #ifdef _WIN32
     c->c1.tuntap->windows_driver = c->options.windows_driver;
@@ -1811,9 +1812,12 @@ do_open_tun(struct context *c)
             ovpn_dco_init(c->mode, &c->c1.tuntap->dco);
         }
 
-        /* open the tun device */
-        open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
-                 c->c1.tuntap, &c->net_ctx);
+        /* open the tun device (ovpn-dco-win already opened the device for the socket) */
+        if (!is_dco_win(c->c1.tuntap))
+        {
+            open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
+                     c->c1.tuntap, &c->net_ctx);
+        }
 
 #if defined(ENABLE_DCO)
         /* DCO may have been disabled by open_tun(). propagate change */
@@ -3574,6 +3578,23 @@ do_close_free_key_schedule(struct context *c, bool free_ssl_ctx)
 static void
 do_close_link_socket(struct context *c)
 {
+#if defined(_WIN32)
+    if (is_dco_win(c->c1.tuntap) && c->c2.link_socket
+        && c->c2.link_socket->info.dco_installed)
+    {
+        ASSERT(c->c2.link_socket_owned);
+
+        /* We rely on the tun_close to close the handle if also setup
+         * routes etc, since they cannot be delete when the interface
+         * handle has been closed */
+        if (!c->c1.tuntap->dco.real_tun_init)
+        {
+            do_close_tun_simple(c);
+        }
+        c->c2.link_socket->sd = SOCKET_UNDEFINED;
+    }
+#endif
+
     if (c->c2.link_socket && c->c2.link_socket_owned)
     {
         link_socket_close(c->c2.link_socket);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 85bdd3f6..fa66b513 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3225,8 +3225,8 @@ options_postprocess_mutate_invariant(struct options *options)
 #ifdef _WIN32
     const int dev = dev_type_enum(options->dev, options->dev_type);
 
-    /* when using wintun, kernel doesn't send DHCP requests, so don't use it */
-    if (options->windows_driver == WINDOWS_DRIVER_WINTUN
+    /* when using wintun/ovpn-dco-win, kernel doesn't send DHCP requests, so don't use it */
+    if ((options->windows_driver == WINDOWS_DRIVER_WINTUN || options->windows_driver == WINDOWS_DRIVER_WINDCO)
         && (options->tuntap_options.ip_win32_type == IPW32_SET_DHCP_MASQ || options->tuntap_options.ip_win32_type == IPW32_SET_ADAPTIVE))
     {
         options->tuntap_options.ip_win32_type = IPW32_SET_NETSH;
@@ -3322,10 +3322,12 @@ options_postprocess_setdefault_ncpciphers(struct options *o)
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
@@ -4161,7 +4163,8 @@ options_string(const struct options *o,
                       NULL,
                       false,
                       NULL,
-                      ctx);
+                      ctx,
+                      NULL);
         if (tt)
         {
             tt_local = true;
@@ -4548,13 +4551,19 @@ parse_windows_driver(const char *str, const int msglevel)
     {
         return WINDOWS_DRIVER_WINTUN;
     }
+
+    else if (streq(str, "ovpn-dco-win"))
+    {
+        return WINDOWS_DRIVER_WINDCO;
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
index f7e3f265..1b30cedd 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -879,24 +879,19 @@ void options_string_import(struct options *options,
 
 bool key_is_external(const struct options *options);
 
-#if defined(ENABLE_DCO) && defined(TARGET_LINUX)
-
 /**
  * Returns whether the current configuration has dco enabled.
  */
 static inline bool
 dco_enabled(const struct options *o)
 {
+#if defined(_WIN32)
+    return o->windows_driver == WINDOWS_DRIVER_WINDCO;
+#elif defined(ENABLE_DCO)
     return !o->tuntap_options.disable_dco;
-}
-
-#else /* if defined(ENABLE_DCO) && defined(TARGET_LINUX) */
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
index 4e4a3a2f..2e6fc0ca 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2119,6 +2119,41 @@ phase2_socks_client(struct link_socket *sock, struct signal_info *sig_info)
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
@@ -2158,7 +2193,24 @@ link_socket_init_phase2(struct context *c)
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
@@ -3426,6 +3478,17 @@ link_socket_write_udp_posix_sendmsg(struct link_socket *sock,
 
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
@@ -3459,7 +3522,14 @@ socket_recv_queue(struct link_socket *sock, int maxsize)
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
@@ -3512,7 +3582,7 @@ socket_recv_queue(struct link_socket *sock, int maxsize)
         }
         else
         {
-            status = WSAGetLastError();
+            status = socket_get_last_error(sock);
             if (status == WSA_IO_PENDING) /* operation queued? */
             {
                 sock->reads.iostate = IOSTATE_QUEUED;
@@ -3557,7 +3627,16 @@ socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct lin
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
@@ -3618,8 +3697,9 @@ socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct lin
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
@@ -3644,6 +3724,7 @@ socket_send_queue(struct link_socket *sock, struct buffer *buf, const struct lin
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
index 9076a9b7..0b01a1d0 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -743,13 +743,23 @@ init_tun(const char *dev,        /* --dev option */
          struct addrinfo *remote_public,
          const bool strict_warn,
          struct env_set *es,
-         openvpn_net_ctx_t *ctx)
+         openvpn_net_ctx_t *ctx,
+         struct tuntap *tt)
 {
     struct gc_arena gc = gc_new();
-    struct tuntap *tt;
 
-    ALLOC_OBJ(tt, struct tuntap);
-    clear_tuntap(tt);
+    if (!tt)
+    {
+        ALLOC_OBJ(tt, struct tuntap);
+        clear_tuntap(tt);
+    }
+#if defined(_WIN32)
+    else
+    {
+        ASSERT(!tt->dco.real_tun_init);
+        tt->dco.real_tun_init = true;
+    }
+#endif
 
     tt->type = dev_type_enum(dev, dev_type);
     tt->topology = topology;
@@ -892,6 +902,12 @@ init_tun_post(struct tuntap *tt,
 {
     tt->options = *options;
 #ifdef _WIN32
+    if (tt->windows_driver == WINDOWS_DRIVER_WINDCO)
+    {
+        dco_start_tun(tt);
+        return;
+    }
+
     overlapped_io_init(&tt->reads, frame, FALSE, true);
     overlapped_io_init(&tt->writes, frame, TRUE, true);
     tt->adapter_index = TUN_ADAPTER_INDEX_INVALID;
@@ -3508,6 +3524,9 @@ print_windows_driver(enum windows_driver_type windows_driver)
         case WINDOWS_DRIVER_WINTUN:
             return "wintun";
 
+        case WINDOWS_DRIVER_WINDCO:
+            return "ovpn-dco-win";
+
         default:
             return "unspecified";
     }
@@ -3889,6 +3908,10 @@ get_tap_reg(struct gc_arena *gc)
                     {
                         windows_driver = WINDOWS_DRIVER_WINTUN;
                     }
+                    else if (strcasecmp(component_id, "ovpn-dco") == 0)
+                    {
+                        windows_driver = WINDOWS_DRIVER_WINDCO;
+                    }
 
                     if (windows_driver != WINDOWS_DRIVER_UNSPECIFIED)
                     {
@@ -4243,7 +4266,9 @@ at_least_one_tap_win(const struct tap_reg *tap_reg)
 {
     if (!tap_reg)
     {
-        msg(M_FATAL, "There are no TAP-Windows nor Wintun adapters on this system.  You should be able to create an adapter by using tapctl.exe utility.");
+        msg(M_FATAL, "There are no TAP-Windows, Wintun or ovpn-dco-win adapters "
+            "on this system.  You should be able to create an adapter "
+            "by using tapctl.exe utility.");
     }
 }
 
@@ -6443,7 +6468,7 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
     const char *path = NULL;
     char tuntap_device_path[256];
 
-    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN)
+    if (tt->windows_driver == WINDOWS_DRIVER_WINTUN || tt->windows_driver == WINDOWS_DRIVER_WINDCO)
     {
         const struct device_instance_id_interface *dev_if;
 
@@ -6463,7 +6488,7 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
     }
     else
     {
-        /* Open TAP-Windows adapter */
+        /* Open TAP-Windows or dco-win adapter */
         openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path), "%s%s%s",
                          USERMODEDEVICEDIR,
                          device_guid,
@@ -6499,7 +6524,7 @@ tun_try_open_device(struct tuntap *tt, const char *device_guid, const struct dev
     return true;
 }
 
-static void
+void
 tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_guid, struct gc_arena *gc)
 {
     const struct tap_reg *tap_reg = get_tap_reg(gc);
@@ -6791,7 +6816,7 @@ netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_arena *gc
     argv_free(&argv);
 }
 
-static void
+void
 close_tun_handle(struct tuntap *tt)
 {
     const char *adaptertype = print_windows_driver(tt->windows_driver);
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index cf02bf43..a4902a78 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -48,7 +48,8 @@
 enum windows_driver_type {
     WINDOWS_DRIVER_UNSPECIFIED,
     WINDOWS_DRIVER_TAP_WINDOWS6,
-    WINDOWS_DRIVER_WINTUN
+    WINDOWS_DRIVER_WINTUN,
+    WINDOWS_DRIVER_WINDCO
 };
 #endif
 
@@ -64,6 +65,8 @@ struct tuntap_options {
     /* --ip-win32 options */
     bool ip_win32_defined;
 
+    bool disable_dco;
+
 #define IPW32_SET_MANUAL       0   /* "--ip-win32 manual" */
 #define IPW32_SET_NETSH        1   /* "--ip-win32 netsh" */
 #define IPW32_SET_IPAPI        2   /* "--ip-win32 ipapi" */
@@ -242,6 +245,10 @@ tuntap_ring_empty(struct tuntap *tt)
 {
     return tuntap_is_wintun(tt) && (tt->wintun_send_ring->head == tt->wintun_send_ring->tail);
 }
+
+/* Low level function to open tun handle, used by DCO to create a handle for DCO*/
+void
+tun_open_device(struct tuntap *tt, const char *dev_node, const char **device_guid, struct gc_arena *gc);
 #endif
 
 /*
@@ -253,6 +260,8 @@ void open_tun(const char *dev, const char *dev_type, const char *dev_node,
 
 void close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx);
 
+void close_tun_handle(struct tuntap *tt);
+
 int write_tun(struct tuntap *tt, uint8_t *buf, int len);
 
 int read_tun(struct tuntap *tt, uint8_t *buf, int len);
@@ -279,7 +288,8 @@ struct tuntap *init_tun(const char *dev,        /* --dev option */
                         struct addrinfo *remote_public,
                         const bool strict_warn,
                         struct env_set *es,
-                        openvpn_net_ctx_t *ctx);
+                        openvpn_net_ctx_t *ctx,
+                        struct tuntap *tt);
 
 void init_tun_post(struct tuntap *tt,
                    const struct frame *frame,
@@ -624,6 +634,12 @@ write_tun_buffered(struct tuntap *tt, struct buffer *buf)
     }
 }
 
+static inline bool
+is_dco_win(struct tuntap *tt)
+{
+    return tt->windows_driver == WINDOWS_DRIVER_WINDCO;
+}
+
 #else  /* ifdef _WIN32 */
 
 static inline bool
@@ -649,6 +665,13 @@ tun_standby(struct tuntap *tt)
     return true;
 }
 
+
+static inline bool
+is_dco_win(struct tuntap *tt)
+{
+    return false;
+}
+
 #endif /* ifdef _WIN32 */
 
 /*
@@ -672,25 +695,28 @@ tun_set(struct tuntap *tt,
         void *arg,
         unsigned int *persistent)
 {
-    if (tuntap_defined(tt))
+    if (!tuntap_defined(tt) || is_dco_win(tt))
+    {
+        return;
+    }
+
+    /* if persistent is defined, call event_ctl only if rwflags has changed since last call */
+    if (!persistent || *persistent != rwflags)
     {
-        /* if persistent is defined, call event_ctl only if rwflags has changed since last call */
-        if (!persistent || *persistent != rwflags)
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
-- 
2.35.1


