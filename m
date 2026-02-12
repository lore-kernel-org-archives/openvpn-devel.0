From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 12 Feb 2026 12:41:01 +0000
In-Reply-To: <gerrit.1766158651000.I1f5724476862935284f620c54afa510eea03e3f9@...2715...>
References: <gerrit.1766158651000.I1f5724476862935284f620c54afa510eea03e3f9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <0abdcd13582a16eb8a9e1784a2e5f043128c3bb1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xpsArVki2ho="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove NTLM support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xpsArVki2ho=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1453?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by cron2

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: Remove NTLM support
......................................................................

Remove NTLM support

Since Microsoft has abandonded this I think it is time
for us to do the same for OpenVPN 2.8.

Leaves a stub ntlm_support in to make cross-branch
t_client.rc easier to maintain.

Change-Id: I1f5724476862935284f620c54afa510eea03e3f9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M CMakeLists.txt
M config.h.cmake.in
M configure.ac
M doc/doxygen/openvpn.doxyfile.in
M doc/man-sections/proxy-options.rst
M src/openvpn/Makefile.am
D src/openvpn/ntlm.c
D src/openvpn/ntlm.h
M src/openvpn/options.c
M src/openvpn/proxy.c
M src/openvpn/proxy.h
M src/openvpn/syshead.h
M tests/Makefile.am
M tests/ntlm_support.c
14 files changed, 9 insertions(+), 626 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/53/1453/2

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
-	[AS_HELP_STRING([--disable-ntlm], [disable NTLMv2 proxy support @<:@defau=
lt=3Dyes@:>@])],
-	,
-	[enable_ntlm=3D"yes"]
-)
-
-AC_ARG_ENABLE(
 	[plugins],
 	[AS_HELP_STRING([--disable-plugins], [disable plug-in support @<:@default=
=3Dyes@:>@])],
 	,
@@ -1171,7 +1164,6 @@
 test "${enable_fragment}" =3D "yes" && AC_DEFINE([ENABLE_FRAGMENT], [1], [=
Enable internal fragmentation support])
 test "${enable_port_share}" =3D "yes" && AC_DEFINE([ENABLE_PORT_SHARE], [1=
], [Enable TCP Server port sharing])
 test "${enable_dns_updown_by_default}" =3D "yes" && AC_DEFINE([ENABLE_DNS_=
UPDOWN_BY_DEFAULT], [1], [Enable dns-updown hook by default])
-test "${enable_ntlm}" =3D "yes" && AC_DEFINE([ENABLE_NTLM], [1], [Enable N=
TLMv2 proxy support])
 test "${enable_crypto_ofb_cfb}" =3D "yes" && AC_DEFINE([ENABLE_OFB_CFB_MOD=
E], [1], [Enable OFB and CFB cipher modes])
 OPTIONAL_CRYPTO_CFLAGS=3D"${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CFLAGS}"
 OPTIONAL_CRYPTO_LIBS=3D"${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_LIBS}"
diff --git a/doc/doxygen/openvpn.doxyfile.in b/doc/doxygen/openvpn.doxyfile=
.in
index bdbc608..5b8e262 100644
--- a/doc/doxygen/openvpn.doxyfile.in
+++ b/doc/doxygen/openvpn.doxyfile.in
@@ -2212,7 +2212,6 @@
 # This tag requires that the tag ENABLE_PREPROCESSING is set to YES.

 PREDEFINED             =3D _WIN32 \
-                         NTLM \
                          USE_LZO \
                          ENABLE_FRAGMENT \
                          P2MP \
diff --git a/doc/man-sections/proxy-options.rst b/doc/man-sections/proxy-op=
tions.rst
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
   Overwrite the username/password information for ``--http-proxy``. If spe=
cified
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
- *  *NTLMv2 support and domain name parsing by Miroslav Zajic, Nextsoft s.=
r.o.*
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
-gen_hmac_md5(const uint8_t *data, int data_len, const uint8_t *key, uint8_=
t *result)
-{
-    hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();
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
-    timestamp_ull =3D openvpn_time(NULL);
-    timestamp_ull =3D (timestamp_ull + UINT64(11644473600)) * UINT64(10000=
000);
-
-    /* store little endian value */
-    timestamp[0] =3D timestamp_ull & UINT64(0xFF);
-    timestamp[1] =3D (timestamp_ull >> 8) & UINT64(0xFF);
-    timestamp[2] =3D (timestamp_ull >> 16) & UINT64(0xFF);
-    timestamp[3] =3D (timestamp_ull >> 24) & UINT64(0xFF);
-    timestamp[4] =3D (timestamp_ull >> 32) & UINT64(0xFF);
-    timestamp[5] =3D (timestamp_ull >> 40) & UINT64(0xFF);
-    timestamp[6] =3D (timestamp_ull >> 48) & UINT64(0xFF);
-    timestamp[7] =3D (timestamp_ull >> 56) & UINT64(0xFF);
-}
-
-static void
-gen_nonce(unsigned char *nonce)
-{
-    /* Generates 8 random bytes to be used as client nonce */
-    int i;
-
-    for (i =3D 0; i < 8; i++)
-    {
-        nonce[i] =3D (unsigned char)get_random();
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
-        *str =3D toupper(*str);
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
- * Characters that are 8bit in src, will get the same treatment, resulting=
 in
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
-    int i =3D 0;
-    do
-    {
-        dst[i++] =3D *src;
-        dst[i++] =3D 0;
-    } while (*src++);
-
-    return i;
-}
-
-static void
-add_security_buffer(int sb_offset, void *data, int length, unsigned char *=
msg_buf, int *msg_bufpos,
-                    size_t msg_bufsize)
-{
-    if (*msg_bufpos + length > msg_bufsize)
-    {
-        msg(M_WARN, "NTLM: security buffer too big for message buffer");
-        return;
-    }
-    /* Adds security buffer data to a message and sets security buffer's
-     * offset and length */
-    msg_buf[sb_offset] =3D (unsigned char)length;
-    msg_buf[sb_offset + 2] =3D msg_buf[sb_offset];
-    msg_buf[sb_offset + 4] =3D (unsigned char)(*msg_bufpos & 0xff);
-    msg_buf[sb_offset + 5] =3D (unsigned char)((*msg_bufpos >> 8) & 0xff);
-    memcpy(&msg_buf[*msg_bufpos], data, msg_buf[sb_offset]);
-    *msg_bufpos +=3D length;
-}
-
-const char *
-ntlm_phase_1(const struct http_proxy_info *p, struct gc_arena *gc)
-{
-    struct buffer out =3D alloc_buf_gc(96, gc);
-    /* try a minimal NTLM handshake
-     *
-     * https://davenport.sourceforge.net/ntlm.html
-     *
-     * This message contains only the NTLMSSP signature,
-     * the NTLM message type,
-     * and the minimal set of flags (Negotiate NTLM and Negotiate OEM).
-     *
-     */
-    buf_printf(&out, "%s", "TlRMTVNTUAABAAAAAgIAAA=3D=3D");
-    return (BSTR(&out));
-}
-
-const char *
-ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct =
gc_arena *gc)
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
-    uint8_t *ntlmv2_blob =3D ntlmv2_response + 16; /* inside ntlmv2_respon=
se, length: 128 */
-    int ntlmv2_blob_size =3D 0;
-    int phase3_bufpos =3D 0x40;                    /* offset to next secur=
ity buffer data to be added */
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
-    separator =3D strchr(p->up.username, '\\');
-    if (separator =3D=3D NULL)
-    {
-        strncpy(username, p->up.username, sizeof(username) - 1);
-        username[sizeof(username) - 1] =3D 0;
-        domain[0] =3D 0;
-    }
-    else
-    {
-        strncpy(username, separator + 1, sizeof(username) - 1);
-        username[sizeof(username) - 1] =3D 0;
-        len =3D separator - p->up.username;
-        if (len > sizeof(domain) - 1)
-        {
-            len =3D sizeof(domain) - 1;
-        }
-        strncpy(domain, p->up.username, len);
-        domain[len] =3D 0;
-    }
-
-
-    /* fill 1st 16 bytes with md4 hash, disregard terminating null */
-    int unicode_len =3D unicodize(pwbuf, p->up.password) - 2;
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
-    ret_val =3D openvpn_base64_decode(phase_2, buf2, -1);
-    if (ret_val < 0)
-    {
-        msg(M_WARN, "NTLM: base64 decoding of phase 2 response failed");
-        return NULL;
-    }
-
-    /* extract the challenge from bytes 24-31 */
-    for (i =3D 0; i < 8; i++)
-    {
-        challenge[i] =3D buf2[i + 24];
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
-    gen_hmac_md5((uint8_t *)userdomain_u, 2 * strlen(userdomain), md4_hash=
, ntlmv2_hash);
-
-    /* NTLMv2 Blob */
-    memset(ntlmv2_blob, 0, 128);       /* Clear blob buffer */
-    ntlmv2_blob[0x00] =3D 1;             /* Signature */
-    ntlmv2_blob[0x01] =3D 1;             /* Signature */
-    ntlmv2_blob[0x04] =3D 0;             /* Reserved */
-    gen_timestamp(&ntlmv2_blob[0x08]); /* 64-bit Timestamp */
-    gen_nonce(&ntlmv2_blob[0x10]);     /* 64-bit Client Nonce */
-    ntlmv2_blob[0x18] =3D 0;             /* Unknown, zero should work */
-
-    /* Add target information block to the blob */
-
-    /* Check for Target Information block */
-    /* The NTLM spec instructs to interpret these 4 consecutive bytes as a
-     * 32bit long integer. However, no endianness is specified.
-     * The code here and that found in other NTLM implementations point
-     * towards the assumption that the byte order on the wire has to
-     * match the order on the sending and receiving hosts. Probably NTLM h=
as
-     * been thought to be always running on x86_64/i386 machine thus
-     * implying Little-Endian everywhere.
-     *
-     * This said, in case of future changes, we should keep in mind that t=
he
-     * byte order on the wire for the NTLM header is LE.
-     */
-    const size_t hoff =3D 0x14;
-    unsigned long flags =3D
-        buf2[hoff] | (buf2[hoff + 1] << 8) | (buf2[hoff + 2] << 16) | (buf=
2[hoff + 3] << 24);
-    if ((flags & 0x00800000) =3D=3D 0x00800000)
-    {
-        tib_len =3D buf2[0x28]; /* Get Target Information block size */
-        if (tib_len + 0x1c + 16 > sizeof(ntlmv2_response))
-        {
-            msg(M_WARN, "NTLM: target information buffer too long for resp=
onse (len=3D%d)", tib_len);
-            return NULL;
-        }
-
-        {
-            uint8_t *tib_ptr;
-            uint8_t tib_pos =3D buf2[0x2c];
-            if (tib_pos + tib_len > sizeof(buf2))
-            {
-                msg(M_ERR,
-                    "NTLM: phase 2 response from server too long (need %d =
bytes at offset %u)",
-                    tib_len, tib_pos);
-                return NULL;
-            }
-            /* Get Target Information block pointer */
-            tib_ptr =3D buf2 + tib_pos;
-            /* Copy Target Information block into the blob */
-            memcpy(&ntlmv2_blob[0x1c], tib_ptr, tib_len);
-        }
-    }
-    else
-    {
-        tib_len =3D 0;
-    }
-
-    /* Unknown, zero works */
-    ntlmv2_blob[0x1c + tib_len] =3D 0;
-
-    /* Get blob length */
-    ntlmv2_blob_size =3D 0x20 + tib_len;
-
-    /* Add challenge from message 2 */
-    memcpy(&ntlmv2_response[8], challenge, 8);
-
-    /* hmac-md5 */
-    gen_hmac_md5(&ntlmv2_response[8], ntlmv2_blob_size + 8, ntlmv2_hash, n=
tlmv2_hmacmd5);
-
-    /* Add hmac-md5 result to the blob.
-     * Note: This overwrites challenge previously written at
-     * ntlmv2_response[8..15] */
-    memcpy(ntlmv2_response, ntlmv2_hmacmd5, MD5_DIGEST_LENGTH);
-
-    memset(phase3, 0, sizeof(phase3));   /* clear reply */
-
-    strcpy((char *)phase3, "NTLMSSP\0"); /* signature */
-    phase3[8] =3D 3;                       /* type 3 */
-
-    /* NTLMv2 response */
-    add_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 16, phas=
e3, &phase3_bufpos,
-                        sizeof(phase3));
-
-    /* username in ascii */
-    add_security_buffer(0x24, username, strlen(username), phase3, &phase3_=
bufpos, sizeof(phase3));
-
-    /* Set domain. If <domain> is empty, default domain will be used
-     * (i.e. proxy's domain) */
-    add_security_buffer(0x1c, domain, strlen(domain), phase3, &phase3_bufp=
os, sizeof(phase3));
-
-    /* other security buffers will be empty */
-    phase3[0x10] =3D phase3_bufpos; /* lm not used */
-    phase3[0x30] =3D phase3_bufpos; /* no workstation name supplied */
-    phase3[0x38] =3D phase3_bufpos; /* no session key */
-
-    /* flags */
-    phase3[0x3c] =3D 0x02; /* negotiate oem */
-    phase3[0x3d] =3D 0x02; /* negotiate ntlm */
-
-    return ((const char *)make_base64_string2((unsigned char *)phase3, pha=
se3_bufpos, gc));
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
-const char *ntlm_phase_1(const struct http_proxy_info *p, struct gc_arena =
*gc);
-
-const char *ntlm_phase_3(const struct http_proxy_info *p, const char *phas=
e_2, struct gc_arena *gc);
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
     "                  up is a file containing username/password on 2 line=
s, or\n"
-    "                  'stdin' to prompt from console.  Add auth=3D'ntlm2'=
 if\n"
-    "                  the proxy requires NTLM authentication.\n"
+    "                  'stdin' to prompt from console.\n"
     "--http-proxy s p 'auto[-nct]' : Like the above directive, but automat=
ically\n"
     "                  determine auth method and query for username/passwo=
rd\n"
     "                  if needed.  auto-nct disables weak proxy auth metho=
ds.\n"
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
                 ret =3D HTTP_AUTH_DIGEST;
             }
 #endif
-#if NTLM
-            else if (!strncmp(buf + 20, "NTLM", 4))
-            {
-                msg(D_PROXY, "PROXY AUTH NTLM: '%s'", buf);
-                *data =3D NULL;
-                ret =3D HTTP_AUTH_NTLM2;
-            }
-#endif
         }
     }
 }
@@ -511,40 +502,20 @@
         {
             p->auth_method =3D HTTP_AUTH_BASIC;
         }
-#if NTLM
-        else if (!strcmp(o->auth_method_string, "ntlm"))
-        {
-            msg(M_WARN,
-                "NTLM v1 authentication has been removed in OpenVPN 2.7. W=
ill try to use NTLM v2 authentication.");
-            p->auth_method =3D HTTP_AUTH_NTLM2;
-        }
-        else if (!strcmp(o->auth_method_string, "ntlm2"))
-        {
-            p->auth_method =3D HTTP_AUTH_NTLM2;
-        }
-#endif
         else
         {
             msg(M_FATAL, "ERROR: unknown HTTP authentication method: '%s'"=
, o->auth_method_string);
         }
     }

-    /* When basic or NTLMv2 authentication is requested, get credentials n=
ow.
+    /* When basic authentication is requested, get credentials now.
      * In case of "auto" negotiation credentials will be retrieved later o=
nce
      * we know whether we need any. */
-    if (p->auth_method =3D=3D HTTP_AUTH_BASIC || p->auth_method =3D=3D HTT=
P_AUTH_NTLM2)
+    if (p->auth_method =3D=3D HTTP_AUTH_BASIC)
     {
         get_user_pass_http(p, p->options.first_time);
     }

-#if !NTLM
-    if (p->auth_method =3D=3D HTTP_AUTH_NTLM2)
-    {
-        msg(M_FATAL,
-            "Sorry, this version of " PACKAGE_NAME " was built without NTL=
M Proxy support.");
-    }
-#endif
-
     p->defined =3D true;
     return p;
 }
@@ -638,8 +609,7 @@
     volatile int *signal_received =3D &sig_info->signal_received;

     /* get user/pass if not previously given */
-    if (p->auth_method =3D=3D HTTP_AUTH_BASIC || p->auth_method =3D=3D HTT=
P_AUTH_DIGEST
-        || p->auth_method =3D=3D HTTP_AUTH_NTLM2)
+    if (p->auth_method =3D=3D HTTP_AUTH_BASIC || p->auth_method =3D=3D HTT=
P_AUTH_DIGEST)
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
-                snprintf(buf, sizeof(buf), "Proxy-Authorization: NTLM %s",=
 ntlm_phase_1(p, &gc));
-                msg(D_PROXY, "Attempting NTLM Proxy-Authorization phase 1"=
);
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
             processed =3D true;
         }
-        else if (p->auth_method =3D=3D HTTP_AUTH_NTLM2 && !processed) /* c=
heck for NTLM */
-        {
-#if NTLM
-            /* look for the phase 2 response */
-            char buf2[512];
-            while (true)
-            {
-                if (!recv_line(sd, buf, sizeof(buf),
-                               get_server_poll_remaining_time(server_poll_=
timeout), true, NULL,
-                               signal_received))
-                {
-                    goto error;
-                }
-                chomp(buf);
-                msg(D_PROXY, "HTTP proxy returned: '%s'", buf);
-
-                char get[80];
-                CLEAR(buf2);
-                snprintf(get, sizeof(get), "%%*s NTLM %%%zus", sizeof(buf2=
) - 1);
-                nparms =3D sscanf(buf, get, buf2);
-
-                /* check for "Proxy-Authenticate: NTLM TlRM..." */
-                if (nparms =3D=3D 1)
-                {
-                    /* parse buf2 */
-                    msg(D_PROXY, "auth string: '%s'", buf2);
-                    break;
-                }
-            }
-            /* if we are here then auth string was got */
-            msg(D_PROXY, "Received NTLM Proxy-Authorization phase 2 respon=
se");
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
-                const char *np3 =3D ntlm_phase_3(p, buf2, &gc);
-                if (!np3)
-                {
-                    msg(D_PROXY,
-                        "NTLM Proxy-Authorization phase 3 failed: received=
 corrupted data from proxy server");
-                    goto error;
-                }
-                snprintf(buf, sizeof(buf), "Proxy-Authorization: NTLM %s",=
 np3);
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
-                           get_server_poll_remaining_time(server_poll_time=
out), true, NULL,
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
-            nparms =3D sscanf(buf, "%*s %d", &status);
-            processed =3D true;
-#endif /* if NTLM */
-        }
 #if PROXY_DIGEST_AUTH
         else if (p->auth_method =3D=3D HTTP_AUTH_DIGEST && !processed)
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
 ntlm_support_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/c=
ompat -I$(top_srcdir)/tests/unit_tests/openvpn -DNO_CMOCKA @TEST_CFLAGS@
 ntlm_support_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn $(OPTI=
ONAL_CRYPTO_LIBS)
 ntlm_support_SOURCES =3D ntlm_support.c \
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
-    provider_t *legacy =3D crypto_load_provider("legacy");
-    provider_t *def =3D crypto_load_provider("default");
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1453?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1f5724476862935284f620c54afa510eea03e3f9
Gerrit-Change-Number: 1453
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--xpsArVki2ho=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1453?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><p>The change is no longer submittable: Code-Revi=
ew and checks~ChecksSubmitRule are unsatisfied now.</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Remove=
 NTLM support<br><br>Since Microsoft has abandonded this I think it is time=
<br>for us to do the same for OpenVPN 2.8.<br><br>Leaves a stub ntlm_suppor=
t in to make cross-branch<br>t_client.rc easier to maintain.<br><br>Change-=
Id: I1f5724476862935284f620c54afa510eea03e3f9<br>Signed-off-by: Frank Licht=
enheld &lt;frank@...2641...&gt;<br>---<br>M CMakeLists.txt<br>M config.h.cm=
ake.in<br>M configure.ac<br>M doc/doxygen/openvpn.doxyfile.in<br>M doc/man-=
sections/proxy-options.rst<br>M src/openvpn/Makefile.am<br>D src/openvpn/nt=
lm.c<br>D src/openvpn/ntlm.h<br>M src/openvpn/options.c<br>M src/openvpn/pr=
oxy.c<br>M src/openvpn/proxy.h<br>M src/openvpn/syshead.h<br>M tests/Makefi=
le.am<br>M tests/ntlm_support.c<br>14 files changed, 9 insertions(+), 626 d=
eletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29=
418/openvpn refs/changes/53/1453/2</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CM=
akeLists.txt</span><br><span>index e25ecae..566da71 100644</span><br><span>=
--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@=
@ -502,8 +502,6 @@</span><br><span>     src/openvpn/multi.h</span><br><span=
>     src/openvpn/multi_io.h</span><br><span>     src/openvpn/multi_io.c</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    src/openvpn/ntlm.c</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    src/openvpn/ntlm.h<=
/span><br><span>     src/openvpn/occ.c</span><br><span>     src/openvpn/occ=
.h</span><br><span>     src/openvpn/openvpn.c</span><br><span>diff --git a/=
config.h.cmake.in b/config.h.cmake.in</span><br><span>index ddf6174..a93fcd=
5 100644</span><br><span>--- a/config.h.cmake.in</span><br><span>+++ b/conf=
ig.h.cmake.in</span><br><span>@@ -35,9 +35,6 @@</span><br><span> /* Enable =
dns-updown script hook */</span><br><span> #cmakedefine ENABLE_DNS_UPDOWN</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* En=
able NTLMv2 proxy support */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define ENABLE_NTLM 1</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span> /* Enable management server capability */</span><b=
r><span> #define ENABLE_MANAGEMENT 1</span><br><span> </span><br><span>diff=
 --git a/configure.ac b/configure.ac</span><br><span>index 841b0d1..9fa6a41=
 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/configure.=
ac</span><br><span>@@ -95,13 +95,6 @@</span><br><span> )</span><br><span> <=
/span><br><span> AC_ARG_ENABLE(</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	[ntlm],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[A=
S_HELP_STRING([--disable-ntlm], [disable NTLMv2 proxy support @&lt;:@defaul=
t=3Dyes@:&gt;@])],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[enable_ntlm=3D&quot;=
yes&quot;]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-AC_ARG_ENABLE(</span><br><span> 	[plugins],</span><b=
r><span> 	[AS_HELP_STRING([--disable-plugins], [disable plug-in support @&l=
t;:@default=3Dyes@:&gt;@])],</span><br><span> 	,</span><br><span>@@ -1171,7=
 +1164,6 @@</span><br><span> test &quot;${enable_fragment}&quot; =3D &quot;=
yes&quot; &amp;&amp; AC_DEFINE([ENABLE_FRAGMENT], [1], [Enable internal fra=
gmentation support])</span><br><span> test &quot;${enable_port_share}&quot;=
 =3D &quot;yes&quot; &amp;&amp; AC_DEFINE([ENABLE_PORT_SHARE], [1], [Enable=
 TCP Server port sharing])</span><br><span> test &quot;${enable_dns_updown_=
by_default}&quot; =3D &quot;yes&quot; &amp;&amp; AC_DEFINE([ENABLE_DNS_UPDO=
WN_BY_DEFAULT], [1], [Enable dns-updown hook by default])</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-test &quot;${enable_ntlm}&quot; =3D &qu=
ot;yes&quot; &amp;&amp; AC_DEFINE([ENABLE_NTLM], [1], [Enable NTLMv2 proxy =
support])</span><br><span> test &quot;${enable_crypto_ofb_cfb}&quot; =3D &q=
uot;yes&quot; &amp;&amp; AC_DEFINE([ENABLE_OFB_CFB_MODE], [1], [Enable OFB =
and CFB cipher modes])</span><br><span> OPTIONAL_CRYPTO_CFLAGS=3D&quot;${OP=
TIONAL_CRYPTO_CFLAGS} ${CRYPTO_CFLAGS}&quot;</span><br><span> OPTIONAL_CRYP=
TO_LIBS=3D&quot;${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_LIBS}&quot;</span><br><spa=
n>diff --git a/doc/doxygen/openvpn.doxyfile.in b/doc/doxygen/openvpn.doxyfi=
le.in</span><br><span>index bdbc608..5b8e262 100644</span><br><span>--- a/d=
oc/doxygen/openvpn.doxyfile.in</span><br><span>+++ b/doc/doxygen/openvpn.do=
xyfile.in</span><br><span>@@ -2212,7 +2212,6 @@</span><br><span> # This tag=
 requires that the tag ENABLE_PREPROCESSING is set to YES.</span><br><span>=
 </span><br><span> PREDEFINED             =3D _WIN32 \</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                         NTLM \</span><br>=
<span>                          USE_LZO \</span><br><span>                 =
         ENABLE_FRAGMENT \</span><br><span>                          P2MP \=
</span><br><span>diff --git a/doc/man-sections/proxy-options.rst b/doc/man-=
sections/proxy-options.rst</span><br><span>index 38c4578..7123838 100644</s=
pan><br><span>--- a/doc/man-sections/proxy-options.rst</span><br><span>+++ =
b/doc/man-sections/proxy-options.rst</span><br><span>@@ -7,7 +7,7 @@</span>=
<br><span>   ``--http-proxy-user-pass`` option (See `INLINE FILE SUPPORT`_)=
.</span><br><span> </span><br><span>   The last optional argument is an ``a=
uth-method`` which should be one</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  of :code:`none`, :code:`basic`, or :code:`ntlm2`.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  of :code:`none`, :code:`basic`=
.</span><br><span> </span><br><span>   HTTP Digest authentication is suppor=
ted as well, but only via the</span><br><span>   :code:`auto` or :code:`aut=
o-nct` flags (below).  This must replace</span><br><span>@@ -31,8 +31,6 @@<=
/span><br><span>      http-proxy proxy.example.net 3128 authfile.txt</span>=
<br><span>      # basic authentication, ask user for credentials</span><br>=
<span>      http-proxy proxy.example.net 3128 stdin</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     # NTLM authentication, load credential=
s from file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     http-=
proxy proxy.example.net 3128 authfile.txt ntlm2</span><br><span>      # det=
ermine which authentication is required, ask user for credentials</span><br=
><span>      http-proxy proxy.example.net 3128 auto</span><br><span>      #=
 determine which authentication is required, but reject basic</span><br><sp=
an>@@ -47,9 +45,8 @@</span><br><span>      password</span><br><span>      &=
lt;/http-proxy-user-pass&gt;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  Note that support for NTLMv1 proxies was removed=
 with OpenVPN 2.7.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  :=
code:`ntlm` now is an alias for :code:`ntlm2`; i.e. OpenVPN will always</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  attempt to use NTLMv2 a=
uthentication.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Not=
e that support for NTLMv1 proxies was removed with OpenVPN 2.7</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  and support for NTLMv2 proxies=
 was removed with OpenVPN 2.8.</span><br><span> </span><br><span> --http-pr=
oxy-user-pass userpass</span><br><span>   Overwrite the username/password i=
nformation for ``--http-proxy``. If specified</span><br><span>diff --git a/=
src/openvpn/Makefile.am b/src/openvpn/Makefile.am</span><br><span>index 3c5=
67aa..ff8cc54 100644</span><br><span>--- a/src/openvpn/Makefile.am</span><b=
r><span>+++ b/src/openvpn/Makefile.am</span><br><span>@@ -101,7 +101,6 @@</=
span><br><span> 	networking_iproute2.c networking_iproute2.h \</span><br><s=
pan> 	networking_sitnl.c networking_sitnl.h \</span><br><span> 	networking.=
h \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	ntlm.c ntlm.h \</=
span><br><span> 	occ.c occ.h \</span><br><span> 	openssl_compat.h \</span><=
br><span> 	pkcs11.c pkcs11.h pkcs11_backend.h \</span><br><span>diff --git =
a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c</span><br><span>deleted file mode=
 100644</span><br><span>index 8e913dc..0000000</span><br><span>--- a/src/op=
envpn/ntlm.c</span><br><span>+++ /dev/null</span><br><span>@@ -1,395 +0,0 @=
@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- *  ntlm proxy support for OpenVPN</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  Copyright (C) 2004 William Preston</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *  *NTLMv2 support and domain name parsing=
 by Miroslav Zajic, Nextsoft s.r.o.*</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
This program is free software; you can redistribute it and/or modify</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *  it under the terms of th=
e GNU General Public License as published by</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- *  the Free Software Foundation; either version 2 o=
f the License, or</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  =
(at your option) any later version.</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  T=
his program is distributed in the hope that it will be useful,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- *  but WITHOUT ANY WARRANTY; with=
out even the implied warranty of</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See th=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  GNU General Publ=
ic License for more details.</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  You shou=
ld have received a copy of the GNU General Public License along</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- *  with this program; if not, se=
e &lt;https://www.gnu.org/licenses/&gt;.</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_CONFIG_H=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;config=
.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#include &quot;syshead.h&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if NTLM</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;commo=
n.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &qu=
ot;buffer.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#inc=
lude &quot;misc.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#include &quot;socket.h&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#include &quot;fdmisc.h&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#include &quot;proxy.h&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#include &quot;ntlm.h&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#include &quot;base64.h&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#include &quot;crypto.h&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#include &quot;memdbg.h&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* 64bi=
t datatype macros */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
ifdef _MSC_VER</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* MS c=
ompilers */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define UI=
NTEGER64 __int64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne UINT64(c)  c##Ui64</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Non MS compil=
ers */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define UINTEGE=
R64 unsigned long long</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define UINT64(c)  c##LL</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-gen_md4_hash(const uint8_t *data, int data_len, uint8_t *result=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    /* result is 16 byte md4 hash */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t md[MD4_DIGEST=
_LENGTH];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    md_full(&quot;MD4&quot;, data=
, data_len, md);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
emcpy(result, md, MD4_DIGEST_LENGTH);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-gen_hmac_md5(const uint8_t *data, i=
nt data_len, const uint8_t *key, uint8_t *result)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    hmac_ctx_init(hmac_ctx, key, &quot;MD5&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    hmac_ctx_update(hmac_ctx, data,=
 data_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    hmac_c=
tx_final(hmac_ctx, result);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    hmac_ctx_cleanup(hmac_ctx);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    hmac_ctx_free(hmac_ctx);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC=
__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ge=
n_timestamp(uint8_t *timestamp)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Cop=
ies 8 bytes long timestamp into &quot;timestamp&quot; buffer.</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-     * Timestamp is Little-endian, =
64-bit signed value representing the</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     * number of tenths of a microsecond since January 1, 16=
01.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    UINTEGER64 timestamp_ull;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    timestamp_ull =3D openvpn_time(NULL);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    timestamp_ull =3D (timestamp_ull + UINT=
64(11644473600)) * UINT64(10000000);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*=
 store little endian value */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    timestamp[0] =3D timestamp_ull &amp; UINT64(0xFF);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    timestamp[1] =3D (timestamp_ul=
l &gt;&gt; 8) &amp; UINT64(0xFF);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    timestamp[2] =3D (timestamp_ull &gt;&gt; 16) &amp; UINT64(0=
xFF);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    timestamp[3]=
 =3D (timestamp_ull &gt;&gt; 24) &amp; UINT64(0xFF);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    timestamp[4] =3D (timestamp_ull &gt;&gt=
; 32) &amp; UINT64(0xFF);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    timestamp[5] =3D (timestamp_ull &gt;&gt; 40) &amp; UINT64(0xFF);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    timestamp[6] =3D (ti=
mestamp_ull &gt;&gt; 48) &amp; UINT64(0xFF);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    timestamp[7] =3D (timestamp_ull &gt;&gt; 56) &am=
p; UINT64(0xFF);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-gen_nonce(unsigned char *nonce)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    /* Generates 8 random bytes to be used as client nonce */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    for (i =3D 0; i &lt; 8; i++)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        nonce[i] =3D (unsigned char)get_random();</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-my_strupr(char *str)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    /* converts string to uppercase in place */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    while (*str)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        *str =3D toupper(*str);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        str++;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * This function expects a null-terminated string in src and =
will</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * copy it (inclu=
ding the terminating NUL byte),</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * alternating it with 0 to dst.</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * This basically will transform a ASCII string into valid UTF-16.</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- * Characters that are 8bit =
in src, will get the same treatment, resulting in</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * invalid or wrong unicode code points.</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * @note the function will blindly assume that =
dst has double</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the =
space of src.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @retu=
rn  the length of the number of bytes written to dst</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static int</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-unicodize(char *dst, const char *src)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* not really unicode... */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    int i =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        dst[i++] =3D *src;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dst[i++] =3D 0=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    } while (*src++)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    return i;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-add_security_buffer(int s=
b_offset, void *data, int length, unsigned char *msg_buf, int *msg_bufpos,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    si=
ze_t msg_bufsize)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (*msg_bufpos + le=
ngth &gt; msg_bufsize)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_W=
ARN, &quot;NTLM: security buffer too big for message buffer&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* Adds security buffer data to a message and s=
ets security buffer&#39;s</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     * offset and length */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    msg_buf[sb_offset] =3D (unsigned char)length;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    msg_buf[sb_offset + 2] =3D msg_bu=
f[sb_offset];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg_=
buf[sb_offset + 4] =3D (unsigned char)(*msg_bufpos &amp; 0xff);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    msg_buf[sb_offset + 5] =3D (u=
nsigned char)((*msg_bufpos &gt;&gt; 8) &amp; 0xff);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    memcpy(&amp;msg_buf[*msg_bufpos], data,=
 msg_buf[sb_offset]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    *msg_bufpos +=3D length;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-const char *</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-ntlm_phase_1(const struct http_proxy_info *=
p, struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer =
out =3D alloc_buf_gc(96, gc);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    /* try a minimal NTLM handshake</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-     *</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-     * https://davenport.sourceforge.net/ntlm.html</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-     *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-     * This message contains only the NTLMSSP signatur=
e,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * the NTLM mes=
sage type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * and =
the minimal set of flags (Negotiate NTLM and Negotiate OEM).</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-     *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    buf_printf(&amp;out, &quot;%s&quot;, &quot;TlRMTVNTUAABAAAAAg=
IAAA=3D=3D&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return (BSTR(&amp;out));</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-const char *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-ntlm_phase_3(const struct http_proxy_info *p, =
const char *phase_2, struct gc_arena *gc)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    /* NTLM handshake</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * https://=
davenport.sourceforge.net/ntlm.html</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-     *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
    */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    char pwbuf[sizeof(p-&gt;up.passw=
ord) * 2]; /* for unicode password */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    uint8_t phase3[464];</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  uint8_t md4_hash[MD4_DIGEST_LENGTH + 5];</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    uint8_t challenge[8];</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    int i, ret_val;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    uint8_t ntlmv2_response[256];</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    char userdomain_u[256]; /* for uppercase unicode username=
 and domain */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cha=
r userdomain[128];   /* the same as previous but ascii */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    uint8_t ntlmv2_hash[MD5_DIGEST_LENG=
TH];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t ntlmv=
2_hmacmd5[16];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uin=
t8_t *ntlmv2_blob =3D ntlmv2_response + 16; /* inside ntlmv2_response, leng=
th: 128 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ntl=
mv2_blob_size =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int phase3_bufpos =3D 0x40;                    /* offset to next securit=
y buffer data to be added */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    size_t len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char domain[128]=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char username[12=
8];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *separato=
r;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    ASSERT(strlen(p-&gt;up.username) &gt=
; 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(strle=
n(p-&gt;up.password) &gt; 0);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* userna=
me parsing */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sepa=
rator =3D strchr(p-&gt;up.username, &#39;\\&#39;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (separator =3D=3D NULL)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        strncpy(username, p-&gt;up.username, sizeof(u=
sername) - 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 username[sizeof(username) - 1] =3D 0;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        domain[0] =3D 0;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        strncpy(username,=
 separator + 1, sizeof(username) - 1);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        username[sizeof(username) - 1] =3D 0;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        len =3D separator - p-&gt;=
up.username;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (len &gt; sizeof(domain) - 1)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          len =3D sizeof(domain) - 1;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        strncpy(domain, p-&gt;up.username, len);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        domain[len] =3D 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* fill 1st 16 by=
tes with md4 hash, disregard terminating null */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    int unicode_len =3D unicodize(pwbuf, p-&gt;u=
p.password) - 2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    g=
en_md4_hash((uint8_t *)pwbuf, unicode_len, md4_hash);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* pad to 21 bytes */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    memset(md4_hash + MD4_DIGEST_LENGTH, 0, 5);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* If the decoded challenge is shorter than require=
d by the protocol,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
  * the missing bytes will be NULL, as buf2 is known to be zeroed</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-     * when this decode happens=
.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    uint8_t buf2[512]; /* decoded =
reply from proxy */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  CLEAR(buf2);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret=
_val =3D openvpn_base64_decode(phase_2, buf2, -1);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (ret_val &lt; 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(M_WARN, &quot;NTLM: base64 decoding of phase 2 =
response failed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        return NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    /* extract the challenge from by=
tes 24-31 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (=
i =3D 0; i &lt; 8; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        challe=
nge[i] =3D buf2[i + 24];</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* Generate NTLMv2 response */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int tib_len;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /* NTLMv2 hash */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    strcpy(userdomain, username);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    my_strupr(userdomain);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (strlen(username) + str=
len(domain) &lt; sizeof(userdomain))</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       strcat(userdomain, domain);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_INFO, &quot;NTLM: =
Username or domain too long&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  unicodize(userdomain_u, userdomain);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    gen_hmac_md5((uint8_t *)userdomain_u, 2 * strlen(userd=
omain), md4_hash, ntlmv2_hash);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* NTLM=
v2 Blob */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    memset(=
ntlmv2_blob, 0, 128);       /* Clear blob buffer */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    ntlmv2_blob[0x00] =3D 1;             /*=
 Signature */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ntlm=
v2_blob[0x01] =3D 1;             /* Signature */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    ntlmv2_blob[0x04] =3D 0;             /* Rese=
rved */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gen_timest=
amp(&amp;ntlmv2_blob[0x08]); /* 64-bit Timestamp */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    gen_nonce(&amp;ntlmv2_blob[0x10]);     =
/* 64-bit Client Nonce */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    ntlmv2_blob[0x18] =3D 0;             /* Unknown, zero should work *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* Add target information block to th=
e blob */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    /* Check for Target Informati=
on block */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* The=
 NTLM spec instructs to interpret these 4 consecutive bytes as a</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-     * 32bit long integer. Howev=
er, no endianness is specified.</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-     * The code here and that found in other NTLM implementations=
 point</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * towards =
the assumption that the byte order on the wire has to</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     * match the order on the sending and r=
eceiving hosts. Probably NTLM has</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-     * been thought to be always running on x86_64/i386 machine=
 thus</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * implying =
Little-Endian everywhere.</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * This=
 said, in case of future changes, we should keep in mind that the</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-     * byte order on the wire f=
or the NTLM header is LE.</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const =
size_t hoff =3D 0x14;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    unsigned long flags =3D</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        buf2[hoff] | (buf2[hoff + 1] &lt;&lt; 8) | (buf2[hoff + 2] &l=
t;&lt; 16) | (buf2[hoff + 3] &lt;&lt; 24);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if ((flags &amp; 0x00800000) =3D=3D 0x00800000)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        tib_len =3D buf2[0x28]; /* Get T=
arget Information block size */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (tib_len + 0x1c + 16 &gt; sizeof(ntlmv2_response))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;NTLM: t=
arget information buffer too long for response (len=3D%d)&quot;, tib_len);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return NUL=
L;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            uint8_t *tib_ptr;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            uint8_t tib_pos =3D buf2[0x2c];</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            if (tib_pos + tib_len =
&gt; sizeof(buf2))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     msg(M_ERR,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              &quot;NTLM: phase 2 response from server too long (need %d by=
tes at offset %u)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    tib_len, tib_pos);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                return NULL;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            /* Get Target Information block pointer */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            tib_ptr =3D=
 buf2 + tib_pos;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       /* Copy Target Information block into the blob */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            memcpy(&amp;ntlmv2_blob[0x1c=
], tib_ptr, tib_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        tib_len =3D 0;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Unknown, ze=
ro works */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ntlmv2=
_blob[0x1c + tib_len] =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Get blo=
b length */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ntlmv2=
_blob_size =3D 0x20 + tib_len;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Add c=
hallenge from message 2 */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    memcpy(&amp;ntlmv2_response[8], challenge, 8);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /* hmac-md5 */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    gen_hmac_md5(&amp;ntlmv2_response[8], ntlmv2_blob_size + 8, n=
tlmv2_hash, ntlmv2_hmacmd5);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Add hma=
c-md5 result to the blob.</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     * Note: This overwrites challenge previously written at</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-     * ntlmv2_response[8..15] */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    memcpy(ntlmv2_res=
ponse, ntlmv2_hmacmd5, MD5_DIGEST_LENGTH);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    memset(phase3, 0, sizeof(phase3));   /* clear reply */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    strcpy((char *)phase3, &quot;NTLMSSP\0&quot;); /* signa=
ture */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    phase3[8] =
=3D 3;                       /* type 3 */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* NTLMv2 response */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    add_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 16, ph=
ase3, &amp;phase3_bufpos,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                        sizeof(phase3));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    /* username in ascii */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    add_security_buffer(0x24, username, strlen(username), phase3, &=
amp;phase3_bufpos, sizeof(phase3));</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* =
Set domain. If &lt;domain&gt; is empty, default domain will be used</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-     * (i.e. proxy&#39;s doma=
in) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    add_securit=
y_buffer(0x1c, domain, strlen(domain), phase3, &amp;phase3_bufpos, sizeof(p=
hase3));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* other security buffers will=
 be empty */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    phase=
3[0x10] =3D phase3_bufpos; /* lm not used */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    phase3[0x30] =3D phase3_bufpos; /* no workstatio=
n name supplied */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 phase3[0x38] =3D phase3_bufpos; /* no session key */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    /* flags */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    phase3[0x3c] =3D 0x02; /* negotiate oem */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    phase3[0x3d] =3D 0x02; /* negotiate ntl=
m */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return ((const char *)make_base64_=
string2((unsigned char *)phase3, phase3_bufpos, gc));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif /* if NTLM */</span><br><span>diff --git a/src/openvpn/ntlm.h b/s=
rc/openvpn/ntlm.h</span><br><span>deleted file mode 100644</span><br><span>=
index b0a6821..0000000</span><br><span>--- a/src/openvpn/ntlm.h</span><br><=
span>+++ /dev/null</span><br><span>@@ -1,12 +0,0 @@</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifndef NTLM_H</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define NTLM_H</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 NTLM</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-const char *ntlm_phase_1(const struct=
 http_proxy_info *p, struct gc_arena *gc);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
const char *ntlm_phase_3(const struct http_proxy_info *p, const char *phase=
_2, struct gc_arena *gc);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#endif</span><br><span>diff --git a/src/openvpn/optio=
ns.c b/src/openvpn/options.c</span><br><span>index 2bca647..09a5d48 100644<=
/span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openv=
pn/options.c</span><br><span>@@ -158,8 +158,7 @@</span><br><span>     &quot=
;                  through an HTTP proxy at address s and port p.\n&quot;</=
span><br><span>     &quot;                  If proxy authentication is requ=
ired,\n&quot;</span><br><span>     &quot;                  up is a file con=
taining username/password on 2 lines, or\n&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    &quot;                  &#39;stdin&#39; to p=
rompt from console.  Add auth=3D&#39;ntlm2&#39; if\n&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    &quot;                  the proxy =
requires NTLM authentication.\n&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    &quot;                  &#39;stdin&#39; to prompt fro=
m console.\n&quot;</span><br><span>     &quot;--http-proxy s p &#39;auto[-n=
ct]&#39; : Like the above directive, but automatically\n&quot;</span><br><s=
pan>     &quot;                  determine auth method and query for userna=
me/password\n&quot;</span><br><span>     &quot;                  if needed.=
  auto-nct disables weak proxy auth methods.\n&quot;</span><br><span>diff -=
-git a/src/openvpn/proxy.c b/src/openvpn/proxy.c</span><br><span>index efd4=
aad..b355827 100644</span><br><span>--- a/src/openvpn/proxy.c</span><br><sp=
an>+++ b/src/openvpn/proxy.c</span><br><span>@@ -35,7 +35,6 @@</span><br><s=
pan> #include &quot;proxy.h&quot;</span><br><span> #include &quot;base64.h&=
quot;</span><br><span> #include &quot;httpdigest.h&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#include &quot;ntlm.h&quot;</span><br><s=
pan> #include &quot;memdbg.h&quot;</span><br><span> #include &quot;forward.=
h&quot;</span><br><span> </span><br><span>@@ -348,14 +347,6 @@</span><br><s=
pan>                 ret =3D HTTP_AUTH_DIGEST;</span><br><span>            =
 }</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if NTLM</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    else if (!strncmp(buf + 20, &quot;NTLM&quot;, 4))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                msg(D_PROXY, &quot;PROXY AUTH NTLM:=
 &#39;%s&#39;&quot;, buf);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                *data =3D NULL;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                ret =3D HTTP_AUTH_NTLM2;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif</span><br><span>         }</span><br><span=
>     }</span><br><span> }</span><br><span>@@ -511,40 +502,20 @@</span><br>=
<span>         {</span><br><span>             p-&gt;auth_method =3D HTTP_AU=
TH_BASIC;</span><br><span>         }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#if NTLM</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        else if (!strcmp(o-&gt;auth_method_string, &quot;ntlm&quot;))</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                &quot;NTLM v1 authe=
ntication has been removed in OpenVPN 2.7. Will try to use NTLM v2 authenti=
cation.&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      p-&gt;auth_method =3D HTTP_AUTH_NTLM2;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        else if (!strcmp(o-&gt;auth_method_string, &quot;ntlm2&q=
uot;))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            p-&gt;auth_meth=
od =3D HTTP_AUTH_NTLM2;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</sp=
an><br><span>         else</span><br><span>         {</span><br><span>     =
        msg(M_FATAL, &quot;ERROR: unknown HTTP authentication method: &#39;=
%s&#39;&quot;, o-&gt;auth_method_string);</span><br><span>         }</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /* When basic or NTLMv2 authentication is requested, get c=
redentials now.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* When basic authentication is requested, get credentials now.</span><br><=
span>      * In case of &quot;auto&quot; negotiation credentials will be re=
trieved later once</span><br><span>      * we know whether we need any. */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (p-&gt;auth_met=
hod =3D=3D HTTP_AUTH_BASIC || p-&gt;auth_method =3D=3D HTTP_AUTH_NTLM2)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (p-&gt;auth_meth=
od =3D=3D HTTP_AUTH_BASIC)</span><br><span>     {</span><br><span>         =
get_user_pass_http(p, p-&gt;options.first_time);</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if !NT=
LM</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (p-&gt;auth_=
method =3D=3D HTTP_AUTH_NTLM2)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 msg(M_FATAL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    &quot;Sorry, this version of &quot; PACKAGE_NAME &quot; was built witho=
ut NTLM Proxy support.&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     =
p-&gt;defined =3D true;</span><br><span>     return p;</span><br><span> }</=
span><br><span>@@ -638,8 +609,7 @@</span><br><span>     volatile int *signa=
l_received =3D &amp;sig_info-&gt;signal_received;</span><br><span> </span><=
br><span>     /* get user/pass if not previously given */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (p-&gt;auth_method =3D=3D HTTP_A=
UTH_BASIC || p-&gt;auth_method =3D=3D HTTP_AUTH_DIGEST</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        || p-&gt;auth_method =3D=3D HTTP_A=
UTH_NTLM2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (p=
-&gt;auth_method =3D=3D HTTP_AUTH_BASIC || p-&gt;auth_method =3D=3D HTTP_AU=
TH_DIGEST)</span><br><span>     {</span><br><span>         get_user_pass_ht=
tp(p, false);</span><br><span> </span><br><span>@@ -692,25 +662,6 @@</span>=
<br><span>                 }</span><br><span>                 break;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if NTLM</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            case HTTP_A=
UTH_NTLM2:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     /* keep-alive connection */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                snprintf(buf, sizeof(buf), &quot;Proxy-Connectio=
n: Keep-Alive&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                if (!send_line_crlf(sd, buf))</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    goto error;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                snprintf(buf, sizeof(buf), &quot;Proxy-Authorization=
: NTLM %s&quot;, ntlm_phase_1(p, &amp;gc));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                msg(D_PROXY, &quot;Attempting NTLM Pr=
oxy-Authorization phase 1&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                dmsg(D_SHOW_KEYS, &quot;Send to HTTP proxy: &#3=
9;%s&#39;&quot;, buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                if (!send_line_crlf(sd, buf))</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    goto error;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                break;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span>             default:</span><br><span>      =
           ASSERT(0);</span><br><span>         }</span><br><span>@@ -749,11=
2 +700,6 @@</span><br><span>         {</span><br><span>             process=
ed =3D true;</span><br><span>         }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        else if (p-&gt;auth_method =3D=3D HTTP_AUTH_NTLM2=
 &amp;&amp; !processed) /* check for NTLM */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if NTLM</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          /* look for the phase 2 response */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            char buf2[512];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            while (true)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                if (!recv_line(sd, buf, sizeof(b=
uf),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
              get_server_poll_remaining_time(server_poll_timeout), true, NU=
LL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
             signal_received))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    goto error;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                chomp(buf);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                msg(D_PROXY, &quot;HTTP proxy returned: &#=
39;%s&#39;&quot;, buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                cha=
r get[80];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     CLEAR(buf2);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            snprintf(get, sizeof(get), &quot;%%*s NTLM %%%zus&quot;, sizeof=
(buf2) - 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       nparms =3D sscanf(buf, get, buf2);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               /* check for &quot;Proxy-Authenticate: NTLM TlRM...&quot; */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (n=
parms =3D=3D 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          /* parse buf2 */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    msg(D_PROXY, &quot;auth string: &#39;%s&#39;&quot;=
, buf2);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* if we=
 are here then auth string was got */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            msg(D_PROXY, &quot;Received NTLM Proxy-Authoriz=
ation phase 2 response&quot;);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
/* receive and discard everything else */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            while (recv_line(sd, NULL, 0, 2, true, NULL=
, signal_received))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            /* now send the phase 3 rep=
ly */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            /* format HTTP CONNECT me=
ssage */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            s=
nprintf(buf, sizeof(buf), &quot;CONNECT %s:%s HTTP/%s&quot;, host, port,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                     p-&=
gt;options.http_version);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D=
_PROXY, &quot;Send to HTTP proxy: &#39;%s&#39;&quot;, buf);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            /* send HTTP CONNECT message to proxy */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!send_line_=
crlf(sd, buf))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 goto error;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            /* keep-alive connection *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            snprintf=
(buf, sizeof(buf), &quot;Proxy-Connection: Keep-Alive&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            if (!send_line_crlf(sd,=
 buf))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                goto er=
ror;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            /* send HOST etc, */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            if (!add_proxy_headers(=
p, sd, host))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
goto error;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            msg(D_PROXY, &quot;Attempti=
ng NTLM Proxy-Authorization phase 3&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                const char *np3 =3D ntlm_phase_3(p, buf2, &am=
p;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 if (!np3)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     msg(D_PROXY,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    &quot;NTLM Proxy-Authorization phase 3 failed: received=
 corrupted data from proxy server&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    goto error;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                snprintf(buf, sizeof(buf), &quo=
t;Proxy-Authorization: NTLM %s&quot;, np3);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     msg(D_PROXY, &quot;Send to HTTP proxy: &#39;%s&#39;&quot;, buf);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!send_line_=
crlf(sd, buf))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 goto error;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* ok=
 so far... */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    /* send empty CR, LF */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            if (!send_crlf(sd))</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                goto error;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* =
receive reply from proxy */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            if (!recv_line(sd, buf, sizeof(buf),</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                           get_server_poll=
_remaining_time(server_poll_timeout), true, NULL,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                           signal_received))</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                goto error;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            /* remove trailing CR, LF */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            chomp(buf);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(D_PROXY, &quot;HTTP proxy returned: &#3=
9;%s&#39;&quot;, buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* parse=
 return string */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        nparms =3D sscanf(buf, &quot;%*s %d&quot;, &amp;status);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            processed =3D true;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if NTLM */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an> #if PROXY_DIGEST_AUTH</span><br><span>         else if (p-&gt;auth_meth=
od =3D=3D HTTP_AUTH_DIGEST &amp;&amp; !processed)</span><br><span>         =
{</span><br><span>diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h</s=
pan><br><span>index 89c2da77..e662e7d 100644</span><br><span>--- a/src/open=
vpn/proxy.h</span><br><span>+++ b/src/openvpn/proxy.h</span><br><span>@@ -3=
1,7 +31,7 @@</span><br><span> #define HTTP_AUTH_BASIC  1</span><br><span> #=
define HTTP_AUTH_DIGEST 2</span><br><span> /* #define HTTP_AUTH_NTLM   3 re=
moved in OpenVPN 2.7 */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define HTTP_AUTH_NTLM2  4</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* #define HTTP_AUTH_NTLM2  4 removed in OpenVPN 2.8 */</span><br>=
<span> #define HTTP_AUTH_N      5 /* number of HTTP_AUTH methods */</span><=
br><span> </span><br><span> struct http_custom_header</span><br><span>diff =
--git a/src/openvpn/syshead.h b/src/openvpn/syshead.h</span><br><span>index=
 582e130..067ee9d 100644</span><br><span>--- a/src/openvpn/syshead.h</span>=
<br><span>+++ b/src/openvpn/syshead.h</span><br><span>@@ -491,13 +491,6 @@<=
/span><br><span> #endif</span><br><span> </span><br><span> /*</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * Should we include NTLM proxy fun=
ctionality</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_NTLM</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define NTLM 1</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
/*</span><br><span>  * Should we include proxy digest auth functionality</s=
pan><br><span>  */</span><br><span> #define PROXY_DIGEST_AUTH 1</span><br><=
span>diff --git a/tests/Makefile.am b/tests/Makefile.am</span><br><span>ind=
ex cb30fe5..3907965 100644</span><br><span>--- a/tests/Makefile.am</span><b=
r><span>+++ b/tests/Makefile.am</span><br><span>@@ -49,13 +49,4 @@</span><b=
r><span> ntlm_support_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdi=
r)/src/compat -I$(top_srcdir)/tests/unit_tests/openvpn -DNO_CMOCKA @TEST_CF=
LAGS@</span><br><span> ntlm_support_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcd=
ir)/src/openvpn $(OPTIONAL_CRYPTO_LIBS)</span><br><span> ntlm_support_SOURC=
ES =3D ntlm_support.c \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	unit_tests/openvpn/mock_msg.c unit_tests/openvpn/mock_msg.h \</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/buffe=
r.c \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/s=
rc/openvpn/crypto.c \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	$(top_srcdir)/src/openvpn/crypto_epoch.c \</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/crypto_openssl.c \</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/cr=
ypto_mbedtls.c \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(to=
p_srcdir)/src/openvpn/crypto_mbedtls_legacy.c \</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/otime.c \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/packet_=
id.c \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcdir)/=
src/openvpn/platform.c</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	unit_tests/openvpn/mock_msg.c unit_tests/openvpn/mock_msg.h</span><br><=
span>diff --git a/tests/ntlm_support.c b/tests/ntlm_support.c</span><br><sp=
an>index 4fd044e..a4ee00e 100644</span><br><span>--- a/tests/ntlm_support.c=
</span><br><span>+++ b/tests/ntlm_support.c</span><br><span>@@ -26,30 +26,1=
0 @@</span><br><span> </span><br><span> #include &quot;syshead.h&quot;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include=
 &quot;crypto.h&quot;</span><br><span> #include &quot;error.h&quot;</span><=
br><span> </span><br><span> int</span><br><span> main(void)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef NTLM</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_CRYPTO_OP=
ENSSL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    provider_t =
*legacy =3D crypto_load_provider(&quot;legacy&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    provider_t *def =3D crypto_load_provide=
r(&quot;default&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!md_v=
alid(&quot;MD4&quot;))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_F=
ATAL, &quot;MD4 not supported&quot;);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (!md_valid(&quot;MD5&quot;))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      msg(M_FATAL, &quot;MD5 not supported&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if defined(ENABLE_CRYPTO_OPENSSL)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    crypto_unload_provider(&quot;legacy&quot;, le=
gacy);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    crypto_unlo=
ad_provider(&quot;default&quot;, def);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#else /* ifdef NTLM */</span><br><span>     msg(M_FATAL, &quot;NTLM suppo=
rt not compiled in&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span> }</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1453?usp=3Demail">c=
hange 1453</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1453?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1f5724476862935284f620c54af=
a510eea03e3f9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1453 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--xpsArVki2ho=--

