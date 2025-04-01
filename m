From: Gert Doering <gert@...1296...>
Date: Tue,  1 Apr 2025 20:15:30 +0200
Message-ID: <20250401181535.7854-1-gert@...1296...>
In-Reply-To: <gerrit.1743515497000.Ib1db457c42a80f6b8fc0e3ceb4a895d4cf7f0155@...2715...>
References: <gerrit.1743515497000.Ib1db457c42a80f6b8fc0e3ceb4a895d4cf7f0155@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dco-win: Fix crash when cancelling
 pending operation
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

The OVERLAPPED structure must remain valid for the entire duration of an
asynchronous operation. Previously, when a TCP connection was pending
inside the NEW_PEER call, the OVERLAPPED structure was defined as a
local variable within dco_p2p_new_peer().

When CancelIo() was called later from close_tun_handle(), the OVERLAPPED
structure was already out of scope, resulting in undefined behavior and
stack corruption.

This fix moves the OVERLAPPED structure to the tuntap struct, ensuring
it remains valid throughout the operation's lifetime.

GitHub: #715

Change-Id: Ib1db457c42a80f6b8fc0e3ceb4a895d4cf7f0155
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/928
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 8b47124..a386e53 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -321,7 +321,7 @@
 }
 
 void
-dco_p2p_new_peer(HANDLE handle, struct link_socket *sock, struct signal_info *sig_info)
+dco_p2p_new_peer(HANDLE handle, OVERLAPPED *ov, struct link_socket *sock, struct signal_info *sig_info)
 {
     msg(D_DCO_DEBUG, "%s", __func__);
 
@@ -395,8 +395,8 @@
         ASSERT(0);
     }
 
-    OVERLAPPED ov = { 0 };
-    if (!DeviceIoControl(handle, OVPN_IOCTL_NEW_PEER, &peer, sizeof(peer), NULL, 0, NULL, &ov))
+    CLEAR(*ov);
+    if (!DeviceIoControl(handle, OVPN_IOCTL_NEW_PEER, &peer, sizeof(peer), NULL, 0, NULL, ov))
     {
         DWORD err = GetLastError();
         if (err != ERROR_IO_PENDING)
@@ -405,7 +405,7 @@
         }
         else
         {
-            dco_connect_wait(handle, &ov, get_server_poll_remaining_time(sock->server_poll_timeout), sig_info);
+            dco_connect_wait(handle, ov, get_server_poll_remaining_time(sock->server_poll_timeout), sig_info);
         }
     }
 }
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 95c95c8..e8e4e22 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -63,7 +63,7 @@
 dco_mp_start_vpn(HANDLE handle, struct link_socket *sock);
 
 void
-dco_p2p_new_peer(HANDLE handle, struct link_socket *sock, struct signal_info *sig_info);
+dco_p2p_new_peer(HANDLE handle, OVERLAPPED *ov, struct link_socket *sock, struct signal_info *sig_info);
 
 void
 dco_start_tun(struct tuntap *tt);
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 09de1b0..beb31fa 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2242,7 +2242,7 @@
     }
     else
     {
-        dco_p2p_new_peer(c->c1.tuntap->hand, sock, sig_info);
+        dco_p2p_new_peer(c->c1.tuntap->hand, &c->c1.tuntap->dco_new_peer_ov, sock, sig_info);
     }
     sock->sockflags |= SF_DCO_WIN;
 
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index b616f5d..bcc23b4 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -215,6 +215,7 @@
 
 #ifdef _WIN32
     HANDLE hand;
+    OVERLAPPED dco_new_peer_ov; /* used for async NEW_PEER dco call, which might wait for TCP connect */
     struct overlapped_io reads;
     struct overlapped_io writes;
     struct rw_handle rw_handle;

