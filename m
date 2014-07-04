From: Holger Kummert <Holger.Kummert@...1516...>
Date: Fri, 4 Jul 2014 09:35:24 +0200
Message-ID: <1404459325-11064-1-git-send-email-Holger.Kummert@...1516...>
In-Reply-To: <1397645317-20116-2-git-send-email-Holger.Kummert@...1516...>
References: <1397645317-20116-2-git-send-email-Holger.Kummert@...1516...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCHv2 1/2] Get NTLMv1 and NTLMv2 up and running
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

  * Force conversion to UTF-16 of username and domain if server requires UTF-16.
  * Rewrite conversion function to cleanly convert UTF-8 to UTF-16.
  * Fix bug in length computation in NTLMv2-code.
  * Architecture independent access to NTLM NegotiateFlags.

Signed-off-by: Holger Kummert <Holger.Kummert@...1516...>

---
 src/openvpn/ntlm.c | 169 +++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 144 insertions(+), 25 deletions(-)

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 3390bdd..4e4c5da 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -56,6 +56,20 @@
 #endif
 
 
+#define UNI_MAX_UTF16               0x0010FFFF
+#define UNI_HALF_BASE               0x00010000
+#define UNI_HALF_MASK               0x000003FF
+#define UNI_HALF_SHIFT              10
+#define UNI_SUR_HIGH_START          0xD800
+#define UNI_SUR_LOW_START           0xDC00
+#define UNI_SUR_LOW_END             0xDFFF
+
+
+#define NTLM_NEGOTIATE_UNICODE      (1<<0)
+#define NTLM_NEGOTIATE_OEM          (1<<1)
+#define NTLM_NEGOTIATE_NTLM2_KEY    (1<<19)
+#define NTLM_NEGOTIATE_TARGET_INFO  (1<<23)
+
 
 
 static void
@@ -79,8 +93,10 @@ gen_md4_hash (const char* data, int data_len, char *result)
   const md_kt_t *md4_kt = md_kt_get("MD4");
   char md[MD4_DIGEST_LENGTH];
 
-  md_full(md4_kt, data, data_len, md);
-  memcpy (result, md, MD4_DIGEST_LENGTH);
+  if (data_len >= 0) {
+    md_full(md4_kt, data, data_len, md);
+    memcpy (result, md, MD4_DIGEST_LENGTH);
+  }
 }
 
 static void
@@ -140,23 +156,92 @@ unsigned char *my_strupr(unsigned char *str)
 }
 
 static int
-unicodize (char *dst, const char *src)
+utf8_to_utf16LE (unsigned char *dst, int dst_len, unsigned char *src)
 {
-  /* not really unicode... */
-  int i = 0;
-  do
+  /* Convert UTF-8 to UTF-16 little endian
+   *
+   * http://clang.llvm.org/doxygen/ConvertUTF_8c_source.html
+   */
+  unsigned char *end = src + strlen(src),
+                *dst_start = dst;
+  const char trailingBytesForUTF8[256] = {
+              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
+              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
+              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
+              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
+              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
+              0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
+              1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
+              2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2, 3,3,3,3,3,3,3,3,4,4,4,4,5,5,5,5
+  };
+  const unsigned int offsetsUtf8[6] = { 0x00000000UL, 0x00003080UL, 0x000E2080UL,
+                                        0x03C82080UL, 0xFA082080UL, 0x82082080UL };
+
+  while (src < end)
     {
-      dst[i++] = *src;
-      dst[i++] = 0;
+      unsigned int ch = 0,
+                   extraBytes = trailingBytesForUTF8[*src];
+
+      if (extraBytes >= end - src)
+        return -1;
+
+      /* The cases all fall through. */
+      switch (extraBytes) {
+        case 5: ch += *src++; ch <<= 6;
+        case 4: ch += *src++; ch <<= 6;
+        case 3: ch += *src++; ch <<= 6;
+        case 2: ch += *src++; ch <<= 6;
+        case 1: ch += *src++; ch <<= 6;
+        case 0: ch += *src++;
+      }
+      ch -= offsetsUtf8[extraBytes];     /* clean up UTF-8 control bits */
+
+      /* Now 'ch' contains the codepoint of the UTF-8-character. */
+
+      if (ch <= 0xFFFF)
+      {
+        if (ch >= UNI_SUR_HIGH_START && ch <= UNI_SUR_LOW_END) {
+          msg (M_INFO, "Warning: Illegal character value: %x is in reserved area of UTF-16 [%x, %x]", UNI_SUR_HIGH_START, UNI_SUR_LOW_END);
+          return -1;
+        }
+        else {    /* normal case */
+          if (dst_len - (dst - dst_start) < 2) {
+            msg (M_INFO, "Warning: Not enough space in destination buffer for conversion to UTF-16");
+            return -1;
+          }
+          *dst++ = ch & 0xff;
+          *dst++ = (ch >> 8) & 0xff;
+        }
+      }
+      else if (ch > UNI_MAX_UTF16) {
+          msg (M_INFO, "Warning: Illegal character value :%x is too large for UTF-16", ch);
+          return -1;
+      }
+      else {
+        /* character is in range 0xFFFF - 0x10FFFF. */
+        if (dst_len - (dst - dst_start) < 4) {
+          msg (M_INFO, "Warning: Not enough space in destination buffer for conversion to UTF-16");
+          return -1;
+        }
+        ch -= UNI_HALF_BASE;
+        *dst++ = ( (ch >> UNI_HALF_SHIFT) + UNI_SUR_HIGH_START)        & 0xff;
+        *dst++ = (((ch >> UNI_HALF_SHIFT) + UNI_SUR_HIGH_START) >> 8) & 0xff;
+        *dst++ = ( (ch & UNI_HALF_MASK) + UNI_SUR_LOW_START)           & 0xff;
+        *dst++ = (((ch & UNI_HALF_MASK) + UNI_SUR_LOW_START) >> 8)    & 0xff;
+      }
     }
-  while (*src++);
 
-  return i;
+  return dst - dst_start;
 }
 
 static void
-add_security_buffer(int sb_offset, void *data, int length, unsigned char *msg_buf, int *msg_bufpos)
+add_security_buffer(int sb_offset, void *data, int length, unsigned char *msg_buf, int *msg_bufpos, int msg_buflen)
 {
+  if ((*msg_bufpos - *msg_buf) + length > msg_buflen) {
+    msg (M_INFO, "Warning: Not enough space in destination buffer");
+    return;
+  }
+
 	/* Adds security buffer data to a message and sets security buffer's offset and length */
 	msg_buf[sb_offset] = (unsigned char)length;
 	msg_buf[sb_offset + 2] = msg_buf[sb_offset];
@@ -195,10 +280,12 @@ ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, struct gc_ar
   char pwbuf[sizeof (p->up.password) * 2]; /* for unicode password */
   char buf2[128]; /* decoded reply from proxy */
   unsigned char phase3[464];
+  unsigned long ntlm_negotiate_flags;
 
   char md4_hash[MD4_DIGEST_LENGTH+5];
   char challenge[8], ntlm_response[24];
   int i, ret_val;
+  int ntlm_unicode;
 
 	char ntlmv2_response[144];
 	char userdomain_u[256]; /* for uppercase unicode username and domain */
@@ -211,7 +298,9 @@ ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, struct gc_ar
 	size_t len;
 
 	char domain[128];
-	char username[128];
+  char domain_u[256];
+  char username[USER_PASS_LEN];
+  char username_u[USER_PASS_LEN*2];
 	char *separator;
 
 	bool ntlmv2_enabled = (p->auth_method == HTTP_AUTH_NTLM2);
@@ -238,7 +327,7 @@ ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, struct gc_ar
 
 
   /* fill 1st 16 bytes with md4 hash, disregard terminating null */
-  gen_md4_hash (pwbuf, unicodize (pwbuf, p->up.password) - 2, md4_hash);
+  gen_md4_hash (pwbuf, utf8_to_utf16LE(pwbuf, sizeof (p->up.password) * 2, (unsigned char*)p->up.password), md4_hash);
 
   /* pad to 21 bytes */
   memset(md4_hash + MD4_DIGEST_LENGTH, 0, 5);
@@ -250,23 +339,36 @@ ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, struct gc_ar
   /* we can be sure that phase_2 is less than 128
    * therefore buf2 needs to be (3/4 * 128) */
 
+  /* extract NegotiateFlags from bytes 20-23 */
+  ntlm_negotiate_flags = (buf2[0x14] & 0xff) | (buf2[0x15] & 0xff) << 8 | (buf2[0x16] & 0xff) << 16 | (buf2[0x17] & 0xff) << 24;
+
+  ntlm_unicode = ntlm_negotiate_flags & NTLM_NEGOTIATE_UNICODE ? 1 : 0;
+
   /* extract the challenge from bytes 24-31 */
   for (i=0; i<8; i++)
   {
     challenge[i] = buf2[i+24];
   }
 
+  msg (M_DEBUG, "Received NTLM negotiate flags 0x%08x: %s encoding, %sNTLM2sec, %sTargetInfo - doing NTLMv%s",
+                 ntlm_negotiate_flags, ntlm_unicode ? "Unicode":"OEM",
+                 ntlm_negotiate_flags & NTLM_NEGOTIATE_NTLM2_KEY ? "":"no ",
+                 ntlm_negotiate_flags & NTLM_NEGOTIATE_TARGET_INFO ? "":"no ",
+                 ntlmv2_enabled ? "2":"1");
+
 	if (ntlmv2_enabled){ /* Generate NTLMv2 response */
 	        int tib_len;
 
 		/* NTLMv2 hash */
-	        my_strupr((unsigned char *)strcpy(userdomain, username));
+		my_strupr((unsigned char *)strcpy(userdomain, username));
 		if (strlen(username) + strlen(domain) < sizeof(userdomain))
 			strcat(userdomain, domain);
 		else
 			msg (M_INFO, "Warning: Username or domain too long");
-		unicodize (userdomain_u, userdomain);
-		gen_hmac_md5(userdomain_u, 2 * strlen(userdomain), md4_hash, MD5_DIGEST_LENGTH, ntlmv2_hash);
+		len = utf8_to_utf16LE (userdomain_u, sizeof(userdomain_u), userdomain);
+		if (len >= 0) {
+		  gen_hmac_md5(userdomain_u, len, md4_hash, MD5_DIGEST_LENGTH, ntlmv2_hash);
+		}
 
 		/* NTLMv2 Blob */
 		memset(ntlmv2_blob, 0, 128);                /* Clear blob buffer */ 
@@ -278,8 +380,8 @@ ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, struct gc_ar
 		ntlmv2_blob[0x18]=0;                        /* Unknown, zero should work */
 
 		/* Add target information block to the blob */
-		if (( *((long *)&buf2[0x14]) & 0x00800000) == 0x00800000){ /* Check for Target Information block */
-			tib_len = buf2[0x28];/* Get Target Information block size */
+		if (ntlm_negotiate_flags & NTLM_NEGOTIATE_TARGET_INFO){    /* Check for Target Information block */
+			tib_len = buf2[0x28] & 0xff | (buf2[0x29] & 0xff) << 8;  /* Get Target Information block size */
 			if (tib_len > 96) tib_len = 96;
 			{
 			  char *tib_ptr = buf2 + buf2[0x2c]; /* Get Target Information block pointer */
@@ -292,7 +394,7 @@ ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, struct gc_ar
 		ntlmv2_blob[0x1c + tib_len] = 0;            /* Unknown, zero works */ 
 
 		/* Get blob length */
-		ntlmv2_blob_size = 0x20 + tib_len; 
+		ntlmv2_blob_size = 0x1c + tib_len;
 
 		/* Add challenge from message 2 */
 		memcpy(&ntlmv2_response[8], challenge, 8);
@@ -323,16 +425,33 @@ ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, struct gc_ar
 	phase3[8] = 3; /* type 3 */
 
 	if (ntlmv2_enabled){ /* NTLMv2 response */
-		add_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 16, phase3, &phase3_bufpos);
+		add_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 16, phase3, &phase3_bufpos, sizeof(phase3));
 	}else{ /* NTLM response */
-		add_security_buffer(0x14, ntlm_response, 24, phase3, &phase3_bufpos);
+		add_security_buffer(0x14, ntlm_response, 24, phase3, &phase3_bufpos, sizeof(phase3));
 	}
 	
-	/* username in ascii */
-	add_security_buffer(0x24, username, strlen (username), phase3, &phase3_bufpos);
+  /* Set username. */
+  if (ntlm_unicode) {
+    len = utf8_to_utf16LE(username_u, sizeof(username_u), username);
+    if (len>=0) {
+      add_security_buffer(0x24, username_u, len, phase3, &phase3_bufpos, sizeof(phase3));
+    }
+  }
+  else {
+    add_security_buffer(0x24, username, strlen(username), phase3, &phase3_bufpos, sizeof(phase3));
+  }
+
 
 	/* Set domain. If <domain> is empty, default domain will be used (i.e. proxy's domain) */ 
-	add_security_buffer(0x1c, domain, strlen (domain), phase3, &phase3_bufpos);
+  if (ntlm_unicode) {
+    len = utf8_to_utf16LE(domain_u, sizeof(domain_u), domain);
+    if (len>=0) {
+      add_security_buffer(0x1c, domain_u, len, phase3, &phase3_bufpos, sizeof(phase3));
+    }
+  }
+  else {
+    add_security_buffer(0x1c, domain, strlen(domain), phase3, &phase3_bufpos, sizeof(phase3));
+  }
 	
 
 	/* other security buffers will be empty */
@@ -341,7 +460,7 @@ ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, struct gc_ar
 	phase3[0x38] = phase3_bufpos; /* no session key */
 	
 	/* flags */
-  phase3[0x3c] = 0x02; /* negotiate oem */
+  phase3[0x3c] = ntlm_unicode ? 0x01 : 0x02; /* negotiate unicode/oem */
   phase3[0x3d] = 0x02; /* negotiate ntlm */
 
   return ((const char *)make_base64_string2 ((unsigned char *)phase3, phase3_bufpos, gc));
-- 
tg: (fce39ec..) t/0006/fix_ntlm_http_auth (depends on: t/0005/ignore_utf8_bom)

