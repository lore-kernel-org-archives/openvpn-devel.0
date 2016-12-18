References: <1397645317-20116-2-git-send-email-Holger.Kummert@...1516...>
	<1404459325-11064-1-git-send-email-Holger.Kummert@...1516...>
	<561D8BCF.60304@...1856...> <563371FD.70206@...1516...>
	<CAA1AbxKuF3ewuhn_XTvymCfq_my8vqK+-Q1mj59VBZp4jOK7VA@...278...>
	<563379B3.90905@...1516...> <20151110194853.GR24952@...1296...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <0fb5c4b7-be42-8859-14b0-8bfe474dfbc7@...1856...>
Date: Sun, 18 Dec 2016 17:46:55 +0100
MIME-Version: 1.0
In-Reply-To: <20151110194853.GR24952@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nFICrHG6jdVq5knBHjJgOk4PkwP3N1jdL"
Subject: Re: [Openvpn-devel] [PATCHv2 1/2] Get NTLMv1 and NTLMv2 up and
 running
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Holger Kummert <Holger.Kummert@...1516...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nFICrHG6jdVq5knBHjJgOk4PkwP3N1jdL
Content-Type: multipart/mixed; boundary="B1k7kkVMM9vKdaSutx2Fo0PCKGRJQKd3G"
From: Steffan Karger <steffan@...1856...>
To: Gert Doering <gert@...1296...>,
	Holger Kummert <Holger.Kummert@...1516...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <0fb5c4b7-be42-8859-14b0-8bfe474dfbc7@...1856...>
Subject: Re: [Openvpn-devel] [PATCHv2 1/2] Get NTLMv1 and NTLMv2 up and running
References: <1397645317-20116-2-git-send-email-Holger.Kummert@...1516...>
	<1404459325-11064-1-git-send-email-Holger.Kummert@...1516...>
	<561D8BCF.60304@...1856...> <563371FD.70206@...1516...>
	<CAA1AbxKuF3ewuhn_XTvymCfq_my8vqK+-Q1mj59VBZp4jOK7VA@...278...>
	<563379B3.90905@...1516...> <20151110194853.GR24952@...1296...>
In-Reply-To: <20151110194853.GR24952@...1296...>

--B1k7kkVMM9vKdaSutx2Fo0PCKGRJQKd3G
Content-Type: multipart/mixed; boundary="------------6D1F139762C9E89AF6C2E46A"

This is a multi-part message in MIME format.
--------------6D1F139762C9E89AF6C2E46A
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 10-11-15 20:48, Gert Doering wrote:
> On Fri, Oct 30, 2015 at 03:07:47PM +0100, Holger Kummert wrote:
>> Am 30.10.2015 um 14:58 schrieb Steffan Karger:
> [..]
>>> Seems I forgot the * before the second msg_bufpos, sorry.  msg_bufpos
>>> itself is a pointer indeed, but *msg_bufpos is (used as) an offset
>>> into msg_buf:
>>>
>>>     memcpy(&msg_buf[*msg_bufpos], data, msg_buf[sb_offset]);
>>>
>>> msg_bufpos (without the *) is not related to msg_buf.
>>
>> Ah, then your first proposal makes sense
>> (i.e. if (msg_buflen - length < *msg_bufpos) )
>>
>> We could take that.
>=20
> So, how do we move onward here?  Holger, can you send a new patch (set)=20
> incorporating Steffan's comments?
>=20
> Since we found a proper reviewer now, merging this looks possible, after
> all the time... ;-)

Would still be nice to get this patch in.  I've had this patch (plus a
type-fix patch) in my local repo for a long time now, so to get things
started a bit, I rebased it onto the current (post-reformatting) master
branch.  The patch is attached.

Any news from the author's side?

-Steffan

--------------6D1F139762C9E89AF6C2E46A
Content-Type: text/x-patch;
	name="0001-Get-NTLMv1-and-NTLMv2-up-and-running.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Get-NTLMv1-and-NTLMv2-up-and-running.patch"

=46rom c5f5fc4278d34e8d99733672a6a324830907aa23 Mon Sep 17 00:00:00 2001
From: Holger Kummert <Holger.Kummert@...1516...>
Date: Fri, 4 Jul 2014 09:35:24 +0200
Subject: [PATCH] Get NTLMv1 and NTLMv2 up and running

  * Force conversion to UTF-16 of username and domain if server requires =
UTF-16.
  * Rewrite conversion function to cleanly convert UTF-8 to UTF-16.
  * Fix bug in length computation in NTLMv2-code.
  * Architecture independent access to NTLM NegotiateFlags.

Signed-off-by: Holger Kummert <Holger.Kummert@...1516...>
---
 src/openvpn/ntlm.c | 190 ++++++++++++++++++++++++++++++++++++++++++++++-=
------
 1 file changed, 166 insertions(+), 24 deletions(-)

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index e78af9e..062efba 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -56,6 +56,21 @@
 #endif
=20
=20
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
+
=20
 static void
 create_des_keys(const unsigned char *hash, unsigned char *key)
@@ -78,8 +93,11 @@ gen_md4_hash(const char *data, int data_len, char *res=
ult)
     const md_kt_t *md4_kt =3D md_kt_get("MD4");
     char md[MD4_DIGEST_LENGTH];
=20
-    md_full(md4_kt, data, data_len, md);
-    memcpy(result, md, MD4_DIGEST_LENGTH);
+    if (data_len >=3D 0)
+    {
+        md_full(md4_kt, data, data_len, md);
+        memcpy(result, md, MD4_DIGEST_LENGTH);
+    }
 }
=20
 static void
@@ -140,23 +158,106 @@ my_strupr(unsigned char *str)
 }
=20
 static int
-unicodize(char *dst, const char *src)
+utf8_to_utf16LE(unsigned char *dst, int dst_len, unsigned char *src)
 {
-    /* not really unicode... */
-    int i =3D 0;
-    do
+    /* Convert UTF-8 to UTF-16 little endian
+     *
+     * http://clang.llvm.org/doxygen/ConvertUTF_8c_source.html
+     */
+    unsigned char *end =3D src + strlen(src),
+                  *dst_start =3D dst;
+    const char trailingBytesForUTF8[256] =3D {
+        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0=
,
+        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0=
,
+        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0=
,
+        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0=
,
+        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0=
,
+        0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0=
,
+        1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1, 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1=
,
+        2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2, 3,3,3,3,3,3,3,3,4,4,4,4,5,5,5,5=

+    };
+    const unsigned int offsetsUtf8[6] =3D { 0x00000000UL, 0x00003080UL, =
0x000E2080UL,
+                                          0x03C82080UL, 0xFA082080UL, 0x=
82082080UL };
+
+    while (src < end)
     {
-        dst[i++] =3D *src;
-        dst[i++] =3D 0;
+        unsigned int ch =3D 0,
+                     extraBytes =3D trailingBytesForUTF8[*src];
+
+        if (extraBytes >=3D end - src)
+        {
+            return -1;
+        }
+
+        /* The cases all fall through. */
+        switch (extraBytes) {
+            case 5: ch +=3D *src++; ch <<=3D 6;
+
+            case 4: ch +=3D *src++; ch <<=3D 6;
+
+            case 3: ch +=3D *src++; ch <<=3D 6;
+
+            case 2: ch +=3D *src++; ch <<=3D 6;
+
+            case 1: ch +=3D *src++; ch <<=3D 6;
+
+            case 0: ch +=3D *src++;
+        }
+        ch -=3D offsetsUtf8[extraBytes];   /* clean up UTF-8 control bit=
s */
+
+        /* Now 'ch' contains the codepoint of the UTF-8-character. */
+
+        if (ch <=3D 0xFFFF)
+        {
+            if (ch >=3D UNI_SUR_HIGH_START && ch <=3D UNI_SUR_LOW_END)
+            {
+                msg(M_INFO, "Warning: Illegal character value: %x is in =
reserved area of UTF-16 [%x, %x]", UNI_SUR_HIGH_START, UNI_SUR_LOW_END);
+                return -1;
+            }
+            else  /* normal case */
+            {
+                if (dst_len - (dst - dst_start) < 2)
+                {
+                    msg(M_INFO, "Warning: Not enough space in destinatio=
n buffer for conversion to UTF-16");
+                    return -1;
+                }
+                *dst++ =3D ch & 0xff;
+                *dst++ =3D (ch >> 8) & 0xff;
+            }
+        }
+        else if (ch > UNI_MAX_UTF16)
+        {
+            msg(M_INFO, "Warning: Illegal character value :%x is too lar=
ge for UTF-16", ch);
+            return -1;
+        }
+        else
+        {
+            /* character is in range 0xFFFF - 0x10FFFF. */
+            if (dst_len - (dst - dst_start) < 4)
+            {
+                msg(M_INFO, "Warning: Not enough space in destination bu=
ffer for conversion to UTF-16");
+                return -1;
+            }
+            ch -=3D UNI_HALF_BASE;
+            *dst++ =3D ( (ch >> UNI_HALF_SHIFT) + UNI_SUR_HIGH_START)   =
     & 0xff;
+            *dst++ =3D (((ch >> UNI_HALF_SHIFT) + UNI_SUR_HIGH_START) >>=
 8) & 0xff;
+            *dst++ =3D ( (ch & UNI_HALF_MASK) + UNI_SUR_LOW_START)      =
     & 0xff;
+            *dst++ =3D (((ch & UNI_HALF_MASK) + UNI_SUR_LOW_START) >> 8)=
    & 0xff;
+        }
     }
-    while (*src++);
=20
-    return i;
+    return dst - dst_start;
 }
=20
 static void
-add_security_buffer(int sb_offset, void *data, int length, unsigned char=
 *msg_buf, int *msg_bufpos)
+add_security_buffer(int sb_offset, void *data, int length, unsigned char=
 *msg_buf, int *msg_bufpos, int msg_buflen)
 {
+    if ((*msg_bufpos - *msg_buf) + length > msg_buflen)
+    {
+        msg(M_INFO, "Warning: Not enough space in destination buffer");
+        return;
+    }
+
     /* Adds security buffer data to a message and sets security buffer's=
 offset and length */
     msg_buf[sb_offset] =3D (unsigned char)length;
     msg_buf[sb_offset + 2] =3D msg_buf[sb_offset];
@@ -195,10 +296,12 @@ ntlm_phase_3(const struct http_proxy_info *p, const=
 char *phase_2, struct gc_are
     char pwbuf[sizeof(p->up.password) * 2]; /* for unicode password */
     char buf2[128]; /* decoded reply from proxy */
     unsigned char phase3[464];
+    unsigned long ntlm_negotiate_flags;
=20
     char md4_hash[MD4_DIGEST_LENGTH+5];
     char challenge[8], ntlm_response[24];
     int i, ret_val;
+    int ntlm_unicode;
=20
     char ntlmv2_response[144];
     char userdomain_u[256];     /* for uppercase unicode username and do=
main */
@@ -211,7 +314,9 @@ ntlm_phase_3(const struct http_proxy_info *p, const c=
har *phase_2, struct gc_are
     size_t len;
=20
     char domain[128];
-    char username[128];
+    char domain_u[256];
+    char username[USER_PASS_LEN];
+    char username_u[USER_PASS_LEN*2];
     char *separator;
=20
     bool ntlmv2_enabled =3D (p->auth_method =3D=3D HTTP_AUTH_NTLM2);
@@ -244,7 +349,7 @@ ntlm_phase_3(const struct http_proxy_info *p, const c=
har *phase_2, struct gc_are
=20
=20
     /* fill 1st 16 bytes with md4 hash, disregard terminating null */
-    gen_md4_hash(pwbuf, unicodize(pwbuf, p->up.password) - 2, md4_hash);=

+    gen_md4_hash(pwbuf, utf8_to_utf16LE(pwbuf, sizeof(p->up.password) * =
2, (unsigned char *)p->up.password), md4_hash);
=20
     /* pad to 21 bytes */
     memset(md4_hash + MD4_DIGEST_LENGTH, 0, 5);
@@ -258,12 +363,23 @@ ntlm_phase_3(const struct http_proxy_info *p, const=
 char *phase_2, struct gc_are
     /* we can be sure that phase_2 is less than 128
      * therefore buf2 needs to be (3/4 * 128) */
=20
+    /* extract NegotiateFlags from bytes 20-23 */
+    ntlm_negotiate_flags =3D (buf2[0x14] & 0xff) | (buf2[0x15] & 0xff) <=
< 8 | (buf2[0x16] & 0xff) << 16 | (buf2[0x17] & 0xff) << 24;
+
+    ntlm_unicode =3D ntlm_negotiate_flags & NTLM_NEGOTIATE_UNICODE ? 1 :=
 0;
+
     /* extract the challenge from bytes 24-31 */
     for (i =3D 0; i<8; i++)
     {
         challenge[i] =3D buf2[i+24];
     }
=20
+    msg(M_DEBUG, "Received NTLM negotiate flags 0x%08x: %s encoding, %sN=
TLM2sec, %sTargetInfo - doing NTLMv%s",
+        ntlm_negotiate_flags, ntlm_unicode ? "Unicode" : "OEM",
+        ntlm_negotiate_flags & NTLM_NEGOTIATE_NTLM2_KEY ? "" : "no ",
+        ntlm_negotiate_flags & NTLM_NEGOTIATE_TARGET_INFO ? "" : "no ",
+        ntlmv2_enabled ? "2" : "1");
+
     if (ntlmv2_enabled)      /* Generate NTLMv2 response */
     {
         int tib_len;
@@ -278,8 +394,11 @@ ntlm_phase_3(const struct http_proxy_info *p, const =
char *phase_2, struct gc_are
         {
             msg(M_INFO, "Warning: Username or domain too long");
         }
-        unicodize(userdomain_u, userdomain);
-        gen_hmac_md5(userdomain_u, 2 * strlen(userdomain), md4_hash, MD5=
_DIGEST_LENGTH, ntlmv2_hash);
+        len =3D utf8_to_utf16LE(userdomain_u, sizeof(userdomain_u), user=
domain);
+        if (len >=3D 0)
+        {
+            gen_hmac_md5(userdomain_u, len, md4_hash, MD5_DIGEST_LENGTH,=
 ntlmv2_hash);
+        }
=20
         /* NTLMv2 Blob */
         memset(ntlmv2_blob, 0, 128);                        /* Clear blo=
b buffer */
@@ -291,9 +410,9 @@ ntlm_phase_3(const struct http_proxy_info *p, const c=
har *phase_2, struct gc_are
         ntlmv2_blob[0x18] =3D 0;                              /* Unknown=
, zero should work */
=20
         /* Add target information block to the blob */
-        if (( *((long *)&buf2[0x14]) & 0x00800000) =3D=3D 0x00800000)   =
       /* Check for Target Information block */
+        if (ntlm_negotiate_flags & NTLM_NEGOTIATE_TARGET_INFO)          =
   /* Check for Target Information block */
         {
-            tib_len =3D buf2[0x28];            /* Get Target Information=
 block size */
+            tib_len =3D buf2[0x28] & 0xff | (buf2[0x29] & 0xff) << 8;   =
           /* Get Target Information block size */
             if (tib_len > 96)
             {
                 tib_len =3D 96;
@@ -311,7 +430,7 @@ ntlm_phase_3(const struct http_proxy_info *p, const c=
har *phase_2, struct gc_are
         ntlmv2_blob[0x1c + tib_len] =3D 0;                    /* Unknown=
, zero works */
=20
         /* Get blob length */
-        ntlmv2_blob_size =3D 0x20 + tib_len;
+        ntlmv2_blob_size =3D 0x1c + tib_len;
=20
         /* Add challenge from message 2 */
         memcpy(&ntlmv2_response[8], challenge, 8);
@@ -345,18 +464,41 @@ ntlm_phase_3(const struct http_proxy_info *p, const=
 char *phase_2, struct gc_are
=20
     if (ntlmv2_enabled)      /* NTLMv2 response */
     {
-        add_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 16=
, phase3, &phase3_bufpos);
+        add_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 16=
, phase3, &phase3_bufpos, sizeof(phase3));
     }
     else       /* NTLM response */
     {
-        add_security_buffer(0x14, ntlm_response, 24, phase3, &phase3_buf=
pos);
+        add_security_buffer(0x14, ntlm_response, 24, phase3, &phase3_buf=
pos, sizeof(phase3));
+    }
+
+    /* Set username. */
+    if (ntlm_unicode)
+    {
+        len =3D utf8_to_utf16LE(username_u, sizeof(username_u), username=
);
+        if (len>=3D0)
+        {
+            add_security_buffer(0x24, username_u, len, phase3, &phase3_b=
ufpos, sizeof(phase3));
+        }
+    }
+    else
+    {
+        add_security_buffer(0x24, username, strlen(username), phase3, &p=
hase3_bufpos, sizeof(phase3));
     }
=20
-    /* username in ascii */
-    add_security_buffer(0x24, username, strlen(username), phase3, &phase=
3_bufpos);
=20
     /* Set domain. If <domain> is empty, default domain will be used (i.=
e. proxy's domain) */
-    add_security_buffer(0x1c, domain, strlen(domain), phase3, &phase3_bu=
fpos);
+    if (ntlm_unicode)
+    {
+        len =3D utf8_to_utf16LE(domain_u, sizeof(domain_u), domain);
+        if (len>=3D0)
+        {
+            add_security_buffer(0x1c, domain_u, len, phase3, &phase3_buf=
pos, sizeof(phase3));
+        }
+    }
+    else
+    {
+        add_security_buffer(0x1c, domain, strlen(domain), phase3, &phase=
3_bufpos, sizeof(phase3));
+    }
=20
=20
     /* other security buffers will be empty */
@@ -365,7 +507,7 @@ ntlm_phase_3(const struct http_proxy_info *p, const c=
har *phase_2, struct gc_are
     phase3[0x38] =3D phase3_bufpos;     /* no session key */
=20
     /* flags */
-    phase3[0x3c] =3D 0x02; /* negotiate oem */
+    phase3[0x3c] =3D ntlm_unicode ? 0x01 : 0x02; /* negotiate unicode/oe=
m */
     phase3[0x3d] =3D 0x02; /* negotiate ntlm */
=20
     return ((const char *)make_base64_string2((unsigned char *)phase3, p=
hase3_bufpos, gc));
--=20
2.7.4


--------------6D1F139762C9E89AF6C2E46A--

--B1k7kkVMM9vKdaSutx2Fo0PCKGRJQKd3G--

--nFICrHG6jdVq5knBHjJgOk4PkwP3N1jdL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYVr2EAAoJEJgCyj0AftKIGs4IANdDLdXVtJejcpQ8WTEXcTX8
+FvV5hW0n2wP2HHVbXGu6vG/P1TfPQZPo3XF/Y++6dHYbFHUj6ErVMs6eWrL3stk
2y8F9Bj8JeWnCjzPyZqUcPqedXHXqGuhfnQe8zRQaj2Osk8gqTOrmb/DyME43hgR
pQQDMjqDqy37QD92SAWkuSsN8nm7wp2SOomfTkO3qz1HndbL8OrAXk3jn4hvLSit
J3Ru1hJvnLR3nW2+0Ijv6WTp6Quh9bex36e7jhqq+jLvqPjTRVo/B/hUVrliNFlV
hV45aCDYZlKNbDCEbXkMY4ffQcK+S/IMcKRSmdFvGb+Bp0lqDtmdCehP/5hlaLo=
=K+e+
-----END PGP SIGNATURE-----

--nFICrHG6jdVq5knBHjJgOk4PkwP3N1jdL--

