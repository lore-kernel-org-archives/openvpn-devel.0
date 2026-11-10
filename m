Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05F9606A325
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KGhTfTTk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kylxLazT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MSYhWgBI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TYpJqT5/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=xFlZ5jeN6MSD93NDh3SdXy3flQpetLoKYjL8XH2U/dg=; b=KGhTfTTkRSO5lWegrvEOgj9mJk
	yPFeJhYhgGp9qWBPp17UWL/surFsZgBWrELci8wOruQ0PE2bImvjPcbtJwVUR2NK7hPOI7BsR0g/w
	wHInL6/KvZSdobM7DnTt+hB2h26XjNbKYqhXn3MwtnyQ3dPpA5Kg3t4SIjd8NVR0duqc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQjyH-000000006Hs-3ppy;
	Tue, 10 Nov 2026 11:25:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQjyF-000000006Dh-48p1
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:24:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B7kneyhfnUxYM5ECIPYdDigv3+6aAZWgBkjkD4YsFmk=; b=kylxLazThqe2Q5IUs9KslxyR3D
 roGAUbt15RWI8GUyyIKYq3+uyn2ygHLn9o5bB/tP0Cfj10IGI5JjD6vRz4YwMShWl0qWJsaw7FoQa
 bH6T+4KlxSHf3BjIJCEErl09tg35EtRDWPlH52ijcORrG/wktrjmRoucyVOT5mI7RDug=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=B7kneyhfnUxYM5ECIPYdDigv3+6aAZWgBkjkD4YsFmk=; b=MSYhWgBIV7LoolNcGY4N8mf+K7
 e8Po090dMzBDsWYCRT3Y63i3K+kALfJjrz47Gx9MNaCYkKb6wQDXPr5TqRoFGlzHZq73ugRtRo3qh
 K2RMkvrbGYQxcqfazvVbmGGRQRGPqAv7sVTcrf/9/YgA/iIDTmvseBtNhjU9vTa6yKks=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQjxm-000000004BX-0FY8 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 11:24:31 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-4922523d1afso1078449f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 03:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794309863; x=1794914663; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=B7kneyhfnUxYM5ECIPYdDigv3+6aAZWgBkjkD4YsFmk=;
 b=TYpJqT5/8LGcNPEf+F3839OfnSEg7XO/dvnuEUCCov+ifSz0kaUUBtgptbpHcXmuF7
 xO/t8zQK1Sh3X9+Ko1x1nsgacVerBn8+uznZFBYvzPXC1E3ou+wDFxNprHTEqf4MHsqK
 eLJ4PJw5st18CnauM5Wbkz9oIxDNm6UAxtfy9vjL1Wy/n6KS2i+8bcfzgJ+13UhY6msD
 FN+zCR818GYtQuK9qfO/FSrfF8g+znd0OYTij8UJDx7jcmUU97pgkfXQe0XhQOAOMwGA
 xmrc7+NbPHvgLMtHilEFUbonsapkw5FlQ04fO3iWmBYd2pwvyR5ES/H3SDFRq9O8C6oP
 HNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794309863; x=1794914663;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=B7kneyhfnUxYM5ECIPYdDigv3+6aAZWgBkjkD4YsFmk=;
 b=kxl3I9GhxwEwLC7JjE6a0ntSFDHBTwfVp2RRyKPIQLvDJ6zprm0X4ThP5ecFlb3vOP
 KMfaFUIuUWXxvNmLQkePVpsh9zkB5LU01b9u9fDF9DWVO9Q/T/abKXOBEp6FYHPcUjXL
 OmIFg+nkyO/nxfqieDEDCvRmqgMHi0rLyy2dvRYcmtZNeQKVuJIpoCLttfGHlJidy6mI
 YKWBa/RJXBzKrunVFcAmzW5h0HpDAZB2upscodAtO/8fbLo/e/+cz34gTVr76OCMzeqh
 Qym9vJQZ4lu1MxivN+fw3yjCJrpoVClWWla6d1cuPIgZ/F4M0tR4fFsCH1hpPI3r+/xs
 W12Q==
X-Gm-Message-State: APuU4Z9DTelvShdRMg9EbzA5zXxpE6ka9ce4Be56dXqinVJBHrpRJ409
 p47EtTM540GTgom/9PmVhhBgLR94zueQn5BeYIQxPhDQevdmRKE2WygMb3zCx/CiJD6y6nyFQrB
 uyDzpb5XUlBIZziQLKoTHLWBAme7Rnwcit5OEYHs/MhMKevx6qVtDcNtWqk0BBk6JW/nBgbrgjK
 xFbd5qgA==
X-Gm-Gg: AYBFou1+wH98Pvdv3gzx5uAPJ6FtKp02iosVaqvw58d2TL72+uxdTMFHOuIVjQ+vZcx
 8zYuJZQbRPhwfcRAuiIrbq45ua6EtySmFqgt2+mvxHxq05WyYT3pVqcEGjHwEGnSDJ90YNdUk0r
 yMMq4EA4wYNeeRqBHlmO0iuUuOYz7fLzs4AlB0D5xbX6DTCsM6W4Bc1w+0e//dLxWk7yUtVz4dm
 w/m6YTUczzpo/SUSAz0R8HryMBSu9wFHiZtADIEcg9J5+EqizoLLTCaqw23RM3lU1/k2l8mlQMc
 N+cnIIoB4u8Ud8AwbiYWgHRbw37rxYEJ2mtG8I7bDrPrMdjXeMOBAhJBtmhkP7gIv/sQGG6VBKr
 nPoe6nGNj32VZKVdszCcyfFilS4yETH8wfUizVPLhfeAsn95Q+GrH6wxZJfpgxDPChfq9Thp/DI
 0s17qMjIiIG1sPLryhFkTi4bJDXB3l/YkEiILckrTCVfEIAv8ot5HLkcCuZ40Di9/bLC7iyW/S3
 0hISz+vTky7nFl8OOvvdIwmjRtrZTA9HycnXg3T3kUZVyYWwAKS+iwUwOS7ocIhdq/rJhsCkpw6
 09Tu/9MBwFSHoz+Fe++Lv6ObSFmyyLR3byGIxBZ6nKlKXIo2owJxVxzX0oUlMUZOc3Ew1jknh2m
 Pfd1sw/NiQ5Pl83i8plEeJoZ6YjZAvzMs1q0sFE8/HN2vF9HF8pioI/vJs7zLJCsj9iz1DL1lWP
 HkqhBZtNNV7P7Mvn0=
X-Received: by 2002:a05:6000:2389:b0:491:8462:20cc with SMTP id
 ffacd0b85a97d-49830d8186fmr4569040f8f.37.1794309863211; 
 Tue, 10 Nov 2026 03:24:23 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a495csm4348919f8f.55.2026.11.10.03.24.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 03:24:22 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 11:24:20 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
X-Gerrit-Change-Number: 2158
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2158?usp=email>
X-Gerrit-Commit: 3f8d4f6fe041f8005cc926cd887cc0a2a6fe27c6
In-Reply-To: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
References: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkzYmNiNGNiOGUxN2ZmODBhNWNiOGFjZGFmMThkMTA3MjE1OTE4NGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8db007f58afb14eeaa1323e072987d235e19af16-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQjxm-000000004BX-0FY8
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
Content-Type: multipart/mixed; boundary="===============0721360399804094466=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0721360399804094466==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fzcGajrQBJw="; charset=UTF-8

--fzcGajrQBJw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2158?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: crypto*: Avoid sign conversion warnings by using de=
fines directly
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


crypto*: Avoid sign conversion warnings by using defines directly

Using =
the defines directly avoids the issue with sign
conversion by letting the c=
ompiler deduce the types of
the literals=2E

I do not think that using an i=
ntermediate variabl
increases the readability=2E

Change-Id: I3bcb4cb8e17ff=
80a5cb8acdaf18d1072159184e5
Signed-off-by: Frank Lichtenheld <frank@lichten=
held=2Ecom>
---
M src/openvpn/crypto=2Ec
M src/openvpn/crypto_epoch=2Ec
M s=
rc/openvpn/packet_id=2Eh
M src/openvpn/tls_crypt=2Ec
M src/openvpn/tls_cryp=
t=2Eh
5 files changed, 24 insertions(+), 32 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/2158/2

diff --git a/=
src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index ffdf8c4=2E=2Ef3631f2 =
100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -81,7 +=
81,6 @@
 
     const struct key_ctx *ctx =3D &opt->key_ctx_bi=2Eencrypt;
  =
   uint8_t *mac_out =3D NULL;
-    const int mac_len =3D OPENVPN_AEAD_TAG_L=
ENGTH;
 
     /* IV, packet-ID and implicit IV required for this mode=2E */=

     ASSERT(ctx->cipher);
@@ -142,7 +141,7 @@
     dmsg(D_PACKET_CONTENT, =
"ENCRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 80, &gc));
 
     /* =
Buffer overflow check */
-    if (!buf_safe(&work, buf->len + mac_len + cip=
her_ctx_block_size(ctx->cipher)))
+    if (!buf_safe(&work, BLENZ(buf) + OP=
ENVPN_AEAD_TAG_LENGTH + cipher_ctx_block_size(ctx->cipher)))
     {
       =
  msg(D_CRYPT_ERRORS, "ENCRYPT: buffer size error, bc=3D%d bo=3D%d bl=3D%d =
wc=3D%d wo=3D%d wl=3D%d",
             buf->capacity, buf->offset, buf->len=
, work=2Ecapacity, work=2Eoffset, work=2Elen);
@@ -156,7 +155,7 @@
     if =
(!use_epoch_data_format)
     {
         /* Reserve space for authenticatio=
n tag */
-        mac_out =3D buf_write_alloc(&work, mac_len);
+        mac=
_out =3D buf_write_alloc(&work, OPENVPN_AEAD_TAG_LENGTH);
         ASSERT(m=
ac_out);
     }
 
@@ -177,12 +176,12 @@
     if (use_epoch_data_format)
   =
  {
         /* Reserve space for authentication tag */
-        mac_out =
=3D buf_write_alloc(&work, mac_len);
+        mac_out =3D buf_write_alloc(&=
work, OPENVPN_AEAD_TAG_LENGTH);
         ASSERT(mac_out);
     }
 
     /* =
Write authentication tag */
-    ASSERT(cipher_ctx_get_tag(ctx->cipher, mac=
_out, mac_len));
+    ASSERT(cipher_ctx_get_tag(ctx->cipher, mac_out, OPENV=
PN_AEAD_TAG_LENGTH));
 
     *buf =3D work;
 
@@ -453,9 +452,6 @@
         =
CRYPT_DROP("Decryption failed verification limit reached=2E");
     }
 
-  =
  const int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;
-
-
     ASSERT(frame);
 =
    ASSERT(buf->len > 0);
     ASSERT(ctx->cipher);
@@ -470,14 +466,14 @@
 =
    ASSERT(packet_id_initialized(&opt->packet_id));
 
     /* Ensure that t=
he packet size is long enough */
-    int min_packet_len =3D packet_id_size=
(false) + tag_size + 1;
+    size_t min_packet_len =3D packet_id_size(false=
) + OPENVPN_AEAD_TAG_LENGTH + 1;
 
     if (use_epoch_data_format)
     {
 =
        min_packet_len +=3D sizeof(uint32_t);
     }
 
-    if (buf->len < =
min_packet_len)
+    if (BLENZ(buf) < min_packet_len)
     {
         CRYPT=
_ERROR("missing IV info, missing tag or no payload");
     }
@@ -540,24 +53=
6,24 @@
         }
     }
 
-    const int ad_size =3D (int)(BPTR(buf) - ad=
_start);
+    const uintptr_t ad_size =3D (uintptr_t)(BPTR(buf) - ad_start)=
;
 
     uint8_t *tag_ptr =3D NULL;
     int data_len =3D 0;
 
     if (use=
_epoch_data_format)
     {
-        data_len =3D BLEN(buf) - tag_size;
+   =
     data_len =3D BLEN(buf) - OPENVPN_AEAD_TAG_LENGTH;
         tag_ptr =3D=
 BPTR(buf) + data_len;
     }
     else
     {
         tag_ptr =3D BPTR(bu=
f);
-        ASSERT(buf_advance(buf, tag_size));
+        ASSERT(buf_advanc=
e(buf, OPENVPN_AEAD_TAG_LENGTH));
         data_len =3D BLEN(buf);
     }
 =

-    dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex(tag_ptr, tag_siz=
e, 0, &gc));
+    dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex(tag_=
ptr, OPENVPN_AEAD_TAG_LENGTH, 0, &gc));
     dmsg(D_PACKET_CONTENT, "DECRYP=
T FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 0, &gc));
 
     /* Buffer o=
verflow check (should never fail) */
@@ -567,7 +563,7 @@
     }
 
     /* f=
eed in tag and the authenticated data */
-    ASSERT(cipher_ctx_update_ad(c=
tx->cipher, ad_start, ad_size));
+    ASSERT(cipher_ctx_update_ad(ctx->ciph=
er, ad_start, (int)ad_size));
     dmsg(D_PACKET_CONTENT, "DECRYPT AD: %s",=
 format_hex(ad_start, ad_size, 0, &gc));
 
     /* Decrypt and authenticate=
 packet */
@@ -578,7 +574,7 @@
     }
 
     ASSERT(buf_inc_len(&work, outl=
en));
-    if (!cipher_ctx_final_check_tag(ctx->cipher, BPTR(&work) + outle=
n, &outlen, tag_ptr, tag_size))
+    if (!cipher_ctx_final_check_tag(ctx->c=
ipher, BPTR(&work) + outlen, &outlen, tag_ptr, OPENVPN_AEAD_TAG_LENGTH))
  =
   {
         ctx->failed_verifications++;
         CRYPT_DROP("packet tag =
authentication failed");
@@ -1118,20 +1114,19 @@
 static void
 generate_key=
_random(struct key *key)
 {
-    int cipher_len =3D MAX_CIPHER_KEY_LENGTH;
=
-    int hmac_len =3D MAX_HMAC_KEY_LENGTH;
-
     struct gc_arena gc =3D gc=
_new();
 
     CLEAR(*key);
-    if (!rand_bytes(key->cipher, cipher_len) |=
| !rand_bytes(key->hmac, hmac_len))
+    if (!rand_bytes(key->cipher, MAX_C=
IPHER_KEY_LENGTH)
+        || !rand_bytes(key->hmac, MAX_HMAC_KEY_LENGTH))
=
     {
         msg(M_FATAL, "ERROR: Random number generator cannot obtain =
entropy for key generation");
     }
 
     dmsg(D_SHOW_KEY_SOURCE, "Cipher=
 source entropy: %s",
-         format_hex(key->cipher, cipher_len, 0, &gc)=
);
-    dmsg(D_SHOW_KEY_SOURCE, "HMAC source entropy: %s", format_hex(key->=
hmac, hmac_len, 0, &gc));
+         format_hex(key->cipher, MAX_CIPHER_KEY_=
LENGTH, 0, &gc));
+    dmsg(D_SHOW_KEY_SOURCE, "HMAC source entropy: %s",
+=
         format_hex(key->hmac, MAX_HMAC_KEY_LENGTH, 0, &gc));
 
     gc_fre=
e(&gc);
 }
diff --git a/src/openvpn/crypto_epoch=2Ec b/src/openvpn/crypto_e=
poch=2Ec
index 243b5a2=2E=2Ee0fc099 100644
--- a/src/openvpn/crypto_epoch=
=2Ec
+++ b/src/openvpn/crypto_epoch=2Ec
@@ -51,26 +51,23 @@
     hmac_ctx_i=
nit(hmac_ctx, secret, "SHA256");
 
     ASSERT(info_len <=3D INT_MAX);
-   =
 const unsigned int digest_size =3D SHA256_DIGEST_LENGTH;
 
     /* T(0) =
=3D empty string */
     uint8_t t_prev[SHA256_DIGEST_LENGTH];
-    unsigne=
d int t_prev_len =3D 0;
 
-    for (uint8_t block =3D 1; (block - 1) * dige=
st_size < out_len; block++)
+    for (uint8_t block =3D 1; (block - 1u) * S=
HA256_DIGEST_LENGTH < out_len; block++)
     {
         hmac_ctx_reset(hmac=
_ctx);
 
         /* calculate T(block) */
-        hmac_ctx_update(hmac_ct=
x, t_prev, t_prev_len);
+        hmac_ctx_update(hmac_ctx, t_prev, block =
=3D=3D 1 ? 0 : SHA256_DIGEST_LENGTH);
         hmac_ctx_update(hmac_ctx, in=
fo, (int)info_len);
         hmac_ctx_update(hmac_ctx, &block, 1);
        =
 hmac_ctx_final(hmac_ctx, t_prev);
-        t_prev_len =3D digest_size;
 
 =
        /* Copy a full hmac output or remaining bytes */
-        size_t ou=
t_offset =3D (block - 1) * digest_size;
-        size_t copylen =3D min_siz=
e(digest_size, out_len - out_offset);
+        size_t out_offset =3D (block=
 - 1u) * SHA256_DIGEST_LENGTH;
+        size_t copylen =3D min_size(SHA256_=
DIGEST_LENGTH, out_len - out_offset);
 
         memcpy(out + out_offset, t=
_prev, copylen);
     }
diff --git a/src/openvpn/packet_id=2Eh b/src/openvp=
n/packet_id=2Eh
index 48752d3=2E=2E782dd58 100644
--- a/src/openvpn/packet_=
id=2Eh
+++ b/src/openvpn/packet_id=2Eh
@@ -312,7 +312,7 @@
 const char *pac=
ket_id_net_print(const struct packet_id_net *pin, bool print_timestamp,
   =
                              struct gc_arena *gc);
 
-static inline int
+s=
tatic inline unsigned int
 packet_id_size(bool long_form)
 {
     return si=
zeof(packet_id_type) + (long_form ? sizeof(net_time_t) : 0);
diff --git a/s=
rc/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index 2dadc4f=2E=2E7eb=
83ce 100644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec=

@@ -52,7 +52,7 @@
     return create_kt("AES-256-CTR", "SHA256", "tls-cryp=
t");
 }
 
-int
+unsigned int
 tls_crypt_buf_overhead(void)
 {
     return p=
acket_id_size(true) + TLS_CRYPT_TAG_SIZE + TLS_CRYPT_BLOCK_SIZE;
diff --git=
 a/src/openvpn/tls_crypt=2Eh b/src/openvpn/tls_crypt=2Eh
index d179cbb=2E=
=2E8e5567f 100644
--- a/src/openvpn/tls_crypt=2Eh
+++ b/src/openvpn/tls_cry=
pt=2Eh
@@ -130,7 +130,7 @@
  * Returns the maximum overhead (in bytes) adde=
d to the destination buffer by
  * tls_crypt_wrap()=2E
  */
-int tls_crypt_=
buf_overhead(void);
+unsigned int tls_crypt_buf_overhead(void);
 
 /**
  * =
Wrap a control channel packet (both authenticates and encrypts the data)=2E=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3bcb4cb8e17ff=
80a5cb8acdaf18d1072159184e5
Gerrit-Change-Number: 2158
Gerrit-PatchSet: 2
G=
errit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: A=
rne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>

--fzcGajrQBJw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail">View Change</a></p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">crypto*: Avoid sign conversion warnings by using defines directly<br=
><br>Using the defines directly avoids the issue with sign<br>conversion by=
 letting the compiler deduce the types of<br>the literals=2E<br><br>I do no=
t think that using an intermediate variabl<br>increases the readability=2E<=
br><br>Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5<br>Signed-off-b=
y: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvp=
n/crypto=2Ec<br>M src/openvpn/crypto_epoch=2Ec<br>M src/openvpn/packet_id=
=2Eh<br>M src/openvpn/tls_crypt=2Ec<br>M src/openvpn/tls_crypt=2Eh<br>5 fil=
es changed, 24 insertions(+), 32 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/2158/2</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><b=
r><span>index ffdf8c4=2E=2Ef3631f2 100644</span><br><span>--- a/src/openvpn=
/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@=
 -81,7 +81,6 @@</span><br><span> </span><br><span>     const struct key_ctx=
 *ctx =3D &amp;opt-&gt;key_ctx_bi=2Eencrypt;</span><br><span>     uint8_t *=
mac_out =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
const int mac_len =3D OPENVPN_AEAD_TAG_LENGTH;</span><br><span> </span><br>=
<span>     /* IV, packet-ID and implicit IV required for this mode=2E */</s=
pan><br><span>     ASSERT(ctx-&gt;cipher);</span><br><span>@@ -142,7 +141,7=
 @@</span><br><span>     dmsg(D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot=
;, format_hex(BPTR(buf), BLENZ(buf), 80, &amp;gc));</span><br><span> </span=
><br><span>     /* Buffer overflow check */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!buf_safe(&amp;work, buf-&gt;len + mac_len + =
cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!buf_safe(&amp;work, BLENZ(buf) + OPENVPN_AEAD_=
TAG_LENGTH + cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><span>     {=
</span><br><span>         msg(D_CRYPT_ERRORS, &quot;ENCRYPT: buffer size er=
ror, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d&quot;,</span><br><span=
>             buf-&gt;capacity, buf-&gt;offset, buf-&gt;len, work=2Ecapacit=
y, work=2Eoffset, work=2Elen);</span><br><span>@@ -156,7 +155,7 @@</span><b=
r><span>     if (!use_epoch_data_format)</span><br><span>     {</span><br><=
span>         /* Reserve space for authentication tag */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        mac_out =3D buf_write_alloc(&amp=
;work, mac_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     mac_out =3D buf_write_alloc(&amp;work, OPENVPN_AEAD_TAG_LENGTH);</span=
><br><span>         ASSERT(mac_out);</span><br><span>     }</span><br><span=
> </span><br><span>@@ -177,12 +176,12 @@</span><br><span>     if (use_epoch=
_data_format)</span><br><span>     {</span><br><span>         /* Reserve sp=
ace for authentication tag */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        mac_out =3D buf_write_alloc(&amp;work, mac_len);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        mac_out =3D buf_write_=
alloc(&amp;work, OPENVPN_AEAD_TAG_LENGTH);</span><br><span>         ASSERT(=
mac_out);</span><br><span>     }</span><br><span> </span><br><span>     /* =
Write authentication tag */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    ASSERT(cipher_ctx_get_tag(ctx-&gt;cipher, mac_out, mac_len));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(cipher_ctx_g=
et_tag(ctx-&gt;cipher, mac_out, OPENVPN_AEAD_TAG_LENGTH));</span><br><span>=
 </span><br><span>     *buf =3D work;</span><br><span> </span><br><span>@@ =
-453,9 +452,6 @@</span><br><span>         CRYPT_DROP(&quot;Decryption faile=
d verification limit reached=2E&quot;);</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int ta=
g_size =3D OPENVPN_AEAD_TAG_LENGTH;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span>     ASSERT(frame);</span><br><span>     ASSERT(buf-&gt;len &gt; =
0);</span><br><span>     ASSERT(ctx-&gt;cipher);</span><br><span>@@ -470,14=
 +466,14 @@</span><br><span>     ASSERT(packet_id_initialized(&amp;opt-&gt;=
packet_id));</span><br><span> </span><br><span>     /* Ensure that the pack=
et size is long enough */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    int min_packet_len =3D packet_id_size(false) + tag_size + 1;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t min_packet_len =
=3D packet_id_size(false) + OPENVPN_AEAD_TAG_LENGTH + 1;</span><br><span> <=
/span><br><span>     if (use_epoch_data_format)</span><br><span>     {</spa=
n><br><span>         min_packet_len +=3D sizeof(uint32_t);</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (buf-&gt;len &lt; min_packet_len)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (BLENZ(buf) &lt; min_packet_len)</span><br><=
span>     {</span><br><span>         CRYPT_ERROR(&quot;missing IV info, mis=
sing tag or no payload&quot;);</span><br><span>     }</span><br><span>@@ -5=
40,24 +536,24 @@</span><br><span>         }</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const in=
t ad_size =3D (int)(BPTR(buf) - ad_start);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const uintptr_t ad_size =3D (uintptr_t)(BPTR(buf=
) - ad_start);</span><br><span> </span><br><span>     uint8_t *tag_ptr =3D =
NULL;</span><br><span>     int data_len =3D 0;</span><br><span> </span><br>=
<span>     if (use_epoch_data_format)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        data_len =3D BLEN(buf) - tag=
_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        data_=
len =3D BLEN(buf) - OPENVPN_AEAD_TAG_LENGTH;</span><br><span>         tag_p=
tr =3D BPTR(buf) + data_len;</span><br><span>     }</span><br><span>     el=
se</span><br><span>     {</span><br><span>         tag_ptr =3D BPTR(buf);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(buf_adva=
nce(buf, tag_size));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        ASSERT(buf_advance(buf, OPENVPN_AEAD_TAG_LENGTH));</span><br><span=
>         data_len =3D BLEN(buf);</span><br><span>     }</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONT=
ENT, &quot;DECRYPT MAC: %s&quot;, format_hex(tag_ptr, tag_size, 0, &amp;gc)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET=
_CONTENT, &quot;DECRYPT MAC: %s&quot;, format_hex(tag_ptr, OPENVPN_AEAD_TAG=
_LENGTH, 0, &amp;gc));</span><br><span>     dmsg(D_PACKET_CONTENT, &quot;DE=
CRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLENZ(buf), 0, &amp;gc));</span=
><br><span> </span><br><span>     /* Buffer overflow check (should never fa=
il) */</span><br><span>@@ -567,7 +563,7 @@</span><br><span>     }</span><br=
><span> </span><br><span>     /* feed in tag and the authenticated data */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(cipher_ctx_=
update_ad(ctx-&gt;cipher, ad_start, ad_size));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    ASSERT(cipher_ctx_update_ad(ctx-&gt;cipher, =
ad_start, (int)ad_size));</span><br><span>     dmsg(D_PACKET_CONTENT, &quot=
;DECRYPT AD: %s&quot;, format_hex(ad_start, ad_size, 0, &amp;gc));</span><b=
r><span> </span><br><span>     /* Decrypt and authenticate packet */</span>=
<br><span>@@ -578,7 +574,7 @@</span><br><span>     }</span><br><span> </spa=
n><br><span>     ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (!cipher_ctx_final_check_tag(ctx-=
&gt;cipher, BPTR(&amp;work) + outlen, &amp;outlen, tag_ptr, tag_size))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!cipher_ctx_fina=
l_check_tag(ctx-&gt;cipher, BPTR(&amp;work) + outlen, &amp;outlen, tag_ptr,=
 OPENVPN_AEAD_TAG_LENGTH))</span><br><span>     {</span><br><span>         =
ctx-&gt;failed_verifications++;</span><br><span>         CRYPT_DROP(&quot;p=
acket tag authentication failed&quot;);</span><br><span>@@ -1118,20 +1114,1=
9 @@</span><br><span> static void</span><br><span> generate_key_random(stru=
ct key *key)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    int cipher_len =3D MAX_CIPHER_KEY_LENGTH;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    int hmac_len =3D MAX_HMAC_KEY_LENGTH;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>    =
 struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>     CL=
EAR(*key);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!ra=
nd_bytes(key-&gt;cipher, cipher_len) || !rand_bytes(key-&gt;hmac, hmac_len)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!rand_byte=
s(key-&gt;cipher, MAX_CIPHER_KEY_LENGTH)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        || !rand_bytes(key-&gt;hmac, MAX_HMAC_KEY_LENG=
TH))</span><br><span>     {</span><br><span>         msg(M_FATAL, &quot;ERR=
OR: Random number generator cannot obtain entropy for key generation&quot;)=
;</span><br><span>     }</span><br><span> </span><br><span>     dmsg(D_SHOW=
_KEY_SOURCE, &quot;Cipher source entropy: %s&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         format_hex(key-&gt;cipher, cipher_=
len, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 dmsg(D_SHOW_KEY_SOURCE, &quot;HMAC source entropy: %s&quot;, format_hex(ke=
y-&gt;hmac, hmac_len, 0, &amp;gc));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+         format_hex(key-&gt;cipher, MAX_CIPHER_KEY_LENGTH, =
0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dm=
sg(D_SHOW_KEY_SOURCE, &quot;HMAC source entropy: %s&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+         format_hex(key-&gt;hmac, MA=
X_HMAC_KEY_LENGTH, 0, &amp;gc));</span><br><span> </span><br><span>     gc_=
free(&amp;gc);</span><br><span> }</span><br><span>diff --git a/src/openvpn/=
crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec</span><br><span>index 243b5=
a2=2E=2Ee0fc099 100644</span><br><span>--- a/src/openvpn/crypto_epoch=2Ec</=
span><br><span>+++ b/src/openvpn/crypto_epoch=2Ec</span><br><span>@@ -51,26=
 +51,23 @@</span><br><span>     hmac_ctx_init(hmac_ctx, secret, &quot;SHA25=
6&quot;);</span><br><span> </span><br><span>     ASSERT(info_len &lt;=3D IN=
T_MAX);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const unsi=
gned int digest_size =3D SHA256_DIGEST_LENGTH;</span><br><span> </span><br>=
<span>     /* T(0) =3D empty string */</span><br><span>     uint8_t t_prev[=
SHA256_DIGEST_LENGTH];</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    unsigned int t_prev_len =3D 0;</span><br><span> </span><br><span style=
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
it-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acda=
f18d1072159184e5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2158 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--fzcGajrQBJw=--


--===============0721360399804094466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0721360399804094466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0721360399804094466==--

