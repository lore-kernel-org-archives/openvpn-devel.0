Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B163C79FA0
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 21:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=s+0Nw2gX7iZpU0gLoUxHq4LoJ+6RI9/VH7aLrNaiCKg=; b=IVjuEJaWvo/QXC
	0W8MIiiKxqpGDS2Opu50i5AdV8wOWBIXmb1mYeFGeN+FP46XZRMD6/arKePUy7nj/DzTE4nZzQ7p0
	Hq0zlZjMOI5mhBb1VQWt3UO3nBvU3ek9Kw93X3pkiQz9JXqnK0jopBVafCfrb8qQTLiNd/Xuyhveo
	8ZE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3gW8-0008QR-HX;
	Mon, 07 Sep 2026 21:04:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3gVp-0008Q8-GQ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 21:04:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GEJh6864DnjVen+sXJRRwaluiB8K7l4y8isitlipL9U=; b=MW85YLTcRZ6UsYqnasWkxo69zh
 J2cJ6hqwTwTRlRGRTvKgAeqvHGpmgelUvFFf1SKrnFe1rEhUk4gU4MFVsMWs2QCuSNSCGhUBUryiw
 StILz/ZT7mZfzdAmain5hRw8Nem5sMdVD6qzqfCMogk4ft3N/5YYGoJpqwHA77xwlsJw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GEJh6864DnjVen+sXJRRwaluiB8K7l4y8isitlipL9U=; b=i
 KTNbnQsNFNWvIycovhI/3APpB8DdtuuhTHc35LdQsgWEr49l/gnfVy6pjbmLFLTDtm5cCWsXpagkY
 lR6GMC80ioaJWiFbkcQ+DIQ6/20e+peV4elCwoJZ7j6wQwT0FSu8pF+jootErEbhe8jxAyPXz7dvf
 DiI3N0NUfYyY9EX4=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3gVg-00056a-5T for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 21:04:18 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49b8eeb3ff2so36998845e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 14:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788815046; x=1789419846; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GEJh6864DnjVen+sXJRRwaluiB8K7l4y8isitlipL9U=;
 b=U+ZZ/+uQR4mnJ8SvGsd0qKPURVxkGNfXYP2RtvAOlfvs2T9kuV0crIS8ZeE16J4Jk1
 OhDNzhiRq0kXvNKBg1dVKflEzcTA5YLH3M7hPUSa2CYENcxpgB17KNSGVJKitFojvSuA
 D5r5GI/M2gVOWFLv5L0/YaKO+EjV7Q3begfCbdmEte4msZzpYTwxExQMvY8/5M0QugZv
 Ll9aCxy7RvrZKTsAwyJlexf+TAdga1z8//QmY956ZVGxV6gLtd7fGKaaLYoMkBSBWxwi
 MooSF8SGFnmCOZTi4J2ErY59GR0UOzwvLnUEwUNdFneSJmtE0XsNSihDArPSaxlpKvrO
 X5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788815046; x=1789419846;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GEJh6864DnjVen+sXJRRwaluiB8K7l4y8isitlipL9U=;
 b=IH31OgLFuDzKXe3TOQuh9PbLQQlybx7ifVep3foyVbHAAKRoPotQ6Kdh/e6q/rmFpB
 HIDfnpXIsiiImQHocLpHDIPI2l2bisqn0RGL1T9zCzrR3+st7Pq9FnSMo114ul6dTDdW
 PmTB8B5PYoV6u4WwsLGBLchDF8D4T/eavASkERHBO7VcQuqPWN4hRgVjcxvTk3Jqh6hB
 EW9tzkKme33EpPZ9eyqeZ7Gja5Hu1TdUH92285KT4dIdfd4iIhgJZod1HH8ZiYzlOD+0
 b28otrQ17/SRIjjMakLvxdHRcNXDgWQ/68/2TZJcXzxB336SkXpIEQgDYbRX5Q4hrYJZ
 KBjw==
X-Gm-Message-State: AFuF++ld6FfKi6XigaFaTYm8dv0xRZIyM8TUtz16GG8vuL/RoAxNCu3r
 qAgq5TaKo3DfRrFE9eB47EInre7RhqqQcJ5wM665eCGmcfEc8BjsZNunjAqGU1W44/2FEs1Z0bj
 9HOCUm5SbB4l1ziKv2gSlsMtCA6oBkChzIWUdORn4VZxO87MltAto0IQbgZ+Q8we5Uzhw6DiW39
 +FJBzzyw==
X-Gm-Gg: AYBFou1nbsVxgIZCV9qG90btWriaXlZU76ccKgUdt33inKwHpgZoyqDlYgC5ZtqhvtK
 s+HTDzRtp7KoaGBnGYBTY0YzeZ1wk88NIH+N310U0kwDUkElF/bG/e1cJxgvNSUK4dNloajt/89
 XLt0pxtNZG5eOB0NDaBPg5nzQIysK02IACaWqW9Xu5kAyxiIuNPVnlBGEkD4jyQg7yEPLoWEQtO
 vh5IB3Y+b6EfFWTHLVsiSph8MhMR+a3I5iGuXLC2iO/6tXB6aIRslMnk+Er3gok0OwwxTtAqMnn
 BCZQVd03HlGUMkW9TIUAUvBk/p+Tl0bbiV7wtXaAOL4LU6dmEhC5QWKHoWO6lnvjBMDM94IOSxA
 jeqqT2HQrCSCZM7WsiSzDr87Qmai451McO1huG+5an6j+CFkyL/3JRw8fkHYtlN+fBf4sJ0IAyP
 0kYkfJhFy26DLQwBNVlj7iJek5HsFPh7rF8jOFkRlokcqs6eZwrqHJZ3ZyyzT84+tRsD+1Wwee1
 u/LG8hCWM4V5jjf7kbprVX9Y0ckBogR4r+VT+e5oB/V0tBJbef13F9wjPbYxYJiQEBwApwVwIRq
 gzQm/xxBwc18XLDlESKYmcaEzcqtmL5HkCefXhZMa6Ey6yb6oz0=
X-Received: by 2002:a05:600c:190b:b0:49c:fa21:e743 with SMTP id
 5b1f17b1804b1-49cfa21e92amr233732105e9.25.1788815045128; 
 Mon, 07 Sep 2026 14:04:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60bae6sm501248565e9.9.2026.09.07.14.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:04:04 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 21:04:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e
X-Gerrit-Change-Number: 1904
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1904?usp=email>
X-Gerrit-Commit: c3a39a4174522b5e37a428ef57c5f4c84fc52348
References: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODE1MDM1MDAwLkliNGFmNzYzOWNkZWJlODFlYmEwNWFiMDRlZmU2ZTg1ZTYzZGUwZjllQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aca163ef3211937bd00a5f5737ea029d756cb37f-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3gVg-00056a-5T
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: When
 extracting pointers from buffer, retain const
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4368254537160204289=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4368254537160204289==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ABMSwPG1PPs="; charset=UTF-8

--ABMSwPG1PPs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1904?usp=3Demail

to review the following change=2E


Chang=
e subject: buffer: When extracting pointers from buffer, retain const
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer: When ext=
racting pointers from buffer, retain const

Currently you can use BPTR and =
similar to implictly remove
const=2E That avoids some warnings that we shou=
ld get and
confuses tools like cppcheck into giving wrong suggestions=2E

S=
o make sure that by default we do not return a non-const
pointer if the buf=
fer is not const=2E Change all call sites
that threw warnings=2E

Change-Id=
: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e
Signed-off-by: Frank Lichtenhel=
d <frank@lichtenheld=2Ecom>
---
M src/openvpn/buffer=2Ec
M src/openvpn/buff=
er=2Eh
M src/openvpn/crypto_backend=2Eh
M src/openvpn/crypto_mbedtls=2Ec
M =
src/openvpn/crypto_mbedtls_legacy=2Ec
M src/openvpn/crypto_openssl=2Ec
M sr=
c/openvpn/forward=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/mroute=2Ec
M s=
rc/openvpn/proto=2Eh
M src/openvpn/ps=2Ec
M src/openvpn/push=2Ec
M src/open=
vpn/socket=2Ec
M src/openvpn/socket=2Eh
M src/openvpn/ssl_pkt=2Ec
M src/ope=
nvpn/ssl_verify=2Ec
M src/openvpn/tls_crypt=2Ec
M src/openvpn/tun=2Eh
M src=
/openvpn/vlan=2Ec
M tests/unit_tests/openvpn/test_buffer=2Ec
M tests/unit_t=
ests/openvpn/test_tls_crypt=2Ec
21 files changed, 154 insertions(+), 89 del=
etions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/04/1904/1

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2E=
c
index 5d00415=2E=2E8a3136a 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/=
openvpn/buffer=2Ec
@@ -109,7 +109,7 @@
 #endif
     ret=2Edata =3D (uint8_t=
 *)malloc(buf->capacity);
     check_malloc_return(ret=2Edata);
-    memcpy=
(BPTR(&ret), BPTR(buf), BLENZ(buf));
+    memcpy(BPTR(&ret), CBPTR(buf), BL=
ENZ(buf));
     return ret;
 }
 
@@ -162,7 +162,7 @@
     {
         return=
 false;
     }
-    return buf_write(dest, BPTR(src), BLENZ(src));
+    ret=
urn buf_write(dest, CBPTR(src), BLENZ(src));
 }
 
 void
@@ -293,7 +293,7 @@=

         return false;
     }
 
-    const ssize_t size =3D write(fd, BPTR=
(buf), (unsigned int)BLEN(buf));
+    const ssize_t size =3D write(fd, CBPT=
R(buf), (unsigned int)BLEN(buf));
     if (size !=3D BLEN(buf))
     {
    =
     msg(M_ERRNO, "Write error on file '%s'", filename);
@@ -732,7 +732,7 @=
@
     {
         return false;
     }
-    return memcmp(BPTR(src), match,=
 size) =3D=3D 0;
+    return memcmp(CBPTR(src), match, size) =3D=3D 0;
 }
 =

 bool
@@ -1035,13 +1035,13 @@
 }
 
 bool
-string_check_buf(struct buffer *=
buf, const unsigned int inclusive, const unsigned int exclusive)
+string_ch=
eck_buf(const struct buffer *buf, const unsigned int inclusive, const unsig=
ned int exclusive)
 {
     ASSERT(buf);
 
     for (int i =3D 0; i < BLEN(b=
uf); i++)
     {
-        char c =3D BSTR(buf)[i];
+        char c =3D CBST=
R(buf)[i];
 
         if (!char_inc_exc(c, inclusive, exclusive))
         =
{
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh
index 0a02e9=
4=2E=2E22a8b74 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/openvpn/buffer=
=2Eh
@@ -136,21 +136,29 @@
 
 
 /** Return a pointer to the start of the bu=
ffer content=2E @see buf_bptr() */
-#define BPTR(buf)  (buf_bptr(buf))
+#de=
fine BPTR(buf)   (buf_bptr(buf))
+/** Return a const pointer to the start o=
f the buffer content=2E @see buf_cbptr() */
+#define CBPTR(buf)  (buf_cbptr=
(buf))
 /** Return a pointer one past the end of the buffer content=2E @see=
 buf_bend() */
-#define BEND(buf)  (buf_bend(buf))
+#define BEND(buf)   (bu=
f_bend(buf))
+/** Return a const pointer one past the end of the buffer con=
tent=2E @see buf_cbend() */
+#define CBEND(buf)  (buf_cbend(buf))
 /** Retu=
rn a pointer to the last byte of the buffer content, or NULL if empty=2E @s=
ee buf_blast() */
-#define BLAST(buf) (buf_blast(buf))
+#define BLAST(buf) =
 (buf_blast(buf))
+/** Return a const pointer to the last byte of the buffe=
r content, or NULL if empty=2E @see buf_cblast() */
+#define CBLAST(buf) (b=
uf_cblast(buf))
 /** Return the length of the buffer content in bytes=2E @s=
ee buf_len() */
-#define BLEN(buf)  (buf_len(buf))
+#define BLEN(buf)   (bu=
f_len(buf))
 /** Return the length of the buffer content as a \c size_t=2E =
@see buf_len() */
-#define BLENZ(buf) ((size_t)buf_len(buf))
+#define BLENZ=
(buf)  ((size_t)buf_len(buf))
 /** Return true iff the buffer is defined (h=
as non-NULL data pointer)=2E @see buf_defined() */
-#define BDEF(buf)  (buf=
_defined(buf))
+#define BDEF(buf)   (buf_defined(buf))
 /** Return the buff=
er content pointer cast to \c char *=2E @see buf_str() */
-#define BSTR(buf=
)  (buf_str(buf))
+#define BSTR(buf)   (buf_str(buf))
+/** Return the buffe=
r content pointer cast to \c const char *=2E @see buf_cstr() */
+#define CB=
STR(buf)  (buf_cstr(buf))
 /** Return the number of bytes available for app=
ending to the buffer=2E @see buf_forward_capacity() */
-#define BCAP(buf)  =
(buf_forward_capacity(buf))
+#define BCAP(buf)   (buf_forward_capacity(buf)=
)
 
 /**
  * Zeroise and reset a buffer=2E
@@ -407,15 +415,15 @@
 }
 
 /**
=
- * Return a pointer to the start of the buffer content=2E
+ * Return a con=
st pointer to the start of the buffer content=2E
  *
  * @param buf   The b=
uffer to query=2E
  *
  * @return Pointer to \c buf->data + \c buf->offset,=
 or NULL if \c buf is
  *         not valid=2E
  */
-static inline uint8_t =
*
-buf_bptr(const struct buffer *buf)
+static inline const uint8_t *
+buf_c=
bptr(const struct buffer *buf)
 {
     if (buf_valid(buf))
     {
@@ -428,6=
 +436,20 @@
 }
 
 /**
+ * Return a pointer to the start of the buffer conte=
nt=2E
+ *
+ * @param buf   The buffer to query=2E
+ *
+ * @return Pointer t=
o \c buf->data + \c buf->offset, or NULL if \c buf is
+ *         not valid=
=2E
+ */
+static inline uint8_t *
+buf_bptr(struct buffer *buf)
+{
+    ret=
urn (uint8_t *)buf_cbptr(buf);
+}
+
+/**
  * Return the length of the buffe=
r content=2E
  *
  * @param buf   The buffer to query=2E
@@ -455,12 +477,46=
 @@
  * @return Pointer to the byte immediately after the last content byte=
=2E
  */
 static inline uint8_t *
-buf_bend(const struct buffer *buf)
+buf_=
bend(struct buffer *buf)
 {
     return buf_bptr(buf) + buf_len(buf);
 }
 
=
 /**
+ * Return a const pointer one past the end of the buffer content=2E
+=
 *
+ * @param buf   The buffer to query=2E
+ *
+ * @return Pointer to the b=
yte immediately after the last content byte=2E
+ */
+static inline const ui=
nt8_t *
+buf_cbend(const struct buffer *buf)
+{
+    return buf_cbptr(buf) =
+ buf_len(buf);
+}
+
+/**
+ * Return a const pointer to the last byte of th=
e buffer content=2E
+ *
+ * @param buf   The buffer to query=2E
+ *
+ * @re=
turn Pointer to the last byte, or NULL if the buffer is empty or
+ *       =
  invalid=2E
+ */
+static inline const uint8_t *
+buf_cblast(const struct b=
uffer *buf)
+{
+    if (buf_len(buf) > 0)
+    {
+        return buf_cbptr(=
buf) + buf_len(buf) - 1;
+    }
+    else
+    {
+        return NULL;
+   =
 }
+}
+
+/**
  * Return a pointer to the last byte of the buffer content=2E=

  *
  * @param buf   The buffer to query=2E
@@ -469,16 +525,9 @@
  *      =
   invalid=2E
  */
 static inline uint8_t *
-buf_blast(const struct buffer =
*buf)
+buf_blast(struct buffer *buf)
 {
-    if (buf_len(buf) > 0)
-    {
-=
        return buf_bptr(buf) + buf_len(buf) - 1;
-    }
-    else
-    {
- =
       return NULL;
-    }
+    return (uint8_t *)buf_cblast(buf);
 }
 
 /*=
*
@@ -518,12 +567,25 @@
  * @return The content pointer as a \c char *, or =
NULL if \c buf is invalid=2E
  */
 static inline char *
-buf_str(const stru=
ct buffer *buf)
+buf_str(struct buffer *buf)
 {
     return (char *)buf_bpt=
r(buf);
 }
 
 /**
+ * Return the buffer content pointer cast to \c const ch=
ar *=2E
+ *
+ * @param buf   The buffer to query=2E
+ *
+ * @return The con=
tent pointer as a \c const char *, or NULL if \c buf is invalid=2E
+ */
+st=
atic inline const char *
+buf_cstr(const struct buffer *buf)
+{
+    return=
 (const char *)buf_cbptr(buf);
+}
+
+/**
  * Reset a buffer to an undefined=
 (unallocated) state=2E
  *
  * Sets all fields to zero/NULL without freein=
g any memory=2E  Use \c free_buf()
@@ -1300,7 +1362,7 @@
 static inline boo=
l
 buf_copy(struct buffer *dest, const struct buffer *src)
 {
-    return b=
uf_write(dest, BPTR(src), BLENZ(src));
+    return buf_write(dest, CBPTR(sr=
c), BLENZ(src));
 }
 
 /**
@@ -1427,14 +1489,14 @@
  *         is empty=2E
=
  */
 static inline int
-buf_peek_u8(struct buffer *buf)
+buf_peek_u8(const=
 struct buffer *buf)
 {
     int ret;
     if (BLEN(buf) < 1)
     {
      =
   return -1;
     }
-    ret =3D *BPTR(buf);
+    ret =3D *CBPTR(buf);
   =
  return ret;
 }
 
@@ -1547,7 +1609,7 @@
 static inline bool
 buf_equal(con=
st struct buffer *a, const struct buffer *b)
 {
-    return BLEN(a) =3D=3D =
BLEN(b) && 0 =3D=3D memcmp(BPTR(a), BPTR(b), BLENZ(a));
+    return BLEN(a)=
 =3D=3D BLEN(b) && 0 =3D=3D memcmp(CBPTR(a), CBPTR(b), BLENZ(a));
 }
 
 /**=

@@ -1561,7 +1623,7 @@
     {
         return false;
     }
-    return mem=
cmp(BPTR(src), match, size) =3D=3D 0;
+    return memcmp(CBPTR(src), match,=
 size) =3D=3D 0;
 }
 
 /**
@@ -1575,7 +1637,7 @@
     {
         return fal=
se;
     }
-    return memcmp(BPTR(src), match, size) =3D=3D 0;
+    return=
 memcmp(CBPTR(src), match, size) =3D=3D 0;
 }
 
 /**
@@ -1720,7 +1782,7 @@
=
  * @param exclusive Character classes that are not allowed even if they ar=
e also in inclusive=2E
  * @return True if the string consists only of allo=
wed characters, false otherwise=2E
  */
-bool string_check_buf(struct buffe=
r *buf, const unsigned int inclusive,
+bool string_check_buf(const struct b=
uffer *buf, const unsigned int inclusive,
                       const unsi=
gned int exclusive);
 
 /**
diff --git a/src/openvpn/crypto_backend=2Eh b/s=
rc/openvpn/crypto_backend=2Eh
index 17085d6=2E=2E7ef6ac4 100644
--- a/src/o=
penvpn/crypto_backend=2Eh
+++ b/src/openvpn/crypto_backend=2Eh
@@ -445,7 +4=
45,7 @@
  *
  * @return              \c 0 on failure, \c 1 on success=2E
  =
*/
-int cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, ui=
nt8_t *src, int src_len);
+int cipher_ctx_update(cipher_ctx_t *ctx, uint8_t=
 *dst, int *dst_len, const uint8_t *src, int src_len);
 
 /**
  * Pads the =
final cipher block using PKCS padding, and output to the destination
diff -=
-git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec
inde=
x 6662def=2E=2E85cc545 100644
--- a/src/openvpn/crypto_mbedtls=2Ec
+++ b/sr=
c/openvpn/crypto_mbedtls=2Ec
@@ -512,7 +512,7 @@
 }
 
 int
-cipher_ctx_upda=
te(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, uint8_t *src, int src_len=
)
+cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, const u=
int8_t *src, int src_len)
 {
     if (src_len < 0)
     {
diff --git a/src/=
openvpn/crypto_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_legacy=2Ec
i=
ndex 9e47c26=2E=2Ebbd012f6 100644
--- a/src/openvpn/crypto_mbedtls_legacy=
=2Ec
+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec
@@ -249,7 +249,7 @@
 
    =
 size_t out_len =3D 0;
     if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL
-      =
  !=3D mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(src), NULL,=
 0, &out_len))
+        !=3D mbedtls_pem_write_buffer(header, footer, CBPTR=
(src), BLEN(src), NULL, 0, &out_len))
     {
         return false;
     }
=
@@ -257,7 +257,7 @@
     /* We set the size buf to out_len-1 to NOT include=
 the 0 byte that
      * mbedtls_pem_write_buffer in its length calculation=
 */
     *dst =3D alloc_buf_gc(out_len, gc);
-    if (!mbed_ok(mbedtls_pem_=
write_buffer(header, footer, BPTR(src), BLEN(src), BPTR(dst),
+    if (!mbe=
d_ok(mbedtls_pem_write_buffer(header, footer, CBPTR(src), BLEN(src), BPTR(d=
st),
                                           BCAP(dst), &out_len))
     =
    || !buf_inc_len(dst, out_len - 1))
     {
@@ -684,7 +684,7 @@
 }
 
 int=

-cipher_ctx_update(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_l=
en, uint8_t *src,
+cipher_ctx_update(mbedtls_cipher_context_t *ctx, uint8_t=
 *dst, int *dst_len, const uint8_t *src,
                   int src_len)
 {=

     size_t s_dst_len =3D *dst_len;
diff --git a/src/openvpn/crypto_openss=
l=2Ec b/src/openvpn/crypto_openssl=2Ec
index 2019280=2E=2E29c5fa6 100644
--=
- a/src/openvpn/crypto_openssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ =
-465,7 +465,7 @@
 {
     bool ret =3D false;
     BIO *bio =3D BIO_new(BIO_=
s_mem());
-    if (!bio || !PEM_write_bio(bio, name, "", BPTR(src), BLEN(sr=
c)))
+    if (!bio || !PEM_write_bio(bio, name, "", CBPTR(src), BLEN(src)))=

     {
         ret =3D false;
         goto cleanup;
@@ -492,7 +492,7 @@
=
 {
     bool ret =3D false;
 
-    BIO *bio =3D BIO_new_mem_buf((char *)BPT=
R(src), BLEN(src));
+    BIO *bio =3D BIO_new_mem_buf(CBPTR(src), BLEN(src)=
);
     if (!bio)
     {
         crypto_msg(M_FATAL, "Cannot open memory B=
IO for PEM decode");
@@ -941,7 +941,7 @@
 }
 
 int
-cipher_ctx_update(EVP_C=
IPHER_CTX *ctx, uint8_t *dst, int *dst_len, uint8_t *src, int src_len)
+cip=
her_ctx_update(EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len, const uint8=
_t *src, int src_len)
 {
     if (!EVP_CipherUpdate(ctx, dst, dst_len, src,=
 src_len))
     {
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forwar=
d=2Ec
index 2ade321=2E=2Ead43d40 100644
--- a/src/openvpn/forward=2Ec
+++ b=
/src/openvpn/forward=2Ec
@@ -271,7 +271,7 @@
     }
     else
     {
-     =
   msg(D_PUSH_ERRORS, "WARNING: Received unknown control message: %s", BSTR=
(buf));
+        msg(D_PUSH_ERRORS, "WARNING: Received unknown control mess=
age: %s", CBSTR(buf));
     }
 }
 
@@ -1646,7 +1646,7 @@
             retur=
n;
         }
 
-        const struct openvpn_ethhdr *orig_ethhdr =3D (stru=
ct openvpn_ethhdr *)BPTR(buf);
+        const struct openvpn_ethhdr *orig_e=
thhdr =3D (const struct openvpn_ethhdr *)CBPTR(buf);
 
         /* Copy fra=
metype and reverse source/destination for the response */
         struct o=
penvpn_ethhdr ethhdr;
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/man=
age=2Ec
index 310d2e1=2E=2E7128196 100644
--- a/src/openvpn/manage=2Ec
+++ =
b/src/openvpn/manage=2Ec
@@ -2512,24 +2512,23 @@
 {
     const int size_hin=
t =3D 1024;
     ssize_t sent =3D 0;
-    const struct buffer *buf;
 
     =
buffer_list_aggregate(man->connection=2Eout, size_hint);
-    buf =3D buffe=
r_list_peek(man->connection=2Eout);
+    const struct buffer *buf =3D buffe=
r_list_peek(man->connection=2Eout);
     if (buf && BLEN(buf))
     {
     =
    const int len =3D min_int(size_hint, BLEN(buf));
 #ifdef TARGET_ANDROID=

         if (man->connection=2Efdtosend > 0)
         {
-            sent =
=3D man_send_with_fd(man->connection=2Esd_cli, BPTR(buf), len, MSG_NOSIGNAL=
,
+            sent =3D man_send_with_fd(man->connection=2Esd_cli, CBPTR(bu=
f), len, MSG_NOSIGNAL,
                                     man->connection=
=2Efdtosend);
             man->connection=2Efdtosend =3D -1;
         }
  =
       else
 #endif
         {
-            sent =3D send(man->connection=
=2Esd_cli, (const void *)BPTR(buf), len, MSG_NOSIGNAL);
+            sent =
=3D send(man->connection=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);
        =
 }
         if (sent >=3D 0)
         {
diff --git a/src/openvpn/mroute=2Ec=
 b/src/openvpn/mroute=2Ec
index edf8239=2E=2E39fa482 100644
--- a/src/openv=
pn/mroute=2Ec
+++ b/src/openvpn/mroute=2Ec
@@ -150,12 +150,12 @@
     unsig=
ned int ret =3D 0;
     if (BLEN(buf) >=3D 1)
     {
-        switch (OPENV=
PN_IPH_GET_VER(*BPTR(buf)))
+        switch (OPENVPN_IPH_GET_VER(*CBPTR(buf=
)))
         {
             case 4:
                 if (BLENZ(buf) >=3D si=
zeof(struct openvpn_iphdr))
                 {
-                    const s=
truct openvpn_iphdr *ip =3D (const struct openvpn_iphdr *)BPTR(buf);
+     =
               const struct openvpn_iphdr *ip =3D (const struct openvpn_iph=
dr *)CBPTR(buf);
 
                     mroute_get_in_addr_t(src, ip->saddr=
);
                     mroute_get_in_addr_t(dest, ip->daddr);
@@ -179,7 +1=
79,7 @@
             case 6:
                 if (BLENZ(buf) >=3D sizeof(st=
ruct openvpn_ipv6hdr))
                 {
-                    const struct=
 openvpn_ipv6hdr *ipv6 =3D (const struct openvpn_ipv6hdr *)BPTR(buf);
+    =
                const struct openvpn_ipv6hdr *ipv6 =3D (const struct openvp=
n_ipv6hdr *)CBPTR(buf);
 #if 0 /* very basic debug */
                     =
struct gc_arena gc =3D gc_new();
                     msg( M_INFO, "IPv6 pa=
cket! src=3D%s, dst=3D%s",
@@ -202,7 +202,7 @@
 
             default:
    =
             msg(M_WARN, "IP packet with unknown IP version=3D%d seen",
-  =
                  OPENVPN_IPH_GET_VER(*BPTR(buf)));
+                    OP=
ENVPN_IPH_GET_VER(*CBPTR(buf)));
         }
     }
     return ret;
@@ -226=
,7 +226,7 @@
     unsigned int ret =3D 0;
     if (BLEN(buf) >=3D (int)size=
of(struct openvpn_ethhdr))
     {
-        const struct openvpn_ethhdr *eth=
 =3D (const struct openvpn_ethhdr *)BPTR(buf);
+        const struct openvp=
n_ethhdr *eth =3D (const struct openvpn_ethhdr *)CBPTR(buf);
         if (s=
rc)
         {
             mroute_copy_ether_to_addr(src, eth->source, vid=
);
diff --git a/src/openvpn/proto=2Eh b/src/openvpn/proto=2Eh
index 3570582=
=2E=2E9bb0866 100644
--- a/src/openvpn/proto=2Eh
+++ b/src/openvpn/proto=2E=
h
@@ -258,7 +258,7 @@
         *ip_hdr_offset =3D 0;
         if (likely(BL=
EN(buf) >=3D (int)sizeof(struct openvpn_iphdr)))
         {
-            ip=
_ver =3D OPENVPN_IPH_GET_VER(*BPTR(buf));
+            ip_ver =3D OPENVPN_I=
PH_GET_VER(*CBPTR(buf));
         }
     }
     else if (tunnel_type =3D=3D=
 DEV_TYPE_TAP)
@@ -267,7 +267,7 @@
         /* for tap get ip version from =
eth header */
         if (likely(BLEN(buf) >=3D *ip_hdr_offset))
         =
{
-            const struct openvpn_ethhdr *eh =3D (const struct openvpn_et=
hhdr *)BPTR(buf);
+            const struct openvpn_ethhdr *eh =3D (const s=
truct openvpn_ethhdr *)CBPTR(buf);
             uint16_t proto =3D ntohs(eh=
->proto);
             if (proto =3D=3D OPENVPN_ETH_P_IPV6)
             {
=
diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index be91a99=2E=2E08c=
2673 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -208,7 +20=
8,9 @@
 
         if (head)
         {
-            iov[1]=2Eiov_base =3D B=
PTR(head);
+            /* sendmsg takes a const msghdr, but we can't const=
ruct that here
+               directly, so cast */
+            iov[1]=2Ei=
ov_base =3D (char *)CBPTR(head);
             iov[1]=2Eiov_len =3D BLENZ(he=
ad);
             mesg=2Emsg_iovlen =3D 2;
         }
@@ -964,7 +966,7 @@
 =
bool
 is_openvpn_protocol(const struct buffer *buf)
 {
-    const unsigned =
char *p =3D (const unsigned char *)BSTR(buf);
+    const unsigned char *p =
=3D (const unsigned char *)CBSTR(buf);
     const int len =3D BLEN(buf);
  =
   if (len >=3D 3)
     {
diff --git a/src/openvpn/push=2Ec b/src/openvpn/p=
ush=2Ec
index da2bb9f=2E=2E761a59e 100644
--- a/src/openvpn/push=2Ec
+++ b/=
src/openvpn/push=2Ec
@@ -47,7 +47,7 @@
 void
 receive_auth_failed(struct co=
ntext *c, const struct buffer *buffer)
 {
-    msg(M_VERB0, "AUTH: Received=
 control message: %s", BSTR(buffer));
+    msg(M_VERB0, "AUTH: Received con=
trol message: %s", CBSTR(buffer));
     c->options=2Eno_advance =3D true;
 =

     if (!c->options=2Epull)
@@ -64,7 +64,7 @@
     const char *reason =3D=
 NULL;
     if (authfail_extended && BLEN(&buf))
     {
-        reason =3D=
 BSTR(&buf);
+        reason =3D CBSTR(&buf);
     }
 
     if (authfail_ex=
tended && buf_string_match_head_str(&buf, "TEMP"))
@@ -116,7 +116,7 @@
    =
  */
     if (authfail_extended && buf_string_match_head_str(&buf, "CRV1:")=
 && BLEN(&buf))
     {
-        ssl_put_auth_challenge(BSTR(&buf));
+      =
  ssl_put_auth_challenge(CBSTR(&buf));
     }
 #endif /* ifdef ENABLE_MANAG=
EMENT */
 }
@@ -508,7 +508,7 @@
     uint64_t option_types_found =3D 0;
 
 =
    msg(D_PUSH, "PUSH: Received control message: '%s'",
-        sanitize_c=
ontrol_message(BSTR(buffer), &gc));
+        sanitize_control_message(CBSTR=
(buffer), &gc));
 
     int status =3D process_incoming_push_msg(c, buffer,=
 c->options=2Epull, pull_permission_mask(c),
                              =
              &option_types_found);
@@ -516,7 +516,7 @@
     if (status =3D=
=3D PUSH_MSG_ERROR)
     {
         msg(D_PUSH_ERRORS, "WARNING: Received b=
ad push/pull message: %s",
-            sanitize_control_message(BSTR(buffe=
r), &gc));
+            sanitize_control_message(CBSTR(buffer), &gc));
    =
 }
     else if (status =3D=3D PUSH_MSG_REPLY || status =3D=3D PUSH_MSG_UPD=
ATE
              || status =3D=3D PUSH_MSG_CONTINUATION)
diff --git a/src/=
openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 7c6217a=2E=2E7f39268 1006=
44
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -2446,7 +24=
46,9 @@
     struct cmsghdr *cmsg;
     uint8_t pktinfo_buf[PKTINFO_BUF_SIZ=
E];
 
-    iov=2Eiov_base =3D BPTR(buf);
+    /* sendmsg takes a const msgh=
dr, but we can't construct that here
+       directly, so cast */
+    iov=
=2Eiov_base =3D (char *)CBPTR(buf);
     iov=2Eiov_len =3D BLENZ(buf);
    =
 mesg=2Emsg_iov =3D &iov;
     mesg=2Emsg_iovlen =3D 1;
diff --git a/src/op=
envpn/socket=2Eh b/src/openvpn/socket=2Eh
index 89465bc=2E=2Ec6a29f4 100644=

--- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -709,14 +709,=
14 @@
     }
     else
 #endif
-        return sendto(sock->sd, BPTR(buf), =
BLENZ(buf), 0, (struct sockaddr *)&to->dest=2Eaddr=2Esa,
+        return se=
ndto(sock->sd, CBPTR(buf), BLENZ(buf), 0, (struct sockaddr *)&to->dest=2Ead=
dr=2Esa,
                       (socklen_t)af_addr_size(to->dest=2Eaddr=2Es=
a=2Esa_family));
 }
 
 static inline ssize_t
 link_socket_write_tcp_posix(s=
truct link_socket *sock, struct buffer *buf)
 {
-    return send(sock->sd, =
BPTR(buf), BLENZ(buf), MSG_NOSIGNAL);
+    return send(sock->sd, CBPTR(buf)=
, BLENZ(buf), MSG_NOSIGNAL);
 }
 
 #endif /* ifdef _WIN32 */
@@ -761,7 +761=
,7 @@
 {
     if (sock && ipbuf)
     {
-        const struct openvpn_iphdr=
 *iph =3D (struct openvpn_iphdr *)BPTR(ipbuf);
+        const struct openvp=
n_iphdr *iph =3D (const struct openvpn_iphdr *)CBPTR(ipbuf);
         sock-=
>ptos =3D iph->tos;
         sock->ptos_defined =3D true;
     }
diff --git=
 a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index 6a6d9f9=2E=2E90b=
2aec 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ =
-305,7 +305,7 @@
     }
 
     /* get opcode and key ID */
-    uint8_t pkt=
_firstbyte =3D *BPTR(buf);
+    uint8_t pkt_firstbyte =3D *CBPTR(buf);
    =
 int op =3D pkt_firstbyte >> P_OPCODE_SHIFT;
     int key_id =3D pkt_firstb=
yte & P_KEY_ID_MASK;
 
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvp=
n/ssl_verify=2Ec
index 063fa5d=2E=2E3653eb4 100644
--- a/src/openvpn/ssl_ve=
rify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -207,7 +207,7 @@
 
         st=
ruct cert_hash *ch =3D session->cert_hash_set->ch[error_depth];
         AS=
SERT(sizeof(ch->sha256_hash) =3D=3D BLEN(cert_hash));
-        memcpy(ch->s=
ha256_hash, BPTR(cert_hash), sizeof(ch->sha256_hash));
+        memcpy(ch->=
sha256_hash, CBPTR(cert_hash), sizeof(ch->sha256_hash));
     }
 }
 
diff -=
-git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index 47f5ac5=
=2E=2E23c7975 100644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_=
crypt=2Ec
@@ -148,7 +148,7 @@
 
     gc_init(&gc);
 
-    dmsg(D_PACKET_CON=
TENT, "TLS-CRYPT WRAP FROM: %s", format_hex(BPTR(src), BLEN(src), 80, &gc))=
;
+    dmsg(D_PACKET_CONTENT, "TLS-CRYPT WRAP FROM: %s", format_hex(CBPTR(s=
rc), BLEN(src), 80, &gc));
 
     /* Get packet ID */
     if (!packet_id_w=
rite(&opt->packet_id=2Esend, dst, true, false))
@@ -157,7 +157,7 @@
       =
  goto err;
     }
 
-    dmsg(D_PACKET_CONTENT, "TLS-CRYPT WRAP AD: %s", f=
ormat_hex(BPTR(dst), BLEN(dst), 0, &gc));
+    dmsg(D_PACKET_CONTENT, "TLS-=
CRYPT WRAP AD: %s", format_hex(CBPTR(dst), BLEN(dst), 0, &gc));
 
     /* B=
uffer overflow check */
     if (!buf_safe(dst, BLENZ(src) + TLS_CRYPT_BLOC=
K_SIZE + TLS_CRYPT_TAG_SIZE))
@@ -173,8 +173,8 @@
     {
         uint8_t *=
tag =3D NULL;
         hmac_ctx_reset(ctx->hmac);
-        hmac_ctx_update(=
ctx->hmac, BPTR(dst), BLEN(dst));
-        hmac_ctx_update(ctx->hmac, BPTR(=
src), BLEN(src));
+        hmac_ctx_update(ctx->hmac, CBPTR(dst), BLEN(dst)=
);
+        hmac_ctx_update(ctx->hmac, CBPTR(src), BLEN(src));
 
         A=
SSERT(tag =3D buf_write_alloc(dst, TLS_CRYPT_TAG_SIZE));
         hmac_ctx_=
final(ctx->hmac, tag);
@@ -189,7 +189,7 @@
     /* Encrypt src */
     {
  =
       int outlen =3D 0;
-        ASSERT(cipher_ctx_update(ctx->cipher, BEN=
D(dst), &outlen, BPTR(src), BLEN(src)));
+        ASSERT(cipher_ctx_update(=
ctx->cipher, BEND(dst), &outlen, CBPTR(src), BLEN(src)));
         ASSERT(b=
uf_inc_len(dst, outlen));
         ASSERT(cipher_ctx_final(ctx->cipher, BPT=
R(dst), &outlen));
         ASSERT(buf_inc_len(dst, outlen));
@@ -220,7 +22=
0,7 @@
     ASSERT(ctx->cipher);
     ASSERT(packet_id_initialized(&opt->pa=
cket_id) || (opt->flags & CO_IGNORE_PACKET_ID));
 
-    dmsg(D_PACKET_CONTE=
NT, "TLS-CRYPT UNWRAP FROM: %s", format_hex(BPTR(src), BLEN(src), 80, &gc))=
;
+    dmsg(D_PACKET_CONTENT, "TLS-CRYPT UNWRAP FROM: %s", format_hex(CBPTR=
(src), BLEN(src), 80, &gc));
 
     if (BLENZ(src) < TLS_CRYPT_OFF_CT)
    =
 {
@@ -237,11 +237,11 @@
             CRYPT_ERROR("potential buffer overflo=
w");
         }
 
-        if (!cipher_ctx_reset(ctx->cipher, BPTR(src) + T=
LS_CRYPT_OFF_TAG))
+        if (!cipher_ctx_reset(ctx->cipher, CBPTR(src) +=
 TLS_CRYPT_OFF_TAG))
         {
             CRYPT_ERROR("cipher reset fail=
ed");
         }
-        if (!cipher_ctx_update(ctx->cipher, BPTR(dst), &o=
utlen, BPTR(src) + TLS_CRYPT_OFF_CT,
+        if (!cipher_ctx_update(ctx->c=
ipher, BPTR(dst), &outlen, CBPTR(src) + TLS_CRYPT_OFF_CT,
                 =
               BLEN(src) - (int)TLS_CRYPT_OFF_CT))
         {
             =
CRYPT_ERROR("cipher update failed");
@@ -256,17 +256,17 @@
 
     /* Check =
authentication */
     {
-        const uint8_t *tag =3D BPTR(src) + TLS_CR=
YPT_OFF_TAG;
+        const uint8_t *tag =3D CBPTR(src) + TLS_CRYPT_OFF_TAG=
;
         uint8_t tag_check[TLS_CRYPT_TAG_SIZE] =3D { 0 };
 
         dmsg=
(D_PACKET_CONTENT, "TLS-CRYPT UNWRAP AD: %s",
-             format_hex(BPTR=
(src), TLS_CRYPT_OFF_TAG, 0, &gc));
+             format_hex(CBPTR(src), TL=
S_CRYPT_OFF_TAG, 0, &gc));
         dmsg(D_PACKET_CONTENT, "TLS-CRYPT UNWRA=
P TO: %s",
-             format_hex(BPTR(dst), BLEN(dst), 80, &gc));
+     =
        format_hex(CBPTR(dst), BLEN(dst), 80, &gc));
 
         hmac_ctx_re=
set(ctx->hmac);
-        hmac_ctx_update(ctx->hmac, BPTR(src), TLS_CRYPT_OF=
F_TAG);
-        hmac_ctx_update(ctx->hmac, BPTR(dst), BLEN(dst));
+       =
 hmac_ctx_update(ctx->hmac, CBPTR(src), TLS_CRYPT_OFF_TAG);
+        hmac_c=
tx_update(ctx->hmac, CBPTR(dst), BLEN(dst));
         hmac_ctx_final(ctx->h=
mac, tag_check);
 
         if (memcmp_constant_time(tag, tag_check, sizeof=
(tag_check)))
@@ -384,7 +384,7 @@
     hmac_ctx_reset(hmac_ctx);
     hmac_=
ctx_update(hmac_ctx, (void *)&net_len, sizeof(net_len));
     hmac_ctx_upda=
te(hmac_ctx, (void *)src_key->keys, sizeof(src_key->keys));
-    hmac_ctx_u=
pdate(hmac_ctx, BPTR(src_metadata), BLEN(src_metadata));
+    hmac_ctx_upda=
te(hmac_ctx, CBPTR(src_metadata), BLEN(src_metadata));
     hmac_ctx_final(=
hmac_ctx, tag);
 
     dmsg(D_CRYPTO_DEBUG, "TLS-CRYPT WRAP TAG: %s", forma=
t_hex(tag, TLS_CRYPT_TAG_SIZE, 0, gc));
@@ -405,7 +405,7 @@
     ASSERT(cip=
her_ctx_update(cipher_ctx, BEND(&work), &outlen, (void *)src_key->keys,
   =
                           sizeof(src_key->keys)));
     ASSERT(buf_inc_len=
(&work, outlen));
-    ASSERT(cipher_ctx_update(cipher_ctx, BEND(&work), &o=
utlen, BPTR(src_metadata),
+    ASSERT(cipher_ctx_update(cipher_ctx, BEND(&=
work), &outlen, CBPTR(src_metadata),
                              BLEN(src=
_metadata)));
     ASSERT(buf_inc_len(&work, outlen));
     ASSERT(cipher_c=
tx_final(cipher_ctx, BEND(&work), &outlen));
@@ -529,7 +529,7 @@
         r=
eturn false;
     }
 
-    const uint8_t *metadata =3D buf_bptr(tls_crypt_v=
2_metadata);
+    const uint8_t *metadata =3D CBPTR(tls_crypt_v2_metadata);=

     if (*metadata !=3D TLS_CRYPT_METADATA_TYPE_TIMESTAMP)
     {
        =
 msg(M_WARN, "ERROR: Client key does not have a timestamp=2E");
diff --git =
a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh
index 931e54d=2E=2E2477560 1006=
44
--- a/src/openvpn/tun=2Eh
+++ b/src/openvpn/tun=2Eh
@@ -504,7 +504,7 @@
=
 static inline bool
 is_ip_packet_valid(const struct buffer *buf)
 {
-    c=
onst struct openvpn_iphdr *ih =3D (const struct openvpn_iphdr *)BPTR(buf);
=
+    const struct openvpn_iphdr *ih =3D (const struct openvpn_iphdr *)CBPTR=
(buf);
 
     if (OPENVPN_IPH_GET_VER(ih->version_len) =3D=3D 4)
     {
dif=
f --git a/src/openvpn/vlan=2Ec b/src/openvpn/vlan=2Ec
index bffc60e=2E=2E69=
ac10d 100644
--- a/src/openvpn/vlan=2Ec
+++ b/src/openvpn/vlan=2Ec
@@ -269,=
7 +269,7 @@
         return false;
     }
 
-    vlanhdr =3D (const struct =
openvpn_8021qhdr *)BPTR(buf);
+    vlanhdr =3D (const struct openvpn_8021qh=
dr *)CBPTR(buf);
 
     if (ntohs(vlanhdr->tpid) !=3D OPENVPN_ETH_P_8021Q)
=
     {
diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_t=
ests/openvpn/test_buffer=2Ec
index 7fb9162=2E=2E7bd0c45 100644
--- a/tests/=
unit_tests/openvpn/test_buffer=2Ec
+++ b/tests/unit_tests/openvpn/test_buff=
er=2Ec
@@ -51,7 +51,7 @@
 
 #define assert_buf_equals_str(buf, str)        =
\
     assert_int_equal(BLENZ(buf), strlen(str)); \
-    assert_memory_equa=
l(BPTR(buf), str, BLENZ(buf));
+    assert_memory_equal(CBPTR(buf), str, BL=
ENZ(buf));
 
 static void
 test_buffer_printf_catrunc(void **state)
diff --=
git a/tests/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvp=
n/test_tls_crypt=2Ec
index db03437=2E=2Ef648e13 100644
--- a/tests/unit_tes=
ts/openvpn/test_tls_crypt=2Ec
+++ b/tests/unit_tests/openvpn/test_tls_crypt=
=2Ec
@@ -130,7 +130,7 @@
 bool
 __wrap_buffer_write_file(const char *filena=
me, const struct buffer *buf)
 {
-    const char *pem =3D BSTR(buf);
+    c=
onst char *pem =3D CBSTR(buf);
     check_expected_ptr(filename);
     chec=
k_expected_ptr(pem);
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1904?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e
Gerrit-Change-Number: 1904
Ge=
rrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>

--ABMSwPG1PPs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">buffer: When extracting pointers from buffer, retain const<br><br>Curr=
ently you can use BPTR and similar to implictly remove<br>const=2E That avo=
ids some warnings that we should get and<br>confuses tools like cppcheck in=
to giving wrong suggestions=2E<br><br>So make sure that by default we do no=
t return a non-const<br>pointer if the buffer is not const=2E Change all ca=
ll sites<br>that threw warnings=2E<br><br>Change-Id: Ib4af7639cdebe81eba05a=
b04efe6e85e63de0f9e<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh=
<br>M src/openvpn/crypto_backend=2Eh<br>M src/openvpn/crypto_mbedtls=2Ec<br=
>M src/openvpn/crypto_mbedtls_legacy=2Ec<br>M src/openvpn/crypto_openssl=2E=
c<br>M src/openvpn/forward=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn=
/mroute=2Ec<br>M src/openvpn/proto=2Eh<br>M src/openvpn/ps=2Ec<br>M src/ope=
nvpn/push=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M =
src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>M src/openvpn/tl=
s_crypt=2Ec<br>M src/openvpn/tun=2Eh<br>M src/openvpn/vlan=2Ec<br>M tests/u=
nit_tests/openvpn/test_buffer=2Ec<br>M tests/unit_tests/openvpn/test_tls_cr=
ypt=2Ec<br>21 files changed, 154 insertions(+), 89 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/04/1904/1</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/b=
uffer=2Ec</span><br><span>index 5d00415=2E=2E8a3136a 100644</span><br><span=
>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec<=
/span><br><span>@@ -109,7 +109,7 @@</span><br><span> #endif</span><br><span=
>     ret=2Edata =3D (uint8_t *)malloc(buf-&gt;capacity);</span><br><span> =
    check_malloc_return(ret=2Edata);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    memcpy(BPTR(&amp;ret), BPTR(buf), BLENZ(buf));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(BPTR(&amp;ret), CB=
PTR(buf), BLENZ(buf));</span><br><span>     return ret;</span><br><span> }<=
/span><br><span> </span><br><span>@@ -162,7 +162,7 @@</span><br><span>     =
{</span><br><span>         return false;</span><br><span>     }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return buf_write(dest, BPTR(s=
rc), BLENZ(src));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return buf_write(dest, CBPTR(src), BLENZ(src));</span><br><span> }</span>=
<br><span> </span><br><span> void</span><br><span>@@ -293,7 +293,7 @@</span=
><br><span>         return false;</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const ssize_t size=
 =3D write(fd, BPTR(buf), (unsigned int)BLEN(buf));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const ssize_t size =3D write(fd, CBPT=
R(buf), (unsigned int)BLEN(buf));</span><br><span>     if (size !=3D BLEN(b=
uf))</span><br><span>     {</span><br><span>         msg(M_ERRNO, &quot;Wri=
te error on file &#39;%s&#39;&quot;, filename);</span><br><span>@@ -732,7 +=
732,7 @@</span><br><span>     {</span><br><span>         return false;</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return memcmp(BPTR(src), match, size) =3D=3D 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return memcmp(CBPTR(src), match, size) =3D=
=3D 0;</span><br><span> }</span><br><span> </span><br><span> bool</span><br=
><span>@@ -1035,13 +1035,13 @@</span><br><span> }</span><br><span> </span><=
br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-string_=
check_buf(struct buffer *buf, const unsigned int inclusive, const unsigned =
int exclusive)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+strin=
g_check_buf(const struct buffer *buf, const unsigned int inclusive, const u=
nsigned int exclusive)</span><br><span> {</span><br><span>     ASSERT(buf);=
</span><br><span> </span><br><span>     for (int i =3D 0; i &lt; BLEN(buf);=
 i++)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        char c =3D BSTR(buf)[i];</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        char c =3D CBSTR(buf)[i];</span><br><span> </sp=
an><br><span>         if (!char_inc_exc(c, inclusive, exclusive))</span><br=
><span>         {</span><br><span>diff --git a/src/openvpn/buffer=2Eh b/src=
/openvpn/buffer=2Eh</span><br><span>index 0a02e94=2E=2E22a8b74 100644</span=
><br><span>--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/b=
uffer=2Eh</span><br><span>@@ -136,21 +136,29 @@</span><br><span> </span><br=
><span> </span><br><span> /** Return a pointer to the start of the buffer c=
ontent=2E @see buf_bptr() */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define BPTR(buf)  (buf_bptr(buf))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define BPTR(buf)   (buf_bptr(buf))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/** Return a const pointer to the sta=
rt of the buffer content=2E @see buf_cbptr() */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define CBPTR(buf)  (buf_cbptr(buf))</span><br>=
<span> /** Return a pointer one past the end of the buffer content=2E @see =
buf_bend() */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
BEND(buf)  (buf_bend(buf))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define BEND(buf)   (buf_bend(buf))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/** Return a const pointer one past the end of the b=
uffer content=2E @see buf_cbend() */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define CBEND(buf)  (buf_cbend(buf))</span><br><span> /** =
Return a pointer to the last byte of the buffer content, or NULL if empty=
=2E @see buf_blast() */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define BLAST(buf) (buf_blast(buf))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define BLAST(buf)  (buf_blast(buf))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/** Return a const pointer to the last b=
yte of the buffer content, or NULL if empty=2E @see buf_cblast() */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define CBLAST(buf) (buf_cb=
last(buf))</span><br><span> /** Return the length of the buffer content in =
bytes=2E @see buf_len() */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define BLEN(buf)  (buf_len(buf))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define BLEN(buf)   (buf_len(buf))</span><br><span> /** =
Return the length of the buffer content as a \c size_t=2E @see buf_len() */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define BLENZ(buf) ((=
size_t)buf_len(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define BLENZ(buf)  ((size_t)buf_len(buf))</span><br><span> /** Return tru=
e iff the buffer is defined (has non-NULL data pointer)=2E @see buf_defined=
() */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define BDEF(buf=
)  (buf_defined(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define BDEF(buf)   (buf_defined(buf))</span><br><span> /** Return the bu=
ffer content pointer cast to \c char *=2E @see buf_str() */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define BSTR(buf)  (buf_str(buf))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define BSTR(buf)   (bu=
f_str(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Retu=
rn the buffer content pointer cast to \c const char *=2E @see buf_cstr() */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CBSTR(buf) =
 (buf_cstr(buf))</span><br><span> /** Return the number of bytes available =
for appending to the buffer=2E @see buf_forward_capacity() */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define BCAP(buf)  (buf_forward_cap=
acity(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
BCAP(buf)   (buf_forward_capacity(buf))</span><br><span> </span><br><span> =
/**</span><br><span>  * Zeroise and reset a buffer=2E</span><br><span>@@ -4=
07,15 +415,15 @@</span><br><span> }</span><br><span> </span><br><span> /**<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Return a pointer to=
 the start of the buffer content=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * Return a const pointer to the start of the buffer conten=
t=2E</span><br><span>  *</span><br><span>  * @param buf   The buffer to que=
ry=2E</span><br><span>  *</span><br><span>  * @return Pointer to \c buf-&gt=
;data + \c buf-&gt;offset, or NULL if \c buf is</span><br><span>  *        =
 not valid=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-static inline uint8_t *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-buf_bptr(const struct buffer *buf)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static inline const uint8_t *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+buf_cbptr(const struct buffer *buf)=
</span><br><span> {</span><br><span>     if (buf_valid(buf))</span><br><spa=
n>     {</span><br><span>@@ -428,6 +436,20 @@</span><br><span> }</span><br>=
<span> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Return a pointer to the start of the buffer content=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to query=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return Pointer to \c buf-&gt;data + \=
c buf-&gt;offset, or NULL if \c buf is</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *         not valid=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static inline uint8_t *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+buf_bptr(struct buffer *buf)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return (uint8_t *)buf_cbptr(buf);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an>  * Return the length of the buffer content=2E</span><br><span>  *</span=
><br><span>  * @param buf   The buffer to query=2E</span><br><span>@@ -455,=
12 +477,46 @@</span><br><span>  * @return Pointer to the byte immediately a=
fter the last content byte=2E</span><br><span>  */</span><br><span> static =
inline uint8_t *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-buf_b=
end(const struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+buf_bend(struct buffer *buf)</span><br><span> {</span><br><span> =
    return buf_bptr(buf) + buf_len(buf);</span><br><span> }</span><br><span=
> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Return a const pointer one past the end of the buffer content=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to query=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @return Pointer to the byte immedia=
tely after the last content byte=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static inline const uint8_t *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+buf_cbend(const struct buffer *buf)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return buf_cbptr(buf) + buf_len(buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return a const point=
er to the last byte of the buffer content=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param buf   The buffer to query=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @return Pointer to the last byte, or NULL if the buffer is emp=
ty or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         inv=
alid=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static inline const uint8_t =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_cblast(const s=
truct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(buf=
) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return buf_cbptr=
(buf) + buf_len(buf) - 1;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span>  * Return a pointer to the last byte of the buffer content=2E<=
/span><br><span>  *</span><br><span>  * @param buf   The buffer to query=2E=
</span><br><span>@@ -469,16 +525,9 @@</span><br><span>  *         invalid=
=2E</span><br><span>  */</span><br><span> static inline uint8_t *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-buf_blast(const struct buffer *=
buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_blast(struc=
t buffer *buf)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (buf_len(buf) &gt; 0)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        return buf_bptr(buf) + buf_len(buf) - 1;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retur=
n NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return (uint8_t *)buf_cb=
last(buf);</span><br><span> }</span><br><span> </span><br><span> /**</span>=
<br><span>@@ -518,12 +567,25 @@</span><br><span>  * @return The content poi=
nter as a \c char *, or NULL if \c buf is invalid=2E</span><br><span>  */</=
span><br><span> static inline char *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-buf_str(const struct buffer *buf)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+buf_str(struct buffer *buf)</span><br><span> {=
</span><br><span>     return (char *)buf_bptr(buf);</span><br><span> }</spa=
n><br><span> </span><br><span> /**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Return the buffer content pointer cast to \c const char *=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to que=
ry=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return The content pointer =
as a \c const char *, or NULL if \c buf is invalid=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static inline const char *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+buf_cstr(const struct buffer *buf)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return (const char *)buf_cbptr(buf);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/**</span><br><span>  * Reset a buffer to an undefined (unallocated) =
state=2E</span><br><span>  *</span><br><span>  * Sets all fields to zero/NU=
LL without freeing any memory=2E  Use \c free_buf()</span><br><span>@@ -130=
0,7 +1362,7 @@</span><br><span> static inline bool</span><br><span> buf_cop=
y(struct buffer *dest, const struct buffer *src)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return buf_write(dest, BP=
TR(src), BLENZ(src));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return buf_write(dest, CBPTR(src), BLENZ(src));</span><br><span> }</s=
pan><br><span> </span><br><span> /**</span><br><span>@@ -1427,14 +1489,14 @=
@</span><br><span>  *         is empty=2E</span><br><span>  */</span><br><s=
pan> static inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-buf_peek_u8(struct buffer *buf)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+buf_peek_u8(const struct buffer *buf)</span><br><span> {</span=
><br><span>     int ret;</span><br><span>     if (BLEN(buf) &lt; 1)</span><=
br><span>     {</span><br><span>         return -1;</span><br><span>     }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D *BPTR(buf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D *CBPTR=
(buf);</span><br><span>     return ret;</span><br><span> }</span><br><span>=
 </span><br><span>@@ -1547,7 +1609,7 @@</span><br><span> static inline bool=
</span><br><span> buf_equal(const struct buffer *a, const struct buffer *b)=
</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return BLEN(a) =3D=3D BLEN(b) &amp;&amp; 0 =3D=3D memcmp(BPTR(a), BPTR(b)=
, BLENZ(a));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn BLEN(a) =3D=3D BLEN(b) &amp;&amp; 0 =3D=3D memcmp(CBPTR(a), CBPTR(b), B=
LENZ(a));</span><br><span> }</span><br><span> </span><br><span> /**</span><=
br><span>@@ -1561,7 +1623,7 @@</span><br><span>     {</span><br><span>     =
    return false;</span><br><span>     }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return memcmp(BPTR(src), match, size) =3D=3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return memcmp(CBPTR(=
src), match, size) =3D=3D 0;</span><br><span> }</span><br><span> </span><br=
><span> /**</span><br><span>@@ -1575,7 +1637,7 @@</span><br><span>     {</s=
pan><br><span>         return false;</span><br><span>     }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return memcmp(BPTR(src), match, s=
ize) =3D=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn memcmp(CBPTR(src), match, size) =3D=3D 0;</span><br><span> }</span><b=
r><span> </span><br><span> /**</span><br><span>@@ -1720,7 +1782,7 @@</span>=
<br><span>  * @param exclusive Character classes that are not allowed even =
if they are also in inclusive=2E</span><br><span>  * @return True if the st=
ring consists only of allowed characters, false otherwise=2E</span><br><spa=
n>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool string_che=
ck_buf(struct buffer *buf, const unsigned int inclusive,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+bool string_check_buf(const struct buf=
fer *buf, const unsigned int inclusive,</span><br><span>                   =
    const unsigned int exclusive);</span><br><span> </span><br><span> /**</=
span><br><span>diff --git a/src/openvpn/crypto_backend=2Eh b/src/openvpn/cr=
ypto_backend=2Eh</span><br><span>index 17085d6=2E=2E7ef6ac4 100644</span><b=
r><span>--- a/src/openvpn/crypto_backend=2Eh</span><br><span>+++ b/src/open=
vpn/crypto_backend=2Eh</span><br><span>@@ -445,7 +445,7 @@</span><br><span>=
  *</span><br><span>  * @return              \c 0 on failure, \c 1 on succe=
ss=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-int cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, u=
int8_t *src, int src_len);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+int cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len,=
 const uint8_t *src, int src_len);</span><br><span> </span><br><span> /**</=
span><br><span>  * Pads the final cipher block using PKCS padding, and outp=
ut to the destination</span><br><span>diff --git a/src/openvpn/crypto_mbedt=
ls=2Ec b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>index 6662def=2E=2E=
85cc545 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls=2Ec</span><=
br><span>+++ b/src/openvpn/crypto_mbedtls=2Ec</span><br><span>@@ -512,7 +51=
2,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_update(cipher_ctx_t *=
ctx, uint8_t *dst, int *dst_len, uint8_t *src, int src_len)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_update(cipher_ctx_t *ctx=
, uint8_t *dst, int *dst_len, const uint8_t *src, int src_len)</span><br><s=
pan> {</span><br><span>     if (src_len &lt; 0)</span><br><span>     {</spa=
n><br><span>diff --git a/src/openvpn/crypto_mbedtls_legacy=2Ec b/src/openvp=
n/crypto_mbedtls_legacy=2Ec</span><br><span>index 9e47c26=2E=2Ebbd012f6 100=
644</span><br><span>--- a/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><=
span>+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>@@ -249,7 =
+249,7 @@</span><br><span> </span><br><span>     size_t out_len =3D 0;</spa=
n><br><span>     if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        !=3D mbedtls_pem_write_buffer(he=
ader, footer, BPTR(src), BLEN(src), NULL, 0, &amp;out_len))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        !=3D mbedtls_pem_write_buff=
er(header, footer, CBPTR(src), BLEN(src), NULL, 0, &amp;out_len))</span><br=
><span>     {</span><br><span>         return false;</span><br><span>     }=
</span><br><span>@@ -257,7 +257,7 @@</span><br><span>     /* We set the siz=
e buf to out_len-1 to NOT include the 0 byte that</span><br><span>      * m=
bedtls_pem_write_buffer in its length calculation */</span><br><span>     *=
dst =3D alloc_buf_gc(out_len, gc);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR=
(src), BLEN(src), BPTR(dst),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, CBPTR(sr=
c), BLEN(src), BPTR(dst),</span><br><span>                                 =
          BCAP(dst), &amp;out_len))</span><br><span>         || !buf_inc_le=
n(dst, out_len - 1))</span><br><span>     {</span><br><span>@@ -684,7 +684,=
7 @@</span><br><span> }</span><br><span> </span><br><span> int</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_update(mbedtls_cipher_c=
ontext_t *ctx, uint8_t *dst, int *dst_len, uint8_t *src,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_update(mbedtls_cipher_conte=
xt_t *ctx, uint8_t *dst, int *dst_len, const uint8_t *src,</span><br><span>=
                   int src_len)</span><br><span> {</span><br><span>     siz=
e_t s_dst_len =3D *dst_len;</span><br><span>diff --git a/src/openvpn/crypto=
_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br><span>index 2019280=
=2E=2E29c5fa6 100644</span><br><span>--- a/src/openvpn/crypto_openssl=2Ec</=
span><br><span>+++ b/src/openvpn/crypto_openssl=2Ec</span><br><span>@@ -465=
,7 +465,7 @@</span><br><span> {</span><br><span>     bool ret =3D false;</s=
pan><br><span>     BIO *bio =3D BIO_new(BIO_s_mem());</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!bio || !PEM_write_bio(bio, name, &=
quot;&quot;, BPTR(src), BLEN(src)))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!bio || !PEM_write_bio(bio, name, &quot;&quot;, CBP=
TR(src), BLEN(src)))</span><br><span>     {</span><br><span>         ret =
=3D false;</span><br><span>         goto cleanup;</span><br><span>@@ -492,7=
 +492,7 @@</span><br><span> {</span><br><span>     bool ret =3D false;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    BIO =
*bio =3D BIO_new_mem_buf((char *)BPTR(src), BLEN(src));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    BIO *bio =3D BIO_new_mem_buf(CBPTR(=
src), BLEN(src));</span><br><span>     if (!bio)</span><br><span>     {</sp=
an><br><span>         crypto_msg(M_FATAL, &quot;Cannot open memory BIO for =
PEM decode&quot;);</span><br><span>@@ -941,7 +941,7 @@</span><br><span> }</=
span><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-cipher_ctx_update(EVP_CIPHER_CTX *ctx, uint8_t *dst, int *d=
st_len, uint8_t *src, int src_len)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+cipher_ctx_update(EVP_CIPHER_CTX *ctx, uint8_t *dst, int *ds=
t_len, const uint8_t *src, int src_len)</span><br><span> {</span><br><span>=
     if (!EVP_CipherUpdate(ctx, dst, dst_len, src, src_len))</span><br><spa=
n>     {</span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn=
/forward=2Ec</span><br><span>index 2ade321=2E=2Ead43d40 100644</span><br><s=
pan>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=
=2Ec</span><br><span>@@ -271,7 +271,7 @@</span><br><span>     }</span><br><=
span>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        msg(D_PUSH_ERRORS, &quot;WARNING: Received unknown =
control message: %s&quot;, BSTR(buf));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        msg(D_PUSH_ERRORS, &quot;WARNING: Received unkno=
wn control message: %s&quot;, CBSTR(buf));</span><br><span>     }</span><br=
><span> }</span><br><span> </span><br><span>@@ -1646,7 +1646,7 @@</span><br=
><span>             return;</span><br><span>         }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        const struct ope=
nvpn_ethhdr *orig_ethhdr =3D (struct openvpn_ethhdr *)BPTR(buf);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        const struct openvpn_e=
thhdr *orig_ethhdr =3D (const struct openvpn_ethhdr *)CBPTR(buf);</span><br=
><span> </span><br><span>         /* Copy frametype and reverse source/dest=
ination for the response */</span><br><span>         struct openvpn_ethhdr =
ethhdr;</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/m=
anage=2Ec</span><br><span>index 310d2e1=2E=2E7128196 100644</span><br><span=
>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec<=
/span><br><span>@@ -2512,24 +2512,23 @@</span><br><span> {</span><br><span>=
     const int size_hint =3D 1024;</span><br><span>     ssize_t sent =3D 0;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const struct buff=
er *buf;</span><br><span> </span><br><span>     buffer_list_aggregate(man-&=
gt;connection=2Eout, size_hint);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    buf =3D buffer_list_peek(man-&gt;connection=2Eout);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const struct buffer *buf=
 =3D buffer_list_peek(man-&gt;connection=2Eout);</span><br><span>     if (b=
uf &amp;&amp; BLEN(buf))</span><br><span>     {</span><br><span>         co=
nst int len =3D min_int(size_hint, BLEN(buf));</span><br><span> #ifdef TARG=
ET_ANDROID</span><br><span>         if (man-&gt;connection=2Efdtosend &gt; =
0)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            sent =3D man_send_with_fd(man-&gt;connection=2Esd_cli, =
BPTR(buf), len, MSG_NOSIGNAL,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            sent =3D man_send_with_fd(man-&gt;connection=2Esd_cli=
, CBPTR(buf), len, MSG_NOSIGNAL,</span><br><span>                          =
           man-&gt;connection=2Efdtosend);</span><br><span>             man=
-&gt;connection=2Efdtosend =3D -1;</span><br><span>         }</span><br><sp=
an>         else</span><br><span> #endif</span><br><span>         {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            sent =3D send(man=
-&gt;connection=2Esd_cli, (const void *)BPTR(buf), len, MSG_NOSIGNAL);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            sent =3D sen=
d(man-&gt;connection=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);</span><br><s=
pan>         }</span><br><span>         if (sent &gt;=3D 0)</span><br><span=
>         {</span><br><span>diff --git a/src/openvpn/mroute=2Ec b/src/openv=
pn/mroute=2Ec</span><br><span>index edf8239=2E=2E39fa482 100644</span><br><=
span>--- a/src/openvpn/mroute=2Ec</span><br><span>+++ b/src/openvpn/mroute=
=2Ec</span><br><span>@@ -150,12 +150,12 @@</span><br><span>     unsigned in=
t ret =3D 0;</span><br><span>     if (BLEN(buf) &gt;=3D 1)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        switch =
(OPENVPN_IPH_GET_VER(*BPTR(buf)))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        switch (OPENVPN_IPH_GET_VER(*CBPTR(buf)))</span><br><=
span>         {</span><br><span>             case 4:</span><br><span>      =
           if (BLENZ(buf) &gt;=3D sizeof(struct openvpn_iphdr))</span><br><=
span>                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    const struct openvpn_iphdr *ip =3D (const struct open=
vpn_iphdr *)BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    const struct openvpn_iphdr *ip =3D (const struct ope=
nvpn_iphdr *)CBPTR(buf);</span><br><span> </span><br><span>                =
     mroute_get_in_addr_t(src, ip-&gt;saddr);</span><br><span>             =
        mroute_get_in_addr_t(dest, ip-&gt;daddr);</span><br><span>@@ -179,7=
 +179,7 @@</span><br><span>             case 6:</span><br><span>           =
      if (BLENZ(buf) &gt;=3D sizeof(struct openvpn_ipv6hdr))</span><br><spa=
n>                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   const struct openvpn_ipv6hdr *ipv6 =3D (const struct ope=
nvpn_ipv6hdr *)BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    const struct openvpn_ipv6hdr *ipv6 =3D (const str=
uct openvpn_ipv6hdr *)CBPTR(buf);</span><br><span> #if 0 /* very basic debu=
g */</span><br><span>                     struct gc_arena gc =3D gc_new();<=
/span><br><span>                     msg( M_INFO, &quot;IPv6 packet! src=3D=
%s, dst=3D%s&quot;,</span><br><span>@@ -202,7 +202,7 @@</span><br><span> </=
span><br><span>             default:</span><br><span>                 msg(M=
_WARN, &quot;IP packet with unknown IP version=3D%d seen&quot;,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    OPENVPN_IPH_G=
ET_VER(*BPTR(buf)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    OPENVPN_IPH_GET_VER(*CBPTR(buf)));</span><br><span>   =
      }</span><br><span>     }</span><br><span>     return ret;</span><br><=
span>@@ -226,7 +226,7 @@</span><br><span>     unsigned int ret =3D 0;</span=
><br><span>     if (BLEN(buf) &gt;=3D (int)sizeof(struct openvpn_ethhdr))</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        const struct openvpn_ethhdr *eth =3D (const struct openvpn_ethhdr *=
)BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
const struct openvpn_ethhdr *eth =3D (const struct openvpn_ethhdr *)CBPTR(b=
uf);</span><br><span>         if (src)</span><br><span>         {</span><br=
><span>             mroute_copy_ether_to_addr(src, eth-&gt;source, vid);</s=
pan><br><span>diff --git a/src/openvpn/proto=2Eh b/src/openvpn/proto=2Eh</s=
pan><br><span>index 3570582=2E=2E9bb0866 100644</span><br><span>--- a/src/o=
penvpn/proto=2Eh</span><br><span>+++ b/src/openvpn/proto=2Eh</span><br><spa=
n>@@ -258,7 +258,7 @@</span><br><span>         *ip_hdr_offset =3D 0;</span>=
<br><span>         if (likely(BLEN(buf) &gt;=3D (int)sizeof(struct openvpn_=
iphdr)))</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            ip_ver =3D OPENVPN_IPH_GET_VER(*BPTR(buf));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            ip_ver =3D OP=
ENVPN_IPH_GET_VER(*CBPTR(buf));</span><br><span>         }</span><br><span>=
     }</span><br><span>     else if (tunnel_type =3D=3D DEV_TYPE_TAP)</span=
><br><span>@@ -267,7 +267,7 @@</span><br><span>         /* for tap get ip v=
ersion from eth header */</span><br><span>         if (likely(BLEN(buf) &gt=
;=3D *ip_hdr_offset))</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            const struct openvpn_ethhdr *eh =3D =
(const struct openvpn_ethhdr *)BPTR(buf);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            const struct openvpn_ethhdr *eh =3D (cons=
t struct openvpn_ethhdr *)CBPTR(buf);</span><br><span>             uint16_t=
 proto =3D ntohs(eh-&gt;proto);</span><br><span>             if (proto =3D=
=3D OPENVPN_ETH_P_IPV6)</span><br><span>             {</span><br><span>diff=
 --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><span>index be91=
a99=2E=2E08c2673 100644</span><br><span>--- a/src/openvpn/ps=2Ec</span><br>=
<span>+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -208,7 +208,9 @@</span><b=
r><span> </span><br><span>         if (head)</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            iov[1]=2Eiov_=
base =3D BPTR(head);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /* sendmsg takes a const msghdr, but we can&#39;t construct th=
at here</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
   directly, so cast */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            iov[1]=2Eiov_base =3D (char *)CBPTR(head);</span><br><span>=
             iov[1]=2Eiov_len =3D BLENZ(head);</span><br><span>            =
 mesg=2Emsg_iovlen =3D 2;</span><br><span>         }</span><br><span>@@ -96=
4,7 +966,7 @@</span><br><span> bool</span><br><span> is_openvpn_protocol(co=
nst struct buffer *buf)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    const unsigned char *p =3D (const unsigned char *)=
BSTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 unsigned char *p =3D (const unsigned char *)CBSTR(buf);</span><br><span>  =
   const int len =3D BLEN(buf);</span><br><span>     if (len &gt;=3D 3)</sp=
an><br><span>     {</span><br><span>diff --git a/src/openvpn/push=2Ec b/src=
/openvpn/push=2Ec</span><br><span>index da2bb9f=2E=2E761a59e 100644</span><=
br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=
=2Ec</span><br><span>@@ -47,7 +47,7 @@</span><br><span> void</span><br><spa=
n> receive_auth_failed(struct context *c, const struct buffer *buffer)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg=
(M_VERB0, &quot;AUTH: Received control message: %s&quot;, BSTR(buffer));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_VERB0, &quot=
;AUTH: Received control message: %s&quot;, CBSTR(buffer));</span><br><span>=
     c-&gt;options=2Eno_advance =3D true;</span><br><span> </span><br><span=
>     if (!c-&gt;options=2Epull)</span><br><span>@@ -64,7 +64,7 @@</span><b=
r><span>     const char *reason =3D NULL;</span><br><span>     if (authfail=
_extended &amp;&amp; BLEN(&amp;buf))</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        reason =3D BSTR(&amp;buf);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        reason =3D CBS=
TR(&amp;buf);</span><br><span>     }</span><br><span> </span><br><span>    =
 if (authfail_extended &amp;&amp; buf_string_match_head_str(&amp;buf, &quot=
;TEMP&quot;))</span><br><span>@@ -116,7 +116,7 @@</span><br><span>      */<=
/span><br><span>     if (authfail_extended &amp;&amp; buf_string_match_head=
_str(&amp;buf, &quot;CRV1:&quot;) &amp;&amp; BLEN(&amp;buf))</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ssl_p=
ut_auth_challenge(BSTR(&amp;buf));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        ssl_put_auth_challenge(CBSTR(&amp;buf));</span><br><=
span>     }</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br=
><span> }</span><br><span>@@ -508,7 +508,7 @@</span><br><span>     uint64_t=
 option_types_found =3D 0;</span><br><span> </span><br><span>     msg(D_PUS=
H, &quot;PUSH: Received control message: &#39;%s&#39;&quot;,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        sanitize_control_message(BST=
R(buffer), &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        sanitize_control_message(CBSTR(buffer), &amp;gc));</span><br><spa=
n> </span><br><span>     int status =3D process_incoming_push_msg(c, buffer=
, c-&gt;options=2Epull, pull_permission_mask(c),</span><br><span>          =
                                  &amp;option_types_found);</span><br><span=
>@@ -516,7 +516,7 @@</span><br><span>     if (status =3D=3D PUSH_MSG_ERROR)=
</span><br><span>     {</span><br><span>         msg(D_PUSH_ERRORS, &quot;W=
ARNING: Received bad push/pull message: %s&quot;,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            sanitize_control_message(BSTR(buffe=
r), &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       sanitize_control_message(CBSTR(buffer), &amp;gc));</span><br><span> =
    }</span><br><span>     else if (status =3D=3D PUSH_MSG_REPLY || status =
=3D=3D PUSH_MSG_UPDATE</span><br><span>              || status =3D=3D PUSH_=
MSG_CONTINUATION)</span><br><span>diff --git a/src/openvpn/socket=2Ec b/src=
/openvpn/socket=2Ec</span><br><span>index 7c6217a=2E=2E7f39268 100644</span=
><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/s=
ocket=2Ec</span><br><span>@@ -2446,7 +2446,9 @@</span><br><span>     struct=
 cmsghdr *cmsg;</span><br><span>     uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 iov=2Eiov_base =3D BPTR(buf);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* sendmsg takes a const msghdr, but we can&#39;t construct =
that here</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       dir=
ectly, so cast */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  iov=2Eiov_base =3D (char *)CBPTR(buf);</span><br><span>     iov=2Eiov_len=
 =3D BLENZ(buf);</span><br><span>     mesg=2Emsg_iov =3D &amp;iov;</span><b=
r><span>     mesg=2Emsg_iovlen =3D 1;</span><br><span>diff --git a/src/open=
vpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 89465bc=2E=2E=
c6a29f4 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span=
>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -709,14 +709,14 @@</span><=
br><span>     }</span><br><span>     else</span><br><span> #endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return sendto(sock-&gt;=
sd, BPTR(buf), BLENZ(buf), 0, (struct sockaddr *)&amp;to-&gt;dest=2Eaddr=2E=
sa,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return s=
endto(sock-&gt;sd, CBPTR(buf), BLENZ(buf), 0, (struct sockaddr *)&amp;to-&g=
t;dest=2Eaddr=2Esa,</span><br><span>                       (socklen_t)af_ad=
dr_size(to-&gt;dest=2Eaddr=2Esa=2Esa_family));</span><br><span> }</span><br=
><span> </span><br><span> static inline ssize_t</span><br><span> link_socke=
t_write_tcp_posix(struct link_socket *sock, struct buffer *buf)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return sen=
d(sock-&gt;sd, BPTR(buf), BLENZ(buf), MSG_NOSIGNAL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return send(sock-&gt;sd, CBPTR(buf), =
BLENZ(buf), MSG_NOSIGNAL);</span><br><span> }</span><br><span> </span><br><=
span> #endif /* ifdef _WIN32 */</span><br><span>@@ -761,7 +761,7 @@</span><=
br><span> {</span><br><span>     if (sock &amp;&amp; ipbuf)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const =
struct openvpn_iphdr *iph =3D (struct openvpn_iphdr *)BPTR(ipbuf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        const struct openvpn=
_iphdr *iph =3D (const struct openvpn_iphdr *)CBPTR(ipbuf);</span><br><span=
>         sock-&gt;ptos =3D iph-&gt;tos;</span><br><span>         sock-&gt;=
ptos_defined =3D true;</span><br><span>     }</span><br><span>diff --git a/=
src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index 6a6=
d9f9=2E=2E90b2aec 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</spa=
n><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -305,7 +305,7 =
@@</span><br><span>     }</span><br><span> </span><br><span>     /* get opc=
ode and key ID */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
uint8_t pkt_firstbyte =3D *BPTR(buf);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    uint8_t pkt_firstbyte =3D *CBPTR(buf);</span><br><spa=
n>     int op =3D pkt_firstbyte &gt;&gt; P_OPCODE_SHIFT;</span><br><span>  =
   int key_id =3D pkt_firstbyte &amp; P_KEY_ID_MASK;</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verif=
y=2Ec</span><br><span>index 063fa5d=2E=2E3653eb4 100644</span><br><span>---=
 a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=
=2Ec</span><br><span>@@ -207,7 +207,7 @@</span><br><span> </span><br><span>=
         struct cert_hash *ch =3D session-&gt;cert_hash_set-&gt;ch[error_de=
pth];</span><br><span>         ASSERT(sizeof(ch-&gt;sha256_hash) =3D=3D BLE=
N(cert_hash));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 memcpy(ch-&gt;sha256_hash, BPTR(cert_hash), sizeof(ch-&gt;sha256_hash));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(ch-&gt=
;sha256_hash, CBPTR(cert_hash), sizeof(ch-&gt;sha256_hash));</span><br><spa=
n>     }</span><br><span> }</span><br><span> </span><br><span>diff --git a/=
src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><span>index=
 47f5ac5=2E=2E23c7975 100644</span><br><span>--- a/src/openvpn/tls_crypt=2E=
c</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br><span>@@ -148,7=
 +148,7 @@</span><br><span> </span><br><span>     gc_init(&amp;gc);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_=
PACKET_CONTENT, &quot;TLS-CRYPT WRAP FROM: %s&quot;, format_hex(BPTR(src), =
BLEN(src), 80, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    dmsg(D_PACKET_CONTENT, &quot;TLS-CRYPT WRAP FROM: %s&quot;, forma=
t_hex(CBPTR(src), BLEN(src), 80, &amp;gc));</span><br><span> </span><br><sp=
an>     /* Get packet ID */</span><br><span>     if (!packet_id_write(&amp;=
opt-&gt;packet_id=2Esend, dst, true, false))</span><br><span>@@ -157,7 +157=
,7 @@</span><br><span>         goto err;</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACK=
ET_CONTENT, &quot;TLS-CRYPT WRAP AD: %s&quot;, format_hex(BPTR(dst), BLEN(d=
st), 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   dmsg(D_PACKET_CONTENT, &quot;TLS-CRYPT WRAP AD: %s&quot;, format_hex(CBP=
TR(dst), BLEN(dst), 0, &amp;gc));</span><br><span> </span><br><span>     /*=
 Buffer overflow check */</span><br><span>     if (!buf_safe(dst, BLENZ(src=
) + TLS_CRYPT_BLOCK_SIZE + TLS_CRYPT_TAG_SIZE))</span><br><span>@@ -173,8 +=
173,8 @@</span><br><span>     {</span><br><span>         uint8_t *tag =3D N=
ULL;</span><br><span>         hmac_ctx_reset(ctx-&gt;hmac);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        hmac_ctx_update(ctx-&gt;hmac,=
 BPTR(dst), BLEN(dst));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        hmac_ctx_update(ctx-&gt;hmac, BPTR(src), BLEN(src));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        hmac_ctx_update(ctx-&gt;=
hmac, CBPTR(dst), BLEN(dst));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        hmac_ctx_update(ctx-&gt;hmac, CBPTR(src), BLEN(src));</sp=
an><br><span> </span><br><span>         ASSERT(tag =3D buf_write_alloc(dst,=
 TLS_CRYPT_TAG_SIZE));</span><br><span>         hmac_ctx_final(ctx-&gt;hmac=
, tag);</span><br><span>@@ -189,7 +189,7 @@</span><br><span>     /* Encrypt=
 src */</span><br><span>     {</span><br><span>         int outlen =3D 0;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(cipher_c=
tx_update(ctx-&gt;cipher, BEND(dst), &amp;outlen, BPTR(src), BLEN(src)));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(cipher=
_ctx_update(ctx-&gt;cipher, BEND(dst), &amp;outlen, CBPTR(src), BLEN(src)))=
;</span><br><span>         ASSERT(buf_inc_len(dst, outlen));</span><br><spa=
n>         ASSERT(cipher_ctx_final(ctx-&gt;cipher, BPTR(dst), &amp;outlen))=
;</span><br><span>         ASSERT(buf_inc_len(dst, outlen));</span><br><spa=
n>@@ -220,7 +220,7 @@</span><br><span>     ASSERT(ctx-&gt;cipher);</span><b=
r><span>     ASSERT(packet_id_initialized(&amp;opt-&gt;packet_id) || (opt-&=
gt;flags &amp; CO_IGNORE_PACKET_ID));</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;TLS-CRYP=
T UNWRAP FROM: %s&quot;, format_hex(BPTR(src), BLEN(src), 80, &amp;gc));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONT=
ENT, &quot;TLS-CRYPT UNWRAP FROM: %s&quot;, format_hex(CBPTR(src), BLEN(src=
), 80, &amp;gc));</span><br><span> </span><br><span>     if (BLENZ(src) &lt=
; TLS_CRYPT_OFF_CT)</span><br><span>     {</span><br><span>@@ -237,11 +237,=
11 @@</span><br><span>             CRYPT_ERROR(&quot;potential buffer overf=
low&quot;);</span><br><span>         }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (!cipher_ctx_reset(ctx-&gt;ci=
pher, BPTR(src) + TLS_CRYPT_OFF_TAG))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (!cipher_ctx_reset(ctx-&gt;cipher, CBPTR(src) =
+ TLS_CRYPT_OFF_TAG))</span><br><span>         {</span><br><span>          =
   CRYPT_ERROR(&quot;cipher reset failed&quot;);</span><br><span>         }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!cipher_c=
tx_update(ctx-&gt;cipher, BPTR(dst), &amp;outlen, BPTR(src) + TLS_CRYPT_OFF=
_CT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ci=
pher_ctx_update(ctx-&gt;cipher, BPTR(dst), &amp;outlen, CBPTR(src) + TLS_CR=
YPT_OFF_CT,</span><br><span>                                BLEN(src) - (in=
t)TLS_CRYPT_OFF_CT))</span><br><span>         {</span><br><span>           =
  CRYPT_ERROR(&quot;cipher update failed&quot;);</span><br><span>@@ -256,17=
 +256,17 @@</span><br><span> </span><br><span>     /* Check authentication =
*/</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        const uint8_t *tag =3D BPTR(src) + TLS_CRYPT_OFF_TAG;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        const uint8_t *tag =
=3D CBPTR(src) + TLS_CRYPT_OFF_TAG;</span><br><span>         uint8_t tag_ch=
eck[TLS_CRYPT_TAG_SIZE] =3D { 0 };</span><br><span> </span><br><span>      =
   dmsg(D_PACKET_CONTENT, &quot;TLS-CRYPT UNWRAP AD: %s&quot;,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-             format_hex(BPTR(src),=
 TLS_CRYPT_OFF_TAG, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+             format_hex(CBPTR(src), TLS_CRYPT_OFF_TAG, 0, &am=
p;gc));</span><br><span>         dmsg(D_PACKET_CONTENT, &quot;TLS-CRYPT UNW=
RAP TO: %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
         format_hex(BPTR(dst), BLEN(dst), 80, &amp;gc));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+             format_hex(CBPTR(dst), BL=
EN(dst), 80, &amp;gc));</span><br><span> </span><br><span>         hmac_ctx=
_reset(ctx-&gt;hmac);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        hmac_ctx_update(ctx-&gt;hmac, BPTR(src), TLS_CRYPT_OFF_TAG);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        hmac_ctx_update(ctx-=
&gt;hmac, BPTR(dst), BLEN(dst));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        hmac_ctx_update(ctx-&gt;hmac, CBPTR(src), TLS_CRYPT_OF=
F_TAG);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hmac=
_ctx_update(ctx-&gt;hmac, CBPTR(dst), BLEN(dst));</span><br><span>         =
hmac_ctx_final(ctx-&gt;hmac, tag_check);</span><br><span> </span><br><span>=
         if (memcmp_constant_time(tag, tag_check, sizeof(tag_check)))</span=
><br><span>@@ -384,7 +384,7 @@</span><br><span>     hmac_ctx_reset(hmac_ctx=
);</span><br><span>     hmac_ctx_update(hmac_ctx, (void *)&amp;net_len, siz=
eof(net_len));</span><br><span>     hmac_ctx_update(hmac_ctx, (void *)src_k=
ey-&gt;keys, sizeof(src_key-&gt;keys));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    hmac_ctx_update(hmac_ctx, BPTR(src_metadata), BLEN(sr=
c_metadata));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hm=
ac_ctx_update(hmac_ctx, CBPTR(src_metadata), BLEN(src_metadata));</span><br=
><span>     hmac_ctx_final(hmac_ctx, tag);</span><br><span> </span><br><spa=
n>     dmsg(D_CRYPTO_DEBUG, &quot;TLS-CRYPT WRAP TAG: %s&quot;, format_hex(=
tag, TLS_CRYPT_TAG_SIZE, 0, gc));</span><br><span>@@ -405,7 +405,7 @@</span=
><br><span>     ASSERT(cipher_ctx_update(cipher_ctx, BEND(&amp;work), &amp;=
outlen, (void *)src_key-&gt;keys,</span><br><span>                         =
     sizeof(src_key-&gt;keys)));</span><br><span>     ASSERT(buf_inc_len(&a=
mp;work, outlen));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 ASSERT(cipher_ctx_update(cipher_ctx, BEND(&amp;work), &amp;outlen, BPTR(sr=
c_metadata),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASS=
ERT(cipher_ctx_update(cipher_ctx, BEND(&amp;work), &amp;outlen, CBPTR(src_m=
etadata),</span><br><span>                              BLEN(src_metadata))=
);</span><br><span>     ASSERT(buf_inc_len(&amp;work, outlen));</span><br><=
span>     ASSERT(cipher_ctx_final(cipher_ctx, BEND(&amp;work), &amp;outlen)=
);</span><br><span>@@ -529,7 +529,7 @@</span><br><span>         return fals=
e;</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    const uint8_t *metadata =3D buf_bptr(tls_crypt_v2=
_metadata);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t uint8_t *metadata =3D CBPTR(tls_crypt_v2_metadata);</span><br><span>     =
if (*metadata !=3D TLS_CRYPT_METADATA_TYPE_TIMESTAMP)</span><br><span>     =
{</span><br><span>         msg(M_WARN, &quot;ERROR: Client key does not hav=
e a timestamp=2E&quot;);</span><br><span>diff --git a/src/openvpn/tun=2Eh b=
/src/openvpn/tun=2Eh</span><br><span>index 931e54d=2E=2E2477560 100644</spa=
n><br><span>--- a/src/openvpn/tun=2Eh</span><br><span>+++ b/src/openvpn/tun=
=2Eh</span><br><span>@@ -504,7 +504,7 @@</span><br><span> static inline boo=
l</span><br><span> is_ip_packet_valid(const struct buffer *buf)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const stru=
ct openvpn_iphdr *ih =3D (const struct openvpn_iphdr *)BPTR(buf);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const struct openvpn_iphd=
r *ih =3D (const struct openvpn_iphdr *)CBPTR(buf);</span><br><span> </span=
><br><span>     if (OPENVPN_IPH_GET_VER(ih-&gt;version_len) =3D=3D 4)</span=
><br><span>     {</span><br><span>diff --git a/src/openvpn/vlan=2Ec b/src/o=
penvpn/vlan=2Ec</span><br><span>index bffc60e=2E=2E69ac10d 100644</span><br=
><span>--- a/src/openvpn/vlan=2Ec</span><br><span>+++ b/src/openvpn/vlan=2E=
c</span><br><span>@@ -269,7 +269,7 @@</span><br><span>         return false=
;</span><br><span>     }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    vlanhdr =3D (const struct openvpn_8021qhdr *)BPTR(=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    vlanhdr =
=3D (const struct openvpn_8021qhdr *)CBPTR(buf);</span><br><span> </span><b=
r><span>     if (ntohs(vlanhdr-&gt;tpid) !=3D OPENVPN_ETH_P_8021Q)</span><b=
r><span>     {</span><br><span>diff --git a/tests/unit_tests/openvpn/test_b=
uffer=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>index =
7fb9162=2E=2E7bd0c45 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_buffer=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_buffer=
=2Ec</span><br><span>@@ -51,7 +51,7 @@</span><br><span> </span><br><span> #=
define assert_buf_equals_str(buf, str)        \</span><br><span>     assert=
_int_equal(BLENZ(buf), strlen(str)); \</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    assert_memory_equal(BPTR(buf), str, BLENZ(buf));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(C=
BPTR(buf), str, BLENZ(buf));</span><br><span> </span><br><span> static void=
</span><br><span> test_buffer_printf_catrunc(void **state)</span><br><span>=
diff --git a/tests/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests=
/openvpn/test_tls_crypt=2Ec</span><br><span>index db03437=2E=2Ef648e13 1006=
44</span><br><span>--- a/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span>=
<br><span>+++ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span=
>@@ -130,7 +130,7 @@</span><br><span> bool</span><br><span> __wrap_buffer_w=
rite_file(const char *filename, const struct buffer *buf)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *pem =
=3D BSTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *pem =3D CBSTR(buf);</span><br><span>     check_expected_ptr(file=
name);</span><br><span>     check_expected_ptr(pem);</span><br><span> </spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1904?usp=3Demail">change 1904</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib4af7639cdebe81eba0=
5ab04efe6e85e63de0f9e </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1904 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>

</body></html>
--ABMSwPG1PPs=--


--===============4368254537160204289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4368254537160204289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4368254537160204289==--

