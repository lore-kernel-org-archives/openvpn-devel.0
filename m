From: Gert Doering <gert@...1296...>
Date: Wed,  2 Apr 2025 13:30:11 +0200
Message-ID: <20250402113016.14980-1-gert@...1296...>
In-Reply-To: <gerrit.1743592292000.I44a73f06c0672c1d288bf46e9424dc0dc2abe054@...2715...>
References: <gerrit.1743592292000.I44a73f06c0672c1d288bf46e9424dc0dc2abe054@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dco-win: Ensure correct OVERLAPPED scope
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

From: Lev Stipakov <lev@...515...>

This is a backport of the master commit

   f60a493 ("dco-win: Fix crash when cancelling pending operation")

Although I am unable to reproduce this issue on release branch,
the code is clearly wrong and has to be fixed.

The OVERLAPPED structure must remain valid for the entire duration of an
asynchronous operation. Previously, when a TCP connection was pending
inside the NEW_PEER call, the OVERLAPPED structure was defined as a
local variable within dco_p2p_new_peer().

When CancelIo() was called later from close_tun_handle(), the OVERLAPPED
structure was already out of scope, resulting in undefined behavior and
stack corruption.

This fix moves the OVERLAPPED structure to the tuntap struct, ensuring
it remains valid throughout the operation's lifetime.

Change-Id: I44a73f06c0672c1d288bf46e9424dc0dc2abe054
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/933
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 3ec946f..0b8f831 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -156,7 +156,8 @@
 }
 
 void
-dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_local,
+dco_create_socket(HANDLE handle, OVERLAPPED *ov,
+                  struct addrinfo *remoteaddr, bool bind_local,
                   struct addrinfo *bind, int timeout,
                   struct signal_info *sig_info)
 {
@@ -229,8 +230,8 @@
         ASSERT(0);
     }
 
-    OVERLAPPED ov = { 0 };
-    if (!DeviceIoControl(handle, OVPN_IOCTL_NEW_PEER, &peer, sizeof(peer), NULL, 0, NULL, &ov))
+    CLEAR(*ov);
+    if (!DeviceIoControl(handle, OVPN_IOCTL_NEW_PEER, &peer, sizeof(peer), NULL, 0, NULL, ov))
     {
         DWORD err = GetLastError();
         if (err != ERROR_IO_PENDING)
@@ -239,7 +240,7 @@
         }
         else
         {
-            dco_connect_wait(handle, &ov, timeout, sig_info);
+            dco_connect_wait(handle, ov, timeout, sig_info);
         }
     }
 }
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 4883629..dcf480e 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -41,7 +41,8 @@
 create_dco_handle(const char *devname, struct gc_arena *gc);
 
 void
-dco_create_socket(HANDLE handle, struct addrinfo *remoteaddr, bool bind_local,
+dco_create_socket(HANDLE handle, OVERLAPPED *ov,
+                  struct addrinfo *remoteaddr, bool bind_local,
                   struct addrinfo *bind, int timeout,
                   struct signal_info *sig_info);
 
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index e070688..2eb2e74 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2148,7 +2148,7 @@
         c->c1.tuntap = tt;
     }
 
-    dco_create_socket(c->c1.tuntap->hand,
+    dco_create_socket(c->c1.tuntap->hand, &c->c1.tuntap->dco_new_peer_ov,
                       sock->info.lsa->current_remote,
                       sock->bind_local, sock->info.lsa->bind_local,
                       get_server_poll_remaining_time(sock->server_poll_timeout),
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 33b9552..91dbeef 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -196,6 +196,7 @@
 
 #ifdef _WIN32
     HANDLE hand;
+    OVERLAPPED dco_new_peer_ov; /* used for async NEW_PEER dco call, which might wait for TCP connect */
     struct overlapped_io reads;
     struct overlapped_io writes;
     struct rw_handle rw_handle;

