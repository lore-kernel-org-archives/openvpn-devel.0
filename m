From: Gert Doering <gert@...1296...>
Date: Wed, 24 Sep 2025 10:21:15 +0200
Message-ID: <20250924082121.23139-1-gert@...1296...>
In-Reply-To: <gerrit.1758036965000.Id070d1a45d45f9029309d23df7f3cab9ce792205@...2715...>
References: <gerrit.1758036965000.Id070d1a45d45f9029309d23df7f3cab9ce792205@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] ps: Fix conversion warnings related to
 send/recv return values
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

We know that these values can't be big since they are limited
to the size of the input buffer. So we can explicitly cast
them to int if required.

Change-Id: Id070d1a45d45f9029309d23df7f3cab9ce792205
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1194
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1194
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 1d14367..31e7c25 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -475,11 +475,6 @@
     return true;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * This function runs in the context of the background proxy process.
  * Receive a control message from the parent (sent by the port_share_sendmsg
@@ -539,7 +534,7 @@
 
             if (status >= 2 && command == COMMAND_REDIRECT)
             {
-                buf.len = status - 1;
+                buf.len = (int)status - 1;
                 if (proxy_entry_new(list, es, server_addr, received_fd, &buf, journal_dir))
                 {
                     CLEAR(buf); /* we gave the buffer to proxy_entry_new */
@@ -566,7 +561,7 @@
 proxy_connection_io_recv(struct proxy_connection *pc)
 {
     /* recv data from socket */
-    const int status = recv(pc->sd, BPTR(&pc->buf), BCAP(&pc->buf), MSG_NOSIGNAL);
+    const ssize_t status = recv(pc->sd, BPTR(&pc->buf), BCAP(&pc->buf), MSG_NOSIGNAL);
     if (status < 0)
     {
         return (errno == EAGAIN) ? IOSTAT_EAGAIN_ON_READ : IOSTAT_READ_ERROR;
@@ -577,8 +572,8 @@
         {
             return IOSTAT_READ_ERROR;
         }
-        dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: read[%d] %d", (int)pc->sd, status);
-        pc->buf.len = status;
+        dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: read[%d] %zd", (int)pc->sd, status);
+        pc->buf.len = (int)status;
     }
     return IOSTAT_GOOD;
 }
@@ -587,7 +582,7 @@
 proxy_connection_io_send(struct proxy_connection *pc, int *bytes_sent)
 {
     const socket_descriptor_t sd = pc->counterpart->sd;
-    const int status = send(sd, BPTR(&pc->buf), BLEN(&pc->buf), MSG_NOSIGNAL);
+    const ssize_t status = send(sd, BPTR(&pc->buf), BLEN(&pc->buf), MSG_NOSIGNAL);
 
     if (status < 0)
     {
@@ -596,17 +591,17 @@
     }
     else
     {
-        *bytes_sent += status;
+        *bytes_sent += (int)status;
         if (status != pc->buf.len)
         {
-            dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: partial write[%d], tried=%d got=%d", (int)sd,
+            dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: partial write[%d], tried=%d got=%zd", (int)sd,
                  pc->buf.len, status);
-            buf_advance(&pc->buf, status);
+            buf_advance(&pc->buf, (int)status);
             return IOSTAT_EAGAIN_ON_WRITE;
         }
         else
         {
-            dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: wrote[%d] %d", (int)sd, status);
+            dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: wrote[%d] %zd", (int)sd, status);
             pc->buf.len = 0;
             pc->buf.offset = 0;
         }
@@ -797,10 +792,6 @@
     msg(M_INFO, "PORT SHARE PROXY: proxy exiting");
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Called from the main OpenVPN process to enable the port
  * share proxy.

