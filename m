From: Gert Doering <gert@...1296...>
Date: Wed, 17 Jan 2024 10:08:39 +0100
Message-ID: <20240117090840.32621-1-gert@...1296...>
In-Reply-To: <gerrit.1705068839000.Iefa4930cb1e8c4135056a17ceb4283fc13cc75c8@...2715...>
References: <gerrit.1705068839000.Iefa4930cb1e8c4135056a17ceb4283fc13cc75c8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] NTLM: increase size of phase 2 response
 we can handle
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

With NTLMv2 the target information buffer can be rather large
even with normal domain setups.

In my test setup it was 152 bytes starting at offset 71.
Overall the base64 encode phase 2 response was 300 byte long.
The linked documentation has 98 bytes at offset 60. 128 byte
is clearly too low.

While here improve the error messaging, so that if the buffer
is too small at least one can determine that in the log.

Change-Id: Iefa4930cb1e8c4135056a17ceb4283fc13cc75c8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/497
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 99d4ae7..2c6a69d 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -205,7 +205,7 @@
     uint8_t challenge[8];
     int i, ret_val;
 
-    uint8_t ntlmv2_response[144];
+    uint8_t ntlmv2_response[256];
     char userdomain_u[256];     /* for uppercase unicode username and domain */
     char userdomain[128];       /* the same as previous but ascii */
     uint8_t ntlmv2_hash[MD5_DIGEST_LENGTH];
@@ -255,17 +255,15 @@
      * the missing bytes will be NULL, as buf2 is known to be zeroed
      * when this decode happens.
      */
-    uint8_t buf2[128]; /* decoded reply from proxy */
+    uint8_t buf2[512]; /* decoded reply from proxy */
     CLEAR(buf2);
     ret_val = openvpn_base64_decode(phase_2, buf2, -1);
     if (ret_val < 0)
     {
+        msg(M_WARN, "NTLM: base64 decoding of phase 2 response failed");
         return NULL;
     }
 
-    /* we can be sure that phase_2 is less than 128
-     * therefore buf2 needs to be (3/4 * 128) */
-
     /* extract the challenge from bytes 24-31 */
     for (i = 0; i<8; i++)
     {
@@ -284,7 +282,7 @@
     }
     else
     {
-        msg(M_INFO, "Warning: Username or domain too long");
+        msg(M_INFO, "NTLM: Username or domain too long");
     }
     unicodize(userdomain_u, userdomain);
     gen_hmac_md5((uint8_t *)userdomain_u, 2 * strlen(userdomain), md4_hash,
@@ -319,9 +317,10 @@
     if ((flags & 0x00800000) == 0x00800000)
     {
         tib_len = buf2[0x28];            /* Get Target Information block size */
-        if (tib_len > 96)
+        if (tib_len + 0x1c + 16 > sizeof(ntlmv2_response))
         {
-            tib_len = 96;
+            msg(M_WARN, "NTLM: target information buffer too long for response (len=%d)", tib_len);
+            return NULL;
         }
 
         {
@@ -329,6 +328,7 @@
             uint8_t tib_pos = buf2[0x2c];
             if (tib_pos + tib_len > sizeof(buf2))
             {
+                msg(M_ERR, "NTLM: phase 2 response from server too long (need %d bytes at offset %u)", tib_len, tib_pos);
                 return NULL;
             }
             /* Get Target Information block pointer */
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 5a1b4e1..e081532 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -752,8 +752,7 @@
         {
 #if NTLM
             /* look for the phase 2 response */
-            char buf2[129];
-
+            char buf2[512];
             while (true)
             {
                 if (!recv_line(sd, buf, sizeof(buf), get_server_poll_remaining_time(server_poll_timeout), true, NULL, signal_received))
@@ -764,9 +763,9 @@
                 msg(D_PROXY, "HTTP proxy returned: '%s'", buf);
 
                 char get[80];
+                CLEAR(buf2);
                 openvpn_snprintf(get, sizeof(get), "%%*s NTLM %%%zus", sizeof(buf2) - 1);
                 nparms = sscanf(buf, get, buf2);
-                buf2[128] = 0; /* we only need the beginning - ensure it's null terminated. */
 
                 /* check for "Proxy-Authenticate: NTLM TlRM..." */
                 if (nparms == 1)

