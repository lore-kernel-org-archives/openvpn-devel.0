From: Gert Doering <gert@...1296...>
Date: Fri, 10 Oct 2025 11:57:00 +0200
Message-ID: <20251010095706.3779-1-gert@...1296...>
In-Reply-To: <gerrit.1759942426000.I977bab08cb614c2d59c34ceebc112f3add9bd168@...2715...>
References: <gerrit.1759942426000.I977bab08cb614c2d59c34ceebc112f3add9bd168@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] socks: Fix conversion warnings with MinGW
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

The winsock2 APIs are a bit weird at times...

Change-Id: I977bab08cb614c2d59c34ceebc112f3add9bd168
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1262
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1262
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 85bbde5..1a75daf 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -80,11 +80,6 @@
     free(sp);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static bool
 socks_proxy_recv_char(char *c, const char *name, socket_descriptor_t sd,
                       struct event_timeout *server_poll_timeout,
@@ -98,7 +93,8 @@
     tv.tv_sec = get_server_poll_remaining_time(server_poll_timeout);
     tv.tv_usec = 0;
 
-    const int status = select(sd + 1, &reads, NULL, NULL, &tv);
+    /* NB: first argument ignored on Windows where socket_descriptor_t != int */
+    const int status = select((int)sd + 1, &reads, NULL, NULL, &tv);
 
     get_signal(signal_received);
     if (*signal_received)
@@ -139,10 +135,7 @@
                              volatile int *signal_received)
 {
     char to_send[516];
-    char buf[2];
-    int len = 0;
     struct user_pass creds;
-    ssize_t size;
     bool ret = false;
 
     CLEAR(creds);
@@ -161,9 +154,10 @@
 
     int sret = snprintf(to_send, sizeof(to_send), "\x01%c%s%c%s", (int)strlen(creds.username),
                         creds.username, (int)strlen(creds.password), creds.password);
-    ASSERT(sret <= sizeof(to_send));
+    ASSERT(sret >= 0 && sret <= sizeof(to_send));
 
-    size = send(sd, to_send, strlen(to_send), MSG_NOSIGNAL);
+    /* NB: int because Windows APIs */
+    ssize_t size = send(sd, to_send, (int)strlen(to_send), MSG_NOSIGNAL);
 
     if (size != strlen(to_send))
     {
@@ -172,6 +166,8 @@
         goto cleanup;
     }
 
+    int len = 0;
+    char buf[2];
     while (len < 2)
     {
         char c;
@@ -419,8 +415,10 @@
     buf[5 + len + 1] = (char)(port & 0xff);
 
     {
-        const ssize_t size = send(sd, buf, 5 + len + 2, MSG_NOSIGNAL);
-        if ((int)size != 5 + (int)len + 2)
+        /* int because Windows APIs */
+        int send_len = 5 + (int)len + 2;
+        const ssize_t size = send(sd, buf, send_len, MSG_NOSIGNAL);
+        if (size != send_len)
         {
             msg(D_LINK_ERRORS | M_ERRNO,
                 "establish_socks_proxy_passthru: TCP port write failed on send()");
@@ -443,10 +441,6 @@
     return;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
                                socket_descriptor_t ctrl_sd, /* already open to proxy */

