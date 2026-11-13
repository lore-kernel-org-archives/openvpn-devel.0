Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C84606A895
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 22:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=c0d5NkJ0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BEJTw2+Y;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aY3zWr2b;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=MOeG+zFo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=WgGskZwPck+OFhuI9ST7zqZBcCM6AvE/d9JOoen/8r4=; b=c0d5NkJ01TQU7fx455X+4hmJvF
	XBUpZIB+hD6v+s2MR0IrGLWNqklrMrAencW+RozdMv/1XHG6V9OxAQdXqRslQsbiPL6/SvW5G6tsh
	ptbbwCV23wwkHFjDKkypv62GqANAd1ze8Gd5CsxF8eS94xMeXnXxuBwi3Ffsmv++c5Po=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRzdx-0000000079R-1qA6;
	Fri, 13 Nov 2026 22:21:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRzdv-0000000079J-0jBm
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:21:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eWk9xLrvwAzWasqczTMqgvSaEsv83h+E2cOvw8iYGxw=; b=BEJTw2+YHgrkhegz7+hKoGx8bx
 svST/Q543zVhbywN9xCLHs4gEW7m5EruV9ZOiCDjr6RIUeXJhEcH19DGSOWbLSYuVJbm2ijaexq+w
 y3/R0UVYR3cUnUfKu7CEtak+wrrO9PMjNiPJU4ytKx5wLj6K48fLDvXSp0pC6P7WcWwI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eWk9xLrvwAzWasqczTMqgvSaEsv83h+E2cOvw8iYGxw=; b=aY3zWr2bdf7hCVHiFQs1ihTi/D
 zg38OJMYGz03oDTaGMtlgEm/+iCWMMcafEFiDFoRsBRZB38TTUQgvF0auMaw0pyH0oE3kC67vLGpE
 pN/bkyYDAi/yB+2CZTrfcB5HDvrp4Uxy685QD6GAT7ov4e4/0Vpp5OykHbqDgRKqZJeU=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRzdt-000000006PK-0elj for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 22:21:11 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so12236815e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 14:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794608463; x=1795213263; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eWk9xLrvwAzWasqczTMqgvSaEsv83h+E2cOvw8iYGxw=;
 b=MOeG+zFobGytajLzF5MaJFYvFIu6aQbUrWVPwpf3bUnbMke/TvpfVcr0cuq9Hp5JRP
 LUH5UN3g4nQaE4MNeScOtp4Gb6w2xT6YNiTJEIw6HjYRhuDSBlHY/+4RonMmP0jVPzDM
 O3ZtdSI9/sDCjRAyFBKVaKFlENtjyCdb8giE93pt6A+taxnf56z5pHKE0OsM5bBoWFO7
 v81zqpMNxLETFwAA/sHJJPA4jKPwBIBNFq5yZRbBGqZWSa+3h+G6SFT8HxOcJwjGrdqL
 CZhKnX+jGAg3peFWJn1hr30g0tGGwifZNHphzLjH3R+JjJle3ITRXKtse3hZu8NKrx3w
 ScBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794608463; x=1795213263;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eWk9xLrvwAzWasqczTMqgvSaEsv83h+E2cOvw8iYGxw=;
 b=uMPFt+rXpwVU2Imys0usYCGKG6Cjy6o2XaRQKbFWCgqS31SqkOINAcgKbG3F6KAYil
 XMQwRdG//RPzwBxZ8HkWHFjlLzGfoQEok2csNoJ+Dhzs+eGL0l1eeY4jPLB4kUbksxUA
 tJm/BIkK++VnnkjFWnFhvR3jMJQaqxvjqPparX2P4Q5U6zqXwYzUNg7bI1M0caKc+crc
 ViFxE+K1vgcsGQWG8r6pz9iaDVYJYZlmKWpzzueFvdlBRt8UuhLVYzEkORHtmBNhFD3s
 dERRANbF1edKPRrYXSNvkISOcpvRtBdhS8105kyR4x51JQRfaZP9MeE4BCwqgaLGemV2
 dHGA==
X-Forwarded-Encrypted: i=1;
 AL+hErHZ1xdIMiBKSwLz9c4LSz0QEwnd9AjCVQ3O8BYdcy91F2iGkfOMhn7QIH8lhVZ+orC4cNfhfm/T1GWQCqvX@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9HSVJO1To5ePoPwBrMEUP3kZ0MblA7MBs7zA64I3Epu7CBqbUK
 9jaCukDaDFs9rQcrFrMUkZsjFT6XpIwAx2UTbW3M1b0IPJLHUcUUV0FQO/MCfMAC05L9eTpV+Ep
 x6QlvvRMVIw5p3M06pjTRcK3ws1rXLTc1c7QnNPyxps7FVATms7SG2zNUUomwCoxRJyUKS1U690
 FBNUrWRA==
X-Gm-Gg: AYBFou2VdAQnxtcCDIxR83e78NKQu2Ls3+qVPBIzkC0jufOYHxRHhsYylioFYrmT9d+
 lW88BGgn7U0ZTBaEsaICWsoM8NA6h2hB5uzdJ1vu33TUdr5X791/eTxU6B93NMcjELEpjktIzsh
 iza6/pnAV+s9B9wgvjCrS2nBHc7aOXMPIXtgMCYaOiZeYE9qz3UxsCtUk2X1GZgWArA1f0zSEYq
 BPoQR8z7YOek0uhOX6gQ8SamuqWmTmbOdBgbcqO6oMnb6LrHATgSWTxOh4V3NO0VlF5XoYApu5B
 7TVDbzjcMUTKpbBVhy6tyhFqZ1J1C1LdaRtn4zaP3Iin912nmnbnyjqjCQvVP/NubBjL4Ccueiq
 lmM6sns0u+ZzHzO+0F0GEl9Pd5vPS9vhYyETaxbYZioWnwjpxZhlNFQQxVy3FBcUGJgwDkue5gt
 8zMIbl1MFGUuhsoqpgwYbhY5GQlEnbx3a4sVt5tHTSdMzR4ffWMNT7dxMmAh98zYE8r8nVN0o3D
 QRVcr/QWfaCpxe+Kv/xcBk8Lmwi3QLqjacxTFNbFrBUZDTWGCjKuoITRPOdnNmrEfqiThOZmAju
 thCiVJKIc4yTuFpqBao46PDUua4MRnuBwO2nuXYJC28D05UK55Br6yQfhtCvgVin4HZdLMgW0VQ
 WDO4Ypa5/5ca8G+Sto2TLEPhtKh3NBRdJibLUD/i/PSaPJrPFn0/kbP65u2ujHtvFzURkjcfUd2
 CwHi7McEJgzNbUAZk=
X-Received: by 2002:a05:600c:6912:b0:4ba:59fa:510e with SMTP id
 5b1f17b1804b1-4bb55ab411dmr85684555e9.23.1794608462270; 
 Fri, 13 Nov 2026 14:21:02 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e293540sm185206815e9.8.2026.11.13.14.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 14:21:01 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 22:21:01 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
X-Gerrit-Change-Number: 2158
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2158?usp=email>
X-Gerrit-Commit: bf7c8d16730fd21ac290ad508404f6efcbdfc8a4
In-Reply-To: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
References: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkzYmNiNGNiOGUxN2ZmODBhNWNiOGFjZGFmMThkMTA3MjE1OTE4NGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <025c54681c031ae5ede81fbf52edb4496c078416-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRzdt-000000006PK-0elj
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4512826556114049085=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4512826556114049085==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Jkt2Ob6kdJk="; charset=UTF-8

--Jkt2Ob6kdJk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2158?usp=3Demail )

Change subject: crypto*: Avoid sign convers=
ion warnings by using defines directly
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

crypto*: Avoid sign conversion warnings by using =
defines directly

Using the defines directly avoids the issue with sign
con=
version by letting the compiler deduce the types of
the literals=2E

I do n=
ot think that using an intermediate variable
increases the readability=2E

=
Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
Signed-off-by: Frank L=
ichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mai=
lbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158
Mes=
sage-Id: <20261111183144=2E18676-1-gert@greenie=2Emuc=2Ede>
URL: https://lo=
re=2Ekernel=2Eorg/openvpn-devel/20261111183144=2E18676-1-gert@greenie=2Emuc=
=2Ede
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openv=
pn/crypto=2Ec
M src/openvpn/crypto_epoch=2Ec
M src/openvpn/packet_id=2Eh
M =
src/openvpn/tls_crypt=2Ec
M src/openvpn/tls_crypt=2Eh
M tests/unit_tests/op=
envpn/test_tls_crypt=2Ec
6 files changed, 24 insertions(+), 50 deletions(-)=





diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index 5ad=
4b5f=2E=2Edb1cb41 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/cry=
pto=2Ec
@@ -81,7 +81,6 @@
 
     const struct key_ctx *ctx =3D &opt->key_ct=
x_bi=2Eencrypt;
     uint8_t *mac_out =3D NULL;
-    const int mac_len =3D =
OPENVPN_AEAD_TAG_LENGTH;
 
     /* IV, packet-ID and implicit IV required f=
or this mode=2E */
     ASSERT(ctx->cipher);
@@ -142,7 +141,7 @@
     dmsg(=
D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 80,=
 &gc));
 
     /* Buffer overflow check */
-    if (!buf_safe(&work, buf->l=
en + mac_len + cipher_ctx_block_size(ctx->cipher)))
+    if (!buf_safe(&wor=
k, BLENZ(buf) + OPENVPN_AEAD_TAG_LENGTH + cipher_ctx_block_size(ctx->cipher=
)))
     {
         msg(D_CRYPT_ERRORS, "ENCRYPT: buffer size error, bc=3D%=
d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d",
             buf->capacity, buf=
->offset, buf->len, work=2Ecapacity, work=2Eoffset, work=2Elen);
@@ -156,7 =
+155,7 @@
     if (!use_epoch_data_format)
     {
         /* Reserve space=
 for authentication tag */
-        mac_out =3D buf_write_alloc(&work, mac_=
len);
+        mac_out =3D buf_write_alloc(&work, OPENVPN_AEAD_TAG_LENGTH);=

         ASSERT(mac_out);
     }
 
@@ -177,12 +176,12 @@
     if (use_epoc=
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
 
     /* Write authentication tag */
-    ASSERT(cipher_ctx_get_tag(=
ctx->cipher, mac_out, mac_len));
+    ASSERT(cipher_ctx_get_tag(ctx->cipher=
, mac_out, OPENVPN_AEAD_TAG_LENGTH));
 
     *buf =3D work;
 
@@ -449,9 +44=
8,6 @@
         CRYPT_DROP("Decryption failed verification limit reached=2E=
");
     }
 
-    const int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;
-
-
     =
ASSERT(frame);
     ASSERT(buf->len > 0);
     ASSERT(ctx->cipher);
@@ -466=
,14 +462,14 @@
     ASSERT(packet_id_initialized(&opt->packet_id));
 
     =
/* Ensure that the packet size is long enough */
-    int min_packet_len =
=3D packet_id_size(false) + tag_size + 1;
+    size_t min_packet_len =3D pa=
cket_id_size(false) + OPENVPN_AEAD_TAG_LENGTH + 1;
 
     if (use_epoch_dat=
a_format)
     {
         min_packet_len +=3D sizeof(uint32_t);
     }
 
- =
   if (buf->len < min_packet_len)
+    if (BLENZ(buf) < min_packet_len)
   =
  {
         CRYPT_ERROR("missing IV info, missing tag or no payload");
   =
  }
@@ -536,24 +532,24 @@
         }
     }
 
-    const int ad_size =3D (i=
nt)(BPTR(buf) - ad_start);
+    const uintptr_t ad_size =3D (uintptr_t)(BPT=
R(buf) - ad_start);
 
     uint8_t *tag_ptr =3D NULL;
     int data_len =3D=
 0;
 
     if (use_epoch_data_format)
     {
-        data_len =3D BLEN(buf=
) - tag_size;
+        data_len =3D BLEN(buf) - OPENVPN_AEAD_TAG_LENGTH;
  =
       tag_ptr =3D BPTR(buf) + data_len;
     }
     else
     {
         t=
ag_ptr =3D BPTR(buf);
-        ASSERT(buf_advance(buf, tag_size));
+       =
 ASSERT(buf_advance(buf, OPENVPN_AEAD_TAG_LENGTH));
         data_len =3D B=
LEN(buf);
     }
 
-    dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s", format_he=
x(tag_ptr, tag_size, 0, &gc));
+    dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s=
", format_hex(tag_ptr, OPENVPN_AEAD_TAG_LENGTH, 0, &gc));
     dmsg(D_PACKE=
T_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 0, &gc));
=
 
     /* Buffer overflow check (should never fail) */
@@ -563,7 +559,7 @@
=
     }
 
     /* feed in tag and the authenticated data */
-    ASSERT(ciph=
er_ctx_update_ad(ctx->cipher, ad_start, ad_size));
+    ASSERT(cipher_ctx_u=
pdate_ad(ctx->cipher, ad_start, (int)ad_size));
     dmsg(D_PACKET_CONTENT,=
 "DECRYPT AD: %s", format_hex(ad_start, ad_size, 0, &gc));
 
     /* Decryp=
t and authenticate packet */
@@ -574,7 +570,7 @@
     }
 
     ASSERT(buf_i=
nc_len(&work, outlen));
-    if (!cipher_ctx_final_check_tag(ctx->cipher, B=
PTR(&work) + outlen, &outlen, tag_ptr, tag_size))
+    if (!cipher_ctx_fina=
l_check_tag(ctx->cipher, BPTR(&work) + outlen, &outlen, tag_ptr, OPENVPN_AE=
AD_TAG_LENGTH))
     {
         ctx->failed_verifications++;
         CRYPT=
_DROP("packet tag authentication failed");
@@ -1114,20 +1110,19 @@
 static =
void
 generate_key_random(struct key *key)
 {
-    int cipher_len =3D MAX_C=
IPHER_KEY_LENGTH;
-    int hmac_len =3D MAX_HMAC_KEY_LENGTH;
-
     struct =
gc_arena gc =3D gc_new();
 
     CLEAR(*key);
-    if (!rand_bytes(key->cip=
her, cipher_len) || !rand_bytes(key->hmac, hmac_len))
+    if (!rand_bytes(=
key->cipher, MAX_CIPHER_KEY_LENGTH)
+        || !rand_bytes(key->hmac, MAX_=
HMAC_KEY_LENGTH))
     {
         msg(M_FATAL, "ERROR: Random number genera=
tor cannot obtain entropy for key generation");
     }
 
     dmsg(D_SHOW_K=
EY_SOURCE, "Cipher source entropy: %s",
-         format_hex(key->cipher, c=
ipher_len, 0, &gc));
-    dmsg(D_SHOW_KEY_SOURCE, "HMAC source entropy: %s"=
, format_hex(key->hmac, hmac_len, 0, &gc));
+         format_hex(key->ciphe=
r, MAX_CIPHER_KEY_LENGTH, 0, &gc));
+    dmsg(D_SHOW_KEY_SOURCE, "HMAC sour=
ce entropy: %s",
+         format_hex(key->hmac, MAX_HMAC_KEY_LENGTH, 0, &g=
c));
 
     gc_free(&gc);
 }
diff --git a/src/openvpn/crypto_epoch=2Ec b/sr=
c/openvpn/crypto_epoch=2Ec
index 243b5a2=2E=2E40e8cec 100644
--- a/src/open=
vpn/crypto_epoch=2Ec
+++ b/src/openvpn/crypto_epoch=2Ec
@@ -38,11 +38,6 @@
=
 #include "buffer=2Eh"
 #include "integer=2Eh"
 
-#if defined(__GNUC__) || =
defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ign=
ored "-Wsign-conversion"
-#endif
-
 void
 ovpn_hkdf_expand(const uint8_t *s=
ecret, const uint8_t *info, size_t info_len,
                  uint8_t *out=
, size_t out_len)
@@ -51,26 +46,23 @@
     hmac_ctx_init(hmac_ctx, secret, =
"SHA256");
 
     ASSERT(info_len <=3D INT_MAX);
-    const unsigned int di=
gest_size =3D SHA256_DIGEST_LENGTH;
 
     /* T(0) =3D empty string */
    =
 uint8_t t_prev[SHA256_DIGEST_LENGTH];
-    unsigned int t_prev_len =3D 0;
=
 
-    for (uint8_t block =3D 1; (block - 1) * digest_size < out_len; block=
++)
+    for (uint8_t block =3D 1; (block - 1u) * SHA256_DIGEST_LENGTH < ou=
t_len; block++)
     {
         hmac_ctx_reset(hmac_ctx);
 
         /* cal=
culate T(block) */
-        hmac_ctx_update(hmac_ctx, t_prev, t_prev_len);
=
+        hmac_ctx_update(hmac_ctx, t_prev, block =3D=3D 1 ? 0 : SHA256_DIGE=
ST_LENGTH);
         hmac_ctx_update(hmac_ctx, info, (int)info_len);
      =
   hmac_ctx_update(hmac_ctx, &block, 1);
         hmac_ctx_final(hmac_ctx, =
t_prev);
-        t_prev_len =3D digest_size;
 
         /* Copy a full hma=
c output or remaining bytes */
-        size_t out_offset =3D (block - 1) *=
 digest_size;
-        size_t copylen =3D min_size(digest_size, out_len - o=
ut_offset);
+        size_t out_offset =3D (block - 1u) * SHA256_DIGEST_LEN=
GTH;
+        size_t copylen =3D min_size(SHA256_DIGEST_LENGTH, out_len - o=
ut_offset);
 
         memcpy(out + out_offset, t_prev, copylen);
     }
@@=
 -463,7 +455,3 @@
         epoch_iterate_send_key(opt);
     }
 }
-
-#if de=
fined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
d=
iff --git a/src/openvpn/packet_id=2Eh b/src/openvpn/packet_id=2Eh
index c37=
4ccb=2E=2E08a0f78 100644
--- a/src/openvpn/packet_id=2Eh
+++ b/src/openvpn/=
packet_id=2Eh
@@ -249,7 +249,7 @@
 const char *packet_id_net_print(const st=
ruct packet_id_net *pin, bool print_timestamp,
                            =
     struct gc_arena *gc);
 
-static inline int
+static inline unsigned int=

 packet_id_size(bool long_form)
 {
     return sizeof(packet_id_type) + (l=
ong_form ? sizeof(net_time_t) : 0);
diff --git a/src/openvpn/tls_crypt=2Ec =
b/src/openvpn/tls_crypt=2Ec
index e59f55b=2E=2E08d9fcd 100644
--- a/src/ope=
nvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -52,7 +52,7 @@
     r=
eturn create_kt("AES-256-CTR", "SHA256", "tls-crypt");
 }
 
-int
+unsigned =
int
 tls_crypt_buf_overhead(void)
 {
     return packet_id_size(true) + TLS=
_CRYPT_TAG_SIZE + TLS_CRYPT_BLOCK_SIZE;
diff --git a/src/openvpn/tls_crypt=
=2Eh b/src/openvpn/tls_crypt=2Eh
index d179cbb=2E=2E8e5567f 100644
--- a/sr=
c/openvpn/tls_crypt=2Eh
+++ b/src/openvpn/tls_crypt=2Eh
@@ -130,7 +130,7 @@=

  * Returns the maximum overhead (in bytes) added to the destination buffe=
r by
  * tls_crypt_wrap()=2E
  */
-int tls_crypt_buf_overhead(void);
+unsig=
ned int tls_crypt_buf_overhead(void);
 
 /**
  * Wrap a control channel pac=
ket (both authenticates and encrypts the data)=2E
diff --git a/tests/unit_t=
ests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=
=2Ec
index 2d31c00=2E=2E00de73a 100644
--- a/tests/unit_tests/openvpn/test_=
tls_crypt=2Ec
+++ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
@@ -232,11 =
+232,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma=
 GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#=
endif
-
 /**
  * Check that short messages are successfully wrapped-and-unw=
rapped=2E
  */
@@ -778,10 +773,6 @@
     tls_wrap_free(&wrap_ctx);
 }
 
-#i=
f defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#end=
if
-
 static void
 test_tls_crypt_v2_write_server_key_file(void **state)
 {=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3bcb4cb8e17ff80a5c=
b8acdaf18d1072159184e5
Gerrit-Change-Number: 2158
Gerrit-PatchSet: 7
Gerrit=
-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>

--Jkt2Ob6kdJk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2158?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">crypto*: Avoid sign conversion war=
nings by using defines directly<br><br>Using the defines directly avoids th=
e issue with sign<br>conversion by letting the compiler deduce the types of=
<br>the literals=2E<br><br>I do not think that using an intermediate variab=
le<br>increases the readability=2E<br><br>Change-Id: I3bcb4cb8e17ff80a5cb8a=
cdaf18d1072159184e5<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158<br>Message-Id: =
&lt;20261111183144=2E18676-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lo=
re=2Ekernel=2Eorg/openvpn-devel/20261111183144=2E18676-1-gert@greenie=2Emuc=
=2Ede<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---=
<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/crypto_epoch=2Ec<br>M src/ope=
nvpn/packet_id=2Eh<br>M src/openvpn/tls_crypt=2Ec<br>M src/openvpn/tls_cryp=
t=2Eh<br>M tests/unit_tests/openvpn/test_tls_crypt=2Ec<br>6 files changed, =
24 insertions(+), 50 deletions(-)<br><br></pre>
<pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn=
/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index 5ad4b5f=2E=2Edb1=
cb41 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>++=
+ b/src/openvpn/crypto=2Ec</span><br><span>@@ -81,7 +81,6 @@</span><br><spa=
n> </span><br><span>     const struct key_ctx *ctx =3D &amp;opt-&gt;key_ctx=
_bi=2Eencrypt;</span><br><span>     uint8_t *mac_out =3D NULL;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    const int mac_len =3D OPENVPN_=
AEAD_TAG_LENGTH;</span><br><span> </span><br><span>     /* IV, packet-ID an=
d implicit IV required for this mode=2E */</span><br><span>     ASSERT(ctx-=
&gt;cipher);</span><br><span>@@ -142,7 +141,7 @@</span><br><span>     dmsg(=
D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLENZ=
(buf), 80, &amp;gc));</span><br><span> </span><br><span>     /* Buffer over=
flow check */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
!buf_safe(&amp;work, buf-&gt;len + mac_len + cipher_ctx_block_size(ctx-&gt;=
cipher)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!b=
uf_safe(&amp;work, BLENZ(buf) + OPENVPN_AEAD_TAG_LENGTH + cipher_ctx_block_=
size(ctx-&gt;cipher)))</span><br><span>     {</span><br><span>         msg(=
D_CRYPT_ERRORS, &quot;ENCRYPT: buffer size error, bc=3D%d bo=3D%d bl=3D%d w=
c=3D%d wo=3D%d wl=3D%d&quot;,</span><br><span>             buf-&gt;capacity=
, buf-&gt;offset, buf-&gt;len, work=2Ecapacity, work=2Eoffset, work=2Elen);=
</span><br><span>@@ -156,7 +155,7 @@</span><br><span>     if (!use_epoch_da=
ta_format)</span><br><span>     {</span><br><span>         /* Reserve space=
 for authentication tag */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        mac_out =3D buf_write_alloc(&amp;work, mac_len);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        mac_out =3D buf_write_all=
oc(&amp;work, OPENVPN_AEAD_TAG_LENGTH);</span><br><span>         ASSERT(mac=
_out);</span><br><span>     }</span><br><span> </span><br><span>@@ -177,12 =
+176,12 @@</span><br><span>     if (use_epoch_data_format)</span><br><span>=
     {</span><br><span>         /* Reserve space for authentication tag */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mac_out =3D bu=
f_write_alloc(&amp;work, mac_len);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        mac_out =3D buf_write_alloc(&amp;work, OPENVPN_AEAD_=
TAG_LENGTH);</span><br><span>         ASSERT(mac_out);</span><br><span>    =
 }</span><br><span> </span><br><span>     /* Write authentication tag */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(cipher_ctx_ge=
t_tag(ctx-&gt;cipher, mac_out, mac_len));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ASSERT(cipher_ctx_get_tag(ctx-&gt;cipher, mac_out=
, OPENVPN_AEAD_TAG_LENGTH));</span><br><span> </span><br><span>     *buf =
=3D work;</span><br><span> </span><br><span>@@ -449,9 +448,6 @@</span><br><=
span>         CRYPT_DROP(&quot;Decryption failed verification limit reached=
=2E&quot;);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const int tag_size =3D OPENVPN_AEAD_TAG=
_LENGTH;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(frame=
);</span><br><span>     ASSERT(buf-&gt;len &gt; 0);</span><br><span>     AS=
SERT(ctx-&gt;cipher);</span><br><span>@@ -466,14 +462,14 @@</span><br><span=
>     ASSERT(packet_id_initialized(&amp;opt-&gt;packet_id));</span><br><spa=
n> </span><br><span>     /* Ensure that the packet size is long enough */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int min_packet_len =
=3D packet_id_size(false) + tag_size + 1;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    size_t min_packet_len =3D packet_id_size(false) +=
 OPENVPN_AEAD_TAG_LENGTH + 1;</span><br><span> </span><br><span>     if (us=
e_epoch_data_format)</span><br><span>     {</span><br><span>         min_pa=
cket_len +=3D sizeof(uint32_t);</span><br><span>     }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len &lt;=
 min_packet_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (BLENZ(buf) &lt; min_packet_len)</span><br><span>     {</span><br><span=
>         CRYPT_ERROR(&quot;missing IV info, missing tag or no payload&quot=
;);</span><br><span>     }</span><br><span>@@ -536,24 +532,24 @@</span><br>=
<span>         }</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const int ad_size =3D (int)(BPTR(bu=
f) - ad_start);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const uintptr_t ad_size =3D (uintptr_t)(BPTR(buf) - ad_start);</span><br><s=
pan> </span><br><span>     uint8_t *tag_ptr =3D NULL;</span><br><span>     =
int data_len =3D 0;</span><br><span> </span><br><span>     if (use_epoch_da=
ta_format)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        data_len =3D BLEN(buf) - tag_size;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        data_len =3D BLEN(buf) - OPENVPN=
_AEAD_TAG_LENGTH;</span><br><span>         tag_ptr =3D BPTR(buf) + data_len=
;</span><br><span>     }</span><br><span>     else</span><br><span>     {</=
span><br><span>         tag_ptr =3D BPTR(buf);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        ASSERT(buf_advance(buf, tag_size));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(buf_advance=
(buf, OPENVPN_AEAD_TAG_LENGTH));</span><br><span>         data_len =3D BLEN=
(buf);</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    dmsg(D_PACKET_CONTENT, &quot;DECRYPT MAC: %s&=
quot;, format_hex(tag_ptr, tag_size, 0, &amp;gc));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;DECRYPT MAC=
: %s&quot;, format_hex(tag_ptr, OPENVPN_AEAD_TAG_LENGTH, 0, &amp;gc));</spa=
n><br><span>     dmsg(D_PACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;, forma=
t_hex(BPTR(buf), BLENZ(buf), 0, &amp;gc));</span><br><span> </span><br><spa=
n>     /* Buffer overflow check (should never fail) */</span><br><span>@@ -=
563,7 +559,7 @@</span><br><span>     }</span><br><span> </span><br><span>  =
   /* feed in tag and the authenticated data */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    ASSERT(cipher_ctx_update_ad(ctx-&gt;cipher, a=
d_start, ad_size));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ASSERT(cipher_ctx_update_ad(ctx-&gt;cipher, ad_start, (int)ad_size));</=
span><br><span>     dmsg(D_PACKET_CONTENT, &quot;DECRYPT AD: %s&quot;, form=
at_hex(ad_start, ad_size, 0, &amp;gc));</span><br><span> </span><br><span> =
    /* Decrypt and authenticate packet */</span><br><span>@@ -574,7 +570,7 =
@@</span><br><span>     }</span><br><span> </span><br><span>     ASSERT(buf=
_inc_len(&amp;work, outlen));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (!cipher_ctx_final_check_tag(ctx-&gt;cipher, BPTR(&amp;work)=
 + outlen, &amp;outlen, tag_ptr, tag_size))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!cipher_ctx_final_check_tag(ctx-&gt;cipher,=
 BPTR(&amp;work) + outlen, &amp;outlen, tag_ptr, OPENVPN_AEAD_TAG_LENGTH))<=
/span><br><span>     {</span><br><span>         ctx-&gt;failed_verification=
s++;</span><br><span>         CRYPT_DROP(&quot;packet tag authentication fa=
iled&quot;);</span><br><span>@@ -1114,20 +1110,19 @@</span><br><span> stati=
c void</span><br><span> generate_key_random(struct key *key)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int cipher_le=
n =3D MAX_CIPHER_KEY_LENGTH;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    int hmac_len =3D MAX_HMAC_KEY_LENGTH;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span>     struct gc_arena gc =3D gc_=
new();</span><br><span> </span><br><span>     CLEAR(*key);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (!rand_bytes(key-&gt;cipher, ci=
pher_len) || !rand_bytes(key-&gt;hmac, hmac_len))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!rand_bytes(key-&gt;cipher, MAX_CIPHE=
R_KEY_LENGTH)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  || !rand_bytes(key-&gt;hmac, MAX_HMAC_KEY_LENGTH))</span><br><span>     {=
</span><br><span>         msg(M_FATAL, &quot;ERROR: Random number generator=
 cannot obtain entropy for key generation&quot;);</span><br><span>     }</s=
pan><br><span> </span><br><span>     dmsg(D_SHOW_KEY_SOURCE, &quot;Cipher s=
ource entropy: %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-         format_hex(key-&gt;cipher, cipher_len, 0, &amp;gc));</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_SHOW_KEY_SOURCE, &quo=
t;HMAC source entropy: %s&quot;, format_hex(key-&gt;hmac, hmac_len, 0, &amp=
;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         form=
at_hex(key-&gt;cipher, MAX_CIPHER_KEY_LENGTH, 0, &amp;gc));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_SHOW_KEY_SOURCE, &quot;H=
MAC source entropy: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+         format_hex(key-&gt;hmac, MAX_HMAC_KEY_LENGTH, 0, &amp;gc=
));</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><spa=
n> }</span><br><span>diff --git a/src/openvpn/crypto_epoch=2Ec b/src/openvp=
n/crypto_epoch=2Ec</span><br><span>index 243b5a2=2E=2E40e8cec 100644</span>=
<br><span>--- a/src/openvpn/crypto_epoch=2Ec</span><br><span>+++ b/src/open=
vpn/crypto_epoch=2Ec</span><br><span>@@ -38,11 +38,6 @@</span><br><span> #i=
nclude &quot;buffer=2Eh&quot;</span><br><span> #include &quot;integer=2Eh&q=
uot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-co=
nversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void=
</span><br><span> ovpn_hkdf_expand(const uint8_t *secret, const uint8_t *in=
fo, size_t info_len,</span><br><span>                  uint8_t *out, size_t=
 out_len)</span><br><span>@@ -51,26 +46,23 @@</span><br><span>     hmac_ctx=
_init(hmac_ctx, secret, &quot;SHA256&quot;);</span><br><span> </span><br><s=
pan>     ASSERT(info_len &lt;=3D INT_MAX);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    const unsigned int digest_size =3D SHA256_DIGEST_L=
ENGTH;</span><br><span> </span><br><span>     /* T(0) =3D empty string */</=
span><br><span>     uint8_t t_prev[SHA256_DIGEST_LENGTH];</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    unsigned int t_prev_len =3D 0;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for =
(uint8_t block =3D 1; (block - 1) * digest_size &lt; out_len; block++)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (uint8_t block =
=3D 1; (block - 1u) * SHA256_DIGEST_LENGTH &lt; out_len; block++)</span><br=
><span>     {</span><br><span>         hmac_ctx_reset(hmac_ctx);</span><br>=
<span> </span><br><span>         /* calculate T(block) */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        hmac_ctx_update(hmac_ctx, t_pre=
v, t_prev_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    hmac_ctx_update(hmac_ctx, t_prev, block =3D=3D 1 ? 0 : SHA256_DIGEST_LE=
NGTH);</span><br><span>         hmac_ctx_update(hmac_ctx, info, (int)info_l=
en);</span><br><span>         hmac_ctx_update(hmac_ctx, &amp;block, 1);</sp=
an><br><span>         hmac_ctx_final(hmac_ctx, t_prev);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        t_prev_len =3D digest_size;</span=
><br><span> </span><br><span>         /* Copy a full hmac output or remaini=
ng bytes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        si=
ze_t out_offset =3D (block - 1) * digest_size;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        size_t copylen =3D min_size(digest_size, o=
ut_len - out_offset);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        size_t out_offset =3D (block - 1u) * SHA256_DIGEST_LENGTH;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        size_t copylen =3D=
 min_size(SHA256_DIGEST_LENGTH, out_len - out_offset);</span><br><span> </s=
pan><br><span>         memcpy(out + out_offset, t_prev, copylen);</span><br=
><span>     }</span><br><span>@@ -463,7 +455,3 @@</span><br><span>         =
epoch_iterate_send_key(opt);</span><br><span>     }</span><br><span> }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic po=
p</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an>diff --git a/src/openvpn/packet_id=2Eh b/src/openvpn/packet_id=2Eh</span=
><br><span>index c374ccb=2E=2E08a0f78 100644</span><br><span>--- a/src/open=
vpn/packet_id=2Eh</span><br><span>+++ b/src/openvpn/packet_id=2Eh</span><br=
><span>@@ -249,7 +249,7 @@</span><br><span> const char *packet_id_net_print=
(const struct packet_id_net *pin, bool print_timestamp,</span><br><span>   =
                              struct gc_arena *gc);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline int</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static inline unsigned int</s=
pan><br><span> packet_id_size(bool long_form)</span><br><span> {</span><br>=
<span>     return sizeof(packet_id_type) + (long_form ? sizeof(net_time_t) =
: 0);</span><br><span>diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/=
tls_crypt=2Ec</span><br><span>index e59f55b=2E=2E08d9fcd 100644</span><br><=
span>--- a/src/openvpn/tls_crypt=2Ec</span><br><span>+++ b/src/openvpn/tls_=
crypt=2Ec</span><br><span>@@ -52,7 +52,7 @@</span><br><span>     return cre=
ate_kt(&quot;AES-256-CTR&quot;, &quot;SHA256&quot;, &quot;tls-crypt&quot;);=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
unsigned int</span><br><span> tls_crypt_buf_overhead(void)</span><br><span>=
 {</span><br><span>     return packet_id_size(true) + TLS_CRYPT_TAG_SIZE + =
TLS_CRYPT_BLOCK_SIZE;</span><br><span>diff --git a/src/openvpn/tls_crypt=2E=
h b/src/openvpn/tls_crypt=2Eh</span><br><span>index d179cbb=2E=2E8e5567f 10=
0644</span><br><span>--- a/src/openvpn/tls_crypt=2Eh</span><br><span>+++ b/=
src/openvpn/tls_crypt=2Eh</span><br><span>@@ -130,7 +130,7 @@</span><br><sp=
an>  * Returns the maximum overhead (in bytes) added to the destination buf=
fer by</span><br><span>  * tls_crypt_wrap()=2E</span><br><span>  */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-int tls_crypt_buf_overhead(vo=
id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int tl=
s_crypt_buf_overhead(void);</span><br><span> </span><br><span> /**</span><b=
r><span>  * Wrap a control channel packet (both authenticates and encrypts =
the data)=2E</span><br><span>diff --git a/tests/unit_tests/openvpn/test_tls=
_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>in=
dex 2d31c00=2E=2E00de73a 100644</span><br><span>--- a/tests/unit_tests/open=
vpn/test_tls_crypt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
tls_crypt=2Ec</span><br><span>@@ -232,11 +232,6 @@</span><br><span>     }</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &q=
uot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> /**</span><br><span>  * Check that short messages are successfully=
 wrapped-and-unwrapped=2E</span><br><span>  */</span><br><span>@@ -778,10 +=
773,6 @@</span><br><span>     tls_wrap_free(&amp;wrap_ctx);</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> static void</span><br><span> test_tls_crypt_v=
2_write_server_key_file(void **state)</span><br><span> {</span><br></pre><p=
>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?=
usp=3Demail">change 2158</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2158?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2158 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--Jkt2Ob6kdJk=--


--===============4512826556114049085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4512826556114049085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4512826556114049085==--

