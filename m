From: Gert Doering <gert@...1296...>
Date: Wed, 17 Jan 2024 10:17:11 +0100
Message-ID: <20240117091711.5366-1-gert@...1296...>
In-Reply-To: <gerrit.1704898621000.Icea931d29e3e504e23e045539b21013b42172664@...2715...>
References: <gerrit.1704898621000.Icea931d29e3e504e23e045539b21013b42172664@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] NTLM: add length check to
 add_security_buffer
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

Especially ntlmv2_response can be very big, so make sure
we not do exceed the size of the phase3 buffer.

Change-Id: Icea931d29e3e504e23e045539b21013b42172664
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/493
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 2e77214..2b735ec 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -167,8 +167,13 @@
 
 static void
 add_security_buffer(int sb_offset, void *data, int length,
-                    unsigned char *msg_buf, int *msg_bufpos)
+                    unsigned char *msg_buf, int *msg_bufpos, size_t msg_bufsize)
 {
+    if (*msg_bufpos + length > msg_bufsize)
+    {
+        msg(M_WARN, "NTLM: security buffer too big for message buffer");
+        return;
+    }
     /* Adds security buffer data to a message and sets security buffer's
      * offset and length */
     msg_buf[sb_offset] = (unsigned char)length;
@@ -396,20 +401,20 @@
     if (ntlmv2_enabled)      /* NTLMv2 response */
     {
         add_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 16,
-                            phase3, &phase3_bufpos);
+                            phase3, &phase3_bufpos, sizeof(phase3));
     }
     else       /* NTLM response */
     {
-        add_security_buffer(0x14, ntlm_response, 24, phase3, &phase3_bufpos);
+        add_security_buffer(0x14, ntlm_response, 24, phase3, &phase3_bufpos, sizeof(phase3));
     }
 
     /* username in ascii */
     add_security_buffer(0x24, username, strlen(username), phase3,
-                        &phase3_bufpos);
+                        &phase3_bufpos, sizeof(phase3));
 
     /* Set domain. If <domain> is empty, default domain will be used
      * (i.e. proxy's domain) */
-    add_security_buffer(0x1c, domain, strlen(domain), phase3, &phase3_bufpos);
+    add_security_buffer(0x1c, domain, strlen(domain), phase3, &phase3_bufpos, sizeof(phase3));
 
     /* other security buffers will be empty */
     phase3[0x10] = phase3_bufpos;     /* lm not used */

