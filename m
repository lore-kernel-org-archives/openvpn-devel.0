Message-ID: <478A4D83.6060709@...1068...>
Date: Sun, 13 Jan 2008 18:42:27 +0100
From: Mirek Zajic <zajic@...1068...>
MIME-Version: 1.0
Subject: [Openvpn-devel] NTLMv2 patch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I'm sending the patch for NTLMv2 proxy authorization support. Please 
note that I diffed against version 2.0.9 because it was the version that 
I modified. Hope that it's not too confusing.

The features are:
-NTLMv2 support
-Allows user to specify authorization domain in username (both 
DOMAIN\username and username@...1071... forms are supported). Applies both 
to NTLM and NTLMv2.
-Uses keep-alive connection to proxy for NTLM and NTLMv2 to fix problems 
with for ex. Squid proxy.

Tested with:
-ISA server
-Squid proxy
host OS both Windows XP and Linux


Miroslav Zajic
Nextsoft s.r.o.





diff -Naur openvpn-2.0.9/ntlm.c openvpn-NTLMv2-2.0.9/ntlm.c
--- openvpn-2.0.9/ntlm.c    2005-12-12 09:23:58.000000000 +0100
+++ openvpn-NTLMv2-2.0.9/ntlm.c    2008-01-13 18:18:45.761992000 +0100
@@ -3,6 +3,8 @@
  *
  *  Copyright (C) 2004 William Preston
  *
+ *  *NTLMv2 support and domain name parsing by Miroslav Zajic, Nextsoft 
s.r.o.*
+ *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
  *  the Free Software Foundation; either version 2 of the License, or
@@ -41,146 +43,332 @@
 
 #include "memdbg.h"
 
+
+
 static void
 create_des_keys(const unsigned char *hash, unsigned char *key)
 {
-  key[0] = hash[0];
-  key[1] = ((hash[0]&1)<<7)|(hash[1]>>1);
-  key[2] = ((hash[1]&3)<<6)|(hash[2]>>2);
-  key[3] = ((hash[2]&7)<<5)|(hash[3]>>3);
-  key[4] = ((hash[3]&15)<<4)|(hash[4]>>4);
-  key[5] = ((hash[4]&31)<<3)|(hash[5]>>5);
-  key[6] = ((hash[5]&63)<<2)|(hash[6]>>6);
-  key[7] = ((hash[6]&127)<<1);
-  des_set_odd_parity((des_cblock *)key);
+    key[0] = hash[0];
+    key[1] = ((hash[0]&1)<<7)|(hash[1]>>1);
+    key[2] = ((hash[1]&3)<<6)|(hash[2]>>2);
+    key[3] = ((hash[2]&7)<<5)|(hash[3]>>3);
+    key[4] = ((hash[3]&15)<<4)|(hash[4]>>4);
+    key[5] = ((hash[4]&31)<<3)|(hash[5]>>5);
+    key[6] = ((hash[5]&63)<<2)|(hash[6]>>6);
+    key[7] = ((hash[6]&127)<<1);
+    des_set_odd_parity((des_cblock *)key);
 }
 
+
 static void
 gen_md4_hash (const char* data, int data_len, char *result)
 {
-  /* result is 16 byte md4 hash */
+    /* result is 16 byte md4 hash */
+
+    MD4_CTX c;
+    char md[16];
+
+    MD4_Init (&c);
+    MD4_Update (&c, data, data_len);
+    MD4_Final ((unsigned char *)md, &c);
+
+    memcpy (result, md, 16);
+}
+
+
+static void
+gen_hmac_md5 (const char* data, int data_len, const char* key, int 
key_len,char *result)
+{
+    unsigned int len;
+
+    HMAC_CTX c;
+    HMAC_Init (&c, key, key_len, EVP_md5());
+    HMAC_Update (&c, data, data_len);
+    HMAC_Final (&c, result, &len);
+    HMAC_CTX_cleanup(&c);
+}
+
+
+static void
+gen_timestamp (unsigned char *timestamp)
+{
+    /* Copies 8 bytes long timestamp into "timestamp" buffer.
+     * Timestamp is Little-endian, 64-bit signed value representing the 
number of tenths of a microsecond since January 1, 1601.
+     */
+
+    unsigned char bufA[8]; /* Buffer for 64-bit computing */
+    unsigned char bufB[8]; /* Second buffer  */
+    int a, b, c, tmp, tmp2, carry;
+
+    /* set 64-bit buffer A with current time (seconds since 00:00:00 
1.1.1970) */
+    *(unsigned int *)bufA =     (unsigned int)time(NULL);
+    *(unsigned int *)&bufA[4] = (unsigned int)0;
+
+    /* 64-bit adition of 0x02B6109100 (seconds between 00:00:00 
1.1.1601 and 00:00:00 1.1.1970) */
+    *(unsigned int *)bufB =     (unsigned int)0xB6109100;
+    *(unsigned int *)&bufB[4] = (unsigned int)0x00000002;
+
+    carry=0;
+    for (a=0; a<8; a++){ /* lame adition */
+        tmp = (unsigned int)bufA[a] + (unsigned int)bufB[a] + carry;
+        bufA[a] = tmp & 0xFF;
+        carry = (tmp & 0xFF00) >> 8;
+    }
+    
+    /* 64-bit multiply by 10000000 = 0x989680 (converting seconds to 
tenths of microseconds) */
+    *(unsigned int *)bufB =           (unsigned int)0x00989680;
+    *(unsigned int *)&bufB[4] =       (unsigned int)0x00000000;
+    *(unsigned int *)timestamp =      (unsigned int)0x00000000;
+    *(unsigned int *)&timestamp[4] =  (unsigned int)0x00000000;
+
+    for (a=0; a<8; a++){ /* lame multiply */
+        for (b=0; b<8; b++){
+            tmp = (unsigned int)bufA[a] * (unsigned int)bufB[b];
+            carry=0;
+            for (c=b; (c<8-a) && (c < b + 3); c++){
+                tmp2 = ((tmp & (0xFF << ((c-b) * 8))) >> ((c-b) * 8)) + 
(unsigned int)timestamp[a+c] + carry;
+                timestamp[a+c] = tmp2 & 0xFF;
+                carry = (tmp2 & 0xFF00) >> 8;
+            }
+        }
+    }
+}
+
 
-  MD4_CTX c;
-  char md[16];
+static void
+gen_nonce (unsigned char *nonce)
+{
+    /* Generates 8 random bytes to be used as client nonce */
+    int i;
+
+    for(i=0;i<8;i++);
+        nonce[i] = (unsigned char)random();
+}
 
-  MD4_Init (&c);
-  MD4_Update (&c, data, data_len);
-  MD4_Final ((unsigned char *)md, &c);
 
-  memcpy (result, md, 16);
+unsigned char *my_strupr(unsigned char *str)
+{
+    /* converts string to uppercase in place */
+
+    unsigned char *tmp;
+    tmp = str;
+    do
+    {
+        if (*str >= 'a' && *str <= 'z')
+            *str -= 32;
+    }
+    while (*(++str));
+    return tmp;
 }
 
+
 static int
 unicodize (char *dst, const char *src)
 {
-  /* not really unicode... */
-  int i = 0;
-  do
-    {
-      dst[i++] = *src;
-      dst[i++] = 0;
-    }
-  while (*src++);
+    /* not really unicode... */
+    int i = 0;
+    do
+        {
+            dst[i++] = *src;
+            dst[i++] = 0;
+        }
+    while (*src++);
 
-  return i;
+    return i;
 }
 
+
+static void
+add_security_buffer(int sb_offset, void *data, int length, unsigned 
char *msg_buf, int *msg_bufpos)
+{
+    /* Adds security buffer data to a message and sets security 
buffer's offset and length */
+    msg_buf[sb_offset] = (unsigned char)length;
+    msg_buf[sb_offset + 2] = msg_buf[sb_offset];
+    msg_buf[sb_offset + 4] = *msg_bufpos;
+    memcpy(&msg_buf[*msg_bufpos], data, msg_buf[sb_offset]);
+    *msg_bufpos += length;
+}
+
+
+
+
+
 const char *
 ntlm_phase_1 (const struct http_proxy_info *p, struct gc_arena *gc)
 {
-  struct buffer out = alloc_buf_gc (96, gc);
-  /* try a minimal NTLM handshake
-   *
-   * http://davenport.sourceforge.net/ntlm.html
-   *
-   * This message contains only the NTLMSSP signature,
-   * the NTLM message type,
-   * and the minimal set of flags (Negotiate NTLM and Negotiate OEM).
-   *
-   */
-  buf_printf (&out, "%s", "TlRMTVNTUAABAAAAAgIAAA==");
-  return (BSTR (&out));
+    struct buffer out = alloc_buf_gc (96, gc);
+    /* try a minimal NTLM handshake
+     *
+     * http://davenport.sourceforge.net/ntlm.html
+     *
+     * This message contains only the NTLMSSP signature,
+     * the NTLM message type,
+     * and the minimal set of flags (Negotiate NTLM and Negotiate OEM).
+     *
+     */
+    buf_printf (&out, "%s", "TlRMTVNTUAABAAAAAgIAAA==");
+    return (BSTR (&out));
 }
 
+
 const char *
 ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, 
struct gc_arena *gc)
 {
-  char pwbuf[sizeof (p->up.password) * 2]; /* for unicode password */
-  char buf2[128]; /* decoded reply from proxy */
-  char phase3[146];
-
-  char md4_hash[21];
-  char challenge[8], response[24];
-  int i, ret_val, buflen;
-  des_cblock key1, key2, key3;
-  des_key_schedule sched1, sched2, sched3;
-
-  /* try a minimal NTLM handshake
-   *
-   * http://davenport.sourceforge.net/ntlm.html
-   *
-   */
-  ASSERT (strlen (p->up.username) > 0);
-  ASSERT (strlen (p->up.password) > 0);
-
-  /* fill 1st 16 bytes with md4 hash, disregard terminating null */
-  gen_md4_hash (pwbuf, unicodize (pwbuf, p->up.password) - 2, md4_hash);
-
-  /* pad to 21 bytes */
-  memset (md4_hash + 16, 0, 5);
-
-  ret_val = base64_decode( phase_2, (void *)buf2);
-  /* we can be sure that phase_2 is less than 128
-   * therefore buf2 needs to be (3/4 * 128) */
-
-  /* extract the challenge from bytes 24-31 */
-  for (i=0; i<8; i++)
-  {
-    challenge[i] = buf2[i+24];
-  }
-
-  create_des_keys ((unsigned char *)md4_hash, key1);
-  des_set_key_unchecked ((des_cblock *)key1, sched1);
-  des_ecb_encrypt ((des_cblock *)challenge, (des_cblock *)response, 
sched1, DES_ENCRYPT);
-
-  create_des_keys ((unsigned char *)&(md4_hash[7]), key2);
-  des_set_key_unchecked ((des_cblock *)key2, sched2);
-  des_ecb_encrypt ((des_cblock *)challenge, (des_cblock 
*)&(response[8]), sched2, DES_ENCRYPT);
-
-  create_des_keys ((unsigned char *)&(md4_hash[14]), key3);
-  des_set_key_unchecked ((des_cblock *)key3, sched3);
-  des_ecb_encrypt ((des_cblock *)challenge, (des_cblock 
*)&(response[16]), sched3, DES_ENCRYPT);
-
-  /* clear reply */
-  memset (phase3, 0, sizeof (phase3));
-
-  strcpy (phase3, "NTLMSSP\0");
-  phase3[8] = 3; /* type 3 */
-
-  buflen = 0x58 + strlen (p->up.username);
-  if (buflen > (int) sizeof (phase3))
-    buflen = sizeof (phase3);
-
-  phase3[0x10] = buflen; /* lm not used */
-  phase3[0x20] = buflen; /* default domain (i.e. proxy's domain) */
-  phase3[0x30] = buflen; /* no workstation name supplied */
-  phase3[0x38] = buflen; /* no session key */
-
-  phase3[0x14] = 24; /* ntlm response is 24 bytes long */
-  phase3[0x16] = phase3[0x14];
-  phase3[0x18] = 0x40; /* ntlm offset */
-  memcpy (&(phase3[0x40]), response, 24);
-
-
-  phase3[0x24] = strlen (p->up.username); /* username in ascii */
-  phase3[0x26] = phase3[0x24];
-  phase3[0x28] = 0x58;
-  strncpy (&(phase3[0x58]), p->up.username, sizeof (phase3) - 0x58);
-
-  phase3[0x3c] = 0x02; /* negotiate oem */
-  phase3[0x3d] = 0x02; /* negotiate ntlm */
+    /* NTLM handshake
+     *
+     * http://davenport.sourceforge.net/ntlm.html
+     *
+     */
+    
+    char pwbuf[sizeof (p->up.password) * 2]; /* for unicode password */
+    char buf2[128]; /* decoded reply from proxy */
+    unsigned char phase3[464];
+
+    char md4_hash[21];
+    char challenge[8], ntlm_response[24];
+    int i, ret_val;
+    des_cblock key1, key2, key3;
+    des_key_schedule sched1, sched2, sched3;
+
+    char ntlmv2_response[144];
+    char userdomain_u[256]; /* for uppercase unicode username and domain */
+    char userdomain[128];   /* the same as previous but ascii */
+    char ntlmv2_hash[16];
+    char ntlmv2_hmacmd5[16];
+    char *ntlmv2_blob = ntlmv2_response + 16; /* inside 
ntlmv2_response, length: 128 */
+    int ntlmv2_blob_size=0;
+    int phase3_bufpos = 0x40; /* offset to next security buffer data to 
be added */
+    int len;
+
+    char domain[128];
+    char username[128];
+    char *separator;
+
+    bool ntlmv2_enabled = (p->auth_method == HTTP_AUTH_NTLM2);
+
+
+    ASSERT (strlen (p->up.username) > 0);
+    ASSERT (strlen (p->up.password) > 0);
+    
+    /* username parsing */
+    separator = strchr(p->up.username, '\\');
+    if (separator == NULL) {
+        strncpy(username, p->up.username, sizeof(username)-1);
+        username[sizeof(username)-1]=0;
+        domain[0]=0;
+    } else {
+        strncpy(username, separator+1, sizeof(username)-1);
+        username[sizeof(username)-1]=0;
+        len = separator - p->up.username;
+        if (len > sizeof(domain) - 1) len = sizeof(domain) - 1;
+        strncpy(domain, p->up.username,  len);
+        domain[len]=0;
+    }
+
+
+    /* fill 1st 16 bytes with md4 hash, disregard terminating null */
+    gen_md4_hash (pwbuf, unicodize (pwbuf, p->up.password) - 2, md4_hash);
+
+    /* pad to 21 bytes */
+    memset (md4_hash + 16, 0, 5);
+
+    ret_val = base64_decode( phase_2, (void *)buf2);
+    /* we can be sure that phase_2 is less than 128
+     * therefore buf2 needs to be (3/4 * 128) */
+
+    /* extract the challenge from bytes 24-31 */
+    for (i=0; i<8; i++)
+    {
+        challenge[i] = buf2[i+24];
+    }
+
+    if (ntlmv2_enabled){ /* Generate NTLMv2 response */
+        
+        /* NTLMv2 hash */
+        my_strupr(strcpy(userdomain, username));
+        if (strlen(username) + strlen(domain) < sizeof(userdomain))
+            strcat(userdomain, domain);    
+        unicodize (userdomain_u, userdomain);
+        gen_hmac_md5(userdomain_u, 2 * strlen(userdomain), md4_hash, 
16, ntlmv2_hash);
+
+        /* NTLMv2 Blob */
+        memset(ntlmv2_blob, 0, 128);                /* Clear blob 
buffer */
+        ntlmv2_blob[0x00]=1;                        /* Signature */
+        ntlmv2_blob[0x01]=1;                        /* Signature */
+        ntlmv2_blob[0x04]=0;                        /* Reserved */
+        gen_timestamp(&ntlmv2_blob[0x08]);          /* 64-bit Timestamp */
+        gen_nonce(&ntlmv2_blob[0x10]);              /* 64-bit Client 
Nonce */
+        ntlmv2_blob[0x18]=0;                        /* Unknown, zero 
should work */
+
+        /* Add target information block to the blob */
+        unsigned short tib_len;
+        if (( *((long *)&buf2[0x14]) & 0x00800000) == 0x00800000){ /* 
Check for Target Information block */
+            tib_len = *((unsigned short *)&buf2[0x28]); /* Get Target 
Information block size */
+            if (tib_len > 96) tib_len = 96;
+            char *tib_ptr = buf2 + buf2[0x2c]; /* Get Target 
Information block pointer */
+            memcpy(&ntlmv2_blob[0x1c], tib_ptr, tib_len); /* Copy 
Target Information block into the blob */
+        } else {
+            tib_len = 0;
+        }
+
+        ntlmv2_blob[0x1c + tib_len] = 0;            /* Unknown, zero 
works */
+
+        /* Get blob length */
+        ntlmv2_blob_size = 0x20 + tib_len;
+
+        /* Add challenge from message 2 */
+        memcpy(&ntlmv2_response[8], challenge, 8);
+
+        /* hmac-md5 */
+        gen_hmac_md5(&ntlmv2_response[8], ntlmv2_blob_size + 8, 
ntlmv2_hash, 16, ntlmv2_hmacmd5);
+        
+        /* Add hmac-md5 result to the blob */
+        memcpy(ntlmv2_response, ntlmv2_hmacmd5, 16); /* Note: This 
overwrites challenge previously written at ntlmv2_response[8..15] */
+    
+    } else { /* Generate NTLM response */
+
+        create_des_keys ((unsigned char *)md4_hash, key1);
+        des_set_key_unchecked ((des_cblock *)key1, sched1);
+        des_ecb_encrypt ((des_cblock *)challenge, (des_cblock 
*)ntlm_response, sched1, DES_ENCRYPT);
+
+        create_des_keys ((unsigned char *)&(md4_hash[7]), key2);
+        des_set_key_unchecked ((des_cblock *)key2, sched2);
+        des_ecb_encrypt ((des_cblock *)challenge, (des_cblock 
*)&(ntlm_response[8]), sched2, DES_ENCRYPT);
+
+        create_des_keys ((unsigned char *)&(md4_hash[14]), key3);
+        des_set_key_unchecked ((des_cblock *)key3, sched3);
+        des_ecb_encrypt ((des_cblock *)challenge, (des_cblock 
*)&(ntlm_response[16]), sched3, DES_ENCRYPT);
+    }
+    
+    
+    memset (phase3, 0, sizeof (phase3)); /* clear reply */
+
+    strcpy (phase3, "NTLMSSP\0"); /* signature */
+    phase3[8] = 3; /* type 3 */
+
+    if (ntlmv2_enabled){ /* NTLMv2 response */
+        add_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 
16, phase3, &phase3_bufpos);
+    }else{ /* NTLM response */
+        add_security_buffer(0x14, ntlm_response, 24, phase3, 
&phase3_bufpos);
+    }
+    
+    /* username in ascii */
+    add_security_buffer(0x24, username, strlen (username), phase3, 
&phase3_bufpos);
+
+    /* Set domain. If <domain> is empty, default domain will be used 
(i.e. proxy's domain) */
+    add_security_buffer(0x1c, domain, strlen (domain), phase3, 
&phase3_bufpos);
+    
+
+    /* other security buffers will be empty */
+    phase3[0x10] = phase3_bufpos; /* lm not used */
+    phase3[0x30] = phase3_bufpos; /* no workstation name supplied */
+    phase3[0x38] = phase3_bufpos; /* no session key */
+    
+    /* flags */
+    phase3[0x3c] = 0x02; /* negotiate oem */
+    phase3[0x3d] = 0x02; /* negotiate ntlm */
 
-  return ((const char *)make_base64_string2 ((unsigned char *)phase3, 
buflen, gc));
+    return ((const char *)make_base64_string2 ((unsigned char *)phase3, 
phase3_bufpos, gc));
 }
 
 #else
diff -Naur openvpn-2.0.9/proxy.c openvpn-NTLMv2-2.0.9/proxy.c
--- openvpn-2.0.9/proxy.c    2005-12-12 09:30:26.000000000 +0100
+++ openvpn-NTLMv2-2.0.9/proxy.c    2007-10-29 17:30:52.264678400 +0100
@@ -241,13 +241,15 @@
     p->auth_method = HTTP_AUTH_BASIC;
       else if (!strcmp (o->auth_method_string, "ntlm"))
     p->auth_method = HTTP_AUTH_NTLM;
+      else if (!strcmp (o->auth_method_string, "ntlm2"))
+    p->auth_method = HTTP_AUTH_NTLM2;
       else
-    msg (M_FATAL, "ERROR: unknown HTTP authentication method: '%s' -- 
only the 'none', 'basic', or 'ntlm' methods are currently supported",
+    msg (M_FATAL, "ERROR: unknown HTTP authentication method: '%s' -- 
only the 'none', 'basic', 'ntlm', or 'ntlm2' methods are currently 
supported",
          o->auth_method_string);
     }
 
-  /* only basic and NTLM authentication supported so far */
-  if (p->auth_method == HTTP_AUTH_BASIC || p->auth_method == 
HTTP_AUTH_NTLM)
+  /* only basic and NTLM/NTLMv2 authentication supported so far */
+  if (p->auth_method == HTTP_AUTH_BASIC || p->auth_method == 
HTTP_AUTH_NTLM || p->auth_method == HTTP_AUTH_NTLM2)
     {
       get_user_pass (&static_proxy_user_pass,
              o->auth_file,
@@ -258,7 +260,7 @@
     }
 
 #if !NTLM
-  if (p->auth_method == HTTP_AUTH_NTLM)
+  if (p->auth_method == HTTP_AUTH_NTLM || p->auth_method == 
HTTP_AUTH_NTLM2)
     msg (M_FATAL, "Sorry, this version of " PACKAGE_NAME " was built 
without NTLM Proxy support.");
 #endif
 
@@ -302,6 +304,7 @@
     goto error;
     }
 
+
   /* auth specified? */
   switch (p->auth_method)
     {
@@ -320,6 +323,12 @@
 
 #if NTLM
     case HTTP_AUTH_NTLM:
+    case HTTP_AUTH_NTLM2:
+      /* keep-alive connection */
+      openvpn_snprintf (buf, sizeof(buf), "Proxy-Connection: Keep-Alive");
+      if (!send_line_crlf (sd, buf))
+    goto error;
+
       openvpn_snprintf (buf, sizeof(buf), "Proxy-Authorization: NTLM %s",
             ntlm_phase_1 (p, &gc));
       msg (D_PROXY, "Attempting NTLM Proxy-Authorization phase 1");
@@ -357,7 +366,7 @@
       msg (D_PROXY, "Proxy requires authentication");
 
       /* check for NTLM */
-      if (p->auth_method == HTTP_AUTH_NTLM)
+      if (p->auth_method == HTTP_AUTH_NTLM || p->auth_method == 
HTTP_AUTH_NTLM2)
         {
 #if NTLM
           /* look for the phase 2 response */
@@ -402,6 +411,12 @@
           if (!send_line_crlf (sd, buf))
             goto error;
 
+          /* keep-alive connection */
+          openvpn_snprintf (buf, sizeof(buf), "Proxy-Connection: 
Keep-Alive");
+          if (!send_line_crlf (sd, buf))
+            goto error;
+
+          
           /* send HOST etc, */
           openvpn_sleep (1);
           openvpn_snprintf (buf, sizeof(buf), "Host: %s", host);
diff -Naur openvpn-2.0.9/proxy.h openvpn-NTLMv2-2.0.9/proxy.h
--- openvpn-2.0.9/proxy.h    2005-11-01 03:06:12.000000000 +0100
+++ openvpn-NTLMv2-2.0.9/proxy.h    2007-10-29 14:07:31.941475200 +0100
@@ -35,6 +35,7 @@
 #define HTTP_AUTH_BASIC 1
 #define HTTP_AUTH_NTLM  2
 #define HTTP_AUTH_N     3
+#define HTTP_AUTH_NTLM2 4
 
 struct http_proxy_options {
   const char *server;



