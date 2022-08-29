From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 29 Aug 2022 14:51:17 +0300
Message-Id: <20220829115117.291-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco-win: support for --persist-tun
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

Since version 0.8.0, dco-win driver added support for
DEL_PEER command, which enabled --persist-tun
implementation on client side.

Add real implementation for dco_del_peer on Windows,
which calls DEL_PEER, which clears peer state
on the driver without tearing tunnel down.

When pulled options are changed on restart,
we need to close and reopen tun device. This
is not yes supported for dco-win, so we close
tun and trigger reconnect.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/dco.c          |  5 -----
 src/openvpn/dco_win.c      | 29 ++++++++++++++----------
 src/openvpn/dco_win.h      |  8 ++++---
 src/openvpn/init.c         | 19 +++++++++++++---
 src/openvpn/ovpn_dco_win.h |  1 +
 src/openvpn/socket.c       | 45 ++++++++++++++++++++------------------
 6 files changed, 63 insertions(+), 44 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 78023eea..075820c3 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -233,11 +233,6 @@ dco_check_startup_option_conflict(int msglevel, const struct options *o)
         return false;
     }
 
-    if (o->persist_tun)
-    {
-        msg(msglevel, "--persist-tun is not supported with ovpn-dco.");
-        return false;
-    }
 #elif defined(TARGET_LINUX)
     /* if the device name is fixed, we need to check if an interface with this
      * name already exists. IF it does, it must be a DCO interface, otherwise
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index a2030866..a7d6b55d 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -42,7 +42,7 @@
 const IN_ADDR in4addr_any = { 0 };
 #endif
 
-static struct tuntap
+struct tuntap
 create_dco_handle(const char *devname, struct gc_arena *gc)
 {
     struct tuntap tt = { .windows_driver = WINDOWS_DRIVER_DCO };
@@ -157,10 +157,9 @@ dco_connect_wait(HANDLE handle, OVERLAPPED *ov, int timeout, volatile int *signa
     return -1;
 }
 
-struct tuntap
-dco_create_socket(struct addrinfo *remoteaddr, bool bind_local,
-                  struct addrinfo *bind, const char *devname,
-                  struct gc_arena *gc, int timeout,
+bool
+dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_local,
+                  struct addrinfo *bind, int timeout,
                   volatile int *signal_received)
 {
     msg(D_DCO_DEBUG, "%s", __func__);
@@ -232,10 +231,8 @@ dco_create_socket(struct addrinfo *remoteaddr, bool bind_local,
         ASSERT(0);
     }
 
-    struct tuntap tt = create_dco_handle(devname, gc);
-
     OVERLAPPED ov = { 0 };
-    if (!DeviceIoControl(tt.hand, OVPN_IOCTL_NEW_PEER, &peer, sizeof(peer), NULL, 0, NULL, &ov))
+    if (!DeviceIoControl(handle, OVPN_IOCTL_NEW_PEER, &peer, sizeof(peer), NULL, 0, NULL, &ov))
     {
         DWORD err = GetLastError();
         if (err != ERROR_IO_PENDING)
@@ -244,13 +241,13 @@ dco_create_socket(struct addrinfo *remoteaddr, bool bind_local,
         }
         else
         {
-            if (dco_connect_wait(tt.hand, &ov, timeout, signal_received) < 0)
+            if (dco_connect_wait(handle, &ov, timeout, signal_received) < 0)
             {
-                close_tun_handle(&tt);
+                return false;
             }
         }
     }
-    return tt;
+    return true;
 }
 
 int
@@ -265,7 +262,15 @@ dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd,
 int
 dco_del_peer(dco_context_t *dco, unsigned int peerid)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d - not implemented", __func__, peerid);
+    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_DEL_PEER, NULL,
+                         0, NULL, 0, &bytes_returned, NULL))
+    {
+        msg(M_WARN | M_ERRNO, "DeviceIoControl(OVPN_IOCTL_DEL_PEER) failed");
+        return -1;
+    }
     return 0;
 }
 
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 348fc568..3a04e4f3 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -37,9 +37,11 @@ struct dco_context {
 typedef struct dco_context dco_context_t;
 
 struct tuntap
-dco_create_socket(struct addrinfo *remoteaddr, bool bind_local,
-                  struct addrinfo *bind, const char *devname,
-                  struct gc_arena *gc, int timeout,
+create_dco_handle(const char *devname, struct gc_arena *gc);
+
+bool
+dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_local,
+                  struct addrinfo *bind, int timeout,
                   volatile int *signal_received);
 
 void
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9917cefe..84d95c21 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2183,10 +2183,23 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
             {
                 /* if so, close tun, delete routes, then reinitialize tun and add routes */
                 msg(M_INFO, "NOTE: Pulled options changed on restart, will need to close and reopen TUN/TAP device.");
+
+                bool tt_dco_win = tuntap_is_dco_win(c->c1.tuntap);
                 do_close_tun(c, true);
-                management_sleep(1);
-                c->c2.did_open_tun = do_open_tun(c);
-                update_time();
+
+                if (tt_dco_win)
+                {
+                    msg(M_NONFATAL, "dco-win doesn't yet support reopening TUN device");
+                    /* prevent link_socket_close() from closing handle with WinSock API */
+                    c->c2.link_socket->sd = SOCKET_UNDEFINED;
+                    return false;
+                }
+                else
+                {
+                    management_sleep(1);
+                    c->c2.did_open_tun = do_open_tun(c);
+                    update_time();
+                }
             }
         }
 
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index 1ebd51a7..cbbdf92e 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -106,3 +106,4 @@ typedef struct _OVPN_SET_PEER {
 #define OVPN_IOCTL_SWAP_KEYS    CTL_CODE(FILE_DEVICE_UNKNOWN, 4, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_SET_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 5, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_DEVICE_UNKNOWN, 6, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_DEL_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_BUFFERED, FILE_ANY_ACCESS)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 4e29327b..f2bb3d69 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2128,23 +2128,29 @@ static void
 create_socket_dco_win(struct context *c, struct link_socket *sock,
                       volatile int *signal_received)
 {
-    struct tuntap *tt;
-    /* In this case persist-tun is enabled, which we don't support yet */
-    ASSERT(!c->c1.tuntap);
-
-    ALLOC_OBJ(tt, struct tuntap);
-
-    *tt = dco_create_socket(sock->info.lsa->current_remote,
-                            sock->bind_local,
-                            sock->info.lsa->bind_local,
-                            c->options.dev_node,
-                            &c->gc,
-                            get_server_poll_remaining_time(sock->server_poll_timeout),
-                            signal_received);
-
-    /* This state is used by signal handler which does teardown,
-     * so it has to be set before return */
-    c->c1.tuntap = tt;
+    if (!c->c1.tuntap)
+    {
+        struct tuntap *tt;
+        ALLOC_OBJ(tt, struct tuntap);
+
+        *tt = create_dco_handle(c->options.dev_node, &c->gc);
+
+        /* Ensure we can "safely" cast the handle to a socket */
+        static_assert(sizeof(sock->sd) == sizeof(tt->hand), "HANDLE and SOCKET size differs");
+
+        c->c1.tuntap = tt;
+    }
+
+    bool res = dco_create_socket(c->c1.tuntap->hand,
+                                 sock->info.lsa->current_remote,
+                                 sock->bind_local, sock->info.lsa->bind_local,
+                                 get_server_poll_remaining_time(sock->server_poll_timeout),
+                                 signal_received);
+    if (!res)
+    {
+        close_tun_handle(c->c1.tuntap);
+    }
+
     sock->info.dco_installed = true;
 
     if (*signal_received)
@@ -2152,10 +2158,7 @@ create_socket_dco_win(struct context *c, struct link_socket *sock,
         return;
     }
 
-    /* Ensure we can "safely" cast the handle to a socket */
-    static_assert(sizeof(sock->sd) == sizeof(tt->hand), "HANDLE and SOCKET size differs");
-    sock->sd = (SOCKET)tt->hand;
-
+    sock->sd = (SOCKET)c->c1.tuntap->hand;
     linksock_print_addr(sock);
 }
 #endif /* if defined(_WIN32) */
-- 
2.23.0.windows.1


