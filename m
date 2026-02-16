From: Gert Doering <gert@...1296...>
Date: Mon, 16 Feb 2026 15:51:59 +0100
Message-ID: <20260216145205.14958-1-gert@...1296...>
In-Reply-To: <gerrit.1766158651000.I1f5724476862935284f620c54afa510eea03e3f9@...2715...>
References: <gerrit.1766158651000.I1f5724476862935284f620c54afa510eea03e3f9@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Remove NTLM support
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

Since Microsoft has abandonded this I think it is time
for us to do the same for OpenVPN 2.8.

Leaves a stub ntlm_support in to make cross-branch
t_client.rc easier to maintain.

Change-Id: I1f5724476862935284f620c54afa510eea03e3f9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1453
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1453
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index e25ecae..566da71 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -502,8 +502,6 @@
     src/openvpn/multi.h
     src/openvpn/multi_io.h
     src/openvpn/multi_io.c
-    src/openvpn/ntlm.c
-    src/openvpn/ntlm.h
     src/openvpn/occ.c
     src/openvpn/occ.h
     src/openvpn/openvpn.c
diff --git a/config.h.cmake.in b/config.h.cmake.in
index ddf6174..a93fcd5 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -35,9 +35,6 @@
 /* Enable dns-updown script hook */
 #cmakedefine ENABLE_DNS_UPDOWN
 
-/* Enable NTLMv2 proxy support */
-#define ENABLE_NTLM 1
-
 /* Enable management server capability */
 #define ENABLE_MANAGEMENT 1
 
diff --git a/configure.ac b/configure.ac
index 841b0d1..9fa6a41 100644
--- a/configure.ac
+++ b/configure.ac
@@ -95,13 +95,6 @@
 )
 
 AC_ARG_ENABLE(
-	[ntlm],
-	[AS_HELP_STRING([--disable-ntlm], [disable NTLMv2 proxy support @<:@default=yes@:>@])],
-	,
-	[enable_ntlm="yes"]
-)
-
-AC_ARG_ENABLE(
 	[plugins],
 	[AS_HELP_STRING([--disable-plugins], [disable plug-in support @<:@default=yes@:>@])],
 	,
@@ -1171,7 +1164,6 @@
 test "${enable_fragment}" = "yes" && AC_DEFINE([ENABLE_FRAGMENT], [1], [Enable internal fragmentation support])
 test "${enable_port_share}" = "yes" && AC_DEFINE([ENABLE_PORT_SHARE], [1], [Enable TCP Server port sharing])
 test "${enable_dns_updown_by_default}" = "yes" && AC_DEFINE([ENABLE_DNS_UPDOWN_BY_DEFAULT], [1], [Enable dns-updown hook by default])
-test "${enable_ntlm}" = "yes" && AC_DEFINE([ENABLE_NTLM], [1], [Enable NTLMv2 proxy support])
 test "${enable_crypto_ofb_cfb}" = "yes" && AC_DEFINE([ENABLE_OFB_CFB_MODE], [1], [Enable OFB and CFB cipher modes])
 OPTIONAL_CRYPTO_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CFLAGS}"
 OPTIONAL_CRYPTO_LIBS="${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_LIBS}"
diff --git a/doc/doxygen/openvpn.doxyfile.in b/doc/doxygen/openvpn.doxyfile.in
index bdbc608..5b8e262 100644
--- a/doc/doxygen/openvpn.doxyfile.in
+++ b/doc/doxygen/openvpn.doxyfile.in
@@ -2212,7 +2212,6 @@
 # This tag requires that the tag ENABLE_PREPROCESSING is set to YES.
 
 PREDEFINED             = _WIN32 \
-                         NTLM \
                          USE_LZO \
                          ENABLE_FRAGMENT \
                          P2MP \
diff --git a/doc/man-sections/proxy-options.rst b/doc/man-sections/proxy-options.rst
index 38c4578..7123838 100644
--- a/doc/man-sections/proxy-options.rst
+++ b/doc/man-sections/proxy-options.rst
@@ -7,7 +7,7 @@
   ``--http-proxy-user-pass`` option (See `INLINE FILE SUPPORT`_).
 
   The last optional argument is an ``auth-method`` which should be one
-  of :code:`none`, :code:`basic`, or :code:`ntlm2`.
+  of :code:`none`, :code:`basic`.
 
   HTTP Digest authentication is supported as well, but only via the
   :code:`auto` or :code:`auto-nct` flags (below).  This must replace
@@ -31,8 +31,6 @@
      http-proxy proxy.example.net 3128 authfile.txt
      # basic authentication, ask user for credentials
      http-proxy proxy.example.net 3128 stdin
-     # NTLM authentication, load credentials from file
-     http-proxy proxy.example.net 3128 authfile.txt ntlm2
      # determine which authentication is required, ask user for credentials
      http-proxy proxy.example.net 3128 auto
      # determine which authentication is required, but reject basic
@@ -47,9 +45,8 @@
      password
      </http-proxy-user-pass>
 
-  Note that support for NTLMv1 proxies was removed with OpenVPN 2.7.
-  :code:`ntlm` now is an alias for :code:`ntlm2`; i.e. OpenVPN will always
-  attempt to use NTLMv2 authentication.
+  Note that support for NTLMv1 proxies was removed with OpenVPN 2.7
+  and support for NTLMv2 proxies was removed with OpenVPN 2.8.
 
 --http-proxy-user-pass userpass
   Overwrite the username/password information for ``--http-proxy``. If specified
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 3c567aa..ff8cc54 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -101,7 +101,6 @@
 	networking_iproute2.c networking_iproute2.h \
 	networking_sitnl.c networking_sitnl.h \
 	networking.h \
-	ntlm.c ntlm.h \
 	occ.c occ.h \
 	openssl_compat.h \
 	pkcs11.c pkcs11.h pkcs11_backend.h \
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
deleted file mode 100644
index 8e913dc..0000000
--- a/src/openvpn/ntlm.c
+++ /dev/null
@@ -1,395 +0,0 @@
-/*
- *  ntlm proxy support for OpenVPN
- *
- *  Copyright (C) 2004 William Preston
- *
- *  *NTLMv2 support and domain name parsing by Miroslav Zajic, Nextsoft s.r.o.*
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, see <https://www.gnu.org/licenses/>.
- */
-
-#ifdef HAVE_CONFIG_H
-#include "config.h"
-#endif
-
-#include "syshead.h"
-
-#if NTLM
-
-#include "common.h"
-#include "buffer.h"
-#include "misc.h"
-#include "socket.h"
-#include "fdmisc.h"
-#include "proxy.h"
-#include "ntlm.h"
-#include "base64.h"
-#include "crypto.h"
-
-#include "memdbg.h"
-
-
-/* 64bit datatype macros */
-#ifdef _MSC_VER
-/* MS compilers */
-#define UINTEGER64 __int64
-#define UINT64(c)  c##Ui64
-#else
-/* Non MS compilers */
-#define UINTEGER64 unsigned long long
-#define UINT64(c)  c##LL
-#endif
-
-
-static void
-gen_md4_hash(const uint8_t *data, int data_len, uint8_t *result)
-{
-    /* result is 16 byte md4 hash */
-    uint8_t md[MD4_DIGEST_LENGTH];
-
-    md_full("MD4", data, data_len, md);
-    memcpy(result, md, MD4_DIGEST_LENGTH);
-}
-
-static void
-gen_hmac_md5(const uint8_t *data, int data_len, const uint8_t *key, uint8_t *result)
-{
-    hmac_ctx_t *hmac_ctx = hmac_ctx_new();
-
-    hmac_ctx_init(hmac_ctx, key, "MD5");
-    hmac_ctx_update(hmac_ctx, data, data_len);
-    hmac_ctx_final(hmac_ctx, result);
-    hmac_ctx_cleanup(hmac_ctx);
-    hmac_ctx_free(hmac_ctx);
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-static void
-gen_timestamp(uint8_t *timestamp)
-{
-    /* Copies 8 bytes long timestamp into "timestamp" buffer.
-     * Timestamp is Little-endian, 64-bit signed value representing the
-     * number of tenths of a microsecond since January 1, 1601.
-     */
-
-    UINTEGER64 timestamp_ull;
-
-    timestamp_ull = openvpn_time(NULL);
-    timestamp_ull = (timestamp_ull + UINT64(11644473600)) * UINT64(10000000);
-
-    /* store little endian value */
-    timestamp[0] = timestamp_ull & UINT64(0xFF);
-    timestamp[1] = (timestamp_ull >> 8) & UINT64(0xFF);
-    timestamp[2] = (timestamp_ull >> 16) & UINT64(0xFF);
-    timestamp[3] = (timestamp_ull >> 24) & UINT64(0xFF);
-    timestamp[4] = (timestamp_ull >> 32) & UINT64(0xFF);
-    timestamp[5] = (timestamp_ull >> 40) & UINT64(0xFF);
-    timestamp[6] = (timestamp_ull >> 48) & UINT64(0xFF);
-    timestamp[7] = (timestamp_ull >> 56) & UINT64(0xFF);
-}
-
-static void
-gen_nonce(unsigned char *nonce)
-{
-    /* Generates 8 random bytes to be used as client nonce */
-    int i;
-
-    for (i = 0; i < 8; i++)
-    {
-        nonce[i] = (unsigned char)get_random();
-    }
-}
-
-static void
-my_strupr(char *str)
-{
-    /* converts string to uppercase in place */
-
-    while (*str)
-    {
-        *str = toupper(*str);
-        str++;
-    }
-}
-
-/**
- * This function expects a null-terminated string in src and will
- * copy it (including the terminating NUL byte),
- * alternating it with 0 to dst.
- *
- * This basically will transform a ASCII string into valid UTF-16.
- * Characters that are 8bit in src, will get the same treatment, resulting in
- * invalid or wrong unicode code points.
- *
- * @note the function will blindly assume that dst has double
- * the space of src.
- * @return  the length of the number of bytes written to dst
- */
-static int
-unicodize(char *dst, const char *src)
-{
-    /* not really unicode... */
-    int i = 0;
-    do
-    {
-        dst[i++] = *src;
-        dst[i++] = 0;
-    } while (*src++);
-
-    return i;
-}
-
-static void
-add_security_buffer(int sb_offset, void *data, int length, unsigned char *msg_buf, int *msg_bufpos,
-                    size_t msg_bufsize)
-{
-    if (*msg_bufpos + length > msg_bufsize)
-    {
-        msg(M_WARN, "NTLM: security buffer too big for message buffer");
-        return;
-    }
-    /* Adds security buffer data to a message and sets security buffer's
-     * offset and length */
-    msg_buf[sb_offset] = (unsigned char)length;
-    msg_buf[sb_offset + 2] = msg_buf[sb_offset];
-    msg_buf[sb_offset + 4] = (unsigned char)(*msg_bufpos & 0xff);
-    msg_buf[sb_offset + 5] = (unsigned char)((*msg_bufpos >> 8) & 0xff);
-    memcpy(&msg_buf[*msg_bufpos], data, msg_buf[sb_offset]);
-    *msg_bufpos += length;
-}
-
-const char *
-ntlm_phase_1(const struct http_proxy_info *p, struct gc_arena *gc)
-{
-    struct buffer out = alloc_buf_gc(96, gc);
-    /* try a minimal NTLM handshake
-     *
-     * https://davenport.sourceforge.net/ntlm.html
-     *
-     * This message contains only the NTLMSSP signature,
-     * the NTLM message type,
-     * and the minimal set of flags (Negotiate NTLM and Negotiate OEM).
-     *
-     */
-    buf_printf(&out, "%s", "TlRMTVNTUAABAAAAAgIAAA==");
-    return (BSTR(&out));
-}
-
-const char *
-ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_arena *gc)
-{
-    /* NTLM handshake
-     *
-     * https://davenport.sourceforge.net/ntlm.html
-     *
-     */
-
-    char pwbuf[sizeof(p->up.password) * 2]; /* for unicode password */
-    uint8_t phase3[464];
-
-    uint8_t md4_hash[MD4_DIGEST_LENGTH + 5];
-    uint8_t challenge[8];
-    int i, ret_val;
-
-    uint8_t ntlmv2_response[256];
-    char userdomain_u[256]; /* for uppercase unicode username and domain */
-    char userdomain[128];   /* the same as previous but ascii */
-    uint8_t ntlmv2_hash[MD5_DIGEST_LENGTH];
-    uint8_t ntlmv2_hmacmd5[16];
-    uint8_t *ntlmv2_blob = ntlmv2_response + 16; /* inside ntlmv2_response, length: 128 */
-    int ntlmv2_blob_size = 0;
-    int phase3_bufpos = 0x40;                    /* offset to next security buffer data to be added */
-    size_t len;
-
-    char domain[128];
-    char username[128];
-    char *separator;
-
-    ASSERT(strlen(p->up.username) > 0);
-    ASSERT(strlen(p->up.password) > 0);
-
-    /* username parsing */
-    separator = strchr(p->up.username, '\\');
-    if (separator == NULL)
-    {
-        strncpy(username, p->up.username, sizeof(username) - 1);
-        username[sizeof(username) - 1] = 0;
-        domain[0] = 0;
-    }
-    else
-    {
-        strncpy(username, separator + 1, sizeof(username) - 1);
-        username[sizeof(username) - 1] = 0;
-        len = separator - p->up.username;
-        if (len > sizeof(domain) - 1)
-        {
-            len = sizeof(domain) - 1;
-        }
-        strncpy(domain, p->up.username, len);
-        domain[len] = 0;
-    }
-
-
-    /* fill 1st 16 bytes with md4 hash, disregard terminating null */
-    int unicode_len = unicodize(pwbuf, p->up.password) - 2;
-    gen_md4_hash((uint8_t *)pwbuf, unicode_len, md4_hash);
-
-    /* pad to 21 bytes */
-    memset(md4_hash + MD4_DIGEST_LENGTH, 0, 5);
-
-    /* If the decoded challenge is shorter than required by the protocol,
-     * the missing bytes will be NULL, as buf2 is known to be zeroed
-     * when this decode happens.
-     */
-    uint8_t buf2[512]; /* decoded reply from proxy */
-    CLEAR(buf2);
-    ret_val = openvpn_base64_decode(phase_2, buf2, -1);
-    if (ret_val < 0)
-    {
-        msg(M_WARN, "NTLM: base64 decoding of phase 2 response failed");
-        return NULL;
-    }
-
-    /* extract the challenge from bytes 24-31 */
-    for (i = 0; i < 8; i++)
-    {
-        challenge[i] = buf2[i + 24];
-    }
-
-    /* Generate NTLMv2 response */
-    int tib_len;
-
-    /* NTLMv2 hash */
-    strcpy(userdomain, username);
-    my_strupr(userdomain);
-    if (strlen(username) + strlen(domain) < sizeof(userdomain))
-    {
-        strcat(userdomain, domain);
-    }
-    else
-    {
-        msg(M_INFO, "NTLM: Username or domain too long");
-    }
-    unicodize(userdomain_u, userdomain);
-    gen_hmac_md5((uint8_t *)userdomain_u, 2 * strlen(userdomain), md4_hash, ntlmv2_hash);
-
-    /* NTLMv2 Blob */
-    memset(ntlmv2_blob, 0, 128);       /* Clear blob buffer */
-    ntlmv2_blob[0x00] = 1;             /* Signature */
-    ntlmv2_blob[0x01] = 1;             /* Signature */
-    ntlmv2_blob[0x04] = 0;             /* Reserved */
-    gen_timestamp(&ntlmv2_blob[0x08]); /* 64-bit Timestamp */
-    gen_nonce(&ntlmv2_blob[0x10]);     /* 64-bit Client Nonce */
-    ntlmv2_blob[0x18] = 0;             /* Unknown, zero should work */
-
-    /* Add target information block to the blob */
-
-    /* Check for Target Information block */
-    /* The NTLM spec instructs to interpret these 4 consecutive bytes as a
-     * 32bit long integer. However, no endianness is specified.
-     * The code here and that found in other NTLM implementations point
-     * towards the assumption that the byte order on the wire has to
-     * match the order on the sending and receiving hosts. Probably NTLM has
-     * been thought to be always running on x86_64/i386 machine thus
-     * implying Little-Endian everywhere.
-     *
-     * This said, in case of future changes, we should keep in mind that the
-     * byte order on the wire for the NTLM header is LE.
-     */
-    const size_t hoff = 0x14;
-    unsigned long flags =
-        buf2[hoff] | (buf2[hoff + 1] << 8) | (buf2[hoff + 2] << 16) | (buf2[hoff + 3] << 24);
-    if ((flags & 0x00800000) == 0x00800000)
-    {
-        tib_len = buf2[0x28]; /* Get Target Information block size */
-        if (tib_len + 0x1c + 16 > sizeof(ntlmv2_response))
-        {
-            msg(M_WARN, "NTLM: target information buffer too long for response (len=%d)", tib_len);
-            return NULL;
-        }
-
-        {
-            uint8_t *tib_ptr;
-            uint8_t tib_pos = buf2[0x2c];
-            if (tib_pos + tib_len > sizeof(buf2))
-            {
-                msg(M_ERR,
-                    "NTLM: phase 2 response from server too long (need %d bytes at offset %u)",
-                    tib_len, tib_pos);
-                return NULL;
-            }
-            /* Get Target Information block pointer */
-            tib_ptr = buf2 + tib_pos;
-            /* Copy Target Information block into the blob */
-            memcpy(&ntlmv2_blob[0x1c], tib_ptr, tib_len);
-        }
-    }
-    else
-    {
-        tib_len = 0;
-    }
-
-    /* Unknown, zero works */
-    ntlmv2_blob[0x1c + tib_len] = 0;
-
-    /* Get blob length */
-    ntlmv2_blob_size = 0x20 + tib_len;
-
-    /* Add challenge from message 2 */
-    memcpy(&ntlmv2_response[8], challenge, 8);
-
-    /* hmac-md5 */
-    gen_hmac_md5(&ntlmv2_response[8], ntlmv2_blob_size + 8, ntlmv2_hash, ntlmv2_hmacmd5);
-
-    /* Add hmac-md5 result to the blob.
-     * Note: This overwrites challenge previously written at
-     * ntlmv2_response[8..15] */
-    memcpy(ntlmv2_response, ntlmv2_hmacmd5, MD5_DIGEST_LENGTH);
-
-    memset(phase3, 0, sizeof(phase3));   /* clear reply */
-
-    strcpy((char *)phase3, "NTLMSSP\0"); /* signature */
-    phase3[8] = 3;                       /* type 3 */
-
-    /* NTLMv2 response */
-    add_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 16, phase3, &phase3_bufpos,
-                        sizeof(phase3));
-
-    /* username in ascii */
-    add_security_buffer(0x24, username, strlen(username), phase3, &phase3_bufpos, sizeof(phase3));
-
-    /* Set domain. If <domain> is empty, default domain will be used
-     * (i.e. proxy's domain) */
-    add_security_buffer(0x1c, domain, strlen(domain), phase3, &phase3_bufpos, sizeof(phase3));
-
-    /* other security buffers will be empty */
-    phase3[0x10] = phase3_bufpos; /* lm not used */
-    phase3[0x30] = phase3_bufpos; /* no workstation name supplied */
-    phase3[0x38] = phase3_bufpos; /* no session key */
-
-    /* flags */
-    phase3[0x3c] = 0x02; /* negotiate oem */
-    phase3[0x3d] = 0x02; /* negotiate ntlm */
-
-    return ((const char *)make_base64_string2((unsigned char *)phase3, phase3_bufpos, gc));
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-#endif /* if NTLM */
diff --git a/src/openvpn/ntlm.h b/src/openvpn/ntlm.h
deleted file mode 100644
index b0a6821..0000000
--- a/src/openvpn/ntlm.h
+++ /dev/null
@@ -1,12 +0,0 @@
-#ifndef NTLM_H
-#define NTLM_H
-
-#if NTLM
-
-const char *ntlm_phase_1(const struct http_proxy_info *p, struct gc_arena *gc);
-
-const char *ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_arena *gc);
-
-#endif
-
-#endif
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2bca647..09a5d48 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -158,8 +158,7 @@
     "                  through an HTTP proxy at address s and port p.\n"
     "                  If proxy authentication is required,\n"
     "                  up is a file containing username/password on 2 lines, or\n"
-    "                  'stdin' to prompt from console.  Add auth='ntlm2' if\n"
-    "                  the proxy requires NTLM authentication.\n"
+    "                  'stdin' to prompt from console.\n"
     "--http-proxy s p 'auto[-nct]' : Like the above directive, but automatically\n"
     "                  determine auth method and query for username/password\n"
     "                  if needed.  auto-nct disables weak proxy auth methods.\n"
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index efd4aad..b355827 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -35,7 +35,6 @@
 #include "proxy.h"
 #include "base64.h"
 #include "httpdigest.h"
-#include "ntlm.h"
 #include "memdbg.h"
 #include "forward.h"
 
@@ -348,14 +347,6 @@
                 ret = HTTP_AUTH_DIGEST;
             }
 #endif
-#if NTLM
-            else if (!strncmp(buf + 20, "NTLM", 4))
-            {
-                msg(D_PROXY, "PROXY AUTH NTLM: '%s'", buf);
-                *data = NULL;
-                ret = HTTP_AUTH_NTLM2;
-            }
-#endif
         }
     }
 }
@@ -511,40 +502,20 @@
         {
             p->auth_method = HTTP_AUTH_BASIC;
         }
-#if NTLM
-        else if (!strcmp(o->auth_method_string, "ntlm"))
-        {
-            msg(M_WARN,
-                "NTLM v1 authentication has been removed in OpenVPN 2.7. Will try to use NTLM v2 authentication.");
-            p->auth_method = HTTP_AUTH_NTLM2;
-        }
-        else if (!strcmp(o->auth_method_string, "ntlm2"))
-        {
-            p->auth_method = HTTP_AUTH_NTLM2;
-        }
-#endif
         else
         {
             msg(M_FATAL, "ERROR: unknown HTTP authentication method: '%s'", o->auth_method_string);
         }
     }
 
-    /* When basic or NTLMv2 authentication is requested, get credentials now.
+    /* When basic authentication is requested, get credentials now.
      * In case of "auto" negotiation credentials will be retrieved later once
      * we know whether we need any. */
-    if (p->auth_method == HTTP_AUTH_BASIC || p->auth_method == HTTP_AUTH_NTLM2)
+    if (p->auth_method == HTTP_AUTH_BASIC)
     {
         get_user_pass_http(p, p->options.first_time);
     }
 
-#if !NTLM
-    if (p->auth_method == HTTP_AUTH_NTLM2)
-    {
-        msg(M_FATAL,
-            "Sorry, this version of " PACKAGE_NAME " was built without NTLM Proxy support.");
-    }
-#endif
-
     p->defined = true;
     return p;
 }
@@ -638,8 +609,7 @@
     volatile int *signal_received = &sig_info->signal_received;
 
     /* get user/pass if not previously given */
-    if (p->auth_method == HTTP_AUTH_BASIC || p->auth_method == HTTP_AUTH_DIGEST
-        || p->auth_method == HTTP_AUTH_NTLM2)
+    if (p->auth_method == HTTP_AUTH_BASIC || p->auth_method == HTTP_AUTH_DIGEST)
     {
         get_user_pass_http(p, false);
 
@@ -692,25 +662,6 @@
                 }
                 break;
 
-#if NTLM
-            case HTTP_AUTH_NTLM2:
-                /* keep-alive connection */
-                snprintf(buf, sizeof(buf), "Proxy-Connection: Keep-Alive");
-                if (!send_line_crlf(sd, buf))
-                {
-                    goto error;
-                }
-
-                snprintf(buf, sizeof(buf), "Proxy-Authorization: NTLM %s", ntlm_phase_1(p, &gc));
-                msg(D_PROXY, "Attempting NTLM Proxy-Authorization phase 1");
-                dmsg(D_SHOW_KEYS, "Send to HTTP proxy: '%s'", buf);
-                if (!send_line_crlf(sd, buf))
-                {
-                    goto error;
-                }
-                break;
-#endif
-
             default:
                 ASSERT(0);
         }
@@ -749,112 +700,6 @@
         {
             processed = true;
         }
-        else if (p->auth_method == HTTP_AUTH_NTLM2 && !processed) /* check for NTLM */
-        {
-#if NTLM
-            /* look for the phase 2 response */
-            char buf2[512];
-            while (true)
-            {
-                if (!recv_line(sd, buf, sizeof(buf),
-                               get_server_poll_remaining_time(server_poll_timeout), true, NULL,
-                               signal_received))
-                {
-                    goto error;
-                }
-                chomp(buf);
-                msg(D_PROXY, "HTTP proxy returned: '%s'", buf);
-
-                char get[80];
-                CLEAR(buf2);
-                snprintf(get, sizeof(get), "%%*s NTLM %%%zus", sizeof(buf2) - 1);
-                nparms = sscanf(buf, get, buf2);
-
-                /* check for "Proxy-Authenticate: NTLM TlRM..." */
-                if (nparms == 1)
-                {
-                    /* parse buf2 */
-                    msg(D_PROXY, "auth string: '%s'", buf2);
-                    break;
-                }
-            }
-            /* if we are here then auth string was got */
-            msg(D_PROXY, "Received NTLM Proxy-Authorization phase 2 response");
-
-            /* receive and discard everything else */
-            while (recv_line(sd, NULL, 0, 2, true, NULL, signal_received))
-            {
-            }
-
-            /* now send the phase 3 reply */
-
-            /* format HTTP CONNECT message */
-            snprintf(buf, sizeof(buf), "CONNECT %s:%s HTTP/%s", host, port,
-                     p->options.http_version);
-
-            msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
-
-            /* send HTTP CONNECT message to proxy */
-            if (!send_line_crlf(sd, buf))
-            {
-                goto error;
-            }
-
-            /* keep-alive connection */
-            snprintf(buf, sizeof(buf), "Proxy-Connection: Keep-Alive");
-            if (!send_line_crlf(sd, buf))
-            {
-                goto error;
-            }
-
-            /* send HOST etc, */
-            if (!add_proxy_headers(p, sd, host))
-            {
-                goto error;
-            }
-
-            msg(D_PROXY, "Attempting NTLM Proxy-Authorization phase 3");
-            {
-                const char *np3 = ntlm_phase_3(p, buf2, &gc);
-                if (!np3)
-                {
-                    msg(D_PROXY,
-                        "NTLM Proxy-Authorization phase 3 failed: received corrupted data from proxy server");
-                    goto error;
-                }
-                snprintf(buf, sizeof(buf), "Proxy-Authorization: NTLM %s", np3);
-            }
-
-            msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
-            if (!send_line_crlf(sd, buf))
-            {
-                goto error;
-            }
-            /* ok so far... */
-            /* send empty CR, LF */
-            if (!send_crlf(sd))
-            {
-                goto error;
-            }
-
-            /* receive reply from proxy */
-            if (!recv_line(sd, buf, sizeof(buf),
-                           get_server_poll_remaining_time(server_poll_timeout), true, NULL,
-                           signal_received))
-            {
-                goto error;
-            }
-
-            /* remove trailing CR, LF */
-            chomp(buf);
-
-            msg(D_PROXY, "HTTP proxy returned: '%s'", buf);
-
-            /* parse return string */
-            nparms = sscanf(buf, "%*s %d", &status);
-            processed = true;
-#endif /* if NTLM */
-        }
 #if PROXY_DIGEST_AUTH
         else if (p->auth_method == HTTP_AUTH_DIGEST && !processed)
         {
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 89c2da77..e662e7d 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -31,7 +31,7 @@
 #define HTTP_AUTH_BASIC  1
 #define HTTP_AUTH_DIGEST 2
 /* #define HTTP_AUTH_NTLM   3 removed in OpenVPN 2.7 */
-#define HTTP_AUTH_NTLM2  4
+/* #define HTTP_AUTH_NTLM2  4 removed in OpenVPN 2.8 */
 #define HTTP_AUTH_N      5 /* number of HTTP_AUTH methods */
 
 struct http_custom_header
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 582e130..067ee9d 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -491,13 +491,6 @@
 #endif
 
 /*
- * Should we include NTLM proxy functionality
- */
-#ifdef ENABLE_NTLM
-#define NTLM 1
-#endif
-
-/*
  * Should we include proxy digest auth functionality
  */
 #define PROXY_DIGEST_AUTH 1
diff --git a/tests/Makefile.am b/tests/Makefile.am
index cb30fe5..3907965 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -49,13 +49,4 @@
 ntlm_support_CFLAGS  = -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat -I$(top_srcdir)/tests/unit_tests/openvpn -DNO_CMOCKA @TEST_CFLAGS@
 ntlm_support_LDFLAGS = @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn $(OPTIONAL_CRYPTO_LIBS)
 ntlm_support_SOURCES = ntlm_support.c \
-	unit_tests/openvpn/mock_msg.c unit_tests/openvpn/mock_msg.h \
-	$(top_srcdir)/src/openvpn/buffer.c \
-	$(top_srcdir)/src/openvpn/crypto.c \
-	$(top_srcdir)/src/openvpn/crypto_epoch.c \
-	$(top_srcdir)/src/openvpn/crypto_openssl.c \
-	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
-	$(top_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \
-	$(top_srcdir)/src/openvpn/otime.c \
-	$(top_srcdir)/src/openvpn/packet_id.c \
-	$(top_srcdir)/src/openvpn/platform.c
+	unit_tests/openvpn/mock_msg.c unit_tests/openvpn/mock_msg.h
diff --git a/tests/ntlm_support.c b/tests/ntlm_support.c
index 4fd044e..a4ee00e 100644
--- a/tests/ntlm_support.c
+++ b/tests/ntlm_support.c
@@ -26,30 +26,10 @@
 
 #include "syshead.h"
 
-#include "crypto.h"
 #include "error.h"
 
 int
 main(void)
 {
-#ifdef NTLM
-#if defined(ENABLE_CRYPTO_OPENSSL)
-    provider_t *legacy = crypto_load_provider("legacy");
-    provider_t *def = crypto_load_provider("default");
-#endif
-    if (!md_valid("MD4"))
-    {
-        msg(M_FATAL, "MD4 not supported");
-    }
-    if (!md_valid("MD5"))
-    {
-        msg(M_FATAL, "MD5 not supported");
-    }
-#if defined(ENABLE_CRYPTO_OPENSSL)
-    crypto_unload_provider("legacy", legacy);
-    crypto_unload_provider("default", def);
-#endif
-#else /* ifdef NTLM */
     msg(M_FATAL, "NTLM support not compiled in");
-#endif
 }

