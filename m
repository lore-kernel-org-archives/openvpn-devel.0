From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 11 Jul 2024 13:30:22 +0200
Message-Id: <20240711113022.52076-1-frank@...2641...>
In-Reply-To: <Zo6XDNcBacVz00PU@...2685...>
References: <Zo6XDNcBacVz00PU@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH release/2.5] Allow trailing \r and \n in
 control channel message
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

From: Arne Schwabe <arne@...1227...>

Writing a reason from a script will easily end up adding extra \r\n characters
at the end of the reason. Our current code pushes this to the peer. So be more
liberal in accepting these message.

Closes openvpn/openvpn#568

This is the backport of the fix to release/2.5.

Change-Id: I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e
Signed-off-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/forward.c | 73 +++++++++++++++++++++++++------------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 404b71c8..e8b981b3 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -221,6 +221,46 @@ parse_incoming_control_channel_command(struct context *c, struct buffer *buf)
     }
 }
 
+static struct buffer
+extract_command_buffer(struct buffer *buf, struct gc_arena *gc)
+{
+    /* commands on the control channel are seperated by 0x00 bytes.
+     * cmdlen does not include the 0 byte of the string */
+    int cmdlen = (int)strnlen(BSTR(buf), BLEN(buf));
+
+    if (cmdlen >= BLEN(buf))
+    {
+        buf_advance(buf, cmdlen);
+        /* Return empty buffer */
+        struct buffer empty = { 0 };
+        return empty;
+    }
+
+    /* include the NUL byte and ensure NUL termination */
+    cmdlen +=  1;
+
+    /* Construct a buffer that only holds the current command and
+     * its closing NUL byte */
+    struct buffer cmdbuf = alloc_buf_gc(cmdlen, gc);
+    buf_write(&cmdbuf, BPTR(buf), cmdlen);
+
+    /* Remove \r and \n at the end of the buffer to avoid
+     * problems with scripts and other that add extra \r and \n */
+    buf_chomp(&cmdbuf);
+
+    /* check we have only printable characters or null byte in the
+     * command string and no newlines */
+    if (!string_check_buf(&cmdbuf, CC_PRINT | CC_NULL, CC_CRLF))
+    {
+        msg(D_PUSH_ERRORS, "WARNING: Received control with invalid characters: %s",
+            format_hex(BPTR(&cmdbuf), BLEN(&cmdbuf), 256, gc));
+        cmdbuf.len = 0;
+    }
+
+    buf_advance(buf, cmdlen);
+    return cmdbuf;
+}
+
 /*
  * Handle incoming configuration
  * messages on the control channel.
@@ -236,41 +276,14 @@ check_incoming_control_channel(struct context *c)
     struct buffer buf = alloc_buf_gc(len, &gc);
     if (tls_rec_payload(c->c2.tls_multi, &buf))
     {
-
         while (BLEN(&buf) > 1)
         {
-            /* commands on the control channel are seperated by 0x00 bytes.
-             * cmdlen does not include the 0 byte of the string */
-            int cmdlen = (int)strnlen(BSTR(&buf), BLEN(&buf));
-
-            if (cmdlen < BLEN(&buf))
-            {
-                /* include the NUL byte and ensure NUL termination */
-                int cmdlen = (int)strlen(BSTR(&buf)) + 1;
-
-                /* Construct a buffer that only holds the current command and
-                 * its closing NUL byte */
-                struct buffer cmdbuf = alloc_buf_gc(cmdlen, &gc);
-                buf_write(&cmdbuf, BPTR(&buf), cmdlen);
+            struct buffer cmdbuf = extract_command_buffer(&buf, &gc);
 
-                /* check we have only printable characters or null byte in the
-                 * command string and no newlines */
-                if (!string_check_buf(&buf, CC_PRINT | CC_NULL, CC_CRLF))
-                {
-                    msg(D_PUSH_ERRORS, "WARNING: Received control with invalid characters: %s",
-                        format_hex(BPTR(&buf), BLEN(&buf), 256, &gc));
-                }
-                else
-                {
-                    parse_incoming_control_channel_command(c, &cmdbuf);
-                }
-            }
-            else
+            if (cmdbuf.len > 0)
             {
-                msg(D_PUSH_ERRORS, "WARNING: Ignoring control channel "
-                    "message command without NUL termination");
+                parse_incoming_control_channel_command(c, &cmdbuf);
             }
-            buf_advance(&buf, cmdlen);
         }
     }
     else
-- 
2.34.1


