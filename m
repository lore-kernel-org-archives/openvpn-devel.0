From: Gert Doering <gert@...1296...>
Date: Tue, 13 Jan 2026 13:15:05 +0100
Message-ID: <20260113121512.12057-1-gert@...1296...>
In-Reply-To: <gerrit.1768304582000.I0141945469dd11340bfb42ec37a3c5f90ed0ff52@...2715...>
References: <gerrit.1768304582000.I0141945469dd11340bfb42ec37a3c5f90ed0ff52@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] socket: Remove old "dynamic remote"
 feature
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

From: Frank Lichtenheld <frank@...2641...>

So apparently when using --proto tcp-server --tls-server
--remote, AND the remote is not resolvable on startup
then we would preserve the remote name and resolve it
later on connect. Except that when the remote is not
resolvable I never managed to get it to create a
listening socket in the first place.

Originally I looked into this code because ZeroPath
claimed it was broken. I think that report was
correct but I think it is much easier to declare this
feature dead instead of trying to fix it. It is
undocumented and if it is usable then only in very
specific circumstances that are hard to figure out.

Github: openvpn-private-issues#13
Change-Id: I0141945469dd11340bfb42ec37a3c5f90ed0ff52
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1468
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1468
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index e2c5844..093f822 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -867,12 +867,10 @@
 
 static socket_descriptor_t
 socket_listen_accept(socket_descriptor_t sd, struct link_socket_actual *act,
-                     const char *remote_dynamic, const struct addrinfo *local, bool do_listen,
+                     const struct addrinfo *local, bool do_listen,
                      bool nowait, volatile int *signal_received)
 {
     struct gc_arena gc = gc_new();
-    /* struct openvpn_sockaddr *remote = &act->dest; */
-    struct openvpn_sockaddr remote_verify = act->dest;
     socket_descriptor_t new_sd = SOCKET_UNDEFINED;
 
     CLEAR(*act);
@@ -913,31 +911,7 @@
 
         if (socket_defined(new_sd))
         {
-            struct addrinfo *ai = NULL;
-            if (remote_dynamic)
-            {
-                openvpn_getaddrinfo(0, remote_dynamic, NULL, 1, NULL,
-                                    remote_verify.addr.sa.sa_family, &ai);
-            }
-
-            if (ai && !addrlist_match(&remote_verify, ai))
-            {
-                msg(M_WARN, "TCP NOTE: Rejected connection attempt from %s due to --remote setting",
-                    print_link_socket_actual(act, &gc));
-                if (openvpn_close_socket(new_sd))
-                {
-                    msg(M_ERR, "TCP: close socket failed (new_sd)");
-                }
-                freeaddrinfo(ai);
-            }
-            else
-            {
-                if (ai)
-                {
-                    freeaddrinfo(ai);
-                }
-                break;
-            }
+            break;
         }
         management_sleep(1);
     }
@@ -1255,8 +1229,7 @@
 }
 
 static void
-resolve_remote(struct link_socket *sock, int phase, const char **remote_dynamic,
-               struct signal_info *sig_info)
+resolve_remote(struct link_socket *sock, int phase, struct signal_info *sig_info)
 {
     volatile int *signal_received = sig_info ? &sig_info->signal_received : NULL;
     struct gc_arena gc = gc_new();
@@ -1351,10 +1324,6 @@
     {
         msg(M_INFO, "TCP/UDP: Preserving recently used remote address: %s",
             print_link_socket_actual(&sock->info.lsa->actual, &gc));
-        if (remote_dynamic)
-        {
-            *remote_dynamic = NULL;
-        }
     }
     else
     {
@@ -1516,7 +1485,7 @@
         {
             resolve_bind_local(sock, sock->info.af);
         }
-        resolve_remote(sock, 1, NULL, NULL);
+        resolve_remote(sock, 1, NULL);
     }
 }
 
@@ -1577,8 +1546,7 @@
 }
 
 static void
-phase2_tcp_server(struct link_socket *sock, const char *remote_dynamic,
-                  struct signal_info *sig_info)
+phase2_tcp_server(struct link_socket *sock, struct signal_info *sig_info)
 {
     ASSERT(sig_info);
     volatile int *signal_received = &sig_info->signal_received;
@@ -1586,8 +1554,9 @@
     {
         case LS_MODE_DEFAULT:
             sock->sd =
-                socket_listen_accept(sock->sd, &sock->info.lsa->actual, remote_dynamic,
-                                     sock->info.lsa->bind_local, true, false, signal_received);
+                socket_listen_accept(sock->sd, &sock->info.lsa->actual,
+                                     sock->info.lsa->bind_local, true, false,
+                                     signal_received);
             break;
 
         case LS_MODE_TCP_LISTEN:
@@ -1675,7 +1644,7 @@
         sock->info.lsa->remote_list = NULL;
     }
 
-    resolve_remote(sock, 1, NULL, sig_info);
+    resolve_remote(sock, 1, sig_info);
 }
 
 #if defined(_WIN32)
@@ -1733,7 +1702,6 @@
     const struct frame *frame = &c->c2.frame;
     struct signal_info *sig_info = c->sig;
 
-    const char *remote_dynamic = NULL;
     struct signal_info sig_save = { 0 };
 
     ASSERT(sock);
@@ -1748,18 +1716,8 @@
     /* initialize buffers */
     socket_frame_init(frame, sock);
 
-    /*
-     * Pass a remote name to connect/accept so that
-     * they can test for dynamic IP address changes
-     * and throw a SIGUSR1 if appropriate.
-     */
-    if (sock->resolve_retry_seconds)
-    {
-        remote_dynamic = sock->remote_host;
-    }
-
     /* Second chance to resolv/create socket */
-    resolve_remote(sock, 2, &remote_dynamic, sig_info);
+    resolve_remote(sock, 2, sig_info);
 
     /* If a valid remote has been found, create the socket with its addrinfo */
 #if defined(_WIN32)
@@ -1809,7 +1767,7 @@
 
     if (sock->info.proto == PROTO_TCP_SERVER)
     {
-        phase2_tcp_server(sock, remote_dynamic, sig_info);
+        phase2_tcp_server(sock, sig_info);
     }
     else if (sock->info.proto == PROTO_TCP_CLIENT)
     {

