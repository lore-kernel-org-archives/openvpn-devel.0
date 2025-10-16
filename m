From: Gert Doering <gert@...1296...>
Date: Thu, 16 Oct 2025 12:17:16 +0200
Message-ID: <20251016101722.2979-1-gert@...1296...>
In-Reply-To: <gerrit.1760523707000.If91d14f31368a93182bcf23b1d82b06ea94381d8@...2715...>
References: <gerrit.1760523707000.If91d14f31368a93182bcf23b1d82b06ea94381d8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] socket: Wrap winsock functions to avoid
 common conversion warnings
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

Before I had done those at the call site but we have
several very similar issues with multiple occurrences.
So handle them together.

Change-Id: If91d14f31368a93182bcf23b1d82b06ea94381d8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1277
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1277
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 02554ba..dfe1e59 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -54,11 +54,6 @@
 }
 
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /* cached proxy username/password */
 static struct user_pass static_proxy_user_pass;
 
@@ -93,7 +88,7 @@
         tv.tv_sec = timeout_sec;
         tv.tv_usec = 0;
 
-        status = select(sd + 1, &reads, NULL, NULL, &tv);
+        status = openvpn_select(sd + 1, &reads, NULL, NULL, &tv);
 
         get_signal(signal_received);
         if (*signal_received)
@@ -192,7 +187,7 @@
 static bool
 send_line(socket_descriptor_t sd, const char *buf)
 {
-    const ssize_t size = send(sd, buf, strlen(buf), MSG_NOSIGNAL);
+    const ssize_t size = openvpn_send(sd, buf, strlen(buf), MSG_NOSIGNAL);
     if (size != (ssize_t)strlen(buf))
     {
         msg(D_LINK_ERRORS | M_ERRNO, "send_line: TCP port write failed on send()");
@@ -903,7 +898,7 @@
 
                 if (opaque)
                 {
-                    const int len = strlen(opaque) + 16;
+                    const size_t len = strlen(opaque) + 16;
                     opaque_kv = gc_malloc(len, false, &gc);
                     snprintf(opaque_kv, len, ", opaque=\"%s\"", opaque);
                 }
@@ -1068,7 +1063,3 @@
     gc_free(&gc);
     return ret;
 }
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index f71d891..40a86fb 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -849,6 +849,10 @@
     gc_free(&gc);
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 static socket_descriptor_t
 socket_listen_accept(socket_descriptor_t sd, struct link_socket_actual *act,
                      const char *remote_dynamic, const struct addrinfo *local, bool do_listen,
@@ -873,7 +877,7 @@
         tv.tv_sec = 0;
         tv.tv_usec = 0;
 
-        status = select(sd + 1, &reads, NULL, NULL, &tv);
+        status = openvpn_select(sd + 1, &reads, NULL, NULL, &tv);
 
         get_signal(signal_received);
         if (*signal_received)
@@ -979,7 +983,7 @@
             msg(M_NONFATAL | M_ERRNO, "Setting IPV6_V6ONLY=%d failed", v6only);
         }
     }
-    if (bind(sd, cur->ai_addr, cur->ai_addrlen))
+    if (openvpn_bind(sd, cur->ai_addr, cur->ai_addrlen))
     {
         msg(M_FATAL | M_ERRNO, "%s: Socket bind failed on local address %s", prefix,
             print_sockaddr_ex(local->ai_addr, ":", PS_SHOW_PORT, &gc));
@@ -1026,7 +1030,7 @@
             tv.tv_sec = (connect_timeout > 0) ? 1 : 0;
             tv.tv_usec = 0;
 
-            status = select(sd + 1, NULL, &writes, NULL, &tv);
+            status = openvpn_select(sd + 1, NULL, &writes, NULL, &tv);
 #endif
             if (signal_received)
             {
@@ -1183,6 +1187,11 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 static void
 resolve_bind_local(struct link_socket *sock, const sa_family_t af)
 {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 2c79a11..e986c9c 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -291,9 +291,38 @@
     sh.is_handle ? SetLastError(ERROR_INVALID_FUNCTION) : WSASetLastError(WSAEINVAL);
 }
 
+/* winsock(2).h uses slightly different types so to avoid conversion
+   errors we wrap these functions on Windows */
+
+static inline int
+openvpn_select(socket_descriptor_t nfds, fd_set *readfds, fd_set *writefds,
+               fd_set *exceptfds, struct timeval *timeout)
+{
+    (void)nfds; /* first argument ignored on Windows */
+    return select(0, readfds, writefds, exceptfds, timeout);
+}
+
+static inline ssize_t
+openvpn_send(socket_descriptor_t sockfd, const void *buf, size_t len, int flags)
+{
+    ASSERT(len <= INT_MAX);
+    return send(sockfd, buf, (int)len, flags);
+}
+
+static inline int
+openvpn_bind(socket_descriptor_t sockfd, const struct sockaddr *addr, size_t addrlen)
+{
+    ASSERT(addrlen <= INT_MAX);
+    return bind(sockfd, addr, (int)addrlen);
+}
+
 #else /* ifdef _WIN32 */
 
 #define openvpn_close_socket(s) close(s)
+#define openvpn_select(nfds, readfds, writefds, exceptfds, timeout) \
+    select(nfds, readfds, writefds, exceptfds, timeout)
+#define openvpn_send(sockfd, buf, len, flags) send(sockfd, buf, len, flags)
+#define openvpn_bind(sockfd, addr, addrlen)   bind(sockfd, addr, addrlen)
 
 #endif /* ifdef _WIN32 */
 
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 6467baf..d383ef7 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -93,8 +93,7 @@
     tv.tv_sec = get_server_poll_remaining_time(server_poll_timeout);
     tv.tv_usec = 0;
 
-    /* NB: first argument ignored on Windows where socket_descriptor_t != int */
-    const int status = select((int)sd + 1, &reads, NULL, NULL, &tv);
+    const int status = openvpn_select(sd + 1, &reads, NULL, NULL, &tv);
 
     get_signal(signal_received);
     if (*signal_received)
@@ -156,10 +155,9 @@
                         creds.username, (int)strlen(creds.password), creds.password);
     ASSERT(sret >= 0 && sret <= sizeof(to_send));
 
-    /* NB: int because Windows APIs */
-    ssize_t size = send(sd, to_send, (int)strlen(to_send), MSG_NOSIGNAL);
+    ssize_t size = openvpn_send(sd, to_send, strlen(to_send), MSG_NOSIGNAL);
 
-    if (size != strlen(to_send))
+    if (size != (ssize_t)strlen(to_send))
     {
         msg(D_LINK_ERRORS | M_ERRNO,
             "socks_username_password_auth: TCP port write failed on send()");
@@ -208,7 +206,7 @@
     {
         method_sel[2] = 0x02; /* METHODS = [2 (plain login)] */
     }
-    size = send(sd, method_sel, sizeof(method_sel), MSG_NOSIGNAL);
+    size = openvpn_send(sd, method_sel, sizeof(method_sel), MSG_NOSIGNAL);
     if (size != sizeof(method_sel))
     {
         msg(D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port write failed on send()");
@@ -415,10 +413,9 @@
     buf[5 + len + 1] = (char)(port & 0xff);
 
     {
-        /* int because Windows APIs */
-        int send_len = 5 + (int)len + 2;
-        const ssize_t size = send(sd, buf, send_len, MSG_NOSIGNAL);
-        if (size != send_len)
+        size_t send_len = 5 + len + 2;
+        const ssize_t size = openvpn_send(sd, buf, send_len, MSG_NOSIGNAL);
+        if (size != (ssize_t)send_len)
         {
             msg(D_LINK_ERRORS | M_ERRNO,
                 "establish_socks_proxy_passthru: TCP port write failed on send()");

