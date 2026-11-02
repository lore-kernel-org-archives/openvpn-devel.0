Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D0A606C3F1
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=c9z1oHLD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Rc058epk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ey81Scpw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=c/ZYPsnH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=dJp65UViZfFePBrUyyl9rQU2bSGiBzV0iQn6eOF0hek=; b=c9z1oHLDWFfoRkpNwyQARAmRMK
	DGNVOLZldVTsD24YFqzqxlYGhGeAnKBc6/wkQGSmDYK1XVkVl+IAtUmFqlAq2Tr0XtUd54Iqna/P9
	LR6QvQ1kSjoCA/GIidPikeX5r/JZ4twWSSaOvh+6dsDQbAt+2Je5aFxmxmDD4YCIZXkY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNtHv-000000002Ge-3Mm1;
	Mon, 02 Nov 2026 14:45:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNtHu-000000002GX-0i84
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:45:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KQznbwPZmNVe2+oT/mwPNvyqx9DTxa7ZQkNNfEbBlpw=; b=Rc058epk27PkVphN+sfCdUy/WA
 dUrKJ9NdJnpAiVoPZHt4RYLRMPKe1sJlP4kZtd5SOkJBjxlWnQsaNDK1DdbUK8ZzWnLJBuKOT9yKA
 +JYAjyKr6/k+TPfTMBomZjtRNxgHtPCleLBXPYZSRxORH8CeImnsZP74LFTDj3Rqg/Eg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KQznbwPZmNVe2+oT/mwPNvyqx9DTxa7ZQkNNfEbBlpw=; b=ey81ScpwsL3FdYz6z4c7u5hI21
 jEOJ4Cpeg7acWCTaBu2viQotpLJa0lSfbkSeRfGoLAWalnksNP6wIjYmer9NshwQvmfZl5qwfwuL7
 z2cRLsyLlJIXbwboQev0qIyxnXo5/ePVHea8mR4v4KtjvX2TOEBFcJfoH50q6aEY8RiQ=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNtHs-000000002Bv-2n5T for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 14:45:30 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a20bdaf39cso35894545e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 06:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793630722; x=1794235522; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KQznbwPZmNVe2+oT/mwPNvyqx9DTxa7ZQkNNfEbBlpw=;
 b=c/ZYPsnHPSWdauUArNahDtihRAOit7B/CRRvjPFL0tixNL+TKuEt6kU+pIyf6y6389
 kSEVG8+oZUURubSVmzwiledNz7oj8/XoN0OxVnxs6FztCbjhMP03qm+nj/irVMPoIzTf
 F+vR+PshW/1dXzzuD/HWjCvpQV2maiCJ6H7RP/v50vjm0+Bj0bBo6mts3G7kAwFtSppr
 g3J7jGoHceEC+KTbi/1m1gCfrUZiYzL4Ie0CFUJmSQNWVL3XtJrNDogeqVndUF3wBCnH
 DqieLf7Po+53NgZEftLVevngFAyQVDEPs7pwNKvwrZrS6lKF5dqIGJzdwtY621q+Amn1
 3GVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793630722; x=1794235522;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KQznbwPZmNVe2+oT/mwPNvyqx9DTxa7ZQkNNfEbBlpw=;
 b=ahs0uYpxw+jCIe1evQDj6RTStFd6Tdnz8tZEyLEyhdbZCecLVVVhvimJASJISeJvTP
 cdqaWWlJctdGjNxsPTLNcOGjbXh1jfeGEuamfoFJpJ1sL/ZYPOkO8wExOdgjZNuF89/F
 S35qnSCj7P8OAfhfptBgyfQNmQgj2DaSS+OofUZsKYMqCZlFt/B8eNgsUMAD5DXz1uGS
 U/al71yAw8L9xf+aHxlhbCb+hFcns+edc/sfbf0zUuLPF9mLWdHKInLRpBTqMTZ7EA1L
 Wn92xaoZOQjtps0TdfY9ijnHKa7VlFnNOBryt6UV/ioEEhK+ZJ8Ai1TvXDB2yoPbgXgB
 Vvzw==
X-Gm-Message-State: AFq9FYJwZblw356RH+7gCInlW+SBZ57DKT0PlgoSPEZ0dxVYTV+xOTN2
 1fRbjJnAwFPPRX9YMoRiUsEYOZow1A4uH/ENTIz93cub8mtUdxUyxro7ACGs5gMB/EfTeILh8wz
 4plcDwODwfJb3IOP7UnRDXOH63vmpbOPI3+8Up2u0iOeqph7rwjvZiuG+IiuSdoiGBC8s
X-Gm-Gg: AYBFou0N7MQo07GtHsVm7BYrqijVTsJduT1FYNrAKuO6MLQ5eROjGL0e0/01BQzxb3h
 MzDH00eRdiFSQcnWwcQTSeiVSGyKj0iSmXF9tTCl1KkZ6o/Tr2OGYW65wvgNRg0M5gAuyx/JHwl
 0iL3Kz1Pl9s93cMqBvhxUKERTZ2bIWrN4zElC5yIhgKaP20cNiGmvnKu61bB/G8Ui+oZVtba7w/
 xD6cJ7+Zmvvm1RotjhgW0pK+86T/bdEG55JUXElsvgcnnfUyKlD8mNMOoBuiOi+tDd+lj8s1Sk3
 tK77jnZi7aFWBNVkb7kNmWRpyFmHZCuXQRW4loQ2gvFc5ooG94xZyUHxhQ20rvJPdD8DDPq0hr4
 wA7jCBnDMROtB3IMGfcfpr4j73Oc3sY3+WXNGl1X+yDXhiqTzVMK3hn3NS2T5P2CZ4gGa1C69V+
 CtU6n4JOtCmFKJaff1Bhb7vk6PxEBG2qe5TBKQMmveK08XRgRpdoHL4BC1NP26b78dugoKZLbWM
 xxKRgSfaUxooJyu9crrq6itKoX8SL533urxIWfpk96HG140hVUTLHckZH6gP6/0f8IjUKgP9NUg
 oLQoX8njTxenOPpcjokDlkfia/iQf6wgWBpjlKofxdMqMrh2xWU2svzOggaoMGlFE3J8NcyV11T
 P0kdg9DGKjtx8GSwufrD+V1hZcAF5dfP+nQkQL7keFudaYLYQiQimxFmXKx+b7gDhfDha6Ge/BL
 EZvOgfHKhJyt+uuA==
X-Received: by 2002:a05:600c:a00d:b0:4a1:83f0:7c91 with SMTP id
 5b1f17b1804b1-4ac185bc336mr226791735e9.18.1793630721944; 
 Mon, 02 Nov 2026 06:45:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09ad5ff8sm195381955e9.4.2026.11.02.06.45.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 06:45:21 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 14:45:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ie0f902ae5aa8e549f76f2cf32facda43eac18915
X-Gerrit-Change-Number: 2083
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2083?usp=email>
X-Gerrit-Commit: c02263f71f424eadc5299f5c7401fda25fdda817
In-Reply-To: <gerrit.1793618479000.Ie0f902ae5aa8e549f76f2cf32facda43eac18915@gerrit.openvpn.net>
References: <gerrit.1793618479000.Ie0f902ae5aa8e549f76f2cf32facda43eac18915@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4NDc5MDAwLkllMGY5MDJhZTVhYThlNTQ5Zjc2ZjJjZjMyZmFjZGE0M2VhYzE4OTE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3edb64c05d1109abdd49f09755a842efe3ec2767-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNtHs-000000002Bv-2n5T
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tls_crypt: append
 cipher final output at buffer end
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9003214151084980576=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9003214151084980576==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2e20i02UllE="; charset=UTF-8

--2e20i02UllE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Hello Arne S=
chwabe, 

I'd like you to reexamine a change=2E Please visit

    https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2083?usp=3Demail

to look at the new patc=
h set (#2)=2E

The change is no longer submittable: checks~ChecksSubmitRule=
 is unsatisfied now=2E


Change subject: tls_crypt: append cipher final out=
put at buffer end
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

tls_crypt: append cipher final output at buffer end

tls_crypt_wrap() =
and tls_crypt_unwrap() passed BPTR(dst) to
cipher_ctx_final(), which would =
overwrite the start of dst if final
produced output=2E Use BEND(dst), as th=
e tls-crypt-v2 code does=2E
No functional change with AES-256-CTR, whose fi=
nal produces 0 bytes=2E

Change-Id: Ie0f902ae5aa8e549f76f2cf32facda43eac189=
15
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn=
/tls_crypt=2Ec
1 file changed, 2 insertions(+), 2 deletions(-)


  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/83/2083/2

diff --=
git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index 23c7975=
=2E=2Ed015004 100644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_=
crypt=2Ec
@@ -191,7 +191,7 @@
         int outlen =3D 0;
         ASSERT(ci=
pher_ctx_update(ctx->cipher, BEND(dst), &outlen, CBPTR(src), BLEN(src)));
 =
        ASSERT(buf_inc_len(dst, outlen));
-        ASSERT(cipher_ctx_final(=
ctx->cipher, BPTR(dst), &outlen));
+        ASSERT(cipher_ctx_final(ctx->ci=
pher, BEND(dst), &outlen));
         ASSERT(buf_inc_len(dst, outlen));
    =
 }
 
@@ -247,7 +247,7 @@
             CRYPT_ERROR("cipher update failed");
=
         }
         ASSERT(buf_inc_len(dst, outlen));
-        if (!cipher_=
ctx_final(ctx->cipher, BPTR(dst), &outlen))
+        if (!cipher_ctx_final(=
ctx->cipher, BEND(dst), &outlen))
         {
             CRYPT_ERROR("ciph=
er final failed");
         }

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2083?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Ie0f902ae5aa8e549f76f2cf32facda43eac18915
Gerrit-Change-Num=
ber: 2083
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--2e20i02UllE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>R=C4=83zvan Cojocaru =
<strong>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2083?usp=3Demail">View Change</a>=
</p><p>The change is no longer submittable: checks~ChecksSubmitRule is unsa=
tisfied now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">tls_crypt: append cipher final output at bu=
ffer end<br><br>tls_crypt_wrap() and tls_crypt_unwrap() passed BPTR(dst) to=
<br>cipher_ctx_final(), which would overwrite the start of dst if final<br>=
produced output=2E Use BEND(dst), as the tls-crypt-v2 code does=2E<br>No fu=
nctional change with AES-256-CTR, whose final produces 0 bytes=2E<br><br>Ch=
ange-Id: Ie0f902ae5aa8e549f76f2cf32facda43eac18915<br>Signed-off-by: Razvan=
 Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/tls_crypt=
=2Ec<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/83=
/2083/2</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_cr=
ypt=2Ec</span><br><span>index 23c7975=2E=2Ed015004 100644</span><br><span>-=
-- a/src/openvpn/tls_crypt=2Ec</span><br><span>+++ b/src/openvpn/tls_crypt=
=2Ec</span><br><span>@@ -191,7 +191,7 @@</span><br><span>         int outle=
n =3D 0;</span><br><span>         ASSERT(cipher_ctx_update(ctx-&gt;cipher, =
BEND(dst), &amp;outlen, CBPTR(src), BLEN(src)));</span><br><span>         A=
SSERT(buf_inc_len(dst, outlen));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        ASSERT(cipher_ctx_final(ctx-&gt;cipher, BPTR(dst), &amp;=
outlen));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        AS=
SERT(cipher_ctx_final(ctx-&gt;cipher, BEND(dst), &amp;outlen));</span><br><=
span>         ASSERT(buf_inc_len(dst, outlen));</span><br><span>     }</spa=
n><br><span> </span><br><span>@@ -247,7 +247,7 @@</span><br><span>         =
    CRYPT_ERROR(&quot;cipher update failed&quot;);</span><br><span>        =
 }</span><br><span>         ASSERT(buf_inc_len(dst, outlen));</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (!cipher_ctx_final(ctx-&=
gt;cipher, BPTR(dst), &amp;outlen))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (!cipher_ctx_final(ctx-&gt;cipher, BEND(dst), &a=
mp;outlen))</span><br><span>         {</span><br><span>             CRYPT_E=
RROR(&quot;cipher final failed&quot;);</span><br><span>         }</span><br=
></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2083?usp=3Demail">change 2083</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2083?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Ie0f902ae5aa8e549f76f2cf32facda43eac18915=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2083 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>

</body></html>
--2e20i02UllE=--


--===============9003214151084980576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9003214151084980576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9003214151084980576==--

