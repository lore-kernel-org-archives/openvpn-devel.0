Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E7BC88E4D
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fxhw9d2FXcutfl5PDph1MtJ9zm8nWD7YgkzlWU5O/QM=; b=kl2Mk1vFTatXtDZEQz9mWTvLFA
	L7abMkEnGgWzoI1lKQ+YAx/X5/naJP1YZPojjNTLsqrHD52pCzkgxOKzdakIQqgfZUlAqlWNasqk4
	7k2HCzVpAI2pHPRatohtCPAx+6inNSyrIdRifZFALrNEeqwgzKy1GhPVhVzFU1kEeyY0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x516c-00072I-RL;
	Fri, 11 Sep 2026 13:15:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x516b-000722-6k
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 13:15:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=CZYvwT8+WY0Vxf3k1cX55cXLFl0MHtY5yYTu1rfUDpc=; b=dTlVllX7BkY9d82TMjeK7v7guZ
 KvrBIqGyxQG+WWZl21rNJ/Nph1BuHsnCfYHLrbdMH7OfG68gtPTSycC6+haUFz4Unq0Eoa+6IXUhP
 bHy92KsSHnxIt+NROmOkylTesjKtB6GL8okR3N75SjukH2KCobjyol5HtXJ35134ApP8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CZYvwT8+WY0Vxf3k1cX55cXLFl0MHtY5yYTu1rfUDpc=; b=G
 uSd6IPdG8w0WFy7z9ohwipc2q1K3Ln08OPwKD5+BZCUF3WkIJU+1r0oAfOwdl+OlYRJ02K+cEvp7D
 tloGbHRYvo+CklCguMJiw2X+uvCeDs8Z+8Wv7fnEyzI63SwLtRg1wdxK1IdN5teD0HM2Iq5gVEYMn
 XmpIPFDh+MlCYGUI=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x516X-0005Fr-8x for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 13:15:49 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4956869750eso8248675e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 06:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789132539; x=1789737339; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CZYvwT8+WY0Vxf3k1cX55cXLFl0MHtY5yYTu1rfUDpc=;
 b=g79WsBWVvuwe59X9ZcFFr4L+zqE0zFoaVSyS5WPiPfDPth6KxdrJGdWXUBAlDLVnx6
 9vlhZI9bw6Ryh95G3b9QmhYStGrJ2bfy7SdR6saXgzTJwTPEVeWT+1AVciiVCfzgWSWk
 YtoaSdreMxzd+VGgqIGgDVj5rgkEdp4xJM1/HsKzqRP3M8NoEzztyfk+xN79KQppTGOU
 iOn7V70gU1kmogmt5/+4OWQkVHAoYjr/9228TGEj34cEI2IsMc0m+oRCL4MBj2SN5ecd
 rDh7JR/O3yP4jMBuEffr+Kaql8nrfgGvWV5gCWHC7iJzghclrwgGZBZ0AOdqJot8HVlU
 rWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789132539; x=1789737339;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CZYvwT8+WY0Vxf3k1cX55cXLFl0MHtY5yYTu1rfUDpc=;
 b=oiCQwPvtgKNWcHqNVML/Sdjx/mgkMzQYDXhiwB1YJllOAoLHtEiT2k4m1X9mTAX3n3
 +tfsAzntziSLStXjnrRID5PYbDr2m8PkYzDa9nOHz30gvI601us+0rCB+AD2kxK+bPLV
 AZUwKpgcp4jPUreE/ypIdS3S6ffrHNR/KznetxuPfclwGiLuD1xw/iaUk8nfjfzK+3m2
 e/9VBv4qLWYtcj9yZLc4UHIWQRF4ZJ9X98KHDJKgjr1lkqkSXjeJe8MFNgur1iUSwf7A
 045XT8lVXNb9FB21ueAQJVjTCQvhtxGRexhWfXhLTJ1L0VhBKM1McUjqvKaHXhpXm+fW
 esvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx82pvjxtiuXolGdClE7rUQjmbxOxLXUmBkkRlqRiZx9YrONXkqcQ6EaRlgOIXqwQePwHu3D5g5ojX1Y8cY@lists.sourceforge.net
X-Gm-Message-State: AFuF++kNJeL0Vr16uFXVnG+Q/6WCwjbc1msVs8upcPYgrTsQlJC1VAmd
 8TkzJeoG0++reZ5LdUQDTtio7DgBZhe2GDf9pl9ruY2ii9uVMSqVBQeoYaicsnbmQ7jwvwhCzTb
 mnPbR2foU8/tc0jzE5tyCuoOkFyJvXB3V8jSkLZdOnb/DC/PqCbkw8+vh1YeERQbBiiMM
X-Gm-Gg: AYBFou30qkpFlkluYgucagTSLMvVnIdQy/dhgmTFWau3I6p8OA9hfJXDHru0hG6s0hK
 NrlyghN/z3rbivdtBl1gf1Bukc7GI291OAE9Vu4+lY916xdcqbi/dBn4XXcukHJpg65slm0J+Fx
 xBBj0augdiuwmb7oXCnXbuWoAHzZb0fSc0qor1GcU264hZ6PGQDYmK6hNedbwiUYKHS/JEI4TQx
 tz/+dSPAWL1bmKI5pC5mLCe34JkJxp5MxlmSvyh/Q6JWW1rmjBBz2vcwVViwb5PdsenMnal1uRg
 xnQnsOQ2jV04GhB9GBnGgV+yY3asbW+oMw/Yw2cEJmJKuiwEVB1+Mz4xrPcLCDO4D0zf5LVJkfR
 hyLGfVDSi8M0NsafWBtmCb7px4G7RaNyLE1UuD3xImHmmzrQuBF/p8bTHdgsiT3PvHPlA7Fnm/k
 QaHWESDOLeyKys9oodO3+EL+TDOFaS/mFAYBVg5jz7hHoNClISeZYXn4YEPslwdM69iCJ7lCBAw
 MsKrh8/Mash7FzYUiZ8Ds3PGRaDJh+C0PjBkJXMPZpKXw/ncEqIu70gc1yCMAdDnFpR2+z+l+5J
 PPO+0jZFOOk0USPlAh9hiYrLMeFUhS5wBcdu0ESpuBb1HXAT2GEpzwGJcyzsLg==
X-Received: by 2002:a05:600c:c16b:b0:49e:69f8:e846 with SMTP id
 5b1f17b1804b1-49e69f8e888mr4160315e9.9.1789132538076; 
 Fri, 11 Sep 2026 06:15:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26d4e3f3sm170009995e9.15.2026.09.11.06.15.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 06:15:37 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 13:15:34 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e
X-Gerrit-Change-Number: 1904
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1904?usp=email>
X-Gerrit-Commit: 8126032d14b9fbf864424f8c4982da147220beec
In-Reply-To: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
References: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODE1MDM1MDAwLkliNGFmNzYzOWNkZWJlODFlYmEwNWFiMDRlZmU2ZTg1ZTYzZGUwZjllQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d54f30e9ee216b72696acd3707be12e196f23599-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x516X-0005Fr-8x
Subject: [Openvpn-devel] [L] Change in openvpn[master]: buffer: When
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1607608940104962380=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1607608940104962380==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l0O4OFXsewk="; charset=UTF-8

--l0O4OFXsewk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

Hello plaistho=
s, 

I'd like you to reexamine a change=2E Please visit

    http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail

to look at the new patch set=
 (#4)=2E


Change subject: buffer: When extracting pointers from buffer, re=
tain const
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

b=
uffer: When extracting pointers from buffer, retain const

Currently you ca=
n use BPTR and similar to implicitly remove
const=2E That avoids some warni=
ngs that we should get and
confuses tools like cppcheck into giving wrong s=
uggestions=2E

So make sure that by default we only return a non-const
poin=
ter if the buffer pointer is not const=2E Change all call
sites that threw =
warnings=2E

Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e
Signed-of=
f-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/openvpn/buffer=
=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/crypto_backend=2Eh
M src/openvp=
n/crypto_mbedtls=2Ec
M src/openvpn/crypto_mbedtls_legacy=2Ec
M src/openvpn/=
crypto_openssl=2Ec
M src/openvpn/forward=2Ec
M src/openvpn/manage=2Ec
M src=
/openvpn/mroute=2Ec
M src/openvpn/proto=2Eh
M src/openvpn/ps=2Ec
M src/open=
vpn/push=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
M src/openvp=
n/ssl_pkt=2Ec
M src/openvpn/ssl_verify=2Ec
M src/openvpn/tls_crypt=2Ec
M sr=
c/openvpn/tun=2Eh
M src/openvpn/vlan=2Ec
M tests/unit_tests/openvpn/test_bu=
ffer=2Ec
M tests/unit_tests/openvpn/test_tls_crypt=2Ec
21 files changed, 16=
5 insertions(+), 98 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/04/1904/4

diff --git a/src/openvpn/buffer=2Ec b=
/src/openvpn/buffer=2Ec
index 5d00415=2E=2E21e113d 100644
--- a/src/openvpn=
/buffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -109,7 +109,7 @@
 #endif
     r=
et=2Edata =3D (uint8_t *)malloc(buf->capacity);
     check_malloc_return(re=
t=2Edata);
-    memcpy(BPTR(&ret), BPTR(buf), BLENZ(buf));
+    memcpy(BPTR=
(&ret), CBPTR(buf), BLENZ(buf));
     return ret;
 }
 
@@ -162,7 +162,7 @@
=
     {
         return false;
     }
-    return buf_write(dest, BPTR(src),=
 BLENZ(src));
+    return buf_write(dest, CBPTR(src), BLENZ(src));
 }
 
 vo=
id
@@ -293,7 +293,7 @@
         return false;
     }
 
-    const ssize_t s=
ize =3D write(fd, BPTR(buf), (unsigned int)BLEN(buf));
+    const ssize_t s=
ize =3D write(fd, CBPTR(buf), (unsigned int)BLEN(buf));
     if (size !=3D =
BLEN(buf))
     {
         msg(M_ERRNO, "Write error on file '%s'", filenam=
e);
@@ -732,7 +732,7 @@
     {
         return false;
     }
-    return me=
mcmp(BPTR(src), match, size) =3D=3D 0;
+    return memcmp(CBPTR(src), match=
, size) =3D=3D 0;
 }
 
 bool
@@ -1035,13 +1035,13 @@
 }
 
 bool
-string_che=
ck_buf(struct buffer *buf, const unsigned int inclusive, const unsigned int=
 exclusive)
+string_check_buf(const struct buffer *buf, const unsigned int =
inclusive, const unsigned int exclusive)
 {
     ASSERT(buf);
 
     for (i=
nt i =3D 0; i < BLEN(buf); i++)
     {
-        char c =3D BSTR(buf)[i];
+ =
       char c =3D CBSTR(buf)[i];
 
         if (!char_inc_exc(c, inclusive,=
 exclusive))
         {
@@ -1135,7 +1135,7 @@
     if (buf && buf->len)
   =
  {
         msglvl_t msglevel =3D D_ALIGN_DEBUG;
-        const uintptr_t =
u =3D (uintptr_t)BPTR(buf);
+        const uintptr_t u =3D (uintptr_t)CBPTR=
(buf);
 
         if (u & (PAYLOAD_ALIGN - 1))
         {
@@ -1393,16 +1393=
,16 @@
         return NULL;
     }
 
-    const uint8_t *seppos =3D memchr=
(BPTR(buf), sep, buf_len(buf));
+    const uint8_t *seppos =3D memchr(CBPTR=
(buf), sep, buf_len(buf));
     if (!seppos)
     {
         return NULL;
 =
    }
-    size_t field_len =3D seppos - BPTR(buf);
+    size_t field_len =
=3D seppos - CBPTR(buf);
 
     char *field =3D gc_malloc(field_len + 1, fa=
lse, gc);
 
-    memcpy(field, BPTR(buf), field_len);
+    memcpy(field, CB=
PTR(buf), field_len);
     field[field_len] =3D 0;
 
     buf_advance(buf, =
field_len + 1);
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2E=
h
index 0a02e94=2E=2E22a8b74 100644
--- a/src/openvpn/buffer=2Eh
+++ b/src/=
openvpn/buffer=2Eh
@@ -136,21 +136,29 @@
 
 
 /** Return a pointer to the s=
tart of the buffer content=2E @see buf_bptr() */
-#define BPTR(buf)  (buf_b=
ptr(buf))
+#define BPTR(buf)   (buf_bptr(buf))
+/** Return a const pointer =
to the start of the buffer content=2E @see buf_cbptr() */
+#define CBPTR(bu=
f)  (buf_cbptr(buf))
 /** Return a pointer one past the end of the buffer c=
ontent=2E @see buf_bend() */
-#define BEND(buf)  (buf_bend(buf))
+#define B=
END(buf)   (buf_bend(buf))
+/** Return a const pointer one past the end of =
the buffer content=2E @see buf_cbend() */
+#define CBEND(buf)  (buf_cbend(b=
uf))
 /** Return a pointer to the last byte of the buffer content, or NULL =
if empty=2E @see buf_blast() */
-#define BLAST(buf) (buf_blast(buf))
+#defi=
ne BLAST(buf)  (buf_blast(buf))
+/** Return a const pointer to the last byt=
e of the buffer content, or NULL if empty=2E @see buf_cblast() */
+#define =
CBLAST(buf) (buf_cblast(buf))
 /** Return the length of the buffer content =
in bytes=2E @see buf_len() */
-#define BLEN(buf)  (buf_len(buf))
+#define B=
LEN(buf)   (buf_len(buf))
 /** Return the length of the buffer content as a=
 \c size_t=2E @see buf_len() */
-#define BLENZ(buf) ((size_t)buf_len(buf))
=
+#define BLENZ(buf)  ((size_t)buf_len(buf))
 /** Return true iff the buffer=
 is defined (has non-NULL data pointer)=2E @see buf_defined() */
-#define B=
DEF(buf)  (buf_defined(buf))
+#define BDEF(buf)   (buf_defined(buf))
 /** R=
eturn the buffer content pointer cast to \c char *=2E @see buf_str() */
-#d=
efine BSTR(buf)  (buf_str(buf))
+#define BSTR(buf)   (buf_str(buf))
+/** Re=
turn the buffer content pointer cast to \c const char *=2E @see buf_cstr() =
*/
+#define CBSTR(buf)  (buf_cstr(buf))
 /** Return the number of bytes ava=
ilable for appending to the buffer=2E @see buf_forward_capacity() */
-#defi=
ne BCAP(buf)  (buf_forward_capacity(buf))
+#define BCAP(buf)   (buf_forward=
_capacity(buf))
 
 /**
  * Zeroise and reset a buffer=2E
@@ -407,15 +415,15=
 @@
 }
 
 /**
- * Return a pointer to the start of the buffer content=2E
+ =
* Return a const pointer to the start of the buffer content=2E
  *
  * @par=
am buf   The buffer to query=2E
  *
  * @return Pointer to \c buf->data + \=
c buf->offset, or NULL if \c buf is
  *         not valid=2E
  */
-static i=
nline uint8_t *
-buf_bptr(const struct buffer *buf)
+static inline const ui=
nt8_t *
+buf_cbptr(const struct buffer *buf)
 {
     if (buf_valid(buf))
  =
   {
@@ -428,6 +436,20 @@
 }
 
 /**
+ * Return a pointer to the start of th=
e buffer content=2E
+ *
+ * @param buf   The buffer to query=2E
+ *
+ * @re=
turn Pointer to \c buf->data + \c buf->offset, or NULL if \c buf is
+ *    =
     not valid=2E
+ */
+static inline uint8_t *
+buf_bptr(struct buffer *bu=
f)
+{
+    return (uint8_t *)buf_cbptr(buf);
+}
+
+/**
  * Return the lengt=
h of the buffer content=2E
  *
  * @param buf   The buffer to query=2E
@@ -=
455,12 +477,46 @@
  * @return Pointer to the byte immediately after the las=
t content byte=2E
  */
 static inline uint8_t *
-buf_bend(const struct buff=
er *buf)
+buf_bend(struct buffer *buf)
 {
     return buf_bptr(buf) + buf_l=
en(buf);
 }
 
 /**
+ * Return a const pointer one past the end of the buffe=
r content=2E
+ *
+ * @param buf   The buffer to query=2E
+ *
+ * @return Po=
inter to the byte immediately after the last content byte=2E
+ */
+static i=
nline const uint8_t *
+buf_cbend(const struct buffer *buf)
+{
+    return b=
uf_cbptr(buf) + buf_len(buf);
+}
+
+/**
+ * Return a const pointer to the l=
ast byte of the buffer content=2E
+ *
+ * @param buf   The buffer to query=
=2E
+ *
+ * @return Pointer to the last byte, or NULL if the buffer is empt=
y or
+ *         invalid=2E
+ */
+static inline const uint8_t *
+buf_cblast=
(const struct buffer *buf)
+{
+    if (buf_len(buf) > 0)
+    {
+        re=
turn buf_cbptr(buf) + buf_len(buf) - 1;
+    }
+    else
+    {
+        re=
turn NULL;
+    }
+}
+
+/**
  * Return a pointer to the last byte of the bu=
ffer content=2E
  *
  * @param buf   The buffer to query=2E
@@ -469,16 +525=
,9 @@
  *         invalid=2E
  */
 static inline uint8_t *
-buf_blast(const=
 struct buffer *buf)
+buf_blast(struct buffer *buf)
 {
-    if (buf_len(buf=
) > 0)
-    {
-        return buf_bptr(buf) + buf_len(buf) - 1;
-    }
-   =
 else
-    {
-        return NULL;
-    }
+    return (uint8_t *)buf_cblast=
(buf);
 }
 
 /**
@@ -518,12 +567,25 @@
  * @return The content pointer as a=
 \c char *, or NULL if \c buf is invalid=2E
  */
 static inline char *
-buf=
_str(const struct buffer *buf)
+buf_str(struct buffer *buf)
 {
     return =
(char *)buf_bptr(buf);
 }
 
 /**
+ * Return the buffer content pointer cast=
 to \c const char *=2E
+ *
+ * @param buf   The buffer to query=2E
+ *
+ * =
@return The content pointer as a \c const char *, or NULL if \c buf is inva=
lid=2E
+ */
+static inline const char *
+buf_cstr(const struct buffer *buf)=

+{
+    return (const char *)buf_cbptr(buf);
+}
+
+/**
  * Reset a buffer =
to an undefined (unallocated) state=2E
  *
  * Sets all fields to zero/NULL=
 without freeing any memory=2E  Use \c free_buf()
@@ -1300,7 +1362,7 @@
 st=
atic inline bool
 buf_copy(struct buffer *dest, const struct buffer *src)
 =
{
-    return buf_write(dest, BPTR(src), BLENZ(src));
+    return buf_write=
(dest, CBPTR(src), BLENZ(src));
 }
 
 /**
@@ -1427,14 +1489,14 @@
  *      =
   is empty=2E
  */
 static inline int
-buf_peek_u8(struct buffer *buf)
+bu=
f_peek_u8(const struct buffer *buf)
 {
     int ret;
     if (BLEN(buf) < 1=
)
     {
         return -1;
     }
-    ret =3D *BPTR(buf);
+    ret =3D *=
CBPTR(buf);
     return ret;
 }
 
@@ -1547,7 +1609,7 @@
 static inline bool=

 buf_equal(const struct buffer *a, const struct buffer *b)
 {
-    return =
BLEN(a) =3D=3D BLEN(b) && 0 =3D=3D memcmp(BPTR(a), BPTR(b), BLENZ(a));
+   =
 return BLEN(a) =3D=3D BLEN(b) && 0 =3D=3D memcmp(CBPTR(a), CBPTR(b), BLENZ=
(a));
 }
 
 /**
@@ -1561,7 +1623,7 @@
     {
         return false;
     }
=
-    return memcmp(BPTR(src), match, size) =3D=3D 0;
+    return memcmp(CBP=
TR(src), match, size) =3D=3D 0;
 }
 
 /**
@@ -1575,7 +1637,7 @@
     {
    =
     return false;
     }
-    return memcmp(BPTR(src), match, size) =3D=3D=
 0;
+    return memcmp(CBPTR(src), match, size) =3D=3D 0;
 }
 
 /**
@@ -172=
0,7 +1782,7 @@
  * @param exclusive Character classes that are not allowed =
even if they are also in inclusive=2E
  * @return True if the string consis=
ts only of allowed characters, false otherwise=2E
  */
-bool string_check_b=
uf(struct buffer *buf, const unsigned int inclusive,
+bool string_check_buf=
(const struct buffer *buf, const unsigned int inclusive,
                  =
     const unsigned int exclusive);
 
 /**
diff --git a/src/openvpn/crypto_=
backend=2Eh b/src/openvpn/crypto_backend=2Eh
index 17085d6=2E=2E7ef6ac4 100=
644
--- a/src/openvpn/crypto_backend=2Eh
+++ b/src/openvpn/crypto_backend=
=2Eh
@@ -445,7 +445,7 @@
  *
  * @return              \c 0 on failure, \c 1=
 on success=2E
  */
-int cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst,=
 int *dst_len, uint8_t *src, int src_len);
+int cipher_ctx_update(cipher_ct=
x_t *ctx, uint8_t *dst, int *dst_len, const uint8_t *src, int src_len);
 
 =
/**
  * Pads the final cipher block using PKCS padding, and output to the d=
estination
diff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto=
_mbedtls=2Ec
index 6662def=2E=2E0c5beb4 100644
--- a/src/openvpn/crypto_mbe=
dtls=2Ec
+++ b/src/openvpn/crypto_mbedtls=2Ec
@@ -512,7 +512,7 @@
 }
 
 int=

-cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, uint8_t =
*src, int src_len)
+cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int =
*dst_len, const uint8_t *src, int src_len)
 {
     if (src_len < 0)
     {
=
@@ -1093,7 +1093,7 @@
 
     size_t out_len =3D 0;
     if (MBEDTLS_ERR_BAS=
E64_BUFFER_TOO_SMALL
-        !=3D mbedtls_pem_write_buffer(header, footer,=
 BPTR(src), BLEN(src), NULL, 0, &out_len))
+        !=3D mbedtls_pem_write_=
buffer(header, footer, CBPTR(src), BLEN(src), NULL, 0, &out_len))
     {
  =
       return false;
     }
@@ -1101,7 +1101,7 @@
     /* We set the size b=
uf to out_len-1 to NOT include the 0 byte that
      * mbedtls_pem_write_bu=
ffer in its length calculation */
     *dst =3D alloc_buf_gc(out_len, gc);
=
-    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(=
src), BPTR(dst),
+    if (!mbed_ok(mbedtls_pem_write_buffer(header, footer,=
 CBPTR(src), BLEN(src), BPTR(dst),
                                        =
   BCAP(dst), &out_len))
         || !(out_len < INT_MAX && out_len > 1)
  =
       || !buf_inc_len(dst, (int)out_len - 1))
diff --git a/src/openvpn/cry=
pto_mbedtls_legacy=2Ec b/src/openvpn/crypto_mbedtls_legacy=2Ec
index 9e47c2=
6=2E=2Ebbd012f6 100644
--- a/src/openvpn/crypto_mbedtls_legacy=2Ec
+++ b/sr=
c/openvpn/crypto_mbedtls_legacy=2Ec
@@ -249,7 +249,7 @@
 
     size_t out_l=
en =3D 0;
     if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL
-        !=3D mbedtl=
s_pem_write_buffer(header, footer, BPTR(src), BLEN(src), NULL, 0, &out_len)=
)
+        !=3D mbedtls_pem_write_buffer(header, footer, CBPTR(src), BLEN(s=
rc), NULL, 0, &out_len))
     {
         return false;
     }
@@ -257,7 +25=
7,7 @@
     /* We set the size buf to out_len-1 to NOT include the 0 byte t=
hat
      * mbedtls_pem_write_buffer in its length calculation */
     *dst=
 =3D alloc_buf_gc(out_len, gc);
-    if (!mbed_ok(mbedtls_pem_write_buffer(=
header, footer, BPTR(src), BLEN(src), BPTR(dst),
+    if (!mbed_ok(mbedtls_=
pem_write_buffer(header, footer, CBPTR(src), BLEN(src), BPTR(dst),
        =
                                   BCAP(dst), &out_len))
         || !buf_i=
nc_len(dst, out_len - 1))
     {
@@ -684,7 +684,7 @@
 }
 
 int
-cipher_ctx_=
update(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len, uint8_t *=
src,
+cipher_ctx_update(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *d=
st_len, const uint8_t *src,
                   int src_len)
 {
     size_t =
s_dst_len =3D *dst_len;
diff --git a/src/openvpn/crypto_openssl=2Ec b/src/o=
penvpn/crypto_openssl=2Ec
index 2019280=2E=2E29c5fa6 100644
--- a/src/openv=
pn/crypto_openssl=2Ec
+++ b/src/openvpn/crypto_openssl=2Ec
@@ -465,7 +465,7=
 @@
 {
     bool ret =3D false;
     BIO *bio =3D BIO_new(BIO_s_mem());
-  =
  if (!bio || !PEM_write_bio(bio, name, "", BPTR(src), BLEN(src)))
+    if =
(!bio || !PEM_write_bio(bio, name, "", CBPTR(src), BLEN(src)))
     {
     =
    ret =3D false;
         goto cleanup;
@@ -492,7 +492,7 @@
 {
     bool =
ret =3D false;
 
-    BIO *bio =3D BIO_new_mem_buf((char *)BPTR(src), BLEN(=
src));
+    BIO *bio =3D BIO_new_mem_buf(CBPTR(src), BLEN(src));
     if (!=
bio)
     {
         crypto_msg(M_FATAL, "Cannot open memory BIO for PEM de=
code");
@@ -941,7 +941,7 @@
 }
 
 int
-cipher_ctx_update(EVP_CIPHER_CTX *ct=
x, uint8_t *dst, int *dst_len, uint8_t *src, int src_len)
+cipher_ctx_updat=
e(EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len, const uint8_t *src, int =
src_len)
 {
     if (!EVP_CipherUpdate(ctx, dst, dst_len, src, src_len))
  =
   {
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 2=
ade321=2E=2Ead43d40 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/=
forward=2Ec
@@ -271,7 +271,7 @@
     }
     else
     {
-        msg(D_PUSH=
_ERRORS, "WARNING: Received unknown control message: %s", BSTR(buf));
+    =
    msg(D_PUSH_ERRORS, "WARNING: Received unknown control message: %s", CBS=
TR(buf));
     }
 }
 
@@ -1646,7 +1646,7 @@
             return;
         }=

 
-        const struct openvpn_ethhdr *orig_ethhdr =3D (struct openvpn_et=
hhdr *)BPTR(buf);
+        const struct openvpn_ethhdr *orig_ethhdr =3D (co=
nst struct openvpn_ethhdr *)CBPTR(buf);
 
         /* Copy frametype and re=
verse source/destination for the response */
         struct openvpn_ethhdr=
 ethhdr;
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index=
 310d2e1=2E=2Ec301687 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn=
/manage=2Ec
@@ -2278,7 +2278,7 @@
 
 #ifdef TARGET_ANDROID
 static ssize_t
=
-man_send_with_fd(int fd, void *ptr, size_t nbytes, int flags, int sendfd)
=
+man_send_with_fd(int fd, const void *ptr, size_t nbytes, int flags, int se=
ndfd)
 {
     struct msghdr msg =3D { 0 };
     struct iovec iov[1];
@@ -23=
02,12 +2302,14 @@
     msg=2Emsg_name =3D NULL;
     msg=2Emsg_namelen =3D =
0;
 
-    iov[0]=2Eiov_base =3D ptr;
+    /* sendmsg takes a const msghdr, =
but we can't construct that here
+       directly, so cast */
+    iov[0]=
=2Eiov_base =3D (void *)ptr;
     iov[0]=2Eiov_len =3D nbytes;
     msg=2Em=
sg_iov =3D iov;
     msg=2Emsg_iovlen =3D 1;
 
-    return (sendmsg(fd, &ms=
g, flags));
+    return sendmsg(fd, &msg, flags);
 }
 
 static ssize_t
@@ -=
2512,24 +2514,23 @@
 {
     const int size_hint =3D 1024;
     ssize_t sent=
 =3D 0;
-    const struct buffer *buf;
 
     buffer_list_aggregate(man->co=
nnection=2Eout, size_hint);
-    buf =3D buffer_list_peek(man->connection=
=2Eout);
+    const struct buffer *buf =3D buffer_list_peek(man->connection=
=2Eout);
     if (buf && BLEN(buf))
     {
         const int len =3D min_i=
nt(size_hint, BLEN(buf));
 #ifdef TARGET_ANDROID
         if (man->connecti=
on=2Efdtosend > 0)
         {
-            sent =3D man_send_with_fd(man->c=
onnection=2Esd_cli, BPTR(buf), len, MSG_NOSIGNAL,
+            sent =3D man=
_send_with_fd(man->connection=2Esd_cli, CBPTR(buf), len, MSG_NOSIGNAL,
    =
                                 man->connection=2Efdtosend);
             =
man->connection=2Efdtosend =3D -1;
         }
         else
 #endif
       =
  {
-            sent =3D send(man->connection=2Esd_cli, (const void *)BPTR=
(buf), len, MSG_NOSIGNAL);
+            sent =3D send(man->connection=2Esd_=
cli, CBSTR(buf), len, MSG_NOSIGNAL);
         }
         if (sent >=3D 0)
 =
        {
diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec
inde=
x edf8239=2E=2E39fa482 100644
--- a/src/openvpn/mroute=2Ec
+++ b/src/openvp=
n/mroute=2Ec
@@ -150,12 +150,12 @@
     unsigned int ret =3D 0;
     if (BL=
EN(buf) >=3D 1)
     {
-        switch (OPENVPN_IPH_GET_VER(*BPTR(buf)))
+ =
       switch (OPENVPN_IPH_GET_VER(*CBPTR(buf)))
         {
             ca=
se 4:
                 if (BLENZ(buf) >=3D sizeof(struct openvpn_iphdr))
  =
               {
-                    const struct openvpn_iphdr *ip =3D (c=
onst struct openvpn_iphdr *)BPTR(buf);
+                    const struct op=
envpn_iphdr *ip =3D (const struct openvpn_iphdr *)CBPTR(buf);
 
           =
          mroute_get_in_addr_t(src, ip->saddr);
                     mroute=
_get_in_addr_t(dest, ip->daddr);
@@ -179,7 +179,7 @@
             case 6:
 =
                if (BLENZ(buf) >=3D sizeof(struct openvpn_ipv6hdr))
       =
          {
-                    const struct openvpn_ipv6hdr *ipv6 =3D (co=
nst struct openvpn_ipv6hdr *)BPTR(buf);
+                    const struct o=
penvpn_ipv6hdr *ipv6 =3D (const struct openvpn_ipv6hdr *)CBPTR(buf);
 #if 0=
 /* very basic debug */
                     struct gc_arena gc =3D gc_new(=
);
                     msg( M_INFO, "IPv6 packet! src=3D%s, dst=3D%s",
@@ =
-202,7 +202,7 @@
 
             default:
                 msg(M_WARN, "IP p=
acket with unknown IP version=3D%d seen",
-                    OPENVPN_IPH_=
GET_VER(*BPTR(buf)));
+                    OPENVPN_IPH_GET_VER(*CBPTR(buf))=
);
         }
     }
     return ret;
@@ -226,7 +226,7 @@
     unsigned int=
 ret =3D 0;
     if (BLEN(buf) >=3D (int)sizeof(struct openvpn_ethhdr))
   =
  {
-        const struct openvpn_ethhdr *eth =3D (const struct openvpn_eth=
hdr *)BPTR(buf);
+        const struct openvpn_ethhdr *eth =3D (const struc=
t openvpn_ethhdr *)CBPTR(buf);
         if (src)
         {
             mr=
oute_copy_ether_to_addr(src, eth->source, vid);
diff --git a/src/openvpn/pr=
oto=2Eh b/src/openvpn/proto=2Eh
index 3570582=2E=2E9bb0866 100644
--- a/src=
/openvpn/proto=2Eh
+++ b/src/openvpn/proto=2Eh
@@ -258,7 +258,7 @@
        =
 *ip_hdr_offset =3D 0;
         if (likely(BLEN(buf) >=3D (int)sizeof(struc=
t openvpn_iphdr)))
         {
-            ip_ver =3D OPENVPN_IPH_GET_VER(*=
BPTR(buf));
+            ip_ver =3D OPENVPN_IPH_GET_VER(*CBPTR(buf));
     =
    }
     }
     else if (tunnel_type =3D=3D DEV_TYPE_TAP)
@@ -267,7 +267,=
7 @@
         /* for tap get ip version from eth header */
         if (lik=
ely(BLEN(buf) >=3D *ip_hdr_offset))
         {
-            const struct op=
envpn_ethhdr *eh =3D (const struct openvpn_ethhdr *)BPTR(buf);
+           =
 const struct openvpn_ethhdr *eh =3D (const struct openvpn_ethhdr *)CBPTR(b=
uf);
             uint16_t proto =3D ntohs(eh->proto);
             if (pro=
to =3D=3D OPENVPN_ETH_P_IPV6)
             {
diff --git a/src/openvpn/ps=2E=
c b/src/openvpn/ps=2Ec
index be91a99=2E=2E08c2673 100644
--- a/src/openvpn/=
ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -208,7 +208,9 @@
 
         if (head)
  =
       {
-            iov[1]=2Eiov_base =3D BPTR(head);
+            /* sen=
dmsg takes a const msghdr, but we can't construct that here
+              =
 directly, so cast */
+            iov[1]=2Eiov_base =3D (char *)CBPTR(head=
);
             iov[1]=2Eiov_len =3D BLENZ(head);
             mesg=2Emsg_i=
ovlen =3D 2;
         }
@@ -964,7 +966,7 @@
 bool
 is_openvpn_protocol(cons=
t struct buffer *buf)
 {
-    const unsigned char *p =3D (const unsigned ch=
ar *)BSTR(buf);
+    const unsigned char *p =3D (const unsigned char *)CBST=
R(buf);
     const int len =3D BLEN(buf);
     if (len >=3D 3)
     {
diff =
--git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index da2bb9f=2E=2E761a=
59e 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -47,7 +=
47,7 @@
 void
 receive_auth_failed(struct context *c, const struct buffer *=
buffer)
 {
-    msg(M_VERB0, "AUTH: Received control message: %s", BSTR(buf=
fer));
+    msg(M_VERB0, "AUTH: Received control message: %s", CBSTR(buffer=
));
     c->options=2Eno_advance =3D true;
 
     if (!c->options=2Epull)
@=
@ -64,7 +64,7 @@
     const char *reason =3D NULL;
     if (authfail_extend=
ed && BLEN(&buf))
     {
-        reason =3D BSTR(&buf);
+        reason =
=3D CBSTR(&buf);
     }
 
     if (authfail_extended && buf_string_match_he=
ad_str(&buf, "TEMP"))
@@ -116,7 +116,7 @@
      */
     if (authfail_extend=
ed && buf_string_match_head_str(&buf, "CRV1:") && BLEN(&buf))
     {
-     =
   ssl_put_auth_challenge(BSTR(&buf));
+        ssl_put_auth_challenge(CBST=
R(&buf));
     }
 #endif /* ifdef ENABLE_MANAGEMENT */
 }
@@ -508,7 +508,7 =
@@
     uint64_t option_types_found =3D 0;
 
     msg(D_PUSH, "PUSH: Receiv=
ed control message: '%s'",
-        sanitize_control_message(BSTR(buffer), =
&gc));
+        sanitize_control_message(CBSTR(buffer), &gc));
 
     int s=
tatus =3D process_incoming_push_msg(c, buffer, c->options=2Epull, pull_perm=
ission_mask(c),
                                            &option_types_f=
ound);
@@ -516,7 +516,7 @@
     if (status =3D=3D PUSH_MSG_ERROR)
     {
  =
       msg(D_PUSH_ERRORS, "WARNING: Received bad push/pull message: %s",
- =
           sanitize_control_message(BSTR(buffer), &gc));
+            sanit=
ize_control_message(CBSTR(buffer), &gc));
     }
     else if (status =3D=
=3D PUSH_MSG_REPLY || status =3D=3D PUSH_MSG_UPDATE
              || status=
 =3D=3D PUSH_MSG_CONTINUATION)
diff --git a/src/openvpn/socket=2Ec b/src/op=
envpn/socket=2Ec
index 7c6217a=2E=2E7f39268 100644
--- a/src/openvpn/socket=
=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -2446,7 +2446,9 @@
     struct cmsghdr=
 *cmsg;
     uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];
 
-    iov=2Eiov_base =
=3D BPTR(buf);
+    /* sendmsg takes a const msghdr, but we can't construct=
 that here
+       directly, so cast */
+    iov=2Eiov_base =3D (char *)CBP=
TR(buf);
     iov=2Eiov_len =3D BLENZ(buf);
     mesg=2Emsg_iov =3D &iov;
 =
    mesg=2Emsg_iovlen =3D 1;
diff --git a/src/openvpn/socket=2Eh b/src/open=
vpn/socket=2Eh
index 89465bc=2E=2Ec6a29f4 100644
--- a/src/openvpn/socket=
=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -709,14 +709,14 @@
     }
     else
 #=
endif
-        return sendto(sock->sd, BPTR(buf), BLENZ(buf), 0, (struct so=
ckaddr *)&to->dest=2Eaddr=2Esa,
+        return sendto(sock->sd, CBPTR(buf)=
, BLENZ(buf), 0, (struct sockaddr *)&to->dest=2Eaddr=2Esa,
                =
       (socklen_t)af_addr_size(to->dest=2Eaddr=2Esa=2Esa_family));
 }
 
 st=
atic inline ssize_t
 link_socket_write_tcp_posix(struct link_socket *sock, =
struct buffer *buf)
 {
-    return send(sock->sd, BPTR(buf), BLENZ(buf), MS=
G_NOSIGNAL);
+    return send(sock->sd, CBPTR(buf), BLENZ(buf), MSG_NOSIGNA=
L);
 }
 
 #endif /* ifdef _WIN32 */
@@ -761,7 +761,7 @@
 {
     if (sock &&=
 ipbuf)
     {
-        const struct openvpn_iphdr *iph =3D (struct openvpn=
_iphdr *)BPTR(ipbuf);
+        const struct openvpn_iphdr *iph =3D (const s=
truct openvpn_iphdr *)CBPTR(ipbuf);
         sock->ptos =3D iph->tos;
     =
    sock->ptos_defined =3D true;
     }
diff --git a/src/openvpn/ssl_pkt=2E=
c b/src/openvpn/ssl_pkt=2Ec
index 6a6d9f9=2E=2E90b2aec 100644
--- a/src/ope=
nvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -305,7 +305,7 @@
     }
 =

     /* get opcode and key ID */
-    uint8_t pkt_firstbyte =3D *BPTR(buf)=
;
+    uint8_t pkt_firstbyte =3D *CBPTR(buf);
     int op =3D pkt_firstbyte=
 >> P_OPCODE_SHIFT;
     int key_id =3D pkt_firstbyte & P_KEY_ID_MASK;
 
di=
ff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 06=
3fa5d=2E=2E3653eb4 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvp=
n/ssl_verify=2Ec
@@ -207,7 +207,7 @@
 
         struct cert_hash *ch =3D se=
ssion->cert_hash_set->ch[error_depth];
         ASSERT(sizeof(ch->sha256_ha=
sh) =3D=3D BLEN(cert_hash));
-        memcpy(ch->sha256_hash, BPTR(cert_has=
h), sizeof(ch->sha256_hash));
+        memcpy(ch->sha256_hash, CBPTR(cert_h=
ash), sizeof(ch->sha256_hash));
     }
 }
 
diff --git a/src/openvpn/tls_cr=
ypt=2Ec b/src/openvpn/tls_crypt=2Ec
index 47f5ac5=2E=2E23c7975 100644
--- a=
/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -148,7 +148,7=
 @@
 
     gc_init(&gc);
 
-    dmsg(D_PACKET_CONTENT, "TLS-CRYPT WRAP FROM=
: %s", format_hex(BPTR(src), BLEN(src), 80, &gc));
+    dmsg(D_PACKET_CONTE=
NT, "TLS-CRYPT WRAP FROM: %s", format_hex(CBPTR(src), BLEN(src), 80, &gc));=

 
     /* Get packet ID */
     if (!packet_id_write(&opt->packet_id=2Esen=
d, dst, true, false))
@@ -157,7 +157,7 @@
         goto err;
     }
 
-    =
dmsg(D_PACKET_CONTENT, "TLS-CRYPT WRAP AD: %s", format_hex(BPTR(dst), BLEN(=
dst), 0, &gc));
+    dmsg(D_PACKET_CONTENT, "TLS-CRYPT WRAP AD: %s", format=
_hex(CBPTR(dst), BLEN(dst), 0, &gc));
 
     /* Buffer overflow check */
  =
   if (!buf_safe(dst, BLENZ(src) + TLS_CRYPT_BLOCK_SIZE + TLS_CRYPT_TAG_SIZ=
E))
@@ -173,8 +173,8 @@
     {
         uint8_t *tag =3D NULL;
         hma=
c_ctx_reset(ctx->hmac);
-        hmac_ctx_update(ctx->hmac, BPTR(dst), BLEN=
(dst));
-        hmac_ctx_update(ctx->hmac, BPTR(src), BLEN(src));
+       =
 hmac_ctx_update(ctx->hmac, CBPTR(dst), BLEN(dst));
+        hmac_ctx_updat=
e(ctx->hmac, CBPTR(src), BLEN(src));
 
         ASSERT(tag =3D buf_write_al=
loc(dst, TLS_CRYPT_TAG_SIZE));
         hmac_ctx_final(ctx->hmac, tag);
@@ =
-189,7 +189,7 @@
     /* Encrypt src */
     {
         int outlen =3D 0;
-=
        ASSERT(cipher_ctx_update(ctx->cipher, BEND(dst), &outlen, BPTR(src)=
, BLEN(src)));
+        ASSERT(cipher_ctx_update(ctx->cipher, BEND(dst), &o=
utlen, CBPTR(src), BLEN(src)));
         ASSERT(buf_inc_len(dst, outlen));
=
         ASSERT(cipher_ctx_final(ctx->cipher, BPTR(dst), &outlen));
       =
  ASSERT(buf_inc_len(dst, outlen));
@@ -220,7 +220,7 @@
     ASSERT(ctx->ci=
pher);
     ASSERT(packet_id_initialized(&opt->packet_id) || (opt->flags & =
CO_IGNORE_PACKET_ID));
 
-    dmsg(D_PACKET_CONTENT, "TLS-CRYPT UNWRAP FROM=
: %s", format_hex(BPTR(src), BLEN(src), 80, &gc));
+    dmsg(D_PACKET_CONTE=
NT, "TLS-CRYPT UNWRAP FROM: %s", format_hex(CBPTR(src), BLEN(src), 80, &gc)=
);
 
     if (BLENZ(src) < TLS_CRYPT_OFF_CT)
     {
@@ -237,11 +237,11 @@
 =
            CRYPT_ERROR("potential buffer overflow");
         }
 
-       =
 if (!cipher_ctx_reset(ctx->cipher, BPTR(src) + TLS_CRYPT_OFF_TAG))
+      =
  if (!cipher_ctx_reset(ctx->cipher, CBPTR(src) + TLS_CRYPT_OFF_TAG))
     =
    {
             CRYPT_ERROR("cipher reset failed");
         }
-        =
if (!cipher_ctx_update(ctx->cipher, BPTR(dst), &outlen, BPTR(src) + TLS_CRY=
PT_OFF_CT,
+        if (!cipher_ctx_update(ctx->cipher, BPTR(dst), &outlen,=
 CBPTR(src) + TLS_CRYPT_OFF_CT,
                                BLEN(src) -=
 (int)TLS_CRYPT_OFF_CT))
         {
             CRYPT_ERROR("cipher update=
 failed");
@@ -256,17 +256,17 @@
 
     /* Check authentication */
     {
-=
        const uint8_t *tag =3D BPTR(src) + TLS_CRYPT_OFF_TAG;
+        cons=
t uint8_t *tag =3D CBPTR(src) + TLS_CRYPT_OFF_TAG;
         uint8_t tag_che=
ck[TLS_CRYPT_TAG_SIZE] =3D { 0 };
 
         dmsg(D_PACKET_CONTENT, "TLS-CR=
YPT UNWRAP AD: %s",
-             format_hex(BPTR(src), TLS_CRYPT_OFF_TAG, =
0, &gc));
+             format_hex(CBPTR(src), TLS_CRYPT_OFF_TAG, 0, &gc));=

         dmsg(D_PACKET_CONTENT, "TLS-CRYPT UNWRAP TO: %s",
-             f=
ormat_hex(BPTR(dst), BLEN(dst), 80, &gc));
+             format_hex(CBPTR(d=
st), BLEN(dst), 80, &gc));
 
         hmac_ctx_reset(ctx->hmac);
-        h=
mac_ctx_update(ctx->hmac, BPTR(src), TLS_CRYPT_OFF_TAG);
-        hmac_ctx_=
update(ctx->hmac, BPTR(dst), BLEN(dst));
+        hmac_ctx_update(ctx->hmac=
, CBPTR(src), TLS_CRYPT_OFF_TAG);
+        hmac_ctx_update(ctx->hmac, CBPTR=
(dst), BLEN(dst));
         hmac_ctx_final(ctx->hmac, tag_check);
 
       =
  if (memcmp_constant_time(tag, tag_check, sizeof(tag_check)))
@@ -384,7 +3=
84,7 @@
     hmac_ctx_reset(hmac_ctx);
     hmac_ctx_update(hmac_ctx, (void=
 *)&net_len, sizeof(net_len));
     hmac_ctx_update(hmac_ctx, (void *)src_k=
ey->keys, sizeof(src_key->keys));
-    hmac_ctx_update(hmac_ctx, BPTR(src_m=
etadata), BLEN(src_metadata));
+    hmac_ctx_update(hmac_ctx, CBPTR(src_met=
adata), BLEN(src_metadata));
     hmac_ctx_final(hmac_ctx, tag);
 
     dms=
g(D_CRYPTO_DEBUG, "TLS-CRYPT WRAP TAG: %s", format_hex(tag, TLS_CRYPT_TAG_S=
IZE, 0, gc));
@@ -405,7 +405,7 @@
     ASSERT(cipher_ctx_update(cipher_ctx,=
 BEND(&work), &outlen, (void *)src_key->keys,
                             =
 sizeof(src_key->keys)));
     ASSERT(buf_inc_len(&work, outlen));
-    ASS=
ERT(cipher_ctx_update(cipher_ctx, BEND(&work), &outlen, BPTR(src_metadata),=

+    ASSERT(cipher_ctx_update(cipher_ctx, BEND(&work), &outlen, CBPTR(src_=
metadata),
                              BLEN(src_metadata)));
     ASSERT(=
buf_inc_len(&work, outlen));
     ASSERT(cipher_ctx_final(cipher_ctx, BEND(=
&work), &outlen));
@@ -529,7 +529,7 @@
         return false;
     }
 
-   =
 const uint8_t *metadata =3D buf_bptr(tls_crypt_v2_metadata);
+    const ui=
nt8_t *metadata =3D CBPTR(tls_crypt_v2_metadata);
     if (*metadata !=3D T=
LS_CRYPT_METADATA_TYPE_TIMESTAMP)
     {
         msg(M_WARN, "ERROR: Clien=
t key does not have a timestamp=2E");
diff --git a/src/openvpn/tun=2Eh b/sr=
c/openvpn/tun=2Eh
index 931e54d=2E=2E2477560 100644
--- a/src/openvpn/tun=
=2Eh
+++ b/src/openvpn/tun=2Eh
@@ -504,7 +504,7 @@
 static inline bool
 is_=
ip_packet_valid(const struct buffer *buf)
 {
-    const struct openvpn_iphd=
r *ih =3D (const struct openvpn_iphdr *)BPTR(buf);
+    const struct openvp=
n_iphdr *ih =3D (const struct openvpn_iphdr *)CBPTR(buf);
 
     if (OPENVP=
N_IPH_GET_VER(ih->version_len) =3D=3D 4)
     {
diff --git a/src/openvpn/vl=
an=2Ec b/src/openvpn/vlan=2Ec
index bffc60e=2E=2E69ac10d 100644
--- a/src/o=
penvpn/vlan=2Ec
+++ b/src/openvpn/vlan=2Ec
@@ -269,7 +269,7 @@
         ret=
urn false;
     }
 
-    vlanhdr =3D (const struct openvpn_8021qhdr *)BPTR(=
buf);
+    vlanhdr =3D (const struct openvpn_8021qhdr *)CBPTR(buf);
 
     =
if (ntohs(vlanhdr->tpid) !=3D OPENVPN_ETH_P_8021Q)
     {
diff --git a/test=
s/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test_buffer=
=2Ec
index 7fb9162=2E=2E7bd0c45 100644
--- a/tests/unit_tests/openvpn/test_=
buffer=2Ec
+++ b/tests/unit_tests/openvpn/test_buffer=2Ec
@@ -51,7 +51,7 @@=

 
 #define assert_buf_equals_str(buf, str)        \
     assert_int_equal(=
BLENZ(buf), strlen(str)); \
-    assert_memory_equal(BPTR(buf), str, BLENZ(=
buf));
+    assert_memory_equal(CBPTR(buf), str, BLENZ(buf));
 
 static voi=
d
 test_buffer_printf_catrunc(void **state)
diff --git a/tests/unit_tests/o=
penvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
ind=
ex db03437=2E=2Ef648e13 100644
--- a/tests/unit_tests/openvpn/test_tls_cryp=
t=2Ec
+++ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
@@ -130,7 +130,7 @@=

 bool
 __wrap_buffer_write_file(const char *filename, const struct buffer =
*buf)
 {
-    const char *pem =3D BSTR(buf);
+    const char *pem =3D CBSTR=
(buf);
     check_expected_ptr(filename);
     check_expected_ptr(pem);
 

=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib4af7639cdebe81eb=
a05ab04efe6e85e63de0f9e
Gerrit-Change-Number: 1904
Gerrit-PatchSet: 4
Gerri=
t-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc <r=
azvanc@mailbox=2Eorg>

--l0O4OFXsewk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p>flichtenheld <strong>up=
loaded patch set #4</strong> to this change=2E</p><p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">buffer: When extracting pointers from buffer, retain const<br><br>Cu=
rrently you can use BPTR and similar to implicitly remove<br>const=2E That =
avoids some warnings that we should get and<br>confuses tools like cppcheck=
 into giving wrong suggestions=2E<br><br>So make sure that by default we on=
ly return a non-const<br>pointer if the buffer pointer is not const=2E Chan=
ge all call<br>sites that threw warnings=2E<br><br>Change-Id: Ib4af7639cdeb=
e81eba05ab04efe6e85e63de0f9e<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/b=
uffer=2Eh<br>M src/openvpn/crypto_backend=2Eh<br>M src/openvpn/crypto_mbedt=
ls=2Ec<br>M src/openvpn/crypto_mbedtls_legacy=2Ec<br>M src/openvpn/crypto_o=
penssl=2Ec<br>M src/openvpn/forward=2Ec<br>M src/openvpn/manage=2Ec<br>M sr=
c/openvpn/mroute=2Ec<br>M src/openvpn/proto=2Eh<br>M src/openvpn/ps=2Ec<br>=
M src/openvpn/push=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=
=2Eh<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>M src/=
openvpn/tls_crypt=2Ec<br>M src/openvpn/tun=2Eh<br>M src/openvpn/vlan=2Ec<br=
>M tests/unit_tests/openvpn/test_buffer=2Ec<br>M tests/unit_tests/openvpn/t=
est_tls_crypt=2Ec<br>21 files changed, 165 insertions(+), 98 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/04/1904/4</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src=
/openvpn/buffer=2Ec</span><br><span>index 5d00415=2E=2E21e113d 100644</span=
><br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/b=
uffer=2Ec</span><br><span>@@ -109,7 +109,7 @@</span><br><span> #endif</span=
><br><span>     ret=2Edata =3D (uint8_t *)malloc(buf-&gt;capacity);</span><=
br><span>     check_malloc_return(ret=2Edata);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    memcpy(BPTR(&amp;ret), BPTR(buf), BLENZ(buf));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(BPTR(&am=
p;ret), CBPTR(buf), BLENZ(buf));</span><br><span>     return ret;</span><br=
><span> }</span><br><span> </span><br><span>@@ -162,7 +162,7 @@</span><br><=
span>     {</span><br><span>         return false;</span><br><span>     }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return buf_write(de=
st, BPTR(src), BLENZ(src));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return buf_write(dest, CBPTR(src), BLENZ(src));</span><br><span=
> }</span><br><span> </span><br><span> void</span><br><span>@@ -293,7 +293,=
7 @@</span><br><span>         return false;</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const ss=
ize_t size =3D write(fd, BPTR(buf), (unsigned int)BLEN(buf));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const ssize_t size =3D write(=
fd, CBPTR(buf), (unsigned int)BLEN(buf));</span><br><span>     if (size !=
=3D BLEN(buf))</span><br><span>     {</span><br><span>         msg(M_ERRNO,=
 &quot;Write error on file &#39;%s&#39;&quot;, filename);</span><br><span>@=
@ -732,7 +732,7 @@</span><br><span>     {</span><br><span>         return f=
alse;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    return memcmp(BPTR(src), match, size) =3D=3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return memcmp(CBPTR(src), match,=
 size) =3D=3D 0;</span><br><span> }</span><br><span> </span><br><span> bool=
</span><br><span>@@ -1035,13 +1035,13 @@</span><br><span> }</span><br><span=
> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-string_check_buf(struct buffer *buf, const unsigned int inclusive, const=
 unsigned int exclusive)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+string_check_buf(const struct buffer *buf, const unsigned int inclusiv=
e, const unsigned int exclusive)</span><br><span> {</span><br><span>     AS=
SERT(buf);</span><br><span> </span><br><span>     for (int i =3D 0; i &lt; =
BLEN(buf); i++)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        char c =3D BSTR(buf)[i];</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        char c =3D CBSTR(buf)[i];</span><br><=
span> </span><br><span>         if (!char_inc_exc(c, inclusive, exclusive))=
</span><br><span>         {</span><br><span>@@ -1135,7 +1135,7 @@</span><br=
><span>     if (buf &amp;&amp; buf-&gt;len)</span><br><span>     {</span><b=
r><span>         msglvl_t msglevel =3D D_ALIGN_DEBUG;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const uintptr_t u =3D (uintptr_t)BP=
TR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
st uintptr_t u =3D (uintptr_t)CBPTR(buf);</span><br><span> </span><br><span=
>         if (u &amp; (PAYLOAD_ALIGN - 1))</span><br><span>         {</span=
><br><span>@@ -1393,16 +1393,16 @@</span><br><span>         return NULL;</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    const uint8_t *seppos =3D memchr(BPTR(buf), sep, buf_l=
en(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
uint8_t *seppos =3D memchr(CBPTR(buf), sep, buf_len(buf));</span><br><span>=
     if (!seppos)</span><br><span>     {</span><br><span>         return NU=
LL;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    size_t field_len =3D seppos - BPTR(buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    size_t field_len =3D seppos - CBPTR(buf);=
</span><br><span> </span><br><span>     char *field =3D gc_malloc(field_len=
 + 1, false, gc);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    memcpy(field, BPTR(buf), field_len);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    memcpy(field, CBPTR(buf), field_len)=
;</span><br><span>     field[field_len] =3D 0;</span><br><span> </span><br>=
<span>     buf_advance(buf, field_len + 1);</span><br><span>diff --git a/sr=
c/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span>index 0a02e94=
=2E=2E22a8b74 100644</span><br><span>--- a/src/openvpn/buffer=2Eh</span><br=
><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -136,21 +136,29 @@</=
span><br><span> </span><br><span> </span><br><span> /** Return a pointer to=
 the start of the buffer content=2E @see buf_bptr() */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#define BPTR(buf)  (buf_bptr(buf))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define BPTR(buf)   (buf_bp=
tr(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Return =
a const pointer to the start of the buffer content=2E @see buf_cbptr() */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CBPTR(buf)  (=
buf_cbptr(buf))</span><br><span> /** Return a pointer one past the end of t=
he buffer content=2E @see buf_bend() */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define BEND(buf)  (buf_bend(buf))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define BEND(buf)   (buf_bend(buf))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Return a const pointe=
r one past the end of the buffer content=2E @see buf_cbend() */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define CBEND(buf)  (buf_cbend(=
buf))</span><br><span> /** Return a pointer to the last byte of the buffer =
content, or NULL if empty=2E @see buf_blast() */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define BLAST(buf) (buf_blast(buf))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define BLAST(buf)  (buf_blast(b=
uf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Return a co=
nst pointer to the last byte of the buffer content, or NULL if empty=2E @se=
e buf_cblast() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine CBLAST(buf) (buf_cblast(buf))</span><br><span> /** Return the length =
of the buffer content in bytes=2E @see buf_len() */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define BLEN(buf)  (buf_len(buf))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define BLEN(buf)   (buf_len(=
buf))</span><br><span> /** Return the length of the buffer content as a \c =
size_t=2E @see buf_len() */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define BLENZ(buf) ((size_t)buf_len(buf))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define BLENZ(buf)  ((size_t)buf_len(buf))</spa=
n><br><span> /** Return true iff the buffer is defined (has non-NULL data p=
ointer)=2E @see buf_defined() */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define BDEF(buf)  (buf_defined(buf))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define BDEF(buf)   (buf_defined(buf))</span><=
br><span> /** Return the buffer content pointer cast to \c char *=2E @see b=
uf_str() */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define BS=
TR(buf)  (buf_str(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define BSTR(buf)   (buf_str(buf))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/** Return the buffer content pointer cast to \c const c=
har *=2E @see buf_cstr() */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define CBSTR(buf)  (buf_cstr(buf))</span><br><span> /** Return the=
 number of bytes available for appending to the buffer=2E @see buf_forward_=
capacity() */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
BCAP(buf)  (buf_forward_capacity(buf))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define BCAP(buf)   (buf_forward_capacity(buf))</span><b=
r><span> </span><br><span> /**</span><br><span>  * Zeroise and reset a buff=
er=2E</span><br><span>@@ -407,15 +415,15 @@</span><br><span> }</span><br><s=
pan> </span><br><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * Return a pointer to the start of the buffer content=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Return a const pointer to the=
 start of the buffer content=2E</span><br><span>  *</span><br><span>  * @pa=
ram buf   The buffer to query=2E</span><br><span>  *</span><br><span>  * @r=
eturn Pointer to \c buf-&gt;data + \c buf-&gt;offset, or NULL if \c buf is<=
/span><br><span>  *         not valid=2E</span><br><span>  */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-static inline uint8_t *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-buf_bptr(const struct buffer *buf=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline cons=
t uint8_t *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_cbpt=
r(const struct buffer *buf)</span><br><span> {</span><br><span>     if (buf=
_valid(buf))</span><br><span>     {</span><br><span>@@ -428,6 +436,20 @@</s=
pan><br><span> }</span><br><span> </span><br><span> /**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Return a pointer to the start of the=
 buffer content=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   Th=
e buffer to query=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return Point=
er to \c buf-&gt;data + \c buf-&gt;offset, or NULL if \c buf is</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *         not valid=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static inline uint8_t *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+buf_bptr(struct buffer *buf)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return (uint8_t *)buf_cbptr(buf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span>  * Return the length of the buffer content=
=2E</span><br><span>  *</span><br><span>  * @param buf   The buffer to quer=
y=2E</span><br><span>@@ -455,12 +477,46 @@</span><br><span>  * @return Poin=
ter to the byte immediately after the last content byte=2E</span><br><span>=
  */</span><br><span> static inline uint8_t *</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-buf_bend(const struct buffer *buf)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+buf_bend(struct buffer *buf)</span><=
br><span> {</span><br><span>     return buf_bptr(buf) + buf_len(buf);</span=
><br><span> }</span><br><span> </span><br><span> /**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Return a const pointer one past the en=
d of the buffer content=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
buf   The buffer to query=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retu=
rn Pointer to the byte immediately after the last content byte=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static inline const uint8_t *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+buf_cbend(const struct buffer *buf)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return buf_cbptr(buf) + buf_len(b=
uf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Return a const pointer to the last byte of the buffer content=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param buf   The buffer to query=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return Pointer to the last by=
te, or NULL if the buffer is empty or</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *         invalid=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static inline const uint8_t *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+buf_cblast(const struct buffer *buf)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (buf_len(buf) &gt; 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return buf_cbptr(buf) + buf_len(buf) - 1;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span>  * Return a pointer to the las=
t byte of the buffer content=2E</span><br><span>  *</span><br><span>  * @pa=
ram buf   The buffer to query=2E</span><br><span>@@ -469,16 +525,9 @@</span=
><br><span>  *         invalid=2E</span><br><span>  */</span><br><span> sta=
tic inline uint8_t *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-b=
uf_blast(const struct buffer *buf)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+buf_blast(struct buffer *buf)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (buf_len(buf) &gt; 0)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        return buf_bptr(buf) + buf_len(buf=
) - 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return NULL;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return (uint8_t *)buf_cblast(buf);</span><br><span> }</span><br><span>=
 </span><br><span> /**</span><br><span>@@ -518,12 +567,25 @@</span><br><spa=
n>  * @return The content pointer as a \c char *, or NULL if \c buf is inva=
lid=2E</span><br><span>  */</span><br><span> static inline char *</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-buf_str(const struct buffer *bu=
f)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_str(struct bu=
ffer *buf)</span><br><span> {</span><br><span>     return (char *)buf_bptr(=
buf);</span><br><span> }</span><br><span> </span><br><span> /**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Return the buffer content po=
inter cast to \c const char *=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param buf   The buffer to query=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @return The content pointer as a \c const char *, or NULL if \c buf is inv=
alid=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static inline const char *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_cstr(const struct=
 buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (const char *=
)buf_cbptr(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Reset a buffer t=
o an undefined (unallocated) state=2E</span><br><span>  *</span><br><span> =
 * Sets all fields to zero/NULL without freeing any memory=2E  Use \c free_=
buf()</span><br><span>@@ -1300,7 +1362,7 @@</span><br><span> static inline =
bool</span><br><span> buf_copy(struct buffer *dest, const struct buffer *sr=
c)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return buf_write(dest, BPTR(src), BLENZ(src));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return buf_write(dest, CBPTR(src), BLENZ=
(src));</span><br><span> }</span><br><span> </span><br><span> /**</span><br=
><span>@@ -1427,14 +1489,14 @@</span><br><span>  *         is empty=2E</spa=
n><br><span>  */</span><br><span> static inline int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-buf_peek_u8(struct buffer *buf)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+buf_peek_u8(const struct buffer=
 *buf)</span><br><span> {</span><br><span>     int ret;</span><br><span>   =
  if (BLEN(buf) &lt; 1)</span><br><span>     {</span><br><span>         ret=
urn -1;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    ret =3D *BPTR(buf);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ret =3D *CBPTR(buf);</span><br><span>     return ret;</spa=
n><br><span> }</span><br><span> </span><br><span>@@ -1547,7 +1609,7 @@</spa=
n><br><span> static inline bool</span><br><span> buf_equal(const struct buf=
fer *a, const struct buffer *b)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return BLEN(a) =3D=3D BLEN(b) &amp;&amp; 0=
 =3D=3D memcmp(BPTR(a), BPTR(b), BLENZ(a));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return BLEN(a) =3D=3D BLEN(b) &amp;&amp; 0 =3D=
=3D memcmp(CBPTR(a), CBPTR(b), BLENZ(a));</span><br><span> }</span><br><spa=
n> </span><br><span> /**</span><br><span>@@ -1561,7 +1623,7 @@</span><br><s=
pan>     {</span><br><span>         return false;</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return memcmp(BPTR(s=
rc), match, size) =3D=3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return memcmp(CBPTR(src), match, size) =3D=3D 0;</span><br><spa=
n> }</span><br><span> </span><br><span> /**</span><br><span>@@ -1575,7 +163=
7,7 @@</span><br><span>     {</span><br><span>         return false;</span>=
<br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn memcmp(BPTR(src), match, size) =3D=3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return memcmp(CBPTR(src), match, size) =3D=
=3D 0;</span><br><span> }</span><br><span> </span><br><span> /**</span><br>=
<span>@@ -1720,7 +1782,7 @@</span><br><span>  * @param exclusive Character =
classes that are not allowed even if they are also in inclusive=2E</span><b=
r><span>  * @return True if the string consists only of allowed characters,=
 false otherwise=2E</span><br><span>  */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-bool string_check_buf(struct buffer *buf, const unsigned=
 int inclusive,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool=
 string_check_buf(const struct buffer *buf, const unsigned int inclusive,</=
span><br><span>                       const unsigned int exclusive);</span>=
<br><span> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/c=
rypto_backend=2Eh b/src/openvpn/crypto_backend=2Eh</span><br><span>index 17=
085d6=2E=2E7ef6ac4 100644</span><br><span>--- a/src/openvpn/crypto_backend=
=2Eh</span><br><span>+++ b/src/openvpn/crypto_backend=2Eh</span><br><span>@=
@ -445,7 +445,7 @@</span><br><span>  *</span><br><span>  * @return         =
     \c 0 on failure, \c 1 on success=2E</span><br><span>  */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-int cipher_ctx_update(cipher_ctx_t =
*ctx, uint8_t *dst, int *dst_len, uint8_t *src, int src_len);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+int cipher_ctx_update(cipher_ctx_=
t *ctx, uint8_t *dst, int *dst_len, const uint8_t *src, int src_len);</span=
><br><span> </span><br><span> /**</span><br><span>  * Pads the final cipher=
 block using PKCS padding, and output to the destination</span><br><span>di=
ff --git a/src/openvpn/crypto_mbedtls=2Ec b/src/openvpn/crypto_mbedtls=2Ec<=
/span><br><span>index 6662def=2E=2E0c5beb4 100644</span><br><span>--- a/src=
/openvpn/crypto_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtl=
s=2Ec</span><br><span>@@ -512,7 +512,7 @@</span><br><span> }</span><br><spa=
n> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, uint8_t=
 *src, int src_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
cipher_ctx_update(cipher_ctx_t *ctx, uint8_t *dst, int *dst_len, const uint=
8_t *src, int src_len)</span><br><span> {</span><br><span>     if (src_len =
&lt; 0)</span><br><span>     {</span><br><span>@@ -1093,7 +1093,7 @@</span>=
<br><span> </span><br><span>     size_t out_len =3D 0;</span><br><span>    =
 if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        !=3D mbedtls_pem_write_buffer(header, footer, BP=
TR(src), BLEN(src), NULL, 0, &amp;out_len))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        !=3D mbedtls_pem_write_buffer(header, foote=
r, CBPTR(src), BLEN(src), NULL, 0, &amp;out_len))</span><br><span>     {</s=
pan><br><span>         return false;</span><br><span>     }</span><br><span=
>@@ -1101,7 +1101,7 @@</span><br><span>     /* We set the size buf to out_l=
en-1 to NOT include the 0 byte that</span><br><span>      * mbedtls_pem_wri=
te_buffer in its length calculation */</span><br><span>     *dst =3D alloc_=
buf_gc(out_len, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (!mbed_ok(mbedtls_pem_write_buffer(header, footer, BPTR(src), BLEN(sr=
c), BPTR(dst),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!mbed_ok(mbedtls_pem_write_buffer(header, footer, CBPTR(src), BLEN(src),=
 BPTR(dst),</span><br><span>                                           BCAP=
(dst), &amp;out_len))</span><br><span>         || !(out_len &lt; INT_MAX &a=
mp;&amp; out_len &gt; 1)</span><br><span>         || !buf_inc_len(dst, (int=
)out_len - 1))</span><br><span>diff --git a/src/openvpn/crypto_mbedtls_lega=
cy=2Ec b/src/openvpn/crypto_mbedtls_legacy=2Ec</span><br><span>index 9e47c2=
6=2E=2Ebbd012f6 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls_leg=
acy=2Ec</span><br><span>+++ b/src/openvpn/crypto_mbedtls_legacy=2Ec</span><=
br><span>@@ -249,7 +249,7 @@</span><br><span> </span><br><span>     size_t =
out_len =3D 0;</span><br><span>     if (MBEDTLS_ERR_BASE64_BUFFER_TOO_SMALL=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        !=3D mbedtls_=
pem_write_buffer(header, footer, BPTR(src), BLEN(src), NULL, 0, &amp;out_le=
n))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        !=3D mbe=
dtls_pem_write_buffer(header, footer, CBPTR(src), BLEN(src), NULL, 0, &amp;=
out_len))</span><br><span>     {</span><br><span>         return false;</sp=
an><br><span>     }</span><br><span>@@ -257,7 +257,7 @@</span><br><span>   =
  /* We set the size buf to out_len-1 to NOT include the 0 byte that</span>=
<br><span>      * mbedtls_pem_write_buffer in its length calculation */</sp=
an><br><span>     *dst =3D alloc_buf_gc(out_len, gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_pem_write_buffer(h=
eader, footer, BPTR(src), BLEN(src), BPTR(dst),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_pem_write_buffer(heade=
r, footer, CBPTR(src), BLEN(src), BPTR(dst),</span><br><span>              =
                             BCAP(dst), &amp;out_len))</span><br><span>    =
     || !buf_inc_len(dst, out_len - 1))</span><br><span>     {</span><br><s=
pan>@@ -684,7 +684,7 @@</span><br><span> }</span><br><span> </span><br><spa=
n> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_upda=
te(mbedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len, uint8_t *src,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_update(m=
bedtls_cipher_context_t *ctx, uint8_t *dst, int *dst_len, const uint8_t *sr=
c,</span><br><span>                   int src_len)</span><br><span> {</span=
><br><span>     size_t s_dst_len =3D *dst_len;</span><br><span>diff --git a=
/src/openvpn/crypto_openssl=2Ec b/src/openvpn/crypto_openssl=2Ec</span><br>=
<span>index 2019280=2E=2E29c5fa6 100644</span><br><span>--- a/src/openvpn/c=
rypto_openssl=2Ec</span><br><span>+++ b/src/openvpn/crypto_openssl=2Ec</spa=
n><br><span>@@ -465,7 +465,7 @@</span><br><span> {</span><br><span>     boo=
l ret =3D false;</span><br><span>     BIO *bio =3D BIO_new(BIO_s_mem());</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!bio || !PEM_wri=
te_bio(bio, name, &quot;&quot;, BPTR(src), BLEN(src)))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (!bio || !PEM_write_bio(bio, name=
, &quot;&quot;, CBPTR(src), BLEN(src)))</span><br><span>     {</span><br><s=
pan>         ret =3D false;</span><br><span>         goto cleanup;</span><b=
r><span>@@ -492,7 +492,7 @@</span><br><span> {</span><br><span>     bool re=
t =3D false;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    BIO *bio =3D BIO_new_mem_buf((char *)BPTR(src), BLEN(src));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    BIO *bio =3D BIO_n=
ew_mem_buf(CBPTR(src), BLEN(src));</span><br><span>     if (!bio)</span><br=
><span>     {</span><br><span>         crypto_msg(M_FATAL, &quot;Cannot ope=
n memory BIO for PEM decode&quot;);</span><br><span>@@ -941,7 +941,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> int</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-cipher_ctx_update(EVP_CIPHER_CTX *ctx, uin=
t8_t *dst, int *dst_len, uint8_t *src, int src_len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+cipher_ctx_update(EVP_CIPHER_CTX *ctx, ui=
nt8_t *dst, int *dst_len, const uint8_t *src, int src_len)</span><br><span>=
 {</span><br><span>     if (!EVP_CipherUpdate(ctx, dst, dst_len, src, src_l=
en))</span><br><span>     {</span><br><span>diff --git a/src/openvpn/forwar=
d=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 2ade321=2E=2Ead43d40 =
100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/=
src/openvpn/forward=2Ec</span><br><span>@@ -271,7 +271,7 @@</span><br><span=
>     }</span><br><span>     else</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        msg(D_PUSH_ERRORS, &quot;WARNING=
: Received unknown control message: %s&quot;, BSTR(buf));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS, &quot;WARN=
ING: Received unknown control message: %s&quot;, CBSTR(buf));</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span>@@ -1646,7 +=
1646,7 @@</span><br><span>             return;</span><br><span>         }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   const struct openvpn_ethhdr *orig_ethhdr =3D (struct openvpn_ethhdr *)BP=
TR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
st struct openvpn_ethhdr *orig_ethhdr =3D (const struct openvpn_ethhdr *)CB=
PTR(buf);</span><br><span> </span><br><span>         /* Copy frametype and =
reverse source/destination for the response */</span><br><span>         str=
uct openvpn_ethhdr ethhdr;</span><br><span>diff --git a/src/openvpn/manage=
=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 310d2e1=2E=2Ec301687 10=
0644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src=
/openvpn/manage=2Ec</span><br><span>@@ -2278,7 +2278,7 @@</span><br><span> =
</span><br><span> #ifdef TARGET_ANDROID</span><br><span> static ssize_t</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-man_send_with_fd(int fd, =
void *ptr, size_t nbytes, int flags, int sendfd)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+man_send_with_fd(int fd, const void *ptr, size=
_t nbytes, int flags, int sendfd)</span><br><span> {</span><br><span>     s=
truct msghdr msg =3D { 0 };</span><br><span>     struct iovec iov[1];</span=
><br><span>@@ -2302,12 +2302,14 @@</span><br><span>     msg=2Emsg_name =3D =
NULL;</span><br><span>     msg=2Emsg_namelen =3D 0;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    iov[0]=2Eiov_base =3D p=
tr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* sendmsg t=
akes a const msghdr, but we can&#39;t construct that here</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+       directly, so cast */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    iov[0]=2Eiov_base =3D (vo=
id *)ptr;</span><br><span>     iov[0]=2Eiov_len =3D nbytes;</span><br><span=
>     msg=2Emsg_iov =3D iov;</span><br><span>     msg=2Emsg_iovlen =3D 1;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn (sendmsg(fd, &amp;msg, flags));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return sendmsg(fd, &amp;msg, flags);</span><br><span>=
 }</span><br><span> </span><br><span> static ssize_t</span><br><span>@@ -25=
12,24 +2514,23 @@</span><br><span> {</span><br><span>     const int size_hi=
nt =3D 1024;</span><br><span>     ssize_t sent =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const struct buffer *buf;</span><br><sp=
an> </span><br><span>     buffer_list_aggregate(man-&gt;connection=2Eout, s=
ize_hint);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf =3D=
 buffer_list_peek(man-&gt;connection=2Eout);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const struct buffer *buf =3D buffer_list_peek(=
man-&gt;connection=2Eout);</span><br><span>     if (buf &amp;&amp; BLEN(buf=
))</span><br><span>     {</span><br><span>         const int len =3D min_in=
t(size_hint, BLEN(buf));</span><br><span> #ifdef TARGET_ANDROID</span><br><=
span>         if (man-&gt;connection=2Efdtosend &gt; 0)</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            se=
nt =3D man_send_with_fd(man-&gt;connection=2Esd_cli, BPTR(buf), len, MSG_NO=
SIGNAL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
sent =3D man_send_with_fd(man-&gt;connection=2Esd_cli, CBPTR(buf), len, MSG=
_NOSIGNAL,</span><br><span>                                     man-&gt;con=
nection=2Efdtosend);</span><br><span>             man-&gt;connection=2Efdto=
send =3D -1;</span><br><span>         }</span><br><span>         else</span=
><br><span> #endif</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            sent =3D send(man-&gt;connection=2Esd_c=
li, (const void *)BPTR(buf), len, MSG_NOSIGNAL);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            sent =3D send(man-&gt;connection=
=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);</span><br><span>         }</span=
><br><span>         if (sent &gt;=3D 0)</span><br><span>         {</span><b=
r><span>diff --git a/src/openvpn/mroute=2Ec b/src/openvpn/mroute=2Ec</span>=
<br><span>index edf8239=2E=2E39fa482 100644</span><br><span>--- a/src/openv=
pn/mroute=2Ec</span><br><span>+++ b/src/openvpn/mroute=2Ec</span><br><span>=
@@ -150,12 +150,12 @@</span><br><span>     unsigned int ret =3D 0;</span><b=
r><span>     if (BLEN(buf) &gt;=3D 1)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        switch (OPENVPN_IPH_GET_VER(=
*BPTR(buf)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 switch (OPENVPN_IPH_GET_VER(*CBPTR(buf)))</span><br><span>         {</span=
><br><span>             case 4:</span><br><span>                 if (BLENZ(=
buf) &gt;=3D sizeof(struct openvpn_iphdr))</span><br><span>                =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 const struct openvpn_iphdr *ip =3D (const struct openvpn_iphdr *)BPTR(buf)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  const struct openvpn_iphdr *ip =3D (const struct openvpn_iphdr *)CBPTR(bu=
f);</span><br><span> </span><br><span>                     mroute_get_in_ad=
dr_t(src, ip-&gt;saddr);</span><br><span>                     mroute_get_in=
_addr_t(dest, ip-&gt;daddr);</span><br><span>@@ -179,7 +179,7 @@</span><br>=
<span>             case 6:</span><br><span>                 if (BLENZ(buf) =
&gt;=3D sizeof(struct openvpn_ipv6hdr))</span><br><span>                 {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    co=
nst struct openvpn_ipv6hdr *ipv6 =3D (const struct openvpn_ipv6hdr *)BPTR(b=
uf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     const struct openvpn_ipv6hdr *ipv6 =3D (const struct openvpn_ipv6hdr *=
)CBPTR(buf);</span><br><span> #if 0 /* very basic debug */</span><br><span>=
                     struct gc_arena gc =3D gc_new();</span><br><span>     =
                msg( M_INFO, &quot;IPv6 packet! src=3D%s, dst=3D%s&quot;,</=
span><br><span>@@ -202,7 +202,7 @@</span><br><span> </span><br><span>      =
       default:</span><br><span>                 msg(M_WARN, &quot;IP packe=
t with unknown IP version=3D%d seen&quot;,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    OPENVPN_IPH_GET_VER(*BPTR(buf)));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
OPENVPN_IPH_GET_VER(*CBPTR(buf)));</span><br><span>         }</span><br><sp=
an>     }</span><br><span>     return ret;</span><br><span>@@ -226,7 +226,7=
 @@</span><br><span>     unsigned int ret =3D 0;</span><br><span>     if (B=
LEN(buf) &gt;=3D (int)sizeof(struct openvpn_ethhdr))</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const struct =
openvpn_ethhdr *eth =3D (const struct openvpn_ethhdr *)BPTR(buf);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        const struct openvpn_=
ethhdr *eth =3D (const struct openvpn_ethhdr *)CBPTR(buf);</span><br><span>=
         if (src)</span><br><span>         {</span><br><span>             m=
route_copy_ether_to_addr(src, eth-&gt;source, vid);</span><br><span>diff --=
git a/src/openvpn/proto=2Eh b/src/openvpn/proto=2Eh</span><br><span>index 3=
570582=2E=2E9bb0866 100644</span><br><span>--- a/src/openvpn/proto=2Eh</spa=
n><br><span>+++ b/src/openvpn/proto=2Eh</span><br><span>@@ -258,7 +258,7 @@=
</span><br><span>         *ip_hdr_offset =3D 0;</span><br><span>         if=
 (likely(BLEN(buf) &gt;=3D (int)sizeof(struct openvpn_iphdr)))</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     ip_ver =3D OPENVPN_IPH_GET_VER(*BPTR(buf));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            ip_ver =3D OPENVPN_IPH_GET_VER(*CB=
PTR(buf));</span><br><span>         }</span><br><span>     }</span><br><spa=
n>     else if (tunnel_type =3D=3D DEV_TYPE_TAP)</span><br><span>@@ -267,7 =
+267,7 @@</span><br><span>         /* for tap get ip version from eth heade=
r */</span><br><span>         if (likely(BLEN(buf) &gt;=3D *ip_hdr_offset))=
</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            const struct openvpn_ethhdr *eh =3D (const struct openvpn=
_ethhdr *)BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            const struct openvpn_ethhdr *eh =3D (const struct openvpn_ethh=
dr *)CBPTR(buf);</span><br><span>             uint16_t proto =3D ntohs(eh-&=
gt;proto);</span><br><span>             if (proto =3D=3D OPENVPN_ETH_P_IPV6=
)</span><br><span>             {</span><br><span>diff --git a/src/openvpn/p=
s=2Ec b/src/openvpn/ps=2Ec</span><br><span>index be91a99=2E=2E08c2673 10064=
4</span><br><span>--- a/src/openvpn/ps=2Ec</span><br><span>+++ b/src/openvp=
n/ps=2Ec</span><br><span>@@ -208,7 +208,9 @@</span><br><span> </span><br><s=
pan>         if (head)</span><br><span>         {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            iov[1]=2Eiov_base =3D BPTR(head);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* sendms=
g takes a const msghdr, but we can&#39;t construct that here</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+               directly, so cast *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            iov[1]=
=2Eiov_base =3D (char *)CBPTR(head);</span><br><span>             iov[1]=2E=
iov_len =3D BLENZ(head);</span><br><span>             mesg=2Emsg_iovlen =3D=
 2;</span><br><span>         }</span><br><span>@@ -964,7 +966,7 @@</span><b=
r><span> bool</span><br><span> is_openvpn_protocol(const struct buffer *buf=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   const unsigned char *p =3D (const unsigned char *)BSTR(buf);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned char *p =3D =
(const unsigned char *)CBSTR(buf);</span><br><span>     const int len =3D B=
LEN(buf);</span><br><span>     if (len &gt;=3D 3)</span><br><span>     {</s=
pan><br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</spa=
n><br><span>index da2bb9f=2E=2E761a59e 100644</span><br><span>--- a/src/ope=
nvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@=
 -47,7 +47,7 @@</span><br><span> void</span><br><span> receive_auth_failed(=
struct context *c, const struct buffer *buffer)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_VERB0, &quot;AUTH: R=
eceived control message: %s&quot;, BSTR(buffer));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    msg(M_VERB0, &quot;AUTH: Received control=
 message: %s&quot;, CBSTR(buffer));</span><br><span>     c-&gt;options=2Eno=
_advance =3D true;</span><br><span> </span><br><span>     if (!c-&gt;option=
s=2Epull)</span><br><span>@@ -64,7 +64,7 @@</span><br><span>     const char=
 *reason =3D NULL;</span><br><span>     if (authfail_extended &amp;&amp; BL=
EN(&amp;buf))</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        reason =3D BSTR(&amp;buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        reason =3D CBSTR(&amp;buf);</span><br=
><span>     }</span><br><span> </span><br><span>     if (authfail_extended =
&amp;&amp; buf_string_match_head_str(&amp;buf, &quot;TEMP&quot;))</span><br=
><span>@@ -116,7 +116,7 @@</span><br><span>      */</span><br><span>     if=
 (authfail_extended &amp;&amp; buf_string_match_head_str(&amp;buf, &quot;CR=
V1:&quot;) &amp;&amp; BLEN(&amp;buf))</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        ssl_put_auth_challenge(BSTR(=
&amp;buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
ssl_put_auth_challenge(CBSTR(&amp;buf));</span><br><span>     }</span><br><=
span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> }</span><br><sp=
an>@@ -508,7 +508,7 @@</span><br><span>     uint64_t option_types_found =3D=
 0;</span><br><span> </span><br><span>     msg(D_PUSH, &quot;PUSH: Received=
 control message: &#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        sanitize_control_message(BSTR(buffer), &amp;gc));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sanitize_cont=
rol_message(CBSTR(buffer), &amp;gc));</span><br><span> </span><br><span>   =
  int status =3D process_incoming_push_msg(c, buffer, c-&gt;options=2Epull,=
 pull_permission_mask(c),</span><br><span>                                 =
           &amp;option_types_found);</span><br><span>@@ -516,7 +516,7 @@</s=
pan><br><span>     if (status =3D=3D PUSH_MSG_ERROR)</span><br><span>     {=
</span><br><span>         msg(D_PUSH_ERRORS, &quot;WARNING: Received bad pu=
sh/pull message: %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            sanitize_control_message(BSTR(buffer), &amp;gc));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            sanitize_control=
_message(CBSTR(buffer), &amp;gc));</span><br><span>     }</span><br><span> =
    else if (status =3D=3D PUSH_MSG_REPLY || status =3D=3D PUSH_MSG_UPDATE<=
/span><br><span>              || status =3D=3D PUSH_MSG_CONTINUATION)</span=
><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</sp=
an><br><span>index 7c6217a=2E=2E7f39268 100644</span><br><span>--- a/src/op=
envpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><sp=
an>@@ -2446,7 +2446,9 @@</span><br><span>     struct cmsghdr *cmsg;</span><=
br><span>     uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    iov=2Eiov_base =3D BPT=
R(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* sendm=
sg takes a const msghdr, but we can&#39;t construct that here</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+       directly, so cast */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    iov=2Eiov_base =3D (c=
har *)CBPTR(buf);</span><br><span>     iov=2Eiov_len =3D BLENZ(buf);</span>=
<br><span>     mesg=2Emsg_iov =3D &amp;iov;</span><br><span>     mesg=2Emsg=
_iovlen =3D 1;</span><br><span>diff --git a/src/openvpn/socket=2Eh b/src/op=
envpn/socket=2Eh</span><br><span>index 89465bc=2E=2Ec6a29f4 100644</span><b=
r><span>--- a/src/openvpn/socket=2Eh</span><br><span>+++ b/src/openvpn/sock=
et=2Eh</span><br><span>@@ -709,14 +709,14 @@</span><br><span>     }</span><=
br><span>     else</span><br><span> #endif</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        return sendto(sock-&gt;sd, BPTR(buf), BLENZ(bu=
f), 0, (struct sockaddr *)&amp;to-&gt;dest=2Eaddr=2Esa,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return sendto(sock-&gt;sd, CBPT=
R(buf), BLENZ(buf), 0, (struct sockaddr *)&amp;to-&gt;dest=2Eaddr=2Esa,</sp=
an><br><span>                       (socklen_t)af_addr_size(to-&gt;dest=2Ea=
ddr=2Esa=2Esa_family));</span><br><span> }</span><br><span> </span><br><spa=
n> static inline ssize_t</span><br><span> link_socket_write_tcp_posix(struc=
t link_socket *sock, struct buffer *buf)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return send(sock-&gt;sd, BPTR(buf=
), BLENZ(buf), MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return send(sock-&gt;sd, CBPTR(buf), BLENZ(buf), MSG_NOSIGNAL=
);</span><br><span> }</span><br><span> </span><br><span> #endif /* ifdef _W=
IN32 */</span><br><span>@@ -761,7 +761,7 @@</span><br><span> {</span><br><s=
pan>     if (sock &amp;&amp; ipbuf)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        const struct openvpn_iphdr *ip=
h =3D (struct openvpn_iphdr *)BPTR(ipbuf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        const struct openvpn_iphdr *iph =3D (const s=
truct openvpn_iphdr *)CBPTR(ipbuf);</span><br><span>         sock-&gt;ptos =
=3D iph-&gt;tos;</span><br><span>         sock-&gt;ptos_defined =3D true;</=
span><br><span>     }</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec =
b/src/openvpn/ssl_pkt=2Ec</span><br><span>index 6a6d9f9=2E=2E90b2aec 100644=
</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/op=
envpn/ssl_pkt=2Ec</span><br><span>@@ -305,7 +305,7 @@</span><br><span>     =
}</span><br><span> </span><br><span>     /* get opcode and key ID */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t pkt_firstbyte =
=3D *BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
uint8_t pkt_firstbyte =3D *CBPTR(buf);</span><br><span>     int op =3D pkt_=
firstbyte &gt;&gt; P_OPCODE_SHIFT;</span><br><span>     int key_id =3D pkt_=
firstbyte &amp; P_KEY_ID_MASK;</span><br><span> </span><br><span>diff --git=
 a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>=
index 063fa5d=2E=2E3653eb4 100644</span><br><span>--- a/src/openvpn/ssl_ver=
ify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@=
 -207,7 +207,7 @@</span><br><span> </span><br><span>         struct cert_ha=
sh *ch =3D session-&gt;cert_hash_set-&gt;ch[error_depth];</span><br><span> =
        ASSERT(sizeof(ch-&gt;sha256_hash) =3D=3D BLEN(cert_hash));</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        memcpy(ch-&gt;sha256_h=
ash, BPTR(cert_hash), sizeof(ch-&gt;sha256_hash));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        memcpy(ch-&gt;sha256_hash, CBPTR(cer=
t_hash), sizeof(ch-&gt;sha256_hash));</span><br><span>     }</span><br><spa=
n> }</span><br><span> </span><br><span>diff --git a/src/openvpn/tls_crypt=
=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><span>index 47f5ac5=2E=2E23c7975=
 100644</span><br><span>--- a/src/openvpn/tls_crypt=2Ec</span><br><span>+++=
 b/src/openvpn/tls_crypt=2Ec</span><br><span>@@ -148,7 +148,7 @@</span><br>=
<span> </span><br><span>     gc_init(&amp;gc);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot=
;TLS-CRYPT WRAP FROM: %s&quot;, format_hex(BPTR(src), BLEN(src), 80, &amp;g=
c));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACK=
ET_CONTENT, &quot;TLS-CRYPT WRAP FROM: %s&quot;, format_hex(CBPTR(src), BLE=
N(src), 80, &amp;gc));</span><br><span> </span><br><span>     /* Get packet=
 ID */</span><br><span>     if (!packet_id_write(&amp;opt-&gt;packet_id=2Es=
end, dst, true, false))</span><br><span>@@ -157,7 +157,7 @@</span><br><span=
>         goto err;</span><br><span>     }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;TLS=
-CRYPT WRAP AD: %s&quot;, format_hex(BPTR(dst), BLEN(dst), 0, &amp;gc));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONT=
ENT, &quot;TLS-CRYPT WRAP AD: %s&quot;, format_hex(CBPTR(dst), BLEN(dst), 0=
, &amp;gc));</span><br><span> </span><br><span>     /* Buffer overflow chec=
k */</span><br><span>     if (!buf_safe(dst, BLENZ(src) + TLS_CRYPT_BLOCK_S=
IZE + TLS_CRYPT_TAG_SIZE))</span><br><span>@@ -173,8 +173,8 @@</span><br><s=
pan>     {</span><br><span>         uint8_t *tag =3D NULL;</span><br><span>=
         hmac_ctx_reset(ctx-&gt;hmac);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        hmac_ctx_update(ctx-&gt;hmac, BPTR(dst), BLEN(dst)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        hmac_ctx_up=
date(ctx-&gt;hmac, BPTR(src), BLEN(src));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        hmac_ctx_update(ctx-&gt;hmac, CBPTR(dst), BLE=
N(dst));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hma=
c_ctx_update(ctx-&gt;hmac, CBPTR(src), BLEN(src));</span><br><span> </span>=
<br><span>         ASSERT(tag =3D buf_write_alloc(dst, TLS_CRYPT_TAG_SIZE))=
;</span><br><span>         hmac_ctx_final(ctx-&gt;hmac, tag);</span><br><sp=
an>@@ -189,7 +189,7 @@</span><br><span>     /* Encrypt src */</span><br><sp=
an>     {</span><br><span>         int outlen =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ASSERT(cipher_ctx_update(ctx-&gt;ci=
pher, BEND(dst), &amp;outlen, BPTR(src), BLEN(src)));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ASSERT(cipher_ctx_update(ctx-&gt;=
cipher, BEND(dst), &amp;outlen, CBPTR(src), BLEN(src)));</span><br><span>  =
       ASSERT(buf_inc_len(dst, outlen));</span><br><span>         ASSERT(ci=
pher_ctx_final(ctx-&gt;cipher, BPTR(dst), &amp;outlen));</span><br><span>  =
       ASSERT(buf_inc_len(dst, outlen));</span><br><span>@@ -220,7 +220,7 @=
@</span><br><span>     ASSERT(ctx-&gt;cipher);</span><br><span>     ASSERT(=
packet_id_initialized(&amp;opt-&gt;packet_id) || (opt-&gt;flags &amp; CO_IG=
NORE_PACKET_ID));</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;TLS-CRYPT UNWRAP FROM: %s&qu=
ot;, format_hex(BPTR(src), BLEN(src), 80, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;TLS-CRYP=
T UNWRAP FROM: %s&quot;, format_hex(CBPTR(src), BLEN(src), 80, &amp;gc));</=
span><br><span> </span><br><span>     if (BLENZ(src) &lt; TLS_CRYPT_OFF_CT)=
</span><br><span>     {</span><br><span>@@ -237,11 +237,11 @@</span><br><sp=
an>             CRYPT_ERROR(&quot;potential buffer overflow&quot;);</span><=
br><span>         }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (!cipher_ctx_reset(ctx-&gt;cipher, BPTR(src) + T=
LS_CRYPT_OFF_TAG))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (!cipher_ctx_reset(ctx-&gt;cipher, CBPTR(src) + TLS_CRYPT_OFF_TAG=
))</span><br><span>         {</span><br><span>             CRYPT_ERROR(&quo=
t;cipher reset failed&quot;);</span><br><span>         }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (!cipher_ctx_update(ctx-&gt;c=
ipher, BPTR(dst), &amp;outlen, BPTR(src) + TLS_CRYPT_OFF_CT,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (!cipher_ctx_update(ctx=
-&gt;cipher, BPTR(dst), &amp;outlen, CBPTR(src) + TLS_CRYPT_OFF_CT,</span><=
br><span>                                BLEN(src) - (int)TLS_CRYPT_OFF_CT)=
)</span><br><span>         {</span><br><span>             CRYPT_ERROR(&quot=
;cipher update failed&quot;);</span><br><span>@@ -256,17 +256,17 @@</span><=
br><span> </span><br><span>     /* Check authentication */</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const u=
int8_t *tag =3D BPTR(src) + TLS_CRYPT_OFF_TAG;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        const uint8_t *tag =3D CBPTR(src) + TLS_=
CRYPT_OFF_TAG;</span><br><span>         uint8_t tag_check[TLS_CRYPT_TAG_SIZ=
E] =3D { 0 };</span><br><span> </span><br><span>         dmsg(D_PACKET_CONT=
ENT, &quot;TLS-CRYPT UNWRAP AD: %s&quot;,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-             format_hex(BPTR(src), TLS_CRYPT_OFF_TAG, 0=
, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
      format_hex(CBPTR(src), TLS_CRYPT_OFF_TAG, 0, &amp;gc));</span><br><sp=
an>         dmsg(D_PACKET_CONTENT, &quot;TLS-CRYPT UNWRAP TO: %s&quot;,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-             format_hex(B=
PTR(dst), BLEN(dst), 80, &amp;gc));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+             format_hex(CBPTR(dst), BLEN(dst), 80, &amp;gc)=
);</span><br><span> </span><br><span>         hmac_ctx_reset(ctx-&gt;hmac);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        hmac_ctx_upda=
te(ctx-&gt;hmac, BPTR(src), TLS_CRYPT_OFF_TAG);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        hmac_ctx_update(ctx-&gt;hmac, BPTR(dst), =
BLEN(dst));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
hmac_ctx_update(ctx-&gt;hmac, CBPTR(src), TLS_CRYPT_OFF_TAG);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        hmac_ctx_update(ctx-&gt;h=
mac, CBPTR(dst), BLEN(dst));</span><br><span>         hmac_ctx_final(ctx-&g=
t;hmac, tag_check);</span><br><span> </span><br><span>         if (memcmp_c=
onstant_time(tag, tag_check, sizeof(tag_check)))</span><br><span>@@ -384,7 =
+384,7 @@</span><br><span>     hmac_ctx_reset(hmac_ctx);</span><br><span>  =
   hmac_ctx_update(hmac_ctx, (void *)&amp;net_len, sizeof(net_len));</span>=
<br><span>     hmac_ctx_update(hmac_ctx, (void *)src_key-&gt;keys, sizeof(s=
rc_key-&gt;keys));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 hmac_ctx_update(hmac_ctx, BPTR(src_metadata), BLEN(src_metadata));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    hmac_ctx_update(hmac_ct=
x, CBPTR(src_metadata), BLEN(src_metadata));</span><br><span>     hmac_ctx_=
final(hmac_ctx, tag);</span><br><span> </span><br><span>     dmsg(D_CRYPTO_=
DEBUG, &quot;TLS-CRYPT WRAP TAG: %s&quot;, format_hex(tag, TLS_CRYPT_TAG_SI=
ZE, 0, gc));</span><br><span>@@ -405,7 +405,7 @@</span><br><span>     ASSER=
T(cipher_ctx_update(cipher_ctx, BEND(&amp;work), &amp;outlen, (void *)src_k=
ey-&gt;keys,</span><br><span>                              sizeof(src_key-&=
gt;keys)));</span><br><span>     ASSERT(buf_inc_len(&amp;work, outlen));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(cipher_ctx_up=
date(cipher_ctx, BEND(&amp;work), &amp;outlen, BPTR(src_metadata),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(cipher_ctx_update=
(cipher_ctx, BEND(&amp;work), &amp;outlen, CBPTR(src_metadata),</span><br><=
span>                              BLEN(src_metadata)));</span><br><span>  =
   ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span>     ASSERT(ciph=
er_ctx_final(cipher_ctx, BEND(&amp;work), &amp;outlen));</span><br><span>@@=
 -529,7 +529,7 @@</span><br><span>         return false;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    const uint8_t *metadata =3D buf_bptr(tls_crypt_v2_metadata);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *metadata =
=3D CBPTR(tls_crypt_v2_metadata);</span><br><span>     if (*metadata !=3D T=
LS_CRYPT_METADATA_TYPE_TIMESTAMP)</span><br><span>     {</span><br><span>  =
       msg(M_WARN, &quot;ERROR: Client key does not have a timestamp=2E&quo=
t;);</span><br><span>diff --git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh=
</span><br><span>index 931e54d=2E=2E2477560 100644</span><br><span>--- a/sr=
c/openvpn/tun=2Eh</span><br><span>+++ b/src/openvpn/tun=2Eh</span><br><span=
>@@ -504,7 +504,7 @@</span><br><span> static inline bool</span><br><span> i=
s_ip_packet_valid(const struct buffer *buf)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    const struct openvpn_iphdr *ih=
 =3D (const struct openvpn_iphdr *)BPTR(buf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const struct openvpn_iphdr *ih =3D (const str=
uct openvpn_iphdr *)CBPTR(buf);</span><br><span> </span><br><span>     if (=
OPENVPN_IPH_GET_VER(ih-&gt;version_len) =3D=3D 4)</span><br><span>     {</s=
pan><br><span>diff --git a/src/openvpn/vlan=2Ec b/src/openvpn/vlan=2Ec</spa=
n><br><span>index bffc60e=2E=2E69ac10d 100644</span><br><span>--- a/src/ope=
nvpn/vlan=2Ec</span><br><span>+++ b/src/openvpn/vlan=2Ec</span><br><span>@@=
 -269,7 +269,7 @@</span><br><span>         return false;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    vlanhdr =3D (const struct openvpn_8021qhdr *)BPTR(buf);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    vlanhdr =3D (const struct open=
vpn_8021qhdr *)CBPTR(buf);</span><br><span> </span><br><span>     if (ntohs=
(vlanhdr-&gt;tpid) !=3D OPENVPN_ETH_P_8021Q)</span><br><span>     {</span><=
br><span>diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/tests/unit=
_tests/openvpn/test_buffer=2Ec</span><br><span>index 7fb9162=2E=2E7bd0c45 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_buffer=2Ec</span>=
<br><span>+++ b/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>@@=
 -51,7 +51,7 @@</span><br><span> </span><br><span> #define assert_buf_equal=
s_str(buf, str)        \</span><br><span>     assert_int_equal(BLENZ(buf), =
strlen(str)); \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    as=
sert_memory_equal(BPTR(buf), str, BLENZ(buf));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_memory_equal(CBPTR(buf), str, BLENZ(b=
uf));</span><br><span> </span><br><span> static void</span><br><span> test_=
buffer_printf_catrunc(void **state)</span><br><span>diff --git a/tests/unit=
_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=
=2Ec</span><br><span>index db03437=2E=2Ef648e13 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>@@ -130,7 +130,7 @@</s=
pan><br><span> bool</span><br><span> __wrap_buffer_write_file(const char *f=
ilename, const struct buffer *buf)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const char *pem =3D BSTR(buf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const char *pem =3D CBST=
R(buf);</span><br><span>     check_expected_ptr(filename);</span><br><span>=
     check_expected_ptr(pem);</span><br><span> </span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1904?usp=3Demail">change 1904</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1904?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1904 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>

</body></html>
--l0O4OFXsewk=--


--===============1607608940104962380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1607608940104962380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1607608940104962380==--

