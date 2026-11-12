Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9630606A883
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WOKviXEU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=btzd2t+r;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=J1KdDCWF;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=L2B6Eqvr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4K03LdZ52yOrcoffDynMRWabySEjGzIkJbWI/hX2wfc=; b=WOKviXEUR9r5GZ1mylb4ELd+bK
	scapbHdLQeL1bHkp4ajijej4oRhjLrbbeVaDj2o87FUInaccJQI8T7En4/uho0UajjjQ/WveEMUEo
	CKQwq1lUIzR1JrvtOeNVcRp6x+MqROZExfPJ3Lz2hEAXND3q7Ku67ykTA/WVyBmcLk7A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYLA-000000003Ut-2Qbe;
	Thu, 12 Nov 2026 17:12:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRYL3-000000003Ug-1Pxj
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:11:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=waL3X3PUC6HN39j0S6dsx213gztO3SreJqgg9bj/XAI=; b=btzd2t+r+DaY1Y3TfCNm48vvyc
 kh3AIDf7PGRxRx4JSVgzxwgLz2jzERpDrJpXLzWt3FY/Q6ypqWghIMXeJCXqNqOY+ilCmVHxDp2Mv
 yqvv3onUB6F+vYPfuZnbRXIHy03t4FYCXXzAQCddhY/57ORLKb32+PCHtEsHEXV78ZG0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=waL3X3PUC6HN39j0S6dsx213gztO3SreJqgg9bj/XAI=; b=J1KdDCWF+nkI354j4EK2rru/46
 mgwKNB8NZWAzCskZ40z4mz4FKstfCY/8qkWD2x4llaV2Rt7H/YSBC0MxXtqxm3ScQwMFmI9/YRg3+
 inmEFWxzdzKDtVlfIxQ52m6RWak0qxjYgETchQS7n2m5KPdUshf8FtHaRM2OxWi2mfH0=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRYKw-000000002wN-0GLi for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:11:53 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-491aaed7565so2706540f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 09:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794503499; x=1795108299; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=waL3X3PUC6HN39j0S6dsx213gztO3SreJqgg9bj/XAI=;
 b=L2B6Eqvrty/k+g75IWUu0QSLvTfZN2zoZJI4fukih6T3EqWn8p+tc/5J4AD5al+yLm
 4sm4AyDIQiudbDBhOEk8gV9w5Wmvk+ncYk3uG2O+xBaJNm7742AeCxOX77f5MYa+KLk6
 M5YeymqC9liqi85RcwtcRcIEWzmPMI7Ayr0sGyF3/LyjCXp+AxpsqPwQaoQW7JLQZAUv
 hyCtw2PgRiMr6d0w8AiNZzv9003lQQJQWb4zS1cThVRWLr8ME8/Mmjfhyt6lXd398ZxU
 YJ7X8zGTiUaJJPNVAndEMFnNR9j0ojenUy4hynlHxXhdjnnOlrvneNSPmIoiTFAcmi7L
 m1tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794503499; x=1795108299;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=waL3X3PUC6HN39j0S6dsx213gztO3SreJqgg9bj/XAI=;
 b=ZlQUQcBYU9xizW1LPKESIGZ9hIhmBaKpCAqSdcvIuDAtAE/+MREDtjjlrspQTJEmMr
 EavNCKd51X41LFtTjNZ9d+nyQBJEMM9QHs/HVClDj42cVx+3NR+uOOz7cXg63tM975sb
 dVlTH04u1jAO4nNOCUdi1bOPA5CpvYsYhtAxmOvO0fpgkNSVa4wz2yzrTM0k2VWP2INe
 6mUJRdUEEezBldgWzUpGWcG1LkhziZVT49vrPRSBkNcdOEgTfQbXkZfFVF4AAxDaLTXn
 cyD4Bc4MFJ8HcQ4FK2StZGNagNvQlgM/cy/cVSPFEkAWsyPFZXitbPbLyQxMILcgYFf0
 ni4Q==
X-Gm-Message-State: APuU4Z+OGgekgUYwdSnn70M7xg07ofXBDNTQSeaeoKZHzaAABVCrWFns
 nA1HsKsp+evRu7tRGEZZPz0zSmNXYwYLdaMtKwbIadQAtFA7AAtAAXHqmAjc/0CK1ZnvNeo6srE
 CEi50ceJkZCQlCSzm8n14YQ4KybT0ZLIA2BheOkU6YucdTzqLPH7huJgQc2J5IZB2ddLF
X-Gm-Gg: AYBFou1r8nf0pvAnwGG5St64+knOoVjuDSbM6GZR97YtSttfx1xt0/uPzrGu9nLSXf/
 sCTseMNpmcEivonaStMM5D02kbt5HCBtcoDm9GL1QDntcWkeBzBSbjQRU6GkVL/CkYvI4q+mvzj
 DKlSVqQHf+VZ70mf6d2zrzi67u7XbzYLzi7s7Dl+k8K5KZ/NcVowrXte2QVXlQYNK3tzHDjhxwh
 pC0WPU7efq+HvFZlTralAD5XTBk57kyPthLm5YpxM0iVDpH87MW1H19pJ72U8a0MjIDo5KjWPRp
 9gKOcDO+0S2aYpj0JutvrvMSqg5ci1FemXuy8z+0uvC/TzlNHk1q8JDzR8LRc3oFtvR+0Aj1EfF
 SH/2HDQmaPJ+CAzs/U4mcVw2KH52MH7Z2qSI+r4TbR48Y6tUKz1iB0NJuMnVw3xKGbJBMcUpSfr
 pHPs+yoiFjQwOL8xAHF12v9yNQmDb7+Gggmh9GpJvYqEvdJZGUtIsUmm6D3VOLbieV60qvpGY/V
 45y5YZNhkrVKekzb1lSjxNVvOvVBCB4iQVhfXzC4PMaU7yBLETzTeAdUVRJk/XuqCeTD851CAIQ
 Bc8RFcZs5YJZe/yzVgF5YpE9svimCjZQKkMlsaLUApZ13RXck8SnZhs/NX+uaYZhgCscQ/lllBX
 k4EZ64gizPuyFtSUoUK5owrzZlEROs5vCdhatEAh3gaBewu0j9BXltIGn3n2XF22x+kSFw3UQ74
 W7ljrpJAe2YS9NU3s=
X-Received: by 2002:a05:6000:184f:b0:48b:451:4f19 with SMTP id
 ffacd0b85a97d-499c8c67018mr13989439f8f.51.1794503499200; 
 Thu, 12 Nov 2026 09:11:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c18b9sm271016f8f.20.2026.11.12.09.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:11:38 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 17:11:31 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5
X-Gerrit-Change-Number: 2158
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2158?usp=email>
X-Gerrit-Commit: 3052fe05d7f2ff97b885b64731b76453c4e29caa
In-Reply-To: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
References: <gerrit.1794261747000.I3bcb4cb8e17ff80a5cb8acdaf18d1072159184e5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MjYxNzQ3MDAwLkkzYmNiNGNiOGUxN2ZmODBhNWNiOGFjZGFmMThkMTA3MjE1OTE4NGU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c9e47cd8bef6b7424b8a51762e2fea7aadab32e8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xRYKw-000000002wN-0GLi
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6329733229553478765=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6329733229553478765==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ntIHpqFUNfg="; charset=UTF-8

--ntIHpqFUNfg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a chan=
ge=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=
=3Demail

to look at the new patch set (#6)=2E

The change is no longer sub=
mittable: checks~ChecksSubmitRule is unsatisfied now=2E


Change subject: c=
rypto*: Avoid sign conversion warnings by using defines directly
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

crypto*: Avoid sign co=
nversion warnings by using defines directly

Using the defines directly avo=
ids the issue with sign
conversion by letting the compiler deduce the types=
 of
the literals=2E

I do not think that using an intermediate variable
inc=
reases the readability=2E

Change-Id: I3bcb4cb8e17ff80a5cb8acdaf18d10721591=
84e5
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M src/o=
penvpn/crypto=2Ec
M src/openvpn/crypto_epoch=2Ec
M src/openvpn/packet_id=2E=
h
M src/openvpn/tls_crypt=2Ec
M src/openvpn/tls_crypt=2Eh
M tests/unit_test=
s/openvpn/test_tls_crypt=2Ec
6 files changed, 24 insertions(+), 50 deletion=
s(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/5=
8/2158/6

diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
inde=
x 826f39e=2E=2E44c1f4a 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvp=
n/crypto=2Ec
@@ -81,7 +81,6 @@
 
     const struct key_ctx *ctx =3D &opt->k=
ey_ctx_bi=2Eencrypt;
     uint8_t *mac_out =3D NULL;
-    const int mac_len=
 =3D OPENVPN_AEAD_TAG_LENGTH;
 
     /* IV, packet-ID and implicit IV requi=
red for this mode=2E */
     ASSERT(ctx->cipher);
@@ -142,7 +141,7 @@
     =
dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf)=
, 80, &gc));
 
     /* Buffer overflow check */
-    if (!buf_safe(&work, b=
uf->len + mac_len + cipher_ctx_block_size(ctx->cipher)))
+    if (!buf_safe=
(&work, BLENZ(buf) + OPENVPN_AEAD_TAG_LENGTH + cipher_ctx_block_size(ctx->c=
ipher)))
     {
         msg(D_CRYPT_ERRORS, "ENCRYPT: buffer size error, b=
c=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d",
             buf->capacity=
, buf->offset, buf->len, work=2Ecapacity, work=2Eoffset, work=2Elen);
@@ -1=
56,7 +155,7 @@
     if (!use_epoch_data_format)
     {
         /* Reserve =
space for authentication tag */
-        mac_out =3D buf_write_alloc(&work,=
 mac_len);
+        mac_out =3D buf_write_alloc(&work, OPENVPN_AEAD_TAG_LEN=
GTH);
         ASSERT(mac_out);
     }
 
@@ -177,12 +176,12 @@
     if (use=
_epoch_data_format)
     {
         /* Reserve space for authentication tag=
 */
-        mac_out =3D buf_write_alloc(&work, mac_len);
+        mac_out =
=3D buf_write_alloc(&work, OPENVPN_AEAD_TAG_LENGTH);
         ASSERT(mac_ou=
t);
     }
 
     /* Write authentication tag */
-    ASSERT(cipher_ctx_get=
_tag(ctx->cipher, mac_out, mac_len));
+    ASSERT(cipher_ctx_get_tag(ctx->c=
ipher, mac_out, OPENVPN_AEAD_TAG_LENGTH));
 
     *buf =3D work;
 
@@ -453,=
9 +452,6 @@
         CRYPT_DROP("Decryption failed verification limit reach=
ed=2E");
     }
 
-    const int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;
-
-
=
     ASSERT(frame);
     ASSERT(buf->len > 0);
     ASSERT(ctx->cipher);
@@=
 -470,14 +466,14 @@
     ASSERT(packet_id_initialized(&opt->packet_id));
 
=
     /* Ensure that the packet size is long enough */
-    int min_packet_l=
en =3D packet_id_size(false) + tag_size + 1;
+    size_t min_packet_len =3D=
 packet_id_size(false) + OPENVPN_AEAD_TAG_LENGTH + 1;
 
     if (use_epoch_=
data_format)
     {
         min_packet_len +=3D sizeof(uint32_t);
     }
 =

-    if (buf->len < min_packet_len)
+    if (BLENZ(buf) < min_packet_len)
=
     {
         CRYPT_ERROR("missing IV info, missing tag or no payload");
=
     }
@@ -540,24 +536,24 @@
         }
     }
 
-    const int ad_size =3D=
 (int)(BPTR(buf) - ad_start);
+    const uintptr_t ad_size =3D (uintptr_t)(=
BPTR(buf) - ad_start);
 
     uint8_t *tag_ptr =3D NULL;
     int data_len =
=3D 0;
 
     if (use_epoch_data_format)
     {
-        data_len =3D BLEN(=
buf) - tag_size;
+        data_len =3D BLEN(buf) - OPENVPN_AEAD_TAG_LENGTH;=

         tag_ptr =3D BPTR(buf) + data_len;
     }
     else
     {
       =
  tag_ptr =3D BPTR(buf);
-        ASSERT(buf_advance(buf, tag_size));
+    =
    ASSERT(buf_advance(buf, OPENVPN_AEAD_TAG_LENGTH));
         data_len =
=3D BLEN(buf);
     }
 
-    dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s", form=
at_hex(tag_ptr, tag_size, 0, &gc));
+    dmsg(D_PACKET_CONTENT, "DECRYPT MA=
C: %s", format_hex(tag_ptr, OPENVPN_AEAD_TAG_LENGTH, 0, &gc));
     dmsg(D_=
PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLENZ(buf), 0, &g=
c));
 
     /* Buffer overflow check (should never fail) */
@@ -567,7 +563,=
7 @@
     }
 
     /* feed in tag and the authenticated data */
-    ASSERT=
(cipher_ctx_update_ad(ctx->cipher, ad_start, ad_size));
+    ASSERT(cipher_=
ctx_update_ad(ctx->cipher, ad_start, (int)ad_size));
     dmsg(D_PACKET_CON=
TENT, "DECRYPT AD: %s", format_hex(ad_start, ad_size, 0, &gc));
 
     /* D=
ecrypt and authenticate packet */
@@ -578,7 +574,7 @@
     }
 
     ASSERT(=
buf_inc_len(&work, outlen));
-    if (!cipher_ctx_final_check_tag(ctx->ciph=
er, BPTR(&work) + outlen, &outlen, tag_ptr, tag_size))
+    if (!cipher_ctx=
_final_check_tag(ctx->cipher, BPTR(&work) + outlen, &outlen, tag_ptr, OPENV=
PN_AEAD_TAG_LENGTH))
     {
         ctx->failed_verifications++;
         =
CRYPT_DROP("packet tag authentication failed");
@@ -1118,20 +1114,19 @@
 st=
atic void
 generate_key_random(struct key *key)
 {
-    int cipher_len =3D =
MAX_CIPHER_KEY_LENGTH;
-    int hmac_len =3D MAX_HMAC_KEY_LENGTH;
-
     st=
ruct gc_arena gc =3D gc_new();
 
     CLEAR(*key);
-    if (!rand_bytes(key=
->cipher, cipher_len) || !rand_bytes(key->hmac, hmac_len))
+    if (!rand_b=
ytes(key->cipher, MAX_CIPHER_KEY_LENGTH)
+        || !rand_bytes(key->hmac,=
 MAX_HMAC_KEY_LENGTH))
     {
         msg(M_FATAL, "ERROR: Random number g=
enerator cannot obtain entropy for key generation");
     }
 
     dmsg(D_S=
HOW_KEY_SOURCE, "Cipher source entropy: %s",
-         format_hex(key->ciph=
er, cipher_len, 0, &gc));
-    dmsg(D_SHOW_KEY_SOURCE, "HMAC source entropy=
: %s", format_hex(key->hmac, hmac_len, 0, &gc));
+         format_hex(key->=
cipher, MAX_CIPHER_KEY_LENGTH, 0, &gc));
+    dmsg(D_SHOW_KEY_SOURCE, "HMAC=
 source entropy: %s",
+         format_hex(key->hmac, MAX_HMAC_KEY_LENGTH, =
0, &gc));
 
     gc_free(&gc);
 }
diff --git a/src/openvpn/crypto_epoch=2Ec=
 b/src/openvpn/crypto_epoch=2Ec
index 243b5a2=2E=2E40e8cec 100644
--- a/src=
/openvpn/crypto_epoch=2Ec
+++ b/src/openvpn/crypto_epoch=2Ec
@@ -38,11 +38,=
6 @@
 #include "buffer=2Eh"
 #include "integer=2Eh"
 
-#if defined(__GNUC__=
) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnosti=
c ignored "-Wsign-conversion"
-#endif
-
 void
 ovpn_hkdf_expand(const uint8=
_t *secret, const uint8_t *info, size_t info_len,
                  uint8_t=
 *out, size_t out_len)
@@ -51,26 +46,23 @@
     hmac_ctx_init(hmac_ctx, sec=
ret, "SHA256");
 
     ASSERT(info_len <=3D INT_MAX);
-    const unsigned i=
nt digest_size =3D SHA256_DIGEST_LENGTH;
 
     /* T(0) =3D empty string */=

     uint8_t t_prev[SHA256_DIGEST_LENGTH];
-    unsigned int t_prev_len =
=3D 0;
 
-    for (uint8_t block =3D 1; (block - 1) * digest_size < out_len=
; block++)
+    for (uint8_t block =3D 1; (block - 1u) * SHA256_DIGEST_LENG=
TH < out_len; block++)
     {
         hmac_ctx_reset(hmac_ctx);
 
        =
 /* calculate T(block) */
-        hmac_ctx_update(hmac_ctx, t_prev, t_prev=
_len);
+        hmac_ctx_update(hmac_ctx, t_prev, block =3D=3D 1 ? 0 : SHA2=
56_DIGEST_LENGTH);
         hmac_ctx_update(hmac_ctx, info, (int)info_len);=

         hmac_ctx_update(hmac_ctx, &block, 1);
         hmac_ctx_final(hma=
c_ctx, t_prev);
-        t_prev_len =3D digest_size;
 
         /* Copy a f=
ull hmac output or remaining bytes */
-        size_t out_offset =3D (block=
 - 1) * digest_size;
-        size_t copylen =3D min_size(digest_size, out_=
len - out_offset);
+        size_t out_offset =3D (block - 1u) * SHA256_DIG=
EST_LENGTH;
+        size_t copylen =3D min_size(SHA256_DIGEST_LENGTH, out_=
len - out_offset);
 
         memcpy(out + out_offset, t_prev, copylen);
  =
   }
@@ -463,7 +455,3 @@
         epoch_iterate_send_key(opt);
     }
 }
-
=
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#=
endif
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
diff --git a/tests/=
unit_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/test_tls_c=
rypt=2Ec
index 2d31c00=2E=2E00de73a 100644
--- a/tests/unit_tests/openvpn/t=
est_tls_crypt=2Ec
+++ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec
@@ -232=
,11 +232,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pr=
agma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion=
"
-#endif
-
 /**
  * Check that short messages are successfully wrapped-and=
-unwrapped=2E
  */
@@ -778,10 +773,6 @@
     tls_wrap_free(&wrap_ctx);
 }
 =

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-=
#endif
-
 static void
 test_tls_crypt_v2_write_server_key_file(void **state=
)
 {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3bcb4cb8e=
17ff80a5cb8acdaf18d1072159184e5
Gerrit-Change-Number: 2158
Gerrit-PatchSet:=
 6
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--ntIHpqFUNfg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Frank Lich=
tenheld <strong>uploaded patch set #6</strong> to this change=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail">View Ch=
ange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule=
 is unsatisfied now=2E</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">crypto*: Avoid sign conversion warn=
ings by using defines directly<br><br>Using the defines directly avoids the=
 issue with sign<br>conversion by letting the compiler deduce the types of<=
br>the literals=2E<br><br>I do not think that using an intermediate variabl=
e<br>increases the readability=2E<br><br>Change-Id: I3bcb4cb8e17ff80a5cb8ac=
daf18d1072159184e5<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt;<br>---<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/crypto_epoc=
h=2Ec<br>M src/openvpn/packet_id=2Eh<br>M src/openvpn/tls_crypt=2Ec<br>M sr=
c/openvpn/tls_crypt=2Eh<br>M tests/unit_tests/openvpn/test_tls_crypt=2Ec<br=
>6 files changed, 24 insertions(+), 50 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/215=
8/6</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</s=
pan><br><span>index 826f39e=2E=2E44c1f4a 100644</span><br><span>--- a/src/o=
penvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><s=
pan>@@ -81,7 +81,6 @@</span><br><span> </span><br><span>     const struct k=
ey_ctx *ctx =3D &amp;opt-&gt;key_ctx_bi=2Eencrypt;</span><br><span>     uin=
t8_t *mac_out =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    const int mac_len =3D OPENVPN_AEAD_TAG_LENGTH;</span><br><span> </spa=
n><br><span>     /* IV, packet-ID and implicit IV required for this mode=2E=
 */</span><br><span>     ASSERT(ctx-&gt;cipher);</span><br><span>@@ -142,7 =
+141,7 @@</span><br><span>     dmsg(D_PACKET_CONTENT, &quot;ENCRYPT FROM: %=
s&quot;, format_hex(BPTR(buf), BLENZ(buf), 80, &amp;gc));</span><br><span> =
</span><br><span>     /* Buffer overflow check */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (!buf_safe(&amp;work, buf-&gt;len + mac_=
len + cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!buf_safe(&amp;work, BLENZ(buf) + OPENVPN=
_AEAD_TAG_LENGTH + cipher_ctx_block_size(ctx-&gt;cipher)))</span><br><span>=
     {</span><br><span>         msg(D_CRYPT_ERRORS, &quot;ENCRYPT: buffer s=
ize error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d&quot;,</span><br=
><span>             buf-&gt;capacity, buf-&gt;offset, buf-&gt;len, work=2Ec=
apacity, work=2Eoffset, work=2Elen);</span><br><span>@@ -156,7 +155,7 @@</s=
pan><br><span>     if (!use_epoch_data_format)</span><br><span>     {</span=
><br><span>         /* Reserve space for authentication tag */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        mac_out =3D buf_write_allo=
c(&amp;work, mac_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        mac_out =3D buf_write_alloc(&amp;work, OPENVPN_AEAD_TAG_LENGTH);=
</span><br><span>         ASSERT(mac_out);</span><br><span>     }</span><br=
><span> </span><br><span>@@ -177,12 +176,12 @@</span><br><span>     if (use=
_epoch_data_format)</span><br><span>     {</span><br><span>         /* Rese=
rve space for authentication tag */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        mac_out =3D buf_write_alloc(&amp;work, mac_len);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        mac_out =3D buf_=
write_alloc(&amp;work, OPENVPN_AEAD_TAG_LENGTH);</span><br><span>         A=
SSERT(mac_out);</span><br><span>     }</span><br><span> </span><br><span>  =
   /* Write authentication tag */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ASSERT(cipher_ctx_get_tag(ctx-&gt;cipher, mac_out, mac_len)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(cipher=
_ctx_get_tag(ctx-&gt;cipher, mac_out, OPENVPN_AEAD_TAG_LENGTH));</span><br>=
<span> </span><br><span>     *buf =3D work;</span><br><span> </span><br><sp=
an>@@ -453,9 +452,6 @@</span><br><span>         CRYPT_DROP(&quot;Decryption=
 failed verification limit reached=2E&quot;);</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const =
int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span>     ASSERT(frame);</span><br><span>     ASSERT(buf-&gt;len=
 &gt; 0);</span><br><span>     ASSERT(ctx-&gt;cipher);</span><br><span>@@ -=
470,14 +466,14 @@</span><br><span>     ASSERT(packet_id_initialized(&amp;op=
t-&gt;packet_id));</span><br><span> </span><br><span>     /* Ensure that th=
e packet size is long enough */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    int min_packet_len =3D packet_id_size(false) + tag_size + 1;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t min_packe=
t_len =3D packet_id_size(false) + OPENVPN_AEAD_TAG_LENGTH + 1;</span><br><s=
pan> </span><br><span>     if (use_epoch_data_format)</span><br><span>     =
{</span><br><span>         min_packet_len +=3D sizeof(uint32_t);</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (buf-&gt;len &lt; min_packet_len)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (BLENZ(buf) &lt; min_packet_len)</span=
><br><span>     {</span><br><span>         CRYPT_ERROR(&quot;missing IV inf=
o, missing tag or no payload&quot;);</span><br><span>     }</span><br><span=
>@@ -540,24 +536,24 @@</span><br><span>         }</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    co=
nst int ad_size =3D (int)(BPTR(buf) - ad_start);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const uintptr_t ad_size =3D (uintptr_t)(BP=
TR(buf) - ad_start);</span><br><span> </span><br><span>     uint8_t *tag_pt=
r =3D NULL;</span><br><span>     int data_len =3D 0;</span><br><span> </spa=
n><br><span>     if (use_epoch_data_format)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        data_len =3D BLEN(buf)=
 - tag_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 data_len =3D BLEN(buf) - OPENVPN_AEAD_TAG_LENGTH;</span><br><span>        =
 tag_ptr =3D BPTR(buf) + data_len;</span><br><span>     }</span><br><span> =
    else</span><br><span>     {</span><br><span>         tag_ptr =3D BPTR(b=
uf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(bu=
f_advance(buf, tag_size));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        ASSERT(buf_advance(buf, OPENVPN_AEAD_TAG_LENGTH));</span><br=
><span>         data_len =3D BLEN(buf);</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_PACKE=
T_CONTENT, &quot;DECRYPT MAC: %s&quot;, format_hex(tag_ptr, tag_size, 0, &a=
mp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_=
PACKET_CONTENT, &quot;DECRYPT MAC: %s&quot;, format_hex(tag_ptr, OPENVPN_AE=
AD_TAG_LENGTH, 0, &amp;gc));</span><br><span>     dmsg(D_PACKET_CONTENT, &q=
uot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLENZ(buf), 0, &amp;gc));=
</span><br><span> </span><br><span>     /* Buffer overflow check (should ne=
ver fail) */</span><br><span>@@ -567,7 +563,7 @@</span><br><span>     }</sp=
an><br><span> </span><br><span>     /* feed in tag and the authenticated da=
ta */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(ciphe=
r_ctx_update_ad(ctx-&gt;cipher, ad_start, ad_size));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(cipher_ctx_update_ad(ctx-&gt;c=
ipher, ad_start, (int)ad_size));</span><br><span>     dmsg(D_PACKET_CONTENT=
, &quot;DECRYPT AD: %s&quot;, format_hex(ad_start, ad_size, 0, &amp;gc));</=
span><br><span> </span><br><span>     /* Decrypt and authenticate packet */=
</span><br><span>@@ -578,7 +574,7 @@</span><br><span>     }</span><br><span=
> </span><br><span>     ASSERT(buf_inc_len(&amp;work, outlen));</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (!cipher_ctx_final_check_t=
ag(ctx-&gt;cipher, BPTR(&amp;work) + outlen, &amp;outlen, tag_ptr, tag_size=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!cipher_c=
tx_final_check_tag(ctx-&gt;cipher, BPTR(&amp;work) + outlen, &amp;outlen, t=
ag_ptr, OPENVPN_AEAD_TAG_LENGTH))</span><br><span>     {</span><br><span>  =
       ctx-&gt;failed_verifications++;</span><br><span>         CRYPT_DROP(=
&quot;packet tag authentication failed&quot;);</span><br><span>@@ -1118,20 =
+1114,19 @@</span><br><span> static void</span><br><span> generate_key_rand=
om(struct key *key)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int cipher_len =3D MAX_CIPHER_KEY_LENGTH;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    int hmac_len =3D MAX_HMAC_KEY_=
LENGTH;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>=
     CLEAR(*key);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (!rand_bytes(key-&gt;cipher, cipher_len) || !rand_bytes(key-&gt;hmac, hm=
ac_len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ra=
nd_bytes(key-&gt;cipher, MAX_CIPHER_KEY_LENGTH)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        || !rand_bytes(key-&gt;hmac, MAX_HMAC_K=
EY_LENGTH))</span><br><span>     {</span><br><span>         msg(M_FATAL, &q=
uot;ERROR: Random number generator cannot obtain entropy for key generation=
&quot;);</span><br><span>     }</span><br><span> </span><br><span>     dmsg=
(D_SHOW_KEY_SOURCE, &quot;Cipher source entropy: %s&quot;,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-         format_hex(key-&gt;cipher, ci=
pher_len, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    dmsg(D_SHOW_KEY_SOURCE, &quot;HMAC source entropy: %s&quot;, format_h=
ex(key-&gt;hmac, hmac_len, 0, &amp;gc));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+         format_hex(key-&gt;cipher, MAX_CIPHER_KEY_LEN=
GTH, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   dmsg(D_SHOW_KEY_SOURCE, &quot;HMAC source entropy: %s&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+         format_hex(key-&gt;hma=
c, MAX_HMAC_KEY_LENGTH, 0, &amp;gc));</span><br><span> </span><br><span>   =
  gc_free(&amp;gc);</span><br><span> }</span><br><span>diff --git a/src/ope=
nvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec</span><br><span>index =
243b5a2=2E=2E40e8cec 100644</span><br><span>--- a/src/openvpn/crypto_epoch=
=2Ec</span><br><span>+++ b/src/openvpn/crypto_epoch=2Ec</span><br><span>@@ =
-38,11 +38,6 @@</span><br><span> #include &quot;buffer=2Eh&quot;</span><br>=
<span> #include &quot;integer=2Eh&quot;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clan=
g__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC=
 diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> void</span><br><span> ovpn_hkdf_expand(const=
 uint8_t *secret, const uint8_t *info, size_t info_len,</span><br><span>   =
               uint8_t *out, size_t out_len)</span><br><span>@@ -51,26 +46,=
23 @@</span><br><span>     hmac_ctx_init(hmac_ctx, secret, &quot;SHA256&quo=
t;);</span><br><span> </span><br><span>     ASSERT(info_len &lt;=3D INT_MAX=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const unsigned =
int digest_size =3D SHA256_DIGEST_LENGTH;</span><br><span> </span><br><span=
>     /* T(0) =3D empty string */</span><br><span>     uint8_t t_prev[SHA25=
6_DIGEST_LENGTH];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
unsigned int t_prev_len =3D 0;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    for (uint8_t block =3D 1; (block - 1) * dige=
st_size &lt; out_len; block++)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    for (uint8_t block =3D 1; (block - 1u) * SHA256_DIGEST_LENGT=
H &lt; out_len; block++)</span><br><span>     {</span><br><span>         hm=
ac_ctx_reset(hmac_ctx);</span><br><span> </span><br><span>         /* calcu=
late T(block) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   hmac_ctx_update(hmac_ctx, t_prev, t_prev_len);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        hmac_ctx_update(hmac_ctx, t_prev, blo=
ck =3D=3D 1 ? 0 : SHA256_DIGEST_LENGTH);</span><br><span>         hmac_ctx_=
update(hmac_ctx, info, (int)info_len);</span><br><span>         hmac_ctx_up=
date(hmac_ctx, &amp;block, 1);</span><br><span>         hmac_ctx_final(hmac=
_ctx, t_prev);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 t_prev_len =3D digest_size;</span><br><span> </span><br><span>         /* =
Copy a full hmac output or remaining bytes */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        size_t out_offset =3D (block - 1) * digest_=
size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        size_t c=
opylen =3D min_size(digest_size, out_len - out_offset);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        size_t out_offset =3D (block - =
1u) * SHA256_DIGEST_LENGTH;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        size_t copylen =3D min_size(SHA256_DIGEST_LENGTH, out_len -=
 out_offset);</span><br><span> </span><br><span>         memcpy(out + out_o=
ffset, t_prev, copylen);</span><br><span>     }</span><br><span>@@ -463,7 +=
455,3 @@</span><br><span>         epoch_iterate_send_key(opt);</span><br><s=
pan>     }</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span>diff --git a/src/openvpn/packet_id=2Eh=
 b/src/openvpn/packet_id=2Eh</span><br><span>index 48752d3=2E=2E782dd58 100=
644</span><br><span>--- a/src/openvpn/packet_id=2Eh</span><br><span>+++ b/s=
rc/openvpn/packet_id=2Eh</span><br><span>@@ -312,7 +312,7 @@</span><br><spa=
n> const char *packet_id_net_print(const struct packet_id_net *pin, bool pr=
int_timestamp,</span><br><span>                                 struct gc_a=
rena *gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-static inline int</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static inline unsigned int</span><br><span> packet_id_size(bool long_f=
orm)</span><br><span> {</span><br><span>     return sizeof(packet_id_type) =
+ (long_form ? sizeof(net_time_t) : 0);</span><br><span>diff --git a/src/op=
envpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br><span>index 2dadc=
4f=2E=2E7eb83ce 100644</span><br><span>--- a/src/openvpn/tls_crypt=2Ec</spa=
n><br><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br><span>@@ -52,7 +52,7 =
@@</span><br><span>     return create_kt(&quot;AES-256-CTR&quot;, &quot;SHA=
256&quot;, &quot;tls-crypt&quot;);</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+unsigned int</span><br><span> tls_crypt_b=
uf_overhead(void)</span><br><span> {</span><br><span>     return packet_id_=
size(true) + TLS_CRYPT_TAG_SIZE + TLS_CRYPT_BLOCK_SIZE;</span><br><span>dif=
f --git a/src/openvpn/tls_crypt=2Eh b/src/openvpn/tls_crypt=2Eh</span><br><=
span>index d179cbb=2E=2E8e5567f 100644</span><br><span>--- a/src/openvpn/tl=
s_crypt=2Eh</span><br><span>+++ b/src/openvpn/tls_crypt=2Eh</span><br><span=
>@@ -130,7 +130,7 @@</span><br><span>  * Returns the maximum overhead (in b=
ytes) added to the destination buffer by</span><br><span>  * tls_crypt_wrap=
()=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-int tls_crypt_buf_overhead(void);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+unsigned int tls_crypt_buf_overhead(void);</span><br><sp=
an> </span><br><span> /**</span><br><span>  * Wrap a control channel packet=
 (both authenticates and encrypts the data)=2E</span><br><span>diff --git a=
/tests/unit_tests/openvpn/test_tls_crypt=2Ec b/tests/unit_tests/openvpn/tes=
t_tls_crypt=2Ec</span><br><span>index 2d31c00=2E=2E00de73a 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>++=
+ b/tests/unit_tests/openvpn/test_tls_crypt=2Ec</span><br><span>@@ -232,11 =
+232,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * Check th=
at short messages are successfully wrapped-and-unwrapped=2E</span><br><span=
>  */</span><br><span>@@ -778,10 +773,6 @@</span><br><span>     tls_wrap_fr=
ee(&amp;wrap_ctx);</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnos=
tic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void=
</span><br><span> test_tls_crypt_v2_write_server_key_file(void **state)</sp=
an><br><span> {</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail">change 2158</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2158?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3bcb4cb8e17ff80=
a5cb8acdaf18d1072159184e5 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2158 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>=

<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>

</body></html>
--ntIHpqFUNfg=--


--===============6329733229553478765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6329733229553478765==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6329733229553478765==--

