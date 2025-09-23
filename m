From: Gert Doering <gert@...1296...>
Date: Tue, 23 Sep 2025 17:10:44 +0200
Message-ID: <20250923151050.27336-1-gert@...1296...>
In-Reply-To: <gerrit.1756814708000.I6e848df8104b6e3a6e2c3245ece91a20e473fb40@...2715...>
References: <gerrit.1756814708000.I6e848df8104b6e3a6e2c3245ece91a20e473fb40@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] socks: factor out socks_proxy_recv_char()
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

This is basically identical code duplicated three
times.

Change-Id: I6e848df8104b6e3a6e2c3245ece91a20e473fb40
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1165
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1165
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 481d3fb..1102421 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -81,6 +81,54 @@
 }
 
 static bool
+socks_proxy_recv_char(char *c, const char *name, socket_descriptor_t sd,
+                      struct event_timeout *server_poll_timeout,
+                      volatile int *signal_received)
+{
+    fd_set reads;
+    FD_ZERO(&reads);
+    openvpn_fd_set(sd, &reads);
+
+    struct timeval tv;
+    tv.tv_sec = get_server_poll_remaining_time(server_poll_timeout);
+    tv.tv_usec = 0;
+
+    const int status = select(sd + 1, &reads, NULL, NULL, &tv);
+
+    get_signal(signal_received);
+    if (*signal_received)
+    {
+        return false;
+    }
+
+    /* timeout? */
+    if (status == 0)
+    {
+        msg(D_LINK_ERRORS | M_ERRNO, "%s: TCP port read timeout expired", name);
+        return false;
+    }
+
+    /* error */
+    if (status < 0)
+    {
+        msg(D_LINK_ERRORS | M_ERRNO, "%s: TCP port read failed on select()", name);
+        return false;
+    }
+
+    /* read single char */
+    const ssize_t size = recv(sd, c, 1, MSG_NOSIGNAL);
+
+    /* error? */
+    if (size != 1)
+    {
+        msg(D_LINK_ERRORS | M_ERRNO, "%s: TCP port read failed on recv()", name);
+        return false;
+    }
+
+    return true;
+}
+
+static bool
 socks_username_password_auth(struct socks_proxy_info *p, socket_descriptor_t sd,
                              struct event_timeout *server_poll_timeout,
                              volatile int *signal_received)
@@ -121,52 +169,12 @@
 
     while (len < 2)
     {
-        int status;
-        ssize_t size;
-        fd_set reads;
-        struct timeval tv;
         char c;
 
-        FD_ZERO(&reads);
-        openvpn_fd_set(sd, &reads);
-        tv.tv_sec = get_server_poll_remaining_time(server_poll_timeout);
-        tv.tv_usec = 0;
-
-        status = select(sd + 1, &reads, NULL, NULL, &tv);
-
-        get_signal(signal_received);
-        if (*signal_received)
+        if (!socks_proxy_recv_char(&c, __func__, sd, server_poll_timeout, signal_received))
         {
             goto cleanup;
         }
-
-        /* timeout? */
-        if (status == 0)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO,
-                "socks_username_password_auth: TCP port read timeout expired");
-            goto cleanup;
-        }
-
-        /* error */
-        if (status < 0)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO,
-                "socks_username_password_auth: TCP port read failed on select()");
-            goto cleanup;
-        }
-
-        /* read single char */
-        size = recv(sd, &c, 1, MSG_NOSIGNAL);
-
-        /* error? */
-        if (size != 1)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO,
-                "socks_username_password_auth: TCP port read failed on recv()");
-            goto cleanup;
-        }
-
         /* store char in buffer */
         buf[len++] = c;
     }
@@ -208,49 +216,12 @@
 
     while (len < 2)
     {
-        int status;
-        ssize_t size;
-        fd_set reads;
-        struct timeval tv;
         char c;
 
-        FD_ZERO(&reads);
-        openvpn_fd_set(sd, &reads);
-        tv.tv_sec = get_server_poll_remaining_time(server_poll_timeout);
-        tv.tv_usec = 0;
-
-        status = select(sd + 1, &reads, NULL, NULL, &tv);
-
-        get_signal(signal_received);
-        if (*signal_received)
+        if (!socks_proxy_recv_char(&c, __func__, sd, server_poll_timeout, signal_received))
         {
             return false;
         }
-
-        /* timeout? */
-        if (status == 0)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port read timeout expired");
-            return false;
-        }
-
-        /* error */
-        if (status < 0)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port read failed on select()");
-            return false;
-        }
-
-        /* read single char */
-        size = recv(sd, &c, 1, MSG_NOSIGNAL);
-
-        /* error? */
-        if (size != 1)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port read failed on recv()");
-            return false;
-        }
-
         /* store char in buffer */
         buf[len++] = c;
     }
@@ -317,54 +288,13 @@
 
     while (len < 4 + alen + 2)
     {
-        int status;
-        ssize_t size;
-        fd_set reads;
-        struct timeval tv;
         char c;
 
-        FD_ZERO(&reads);
-        openvpn_fd_set(sd, &reads);
-        tv.tv_sec = get_server_poll_remaining_time(server_poll_timeout);
-        tv.tv_usec = 0;
-
-        status = select(sd + 1, &reads, NULL, NULL, &tv);
-
-        get_signal(signal_received);
-        if (*signal_received)
+        if (!socks_proxy_recv_char(&c, __func__, sd, server_poll_timeout, signal_received))
         {
             return false;
         }
 
-        /* timeout? */
-        if (status == 0)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO, "recv_socks_reply: TCP port read timeout expired");
-            return false;
-        }
-
-        /* error */
-        if (status < 0)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO, "recv_socks_reply: TCP port read failed on select()");
-            return false;
-        }
-
-        /* read single char */
-        size = recv(sd, &c, 1, MSG_NOSIGNAL);
-
-        /* error? */
-        if (size < 0)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO, "recv_socks_reply: TCP port read failed on recv()");
-            return false;
-        }
-        else if (size == 0)
-        {
-            msg(D_LINK_ERRORS, "ERROR: recv_socks_reply: empty response from socks server");
-            return false;
-        }
-
         if (len == 3)
         {
             atyp = c;

