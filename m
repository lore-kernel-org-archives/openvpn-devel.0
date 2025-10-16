From: Gert Doering <gert@...1296...>
Date: Thu, 16 Oct 2025 12:37:22 +0200
Message-ID: <20251016103730.5319-1-gert@...1296...>
In-Reply-To: <gerrit.1760526572000.Ieb18101dcf8143efdae1c39bde356e7166cbefa5@...2715...>
References: <gerrit.1760526572000.Ieb18101dcf8143efdae1c39bde356e7166cbefa5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] proxy: factor out send code common with
 socks proxy
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

Change-Id: Ieb18101dcf8143efdae1c39bde356e7166cbefa5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1279
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1279
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 4205991..ff6ea5a 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -184,13 +184,13 @@
     return true;
 }
 
-static bool
-send_line(socket_descriptor_t sd, const char *buf)
+bool
+proxy_send(socket_descriptor_t sd, const void *buf, size_t buf_len)
 {
-    const ssize_t size = openvpn_send(sd, buf, strlen(buf), MSG_NOSIGNAL);
-    if (size != (ssize_t)strlen(buf))
+    const ssize_t size = openvpn_send(sd, buf, buf_len, MSG_NOSIGNAL);
+    if (size != (ssize_t)buf_len)
     {
-        msg(D_LINK_ERRORS | M_ERRNO, "send_line: TCP port write failed on send()");
+        msg(D_LINK_ERRORS | M_ERRNO, "proxy_send: TCP port write failed on send()");
         return false;
     }
     return true;
@@ -201,10 +201,10 @@
 {
     bool ret;
 
-    struct buffer buf = alloc_buf(strlen(src) + 3);
+    struct buffer buf = alloc_buf(strlen(src) + 2);
     ASSERT(buf_write(&buf, src, strlen(src)));
-    ASSERT(buf_write(&buf, "\r\n", 3));
-    ret = send_line(sd, BSTR(&buf));
+    ASSERT(buf_write(&buf, "\r\n", 2));
+    ret = proxy_send(sd, BSTR(&buf), BLEN(&buf));
     free_buf(&buf);
     return ret;
 }
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 3bfa687..d14725c 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -83,6 +83,8 @@
 bool proxy_recv_char(uint8_t *c, const char *name, socket_descriptor_t sd,
                      struct timeval *timeout, volatile int *signal_received);
 
+bool proxy_send(socket_descriptor_t sd, const void *buf, size_t buf_len);
+
 bool establish_http_proxy_passthru(struct http_proxy_info *p,
                                    socket_descriptor_t sd, /* already open to proxy */
                                    const char *host,       /* openvpn server remote */
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 9dc013e..7ecf01a 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -123,12 +123,8 @@
                         creds.username, (int)strlen(creds.password), creds.password);
     ASSERT(sret >= 0 && sret <= sizeof(to_send));
 
-    ssize_t size = openvpn_send(sd, to_send, strlen(to_send), MSG_NOSIGNAL);
-
-    if (size != (ssize_t)strlen(to_send))
+    if (!proxy_send(sd, to_send, strlen(to_send)))
     {
-        msg(D_LINK_ERRORS | M_ERRNO,
-            "socks_username_password_auth: TCP port write failed on send()");
         goto cleanup;
     }
 
@@ -166,7 +162,6 @@
 {
     uint8_t buf[2];
     int len = 0;
-    ssize_t size;
 
     /* VER = 5, NMETHODS = 1, METHODS = [0 (no auth)] */
     uint8_t method_sel[3] = { 0x05, 0x01, 0x00 };
@@ -174,10 +169,8 @@
     {
         method_sel[2] = 0x02; /* METHODS = [2 (plain login)] */
     }
-    size = openvpn_send(sd, method_sel, sizeof(method_sel), MSG_NOSIGNAL);
-    if (size != sizeof(method_sel))
+    if (!proxy_send(sd, method_sel, sizeof(method_sel)))
     {
-        msg(D_LINK_ERRORS | M_ERRNO, "socks_handshake: TCP port write failed on send()");
         return false;
     }
 
@@ -380,18 +373,11 @@
     buf[5 + len] = (char)(port >> 8);
     buf[5 + len + 1] = (char)(port & 0xff);
 
+    if (!proxy_send(sd, buf, 5 + len + 2))
     {
-        size_t send_len = 5 + len + 2;
-        const ssize_t size = openvpn_send(sd, buf, send_len, MSG_NOSIGNAL);
-        if (size != (ssize_t)send_len)
-        {
-            msg(D_LINK_ERRORS | M_ERRNO,
-                "establish_socks_proxy_passthru: TCP port write failed on send()");
-            goto error;
-        }
+        goto error;
     }
 
-
     /* receive reply from Socks proxy and discard */
     if (!recv_socks_reply(sd, NULL, server_poll_timeout, &sig_info->signal_received))
     {

