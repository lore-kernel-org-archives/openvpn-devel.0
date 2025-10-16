From: Gert Doering <gert@...1296...>
Date: Thu, 16 Oct 2025 12:31:35 +0200
Message-ID: <20251016103143.4461-1-gert@...1296...>
In-Reply-To: <gerrit.1760525463000.I70620aca638847168f06b0fb23cc04bd279d7df9@...2715...>
References: <gerrit.1760525463000.I70620aca638847168f06b0fb23cc04bd279d7df9@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] proxy: factor out recv_char code common
 with socks proxy
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

Change-Id: I70620aca638847168f06b0fb23cc04bd279d7df9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1278
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1278
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index dfe1e59..4205991 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -57,6 +57,50 @@
 /* cached proxy username/password */
 static struct user_pass static_proxy_user_pass;
 
+bool
+proxy_recv_char(uint8_t *c, const char *name, socket_descriptor_t sd,
+                struct timeval *timeout, volatile int *signal_received)
+{
+    fd_set reads;
+    FD_ZERO(&reads);
+    openvpn_fd_set(sd, &reads);
+
+    const int status = openvpn_select(sd + 1, &reads, NULL, NULL, timeout);
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
+    const ssize_t size = recv(sd, (void *)c, 1, MSG_NOSIGNAL);
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
+
 static bool
 recv_line(socket_descriptor_t sd, char *buf, int len, const int timeout_sec, const bool verbose,
           struct buffer *lookahead, volatile int *signal_received)
@@ -72,9 +116,6 @@
 
     while (true)
     {
-        int status;
-        ssize_t size;
-        fd_set reads;
         struct timeval tv;
         uint8_t c;
 
@@ -83,50 +124,12 @@
             ASSERT(buf_init(&la, 0));
         }
 
-        FD_ZERO(&reads);
-        openvpn_fd_set(sd, &reads);
         tv.tv_sec = timeout_sec;
         tv.tv_usec = 0;
 
-        status = openvpn_select(sd + 1, &reads, NULL, NULL, &tv);
-
-        get_signal(signal_received);
-        if (*signal_received)
+        if (!proxy_recv_char(&c, "recv_line", sd, &tv, signal_received))
         {
-            goto error;
-        }
-
-        /* timeout? */
-        if (status == 0)
-        {
-            if (verbose)
-            {
-                msg(D_LINK_ERRORS | M_ERRNO, "recv_line: TCP port read timeout expired");
-            }
-            goto error;
-        }
-
-        /* error */
-        if (status < 0)
-        {
-            if (verbose)
-            {
-                msg(D_LINK_ERRORS | M_ERRNO, "recv_line: TCP port read failed on select()");
-            }
-            goto error;
-        }
-
-        /* read single char */
-        size = recv(sd, (void *)&c, 1, MSG_NOSIGNAL);
-
-        /* error? */
-        if (size != 1)
-        {
-            if (verbose)
-            {
-                msg(D_LINK_ERRORS | M_ERRNO, "recv_line: TCP port read failed on recv()");
-            }
-            goto error;
+            return false;
         }
 
 #if 0
@@ -179,9 +182,6 @@
     }
 
     return true;
-
-error:
-    return false;
 }
 
 static bool
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index be16d83..3bfa687 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -80,6 +80,9 @@
 
 void http_proxy_close(struct http_proxy_info *hp);
 
+bool proxy_recv_char(uint8_t *c, const char *name, socket_descriptor_t sd,
+                     struct timeval *timeout, volatile int *signal_received);
+
 bool establish_http_proxy_passthru(struct http_proxy_info *p,
                                    socket_descriptor_t sd, /* already open to proxy */
                                    const char *host,       /* openvpn server remote */
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index d383ef7..9dc013e 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -81,7 +81,7 @@
 }
 
 static bool
-socks_proxy_recv_char(char *c, const char *name, socket_descriptor_t sd,
+socks_proxy_recv_char(uint8_t *c, const char *name, socket_descriptor_t sd,
                       struct event_timeout *server_poll_timeout,
                       volatile int *signal_received)
 {
@@ -93,39 +93,7 @@
     tv.tv_sec = get_server_poll_remaining_time(server_poll_timeout);
     tv.tv_usec = 0;
 
-    const int status = openvpn_select(sd + 1, &reads, NULL, NULL, &tv);
-
-    get_signal(signal_received);
-    if (*signal_received)
-    {
-        return false;
-    }
-
-    /* timeout? */
-    if (status == 0)
-    {
-        msg(D_LINK_ERRORS | M_ERRNO, "%s: TCP port read timeout expired", name);
-        return false;
-    }
-
-    /* error */
-    if (status < 0)
-    {
-        msg(D_LINK_ERRORS | M_ERRNO, "%s: TCP port read failed on select()", name);
-        return false;
-    }
-
-    /* read single char */
-    const ssize_t size = recv(sd, c, 1, MSG_NOSIGNAL);
-
-    /* error? */
-    if (size != 1)
-    {
-        msg(D_LINK_ERRORS | M_ERRNO, "%s: TCP port read failed on recv()", name);
-        return false;
-    }
-
-    return true;
+    return proxy_recv_char(c, name, sd, &tv, signal_received);
 }
 
 static bool
@@ -165,10 +133,10 @@
     }
 
     int len = 0;
-    char buf[2];
+    uint8_t buf[2];
     while (len < 2)
     {
-        char c;
+        uint8_t c;
 
         if (!socks_proxy_recv_char(&c, __func__, sd, server_poll_timeout, signal_received))
         {
@@ -196,12 +164,12 @@
 socks_handshake(struct socks_proxy_info *p, socket_descriptor_t sd,
                 struct event_timeout *server_poll_timeout, volatile int *signal_received)
 {
-    char buf[2];
+    uint8_t buf[2];
     int len = 0;
     ssize_t size;
 
     /* VER = 5, NMETHODS = 1, METHODS = [0 (no auth)] */
-    char method_sel[3] = { 0x05, 0x01, 0x00 };
+    uint8_t method_sel[3] = { 0x05, 0x01, 0x00 };
     if (p->authfile[0])
     {
         method_sel[2] = 0x02; /* METHODS = [2 (plain login)] */
@@ -215,7 +183,7 @@
 
     while (len < 2)
     {
-        char c;
+        uint8_t c;
 
         if (!socks_proxy_recv_char(&c, __func__, sd, server_poll_timeout, signal_received))
         {
@@ -226,7 +194,7 @@
     }
 
     /* VER == 5 */
-    if (buf[0] != '\x05')
+    if (buf[0] != 5)
     {
         msg(D_LINK_ERRORS, "socks_handshake: Socks proxy returned bad status");
         return false;
@@ -273,7 +241,7 @@
 recv_socks_reply(socket_descriptor_t sd, struct openvpn_sockaddr *addr,
                  struct event_timeout *server_poll_timeout, volatile int *signal_received)
 {
-    char atyp = '\0';
+    uint8_t atyp = 0;
     int alen = 0;
     int len = 0;
     char buf[270]; /* 4 + alen(max 256) + 2 */
@@ -287,7 +255,7 @@
 
     while (len < 4 + alen + 2)
     {
-        char c;
+        uint8_t c;
 
         if (!socks_proxy_recv_char(&c, __func__, sd, server_poll_timeout, signal_received))
         {
@@ -303,18 +271,18 @@
         {
             switch (atyp)
             {
-                case '\x01': /* IP V4 */
+                case 1: /* IP V4 */
                     alen = 4;
                     break;
 
-                case '\x03': /* DOMAINNAME */
+                case 3: /* DOMAINNAME */
                     /* RFC 1928, section 5: 1 byte length, <n> bytes name,
                      * so the total "address length" is (length+1)
                      */
-                    alen = (unsigned char)c + 1;
+                    alen = c + 1;
                     break;
 
-                case '\x04': /* IP V6 */
+                case 4: /* IP V6 */
                     alen = 16;
                     break;
 
@@ -333,14 +301,14 @@
     }
 
     /* VER == 5 && REP == 0 (succeeded) */
-    if (buf[0] != '\x05' || buf[1] != '\x00')
+    if (buf[0] != 5 || buf[1] != 0)
     {
         msg(D_LINK_ERRORS, "recv_socks_reply: Socks proxy returned bad reply");
         return false;
     }
 
     /* ATYP == 1 (IP V4 address) */
-    if (atyp == '\x01' && addr != NULL)
+    if (atyp == 1 && addr != NULL)
     {
         memcpy(&addr->addr.in4.sin_addr, buf + 4, sizeof(addr->addr.in4.sin_addr));
         memcpy(&addr->addr.in4.sin_port, buf + 8, sizeof(addr->addr.in4.sin_port));

