From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 10 Jul 2024 16:06:23 +0200
Message-Id: <20240710140623.172829-1-frank@...2641...>
In-Reply-To: <gerrit.1720433364000.I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e@...2715...>
References: <gerrit.1720433364000.I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Allow trailing \r and \n in control
 channel message
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

Change-Id: I47c992b6b73b1475cbff8a28f720cf50dc1fbe3e
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/672
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 71b7167..40b7cc4 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -290,41 +290,14 @@
     struct buffer buf = alloc_buf_gc(len, &gc);
     if (tls_rec_payload(c->c2.tls_multi, &buf))
     {
-
         while (BLEN(&buf) > 1)
         {
-            /* commands on the control channel are seperated by 0x00 bytes.
-             * cmdlen does not include the 0 byte of the string */
-            int cmdlen = (int)strnlen(BSTR(&buf), BLEN(&buf));
+            struct buffer cmdbuf = extract_command_buffer(&buf, &gc);
 
-            if (cmdlen < BLEN(&buf))
+            if (cmdbuf.len > 0)
             {
-                /* include the NUL byte and ensure NUL termination */
-                int cmdlen = (int)strlen(BSTR(&buf)) + 1;
-
-                /* Construct a buffer that only holds the current command and
-                 * its closing NUL byte */
-                struct buffer cmdbuf = alloc_buf_gc(cmdlen, &gc);
-                buf_write(&cmdbuf, BPTR(&buf), cmdlen);
-
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
+                parse_incoming_control_channel_command(c, &cmdbuf);
             }
-            else
-            {
-                msg(D_PUSH_ERRORS, "WARNING: Ignoring control channel "
-                    "message command without NUL termination");
-            }
-            buf_advance(&buf, cmdlen);
         }
     }
     else
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 2ec0b2f..689cd7f 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -557,3 +557,43 @@
     }
     return false;
 }
+
+struct buffer
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
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 88b9e8c..c8a27fb 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -230,6 +230,20 @@
                      uint8_t header,
                      bool request_resend_wkc);
 
+
+/**
+ * Extracts a control channel message from buf and adjusts the size of
+ * buf after the message has been extracted
+ * @param buf   The buffer the message should be extracted from
+ * @param gc    gc_arena to be used for the returned buffer and displaying
+ *              diagnostic messages
+ * @return      A buffer with a control channel message or a buffer with
+ *              with length 0 if there is no message or the message has
+ *              invalid characters.
+ */
+struct buffer
+extract_command_buffer(struct buffer *buf, struct gc_arena *gc);
+
 static inline const char *
 packet_opcode_name(int op)
 {
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 1084d66..741c982 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -626,6 +626,40 @@
     free_tas(&tas_server);
 }
 
+static void
+test_extract_control_message(void **ut_state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer input_buf = alloc_buf_gc(1024, &gc);
+
+    /* This message will have a \0x00 at the end since it is a C string */
+    const char input[] = "valid control message\r\n\0\0Invalid\r\none\0valid one again";
+
+    buf_write(&input_buf, input, sizeof(input));
+    struct buffer cmd1 = extract_command_buffer(&input_buf, &gc);
+    struct buffer cmd2 = extract_command_buffer(&input_buf, &gc);
+    struct buffer cmd3 = extract_command_buffer(&input_buf, &gc);
+    struct buffer cmd4 = extract_command_buffer(&input_buf, &gc);
+    struct buffer cmd5 = extract_command_buffer(&input_buf, &gc);
+
+    assert_string_equal(BSTR(&cmd1), "valid control message");
+    /* empty message with just a \0x00 */
+    assert_int_equal(cmd2.len, 1);
+    assert_string_equal(BSTR(&cmd2), "");
+    assert_int_equal(cmd3.len, 0);
+    assert_string_equal(BSTR(&cmd4), "valid one again");
+    assert_int_equal(cmd5.len, 0);
+
+    const uint8_t nonull[6] = { 'n', 'o', ' ', 'N', 'U', 'L'};
+    struct buffer nonull_buf = alloc_buf_gc(1024, &gc);
+
+    buf_write(&nonull_buf, nonull, sizeof(nonull));
+    struct buffer nonullcmd = extract_command_buffer(&nonull_buf, &gc);
+    assert_int_equal(nonullcmd.len, 0);
+
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
@@ -640,6 +674,7 @@
         cmocka_unit_test(test_verify_hmac_tls_auth),
         cmocka_unit_test(test_generate_reset_packet_plain),
         cmocka_unit_test(test_generate_reset_packet_tls_auth),
+        cmocka_unit_test(test_extract_control_message)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

