Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B5C606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=J6vLKt6S;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fiIUqBev;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MK1JCsc0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Q2Pb2Zsu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=MbTxEqc3MIrk8y1MudgPDtUPj2bVoxKUuxTnSyCJVxw=; b=J6vLKt6SAft9wrKGOp19n/E0vv
	Xw1Uf/qxvF1o5pvLYc3oA27a2VWsBr1xakXmznIquhUwfDUNj3Q75PKkfmySe6O5rBmkd5lsl3cFR
	QloxPHJrpsGUvgjYUgki4bNPS/5dtVWc2K90rGxHcl65vkc6LLW6IDWjiTBNLsw1Bz44=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNrJg-000000002wb-1Sv6;
	Mon, 02 Nov 2026 12:39:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNrJf-000000002wU-0Mlf
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:39:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lcbQYkFOCZxPoDlMR2+rPPCeP0RR7RzxhPZPtT9IYt4=; b=fiIUqBevv27ul08Ez8W0am0lad
 tCDi+Zo7/SNUfrtb41wFLMjAv0O2mpwIAl+vIQvD2jJyKr6LDRxzzR1s2X3qdjsv3AsQ3HN1me3om
 RAiBWL5+3/7SewbwYTxqhQ13wIWDWU4bcuP+T2Q3+smy5u4anpI8c2ekjtTLMcubj8Ko=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lcbQYkFOCZxPoDlMR2+rPPCeP0RR7RzxhPZPtT9IYt4=; b=MK1JCsc0Hkt+HqbIuPugHXh40O
 hr4vX9M+vjf/mufLwno2lXanEGlLXmTl+bdgTapJHPCxvqsQk+5Bfxgsvd8zsUkE0+iKwehyIP/ct
 N/XglYC4VObnr/YwCBfEd/dZZFyxZ94SdcU8LD0rYYvIpjkS6+BwjkmoAA5K44CTp8Hw=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNrJe-0000000072i-1iJb for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:39:11 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so18535775e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 04:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793623144; x=1794227944; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lcbQYkFOCZxPoDlMR2+rPPCeP0RR7RzxhPZPtT9IYt4=;
 b=Q2Pb2ZsurFJykPYRKJ/iAEdPRSCWAG84HlcMHtQa2XolsE+9I6PgKed3CY9XHRo88n
 mAUIJhHV3+ge31oOP0BZNLv7O0JlK10JbMYqiUmzJ7bjjS60pgzlUH+AawFFHUrqDIzN
 N965QghV1Kbn8IpoRm3PRIcmRQnmTrxL3DbE5cUiwSM/SDGYuTrpYaF0NaPI2C27PrSy
 WstWuOjKP2JWFB52Ox9AjqssNLH6f80chphVi5wTG9KPIgX0VOr4645/S54xm83K31O4
 +rkI7SjadwKxB8ISRB7KDK5WntUN8WyTb4CR51F6LTkMEt7aSiRLzuc1reG/k12+xtaQ
 dcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793623144; x=1794227944;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lcbQYkFOCZxPoDlMR2+rPPCeP0RR7RzxhPZPtT9IYt4=;
 b=mhI6M6wSemrEeJnyWxF9ddMfDM/jEMWPhQ4ez028yrXLoX+sKTAeF0f9eGTTHjrYeS
 uBKuh8iQVKUNf0IM6zh+bl64D2L4ruZMcB1/Vgnl4D91X0+EdIlQCxgzXRlVmpteLtlH
 8420Ltr15/dD2JR1UlboxdjjfK1bmbGoJ6fsSDB47QFhrlvFi4nh4uqxRNSgopOyqOpt
 FZ4QPgUgrduox23+CKf2QY6a7pvIpFvOQNZVIFoTXlpqMsLusUKf46HQ+T+bG7q+gzL8
 mRoN5NHYXTxszJJm/iyqBCwM1dQXEylV9PcK5n2cyB0OTTR3kRNjBqyfDc3Cvxv+3uXX
 yccg==
X-Gm-Message-State: AFq9FYIKlKTAB71HL1aSrc04FB0AbLmXug/441fXGi3ZfMDUkIiCFX9V
 pFRhCvk4huzbxp0dfeVrO5uwrwf2iyc2eRuI4+0I/fuaYCGUJlW5mIUqtNOYc4p6xcazifHWJtl
 ze9pZLoFJ9xgPaDUCFxlFYiYONI/TBeToAwzzxMrM8HzPrR/mTGM5lbpF8GgsxBetByzrzLLkUN
 mcsFZipQ==
X-Gm-Gg: AYBFou1EZj1Km6g8HolAOsKScAiQ/BnEJ3o28audI/ERRa9lzi/HCFyr1tx+5E++AdV
 P597/mosvZ+9neV14U5AJO9j5GwSRDY6bYRLfrA0srVBsp1xTTwTv/frLBkKbmI/M6bPfcHOn1u
 vLgQFwsREg20mEpTOmDl4HdCfVdqqMMbLzJcm5nJPQCZDiGPp+WrEHI9QrDJvMd1DAmKDS2y/Ih
 bulUGesth2xCpeXsjBCWuTFjqEueMiVzVYajBEY8fAGlbyXzyOr+SkA8dSdt+fASdcDXTreBHDH
 4beG8mEFff+0CjDCyAsDZiKmNJnXzlsDUjY0roEAVcjX6B8lWyGaI10jt2H3w1SVhHSfchY7hv1
 L1owzaFHH0lCD/Pz7T3rPDeFa8UToicqjlmzIuC0fknRAi4Yhw73nYd+neb0oVaEOb4rMx34rPz
 SDLe0/+s1DaSxZnsgzCSio2KeXTgGx9Y/9Hg7t4H0jwGbIfW8wvYGhKLim0vUGh/FUbeCHxPCsf
 jkeNsDhtTZ8megqLkKkBAA6qoOad6d8D0hyGaMOtaFQRdZngw1YmBYX5cgFNnyvjv2pxFLzNvG4
 If6Ja71obCiuu0/mYJ1+WQvMvv2755n21D85+Ya+Vh8lYYeAst0ECtQBscL57Cor+8+QVSLHzfy
 tXtzBMM5AfjmvgDr1vac3GO5QBeKpA8k4GdCT3yV4EYlKFcSUIyg0aRenGE25DrD300TmSku+qW
 QTjpofF0xLdaCc4g==
X-Received: by 2002:a05:600c:6212:b0:4b0:a7aa:843 with SMTP id
 5b1f17b1804b1-4b0a7aa0a54mr70102755e9.25.1793623143672; 
 Mon, 02 Nov 2026 04:39:03 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abe7700c3bsm248012675e9.0.2026.11.02.04.39.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 04:39:03 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 12:39:02 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id6587b3d44d3326cae83c460cd85e8570ee8666a
X-Gerrit-Change-Number: 2089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2089?usp=email>
X-Gerrit-Commit: ca739b2af0d0df61b9940e08c82052a5035582e6
References: <gerrit.1793623141000.Id6587b3d44d3326cae83c460cd85e8570ee8666a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjIzMTQxMDAwLklkNjU4N2IzZDQ0ZDMzMjZjYWU4M2M0NjBjZDg1ZTg1NzBlZTg2NjZhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f9e7d2ad39591343c190b43f61149ab2ad636ef7-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNrJe-0000000072i-1iJb
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto: assert opt
 before first use in openvpn_decrypt_aead()
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
Content-Type: multipart/mixed; boundary="===============1848182405098794132=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1848182405098794132==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4KWiQuJj9Ec="; charset=UTF-8

--4KWiQuJj9Ec=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2089?usp=3Demail

to review the following change=2E
=


Change subject: crypto: assert opt before first use in openvpn_decrypt_ae=
ad()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

crypto:=
 assert opt before first use in openvpn_decrypt_aead()

opt was dereference=
d before ASSERT(opt)=2E Move the assertion up=2E

Change-Id: Id6587b3d44d33=
26cae83c460cd85e8570ee8666a
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
---
M src/openvpn/crypto=2Ec
1 file changed, 1 insertion(+), 1 dele=
tion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/89/2089/1

diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
=
index 3d3ab0c=2E=2E498c327 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/op=
envpn/crypto=2Ec
@@ -440,6 +440,7 @@
     struct gc_arena gc;
     gc_init(=
&gc);
 
+    ASSERT(opt);
     struct key_ctx *ctx =3D &opt->key_ctx_bi=2Ed=
ecrypt;
     const bool use_epoch_data_format =3D opt->flags & CO_EPOCH_DAT=
A_KEY_FORMAT;
     if (!use_epoch_data_format && cipher_decrypt_verify_fail=
_exceeded(ctx))
@@ -450,7 +451,6 @@
     const int tag_size =3D OPENVPN_AEA=
D_TAG_LENGTH;
 
 
-    ASSERT(opt);
     ASSERT(frame);
     ASSERT(buf->le=
n > 0);
     ASSERT(ctx->cipher);

-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2089?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: Id6587b3d44d3326cae83c460cd85e8570ee8666a
Gerrit-Change-Nu=
mber: 2089
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--4KWiQuJj9Ec=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2089?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">crypto: assert opt before first use in openvpn_decrypt_=
aead()<br><br>opt was dereferenced before ASSERT(opt)=2E Move the assertion=
 up=2E<br><br>Change-Id: Id6587b3d44d3326cae83c460cd85e8570ee8666a<br>Signe=
d-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/ope=
nvpn/crypto=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/89/2089/1</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/=
crypto=2Ec</span><br><span>index 3d3ab0c=2E=2E498c327 100644</span><br><spa=
n>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec=
</span><br><span>@@ -440,6 +440,7 @@</span><br><span>     struct gc_arena g=
c;</span><br><span>     gc_init(&amp;gc);</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(opt);</span><br><span>  =
   struct key_ctx *ctx =3D &amp;opt-&gt;key_ctx_bi=2Edecrypt;</span><br><sp=
an>     const bool use_epoch_data_format =3D opt-&gt;flags &amp; CO_EPOCH_D=
ATA_KEY_FORMAT;</span><br><span>     if (!use_epoch_data_format &amp;&amp; =
cipher_decrypt_verify_fail_exceeded(ctx))</span><br><span>@@ -450,7 +451,6 =
@@</span><br><span>     const int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;</sp=
an><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    ASSERT(opt);</span><br><span>     ASSERT(frame);</span><br><=
span>     ASSERT(buf-&gt;len &gt; 0);</span><br><span>     ASSERT(ctx-&gt;c=
ipher);</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2089?usp=3Demail">change 2089</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2089?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: Id6587b3d44d3326cae83c460=
cd85e8570ee8666a </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2089 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--4KWiQuJj9Ec=--


--===============1848182405098794132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1848182405098794132==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1848182405098794132==--

