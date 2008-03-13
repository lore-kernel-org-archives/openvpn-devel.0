Message-ID: <47D93FE9.4030600@...1068...>
Date: Thu, 13 Mar 2008 15:53:29 +0100
From: Mirek Zajic <zajic@...1068...>
MIME-Version: 1.0
References: <478C94C4.1050409@...1068...>	
	<9e0cf0bf0801150345i749f5ca6na1f8343b6da390fc@...278...>	
	<9e0cf0bf0801150345p4639a831ub8f85fd56bda48db@...278...>	
	<478CAD6A.3010808@...1068...>	
	<9e0cf0bf0801150522x72621b20pc36373986f2ad8a1@...278...>	
	<47D7CBC2.6020606@...1068...>	
	<9e0cf0bf0803120802x53ed773ev38f25064069909e9@...278...>	
	<47D7F911.50307@...1068...>
	<9e0cf0bf0803130645i1f84a228r2b983a00e7159faa@...278...>
In-Reply-To: <9e0cf0bf0803130645i1f84a228r2b983a00e7159faa@...278...>
Subject: Re: [Openvpn-devel] NTLMv2 patch corrected
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

I'm sending NTLMv2 patch again. I hope that everything is correct now 
:-) Again thanks to Alon for his feedback.


Miroslav Zajic
NextSoft s.r.o.

P.S. I moved int64 macros to ntlm.c. I left them unchanged, becouse they 
could be useful in future.


diff -Naur openvpn-2.1/ntlm.c openvpn-NTLMv2-predelane-2.1/ntlm.c
--- openvpn-2.1/ntlm.c    2008-01-13 21:25:52.915264000 +0100
+++ openvpn-NTLMv2-predelane-2.1/ntlm.c    2008-03-13 15:29:31.109375000 
+0100
@@ -3,6 +3,8 @@
  *
  *  Copyright (C) 2004 William Preston
  *
+ *  *NTLMv2 support and domain name parsing by Miroslav Zajic, NextSoft 
s.r.o.*
+ *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
  *  the Free Software Foundation; either version 2 of the License, or
@@ -41,6 +43,21 @@
 
 #include "memdbg.h"
 
+
+/* 64bit datatype macros */
+#ifdef _MSC_VER
+    /* MS compilers */
+#    define UINTEGER64 __int64
+#    define UINT64(c) c ## Ui64
+#else
+    /* Non MS compilers */
+#    define UINTEGER64 unsigned long long
+#    define UINT64(c) c ## LL
+#endif
+
+
+
+
 static void
 create_des_keys(const unsigned char *hash, unsigned char *key)
 {
@@ -70,6 +87,61 @@
   memcpy (result, md, 16);
 }
 
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
+static void
+gen_timestamp (unsigned char *timestamp)
+{
+    /* Copies 8 bytes long timestamp into "timestamp" buffer.
+     * Timestamp is Little-endian, 64-bit signed value representing the 
number of tenths of a microsecond since January 1, 1601.
+     */
+
+    UINTEGER64 timestamp_ull;
+
+    timestamp_ull = openvpn_time(NULL);
+    timestamp_ull = (timestamp_ull + UINT64(11644473600)) * 
UINT64(10000000);
+
+    /* store little endian value */
+    timestamp[0]= timestamp_ull & UINT64(0xFF);
+    timestamp[1]= (timestamp_ull  >> 8)  & UINT64(0xFF);
+    timestamp[2]= (timestamp_ull  >> 16) & UINT64(0xFF);
+    timestamp[3]= (timestamp_ull  >> 24) & UINT64(0xFF);
+    timestamp[4]= (timestamp_ull  >> 32) & UINT64(0xFF);
+    timestamp[5]= (timestamp_ull  >> 40) & UINT64(0xFF);
+    timestamp[6]= (timestamp_ull  >> 48) & UINT64(0xFF);
+    timestamp[7]= (timestamp_ull  >> 56) & UINT64(0xFF);
+}
+
+static void
+gen_nonce (unsigned char *nonce)
+{
+    /* Generates 8 random bytes to be used as client nonce */
+    int i;
+
+    for(i=0;i<8;i++){
+        nonce[i] = (unsigned char)get_random();
+    }
+}
+
+unsigned char *my_strupr(unsigned char *str)
+{
+    /* converts string to uppercase in place */
+    unsigned char *tmp = str;;
+
+    do *str = toupper(*str); while (*(++str));
+    return tmp;
+}
+
 static int
 unicodize (char *dst, const char *src)
 {
@@ -85,6 +157,18 @@
   return i;
 }
 
+static void
+add_security_buffer(int sb_offset, void *data, int length, unsigned 
char *msg_buf, int *msg_bufpos)
+{
+    /* Adds security buffer data to a message and sets security 
buffer's offset and length */
+    msg_buf[sb_offset] = (unsigned char)length;
+    msg_buf[sb_offset + 2] = msg_buf[sb_offset];
+    msg_buf[sb_offset + 4] = (unsigned char)(*msg_bufpos & 0xff);
+    msg_buf[sb_offset + 5] = (unsigned char)((*msg_bufpos >> 8) & 0xff);
+    memcpy(&msg_buf[*msg_bufpos], data, msg_buf[sb_offset]);
+    *msg_bufpos += length;
+}
+
 const char *
 ntlm_phase_1 (const struct http_proxy_info *p, struct gc_arena *gc)
 {
@@ -105,23 +189,56 @@
 const char *
 ntlm_phase_3 (const struct http_proxy_info *p, const char *phase_2, 
struct gc_arena *gc)
 {
+    /* NTLM handshake
+     *
+     * http://davenport.sourceforge.net/ntlm.html
+     *
+     */
+   
   char pwbuf[sizeof (p->up.password) * 2]; /* for unicode password */
   char buf2[128]; /* decoded reply from proxy */
-  char phase3[146];
+  unsigned char phase3[464];
 
   char md4_hash[21];
-  char challenge[8], response[24];
-  int i, ret_val, buflen;
+  char challenge[8], ntlm_response[24];
+  int i, ret_val;
   des_cblock key1, key2, key3;
   des_key_schedule sched1, sched2, sched3;
 
-  /* try a minimal NTLM handshake
-   *
-   * http://davenport.sourceforge.net/ntlm.html
-   *
-   */
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
   ASSERT (strlen (p->up.username) > 0);
   ASSERT (strlen (p->up.password) > 0);
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
 
   /* fill 1st 16 bytes with md4 hash, disregard terminating null */
   gen_md4_hash (pwbuf, unicodize (pwbuf, p->up.password) - 2, md4_hash);
@@ -139,48 +256,95 @@
     challenge[i] = buf2[i+24];
   }
 
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
+    if (ntlmv2_enabled){ /* Generate NTLMv2 response */
+       
+        /* NTLMv2 hash */
+        my_strupr(strcpy(userdomain, username));
+        if (strlen(username) + strlen(domain) < sizeof(userdomain))
+            strcat(userdomain, domain);
+        else
+            msg (M_INFO, "Warning: Username or domain too long");
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
+        int tib_len;
+        if (( *((long *)&buf2[0x14]) & 0x00800000) == 0x00800000){ /* 
Check for Target Information block */
+            tib_len = buf2[0x28];/* Get Target Information block size */
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
   phase3[0x3c] = 0x02; /* negotiate oem */
   phase3[0x3d] = 0x02; /* negotiate ntlm */
 
-  return ((const char *)make_base64_string2 ((unsigned char *)phase3, 
buflen, gc));
+  return ((const char *)make_base64_string2 ((unsigned char *)phase3, 
phase3_bufpos, gc));
 }
 
 #else
diff -Naur openvpn-2.1/proxy.c openvpn-NTLMv2-predelane-2.1/proxy.c
--- openvpn-2.1/proxy.c    2008-01-13 21:25:52.945307200 +0100
+++ openvpn-NTLMv2-predelane-2.1/proxy.c    2008-01-15 
11:46:12.737156800 +0100
@@ -294,19 +294,21 @@
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
       get_user_pass_http (p, true);
     }
 
 #if !NTLM
-  if (p->auth_method == HTTP_AUTH_NTLM)
+  if (p->auth_method == HTTP_AUTH_NTLM || p->auth_method == 
HTTP_AUTH_NTLM2)
     msg (M_FATAL, "Sorry, this version of " PACKAGE_NAME " was built 
without NTLM Proxy support.");
 #endif
 
@@ -374,6 +376,12 @@
 
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
@@ -411,7 +419,7 @@
       msg (D_PROXY, "Proxy requires authentication");
 
       /* check for NTLM */
-      if (p->auth_method == HTTP_AUTH_NTLM)
+      if (p->auth_method == HTTP_AUTH_NTLM || p->auth_method == 
HTTP_AUTH_NTLM2)
         {
 #if NTLM
           /* look for the phase 2 response */
@@ -456,6 +464,12 @@
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
diff -Naur openvpn-2.1/proxy.h openvpn-NTLMv2-predelane-2.1/proxy.h
--- openvpn-2.1/proxy.h    2008-01-13 21:25:52.975350400 +0100
+++ openvpn-NTLMv2-predelane-2.1/proxy.h    2008-01-15 
11:25:00.097190400 +0100
@@ -59,6 +59,7 @@
 #define HTTP_AUTH_BASIC 1
 #define HTTP_AUTH_NTLM  2
 #define HTTP_AUTH_N     3
+#define HTTP_AUTH_NTLM2 4
 
 struct http_proxy_options {
   const char *server;


