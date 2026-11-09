Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC65606A325
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=H673E8oA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EDpNHcJD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GQLCWqOl;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Zrj6zpww
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=QcWeGcrG8NnkKodT5ZWlr4H/MERbq4DcDSSK0Mpey54=; b=H673E8oA4plmOBcndqWL6JYAZM
	wfmJnKXbcA3AAfhNPS9KMd8jP0HG96qcrt/SZAL6pTEjw/dG2rdDTHiBeyiDYb2IlLLHQC7dbDmBv
	YlHGFt0pp5qBxAOlhzSvkP1ICLnAwUr9ed5RjaM4vpBPwoi3AAZPpB1JxT/mO6cO8d6E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQXRq-000000004fy-00ds;
	Mon, 09 Nov 2026 22:02:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQXRo-000000004fs-2zb3
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 22:02:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uOI+tjeU3aizDGPgXZ6E0Klq91XIJVHrjXQ45a1Mlms=; b=EDpNHcJDK/I5nGrj3K9cpI2hh3
 Q4Sub5rWBl7SurEPMgcBBX0E/KIgPs4i7OS8Uu0r+X3yPL/vn02u2ho1G4KrawnklBC9tYv6cc4fY
 At//JsUb7ZHKQmbccUk3RQxfS/7DSIEtjnXP66eX7UdluwxEIZWQvfKlofFRkvuZ6eXw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uOI+tjeU3aizDGPgXZ6E0Klq91XIJVHrjXQ45a1Mlms=; b=GQLCWqOlH0Ryy/8hgbgCx+z2t2
 kzjvDtsesemZ24ig591B7Q3OaxPp/r6PTlI3JTq7jUwRSILHsVV9M/LNaDpg93aeWpy8b2dCW9gdi
 1+Xnybhy0O77263wEDAJ9rDUbYbOEFeAnZQqQ9sFR7ct3S9LkcZ+hbcbGOA2qNWX5QZY=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQXRm-000000001l9-1e8T for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 22:02:40 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so15901385e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 14:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794261752; x=1794866552; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uOI+tjeU3aizDGPgXZ6E0Klq91XIJVHrjXQ45a1Mlms=;
 b=Zrj6zpww78dtTJmIOruej8DDwl0pSHIyvNIiWnR1h/97aAsvxPyARlFbRfdylmRGvt
 jTQo3vF6JUpkMStCyiBPJcJcBJIC9XqwqPAYRcVFdPbF0TuFQPWeE28qEOD2JdU8e48v
 EG0rKcnCTXh+oIliPAsVNF+ZiFYs37AWqxkvuxZ5hOZtPvyfBtIYjgqvzMnUhkp73oEh
 5s2okCC+surxhYfNOoy79ZZzg5eUve98XRtyG0zjTuF2UjiUEVjXMD9K+hK8LSqmGRR9
 ciWd11w2oyFgqWhJrphMRIvSmWfGgckxP5vTRY8SV+2ZU1hoyeqUqkH3eL+ok00jvAq9
 oOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794261752; x=1794866552;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uOI+tjeU3aizDGPgXZ6E0Klq91XIJVHrjXQ45a1Mlms=;
 b=KQlTqjzNqvwxTZpMWcSit0ZJzWl2WOgggU/+qcYKVAF6Oi3Gc2wVSvxqh6h/m8cTqp
 U9tp53QjEu892afXiGgWBcZb04pxe+svRGxkL6YZH5NCAH8b76iLmX44AJ+rLXb5YrcX
 PkYIRd7XxgpDTEdDU/pY2lEjGVF197VIWeTAMFgFqVHEM7XFwyJTh8jLtkFVXMDAkN7G
 VsSSlCajKSvypQjGOYEJ8vFM77WGmkbpHKzQ+xKfw5yQuCAuY72vXnh9v3ow08T4jHOL
 +PlUfHybcIEGushpMiktHTIAZEK0ju06bVpCLnkeSOQFACMqjWlUC17d/LYQvFuJt2Qu
 FDwg==
X-Gm-Message-State: APuU4Z/qeDG1PUbqB7gRgrSkyfikcJRNCmgQobiO714csTw4bG8qFnP3
 hArjvOJVj9ixANbcNtnbphiT5IUag6OkFGeeqwfaNSbY/ao9wMNnKHVu7E6Y6dPgMzvjb/EIHk5
 pDhOAkbMx6LW/YbL8NO2BVLH5ur4rvo+E7iyEaWS7IudszwqmVxXizm2XAcJmO6vJVWT/SQKN8Z
 sKs+tPhQ==
X-Gm-Gg: AYBFou1/sYpEafIvuLcKjqei5xEcTCaUGXG/qmjYsFxjGxpDvqd4+5Lub44xshJeg/n
 imlIGIwXdf7NvMTq054iz5b5sbGiTPblE0H9rLnQylD1cvF6ToDLGiOXkhTAF4l9tOArP9BLy23
 nMIvmvgacbfDa6bUQdzDwEnPMkEGnAQvdybEu+Nqzqspp9IOIC7izgPRaPg7/vm0MyQE4LYu5Uo
 ruiHJrJGdbszT6QNu1dYUn2mB1TCVFSWf4II0O89L+egfetFpZ5Bbf4icKk6oy9Yfiv17mC6Klj
 bRy5NClvxBPUx4AG4TBHcR5VAmlnhUiFsaSkIikgOItsdc3MjcIJg58qxJqrAPOzXqvL2Y8u7Bi
 hVYjmiVUp7ncmUxi577Cit1/FJnfNmO8WHXBsToNZR8ZbUHPyJPoGpdxNZG/riT0x0c2YISxljC
 RJ63IUJOyYuDOYXql9GZz2iRGQgJkmlKCvyiajzaRmvaUx+4rEWPuipIW3hPZz2y1N9PP34a5H/
 ULaelVP57KO+ILreTj9OEsiH3fhlzovhC8wIG7PGlt+95f4XQtQTskyFBb9/JnlYy9B7N1fkgb1
 WyLWXmZS1xHlwuBPKPpvLws5521cJmK8zuN02gQLA8eOXWY5Oq2Aauik4TSxeWXmsT9uaG4pGAk
 +ezHPJGEwdp/+25pIGWnH8vRmv4AGMLjC3qOz6PaGiqYpFeSjEvuRXXDipevE+Buq0Y4sew4cQO
 Enf6a8TYePfIF0cw==
X-Received: by 2002:a05:600c:c09a:b0:4a7:669c:c988 with SMTP id
 5b1f17b1804b1-4ba0234bc26mr6787385e9.23.1794261751644; 
 Mon, 09 Nov 2026 14:02:31 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01feee1asm23587495e9.12.2026.11.09.14.02.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 14:02:31 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 22:02:30 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
X-Gerrit-Change-Number: 2158
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2158?usp=email>
X-Gerrit-Commit: b97583191ad0e275731f5f2e45b70e719a68f8d6
References: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkzYmNiNGNiOGUxN2ZmODBhNWNiOGFjZGFmMThkMTA3MjE1OTE4NGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <79c032e63d1dfa48276876e65f5624d7c0510c0d-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQXRm-000000001l9-1e8T
Subject: [Openvpn-devel] [M] Change in openvpn[master]: crypto*: Avoid sign
 conversion warnings by using defines directly
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7953460118797556567=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7953460118797556567==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8kWIbVoBKao="; charset=UTF-8

--8kWIbVoBKao=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2158?usp=3Demail

to review the following change=2E
=


Change subject: crypto*: Avoid sign conversion warnings by using defines =
directly
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

cryp=
to*: Avoid sign conversion warnings by using defines directly

Using the de=
fines directly avoids the issue with sign
conversion by letting the compile=
r deduce the types of
the literals=2E

Change-Id: I3bcb4cb8e17ff80a5cb8acda=
f18d1072159184e5
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

---
M src/openvpn/crypto=2Ec
M src/openvpn/crypto_epoch=2Ec
M src/openvpn/=
packet_id=2Eh
M src/openvpn/tls_crypt=2Ec
M src/openvpn/tls_crypt=2Eh
5 fil=
es changed, 24 insertions(+), 32 deletions(-)



  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/58/2158/1

diff --git a/src/openvp=
n/crypto=2Ec b/src/openvpn/crypto=2Ec
index ffdf8c4=2E=2Ef3631f2 100644
---=
 a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -81,7 +81,6 @@
 
=
     const struct key_ctx *ctx =3D &opt->key_ctx_bi=2Eencrypt;
     uint8_t=
 *mac_out =3D NULL;
-    const int mac_len =3D OPENVPN_AEAD_TAG_LENGTH;
 
 =
    /* IV, packet-ID and implicit IV required for this mode=2E */
     ASSE=
RT(ctx->cipher);
@@ -142,7 +141,7 @@
     dmsg(D_PACKET_CONTENT, "ENCRYPT F=
ROM: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
     /* Buffer ove=
rflow check */
-    if (!buf_safe(&work, buf->len + mac_len + cipher_ctx_bl=
ock_size(ctx->cipher)))
+    if (!buf_safe(&work, BLENZ(buf) + OPENVPN_AEAD=
_TAG_LENGTH + cipher_ctx_block_size(ctx->cipher)))
     {
         msg(D_CR=
YPT_ERRORS, "ENCRYPT: buffer size error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=
=3D%d wl=3D%d",
             buf->capacity, buf->offset, buf->len, work=2Ec=
apacity, work=2Eoffset, work=2Elen);
@@ -156,7 +155,7 @@
     if (!use_epoc=
h_data_format)
     {
         /* Reserve space for authentication tag */
-=
        mac_out =3D buf_write_alloc(&work, mac_len);
+        mac_out =3D b=
uf_write_alloc(&work, OPENVPN_AEAD_TAG_LENGTH);
         ASSERT(mac_out);
 =
    }
 
@@ -177,12 +176,12 @@
     if (use_epoch_data_format)
     {
      =
   /* Reserve space for authentication tag */
-        mac_out =3D buf_writ=
e_alloc(&work, mac_len);
+        mac_out =3D buf_write_alloc(&work, OPENVP=
N_AEAD_TAG_LENGTH);
         ASSERT(mac_out);
     }
 
     /* Write authen=
tication tag */
-    ASSERT(cipher_ctx_get_tag(ctx->cipher, mac_out, mac_le=
n));
+    ASSERT(cipher_ctx_get_tag(ctx->cipher, mac_out, OPENVPN_AEAD_TAG_=
LENGTH));
 
     *buf =3D work;
 
@@ -453,9 +452,6 @@
         CRYPT_DROP("=
Decryption failed verification limit reached=2E");
     }
 
-    const int =
tag_size =3D OPENVPN_AEAD_TAG_LENGTH;
-
-
     ASSERT(frame);
     ASSERT(b=
uf->len > 0);
     ASSERT(ctx->cipher);
@@ -470,14 +466,14 @@
     ASSERT(p=
acket_id_initialized(&opt->packet_id));
 
     /* Ensure that the packet si=
ze is long enough */
-    int min_packet_len =3D packet_id_size(false) + ta=
g_size + 1;
+    size_t min_packet_len =3D packet_id_size(false) + OPENVPN_=
AEAD_TAG_LENGTH + 1;
 
     if (use_epoch_data_format)
     {
         min_=
packet_len +=3D sizeof(uint32_t);
     }
 
-    if (buf->len < min_packet_l=
en)
+    if (BLENZ(buf) < min_packet_len)
     {
         CRYPT_ERROR("miss=
ing IV info, missing tag or no payload");
     }
@@ -540,24 +536,24 @@
    =
     }
     }
 
-    const int ad_size =3D (int)(BPTR(buf) - ad_start);
+  =
  const uintptr_t ad_size =3D (uintptr_t)(BPTR(buf) - ad_start);
 
     uin=
t8_t *tag_ptr =3D NULL;
     int data_len =3D 0;
 
     if (use_epoch_data_=
format)
     {
-        data_len =3D BLEN(buf) - tag_size;
+        data_le=
n =3D BLEN(buf) - OPENVPN_AEAD_TAG_LENGTH;
         tag_ptr =3D BPTR(buf) +=
 data_len;
     }
     else
     {
         tag_ptr =3D BPTR(buf);
-       =
 ASSERT(buf_advance(buf, tag_size));
+        ASSERT(buf_advance(buf, OPENV=
PN_AEAD_TAG_LENGTH));
         data_len =3D BLEN(buf);
     }
 
-    dmsg(D=
_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex(tag_ptr, tag_size, 0, &gc));=

+    dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex(tag_ptr, OPENVPN=
_AEAD_TAG_LENGTH, 0, &gc));
     dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s",=
 format_hex(BPTR(buf), BLENZ(buf), 0, &gc));
 
     /* Buffer overflow chec=
k (should never fail) */
@@ -567,7 +563,7 @@
     }
 
     /* feed in tag a=
nd the authenticated data */
-    ASSERT(cipher_ctx_update_ad(ctx->cipher, =
ad_start, ad_size));
+    ASSERT(cipher_ctx_update_ad(ctx->cipher, ad_start=
, (int)ad_size));
     dmsg(D_PACKET_CONTENT, "DECRYPT AD: %s", format_hex(=
ad_start, ad_size, 0, &gc));
 
     /* Decrypt and authenticate packet */
@=
@ -578,7 +574,7 @@
     }
 
     ASSERT(buf_inc_len(&work, outlen));
-    i=
f (!cipher_ctx_final_check_tag(ctx->cipher, BPTR(&work) + outlen, &outlen, =
tag_ptr, tag_size))
+    if (!cipher_ctx_final_check_tag(ctx->cipher, BPTR(=
&work) + outlen, &outlen, tag_ptr, OPENVPN_AEAD_TAG_LENGTH))
     {
       =
  ctx->failed_verifications++;
         CRYPT_DROP("packet tag authenticati=
on failed");
@@ -1118,20 +1114,19 @@
 static void
 generate_key_random(stru=
ct key *key)
 {
-    int cipher_len =3D MAX_CIPHER_KEY_LENGTH;
-    int hma=
c_len =3D MAX_HMAC_KEY_LENGTH;
-
     struct gc_arena gc =3D gc_new();
 
  =
   CLEAR(*key);
-    if (!rand_bytes(key->cipher, cipher_len) || !rand_byte=
s(key->hmac, hmac_len))
+    if (!rand_bytes(key->cipher, MAX_CIPHER_KEY_LE=
NGTH)
+        || !rand_bytes(key->hmac, MAX_HMAC_KEY_LENGTH))
     {
     =
    msg(M_FATAL, "ERROR: Random number generator cannot obtain entropy for =
key generation");
     }
 
     dmsg(D_SHOW_KEY_SOURCE, "Cipher source entr=
opy: %s",
-         format_hex(key->cipher, cipher_len, 0, &gc));
-    dmsg=
(D_SHOW_KEY_SOURCE, "HMAC source entropy: %s", format_hex(key->hmac, hmac_l=
en, 0, &gc));
+         format_hex(key->cipher, MAX_CIPHER_KEY_LENGTH, 0, &=
gc));
+    dmsg(D_SHOW_KEY_SOURCE, "HMAC source entropy: %s",
+         for=
mat_hex(key->hmac, MAX_HMAC_KEY_LENGTH, 0, &gc));
 
     gc_free(&gc);
 }
d=
iff --git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec
ind=
ex 243b5a2=2E=2Ee0fc099 100644
--- a/src/openvpn/crypto_epoch=2Ec
+++ b/src=
/openvpn/crypto_epoch=2Ec
@@ -51,26 +51,23 @@
     hmac_ctx_init(hmac_ctx, =
secret, "SHA256");
 
     ASSERT(info_len <=3D INT_MAX);
-    const unsigne=
d int digest_size =3D SHA256_DIGEST_LENGTH;
 
     /* T(0) =3D empty string=
 */
     uint8_t t_prev[SHA256_DIGEST_LENGTH];
-    unsigned int t_prev_len=
 =3D 0;
 
-    for (uint8_t block =3D 1; (block - 1) * digest_size < out_le=
n; block++)
+    for (uint8_t block =3D 1; (block - 1u) * SHA256_DIGEST_LEN=
GTH < out_len; block++)
     {
         hmac_ctx_reset(hmac_ctx);
 
       =
  /* calculate T(block) */
-        hmac_ctx_update(hmac_ctx, t_prev, t_pre=
v_len);
+        hmac_ctx_update(hmac_ctx, t_prev, block =3D=3D 1 ? 0 : SHA=
256_DIGEST_LENGTH);
         hmac_ctx_update(hmac_ctx, info, (int)info_len)=
;
         hmac_ctx_update(hmac_ctx, &block, 1);
         hmac_ctx_final(hm=
ac_ctx, t_prev);
-        t_prev_len =3D digest_size;
 
         /* Copy a =
full hmac output or remaining bytes */
-        size_t out_offset =3D (bloc=
k - 1) * digest_size;
-        size_t copylen =3D min_size(digest_size, out=
_len - out_offset);
+        size_t out_offset =3D (block - 1u) * SHA256_DI=
GEST_LENGTH;
+        size_t copylen =3D min_size(SHA256_DIGEST_LENGTH, out=
_len - out_offset);
 
         memcpy(out + out_offset, t_prev, copylen);
 =
    }
diff --git a/src/openvpn/packet_id=2Eh b/src/openvpn/packet_id=2Eh
in=
dex 48752d3=2E=2E782dd58 100644
--- a/src/openvpn/packet_id=2Eh
+++ b/src/o=
penvpn/packet_id=2Eh
@@ -312,7 +312,7 @@
 const char *packet_id_net_print(c=
onst struct packet_id_net *pin, bool print_timestamp,
                     =
            struct gc_arena *gc);
 
-static inline int
+static inline unsig=
ned int
 packet_id_size(bool long_form)
 {
     return sizeof(packet_id_typ=
e) + (long_form ? sizeof(net_time_t) : 0);
diff --git a/src/openvpn/tls_cry=
pt=2Ec b/src/openvpn/tls_crypt=2Ec
index 2dadc4f=2E=2E7eb83ce 100644
--- a/=
src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -52,7 +52,7 @@=

     return create_kt("AES-256-CTR", "SHA256", "tls-crypt");
 }
 
-int
+un=
signed int
 tls_crypt_buf_overhead(void)
 {
     return packet_id_size(true=
) + TLS_CRYPT_TAG_SIZE + TLS_CRYPT_BLOCK_SIZE;
diff --git a/src/openvpn/tls=
_crypt=2Eh b/src/openvpn/tls_crypt=2Eh
index d179cbb=2E=2E8e5567f 100644
--=
- a/src/openvpn/tls_crypt=2Eh
+++ b/src/openvpn/tls_crypt=2Eh
@@ -130,7 +13=
0,7 @@
  * Returns the maximum overhead (in bytes) added to the destination=
 buffer by
  * tls_crypt_wrap()=2E
  */
-int tls_crypt_buf_overhead(void);
=
+unsigned int tls_crypt_buf_overhead(void);
 
 /**
  * Wrap a control chann=
el packet (both authenticates and encrypts the data)=2E

-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159=
184e5
Gerrit-Change-Number: 2158
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--8kWIbVoBKao=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">crypto*: Avoid sign conversion warnings by using defines d=
irectly<br><br>Using the defines directly avoids the issue with sign<br>con=
version by letting the compiler deduce the types of<br>the literals=2E<br><=
br>Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/cr=
ypto=2Ec<br>M src/openvpn/crypto_epoch=2Ec<br>M src/openvpn/packet_id=2Eh<b=
r>M src/openvpn/tls_crypt=2Ec<br>M src/openvpn/tls_crypt=2Eh<br>5 files cha=
nged, 24 insertions(+), 32 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/2158/1</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><spa=
n>index ffdf8c4=2E=2Ef3631f2 100644</span><br><span>--- a/src/openvpn/crypt=
o=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -81,7=
 +81,6 @@</span><br><span> </span><br><span>     const struct key_ctx *ctx =
=3D &amp;opt-&gt;key_ctx_bi=2Eencrypt;</span><br><span>     uint8_t *mac_ou=
t =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const =
int mac_len =3D OPENVPN_AEAD_TAG_LENGTH;</span><br><span> </span><br><span>=
     /* IV, packet-ID and implicit IV required for this mode=2E */</span><b=
r><span>     ASSERT(ctx-&gt;cipher);</span><br><span>@@ -142,7 +141,7 @@</s=
pan><br><span>     dmsg(D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot;, for=
mat_hex(BPTR(buf), BLENZ(buf), 80, &amp;gc));</span><br><span> </span><br><=
span>     /* Buffer overflow check */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (!buf_safe(&amp;work, buf-&gt;len + mac_len + cipher=
_ctx_block_size(ctx-&gt;cipher)))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (!buf_safe(&amp;work, BLENZ(buf) + OPENVPN_AEAD_TAG_LE=
NGTH + cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><span>     {</span=
><br><span>         msg(D_CRYPT_ERRORS, &quot;ENCRYPT: buffer size error, b=
c=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d&quot;,</span><br><span>     =
        buf-&gt;capacity, buf-&gt;offset, buf-&gt;len, work=2Ecapacity, wor=
k=2Eoffset, work=2Elen);</span><br><span>@@ -156,7 +155,7 @@</span><br><spa=
n>     if (!use_epoch_data_format)</span><br><span>     {</span><br><span> =
        /* Reserve space for authentication tag */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        mac_out =3D buf_write_alloc(&amp;work,=
 mac_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
ac_out =3D buf_write_alloc(&amp;work, OPENVPN_AEAD_TAG_LENGTH);</span><br><=
span>         ASSERT(mac_out);</span><br><span>     }</span><br><span> </sp=
an><br><span>@@ -177,12 +176,12 @@</span><br><span>     if (use_epoch_data_=
format)</span><br><span>     {</span><br><span>         /* Reserve space fo=
r authentication tag */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        mac_out =3D buf_write_alloc(&amp;work, mac_len);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        mac_out =3D buf_write_alloc(=
&amp;work, OPENVPN_AEAD_TAG_LENGTH);</span><br><span>         ASSERT(mac_ou=
t);</span><br><span>     }</span><br><span> </span><br><span>     /* Write =
authentication tag */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    ASSERT(cipher_ctx_get_tag(ctx-&gt;cipher, mac_out, mac_len));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(cipher_ctx_get_tag=
(ctx-&gt;cipher, mac_out, OPENVPN_AEAD_TAG_LENGTH));</span><br><span> </spa=
n><br><span>     *buf =3D work;</span><br><span> </span><br><span>@@ -453,9=
 +452,6 @@</span><br><span>         CRYPT_DROP(&quot;Decryption failed veri=
fication limit reached=2E&quot;);</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int tag_size=
 =3D OPENVPN_AEAD_TAG_LENGTH;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan>     ASSERT(frame);</span><br><span>     ASSERT(buf-&gt;len &gt; 0);</s=
pan><br><span>     ASSERT(ctx-&gt;cipher);</span><br><span>@@ -470,14 +466,=
14 @@</span><br><span>     ASSERT(packet_id_initialized(&amp;opt-&gt;packet=
_id));</span><br><span> </span><br><span>     /* Ensure that the packet siz=
e is long enough */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  int min_packet_len =3D packet_id_size(false) + tag_size + 1;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    size_t min_packet_len =3D pa=
cket_id_size(false) + OPENVPN_AEAD_TAG_LENGTH + 1;</span><br><span> </span>=
<br><span>     if (use_epoch_data_format)</span><br><span>     {</span><br>=
<span>         min_packet_len +=3D sizeof(uint32_t);</span><br><span>     }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (buf-&gt;len &lt; min_packet_len)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (BLENZ(buf) &lt; min_packet_len)</span><br><span> =
    {</span><br><span>         CRYPT_ERROR(&quot;missing IV info, missing t=
ag or no payload&quot;);</span><br><span>     }</span><br><span>@@ -540,24 =
+536,24 @@</span><br><span>         }</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int ad_s=
ize =3D (int)(BPTR(buf) - ad_start);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const uintptr_t ad_size =3D (uintptr_t)(BPTR(buf) - ad=
_start);</span><br><span> </span><br><span>     uint8_t *tag_ptr =3D NULL;<=
/span><br><span>     int data_len =3D 0;</span><br><span> </span><br><span>=
     if (use_epoch_data_format)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        data_len =3D BLEN(buf) - tag_size;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        data_len =
=3D BLEN(buf) - OPENVPN_AEAD_TAG_LENGTH;</span><br><span>         tag_ptr =
=3D BPTR(buf) + data_len;</span><br><span>     }</span><br><span>     else<=
/span><br><span>     {</span><br><span>         tag_ptr =3D BPTR(buf);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(buf_advance=
(buf, tag_size));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      ASSERT(buf_advance(buf, OPENVPN_AEAD_TAG_LENGTH));</span><br><span>  =
       data_len =3D BLEN(buf);</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT=
, &quot;DECRYPT MAC: %s&quot;, format_hex(tag_ptr, tag_size, 0, &amp;gc));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CO=
NTENT, &quot;DECRYPT MAC: %s&quot;, format_hex(tag_ptr, OPENVPN_AEAD_TAG_LE=
NGTH, 0, &amp;gc));</span><br><span>     dmsg(D_PACKET_CONTENT, &quot;DECRY=
PT FROM: %s&quot;, format_hex(BPTR(buf), BLENZ(buf), 0, &amp;gc));</span><b=
r><span> </span><br><span>     /* Buffer overflow check (should never fail)=
 */</span><br><span>@@ -567,7 +563,7 @@</span><br><span>     }</span><br><s=
pan> </span><br><span>     /* feed in tag and the authenticated data */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(cipher_ctx_upd=
ate_ad(ctx-&gt;cipher, ad_start, ad_size));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ASSERT(cipher_ctx_update_ad(ctx-&gt;cipher, ad_=
start, (int)ad_size));</span><br><span>     dmsg(D_PACKET_CONTENT, &quot;DE=
CRYPT AD: %s&quot;, format_hex(ad_start, ad_size, 0, &amp;gc));</span><br><=
span> </span><br><span>     /* Decrypt and authenticate packet */</span><br=
><span>@@ -578,7 +574,7 @@</span><br><span>     }</span><br><span> </span><=
br><span>     ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!cipher_ctx_final_check_tag(ctx-&gt=
;cipher, BPTR(&amp;work) + outlen, &amp;outlen, tag_ptr, tag_size))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!cipher_ctx_final_c=
heck_tag(ctx-&gt;cipher, BPTR(&amp;work) + outlen, &amp;outlen, tag_ptr, OP=
ENVPN_AEAD_TAG_LENGTH))</span><br><span>     {</span><br><span>         ctx=
-&gt;failed_verifications++;</span><br><span>         CRYPT_DROP(&quot;pack=
et tag authentication failed&quot;);</span><br><span>@@ -1118,20 +1114,19 @=
@</span><br><span> static void</span><br><span> generate_key_random(struct =
key *key)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    int cipher_len =3D MAX_CIPHER_KEY_LENGTH;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int hmac_len =3D MAX_HMAC_KEY_LENGTH;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     s=
truct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>     CLEA=
R(*key);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!rand=
_bytes(key-&gt;cipher, cipher_len) || !rand_bytes(key-&gt;hmac, hmac_len))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!rand_bytes(=
key-&gt;cipher, MAX_CIPHER_KEY_LENGTH)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        || !rand_bytes(key-&gt;hmac, MAX_HMAC_KEY_LENGTH=
))</span><br><span>     {</span><br><span>         msg(M_FATAL, &quot;ERROR=
: Random number generator cannot obtain entropy for key generation&quot;);<=
/span><br><span>     }</span><br><span> </span><br><span>     dmsg(D_SHOW_K=
EY_SOURCE, &quot;Cipher source entropy: %s&quot;,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-         format_hex(key-&gt;cipher, cipher_len,=
 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dms=
g(D_SHOW_KEY_SOURCE, &quot;HMAC source entropy: %s&quot;, format_hex(key-&g=
t;hmac, hmac_len, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         format_hex(key-&gt;cipher, MAX_CIPHER_KEY_LENGTH, 0, &=
amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D=
_SHOW_KEY_SOURCE, &quot;HMAC source entropy: %s&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         format_hex(key-&gt;hmac, MAX_HM=
AC_KEY_LENGTH, 0, &amp;gc));</span><br><span> </span><br><span>     gc_free=
(&amp;gc);</span><br><span> }</span><br><span>diff --git a/src/openvpn/cryp=
to_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec</span><br><span>index 243b5a2=
=2E=2Ee0fc099 100644</span><br><span>--- a/src/openvpn/crypto_epoch=2Ec</sp=
an><br><span>+++ b/src/openvpn/crypto_epoch=2Ec</span><br><span>@@ -51,26 +=
51,23 @@</span><br><span>     hmac_ctx_init(hmac_ctx, secret, &quot;SHA256&=
quot;);</span><br><span> </span><br><span>     ASSERT(info_len &lt;=3D INT_=
MAX);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const unsign=
ed int digest_size =3D SHA256_DIGEST_LENGTH;</span><br><span> </span><br><s=
pan>     /* T(0) =3D empty string */</span><br><span>     uint8_t t_prev[SH=
A256_DIGEST_LENGTH];</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   unsigned int t_prev_len =3D 0;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    for (uint8_t block =3D 1; (block - 1) *=
 digest_size &lt; out_len; block++)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    for (uint8_t block =3D 1; (block - 1u) * SHA256_DIGEST_=
LENGTH &lt; out_len; block++)</span><br><span>     {</span><br><span>      =
   hmac_ctx_reset(hmac_ctx);</span><br><span> </span><br><span>         /* =
calculate T(block) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        hmac_ctx_update(hmac_ctx, t_prev, t_prev_len);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        hmac_ctx_update(hmac_ctx, t_prev=
, block =3D=3D 1 ? 0 : SHA256_DIGEST_LENGTH);</span><br><span>         hmac=
_ctx_update(hmac_ctx, info, (int)info_len);</span><br><span>         hmac_c=
tx_update(hmac_ctx, &amp;block, 1);</span><br><span>         hmac_ctx_final=
(hmac_ctx, t_prev);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      t_prev_len =3D digest_size;</span><br><span> </span><br><span>       =
  /* Copy a full hmac output or remaining bytes */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        size_t out_offset =3D (block - 1) * di=
gest_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        siz=
e_t copylen =3D min_size(digest_size, out_len - out_offset);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        size_t out_offset =3D (blo=
ck - 1u) * SHA256_DIGEST_LENGTH;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        size_t copylen =3D min_size(SHA256_DIGEST_LENGTH, out_=
len - out_offset);</span><br><span> </span><br><span>         memcpy(out + =
out_offset, t_prev, copylen);</span><br><span>     }</span><br><span>diff -=
-git a/src/openvpn/packet_id=2Eh b/src/openvpn/packet_id=2Eh</span><br><spa=
n>index 48752d3=2E=2E782dd58 100644</span><br><span>--- a/src/openvpn/packe=
t_id=2Eh</span><br><span>+++ b/src/openvpn/packet_id=2Eh</span><br><span>@@=
 -312,7 +312,7 @@</span><br><span> const char *packet_id_net_print(const st=
ruct packet_id_net *pin, bool print_timestamp,</span><br><span>            =
                     struct gc_arena *gc);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static inline unsigned int</span><br><=
span> packet_id_size(bool long_form)</span><br><span> {</span><br><span>   =
  return sizeof(packet_id_type) + (long_form ? sizeof(net_time_t) : 0);</sp=
an><br><span>diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=
=2Ec</span><br><span>index 2dadc4f=2E=2E7eb83ce 100644</span><br><span>--- =
a/src/openvpn/tls_crypt=2Ec</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec=
</span><br><span>@@ -52,7 +52,7 @@</span><br><span>     return create_kt(&q=
uot;AES-256-CTR&quot;, &quot;SHA256&quot;, &quot;tls-crypt&quot;);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned =
int</span><br><span> tls_crypt_buf_overhead(void)</span><br><span> {</span>=
<br><span>     return packet_id_size(true) + TLS_CRYPT_TAG_SIZE + TLS_CRYPT=
_BLOCK_SIZE;</span><br><span>diff --git a/src/openvpn/tls_crypt=2Eh b/src/o=
penvpn/tls_crypt=2Eh</span><br><span>index d179cbb=2E=2E8e5567f 100644</spa=
n><br><span>--- a/src/openvpn/tls_crypt=2Eh</span><br><span>+++ b/src/openv=
pn/tls_crypt=2Eh</span><br><span>@@ -130,7 +130,7 @@</span><br><span>  * Re=
turns the maximum overhead (in bytes) added to the destination buffer by</s=
pan><br><span>  * tls_crypt_wrap()=2E</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-int tls_crypt_buf_overhead(void);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int tls_crypt_b=
uf_overhead(void);</span><br><span> </span><br><span> /**</span><br><span> =
 * Wrap a control channel packet (both authenticates and encrypts the data)=
=2E</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2158?usp=3Demail">change 2158</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf1=
8d1072159184e5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 21=
58 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>

</body></html>
--8kWIbVoBKao=--


--===============7953460118797556567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7953460118797556567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7953460118797556567==--

